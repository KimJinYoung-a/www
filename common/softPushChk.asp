<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description :  WebPush 인증페이지
' History : 2017.11.10 원승현 생성
' 이 페이지가 동작하기 위해선 head.asp에 /lib/js/manifest.js 가 불러와져 있어야 하며
' 루트 디렉토리에 service-worker.js가 있어야 한다.
'###########################################################
%>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
</head>
<body>
<%' for dev msg : 팝업 창 사이즈 width=565, height=585 %>
<div class="heightgird">
	<div class="popWrap push-agree">
		<h1 style="background-color:#d43239"><img src="http://fiximage.10x10.co.kr/web2017/common/tit_push.png" alt="NOTICE" /></h1>
		<div class="popContent">
			<p class="tMar05"><img src="http://fiximage.10x10.co.kr/web2017/common/txt_push_agree.png" alt="NOTICE" /></p>
			<div class="btnArea tMar20">
				<span><button type="button" value="" class="btn btnGry" onclick="window.close();">아니오</button></span>
				<span><button type="button" value="" class="btn btnBlack" id="pushYes" onclick="appBoyWebPushBrowserChk();">예</button></span>
			</div>
			<p class="fs12 cBk0V15 tMar20">* 수신 동의 후 <strong class="cRd0V15">허용 버튼</strong>을 눌러주세요, <strong class="cRd0V15">차단 시 재설정이 불가</strong>합니다.</p>
		</div>
	</div>
	<div class="popFooter">
		<div class="ftLt tPad10 lPad20">
			<label><input type="checkbox" class="check" onclick="setCookieAppBoy('appBoySoftPushPopChk', 'notView', 10);window.close();" /> 다시보지 않기</label>
		</div>
		<div class="btnArea">
			<button type="button" class="btn btnS1 btnGry2" style="margin-right:-10px;" onclick="window.close();">닫기</button>
		</div>
	</div>
</div>
<script type="text/javascript">
	+function(a,p,P,b,y){appboy={};appboyQueue=[];for(var s="initialize destroy getDeviceId toggleAppboyLogging setLogger openSession changeUser requestImmediateDataFlush requestFeedRefresh subscribeToFeedUpdates logCardImpressions logCardClick logFeedDisplayed requestInAppMessageRefresh logInAppMessageImpression logInAppMessageClick logInAppMessageButtonClick logInAppMessageHtmlClick subscribeToNewInAppMessages removeSubscription removeAllSubscriptions logCustomEvent logPurchase isPushSupported isPushBlocked isPushGranted isPushPermissionGranted registerAppboyPushMessages unregisterAppboyPushMessages submitFeedback ab ab.User ab.User.Genders ab.User.NotificationSubscriptionTypes ab.User.prototype.getUserId ab.User.prototype.setFirstName ab.User.prototype.setLastName ab.User.prototype.setEmail ab.User.prototype.setGender ab.User.prototype.setDateOfBirth ab.User.prototype.setCountry ab.User.prototype.setHomeCity ab.User.prototype.setLanguage ab.User.prototype.setEmailNotificationSubscriptionType ab.User.prototype.setPushNotificationSubscriptionType ab.User.prototype.setPhoneNumber ab.User.prototype.setAvatarImageUrl ab.User.prototype.setLastKnownLocation ab.User.prototype.setUserAttribute ab.User.prototype.setCustomUserAttribute ab.User.prototype.addToCustomAttributeArray ab.User.prototype.removeFromCustomAttributeArray ab.User.prototype.incrementCustomUserAttribute ab.User.prototype.addAlias ab.InAppMessage ab.InAppMessage.SlideFrom ab.InAppMessage.ClickAction ab.InAppMessage.DismissType ab.InAppMessage.OpenTarget ab.InAppMessage.ImageStyle ab.InAppMessage.Orientation ab.InAppMessage.CropType ab.InAppMessage.prototype.subscribeToClickedEvent ab.InAppMessage.prototype.subscribeToDismissedEvent ab.InAppMessage.prototype.removeSubscription ab.InAppMessage.prototype.removeAllSubscriptions ab.InAppMessage.Button ab.InAppMessage.Button.prototype.subscribeToClickedEvent ab.InAppMessage.Button.prototype.removeSubscription ab.InAppMessage.Button.prototype.removeAllSubscriptions ab.SlideUpMessage ab.ModalMessage ab.FullScreenMessage ab.HtmlMessage ab.ControlMessage ab.Feed ab.Feed.prototype.getUnreadCardCount ab.Card ab.ClassicCard ab.CaptionedImage ab.Banner ab.WindowUtils display display.automaticallyShowNewInAppMessages display.showInAppMessage display.showFeed display.destroyFeed display.toggleFeed sharedLib".split(" "),i=0;i<s.length;i++){for(var m=s[i],k=appboy,l=m.split("."),j=0;j<l.length-1;j++)k=k[l[j]];k[l[j]]=(new Function("return function "+m.replace(/\./g,"_")+"(){appboyQueue.push(arguments)}"))()}appboy.getUser=function(){return new appboy.ab.User};appboy.getCachedFeed=function(){return new appboy.ab.Feed};(y=p.createElement(P)).type='text/javascript';y.src='https://js.appboycdn.com/web-sdk/2.0/appboy.min.js';y.async=1;(b=p.getElementsByTagName(P)[0]).parentNode.insertBefore(y,b)}(window,document,'script');
	appboy.initialize('fd071a91-c38b-4174-acaa-d1ebff105f35', {enableLogging: false, safariWebsitePushId:'web.kr.10x10', enableHtmlInAppMessages: true});
	appboy.openSession();
	//appboy.logCustomEvent("prime-for-push");

	function appBoyWebPushBrowserChk()
	{
		if (appboy.isPushPermissionGranted())
		{
			alert("PUSH알림 허용이 이미 되어 있습니다.");
			setCookieAppBoy('appBoySoftPushPopChk', 'notView', 100000);
			window.close();
			return false;
		}
		if (appboy.isPushBlocked())
		{
			alert("PUSH알림이 차단되어 있는 상태 입니다.\n설정에서 푸쉬알림을 허용해주세요.");
			window.close();
			return false;
		}
		if (appboy.isPushSupported())
		{
			appboy.registerAppboyPushMessages(appBoyWebPushBrowserChkCallBack);
		}
		else
		{
			alert("지원하지 않는 브라우저 입니다.");
			setCookieAppBoy('appBoySoftPushPopChk', 'notView', 10);
			window.close();
			return false;
		}
	}

	function appBoyWebPushBrowserChkCallBack()
	{
		setCookieAppBoy('appBoySoftPushPopChk', 'notView', 10000);
		window.close();
		return false;
	}
	
    function setCookieAppBoy(cName, cValue, cDay)
	{
        var expire = new Date();
        expire.setDate(expire.getDate() + cDay);
        cookies = cName + '=' + escape(cValue) + '; path=/ ';
        if(typeof cDay != 'undefined') cookies += ';expires=' + expire.toGMTString() + ';';
        document.cookie = cookies;
    }

</script>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->