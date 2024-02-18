<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"

'Response.ContentType = "application/json"
Response.Charset = "UTF-8"
%>
<!-- #include virtual="/lib/db/dbhelper.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/ordercls/shoppingbagDBcls.asp" -->
<!-- #include virtual="/lib/classes/item/itemOptionCls.asp" -->
<!-- #include virtual="/lib/classes/item/iteminfoCls.asp" -->

<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/JSON_2.0.4.asp" -->
<%
Const sitename = "10x10"

'// 회원Key
dim userid, guestSessionID
If IsUserLoginOK() Then
	userid = getEncLoginUserID
Else
	userid = GetLoginUserID
End If
guestSessionID = GetGuestSessionKey()

'/--------------
dim sBagCount, lp
dim oShoppingBag
set oShoppingBag = new CShoppingBag
oShoppingBag.FRectUserID    = userid
oshoppingbag.FRectSessionID = guestSessionID
oShoppingBag.FRectSiteName  = sitename

''쇼핑백 내용 쿼리
oshoppingbag.GetShoppingBagDataDB

sBagCount = oshoppingbag.FShoppingBagItemCount

'// JSON 카트 데이터 생성
Dim oCart : Set oCart = jsObject()
oCart("usrkey") = chkIIF(IsUserLoginOK,request.Cookies("tinfo")("shix"),session.sessionid)		'/ 회원Key
oCart("expire") = date																			'/ 유효기간 (1일)
oCart("cartcnt") = sBagCount																		'/ 장바구니 상품 갯수

Set oCart("list") = jsArray()

if sBagCount>0 then
	''for lp=(oshoppingbag.FShoppingBagItemCount-1) to 0 step -1		'// 역으로
	for lp=0 to (oshoppingbag.FShoppingBagItemCount-1)					'// 순으로
		Set oCart("list")(null) = jsObject()
		oCart("list")(null)("itemid") = oshoppingbag.FItemList(lp).FItemID
		oCart("list")(null)("itemoption") = oshoppingbag.FItemList(lp).FItemoption
		oCart("list")(null)("itemname") = oshoppingbag.FItemList(lp).FItemName
		oCart("list")(null)("image") = oshoppingbag.FItemList(lp).FImageList
		oCart("list")(null)("brand") = oshoppingbag.FItemList(lp).FBrandName
		oCart("list")(null)("makerid") = oshoppingbag.FItemList(lp).FMakerID
		oCart("list")(null)("itemea") = oshoppingbag.FItemList(lp).FItemEa

		'최대 10개 저장
		''if ((oshoppingbag.FShoppingBagItemCount-1)-lp)>=9 then Exit for	'// 역으로
		if lp>=9 then Exit for		'// 순으로
	next

end if

oCart.flush

set oShoppingBag = Nothing
%>

<!-- #include virtual="/lib/db/dbclose.asp" -->