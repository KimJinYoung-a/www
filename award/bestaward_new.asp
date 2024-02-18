<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<% strPageTitle = "텐바이텐 10X10 : BEST NEW : 신상품 베스트" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/shoppingchanceCls_B.asp" -->
<!-- #include virtual="/lib/classes/item/itemInfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/classes/search/searchCls.asp" -->
<!-- #include virtual ="/lib/classes/enjoy/newawardcls.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<%
	'// 변수 선언 //
	Dim lp
	Dim atype



dim PageSize	: PageSize = getNumeric(requestCheckVar(request("psz"),9))
dim SortMet		: SortMet =  requestCheckVar(request("srm"),2)
dim searchFlag 	: searchFlag = "newitem"
dim CurrPage 	: CurrPage = getNumeric(requestCheckVar(request("cpg"),9))
dim catecode	: catecode = getNumeric(requestCheckVar(request("disp"),9))
dim icoSize		: icoSize = requestCheckVar(request("icoSize"),1)

if icoSize="" then icoSize="M"	'상품 아이콘 기본(중간)

dim imgSz	: imgSz = chkIIF(icoSize="M",180,150)

Dim cntless : cntless  = True

if SortMet="" then SortMet="be"		'정렬 기본값 : 인기순

dim ListDiv,ColsSize,ScrollCount
dim cdlNpage
ListDiv="newlist"
ColsSize =6
ScrollCount = 10

if CurrPage="" then CurrPage=1
if PageSize ="" then PageSize =100

dim oDoc,iLp
set oDoc = new SearchItemCls

oDoc.FListDiv 			= ListDiv
oDoc.FRectSortMethod	= SortMet
oDoc.FRectSearchFlag 	= searchFlag
oDoc.FPageSize 			= PageSize

oDoc.FCurrPage 			= CurrPage
oDoc.FSellScope			= "Y"
oDoc.FScrollCount 		= ScrollCount
oDoc.FRectSearchItemDiv ="D"
oDoc.FRectCateCode			= catecode

oDoc.getSearchList

'레코픽용
Dim oaward
set oaward = new CAWard
oaward.FPageSize = 30
oaward.FDisp1 = catecode

