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
<!-- #include virtual="/lib/db/dbhelper.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/ordercls/shoppingbagDBcls.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_pointcls.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_tenCashCls.asp" -->
<!-- #include virtual="/lib/classes/ordercls/sp_myordercls.asp" -->
<!-- #include virtual="/lib/classes/giftcard/giftcard_MyCardInfoCls.asp" -->
<!-- #include virtual="/lib/classes/ordercls/pack_cls.asp" -->
<%
Dim iDiscountSum
Const sitename = "10x10"

dim i, userid, guestSessionID
userid          = GetLoginUserID
guestSessionID  = GetGuestSessionKey


dim subtotalprice       : subtotalprice         = request.Form("price")
dim checkitemcouponlist : checkitemcouponlist   = request.Form("checkitemcouponlist")
dim couponid            : couponid              = request.Form("sailcoupon")                ''할인권 쿠폰번호
dim couponmoney         : couponmoney           = request.Form("couponmoney")
dim emsPrice            : emsPrice              = request.Form("emsPrice")
dim countryCode         : countryCode           = request.Form("countryCode")

Dim miletotalprice      : miletotalprice    = request.Form("spendmileage")
Dim spendtencash        : spendtencash      = request.Form("spendtencash")
Dim spendgiftmoney      : spendgiftmoney    = request.Form("spendgiftmoney")
Dim itemcouponmoney     : itemcouponmoney   = request.Form("itemcouponmoney")


if (Not isNumeric(miletotalprice)) or (miletotalprice="") then miletotalprice=0
if (Not isNumeric(spendtencash)) or (spendtencash="") then spendtencash=0
if (Not isNumeric(spendgiftmoney)) or (spendgiftmoney="") then spendgiftmoney=0
if (Not isNumeric(itemcouponmoney)) or (itemcouponmoney="") then itemcouponmoney=0
if (Not isNumeric(couponmoney)) or (couponmoney="") then couponmoney=0
if (Not isNumeric(couponid)) or (couponid="") then couponid=0
if (Not isNumeric(emsPrice)) or (emsPrice="") then emsPrice=0
    
      
if (Right(checkitemcouponlist,1)=",") then checkitemcouponlist=Left(checkitemcouponlist,Len(checkitemcouponlist)-1)

dim oshoppingbag,goodname
set oshoppingbag = new CShoppingBag
	oshoppingbag.FRectUserID = userid
	oshoppingbag.FRectSessionID = guestSessionID
	oShoppingBag.FRectSiteName  = sitename
	oShoppingBag.FcountryCode = countryCode           ''2009추가
	oshoppingbag.GetShoppingBagDataDB_Checked
	
''업체 개별 배송비 상품이 있는경우
if (oshoppingbag.IsUpcheParticleBeasongInclude)  then
    oshoppingbag.GetParticleBeasongInfoDB_Checked
end if

dim tmpitemcoupon, tmp
tmpitemcoupon = split(checkitemcouponlist,",")

'상품쿠폰 적용
for i=LBound(tmpitemcoupon) to UBound(tmpitemcoupon)
	tmp = trim(tmpitemcoupon(i))

	if oshoppingbag.IsCouponItemExistsByCouponIdx(tmp) then
		oshoppingbag.AssignItemCoupon(tmp)
	end if
next

''보너스 쿠폰 적용
if (couponid<>0) then
    oshoppingbag.AssignBonusCoupon(couponid)
end if

''Ems 금액 적용
oshoppingbag.FemsPrice = emsPrice

oshoppingbag.FDiscountRate = 0.95

if (oshoppingbag.FAssignedBonusCouponType="3") then  ''배송비쿠폰할인은 까지 말자.
    iDiscountSum = oshoppingbag.AssignHanaDiscountTotalPrice(CLNG(subtotalprice),CLNG(oshoppingbag.getTotalCouponAssignPrice(""))-CLNG(oshoppingbag.GetTotalBeasongPrice))
else
    iDiscountSum = oshoppingbag.AssignHanaDiscountTotalPrice(CLNG(subtotalprice),CLNG(oshoppingbag.getTotalCouponAssignPrice(""))-couponmoney-CLNG(oshoppingbag.GetTotalBeasongPrice))
end if
response.write "OK|"&iDiscountSum
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
