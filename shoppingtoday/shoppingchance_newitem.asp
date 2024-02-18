<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/shoppingchanceCls_B.asp" -->
<!-- #include virtual="/lib/classes/item/itemInfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/classes/search/searchCls.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<%
	'// 변수 선언 //
	Dim lp

dim PageSize	: PageSize = getNumeric(requestCheckVar(request("psz"),9))
dim SortMet		: SortMet =  requestCheckVar(request("srm"),2)
dim searchFlag 	: searchFlag = "newitem"
dim CurrPage 	: CurrPage = getNumeric(requestCheckVar(request("cpg"),9))
dim catecode	: catecode = getNumeric(requestCheckVar(request("disp"),9))
dim icoSize		: icoSize = requestCheckVar(request("icoSize"),1)

if icoSize="" then icoSize="M"	'상품 아이콘 기본(중간)
if SortMet="" then SortMet="ne"		'정렬 기본값 : 인기순

'추가 이미지 사이즈
dim imgSz	: imgSz = chkIIF(icoSize="M",240,180)

dim ListDiv,ColsSize,ScrollCount
dim cdlNpage
ListDiv="newlist"
ColsSize =6
ScrollCount = 10

if CurrPage="" then CurrPage=1
if PageSize ="" then PageSize =48

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
%>

<script type="text/javascript" src="/lib/js/jquery.numspinner.min.js"></script>
<script language="javascript">
$(function() {
	// Item Image Control
	$(".pdtList li .pdtPhoto").mouseenter(function(e){
		$(this).find("dfn").fadeIn(150);
	}).mouseleave(function(e){
		$(this).find("dfn").fadeOut(150);
	});
	$(".pdtList p").click(function(e){
		e.stopPropagation();				
	});
});

function fnSearch(frmval){
	var frm = document.sFrm;
	frm.cpg.value = 1;
	frm.srm.value = frmval;
	frm.submit();
}
function TnMovePage(pg){
	document.sFrm.cpg.value=pg;
	document.sFrm.submit();
}

function jsGoUrl(catecode){
	location.href = "/shoppingtoday/shoppingchance_newitem.asp?disp="+catecode;
}

</script>

