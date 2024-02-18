<%@  codepage="65001" language="VBScript" %>
<% option explicit %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"

response.Charset = "utf-8"
%>
<!-- #include virtual="/login/checkPopUserGuestLogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbHelper.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<%
Dim sqlStr, userid, backurl
dim rebankname, rebankaccount, rebankownername

backurl     = request.ServerVariables("HTTP_REFERER")
userid          = getEncLoginUserID()

if (userid<>"") then
    sqlStr = "exec [db_cs].[dbo].[usp_WWW_AutoCancel_RefundInfo_Set] '" & userid & "','" & request.form("rebankname") & "','" & replace(request.form("encaccount"),"-","") & "','" & request.form("rebankownername") &"'"
    dbget.Execute sqlStr
end if
%>
<script>
    opener.location.href = opener.document.URL;
    self.opener = self;
    self.close();
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->
