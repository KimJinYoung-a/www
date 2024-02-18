<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 방가방가 첫 구매! WWW
' History : 2016.03.11 유태욱 생성
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
		eCode = "66061"
	Else
		eCode = "69628"
	End If

currenttime = now()
'															currenttime = #03/14/2016 10:05:00#

userid = GetEncLoginUserID()

dim couponidx
	IF application("Svr_Info") = "Dev" THEN
		couponidx = "11124"
	Else
		couponidx = "11492"
	End If

Dim selectitemid
	IF application("Svr_Info") = "Dev" THEN
		selectitemid = "1210578"
	Else
		selectitemid = "1450183"
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
.dailylike {position:relative; text-align:center; padding-bottom:55px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/69628/bg_stripe.png) repeat-y 0 0;}
.dailylike .swiper-container {overflow:hidden; position:relative; width:100%; height:554px;}
.dailylike .swiper-wrapper {position:relative; width:100%;}
.dailylike .swiper-slide {position:relative; float:left; width:570px !important;}
.dailylike button {display:block; position:absolute; top:292px; z-index:40; background:transparent;}
.dailylike .prev {left:254px;}
.dailylike .next {right:254px;}
.getCoupon {position:relative;}
.getCoupon .goBuy {position:absolute; left:50%; top:120px; margin-left:-169px; background:transparent;}
.evtNoti {overflow:hidden; padding:32px 0 32px 5px; text-align:left; background:#4d393b;}
.evtNoti h3 {float:left; width:352px; text-align:center; padding-top:52px;}
.evtNoti ul {float:left; width:700px; padding-top:4px; border-left:1px solid #6c5053;}
.evtNoti ul li {position:relative; line-height:22px; padding:0 0 0 70px; color:#eae3dc;}
.evtNoti ul li a {position:absolute; right:45px; top:-1px;}
#couponLayer {position:absolute; left:0; top:0; width:100%; height:100%; z-index:50; background:url(http://webimage.10x10.co.kr/eventIMG/2016/69628/bg_mask.png) repeat 0 0;}
#couponLayer .resultCont {position:absolute; left:50%; top:600px; margin-left:-242px;}
#couponLayer .btnClose {position:absolute; right:38px; top:35px; background:transparent; z-index:60;}

/* animation */
.goBuy {-webkit-animation: move 0.3s ease-in-out 0s 100 alternate; -moz-animation: move 0.3s ease-in-out 0s 100 alternate; -ms-animation: move 0.3s ease-in-out 0s 100 alternate; -o-animation: move 0.3s ease-in-out 0s 100 alternate; animation: move 0.3s ease-in-out 0s 100 alternate;}
@keyframes move {from {transform:translate(-3px,0);} to {transform:translate(3px,0);}}
@-webkit-keyframes move { from {-webkit-transform:translate(-3px,0);} to {-webkit-transform:translate(3px,0);}}
@-moz-keyframes move {from {-moz-transform:translate(-3px,0);} to{-moz-transform:translate(3px,0);}}
@-o-keyframes move {from {-o-transform:translate(-3px,0);} to {-o-transform:translate(3px,0);}}
@-ms-keyframes move {from {-ms-transform:translate(-3px,0);} to {-ms-transform:translate(3px,0);}}
</style>
<script type="text/javascript">
$(function(){
	var mySwiper = new Swiper('.swiper-container',{
		slidesPerView:'auto',
		centeredSlides:true,
		loop: true,
		speed:1000, 
		autoplay:2700,
		simulateTouch:false,
		pagination:false
	})
	$('.prev').on('click', function(e){
		e.preventDefault()
		mySwiper.swipePrev()
	})
	$('.next').on('click', function(e){
		e.preventDefault()
		mySwiper.swipeNext()
	});
	$(".btnClose").click(function(){
		$("#couponLayer").hide();
	});
});

function jscoupondown(){
	<% If IsUserLoginOK() Then %>
		<% If not( left(currenttime,10)>="2016-03-14" and left(currenttime,10)<"2016-03-21" ) Then %>
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
					url: "/event/etc/doeventsubscript/doEventSubscript69628.asp",
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
<%'' 방가방가 첫 구매 %>
<div class="evt69628">
	<h2><img src="http://webimage.10x10.co.kr/eventIMG/2016/69628/tit_hello.gif" alt="방가방가 첫 구매 - 아직 한번도 구매하지 않은 고객분들께 상콤하게 에코백을 제안합니다!" /></h2>
	<div class="dailylike">
		<div class="swiper-container">
			<div class="swiper-wrapper">
				<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69628/img_slide_01.png" alt="" /></div>
				<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69628/img_slide_02.png" alt="" /></div>
				<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69628/img_slide_03.png" alt="" /></div>
				<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69628/img_slide_04.png" alt="" /></div>
				<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69628/img_slide_05.png" alt="" /></div>
			</div>
		</div>
		<button class="prev"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69628/btn_prev.png" alt="이전" /></button>
		<button class="next"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69628/btn_next.png" alt="다음" /></button>
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/69628/txt_price.png" alt="데일리라이크 에코백(랜덤발송) 4,000원(쿠폰할인가)" /></p>
	</div>
	<div class="getCoupon">
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/69628/txt_coupon.png" alt="오늘 당신만을 위한 엄청난 쿠폰으로 첫 구매에 도전하세요!" /></p>
		<button class="goBuy" onclick="jscoupondown(); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69628/btn_buy.png" alt="쿠폰 받고 구매하러 가기" /></button>
	</div>


	<%' 쿠폰받기 레이어 %>
	<div id="couponLayer" style="display:none"></div>

	<div class="evtNoti">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/69628/tit_noti.png" alt="이벤트 유의사항" /></h3>
		<ul>
			<li>- 텐바이텐에서 한번도 구매이력이 없는 오렌지등급 고객님을 위한 이벤트입니다. <a href="/my10x10/special_info.asp" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69628/btn_grade.png" alt="회원등급 보러가기" /></a></li>
			<li>- 본 이벤트는 로그인 후에 참여가 가능합니다.</li>
			<li>- ID 당 1회만 구매가 가능합니다.</li>
			<li>- 이벤트는 조기 마감 될 수 있습니다.</li>
			<li>- 이벤트는 즉시결제로만 구매가 가능하며, 배송 후 반품/교환/구매취소가 불가능합니다.</li>
		</ul>
	</div>
</div>
<form method="post" name="directOrd" action="/inipay/shoppingbag_process.asp">
	<input type="hidden" name="itemid" value="<%=selectitemid%>">
	<input type="hidden" name="itemoption" value="0000">
	<input type="hidden" name="itemea" value="1">
	<input type="hidden" name="mode" value="DO1">
</form>
<!-- #include virtual="/lib/db/dbclose.asp" -->