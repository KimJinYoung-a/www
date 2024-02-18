<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'#############################################################
'	Description : 클리어런스 세일 W
'	History		: 2016.01.18 유태욱 생성
'#############################################################
%>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/classes/item/iteminfoCls.asp" -->
<!-- #include virtual="/lib/classes/clearancesale/clearancesaleCls.asp"-->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<%
''dim soldoutyn	''품절상품 포함,제외
dim i
dim flo1, flo2, flo3
dim catecode, SortMet
dim PageSize, CurrPage
dim Price, minPrice, maxPrice
dim classStr, adultChkFlag, adultPopupLink, linkUrl

	flo1 =	requestCheckVar(Request("flo1"),4) '// 무료배송
	flo2 =	requestCheckVar(Request("flo2"),6) '// 텐바이텐 배송
	flo3 =	requestCheckVar(Request("flo3"),8) '// 포장상품여부
	SortMet = requestCheckVar(request("srm"),2)
	price =	requestCheckVar(Request("price"),3)
'	soldoutyn=requestcheckvar(request("soldoutyn"),1)
	catecode = getNumeric(requestCheckVar(Request("disp"),3))
	PageSize = getNumeric(requestCheckVar(request("psz"),9))
	CurrPage = getNumeric(requestCheckVar(request("cpg"),9))

if CurrPage="" then CurrPage=1
if PageSize ="" then PageSize =32

if SortMet="" then SortMet="be"		''기본 인기순 정렬
if price = "" then price = "all"	''가격대별 정렬
'if soldoutyn="" then soldoutyn="Y"	''품절상품 포함여부

'가격대별
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

''실시간 급상승( top 5 )
dim obestitem
set obestitem = new CClearancesalelist
	obestitem.fnGetbestitem

''매진임박상품(30개이하) asc top 4
dim oLimitedLowStock
set oLimitedLowStock = new CClearancesalelist
	oLimitedLowStock.fnGetLimitedLowStock

''방금 판매된 상품
dim oNewsellitem
set oNewsellitem = new CClearancesalelist
	oNewsellitem.fnGetNewsellitem

''클리어런스 상품 리스트
dim oclearancelist
set oclearancelist = new CClearancesalelist
	oclearancelist.FPageSize = PageSize
	oclearancelist.FCurrPage = CurrPage
	oclearancelist.FdeliType1 = flo1
	oclearancelist.FdeliType2 = flo2
	oclearancelist.Fpojangok  = flo3
	oclearancelist.FRectSortMethod=SortMet	''정렬기준
	oclearancelist.FminPrice = minPrice	''최소금액
	oclearancelist.FmaxPrice = maxPrice	''최대금액
'	oclearancelist.frectsoldoutyn=soldoutyn	''품절상품 제거,포함
	oclearancelist.FRectCateCode = catecode	''카테고리
	oclearancelist.fnGetClearancesaleList
%>

<!-- #include virtual="/lib/inc/head.asp" -->
<script type="text/javascript">
$(function() {
	<% if Request("srm") <> "" or Request("price") <> "" or Request("disp") <> "" then %>
		//window.parent.$('html,body').animate({scrollTop:$("#clearanceList").offset().top}, 0);
	<% end if %>
	$(".pdtList p").click(function(e){
		e.stopPropagation();				
	});				

	if ($('.clearSlideV15 .itemCont').length > 1) {
		// 추천상품 슬라이드
		$('.clearSlideV15').slidesjs({
			width:1140,
			height:420,
			navigation:{active:true, effect:"fade"},
			pagination:{active:true, effect:"fade"},
			play:{interval:4500, effect:"fade", auto:true, pauseOnHover:true},
			effect:{
				fade:{speed:600, crossfade:true}
			}
		}).find('.slidesjs-pagination').append('<span>3</span>')
	}
});

//가격대별 정렬
function jsGoUrl(catecode, price){
      location.href = "/clearancesale/index.asp?disp="+catecode+"&price="+price+"&srm=<%=SortMet%>&flo1=<%=flo1%>&flo2=<%=flo2%>&flo3=<%=flo3%>";
}

//상품 정렬
function fnSearch(frmval){
	var frm = document.sFrm;
	frm.cpg.value = 1;
	frm.srm.value = frmval;
	frm.submit();
}

//페이징
function TnMovePage(pg){
	document.sFrm.cpg.value=pg;
	document.sFrm.submit();
}

//무배 flo1
function chkfree(flo1,flo2,flo3){
	if(document.all.chksearchfree.checked==true){
		location.href = "/clearancesale/index.asp?disp=<%=catecode%>&price=<%=price%>&srm=<%=SortMet%>&flo1="+flo1+"&flo2="+flo2+"&flo3="+flo3;
	}
	if(document.all.chksearchfree.checked==false){
		location.href = "/clearancesale/index.asp?disp=<%=catecode%>&price=<%=price%>&srm=<%=SortMet%>&flo1=&flo2="+flo2+"&flo3="+flo3;
	}
}

