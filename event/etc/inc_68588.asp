<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 오렌지족
' History : 2016.01.14 한용민 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->

<% '<!-- #include virtual="/lib/inc/head.asp" --> %>

<%
dim eCode, userid, currenttime, i
	IF application("Svr_Info") = "Dev" THEN
		eCode = "66002"
	Else
		eCode = "68588"
	End If

currenttime = now()
'currenttime = #01/18/2016 10:05:00#

userid = GetEncLoginUserID()

dim couponidx
	IF application("Svr_Info") = "Dev" THEN
		couponidx = "11116"
	Else
		couponidx = "11429"
	End If

dim subscriptcount, itemcouponcount
subscriptcount=0
itemcouponcount=0

'//본인 참여 여부
if userid<>"" then
	subscriptcount = getevent_subscriptexistscount(eCode, userid, "", "", "")
	itemcouponcount = getitemcouponexistscount(userid, couponidx, "", "")
end if
'response.write GetUserStrlarge(GetLoginUserLevel) & "/" & GetLoginUserLevel

dim administrator
	administrator=FALSE

if GetLoginUserID="greenteenz" or GetLoginUserID="djjung" or GetLoginUserID="bborami" or GetLoginUserID="kyungae13" or GetLoginUserID="tozzinet" then
	administrator=TRUE
end if

