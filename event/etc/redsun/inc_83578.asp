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
	eCode   =  83578
	getbonuscoupon1 = 1025	
	getbonuscoupon2 = 1026	
End If

'// 쿠폰 카운트
couponcnt = getbonuscoupontotalcount(getbonuscoupon1&","&getbonuscoupon2, "", "", "")

%>
<style type="text/css">
#contentWrap {padding-bottom:0;}
.red-sun {background-color:#120927;}
.red-sun .topic {position:relative;  height:818px; margin-bottom:-97px; background:#3c00b0 url(http://webimage.10x10.co.kr/eventIMG/2018/83578/bg_topic.jpg) 50% 0 no-repeat;}
.red-sun h2 {position:absolute; top:121px; left:50%; margin-left:-499px;}
.red-sun .slide {position:absolute; top:168px; left:50%; z-index:10; width:409px; height:266px; margin-left:9px;}
#slideshow div {position:absolute; top:0; left:0; z-index:8; opacity:0.0;}
#slideshow div.active {z-index:10; opacity:1.0;}
#slideshow div.last-active {z-index:9;}

.red-sun-coupon {position:relative; width:1206px; margin:0 auto 0;}
.red-sun-coupon h3 {position:absolute; top:432px; left:50%; margin-left:118px; cursor:pointer;}
.red-sun-coupon h3:hover {padding:0 118px 300px 0;}
.red-sun-coupon .btn-download,
.red-sun-coupon .coupon-close {position:absolute; top:323px; left:50%; margin-left:-126px; width:630px; height:80px; background:#f03d34 url(http://webimage.10x10.co.kr/eventIMG/2018/83578/txt_coupon.gif) 0 0 no-repeat; text-indent:-9999em;}
.red-sun-coupon .coupon-close {background-position:0 100%;}
.red-sun-coupon .label {position:absolute; top:65px; left:50%; margin-left:459px;}

.noti {display:none; position:absolute; top:467px; left:50%; width:410px; height:197px; margin-left:-16px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/82766/bg_pattern_purple.png) 50% 0 no-repeat;}
.noti ul {padding:47px 0 0 40px; text-align:left;}
.noti li {position:relative; padding-left:10px; color:#fff; font-family:'Gulim', '굴림', 'Verdana'; font-size:12px; line-height:24px;}
.noti li:after {content:' '; position:absolute; top:10px; left:0; width:5px; height:1px; background-color:currentColor;}

.red-sun-event-01 {padding-bottom:83px; background:#130a28 url(http://webimage.10x10.co.kr/eventIMG/2018/83578/bg_event_01.png) 50% 509px no-repeat;}
.red-sun-event-01 h3 {padding:52px 0 50px;}
.red-sun-event-01 ul {overflow:hidden; width:1206px; margin:0 auto;}
.red-sun-event-01 .event02 , .red-sun-event-01 .event03 {float:left; width:50%;}
.red-sun-event-01 a {display:block; position:relative;}
.red-sun-event-01 .on {position:absolute; top:0; left:50%; margin-left:-301px; transition:opacity 0.3s ease-in-out 0s; opacity:0;}
.red-sun-event-01 a:hover .on {opacity:1;}
.red-sun-event-01 .event01 .on {margin-left:-603px;}

.red-sun-event-02 {padding-bottom:135px; background:#6e209f;}
.red-sun-event-02 h3 {padding:160px 0 20px;}
.red-sun-event-02 .inner {position:relative; width:1175px; margin:0 auto;}
.red-sun-event-02 li {position:absolute;}
.red-sun-event-02 .event01 {left:47px; top:28px;}
.red-sun-event-02 .event02 {left:235px; top:0;}
.red-sun-event-02 .event03 {left:395px; top:76px;}
.red-sun-event-02 .event04 {left:349px; top:326px;}
.red-sun-event-02 .event05 {left:182px; top:440px;}
.red-sun-event-02 .event06 {left:20px; top:384px;}
.red-sun-event-02 .event07 {left:-30px; top:214px;}
.red-sun-event-02 .event08 {left:146px; top:168px;}
.red-sun-event-02 .event09 {left:639px; top:41px;}
.red-sun-event-02 .event10 {left:814px; top:0;}
.red-sun-event-02 .event11 {left:969px; top:117px;}
.red-sun-event-02 .event12 {left:982px; top:313px;}
.red-sun-event-02 .event13 {left:771px; top:401px;}
.red-sun-event-02 .event14 {left:598px; top:400px;}
.red-sun-event-02 .event15 {left:628px; top:212px;}
.red-sun-event-02 .event16 {left:808px; top:210px;}
.red-sun-event-02 li img {transition:opacity 0.3s ease-in-out 0s; opacity:0;}
.red-sun-event-02 li:hover img {opacity:1;}

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
	}, function () {
		isStopped = false;
	});

	$("#noti").hover(function() {
		$("#noticontents").fadeIn(100);
	});

	$("#noti").mouseleave(function() {
		$("#noticontents").fadeOut(100);
	});
});

function jsevtDownCoupon(stype,idx){
	<% If IsUserLoginOK() Then %>
		<% If now() > #01/15/2018 00:00:00# and now() < #01/16/2018 23:59:59# then %>
			var str = $.ajax({
				type: "POST",
				url: "/event/etc/coupon/couponshop_process.asp",
				data: "mode=cpok&stype="+stype+"&idx="+idx,
				dataType: "text",
				async: false
			}).responseText;
			var str1 = str.split("||")
			if (str1[0] == "11"){
				alert('쿠폰이 발급 되었습니다.\n1월 16일 자정까지 사용하세요.');
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
<div class="evt83578 red-sun">
	<div class="topic">
		<h2><img src="http://webimage.10x10.co.kr/eventIMG/2018/83578/tit_red_sun.png" alt="레드 썬! 데이 단, 2일 마법에 걸린 특급세일 지금 확인하세요!" /></h2>
		<div id="slideshow" class="slide">
			<div class="active"><img src="http://webimage.10x10.co.kr/eventIMG/2018/83578/img_upto_01.jpg" alt="Up to 92%" /></div>
			<div><img src="http://webimage.10x10.co.kr/eventIMG/2018/83578/img_upto_02.jpg" alt="" /></div>
			<div><img src="http://webimage.10x10.co.kr/eventIMG/2018/83578/img_upto_03.jpg" alt="" /></div>
			<div><img src="http://webimage.10x10.co.kr/eventIMG/2018/83578/img_upto_04.jpg" alt="" /></div>
		</div>
	</div>

	<div class="red-sun-coupon">
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2018/83578/img_coupon.png" alt="리얼쿠폰 진짜루? 할인에 할인을 도와주는 쿠폰! 6만원 이상 구매 시 만원 할인, 20만원 이상 삼만원 할인, 사용기간 01/15~16까지 2일간" /></p>
		<% If now() > #01/16/2018 00:00:00# Then %>
		<b class="label scale-animation"><img src="http://webimage.10x10.co.kr/eventIMG/2017/82766/img_label_close.png" alt="마감 임박" /></b>
		<% End If %>
		<button type="button" class="btn-download" onclick="jsevtDownCoupon('evtsel,evtsel','<%= getbonuscoupon1 %>,<%= getbonuscoupon2 %>'); return false;">쿠폰 한번에 다운받기</button>
		<h3 id="noti"><img src="http://webimage.10x10.co.kr/eventIMG/2018/83578/tit_noti.png" alt="이벤트 유의사항" /></h3>
		<div id="noticontents" class="noti">
			<ul>
				<li>이벤트는 ID 당 1회만 참여할 수 있습니다.</li>
				<li>지급된 쿠폰은 텐바이텐에서만 사용 가능 합니다.</li>
				<li>쿠폰은 01/16(화) 23시 59분 59초에 종료됩니다.</li>
				<li>주문한 상품에 따라, 배송비용은 추가로 발생할 수 있습니다.</li>
				<li>이벤트는 조기 마감될 수 있습니다.</li>
			</ul>
		</div>
	</div>

	<div class="red-sun-event-01">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2018/83578/tit_sale.png" alt="세일, 레드 썬 당신만을 위해 준비했어요!" /></h3>
		<ul>
			<li class="event01">
				<a href="eventmain.asp?eventid=83579">
					<span class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2018/83578/img_sale_01_off.png" alt="단독특가, 기대해! 연말 할인의 성장통, 텐바이텐 단독 세일 이벤트 바로가기" /></span>
					<span class="on"><img src="http://webimage.10x10.co.kr/eventIMG/2018/83578/img_sale_01_on.png" alt="" /></span>
				</a>
			</li>
			<li class="event02">
				<a href="eventmain.asp?eventid=83581">
					<span class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2018/83578/img_sale_02_off.png?v=1" alt="두고봐, 하나 더 줄거야! 이렇게 하나를 더? 이거 받아도 되는거에요? 이벤트 바로가기" /></span>
					<span class="on"><img src="http://webimage.10x10.co.kr/eventIMG/2018/83578/img_sale_02_on.png?v=1" alt="" /></span>
				</a>
			</li>
			<li class="event03">
				<a href="eventmain.asp?eventid=83580">
					<span class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2018/83578/img_sale_03_off.png?v=1" alt="숨지마~ 스크래치! 스크래치, 있는지 모를 정도의 퀄리티에 최저가로~ 이벤트 바로가기" /></span>
					<span class="on"><img src="http://webimage.10x10.co.kr/eventIMG/2018/83578/img_sale_03_on.png?v=1" alt="" /></span>
				</a>
			</li>
		</ul>
	</div>

	<div class="red-sun-event-02">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2018/83578/tit_discount.png?v=1.1" alt="할인이 왜 거기서 나와?" /></h3>
		<div class="inner">
			<div><img src="http://webimage.10x10.co.kr/eventIMG/2018/83578/img_discount.jpg?v=1" alt="" /></div>
			<ul>
				<li class="event01"><a href="eventmain.asp?eventid=83647"><img src="http://webimage.10x10.co.kr/eventIMG/2018/83578/img_discount_01.png?v=1" alt="푸드 BEST" /></a></li>
				<li class="event02"><a href="eventmain.asp?eventid=83648"><img src="http://webimage.10x10.co.kr/eventIMG/2018/83578/img_discount_02.png?v=1" alt="베이비 BEST" /></a></li>
				<li class="event03"><a href="eventmain.asp?eventid=83624"><img src="http://webimage.10x10.co.kr/eventIMG/2018/83578/img_discount_03.png?v=1" alt="가구 베스트 BRAND 12" /></a></li>
				<li class="event04"><a href="eventmain.asp?eventid=83641"><img src="http://webimage.10x10.co.kr/eventIMG/2018/83578/img_discount_04.png?v=1" alt="패브릭 베스트 BRAND 10" /></a></li>
				<li class="event05"><a href="eventmain.asp?eventid=83622"><img src="http://webimage.10x10.co.kr/eventIMG/2018/83578/img_discount_05.png?v=1" alt="트래블 BEST ITEM" /></a></li>
				<li class="event06"><a href="eventmain.asp?eventid=83618"><img src="http://webimage.10x10.co.kr/eventIMG/2018/83578/img_discount_06.png?v=1" alt="디자인가전 브랜드" /></a></li>
				<li class="event07"><a href="eventmain.asp?eventid=83625"><img src="http://webimage.10x10.co.kr/eventIMG/2018/83578/img_discount_07.png?v=1" alt="수납 베스트 BRAND 10" /></a></li>
				<li class="event08"><a href="eventmain.asp?eventid=83640"><img src="http://webimage.10x10.co.kr/eventIMG/2018/83578/img_discount_08.png?v=1" alt="패션 베스트 BRAND 10" /></a></li>
				<li class="event09"><a href="eventmain.asp?eventid=83672"><img src="http://webimage.10x10.co.kr/eventIMG/2018/83578/img_discount_09.png?v=1" alt="음향기기 베스트" /></a></li>
				<li class="event10"><a href="eventmain.asp?eventid=83637"><img src="http://webimage.10x10.co.kr/eventIMG/2018/83578/img_discount_10.png?v=1" alt="토이 베스트 BRAND 12" /></a></li>
				<li class="event11"><a href="eventmain.asp?eventid=83611"><img src="http://webimage.10x10.co.kr/eventIMG/2018/83578/img_discount_11.png?v=1" alt="주얼리/시계 BRAND" /></a></li>
				<li class="event12"><a href="eventmain.asp?eventid=83635"><img src="http://webimage.10x10.co.kr/eventIMG/2018/83578/img_discount_12.png?v=1" alt="캣앤독 베스트 BRAND 5" /></a></li>
				<li class="event13"><a href="eventmain.asp?eventid=83631"><img src="http://webimage.10x10.co.kr/eventIMG/2018/83578/img_discount_13.png?v=1" alt="키친 BEST" /></a></li>
				<li class="event14"><a href="eventmain.asp?eventid=83585"><img src="http://webimage.10x10.co.kr/eventIMG/2018/83578/img_discount_14.png?v=1" alt="잡화 BEST" /></a></li>
				<li class="event15"><a href="eventmain.asp?eventid=83610"><img src="http://webimage.10x10.co.kr/eventIMG/2018/83578/img_discount_15.png?v=1" alt="뷰티 BEST" /></a></li>
				<li class="event16"><a href="eventmain.asp?eventid=83630"><img src="http://webimage.10x10.co.kr/eventIMG/2018/83578/img_discount_16.png?v=1" alt="데코 BEST" /></a></li>
			</ul>
		</div>
	</div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->