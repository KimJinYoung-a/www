<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/item/itemInfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/classes/item/PlusSaleItemCls.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<%
	strPageTitle = "텐바이텐 10X10 : PLUS SALE"
	Dim cdl, cdm, cds, lp, ScrollCount, atype, vTmp, k, catecode
	dim oPlusSaleItem
	dim setCols, setRows, i, j

	catecode = requestCheckVar(Request("disp"),3)
	cdm = requestCheckVar(Request("cdm"),3)
	cds = requestCheckVar(Request("cds"),3)
	dim PageSize	: PageSize = requestCheckVar(request("psz"),9)
	dim SortMet		: SortMet = requestCheckVar(request("srm"),16)
	dim CurrPage 	: CurrPage = requestCheckVar(request("cpg"),9)
	ScrollCount = 10
	setCols = 3				'플러스할인 상품 1행 표시수

	if CurrPage="" then CurrPage=1
	if PageSize ="" then PageSize =16
	if SortMet = "" then SortMet = "ne"

	public function selectSoringName(v)
		select case v
			case "ne" : selectSoringName = "신상품순"
			case "bs" : selectSoringName = "판매량순"
			case "be" : selectSoringName = "인기상품순"
			case "hp" : selectSoringName = "높은가격순"
			case "lp" : selectSoringName = "낮은가격순"
			case "hs" : selectSoringName = "높은할인율순"
		end select									
	end function


	dim oDoc,iLp
	set oDoc = new scPlusSaleList
	oDoc.FRectSortMethod	= SortMet
	oDoc.FPageSize			= PageSize
	oDoc.Fcatecode			= catecode
	oDoc.FRectCdM			= cdM
	oDoc.FRectCdS			= cdS
	oDoc.FCurrPage			= CurrPage
	oDoc.FScrollCount		= ScrollCount

	oDoc.getPlussaleList
%>
<script type="text/javascript" src="/lib/js/jquery.numspinner.min.js"></script>
<script language="javascript">
<!--
function jsGoPage(iP){
	document.sFrm.cpg.value = iP;
	document.sFrm.submit();
}

