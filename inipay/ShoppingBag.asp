<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<%
	'페이지 정보
	strPageTitle = "텐바이텐 10X10 : 장바구니"		'페이지 타이틀 (필수)
	strPageImage = "https://fiximage.10x10.co.kr/page/title/pageImage_shopping_v1.jpg"
	strPageDesc = "당신의 결제를 기다리는 상품을 만나러 갈 시간입니다!"
	'// 오픈그래프 메타태그
	strHeaderAddMetaTag = "<meta property=""og:title"" content=""[텐바이텐] 장바구니"" />" & vbCrLf &_
						"<meta property=""og:type"" content=""website"" />" & vbCrLf &_
						"<meta property=""og:url"" content=""https://www.10x10.co.kr/inipay/ShoppingBag.asp"" />" & vbCrLf &_
						"<meta property=""og:description"" content=""" & strPageDesc & """>" & vbCrLf
%>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/login/checkBaguniLogin.asp" -->
<!-- #include virtual="/lib/db/dbhelper.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/shopping/sp_itemcouponcls.asp" -->
<!-- #include virtual="/lib/classes/shopping/sp_couponcls.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_pointcls.asp" -->
<!-- #include virtual="/lib/classes/shopping/sp_mileageshopitemcls.asp" -->
<!-- #include virtual="/lib/classes/ordercls/shoppingbagDBcls.asp" -->
<!-- #include virtual="/lib/classes/item/itemOptionCls.asp" -->
<!-- #include virtual="/lib/classes/item/ticketItemCls.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_myfavoritecls.asp" -->
<!-- #include virtual="/lib/classes/item/iteminfoCls.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_tenCashCls.asp" -->
<!-- #include virtual="/lib/classes/giftcard/giftcard_MyCardInfoCls.asp" -->
<!-- #include virtual="/lib/classes/ordercls/emscls.asp" -->
<!-- #include virtual="/lib/classes/ordercls/pack_cls.asp" -->
<%
Dim ISQuickDlvUsing : ISQuickDlvUsing = FALSE ''2018/05/14 퀵배송 사용 안할경우 FALSE 로
Dim ISArmyDlvUsing : ISArmyDlvUsing = FALSE ''2018/06/14 군부대배송 사용안함.

if (TRUE) or (getLoginUserLevel()="7") then ISQuickDlvUsing=True ''우선 직원만 테스트

'// 바로배송 종료에 따른 처리
If now() > #07/31/2019 12:00:00# Then
	ISQuickDlvUsing = FALSE
End If

Const CnPls = 2 ''201712 추가 조건배송 이후에 경우의 수가 더 생기면 늘릴것
Const sitename = "10x10"
'' 마일리지샵 가능 여부
Const IsMileShopEnabled = FALSE
'' 위시리스트상품 표시여부. 201204
Dim BtmWishListVisible : BtmWishListVisible = TRUE
'' 장바구니에서 옵션수정가능 여부. 201204
Dim IsBaguniOptionEditEnable : IsBaguniOptionEditEnable = FALSE

'' 레코벨에 보낼 ItemId값
Dim RecoBellSendItemId : RecoBellSendItemId = ""

''계속 쇼핑하기 URL
dim LastShoppingUrl
LastShoppingUrl="/"

dim userid, guestSessionID, isBaguniUserLoginOK
If IsUserLoginOK() Then
	userid = getEncLoginUserID ''GetLoginUserID '' ''
	isBaguniUserLoginOK = true
Else
	userid = GetLoginUserID
	isBaguniUserLoginOK = false
End If
guestSessionID = GetGuestSessionKey

Dim bTp : bTp = request("bTp")	''장바구니 구분
if (bTp="a") and (NOT ISArmyDlvUsing) then bTp=""

Dim IsForeignDlv : IsForeignDlv = (bTp="f")			''해외 배송 여부
Dim IsArmyDlv	: IsArmyDlv = (bTp="a")			''군부대 배송 여부
Dim IsQuickDlv	: IsQuickDlv = (bTp="q")			''바로 배송 여부
Dim IsLocalDlv	: IsLocalDlv = (NOT IsForeignDlv) and (NOT IsArmyDlv) and (NOT IsQuickDlv) ''바로배송 추가에 따른 수정

dim chKdp, itemid, itemoption, itemea, requiredetail
chKdp		= requestCheckVar(request.Form("chKdp"),10)
itemid		= requestCheckVar(request.Form("itemid"),9)
itemoption = requestCheckVar(request.Form("itemoption"),4)
itemea		= requestCheckVar(request.Form("itemea"),9)
requiredetail = request.Form("requiredetail")

dim sBagCount
dim oShoppingBag
set oShoppingBag = new CShoppingBag
oShoppingBag.FRectUserID	= userid
oshoppingbag.FRectSessionID = guestSessionID
oShoppingBag.FRectSiteName = sitename

''위치변경 2013/09/12
if (IsForeignDlv) then
	oshoppingbag.FcountryCode = "AA"
elseif (IsArmyDlv) then
	oshoppingbag.FcountryCode = "ZZ"
elseif (IsQuickDlv) then
	oshoppingbag.FcountryCode = "QQ"
end if

''쇼핑백 내용 쿼리
oshoppingbag.GetShoppingBagDataDB

sBagCount = oshoppingbag.FShoppingBagItemCount


''마일리지 및 쿠폰 정보
dim availtotalMile
dim oSailCoupon, oItemCoupon, oMileage

availtotalMile = 0

'// 마일리지 정보
set oMileage = new TenPoint
oMileage.FRectUserID = userid
if (userid<>"") then
	oMileage.getTotalMileage
	availtotalMile = oMileage.FTotalMileage
end if

if availtotalMile<1 then availtotalMile=0


'// 할인권정보
set oSailCoupon = new CCoupon
oSailCoupon.FRectUserID = userid
oSailCoupon.FPageSize=100

if (userid<>"") then
	oSailCoupon.getValidCouponList
end if

'' (%) 보너스쿠폰 존재여부 - %할인쿠폰이 있는경우만 [%할인쿠폰제외상품]표시하기위함
dim intp, IsPercentBonusCouponExists
IsPercentBonusCouponExists = false
for intp=0 to oSailCoupon.FResultCount-1
	if (oSailCoupon.FItemList(intp).FCoupontype=1) then
		IsPercentBonusCouponExists = true
		Exit for
	end if
next

'// 쿠폰 정보
set oItemCoupon = new CUserItemCoupon
oItemCoupon.FRectUserID = userid
oItemCoupon.FPageSize=100

if (userid<>"") then
	oItemCoupon.getValidItemCouponListInBaguni ''2018/10/22
end if

'' 상품 쿠폰 적용. //201204추가 === 쿠폰 적용가를 구하기 위함.
dim IsItemFreeBeasongCouponExists
IsItemFreeBeasongCouponExists = false
for i=0 to oItemCoupon.FResultCount-1
	if oshoppingbag.IsCouponItemExistsByCouponIdx(oItemCoupon.FItemList(i).Fitemcouponidx) then
		oshoppingbag.AssignItemCoupon(oItemCoupon.FItemList(i).Fitemcouponidx)

		if (oshoppingbag.IsCouponItemExistsByCouponIdx(oItemCoupon.FItemList(i).Fitemcouponidx)) and (oitemcoupon.FItemList(i).IsFreeBeasongCoupon) then
			IsItemFreeBeasongCouponExists = true
		end if
	end if
next

''예치금 추가
Dim oTenCash, availtotalTenCash
availtotalTenCash = 0
set oTenCash = new CTenCash
oTenCash.FRectUserID = userid
if (userid<>"") then
	oTenCash.getUserCurrentTenCash

	availtotalTenCash = oTenCash.Fcurrentdeposit
end if
set oTenCash = Nothing

'' GiftCard
Dim oGiftCard, availTotalGiftMoney
availTotalGiftMoney = 0
set oGiftCard = new myGiftCard
oGiftCard.FRectUserID = userid
if (userid<>"") then
	availTotalGiftMoney = oGiftCard.myGiftCardCurrentCash
end if
set oGiftCard = Nothing

'// 마일리지 샵 상품
dim oMileageShop

set oMileageShop = new CMileageShop
oMileageShop.FPageSize=30			''' it is Not Work.. may be 100 items

if (IsMileShopEnabled) and (userid<>"") then
	oMileageShop.GetMileageShopItemList

	if (oMileageShop.FResultcount>5) then oMileageShop.FResultcount=5 ''5개만 표시 2013/09
end if

dim iCols, iRows
iCols=5		'''' OLD 5 new 4
iRows = CLng(oMileageShop.FResultCount \ iCols)

if (oMileageShop.FResultCount mod iCols)>0 then
	iRows = iRows + 1
end if

''위시리스트 상품 최대 5개
Dim omyFavorate
''if (userid="") then BtmWishListVisible=FALSE
if (sBagCount<1) then BtmWishListVisible=FALSE

IF (BtmWishListVisible) then
	set omyFavorate = new CMyFavorite
	omyFavorate.FPageSize = 5
	omyFavorate.FRectUserID = userid
	if (userid="") then ''비회원인경우 POPULAR WISH
		omyFavorate.getBaguniPopularList5
	else
		omyFavorate.getBaguniFavList5
	end if

End IF

''===EMS 관련============
Dim oems : SET oems = New CEms
Dim oemsPrice : SET oemsPrice = New CEms
if (IsForeignDlv) then
	oems.FRectCurrPage = 1
	oems.FRectPageSize = 200
	oems.FRectisUsing = "Y"
	oems.GetServiceAreaList

	oemsPrice.FRectWeight = oshoppingbag.getEmsTotalWeight
	oemsPrice.GetWeightPriceListByWeight
end if


''포토북 편집 안한상품 존재
dim NotEditPhotobookExists
''주문제작 상품 문구 적지 않은 상품
dim NotWriteRequireDetailExists
dim iErrMsg
dim i, j, idx
i=0
idx=0

dim optionBoxHtml

'' OldType Option Box를 한 콤보로 표시// 마일리지 및 위시리스트 동시사용
function getOneTypeOptionBoxHtmlMile(byVal iItemID, byVal isItemSoldOut, byval iOptionBoxStyle, byVal isLimitView)
	dim i, optionHtml, optionTypeStr, optionKindStr, optionSoldOutFlag, optionSubStyle
	dim oItemOption

	set oItemOption = new CItemOption
	oItemOption.FRectItemID = iItemID
	oItemOption.FRectIsUsing = "Y"
	oItemOption.GetOptionList

	if (oItemOption.FResultCount<1) then Exit Function

	optionTypeStr = oItemOption.FItemList(0).FoptionTypeName
	if (Trim(optionTypeStr)="") then
		optionTypeStr = "옵션 선택"
	else
		optionTypeStr = optionTypeStr + " 선택"
	end if
	optionHtml = "<select class='optSelect2' title='옵션을 선택해주세요' name='item_option_"&iItemID&"' " + iOptionBoxStyle + ">"
	optionHtml = optionHtml + "<option value='' selected>" & optionTypeStr & "</option>"


	for i=0 to oItemOption.FResultCount-1
		optionKindStr	= oItemOption.FItemList(i).FOptionName
		optionSoldOutFlag	= ""

		if (oItemOption.FItemList(i).IsOptionSoldOut) then optionSoldOutFlag="S"

		''품절일경우 한정표시 안함
		if ((isItemSoldOut) or (oItemOption.FItemList(i).IsOptionSoldOut)) then
			optionKindStr = optionKindStr + " (품절)"
			optionSubStyle = "style='color:#DD8888'"
		else
			if (oitemoption.FItemList(i).Foptaddprice>0) then
			'' 추가 가격
				optionKindStr = optionKindStr + " (" + FormatNumber(oitemoption.FItemList(i).Foptaddprice,0)  + "원 추가)"
			end if

			if (oitemoption.FItemList(i).IsLimitSell) then
			''옵션별로 한정수량 표시
				If (isLimitView) then
					optionKindStr = optionKindStr + " (한정 " + CStr(oItemOption.FItemList(i).GetOptLimitEa) + " 개)"
				end if
			end if
			optionSubStyle = ""
		end if

		optionHtml = optionHtml + "<option id='" + optionSoldOutFlag + "' " + optionSubStyle + " value='" + oItemOption.FItemList(i).FitemOption + "'>" + optionKindStr + "</option>"
	next

	optionHtml = optionHtml + "</select>"

	getOneTypeOptionBoxHtmlMile = optionHtml
	set oItemOption = Nothing
end function

Dim iTicketItemCNT : iTicketItemCNT = 0
Dim oTicketItem, TicketBookingExired : TicketBookingExired=FALSE

Dim iPresentItemCNT : iPresentItemCNT = 0

'// Kakao Analytics
kakaoAnal_AddScript = "kakaoPixel('6348634682977072419').viewCart();"


'// 크리테오 스크립트 관련
Dim CriteoADSItem
CriteoADSItem = ""
If oshoppingbag.FShoppingBagItemCount > 0 Then
	For r = 0 to oshoppingbag.FShoppingBagItemCount -1
		CriteoADSItem = CriteoADSItem &"{id: '"&oshoppingbag.FItemList(r).FItemID&"', price: "&oshoppingbag.FItemList(r).GetCouponAssignPrice&", quantity: "&oshoppingbag.FItemList(r).FItemEa&" },"
	Next
	If CriteoADSItem <> "" Then
		CriteoADSItem = Left(CriteoADSItem, Len(CriteoADSItem)-1)
	End If
End If
'//크리테오에 보낼 md5 유저 이메일값
If Trim(session("ssnuseremail")) <> "" Then
	CriteoUserMailMD5 = MD5(Trim(session("ssnuseremail")))
Else
	CriteoUserMailMD5 = ""
End If
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<script type="text/javascript" src="/lib/js/jquery.numspinner.min.js"></script>
<script type="text/javascript" >
$(document).unbind("dblclick");
//document.ondblclick = function(e) { }; // kill dblclick

var ChkErrMsg;
var Totalitemcount = <%= oshoppingbag.FShoppingBagItemCount %>;

function DownloadCouponWithReload(itemcouponidx){
	var popwin=window.open('<%= wwwURL %>/my10x10/downloaditemcoupon.asp?itemcouponidx=' + itemcouponidx + '&prload=on','DownloadCoupon','width=550,height=550,scrollbars=no,resizable=no');
	popwin.focus();
}

function checkAllItem(comp,j){
	var frm = document.baguniFrm;

	if (frm.chk_item.length){
		for(var i=0;i<frm.chk_item.length;i++){
			if (!frm.chk_item[i].disabled){
				frm.chk_item[i].checked = comp.checked;
			}
		}
	}else{
		if (!frm.chk_item.disabled){
			frm.chk_item.checked = comp.checked;
		}
	}

	for (var i=0;i<=j;i++){
		var dm = eval("document.baguniFrm.chk_item"+i);
		if (dm) { dm.checked = comp.checked; }
	}

	fnSelCalculate();
}

function fnCheckAll(comp){
	var frm = document.baguniFrm;
	var p = comp.name.substr(8,10); //comp.name.length-1

	if (frm.chk_item){
		if (frm.chk_item.length){
			for(var i=0;i<frm.chk_item.length;i++){
				if (frm.chk_item[i].id==p){
					if (!frm.chk_item[i].disabled){
						frm.chk_item[i].checked = comp.checked;
					}
				}
			}
		}else{
			if (frm.chk_item.id==p){
				if (!frm.chk_item.disabled){
					frm.chk_item.checked = comp.checked;
				}
			}
		}
	}

	fnSelCalculate();
}

$(function(){
	// 체크박스 변경
	fnAmplitudeEventMultiPropertiesAction("view_shoppingbag","","");
	$("input[name='chk_item']").click(function(){
		fnSelCalculate();
	});

	<%'// 해외 배송일 경우만 상품 전체 선택 처리%>
	<% if bTp = "f" then %>
	var frm = document.baguniFrm;

	if (frm.chk_item){
		if (frm.chk_item.length){
			for(var i=0;i<frm.chk_item.length;i++){
				if (!frm.chk_item[i].disabled){
					frm.chk_item[i].checked = true;
				}
			}
		}else{
			if (!frm.chk_item.disabled){
				frm.chk_item.checked = true;
			}
		}
	}
	<% end if %>
});

function DelItem(idx){
	var frm = document.baguniFrm;
	var reloadfrm = document.reloadFrm;

	if (!frm.itemkey.length){
		reloadfrm.mode.value	= "edit";
		reloadfrm.itemid.value	= frm.itemid.value;
		reloadfrm.itemoption.value = frm.itemoption.value;
		reloadfrm.itemea.value = 0;
	}else{
		reloadfrm.mode.value = "edit";
		reloadfrm.itemid.value	= frm.itemid[idx].value;
		reloadfrm.itemoption.value = frm.itemoption[idx].value;
		reloadfrm.itemea.value = 0;
	}

	if (confirm('상품을 장바구니에서 삭제 하시겠습니까?')){
	    appierProductRemovedFromCart(idx);
		document.reloadFrm.submit();
	}
}

function addItemNo(idx,addno){
	var frm = document.baguniFrm;
	var itemeacomp;
	if (!frm.itemkey.length){
		itemeacomp = frm.itemea;
	}else{
		itemeacomp = frm.itemea[idx];
	}

	if (itemeacomp.value*1+addno<1) return;

	itemeacomp.value = itemeacomp.value*1+addno;
}

function EditItem(idx){
	var frm = document.baguniFrm;
	var reloadfrm = document.reloadFrm;
	var itemeacomp;
	var maxnoflag;
	var minnoflag;
	var soldoutflag;

	if (!frm.itemkey.length){
		reloadfrm.mode.value		= "edit";
		reloadfrm.itemid.value		= frm.itemid.value;
		reloadfrm.itemoption.value	= frm.itemoption.value;
		reloadfrm.itemea.value		= frm.itemea.value;

		itemeacomp = frm.itemea;
		maxnoflag = frm.maxnoflag;
		minnoflag = frm.minnoflag;
		soldoutflag = frm.soldoutflag;
	}else{
		reloadfrm.mode.value		= "edit";
		reloadfrm.itemid.value		= frm.itemid[idx].value;
		reloadfrm.itemoption.value	= frm.itemoption[idx].value;
		reloadfrm.itemea.value		= frm.itemea[idx].value;

		itemeacomp	= frm.itemea[idx];
		maxnoflag	= frm.maxnoflag[idx];
		minnoflag	= frm.minnoflag[idx];
		soldoutflag	= frm.soldoutflag[idx];
	}

	if (!IsDigit(itemeacomp.value)||(itemeacomp.value.length<1) ) {
		alert("구매수량은 숫자로 넣으셔야 됩니다.");
		itemeacomp.focus();
		return;
	}

	//최대구매수량 체크
	if (itemeacomp.value*1>maxnoflag.value*1){
		alert('한정수량 또는 최대 구매수량 (' + maxnoflag.value + ')개를 초과하여 주문 하실 수 없습니다.');
		itemeacomp.focus();
		return;
	}
	//최소구매수량 체크
	if (itemeacomp.value*1<minnoflag.value*1){
		alert('최소 구매수량 (' + minnoflag.value + ')개를 이상 주문 하실 수 있습니다..');
		itemeacomp.focus();
		return;
	}

	if (itemeacomp.value == "0"){
		if (confirm('상품을 장바구니에서 삭제 하시겠습니까?')){
			document.reloadFrm.submit();
		}
	}

	document.reloadFrm.submit();
}

function EditRequireDetail(iitemid,iitemoption){
	var popwin = window.open('/inipay/Pop_EditItemRequire.asp?itemid=' + iitemid + '&itemoption=' + iitemoption,'edititemrequire','width=640,height=500,scrollbars=yes,resizable=yes');
	popwin.focus();
}

function PopMileageItemView(iitemid){
	var popwin = window.open('/my10x10/Pop_mileageshop_itemview.asp?itemid=' + iitemid,'Pop_mileageshop_itemview','width=464,height=600,scrollbars=yes,resizable=yes');
	popwin.focus();
}


//마일리지샵 상품 추가
function AddMileItem(iitemid,iitemoption,iitemea){
	var frm = document.reloadFrm;
	//옵션 선택 추가..

	frm.mode.value		= "add";
	frm.itemid.value	=iitemid;
	frm.itemoption.value=iitemoption;
	frm.itemea.value	=iitemea;
	frm.submit();
}

function AddMileItem2(iitemid){
	var mfrm = document.mileForm;
	var frm = document.reloadFrm;
	var iitemoption="0000";
	//옵션 선택 추가..
	if (eval("document.mileForm.item_option_"+iitemid)){
		var comp = eval("mileForm.item_option_"+iitemid);
		if (comp[comp.selectedIndex].id == "S") { alert("품절된 옵션은 구매하실 수 없습니다."); return; }

		iitemoption=comp[comp.selectedIndex].value;

		if (iitemoption==""){
			alert('옵션을 선택 하세요.');
			comp.focus();
			return;
		}
	}
	frm.mode.value		= "add";
	frm.itemid.value	=iitemid;
	frm.itemoption.value=iitemoption;
	frm.itemea.value	="1";
	frm.submit();
}

function AddFavItem2(iitemid, adultType){
	var mfrm = document.favForm;
	var frm = document.reloadFrm;
	var isAdult = <%=chkiif(session("isAdult")=True,1,0)%>;
	var iitemoption="0000";
	//옵션 선택 추가..

	if (eval("document.favForm.item_option_"+iitemid)){
		var comp = eval("document.favForm.item_option_"+iitemid);
		if (comp[comp.selectedIndex].id == "S") { alert("품절된 옵션은 구매하실 수 없습니다."); return; }

		iitemoption=comp[comp.selectedIndex].value;

		if (iitemoption==""){
			alert('옵션을 선택 하세요.');
			comp.focus();
			return;
		}
		if(isAdult == 0 && adultType != "0"){
			confirmAdultAuth('/my10x10/mywishlist.asp');
			return;
		}
	}

	frm.mode.value		= "add";
	frm.itemid.value	=iitemid;
	frm.itemoption.value=iitemoption;
	frm.itemea.value	="1";
	frm.submit();
}

// enjoy together 장바구니 추가
function AddTogetherItem2(iitemid){
	var mfrm = document.togeForm;
	var frm = document.reloadFrm;
	var iitemoption="0000";
	//옵션 선택 추가..
	if (eval("document.togeForm.item_option_"+iitemid)){
		var comp = eval("togeForm.item_option_"+iitemid);
		if (comp[comp.selectedIndex].id == "S") { alert("품절된 옵션은 구매하실 수 없습니다."); return; }

		iitemoption=comp[comp.selectedIndex].value;

		if (iitemoption==""){
			alert('옵션을 선택 하세요.');
			comp.focus();
			return;
		}
	}
	frm.mode.value		= "add";
	frm.itemid.value	=iitemid;
	frm.itemoption.value=iitemoption;
	frm.itemea.value	="1";
	frm.submit();
}

function GoShopping(){
	location.href="<%= LastShoppingUrl %>";
}

function PayNextSelected(jumundiv){
	var frm = document.baguniFrm;
	var nextfrm = document.NextFrm;
	var chkExists = false;
	var mitemExists = false;
	var oitemExists = false;
	var nitemExists = false;
	var d1typExists = false;
	var d2typExists = false;
	var d3typExists = false;
	var titemCount = 0;		//Ticket
	var rstemCount = 0;		//현장수령상품
	var pitemCount = 0;		//Present상품
	var mitemttl = 0;
	var isAdult = <%=chkiif(session("isAdult")=True,1,0)%>;

	if (frm.chk_item){
		if (frm.chk_item.length){
			for(var i=0;i<frm.chk_item.length;i++){
				if (frm.chk_item[i].checked){
					chkExists = true;
					if (frm.mtypflag[i].value=="m"){
						mitemExists = true;
						mitemttl+=frm.isellprc[i].value*1;
					}else if(frm.mtypflag[i].value=="o"){
						oitemExists = true;
					}else if(frm.mtypflag[i].value=="t"){
						titemCount = titemCount+1;
					}else if(frm.mtypflag[i].value=="r"){
						rstemCount = rstemCount+1;
					}else if(frm.mtypflag[i].value=="p"){
						pitemCount = pitemCount+1;
					}else{
						nitemExists = true;
					}

					if ((frm.dtypflag[i].value=="1")&&(frm.mtypflag[i].value!="m")){
						d1typExists = true;
					}else if(frm.dtypflag[i].value=="2"){
						d2typExists = true;
					}else{
						d3typExists = true;
					}

					if (frm.soldoutflag[i].value == "Y"){
						alert('품절된 상품은 구매하실 수 없습니다.');
						frm.itemea[i].focus();
						return;
					}

					if(isAdult == 0 && $(frm.chk_item[i]).attr("adultType") != "0"){
						confirmAdultAuth('/my10x10/shoppingbag.asp');
						return;
					}

            		if (frm.nophothofileflag[i].value=="1"){
            			alert('포토북 상품은 편집후 구매 가능합니다.');
            			frm.itemea[i].focus();
            			return;
            		}

            		if (frm.chkolditemea[i].value*1!=frm.itemea[i].value*1){
            			alert('수량 조절후 수정 버튼을 누르셔야 저장됩니다.');
            			frm.itemea[i].focus();
            			return;
            		}

        			if (frm.chkolditemea[i].value*1>frm.maxnoflag[i].value*1){
        				alert('한정수량 또는 최대 구매수량 (' + frm.maxnoflag[i].value + ')개를 초과하여 주문 하실 수 없습니다.');
        				frm.itemea[i].focus();
        				return;
        			}
        			if (frm.chkolditemea[i].value*1<frm.minnoflag[i].value*1){
        				alert('최소 구매수량 (' + frm.minnoflag[i].value + ')개 이상 주문 하실 수 있습니다.');
        				frm.itemea[i].focus();
        				return;
        			}


					if ((jumundiv=="f")&&(frm.foreignflag[i].value!='Y')){
            			alert('해외 배송이 가능한 상품이 없습니다.\n\n상품설명 페이지의 배송구분 란에 해외배송 안내가 되어 있는 상품만으로 해외 배송이 가능합니다.');
            			if (frm.itemea[i].type=='text'){
            				frm.itemea[i].focus();
            			}
            			return;
            		}

            		if ((jumundiv=="a")&&(frm.dtypflag[i].value!='1')){
            			alert('군부대 배송이 가능한 상품이 없습니다.\n\n텐바이텐 배송상품으로만 군부대 배송이 가능합니다.');
            			if (frm.itemea[i].type=='text'){
            				frm.itemea[i].focus();
            			}
            			return;
            		}

                }
            }
        }else{
            if (frm.chk_item.checked){
                chkExists = true;
                if (frm.mtypflag.value=="m"){
                    mitemExists = true;
                    mitemttl+=frm.isellprc.value*1;
                }
                if (frm.soldoutflag.value == "Y"){
        			alert('품절된 상품은 구매하실 수 없습니다.');
        			frm.itemea.focus();
        			return;
        		}

        		if (frm.nophothofileflag.value=="1"){
        			alert('포토북 상품은 편집후 구매 가능합니다.');
        			frm.itemea.focus();
        			return;
        		}
				if(isAdult == 0 && $(frm.chk_item).attr("adultType") != "0"){
					confirmAdultAuth('/my10x10/shoppingbag.asp');
					return;
				}

        		if (frm.chkolditemea.value*1!=frm.itemea.value*1){
        			alert('수량 조절후 수정 버튼을 누르셔야 저장됩니다.');
        			frm.itemea.focus();
        			return;
        		}

        		if (frm.chkolditemea.value*1>frm.maxnoflag.value*1){
        			alert('한정수량 또는 최대 구매수량 (' + frm.maxnoflag.value + ')개를 초과하여 주문 하실 수 없습니다.');
        			frm.itemea.focus();
        			return;
        		}
        		if (frm.chkolditemea.value*1<frm.minnoflag.value*1){
        			alert('최소 구매수량 (' + frm.minnoflag.value + ')개 이상 주문 하실 수 있습니다.');
        			frm.itemea.focus();
        			return;
        		}


        		if ((jumundiv=="f")&&(frm.foreignflag.value!='Y')){
        			alert('해외 배송이 불가능한 상품이 포함 되어있습니다.');
        			if (frm.itemea.type=='text'){
        				frm.itemea.focus();
        			}
        			return;
        		}

        		if ((jumundiv=="a")&&(frm.dtypflag.value!='1')){
        			alert('군부대 배송이 불가능한 상품이 포함 되어있습니다.');
        			if (frm.itemea.type=='text'){
        				frm.itemea.focus();
        			}
        			return;
        		}
            }
        }
    }

	if (!chkExists){
		alert('선택된 상품이 없습니다. 주문 하실 상품을 선택후 진행해 주세요.');
		return;
	}

	if ((mitemExists)&&(!d1typExists)){
		alert('마일리지샵 상품은 텐바이텐 배송상품과 함께 하셔야 배송 가능 합니다.');
		return;
	}

    if ((oitemExists)&&(nitemExists)){
        alert('단독구매 및 예약판매 상품과 일반상품은 같이 구매하실 수 없습니다.\n\n단독구매 및 예약판매 상품은 별도로 장바구니에 담아주세요.');
        return;
    }

    if ((titemCount>0)&&(nitemExists)){
        alert('티켓 단독 상품과 일반상품은 같이 구매하실 수 없습니다.\n\티켓 단독 상품은 별도로 장바구니에 담아주세요.');
        return;
    }

    if (titemCount>1){
        alert('티켓 단독 상품은 개별상품으로만 주문 가능합니다.\n\티켓 단독 상품은 별도로 장바구니에 담아주세요.');
        return;
    }

    if ((rstemCount>0)&&(nitemExists)){
        alert('현장수령 상품과 일반상품은 같이 구매하실 수 없습니다.\n\현장수령 상품은 별도로 장바구니에 담아주세요.');
        return;
    }

    if ((pitemCount>0)&&(nitemExists)){
        alert('Present상품과 일반상품은 같이 구매하실 수 없으니, 단독으로 주문해 주시기 바랍니다.');
        return;
    }

	if (pitemCount>1){
		alert('Present 상품은 개별상품으로만 주문 가능합니다.\n\Present상품은 한번에 한 상품씩 구매 가능합니다.');
		return;
	}

	var currmileage = <%= availtotalMile %>;
	nextfrm.mileshopitemprice.value = mitemttl;

	if (nextfrm.mileshopitemprice.value*1>currmileage*1){
		alert('장바구니에 담으신 마일리지샵 상품의 합계가 고객님이 보유하신 마일리지 금액보다 큽니다.\n\n- 보유하신 마일리지 : ' + setComma(currmileage) + 'point\n- 담으신 마일리지샵 상품의 합계 : ' + setComma(nextfrm.mileshopitemprice.value) + 'point');
		return;
	}

	frm.mode.value = "OCK";
	//frm.bTp.value = jumundiv;
	frm.submit();
}

function PayNext(frm, jumundiv, iErrMsg){
	var nextfrm = document.NextFrm;
	var isAdult = <%=chkiif(session("isAdult")=True,1,0)%>;
	if (iErrMsg){
		alert(iErrMsg);
		return;
	}

	if (Totalitemcount==1){
		if (frm.soldoutflag.value == "Y"){
			alert('품절된 상품은 구매하실 수 없습니다.');
			frm.itemea.focus();
			return;
		}

		if(isAdult == 0 && $(frm.chk_item).attr("adultType") != "0"){
			confirmAdultAuth('/my10x10/shoppingbag.asp');
			return;
		}

		if (frm.nophothofileflag.value=="1"){
			alert('포토북 상품은 편집후 구매 가능합니다.');
			frm.itemea.focus();
			return;
		}

		if (frm.chkolditemea.value*1!=frm.itemea.value*1){
			alert('수량 조절후 수정 버튼을 누르셔야 저장됩니다.');
			frm.itemea.focus();
			return;
		}

		if (frm.chkolditemea.value*1>frm.maxnoflag.value*1){
			alert('한정수량 또는 최대 구매수량 (' + frm.maxnoflag.value + ')개를 초과하여 주문 하실 수 없습니다.');
			frm.itemea.focus();
			return;
		}
		if (frm.chkolditemea.value*1<frm.minnoflag.value*1){
			alert('최소 구매수량 (' + frm.minnoflag.value + ')개 이상 주문하실 수 있습니다.');
			frm.itemea.focus();
			return;
		}


		if ((jumundiv=="f")&&(frm.foreignflag.value!='Y')){
		    alert('해외 배송이 불가능한 상품이 포함 되어있습니다.');
		    if (frm.itemea.type=='text'){
			    frm.itemea.focus();
			}
			return;
		}

	}else{
		for (i=0;i<Totalitemcount;i++){
			if (frm.nophothofileflag[i].value=="1"){
    		    alert('포토북 상품은 편집후 구매 가능합니다.');
    			frm.itemea[i].focus();
    			return;
    		}

			if (frm.chkolditemea[i].value*1!=frm.itemea[i].value*1){
    	        alert('수량 조절후 수정 버튼을 누르셔야 저장됩니다.');
    	        frm.itemea[i].focus();
    			return;
    	    }

			if(isAdult == 0 && $(frm.chk_item[i]).attr("adultType") != "0"){
				confirmAdultAuth('/my10x10/shoppingbag.asp');
				return;
			}

			if (frm.chkolditemea[i].value*1>frm.maxnoflag[i].value*1){
				alert('한정수량 또는 최대 구매수량 (' + frm.maxnoflag[i].value + ')개를 초과하여 주문 하실 수 없습니다.');
				frm.itemea[i].focus();
				return;
			}
			if (frm.chkolditemea[i].value*1<frm.minnoflag[i].value*1){
				alert('최소 구매수량 (' + frm.minnoflag[i].value + ')개 이상 주문하실 수 있습니다..');
				frm.itemea[i].focus();
				return;
			}


			if ((jumundiv=="f")&&(frm.foreignflag[i].value!='Y')){
    		    alert('해외 배송이 불가능한 상품이 포함 되어있습니다.');
    		    if (frm.itemea[i].type=='text'){
    			    frm.itemea[i].focus();
    			}
    			return;
    		}

			<%'// 하나체크 전용상품 관련 %>
			if (frm.mtypflag[i].value=="o"){
    		    alert('단독구매 및 예약판매 상품과 일반상품은 같이 구매하실 수 없습니다.\n\n단독구매 및 예약판매 상품은 별도로 장바구니에 담아주세요.');
    		    if (frm.itemea[i].type=='text'){
    			    frm.itemea[i].focus();
    			}
    			return;
			}
		}
	}


	var currmileage = <%= availtotalMile %>;

    if (nextfrm.mileshopitemprice.value*1>currmileage*1){
        alert('장바구니에 담으신 마일리지샵 상품의 합계가 고객님이 보유하신 마일리지 금액보다 큽니다.\n\n- 보유하신 마일리지 : ' + setComma(currmileage) + 'point\n- 담으신 마일리지샵 상품의 합계 : ' + setComma(nextfrm.mileshopitemprice.value) + 'point');
		return;
    }

    if (frm.chk_item.length){
		for(var i=0;i<frm.chk_item.length;i++){
		    if (!frm.chk_item[i].disabled){
			    frm.chk_item[i].checked = true;
			}
		}
	}else{
	    if (!frm.chk_item.disabled){
		    frm.chk_item.checked = true;
		}
	}
	frm.mode.value = "OCK";
	frm.submit();
}

function TnShoppingBagForceAdd(){
	document.frmConfirm.submit();
}

function NtcCenterLayer(){
	//var isIE=document.all;
	//var iPopupLayer=document.getElementById("iPopupLayer");
	//iPopupLayer.style.left = (screen.width-350)/2 ;
	//iPopupLayer.style.top = (screen.height-150)/2;
	//iPopupLayer.style.visibility = "visible"
}

function hidePopupLayer(){
	var comp = document.getElementById("cartAddLyr");
	comp.style.visibility = "hidden"
}

function goSaveDvlPay(){
	location.href="/event/eventmain.asp?eventid=14067";
}

function addWishSelected(){
    var frm = document.baguniFrm;
    var chkExists = false;
    var ArrayFavItemID='';

    if (frm.chk_item){
        if (frm.chk_item.length){
            for(var i=0;i<frm.chk_item.length;i++){
                if (frm.chk_item[i].checked){
                    chkExists = true;
                    ArrayFavItemID=ArrayFavItemID + ',' + frm.itemid[i].value;
                }
            }
        }else{
            if (frm.chk_item.checked){
                chkExists = true;
                ArrayFavItemID=ArrayFavItemID + ',' + frm.itemid[i].value;
            }
        }
	}

	if (!chkExists){
		alert('선택된 상품이 없습니다. 위시리스트에 담으실 상품을 선택후 진행해 주세요.');
		return;
	}

 	if (confirm('선택 상품을 위시리스트에 추가하시겠습니까?')){
		var FavWin = window.open('/my10x10/popMyFavorite.asp?mode=AddFavItems&bagarray=' + ArrayFavItemID ,'FavWin','width=380,height=310,scrollbars=no,resizable=no');
		FavWin.focus();
	}
}

function delSelected(){
	var frm = document.baguniFrm;
	var chkExists = false;

    if (frm.chk_item){
        if (frm.chk_item.length){
            for(var i=0;i<frm.chk_item.length;i++){
                if (frm.chk_item[i].checked){
                    chkExists = true;
                    appierProductRemovedFromCart(i);
                }
            }
        }else{
            if (frm.chk_item.checked){
                chkExists = true;
            }
        }
    }

    if (!chkExists){
        alert('선택된 상품이 없습니다. 장바구니에서 삭제할 상품을 선택후 진행해 주세요.');
		return;
    }

    if (confirm('선택 상품을 장바구니에서 삭제하시겠습니까?')){
        frm.mode.value='DLARR';
        frm.submit();
    }
}

function delSoldOutBaguni(){
    var frm = document.baguniFrm;
    var sdExists = false;

    if (frm.chk_item){
        if (frm.chk_item.length){
            for(var i=0;i<frm.chk_item.length;i++){
                if (frm.soldoutflag[i].value == "Y"){
                    sdExists = true;
                }
            }
        }else{
            if (frm.soldoutflag == "Y"){
                sdExists = true;
            }
        }
    }

    if (!sdExists){
        alert('품절 상품이 없습니다. 장바구니에서 삭제할 상품을 선택후 선택상품 삭제로 진행해 주세요.');
		return;
    }

    if (confirm('품절 상품을 장바구니에서 삭제하시겠습니까?')){
        if (frm.chk_item){
            if (frm.chk_item.length){
                for(var i=0;i<frm.chk_item.length;i++){
                    if (frm.soldoutflag[i].value == "Y"){
                        frm.chk_item[i].checked=true;
                        frm.chk_item[i].disabled=false;
                    }
                }
            }else{
                if (frm.soldoutflag.value == "Y"){
                    frm.chk_item.checked=true;
                    frm.chk_item.disabled=false;
                }
            }
        }

        frm.mode.value='DLARR';
        frm.submit();
    }
}

function DirectOrder(idx, adultType){
    var frm = document.baguniFrm;
	var reloadfrm = document.reloadFrm;
	var isAdult = <%=chkiif(session("isAdult")=True,1,0)%>;

	if (!frm.itemkey.length){
		reloadfrm.mode.value    = "DO1";
		reloadfrm.itemid.value	= frm.itemid.value;
		reloadfrm.itemoption.value = frm.itemoption.value;
		reloadfrm.itemea.value = frm.itemea.value;
		reloadfrm.requiredetail.value = frm.requiredetail.value;

		if (frm.soldoutflag.value == "Y"){
        	alert('품절된 상품은 구매하실 수 없습니다.');
        	frm.itemea.focus();
        	return;
        }

		if(isAdult == 0 && adultType != "0"){
			confirmAdultAuth('/my10x10/mywishlist.asp');
			return;
		}

        if (frm.nophothofileflag.value == "1"){
        	alert('포토북 상품은 편집후 구매 가능합니다.');
			frm.itemea.focus();
			return;
        }

        if (frm.chkolditemea.value*1>frm.maxnoflag.value*1){
        	alert('한정수량 또는 최대 구매수량 (' + frm.maxnoflag.value + ')개를 초과하여 주문 하실 수 없습니다.');
        	frm.itemea.focus();
        	return;
        }
        if (frm.chkolditemea.value*1<frm.minnoflag.value*1){
        	alert('최소 구매수량 (' + frm.minnoflag.value + ')개 이상 주문 하실 수 있습니다.');
        	frm.itemea.focus();
        	return;
        }

		if (frm.chkolditemea.value*1!=frm.itemea.value*1){
	        alert('수량 조절후 수정 버튼을 누르셔야 저장됩니다.');
	        frm.itemea.focus();
			return;
	    }

	    <% if (Not isBaguniUserLoginOK) then %>
	    if (frm.mtypflag.value == "t"){
	        alert('죄송합니다. 티켓 상품은 회원 구매만 가능합니다.');
	        frm.itemea.focus();
			return;
	    }

	    if (frm.mtypflag.value == "p"){
	        alert('죄송합니다. Present상품은 회원 구매만 가능합니다.');
			return;
	    }
	    <% end if %>

	}else{
		reloadfrm.mode.value = "DO1";
		reloadfrm.itemid.value	= frm.itemid[idx].value;
		reloadfrm.itemoption.value = frm.itemoption[idx].value;
		reloadfrm.itemea.value = frm.itemea[idx].value;
		reloadfrm.requiredetail.value = frm.requiredetail[idx].value;
		
		if (frm.soldoutflag[idx].value == "Y"){
        	alert('품절된 상품은 구매하실 수 없습니다.');
        	frm.itemea[idx].focus();
        	return;
        }

		if(isAdult == 0 && adultType != "0"){
			confirmAdultAuth('/my10x10/mywishlist.asp');
			return;
		}

        if (frm.nophothofileflag[idx].value == "1"){
        	alert('포토북 상품은 편집후 구매 가능합니다.');
			frm.itemea[idx].focus();
			return;
        }

        if (frm.chkolditemea[idx].value*1>frm.maxnoflag[idx].value*1){
        	alert('한정수량 또는 최대 구매수량 (' + frm.maxnoflag[idx].value + ')개를 초과하여 주문 하실 수 없습니다.');
        	frm.itemea[idx].focus();
        	return;
        }
        if (frm.chkolditemea[idx].value*1<frm.minnoflag[idx].value*1){
        	alert('최소 구매수량 (' + frm.minnoflag[idx].value + ')개 이상 주문 하실 수 있습니다.');
        	frm.itemea[idx].focus();
        	return;
        }


		if (frm.chkolditemea[idx].value*1!=frm.itemea[idx].value*1){
	        alert('수량 조절후 수정 버튼을 누르셔야 저장됩니다.');
	        frm.itemea[idx].focus();
			return;
	    }

	    <% if (Not isBaguniUserLoginOK) then %>
	    if (frm.mtypflag[idx].value == "t"){
	        alert('죄송합니다. 티켓 상품은 회원 구매만 가능합니다.');
	        frm.itemea[idx].focus();
			return;
	    }

	    if (frm.mtypflag[idx].value == "p"){
	        alert('죄송합니다. Present상품은 회원 구매만 가능합니다.');
			return;
	    }
	    <% end if %>
	}

	document.reloadFrm.submit();
}

function editOrderPhotolooks(itemid, itemoption, orgfile){
    var ws = screen.width * 0.8;
	var hs = screen.height * 0.8;
	var winspec = "width="+ ws + ",height="+ hs +",top=10,left=10, menubar=no,toolbar=no,scroolbars=no,resizable=yes";
	var popwin = window.open("/shopping/fuji/photolooks.asp?itemid="+ itemid +"&itemoption="+ itemoption +"&orgfile="+orgfile, "photolooks"+itemid+itemoption, winspec)
	popwin.focus();
}

var pMileBtn = false;
function showMileShop(){
    //마일리지 샵으로 이동.
    location.href="/my10x10/mileage_shop.asp";
    return;

    pMileBtn = !(pMileBtn);
    var comp = null;
    <% for j=1 to iRows-1 %>
    comp = document.getElementById("imileRows<%= j %>");

    if (comp){

            if (pMileBtn==true){
                comp.style.display = "block";
            }else{
                comp.style.display = "none";
            }

    }

    <% next %>
}

function popEmsApplyGoCondition(){
    var nation = 'GR';
    if (document.baguniFrm.countryCode.value!='') nation = document.baguniFrm.countryCode.value;

    var popwin = window.open('http://ems.epost.go.kr:8080/front.EmsApplyGoCondition.postal?nation=' + nation,'EmsApplyGoCondition','scrollbars=yes,resizable=yes,width=620,height=600');
}

function plusComma(num){
	if (num < 0) { num *= -1; var minus = true}
	else var minus = false

	var dotPos = (num+"").split(".")
	var dotU = dotPos[0]
	var dotD = dotPos[1]
	var commaFlag = dotU.length%3

	if(commaFlag) {
		var out = dotU.substring(0, commaFlag)
		if (dotU.length > 3) out += ","
	}
	else var out = ""

	for (var i=commaFlag; i < dotU.length; i+=3) {
		out += dotU.substring(i, i+3)
		if( i < dotU.length-3) out += ","
	}

	if(minus) out = "-" + out
	if(dotD) return out + "." + dotD
	else return out
}

function calcuEmsPrice(emsAreaCode){
    //divEmsPrice
    var emsprice = 0;

    var _emsAreaCode = new Array(<%= oemsPrice.FResultCount %>);
    var _emsPrice = new Array(<%= oemsPrice.FResultCount %>);

    <% for i=0 to oemsPrice.FResultCount-1 %>
        _emsAreaCode[<%= i %>] = '<%= oemsPrice.FItemList(i).FemsAreaCode %>';
        _emsPrice[<%= i %>] = '<%= oemsPrice.FItemList(i).FemsPrice %>';
    <% next %>

    for (var i=0;i<_emsAreaCode.length;i++){
        if (_emsAreaCode[i]==emsAreaCode){
            emsprice = _emsPrice[i];
            break;
        }
    }

    return emsprice;


}

function setEMSPrice(comp){
    var frm = comp.form;
    var iMaxWeight = 30000;  //(g)
    var totalWeight = <%= oshoppingbag.getEmsTotalWeight %>;
    var contryName = '';

    if (comp.value==''){
        //document.getElementById("sp_countryName").innerHTML = "-";
		document.getElementById("sp_emsPrice").innerHTML = "-";
		document.getElementById("sp_emsPriceTTL").innerHTML = "0";
		$("#iemsPrice").val(0);
    }else{
        //frm.countryCode.value = comp.value;
        var iemsAreaCode = comp[comp.selectedIndex].id.split("|")[0]; 
        iMaxWeight = comp[comp.selectedIndex].id.split("|")[1]; 
        contryName = comp[comp.selectedIndex].text;
        iemsPrice  = calcuEmsPrice(iemsAreaCode);
		//document.getElementById("sp_countryName").innerHTML = contryName;
		document.getElementById("sp_emsPrice").innerHTML = plusComma(iemsPrice);
		document.getElementById("sp_emsPriceTTL").innerHTML = plusComma(iemsPrice);
		document.getElementById("sp_ForeignPriceTTL").innerHTML = plusComma(iemsPrice);

		$("#iemsPrice").val(iemsPrice);
		$("#sp_emsPriceTTL").val(iemsPrice);
		$("#sp_ForeignPriceTTL").val(iemsPrice);
    }
	fnSelCalculate();


    //iMaxWeight 체크
    if (totalWeight>iMaxWeight){
        alert('죄송합니다. ' + contryName + ' 최대 배송 가능 중량은 ' + iMaxWeight + ' (g)입니다.');
        comp.value='';
        return;
    }
}


	//하단 마일리지, my wish, enjoy together 탭 관련 스크립트
	$(function(){
		$(".recoPick .tabMenu li a:first").addClass("current");
		$(".recoPick .tabCont").find(".section").hide();
		$(".recoPick .tabCont").find(".section:first").show();
		
		$(".recoPick .tabMenu li a").click(function(){
			$(".recoPick .tabMenu li a").removeClass("current");
			$(this).addClass("current");
			var thisCont = $(this).attr("href");
			$(".recoPick .tabCont").find(".section").hide();
			$(".recoPick .tabCont").find(thisCont).show();
			return false;
		});
		
		<% if (ISQuickDlvUsing) then %>
		// 바로배송
		$('.infoMoreViewV15').mouseover(function(){
    		$(this).children('.infoViewLyrV15').show();
    	});
    	$('.infoMoreViewV15').mouseleave(function(){
    		$(this).children('.infoViewLyrV15').hide();
    	});
        <% end if %>
	});

// 장바구니 선택 재계산
function fnSelCalculate() {
	var vTotItemCnt=0, vTotItemEa=0, vTotItemPrc=0, vTotDlvPrc=0, vTotMilePrc=0, vTotItemMile=0;
	var aDlvLmt = new Array();
	$(".baseTable td input[name='chk_item']:enabled").each(function(){
		var itemprc=0, itemea=0, realitemea=0, itemcnt=0, mileprc=0, itemMile=0, mtypflag="", dtypflag="", prcUnit="원";
		var soldout="N", cDlvFree=false;

		var parentstr = $(this).closest("tbody");
		var parentstr2 = $(this).closest("tr");
		dtypflag = parentstr.find("input[name='dtypflag']").val();
		mtypflag = parentstr.find("input[name='mtypflag']").val();
		soldout = parentstr.find("input[name='soldoutflag']").val();
		if(mtypflag=="m") prcUnit="Pt";

		if($(this).prop("checked")) {
			itemprc = parseInt(parentstr2.find("input[name='isellprc']").val());
			itemea = parseInt(parentstr2.find("input[name='itemea']").val());
			realitemea = parseInt(parentstr2.find("input[name='realitemea']").val());
			itemMile = parseInt(parentstr2.find("input[name='imileage']").val());
			if(!itemprc) itemprc=0; if(!itemea) itemea=0;

			if(mtypflag=="m") mileprc = itemprc;
			if(dtypflag=="2") cDlvFree=true;

			vTotItemPrc += (itemprc * realitemea) - mileprc;
			vTotItemEa += realitemea;
			vTotMilePrc += mileprc;
			vTotItemMile += itemMile*realitemea;
			vTotItemCnt++;
			itemcnt++;
		}

		// 정책별 기준 취합
		var vMix = $(this).attr("mix");
		var vGrpDlvLmt = $("#grpDlvLmt"+vMix).val();
		var vGrpDlvPrc = $("#grpDlvPrc"+vMix).val();
		var cNew = -1;
		for(var i in aDlvLmt) {
			cNew = -1;
			if(aDlvLmt[i][0]==vMix) {
				cNew = i;
				break;
			}
		}
		if(cNew<0) {
			if(vMix>6 && cDlvFree) vGrpDlvLmt=0;						// 업체조건 배송중 업배무료가 있으면 배송기준 0원
			aDlvLmt.push([vMix,(itemprc * realitemea),(mileprc * realitemea),itemcnt,vGrpDlvLmt,vGrpDlvPrc]);
		} else {
			aDlvLmt[cNew][1] = aDlvLmt[cNew][1]+(itemprc * realitemea);		// 상품가합
			aDlvLmt[cNew][2] = aDlvLmt[cNew][2]+(mileprc * realitemea);		// 마일리지 상품가합
			aDlvLmt[cNew][3] += itemcnt;								// 상품수(종류)
			if(vMix>6 && cDlvFree) aDlvLmt[cNew][4]=0;					// 업체조건 배송중 업배무료가 있으면 배송기준 0원
		}
		
	});

	// 정책별 합계 출력
	for(var i in aDlvLmt) {
		vTotDlvPrc += fnPrintGroupTotal(aDlvLmt[i][0],aDlvLmt[i][1],aDlvLmt[i][2],aDlvLmt[i][3],aDlvLmt[i][4],aDlvLmt[i][5]);
	}
	// 해외배송시 해외배송비
	if($("#iemsPrice").val()) {
		if(vTotItemPrc>0) {
			vTotDlvPrc = parseInt($("#iemsPrice").val());
		} else {
			vTotDlvPrc = parseInt($("#iemsPrice").val());
		}
	}
	<% if IsArmyDlv then %>
		if(vTotItemPrc>0) {
			vTotDlvPrc = <%=C_ARMIDLVPRICE%>;
		} else {
			vTotDlvPrc = 0;
		}
	<% elseif (IsQuickDlv) then %>
	    if(vTotItemPrc>0) {
			vTotDlvPrc = <%=C_QUICKDLVPRICE%>;
		} else {
			vTotDlvPrc = 0;
		}
	<% end if %>

	var vPrtStr="";

	// 총 상품합계
	vPrtStr = '<li>';
	vPrtStr += '	<span class="ftLt">상품 총 금액(' + vTotItemCnt + '개)</span>';
	vPrtStr += '	<strong class="ftRt">' + plusComma(vTotItemPrc) + '원</strong>';
	vPrtStr += '</li>';
	vPrtStr += '<li>';
	if($("#iemsPrice").val()) {
		vPrtStr += '	<span class="ftLt">해외 배송비</span>';
		vPrtStr += '	<strong class="ftRt"><span id="sp_emsPriceTTL">' + plusComma(vTotDlvPrc) + '</span>원</strong>';
	} else {
		vPrtStr += '	<span class="ftLt">배송비</span>';
		vPrtStr += '	<strong class="ftRt">' + plusComma(vTotDlvPrc) + '원</strong>';
	}
	vPrtStr += '</li>';
	$("#lyrTotalItem").html("<ul class='priceList'>"+vPrtStr+"</ul>");

	// 총 주문액
	vPrtStr = '<span class="fs13 cr777">(적립 마일리지 ' + plusComma(vTotItemMile) + ' P)</span>';
	vPrtStr += '	<strong class="lPad10">';

	if(vTotMilePrc>0) {
		vPrtStr += '마일리지샵 금액 <span class="crRed lPad10"><em class="fs20">' + plusComma(vTotMilePrc) + '</em>P</span>';
		vPrtStr += '	<em><img src="http://fiximage.10x10.co.kr/web2013/cart/ico_plus.gif" alt="더하기" /></em>';
		vPrtStr += '	<dd>' + plusComma(vTotMilePrc) + 'P</dd>';
		vPrtStr += '</dl>';
	}
	<% if IsForeignDlv then %>
		vPrtStr += '	결제 예정 금액 <span class="crRed lPad10"><em class="fs20"><span id="sp_ForeignPriceTTL">' + plusComma(vTotItemPrc+vTotDlvPrc) + '</span></em>원</span></strong>';
	<% else %>
		vPrtStr += '	결제 예정 금액 <span class="crRed lPad10"><em class="fs20">' + plusComma(vTotItemPrc+vTotDlvPrc) + '</em>원</span></strong>';
	<% end if %>
	$("#lyrTotalOrder").html(vPrtStr);
	
}

// 그룹별 소계 출력
function fnPrintGroupTotal(vMix,vTotal,vMile,vCnt,vLimit,vDlv) {
	var vDlvTot=0, vPrtStr="";
	var grpDlvname = $("#grpDlvname"+vMix).val();
	var vArmyDlvTot

	if((vTotal)>0 && (vTotal-vMile)<vLimit) {
		vDlvTot += parseInt(vDlv);
	} else if(vMix=="1" && vCnt>0) {
		vDlvTot += parseInt(vDlv);
	}
	
	if(vTotal>0){
        <% if (IsArmyDlv) then %>
		vArmyDlvTot = <%=C_ARMIDLVPRICE%>;
	    <% elseif IsQuickDlv  then %>
	    vArmyDlvTot = <%=C_QUICKDLVPRICE%>; 
	    <% else %>
	    vArmyDlvTot = 0;   
	    <% end if%>
	}else{
		vArmyDlvTot = 0;
	}
	
	if(vMix=="3") {
		<% if (IsForeignDlv) then %>
			vPrtStr += '<p class="cr555">' + grpDlvname + ' 합계금액 <strong>' + plusComma(vTotal) + '</strong>원 = 총 합계 <strong>' + plusComma(vTotal) + '</strong>원</p>';
		<% elseif (IsArmyDlv or IsQuickDlv) then %>
			vPrtStr += '<p class="cr555">' + grpDlvname + ' 합계금액 <strong>' + plusComma(vTotal) + '</strong>원 + 배송비 <strong>' + plusComma(vArmyDlvTot) + '</strong>원 = 총 합계 <strong>' + plusComma(vTotal+vArmyDlvTot) + '</strong>원</p>';
		<% else %>
			vPrtStr += '<p class="cr555">' + grpDlvname + ' 합계금액 <strong>' + plusComma(vTotal-vMile) + '</strong>원 + 배송비 <strong>' + plusComma(vDlvTot) + '</strong>원 = 총 합계 <strong>' + plusComma(vTotal+vDlvTot-vMile) + '</strong>원</p>';
			if(vMile>0) {
				vPrtStr += '<p>마일리지샵 상품합계 <span class="cBk1V16a">' + plusComma(vMile) + '</span>P</p>';
			}
		<% end if %>
	} else if(vMix=="6") {
		vPrtStr += '<p class="cr555">' + grpDlvname + ' 합계금액 <strong>' + plusComma(vTotal) + '</strong>원 + 배송비 착불 부과 = 총합계 <strong>' + plusComma(vTotal+vDlvTot) + '</strong>원</p>';
	} else {
		vPrtStr += '<p class="cr555">' + grpDlvname + ' 합계금액 <strong>' + plusComma(vTotal) + '</strong>원 + 배송비 <strong>' + plusComma(vDlvTot) + '</strong>원 = 총 합계 <strong>' + plusComma(vTotal+vDlvTot) + '</strong>원</p>';
	}

	// 그룹합 출력
	$("#grpTot"+vMix).html(vPrtStr);

	return vDlvTot;	// 총 배송비 반환
}

let appier_shoppingbag_products = new Array();
let appier_shoppingbag_product = {};
</script>

<%
	'RecoPick 스크립트 incFooter.asp에서 출력; 2013.12.05 허진원 추가
	'레코픽 서비스 종료에 따른 제거(150630 원승현)
	Dim r, rcpItem
'	If oshoppingbag.FShoppingBagItemCount > 0 Then
'		For r = 0 to oshoppingbag.FShoppingBagItemCount -1
			'recoPick용
'			rcpItem = rcpItem & chkIIF(rcpItem="","",", ") & "{id: '" & oshoppingbag.FItemList(r).FItemID & "', count: " & oshoppingbag.FItemList(r).FItemEa & "}"
'		Next
'	End If
	'RecoPick 스크립트 incFooter.asp에서 출력; 2013.12.05 허진원 추가
'	if rcpItem<>"" then RecoPickSCRIPT = "	recoPick('sendLog', 'basket', " & rcpItem & ");"

	'// 구글 ADS 스크립트 관련(2017.05.29 원승현 추가)
	Dim ADSItem
	If oshoppingbag.FShoppingBagItemCount > 0 Then
		For r = 0 to oshoppingbag.FShoppingBagItemCount -1
			ADSItem = ADSItem &"'"&oshoppingbag.FItemList(r).FItemID&"',"
		Next
		If ADSItem <> "" Then
			If oshoppingbag.FShoppingBagItemCount > 1 Then
				ADSItem = "["&Left(ADSItem, Len(ADSItem)-1)&"]"
			Else
				ADSItem = Left(ADSItem, Len(ADSItem)-1)
			End If
		End If
	End If
	if ADSItem = "" then
		ADSItem = "''"
	end if	
%>

</head>
<body>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container">
		<div id="contentWrap">
			<div class="cartWrap">
				<div class="cartHeader">
					<div class="orderStep">
						<h2><span class="step01">장바구니</span></h2>
						<span class="step02">주문결제</span>
						<span class="step03">주문완료</span>
					</div>
					<% if (isBaguniUserLoginOK) then %>
					<dl class="myBenefitBox">
						<dt><strong><%= GetLoginUserName %></strong>님 <span class="<%= GetUserLevelCSSClass() %>"><strong>[<%= GetUserLevelStr(GetLoginUserLevel) %>]</strong></span>의 쇼핑혜택</dt>
						<dd>
							<ul>
								<li><strong class="crRed"><%= FormatNumber(oMileage.FTotalMileage,0) %> P</strong><span>마일리지</span></li>
								<li><strong class="crRed"><%= FormatNumber(oSailCoupon.FTotalCount,0) %>장</strong><span>보너스 쿠폰</span></li>
								<li><strong class="crRed"><%= FormatNumber(oItemCoupon.FTotalCount,0) %>장</strong><span>상품쿠폰</span></li>
								<% if (availtotalTenCash>0) then %>
								<li><strong class="cr000"><%= FormatNumber(availtotalTenCash,0) %>원</strong><span>예치금</span></li>
								<% end if %>
								<% if (availTotalGiftMoney>0) then %>
								<li><strong class="cr000"><%= FormatNumber(availTotalGiftMoney,0) %>원</strong><span>기프트 카드</span></li>
								<% end if %>
							</ul>
						</dd>
					</dl>
					<% end if %>
				</div>
				<div class="overHidden tPad10">
					<ul class="cartTab">
						<li class="domestic<%=CHKIIF(IsLocalDlv," selected","")%>" onClick="document.location.href='ShoppingBag.asp'"><p><span><strong>배송전체</strong><!--(<strong><%=sBagCount%></strong>)--></span></p></li>
						<% if (ISQuickDlvUsing) then %>
						<li class="baro<%=CHKIIF(IsQuickDlv," selected","")%>" onClick="document.location.href='ShoppingBag.asp?bTp=q'"><p><span><strong>바로배송</strong><!--(<strong><%=sBagCount%></strong>)--></span></p></li>
						<% end if %>
						<li class="abroad<%=CHKIIF(IsForeignDlv," selected","")%>" onClick="document.location.href='ShoppingBag.asp?bTp=f'"><p><span><strong>해외배송</strong></span></p></li>
						<% if (ISArmyDlvUsing) then %>
						<li class="military<%=CHKIIF(IsArmyDlv," selected","")%>" onClick="document.location.href='ShoppingBag.asp?bTp=a'"><p><span><strong>군부대배송</strong><!--(<strong><%=sBagCount%></strong>)--></span></p></li>
						<% end if %>
					</ul>
					<% if (isBaguniUserLoginOK) then %>
					<% if Not oshoppingbag.IsShoppingBagVoid then %>
					<p class="goMyWish tMar25"><a href="/my10x10/mywishlist.asp"><img src="http://fiximage.10x10.co.kr/web2013/common/btn_mywish.png" alt="MY WISH" /></a></p>
					<% end if %>
					<% end if %>
				</div>
				<form name="baguniFrm" method="post" action="/inipay/shoppingbag_process.asp" onSubmit="return false" >
				<input type="hidden" name="mode" value="">
				<input type="hidden" name="bTp" value="<%=bTp%>">
				<div class="cartBox">
					<% if oshoppingbag.IsShoppingBagVoid then %>
					<div class="cartBlank ct">
						<% if (IsForeignDlv) then %>
						<p><img src="http://fiximage.10x10.co.kr/web2013/cart/cart_blank3.png" alt="OOPS! 해외배송 가능한 상품이 없습니다." /></p>
						<p class="tPad15">해외배송 가능 여부는 상품 페이지의 배송구분란에서 확인하실 수 있습니다.</p>
						<p class="tPad05"><a href="/cscenter/oversea/emsIntro.asp" class="addInfo" onclick=""><em>해외배송 서비스 안내</em></a></p>
						<% elseif (IsArmyDlv) then %>
						<p><img src="http://fiximage.10x10.co.kr/web2013/cart/cart_blank2.png" alt="충성! 군부대배송 가능한 상품이 없습니다." /></p>
						<p class="tPad15">군부대 배송은 텐바이텐 배송상품만 가능합니다.<br />텐바이텐 배송상품 여부는 상품 페이지의 배송구분란에서 확인하실 수 있습니다.</p>
						<% elseif (IsQuickDlv) then %>
						<p><img src="http://fiximage.10x10.co.kr/web2017/cart/cart_blank4.png" alt="앗! 바로배송 가능한 상품이 없습니다." /></p>
						<p class="tPad15">바로배송은 서울 지역 한정, 주문 당일 12시(정오)전 결제완료된 주문에만 적용되며, <br />12시 이후 신청 시 다음날 배송이 시작됩니다.</p>
						<% else %>
						<p><img src="http://fiximage.10x10.co.kr/web2013/cart/cart_blank.png" alt="앗! 장바구니에 담긴 상품이 없습니다." /></p>
						<p class="tPad15">장바구니는 접속 종료 후 14일 동안만 보관 됩니다.<br />더 오래 보관하고 싶은 상품은 위시리스트에 담아주세요.</p>
						<% end if %>
						<p class="tPad30 bPad20"><a href="/" class="btn btnB1 btnRed btnW180"><em class="whiteArr01">계속 쇼핑하기</em></a></p>
					</div>
					<% else %>

						<% '//2월 구매사은품 배너 '/2016-02-03 원승현 %>
						<% if date>="2016-02-04" and date<"2016-02-11" Then %>
							<p style="margin:20px 0 30px;"><a href="/event/eventmain.asp?eventid=68950"><img src="http://webimage.10x10.co.kr/eventIMG/2016/68950/img_bnr.jpg" alt="2월 구매사은이벤트 텐바이텐 배송상품 포함하여 10만원 이상 구매시, 멀티비타민 오렌지맛 구미를 사은품으로 드립니다. 한정수량으로 조기 소진 될 수 있습니다" /></a></p>
						<% End If %>
					<!-- <div style="position:relative; margin:20px 0 30px;">
						<img src="http://fiximage.10x10.co.kr/web2021/diary2022/bnr_diary2022_shopping_02.png" alt="2022 다이어리 구매하고 특별한 선물 받아가세요!" />
						<a href="/diarystory2022/" target="_blank" style="position:absolute; top:110px; right:46px; width:130px; height:40px; text-indent:-10000px;">자세히보기</a>
					</div> -->
					<% ''IDX 0: 티켓, 1:Present상품, 2:현장수령 상품, 3:텐바이텐 배송, 4:업체 배송 5:업체 개별 배송 6:업체 착불배송 %>
<!-------------------------------------->
<%
dim Mix, MidxSub
MidxSub = 0
Dim idrwCnt : idrwCnt= 0
%>
<%
function DrawBaguniSubList()
    Dim doNothing : doNothing=True
    Dim iDlvTypeStr : iDlvTypeStr = getBaguniConstStringName(Mix)
    Dim j,k : j=0 : k=1
    Dim pmakerid,pdlvPrice, pdlvDispStr, pitemprice

    if IsForeignDlv then
        iDlvTypeStr = "해외 배송 상품"
    elseif IsArmyDlv then
        iDlvTypeStr = "군부대 배송 상품"
    elseif IsQuickDlv then
        iDlvTypeStr = "바로 배송 상품"
    end if

    if (Mix=5) then ''업체 조건배송
        oshoppingbag.GetParticleBeasongInfoDB
        k = oshoppingbag.FParticleBeasongUpcheCount
    end if

    for j=0 to k-1
        if (Mix=5) then
            MidxSub = MidxSub+1
            pmakerid = oshoppingbag.FParticleBeasongUpcheList(j).FMakerid
            pdlvPrice = oshoppingbag.getUpcheParticleItemBeasongPrice(pmakerid)
            pdlvDispStr = oshoppingbag.FParticleBeasongUpcheList(j).getDeliveryPayDispHTML
            pitemprice = oshoppingbag.GetCouponNotAssingUpcheParticleItemPrice(pmakerid)
        end if
        idrwCnt = idrwCnt+1
%>

	<div class="<%=CHKIIF(idrwCnt=1,"overHidden tMar10","overHidden tMar55")%>" id="bagGrpTitle<%=j%>">
		<h3><%= iDlvTypeStr %></h3>
		<% if (Mix=0) then %>
		<span class="fs11 ftLt tPad05 lPad10 cr777">티켓예매는 일반상품과 함께 구매가 안되며, 티켓만 단독으로 주문하셔야 합니다.</span>
		<% elseif (Mix=1) then %>
		<span class="fs11 ftLt tPad05 lPad10 cr777">10X10 Present 상품은 일반상품과 함께 주문되지 않으며, <span class="red_11px">단독으로 주문</span>하셔야 합니다.</span>
		<% elseif (Mix=2) then %>
		<span class="fs11 ftLt tPad05 lPad10 cr777">배송 없이 지정된 현장에서 직접 수령합니다. 현장수령상품은 단독으로 주문하셔야 합니다.</span>
		<% elseif (Mix=3) then %>
			<% if (IsLocalDlv) then %>
			<% if (isBaguniUserLoginOK) and (oshoppingbag.getFreeBeasongLimit>1) then %>
			<span class="fs11 ftLt tPad05 lPad10 cr777"><%= FormatNumber(oshoppingbag.getFreeBeasongLimit,0) %>원 이상 구매시 무료배송 <!-- / 해외배송됩니다. --></span>
			<% end if %>
			<% elseif (IsForeignDlv) then %>
			<span class="fs11 ftLt tPad05 lPad10 cr777">해외 배송비는 <span class="crRed">배송 국가와 상품의 중량에 따라 부과</span>됩니다. (배송방법 : EMS)</span>
			<% elseif (IsArmyDlv) then %>
			<span class="fs11 ftLt tPad05 lPad10 cr777">군부대 주문은 우체국 택배 이용으로 구매금액과 상관없이 <span class="crRed">배송비 3,000원이 부과</span>됩니다.</span>
			<% end if %>
			
			<% if (ISQuickDlvUsing) AND ((IsLocalDlv and oshoppingbag.IsQuickAvailItemExists) or IsQuickDlv) then %>
			<div class="infoMoreViewV15" style="z-index:98;">
				<span class="btn btnS3 btnGry fn lMar10 tMar04"><em class="whiteArr01">바로배송 안내</em></span>
				<div class="infoViewLyrV15">
					<div class="infoViewBoxV15">
						<dfn></dfn>
						<div class="infoViewV15">
							<div class="pad20">
								<p>오전에 주문한 상품을 그날 오후에 바로 받자!<br />서울 전 지역 한정, 오후 1시까지 주문/결제를 완료할 경우 신청할 수 있는 퀵배송 서비스입니다.</p>
								<p class="tMar10">
								<% if (C_QUICKDLVPRICE=5000) then %>
								<strong>바로배송 배송료 : <span class="cRd0V15"><%=FormatNUMBER(C_QUICKDLVPRICE,0)%>원</span></strong><br />
								<% else %>
								<strong>바로배송 배송료 : <del class="cGy1V15">5,000원</del> <span class="cRd0V15"><%=FormatNUMBER(C_QUICKDLVPRICE,0)%>원</span></strong><br /><span class="cGy1V15">(오픈기념 이벤트 할인중, 2018년 7월 18일까지)</span>
								<% end if %>
								</p>
								<p class="tPad15"><a href="/shoppingtoday/barodelivery.asp" class="more1V15" style="color:#888; text-decoration:underline; cursor:pointer;">바로배송 상품 전체보기</a></p>
								<ul class="list01V15 tMar15">
									<li>바로배송은 배송지가 서울 지역일 경우 가능합니다.</li>
									<li>주문 당일 오후 1시전 결제완료된 주문에만 신청 가능하며, 오후 1시 이후 신청 시 다음날 배송이 시작됩니다.</li>
									<li>더욱 더 빠른 배송 서비스를 위해 주말/공휴일에는 쉽니다.</li>
									<li>상품의 부피/무게에 따라 배송 유/무 또는 요금이 달라질 수 있습니다.</li>
									<li>바로배송 서비스에는 무료배송쿠폰을 적용할 수 없습니다.</li>
									<li>회사 또는 사무실로 주문하시는 경우, <span class="cRd0V15">퇴근 시간 이후 배송될 수도 있습니다.</span> 오후 늦게라도 상품 수령이 가능한 주소지를 입력해주시면 감사하겠습니다.</li>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
			<% end if %>
		<% elseif (Mix=4) then %>

		<% elseif (Mix=5) then %>
		<span class="fs12 ftLt tPad03 lPad10 cr777">
		<% if (pdlvPrice<1) then %>
		무료배송
		<% else %>
		<%=pdlvDispStr%>
		<% end if %>
		</span>
		<% if (pdlvPrice>0) then %>
		<a href="/street/street_brand.asp?makerid=<%= pMakerid %>" class="ftRt btn btnS3 btnGry fn rMar05"><em class="whiteArr01">배송비 절약 상품</em></a>
		<% end if %>
		<% elseif (Mix=6) then %>
		<span class="fs11 ftLt tPad05 lPad10 cr777">배송지역에 따라 배송비가 착불로 부가 됩니다.</span>
		<% elseif (Mix=8) then %>
		<a href="/shopping/pop_rental_info.asp" onclick="window.open(this.href, 'popbenefit', 'width=1000,height=800,left=300,scrollbars=auto,resizable=yes'); return false;" class="btn-view-rental"><img src="http://fiximage.10x10.co.kr/web2020/common/icon_help_circle.png" alt="이니렌탈 안내"></a><!-- for dev msg : 버튼 선택시 이니렌탈 안내창 노출 -->		
		<span class="fs11 ftLt tPad05 lPad10 cr777">이니렌탈 상품은 일반 상품과 함께 구매가 되지 않으며 렌탈 상품만 단독으로 주문하셔야 합니다.</span>
		<% end if %>
	</div>

	<table class="baseTable tMar10" id="bagGrpItem<%=j%>">
		<caption>장바구니 목록(<%= iDlvTypeStr %>)</caption>
		<colgroup>
			<col width="35px" /><col width="70px" /><col width="55px" /><col width="" /><col width="110px" /><col width="80px" /><col width="95px" /><col width="95px" /><col width="110px" /><col width="120px" />
		</colgroup>
	<thead>
		<tr>
			<th><input type="checkbox" name="chk_item<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" onClick="fnCheckAll(this);" /></th>
			<% if Mix=0 then %>
			<th>상품코드</th>
			<th colspan="2">공연명</th>
			<th>티켓가</th>
			<th>수량</th>
			<th>티켓금액</th>
			<th>마일리지</th>
			<th>쿠폰</th>
			<th></th>
			<% elseif Mix=8 Then %>
			<th>상품코드</th>
			<th colspan="3">상품정보</th>
			<th></th>
			<th>수량</th>
			<th colspan="2">이니렌탈 시</th>
			<th></th>			
			<% else %>
			<th>상품코드</th>
			<th colspan="2">상품정보</th>
			<th>판매가격</th>
			<th>수량</th>
			<th>주문금액</th>
			<th>마일리지</th>
			<th>쿠폰</th>
			<th></th>
			<% end if %>
		</tr>
		</thead>
		<tbody>
		<%
			for i=0 to oshoppingbag.FShoppingBagItemCount -1
				doNothing = True

                if (Mix=0) then if (oshoppingbag.FItemList(i).IsTicketItem) then doNothing = FALSE
                if (Mix=1) then if (oshoppingbag.FItemList(i).IsPresentItem) then doNothing = FALSE
                if (Mix=2) then if (oshoppingbag.FItemList(i).IsReceiveSite) then doNothing = FALSE
                if (Mix=3) then if ((Not oshoppingbag.FItemList(i).IsReceivePayItem ) and (Not oshoppingbag.FItemList(i).IsUpcheBeasong) and (Not oshoppingbag.FItemList(i).IsUpcheParticleBeasong) and (Not oshoppingbag.FItemList(i).IsTicketItem) and Not(oshoppingbag.FItemList(i).IsReceiveSite) and Not(oshoppingbag.FItemList(i).IsPresentItem)  and Not(oshoppingbag.FItemList(i).IsTravelItem) and Not(oshoppingbag.FItemList(i).IsRentalItem)) then doNothing = FALSE
                if (Mix=4) then if (oshoppingbag.FItemList(i).IsUpcheBeasong) and Not(oshoppingbag.FItemList(i).IsTravelItem) then doNothing = FALSE
                if (Mix=6) then if (oshoppingbag.FItemList(i).IsReceivePayItem) then doNothing = FALSE
                if (Mix=7) then if (oshoppingbag.FItemList(i).IsTravelItem) then doNothing = FALSE
				if (Mix=8) then if (oshoppingbag.FItemList(i).IsRentalItem) then doNothing = FALSE

                if (Mix=5) then if ( oshoppingbag.FItemList(i).IsUpcheParticleBeasong) and (LCase(pMakerid)=LCase(oshoppingbag.FItemList(i).FMakerid)) then doNothing = FALSE

                if (IsForeignDlv) then
                    doNothing = True
                    if (oshoppingbag.FItemList(i).IsForeignDeliverValid) then doNothing = FALSE
                end if


'				if ((Mix=1) and (oshoppingbag.FItemList(i).IsPresentItem)) _
'				or ((Mix=2) and (oshoppingbag.FItemList(i).IsReceiveSite)) _
'				or ((Mix=3) and (Not oshoppingbag.FItemList(i).IsReceivePayItem ) and (Not oshoppingbag.FItemList(i).IsUpcheBeasong) and (Not oshoppingbag.FItemList(i).IsUpcheParticleBeasong) and (Not oshoppingbag.FItemList(i).IsTicketItem) and Not(oshoppingbag.FItemList(i).IsReceiveSite) and Not(oshoppingbag.FItemList(i).IsPresentItem)) _
'				or ((Mix=4) and (oshoppingbag.FItemList(i).IsUpcheBeasong)) _
'				or ((Mix=6) and (oshoppingbag.FItemList(i).IsReceivePayItem))  then


				TicketBookingExired = FALSE
				if (Mix=0) then
                    set oTicketItem = new CTicketItem
                    oTicketItem.FRectItemID = oshoppingbag.FItemList(i).FItemID
                    oTicketItem.GetOneTicketItem
                    IF (oTicketItem.FResultCount>0) then
                        TicketBookingExired = oTicketItem.FOneItem.IsExpiredBooking
                    END IF
                    set oTicketItem = Nothing
               end if

               if Not (doNothing) Then
		%>

		<script>
            appier_shoppingbag_product = {};

            appier_shoppingbag_product.product_id = "<%=oshoppingbag.FItemList(i).FItemID%>";
            appier_shoppingbag_product.product_name = "<%= Replace(oshoppingbag.FItemList(i).FItemName, """", "") %>";
            appier_shoppingbag_product.product_image_url = "<%=oshoppingbag.FItemList(i).FImageList%>";
            appier_shoppingbag_product.product_url = "https://m.10x10.co.kr/category/category_itemPrd.asp?itemid=<%= oshoppingbag.FItemList(i).FItemID %>&gaparam=cart_list";
            appier_shoppingbag_product.product_price = parseInt("<%=oshoppingbag.FItemList(i).GetCouponAssignPrice%>");
            appier_shoppingbag_product.category_name_depth1 = "<%=oshoppingbag.FItemList(i).Ffirst_depth_cate%>";
            appier_shoppingbag_product.category_name_depth2 = "<%=oshoppingbag.FItemList(i).Fsecond_depth_cate%>";
            appier_shoppingbag_product.brand_id = "<%=oshoppingbag.FItemList(i).FMakerID%>";
            appier_shoppingbag_product.brand_name = "<%=oshoppingbag.FItemList(i).FBrandName%>";
            appier_shoppingbag_product.quantity = parseInt("<%=oshoppingbag.FItemList(i).FItemEa%>");
            appier_shoppingbag_product.product_variant = "<%=oshoppingbag.FItemList(i).FItemOptionName%>";
