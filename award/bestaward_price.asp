<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<% strPageTitle = "텐바이텐 10X10 : BEST AWARD : 가격대별 베스트" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual ="/lib/classes/enjoy/newawardcls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryPrdCls.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<%
	Dim atype,catecode, oaward, vMoney1_1, vMoney1_2, vMoney2_1, vMoney2_2, vMoney3_1, vMoney3_2, vMoney4_1, vMoney4_2, i
	dim classStr, adultChkFlag, adultPopupLink, linkUrl

	'카테고리가 없을 경우 랜덤처리
	catecode = RequestCheckVar(request("disp"),3)
	
	If catecode = "109" OR catecode = "108" OR catecode = "107" OR catecode = "105" Then
		Response.Redirect "/"
		dbget.Close()
		Response.End
	End IF
	
	if catecode="" then
		'카테고리 배열 선언

		''dim arrCDL
		''arrCDL = Split("101,102,103,104,114,106,112,117,116,118,115,110",",")
		'// 랜덤(초기준)으로 카테고리 선정
		''catecode = arrCDL(Second(now) mod (Ubound(arrCDL)+1))
	end if
	'cdl = NullFillWith(RequestCheckVar(request("cdl"),3),"010")

	atype = RequestCheckVar(request("atype"),1)
	if atype="" then atype="b"

	set oaward = new CAWard

	vMoney1_1 = 0
	vMoney1_2 = Split(oaward.GetPriceBetween(catecode),",")(0)
	vMoney2_1 = CLng(vMoney1_2) + 1
	vMoney2_2 = Split(oaward.GetPriceBetween(catecode),",")(1)
	vMoney3_1 = CLng(vMoney2_2) + 1
	vMoney3_2 = Split(oaward.GetPriceBetween(catecode),",")(2)
	vMoney4_1 = vMoney3_2
	vMoney4_2 = 0

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
						<li><a href="/award/awardlist.asp?atype=b&disp=<%=catecode%>">베스트셀러</a></li>
						<li><a href="/award/awardlist.asp?atype=g&disp=<%=catecode%>">고객만족 베스트</a></li>
						<li><a href="/award/awardlist.asp?atype=f&disp=<%=catecode%>">베스트 위시</a></li>
						<li><a href="/award/bestaward_new.asp?disp=<%=catecode%>">신상품 베스트</a></li>
						<li class="on"><a href="/award/bestaward_price.asp?disp=<%=catecode%>">가격대별 베스트</a></li>
						<li><a href="/award/bestaward_colorpalette.asp?disp=<%=catecode%>">베스트 컬러</a></li>
						<li><a href="/award/awardbrandlist.asp?disp=<%=catecode%>">베스트 브랜드</a></li>
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
							<%=fnAwardBestCategoryLI(catecode,"/award/bestaward_price.asp?atype="&atype&"&")%>
						</ul>
					</div>
				</div>
			</div>
			<div class="hotSectionV15">
				<div class="hotArticleV15">
					<div class="bestPriceV15">
						<dl>
							<dt class="tit-bestprice"><span class="down"><%= FormatNumber(vMoney1_2,0) %>won</span></dt>
							<dd>
								<div class="pdtWrap pdt200V15">
									<ul class="pdtList">
									<%
										oaward.FDisp1 = catecode
										oaward.FMoney1 = vMoney1_1
										oaward.FMoney2 = vMoney1_2
										oaward.GetBestSellersPrice
	
										For i=0 To oaward.FResultCount-1

										classStr = ""
										linkUrl = "/shopping/category_prd.asp?itemid="& oaward.FItemList(i).FItemID 
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
													<a href="/shopping/category_prd.asp?itemid=<%=oaward.FItemList(i).FItemId%>">
														<span class="soldOutMask"></span>
														<img src="<%=oaward.FItemList(i).Ficon1image%>" alt="<%=oaward.FItemList(i).FItemName%>" />
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
													 		IF oaward.FItemList(i).isReipgoItem Then Response.Write "<img src='http://fiximage.10x10.co.kr/web2011/category/icon_re.gif' width='26' height='11' hspace='2' style='display:inline;'> "
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
										next
										%>
									</ul>
								</div>
							</dd>
						</dl>
						<dl>
							<dt class="tit-bestprice"><span class="down"><%= FormatNumber(vMoney2_2,0) %>won</span></dt>
							<dd>
								<div class="pdtWrap pdt200V15">
									<ul class="pdtList">
									<%
										oaward.FDisp1 = catecode
										oaward.FMoney1 = vMoney2_1
										oaward.FMoney2 = vMoney2_2
										oaward.GetBestSellersPrice

										For i=0 To oaward.FResultCount-1

										classStr = ""
										linkUrl = "/shopping/category_prd.asp?itemid="& oaward.FItemList(i).FItemID 
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
													<a href="/shopping/category_prd.asp?itemid=<%=oaward.FItemList(i).FItemId%>">
														<span class="soldOutMask"></span>
														<img src="<%=oaward.FItemList(i).Ficon1image%>" alt="<%=oaward.FItemList(i).FItemName%>" />
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
													 		IF oaward.FItemList(i).isReipgoItem Then Response.Write "<img src='http://fiximage.10x10.co.kr/web2011/category/icon_re.gif' width='26' height='11' hspace='2' style='display:inline;'> "
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
										next
										%>
									</ul>
								</div>
							</dd>
						</dl>

						<dl>
							<dt class="tit-bestprice"><span class="down"><%= FormatNumber(vMoney3_2,0) %>won</span></dt>
							<dd>
								<div class="pdtWrap pdt200V15">
									<ul class="pdtList">
									<%
										oaward.FDisp1 = catecode
										oaward.FMoney1 = vMoney3_1
										oaward.FMoney2 = vMoney3_2
										oaward.GetBestSellersPrice

										For i=0 To oaward.FResultCount-1
										classStr = ""
										linkUrl = "/shopping/category_prd.asp?itemid="& oaward.FItemList(i).FItemID 
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
									%>
										<li class="<%=classStr%>" <%=chkIIF(adultChkFlag, "onclick=""confirmAdultAuth('"&linkUrl&"');""","")%> >
											<p class="ranking"><%= i+1 %>.</p>
											<div class="pdtBox">
												<div class="pdtPhoto">
												<% if adultChkFlag then %>									
												<div class="adult-hide">
													<p><span>19세 이상만</span> <span>구매 가능한 상품입니다</span></p>
												</div>
												<% end if %>														
													<a href="/shopping/category_prd.asp?itemid=<%=oaward.FItemList(i).FItemId%>">
														<span class="soldOutMask"></span>
														<img src="<%=oaward.FItemList(i).Ficon1image%>" alt="<%=oaward.FItemList(i).FItemName%>" />
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
													 		IF oaward.FItemList(i).isReipgoItem Then Response.Write "<img src='http://fiximage.10x10.co.kr/web2011/category/icon_re.gif' width='26' height='11' hspace='2' style='display:inline;'> "
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
										next
										%>
									</ul>
								</div>
							</dd>
						</dl>
						<dl>
							<dt class="tit-bestprice"><span class="up"><%= FormatNumber(vMoney3_2,0) %>won</span></dt>
							<dd>
								<div class="pdtWrap pdt200V15">
									<ul class="pdtList">
									<%
										oaward.FDisp1 = catecode
										oaward.FMoney1 = vMoney4_1
										oaward.FMoney2 = vMoney4_2
										oaward.GetBestSellersPrice

										For i=0 To oaward.FResultCount-1
										
										classStr = ""
										linkUrl = "/shopping/category_prd.asp?itemid="& oaward.FItemList(i).FItemID 
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
									%>
										<li class="<%=classStr%>" <%=chkIIF(adultChkFlag, "onclick=""confirmAdultAuth('"&linkUrl&"');""","")%> >
											<p class="ranking"><%= i+1 %>.</p>
											<div class="pdtBox">
												<div class="pdtPhoto">
												<% if adultChkFlag then %>									
												<div class="adult-hide">
													<p><span>19세 이상만</span> <span>구매 가능한 상품입니다</span></p>
												</div>
												<% end if %>														
													<a href="/shopping/category_prd.asp?itemid=<%=oaward.FItemList(i).FItemId%>">
														<span class="soldOutMask"></span>
														<img src="<%=oaward.FItemList(i).Ficon1image%>" alt="<%=oaward.FItemList(i).FItemName%>" />
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
													 		IF oaward.FItemList(i).isReipgoItem Then Response.Write "<img src='http://fiximage.10x10.co.kr/web2011/category/icon_re.gif' width='26' height='11' hspace='2' style='display:inline;'> "
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
										next
										%>
									</ul>
								</div>
							</dd>
						</dl>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->