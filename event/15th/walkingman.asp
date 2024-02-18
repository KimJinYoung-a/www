<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  [15주년] 워킹맨
' History : 2016.10.06 원승현
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%

	Dim eCode, vQuery, nowDate, userid, myAppearCnt, intLoop, intLoop2

	IF application("Svr_Info") = "Dev" THEN
		eCode   =  66215
	Else
		eCode   =  73063
	End If

	'============== 모바일 접근시 모바일 페이지 이동(referer가 10x10이면 이동안함) ============
	if InStr(request.ServerVariables("HTTP_REFERER"),"10x10.co.kr")<1 then
		if Not(Request("mfg")="pc" or session("mfg")="pc") then
			if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
				dim mRdSite: mRdSite = requestCheckVar(request("rdsite"),32)
				Response.Redirect "http://m.10x10.co.kr/event/eventmain.asp?eventid=" & eCode & chkIIF(mRdSite<>"","&rdsite=" & mRdSite,"")
				REsponse.End
			end if
		end if
	end if

	'// 아이디
	userid = getEncLoginUserid()
	'// 오늘날짜
	nowDate = Left(Now(), 10)

	If IsUserLoginOK() Then
		'// 현재 출석일수 확인
		vQuery = "SELECT count(*) FROM [db_event].[dbo].[tbl_event_subscript] WHERE evt_code = '" & eCode & "' And userid='"&userid&"' "
		rsget.CursorLocation = adUseClient
		rsget.Open vQuery, dbget, adOpenForwardOnly, adLockReadOnly
		IF Not rsget.Eof Then
			myAppearCnt = rsget(0)
		End IF
		rsget.close

		'// 출석일수 한자리일경우는 앞에 0추가
		If Len(Trim(myAppearCnt))=1 Then
			myAppearCnt = CStr("0"&myAppearCnt)
		Else
			myAppearCnt = CStr(myAppearCnt)
		End If
	Else
		myAppearCnt = CStr("00")
	End If

	'// Facebook 오픈그래프 메타태그 작성
	strHeaderAddMetaTag = "<meta property=""og:title"" content=""[텐바이텐] 15주년 워킹맨"" />" & vbCrLf &_
						"<meta property=""og:type"" content=""website"" />" & vbCrLf &_
						"<meta property=""og:url"" content=""http://www.10x10.co.kr/event/15th/walkingman.asp"" />" & vbCrLf
	
	strHeaderAddMetaTag = strHeaderAddMetaTag & "<meta property=""og:image"" content=""http://webimage.10x10.co.kr/eventIMG/2016/15th/73063/m/img_kakao.jpg"" />" & vbCrLf &_
												"<link rel=""image_src"" href=""http://webimage.10x10.co.kr/eventIMG/2016/15th/73063/m/img_kakao.jpg"" />" & vbCrLf

	strPageTitle = "[텐바이텐] 15주년 이벤트 워킹맨"
	strPageKeyword = "[텐바이텐] 15주년 이벤트"
	strPageDesc = "[텐바이텐] 이벤트 - 하루에 한 걸음 출석체크하고, 다양한 선물에 도전하세요!"
	

%>
<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
/* teN15th commen */
img {vertical-align:top;}
#contentWrap {padding:0;}
.gnbWrapV15 {height:38px;}

