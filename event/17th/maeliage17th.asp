<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'###########################################################
' Description : 17주년 매일리지
' History : 2018-09-18 원승현 생성
'###########################################################
%>
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
Dim eCode, userid, currenttime

IF application("Svr_Info") = "Dev" THEN
	eCode   =  89170
Else
	eCode   =  89074
End If

userid = GetEncLoginUserID()
currenttime = now()
'currenttime = "2018-10-10 오전 10:03:35"


'// 쇼셜서비스로 글보내기 
Dim vTitle, vLink, vPre, vImg, vIsEnd, vState, vNowTime, vCouponMaxCount
Dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
snpTitle	= Server.URLEncode("[텐바이텐 17주년]\n매일 매일 매일리지")
snpLink		= Server.URLEncode("http://www.10x10.co.kr/event/17th/maeliage17th.asp")
snpPre		= Server.URLEncode("10x10 이벤트")
snpImg		= Server.URLEncode("http://webimage.10x10.co.kr/eventIMG/2018/89073/banMoList20180918090618.JPEG")


'// Facebook 오픈그래프 메타태그 작성
strPageTitle = "[텐바이텐 17주년]매일 매일 매일리지"
strPageKeyword = "[텐바이텐 17주년]\n매일 매일 매일리지"
strPageDesc = "매일 출석하고 점점 불어나는\n마일리지 받아가세요!"
strPageUrl = "http://www.10x10.co.kr/event/17th/maeliage17th.asp"
strPageImage = "http://webimage.10x10.co.kr/eventIMG/2018/89073/banMoList20180918090618.JPEG"

%>
<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
#contentWrap {padding:0;}
.share {position:absolute; top:400px; left:50%; z-index:30; margin-left:410px; animation:bounce2 1s 100 ease-in-out;}
.share:before {display:inline-block; position:absolute; top:103px; left:0; z-index:5; width:160px; height:53px; background-image:url(http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/img_share_hand.png); content:' ';}
.share ul {overflow:hidden; position:absolute; top:90px; left:0; width:110px; padding:0 25px;}
.share ul li {float:left; width:50%;}
.share a {display:inline-block; position:absolute; top:90px; left:25px; z-index:7; width:53px; height:53px; text-indent:-999em;}
.share .twitter {left:80px;}

.evtHead {display:none;}
.ten-life .inner {position:relative; width:1140px; margin:0 auto;}
.ten-life button {background-color:transparent; vertical-align:top;}
.maeileage {background:#ff93b8 url(http://webimage.10x10.co.kr/fixevent/event/2018/17th/89074/bg_maeileage.jpg) no-repeat 50% 194px;}
.maeileage h2 {position:relative; padding-top:73px; z-index:2;}
.maeileage i {position:absolute; left:50%; top:87px; margin-left:-299px; animation:bounce .8s 30; z-index:1;}
.maeileage .app-down {overflow:hidden; margin-top:55px; padding:0 180px;}
.maeileage .app-down .ftLt {margin-top:62px;}
.maeileage .noti {padding:80px 0; background:#40255d url(http://webimage.10x10.co.kr/fixevent/event/2018/17th/89074/bg_noti.jpg) repeat 50% 0;}
.maeileage .noti h3 {position:absolute; left:135px; top:50%; margin-top:-14px;}
.maeileage .noti ul {padding-left:332px; text-align:left;}
.maeileage .noti li {color:#fff; padding:18px 0 0 11px; line-height:16px; font-size:15px; text-indent:-11px; font-family:'malgunGothic', '맑은고딕', sans-serif; letter-spacing:-1px;}
.maeileage .noti li:first-child {padding-top:0;}
@keyframes bounce {
	from, to {transform:translateY(0); animation-timing-function:ease-out;}
	50% {transform:translateY(8px); animation-timing-function:ease-in;}
}
</style>
<script type="text/javascript">
fnAmplitudeEventMultiPropertiesAction('view_17th_maeliage','','');
function snschk(snsnum) {
	if(snsnum == "tw") {
		popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>');
		fnAmplitudeEventMultiPropertiesAction('click_maeliage17th_sns','eventcode|snstype','<%=ecode%>|tw');
	}else if(snsnum=="fb"){
		popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','');
		fnAmplitudeEventMultiPropertiesAction('click_maeliage17th_sns','eventcode|snstype','<%=ecode%>|fb');
	}else if(snsnum=="pt"){
		pinit('<%=snpLink%>','<%=snpImg%>');
	}
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
						<%' 17주년 매일리지 %>
						<div class="evt89074 ten-life maeileage">
                            <%'// 네비 완성되면 여기에 추가 %>
							<!-- #include virtual="/event/17th/nav.asp" -->							
							<div class="inner">
								<h2><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/89074/tit_maeileage.png" alt="매일 오면 점점 커지는 혜택!" /></h2>
								<i><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/89074/img_badge.png" alt="모바일 앱에서만 참여가능!" /></i>
								<div class="app-down">
                                    <% if left(currenttime, 10) >= "2018-10-10" And left(currenttime, 10) < "2018-10-18" Then %>
                                        <p class="ftLt"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/89074/img_app_download1.png" alt="텐바이텐 APP 다운받기" /></p>
                                    <% elseif left(currenttime, 10) >= "2018-10-18" then %>
                                        <p class="ftLt"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/89074/img_app_download2.png" alt="텐바이텐 APP 다운받기" /></p>
                                    <% else %>
                                        <p class="ftLt"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/89074/img_app_download1.png" alt="텐바이텐 APP 다운받기" /></p>
                                    <% end if %>
                                    <p class="ftRt"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/89074/img_get_maeileage.png" alt="받을 수 있는 최대 마일리지 7,200M" /></p>
                                </div>
							</div>
							<div class="noti">
								<div class="inner">
									<h3><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/89074/tit_noti.png" alt="유의사항" /></h3>
									<ul>
										<li>- 본 이벤트는 텐바이텐 앱에서 하루에 한 번 참여할 수 있습니다.</li>
										<li>- 본 이벤트는 로그인 이후 참여 가능합니다.</li>
										<li>- 출석 체크 기간은 총 2회차까지 있습니다. (1회차 : 10월 10일 ~ 10월 17일 / 2회차 : 10월 24일 ~ 10월 31일)</li>
										<li>- 이벤트 참여 이후, <span style="color:#ff8bbf;">연속으로 출석하지 않았을 시 100M부터 다시 시작됩니다.</span></li>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<%' 공유 %>                            
			<div class="share">
				<p><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/img_share.png" alt="" /></p>
				<ul>
					<li><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/img_fb.png" alt="" /></li>
					<li><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/88938/img_twitter.png" alt="" /></li>
				</ul>                                
				<a href="" class="fb" onclick="snschk('fb');return false;" >페이스북 공유</a>
				<a href="" class="twitter" onclick="snschk('tw');return false;" >트위터 공유</a>                                
			</div>  
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->