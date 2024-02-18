<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : 가정의달 기획전 2020
' History : 2020-04-07 이종화 생성
'####################################################
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<%
'============== 모바일 접근시 모바일 페이지 이동(referer가 10x10이면 이동안함) ============
if InStr(request.ServerVariables("HTTP_REFERER"),"10x10.co.kr")<1 then
	if Not(Request("mfg")="pc" or session("mfg")="pc") then
		if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
			Response.Redirect "http://m.10x10.co.kr/event/family2020/"
			REsponse.End
		end if
	end if
end if
%>
<link rel="stylesheet" type="text/css" href="/lib/css/family2020.css?v=1.1">
<script type="text/javascript" src="/event/etc/json/js_applyItemInfo.js"></script>
<style>[v-cloak] { display: none; }</style>
<script>
$(function() {
	fnAmplitudeEventMultiPropertiesAction('view_family2020_main','','');
	$(".family2020 .topic").addClass("on");

	$(".family2020 .tab-cont .slider").slick({
		variableWidth: true,
		centerMode: true,
		dots: true,
		autoplay: true,
		speed: 1000
	});

	var tabTop = $(".tab-nav").offset().top,
		tabNav = $(".tab-nav").outerHeight();
	$(window).scroll(function(){
		var tabParents = $(".tab-parents").offset().top - tabNav,
			tabCouple = $(".tab-couple").offset().top - tabNav,
			tabChild = $(".tab-child").offset().top - tabNav,
			category = $(".category-wrap").offset().top - tabNav,
			tabEvent = $(".tab-event").offset().top - $(window).innerHeight()*.5;
		var y = $(window).scrollTop();
		if ( tabTop <= y ) {
			$(".tab-nav").addClass("fixed");
			var tabParents = $(".tab-parents").offset().top - tabNav,
				tabCouple = $(".tab-couple").offset().top - tabNav,
				tabChild = $(".tab-child").offset().top - tabNav,
				category = $(".category-wrap").offset().top - tabNav,
				tabEvent = $(".tab-event").offset().top - $(window).innerHeight()*.5;
			if ( y < tabCouple ) {
				$(".tab-nav li.parents").addClass("on").siblings("li").removeClass("on");
			} else if ( tabCouple <= y && y < tabChild ) {
				$(".tab-nav li.couple").addClass("on").siblings("li").removeClass("on");
			} else if ( tabChild <= y && y < category ) {
				$(".tab-nav li.child").addClass("on").siblings("li").removeClass("on");
			} else if ( category <= y && y < tabEvent ) {
				$(".tab-nav li").removeClass("on");
			} else {
				$(".tab-nav li.event").addClass("on").siblings("li").removeClass("on");
			}
		} else {
			$(".tab-nav").removeClass("fixed");
		}
	});
	$(".family2020 .tab-nav li a").click(function(e){
		e.preventDefault();
		$(this).parent("li").addClass("on").siblings("li").removeClass("on");
		$('html,body').animate({'scrollTop': $(this.hash).offset().top},0);
	});

	fnApplyItemInfoToTalPriceList({
		items:"2607663,2792109,2278171,2805630,2645437,2599569,2782674,2548608,2516530,2610861,2519135,2351405",
		target:"itemList1",
		fields:["image","name","price","sale","wish","evaluate"],
		unit:"hw",
		saleBracket:false
	});
	fnApplyItemInfoToTalPriceList({
		items:"2331348,2711597,1948702,2201856,2751936,1330771,2825513,2206488,1862657,1692872,2336639,2452429",
		target:"itemList2",
		fields:["image","name","price","sale","wish","evaluate"],
		unit:"hw",
		saleBracket:false
	});
	fnApplyItemInfoToTalPriceList({
		items:"2797702,2774963,2142575,2787707,2694289,2608200,2285057,2702380,2792102,2792013,2720316,1939645",
		target:"itemList3",
		fields:["image","name","price","sale","wish","evaluate"],
		unit:"hw",
		saleBracket:false
	});
});
</script>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container family2020">
		<div class="topic">
			<h2><img src="//webimage.10x10.co.kr/fixevent/event/2020/family2020/tit_present.png" alt="가정의 달"></h2>
			<span><img src="//webimage.10x10.co.kr/fixevent/event/2020/family2020/img_carnation.png" alt=""></span>
		</div>
		<%' 상품영역 %>
		<template id="mdpicklist" v-cloak></template>
		<div class="tab-nav">
			<ul>
				<li class="parents on"><a href="#tab-parents">부모님</a></li>
				<li class="couple"><a href="#tab-couple">연인</a></li>
				<li class="child"><a href="#tab-child">어린이</a></li>
				<li class="event"><a href="#tab-event">기획전</a></li>
			</ul>
		</div>
		<section id="tab-parents" class="tab-cont tab-parents">
			<h3><img src="//webimage.10x10.co.kr/fixevent/event/2020/family2020/tit_parents.png" alt="부모님"></h3>
			<div class="slider">
				<div><a href="/event/eventmain.asp?eventid=101795"><img src="//webimage.10x10.co.kr/fixevent/event/2020/family2020/img_slide2_1.jpg" alt=""></a></div>
				<div><a href="/shopping/category_prd.asp?itemid=2811387"><img src="//webimage.10x10.co.kr/fixevent/event/2020/family2020/img_slide2_2.jpg" alt=""></a></div>
				<div><a href="/shopping/category_prd.asp?itemid=2324241"><img src="//webimage.10x10.co.kr/fixevent/event/2020/family2020/img_slide2_3.jpg" alt=""></a></div>
				<div><a href="/shopping/category_prd.asp?itemid=2201856"><img src="//webimage.10x10.co.kr/fixevent/event/2020/family2020/img_slide2_4.jpg?v=1.0" alt=""></a></div>
			</div>
			<div class="items type-thumb item-240">
				<ul id="itemList2">
					<li>
						<a href="/shopping/category_prd.asp?itemid=2331348">
							<div class="thumbnail"><img src="" alt=""></div>
							<div class="desc">
								<p class="name"></p>
								<p class="price"></p>
							</div>
						</a>
						<div class="etc">
							<div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수"></span></div>
							<div class="tag wish"><span class="icon icon-wish"><i>wish</i></span><span class="counting" title="위시 개수"></span></div>
						</div>
					</li>
					<li>
						<a href="/shopping/category_prd.asp?itemid=2711597">
							<div class="thumbnail"><img src="" alt=""></div>
							<div class="desc">
								<p class="name"></p>
								<p class="price"></p>
							</div>
						</a>
						<div class="etc">
							<div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수"></span></div>
							<div class="tag wish"><span class="icon icon-wish"><i>wish</i></span><span class="counting" title="위시 개수"></span></div>
						</div>
					</li>
					<li>
						<a href="/shopping/category_prd.asp?itemid=1948702">
							<div class="thumbnail"><img src="" alt=""></div>
							<div class="desc">
								<p class="name"></p>
								<p class="price"></p>
							</div>
						</a>
						<div class="etc">
							<div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수"></span></div>
							<div class="tag wish"><span class="icon icon-wish"><i>wish</i></span><span class="counting" title="위시 개수"></span></div>
						</div>
					</li>
					<li>
						<a href="/shopping/category_prd.asp?itemid=2201856">
							<div class="thumbnail"><img src="" alt=""></div>
							<div class="desc">
								<p class="name"></p>
								<p class="price"></p>
							</div>
						</a>
						<div class="etc">
							<div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수"></span></div>
							<div class="tag wish"><span class="icon icon-wish"><i>wish</i></span><span class="counting" title="위시 개수"></span></div>
						</div>
					</li>
					<li>
						<a href="/shopping/category_prd.asp?itemid=2751936">
							<div class="thumbnail"><img src="" alt=""></div>
							<div class="desc">
								<p class="name"></p>
								<p class="price"></p>
							</div>
						</a>
						<div class="etc">
							<div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수"></span></div>
							<div class="tag wish"><span class="icon icon-wish"><i>wish</i></span><span class="counting" title="위시 개수"></span></div>
						</div>
					</li>
					<li>
						<a href="/shopping/category_prd.asp?itemid=1330771">
							<div class="thumbnail"><img src="" alt=""></div>
							<div class="desc">
								<p class="name"></p>
								<p class="price"></p>
							</div>
						</a>
						<div class="etc">
							<div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수"></span></div>
							<div class="tag wish"><span class="icon icon-wish"><i>wish</i></span><span class="counting" title="위시 개수"></span></div>
						</div>
					</li>
					<li>
						<a href="/shopping/category_prd.asp?itemid=2825513">
							<div class="thumbnail"><img src="" alt=""></div>
							<div class="desc">
								<p class="name"></p>
								<p class="price"></p>
							</div>
						</a>
						<div class="etc">
							<div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수"></span></div>
							<div class="tag wish"><span class="icon icon-wish"><i>wish</i></span><span class="counting" title="위시 개수"></span></div>
						</div>
					</li>
					<li>
						<a href="/shopping/category_prd.asp?itemid=2206488">
							<div class="thumbnail"><img src="" alt=""></div>
							<div class="desc">
								<p class="name"></p>
								<p class="price"></p>
							</div>
						</a>
						<div class="etc">
							<div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수"></span></div>
							<div class="tag wish"><span class="icon icon-wish"><i>wish</i></span><span class="counting" title="위시 개수"></span></div>
						</div>
					</li>
					<li>
						<a href="/shopping/category_prd.asp?itemid=1862657">
							<div class="thumbnail"><img src="" alt=""></div>
							<div class="desc">
								<p class="name"></p>
								<p class="price"></p>
							</div>
						</a>
						<div class="etc">
							<div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수"></span></div>
							<div class="tag wish"><span class="icon icon-wish"><i>wish</i></span><span class="counting" title="위시 개수"></span></div>
						</div>
					</li>
					<li>
						<a href="/shopping/category_prd.asp?itemid=1692872">
							<div class="thumbnail"><img src="" alt=""></div>
							<div class="desc">
								<p class="name"></p>
								<p class="price"></p>
							</div>
						</a>
						<div class="etc">
							<div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수"></span></div>
							<div class="tag wish"><span class="icon icon-wish"><i>wish</i></span><span class="counting" title="위시 개수"></span></div>
						</div>
					</li>
					<li>
						<a href="/shopping/category_prd.asp?itemid=2336639">
							<div class="thumbnail"><img src="" alt=""></div>
							<div class="desc">
								<p class="name"></p>
								<p class="price"></p>
							</div>
						</a>
						<div class="etc">
							<div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수"></span></div>
							<div class="tag wish"><span class="icon icon-wish"><i>wish</i></span><span class="counting" title="위시 개수"></span></div>
						</div>
					</li>
					<li>
						<a href="/shopping/category_prd.asp?itemid=2452429">
							<div class="thumbnail"><img src="" alt=""></div>
							<div class="desc">
								<p class="name"></p>
								<p class="price"></p>
							</div>
						</a>
						<div class="etc">
							<div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수"></span></div>
							<div class="tag wish"><span class="icon icon-wish"><i>wish</i></span><span class="counting" title="위시 개수"></span></div>
						</div>
					</li>
				</ul>
			</div>
		</section>
		<section id="tab-couple" class="tab-cont tab-couple">
			<h3><img src="//webimage.10x10.co.kr/fixevent/event/2020/family2020/tit_couple.png" alt="연인"></h3>
			<div class="slider">
				<div><a href="/event/eventmain.asp?eventid=101796"><img src="//webimage.10x10.co.kr/fixevent/event/2020/family2020/img_slide3_1.jpg" alt=""></a></div>
				<div><a href="/shopping/category_prd.asp?itemid=2797702"><img src="//webimage.10x10.co.kr/fixevent/event/2020/family2020/img_slide3_2.jpg" alt=""></a></div>
				<div><a href="/shopping/category_prd.asp?itemid=2300712"><img src="//webimage.10x10.co.kr/fixevent/event/2020/family2020/img_slide3_3.jpg" alt=""></a></div>
				<div><a href="/shopping/category_prd.asp?itemid=2774963"><img src="//webimage.10x10.co.kr/fixevent/event/2020/family2020/img_slide3_4.jpg" alt=""></a></div>
			</div>
			<div class="items type-thumb item-240">
				<ul id="itemList3">
					<li>
						<a href="/shopping/category_prd.asp?itemid=2797702">
							<div class="thumbnail"><img src="" alt=""></div>
							<div class="desc">
								<p class="name"></p>
								<p class="price"></p>
							</div>
						</a>
						<div class="etc">
							<div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수"></span></div>
							<div class="tag wish"><span class="icon icon-wish"><i>wish</i></span><span class="counting" title="위시 개수"></span></div>
						</div>
					</li>
					<li>
						<a href="/shopping/category_prd.asp?itemid=2774963">
							<div class="thumbnail"><img src="" alt=""></div>
							<div class="desc">
								<p class="name"></p>
								<p class="price"></p>
							</div>
						</a>
						<div class="etc">
							<div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수"></span></div>
							<div class="tag wish"><span class="icon icon-wish"><i>wish</i></span><span class="counting" title="위시 개수"></span></div>
						</div>
					</li>
					<li>
						<a href="/shopping/category_prd.asp?itemid=2142575">
							<div class="thumbnail"><img src="" alt=""></div>
							<div class="desc">
								<p class="name"></p>
								<p class="price"></p>
							</div>
						</a>
						<div class="etc">
							<div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수"></span></div>
							<div class="tag wish"><span class="icon icon-wish"><i>wish</i></span><span class="counting" title="위시 개수"></span></div>
						</div>
					</li>
					<li>
						<a href="/shopping/category_prd.asp?itemid=2787707">
							<div class="thumbnail"><img src="" alt=""></div>
							<div class="desc">
								<p class="name"></p>
								<p class="price"></p>
							</div>
						</a>
						<div class="etc">
							<div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수"></span></div>
							<div class="tag wish"><span class="icon icon-wish"><i>wish</i></span><span class="counting" title="위시 개수"></span></div>
						</div>
					</li>
					<li>
						<a href="/shopping/category_prd.asp?itemid=2694289">
							<div class="thumbnail"><img src="" alt=""></div>
							<div class="desc">
								<p class="name"></p>
								<p class="price"></p>
							</div>
						</a>
						<div class="etc">
							<div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수"></span></div>
							<div class="tag wish"><span class="icon icon-wish"><i>wish</i></span><span class="counting" title="위시 개수"></span></div>
						</div>
					</li>
					<li>
						<a href="/shopping/category_prd.asp?itemid=2608200">
							<div class="thumbnail"><img src="" alt=""></div>
							<div class="desc">
								<p class="name"></p>
								<p class="price"></p>
							</div>
						</a>
						<div class="etc">
							<div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수"></span></div>
							<div class="tag wish"><span class="icon icon-wish"><i>wish</i></span><span class="counting" title="위시 개수"></span></div>
						</div>
					</li>
					<li>
						<a href="/shopping/category_prd.asp?itemid=2285057">
							<div class="thumbnail"><img src="" alt=""></div>
							<div class="desc">
								<p class="name"></p>
								<p class="price"></p>
							</div>
						</a>
						<div class="etc">
							<div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수"></span></div>
							<div class="tag wish"><span class="icon icon-wish"><i>wish</i></span><span class="counting" title="위시 개수"></span></div>
						</div>
					</li>
					<li>
						<a href="/shopping/category_prd.asp?itemid=2702380">
							<div class="thumbnail"><img src="" alt=""></div>
							<div class="desc">
								<p class="name"></p>
								<p class="price"></p>
							</div>
						</a>
						<div class="etc">
							<div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수"></span></div>
							<div class="tag wish"><span class="icon icon-wish"><i>wish</i></span><span class="counting" title="위시 개수"></span></div>
						</div>
					</li>
					<li>
						<a href="/shopping/category_prd.asp?itemid=2792102">
							<div class="thumbnail"><img src="" alt=""></div>
							<div class="desc">
								<p class="name"></p>
								<p class="price"></p>
							</div>
						</a>
						<div class="etc">
							<div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수"></span></div>
							<div class="tag wish"><span class="icon icon-wish"><i>wish</i></span><span class="counting" title="위시 개수"></span></div>
						</div>
					</li>
					<li>
						<a href="/shopping/category_prd.asp?itemid=2792013">
							<div class="thumbnail"><img src="" alt=""></div>
							<div class="desc">
								<p class="name"></p>
								<p class="price"></p>
							</div>
						</a>
						<div class="etc">
							<div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수"></span></div>
							<div class="tag wish"><span class="icon icon-wish"><i>wish</i></span><span class="counting" title="위시 개수"></span></div>
						</div>
					</li>
					<li>
						<a href="/shopping/category_prd.asp?itemid=2720316">
							<div class="thumbnail"><img src="" alt=""></div>
							<div class="desc">
								<p class="name"></p>
								<p class="price"></p>
							</div>
						</a>
						<div class="etc">
							<div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수"></span></div>
							<div class="tag wish"><span class="icon icon-wish"><i>wish</i></span><span class="counting" title="위시 개수"></span></div>
						</div>
					</li>
					<li>
						<a href="/shopping/category_prd.asp?itemid=1939645">
							<div class="thumbnail"><img src="" alt=""></div>
							<div class="desc">
								<p class="name"></p>
								<p class="price"></p>
							</div>
						</a>
						<div class="etc">
							<div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수"></span></div>
							<div class="tag wish"><span class="icon icon-wish"><i>wish</i></span><span class="counting" title="위시 개수"></span></div>
						</div>
					</li>
				</ul>
			</div>
		</section>
		<section id="tab-child" class="tab-cont tab-child">
			<h3><img src="//webimage.10x10.co.kr/fixevent/event/2020/family2020/tit_child.png" alt="어린이"></h3>
			<div class="slider">
				<div><a href="/event/eventmain.asp?eventid=101794"><img src="//webimage.10x10.co.kr/fixevent/event/2020/family2020/img_slide1_1.jpg" alt=""></a></div>
				<div><a href="/shopping/category_prd.asp?itemid=2702487"><img src="//webimage.10x10.co.kr/fixevent/event/2020/family2020/img_slide1_2.jpg" alt=""></a></div>
				<div><a href="/shopping/category_prd.asp?itemid=2805630"><img src="//webimage.10x10.co.kr/fixevent/event/2020/family2020/img_slide1_3.jpg" alt=""></a></div>
				<div><a href="/shopping/category_prd.asp?itemid=2768968"><img src="//webimage.10x10.co.kr/fixevent/event/2020/family2020/img_slide1_4.jpg" alt=""></a></div>
			</div>
			<div class="items type-thumb item-240">
				<ul id="itemList1">
					<li>
						<a href="/shopping/category_prd.asp?itemid=2607663">
							<div class="thumbnail"><img src="" alt=""></div>
							<div class="desc">
								<p class="name"></p>
								<p class="price"></p>
							</div>
						</a>
						<div class="etc">
							<div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수"></span></div>
							<div class="tag wish"><span class="icon icon-wish"><i>wish</i></span><span class="counting" title="위시 개수"></span></div>
						</div>
					</li>
					<li>
						<a href="/shopping/category_prd.asp?itemid=2792109">
							<div class="thumbnail"><img src="" alt=""></div>
							<div class="desc">
								<p class="name"></p>
								<p class="price"></p>
							</div>
						</a>
						<div class="etc">
							<div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수"></span></div>
							<div class="tag wish"><span class="icon icon-wish"><i>wish</i></span><span class="counting" title="위시 개수"></span></div>
						</div>
					</li>
					<li>
						<a href="/shopping/category_prd.asp?itemid=2278171">
							<div class="thumbnail"><img src="" alt=""></div>
							<div class="desc">
								<p class="name"></p>
								<p class="price"></p>
							</div>
						</a>
						<div class="etc">
							<div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수"></span></div>
							<div class="tag wish"><span class="icon icon-wish"><i>wish</i></span><span class="counting" title="위시 개수"></span></div>
						</div>
					</li>
					<li>
						<a href="/shopping/category_prd.asp?itemid=2805630">
							<div class="thumbnail"><img src="" alt=""></div>
							<div class="desc">
								<p class="name"></p>
								<p class="price"></p>
							</div>
						</a>
						<div class="etc">
							<div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수"></span></div>
							<div class="tag wish"><span class="icon icon-wish"><i>wish</i></span><span class="counting" title="위시 개수"></span></div>
						</div>
					</li>
					<li>
						<a href="/shopping/category_prd.asp?itemid=2645437">
							<div class="thumbnail"><img src="" alt=""></div>
							<div class="desc">
								<p class="name"></p>
								<p class="price"></p>
							</div>
						</a>
						<div class="etc">
							<div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수"></span></div>
							<div class="tag wish"><span class="icon icon-wish"><i>wish</i></span><span class="counting" title="위시 개수"></span></div>
						</div>
					</li>
					<li>
						<a href="/shopping/category_prd.asp?itemid=2599569">
							<div class="thumbnail"><img src="" alt=""></div>
							<div class="desc">
								<p class="name"></p>
								<p class="price"></p>
							</div>
						</a>
						<div class="etc">
							<div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수"></span></div>
							<div class="tag wish"><span class="icon icon-wish"><i>wish</i></span><span class="counting" title="위시 개수"></span></div>
						</div>
					</li>
					<li>
						<a href="/shopping/category_prd.asp?itemid=2782674">
							<div class="thumbnail"><img src="" alt=""></div>
							<div class="desc">
								<p class="name"></p>
								<p class="price"></p>
							</div>
						</a>
						<div class="etc">
							<div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수"></span></div>
							<div class="tag wish"><span class="icon icon-wish"><i>wish</i></span><span class="counting" title="위시 개수"></span></div>
						</div>
					</li>
					<li>
						<a href="/shopping/category_prd.asp?itemid=2548608">
							<div class="thumbnail"><img src="" alt=""></div>
							<div class="desc">
								<p class="name"></p>
								<p class="price"></p>
							</div>
						</a>
						<div class="etc">
							<div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수"></span></div>
							<div class="tag wish"><span class="icon icon-wish"><i>wish</i></span><span class="counting" title="위시 개수"></span></div>
						</div>
					</li>
					<li>
						<a href="/shopping/category_prd.asp?itemid=2516530">
							<div class="thumbnail"><img src="" alt=""></div>
							<div class="desc">
								<p class="name"></p>
								<p class="price"></p>
							</div>
						</a>
						<div class="etc">
							<div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수"></span></div>
							<div class="tag wish"><span class="icon icon-wish"><i>wish</i></span><span class="counting" title="위시 개수"></span></div>
						</div>
					</li>
					<li>
						<a href="/shopping/category_prd.asp?itemid=2610861">
							<div class="thumbnail"><img src="" alt=""></div>
							<div class="desc">
								<p class="name"></p>
								<p class="price"></p>
							</div>
						</a>
						<div class="etc">
							<div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수"></span></div>
							<div class="tag wish"><span class="icon icon-wish"><i>wish</i></span><span class="counting" title="위시 개수"></span></div>
						</div>
					</li>
					<li>
						<a href="/shopping/category_prd.asp?itemid=2519135">
							<div class="thumbnail"><img src="" alt=""></div>
							<div class="desc">
								<p class="name"></p>
								<p class="price"></p>
							</div>
						</a>
						<div class="etc">
							<div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수"></span></div>
							<div class="tag wish"><span class="icon icon-wish"><i>wish</i></span><span class="counting" title="위시 개수"></span></div>
						</div>
					</li>
					<li>
						<a href="/shopping/category_prd.asp?itemid=2351405">
							<div class="thumbnail"><img src="" alt=""></div>
							<div class="desc">
								<p class="name"></p>
								<p class="price"></p>
							</div>
						</a>
						<div class="etc">
							<div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수"></span></div>
							<div class="tag wish"><span class="icon icon-wish"><i>wish</i></span><span class="counting" title="위시 개수"></span></div>
						</div>
					</li>
				</ul>
			</div>
		</section>
		<%' 상품영역 %>
		<template id="itemlist" v-cloak></template>
		<%' 이벤트영역 %>
		<template id="eventlist" v-cloak></template>
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
<script src="/vue/exhibition/components/item-wishnevaluate.js"></script>
<script src="/vue/exhibition/components/item-list.js"></script>
<script src="/vue/exhibition/components/slideitem-list.js"></script>
<script src="/vue/exhibition/components/event-list.js"></script>
<script src="/vue/exhibition/modules/store.js"></script>
<script src="/vue/exhibition/main/family2020/searchfilter.js"></script>
<script src="/vue/exhibition/main/family2020/mdpicklist.js"></script>
<script src="/vue/exhibition/main/family2020/itemlist.js"></script>
<script src="/vue/exhibition/main/family2020/eventlist.js"></script>
</body>
</html>