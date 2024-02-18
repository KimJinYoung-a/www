<%@ codepage="65001" language="VBScript" %>
<%
option Explicit
Response.Buffer = True
Response.CharSet = "utf-8"
%>
<%
'#######################################################
'	History	:  2015.04.02 허진원 생성
'	Description : 상품 정보 보기 팝업
'               : 팝업 창 사이즈 width=945, height=660
'#######################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/item/itemInfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/classes/search/searchcls.asp" -->
<!-- #include virtual="/lib/util/base64.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryPrdCls.asp" -->
<!-- #include virtual="/lib/classes/item/ItemOptionCls.asp" -->
<!-- #include virtual="/lib/classes/shopping/sp_evaluatesearchercls.asp" -->
<!-- #include virtual="/lib/classes/shopping/sp_item_qnacls.asp" -->
<!-- #include virtual="/lib/classes/item/PlusSaleItemCls.asp" -->
<!-- #include virtual="/lib/classes/item/ticketItemCls.asp" -->
<%
	'// 변수 선언 //
	Dim dispCate, lp, chkQkSch, strBrandListURL, ListDiv,ColsSize,ScrollCount, i, ctab
	Dim oItem, oADD
	Dim IsPresentItem, IsReceiveSiteItem, IsTicketItem, ISFujiPhotobook, LoginUserid, IsRentalItem

	'// 파라메터 접수
	dispCate = getNumeric(requestCheckVar(Request("disp"),15))
	If requestCheckVar(Request("tab"),1) <> "" Then
		ctab = requestCheckVar(Request("tab"),1)
	End If

dim PageSize	: PageSize = getNumeric(requestCheckVar(request("psz"),9))
dim SortMet		: SortMet = requestCheckVar(request("srm"),9)
dim searchFlag 	: searchFlag = requestCheckVar(request("sflag"),9)
dim CurrPage 	: CurrPage = requestCheckVar(request("scpg"),9)
dim colorCD 	: colorCD = requestCheckVar(request("iccd"),42)
dim SearchItemDiv : SearchItemDiv="D"
dim icoSize		: icoSize = requestCheckVar(request("icoSize"),1)
dim deliType	: deliType = requestCheckVar(request("deliType"),2)
dim searchText	: searchText = requestCheckVar(request("rect"),100)
dim rangePrice	: rangePrice = requestCheckVar(request("rPrc"),3)
dim minPrice	: minPrice = requestCheckVar(request("minPrc"),8)
dim maxPrice	: maxPrice = requestCheckVar(request("maxPrc"),8)

LoginUserid = getLoginUserid()

dim itemid, itEvtImg, itEvtImgMap
itemid = getNumeric(requestCheckVar(request("itemid"),9))

if itemid="" or itemid="0" then
	dbget.close(): response.End
elseif Not(isNumeric(itemid)) then
	dbget.close(): response.End
else
	'정수형태로 변환
	itemid=CLng(itemid)
end if

'// 2020-01-22 특템이벤트
if (trim(itemid)="2693538") or (trim(itemid)="2693445") or (trim(itemid)="2693540") or (trim(itemid)="2693654") then
	Response.Write "<script>alert('본 상품은 이벤트 페이지에서만 확인하실 수 있습니다.'); window.close();</script>"
	dbget.close(): response.End
end if

'// 2020-01-22 특템이벤트
if (trim(itemid)="2706609") or (trim(itemid)="2706640") or (trim(itemid)="2706666") then
	Response.Write "<script>alert('본 상품은 이벤트 페이지에서만 확인하실 수 있습니다.'); window.close();</script>"
	dbget.close(): response.End
end if

'// 2020-02-18 100원 자판기
if (trim(itemid)="2721350") or (trim(itemid)="2721505") or (trim(itemid)="2721559") or (trim(itemid)="2721570") or (trim(itemid)="2721577") or (trim(itemid)="2721592") or (trim(itemid)="2721723") or (trim(itemid)="2721725") then
	Response.Write "<script>alert('본 상품은 이벤트 페이지에서만 확인하실 수 있습니다.'); window.close();</script>"
	dbget.close(): response.End
end if

'// 2020-04-01 데이세일
if (trim(itemid)="2792465") or (trim(itemid)="2792468") or (trim(itemid)="2792463") or (trim(itemid)="2793104") or (trim(itemid)="2792470") or (trim(itemid)="2792469") or (trim(itemid)="2792464") or (trim(itemid)="2793094") or (trim(itemid)="2792466") or (trim(itemid)="2793108") or (trim(itemid)="2792471") or (trim(itemid)="2792472") then
	Response.Write "<script>alert('본 상품은 이벤트 페이지에서만 확인하실 수 있습니다.'); window.close();</script>"
	dbget.close(): response.End
end if

'// 2020-06-15 1일1줍
if (trim(itemid)="2932789") or (trim(itemid)="2932822") or (trim(itemid)="2932782") or (trim(itemid)="2932844") or (trim(itemid)="2932805") then
	Response.Write "<script>alert('본 상품은 이벤트 페이지에서만 확인하실 수 있습니다.'); window.close();</script>"
	dbget.close(): response.End
end if

'// 2020-06-15 1일1줍
if (trim(itemid)="2962639") then
	Response.Write "<script>alert('본 상품은 이벤트 페이지에서만 확인하실 수 있습니다.'); window.close();</script>"
	dbget.close(): response.End
end if

'// 2020-07-20 타임세일
if (trim(itemid)="3020758") or (trim(itemid)="3021109") or (trim(itemid)="3021200") or (trim(itemid)="3020771") or (trim(itemid)="3020770") or (trim(itemid)="3021111") or (trim(itemid)="3021135") or (trim(itemid)="3021133") then
	Response.Write "<script>alert('본 상품은 이벤트 페이지에서만 확인하실 수 있습니다.'); window.close();</script>"
	dbget.close(): response.End
end if

'// 2020-07-24 줍줍 마샬
if (trim(itemid)="3046858") then
	Response.Write "<script>alert('본 상품은 이벤트 페이지에서만 확인하실 수 있습니다.'); window.close();</script>"
	dbget.close(): response.End
end if

'// 2020-07-24 줍줍 아이패드
if (trim(itemid)="3093111") then
	Response.Write "<script>alert('본 상품은 이벤트 페이지에서만 확인하실 수 있습니다.'); window.close();</script>"
	dbget.close(): response.End
end if

'// 2020-07-24 줍줍 아이패드
if (trim(itemid)="3132139") then
	Response.Write "<script>alert('본 상품은 이벤트 페이지에서만 확인하실 수 있습니다.'); window.close();</script>"
	dbget.close(): response.End
end if

'// 2020-10-15 득템의기회
if (trim(itemid)="3308962") then
	Response.Write "<script>alert('본 상품은 이벤트 페이지에서만 확인하실 수 있습니다.'); window.close();</script>"
	dbget.close(): response.End
end if

'// 2020-10-15 득템의기회
if (trim(itemid)="3308960") then
	Response.Write "<script>alert('본 상품은 이벤트 페이지에서만 확인하실 수 있습니다.'); window.close();</script>"
	dbget.close(): response.End
