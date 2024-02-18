<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<%
'####################################################
' Description : 추석 기획전 정담추석
' History : 2020-08-26 조경애
'####################################################

	Dim today_code, currentDate
	currentDate = date()
	'currentDate = "2020-06-15"
	today_code = "000"

	if currentdate >= "2020-08-26" AND currentdate <= "2020-08-31" Then
		today_code = "1881035"
	ElseIf currentdate = "2020-09-01" Then
		today_code = "1596901"
	ElseIf currentdate = "2020-09-02" Then
        today_code = "3155560"
    ElseIf currentdate = "2020-09-03" Then
        today_code = "2063632"
    ElseIf currentdate = "2020-09-04" Then
        today_code = "2452641"
    ElseIf currentdate = "2020-09-05" Then
        today_code = "2835760"
    ElseIf currentdate = "2020-09-06" Then
        today_code = "1616984"
    ElseIf currentdate = "2020-09-07" Then
        today_code = "1891858"
    ElseIf currentdate = "2020-09-08" Then
        today_code = "3176200"
    ElseIf currentdate = "2020-09-09" Then
        today_code = "3116416"
    ElseIf currentdate = "2020-09-10" Then
        today_code = "1781907"
    ElseIf currentdate = "2020-09-11" Then
        today_code = "3136956"
    ElseIf currentdate = "2020-09-12" Then
        today_code = "1638559"
    ElseIf currentdate = "2020-09-13" Then
        today_code = "3136959"
    ElseIf currentdate = "2020-09-14" Then
        today_code = "3134662"
    ElseIf currentdate = "2020-09-15" Then
        today_code = "2201871"
    ElseIf currentdate = "2020-09-16" Then
        today_code = "1781907"
    ElseIf currentdate = "2020-09-17" Then
        today_code = "1253348"
    ElseIf currentdate = "2020-09-18" Then
        today_code = "2467072"
    ElseIf currentdate = "2020-09-19" Then
        today_code = "1881035"
    ElseIf currentdate = "2020-09-20" Then
        today_code = "1596901"
    ElseIf currentdate = "2020-09-21" Then
        today_code = "2041233"
    ElseIf currentdate = "2020-09-22" Then
        today_code = "2073519"
    ElseIf currentdate = "2020-09-23" Then
        today_code = "3206903"
    ElseIf currentdate = "2020-09-24" Then
        today_code = "3200960"
    ElseIf currentdate = "2020-09-25" Then
		today_code = "3177120"
	End If