//텐바이텐배송 flo2
function chktenbae(flo1,flo2,flo3){
	if(document.all.chksearchtenbae.checked==true){
		location.href = "/clearancesale/index.asp?disp=<%=catecode%>&price=<%=price%>&srm=<%=SortMet%>&flo1="+flo1+"&flo2="+flo2+"&flo3="+flo3;
	}
	if(document.all.chksearchtenbae.checked==false){
		location.href = "/clearancesale/index.asp?disp=<%=catecode%>&price=<%=price%>&srm=<%=SortMet%>&flo1="+flo1+"&flo2=&flo3="+flo3;
	}
}

//포장상품여부 flo3
function chkpojangok(flo1,flo2,flo3){
	if(document.all.chksearchpojangok.checked==true){
		location.href = "/clearancesale/index.asp?disp=<%=catecode%>&price=<%=price%>&srm=<%=SortMet%>&flo1="+flo1+"&flo2="+flo2+"&flo3="+flo3;
	}
	if(document.all.chksearchpojangok.checked==false){
		location.href = "/clearancesale/index.asp?disp=<%=catecode%>&price=<%=price%>&srm=<%=SortMet%>&flo1="+flo1+"&flo2="+flo2+"&flo3=";
	}
}
</script>
</head>
<body>
<div class="wrap clearanceV15">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container skinV19">
		<div id="contentWrap">
			<div class="hotHgroupV19 bg-orange">
				<div class="tab-area">
					<ul>
						<li><a href="/shoppingtoday/shoppingchance_saleitem.asp">세일중인 상품</a></li>
						<li class="on"><a href="/clearancesale/">클리어런스</a></li>
						<li><a href="/shoppingtoday/shoppingchance_plussale.asp">플러스 아이템</a></li>
					</ul>
				</div>
				<h2>CLEARANCE<% if oclearancelist.fnGetmaxSalePercent<>"" then %><span class="rate"><%= oclearancelist.fnGetmaxSalePercent %>%~</span><% end if %><p class="tit-sub">숨겨져 있는 보물같은 상품들을 할인된 가격으로 만나보세요!</p></h2>
				<% ''상단 롤링 %>
				<% if obestitem.Fbestitem > 4 or oLimitedLowStock.FLowStockcnt > 4 or oNewsellitem.Fnowsellitemcnt > 4 then %>
				<div class="clearHotItemV15 ">
					<div class="clearSlideV15">
						<%'' 롤링1 : 실시간 인기 상품 %>
						<!-- #include virtual="/clearancesale/inc/inc_bestitem.asp" -->
						
						<%'' 롤링2 : 30개이하 재고 상품 %>
						<!-- #include virtual="/clearancesale/inc/inc_limitlowstock.asp" -->
						
						<%'' 롤링3 : 방금 판매된 상품 %>
						<!-- #include virtual="/clearancesale/inc/inc_newsellitem.asp" -->
					</div>
				</div>
				<% end if %>
				<div class="grpSubWrapV19">
					<ul>
						<li <%=CHKIIF(price="all","class=on","")%>><a href="" onClick="jsGoUrl('<%=catecode%>','all'); return false;">All</a></li>
						<li <%=CHKIIF(price="0","class=on","")%>><a href="" onClick="jsGoUrl('<%=catecode%>','0'); return false;">1만원미만</a></li>
						<li <%=CHKIIF(price="1","class=on","")%>><a href="" onClick="jsGoUrl('<%=catecode%>','1'); return false;">1~3만원</a></li>
						<li <%=CHKIIF(price="3","class=on","")%>><a href="" onClick="jsGoUrl('<%=catecode%>','3'); return false;">3~5만원</a></li>
						<li <%=CHKIIF(price="5","class=on","")%>><a href="" onClick="jsGoUrl('<%=catecode%>','5'); return false;">5~10만원</a></li>
						<li <%=CHKIIF(price="10","class=on","")%>><a href="" onClick="jsGoUrl('<%=catecode%>','10'); return false;">10만원 이상</a></li>
					</ul>
				</div>
				<div class="snb-bar">
					<div class="snbbar-inner">
						<div class="btn-ctgr"><span><%=fnSelectCategoryName(catecode)%></span></div>
						<div class="sortingV19">
							<div class="choice-wrap">
								<ul>
									<li><input type="checkbox" id="chksearchfree" name="chksearchfree" onclick="chkfree('free','<%= flo2 %>','<%= flo3 %>');" <% if flo1 = "free" then response.write "checked" %>><label for="chksearchfree">무료배송</label></li>
									<li><input type="checkbox" id="chksearchtenbae" name="chksearchtenbae" onclick="chktenbae('<%= flo1 %>','tenbae','<%= flo3 %>');" <% if flo2 = "tenbae" then response.write "checked" %>><label for="chksearchtenbae">텐바이텐 배송</label></li>
									<li><input type="checkbox" id="chksearchpojangok" name="chksearchpojangok" onclick="chkpojangok('<%= flo1 %>','<%= flo2 %>','pojangok');" <% if flo3 = "pojangok" then response.write "checked" %>><label for="chksearchpojangok">선물포장 상품</label></li>
								</ul>
							</div>
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
								<li class="<%= chkIIF(catecode="","class=on","") %>"><a href="/clearancesale/index.asp?price=<%=price%>&srm=<%=SortMet%>&flo1=<%=flo1%>&flo2=<%=flo2%>&flo3=<%=flo3%>">전체 카테고리</a></li>
								<%=fnAwardBestCategoryLI(catecode,"/clearancesale/index.asp?price="&price&"&srm="&SortMet&"&flo1="&flo1&"&flo2="&flo2&"&flo3="&flo3&"&")%>
							</ul>
						</div>
					</div>
				</div>
			</div>
			<div class="hotSectionV15 hotSaleV15">
				<form name="sFrm" method="get" action="/clearancesale/index.asp" style="margin:0px;">
				<input type="hidden" name="price" value="<%= price %>">
				<input type="hidden" name="psz" value="<%= PageSize %>">
				<input type="hidden" name="cpg" value="<%=oclearancelist.FCurrPage %>">
				<input type="hidden" name="flo3" value="<%=flo3 %>">
				<input type="hidden" name="flo1" value="<%=flo1 %>">
				<input type="hidden" name="flo2" value="<%=flo2 %>">
				<input type="hidden" name="disp" value="<%= oclearancelist.FRectcatecode %>">
				<input type="hidden" name="srm" value="<%= oclearancelist.FRectSortMethod %>">
				<a name="clearanceList" id="clearanceList"></a>
				<div class="hotArticleV15">
					<%'' list %>
					<% IF oclearancelist.FResultCount > 0 THEN %>
						<div class="pdtWrap pdt240V15 row_4th">
							<ul class="pdtList">
								<%'' for dev msg : 한 페이지당 16개 상품 보여주세요 %>
								<% 
									FOR i = 0 to oclearancelist.FResultCount-1 

									classStr = ""
									linkUrl = "/shopping/category_prd.asp?itemid="& oclearancelist.FItemList(i).FItemID 
									adultChkFlag = false
									adultChkFlag = session("isAdult") <> true and oclearancelist.FItemList(i).FadultType = 1									
													
									If oclearancelist.FItemList(i).isSoldOut=true then
										classStr = addClassStr(classStr,"soldOut")							
									end if				
									if adultChkFlag then
										classStr = addClassStr(classStr,"adult-item")								
									end if													 									
								%>
									<li class="<%=classStr%>" <%=chkIIF(adultChkFlag, "onclick=""confirmAdultAuth('"&linkUrl&"');""","")%> > 						
										<div class="pdtBox">
											<% '// 해외직구배송작업추가(원승현) %>
											<% If oclearancelist.FItemList(i).IsDirectPurchase Then %>
												<i class="abroad-badge">해외직구</i>
											<% End If %>
											<div class="pdtPhoto">
											<% if adultChkFlag then %>									
											<div class="adult-hide">
												<p><span>19세 이상만</span> <span>구매 가능한 상품입니다</span></p>
											</div>
											<% end if %>											
												<span class="soldOutMask"></span>
												<a href="/shopping/category_prd.asp?itemid=<%=oclearancelist.FItemList(i).FItemid%>">
													<img src="<%=getThumbImgFromURL(oclearancelist.FItemList(i).FImageBasic,"240","240","true","false") %>" width="240" height="240" alt="<%= oclearancelist.FItemList(i).FItemName %>" />
												</a>
											</div>
											<div class="pdtInfo">
												<p class="pdtBrand tPad20"><a href="" onclick="GoToBrandShop('<%= oclearancelist.FItemList(i).FMakerId %>'); return false;"><%= oclearancelist.FItemList(i).FBrandName %></a></p>
												<p class="pdtName tPad07"><a href="/shopping/category_prd.asp?itemid=<%=oclearancelist.FItemList(i).FItemid%>"><%= oclearancelist.FItemList(i).FItemName %></a></p>
												<%
													If oclearancelist.FItemList(i).IsSaleItem or oclearancelist.FItemList(i).isCouponItem Then
														'If oclearancelist.FItemList(i).Fitemcoupontype <> "3" Then
														'	Response.Write "<p class='pdtPrice'><span class='txtML'>" & FormatNumber(oclearancelist.FItemList(i).FOrgPrice,0) & "원 </span></p>"
														'End If
														IF oclearancelist.FItemList(i).IsSaleItem Then
															Response.Write "<p class='pdtPrice'><span class='txtML'>" & FormatNumber(oclearancelist.FItemList(i).FOrgPrice,0) & "원 </span></p>"
															Response.Write "<p class='pdtPrice'><span class='finalP'>" & FormatNumber(oclearancelist.FItemList(i).getRealPrice,0) & "원 </span>"
															Response.Write "<strong class='cRd0V15'>[" & oclearancelist.FItemList(i).getSalePro & "]</strong></p>"
														End IF
														IF oclearancelist.FItemList(i).IsCouponItem Then
															if Not(oclearancelist.FItemList(i).IsFreeBeasongCoupon() or oclearancelist.FItemList(i).IsSaleItem) Then
																Response.Write "<p class='pdtPrice'><span class='txtML'>" & FormatNumber(oclearancelist.FItemList(i).FOrgPrice,0) & "원 </span></p>"
															end if
															Response.Write "<p class='pdtPrice'><span class='finalP'>" & FormatNumber(oclearancelist.FItemList(i).GetCouponAssignPrice,0) & "원 </span>"
															Response.Write "<strong class='cGr0V15'>[" & oclearancelist.FItemList(i).GetCouponDiscountStr & "]</strong></p>"
														End IF
													Else
														Response.Write "<p class='pdtPrice'><span class='finalP'>" & FormatNumber(oclearancelist.FItemList(i).getRealPrice,0) & "원 </span>"
													End If
												%>

												<p class="pdtStTag tPad10">
												<%
													IF oclearancelist.FItemList(i).isSoldOut Then
														Response.Write "<img src='http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif' alt='SOLDOUT' />"
													Else
														IF oclearancelist.FItemList(i).isTenOnlyItem Then Response.Write "<img src='http://fiximage.10x10.co.kr/web2013/shopping/tag_only.gif' alt='ONLY' /> "
														IF oclearancelist.FItemList(i).isSaleItem Then Response.Write "<img src='http://fiximage.10x10.co.kr/web2013/shopping/tag_sale.gif' alt='SALE' /> "
														IF oclearancelist.FItemList(i).isCouponItem Then Response.Write "<img src='http://fiximage.10x10.co.kr/web2013/shopping/tag_coupon.gif' alt='쿠폰' /> "
														IF oclearancelist.FItemList(i).isLimitItem Then Response.Write "<img src='http://fiximage.10x10.co.kr/web2013/shopping/tag_limited.gif' alt='한정' /> "
														IF oclearancelist.FItemList(i).isNewItem Then Response.Write "<img src='http://fiximage.10x10.co.kr/web2013/shopping/tag_new.gif' alt='NEW' /> "
														IF oclearancelist.FItemList(i).IsPojangitem Then Response.Write "<span class='icoWrappingV15a'><img src='http://fiximage.10x10.co.kr/web2015/shopping/ico_pakage_act.png' alt='선물포장가능'><em><img src='http://fiximage.10x10.co.kr/web2015/common/pkg_tip.png' alt='선물포장가능'></em></span> "
													End If
												%>
												</p>
											</div>
											<ul class="pdtActionV15">
												<li class="largeView"><a href="" onclick="ZoomItemInfo('<%=oclearancelist.FItemList(i).FItemid%>'); return false;"><img src="http://fiximage.10x10.co.kr/web2015/common/btn_quick.png" alt="QUICK" /></a></li>
												<li class="postView"><a href="" onclick="popEvaluate('<%=oclearancelist.FItemList(i).FItemid%>'); return false;"><span><%= oclearancelist.FItemList(i).FEvalCnt %></span></a></li>
												<li class="wishView"><a href="" onclick="TnAddFavorite('<%= oclearancelist.FItemList(i).FItemID %>'); return false;"><span><%= oclearancelist.FItemList(i).FFavCount %></span></a></li>
											</ul>
										</div>
									</li>
								<% next %>
							</ul>
						</div>
	
						<%'' paging %>
						<div class="pageWrapV15 tMar20">
							<%= fnDisplayPaging_New(CurrPage,oclearancelist.FTotalCount,PageSize,10,"TnMovePage") %>
						</div>
					<% else %>
						<div class="noData">
							<p>세일중인 상품이 없습니다</p>
						</div>
					<% end if %>
				</div>
				</form>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<%
set obestitem = nothing
set oLimitedLowStock = nothing
set oNewsellitem = nothing
set oclearancelist = nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
