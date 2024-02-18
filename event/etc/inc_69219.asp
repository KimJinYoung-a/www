<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 피크타입
' History : 2016.02.22 원승현 생성
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
		eCode = "66045"
	Else
		eCode = "69219"
	End If

currenttime = now()
'currenttime = #01/18/2016 10:05:00#

userid = GetEncLoginUserID()

dim couponidx
	IF application("Svr_Info") = "Dev" THEN
		couponidx = "11123"
	Else
		couponidx = "11474"
	End If

Dim selectitemid
	IF application("Svr_Info") = "Dev" THEN
		selectitemid = "1210578"
	Else
		selectitemid = "1439056"
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

if GetLoginUserID="greenteenz" or GetLoginUserID="djjung" or GetLoginUserID="bborami" or GetLoginUserID="kyungae13" or GetLoginUserID="tozzinet" or GetLoginUserID="thensi7" or GetLoginUserID="baboytw" then
	administrator=TRUE
end If

%>
<style type="text/css">
img {vertical-align:top;}
.evt68588 {position:relative; background:#fff;}
.title {position:relative;}
.title h2 {position:absolute; left:50%; margin-left:-218px;}
.slide {position:relative; width:1140px; background:#90b334;}
.slide .slidesjs-navigation {position:absolute; z-index:10; top:264px; width:32px; height:63px; text-indent:-999em; background:url(http://webimage.10x10.co.kr/eventIMG/2016/69219/btn_nav.png) no-repeat 0 0}
.slide .slidesjs-previous {left:147px;}
.slide .slidesjs-next {right:147px; background-position:100% 0;}
.getCoupon {overflow:hidden;}
.getCoupon div {position:relative;}
.getCoupon .goBuy {position:absolute; left:43px; top:136px; background:transparent;}
.evtNoti {overflow:hidden; height:150px; padding-top:42px; text-align:left; background:#694b31;}
.evtNoti h3 {float:left; padding:0 44px 0 103px;}
.evtNoti ul {float:left; padding-top:4px;}
.evtNoti ul li {line-height:13px; padding-bottom:10px; color:#edded1;}
.evtNoti ul li:first-child {position:relative; padding-right:143px;}
.evtNoti ul li a {display:inline-block; position:absolute; right:0; top:-6px;}
#couponLayer {position:absolute; left:0; top:0; width:100%; height:100%; z-index:50; background:url(http://webimage.10x10.co.kr/eventIMG/2016/69219/bg_mask.png) repeat 0 0;}
#couponLayer .resultCont {position:absolute; left:50%; top:600px; margin-left:-282px;}
#couponLayer .btnClose {position:absolute; right:40px; top:40px; background:transparent; z-index:60;}

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
		width:"1140",
		height:"565",
		pagination:false,
		navigation:{effect:"fade"},
		play:{interval:1700, effect:"fade", auto:true},
		effect:{fade: {speed:900, crossfade:true}
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

	/* title animation */
	titleAnimation()
	$('.title h2').css({'top':'108px'});
	function titleAnimation() {
		$('.title h2').delay(100).animate({top:'168px'},{duration: 'slow', easing: 'easeOutElastic'}, 800);
		$(".title h2 span").delay(700).animate({"margin-top":"0","margin-left":"0", "opacity":"1"},1000);
		$(".title .deco").delay(1800).animate({"opacity":"1"},800).addClass("swing");
	}
	
});

function jscoupondown(){
	<% If IsUserLoginOK() Then %>
		<% If not( left(currenttime,10)>="2016-02-23" and left(currenttime,10)<"2016-03-01" ) Then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return;
		<% else %>
			<% if GetLoginUserLevel<>"5" and not(administrator) then %>
				alert("고객님은 쿠폰발급 대상이 아닙니다.");
				return;
			<% else %>
				<% if administrator then %>
					alert("[관리자] 특별히 관리자님이니까 오렌지 등급이 아니여도 다음 단계로 진행 시켜 드릴께요!");
				<% end if %>
				var str = $.ajax({
					type: "POST",
					url: "/event/etc/doEventSubscript69219.asp",
					data: "mode=coupondown",
					dataType: "text",
					async: false
				}).responseText;
				//alert(str);
				var str1 = str.split("||")
				//alert(str1[0]);
				if (str1[0] == "11"){
					$("#couponLayer").empty().html(str1[1]);
					$("#couponLayer").show();
					window.parent.$('html,body').animate({scrollTop:700}, 500);
					return false;
				}else if (str1[0] == "10"){
					alert('데이터 처리에 예외 상황이 발생하였습니다. 관리자에게 문의해주십시오.');
					return false;
				}else if (str1[0] == "09"){
					$("#couponLayer").empty().html(str1[1]);
					$("#couponLayer").show();
					window.parent.$('html,body').animate({scrollTop:700}, 500);
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
					$("#couponLayer").empty().html(str1[1]);
					$("#couponLayer").show();
					window.parent.$('html,body').animate({scrollTop:700}, 500);
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
				}else if (str1[0] == "12"){
					alert('오전 10시부터 응모하실 수 있습니다.');
					return false;
				}else{
					alert('오류가 발생했습니다.');
					return false;
				}
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

function goDirOrdItem()
{
	document.directOrd.submit();
}

function poplayerclose()
{
	$("#couponLayer").hide();
	location.reload();
}

</script>

<% '<!-- 피크타임 --> %>
<div class="evt68588">
	<div class="title">
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/69219/txt_now.png" alt="한번도 사지 않은 지금이" /></p>
		<h2><img src="http://webimage.10x10.co.kr/eventIMG/2016/69219/tit_time.png" alt="피크타임" /></h2>
	</div>
	<div class="slide">
		<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/69219/img_slide_01.jpg" alt="" /></div>
		<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/69219/img_slide_02.jpg" alt="" /></div>
		<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/69219/img_slide_03.jpg" alt="" /></div>
		<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/69219/img_slide_04.jpg" alt="" /></div>
	</div>
	<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/69219/txt_price.png" alt="굴리굴리 피크닉 매트(랜덤 발송) : 쿠폰할인가 2,000원" /></p>
	<div class="getCoupon">
		<p class="ftLt"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69219/txt_process.gif" alt="" /></p>
		<div class="ftRt">
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/69219/txt_amazing_coupon.gif" alt="오늘 당신만을 위한 엄청난 쿠폰으로 첫 구매에 도전하세요!" /></p>
			<button class="goBuy" onclick="jscoupondown(); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69219/btn_buy.png" alt="쿠폰 받고 구매하러 가기" /></button>
		</div>
	</div>

	<%' 쿠폰받기 레이어 %>
	<div id="couponLayer" style="display:none"></div>
	<%'// 쿠폰받기 레이어 %>

	<div class="evtNoti">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/69219/tit_noti.png" alt="이벤트 유의사항" /></h3>
		<ul>
			<li>- 텐바이텐에서 한번도 구매이력이 없는 오렌지등급 고객님을 위한 이벤트입니다. <a href="/my10x10/special_info.asp" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69219/btn_grade.png" alt="회원등급 보러가기" /></a></li>
			<li>- 본 이벤트는 로그인 후에 참여가 가능합니다.</li>
			<li>- ID당 1회만 구매가 가능합니다.</li>
			<li>- 이벤트는 상품 품절 시 조기 마감 될 수 있습니다. </li>
			<li>- 이벤트는 즉시결제로만 구매가 가능하며, 배송 후 반품/교환/구매취소가 불가능합니다.</li>
		</ul>
	</div>
</div>
<% '<!-- // 피크타임 --> %>
<form method="post" name="directOrd" action="/inipay/shoppingbag_process.asp">
	<input type="hidden" name="itemid" value="<%=selectitemid%>">
	<input type="hidden" name="itemoption" value="0000">
	<input type="hidden" name="itemea" value="1">
	<input type="hidden" name="mode" value="DO1">
</form>
<!-- #include virtual="/lib/db/dbclose.asp" -->