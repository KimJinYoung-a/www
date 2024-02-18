<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<%
'####################################################
' Description : 텐큐베리감사 : 텐큐박스
' History : 2018-03-30 정태훈
'####################################################
Dim eCode, userid

IF application("Svr_Info") = "Dev" THEN
	eCode   =  67498
Else
	eCode   =  85147
End If

userid = GetEncLoginUserID()

'// Facebook 오픈그래프 메타태그 작성
strPageTitle = "[텐바이텐] 텐큐-텐큐베리박스"
strPageKeyword = "[텐바이텐] 텐큐-텐큐베리박스"
strPageDesc = "[텐바이텐] 이벤트 - 4월 정기세일 감사하는 마음 , 함께 나누세요! 텐큐베리박스"
strPageUrl = "http://www.10x10.co.kr/event/tenq/thx_box.asp"


%>
<style type="text/css">
.thx_box {margin-top:-45px !important}
.thx_box .thx-head{position:relative; background:#fa5356 url(http://webimage.10x10.co.kr/eventIMG/2018/tenq/85147/bg_head.png) no-repeat 50% 0;}
.thx_box .thx-head h2{padding:119px 0 70px;}
.thx_box .thx-head .vod {padding:12px 0;}
.thx_box .txt {position:relative; padding:97px 0 112px; background-color:#fa5356;}
.thx_box .process {padding-bottom:93px; background-color:#92eeef;}
.thx_box .process p {padding:95px 0 70px;}
.thx_box .noti {padding:80px 0; background:#0a9b9d;}
.thx_box .noti .inner{position:relative; width:1020px; margin:0 auto;}
.thx_box .noti h3 {position:absolute; left:70px; top:50%; margin-top:-14px;}
.thx_box .noti ul {padding-left:270px; text-align:left;}
.thx_box .noti li {color:#fff; line-height:1; padding:8px 0;}
.thx_box .noti li:first-child {padding-top:0;}
</style>
</head>
<body>
<div id="eventDetailV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container fullEvt">
		<div id="contentWrap">
			<div class="eventWrapV15">
				<div class="eventContV15 tMar15">
					<div class="contF contW">
						<!-- 텐큐베리감사 : 텐큐박스 -->
						<div class="mEvt85147 tenq thx_box">
						<!-- #include virtual="/event/tenq/nav.asp" -->
							<div class="thx-head">
								<h2><img src="http://webimage.10x10.co.kr/eventIMG/2018/tenq/85147/tit_thx_box.png" alt="텐큐베리박스" /></h2>
								<div class="vod"><iframe width="1020" height="575" src="https://www.youtube.com/embed/KEMKJ_yqIPU?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe></div>
							</div>
							<div class="txt"><img src="http://webimage.10x10.co.kr/eventIMG/2018/tenq/85147/txt_evt.png" alt="텐큐베리박스를 드려요! 페이스북에 올라온 해당 영상을 공유해주신 분 중 추첨을 통해  10분께 텐큐베리박스  를 드립니다!" /></div>
							<div class="process">
								<p><img src="http://webimage.10x10.co.kr/eventIMG/2018/tenq/85147/txt_how_to.png" alt="참여 방법 텐바이텐 페이스북으로 이동 영상 게시글을  좋아요 + 공유 누르기 공유 후 댓글을 통해 영상 감상평 남기기" /></p>
								<a href="https://www.facebook.com/your10x10/videos/1879157532104750/" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2018/tenq/85147/btn_fb.png" alt="페이스북으로 이동" /></a>
							</div>
							<!-- 유의사항 -->
							<div class="noti">
								<div class="inner">
									<h3><img src="http://webimage.10x10.co.kr/eventIMG/2018/tenq/85147/tit_noti.png" alt="유의사항" /></h3>
									<ul>
										<li>- 본 이벤트는 텐바이텐 공식 페이스북(@your10x10)에서 진행되는 이벤트입니다.</li>
										<li>- 텐바이텐 공식 페이스북 페이지를 팔로우 하지 않을 시 당첨자 명단에서 제외될 수 있습니다.</li>
										<li>- 당첨자 발표는 페이스북을 통해 04월 23일 월요일에 발표할 예정입니다.</li>
										<li>- 이벤트 발표는 텐바이텐 페이스북 페이지, 텐바이텐 사이트 내 공지사항에 기재됩니다.</li>
										<li>- 당첨자에게는 세무신고에 필요한 개인정보를 요청할 수 있습니다. 제세공과금은 텐바이텐 부담입니다.</li>
									</ul>
								</div>
							</div>
						</div>
						<!--// 텐큐베리감사 : 텐큐박스 -->
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