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
' Description : 플레이띵 Vol.16 슬기로운 생활
' History : 2017-06-02 원승현
'####################################################
Dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  66334
Else
	eCode   =  78257
End If

dim userid, commentcount, i, vDIdx, vQuery
	userid = GetEncLoginUserID()

commentcount = getcommentexistscount(userid, eCode, "", "", "", "Y")
vDIdx = request("didx")

dim cEComment ,blnFull, cdl, com_egCode, bidx, blnBlogURL, strBlogURL
dim iCTotCnt, arrCList,intCLoop, pagereload
dim iCPageSize, iCCurrpage, isMyComm
dim iCStartPage, iCEndPage, iCTotalPage, iCx,iCPerCnt
	iCCurrpage	= requestCheckVar(Request("iCC"),10)	'현재 페이지 번호
	cdl			= requestCheckVar(Request("cdl"),3)
	blnFull		= requestCheckVar(Request("blnF"),10)
	blnBlogURL	= requestCheckVar(Request("blnB"),10)
	isMyComm	= requestCheckVar(request("isMC"),1)
	pagereload	= requestCheckVar(request("pagereload"),2)

IF blnFull = "" THEN blnFull = True
IF blnBlogURL = "" THEN blnBlogURL = False

IF iCCurrpage = "" THEN
	iCCurrpage = 1
END IF
IF iCTotCnt = "" THEN
	iCTotCnt = -1
END IF

iCPerCnt = 10		'보여지는 페이지 간격
'한 페이지의 보여지는 열의 수
if blnFull then
	iCPageSize = 6		'풀단이면 15개			'/수기이벤트 둘다 강제 12고정
else
	iCPageSize = 6		'메뉴가 있으면 10개			'/수기이벤트 둘다 강제 12고정
end if

'데이터 가져오기
set cEComment = new ClsEvtComment
	cEComment.FECode 		= eCode
	cEComment.FComGroupCode	= com_egCode
	cEComment.FEBidx    	= bidx
	cEComment.FCPage 		= iCCurrpage	'현재페이지
	cEComment.FPSize 		= iCPageSize	'페이지 사이즈
	if isMyComm="Y" then cEComment.FUserID = userid
	cEComment.FTotCnt 		= iCTotCnt  '전체 레코드 수
	
	arrCList = cEComment.fnGetComment		'리스트 가져오기
	iCTotCnt = cEComment.FTotCnt '리스트 총 갯수
set cEComment = nothing

iCTotalPage 	=  Int(iCTotCnt/iCPageSize)	'전체 페이지 수
IF (iCTotCnt MOD iCPageSize) > 0 THEN	iCTotalPage = iCTotalPage + 1

Dim q1val, q2val, q3val, q4val, q5val, q6val
Dim qtotalval, qUserTotalScore, qusercomment
Dim testchk, tmpTotalVal, pagingURL, tmpPagingURL

testchk = False
'// 로그인 했을경우 응모데이터가 있으면 가져온다.
If IsUserLoginOK() Then
	vQuery = "SELECT sub_opt1, sub_opt2, sub_opt3 FROM [db_event].[dbo].[tbl_event_subscript] WHERE userid = '" & userid & "' And evt_code='"&eCode&"' "
	rsget.Open vQuery,dbget,1
	If Not(rsget.bof Or rsget.eof) Then
		testchk = True
		qtotalval = rsget("sub_opt1")
		qUserTotalScore = rsget("sub_opt2")
		qusercomment = rsget("sub_opt3")
		tmpTotalVal = Split(qtotalval,"|")
		q1val = tmpTotalVal(0)
		q2val = tmpTotalVal(1)
		q3val = tmpTotalVal(2)
		q4val = tmpTotalVal(3)
		q5val = tmpTotalVal(4)
		q6val = qusercomment
	End If
	rsget.close
End If

pagingURL = Request.ServerVariables("PATH_INFO") &"?"& Request.ServerVariables("QUERY_STRING")

If InStr(pagingURL, "#")>0 Then
	tmpPagingURL = Split(pagingURL, "#")
	pagingURL = tmpPagingURL(0)
