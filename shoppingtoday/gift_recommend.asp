<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/item/itemInfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/classes/search/searchCls.asp" -->
<!-- #include virtual="/lib/classes/enjoy/shoppingchanceCls_B.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<%
	'페이지 정보
	strPageTitle = "텐바이텐 10X10 : 선물포장 서비스"		'페이지 타이틀 (필수)
	strPageImage = "https://fiximage.10x10.co.kr/page/title/pageImage_gift_v1.jpg"
	strPageDesc = "정성 두배! 감동 두배! 텐바이텐 선물포장 서비스를 이용해보세요!"
	'// 오픈그래프 메타태그
	strHeaderAddMetaTag = "<meta property=""og:title"" content=""[텐바이텐] 선물포장서비스"" />" & vbCrLf &_
						"<meta property=""og:type"" content=""website"" />" & vbCrLf &_
						"<meta property=""og:url"" content=""https://www.10x10.co.kr/shoppingtoday/gift_recommend.asp"" />" & vbCrLf &_
						"<meta property=""og:description"" content=""" & strPageDesc & """>" & vbCrLf

'============== 모바일 접근시 모바일 페이지 이동(referer가 10x10이면 이동안함) ============
if InStr(request.ServerVariables("HTTP_REFERER"),"10x10.co.kr")<1 then
	if Not(Request("mfg")="pc" or session("mfg")="pc") then
		if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
			dim mRdSite: mRdSite = requestCheckVar(request("rdsite"),32)
			Response.Redirect "http://m.10x10.co.kr/shoppingtoday/gift_recommend.asp" & chkIIF(mRdSite<>"","?rdsite=" & mRdSite,"")
			REsponse.End
		end if
	end if
end if

Dim catecode, lp,sPercent, flo1, flo2, price
catecode = getNumeric(requestCheckVar(Request("disp"),3))
price =	requestCheckVar(Request("price"),3)
flo1 =	requestCheckVar(Request("flo1"),5) '// 무료배송
flo2 =	requestCheckVar(Request("flo2"),5) '// 한정판매
dim PageSize	: PageSize = getNumeric(requestCheckVar(request("psz"),9))
dim SortMet		: SortMet = requestCheckVar(request("srm"),2)
dim CurrPage 	: CurrPage = getNumeric(requestCheckVar(request("cpg"),9))
dim icoSize		: icoSize = requestCheckVar(request("icoSize"),1)
dim minPrice, maxPrice

If price = "" Then
	price = "all"
End IF

'할인률 적용
Select Case price
	Case "0"
		minPrice = "1"
		maxPrice = "9999"
	Case "1"
		minPrice = "10000"
		maxPrice = "29999"
	Case "3"
		minPrice = "30000"
		maxPrice = "49999"
	Case "5"
		minPrice = "50000"
		maxPrice = "99999"
	Case "10"
		minPrice = "100000"
		maxPrice = "10000000"
end Select

if icoSize="" then icoSize="M"	'상품 아이콘 기본(중간)

dim ScrollCount
ScrollCount = 10

'추가 이미지 사이즈
dim imgSz	: imgSz = chkIIF(icoSize="M",180,150)

if SortMet="" then SortMet="ne"			''pj:인기포장순, ne:신상순
if CurrPage="" then CurrPage=1
if PageSize ="" then PageSize =16
'rw sPercent & "!"
dim oDoc,iLp
set oDoc = new SearchItemCls

oDoc.FListDiv 			= "fulllist"
oDoc.FRectSortMethod	= SortMet
oDoc.FRectSearchFlag 	= "pk"
oDoc.FPageSize 			= PageSize
oDoc.FRectCateCode		= catecode
oDoc.FisFreeBeasong		= flo1	'// 무료배송
oDoc.FisLimit			= flo2	'// 한정판매
oDoc.FminPrice			= minPrice
oDoc.FmaxPrice			= maxPrice
oDoc.FRectSearchItemDiv = "n"
oDoc.FRectSearchCateDep = "T"
oDoc.FCurrPage 			= CurrPage
oDoc.FSellScope 		= "Y"
oDoc.FScrollCount 		= ScrollCount

oDoc.getSearchList
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<script>
$(function() {
	$(".pdtList li .pdtPhoto").mouseenter(function(e){
		$(this).find("dfn").fadeIn(150);
	}).mouseleave(function(e){
		$(this).find("dfn").fadeOut(150);
	});
	
	$('.icoWrappingV15a').mouseover(function() {
		$(this).children('em').fadeIn();
	});

	$('.icoWrappingV15a').mouseleave(function() {
		$(this).children('em').hide();
	});
});

function fnSearch(frmnm,frmval){
	frmnm.value = frmval;

	var frm = document.sFrm;
	frm.cpg.value=1;
	frm.submit();

}
function TnMovePage(pg){
	document.sFrm.cpg.value=pg;
	document.sFrm.submit();
}

function jsGoUrl(catecode, price){
      location.href = "/shoppingtoday/gift_recommend.asp?disp="+catecode+"&price="+price+"&srm=<%=SortMet%>";
}
</script>
</head>
<body>
<div class="wrap giftGuideWrapV15a">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->

	<div class="container">
		<div class="giftGuideHeadV15a ">
			<div class="hGroup">
				<h2><img src="http://fiximage.10x10.co.kr/web2015/shopping/tit_wrapping_service.png" alt="텐바이텐 선물포장 서비스" /></h2>
				<p class="desc"><img src="http://fiximage.10x10.co.kr/web2015/shopping/txt_service.png" alt="정성 두배, 감동 두배! 선물 포장 서비스를 지금 이용해보세요! 여러가지 상품을 한번에 모아서 선물을 보낼 수 있습니다." /></p>
				<p><img src="http://fiximage.10x10.co.kr/web2015/shopping/txt_fee.png" alt="포장비 2,000원(선물 메시지 포함)" /></p>
			</div>
		</div>
		<div id="contentWrap" class="giftWrapV15a">
			<div class="hotSectionV15">
				<div class="deco"></div>
				<div class="lnbHotV15">
					<div class="all"><strong>전체 카테고리</strong></div>
					<ul>
						<li><a href="/shoppingtoday/gift_recommend.asp?price=<%=price%>&srm=<%=SortMet%>" <%= chkIIF(catecode="","class=on","") %>>전체</a></li>
						<%=fnAwardBestCategoryLI(catecode,"/shoppingtoday/gift_recommend.asp?price="&price&"&srm="&SortMet&"&")%>
					</ul>
				</div>

				<div class="hotArticleV15">
					<div class="grpSubWrapV15">
						<ul>
							<li <%=CHKIIF(price="all","class=current","")%>><a href="" onClick="jsGoUrl('<%=catecode%>','all'); return false;">All</a></li>
							<li <%=CHKIIF(price="0","class=current","")%>><a href="" onClick="jsGoUrl('<%=catecode%>','0'); return false;">1만원 미만</a></li>
							<li <%=CHKIIF(price="1","class=current","")%>><a href="" onClick="jsGoUrl('<%=catecode%>','1'); return false;">1~3만원</a></li>
							<li <%=CHKIIF(price="3","class=current","")%>><a href="" onClick="jsGoUrl('<%=catecode%>','3'); return false;">3~5만원</a></li>
							<li <%=CHKIIF(price="5","class=current","")%>><a href="" onClick="jsGoUrl('<%=catecode%>','5'); return false;">5~10만원</a></li>
							<li <%=CHKIIF(price="10","class=current","")%>><a href="" onClick="jsGoUrl('<%=catecode%>','10'); return false;">10만원이상</a></li>
						</ul>
					</div>
					<form name="sFrm" method="get" action="/shoppingtoday/gift_recommend.asp" style="margin:0px;">
					<input type="hidden" name="sflag" value="<%= oDoc.FRectSearchFlag  %>">
					<input type="hidden" name="disp" value="<%= oDoc.FRectcatecode %>">
					<input type="hidden" name="srm" value="<%= oDoc.FRectSortMethod%>">
					<input type="hidden" name="cpg" value="<%=oDoc.FCurrPage %>">
					<input type="hidden" name="psz" value="<%= PageSize%>">
					<input type="hidden" name="price" value="<%= price%>">
					<div class="sortingV15">
						<span class="blt"></span>
						<span class="total">total <strong><%= oDoc.FTotalCount %></strong></span>
						<div class="option">
							<select name="ttsrtm" class="optSelect" onchange="fnSearch(this.form.srm,this.value);" title="상품 정렬 방법 선택">
								<option value="pj" <% if SortMet="pj" then response.write "selected" %>>인기포장순</option>
								<option value="bs" <% if SortMet="bs" then response.write "selected" %>>판매량순</option>
								<option value="ne" <% if SortMet="ne" then response.write "selected" %>>신상품순</option>
								<option value="be" <% if SortMet="be" then response.write "selected" %>>인기상품순</option>
								<option value="hp" <% if SortMet="hp" then response.write "selected" %>>높은가격순</option>
								<option value="lp" <% if SortMet="lp" then response.write "selected" %>>낮은가격순</option>
								<option value="ws" <% if SortMet="ws" then response.write "selected" %>>인기위시순</option>
							</select>
						</div>
					</div>

					<div class="pdtWrap pdt180V15">
						<ul class="pdtList">
						<%
						IF oDoc.FResultCount >0 then
						dim i,TotalCnt
						dim cdlNTotCnt, icolS,icolE, cdlNCols
						dim maxLoop	,intLoop

						TotalCnt = oDoc.FResultCount

							For i=0 To TotalCnt-1
							 IF (i <= TotalCnt-1) Then
						%>
							<li <% If oDoc.FItemList(i).isSoldOut Then response.write "class='soldOut'" %>>
								<div class="pdtBox">
									<div class="pdtPhoto">
										<a href="javascript:TnGotoProduct('<%=oDoc.FItemList(i).FItemID %>')">
											<span class="soldOutMask"></span>
											<img src="<% = oDoc.FItemList(i).FImageIcon1 %>" width="180" height="180" alt="<% = oDoc.FItemList(i).FItemName %>" />
											<% if oDoc.FItemList(i).FAddimage<>"" then %><dfn><img src="<%=getThumbImgFromURL(oDoc.FItemList(i).FAddimage,imgSz,imgSz,"true","false")%>" alt="<%=Replace(oDoc.FItemList(i).FItemName,"""","")%>" /></dfn><% end if %>
										</a>
									</div>
									<div class="pdtInfo">
										<p class="pdtBrand tPad20"><a href="javascript:GoToBrandShop('<%=oDoc.FItemList(i).FMakerId %>')"><% = oDoc.FItemList(i).FBrandName %></a></p>
										<p class="pdtName tPad07"><a href="javascript:TnGotoProduct('<%=oDoc.FItemList(i).FItemID %>')"><% = oDoc.FItemList(i).FItemName %></a></p>
										<%
											If oDoc.FItemList(i).IsSaleItem or oDoc.FItemList(i).isCouponItem Then
												'If oDoc.FItemList(i).Fitemcoupontype <> "3" Then
												'	Response.Write "<p class='pdtPrice'><span class='txtML'>" & FormatNumber(oDoc.FItemList(i).FOrgPrice,0) & "원 </span></p>"
												'End If
												IF oDoc.FItemList(i).IsSaleItem Then
													Response.Write "<p class='pdtPrice'><span class='txtML'>" & FormatNumber(oDoc.FItemList(i).FOrgPrice,0) & "원 </span></p>"
													Response.Write "<p class='pdtPrice'><span class='finalP'>" & FormatNumber(oDoc.FItemList(i).getRealPrice,0) & "원 </span>"
													Response.Write "<strong class='cRd0V15'>[" & oDoc.FItemList(i).getSalePro & "]</strong></p>"
										 		End IF
										 		IF oDoc.FItemList(i).IsCouponItem Then
										 			if Not(oDoc.FItemList(i).IsFreeBeasongCoupon() or oDoc.FItemList(i).IsSaleItem) Then
										 				Response.Write "<p class='pdtPrice'><span class='txtML'>" & FormatNumber(oDoc.FItemList(i).FOrgPrice,0) & "원 </span></p>"
										 			end if
													Response.Write "<p class='pdtPrice'><span class='finalP'>" & FormatNumber(oDoc.FItemList(i).GetCouponAssignPrice,0) & "원 </span>"
													Response.Write "<strong class='cGr0V15'>[" & oDoc.FItemList(i).GetCouponDiscountStr & "]</strong></p>"
										 		End IF
											Else
												Response.Write "<p class='pdtPrice'><span class='finalP'>" & FormatNumber(oDoc.FItemList(i).getRealPrice,0) & "원 </span>"
											End If
										%>
										<p class="pdtStTag tPad10">
										<%
											IF oDoc.FItemList(i).isSoldOut Then
												Response.Write "<img src='http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif' alt='SOLDOUT' />"
											Else
										 		IF oDoc.FItemList(i).isTenOnlyItem Then Response.Write "<img src='http://fiximage.10x10.co.kr/web2013/shopping/tag_only.gif' alt='ONLY' /> "
										 		IF oDoc.FItemList(i).isSaleItem Then Response.Write "<img src='http://fiximage.10x10.co.kr/web2013/shopping/tag_sale.gif' alt='SALE' /> "
										 		IF oDoc.FItemList(i).isCouponItem Then Response.Write "<img src='http://fiximage.10x10.co.kr/web2013/shopping/tag_coupon.gif' alt='쿠폰' /> "
										 		IF oDoc.FItemList(i).isLimitItem Then Response.Write "<img src='http://fiximage.10x10.co.kr/web2013/shopping/tag_limited.gif' alt='한정' /> "
										 		IF oDoc.FItemList(i).isNewItem Then Response.Write "<img src='http://fiximage.10x10.co.kr/web2013/shopping/tag_new.gif' alt='NEW' /> "
										 		IF oDoc.FItemList(i).IsPojangitem Then Response.Write "<span class='icoWrappingV15a'><img src='http://fiximage.10x10.co.kr/web2015/shopping/ico_pakage_act.png' alt='선물포장가능'><em><img src='http://fiximage.10x10.co.kr/web2015/common/pkg_tip.png' alt='선물포장가능'></em></span> "
											End If
										%>
										</p>
									</div>
									<ul class="pdtActionV15">
										<li class="largeView"><a href="" onclick="ZoomItemInfo('<%=oDoc.FItemList(i).FItemid%>'); return false;"><img src="http://fiximage.10x10.co.kr/web2015/common/btn_quick.png" alt="QUICK" /></a></li>
										<li class="postView"><a href="" onclick="popEvaluate('<%=oDoc.FItemList(i).FItemid%>'); return false;"><span><%= oDoc.FItemList(i).FEvalCnt %></span></a></li>
										<li class="wishView"><a href="" onclick="TnAddFavorite('<%= oDoc.FItemList(i).FItemID %>'); return false;"><span><%= oDoc.FItemList(i).FFavCount %></span></a></li>
									</ul>
								</div>
							</li>
							<% End IF %>
							<% Next %>
						</ul>
					</div>
					<div class="pageWrapV15 tMar20">
						<%= fnDisplayPaging_New(CurrPage,oDoc.FTotalCount,PageSize,10,"TnMovePage") %>
					</div>
					<% Else %>
					</div>
					<div class="pageWrapV15 tMar20"></div>
						<div align="center"><p class="noData"><strong>해당 상품이 없습니다.</strong></p></div>
					<% ENd IF %>
				</form>
				</div>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<% Set oDoc = Nothing %>
<!-- #include virtual="/lib/db/dbclose.asp" -->