<%
            DIM appier_total_price

            IF (IsForeignDlv) then
                appier_total_price = oshoppingbag.GetCouponAssignTotalItemPrice-oshoppingbag.GetMileageShopItemPrice
            ELSEIF (IsArmyDlv) then
                appier_total_price = oshoppingbag.GetTenDeliverItemPrice
            ELSEIF (IsQuickDlv) then
                appier_total_price = oshoppingbag.GetTenDeliverItemPrice
            ELSE
                appier_total_price = oshoppingbag.GetCouponAssignTotalItemPrice-oshoppingbag.GetMileageShopItemPrice
            END IF
%>
            appier_shoppingbag_product.total_goods_price = parseInt("<%=appier_total_price%>");

            appier_shoppingbag_products.push(appier_shoppingbag_product);
        </script>

		<input type="hidden" name="itemkey" value="<%=oshoppingbag.FItemList(i).FItemID %>_<%=oshoppingbag.FItemList(i).FItemOption %>">
        <input type="hidden" name="itemid" value="<%= oshoppingbag.FItemList(i).FItemID %>">
        <input type="hidden" name="itemoption" value="<%= oshoppingbag.FItemList(i).FItemoption %>">
        <input type="hidden" name="soldoutflag" value="<% if (oshoppingbag.FItemList(i).IsSoldOut) or (TicketBookingExired) then response.write "Y" else response.write "N" end if %>">
        <input type="hidden" name="maxnoflag" value="<%=chkIIF(oshoppingbag.FItemList(i).ISsoldOut,"0",oshoppingbag.FItemList(i).GetLimitOrderNo)%>">
        <input type="hidden" name="minnoflag" value="<%=chkIIF(oshoppingbag.FItemList(i).ISsoldOut,"0",oshoppingbag.FItemList(i).GetMinumOrderNo)%>">
        <input type="hidden" name="foreignflag" value="<% if oshoppingbag.FItemList(i).IsForeignDeliverValid then response.write "Y" else response.write "N" end if %>">
        <input type="hidden" name="requiredetail" value="<%= doubleQuote(oshoppingbag.FItemList(i).getRequireDetail) %>" />
        <% if (oshoppingbag.FItemList(i).IsUpcheBeasong) or (oshoppingbag.FItemList(i).IsReceivePayItem) or (oshoppingbag.FItemList(i).Fdeliverytype="2") then %>
        <input type="hidden" name="dtypflag" value="2">
        <% elseif (oshoppingbag.FItemList(i).IsUpcheParticleBeasong) then %>
        <input type="hidden" name="dtypflag" value="3">
        <% elseif (oshoppingbag.FItemList(i).IsTicketItem) or (oshoppingbag.FItemList(i).IsPresentItem) or (oshoppingbag.FItemList(i).IsReceiveSite) then %>
        <input type="hidden" name="dtypflag" value="0">
        <% else %>
        <input type="hidden" name="dtypflag" value="1">
        <% end if %>
        <% if oshoppingbag.FItemList(i).Is09Sangpum then %><input type="hidden" name="mtypflag" value="o">
        <% elseif oshoppingbag.FItemList(i).IsTicketItem then %><input type="hidden" name="mtypflag" value="t">
        <% elseif oshoppingbag.FItemList(i).IsPresentItem then %><input type="hidden" name="mtypflag" value="p">
        <% elseif oshoppingbag.FItemList(i).IsMileShopSangpum then %><input type="hidden" name="mtypflag" value="m">
        <% elseif oshoppingbag.FItemList(i).IsReceiveSite then %><input type="hidden" name="mtypflag" value="r">
        <% else %><input type="hidden" name="mtypflag" value=""><% end if %>
        <% if (oshoppingbag.FItemList(i).ISFujiPhotobookItem) and (oshoppingbag.FItemList(i).getPhotobookFileName="") then %><input type="hidden" name="nophothofileflag" value="1">
        <% else %><input type="hidden" name="nophothofileflag" value="0"><% end if %>
		<tr mix="<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>">
			<input type="hidden" name="isellprc" value="<%= oshoppingbag.FItemList(i).getRealPrice %>">
			<input type="hidden" name="ifinalprc" value="<%= oshoppingbag.FItemList(i).GetCouponAssignPrice %>">
			<input type="hidden" name="imileage" value="<%=chkIIF(IsUserLoginOK(),oshoppingbag.FItemList(i).FMileage,"0") %>">
			<input type="hidden" name="cPlusale" value="<%=chkIIF(oshoppingbag.FItemList(i).IsPLusSaleItem,"true","false")%>">
			<td class="rt"><input type="checkbox" <%=chkIIF(oshoppingbag.FItemList(i).ISsoldOut or TicketBookingExired,"disabled='disabled'","")%> name="chk_item" id="<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" value="<%= idx %>" mix="<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" adultType="<%=oshoppingbag.FItemList(i).FAdultType%>" /></td>
			<td><%= oshoppingbag.FItemList(i).FItemID %></td>
			<td><img src="<%= oshoppingbag.FItemList(i).FImageSmall %>" width="50px" height="50px" onClick="location.href='/shopping/category_prd.asp?itemid=<%= oshoppingbag.FItemList(i).FItemID %>&gaparam=cart_list'" style="cursor:pointer"/></td>
			<td class="lt">
				<p>
				<% if oshoppingbag.FItemList(i).IsPLusSaleItem then %>
            		<span class="crRed">[<strong>+</strong> Sale 상품]</span>
            	<% end if %>
            	<% if oshoppingbag.FItemList(i).IsMileShopSangpum then %>
            		<span class="crRed">[마일리지샵상품]</span>
            	<% end if %>
            	<% if oshoppingbag.FItemList(i).Is09Sangpum then %>
            		<span class="crRed">[단독구매상품]</span>
            	<% end if %>
            	<% if (oshoppingbag.FItemList(i).IsFreeBeasongItem) then %>
            		<% if (oshoppingbag.FItemList(i).FMakerid<>"goodovening") then %>
            		<span class="crRed">[무료배송상품]</span>
            		<% end if %>
            	<% end if %>
            	<% if (oshoppingbag.FItemList(i).IsSpecialUserItem) then %>
            		<span class="crRed">[우수회원샵상품]</span>
            	<% end if %>
            	<% if (IsPercentBonusCouponExists and (oshoppingbag.FItemList(i).IsUnDiscountedMarginItem and Not oshoppingbag.FItemList(i).IsMileShopSangpum )) then %>
            		<span class="crGrn">[%보너스쿠폰제외상품]</span>
            	<% end if %>
            	<% if (oshoppingbag.FItemList(i).IsBuyOrderItem) then %>
            		<span class="crBlu">[선착순구매상품]</span>
            	<% end if %>
            	<% if (oshoppingbag.FItemList(i).IsForeignDeliverValid) then %>
            		<span class="crBlu">[해외배송가능]</span>
            	<% end if %>
            	<% if (ISQuickDlvUsing) AND (oshoppingbag.FItemList(i).IsQuickAvailItem) then %>
            		<span class="crBlu">[바로배송가능]</span>
            	<% end if %>
            	
				<%
				'선물포장서비스 노출
				if G_IsPojangok then
				%>
					<% if not(IsForeignDlv) and not(IsArmyDlv) then %>
						<% if (oshoppingbag.FItemList(i).FPojangOk="Y") then %>
							<span class="cPk0V15">[선물포장가능]</span>
						<% end if %>
					<% end if %>
				<% end if %>

				</p>
				<% if (oshoppingbag.FItemList(i).ISFujiPhotobookItem) then %>
                <% if oshoppingbag.FItemList(i).getPhotobookFileName="" then NotEditPhotobookExists=True %>
                <p class="tPad05"><a href="" class="btn btnS4 btnGry2 fn" onClick="editOrderPhotolooks('<%= oshoppingbag.FItemList(i).FItemid %>','<%= oshoppingbag.FItemList(i).FItemoption %>','<%= oshoppingbag.FItemList(i).getPhotobookFileName %>');return false;">포토북 수정</a></p>
                <!-- <p><img src="http://fiximage.10x10.co.kr/web2010/order/btn_photomodify.gif" width="52" height="13" border="0" onclick="editOrderPhotolooks('<%= oshoppingbag.FItemList(i).FItemid %>','<%= oshoppingbag.FItemList(i).FItemoption %>','<%= oshoppingbag.FItemList(i).getPhotobookFileName %>');" style="cursor:pointer" align="top" style="margin-bottom:2px;"></p> -->
                <% end if %>
				<p class="tPad05"><%= oshoppingbag.FItemList(i).FItemName %></p>
				<p class="tPad02"><% if oshoppingbag.FItemList(i).getOptionNameFormat<>"" then %><%= oshoppingbag.FItemList(i).getOptionNameFormat %><% end if %></p>

			</td>
			<% If Mix=8 Then %>
				<td></td>
				<td></td>
			<% Else %>
				<td>
					<% if oshoppingbag.FItemList(i).IsMileShopSangpum then %>
						<%= FormatNumber(oshoppingbag.FItemList(i).getRealPrice,0) %>Pt
					<% else %>
						<% if (oshoppingbag.FItemList(i).IsSailItem) then %>
						<p class="txtML cr999"><%= FormatNumber(oshoppingbag.FItemList(i).FOrgPrice+oshoppingbag.FItemList(i).FoptAddPrice,0) %>원</p>
						<p class="crRed"><strong><%= FormatNumber(oshoppingbag.FItemList(i).getRealPrice,0) %>원</strong></p>
						<% else %>
							<%= FormatNumber(oshoppingbag.FItemList(i).getRealPrice,0) %>원
						<% end if %>
					<% end if %>
				</td>
			<% End If %>
			<td>
				<% if oshoppingbag.FItemList(i).IsMileShopSangpum then %>
				<%= oshoppingbag.FItemList(i).FItemEa %>
				<input name="itemea" type="hidden" value="<%=chkIIF(oshoppingbag.FItemList(i).ISsoldOut,"0",oshoppingbag.FItemList(i).FItemEa)%>" />
				<input name="realitemea" type="hidden" value="<%=chkIIF(oshoppingbag.FItemList(i).ISsoldOut,"0",oshoppingbag.FItemList(i).FItemEa)%>" />
				<% else %>
				<p>
				<input name="itemea" type="text" style="width:30px" class="txtInp ct" value="<%=chkIIF(oshoppingbag.FItemList(i).ISsoldOut,"0",oshoppingbag.FItemList(i).FItemEa)%>" Autocomplete="off" maxlength="5" />
				<input name="realitemea" type="hidden" value="<%=chkIIF(oshoppingbag.FItemList(i).ISsoldOut,"0",oshoppingbag.FItemList(i).FItemEa)%>" />
				<span class="orderNumAtc">
					<span><img src="http://fiximage.10x10.co.kr/web2013/common/btn_num_up.png" alt="갯수 더하기" onclick="addItemNo(<%= idx %>,1);" style="cursor:pointer" /></span>
					<span class="tPad02"><img src="http://fiximage.10x10.co.kr/web2013/common/btn_num_down.png" alt="갯수 빼기" onclick="addItemNo(<%= idx %>,-1);" style="cursor:pointer" /></span>
				</span>
				</p>
				<p class="tPad03"><a href="" class="btn btnS3 btnGry2 fn" style="width:41px;" onClick="EditItem('<%= idx %>');return false;">수정</a></p>
				<% end if %>
			</td>
			<% If Mix=8 Then %>
				<td colspan="2">
					<% if (oshoppingbag.FItemList(i).ISsoldOut) or (TicketBookingExired) then %>
						<span class="crRed">품절</span>
					<% else %>
						<% If Trim(oshoppingbag.FItemList(i).FRentalMonth) <> "0" Then %>
							<%=oshoppingbag.FItemList(i).FRentalMonth%>개월간 월 <%=FormatNumber(RentalPriceCalculationData(oshoppingbag.FItemList(i).FRentalMonth,oshoppingbag.FItemList(i).GetCouponAssignPrice*oshoppingbag.FItemList(i).FItemEa),0)%>원
						<% Else %>
							12개월간 월 <%=FormatNumber(RentalPriceCalculationData("12",oshoppingbag.FItemList(i).GetCouponAssignPrice*oshoppingbag.FItemList(i).FItemEa),0)%>원
						<% End If %>
					<% end if %>				
					<input type="hidden" name="chkolditemea" value="<%=chkIIF(oshoppingbag.FItemList(i).ISsoldOut,"0",oshoppingbag.FItemList(i).FItemEa)%>">
				</td>
			<% Else %>			
				<td>
					<% if (oshoppingbag.FItemList(i).ISsoldOut) or (TicketBookingExired) then %>
					<span class="crRed">품절</span>
					<% else %>
					<% if oshoppingbag.FItemList(i).IsMileShopSangpum then %>
						<%= FormatNumber(oshoppingbag.FItemList(i).GetRealPrice*oshoppingbag.FItemList(i).FItemEa,0) %>Pt
					<% else %>
						<%= FormatNumber(oshoppingbag.FItemList(i).GetRealPrice*oshoppingbag.FItemList(i).FItemEa,0) %>원
					<% end if %>
					<% end if %>
					<input type="hidden" name="chkolditemea" value="<%=chkIIF(oshoppingbag.FItemList(i).ISsoldOut,"0",oshoppingbag.FItemList(i).FItemEa)%>">
				</td>
				<td>
					<% if Not (isBaguniUserLoginOK) then %>회원 구매 시<br /><% end if %>
					<%= Formatnumber(CLng(oshoppingbag.FItemList(i).Fmileage)*oshoppingbag.FItemList(i).FItemEa,0) %> Point
				</td>
				<td>
					<% if (oshoppingbag.FItemList(i).FUserVaildCoupon) then %>
					<p class="crGrn"><%= oshoppingbag.FItemList(i).getCouponTypeStr %> <br />적용가</p>
					<p class="crGrn"><strong><%= FormatNumber(oshoppingbag.FItemList(i).GetCouponAssignPrice*oshoppingbag.FItemList(i).FItemEa,0) %>원</strong></p>
					<% elseif Not IsNULL(oshoppingbag.FItemList(i).Fcurritemcouponidx) then %>
					<p class="crGrn tPad05"><%= oshoppingbag.FItemList(i).getCouponTypeStr %><br /><a href="" class="btn btnS3 btnGrn btnW80 fn tMar03" onClick="DownloadCouponWithReload('<%= oshoppingbag.FItemList(i).Fcurritemcouponidx %>');return false"><em class="btnDown">쿠폰다운</em></a></p>
					<% end if %>
				</td>
			<% End If %>
			<td class="rt">
				<% if Not(oshoppingbag.FItemList(i).IsMileShopSangpum or oshoppingbag.FItemList(i).ISsoldOut) then %>
					<% if oshoppingbag.FItemList(i).isRentalItem then %>
						<p><a href="" class="btn btnS3 btnRed btnW70 fn" onclick="DirectOrder('<%= idx %>', '<%=oshoppingbag.FItemList(i).FAdultType%>');return false;">렌탈 하기</a></p>
					<% Else %>
						<p><a href="" class="btn btnS3 btnRed btnW70 fn" onclick="DirectOrder('<%= idx %>', '<%=oshoppingbag.FItemList(i).FAdultType%>');return false;">바로 주문</a></p>
					<% End If %>
				<% end if %>
				<% if (isBaguniUserLoginOK) then %>
				<p class="tPad03"><a href="" class="btn btnS3 btnWhite btnW70 fn" onclick="TnAddFavorite('<%= oshoppingbag.FItemList(i).FItemid %>');return false;" >위시 담기</a></p>
				<% end if %>
				<p class="tPad03"><a href="" class="btn btnS3 btnGry2 btnW70 fn" onclick="DelItem('<%= idx %>');return false;" ><em class="btnDel">삭제</em></a></p>
			</td>
		</tr>
		<% if (oshoppingbag.FItemList(i).IsManufactureSangpum) then %>
		<tr class="orderWord">
			<td class="bdrNone"></td>
			<td class="bdrNone"></td>
			<td colspan="7">
				<dl class="customWord">
					<dt><strong>주문제작문구</strong> :</dt>
					<dd>
						<% if (oshoppingbag.FItemList(i).IsManufactureSangpum) and (oshoppingbag.FItemList(i).getRequireDetail="") then %>
							<p>(! 주문제작문구를 넣어주세요.)</p>
							<% NotWriteRequireDetailExists = True %>
						<% else %>
							<%= oshoppingbag.FItemList(i).getRequireDetailHtml %>
						<% end if %>
					</dd>
				</dl>
			</td>
			<td class="rt vTop tPad03">
				<p class="tPad07"><a href="" class="btn btnS4 btnGry2 btnW70 fn lMar10" onClick="EditRequireDetail('<%= oshoppingbag.FItemList(i).FItemid %>','<%= oshoppingbag.FItemList(i).FItemoption %>');return false;">문구수정</a></p>
			</td>
		</tr>
		<% end if %>

			<% if (Mix=0) then iTicketItemCNT = iTicketItemCNT +1 end if %>
			<% if (Mix=1) then iPresentItemCNT = iPresentItemCNT +1 end if %>
			<% idx = idx +1 %>
			<% end if %>
		<% next %>
		</tbody>
		<tfoot>


		<% if (IsForeignDlv) then %>
		<tr>
			<td colspan="10" id="grpTot<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>">
				<p class="cr555 fs13"><%= iDlvTypeStr %> 합계금액 <strong><%= FormatNumber(oshoppingbag.GetCouponNotAssingTenDeliverItemPrice,0) %></strong>원 </p>
				<% if (oshoppingbag.IsMileShopSangpumExists) then %>
				<p class="tPad05 fs11">(마일리지샵 상품 합계 금액 <strong><%= FormatNumber(oshoppingbag.GetMileageShopItemPrice,0) %> Point</strong>)</p>
				<% end if %>
			</td>
			<input type="hidden" id="grpDlvLmt<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" name="grpDlvLmt<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" value="<%=oshoppingbag.getFreeBeasongLimit%>">
			<input type="hidden" id="grpDlvPrc<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" name="grpDlvPrc<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" value="<%=oshoppingbag.getTenDeliverItemBeasongPay%>">
			<input type="hidden" id="grpDlvname<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" name="grpDlvname<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" value="<%= iDlvTypeStr %>">
		</tr>
		<% elseif (IsArmyDlv or IsQuickDlv) then %>
		<tr>
			<td colspan="10" id="grpTot<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" value="<%= iDlvTypeStr %>">
				<p class="cr555 fs13"><%= iDlvTypeStr %> 합계금액 <strong><%= FormatNumber(oshoppingbag.GetCouponNotAssingTenDeliverItemPrice,0) %></strong>원 + 배송비 <strong><%= FormatNumber(oshoppingbag.GetOrgBeasongPrice,0) %></strong>원 = 총 합계 <strong><%= FormatNumber(oshoppingbag.GetCouponNotAssingTenDeliverItemPrice+oshoppingbag.GetOrgBeasongPrice,0) %></strong>원</p>
				<% if (oshoppingbag.IsMileShopSangpumExists) then %>
				<p class="tPad05 fs11">(마일리지샵 상품 합계 금액 <strong><%= FormatNumber(oshoppingbag.GetMileageShopItemPrice,0) %> Point</strong>)</p>
				<% end if %>
			</td>
			<input type="hidden" id="grpDlvLmt<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" name="grpDlvLmt<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" value="<%=oshoppingbag.getFreeBeasongLimit%>">
			<input type="hidden" id="grpDlvPrc<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" name="grpDlvPrc<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" value="<%=oshoppingbag.getTenDeliverItemBeasongPay%>">
			<input type="hidden" id="grpDlvname<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" name="grpDlvname<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" value="<%= iDlvTypeStr %>">
		</tr>
		<% else %>
		<% if (Mix=0) then %>
		<tr>
			<td colspan="10" id="grpTot<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" value="<%= iDlvTypeStr %>">
				<p class="cr555 fs13"><%= iDlvTypeStr %> 합계금액 <strong><%= FormatNumber(oshoppingbag.GetCouponNotAssingTicketItemPrice,0) %></strong>원 + 배송비 <strong><%= FormatNumber(oshoppingbag.GetTicketItemBeasongPrice,0) %></strong>원 = 총 합계 <strong><%= FormatNumber(oshoppingbag.GetCouponNotAssingTicketItemPrice+oshoppingbag.GetTicketItemBeasongPrice,0) %></strong>원</p>
			</td>
			<input type="hidden" id="grpDlvLmt<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" name="grpDlvLmt<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" value="0">
			<input type="hidden" id="grpDlvPrc<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" name="grpDlvPrc<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" value="<%=oshoppingbag.GetTicketItemBeasongPrice%>">
			<input type="hidden" id="grpDlvname<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" name="grpDlvname<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" value="<%= iDlvTypeStr %>">
		</tr>
		<% elseif (Mix=1) then %>
		<tr>
			<td colspan="10" id="grpTot<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" value="<%= iDlvTypeStr %>">
				<p class="cr555 fs13"><%= iDlvTypeStr %> 합계금액 <strong><%= FormatNumber(oshoppingbag.GetCouponNotAssingPresentItemPrice,0) %></strong>원 + 배송비 <strong><%= FormatNumber(oshoppingbag.GetPresentItemBeasongPrice,0) %></strong>원 = 총 합계 <strong><%= FormatNumber(oshoppingbag.GetCouponNotAssingPresentItemPrice+oshoppingbag.GetPresentItemBeasongPrice,0) %></strong>원</p>
			</td>
			<input type="hidden" id="grpDlvLmt<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" name="grpDlvLmt<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" value="-1">
			<input type="hidden" id="grpDlvPrc<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" name="grpDlvPrc<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" value="<%=oshoppingbag.GetPresentItemBeasongPrice%>">
			<input type="hidden" id="grpDlvname<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" name="grpDlvname<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" value="<%= iDlvTypeStr %>">
		</tr>
		<% elseif (Mix=2) then %>
		<tr>
			<td colspan="10" id="grpTot<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" value="<%= iDlvTypeStr %>">
				<p class="cr555 fs13"><%= iDlvTypeStr %> 합계금액 <strong><%= FormatNumber(oshoppingbag.GetCouponNotAssingRsvSiteItemPrice,0) %></strong>원 + 배송비 <strong><%= FormatNumber(oshoppingbag.GetRsvSiteItemBeasongPrice,0) %></strong>원 = 총 합계 <strong><%= FormatNumber(oshoppingbag.GetCouponNotAssingRsvSiteItemPrice+oshoppingbag.GetRsvSiteItemBeasongPrice,0) %></strong>원</p>
			</td>
			<input type="hidden" id="grpDlvLmt<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" name="grpDlvLmt<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" value="0">
			<input type="hidden" id="grpDlvPrc<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" name="grpDlvPrc<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" value="<%=oshoppingbag.GetRsvSiteItemBeasongPrice%>">
			<input type="hidden" id="grpDlvname<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" name="grpDlvname<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" value="<%= iDlvTypeStr %>">
		</tr>
		<% elseif (Mix=3) then %>
		<tr>
			<td colspan="10" id="grpTot<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" value="<%= iDlvTypeStr %>">
				<p class="cr555 fs13"><%= iDlvTypeStr %> 합계금액 <strong><%= FormatNumber(oshoppingbag.GetCouponNotAssingTenDeliverItemPrice,0) %></strong>원 + 배송비 <strong><%= FormatNumber(oshoppingbag.getTenDeliverItemBeasongPrice,0) %></strong>원 = 총 합계 <strong><%= FormatNumber(oshoppingbag.GetCouponNotAssingTenDeliverItemPrice+oshoppingbag.getTenDeliverItemBeasongPrice,0) %></strong>원</p>
				<% if (oshoppingbag.IsMileShopSangpumExists) then %>
				<p class="tPad05 fs11">(마일리지샵 상품 합계 금액 <strong><%= FormatNumber(oshoppingbag.GetMileageShopItemPrice,0) %> Point</strong>)</p>
				<% end if %>
			</td>
			<input type="hidden" id="grpDlvLmt<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" name="grpDlvLmt<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" value="<%=oshoppingbag.getFreeBeasongLimit%>">
			<input type="hidden" id="grpDlvPrc<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" name="grpDlvPrc<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" value="<%=oshoppingbag.getTenDeliverItemBeasongPay%>">
			<input type="hidden" id="grpDlvname<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" name="grpDlvname<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" value="<%= iDlvTypeStr %>">
		</tr>
		<% elseif (Mix=4) then %>
		<tr>
			<td colspan="10" id="grpTot<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" value="<%= iDlvTypeStr %>">
				<p class="cr555 fs13"><%= iDlvTypeStr %> 합계금액 <strong><%= FormatNumber(oshoppingbag.GetCouponNotAssingUpcheItemPrice,0) %></strong>원 + 배송비 <strong><%= FormatNumber(oshoppingbag.getUpcheBeasongPrice,0) %></strong>원 = 총 합계 <strong><%= FormatNumber(oshoppingbag.GetCouponNotAssingUpcheItemPrice+oshoppingbag.getUpcheBeasongPrice,0) %></strong>원</p>
			</td>
			<input type="hidden" id="grpDlvLmt<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" name="grpDlvLmt<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" value="0">
			<input type="hidden" id="grpDlvPrc<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" name="grpDlvPrc<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" value="<%=oshoppingbag.getUpcheBeasongPrice%>">
			<input type="hidden" id="grpDlvname<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" name="grpDlvname<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" value="<%= iDlvTypeStr %>">
		</tr>
		<% elseif (Mix=5) then %>
		<tr>
			<td colspan="10" id="grpTot<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" value="<%= iDlvTypeStr %>">
				<p class="cr555 fs13"><%= iDlvTypeStr %> 합계금액 <strong><%= FormatNumber(pitemprice,0) %></strong>원 + 배송비 <strong><%= FormatNumber(pdlvPrice,0) %></strong>원 = 총 합계 <strong><%= FormatNumber(pitemprice+pdlvPrice,0) %></strong>원</p>
			</td>
			<input type="hidden" id="grpDlvLmt<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" name="grpDlvLmt<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" value="<%=oshoppingbag.FParticleBeasongUpcheList(j).FdefaultFreebeasongLimit%>">
			<input type="hidden" id="grpDlvPrc<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" name="grpDlvPrc<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" value="<%=chkIIF(GetLoginUserLevel="7" or GetLoginUserLevel="8",0,oshoppingbag.FParticleBeasongUpcheList(j).FdefaultDeliverPay)%>">
			<input type="hidden" id="grpDlvname<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" name="grpDlvname<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" value="<%= iDlvTypeStr %>">
		</tr>
		<% elseif (Mix=6) then %>
		<tr>
			<td colspan="10" id="grpTot<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" value="<%= iDlvTypeStr %>">
				<p class="cr555 fs13"><%= iDlvTypeStr %> 합계금액 <strong><%= FormatNumber(oshoppingbag.GetCouponNotAssingUpcheReceivePayItemPrice,0) %></strong>원 + 배송비 착불 부과 = 총합계 <strong><%= FormatNumber(oshoppingbag.GetCouponNotAssingUpcheReceivePayItemPrice+0,0) %></strong>원</p>
			</td>
			<input type="hidden" id="grpDlvLmt<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" name="grpDlvLmt<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" value="0">
			<input type="hidden" id="grpDlvPrc<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" name="grpDlvPrc<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" value="0">
			<input type="hidden" id="grpDlvname<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" name="grpDlvname<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" value="<%= iDlvTypeStr %>">
		</tr>
		<% elseif (Mix=7) then %>
		<tr>
			<td colspan="10" id="grpTot<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" value="<%= iDlvTypeStr %>">
				<p class="cr555 fs13"><%= iDlvTypeStr %> 합계금액 <strong><%= FormatNumber(oshoppingbag.GetCouponNotAssingTravelItemPrice,0) %></strong>원 + 배송비 <strong><%= FormatNumber(oshoppingbag.GetTravelItemBeasongPrice,0) %></strong>원 = 총 합계 <strong><%= FormatNumber(oshoppingbag.GetCouponNotAssingTravelItemPrice+oshoppingbag.GetTravelItemBeasongPrice,0) %></strong>원</p>
			</td>
			<input type="hidden" id="grpDlvLmt<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" name="grpDlvLmt<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" value="0">
			<input type="hidden" id="grpDlvPrc<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" name="grpDlvPrc<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" value="<%=oshoppingbag.GetTravelItemBeasongPrice%>">
			<input type="hidden" id="grpDlvname<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" name="grpDlvname<%=CHKIIF(Mix=5,Mix+CnPls+MidxSub,Mix)%>" value="<%= iDlvTypeStr %>">
		</tr>
		<% elseif (Mix=8) then %>
		<tr>
			<td colspan="10">
				<p class="cr555 fs13">이니렌탈 상품은 결제 페이지에서 렌탈 개월 수를 선택해 주시면 월 렌탈료를 확인하실 수 있습니다.</p>
			</td>
		</tr>		
		<% else %>

		<% end if %>
		<% end if %>
		</tfoot>
	</table>

	<% if (Mix=1) then %>
	<div class="note01 tPad10">
		<ul class="list01">
			<li>일반상품과 함께 주문되지 않으며, 단독으로 주문하셔야 합니다.</li>
			<li>한 주문에 1개씩만 주문할 수 있으며, 한 ID당 최대 1회까지 주문 가능합니다.</li>
			<% '// 텐텐배송 2500으로 변경 %>
			<% If (Left(Now, 10) >= "2019-01-01") Then %>
				<li>주문 건당 2,500원의 배송비가 부과됩니다.</li>
			<% Else %>
				<li>주문 건당 2,000원의 배송비가 부과됩니다.</li>
			<% End If %>
			<li>고객 변심으로 인한 교환 및 환불 불가합니다. (단, 불량시 교환 가능)</li>
		</ul>
	</div>
	<% end if %>
