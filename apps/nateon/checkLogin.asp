<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"

'#######################################################
'	History	:  2009.06.16 허진원 생성
'	Description : 네이트온 알리미 연동전용 로그인 처리
'#######################################################

response.end  ''2017/04/20
%>
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/apps/nateon/lib/nateon_alarmClass.asp"-->
<%
	'// 텐바이텐 로그인 확인
	if (Not IsUserLoginOK) then
		dim checklogin_backpath
	  	dim strBackPath	
	   	strBackPath 	= "/apps/nateon/checkLogin.asp"		'로그인후 본페이지로 다시 복귀
	   
	    checklogin_backpath = "backpath="+ server.URLEncode(strBackPath) + "&isopenerreload=on"
		response.redirect "/login/poploginpage.asp?" + checklogin_backpath
	    response.end
	end if

	'// 네이트온 로그인 페이지 호출
	dim ticket, ticketVal
	Set ticket = New CoTicket
	ticket("unique_key") = GetLoginUserID
	ticket("userid") = GetLoginUserID
	ticketVal = ticket.GetTicket(tenEncKey, 120)		'암호키 설정
	Set ticket = Nothing

	Response.Redirect("http://nateonweb.nate.com/login/alarm/login_auth.php?service_id=30&value="&ticketVal)
%>

