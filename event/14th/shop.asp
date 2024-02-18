<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : [14주년] 5분안에 매장을 털어라! 습격자들
' History : 2015.10.07 한용민 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventCls.asp" -->

<%
dim currenttime
	currenttime =  now()
	'currenttime = #10/10/2015 09:00:00#

dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  64913
Else
	eCode   =  66519
End If

dim userid, i
	userid = GetEncLoginUserID()

'// 이벤트 정보 가져옴
'dim cEvent, ename, emimg, evt_mo_listbanner, evt_subname, blnitempriceyn
'set cEvent = new ClsEvtCont
'	cEvent.FECode = eCode
'	cEvent.fnGetEvent
'
'	ename		= cEvent.FEName
'	emimg		= cEvent.FEMimg
'	evt_mo_listbanner	= cEvent.FEmolistbanner
'	'evt_subname			= cEvent.Fevt_subname
'	blnitempriceyn = cEvent.FItempriceYN
'set cEvent = Nothing

'//sns
dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
snpTitle = Server.URLEncode("5분안에 매장을 털어라! 습격자들")
snpLink = Server.URLEncode("http://m.10x10.co.kr/event/eventmain.asp?eventid=" & eCode)
snpPre = Server.URLEncode("텐바이텐 이벤트")
snpTag = Server.URLEncode("[텐바이텐] 5분안에 매장을 털어라! 습격자들")
snpTag2 = Server.URLEncode("#10x10 #텐바이텐")

dim chasu
	chasu=1

if left(currenttime,10)<"2015-10-15" then
	chasu=1
elseif left(currenttime,10)>="2015-10-15" and left(currenttime,10)<"2015-10-22" then
	chasu=2
else
	chasu=3
end if

dim subscriptexistscount
	subscriptexistscount=0

if userid<>"" then
	subscriptexistscount = getevent_subscriptexistscount(eCode, userid, left(currenttime,10), "", "")
end if
%>

<style type="text/css">
#contentWrap {padding-bottom:0;}

