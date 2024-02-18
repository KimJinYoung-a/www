<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 7월의 사은품
' History : 2019-06-21 최종원
'####################################################
%>
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%

dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode = "90320"
Else
	eCode = "95967"
End If
%>
<%
'============== 모바일 접근시 모바일 페이지 이동(referer가 10x10이면 이동안함) ============
if InStr(request.ServerVariables("HTTP_REFERER"),"10x10.co.kr")<1 then
	if Not(Request("mfg")="pc" or session("mfg")="pc") then
		if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
			dim mRdSite: mRdSite = requestCheckVar(request("rdsite"),32)
			Response.Redirect "http://m.10x10.co.kr/event/eventmain.asp?eventid=" & eCode & chkIIF(mRdSite<>"","?rdsite=" & mRdSite,"") & chkIIF(gaparam<>"","&gaparam=" & gaparam,"")
			REsponse.End
		end if
	end if
end if
%>
<%
'공유관련
'// 쇼셜서비스로 글보내기 
Dim strPageTitle, strPageDesc, strPageUrl, strHeaderAddMetaTag, strPageImage, strPageKeyword
Dim strRecoPickMeta		'RecoPick환경변수
Dim vTitle, vLink, vPre, vImg, vIsEnd, vState, vNowTime, vCouponMaxCount
Dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
snpTitle	= Server.URLEncode("[7월의 사은품] 텐바이텐 7월사은품")
snpLink		= Server.URLEncode("http://www.10x10.co.kr/event/eventmain.asp?eventid=" & eCode)
snpPre		= Server.URLEncode("10x10 이벤트")
snpImg		= Server.URLEncode("http://webimage.10x10.co.kr/fixevent/event/2019/95967/m/img_kakao.jpg")

