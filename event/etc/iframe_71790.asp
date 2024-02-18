<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 마이펫의 이중생활 SMS
' History : 2016.07.13 김진영 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/event/appdown/appdownCls.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
Dim eCode, smssubscriptcount, usercell, userid, isEventPeriod
eCode				= getevt_code
userid				= GetEncLoginUserID()
smssubscriptcount	= 0
usercell			= ""
smssubscriptcount	= getevent_subscriptexistscount(eCode, userid, "SMS_W", "", "")
usercell			= getusercell(userid)
isEventPeriod		= "N"

IF application("Svr_Info") = "Dev" THEN
	eCode = 66171
	If Now() >= #07/13/2016 00:00:00# And now() < #07/27/2016 23:59:59# Then 
		isEventPeriod = "Y"
	End If
Else
	eCode = 71790
	If Now() >= #07/14/2016 00:00:00# And now() < #07/27/2016 23:59:59# Then 
		isEventPeriod = "Y"
	End If
End If
%>
<style type="text/css">
img {vertical-align:top;}

.mypet {position:relative; background:#fff url(http://webimage.10x10.co.kr/eventIMG/2016/71790/bg_blue_v1.jpg) no-repeat 50% 0;}
.mypet .snowball, .mypet .pops {position:absolute; top:806px; left:50%; margin-left:-696px; animation-iteration-count:infinite; animation-fill-mode:both; animation-direction:alternate; animation-play-state:running;}
.mypet .pops {top:1440px; margin-left:448px;}
.mypet .snowball {animation-name:moveSnowball; animation-duration:1.5s;}
@keyframes moveSnowball {
	0% {margin-top:5px; animation-timing-function:linear;}
	100% {margin-top:0; animation-timing-function:linear;}
}
.pops {animation-name:movePops; animation-duration:4s;}
@keyframes movePops {
	0% {margin-left:448px; animation-timing-function:linear;}
	100% {margin-left:400px; animation-timing-function:linear;}
}

.mypet .topic {position:relative; height:350px;}
.mypet .topic p {position:absolute; top:102px; left:50%; width:265px; height:28px; margin-left:-132px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/71790/tit_my_pet.png) no-repeat 50% 0; text-indent:-9999em;}
.mypet .topic h2 {position:absolute; top:160px; left:50%; width:670px; height:87px; margin-left:-335px;}
.mypet .topic h2 span {position:absolute; top:0; height:87px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/71790/tit_my_pet.png) no-repeat 0 -58px; text-indent:-9999em;}
.mypet .topic h2 .letter1 {left:0; width:359px;}
.mypet .topic h2 .letter2 {right:0; width:287px; background-position:100% -58px;}

.mypet .event1 {height:641px;}
.mypet .event1 .field {overflow:hidden; width:968px; height:60px; margin:0 auto; padding-top:15px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/71790/bg_box.png) no-repeat 50% 0;}
.mypet .event1 .field h3, .mypet .event1 .field input {float:left;}
.mypet .event1 .field h3 {padding:14px 48px 0 47px;}
.mypet .event1 .field .itext {width:390px; height:46px; margin-right:9px; padding:0 22px; color:#000; font-family:'Verdana'; font-size:16px; font-weight:bold; line-height:46px; text-align:center;}
.mypet .event1 .free {margin-top:14px;}

.mypet .event2 {height:458px; padding-top:52px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/71790/bg_pink.png) no-repeat 50% 0;}

.movie {position:relative; height:501px;}
.movie iframe {position:absolute; top:69px; left:50%; margin-left:-392px;}
.movie p {position:absolute; top:80px; left:50%; margin-left:-197px;}
.movie .btnMore {position:absolute; top:344px; left:50%; margin-left:122px;}
.movie .btnMore:hover {animation-name:bounce; animation-iteration-count:infinite; animation-duration:0.6s;}
@keyframes bounce {
	from, to{margin-top:3px; animation-timing-function:ease;}
	50% {margin-top:0px; animation-timing-function:ease;}
}

