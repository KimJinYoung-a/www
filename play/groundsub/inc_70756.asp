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
' Description : PLAY 30-3 W 유형선택
' History : 2016-05-14 원승현 생성
'####################################################
Dim eCode , pagereload
IF application("Svr_Info") = "Dev" THEN
	eCode   =  66130
Else
	eCode   =  70756
End If


Dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
	snpTitle = Server.URLEncode("[텐바이텐] 페스티벌에서 나의 유형 Test & Tip")
	snpLink = Server.URLEncode("http://www.10x10.co.kr/play/playGround.asp?gidx=30&gcidx=124")
	snpPre = Server.URLEncode("텐바이텐")
	snpTag = Server.URLEncode("텐바이텐 " & Replace("#30 서른 번째 이야기 FESTIVAL"," ",""))
	snpTag2 = Server.URLEncode("#텐바이텐 #10x10 #뷰티풀민트라이프")
	snpImg = Server.URLEncode("http://webimage.10x10.co.kr/play/playmainimg/201605/playmainimg20160516105657.png")

%>
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/section.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<style type="text/css">
.groundWrap {width:100%; background-color:#f3d774;}
.groundCont {position:relative; padding-bottom:0; background-color:#fff;}
.groundCont .grArea {width:100%;}
.groundCont .tagView {width:1100px; margin-top:30px; padding:28px 20px 60px;}

img {vertical-align:top;}

.myType button {background-color:transparent;}

.myType .topic {height:1266px; background:#f3e9c6 url(http://webimage.10x10.co.kr/play/ground/20160516/bg_pattern_yellow.jpg) repeat-x 0 0;}
.myType .topic .inner {position:relative; height:100%; background:url(http://webimage.10x10.co.kr/play/ground/20160516/bg_hill_yellow.jpg) no-repeat 50% 0;}
.myType .topic h3 {overflow:hidden; position:absolute; top:200px; left:50%; z-index:5; width:654px; height:214px; margin-left:-327px;}
.myType .topic h3 span {position:absolute;}
.myType .topic h3 .letter1 {top:0; left:50%; margin-left:-186px;}
.myType .topic h3 .letter2 {bottom:0; left:0;}
.myType .topic p {position:absolute; top:722px; left:50%; margin-left:-260px;}
.myType .topic .balloon {position:absolute; top:198px; left:50%; margin-left:326px;}
.myType .topic .cloud {position:absolute; top:175px; left:50%; margin-left:-530px;}
.myType .topic .bird {position:absolute; top:163px; left:50%; margin-left:-527px; animation-duration:1s; animation-delay:1s;}
.btnStart {position:absolute; bottom:90px; left:50%; margin-left:-75px;}

.test {background:#c0d66d url(http://webimage.10x10.co.kr/play/ground/20160516/bg_hill_green.png) repeat 50% 0;}
.test .question {position:relative; height:928px; background:url(http://webimage.10x10.co.kr/play/ground/20160516/bg_line_dashed.png) no-repeat 50% 0; text-align:center;}
.test .question .btngroup {position:absolute; top:324px; left:50%; width:836px; margin-left:-418px;}
.test .question .btngroup button {float:left; margin:0 89px;}

.test .resultWrap {position:relative; height:744px; background:#30b9c5 url(http://webimage.10x10.co.kr/play/ground/20160516/bg_blue.png) repeat 50% 0;}
.test .resultWrap .result {position:relative; width:1085px; height:575px; margin:0 auto; padding-top:169px; background:url(http://webimage.10x10.co.kr/play/ground/20160516/bg_line_dashed.png) no-repeat 50% 0;}
.test .resultWrap .result p {margin-left:10px;}
.test .resultWrap .result .item {position:absolute; bottom:100px; right:0;}
.test .resultWrap .result .item ul {overflow:hidden; position:absolute; top:20px; left:120px;}
.test .resultWrap .result .item ul li {float:left; width:100px; height:100px; margin-right:5px;}
.test .resultWrap .result .item ul li a {display:block; width:100%; height:100%;}
.test .resultWrap .result .item ul li a img {width:100%; height:100%;}
.test .resultWrap .result .item .btnPlus {position:absolute; bottom:45px; right:-21px;}
.test .resultWrap .result2 .item ul {left:125px;}
.test .resultWrap .result3 .item ul {left:105px;}
.test .resultWrap .result3 .item ul li:last-child {margin-left:10px;}
.test .resultWrap .result4 .item ul {left:105px;}
.test .resultWrap .result4 .item ul li:last-child {margin-left:10px;}
.test .resultWrap .snsShare {position:absolute; top:532px; left:50%; margin-left:-525px;}

.ranking {overflow:hidden; position:relative; height:650px; padding-top:80px; background:#077b53 url(http://webimage.10x10.co.kr/play/ground/20160516/bg_green.png) repeat 50% 0;}
.ranking h4 {text-align:center;}
.ranking ul {width:526px; margin:60px auto 0;}
.ranking ul li {position:relative; padding-left:55px; margin-top:20px; height:86px; background:url(http://webimage.10x10.co.kr/play/ground/20160516/bg_ranking.png) no-repeat 0 50%; color:#0b583e;}
.ranking ul li:first-child {margin-top:0;}
.ranking ul li div {position:relative; min-width:210px; height:86px; background:url(http://webimage.10x10.co.kr/play/ground/20160516/bg_rate_full.png) no-repeat 100% 50%;}
.ranking ul li div:before {content:''; position:absolute; left:-55px; top:0; z-index:30px;width:86px; height:86px; background-position:0 0;  background-repeat:no-repeat;}
.ranking ul li.no1 div:before {background-image:url(http://webimage.10x10.co.kr/play/ground/20160516/txt_raking_01.png);}
.ranking ul li.no2 div:before {background-image:url(http://webimage.10x10.co.kr/play/ground/20160516/txt_raking_02.png);}
.ranking ul li.no3 div:before {background-image:url(http://webimage.10x10.co.kr/play/ground/20160516/txt_raking_03.png);}
.ranking ul li.no4 div:before {background-image:url(http://webimage.10x10.co.kr/play/ground/20160516/txt_raking_04.png);}
.ranking ul li span {position:absolute; left:40px; top:50%; z-index:30; margin-top:-10px;}
.ranking ul li b {position:absolute; top:32px; right:20px; font-family:'Verdana'; font-size:23px; line-height:24px; text-align:right;}
.ranking .star {position:absolute; top:26px; left:50%; margin-left:-819px;}

.updown {animation-name:updown; animation-iteration-count:infinite; animation-duration:1.5s;}
@keyframes updown {
	from, to{margin-top:0; animation-timing-function:linear;}
	50% {margin-top:5px; animation-timing-function:linear;}
}
.shake {animation-name:shake; animation-iteration-count:infinite; animation-duration:5s;}
@keyframes shake {
	from, to{ margin-left:-530px; animation-timing-function:ease-out;}
	50% {margin-left:-550px; animation-timing-function:ease-in;}
}
.bounce {animation-name:bounce; animation-iteration-count:infinite; animation-duration:1s;}
@keyframes bounce {
	from, to{margin-bottom:0; animation-timing-function:linear;}
	50% {margin-bottom:7px; animation-timing-function:linear;}
}
@keyframes twinkle {
	0% {opacity:0.5;}
	100% {opacity:1;}
}
.twinkle {animation-name:twinkle; animation-iteration-count:infinite; animation-duration:3s; animation-fill-mode:both;}
</style>
<script type="text/javascript">
$(function(){
	/* 더블클릭시 최상단으로 이동 이벤트 없애기 */
	$(document).unbind("dblclick").dblclick(function () {});

	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 100 ) {
			titleAnimation();
		}
	});

	/* title animation */
	$("#titleAnimation .letter1").css({"margin-top":"-30px", "opacity":"0"});
	$("#titleAnimation .letter2").css({"margin-bottom":"-5px", "opacity":"0"});
	function titleAnimation() {
		$("#titleAnimation .letter1").delay(700).animate({"margin-top":"0", "opacity":"1"},800);
		$("#titleAnimation .letter2").delay(100).animate({"margin-bottom":"0", "opacity":"1",},500);
	}

	/* skip to test */
	$("#btnStart").click(function(event){
		event.preventDefault();
		window.parent.$('html,body').animate({scrollTop:$(this.hash).offset().top},700);
	});

	/* test */
	$("#test .question").hide();
	$("#test .question:first").show();
	$("#test .question button").on("click", function(e){
		<% if Not(IsUserLoginOK) then %>
			jsChklogin('<%=IsUserLoginOK%>');
			return false;
		<% end if %>
		<% if not(left(now(), 10)>="2016-05-14" And left(now(), 10) < "2016-07-01") then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return false;
		<% end if %>

		$("#test .question").hide();
		$(this).parent(".btngroup").parent(".question").next().show();
	});
});

function fnAnswerChk(qNo, Ans)
{
	if (qNo=="1")
	{
		$("#qAnswer").val(Ans);
	}
	else if (qNo=="4")
	{
		$("#qAnswer").val($("#qAnswer").val().substr(0, qNo-1));
		$("#qAnswer").val($("#qAnswer").val()+Ans);
		if (!$("#qAnswer").val().length==qNo)
		{
			alert("순서대로 TEST에 응모해주세요.");
			return false;
		}
		$.ajax({
			type:"GET",
			url:"/play/groundsub/doEventSubscript70756.asp",
	        data: $("#frmSbS").serialize(),
			dataType: "text",
			async:false,
			cache:true,
			success : function(Data, textStatus, jqXHR){
				if (jqXHR.readyState == 4) {
					if (jqXHR.status == 200) {
						if(Data!="") {
							var str;
							for(var i in Data)
							{
								 if(Data.hasOwnProperty(i))
								{
									str += Data[i];
								}
							}
							str = str.replace("undefined","");
							res = str.split("|");
							if (res[0]=="OK")
							{
								$('#result'+res[1]).show();
								showRankingData();
								window.parent.$('html,body').animate({scrollTop:$("#resultpov").offset().top},300);
							}
							else
							{
								errorMsg = res[1].replace(">?n", "\n");
								alert(errorMsg );
								parent.location.reload();
								return false;
							}
						} else {
							alert("잘못된 접근 입니다.");
							parent.location.reload();
							return false;
						}
					}
				}
			},
			error:function(jqXHR, textStatus, errorThrown){
				alert("잘못된 접근 입니다.");
				var str;
				for(var i in jqXHR)
				{
					 if(jqXHR.hasOwnProperty(i))
					{
						str += jqXHR[i];
					}
				}
				alert(str);
				parent.location.reload();
				return false;
			}
		});

	}
	else
	{
		$("#qAnswer").val($("#qAnswer").val().substr(0, qNo-1));
		$("#qAnswer").val($("#qAnswer").val()+Ans);
		if (!$("#qAnswer").val().length==qNo)
		{
			alert("순서대로 TEST에 응모해주세요.");
			return false;
		}
	}
}

function showRankingData()
{
	$.ajax({
		type:"GET",
		url:"/play/groundsub/doEventSubscript70756.asp?mode=ranking",
		dataType: "text",
		async:false,
		cache:true,
		success : function(Data, textStatus, jqXHR){
			if (jqXHR.readyState == 4) {
				if (jqXHR.status == 200) {
					if(Data!="") {
						var str;
						for(var i in Data)
						{
							 if(Data.hasOwnProperty(i))
							{
								str += Data[i];
							}
						}
						str = str.replace("undefined","");
						res = str.split("|");
						if (res[0]=="OK")
						{
							$('#rankingData').empty().html(res[1]);
							$('#rankingData').show();
						}
						else
						{
							errorMsg = res[1].replace(">?n", "\n");
							alert(errorMsg );
							parent.location.reload();
							return false;
						}
					} else {
						alert("잘못된 접근 입니다.");
						parent.location.reload();
						return false;
					}
				}
			}
		},
		error:function(jqXHR, textStatus, errorThrown){
			alert("잘못된 접근 입니다.");
			var str;
			for(var i in jqXHR)
			{
				 if(jqXHR.hasOwnProperty(i))
				{
					str += jqXHR[i];
				}
			}
			alert(str);
			parent.location.reload();
			return false;
		}
	});

}
//-->
</script>
<div class="groundCont">
	<div class="grArea">
		<div class="playGr20160516 myType">
			<div class="topic">
				<div class="inner">
					<h3 id="titleAnimation">
						<span class="letter1"><img src="http://webimage.10x10.co.kr/play/ground/20160516/tit_my_type_01.png" alt="나의 유형을 알아봐형" /></span>
						<span class="letter2"><img src="http://webimage.10x10.co.kr/play/ground/20160516/tit_my_type_02.png" alt="My type" /></span>
					</h3>
					<p><img src="http://webimage.10x10.co.kr/play/ground/20160516/txt_my_type.png" alt="페스티벌에 어떤 옷을 입을지, 무엇을 가져가야 할지 항상 고민하셨던 분들!! 당신은 페스티벌에서 어떤 유형인가요? 텐바이텐이 준비한 테스트를 통해 여러분의 유형을 알아보세요! 유형별 맞춤 아이템과 팁도 준비했으니 페스티벌을 알차게 보내보아요!" /></p>
					<a href="#test" id="btnStart" class="btnStart bounce"><img src="http://webimage.10x10.co.kr/play/ground/20160516/btn_start.png" alt="테스트 시작하기" /></a>
					<div class="balloon updown"><img src="http://webimage.10x10.co.kr/play/ground/20160516/img_balloon.png" alt="" /></div>
					<div class="cloud shake"><img src="http://webimage.10x10.co.kr/play/ground/20160516/img_cloud.png" alt="" /></div>
					<div class="bird updown"><img src="http://webimage.10x10.co.kr/play/ground/20160516/img_bird.png" alt="" /></div>
				</div>
			</div>
			<div id="resultpov"></div>

			<div id="test" class="test">
				<%' question %>
				<div class="question question1">
					<p><img src="http://webimage.10x10.co.kr/play/ground/20160516/txt_test_question_01.png" alt="즐겨 듣는 음악은?" /></p>
					<div class="btngroup">
						<button type="button" onclick="fnAnswerChk('1','A');return false;"><img src="http://webimage.10x10.co.kr/play/ground/20160516/btn_choice_01_a.png" alt="신나는 댄스 음악" /></button>
						<button type="button" onclick="fnAnswerChk('1','B');return false;"><img src="http://webimage.10x10.co.kr/play/ground/20160516/btn_choice_01_b.png" alt="잔잔한 어쿠스틱 음악" /></button>
					</div>
				</div>
				<div class="question question2">
					<p><img src="http://webimage.10x10.co.kr/play/ground/20160516/txt_test_question_02.png" alt="주로 올리는 포스팅은?" /></p>
					<div class="btngroup">
						<button type="button" onclick="fnAnswerChk('2','A');return false;"><img src="http://webimage.10x10.co.kr/play/ground/20160516/btn_choice_02_a.png" alt="#먹스타그램" /></button>
						<button type="button" onclick="fnAnswerChk('2','B');return false;"><img src="http://webimage.10x10.co.kr/play/ground/20160516/btn_choice_02_b.png" alt="#셀스타그램" /></button>
					</div>
				</div>
				<div class="question question3">
					<p><img src="http://webimage.10x10.co.kr/play/ground/20160516/txt_test_question_03.png" alt="기분이 좋지 앟을 때는?" /></p>
					<div class="btngroup">
						<button type="button" onclick="fnAnswerChk('3','A');return false;"><img src="http://webimage.10x10.co.kr/play/ground/20160516/btn_choice_03_a.png" alt="음악에 맞춰 맘껏 뛰기" /></button>
						<button type="button" onclick="fnAnswerChk('3','B');return false;"><img src="http://webimage.10x10.co.kr/play/ground/20160516/btn_choice_03_b.png" alt="먹고 또 먹고" /></button>
					</div>
				</div>
				<div class="question question4">
					<p><img src="http://webimage.10x10.co.kr/play/ground/20160516/txt_test_question_04.png" alt="시간 날때 누구와?" /></p>
					<div class="btngroup">
						<button type="button" onclick="fnAnswerChk('4','A');return false;"><img src="http://webimage.10x10.co.kr/play/ground/20160516/btn_choice_04_a.png" alt="혼자가 좋아" /></button>
						<button type="button" onclick="fnAnswerChk('4','B');return false;"><img src="http://webimage.10x10.co.kr/play/ground/20160516/btn_choice_04_b.png" alt="친구와 수다떨기" /></button>
					</div>
				</div>

				<%' result %>
				<div class="question resultWrap">
					<%'  뛰뛰방방형 %>
					<div class="result result1"  id="result1" style="display:none;">
						<p><img src="http://webimage.10x10.co.kr/play/ground/20160516/txt_test_result_01.png" alt="뛰고 뛰고, 방방 또 뛰자! 당신은 뛰뛰방방형 페스티벌에서는 역시 뛰어야 제맛! 두 손 가볍게 필요한 소품만 담을 수 있는 크로스백은 필수! 화려한 패턴의 힙색도 느낌 있게 연출 가능! 오래 뛰어다닐 당신을 위해 편안한 샌들도 꼭 챙기자. 단, 스타일까지 포기하면 안 돼!" /></p>

						<div class="item">
							<p><img src="http://webimage.10x10.co.kr/play/ground/20160516/img_item_01.png" alt="이런건 어때?" /></p>
							<ul>
								<li><a href="/shopping/category_prd.asp?itemid=1045290&amp;pEtr=70756" target="_blank" title="새창"><img src="http://webimage.10x10.co.kr/play/ground/20160516/img_item_white.png" alt="poster side bag denim" /></a></li>
								<li><a href="/shopping/category_prd.asp?itemid=1075746&amp;pEtr=70756" target="_blank" title="새창"><img src="http://webimage.10x10.co.kr/play/ground/20160516/img_item_white.png" alt="weekade let&apos;s waist bag" /></a></li>
								<li><a href="/shopping/category_prd.asp?itemid=1272166&amp;pEtr=70756" target="_blank" title="새창"><img src="http://webimage.10x10.co.kr/play/ground/20160516/img_item_white.png" alt="츄바스코 게레로" /></a></li>
							</ul>
							<div class="btnPlus bounce">
								<a href="/event/eventmain.asp?eventid=70756#groupBar1" target="_blank" title="새창"><img src="http://webimage.10x10.co.kr/play/ground/20160516/btn_plus.png" alt="뛰뛰방방형 상품 더보기" /></a>
							</div>
						</div>
					</div>

					<%' 유유자적형 %>
					<div class="result result2" id="result2" style="display:none;">
						<p><img src="http://webimage.10x10.co.kr/play/ground/20160516/txt_test_result_02.png" alt="이곳에 내 한 몸 뉘련다 당신은 유유자적형 잔디밭에 누워 하늘을 보며 노래를 들을 때 피크닉 매트와 포근한 담요까지 있다면 금상첨화 햇빛과 주위사람에게 방해받고 싶지 않다면 귀여운 안대 착용을 추천! 사르르 잠에 드는 순간, 쌓였던 피로가 싹 가실걸?" /></p>

						<div class="item">
							<p><img src="http://webimage.10x10.co.kr/play/ground/20160516/img_item_02.png" alt="이런건 어때?" /></p>
							<ul>
								<li><a href="/shopping/category_prd.asp?itemid=1118175&amp;pEtr=70756" target="_blank" title="새창"><img src="http://webimage.10x10.co.kr/play/ground/20160516/img_item_white.png" alt="피크닉 타월" /></a></li>
								<li><a href="/shopping/category_prd.asp?itemid=1088289&amp;pEtr=70756" target="_blank" title="새창"><img src="http://webimage.10x10.co.kr/play/ground/20160516/img_item_white.png" alt="오아시스피크닉매트" /></a></li>
								<li><a href="/shopping/category_prd.asp?itemid=682897&amp;pEtr=70756" target="_blank" title="새창"><img src="http://webimage.10x10.co.kr/play/ground/20160516/img_item_white.png" alt="New Eye Mask 수면안대" /></a></li>
							</ul>
							<div class="btnPlus bounce">
								<a href="/event/eventmain.asp?eventid=70756#groupBar2" target="_blank" title="새창"><img src="http://webimage.10x10.co.kr/play/ground/20160516/btn_plus.png" alt="유유자적형 상품 더보기" /></a>
							</div>
						</div>
					</div>

					<%' 간지나는형 %>
					<div class="result result3" id="result3" style="display:none;">
						<p><img src="http://webimage.10x10.co.kr/play/ground/20160516/txt_test_result_03.png" alt="이 구역에 간지는 바로 나야! 당신은 간지나는형 1일 1셀카 하는 당신을 위해 셀카 렌즈를 추천! 차별화된 인증샷에는 데코 용품들이 필요하겠지? 함께 가는 친구들과 트윈룩으로 맞춰 입고 화관, 꽃팔찌, 선글라스 등으로 한껏 멋을 낸다면 남들도 부러워 할껄?" /></p>

						<div class="item">
							<p><img src="http://webimage.10x10.co.kr/play/ground/20160516/img_item_03.png" alt="이런건 어때?" /></p>
							<ul>
								<li><a href="/shopping/category_prd.asp?itemid=1246002&amp;pEtr=70756" target="_blank" title="새창"<img src="http://webimage.10x10.co.kr/play/ground/20160516/img_item_white.png" alt="셀카렌즈" /></a></li>
								<li><a href="/shopping/category_prd.asp?itemid=1354437&amp;pEtr=70756" target="_blank" title="새창"><img src="http://webimage.10x10.co.kr/play/ground/20160516/img_item_white.png" alt="써커스보이밴드 스트라이프 티" /></a></li>
								<li><a href="/shopping/category_prd.asp?itemid=1196210&amp;pEtr=70756" target="_blank" title="새창"><img src="http://webimage.10x10.co.kr/play/ground/20160516/img_item_white.png" alt="꽃팔찌" /></a></li>
							</ul>
							<div class="btnPlus bounce">
								<a href="/event/eventmain.asp?eventid=70756#groupBar3" target="_blank" title="새창"><img src="http://webimage.10x10.co.kr/play/ground/20160516/btn_plus.png" alt="간지나는형 상품 더보기" /></a>
							</div>
						</div>
					</div>

					<%' 쳐묵쳐묵형 %>
					<div class="result result4" id="result4" style="display:none;">
						<p><img src="http://webimage.10x10.co.kr/play/ground/20160516/txt_test_result_04.png" alt="먹을 건 배신 하지 않는다 당신은 쳐묵쳐묵형 어딜 가나 먹을 것을 잔뜩 챙겨 다니는 야무진 당신 꼭 한 번 만나고 싶다! 완전 우리 스타일! 음료를 차갑게 유지시켜줄 쿨러와 보냉백은 필수지! 밤이 되면 더 잘 먹을 수 있게 랜턴도 준비하자 우리의 밤은 쳐묵쳐묵으로 빛나리!" /></p>

						<div class="item">
							<p><img src="http://webimage.10x10.co.kr/play/ground/20160516/img_item_04.png" alt="이런건 어때?" /></p>
							<ul>
								<li><a href="/shopping/category_prd.asp?itemid=1320364&amp;pEtr=70756" target="_blank" title="새창"><img src="http://webimage.10x10.co.kr/play/ground/20160516/img_item_white.png" alt="쿨헬퍼" /></a></li>
								<li><a href="/shopping/category_prd.asp?itemid=1296243&amp;pEtr=70756" target="_blank" title="새창"><img src="http://webimage.10x10.co.kr/play/ground/20160516/img_item_white.png" alt="토트백" /></a></li>
								<li><a href="/shopping/category_prd.asp?itemid=1284635&amp;pEtr=70756" target="_blank" title="새창"><img src="http://webimage.10x10.co.kr/play/ground/20160516/img_item_white.png" alt="랜턴" /></a></li>
							</ul>
							<div class="btnPlus bounce">
								<a href="/event/eventmain.asp?eventid=70756#groupBar4" target="_blank" title="새창"><img src="http://webimage.10x10.co.kr/play/ground/20160516/btn_plus.png" alt="쳐묵쳐묵형 상품 더보기" /></a>
							</div>
						</div>
					</div>

					<!-- sns -->
					<div class="snsShare">
						<a href="" onClick="popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','','<%=snpImg%>'); return false;"><img src="http://webimage.10x10.co.kr/play/ground/20160516/btn_sns_facebook.png" alt="나의 유형을 알아봐형 My type 페이스북으로 공유하기" /></a>
					</div>
				</div>
			</div>
			<div class="ranking" id="rankingData" style="display:none;">
			</div>
		</div>
	</div>
</div>

<form method="post" name="frmSbS" id="frmSbS">
	<input type="hidden" name="qAnswer" id="qAnswer">
	<input type="hidden" name="mode" value="add">
</form>
<!-- #include virtual="/lib/db/dbclose.asp" -->