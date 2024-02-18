<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  [15주년] 전국 영상자랑
' History : 2016.10.07 유태욱
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
Dim evt_code, userid, nowdate
dim subscriptcounttotalcnt, usersubscriptcount

IF application("Svr_Info") = "Dev" THEN
	evt_code   =  66218
Else
	evt_code   =  73065
End If

'============== 모바일 접근시 모바일 페이지 이동(referer가 10x10이면 이동안함) ============
if InStr(request.ServerVariables("HTTP_REFERER"),"10x10.co.kr")<1 then
	if Not(Request("mfg")="pc" or session("mfg")="pc") then
		if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
			dim mRdSite: mRdSite = requestCheckVar(request("rdsite"),32)
			Response.Redirect "http://m.10x10.co.kr/event/eventmain.asp?eventid=" & evt_code & chkIIF(mRdSite<>"","&rdsite=" & mRdSite,"")
			REsponse.End
		end if
	end if
end if

userid = GetEncLoginUserID()
nowdate = now()
'	nowdate = #10/10/2016 10:05:00#

usersubscriptcount=0
subscriptcounttotalcnt=0

subscriptcounttotalcnt = getevent_subscripttotalcount(evt_code, "Y", "", "")

'//본인 참여 여부
if userid<>"" then
	usersubscriptcount = getevent_subscriptexistscount(evt_code, userid, "Y", "", "")
end if

strPageTitle	= "[텐바이텐 15th] 전국 영상자랑"
strPageUrl		= "http://www.10x10.co.kr/event/15th/sns.asp"
strPageImage	= "http://webimage.10x10.co.kr/eventIMG/2016/15th/73065/m/img_kakao.jpg"

'// 쇼셜서비스로 글보내기 (2010.07.21; 허진원)
Dim vTitle, vLink, vPre, vImg
Dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
snpTitle	= Server.URLEncode("[텐바이텐 15th] 전국 영상자랑")
snpLink		= Server.URLEncode("http://www.10x10.co.kr/event/15th/sns.asp")
snpPre		= Server.URLEncode("10x10")

'// Facebook 오픈그래프 메타태그 작성
strHeaderAddMetaTag = "<meta property=""og:title"" content=""[텐바이텐 15th] 전국 영상자랑"" />" & vbCrLf &_
					"<meta property=""og:type"" content=""website"" />" & vbCrLf &_
					"<meta property=""og:url"" content=""http://www.10x10.co.kr/event/15th/sns.asp"" />" & vbCrLf

strHeaderAddMetaTag = strHeaderAddMetaTag & "<meta property=""og:image"" content=""http://webimage.10x10.co.kr/eventIMG/2016/15th/73065/m/img_kakao.jpg"" />" & vbCrLf &_
											"<link rel=""image_src"" href=""http://webimage.10x10.co.kr/eventIMG/2016/15th/73065/m/img_kakao.jpg"" />" & vbCrLf

strPageKeyword = "[텐바이텐 15th] 전국 영상자랑트"
strPageDesc = "[텐바이텐] 이벤트 - 15주년 기념, 텐바이텐 영상을 전국에 널리 퍼뜨려주세요!"

