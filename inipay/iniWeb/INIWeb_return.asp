<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/inipay/iniWeb/INIWeb_Util.asp" -->
<!-- #include virtual="/inipay/iniWeb/aspJSON1.17.asp" -->
<%
''INIWeb_return.asp
dim i, k

'for each i in request.form
'	response.write i & " => " & request.form(i) & "<br/>"
'next

dim resultCode : resultCode = request.form("resultCode")
dim resultMsg : resultMsg = request.form("resultMsg")

dim authUrl : authUrl = request.form("authUrl")
dim authToken : authToken = request.form("authToken")

dim netCancelUrl : netCancelUrl = request.form("netCancelUrl")

dim orderNumber : orderNumber = Trim(request.form("orderNumber"))  ''2018/01/04
dim merchantData : merchantData = request.form("merchantData")  ''2018/01/04

Dim isBaguinTempUse
isBaguinTempUse = (merchantData="vidx="&orderNumber)

Dim isChangeOrderUse
isChangeOrderUse = (merchantData="orderserial="&orderNumber)

''인증 실패
if (resultCode<>"0000") then
    response.write "<script>alert('인증에 실패하였습니다.\r\n"&replace(resultMsg,"'","")&"');</script>"
    response.write resultMsg
    dbget.close() : response.end
end if


''인증성공한경우
%>
<HTML>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<body onload="iniWebProc()">
<script>
function iniWebProc(){
    var fdo = opener.document.frmorder;
    fdo.authToken.value='<%=server.UrlEncode(authToken)%>';
    fdo.authUrl.value='<%=server.UrlEncode(authUrl)%>';
    <% If (isChangeOrderUse) Then %>
        fdo.action='<%=INIWEB_ChangePayURL%>';
    <% Else %>
        <% if (isBaguinTempUse) then %>
        fdo.action='<%=INIWEB_ProcUrl_BaguniTMP%>';
        <% else %>
        fdo.action='<%=INIWEB_ProcUrl%>';
        <% end if %>
    <% End If %>
    fdo.target="";
    opener.disable_click();
    fdo.submit();
    setTimeout("window.close()",500);
}
</script>
</BODY>
</HTML>
<!-- #include virtual="/lib/db/dbclose.asp" -->