end if

'// 2020-10-15 득템의기회
if (trim(itemid)="3308967") then
	Response.Write "<script>alert('본 상품은 이벤트 페이지에서만 확인하실 수 있습니다.'); window.close();</script>"
	dbget.close(): response.End
end if

'// 2020-10-15 득템의기회
if (trim(itemid)="3309030") then
	Response.Write "<script>alert('본 상품은 이벤트 페이지에서만 확인하실 수 있습니다.'); window.close();</script>"
	dbget.close(): response.End
end if

'// 2020-10-23 오구오구2 득템의기회
if (trim(itemid)="3362885") then
	Response.Write "<script>alert('본 상품은 이벤트 페이지에서만 확인하실 수 있습니다.'); window.close();</script>"
	dbget.close(): response.End
end if

'// 2020-10-23 오구오구2 득템의기회
if (trim(itemid)="3363949") then
	Response.Write "<script>alert('본 상품은 이벤트 페이지에서만 확인하실 수 있습니다.'); window.close();</script>"
	dbget.close(): response.End
end if

'// 2020-10-23 오구오구2 득템의기회
if (trim(itemid)="3363953") then
	Response.Write "<script>alert('본 상품은 이벤트 페이지에서만 확인하실 수 있습니다.'); window.close();</script>"
	dbget.close(): response.End
end if

'// 2020-10-23 오구오구2 득템의기회
if (trim(itemid)="3363963") then
	Response.Write "<script>alert('본 상품은 이벤트 페이지에서만 확인하실 수 있습니다.'); window.close();</script>"
	dbget.close(): response.End
end if

'// 2020-11-02 오리온 쫄깃쫄KIT 추가 정태훈
if (trim(itemid)="3356171") or (trim(itemid)="3797904") then
	Response.Write "<script>alert('본 상품은 이벤트 페이지에서만 확인하실 수 있습니다.'); window.close();</script>"
	dbget.close(): response.End
end if
if (trim(itemid)="3371142") or (trim(itemid)="3687012") or (trim(itemid)="3721834") or (trim(itemid)="3733042") or (trim(itemid)="3742097") then
	Response.Write "<script>alert('본 상품은 이벤트 페이지에서만 확인하실 수 있습니다.'); window.close();</script>"
	dbget.close(): response.End
end if

'// 다이어리 타임세일 제한(작업해야됨)
if (trim(itemid)="3424997") or (trim(itemid)="3424998") or (trim(itemid)="3418284") or (trim(itemid)="3424999") or (trim(itemid)="3425011") or (trim(itemid)="3418290") or (trim(itemid)="3425012") or (trim(itemid)="3425021") or (trim(itemid)="3425022") then
	Response.Write "<script>alert('본 상품은 이벤트 페이지에서만 확인하실 수 있습니다.'); window.close();</script>"
	dbget.close(): response.End
end if

'// 크리스 박스 아이템 접근 제한
if (trim(itemid)="3465575") or (trim(itemid)="3465576") or (trim(itemid)="3465577") or (trim(itemid)="3465583") or (trim(itemid)="3465584") or (trim(itemid)="3465585") or (trim(itemid)="3465586") or (trim(itemid)="3458651") then
	Response.Write "<script>alert('본 상품은 이벤트 페이지에서만 확인하실 수 있습니다.'); window.close();</script>"
	dbget.close(): response.End
end if

'// 다이어리 타임세일2 아이템 접근 제한
if (trim(itemid)="3493942") or (trim(itemid)="3493958") or (trim(itemid)="3493962") or (trim(itemid)="3493976") or (trim(itemid)="3493993") or (trim(itemid)="3493994") or (trim(itemid)="3493998") or (trim(itemid)="3494000") or (trim(itemid)="3494001") then
	Response.Write "<script>alert('본 상품은 이벤트 페이지에서만 확인하실 수 있습니다.'); window.close();</script>"
	dbget.close(): response.End
end if

'// 2021-01-13 줍줍이벤트 추가 정태훈
if (trim(itemid)="3527551") or (trim(itemid)="3554837") or (trim(itemid)="3570847") or (trim(itemid)="3568687") or (trim(itemid)="3589288") or (trim(itemid)="3628565") or (trim(itemid)="3654550") or (trim(itemid)="3654634") or (trim(itemid)="3654662") then
	Response.Write "<script>alert('본 상품은 이벤트 페이지에서만 확인하실 수 있습니다.'); window.close();</script>"
	dbget.close(): response.End
end if

'// 2021-01-21 타임세일 추가 정태훈
if (trim(itemid)="3577689") or (trim(itemid)="3573760") or (trim(itemid)="3573757") or (trim(itemid)="3577707") or (trim(itemid)="3577713") or (trim(itemid)="3573758") or (trim(itemid)="3573761") or (trim(itemid)="3577718") or (trim(itemid)="3573759") or (trim(itemid)="3675389") or (trim(itemid)="3680472") then
	Response.Write "<script>alert('본 상품은 이벤트 페이지에서만 확인하실 수 있습니다.'); window.close();</script>"
	dbget.close(): response.End
end if

'// 2021-03-25 타임세일 추가 정태훈
if (trim(itemid)="3713161") or (trim(itemid)="3715297") or (trim(itemid)="3708341") or (trim(itemid)="3690021") or (trim(itemid)="3714968") or (trim(itemid)="3715334") or (trim(itemid)="3713169") or (trim(itemid)="3715328") or (trim(itemid)="3715002") or (trim(itemid)="3701844") then
	Response.Write "<script>alert('본 상품은 이벤트 페이지에서만 확인하실 수 있습니다.'); window.close();</script>"
	dbget.close(): response.End
end if

'// 2021-03-25 타임세일 추가 정태훈
if (trim(itemid)="3713643") or (trim(itemid)="3717297") or (trim(itemid)="3708348") or (trim(itemid)="3715298") or (trim(itemid)="3714963") or (trim(itemid)="3715197") or (trim(itemid)="3709143") or (trim(itemid)="3713170") or (trim(itemid)="3715332") or (trim(itemid)="3717425") or (trim(itemid)="3731023") then
	Response.Write "<script>alert('본 상품은 이벤트 페이지에서만 확인하실 수 있습니다.'); window.close();</script>"
	dbget.close(): response.End
end if

'// 2021-03-25 언박싱 추가 정태훈
if (trim(itemid)="3707491") or (trim(itemid)="3707496") or (trim(itemid)="3707497") or (trim(itemid)="3707498") or (trim(itemid)="3707499") or (trim(itemid)="3707500") then
	Response.Write "<script>alert('본 상품은 이벤트 페이지에서만 확인하실 수 있습니다.'); window.close();</script>"
	dbget.close(): response.End
end if

'// 2021-03-31 타임세일 추가 정태훈
if (trim(itemid)="3718849") or (trim(itemid)="3686950") or (trim(itemid)="3709144") or (trim(itemid)="3721795") or (trim(itemid)="3725107") or (trim(itemid)="3721797") or (trim(itemid)="3718165") or (trim(itemid)="3722309") or (trim(itemid)="3730632") or (trim(itemid)="3725215") then
	Response.Write "<script>alert('본 상품은 이벤트 페이지에서만 확인하실 수 있습니다.'); window.close();</script>"
	dbget.close(): response.End
