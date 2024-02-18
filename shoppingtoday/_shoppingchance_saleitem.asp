<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/item/itemInfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/classes/search/searchCls.asp" -->
<!-- #include virtual="/lib/classes/enjoy/shoppingchanceCls_B.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<%
	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : NOW ON SALE"

	'// 모달창이 필요한경우 아래 변수에 내용을 넣어주세요.
	strModalCont = "<div id='itemLyr' class='window loginLyr'>" &_
					"<div style='background:#fff; width:500px; height:400px'>모달 내용</div>" &_
					"	<p class='lyrClose'>close</p>" &_
					"</div>"

	'// 팝업창(레이어)이 필요한 경우 아래 변수에 내용을 넣어주세요.
	strPopupCont = "<div id='popLyr' class='window certLyr'></div>"

Dim catecode, lp,sPercent, flo1, flo2
catecode = getNumeric(requestCheckVar(Request("disp"),3))
sPercent =	getNumeric(requestCheckVar(Request("sp"),2))
flo1 =	requestCheckVar(Request("flo1"),5) '// 무료배송
flo2 =	requestCheckVar(Request("flo2"),5) '// 한정판매
dim PageSize	: PageSize = getNumeric(requestCheckVar(request("psz"),9))
dim SortMet		: SortMet = requestCheckVar(request("srm"),2)
dim searchFlag 	: searchFlag = "sale"
dim CurrPage 	: CurrPage = getNumeric(requestCheckVar(request("cpg"),9))
dim icoSize		: icoSize = requestCheckVar(request("icoSize"),1)

if icoSize="" then icoSize="M"	'상품 아이콘 기본(중간)

dim ListDiv,ColsSize,ScrollCount
dim cdlNpage
ListDiv="salelist"
ColsSize =6
ScrollCount = 10

'추가 이미지 사이즈
dim imgSz	: imgSz = chkIIF(icoSize="M",180,150)

if SortMet="" then SortMet="be"
if CurrPage="" then CurrPage=1
if PageSize ="" then PageSize =32

if (PageSize>"96") then PageSize=96 ''2016/09/09
'rw sPercent & "!"
dim oDoc,iLp
set oDoc = new SearchItemCls

oDoc.FListDiv 			= ListDiv
oDoc.FRectSortMethod	= SortMet
oDoc.FRectSearchFlag 	= searchFlag
oDoc.FPageSize 			= PageSize
oDoc.FRectCateCode		= catecode
oDoc.FisFreeBeasong		= flo1	'// 무료배송
oDoc.FisLimit			= flo2	'// 한정판매
'oDoc.FisTenOnly			= flo

oDoc.FCurrPage 			= CurrPage
oDoc.FSellScope 		= "Y"
oDoc.FScrollCount 		= ScrollCount

'할인률 적용
Select Case sPercent
	Case "99"
		oDoc.FSalePercentLow = "0"
		oDoc.FSalePercentHigh = "0.3"
	Case "70"
		oDoc.FSalePercentLow = "0.3"
		oDoc.FSalePercentHigh = "0.5"
	Case "50"
		oDoc.FSalePercentLow = "0.5"
		oDoc.FSalePercentHigh = "0.8"
	Case "20"
		oDoc.FSalePercentLow = "0.8"
		oDoc.FSalePercentHigh = "1"
end Select

oDoc.getSearchList

'If cdm = "" Then
'	cdm = "01"
'End IF
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

function jsGoUrl(sP, catecode, flo1, flo2){
      location.href = "/shoppingtoday/shoppingchance_saleitem.asp?disp="+catecode+"&sP="+sP+"&flo1="+flo1+"&flo2="+flo2;
}

//무배
function chkfree(flo1,flo2){
	if(document.sFrm.chksearchfree.checked==true){
		location.href = "/shoppingtoday/shoppingchance_saleitem.asp?disp=<%=catecode%>&sP=<%=sPercent%>&flo1="+flo1+"&flo2="+flo2;
	}
	if(document.sFrm.chksearchfree.checked==false){
		location.href = "/shoppingtoday/shoppingchance_saleitem.asp?disp=<%=catecode%>&sP=<%=sPercent%>&flo1=&flo2="+flo2;
	}
}

