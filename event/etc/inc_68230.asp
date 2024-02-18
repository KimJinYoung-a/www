<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 루돌프 사슴 쿠폰
' History : 2015.12.21 한용민 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->

<%
dim eCode, userid, getbonuscoupon, currenttime, getlimitcnt
	IF application("Svr_Info") = "Dev" THEN
		eCode = "65989"
	Else
		eCode = "68230"
	End If
	IF application("Svr_Info") = "Dev" THEN
		getbonuscoupon = "2759"
	Else
		getbonuscoupon = "812"
	End If

	currenttime = now()
	'currenttime = #12/22/2015 10:05:00#

	userid = GetEncLoginUserID()
	getlimitcnt = 30000

dim bonuscouponcount, subscriptcount, totalsubscriptcount, totalbonuscouponcount
bonuscouponcount=0
subscriptcount=0
totalsubscriptcount=0
totalbonuscouponcount=0

'//본인 참여 여부
if userid<>"" then
	subscriptcount = getevent_subscriptexistscount(eCode, userid, left(currenttime,10), "", "")
	bonuscouponcount = getbonuscouponexistscount(userid, getbonuscoupon, "", "", left(currenttime,10))
end if

'//전체 참여수
totalsubscriptcount = getevent_subscripttotalcount(eCode, left(currenttime,10), "", "")
'//전체 쿠폰 발행수량
totalbonuscouponcount = getbonuscoupontotalcount(getbonuscoupon, "", "", left(currenttime,10))

'totalsubscriptcount = 25005		'25005		'/30000
'totalbonuscouponcount = 25005		'25005		'/30000
%>

<!-- #include virtual="/lib/inc/head.asp" -->

<style type="text/css">
img {vertical-align:top;}