oaward.FRectAwardgubun = atype
oaward.GetNormalItemList
%>
<script type="text/javascript" src="/lib/js/jquery.numspinner.min.js"></script>
<script>
$(function() {
	// Item Image Control
	$(".pdtList li .pdtPhoto").mouseenter(function(e){
		$(this).find("dfn").fadeIn(150);
	}).mouseleave(function(e){
		$(this).find("dfn").fadeOut(150);
	});
});

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
						<li class="on"><a href="/award/bestaward_new.asp?disp=<%=catecode%>">신상품 베스트</a></li>
						<li><a href="/award/bestaward_price.asp?disp=<%=catecode%>">가격대별 베스트</a></li>
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
							<%=fnAwardBestCategoryLI(catecode,"/award/bestaward_new.asp?")%>
						</ul> 
					</div>
				</div>
			</div>
			<div class="hotSectionV15">
				<div class="hotArticleV15">
				<form name="sFrm" method="get" action="/shoppingtoday/shoppingchance_newitem.asp" style="margin:0px;">
				<input type="hidden" name="sflag" value="<%= oDoc.FRectSearchFlag  %>">
				<input type="hidden" name="srm" value="<%= oDoc.FRectSortMethod%>">
				<input type="hidden" name="cpg" value="<%=oDoc.FCurrPage %>">
				<input type="hidden" name="psz" value="<%= PageSize%>">
				<input type="hidden" name="chkr" value="<%= oDoc.FCheckResearch %>">
				<input type="hidden" name="disp" value="<%= oDoc.FRectCateCode %>">
				<input type="hidden" name="reset" value="">
					<div class="ctgyBestV15">
						<div class="pdtWrap pdt240V15">
							<ul class="pdtList">
						<%
						IF oDoc.FResultCount >0 then
						dim cdlNTotCnt, i, TotalCnt
						dim maxLoop	,intLoop

						TotalCnt = oDoc.FResultCount

						dim classStr, adultChkFlag, adultPopupLink, linkUrl

							For i=0 To TotalCnt-1
								IF (i <= TotalCnt-1) Then
									classStr = ""
									linkUrl = "/shopping/category_prd.asp?itemid="& oDoc.FItemList(i).FItemID
									adultChkFlag = false
									adultChkFlag = session("isAdult") <> true and oDoc.FItemList(i).FadultType = 1
									
									If oDoc.FItemList(i).GetLevelUpCount > "29" then
										classStr = addClassStr(classStr,"bestUpV15")															
									end if
									If oDoc.FItemList(i).isSoldOut=true then
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
										<% If oDoc.FItemList(i).IsDirectPurchase Then %>
											<i class="abroad-badge">해외직구</i>
										<% End If %>
										<div class="pdtPhoto">
										<% if adultChkFlag then %>									
										<div class="adult-hide">
											<p><span>19세 이상만</span> <span>구매 가능한 상품입니다</span></p>
										</div>
										<% end if %>																				
											<a href="javascript:TnGotoProduct('<%=oDoc.FItemList(i).FItemID %>')">
												<span class="soldOutMask"></span>
												<img src="<% = oDoc.FItemList(i).FImageBasic %>" alt="<% = oDoc.FItemList(i).FItemName %>" />
												<% if oDoc.FItemList(i).FAddimage<>"" then %><dfn><img src="<%=getThumbImgFromURL(oDoc.FItemList(i).FAddimage,240,240,"true","false")%>" alt="<%=Replace(oDoc.FItemList(i).FItemName,"""","")%>" /></dfn><% end if %>
											</a>
										</div>
										<div class="pdtInfo">
											<p class="pdtBrand tPad20"><a href="javascript:GoToBrandShop('<%=oDoc.FItemList(i).FMakerId %>')"><%= oDoc.FItemList(i).FBrandName %></a></p>
											<p class="pdtName tPad07"><a href="javascript:TnGotoProduct('<%=oDoc.FItemList(i).FItemID %>')"><%= oDoc.FItemList(i).FItemName %></a></p>
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
											 		IF oDoc.FItemList(i).isReipgoItem Then Response.Write "<img src='http://fiximage.10x10.co.kr/web2011/category/icon_re.gif' width='26' height='11' hspace='2' style='display:inline;'> "
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
							<%
									end if
								End If
							Next
						End if
						%>
							</ul>
						</div>
					</div>

					<div class="pdtWrap pdt150V15">
						<ul class="pdtList">
						<%
						IF oDoc.FResultCount >0 then
							For i=0 To TotalCnt-1
								IF (i <= TotalCnt-1) Then
									classStr = ""
									linkUrl = "/shopping/category_prd.asp?itemid="& oDoc.FItemList(i).FItemID
									adultChkFlag = false
									adultChkFlag = session("isAdult") <> true and oDoc.FItemList(i).FadultType = 1
									
									If oDoc.FItemList(i).GetLevelUpCount > "29" then
										classStr = addClassStr(classStr,"bestUpV15")															
									end if
									If oDoc.FItemList(i).isSoldOut=true then
										classStr = addClassStr(classStr,"soldOut")							
									end if				
									if adultChkFlag then
										classStr = addClassStr(classStr,"adult-item")								
									end if	
																	
									If i > 2 then %>
							<li class="<%=classStr%>" <%=chkIIF(adultChkFlag, "onclick=""confirmAdultAuth('"&linkUrl&"');""","")%> > 						
								<p class="ranking"><%= i+1 %>.</p>
								<div class="pdtBox">
									<% '// 해외직구배송작업추가(원승현) %>
									<% If oDoc.FItemList(i).IsDirectPurchase Then %>
										<i class="abroad-badge">해외직구</i>
									<% End If %>
									<div class="pdtPhoto">
										<% if adultChkFlag then %>									
										<div class="adult-hide">
											<p><span>19세 이상만</span> <span>구매 가능한 상품입니다</span></p>
										</div>
										<% end if %>																			
										<a href="javascript:TnGotoProduct('<%=oDoc.FItemList(i).FItemID %>')">
											<span class="soldOutMask"></span>
											<img src="<% = oDoc.FItemList(i).FImageIcon1 %>" alt="<% = oDoc.FItemList(i).FItemName %>" />
											<% if oDoc.FItemList(i).FAddimage<>"" then %><dfn><img src="<%=getThumbImgFromURL(oDoc.FItemList(i).FAddimage,imgSz,imgSz,"true","false")%>" alt="<%=Replace(oDoc.FItemList(i).FItemName,"""","")%>" /></dfn><% end if %>
										</a>
									</div>
									<div class="pdtInfo">
										<p class="pdtBrand tPad20"><a href="javascript:GoToBrandShop('<%=oDoc.FItemList(i).FMakerId %>')"><%= oDoc.FItemList(i).FBrandName %></a></p>
										<p class="pdtName tPad07"><a href="javascript:TnGotoProduct('<%=oDoc.FItemList(i).FItemID %>')"><%= oDoc.FItemList(i).FItemName %></a></p>
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
										 		IF oDoc.FItemList(i).isReipgoItem Then Response.Write "<img src='http://fiximage.10x10.co.kr/web2011/category/icon_re.gif' width='26' height='11' hspace='2' style='display:inline;'> "
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
							<%
									end if
								End If
							Next
						End if
						%>
						</ul>
					</div>

				</div>
			</div>
			<% If oaward.FResultCount > 0 Then ' 레코픽 추가(10/16) %>
			<script type="text/javascript">
				var vIId=<%=oaward.FItemList(0).FItemId%>, vDisp='';
			</script>
			<script type="text/javascript" src="./inc_happyTogether.js"></script>
			<div class="recopickPdt tMar80" id="lyrHPTgr"></div>
			<% End If ' 레코픽 추가(10/16) %>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<% set oaward = Nothing %>
<% set oDoc = Nothing %>
<!-- #include virtual="/lib/db/dbclose.asp" -->