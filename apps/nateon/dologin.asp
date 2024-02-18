<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%Response.Addheader "P3P","policyref='/w3c/p3p.xml', CP='NOI DSP LAW NID PSA ADM OUR IND NAV COM'"%>
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
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbHelper.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/memberlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/membercls/userloginclass.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/apps/nateon/lib/nateon_alarmClass.asp"-->
<%
dim ouser
dim userid, userpass
dim isupche

userid 		= requestCheckVar(request("userid"),32)
userpass 	= requestCheckVar(request("userpass"),32)

set ouser = new CTenUser
ouser.FRectUserID = userid
ouser.FRectPassWord = userpass
ouser.LoginProc

if (ouser.IsPassOk) then	
	'// 네이트온 알리미 연동 페이지로 이동(파라메터 암호화)
	dim ticket, ticketVal
	Set ticket = New CoTicket
	ticket("unique_key") = userid
	ticket("userid") = userid
	ticketVal = ticket.GetTicket(tenEncKey, 120)		'암호키 설정
	Set ticket = Nothing

	Response.Redirect("http://nateonalarm.nate.com/interface/user_connect.php?service_id=30&value="&ticketVal)
elseif (ouser.IsRequireUsingSite) then
	set ouser = Nothing
    response.write "<script>var ret = confirm('사용 중지하신 서비스 입니다. \n텐바이텐 쇼핑몰을 이용하시려면 핑거스 My Fingers에서 \n이용사이트 설정을 수정하시면 텐바이텐 서비스를 바로 이용하실 수 있습니다.'); if (ret) { var popwin=window.open('http://thefingers.co.kr/myfingers/membermodify.asp','_blank',''); popwin.focus(); } </script>"
    response.write "<script>history.back();</script>"
else	
	set ouser = Nothing
	response.write "<script>alert('아이디 또는 비밀번호 오류입니다.');</script>"
	response.write "<script>history.back();</script>"
end if
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->