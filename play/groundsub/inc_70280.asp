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
' Description : PLAY 29 W
' History : 2016-04-08 이종화 생성
'####################################################
Dim eCode , userid , strSql , totcnt , pagereload
IF application("Svr_Info") = "Dev" THEN
	eCode   =  66108
Else
	eCode   =  70280
End If

	pagereload	= requestCheckVar(request("pagereload"),2)
	userid = GetEncLoginUserID()

Dim prize1 : prize1 = 0
Dim prize2 : prize2 = 0 
Dim prize3 : prize3 = 0 
Dim prize4 : prize4 = 0 
Dim prize5 : prize5 = 0 
Dim prize6 : prize6 = 0

'// 응모 여부
strSql = " select "
strSql = strSql & "	isnull(sum(case when sub_opt1 = 1 then 1 else 0 end),0) as prize1 , "
strSql = strSql & "	isnull(sum(case when sub_opt1 = 2 then 1 else 0 end),0) as prize2 , "
strSql = strSql & "	isnull(sum(case when sub_opt1 = 3 then 1 else 0 end),0) as prize3 , "
strSql = strSql & "	isnull(sum(case when sub_opt1 = 4 then 1 else 0 end),0) as prize4 , "
strSql = strSql & "	isnull(sum(case when sub_opt1 = 5 then 1 else 0 end),0) as prize5 , "
strSql = strSql & "	isnull(sum(case when sub_opt1 = 6 then 1 else 0 end),0) as prize6  "
strSql = strSql & "	from db_event.dbo.tbl_event_subscript "
strSql = strSql & "	where evt_code = '"& eCode &"' "
rsget.Open strSql,dbget,1
IF Not rsget.Eof Then
	prize1	= rsget("prize1")
	prize2	= rsget("prize2")
	prize3	= rsget("prize3")
	prize4	= rsget("prize4")
	prize5	= rsget("prize5")
	prize6	= rsget("prize6")
End IF
rsget.close()

If IsUserLoginOK Then 
	'// 이벤트 진행 여부
	strSql = "select "
	strSql = strSql & " count(*) "
	strSql = strSql & " from db_event.dbo.tbl_event_subscript"
	strSql = strSql & "	where userid = '"& userid &"' and evt_code = '"& eCode &"' " 
	rsget.Open strSql,dbget,1
	IF Not rsget.Eof Then
		totcnt = rsget(0)
	End IF
	rsget.close()
