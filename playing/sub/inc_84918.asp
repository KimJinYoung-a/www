<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/event/etc/instagrameventCls.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<%
'####################################################
' Description : 플레이띵 Vol.36 오늘 뭐하지?
' History : 2018-03-02 원승현
'####################################################
Dim eCode, vQuery, currenttime, vConfirmCheckToDate
Dim TaroOpenDate, TaroIdx, TaroImgValue, vDIdx

IF application("Svr_Info") = "Dev" THEN
	eCode   =  67511
Else
	eCode   =  84918
End If

currenttime = date()
'currenttime = "2018-03-03"
'// 오늘자 응모데이터 bool
vConfirmCheckToDate = False

vDIdx = request("didx")

'// 오늘자 응모데이터가 있는지 확인한다.
'// sub_opt1 : 응모일자(날짜만)
'// sub_opt2 : db_temp.[dbo].[tbl_playingV36Taro] 에 있는 IDX값
'// sub_opt3 : 이미지 파일명
If IsUserLoginOK() Then
	vQuery = "SELECT sub_opt1, sub_opt2, sub_opt3 FROM [db_event].[dbo].[tbl_event_subscript] WHERE userid = '" & getEncLoginUserId & "' And evt_code='"&eCode&"' And convert(varchar(10), regdate, 120) ='"&currenttime&"' "
	rsget.Open vQuery,dbget,1
	If Not(rsget.bof Or rsget.eof) Then
		vConfirmCheckToDate = True
		TaroOpenDate = rsget("sub_opt1")
		TaroIdx = rsget("sub_opt2")
		TaroImgValue = rsget("sub_opt3")
	End If
	rsget.close