.teN15th .tenHeader {position:relative; height:180px; text-align:left; background:#363c7b url(http://webimage.10x10.co.kr/eventIMG/2016/15th/bg_head.gif) repeat 0 0; z-index:10;}
.teN15th .tenHeader .headCont {position:relative; width:1260px; margin:0 auto; background:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/bg_star.png) no-repeat 50% 0;}
.teN15th .tenHeader .headCont div {position:relative; width:1140px; height:180px; margin:0 auto;}
.teN15th .tenHeader h2 {padding:25px 0 0 27px;}
.teN15th .tenHeader .navigator {position:absolute; right:0; top:0; background:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/bg_line.gif) no-repeat 100% 50%;}
.teN15th .tenHeader .navigator:after {content:" "; display:block; clear:both;}
.teN15th .tenHeader .navigator li {float:left; width:120px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/bg_line.gif) no-repeat 0 50%;}
.teN15th .tenHeader .navigator li a {display:block; height:180px; background-position:0 0; background-repeat:no-repeat; text-indent:-999em;}
.teN15th .tenHeader .navigator li.nav1 a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/nav_01.png);}
.teN15th .tenHeader .navigator li.nav2 a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/nav_02.png);}
.teN15th .tenHeader .navigator li.nav3 a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/nav_03.png);}
.teN15th .tenHeader .navigator li.nav4 a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/nav_04.png);}
.teN15th .tenHeader .navigator li.nav5 a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/nav_05.png);}
.teN15th .tenHeader .navigator li.nav6 a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/nav_06.png);}
.teN15th .tenHeader .navigator li a:hover {background-position:0 -180px;}
.teN15th .tenHeader .navigator li.current a {height:192px; background-position:0 100%;}
.teN15th .noti {padding:68px 0; text-align:left; border-top:4px solid #d5d5d5; background-color:#eee;}
.teN15th .noti div {position:relative; width:1140px; margin:0 auto;}
.teN15th .noti h3 {position:absolute; left:92px; top:50%; margin-top:-37px;}
.teN15th .noti ul {padding:0 50px 0 310px;}
.teN15th .noti li {color:#666; text-indent:-10px; padding:5px 0 0 10px; line-height:18px;}
.teN15th .shareSns {height:160px; text-align:left; background:#363c7b url(http://webimage.10x10.co.kr/eventIMG/2016/15th/bg_share.png) repeat 0 0;}
.teN15th .shareSns div {position:relative; width:1140px; margin:0 auto;}
.teN15th .shareSns p {padding:70px 0 0 40px;}
.teN15th .shareSns ul {overflow:hidden; position:absolute; right:40px; top:50px;}
.teN15th .shareSns li {float:left; padding-left:40px;}

.wkMan {position:relative; padding-bottom:190px; background:#fff871 url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73063/bg_road.png) no-repeat 50% 349px; text-align:center;}

.titSection {position:relative; width:1140px; margin:0 auto; padding-top:85px;}
.titSection .title {overflow:hidden; width:499px; margin:0 auto;}
.titSection .title h2, .titSection .title i {float:left;}
.titSection .myCounting {display:table; overflow:hidden; position:absolute; left:50%; top:131px; width:214px; height:160px; margin-left:254px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73063/frame_mycounting.png) no-repeat 50% 50%; text-align:left;}
.titSection .myCounting strong {width:70px; padding:33px 0 0 38px;}
.titSection .myCounting strong, .myCounting .dailyCount {display:table-cell; text-align:left;}
.titSection .myCounting .dailyCount {font-family:"malgun Gothic","맑은고딕", Dotum, "돋움", sans-serif; font-size:56px; color:#000; font-weight:bold; letter-spacing:-0.05em; vertical-align:top;}

.boardSection {position:relative; width:1140px; height:560px; margin:110px auto 0; padding-top:200px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73063/bg_board.png) no-repeat 50% 0;}
.boardSection .giftBox {position:relative;}
.boardSection .giftBox button {background-color:transparent; z-index:10;}
.boardSection .giftBox .countAct {position:absolute; left:50%; top:215px; margin-left:-166px; outline:none;}
.boardSection .giftBox .btnGiftView {position:absolute; left:50%; top:0; width:360px; height:195px; margin-left:-156px; text-align:right; outline:none; animation:bounce infinite 1.7s 1s; -webkit-animation:bounce infinite 1.7s 1s;}
.boardSection .giftBox span {display:block; position:absolute; left:50%; background-repeat:no-repeat;}
.boardSection .giftBox span.spark1 {top:162px; width:83px; height:83px; margin-left:-247px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73063/deco_spark1.png); background-position:0 0; animation:spark 20 2.2s 0s; -webkit-animation:spark 20 2.2s 0s;}
.boardSection .giftBox span.spark2 {top:118px; width:103px; height:103px; margin-left:150px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73063/deco_spark2.png); background-position:100% 0; animation:spark 20 2s 1s; -webkit-animation:spark 20 2s 1s;}
@keyframes shake {
	0%, 25%, 55%, 100% {transform:translateX(0);}
	10%, 40% {transform:translateY(-3px);}
}
.shake {animation:shake 1.2s infinite both; -webkit-animation:shake 1.2s infinite both;}
@keyframes bounce {
	from, to{margin-top:0; animation-timing-function:ease-in;}
	50% {margin-top:5px; animation-timing-function:ease-out;}
}
.bounce {animation:bounce 20 2s 5s both alternate;}
@keyframes spark {
	from {opacity:0;}
	to {opacity:1;}
}
.filmLight {animation:spark 20 .15s 2.7s; -webkit-animation:spark 20 .15s 2.7s;}

.walkBoard li {display:table; position:absolute; width:127px; height:127px; background-position:50% 50%; background-repeat:no-repeat;}
.walkBoard li div {display:table-cell; position:relative; width:100%; height:100%; vertical-align:middle;}
.walkBoard li div:after {display:none; width:100%; height:100%; position:absolute; left:0; top:0; content:''; background:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73063/bg_day_finish.png) no-repeat 50% 50%;}
.walkBoard li div strong {overflow:hidden; display:block; position:absolute; left:50%; bottom:18px; width:98px; height:168px; margin-left:-49px; text-indent:-999em; background:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73063/walkingman.png) no-repeat 50% 100%; z-index:100; opacity:0; filter:alpha(opacity=0);}
.walkBoard li.done div:after {display:block; z-index:50; height:127px;}
.walkBoard li.done div strong {display:none;}
.walkBoard li.done.step03 div p, .walkBoard li.done.step05 div p, .walkBoard li.done.step08 div p,
.walkBoard li.done.step11 div p, .walkBoard li.done.step13 div p, .walkBoard li.done.step15 div p {display:none;}
.walkBoard li.current div strong {display:block; opacity:1; filter:alpha(opacity=100);}
.walkBoard li.current div p {display:none;}
.walkBoard li.step00 {left:0; top:0; width:253px;}
.walkBoard li.step00 div {padding:0 50px 0 0;}
.walkBoard li.step00 div:after {display:none;}
.walkBoard li.step00 div strong {margin-left:14px;}
.walkBoard li.step00 div .decoArrow {display:block; position:absolute; left:23px; top:54px; width:35px; height:17px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73063/deco_arrow.png) 0 0 repeat-x;}
.walkBoard li.step00.current div p {display:block;}
.walkBoard li.step01 {left:253px; top:0;}
.walkBoard li.step02 {left:380px; top:0;}
.walkBoard li.step03 {left:507px; top:-58px; width:253px; height:185px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73063/bg_day03.png); background-position:43px 0;}
.walkBoard li.step03 div {padding-top:105px;}
.walkBoard li.step03 div:after {height:185px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73063/bg_day03_finish.png) no-repeat 50% 50%;}
.walkBoard li.step03 div i, .walkBoard li.step11 div i {position:absolute; display:block; width:23px; height:23px;}
.walkBoard li.step03 div i.coin1, .walkBoard li.step11 div i.coin1 {left:50px; bottom:73px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73063/deco_coin.png) 50% 50% no-repeat; animation:rotation 1 .7s 0s running; -webkit-animation:rotation 1 .7s 0s running;}
.walkBoard li.step03 div i.coin2, .walkBoard li.step11 div i.coin2 {left:30px; bottom:73px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73063/deco_coin2.png) 50% 50% no-repeat; animation:rotation 1 .8s 0.7s running; -webkit-animation:rotation 1 .8s 0.7s running;}
.walkBoard li.step04 {left:760px; top:0;}
.walkBoard li.step05 {left:887px; top:0; width:253px; height:253px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73063/bg_day05.png); background-position:31px 32px;}
.walkBoard li.step05 div {padding:0 0 126px 126px;}
.walkBoard li.step05 div:after {height:253px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73063/bg_day05_finish.png) no-repeat 50% 50%;}
.walkBoard li.step05 div strong {margin-left:14px; bottom:144px;}
.walkBoard li.step05 div .car1 {display:block; position:absolute; left:72px; bottom:32px; width:140px; height:53px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73063/deco_car1.png) 50% 50% no-repeat;}
.walkBoard li.step06 {left:1013px; top:253px;}
.walkBoard li.step07 {left:1013px; top:380px;}
.walkBoard li.step08 {left:887px; top:507px; width:253px; height:253px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73063/bg_day08.png); background-position:18px 12px;}
.walkBoard li.step08 div {padding:126px 0 0 126px;}
.walkBoard li.step08 div:after {height:253px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73063/bg_day08_finish.png) no-repeat 50% 50%;}
.walkBoard li.step08 div strong {margin-left:14px;}
.walkBoard li.step08 div .film {display:block; position:absolute; left:85px; bottom:40px; width:43px; height:55px; padding:4px 0 0 35px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73063/deco_film.png) 0 0 no-repeat;}
.walkBoard li.step08 div .film i {display:block; width:43px; height:28px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73063/deco_film_light.png) 0 0 no-repeat;}
.walkBoard li.step09 {left:760px; top:633px;}
.walkBoard li.step10 {left:633px; top:633px;}
.walkBoard li.step11 {left:380px; top:575px; width:253px; height:185px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73063/bg_day03.png); background-position:43px 0;}
.walkBoard li.step11 div {padding-top:105px;}
.walkBoard li.step11 div:after {height:185px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73063/bg_day03_finish.png) no-repeat 50% 50%;}
.walkBoard li.step12 {left:253px; top:633px;}
.walkBoard li.step13 {left:0; top:450px; width:253px; height:310px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73063/bg_day05.png); background-position:111px 0;}
.walkBoard li.step13 div {padding:183px 126px 0 0;}
.walkBoard li.step13 div:after {height:310px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73063/bg_day13_finish.png) no-repeat 50% 50%;}
.walkBoard li.step13 div strong {margin-left:-112px;}
.walkBoard li.step13 div .car2 {display:block; position:absolute; left:88px; bottom:114px; width:140px; height:53px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73063/deco_car2.png) 50% 50% no-repeat;}
.walkBoard li.step14 {left:0; top:380px;;}
.walkBoard li.step14 div:after {background:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73063/bg_day14_finish.png) no-repeat 50% 50%;}
.walkBoard li.step15 {left:0; top:127px; height:253px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73063/bg_day15.gif); background-position:50% 0;}
.walkBoard li.step15 div {padding-top:105px;}
.walkBoard li.step15 div:after {height:253px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73063/bg_day15_finish.png) no-repeat 50% 50%;}
.walkBoard li.step15 div .balloon {display:block; position:absolute; left:92px; top:-33px; width:63px; height:87px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73063/deco_balloon.png) 50% 50% no-repeat;}

