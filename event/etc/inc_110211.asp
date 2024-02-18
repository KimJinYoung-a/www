<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : MKT 2021 4월 정기세일
' History : 2021-03-24 임보라
'####################################################
%>
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
	Dim currentDate, evtStartDate, evtEndDate, eCode, userid
	Dim eventCoupons, isCouponShow, vQuery

	currentDate = date()
	evtStartDate = Cdate("2021-03-29")
	evtEndDate = Cdate("2021-04-26")

	'test
	' currentDate = Cdate("2021-04-16")

	IF application("Svr_Info") = "Dev" THEN
		eCode = 104336
		eventCoupons = "22270,22269,22268,22267,22271,22265"
	Else
		eCode = 110211
		eventCoupons = "135989,135988,135987,135986,135985,135984"
	End If

	userid = GetEncLoginUserID()

	isCouponShow = True

	If IsUserLoginOK Then
		vQuery = "select count(1) from [db_item].[dbo].[tbl_user_item_coupon] where userid = '" & getencLoginUserid() & "'"
		vQuery = vQuery + " and itemcouponidx in ("&eventCoupons&") "
		vQuery = vQuery + " and usedyn = 'N' "
		rsget.CursorLocation = adUseClient
		rsget.Open vQuery,dbget,adOpenForwardOnly,adLockReadOnly
		If rsget(0) = 6 Then
			isCouponShow = False
		Else
			isCouponShow = True
		End IF
		rsget.close
	End If
	' response.write isCouponShow