.evt68230 {min-height:1359px; background:#1b6100 url(http://webimage.10x10.co.kr/eventIMG/2015/68230/bg_mountain_v1.png) no-repeat 0 0;}
.evt68230 button {background-color:transparent;}

.snow {position:absolute; top:0; left:0; z-index:5; width:1071px; height:1078px; background:transparent url(http://webimage.10x10.co.kr/eventIMG/2015/68230/bg_snow_v1.png) repeat-y 0 0;}
.snowing {
/* chrome, safari, opera */-webkit-animation-name:snowing; -webkit-animation-duration:30s; -webkit-animation-timing-function:linear; -webkit-animation-iteration-count:infinite;
/* standard syntax */animation-name:snowing; animation-duration:30s; animation-timing-function:linear; animation-iteration-count:infinite;}
/* chrome, safari, opera */
@-webkit-keyframes snowing {
	0% {background-position:0 0}
	100%{background-position:0 500px}
}
@keyframes snowing {
	0% {background-position:0 0}
	100%{background-position:0 500px}
}

.topic {position:relative; height:330px;}
.topic h2 {position:absolute; top:97px; left:50%; margin-left:-292px;}
.topic .only {position:absolute; top:20px; right:20px;}

.coupon {position:relative; height:1031px;}
.rudolph {position:absolute; top:0; left:335px; z-index:5;}
.btnClick {position:absolute; top:180px; left:442px; z-index:10;}
.btnCoupon {display:none; position:absolute; top:413px; left:254px;}
.deadline {position:absolute; top:82px; left:312px; z-index:5;}
.present {position:absolute; top:413px; left:254px;}
.soldout {position:absolute; top:0; left:254px;}

.bnr {overflow:hidden; margin-top:-2px;}
.bnr p {float:left;}

.noti {position:relative; height:154px; background-color:#efefef; text-align:left;}
.noti h3 {position:absolute; top:0; left:0;}
.noti ul {overflow:hidden; margin-left:332px; width:808px; padding-top:38px;}
.noti ul li {float:left; width:50%; margin-top:6px; color:#000;}

/* css3 animation */
@-webkit-keyframes flash {
	0% {opacity:0;}
	100% {opacity:1;}
}
@keyframes flash {
	0% {opacity:0;}
	100% {opacity:1;}
}
.flash {
	-webkit-animation-duration:1s;  -webkit-animation-name:flash; -webkit-animation-iteration-count:3;
	animation-duration:1s; animation-name:flash; animation-iteration-count:3;
}

@-webkit-keyframes pulse {
	0% {-webkit-transform: scale(1);}
	50% {-webkit-transform: scale(0.9);}
	100% {-webkit-transform: scale(1);}
} 
@keyframes pulse {
	0% {transform:scale(1);}
	50% {transform:scale(0.9);}
	100% {transform:scale(1);}
}
.pulse {
	-webkit-animation-name:pulse; -webkit-animation-duration:2s; -webkit-animation-fill-mode:both; -webkit-animation-iteration-count:5;
	animation-name:pulse; animation-duration:2s; animation-fill-mode:both; animation-iteration-count:5;
}
</style>
<script type="text/javascript">

function jseventSubmit(frm){
	<% If IsUserLoginOK() Then %>
		<% If not( left(currenttime,10)>="2015-12-22" and left(currenttime,10)<"2015-12-23" ) Then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return;
		<% else %>
			<% if subscriptcount>0 or bonuscouponcount>0 then %>
				alert("쿠폰은 한 개의 아이디당 한 번만 다운 받으실 수 있습니다.");
				return;
			<% else %>
				<% if totalsubscriptcount>=getlimitcnt or totalbonuscouponcount>=getlimitcnt then %>
					alert("죄송합니다. 쿠폰이 모두 소진 되었습니다.");
					return;
				<% else %>
					<% if Hour(currenttime) < 10 then %>
						alert("쿠폰은 오전 10시부터 다운 받으실수 있습니다.");
						return;
					<% else %>
						frm.action="/event/etc/doeventsubscript/doEventSubscript68230.asp";
						frm.target="evtFrmProc";
						frm.mode.value='couponreg';
						frm.submit();
					<% end if %>
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
</head>
<body>

<div class="evt68230">
	<div class="snow snowing"></div>
	<div class="topic">
		<h2><img src="http://webimage.10x10.co.kr/eventIMG/2015/68230/tit_rudolph.png" alt="루돌프 사슴쿠폰" /></h2>
		<p class="only"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68230/ico_only_v1.png" alt="빨간 코를 눌러주세요! 따끈한 보너스 쿠폰이 당신을 찾아갑니다. 오직 텐바이텐에서만 만나 보실 수 있습니다." /></p>
	</div>

	<div class="coupon">
		<div class="rudolph"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68230/img_rudolph.png" alt="" /></div>
		<div class="present"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68230/img_present.png" alt="" /></div>

		<% '<!-- for dev msg : 클릭 --> %>
		<button type="button" id="btnClick" class="btnClick pulse">
			<img src="http://webimage.10x10.co.kr/eventIMG/2015/68230/btn_click.png" alt="클릭" />
		</button>

		<% '<!-- for dev msg : 쿠폰 --> %>
		<button type="button" onclick="jseventSubmit(evtFrm1); return false;" id="btnCoupon" class="btnCoupon">
			<img src="http://webimage.10x10.co.kr/eventIMG/2015/68230/btn_coupon_v1.png" alt="5천원 쿠폰 3만원 이상 구매시 사용가능하며 12월 22일 화요일 하루동안 사용하실 수 있습니다." />
		</button>

		<% if totalsubscriptcount>=getlimitcnt or totalbonuscouponcount>=getlimitcnt then %>
			<% '<!-- for dev msg : 쿠폰이 모두 소진 될 경우 보여주세요 --> %>
			<p class="soldout">
				<img src="http://webimage.10x10.co.kr/eventIMG/2015/68230/txt_soldout_v2.png" alt="쿠폰이 모두 소진되었습니다. 다음 기회에 이용해주세요" />
			</p>
		<% else %>
			<% if ((getlimitcnt - totalsubscriptcount) < 5000) or ((getlimitcnt - totalbonuscouponcount) < 5000) then %>
				<% '<!-- for dev msg : 마감 임박 --> %>
				<strong class="deadline flash">
					<img src="http://webimage.10x10.co.kr/eventIMG/2015/68230/m/txt_deadline.png" alt="쿠폰이 모두 소진되었습니다. 다음 기회에 이용해주세요" />
				</strong>
			<% end if %>
		<% end if %>
	</div>

	<div class="bnr">
		<p class="btnApp"><a href="/event/appdown/" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68230/btn_down_tentenapp.png" alt="아직이신가요? 텐바이텝 앱 다운받기" /></a></p>
		<p class="btnJoin"><a href="/member/join.asp" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2015/68230/btn_join.png" alt="바이텐에 처음 오셨나요? 회원가입하고 구매하러 go" /></a></p>
	</div>

	<div class="noti">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/68230/tit_noti.png" alt="이벤트 유의사항" /></h3>
		<ul>
			<li>- 이벤트는 ID 당 1일 1회만 참여할 수 있습니다. </li>
			<li>- 주문한 상품에 따라, 배송비용은 추가로 발생 할 수 있습니다.</li>
			<li>- 지급된 쿠폰은 텐바이텐에서만 사용가능 합니다.</li>
			<li>- 이벤트는 조기 마감 될 수 있습니다.</li>
			<li>- 쿠폰은 금일 12/22(화) 23시59분 종료됩니다.</li>
		</ul>
	</div>
</div>
<form name="evtFrm1" action="" onsubmit="return false;" method="post" style="margin:0px;">
	<input type="hidden" name="mode">
</form>
<iframe id="evtFrmProc" name="evtFrmProc" src="about:blank" frameborder="0" width=0 height=0 style="display:none;"></iframe>
<script type="text/javascript">
$(function(){
	$("#btnClick").click(function(event){
		<% If IsUserLoginOK() Then %>
			<% If not( left(currenttime,10)>="2015-12-22" and left(currenttime,10)<"2015-12-23" ) Then %>
				alert("이벤트 응모 기간이 아닙니다.");
				return;
			<% else %>
				<% if subscriptcount>0 or bonuscouponcount>0 then %>
					alert("쿠폰은 한 개의 아이디당 한 번만 다운 받으실 수 있습니다.");
					return;
				<% else %>
					<% if totalsubscriptcount>=getlimitcnt or totalbonuscouponcount>=getlimitcnt then %>
						alert("죄송합니다. 쿠폰이 모두 소진 되었습니다.");
						return;
					<% else %>
						<% if Hour(currenttime) < 10 then %>
							alert("쿠폰은 오전 10시부터 다운 받으실수 있습니다.");
							return;
						<% else %>
							$("#btnClick").removeClass("pulse");
							$("#btnCoupon").slideDown();
						<% end if %>
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
	});
});
</script>
</body>
</html>

<!-- #include virtual="/lib/db/dbclose.asp" -->