function fnSearch(frmval){
	var frm = document.sFrm;
	frm.cpg.value = 1;
	frm.srm.value = frmval;
	frm.submit();
}
//-->
</script>
</head>
<body>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container skinV19">
		<div id="contentWrap">
			<div class="hotHgroupV19 bg-purple">
				<div class="tab-area">
					<ul>
						<li><a href="/shoppingtoday/shoppingchance_saleitem.asp">세일중인 상품</a></li>
						<li><a href="/clearancesale/">클리어런스</a></li>
						<li class="on"><a href="/shoppingtoday/shoppingchance_plussale.asp">플러스 아이템</a></li>
					</ul>
				</div>
				<h2>PLUS ITEM<p class="tit-sub">함께 구매하면 좋은 상품을 추천드려요!<br/>할인이 적용되거나 활용도 높은 상품들도 숨어있으니 놓치지 말고 확인해주세요</p></h2>
			</div>
			<div class="snb-bar">
				<div class="snbbar-inner">
					<div class="btn-ctgr"><span><%=fnSelectCategoryName(catecode)%></span></div>
					<div class="sortingV19">
						<div class="select-boxV19">
							<dl>
								<dt class=""><span><%=fnSelectSoringName(SortMet)%></span></dt>
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
							<%=fnAwardBestCategoryLI(catecode,"/shoppingtoday/shoppingchance_plussale.asp?")%>
						</ul>
					</div>
				</div>
			</div>
			<div class="hotSectionV15 hotPlusSaleV15">
				<div class="hotArticleV15">
				<form name="sFrm" method="get" action="shoppingchance_plussale.asp">
					<input type="hidden" name="disp" value="<%= oDoc.Fcatecode %>">
					<input type="hidden" name="cdm" value="<%= oDoc.FRectCdM %>">
					<input type="hidden" name="cds" value="<%= oDoc.FRectCdS %>">
					<input type="hidden" name="srm" value="<%= oDoc.FRectSortMethod%>">
					<input type="hidden" name="cpg" value="<%=oDoc.FCurrPage %>">
					<input type="hidden" name="psz" value="<%= PageSize%>">
					<input type="hidden" name="reset" value="">
				</form>
					<div class="pdtWrap pdt240V15">
						<ul class="pdtList">
							<%
							If oDoc.FResultCount > 0 Then
	
								For iLp=0 To oDoc.FResultCount-1
							%>
							<li <% IF oDoc.FItemList(iLp).isSoldOut Then response.write "class='soldOut'" %>>
								<div class="pdtBox">
									<div class="pdtPhoto">
										<a href="javascript:TnGotoProduct('<%=oDoc.FItemList(iLp).FItemID %>')""><span class="soldOutMask"></span><img src="<%=oDoc.FItemList(iLp).FImageicon1%>" width="240" height="240" alt="<%=oDoc.FItemList(iLp).FItemName%>" /></a>
									</div>
									<div class="pdtInfo">
										<p class="pdtBrand tPad20"><a href="javascript:GoToBrandShop('<%=oDoc.FItemList(iLp).FMakerId %>')"><%=oDoc.FItemList(iLp).FBrandName%></a></p>
										<p class="pdtName tPad07"><a href="javascript:TnGotoProduct('<%=oDoc.FItemList(iLp).FItemID %>')"><%=oDoc.FItemList(iLp).FItemName%></a></p>
										<%
											If oDoc.FItemList(iLp).IsSaleItem or oDoc.FItemList(iLp).isCouponItem Then
												'If oDoc.FItemList(i).Fitemcoupontype <> "3" Then
												'	Response.Write "<p class='pdtPrice'><span class='txtML'>" & FormatNumber(oDoc.FItemList(i).FOrgPrice,0) & "원 </span></p>"
												'End If
												IF oDoc.FItemList(iLp).IsSaleItem Then
													Response.Write "<p class='pdtPrice'><span class='txtML'>" & FormatNumber(oDoc.FItemList(iLp).FOrgPrice,0) & "원 </span></p>"
													Response.Write "<p class='pdtPrice'><span class='finalP'>" & FormatNumber(oDoc.FItemList(iLp).getRealPrice,0) & "원 </span>"
													Response.Write "<strong class='cRd0V15'>[" & oDoc.FItemList(iLp).getSalePro & "]</strong></p>"
										 		End IF
										 		IF oDoc.FItemList(iLp).IsCouponItem Then
										 			if Not(oDoc.FItemList(iLp).IsFreeBeasongCoupon() or oDoc.FItemList(iLp).IsSaleItem) Then
										 				Response.Write "<p class='pdtPrice'><span class='txtML'>" & FormatNumber(oDoc.FItemList(iLp).FOrgPrice,0) & "원 </span></p>"
										 			end if
													Response.Write "<p class='pdtPrice'><span class='finalP'>" & FormatNumber(oDoc.FItemList(iLp).GetCouponAssignPrice,0) & "원 </span>"
													Response.Write "<strong class='cGr0V15'>[" & oDoc.FItemList(iLp).GetCouponDiscountStr & "]</strong></p>"
										 		End IF
											Else
												Response.Write "<p class='pdtPrice'><span class='finalP'>" & FormatNumber(oDoc.FItemList(iLp).getRealPrice,0) & "원 </span>"
											End If
										%>
										<p class="pdtStTag tPad10">
										<%
									 		IF oDoc.FItemList(iLp).isTenOnlyItem Then Response.Write "<img src='http://fiximage.10x10.co.kr/web2013/shopping/tag_only.gif' alt='ONLY' /> "
									 		IF oDoc.FItemList(iLp).isSaleItem Then Response.Write "<img src='http://fiximage.10x10.co.kr/web2013/shopping/tag_sale.gif' alt='SALE' /> "
									 		IF oDoc.FItemList(iLp).isCouponItem Then Response.Write "<img src='http://fiximage.10x10.co.kr/web2013/shopping/tag_coupon.gif' alt='쿠폰' /> "
									 		IF oDoc.FItemList(iLp).isLimitItem Then Response.Write "<img src='http://fiximage.10x10.co.kr/web2013/shopping/tag_limited.gif' alt='한정' /> "
									 		IF oDoc.FItemList(iLp).isNewItem Then Response.Write "<img src='http://fiximage.10x10.co.kr/web2013/shopping/tag_new.gif' alt='NEW' /> "
									 		IF oDoc.FItemList(iLp).isReipgoItem Then Response.Write "<img src='http://fiximage.10x10.co.kr/web2011/category/icon_re.gif' width='26' height='11' hspace='2' style='display:inline;'> "
										%>
										</p>
									</div>
									<ul class="pdtActionV15">
										<li class="largeView"><a href="" onclick="ZoomItemInfo('<%=oDoc.FItemList(iLp).FItemid %>'); return false;"><img src="http://fiximage.10x10.co.kr/web2015/common/btn_quick.png" alt="QUICK" /></a></li>
										<li class="postView"><a href="" onclick="popEvaluate('<%=oDoc.FItemList(iLp).FItemid %>'); return false;"><span><%= oDoc.FItemList(iLp).Freviewcnt %></span></a></li>
										<li class="wishView"><a href="" onclick="TnAddFavorite('<%= oDoc.FItemList(iLp).FItemID %>'); return false;"><span><%= oDoc.FItemList(iLp).FFavCount %></span></a></li>
									</ul>
								</div>
								<div class="pdtPlus">
								<%
									'메인관련 할인 상품 목록 접수/출력
									set oPlusSaleItem = new CSetSaleItem
									oPlusSaleItem.FRectItemID = oDoc.FItemList(iLp).FItemID
								    oPlusSaleItem.GetLinkSetSaleItemList

								    vTmp = oPlusSaleItem.FResultCount-1
								    If vTmp > 2 Then
								    	vTmp = 2
									End IF

									For i=0 To vTmp
										Response.Write "<a href='" & wwwurl & "/shopping/category_prd.asp?itemid=" & oPlusSaleItem.FItemList(i).Fitemid & "')'><img src='" & oPlusSaleItem.FItemList(i).FImageSmall & "' alt='"&oPlusSaleItem.FItemList(i).FItemName &"' />"
										Response.write "<strong>" & chkIIF(oPlusSaleItem.FItemList(i).FPLusSalePro>0,oPlusSaleItem.FItemList(i).FPLusSalePro& "%","&nbsp;") & "</strong></a>"
									Next

									set oPlusSaleItem = Nothing
								%>
								</div>
							</li>
								<%
									If ((iLp+1) mod 4 = 0) AND iLp <> oDoc.FResultCount-1 Then
										Response.write "</ul></div><div class='pdtWrap pdt240V15'><ul class='pdtList'>"
									End if
								Next
									Response.Write "</ul></div>"
							Else
							End if
								%>
					<div class="pageWrapV15 tMar20">
						<%= fnDisplayPaging_New(CurrPage,oDoc.FTotalCount,PageSize,10,"jsGoPage") %>
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