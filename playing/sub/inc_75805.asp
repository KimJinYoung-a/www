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
' Description : PLAYing 용돈을 부탁해
' History : 2017-01-26 유태욱 생성
'####################################################
Dim eCode , LoginUserid, vQuery, myKitgubun, vDIdx
IF application("Svr_Info") = "Dev" THEN
	eCode   =  66268
Else
	eCode   =  75805
End If

vDIdx = request("didx")
LoginUserid		= getencLoginUserid()

%>
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<style type="text/css">
.pocketMny {text-align:center;}
.pocketMny button {background-color:transparent;}

.pocketMny .topic {background-color:#9591d3;}
.pocketMny .topic .start {position:relative;/*  width:1100px; margin:0 auto; */}
.pocketMny .topic .start h2 {padding-top:125px; margin-left:-61px;}
.pocketMny .topic .start p {padding-top:40px;}
.pocketMny .topic .start .btnStart {overflow:hidden; height:99px; padding:36px 0 148px; }
.pocketMny .topic .start .btnStart a {display:block; width:100%; height:100%; animation:bounce 1s infinite;}
.pocketMny .topic .btnResult {position:absolute; top:246px; right:0; overflow:hidden; height:50px;}
.pocketMny .topic .btnResult a:hover img {margin-top:-50px;}

.pocketMny .test {position:relative; height:900px;}
.pocketMny .test .title {overflow:hidden; position:absolute; top:70px; left:50%; width:314px; height:93px; margin-left:-157px;}
.pocketMny .test .question {height:900px; background-color:#ffda2b;}
.pocketMny .test .question .ques {position:absolute; top:70px; left:50%; margin-left:-196px; }
.pocketMny .test .question .ques span {position:absolute; top:225px; left:50%; margin-left:-90px;}
.pocketMny .test .question .q03 span, .pocketMny .test .question .q04 span {top:180px; left:50%; margin-left:-125px;}
.pocketMny .test .question .q05 span {top:210px; left:50%; margin-left:-92px;}
.pocketMny .test .question2 .title span {background-color:#ffc6ca; background-position:50% -93px;}
.pocketMny .test .question2 {background-color:#ffc6ca;}
.pocketMny .test .question3 {background-color:#ddefcc;}
.pocketMny .test .question3 .title span {background-color:#ddefcc; background-position:50% -186px;}
.pocketMny .test .question4 {background-color:#cbe8fe;}
.pocketMny .test .question4 .title span {background-color:#cbe8fe; background-position:50% -279px;}
.pocketMny .test .question5 {background-color:#e7d2de;}
.pocketMny .test .question5 .title span {background-color:#e7d2de; background-position:50% 100%;}
.pocketMny .test .question p {position:relative; z-index:5;}
.pocketMny .test .question .btnGroup {height:900px; width:100%; margin:0 auto;}
.pocketMny .test .question .btnGroup button {position:relative; float:left; width:50%;}
.pocketMny .test .question .btnGroup .btnA {text-align:right; background-color:#aee8cb;}
.pocketMny .test .question .btnGroup .btnA:hover {text-align:right; background-color:#7ecfa6;}
.pocketMny .test .question .btnGroup .btnB {text-align:left; background-color:#a5d4ea;}
.pocketMny .test .question .btnGroup .btnB:hover {background-color:#77bcdc;}
.pocketMny .test .question2 .btnGroup .btnA {background-color:#edebb3;}
.pocketMny .test .question2 .btnGroup .btnA:hover {background-color:#d0bc5c;}
.pocketMny .test .question2 .btnGroup .btnB {background-color:#f2c4b5;}
.pocketMny .test .question2 .btnGroup .btnB:hover {background-color:#ec9191;}
.pocketMny .test .question3 .btnGroup .btnA {background-color:#cfd9e7;}
.pocketMny .test .question3 .btnGroup .btnA:hover {background-color:#aa9add;}
.pocketMny .test .question3 .btnGroup .btnB {background-color:#d7f490;}
.pocketMny .test .question3 .btnGroup .btnB:hover {background-color:#a7cc4c;}
.pocketMny .test .question4 .btnGroup .btnA {background-color:#fce0c8;}
.pocketMny .test .question4 .btnGroup .btnA:hover {background-color:#eec4a0;}
.pocketMny .test .question4 .btnGroup .btnB {background-color:#bed8f8;}
.pocketMny .test .question4 .btnGroup .btnB:hover {background-color:#8bb8ef;}
.pocketMny .test .question5 .btnGroup .btnA {background-color:#fff3af;}
.pocketMny .test .question5 .btnGroup .btnA:hover {background-color:#e0cc5a;}
.pocketMny .test .question5 .btnGroup .btnB {background-color:#e1e0f8;}
.pocketMny .test .question5 .btnGroup .btnB:hover {background-color:#b1aef1;}


.pocketMny .test .question .btnGroup button span {position:absolute; top:0; left:0; opacity:0; filter:alpha(opacity=0);} 
.pocketMny .test .question .btnGroup button.btnA span { top:0; right:0; opacity:0; filter:alpha(opacity=0);} 
.pocketMny .test .question .btnGroup button:hover span {opacity:1; filter:alpha(opacity=100);} 
.pocketMny .test .lyResult {position:absolute; top:0px; left:50%; z-index:15; width:2000px; height:900px; margin-left:-1000px;}
.result {position:relative; height:901px; background:#48bbc2 url(http://webimage.10x10.co.kr/playing/thing/vol007/bg_result.jpg) 50% 0 no-repeat;}
.result .grouping {position:absolute; top:0px; left:50%; margin-left:-199px;}
.result .grouping a {display:block; animation:resultDown 1s 1;}
.result .btnMore {position:absolute; top:65px; left:50%; margin-left:365px;}

.vol007 {margin-top:28px;}

/* animation */
@keyframes bounce {
	from, to{margin-top:0; animation-timing-function:ease-out;}
	50% {margin-top:5px; animation-timing-function:ease-in;}
} 

</style>
<script type="text/javascript">
$(function(){
	/* 더블클릭시 최상단으로 이동 이벤트 없애기 */
	$(document).unbind("dblclick").dblclick(function () {});

	var position = $('.pocketMny').offset(); // 위치값
	$('html,body').animate({ scrollTop : position.top }, 100); // 이동

	$("#result").hide();

	/* start test */
	$("#btnStart a").on("click", function(e){
		$("#test").slideDown();
		event.preventDefault();
		window.$('html,body').animate({scrollTop:$(this.hash).offset().top},700);
	});

	/* test */
	$("#test .question").hide();
	$("#test .lyResult").hide();
	$("#test .question:first").show();
//	$("#test .question button").on("click", function(e){
//		if ( $(this).parent(".btnGroup").parent(".question").hasClass("question5")) {
//			$("#test .question5").show();
//			$("#test .lyResult").show();
//		} else {
//			$("#test .question").hide();
//			$(this).parent(".btnGroup").parent(".question").next().show();
//		}
//	});
		$("#lyResult a").on("click", function(e){
		$("#result").show();
		event.preventDefault();
		window.$('html,body').animate({scrollTop:$(this.hash).offset().top},700);
		resultAni()
	});

	/* resutl */
	$("#result .btnMore").on("click", function(e){
	$("#test .lyResult").hide();
	$("#test .question5").hide();
	$("#test .question1").show();
	$(".result .grouping").delay(100).animate({"margin-top":"-300px","opacity":"0"},800);
	$("#result").hide();
		event.preventDefault();
		window.parent.$('html,body').animate({scrollTop:$(this.hash).offset().top},700);
	});

	/* animation */
	$(".result .grouping").css({"margin-top":"-300px","opacity":"0"});
	function resultAni() {
		$(".result .grouping").delay(100).animate({"margin-top":"0","opacity":"1"},800);
	}

});

function restart(){
	$("#resultviewbtn").hide();
	$("#test").hide();
	$("#lyResult").hide();
	$("#result").empty();
	$("#result").hide();
	$("#question2").hide();
	$("#question3").hide();
	$("#question4").hide();
	$("#question5").hide();
	$("#question1").show();
	$("#test").show();
	window.parent.$('html,body').animate({scrollTop:$("#question1").offset().top},700);
}

function jsplayingthing(num,sel){
<% If IsUserLoginOK() Then %>
	$.ajax({
		type: "GET",
		url: "/playing/sub/doEventSubscript75805.asp",
		data: "mode=add&num="+num+"&sel="+sel,
		cache: false,
		success: function(str) {
			str = str.replace("undefined","");
			res = str.split("|");
			if (res[0]=="OK") {
				if(num==1){
					$("#test .question").hide();
					$("#question2").show();
				}else if(num==2){
					$("#test .question").hide();
					$("#question3").show();
				}else if(num==3){
					$("#test .question").hide();
					$("#question4").show();
				}else if(num==4){
					$("#test .question").hide();
					$("#question5").show();
				}else if(num==5){
					$("#test .question5").show();
					$("#test .lyResult").show();
					$("#lyResult").show();
				}else{
					alert('잘못된 접속 입니다.1');
					parent.location.reload();
				}
			} else {
				errorMsg = res[1].replace(">?n", "\n");
				alert(errorMsg );
				return false;
			}
		}
		,error: function(err) {
			console.log(err.responseText);
			alert("통신중 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
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

function jsplayingthingresult(){
<% If IsUserLoginOK() Then %>
	$.ajax({
		type: "GET",
		url: "/playing/sub/doEventSubscript75805.asp",
		data: "mode=result",
		cache: false,
		success: function(str) {
			str = str.replace("undefined","");
			res = str.split("|");
			if (res[0]=="OK") {
				if (res[1]=="1") {
					$("#result").empty().html(res[2]);
					$("#result").show();
					window.parent.$('html,body').animate({scrollTop:$("#result").offset().top},700);
				}else if(res[1]=="2") {
					$("#result").empty().html(res[2]);
					$("#result").show();
					window.parent.$('html,body').animate({scrollTop:$("#result").offset().top},700);
				}else if(res[1]=="3") {
					$("#result").empty().html(res[2]);
					$("#result").show();
					window.parent.$('html,body').animate({scrollTop:$("#result").offset().top},700);
				}else if(res[1]=="4") {
					$("#result").empty().html(res[2]);
					$("#result").show();
					window.parent.$('html,body').animate({scrollTop:$("#result").offset().top},700);
				}else{
					parent.location.reload();
				}
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
	<%''THING. html 코딩 영역 : 클래스명은 thing+볼륨 예) thingVol001 / 이미지폴더는 볼륨을 따라 vol001 %>
	<!-- Vol.007 감 나와라, 뚝딱 -->
	<div class="thingVol007 pocketMny">

		<div id="topic" class="section topic">
			<div id="start" class="start">
				<h2><img src="http://webimage.10x10.co.kr/playing/thing/vol007/txt_pocket_money_v2.png" alt="나의 용돈을부탁해 " /></h2>
				<p><img src="http://webimage.10x10.co.kr/playing/thing/vol007/txt_intro.png" alt="두둑이 받은 세뱃돈 앞으로 어떻게 쓸지 고민해보셨나요? 용돈이 많아지는 시기에 금전감각 테스트를 통해 나에게 맞는 소비계획을 새롭게 시작하세요! " /></p>
				<div id="btnStart" class="btnStart"><a href="#test"><img src="http://webimage.10x10.co.kr/playing/thing/vol007/btn_start.png" alt="테스트 스타트" /></a></div>
			</div>
		</div>

		<!-- test -->
		<div id="test" class="section test">
			<!-- question -->
			<div class="question question1" id="question1" style="display:none;">
				<p class="ques">
					<img src="http://webimage.10x10.co.kr/playing/thing/vol007/txt_test_question_01.png" alt="마트에서 장볼 때 나의 모습은?" />
					<span><img src="http://webimage.10x10.co.kr/playing/thing/vol007/img_question_01.gif" alt="" /></span>
				</p>
				<div class="btnGroup">
					<button type="button" class="btnA" onclick="jsplayingthing('1','A'); return false;">
						<img src="http://webimage.10x10.co.kr/playing/thing/vol007/btn_01_a.jpg" alt="A 미리 적어둔 리스트를 토대로 물건을 고른다" />
						<span class="over"><img src="http://webimage.10x10.co.kr/playing/thing/vol007/btn_01_a_over.jpg" alt="A 미리 적어둔 리스트를 토대로 물건을 고른다" /></span>
					</button>
					<button type="button" class="btnB" onclick="jsplayingthing('1','B'); return false;">
						<img src="http://webimage.10x10.co.kr/playing/thing/vol007/btn_01_b.jpg" alt="B 내키는 대로 이것 저것 물건을 고른다" />
						<span><img src="http://webimage.10x10.co.kr/playing/thing/vol007/btn_01_b_over.jpg" alt="B 내키는 대로 이것 저것 물건을 고른다" /></span>
					</button>
				</div>
			</div>
			<div class="question question2" id="question2" style="display:none;">
				<p class="ques">
					<img src="http://webimage.10x10.co.kr/playing/thing/vol007/txt_test_question_02.png" alt="30만원의 공돈이 들어왔다 나는 어떻게 쓸까?" />
					<span><img src="http://webimage.10x10.co.kr/playing/thing/vol007/img_question_02.gif" alt="" /></span>
				</p>
				<div class="btnGroup">
					<button type="button" class="btnA" onclick="jsplayingthing('2','A'); return false;">
						<img src="http://webimage.10x10.co.kr/playing/thing/vol007/btn_02_a.jpg" alt="A 비싸서 못 샀던 물건을 고민 없이 주문한다 " />
						<span class="over"><img src="http://webimage.10x10.co.kr/playing/thing/vol007/btn_02_a_over.jpg" alt="A 비싸서 못 샀던 물건을 고민 없이 주문한다" /></span>
					</button>
					<button type="button" class="btnB" onclick="jsplayingthing('2','B'); return false;">
						<img src="http://webimage.10x10.co.kr/playing/thing/vol007/btn_02_b.jpg" alt="B 소심하게 조금씩 작게 작게 산다 " />
						<span><img src="http://webimage.10x10.co.kr/playing/thing/vol007/btn_02_b_over.jpg" alt="B 소심하게 조금씩 작게 작게 산다 " /></span>
					</button>
				</div>
			</div>
			<div class="question question3" id="question3" style="display:none;">
				<p class="ques q03">
					<img src="http://webimage.10x10.co.kr/playing/thing/vol007/txt_test_question_03.png" alt="나의 지갑속은?" />
					<span><img src="http://webimage.10x10.co.kr/playing/thing/vol007/img_question_03.gif" alt="" /></span>
				</p>
				<div class="btnGroup">
					<button type="button" class="btnA" onclick="jsplayingthing('3','A'); return false;">
						<img src="http://webimage.10x10.co.kr/playing/thing/vol007/btn_03_a.jpg" alt="A 모아둔 쿠폰들과 다양한 카드들" />
						<span class="over"><img src="http://webimage.10x10.co.kr/playing/thing/vol007/btn_03_a_over.jpg" alt="A 모아둔 쿠폰들과 다양한 카드들" /></span>
					</button>
					<button type="button" class="btnB" onclick="jsplayingthing('3','B'); return false;">
						<img src="http://webimage.10x10.co.kr/playing/thing/vol007/btn_03_b.jpg" alt="B 심플하게 카드만 2-3장" />
						<span><img src="http://webimage.10x10.co.kr/playing/thing/vol007/btn_03_b_over.jpg" alt="B 심플하게 카드만 2-3장" /></span>
					</button>
				</div>
			</div>
			<div class="question question4" id="question4" style="display:none;">
				<p class="ques q04">
					<img src="http://webimage.10x10.co.kr/playing/thing/vol007/txt_test_question_04.png" alt="평소 메모습관은?" />
					<span><img src="http://webimage.10x10.co.kr/playing/thing/vol007/img_question_04.gif" alt="" /></span>
				</p>
				<div class="btnGroup">
					<button type="button" class="btnA" onclick="jsplayingthing('4','A'); return false;">
						<img src="http://webimage.10x10.co.kr/playing/thing/vol007/btn_04_a.jpg" alt="A 중요한 메모 외에는 잘 하지 않는다" />
						<span class="over"><img src="http://webimage.10x10.co.kr/playing/thing/vol007/btn_04_a_over.jpg" alt="A 중요한 메모 외에는 잘 하지 않는다" /></span>
					</button>
					<button type="button" class="btnB" onclick="jsplayingthing('4','B'); return false;">
						<img src="http://webimage.10x10.co.kr/playing/thing/vol007/btn_04_b.jpg" alt="B 매일 다이어리에 이것저것 메모한다" />
						<span><img src="http://webimage.10x10.co.kr/playing/thing/vol007/btn_04_b_over.jpg" alt="B 매일 다이어리에 이것저것 메모한다" /></span>
					</button>
				</div>
			</div>
			<div class="question question5" id="question5" style="display:none;">
				<p class="ques q05">
					<img src="http://webimage.10x10.co.kr/playing/thing/vol007/txt_test_question_05.png" alt="평소 나의 책상모습은?" />
					<span><img src="http://webimage.10x10.co.kr/playing/thing/vol007/img_question_05.gif" alt="" /></span>
				</p>
				<div class="btnGroup">
					<button type="button" class="btnA" onclick="jsplayingthing('5','A'); return false;">
						<img src="http://webimage.10x10.co.kr/playing/thing/vol007/btn_05_a.jpg" alt="A 잘 어지르는 타입 '정리는 나중에 몰아서 " />
						<span class="over"><img src="http://webimage.10x10.co.kr/playing/thing/vol007/btn_05_a_over.jpg" alt="A 잘 어지르는 타입 '정리는 나중에 몰아서" /></span>
					</button>
					<button type="button" class="btnB" onclick="jsplayingthing('5','B'); return false;">
						<img src="http://webimage.10x10.co.kr/playing/thing/vol007/btn_05_b.jpg" alt="B 잘 정리하는 타입 '모든 것은 제자리로" />
						<span><img src="http://webimage.10x10.co.kr/playing/thing/vol007/btn_05_b_over.jpg" alt="B 잘 정리하는 타입 '모든 것은 제자리로" /></span>
					</button>
				</div>
			</div>

			<div id="lyResult" class="lyResult" style="display:none;">
				<a href="" onclick="jsplayingthingresult(); return false;"><img src="http://webimage.10x10.co.kr/playing/thing/vol007/btn_result_view.png" alt="결과보기" /></a>
			</div>
		</div>

		<% If IsUserLoginOK() Then %>
		<%'' result %>
		<div id="result" class="section result">
		</div>
		<% end if %>

		<div class="vol007"><img src="http://webimage.10x10.co.kr/playing/thing/vol007/txt_vol007.png" alt="THING의 사물에 대한 생각 나의 금전감각에 따라 알맞는 가계부 쓰자!" /></div>
	</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->