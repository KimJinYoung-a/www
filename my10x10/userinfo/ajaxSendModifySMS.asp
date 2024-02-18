<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/classes/ordercls/smscls.asp" -->
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
'  아이디를 받아 유효한 정보인지 확인 후 SMS 발송
' -------------------------------------------------
dim txUserId, txUserHP, chkStat, joinDt, sqlStr
dim sRndKey

	txUserId = requestCheckVar(Request.form("id"),32)		' 사용자 아이디 입력 받음
	txUserHP = requestCheckVar(Request.form("phone"),18)	' 사용자 휴대폰 입력 받음

	If txUserId="" or txUserHP="" Then
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

	'# 유효 인증 대기값이 있는지 확인(100초 이내 / 확인은 120초까지 유효)
	sqlStr = "Select top 1 smsCD From db_log.dbo.tbl_userConfirm Where userid='" & txUserid & "' and confDiv='S' and isConfirm='N' and datediff(s,regdate,getdate())<=120 order by idx desc "
	rsget.Open sqlStr,dbget,1
	if Not(rsget.EOF or rsget.BOF) then
		sRndKey = rsget("smsCD")
	end if
	rsget.close

	if sRndKey<>"" then
		'// 2분 이내에는 재발송 없음(SPAM 등에 걸리지 않는 이상 거의 대부분 늦게라도 전송됨)
	else
		'//신규발송

		'# sRndKey값 생성
		randomize(time())
		sRndKey=Num2Str(left(round(rnd*(1000000)),6),6,"0","R")

		'# 인증 로그에 저장
		sqlStr = "insert into db_log.dbo.tbl_userConfirm (userid, confDiv, usercell, smsCD, pFlag, evtFlag) values ("
		sqlStr = sqlStr + " '" & txuserid & "'"
		sqlStr = sqlStr + " ,'S'"
		sqlStr = sqlStr + " ,'" & txUserHP & "'"
		sqlStr = sqlStr + " ,'" & sRndKey & "'"
		sqlStr = sqlStr + " ,'T','N'"
		sqlStr = sqlStr + " )"
		dbget.execute(sqlStr)

		'# 인증 SMS 발송
		'sqlStr = "Insert into [db_sms].[ismsuser].em_tran(tran_phone, tran_callback, tran_status, tran_date, tran_msg ) values " &_
		'		" ('" & txUserHP & "'" &_
		'		" ,'1644-6030','1',getdate()" &_
		'		" ,'인증번호 [" & sRndKey & "]"& vbCrLf & "입력창에 넣으시면 진행이 완료됩니다. -텐바이텐')"
		
		''2015/08/16 수정
		'sqlStr = " exec [db_sms].[dbo].[usp_SendSMS] '" & txUserHP & "','1644-6030','인증번호 [" & sRndKey & "]"& vbCrLf & "입력창에 넣으시면 진행이 완료됩니다. -텐바이텐'"
		'dbget.execute(sqlStr)

		''2018/01/22 수정; 허진원 카카오 알림톡으로 전송
		Call SendKakaoMsg_LINK(txUserHP,"1644-6030","S0001","[텐바이텐] 고객님의 인증번호는 [" & sRndKey & "]입니다.","SMS","","인증번호 [" & sRndKey & "]"& vbCrLf & "입력창에 넣으시면 진행이 완료됩니다. -텐바이텐","")
	end if
%>
<script type="text/javascript">
 // 발송 팝업 레이어 띄움
 $(function(){
	 $('#certPhoneLyr').fadeIn().css({
		 left: ($(window).width() - $('#certPhoneLyr').outerWidth())/2,
		 top: (($(window).height() - $('#certPhoneLyr').outerHeight())/3) + $(window).scrollTop()
	 });
 });

 //인증 처리
 function fnConfirmSMS() {
 	var frm = document.cnfSMSForm;
 	if(frm.crtfyNo.value.length<6) {
 		alert("휴대폰으로 받으신 인증번호를 정확히 입력해주세요.");
 		frm.crtfyNo.focus();
 		return;
 	}

	var rstStr = $.ajax({
		type: "POST",
		url: "/member/ajaxCheckConfirmSMS.asp",
		data: "id=<%=txUserId%>&key="+frm.crtfyNo.value,
		dataType: "text",
		async: false
	}).responseText;

	if (rstStr == "1"){
		$("#smsRstMsg").attr("class","cmt cr6aa7cc");
		$("#smsRstMsg").html("인증이 완료되었습니다.")
		//페이지 새로고침
		history.go(0);
	}else if (rstStr == "2"){
		$("#smsRstMsg").attr("class","cmt crRed");
		$("#smsRstMsg").html("인증번호가 정확하지 않습니다.")
	}else{
		$("#smsRstMsg").attr("class","cmt cr6aa7cc");
		$("#smsRstMsg").html("인증번호를 입력해주세요.")
		alert("처리중 오류가 발생했습니다."+rstStr);
	}

 }
  $('#close').click(function(){
 	 	$('#certPhoneLyr').fadeOut()

});
 $('#cancel').click(function(){
 	 	$('#certPhoneLyr').fadeOut()

});
</script>
	<div id="certPhoneLyr" class="window certLyr" style="display:none;position:absolute;z-index:10;text-align:center;width:505px;height:456px;">
		<div class="popTop pngFix"><div class="pngFix"></div>
		<div class="popContWrap pngFix">
			<form name="cnfSMSForm" action="" onsubmit="return false;">
			<div class="popCont pngFix">
				<div class="popHead">
					<h2><img src="http://fiximage.10x10.co.kr/web2013/member/tit_pop_phone.gif" alt="휴대폰 인증하기" /></h2>
					<p class="lyrClose"><img id="close" src="http://fiximage.10x10.co.kr/web2013/common/btn_pop_close.gif" alt="닫기" /></p>
				</div>
				<div class="popBody ct">
					<div class="certCont">
						<p class="result"><strong><span class="crRed"><%=txUserHP%></span>로<br />휴대폰 인증번호를 발송하였습니다.</strong></p>
						<p class="certNum">
							<label for="certNum"><strong>인증번호</strong></label>
							<span class="lMar10"><input type="text" name="crtfyNo" maxlength="6" class="txtInp offInput" id="certNum" /></span>
							<a href="javascript:fnConfirmSMS();" class="btn btnS1 btnGry">인증번호 확인</a>
						</p>
						<p id="smsRstMsg" class="cmt cr6aa7cc"><strong>인증번호를 입력해주세요.</strong></p>
						<p class="help">인증번호가 도착하지 않으면 스팸문자함 또는 차단설정을 확인해주세요.</p>
						<div class="btnArea ct tMar20">
							<a href="javascript:fnConfirmSMS();" class="btn btnS1 btnRed btnW80 fs12">확인</a>
							<span id="cancel" class="btn btnS1 btnGry2 btnW80 fs12">취소</span>
						</div>
					</div>
				</div>
			</div>
			</form>
		</div>
	</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->