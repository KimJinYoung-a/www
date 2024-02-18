<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : 2019 크리스마스 기획전
' History : 2019-11-05 이종화 생성
'####################################################
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
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
%>
<style>[v-cloak] { display: none; }</style>
<link rel="stylesheet" type="text/css" href="/lib/css/xmas2019.css?v=1.04">
<script type="text/javascript" src="/event/etc/json/js_applyItemInfo.js"></script>
<script type="text/javascript">
$(function(){
	$('.xmas2019 .topic').addClass('que');
	var floatingTop = $('.xmas2019').offset().top + 107;
	$('.xmas2019 .bnr-floating').css('top', floatingTop);
	var slider = $('.xmas2019 .slider-wrap .slider');
	function sliderAction (target) {
		var progress = target.siblings('.progressbar').find('.progressbar-fill');
		var pager = target.siblings('.pager');
		target.on('init', function(event, slick) {
			var init = Math.floor(100 / slick.slideCount);
			progress.css('width', init + '%');
			pager.find('span').text(slick.slideCount);
		});
		target.on('beforeChange', function(event, slick, currentSlide, nextSlide) {
			var calc = ( (nextSlide+1) / slick.slideCount ) * 100;
			progress.css('width', calc + '%');
			pager.find('b').text(nextSlide+1);
		});
		target.slick({
			autoplay: true,
			arrows: false
		});
	}
	slider.each(function(){
		sliderAction( $(this) );
	});
	$(window).scroll(function(){
		$('.xmas2019 .take .txt-wrap').each(function(){
			var y = $(window).scrollTop() + $(window).height() * 0.5;
			var txtTop = $(this).offset().top;
			if(y > txtTop) {
				$(this).addClass('que');
			}
		});
	});
	fnApplyItemInfoToTalPriceList({
		items:"2584298,2580851,1688020,2140986,2023635,2546624,2476601,2311368,2123394,2584246",
		target:"itemList1",
		fields:["name","price","sale"],
		unit:"hw",
		saleBracket:false
	});
	fnApplyItemInfoToTalPriceList({
		items:"2568784,2571181,2543028,2564632,2564638,2576083,1611105,1609775,1831398,2571163",
		target:"itemList2",
		fields:["name","price","sale"],
		unit:"hw",
		saleBracket:false
	});
	fnApplyItemInfoToTalPriceList({
		items:"2065460,2519454,2541074,1672546,1552103,2202150,2566671,2568866,2452501,2483131",
		target:"itemList3",
		fields:["name","price","sale"],
		unit:"hw",
		saleBracket:false
	});
});
</script>
<script>
$(function() {
	fnAmplitudeEventMultiPropertiesAction('view_2019christmas_main','','');
})
</script>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container xmas2019">
		<div class="topic">
			<h2>
				<span class="tit-pick"><img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/tit_pick.gif" alt="Pick"></span>
				<img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/tit_your.png" alt="your christmas" class="tit-your">
			</h2>
			<p><img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/txt_intro.png" alt=""></p>
			<span class="deco deco-l">
				<img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/img_deco_l1.png" alt="">
				<img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/img_deco_l2.png" alt="">
				<img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/img_deco_l3.png" alt="">
			</span>
			<span class="deco deco-r">
				<img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/img_deco_r1.png" alt="">
				<img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/img_deco_r2.png" alt="">
				<img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/img_deco_r3.png" alt="">
			</span>
		</div>

		<!-- for dev msg : 마케팅 쿠폰 -->
		<% server.Execute("/christmas/2019/exc_coupon.asp") %>

		<section class="keyword">
			<h3><img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/tit_keyword.png" alt="크리스마스 키워드 2019 CHRISTMAS KEYWORD"></span></h3>
			<div class="tag">
				<a href="/search/search_result.asp?rect=크리스마스&cpg=1&extUrl=&tvsTxt=&gaparam=main_menu_search&sTtxt=크리스마스" class="sch">#크리스마스</a>
				<a href="/search/search_result.asp?rect=벽트리&cpg=1&extUrl=&tvsTxt=&gaparam=main_menu_search&sTtxt=벽트리" class="sch">#벽트리</a>
				<a href="/event/eventmain.asp?eventid=98654" class="evt">#MERRYLIGHT</a>
				<a href="/event/eventmain.asp?eventid=98626" class="evt">#미니트리</a>
				<a href="/search/search_result.asp?rect=가랜드&cpg=1&extUrl=&tvsTxt=&gaparam=main_menu_search&sTtxt=가랜드" class="sch">#가랜드</a>
				<br>
				<a href="/search/search_result.asp?rect=전구&cpg=1&extUrl=&tvsTxt=&gaparam=main_menu_search&sTtxt=전구" class="sch">#전구</a>
				<a href="/event/eventmain.asp?eventid=98627" class="evt">#크리스마스선물</a>
				<a href="/search/search_result.asp?rect=오너먼트&cpg=1&extUrl=&tvsTxt=&gaparam=main_menu_search&sTtxt=오너먼트" class="sch">#오너먼트</a>
				<a href="/event/eventmain.asp?eventid=98630" class="evt">#크리스마스카드</a>
				<a href="/event/eventmain.asp?eventid=98631" class="evt">#파티</a>
			</div>
		</section>

		<section class="take">
			<div class="take1 type-a">
				<div class="main-img">
					<p><img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/img_take1_1.jpg" alt=""></p>
					<ul class="link">
						<li class="l1"><a href="/shopping/category_prd.asp?itemid=2464507"></a></li>
						<li class="l2"><a href="/shopping/category_prd.asp?itemid=2027505"></a></li>
						<li class="l3"><a href="/shopping/category_prd.asp?itemid=2374389"></a></li>
						<li class="l4"><a href="/shopping/category_prd.asp?itemid=1903415"></a></li>
						<li class="l5"><a href="/shopping/category_prd.asp?itemid=2430593"></a></li>
						<li class="l6"><a href="/shopping/category_prd.asp?itemid=2274404"></a></li>
					</ul>
				</div>
				<div class="txt-wrap">
					<p><img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/tit_take_01.png" alt="Take 1. On the table"></p>
					<p><img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/txt_take_01.png" alt="시선 닿는 곳마다 크리스마스"></p>
				</div>
				<div class="img img2"><a href="/shopping/category_prd.asp?itemid=2581264"><img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/img_take1_2.jpg" alt=""></a></div>
				<div class="img img3"><a href="/shopping/category_prd.asp?itemid=2464507"><img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/img_take1_3.jpg" alt=""></a></div>
				<div class="slider-wrap">
					<div class="slider">
						<div class="slide">
							<a href="/shopping/category_prd.asp?itemid=1958525"><img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/img_slide1_1_1.jpg" alt=""></a>
							<a href="/shopping/category_prd.asp?itemid=2580838"><img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/img_slide1_1_2.jpg" alt=""></a>
						</div>
						<div class="slide">
							<a href="/shopping/category_prd.asp?itemid=2581263"><img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/img_slide1_2_1.jpg" alt=""></a>
							<a href="/shopping/category_prd.asp?itemid=2580857"><img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/img_slide1_2_2.jpg" alt=""></a>
						</div>
						<div class="slide">
							<a href="/shopping/category_prd.asp?itemid=2274404"><img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/img_slide1_3_1.jpg" alt=""></a>
							<a href="/shopping/category_prd.asp?itemid=2580851"><img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/img_slide1_3_2.jpg" alt=""></a>
						</div>
					</div>
					<div class="progressbar"><span class="progressbar-fill"></span></div>
					<div class="pager"><b>1</b><i>/</i><span>3</span></div>
				</div>
				<div class="prd-wrap">
					<ul id="itemList1">
						<li>
							<a href="/shopping/category_prd.asp?itemid=2584298">
								<div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/img_item1_01.jpg" alt=""></div>
								<div class="desc">
									<p class="name">상품명</p>
									<p class="price"><s>36,400</s> 32,030원<span>12%</span></p>
								</div>
							</a>
						</li>
						<li>
							<a href="/shopping/category_prd.asp?itemid=2580851">
								<div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/img_item1_02.jpg" alt=""></div>
								<div class="desc">
									<p class="name">상품명</p>
									<p class="price"><s>36,400</s> 32,030원<span>12%</span></p>
								</div>
							</a>
						</li>
						<li>
							<a href="/shopping/category_prd.asp?itemid=1688020">
								<div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/img_item1_03.jpg" alt=""></div>
								<div class="desc">
									<p class="name">상품명</p>
									<p class="price"><s>36,400</s> 32,030원<span>12%</span></p>
								</div>
							</a>
						</li>
						<li>
							<a href="/shopping/category_prd.asp?itemid=2140986">
								<div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/img_item1_04.jpg" alt=""></div>
								<div class="desc">
									<p class="name">상품명</p>
									<p class="price"><s>36,400</s> 32,030원<span>12%</span></p>
								</div>
							</a>
						</li>
						<li>
							<a href="/shopping/category_prd.asp?itemid=2023635">
								<div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/img_item1_05.jpg" alt=""></div>
								<div class="desc">
									<p class="name">상품명</p>
									<p class="price"><s>36,400</s> 32,030원<span>12%</span></p>
								</div>
							</a>
						</li>
						<li>
							<a href="/shopping/category_prd.asp?itemid=2546624">
								<div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/img_item1_06.jpg" alt=""></div>
								<div class="desc">
									<p class="name">상품명</p>
									<p class="price"><s>36,400</s> 32,030원<span>12%</span></p>
								</div>
							</a>
						</li>
						<li>
							<a href="/shopping/category_prd.asp?itemid=2476601">
								<div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/img_item1_07.jpg" alt=""></div>
								<div class="desc">
									<p class="name">상품명</p>
									<p class="price"><s>36,400</s> 32,030원<span>12%</span></p>
								</div>
							</a>
						</li>
						<li>
							<a href="/shopping/category_prd.asp?itemid=2311368">
								<div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/img_item1_08.jpg" alt=""></div>
								<div class="desc">
									<p class="name">상품명</p>
									<p class="price"><s>36,400</s> 32,030원<span>12%</span></p>
								</div>
							</a>
						</li>
						<li>
							<a href="/shopping/category_prd.asp?itemid=2123394">
								<div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/img_item1_09.jpg" alt=""></div>
								<div class="desc">
									<p class="name">상품명</p>
									<p class="price"><s>36,400</s> 32,030원<span>12%</span></p>
								</div>
							</a>
						</li>
						<li>
							<a href="/shopping/category_prd.asp?itemid=2584246">
								<div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/img_item1_10.jpg" alt=""></div>
								<div class="desc">
									<p class="name">상품명</p>
									<p class="price"><s>36,400</s> 32,030원<span>12%</span></p>
								</div>
							</a>
						</li>
					</ul>
				</div>
			</div>
			<div class="take2 type-b">
				<div class="main-img">
					<p><img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/img_take2_1.jpg" alt=""></p>
					<ul class="link">
						<li class="l1"><a href="/shopping/category_prd.asp?itemid=2564639"></a></li>
					</ul>
				</div>
				<div class="txt-wrap">
					<p><img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/tit_take_02.png" alt="Take 2. Wall decoration"></p>
					<p><img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/txt_take_02.png" alt="오늘부터 크리스마스"></p>
				</div>
				<div class="img img2"><a href="/shopping/category_prd.asp?itemid=2084384"><img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/img_take2_2.jpg" alt=""></a></div>
				<div class="img img3"><a href="/shopping/category_prd.asp?itemid=2580838"><img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/img_take2_3.jpg" alt=""></a></div>
				<div class="slider-wrap">
					<div class="slider">
						<div class="slide">
							<a href="/shopping/category_prd.asp?itemid=2568784"><img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/img_slide2_1_1.jpg" alt=""></a>
							<a href="/shopping/category_prd.asp?itemid=2580851"><img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/img_slide2_1_2.jpg" alt=""></a>
						</div>
						<div class="slide">
							<a href="/shopping/category_prd.asp?itemid=2143326"><img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/img_slide2_2_1.jpg" alt=""></a>
							<a href="/shopping/category_prd.asp?itemid=2145656"><img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/img_slide2_2_2.jpg" alt=""></a>
						</div>
						<div class="slide">
							<a href="/shopping/category_prd.asp?itemid=2564639"><img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/img_slide2_3.jpg" alt=""></a>
						</div>
					</div>
					<div class="progressbar"><span class="progressbar-fill"></span></div>
					<div class="pager"><b>1</b><i>/</i><span>3</span></div>
				</div>
				<div class="prd-wrap">
					<ul id="itemList2">
						<li>
							<a href="/shopping/category_prd.asp?itemid=2568784">
								<div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/img_item2_01.jpg" alt=""></div>
								<div class="desc">
									<p class="name">상품명</p>
									<p class="price"><s>36,400</s> 32,030원<span>12%</span></p>
								</div>
							</a>
						</li>
						<li>
							<a href="/shopping/category_prd.asp?itemid=2571181">
								<div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/img_item2_02.jpg" alt=""></div>
								<div class="desc">
									<p class="name">상품명</p>
									<p class="price"><s>36,400</s> 32,030원<span>12%</span></p>
								</div>
							</a>
						</li>
						<li>
							<a href="/shopping/category_prd.asp?itemid=2543028">
								<div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/img_item2_03.jpg" alt=""></div>
								<div class="desc">
									<p class="name">상품명</p>
									<p class="price"><s>36,400</s> 32,030원<span>12%</span></p>
								</div>
							</a>
						</li>
						<li>
							<a href="/shopping/category_prd.asp?itemid=2564632">
								<div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/img_item2_04.jpg" alt=""></div>
								<div class="desc">
									<p class="name">상품명</p>
									<p class="price"><s>36,400</s> 32,030원<span>12%</span></p>
								</div>
							</a>
						</li>
						<li>
							<a href="/shopping/category_prd.asp?itemid=2564638">
								<div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/img_item2_05.jpg" alt=""></div>
								<div class="desc">
									<p class="name">상품명</p>
									<p class="price"><s>36,400</s> 32,030원<span>12%</span></p>
								</div>
							</a>
						</li>
						<li>
							<a href="/shopping/category_prd.asp?itemid=2576083">
								<div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/img_item2_06.jpg" alt=""></div>
								<div class="desc">
									<p class="name">상품명</p>
									<p class="price"><s>36,400</s> 32,030원<span>12%</span></p>
								</div>
							</a>
						</li>
						<li>
							<a href="/shopping/category_prd.asp?itemid=1611105">
								<div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/img_item2_07.jpg" alt=""></div>
								<div class="desc">
									<p class="name">상품명</p>
									<p class="price"><s>36,400</s> 32,030원<span>12%</span></p>
								</div>
							</a>
						</li>
						<li>
							<a href="/shopping/category_prd.asp?itemid=1609775">
								<div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/img_item2_08.jpg" alt=""></div>
								<div class="desc">
									<p class="name">상품명</p>
									<p class="price"><s>36,400</s> 32,030원<span>12%</span></p>
								</div>
							</a>
						</li>
						<li>
							<a href="/shopping/category_prd.asp?itemid=1831398">
								<div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/img_item2_09.jpg" alt=""></div>
								<div class="desc">
									<p class="name">상품명</p>
									<p class="price"><s>36,400</s> 32,030원<span>12%</span></p>
								</div>
							</a>
						</li>
						<li>
							<a href="/shopping/category_prd.asp?itemid=2571163">
								<div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/img_item2_10.jpg" alt=""></div>
								<div class="desc">
									<p class="name">상품명</p>
									<p class="price"><s>36,400</s> 32,030원<span>12%</span></p>
								</div>
							</a>
						</li>
					</ul>
				</div>
			</div>
			<div class="take3 type-a">
				<div class="main-img">
					<p><img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/img_take3_1.jpg" alt=""></p>
					<ul class="link">
						<li class="l1"><a href="/shopping/category_prd.asp?itemid=1786079"></a></li>
					</ul>
				</div>
				<div class="txt-wrap">
					<p><img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/tit_take_03.png" alt="Take 3. For someone"></p>
					<p><img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/txt_take_03.png" alt="올해는 부끄러워하지 말기"></p>
				</div>
				<div class="img img2"><a href="/shopping/category_prd.asp?itemid=2374389"><img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/img_take3_2.jpg" alt=""></a></div>
				<div class="img img3"><a href="/shopping/category_prd.asp?itemid=2316435"><img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/img_take3_3.jpg" alt=""></a></div>
				<div class="slider-wrap">
					<div class="slider">
						<div class="slide">
							<a href="/shopping/category_prd.asp?itemid=1836968"><img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/img_slide3_1_1.jpg" alt=""></a>
							<a href="/shopping/category_prd.asp?itemid=2139418"><img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/img_slide3_1_2.jpg" alt=""></a>
						</div>
						<div class="slide">
							<a href="/shopping/category_prd.asp?itemid=1786079"><img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/img_slide3_2.jpg" alt=""></a>
						</div>
					</div>
					<div class="progressbar"><span class="progressbar-fill"></span></div>
					<div class="pager"><b>1</b><i>/</i><span>2</span></div>
				</div>
				<div class="prd-wrap">
					<ul id="itemList3">
						<li>
							<a href="/shopping/category_prd.asp?itemid=2065460">
								<div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/img_item3_01.jpg" alt=""></div>
								<div class="desc">
									<p class="name">상품명</p>
									<p class="price"><s>36,400</s> 32,030원<span>12%</span></p>
								</div>
							</a>
						</li>
						<li>
							<a href="/shopping/category_prd.asp?itemid=2519454">
								<div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/img_item3_02.jpg" alt=""></div>
								<div class="desc">
									<p class="name">상품명</p>
									<p class="price"><s>36,400</s> 32,030원<span>12%</span></p>
								</div>
							</a>
						</li>
						<li>
							<a href="/shopping/category_prd.asp?itemid=2541074">
								<div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/img_item3_03.jpg" alt=""></div>
								<div class="desc">
									<p class="name">상품명</p>
									<p class="price"><s>36,400</s> 32,030원<span>12%</span></p>
								</div>
							</a>
						</li>
						<li>
							<a href="/shopping/category_prd.asp?itemid=1672546">
								<div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/img_item3_04.jpg" alt=""></div>
								<div class="desc">
									<p class="name">상품명</p>
									<p class="price"><s>36,400</s> 32,030원<span>12%</span></p>
								</div>
							</a>
						</li>
						<li>
							<a href="/shopping/category_prd.asp?itemid=1552103">
								<div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/img_item3_05.jpg" alt=""></div>
								<div class="desc">
									<p class="name">상품명</p>
									<p class="price"><s>36,400</s> 32,030원<span>12%</span></p>
								</div>
							</a>
						</li>
						<li>
							<a href="/shopping/category_prd.asp?itemid=2202150">
								<div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/img_item3_06.jpg" alt=""></div>
								<div class="desc">
									<p class="name">상품명</p>
									<p class="price"><s>36,400</s> 32,030원<span>12%</span></p>
								</div>
							</a>
						</li>
						<li>
							<a href="/shopping/category_prd.asp?itemid=2566671">
								<div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/img_item3_07.jpg" alt=""></div>
								<div class="desc">
									<p class="name">상품명</p>
									<p class="price"><s>36,400</s> 32,030원<span>12%</span></p>
								</div>
							</a>
						</li>
						<li>
							<a href="/shopping/category_prd.asp?itemid=2568866">
								<div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/img_item3_08.jpg" alt=""></div>
								<div class="desc">
									<p class="name">상품명</p>
									<p class="price"><s>36,400</s> 32,030원<span>12%</span></p>
								</div>
							</a>
						</li>
						<li>
							<a href="/shopping/category_prd.asp?itemid=2452501">
								<div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/img_item3_09.jpg" alt=""></div>
								<div class="desc">
									<p class="name">상품명</p>
									<p class="price"><s>36,400</s> 32,030원<span>12%</span></p>
								</div>
							</a>
						</li>
						<li>
							<a href="/shopping/category_prd.asp?itemid=2483131">
								<div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/img_item3_10.jpg" alt=""></div>
								<div class="desc">
									<p class="name">상품명</p>
									<p class="price"><s>36,400</s> 32,030원<span>12%</span></p>
								</div>
							</a>
						</li>
					</ul>
				</div>
			</div>
		</section>

		<section class="lookbook">
			<h3><img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/tit_lookbook.png" alt="CHRISTMAS LOOKBOOK"></h3>
			<div class="img">
				<p><img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/img_lookbook_v2.jpg" alt=""></p>
				<ul class="link">
					<li class="l1"><a href="/shopping/category_prd.asp?itemid=2430593"></a></li>
					<li class="l2"><a href="/shopping/category_prd.asp?itemid=2580851"></a></li>
					<li class="l3"><a href="/shopping/category_prd.asp?itemid=1958525"></a></li>
					<li class="l4"><a href="/shopping/category_prd.asp?itemid=2581389"></a></li>
					<li class="l5"><a href="/shopping/category_prd.asp?itemid=2580838"></a></li>
					<li class="l6"><a href="/shopping/category_prd.asp?itemid=2580857"></a></li>
					<li class="l7"><a href="/shopping/category_prd.asp?itemid=2580857"></a></li>
				</ul>
			</div>
		</section>

		<%' 상품영역 %>
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
<script src="/vue/exhibition/components/item-list.js"></script>
<script src="/vue/exhibition/components/searchfilter.js"></script>
<script src="/vue/exhibition/modules/store.js"></script>
<script src="/vue/exhibition/main/christmas2019/index.js"></script>
</body>
</html>