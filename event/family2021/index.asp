<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : 가정의달 기획전 - JAVA 버전
' History : 2021-04-05 김형태 생성
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
    <link rel="stylesheet" type="text/css" href="./family2021.css?v=1.02">
    <script type="text/javascript" src="/event/etc/json/js_applyItemInfo.js"></script>
    <style>[v-cloak] { display: none; }</style>
    <script>
        $(function() {
            fnAmplitudeEventMultiPropertiesAction('view_family2020_main','','');

            // 카테고리 타이틀 모션
            	var tab = $('.family2021 .tab-wrap');
            	$(window).on('scroll', function(e) {
            		var st = $(window).scrollTop() + $(window).height() * .5;
            		if (st > tab.offset().top) tab.children('h3').addClass('on');
            	});

            // 탭 전환 시 키워드 이미지 교체
            $(".family2021 .tab-nav label").on('click', function(e) {
                var idx = $(this).parent('li').index();
                if (idx !== 0) {
                    $('.family2021 .keyword').show();
                    var url = '//webimage.10x10.co.kr/fixevent/event/2021/family/txt_kwd_0' + idx + '.png';
                    $('.family2021 .keyword img').attr('src', url);
                } else {
                    $('.family2021 .keyword').hide();
                }
            });
            // slider
            $(".family2021 .slider").slick({
                variableWidth: true,
                centerMode: true,
                autoplay: true,
                speed: 1000
            });
            fnApplyItemInfoToTalPriceList({
                items:"3733127,2336227,3134662,3590014,3189536,2324242,3740960,2748236",
                target:"itemList1",
                fields:["image","name","price","sale","wish","evaluate"],
                unit:"hw",
                saleBracket:false
            });
            fnApplyItemInfoToTalPriceList({
                items:"2702544,2588063,2772222,2769488,2521749,3708850,3572235,3714609",
                target:"itemList2",
                fields:["image","name","price","sale","wish","evaluate"],
                unit:"hw",
                saleBracket:false
            });
            fnApplyItemInfoToTalPriceList({
                items:"2792013,3723926,3675412,2617693,3748587,2905508,1646098,3549960",
                target:"itemList3",
                fields:["image","name","price","sale","wish","evaluate"],
                unit:"hw",
                saleBracket:false
            });
            fnApplyItemInfoToTalPriceList({
                items:"3101505,3726255,2147178,2397582,2704898,3248594,2322954,2942128",
                target:"itemList4",
                fields:["image","name","price","sale","wish","evaluate"],
                unit:"hw",
                saleBracket:false
            });
        });
    </script>
    <div class="wrap">
        <!-- #include virtual="/lib/inc/incHeader.asp" -->
        <div class="container family2021">
            <div class="topic"><h2>2021 가정의달 기획전</h2></div>
            <p class="intro"><img src="//webimage.10x10.co.kr/fixevent/event/2021/family/txt_intro.png" alt="표현하고 싶은 고마운 마음" class="vTop"></p>
            <!-- 퍼블 수작업 영역 -->
            <section class="section s1">
                <div class="topic">
                    <h3><img src="//webimage.10x10.co.kr/fixevent/event/2021/family/tit_s01.png" alt="부모님 스승님"></h3>
                    <span class="num"><img src="//webimage.10x10.co.kr/fixevent/event/2021/family/txt_s01.png" alt="01"></span>
                </div>
                <div class="slider">
                    <div><a href="/shopping/category_prd.asp?itemid=2820179"><img src="//webimage.10x10.co.kr/fixevent/event/2021/family/img_slide1_1.jpg" alt=""></a></div>
                    <div><a href="/shopping/category_prd.asp?itemid=2820178"><img src="//webimage.10x10.co.kr/fixevent/event/2021/family/img_slide1_2.jpg" alt=""></a></div>
                    <div><a href="/shopping/category_prd.asp?itemid=2332827"><img src="//webimage.10x10.co.kr/fixevent/event/2021/family/img_slide1_3.jpg" alt=""></a></div>
                    <div><a href="/shopping/category_prd.asp?itemid=3006026"><img src="//webimage.10x10.co.kr/fixevent/event/2021/family/img_slide1_4.jpg" alt=""></a></div>
                </div>
                <div class="items type-thumb item-240">
                    <ul id="itemList1">
                        <li>
                            <a href="/shopping/category_prd.asp?itemid=3733127">
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
                            <a href="/shopping/category_prd.asp?itemid=2336227">
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
                            <a href="/shopping/category_prd.asp?itemid=3134662">
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
                            <a href="/shopping/category_prd.asp?itemid=3590014">
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
                            <a href="/shopping/category_prd.asp?itemid=3189536">
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
                            <a href="/shopping/category_prd.asp?itemid=2324242">
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
                            <a href="/shopping/category_prd.asp?itemid=3740960">
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
                            <a href="/shopping/category_prd.asp?itemid=2748236">
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
            <section class="section s2">
                <div class="topic">
                    <h3><img src="//webimage.10x10.co.kr/fixevent/event/2021/family/tit_s02.png" alt="우리 아이 조카"></h3>
                    <span class="num"><img src="//webimage.10x10.co.kr/fixevent/event/2021/family/txt_s02.png" alt="02"></span>
                </div>
                <div class="slider">
                    <div><a href="/shopping/category_prd.asp?itemid=3724935"><img src="//webimage.10x10.co.kr/fixevent/event/2021/family/img_slide2_1.jpg" alt=""></a></div>
                    <div><a href="/shopping/category_prd.asp?itemid=3732511"><img src="//webimage.10x10.co.kr/fixevent/event/2021/family/img_slide2_2.jpg" alt=""></a></div>
                    <div><a href="/shopping/category_prd.asp?itemid=3543731"><img src="//webimage.10x10.co.kr/fixevent/event/2021/family/img_slide2_3.jpg" alt=""></a></div>
                    <div><a href="/shopping/category_prd.asp?itemid=3641502"><img src="//webimage.10x10.co.kr/fixevent/event/2021/family/img_slide2_4.jpg" alt=""></a></div>
                </div>
                <div class="items type-thumb item-240">
                    <ul id="itemList2">
                        <li>
                            <a href="/shopping/category_prd.asp?itemid=2702544">
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
                            <a href="/shopping/category_prd.asp?itemid=2588063">
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
                            <a href="/shopping/category_prd.asp?itemid=2772222">
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
                            <a href="/shopping/category_prd.asp?itemid=2769488">
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
                            <a href="/shopping/category_prd.asp?itemid=2521749">
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
                            <a href="/shopping/category_prd.asp?itemid=3708850">
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
                            <a href="/shopping/category_prd.asp?itemid=3572235">
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
                            <a href="/shopping/category_prd.asp?itemid=3714609">
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
            <section class="section s3">
                <div class="topic">
                    <h3><img src="//webimage.10x10.co.kr/fixevent/event/2021/family/tit_s03.png" alt="커플 부부"></h3>
                    <span class="num"><img src="//webimage.10x10.co.kr/fixevent/event/2021/family/txt_s03.png" alt="03"></span>
                </div>
                <div class="slider">
                    <div><a href="/shopping/category_prd.asp?itemid=3147005"><img src="//webimage.10x10.co.kr/fixevent/event/2021/family/img_slide3_1.jpg" alt=""></a></div>
                    <div><a href="/shopping/category_prd.asp?itemid=2797702"><img src="//webimage.10x10.co.kr/fixevent/event/2021/family/img_slide3_2.jpg" alt=""></a></div>
                    <div><a href="/shopping/category_prd.asp?itemid=3698504"><img src="//webimage.10x10.co.kr/fixevent/event/2021/family/img_slide3_3.jpg" alt=""></a></div>
                    <div><a href="/shopping/category_prd.asp?itemid=3489354"><img src="//webimage.10x10.co.kr/fixevent/event/2021/family/img_slide3_4.jpg" alt=""></a></div>
                </div>
                <div class="items type-thumb item-240">
                    <ul id="itemList3">
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
                            <a href="/shopping/category_prd.asp?itemid=3723926">
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
                            <a href="/shopping/category_prd.asp?itemid=3675412">
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
                            <a href="/shopping/category_prd.asp?itemid=2617693">
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
                            <a href="/shopping/category_prd.asp?itemid=3748587">
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
                            <a href="/shopping/category_prd.asp?itemid=2905508">
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
                            <a href="/shopping/category_prd.asp?itemid=1646098">
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
                            <a href="/shopping/category_prd.asp?itemid=3549960">
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
            <section class="section s4">
                <div class="topic">
                    <h3><img src="//webimage.10x10.co.kr/fixevent/event/2021/family/tit_s04.png" alt="스무살"></h3>
                    <span class="num"><img src="//webimage.10x10.co.kr/fixevent/event/2021/family/txt_s04.png" alt="04"></span>
                </div>
                <div class="slider">
                    <div><a href="/shopping/category_prd.asp?itemid=3482036"><img src="//webimage.10x10.co.kr/fixevent/event/2021/family/img_slide4_1.jpg" alt=""></a></div>
                    <div><a href="/shopping/category_prd.asp?itemid=3666162"><img src="//webimage.10x10.co.kr/fixevent/event/2021/family/img_slide4_2.jpg" alt=""></a></div>
                    <div><a href="/shopping/category_prd.asp?itemid=3666567"><img src="//webimage.10x10.co.kr/fixevent/event/2021/family/img_slide4_3.jpg" alt=""></a></div>
                    <div><a href="/shopping/category_prd.asp?itemid=3106422"><img src="//webimage.10x10.co.kr/fixevent/event/2021/family/img_slide4_4.jpg" alt=""></a></div>
                </div>
                <div class="items type-thumb item-240">
                    <ul id="itemList4">
                        <li>
                            <a href="/shopping/category_prd.asp?itemid=3101505">
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
                            <a href="/shopping/category_prd.asp?itemid=3726255">
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
                            <a href="/shopping/category_prd.asp?itemid=2147178">
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
                            <a href="/shopping/category_prd.asp?itemid=2397582">
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
                            <a href="/shopping/category_prd.asp?itemid=2704898">
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
                            <a href="/shopping/category_prd.asp?itemid=3248594">
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
                            <a href="/shopping/category_prd.asp?itemid=2322954">
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
                            <a href="/shopping/category_prd.asp?itemid=2942128">
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

            <template id="itemlist" v-cloak></template>
            
            <!-- 기획전 -->
            <section class="evt-wrap">
                <h3>EVENTS</h3>
                <ul class="evt-list">
                    <li><a href="/event/eventmain.asp?eventid=110563"><img src="//webimage.10x10.co.kr/fixevent/event/2021/family/img_evt_01.png" alt="어버이날"></a></li>
                    <li><a href="/event/eventmain.asp?eventid=110295"><img src="//webimage.10x10.co.kr/fixevent/event/2021/family/img_evt_02.png" alt="어린이날"></a></li>
                    <li><a href="/event/eventmain.asp?eventid=110470"><img src="//webimage.10x10.co.kr/fixevent/event/2021/family/img_evt_03.png" alt="로즈데이"></a></li>
                    <li><a href="/event/eventmain.asp?eventid=110528"><img src="//webimage.10x10.co.kr/fixevent/event/2021/family/img_evt_04.png" alt="부부의날"></a></li>
                </ul>
            </section>
            <!-- //기획전 -->
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

    <!--Common Components-->
    <script src="/vue/components/common/functions/common.js?v=1.00"></script>
    <!--End Common Components-->

    <script src="/vue/exhibition/components/pagination.js"></script>
    <script src="/vue/exhibition/components/item-wishnevaluate.js"></script>
    <script src="/vue/exhibition/components/item-list_V2.js"></script>
    <script src="/vue/exhibition/modules/store_V2.js?v=0.01"></script>
    <script src="/vue/exhibition/main/family2021/searchFilter.js"></script>
    <script src="/vue/exhibition/main/family2021/itemlist.js"></script>
</body>
</html>