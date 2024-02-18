<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<!-- #include virtual="/login/checkUserGuestlogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbHelper.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/ordercls/sp_myordercls.asp" -->
<%

dim userid : userid       = getEncLoginUserID()

if (userid="") then
    response.write "<script>alert('최근 주문내역이 없습니다.');</script>"
    dbget.Close : response.end
end if

Dim retOrderSerial : retOrderSerial = getUserRecentOrder(userid)

if (Len(retOrderSerial)<>11) then
    response.write "<script>alert('최근 주문내역이 없습니다.');</script>"
    dbget.Close : response.end
end if

response.write "<script>parent.document.frmOrdSearch.orderserial.value='"& retOrderSerial &"';parent.document.frmOrdSearch.submit();</script>"
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
