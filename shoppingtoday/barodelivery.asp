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
dim searchFlag 	: searchFlag = "qq"
dim CurrPage 	: CurrPage = getNumeric(requestCheckVar(request("cpg"),9))
dim catecode	: catecode = getNumeric(requestCheckVar(request("disp"),9))
dim icoSize		: icoSize = requestCheckVar(request("icoSize"),1)

if icoSize="" then icoSize="M"	'상품 아이콘 기본(중간)
if SortMet="" then SortMet="be"		'정렬 기본값 : 인기순

'추가 이미지 사이즈
dim imgSz	: imgSz = chkIIF(icoSize="M",180,150)

dim ListDiv,ColsSize,ScrollCount
dim cdlNpage
ListDiv="fulllist"
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
	
	// 바로배송(20170111) 
	$('.infoMoreViewV15').mouseover(function(){
		$(this).children('.infoViewLyrV15').show();
	});
	$('.infoMoreViewV15').mouseleave(function(){
		$(this).children('.infoViewLyrV15').hide();
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

function jsGoUrl(catecode){
	location.href = "/shoppingtoday/barodelivery.asp?disp="+catecode;
}

</script>

</head>
<body>
<div class="wrap baro-deliveryV17">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<%
		'// 바로배송 종료에 따른 처리
		If now() > #07/31/2019 12:00:00# Then
			Response.Write "바로배송 서비스가 종료되었습니다."
		Else
	%>
	<div class="container">
	    <!-- 바로배송(20170111) -->
		<div class="title">
			<div class="inner">
			    <% IF (now()<#19/07/2018 00:00:00#) then %>
			    <h2><img src="http://fiximage.10x10.co.kr/web2018/shopping/txt_baro_sale.png" alt="주문하고 바로바로, 텐바이텐 바로배송 - 오픈기념 배송료 할인 이벤트 25,00원" /></h2>    
			    <% else %>
				<h2><img src="http://fiximage.10x10.co.kr/web2018/shopping/txt_baro.png" alt="주문하고 바로바로, 텐바이텐 바로배송" /></h2>
			    <% end if %>
				<div class="infoMoreViewV15" style="z-index:98;">
					<p class="tMar30"><img src="http://fiximage.10x10.co.kr/web2017/shopping/btn_baro.png" alt="바로배송 안내" /></p>
					<div class="infoViewLyrV15">
						<div class="infoViewBoxV15">
							<dfn></dfn>
							<div class="infoViewV15">
								<div class="pad20">
									<p>오전에 주문한 상품을 그날 오후에 바로 받자!<br />서울 전 지역 한정, 오후 1시까지 주문/결제를 완료할 경우 신청할 수 있는 퀵배송 서비스입니다.</p>
									<p class="tMar10"><strong>바로배송 배송료 : 
									<% IF (now()<#19/07/2018 00:00:00#) then %>
									<del class="cGy1V15">5,000원</del> <span class="cRd0V15">2,500원</span></strong><br /><span class="cGy1V15">(오픈기념 이벤트 할인중, 2018년 7월 18일까지)</span>
								    <% else %>
								    5,000원
								    <% end if %>
									</strong>
									</p>
									<!-- p class="tPad15"><a href="" class="more1V15" style="color:#888; text-decoration:underline; cursor:pointer;">바로배송 상품 전체보기</a></p -->
									<ul class="list01V15 tMar15">
										<li>바로배송은 배송지가 서울 지역일 경우 가능합니다.</li>
										<li>주문 당일 오후 1시전 결제완료된 주문에만 신청 가능하며, 오후 1시 이후 신청 시 다음날 배송이 시작됩니다.</li>
										<li>더욱 더 빠른 배송 서비스를 위해 주말/공휴일에는 쉽니다.</li>
										<li>상품의 부피/무게에 따라 배송 유/무 또는 요금이 달라질 수 있습니다.</li>
										<li>바로배송 서비스에는 무료배송쿠폰을 적용할 수 없습니다.</li>
										<li>회사 또는 사무실로 주문하시는 경우, <span class="cRd0V15">퇴근 시간 이후 배송될 수도 있습니다.</span> 오후 늦게라도 상품 수령이 가능한 주소지를 입력해주시면 감사하겠습니다.</li>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!--// 바로배송(20170111) -->
		<div id="contentWrap">
			<div class="hotSectionV15 hotNewV15">
				<div class="deco"></div>
				<div class="lnbHotV15">
					<div class="all"><strong>전체 카테고리</strong></div>
					<ul>
						<li><a href="?disp=" class="<%= chkIIF(catecode="","on","") %>">전체</a></li>
						<%=fnAwardBestCategoryLI(catecode,"/shoppingtoday/barodelivery.asp?")%>
					</ul>
				</div>

				<div class="hotArticleV15">
				<form name="sFrm" method="get" action="/shoppingtoday/barodelivery.asp" style="margin:0px;">
				<input type="hidden" name="sflag" value="<%= oDoc.FRectSearchFlag  %>">
				<input type="hidden" name="srm" value="<%= oDoc.FRectSortMethod%>">
				<input type="hidden" name="cpg" value="<%=oDoc.FCurrPage %>">
				<input type="hidden" name="psz" value="<%= PageSize%>">
				<input type="hidden" name="chkr" value="<%= oDoc.FCheckResearch %>">
				<input type="hidden" name="disp" value="<%= oDoc.FRectCateCode %>">
				<input type="hidden" name="reset" value="">
					<div class="grpSubWrapV15">
						<span class="blt"></span>
						<span class="total">total <strong><%= FormatNumber(oDoc.FTotalCount,0) %></strong></span>
						<div class="option">
							<select name="ttsrtm" class="optSelect" title="상품 정렬 방법 선택" onchange="fnSearch(this.form.srm,this.value);">
								<option value="ne" <% if SortMet="ne" then response.write "selected" %>>신상품순</option>
								<option value="bs" <% if SortMet="bs" then response.write "selected" %>>판매량순</option>
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
						dim cdlNTotCnt, i, TotalCnt
						dim maxLoop	,intLoop

						TotalCnt = oDoc.FResultCount

							For i=0 To TotalCnt-1
						%>
							<% IF (i <= TotalCnt-1) Then %>
							<li<% If oDoc.FItemList(i).FItemDiv="21" Then %>  class="deal-item"<% End If %>>
								<% If oDoc.FItemList(i).FItemDiv="21" Then %>
								<div class="pdtBox">
									<i class="dealBadge">텐텐<br /><strong>DEAL</strong></i>
									<% If oDoc.FItemList(i).Frecentsellcount >= 30 then %>
										<strong class="pdtLabel"><img src="http://fiximage.10x10.co.kr/web2015/common/ico_label_rookie.png" alt="ROOKIE 상품" /></strong>
									<% End if %>
									<div class="pdtPhoto">
										<a href="/deal/deal.asp?itemid=<%=oDoc.FItemList(i).FItemID %>&gaparam=baro_<%=SortMet%>_<%=i+1%>">
											<span class="soldOutMask"></span>
											<img src="<%= getThumbImgFromURL(oDoc.FItemList(i).FImageBasic,imgSz,imgSz,"true","false") %>" width="180" height="180" alt="<% = oDoc.FItemList(i).FItemName %>" />
											<% if oDoc.FItemList(i).FAddimage<>"" then %><dfn><img src="<%=getThumbImgFromURL(oDoc.FItemList(i).FAddimage,imgSz,imgSz,"true","false")%>" alt="<%=Replace(oDoc.FItemList(i).FItemName,"""","")%>" /></dfn><% end if %>
										</a>
									</div>
									<div class="pdtInfo">
										<p class="pdtBrand tPad20"><a href="javascript:GoToBrandShop('<%=oDoc.FItemList(i).FMakerId %>')"><% = oDoc.FItemList(i).FBrandName %></a></p>
										<p class="pdtName tPad07"><a href="/deal/deal.asp?itemid=<%=oDoc.FItemList(i).FItemID %>&gaparam=baro_<%=SortMet%>_<%=i+1%>"><% = oDoc.FItemList(i).FItemName %></a></p>
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
									<% If oDoc.FItemList(i).Frecentsellcount >= 30 then %>
										<strong class="pdtLabel"><img src="http://fiximage.10x10.co.kr/web2015/common/ico_label_rookie.png" alt="ROOKIE 상품" /></strong>
									<% End if %>
									<div class="pdtPhoto">
										<a href="/shopping/category_prd.asp?itemid=<%=oDoc.FItemList(i).FItemID %>&gaparam=baro_<%=SortMet%>_<%=i+1%>">
											<span class="soldOutMask"></span>
											<img src="<%= getThumbImgFromURL(oDoc.FItemList(i).FImageBasic,imgSz,imgSz,"true","false") %>" width="180" height="180" alt="<% = oDoc.FItemList(i).FItemName %>" />
											<% if oDoc.FItemList(i).FAddimage<>"" then %><dfn><img src="<%=getThumbImgFromURL(oDoc.FItemList(i).FAddimage,imgSz,imgSz,"true","false")%>" alt="<%=Replace(oDoc.FItemList(i).FItemName,"""","")%>" /></dfn><% end if %>
										</a>
									</div>
									<div class="pdtInfo">
										<p class="pdtBrand tPad20"><a href="javascript:GoToBrandShop('<%=oDoc.FItemList(i).FMakerId %>')"><% = oDoc.FItemList(i).FBrandName %></a></p>
										<p class="pdtName tPad07"><a href="/shopping/category_prd.asp?itemid=<%=oDoc.FItemList(i).FItemID %>&gaparam=baro_<%=SortMet%>_<%=i+1%>"><% = oDoc.FItemList(i).FItemName %></a></p>
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
	<%
		End If
	%>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->