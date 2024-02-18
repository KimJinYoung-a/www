<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/base64.asp" -->
<!-- #include virtual="/lib/classes/item/dealCls.asp" -->
<!-- #include virtual="/lib/classes/item/itemInfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryPrdCls.asp" -->
<!-- #include virtual="/lib/classes/item/ItemOptionCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/classes/search/searchCls.asp" -->
<!-- #include virtual="/lib/classes/shopping/sp_evaluatesearchercls.asp" -->
<!-- #include virtual="/lib/classes/shopping/sp_item_qnacls.asp" -->
<!-- #include virtual="/lib/classes/item/PlusSaleItemCls.asp" -->
<!-- #include virtual="/lib/classes/item/ticketItemCls.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/diarystory2016/lib/classes/diary_class_B.asp" -->
<!-- #include virtual="/lib/classes/ordercls/pack_cls.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<%
dim itemid, oItem, itEvtImg, itEvtImgMap, itEvtImgNm, sCatNm, lp, LoginUserid, cpid, IsTicketItem, IsSpcTravelItem, oTicket, addEx, clsDiaryPrdCheck, DiaryPreviewImgLoad, DiarySearchValue, GiftSu
dim oADD, i, ix, ISFujiPhotobook, IsPresentItem, IsReceiveSiteItem, catecode, cTalk, vTalkCnt, makerid, itemVideos, DealCouponYn, DealBrandCheck, DealBrandName
itemid = requestCheckVar(request("itemid"),9)
LoginUserid = getLoginUserid()
DealCouponYn="N"
DealBrandCheck="Y"
DealBrandName=""

If Request.ServerVariables("SERVER_PORT") = "443" Then
	Response.Redirect "http://" & Request.ServerVariables("SERVER_NAME") & Request.ServerVariables("PATH_INFO") & "?" & Request.ServerVariables("QUERY_STRING")
End If

'// 에코마케팅용 레코벨 스크립트 용(2016.12.21)
Dim vPrtr
vPrtr = requestCheckVar(request("pRtr"),200)

'============== 모바일 접근시 모바일 페이지 이동(referer가 10x10이면 이동안함) ============
if InStr(request.ServerVariables("HTTP_REFERER"),"10x10.co.kr")<1 then
	if Not(Request("mfg")="pc" or session("mfg")="pc") then
		if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
			dim mQrParam: mQrParam = request.QueryString		'// 유입 전체 파라메터 접수
			Response.Redirect "http://m.10x10.co.kr/category/category_itemPrd.asp?" & mQrParam
			REsponse.End
		end if
	end if
end if


'####### DB에서 가져오는 컴퍼넌트 사용여부 '(ex: 사용후기, 상품문의, 브랜드BEST, 해피투게더, 관련이벤트, 테스터후기 ) #######
''flgDBUse = true			'inc_const.asp에 cFlgDBUse 변수로 이전 (2015.12.18; 허진원)


'======================================== 상품코드 정확성체크 및 상품관련내용 ====================================
if itemid="" or itemid="0" then
	Call Alert_Return("상품번호가 없습니다.")
	response.End
elseif Not(isNumeric(itemid)) then
	Call Alert_Return("잘못된 상품번호입니다.")
	response.End
else	'정수형태로 변환
	itemid=CLng(getNumeric(itemid))
end if

if itemid=0 then
	Call Alert_Return("잘못된 상품번호입니다.")
	response.End
end if

set oItem = new CatePrdCls
oItem.GetItemData itemid

'=============================== 딜 추가 정보 ==========================================
Dim oDeal, ArrDealItem
Set oDeal = New DealCls
oDeal.GetIDealInfo itemid
If oDeal.Prd.FDealCode="" Then
	Response.write "<script>alert('딜 상품 정보가 부족합니다.');history.back();</script>"
	Response.End
End If
ArrDealItem=oDeal.GetDealItemList(oDeal.Prd.FDealCode)

If isArray(ArrDealItem) Then
Else
	Call Alert_Return("존재하지 않는 상품입니다.")
	response.End
End If

if oItem.FResultCount=0 then
	Call Alert_Return("존재하지 않는 상품입니다.")
	response.End
end If

if oDeal.Prd.FMasterItemCode="" Or oDeal.Prd.FMasterItemCode=0 Or isnull(oDeal.Prd.FMasterItemCode) then
	Call Alert_Return("존재하지 않는 상품입니다.")
	response.End
end if

if oItem.Prd.Fisusing="N" then
	if GetLoginUserLevel()=7 then
		'STAFF는 종료상품도 표시
		Response.Write "<script>alert('판매가 종료되었거나 삭제된 상품입니다.');</script>"
	else
		'// 수정 2017-03-09 이종화 - 종료 상품일시 - page redirect
		'Call Alert_Return("판매가 종료되었거나 삭제된 상품입니다.")
		'response.End
		Response.redirect("/shopping/closedprd.asp?"&request.servervariables("QUERY_STRING"))
	end if
end if

Dim ofavItem
set ofavItem = new CatePrdCls
ofavItem.GetItemData oDeal.Prd.FMasterItemCode

itemid = oItem.Prd.FItemid
makerid = oItem.Prd.FMakerid
catecode = requestCheckVar(request("disp"),18)
If catecode <> "" Then
	If IsNumeric(catecode) = False Then
		catecode = ""
	End If
End If

if catecode="" or (len(catecode) mod 3)<>0 then catecode = oItem.Prd.FcateCode

'// fuji FDI photobook 2010-06-14
ISFujiPhotobook = oItem.Prd.FMakerid="fdiphoto"

'// Present상품
IsPresentItem = (oItem.Prd.FItemDiv = "09")

'// 스페셜 항공권 상품 (ex 진에어 이벤트)
IsSpcTravelItem = oitem.Prd.IsTravelItem and oItem.Prd.Fmakerid = "10x10Jinair"

'2015 APP전용 상품 안내
if IsPresentItem or oItem.Prd.FOrgMakerid="10x10present" or itemid=1250336 then
	Call Alert_Move("본 상품은 텐바이텐 APP에서만 보실 수 있습니다.","/")
	dbget.Close: Response.End
end if

'// 현장수령 상품
IsReceiveSiteItem = (oItem.Prd.FDeliverytype="6")

'// 티켓팅
IsTicketItem = (oItem.Prd.FItemDiv = "08")
If IsTicketItem Then
	set oTicket = new CTicketItem
	oTicket.FRectItemID = itemid
	oTicket.GetOneTicketItem
End If

'// 상품설명 추가
set addEx = new CatePrdCls
	addEx.getItemAddExplain itemid

'// 상품상세설명 동영상 추가
Set itemVideos = New catePrdCls
	itemVideos.fnGetItemVideos itemid, "video1"
'================================================================================================================
'=============================== 이메일특가 번호 접수 및 특가 계산 (base64사용) =================================
cpid = requestCheckVar(request("ldv"),12)
if Not(cpid="" or isNull(cpid)) then
	cpid = trim(Base64decode(cpid))
	if isNumeric(cpid) then
		oItem.getTargetCoupon cpid, itemid
	end if
ElseIf Left(request.Cookies("rdsite"), 6) = "nvshop" Then
	Dim naverSpecialcpID
	if (application("Svr_Info")<>"Dev") then
		naverSpecialcpID = 12772
	Else
		naverSpecialcpID = 11150
	End If

	if isNumeric(naverSpecialcpID) then
		oItem.getTargetCoupon naverSpecialcpID, itemid
	end if
end if
'================================================================================================================
'=============================== 추가 이미지 & 추가 이미지-메인 이미지 ==========================================
set oADD = new CatePrdCls
oADD.getAddImage oDeal.Prd.FMasterItemCode

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

'=============================== 추가 정보 ==========================================
dim isMyFavBrand: isMyFavBrand=false
dim isMyFavItem: isMyFavItem=false
if IsUserLoginOK then
	isMyFavBrand = getIsMyFavBrand(LoginUserid,oItem.Prd.FMakerid)
	isMyFavItem = getIsMyFavItem(LoginUserid,oDeal.Prd.FMasterItemCode)
