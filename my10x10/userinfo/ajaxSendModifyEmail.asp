<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/tenEncUtil.asp" -->
<!-- #include virtual="/lib/email/maillib.asp" -->
<!-- #INCLUDE Virtual="/lib/email/maillib2.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"

'// 유효 접근 주소 검사 //
dim refer
refer = request.ServerVariables("HTTP_REFERER")
if InStr(refer,"10x10.co.kr")<1 then
	response.write "<script type='text/javascript'>alert('유효하지 못한 접근입니다.');</script>'"	'--유효하지 못한 접근
	dbget.close(): response.End
end if

' -------------------------------------------------
'  아이디를 받아 유효한 정보인지 확인 후 메일 발송
' -------------------------------------------------
dim txUserId, txUsermail, chkStat, joinDt, CnfIdx, CnfDate, sqlStr
dim sRUrl, dExp

	txUserId = requestCheckVar(Request.form("id"),32)		' 사용자 아이디 입력 받음
	txUsermail = requestCheckVar(Request.form("mail"),128)	' 사용자 이메일 입력 받음

	If txUserId="" Then
		response.write "<script type='text/javascript'>alert('잘못된 접근입니다.');</script>'"
		dbget.close(): response.End
	end if

	'// 회원 여부 확인
	sqlStr = "Select userStat, regdate From db_user.dbo.tbl_user_n Where userid='" & txUserid & "'"
	rsget.Open sqlStr,dbget,1
	if Not(rsget.EOF or rsget.BOF) then
		chkStat = rsget("userStat")
		joinDt = rsget("regdate")
	end if
	rsget.close

	if joinDt="" or (chkStat="N" and datediff("h",joinDt,now())>12) then
		'# 회원정보 없음(또는 유효기간 종료 고객)
		response.write "<script type='text/javascript'>alert('회원 정보가 존재하지 않습니다.');</script>'"
		dbget.close(): response.End
	end if

	'# 연속발송 제한 확인 (6시간동안 5회까지만 허용;이메일,휴대폰 총발송수)
	Dim chkSendCnt
	sqlStr = "Select count(*) From db_log.dbo.tbl_userConfirm Where userid='" & txUserid & "' and datediff(hh,regdate,getdate())<6 "
	rsget.Open sqlStr,dbget,1
	if Not(rsget.EOF or rsget.BOF) then
		chkSendCnt = rsget(0)
	end if
	rsget.close

	if chkSendCnt>5 then
		response.write "<script type='text/javascript'>alert('단기간에 많은 인증요청으로 더이상 인증을 할 수 없습니다.\n잠시 후 다시 시도해주세요.');</script>'"
		dbget.close(): response.End
	end if

	'# 유효 인증 대기값이 있는지 확인
	sqlStr = "Select top 1 idx, regdate From db_log.dbo.tbl_userConfirm Where userid='" & txUserid & "' and confDiv='E' and isConfirm='N' and datediff(hh,regdate,getdate())<12 order by idx desc "
	rsget.Open sqlStr,dbget,1
	if Not(rsget.EOF or rsget.BOF) then
		CnfIdx = rsget("idx")
		CnfDate = rsget("regdate")
	end if
	rsget.close

	if CnfIdx<>"" then
		'// 재발송

		'# 인증확인 URL
		sRUrl = wwwUrl & "/my10x10/userInfo/doEmailConfirm.asp?strkey=" & server.URLEncode(tenEnc(txuserid & "||" & CnfIdx))
		'# 인증 종료일
		dExp = cStr(dateadd("h",12,CnfDate))
		'# 인증 메일 발송
		Call SendMailReConfirm(txUsermail,txuserid,dExp,sRUrl)
	else
		'//신규발송
		'# 인증 로그에 저장
		On Error Resume Next
		dbget.beginTrans

		sqlStr = "insert into db_log.dbo.tbl_userConfirm (userid, confDiv, usermail, pFlag, evtFlag) values ("
		sqlStr = sqlStr + " '" & txuserid & "'"
		sqlStr = sqlStr + " ,'E'"
		sqlStr = sqlStr + " ,'" & txUsermail & "'"
		sqlStr = sqlStr + " ,'T','N'"
		sqlStr = sqlStr + " )"
		dbget.execute(sqlStr)

		sqlStr = "Select IDENT_CURRENT('db_log.dbo.tbl_userConfirm') as maxIdx "
		rsget.Open sqlStr,dbget,1
			CnfIdx = rsget("maxIdx")
		rsget.close

		If Err.Number = 0 Then
		        '// 처리 완료
		        dbget.CommitTrans
		Else
		        '//오류가 발생했으므로 롤백
		        dbget.RollBackTrans
				response.write "<script type='text/javascript'>alert('처리중 오류가 발생했습니다.');</script>'"
				dbget.close(): response.End
		End If
		on error Goto 0

		'# 인증확인 URL
		sRUrl = wwwUrl & "/my10x10/userInfo/doEmailConfirm.asp?strkey=" & server.URLEncode(tenEnc(txuserid & "||" & CnfIdx))
		'# 인증 종료일
		dExp = cStr(dateadd("h",12,now()))
		'# 인증 메일 발송
		Call SendMailReConfirm(txUsermail,txuserid,dExp,sRUrl)
	end if
%>
<script type="text/javascript">
 // 발송 팝업 레이어 띄움
 $('#certMailLyr').fadeIn().css({
	 left: ($(window).width() - $('#certMailLyr').outerWidth())/2,
	 top: ($(window).height() - $('#certMailLyr').outerHeight())/3 + $(window).scrollTop()
 });
 $('#close').click(function(){
 	 	$('#certMailLyr').fadeOut()

});
 $('#comfirm').click(function(){
 	 	$('#certMailLyr').fadeOut()

});
</script>
	<div id="certMailLyr" class="window certLyr" style="display:none;position:absolute;z-index:10;text-align:center;width:496px;height:406px;">
		<div class="popTop pngFix"><div class="pngFix"></div>
		<div class="popContWrap pngFix">
			<div class="popCont pngFix">
				<div class="popHead">
					<h2><img src="http://fiximage.10x10.co.kr/web2013/member/tit_pop_mail.gif" alt="이메일 인증하기" /></h2>
					<p class="lyrClose"><img src="http://fiximage.10x10.co.kr/web2013/common/btn_pop_close.gif" id="close" alt="닫기" /></p>
				</div>
				<div class="popBody ct">
					<div class="certCont">
						<p class="result"><strong><span class="crRed"><%=txUsermail%></span>로<br />휴대폰 인증번호를 발송하였습니다.</strong></p>
						<div>
							<p class="cmt crRed">인증 이메일을 12시간 안에 확인해주세요.</p>
							<p class="help lt">가입승인 시간 내에 승인을 하지 않으시면 인증이 취소됩니다.<br />인증메일이 도착하지 않았을 경우 팝업창을 닫고 '사용자 인증하기' 버튼을<br /> 클릭하시면 다시 메일을 받으실 수 있습니다.</p>
						</div>
						<div class="btnArea ct tMar20">
							<span id="comfirm" class="btn btnS1 btnRed btnW80 fs12">확인</span>
					<!--	<a href="#" class="btn btnS1 btnGry2 btnW80 fs12">취소</a>	-->
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->