//한정
function chklimit(flo1,flo2){
	if(document.sFrm.chksearchlimit.checked==true){
		location.href = "/shoppingtoday/shoppingchance_saleitem.asp?disp=<%=catecode%>&sP=<%=sPercent%>&flo1="+flo1+"&flo2="+flo2;
	}
	if(document.sFrm.chksearchlimit.checked==false){
		location.href = "/shoppingtoday/shoppingchance_saleitem.asp?disp=<%=catecode%>&sP=<%=sPercent%>&flo1="+flo1+"&flo2=";
	}
}
</script>
</head>
<body>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container">
		<div id="contentWrap">
			<div class="hotHgroupV15">
				<h2><img src="http://fiximage.10x10.co.kr/web2015/shopping/tit_now_on_salel.png" alt="NOW ON SALE" /></h2>
				<div class="btnLink"><a href="/shoppingtoday/shoppingchance_plussale.asp"><img src="http://fiximage.10x10.co.kr/web2017/shopping/btn_plus_item.png" alt="PLUS ITEM" /></a></div>
				<div class="btnLink goClear"><a href="/clearancesale/"><img src="http://fiximage.10x10.co.kr/web2015/shopping/btn_clearance.png" alt="CLEARANCE SALE" /></a></div>
			</div>
			<div class="hotSectionV15 hotSaleV15">
				<div class="deco"></div>
				<div class="lnbHotV15">
					<div class="all"><strong>전체 카테고리</strong></div>
					<ul>
						<li><a href="?disp=&sP=<%=sPercent%>&flo1=<%=flo1%>&flo2=<%=flo2%>" class="<%= chkIIF(catecode="","on","") %>">전체</a></li>
						<%=fnAwardBestCategoryLI(catecode,"/shoppingtoday/shoppingchance_saleitem.asp?sP="&sPercent&"&flo1="&flo1&"&flo2="&flo2&"&")%>
					</ul>
				</div>

				<div class="hotArticleV15">
					<div class="grpSubWrapV15">
						<ul>
							<li class="nav1"><a href="javascript:jsGoUrl('','<%=catecode%>','<%=flo1%>','<%=flo2%>');" class="<%=CHKIIF(sPercent="","on","")%>"><span></span>ALL</a></li>
							<li class="nav2"><a href="javascript:jsGoUrl('99','<%=catecode%>','<%=flo1%>','<%=flo2%>');" class="<%=CHKIIF(sPercent="99","on","")%>"><span></span>70% ~</a></li>
							<li class="nav3"><a href="javascript:jsGoUrl('70','<%=catecode%>','<%=flo1%>','<%=flo2%>');" class="<%=CHKIIF(sPercent="70","on","")%>"><span></span>70% ~ 50%</a></li>
							<li class="nav4"><a href="javascript:jsGoUrl('50','<%=catecode%>','<%=flo1%>','<%=flo2%>');" class="<%=CHKIIF(sPercent="50","on","")%>"><span></span>50% ~ 20%</a></li>
							<li class="nav5"><a href="javascript:jsGoUrl('20','<%=catecode%>','<%=flo1%>','<%=flo2%>');" class="<%=CHKIIF(sPercent="20","on","")%>"><span></span>~ 20%</a></li>
						</ul>
					</div>
				<form name="sFrm" method="get" action="/shoppingtoday/shoppingchance_saleitem.asp" style="margin:0px;">
				<input type="hidden" name="sflag" value="<%= oDoc.FRectSearchFlag  %>">
				<input type="hidden" name="disp" value="<%= oDoc.FRectcatecode %>">
				<input type="hidden" name="srm" value="<%= oDoc.FRectSortMethod%>">
				<input type="hidden" name="cpg" value="<%=oDoc.FCurrPage %>">
				<input type="hidden" name="psz" value="<%= PageSize%>">
				<input type="hidden" name="chkr" value="<%= oDoc.FCheckResearch %>">
				<input type="hidden" name="sP" value="<%=sPercent%>">
				<input type="hidden" name="flo1" value="<%=flo1%>">
				<input type="hidden" name="flo2" value="<%=flo2%>">
				<input type="hidden" name="reset" value="">
					<div class="sortingV15">
						<span class="blt"></span>
						<span class="total">total <strong><%= oDoc.FTotalCount %></strong></span>
						<div class="option">
							<span class="choice">
								<input type="checkbox" id="checkFree" name="chksearchfree" onclick="chkfree('free','<%= flo2 %>');" <% if flo1 = "free" then response.write "checked" %> /> <label for="checkFree"><img src="http://fiximage.10x10.co.kr/web2015/shopping/txt_label_free_deliery.png" alt="무료배송" /></label>
								<input type="checkbox" id="checkLimited" name="chksearchlimit" onclick="chklimit('<%= flo1 %>','limit');" <% if flo2 = "limit" then response.write "checked" %> /> <label for="checkLimited"><img src="http://fiximage.10x10.co.kr/web2015/shopping/txt_label_limited.png" alt="한정판매" /></label>
							</span>
							<select name="ttsrtm" class="optSelect" onchange="fnSearch(this.form.srm,this.value);" title="상품 정렬 방법 선택">
								<option value="ne" <% if SortMet="ne" then response.write "selected" %>>신상품순</option>
								<option value="be" <% if SortMet="be" then response.write "selected" %>>인기상품순</option>
								<option value="hp" <% if SortMet="hp" then response.write "selected" %>>높은가격순</option>
								<option value="lp" <% if SortMet="lp" then response.write "selected" %>>낮은가격순</option>
								<option value="hs" <% if SortMet="hs" then response.write "selected" %>>높은할인율순</option>
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
							<% If oDoc.FItemList(i).FItemDiv="21" Then %>
							<li class="deal-item">
							<% Else %>
							<li<%=chkIIF(oDoc.FItemList(i).isSoldOut," class=""soldOut""","")%>>
							<% End If %>
							<% If oDoc.FItemList(i).FItemDiv="21" Then %>
								<div class="pdtBox">
									<i class="dealBadge">텐텐<br /><strong>DEAL</strong></i>
									<div class="pdtPhoto">
										<a href="/deal/deal.asp?itemid=<%=oDoc.FItemList(i).FItemID %>&gaparam=nowonsale_<%=CHKIIF(sPercent<>"",sPercent,"all")%>_<%=i+1%>">
											<span class="soldOutMask"></span>
											<img src="<% = oDoc.FItemList(i).FImageIcon1 %>" width="180" height="180" alt="<% = oDoc.FItemList(i).FItemName %>" />
											<% if oDoc.FItemList(i).FAddimage<>"" then %><dfn><img src="<%=getThumbImgFromURL(oDoc.FItemList(i).FAddimage,imgSz,imgSz,"true","false")%>" alt="<%=Replace(oDoc.FItemList(i).FItemName,"""","")%>" /></dfn><% end if %>
										</a>
									</div>
									<div class="pdtInfo">
										<p class="pdtBrand tPad20"><a href="/street/street_brand.asp?makerid=<%= oDoc.FItemList(i).FMakerid %>"><% = oDoc.FItemList(i).FBrandName %></a></p>
										<p class="pdtName tPad07"><a href="/deal/deal.asp?itemid=<%= oDoc.FItemList(i).FItemID %>&disp=<%=getArrayDispCate(dispCate,oDoc.FItemList(i).FarrCateCd)%><%=logparam%>"><% = oDoc.FItemList(i).FItemName %></a></p>
										<% IF oDoc.FItemList(i).FItemOptionCnt="" Or oDoc.FItemList(i).FItemOptionCnt="0" then %>
										<p class="pdtPrice"><span class="finalP"><%=FormatNumber(oDoc.FItemList(i).getRealPrice,0)%>원<% If oDoc.FItemList(i).FtenOnlyYn="Y" Then %>~<% End If %></span></p>
										<% Else %>
										<p class="pdtPrice"><span class="finalP"><%=FormatNumber(oDoc.FItemList(i).getRealPrice,0)%>원<% If oDoc.FItemList(i).FtenOnlyYn="Y" Then %>~<% End If %></span> <strong class="cRd0V15">[<% If oDoc.FItemList(i).FLimityn="Y" Then %>~<% End If %><%=oDoc.FItemList(i).FItemOptionCnt%>%]</strong></p>
										<% End If %>
										<p class="pdtStTag tPad10">
										<% IF oDoc.FItemList(i).isSoldOut Then %>
											<img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" />
										<% Else %>
											<% IF oDoc.FItemList(i).isTempSoldOut Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" /> <% end if %>
											<% IF Not(isNull(oDoc.FItemList(i).FItemOptionCnt) or trim(oDoc.FItemList(i).FItemOptionCnt)="") Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_sale.gif" alt="SALE" /> <% end if %>
											<% IF oDoc.FItemList(i).isCouponItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_coupon.gif" alt="쿠폰" /> <% end if %>
											<% IF oDoc.FItemList(i).isNewItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_new.gif" alt="NEW" /> <% end if %>
										<% End If %>
										</p>
									</div>
								</div>
							<% Else %>
								<div class="pdtBox">
									<div class="pdtPhoto">
										<a href="/shopping/category_prd.asp?itemid=<%=oDoc.FItemList(i).FItemID %>&gaparam=nowonsale_<%=CHKIIF(sPercent<>"",sPercent,"all")%>_<%=i+1%>">
											<span class="soldOutMask"></span>
											<img src="<% = oDoc.FItemList(i).FImageIcon1 %>" width="180" height="180" alt="<% = oDoc.FItemList(i).FItemName %>" />
											<% if oDoc.FItemList(i).FAddimage<>"" then %><dfn><img src="<%=getThumbImgFromURL(oDoc.FItemList(i).FAddimage,imgSz,imgSz,"true","false")%>" alt="<%=Replace(oDoc.FItemList(i).FItemName,"""","")%>" /></dfn><% end if %>
										</a>
									</div>
									<div class="pdtInfo">
										<p class="pdtBrand tPad20"><a href="javascript:GoToBrandShop('<%=oDoc.FItemList(i).FMakerId %>')"><% = oDoc.FItemList(i).FBrandName %></a></p>
										<p class="pdtName tPad07"><a href="/shopping/category_prd.asp?itemid=<%=oDoc.FItemList(i).FItemID %>&gaparam=nowonsale_<%=CHKIIF(sPercent<>"",sPercent,"all")%>_<%=i+1%>"><% = oDoc.FItemList(i).FItemName %></a></p>
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
							<% End If %>
							<% End IF %>
							<% Next %>
						</ul>
					</div>
					<div class="pageWrapV15 tMar20">
							<%= fnDisplayPaging_New(CurrPage,oDoc.FTotalCount,PageSize,10,"TnMovePage") %>
					</div>
					<% Else %>
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
<!-- #include virtual="/lib/db/dbclose.asp" -->