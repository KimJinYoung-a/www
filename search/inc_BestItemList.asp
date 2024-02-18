<%
'#######################################################
'	History	:  2013.09.28 허진원 생성
'	Description : 키워드 메이트 > 베스트셀러
'                 검색결과가 없을때 BEST순(itemscroe) 상품 목록
'#######################################################

	'// 베스트 상품 접수
	Dim oKDoc
	set oKDoc = new SearchItemCls
	'oKDoc.FRectSearchTxt = DocSearchText	'검색어
	'oKDoc.FRectExceptText = ExceptText		'제외어
	oKDoc.FRectSortMethod	= "be"			'Best순
	'oKDoc.FRectCateCode	= dispCate		'카테고리
	oKDoc.FRectSearchCateDep = "T"
	oKDoc.FRectSearchItemDiv = "y"
	oKDoc.FCurrPage = 1
	oKDoc.FPageSize = 20
	oKDoc.FScrollCount = 0
	oKDoc.FListDiv = "bestlist"
	oKDoc.FSellScope="Y"
	oKDoc.FRectSearchFlag = "n"
	'oKDoc.FminPrice	= "6000"			'최소 금액제한

	oKDoc.getSearchList

	if oKDoc.FResultCount>0 then
%>
<script type="text/javascript">
$(function(){
	//Keyword mate
	if ($('.kwdMateSlideV15 .pdtList').length > 1) {
		$('.kwdMateSlideV15').slidesjs({
			width:1140,
			height:440,
			start:1,
			navigation:{active:false},
			pagination:{active:true, effect:"fade"},
			play:{active:false, interval:5000, effect:"fade", auto:true},
			effect:{
				fade:{speed:750, crossfade:true}
			}
		});
	}

});
</script>
<div class="keywordPdtV15 tMar40">
	<h2><img src="http://fiximage.10x10.co.kr/web2015/shopping/tit_bestseller.gif" alt="베스트셀러" /></h2>
	<div class="pdtWrap pdt200V15 kwdMateSlideV15">
		<ul class="pdtList" id="bestpdtList">
			<% For lp=0 To (oKDoc.FResultCount-1) %>
				<li<%=chkIIF(oKDoc.FItemList(lp).isSoldOut," class=""soldOut""","")%>>
					<div class="pdtBox">
						<div class="pdtPhoto">
							<span class="soldOutMask"></span>
							<a href="/shopping/category_prd.asp?itemid=<%=oKDoc.FItemList(lp).FItemid%>">
								<img src="<%=oKDoc.FItemList(lp).FImageBasic%>" alt="<%=Replace(oKDoc.FItemList(lp).FItemName,"""","")%>" />
								<% if oKDoc.FItemList(lp).FAddimage<>"" then %><dfn><img src="<%=oKDoc.FItemList(lp).FAddimage%>" alt="<%=Replace(oKDoc.FItemList(lp).FItemName,"""","")%>" /></dfn><% end if %>
							</a>
						</div>
						<div class="pdtInfo">
							<p class="pdtBrand tPad20"><a href="/street/street_brand.asp?makerid=<%=oKDoc.FItemList(lp).FMakerid%>"><%=oKDoc.FItemList(lp).FBrandName%></a></p>
							<p class="pdtName tPad07"><a href="/shopping/category_prd.asp?itemid=<%=oKDoc.FItemList(lp).FItemid%>"><%=oKDoc.FItemList(lp).FItemName%></a></p>
							<% if oKDoc.FItemList(lp).IsSaleItem or oKDoc.FItemList(lp).isCouponItem Then %>
								<% IF oKDoc.FItemList(lp).IsSaleItem then %>
								<p class="pdtPrice"><span class="txtML"><%=FormatNumber(oKDoc.FItemList(lp).getOrgPrice,0)%>원</span></p>
								<p class="pdtPrice"><span class="finalP"><%=FormatNumber(oKDoc.FItemList(lp).getRealPrice,0)%>원</span> <strong class="cRd0V15">[<%=oKDoc.FItemList(lp).getSalePro%>]</strong></p>
								<% End If %>
								<% IF oKDoc.FItemList(lp).IsCouponItem Then %>
									<% if Not(oKDoc.FItemList(lp).IsFreeBeasongCoupon() or oKDoc.FItemList(lp).IsSaleItem) Then %>
								<p class="pdtPrice"><span class="txtML"><%=FormatNumber(oKDoc.FItemList(lp).getOrgPrice,0)%>원</span></p>
									<% end If %>
								<p class="pdtPrice"><span class="finalP"><%=FormatNumber(oKDoc.FItemList(lp).GetCouponAssignPrice,0)%>원</span> <strong class="cGr0V15">[<%=oKDoc.FItemList(lp).GetCouponDiscountStr%>]</strong></p>
								<% End If %>
							<% Else %>
								<p class="pdtPrice"><span class="finalP"><%=FormatNumber(oKDoc.FItemList(lp).getRealPrice,0) & chkIIF(oKDoc.FItemList(lp).IsMileShopitem,"Point","원")%></span></p>
							<% End If %>
							<p class="pdtStTag tPad10">
								<% IF oKDoc.FItemList(lp).isSoldOut Then %>
									<img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" />
								<% else %>
									<% IF oKDoc.FItemList(lp).isTempSoldOut Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" /> <% end if %>
									<% IF oKDoc.FItemList(lp).isSaleItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_sale.gif" alt="SALE" /> <% end if %>
									<% IF oKDoc.FItemList(lp).isCouponItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_coupon.gif" alt="쿠폰" /> <% end if %>
									<% IF oKDoc.FItemList(lp).isLimitItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_limited.gif" alt="한정" /> <% end if %>
									<% IF oKDoc.FItemList(lp).IsTenOnlyitem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_only.gif" alt="ONLY" /> <% end if %>
									<% IF oKDoc.FItemList(lp).isNewItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_new.gif" alt="NEW" /> <% end if %>
								<% end if %>
							</p>
						</div>
						<ul class="pdtActionV15">
							<li class="largeView"><a href="" onclick="ZoomItemInfo('<%=oKDoc.FItemList(lp).FItemid %>'); return false;"><img src="http://fiximage.10x10.co.kr/web2015/common/btn_quick.png" alt="QUICK" /></a></li>
							<li class="postView"><a href="" onclick="<%=chkIIF(oKDoc.FItemList(lp).FEvalCnt>0,"popEvaluate('" & oKDoc.FItemList(lp).FItemid & "');","")%>return false;"><span><%=oKDoc.FItemList(lp).FEvalCnt%></span></a></li>
							<li class="wishView"><a href="" onclick="TnAddFavorite('<%=oKDoc.FItemList(lp).FItemid %>'); return false;"><span><%=oKDoc.FItemList(lp).FfavCount%></span></a></li>
						</ul>
					</div>
				</li>
			<% next %>
		</ul>
	</div>
</div>
<%
	End if
	set oKDoc = Nothing
%>