End If
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<style type="text/css">
.thingVol036 {text-align:center;}
.thingVol036 button {background:transparent; outline:none;}
.topic {position:relative; height:739px; padding-top:159px; background:url(http://webimage.10x10.co.kr/playing/thing/vol036/bg_head.png) 50% 0 repeat-x;}
.topic h2 {position:relative; width:500px; height:232px; margin:0 auto;}
.topic h2 span, .topic h2 i {display:block; position:absolute; left:50%; opacity:0;}
.topic h2 .t1 {top:3px; margin-left:-150px; animation-delay:0.3s;}
.topic h2 .t2 {top:121px; margin-left:-168px; animation-delay:0.5s;}
.topic h2 .deco1 {top:0; margin-left:52px; animation-delay:0.8s;}
.topic h2 .deco2 {top:71px; margin-left:155px; animation-delay:0.8s;}
.topic .sub-copy {margin-top:58px;}
.topic .img-card {position:absolute; left:50%; top:561px; margin-left:-153px; z-index:10; animation:pulse 1 0.5s ; animation-fill-mode:forwards; -webkit-animation-fill-mode:forwards; animation-delay:1.5s; opacity:0;}
.section1 {position:relative; padding:225px 0 80px 0; background:url(http://webimage.10x10.co.kr/playing/thing/vol036/bg_section1.png) 50% 0 repeat;}
.section1 span {display:block; padding-top:63px; animation:bounce .8s 30;}
.section2 {position:relative; padding:100px 0 125px 0; background:url(http://webimage.10x10.co.kr/playing/thing/vol036/bg_section2.png) 50% 0 repeat;}
.section2 .card-shuffle-wrap {position:absolute; left:50%; top:123px; width:1430px; margin-left:-715px;}
.section2 .card-shuffle-wrap .btn-mixed {position:absolute; left:50%; top:172px; margin-left:88px; outline:none; z-index:5;}
.section2 .card-shuffle {position:relative; width:100%;}
.section2 .card-shuffle li {float:left; position:absolute; left:50%; top:148px; width:273px; height:422px; margin-left:-138px; transition:all 1s cubic-bezier(0.68,-.55,.265,1.55); perspective:1000; -ms-transform:perspective(1000px); -moz-transform:perspective(1000px); -ms-transform-style:preserve-3d; -moz-transform-style:preserve-3d; z-index:5;}
.section2 .card-shuffle li p {position:absolute; left:50%; top:0; width:100%; margin-left:-138px; box-shadow:4px 4px 8px 5px rgba(0,0,0,.3); border-radius:19px 19px;}
.section2 .card-shuffle li.ani1 {margin-left:-320px; z-index:3;}
.section2 .card-shuffle li.ani2 {margin-left:33px; z-index:3;}
.section2 .card-shuffle li.ani3 {margin-left:-505px; z-index:2;}
.section2 .card-shuffle li.ani4 {margin-left:220px; z-index:2;}
.section2 .card-shuffle li.ani5 {margin-left:-693px; z-index:1;}
.section2 .card-shuffle li.ani6 {margin-left:406px; z-index:1;}
.section2 .card-shuffle li .front {z-index:2; transform:rotateY(0deg);}
.section2 .card-shuffle li .back {width:396px; height:614px; margin-top:44px; opacity:0; transform:rotateY(180deg) translateY(-148px);}
.section2 .card-shuffle li .back span {display:block; position:absolute; left:-83px; top:-44px; width:132px; height:137px; background:url(http://webimage.10x10.co.kr/playing/thing/vol036/img_tooltip.png) 50% 0 no-repeat; font-size:26px; font-family:'malgun gothic', dotum, sans-serif; line-height:130px; color:#fff;}
.section2 .card-shuffle li.card0 {z-index:5;}
.section2 .card-shuffle li.card1 {transform:rotate(-5deg); opacity:0.8; z-index:4;}
.section2 .card-shuffle li.card2 {transform:rotate(-10deg); opacity:0.5; z-index:1;}
.section2 .card-shuffle li.card3 {margin-left:-405px; opacity:0; z-index:3;}
.section2 .card-shuffle li.card4 {margin-left:205px; opacity:0; z-index:2;}
.section2 .card-shuffle li.card5 {margin-left:-305px; opacity:0; z-index:3;}
.section2 .card-shuffle li.card6 {margin-left:305px;opacity:0; z-index:2;}
.section2 .card-shuffle .taro p {box-shadow:4px 4px 8px 5px rgba(0,0,0,.3); border-radius:19px 19px;}
.section2 .card-shuffle .flipper {position:relative; width:396px; height:514px; padding-top:44px; margin-left:-136px !important; transition:0.6s; transform-style:preserve-3d; transform:rotateY(180deg);}
.section2 .card-shuffle .flipper p {box-shadow:5px 5px 10px 5px rgba(0,0,0,.3); border-radius:25px 25px;}
.section2 .card-shuffle .flipper p.front {box-shadow:none; display:none;}
.section2 .card-shuffle .flipper p.back {animation:flip .6s 1; animation-fill-mode:both;}
.section2 .card-spread li:after {display:block; position:absolute; left:50%; top:0; width:100%; height:100%; margin-left:-138px; background:rgba(0,0,0,.6); content:''; border-radius:19px 19px;}
.section2 .card-spread li.flipper:after {display:none;}
.section2 .card-mixed li p {box-shadow:none;}
.section2 .card-mixed li.card0 p, .section2 .card-mixed li.card1 p, .section2 .card-mixed li.card1 p {box-shadow:4px 4px 8px 5px rgba(0,0,0,.3);}
.section2 .btn-card-view {position:absolute; left:50%; bottom:63px; margin-left:-80px;}
.section2 .btn-share {display:none;}
.section3 {padding:100px 0 60px; background:url(http://webimage.10x10.co.kr/playing/thing/vol036/bg_section3.png) 50% 0 repeat;}
.section3 h3 {position:relative; width:350px; margin:0 auto; padding-bottom:38px;}
.section3 h3 span {position:absolute; left:0; top:-3px; width:115px; height:32px; text-align:center; color:#000; font-size:27px; line-height:1.2; font-weight:400; font-family:'malgun gothic', dotum, sans-serif;}
.section3 .card-view {width:100%; height:626px;}
.section3 .card-view .swiper-container {width:100%; height:626px; text-align:left;}
.section3 .card-view .swiper-slide {position:relative; float:left; width:396px; height:614px; margin:0 30px; padding-top:12px; text-align:center;}
.section3 .card-view .swiper-slide p {position:absolute; left:50%; top:0; width:140px; height:44px; margin-left:-70px; background:url(http://webimage.10x10.co.kr/playing/thing/vol036/bg_date_box.png) 50% 0 no-repeat; font-size:26px; font-family:'malgun gothic', dotum, sans-serif; line-height:41px; color:#fff;}
.section3 .card-view .swiper-slide img {width:396px; height:614px;}
.section3 a.www_FlowSlider_com-branding {display:none !important;}
.final {padding:79px 0; background:url(http://webimage.10x10.co.kr/playing/thing/vol036/bg_section4.png) 50% 0 repeat-x; text-align:center;}
.final a {display:block; animation:shake 3s 50; animation-fill-mode:both;}
.slideX {animation:slideX 0.4s ease-in forwards;}
@keyframes slideX {
	0% {transform:translateX(-30px); opacity:0;}
	100% {transform:translateX(0); opacity:1;}
}
.slideY {animation:slideY 0.4s ease-in forwards;}
@keyframes slideY {
	0% {transform:translateY(-30px); opacity:0;}
	100% {transform:translateY(0); opacity:1;}
}
.blink {animation:blink 1.7s 3 3.8s forwards;}
@keyframes blink {
	0%, 100% {opacity:1;}
	10%, 30%, 50%, 70%, 90% {opacity:1;}
	20%, 40%, 60%, 80% {opacity:0;}
}
@keyframes pulse {
    0% {transform:scale(1.7); opacity:0;}
    100% {transform:scale(1); opacity:1;}
}
@-webkit-keyframes pulse {
    0% {-webkit-transform:scale(1.7); opacity:0;}
    100% {-webkit-transform:scale(1); opacity:1;}
}
@keyframes flip {
	from {opacity:0;}
	60%, 100% {opacity:1;}
}
@keyframes shake {
	0%, 100% {transform:translateX(0);}
	10%, 30%, 50%, 70%, 90% {transform:translateX(-3px);}
	20%, 40%, 60%, 80% {transform:translateX(3px);}
}
@keyframes bounce {
	from, to {transform:translateY(0); animation-timing-function:ease-out;}
	50% {transform:translateY(8px); animation-timing-function:ease-in;}
}
</style>
<script type="text/javascript" src="/lib/js/jquery.flowslider.js"></script>
<script type="text/javascript">
$(function(){
	//	$(".topic").addClass("animation");
	$(".topic h2 span").addClass("slideX");
	$(".topic .deco1").addClass("blink");
	$(".topic .deco2").addClass("slideY");

	$(".section3").hide();
	$(".btn-card-view").on("click", function(){
		$.ajax({
			type:"GET",
			url:"/playing/sub/doEventSubscript84918.asp?mode=RecentView",
			dataType: "text",
			async:false,
			cache:true,
			success : function(Data, textStatus, jqXHR){
					//$str = $(Data);
					res = Data.split("||");
					if (jqXHR.readyState == 4) {
						if (jqXHR.status == 200) {
							if(Data!="") {
								if (res[0]=="ok")
								{
									$("#RecentViewTaroCard").empty().html(res[1]);
									setTimeout(function() {
										$(".card-view .swiper-container").FlowSlider({
											marginStart:0,
											marginEnd:0,
											startPosition:0.5
										});
									}, 100);
									$(".section3").fadeIn();
									window.$('html,body').animate({scrollTop:$(".section3").offset().top},500);
								}
								else
								{
									alert(res[1]);
									return false;
								}
							} else {

							}
						}
					}
			},
			error:function(jqXHR, textStatus, errorThrown){
				alert("잘못된 접근 입니다.");
				return false;
			}
		});


	});

	$(".btn-card-close").on("click", function(){
		$(".section3").hide("slide", { direction: "up" }, 500);
		window.$('html,body').animate({scrollTop:$(".section2").offset().top},500);
	});

	<%'// 오늘자 응모 데이터가 있으면 그냥 펼쳐준다. %>
	<% if vConfirmCheckToDate then %>
		$("#taroResult").empty().html("<span><%=TaroOpenDate%></span><img src='http://webimage.10x10.co.kr/playing/thing/vol036/<%=TaroImgValue%>' alt='' />");
		$(".btn-mixed").fadeOut();
		$(".card-shuffle li").each(function(e) {
			setTimeout(function() {
				$(".card-shuffle li").eq(e).attr("class", "taro ani" + e);
			}, e * 10);
			setTimeout(function() {
				$(".ani0").addClass('flipper');
				$(".card-shuffle").addClass('card-spread');
				$(".btn-spread").hide();
				$(".btn-share").fadeIn();
			}, 50);
		});
	<% else %>
		$(".btn-mixed").css({"opacity":"0"});
		var isVisible = false;
		$(window).on('scroll',function() {
			if (checkVisible($('.card-shuffle-wrap'))&&!isVisible) {
				cardMix();
				$(".btn-mixed").delay(1500).animate({"opacity":"1"},700);
				isVisible=true;
			}
		});
	<% end if %>

	$('.btn-spread button').click(function() {
		<% if IsUserLoginOK() then %>
			<% if currenttime >= "2018-03-02" And currenttime < "2018-03-17" then %>
				<% if vConfirmCheckToDate then %>
					alert("금일은 이미 취미를 점치셨습니다.");
					return false;
				<% else %>
					$.ajax({
						type:"GET",
						url:"/playing/sub/doEventSubscript84918.asp?mode=add",
						dataType: "text",
						async:false,
						cache:true,
						success : function(Data, textStatus, jqXHR){
								//$str = $(Data);
								res = Data.split("||");
								if (jqXHR.readyState == 4) {
									if (jqXHR.status == 200) {
										if(Data!="") {
											if (res[0]=="ok")
											{
												$("#taroResult").empty().html(res[1]);
												$(".btn-mixed").fadeOut();
												$(".card-shuffle li").each(function(e) {
													setTimeout(function() {
														$(".card-shuffle li").eq(e).attr("class", "taro ani" + e);
													}, e * 150);
													setTimeout(function() {
														$(".ani0").addClass('flipper');
														$(".card-shuffle").addClass('card-spread');
														$(".btn-spread").hide();
														$(".btn-share").fadeIn();
													}, 1070);
												});
											}
											else
											{
												alert(res[1]);
												document.location.reload();
											}
										} else {

										}
									}
								}
						},
						error:function(jqXHR, textStatus, errorThrown){
							alert("잘못된 접근 입니다.");
							return false;
						}
					});
				<% end if %>
			<% else %>
				alert("이벤트 응모기간이 아닙니다.");
				return false;
			<% end if %>
		<% else %>
			if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
				location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/playing/view.asp?didx="&vDIdx)%>';
				return;
			}
			return false;
		<% end if %>
	});

	function cardMix() {
		$(".card-shuffle").addClass('card-mixed');
		$(".card-shuffle li").each(function(e) {
			$(".card-shuffle li").eq(e).attr("class", "card" + e);
			setTimeout(function() {
				$(".card-shuffle li").eq(e).attr("class", "");
			}, e * 70);
			setTimeout(function() {
				$(".card-shuffle li").eq(1).attr("class", "card1");
			}, 490);
			setTimeout(function() {
				$(".card-shuffle li").eq(2).attr("class", "card2");
			}, 550);
		});
	}

	function checkVisible( elm, eval ) {
		eval = eval || "object visible";
		var viewportHeight = $(window).height(),
			scrolltop = $(window).scrollTop(),
			y = $(elm).offset().top+100,
			elementHeight = $(elm).height();
		if (eval == "object visible") return ((y < (viewportHeight + scrolltop)) && (y > (scrolltop - elementHeight)));
		if (eval == "above") return ((y < (viewportHeight + scrolltop)));
	}

	$('.btn-mixed').click(function() {
		cardMix();
	});
});

</script>
</head>
<%' Vol.036 오늘 뭐하지 %>
<div class="thingVol036">
	<div class="topic">
		<h2>
			<span class="t1"><img src="http://webimage.10x10.co.kr/playing/thing/vol036/tit_taro1.png" alt="오늘" /></span>
			<span class="t2"><img src="http://webimage.10x10.co.kr/playing/thing/vol036/tit_taro2.png" alt="뭐하지" /></span>
			<i class="deco1"><img src="http://webimage.10x10.co.kr/playing/thing/vol036/tit_taro_deco.png" alt="" /></i>
			<i class="deco2"><img src="http://webimage.10x10.co.kr/playing/thing/vol036/tit_taro_question.png" alt="?" /></i>
		</h2>
		<p class="sub-copy"><img src="http://webimage.10x10.co.kr/playing/thing/vol036/tit_sub.png" alt="매일 반복되는 일상, 하루에 오직 자신을 위해 보내는 시간이 있나요? 행복은 나 자신을 위한 시간 속에 있는 지도 모릅니다." /></p>
		<span class="img-card"><img src="http://webimage.10x10.co.kr/playing/thing/vol036/img_card.png" alt="" /></span>
	</div>
	<div class="section1">
		<p><img src="http://webimage.10x10.co.kr/playing/thing/vol036/txt_taro_today.png" alt="오늘 무엇을 하며 보낼지 취미를 점쳐보세요! 여러분들도 매일 취미 생활을 할 수 있습니다. 행운 취미 타로가 여러분들을 소소하지만 확실한 행복으로 만들어 줄 거에요!" /></p>
		<span><img src="http://webimage.10x10.co.kr/playing/thing/vol036/img_btm_arrwo.png" alt="" /></span>
	</div>
	<div class="section2">
		<h3><img src="http://webimage.10x10.co.kr/playing/thing/vol036/txt_taro_hobby.png" alt="행운의 취미 타로 - 매일 하루에 하나씩 취미를 점쳐보세요! 취미: 금전적 목적이 아닌 기쁨을 얻는 활동 [출처: 위키백과] / 오늘 어떤 일로 행복한 시간을 가질지 고민하면서 섞어주세요!" /></h3>
		<div class="card-shuffle-wrap">
			<ul class="card-shuffle">
				<li class="card0">
					<p class="front"><img src="http://webimage.10x10.co.kr/playing/thing/vol036/img_card2.png" alt="" /></p>
					<%' 랜덤카드 이미지 노출(img_card_view01.png ~ img_card_view24.png) %>
					<p class="back" id="taroResult"></p>
				</li>
				<li class="card1"><p><img src="http://webimage.10x10.co.kr/playing/thing/vol036/img_card2.png" alt="" /></p></li>
				<li class="card2"><p><img src="http://webimage.10x10.co.kr/playing/thing/vol036/img_card2.png" alt="" /></p></li>
				<li class="card3"><p><img src="http://webimage.10x10.co.kr/playing/thing/vol036/img_card2.png" alt="" /></p></li>
				<li class="card4"><p><img src="http://webimage.10x10.co.kr/playing/thing/vol036/img_card2.png" alt="" /></p></li>
				<li class="card5"><p><img src="http://webimage.10x10.co.kr/playing/thing/vol036/img_card2.png" alt="" /></p></li>
				<li class="card6"><p><img src="http://webimage.10x10.co.kr/playing/thing/vol036/img_card2.png" alt="" /></p></li>
			</ul>
			<button type="button" class="btn-mixed"><img src="http://webimage.10x10.co.kr/playing/thing/vol036/btn_mixed.png" alt="섞기" /></button>
		</div>
		<p class="tMar55 btn-spread"><button type="button"><img src="http://webimage.10x10.co.kr/playing/thing/vol036/btn_choice.png" alt="뽑기" /></button></p>
		<p class="tMar55 btn-share"><button type="button" onclick="snschk('fb'); return false;"><img src="http://webimage.10x10.co.kr/playing/thing/vol036/btn_today_share.png" alt="오늘의 내 취미 공유하기" /></button></p>
		<%' 지난 카드 있는 경우만 노출 %>
		<p class="btn-card-view"><button><img src="http://webimage.10x10.co.kr/playing/thing/vol036/btn_card_view.png" alt="지난 카드 확인하기" /></button></p>
	</div>
	<div class="section3">
		<h3><span><%=GetLoginUserName%></span><img src='http://webimage.10x10.co.kr/playing/thing/vol036/txt_taro_last.png' alt='님의 지난 취미 카드' /></h3>
		<div class='card-view' id="RecentViewTaroCard"></div>
		<p class='tMar40 btn-card-close'><button type='button'><img src='http://webimage.10x10.co.kr/playing/thing/vol036/btn_card_hide.png' alt='지난 카드 접어두기' /></button></p> "
	</div>
	<div class="final">
		<p><img src="http://webimage.10x10.co.kr/playing/thing/vol036/txt_another_shoppping.png" alt="오늘 뽑은 취미 대신 다른 취미를 만나고 싶다면? 더 확실하게 원하는 취미를 골라보세요!" /></p>
		<a href="/event/eventmain.asp?eventid=84918" class="tMar30 btnShake"><img src="http://webimage.10x10.co.kr/playing/thing/vol036/btn_another_shopping.png" alt="다른 취미 쇼핑하기" /></a>
	</div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->