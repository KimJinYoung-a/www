<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<%
'####################################################
' Description : 레드-썬
' History : 2017-12-15 이종화
'####################################################
Dim eCode, couponcnt,  getbonuscoupon1 , getbonuscoupon2
IF application("Svr_Info") = "Dev" THEN
	eCode   =  67488
	getbonuscoupon1 = 2863
	getbonuscoupon2 = 2864
Else
	eCode   =  82766
	getbonuscoupon1 = 1016	
	getbonuscoupon2 = 1017	
End If

'// 쿠폰 카운트
couponcnt = getbonuscoupontotalcount(getbonuscoupon1&","&getbonuscoupon2, "", "", "")

%>
<style type="text/css">
#contentWrap {padding-bottom:0;}
.red-sun {background-color:#fff;}
.red-sun .topic,
.red-sun .topic .inner {height:838px; background:#f03d34 url(http://webimage.10x10.co.kr/eventIMG/2017/82766/bg_topic_v1.jpg) 50% 0 no-repeat; background-size:1903px auto;}
.red-sun .topic {position:relative; padding-top:484px;}
.red-sun .topic .inner {background-color:#2f3958; background-position:50% 100%;}
.red-sun h2 {position:absolute; top:113px; left:50%; margin-left:-460px;}
.red-sun .slide {position:absolute; top:169px; left:50%; z-index:10; width:468px; height:316px; margin-left:22px;}
#slideshow div {position:absolute; top:0; left:0; z-index:8; opacity:0.0;}
#slideshow div.active {z-index:10; opacity:1.0;}
#slideshow div.last-active {z-index:9;}

.red-sun-coupon {position:relative; width:1206px; margin:0 auto; padding-top:230px;}
.red-sun-coupon h3 {position:absolute; top:662px; left:50%; margin-left:118px;}
.red-sun-coupon .btn-download,
.red-sun-coupon .coupon-close {position:absolute; top:553px; left:50%; margin-left:-126px; width:630px; height:80px; background:#f03d34 url(http://webimage.10x10.co.kr/eventIMG/2017/82766/txt_coupon.gif) 0 0 no-repeat; text-indent:-9999em;}
.red-sun-coupon .coupon-close {background-position:0 100%;}
.red-sun-coupon .label {position:absolute; top:295px; left:50%; margin-left:459px;}

.noti {display:none; position:absolute; top:697px; left:50%; width:410px; height:197px; margin-left:-16px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/82766/bg_pattern_purple.png) 50% 0 no-repeat;}
.noti ul {padding:47px 0 0 40px; text-align:left;}
.noti li {position:relative; padding-left:10px; color:#fff; font-family:'Gulim', '굴림', 'Verdana'; font-size:12px; line-height:24px;}
.noti li:after {content:' '; position:absolute; top:10px; left:0; width:5px; height:1px; background-color:currentColor;}

.red-sun-event .on {transition:opacity 0.4s ease-in-out 0s; opacity:0;}
.red-sun-event a:hover .on {opacity:1;}

.red-sun-event-01 {height:1354px; background:#352f4d url(http://webimage.10x10.co.kr/eventIMG/2017/82766/bg_event_01.png) 50% 0 no-repeat;}
.red-sun-event-01 ul {overflow:hidden; width:1206px; margin:50px auto 0;}
.red-sun-event-01 .event02 ,
.red-sun-event-01 .event03 {float:left; width:50%;}
.red-sun-event-01 a {display:block; position:relative;}
.red-sun-event-01 .on {position:absolute; top:0; left:50%; margin-left:-301px;}
.red-sun-event-01 .event01 .on {margin-left:-603px;}

.red-sun-event-02 {height:1085px; background:#f03d34 url(http://webimage.10x10.co.kr/eventIMG/2017/82766/bg_event_02.png) 50% 0 no-repeat;}
.red-sun-event-02 h3 {padding-top:130px;}
.red-sun-event-02 ul {position:relative; width:1175px; height:771px; margin:19px auto 0;}
.red-sun-event-02 li {position:absolute;}
.red-sun-event-02 .event01 {top:211px; right:175px;}
.red-sun-event-02 .on {position:absolute; top:0; left:50%; margin-left:-111px;}
.red-sun-event-02 .thumbnail300px {margin-left:-151px;}
.red-sun-event-02 .event02 {top:327px; left:380px;}
.red-sun-event-02 .event03 {top:441px; left:212px;}
.red-sun-event-02 .event04 {top:215px; left:0;}
.red-sun-event-02 .event05 {top:118px; right:14px;}
.red-sun-event-02 .event06 {top:222px; right:355px;}
.red-sun-event-02 .event07 {top:314px; right:0;}
.red-sun-event-02 .event08 {top:0; left:265px;}
.red-sun-event-02 .event09 {top:402px; right:134px;}
.red-sun-event-02 .event10 {top:42px; right:344px;}
.red-sun-event-02 .event11 {top:0; right:168px;}
.red-sun-event-02 .event12 {top:77px; left:424px;}
.red-sun-event-02 .event13 {top:392px; left:36px;}
.red-sun-event-02 .event13 .on {top:-7px; left:0; margin-left:-16px;}
.red-sun-event-02 .event14 {top:169px; left:176px;}
.red-sun-event-02 .event15 {top:29px; left:77px;}
.red-sun-event-02 .event16 {top:400px; right:384px;}
.red-sun-event-02 .event16 .on {margin-left:-112px;}

.scale-animation {backface-visibility:visible; animation:scale-animation 1.2s infinite; animation-fill-mode:both;}
@keyframes scale-animation {
	0% {transform: scale(0.8); opacity:0;}
	100% {transform: scale(1); opacity:1;}
}
</style>
<script type="text/javascript">
var isStopped = false;
function slideSwitch() {
	if (!isStopped) {
		var $active = $("#slideshow div.active");
		if ($active.length == 0) $active = $("#slideshow div:last");
		var $next = $active.next().length ? $active.next() : $("#slideshow div:first");

		$active.addClass('last-active');

		$next.css({
			opacity:0.0
		})
			.addClass("active")
			.animate({
			opacity: 1.0
		}, 0, function () {
			$active.removeClass("active last-active");
		});
	}
}

$(function () {
	setInterval(function () {
		slideSwitch();
	}, 500);

	$("#slideshow").hover(function () {
		isStopped = false;
	},function () {
		isStopped = false;
	});

	$("#noti a").hover(function() {
		$("#noticontents").fadeIn(100);
	});

	$("#noti a").on("click", function(e){
		$("#noticontents").fadeIn(100);
		return false;
	});

	$("#noticontents").mouseleave(function() {
		$("#noticontents").fadeOut(100);
	});
});

function jsevtDownCoupon(stype,idx){
	<% If IsUserLoginOK() Then %>
		<% If now() > #12/18/2017 00:00:00# and now() < #12/19/2017 23:59:59# then %>
			var str = $.ajax({
				type: "POST",
				url: "/event/etc/coupon/couponshop_process.asp",
				data: "mode=cpok&stype="+stype+"&idx="+idx,
				dataType: "text",
				async: false
			}).responseText;
			var str1 = str.split("||")
			if (str1[0] == "11"){
				alert('쿠폰이 발급 되었습니다.\n12월 19일 자정까지 사용하세요.');
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
		<% else %>
			alert("이벤트 기간이 아닙니다.");
			return;
		<% end if %>
	<% Else %>
		if(confirm("로그인 후 쿠폰을 받을 수 있습니다!")){
			top.location.href="/login/loginpage.asp?vType=G";
			return false;
		}
		return false;
	<% End IF %>
}
</script>
<div class="evt82766 red-sun">
	<div class="section topic">
		<h2><img src="http://webimage.10x10.co.kr/eventIMG/2017/82766/tit_red_sun_v1.png" alt="레드 썬! 데이 단, 2일 마법에 걸린 특급세일 지금 확인하세요!" /></h2>
		<div id="slideshow" class="slide">
			<div class="active"><img src="http://webimage.10x10.co.kr/eventIMG/2017/82766/img_upto_01_v1.jpg" alt="Up to 94%" /></div>
			<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/82766/img_upto_02_v1.jpg" alt="" /></div>
			<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/82766/img_upto_03_v1.jpg" alt="" /></div>
			<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/82766/img_upto_04_v1.jpg" alt="" /></div>
		</div>

		<div class="inner">
			<div class="red-sun-coupon">
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/82766/img_coupon.png" alt="리얼쿠폰 진짜루? 할인에 할인을 도와주는 쿠폰! 6만원 이상 구매 시 만원 할인, 20만원 이상 삼만원 할인, 사용기간 12/18~19까지 2일간" /></p>
				<% If now() > #12/19/2017 00:00:00# Then %>
				<b class="label scale-animation"><img src="http://webimage.10x10.co.kr/eventIMG/2017/82766/img_label_close.png" alt="마감 임박" /></b>
				<% End If %>
				<% If couponcnt >= 200000 Then %>
				<p class="coupon-close">쿠폰이 모두 소진되었습니다</p>
				<% Else %>
				<button type="button" class="btn-download" onclick="jsevtDownCoupon('evtsel,evtsel','<%= getbonuscoupon1 %>,<%= getbonuscoupon2 %>'); return false;">쿠폰 한번에 다운받기</button>
				<% End If %>
				<h3 id="noti"><a href="#noticontents"><img src="http://webimage.10x10.co.kr/eventIMG/2017/82766/tit_noti.png" alt="이벤트 유의사항" /></a></h3>
				<div id="noticontents" class="noti">
					<ul>
						<li>이벤트는 ID 당 1회만 참여할 수 있습니다.</li>
						<li>지급된 쿠폰은 텐바이텐에서만 사용 가능 합니다.</li>
						<li>쿠폰은 12/19(화) 23시 59분 59초에 종료됩니다.</li>
						<li>주문한 상품에 따라, 배송비용은 추가로 발생할 수 있습니다.</li>
						<li>이벤트는 조기 마감될 수 있습니다.</li>
					</ul>
				</div>
			</div>
		</div>
	</div>

	<div class="section red-sun-event red-sun-event-01">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/82766/tit_sale.png" alt="세일, 레드 썬 당신만을 위해 준비했어요!" /></h3>
		<ul>
			<li class="event01">
				<a href="eventmain.asp?eventid=82767">
					<span class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2017/82766/img_sale_01_off_v1.png" alt="단독특가, 기대해! 연말 할인의 성장통, 텐바이텐 단독 세일 이벤트 바로가기" /></span>
					<span class="on"><img src="http://webimage.10x10.co.kr/eventIMG/2017/82766/img_sale_01_on_v1.png" alt="" /></span>
				</a>
			</li>
			<li class="event02">
				<a href="eventmain.asp?eventid=82769">
					<span class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2017/82766/img_sale_02_off_v2.png" alt="두고봐, 하나 더 줄거야! 이렇게 하나를 더? 이거 받아도 되는거에요? 이벤트 바로가기" /></span>
					<span class="on"><img src="http://webimage.10x10.co.kr/eventIMG/2017/82766/img_sale_02_on_v2.png" alt="" /></span>
				</a>
			</li>
			<li class="event03">
				<a href="eventmain.asp?eventid=82768">
					<span class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2017/82766/img_sale_03_off_v1.png" alt="숨지마~ 스크래치! 스크래치, 있는지 모를 정도의 퀄리티에 최저가로~ 이벤트 바로가기" /></span>
					<span class="on"><img src="http://webimage.10x10.co.kr/eventIMG/2017/82766/img_sale_03_on_v1.png" alt="" /></span>
				</a>
			</li>
		</ul>
	</div>

	<div class="section red-sun-event red-sun-event-02">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/82766/tit_discount.png" alt="할인이 왜 거기서 나와?" /></h3>
		<ul>
			<li class="event01">
				<a href="eventmain.asp?eventid=82896">
					<span class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2017/82766/img_discount_01_off_v1.png" alt="데코/조명 베스트 BRAND 6" /></span>
					<span class="on"><img src="http://webimage.10x10.co.kr/eventIMG/2017/82766/img_discount_01_on.png" alt="" /></span>
				</a>
			</li>
			<li class="event02">
				<a href="eventmain.asp?eventid=82897">
					<span class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2017/82766/img_discount_02_off.png" alt="가구 베스트 BRAND 10" /></span>
					<span class="on thumbnail300px"><img src="http://webimage.10x10.co.kr/eventIMG/2017/82766/img_discount_02_on.png" alt="" /></span>
				</a>
			</li>
			<li class="event03">
				<a href="eventmain.asp?eventid=82914">
					<span class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2017/82766/img_discount_03_off.png" alt="여행 베스트 아이템" /></span>
					<span class="on"><img src="http://webimage.10x10.co.kr/eventIMG/2017/82766/img_discount_03_on_v1.png" alt="" /></span>
				</a>
			</li>
			<li class="event04">
				<a href="eventmain.asp?eventid=82901">
					<span class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2017/82766/img_discount_04_off_v1.png" alt="러그 &amp; 발매트 특가 모음전" /></span>
					<span class="on"><img src="http://webimage.10x10.co.kr/eventIMG/2017/82766/img_discount_04_on_v1.png" alt="" /></span>
				</a>
			</li>
			<li class="event05">
				<a href="eventmain.asp?eventid=82898">
					<span class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2017/82766/img_discount_05_off.png" alt="키친 베스트 BRAND 5" /></span>
					<span class="on"><img src="http://webimage.10x10.co.kr/eventIMG/2017/82766/img_discount_05_on_v1.png" alt="" /></span>
				</a>
			</li>
			<li class="event06">
				<a href="eventmain.asp?eventid=82899">
					<span class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2017/82766/img_discount_06_off.png" alt="푸드 베스트 특가 모음전" /></span>
					<span class="on"><img src="http://webimage.10x10.co.kr/eventIMG/2017/82766/img_discount_06_on.png" alt="" /></span>
				</a>
			</li>
			<li class="event07">
				<a href="eventmain.asp?eventid=82902">
					<span class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2017/82766/img_discount_07_off.png" alt="캣앤독 베스트 BRAND 5" /></span>
					<span class="on"><img src="http://webimage.10x10.co.kr/eventIMG/2017/82766/img_discount_07_on.png" alt="" /></span>
				</a>
			</li>
			<li class="event08">
				<a href="eventmain.asp?eventid=82928">
					<span class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2017/82766/img_discount_08_off.png" alt="수제 브랜드전" /></span>
					<span class="on"><img src="http://webimage.10x10.co.kr/eventIMG/2017/82766/img_discount_08_on_v1.png" alt="" /></span>
				</a>
			</li>
			<li class="event09">
				<a href="eventmain.asp?eventid=82915">
					<span class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2017/82766/img_discount_09_off_v1.png" alt="BAG&amp;SHOES 브랜드대전" /></span>
					<span class="on thumbnail300px"><img src="http://webimage.10x10.co.kr/eventIMG/2017/82766/img_discount_09_on_v1.png" alt="" /></span>
				</a>
			</li>
			<li class="event10">
				<a href="eventmain.asp?eventid=82943">
					<span class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2017/82766/img_discount_10_off_v1.png" alt="오아 브랜드전" /></span>
					<span class="on"><img src="http://webimage.10x10.co.kr/eventIMG/2017/82766/img_discount_10_on.png" alt="" /></span>
				</a>
			</li>
			<li class="event11">
				<a href="eventmain.asp?eventid=82944">
					<span class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2017/82766/img_discount_11_off.png" alt="브래디백 할인전" /></span>
					<span class="on"><img src="http://webimage.10x10.co.kr/eventIMG/2017/82766/img_discount_11_on_v1.png" alt="" /></span>
				</a>
			</li>
			<li class="event12">
				<a href="eventmain.asp?eventid=82970">
					<span class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2017/82766/img_discount_12_off_v1.png" alt="패션 베스트 BRAND 6" /></span>
					<span class="on thumbnail300px"><img src="http://webimage.10x10.co.kr/eventIMG/2017/82766/img_discount_12_on_v1.png" alt="" /></span>
				</a>
			</li>
			<li class="event13">
				<a href="eventmain.asp?eventid=82903">
					<span class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2017/82766/img_discount_13_off_v1.png" alt="토이 베스트 BRAND 6" /></span>
					<span class="on"><img src="http://webimage.10x10.co.kr/eventIMG/2017/82766/img_discount_13_on_v1.png" alt="" /></span>
				</a>
			</li>
			<li class="event14">
				<a href="eventmain.asp?eventid=82950">
					<span class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2017/82766/img_discount_14_off_v1.png" alt="쥬얼리/시계 BEST ITEM" /></span>
					<span class="on thumbnail300px"><img src="http://webimage.10x10.co.kr/eventIMG/2017/82766/img_discount_14_on_v1.png" alt="" /></span>
				</a>
			</li>
			<li class="event15">
				<a href="eventmain.asp?eventid=82932">
					<span class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2017/82766/img_discount_15_off.png" alt="본격! 뷰티 월동 준비" /></span>
					<span class="on"><img src="http://webimage.10x10.co.kr/eventIMG/2017/82766/img_discount_15_on_v1.png" alt="" /></span>
				</a>
			</li>
			<li class="event16">
				<a href="eventmain.asp?eventid=83076">
					<span class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2017/82766/img_discount_16_off.png" alt="패브릭 베스트 BRAND 5" /></span>
					<span class="on"><img src="http://webimage.10x10.co.kr/eventIMG/2017/82766/img_discount_16_on.png" alt="" /></span>
				</a>
			</li>
		</ul>
	</div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->