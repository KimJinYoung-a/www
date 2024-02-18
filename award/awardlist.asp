<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : BEST AWARD"		'페이지 타이틀 (필수)
%>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual ="/lib/classes/enjoy/newawardcls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<%
	Dim atype,catecode
	catecode = RequestCheckVar(request("disp"),3)
	atype = RequestCheckVar(request("atype"),1)
	if atype="" or atype="s" then atype="b" '2015-09-17 b -> f 변경 기본b
	Dim cntless : cntless  = true

	Dim oaward
	set oaward = new CAWard
	oaward.FPageSize = 100
	oaward.FDisp1 = catecode

	oaward.FRectAwardgubun = atype
	oaward.GetNormalItemList

	If oaward.FResultCount < 3 and atype<>"s" Then
		cntless = false
		oaward.GetNormalItemList5down
	End if

	Dim i

	'RecoPick 스크립트 incFooter.asp에서 출력; 2014.10.17 원승현 추가
'	RecoPickSCRIPT = "	recoPick('page', 'award');" ' 레코픽 서비스 해지로 제거 
%>
<script type="text/javascript" src="/lib/js/jquery.numspinner.min.js"></script>
<script>
$(function() {
	//급상승 상품 mark control
	$(".bestUpV15 .ranking").append("<span>급상승한 상품입니다</span>");
	$(".pdtList p").click(function(e){
		e.stopPropagation();				
	});	
});


function onGaProductClick(itemid, itemname, brand, posi)
{
	ga('ec:addProduct',{
		'id' : itemid,
		'name' : itemname,
		'brand' : brand
	});
	ga('ec:setAction', 'click',{list:'BestAward'});

	ga('send', 'event', 'UX', 'click', 'itemPrd');
	
	document.location = '/shopping/category_prd.asp?itemid='+itemid+'&gaparam=bestaward_<%=atype%>_'+posi; <%''2017/05/25 gaparam added %>

}