<%
	Next
end function
%>

<%
'선물포장서비스 노출		'/2015.11.05 한용민 추가
if G_IsPojangok then
	'/해외배송과 군부대배송은 노출안함
	if not(IsForeignDlv) and not(IsArmyDlv) then
		'선물포장서비스 표기
		if (oshoppingbag.IsTenBeasongInclude) then
%>
			<div class="wrappingOpenV15a">
				<% if isBaguniUserLoginOK then %>
					<p><img src="http://fiximage.10x10.co.kr/web2015/inipay/txt_wrapping_service_open.png" alt="선물포장 서비스 오픈 선물포장은 다음 단계에서 가능합니다." /></p>
				<% else %>
					<p><img src="http://fiximage.10x10.co.kr/web2015/inipay/txt_wrapping_service_open2.png" alt="선물포장 서비스 오픈 선물포장은 다음 단계에서 가능합니다." /></p>
				<% end if %>
			</div>
		<% end if %>
	<% end if %>
<% end if %>

<% for Mix=0 to 8 %>

    <% if (Mix=0) and (IsLocalDlv) then %>
        <% if (oshoppingbag.IsTicketSangpumExists) then %>
        <% CALL DrawBaguniSubList() %>
        <% end if %>
    <% end if %>

    <% if (Mix=1) and (IsLocalDlv) then %>
        <% if (oshoppingbag.IsPresentSangpumExists) then %>
        <% CALL DrawBaguniSubList() %>
        <% end if %>
    <% end if %>

    <% if (Mix=2) and (IsLocalDlv) then %>
        <% if (oshoppingbag.IsRsvSiteSangpumExists) then %>
        <% CALL DrawBaguniSubList() %>
        <% end if %>
    <% end if %>

    <% if (Mix=3) then %>
        <% if ((oshoppingbag.IsTenBeasongInclude) or (oshoppingbag.IsMileShopSangpumExists)) then %>
        <% CALL DrawBaguniSubList() %>
        <% end if %>
    <% end if %>

    <% if (Mix=4) and (IsLocalDlv) then %>
        <% if (oshoppingbag.IsUpcheBeasongInclude) then '' and (not oshoppingbag.IsTravelSangpumExists) %>
        <% CALL DrawBaguniSubList() %>
        <% end if %>
    <% end if %>

    <% if (Mix=5) and (IsLocalDlv) then %>
        <% if (oshoppingbag.IsUpcheParticleBeasongInclude) then %>
        <% CALL DrawBaguniSubList() %>
        <% end if %>
    <% end if %>

    <% if (Mix=6) and (IsLocalDlv) then %>
        <% if (oshoppingbag.IsReceivePayItemInclude) then %>
        <% CALL DrawBaguniSubList() %>
        <% end if %>
    <% end if %>
    
    <% if (Mix=7) and (IsLocalDlv) then %>
        <% if (oshoppingbag.IsTravelSangpumExists) then %>
        <% CALL DrawBaguniSubList() %>
        <% end if %>
    <% end if %>

	<% If (Mix=8) and (IsLocalDlv) Then %>
		<% if (oshoppingbag.IsRentalSangpumExists) then %>
		<% CALL DrawBaguniSubList() %>
		<% End IF %>
	<% End If %>