.walkBoard li.step05 div strong, .walkBoard li.step06 div strong,
.walkBoard li.step07 div strong, .walkBoard li.step08 div strong,
.walkBoard li.step09 div strong, .walkBoard li.step10 div strong,
.walkBoard li.step11 div strong, .walkBoard li.step12 div strong {background:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73063/walkingman2.png) no-repeat 50% 100%;}

@keyframes bgMotion {
	from {background-position:0 0;}
	to {background-position:10px 0;}
}
.bgMotion {animation:bgMotion infinite .5s 0s both running; -webkit-animation:bgMotion infinite .5s 0s both running;}
@keyframes rotation {
	0% {transform:rotate(-200deg);}
	100% {transform:rotate(0);}
}

.lyrClose {overflow:hidden; position:absolute; z-index:50; width:60px; height:60px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73063/btn_lyr_close.png) 50% 50% no-repeat; text-indent:-999em; outline:none;}
.giftView {display:none; position:fixed; top:50% !important; left:50% !important; width:1072px; height:809px; margin:-405px 0 0 -536px;}
.giftView > div {position:relative; width:100%; height:100%;}
.giftView .lyrClose {right:28px; top:15px;}

.giftLyr {display:none; position:fixed; top:50% !important; left:50% !important; z-index:60;}
.giftLyr > div {position:relative; width:100%; height:100%;}
.giftLyr .lyrClose {right:23px; top:10px;}
.btnGoLink {overflow:hidden; position:absolute; left:50%; bottom:36px; width:90%; height:141px; margin-left:-45%; text-indent:-999em; outline:none; background-color:rgba(255,255,255,0);}
.code {position:absolute; left:0; bottom:40px; width:100%; color:#ccc; text-align:center; font-size:10px; font-family:verdana, tahoma, sans-serif;}

#lyr01m, #lyr03f, #lyr04c, #lyr05h {width:508px; height:628px; margin:-314px 0 0 -254px;} /* 마일리지은행, 비당첨, 영화관, 선물의집 */
#lyr02g, #lyr06t {width:748px; height:628px; margin:-314px 0 0 -374px;} /* 당첨 사은품 */
#lyr00e {width:918px; height:628px; margin:-314px 0 0 -459px;} /* 출석 끝 */
</style>
<script type="text/javascript">
$(function(){

	<%'// 현재 맨 위치 계산 %>
	<% for intLoop=0 to 15 %>
		<% if intLoop < 10 then %>
			$("#step0<%=intLoop%>").removeClass('current');
			$("#step0<%=intLoop%>").removeClass('done');
		<% else %>
			$("#step<%=intLoop%>").removeClass('current');
			$("#step<%=intLoop%>").removeClass('done');
		<% end if %>
	<% next %>
	<% for intLoop2=0 to cint(myAppearCnt) %>
		<% if intLoop2 < 10 then %>
			$("#step0<%=intLoop2%>").addClass('done');
		<% else %>
			$("#step<%=intLoop2%>").addClass('done');
		<% end if %>
	<% next %>

	<% if cint(myAppearCnt)=15 then %>
		$(".countAct").attr('disabled','disabled'); 
		$(".countAct").children('img').attr('src','http://webimage.10x10.co.kr/eventIMG/2016/15th/73063/btn_action_finish.png');
		$(".countAct").children('img').attr('alt','출석끝');
		$(".countAct").removeClass('shake');
	<% else %>
		$("#step<%=myAppearCnt%>").removeClass('done');
		$("#step<%=myAppearCnt%>").addClass('current');
	<% end if %>

	/* START 모션 추가 */
	if($('.walkBoard li.step00').hasClass('current')) {
		$(this).find('.decoArrow').addClass('bgMotion');
	}

	$(".countAct").click(function() {
		<% If not(IsUserLoginOK()) Then %>
			if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
				location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/15th/walkingman.asp")%>';
				return;
			}
		<% end if %>

		<% If not(nowDate >= "2016-10-10" and nowDate < "2016-10-25") Then %>
			alert("이벤트 응모기간이 아닙니다.");
			return;
		<% end if %>
		$(".countAct").attr('disabled','disabled').removeClass('shake');
		$('.walkBoard li').each(function(){
			if($(this).hasClass('current')) {
				<%'// 현재위치 index값 받기%>
				var nowPos = $(this).index();
//				console.log(nowPos);
				if ((nowPos==0)) {
					<%'// 1로 이동%>
					setAppearAc("ins", nowPos, "nomal1");

					<%'// 현재 위치값 0 %>
					$(this).children('div').children('strong').animate({"margin-left":"141px", "opacity":"1"},1000);
				} 
				else if ((nowPos==1)) 
				{
					<%'// 2로 이동%>
					setAppearAc("ins", nowPos, "nomal2");

					<%'// 현재 위치값 1 %>
					$(this).children('div').children('strong').animate({"margin-left":"78px", "opacity":"1"},1000);
				} 
				else if ((nowPos==2)) 
				{
					<%'// 3(첫번째 100마일리지 신청)으로 이동%>
					setAppearAc("ins", nowPos, "mileage1");

					<%'// 현재 위치값 2(여기서 3번 마일리지 신청에 대한 액션 처리) %>
					$(this).children('div').children('strong').animate({"margin-left":"141px", "opacity":"1"},1000);
				} 
				else if ((nowPos==3)) 
				{
					<%'// 4로 이동%>
					setAppearAc("ins", nowPos, "nomal4");

					<%'// 현재 위치값 3 %>
					$(this).children('div').children('strong').animate({"margin-left":"141px", "opacity":"1"},1000);

				} 
				else if ((nowPos==4)) 
				{
					<%'// 5(첫번째 경품응모)로 이동%>
					setAppearAc("ins", nowPos, "gift1");

					<%'// 현재 위치값 4(여기서 5번 경품 응모에 대한 액션 처리 %>
					$(this).children('div').children('strong').animate({"margin-left":"204px", "opacity":"1"},1000);

				} 
				else if ((nowPos==5)) 
				{
					<%'// 6으로 이동%>
					setAppearAc("ins", nowPos, "nomal6");

					<%'// 현재 위치값 5 %>
					$(this).children('div').children('strong').animate({"margin-bottom":"-253px", "opacity":"1"},1000);
				} 
				else if ((nowPos==6)) 
				{
					<%'// 7으로 이동%>
					setAppearAc("ins", nowPos, "nomal7");

					<%'// 현재 위치값 6 %>
					$(this).children('div').children('strong').animate({"margin-bottom":"-127px", "opacity":"1"},1000);

				}
				else if ((nowPos==7)) 
				{
					<%'// 8(cgv 이용권 응모)으로 이동%>
					setAppearAc("ins", nowPos, "cgv");

					<%'// 현재 위치값 7(여기서 cgv주말 이용권 응모에 대한 액션 처리 %>
					$(this).children('div').children('strong').animate({"margin-bottom":"-253px", "opacity":"1"},1000);
				}				
				else if ((nowPos==8)) 
				{
					<%'// 9으로 이동%>
					setAppearAc("ins", nowPos, "nomal9");

					<%'// 현재 위치값 8 %>
					$(this).children('div').children('strong').animate({"margin-left":"-240px", "opacity":"1"},1000);

				} 
				else if ((nowPos==9)) 
				{
					<%'// 10으로 이동%>
					setAppearAc("ins", nowPos, "nomal10");

					<%'// 현재 위치값 9 %>
					$(this).children('div').children('strong').animate({"margin-left":"-174px", "opacity":"1"},1000);

				} 
				else if ((nowPos==10)) 
				{
					<%'// 11(두번째 100마일리지 신청)으로 이동%>
					setAppearAc("ins", nowPos, "mileage2");

					<%'// 현재 위치값 10(여기서 마일리지 신청에 대한 액션 처리) %>
					$(this).children('div').children('strong').animate({"margin-left":"-238px", "opacity":"1"},1000);
				} 
				else if ((nowPos==11)) 
				{
					<%'// 12로 이동%>
					setAppearAc("ins", nowPos, "nomal12");

					<%'// 현재 위치값 11 %>
					$(this).children('div').children('strong').animate({"margin-left":"-238px", "opacity":"1"},1000);
				} 
				else if ((nowPos==12)) 
				{
					<%'// 13(두번째 경품응모)으로 이동%>
					setAppearAc("ins", nowPos, "gift2");

					<%'// 현재 위치값 12(여기서 두번째 경품응모) %>
					$(this).children('div').children('strong').animate({"margin-left":"-303px", "opacity":"1"},1000);
				} 
				else if ((nowPos==13)) 
				{
					<%'// 14로 이동%>
					setAppearAc("ins", nowPos, "nomal14");

					<%'// 현재 위치값 13 %>
					$(this).children('div').children('strong').animate({"margin-bottom":"253px", "opacity":"1"},1000);
				} 
				else if ((nowPos==14)) 
				{
					<%'// 15(마지막 500마일리지 신청)로 이동%>
					setAppearAc("ins", nowPos, "mileage3");

					<%'// 현재 위치값 14(마지막 출첵) %>
					$(this).children('div').children('strong').animate({"margin-bottom":"127px", "opacity":"0"},1000);
					viewPoupLayer('modal',$('#giftLyr').html()); /* 레이어 띄우기 */
					/* 출석하기 버튼 비활성화 */
					$(".countAct").attr('disabled','disabled'); 
					$(".countAct").children('img').attr('src','http://webimage.10x10.co.kr/eventIMG/2016/15th/73063/btn_action_finish.png');
					$(".countAct").children('img').attr('alt','출석끝');
					$(".countAct").removeClass('shake');
				} 
				else 
				{
					$(this).children('div').children('strong').animate({"margin-left":"78px", "opacity":"1"},1000);
				}

				$(this).removeClass('current');
				setTimeout(function(){
					if ((nowPos==14)) {
						$('.walkBoard li').eq(nowPos).addClass('done');
						$('.walkBoard li').eq(nowPos+1).addClass('done');
					} else {
						$('.walkBoard li').eq(nowPos).addClass('done'); /* 출석완료 레이어 씌우기 */
						$('.walkBoard li').eq(nowPos+1).addClass('current'); /* 다음칸 이동(현재위치에 클래스 current 추가) */
						$('.walkBoard li.step00').find('.decoArrow').removeClass('bgMotion'); /* START 모션 제거 */
					}
				}, 1000);
			}
		});
	});

	/* animation */
	coinAnimation();
	carAnimation();
	lightAnimation();
	balloonAnimation();

	$(".step03 .coin1, .step03 .coin2, .step11 .coin1, .step11 .coin2").css({"left":"-23px", "opacity":"0"});
	function coinAnimation() {
		$(".step03 .coin1").delay(50).animate({"left":"50px", "opacity":"1"}, 700);
		$(".step03 .coin2").delay(700).animate({"left":"30px", "opacity":"1"}, 800);
		$(".step11 .coin1").delay(2800).animate({"left":"50px", "opacity":"1"}, 700);
		$(".step11 .coin2").delay(3500).animate({"left":"30px", "opacity":"1"}, 800);
	};
	$(".step05 .car1").css({"left":"200px", "opacity":"0"});
	$(".step13 .car2").css({"left":"0", "opacity":"0"});
	function carAnimation() {
		$(".step05 .car1").delay(1500).animate({"left":"72px", "opacity":"1"}, 1200);
		$(".step13 .car2").delay(4300).animate({"left":"88px", "opacity":"1"}, 1300);
	}
	function lightAnimation() {
		$(".step08 .film i").addClass('filmLight');
	}
	function balloonAnimation() {
		$(".step15 .balloon").addClass('bounce');
	}
});

