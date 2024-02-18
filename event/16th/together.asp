<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<%
'============== 모바일 접근시 모바일 페이지 이동(referer가 10x10이면 이동안함) ============
if InStr(request.ServerVariables("HTTP_REFERER"),"10x10.co.kr")<1 then
	if Not(Request("mfg")="pc" or session("mfg")="pc") then
		if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
			dim mRdSite: mRdSite = requestCheckVar(request("rdsite"),32)
			Response.Redirect "http://m.10x10.co.kr/event/16th/together.asp" & chkIIF(mRdSite<>"","?rdsite=" & mRdSite,"")
			REsponse.End
		end if
	end if
end if

	'// 쇼셜서비스로 글보내기 (2010.07.21; 허진원)
	Dim vTitle, vLink, vPre, vImg, vIsEnd, vQuery, vState, vNowTime, vCouponMaxCount
	Dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
	snpTitle	= Server.URLEncode("[텐바이텐] 16주년 텐쇼 - 함께하쑈 : 50만원 쇼핑지원금으로 신나게 쇼핑을 즐겨 줄 서포터즈를 찾습니다!")
	snpLink		= Server.URLEncode("http://www.10x10.co.kr/event/16th/together.asp")
	snpPre		= Server.URLEncode("10x10 이벤트")
	snpImg		= Server.URLEncode("http://webimage.10x10.co.kr/eventIMG/2017/16th/m/kakao_tenshow_sub1.jpg")
	
	
	'// Facebook 오픈그래프 메타태그 작성
	strPageTitle = "[텐바이텐] 16주년 텐쑈 - 함께하쑈"
	strPageKeyword = "[텐바이텐] 16주년 텐쑈 - 함께하쑈"
	strPageDesc = "[텐바이텐] 이벤트 - 모두가 함께하는 쇼핑쑈! 텐바이텐의 텐텐쑈퍼를 모집합니다."
	strPageUrl = "http://www.10x10.co.kr/event/16th/together.asp"
	strPageImage = "http://webimage.10x10.co.kr/eventIMG/2017/80411/banMoList20170929160550.JPEG"
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<style>
/* common */
#contentWrap {padding:0;}
.gnbWrapV15 {height:38px;}
.ten-show .inner {position:relative; width:1140px; height:100%; margin:0 auto;}
.ten-show .noti {padding:24px 0; background-color:#8b8b8b;}
.ten-show .noti h3 {position:absolute; left:95px; top:50%; margin-top:-24px;}
.ten-show .noti ul {margin-left:280px; padding:15px 0 15px 70px; border-left:1px solid #9c9c9c; text-align:left;}
.ten-show .noti li {padding:3px 0 3px 9px; text-indent:-9px; line-height:18px; color:#fff;}
.ten-show .share {height:126px; text-align:left; background-color:#03154e;}
.ten-show .share p {padding-top:52px;}
.ten-show .share .btn-group {position:absolute; right:0; top:35px;}
.ten-show .share .btn-group a {position:relative; margin-left:12px;}
.ten-show .share .btn-group a:active {top:3px;}

/* together */
.show-together {background:#fff url(http://webimage.10x10.co.kr/eventIMG/2017/16th/80411/bg_topic.png) 50% 0 repeat-x;}
.show-together .topic {position:relative; height:567px; margin-bottom:98px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/16th/80411/bg_illust.png) 50% 0 no-repeat;}
.show-together .topic:after {content:''; display:inline-block; position:absolute; left:0; bottom:0; width:100%; height:8px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/16th/80411/bg_wave.png) 0 0 repeat-x;}
.show-together .topic .go-main {position:absolute; top:20px; left:50%; margin-left:427px; animation:bounce2 1s 100;}
.show-together .topic h2 span {display:block; position:absolute; left:50%; z-index:20; background-position:0 0; background-repeat:no-repeat; text-indent:-999em;}
.show-together .topic h2 span.t1 {top:138px; width:130px; height:155px; margin-left:-277px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/16th/80411/tit_together_1.png);}
.show-together .topic h2 span.t2 {top:123px; width:124px; height:190px; margin-left:-140px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/16th/80411/tit_together_2.png);}
.show-together .topic h2 span.t3 {top:114px; width:130px; height:148px; margin-left:-9px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/16th/80411/tit_together_3.png);}
.show-together .topic h2 span.t4 {top:158px; width:160px; height:162px; margin-left:118px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/16th/80411/tit_together_4.png);}
.show-together .topic h2 span.t5 {top:90px; z-index:10; width:168px; height:132px; margin-left:190px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/16th/80411/tit_together_5.png); animation:bounce1 .6s 1s 2;}
.show-together .topic p {position:absolute; left:50%;}
.show-together .topic .subcopy {top:334px; margin-left:-125px;}
.show-together .topic .shopper {top:481px; margin-left:-250px;}
.show-together .topic .deco {position:absolute; left:50%; top:75px; z-index:30; width:689px; height:238px; margin-left:-357px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/16th/80411/bg_doco.png) 0 0 no-repeat;}
.section2 {padding:62px 0 50px;}
.section3 {padding:0 0 103px;}
.section3 div {padding-bottom:50px;}
@keyframes bounce1 {
	from to{transform:translateY(0);}
	50%{transform:translateY(10px)}
}
@keyframes bounce2 {
	from to{transform:translateY(0);}
	50%{transform:translateY(5px)}
}
</style>
<script type="text/javascript">
$(function(){
	titleAnimation();
	$(".topic .deco").css({"opacity":"0","margin-top":"-20px"});
	$(".topic h2 span").css({"opacity":"0"});
	$(".topic h2 .t1,.topic h2 .t3").css({"margin-top":"-30px"});
	$(".topic h2 .t2,.topic h2 .t4").css({"margin-top":"30px"});
	function titleAnimation() {
		$(".topic .deco").delay(90).animate({"opacity":"1","margin-top":"0"},1200);
		$(".topic h2 .t1,.topic h2 .t3").delay(10).animate({"margin-top":"10px", "opacity":"1"},600).animate({"margin-top":"0"},300);
		$(".topic h2 .t2,.topic h2 .t4").delay(10).animate({"margin-top":"-10px", "opacity":"1"},600).animate({"margin-top":"0"},300);
		$(".topic h2 .t5").delay(800).animate({"opacity":"1"},600);
	}
});

