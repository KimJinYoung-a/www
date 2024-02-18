<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "utf-8" %>
<%
	Response.AddHeader "Cache-Control","no-cache"
	Response.AddHeader "Expires","0"
	Response.AddHeader "Pragma","no-cache"
%>
<%
'###########################################################
' Description :  기프트
' History : 2015.02.09 한용민 생성
'###########################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/functions.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/item/iteminfoCls.asp" -->
<!-- #include virtual="/lib/classes/gift/giftCls.asp" -->
<!-- #include virtual="/gift/lib/giftFunction.asp" -->
<!-- #include virtual="/gift/Underconstruction_gift.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->

<%
Dim oGiftShop, page, PageSize, vPackIdx, vSortMtd, isSoldOut, i
	page		= getNumeric(requestcheckvar(request("page"),10))
	vPackIdx	= getNumeric(requestcheckvar(request("pack"),10))
	vSortMtd	= requestcheckvar(request("sort"),2)
	isSoldOut	= requestcheckvar(request("sold"),1)

if page="" then page=1
if vPackIdx="" then vPackIdx=1			'포장구분 (기본:플라워)
if vSortMtd="" then vSortMtd="ne"
if isSoldOut="" then isSoldOut="Y"		'품절상품 포함여부 (Y:포함, N:제외)

PageSize=16

'// 포장상품 목록 접수
Set oGiftShop = new CGiftTalk
	oGiftShop.FPageSize=PageSize
	oGiftShop.FCurrPage=page
	oGiftShop.FRectSortMtd = "be"	'vSortMtd		'정렬방법
	oGiftShop.FRectPackIdx = vPackIdx		'포장상품 구분
	'oGiftShop.FRectIsSoldOut = isSoldOut	'품절포함여부
	oGiftShop.GetPackageList

'=============================== 해더의 타이틀 및 관련태그의 삽입처리 ===========================================
'타이틀 설정
strPageTitle = "텐바이텐 10X10 : GIFT 선물 포장 아이템"
'페이지 설명 설정
strPageDesc = "생활감성채널 텐바이텐 GIFT - 선물에 관한 창의적이고 신선한 테마를 만들어보세요!"
'페이지 요약 이미지(SNS 퍼가기용)
strPageImage = ""
'페이지 URL(SNS 퍼가기용)
strPageUrl = wwwUrl & "/gift/WRAPPING.asp"
%>

<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/section.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<script type="text/javascript">

function goPage(page){
	frmgift.page.value=page;
	frmgift.submit();
}

function fnChgPackDiv(pid) {
	frmgift.pack.value=pid;
	frmgift.submit();
}

function goWriteTheme() {
<% If IsUserLoginOK Then %>
	location.href = "/gift/shop/themeWrite.asp";
<% Else %>
	jsChklogin('<%=IsUserLoginOK%>');
<% End If %>
}

function fnSort(mtd) {
	frmgift.sort.value=mtd;
	frmgift.submit();
}

function fnChgSoldOut(sw) {
	frmgift.sold.value=sw;
	frmgift.submit();
}

function goLinkPage(div,iid,cnt) {
	if(cnt>0) {
		switch(div) {
			case 'talk':
				location.href="/gift/talk/?itemid="+iid;
				break;
			case 'day':
				location.href="/gift/day/?itemid="+iid;
				break;
			case 'shop':
				location.href="/gift/shop/?itemid="+iid;
				break;
		}
	}
}

//검색페이지 보기
function gogifttalksearch(itemid){
	location.href="/gift/talk/search.asp?itemid="+itemid
}

function itemwrite(itemid){
	frmtalk.ritemid.value=itemid;
	frmtalk.submit();
}

$(function(){
	$("#wrappingList .pdtList .pdtBox .btnmore").hide();
	$("#wrappingList .pdtList .pdtBox .pdtPhoto").mouseover(function(){
		$(this).find(".btnmore").fadeIn("fast");
	});
	$("#wrappingList .pdtList .pdtBox .pdtPhoto").mouseleave(function(){
		$(this).find(".btnmore").fadeOut("fast");
	});
});