function setAppearAc(mode, nowpos, act)
{
	<%'// 폼값에 넣음 %>
	$("#mode").val(mode);
	$("#nowpos").val(nowpos);
	$("#act").val(act);

	$.ajax({
		type:"GET",
		url:"/event/15th/doeventsubscript/dowalkingman.asp",
		data: $("#frmAppearPrd").serialize(),
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
							if (mode=="ins")
							{
								if (res[2]!="")
								{
									$("#giftLyr").empty().html(res[2]);
									viewPoupLayer('modal',$('#giftLyr').html());
								}
								else
								{
									setTimeout(function(){alert("내일 또 걸어주세요!\n다양한 선물이 당신을 기다립니다!");}, 1000);
								}
								$("#dCnt").empty().html(res[1]);
								$(".countAct").attr('disabled',false).addClass('shake');
								return false;
							}
						}
						else
						{
							errorMsg = res[1].replace(">?n", "\n");
							alert(errorMsg);
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

<%'// 경품, cgv영화권 응모 %>
function getAppearGift(mode, nowpos, act)
{
	<%'// 폼값에 넣음 %>
	$("#mode").val(mode);
	$("#nowpos").val(nowpos);
	$("#act").val(act);

	$.ajax({
		type:"GET",
		url:"/event/15th/doeventsubscript/dowalkingman.asp",
		data: $("#frmAppearPrd").serialize(),
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
							if (mode=="gift1")
							{
								$("#giftLyr").empty().html(res[1]);
								viewPoupLayer('modal',$('#giftLyr').html());
								return false;
							}
							else if (mode=="cgv")
							{
								$("#giftLyr").empty().html(res[1]);
								viewPoupLayer('modal',$('#giftLyr').html());
								return false;
							}
							else if (mode=="gift2")
							{
								$("#giftLyr").empty().html(res[1]);
								viewPoupLayer('modal',$('#giftLyr').html());
								return false;
							}
						}
						else
						{
							errorMsg = res[1].replace(">?n", "\n");
							alert(errorMsg);
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
</script>
</head>
<body>
<div id="eventDetailV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container fullEvt"><%' for dev msg : 왼쪽메뉴(카테고리명) 사용시 클래스 : partEvt / 왼쪽메뉴(카테고리명) 사용 안할때 클래스 : fullEvt %>
		<div id="contentWrap">
			<div class="eventWrapV15">
				<!--div class="evtHead snsArea">
					<dl class="evtSelect ftLt">
						<dt><span>이벤트 더보기</span></dt>
						<dd>
							<ul>
								<li><strong>엔조이 이벤트 전체 보기</strong></li>
								<li>나는 모은다 고로 존재한다</li>
								<li>일년 열두달 매고 싶은, 플래그쉽 플래그쉽</li>
								<li>시어버터 보습막을 입자</li>
								<li>전국민 블루투스 키보드</li>
								<li>데스크도 여름 정리가 필요해 필요해 필요해</li>
								<li>지금 놀이터 갈래요!</li>
								<li>ELLY FACTORY</li>
								<li>폴프랭크 카메라</li>
								<li>폴프랭크 카메라</li>
								<li>폴프랭크 카메라</li>
							</ul>
						</dd>
					</dl>
					<div class="ftRt">
						<a href="" class="ftLt btn btnS2 btnGrylight"><em class="gryArr01">브랜드 전상품 보기</em></a>
						<div class="sns lMar10">
							<ul>
								<li><a href="#"><img src="http://fiximage.10x10.co.kr/web2013/common/sns_me2day.gif" alt="미투데이" /></a></li>
								<li><a href="#"><img src="http://fiximage.10x10.co.kr/web2013/common/sns_twitter.gif" alt="트위터" /></a></li>
								<li><a href="#"><img src="http://fiximage.10x10.co.kr/web2013/common/sns_facebook.gif" alt="페이스북" /></a></li>
								<li><a href="#"><img src="http://fiximage.10x10.co.kr/web2013/common/sns_pinterest.gif" alt="핀터레스트" /></a></li>
							</ul>
							<div class="favoriteAct myFavor"><strong>123</strong></div>
						</div>
					</div>
				</div-->

				<div class="eventContV15">
					<%' event area(이미지만 등록될때 / 수작업일때) %>
					<div class="contF contW">
						<%' 15주년 이벤트 : 워킹맨 %>
						<div class="teN15th">
							<div class="tenHeader">
								<div class="headCont">
									<div>
										<h2><a href="/event/15th/"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/tit_ten_15th.png" alt="teN15th 텐바이텐의 다양한 이야기" /></a></h2>
										<ul class="navigator">
											<li class="nav1"><a href="/event/15th/">최대 40% 쿠폰 받기 [teN15th]</a></li>
											<li class="nav2 current"><a href="/event/15th/walkingman.asp">매일 매일 출석체크 [워킹맨]</a></li>
											<li class="nav3"><a href="/event/15th/discount.asp">할인에 도전하라 [비정상할인]</a></li>
											<li class="nav4"><a href="/event/15th/gift.asp">팡팡 터지는 구매사은품 [사은품을 부탁해]</a></li>
											<li class="nav5"><a href="/event/15th/sns.asp">영상을 공유하라 [전국 영상자랑]</a></li>
											<li class="nav6"><a href="/event/15th/tv.asp">일상을 담아라 [나의 리틀텔레비전]</a></li>
										</ul>
									</div>
								</div>
							</div>

							<div class="wkMan">
								<div class="titSection">
									<div class="title">
										<h2><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73063/tit_wkman.png" alt="뛰지말고 걸어아! 워킹맨!" /></h2>
										<i><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73063/ico_char.gif" alt="워킹맨!" /></i>
									</div>
									<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73063/txt_wkman_desp.png" alt="하루에 한 걸음씩 출석체크 하고, 다양한 선물에 도전하세요!" /></p>
									<div class="myCounting">
										<strong><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73063/txt_mycounting.png" alt="나의 출석일 수" /></strong>
										<div class="dailyCount" id="dCnt"><%=myAppearCnt%></div> <%'for dev msg : 출석일 수 표시 %>
									</div>
								</div>

								<div class="boardSection">
									<div class="giftBox">
										<button type="button" class="countAct shake"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73063/btn_action.png" alt="출석하기" /></button>
										<button type="button" class="btnGiftView" onclick="viewPoupLayer('modal',$('#giftView').html());return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73063/btn_gift_view.png" alt="사은품 보러가기" /></button>
										<img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73063/img_gift.png" alt="사은품박스" />
										<span class="spark1"></span><span class="spark2"></span>
									</div>
									<div id="giftView">
										<div class="giftView window">
											<div>
												<img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73063/img_lyr_gift_list_v1.png" alt="당첨 상품 리스트" />
												<button type="button" onclick="ClosePopLayer()" class="lyrClose">닫기</button>
											</div>
										</div>
									</div>

									<ul class="walkBoard">
										<li class="dayBlock step00 " id="step00">
											<div>
												<strong>START 지점에 워킹맨이 있습니다.</strong>
												<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73063/txt_start.png" alt="START" /></p>
												<span class="decoArrow"></span>
											</div>
										</li>
										<li class="dayBlock step01 " id="step01">
											<div>
												<strong>step01 에 워킹맨이 있습니다.</strong>
												<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73063/txt_day01.png" alt="01" /></p>
											</div>
										</li>
										<li class="dayBlock step02 " id="step02">
											<div>
												<strong>step02 에 워킹맨이 있습니다.</strong>
												<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73063/txt_day02.png" alt="02" /></p>
											</div>
										</li>
										<li class="dayBlock step03 " id="step03">
											<div>
												<strong>step03 에 워킹맨이 있습니다.</strong>
												<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73063/txt_day03.png" alt="100마일리지신청" /></p>
												<i class="coin1"></i><i class="coin2"></i>
											</div>
										</li>
										<li class="dayBlock step04 " id="step04">
											<div>
												<strong>step04 에 워킹맨이 있습니다.</strong>
												<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73063/txt_day04.png" alt="04" /></p>
											</div>
										</li>
										<li class="dayBlock step05 " id="step05">
											<div>
												<strong>step05 에 워킹맨이 있습니다.</strong>
												<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73063/txt_day05.png" alt="경품응모" /></p>
												<span class="car1"></span>
											</div>
										</li>
										<li class="dayBlock step06 " id="step06">
											<div>
												<strong>step06 에 워킹맨이 있습니다.</strong>
												<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73063/txt_day06.png" alt="06" /></p>
											</div>
										</li>
										<li class="dayBlock step07 " id="step07">
											<div>
												<strong>step07 에 워킹맨이 있습니다.</strong>
												<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73063/txt_day07.png" alt="07" /></p>
											</div>
										</li>
										<li class="dayBlock step08 " id="step08">
											<div>
												<strong>step08 에 워킹맨이 있습니다.</strong>
												<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73063/txt_day08.png" alt="CGV 주말 이용권 응모" /></p>
												<span class="film"><i></i></span>
											</div>
										</li>
										<li class="dayBlock step09 " id="step09">
											<div>
												<strong>step09 에 워킹맨이 있습니다.</strong>
												<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73063/txt_day09.png" alt="09" /></p>
											</div>
										</li>
										<li class="dayBlock step10 " id="step10">
											<div>
												<strong>step10 에 워킹맨이 있습니다.</strong>
												<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73063/txt_day10.png" alt="10" /></p>
											</div>
										</li>
										<li class="dayBlock step11 " id="step11">
											<div>
												<strong>step11 에 워킹맨이 있습니다.</strong>
												<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73063/txt_day03.png" alt="100마일리지신청" /></p>
												<i class="coin1"></i><i class="coin2"></i>
											</div>
										</li>
										<li class="dayBlock step12 " id="step12">
											<div>
												<strong>step12 에 워킹맨이 있습니다.</strong>
												<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73063/txt_day12.png" alt="12" /></p>
											</div>
										</li>
										<li class="dayBlock step13" id="step13">
											<div>
												<strong>step13 에 워킹맨이 있습니다.</strong>
												<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73063/txt_day05.png" alt="경품응모" /></p>
												<span class="car2"></span>
											</div>
										</li>
										<li class="dayBlock step14" id="step14">
											<div>
												<strong>step14 에 워킹맨이 있습니다.</strong>
												<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73063/txt_day14.png" alt="14" /></p>
											</div>
										</li>
										<li class="dayBlock step15" id="step15">
											<div>
												<strong>step15 에 워킹맨이 있습니다.</strong>
												<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73063/txt_day15.png" alt="500마일리지 신청" /></p>
												<span class="balloon"></span>
											</div>
										</li>
									</ul>
								</div>

								<%' layer %>
								<div id="giftLyr"></div>
							</div>
							<%' 이벤트 유의사항 %>
							<div class="noti">
								<div>
									<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/tit_noti.png" alt="이벤트 유의사항" /></h3>
									<ul>
										<li>- 본 이벤트는 ID당 하루에 한 번 다음 칸으로 이동할 수 있습니다.</li>
										<li>- 경품응모를 하지 않고 팝업 창을 닫았을 시(오류로 인한 종료포함) 다시 응모할 수 없습니다.</li>
										<li>- 당첨된 상품 및 마일리지는 10월 26일(수요일) 일괄 배송 혹은 지급예정입니다.</li>
										<li>- 5만원 이상의 상품에 당첨되신 분께는 세무신고를 위해 개인정보를 요청할 수 있으며, 제세공과금은 텐바이텐 부담입니다.</li>
										<li>- 이벤트 내 모든 상품의 컬러는 랜덤으로 발송되며, 선택할 수 없습니다.</li>
										<li>- 경품을 통해 받은 사은품은 재판매 혹은 현금성 거래가 불가 합니다.</li>
									</ul>
								</div>
							</div>
							<%' sns 공유 %>
							<%
								'// 쇼셜서비스로 글보내기 (2010.07.21; 허진원)
								Dim vTitle, vLink, vPre, vImg
								
								dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
								snpTitle = Server.URLEncode("[텐바이텐] 15주년 이벤트 워킹맨")
								snpLink = Server.URLEncode("http://www.10x10.co.kr/event/15th/walkingman.asp")
								snpPre = Server.URLEncode("10x10 이벤트")
								
								'기본 태그
								snpTag = Server.URLEncode("텐바이텐")
								snpTag2 = Server.URLEncode("#10x10")
							%>
							<div class="shareSns">
								<div>
									<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/txt_share.png" alt="텐바이텐 15주년 이야기, 친구와 함께라면!" /></p>
									<ul>
										<li><a href="" onclick="popSNSPost('fb','<%=strPageTitle%>','<%=snpLink%>','','');return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/btn_facebook.png" alt="텐바이텐 15주년 이야기 페이스북으로 공유" /></a></li>
										<li><a href="" onclick="popSNSPost('tw','<%=strPageTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>'); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/btn_twitter.png" alt="텐바이텐 15주년 이야기 트위터로 공유" /></a></li>
									</ul>
								</div>
							</div>
						</div>
					</div>
					<%' //event area(이미지만 등록될때 / 수작업일때) %>
				</div>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
<form name="frmAppearPrd" id="frmAppearPrd" method="get">
	<input type="hidden" name="mode" id="mode">
	<input type="hidden" name="nowpos" id="nowpos">
	<input type="hidden" name="act" id="act">
</form>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->