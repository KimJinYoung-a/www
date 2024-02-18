<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<% Response.Addheader "P3P","policyref=""/w3c/p3p.xml"", CP=""CONi NOI DSP LAW NID PHY ONL OUR IND COM"""%>
<!-- #include virtual="/login/checkUserGuestlogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbHelper.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/classes/ordercls/sp_myordercls.asp" -->
<%
dim userid
userid = getLoginUserID


Dim orderserial : orderserial = requestCheckVar(request("orderserial"),11)
dim itemid      : itemid = RequestCheckvar(request.Form("itemid"),10)
dim itemoption  : itemoption = RequestCheckvar(request.Form("itemoption"),4)
dim pcode   : pcode   = RequestCheckvar(request.Form("pcode"),16)       'Fuji 제품코드
dim tplcode : tplcode = RequestCheckvar(request.Form("tplcode"),16)     'Fuji 템플릿코드
dim ordfile : ordfile = RequestCheckvar(request.Form("ordfile"),100)    '저장된 파일
dim didx : didx= RequestCheckvar(request.Form("didx"),11)

if ((userid="") and session("userorderserial")<>"") then
	orderserial = session("userorderserial")
end if

dim myorder
set myorder = new CMyOrder

if (IsUserLoginOK()) then
    myorder.FRectUserID = userid
    myorder.FRectOrderserial = orderserial
    myorder.GetOneOrder
elseif (IsGuestLoginOK()) then
    orderserial = GetGuestLoginOrderserial()
    myorder.FRectOrderserial = orderserial
    myorder.GetOneOrder
end if


dim myorderdetail
set myorderdetail = new CMyOrder
myorderdetail.FRectOrderserial = orderserial
myorderdetail.FRectIdx = didx

if myorder.FResultCount>0 then
    myorderdetail.GetOneOrderDetail
end if


dim i

if ((myorder.FResultCount<1) or (myorderdetail.FResultCount<1)) then
    response.write "<script language='javascript'>alert('주문 정보가 존재하지 않습니다.');</script>"
    response.write "<script language='javascript'>window.close();</script>"
    dbget.close()	:	response.End
end if


dim IsEditEnable
IsEditEnable = (myorderdetail.FOneItem.IsEditAvailState) or (myorderdetail.FOneItem.Frequiredetail="")

if  (Not IsEditEnable) then
    response.write "<script>alert('죄송합니다. 현재 제작중이므로 수정이 불가능 합니다.');</script>"
    response.write "<script>window.close();</script>"
    dbget.close() : response.end
end if

dim sqlStr
sqlStr = "update db_order.dbo.tbl_order_detail" & VbCrlf
sqlStr = sqlStr & " set requiredetail='"&ordfile&"'" & VbCrlf
sqlStr = sqlStr & " where orderserial='"&orderserial&"'"
sqlStr = sqlStr & " and idx="&didx

dbget.Execute sqlStr

response.write "<script>alert('수정되었습니다.');opener.location.reload();</script>"
response.write "<script>window.close();</script>"
dbget.close() : response.end
%>

<%
set myorderdetail = Nothing
set myorder = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->