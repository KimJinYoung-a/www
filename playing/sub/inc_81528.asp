<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'#################################################################
' Description : 플레잉 왜 우리는 다이어리를 끝까지 써 본적이 없을까?
' History : 2017.10.26 정태훈
'#################################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<%
dim eCode, vUserID, myevt, vDIdx, myselect
dim arrList, sqlStr

IF application("Svr_Info") = "Dev" THEN
	eCode = "67443"
Else
	eCode = "81528"
End If

vDIdx = request("didx")
vUserID = getEncLoginUserID
myselect = 0

'참여했는지 체크
myevt = getevent_subscriptexistscount(eCode, vUserID,"","","")

sqlStr = ""
sqlStr = sqlStr & " select isnull([1],0) as '1',isnull([2],0) as '2',isnull([3],0) as '3',isnull([4],0) as '4'" & vbCrlf
sqlStr = sqlStr & " from  " & vbCrlf
sqlStr = sqlStr & " ( " & vbCrlf
sqlStr = sqlStr & "		SELECT  sub_opt2 as so2, COUNT(*) as cnt " & vbCrlf
sqlStr = sqlStr & "			FROM db_event.[dbo].[tbl_event_subscript]  " & vbCrlf
sqlStr = sqlStr & "				where evt_code = '"& eCode &"' " & vbCrlf
sqlStr = sqlStr & "				group by sub_opt2 " & vbCrlf
sqlStr = sqlStr & " ) as a " & vbCrlf
sqlStr = sqlStr & " pivot " & vbCrlf
sqlStr = sqlStr & " ( " & vbCrlf
sqlStr = sqlStr & "		sum(cnt) for so2 in ([1],[2],[3],[4]) " & vbCrlf
sqlStr = sqlStr & " ) as tp "
rsget.Open sqlStr,dbget,1
If not rsget.EOF Then
	arrList = rsget.getRows()
End If
rsget.close

dim numcols, rowcounter, colcounter, thisfield(3)
if isArray(arrList) then
	numcols=ubound(arrList,1)
		FOR colcounter=0 to numcols
			thisfield(colcounter)=arrList(colcounter,0)
			if isnull(thisfield(colcounter)) or trim(thisfield(colcounter))=""then
				thisfield(colcounter)="0"
			end if
		Next
Else
		thisfield(0)="0"
		thisfield(1)="0"
		thisfield(2)="0"
		thisfield(3)="0"
end if
'response.write thisfield(8)

sqlstr = "select top 1 sub_opt2 " &_
		"  from db_event.dbo.tbl_event_subscript where evt_code = '" & eCode & "' and userid = '" & vUserID & "' "
		'response.write sqlstr
rsget.Open sqlStr,dbget,1
	IF Not rsget.Eof Then
		myselect = rsget(0)
	end if
