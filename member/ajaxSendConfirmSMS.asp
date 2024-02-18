<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"

'// 유효 접근 주소 검사 //
dim refer
refer = request.ServerVariables("HTTP_REFERER")
if InStr(refer,"10x10.co.kr")<1 then
	response.write "<script type='text/javascript'>alert('유효하지 못한 접근입니다.');fnLyrClose();</script>'"	'--유효하지 못한 접근
	dbget.close(): response.End
end if

' -------------------------------------------------
'  아이디를 받아 유효한 정보인지 확인 후 SMS 발송
' -------------------------------------------------
dim txUserId, txUserHP, chkStat, joinDt, sqlStr
dim sRndKey

	txUserId = requestCheckVar(Request.form("id"),32)	' 사용자 아이디 입력 받음

	If txUserId="" Then 
		response.write "<script type='text/javascript'>alert('잘못된 접근입니다.');fnLyrClose();</script>'"
		dbget.close(): response.End
	end if

	'// 회원 여부 확인
	sqlStr = "Select usercell, userStat, regdate From db_user.dbo.tbl_user_n Where userid='" & txUserid & "'"
	rsget.Open sqlStr,dbget,1
	if Not(rsget.EOF or rsget.BOF) then
		txUserHP = rsget("usercell")
		chkStat = rsget("userStat")
		joinDt = rsget("regdate")
	end if
	rsget.close

	if txUserHP="" or (chkStat="N" and datediff("h",joinDt,now())>12) then
		'# 회원정보 없음(또는 유효기간 종료 고객)
		response.write "<script type='text/javascript'>alert('회원 정보가 존재하지 않습니다.');fnLyrClose();</script>'"
		dbget.close(): response.End
	elseif (chkStat="Y" and datediff("h",joinDt,now())<=12) then
		'# 이미 가입 처리 완료
		response.write "<script type='text/javascript'>alert('감사합니다.\n이미 본인인증을 받으셨습니다.\n\n메인으로 이동합니다.');location.href='" & wwwUrl & "/';</script>"
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
		sqlStr = " exec [db_sms].[dbo].[usp_SendSMS] '" & txUserHP & "','1644-6030','인증번호 [" & sRndKey & "]"& vbCrLf & "입력창에 넣으시면 진행이 완료됩니다. -텐바이텐'"
		dbget.execute(sqlStr)
	end if
%>
<script type="text/javascript">
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
		url: "ajaxCheckConfirmSMS.asp",
		data: "id=<%=txUserId%>&chkFlag=N&key="+frm.crtfyNo.value,
		dataType: "text",
		async: false
	}).responseText;

	if (rstStr == "1"){
		$("#smsRstMsg").html("인증이 완료되었습니다.");
		<%
			if chkStat="N" then
				'신규가입 승인시
				Response.Write "location.replace('/member/join_welcome.asp');"
			else
				'기존회원 승인시
				Response.Write "location.replace('/my10x10/userinfo/membermodify.asp');"
			end if
		%>
	}else if (rstStr == "2"){
		$("#smsRstMsg").html("인증번호가 정확하지 않습니다.");
	}else{
		$("#smsRstMsg").html("인증번호를 입력해주세요.");
		alert("처리중 오류가 발생했습니다."+rstStr);
	}

 }
 
 function fnLyrClose() {
 	$('.window').fadeOut();
 }
</script>
<div class="popTop pngFix"><div class="pngFix"></div></div>
<div class="popContWrap pngFix">
	<div class="popCont pngFix">
		<div class="popHead">
			<h2><img src="http://fiximage.10x10.co.kr/web2013/member/tit_pop_phone.gif" alt="휴대폰 인증하기" /></h2>
			<p class="lyrClose" onclick="fnLyrClose()"><img src="http://fiximage.10x10.co.kr/web2013/common/btn_pop_close.gif" alt="닫기" /></p>
		</div>
		<div class="popBody ct">
			<div class="certCont">
				<p class="result"><strong><span class="crRed"><%=txUserHP%></span>로<br />휴대폰 인증번호를 발송하였습니다.</strong></p>
				<p class="certNum">
				<form name="cnfSMSForm" action="" onsubmit="return false;">
					<label for="certNum"><strong>인증번호</strong></label> 
					<span class="lMar10"><input type="text" class="txtInp offInput" name="crtfyNo" id="certNum" maxlength="6" style="text-align:center;" /></span>
					<span class="btn btnS1 btnGry" onclick="fnConfirmSMS()">인증번호 확인</span>
				</form>
				</p>
				<p id="smsRstMsg" class="cmt cr6aa7cc"><strong>인증번호를 입력해주세요.</strong></p>
				<p class="help">인증번호가 도착하지 않으면 스팸문자함 또는 차단설정을 확인해주세요.</p>
				<div class="btnArea ct tMar20">
					<span class="btn btnS1 btnRed btnW80 fs12" onclick="fnConfirmSMS()">확인</span>
					<span class="btn btnS1 btnGry2 btnW80 fs12" onclick="fnLyrClose()">취소</span>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->