</script>
</head>
<body>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container skinV19">
		<div id="contentWrap" class="bestAwdV17">
			<div class="hotHgroupV19">
				<div class="tab-area">
					<ul>
						<li class="on"><a href="#">베스트 셀러</a></li>
						<li><a href="/bestreview/bestreview_main.asp?disp=<%=catecode%>">베스트 리뷰</a></li>
					</ul>
				</div>
				<h2>BEST SELLER</h2>
				<div class="grpSubWrapV19">
					<ul>
						<li class="<%=CHKIIF(atype="b","on","")%>"><a href="/award/awardlist.asp?atype=b&disp=<%=catecode%>">베스트셀러</a></li>
						<li class="<%=CHKIIF(atype="g","on","")%>"><a href="/award/awardlist.asp?atype=g&disp=<%=catecode%>">고객만족 베스트</a></li>
						<li class="<%=CHKIIF(atype="f","on","")%>"><a href="/award/awardlist.asp?atype=f&disp=<%=catecode%>">베스트 위시</a></li>
						<li class="<%=CHKIIF(atype="s","on","")%>"><a href="/award/bestaward_new.asp">신상품 베스트</a></li>
						<li><a href="/award/bestaward_price.asp?&disp=<%=catecode%>">가격대별 베스트</a></li>
						<li><a href="/award/bestaward_colorpalette.asp?&disp=<%=catecode%>">베스트 컬러</a></li>
						<li><a href="/award/awardbrandlist.asp?&disp=<%=catecode%>">베스트 브랜드</a></li>
					</ul>
				</div>
			</div>
			<div class="snb-bar">
				<div class="snbbar-inner">
					<div class="btn-ctgr"><span><%=fnSelectCategoryName(catecode)%></span></div>
				</div>
				<div class="lnbHotV19">
					<div class="inner">
						<ul>
							<li class="<%= chkIIF(catecode="","on","") %>"><a href="?atype=<%=atype%>">전체 카테고리</a></li>
							<%=fnAwardBestCategoryLI(catecode,"/award/awardlist.asp?atype="&atype&"&")%>
						</ul>
					</div>
				</div>
			</div>
			<div class="hotSectionV15">
				<div class="hotArticleV15">
					<div class="ctgyBestV15">
						<div class="pdtWrap pdt240V15">
							<ul class="pdtList">
						 <%
						 	dim classStr, adultChkFlag, adultPopupLink, linkUrl
			            	for i=0 to oaward.FPageSize-1

				            If oaward.FResultCount>0 AND oaward.FResultCount > i Then
								classStr = ""
								linkUrl = "/shopping/category_prd.asp?itemid="& oaward.FItemList(i).FItemId 
								adultChkFlag = false
								adultChkFlag = session("isAdult") <> true and oaward.FItemList(i).FadultType = 1								

								If oaward.FItemList(i).GetLevelUpCount > "29" then
									classStr = addClassStr(classStr,"bestUpV15")															
								end if
								If oaward.FItemList(i).isSoldOut=true then
									classStr = addClassStr(classStr,"soldOut")							
								end if				
								if adultChkFlag then
									classStr = addClassStr(classStr,"adult-item")								
								end if																				
								If i < 3 then
			          	 %>								
								<li class="<%=classStr%>" <%=chkIIF(adultChkFlag, "onclick=""confirmAdultAuth('"&linkUrl&"');""","")%> > 						
									<p class="ranking">BEST <%= i+1 %></p>
									<div class="pdtBox">
										<% '// 해외직구배송작업추가(원승현) %>
										<% If oaward.FItemList(i).IsDirectPurchase Then %>
											<i class="abroad-badge">해외직구</i>
										<% End If %>
										<div class="pdtPhoto">
										<% if adultChkFlag then %>									
										<div class="adult-hide">
											<p><span>19세 이상만</span> <span>구매 가능한 상품입니다</span></p>
										</div>
										<% end if %>										
											<a href="/shopping/category_prd.asp?itemid=<%=oaward.FItemList(i).FItemId%>" onclick="onGaProductClick('<%= oaward.FItemList(i).FItemId %>', '<%=server.URLEncode(oaward.FItemList(i).FItemName)%>', '<%=server.URLEncode(Trim(Replace(oaward.FItemList(i).FBrandName, "'","")))%>','<%=i+1%>');return false;">
											<!--a href="/shopping/category_prd.asp?itemid=<%= oaward.FItemList(i).FItemId %>"-->
												<span class="soldOutMask"></span>
												<img src="<%= getThumbImgFromURL(oaward.FItemList(i).FImageBasic,240,240,"true","false") %>" alt="<%=oaward.FItemList(i).FItemName%>" />
												<dfn><img src="http://fiximage.10x10.co.kr/web2013/@temp/pdt01_400x400.jpg" alt="<%=oaward.FItemList(i).FItemName%>" /></dfn>
											</a>
										</div>
										<div class="pdtInfo">
											<p class="pdtBrand tPad20"><a href="/street/street_brand.asp?makerid=<%=oaward.FItemList(i).FMakerid%>"><%=oaward.FItemList(i).FBrandName%></a></p>
											<p class="pdtName tPad07"><a href="/shopping/category_prd.asp?itemid=<%=oaward.FItemList(i).FItemId%>"><%=oaward.FItemList(i).FItemName%></a></p>
											<%
												If oaward.FItemList(i).IsSaleItem or oaward.FItemList(i).isCouponItem Then
													'If oaward.FItemList(i).Fitemcoupontype <> "3" Then
													'	Response.Write "<p class='pdtPrice'><span class='txtML'>" & FormatNumber(oaward.FItemList(i).FOrgPrice,0) & "원 </span></p>"
													'End If
													IF oaward.FItemList(i).IsSaleItem Then
														Response.Write "<p class='pdtPrice'><span class='txtML'>" & FormatNumber(oaward.FItemList(i).FOrgPrice,0) & "원 </span></p>"
														Response.Write "<p class='pdtPrice'><span class='finalP'>" & FormatNumber(oaward.FItemList(i).getRealPrice,0) & "원 </span>"
														Response.Write "<strong class='cRd0V15'>[" & oaward.FItemList(i).getSalePro & "]</strong></p>"
											 		End IF
											 		IF oaward.FItemList(i).IsCouponItem Then
											 			if Not(oaward.FItemList(i).IsFreeBeasongCoupon() or oaward.FItemList(i).IsSaleItem) Then
											 				Response.Write "<p class='pdtPrice'><span class='txtML'>" & FormatNumber(oaward.FItemList(i).FOrgPrice,0) & "원 </span></p>"
											 			end if
														Response.Write "<p class='pdtPrice'><span class='finalP'>" & FormatNumber(oaward.FItemList(i).GetCouponAssignPrice,0) & "원 </span>"
														Response.Write "<strong class='cGr0V15'>[" & oaward.FItemList(i).GetCouponDiscountStr & "]</strong></p>"
											 		End IF
												Else
													Response.Write "<p class='pdtPrice'><span class='finalP'>" & FormatNumber(oaward.FItemList(i).getRealPrice,0) & "원 </span>"
												End If
											%>
											<p class="pdtStTag tPad10">
											<%
												IF oaward.FItemList(i).isSoldOut Then
													Response.Write "<img src='http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif' alt='SOLDOUT' />"
												Else
											 		IF oaward.FItemList(i).isTenOnlyItem Then Response.Write "<img src='http://fiximage.10x10.co.kr/web2013/shopping/tag_only.gif' alt='ONLY' /> "
											 		IF oaward.FItemList(i).isSaleItem Then Response.Write "<img src='http://fiximage.10x10.co.kr/web2013/shopping/tag_sale.gif' alt='SALE' /> "
											 		IF oaward.FItemList(i).isCouponItem Then Response.Write "<img src='http://fiximage.10x10.co.kr/web2013/shopping/tag_coupon.gif' alt='쿠폰' /> "
											 		IF oaward.FItemList(i).isLimitItem Then Response.Write "<img src='http://fiximage.10x10.co.kr/web2013/shopping/tag_limited.gif' alt='한정' /> "
											 		IF oaward.FItemList(i).isNewItem Then Response.Write "<img src='http://fiximage.10x10.co.kr/web2013/shopping/tag_new.gif' alt='NEW' /> "
												End If
											%>
											</p>
										</div>
										<ul class="pdtActionV15">
											<li class="largeView"><a href="" onclick="ZoomItemInfo('<%=oaward.FItemList(i).FItemid%>'); return false;"><img src="http://fiximage.10x10.co.kr/web2015/common/btn_quick.png" alt="QUICK" /></a></li>
											<li class="postView"><a href="" onclick="popEvaluate('<%=oaward.FItemList(i).FItemid%>'); return false;"><span><%= oaward.FItemList(i).FEvalCnt %></span></a></li>
											<li class="wishView"><a href="" onclick="TnAddFavorite('<%=oaward.FItemList(i).FItemid %>'); return false;"><span><%= oaward.FItemList(i).FfavCount %></span></a></li>
										</ul>
									</div>
								</li>
							<%
								end if
							End If
							Next
							%>
							</ul>
						</div>
					</div>

					<div class="pdtWrap pdt200V15">
						<ul class="pdtList">
						 <%
			            	for i=0 to oaward.FPageSize-1
				            If oaward.FResultCount>0 AND oaward.FResultCount > i Then							
								classStr = ""
								linkUrl = "/shopping/category_prd.asp?itemid="& oaward.FItemList(i).FItemId 
								adultChkFlag = false
								adultChkFlag = session("isAdult") <> true and oaward.FItemList(i).FadultType = 1								

								If oaward.FItemList(i).GetLevelUpCount > "29" then
									classStr = addClassStr(classStr,"bestUpV15")															
								end if
								If oaward.FItemList(i).isSoldOut=true then
									classStr = addClassStr(classStr,"soldOut")							
								end if				
								if adultChkFlag then
									classStr = addClassStr(classStr,"adult-item")								
								end if	

								If i > 2 then
			          	 %>
							<li class="<%=classStr%>" <%=chkIIF(adultChkFlag, "onclick=""confirmAdultAuth('"&linkUrl&"');""","")%> >
								<p class="ranking"><%= i+1 %>.</p>
								<div class="pdtBox">
									<% '// 해외직구배송작업추가(원승현) %>
									<% If oaward.FItemList(i).IsDirectPurchase Then %>
										<i class="abroad-badge">해외직구</i>
									<% End If %>
									<div class="pdtPhoto">
									<% if adultChkFlag then %>									
									<div class="adult-hide">
										<p><span>19세 이상만</span> <span>구매 가능한 상품입니다</span></p>
									</div>
									<% end if %>									
										<a href="/shopping/category_prd.asp?itemid=<%=oaward.FItemList(i).FItemId%>" onclick="onGaProductClick('<%= oaward.FItemList(i).FItemId %>', '<%=server.URLEncode(oaward.FItemList(i).FItemName)%>', '<%=server.URLEncode(Trim(Replace(oaward.FItemList(i).FBrandName, "'","")))%>','<%=i+1%>');return false;">
										<!--a href="/shopping/category_prd.asp?itemid=<%= oaward.FItemList(i).FItemId %>"-->
											<span class="soldOutMask"></span>
											<img src="<%= oaward.FItemList(i).Ficon1image %>" alt="<%=oaward.FItemList(i).FItemName%>" />
											<dfn><img src="http://fiximage.10x10.co.kr/web2013/@temp/pdt01_400x400.jpg" alt="<%=oaward.FItemList(i).FItemName%>" /></dfn>
										</a>
									</div>
									<div class="pdtInfo">
										<p class="pdtBrand tPad20"><a href="/street/street_brand.asp?makerid=<%=oaward.FItemList(i).FMakerid%>"><%=oaward.FItemList(i).FBrandName%></a></p>
										<p class="pdtName tPad07"><a href="/shopping/category_prd.asp?itemid=<%=oaward.FItemList(i).FItemId%>"><%=oaward.FItemList(i).FItemName%></a></p>
										<%
											If oaward.FItemList(i).IsSaleItem or oaward.FItemList(i).isCouponItem Then
												'If oaward.FItemList(i).Fitemcoupontype <> "3" Then
												'	Response.Write "<p class='pdtPrice'><span class='txtML'>" & FormatNumber(oaward.FItemList(i).FOrgPrice,0) & "원 </span></p>"
												'End If
												IF oaward.FItemList(i).IsSaleItem Then
													Response.Write "<p class='pdtPrice'><span class='txtML'>" & FormatNumber(oaward.FItemList(i).FOrgPrice,0) & "원 </span></p>"
													Response.Write "<p class='pdtPrice'><span class='finalP'>" & FormatNumber(oaward.FItemList(i).getRealPrice,0) & "원 </span>"
													Response.Write "<strong class='cRd0V15'>[" & oaward.FItemList(i).getSalePro & "]</strong></p>"
										 		End IF
										 		IF oaward.FItemList(i).IsCouponItem Then
										 			if Not(oaward.FItemList(i).IsFreeBeasongCoupon() or oaward.FItemList(i).IsSaleItem) Then
										 				Response.Write "<p class='pdtPrice'><span class='txtML'>" & FormatNumber(oaward.FItemList(i).FOrgPrice,0) & "원 </span></p>"
										 			end if
													Response.Write "<p class='pdtPrice'><span class='finalP'>" & FormatNumber(oaward.FItemList(i).GetCouponAssignPrice,0) & "원 </span>"
													Response.Write "<strong class='cGr0V15'>[" & oaward.FItemList(i).GetCouponDiscountStr & "]</strong></p>"
										 		End IF
											Else
												Response.Write "<p class='pdtPrice'><span class='finalP'>" & FormatNumber(oaward.FItemList(i).getRealPrice,0) & "원 </span>"
											End If
										%>
										<p class="pdtStTag tPad10">
										<%
											IF oaward.FItemList(i).isSoldOut Then
												Response.Write "<img src='http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif' alt='SOLDOUT' />"
											Else
										 		IF oaward.FItemList(i).isTenOnlyItem Then Response.Write "<img src='http://fiximage.10x10.co.kr/web2013/shopping/tag_only.gif' alt='ONLY' /> "
										 		IF oaward.FItemList(i).isSaleItem Then Response.Write "<img src='http://fiximage.10x10.co.kr/web2013/shopping/tag_sale.gif' alt='SALE' /> "
										 		IF oaward.FItemList(i).isCouponItem Then Response.Write "<img src='http://fiximage.10x10.co.kr/web2013/shopping/tag_coupon.gif' alt='쿠폰' /> "
										 		IF oaward.FItemList(i).isLimitItem Then Response.Write "<img src='http://fiximage.10x10.co.kr/web2013/shopping/tag_limited.gif' alt='한정' /> "
										 		IF oaward.FItemList(i).isNewItem Then Response.Write "<img src='http://fiximage.10x10.co.kr/web2013/shopping/tag_new.gif' alt='NEW' /> "
											End If
										%>
										</p>
									</div>
									<ul class="pdtActionV15">
										<li class="largeView"><a href="" onclick="ZoomItemInfo('<%=oaward.FItemList(i).FItemid%>'); return false;"><img src="http://fiximage.10x10.co.kr/web2015/common/btn_quick.png" alt="QUICK" /></a></li>
										<li class="postView"><a href="" onclick="popEvaluate('<%=oaward.FItemList(i).FItemid%>'); return false;"><span><%= oaward.FItemList(i).FEvalCnt %></span></a></li>
										<li class="wishView"><a href="" onclick="TnAddFavorite('<%=oaward.FItemList(i).FItemid %>'); return false;"><span><%= oaward.FItemList(i).FfavCount %></span></a></li>
									</ul>
								</div>
							</li>
							<% end if %>
						<%
							End If
							Next
						%>
						</ul>
					</div>
				</div>
			</div>
			<%' 레코픽 추가(10/16) %>
			<%' 레코픽 서비스 해지로 인한 제거 (150630) %>
			<!--
			<script type="text/javascript">
				var vIId=<%=oaward.FItemList(0).FItemId%>, vDisp='';
			</script>
			<script type="text/javascript" src="./inc_happyTogether.js"></script>
			<div class="recopickPdt tMar80" id="lyrHPTgr"></div>
			-->
			<%'// 레코픽 추가(10/16) %>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->