rsget.Close
%>
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<style type="text/css">
.diary button {background-color:transparent;}
.diary .topic {height:834px; background:#ebd6bf url(http://webimage.10x10.co.kr/playing/thing/vol026/bg_topic.jpg) 50% 0 no-repeat;}
.topic .inner {width:1020px; margin:0 auto; padding-top:109px;}
.topic p {margin-top:50px;}
.diary h2 {overflow:hidden; width:464px; height:341px;}
.diary .topic span {display:block; background:url(http://webimage.10x10.co.kr/playing/thing/vol026/tit_diary.png) 0 0 no-repeat; text-indent:-9999em; opacity:0;}
.diary .topic .label {width:212px; height:28px;}
.diary .topic .letter1 {height:62px; margin-top:66px; background-position:0 -94px; animation-delay:0.5s;}
.diary .topic .letter2 {height:78px; margin-top:12px; background-position:0 -168px; animation-delay:0.5s;}
.diary .topic .letter3 {height:62px; margin-top:31px;  background-position:0 100%; animation-delay:1s;}
.opacity {animation:opacity 0.8s cubic-bezier(0.1, 1, 0.5, 1) forwards;}
@keyframes opacity {
	0% {transform:translateY(10px); opacity:0;}
	100% {transform:translateY(0); opacity:1;}
}
.slideX {animation:slideX 0.6s ease-in forwards;}
@keyframes slideX {
	0% {transform:translateX(-50px); opacity:0;}
	100% {transform:translateX(0); opacity:1;}
}

.graph p, .graph li {background:url(http://webimage.10x10.co.kr/playing/thing/vol026/txt_graph.png) 0 0 no-repeat; text-indent:-9999em; opacity:0;}
.graph p {height:31px; animation-delay:1.6s;}
.graph ol {margin-top:52px;}
.graph li {height:30px; margin-top:15px; background-position:0 -83px;}
.graph .ranking1 {margin-top:0; animation-delay:2.1s;}
.graph .ranking2 {background-position:0 -128px; animation-delay:2.3s;}
.graph .ranking3 {background-position:0 -172px; animation-delay:2.5s;}
.graph .ranking4 {background-position:0 -217px; animation-delay:2.7s;}
.effect1 {animation:effect1 0.7s cubic-bezier(.17, .27, .51, 1.01) forwards; animation-fill-mode:both;}
@keyframes effect1 {
	0% {transform:translateX(40px); opacity:0;}
	100% {transform:translateX(0); opacity:1;}
}

.story {height:1653px; padding-top:138px; background:#2f393e url(http://webimage.10x10.co.kr/playing/thing/vol026/bg_story.jpg) 50% 0 no-repeat; text-align:center;}
.question {width:1140px; height:1120px; margin:0 auto; padding-top:84px; background:url(http://webimage.10x10.co.kr/playing/thing/vol026/bg_box.png) 50% 0 no-repeat;}
.no1 {margin-top:33px;}
.no1 b {display:block; width:149px; height:52px; margin:0 auto;}
.no1 b:after {content:' '; display:block; clear:both;}
.typing .letter {float:left; width:39px; height:100%; background:url(http://webimage.10x10.co.kr/playing/thing/vol026/txt_no_one.gif) 0 0 no-repeat; text-indent:-9999em; opacity:0;}
.typing .letter2 {width:48px; background-position:-39px 0; animation-delay:0.2s;}
.typing .letter3 {width:62px; background-position:-87px 0; animation-delay:0.8s;}
.effect2 {animation:effect2 2.5s cubic-bezier(0.1, 1, 0, 1) forwards;}
@keyframes effect2 {
	0% {transform:translateX(-15px); opacity:0;}
	100% {transform:translateX(0); opacity:1;}
}
.conclusion {padding-top:110px;}
.btn-item {margin-top:42px;}
.btn-item:hover img {animation:shake 3s infinite; animation-fill-mode:both;}
@keyframes shake {
	0%, 100% {transform:translateX(0);}
	10%, 30%, 50%, 70%, 90% {transform:translateX(-10px);}
	20%, 40%, 60%, 80% {transform:translateX(10px);}
}

.vote {height:940px; padding-top:103px; background:#faefe6 url(http://webimage.10x10.co.kr/playing/thing/vol026/bg_paper.jpg) 50% 0 repeat; text-align:center;}
.vote h3 + p {margin-top:43px;}
.choice ul {width:1100px; margin:102px auto 0;}
.choice ul:after {content:' '; display:block; clear:both;}
.choice li {float:left; width:273px; height:274px; margin:0 1px;}
.choice button {position:relative; width:100%; height:100%; font-size:11px; outline:none;}
.choice .bg {position:absolute; top:0; left:0;width:100%; height:100%; background:url(http://webimage.10x10.co.kr/playing/thing/vol026/btn_choice.png) 0 0 no-repeat;}
.choice .on .bg {background-position:0 100%;}
.choice .type2 .bg {background-position:-273px 0;}
.choice .type2 .on .bg {background-position:-273px 100%;}
.choice .type3 .bg {background-position:-546px 0;}
.choice .type3 .on .bg {background-position:-546px 100%;}
.choice .type4 .bg {background-position:100% 0;}
.choice .type4 .on .bg {background-position:100% 100%;}
.choice .icon {position:absolute; top:-46px; left:99px; z-index:5; width:58px; height:57px; background:url(http://webimage.10x10.co.kr/playing/thing/vol026/ico_check.png) 0 0 no-repeat; text-indent:-999em; opacity:0; transition:all 0.3s;}
.choice .on .icon {top:-36px; opacity:1;}
.choice .counting {margin-top:-14px; color:#5e5e5e; font-size:13px; font-weight:bold;}
.choice .counting b {color:#f2403c; font-family:'Verdana';}
.btn-vote {clear:left; margin-top:98px;}

.epilogue {height:437px; padding-top:101px; background:#72353d url(http://webimage.10x10.co.kr/playing/thing/vol026/bg_epilogue.jpg) 50% 0 no-repeat; text-align:center;}
.epilogue p {margin-top:35px;}
.epilogue h3 + p {margin-top:25px;}
</style>
<script type="text/javascript">
$(function(){
	/* vote */
	$(".choice li button").click(function(){
		$(".choice li button").removeClass("on");
		if ( $(this).hasClass("on")) {
			$(this).removeClass("on");
		} else {
			$(this).addClass("on");
			$("#stype").val($(this).val());
		}
	});

	/* title animation */
	function titleAnimation() {
		var window_top = $(window).scrollTop();
		var div_top = $(".headerWrapV15").offset().top;
		if (window_top > div_top){
			$("#titleAnimation .label").addClass("slideX");
			$("#titleAnimation .letter").addClass("opacity");
			$(".graph p").addClass("effect1");
			$(".graph li").addClass("effect1");
		} else {
			$("#titleAnimation .label").removeClass("slideX");
			$("#titleAnimation .letter").removeClass("opacity");
			$(".graph p").removeClass("effect1");
			$(".graph li").removeClass("effect1");
		}
	}
	function typingAnimation() {
		var window_top = $(window).scrollTop();
		var div_top = $(".graph").offset().top;
		if (window_top > div_top){
			$("#story .typing span").addClass("effect2");
		} else {
			$("#story .typing span").removeClass("effect2");
		}
	}
	$(function() {
		$(window).scroll(titleAnimation);
		$(window).scroll(typingAnimation);
	});
});

function fnBadge() {
	var badgeval = $("#stype").val();
	<% If vUserID = "" Then %>
		if ("<%=IsUserLoginOK%>"=="False") {
			if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
				location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/playing/view.asp?didx="&vDIdx)%>';
				return;
			}
			return false;
		}
	<% End If %>
	<% If vUserID <> "" Then %>
	
	if(!badgeval > 0 && !badgeval < 10){
		alert('어떤 유형인지 선택해 주세요.');
		return false;
	}
	
	var reStr;
	var str = $.ajax({
		type: "GET",
		url:"/playing/sub/doEventSubscript81528.asp",
		data: "mode=down&stype="+badgeval,
		dataType: "text",
		async: false
	}).responseText;
		reStr = str.split("|");
		if(reStr[0]=="OK"){
			if(reStr[1] == "dn") {
				$("#badgebtn").hide();
				$("#badgehd").show();
				$("#cnt"+badgeval).html(Number($("#count"+badgeval).val())+1);
				alert('투표가 완료 되었습니다.');
				//document.location.reload();
				return false;
			}else{
				alert('오류가 발생했습니다.');
				//document.location.reload();
				return false;
			}
		}else{
			errorMsg = reStr[1].replace(">?n", "\n");
			alert(errorMsg);
			
			//document.location.reload();
			return false;
		}
	<% End If %>
}

function fnBadgeok() {
	alert('투표가 완료 되었습니다.');
	return false;
}

function fnaftalt() {
	alert('이미 투표 하셨습니다.');
	return false;
}
</script>
						<div class="thingVol026 diary">
							<div class="section topic">
								<div class="inner">
									<h2 id="titleAnimation">
										<span class="label">장바구니 탐구생활 다이어리편</span>
										<span class="letter letter1">왜 우리는</span>
										<span class="letter letter2">다이어리를 끝까지</span>
										<span class="letter letter3"> 써 본적이 없을까?</span>
									</h2>
									<div class="graph">
										<p>나는 다이어리를 몇 월 까지 써봤다</p>
										<ol>
											<li class="ranking1">57% 8월</li>
											<li class="ranking2">25% 10월</li>
											<li class="ranking3">12% 6월</li>
											<li class="ranking4">6% 기타</li>
										</ol>
									</div>
								</div>
							</div>

							<div id="story" class="section story">
								<div class="question">
									<h3><img src="http://webimage.10x10.co.kr/playing/thing/vol026/tit_question.gif" alt="Question" /></h3>
									<p class="no1">
										<b class="typing">
											<span class="letter letter1">1위</span>
											<span class="letter letter2">는</span>
											<span class="letter letter3">8월</span>
										</b>
										<img src="http://webimage.10x10.co.kr/playing/thing/vol026/txt_question.gif?v=1.0" alt="왜, 한 해를 다 채우지 못하고 다이어리를 마무리하는 걸까? 플레잉 프로 고민 자문 위원단이 여러 유형의 다이어리 덕후들을 만나 함께 고민해 보았습니다." />
									</p>
									<p><img src="http://webimage.10x10.co.kr/playing/thing/vol026/txt_interview_01.gif" alt="예쁜 다이어리 모으기 전문 박○○ 한가지 디자인만 쓰는게 지루해, 계속 다른 제품을 구매하고 쓰길 반복해서 그런 게 아닐까요? 다이어리 꾸미기 전문 문○○ 자서전처럼 완성되는 기분이 좋아서 한 권을 예쁘게 꾸며 꽉 채워요. 하지만 눈에 보이는 손상이 생기면 새로 구매해서 사용해요. 체계적으로 쓰기 전문 정○○ 용도에 맞게 사용하는 것을 좋아해서 모든 다이어리를 끝까지 다 못쓰죠. 저 같은 유형의 사람들이 많지 않을까요? 자유롭게 쓰기 전문 한○○ 칸칸이 나누어져 있는 페이지가 조금 불편해서 무지 노트처럼 편하게 사용하다 보니 한 권을 다 못채워요." /></p>
									<p><img src="http://webimage.10x10.co.kr/playing/thing/vol026/txt_interview_02.gif" alt="다이어리 덕후들도 한 권을 다 쓰는것은 아니라는 결과와 함께 자신에게 맞는 다이어리를 찾으면 끝까지 쓸 것 같다는 의견이 나왔습니다" /></p>
								</div>
								<div class="conclusion">
									<p><img src="http://webimage.10x10.co.kr/playing/thing/vol026/txt_conclusion.png" alt="Conclusion 그래서 내린 결론! 플레잉에서 유형에 맞게 추천한 다이어리로 2018년을 꽉 채워보자!" /></p>
									<div class="btn-item">
										<a href="/event/eventmain.asp?eventid=81528"><img src="http://webimage.10x10.co.kr/playing/thing/vol026/btn_item.png" alt="각 유형별 다이어리 추천 아이템 보기" /></a>
									</div>
								</div>
							</div>

							<div class="section vote">
								<h3><img src="http://webimage.10x10.co.kr/playing/thing/vol026/tit_vote.png" alt="Vote" /><input type="hidden" id="stype"></h3>
								<p><img src="http://webimage.10x10.co.kr/playing/thing/vol026/txt_vote.png" alt="다이어리를 쓸때 어떤 유형인지 체크 후 투표해주세요! 투표해주신 고객분들 중 추첨을 통하여 20분께 유형에 맞는 다이어리를 증정합니다. 응모기간 2017.10.30 ~ 11.13, 발표 11.14, 당첨자 20명, 사은품 선택한 유형의 다이어리 종류 랜덤증정, 한 ID 당 1회 투표가능" /></p>
								<div class="choice">
									<ul>
										<li class="type1">
											<button type="button" value="1"<% If myselect="1" Then Response.write " class='on'" %>><span class="bg"></span>A 예쁜 다이어리를 모으는 유형<span class="icon"></span></button>
											<div class="counting"><b id="cnt1"><%= thisfield(0) %><input type="hidden" id="count1" value="<%= thisfield(0) %>"></b>명의 선택</div>
										</li>
										<li class="type2">
											<button type="button" value="2"<% If myselect="2" Then Response.write " class='on'" %>><span class="bg"></span>B 용도에 따라 다양한 다이어리를 쓰는 유형<span class="icon"></span></button>
											<div class="counting"><b id="cnt2"><%= thisfield(1) %><input type="hidden" id="count2" value="<%= thisfield(1) %>"></b>명의 선택</div>
										</li>
										<li class="type3">
											<button type="button" value="3"<% If myselect="3" Then Response.write " class='on'" %>><span class="bg"></span>C 꾸며서 한 권을 완성하는 유형<span class="icon"></span></button>
											<div class="counting"><b id="cnt3"><%= thisfield(2) %><input type="hidden" id="count3" value="<%= thisfield(2) %>"></b>명의 선택</div>
										</li>
										<li class="type4">
											<button type="button" value="4"<% If myselect="4" Then Response.write " class='on'" %>><span class="bg"></span>D 자유롭게 쓰는 유형<span class="icon"></span></button>
											<div class="counting"><b id="cnt4"><%= thisfield(3) %><input type="hidden" id="count4" value="<%= thisfield(3) %>"></b>명의 선택</div>
										</li>
									</ul>
									<% If vUserID = "" Then %>
									<button type="button" class="btn-vote" onClick="fnBadge();return false;" id="badgebtn"><img src="http://webimage.10x10.co.kr/playing/thing/vol026/btn_vote.gif" alt="투표하기" /></button>
									<% Else %>
									<% if myevt = "0" then %>
									<button type="button" class="btn-vote" onClick="fnBadge();return false;" id="badgebtn"><img src="http://webimage.10x10.co.kr/playing/thing/vol026/btn_vote.gif" alt="투표하기" /></button>
									<div class="btn-vote" id="badgehd" style="display:none"><img src="http://webimage.10x10.co.kr/playing/thing/vol026/btn_vote_done.gif" alt="투표완료" /></div>
									<% Else %>
									<div class="btn-vote" id="badgehd"><img src="http://webimage.10x10.co.kr/playing/thing/vol026/btn_vote_done.gif" alt="투표완료" /></div>
									<% End If %>
									<% End If %>
								</div>
							</div>
							<div class="section epilogue">
								<h3><img src="http://webimage.10x10.co.kr/playing/thing/vol026/tit_epilogue.png" alt="Epilogue" /></h3>
								<p><img src="http://webimage.10x10.co.kr/playing/thing/vol026/txt_epilogue_01.png" alt="지금, 다이어리 쓰고 있나요? 인스타그램에 예전에 쓴, 혹은 지금 쓰고 있는 다이어리를 #텐바이텐플레잉과 함께 자랑해주세요! 다이어리 끝까지 쓰기 팁과 사진을 올려주신 분들 중 5명을 추첨하여 다이어리를 선물로 드립니다. 다이어리 랜덤증정" /></p>
								<p><img src="http://webimage.10x10.co.kr/playing/thing/vol026/txt_epilogue_02.png" alt="유의사항 인스타그램 계정이 비공개인 경우, 집계가 되지 않습니다. 당첨자 발표는 Direct Message로 개별 통보됩니다. 플레잉 인스타그램 @10X10PLAYING" /></p>
							</div>
						</div>
						<!-- //THING. html 코딩 영역 -->
<!-- #include virtual="/lib/db/dbclose.asp" -->