End If
%>
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/section.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<style type="text/css">
.groundWrap {width:100%; background:#dddfe9;}
.groundCont {position:relative; padding-bottom:0; background-color:#fff;}
.groundCont .grArea {width:100%;}
.groundCont .tagView {width:1100px; margin-top:30px; padding:28px 20px 60px;}
img {vertical-align:top;}
.timeCont {position:relative; width:1140px; margin:0 auto;}
.intro {text-align:center; background:url(http://webimage.10x10.co.kr/play/ground/20160418/bg_stripe.png) repeat 0 0;}
.intro .timeCont {width:100%; height:781px; padding-top:137px; background-image:url(http://webimage.10x10.co.kr/play/ground/20160418/bg_shadow.png),url(http://webimage.10x10.co.kr/play/ground/20160418/bg_slash.png); background-position:50% 0,50% 0; background-repeat:no-repeat, no-repeat;}
.intro .title {overflow:hidden; position:relative; width:536px; height:484px; margin:0 auto; background:url(http://webimage.10x10.co.kr/play/ground/20160418/bg_box.png) no-repeat 50% 0;}
.intro .title p {position:absolute; left:50%; top:85px; margin-left:-160px;}
.intro h2 {position:absolute; left:50%; top:165px; margin-left:-214px;}
.intro h2 span {display:block; width:428px; height:111px; margin:0 auto; background:url(http://webimage.10x10.co.kr/play/ground/20160418/tit_ask_clock.png) no-repeat 0 0; text-indent:-999em;}
.intro h2 span.t01 {left:0; top:0;}
.intro h2 span.t02 {right:0; bottom:0; background-position:0 100%;}
.intro .purpose {padding-top:56px;}
.section {height:800px; background-position:50% 0; background-repeat:no-repeat;}
.section .timeCont {height:800px; text-align:left;}
.section .timeCont a.goItem {display:block; position:absolute; left:0; top:0; z-index:30; width:100%; height:800px; text-indent:-9999px; background:transparent;}
.section01 {background-image:url(http://webimage.10x10.co.kr/play/ground/20160418/bg_scene_01.jpg); background-color:#f9e670;}
.section02 {background-image:url(http://webimage.10x10.co.kr/play/ground/20160418/bg_scene_02.jpg); background-color:#d5ee58;}
.section03 {background-image:url(http://webimage.10x10.co.kr/play/ground/20160418/bg_scene_03.jpg); background-color:#e1baf1;}
.section04 {background-image:url(http://webimage.10x10.co.kr/play/ground/20160418/bg_scene_04.jpg); background-color:#f9d079;}
.section05 {background-image:url(http://webimage.10x10.co.kr/play/ground/20160418/bg_scene_05.jpg); background-color:#fecbde;}
.section06 {background-image:url(http://webimage.10x10.co.kr/play/ground/20160418/bg_scene_06.jpg); background-color:#77b7ef;}
.section .story {position:absolute;}
.section01 .story {left:680px; top:475px;}
.section02 .story {left:70px; top:325px;}
.section03 .story {left:750px; top:412px;}
.section04 .story {left:70px; top:385px;}
.section05 .story {left:70px; top:392px;}
.section06 .story {left:70px; top:455px;}
.section .story .desc {position:absolute; left:0; top:0;}
.section .story .solution {position:absolute; left:0; top:30px;}
.section .deco {position:absolute;}
.section01 .d01 {left:170px; top:520px;}
.section01 .d02 {left:455px; top:648px;}
.section02 .d01 {right:-150px; top:281px;}
.section03 .d01 {right:218px; top:245px;}
.section04 .d01 {right:0; top:429px;}
.section05 .d01 {right:-103px; top:144px;}
.section06 .d01 {right:-146px; top:430px;}
.section06 .d02 {right:1px; bottom:-70px;}

/* vote */
.myClock {text-align:center; padding:75px 0 125px; background-image:url(http://webimage.10x10.co.kr/play/ground/20160418/bg_vote_01.png),url(http://webimage.10x10.co.kr/play/ground/20160418/bg_vote_02.png); background-repeat:no-repeat, no-repeat; background-position:0 0,100% 100%; background-color:#37437e;}
.myClock ul {overflow:hidden; width:1098px; margin:0 auto; padding:56px 0 75px;}
.myClock li {float:left; width:145px; padding:0 19px; font-weight:bold;}
.myClock li .selectItem {overflow:hidden; cursor:pointer;}
.myClock li .selectItem span {display:block; overflow:hidden; width:100%; padding-bottom:15px;}
.myClock li .selectItem.current span img {margin-left:-145px;}
.myClock li .count span {display:inline-block; padding-left:20px; margin-top:10px; color:#fff; font-size:15px; line-height:16px; font-family:verdana; background:url(http://webimage.10x10.co.kr/play/ground/20160418/ico_heart.png) no-repeat 0 50%;}
.myClock .btnVote {vertical-align:top;}
</style>
<script type="text/javascript">
<!--
$(function(){
	<% if pagereload<>"" then %>
		setTimeout("pagedown()",500);
	<% end if %>
});

function pagedown(){
	window.$('html,body').animate({scrollTop:$("#vote").offset().top}, 0);
}

$(function(){
	/* animation */
	$(".intro h2").css({"margin-top":"370px"});
	function intro () {
		$('.intro .title p').delay(300).effect("pulsate", {times:2},400 );
		$('.intro h2').delay(800).animate({"margin-top":"0"}, 800);
	}
	intro ()
	$(".section .story .desc").css({"margin-top":"5px", "opacity":"0"});
	$(".section .story .solution").css({"margin-top":"10px", "opacity":"0"});
	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 1450 ) {
			$(".section01 .story .desc").animate({"margin-top":"0", "opacity":"1"},500);
			$(".section01 .story .solution").delay(400).animate({"margin-top":"0", "opacity":"1"},500);
		}
		if (scrollTop > 2250 ) {
			$(".section02 .story .desc").animate({"margin-top":"0", "opacity":"1"},500);
			$(".section02 .story .solution").delay(400).animate({"margin-top":"0", "opacity":"1"},500);
		}
		if (scrollTop > 3050 ) {
			$(".section03 .story .desc").animate({"margin-top":"0", "opacity":"1"},500);
			$(".section03 .story .solution").delay(400).animate({"margin-top":"0", "opacity":"1"},500);
		}
		if (scrollTop > 3850 ) {
			$(".section04 .story .desc").animate({"margin-top":"0", "opacity":"1"},500);
			$(".section04 .story .solution").delay(400).animate({"margin-top":"0", "opacity":"1"},500);
		}
		if (scrollTop > 4650 ) {
			$(".section05 .story .desc").animate({"margin-top":"0", "opacity":"1"},500);
			$(".section05 .story .solution").delay(400).animate({"margin-top":"0", "opacity":"1"},500);
		}
		if (scrollTop > 5450 ) {
			$(".section06 .story .desc").animate({"margin-top":"0", "opacity":"1"},500);
			$(".section06 .story .solution").delay(400).animate({"margin-top":"0", "opacity":"1"},500);
		}
	});
	/* select clock */
	$(".myClock li .selectItem").click(function() {
		$(".myClock li .selectItem").removeClass("current");
		$(this).addClass("current");
		var j = $(".myClock li .selectItem").index(this) + 1;
		$("#sub_opt1").val(j);
	});
});

function vote_play(){
	var frm = document.frmvote;
	<% if Not(IsUserLoginOK) then %>
		jsChklogin('<%=IsUserLoginOK%>');
		return false;
	<% end if %>

	<% If not(left(now(),10)>="2016-04-18" and left(now(),10)<"2016-04-25" ) Then %>
		alert("이벤트 응모 기간이 아닙니다.");
		return;
	<% else %>
		<% if totcnt > 4 then %>
			alert("한 개의 아이디당 5회까지 응모가 가능 합니다.");
			return;
		<% else %>
			if(!frm.sub_opt1.value){
				alert("시계를 선택 해주세요");
				return false;
			}

			frm.action = "/play/groundsub/doEventSubscript70280.asp";
			frm.target="frmproc";
			frm.submit();
			return;
		<% end if %>
	<% end if %>
}
//-->
</script>
<div class="groundCont">
	<div class="grArea">
		<div class="playGr20160418 askClock">
			<div class="intro">
				<div class="timeCont">
					<div class="title">
						<p><img src="http://webimage.10x10.co.kr/play/ground/20160418/txt_know.png" alt="시계는 답을 알고 있다!"></p>
						<h2>
							<span class="t01">시계에게</span>
							<span class="t02">물으시게</span>
						</h2>
					</div>
					<p class="purpose"><img src="http://webimage.10x10.co.kr/play/ground/20160418/txt_purpose.png" alt="매일 우리는 일상 속에서 시계와 함께 합니다. 우리가 항상 만나던 시계가 일상의 이야기에 답해준다면 어떨까요? 시계의 기능과 모양에 따라 일상을 이야기하는‘시계에게 물으시계’ 를 통해 하루를 새로운 시각으로 바라보세요!"></p>
				</div>
			</div>
			<div class="section section01">
				<div class="timeCont">
					<div class="deco d01"><img src="http://webimage.10x10.co.kr/play/ground/20160418/img_deco_01_01.gif" alt=" "></div>
					<div class="deco d02"><img src="http://webimage.10x10.co.kr/play/ground/20160418/img_deco_01_02.gif" alt=" "></div>
					<div class="story">
						<p class="desc"><img src="http://webimage.10x10.co.kr/play/ground/20160418/txt_desc_01.png" alt="책상을 엎지 말고, 모래시계를 엎자! "></p>
						<p class="solution"><span><img src="http://webimage.10x10.co.kr/play/ground/20160418/txt_solution_01.png" alt="잠시만쉬시계"></span></p>
					</div>
					<a href="/shopping/category_prd.asp?itemid=1272175" class="goItem">상품 보러가기</a>
				</div>
			</div>
			<div class="section section02">
				<div class="timeCont">
					<div class="deco d01"><img src="http://webimage.10x10.co.kr/play/ground/20160418/img_deco_02_01.gif" alt=" "></div>
					<div class="story">
						<p class="desc"><img src="http://webimage.10x10.co.kr/play/ground/20160418/txt_desc_02.png" alt="이 시간 이대로"></p>
						<p class="solution"><span><img src="http://webimage.10x10.co.kr/play/ground/20160418/txt_solution_02.png" alt="타임! 멈추시계"></span></p>
					</div>
					<a href="/shopping/category_prd.asp?itemid=1441711" class="goItem">상품 보러가기</a>
				</div>
			</div>
			<div class="section section03">
				<div class="timeCont">
					<div class="deco d01"><img src="http://webimage.10x10.co.kr/play/ground/20160418/img_deco_03_01.gif" alt=" "></div>
					<div class="story">
						<p class="desc"><img src="http://webimage.10x10.co.kr/play/ground/20160418/txt_desc_03.png" alt="열 번은 더 찍었다..."></p>
						<p class="solution"><span><img src="http://webimage.10x10.co.kr/play/ground/20160418/txt_solution_03.png" alt="이쯤되면 넘어오시계"></span></p>
					</div>
					<a href="/shopping/category_prd.asp?itemid=255243" class="goItem">상품 보러가기</a>
				</div>
			</div>
			<div class="section section04">
				<div class="timeCont">
					<div class="deco d01"><img src="http://webimage.10x10.co.kr/play/ground/20160418/img_deco_04_01.gif" alt=" "></div>
					<div class="story">
						<p class="desc"><img src="http://webimage.10x10.co.kr/play/ground/20160418/txt_desc_04.png" alt="돌처럼 단단한 마음으로"></p>
						<p class="solution"><span><img src="http://webimage.10x10.co.kr/play/ground/20160418/txt_solution_04.png" alt="단단해지시계"></span></p>
					</div>
					<a href="/shopping/category_prd.asp?itemid=1050471" class="goItem">상품 보러가기</a>
				</div>
			</div>
			<div class="section section05">
				<div class="timeCont">
					<div class="deco d01"><img src="http://webimage.10x10.co.kr/play/ground/20160418/img_deco_05_01.gif" alt=" "></div>
					<div class="story">
						<p class="desc"><img src="http://webimage.10x10.co.kr/play/ground/20160418/txt_desc_05.png" alt="대신 울어줄테니,"></p>
						<p class="solution"><span><img src="http://webimage.10x10.co.kr/play/ground/20160418/txt_solution_05.png" alt="그만우시계"></span></p>
					</div>
					<a href="/shopping/category_prd.asp?itemid=747525" class="goItem">상품 보러가기</a>
				</div>
			</div>
			<div class="section section06">
				<div class="timeCont">
					<div class="deco d01"><img src="http://webimage.10x10.co.kr/play/ground/20160418/img_deco_06_01.gif" alt=" "></div>
					<div class="deco d02"><img src="http://webimage.10x10.co.kr/play/ground/20160418/img_wing.png" alt=" "></div>
					<div class="story">
						<p class="desc"><img src="http://webimage.10x10.co.kr/play/ground/20160418/txt_desc_06.png" alt="한 단계 한 단계, 훨훨 "></p>
						<p class="solution"><span><img src="http://webimage.10x10.co.kr/play/ground/20160418/txt_solution_06.png" alt="날아오르시계"></span></p>
					</div>
					<a href="/shopping/category_prd.asp?itemid=1019450" class="goItem">상품 보러가기</a>
				</div>
			</div>
			<div class="myClock" id="vote">
				<div class="timeCont">
					<h3><img src="http://webimage.10x10.co.kr/play/ground/20160418/tit_vote_clock_v2.png" alt="나에게 맞는 시계를 투표해주세요!"></h3>
					<ul>
						<li>
							<div class="selectItem">
								<span><img src="http://webimage.10x10.co.kr/play/ground/20160418/img_clock_01.jpg" alt=""></span>
								<p><img src="http://webimage.10x10.co.kr/play/ground/20160418/txt_clock_01.png" alt="잠시만쉬시계"></p>
							</div>
							<p class="count"><span><%=prize1%></span></p>
						</li>
						<li>
							<div class="selectItem">
								<span><img src="http://webimage.10x10.co.kr/play/ground/20160418/img_clock_02.jpg" alt=""></span>
								<p><img src="http://webimage.10x10.co.kr/play/ground/20160418/txt_clock_02.png" alt="날아오르시계"></p>
							</div>
							<p class="count"><span><%=prize2%></span></p>
						</li>
						<li>
							<div class="selectItem">
								<span><img src="http://webimage.10x10.co.kr/play/ground/20160418/img_clock_03.jpg" alt=""></span>
								<p><img src="http://webimage.10x10.co.kr/play/ground/20160418/txt_clock_03.png" alt="그만우시계"></p>
							</div>
							<p class="count"><span><%=prize3%></span></p>
						</li>
						<li>
							<div class="selectItem">
								<span><img src="http://webimage.10x10.co.kr/play/ground/20160418/img_clock_04.jpg" alt=""></span>
								<p><img src="http://webimage.10x10.co.kr/play/ground/20160418/txt_clock_04.png" alt="단단해지시계"></p>
							</div>
							<p class="count"><span><%=prize4%></span></p>
						</li>
						<li>
							<div class="selectItem">
								<span><img src="http://webimage.10x10.co.kr/play/ground/20160418/img_clock_05.jpg" alt=""></span>
								<p><img src="http://webimage.10x10.co.kr/play/ground/20160418/txt_clock_05.png" alt="넘어오시계"></p>
							</div>
							<p class="count"><span><%=prize5%></span></p>
						</li>
						<li>
							<div class="selectItem">
								<span><img src="http://webimage.10x10.co.kr/play/ground/20160418/img_clock_06.jpg" alt=""></span>
								<p><img src="http://webimage.10x10.co.kr/play/ground/20160418/txt_clock_06.png" alt="타임멈추시계"></p>
							</div>
							<p class="count"><span><%=prize6%></span></p>
						</li>
					</ul>
					<button type="button" class="btnVote" onclick="vote_play();"><img src="http://webimage.10x10.co.kr/play/ground/20160418/btn_vote.png" alt="투표하기"></button>
				</div>
			</div>
		</div>
<form name="frmvote" method="post">
<input type="hidden" name="mode" value="add"/>
<input type="hidden" name="sub_opt1" id="sub_opt1" value=""/>
<input type="hidden" name="pagereload" value="ON"/>
</form>
<iframe id="frmproc" name="frmproc" frameborder="0" width=0 height=0></iframe>
<!-- #include virtual="/lib/db/dbclose.asp" -->