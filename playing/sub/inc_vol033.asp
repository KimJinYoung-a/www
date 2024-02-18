<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/classes/item/itemInfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryPrdCls.asp" -->
<%
'####################################################
' Description : PLAYing Thing Bag
' History : 2018-01-19 정태훈 생성
'####################################################
%>
<%
dim oItem
dim currenttime
	currenttime =  now()
'	currenttime = #11/09/2016 09:00:00#

Dim userid , getbonuscoupon1 , couponcnt1
IF application("Svr_Info") = "Dev" THEN
	getbonuscoupon1 = 11167
Else
	getbonuscoupon1 = 13353
End If

couponcnt1=0

couponcnt1 = getitemcouponexistscount("",getbonuscoupon1, "", "")
'couponcnt1=40000

%>
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<base href="http://www.10x10.co.kr/">
<style type="text/css">
.thingVol033 button {background-color:transparent;}
.thingVol033 {text-align:center;}

.thingVol033 .top-cont {height:730px; background:#69be6b url(http://webimage.10x10.co.kr/playing/thing/vol033/bg_top.jpg) no-repeat 50% 0; animation:snowing 20s alternate 10; }
.thingVol033 .top-cont h2 {padding-top:235px;}

.intro {padding:44px 0 20px; background-color:#474747;}
.intro div{padding-top:20px; animation:bounce .8s 20;}

.section {position:relative; height:880px;}
.section > div {position:absolute; top:0; left:50%; width:50%; height:100%; margin-left:-50%;}
.section .sth {margin-left:0;}
.section div .inner {position:absolute; top:0; width:570px; height:100%;}
.section .nth .inner {right:0;}
.section .sth .inner {left:0;}
.section .thumb {position:absolute; top:0; z-index:5; opacity:0;}
.section .nth .thumb {right:-1px;}
.section .sth .thumb {left:0;}
.section p,
.section em,
.section span {display:block; position:relative; z-index:10; opacity:0;}
.section div p {width:247px; height:42px; margin:110px auto 25px; padding-top:20px; background:url(http://webimage.10x10.co.kr/playing/thing/vol033/img_box_wht.png);}
.section .sth p {background:url(http://webimage.10x10.co.kr/playing/thing/vol033/img_box_blck.png);}
.section div em {margin-bottom:50px}
.section1 div p {margin:220px auto 40px;}

.section1 .nth{background:#f9d807 url(http://webimage.10x10.co.kr/playing/thing/vol033/img_nth_1.jpg) no-repeat 100% 0;}
.section1 .sth{background:#fff url(http://webimage.10x10.co.kr/playing/thing/vol033/img_sth_1.jpg) no-repeat 0 0;}
.section2 .nth{background:#ffd8b6;}
.section2 .sth{background:#ff852b;}
.section3 .nth{background:#d0d3ff;}
.section3 .sth{background:#8a9bff;}
.section4 .nth{background:#bbecff;}
.section4 .sth{background:#42cbed;}
.section5 .nth{background:#ffdaea;}
.section5 .sth{background:#ff98bc;}

.thing-item {overflow:hidden; width:1140px; margin:0 auto;}
.thing-item div {float:left; width:50%;}
.thing-item .detail {position:relative; padding-top:130px;}
.thing-item .detail a {position:absolute; top:385px; left:112px; animation:slideX .7s 100;}

.thing-evt { padding-top:120px; height:360px; background:#fffcc6 url(http://webimage.10x10.co.kr/playing/thing/vol033/bg_evt.jpg);}
.thing-evt .wrap {overflow:hidden; width:1140px; margin:0 auto;}
.thing-evt .wrap > div{float:left;}
.thing-evt .detail {padding:0 186px 0 108px;}
.thing-evt .cheer-up p{position:relative; height:39px; padding:0 30px; background-color:#fff; line-height:39px; font-size:12px; color:#i353535; font-weight:bold; border-radius:18px;}
.thing-evt .cheer-up p:after {content:' '; position:absolute; bottom:-20px; left:50%; z-index:30; margin-left:-11px; width:22px; height:20px; background:url(http://webimage.10x10.co.kr/playing/thing/vol033/img_num.png);}
.thing-evt .cheer-up em {color:#db0c0c;}
.thing-evt .cheer-up button,
.thing-evt .cheer-up .closed {position:relative; padding-top:8px; z-index:10;}
.pop-ly {position:fixed; top:0; left:0; width:100%; height:100%; z-index:10; background-color:rgba(0, 0, 0, .5);}
.pop-ly div {position:absolute; top: 50%; left: 50%; margin-right:-50%; transform: translate(-50%, -50%);}
.pop-ly button {position:absolute; top:-8px; right:-9px;}
.pop-ly a {display:inline-block; position:absolute; bottom:25px; left:50%; width:60%; height:40px; margin-left:-30%; text-indent:-999em;}

/* 애니메이션 */
.typing {overflow:hidden; display:inline-block; animation:typing .8s .5s steps(7, end) forwards; opacity:0;}
.slideY {animation:slideY .5s 1 forwards;}
.slideY1 {animation:slideY .5s .2s 1 forwards;}
.slideY2 {animation:slideY .6s .2s 1 forwards;}
.slideY3 {animation:slideY .8s .2s 1 forwards;}
@keyframes snowing {
	0% {background-position:50% 0;}
	100% {background-position:50% -175px;}
}
@keyframes bounce {
	from, to {transform:translateY(0); animation-timing-function:ease-out;}
	50% {transform:translateY(8px); animation-timing-function:ease-in;}
}
@keyframes typing {
	from {width:0; opacity:0;}
	1% {opacity:1;}
	to {width: 100%; opacity:1;}
}
@keyframes slideY {
	from{transform:translateY(15px); opacity:0;}
	 to {transform:translateY(0); opacity:1;}
}
@keyframes slideX {
	from,to{transform:translateX(0);}
	 50% {transform:translateX(10px);}
}
</style>
<script style="text/javascript">
$(function(){
	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 900) {
			$(".section1 .nth p").addClass("slideY");
			$(".section1 .nth em").addClass("slideY1");
			$(".section1 .nth p strong").addClass("typing");
			window.setTimeout(function(){
			$(".section1 .sth p").addClass("slideY");
			$(".section1 .sth em").addClass("slideY1");
			$(".section1 .sth p strong").addClass("typing");
			}, 1000);
		}
		if (scrollTop > 1700) {
			$(".section2 .nth .thumb").addClass("slideY");
			$(".section2 .nth p").addClass("slideY1");
			$(".section2 .nth em").addClass("slideY2");
			$(".section2 .nth span").addClass("slideY3");
			$(".section2 .nth p strong").addClass("typing");
			window.setTimeout(function(){
			$(".section2 .sth .thumb").addClass("slideY");
			$(".section2 .sth p").addClass("slideY1");
			$(".section2 .sth em").addClass("slideY2");
			$(".section2 .sth span").addClass("slideY3");
			$(".section2 .sth p strong").addClass("typing");
			}, 800);
		}
		if (scrollTop > 2600) {
			$(".section3 .nth .thumb").addClass("slideY");
			$(".section3 .nth p").addClass("slideY1");
			$(".section3 .nth em").addClass("slideY2");
			$(".section3 .nth span").addClass("slideY3");
			$(".section3 .nth p strong").addClass("typing");
			window.setTimeout(function(){
			$(".section3 .sth .thumb").addClass("slideY");
			$(".section3 .sth p").addClass("slideY1");
			$(".section3 .sth em").addClass("slideY2");
			$(".section3 .sth span").addClass("slideY3");
			$(".section3 .sth p strong").addClass("typing");
			}, 800);
		}
		if (scrollTop > 3300) {
			$(".section4 .nth .thumb").addClass("slideY");
			$(".section4 .nth p").addClass("slideY1");
			$(".section4 .nth em").addClass("slideY2");
			$(".section4 .nth span").addClass("slideY3");
			$(".section4 .nth p strong").addClass("typing");
			window.setTimeout(function(){
			$(".section4 .sth .thumb").addClass("slideY");
			$(".section4 .sth p").addClass("slideY1");
			$(".section4 .sth em").addClass("slideY2");
			$(".section4 .sth span").addClass("slideY3");
			$(".section4 .sth p strong").addClass("typing");
			}, 800);
		}
		if (scrollTop > 4200) {
			$(".section5 .nth .thumb").addClass("slideY");
			$(".section5 .nth p").addClass("slideY1");
			$(".section5 .nth em").addClass("slideY2");
			$(".section5 .nth span").addClass("slideY3");
			$(".section5 .nth p strong").addClass("typing");
			window.setTimeout(function(){
			$(".section5 .sth .thumb").addClass("slideY");
			$(".section5 .sth p").addClass("slideY1");
			$(".section5 .sth em").addClass("slideY2");
			$(".section5 .sth span").addClass("slideY3");
			$(".section5 .sth p strong").addClass("typing");
			}, 1000);
		}
	});
	$(".pop-ly").hide();
	/*$(".pop-ly button").on("click", function(e){
		$(".pop-ly").hide();
	});*/
});
</script>
<script type="text/javascript">
function jsevtDownCoupon(stype,idx){
	<% If IsUserLoginOK() Then %>
		<% If now() > #02/05/2018 23:59:59# then %>
			alert("이벤트 기간이 아닙니다.");
			return;
		<% else %>
			var str = $.ajax({
				type: "POST",
				url: "/event/etc/coupon/couponshop_process.asp",
				data: "mode=cpok&stype="+stype+"&idx="+idx,
				dataType: "text",
				async: false
			}).responseText;
			var str1 = str.split("||")
			if (str1[0] == "11"){
				$(".pop-ly").show();
				$("#tcnt").empty().html(numberWithCommas(Number(<%=couponcnt1%>)+1));
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
		<% end if %>
	<% Else %>
		if(confirm("로그인 후 쿠폰을 받을 수 있습니다!")){
			top.location.href="/login/loginpage.asp?vType=G";
			return false;
		}
		return false;
	<% End IF %>
}
function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
</script>

						<div class="thingVol033">

							<div class="top-cont">
								<h2><img src="http://webimage.10x10.co.kr/playing/thing/vol033/tit_bag.png" alt="thing bag" /></h2>
							</div>
							<div class="intro">
								<img src="http://webimage.10x10.co.kr/playing/thing/vol033/txt_intro.png" alt="PLAYing에서 만든 THING BAG SET와 함께하세요!" />
								<div><img src="http://webimage.10x10.co.kr/playing/thing/vol033/btn_arrow.png" alt="" /></div>
							</div>
							<div class="section section1">
								<div class="nth">
									<div class="inner">
										<p><strong><img src="http://webimage.10x10.co.kr/playing/thing/vol033/txt_nth_1.png" alt="아무것도 아닌 것" /></strong></p>
										<em><img src="http://webimage.10x10.co.kr/playing/thing/vol033/txt_nth.png" alt="nothing" /></em>
									</div>
								</div>
								<div class="sth">
									<div class="inner">
										<p><strong><img src="http://webimage.10x10.co.kr/playing/thing/vol033/txt_sth_1.png" alt="특별한 것" /></strong></strong></p>
										<em><img src="http://webimage.10x10.co.kr/playing/thing/vol033/txt_sth.png" alt="something" /></em>
									</div>
								</div>
							</div>
							<div class="section section2">
								<div class="nth">
									<div class="inner">
										<p><strong><img src="http://webimage.10x10.co.kr/playing/thing/vol033/txt_nth_2.png" alt="2017" /></strong></p>
										<em><img src="http://webimage.10x10.co.kr/playing/thing/vol033/txt_nth.png" alt="nothing" /></em>
										<span><img src="http://webimage.10x10.co.kr/playing/thing/vol033/txt_nth_sub_2.png" alt="잘 가요 2017년! 버리지 못했던 좋지 않은 기억을 담으세요" /></span>
										<div class="thumb"><img src="http://webimage.10x10.co.kr/playing/thing/vol033/img_nth_2.jpg" alt="" /></div>
									</div>
								</div>
								<div class="sth">
									<div class="inner">
										<p><strong><img src="http://webimage.10x10.co.kr/playing/thing/vol033/txt_sth_2.png" alt="2018" /></strong></p>
										<em><img src="http://webimage.10x10.co.kr/playing/thing/vol033/txt_sth.png" alt="something" /></em>
										<span><img src="http://webimage.10x10.co.kr/playing/thing/vol033/txt_sth_sub_2.png" alt="앞으로 새롭게 시작할 2018년! 새로운 기대를 담으세요" /></span>
										<div class="thumb"><img src="http://webimage.10x10.co.kr/playing/thing/vol033/img_sth_2.jpg" alt="" /></div>
									</div>
								</div>
							</div>
							<div class="section section3">
								<div class="nth">
									<div class="inner">
										<p><strong><img src="http://webimage.10x10.co.kr/playing/thing/vol033/txt_nth_3.png" alt="do" /></strong></p>
										<em><img src="http://webimage.10x10.co.kr/playing/thing/vol033/txt_nth.png" alt="nothing" /></em>
										<span><img src="http://webimage.10x10.co.kr/playing/thing/vol033/txt_nth_sub_3.png" alt="구겨졌던 쓴 기억들은 펼치지 말아요!" /></span>
										<div class="thumb"><img src="http://webimage.10x10.co.kr/playing/thing/vol033/img_nth_3.jpg" alt="" /></div>
									</div>
								</div>
								<div class="sth">
									<div class="inner">
										<p><strong><img src="http://webimage.10x10.co.kr/playing/thing/vol033/txt_sth_3.png" alt="do" /></strong></p>
										<em><img src="http://webimage.10x10.co.kr/playing/thing/vol033/txt_sth.png" alt="something" /></em>
										<span><img src="http://webimage.10x10.co.kr/playing/thing/vol033/txt_sth_sub_3.png" alt="새로운 것들, 새로운 이야기는 펼칠 준비를 해도 좋아요!" /></span>
										<div class="thumb"><img src="http://webimage.10x10.co.kr/playing/thing/vol033/img_sth_3.jpg" alt="" /></div>
									</div>
								</div>
							</div>
							<div class="section section4">
								<div class="nth">
									<div class="inner">
										<p><strong><img src="http://webimage.10x10.co.kr/playing/thing/vol033/txt_nth_4.png" alt="hello" /></strong></p>
										<em><img src="http://webimage.10x10.co.kr/playing/thing/vol033/txt_nth.png" alt="nothing" /></em>
										<span><img src="http://webimage.10x10.co.kr/playing/thing/vol033/txt_nth_sub_4.png" alt="떠나 보내야 할 것들은 꾹꾹 담아서 새어 나오지 않게 묶어 주세요" /></span>
										<div class="thumb"><img src="http://webimage.10x10.co.kr/playing/thing/vol033/img_nth_4.jpg" alt="" /></div>
									</div>
								</div>
								<div class="sth">
									<div class="inner">
										<p><strong><img src="http://webimage.10x10.co.kr/playing/thing/vol033/txt_sth_4.png" alt="bye" /></strong></p>
										<em><img src="http://webimage.10x10.co.kr/playing/thing/vol033/txt_sth.png" alt="something" /></em>
										<span><img src="http://webimage.10x10.co.kr/playing/thing/vol033/txt_sth_sub_4.png" alt="보송보송한 마음으로  새로운 시작을 기도해보아요!" /></span>
										<div class="thumb"><img src="http://webimage.10x10.co.kr/playing/thing/vol033/img_sth_4.jpg" alt="" /></div>
									</div>
								</div>
							</div>
							<div class="section section5">
								<div class="nth">
									<div class="inner">
										<p><strong><img src="http://webimage.10x10.co.kr/playing/thing/vol033/txt_nth_5.png" alt="no think" /></strong></p>
										<em><img src="http://webimage.10x10.co.kr/playing/thing/vol033/txt_nth.png" alt="nothing" /></em>
										<span><img src="http://webimage.10x10.co.kr/playing/thing/vol033/txt_nth_sub_5.png" alt="오늘부터  아무것도 아닌 것에 깊은 생각 금지!" /></span>
										<div class="thumb"><img src="http://webimage.10x10.co.kr/playing/thing/vol033/img_nth_5.jpg" alt="" /></div>
									</div>
								</div>
								<div class="sth">
									<div class="inner">
										<p><strong><img src="http://webimage.10x10.co.kr/playing/thing/vol033/txt_sth_5.png" alt="some think" /></strong></p>
										<em><img src="http://webimage.10x10.co.kr/playing/thing/vol033/txt_sth.png" alt="something" /></em>
										<span><img src="http://webimage.10x10.co.kr/playing/thing/vol033/txt_sth_sub_5.png" alt="오늘부터  어떤 일에도 특별하게 생각하기!" /></span>
										<div class="thumb"><img src="http://webimage.10x10.co.kr/playing/thing/vol033/img_sth_5.jpg" alt="" /></div>
									</div>
								</div>
							</div>

							<!-- 상품 -->
							<div class="thing-item">
								<div class="detail">
									<img src="http://webimage.10x10.co.kr/playing/thing/vol033/txt_prd.gif" alt="THING BAG set (NOTHING BAG + SOMETHING BAG) " />
									<a href="/shopping/category_prd.asp?itemid=1879853" target="_blank"><img src="http://webimage.10x10.co.kr/playing/thing/vol033/btn_buy.png" alt="구매하러 가기" /></a>
								</div>
								<div class="thumb"><img src="http://webimage.10x10.co.kr/playing/thing/vol033/img_bag.jpg" alt="limited edition" /></div>
							</div>

							<!-- 이벤트 -->
							<div class="thing-evt">
								<div class="wrap">
									<div class="detail"><img src="http://webimage.10x10.co.kr/playing/thing/vol033/txt_evnt.png" alt="플레잉에서 만든 THING BAG을 응원해주세요! 관심을 가져주시는 만큼 힘을 얻어 150개 한정을 넘어서 더 많이 만나볼 수 있도록 제작하겠습니다. 응원해주시는 고객님들에게 THING BAG sET  10% 추가 할인 쿠폰 을 드립니다! 이벤트 기간 : 1.22(월) -2.5(월)" /></div>
									<div class="cheer-up">
										<!-- for dev msg 이벤트 참여 인원수 --><p>총 <em id="tcnt"><%=FormatNumber(couponcnt1,0)%></em>명이 THING BAG을 응원했습니다.</p>
										<!-- <button onclick="jsevtDownCoupon('prd','<%= getbonuscoupon1 %>'); return false;"><img src="http://webimage.10x10.co.kr/playing/thing/vol033/btn_pop_up_closed.png" alt="THING BAG 응원하기" /></button> -->
										<div class="closed"><img src="http://webimage.10x10.co.kr/playing/thing/vol033/btn_pop_up_closed.png" alt="응원종료" /></div>
									</div>
								</div>
								<div class="pop-ly">
									<div>
										<img src="http://webimage.10x10.co.kr/playing/thing/vol033/txt_ly.png" alt="응모완료! 감사합니다! thing bag SET 추가할인 쿠폰이 발급 되었습니다 추가할인 쿠폰 10%" />
										<a href="/my10x10/couponbook.asp" target="_blank">내 쿠폰함 바로가기</a>
										<button><img src="http://webimage.10x10.co.kr/playing/thing/vol033/btn_close.png" alt="닫기" /></button>
									</div>
								</div>
							</div>
						</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->