%>
<style type="text/css">
img {vertical-align:top;}
.evt68588 {position:relative; background:#fff;}
.title {position:relative;}
.title .you {position:absolute; left:50%; top:101px; margin-left:-127px;}
.title h2 span {display:block; position:absolute;}
.title h2 span.t01 {left:293px; top:163px;}
.title h2 span.t02 {left:439px; top:158px;}
.title h2 span.t03 {left:536px; top:152px;}
.title h2 span.t04 {left:651px; top:159px;}
.title .deco {position:absolute; left:295px; top:254px;}
.socksView {overflow:hidden;}
.socksView .ftLt {width:670px;}
.socksView .ftRt {width:470px;}
.getCoupon {position:relative;}
.getCoupon .goBuy {position:absolute; left:610px; top:159px; background:transparent;}
.slide {position:relative; width:670px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/68588/bg_socks.png) no-repeat 0 0;}
.slidesjs-pagination {overflow:hidden; position:absolute; bottom:178px; left:294px; z-index:50; width:114px;}
.slidesjs-pagination li {float:left; padding:0 1px;}
.slidesjs-pagination li a {display:block; width:26px; height:31px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/68588/btn_pagination.png) no-repeat 0 0; text-indent:-999em;}
.slidesjs-pagination li a.active {background-position:100% 0;}
.evtNoti {overflow:hidden; height:150px; padding-top:42px; text-align:left; background:#e5e5e5;}
.evtNoti h3 {float:left; padding:0 44px 0 103px;}
.evtNoti ul {float:left; padding-top:4px;}
.evtNoti ul li {line-height:13px; padding-bottom:10px; color:#727272;}
#couponLayer {position:absolute; left:0; top:0; width:100%; height:100%; z-index:50; background:url(http://webimage.10x10.co.kr/eventIMG/2016/68588/bg_mask.png) repeat 0 0;}
#couponLayer .resultCont {position:absolute; left:50%; top:600px; margin-left:-282px;}
#couponLayer .btnClose {position:absolute; right:22px; top:22px; background:transparent; z-index:60;}

/* animation */
.swing {-webkit-animation: swing 1s ease-in-out 1s 30 alternate; -moz-animation: swing 1s ease-in-out 1s 30 alternate; -ms-animation: swing 1s ease-in-out 1s 30 alternate; -o-animation: swing 1s ease-in-out 1s 30 alternate; animation: swing 1s ease-in-out 1s 30 alternate;}
@keyframes swing {from {transform: rotate(15deg) translate(-5px,0);} to {transform: rotate(-10deg) translate(5px,0);}}
@-webkit-keyframes swing { from {-webkit-transform: rotate(10deg) translate(-5px,0);} to {-webkit-transform: rotate(-10deg) translate(5px,0);}}
@-moz-keyframes swing {from {-moz-transform: rotate(10deg) translate(-5px,0);} to{-moz-transform: rotate(-10deg) translate(5px,0);}}
@-o-keyframes swing {from {-o-transform: rotate(10deg) translate(-5px,0);} to {-o-transform: rotate(-10deg) translate(5px,0);}}
@-ms-keyframes swing {from {-ms-transform: rotate(10deg) translate(-5px,0);} to {-ms-transform: rotate(-10deg) translate(5px,0);}}

.goBuy {-webkit-animation: move 0.3s ease-in-out 0s 100 alternate; -moz-animation: move 0.3s ease-in-out 0s 100 alternate; -ms-animation: move 0.3s ease-in-out 0s 100 alternate; -o-animation: move 0.3s ease-in-out 0s 100 alternate; animation: move 0.3s ease-in-out 0s 100 alternate;}
@keyframes move {from {transform:translate(-3px,0);} to {transform:translate(3px,0);}}
@-webkit-keyframes move { from {-webkit-transform:translate(-3px,0);} to {-webkit-transform:translate(3px,0);}}
@-moz-keyframes move {from {-moz-transform:translate(-3px,0);} to{-moz-transform:translate(3px,0);}}
@-o-keyframes move {from {-o-transform:translate(-3px,0);} to {-o-transform:translate(3px,0);}}
@-ms-keyframes move {from {-ms-transform:translate(-3px,0);} to {-ms-transform:translate(3px,0);}}
</style>
<script type="text/javascript">

$(function(){
	$(".slide").slidesjs({
		width:"670",
		height:"416",
		pagination:{effect:"fade"},
		navigation:false,
		play:{interval:2700, effect:"fade", auto:true},
		effect:{fade: {speed:700, crossfade:true}
		},
		callback: {
			complete: function(number) {
				var pluginInstance = $('.slide').data('plugin_slidesjs');
				setTimeout(function() {
					pluginInstance.play(true);
				}, pluginInstance.options.play.interval);
			}
		}
	});

//	$(".goBuy").click(function(){
//		$("#couponLayer").show();
//		window.parent.$('html,body').animate({scrollTop:700}, 500);
//	});
	$(".btnClose").click(function(){
		$("#couponLayer").hide();
		location.reload();
	});

	/* title animation */
	titleAnimation()
	$(".title h2 span").css({"opacity":"0"});
	$(".title h2 .t01").css({"margin-left":"-70px"});
	$(".title h2 .t02").css({"margin-top":"30px"});
	$(".title h2 .t03").css({"margin-top":"-30px"});
	$(".title h2 .t04").css({"margin-left":"70px"});
	$(".title .deco").css({"opacity":"0"});
	function titleAnimation() {
		$('.title .you').delay(100).effect( "bounce", {times:2}, 800);
		$(".title h2 span").delay(700).animate({"margin-top":"0","margin-left":"0", "opacity":"1"},1000);
		$(".title .deco").delay(1800).animate({"opacity":"1"},800).addClass("swing");
	}
	
});

function jscoupondown(){
	<% If IsUserLoginOK() Then %>
		<% If not( left(currenttime,10)>="2016-01-18" and left(currenttime,10)<"2016-01-23" ) Then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return;
		<% else %>
			<% if subscriptcount>0 or itemcouponcount>0 then %>
				//alert("한 개의 아이디당 한 번만 응모가 가능 합니다.");
				$(".intro").fadeOut(300);
				$("#coupondownno").hide();
				$("#coupondownyes").show();
				$("#couponLayer").fadeIn(300);
				return;
			<% else %>
				<% if GetLoginUserLevel<>"5" and not(administrator) then %>
					alert("고객님은 쿠폰발급 대상이 아닙니다.");
					return;
				<% else %>
					<% if administrator then %>
						alert("[관리자] 특별히 관리자님이니까 오렌지 등급이 아니여도 다음 단계로 진행 시켜 드릴께요!");
					<% end if %>

					<% 'if Hour(currenttime) < 10 then %>
						//alert("쿠폰은 오전 10시부터 다운 받으실수 있습니다.");
						//return;
					<% 'else %>
						var str = $.ajax({
							type: "POST",
							url: "/event/etc/doeventsubscript/doEventSubscript68588.asp",
							data: "mode=coupondown",
							dataType: "text",
							async: false
						}).responseText;
						//alert(str);
						var str1 = str.split("||")
						//alert(str1[0]);
						if (str1[0] == "11"){
							$("#coupondownyes").hide();
							$("#coupondownno").show();
							$("#couponLayer").show();
							window.parent.$('html,body').animate({scrollTop:700}, 500);
							return false;
						}else if (str1[0] == "10"){
							alert('데이터 처리에 예외 상황이 발생하였습니다. 관리자에게 문의해주십시오.');
							return false;
						}else if (str1[0] == "09"){
							alert('이미 쿠폰을 받으셨습니다.');
							return false;
						}else if (str1[0] == "08"){
							alert('기간이 종료되었거나 유효하지 않은 쿠폰입니다.');
							return false;
						}else if (str1[0] == "07"){
							alert('데이터 처리에 문제가 발생하였습니다. 관리자에게 문의해주십시오.');
							return false;
						}else if (str1[0] == "06"){
							alert('쿠폰은 오전 10시부터 다운 받으실수 있습니다.');
							return false;
						}else if (str1[0] == "05"){
							alert('고객님은 쿠폰발급 대상이 아닙니다.');
							return false;
						}else if (str1[0] == "04"){
							alert('한 개의 아이디당 한 번만 응모가 가능 합니다.');
							return false;
						}else if (str1[0] == "03"){
							alert('이벤트 응모 기간이 아닙니다.');
							return false;
						}else if (str1[0] == "03"){
							alert('이벤트 응모 기간이 아닙니다.');
							return false;
						}else if (str1[0] == "02"){
							alert('로그인을 해주세요.');
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
					<% 'end if %>
				<% end if %>
			<% end if %>
		<% end if %>
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return false;
		}
		return false;
	<% End IF %>
}

</script>

<% '<!-- 오렌지족 --> %>
<div class="evt68588">
	<div class="title">
		<p class="you"><img src="http://webimage.10x10.co.kr/eventIMG/2016/68588/txt_nothing.png" alt="한번도 사지 않은 당신은" /></p>
		<h2>
			<span class="t01"><img src="http://webimage.10x10.co.kr/eventIMG/2016/68588/tit_orange_01.png" alt="오" /></span>
			<span class="t02"><img src="http://webimage.10x10.co.kr/eventIMG/2016/68588/tit_orange_02.png" alt="렌" /></span>
			<span class="t03"><img src="http://webimage.10x10.co.kr/eventIMG/2016/68588/tit_orange_03.png" alt="지" /></span>
			<span class="t04"><img src="http://webimage.10x10.co.kr/eventIMG/2016/68588/tit_orange_04.png" alt="족" /></span>
		</h2>
		<div class="deco"><img src="http://webimage.10x10.co.kr/eventIMG/2016/68588/img_socks.png" alt="" /></div>
		<p class="desc"><img src="http://webimage.10x10.co.kr/eventIMG/2016/68588/txt_info.gif" alt="텐바이텐 오렌지족이란? 신규가입회원, 구매경험이 없는 고객" /></p>
	</div>
	<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/68588/txt_process.png" alt="쿠폰발급받고 구매하러가기→원하는 세트 고르기→쿠폰 사용하여 결제하기" /></div>
	<div class="socksView">
		<div class="ftLt">
			<div class="slide">
				<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/68588/img_slide_01.png" alt="" /></div>
				<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/68588/img_slide_02.png" alt="" /></div>
				<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/68588/img_slide_03.png" alt="" /></div>
				<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/68588/img_slide_04.png" alt="" /></div>
			</div>
		</div>
		<div class="ftRt"><img src="http://webimage.10x10.co.kr/eventIMG/2016/68588/txt_price.png" alt="델리삭스 SET - 2000원(쿠폰할인가)" /></div>
	</div>
	<div class="getCoupon">
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/68588/txt_first_buy.png" alt="오늘 당신만을 위한 엄청난 가격으로 첫 구매에 도전하세요!" /></p>
		<button class="goBuy" onclick="jscoupondown(); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/68588/btn_buy.png" alt="쿠폰 받으러 가기" /></button>
	</div>

	<% '<!-- 쿠폰받기 레이어 --> %>
	<div id="couponLayer" style="display:none">
		<div class="resultCont">
			<a href="/shopping/category_prd.asp?itemid=1422226" target="_blank">
				<% if subscriptcount>0 or itemcouponcount>0 then %>
					<% ' <!-- 이미 발급 받은 경우 --> %>
					<img id="coupondownyes" src="http://webimage.10x10.co.kr/eventIMG/2016/68588/img_layer_buy_02.png" alt="이미 쿠폰이 발급되었습니다" />
				<% else %>
					<img id="coupondownno" src="http://webimage.10x10.co.kr/eventIMG/2016/68588/img_layer_buy_01.png" alt="쿠폰이 발급되었습니다" />
				<% end if %>
			</a>
			<button class="btnClose"><img src="http://webimage.10x10.co.kr/eventIMG/2016/68588/btn_layer_close.png" alt="닫기" /></button>
		</div>
	</div>

	<div class="evtNoti">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/68588/tit_noti.png" alt="이벤트 유의사항" /></h3>
		<ul>
			<li>- 텐바이텐에서 한번도 구매이력이 없는 오렌지등급 고객님을 위한 이벤트입니다.</li>
			<li>- 본 이벤트는 로그인 후에 참여가 가능합니다.</li>
			<li>- ID 당 1회만 구매가 가능합니다.</li>
			<li>- 이벤트는 조기 마감 될 수 있습니다.</li>
			<li>- 본 상품은 즉시결제로만 구매가 가능하며, 배송 후 반품/교환/구매취소가 불가능합니다.</li>
		</ul>
	</div>
</div>
<% '<!-- // 오렌지족 --> %>

<!-- #include virtual="/lib/db/dbclose.asp" -->