%>
<script type="text/javascript" src="/event/lib/countdownforevent.js"></script>
<script type="text/javascript" src="/event/etc/json/js_applyItemInfo.js"></script>
<script>
$(function(){
    $('.topic').addClass('on');
    fnApplyToTalPriceItem({
        items:<%=today_code%>,
        target:"todayitem",
        fields:["image","name","price","sale"],
        unit:"none",
        saleBracket:false
    });

    $('.swiper1').slick({
		autoplay:false,
        fade:true,
		speed:800,
        arrows:true,
        dots:true
	});
    $('.swiper2').slick({
		autoplay:false,
        fade:true,
		speed:800,
        arrows:true,
        dots:true
	});
    $('.swiper3').slick({
		autoplay:false,
        fade:true,
		speed:800,
        arrows:true,
        dots:true
	});

	var tabTop = $(".topic .sub").offset().top;
	$(window).scroll(function(){
		var y = $(window).scrollTop();
		if ( tabTop <= y ) {
			$(".btn-today").addClass("sticky");
		} else {
			$(".btn-today").removeClass("sticky");
		}
	});
    
    $(".btn-today").click(function(e){
		e.preventDefault();
		$('html,body').animate({scrollTop:$(this.hash).offset().top},1000);
	});

    $(".itemcode").each(function(){
        var e = $(this);
        for (var i = 0; i < 7; i++) {
        e.clone().insertAfter(e);
        }
    });
    var codes = [
    3134662,3143158,1881035,2365125,3006023,2824023,2063632,2806773,
    1552103,1616984,2835760,2644354,1212217,3146544,1862657,2201871,
    3136959,1596901,2720316,3059626,3153559,2452641,3155163,1285004];
	var i = 0;
	var url1,url2,cls1,cls2 = "";
	$(".item-list li:visible").each(function(){
		url1 = $(this).find("a").attr("href");
		url2 = url1.replace("code",codes[i]);
		$(this).find("a").attr("href",url2);
		cls1 = $(this).attr("class");
		cls2 = cls1.replace("code",codes[i]);
		$(this).attr("class",cls2);
		i++;
	});

    fnApplyToTalPriceItem({
		items:codes.slice(0,8),
		target:"item",
		fields:["image","name","price","sale","soldout"],
		unit:"none",
		saleBracket:false
	});
    fnApplyToTalPriceItem({
		items:codes.slice(8,16),
		target:"item",
		fields:["image","name","price","sale","soldout"],
		unit:"none",
		saleBracket:false
	});
    fnApplyToTalPriceItem({
		items:codes.slice(16,24),
		target:"item",
		fields:["image","name","price","sale","soldout"],
		unit:"none",
		saleBracket:false
	});
    
    // 관련이벤트
    activeItem = $(".rtd-event li:first");
	$(activeItem).addClass('active');
	$(".rtd-event li").hover(function(){
		$(".rtd-event li").removeClass("hover");
		$(this).addClass("hover");
		$(activeItem).animate({width:"86px"},{duration:300, queue:false});
		$(this).animate({width:"796px"},{duration:300, queue:false});
		activeItem = this;
	});
    countDownEventTimer({
        eventid:105176,
        useDay: true
    });
});
</script>
<style>
.jungdam {background:#fff;}
.jungdam .section {position:relative; background-position:50% 0; background-repeat:no-repeat;}
.jungdam a {text-decoration:none;}
.jungdam map area {outline:0;}
.jungdam .name {overflow:hidden; padding-bottom:12px; font-size:16px;  color:#222; text-overflow:ellipsis; white-space:nowrap;}
.jungdam .price {display:inline-block; font-size:18px; color:#ff2241;}
.jungdam .price:after {content:'원'}
.jungdam .price s {display:block; color:#5d5d5d; font-size:16px; text-decoration:none;}
.jungdam .price span {float:left; padding-right:10px;}
.jungdam .btn-more {position:absolute; left:50%; bottom:126px; width:314px; height:95px; margin-left:-157px; text-indent:-999em;}
.jungdam .swiper {width:1220px; height:750px; margin:0 auto;}
.jungdam .slick-arrow {position:absolute; left:47px; top:50%; width:47px; height:78px; margin-top:-39px; background:url(//webimage.10x10.co.kr/fixevent/event/2020/105176/btn_arrow.png) 50% 50% no-repeat;}
.jungdam .slick-next {left:auto; right:47px; transform:rotate(180deg);}
.jungdam .slick-dots {padding-top:30px;}
.jungdam .slick-dots li {padding:0 10px;}
.jungdam .slick-dots button {width:15px; height:15px; background:#d4bbb3; border-radius:50%;}
.jungdam .slick-dots .slick-active button {background:#ff8972;}
.jungdam .item-list {width:1000px; margin:0 auto; padding-top:115px;}
.jungdam .item-list li {float:left; width:220px; height:366px; margin:0 10px;}
.jungdam .item-list .thumbnail {position:relative; width:220px; height:220px;}
.jungdam .item-list .thumbnail img {width:100%;}
.jungdam .item-list .thumbnail .ico-soldout {display:none; position:absolute; top:0; left:0; right:0; bottom:0; justify-content: center; align-items:center; width:100%; height:100%; color:#fff; text-align:center; font-size:16px; background-color: rgba(0, 0, 0, 0.5); }
.jungdam .item-list .thumbnail .ico-soldout span:before {content: ''; display:block; width:104px; height:104px; margin-bottom:5px; background-position: -625px 0; background-image: url(//fiximage.10x10.co.kr/web2019/diary2020/ico.svg?v=1.08); background-size:740px;}
.jungdam .item-list .soldout .thumbnail .ico-soldout {display:flex; z-index:10;}
.jungdam .item-list .desc {text-align:left; padding:18px 10px 0; line-height:1.2; font-weight:bold;}
.jungdam .item-list .desc .price s {padding-bottom:4px; font-weight:400;}

.topic {height:800px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2020/105176/bg_topic.jpg);}
.topic h2 {position:absolute; left:50%; top:136px; margin-left:-43px;}
.topic h2 img {position:absolute; left:0; top:0;}
.topic .sub {position:absolute; left:50%; top:635px; margin-left:-145px;}
.topic .deco img {position:absolute; left:50%; top:152px; margin-left:-490px;}
.topic .deco img:nth-child(2) {top:271px; margin-left:64px;}
.topic .deco img:nth-child(3) {top:190px; margin-left:597px;}
.topic h2 img,.topic .sub,.topic .deco img {transition:all 1.8s;}
.topic h2 img {opacity:0; transform:translateX(20px);}
.topic h2 img:nth-child(2),.topic h2 img:nth-child(4) {transform:translateX(-20px);}
.topic .sub {opacity:0; transform:translateY(10px); transition:all 1s 1s;}
.topic.on h2 img {opacity:1; transform:translateX(0);}
.topic.on p {opacity:1; transform:translateY(0);}
.topic .today {position:absolute; left:50%; top:123px; width:190px; height:320px; margin-left:304px;}
.topic .today a {display:block; height:100%; text-decoration:none; font-size:16px; font-weight:600; line-height:1.1;}
.topic .today .name {padding:16px 5px 12px;}
.topic .today .price {font-size:16px;}
.topic .today .price:after {font-weight:400;}
.topic .today .price s {display:inline-block; float:left; font-size:16px; padding-right:15px; color:#989898; font-weight:400;}
.topic .today .price span {padding-right:6px;}
.topic .today .time {position:absolute; left:0; bottom:0; z-index:10; width:92px; height:38px; padding-left:98px; font:500 16px/38px verdana; text-align:left; color:#fff; background:url(//webimage.10x10.co.kr/fixevent/event/2020/105176/txt_time.png) no-repeat 50%;}
.topic .today .time #day {display:none;}
.topic .today .deal .price span,
.topic .today .deal .price:after {display:none;}
.topic .thumbnail {position:relative; width:190px; height:190px;}
.topic .thumbnail img {width:190px; height:190px;}
.thx1 {height:1835px; padding-top:488px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2020/105176/bg_cont_1.png);}
.thx2 {height:1837px; padding-top:565px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2020/105176/bg_cont_2.png);}
.thx2 .slick-dots button {background:#d3d39f;}
.thx2 .slick-dots .slick-active button {background:#b9b940;}
.thx3 {height:1836px; padding-top:566px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2020/105176/bg_cont_3.png);}
.thx3 .slick-dots button {background:#c6d0d1;}
.thx3 .slick-dots .slick-active button {background:#94c0c3;}

.rtd-event {height:615px; padding-top:137px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2020/105176/bg_finish.png);}
.rtd-event ul {position:relative; overflow:hidden; width:1140px; margin:0 auto;}
.rtd-event li {position:relative; overflow:hidden; float:left; width:86px; height:500px;}
.rtd-event li.active {width:796px;}
.rtd-event li:after {content:''; display:block; position:absolute; left:0; top:0; width:86px; height:500px; background:url(//webimage.10x10.co.kr/fixevent/event/2020/105176/txt_bar.jpg) 0 0 no-repeat; opacity:1; transition:all .4s; cursor:pointer;}
.rtd-event li.bnr2:after {background-position-x:-86px;}
.rtd-event li.bnr3:after {background-position-x:-172px;}
.rtd-event li.bnr4:after {background-position-x:-258px;}
.rtd-event li.bnr5:after {background-position-x:100%;}
.rtd-event li.hover:after {opacity:0;}

.btn-today {overflow:hidden; position:fixed; left:50%; top:50%; z-index:50; width:186px; margin-left:380px;}
.btn-today img {display:inline-block; margin-left:186px;  transition:all .7s cubic-bezier(0.6, -0.28, 0.735, 0.045);}
.btn-today.sticky img {margin-left:0;}

</style>
<div class="evt105176 jungdam">
    <div class="section topic" id="topic">
        <h2>
            <img src="//webimage.10x10.co.kr/fixevent/event/2020/105176/tit_jungdam_1.png" alt="정담 추석">
            <img src="//webimage.10x10.co.kr/fixevent/event/2020/105176/tit_jungdam_2.png" alt="">
            <img src="//webimage.10x10.co.kr/fixevent/event/2020/105176/tit_jungdam_3.png" alt="">
            <img src="//webimage.10x10.co.kr/fixevent/event/2020/105176/tit_jungdam_4.png" alt="">
        </h2>
        <p class="sub"><img src="//webimage.10x10.co.kr/fixevent/event/2020/105176/txt_sub.png" alt=""></p>
        <div class="deco">
            <img src="//webimage.10x10.co.kr/fixevent/event/2020/105176/bg_cloud_1.png" alt="">
            <img src="//webimage.10x10.co.kr/fixevent/event/2020/105176/bg_cloud_2.png" alt="">
            <img src="//webimage.10x10.co.kr/fixevent/event/2020/105176/bg_cloud_3.png" alt="">
        </div>

        <!-- 오늘의 특가 -->
        <div class="today" id="todayPrd">
            <a href="/shopping/category_prd.asp?itemid=<%=today_code%>&pEtr=105176" class="todayitem<%=today_code%> <%=CHKIIF(today_code="3176200"," deal","")%>">
                <div class="thumbnail">
                    <img src="" alt="">
                    <div class="time">
                        <span id="day"></span>
                        <span id="hour"></span>:<span id="min"></span>:<span id="sec"></span>
                    </div>
                </div>
                <p class="name"></p>
                <div class="price-wrap"><p class="price"></p></div>
            </a>                   
        </div>
        <a href="#topic" class="btn-today"><img src="//webimage.10x10.co.kr/fixevent/event/2020/105176/btn_today.png" alt="오늘의 특가 선물"></a>
    </div>

    <!-- 부모님 -->
    <div class="section thx1">
        <div class="swiper swiper1">
            <div>
                <img src="//webimage.10x10.co.kr/fixevent/event/2020/105176/slide1_1.jpg" alt="" usemap="#map1">
                <map name="map1">
                    <area href="/shopping/category_prd.asp?itemid=1549045&pEtr=105176" coords="363,56,658,162" shape="rect">
                    <area href="/shopping/category_prd.asp?itemid=1881035&pEtr=105176" coords="857,-26,1190,278" shape="rect">
                    <area href="/shopping/category_prd.asp?itemid=2195928&pEtr=105176" coords="111,128,258,452" shape="rect">
                    <area href="/shopping/category_prd.asp?itemid=3006026&pEtr=105176" coords="281,187,368,458" shape="rect">
                    <area href="/shopping/category_prd.asp?itemid=3134662&pEtr=105176" coords="404,224,803,451" shape="rect">
                    <area href="/shopping/category_prd.asp?itemid=2063632&pEtr=105176" coords="123,484,757,681" shape="rect">
                    <area href="/shopping/category_prd.asp?itemid=3134663&pEtr=105176" coords="821,328,1162,668" shape="rect">
                </map>
            </div>
            <div><a href="/shopping/category_prd.asp?itemid=3134663&pEtr=105176"><img src="//webimage.10x10.co.kr/fixevent/event/2020/105176/slide1_2.jpg" alt=""></a></div>
            <div><a href="/shopping/category_prd.asp?itemid=3134662&pEtr=105176"><img src="//webimage.10x10.co.kr/fixevent/event/2020/105176/slide1_3.jpg" alt=""></a></div>
        </div>
        <ul class="item-list">
            <li class="itemcode">
                <a href="/shopping/category_prd.asp?itemid=code&pEtr=105176">
                    <div class="thumbnail">
                        <div class="ico-soldout"><span>일시품절</span></div>
                        <img src="" alt="">
                    </div>
                    <div class="desc">
                        <p class="name"></p>
                        <p class="price"></p>
                    </div>
                </a>
            </li>
        </ul>
        <a class="btn-more" href="/event/eventmain.asp?eventid=105243">더 많은 상품 보러가기</a>
    </div>
    
    <!-- 은사님 -->
    <div class="section thx2">
        <div class="swiper swiper2">
            <div>
                <img src="//webimage.10x10.co.kr/fixevent/event/2020/105176/slide2_1.jpg" alt="" usemap="#map2">
                <map name="map2">
                    <area href="/shopping/category_prd.asp?itemid=2835760&pEtr=105176" coords="269,194,436,382" shape="rect">
                    <area href="/shopping/category_prd.asp?itemid=3136956&pEtr=105176" coords="8,399,462,516" shape="rect">
                    <area href="/shopping/category_prd.asp?itemid=1616984&pEtr=105176" coords="147,526,375,673" shape="rect">
                    <area href="/shopping/category_prd.asp?itemid=3006021&pEtr=105176" coords="503,250,703,498" shape="rect">
                    <area href="/shopping/category_prd.asp?itemid=1212217&pEtr=105176" coords="710,444,892,609" shape="rect">
                    <area href="/shopping/category_prd.asp?itemid=2644354&pEtr=105176" coords="883,220,1217,519" shape="rect">
                </map>
            </div>
            <div><a href="/shopping/category_prd.asp?itemid=2644354&pEtr=105176"><img src="//webimage.10x10.co.kr/fixevent/event/2020/105176/slide2_2.jpg" alt=""></a></div>
            <div><a href="/shopping/category_prd.asp?itemid=3136956&pEtr=105176"><img src="//webimage.10x10.co.kr/fixevent/event/2020/105176/slide2_3.jpg" alt=""></a></div>
        </div>
        <ul class="item-list">
            <li class="itemcode">
                <a href="/shopping/category_prd.asp?itemid=code&pEtr=105176">
                    <div class="thumbnail">
                        <div class="ico-soldout"><span>일시품절</span></div>
                        <img src="" alt="">
                    </div>
                    <div class="desc">
                        <p class="name"></p>
                        <p class="price"></p>
                    </div>
                </a>
            </li>
        </ul>
        <a class="btn-more" href="/event/eventmain.asp?eventid=105244">더 많은 상품 보러가기</a>
    </div>

    <!-- 첫인사 -->
    <div class="section thx3">
        <div class="swiper swiper3">
            <div>
                <img src="//webimage.10x10.co.kr/fixevent/event/2020/105176/slide3_1.jpg" alt="" usemap="#map3">
                <map name="map3">
                    <area href="/shopping/category_prd.asp?itemid=1596901&pEtr=105176" coords="5,362,142,470" shape="rect">
                    <area href="/shopping/category_prd.asp?itemid=3136957&pEtr=105176" coords="152,402,292,636" shape="rect">
                    <area href="/shopping/category_prd.asp?itemid=2473351&pEtr=105176" coords="296,527,485,675" shape="rect">
                    <area href="/shopping/category_prd.asp?itemid=3136959&pEtr=105176" coords="440,187,753,404" shape="rect">
                    <area href="/shopping/category_prd.asp?itemid=2702511&pEtr=105176" coords="760,31,971,382" shape="rect">
                    <area href="/shopping/category_prd.asp?itemid=2452641&pEtr=105176" coords="992,157,1217,297" shape="rect">
                    <area href="/shopping/category_prd.asp?itemid=1791964&pEtr=105176" coords="1109,459,1217,636" shape="rect">
                </map>
            </div>
            <div><a href="/shopping/category_prd.asp?itemid=3136959&pEtr=105176"><img src="//webimage.10x10.co.kr/fixevent/event/2020/105176/slide3_2.jpg" alt=""></a></div>
            <div><a href="/shopping/category_prd.asp?itemid=1596901&pEtr=105176"><img src="//webimage.10x10.co.kr/fixevent/event/2020/105176/slide3_3.jpg" alt=""></a></div>
        </div>
        <ul class="item-list">
            <li class="itemcode">
                <a href="/shopping/category_prd.asp?itemid=code&pEtr=105176">
                    <div class="thumbnail">
                        <div class="ico-soldout"><span>일시품절</span></div>
                        <img src="" alt="">
                    </div>
                    <div class="desc">
                        <p class="name"></p>
                        <p class="price"></p>
                    </div>
                </a>
            </li>
        </ul>
        <a class="btn-more" href="/event/eventmain.asp?eventid=105245">더 많은 상품 보러가기</a>
    </div>

    <div class="section rtd-event">
        <ul>
            <li class="bnr1 hover"><a href="/event/eventmain.asp?eventid=105246"><img src="//webimage.10x10.co.kr/fixevent/event/2020/105176/bnr_event_1.jpg?v=2" alt="누구나 좋아하는 명절 선물" /></a></li>
            <li class="bnr2"><a href="/event/eventmain.asp?eventid=105247"><img src="//webimage.10x10.co.kr/fixevent/event/2020/105176/bnr_event_2.jpg?v=2" alt="기분좋게 드리는 용돈" /></a></li>
            <li class="bnr3"><a href="/event/eventmain.asp?eventid=105248"><img src="//webimage.10x10.co.kr/fixevent/event/2020/105176/bnr_event_3.jpg?v=2" alt="보다 쉽게 준비하는 명절요리" /></a></li>
            <li class="bnr4"><a href="/event/eventmain.asp?eventid=105249"><img src="//webimage.10x10.co.kr/fixevent/event/2020/105176/bnr_event_4.jpg?v=2" alt="주인공은 나! 한복 추천템" /></a></li>
            <li class="bnr5"><a href="/event/eventmain.asp?eventid=105250"><img src="//webimage.10x10.co.kr/fixevent/event/2020/105176/bnr_event_5.jpg?v=2" alt="조카 선물 고민이라면?" /></a></li>
        </ul>
    </div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->