'// Facebook 오픈그래프 메타태그 작성
strPageTitle = "[7월의 사은품]"
strPageKeyword = "사은품"
strPageDesc = "[7월의 사은품] 선착순 2,500명에게만 드리는 PVC 파우치 받아가세요!"
strPageUrl = "http://www.10x10.co.kr/event/eventmain.asp?eventid=" & eCode
strPageImage = "http://webimage.10x10.co.kr/fixevent/event/2019/95967/m/img_kakao.jpg"
%>
<style type="text/css">
.topic {position:relative;}
.topic h2 {position:absolute; top:203px; left:145px; z-index:10;}
.topic .t1 {position:absolute; top:275px; left:746px; z-index:10;}
.topic .t2 {position:absolute; top:472px; left:528px; z-index:10;}
.topic .limited {position:absolute; top:89px; right:382px;}
.topic .limited:before {display:inline-block; position:absolute; top:-8px; right:-7px; z-index:5; width:68px; height:68px; background-color:#80f5cd; border-radius:50%; content:''; animation:bounce 300 1s .25s;}
.topic .limited img {position:relative; z-index:10; animation:bounce 300 1s;}
@keyframes bounce {
	from, to {transform:translateY(0); animation-timing-function:ease-in;}
	50% {transform:translateY(15px); animation-timing-function:ease-out;}
}
.topic .top-slide {overflow:hidden; position:absolute; top:0; left:402px; width:357px; height:553px;}
.bnr-tenten {position:fixed; top:246px; right:50%; z-index:20; margin-right:-615px;}
.instagram {position:relative;}
.instagram .slide2 {position:absolute; top:0; left:352px; width:436px; height:436px;}
.instagram .slick-dots {margin-top:28px; font-size:0;}
.instagram .slick-dots button {width:10px; height:10px; margin:0 4px; background-color:#dedede; border-radius:5px;}
.instagram .slick-dots .slick-active button {background-color:#8292f7;}
.disney map area {outline:0;}
.sns-share {position:relative;}
.sns-share ul {overflow:hidden; position:absolute; top:0; right:286px; height:100%;}
.sns-share ul li {float:left; width:100px; height:100%; margin:0 8px;}
.sns-share ul li a {display:block; height:100%; font-size:0; color:transparent;}
.noti {position:relative; background-color:#3a78fa;}
.noti h3 {position:absolute; top:50%; left:185px; margin-top:-10px;}
.noti ul {padding:43px 0 43px 330px; text-align:left;}
.noti ul li {padding:4px 0; font-size:13px; color:#fff; font-family:'Roboto', 'Noto Sans KR', 'malgun Gothic', '맑은고딕', sans-serif; word-break:keep-all;}
.noti ul li a {display:inline-block; height:26px; padding:0 6px; background-color:#ff4b9b; color:#fff; line-height:28px;}
.noti ul li a:hover {text-decoration:none;}
</style>
<script>
$(function(){
	$('.top-slide').slick({
		fade: true,
		cssEase: 'none',
		infinite: true,
		autoplay:true,
		autoplaySpeed: 2000,
		arrows:false
	});
	$('.slide2').slick({
		infinite: true,
		speed: 500,
		autoplay:true,
		autoplaySpeed: 2000,
		arrows:false,
		dots:true
	});
});
</script>
<script type="text/javascript">
function snschk(snsnum) {
	if(snsnum == "tw") {
		popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>');		
	}else if(snsnum=="fb"){
		popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','');		
	}else if(snsnum=="pt"){
		pinit('<%=snpLink%>','<%=snpImg%>');
	}
}
</script>
	<div class="evt95967">
		<div class="topic">
			<p><img src="//webimage.10x10.co.kr/fixevent/event/2019/95967/bg_top.jpg" alt=""></p>
			<h2><img src="//webimage.10x10.co.kr/fixevent/event/2019/95967/tit_gift.jpg" alt="7월의 사은품 #파우치"></h2>
			<p class="t1"><img src="//webimage.10x10.co.kr/fixevent/event/2019/95967/txt_top_1.jpg" alt=""></p>
			<p class="t2"><img src="//webimage.10x10.co.kr/fixevent/event/2019/95967/txt_top_2.png" alt=""></p>
			<span class="limited"><img src="//webimage.10x10.co.kr/fixevent/event/2019/95967/txt_limited.png" alt="선착순 2,500명"></span>
			<div class="top-slide">
				<div><img src="//webimage.10x10.co.kr/fixevent/event/2019/95967/img_top_1.jpg" alt=""></div>
				<div><img src="//webimage.10x10.co.kr/fixevent/event/2019/95967/img_top_2.jpg" alt=""></div>
				<div><img src="//webimage.10x10.co.kr/fixevent/event/2019/95967/img_top_3.jpg" alt=""></div>
				<div><img src="//webimage.10x10.co.kr/fixevent/event/2019/95967/img_top_4.jpg" alt=""></div>
				<div><img src="//webimage.10x10.co.kr/fixevent/event/2019/95967/img_top_5.jpg" alt=""></div>
			</div>
		</div>
		<a href="/event/eventmain.asp?eventid=89269" class="bnr-tenten" target="_blank"><img src="//webimage.10x10.co.kr/fixevent/event/2019/95524/bnr_tenten_delievery.png" alt="텐바이텐 배송 상품 보러 가기"></a>
		<p><img src="//webimage.10x10.co.kr/fixevent/event/2019/95967/txt_intro.jpg" alt="파우치 하나 바꿨을 뿐인데"></p>
		<div class="instagram">
			<p><img src="//webimage.10x10.co.kr/fixevent/event/2019/95967/bg_insta.jpg" alt="#투명파우치 #PVC파우치 #디즈니"></p>
			<div class="slide2">
				<div><img src="//webimage.10x10.co.kr/fixevent/event/2019/95967/img_slide_1.jpg" alt=""></div>
				<div><img src="//webimage.10x10.co.kr/fixevent/event/2019/95967/img_slide_2.jpg" alt=""></div>
				<div><img src="//webimage.10x10.co.kr/fixevent/event/2019/95967/img_slide_3.jpg" alt=""></div>
				<div><img src="//webimage.10x10.co.kr/fixevent/event/2019/95967/img_slide_4.jpg" alt=""></div>
				<div><img src="//webimage.10x10.co.kr/fixevent/event/2019/95967/img_slide_5.jpg" alt=""></div>
				<div><img src="//webimage.10x10.co.kr/fixevent/event/2019/95967/img_slide_6.jpg" alt=""></div>
			</div>
		</div>
		<div class="disney">
			<p><img src="//webimage.10x10.co.kr/fixevent/event/2019/95967/img_brand.jpg" alt="디즈니 X 텐바이텐" usemap="#disney"></p>
			<map name="disney">
				<area shape="rect" coords="170,110,770,310" href="/shopping/category_prd.asp?itemid=2367260&pEtr=95967" target="_blank" alt="디즈니 PVC 투명파우치 L">
				<area shape="rect" coords="770,110,970,310" href="/shopping/category_prd.asp?itemid=2367258&pEtr=95967" target="_blank" alt="디즈니 PVC 투명파우치 M">
				<area shape="rect" coords="770,310,970,360" href="/event/eventmain.asp?eventid=95995" target="_blank" alt="디즈니 상품 더 보러가기">
			</map>
		</div>
		<!-- SNS 공유-->
		<div class="sns-share">
			<p><img src="//webimage.10x10.co.kr/fixevent/event/2019/95967/img_share.jpg" alt="친구들에게도 7월 사은품을 알려주세요"></p>
			<ul>
				<li><a href="" onclick="snschk('fb');return false;" target="_blank">페이스북 공유</a></li>				
				<li><a href="" onclick="snschk('tw');return false;" target="_blank">트위터 공유</a></li>
			</ul>
		</div>
		<div class="noti">
			<h3><img src="//webimage.10x10.co.kr/fixevent/event/2019/95967/tit_noti.png" alt="유의사항"></h3>
			<ul>
				<li>- 본 이벤트는 텐바이텐 회원님을 위한 혜택입니다. (비회원 구매 증정 불가)</li>
				<li>- 사은품은 텐바이텐 배송상품을 포함한 구매확정 금액이 4만원 이상이어야 선택이 가능합니다. <a href="/event/eventmain.asp?eventid=89269" target="_blank">텐바이텐 배송상품 보러가기 &gt;</a></li>
				<li>- 구매확정 금액은 쿠폰, 할인카드 등을 적용한 최종 금액입니다. (마일리지/기프트카드/예치금 적용항목에서 제외입니다.)</li>
				<li>- 사은품은 텐바이텐 배송 상품과 함께 배송됩니다.</li>
				<li>- 환불이나 교환으로 인해 최종 구매 가격이 4만원 미만이 될 경우, 사은품도 함께 반품되어야 합니다.</li>
				<li>- 텐바이텐 기프트카드 상품을 구매하는 경우에는 사은품 증정 대상이 아닙니다.</li>
				<li>- 사은품이 모두 소진될 경우 이벤트는 조기 마감될 수 있습니다.</li>
				<li>- PVC 파우치의 색상 및 캐릭터는 랜덤으로 증정됩니다.</li>
			</ul>
		</div>
	</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->