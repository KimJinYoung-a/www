<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<!-- #include Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<%
'####################################################
' Description : PLAYing 마음씨약국
' History : 2017-03-10 김진영 생성
'####################################################
Dim eCode, sqlStr, LoginUserid, vDIdx, myresultCnt, totalresultCnt
IF application("Svr_Info") = "Dev" THEN
	eCode   =  66288
Else
	eCode   =  76711
End If

vDIdx = request("didx")
LoginUserid	= getencLoginUserid()

'1. 로그인을 했다면 tbl_event_subscript에 ID가 있는 지 확인
If IsUserLoginOK() Then
	sqlStr = "SELECT count(*) FROM [db_event].[dbo].[tbl_event_subscript] WHERE evt_code = '" & eCode & "' and userid = '" & LoginUserid & "' AND sub_opt1 = 'result' "
	rsget.Open sqlStr,dbget,1
	If not rsget.EOF Then
		myresultCnt = rsget(0)
	End If
	rsget.close
Else
	myresultCnt = 0
End If

'2. 전체 참여자 카운트
sqlStr = "SELECT count(*) FROM [db_event].[dbo].[tbl_event_subscript] WHERE evt_code = '" & eCode & "' AND sub_opt1 = 'result' "
rsget.Open sqlStr,dbget,1
If not rsget.EOF Then
	totalresultCnt = rsget(0)