end if

'// 2021-04-05 타임세일 추가 정태훈
if (trim(itemid)="3741794") or (trim(itemid)="3717297") or (trim(itemid)="3741793") or (trim(itemid)="3731934") or (trim(itemid)="3738663") or (trim(itemid)="3742256") or (trim(itemid)="3738635") or (trim(itemid)="3742255") or (trim(itemid)="3738453") then
	Response.Write "<script>alert('본 상품은 이벤트 페이지에서만 확인하실 수 있습니다.'); window.close();</script>"
	dbget.close(): response.End
end if

'// 2021-04-12 타임세일 추가 정태훈
if (trim(itemid)="3746914") or (trim(itemid)="3746908") or (trim(itemid)="3722405") or (trim(itemid)="3752141") or (trim(itemid)="3454935") or (trim(itemid)="3742749") or (trim(itemid)="3742229") or (trim(itemid)="3747691") or (trim(itemid)="3747692") or (trim(itemid)="3738455") or (trim(itemid)="3760104") or (trim(itemid)="3758040") or (trim(itemid)="3770922") or (trim(itemid)="3770926") then
	Response.Write "<script>alert('본 상품은 이벤트 페이지에서만 확인하실 수 있습니다.'); window.close();</script>"
	dbget.close(): response.End
end if

'// 2021-04-14 타임세일 추가 정태훈
if (trim(itemid)="3753079") or (trim(itemid)="3748354") or (trim(itemid)="3731940") or (trim(itemid)="3739018") or (trim(itemid)="3753051") or (trim(itemid)="3752204") or (trim(itemid)="3754681") or (trim(itemid)="3699585") or (trim(itemid)="3752630") or (trim(itemid)="3738469") then
	Response.Write "<script>alert('본 상품은 이벤트 페이지에서만 확인하실 수 있습니다.'); window.close();</script>"
	dbget.close(): response.End
end if

'// 2021-05-06 인형뽑기 추가 정태훈
if (trim(itemid)="3810958") or (trim(itemid)="3810962") or (trim(itemid)="3810961") or (trim(itemid)="3810963") or (trim(itemid)="3810964") or (trim(itemid)="3810966") or (trim(itemid)="3810970") or (trim(itemid)="3830803") or (trim(itemid)="3855665") then
	Response.Write "<script>alert('본 상품은 이벤트 페이지에서만 확인하실 수 있습니다.'); window.close();</script>"
	dbget.close(): response.End
end if

'=============================== 상품 상세 정보 ==========================================
set oItem = new CatePrdCls
oItem.GetItemData itemid

if oItem.FResultCount=0 then
	dbget.close(): response.End
end if
if oItem.Prd.Fisusing="N" then
	Response.Write "<script>alert('유효하지 않은 상품이거나 품절된 상품입니다.'); window.close();</script>"
	dbget.close(): response.End
end if

'//2021-06-01 마케팅 전용 상품 접근 불가 정태훈
if (oItem.Prd.FItemDiv = "17") Then
	Response.Write "<script>alert('유효하지 않은 상품이거나 품절된 상품입니다.'); window.close();</script>"
	dbget.close(): response.End
End If

'// fuji FDI photobook 2010-06-14
ISFujiPhotobook = oItem.Prd.FMakerid="fdiphoto"
'// Present상품
IsPresentItem = (oItem.Prd.FItemDiv = "09")
'// 현장수령 상품
IsReceiveSiteItem = (oItem.Prd.FDeliverytype="6")
'// 티켓팅
IsTicketItem = (oItem.Prd.FItemDiv = "08")
If IsTicketItem Then
	dim oTicket
	set oTicket = new CTicketItem
	oTicket.FRectItemID = itemid
	oTicket.GetOneTicketItem
End if
'// 렌탈상품
IsRentalItem = (oItem.Prd.FItemDiv = "30")

''시크릿 쿠폰 존재여부 //2019/06/10
dim isValidSecretItemcouponExists : isValidSecretItemcouponExists = FALSE
dim secretcouponidx : secretcouponidx=-1
 if (IsUserLoginOK) then
	secretcouponidx = oItem.getValidSecretItemCouponDownIdx(LoginUserid, itemid)
 	isValidSecretItemcouponExists =(secretcouponidx>0)
 end if
'=============================== 추가 이미지 & 메인 이미지 ==========================================
set oADD = new CatePrdCls
oADD.getAddImage itemid

'=============================== 추가 정보 ==========================================
dim isMyFavBrand: isMyFavBrand=false
dim isMyFavItem: isMyFavItem=false
if IsUserLoginOK then
	isMyFavBrand = getIsMyFavBrand(LoginUserid,oItem.Prd.FMakerid)
	isMyFavItem = getIsMyFavItem(LoginUserid,itemid)
end if


'//기프트톡 카운
dim vTalkCnt
vTalkCnt = oItem.fnGetGiftTalkCount(itemid)

