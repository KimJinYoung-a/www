<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<%
'####################################################
' Description : 벗꽃을 찍어요 팡팡팡
' History : 2017-04-07 유태욱 생성
'####################################################
Dim eCode , LoginUserid, vDIdx, myresultcnt, totalcnt
IF application("Svr_Info") = "Dev" THEN
	eCode   =  66302
Else
	eCode   =  77393
End If

vDIdx = request("didx")
totalcnt = 0
myresultcnt = 0
LoginUserid	= getencLoginUserid()
totalcnt = getevent_subscripttotalcount(eCode,"","","")

if LoginUserid <> "" then 
	myresultcnt = getevent_subscriptexistscount(eCode,LoginUserid,"","","")
end if

%>
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<style type="text/css">
.blossomPang {text-align:center;}
.blossomPang button {background-color:transparent;}
.blossomPang .topic {overflow:hidden; position:relative; background:#fccedc url(http://webimage.10x10.co.kr/playing/thing/vol012/bg_pink.png) 50% 0 repeat;}
.blossomPang .topic .bg {position:absolute; top:0; left:0; z-index:5; width:100%; height:142px; background:url(http://webimage.10x10.co.kr/playing/thing/vol012/bg_cherry_blossom.png) 50% 0 no-repeat;}
.blossomPang .topic .inner {padding:144px 0 102px; background:url(http://webimage.10x10.co.kr/playing/thing/vol012/bg_pattern_dot.png) 50% 0 repeat;}
.blossomPang h2 {position:relative; width:397px; height:228px; margin:0 auto;}
.blossomPang h2 span {display:block; background:url(http://webimage.10x10.co.kr/playing/thing/vol012/tit_blossom_pang.png) 50% 0 no-repeat; text-indent:-999em;}
.blossomPang h2 .letter {width:100%; height:92px;}
.blossomPang h2 .pang {position:absolute; top:133px; left:20px; width:94px; height:95px; background-position:-20px 100%;}
.blossomPang h2 .pang2 {top:113px; left:152px; background-position:-152px -113px; animation-delay:0.5s;}
.blossomPang h2 .pang3 {top:123px; left:282px; width:100px; height:95px; background-position:-282px -123px;  animation-delay:1s;}
.blossomPang .topic p {margin-top:70px;}

.leaf {position:absolute; top:0; left:50%; width:469px; height:100%; margin-left:-868px; background:url(http://webimage.10x10.co.kr/playing/thing/vol012/img_blossom_leaf_01.png) 50% 0 repeat-y;}
.leaf2 {top:0; width:50%; margin-left:351px; background-image:url(http://webimage.10x10.co.kr/playing/thing/vol012/img_blossom_leaf_02.png);}
.btnSkip {position:relative; z-index:5; width:193px; height:157px; margin:67px auto 0;}
.btnSkip i {position:absolute; top:0; left:0; width:100%; height:100%; margin-left:-16px; background:url(http://webimage.10x10.co.kr/playing/thing/vol012/btn_skip.png) 0 0 no-repeat;}
.btnSkip:hover i, .btnSkip:focus i {background-position:0 100%; animation:scale2 1.5s infinite alternate;}
.btnSkip a,
.btnSkip a span {position:absolute; top:0; left:0; width:100%; height:100%;}
.btnSkip a {color:transparent; line-height:157px;}
.btnSkip a span {margin-left:-16px; background:url(http://webimage.10x10.co.kr/playing/thing/vol012/btn_skip.png) 100% 0 no-repeat;}
.btnSkip a:hover span, .btnSkip a:focus span {background-position:100% 100%;}

.blossomPang .make {position:relative; height:1850px; background:#ffebf1 url(http://webimage.10x10.co.kr/playing/thing/vol012/bg_light_pink.png) 50% 0 repeat-x;}
.make .before, .make .after, .make .btnPang {position:absolute;}
.make .btnPang {transform-origin:50% 50%;}
.make .after {display:none;}
.make .btnClick {position:absolute; width:84px; height:91px; background:url(http://webimage.10x10.co.kr/playing/thing/vol012/btn_click.png) 50% 100% no-repeat;}
.make .btnClick:hover {animation:bounce 0.8s infinite alternate;}
.make .step2 .btnClick {animation-delay:0.5s;}
.make .step3 .btnClick {animation-delay:0.3s;}
.make .step5 .btnClick {animation-delay:0.2s;}
.make .btnClick span {display:block; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/playing/thing/vol012/btn_click.png) 50% 0 no-repeat; text-indent:-9999em;}
.make .btnClick:hover span {animation:flash 1.5s infinite;}
.make .object, .make .ani {position:absolute;}
.make .ani {opacity:0; filter:alpha(opacity=0);}
.make ol li {position:absolute; top:86px; left:50%; margin-left:-462px;}
.make .step1 {width:522px; height:265px;}
.make .step1 .before,
.make .step1 .after {top:79px; left:-48px; width:222px; height:130px;}
.make .step1 .before .object, .make .step1 .after .object {top:0; left:113px;}
.make .step1 .btnClick, .make .step1 .btnPang {top:38px; left:0;}
.make .step2 {top:236px; margin-left:174px; width:350px; height:301px; text-align:left;}
.make .step2 .before,
.make .step2 .after {top:0; left:49px; width:302px; height:242px;}
.step2 .ani {top:0; left:0; opacity:0;}
.step2 .ani1 {animation-delay:0.5s; filter:alpha(opacity=100);}
.step2 .ani2 {animation-delay:1s; filter:alpha(opacity=100);}

.make .step2 .btnClick {top:-36px; right:0;}
.make .step2 .btnPang {top:-44px; right:-29px;}
.make .step3 {top:509px; margin-left:-485px;}
.make .step3 .before {top:96px; left:153px; width:220px; height:181px;}
.make .step3 .after {top:88px; left:153px; width:249px; height:189px;}
.make .step3 .before .object, .make .step3 .after .object {position:absolute; top:98px; left:0;}
.make .step3 .after .object {top:106px;}
.make .step3 .btnClick, .make .step3 .btnPang {top:0; right:0;}

.make .step4 {top:693px; margin-left:89px;}
.make .step4 .before {top:0; left:214px; width:94px; height:223px;}
.make .step4 .btnClick {top:132px; left:0;}
.make .step4 .before .object {top:0; left:6px;}
.make .step4 .after {top:0; left:0; width:408px; height:254px;}
.make .step4 .after .object {top:0; left:220px;}
.make .step4 .btnPang {top:124px; left:206px;}
.step4 .ani {opacity:0; filter:alpha(opacity=100);}
.step4 .object {}
.step4 .after .object {opacity:0; filter:alpha(opacity=100);}
.step4 .ani1 {top:143px; left:63px; animation-delay:0.8s;}
.step4 .ani2 {top:162px; left:133px; animation-delay:1.2s;}
.step4 .ani3 {top:142px; left:337px; animation-delay:1.8s;}

.make .step5 {top:1225px; margin-left:-734px;}
.make .step5 .before {top:185px; left:50%; margin-left:299px;}
.step5 .flower1 {top:-22px; left:45px; animation-delay:1.5s;}
.step5 .flower2 {top:86px; left:550px;}
.step5 .flower3 {top:98px; right:0;  animation-delay:2.5s;}
.make .step5 .after {position:static;}
.make .step5 .btnPang {top:178px; left:50%; margin-left:292px;}
.step5 {z-index:10;}
.step5 .ani {left:50%; filter:alpha(opacity=100);}
.step5 .ani1 {top:-1004px; margin-left:-847px; animation-delay:1.5s;}
.step5 .ani2 {top:-262px; margin-left:-435px;}
.step5 .ani3 {top:-672px; margin-left:615px; animation-delay:1s;}
.step5 .ani4 {top:-302px; margin-left:200px; animation-delay:2s;}
.step5 .ani5 {top:-402px; margin-left:-350px; animation-delay:1.5s;}

.rolling {background-color:#ffe9f1;}
.rolling .wideSwipe .swiper-container,
.rolling .wideSwipe .swiper-slide img {height:700px;}
.rolling .slideNav {width:110px; background-image:url(http://webimage.10x10.co.kr/playing/thing/vol012/btn_nav.png);}
.rolling .btnPrev {margin-left:-570px; background-position:0 0;}
.rolling .btnPrev:hover {background-position:0 0;}
.rolling .btnNext {margin-left:460px; background-position:100% 0;}
.rolling .btnNext:hover {background-position:100% 0;}
.rolling .pagination {height:10px; bottom:30px;}
.rolling .pagination span {width:10px; height:10px; margin:0 6px; background:url(http://webimage.10x10.co.kr/playing/thing/vol012/btn_pagination.png) 50% 0 no-repeat; transition:all 0.5s;}
.rolling .pagination .swiper-active-switch {background-position:50% 100%;}
.rolling .mask {background:none; background-color:#fff; opacity:0.6; filter:alpha(opacity=60);}

.blossomPang .kit {overflow:hidden; position:relative; height:600px; background:#fac8d7 url(http://webimage.10x10.co.kr/playing/thing/vol012/bg_pink.png) 50% 0 repeat;}
.blossomPang .kit p {position:absolute; top:0; left:50%; margin-left:-1000px;}

.blossomPang .event {padding:100px 0 110px; background:#fb7189 url(http://webimage.10x10.co.kr/playing/thing/vol012/bg_hot_pink.png) 50% 0 repeat;}
.btnGet {position:relative; width:232px; height:200px; margin:40px auto 0;}
.btnGet i {position:absolute; top:0; left:0; width:100%; height:100%; margin-left:-23px; background:url(http://webimage.10x10.co.kr/playing/thing/vol012/btn_get.png) 0 0 no-repeat;}
.done i {background-position:0 100%;}
.btnGet:hover i {animation:scale2 1s infinite alternate;}
.btnGet button, .btnGet div,
.btnGet button span, .btnGet div span {position:absolute; top:0; left:0; width:100%; height:100%; margin-left:-11px;}
.btnGet button, .btnGet div {line-height:200px; text-indent:-9999em;}
.btnGet button span, .btnGet div span {background:url(http://webimage.10x10.co.kr/playing/thing/vol012/btn_get.png) 100% 0 no-repeat;}
.btnGet div span {background-position:100% 100%;}
.blossomPang .count {margin-top:20px; line-height:14px;}
.blossomPang .count b {margin:0 4px 0 10px; color:#fefdb0; font-family:'Dotum', '돋움', 'Verdana'; font-size:14px; vertical-align:middle;}
.blossomPang .volume {margin-top:50px; text-align:center;}

/* css3 animation */
.bounce {animation:bounce 0.8s infinite alternate;}
.pulse {animation:pulse 0.5s;}
@keyframes pulse {
	0% {transform:scale(0); opacity:0;}
	100% {transform:scale(1); opacity:1;}
}

.snowing {animation:snowing 20s linear infinite;}
@keyframes snowing {
	0% {background-position:0 0;}
	100% {background-position:0 1000px;}
}
.snowing2 {animation:snowing2 22s linear infinite;}
@keyframes snowing2 {
	0% {background-position:0px 0;}
	100% {background-position:0px 1000px;}
}
.flash {animation:flash;}
@keyframes flash {
	0%, 50%, 100% {opacity:1;}
	25%, 75% {opacity:0;}
}
.shake {animation:shake 1.5s 1 alternate;}
@keyframes shake {
	0% {transform:translateX(-50px) translateY(10px);}
	100% {transform:translateX(0) translateY(0);}
}
.swing {animation:swing 3s infinite; animation-fill-mode:both; transform-origin:50% 50%;}
@keyframes swing {
	0% {transform:rotateZ(0deg);}
	30% {transform:rotateZ(5deg);}
	60% {transform:rotateZ(-5deg);}
	100% {transform:rotateZ(0deg);}
}
@keyframes bounce {
	0% {transform:translateY(7px);}
	100% {transform:translateY(0);}
}

.slideUp {animation:slideUp 1.8s cubic-bezier(0.19, 1, 0.22, 1) forwards;}
@keyframes slideUp {
	0% {transform:translateY(10px); opacity:0;}
	100% {transform:translateY(0); opacity:1;}
}

.twinkle {animation:twinkle 1s 1; animation-fill-mode:both;}
@keyframes twinkle {
	0% {opacity:0;}
	100% {opacity:1;}
}

.fill {animation:fill 1s 1 alternate;}
@keyframes fill {
	0% {height:40px;}
	100% {height:83px;}
}

.scale {animation:scale 1s 1;}
@keyframes scale {
	0% {transform:scale(0);}
	100% {transform:scale(1);}
}

.scale2 {animation:scale2 1s;}
@keyframes scale2 {
	0% {transform:scale(1);}
	100% {transform:scale(0.8);}
}

.move {animation:move 4s infinite;}
@keyframes move {
	0% {transform:translateX(10px) translateY(0); opacity:1;}
	100% {transform:translateX(0) translateY(300px); opacity:0;}
}

.up {animation:up 2.5s 1 cubic-bezier(0.19, 1, 0.22, 1) forwards;}
@keyframes up {
	0% {transform:translateX(0) translateY(50px); opacity:0;}
	100% {transform:translateX(0) translateY(0); opacity:1;}
}
</style>
<script style="text/javascript">
$(function(){
	$("#topic .letter").hide();
	$("#topic .pang").hide();
	$("#topic .letter").fadeIn("slow");
	$("#topic .pang").fadeIn("slow");
	$("#topic .pang").addClass("pulse");

	$(window).scroll(function(){
		var position = $(window).scrollTop();
		console.log(position)
		if(position>=5){
			$("#topic .pang").fadeIn("slow");
			$("#topic .pang").addClass("pulse");
		}else{
			$("#topic .pang").fadeOut("fast");
			$("#topic .pang").removeClass("pulse");
		}
	});

	/* skip */
	$("#btnSkip a").on("click", function(e){
		window.$('html,body').animate({scrollTop:$(this.hash).offset().top},1000);
		return false;
	});

	$(".make .btnClick").on("click", function(e){
		$(this).parent().hide();
		$(this).parent().next().fadeIn();
		$(".btnPang").addClass("scale");
		$(".step5 .flower").removeClass("swing");
	});
	$(".make .btnPang").on("click", function(e){
		$(this).parent().hide();
		$(this).parent().prev().fadeIn();
	});
	
	$(".step1 .btnClick").on("click", function(e){
		$(".step1 .after .object").show().addClass("shake");
	});
	$(".step2 .btnClick").on("click", function(e){
		$(".step2 .ani").show().addClass("twinkle");
	});
	$(".step3 .btnClick").on("click", function(e){
		$(".step3 .after .object img").show().addClass("fill");
	});
	$(".step4 .btnClick").on("click", function(e){
		$(".step4 .after span").show().addClass("slideUp");
	});
	$(".step5 .btnClick").on("click", function(e){
		$(".step5 .ani").show().addClass("move");
		$(".step5 .flower").addClass("swing");
	});

	// wide swipe
	var evtSwiper = new Swiper('#wideSwipe .swiper-container',{
		loop:true,
		slidesPerView:'auto',
		centeredSlides:true,
		speed:1400,
		autoplay:3500,
		simulateTouch:false,
		pagination:'#wideSwipe .pagination',
		paginationClickable:true,
		nextButton:'#wideSwipe .btnNext',
		prevButton:'#wideSwipe .btnPrev'
	})
	$('#wideSwipe .btnPrev').on('click', function(e){
		e.preventDefault();
		evtSwiper.swipePrev();
	});
	$('#wideSwipe .btnNext').on('click', function(e){
		e.preventDefault();
		evtSwiper.swipeNext();
	});
});

function jsplayingthingresult(){
<% If IsUserLoginOK() Then %>
	$.ajax({
		type: "GET",
		url: "/playing/sub/doEventSubscript77393.asp",
		data: "mode=result",
		cache: false,
		success: function(str) {
			var str = str.replace("undefined","");
			var res = str.split("|");

			if (res[0]=="OK") {
				alert('신청이 완료 되었습니다.');
				$("#recnt").empty().html(res[1]);
				$("#btnGet").addClass(" done");
				$("#btnGet").empty().html(res[2]);
			} else {
				errorMsg = res[1].replace(">?n", "\n");
				alert(errorMsg );
				return false;
			}
		}
		,error: function(err) {
			console.log(err.responseText);
			alert("통신중 오류가 발생했습니다. 잠시 후 다시 시도해주세요..");
		}
	});
<% else %>
	if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
		location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/playing/view.asp?didx="&vDIdx)%>';
		return;
	}
	return false;
<% end if %>
}
</script>

	<%'' THING. html 코딩 영역 : 클래스명은 thing+볼륨 예) thingVol001 / 이미지폴더는 볼륨을 따라 vol001 %>
	<%'' Vol.012 꽃을 찍어요 팡팡팡 : 77393 %>
	<div class="thingVol012 blossomPang">
		<div id="topic" class="seciton topic">
			<div class="bg"></div>
			<div class="leaf leaf1 snowing"></div>
			<div class="leaf leaf2 snowing2"></div>
			<div class="inner">
				<h2>
					<span class="letter up">꽃을 찍어요</span>
					<span class="pang pang1">팡</span>
					<span class="pang pang2">팡</span>
					<span class="pang pang3">팡</span>
				</h2>
				<p><img src="http://webimage.10x10.co.kr/playing/thing/vol012/txt_blossom_pang_v1.png" alt="벚꽃이 팡팡 터지는 요즘, 꽃놀이 사진 찍으셨나요? 일상에서도 팡팡 꽃 피게 해줄 벚꽃 잎 스탬프를 여기저기 찍어보세요! 일상에 꽃이 날리는 좋은 일이 생길 거에요 Blossom Pang kit를 만나보세요" /></p>
				<div id="btnSkip" class="btnSkip"><i></i><a href="#make"><span></span>Blossom Pang 만들러 가기</a></div>
			</div>
		</div>

		<div id="make" class="seciton make">
			<ol>
				<li class="step1">
					<p><img src="http://webimage.10x10.co.kr/playing/thing/vol012/txt_make_01.png" alt="꽃잎을 한 잎씩 찍어 꽃 한 송이를 만들어 주세요" /></p>
					<div class="before">
						<span class="object"><img src="http://webimage.10x10.co.kr/playing/thing/vol012/img_make_01_before.png" alt="" /></span>
						<button type="button" class="btnClick"><span>Click</span></button>
					</div>
					<div class="after">
						<span class="object"><img src="http://webimage.10x10.co.kr/playing/thing/vol012/img_make_01_after.png" alt="" /></span>
						<button type="button" class="btnPang"><img src="http://webimage.10x10.co.kr/playing/thing/vol012/btn_pang.png" alt="Pang" /></button>
					</div>
				</li>
				<li class="step2">
					<p><img src="http://webimage.10x10.co.kr/playing/thing/vol012/txt_make_02.png" alt="꽃잎에 나뭇가지 스탬프를 여러 번 찍어주세요" /></p>
					<div class="before">
						<span class="object"><img src="http://webimage.10x10.co.kr/playing/thing/vol012/img_make_02_before.png" alt="" /></span>
						<button type="button" class="btnClick"><span>Click</span></button>
					</div>
					<div class="after">
						<span class="object"><img src="http://webimage.10x10.co.kr/playing/thing/vol012/img_make_02_after_01.png" alt="" /></span>
						<span class="ani ani1"><img src="http://webimage.10x10.co.kr/playing/thing/vol012/img_make_02_after_02.png" alt="" /></span>
						<span class="ani ani2"><img src="http://webimage.10x10.co.kr/playing/thing/vol012/img_make_02_after_03.png" alt="" /></span>
						<button type="button" class="btnPang"><img src="http://webimage.10x10.co.kr/playing/thing/vol012/btn_pang.png" alt="Pang" /></button>
					</div>
				</li>
				<li class="step3">
					<p><img src="http://webimage.10x10.co.kr/playing/thing/vol012/txt_make_03.png" alt="꽃의 파릇파릇한 잎을 만들어주세요" /></p>
					<div class="before">
						<span class="object"><img src="http://webimage.10x10.co.kr/playing/thing/vol012/img_make_03_before.png" alt="" /></span>
						<button type="button" class="btnClick"><span>Click</span></button>
					</div>
					<div class="after">
						<span class="object"><img src="http://webimage.10x10.co.kr/playing/thing/vol012/img_make_03_after.png" alt="" /></span>
						<button type="button" class="btnPang"><img src="http://webimage.10x10.co.kr/playing/thing/vol012/btn_pang.png" alt="Pang" /></button>
					</div>
				</li>
				<li class="step4">
					<p><img src="http://webimage.10x10.co.kr/playing/thing/vol012/txt_make_04.png" alt="꽃잎을 찍은 후 나뭇가지 스탬프로 꽃받침을 만들어주세요" /></p>
					<div class="before">
						<span class="object"><img src="http://webimage.10x10.co.kr/playing/thing/vol012/img_make_04_before.png" alt="" /></span>
						<button type="button" class="btnClick"><span>Click</span></button>
					</div>
					<div class="after">
						<span class="object"><img src="http://webimage.10x10.co.kr/playing/thing/vol012/img_make_04_after_04.png" alt="" /></span>
						<span class="ani ani1"><img src="http://webimage.10x10.co.kr/playing/thing/vol012/img_make_04_after_01.png" alt="" /></span>
						<span class="ani ani2"><img src="http://webimage.10x10.co.kr/playing/thing/vol012/img_make_04_after_02.png" alt="" /></span>
						<span class="ani ani3"><img src="http://webimage.10x10.co.kr/playing/thing/vol012/img_make_04_after_03.png" alt="" /></span>
						<button type="button" class="btnPang"><img src="http://webimage.10x10.co.kr/playing/thing/vol012/btn_pang.png" alt="Pang" /></button>
					</div>
				</li>
				<li class="step5">
					<p><img src="http://webimage.10x10.co.kr/playing/thing/vol012/txt_make_05_v1.png" alt="완성된 꽃들 주변에 흩날리는 꽃잎을 만들어주세요" /></p>
					<span class="object flower flower1"><img src="http://webimage.10x10.co.kr/playing/thing/vol012/img_flower_01.png" alt="" /></span>
					<span class="object flower flower2"><img src="http://webimage.10x10.co.kr/playing/thing/vol012/img_flower_02.png" alt="" /></span>
					<span class="object flower flower3"><img src="http://webimage.10x10.co.kr/playing/thing/vol012/img_flower_03.png" alt="" /></span>
					<div class="before">
						<button type="button" class="btnClick"><span>Click</span></button>
					</div>
					<div class="after">
						<span class="ani ani1"><img src="http://webimage.10x10.co.kr/playing/thing/vol012/img_make_05_after_01.png" alt="" /></span>
						<span class="ani ani2"><img src="http://webimage.10x10.co.kr/playing/thing/vol012/img_make_05_after_02.png" alt="" /></span>
						<span class="ani ani3"><img src="http://webimage.10x10.co.kr/playing/thing/vol012/img_make_05_after_03.png" alt="" /></span>
						<span class="ani ani4"><img src="http://webimage.10x10.co.kr/playing/thing/vol012/img_make_05_after_02.png" alt="" /></span>
						<span class="ani ani5"><img src="http://webimage.10x10.co.kr/playing/thing/vol012/img_make_05_after_03.png" alt="" /></span>
						<button type="button" class="btnPang"><img src="http://webimage.10x10.co.kr/playing/thing/vol012/btn_pang.png" alt="Pang" /></button>
					</div>
				</li>
			</ol>
		</div>

		<div class="seciton rolling">
			<!-- swipe -->
			<div id="wideSwipe" class="slideTemplateV15 wideSwipe">
				<div class="swiper-container">
					<div class="swiper-wrapper">
						<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/playing/thing/vol012/img_slide_01.jpg" alt="" /></div>
						<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/playing/thing/vol012/img_slide_02.jpg" alt="" /></div>
						<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/playing/thing/vol012/img_slide_03.jpg" alt="" /></div>
						<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/playing/thing/vol012/img_slide_04.jpg" alt="" /></div>
						<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/playing/thing/vol012/img_slide_05.jpg" alt="" /></div>
					</div>
					<div class="pagination"></div>
					<button class="slideNav btnPrev">이전</button>
					<button class="slideNav btnNext">다음</button>
					<div class="mask left"></div>
					<div class="mask right"></div>
				</div>
			</div>
		</div>

		<div class="seciton kit">
			<p><img src="http://webimage.10x10.co.kr/playing/thing/vol012/txt_kit.jpg" width="2000" height="600" alt="BLOSSOM PANG Mini KIT는 미니 꽃잎 스탬프 꽃잎3종 나뭇가지1종 10X10mm, 잉크패드pink 32x32mm, 무지 엽서2장 104x154mm, 미니 색연필 set로 구성되어있습니다." /></p>
		</div>

		<%'' for dev msg : 응모하기 %>
		<div class="seciton event">
			<p><img src="http://webimage.10x10.co.kr/playing/thing/vol012/txt_event.png" alt="BLOSSOM PANG KIT로 꽃을 팡팡팡 찍으세요! Blossom kit를 신청해주시면 추첨을 통해 총 70명에게 kit를 드립니다. 응모기간은 4월 10일부터 4월 23일까지며, 당첨자 발표는 4월 24일 월요일입니다. 한 ID당 1회 신청 가능합니다." /></p>
			<% if myresultcnt > 0 then %>
				<%'' 신청 후 %>
				<div class="btnGet done" id="btnGet"><i></i>
					<div><span></span>Blossom Pang Kit 신청완료</div>
				</div>
			<% else %>
				<%'' 신청 전 %>
				<div class="btnGet" id="btnGet"><i></i>
					<button type="button" onclick="jsplayingthingresult(); return false;" >
						<span></span>Blossom Pang Kit 신청하기
					</button>
				</div>
			<% end if %>
			<p class="count">
				<img src="http://webimage.10x10.co.kr/playing/thing/vol012/txt_count_01.png" alt="총" /><b id="recnt"><%= totalcnt %></b><img src="http://webimage.10x10.co.kr/playing/thing/vol012/txt_count_02.png" alt="명이 신청했습니다" />
			</p>
		</div>
		<!-- volume -->
		<div class="seciton volume">
			<p><img src="http://webimage.10x10.co.kr/playing/thing/vol012/txt_vol012.gif" alt="Volume 12 Thing의 사물에 대한 생각 일상의 꽃잎을 찍으세요!" /></p>
		</div>
	</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->