</script>
</head>
<body>
<div id="giftWrapV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container giftSection">
		<div id="contentWrap">
			<div class="head">
				<!-- #include virtual="/gift/inc_gift_menu.asp" -->
			</div>
			<div class="navgift">
				<!-- #include virtual="/gift/inc_gift_WRAPPING_menu.asp" -->
			</div>
			<%
			if oGiftShop.FResultCount>0 then
			%>
				<div id="wrappingList" class="wrappingList pdtWrap pdt230">
					<ul class="pdtList">
						<% for i=0 to oGiftShop.FResultCount-1 %>
						<li>
							<div class="pdtBox">
								<div class="pdtPhoto">
									<p>
										<a href="/shopping/category_prd.asp?itemid=<%= oGiftShop.FItemList(i).FItemID %>">
										<img src="<%=getThumbImgFromURL(oGiftShop.FItemList(i).FImageBasic,230,230,"true","false")%>" alt="<%=Replace(oGiftShop.FItemList(i).FItemName,"""","")%>" width="230" height="230" /></a>
									</p>
									<span class="btnmore">
										<% '<!-- for dev msg : 해당 상품에 쓰여진 기프트 톡 갯수 카운팅입니다. 100이상이면 99+로 표시해주세요. --> %>
										<a href="" onclick="gogifttalksearch('<%= oGiftShop.FItemList(i).FItemID %>'); return false;">보기 
										<strong>
											<% if oGiftShop.FItemList(i).FtalkCnt >= 100 then %>
												99+
											<% else %>
												<%= oGiftShop.FItemList(i).FtalkCnt %>
											<% end if %>
										</strong></a>
										<a href="" onclick="itemwrite('<%= oGiftShop.FItemList(i).FItemID %>'); return false;">쓰기</a>
									</span>
								</div>
								<div class="pdtInfo">
									<p class="pdtBrand"><a href="/street/street_brand.asp?makerid=<%= oGiftShop.FItemList(i).FMakerid %>"><% = oGiftShop.FItemList(i).FBrandName %></p>
									<p class="pdtName tPad07"><a href="/shopping/category_prd.asp?itemid=<%= oGiftShop.FItemList(i).FItemID %>"><% = oGiftShop.FItemList(i).FItemName %></a></p>

									<% if oGiftShop.FItemList(i).IsSaleItem or oGiftShop.FItemList(i).isCouponItem Then %>
										<% IF oGiftShop.FItemList(i).IsSaleItem then %>
										<p class="pdtPrice tPad10"><span class="txtML"><%=FormatNumber(oGiftShop.FItemList(i).getOrgPrice,0)%>원</span></p>
										<p class="pdtPrice"><span class="finalP"><%=FormatNumber(oGiftShop.FItemList(i).getRealPrice,0)%>원</span> <strong class="crRed">[<%=oGiftShop.FItemList(i).getSalePro%>]</strong></p>
										<% End If %>
										<% IF oGiftShop.FItemList(i).IsCouponItem Then %>
											<% if Not(oGiftShop.FItemList(i).IsFreeBeasongCoupon() or oGiftShop.FItemList(i).IsSaleItem) Then %>
										<p class="pdtPrice tPad10"><span class="txtML"><%=FormatNumber(oGiftShop.FItemList(i).getOrgPrice,0)%>원</span></p>
											<% end If %>
										<p class="pdtPrice"><span class="finalP"><%=FormatNumber(oGiftShop.FItemList(i).GetCouponAssignPrice,0)%>원</span> <strong class="crGrn">[<%=oGiftShop.FItemList(i).GetCouponDiscountStr%>]</strong></p>
										<% End If %>
									<% Else %>
										<p class="pdtPrice"><span class="finalP"><%=FormatNumber(oGiftShop.FItemList(i).getRealPrice,0) & chkIIF(oGiftShop.FItemList(i).IsMileShopitem,"Point","원")%></span></p>
									<% End If %>
								</div>
							</div>
						</li>
						<% Next %>
					</ul>
					<div class="pageWrapV15 tMar20"><%=fnDisplayPaging_New(page,oGiftShop.FTotalCount,pageSize,10,"goPage")%></div>
				</div>
			<%
			else
			%>
				<p class="nodata"><span></span>등록된 선물 포장 상품이 없습니다.</p>
			<%
			end If
			%>

			
			<form name="frmtalk" method="post" action="/gift/talk/write.asp" style="margin:0px;">
			<input type="hidden" name="isitemdetail" value="o">
			<input type="hidden" name="ritemid">
			</form>
			<form name="frmgift" method="get" style="margin:0px;">
			<input type="hidden" name="pack" value="<%=vPackIdx%>">
			<input type="hidden" name="page" value="1">
			<input type="hidden" name="sort" value="<%=vSortMtd%>">
			<input type="hidden" name="sold" value="<%=isSoldOut%>">
			</form>
		
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>

<%
Set oGiftShop = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->