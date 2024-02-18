<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/db/dbCTopen.asp" -->
<%
'#######################################################
'	History	: 2017.10.30 원승현 생성
'	Description : appBoy RestAPI
'#######################################################

Dim userid

'On Error Resume Next

'// 유저 기본 정보를 업데이트 한다.
Dim appBoyUserAttributes
appBoyUserAttributes = "{""external_id"":""38706282"",""email"":""thensi7@10x10.co.kr"",""dob"":""1981-11-24"",gender:""M"",push_subscribe:""opted_in"",firstLoginDate:""2014-04-01T16:30:44.880+09:00"",lastLoginDate:""2017-10-31T13:01:09.127+09:00""}"
'appBoyUserAttributes = appBoyUserAttributes & ",basketItems:[""22222223""]"

'response.write appBoyUserAttributes
'response.End

%>
<html>
<head>
	<title>adfasf</title>
</head>
<%
	Dim oXML
'	set oXML = Server.CreateObject("Msxml2.ServerXMLHTTP.3.0")	'xmlHTTP컨퍼넌트 선언
'	oXML.open "POST", "https://api.appboy.com/users/export/ids", false
'	oXML.setRequestHeader "Content-Type", "application/json; charset=utf-8"
'	oXML.setRequestHeader "CharSet", "utf-8" '있어도 되고 없어도 되고
'	oXML.setRequestHeader "Accept","application/json"
'	oXML.send "{""app_group_id"":""9dca85e3-8cf2-406a-a98b-d2cba7d2d3df"",""external_ids"":[""38706282""]}"	'바디 전송

'	response.write oXML.responseText

	Set oXML = Server.CreateObject("Microsoft.XMLHTTP")
	oXML.open "POST", "http://wapi.10x10.co.kr/appBoy/AppBoyUserInfoSend.asp", False
	oXML.setRequestHeader "Content-Type","application/x-www-form-urlencoded"
	oXML.send "userid=thensi7&mode=signUp&action=signUp&platform=pc"

	response.write oXML.responseText

	Set oXML = Nothing


%>
<!--a href="" onclick="appboytestfn();return false;">adf</a-->

</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->
<!-- #include virtual="/lib/db/dbCTclose.asp" -->