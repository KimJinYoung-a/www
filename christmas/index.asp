<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : 2020 크리스마스 기획전
' History : 2020-11-18 정태훈 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/classes/event/exhibitionCls.asp" -->
<%
'============== 모바일 접근시 모바일 페이지 이동(referer가 10x10이면 이동안함) ============
if InStr(request.ServerVariables("HTTP_REFERER"),"10x10.co.kr")<1 then
	if Not(Request("mfg")="pc" or session("mfg")="pc") then
		if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
			Response.Redirect "http://m.10x10.co.kr/christmas/"
			REsponse.End
		end if
	end if
end if

if GetLoginUserLevel<>"7" then
	if now() < #11/23/2020 00:00:00# then
		response.redirect "/christmas/2019/"
	end if
end if

ON ERROR RESUME NEXT

DIM totalPrice , salePercentString , couponPercentString , totalSalePercent, oExhibition, i
SET oExhibition = new ExhibitionCls
	oExhibition.FrectMasterCode = 17 '// 기획전 고유번호
	oExhibition.FrectListType = "A"
    oExhibition.Frectpick = 1
	oExhibition.getItemsPageListProc
%>

<link rel="stylesheet" type="text/css" href="/lib/css/xmas2020.css">
<script type="text/javascript">
$(function(){
	// MD PICK
	$(".slider-prd").slick({
		variableWidth: true,
		draggable: true,
		arrows: true,
		slidesToScroll: 4,
		adaptiveHeight: true
	});
});
window.onload = function(){
	// 인터렉션
	$('.topic').addClass('on');
}
</script>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container xmas2020">
		<!-- 상단 -->
		<div class="topic">
			<h2>
				<span class="t1"><img src="//webimage.10x10.co.kr/fixevent/event/2020/xmas/tit_xmas1.png" alt="holly"></span>
				<span class="t2"><img src="//webimage.10x10.co.kr/fixevent/event/2020/xmas/tit_xmas2.png" alt="Homely Xmas"></span>
			</h2>
			
			<!-- 마케팅 --> 
			<% if date() >= "2020-11-16" and date() <= "2020-11-29" then %>
			<a href="/event/eventmain.asp?eventid=107400" target="_blank" class="bnr-mkt"><img src="//webimage.10x10.co.kr/fixevent/event/2020/xmas/bnr_mkt.png" alt="마케팅배너"></a>
			<% elseif date() >= "2020-11-30" and date() <= "2020-12-06"  then %>
			<a href="/event/eventmain.asp?eventid=107775" target="_blank" class="bnr-mkt"><img src="//webimage.10x10.co.kr/fixevent/event/2020/xmas/bnr_mkt_v2.png" alt="마케팅배너"></a>
			<% elseif date() >= "2020-12-07" and date() <= "2020-12-13"  then %>
			<a href="/event/eventmain.asp?eventid=107790" target="_blank" class="bnr-mkt"><img src="//webimage.10x10.co.kr/fixevent/event/2020/xmas/bnr_mkt_v3.png" alt="마케팅배너"></a>
			<% end if %>

			<div class="deco">
				<i class="dc1"></i>
				<i class="dc2"></i>
				<i class="dc3"></i>
				<i class="dc4"></i>
				<i class="dc5"></i>
			</div>
		</div>

		<%'<!-- MD PICK -->%>
		<% IF oExhibition.FTotalCount > 0 THEN %>
		<section class="mdpick">
			<h3>MD Pick</h3>
			<div class="slider-prd xmas-item">
				<% FOR i = 0 TO oExhibition.FResultCount-1 %>
                <% CALL oExhibition.FItemList(i).fnItemPriceInfos(totalPrice , salePercentString , couponPercentString , totalSalePercent) %>
                <article class="prd-item">
					<figure class="prd-img">
						<img src="<%=oExhibition.FItemList(i).FPrdImage%>" alt="<%=oExhibition.FItemList(i).Fitemname%>">
					</figure>
					<div class="prd-info">
						<div class="prd-price">
							<span class="set-price"><dfn>판매가</dfn><%=totalPrice%></span>
                            <% if salePercentString<>"0" and couponPercentString<>"0" then %>
                            <span class="discount"><dfn>할인율</dfn><%=totalSalePercent%></span>
                            <% else %>
							<% if salePercentString<>"0" then %><span class="discount"><dfn>할인율</dfn><%=salePercentString%></span><% end if %>
                            <% if couponPercentString<>"0" then %><span class="discount"><dfn>할인율</dfn><%=couponPercentString%> 쿠폰</span><% end if %>
                            <% end if %>
						</div>
						<div class="prd-name"><%=oExhibition.FItemList(i).Fitemname%></div>
                        <% if fnEvalTotalPointAVG(oExhibition.FItemList(i).FtotalPoint,"search") >= 80 then %>
                        <div class="user-side">
							<span class="user-eval"><dfn>평점</dfn><i style="width:<%=fnEvalTotalPointAVG(oExhibition.FItemList(i).FtotalPoint,"search")%>%"><%=fnEvalTotalPointAVG(oExhibition.FItemList(i).FtotalPoint,"search")%>점</i></span>
							<% if oExhibition.FItemList(i).FevalCnt >= 5 then %><span class="user-comment"><dfn>상품평</dfn><%=oExhibition.FItemList(i).FevalCnt%></span><% end if %>
						</div>
                        <% end if %>
						<% if oExhibition.FItemList(i).Foptioncode="4" then %><i class="badge-best">베스트</i><% end if %>
                        <% if oExhibition.FItemList(i).Foptioncode="1" then %><i class="badge-lowest">최저가</i><% end if %>
					</div>
					<a href="/shopping/category_prd.asp?itemid=<%=oExhibition.FItemList(i).Fitemid%>" class="prd-link"><span class="blind">상품 바로가기</span></a>
				</article>
                <% next %>
			</div>
		</section>
        <% end if %>
        
		<!-- 이벤트(수작업) -->
		<section class="xmas-event">
			<div class="ch ch1"><a href="/event/eventmain.asp?eventid=107466" target="_blank">chapter1</a></div>
			<div class="ch ch2"><a href="/event/eventmain.asp?eventid=107467" target="_blank">chapter2</a></div>
			<div class="ch ch3"><a href="/event/eventmain.asp?eventid=107468" target="_blank">chapter3</a></div>
		</section>
		
		<%' 상품리스트 %>
		<div id="app" v-cloak></div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
<script src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.auto.min.js"></script>
<% IF application("Svr_Info") = "Dev" THEN %>
    <script src="/vue/vue_dev.js"></script>
<% Else %>
    <script src="/vue/2.5/vue.min.js"></script>
<% End If %>
<script src="/vue/vue.lazyimg.min.js"></script>
<script src="/vue/vuex.min.js"></script>

<script src="/vue/exhibition/components/pagination.js"></script>
<script src="/vue/exhibition/main/christmas2020/item-list.js"></script>
<script src="/vue/exhibition/main/christmas2020/searchfilter.js"></script>
<script src="/vue/exhibition/main/christmas2020/store.js"></script>
<script src="/vue/exhibition/main/christmas2020/index.js"></script>
</body>
</html>
<% SET oExhibition = nothing %>
<!-- #include virtual="/lib/db/dbclose.asp" -->