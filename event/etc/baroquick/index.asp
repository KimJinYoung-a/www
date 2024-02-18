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
'============== 모바일 접근시 모바일 페이지 이동(referer가 10x10이면 이동안함) ============
if InStr(request.ServerVariables("HTTP_REFERER"),"10x10.co.kr")<1 then
	if Not(Request("mfg")="pc" or session("mfg")="pc") then
		if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
			dim mQrParam: mQrParam = request.QueryString		'// 유입 전체 파라메터 접수
			Response.Redirect "http://m.10x10.co.kr/event/etc/baroquick/index.asp?" & mQrParam
			REsponse.End
		end if
	end if
end if
	'// 변수 선언 //
	Dim lp

dim SortMet		: SortMet =  requestCheckVar(request("srm"),2)
dim searchFlag 	: searchFlag = "qq"
dim CurrPage 	: CurrPage = getNumeric(requestCheckVar(request("cpg"),9))
dim catecode	: catecode = getNumeric(requestCheckVar(request("disp"),9))
dim icoSize		: icoSize = requestCheckVar(request("icoSize"),1)

if icoSize="" then icoSize="M"	'상품 아이콘 기본(중간)
if SortMet="" then SortMet="be"		'정렬 기본값 : 인기순

'추가 이미지 사이즈
dim imgSz	: imgSz = chkIIF(icoSize="M",240,150)

dim ListDiv,ColsSize,ScrollCount
dim cdlNpage
ListDiv="fulllist"
ColsSize =6
ScrollCount = 10

if CurrPage="" then CurrPage=1

dim oDoc,iLp
set oDoc = new SearchItemCls
'10000원 이상 제품
oDoc.FminPrice 			= 10000
oDoc.FListDiv 			= ListDiv
oDoc.FRectSortMethod	= SortMet
oDoc.FRectSearchFlag 	= searchFlag
oDoc.FPageSize 			= 100

oDoc.FCurrPage 			= CurrPage
oDoc.FSellScope			= "Y"
oDoc.FScrollCount 		= ScrollCount
oDoc.FRectSearchItemDiv ="D"
oDoc.FRectCateCode			= catecode

oDoc.getSearchList
'바로배송 전 상품  count
dim quickDlvCntObj
set quickDlvCntObj = new SearchItemCls

quickDlvCntObj.FListDiv 	= ListDiv
quickDlvCntObj.FRectSortMethod	= SortMet
quickDlvCntObj.FRectSearchFlag 	= searchFlag

quickDlvCntObj.FSellScope			= "Y"
quickDlvCntObj.FRectSearchItemDiv ="D"