<% next %>
<!-------------------------------------->

					<% if (IsForeignDlv) then %>
					<div class="totalWeight tMar30">
						<dl>
							<dt><img src="http://fiximage.10x10.co.kr/web2013/cart/txt_total_weight.png" alt="총 중량" /></dt>
							<dd>
								<ul>
									<li>
										<div>
											<p class="fs20"><strong><%= FormatNumber(oshoppingbag.getEmsTotalWeight-oshoppingbag.getEmsBoxWeight,0) %>g</strong></p>
											<p class="fs11 tPad10">상품 순 중량</p>
										</div>
									</li>
									<li class="plus">
										<div>
											<p class="fs20"><strong><%= FormatNumber(oshoppingbag.getEmsBoxWeight,0) %>g</strong></p>
											<p class="fs11 tPad10">포장박스 중량</p>
										</div>
									</li>
									<li class="equal">
										<div>
											<p class="fs20"><strong><%= FormatNumber(oshoppingbag.getEmsTotalWeight,0) %>g</strong></p>
											<p class="fs11 tPad10">총 중량</p>
										</div>
									</li>
								</ul>
							</dd>
						</dl>
						<div class="tPad15">
							<p class="ftLt">
								<select class="optSelect2" title="배송국가를 선택해주세요" name="countryCode" onChange="setEMSPrice(this);">
									<option value="">배송 국가 선택</option>
									<% for i=0 to oems.FREsultCount-1 %>
									<option value="<%= oems.FItemList(i).FcountryCode %>" id="<%= oems.FItemList(i).FemsAreaCode %>|<%= oems.FItemList(i).FemsMaxWeight %>" iMaxWeight="<%= oems.FItemList(i).FemsMaxWeight %>" iAreaCode="<%= oems.FItemList(i).FemsAreaCode %>"><%= oems.FItemList(i).FcountryNameKr %>(<%= oems.FItemList(i).FcountryNameEn %>)</option>
									<% next %>
								</select>
								<input type="hidden" name="iemsPrice" id="iemsPrice" value="0">
								<span class="addInfo"><em onClick="popEmsApplyGoCondition();">국가별 발송조건 보기</em></span>
							</p>
							<p class="ftRt">
								<!--span>배송국가 <strong><span id="sp_countryName">-</span></strong></span-->
								<span class="sepLine">중량 <strong><span id="sp_emsWeight"><%= FormatNumber(oshoppingbag.getEmsTotalWeight,0) %></span>g</strong></span>
								<span class="sepLine">해외 배송비 <strong><span id="sp_emsPrice">-</span>원</strong></span>
							</p>
						</div>
					</div>
					<% end if %>
                    </form>