.item {position:relative;}
.item .bg {position:absolute; top:56px; left:50%; width:1920px; height:130px; margin-left:-960px; background-color:#69869d;}
.item h3 {position:relative; z-index:5; margin-top:-56px;}
</style>
<script type="text/javascript">
function jsSubmitsms(frm){
	<% If IsUserLoginOK() Then %>
		<% If Now() > #07/27/2016 23:59:59# Then %>
			alert("이벤트가 종료되었습니다.");
			return;
		<% Else %>
			<% If isEventPeriod = "Y" Then %>
				<% if smssubscriptcount <= 3 then %>
					if(frm.usercellnum.value =="로그인 해주세요. (3회)"){
						jsChklogin('<%=IsUserLoginOK%>');
						return false;
					}
					if (frm.usercellnum.value == ''){
						alert("휴대폰 번호가 정확하지 않습니다.\n마이텐바이텐에서 개인정보를 수정해 주세요.!");
						return;
					}
					frm.mode.value="addsms";
					frm.action="/event/etc/doEventSubscript71790.asp";
					frm.submit();
					return;
				<% else %>
					alert("메세지는 3회까지 발송 가능 합니다.");
					return;
				<% end if %>
			<% else %>
				alert("이벤트 응모 기간이 아닙니다.");
				return;
			<% end if %>				
		<% End If %>
	<% Else %>
		jsChklogin('<%=IsUserLoginOK%>');
	<% End IF %>
}	
</script>
<form name="evtfrm" action="" onsubmit="return false;" method="post" style="margin:0px;">
<input type="hidden" name="mode">
<div class="evt71790 mypet">
	<span class="snowball"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71790/img_snowball.png" alt="" /></span>
	<span class="pops"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71790/img_pops.png" alt="" /></span>
	<div id="animation" class="topic">
		<p>텐바이텐이 선물을 쏜다!</p>
		<h2>
			<span class="letter1">마이펫의</span>
			<span class="letter2">이중생활</span>
		</h2>
	</div>

	<div class="event1">
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/71790/txt_event_01_v1.jpg" alt="지금 텐바이텐 APP에서 이벤트에 참여해주세요! 총 천명에게 마이펫 아이템을 드립니다. 실제 상품은 이미지와 상이할 수 있습니다." /></p>
		<%' for dev msg : 문자 전송 %>
		<div class="field">
			<fieldset>
				<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/71790/tit_sms.png" alt="앱 설치주소 메시지 받기" /></h3>
				<input type="text" title="등록된 휴대폰 번호" readonly="readonly" id="inpUrl" name="usercellnum" class="itext" value="<%IF NOT IsUserLoginOK THEN%>로그인 해주세요. (3회)<% else %><%=usercell%><%END IF%>" />
				<input type="image" onclick="jsSubmitsms(evtfrm); return false;" src="http://webimage.10x10.co.kr/eventIMG/2016/71790/btn_send.png" alt="문자 보내기" />
			</fieldset>
		</div>

		<p class="free"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71790/txt_sms_free.png" alt="등록된 번호로 전송되며, 비용은 무료입니다." /></p>
	</div>

	<div class="event2">
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/71790/txt_event_02.png" alt="배송박스 속 맥스와 함께 일상을 찍어주세요! 추첨을 통해 50분께 기프트카드 1만원 권을 드립니다. 텐바이텐 배송상품 쇼핑 후 박스 속 맥스와 인증샷을 찍은 후 인스타그램에 #텐바이텐 #마이펫의이중생활 해시태그로 업로드 해주세요! 맥스 리플렛은 텐바이텐 배송 상품과 함께 배송됩니다. 선착순 한정수량으로 소진시 미포함 될 수 있습니다." usemap="#link" /></p>
		<map id="link" name="link">
			<area shape="rect" coords="45,142,209,358" href="/event/eventmain.asp?eventid=65618" alt="텐텐배송이 나가신다 길을 비켜라 이벤트 페이지로 이동" />
		</map>
	</div>

	<div class="movie">
		<iframe src="https://www.youtube.com/embed/k5EMRySSUWQ" frameborder="0" title="마이펫의 이중생활 2차 예고편" allowfullscreen width="488" height="330"></iframe>
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/71790/txt_movie.png" alt="영화 마이펫의 이중생활의 줄거리 하루 종일 당신만 기다리며 보낼 것 같죠? 평화로운 나날을 보내던 주인바라기 맥스 어느 날, 자신의 집에 입양견 듀크가 굴러들어오고 맥스는 듀크와 원치 않는 동거를 시작하게 된다. 간식, 밥그릇, 침대, 주인의 사랑까지 빼앗긴 맥스의 일상은 금이 가기 시작하고 급기야 듀크 때문에 뉴욕 한복판을 헤매는 사건이 벌어지는데... " /></p>
		<a href="/culturestation/culturestation_event.asp?evt_code=3494" class="btnMore"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71790/btn_more.png" alt="마이펫의 이중생활 영화 더 보러가기" /></a>
	</div>

	<div class="item">
		<div class="bg"></div>
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/71790/tit_item.png" alt="마이펫의 이중생활 굿즈도 둘러 보세요!" /></h3>
	</div>
</div>
</form>
<script type="text/javascript">
$(function(){
	/* title animation */
	animation();
	$("#animation p").css({"margin-top":"5px", "opacity":"0"});
	$("#animation h2 span").css({"opacity":"0"});
	$("#animation h2 .letter1").css({"left":"-100px"});
	$("#animation h2 .letter2").css({"right":"-100px"});
	function animation () {
		$("#animation h2 .letter1").delay(100).animate({"left":"0", "opacity":"1"},500);
		$("#animation h2 .letter2").delay(100).animate({"right":"0", "opacity":"1"},500);
		$("#animation p").delay(700).animate({"margin-top":"0", "opacity":"1"},500);
	}
});
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->