/* 습격자들 */
.anniversary14th .topic {height:1307px; background:#35353d url(http://webimage.10x10.co.kr/eventIMG/2015/14th/66519/bg_wall_top.jpg) no-repeat 50% 0;}

.topic .hgroup {position:relative; padding-top:110px; padding-bottom:29px;}
.topic .hgroup h3 {position:relative; z-index:10;}
.topic .hgroup .line {position:absolute; top:162px; left:50%; margin-left:-336px; opacity:0.5; filter: alpha(opacity=50);}
.topic .hgroup .shine {position:absolute; top:247px; left:50%; z-index:15; margin-left:29px;}

.movie {width:1139px; height:509px; margin:0 auto; background:url(http://webimage.10x10.co.kr/eventIMG/2015/14th/66519/bg_box.png) no-repeat 50% 0;}
.movie .inner {overflow:hidden; height:415px; padding:52px 20px 0 84px; text-align:left;}
.movie .inner .desc {float:right; position:relative; width:456px; padding-top:42px;}
.movie .inner .video {float:left; width:579px;}

.movie .inner .desc .shot {position:absolute; top:6px; left:34px; z-index:2;}
.movie .inner .desc .shot img {transform:scale(1.1);}
.movie .inner .desc p {position:relative; z-index:5;}
.movie .inner .desc ul {position:relative;}
.movie .inner .desc ul li {position:absolute; width:138px; height:126px;}
.movie .inner .desc ul li.movie01 {top:73px; left:-50px; z-index:5;}
.movie .inner .desc ul li.movie02 {top:34px; left:63px;}
.movie .inner .desc ul li.movie03 {top:85px; left:205px; z-index:5;}
.movie .inner .desc ul li.movie04 {top:34px; left:306px;}
.movie .inner .desc ul li a {overflow:hidden; display:block; position:relative; width:100%; height:126px; color:#fff; font-size:11px; line-height:154px; text-align:center;}
.movie .inner .desc ul li a span {display:block; position:absolute; top:0; left:0; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2015/14th/66519/bg_movie_clip_v6.png) no-repeat 0 -126px;}
.movie .inner .desc ul li a:hover span, .movie .inner .desc ul li a.on span {background-position:0 100%;}
.movie .inner .desc ul li.movie02 a span {background-position:-138px -126px;}
.movie .inner .desc ul li.movie02 a:hover, .movie .inner .desc ul li.movie02 a.on span {background-position:-138px 100%;}
.movie .inner .desc ul li.movie03 a span {background-position:-276px -126px;}
.movie .inner .desc ul li.movie03 a:hover, .movie .inner .desc ul li.movie03 a.on span {background-position:-276px 100%;}
.movie .inner .desc ul li.movie04 a span {background-position:100% -126px;}
.movie .inner .desc ul li.movie04 a:hover, .movie .inner .desc ul li.movie04 a.on span {background-position:100% 100%;}

.movie .inner .video .frame {width:495px; height:300px; margin-left:-7px; padding:3px 7px 0; background:url(http://webimage.10x10.co.kr/eventIMG/2015/14th/66519/bg_video_frame.png) no-repeat 0 0;}
.movie .inner .video h4 {margin-bottom:17px;}

.video .movieclip {display:none;}

.spin {-webkit-animation:spin 7s linear infinite;
	-moz-animation:spin 7s linear infinite;
	animation:spin 7s linear infinite;
}
@-moz-keyframes spin {100% { -moz-transform: rotate(360deg);}}
@-webkit-keyframes spin {100% { -webkit-transform: rotate(360deg);}}
@keyframes spin {100% { -webkit-transform: rotate(360deg); transform:rotate(360deg);}}

.sns {position:relative; width:1140px; margin:38px auto 0; text-align:left;}
.sns p {padding-left:139px;}
.sns ul {overflow:hidden; position:absolute; top:7px; right:85px;}
.sns ul li {float:left; width:46px; height:45px; margin-left:18px;}
.sns ul li a {overflow:hidden; display:block; position:relative; width:100%; height:45px; font-size:11px; line-height:45px; text-align:center;}
.sns ul li a span {display:block; position:absolute; top:0; left:0; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2015/14th/66519/ico_sns.png) no-repeat 50% 0;}
.sns ul li.twitter a span {background-position:50% -45px;}
.sns ul li.kakao a span {background-position:50% 100%;}

.apply {height:242px; margin-top:58px;}
.apply button {margin-top:23px; background-color:transparent;}
.apply button:hover img, .apply button:active img {animation-iteration-count:infinite; animation-duration:0.6s; animation-name:bounce;}
@keyframes bounce {
	from, to{margin-top:0; animation-timing-function:ease-out;}
	50% {margin-top:-5px; animation-timing-function:ease-in;}
}

.manual {overflow:hidden; position:relative; z-index:5; width:100%; height:370px;}
.manual .bg {position:absolute; left:0; top:0; width:100%; height:100%; background:#35353d url(http://webimage.10x10.co.kr/eventIMG/2015/14th/66519/txt_manual.png) no-repeat 50% 0;}

.place h3 {overflow:hidden; position:relative; z-index:5; height:208px;}
.place h3 span {position:absolute; left:0; top:0; width:100%; height:100%; background:#35353d url(http://webimage.10x10.co.kr/eventIMG/2015/14th/66519/tit_place.png) no-repeat 50% 0;}
.rollingwrap {overflow:hidden; position:relative;}
.rolling {position:relative; width:889px; height:541px; margin:0 auto;}
.rolling .swiper {position:absolute; top:0; left:50%; width:5394px; margin-left:-2697px; height:541px;}
.rolling .swiper .swiper-container {overflow:hidden; width:100%; height:541px;}
.rolling .swiper .swiper-wrapper {position:relative; width:100%; height:541px;}
.rolling .swiper .swiper-slide {float:left; width:100%;}
.rolling .swiper .swiper-slide img { vertical-align:top;}
.rolling .pagination {overflow:hidden; position:absolute; bottom:10px; left:50%; z-index:50; width:180px; margin-left:-90px;}
.rolling .swiper-pagination-switch {float:left; width:10px; height:10px; margin:0 10px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/14th/66519/btn_pagination.png) no-repeat 50% 0; cursor:pointer; transition:all 0.5s;}
.rolling .swiper-active-switch {background-position:0 100%;}
.rolling .btn-nav {display:block; position:absolute; top:50%; z-index:110; width:29px; height:53px; margin-top:-26px; background:transparent url(http://webimage.10x10.co.kr/eventIMG/2015/14th/66519/btn_nav.png) no-repeat 0 0; text-indent:-999em;}
.rolling .btn-prev {left:-80px;}
.rolling .btn-next {right:-80px; background-position:100% 0;}
.swipemask {position:absolute; top:0; width:2000px; height:541px; z-index:100; background-color:#000; opacity:0.5; filter:alpha(opacity=50);}
.mask-left {left:-2005px;}
.mask-right {right:-2005px;}

.noti {height:286px; background:#212328 url(http://webimage.10x10.co.kr/eventIMG/2015/14th/66519/bg_wall_btm.jpg) no-repeat 50% 0;}
.noti .inner {width:879px; margin:0 auto; padding-top:55px; padding-left:10px; text-align:left;}
.noti h3 {margin-bottom:23px;}
.noti ul li {margin-top:9px; padding-left:17px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/14th/66519/blt_dot.png) no-repeat 0 2px; color:#bbb; font-size:11px; line-height:1.5em;}
.noti ul li strong {color:#fff;}
</style>
<script type="text/javascript">

$(function(){
	/* swipe */
	var mySwiper = new Swiper('.swiper1',{
		centeredSlides:true,
		slidesPerView:6,
		//initialSlide:0,
		loop: true,
		speed:2000,
		autoplay:5000,
		simulateTouch:false,
		pagination:'.pagination',
		paginationClickable:true
	})
	$('.btn-prev').on('click', function(e){
		e.preventDefault()
		mySwiper.swipePrev()
	})
	$('.btn-next').on('click', function(e){
		e.preventDefault()
		mySwiper.swipeNext()
	});

	/* title animation */
	$(".topic .shine").css({"width":"0", "opacity":"0"});
	function titleAnimation() {
		$(".topic .shine").delay(500).animate({"width":"184px", "opacity":"1"},2000);
	}
	titleAnimation();

	/* nav */
	$("#movie .nav li:nth-child(4) a").addClass("on");
	$("#movie .video .movieclip:nth-child(4)").show();
	$(".movie .inner .desc ul li.movie04").css({"z-index":"6"});

	$("#movie .nav li.movie01 a").click(function(){
		$("#movie .nav li a").removeClass("on");
		$("#movie .video .movieclip").hide();
		$(".movie .inner .desc ul li.movie02").css({"z-index":"3"});
		$(this).addClass("on");
		var thisCont = $(this).attr("href");
		$("#movie .video").find(thisCont).show();
		return false;
	});
	$("#movie .nav li.movie02 a").click(function(){
		$("#movie .nav li a").removeClass("on");
		$("#movie .video .movieclip").hide();
		$(".movie .inner .desc ul li.movie02").css({"z-index":"6"});
		$(this).addClass("on");
		var thisCont = $(this).attr("href");
		$("#movie .video").find(thisCont).show();
		return false;
	});
	$("#movie .nav li.movie03 a").click(function(){
		$("#movie .nav li a").removeClass("on");
		$("#movie .video .movieclip").hide();
		$(".movie .inner .desc ul li.movie03").css({"z-index":"6"});
		$(".movie .inner .desc ul li.movie04").css({"z-index":"5"});
		$(this).addClass("on");
		var thisCont = $(this).attr("href");
		$("#movie .video").find(thisCont).show();
		return false;
	});
	$("#movie .nav li.movie04 a").click(function(){
		$("#movie .nav li a").removeClass("on");
		$("#movie .video .movieclip").hide();
		$(".movie .inner .desc ul li.movie04").css({"z-index":"6"});
		$(".movie .inner .desc ul li.movie03").css({"z-index":"5"});
		$(this).addClass("on");
		var thisCont = $(this).attr("href");
		$("#movie .video").find(thisCont).show();
		return false;
	});
});

function gosns(snsgubun){
	<% If IsUserLoginOK Then %>
		<% if not( left(currenttime,10)>="2015-10-10" and left(currenttime,10)<"2015-10-29" ) then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return;
		<% else %>
			var rstStr = $.ajax({
				type: "POST",
				url: "/event/14th/shop_process.asp",
				data: "mode=snsadd&snsgubun="+snsgubun,
				dataType: "text",
				async: false
			}).responseText;
			//alert(rstStr);
			if (rstStr == "tw"){
				popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>');
				return false;
			}else if (rstStr == "fb"){
				popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','');
				return false;
			}else if (rstStr == "ln"){
				popSNSPost('ln','<%=snpTitle%>','<%=snpLink%>','','');
				return false;
			}else if (rstStr == "USERNOT"){
				alert('로그인을 해주세요.');
				return false;
			}else if (rstStr == "DATENOT"){
				alert('이벤트 응모 기간이 아닙니다.');
				return false;
			}else{
				alert('오류가 발생했습니다.');
				return false;
			}
		<% end if %>
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return false;
		}
		return false;
	<% end if %>
}

function gojoin(){
	<% If IsUserLoginOK Then %>
		<% if not( left(currenttime,10)>="2015-10-10" and left(currenttime,10)<"2015-10-29" ) then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return;
		<% else %>
			<% if subscriptexistscount > 0 then %>
				alert('오늘은 모두 참여 하셨습니다.');
				return false;
			<% else %>
				var rstStr = $.ajax({
					type: "POST",
					url: "/event/14th/shop_process.asp",
					data: "mode=add",
					dataType: "text",
					async: false
				}).responseText;
				//alert(rstStr);
				if (rstStr == "SUCCESS"){
					alert('감사합니다. 참여가 완료 되었습니다!');
					location.reload();
					return false;
				}else if (rstStr == "USERNOT"){
					alert('로그인을 해주세요.');
					return false;
				}else if (rstStr == "DATENOT"){
					alert('이벤트 응모 기간이 아닙니다.');
					return false;
				}else if (rstStr == "END"){
					alert('오늘은 모두 참여 하셨습니다.');
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
	<% end if %>
}

</script>
</head>
<body>
<div id="eventDetailV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container fullEvt">
		<div id="contentWrap">
			<div class="eventWrapV15">
				<div class="eventContV15">
					<div class="contF contW">
						<% '<!-- [66519] 습격자들 --> %>
						<div class="anniversary14th">
							<!-- 14th common : header & nav -->
							<!-- #include virtual="/event/14th/header.asp" -->
							<div class="topic">
								<div class="hgroup">
									<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66519/tit_marauders_v1.png" alt="5분안에 매장을 털어라! 습격자들" /></h3>
									<span class="line"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66519/img_line.png" alt="" /></span>
									<span class="shine"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66519/img_shine.png" alt="" /></span>
								</div>

								<!-- moive clip -->
								<div id="movie" class="movie">
									<div class="inner">
										<div class="desc">
											<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66519/txt_5_minutes.png" alt="주어진 시간은 단 5분! 백만원으로 텐바이텐을 털 수 있는 절호의 기회!" /></p>
											<span class="shot spin"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66519/img_shot_v1.png" alt="" /></span>
											<ul class="nav">
												<li class="movie01"><a href="#movieclip1"><span></span>Movie clip #1. 티져</a></li>
												<li class="movie02"><a href="#movieclip2"><span></span>Movie clip #2. 1차 습격</a></li>
												<li class="movie03"><a href="#movieclip3"><span></span>Movie clip #3. 2차 습격</a></li>
												<li class="movie04"><a href="#movieclip4"><span></span>Movie clip #4. 3차 습격</a></li>
											</ul>
										</div>
										<div class="video">
											<div id="movieclip1" class="movieclip">
												<h4><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66519/tit_movie_clip_01.png" alt="Movie clip #1. 티져" /></h4>
												<div class="frame">
													<iframe src="https://www.youtube.com/embed/pPWUWyAJaiA?rel=0" width="490" height="292" frameborder="0" title="습격자들 티저 영상" webkitallowfullscreen="" mozallowfullscreen="" allowfullscreen=""></iframe>
												</div>
											</div>
											<div id="movieclip2" class="movieclip">
												<h4><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66519/tit_movie_clip_02.png" alt="Movie clip #2. 1차 습격" /></h4>
												<div class="frame">
													<iframe src="https://www.youtube.com/embed/zUCewhqOXh8?rel=0" width="490" height="292" frameborder="0" title="습격자들 1차 습격 영상" webkitallowfullscreen="" mozallowfullscreen="" allowfullscreen=""></iframe>
												</div>
											</div>
											<div id="movieclip3" class="movieclip">
												<h4><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66519/tit_movie_clip_03.png" alt="Movie clip #3. 2차 습격" /></h4>
												<div class="frame">
													<iframe src="https://www.youtube.com/embed/hOsIH97khVs?rel=0" width="490" height="292" frameborder="0" title="습격자들 2차 습격 영상" webkitallowfullscreen="" mozallowfullscreen="" allowfullscreen=""></iframe>
												</div>
											</div>
											<div id="movieclip4" class="movieclip">
												<h4><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66519/tit_movie_clip_04.png" alt="Movie clip #4. 3차 습격" /></h4>
												<div class="frame">
													<iframe src="https://www.youtube.com/embed/C-HtBpe1Y2Q?rel=0" width="490" height="292" frameborder="0" title="습격자들 3차 습격 영상" webkitallowfullscreen="" mozallowfullscreen="" allowfullscreen=""></iframe>
												</div>
											</div>
										</div>
									</div>
									<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66519/txt_keyword.png" alt="지령키워드 #5분 #백만원 #대학로 #습격자들 #텐바이텐 #공유하면_확률두배 #매장털기" /></p>
								</div>
								<% '<!-- for dev msg : 신청하기 --> %>
								<div class="apply">
									<% '<!-- for dev msg txt_date_01~03 --> %>
									<% '<!-- for dev msg :btn_apply_01~03 --> %>
									<% if chasu="1" then %>
										<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66519/txt_date_01.png" alt="1차 습격일 2015년 10월 17일 토요일 오전 10시며, 습격자 인원은 5명 이벤트 기간은 2015년 10월 10일부터 14일까지 응모하실 수 있습니다. 당첨자 발표는 10월 15일 오후입니다." /></p>
										<button type="button" onclick="gojoin(); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66519/btn_apply_01.png" alt="텐바이텐 1차 습격 참가 신청하기" /></button>
									<% elseif chasu="2" then %>
										<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66519/txt_date_02.png" alt="2차 습격일 2015년 10월 24일 토요일 오전 10시며, 습격자 인원은 5명 이벤트 기간은 2015년 10월 15일부터 21일까지 응모하실 수 있습니다. 당첨자 발표는 10월 22일 오후입니다." /></p>
										<button type="button" onclick="gojoin(); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66519/btn_apply_02.png" alt="텐바이텐 2차 습격 참가 신청하기" /></button>
									<% else %>
										<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66519/txt_date_03_v1.png" alt="3차 습격일 2015년 10월 31일 토요일 오전 10시며, 습격자 인원은 5명 이벤트 기간은 2015년 10월 22일부터 28일까지 응모하실 수 있습니다. 당첨자 발표는 10월 29일 목요일 입니다." /></p>
										<button type="button" onclick="gojoin(); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66519/btn_apply_03.png" alt="텐바이텐 3차 습격 참가 신청하기" /></button>
									<% end if %>
								</div>
								<% '<!-- for dev msg : sns --> %>
								<div class="sns">
									<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66519/txt_sns.png" alt="습격자들 이벤트를 페이스북, 트위터, 카카오톡에서 공유하면 당첨확률이 2배 이상 올라갑니다" /></p>
									<ul>
										<li class="facebook"><a href="" onclick="gosns('fb'); return false;"><span></span>페이스북</a></li>
										<li class="twitter"><a href="" onclick="gosns('tw'); return false;"><span></span>트위터</a></li>
										<!--li class="kakao"><a href="" onclick="gosns('ka'); return false;"><span></span>카카오톡</a></li-->
									</ul>
								</div>
							</div>
							<div class="manual">
								<div class="bg"></div>
								<h3>습격자들매뉴얼</h3>
								<ol>
									<li>습격일에 대학로 텐바이텐 매장 가기</li>
									<li>5분 동안 백만원으로 맘껏 쇼핑하기</li>
									<li>쇼핑한 상품은 안전하게 배송받기</li>
								</ol>
							</div>
							<!-- preview -->
							<div class="place">
								<h3><span></span>습격장소미리보기 서울시 종로구 동숭동 텐바이텐</h3>
								<div class="rollingwrap">
									<div class="rolling">
										<div class="swiper">
											<div class="swiper-container swiper1">
												<div class="swiper-wrapper">
													<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66519/img_slide_01.jpg" alt="텐바이텐 동숭동 오프라인 매장" /></div>
													<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66519/img_slide_02.jpg" alt="" /></div>
													<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66519/img_slide_03.jpg" alt="" /></div>
													<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66519/img_slide_04.jpg" alt="" /></div>
													<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66519/img_slide_05.jpg" alt="" /></div>
													<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66519/img_slide_06.jpg" alt="" /></div>
												</div>
											</div>
										</div>
										<div class="pagination"></div>
										<button type="button" class="btn-nav btn-prev">Previous</button>
										<button type="button" class="btn-nav btn-next">Next</button>
										<div class="swipemask mask-left"></div>
										<div class="swipemask mask-right"></div>
									</div>
								</div>
							</div>
							<div class="noti">
								<div class="inner">
									<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66519/tit_noti.png" alt="이벤트 유의사항" /></h3>
									<ul>
										<li>본 이벤트는 ID 당 1일 1회만 응모 가능합니다.</li>
										<li>이벤트 기간 별로 매장 습격 가능 날짜가 상이합니다. 이벤트 참여 전에 미리 확인을 해주세요.</li>
										<li>이벤트 당첨 후 매장 습격 날짜를 변경하실 수 없습니다.</li>
										<li>당첨된 인원에게는 개별로 연락을 드릴 예정입니다.</li>
										<li>매장 습격은 <strong>당첨된 본인만</strong> 참여하실 수 있으며, 동행하신 분은 이벤트 시간 동안에 매장에 들어오실 수 없습니다.</li>
										<li>매장 습격 당일 촬영과 인터뷰가 진행될 예정입니다. 참고바랍니다.</li>
									</ul>
								</div>
							</div>
						</div>
						<% '<!-- //[66519] 습격자들 --> %>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>

<!-- #include virtual="/lib/db/dbclose.asp" -->