end if

'================================================================================================================
'=============================== 해더의 타이틀 및 관련태그의 삽입처리 ===========================================
'타이틀 설정
strPageTitle = "텐바이텐 10X10 : " & Replace(oItem.Prd.FItemName,"""","")
if oItem.Prd.isDealSoldout then
	strPageKeyword = ""
else
	strPageKeyword = Replace(oItem.Prd.FItemName,"""","") & ", " & Replace(oItem.Prd.FBrandName,"""","") & ", " & Replace(oItem.Prd.FBrandName_kor,"""","")
end if

'// 상품 쿠폰 내용  '!
Function GetCouponDiscount(itemcoupontype, itemcouponvalue)

	Select Case itemcoupontype
		Case "1"
			GetCouponDiscount =CStr(itemcouponvalue) + "%"
		Case "2"
			GetCouponDiscount = formatNumber(itemcouponvalue,0) + "원 할인"
		Case "3"
			GetCouponDiscount ="무료배송"
		Case Else
			GetCouponDiscount = itemcoupontype
	End Select

End Function

'// 상품 가격 계산
Function GetDealCouponPrice(sellcash, itemcouponvalue, itemcoupontype)
	Dim tmp
	Select case itemcoupontype
		case "1" ''% 쿠폰
			tmp = CLng(itemcouponvalue*sellcash/100)
		case "2" ''원 쿠폰
			tmp = itemcouponvalue
		case "3" ''무료배송 쿠폰
			tmp = 0
		case else
			tmp = 0
	end Select
	GetDealCouponPrice = sellcash - tmp
End Function

'페이지 설명 설정
if trim(oItem.Prd.FDesignerComment)<>"" then strPageDesc = "생활감성채널 텐바이텐- " & Replace(Trim(oItem.Prd.FDesignerComment),"""","")
'페이지 요약 이미지(SNS 퍼가기용)
strPageImage = getFirstAddimage
'페이지 URL(SNS 퍼가기용)
strPageUrl = "http://10x10.co.kr/" & itemid

'RecoPick 스트립트 관련 내용 추가; 2013.12.05 허진원 추가
'레코픽 서비스 종료로 인한 제거 150630 원승현
'strRecoPickMeta = "	<meta property=""recopick:price"" content=""" & oItem.Prd.getRealPrice & """>"	'head.asp에서 출력
'if oItem.Prd.isDealSoldout then	strRecoPickMeta = strRecoPickMeta & vbCrLf & "	<meta property=""product:availability"" content=""oos"">"
'RecoPickSCRIPT = "	recoPick('sendLog', 'view', '" & itemid & "');"										'incFooter.asp 에서 출력

'// 구글 어낼리틱스 유니버셜 스크립트용으로 전환(2016.03.10)
googleANAL_PRESCRIPT = "ga('set','dimension1','"&itemid&"');" & VbCrlf

'//기프트톡 카운트
vTalkCnt = oItem.fnGetGiftTalkCount(itemid)
'================================================================================================================
'=============================== 다이어리 상품 체크 유무. 사용때만 주석풀기 맨아래 clsDiaryPrdCheck Nothing 에도.
set clsDiaryPrdCheck = new cdiary_list
	clsDiaryPrdCheck.FItemID = itemid
	clsDiaryPrdCheck.DiaryStoryProdCheck
	If clsDiaryPrdCheck.FResultCount  > 0 then
		GiftSu = clsDiaryPrdCheck.getGiftDiaryExists(itemid)	'다이어리 상은품 남은수량
	end If

If clsDiaryPrdCheck.FResultCount > 0 Then
	'// 다이어리 프리뷰 이미지.
	Set DiaryPreviewImgLoad = new cdiary_list
		DiaryPreviewImgLoad.Fidx		= clsDiaryPrdCheck.FDiaryID
		DiaryPreviewImgLoad.getPreviewImgLoad

	'// 다이어리 검색어값
	Set DiarySearchValue = new cdiary_list
		DiarySearchValue.Fidx		= clsDiaryPrdCheck.FDiaryID
		DiarySearchValue.getSearchValueSet

End If

'// 제품상세 facebook 픽셀 스크립트 추가 2016.09.22 원승현
facebookSCRIPT = "<script>" & vbCrLf &_
				"!function(f,b,e,v,n,t,s){if(f.fbq)return;n=f.fbq=function(){n.callMethod?n.callMethod.apply(n,arguments):n.queue.push(arguments)};if(!f._fbq)f._fbq=n;" & vbCrLf &_
				"n.push=n;n.loaded=!0;n.version='2.0';n.queue=[];t=b.createElement(e);t.async=!0;" & vbCrLf &_
				"t.src=v;s=b.getElementsByTagName(e)[0];s.parentNode.insertBefore(t,s)}(window,document,'script','//connect.facebook.net/en_US/fbevents.js');" & vbCrLf &_
				"fbq('init', '260149955247995');" & vbCrLf &_
				"fbq('init', '889484974415237');" & vbCrLf &_
				"fbq('track','PageView');" & vbCrLf &_
				"fbq('track', 'ViewContent',{content_ids:['"&itemid&"'],content_type:'product'});</script>" & vbCrLf &_
				"<noscript><img height=""1"" width=""1"" style=""display:none"" src=""https://www.facebook.com/tr?id=260149955247995&ev=PageView&noscript=1"" /></noscript>" & vbCrLf &_
				"<noscript><img height=""1"" width=""1"" style=""display:none"" src=""https://www.facebook.com/tr?id=889484974415237&ev=PageView&noscript=1"" /></noscript>"

'// 상품상세 로그 사용여부(2017.01.12)
Dim LogUsingCustomChk
If LoginUserId="thensi7" Then
	LogUsingCustomChk = True
Else
	LogUsingCustomChk = True
End If

'// 상품상세 로그저장(2017.01.11 원승현)
If LogUsingCustomChk Then
	If IsUserLoginOK() Then
		'// 검색을 통해서 들어왔을경우
		If Trim(vPrtr)<>"" Then
			Call fnUserLogCheck("itemrect", LoginUserid, itemid, "", Trim(vPrtr), "pc")
		Else
			Call fnUserLogCheck("item", LoginUserid, itemid, "", "", "pc")
		End If
	End If
End If

'// 구글 ADS 스크립트 관련(2018.09.21 신규버전 추가)
googleADSCRIPT = " <script> "
googleADSCRIPT = googleADSCRIPT & "   gtag('event', 'page_view', { "
googleADSCRIPT = googleADSCRIPT & "     'send_to': 'AW-851282978', "
googleADSCRIPT = googleADSCRIPT & "     'ecomm_pagetype': 'product', "
googleADSCRIPT = googleADSCRIPT & "     'ecomm_prodid': '"&itemid&"', "
googleADSCRIPT = googleADSCRIPT & "     'ecomm_totalvalue': "&oItem.Prd.FSellCash&" "
googleADSCRIPT = googleADSCRIPT & "   }); "
googleADSCRIPT = googleADSCRIPT & " </script> "

Function ZeroTime(hs)
	If hs<10 Then
		ZeroTime="0"+hs
	Else
		ZeroTime=hs
	End If
End Function

'// 비회원일경우 회원가입 이후 페이지 이동을 위해 현재 페이지 주소를 쿠키에 저장해놓는다.
If Not(IsUserLoginOK) Then
	response.cookies("sToMUP") = tenEnc(replace(Request.ServerVariables("url")&"?"&Request.ServerVariables("QUERY_STRING"),"index.asp",""))
	Response.Cookies("sToMUP").expires = dateadd("d",1,now())
End If
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<script type="text/javascript">
let cate1_name = "<%= getCateName(oItem.Prd.FcateCode, 1) %>";
let cate2_name = "<%= getCateName(oItem.Prd.FcateCode, 2) %>";

$(function() {

	let view_product_data = {
		itemid : "<%=itemid%>"
		, keyword : "<%=vPrtr%>"
		, productkeywords : ["<%=Replace(Replace(oitem.Prd.FKeywords,",",""","""), "'","")%>"]
		, category_name_depth1  : cate1_name
		, category_name_depth2  : cate2_name
		, categoryname  : cate1_name		
	};
	fnAmplitudeEventActionJsonData("view_deal", JSON.stringify(view_product_data));

	var menuTop=0;

	window.onload=function(){
		// 탑메뉴위치값 저장
		menuTop = $(".pdtTabLinkV15").offset().top;
		$("#tab01").addClass("current");

		$(window).scroll(function(){
			//메뉴표시 (스크롤 위치가 해당메뉴 위치값을 지나면 탑메뉴 선택표시)
			$('.pdtTabLinkV15 ul li').removeClass('current');

			if($("#detail01").length) {
				if( $(window).scrollTop()>=$("#detail01").offset().top-$(".pdtTabLinkV15").outerHeight()-25) {
					$('.pdtTabLinkV15 ul li').removeClass('current');
					$("#tab01").addClass("current");
				}
			}

			if($("#detail02").length) {
				if( $(window).scrollTop()>=$("#detail02").offset().top-$(".pdtTabLinkV15").outerHeight()-25) {
					$('.pdtTabLinkV15 ul li').removeClass('current');
					$("#tab02").addClass("current");
				}
			}

			if($("#detail03").length) {
				if( $(window).scrollTop()>=$("#detail03").offset().top-$(".pdtTabLinkV15").outerHeight()-25) {
					$('.pdtTabLinkV15 ul li').removeClass('current');
					$("#tab03").addClass("current");
				}
			}

			if($("#detail04").length) {
				if( $(window).scrollTop()>=$("#detail04").offset().top-$(".pdtTabLinkV15").outerHeight()-25) {
					$('.pdtTabLinkV15 ul li').removeClass('current');
					$("#tab04").addClass("current");
				}
			}

			if($("#detail06").length) {
				if( $(window).scrollTop()>=$("#detail06").offset().top-$(".pdtTabLinkV15").outerHeight()-25) {
					$('.pdtTabLinkV15 ul li').removeClass('current');
					$("#tab06").addClass("current");
				}
			}

			//탑메뉴 플로팅
			if( $(window).scrollTop()>=menuTop ) {
				//스크롤 위치가 탑메뉴의 위치 보다 크면 플로팅
				$(".pdtTabLinkV15").css("position","fixed");
			} else {
				//스크롤 위치가 탑메뉴의 위치 보다 작으면 원래위치
				$(".pdtTabLinkV15").css("position","absolute");
				$("#tab01").addClass("current");
			}
		});
	}

	// 상품후기
	$(".talkList .talkMore td").hide();
	$(".talkList .talkShort").click(function(){
		$(".talkList .talkMore td").hide();
		$(this).parent().parent().next('.talkMore').find('td').show();
	});

	$('#opbox').hide();
	//$("#coupondl").hide();
	/* dropdown */
	//http://jsfiddle.net/ZN3aD/13/
	$(".btnDrop").on("click", function(e){
		e.stopPropagation();
		$(".dropBox").hide();
		$(this).next().show();
		$(this).toggleClass("on");
		$(this).next().toggleClass("on");
		return false;
	});
	$(".dropBox ul li a").on("click", function(e){
		$(this).parent().parent().parent().prev(".btnDrop").removeClass("on")
		$(this).parent().parent().parent().removeClass("on").prev(".btnDrop").text($(this).text());
		return false;
	});
	$(document).on("click", function(e){
		$(".dropBox").hide();
		$(".btnDrop").removeClass("on");
		$(".dropBox").removeClass("on");
	});
});

//앵커이동
function goToByScroll(id){
	// 해당메뉴 위치로 스크롤 변경 (스크롤 = 해당매뉴 위치 - 탑메뉴 높이)
	$('html,body').animate({scrollTop: $("#detail0"+id).offset().top-$(".pdtTabLinkV15").outerHeight()-20},'slow');
}

// 쿠폰 받기
function DownloadCouponDeal(){
    <% If GetLoginUserID <> "" Then %>
        var popwin=window.open('/deal/downloaditemcoupon.asp?dealcode=<%=oDeal.Prd.FDealCode%>','DownloadCoupon','width=470,height=540,scrollbars=yes,resizable=no');
        popwin.focus();
    <% Else %>
        location.href = '/login/loginpage.asp?backpath=' + encodeURIComponent(location.pathname + location.search);
	<% End If %>
}
</script>
<link rel="canonical" href="http://www.10x10.co.kr/shopping/category_prd.asp?itemid=<%= itemid %>" />
<script type="text/javascript" src="/lib/js/jquery.numspinner.min.js"></script>
<script type="text/javascript">
<!-- #include virtual="/shopping/inc_Item_Javascript.asp" -->
</script>
<%' 쿠폰배너 스타일, 스크립트%>
<style>
.bnr-coupon {display:block; margin-top:10px; margin-bottom:-10px; cursor:pointer;}
.bnr-coupon img {width:440px;}
.popup-lyr {display:none;}
.lyr-coupon {display:none; position:relative; width:412px; padding:40px 0; font-family:'Roboto', 'Noto Sans KR'; text-align:center; background-color:#fff; -webkit-border-radius:5px; border-radius:5px;}
.lyr-coupon h2 {font-weight:normal; font-family:inherit; font-size:21px; color:#444;}
.lyr-coupon .btn-close1 {position:absolute; top:0; right:0; width:60px; height:60px; font-size:0; color:transparent; background:url(//fiximage.10x10.co.kr/web2019/common/ico_x.png) no-repeat 50% / 20px;}
.lyr-coupon .cpn {width:189px; height:96px; margin:20px auto 18px; background:url(//fiximage.10x10.co.kr/web2019/common/bg_cpn.png) no-repeat 50% / 100%;}
.lyr-coupon .cpn .amt {padding-top:12px; font-size:24px; color:#fff; line-height:1.3;}
.lyr-coupon .cpn .amt b {margin-right:3px; font-weight:bold; font-size:37px; vertical-align:-2px;}
.lyr-coupon .cpn .txt1 {font-size:11px; color:#919ff2; letter-spacing:-1px;}
.lyr-coupon .cpn .txt1 b {display:inline-block; margin-right:2px; font-size:12px; vertical-align:-0.5px;}
.lyr-coupon .txt2 {font-size:14px; color:#999; line-height:1.6;}
.lyr-coupon .txt2 strong {font-weight:normal; color:#ff3434;}
.lyr-coupon .btn-area {margin-top:20px; font-size:0;}
.lyr-coupon .btn-area button {height:48px; font:inherit; font-size:15px; -webkit-border-radius:5px; border-radius:5px;}
.lyr-coupon .btn-area .btn-close2 {width:113px; background-color:#c2c2c2; color:#444;}
.lyr-coupon .btn-area .btn-down {width:149px; margin-left:9px; background-color:#222; color:#fff;}
</style>
<script>
function jsEvtCouponDown(stype, idx, cb) {
	<% If IsUserLoginOK() Then %>
	$.ajax({
			type: "POST",
			url: "/event/etc/coupon/couponshop_process.asp",
			data: "mode=cpok&stype="+stype+"&idx="+idx,
			dataType: "text",
			success: function(message) {
				if(message) {
					var str1 = message.split("||")
					if (str1[0] == "11"){
						fnAmplitudeEventMultiPropertiesAction('click_marketing_top_bnr','','')
						cb();
						return false;
					}else if (str1[0] == "12"){
						alert('기간이 종료되었거나 유효하지 않은 쿠폰입니다.');
						return false;
					}else if (str1[0] == "13"){
						alert('이미 다운로드 받으셨습니다.');
						return false;
					}else if (str1[0] == "02"){
						alert('로그인 후 쿠폰을 받을 수 있습니다!');
						return false;
					}else if (str1[0] == "01"){
						alert('잘못된 접속입니다.');
						return false;
					}else if (str1[0] == "00"){
						alert('정상적인 경로가 아닙니다.');
						return false;
					}else{
						alert('오류가 발생했습니다.');
						return false;
					}
				}
			}
	})
	<% Else %>
		jsChklogin('<%=IsUserLoginOK%>');
		return;
	<% End IF %>
}
function handleClicKBanner(link, bannerType, couponidx, lyrId, ampEvt){
	var couponType

	if(ampEvt != '') fnAmplitudeEventMultiPropertiesAction(ampEvt,'','')
	if(bannerType == 1){ // 링크배너
			window.location.href = link
	}else if(bannerType == 2){ // 쿠폰배너
		couponType = couponidx == 1190 ? 'month' : 'evtsel'
		jsEvtCouponDown(couponType, couponidx, function(){
			popupLayer(lyrId)
		})
	}else{ // 레이어팝업배너
		popupLayer(lyrId);
	}
}
function popupLayer(lyrId){
	viewPoupLayer('modal', $("#"+lyrId).html())
}
function handleClickBtn(url){
	window.location.href = url
}
function eventClicKBanner(link, actionEvent, actionEventProperty, actionEventPropertyValue){
	fnAmplitudeEventMultiPropertiesAction(actionEvent, actionEventProperty, actionEventPropertyValue)
	window.location.href = link
}
</script>
<%' 쿠폰배너 스타일, 스크립트%>
<script type="text/javascript" src="category_prd.js?v=1.1"></script>
<%
If oItem.Prd.FAdultType <> 0 and session("isAdult")<>True then
	response.write "<script>confirmAdultAuth('"& Server.URLencode(CurrURLQ()) &"'); location.href='" & SSLUrl & "/';</script>"
end if
%>
</head>
<body>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container">
		<div id="contentWrap" class="dealDetail"><!-- for dev msg : 딜 이벤트 상세에 클래스명 붙여주세요 -->
			<p class="fs11 tPad10"><% If catecode <> "0" Then Call printCategoryHistory_B(catecode) End If %></p>
			<% if oItem.Prd.FisJust1Day then %>
			<!-- just 1 day -->
			<div id="lyrjust1day"></div>
			<script type="text/javascript">
				$.ajax({
					type: "get",
					url: "act_just1day.asp?itemid=<%=itemid%>",
					success: function(message) {
						if(message) {
							$("#lyrjust1day").empty().html(message);
						}
					}
				});
			</script>
			<% End If %>
			<%'// 이벤트 배너%>
			<% server.Execute("/chtml/main/loader/banner/exc_itemprd_banner.asp") %>
			<div class="pdtInfoWrapV15">
				<div class="pdtPhotoWrap deal-item">
					<div class="pdtPhotoBox">
						<div class="photoSlideV15">
						<%
							'// 상품 이미지 출력
							dim viBsimg, viMkimg, viAdImg
							dim viBstmb, viMktmb, viAdtmb

							'// 텐바이텐 기본이미지 추가(이미지 올렸을시 생성되는 50*50사이즈 이미지 추가노출)
							If Not(isNull(oitem.Prd.Ftentenimage) Or oitem.Prd.Ftentenimage = "") Then
								Dim viTentenimg, viTententmb
								if ImageExists(oitem.Prd.Ftentenimage1000) Then
									viTentenimg = oitem.Prd.Ftentenimage1000
								ElseIf ImageExists(oitem.Prd.Ftentenimage600) Then
									viTentenimg = oitem.Prd.Ftentenimage600
								ElseIf ImageExists(oitem.Prd.Ftentenimage) Then
									viTentenimg = oitem.Prd.Ftentenimage
								End If

								If viTentenimg<>"" Then
									viTententmb = oitem.Prd.Ftentenimage50
								End If
								Response.write "<p><img src=""" & viTentenimg & """ thumb=""" & viTententmb & """ alt=""" & replace(oItem.Prd.FItemName,"""","") & """ /></p>"
							End If

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
								viBsimg = getThumbImgFromURL(viBsimg,500,500,"true","false")

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
								viMkimg = getThumbImgFromURL(viMkimg,500,500,"true","false")

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
											viAdImg = getThumbImgFromURL(viAdImg,500,500,"true","false")

											Response.write "<p><img src=""" & viAdImg & """ thumb=""" & viAdtmb & """ alt=""" & replace(oItem.Prd.FItemName,"""","") & """ /></p>"
										end if
									end if
								Next
							End If
						%>
						</div>
					</div>
					<p class="dealBadge">텐텐<br /><strong>DEAL</strong></p>
				</div>
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
						<input type="hidden" name="itemName">
						<input type="hidden" name="isPhotobook" value="<%= ISFujiPhotobook %>">
						<input type="hidden" name="isPresentItem" value="<%= isPresentItem %>">
						<input type="hidden" name="IsSpcTravelItem" value="<%= IsSpcTravelItem %>">
						<input type="hidden" name="itemRemain" id="itemRamainLimit" value="<%=chkIIF(oItem.Prd.IsLimitItemReal,CHKIIF(oItem.Prd.FRemainCount<=oItem.Prd.ForderMaxNum,oItem.Prd.FRemainCount,oItem.Prd.ForderMaxNum),oItem.Prd.ForderMaxNum)%>">
							<%If oItem.Prd.FAdultType <> 0 then%>
							<!-- 성인인증 -->
							<div class="adult-text">
								<div class="inner">
									<p>관계법령에 따라 미성년자는 구매할 수 없으며, 성인인증을 하셔야 구매 가능한 상품입니다.</p>
								</div>
							</div>
							<%End if%>

							<%' 마케팅 쿠폰다운 배너 %>
							<% server.Execute("/chtml/main/loader/banner/exc_itemprd_banner_coupon.asp") %>
							<%' 마케팅 쿠폰다운 배너 %>

							<div class="pdtBasicV15">
								<!-- for dev msg : 동일 브랜드로 딜이 만들어진 경우 브랜드 바로가기 역할로 생성, 여러 브랜드가 모여있는 경우 표시안됨 -->
								<p class="pdtBrand" id="brandshow" style="display:none">
								<a href="" id="zzimBrandCnt" onclick="TnMyBrandJJim('<%= oItem.Prd.FMakerid %>', '<%=oItem.Prd.FBrandName%>'); return false;"><dfn id="zzimBr_<%= oItem.Prd.FMakerid %>" class="<%=chkIIF(isMyFavBrand,"zzimBrV15","")%>">찜브랜드</dfn></a>
								<a href="/street/street_brand.asp?makerid=<%= oItem.Prd.FMakerid %>&ab=012_a_1"><span><%=oItem.Prd.FBrandName%></span></a>
								<a href="/street/street_brand.asp?makerid=<%= oItem.Prd.FMakerid %>&ab=012_a_2" class="btn btnS6 btnGry2 fn lMar10"><em class="whiteArr03">브랜드샵</em></a>
								</p>
								<h2 class="pdtName"><%= replace(replace(oItem.Prd.FItemName,"<br>"," "),"<br />"," ") %></h2>
							</div>
							<div class="detailInfoV15 tentenPrice">
								<dl class="saleInfo">
									<dt>텐바이텐가</dt>
									<dd>
										<strong class="cRd0V15"><span><%=FormatNumber(oDeal.Prd.FMasterSellCash,0)%></span>원~</strong><br />
										<div id="coupondl" style="display:none"><a href="#"  onclick="DownloadCouponDeal(); return false;" class="btn btnS2 btnGrn fn btnW75"><span class="download">쿠폰다운</span></a><div>
									</dd>
								</dl>
							</div>

							<div class="detailInfoV15">
								<dl class="saleInfo">
									<dt>배송비/마일리지</dt>
									<dd>상품 정보에서 확인해주세요.</dd>
								</dl>
							</div>
							<% If oDeal.Prd.FViewDIV="2" Then %>
							<div class="detailInfoV15 dealTime">
							<% If  now() < oDeal.Prd.FStartDate Then %>
								<p><i></i>판매 종료된 상품입니다.</p>
							<% Else %>
								<% If DateDiff("s",now(),oDeal.Prd.FEndDate) < 1 Then %>
								<p><i></i>판매 종료된 상품입니다.</p>
								<% Else %>
								<p><i></i>남은 시간 <b id="remaintime"><% If DateDiff("s",now(),oDeal.Prd.FEndDate) < 86400 Then %><% =ZeroTime(CStr(Fix(DateDiff("s",now(),oDeal.Prd.FEndDate)/3600) Mod 60)) %>:<% =ZeroTime(CStr(Fix(DateDiff("s",now(),oDeal.Prd.FEndDate)/60) Mod 60)) %></b><% Else %><% =DateDiff("d",now(),oDeal.Prd.FEndDate) %></b>일<% End If %> <!-- <span></span> 총 <b>2,113</b>명이 상품을 보았습니다. --></p>
								<% End If %>
							<% End If %>
							</div>
							<% End If %>
<%

'//	한정 여부 (표시여부와 상관없는 실제 상품 한정여부)
Function IsLimitItemReal(ByVal LimitYn)
		IsLimitItemReal= (LimitYn="Y")
end Function

'//일시품절 여부 '2008/07/07 추가 '!
Function isTempSoldOut(ByVal SellYn)
	isTempSoldOut = (SellYn="S")
End Function

Function IsSoldOut(ByVal SellYn, ByVal LimitNo, ByVal LimitSold, ByVal LimitYn)
		isSoldOut = (SellYn<>"Y")
End Function
Dim intLoop
%>
							<!-- option -->
							<div class="detailInfoV15">
								<dl class="saleInfo">
									<dt>상품 선택</dt>
									<dd>
										<div class="dropDown">
											<button type="button" class="btnDrop">상품을 선택해주세요.</button>
											<div class="dropBox multi">
												<% If isArray(ArrDealItem) Then %>
												<ul>
													<% For intLoop = 0 To UBound(ArrDealItem,2) %>
														<%
														If ArrDealItem(9,intLoop)="Y" And DealCouponYn="N" Then
															DealCouponYn="Y"
														End If
														If intLoop=0 Then DealBrandName=ArrDealItem(7,intLoop)
														%>
													<% If IsSoldOut(ArrDealItem(3,intLoop),ArrDealItem(5,intLoop),ArrDealItem(6,intLoop),ArrDealItem(4,intLoop)) Or isTempSoldOut(ArrDealItem(3,intLoop)) Then %>
													<li class="soldout"><div class="option">[상품<%=intLoop+1%>] <%=ArrDealItem(1,intLoop)%> <em class="value"><%=FormatNumber(ArrDealItem(2,intLoop),0)%>원</em></div></li>
													<% Else %>
													<li><a href="#" onclick="fnDealItemOptionView(<%=ArrDealItem(0,intLoop)%>,<%=ArrDealItem(2,intLoop)%>,'[상품<%=intLoop+1%>] <%=ArrDealItem(1,intLoop)%>')"><div class="option">[상품<%=intLoop+1%>] <%=ArrDealItem(1,intLoop)%> <em class="value"><% If ArrDealItem(9,intLoop)="Y" Then %><%=FormatNumber(GetDealCouponPrice(ArrDealItem(2,intLoop),ArrDealItem(13,intLoop),ArrDealItem(12,intLoop)),0)%><% Else %><%=FormatNumber(ArrDealItem(2,intLoop),0)%><% End If %>원</em></div></a></li>
													<% End If %>
													<%
														If ArrDealItem(7,intLoop) <> DealBrandName Then
															DealBrandCheck="N"
														End If
													%>
													<% Next %>
												</ul>
												<% End If %>
											</div>
										</div>
									</dd>
								</dl>
							</div>
<script>
	<% If DealCouponYn="Y" Then %>
		$("#coupondl").show();
	<% End If %>
	<% If DealBrandCheck="Y" Then %>
		$("#brandshow").show();
	<% End If %>
</script>
<script>
function fnDealItemOptionView(itemid,itemprice,itemname){
//alert(itemid);
	$('input[name="itemid"]').val(itemid);
	$('input[name="itemPrice"]').val(itemprice);
	$('input[name="itemName"]').val(itemname);
	$.ajax({
		url: "act_item_option.asp?itemid="+itemid,
		cache: false,
		async: false,
		success: function(message) {
			if(message.substr(0,10)=="notoption=") {
				$('#opbox').hide();
				var minmax = message.substr(10,message.length);
				var myArray = minmax.split('|');
				var min = myArray[0];
				var max = myArray[1];
				//옵션이 없을시 간이바구니 바로 생성
				fnTempShoppingBagSelect('', itemid, '0000', 0,'','',min,max);
				//$('#opbtn').attr("disabled",true);
			} else {
				$('#opbox').show();
				$str = $(message);
				$('#oplist li').remove();
				$('#oplist').append($str);
				$('#opbtn').attr("disabled",false);
			}
		}
	});
}

function fnTempShoppingBagSelect(opSelNm, itemid, opSelCd, optAddPrc, opSoldout, itemdiv, minnum, maxnum){
	var opLimit=parseInt(maxnum);
	var minCnt=parseInt(minnum);
	var maxCnt=parseInt(maxnum);
var itemPrc = $('input[name="itemPrice"]').val()*1;
	var itemName = $('input[name="itemName"]').val();
	var itemCnt=1;
	// 본상품 제한수량 계산
	if($("#itemRamainLimit").val()>0) {
		if($("#itemRamainLimit").val()<opLimit) opLimit=parseInt($("#itemRamainLimit").val());
	}
	//품절처리
	if(opSoldout) {
		alert("품절된 옵션은 선택하실 수 없습니다.");
		return;
	}
	// 옵션이 없으면 추가하지 않음
	//if(opSelCd==""||opSelCd=="0000")  return;

	// 중복 옵션 처리
	var chkDpl = false;
	$("#lySpBagList").find("tr").each(function () {
		if($(this).find("[name='optItemid']").val()==itemid&&$(this).find("[name='optCd']").val()==opSelCd) {
			chkDpl=true;
		}
	});
	if(chkDpl) return;

	// 간이 장바구니 내용 작성
	var sAddItem='';
	sAddItem += '<tr>';
	sAddItem += '	<td class="lt"><p style="overflow:hidden; width:220px; height:20px; text-overflow:ellipsis; white-space:nowrap; color:#000;">'+ itemName + "</p>";
	sAddItem +=  "<p style='color:#888;'>" + opSelNm + "</p>";

	if(itemdiv=="06") {
		sAddItem += '<p class="tPad05"><textarea name="optRequire" style="width:215px; height:35px;"></textarea></p>';
	} else {
		sAddItem += '<input type="hidden" name="optRequire" value="" />';
	}

	sAddItem += '<input type="hidden" name="optItemid" value="'+ (itemid) +'" />';
	sAddItem += '<input type="hidden" name="optCd" value="'+ opSelCd +'" />';
	sAddItem += '<input type="hidden" name="optItemPrc" value="'+ (itemPrc+optAddPrc) +'" />';
	sAddItem += '</td>';
	sAddItem += '<td><input type="text" id="optItemEa" style="width:30px" class="txtInp ct" /></td>';
	sAddItem += '<span class="orderNumAtc"></span>';
	sAddItem += '<td class="rt rPad10">' + plusComma((itemPrc+optAddPrc)*itemCnt) + '</td>';
	sAddItem += '<td><a href="#" class="del"><span class="btnListDel">삭제</span></a></td>';
	sAddItem += '</tr>';

	// 간이바구니에 추가
	$("#lySpBagList").prepend(sAddItem);

	// 스피너 변환
	$("#optItemEa").numSpinner({min:minCnt, max:maxCnt, step:1, value:itemCnt});

	// 간이바구니표시
	if($("#lySpBagList").find("tr").length>0) {

		// 개별삭제
		$('#lySpBagList .del').css('cursor', 'pointer');
		$('#lySpBagList .del').unbind("click");
		$('#lySpBagList .del').click(function(e) {
			e.preventDefault();
			var di = $(this).closest("tr").index();
			$("#lySpBagList").find("tr").eq(di).remove();

			//간이바구니 정리
			if($("#lySpBagList").find("tr").length<=0) {
				$("#lySpBag").hide();
			} else {
				$("#lySpBagList").find("tr").first().addClass("start");
			}

			// 중간 메뉴위치 재지정
			resetPrdTabLinkPostion();

			// 총금액 합계 계산
			FnSpCalcTotalPrice();
		});

		// 간이 바구니 주문수량 변경
		$('#lySpBag input[name="optItemEa"]').keyup(function() {
			FnSpCalcTotalPrice();
		});

		// 간이 바구니 스피너 액션
		$('#lySpBagList .spinner .buttons').click(function() {
			FnSpCalcTotalPrice();
		});

		// 총금액 합계 계산
		FnSpCalcTotalPrice();
		$("#lySpBag").show();

		// 선택창 옵션 초기화
		$('.itemoption select[name="item_option"]').val("");

		// 중간 메뉴위치 재지정
		resetPrdTabLinkPostion();
	} else {
		$("#lySpBag").hide();

		// 중간 메뉴위치 재지정
		resetPrdTabLinkPostion();
	}
}

function fnDealAddShoppingBag(bool){
	if($("#lySpBagList tr").length<1)
	{
		alert("상품을 선택해 주세요.");
	}
	else
	{
		FnAddShoppingBag(bool);
	}
}

$(document).unbind("dblclick").dblclick(function () {});
</script>
							<div class="detailInfoV15" style="margin-top:10px;display:none" id="opbox">
								<dl class="saleInfo">
									<dt>옵션 선택</dt>
									<dd>
										<div class="dropDown">
											<button type="button" class="btnDrop" id="opbtn" disabled>옵션을 선택해주세요.</button>
											<div class="dropBox">
												<ul id="oplist">
												</ul>
											</div>
										</div>
									</dd>
								</dl>
							</div>
							<!-- 간편바구니 -->
							<div class="easeCartV15" id="lySpBag" style="display:none;">
								<div class="easeTxtV15">
									<p>다른옵션도 구매하시려면 옵션을 반복하여 선택해 주세요.</p>
								</div>
								<div class="optSelectListWrap">
									<table class="optSelectList">
										<caption>상품 옵션별 선택 리스트</caption>
										<colgroup>
											<col width="*" /><col width="80px" /><col width="75px" /><col width="18px" />
										</colgroup>
										<tbody  id="lySpBagList"></tbody>
									</table>
								</div>
								<div class="totalPrice">
									<span>상품 금액 합계</span>
									<strong><span id="spTotalPrc">0원</span></strong>
								</div>
							</div>
							<!-- 간편바구니 -->
							<p class="rt tPad10 cGy1V15">(쿠폰 적용은 주문결제 단계에서 가능합니다.)<input type="hidden" name="itemea" value="1" /></p>

							<!-- <div class="checkContV15">
								<dl class="saleInfo">
									<dt>필수 확인사항</dt>
									<dd>
										<ul class="checkListV15">
											<li>주문제작상품으로 7일 소요 예상</li>
											<li>선착순 판매 상품은 실시간 결제로만 구매 가능(무통장 결제 불가)</li>
										</ul>
									</dd>
								</dl>
							</div> -->
						</form>
						<form name="BagArrFrm" method="post" action="" onsubmit="return false;" >
						<input type="hidden" name="mode" value="arr">
						<input type="hidden" name="bagarr" value="">
						</form>
						</div>
						<div class="pdtAddInfoV15">
							<div class="pdtTagV15">
								<% if oItem.Prd.IsNewItem then %><p><img src="http://fiximage.10x10.co.kr/web2015/shopping/tag_new.png" alt="NEW" /></p><% end if %>
								<% if oItem.Prd.isBestRankItem then %><p><img src="http://fiximage.10x10.co.kr/web2015/shopping/tag_best.png" alt="BEST" /></p><% end if %>
							</div>
							<div class="interactInfoV15">
								<dl>
									<dt>딜상품코드</dt>
									<dd><% = oitem.Prd.FItemid %></dd>
								</dl>
								<dl>
									<dt>Review</dt>
									<dd>(<a href="" onClick="goToByScroll('2'); return false;" id="evaltotalcnt">0</a>)</dd>
									<!-- <dd>(<a href="/my10x10/goodsUsing.asp?EvaluatedYN=N">쓰기</a>)</dd> -->
								</dl>
							</div>
						</div>
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
						vBuyAlert = vBuyAlert & "				<a href=""#"" onclick=""$('.alertLyrV15').fadeOut('fast'); return false;"" class=""btn btnS1 btnRed"">쇼핑 계속하기</a>" & vbCrLf
						vBuyAlert = vBuyAlert & "				<a href=""/inipay/shoppingbag.asp"" class=""btn btnS1 btnWhite"">장바구니 가기</a>" & vbCrLf
						vBuyAlert = vBuyAlert & "			</p>" & vbCrLf
						vBuyAlert = vBuyAlert & "		</div>" & vbCrLf
						vBuyAlert = vBuyAlert & "	</div>" & vbCrLf
						vBuyAlert = vBuyAlert & "</div>" & vbCrLf

							If (Not IsTicketItem) Then	'### 일반 상품인 경우
								If  now() < oDeal.Prd.FStartDate Then
									vBuyButton = vBuyButton & "<span style=""width:390px;""><a href=""#"" class=""btn btnB1 btnGry"" onclick=""return false;"">판매종료</a></span>"
								Else
									If oDeal.Prd.FViewDIV="2" And (oDeal.Prd.FEndDate < now()) Then
										vBuyButton = vBuyButton & "<span style=""width:390px;""><a href=""#"" class=""btn btnB1 btnGry"" onclick=""return false;"">판매종료</a></span>"
									Else
										vBuyButton = vBuyButton & chkIIF(oItem.Prd.IsMileShopitem,"","<span style=""width:190px;""><a href=""#"" onclick=""fnDealAddShoppingBag();fnGaSendCheckValue();fnAmplitudeEventAction('click_directorder_in_deal','itemid','"&itemid&"'); return false;"" class=""btn btnB1 btnRed"">바로구매</a></span>")
										vBuyButton = vBuyButton & "<span class=""lPad10 btnCartV15"" style=""width:190px;""><a href=""#"" onclick=""fnDealAddShoppingBag(true);fnGaSendCheckValue(true);fnAmplitudeEventAction('click_shoppingbag_in_deal','itemid','"&itemid&"'); return false;"" class=""btn btnB1 btnWhite"">장바구니</a>" & vBuyAlert & "</span>"
									End If
								End If
							End IF
						If oItem.Prd.FAdultType <> 0 and session("isAdult")<>True then
							vBuyButton = "<span style=""width:190px;""><a href=""#"" onclick=""confirmAdultAuth('"&Server.URLencode(CurrURLQ())&"');"" class=""btn btnB1 btnRed"">바로구매</a></span>"
							vBuyButton = vBuyButton & "<span class=""lPad10 btnCartV15"" style=""width:190px;""><a href=""#"" onclick=""confirmAdultAuth('"&Server.URLencode(CurrURLQ())&"');"" class=""btn btnB1 btnWhite"">장바구니</a>" & vBuyAlert & "</span>"
						End If
						Response.Write vBuyButton
					%>
						<span class="lPad10" style="*width:168px;"><a id="wsIco<%=oDeal.Prd.FMasterItemCode%>"
						    <% If LoginUserid <> "" Then %>
						        onclick="TnAddFavorite(<%=oDeal.Prd.FMasterItemCode%>);fnAmplitudeEventAction('click_wish_in_deal','deal_all','<%=itemid%>');return false;"
						    <% Else %>
						        onclick="goLoginPage()"
						    <% End If %>
						    class="btn btnB1 btnWhite3 <%=chkIIF(isMyFavItem,"myWishMarkV15","")%>"><em class="wishActionV15"><%= FormatNumber(ofavItem.Prd.FfavCount,0) %></em></a></span>
					</div>
				</div>
			</div>
			<div class="pdtDetailV15">
				<div id="lyrPrdTabLink" class="pdtTabLinkV15">
					<div class="group">
						<ul class="pdtSnsV15">
							<li class="twShareV15"><a href="" onclick="shareProduct('tw','<%=snpPre%>','<%=snpTag2%>',''); return false;">Twitter</a></li>
							<li class="fbShareV15"><a href="" onclick="shareProduct('fb','','',''); return false;">Facebook</a></li>
							<li class="ptShareV15"><a href="" onclick="shareProduct('pt','','','<%=snpImg%>'); return false;">Pinterest</a></li>
						</ul>
					</div>

					<ul>
						<li id="tab01" onclick="goToByScroll('1');" class="current"><p>상품 설명</p></li>
						<li id="tab02" onclick="goToByScroll('2');"><p>상품 후기 <span class="fn">(<strong class="fs11" id="lyEvalTotalCnt">0</strong>)</span></p></li>
						<li id="tab03" onclick="goToByScroll('3');"><p>Q&amp;A <span class="fn">(<strong class="fs11" id="lyQnATotalCnt">0</strong>)</span></p></li>
						<li id="tab06" onclick="goToByScroll('6');"><p>배송/교환/환불</p></li>
					</ul>
				</div>
<script type="text/javascript">
<!--
function fnDealOtherItemView(itemid,viewnum){
//alert(itemid);
	$.ajax({
		url: "act_itemprd_pop.asp?itemid="+itemid+"&viewnum="+viewnum+"&dealitemid=<%=itemid%>",
		cache: false,
		async: false,
		success: function(message) {
			if(message!="") {
				$str = $(message);
				$('.slideWrap .slide').remove();
				$('.slideWrap .btnNav').remove();
				$('.slideWrap').append($str);
			} else {
				alert("제공 할 정보가 없습니다.");
			}
		}
	});
}

/* layer */
$(function(){
	$.fn.layerOpen = function(options) {
		return this.each(function() {
			var $this = $(this);
			var $layer = $($this.attr("href") || null);
			$this.click(function() {
				$layer.attr("tabindex",0).show().focus();
				$("#dimmed").show();
				$layer.find(".btnClose").one("click",function () {
					$layer.hide();
					$this.focus();
					$("#dimmed").hide();
				});
			});
		});
	}
	$(".layer").layerOpen();
	$("#dimmed").on("click", function(e){
		$(this).hide();
		$("#layerDeal").hide();
	});
	$(".slideWrap .slide").hide();
	$(".slideWrap .slide:first").show();

//	$(".btnNext").on("click", function(e){
//		$(".slideWrap .slide:first").appendTo(".slideWrap");
//		$(".slideWrap .slide").hide().eq(0).show();
//	});

//	$(".btnPrev").on("click", function(e){
//		$(".slideWrap .slide:last").prependTo(".slideWrap");
//		$(".slideWrap .slide").hide().eq(0).show();
//	});
});
//-->
</script>
				<!-- 상품 설명 -->
				<div class="section pdtExplanV15" id="detail01">
					<div class="tPad10">
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<%
							'=============================== 추가 이미지 & 추가 이미지-메인 이미지 ==========================================
							Dim oADD2
							set oADD2 = new CatePrdCls
							oADD2.getAddImage itemid
							'설명 이미지(추가)
							IF oADD2.FResultCount > 0 THEN
								FOR i= 0 to oADD2.FResultCount-1
									IF oADD2.FADD(i).FAddImageType=1 AND oADD2.FADD(i).FAddimageGubun=1 AND oADD2.FADD(i).FIsExistAddimg THEN
										Response.Write "<tr><td align=""center"">"
										Response.Write "<img src=""" & oADD2.FADD(i).FAddimage & """ border=""0"" style=""max-width:1000px;"" />"
										Response.Write "</td></tr>"
									End IF
								NEXT
							END If
							Set oADD2 = Nothing
						%>
						</table>
					</div>
					<div class="item itemDeal">
						<% If isArray(ArrDealItem) Then %>
						<ul class="pdtList">
							<!-- for dev msg : 2열타입에는 클래스명 half, 1열 타입에는 클래스명 full 붙여주세요 -->
							<% For intLoop = 0 To UBound(ArrDealItem,2) %>
							<% If (UBound(ArrDealItem,2) Mod 2) = 0 Then %>
							<li class="full">
							<% Else %>
							<li class="half">
							<% End If %>
								<a href="#layerDeal" class="layer" onClick="fnDealOtherItemView(<%=ArrDealItem(0,intLoop)%>,<%=intLoop+1%>)">
									<% If IsSoldOut(ArrDealItem(3,intLoop),ArrDealItem(5,intLoop),ArrDealItem(6,intLoop),ArrDealItem(4,intLoop)) Or isTempSoldOut(ArrDealItem(3,intLoop)) Then %>
									<p class="soldout"><span>SOLD OUT</span></p>
									<% End If %>
									<div class="pdtBox">
										<div class="pdtPhoto">
											<img src="<%=oDeal.IsImageBasic(ArrDealItem(0,intLoop),ArrDealItem(8,intLoop))%>" alt="<%=ArrDealItem(1,intLoop)%>" />
											<span class="btnView"><i></i>자세히보기</span>
										</div>
										<div class="pdtInfo">
											<span class="no">상품 <span><%=intLoop+1%></span></span>
											<p class="pdtBrand"><%=ArrDealItem(7,intLoop)%></p>
											<p class="pdtName"><%=ArrDealItem(1,intLoop)%></p>
											<% If ArrDealItem(10,intLoop)="Y" And ArrDealItem(9,intLoop)="Y" Then %>
											<p class="pdtPrice cRd0V15"><%=FormatNumber(GetDealCouponPrice(ArrDealItem(2,intLoop),ArrDealItem(13,intLoop),ArrDealItem(12,intLoop)),0)%><span>원 [<%=CLng((ArrDealItem(11,intLoop)-ArrDealItem(2,intLoop))/ArrDealItem(11,intLoop)*100)%>%]</span> <i class="label">쿠폰</i></p>
											<% ElseIf ArrDealItem(10,intLoop)="Y" Then %>
											<p class="pdtPrice cRd0V15"><%=FormatNumber(ArrDealItem(2,intLoop),0)%><span>원 [<%=CLng((ArrDealItem(11,intLoop)-ArrDealItem(2,intLoop))/ArrDealItem(11,intLoop)*100)%>%]</span></p>
											<% ElseIf ArrDealItem(9,intLoop)="Y" Then %>
											<p class="pdtPrice cGr0V15"><% If ArrDealItem(9,intLoop)="Y" Then %><%=FormatNumber(GetDealCouponPrice(ArrDealItem(2,intLoop),ArrDealItem(13,intLoop),ArrDealItem(12,intLoop)),0)%><% Else %><%=FormatNumber(ArrDealItem(2,intLoop),0)%><% End If %><span>원 [<%= GetCouponDiscount(ArrDealItem(12,intLoop),ArrDealItem(13,intLoop)) %>]</span> <i class="label">쿠폰</i></p>
											<% Else %>
											<p class="pdtPrice"><%=FormatNumber(ArrDealItem(2,intLoop),0)%><span>원</span></p>
											<% End If %>
										</div>
									</div>
								</a>
							</li>
							<% Next %>
						</ul>
						<% End If %>
					</div>
				</div>
				<!-- //상품 설명 -->

				<!-- 상품 후기 -->
				<% if cFlgDBUse then %>
					<!-- (4/9) 상품후기 -------------------------------->
					<!-- #include virtual="/deal/inc_itemEvaluate.asp" -->

					<!-- (6/9) Q&A ------------------------------------->
					<!-- #include virtual="/deal/inc_itemQnA.asp" -->
				<% end if %>
				<!-- //상품 후기 -->
				<% If Not(IsPresentItem) AND oitem.Prd.Fitemdiv <> "18" then %>
				<!-- 배송교환환불 -->
				<!-- #include virtual="/shopping/inc_DeliveryDescription.asp" -->
				<!-- //배송교환환불 -->
				<% end if %>
			</div>
		</div>
	</div>

	<!-- 딜상품 보기 modal layer popup -->
	<div id="layerDeal" class="layerDeal">
		<div class="slideWrap"></div>
		<button type="button" class="btnClose"><span>닫기</span></button>
	</div>
	<script>
	$(function() {
		// 탑메뉴위치값 저장
		if ($("#lyrPrdTabLink").length){
			menuTop = $("#lyrPrdTabLink").offset().top;
		}
		$("#tab01").addClass("current");

		$(window).scroll(function(){
			//메뉴표시 (스크롤 위치가 해당메뉴 위치값을 지나면 탑메뉴 선택표시)
			$('.pdtTabLinkV15 ul li').removeClass('current');

			$('.pdtTabLinkV15 ul li').each(function(){
				if ($(this).css("display") != "none"){
					var idnumber = $(this).attr("id");
					if (idnumber == undefined) {
						return;
					}
					idnumber = idnumber.substring(3,5);

					if($("#detail"+idnumber).length < 7) {
						if($(window).scrollTop()>=$("#detail"+idnumber).offset().top-$(".pdtTabLinkV15").outerHeight()-25) {
							$('.pdtTabLinkV15 ul li').removeClass('current');
							$("#tab"+idnumber).addClass("current");
						}
					}else{
						if( $(window).scrollTop()>=$("#detail07").offset().top-$(".pdtTabLinkV15").outerHeight()-160 || $(window).scrollTop()>=($(document).height()-$(window).height())) {
							$('.pdtTabLinkV15 ul li').removeClass('current');
							if($("#tab07").css("display")!="none") {
								$("#tab07").addClass("current");
							} else {
								$("#tab06").addClass("current");
							}
						}
					}
				}
			})

			//탑메뉴 플로팅
			if( $(window).scrollTop()>=menuTop ) {
				//스크롤 위치가 탑메뉴의 위치 보다 크면 플로팅
				$(".pdtTabLinkV15").css("position","fixed");
			} else {
				//스크롤 위치가 탑메뉴의 위치 보다 작으면 원래위치
				$(".pdtTabLinkV15").css("position","absolute");
				$("#tab01").addClass("current");
			}
		});

		if($('.photoSlideV15 p').length>1) {
			$('.photoSlideV15').slidesjs({
				width:500,
				height:500,
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
			$('.photoSlideV15 p img').css({"width":500,"height":500});
			$('.photoSlideV15').append('<ul class="slidesjs-pagination"><li><a href="" class="active" onclick="return false;"><span></span></a></li></ul>');
			$('.photoSlideV15 .slidesjs-pagination > li').css('background-image', 'url('+$('.photoSlideV15 p img').attr("thumb")+')');
		}
	});
	</script>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
<div id="dimmed" style="display:none; position:fixed; top:0; left:0; z-index:1005; width:100%; height:100%; background:url(http://fiximage.10x10.co.kr/web2016/playing/bg_mask_black_50.png) 0 0 repeat;"></div>
<%' 에코마케팅용 레코벨 스크립트 삽입(2016.12.21) %>
<script type="text/javascript">
  window._rblq = window._rblq || [];
  _rblq.push(['setVar','cuid','0f8265c6-6457-4b4a-b557-905d58f9f216']);
  _rblq.push(['setVar','device','PW']);
  _rblq.push(['setVar','itemId','<%=itemid%>']);
//  _rblq.push(['setVar','userId','{$userId}']); // optional
  _rblq.push(['setVar','searchTerm','<%=vPrtr%>']);
  _rblq.push(['track','view']);
  (function(s,x){s=document.createElement('script');s.type='text/javascript';
  s.async=true;s.defer=true;s.src=(('https:'==document.location.protocol)?'https':'http')+
  '://assets.recobell.io/rblc/js/rblc-apne1.min.js';
  x=document.getElementsByTagName('script')[0];x.parentNode.insertBefore(s, x);})();
</script>

<script>
// 구글 애널리틱스 관련
function fnGaSendCheckValue(bool)
{
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
   ga('create', 'UA-16971867-10', 'auto');

	// 구글 애널리틱스 값
	if (bool==true){
		ga('send', 'event', 'UX', 'click', 'add');
	}
	else
	{
		ga('send', 'event', 'UX', 'click', 'DO1');
	}
}

// 로그인페이지 이동
function goLoginPage() {
    location.href = '/login/loginpage.asp?backpath=' + encodeURIComponent(location.pathname + location.search);
}

// 상품 공유
<%	'// 쇼셜서비스로 글보내기
dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
snpTitle = Server.URLEncode(oItem.Prd.FItemName)
snpLink = Server.URLEncode("http://10x10.co.kr/deal/deal.asp?itemid=" & itemid)

'기본 태그
snpPre = Server.URLEncode("텐바이텐 DEAL ITEM!")
snpTag = Server.URLEncode("텐바이텐 " & Replace(oItem.Prd.FItemName," ",""))
snpTag2 = Server.URLEncode("#10x10")
snpImg = Server.URLEncode(oItem.Prd.FImageBasic)
%>
function shareProduct(gubun, pre, tag, img) {
    let share_method;
    switch(gubun) {
        case 'tw' : share_method = 'twitter'; break;
        case 'fb' : share_method = 'facebook'; break;
        case 'pt' : share_method = 'pinterest'; break;
    }

    popSNSPost(gubun, '<%=snpTitle%>', '<%=snpLink%>', pre, tag, img);
}
</script>

<script type="application/ld+json">
{
	"@context": "http://schema.org/",
	"@type": "Product",
	"name": "<%= Replace(oItem.Prd.FItemName,"""","") %>",
	<% if viBsimg<>"" then %>
	"image": "<%= viBsimg %>",
	<% end if %>
	"mpn": "<%= itemid %>",
	"brand": {
		"@type": "Brand",
    	"name": "<%= Replace(UCase(oItem.Prd.FBrandName),"""","") %>"
	},
	<%
	dim BeasongPayDescription : BeasongPayDescription = " 배송비 안내: 상품 정보에서 확인해주세요."
	%>"description": "<%= Replace(oItem.Prd.FItemName,"""","") %>. 판매가: <%= FormatNumber(CHKIIF(oItem.Prd.FSellCash>oItem.Prd.getOrgPrice, oItem.Prd.FSellCash, oItem.Prd.getOrgPrice), 0) %> 원.<% if (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) then %> 할인판매가: <%= FormatNumber(oItem.Prd.FSellCash,0) %> 원 [<%= CHKIIF(oItem.Prd.FOrgprice = 0, 0, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100)) %>%].<% end if %><% if Not oItem.Prd.FMileage and Not IsTicketItem then %> <%= BeasongPayDescription %><% end if %>",
	"offers": {
		"@type": "Offer",
		"url": "https://www.10x10.co.kr/deal/deal.asp?itemid=<%= itemid %>",
		"priceCurrency": "KRW",
		"availability": "https://schema.org/InStock",
		"priceValidUntil": "<%= Left(DateAdd("yyyy", 1, Now()), 10) %>",
		"price": "<%= CHKIIF(oItem.Prd.FSellCash>oItem.Prd.getOrgPrice, oItem.Prd.FSellCash, oItem.Prd.getOrgPrice) %>"
	}<%
	 if (oItem.Prd.FEvalCnt > 0) then
		 dim avgEvalPoint : avgEvalPoint = getEvaluateAvgPoint(itemid)
		 if (avgEvalPoint > 0) then
	 %>,
	"aggregateRating": {
		"@type": "AggregateRating",
		"ratingValue": "<%= avgEvalPoint %>",
		"reviewCount": "<%= oItem.Prd.FEvalCnt %>"
	}<%
	 	end if
	 end if
	 %>
}
</script>
</body>
</html>
<%
	Set oItem = Nothing
	Set ofavItem = Nothing
	Set oADD = Nothing
	Set itemVideos = Nothing
	If IsTicketItem Then
		set oTicket = Nothing
	end If
	If clsDiaryPrdCheck.FResultCount > 0 Then
		set DiaryPreviewImgLoad = Nothing
		Set DiarySearchValue = Nothing
	End If

	'다이어리 스토리 체크 '이벤트 종료후 삭제
	Set clsDiaryPrdCheck = Nothing
	Set addEx = Nothing
	Set oDeal = Nothing
%>
<% if cFlgDBUse then %><script language="JavaScript" type="text/javascript" SRC="/lib/js/todayview.js"></script><% end if %>
<!-- #include virtual="/lib/db/dbclose.asp" -->
