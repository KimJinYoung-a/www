<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 양/우산 패스티벌
' History : 2020-06-30 이종화
'####################################################
%>
<!-- #include Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
dim eCode, userid, currentDate , eventStartDate , eventEndDate
dim bonuscountcount : bonuscountcount = 0
dim bonusCouponNumber 
IF application("Svr_Info") = "Dev" THEN
	eCode = "102188"
    bonusCouponNumber = "2957"
Else
	eCode = "103915"
    bonusCouponNumber = "1762"
End If

eventStartDate = cdate("2021-07-27")	'이벤트 시작일
eventEndDate = cdate("2020-08-31")		'이벤트 종료일
currentDate = date()
'currentDate = "2020-08-08"

userid = GetEncLoginUserID()

if IsUserLoginOK() then 
    bonuscountcount = getbonuscouponexistscount(userid, bonusCouponNumber, "", "", "")
end if 

%>
<style>
div.fullEvt #contentWrap {padding-top:0 !important;}
div.fullEvt .evtHead {display:none !important;}
div.fullEvt .eventContV15 {margin-top:0 !important;}
.finish-event {display:none;}

.parasol2020 {background-color:#fff;}
.parasol2020 h3 {margin-bottom:23px; color:#222; font-size:22px; font-weight:500; text-align:center;}
.parasol2020 button {background-color:transparent;}
.parasol2020 .btn-more {width:288px; height:62px; font-size:24px; font-weight:600; color:#222; border:solid 2px #222; border-radius:30px;}

.parasol2020 .topic {overflow:hidden; position:relative; height:800px; background:#54ff98 url(//webimage.10x10.co.kr/fixevent/event/2020/103915/bg_top.jpg?v=2) repeat-x 50% 50%;}/* 2021-07-28 수정 */
.parasol2020 .topic h2,
.parasol2020 .topic p,
.parasol2020 .topic .parasol-thumb {position:absolute; top:50%; left:50%; z-index:20;}
.parasol2020 .topic h2 {top:100px; margin-left:-518px;}
.parasol2020 .topic p {top:580px; margin-left:195px;}
.parasol2020 .topic .parasol-thumb {transform:translate(-50%,-50%);}

.parasol2020 .nav-evt {position:relative; width:10vw; display:flex; align-items:center; width:1140px; margin:0 auto 30px; border-bottom:solid 7px #efefef;}
.parasol2020 .nav-evt li {display:flex; align-items:center; justify-content:center; position:relative; bottom:-7px; width:25%; height:100%; transition:all .3s;}
.parasol2020 .nav-evt li a {display:block; width:100%; padding:8px 0 6px; color:#999; font-size:22px; font-weight:500;}
.parasol2020 .nav-evt li a:hover {text-decoration:none;}
.parasol2020 .nav-evt li:hover,
.parasol2020 .nav-evt li.on {border-bottom:solid 7px #fd55bc;}
.parasol2020 .nav-evt li:hover a,
.parasol2020 .nav-evt li.on a {color:#000; font-size:26px; font-weight:600;}

.cont-wrap .cont-parasol {padding-bottom:80px;}

.just-section a {display:block; width:1140px ;padding:75px 0; margin:0 auto;}
.coupon-section .btn-cpn {padding:85px 0;}

.cont-story .nav-evt {margin-bottom:85px;}
.cont-story .slide-wrap {position:relative; width:1140px; margin:0 auto;}
.cont-story .slide-wrap .txt {position:absolute; top:41px; left:0;}
.cont-story .slide-wrap .story-slider {position:relative;width:1140px; height:903px; margin:0 auto; cursor:grab;}
.cont-story .slide-wrap .story-slider span {display:inline-block; float:left; margin-top:390px; transform:translateX(600px); transition:all .6s;}
.cont-story .slide-wrap .story-slider .slick-active span {transform:translateX(0);}
.cont-story .slide-wrap .story-slider .slide-item .thumb {position:relative; z-index:10;}
.cont-story .slide-wrap .pagination-progressbar {position:absolute; left:50%; bottom:0; z-index:10; width:630px; height:13px; margin-left:-61px; background-color:#e2f8e7;}
.cont-story .slide-wrap .pagination-progressbar-fill {position:absolute; left:0; top:0; width:100%; height:100%; transform:scale(0); transform-origin:left top; transition-duration:300ms; background-color: #73ff94;}
.cont-story .slide-wrap .slick-prev {left:510px;}
.cont-story .slide-wrap .slick-prev,
.cont-story .slide-wrap .slick-next {top:0; z-index:30; width:50px; height:890px; background:url(//webimage.10x10.co.kr/fixevent/event/2020/103915/btn_nav.png) no-repeat 50% 0;}
.cont-story .slide-wrap .slick-next {right:0; transform:rotate(180deg);}

.cont-story .staff-review .txt {overflow:hidden; height:583px; margin-top:130px; margin-bottom:60px;}
.cont-story .staff-review .txt.on {height:auto; padding-bottom:0;}
.cont-story .staff-review .txt.on + .btn-more {display:none;}

.cont-theme .parasol-theme {display:flex; flex-wrap:wrap; justify-content:space-between; width:1025px; margin:0 auto;}
.cont-theme .parasol-theme li {margin-bottom:23px;}

.cont-best .sort-wrap {width:1140px; padding-right:20px; margin:0 auto; text-align:right;}
.cont-best .sort {display:inline-flex; margin-bottom:35px;}
.cont-best .sort li {margin:0 16px;}
.cont-best .sort li button {font-size:20px; color:#222; letter-spacing:-2px;}
.cont-best .sort li.on button {font-weight:500; border-bottom:3px solid #1eff8d;}

.cont-best .item-list {position:relative; display:flex; flex-wrap:wrap; width:1130px; min-height:430px; margin:0 auto;}
.cont-best .item-list li {position:relative; width:252px; margin-bottom:55px; margin-right:15px; margin-left:15px;}
.cont-best .item-list li a {position:relative; display:block; text-decoration:none;}
.cont-best .item-list .thumbnail {overflow:hidden; position:relative; width:100%; height:252px; border-radius:10px;}
.cont-best .item-list .thumbnail:after {display:block; position:absolute; top:0; left:0; z-index:10; width:100%; height:100%; background-color:rgba(0,0,0,.03); content:'';}
.cont-best .item-list .thumbnail img {width:100%;}
.cont-best .item-list .desc {padding:15px 8px 0; font-size:14px; text-decoration:none; text-align:left;}
.cont-best .item-list .desc .name {overflow:hidden; height:44px; margin-bottom:10px;}
.cont-best .item-list .desc .price-area {display:flex; align-items:center; margin-bottom:8px; font-weight :bold; font-size:16px;}
.cont-best .item-list .desc .price-area .won {display:none;}
.cont-best .item-list .desc .price-area .discount {display:inline-block; margin-left:5px; font-weight:normal; font-size:14px;}
.cont-best .item-list .desc .price-area .color-red {color:#ff357b !important;}
.cont-best .item-list .desc .price-area .color-green {color:#00cfcb !important;}
.cont-best .item-list .desc .brand {font-size:12px; color:#999;}

.cont-benefit .benefit-list {display:flex; justify-content:center; width:1140px; margin:0 auto;}
.cont-benefit .benefit-list li {margin:0 8px;}
</style>
<script>
$(function(){
	// scroll
	$('html,body').animate({ scrollTop : $('.parasol2020').offset().top }, 100);

	// click nav
    $('.nav-evt a[href*=#]').bind('click', function(e) {
        e.preventDefault();
        var target = $(this).attr("href"),
            targetY = $(target).offset().top;
        $('html, body').stop().animate({scrollTop: targetY}, 600);
    });

	// changing img
	(function changingImg(){
		var i=1;
		var repeat = setInterval(function(){
			i++;
			if(i>30){i=1;}
			$('.evt103915 .topic .parasol-thumb img').attr('src','//webimage.10x10.co.kr/fixevent/event/2020/103915/img_parasol'+ i +'.png');
		},260);
	})();

	// slide
	var slider = $('.story-slider');
	var amt = slider.find('.slide-item').length;
	var progress = $('.pagination-progressbar-fill');
	if (amt > 1) {
		slider.on('init', function(){
			var init = (1 / amt).toFixed(2);
			progress.css('transform', 'scaleX(' + init + ') scaleY(1)');
		});
		slider.on('beforeChange', function(event, slick, currentSlide, nextSlide){
			var calc = ( (nextSlide+1) / slick.slideCount ).toFixed(2);
			progress.css('transform', 'scaleX(' + calc + ') scaleY(1)');
		});
		slider.slick({
			autoplay: true,
			autoplaySpeed: 1800,
			arrows: true,
			fade: true,
			speed: 1000
		});
	} else {
		$(this).find('.pagination-progressbar').hide();
	}

	// btn more
	$('.cont-story .btn-more').click(function (e) { 
		e.preventDefault();
		$('.cont-story .txt').toggleClass('on');
		$(this).hide();
	});

    fnAwardItems('d');
});

var cpg = 0;
var dgubun = "";
function fnAwardItems(datagubun) {
    $(event.target).parents('li').addClass('on').siblings("li").removeClass("on");
    if (datagubun != "") {
        dgubun = datagubun;
    }
    
    if (datagubun == "") {
        cpg++;
    } else {
        cpg = 1;
    }

	$.ajax({
		url: '/event/lib/cateawarditem.asp',
        data : {
            "cpg" : cpg,
            "disp" : 116110,
            "atype" : "dt",
            "dategubun" : dgubun,
        },
		cache: false,
		success: function(message) {
			if(message!="") {
                $(".btn-more").show();
                if (cpg == 1) {
                    $("#awardlist").empty().append(message);
                } else {
                    $("#awardlist").append(message);
                }
			} else {
                $(".btn-more").hide();
            }
		}
		,error: function(err) {
			alert(err.responseText);
		}
	});
}

function fnDownCoupon(stype,idx){
    <% If IsUserLoginOK() Then %>
        var str = $.ajax({
            type: "POST",
            url: "/event/etc/coupon/couponshop_process.asp",
            data: "mode=cpok&stype="+stype+"&idx="+idx,
            dataType: "text",
            async: false
        }).responseText;
        var str1 = str.split("||")
        if (str1[0] == "11"){
            alert('쿠폰이 발급 되었습니다.\n8월 31일까지 사용하세요 :)');
            return false;
        }else if (str1[0] == "12"){
            alert('기간이 종료되었거나 유효하지 않은 쿠폰입니다.');
            return false;
        }else if (str1[0] == "13"){
            alert('이미 다운로드 받으셨습니다.');
            return false;
        }else if (str1[0] == "02"){
            alert('로그인 후 쿠폰을 받을 수 있습니다!');
            return false;
        }else if (str1[0] == "01"){
            alert('잘못된 접속입니다.');
            return false;
        }else if (str1[0] == "00"){
            alert('정상적인 경로가 아닙니다.');
            return false;
        }else{
            alert('오류가 발생했습니다.');
            return false;
        }
	<% Else %>
		if(confirm("로그인 후 쿠폰을 받을 수 있습니다!")){
			top.location.href="/login/loginpage.asp?vType=G";
			return false;
		}
		return false;
	<% End IF %>
}
</script>
<div class="evt103915 parasol2020">
    <div class="topic">
        <h2><img src="//webimage.10x10.co.kr/fixevent/event/2020/103915/tit_parasol.png?v=2" alt="양산 대유행"></h2>
        <p><img src="//webimage.10x10.co.kr/fixevent/event/2020/103915/txt_sale.png?v=2" alt="23,333개의 양산 65% 할인"></p>
        <div class="parasol-thumb"><img src="//webimage.10x10.co.kr/fixevent/event/2020/103915/img_parasol1.png" alt=""></div>
    </div>
    
    
    <div class="just-section">
        <% if currentdate = "2020-07-14" then %>
        <a href="/shopping/category_prd.asp?itemid=2819537"><img src="//webimage.10x10.co.kr/fixevent/event/2020/103915/img_just1.jpg" alt="just1day"></a>
        <% elseIf currentdate = "2020-07-16" then %>
        <a href="/shopping/category_prd.asp?itemid=3017824"><img src="//webimage.10x10.co.kr/fixevent/event/2020/103915/img_just2.jpg" alt="just1day"></a>
        <% end If%>
    </div>
    <% if bonuscountcount = 0 then %>
    <div class="coupon-section">
        <button class="btn-cpn" onclick="fnDownCoupon('evtsel','<%=bonusCouponNumber%>'); return false;"><img src="//webimage.10x10.co.kr/fixevent/event/2020/103915/btn_cp.png?v=2" alt="쿠폰 다운받기"></button>
    </div>
    <% end if %>
    <div class="cont-wrap">
        <%'!-- 스토리 --%>
        <div id="cont1" class="cont-parasol cont-story">
            <ul class="nav-evt">
                <li class="nav1 on"><a href="#cont1">스토리</a></li>
                <li class="nav2"><a href="#cont2">테마별</a></li>
                <li class="nav3"><a href="#cont3">베스트</a></li>
                <li class="nav4"><a href="#cont4">혜택</a></li>
            </ul>
            <div class="slide-wrap">
                <p class="txt"><img src="//webimage.10x10.co.kr/fixevent/event/2020/103915/txt_story.png?v=1.01" alt="Do you know 양산?"></p>
                <div class="story-slider">
                    <div class="slide-item">
                        <a href="/shopping/category_prd.asp?itemid=2799855">
                            <span><img src="//webimage.10x10.co.kr/fixevent/event/2020/103915/img_sm1.jpg" alt=""></span>
                            <img src="//webimage.10x10.co.kr/fixevent/event/2020/103915/img_slide1_1.jpg" alt="" class="thumb">
                        </a>
                    </div>
                    <div class="slide-item">
                        <a href="/shopping/category_prd.asp?itemid=2799855">
                            <span><img src="//webimage.10x10.co.kr/fixevent/event/2020/103915/img_sm1.jpg" alt=""></span>
                            <img src="//webimage.10x10.co.kr/fixevent/event/2020/103915/img_slide1_2.jpg?v=1.01" alt="" class="thumb">
                        </a>
                        </div>
                    <div class="slide-item">
                        <a href="/shopping/category_prd.asp?itemid=2799855">
                            <span><img src="//webimage.10x10.co.kr/fixevent/event/2020/103915/img_sm1.jpg" alt=""></span>
                            <img src="//webimage.10x10.co.kr/fixevent/event/2020/103915/img_slide1_3.jpg" alt="" class="thumb">
                        </a>
                        </div>
                    <div class="slide-item">
                        <a href="/shopping/category_prd.asp?itemid=1911206">
                            <span><img src="//webimage.10x10.co.kr/fixevent/event/2020/103915/img_sm2.jpg" alt=""></span>
                            <img src="//webimage.10x10.co.kr/fixevent/event/2020/103915/img_slide1_4.jpg?v=1.01" alt="" class="thumb">
                        </a>
                        </div>
                    <div class="slide-item">
                        <a href="/shopping/category_prd.asp?itemid=2259271">
                            <span><img src="//webimage.10x10.co.kr/fixevent/event/2020/103915/img_sm3.jpg" alt=""></span>
                            <img src="//webimage.10x10.co.kr/fixevent/event/2020/103915/img_slide1_5.jpg?v=1.01" alt="" class="thumb">
                        </a>
                        </div>
                    <div class="slide-item">
                        <a href="/shopping/category_prd.asp?itemid=2259271">
                            <span><img src="//webimage.10x10.co.kr/fixevent/event/2020/103915/img_sm3.jpg" alt=""></span>
                            <img src="//webimage.10x10.co.kr/fixevent/event/2020/103915/img_slide1_6.jpg?v=1.01" alt="" class="thumb">
                        </a>
                        </div>
                    <div class="slide-item">
                        <a href="/shopping/category_prd.asp?itemid=2361918">
                            <span><img src="//webimage.10x10.co.kr/fixevent/event/2020/103915/img_sm4.jpg" alt=""></span>
                            <img src="//webimage.10x10.co.kr/fixevent/event/2020/103915/img_slide1_7.jpg?v=1.01" alt="" class="thumb">
                        </a>
                        </div>
                </div>
                <div class="pagination-progressbar"><span class="pagination-progressbar-fill"></span></div>
            </div>
            <div class="staff-review">
                <div class="txt">
                    <img src="//webimage.10x10.co.kr/fixevent/event/2020/103915/txt_review.png" alt="화.제.집.중 텐바이텐 Z세대가 말한다, 양산이 대세!" usemap="#map-item">
                    <map name="map-item">
                        <area alt="혜림" href="/shopping/category_prd.asp?itemid=2361918" coords="631,582,52,0" shape="rect" onfocus="this.blur();">
                        <area alt="은비" href="/shopping/category_prd.asp?itemid=2819537" coords="508,660,1089,1242" shape="rect" onfocus="this.blur();">
                        <area alt="지혜" href="/shopping/category_prd.asp?itemid=2259275" coords="51,1320,630,1899" shape="rect" onfocus="this.blur();">
                        <area alt="원주" href="/shopping/category_prd.asp?itemid=2832775" coords="507,1979,1086,2560" shape="rect" onfocus="this.blur();">
                        <area alt="별해" href="/shopping/category_prd.asp?itemid=1496942" coords="51,2641,631,3222" shape="rect" onfocus="this.blur();">
                        <area alt="지아" href="/shopping/category_prd.asp?itemid=2385631" coords="510,3300,1089,3878" shape="rect" onfocus="this.blur();">
                    </map>
                </div>
                <button class="btn-more">더 보기 +</button>
            </div>
        </div>
        <%'!-- 테마별 --%>
        <div id="cont2" class="cont-parasol cont-theme">
            <ul class="nav-evt">
                <li class="nav1"><a href="#cont1">스토리</a></li>
                <li class="nav2 on"><a href="#cont2">테마별</a></li>
                <li class="nav3"><a href="#cont3">베스트</a></li>
                <li class="nav4"><a href="#cont4">혜택</a></li>
            </ul>
            <h3>센스있게 골라보자 나만의 양산!</h3>
            <% if currentdate = "2020-07-14" OR currentdate = "2020-07-16" OR currentdate = "2020-07-18" OR currentdate = "2020-07-20" OR currentdate = "2020-07-22" OR currentdate = "2020-07-24" OR currentdate = "2020-07-26" OR currentdate = "2020-07-28" OR currentdate = "2020-07-30"then %>
            <ul class="parasol-theme">
                <li><a href="/event/eventmain.asp?eventid=104045"><img src="//webimage.10x10.co.kr/fixevent/event/2020/103915/bnr_4.jpg" alt="초경량 양산"></a></li>
                <li><a href="/event/eventmain.asp?eventid=104052"><img src="//webimage.10x10.co.kr/fixevent/event/2020/103915/bnr_5.jpg" alt="디자인 양산"></a></li>
                <li><a href="/event/eventmain.asp?eventid=104042" ><img src="//webimage.10x10.co.kr/fixevent/event/2020/103915/bnr_1.jpg" alt="양우산"></a></li>
                <li><a href="/event/eventmain.asp?eventid=104043"><img src="//webimage.10x10.co.kr/fixevent/event/2020/103915/bnr_2.jpg" alt="컬러별 양산"></a></li>
                <li><a href="/event/eventmain.asp?eventid=104044"><img src="//webimage.10x10.co.kr/fixevent/event/2020/103915/bnr_3.jpg" alt="길다란 양산"></a></li>
                <li><a href="/event/eventmain.asp?eventid=103091"><img src="//webimage.10x10.co.kr/fixevent/event/2020/103915/bnr_6.jpg" alt="장마 기획전"></a></li>
                <li><a href="/event/eventmain.asp?eventid=103142"><img src="//webimage.10x10.co.kr/fixevent/event/2020/103915/bnr_7.jpg" alt="선풍기 모음전"></a></li>
                <li><a href="/event/eventmain.asp?eventid=103787"><img src="//webimage.10x10.co.kr/fixevent/event/2020/103915/bnr_8.jpg" alt="여름 에코백"></a></li>
            </ul>
            <% Else %>
            <ul class="parasol-theme">
                <li><a href="/event/eventmain.asp?eventid=104042"><img src="//webimage.10x10.co.kr/fixevent/event/2020/103915/bnr_1.jpg" alt="양우산"></a></li>
                <li><a href="/event/eventmain.asp?eventid=104043"><img src="//webimage.10x10.co.kr/fixevent/event/2020/103915/bnr_2.jpg" alt="컬러별 양산"></a></li>
                <li><a href="/event/eventmain.asp?eventid=104044"><img src="//webimage.10x10.co.kr/fixevent/event/2020/103915/bnr_3.jpg" alt="길다란 양산"></a></li>
                <li><a href="/event/eventmain.asp?eventid=104045"><img src="//webimage.10x10.co.kr/fixevent/event/2020/103915/bnr_4.jpg" alt="초경량 양산"></a></li>
                <li><a href="/event/eventmain.asp?eventid=104052"><img src="//webimage.10x10.co.kr/fixevent/event/2020/103915/bnr_5.jpg" alt="디자인 양산"></a></li>
                <li><a href="/event/eventmain.asp?eventid=103091"><img src="//webimage.10x10.co.kr/fixevent/event/2020/103915/bnr_6.jpg" alt="장마 기획전"></a></li>
                <li><a href="/event/eventmain.asp?eventid=103142"><img src="//webimage.10x10.co.kr/fixevent/event/2020/103915/bnr_7.jpg" alt="선풍기 모음전"></a></li>
                <li><a href="/event/eventmain.asp?eventid=103787"><img src="//webimage.10x10.co.kr/fixevent/event/2020/103915/bnr_8.jpg" alt="여름 에코백"></a></li>
            </ul>
            <% End If %>
        </div>
        <%'!-- 베스트 --%>
        <div id="cont3" class="cont-parasol cont-best">
            <ul class="nav-evt">
                <li class="nav1"><a href="#cont1">스토리</a></li>
                <li class="nav2"><a href="#cont2">테마별</a></li>
                <li class="nav3 on"><a href="#cont3">베스트</a></li>
                <li class="nav4"><a href="#cont4">혜택</a></li>
            </ul>
            <h3>인기 많은 힛-트 상품만 모았어요</h3>
            <ul class="sort">
                <li class="on" onclick="fnAwardItems('d');"><button>일간</button></li>
                <li onclick="fnAwardItems('w');"><button>주간</button></li>
                <li onclick="fnAwardItems('m');"><button>월간</button></li>
            </ul>
            <ul class="item-list" id="awardlist"></ul>
            <button class="btn-more" onclick="fnAwardItems('');">더 보기 +</button>
        </div>
        <%'!-- 혜택 --%>
        <div id="cont4" class="cont-parasol cont-benefit">
            <ul class="nav-evt">
                <li class="nav1"><a href="#cont1">스토리</a></li>
                <li class="nav2"><a href="#cont2">테마별</a></li>
                <li class="nav3"><a href="#cont3">베스트</a></li>
                <li class="nav4 on"><a href="#cont4">혜택</a></li>
            </ul>
            <h3>놓칠 수 없는 보나스 혜택</h3>
            <% if currentdate = "2020-07-13" Then %>
            <ul class="benefit-list">
                <li><a href="/event/eventmain.asp?eventid=104006"><img src="//webimage.10x10.co.kr/fixevent/event/2020/103915/img_benefit2.jpg" alt="연속로그인"></a></li>
                <li><a href="/my10x10/goodsusing.asp"><img src="//webimage.10x10.co.kr/fixevent/event/2020/103915/img_benefit1.jpg" alt="양산포토후기"></a></li>
            </ul>
            <% ElseIf currentdate >= "2020-07-14" AND currentdate <= "2020-07-16" Then %>
            <ul class="benefit-list">
                <li><a href="/my10x10/couponbook.asp"><img src="//webimage.10x10.co.kr/fixevent/event/2020/103915/img_benefit3.jpg" alt="쿠폰"></a></li>
                <li><a href="/my10x10/goodsusing.asp"><img src="//webimage.10x10.co.kr/fixevent/event/2020/103915/img_benefit1.jpg" alt="양산포토후기"></a></li>
                <li><img src="//webimage.10x10.co.kr/fixevent/event/2020/103915/img_benefit4.jpg" alt="페이코"></li>
            </ul>
            <% ElseIf currentdate >= "2020-07-17" AND currentdate <= "2020-07-19" Then %>
            <ul class="benefit-list">
                <li><a href="/my10x10/goodsusing.asp"><img src="//webimage.10x10.co.kr/fixevent/event/2020/103915/img_benefit1.jpg" alt="양산포토후기"></a></li>
                <li><a href="/event/eventmain.asp?eventid=104006"><img src="//webimage.10x10.co.kr/fixevent/event/2020/103915/img_benefit2.jpg" alt="연속로그인"></a></li>
                <li><img src="//webimage.10x10.co.kr/fixevent/event/2020/103915/img_benefit4.jpg" alt="페이코"></li>
            </ul>
            <% ElseIf currentdate >= "2020-07-20" AND currentdate <= "2020-07-26" Then %>
            <ul class="benefit-list">
                <li><a href="/event/eventmain.asp?eventid=104372"><img src="//webimage.10x10.co.kr/fixevent/event/2020/103915/img_benefit6.jpg" alt="BC카드"></a></li>
                <li><a href="/my10x10/goodsusing.asp"><img src="//webimage.10x10.co.kr/fixevent/event/2020/103915/img_benefit1.jpg" alt="양산포토후기"></a></li>
            </ul>
            <% ElseIf currentdate >= "2020-07-27" AND currentdate <= "2020-07-31" Then %>
            <ul class="benefit-list">
                <li><a href="/event/eventmain.asp?eventid=104372"><img src="//webimage.10x10.co.kr/fixevent/event/2020/103915/img_benefit6.jpg" alt="BC카드"></a></li>
                <li><a href="/my10x10/goodsusing.asp"><img src="//webimage.10x10.co.kr/fixevent/event/2020/103915/img_benefit1.jpg" alt="양산포토후기"></a></li>
            </ul>
            <% ElseIf currentdate >= "2020-08-03" AND currentdate <= "2020-08-08" Then %>
            <ul class="benefit-list">
                <li><a href="/event/eventmain.asp?eventid=103173"><img src="//webimage.10x10.co.kr/fixevent/event/2020/103915/img_benefit8.jpg" alt="무료배송"></a></li>
                <li><a href="/event/benefit/"><img src="//webimage.10x10.co.kr/fixevent/event/2020/103915/img_benefit9.jpg" alt="혜택"></a></li>                
            </ul>
            <% ElseIf currentdate >= "2020-08-09" AND currentdate <= "2020-08-16" Then %>
            <ul class="benefit-list">
                <li><a href="/event/eventmain.asp?eventid=103173"><img src="//webimage.10x10.co.kr/fixevent/event/2020/103915/img_benefit8.jpg" alt="무료배송"></a></li>
                <li><a href="/event/benefit/"><img src="//webimage.10x10.co.kr/fixevent/event/2020/103915/img_benefit9.jpg" alt="혜택"></a></li>                
                <li><a href="/event/eventmain.asp?eventid=104894"><img src="//webimage.10x10.co.kr/fixevent/event/2020/103915/img_benefit10.jpg" alt="줍줍"></a></li>
            </ul>
            <% ElseIf currentdate >= "2020-08-17" Then %>
            <ul class="benefit-list">
                <li><a href="/event/eventmain.asp?eventid=101616"><img src="//webimage.10x10.co.kr/fixevent/event/2020/103915/img_benefit11.jpg" alt="텐텐 무료배송"></a></li>
                <li><a href="/event/benefit/"><img src="//webimage.10x10.co.kr/fixevent/event/2020/103915/img_benefit12.jpg" alt="app 쿠폰"></a></li>
            </ul>
            <% End If%>
        </div>
    </div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->