</head>
<body>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container skinV19">
		<div id="contentWrap">
			<div class="hotHgroupV19 va-md">
				<h2>NEW ARRIVAL</h2>
			</div>
			<div class="snb-bar">
				<div class="snbbar-inner">
					<div class="btn-ctgr"><span><%=fnSelectCategoryName(catecode)%></span></div>
					<div class="sortingV19">
						<div class="select-boxV19">
							<dl>
								<dt class=""><span><%=fnselectSoringName(SortMet)%></span></dt>
								<dd style="display: none;">
									<ul>
										<li onclick="fnSearch('ne')">신상품순</li>
										<li onclick="fnSearch('bs')">판매량순</li>
										<li onclick="fnSearch('be')">인기상품순</li>
										<li onclick="fnSearch('hp')">높은가격순</li>
										<li onclick="fnSearch('lp')">낮은가격순</li>
										<li onclick="fnSearch('hs')">높은할인율순</li>
									</ul>
								</dd>
							</dl>
						</div>
					</div>
				</div>
				<div class="lnbHotV19">
					<div class="inner">
						<ul>
							<li class="<%= chkIIF(catecode="","on","") %>"><a href="?disp=">전체 카테고리</a></li>
							<%=fnAwardBestCategoryLI(catecode,"/shoppingtoday/shoppingchance_newitem.asp?")%>
						</ul>
					</div>
				</div>
			</div>
			<div class="hotSectionV15 hotNewV15">
				<div class="hotArticleV15">
					<form name="sFrm" method="get" action="/shoppingtoday/shoppingchance_newitem.asp" style="margin:0px;">
					<input type="hidden" name="sflag" value="<%= oDoc.FRectSearchFlag  %>">
					<input type="hidden" name="srm" value="<%= oDoc.FRectSortMethod%>">
					<input type="hidden" name="cpg" value="<%=oDoc.FCurrPage %>">
					<input type="hidden" name="psz" value="<%= PageSize%>">
					<input type="hidden" name="chkr" value="<%= oDoc.FCheckResearch %>">
					<input type="hidden" name="disp" value="<%= oDoc.FRectCateCode %>">
					<input type="hidden" name="reset" value="">
					<div class="pdtWrap pdt240V15 row_4th">
						<ul class="pdtList">
						<%
						IF oDoc.FResultCount >0 then
						dim cdlNTotCnt, i, TotalCnt
						dim maxLoop	,intLoop

						TotalCnt = oDoc.FResultCount
						dim classStr, adultChkFlag, adultPopupLink, linkUrl
							For i=0 To TotalCnt-1
								classStr = ""
								linkUrl = "/shopping/category_prd.asp?itemid="& oDoc.FItemList(i).FItemID &"&gaparam=newarrival_"&SortMet&"_"&i+1										  
								adultChkFlag = false
								adultChkFlag = session("isAdult") <> true and oDoc.FItemList(i).FadultType = 1

								If oDoc.FItemList(i).FItemDiv="21" then
									classStr = addClassStr(classStr,"deal-item")							
								end if
								If oDoc.FItemList(i).isSoldOut=true then
									classStr = addClassStr(classStr,"soldOut")							
								end if				
								if adultChkFlag then
									classStr = addClassStr(classStr,"adult-item")								
								end if																		
						%>
							<% IF (i <= TotalCnt-1) Then %>
							<li class="<%=classStr%>" <%=chkIIF(adultChkFlag, "onclick=""confirmAdultAuth('"&linkUrl&"');""","")%> > 						
								<% If oDoc.FItemList(i).FItemDiv="21" Then %>
								<div class="pdtBox">
									<i class="dealBadge">텐텐<br /><strong>DEAL</strong></i>
									<% If oDoc.FItemList(i).Frecentsellcount >= 30 then %>
										<strong class="pdtLabel"><img src="http://fiximage.10x10.co.kr/web2015/common/ico_label_rookie.png" alt="ROOKIE 상품" /></strong>
									<% End if %>
									<div class="pdtPhoto">
									<% if adultChkFlag then %>									
									<div class="adult-hide">
										<p><span>19세 이상만</span> <span>구매 가능한 상품입니다</span></p>
									</div>
									<% end if %>									
										<a href="/deal/deal.asp?itemid=<%=oDoc.FItemList(i).FItemID %>&gaparam=newarrival_<%=SortMet%>_<%=i+1%>">
											<span class="soldOutMask"></span>
											<img src="<%= getThumbImgFromURL(oDoc.FItemList(i).FImageBasic,imgSz,imgSz,"true","false") %>" width="240" height="240" alt="<% = oDoc.FItemList(i).FItemName %>" />
											<% if oDoc.FItemList(i).FAddimage<>"" then %><dfn><img src="<%=getThumbImgFromURL(oDoc.FItemList(i).FAddimage,imgSz,imgSz,"true","false")%>" alt="<%=Replace(oDoc.FItemList(i).FItemName,"""","")%>" /></dfn><% end if %>
										</a>
									</div>
									<div class="pdtInfo">
										<p class="pdtBrand tPad20"><a href="javascript:GoToBrandShop('<%=oDoc.FItemList(i).FMakerId %>')"><% = oDoc.FItemList(i).FBrandName %></a></p>
										<p class="pdtName tPad07"><a href="/deal/deal.asp?itemid=<%=oDoc.FItemList(i).FItemID %>&gaparam=newarrival_<%=SortMet%>_<%=i+1%>"><% = oDoc.FItemList(i).FItemName %></a></p>
										<% IF oDoc.FItemList(i).FItemOptionCnt="" Or oDoc.FItemList(i).FItemOptionCnt="0" then %>
										<p class="pdtPrice"><span class="finalP"><%=FormatNumber(oDoc.FItemList(i).getRealPrice,0)%>원<% If oDoc.FItemList(i).FtenOnlyYn="Y" Then %>~<% End If %></span></p>
										<% Else %>
										<p class="pdtPrice"><span class="finalP"><%=FormatNumber(oDoc.FItemList(i).getRealPrice,0)%>원<% If oDoc.FItemList(i).FtenOnlyYn="Y" Then %>~<% End If %></span> <strong class="cRd0V15">[<% If oDoc.FItemList(i).FLimityn="Y" Then %>~<% End If %><%=oDoc.FItemList(i).FItemOptionCnt%>%]</strong></p>
										<% End If %>
										<p class="pdtStTag tPad10">
										<% IF oDoc.FItemList(i).isSoldOut Then %>
											<img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" />
										<% else %>
											<% IF oDoc.FItemList(i).isTempSoldOut Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" /> <% end if %>
											<% IF oDoc.FItemList(i).FLimityn="Y" Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_sale.gif" alt="SALE" /> <% end if %>
											<% IF oDoc.FItemList(i).isCouponItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_coupon.gif" alt="쿠폰" /> <% end if %>
											<% IF oDoc.FItemList(i).isNewItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_new.gif" alt="NEW" /> <% end if %>
										<% end if %>
										</p>
									</div>
								</div>
								<% Else %>
								<div class="pdtBox">
									<% '// 해외직구배송작업추가(원승현) %>
									<% If oDoc.FItemList(i).IsDirectPurchase Then %>
										<i class="abroad-badge">해외직구</i>
									<% End If %>
									<% If oDoc.FItemList(i).Frecentsellcount >= 30 then %>
										<strong class="pdtLabel"><img src="http://fiximage.10x10.co.kr/web2015/common/ico_label_rookie.png" alt="ROOKIE 상품" /></strong>
									<% End if %>
									<div class="pdtPhoto">
									<% if adultChkFlag then %>									
									<div class="adult-hide">
										<p><span>19세 이상만</span> <span>구매 가능한 상품입니다</span></p>
									</div>
									<% end if %>									
										<a href="/shopping/category_prd.asp?itemid=<%=oDoc.FItemList(i).FItemID %>&gaparam=newarrival_<%=SortMet%>_<%=i+1%>">
											<span class="soldOutMask"></span>
											<img src="<%= getThumbImgFromURL(oDoc.FItemList(i).FImageBasic,imgSz,imgSz,"true","false") %>" width="240" height="240" alt="<% = oDoc.FItemList(i).FItemName %>" />
											<% if oDoc.FItemList(i).FAddimage<>"" then %><dfn><img src="<%=getThumbImgFromURL(oDoc.FItemList(i).FAddimage,imgSz,imgSz,"true","false")%>" alt="<%=Replace(oDoc.FItemList(i).FItemName,"""","")%>" /></dfn><% end if %>
										</a>
									</div>
									<div class="pdtInfo">
										<p class="pdtBrand tPad20"><a href="javascript:GoToBrandShop('<%=oDoc.FItemList(i).FMakerId %>')"><% = oDoc.FItemList(i).FBrandName %></a></p>
										<p class="pdtName tPad07"><a href="/shopping/category_prd.asp?itemid=<%=oDoc.FItemList(i).FItemID %>&gaparam=newarrival_<%=SortMet%>_<%=i+1%>"><% = oDoc.FItemList(i).FItemName %></a></p>
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
								<% End IF %>
							</li>
							<% Else %>
								<td width="150" align="center" valign="top"></td>
							<% End IF %>
						<%
							Next
						End If
						%>
						</ul>
					</div>

					<div class="pageWrapV15 tMar20">
							<%= fnDisplayPaging_New(CurrPage,oDoc.FTotalCount,PageSize,10,"TnMovePage") %>
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