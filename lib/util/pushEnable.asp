<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<link rel="stylesheet" href="https://js.appboycdn.com/web-sdk/1.6/appboy.min.css" />
	<link rel="manifest" href="/lib/js/manifest.json" />
	<script>
		+function(a,p,P,b,y) {
		appboy={};for(var s="destroy toggleAppboyLogging setLogger openSession changeUser requestImmediateDataFlush requestFeedRefresh subscribeToFeedUpdates logCardImpressions logCardClick logFeedDisplayed requestInAppMessageRefresh logInAppMessageImpression logInAppMessageClick logInAppMessageButtonClick logInAppMessageHtmlClick subscribeToNewInAppMessages removeSubscription removeAllSubscriptions logCustomEvent logPurchase isPushSupported isPushBlocked isPushGranted isPushPermissionGranted registerAppboyPushMessages unregisterAppboyPushMessages submitFeedback ab ab.User ab.User.Genders ab.User.NotificationSubscriptionTypes ab.User.prototype.getUserId ab.User.prototype.setFirstName ab.User.prototype.setLastName ab.User.prototype.setEmail ab.User.prototype.setGender ab.User.prototype.setDateOfBirth ab.User.prototype.setCountry ab.User.prototype.setHomeCity ab.User.prototype.setEmailNotificationSubscriptionType ab.User.prototype.setPushNotificationSubscriptionType ab.User.prototype.setPhoneNumber ab.User.prototype.setAvatarImageUrl ab.User.prototype.setLastKnownLocation ab.User.prototype.setUserAttribute ab.User.prototype.setCustomUserAttribute ab.User.prototype.addToCustomAttributeArray ab.User.prototype.removeFromCustomAttributeArray ab.User.prototype.incrementCustomUserAttribute ab.InAppMessage ab.InAppMessage.SlideFrom ab.InAppMessage.ClickAction ab.InAppMessage.DismissType ab.InAppMessage.OpenTarget ab.InAppMessage.ImageStyle ab.InAppMessage.Orientation ab.InAppMessage.CropType ab.InAppMessage.prototype.subscribeToClickedEvent ab.InAppMessage.prototype.subscribeToDismissedEvent ab.InAppMessage.prototype.removeSubscription ab.InAppMessage.prototype.removeAllSubscriptions ab.InAppMessage.Button ab.InAppMessage.Button.prototype.subscribeToClickedEvent ab.InAppMessage.Button.prototype.removeSubscription ab.InAppMessage.Button.prototype.removeAllSubscriptions ab.SlideUpMessage ab.ModalMessage ab.FullScreenMessage ab.HtmlMessage ab.ControlMessage ab.Feed ab.Feed.prototype.getUnreadCardCount ab.Card ab.ClassicCard ab.CaptionedImage ab.Banner ab.WindowUtils display display.automaticallyShowNewInAppMessages display.showInAppMessage display.showFeed display.destroyFeed display.toggleFeed sharedLib".split(" "),i=0;i<s.length;i++){for(var k=appboy,l=s[i].split("."),j=0;j<l.length-1;j++)k=k[l[j]];k[l[j]]=function(){console&&console.error("The Appboy SDK has not yet been loaded.")}}appboy.initialize=function(){console&&console.error("Appboy cannot be loaded - this is usually due to strict corporate firewalls or ad blockers.")};appboy.getUser=function(){return new appboy.ab.User};appboy.getCachedFeed=function(){return new appboy.ab.Feed};
		(y = a.createElement(p)).type = 'text/javascript';
		y.src = 'https://js.appboycdn.com/web-sdk/1.6/appboy.min.js';
		(c = a.getElementsByTagName(p)[0]).parentNode.insertBefore(y, c);
		if (y.addEventListener) {s
		y.addEventListener("load", b, false);
		} else if (y.readyState) {
		y.onreadystatechange = b;
		}
		}(document, 'script', 'link', function() {
		appboy.initialize('fd071a91-c38b-4174-acaa-d1ebff105f35', {enableLogging: true, safariWebsitePushId:'web.kr.10x10'});
		appboy.display.automaticallyShowNewInAppMessages();
		if (appboy.isPushSupported())
		{
			appboy.registerAppboyPushMessages();
			//appboy.unregisterAppboyPushMessages()
			alert("푸쉬 등록이 완료되었습니다.");
		}
		else
		{
			alert("지원하지 않는 브라우저 입니다.");
			self.close();
		}

		<%
		'// 앱보이 유저seq값 전송
		If IsUserLoginOK Then
			If Trim(session("appboySession")) <> "" Then
		%>
				appboy.changeUser('<%=Trim(session("appboySession"))%>');

		<%
				session("appboySession") = ""
			End If
		End If
		%>

		/*
		* If you have a unique identifier for this user (e.g. they are logged into your site) it's a good idea to call
		* changeUser here.
		* See https://js.appboycdn.com/web-sdk/latest/doc/module-appboy.html#.changeUser for more information.
		*/
		// appboy.changeUser(userIdentifier);

		appboy.openSession();
		});
	</script>
</head>
<body>

</body>
</html>