function snschk(snsnum) {
	if(snsnum == "tw") {
		popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>');
	}else if(snsnum=="fb"){
		popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','');
	}else if(snsnum=="pt"){
		pinit('<%=snpLink%>','<%=snpImg%>');
	}
}

// add log
function fnWriteLog() {
	$.ajax({
		type: "get",
		url: "/common/addlog.js",
		data: "tp=together&ror="+encodeURIComponent("http://www.10x10.co.kr/event/16th/together")
	});
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
					<!-- event area(이미지만 등록될때 / 수작업일때) -->
					<div class="contF contW">

						<!-- 16주년 이벤트 -->
						<div class="ten-show show-together">
							<div class="topic">
								<h2>
									<span class="t1">텐</span>
									<span class="t2">텐</span>
									<span class="t3">텐</span>
									<span class="t4">텐</span>
									<span class="t5">텐텐쇼퍼!</span>
								</h2>
								<p class="subcopy"><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80411/txt_subcopy.png" alt="모두가 함께하는 쇼핑쑈! 텐바이텐의 텐텐쑈퍼를 모집합니다" /></p>
								<p class="shopper"><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80411/txt_shopper.png" alt="쇼핑지원금으로 신나게 쇼핑을 한 후,  솔직한 쇼핑 후기를 남기는 텐바이텐 공식 SHOPPER!" /></p>
								<a href="/event/16th/" class="go-main"><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80411/txt_16th_v3.png" alt="16주년 텐쇼!" /></a>
								<div class="deco"></div>
							</div>

							<!-- 텐텐쇼퍼 지원안내 -->
							<div class="section section1"><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80411/txt_benefit_v3.png" alt="활동 혜택" /></div>
							<div class="section section2"><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80411/txt_process.png" alt="신청 절차" /></div>
							<div class="section section3">
								<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80411/txt_date.png" alt="모집 요강" /></div>
								<a href="http://bit.ly/tentenshopper" onclick="fnWriteLog();" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80411/btn_submit.png" alt="신청서 작성하기" /></a>
							</div>

							<!-- 유의사항 -->
							<div class="noti">
								<div class="inner">
									<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/80411/tit_noti.png" alt="이벤트 유의사항" /></h3>
									<ul>
										<li>- 본 이벤트의 일정 및 세부 내용은 당사의 사정에 따라 예고 없이 변동될 수 있습니다.</li>
										<li>- 지원서 양식에 입력하신 정보는 텐바이텐 텐텐쑈퍼 운영/관리를 위해서만 활용되며, 활동 기간이 끝나면 폐기됩니다.</li>
										<li>- 텐텐쑈퍼 활동 시 블로그 및 인스타그램에 올려주신 내용은 텐바이텐에 귀속되며, 홍보를 위한 자료로 활용될 수 있습니다.</li>
									</ul>
								</div>
							</div>

							<!-- 공유하기 -->
							<div class="share">
								<div class="inner">
									<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/txt_share.png" alt="1년에 한번 있는 텐바이텐 쑈! 친구와 함께하쑈~!" /></p>
									<div class="btn-group">
										<a href="#" onclick="snschk('fb');return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/btn_facebook_v2.png" alt="페이스북으로 텐쑈 공유하기" /></a>
										<a href="#" onclick="snschk('tw');return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/btn_twitter.png" alt="트위터로 텐쑈 공유하기" /></a>
										<a href="#" onclick="snschk('pt');return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/16th/btn_pinterest.png" alt="핀터레스트로 텐쑈 공유하기" /></a>
									</div>
								</div>
							</div>
						</div>
						<!-- // 16주년 이벤트 -->

					</div>
					<!-- //event area(이미지만 등록될때 / 수작업일때) -->
				</div>
			</div>
		</div>
	</div>

	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->