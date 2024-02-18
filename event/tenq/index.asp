<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/classes/item/iteminfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_myfavoritecls.asp" -->
<%
	'============== 모바일 접근시 모바일 페이지 이동(referer가 10x10이면 이동안함) ============
	if Not(Request("mfg")="pc" or session("mfg")="pc") then
		if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
			Response.Redirect "http://m.10x10.co.kr/event/eventmain.asp?eventid=85144"
			REsponse.End
		end if
	end If
	Dim cPopular, vDisp, vSort, vCurrPage, i, j, vArrEval
	vDisp = RequestCheckVar(Request("disp"),18)
	vSort = NullFillWith(RequestCheckVar(Request("sort"),1),"3")
	vCurrPage = RequestCheckVar(Request("cpg"),5)

	If vCurrPage = "" Then vCurrPage = 1

	'// 쇼셜서비스로 글보내기 (2010.07.21; 허진원)
	Dim vTitle, vLink, vPre, vImg, vIsEnd, vQuery, vState, vNowTime, vCouponMaxCount
	Dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
	snpTitle	= Server.URLEncode("[텐바이텐] 텐큐베리 감사")
	snpLink		= Server.URLEncode("http://www.10x10.co.kr/event/tenq/")
	snpPre		= Server.URLEncode("10x10 이벤트")
	snpImg		= Server.URLEncode("http://webimage.10x10.co.kr/eventIMG/2018/tenq/m/bnr_kakao.jpg")


	'// Facebook 오픈그래프 메타태그 작성
	strPageTitle = "[텐바이텐] 텐큐베리 감사"
	strPageKeyword = "[텐바이텐] 텐큐베리 감사"
	strPageDesc = "최대 25% 쿠폰과 함께 , 4월에도 텐바이텐에서 즐거운 쇼핑하세요!"
	strPageUrl = "http://www.10x10.co.kr/event/tenq/"
	strPageImage = "http://webimage.10x10.co.kr/eventIMG/2018/tenq/m/bnr_kakao.jpg"

Dim userid : userid = GetEncLoginUserID()

Dim MyCouponCheck
If userid <> "" Then
	vQuery = ""
	vQuery = vQuery & " select top 1 itemcouponidx From [db_item].[dbo].[tbl_user_item_coupon] Where userid='"& userid &"' and itemcouponidx in (13739,13740,13741,13742,13787) "
	rsget.Open vQuery, dbget, 1
	IF Not rsget.Eof Then
		MyCouponCheck = rsget(0)
	Else
		MyCouponCheck=0
	End If
	rsget.close
Else
	MyCouponCheck=0
