<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  ## 텐바이텐 X 앵그리버드 : 행운을 날리새오
' History : 2016-05-09 김진영 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/event/appdown/appdownCls.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
Dim eCode, smssubscriptcount, usercell, userid, isEventPeriod
eCode				= getevt_code
userid				= getloginuserid()
smssubscriptcount	= 0
usercell			= ""
smssubscriptcount	= getevent_subscriptexistscount(eCode, userid, "SMS_W", "", "")
usercell			= getusercell(userid)
isEventPeriod		= "N"

IF application("Svr_Info") = "Dev" THEN
	eCode = 66120
	If Now() >= #05/09/2016 00:00:00# And now() < #05/18/2016 23:59:59# Then 
		isEventPeriod = "Y"
	End If
Else
	eCode = 70672
	If Now() >= #05/11/2016 00:00:00# And now() < #05/18/2016 23:59:59# Then 
		isEventPeriod = "Y"
	End If
End If
%>
<style type="text/css">
img {vertical-align:top;}
.slide {overflow:visible !important; position:relative; width:544px;}
.slide .slidesjs-navigation {position:absolute; z-index:10; top:50%; width:34px; height:50px; margin-top:-25px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/70631/btn_nav.png) no-repeat 0 0; text-indent:-999em;}
.slide .slidesjs-previous {left:0;}
.slide .slidesjs-next {right:0; background-position:100% 0;}
.slidesjs-pagination {overflow:hidden; position:absolute; bottom:-44px; left:50%; z-index:50; width:190px; margin-left:-95px;}
.slidesjs-pagination li {display:inline-block; width:15px; margin:0 8px;}
.slidesjs-pagination li a {display:block; width:100%; height:14px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/70631/btn_pagination.png) no-repeat 0 0; text-indent:-999em;}
.slidesjs-pagination li a.active {background-position:100% 0;}