<%
''Check Confirm

if oshoppingbag.IsSoldOutSangpumExists then
    'iErrMsg = "죄송합니다. 품절된 상품은 구매하실 수 없습니다."
elseif oshoppingbag.Is09NnormalSangpumExists then
    iErrMsg = "단독구매 및 예약판매 상품과 일반상품은 같이 구매하실 수 없습니다.\n\n단독구매 및 예약판매 상품은 별도로 장바구니에 담아주세요"
elseif oshoppingbag.IsTicketNnormalSangpumExists then
    iErrMsg = "품구매상품과 일반상품은 같이 구매 할 수 없으니 따로 주문해 주시기 바랍니다"
elseif oshoppingbag.IsRsvSiteNnormalSangpumExists then
    iErrMsg = "현장수령상품과 일반상품은 같이 구매 할 수 없으니, 단독으로 주문해 주시기 바랍니다"
elseif oshoppingbag.IsPresentNnormalSangpumExists then
    iErrMsg = "Present상품과 일반상품은 같이 구매 할 수 없으니, 단독으로 주문해 주시기 바랍니다"
elseif (oshoppingbag.GetMileshopItemCount>0) and (oshoppingbag.GetTenBeasongCount<1) then
    iErrMsg = "마일리지샵 상품은 텐바이텐 배송상품과 함께 구매 하셔야 배송 가능 합니다."
