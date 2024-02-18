<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
'#######################################################
'	Description : 아이디/비밀번호 찾기
'	History	:  2013.02.12 허진원 - 실명인증 없는 방법
'              2013.07.30 허진원 - 2013리뉴얼
'              2016.06.27 허진원 - pingInfo 사용할때만 ajax로 가져오도록 수정
'#######################################################
%>

<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/member/iPin/nice.nuguya.oivs.asp" -->
<%
	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : 아이디/비밀번호 찾기"		'페이지 타이틀 (필수)
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<%
	Dim C_dumiKey
	Dim retUrl
	C_dumiKey = session.sessionid
	
	
	'///이미 본인 인증된 상태라면 리턴시킨다.
	retUrl = request("returnUrl")
	response.write session("isAdult") & " , " & retUrl
	if session("isAdult") = True and retUrl <> "" then 
		Response.redirect retUrl
	end if

	'####### 본인인증(아이핀) 사용여부 ("N"으로하면 본인인증 없이 패스~) #######
	Dim rnflag
	rnflag	= "Y"

	'#######################################################################################
	'#####	개인인증키(대체인증키;아이핀) 서비스				한국신용정보(주)
	'#######################################################################################
	Dim NiceId, SIKey, ReturnURL, pingInfo, strOrderNo
	'// 텐바이텐
	NiceId = "Ntenxten4"		'// 회원사 ID
	SIKey = "N0001N013276"		'// 사이트식별번호 12자리

	ReturnURL = SSLUrl & "/member/popCheckIDPWiPin.asp"	'// 한국신용정보(주)로 부터 서비스처리 결과를 전달 받아 처리할 페이지
' js Ajax 처리로 서버단 통신은 제거
'	On Error Resume Next
'		pingInfo = getPingInfo()
'		If Err.Number>0 Then
'	        rnflag="N"
'		end if
'	on error Goto 0

	randomize(time())
	strOrderNo = Replace(date, "-", "")  & round(rnd*(999999999999-100000000000)+100000000000)

	'// 해킹방지를 위해 요청정보를 세션에 저장
	session("niceOrderNo") = strOrderNo
%>
		<form name="reqMobiForm" method="post" action="">
			
		</form>
		
<script>		
// 패스워드 찾기(모바일본인인증)
	function jsOpenCert() {
		var popupWindow = window.open( "", "KMCISWindow", "width=425, height=550, resizable=0, scrollbars=no, status=0, titlebar=0, toolbar=0, left=435, top=250" );
		document.reqMobiForm.action = 'popCheckWhoAmI.asp';
		document.reqMobiForm.target = "KMCISWindow";
		document.reqMobiForm.submit();
		popupWindow.focus();
	}
</script>
<%=application("Svr_Info")%>	
<Input Type="button" value="확인" onclick=jsOpenCert() />
<!-- #include virtual="/lib/db/dbclose.asp" -->