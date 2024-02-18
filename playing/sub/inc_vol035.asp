<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'#################################################################
' Description : 플레잉 Thing 여러분은 다이어트할 때 어떤 성향 인가요?
' History : 2018-02-13 이종화
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
	eCode = "84592"
End If

vDIdx = request("didx")
vUserID = getEncLoginUserID
myselect = 0

'참여했는지 체크
myevt = getevent_subscriptexistscount(eCode, vUserID,"","","")

sqlStr = ""
sqlStr = sqlStr & " SELECT isnull([1],0) AS '1',isnull([2],0) AS '2',isnull([3],0) AS '3',isnull([4],0) AS '4'" & vbCrlf
sqlStr = sqlStr & " FROM  " & vbCrlf
sqlStr = sqlStr & " ( " & vbCrlf
sqlStr = sqlStr & "		SELECT  sub_opt2 AS so2, COUNT(*) AS cnt " & vbCrlf
sqlStr = sqlStr & "			FROM db_event.[dbo].[tbl_event_subscript]  " & vbCrlf
sqlStr = sqlStr & "				WHERE evt_code = '"& eCode &"' " & vbCrlf
sqlStr = sqlStr & "				GROUP BY sub_opt2 " & vbCrlf
sqlStr = sqlStr & " ) AS a " & vbCrlf
sqlStr = sqlStr & " PIVOT " & vbCrlf
sqlStr = sqlStr & " ( " & vbCrlf
sqlStr = sqlStr & "		sum(cnt) FOR so2 IN ([1],[2],[3],[4]) " & vbCrlf
sqlStr = sqlStr & " ) AS tp "
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
%>
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<style type="text/css">
.thingVol035 {text-align:center;}
.thingVol035 .inner {position:relative; width:1140px; margin:0 auto;}
.topic {height:919px; background:#feeeb9 url(http://webimage.10x10.co.kr/playing/thing/vol035/bg_topic.jpg) 50% 0 no-repeat;}
.topic .label {overflow:hidden; position:absolute; left:21px; top:150px;}
.topic .label img {margin-left:-218px; transition:all 1s .2s;}
.topic h2 span {display:inline-block; position:absolute; left:21px; z-index:20;}
.topic h2 .t1 {top:218px; margin-left:-20px; opacity:0; transition:all 1s .6s;}
.topic h2 .t2 {top:370px; margin-left:20px; opacity:0; transition:all 1s .6s;}
.topic .what {position:absolute; left:21px; top:498px; margin-top:8px; opacity:0; transition:all 1.5s 1.3s;}
.topic .viewTag {position:absolute; left:21px; top:599px; margin-top:5px; opacity:0; transition:all 1s 1.8s;}
.topic .rank {position:absolute; left:21px; top:654px; width:433px; height:193px; opacity:0; transition:all 1s 2.3s;}
.topic .rank ul {position:relative; width:100%; height:100%;}
.topic .rank li {position:absolute; left:15px; top:10px; width:0; height:16px; transition:all .8s 1.6s; background-position:0 0; background-repeat:no-repeat; background-image:url(http://webimage.10x10.co.kr/playing/thing/vol035/txt_grade1.png); text-indent:-999em;}
.topic .rank li + li {top:47px; transition-delay:1.8s; background-image:url(http://webimage.10x10.co.kr/playing/thing/vol035/txt_grade2.png)}
.topic .rank li + li + li {top:83px; transition-delay:2s; background-image:url(http://webimage.10x10.co.kr/playing/thing/vol035/txt_grade3.png)}
.topic .rank li + li + li + li {top:120px; transition-delay:2.5s; background-image:url(http://webimage.10x10.co.kr/playing/thing/vol035/txt_grade4.png)}
.topic .rank .deco {display:block; position:absolute; left:0; top:-2px; width:460px; height:56px; background:url(http://webimage.10x10.co.kr/playing/thing/vol035/line_dot.png) 0 0 no-repeat;}
.topic.animation .label img {margin-left:0;}
.topic.animation h2 .t1 {margin-left:0; opacity:1;}
.topic.animation h2 .t2 {margin-left:0; opacity:1;}
.topic.animation .what {margin-top:0; opacity:1;}
.topic.animation .viewTag {margin-top:0; opacity:1;}
.topic.animation .rank {opacity:1;}
.topic.animation .rank li {width:139px; transition-delay:2s;}
.topic.animation .rank li + li {width:102px; transition-delay:2.5s;}
.topic.animation .rank li + li + li {width:144px; transition-delay:3s;}
.topic.animation .rank li + li + li + li {width:120px; transition-delay:3.5s;}
.section1 {position:relative; padding:100px 0; background-color:#87ecd1;}
.section1 p {position:absolute; left:50%; top:210px; opacity:1; display:inline-block; height:35px; background:url(http://webimage.10x10.co.kr/playing/thing/vol035/txt_what_question.png) 0 0 no-repeat; text-indent:-999em;}
.section2 {padding:100px 0; background-image:url(http://webimage.10x10.co.kr/playing/thing/vol035/bg_noise_1.jpg);}
.section2 ul {width:920px; margin:0 auto;}
.section2 li {height:302px; padding-bottom:98px; background:url(http://webimage.10x10.co.kr/playing/thing/vol035/img_story_2.jpg) 100% 0 no-repeat;}
.section2 li p {position:relative; left:-10px; opacity:0; text-align:left;}
.section2 li.story1 {padding-left:402px; background:url(http://webimage.10x10.co.kr/playing/thing/vol035/img_story_1.jpg) 0 0 no-repeat;}
.section2 li.story3 {padding-left:402px; background:url(http://webimage.10x10.co.kr/playing/thing/vol035/img_story_3.jpg) 0 0 no-repeat;}
.section2 li.story4 {padding-bottom:0; background:url(http://webimage.10x10.co.kr/playing/thing/vol035/img_story_4.jpg) 100% 0 no-repeat;}
.section3 {padding:100px 0; background:#e84d3a url(http://webimage.10x10.co.kr/playing/thing/vol035/bg_conclusion.png) 50% 0 repeat-x;}
.section3 h3 {padding-bottom:50px;}
.section3 .btnShake:hover {animation:shake 2s 50; animation-fill-mode:both;}
.section4 {padding:80px 0 90px; background:#f6e8e0 url(http://webimage.10x10.co.kr/playing/thing/vol035/bg_vote.png) 50% 0 repeat-x;}
.section4 h3 {padding-bottom:37px;}
.section4 .vote ul {overflow:hidden; width:1100px; margin:0 auto;}
.section4 .vote ul li {float:left; width:275px;}
.section4 .vote ul li div {position:relative; width:273px; height:306px;}
.section4 .vote ul li p {width:255px; font-size:13px; text-align:center; font-weight:bold; color:#5e5e5e;}
.section4 .vote ul li p span {color:#f2403c;}
.section4 .vote ul li input {visibility:hidden; position:absolute; left:0; top:0; width:0; height:0;}
.section4 .vote ul li label {overflow:hidden; display:block; position:relative; width:273px; height:306px; cursor:pointer; text-indent:-999em; background-image:url(http://webimage.10x10.co.kr/playing/thing/vol035/vote_check.png); background-repeat:no-repeat; background-position:0 0;}
.section4 .vote ul li + li input + label {background-position:-275px 0;}
.section4 .vote ul li + li + li input + label {background-position:-550px 0;}
.section4 .vote ul li + li + li + li input + label {background-position:-825px 0;}
.section4 .vote ul li input[type=radio]:checked + label {background-image:url(http://webimage.10x10.co.kr/playing/thing/vol035/vote_check_select.png);}
.section4 .submit {margin-top:100px;}
.final {padding:60px 0; background:#003b48 url(http://webimage.10x10.co.kr/playing/thing/vol035/bg_final.png) 0 0 repeat-x; text-align:center;}
.blink {animation:blink 1.7s 50 3.8s; animation-fill-mode:both;}
@keyframes  blink {
	0%, 100% {opacity:0;}
	10%, 30%, 50%, 70%, 90% {opacity:1;}
	20%, 40%, 60%, 80% {opacity:0;}
}
.typing {width:309px; margin-left:-154px; animation:typing .6s steps(11, end);}
@keyframes typing {
	from {width:0; margin-left:0;}
	to {width: 309px; margin-left:-154px;}
}
@keyframes shake {
	0%, 100% {transform:translateX(0);}
	10%, 30%, 50%, 70%, 90% {transform:translateX(-5px);}
	20%, 40%, 60%, 80% {transform:translateX(5px);}
}
</style>
<script type="text/javascript">
$(function(){
	$(".topic").addClass("animation");
	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 900 ) {
			$(".section1 p").addClass("typing");
		}
		if (scrollTop > 960) {
			$(".section2 li.story1 p").animate({"left":"0","opacity":"1"},500);
		}
		if (scrollTop > 1360) {
			$(".section2 li.story2 p").animate({"left":"0","opacity":"1"},500);
		}
		if (scrollTop > 1760) {
			$(".section2 li.story3 p").animate({"left":"0","opacity":"1"},500);
		}
		if (scrollTop > 2160) {
			$(".section2 li.story4 p").animate({"left":"0","opacity":"1"},500);
		}
	});

	/* vote */
	$(".vote li").click(function(){
		$("#stype").val($(this).find("input").val());
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
	<% else %>

	if(badgeval == ""){
		alert('어떤 유형인지 선택해 주세요.');
		return false;
	}

	var reStr;
	var str = $.ajax({
		type: "GET",
		url:"/playing/sub/sub_proc.asp",
		data: "mode=act&eventid=<%=eCode%>&subopt2="+badgeval,
		dataType: "text",
		async: false
	}).responseText;
		reStr = str.split("|");
		if(reStr[0]=="OK"){
			if(reStr[1] == "ok") {
				$("#badgebtn").hide();
				$("#badgehd").show();
				$("#cnt"+badgeval).html(parseInt($("#cnt"+badgeval).text())+1);
				alert('투표가 완료 되었습니다.');
				return false;
			}else{
				alert('오류가 발생했습니다.');
				return false;
			}
		}else{
			errorMsg = reStr[1].replace(">?n", "\n");
			alert(errorMsg);
			return false;
		}
	<% End If %>
}
</script>
<div class="thingVol035">
	<div class="topic">
		<div class="inner">
			<p class="label"><img src="http://webimage.10x10.co.kr/playing/thing/vol035/txt_label.png" alt="장바구니 탐구생활_다이어트편" /></p>
			<h2>
				<span class="t1"><img src="http://webimage.10x10.co.kr/playing/thing/vol035/tit_diet_1.png" alt="명절에 이 소리 또 들었다." /></span>
				<span class="t2"><img src="http://webimage.10x10.co.kr/playing/thing/vol035/tit_diet_2.png" alt="살쪘니?" /></span>
			</h2>
			<p class="what"><img src="http://webimage.10x10.co.kr/playing/thing/vol035/tit_diet_3.png" alt="Feat. 나 오늘부터 다이어트 한다." /></p>
			<p class="viewTag"><img src="http://webimage.10x10.co.kr/playing/thing/vol035/txt_view.png" alt="다이어트를 결심하는 순간 BEST4" /></p>
			<div class="rank">
				<ol>
					<li>1위 명절이 끝난 후</li>
					<li>2위 1월, 새해</li>
					<li>3위 여름휴가 D-30</li>
					<li>4위 365일 항상</li>
				</ol>
				<span class="deco blink"></span>
			</div>
		</div>
	</div>
	<div class="section section1">
		<h3><img src="http://webimage.10x10.co.kr/playing/thing/vol035/txt_what.png" alt="덕담 대신 받은 잔소리때문에 오늘부터 다이어트를 결심하신 분 있나요? 다이어트를 결심하고 실패하기를 반복하는 우리. 다이어트에 성공한 플레잉 위원들의 경험을 들어보았습니다." /></h3>
		<p>어떻게 해야 성공할까?</p>
	</div>
	<div class="section section2">
		<ul>
			<li class="story1"><p><img src="http://webimage.10x10.co.kr/playing/thing/vol035/txt_story_1.png" alt="길고 확실하게 A유형" /></p></li>
			<li class="story2"><p><img src="http://webimage.10x10.co.kr/playing/thing/vol035/txt_story_2.png" alt="먹고 운동하자 B유형" /></p></li>
			<li class="story3"><p><img src="http://webimage.10x10.co.kr/playing/thing/vol035/txt_story_3.png" alt="단기 다이어트 C유형" /></p></li>
			<li class="story4"><p><img src="http://webimage.10x10.co.kr/playing/thing/vol035/txt_story_4.png" alt="다이어트 못해 D유형" /></p></li>
		</ul>
	</div>
	<div class="section section3">
		<h3><img src="http://webimage.10x10.co.kr/playing/thing/vol035/tit_conclusion.png" alt="나의 성향과 비슷한 다이어트 추천 방법으로 이번 다이어트! 성공해보시면 어떨까요?" /></h3>
		<a href="/event/eventmain.asp?eventid=84592" target="_blank"><img src="http://webimage.10x10.co.kr/playing/thing/vol035/btn_item.png" alt="다이어트 추천 아이템 보기"  class="btnShake" /></a>
	</div>
	<input type="hidden" name="stype" id="stype" value=""/>
	<div class="section section4">
		<h3><img src="http://webimage.10x10.co.kr/playing/thing/vol035/tit_vote.png" alt="여러분은 다이어트할 때 어떤 성향인가요?" /></h3>
		<div class="vote">
			<ul>
				<li>
					<div><input type="radio" id="type1" value="1" name="evtopt1"/><label for="type1">A타입 - 길고 확실하게 유형</label></div>
					<p><span id="cnt1"><%= thisfield(0) %></span>명의 선택</p>
				</li>
				<li>
					<div><input type="radio" id="type2" value="2" name="evtopt1"/><label for="type2">B타입 - 먹고 운동하자 유형</label></div>
					<p><span id="cnt2"><%= thisfield(1) %></span>명의 선택</p>
				</li>
				<li>
					<div><input type="radio" id="type3" value="3" name="evtopt1"/><label for="type3">C타입 - 단기 다이어트 유형</label></div>
					<p><span id="cnt3"><%= thisfield(2) %></span>명의 선택</p>
				</li>
				<li>
					<div><input type="radio" id="type4" value="4" name="evtopt1"/><label for="type4">D타입 - 다이어트 못해 유형</label></div>
					<p><span id="cnt4"><%= thisfield(3) %></span>명의 선택</p>
				</li>
			</ul>
			<% If vUserID = "" Then %>
			<button class="submit" onClick="fnBadge();return false;" id="badgebtn"><img src="http://webimage.10x10.co.kr/playing/thing/vol035/btn_vote.png" alt="투표하기" /></button>
			<% Else %>
			<% if myevt = "0" then %>
			<button class="submit" onClick="fnBadge();return false;" id="badgebtn"><img src="http://webimage.10x10.co.kr/playing/thing/vol035/btn_vote.png" alt="투표하기" /></button>
			<p class="submit" id="badgehd" style="display:none"><img src="http://webimage.10x10.co.kr/playing/thing/vol035/btn_vote_ok.png" alt="투표완료" /></p>
			<% Else %>
			<p class="submit" id="badgehd"><img src="http://webimage.10x10.co.kr/playing/thing/vol035/btn_vote_ok.png" alt="투표완료" /></p>
			<% End If %>
			<% End If %>
		</div>
	</div>
	<div class="final">
		<p><img src="http://webimage.10x10.co.kr/playing/thing/vol035/txt_final.png" alt="이번 플레잉 이벤트 당첨확률이 높은 고객 - 1. 텐바이텐에서 최근에 구매한 고객 / 2. 눈에 확 끌만한 재미있는 코멘트를 남겨주신 고객 / 3. 플레잉 컨텐츠들을 많이 응모했던 고객" /></p>
	</div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->