elseif (availtotalMile<oshoppingbag.GetMileageShopItemPrice) then
    iErrMsg = "장바구니에 담으신 마일리지샵 상품의 합계가 고객님이 보유하신 마일리지 금액보다 큽니다.\n\n- 보유하신 마일리지 : " & FormatNumber(availtotalMile,0) & " point\n- 담으신 마일리지샵 상품의 합계 : " & FormatNumber(oshoppingbag.GetMileageShopItemPrice,0) & " point"
elseif oshoppingbag.IsTicketSangpumExists and (not IsUserLoginOk) then
    iErrMsg = "죄송합니다. 티켓 상품은 회원 구매만 가능합니다."
elseif (iTicketItemCNT>1) then
    iErrMsg = "티켓 상품은 한번에 한 상품씩 구매 가능합니다."
elseif oshoppingbag.IsPresentSangpumExists and (not IsUserLoginOk) then
    iErrMsg = "죄송합니다. Present상품은 회원 구매만 가능합니다."
elseif (iPresentItemCNT>1) then
    iErrMsg = "Present상품은 한번에 한 상품씩 구매 가능합니다."
end if
%>
					<div class="totalBox tMar30">
						<dl class="totalPriceView">
							<dt><img src="http://fiximage.10x10.co.kr/web2013/cart/txt_total.gif" alt="총 주문 금액" /></dt>
							<dd id="lyrTotalItem">
								<% if (IsForeignDlv) then %>
								<ul class="priceList">
									<li>
										<span class="ftLt">상품 총 금액</span><strong class="ftRt"><%= FormatNumber(oshoppingbag.GetTotalItemOrgPrice-oshoppingbag.GetMileageShopItemPrice,0)%>원</strong>
									</li>
									<li>
										<span class="ftLt">해외 배송비</span><strong class="ftRt"><span id="sp_emsPriceTTL"><%= FormatNumber(oshoppingbag.GetTotalBeasongPrice,0) %></span>원</strong>
									</li>
								</ul>
								<% elseif (IsArmyDlv) then %>
								<ul class="priceList">
									<li>
										<span class="ftLt">상품 총 금액</span><strong class="ftRt"><%= FormatNumber(oshoppingbag.GetCouponNotAssingTenDeliverItemPrice,0)%>원</strong>
									</li>
									<li>
										<span class="ftLt">군부대 배송비</span><strong class="ftRt"><%= FormatNumber(oshoppingbag.GetOrgBeasongPrice,0) %>원</strong>
									</li>
								</ul>
								<% else %>
								<ul class="priceList">
									<li>
										<span class="ftLt">상품 총 금액</span><strong class="ftRt"><%= FormatNumber(oshoppingbag.GetTotalItemOrgPrice-oshoppingbag.GetMileageShopItemPrice,0)%>원</strong>
									</li>
									<li>
										<span class="ftLt">배송비</span><strong class="ftRt"><%= FormatNumber(oshoppingbag.GetOrgBeasongPrice,0) %>원</strong>
									</li>
								</ul>
								<% end if %>
							</dd>
						</dl>
						<p class="rt tPad15 bPad05" id="lyrTotalOrder">
							<span class="fs13 cr777">(적립 마일리지 <%= FormatNumber(oshoppingbag.getTotalGainmileage,0) %> P)</span>
							<strong class="lPad10">
								<% if (oshoppingbag.GetMileageShopItemPrice<>0) then%>
								마일리지샵 금액 <span class="crRed lPad10"><em class="fs20"><%= FormatNumber(oshoppingbag.GetMileageShopItemPrice,0) %></em>P</span>
								<em><img src="http://fiximage.10x10.co.kr/web2013/cart/ico_plus.gif" alt="더하기" /></em>
								<% end if %>
								결제 예정 금액 <span class="crRed lPad10"><em class="fs20">
								<% if IsArmyDlv then %>
								<%= FormatNumber(oshoppingbag.GetCouponNotAssingTenDeliverItemPrice+oshoppingbag.GetOrgBeasongPrice,0)%>
								<% elseif IsForeignDlv then %>
								<span id="sp_ForeignPriceTTL"><%= FormatNumber(oshoppingbag.GetTotalItemOrgPrice-oshoppingbag.GetMileageShopItemPrice+oshoppingbag.GetTotalBeasongPrice,0)%></span>
								<% else %>
								<%= FormatNumber(oshoppingbag.GetTotalItemOrgPrice-oshoppingbag.GetMileageShopItemPrice+oshoppingbag.GetOrgBeasongPrice,0) %>
								<% end if %></em>원</span>
							</strong>
						</p>
					</div>

					<div class="overHidden tPad20 bPad20">
						<div class="ftLt">
							<p><input type="checkbox" id="allSelct" name="allSelct" class="check" onClick="checkAllItem(this,<%=Mix+CnPls+MidxSub%>);"/> <label for="allSelct"><strong class="fs13">전체선택</strong></label></p>
							<p class="tPad10">
								<% if (isBaguniUserLoginOK) then %>
								<a href="" class="btn btnS2 btnWhite fn" onClick="addWishSelected(); return false;">선택상품 위시 담기</a>
								<% end if %>
								<a href="" class="btn btnS2 btnGry2 fn" onClick="delSelected(); return false;">선택상품 삭제</a>
								<a href="" class="btn btnS2 btnGry2 fn" onClick="delSoldOutBaguni(); return false;">품절상품 삭제</a>
							</p>
						</div>
						<div class="ftRt">
							<p>
								<a href="#" class="btn btnB1 btnWhite2 btnW185" onclick="GoShopping(); return false;" >계속 쇼핑하기</a>
								<a href="#" class="btn btnB1 btnWhite btnW185 lMar10" onclick="PayNextSelected('<%=bTp%>'); return false;">선택상품 주문하기</a>
								<a href="#" class="btn btnB1 btnRed btnW185 lMar10" onclick="PayNext(document.baguniFrm,'<%=bTp%>','<%= iErrMsg %>'); return false;">전체상품 주문하기</a>
							</p>
							<div class="plusInfo fs12 tPad25 cr666">
								<ul>
									<li>상품쿠폰 및 보너스쿠폰은 STEP2 [주문결제] 에서 적용됩니다.</li>
									<li>장바구니는 접속 종료 후 14일 동안만 보관 됩니다. 더 오래 보관하고 싶은 상품은 위시리스트에 담아주세요.</li>
									<li>상품배송비는 텐바이텐배송/업체배송/업체조건배송/업체착불배송 4가지 기준으로 나누어 적용됩니다.</li>
									<li>업체배송 및 업체조건배송, 업체착불배송 상품은 해당 업체에서 별도 배송되오니 참고하여 주시기 바랍니다.</li>
									<% if IsForeignDlv then %>
									<li>해외 배송의 경우 배송 국가는 STEP2 [주문결제] 단계에서 선태 및 변경이 가능합니다.</li>
									<% end if %>
								</ul>
							</div>
						</div>
					</div>
					<% end if %>
				</div>

				<% ' 18주년 세일 기간 동안 쿠폰 배너 노출
				'If date() > "2019-09-25" AND date() < "2019-10-01" Then 
				If date() > "2019-09-30" AND date() < "2019-11-01" Then 
				%>
					<div class="tPad20" style="margin-bottom:-25px;"><a href="/my10x10/couponbook.asp" onclick="fnAmplitudeEventMultiPropertiesAction('click_shoppingbag_coupon_banner','','',);" target="_balnk"><img src="//webimage.10x10.co.kr/fixevent/event/2019/18th/bnr_18th_shopbag.png" alt="지금 최대 30% 할인쿠폰을 사용해보세요!"></a></div>
				<% End if %>
                <% If now() >= #2021-12-25 23:59:59# Then %>
                <% Else %>
                <!-- 다스배너 -->
				<div class="tPad20" style="margin-bottom:-5px;"><a href="/diarystory2022/" target="_balnk"><img src="http://fiximage.10x10.co.kr/web2021/diary2022/bnr_big_diary2022.png" alt="12월인데 아직 다이어리 구매 안 한 사람 있니?"></a></div>
                <% End If %>

				<% If (Not oshoppingbag.IsShoppingBagVoid) Then %>
					<div class="cartBox topBgUse tMar40" id="sHappyTogether">
						<div class="happyTogether">
							<div class="tit">
								<h3>Enjoy<br />Together</h3>
								<p>함께 구매하면 즐거움이 2배!</p>
							</div>
							<script type="text/javascript" src="./inc_happyTogether.js"></script>
							<div class="pdtWrap pdt120 pad0" id="lyrHPTgr"></div>
						</div>
					</div>
				<% End If %>


				<% If (Not oshoppingbag.IsShoppingBagVoid) Then %>
					<div class="cartBox recoPick topBgUse tMar40">
						<ul class="tabMenu">
							<% if (IsMileShopEnabled) and (isBaguniUserLoginOK) and (Not oshoppingbag.IsShoppingBagVoid) then %>
								<% if (oMileageShop.FResultCount>0) then %>
									<li><a href="#section1">마일리지샵</a></li>
								<% End If %>
							<% End If %>

							<% IF BtmWishListVisible then %>
								<% if (omyFavorate.FresultCount>0)  then %>
									<li><a href="#section2">MY WISH</a></li>
								<% End If %>
							<% End If %>

						</ul>
						<div class="tabCont">
							<% if (IsMileShopEnabled) and (isBaguniUserLoginOK) and (Not oshoppingbag.IsShoppingBagVoid) then %>
								<% if (oMileageShop.FResultCount>0) then %>
									<!-- 마일리지샵 -->
									<div class="section cartMileage" id="section1">
										<h3>MILEAGE SHOP</h3>
										<div class="mileageInfo">
											<dl class="ftLt">
												<dt class="ftLt">마일리지</dt>
												<dd class="ftLt"><strong><%= FormatNumber(oMileage.FTotalMileage,0) %> P</strong></dd>
											</dl>
											<ul class="list01">
												<li>마일리지는 구매 또는 상품후기 작성으로 쌓을 수 있습니다.</li>
												<li>마일리지샵 상품은 텐바이텐 배송 상품과 함께 구매하셔야 하며, 한 상품당 하나씩만 구매하실 수 있습니다.</li>
											</ul>
											<a href="/my10x10/mileage_shop.asp" class="ftRt btn btnS1 btnGry fn rMar05"><em class="whiteArr01">마일리지 샵 가기</em></a>
										</div>

										<div class="pdtWrap pdt150 tBdr3">
											<form name="mileForm">
												<ul class="pdtList">
													<% for i=0 to oMileageShop.FResultCount-1 %>
														<li>
															<div class="pdtBox">
																<div class="pdtPhoto">
																	<p><a href="/shopping/category_prd.asp?itemid=<%= omileageshop.FItemList(i).FItemID %>&gaparam=cart_mileshop"><img src="<%=omileageshop.FItemList(i).FIcon1Image%>" width="150px" height="150px" alt="<%= Replace(Replace(oMileageShop.FItemList(i).FItemName,"[마일리지샵]",""),"[마일리지샵]","") %>" /></a></p>
																	<div class="pdtAction">
																		<ul>
																			<li class="largeView"><p onclick="ZoomItemInfo('<%= omileageshop.FItemList(i).FItemID %>');"><span>크게보기</span></p></li>
																			<li class="postView"><p <%=CHKIIF(omileageshop.FItemList(i).Fevalcnt>0,"onclick=""popEvaluate('"&omileageshop.FItemList(i).FItemID&"');""","")%>><span><%= FormatNumber(omileageshop.FItemList(i).Fevalcnt,0) %></span></p></li>
																			<li class="wishView <%=chkIIF(omileageshop.FItemList(i).IsMyWished,"myWishOn","")%>" id="wsIco<%=omileageshop.FItemList(i).FItemid %>"><p onclick="TnAddFavorite('<%=omileageshop.FItemList(i).FItemid %>');"><span><%=FormatNumber(omileageshop.FItemList(i).FFavCount,0) %></span></p></li>
																		</ul>
																	</div>
																</div>
																<div class="pdtInfo">
																	<p class="pdtName"><a href="/shopping/category_prd.asp?itemid=<%= omileageshop.FItemList(i).FItemID %>&gaparam=cart_mileshop"><%= chrbyte(Replace(Replace(oMileageShop.FItemList(i).FItemName,"[마일리지샵]",""),"[마일리지샵]",""),72,"Y") %></a></p>
																	<p class="pdtPrice tPad10"><span class="finalP"><% = FormatNumber(omileageshop.FItemList(i).getMileageCash,0) %> P</span></p>
																	<p class="tPad05">
																		<%
																		optionBoxHtml = ""
																		''품절시 제외.
																		If (omileageshop.FItemList(i).IsItemOptionExists) and (Not omileageshop.FItemList(i).IsSoldOut) then
																		optionBoxHtml = getOneTypeOptionBoxHtmlMile(omileageshop.FItemList(i).FItemID,omileageshop.FItemList(i).IsSoldOut,"class=""input_default"" style=""width:100%;""",true)
																		End If

																		response.write optionBoxHtml
																		%>
																	</p>
																</div>
																<p class="cartBtn">
																	<% if omileageshop.FItemList(i).IsSoldOut then %>
																	<a href="" class="btn btnM2 btnWhite btnW150" onClick="return false;">품 절</a>
																	<% elseif (availtotalMile<omileageshop.FItemList(i).getMileageCash) then %>
																	<a href="" class="btn btnM2 btnWhite btnW150" onClick="alert('마일리지샵 상품을 구매하실 수 있는 마일리지가 부족합니다.\n- 현재 마일리지 : <%= formatnumber(availtotalMile,0) %> Point'); return false;">장바구니</a>
																	<% ElseIf omileageshop.FItemList(i).FAdultType <> 0 And session("isAdult") <> True then%>
																	<a href="" class="btn btnM2 btnWhite btnW150" onClick="confirmAdultAuth('/inipay/shoppingbag.asp');return false;">장바구니</a>
																	<% else %>
																	<a href="" class="btn btnM2 btnWhite btnW150" onClick="AddMileItem2('<%= omileageshop.FItemList(i).FItemID %>');return false;">장바구니</a>
																	<% end if %>
																</p>
															</div>
														</li>
													<% next %>											
												</ul>
											</form>
										</div>
									</div>
									<!-- //마일리지샵 -->
								<% End If %>
							<% End If %>

							<% IF BtmWishListVisible then %>
								<% if (omyFavorate.FresultCount>0) then %>
									<!-- MY WISH -->
									<form name="favForm">
										<div class="section cartWish" id="section2">
											<div class="group">
												<h3><%=CHKIIF(isBaguniUserLoginOK,"MY WISH","POPULAR WISH")%></h3><%' for dev msg : 비회원 주문결제시에는 POPULAR WISH(이하 버튼도 동일하게 적용해주세요) '%>
												<% if (isBaguniUserLoginOK) then %>
													<p class="cmt02 fs12">고객님의 위시리스트에 담긴 상품입니다.</p>
													<a href="/my10x10/mywishlist.asp" class="ftRt btn btnS1 btnGry fn rMar05"><em class="whiteArr01"><%=CHKIIF(isBaguniUserLoginOK,"MY WISH","POPULAR WISH")%></em></a>
												<% Else %>
													<a href="/my10x10/popularWish.asp" class="ftRt btn btnS1 btnGry fn rMar05"><em class="whiteArr01"><%=CHKIIF(isBaguniUserLoginOK,"MY WISH","POPULAR WISH")%></em></a>
												<% End If %>
											</div>
											<div class="pdtWrap pdt150 tBdr3 tMar10">
												<ul class="pdtList">
													<% for i=0 to omyFavorate.FResultcount-1 %>
													<li>
														<div class="pdtBox">
															<div class="pdtPhoto">
																<p><a href="/shopping/category_prd.asp?itemid=<%= omyFavorate.FItemList(i).FItemID %>&gaparam=cart_wish"><img src="<%= omyFavorate.FItemList(i).FImageIcon1 %>" width="150px" height="150px" alt="<%= omyFavorate.FItemList(i).FItemName%>" /></a></p>
																<div class="pdtAction">
																	<ul>
																		<li class="largeView"><p onclick="ZoomItemInfo('<%= omyFavorate.FItemList(i).FItemID %>');"><span>크게보기</span></p></li>
																		<li class="postView"><p <%=CHKIIF(omyFavorate.FItemList(i).Fevalcnt>0,"onclick=""popEvaluate('"&omyFavorate.FItemList(i).FItemID&"');""","")%>><span><%= omyFavorate.FItemList(i).FEvalCnt %></span></p></li>
																		<li class="wishView" id="wsIco<%=omyFavorate.FItemList(i).FItemid %>"><p onclick="TnAddFavorite('<%=omyFavorate.FItemList(i).FItemid %>');"><span><%=FormatNumber(omyFavorate.FItemList(i).FFavCount,0) %></span></p></li>
																	</ul>
																</div>
															</div>
															<div class="pdtInfo">
																<p class="pdtBrand"><a href="/street/street_brand.asp?makerid=<%=omyFavorate.FItemList(i).Fmakerid%>"><%=omyFavorate.FItemList(i).FBrandName %></a></p>
																<p class="pdtName tPad10"><a href="/shopping/category_prd.asp?itemid=<%= omyFavorate.FItemList(i).FItemID %>&gaparam=cart_wish"><%= chrbyte(omyFavorate.FItemList(i).FItemName,72,"Y") %></a></p>
																<% if omyFavorate.FItemList(i).IsSaleItem or omyFavorate.FItemList(i).isCouponItem then %>
																<% IF omyFavorate.FItemList(i).IsSaleItem then %>
																<p class="pdtPrice"><span class="txtML"><%= FormatNumber(omyFavorate.FItemList(i).FOrgPrice,0) %><% if omyFavorate.FItemList(i).IsMileShopitem then %> Point<% else %>원<%end if%></span></p>
																<p class="pdtPrice"><span class="finalP"><%= FormatNumber(omyFavorate.FItemList(i).getRealPrice,0) %>원</span> <strong class="crRed">[<%= omyFavorate.FItemList(i).getSalePro %>]</strong></p>
																<% end if %>
																<% IF omyFavorate.FItemList(i).IsCouponItem then %>
																<% if Not(omyFavorate.FItemList(i).IsSaleItem()) and Not(omyFavorate.FItemList(i).IsFreeBeasongCoupon()) then %>
																<p class="pdtPrice"><span class="finalP"><%= FormatNumber(omyFavorate.FItemList(i).getOrgPrice,0) %>원</span></p>
																<% else %>
																<p class="pdtPrice"><span class="finalP"><%= FormatNumber(omyFavorate.FItemList(i).GetCouponAssignPrice,0) %>원</span> <strong class="crGrn">[<% =omyFavorate.FItemList(i).GetCouponDiscountStr %>]</strong></p>
																<% end if %>
																<% end if %>
																<% else %>
																<p class="pdtPrice"><span class="finalP"><%= FormatNumber(omyFavorate.FItemList(i).getRealPrice,0) %>원</span></p>
																<% end if %>

																<p class="tPad05">
																	<%
																	optionBoxHtml = ""
																	''품절시 제외.
																	If (omyFavorate.FItemList(i).IsItemOptionExists) and (Not omyFavorate.FItemList(i).IsSoldOut) then
																		if (omyFavorate.FItemList(i).Fdeliverytype="6") then
																			optionBoxHtml = getOneTypeOptionBoxHtmlMile(omyFavorate.FItemList(i).FItemID,omyFavorate.FItemList(i).IsSoldOut,"class=""optSelect2"" style=""width:100%;""",false)
																		else
																			optionBoxHtml = getOneTypeOptionBoxHtmlMile(omyFavorate.FItemList(i).FItemID,omyFavorate.FItemList(i).IsSoldOut,"class=""optSelect2"" style=""width:100%;""",true)
																		end if
																	End If

																	response.write optionBoxHtml
																	%>

																</p>
															</div>
															<p class="cartBtn">
																<a href="" class="btn btnM2 btnWhite btnW150" onClick="AddFavItem2('<%= omyFavorate.FItemList(i).FItemID %>', '<%= omyFavorate.FItemList(i).FAdultType %>');return false;">장바구니</a>
															</p>
														</div>
													</li>
													<% next %>
												</ul>
											</div>
										</div>
									</form>
									<!-- //MY WISH -->
								<% End If %>
							<% End If %>
						</div>
					</div>
				<% End If %>

				<% if Not(isBaguniUserLoginOK) then %>
				<%'// 2018 회원등급 개편 %>
				<dl class="mem-benefit">
					<dt>텐바이텐의 회원혜택</dt>
					<dd>
						<ul>
							<li><strong>회원등급별 혜택</strong>등급별로 매월 쿠폰 발급</li>
							<li><strong>회원 사은혜택</strong>구매 사은품 및 쿠폰 이벤트 진행</li>
							<li><strong>마일리지 적립</strong>구매 및 후기 작성시 마일리지 적립</li>
							<li><strong>이벤트 참여</strong>회원 대상의 다양한 이벤트와 문화 혜택</li>
						</ul>
					</dd>
				</dl>
				<% end if %>
			</div>
		</div>
	</div>

