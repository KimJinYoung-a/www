<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<style type="text/css">
.howShopping {text-align:center;}
.topic {position:relative; height:930px; background:#ff8c00 url(http://webimage.10x10.co.kr/playing/thing/vol022/bg_orange.jpg) no-repeat 50% 0; }
.topic h2 {position:absolute; top:295px; left:50%; width:400px; height:195px; margin-left:-200px;}
.topic h2 span {position:absolute; display:inline-block;}
.topic h2 .t1 {top:7px; left:78px; animation:bounce .2s 1;}
.topic h2 .t2 {top:0; left:210px; animation:bounce .2s 1 .3s;}
.topic h2 .t3 {visibility:hidden; overflow: hidden; bottom:0; left:50%; width:392px; margin-left:-196px;}
.topic h2 .t3.typing{display:block; visibility:visible; animation:typing 1.2s steps(7, end);}
.topic .shoppingPt {padding:125px 0 50px;}
.topic .subcopy {padding:240px 0 90px; animation:appear .8s 1.3s}
.topic .intro {padding-top:58px; width:690px; margin:0 auto; border-top:solid 3px #ff9d26;}
.topic .intro button {margin-top:20px; animation:bounce .8s 30;}

.test {position:relative; background-color:#ffba42;}
.test h3 {padding:70px 0 35px;}
.test .question span{display:inline-block; padding:100px; background-color:#fff;}
.test .question .btnGroup {position:relative; overflow:hidden; height:101px; margin-top:-101px;}
.test .question .btnGroup button {position:absolute; bottom:-15px; left:50%; background-color:transparent; transition:all .3s;}
.test .question .btnGroup button.btnY {margin-left:-329px; }
.test .question .btnGroup button.btnN {margin-left:38px; }
.test .question .btnGroup button:hover{bottom:0;}
.test .question .progressBar {padding:44px 0 94px;}
.test .lyLoading {position:absolute; top:0; left:0; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/playing/thing/vol022/bg_light_brown.png) repeat;}
.test .lyLoading > img {padding:386px 0 8px;}

.result {position:relative; height:1010px; background-color:#ffeae7;}
.result h3 {position:relative; padding:120px 0 60px;}
.result .grouping {overflow:hidden; width:1020px; margin:0 auto; padding-bottom:220px;}
.result .grouping div {float:left;}
.result .grouping .type {padding:89px 107px 98px; border:solid 4px #fed3d3; text-align:left;}
.result .grouping .type > img {margin:0 0 34px -32px;}
.result .grouping .type h4 {margin-bottom:37px;}
.result .grouping .txt {padding:76px 71px 133px 80px; margin:29px 0 0 -29px; background:#fff;}
.result .snsShare {position:absolute; bottom:267px; left:50%; margin-left:16px;}

.result .btnMore {position:absolute; bottom:115px; left:50%; margin-left:-119px; background-color:transparent;}
@keyframes bounce{
	from,to {transform:translateY(0);}
	50% {transform:translateY(10px);}
}
@keyframes typing {
	from {width:0;}
	to {width:392px;}
}
</style>
<script type="text/javascript">
$(function(){
	var position = $('.thingVol022').offset(); // 위치값
	$('html,body').animate({scrollTop : position.top },300); // 이동

	/* test */
	$(".test").hide();
	$(".btnStart").on("click", function(e){
		$(".test").fadeIn();
		event.preventDefault();
		window.$('html,body').animate({scrollTop:$(".test").offset().top},500);
	});

	$(".test .question").hide();
	$(".test .lyLoading").hide();
	$(".result").hide();
	$(".test .question:first").show();
	$(".test .question button").on("click", function(e){
		if ( $(this).parent(".btnGroup").parent(".question").hasClass("q7")) {
			$(".test .q7").show();
			$(".test .lyLoading").show();
			$(".test").delay(2000).slideUp(1000).fadeOut();
			$(".result").delay(2000).fadeIn();
			resultAni();
		} else {
			$(".test .question").hide();
			$(this).parent(".btnGroup").parent(".question").next().show();
		}
	});

	/* 다시하기 */
	$(".result .btnMore").on("click", function(e){
	$(".test .lyLoading").hide();
	$(".test .q7").hide();
	$(".test .q1").show();
	$(".result").hide();
	event.preventDefault();
	window.parent.$('html,body').animate({scrollTop:$(".topic").offset().top},300);
	});

	/*Animation*/
	titleAnimation();
	 $(".topic .subcopy").css({"opacity":"0"});
	function titleAnimation() {
		$(".topic .subcopy").delay(1000).animate({"opacity":"1"},800);
	}
	setTimeout(function(){$(".topic h2 .t3").addClass("typing");}, 400);
	$(".result h3").css({"top":"-30px","opacity":"0"});
	$(".grouping .type").css({"opacity":"0"});
	$(".grouping .type > img").css({"opacity":"0"});
	$(".grouping .type h4").css({"opacity":"0"});
	$(".grouping .type p").css({"opacity":"0"});
	$(".grouping .txt").css({"opacity":"0"});
	$(".snsShare").css({"opacity":"0"});
	$(".btnMore").css({"opacity":"0"});
	function resultAni() {
		$(".result h3").delay(2100).animate({"top":"0","opacity":"1"},800);
		$(".grouping .type").delay(2200).animate({"opacity":"1"},200);
		$(".grouping .type > img").delay(2400).animate({"opacity":"1"},400);
		$(".grouping .type h4").delay(2600).animate({"top":"0","opacity":"1"},600);
		$(".grouping .type h4").delay(2800).animate({"opacity":"1"},800);
		$(".grouping .type p").delay(2900).animate({"opacity":"1"},800);
		$(".grouping .txt").delay(3000).animate({"opacity":"1"},700);
		$(".snsShare").delay(3200).animate({"opacity":"1"},700);
		$(".btnMore").delay(3200).animate({"opacity":"1"},700);
	}
});

function fnChoiceAnswer(objval,f){
	var answerval = $("#answerval").val();
	$("#answerval").val(answerval+objval);
	answerval = $("#answerval").val();
	//alert(answerval);
	if(f=="F")
	{
		if(answerval=="BAAAAAA" || answerval=="BAABBBB" || answerval=="BABBBAB" || answerval=="BABABBB" || answerval=="BAABBBB" || answerval=="BAAABBB" || answerval=="BAABBAB" || answerval=="BAABABB" || answerval=="BAAAABB" || answerval=="BAAABBA" || answerval=="BAAABAB" || answerval=="BAAAAAB" || answerval=="BAAAAAA")
		{
			//alert("#dog");
			$("#dog").show();
			$("#cat").hide();
			$("#bear").hide();
			$("#fox").hide();
		}
		else if(answerval=="BBBBBBB" || answerval=="BBAAAAA" || answerval=="BBBAAAA" || answerval=="BAAAABB" || answerval=="BBBBBAB" || answerval=="BBBBABB" || answerval=="BBBABBB" || answerval=="BBABBBB" || answerval=="BABBBBB" || answerval=="BABBBBA" || answerval=="BABBABB" || answerval=="BAABBBA")
		{
			//alert("#cat");
			$("#dog").hide();
			$("#cat").show();
			$("#bear").hide();
			$("#fox").hide();
		}
		else if(answerval=="AAAAABA" || answerval=="AAAABAA" || answerval=="AAAAABB" || answerval=="AAAABBA" || answerval=="AAABBAA" || answerval=="AAAABBB" || answerval=="AAABBBA" || answerval=="AAABBBB" || answerval=="AABBBBA" || answerval=="AABBBBB" || answerval=="ABBBBBA" || answerval=="ABBBBBB")
		{
			//alert("#bear");
			$("#dog").hide();
			$("#cat").hide();
			$("#bear").show();
			$("#fox").hide();
		}
		else if(answerval=="AAAAAAA" || answerval=="AAAAAAB" || answerval=="AAABAAA" || answerval=="AABAAAA" || answerval=="ABAAAAA" || answerval=="AABBAAA" || answerval=="ABBAAAA" || answerval=="AABBBAA" || answerval=="ABBBAAA" || answerval=="ABBBBAA" || answerval=="BBBBBBA")
		{
			//alert("#fox");
			$("#dog").hide();
			$("#cat").hide();
			$("#bear").hide();
			$("#fox").show();
		}
		else{
			$("#dog").show();
			$("#cat").hide();
			$("#bear").hide();
			$("#fox").hide();
		}
	}
}

function fnResetTest(){
	$("#answerval").val("");
}

</script>
<%
'// 쇼셜서비스로 글보내기 (2010.07.21; 허진원)
dim snpTitle, snpLink, snpPre, snpTag, snpTag2
snpTitle = Server.URLEncode("재미로 보는 연애 유형 test")
snpLink = Server.URLEncode("http://www.10x10.co.kr/playing/view.asp?didx=138")
snpPre = Server.URLEncode("텐바이텐 Playing")
snpTag = Server.URLEncode("텐바이텐 Playing")
snpTag2 = Server.URLEncode("#10x10")
''snpImg = Server.URLEncode(emimg)	'상단에서 생성
%>
						<div class="thingVol022 howShopping">
							<div class="section topic">
								<h2>
									<span class="t1"><img src="http://webimage.10x10.co.kr/playing/thing/vol022/tit_t1.png" alt="쇼" /></span>
									<span class="t2" ><img src="http://webimage.10x10.co.kr/playing/thing/vol022/tit_t2.png" alt="핑" /></span>
									<span class="t3"><img src="http://webimage.10x10.co.kr/playing/thing/vol022/tit_t3.png" alt="어떻게 하세요?" /></span>
								</h2>
								<p class="shoppingPt"><img src="http://webimage.10x10.co.kr/playing/thing/vol022/tit_shopping_pattern.png" alt="장바구니 탐구생활 - 쇼핑 패턴편" /></p>
								<span class="mainHt"><img src="http://webimage.10x10.co.kr/playing/thing/vol022/img_main_heart.gif" alt="" /></span>
								<p class="subcopy"><img src="http://webimage.10x10.co.kr/playing/thing/vol022/txt_subcopy.png" alt="나의 연애 스타일을 찾고 친구들과 공유해보세요!" /></p>
								<div class="intro">
									<p><img src="http://webimage.10x10.co.kr/playing/thing/vol022/txt_intro.png" alt="재미로 보는 연애 유형 TEST" /></p>
									<button class="btnStart"><img src="http://webimage.10x10.co.kr/playing/thing/vol022/btn_start.png" alt="테스트 스타트" /></button></a>
								</div>
							</div>
							<!-- test -->
							<div class="section test">
								<h3><img src="http://webimage.10x10.co.kr/playing/thing/vol022/tit_test.png" alt="재미로 보는 TEST 쇼핑 패턴 탐구생활 _ 연애 유형편" /></h3>
								<!-- question1 -->
								<div class="question q1">
									<p class="ques">
										<p><img src="http://webimage.10x10.co.kr/playing/thing/vol022/txt_num1.png" alt="Q1" /></p>
										<span><img src="http://webimage.10x10.co.kr/playing/thing/vol022/txt_q1.png" alt="미리 쇼핑목록을 정하고 쇼핑한다.충동적으로 주문하는 물건은 별로 없다." /></span>
									</p>
									<div class="btnGroup">
										<button type="button" class="btnY" onClick="fnChoiceAnswer('A','');"><img src="http://webimage.10x10.co.kr/playing/thing/vol022/txt_yes.png" alt="맞아요" /></button>
										<button type="button" class="btnN" onClick="fnChoiceAnswer('B','');"><img src="http://webimage.10x10.co.kr/playing/thing/vol022/txt_no.png" alt="아니요" /></button>
									</div>
									<div class="progressBar"><img src="http://webimage.10x10.co.kr/playing/thing/vol022/img_progressbar1.png" alt="" /></div>
								</div>
								<!-- question2 -->
								<div class="question q2">
									<p class="ques">
										<p><img src="http://webimage.10x10.co.kr/playing/thing/vol022/txt_num2.png" alt="Q2" /></p>
										<span><img src="http://webimage.10x10.co.kr/playing/thing/vol022/txt_q2.png" alt="일상이 쇼핑이다. 하루에 한번은 꼭 쇼핑몰을 방문한다." /></span>
									</p>
									<div class="btnGroup">
										<button type="button" class="btnY" onClick="fnChoiceAnswer('A','');"><img src="http://webimage.10x10.co.kr/playing/thing/vol022/txt_yes.png" alt="맞아요" /></button>
										<button type="button" class="btnN" onClick="fnChoiceAnswer('B','');"><img src="http://webimage.10x10.co.kr/playing/thing/vol022/txt_no.png" alt="아니요" /></button>
									</div>
									<div class="progressBar"><img src="http://webimage.10x10.co.kr/playing/thing/vol022/img_progressbar2.png" alt="" /></div>
								</div>
								<!-- question3 -->
								<div class="question q3">
									<p class="ques">
										<p><img src="http://webimage.10x10.co.kr/playing/thing/vol022/txt_num3.png" alt="Q3" /></p>
										<span><img src="http://webimage.10x10.co.kr/playing/thing/vol022/txt_q3.png" alt="가능한,한 쇼핑몰에서 몰아서 주문한다. All in!" /></span>
									</p>
									<div class="btnGroup">
										<button type="button" class="btnY" onClick="fnChoiceAnswer('A','');"><img src="http://webimage.10x10.co.kr/playing/thing/vol022/txt_yes.png" alt="맞아요" /></button>
										<button type="button" class="btnN" onClick="fnChoiceAnswer('B','');"><img src="http://webimage.10x10.co.kr/playing/thing/vol022/txt_no.png" alt="아니요" /></button>
									</div>
									<div class="progressBar"><img src="http://webimage.10x10.co.kr/playing/thing/vol022/img_progressbar3.png" alt="" /></div>
								</div>
								<!-- question4 -->
								<div class="question q4">
									<p class="ques">
										<p><img src="http://webimage.10x10.co.kr/playing/thing/vol022/txt_num4.png" alt="Q4" /></p>
										<span><img src="http://webimage.10x10.co.kr/playing/thing/vol022/txt_q4.png" alt="베스트셀러 상품들은 무조건 탐방! 많은 사람들이 산 상품을 주로 산다!" /></span>
									</p>
									<div class="btnGroup">
										<button type="button" class="btnY" onClick="fnChoiceAnswer('A','');"><img src="http://webimage.10x10.co.kr/playing/thing/vol022/txt_yes.png" alt="맞아요" /></button>
										<button type="button" class="btnN" onClick="fnChoiceAnswer('B','');"><img src="http://webimage.10x10.co.kr/playing/thing/vol022/txt_no.png" alt="아니요" /></button>
									</div>
									<div class="progressBar"><img src="http://webimage.10x10.co.kr/playing/thing/vol022/img_progressbar4.png" alt="" /></div>
								</div>
								<!-- question5 -->
								<div class="question q5">
									<p class="ques">
										<p><img src="http://webimage.10x10.co.kr/playing/thing/vol022/txt_num5.png" alt="Q5" /></p>
										<span><img src="http://webimage.10x10.co.kr/playing/thing/vol022/txt_q5.png" alt="사도 사도 부족하다.옷장이 꽉 차있어도 입을 옷이 없다." /></span>
									</p>
									<div class="btnGroup">
										<button type="button" class="btnY" onClick="fnChoiceAnswer('A','');"><img src="http://webimage.10x10.co.kr/playing/thing/vol022/txt_yes.png" alt="맞아요" /></button>
										<button type="button" class="btnN" onClick="fnChoiceAnswer('B','');"><img src="http://webimage.10x10.co.kr/playing/thing/vol022/txt_no.png" alt="아니요" /></button>
									</div>
									<div class="progressBar"><img src="http://webimage.10x10.co.kr/playing/thing/vol022/img_progressbar5.png" alt="" /></div>
								</div>
								<!-- question6 -->
								<div class="question q6">
									<p class="ques">
										<p><img src="http://webimage.10x10.co.kr/playing/thing/vol022/txt_num6.png" alt="Q6" /></p>
										<span><img src="http://webimage.10x10.co.kr/playing/thing/vol022/txt_q6.png" alt="한 번 찜한 물건은무슨 일이 있어도 꼭 산다!" /></span>
									</p>
									<div class="btnGroup">
										<button type="button" class="btnY" onClick="fnChoiceAnswer('A','');"><img src="http://webimage.10x10.co.kr/playing/thing/vol022/txt_yes.png" alt="맞아요" /></button>
										<button type="button" class="btnN" onClick="fnChoiceAnswer('B','');"><img src="http://webimage.10x10.co.kr/playing/thing/vol022/txt_no.png" alt="아니요" /></button>
									</div>
									<div class="progressBar"><img src="http://webimage.10x10.co.kr/playing/thing/vol022/img_progressbar6.png" alt="" /></div>
								</div>
								<!-- question7 -->
								<div class="question q7">
									<p class="ques">
										<p><img src="http://webimage.10x10.co.kr/playing/thing/vol022/txt_num7.png" alt="Q7" /></p>
										<span><img src="http://webimage.10x10.co.kr/playing/thing/vol022/txt_q7.png" alt="당장 사고 싶은 물건이라도 몇 날 며칠을 고민한다." /></span>
									</p>
									<div class="btnGroup">
										<button type="button" class="btnY" onClick="fnChoiceAnswer('A','F');fnDispShowHide();"><img src="http://webimage.10x10.co.kr/playing/thing/vol022/txt_yes.png" alt="맞아요" /></button>
										<button type="button" class="btnN" onClick="fnChoiceAnswer('B','F');fnDispShowHide();"><img src="http://webimage.10x10.co.kr/playing/thing/vol022/txt_no.png" alt="아니요" /></button>
									</div>
									<div class="progressBar"><img src="http://webimage.10x10.co.kr/playing/thing/vol022/img_progressbar7.png" alt="" /></div>
								</div>
								<!-- 팝업 로딩 -->
								<div class="lyLoading">
									<img src="http://webimage.10x10.co.kr/playing/thing/vol022/img_load_heart_v2.gif" alt="" />
									<p><img src="http://webimage.10x10.co.kr/playing/thing/vol022/txt_loading.png" alt="연애유형 분석중..." /></p>
								</div>
							</div>

							<!-- result -->
							<div class="section result">
								<h3><img src="http://webimage.10x10.co.kr/playing/thing/vol022/tit_test_result.png" alt="연애 유형 테스트 결과" /></h3>
								<!-- 유형1 (강아지) -->
								<div class="grouping result1" style="display:none" id="dog">
									<div class="type">
										<img src="http://webimage.10x10.co.kr/playing/thing/vol022/img_result1.png" alt="" />
										<h4><img src="http://webimage.10x10.co.kr/playing/thing/vol022/txt_type1.png" alt="강아지 유형" /></h4>
										<p><img src="http://webimage.10x10.co.kr/playing/thing/vol022/txt_subcopy1.png" alt="하루라도 연락하지 않으면 답답하지 않나요?" /></p>
									</div>
									<div class="txt"><img src="http://webimage.10x10.co.kr/playing/thing/vol022/txt_result1.png" alt="온종일 기다리고 잘 따르는 강아지 같은 연애 스타일! 자기감정에 솔직하고 애정 표현에 익숙한 당신, 밀고 당기기보단 감정 표현을 솔직히 하는 성향으로 내숭이 없네요. 하지만! 작은 일에 감정 기복이 큰 성향을 갖고 있으니, 이런 유형일 수록 자신의 의사를 확실하게 말하는 게 중요해요. 너무 사교적인 나머지 상대방이 질투로 인한 다툼이 있을 수 있으니, 언제나 조심하세요!" /></div>
								</div>
								<!-- 유형2 (고양이) -->
								<div class="grouping result2" style="display:none" id="cat">
									<div class="type">
										<img src="http://webimage.10x10.co.kr/playing/thing/vol022/img_result2.png" alt="" />
										<h4><img src="http://webimage.10x10.co.kr/playing/thing/vol022/txt_type2.png" alt="고양이 유형" /></h4>
										<p><img src="http://webimage.10x10.co.kr/playing/thing/vol022/txt_subcopy2.png" alt="나만의 공간과 시간이 필요하지 않으세요?" /></p>
									</div>
									<div class="txt"><img src="http://webimage.10x10.co.kr/playing/thing/vol022/txt_result2.png" alt="자유로운 생활을 추구하는 고양이 같은 연애 스타일! 혼자만의 시간을 좋아하고, 누군가에게 기대지 않아도 혼자서도 잘 해결해내는 당신, 상대방에게 기대하지도, 애정을 구걸하지도 않는 성향이네요. 하지만! 그만큼 상대를 잘 믿지 않기 때문에, 상대가 마음을 열고 다가가기 힘들어할 수도 있을 것 같아요. 상대가 마음을 열 수 있도록 조금 더 친근하게 대하는 것도 좋을 것 같습니다. " /></div>
								</div>
								<!-- 유형3 (여우)-->
								<div class="grouping result3" style="display:none" id="fox">
									<div class="type">
										<img src="http://webimage.10x10.co.kr/playing/thing/vol022/img_result3.png" alt="" />
										<h4><img src="http://webimage.10x10.co.kr/playing/thing/vol022/txt_type3.png" alt="여우 유형" /></h4>
										<p><img src="http://webimage.10x10.co.kr/playing/thing/vol022/txt_subcopy3.png" alt="나도 모르게 상대방의 반응에계산하고 있지 않나요?" /></p>
									</div>
									<div class="txt"><img src="http://webimage.10x10.co.kr/playing/thing/vol022/txt_result3.png" alt="천성적인 밀당의 고수 타입! 눈치가 빠른 스타일로, 상대방의 반응에 따라 빠르게 변화하는 연애 스타일 밀고 당기기를 일부러 하지 않아도 자연스럽게몸에 배어 있어 주변 이성들에게 인기가 좋네요. 하지만! 즉흥적인 감정이 아닌, 계산된 행동으로 상대에게 들켜, 서운하게 할 수 있을 것 같네요. 지나친 계산 대신, 가끔은 끌리는 대로 행동해보면어떨까요?" /></div>
								</div>
								<!-- 유형4 (곰)-->
								<div class="grouping result4" style="display:none" id="bear">
									<div class="type">
										<img src="http://webimage.10x10.co.kr/playing/thing/vol022/img_result4.png" alt="" />
										<h4><img src="http://webimage.10x10.co.kr/playing/thing/vol022/txt_type4.png" alt="곰 유형1" /></h4>
										<p><img src="http://webimage.10x10.co.kr/playing/thing/vol022/txt_subcopy4.png" alt="단순하다는 이야기 많이 듣지 않나요?" /></p>
									</div>
									<div class="txt"><img src="http://webimage.10x10.co.kr/playing/thing/vol022/txt_result4.png" alt="깊이 생각하는걸 별로 좋아하지 않고, 편한 걸 추구하는 친구 같은 연애 스타일!상대방의 이야기를 잘 들어주는 성향이네요.겉보기로는 소심해 보이지만 한번 마음 먹고 움직이면실행력, 적극성 최고인 스타일입니다.그래서, 가끔 꽂히는 상대가 나타나면 적극적으로 변하기도 해서 곰 유형의 사람들은 연상연하 커플이 많습니다." /></div>
								</div>
								<div class="snsShare">
									<img src="http://webimage.10x10.co.kr/playing/thing/vol022/txt_share2.png" alt="친구에게 테스트 추천하기" usemap="#shareMap"/>
									<map name="shareMap" id="shareMap">
										<area  alt="페이스북 공유" href="javascript:popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','');" shape="rect" coords="187,0,226,37" style="outline:none;" target="_self" />
									</map>
								</div>
								<input type="hidden" name="answerval" id="answerval">
								<button class="btnMore" onClick="fnResetTest();"><img src="http://webimage.10x10.co.kr/playing/thing/vol022/btn_restart.png" alt="다시테스트하기" /></button>
							</div>
						</div>
						<!-- //THING. html 코딩 영역 -->