End If

%>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<style type="text/css">
.thingVol016 {text-align:center;}
.thingVol016 .inner {position:relative; width:1140px; margin:0 auto;}
.thingVol016 button {background:transparent;}

.intro {height:1380px; background:#f9e4d3 url(http://webimage.10x10.co.kr/playing/thing/vol016/bg_line.png) 0 0 repeat-x;}
.intro .inner {padding-top:180px; background:url(http://webimage.10x10.co.kr/playing/thing/vol016/bg_flower.png) 50% 265px no-repeat;}
.intro .inner h2 {padding-bottom:55px;}
.intro .inner h2 span {display:block; padding-bottom:40px;}
.intro .btnGoTest {display:block; width:327px; height:84px; margin:0 auto; background:url(http://webimage.10x10.co.kr/playing/thing/vol016/btn_go_test.png) 0 0 no-repeat; text-indent:-999em;}
.viewResult .intro .btnGoTest {background-image:url(http://webimage.10x10.co.kr/playing/thing/vol016/btn_result.png);}
.test {position:relative; padding-bottom:95px; text-align:center; background:#2d2946;}
.test .deco {position:absolute; left:50%; z-index:40; background-position:0 0; background-repeat:no-repeat;}
.test .deco.d1 {top:162px; margin-left:-962px; width:392px; height:444px; background-image:url(http://webimage.10x10.co.kr/playing/thing/vol016/bg_deco1.png);}
.test .deco.d2 {top:970px; margin-left:600px; width:459px; height:478px; background-image:url(http://webimage.10x10.co.kr/playing/thing/vol016/bg_deco2.png);}
.test .deco.d3 {top:1476px; margin-left:-1090px; width:410px; height:994px; background-image:url(http://webimage.10x10.co.kr/playing/thing/vol016/bg_deco3.png);}
.test .deco.d4 {top:2125px; margin-left:570px; width:485px; height:681px; background-image:url(http://webimage.10x10.co.kr/playing/thing/vol016/bg_deco4.png);}
.test .deco.d5 {top:2672px; margin-left:-1115px; width:545px; height:324px; background-image:url(http://webimage.10x10.co.kr/playing/thing/vol016/bg_deco5.png);}
.test .inner {position:relative; top:-350px; margin-bottom:-350px; padding:95px 0 0; background:#fdfdfd;}
.test .info {position:relative; width:990px; margin:0 auto;}
.test .info div {position:absolute; left:330px; top:72px; color:#000;}
.test .info div:after {content:' '; display:block; clear:both;}
.test .info p {float:left; padding-right:25px; font:bold 17px/19px batang;}
.test .info p span {color:#666;}
.test .info .score {position:relative;}
.test .info .score span {position:absolute; left:15px; top:-32px; z-index:30;}
.test .question {padding:85px 0 90px;}
.test .question .answer:after {content:' '; display:block; clear:both;}
.test .question .answer li {display:inline-block; *display:inline; position:relative; cursor:pointer;}
.test .question .answer li i {display:none; position:absolute; left:50%; top:233px; z-index:40; width:40px; height:34px; margin-left:-65px; background:url(http://webimage.10x10.co.kr/playing/thing/vol016/ico_check.png) 0 0 no-repeat; vertical-align:top;}
.test .question .answer li.current i {display:block; animation:bounce1 .4s;}
.test .question .txt {display:inline-block; *display:inline; position:relative; padding-bottom:45px;}
.test .question .txt em {display:none; position:absolute; left:-50px; top:50px; width:131px; height:99px;}
.test .question.correct .txt em {display:block; background:url(http://webimage.10x10.co.kr/playing/thing/vol016/img_correct.png) 0 0 no-repeat;}
.test .question.wrong .txt em {display:block; background:url(http://webimage.10x10.co.kr/playing/thing/vol016/img_wrong.png) 0 0 no-repeat;}
.test .question .desc {display:none; width:610px; margin:50px auto 0; padding:23px 0; color:#f65050; font-size:14px; font-weight:bold; line-height:24px; background:#efefef; border-radius:12px;}
.test .btnSubmit {margin-top:45px; animation:bounce2 1s 100;}
.test .btnGoEvt {display:none; margin-top:45px; animation:bounce2 1s 100;}

.test .question1 {background:#fcfcfc;}
.test .question2 {background:#f7f7f7;}
.test .question2 .answer li i {margin-left:-53px}
.test .question2 .answer li.q2a3 i {margin-left:-65px}
.test .question3 {background:#fcfcfc;}
.test .question3 .answer  li {padding:0 55px;}
.test .question3 .answer li i {top:-16px; margin-left:-39px;}
.test .question4 {background:#f8f8f8;}
.test .question4 .answer li i {top:210px; margin-left:-55px;}
.test .question4 .answer li.q4a3 i {margin-left:-70px;}
.test .question5 {background:#fbfbfb;}
.test .question5 .answer li i {top:210px; margin-left:-52px;}
.test .question6 {background:#f8f8f8;}
.test .question6 .writeCont {position:relative; width:367px; height:35px; margin:0 auto 15px; background:url(http://webimage.10x10.co.kr/playing/thing/vol016/bg_textarea.png) 0 0 no-repeat;}
.test .question6 .writeCont:after {content:''; display:inline-block; position:absolute; left:18px; top:8px; z-index:20; width:1px; height:19px; background:url(http://webimage.10x10.co.kr/playing/thing/vol016/img_cursor.gif) 0 0 no-repeat;}
.test .question6 .focusOn.writeCont:after {display:none;}
.test .question6 .writeCont input {border:0; width:90%; height:35px; font-size:17px; font-weight:bold; background:#f7f7f7;}

.viewResult .test .inner:after {content:''; display:inline-block; position:absolute; right:175px; bottom:215px; width:191px; height:251px; background:url(http://webimage.10x10.co.kr/playing/thing/vol016/txt_good.png) 0 0 no-repeat;}
.viewResult .test .question1 .answer li.q1a1 i,
.viewResult .test .question2 .answer li.q2a4 i,
.viewResult .test .question3 .answer li.q3a4 i,
.viewResult .test .question4 .answer li.q4a4 i,
.viewResult .test .question5 .answer li.q5a3 i {display:block; background-image:url(http://webimage.10x10.co.kr/playing/thing/vol016/ico_check2.png);}
.viewResult .test .question .desc {display:block;}
.viewResult .test .btnSubmit {display:none;}
.viewResult .test .btnGoEvt {display:block;}

.test .question3.correct .txt em {left:40px;}
.test .question5.correct .txt em {left:-30px;}
.test .question6.correct .txt em {left:-10px; background:url(http://webimage.10x10.co.kr/playing/thing/vol016/img_correct2.png) 0 0 no-repeat;}

.test .loading {display:none; position:fixed; left:0; top:0; z-index:100; width:100%; height:100%; text-align:center; background:url(http://webimage.10x10.co.kr/playing/thing/vol016/bg_mask.png) 0 0 repeat;}
.test .loading div {position:absolute; left:0; top:50%; width:100%; height:106px; margin-top:-53px;}
.test .loading span {display:inline-block;}
.test.loadOn .loading {display:block;}
.test.loadOn .loading span {animation:movePen 1.5s 3;}

.answerList {padding:88px 0 80px; background:#8eddda;}
.answerList ul {overflow:hidden; width:1140px; margin:0 auto; padding:55px 0 70px;}
.answerList li {overflow:hidden; float:left; width:336px; margin:15px; padding:4px; font-size:11px;font-weight:bold; text-align:left; border:3px solid #19908b; background:#fff; border-radius:18px;}
.answerList li > div {position:relative; height:94px; padding:20px 18px 0; border:1px solid #705fbd; border-radius:14px;}
.answerList li .writer {color:#504098; line-height:18px;}
.answerList li .writer i {display:inline-block; width:12px; height:18px; margin-right:7px; background:url(http://webimage.10x10.co.kr/playing/thing/vol016/ico_mobile.png) 0 0 no-repeat; vertical-align:middle; text-indent:-999em;}
.answerList li p {padding:10px 0; color:#666; font-size:14px; white-space:nowrap;}
.answerList li .num {color:#19908b;}
.answerList .pageMove,
.answerList .paging a.first,
.answerList .paging a.end {display:none;}
.answerList .paging a {width:44px; height:34px; margin:0 5px; border:0; background:transparent;}
.answerList .paging a span {width:44px; height:34px; font-size:14px; line-height:34px; color:#7a7a7a; padding:0;}
.answerList .paging a.arrow span {background:url(http://webimage.10x10.co.kr/playing/thing/vol016/btn_pagination.png) 0 0 no-repeat;}
.answerList .paging a.next span {background-position:100% 0;}
.answerList .paging a.current span {background-color:#504098; border-radius:5px; color:#fff; font-weight:normal;}
.answerList .paging a.current:hover {background-color:transparent;}
.volume {background-color:#19908b;}
@keyframes bounce1 {
	from,to {transform:translateY(0);}
	50% {transform:translateY(5px);}
}
@keyframes bounce2 {
	from, to {transform:translateY(0); animation-timing-function:ease-out;}
	50% {transform:translateY(10px); animation-timing-function:ease-in;}
}
@keyframes movePen {
	from,to {transform:translateX(0);}
	50% {transform:translateX(10px);}
}
</style>
<script type="text/javascript">
$(function(){
	<% if pagereload = "ON" then %>
		window.$('html,body').animate({scrollTop:$("#SecAnswerList").offset().top}, 0);
//		setTimeout("pagedown()",100);
	<% end if %>

	$(".btnGoTest").click(function(event){
		event.preventDefault();
		window.parent.$('html,body').animate({scrollTop:$(this.hash).offset().top},800);
	});

	$(".question li").click(function(){
		$(this).siblings("li").removeClass("current");
		$(this).addClass("current");
	});

	$(".viewResult .question li").click(function(){
		$(this).removeClass("current");
	});

	$(".btnSubmit").click(function(event){
		$(".test").addClass("loadOn");
	});
	$(".writeCont input").click(function(){
		$(".writeCont").addClass("focusOn");
	});

	<% if testchk then %>
		$("#q1a"+<%=q1val%>).addClass("current")
		$("#q2a"+<%=q2val%>).addClass("current")
		$("#q3a"+<%=q3val%>).addClass("current")
		$("#q4a"+<%=q4val%>).addClass("current")
		$("#q5a"+<%=q5val%>).addClass("current")
	<% end if %>
});

function gowiseLifeTest()
{
	<% If IsUserLoginOK() Then %>
		$("#q6val").val($("#q6text").val());

		if ($("#q1val").val()=="")
		{
			alert("시험지를 모두 다 풀어야 채점(응모)이 됩니다.");
			return false;
		}
		if ($("#q2val").val()=="")
		{
			alert("시험지를 모두 다 풀어야 채점(응모)이 됩니다.");
			return false;
		}
		if ($("#q3val").val()=="")
		{
			alert("시험지를 모두 다 풀어야 채점(응모)이 됩니다.");
			return false;
		}
		if ($("#q4val").val()=="")
		{
			alert("시험지를 모두 다 풀어야 채점(응모)이 됩니다.");
			return false;
		}
		if ($("#q5val").val()=="")
		{
			alert("시험지를 모두 다 풀어야 채점(응모)이 됩니다.");
			return false;
		}
		if ($("#q6val").val()=="")
		{
			alert("시험지를 모두 다 풀어야 채점(응모)이 됩니다.");
			return false;
		}

		$(".loading").show();
		setTimeout("wiseTestAjax();",1000);

	<% else %>
		if(confirm("로그인을 하셔야 참여할 수 있습니다.")){
			top.location.href="/login/loginpage.asp?vType=G";
			return false;
		}
	<% end if %>
}

function jsGoComPage(iP){
	document.frmwiseLife.iCC.value = iP;
	document.frmwiseLife.iCTot.value = "<%=iCTotCnt%>";
	document.frmwiseLife.action="<%=pagingURL%>";
	document.frmwiseLife.submit();
}

function wAnswerVal(q, a)
{
	$("#"+q).val(a);
}

function wiseTestAjax()
{
	$.ajax({
		type:"GET",
		url:"/playing/sub/doEventSubscript78257.asp",
		data: $("#frmwiseLife").serialize(),
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
								document.location.href=res[1];
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
			//var str;
			//for(var i in jqXHR)
			//{
			//	 if(jqXHR.hasOwnProperty(i))
			//	{
			//		str += jqXHR[i];
			//	}
			//}
			//alert(str);
			//document.location.reload();
			return false;
		}
	});
}
</script>
</head>
<%' Vol.016 슬기로운 생활 / 채점 후 viewResult 클래스 추가해주세요 %>
<div class="thingVol016 wiseLife <% If testchk Then %>viewResult<% End If %>">
	<div class="section intro">
		<div class="inner">
			<h2>
				<span class="tit1"><img src="http://webimage.10x10.co.kr/playing/thing/vol016/tit_environnement.png" alt="환경의 날 맞이" /></span>
				<span class="tit2"><img src="http://webimage.10x10.co.kr/playing/thing/vol016/tit_wise.png" alt="슬기로운 생활" /></span>
			</h2>
			<p><img src="http://webimage.10x10.co.kr/playing/thing/vol016/txt_intro.png" alt="안녕하세요, 여러분 6월5일 오늘은 세계 환경의 날입니다. 평소에 환경을 얼마나 아끼고 슬기로운 생활을 했는지 칭찬해주기 위해 플레잉에서 슬기로운 생활 시험을 준비했습니다. 시험에서 점수가 높은 고객들 중 추첨을 통해 20명에게 슬기로운 생활 노트를 드립니다." /></p>
			<div  style="padding:90px 0 35px;"><img src="http://webimage.10x10.co.kr/playing/thing/vol016/img_gift.jpg" alt="시험 점수가 높은 고객들 중 20분께 슬기로운 생활 노트를 드립니다. 응모기간 : 2017. 6.5 ~ 6.18" /></div>
			<% If isUserLoginOK Then %>
				<a href="#testStart" class="btnGoTest">시험보기</a>
			<% Else %>
				<a href="" onclick="if(confirm('로그인을 하셔야 참여할 수 있습니다.')){ top.location.href='/login/loginpage.asp?vType=G';return false;}" class="btnGoTest">시험보기</a>
			<% End If %>
			<p class="tPad20"><img src="http://webimage.10x10.co.kr/playing/thing/vol016/txt_tip.png" alt="본 시험은 1회만 볼 수 있습니다." /></p>
		</div>
	</div>
	<%' 문제 풀기 %>
	<form name="frmwiseLife" id="frmwiseLife" method="post" style="margin:0px;">
		<input type="hidden" name="eventid" value="<%=eCode%>">
		<input type="hidden" name="com_egC" value="<%=com_egCode%>">
		<input type="hidden" name="bidx" value="<%=bidx%>">
		<input type="hidden" name="iCC" value="<%=iCCurrpage%>">
		<input type="hidden" name="iCTot" value="">
		<input type="hidden" name="mode" value="add">
		<input type="hidden" name="spoint">
		<input type="hidden" name="isMC" value="<%=isMyComm%>">
		<input type="hidden" name="pagereload" value="ON">
		<input type="hidden" name="gubunval">
		<input type="hidden" name="q1val" id="q1val">
		<input type="hidden" name="q2val" id="q2val">
		<input type="hidden" name="q3val" id="q3val">
		<input type="hidden" name="q4val" id="q4val">
		<input type="hidden" name="q5val" id="q5val">
		<input type="hidden" name="q6val" id="q6val">
	</form>
	<div id="test" class="section test">
		<div id="testStart" class="inner">
			<div class="info">
				<h3><img src="http://webimage.10x10.co.kr/playing/thing/vol016/tit_test.png" alt="2017년도 1학기 전교생 슬기로운 생활" /></h3>
				<div>
					<p><span>텐텐</span> 초등학교</p>
					<p><span>플레잉</span> 반</p>
					<p><span>1010</span> 번</p>
					<p>이름: <span><%=printUserId(userid,2,"*")%></span></p>
					<% If testchk Then %>
						<p class="score">점수:
							<span>
								<img src="http://webimage.10x10.co.kr/playing/thing/vol016/txt_score_<%=qUserTotalScore%>.png" alt="<%=qUserTotalScore%>점" />
							</span>
						</p>
					<% End If %>
				</div>
			</div>
			<%' for dev msg: 채점하기 버튼 클릭후 정답:correct 오답:wrong 클래스 붙여주세요 %>
			<%' 1학년 %>
			<div id="question1" class="question question1 <%If testchk Then %><% If q1val="1" Then %>correct<%Else%>wrong<% End If %><% End If %>">
				<p class="txt"><em></em><img src="http://webimage.10x10.co.kr/playing/thing/vol016/txt_question1.png" alt="1. 마트에서 장 볼 때, 환경을 위해 어디에 물건을 담아야 할까요?" /></p>
				<ul class="answer">
					<li id="q1a1" class="q1a1" onclick="wAnswerVal('q1val', '1');return false;"><i></i><img src="http://webimage.10x10.co.kr/playing/thing/vol016/txt_answer1_1.png" alt="장바구니" /></li>
					<li id="q1a2" class="q1a2" onclick="wAnswerVal('q1val', '2');return false;"><i></i><img src="http://webimage.10x10.co.kr/playing/thing/vol016/txt_answer1_2.png" alt="비닐봉투" /></li>
				</ul>
				<p class="desc">무심결에 사용하는 비닐이 생활 쓰레기의 17% 이상을 차지하고 있다고 합니다.<br />비닐 대신 장바구니를 이용하는 것만으로도 환경을 보호 할 수 있어요!</p>
			</div>
			<%' 2학년 %>
			<div id="question2" class="question question2 <%If testchk Then %><% If q2val="4" Then %>correct<%Else%>wrong<% End If %><% End If %>">
				<p class="txt"><em></em><img src="http://webimage.10x10.co.kr/playing/thing/vol016/txt_question2.png" alt="2. 뜨거운 여름, 실내에서 에어컨을 켜뒀습니다. 환경을 위해 우리가 닫아야 할 것은 무엇일까요?" /></p>
				<ul class="answer">
					<li id="q2a1" class="q2a1" onclick="wAnswerVal('q2val', '1');return false;"><i></i><img src="http://webimage.10x10.co.kr/playing/thing/vol016/txt_answer2_1.png" alt="지퍼" /></li>
					<li id="q2a2" class="q2a2" onclick="wAnswerVal('q2val', '2');return false;"><i></i><img src="http://webimage.10x10.co.kr/playing/thing/vol016/txt_answer2_2.png" alt="마음" /></li>
					<li id="q2a3" class="q2a3" onclick="wAnswerVal('q2val', '3');return false;"><i></i><img src="http://webimage.10x10.co.kr/playing/thing/vol016/txt_answer2_3.png" alt="병뚜껑" /></li>
					<li id="q2a4" class="q2a4" onclick="wAnswerVal('q2val', '4');return false;"><i></i><img src="http://webimage.10x10.co.kr/playing/thing/vol016/txt_answer2_4.png" alt="창문" /></li>
				</ul>
				<p class="desc">에어컨을 킬 땐 창문을 닫는 것만으로도 연료를 줄일 수 있고,<br />전기료도 절약이 되요.작은 습관이 돈도 아끼고 환경도 아낄 수 있어요!</p>
			</div>
			<%' 3학년 %>
			<div id="question3" class="question question3 <%If testchk Then %><% If q3val="4" Then %>correct<%Else%>wrong<% End If %><% End If %>">
				<p class="txt"><em></em><img src="http://webimage.10x10.co.kr/playing/thing/vol016/txt_question3.png" alt="3. 다음 중 올바른 슬기로운 생활은?" /></p>
				<ul class="answer">
					<li id="q3a1" class="q3a1" onclick="wAnswerVal('q3val', '1');return false;"><i></i><img src="http://webimage.10x10.co.kr/playing/thing/vol016/txt_answer3_1.png" alt="철수:에어컨 빵빵하게 켜놓고 이불 덮는 게 최고야!" /></li>
					<li id="q3a2" class="q3a2" onclick="wAnswerVal('q3val', '2');return false;"><i></i><img src="http://webimage.10x10.co.kr/playing/thing/vol016/txt_answer3_2.png" alt="영희:라면은 일회용 나무 젓가락으로 먹어야 맛있지. 라면 먹고 갈래?" /></li>
					<li id="q3a3" class="q3a3" onclick="wAnswerVal('q3val', '3');return false;"><i></i><img src="http://webimage.10x10.co.kr/playing/thing/vol016/txt_answer3_3.png" alt="찬희:더 시켜, 더시켜! 모자란 것보다 남는 게 나아!" /></li>
					<li id="q3a4" class="q3a4" onclick="wAnswerVal('q3val', '4');return false;"><i></i><img src="http://webimage.10x10.co.kr/playing/thing/vol016/txt_answer3_4.png" alt="기호:분리수거 할 때 씻어서 분리수거 해야 해" /></li>
				</ul>
				<p class="desc">여름철 실내온도는 26-28℃ 로 적정온도 유지하는 것만으로도<br />온실 가스를 줄일 수 있어요. 평소 쓰레기만 10% 줄여도 연간 18kg의<br />CO₂감축한다고 해요! 우리의 작은 습관이 환경을 보호할 수 있어요!</p>
			</div>
			<%' 4학년 %>
			<div id="question4" class="question question4 <%If testchk Then %><% If q4val="4" Then %>correct<%Else%>wrong<% End If %><% End If %>">
				<p class="txt"><em></em><img src="http://webimage.10x10.co.kr/playing/thing/vol016/txt_question4.png" alt="4. 외출할 때 뽑아야 할 것은 무엇일까요?" /></p>
				<ul class="answer">
					<li id="q4a1" class="q4a1" onclick="wAnswerVal('q4val', '1');return false;"><i></i><img src="http://webimage.10x10.co.kr/playing/thing/vol016/txt_answer4_1.png" alt="사랑니" /></li>
					<li id="q4a2" class="q4a2" onclick="wAnswerVal('q4val', '2');return false;"><i></i><img src="http://webimage.10x10.co.kr/playing/thing/vol016/txt_answer4_2.png" alt="반장" /></li>
					<li id="q4a3" class="q4a3" onclick="wAnswerVal('q4val', '3');return false;"><i></i><img src="http://webimage.10x10.co.kr/playing/thing/vol016/txt_answer4_3.png" alt="제비뽑기" /></li>
					<li id="q4a4" class="q4a4" onclick="wAnswerVal('q4val', '4');return false;"><i></i><img src="http://webimage.10x10.co.kr/playing/thing/vol016/txt_answer4_4.png" alt="콘센트" /></li>
				</ul>
				<p class="desc">쓰지 않는 콘센트를 꼽아 놓을 때, 꽂는 것만으로도 많은 양의 전기가<br />소모 된다고 해요! 외출 전에 콘센트를 뽑기만 해도 환경을 아낄 수 있어요.</p>
			</div>
			<%' 5학년 %>
			<div id="question5" class="question question5 <%If testchk Then %><% If q5val="3" Then %>correct<%Else%>wrong<% End If %><% End If %>">
				<p class="txt"><em></em><img src="http://webimage.10x10.co.kr/playing/thing/vol016/txt_question5.png" alt="5. 철수, 영희, 민수가 분리수거를 하고 있습니다. 엄마(경비아저씨)에게 꾸중을 들을 사람은 누구일까요?" /></p>
				<ul class="answer">
					<li id="q5a1" class="q5a1" onclick="wAnswerVal('q5val', '1');return false;"><i></i><img src="http://webimage.10x10.co.kr/playing/thing/vol016/txt_answer5_1.png" alt="철수" /></li>
					<li id="q5a2" class="q5a2" onclick="wAnswerVal('q5val', '2');return false;"><i></i><img src="http://webimage.10x10.co.kr/playing/thing/vol016/txt_answer5_2.png" alt="영희" /></li>
					<li id="q5a3" class="q5a3" onclick="wAnswerVal('q5val', '3');return false;"><i></i><img src="http://webimage.10x10.co.kr/playing/thing/vol016/txt_answer5_3.png" alt="민수" /></li>
				</ul>
				<p class="desc">계란과 양파는 음식물 쓰레기가 안 된다는 것 알고 계셨나요?<br />계란, 양파, 대파, 마늘, 생선 뼈, 동물 뼈 등은 일반 쓰레기로 버려야 해요!</p>
			</div>
			<%' 6학년 %>
			<div id="question6" class="question question6 <%If testchk Then %>correct<% End If %>">
				<p class="txt"><em></em><img src="http://webimage.10x10.co.kr/playing/thing/vol016/txt_question6.png" alt="6. 민수가 꽃을 꺾고 있습니다. 민수에게 뭐라고 따끔하게 말해줄까요?" /></p>
				<div class="writeCont"><input type="text" placeholder="이런 개나리가! 너도 꺾여 볼래?" maxlength="20" id="q6text" value="<%=q6val%>"/></div>
				<p><img src="http://webimage.10x10.co.kr/playing/thing/vol016/txt_tip2.png" alt="20자 이내로 입력해주세요." /></p>
				<button type="button" class="btnSubmit" onclick="gowiseLifeTest();return false;"><img src="http://webimage.10x10.co.kr/playing/thing/vol016/btn_marking.png" alt="채점하기" /></button>
				<a href="/event/eventmain.asp?eventid=78257" class="btnGoEvt" target="_blank"><img src="http://webimage.10x10.co.kr/playing/thing/vol016/btn_go_event.png" alt="보충학습 하러가기" /></a>
			</div>
		</div>
		<div class="deco d1"></div>
		<div class="deco d2"></div>
		<div class="deco d3"></div>
		<div class="deco d4"></div>
		<div class="deco d5"></div>
		<%' 채점중 %>
		<div class="loading" style="display:none;">
			<div>
				<span><img src="http://webimage.10x10.co.kr/playing/thing/vol016/img_pen.png" alt="" /></span>
				<p><img src="http://webimage.10x10.co.kr/playing/thing/vol016/txt_marking.png" alt="채점중..." /></p>
			</div>
		</div>
	</div>
	<%'// 문제 풀기 %>

	<%' 답변 리스트 %>
	<% IF isArray(arrCList) THEN %>
		<div class="section answerList" id="SecAnswerList">
			<h3><img src="http://webimage.10x10.co.kr/playing/thing/vol016/tit_reply.png" alt="센스있는 6학년 답변" /></h3>
			<ul>
				<%' 리스트 6개씩 노출 %>
				<% For intCLoop = 0 To UBound(arrCList,2) %>
				<li>
					<div>
						<span class="writer"><% If arrCList(8,intCLoop) <> "W" Then %><i>모바일에서 작성</i><% End If %><%=chrbyte(printUserId(arrCList(2,intCLoop),2,"*"),10,"Y")%></span>
						<p><%=arrCList(1,intCLoop)%></p>
						<span class="num">NO.<%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1)) %></span>
					</div>
				</li>
				<% Next %>
			</ul>
			<%' 10페이지까지 번호 노출 %>
			<div class="pageWrapV15">
				<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
			</div>
		</div>
	<% End If %>
	<%'// 답변 리스트 %>

	<%' volume %>
	<div class="seciton volume">
		<p><img src="http://webimage.10x10.co.kr/playing/thing/vol016/txt_vol_016.png" alt="vol.016 THING의 사물에 대한 생각 환경을 생각하는 상품들로 환경을 아껴주세요!" /></p>
	</div>
</div>
<%' //THING. html 코딩 영역 %>
<!-- #include virtual="/lib/db/dbclose.asp" -->