<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/classes/item/iteminfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventCls.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
'####################################################
' Description : 내 친구를 소개합니다.
' History : 2017-03-30 원승현
'####################################################
dim nowDate , i, vUserID, eCode, j, UserAppearChkCnt
	nowDate = Left(Now(), 10)
	'nowDate = "2017-04-17"

	'============== 모바일 접근시 모바일 페이지 이동(referer가 10x10이면 이동안함) ============
if InStr(request.ServerVariables("HTTP_REFERER"),"10x10.co.kr")<1 then
	if Not(Request("mfg")="pc" or session("mfg")="pc") then
		if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
			dim mRdSite: mRdSite = requestCheckVar(request("rdsite"),32)
			Response.Redirect "http://m.10x10.co.kr/event/eventmain.asp?eventid=77061" & chkIIF(mRdSite<>"","&rdsite=" & mRdSite,"")
			REsponse.End
		end if
	end if
end if

	IF application("Svr_Info") = "Dev" THEN
		eCode   =  66296
	Else
		eCode   =  77061 
	End If

	vUserID = GetEncLoginUserID()


	'// 사용자가 해당일자에 참여했는지 확인
	Function evtFriendUserAppearChk(evt_code, uid, dateval)
		Dim vQuery
		vQuery = "SELECT count(*) FROM [db_event].[dbo].[tbl_event_subscript] WHERE evt_code = '" & evt_code & "' And userid='"&uid&"' And convert(varchar(10), regdate, 120) = '"&dateval&"' "
		rsget.CursorLocation = adUseClient
		rsget.Open vQuery, dbget, adOpenForwardOnly, adLockReadOnly
		IF Not rsget.Eof Then
			evtFriendUserAppearChk = rsget(0)
		End IF
		rsget.close
	End Function