%>
<style>
.sale2021 {position:relative; background:#fff;}
.sale2021::before,
.sale2021::after {position:absolute; content:url(//webimage.10x10.co.kr/fixevent/event/2021/110211/img_deco_02.png);}
.sale2021::before {top:calc(100% + 700px); left:50%; margin-left:-880px;}
.sale2021::after {top:calc(100% + 1300px); right:50%; margin-right:-840px;}
.sale2021 .btn-area::after {position:absolute; bottom:-550px; left:50%; margin-left:640px; content:url(//webimage.10x10.co.kr/fixevent/event/2021/110211/img_deco_01.png);}
<% If currentDate < #04/16/2021 00:00:00# Then %>
.sale2021 .topic {position:relative; overflow:hidden;}
.sale2021 .topic.v3 {height:675px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/110211/bg_sale_03.gif) no-repeat center top;}
.sale2021 .topic.v4 {height:655px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/110211/bg_sale_04.gif) no-repeat center top;}
.sale2021 .topic h2 {position:absolute; top:0; left:50%; margin-left:-570px; opacity:0;}
.sale2021 .topic.on h2 {-webkit-animation:titAni .5s both ease-out; animation:titAni .5s both ease-out;}
.sale2021 .btn-area {position:relative; height:414px; background:#ff2929 url(//webimage.10x10.co.kr/fixevent/event/2021/110211/bg_link.jpg) no-repeat center top;}
.sale2021 .btn-coupon, .sale2021 .btn-gift {position:absolute; top:0; width:570px; height:100%; font-size:0; color:transparent;}
.sale2021 .btn-coupon {right:50%; background:none;}
.sale2021 .btn-gift {left:50%;}
<% Else %>
.sale2021 .topic {position:relative; overflow:hidden; height:635px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/110211/bg_topic_v3.gif) no-repeat center top;}
.sale2021 .topic h2 {position:absolute; top:0; left:50%; margin-left:-570px; -webkit-animation:titAni .5s both ease-out; animation:titAni .5s both ease-out;}
.sale2021 .topic .txt-day {position:absolute; left:50%; bottom:57px; z-index:10; margin-left:-570px;}
.sale2021 .btn-area {position:relative; background:#ff2929;}
.sale2021 .btn-coupon {background:none; vertical-align:top;}
<% End If %>
.sale2021 .pop-coupon {display:none; position:fixed; left:0; top:0; z-index:1000; width:100%; height:100%; background:rgba(0,0,0,.7);}
.sale2021 .pop-coupon .inner {position:absolute; left:50%; top:50%; transform:translate(-50%,-50%);}
.sale2021 .pop-coupon .btn-close {position:absolute; right:0; top:0; width:70px; height:70px; font-size:0; color:transparent; background:none;}
.sale2021 .links-area {position:relative; width:1152px; margin:0 auto;}
.sale2021 .links-area .links-brand {display:flex; position:absolute; left:0; top:68px; width:100%; height:135px;}
.sale2021 .links-area .links-brand a {display:inline-block; width:100%; height:100%;}
@-webkit-keyframes titAni {
	0% {opacity:0; transform:translate3d(0,20%,0);}
	100% {opacity:1; transform:none;}
}
@keyframes titAni {
	0% {opacity:0; transform:translate3d(0,20%,0);}
	100% {opacity:1; transform:none;}
}
.pdt-groupbarV20 {color:#ff2929 !important;}
.pdt-groupbarV20 p {font-size:48px; line-height:90px; text-transform:uppercase;}
</style>
<script>
	$(window).on('load', function() {
		$('.sale2021 .topic').addClass('on');
	});
	$(function() {
		// 상단 배경 GIF이미지 랜덤 노출
		<% If currentDate < #04/16/2021 00:00:00# Then %>
			var num = Math.floor(Math.random()*2)+1;
			if (num === 1) {
				$('.sale2021 .topic').addClass('v3');
				$('.sale2021 .topic h2 img').attr('src', '//webimage.10x10.co.kr/fixevent/event/2021/110211/tit_sale_03.png');
			} else {
				$('.sale2021 .topic').addClass('v4');
				$('.sale2021 .topic h2 img').attr('src', '//webimage.10x10.co.kr/fixevent/event/2021/110211/tit_sale_04.png');
			}
		<% End If %>

		// 디데이
		<% if currentDate >= "2021-04-23" and currentDate <= "2021-04-26" then %>
			var today = new Date();
			// var today = new Date('April 23, 2021');
			var day = today.getDate();
			$('.txt-day img').attr('src', '//webimage.10x10.co.kr/fixevent/event/2021/110211/txt_day_'+day+'.png');
		<% End If %>

		// 팝업 닫기
		$('.sale2021 .pop-coupon').on('click', function(e) {
			if (e.target === this || $(e.target).is('.btn-close')) {
				$(e.currentTarget).hide();
			}
		});
	});

	function jsDownCoupon(stype,idx){
		<% if Not(IsUserLoginOK) then %>
			jsEventLogin();
		<% else %>
		$.ajax({
			type: "post",
			url: "/shoppingtoday/act_couponshop_process.asp",
			data: "idx="+idx+"&stype="+stype,
			cache: false,
			success: function(message) {
				if(typeof(message)=="object") {
					if(message.response=="Ok") {
						$('.sale2021 .pop-coupon').show();
					} else {
						alert(message.message);
					}
				} else {
					alert("처리중 오류가 발생했습니다.");
				}
			},
			error: function(err) {
				console.log(err.responseText);
			}
		});
		<% end if %>
	}

	function jsEventLogin(){
		if(confirm("로그인을 하셔야 쿠폰을 다운받으실수 있습니다.")){
			location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/eventmain.asp?eventid=" & eCode)%>';
			return;
		}
	}
</script>
<!-- MKT 정기세일 : 메인 (W) 110211 -->
<div class="evt110211 sale2021">
	<% If currentDate < #04/16/2021 00:00:00# Then %>
		<div class="topic">
			<h2><img src="" alt=""></h2>
		</div>
		<div class="btn-area">
			<button class="btn-coupon" onclick="jsDownCoupon('prd,prd,prd,prd,prd,prd,prd','<%=eventCoupons%>');return false;">쿠폰 다운받기</button>
			<a href="/event/eventmain.asp?eventid=110264" class="btn-gift">사은품 보러가기</a>
		</div>
	<% Else %>
		<div class="topic">
			<h2><img src="//webimage.10x10.co.kr/fixevent/event/2021/110211/tit_sale_04.png" alt="텐바이텐 정기세일"></h2>
			<% if currentDate >= "2021-04-23" and currentDate <= "2021-04-26" then %>
				<div class="txt-day"><img src="" alt=""></div>
			<% End If %>
		</div>
		<div class="btn-area">
			<button class="btn-coupon" onclick="jsDownCoupon('prd,prd,prd,prd,prd,prd,prd','<%=eventCoupons%>');return false;"><img src="//webimage.10x10.co.kr/fixevent/event/2021/110211/btn_coupon_v2.jpg" alt="쿠폰 다운받기"></button>
		</div>
	<% End If %>
	<!-- for dev msg : 쿠폰 발급 시 팝업 -->
	<div class="pop-coupon">
		<div class="inner">
			<button class="btn-close">닫기</button>
			<a href="/my10x10/couponbook.asp"><img src="//webimage.10x10.co.kr/fixevent/event/2021/110211/pop_coupon.png" alt="쿠폰이 발급 되었습니다."></a>
		</div>
	</div>
	<div class="links-area">
		<img src="//webimage.10x10.co.kr/fixevent/event/2021/110211/img_link.jpg" alt="지금, 놓쳐서는 안될 필수 브랜드 / 지금, 가장 인기있는 텐텐템">
		<div class="links-brand">
			<a href="/event/eventmain.asp?eventid=110546"></a>
			<a href="/event/eventmain.asp?eventid=110547"></a>
		</div>
	</div>
</div>
<!-- //MKT 정기세일 : 메인 (W) 110211 -->
<!-- #include virtual="/lib/db/dbclose.asp" -->