End If
rsget.close
%>
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<style type="text/css">
button {outline:none; background-color:transparent;}
.heartSeed {text-align:center;}
.heartSeed .intro {position:relative; height:1782px; background:#1f9d62 url(http://webimage.10x10.co.kr/playing/thing/vol010/bg_intro.png) 50% 70px no-repeat;}
.heartSeed .intro h2 {position:absolute; left:50%; top:300px; z-index:30; margin-left:-128px; animation:flip 2s 1.8s; -webkit-animation:flip 2s 1.8s;}
.heartSeed .intro .deco1 {position:absolute; left:50%; top:190px; z-index:20; margin-left:-184px; animation:spin 1.5s .5s 1; -webkit-animation:spin 1.5s .5s 1;}
.heartSeed .intro .deco2 {position:absolute; left:50%; top:190px;  z-index:30; margin-left:-64px;}
.heartSeed .intro .deco3 {position:absolute; left:50%; top:254px;  z-index:30; margin-left:130px;}
.heartSeed .intro .seed {padding:585px 0 30px;}
.heartSeed .intro .swiper {position:relative; width:902px; margin:86px auto 68px;}
.heartSeed .intro .swiper .swiper-container { height:596px; }
.heartSeed .intro .swiper .swiper-slide {float:left; width:902px;}
.heartSeed .intro .swiper button {position:absolute; top:50%; margin-top:-27px;}
.heartSeed .intro .swiper button.btnPrev {left:-63px;}
.heartSeed .intro .swiper button.btnNext {right:-63px;}
.heartSeed .intro .swiper .pagination {position:absolute; bottom:30px; left:0; z-index:5; width:100%; height:auto; z-index:50; padding-top:0; text-align:center;}
.heartSeed .intro .swiper .pagination span {display:inline-block; width:22px; height:13px; margin:0 8px; cursor:pointer; background:url(http://webimage.10x10.co.kr/playing/thing/vol010/btn_pagination.png) 0 0 no-repeat; vertical-align:middle;}
.heartSeed .intro .swiper .pagination .swiper-active-switch {background-position:100% 0;}
.heartSeed .intro .btnStart {animation:bounce1 1s 30; -webkit-animation:bounce1 1s 30;}
.heartTest {position:relative; padding:220px 0 115px; background:#e7e7e7 url(http://webimage.10x10.co.kr/playing/thing/vol010/bg_box_top.png) 50% 0 no-repeat;}
.heartTest .inner {width:1140px; margin:0 auto; padding-bottom:30px; background:url(http://webimage.10x10.co.kr/playing/thing/vol010/bg_box_btm.png) 50% 100% no-repeat;}
.heartTest .question {padding:0 168px; background:url(http://webimage.10x10.co.kr/playing/thing/vol010/bg_box.png) 50% 0 repeat-y;}
.heartTest .question .dash{height:2px; background:url(http://webimage.10x10.co.kr/playing/thing/vol010/bg_dash.png) 50% 0 no-repeat;}
.heartTest .question ul {overflow:hidden;}
.heartTest .question li {position:relative; float:left; cursor:pointer;}
.heartTest .question li i {display:none; position:absolute; left:50%; z-index:40; width:24px; height:24px; margin-left:-9px; background:url(http://webimage.10x10.co.kr/playing/thing/vol010/ico_check.png) 0 0 no-repeat; background-size:100%;}
.heartTest .question li.current i {display:block; animation:bounce1 .5s; -webkit-animation:bounce1 .4s;}
.heartTest .question1 ul {width:403px; height:199px; margin:32px auto 65px; padding:55px 32px 0; text-align:left; background:url(http://webimage.10x10.co.kr/playing/thing/vol010/bg_question_1.png) 0 0 no-repeat;}
.heartTest .question1 li {float:none; margin-bottom:32px; padding-bottom:24px;}
.heartTest .question1 li:after {content:''; display:inline-block; position:absolute; left:0; bottom:0; width:100%; height:6px; background:url(http://webimage.10x10.co.kr/playing/thing/vol010/bg_line.png) 50% 0 no-repeat;}
.heartTest .question1 li img {vertical-align:middle;}
.heartTest .question1 input {width:55px; height:30px; text-align:right; margin:0 5px 0 15px; font-size:24px; border:0; color:#6c5c11; background:transparent; vertical-align:middle;}
.heartTest .question1 li:first-child label {position:relative; width:40px;}
.heartTest .question1 li:first-child label:after {content:''; display:inline-block; position:absolute; right:-20px; top:-5px; width:0.2rem; height:28px; background:url(http://webimage.10x10.co.kr/playing/thing/vol010/m/img_cursor.gif) 0 0 no-repeat;}
.heartTest .question1 li.cursor label:after {display:none;}
.heartTest .question2 h3 {padding:62px 0 38px;}
.heartTest .question2 ul {width:690px; margin:0 auto; padding-bottom:80px;}
.heartTest .question2 li {width:33.33333%;}
.heartTest .question2 li i {top:38px;}
.heartTest .question3 h3 {padding:62px 0;}
.heartTest .question3 ul {padding-bottom:110px;}
.heartTest .question3 li {width:25%;}
.heartTest .question3 li i {top:10px;}
.heartTest .question4 h3 {padding:80px 0 35px;}
.heartTest .question4 ul {padding-bottom:130px;}
.heartTest .question4 li {width:16.66%;}
.heartTest .question4 li i {bottom:8px;}
.heartTest .question5 {padding-bottom:105px;}
.heartTest .question5 h3 {padding:86px 0 37px;}
.heartTest .question5 li i {top:-18px;}
.heartTest .question5 .word {position:relative; width:700px; height:340px; margin:0 auto; background:url(http://webimage.10x10.co.kr/playing/thing/vol010/bg_question_5.png) 50% 60px no-repeat;}
.heartTest .question5 .word li {position:absolute; height:35px;}
.heartTest .question5 .word li span {overflow:hidden; display:inline-block; height:35px;}
.heartTest .question5 .word li.current img {margin-top:-35px;}
.heartTest .question5 .word li.w1 {left:0; top:46px;}
.heartTest .question5 .word li.w2 {left:226px; top:50px;}
.heartTest .question5 .word li.w3 {left:438px; top:0;}
.heartTest .question5 .word li.w4 {right:0; top:73px;}
.heartTest .question5 .word li.w5 {left:92px; top:134px;}
.heartTest .question5 .word li.w6 {left:242px; top:153px;}
.heartTest .question5 .word li.w7 {left:394px; top:130px;}
.heartTest .question5 .word li.w8 {left:510px; top:170px;}
.heartTest .question5 .word li.w9 {left:7px; top:224px;}
.heartTest .question5 .word li.w10 {left:309px; top:235px;}
.heartTest .question5 .word li.w11 {left:561px; top:258px;}
.heartTest .question5 .word li.w12 {left:116px; bottom:0;}
.heartTest .question5 .word li.w13 {left:414px; bottom:0;}
.heartTest .pen {position:absolute; left:50%; bottom:0; width:258px; height:371px; margin-left:390px; background:url(http://webimage.10x10.co.kr/playing/thing/vol010/bg_pen.png) 0 0 no-repeat;}
.heartSeed .loading {display:none; position:fixed; left:0; top:0; z-index:40; width:100%; height:100%; text-align:center; background:url(http://webimage.10x10.co.kr/playing/thing/vol010/bg_mask.png) 0 0 repeat;}
.heartSeed .loading div {position:absolute; left:0; top:50%; width:100%; height:134px; margin-top:-67px; padding-top:98px;}
.heartSeed .loading span {position:absolute; left:50%; top:0; margin-left:-40px;}
.heartSeed .loadOn .loading {display:block;}
.heartSeed .loadOn .loading span {animation:spin 1.5s .5s 3; -webkit-animation:spin 1.5s .5s 3;}
.prescription {display:none; background:#d9f2e8;}
.prescription .result {width:855px; height:902px; margin:0 auto; background:url(http://webimage.10x10.co.kr/playing/thing/vol010/bg_paper.png) 0 0 no-repeat;}
.prescription .result h3 {padding:120px 0 34px;}
.prescription .result .inner {position:relative;}
.prescription .result .inner  .name {position:absolute; left:0; top:0; width:100%; color:#666;}
.prescription .result .inner  .name em {font:bold 27px/29px 'Dotum'; vertical-align:top;}
.prescription .kit {padding:112px 0 105px; background:#1f9d62;}
.prescription .kit .total {padding-top:20px; font-size:13px; font-weight:bold; color:#000;}
.vol010 {margin-top:10px; text-align:center;}
@keyframes bounce1{
	from,to {transform:translateY(0);}
	50% {transform:translateY(5px);}
}
@-webkit-keyframes bounce1{
	from,to {-webkit-transform:translateY(0);}
	50% {-webkit-transform:translateY(5px);}
}
@keyframes flip {
  from {transform: perspective(200px) rotate3d(1, 0, 0, 90deg); animation-timing-function: ease-in;}
  40% {transform: perspective(200px) rotate3d(1, 0, 0, -30deg);}
  60% {transform: perspective(200px) rotate3d(1, 0, 0, 30deg);}
  80% {transform: perspective(200px) rotate3d(1, 0, 0, -5deg);}
  to {transform: perspective(200px);}
}
@-webkit-keyframes flip {
  from {-webkit-transform: perspective(200px) rotate3d(1, 0, 0, 90deg); -webkit-animation-timing-function: ease-in;}
  40% {-webkit-transform: perspective(200px) rotate3d(1, 0, 0, -30deg);}
  60% {-webkit-transform: perspective(200px) rotate3d(1, 0, 0, 30deg);}
  80% {-webkit-transform: perspective(200px) rotate3d(1, 0, 0, -5deg);}
  to {-webkit-transform: perspective(200px);}
}
@keyframes spin {
	from {transform:rotate(0deg);}
	to {transform:rotate(360deg);}
}
@-webkit-keyframes spin {
	from {-webkit-transform:rotate(0deg);}
	to {-webkit-transform:rotate(360deg);}
}
</style>
<script type="text/javascript">
$(function(){
	$("#uYear").blur(function(){
		$(this).val($(this).val().replace(/[^0-9]/g,"").replace(/^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?([0-9]{3,4})-?([0-9]{4})$/, "$1-$2-$3"));
	});
	$("#uMonth").blur(function(){
		$(this).val($(this).val().replace(/[^0-9]/g,"").replace(/^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?([0-9]{3,4})-?([0-9]{4})$/, "$1-$2-$3"));
	});
	$("#uDay").blur(function(){
		$(this).val($(this).val().replace(/[^0-9]/g,"").replace(/^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?([0-9]{3,4})-?([0-9]{4})$/, "$1-$2-$3"));
	});

	var mySwiper = new Swiper('.intro .swiper-container',{
		autoplay:2700,
		pagination:".intro .pagination",
		paginationClickable:true,
		speed:600
	})
	$('.intro .btnPrev').on('click', function(e){
		e.preventDefault();
		mySwiper.swipePrev();
	});
	$('.intro .btnNext').on('click', function(e){
		e.preventDefault();
		mySwiper.swipeNext();
	});

	$(".btnStart").click(function(event){
		event.preventDefault();
		window.parent.$('html,body').animate({scrollTop:$("#heartTest").offset().top},500);
	});

	$(".question li").click(function(){
		$(this).siblings("li").removeClass("current");
		$(this).addClass("current");
	});
	$('.question1 li input').focus(function() {
		$(this).closest("li").addClass("cursor");
	});

	// title animation
	titleAnimation()
	$(".intro h2").css({"opacity":"0"});
	$(".intro .deco2").css({"margin-top":"-10px","opacity":"0"});
	$(".intro .deco3").css({"margin-top":"-10px","opacity":"0"});
	function titleAnimation() {
		$(".intro h2").delay(1800).animate({"opacity":"1"},800);
		$(".intro .deco2").delay(1300).animate({"margin-top":"0", "opacity":"1"},600);
		$(".intro .deco3").delay(1600).animate({"margin-top":"0", "opacity":"1"},600);
	}
});

function jsplayingthing(num, sel){
	if(sel == 2) {$("#tmpex2").val(num);}
	if(sel == 3) {$("#tmpex3").val(num);}
	if(sel == 4) {$("#tmpex4").val(num);}
	if(sel == 5) {$("#tmpex5").val(num);}
}

function jsplayingthingadd(v){
<%
If IsUserLoginOK() Then
	If date() >="2017-03-10" and date() <= "2017-03-22" Then
%>
	if($("#uName").val() == ""){
		alert('이름을 입력하세요');
		window.parent.$('html,body').animate({scrollTop:$("#heartTest").offset().top},500);
		return false;
	}

	if($("#uYear").val() == ""){
		alert('생일을 입력하세요');
		window.parent.$('html,body').animate({scrollTop:$("#heartTest").offset().top},500);
		return false;
	}

	if($("#uYear").val() < 1900 || $("#uYear").val() >= 2017){
		alert('연도를 정확히 입력하세요');
		window.parent.$('html,body').animate({scrollTop:$("#heartTest").offset().top},500);
		return false;
	}

	if($("#uMonth").val() == ""){
		alert('생일을 입력하세요');
		window.parent.$('html,body').animate({scrollTop:$("#heartTest").offset().top},500);
		return false;
	}

	if($("#uMonth").val() < 1 || $("#uMonth").val() >= 13){
		alert('월을 정확히 입력하세요');
		window.parent.$('html,body').animate({scrollTop:$("#heartTest").offset().top},500);
		return false;
	}

	if($("#uDay").val() == ""){
		alert('생일을 입력하세요');
		window.parent.$('html,body').animate({scrollTop:$("#heartTest").offset().top},500);
		return false;
	}

	if($("#uDay").val() > 31){
		alert('일을 정확히 입력하세요');
		window.parent.$('html,body').animate({scrollTop:$("#heartTest").offset().top},500);
		return false;
	}

	if($("#tmpex2").val() == ""){
		alert('두 번째 기초테스트를 선택하세요');
		window.parent.$('html,body').animate({scrollTop:$("#Q2").offset().top},500);
		return false;
	}

	if($("#tmpex3").val() == ""){
		alert('세 번째 기초테스트를 선택하세요');
		window.parent.$('html,body').animate({scrollTop:$("#Q3").offset().top},500);
		return false;
	}

	if($("#tmpex4").val() == ""){
		alert('네 번째 감각테스트를 선택하세요');
		window.parent.$('html,body').animate({scrollTop:$("#Q4").offset().top},500);
		return false;
	}

	if($("#tmpex5").val() == ""){
		alert('다섯 번째 감정테스트를 선택하세요');
		window.parent.$('html,body').animate({scrollTop:$("#Q5").offset().top},500);
		return false;
	}
	var str;
	if(v == "1"){
		str = $.ajax({
			type: "POST",
			url: "/playing/sub/doEventSubscript76711.asp?mode=add",
			data: $("#sfrm").serialize(),
			dataType: "text",
			async: false
		}).responseText;
		console.log(str);
		var str1 = str.split("|")
		console.log(str);

		if (str1[0] == "OK"){
			$(".heartTest").removeClass("loadOn");
			$(".loading").show();
			$(".prescription").hide();

			$("#vResult").empty().html(str1[1]);
			$("#vResult").show();

			event.preventDefault();
			$(".heartTest").addClass("loadOn");
			$(".loading").delay(3500).fadeOut(100);
			$(".prescription").delay(3500).fadeIn(10);
			setTimeout(function(){
				window.parent.$('html,body').animate({scrollTop:$("#prescription").offset().top},500);
			},3600);
		} else {
		
		}
	}else{
		str = $.ajax({
			type: "POST",
			url: "/playing/sub/doEventSubscript76711.asp?mode=result",
			data: $("#sfrm").serialize(),
			dataType: "text",
			async: false
		}).responseText;
		console.log(str);
		var str1 = str.split("|")
		console.log(str);

		if (str1[0] == "05"){
			alert('응모가 완료 되었습니다!');
		}else if(str1[0] == "03"){
			alert('이미 응모하였습니다.!');
		} else {
			alert('오류가 발생했습니다.');
			parent.location.reload();
		}
		return false;
	}
<%
	End If
Else
%>
	jsChklogin('<%=IsUserLoginOK%>');
	return false;
<% end if %>
}

</script>
<div class="thingVol010 heartSeed">
<form name="sfrm" id="sfrm" method="post">
<input type="hidden" name="tmpex2" id="tmpex2">
<input type="hidden" name="tmpex3" id="tmpex3">
<input type="hidden" name="tmpex4" id="tmpex4">
<input type="hidden" name="tmpex5" id="tmpex5">
	<div class="intro">
		<h2><img src="http://webimage.10x10.co.kr/playing/thing/vol010/tit_heart_pharmacy.png" alt="마음씨 약국" /></h2>
		<div class="deco1"><img src="http://webimage.10x10.co.kr/playing/thing/vol010/bg_intro_deco_1.png" alt="" /></div>
		<div class="deco2"><img src="http://webimage.10x10.co.kr/playing/thing/vol010/bg_intro_deco_2.png" alt="" /></div>
		<div class="deco3"><img src="http://webimage.10x10.co.kr/playing/thing/vol010/bg_seed.png" alt="" /></div>
		<div class="seed"><img src="http://webimage.10x10.co.kr/playing/thing/vol010/img_seed.gif" alt="" /></div>
		<p><img src="http://webimage.10x10.co.kr/playing/thing/vol010/txt_purpose.png" alt="마음씨 약국에 오신 걸 환영합니다. 요즘 여러분의 증상은 어떤가요? 난 못하겠어 증상, 앞이 캄캄해 증상, 돌아갈래 증상,, 여러분의 증상을 체크하세요! 마음씨 약국이 씨약으로 처방해드립니다." /></p>
		<div class="swiper">
			<div class="swiper-container">
				<div class="swiper-wrapper">
					<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/playing/thing/vol010/img_slide_01.jpg" alt="" /></div>
					<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/playing/thing/vol010/img_slide_02.jpg" alt="" /></div>
					<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/playing/thing/vol010/img_slide_03.jpg" alt="" /></div>
					<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/playing/thing/vol010/img_slide_04.jpg" alt="" /></div>
					<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/playing/thing/vol010/img_slide_05.jpg" alt="" /></div>
				</div>
				<div class="pagination"></div>
			</div>
			<button class="btnPrev"><img src="http://webimage.10x10.co.kr/playing/thing/vol010/btn_prev.png" alt="이전" /></button>
			<button class="btnNext"><img src="http://webimage.10x10.co.kr/playing/thing/vol010/btn_next.png" alt="다음" /></button>
		</div>
		<button type="button" class="btnStart"><img src="http://webimage.10x10.co.kr/playing/thing/vol010/btn_start.png" alt="증상 체크하기" /></button>
	</div>
	<%' 증상 테스트 (각 항목마다 선택한 li는 클래스 current 들어가게 해놓았습니다!) %>
	<div id="heartTest" class="heartTest">
		<div class="inner">
			<%' Q1 %>
			<div class="question question1">
				<h3><img src="http://webimage.10x10.co.kr/playing/thing/vol010/tit_question_1.png" alt="첫번째, 기초정보입력 - 이름과 생년월일을 적어주세요!" /></h3>
				<ul>
					<li>
						<label class="uName"><img src="http://webimage.10x10.co.kr/playing/thing/vol010/txt_name.png" alt="이름" /></label>
						<input type="text" id="uName" name="uName" class="lt" style="width:250px;" />
					</li>
					<li>
						<label class="uYear"><img src="http://webimage.10x10.co.kr/playing/thing/vol010/txt_birth.png" alt="생일" /></label>
						<input type="text" id="uYear" name="uYear" style="width:70px;" maxlength="4" />
						<label class="uYear"><img src="http://webimage.10x10.co.kr/playing/thing/vol010/txt_year.png" alt="년" /></label>
						<input type="text" id="uMonth" name="uMonth" maxlength="2" />
						<label class="uMonth"><img src="http://webimage.10x10.co.kr/playing/thing/vol010/txt_month.png" alt="월" /></label>
						<input type="text" id="uDay" name="uDay" maxlength="2" />
						<label class="uDay"><img src="http://webimage.10x10.co.kr/playing/thing/vol010/txt_day.png" alt="일" /></label>
					</li>
				</ul>
				<div class="dash"></div>
			</div>
			<%' Q2 %>
			<div class="question question2" id="Q2">
				<h3><img src="http://webimage.10x10.co.kr/playing/thing/vol010/tit_question_2.png" alt="두번째, 기초테스트 - 요즘 나의 관심사를 선택해 주세요!" /></h3>
				<ul>
					<li onclick="jsplayingthing('1','2'); return false;"><i></i><img src="http://webimage.10x10.co.kr/playing/thing/vol010/btn_interest_1.png" alt="직장/학업" /></li>
					<li onclick="jsplayingthing('2','2'); return false;"><i></i><img src="http://webimage.10x10.co.kr/playing/thing/vol010/btn_interest_2.png" alt="연애" /></li>
					<li onclick="jsplayingthing('3','2'); return false;"><i></i><img src="http://webimage.10x10.co.kr/playing/thing/vol010/btn_interest_3.png" alt="다이어트" /></li>
				</ul>
				<div class="dash"></div>
			</div>
			<%' Q3 %>
			<div class="question question3" id="Q3">
				<h3><img src="http://webimage.10x10.co.kr/playing/thing/vol010/tit_question_3.png" alt="세번째, 감각테스트 - 끌리는 색 조합을 선택해주세요!" /></h3>
				<ul>
					<li onclick="jsplayingthing('1','3'); return false;"><i></i><img src="http://webimage.10x10.co.kr/playing/thing/vol010/btn_color_1.png" alt="" /></li>
					<li onclick="jsplayingthing('2','3'); return false;"><i></i><img src="http://webimage.10x10.co.kr/playing/thing/vol010/btn_color_2.png" alt="" /></li>
					<li onclick="jsplayingthing('3','3'); return false;"><i></i><img src="http://webimage.10x10.co.kr/playing/thing/vol010/btn_color_3.png" alt="" /></li>
					<li onclick="jsplayingthing('4','3'); return false;"><i></i><img src="http://webimage.10x10.co.kr/playing/thing/vol010/btn_color_4.png" alt="" /></li>
				</ul>
				<div class="dash"></div>
			</div>
			<%' Q4 %>
			<div class="question question4" id="Q4">
				<h3><img src="http://webimage.10x10.co.kr/playing/thing/vol010/tit_question_4.png" alt="네번째, 감정테스트 - 지금 나의 상태를 선택해주세요!" /></h3>
				<ul>
					<li onclick="jsplayingthing('1','4'); return false;"><i></i><img src="http://webimage.10x10.co.kr/playing/thing/vol010/btn_face_1.png" alt="" /></li>
					<li onclick="jsplayingthing('2','4'); return false;"><i></i><img src="http://webimage.10x10.co.kr/playing/thing/vol010/btn_face_2.png" alt="" /></li>
					<li onclick="jsplayingthing('3','4'); return false;"><i></i><img src="http://webimage.10x10.co.kr/playing/thing/vol010/btn_face_3.png" alt="" /></li>
					<li onclick="jsplayingthing('4','4'); return false;"><i></i><img src="http://webimage.10x10.co.kr/playing/thing/vol010/btn_face_4.png" alt="" /></li>
					<li onclick="jsplayingthing('5','4'); return false;"><i></i><img src="http://webimage.10x10.co.kr/playing/thing/vol010/btn_face_5.png" alt="" /></li>
					<li onclick="jsplayingthing('6','4'); return false;"><i></i><img src="http://webimage.10x10.co.kr/playing/thing/vol010/btn_face_6.png" alt="" /></li>
				</ul>
				<div class="dash"></div>
			</div>
			<%' Q5 %>
			<div class="question question5" id="Q5">
				<h3><img src="http://webimage.10x10.co.kr/playing/thing/vol010/tit_question_5.png" alt="다섯번째, 무의식테스트 - 가장 먼저 보이는 단어는 무엇입니까?" /></h3>
				<div class="word">
					<ul>
						<li class="w1" onclick="jsplayingthing('1','5'); return false;"><i></i><span><img src="http://webimage.10x10.co.kr/playing/thing/vol010/btn_word_1.png" alt="슬픈" /></span></li>
						<li class="w2" onclick="jsplayingthing('2','5'); return false;"><i></i><span><img src="http://webimage.10x10.co.kr/playing/thing/vol010/btn_word_2.png" alt="즐거운" /></span></li>
						<li class="w3" onclick="jsplayingthing('3','5'); return false;"><i></i><span><img src="http://webimage.10x10.co.kr/playing/thing/vol010/btn_word_3.png" alt="귀여운" /></span></li>
						<li class="w4" onclick="jsplayingthing('4','5'); return false;"><i></i><span><img src="http://webimage.10x10.co.kr/playing/thing/vol010/btn_word_4.png" alt="심쿵한" /></span></li>
						<li class="w5" onclick="jsplayingthing('5','5'); return false;"><i></i><span><img src="http://webimage.10x10.co.kr/playing/thing/vol010/btn_word_5.png" alt="행복한" /></span></li>
						<li class="w6" onclick="jsplayingthing('6','5'); return false;"><i></i><span><img src="http://webimage.10x10.co.kr/playing/thing/vol010/btn_word_6.png" alt="지루한" /></span></li>
						<li class="w7" onclick="jsplayingthing('7','5'); return false;"><i></i><span><img src="http://webimage.10x10.co.kr/playing/thing/vol010/btn_word_7.png" alt="편안한" /></span></li>
						<li class="w8" onclick="jsplayingthing('8','5'); return false;"><i></i><span><img src="http://webimage.10x10.co.kr/playing/thing/vol010/btn_word_8.png" alt="심심한" /></span></li>
						<li class="w9" onclick="jsplayingthing('9','5'); return false;"><i></i><span><img src="http://webimage.10x10.co.kr/playing/thing/vol010/btn_word_9.png" alt="사랑스러운" /></span></li>
						<li class="w10" onclick="jsplayingthing('10','5'); return false;"><i></i><span><img src="http://webimage.10x10.co.kr/playing/thing/vol010/btn_word_10.png" alt="그리운" /></span></li>
						<li class="w11" onclick="jsplayingthing('11','5'); return false;"><i></i><span><img src="http://webimage.10x10.co.kr/playing/thing/vol010/btn_word_11.png" alt="앞이캄캄" /></span></li>
						<li class="w12" onclick="jsplayingthing('12','5'); return false;"><i></i><span><img src="http://webimage.10x10.co.kr/playing/thing/vol010/btn_word_12.png" alt="속상한" /></span></li>
						<li class="w13" onclick="jsplayingthing('13','5'); return false;"><i></i><span><img src="http://webimage.10x10.co.kr/playing/thing/vol010/btn_word_13.png" alt="재미있는" /></span></li>
					</ul>
				</div>
			</div>
		</div>
		<button type="button" class="btnSubmit" onclick="jsplayingthingadd('1'); return false;"><img src="http://webimage.10x10.co.kr/playing/thing/vol010/btn_submit.png" alt="처방받기" /></button>
		<div class="pen"></div>
		<%' 로딩중 %>
		<div class="loading">
			<div>
				<span><img src="http://webimage.10x10.co.kr/playing/thing/vol010/ico_loading.png" alt="" /></span>
				<p><img src="http://webimage.10x10.co.kr/playing/thing/vol010/txt_loading.png" alt="처방중..." /></p>
			</div>
		</div>
	</div>

	<div id="prescription" class="prescription">
		<div class="result" id="vResult" style="display:none;"></div>
		<div class="kit">
			<p><img src="http://webimage.10x10.co.kr/playing/thing/vol010/txt_kit.png" alt="마음씨 약국 씨앗 Kit로 증상을 완화하세요! 추첨을 통해 총50명에게 씨악 KIT를 드립니다. 한 ID당 1회 신청 가능합니다." /></p>
			<div style="padding:40px 0 25px;"><img src="http://webimage.10x10.co.kr/playing/thing/vol010/img_kit.jpg" alt="" /></div>
			<button type="button" class="btnKit" onclick="jsplayingthingadd('2'); return false;"><img src="http://webimage.10x10.co.kr/playing/thing/vol010/btn_kit.png" alt="씨앗 키트 신청하기" /></button>
			<p class="total">총 <%= totalresultCnt %>명이 신청했습니다</p>
		</div>
	</div>
	<div class="vol010"><img src="http://webimage.10x10.co.kr/playing/thing/vol010/txt_vol010.png" alt="THING의 사물에 대한 생각 메마른 일상에 씨앗으로 일상을 치유하세요!" /></div>
</form>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->