%>
<!-- #include virtual="/event/2017props/sns.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- <base href="http://www.10x10.co.kr/"> -->
<style type="text/css">
.myFriend {overflow:hidden; background:url(http://webimage.10x10.co.kr/eventIMG/2017/sopum/77061/bg_zigzag.gif) 0 0 repeat;}
.myFriend .section1 {position:relative; height:880px;}
.myFriend .section1 .title {position:relative; width:806px; margin:0 auto;}
.myFriend .section1 .title h3 {position:absolute; left:0; top:98px; width:100%; height:100px;}
.myFriend .section1 .title h3 span {overflow:hidden; display:block; position:absolute; top:0; height:96px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/sopum/77061/tit_introduce_v2.png); text-indent:-999em;}
.myFriend .section1 .title h3 span.letter1 {right:480px; width:303px;}
.myFriend .section1 .title h3 span.letter2 {left:478px; width:350px; background-position:100% 0;}
.myFriend .section1 .title .once {position:absolute; left:50%; top:234px; margin-left:-136px;}
.myFriend .section1 .title .character {position:absolute; left:50%; top:30px; margin-left:-72px;}
.myFriend .section1 .selectCard {animation:bounce 1s 50;}
.myFriend .section1 .cardList {position:absolute; left:50%; top:387px; width:1140px; height:251px; margin-left:-570px;}
.myFriend .section1 .cardList  ul {height:251px; padding-bottom:78px;}
.myFriend .section1 .cardList li {position:absolute; top:0; padding:0 6px 4px; background-position:50% 100%; background-repeat:no-repeat; cursor:pointer;}
.myFriend .section1 .cardList li.card1 {left:24px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/sopum/77061/bg_shadow_1.png);}
.myFriend .section1 .cardList li.card2 {left:246px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/sopum/77061/bg_shadow_2.png);}
.myFriend .section1 .cardList li.card3 {left:469px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/sopum/77061/bg_shadow_3.png);}
.myFriend .section1 .cardList li.card4 {left:685px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/sopum/77061/bg_shadow_4.png);}
.myFriend .section1 .cardList li.card5 {left:884px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/sopum/77061/bg_shadow_5.png);}
.myFriend .section1 .cardList li span {position:relative; top:0; transition:all .4s;}
.myFriend .section1 .cardList li:hover span {top:-44px;}
.myFriend .section1 .deco div {position:absolute; left:50%; background-position:0 0; background-repeat:no-repeat;}
.myFriend .section1 .deco .d1 {top:152px; width:324px; height:262px; margin-left:-843px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/sopum/77061/img_deco_1.png); animation:rotate 2s 1.5s 1;}
.myFriend .section1 .deco .d2 {top:189px; width:118px; height:240px; margin-left:-870px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/sopum/77061/img_deco_2.png);}
.myFriend .section1 .deco .d3 {top:382px; width:215px; z-index:30; height:163px; margin-left:-800px;background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/sopum/77061/img_deco_3.png);}
.myFriend .section1 .deco .d4 {top:92px; width:356px; height:242px; margin-left:500px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/sopum/77061/img_deco_4.gif);}
.myFriend .section1 .deco .d5 {top:238px; width:306px; height:314px; margin-left:650px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/sopum/77061/img_deco_5.png);}
.myFriend .section2 {position:relative; padding:115px 0 93px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/sopum/77061/bg_zigzag_2.gif) 0 0 repeat;}
.myFriend .section2 .showcase {position:relative; z-index:5; width:1168px; height:752px; margin:0 auto; background:url(http://webimage.10x10.co.kr/eventIMG/2017/sopum/77061/bg_showcase_v1.png) 50% 0 no-repeat;}
.myFriend .section2 .showcase h4 {padding:24px 0 47px; line-height:30px;}
.myFriend .section2 .showcase ul {width:1070px; height:630px; margin:0 auto;}
.myFriend .section2 .showcase li {float:left; width:190px; height:190px; margin:0 10px 20px;}
.myFriend .section2 .showcase li.date0403,.myFriend .section2 .showcase li.date0407,
.myFriend .section2 .showcase li.date0408,.myFriend .section2 .showcase li.date0412,
.myFriend .section2 .showcase li.date0413,.myFriend .section2 .showcase li.date0417 {width:200px;}
.myFriend .section2 .showcase li span {display:none; width:100%; height:100%;}
.myFriend .section2 .showcase li span a {display:block; width:100%; height:100%; font-size:0; line-height:0; color:transparent;}
.myFriend .section2 .showcase li.opened span {display:block; background:url(http://webimage.10x10.co.kr/eventIMG/2017/sopum/77061/img_collect_off.png) 0 0 no-repeat;}
.myFriend .section2 .showcase li.collect span {display:block; background:url(http://webimage.10x10.co.kr/eventIMG/2017/sopum/77061/img_collect_on.png) 0 0 no-repeat;}
.myFriend .section2 .showcase li.date0403 span {background-position:0 -1px;}
.myFriend .section2 .showcase li.date0404 span {background-position:-220px 0;}
.myFriend .section2 .showcase li.date0405 span {background-position:-430px 0;}
.myFriend .section2 .showcase li.date0406 span {background-position:-640px 0;}
.myFriend .section2 .showcase li.date0407 span {background-position:100% 0;}
.myFriend .section2 .showcase li.date0408 span {background-position:0 -210px;}
.myFriend .section2 .showcase li.date0409 span {background-position:-220px -210px;}
.myFriend .section2 .showcase li.date0410 span {background-position:-430px -210px;}
.myFriend .section2 .showcase li.date0411 span {background-position:-640px -210px;}
.myFriend .section2 .showcase li.date0412 span {background-position:100% -210px;}
.myFriend .section2 .showcase li.date0413 span {background-position:0 100%;}
.myFriend .section2 .showcase li.date0414 span {background-position:-220px 100%;}
.myFriend .section2 .showcase li.date0415 span {background-position:-430px 100%;}
.myFriend .section2 .showcase li.date0416 span {background-position:-640px 100%;}
.myFriend .section2 .showcase li.date0417 span {background-position:100% 100%;}
.myFriend .section2 .deco {position:absolute; top:741px; left:50%; z-index:10; margin-left:488px;}
.myFriend .section2 .book {position:absolute; top:418px; left:50%; margin-left:-810px;}

.sopum .evtNoti .inner {position:relative; width:820px; margin:0 auto;}
.layerPopup {display:none; position:absolute; left:0; top:0; z-index:100; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2017/sopum/77061/bg_mask.png) 0 0 repeat;}
.layerPopup .applyFigure {position:absolute; left:50%; top:340px; margin-left:-190px; cursor:pointer;}
.layerPopup .btnClose {position:absolute; right:0; top:0; background:transparent;}
@keyframes rotate {
	from {transform:rotate(180deg); -webkit-transform:rotate(180deg);}
	to {transform:rotate(0deg); -webkit-transform:rotate(0deg);}
}
@keyframes bounce {
	from, to {transform:translateY(0); animation-timing-function:ease-out;}
	50% {transform:translateY(5px); animation-timing-function:ease-in;}
}
</style>
<script type="text/javascript">
$(function(){

	$(".myFriend .section1 .cardList li").click(function(){
		<% If not(nowDate >= "2017-04-03" And nowDate < "2017-04-18") Then %>
			alert("이벤트 응모 기간이 아닙니다.");
			document.location.reload();
			return;				
		<% end if %>

		<% If vUserID = "" Then %>
			if ("<%=IsUserLoginOK%>"=="False") {
				if(confirm("로그인 후 참여가 가능합니다. 로그인 하시겠습니까?")){
					location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/2017props/friend.asp")%>';
					return false;
				}
			}
		<% End If %>
		<% if evtFriendUserAppearChk(eCode, vUserID, nowDate) > 0 then %>
			<% If nowDate = "2017-04-17" Then %>
				<% Response.Write "alert('이미 응모하셨습니다.');return false;" %>
			<% Else %>
				<% Response.Write "alert('이미 응모하셨습니다.\n내일 또 응모해 주세요!');return false;" %>
			<% End If %>
		<% end if %>
		$(".layerPopup").fadeIn();
	});

	//animation
	animation()
	$(".title h3 span.letter1").css({"width":"0"});
	$(".title h3 span.letter2").css({"width":"0"});
	$(".deco .d1").css({"margin-top":"-410px"});
	$(".deco .d2").css({"margin-left":"-1070px"});
	$(".deco .d3").css({"margin-left":"-1200px","margin-top":"-250px"});
	$(".deco .d5").css({"margin-left":"1200px"});
	function animation() {
		$(".title h3 span.letter1").delay(300).animate({"width":"303px"},800);
		$(".title h3 span.letter2").delay(1000).animate({"width":"350px"},800);
		$(".deco .d1").delay(1500).animate({"margin-top":"0"},1700);
		$(".deco .d2").delay(2500).animate({"margin-left":"-870px"},800);
		$(".deco .d3").delay(50).animate({"margin-left":"-800px","margin-top":"0"},3000);
		$(".deco .d5").delay(200).animate({"margin-left":"650px"},1000);
	}
	$(".myFriend .section2 .deco").css({"margin-left":"688px","margin-top":"-240px"});
	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 750 ) {
			$(".myFriend .section2 .deco").delay(300).animate({"margin-left":"488px","margin-top":"0"},3000);
		}
	});
});

function checkform(){
	<% If vUserID = "" Then %>
		if ("<%=IsUserLoginOK%>"=="False") {
			if(confirm("로그인 후 참여가 가능합니다. 로그인 하시겠습니까?")){
				location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/2017props/friend.asp")%>';
				return;
			}
		}
	<% End If %>
	<% If vUserID <> "" Then %>
		<% If nowDate >= "2017-04-03" And nowDate < "2017-04-18" Then %>
			$.ajax({
				type:"GET",
				url:"/event/2017props/do_proc/friend_proc.asp?mode=ins",
				dataType: "text",
				async:false,
				cache:false,
				success : function(Data, textStatus, jqXHR){
					if (jqXHR.readyState == 4) {
						if (jqXHR.status == 200) {
							if(Data!="") {
								var str;
								for(var i in Data){
									 if(Data.hasOwnProperty(i)){
										str += Data[i];
									}
								}
								str = str.replace("undefined","");
								res = str.split("|");
								if (res[0]=="OK"){
									alert("오늘의 상품에 응모가 완료되었습니다!\n당첨자 발표는 4월 20일 입니다.");
									$(".layerPopup").fadeOut();
									$("#"+res[1]).addClass("collect");
									window.parent.$('html,body').animate({scrollTop:$(".section2").offset().top},500);
								} else {
									errorMsg = res[1].replace(">?n", "\n");
									alert(errorMsg);
									document.location.reload();
									return false;
								}
							} else {
								alert("잘못된 접근 입니다.");
								document.location.reload();
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
					document.location.reload();
					return false;
				}
			});
		<% Else %>
			alert("이벤트 응모 기간이 아닙니다.");
			document.location.reload();
			return;				
		<% End If %>
	<% End If %>
}
</script>
</head>
<body>
<div id="eventDetailV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container fullEvt">
		<div id="contentWrap">
			<div class="eventWrapV15">

				<div class="eventContV15">
					<%' event area(이미지만 등록될때 / 수작업일때) %>
					<div class="contF contW">

						<%' 4월 정기세일 소품전 [77061] 내 친구를 소개합니다 %>
						<div class="sopum myFriend">
							<%' head %>
							<!-- #include virtual="/event/2017props/head.asp" -->

							<%' 카드선택 %>
							<div class="section section1">
								<div class="title">
									<h3>
										<span class="letter1">내 친구를</span>
										<span class="letter2">소개합니다</span>
									</h3>
									<p class="once"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77061/txt_figure_friends.png" alt="하루에 한번 카드를 확인해보세요! 추첨을 통해 피규어 친구가 찾아갑니다" /></p>
									<div class="character"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77061/img_character.gif" alt="" /></div>
								</div>
								<div class="cardList">
									<ul>
										<li class="card1"><span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77061/img_card_1.png" alt="첫번째 카드" /></span></li>
										<li class="card2"><span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77061/img_card_2.png" alt="두번째 카드" /></span></li>
										<li class="card3"><span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77061/img_card_3.png" alt="세번째 카드" /></span></li>
										<li class="card4"><span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77061/img_card_4.png" alt="네번째 카드" /></span></li>
										<li class="card5"><span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77061/img_card_5.png" alt="다섯번째 카드" /></span></li>
									</ul>
									<p class="selectCard"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77061/txt_select_card.png" alt="원하는 카드 하나를 선택해주세요!" /></p>
								</div>
								<div class="deco">
									<div class="d1"></div>
									<div class="d2"></div>
									<div class="d3"></div>
									<div class="d4"></div>
									<div class="d5"></div>
								</div>
							</div>

							<%' 내가모은 캐릭터 %>
							<div class="section section2">
								<div class="showcase">
									<h4><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77061/txt_my_character.png" alt="내가 모은 캐릭터 보기" /></h4>
									<ul>
										<%' for dev msg : 지난 날짜 opened / 캐릭터 모은 날 collect 클래스 붙여주세요. %>
										<li class="date0403 <% If vUserID <> "" Then %><% If nowDate > "2017-04-03" Then %>opened<% End If %> <% If evtFriendUserAppearChk(eCode, vUserID, "2017-04-03") > 0 Then %> collect<% End If %><% End If %>" id="chr0403"><span><a href="/shopping/category_prd.asp?itemid=1652083&pEtr=77061">4월 3일</a></span></li>
										<li class="date0404 <% If vUserID <> "" Then %><% If nowDate > "2017-04-04" Then %>opened<% End If %> <% If evtFriendUserAppearChk(eCode, vUserID, "2017-04-04") > 0 Then %> collect<% End If %><% End If %>" id="chr0404"><span><a href="/shopping/category_prd.asp?itemid=1654443&pEtr=77061">4월 4일</a></li>
										<li class="date0405 <% If vUserID <> "" Then %><% If nowDate > "2017-04-05" Then %>opened<% End If %> <% If evtFriendUserAppearChk(eCode, vUserID, "2017-04-05") > 0 Then %> collect<% End If %><% End If %>" id="chr0405"><span><a href="/shopping/category_prd.asp?itemid=1647131&pEtr=77061">4월 5일</a></li>
										<li class="date0406 <% If vUserID <> "" Then %><% If nowDate > "2017-04-06" Then %>opened<% End If %> <% If evtFriendUserAppearChk(eCode, vUserID, "2017-04-06") > 0 Then %> collect<% End If %><% End If %>" id="chr0406"><span><a href="/shopping/category_prd.asp?itemid=1473814&pEtr=77061">4월 6일</a></li>
										<li class="date0407 <% If vUserID <> "" Then %><% If nowDate > "2017-04-07" Then %>opened<% End If %> <% If evtFriendUserAppearChk(eCode, vUserID, "2017-04-07") > 0 Then %> collect<% End If %><% End If %>" id="chr0407"><span><a href="/shopping/category_prd.asp?itemid=1357041&pEtr=77061">4월 7일</a></li>
										<li class="date0408 <% If vUserID <> "" Then %><% If nowDate > "2017-04-08" Then %>opened<% End If %> <% If evtFriendUserAppearChk(eCode, vUserID, "2017-04-08") > 0 Then %> collect<% End If %><% End If %>" id="chr0408"><span><a href="/shopping/category_prd.asp?itemid=1441800&pEtr=77061">4월 8일</a></li>
										<li class="date0409 <% If vUserID <> "" Then %><% If nowDate > "2017-04-09" Then %>opened<% End If %> <% If evtFriendUserAppearChk(eCode, vUserID, "2017-04-09") > 0 Then %> collect<% End If %><% End If %>" id="chr0409"><span><a href="/shopping/category_prd.asp?itemid=1494886&pEtr=77061">4월 9일</a></li>
										<li class="date0410 <% If vUserID <> "" Then %><% If nowDate > "2017-04-10" Then %>opened<% End If %> <% If evtFriendUserAppearChk(eCode, vUserID, "2017-04-10") > 0 Then %> collect<% End If %><% End If %>" id="chr0410"><span><a href="/shopping/category_prd.asp?itemid=1574596&pEtr=77061">4월 10일</a></li>
										<li class="date0411 <% If vUserID <> "" Then %><% If nowDate > "2017-04-11" Then %>opened<% End If %> <% If evtFriendUserAppearChk(eCode, vUserID, "2017-04-11") > 0 Then %> collect<% End If %><% End If %>" id="chr0411"><span><a href="/shopping/category_prd.asp?itemid=1581032&pEtr=77061">4월 11일</a></li>
										<li class="date0412 <% If vUserID <> "" Then %><% If nowDate > "2017-04-12" Then %>opened<% End If %> <% If evtFriendUserAppearChk(eCode, vUserID, "2017-04-12") > 0 Then %> collect<% End If %><% End If %>" id="chr0412"><span><a href="/shopping/category_prd.asp?itemid=1494882&pEtr=77061">4월 12일</a></li>
										<li class="date0413 <% If vUserID <> "" Then %><% If nowDate > "2017-04-13" Then %>opened<% End If %> <% If evtFriendUserAppearChk(eCode, vUserID, "2017-04-13") > 0 Then %> collect<% End If %><% End If %>" id="chr0413"><span><a href="/shopping/category_prd.asp?itemid=1668464&pEtr=77061">4월 13일</a></li>
										<li class="date0414 <% If vUserID <> "" Then %><% If nowDate > "2017-04-14" Then %>opened<% End If %> <% If evtFriendUserAppearChk(eCode, vUserID, "2017-04-14") > 0 Then %> collect<% End If %><% End If %>" id="chr0414"><span><a href="/shopping/category_prd.asp?itemid=1231255&pEtr=77061">4월 14일</a></li>
										<li class="date0415 <% If vUserID <> "" Then %><% If nowDate > "2017-04-15" Then %>opened<% End If %> <% If evtFriendUserAppearChk(eCode, vUserID, "2017-04-15") > 0 Then %> collect<% End If %><% End If %>" id="chr0415"><span><a href="/shopping/category_prd.asp?itemid=1624145&pEtr=77061">4월 15일</a></li>
										<li class="date0416 <% If vUserID <> "" Then %><% If nowDate > "2017-04-16" Then %>opened<% End If %> <% If evtFriendUserAppearChk(eCode, vUserID, "2017-04-16") > 0 Then %> collect<% End If %><% End If %>" id="chr0416"><span><a href="/shopping/category_prd.asp?itemid=1473815&pEtr=77061">4월 16일</a></li>
										<li class="date0417 <% If vUserID <> "" Then %><% If nowDate > "2017-04-17" Then %>opened<% End If %> <% If evtFriendUserAppearChk(eCode, vUserID, "2017-04-17") > 0 Then %> collect<% End If %><% End If %>" id="chr0417"><span><a href="/shopping/category_prd.asp?itemid=1209251&pEtr=77061">4월 17일</a></li>
									</ul>
								</div>
								<div class="deco"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77061/img_deco_6.png" alt="" /></div>
								<div class="book"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77061/img_deco_7.png" alt="" /></div>
							</div>

							<%' 응모하기 레이어팝업 %>
							<div class="layerPopup">
								<div class="applyFigure" onclick="checkform();return false;">
									<!--span class="btnClose"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77061/btn_close.png" alt="닫기" /></span-->
									<div>
										<%' 날짜순으로 이미지 01~15 %>
										<% Select Case nowDate %>
											<% Case "2017-04-03" %>
												<img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77061/img_figure_01.png" alt="" />
											<% Case "2017-04-04" %>
												<img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77061/img_figure_02.png" alt="" />
											<% Case "2017-04-05" %>
												<img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77061/img_figure_03.png" alt="" />
											<% Case "2017-04-06" %>
												<img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77061/img_figure_04.png" alt="" />
											<% Case "2017-04-07" %>
												<img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77061/img_figure_05.png" alt="" />
											<% Case "2017-04-08" %>
												<img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77061/img_figure_06.png" alt="" />
											<% Case "2017-04-09" %>
												<img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77061/img_figure_07.png" alt="" />
											<% Case "2017-04-10" %>
												<img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77061/img_figure_08.png" alt="" />
											<% Case "2017-04-11" %>
												<img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77061/img_figure_09.png" alt="" />
											<% Case "2017-04-12" %>
												<img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77061/img_figure_10.png" alt="" />
											<% Case "2017-04-13" %>
												<img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77061/img_figure_11.png" alt="" />
											<% Case "2017-04-14" %>
												<img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77061/img_figure_12.png" alt="" />
											<% Case "2017-04-15" %>
												<img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77061/img_figure_13.png" alt="" />
											<% Case "2017-04-16" %>
												<img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77061/img_figure_14.png" alt="" />
											<% Case "2017-04-17" %>
												<img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77061/img_figure_15.png" alt="" />
											<% Case Else %>
												<img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77061/img_figure_01.png" alt="" />
										<% End Select %>
									</div>
								</div>
							</div>

							<div class="evtNoti">
								<div class="inner">
									<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77061/tit_noti.png" alt="유의사항" /></h3>
									<ul>
										<li>ID당 1일1회 응모 가능합니다.</li>
										<li>추첨을 통해 응모한 캐릭터중 1종을 발송 해 드립니다.</li>
										<li>모든 상품의 옵션은 랜덤으로 배송되며, 선택이 불가합니다.</li>
										<li>당첨자 발표는 2017년 4월 20일(목) 에 일괄 진행됩니다.</li>
									</ul>
								</div>
							</div>

							<%' sns %>
							<div class="sns"><%=snsHtml%></div>
						</div>
						<%'// 4월 정기세일 소품전 [77061] 내 친구를 소개합니다 %>

					</div>
					<%' //event area(이미지만 등록될때 / 수작업일때) %>
				</div>
			</div>
		</div>
	</div>

	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->