.angryHead {position:relative; height:993px; background:#79e0ff url(http://webimage.10x10.co.kr/eventIMG/2016/70631/bg_intro.jpg) no-repeat 50% 0;}
.angryHead h2 {position:absolute; left:50%; top:74px; margin-left:-413px;}
.angryHead .goItem {display:block; position:absolute; left:50%; text-indent:-999em; background:transparent;}
.angryHead .item01 {top:500px; width:347px; height:385px; margin-left:-680px;}
.angryHead .item02 {top:210px; width:280px; height:320px; margin-left:350px;}
.angryCont {position:relative; height:673px; background:#adcd2b;}
.angryCont .movieInfo {width:972px; margin:0 auto;}
.angryCont .movieInfo:after {content:' '; display:block; clear:both;}
.angryCont .movieInfo .rolling {float:left; width:544px; height:363px; border:8px solid #fff;}
.angryCont .movieInfo .rolling iframe {width:544px; height:363px; vertical-align:top;}
.angryCont .movieInfo .story {float:left; padding:46px 0 0 45px;}
.angryCont .appGift {position:absolute; left:50%; bottom:-52px; margin-left:-514px;}
.urlMsg {height:169px; padding-top:83px; background:#000; text-align:center;}
.urlMsg .box {overflow:hidden; width:954px; height:46px; padding:14px 14px 13px 0; margin:0 auto 14px; text-align:left; border:1px solid #5c5c5c;}
.urlMsg .box p {float:left;}
.urlMsg .box .inpUrl {float:left; width:395px; height:46px; padding:0 20px; color:#000; font-weight:bold; background:#fff;}
.urlMsg .box .btnUrl {float:right;}
</style>
<script type="text/javascript">
function jsSubmitsms(frm){
	<% If IsUserLoginOK() Then %>
		<% If Now() > #05/18/2016 23:59:59# Then %>
			alert("이벤트가 종료되었습니다.");
			return;
		<% Else %>
			<% If isEventPeriod = "Y" Then %>
				<% if smssubscriptcount <= 3 then %>
					if(frm.usercellnum.value =="로그인 해주세요"){
						jsChklogin('<%=IsUserLoginOK%>');
						return false;
					}
					if (frm.usercellnum.value == ''){
						alert("휴대폰 번호가 정확하지 않습니다.\n마이텐바이텐에서 개인정보를 수정해 주세요.!");
						return;
					}
					frm.mode.value="addsms";
					frm.action="/event/etc/doEventSubscript70672.asp";
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
	<div class="evt70631">
		<div class="angryHead">
			<h2><img src="http://webimage.10x10.co.kr/eventIMG/2016/70631/tit_angry_bird.png" alt="앵그리버드 텐바이텐에 떳새오!" /></h2>
			<a href="/shopping/category_prd.asp?itemid=1466001&pEtr=70631" target="_top" class="goItem item01">[레고 앵그리버드] 75823 버드 아일랜드의 알 강도</a>
			<a href="/shopping/category_prd.asp?itemid=1466002&pEtr=70631" target="_top" class="goItem item02">[레고 앵그리버드] 75822 피그 비행기 공격</a>
		</div>
		<div class="angryCont">
			<div class="movieInfo">
				<div class="rolling">
					<div class="slide">
						<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/70631/img_slide_05_v2.jpg" alt="" /></div>
						<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/70631/img_slide_01.jpg" alt="" /></div>
						<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/70631/img_slide_02.jpg" alt="" /></div>
						<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/70631/img_slide_03.jpg" alt="" /></div>
						<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/70631/img_slide_04.jpg" alt="" /></div>
						<div><iframe src="http://serviceapi.rmcnmv.naver.com/flash/outKeyPlayer.nhn?vid=90151787156BBEC09CF84A2ABC703854D2D4&outKey=V1262d7a526dfa3f8b623528e2fcba8005b179581a9f68ac1a7db528e2fcba8005b17&controlBarMovable=true&jsCallable=true&skinName=tvcast_white" frameborder="0" allowfullscreen></iframe></div>
					</div>
				</div>
				<p class="story"><img src="http://webimage.10x10.co.kr/eventIMG/2016/70631/txt_story.png" alt="화가 나면 참지 못하는 분노새 ‘레드’ 생각보다 말과 행동이 앞서는 깐족새 ‘척’ 욱하면 폭발해버리는 폭탄새 ‘밤’ 모두가 행복한 버드 아일랜드에서 어울리지 못하는 앵그리버드 레드, 척, 밤 어느 날, 정체불명의 초록 돼지 ‘피그’가 찾아오고, 평화로운 새계에 수상쩍은 일들이 벌어지기 시작하는데…앵그리버드, 이들이 화난 진짜 이유가 밝혀진다!" /></p>
			</div>
			<p class="appGift"><img src="http://webimage.10x10.co.kr/eventIMG/2016/70631/img_gift.jpg" alt="지금 텐바이텐APP에서 총 300명에게 선물을 쏜다!" /></p>
		</div>
		<%' url 보내기 %>
		<div class="urlMsg">
			<div class="box">
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/70631/txt_url.png" alt="app 설치 url 문자 메시지 받기 " /></p>
				<input type="text" id="inpUrl" name="usercellnum" class="inpUrl" readonly value="<%IF NOT IsUserLoginOK THEN%>로그인 해주세요<% else %><%=usercell%><%END IF%>" />
				<button type="button" class="btnUrl" onclick="jsSubmitsms(evtfrm); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/70631/btn_url.png" alt="url 받기 " /></button>
			</div>
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/70631/txt_free.png" alt="마이 텐바이텐에 등록된 번호로 전송되며 (1일 최대 3회), 비용은 무료입니다." /></p>
		</div>
		<%' url 보내기 %>
	</div>
</form>
<script type="text/javascript">
$(function(){
	/* slide js */
	$(".slide").slidesjs({
		width:"544",
		height:"363",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:3000, effect:"fade", auto:false},
		effect:{fade: {speed:1200, crossfade:true}
		},
		callback: {
			complete: function(number) {
				var pluginInstance = $('.slide').data('plugin_slidesjs');
				setTimeout(function() {
					pluginInstance.play(true);
				}, pluginInstance.options.play.interval);
			}
		}
	});
});
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->