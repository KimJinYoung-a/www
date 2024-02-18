<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'#######################################################
'	History	: 2016-11-29 이종화 생성
'	Description : [★★2016 크리스마스] 산타의 선물
'#######################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventCls.asp" -->
<%
Dim mileagecnt, eventPossibleDate, TodayMaxCnt
Dim vUserID, eCode, vQuery, vCheck
vUserID = GetEncLoginUserID()
TodayMaxCnt = 500		'하루 5백명 선착순 지급
vCheck = false

IF application("Svr_Info") = "Dev" THEN
	eCode = "66247"
Else
	eCode = "74320"
End If

'당일 이벤트 참여수
vQuery = "SELECT COUNT(sub_idx) FROM db_event.dbo.tbl_event_subscript WHERE evt_code='"&eCode&"' And convert(varchar(10),regdate,120) = '"& Date() &"'"
rsget.Open vQuery, dbget, 1
If Not(rsget.bof Or rsget.Eof) Then
	mileagecnt = rsget(0)
End IF
rsget.Close

'마일리지 발급 여부 확인
If IsUserLoginOK() Then 
	vQuery = "SELECT COUNT(*) FROM [db_event].[dbo].[tbl_event_subscript] WHERE userid = '" & vUserID & "' And evt_code='"&eCode&"' "
	rsget.Open vQuery,dbget,1
	If rsget(0) > 0 Then
		vCheck = true
	End IF
	rsget.close()
End If 
%>
<style type="text/css">
/* christmas common */
img {vertical-align:top;}

.christmas {background-color:#fff;}
.christmas .head {overflow:hidden; position:relative; height:488px; background-color:#424444;}
.christmas .head .bg {position:absolute; top:0; left:0; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2016/74312/bg_light_01.png) no-repeat 50% 0;}
.christmas .head .light2 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/74312/bg_light_02.png);}
.christmas .head .star {background:url(http://webimage.10x10.co.kr/eventIMG/2016/74312/bg_star.png) no-repeat 50% 0;}
.christmas .head .light1 {animation-name:twinkle; animation-iteration-count:infinite; animation-duration:4s; animation-fill-mode:both; animation-delay:2s;}
.christmas .head .light2 {animation-name:twinkle; animation-iteration-count:infinite; animation-duration:4s; animation-fill-mode:both;}

.christmas .head .star {animation-name:twinkle2; animation-iteration-count:infinite; animation-duration:3s; animation-fill-mode:both;}
.christmas .head .inner {width:1140px; margin:0 auto;}
.christmas .head .hgroup {position:relative; height:388px; padding-top:35px;}
.christmas .head .hgroup .title {width:585px; margin:0 auto; padding-left:30px;}
.christmas .head .hgroup h2 {position:relative; width:585px; height:240px; margin:0 auto;}
.christmas .head .hgroup h2 span {display:block; position:absolute;}
.christmas .head .hgroup h2 .letter,
.christmas .head .hgroup h2 .year { width:50px; height:54px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/74312/tit_christmas.png) no-repeat -246px 0; text-indent:-999em;}
.christmas .head .hgroup h2 .letter1 {top:0; left:246px;}
.christmas .head .hgroup h2 .letter2 {top:74px; left:163px; width:212px; height:17px; background-position:-163px -64px;}
.christmas .head .hgroup h2 .letter3 {bottom:2px; left:0; width:585px; height:148px; background-position:50% -80px;}
.christmas .head .hgroup h2 .year {top:228px; left:195px; width:12px; height:22px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/74312/tit_christmas_2016.png) no-repeat 0 0;}
.christmas .head .hgroup h2 .year2 {left:242px; background-position:-47px 0;}
.christmas .head .hgroup h2 .year3 {left:289px; background-position:-94px 0;}
.christmas .head .hgroup h2 .year4 {left:332px; width:13px; background-position:-137px 0;}
.christmas .head .hgroup h2 .ico {top:123px; left:211px; animation-name:twinkle3; animation-iteration-count:infinite; animation-duration:3s; animation-fill-mode:both; animation-delay:1.8s;}
.christmas .head .hgroup p {margin-top:35px;}
@keyframes twinkle {
	0% {opacity:0.1;}
	50% {opacity:1;}
	100% {opacity:0.1;}
}
@keyframes twinkle2 {
	0% {opacity:1;}
	50% {opacity:0.1;}
	100% {opacity:2;}
}
@keyframes twinkle3 {
	0% {opacity:0;}
	50% {opacity:1;}
	100% {opacity:0;}
}

