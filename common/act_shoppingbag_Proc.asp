<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"

Response.Charset = "UTF-8"
%>
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/tenEncUtil.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbHelper.asp" -->
<!-- #include virtual="/lib/classes/ordercls/shoppingbagDBcls.asp" -->
<%
dim userid, guestSessionID
userid = GetLoginUserID
guestSessionID = GetGuestSessionKey()

'' 사이트 구분
Const sitename = "10x10"

dim mode            : mode		    = requestCheckVar(request.Form("mode"),10)					'추후 필요시 사용
dim itemid          : itemid		= getNumeric(requestCheckVar(request.Form("itemid"),9))
dim itemoption      : itemoption    = requestCheckVar(request.Form("itemoption"),4)
dim itemea          : itemea  	    = getNumeric(requestCheckVar(request.Form("itemea"),9))
dim rstCd			: rstCd = "9"		'1: 성공, 9: 실패

dim oShoppingBag
set oShoppingBag = new CShoppingBag
oShoppingBag.FRectUserID    = userid
oshoppingbag.FRectSessionID = guestSessionID
oShoppingBag.FRectSiteName  = sitename

'// 장바구니에서 삭제
itemea = 0			'무조건 삭제
if (Trim(itemid)<>"") and (Trim(itemoption)<>"") and (Trim(itemea)<>"") then
	oshoppingbag.EditshoppingBagDB Trim(itemid),Trim(itemoption),Trim(itemea)
	rstCd = "1"
end if

set oshoppingbag = Nothing

'화면 출력 / 끗
Response.Write rstCd
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->