%>
<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
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
.teN15th .noti h4 {position:absolute; left:92px; top:50%; margin-top:-37px;}
.teN15th .noti ul {padding:0 50px 0 310px;}
.teN15th .noti li {color:#666; text-indent:-10px; padding:5px 0 0 10px; line-height:18px;}
.teN15th .shareSns {height:160px; text-align:left; background:#363c7b url(http://webimage.10x10.co.kr/eventIMG/2016/15th/bg_share.png) repeat 0 0;}
.teN15th .shareSns div {position:relative; width:1140px; margin:0 auto;}
.teN15th .shareSns p {padding:70px 0 0 40px;}
.teN15th .shareSns ul {overflow:hidden; position:absolute; right:40px; top:50px;}
.teN15th .shareSns li {float:left; padding-left:40px;}

.teN15th{background-color:#aeaaf7;}
.videoMain {position:relative; background:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73065/bg_vedio_v3.jpg) no-repeat 50% 0; height:1659px; margin:0 auto;}
.videoMain h3 {padding:85px 0;}
.videoMain .balloon {position:absolute; top:141px; left:50%; margin-left:435px; animation-name:bounce; animation-iteration-count:infinite; animation-duration:2s;}
.videoMain .videoScreen {margin:0 auto; width:770px; height:577px;}
.videoMain .videoScreen iframe {margin-left:-1px;}
.videoMain .videoScreen .tenByLogo {height:59px; text-align:left; padding:8px 24px 0; }
.videoMain .videoScreen .likeNum {height:60px; text-align:left; padding:15px 22px 0;}
.videoMain .videoScreen .likeNum .btnLike {display:inline-block; background:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73065/btn_like_heart.png) no-repeat 0 0; width:37px; height:31px; font-size:0; line-height:0; color:transparent;}
.videoMain .videoScreen .likeNum .btnLikeOn {background-position: 100% 0;}
.videoMain .videoScreen .likeNum span {display:inline-block; vertical-align:top;}
.videoMain .videoScreen .likeNum span img {margin:5px 3px;}
.videoMain .videoScreen .likeNum .txtLike02 {color:#6477ed; font-size:18px; border-bottom:2px #6477ed solid; font-weight:bold;}
.videoMain .eventDetails { margin-top:45px;}
.videoMain .eventDetails ul {overflow:hidden; display:inline-block; width:610px; margin:10px auto 0;}
.videoMain .eventDetails ul li {float:left; margin-right:30px;}
.videoMain .eventDetails ul .lastLi{margin-right:0;}
.videoMain .eventDetails div {margin-top:50px;}
@keyframes bounce {
	from, to{transform:translateY(0); animation-timing-function:ease-out;}
	50% {transform:translateY(20px); animation-timing-function:ease-in;}
}
</style>
<script type="text/javascript">
function snschk(snsnum) {
	if(snsnum == "tw") {
		popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>');
	}else if(snsnum=="fb"){
		popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','');
	}else if(snsnum=="ka"){
		alert('잘못된 접속 입니다.');
		return false;
	}
}

function jssubmit(){
	<% If IsUserLoginOK() Then %>
		<% If not( left(nowdate,10)>="2016-10-07" and left(nowdate,10)<"2016-10-28" ) Then %>
			alert("이벤트 기간이 아닙니다.");
			return;
		<% else %>
			var str = $.ajax({
				type: "POST",
				url: "/event/15th/doeventsubscript/doEventSubscriptsns.asp",
				data: "mode=addok",
				dataType: "text",
				async: false
			}).responseText;
			var str1 = str.split("||")

			if (str1[0] == "11"){
				$("#btheart").addClass("btnLikeOn");
				$("#btheartcnt").text(str1[1]);
				$("#btheart").text("좋아요");
			}else if (str1[0] == "12"){
				$("#btheart").removeClass("btnLikeOn");
				$("#btheartcnt").text(str1[1]);
				$("#btheart").text("좋아요OFF");
			}else if (str1[0] == "03"){
				alert('이벤트 응모 기간이 아닙니다.');
				return false;
			}else if (str1[0] == "02"){
				alert('로그인을 해주세요.');
				return false;
			}else if (str1[0] == "01"){
				alert('잘못된 접속입니다.');
				return false;
			}else if (str1[0] == "00"){
				alert('정상적인 경로가 아닙니다.');
				return false;
			}else{
				alert('오류가 발생했습니다.');
				return false;
			}
		<% end if %>
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			top.location.href="/login/loginpage.asp?vType=G";
			return false;
		}
		return false;
	<% End IF %>
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
					<div class="contF contW">
						<%' 15주년 이벤트 : sub guide %>
						<div class="teN15th">
							<div class="tenHeader">
								<div class="headCont">
									<div>
										<h2><a href="/event/15th/"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/tit_ten_15th.png" alt="teN15th 텐바이텐의 다양한 이야기" /></a></h2>
										<ul class="navigator">
											<li class="nav1"><a href="/event/15th/">최대 40% 쿠폰 받기 [teN15th]</a></li>
											<li class="nav2"><a href="/event/15th/walkingman.asp">매일 매일 출석체크 [워킹맨]</a></li>
											<li class="nav3"><a href="/event/15th/discount.asp">할인에 도전하라 [비정상할인]</a></li>
											<li class="nav4"><a href="/event/15th/gift.asp">팡팡 터지는 구매사은품 [사은품을 부탁해]</a></li>
											<li class="nav5 current"><a href="/event/15th/sns.asp">영상을 공유하라 [전국 영상자랑]</a></li>
											<li class="nav6"><a href="/event/15th/tv.asp">일상을 담아라 [나의 리틀텔레비전]</a></li>
										</ul>
									</div>
								</div>
							</div>

							<%' 전국 영상 자랑 %>
							<div class="videoMain">
								<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73065/tit_video_evnt.png" alt="전국 영상 자랑 텐바이텐편" /></h3>
								<div class="balloon">
									<img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73065/img_balloon_v3.png" alt="떴다 텐텐 동영상" />
								</div>
								<div class="videoScreen">
									<p class="tenByLogo"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73065/txt_tenby_logo.png" alt="your 10x10" /></p>
									<iframe width="766" height="432" src="https://www.youtube.com/embed/D3hUNlrHqac?rel=0" title="텐바이텐 15주년 텐바이텐이 쏜다" frameborder="0" allowfullscreen=""></iframe>
									<p class="likeNum">
										<button id="btheart" onclick="jssubmit(); return false;" <% if usersubscriptcount > 0 then %> class="btnLike btnLikeOn"<% else %> class="btnLike"<% end if %>>좋아요</button>
										<!-- for dev message : 클릭시 btnLikeOn 클래스 추가 해주세요 -->
										<span class="txtLike01"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73065/txt_like.png" alt="좋아요" /></span>
										<span class="txtLike02" id="btheartcnt"><%= CurrFormat(subscriptcounttotalcnt) %></span>
										<span class="textLike03"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73065/txt_like_02.png" alt="개" /></span>
									</p>
								</div>
								<div class="eventDetails">
									<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73065/txt_evnt_banner.png" alt="이 영상을 전국에 널리 퍼뜨려주세요! 추첨을 통해 30분께 텐바이텐 기프트카드 5만원권을 드립니다" /></p>
									<ul>
										<li><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73065/txt_evnt_way_01.png" alt="텐바이텐 페이스북 페이지으로 이동" /></li>
										<li><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73065/txt_evnt_way_02.png" alt="영상 게시글을 좋아요 후 공유하기" /></li>
										<li class="lastLi"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73065/txt_evnt_way_03.png" alt="공유 후 댓글을 통해 감상평 남기기" /></li>
									</ul>
									<div><a href="https://www.facebook.com/your10x10/videos/1270345029652673/" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73065/btn_go_fb.png" alt="텐바이텐 페이스북 공식계정 전국영상자랑 포스팅으로 이동 새창" /></a></div>
								</div>
							</div>

							<%' 이벤트 유의사항  %>
							<div class="noti">
								<div>
									<h4><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/tit_noti.png" alt="이벤트 유의사항" /></h4>
									<ul>
										<li>- 본 이벤트는 텐바이텐 공식 페이스북 (@your10x10)에서 진행되는 이벤트 입니다.</li>
										<li>- 당첨자발표는 10월 27일 목요일 텐바이텐 공식 페이스북 및 사이트 공지사항을 통해 발표될 예정입니다.</li>
									</ul>
								</div>
							</div>

							<%' sns 공유  %>
							<div class="shareSns">
								<div>
									<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/txt_share.png" alt="텐바이텐 15주년 이야기, 친구와 함께라면!" /></p>
									<ul>
										<li><a href="" onclick="snschk('fb');return false;" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/btn_facebook.png" alt="텐바이텐 15주년 이야기 페이스북으로 공유" /></a></li>
										<li><a href="" onclick="snschk('tw');return false;" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/btn_twitter.png" alt="텐바이텐 15주년 이야기 트위터로 공유" /></a></li>
									</ul>
								</div>
							</div>
						</div>
						<%' 15주년 이벤트 : sub guide %>

					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->