'=============================== 추가 함수 ==========================================
function ImageExists(byval iimg)
	if (IsNull(iimg)) or (trim(iimg)="") or (Right(trim(iimg),1)="\") or (Right(trim(iimg),1)="/") then
		ImageExists = false
	else
		ImageExists = true
	end if
end function

Function getFirstAddimage()
	if ImageExists(oitem.Prd.FImageBasic) then
		getFirstAddimage= oitem.Prd.FImageBasic
	elseif ImageExists(oitem.Prd.FImageMask) then
		getFirstAddimage= oitem.Prd.FImageMask
	elseif (oAdd.FResultCount>0) then
		if ImageExists(oAdd.FADD(0).FAddimage) then
			getFirstAddimage= oAdd.FADD(0).FAddimage
		end if
	else
		getFirstAddimage= oitem.Prd.FImageMain
	end if
end Function

'타이틀 설정
strPageTitle = "텐바이텐 10X10 : 상품 Quick View " & Replace(oItem.Prd.FItemName,"""","")
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
<script type="text/javascript" src="/lib/js/jquery.numspinner.min.js"></script>
<script type="text/javascript">
$(function() {
	if($('.photoSlideV15 p').length>1) {
		$('.photoSlideV15').slidesjs({
			width:400,
			height:400,
			start:1,
			navigation:{active:true, effect:"fade"},
			pagination:{active:true, effect:"fade"},
			effect:{
				fade:{speed:200, crossfade:true}
			}
		});
		$('.photoSlideV15 .slidesjs-container').mouseover(function(){
			$('.photoSlideV15 .slidesjs-navigation').fadeIn();
		});
		$('.photoSlideV15').mouseleave(function(){
			$('.photoSlideV15 .slidesjs-navigation').fadeOut();
		});
		$('.photoSlideV15 .slidesjs-pagination > li a').append('<span></span>');
		//photo thumbnail pagination control
		$('.photoSlideV15 p img').each(function(i){
			$('.photoSlideV15 .slidesjs-pagination > li').eq(i).children("a").css('background-image', 'url('+$(this).attr("thumb")+')');
		});
		//mouse page control
		$('.photoSlideV15 .slidesjs-pagination > li a').mouseenter(function(){
			$('a[data-slidesjs-item="' + $(this).attr("data-slidesjs-item") + '"]').trigger('click');
		});
	} else {
		$('.photoSlideV15 p img').css({"width":400,"height":400});
		$('.photoSlideV15').append('<ul class="slidesjs-pagination"><li><a href="" class="active" onclick="return false;"><span></span></a></li></ul>');
		$('.photoSlideV15 .slidesjs-pagination > li').css('background-image', 'url('+$('.photoSlideV15 p img').attr("thumb")+')');
	}

	<% if Not(isMyFavItem) then %>
	$('.pdtAbout .pdtWish').click(function(){
		TnAddFavorite(<%=itemid%>);
	});
	<% end if %>

	<% If isRentalItem Then %>
		iniRentalPriceCalculation('12');
		$("#rentalmonth").val('12');
	<% End If %>	
});

// 장바구니 처리
function FnZoomAddShoppingBag(bool) {
    var frm = document.sbagfrm;
    var optCode = "0000";
    var MOptPreFixCode="Z";

	// 상품 옵션 검사
    if (!frm.item_option){
        //옵션 없는경우
    }else if (!frm.item_option[0].length){
        //단일 옵션
        if (frm.item_option.value.length<1){
            alert('옵션을 선택 하세요.');
            frm.item_option.focus();
            return;
        }

        if (frm.item_option.options[frm.item_option.selectedIndex].id=="S"){
            alert('품절된 옵션은 구매하실 수 없습니다.');
            frm.item_option.focus();
            return;
        }

        optCode = frm.item_option.value;
    }else{
        //이중 옵션 경우
        for (var i=0;i<frm.item_option.length;i++){
            if (frm.item_option[i].value.length<1){
                alert('옵션을 선택 하세요.');
                frm.item_option[i].focus();
                return;
            }

            if (frm.item_option[i].options[frm.item_option[i].selectedIndex].id=="S"){
                alert('품절된 옵션은 구매하실 수 없습니다.');
                frm.item_option[i].focus();
                return;
            }

            if (i==0){
                optCode = MOptPreFixCode + frm.item_option[i].value.substr(1,1);
            }else if (i==1){
                optCode = optCode + frm.item_option[i].value.substr(1,1);
            }else if (i==2){
                optCode = optCode + frm.item_option[i].value.substr(1,1);
            }
        }

        if (optCode.length==2){
            optCode = optCode + "00";
        }

        if (optCode.length==3){
            optCode = optCode + "0";
        }
    }
    frm.itemoption.value = optCode;

    // 주문 수량 검사
    for (var j=0; j < frm.itemea.value.length; j++){
        if (((frm.itemea.value.charAt(j) * 0 == 0) == false)||(frm.itemea.value==0)){
    		alert('수량은 숫자만 가능합니다.');
    		frm.itemea.focus();
    		return;
    	}
    }

    // 제작문구 검사
    if (frm.requiredetail){

		if (frm.requiredetail.value.length<1){
			alert('주문 제작 상품 문구를 작성해 주세요.');
			frm.requiredetail.focus();
			return;
		}

		if(GetByteLength(frm.requiredetail.value)>255){
			alert('문구 입력은 한글 최대 120자 까지 가능합니다.');
			frm.requiredetail.focus();
			return;
		}
		// 꺽은괄호 치환
		frm.requiredetail.value = frm.requiredetail.value.replace(/</g,"＜").replace(/>/g,"＞");
	}

	if (bool==true){
		// AJAX로 처리
		var vTrData;
		vTrData = "mode=add";
		vTrData += "&itemid=" + frm.itemid.value;
		vTrData += "&sitename=" + frm.sitename.value;
		vTrData += "&itemoption=" + frm.itemoption.value;
		vTrData += "&itemPrice=" + frm.itemPrice.value;
		vTrData += "&isPhotobook=" + frm.isPhotobook.value;
		vTrData += "&isPresentItem=" + frm.isPresentItem.value;
		vTrData += "&itemea=" + frm.itemea.value;
		if(frm.requiredetail) {
			vTrData += "&requiredetail=" + frm.requiredetail.value;
		}

		$.ajax({
			type: "POST",
			url: "/inipay/shoppingbag_process.asp?tp=ajax",
			data:vTrData,
			success: function(message) {
				switch(message.split("||")[0]) {
					case "0":
						alert("유효하지 않은 상품이거나 품절된 상품입니다.");
						break;
					case "1":
						opener.fnDelCartAll();
						$("#alertMsgV15").html("선택하신 상품을<br />장바구니에 담았습니다.");
						$(".alertLyrV15").fadeIn('fast').delay(3000).fadeOut();
						$("#ibgaCNT",opener.document).html(message.split("||")[1]);
						break;
					case "2":
						$("#alertMsgV15").html("장바구니에 이미<br />같은 상품이 있습니다.");
						$(".alertLyrV15").fadeIn('fast').delay(3000).fadeOut();
						break;
					default:
						alert("죄송합니다. 오류가 발생했습니다.");
						break;
				}
			}
		});
	}else{
		//즉시 구매하기
		opener.name = "tenlist";
		frm.mode.value = "DO1";
		frm.target = opener.name;
		frm.action="/inipay/shoppingbag_process.asp";
		frm.submit();
		self.close();
	}
}

$(document).ready(function () {
	// 옵션(멀티옵션 포함) 담기
	$('.itemoption select[name="item_option"]').change(function() {
		var optCnt = $('.itemoption select[name="item_option"]').length;
		var optSel = 0;
		var optCd = [];

		$('.itemoption select[name="item_option"] option:selected').each(function () {
			optCd[optSel] = $(this).val();
			var opSelCd = optCd[optSel];
			var optMSel = -1;
			var opSoldout = false;

			if(optCd[optSel]!=""&&optCd[optSel]!="0000") optSel++;

			//옵션이 모두 선택 됐을 때 간이바구니에 넣는다
			if(optSel==optCnt) {
				if(optCnt>1) {
					// 이중옵션일 때 내용 접수
					for(i=0;i<Mopt_Code.length;i++){
						if(optCnt==2) {
							if(Mopt_Code[i].substr(1,1)==optCd[0].substr(1,1)&&Mopt_Code[i].substr(2,1)==optCd[1].substr(1,1)) {
								optMSel = i;
							}
						} else if(optCnt==3) {
							if(Mopt_Code[i].substr(1,1)==optCd[0].substr(1,1)&&Mopt_Code[i].substr(2,1)==optCd[1].substr(1,1)&&Mopt_Code[i].substr(3,1)==optCd[2].substr(1,1)) {
								optMSel = i;
							}
						}
					}
					if(optMSel>=0) {
						if(Mopt_S[optMSel]) opSoldout=true;
					} else {
						opSoldout = true;
					}
				} else {
					// 단일옵션일 때
					if($(this).attr("soldout")=="Y") opSoldout = true;
				}
				
				//품절처리
				if(opSoldout) {
					alert("품절된 옵션은 선택하실 수 없습니다.");
					return;
				}
			}
		});
	});
});
// 해외 직구 배송정보 안내 (Overseas Direct Purchase)
function ODPorderinfo(){
	var popwin=window.open('/shopping/popDirectGuide.asp','orderinfo','width=1000,height=640,scrollbars=yes,resizable=no');
	popwin.focus();
}

function iniRentalPriceCalculation(period) {
	var inirentalPrice = 0;
	var iniRentalTmpValuePrd;
	if (period!="") {
		inirentalPrice = getIniRentalMonthPriceCalculation('<%=oItem.Prd.FSellCash%>', period);
		iniRentalTmpValuePrd = inirentalPrice.split('|');
		if (iniRentalTmpValuePrd[0]=="error") {
			inirentalPrice = 0;
			return;
		} else if (iniRentalTmpValuePrd[0]=="ok") {
			inirentalPrice = iniRentalTmpValuePrd[1]
		} else {
			inirentalPrice = 0;
			return;
		}
		$("#rentalmonth").val(period);
	} else {
		inirentalPrice = getIniRentalMonthPriceCalculation('<%=oItem.Prd.FSellCash%>', '12');
		iniRentalTmpValuePrd = inirentalPrice.split('|');
		if (iniRentalTmpValuePrd[0]=="error") {
			inirentalPrice = 0;
			return;
		} else if (iniRentalTmpValuePrd[0]=="ok") {
			inirentalPrice = iniRentalTmpValuePrd[1]
		} else {
			inirentalPrice = 0;
			return;
		}
		$("#rentalmonth").val('24');
	}
	inirentalPrice = inirentalPrice.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,')+"원";
	$("#rentalMonthPrice").empty().html(" "+inirentalPrice);
}
</script>
</head>
<body>
<div class="heightgird">
	<div class="popWrap">
		<div class="popContent pdfQuickview15">
			<div class="pdtInfoWrapV15">
				<div class="pdtPhotoWrap">
					<div class="pdtPhotoBox">
						<div class="photoSlideV15">
						<%
							'// 상품 이미지 출력
							dim viBsimg, viMkimg, viAdImg
							dim viBstmb, viMktmb, viAdtmb
							
							'기본 이미지 (큰이미지가 있으면 큰걸로 취합)
							'if ImageExists(oitem.Prd.FImageBasic1000) then
							'	viBsimg = oitem.Prd.FImageBasic1000
							if ImageExists(oitem.Prd.FImageBasic600) then
								viBsimg = oitem.Prd.FImageBasic600
							elseif ImageExists(oitem.Prd.FImageBasic) then
								viBsimg = oitem.Prd.FImageBasic
							end if

							if viBsimg<>"" then
								viBstmb = getThumbImgFromURL(viBsimg,40,40,"true","false")		'썸네일 먼저
								viBsimg = getThumbImgFromURL(viBsimg,400,400,"true","false")
								
								Response.write "<p><img src=""" & viBsimg & """ thumb=""" & viBstmb & """ alt=""" & replace(oItem.Prd.FItemName,"""","") & """ /></p>"
							end if

							'누끼 이미지 (큰이미지가 있으면 큰걸로 취합)
							if ImageExists(oitem.Prd.FImageMask1000) then
								viMkimg = oitem.Prd.FImageMask1000
							elseif ImageExists(oitem.Prd.FImageMask) then
								viMkimg = oitem.Prd.FImageMask
							end if

							if viMkimg<>"" then
								viMktmb = getThumbImgFromURL(viMkimg,40,40,"true","false")
								viMkimg = getThumbImgFromURL(viMkimg,400,400,"true","false")
								
								Response.write "<p><img src=""" & viMkimg & """ thumb=""" & viMktmb & """ alt=""" & replace(oItem.Prd.FItemName,"""","") & """ /></p>"
							end if

							'추가 이미지 (큰이미지가 있으면 큰걸로 취합)
							If oAdd.FResultCount > 0 Then
								For i= 0 to oAdd.FResultCount-1
									viAdImg = "": viAdtmb=""
									If oAdd.FADD(i).FAddImageType=0 Then
										'if ImageExists(oAdd.FADD(i).FAddimage1000) then
										'	viAdImg = oAdd.FADD(i).FAddimage1000
										if ImageExists(oAdd.FADD(i).FAddimage600) then
											viAdImg = oAdd.FADD(i).FAddimage600
										elseif ImageExists(oAdd.FADD(i).FAddimage) then
											viAdImg = oAdd.FADD(i).FAddimage
										end if
										
										if viAdImg<>"" then
											viAdtmb = getThumbImgFromURL(viAdImg,40,40,"true","false")
											viAdImg = getThumbImgFromURL(viAdImg,400,400,"true","false")

											Response.write "<p><img src=""" & viAdImg & """ thumb=""" & viAdtmb & """ alt=""" & replace(oItem.Prd.FItemName,"""","") & """ /></p>"
										end if
									end if
								Next
							End if
						%>
						</div>
					</div>
					<% IF (oItem.Prd.isLimitItem) and not (oItem.Prd.isSoldout or oItem.Prd.isTempSoldOut) and (Not IsReceiveSiteItem) and Not(IsPresentItem and oItem.Prd.FRemainCount>200 ) Then %>
					<p class="limitV15"><strong><% = oItem.Prd.FRemainCount & chkIIF(IsTicketItem,"좌석","개") %></strong> 남았습니다.</p>
					<% end if %>
				</div>
				<% if (isValidSecretItemcouponExists) then %>
					<form name="frmSecretCpn" method="post" action="/shoppingtoday/couponshop_process.asp" style="margin:0px;">
					<input type="hidden" name="stype" value="prdsecret">
					<input type="hidden" name="idx" value="">
					</form>
					<script>
						function jsDownSecretCoupon(idx){
						<% if (NOT IsUserLoginOK) then %>
							jsChklogin('<%=IsUserLoginOK%>');
							return;
						<% else %>
							var frm;
							frm = document.frmSecretCpn;
							frm.idx.value = idx;
							frm.submit();
						<% end if %>
						}
					</script>
				<% end if %>
				<div class="pdtDetailWrap">
					<div class="pdtInfoV15">
						<div class="pdtSaleInfoV15">
						<form name="sbagfrm" method="post" action="" style="margin:0px;">
						<input type="hidden" name="mode" value="add">
						<input type="hidden" name="itemid" value="<% = oitem.Prd.FItemid %>">
						<input type="hidden" name="sitename" value="<%= session("rd_sitename") %>">
						<input type="hidden" name="itemoption" value="">
						<input type="hidden" name="userid" value="<%= LoginUserid %>">
						<input type="hidden" name="itemPrice" value="<%= oItem.Prd.getRealPrice %>">
						<input type="hidden" name="isPhotobook" value="<%= ISFujiPhotobook %>">
						<input type="hidden" name="isPresentItem" value="<%= isPresentItem %>">
						<input type="hidden" name="isRentalItem" value="<%= isRentalItem %>">
						<input type="hidden" name="rentalmonth" id="rentalmonth" value="">
							<div class="pdtBasicV15">
								<p class="pdtBrand">
									<a href="/street/street_brand.asp?makerid=<%= oItem.Prd.FMakerid %>" onclick="opener.GoToBrandShop('<%= oItem.Prd.FMakerid %>'); self.close(); return false;" class="rMar05"><span><%= UCase(oItem.Prd.FBrandName) %></span></a>
									<a href="" id="zzimBrandCnt" onclick="TnMyBrandJJim('<%= oItem.Prd.FMakerid %>', '<%= oItem.Prd.FBrandName %>'); return false;"></a>
									<dfn id="zzimBr_<%= oItem.Prd.FMakerid %>" class="<%=chkIIF(isMyFavBrand,"zzimBrV15","")%>">찜브랜드</dfn></a>
								</p>
								<h2><p class="pdtName"><%= replace(replace(oItem.Prd.FItemName,"<br>"," "),"<br />"," ") %></p></h2>
								<p class="pdtDesp"><%= oItem.Prd.FDesignerComment %></p>
							</div>
							<div class="detailInfoV15">
								<% If (IsRentalItem) Then %>
									<%'!-- for dev msg : 이니시스 렌탈 상품상세 추가 --> %>
									<dl class="saleInfo">
										<dt>이니렌탈 시</dt>
										<dd>
											<div class="rental-info">
												<div class="pick-month">
													<select class="optSelect2 select" onchange="iniRentalPriceCalculation(this.value);">
														<%'// 테스트용으로 4월 19일 부터 셋팅 실서버 배포시에는 5월 3일 10시로 바꿔야됨%>
														<% If now() >= #2021-05-03 09:00:00# and now() < #2021-06-01 00:00:00# Then %>
															<%'// 이니렌탈 이벤트(2021년 5월 3일~2021년 5월 31일)%>
															<option value="12" checked>24개월 간</option>
															<option value="24">24개월 간</option>
															<option value="36">36개월 간</option>
															<% If oItem.Prd.FSellCash > 1000000 Then %>
																<option value="48">48개월 간</option>
															<% End If %>															
														<% Else %>
															<%'// 2021년 8월 2일부터 md 요청으로 인해 12개월 기본값으로 변경 %>
															<option value="12" checked>12개월 간</option>
															<option value="24">24개월 간</option>
															<option value="36">36개월 간</option>
															<%'// 아래 기간동안 48개월 간 표시 안함%>
															<% If now() >= #2021-07-27 00:00:00# and now() < #2022-01-10 00:00:00# Then %>
															<% Else %>
																<% If oItem.Prd.FSellCash > 1000000 Then %>
																	<option value="48">48개월 간</option>
																<% End If %>
															<% End If %>
														<% End If %>
													</select>
													<strong class="cRd0V15">월<span id="rentalMonthPrice"> 0원</span></strong>
												</div>
												<div class="link">
													<a href="/shopping/pop_rental_info.asp" onclick="window.open(this.href, 'popbenefit', 'width=1000,height=800,left=300,scrollbars=auto,resizable=yes'); return false;" >이니렌탈이 뭔가요?</a>
												</div>
											</div>
										</dd>
									</dl>
								<% Else %>
									<dl class="saleInfo">
										<dt>판매가</dt>
										<dd><strong class="cBk0V15"><%= FormatNumber(oItem.Prd.getOrgPrice,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","원")%></strong></dd>
									</dl>
									<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
									<dl class="saleInfo">
										<dt>할인판매가</dt>
										<dd><strong class="cRd0V15">
											<%
												Response.Write FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","원") & " ["
												If oItem.Prd.FOrgprice = 0 Then
													Response.Write "0%]"
												Else
													Response.Write CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) & "%]"
												End If
											%>
										</strong></dd>
									</dl>
									<% End If %>
								<% End If %>								
								<% if oItem.Prd.IsSaleItem and oItem.Prd.IsSpecialUserItem then %>
								<dl class="saleInfo">
									<dt>우수회원가</dt>
									<dd><strong class="cRd0V15"><%= FormatNumber(oItem.Prd.getRealPrice,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","원")%> [<% = getSpecialShopPercent() %>%]</strong> <a href="/my10x10/special_shop.asp" target="_blank" class="btn btnS3 btnRed lMar10"><em class="whiteArr01 fn">우수회원샵</em></a></dd>
								</dl>
								<% end if %>
								<% if oitem.Prd.isCouponItem Then %>
								<dl class="saleInfo">
									<dt>쿠폰적용가</dt>
									<dd>
										<strong class="cGr0V15"><%= FormatNumber(oItem.Prd.GetCouponAssignPrice,0) %>원 [<%= oItem.Prd.GetCouponDiscountStr %>]</strong>&nbsp;
										<% if Not(IsPresentItem) and oitem.Prd.isCouponItem Then %>
										<% if (isValidSecretItemcouponExists) then %>
										<a href="" onclick="jsDownSecretCoupon('<%= secretcouponidx %>'); return false;" class="btn btnS2 btnGrn fn btnW120"><span class="download">시크릿 쿠폰다운</span></a>&nbsp;
										<% else %>
										<a href="" onclick="DownloadCoupon('<%= oitem.Prd.FCurrItemCouponIdx %>'); return false;" class="btn btnS2 btnGrn fn btnW75"><span class="download">쿠폰다운</span></a>&nbsp;
										<% end if %>
										<% end if %>
									</dd>
								</dl>
								<% End If %>
							</div>
							<div class="detailInfoV15">
								<% If Not(IsRentalItem) Then %>
									<% if oItem.Prd.FMileage then %>
									<dl class="saleInfo">
										<dt>마일리지</dt>
										<%'// 2018 회원등급 개편%>
										<dd><strong><% = formatNumber(oItem.Prd.FMileage,0) %> Point <% If Not(IsUserLoginOK()) Then %>~<% End If %></strong></dd>
									</dl>
									<% End If %>
								<% End If %>
								<% If (IsTicketItem) Then '티켓상품 %>
								<dl class="saleInfo">
									<dt>티켓수령</dt>
									<dd><% = oTicket.FOneItem.getTicketDlvName %></dd>
								</dl>
								<% else '일반상품%>
								<dl class="saleInfo">
									<dt>배송구분</dt>
									<dd>
									<% if oItem.Prd.IsAboardBeasong then %>
										<span class="icoAbroadV15">텐바이텐<%=chkIIF(oItem.Prd.IsFreeBeasong,"무료","")%>배송+해외배송</span>&nbsp;
									<% elseif IsPresentItem then %>
										<span><% = oItem.Prd.GetDeliveryName %></span>&nbsp;
									<% ElseIf oItem.Prd.IsOverseasDirectPurchase Then '//해외 직구 배송 %>
										<span class="icoDirectV17"><em class="cBl0V17">해외직구 배송</em></span>&nbsp;&nbsp;<a href="" onclick="ODPorderinfo();return false;"><span class="more1V15">배송정보 안내</span></a>
									<% else %>
										<span><% = oItem.Prd.GetDeliveryName %></span>&nbsp;
									<% end if %>
									</dd>
								</dl>
								<% end if %>
								<dl class="saleInfo">
									<dt>원산지</dt>
									<dd><strong><% = oItem.Prd.FSourceArea %></strong></dd>
								</dl>
							</div>
							<% If (IsTicketItem) Then '티켓상품 %>
							<div class="detailInfoV15">
								<dl class="saleInfo">
									<dt>장르</dt>
									<dd><% = oTicket.FOneItem.FtxGenre  %></dd>
								</dl>
								<dl class="saleInfo">
									<dt>일시</dt>
									<dd><%= FormatDate(oTicket.FOneItem.FstDt,"0000.00.00") %>~<%= FormatDate(oTicket.FOneItem.FedDt,"0000.00.00") %></dd>
								</dl>
								<dl class="saleInfo">
									<dt>관람시간</dt>
									<dd><%= oTicket.FOneItem.FtxRunTime%></dd>
								</dl>
								<dl class="saleInfo">
									<dt>장소</dt>
									<dd><%= oTicket.FOneItem.FticketPlaceName %></dd>
								</dl>
								<dl class="saleInfo">
									<dt>관람등급</dt>
									<dd><%= oTicket.FOneItem.FtxGrade%></dd>
								</dl>
							</div>
							<% end if %>
							<div class="detailInfoV15">
								<dl class="saleInfo">
									<dt><%=chkIIF(IsTicketItem,"예매수량","주문수량")%></dt>
									<dd id="lyItemEa" style="margin-top:-2px;">
									<% if Not(IsPresentItem) then %>
										<input type="text" id="itemea" style="width:30px" class="txtInp ct" />
										<span class="orderNumAtc"></span>
										<script type="text/javascript">
										$("#itemea").numSpinner({min:<%=chkIIF(oItem.Prd.IsLimitItemReal and oItem.Prd.FRemainCount<=0,"0",oItem.Prd.ForderMinNum)%>,max:<%=chkIIF(oItem.Prd.IsLimitItemReal,CHKIIF(oItem.Prd.FRemainCount<=oItem.Prd.ForderMaxNum,oItem.Prd.FRemainCount,oItem.Prd.ForderMaxNum),oItem.Prd.ForderMaxNum)%>,step:1,value:1});
										</script>
									<% else %>
										<input type="hidden" name="itemea" value="1" />
										<span>1</span>개 (한번에 하나씩만 구매가 가능합니다.)
									<% end if %>
									</dd>
								</dl>
							</div>
							<div class="detailInfoV15">
								<% IF oItem.Prd.FOptionCnt>0 then %>
								<dl class="saleInfo">
									<dt>옵션선택</dt>
									<dd style="margin-top:-2px;">
										<p class="itemoption">
										<% if (IsReceiveSiteItem) or (IsPresentItem) or (IsTicketItem) or (oItem.Prd.Flimitdispyn="N") then %>
										<%= GetOptionBoxDpLimitHTML(itemid, oitem.Prd.IsSoldOut,Not(IsReceiveSiteItem) and Not(IsPresentItem and oItem.Prd.FRemainCount>200) and Not(IsTicketItem and oItem.Prd.FRemainCount>100) and Not(oItem.Prd.Flimitdispyn="N")) %>
										<% else %>
										<%= GetOptionBoxHTML(itemid, oitem.Prd.IsSoldOut) %>
										<% end if %>
										</p>
									</dd>
								</dl>
								<% end if %>
								<% if (oItem.Prd.FItemDiv = "06") and (Not ISFujiPhotobook) then %>
								<dl class="saleInfo">
									<dt>문구입력란</dt>
									<dd>
										<textarea style="width:330px; height:50px;" name="requiredetail" id="requiredetail"></textarea>
									</dd>
								</dl>
								<% end if %>
							</div>
							<!-- 주문 확인 사항 -->
							<% IF oItem.Prd.FAvailPayType="9" OR oItem.Prd.FAvailPayType="8" or IsPresentItem Then %>
							<div class="checkContV15">
								<dl class="saleInfo">
									<dt>필수 확인사항</dt>
									<dd>
										<ul class="checkListV15">
										<% IF oItem.Prd.FAvailPayType="9" OR oItem.Prd.FAvailPayType="8" Then %>
											<li>선착순 판매 상품은 실시간 결제로만 구매 가능(무통장 결제 불가)</li>
										<% end if %>
										<% if (IsPresentItem) then %>
											<li>텐바이텐 회원만 주문 가능</li>
											<li>일반상품과 함께 주문 불가 (단독주문)</li>
											<li>한 ID당 최대 2회까지 주문 가능</li>
											<% '// 텐텐배송 2500으로 변경 %>
											<% If (Left(Now, 10) >= "2019-01-01") Then %>
												<li>주문 건당 2,500원의 배송비 부과</li>
											<% Else %>
												<li>주문 건당 2,000원의 배송비 부과</li>
											<% End If %>
										<% end if %>
										</ul>
									</dd>
								</dl>
							</div>
							<% end if %>
						</div>
						<div class="pdtAddInfoV15">
							<div class="interactInfoV15">
								<dl>
									<dt>Review</dt>
									<dd>
										<% if oItem.Prd.FEvalCnt>0 then %><a href="" onClick="popEvaluate('<%= itemid %>','ne'); return false;">(<%=oItem.Prd.FEvalCnt%>)</a><% end if %>
										<a href="/my10x10/goodsUsing.asp?EvaluatedYN=N" target="_blank" class="btnwrite"><span>쓰기</span></a>
									</dd>
								</dl>
								<dl>
									<dt>Gift Talk</dt>
									<dd>
										<% if vTalkCnt>0 then %><a href="/gift/talk/search.asp?itemid=<%=itemid%>" target="_blank">(<%=vTalkCnt%>)</a><% end if %>
										<a href="" onClick="frmtalk.submit(); return false;" class="btnwrite"><span>쓰기</span></a>
									</dd>
								</dl>
							</div>
						</div>
						</form>
					</div>
					<div class="btnArea">
					<%	'### 상품 종류 : 일반, 포토북, 티켓	(Case 정리; 2011-04-20 강준구.)
						Dim vBuyButton : vBuyButton = ""
						Dim vBuyAlert		'장바구니 담기 안내 팝업레이어
						vBuyAlert = "<div class=""alertLyrV15"" style=""display:none;"">" & vbCrLf
						vBuyAlert = vBuyAlert & "	<div class=""alertBox"">" & vbCrLf
						vBuyAlert = vBuyAlert & "		<em class=""closeBtnV15"" onclick=""$('.alertLyrV15').fadeOut('fast');"">&times;</em>" & vbCrLf
						vBuyAlert = vBuyAlert & "		<div class=""alertInner"">" & vbCrLf
						vBuyAlert = vBuyAlert & "			<p><strong class=""cBk0V15"" id=""alertMsgV15"">선택하신 상품을<br />장바구니에 담았습니다.</strong></p>" & vbCrLf
						vBuyAlert = vBuyAlert & "			<p class=""tPad10"">" & vbCrLf
						vBuyAlert = vBuyAlert & "				<a href="""" onclick=""$('.alertLyrV15').fadeOut('fast'); return false;"" class=""btn btnS1 btnRed"">쇼핑 계속하기</a>" & vbCrLf
						vBuyAlert = vBuyAlert & "				<a href="""" onclick=""opener.TnGotoShoppingBag(); self.close(); return false;"" class=""btn btnS1 btnWhite"">장바구니 가기</a>" & vbCrLf
						vBuyAlert = vBuyAlert & "			</p>" & vbCrLf
						vBuyAlert = vBuyAlert & "		</div>" & vbCrLf
						vBuyAlert = vBuyAlert & "	</div>" & vbCrLf
						vBuyAlert = vBuyAlert & "</div>" & vbCrLf


						If oItem.Prd.isSoldout or oItem.Prd.isTempSoldOut Then	'### 일반, 포토북, 티켓 품절일 경우
							vBuyButton = vBuyButton & "<span style=""width:330px;""><a href="""" class=""btn btnB1 btnGry"" onclick=""return false;"">SOLD OUT</a></span>"
						Else
							If (ISFujiPhotobook) Then	'### 포토북 일 경우
								vBuyButton = vBuyButton & "<span style=""width:330px;""><a href="""" onclick=""loadPhotolooks('" & itemid & "'); return false;"" class=""btn btnB1 btnRed"">포토북 편집 후 구매</a></span>"
							ElseIf (isPresentItem) Then	'### Present상품일 경우
								If IsUserLoginOK() Then		'# 로그인한 경우
									vBuyButton = vBuyButton & "<span style=""width:145px;""><a href="""" onclick=""FnZoomAddShoppingBag(false); return false;"" class=""btn btnB1 btnRed"">바로신청</a></span>"
									vBuyButton = vBuyButton & "<span class=""lPad10 btnCartV15""><a href="""" onclick=""FnZoomAddShoppingBag(true); return false;"" class=""btn btnB1 btnWhite"">장바구니</a>" & vBuyAlert & "</span>"
								Else
									vBuyButton = vBuyButton & "<span style=""width:145px;""><a href="""" onclick=""alert('회원 구매만 가능합니다. 로그인 후 구매해 주세요.'); return false;"" class=""btn btnB1 btnRed"">바로신청</a></span>"
									vBuyButton = vBuyButton & "<span class=""lPad10 btnCartV15""><a href="""" onclick=""alert('회원 구매만 가능합니다. 로그인 후 장바구니에 담아 주세요.'); return false;"" class=""btn btnB1 btnWhite"">장바구니</a></span>"
								End If
							ElseIf (isPresentItem) Then	'### 렌탈 상품일 경우
								If IsUserLoginOK() Then		'# 로그인한 경우
									vBuyButton = vBuyButton & "<span style=""width:145px;""><a href="""" onclick=""FnZoomAddShoppingBag(false); return false;"" class=""btn btnB1 btnRed"">렌탈하기</a></span>"
									vBuyButton = vBuyButton & "<span class=""lPad10 btnCartV15""><a href="""" onclick=""FnZoomAddShoppingBag(true); return false;"" class=""btn btnB1 btnWhite"">장바구니</a>" & vBuyAlert & "</span>"
								Else
									vBuyButton = vBuyButton & "<span style=""width:145px;""><a href="""" onclick=""alert('회원 구매만 가능합니다. 로그인 후 구매해 주세요.'); return false;"" class=""btn btnB1 btnRed"">렌탈하기</a></span>"
									vBuyButton = vBuyButton & "<span class=""lPad10 btnCartV15""><a href="""" onclick=""alert('회원 구매만 가능합니다. 로그인 후 장바구니에 담아 주세요.'); return false;"" class=""btn btnB1 btnWhite"">장바구니</a></span>"
								End If								
							Else
								If (Not IsTicketItem) Then	'### 일반 상품인 경우
									vBuyButton = vBuyButton & chkIIF(oItem.Prd.IsMileShopitem,"","<span style=""width:145px;""><a href="""" onclick=""FnZoomAddShoppingBag(false); return false;"" class=""btn btnB1 btnRed"">바로구매</a></span>")
									vBuyButton = vBuyButton & "<span class=""lPad10 btnCartV15""><a href="""" onclick=""FnZoomAddShoppingBag(true); return false;"" class=""btn btnB1 btnWhite"">장바구니</a>" & vBuyAlert & "</span>"
								Else
									'### 티켓 상품인 경우
									If Not oTicket.FOneItem.IsExpiredBooking Then	'판매 기간중 일 경우
										If IsUserLoginOK() Then		'# 로그인한 경우
											vBuyButton = vBuyButton & "<span style=""width:145px;""><a href="""" onclick=""FnZoomAddShoppingBag(false); return false;"" class=""btn btnB1 btnRed"">바로신청</a></span>"
											vBuyButton = vBuyButton & "<span class=""lPad10 btnCartV15""><a href="""" onclick=""FnZoomAddShoppingBag(true); return false;"" class=""btn btnB1 btnWhite"">장바구니</a>" & vBuyAlert & "</span>"
										Else
											vBuyButton = vBuyButton & "<span style=""width:145px;""><a href="""" onclick=""alert('회원 구매만 가능합니다. 로그인 후 구매해 주세요.'); return false;"" class=""btn btnB1 btnRed"">바로신청</a></span>"
											vBuyButton = vBuyButton & "<span class=""lPad10 btnCartV15""><a href="""" onclick=""alert('회원 구매만 가능합니다. 로그인 후 장바구니에 담아 주세요.'); return false;"" class=""btn btnB1 btnWhite"">장바구니</a></span>"
										End If
									Else
										vBuyButton = vBuyButton & "<span style=""width:330px;""><a href="""" class=""btn btnB1 btnGry"" onclick=""return false;"">SOLD OUT</a></span>"
									End IF
								End IF
							End IF
						End IF
						Response.Write vBuyButton
					%>
						<span class="lPad10" style="*width:110px;"><a href="" id="wsIco<%=Itemid %>" onclick="TnAddFavorite(<%=itemid%>);return false;" class="btn btnB1 btnWhite3 <%=chkIIF(isMyFavItem,"myWishMarkV15","")%>"><em class="wishActionV15"><%= FormatNumber(oItem.Prd.FfavCount,0) %></em></a></span>
					</div>
					<div class="btnArea">
						<a href="/shopping/category_prd.asp?itemid=<%= oItem.Prd.FItemID %>" onclick="opener.TnGotoProduct(<%=itemid%>); self.close(); return false;" class="btn btnB1 btnWhite2" target="_blank"><em class="gryArr01">상품상세보기</em></a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<form name="frmtalk" method="post" action="/gift/talk/write.asp" target="_blank">
	<input type="hidden" name="isitemdetail" value="o">
	<input type="hidden" name="ritemid" value="<%=itemid%>">
	</form>
	<div class="popFooter">
		<div class="btnArea">
			<button type="button" class="btn btnS1 btnGry2" onclick="window.close();">닫기</button>
		</div>
	</div>
</div>
</body>
</html>
<%
	set oItem = Nothing
	set oADD =Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