<%
'// 구글 ADS 스크립트 관련(2018.09.21 신규버전 추가)
googleADSCRIPT = " <script> "
googleADSCRIPT = googleADSCRIPT & "   gtag('event', 'page_view', { "
googleADSCRIPT = googleADSCRIPT & "     'send_to': 'AW-851282978', "
googleADSCRIPT = googleADSCRIPT & "     'ecomm_pagetype': 'cart', "
googleADSCRIPT = googleADSCRIPT & "     'ecomm_prodid': "&ADSItem&", "
googleADSCRIPT = googleADSCRIPT & "     'ecomm_totalvalue': '"&oshoppingbag.getTotalPrice("0000")&"' "
googleADSCRIPT = googleADSCRIPT & "   }); "
googleADSCRIPT = googleADSCRIPT & " </script> "	
%>
<form name="reloadFrm" method="post" action="/inipay/shoppingbag_process.asp" onsubmit="return false;">
<input type="hidden" name="mode" value="">
<input type="hidden" name="sitename" value="10x10">
<input type="hidden" name="itemid" value="">
<input type="hidden" name="itemoption" value="">
<input type="hidden" name="itemea" value="">
<input type="hidden" name="requiredetail" value="">
<input type="hidden" name="bTp" value="<%=bTp%>">
</form>

