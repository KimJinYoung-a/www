<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : 애플 기획전 2020
' History : 2020-04-24 이종화 생성
'####################################################
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<%
'============== 모바일 접근시 모바일 페이지 이동(referer가 10x10이면 이동안함) ============
if InStr(request.ServerVariables("HTTP_REFERER"),"10x10.co.kr")<1 then
	if Not(Request("mfg")="pc" or session("mfg")="pc") then
		if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
			Response.Redirect "http://m.10x10.co.kr/event/apple/"
			REsponse.End
		end if
	end if
end if
%>
<link rel="stylesheet" type="text/css" href="/lib/css/apple.css?v=1.3">
<style>[v-cloak] { display: none; }</style>
<style>
	.cartLyr {position:absolute; width:234px; height:120px; padding:25px 20px 0; background:url(http://fiximage.10x10.co.kr/web2015/shopping/bg_descript_box.png) 50% 0 no-repeat; z-index:201;}
	.cartLyr p {padding:0 7px 15px; color:#222; font-size:13px; font-weight:600;}
	.cartLyr .btn-close {position: absolute; top:0; right:2px; width:40px; height:40px; font-size:15px; font-weight:600; background:transparent;}
	.cartLyr .btn-area {display:flex; justify-content:center;}
	.cartLyr .btn-area a {display:flex; align-items:center; justify-content:center; width:112px; height:35px; margin:0 5px; font-size:13px; border-radius:17px; font-weight:600; color:#222; background:#e2e2e2;}
	.cartLyr .btn-area a:first-child {color:#fff; background-color:#6236ff;}
</style>
<script>
$(function() {
	fnAmplitudeEventMultiPropertiesAction('view_family2020_main','','');
	// navigation
	var tabTop = $(".navigation").offset().top,
		tabNav = $(".navigation").outerHeight();
	$(window).scroll(function(){
		var tabIpad = $("#ipad").offset().top - tabNav,
			tabMacbook = $("#macbook").offset().top - tabNav,
			tabIphone = $("#iphone").offset().top - tabNav,
			tabImac = $("#imac").offset().top - tabNav,
			tabAirpods = $("#airpods").offset().top - tabNav,
			tabWatch = $("#watch").offset().top - tabNav;
		var y = $(window).scrollTop();
		if ( tabTop <= y ) {
			$(".navigation").addClass("sticky");
			var tabIpad = $("#ipad").offset().top - tabNav,
				tabMacbook = $("#macbook").offset().top - tabNav,
				tabIphone = $("#iphone").offset().top - tabNav,
				tabImac = $("#imac").offset().top - tabNav,
				tabAirpods = $("#airpods").offset().top - tabNav,
				tabWatch = $("#watch").offset().top - tabNav;
			if ( y < tabMacbook ) {
				$(".navigation li.tab-iPad").addClass("current").siblings("li").removeClass("current");
			} else if ( tabMacbook <= y && y < tabAirpods ) {
				$(".navigation li.tab-macbook").addClass("current").siblings("li").removeClass("current");
			} else if ( tabAirpods  <= y && y < tabImac ) {
				$(".navigation li.tab-airpods").addClass("current").siblings("li").removeClass("current");
			} else if ( tabImac <= y && y < tabIphone ) {
				$(".navigation li.tab-imac").addClass("current").siblings("li").removeClass("current");
			} else if ( tabIphone <= y && y < tabWatch ) {
				$(".navigation li.tab-iphone").addClass("current").siblings("li").removeClass("current");
			} else {
				$(".navigation li.tab-watch").addClass("current").siblings("li").removeClass("current");
			}
		} else {
			$(".navigation").removeClass("sticky");
		}
	});
});
</script>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container">
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

<script src="/vue/exhibition/components/shoppingbag.js"></script>
<script src="/vue/exhibition/components/mdpick/appletype-itemlist.js"></script>
<script src="/vue/exhibition/components/item/item-list.js"></script>
<script src="/vue/exhibition/components/slideEvent-list.js?v=1.0"></script>
<script src="/vue/exhibition/modules/store.js"></script>
<script src="/vue/exhibition/main/apple/index.js"></script>
</body>
</html>