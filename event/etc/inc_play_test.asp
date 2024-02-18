<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  
' History : 
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventCls.asp" -->
<!-- #include virtual="/event/etc/wishlist/wisheventCls.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->


<%
dim eCode, subscriptcount, userid
dim img1, img2, img3, img4
dim title1, title2, title3, title4
dim text1, text2, text3, text4
dim fblink

fblink = "www.10x10.co.kr/event/etc/inc_play_test.asp"
img1 = "http://webimage.10x10.co.kr/image/basic/158/B001589588.jpg"
img2 = "http://webimage.10x10.co.kr/image/basic/158/B001589587.jpg"
img3 = "http://webimage.10x10.co.kr/image/basic/158/B001589584.jpg"
img4 = "http://webimage.10x10.co.kr/image/basic/158/B001589564.jpg"

title1 = "타이틀1"
title2 = "타이틀2"
title3 = "타이틀3"
title4 = "타이틀4"

text1 = "플레이1"
text2 = "플레이2"
text3 = "플레이3"
text4 = "플레이4"

strPageTitle = text4
strPageUrl = fblink
strPageImage = img4

%>
<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
img {vertical-align:top;}
.evt66102 {position:relative;}
.evt66102 .makeFolder {position:absolute; top:352px; right:10px;}
.evt66102 img {vertical-align:top;}
.evt66102 .myWeddingWish {padding-bottom:55px; background:#93eecd url(http://webimage.10x10.co.kr/eventIMG/2015/66102/bg_pattern.png) repeat 0 0;}
.evt66102 .putMyWish {width:860px; margin:0 auto; padding:52px 83px 55px; text-align:center; background:#fff;}
.evt66102 .putMyWish .myFolder {position:relative; padding-bottom:5px; border-bottom:2px solid #000;}
.evt66102 .putMyWish .myFolder img {vertical-align:middle;}
.evt66102 .putMyWish .myFolder span {padding-right:10px; font-size:25px; line-height:25px; color:#000; vertical-align:middle;}
.evt66102 .putMyWish .myFolder a {display:inline-block; position:absolute; top:11px; right:5px;}
.evt66102 .putList {width:834px; height:150px; margin:48px 0 28px 12px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/66102/bg_my_item.gif) no-repeat 0 0;}
.evt66102 .putList ul {overflow:hidden; margin-right:-21px;}
.evt66102 .putList li {float:left; width:150px; height:150px; padding-right:21px;}
.evt66102 .putList li img {width:150px; height:150px;}
.evt66102 .friendsWish {padding-bottom:60px; background:#fff;}
.evt66102 .friendsWish h3 {padding-bottom:55px;}
.evt66102 .friendsWish dl {width:1001px; margin:0 auto;}
.evt66102 .friendsWish dt {padding:0 0 8px 42px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/66102/bg_line.gif) repeat-x 0 100%; text-align:left;}
.evt66102 .friendsWish dt span {display:inline-block; height:20px; padding-left:28px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/66102/ico_cart.gif) no-repeat 0 0; font-size:13px; color:#000;}
.evt66102 .friendsWish dd {padding-bottom:72px;}
.evt66102 .friendsWish dd ul {overflow:hidden; padding-top:44px;}
.evt66102 .friendsWish dd li {float:left; width:150px; padding-left:42px;}
.evt66102 .friendsWish dd li img {width:150px; height:150px;}

.evt66102 .evtNoti {position:relative; padding:60px 70px; text-align:left;}
.evt66102 .evtNoti p {position:absolute; top:57px; right:85px;}
.evt66102 .evtNoti dt {padding-bottom:25px;}
.evt66102 .evtNoti dd li {padding:0 0 10px 12px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/66102/blt_arrow.gif) no-repeat 0 2px; font-size:11px; line-height:12px; color:#000; }
.evt66102 .evtNoti dd li img {display:inline-block; margin-top:-2px; vertical-align:top;}

.pageWrapV15 {width:1001px; margin:0 auto;}
</style>
<script>
function cmaMetaTagsChange(url,stitle,scontent,simg){
//    $("#meta_image_src").attr("href", simg); // 트위터 카드를 사용하는 URL이다.
//    // 트위터 관련 메타태그
//    $("#meta_twitter_url").attr("content", url); // 트위터 카드를 사용하는 URL이다.
//    $("#meta_twitter_title").attr("content", stitle+" [chongmoa.com]"); // 트위터 카드에 나타날 제목
//    $("#meta_twitter_description").attr("content", scontent); // 트위터 카드에 나타날 요약 설명
//    $("#meta_twitter_image").attr("content", simg); // 트위터 카드에 보여줄 이미지
 
    // 페이스북 관련 메타태그
//    $("#meta_og_title").attr("content", stitle); //    제목표시
//    $("#meta_og_image").attr("content", simg); //    이미지경로 w:90px , h:60px(이미지를 여러 개 지정할 수 있음)
//    $("#meta_og_site_name").attr("content", stitle+" [chongmoa.com]"); //    사이트 이름
//    $("#meta_og_url").attr("content", url); //    표시하고싶은URL
//    $("#meta_og_description").attr("content", scontent); //    본문내용
// 	popSNSPost('fb',stitle,url,simg,'');
    // 네이트온 관련 메타태그
//    $("#meta_nate_title").attr("content", stitle); //    제목표시
//    $("#meta_nate_description").attr("content", scontent); //    본문내용
//    $("#meta_nate_site_name").attr("content", stitle+" [chongmoa.com]"); //    사이트 이름
//    $("#meta_nate_url").attr("content",url); //    표시하고싶은URL
//    $("#meta_nate_image").attr("content", simg); //    이미지경로
}
</script>
<div class="evt66102">
	<div>
		<img src="http://webimage.10x10.co.kr/eventIMG/2015/65972/img_share_sns.png" alt="친구에게도 알려주자!" usemap="#share" />
		<map name="share" id="share">
<%
 
			'// 쇼셜서비스로 글보내기 (2010.07.21; 허진원)
			Dim vTitle, vLink, vPre, vImg
			
			dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
			snpTitle = Server.URLEncode("[텐바이텐] PLAY ")
			snpLink = Server.URLEncode("http://www.10x10.co.kr/event/etc/inc_play_test.asp")
%>
			<area shape="rect" coords="956,82,1007,129" href="" onclick="popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','',''); return false;" alt="페이스북" />
			<!--<area shape="rect" coords="956,82,1007,129" onfocus="this.blur();" href="#" alt="facebook" onclick="cmaMetaTagsChange('<%= fblink %>','<%= title2 %>','<%= text2 %>','<%= img2 %>'); return false;"/>-->
			
	<!--		<a href="https://www.facebook.com/dialog/feed?link=https%3A%2F%2F1boon.kakao.com%2Fquiz%2Frightnow%3Fquizmonkeyref%3Dfacebook&name=%EB%82%98%EC%9D%98%20%ED%98%84%EC%9E%AC%20%EC%83%81%ED%83%9C%EB%A5%BC%20%EC%95%8C%EA%B3%A0%20%EC%8B%B6%EB%82%98%EC%9A%94%3F%20%ED%92%8D%EA%B2%BD%ED%99%94&redirect_uri=http://1boon.kakao.com/quiz/rightnow&app_id=1002463033102884&description=...&picture=http://webimage.10x10.co.kr/image/basic/158/B001589564.jpg">-->
			<img src="http://webimage.10x10.co.kr/eventIMG/2015/66102/ico_cart.gif">
			</a>
		</map>
	</div>
</div>

<!-- #include virtual="/lib/db/dbclose.asp" -->