End If
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
.tenq-main button {background-color:transparent; vertical-align:top; outline:none;}
.tenq-main {margin-top:-45px !important}
.tenq-main {background-color:#ffd56a;}
.tenq-main .deco {position:absolute;}
.tenq-main .deco.pang {left:50%;}
.tenq-main .section1 {overflow:hidden; background:url(http://webimage.10x10.co.kr/eventIMG/2018/tenq/85144/bg_pop_0.png) 50% 496px no-repeat;}
.tenq-main .section1 .inner {position:relative; height:2110px; background:url(http://webimage.10x10.co.kr/eventIMG/2018/tenq/85144/bg_bubble_0.png?v=1.1) 55% 123px no-repeat;}
.tenq-main .section1 .subcopy {position:absolute; left:50%; top:86px; margin-left:-258px; animation:move2 .3s forwards ease-in; opacity:0;}
.tenq-main .section1 h2 {position:absolute; left:50%; top:183px; margin-left:-262px; animation:move2 .3s .2s forwards ease-in; opacity:0;}
.tenq-main .section1 .date {position:absolute; left:50%; top:40px; margin-left:356px;}
.tenq-main .section1 .pop1 {left:50%; top:212px; margin-left:-535px;}
.tenq-main .section1 .pop2 {left:50%; top:161px; margin-left:342px;}
.tenq-main .section1 .navigation li {position:absolute; left:50%; z-index:20;}
.tenq-main .section1 .navigation li.nav1 {top:532px; margin-left:-413px;}
.tenq-main .section1 .navigation li.nav1 .deco {left:62px; top:155px;}
.tenq-main .section1 .navigation li.nav1 .coupon {position:absolute; right:107px; top:201px;}
.tenq-main .section1 .navigation li.nav1 .coupon em {position:absolute; left:0; top:-13px; animation:bounce .6s infinite alternate;}
.tenq-main .section1 .navigation li.nav2 {top:869px; margin-left:-87px;}
.tenq-main .section1 .navigation li.nav2 .deco {left:55px; top:108px;}
.tenq-main .section1 .navigation li.nav3 {top:1030px; margin-left:-587px;}
.tenq-main .section1 .navigation li.nav3 .deco {left:97px; top:111px;}
.tenq-main .section1 .navigation li.nav4 {top:1280px; margin-left:-498px;}
.tenq-main .section1 .navigation li.nav4:after {content:''; display:inline-block; position:absolute; left:0; bottom:0; width:300px; height:150px;}
.tenq-main .section1 .navigation li.nav4 .deco {left:427px; top:106px;}
.tenq-main .section1 .navigation li.nav5 {top:1625px; margin-left:-498px;}
.tenq-main .section1 .navigation li.nav5:after {content:''; display:inline-block; position:absolute; right:0; bottom:0; width:400px; height:350px;}
.tenq-main .section1 .navigation li.nav5 .deco {left:113px; top:30px;}

.tenq-main .section1 .wave {left:0; bottom:0; z-index:15; width:100%; height:24px; background:url(http://webimage.10x10.co.kr/eventIMG/2018/tenq/85144/bg_wave.png?v=1) 0 100% repeat-x;}
.tenq-main .section1 .bubble {left:50%; z-index:10; height:273px; background:url(http://webimage.10x10.co.kr/eventIMG/2018/tenq/85144/bg_bubble_1.png) 0 0 no-repeat; animation:move1 2s linear infinite;}
.tenq-main .section1 .bubble1 {top:106px; width:82px; margin-left:-572px;}
.tenq-main .section1 .bubble2 {display:none; top:313px; width:88px; margin-left:-848px; background-position:-82px 0; animation-delay:.3s;}
.tenq-main .section1 .bubble3 {top:580px; width:134px; margin-left:-527px; background-position:-170px 0; animation-delay:.7s;}
.tenq-main .section1 .bubble4 {top:1053px; width:128px; margin-left:-800px; background-position:-304px 0; animation-delay:.5s;}
.tenq-main .section1 .bubble5 {top:1369px; width:269px; margin-left:-1068px; background-position:-432px 0; animation-delay:1s;}
.tenq-main .section1 .bubble6 {top:1693px; width:211px; margin-left:-696px; background-position:-701px 0; animation-delay:.5s;}
.tenq-main .section1 .bubble7 {top:473px; width:134px; margin-left:230px; background-position:-912px 0; animation-delay:.8s;}
.tenq-main .section1 .bubble8 {top:368px; width:166px; margin-left:750px; background-position:-1046px 0; animation-delay:.2s;}
.tenq-main .section1 .bubble9 {top:1264px; width:129px; margin-left:366px; background-position:-1212px 0; animation-delay:.1s;}
.tenq-main .section1 .bubble10 {top:1000px; width:273px; margin-left:648px; background-position:-1341px 0; animation-delay:.8s;}
.tenq-main .section1 .bubble11 {top:1783px; width:212px; margin-left:327px; background-position:-1614px 0; animation-delay:.3s;}
.tenq-main .section1 .bubble12 {display:none; top:320px; width:273px; margin-left:358px; background-position:-1341px 0; animation-delay:.5s;}
.tenq-main .section1 .bubble13 {top:1517px; width:270px; margin-left:734px; z-index:10; background:url(http://webimage.10x10.co.kr/eventIMG/2018/tenq/85144/bg_bubble_2.png) 0 0 no-repeat; animation:none;}

#lyrCoupon {display:none; position:fixed; left:50%; top:50%; z-index:999; width:790px; height:579px; margin:-333px 0 0 -395px; padding-top:88px; background-color:#000; background-color:rgba(0,0,0,.85); border-radius:56px;}
#lyrCoupon .btn-close {position:absolute; left:50%; bottom:58px; margin-left:-111px;}
.tenq-main .section2 {position:relative; padding:171px 0 140px; background:#abe9d5 url(http://webimage.10x10.co.kr/eventIMG/2018/tenq/85144/bg_pop_1.png?v=1) 50% 39px no-repeat;}
.tenq-main .section2:after {content:''; display:inline-block; position:absolute; left:50%; top:66px; z-index:25; width:28px; height:26px; margin-left:196px; background:url(http://webimage.10x10.co.kr/eventIMG/2018/tenq/85144/bg_pop_4.png) 0 0 no-repeat;}
.tenq-main .section2 .cloud {left:50%; top:-211px; width:710px; height:309px; margin-left:-371px; background:url(http://webimage.10x10.co.kr/eventIMG/2018/tenq/85144/bg_cloud.png) 0 0 no-repeat;}
.tenq-main .section2 h3 {position:absolute; left:50%; top:-58px; z-index:20; margin-left:-242px; margin-top:10px; opacity:0;}
.tenq-main .section2 .subcopy {position:absolute; left:50%; top:35px; z-index:20; margin-left:-220px; margin-top:10px; opacity:0;}
.tenq-main .section2 .inner {position:relative; width:1140px; margin:0 auto;}
.tenq-main .section2 .wishList {margin-bottom:-65px; text-align:left; font-size:11px;}
.tenq-main .section2 .btn-more {position:relative; background-color:transparent;}

.tenq-main .section3 {position:fixed; left:50%; top:380px; z-index:100; margin-left:540px;}
.tenq-main .section3:after {content:''; display:inline-block; position:absolute; left:50%; top:-16px; width:31px; height:30px; margin-left:-18px; background:url(http://webimage.10x10.co.kr/eventIMG/2018/tenq/85144/bg_pop_5.png) 0 0 no-repeat;}
.tenq-main .section3 .inner {position:relative; animation:swing 5s 100; transform-origin:50% 0;}
.tenq-main .section3 .inner a {display:block; position:absolute; left:35px; top:100px; width:60px; height:45px; text-indent:-999em;}
.tenq-main .section3 .inner a.btn-tw {left:100px;}

.tenq-main .pang1 {top:50px; margin-left:-464px;}
.tenq-main .pang2 {top:159px; margin-left:179px;}
.tenq-main .pang3 {top:401px; margin-left:392px;}
.tenq-main .pang4 {top:710px; margin-left:-673px;}
.tenq-main .pang5 {top:1418px; margin-left:-808px;}
.tenq-main .pang6 {top:1696px; margin-left:700px;}
.tenq-main .pang7 {top:-140px; margin-left:507px;}
.tenq-main .pang8 {top:315px; margin-left:-714px;}

@keyframes move1 {
	from {margin-top:300px; opacity:1;}
	to {margin-top:0; opacity:0;}
}
@keyframes move2 {
	from {margin-top:10px; opacity:0;}
	to {margin-top:0; opacity:1;}
}
@keyframes bounce {
	0% {transform:translateY(0);}
	100% {transform:translateY(-15px);}
}
@keyframes swing {
	20% {transform:rotate(3deg);}
	40% {transform:rotate(-3deg);}
	60% {transform:rotate(3deg);}
	80% {transform:rotate(-3deg);}
	100% {transform:rotate(0deg);}
}
</style>
<script type="text/javascript" src="/lib/js/jquery.masonry.min.js"></script>
<script style="text/javascript">
$(function(){
	// 쿠폰 레이어
	$('.nav1 .btn-coupon').click(function(){

	});
	$('#lyrCoupon .btn-close').click(function(){
		$('#lyrCoupon').fadeOut(200);
	});

	// wish
	/*
	$('img').load(function(){
		$(".wishList").masonry({
			itemSelector:".box"
		});
	});
	$(".wishList").masonry({
		itemSelector:".box"
	});
	*/
	$(".wishList .info .account").hide();
	$(".wishList .info").mouseover(function () {
		$(".wishList .info .account").hide();
		$(this).children(".account").show();
	});
	$(".wishList .info").mouseleave(function () {
		$(".wishList .info .account").hide();
	});

	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 1600 ) {
			$(".section2 h3").animate({"margin-top":"0", "opacity":"1"},400);
			$(".section2 .subcopy").delay(300).animate({"margin-top":"0", "opacity":"1"},400);
		}
	});

	getList();
});
function getList() {
	var str = $.ajax({
			type: "GET",
	        url: "popularwish_act.asp",
	        data: $("#popularfrm").serialize(),
	        dataType: "text",
	        async: false
	}).responseText;
	//alert(str);
	if(str!="") {
    	if($("#popularfrm input[name='cpg']").val()=="1") {
        	//내용 넣기
        	$('#lySearchResult').html(str);

			//마조니 활성
			$(".wishList").masonry({
				itemSelector: ".box"
				,isAnimatedFromBottom: true
			});
        } else {
        	//추가 내용 Import!
       		//$('#lySearchResult .box').last().after(str);
       		$str = $(str)
       		// 마조니 내용 추가
       		$('.wishList').append($str).masonry('appended',$str);

        }
        isloading=false;
    } else {
    	//더이상 자료가 없다면 스크롤 이벤트 종료
    	$(window).unbind("scroll");
    }

	// 상품정보 표시 액션
	$(".wishList .info").unbind("mouseover").unbind("mouseleave");
	$(".wishList .info .account").hide();
	$(".wishList .info").mouseover(function () {
		$(".wishList .info .account").hide();
		$(this).children(".account").show();
	});

	$(".wishList .info").mouseleave(function () {
		$(".wishList .info .account").hide();
	});
}

function fnWishListMore(){
//	$('input[name="cpg"]').val("2");
	$("#more1").css("display","none");
	$("#more2").css("display","");
	var pg = $("#popularfrm input[name='cpg']").val();
	pg++;
	$("#popularfrm input[name='cpg']").val(pg);
	setTimeout("getList()",500);
}

function fnWishItemMore(){
	window.open("/my10x10/popularwish.asp","_blank");
}

function goPopularWish(d,s){
	$('input[name="cpg"]').val("1");
	$('input[name="disp"]').val(d);
	$('input[name="sort"]').val(s);
	popularfrm.submit();
}

function snschk(snsnum) {
	if(snsnum == "tw") {
		popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>');
	}else if(snsnum=="fb"){
		popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','');
	}else if(snsnum=="pt"){
		pinit('<%=snpLink%>','<%=snpImg%>');
	}
}

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
					//viewPoupLayer('modal',$('#lyrCoupon').html());
					$('#lyrCoupon').fadeIn(300);
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
		location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/tenq/")%>';
		return;
	}
}
</script>
</head>
<body>
<div id="eventDetailV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container fullEvt"><!-- for dev msg : 왼쪽메뉴(카테고리명) 사용시 클래스 : partEvt / 왼쪽메뉴(카테고리명) 사용 안할때 클래스 : fullEvt -->
		<div id="contentWrap">
			<div class="eventWrapV15">


				<div class="eventContV15 tMar15">
					<!-- event area(이미지만 등록될때 / 수작업일때) -->
					<div class="contF contW">

						<!-- 텐큐베리감사 : 메인 -->
						<div class="evt85145 tenq-main">
							<!-- navigation -->
							<div class="section1">
								<div class="inner">
									<div class="topic">
										<p class="subcopy"><img src="http://webimage.10x10.co.kr/eventIMG/2018/tenq/85144/txt_april.png" alt="4월에도 텐바이텐을 찾아주신 고객님!" /></p>
										<h2><img src="http://webimage.10x10.co.kr/eventIMG/2018/tenq/85144/tit_thankyou.png?v=1" alt="텐~큐 베리감사" /></h2>
										<p class="date"><img src="http://webimage.10x10.co.kr/eventIMG/2018/tenq/85144/txt_date.png?v=1.0" alt="2018.04.02 ~ 2018.04.16" /></p>
										<div class="deco pop1"><img src="http://webimage.10x10.co.kr/eventIMG/2018/tenq/85144/bg_pop_2.png?v=1" alt="" /></div>
										<div class="deco pop2"><img src="http://webimage.10x10.co.kr/eventIMG/2018/tenq/85144/bg_pop_3.png" alt="" /></div>
									</div>
									<ul class="navigation">
										<li class="nav1">
											<% if Not(IsUserLoginOK) then %>
											<button class="btn-coupon" onclick="jsEventLogin();return false;">
											<% Else %>
											<button class="btn-coupon" onclick="jsDownCoupon('prd,prd,prd,prd,prd','13739,13740,13741,13742,13787');return false;">
											<% End If %>
												<img src="http://webimage.10x10.co.kr/eventIMG/2018/tenq/85144/nav_coupon.png?v=1.1" alt="땡큐쿠폰" />
												<div class="deco"><img src="http://webimage.10x10.co.kr/eventIMG/2018/tenq/85144/deco_1.gif" alt="" /></div>
												<%'!-- 쿠폰 발급 전 --%>
												<% If MyCouponCheck > "0" Then %>
												<div class="coupon">
													<em><img src="http://webimage.10x10.co.kr/eventIMG/2018/tenq/85144/btn_finish.png?v=1" alt="발급 완료" /></em>
													<img src="http://webimage.10x10.co.kr/eventIMG/2018/tenq/85144/bg_down_2.png?v=1" alt="" />
												</div>
												<% Else %>
												<div class="coupon">
													<em><img src="http://webimage.10x10.co.kr/eventIMG/2018/tenq/85144/btn_down.png?v=1" alt="쿠폰받기" /></em>
													<img src="http://webimage.10x10.co.kr/eventIMG/2018/tenq/85144/bg_down_1.png?v=1" alt="" />
												</div>
												<% End IF %>
											</button>
										</li>
										<li class="nav2">
											<a href="/event/tenq/miracle.asp">
												<img src="http://webimage.10x10.co.kr/eventIMG/2018/tenq/85144/nav_miracle.png?v=1.1" alt="100원의 기적" />
												<div class="deco"><img src="http://webimage.10x10.co.kr/eventIMG/2018/tenq/85144/deco_2.gif?v=1.2" alt="" /></div>
											</a>
										</li>
										<li class="nav3">
											<a href="/event/tenq/maeliage.asp">
												<img src="http://webimage.10x10.co.kr/eventIMG/2018/tenq/85144/nav_mileage.png?v=1" alt="매일리지" />
												<div class="deco"><img src="http://webimage.10x10.co.kr/eventIMG/2018/tenq/85144/deco_3.gif" alt="" /></div>
											</a>
										</li>
										<li class="nav4">
											<a href="/event/tenq/thx_box.asp">
												<img src="http://webimage.10x10.co.kr/eventIMG/2018/tenq/85144/nav_gift.png?v=1.1" alt="땡큐 베리 박스" />
												<div class="deco"><img src="http://webimage.10x10.co.kr/eventIMG/2018/tenq/85144/deco_4.gif" alt="" /></div>
											</a>
										</li>
										<li class="nav5">
											<a href="/event/tenq/giftcard.asp">
												<img src="http://webimage.10x10.co.kr/eventIMG/2018/tenq/85144/nav_1100.png?v=1.1" alt="1,100만원" />
												<div class="deco"><img src="http://webimage.10x10.co.kr/eventIMG/2018/tenq/85144/deco_5.gif" alt="" /></div>
											</a>
										</li>
									</ul>
									<div class="deco wave"></div>
									<div class="deco bubble bubble1"></div><div class="deco bubble bubble2"></div><div class="deco bubble bubble3"></div><div class="deco bubble bubble4"></div><div class="deco bubble bubble5"></div><div class="deco bubble bubble6"></div><div class="deco bubble bubble7"></div><div class="deco bubble bubble8"></div><div class="deco bubble bubble9"></div><div class="deco bubble bubble10"></div><div class="deco bubble bubble11"></div><div class="deco bubble bubble12"></div><div class="deco bubble bubble13"></div>
									<div class="deco pang pang1"><img src="http://webimage.10x10.co.kr/eventIMG/2018/tenq/85144/pang_1.gif" alt="" /></div>
									<div class="deco pang pang2"><img src="http://webimage.10x10.co.kr/eventIMG/2018/tenq/85144/pang_2.gif" alt="" /></div>
									<div class="deco pang pang3"><img src="http://webimage.10x10.co.kr/eventIMG/2018/tenq/85144/pang_3.gif" alt="" /></div>
									<div class="deco pang pang4"><img src="http://webimage.10x10.co.kr/eventIMG/2018/tenq/85144/pang_4.gif" alt="" /></div>
									<div class="deco pang pang5"><img src="http://webimage.10x10.co.kr/eventIMG/2018/tenq/85144/pang_5.gif" alt="" /></div>
									<div class="deco pang pang6"><img src="http://webimage.10x10.co.kr/eventIMG/2018/tenq/85144/pang_6.gif" alt="" /></div>
								</div>
								<!-- 쿠폰 발급 레이어 -->
								<div id="lyrCoupon">
									<a href="/my10x10/couponbook.asp" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2018/tenq/85144/btn_coupon.png?v=1.1" alt="쿠폰이 발급되었습니다. 다양한 쿠폰으로 텐바이텐에서 즐거운 쇼핑하세요!" /></a>
									<button class="btn-close"><img src="http://webimage.10x10.co.kr/eventIMG/2018/tenq/85144/btn_close_2.png" alt="닫기" /></button>
								</div>
								<!--// 쿠폰 발급 레이어 -->
							</div>

							<!-- wish -->
							<div class="section2">
								<h3><img src="http://webimage.10x10.co.kr/eventIMG/2018/tenq/85144/tit_popular.png" alt="지금, 인기있는 상품" /></h3>
								<p class="subcopy"><img src="http://webimage.10x10.co.kr/eventIMG/2018/tenq/85144/txt_wish.png?v=1.1" alt="바로 지금! 다른 사람들의 ♥위시를 실시간으로 만나보세요!" /></p>
								<div class="deco cloud"></div>
								<div class="inner">
									<!-- for  dev msg : ↓현재 위시 페이지와 마크업 동일 -->
									<form id="popularfrm" name="popularfrm" method="get" style="margin:0px;">
									<input type="hidden" name="cpg" id="cpg" value="1" />
									<input type="hidden" name="disp" value="<%=vDisp%>" />
									<input type="hidden" name="sort" value="<%=vSort%>" />
									</form>
									<div class="wishList" id="lySearchResult"></div>
									<div class="noData" id="popwishnodata" style="display:none;">
										<p><strong>실시간으로 등록된 <span>WISH</span>가 더 이상 없습니다.</strong></p>
										<a href="/award/awardlist.asp?atype=f&disp=" class="btnView"><img src="http://fiximage.10x10.co.kr/web2013/wish/btn_view_best_wish.gif" alt="BEST WISH 보러가기" /></a>
									</div>
									<!--  for dev msg : 더보기 클릭 시 상품 아래로 더 노출 후 버튼 btn_more_2로 바뀌게 해주세요 -->
									<button type="button" class="btn-more" id="more1" onclick="fnWishListMore();"><img src="http://webimage.10x10.co.kr/eventIMG/2018/tenq/85144/btn_more_1.png" alt="상품 더보기" /></button>
									<button type="button" class="btn-more" id="more2" style="display:none" onclick="fnWishItemMore();"><img src="http://webimage.10x10.co.kr/eventIMG/2018/tenq/85144/btn_more_2.png" alt="상품 더 구경하러가기" /></button>
									<div class="deco pang pang7"><img src="http://webimage.10x10.co.kr/eventIMG/2018/tenq/85144/pang_7.gif" alt="" /></div>
									<div class="deco pang pang8"><img src="http://webimage.10x10.co.kr/eventIMG/2018/tenq/85144/pang_8.gif" alt="" /></div>
								</div>
							</div>

							<!-- share -->
							<div class="section3">
								<div class="inner">
									<p><img src="http://webimage.10x10.co.kr/eventIMG/2018/tenq/85144/txt_share.png" alt="친구들과 함께하는 텐큐베리감사!" /></p>
									<a href="" class="btn-fb" onclick="snschk('fb');return false;">페이스북으로 공유</a>
									<a href="" class="btn-tw" onclick="snschk('tw');return false;">트위터로 공유</a>
								</div>
							</div>
						</div>
						<!--// 텐큐베리감사 : 메인 -->

					</div>
					<!-- //event area(이미지만 등록될때 / 수작업일때) -->
				</div>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->