<form name="NextFrm" method="post" action="<%= Replace(wwwUrl,"http:","https:") %>/inipay/userinfo.asp">
<input type="hidden" name="sitename" value="10x10">
<input type="hidden" name="bTp" value="<%=bTp%>">
<input type="hidden" name="subtotalprice" value="<%= oshoppingbag.getTotalPrice("0000") %>">
<input type="hidden" name="itemsubtotal" value="<%= oshoppingbag.GetTotalItemOrgPrice %>">
<input type="hidden" name="mileshopitemprice" value="<%= oshoppingbag.GetMileageShopItemPrice %>">

</form>

<form name="frmConfirm" method="post" action="/inipay/shoppingbag_process.asp">
<input type="hidden" name="mode" value="add">
<input type="hidden" name="tp" value="">
<input type="hidden" name="fc" value="on">
<input type="hidden" name="itemid" value="<%= itemid %>">
<input type="hidden" name="itemoption" value="<%= itemoption %>">
<input type="hidden" name="itemea" value="<%= itemea %>">
<input type="hidden" name="requiredetail" value="<%= doubleQuote(requiredetail) %>">
</form>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>

<%
if (oshoppingbag.IsFixNnormalSangpumExists) then
    response.write "<script language='javascript'> ChkErrMsg = '지정일 배송상품(꽃배달)과 일반택배 상품은 같이 배송되지 않으니 양해하시기 바랍니다.';</script>"
elseif (oshoppingbag.IsTicketNnormalSangpumExists) then
    response.write "<script language='javascript'> ChkErrMsg = '티켓 단독구매상품과 일반상품은 같이 구매 할 수 없으니 따로 주문해 주시기 바랍니다.';</script>"
elseif (oshoppingbag.IsRsvSiteNnormalSangpumExists) then
    response.write "<script language='javascript'> ChkErrMsg = '현장수령상품과 일반상품은 같이 구매 할 수 없으니, 단독으로 주문해 주시기 바랍니다.';</script>"
elseif (oshoppingbag.IsPresentNnormalSangpumExists) then
    response.write "<script language='javascript'> ChkErrMsg = 'Present상품과 일반상품은 같이 구매 할 수 없으니, 단독으로 주문해 주시기 바랍니다.';</script>"
elseif oshoppingbag.Is09NnormalSangpumExists then
    response.write "<script language='javascript'> ChkErrMsg = '단독구매 및 예약판매 상품과 일반상품은 같이 구매하실 수 없습니다.\n\n단독구매 및 예약판매 상품은 별도로 장바구니에 담아주세요';</script>"
elseif (oshoppingbag.GetMileshopItemCount>0) and (oshoppingbag.GetTenBeasongCount<1) then
    response.write "<script language='javascript'> ChkErrMsg = '마일리지샵 상품은 텐바이텐 배송상품과 함께 하셔야 배송 가능 합니다.';</script>"
elseif (oshoppingbag.GetMileageShopItemPrice>availtotalMile) then
    response.write "<script language='javascript'> ChkErrMsg = '장바구니에 담으신 마일리지샵 상품의 합계가 고객님이 보유하신 마일리지 금액보다 큽니다.\n\n- 보유하신 마일리지 : " & formatNumber(availtotalMile,0) & "point\n- 담으신 마일리지샵 상품의 합계 : " & formatNumber(oshoppingbag.GetMileageShopItemPrice,0) & "point';</script>"
end if

if (NotWriteRequireDetailExists) then
    response.write "<script language='javascript'> ChkErrMsg = '주문 제작 문구를 작성하지 않은 상품이 존재합니다. - 주문 제작문구를 작성해주세요.';</script>"
end if

if (NotEditPhotobookExists) then
    response.write "<script language='javascript'> ChkErrMsg = '포토북 편집 파일이 존재하지 않습니다. - 포토북 상품은 편집후 구매해 주세요.';</script>"
end if
%>
<script language='javascript'>
function popDuppBaguni(){
    var buf = "<div id='cartAddLyr' class='window cartAddLyr' style='width:400px; height:315px;'>";
	buf=buf+"<div class='popTop pngFix'><div class='pngFix'></div></div>";
	buf=buf+"<div class='popContWrap pngFix'>";
	buf=buf+"<div class='popCont pngFix'>";
	buf=buf+"<div class='popBody'>";
	buf=buf+"<div class='addtoCart'>";
	buf=buf+"<p><img src='http://fiximage.10x10.co.kr/web2013/cart/txt_double_cart.gif' alt='장바구니에 같은 상품이 있습니다. 추가하시겠습니까?' /></p>";
	buf=buf+"<div class='btnArea bPad20'>";
	buf=buf+"<a href='#' onclick='hidePopupLayer();return false;' class='btn btnWhite'>취소하기</a>";
	buf=buf+"<a href='#' onclick='TnShoppingBagForceAdd();return false;' class='btn btnRed'>장바구니 담기</a>";
	buf=buf+"</div>";
	buf=buf+"</div>";
	buf=buf+"</div>";
	buf=buf+"</div>";
	buf=buf+"</div>";
	buf=buf+"</div>";

	viewPoupLayer('popup',buf);
}

function getOnload(){
    <% if (chKdp="on") then %>
    popDuppBaguni();
    <% end if %>
    if (ChkErrMsg){
        alert(ChkErrMsg);
    }
}

$(document).ready(function () {
    <%
    ''쇼핑백 갯수 처리
    if (IsLocalDlv)and(CStr(GetCartCount)<>CStr(sBagCount)) then
        Call setCartCount(sBagCount)
        response.write "document.getElementById('ibgaCNT').innerHTML='"&sBagCount&"';"
    end if
    %>

    <% if (chKdp="on") then %>
    popDuppBaguni();
    <% end if %>
    if (ChkErrMsg){
       alert(ChkErrMsg);
    }

	// 상품없는 그룹
	var noItemGroups = $(".baseTable[id^='bagGrpItem']");
	$(noItemGroups).each(function(){
		if($(this).find("tbody tr").length==0) {
			$(this).hide();
			var idx = $(this).attr("id").replace("bagGrpItem","");
			$("#bagGrpTitle"+idx).hide();
		}
	});
});
//window.onload = getOnload;
</script>
<%' 크리테오 스크립트 추가 %>
<script type="text/javascript" src="//static.criteo.net/js/ld/ld.js" async="true"></script>
<script type="text/javascript">
window.criteo_q = window.criteo_q || [];
var deviceType = /iPad/.test(navigator.userAgent) ? "t" : /Mobile|iP(hone|od)|Android|BlackBerry|IEMobile|Silk/.test(navigator.userAgent) ? "m" : "d";
window.criteo_q.push(
	{ event: "setAccount", account: 8262},
	{ event: "setEmail", email: "<%=CriteoUserMailMD5%>" },
	{ event: "setSiteType", type: deviceType},
	{ event: "viewBasket", item: [<%=CriteoADSItem%>]}
);
</script>
<%'// 크리테오 스크립트 추가 %>

    <script>
        if(typeof qg !== "undefined"){
            appier_shoppingbag_products.forEach(function (item){
                qg("event", "view_shoppingbag", item);
            });
        }

        const appierProductRemovedFromCart = function(idx){
            if(typeof qg !== "undefined"){
                let appier_product_removed_from_cart_data = appier_shoppingbag_products[idx];
                delete appier_product_removed_from_cart_data.quantity;
                delete appier_product_removed_from_cart_data.total_goods_price;

                qg("event", "product_removed_from_cart", appier_product_removed_from_cart_data);
            }
        }
    </script>
</body>
</html>
<%
set oShoppingBag = Nothing
set oMileageShop = Nothing
set oSailCoupon  = Nothing
set oItemCoupon  = Nothing
set oems = Nothing
set oemsPrice = Nothing
IF (BtmWishListVisible) then
	set omyFavorate = Nothing
END IF
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->