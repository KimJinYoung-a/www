<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/md5.asp" -->
<%

''response.write "This page : gate.asp" &"<br>"
Dim REMOTE_ADDR : REMOTE_ADDR = Request.ServerVariables("REMOTE_ADDR")
Dim HTTP_REFERER : HTTP_REFERER = Request.ServerVariables("HTTP_REFERER")

Dim pin_no : pin_no=Trim(request("pin_no"))
Dim encKey : encKey=Trim(request("encKey"))


response.write "HTTP_REFERER:" &HTTP_REFERER&"<br>"
response.write "REMOTE_ADDR:" &REMOTE_ADDR&"<br><br>"
response.write "pin_no:" &pin_no&"<br>"
response.write "encKey:" &encKey&"<br><br>"

Dim buf : buf = Right(pin_no,7)+Left(pin_no,7)

response.write "Right(pin_no,7)+Left(pin_no,7):" &buf&"<br>"
response.write "MD5(Right(pin_no,7)+Left(pin_no,7)):" &MD5(buf)&"<br>"
%>