.spin {animation:spin 5s linear 5;}
@keyframes spin {100% {transform:rotateY(360deg);}}

.navigator {width:1140px; height:65px;}
.navigator ul {overflow:hidden;}
.navigator ul li {float:left; width:285px; height:65px; }
.navigator ul li a {display:block; position:relative; width:100%; height:100%; color:#fff; text-align:center;}
.navigator ul li a span { position:absolute; top:0; left:0; width:100%; height:100%; background:#fff url(http://webimage.10x10.co.kr/eventIMG/2016/74312/img_navigator.gif) no-repeat 0 0; cursor:pointer;}
.navigator ul li a:hover span {background-position:0 -65px;}
.navigator ul li a.on span {background-position:0 100%;}
.navigator ul li.nav2 a span {background-position:-285px 0;}
.navigator ul li.nav2 a:hover span {background-position:-285px -65px;}
.navigator ul li.nav2 a.on span {background-position:-285px 100%;}
.navigator ul li.nav3 a span {background-position:-570px 0;}
.navigator ul li.nav3 a:hover span {background-position:-570px -65px;}
.navigator ul li.nav3 a.on span {background-position:-570px 100%;}
.navigator ul li.nav4 a span {background-position:100% 0;}
.navigator ul li.nav4 a:hover span {background-position:100% -65px;}
.navigator ul li.nav4 a.on span {background-position:100% 100%;}

/* 74320 */
#contentWrap {padding-bottom:0;}
.christmas .hidden {visibility:hidden; width:0; height:0;}
.christmas button {background-color:transparent;}

.christmas .gift {padding-bottom:46px; background:#f6f4f1 url(http://webimage.10x10.co.kr/eventIMG/2016/74313/bg_tree.png) repeat-x 50% -131px;}
.christmas .gift .outer {position:relative; background:url(http://webimage.10x10.co.kr/eventIMG/2016/74314/bg_pattern.png) repeat 0 0 ;}
.christmas .gift .bg {position:absolute; top:146px; left:50%; width:1196px; height:511px; margin-left:-555px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/74320/bg_tree_v1.png) no-repeat 50% 0;}
.christmas .gift .inner {padding-top:109px;}

.christmas .btnGet {position:relative; width:486px; margin:40px auto 0;}
.christmas .btnGet span {position:absolute;}
.christmas .btnGet .click {top:58px; left:22px;}
.christmas .btnGet .click2 {top:82px; left:397px;}
.christmas .btnGet .click {animation-name:bounce; animation-iteration-count:infinite; animation-duration:1.2s;}
@keyframes bounce {
	from, to{margin-top:0; opacity:1; animation-timing-function:ease-out;}
	50% {margin-top:3px; opacity:0.8; animation-timing-function:ease-in;}
}
.christmas .btnGet .santa {top:64px; left:58px;}
.christmas .btnGet .santa {animation-name:shake; animation-iteration-count:infinite; animation-duration:4s; animation-delay:1s;}
@keyframes shake {
	from, to{margin-left:0; animation-timing-function:ease-out;}
	50% {margin-left:30px; animation-timing-function:ease-in;}
}

.christmas .btnGet button {position:relative; z-index:5;}
.christmas .btnGet button img {margin-left:-14px;}
.christmas .soldout {position:absolute; top:276px; left:50%; z-index:10; margin-left:-220px;}

.noti {padding:52px 0 58px; background:#d4d0ca;}
.noti .inner {overflow:hidden; position:relative; width:1140px; margin:0 auto;}
.noti .inner h4 {position:absolute; top:50%; left:91px; margin-top:-40px;}
.noti .inner ul {padding-left:302px; text-align:left;}
.noti .inner ul li {margin-top:14px; padding-left:15px; color:#6a655e; background:url(http://webimage.10x10.co.kr/eventIMG/2016/74319/blt_round.png) 0 2px no-repeat; font-size:11px; line-height:12px;}
.noti .inner ul li:first-child {margin-top:0;}
</style>
<script type="text/javascript">
$(function(){
	/* title animation */
	animation();
	$("#animation span").css({"margin-top":"5px", "opacity":"0"});
	$("#animation .ico").css({"margin-top":"0"});
	$("#animation .letter3").css({"margin-bottom":"10px", "opacity":"0"});
	function animation () {
		$("#animation .letter1").delay(100).animate({"margin-top":"0", "opacity":"1"},800);
		$("#animation .letter2").delay(500).animate({"margin-top":"0", "opacity":"1"},1000);
		$("#animation .letter3").delay(500).animate({"margin-bottom":"0", "opacity":"1"},1000);
		$("#animation .ico").delay(500).animate({"margin-top":"0", "opacity":"1",},800);
		$("#animation .year1").delay(900).animate({"margin-top":"0", "opacity":"1",},800);
		$("#animation .year2").delay(1100).animate({"margin-top":"0", "opacity":"1",},800);
		$("#animation .year3").delay(1300).animate({"margin-top":"0", "opacity":"1",},800);
		$("#animation .year4").delay(1500).animate({"margin-top":"0", "opacity":"1",},800);
	}
});

function jsSubmitC(){
<% If IsUserLoginOK() Then %>
	<% If not(date()>="2016-12-19" and date()<"2016-12-24") then %>
		alert("이벤트 응모 기간이 아닙니다.");
		return;
	<% else %>
		<% if mileagecnt >= TodayMaxCnt then %>
			alert("금일 마일리지 받기가 종료 되었습니다.\n내일 다시 받으러 와주세요!");
			return;
		<% else %>
			<% if vCheck then %>
				alert('이미 다운로드 받으셨습니다.');
				return;
			<% else %>
				var str = $.ajax({
					type: "POST",
					url: "/event/etc/doeventsubscript/doEventSubscript74320.asp",
					data: "mode=evtgo",
					dataType: "text",
					async: false
				}).responseText;
				var str1 = str.split("||")
				if (str1[0] == "11"){
					alert('마일리지가 발급 되었습니다.\n12월 25일 일요일까지\n사용하세요!');
					return false;
				}else if (str1[0] == "01"){
					alert('잘못된 접속입니다.');
					return false;
				}else if (str1[0] == "02"){
					alert('로그인을 해야\n이벤트에 참여할 수 있어요.');
					return false;
				}else if (str1[0] == "03"){
					alert('이벤트 기간이 아닙니다.');
					return false;		
				}else if (str1[0] == "04"){
					alert('본 이벤트는\nID당 한 번씩만 참여할 수 있어요.');
					return false;
				}else if (str1[0] == "05"){
					alert('낮 12시부터 다운이 가능합니다.');
					return false;
				}else if (str1[0] == "06"){
					alert('오늘 마일리지가 모두 소진되었습니다.');
					return false;
				}else if (str1[0] == "07"){
					alert('이미 마일리지를 받으셨습니다.\n마이텐바이텐에서 확인 해주세요');
					return false;
				}else if (str1[0] == "00"){
					alert('정상적인 경로가 아닙니다.');
					return false;
				}else{
					alert('오류가 발생했습니다.');
					return false;
				}
			<% end if %>
		<% end if %>
	<% end if %>
<% Else %>
	if(confirm("로그인을 하셔야 응모가 가능 합니다. 로그인 하시겠습니까?")){
		var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
		winLogin.focus();
		return false;
	}
	return false;
<% End IF %>
}
</script>
<div class="evt74312 christmas">
	<div class="head">
		<div class="bg light light1"></div>
		<div class="bg light light2"></div>
		<div class="bg star"></div>
		<div class="inner">
			<div class="hgroup">
				<div class="title">
					<h2 id="animation">
						<span class="letter letter1 spin"></span>
						<span class="letter letter2">Turn on your</span>
						<span class="letter letter3">Christmas</span>
						<span class="year year1">2</span>
						<span class="year year2">0</span>
						<span class="year year3">1</span>
						<span class="year year4">6</span>
						<span class="ico"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74312/img_light.png" alt="" /></span>
					</h2>
				</div>
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/74312/txt_date.png" alt="빛나는 당신의 잊지 못할 크리스마스를 위하여! 기획전 기간은 2016년 11월 21일부터 12월 23일까지 진행합니다." /></p>
			</div>

			<div class="navigator">
				<ul>
					<li class="nav1"><a href="/event/eventmain.asp?eventid=74313&eGc=193502"><span></span>Christmas colors</a></li>
					<li class="nav2"><a href="/event/eventmain.asp?eventid=74313&eGc=193503"><span></span>Christmas space</a></li>
					<li class="nav3"><a href="/event/eventmain.asp?eventid=74314"><span></span>Special present</a></li>
					<li class="nav4"><a href="/event/eventmain.asp?eventid=74319" class="on"><span></span>Enjoy with 텐바이텐</a></li>
				</ul>
			</div>
		</div>
	</div>

	<div class="gift">
		<div class="outer">
			<div class="bg"></div>
			<div class="inner">
				<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/74320/tit_santa_gift.png" alt="크리스마스에 놀러온 산타의 Gift" /></h3>
				<p style="margin-top:24px;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74320/txt_get.png" alt="매일 낮 12시 선착순 500명 산타의 마일리지를 받으세요! 발급 기간은 2016년 12월 19일부터 12월 23일까지 매일 낮 12시 입니다." /></p>

<%
	If Date() < "2016-12-24" Then
		If mileagecnt >= TodayMaxCnt Then
%>
				<p class="soldout"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74320/txt_soldout<%=chkiif(Date() = "2016-12-23","_last","")%>.png" alt="금일 마일리지가 종료 되었습니다<%=chkiif(Date() <> "2016-12-23"," 내일 낮 12시에 다시 받으러 와주세요!","")%>" /></p>
<%
	
		End If
	End If
%>
				<div class="btnGet">
					<span class="click click1"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74320/txt_click_01.png" alt="click" /></span>
					<span class="click click2"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74320/txt_click_02.png" alt="click" /></span>
					<button type="button" onClick="<% If Date() < "2016-12-24" Then %>jsSubmitC();<% End If %>return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74320/btn_get.png" alt="삼천마일리지 발급받기" /></button>
					<span class="santa"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74320/img_santa.png" alt="" /></span>
				</div>
				<p style="margin-top:-19px;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74320/txt_extinction.png" alt="다음 주 월요일 낮 12시가 되면 사용하지 않은 마일리지는 소멸 됩니다" /></p>
			</div>
		</div>
	</div>

	<div class="noti">
		<div class="inner">
			<h4><img src="http://webimage.10x10.co.kr/eventIMG/2016/74319/tit_noti.png" alt="이벤트 유의사항" /></h4>
			<ul>
				<li>텐바이텐 회원 대상이며, 1일 500명씩 선착순으로 발급됩니다.</li>
				<li>이벤트 기간 중 ID당 1회만 발급 받을 수 있습니다.</li>
				<li>마일리지는 3만원 이상 구매 시 사용 가능하며, 보너스쿠폰과 중복 사용이 가능합니다. (일부 상품 제외)</li>
				<li>발급 받은 마일리지는 12/25(일)까지 사용가능하며, 미사용시 12/26(월) 소멸됩니다.</li>
				<li>반품/교환/구매취소 시 사용한 마일리지는 추가 소멸됩니다.</li>
			</ul>
		</div>
	</div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->