quickDlvCntObj.getSearchList
%>
<style type="text/css">
.baro-quick {position:relative; padding-top:98px; background-color:#499afd; text-align:center;}
.baro-quick .tag1, .baro-quick .tag2 {display:block; position:absolute; left:50%; margin-left:417px; animation:bounce 1.5s 50;}
.baro-quick i.tag1 {top:145px;}
.baro-quick i.tag2 {top:228px;}
.notice {overflow:hidden; display:table; width:890px; padding:15px 0 65px; margin:0 auto;}
.notice h3 {display:table-cell; width:150px; text-align:center; vertical-align:middle;}
.notice ul {display:table-cell;}
.notice ul li {position:relative; padding-left:15px; margin:7px 0; text-align:left; color:#fff; font-size:15px; line-height:1.2; letter-spacing:-0.5px; font-family:malgungothic, '맑은고딕', sans-serif;}
.notice ul li:before {content:''; display:block; position:absolute; left:0; top:7px; width:5px; height:4px; background:url(http://webimage.10x10.co.kr/eventIMG/2018/baroquick/blt_dot.png) no-repeat 0 0;}
.current-view {position:relative; overflow:visible; width:100%; height:235px; margin-bottom:-16px; background:url(http://webimage.10x10.co.kr/eventIMG/2018/baroquick/bg_current.png) no-repeat 0 0; z-index:5;}
.current-view .current-txt {width:50%; padding:65px 0 0 265px; text-align:left;}
.current-view .current-txt p {padding:5px 0;}
.current-view .current-txt p span {padding:0 5px; color:#bdff20; font-size:24px; line-height:21px; font-weight:bold; font-family:verdana, sans-serif;}
.current-view .btn-link {position:absolute; left:660px; top:85px;}
.current-view .btn-link a {display:block; width:230px; height:40px; padding-top:20px; text-align:center;}
.current-view .btn-link a:hover {animation:shake 4s 50; animation-fill-mode:both;}
.baro-best100 {background-color:#fefcf7; padding:89px 63px;}
.baro-best100 .pdtWrap {margin-top:60px; background:none;}
.baro-best100 .pdt240V15 .pdtList {margin-bottom:-2px;}
.baro-best100 .pdt240V15 .pdtList > li {width:25%;}
.baro-best100 .pdt240V15 .pdtBox {height:440px;}
@keyframes bounce {
	from, to {transform:translateY(0); animation-timing-function:ease-out;}
	50% {transform:translateY(7px); animation-timing-function:ease-in;}
}
@keyframes shake {
	0%, 100% {transform:translateX(0);}
	10%, 30%, 50%, 70%, 90% {transform:translateX(-5px);}
	20%, 40%, 60%, 80% {transform:translateX(5px);}
}
</style>
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

	// Item Image Control
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

</script>

</head>
<body>
<div id="eventDetailV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container"><!-- for dev msg : 왼쪽메뉴(카테고리명) 사용시 클래스 : partEvt / 왼쪽메뉴(카테고리명) 사용 안할때 클래스 : fullEvt -->
		<div id="contentWrap">
		<%
			'// 바로배송 종료에 따른 처리
			If now() > #07/31/2019 12:00:00# Then
				Response.Write "바로배송 서비스가 종료되었습니다."
			Else
		%>
			<div class="baro-quick">
				<h2><img src="http://webimage.10x10.co.kr/eventIMG/2018/baroquick/tit_baro.png" alt="주문하고 그날 바로 받는 당일배송 서비스 텐바이텐 바로배송" /></h2>
				<i class="tag1"><img src="http://webimage.10x10.co.kr/eventIMG/2018/baroquick/tag01.png" alt="서울지역 한정" /></i><i class="tag2"><img src="http://webimage.10x10.co.kr/eventIMG/2018/baroquick/tag02.png" alt="특정상품 한정" /></i>
				<p class="tMar50"><img src="http://webimage.10x10.co.kr/eventIMG/2018/baroquick/img_process_v3.png" alt="바로배송 배송료는 5,000원 이며 오후 1시 이전 결제완료 된 상품에 대해 그날 저녁까지 바로 배송합니다." /></p>
				<div class="notice">
					<h3><img src="http://webimage.10x10.co.kr/eventIMG/2018/baroquick/tit_notice.png" alt="알아두기" /></h3>
					<ul>
						<li>바로배송은 <strong>배송지가 서울 지역</strong>일 경우에만 가능한 배송 서비스입니다.</li>
						<li><strong>주문 당일 오후 1시 전 결제완료된 주문에만 신청 가능</strong>하며, 오후 1시 이후 신청 시 다음날 배송이 시작됩니다.</li>
						<li>더욱 더 빠른 배송 서비스를 위해 주말/공휴일에는 쉽니다.</li>
						<li>상품의 <strong>부피/무게에 따라 배송 유/무 또는 요금이 달라질 수</strong> 있습니다.</li>
						<li>바로배송 서비스에는 <strong>무료배송 쿠폰을 적용할 수 없습니다.</strong></li>
					</ul>
				</div>
				<div class="current-view">
					<div class="current-txt">
						<p><img src="http://webimage.10x10.co.kr/eventIMG/2018/baroquick/txt_current1.png" alt="현재" /><span><%=FormatNumber(quickDlvCntObj.FTotalCount,0)%></span><img src="http://webimage.10x10.co.kr/eventIMG/2018/baroquick/txt_current2.png" alt="개의 상품이" /></p>
						<p><img src="http://webimage.10x10.co.kr/eventIMG/2018/baroquick/txt_current3.png" alt="바로배송을 지원합니다." /></p>
					</div>
					<p class="btn-link"><a href="/shoppingtoday/barodelivery.asp"><img src="http://webimage.10x10.co.kr/eventIMG/2018/baroquick/btn_allview.png" alt="전체상품보기" /></a></p>
				</div>
				<div class="baro-best100">
					<h3><img src="http://webimage.10x10.co.kr/eventIMG/2018/baroquick/subtit_best.png" alt="베스트 상품도 바로바로! 바로배송 베스트 100" /></h3>					
					<div class="pdtWrap pdt240V15">						
						<ul class="pdtList">
							<!-- 상품 리스트 -->
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
										<div class="pdtPhoto">
											<a href="/deal/deal.asp?itemid=<%=oDoc.FItemList(i).FItemID %>&gaparam=newarrival_<%=SortMet%>_<%=i+1%>">
												<span class="soldOutMask"></span>
												<img src="<%= getThumbImgFromURL(oDoc.FItemList(i).FImageBasic,imgSz,imgSz,"true","false") %>" width="180" height="180" alt="<% = oDoc.FItemList(i).FItemName %>" />
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
										<% If oDoc.FItemList(i).FDeliverFixDay <> "L" Then %>
											<% If oDoc.FItemList(i).FFreeDeliveryYN="Y" Then %>
												<i class="free-shipping-badge">무료<br>배송</i>
											<% End If %>
										<% End If %>	
                                        <% If oDoc.FItemList(i).IsDirectPurchase Then %>
                                            <i class="abroad-badge">해외직구</i>
                                        <% End If %>    																												
										<div class="pdtPhoto">
											<a href="/shopping/category_prd.asp?itemid=<%=oDoc.FItemList(i).FItemID %>&gaparam=newarrival_<%=SortMet%>_<%=i+1%>">
												<span class="soldOutMask"></span>
												<img src="<%= getThumbImgFromURL(oDoc.FItemList(i).FImageBasic,imgSz,imgSz,"true","false") %>" width="180" height="180" alt="<% = oDoc.FItemList(i).FItemName %>" />
												<% if oDoc.FItemList(i).FAddimage<>"" then %><dfn><img src="<%=getThumbImgFromURL(oDoc.FItemList(i).FAddimage,imgSz,imgSz,"true","false")%>" alt="<%=Replace(oDoc.FItemList(i).FItemName,"""","")%>" /></dfn><% end if %>
											</a>
										</div>
										<div class="pdtInfo">
											<p class="pdtBrand tPad20"><a href="/street/street_brand.asp?makerid=<%= oDoc.FItemList(i).FMakerid %>"><% = oDoc.FItemList(i).FBrandName %></a></p>
											<p class="pdtName tPad07"><a href="/shopping/category_prd.asp?itemid=<%= oDoc.FItemList(i).FItemID %>&disp=<%= oDoc.FItemList(i).FcateCode %>"><% = oDoc.FItemList(i).FItemName %></a></p>
											<% if oDoc.FItemList(i).IsSaleItem or oDoc.FItemList(i).isCouponItem Then %>
												<% IF oDoc.FItemList(i).IsSaleItem then %>
												<p class="pdtPrice"><span class="txtML"><%=FormatNumber(oDoc.FItemList(i).getOrgPrice,0)%>원</span></p>
												<p class="pdtPrice"><span class="finalP"><%=FormatNumber(oDoc.FItemList(i).getRealPrice,0)%>원</span> <strong class="cRd0V15">[<%=oDoc.FItemList(i).getSalePro%>]</strong></p>
												<% End If %>
												<% IF oDoc.FItemList(i).IsCouponItem Then %>
													<% if Not(oDoc.FItemList(i).IsFreeBeasongCoupon() or oDoc.FItemList(i).IsSaleItem) Then %>
												<p class="pdtPrice"><span class="txtML"><%=FormatNumber(oDoc.FItemList(i).getOrgPrice,0)%>원</span></p>
													<% end If %>
												<p class="pdtPrice"><span class="finalP"><%=FormatNumber(oDoc.FItemList(i).GetCouponAssignPrice,0)%>원</span> <strong class="cGr0V15">[<%=oDoc.FItemList(i).GetCouponDiscountStr%>]</strong></p>
												<% End If %>
											<% Else %>
												<p class="pdtPrice"><span class="finalP"><%=FormatNumber(oDoc.FItemList(i).getRealPrice,0) & chkIIF(oDoc.FItemList(i).IsMileShopitem,"Point","원")%></span></p>
											<% End If %>
											<p class="pdtStTag tPad10">
											<% IF oDoc.FItemList(i).isSoldOut Then %>
												<img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" />
											<% else %>
												<% IF oDoc.FItemList(i).isTempSoldOut Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" /> <% end if %>
												<% IF oDoc.FItemList(i).isSaleItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_sale.gif" alt="SALE" /> <% end if %>
												<% IF oDoc.FItemList(i).isCouponItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_coupon.gif" alt="쿠폰" /> <% end if %>
												<% IF oDoc.FItemList(i).isLimitItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_limited.gif" alt="한정" /> <% end if %>
												<% IF oDoc.FItemList(i).IsTenOnlyitem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_only.gif" alt="ONLY" /> <% end if %>
												<% IF oDoc.FItemList(i).isNewItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_new.gif" alt="NEW" /> <% end if %>
												<% IF oDoc.FItemList(i).IsPojangitem Then %><span class="icoWrappingV15a"><img src="http://fiximage.10x10.co.kr/web2015/shopping/ico_pakage_act.png" alt="선물포장가능"><em><img src="http://fiximage.10x10.co.kr/web2015/common/pkg_tip.png" alt="선물포장가능"></em></span> <% end if %>												
											<% end if %>
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
					<p class="tMar70"><a href="/shoppingtoday/barodelivery.asp"><img src="http://webimage.10x10.co.kr/eventIMG/2018/baroquick/btn_allview2.png" alt="바로배송 전체상품보기" /></a></p>
				</div>
			</div>
		<%
			End If
		%>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->