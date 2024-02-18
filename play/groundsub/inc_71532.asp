<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/event/etc/instagrameventCls.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<%
'####################################################
' Description : PLAY #31-4
' History : 2016-06-24 유태욱 생성
'####################################################
Dim eCode, userid, pagereload, i
dim iCCurrpage, iCTotCnt, eCC, iCPageSize, iCTotalPage
IF application("Svr_Info") = "Dev" THEN
	eCode   =  66157
Else
	eCode   =  71532
End If

iCCurrpage = requestCheckVar(Request("iCC"),10)	'현재 페이지 번호
	
IF iCCurrpage = "" THEN iCCurrpage = 1
IF iCTotCnt = "" THEN iCTotCnt = -1

eCC = requestCheckVar(Request("eCC"), 1)
pagereload	= requestCheckVar(request("pagereload"),2)
userid		= GetEncLoginUserID()

iCPageSize = 8		'한 페이지의 보여지는 열의 수

dim oinstagramevent
set oinstagramevent = new Cinstagrameventlist
	oinstagramevent.FPageSize	= iCPageSize
	oinstagramevent.FCurrPage	= iCCurrpage
	oinstagramevent.FTotalCount		= iCTotCnt  '전체 레코드 수
	oinstagramevent.FrectIsusing = "Y"
	oinstagramevent.FrectEcode = eCode
	oinstagramevent.fnGetinstagrameventList

	iCTotCnt = oinstagramevent.FTotalCount '리스트 총 갯수
	iCTotalPage 	=  Int(iCTotCnt/iCPageSize)	'전체 페이지 수
	IF (iCTotCnt MOD iCPageSize) > 0 THEN	iCTotalPage = iCTotalPage + 1
%>
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/section.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<style type="text/css">
.groundWrap {width:100%; background-color:#2491eb;}
.groundCont {position:relative; padding-bottom:0; background-color:#fff;}
.groundCont .grArea {width:100%;}
.groundCont .tagView {width:1100px; margin-top:30px; padding:28px 20px 60px;}

.topic {position:relative; height:483px; background:#2491eb url(http://webimage.10x10.co.kr/play/ground/20160627/bg_wave.png) repeat-x 0 100%; text-align:center;}
.topic h3 {position:absolute; top:108px; left:50%; z-index:5; margin-left:-148px;}
.topic h3{animation-name:pulse; animation-duration:1.2s; animation-iteration-count:2;}
@keyframes pulse {
	0% {transform:scale(1);}
	50% {transform:scale(0.9);}
	100% {transform:scale(1);}
}
.topic .bubble {position:absolute; top:28px; left:50%; width:236px; height:337px; margin-left:-140px; background:url(http://webimage.10x10.co.kr/play/ground/20160627/img_bubble.png) no-repeat 50% 0; }
.bubble {animation-name:bubble; animation-duration:4.5s; animation-timing-function:ease-in-out; animation-delay:-1s; animation-iteration-count:infinite; animation-direction:alternate; animation-play-state:running; animation-delay:2s;}
@keyframes bubble {
	0%{margin-top:-40px; background-size:90% 90%;}
	100%{margin-top:40px; background-size:100% 100%;}
}

.intro {position:relative; height:431px; padding-top:165px; background:#59d7c4 url(http://webimage.10x10.co.kr/play/ground/20160627/bg_line_mint.png) no-repeat 50% 0; text-align:center;}
.intro .favorite {position:absolute; top:-62px; left:50%; margin-left:-33px;}
.intro .spin {animation-name:spin; animation-iteration-count:1; animation-fill-mode:both; animation-timing-function:linear; animation-duration:1.5s;}
@keyframes spin {
	0% {transform: rotateY(180deg);}
	100% {transform: rotateY(360deg);}
}

.place {height:1468px; background:#f5b7a8 url(http://webimage.10x10.co.kr/play/ground/20160627/bg_line_pink.png) no-repeat 50% 0;}
.place .inner {position:relative; width:1140px; margin:0 auto;}
.place h4 {position:absolute; top:82px; left:12px;}
.place .group {position:absolute; top:98px; left:245px; width:390px;}
.place .group2 {top:390px; left:50%; margin-left:161px;}
.place .group3 {top:777px; left:25px;}
.place .group a:hover {text-decoration:none;}
.place .group .thumbnail {position:relative;}
.place .group .thumbnail span {position:absolute; top:0; left:0; height:0; transition:opacity 0.8s ease-out;opacity:0; filter:alpha(opacity=0);}
.place .group .thumbnail:hover span {height:100%; opacity:1; filter: alpha(opacity=100);}
.btnMap {width:390px; margin-top:20px; text-align:center;}
.btnMap .address {display:inline; position:relative; padding-left:20px; color:#d2746a; font-family:'Dotum', '돋움'; font-size:14px; font-weight:bold;}
.btnMap .address span {padding-bottom:2px; border-bottom:1px solid #d2746a;}
.btnMap .address i {position:absolute; top:0; left:0; animation-name:bounce; animation-iteration-count:infinite; animation-duration:0.9s;}
@keyframes bounce {
	from, to{margin-top:0; animation-timing-function:ease-out;}
	50% {margin-top:-4px; animation-timing-function:ease-in;}
}

.place2 {height:1464px; background-color:#82cfe5; background-image:url(http://webimage.10x10.co.kr/play/ground/20160627/bg_line_sky.png);}
.place2 h4 {top:81px; left:1014px;}
.place2 .group1 {left:540px;}
.place2 .group2 {top:347px; left:18px; margin-left:0;}
.place2 .group2 .thumbnail span {top:42px;}
.place2 .group3 {left:50%; margin-left:49px;}
.place2 .group3 .thumbnail span {left:105px;}
.place2 .group3 .btnMap {margin-left:105px;}
.place2 .btnMap .address {color:#37889f;}
.place2 .btnMap .address span {border-color:#37889f;}

.share {position:relative; height:546px; background:#59d7c4 url(http://webimage.10x10.co.kr/play/ground/20160627/bg_blue.png) no-repeat 50% 0; text-align:center;}
.share .btnInstagram {position:absolute; top:260px; left:50%; margin-left:-170px;}
.share .btnInstagram i {position:absolute; top:26px; left:74px;}
.share .btnInstagram:hover i {animation-name:rotateIn; animation-duration:2s; animation-fill-mode:both; animation-iteration-count:1;}
@keyframes rotateIn {
	0% {transform-origin:50% 50%; transform:rotate(-200deg);}
	50% {transform-origin:50% 50%; transform:rotate(0);}
	55% {transform:scale(0.8);}
	100% {transform:scale(1);}
}

.instagram {padding-bottom:62px; background-color:#edf6fd;}
.instagram .noti {height:125px; background-color:#e8e8e8; text-align:center;}
.instagram ul {overflow:hidden; width:1168px; margin:0 auto; padding-top:35px;}
.instagram ul li {float:left; margin:46px 16px 0; text-align:center;}
.instagram ul li a:hover {text-decoration:none;}
.instagram ul li .thumbnail {display:block; padding:5px; border-radius:5px; background-color:#fff; transition:transform 0.5s ease-in-out;}
.instagram ul li .thumbnail img {overflow:hidden; width:250px; height:250px;}
.instagram ul li a:hover .thumbnail {transform:scale(0.95);}
.instagram ul li .author {margin-top:13px; color:#999; font-family:'Dotum', '돋움'; font-size:13px; font-weight:bold;}
.instagram ul li .author span {color:#2491eb;}

/* paging */
.pageWrapV15 {width:502px; height:34px; margin:60px auto 0; padding-top:6px; background:url(http://webimage.10x10.co.kr/play/ground/20160627/bg_paging.png) no-repeat 50% 0;}
.pageWrapV15 .pageMove {display:none;}
.paging a {width:29px; height:29px; margin:0; border:0;}
.paging a span {height:29px; line-height:29px; color:#c6c6c6; font-family:'Dotum', '돋움'; font-size:13px;}
.paging a.current {background-position:0 100%;}
.paging a.current span {color:#2491eb;}
.paging a:hover, .paging a.arrow, .paging a, .paging a.current, .paging a.current:hover {border:0; background-color:transparent;}
.paging .first, .paging .end {display:none;}
.paging a.arrow span {background:none;}
.paging .prev, 
.paging .next {background:url(http://webimage.10x10.co.kr/play/ground/20160627/btn_nav.png) no-repeat 0 0;}
.paging .next {background-position:100% 0;}
.paging .prev {margin-right:9px;}
.paging .next {margin-left:9px;}
</style>
<script type="text/javascript">
$(function(){
	<% if Request("eCC")<>"" then %>
		setTimeout("pagedown()",300);
	<% end if %>
});
function pagedown(){
	window.$('html,body').animate({scrollTop:$("#instagramlist").offset().top}, 0);
}

$(function(){
	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 700) {
			$(".hotPlace #intro .favorite").addClass("spin");
			introAnimation();
		}
	});

	$(".hotPlace #intro p").css({"height":"10px", "opacity":"0"});
	function introAnimation() {
		$(".hotPlace #intro p").delay(900).animate({"height":"253px", "opacity":"1"},1200);
	}
});

function jsGoComPage(iP){
	document.frmcom.iCC.value = iP;
	document.frmcom.iCTot.value = "<%=iCTotCnt%>";
	document.frmcom.submit();
}
</script>
	<!-- 수작업 영역 시작 -->
	<div class="groundCont">
		<div class="grArea">

			<!-- WATER #4 물 좋은 곳 이벤트 코드 : 71532  -->
			<div class="playGr20160627 hotPlace">
				<div class="topic">
					<h3><img src="http://webimage.10x10.co.kr/play/ground/20160627/tit_hot_place.png" alt="나만 아는 물 좋은 곳" /></h3>
					<div class="bubble"></div>
				</div>

				<div id="intro" class="intro">
					<div class="favorite"><img src="http://webimage.10x10.co.kr/play/ground/20160627/ico_favorite.png" alt="" /></div>
					<p><img src="http://webimage.10x10.co.kr/play/ground/20160627/txt_intro.png" alt="물 좋~다! 아름다운 풍경이 눈 앞에 펼쳐질 때, 우리는 스스로도 모르게 말하곤 합니다 여러분들은 물 좋다는 소리가 절로 나오는 나만의 장소를 가지고 있나요? 이번 주 PLAY에서는 마시는 물이 아닌 분위기가 멋진 물 좋은 장소를 소개하려고 합니다 텐바이텐이 소개하는 물 좋은 곳을 함께 거닐어 보고, 여러분의 소중한 장소도 소개해주세요!" /></p>
				</div>

				<div class="place place1">
					<div class="inner">
						<h4><img src="http://webimage.10x10.co.kr/play/ground/20160627/tit_memory.png" alt="인생 사진을 남기고 싶을 때" /></h4>
						<div class="group group1">
							<p class="thumbnail">
								<img src="http://webimage.10x10.co.kr/play/ground/20160627/img_place_01.png" alt="서울숲 뚝섬 카페 하트앤애로우 핑크를 사랑하는 핑크인들의 취향 저격 카페 아기자기하고 러블리한 인테리어에 달콤한 디저트까지! 밝은 조명과 소품 때문에 사진이 더 예쁘게 나오는 것은 안 비밀 일요일과 월요일은 휴무이니 참고하여 방문하세요" />
								<span><img src="http://webimage.10x10.co.kr/play/ground/20160627/img_place_01_over.png" alt="" /></span>
							</p>
							<div class="btnMap">
								<a href="https://goo.gl/maps/UTsfd69nakH2" target="_blank" title="하트앤애로우 핑크 위치 정보 구글맵으로 보기 새창" class="address">
									<i><img src="http://webimage.10x10.co.kr/play/ground/20160627/ico_map.png" alt="" /></i>
									<span>서울 성동구 성수동1가 668-49</span>
								</a>
							</div>
						</div>

						<div class="group group2">
							<p class="thumbnail">
								<img src="http://webimage.10x10.co.kr/play/ground/20160627/img_place_02.png" alt="수동 창고형 카페 대림창고 요즘 sns에서 가장 핫한 갤러리 겸 카페 1970년대 정미소를 개조해서 만든 독특한 인테리어로 넓고 특이한 카페를 찾고 있었다면 이곳을 추천! 곳곳에 커다란 조형물을 구경하는 재미는 덤" />
								<span><img src="http://webimage.10x10.co.kr/play/ground/20160627/img_place_02_over.png" alt="" /></span>
							</p>
							<div class="btnMap">
								<a href="https://goo.gl/maps/iDUfA48gZV62" target="_blank" title="대림창고 위치 정보 구글맵으로 보기 새창" class="address">
									<i><img src="http://webimage.10x10.co.kr/play/ground/20160627/ico_map.png" alt="" /></i>
									<span>서울 성동구 성수동2가 322-32</span>
								</a>
							</div>
						</div>

						<div class="group group3">
							<p class="thumbnail">
								<img src="http://webimage.10x10.co.kr/play/ground/20160627/img_place_03_v1.png" alt="해방촌 루프탑바 oriole 옥상에서 남산타워 야경 보며 분위기를 즐기고 싶고, 루프탑바의 로망을 맘껏 즐기고 싶은 사람에게 추천! 가수 정엽이 운영하는 곳으로, 또 한번 유명해지기도 했어요 좌석이 많지 않아 명당자리를 차지하려면 빠르게 움직여야 해요" />
								<span><img src="http://webimage.10x10.co.kr/play/ground/20160627/img_place_03_over.png" alt="" /></span>
							</p>
							<div class="btnMap">
								<a href="https://goo.gl/maps/9fGGeJDfZoD2" target="_blank" title="oriole 위치 정보 구글맵으로 보기 새창" class="address">
									<i><img src="http://webimage.10x10.co.kr/play/ground/20160627/ico_map.png" alt="" /></i>
									<span>서울 용산구 후암동 406-99</span>
								</a>
							</div>
						</div>
					</div>
				</div>

				<div class="place place2">
					<div class="inner">
						<h4><img src="http://webimage.10x10.co.kr/play/ground/20160627/tit_healing.png" alt="힐링이 필요할 때" /></h4>
						<div class="group group1">
							<p class="thumbnail">
								<img src="http://webimage.10x10.co.kr/play/ground/20160627/img_place_04.png" alt="홍대 한방카페 약다방 봄동 기분, 신체 상태에 따라 18가지 약차를 골라 마실 수 있고 한의사가 직접 태어난 달에 따라 자기와 딱 맞는 차도 추천 해줘요 족욕도 함께 즐길 수 있어 당신을 힐링 시켜 줄 최적의 장소! 한약을 싫어하는 사람도 거부감 없이 마실 수 있어요" />
								<span><img src="http://webimage.10x10.co.kr/play/ground/20160627/img_place_04_over.png" alt="" /></span>
							</p>
							<div class="btnMap">
								<a href="https://goo.gl/maps/2ULnj1pYjZS2" target="_blank" title="약다방 위치 정보 구글맵으로 보기 새창" class="address">
									<i><img src="http://webimage.10x10.co.kr/play/ground/20160627/ico_map_blue.png" alt="불광천 스튜디오&amp;레스토랑 반디앤보스케 여행 분위기, 휴양지 분위기 내고 싶다면 이곳으로! 마당에 카라반, 해먹등 여행느낌 물씬나는 소품들이 많아 아직 떠나지 못한 여름 휴가 기분을 만끽하기엔 안성맞춤 2층은 스튜디오로 장소 렌탈도 가능해요" /></i>
									<span>서울 마포구 동교동 203-36</span>
								</a>
							</div>
						</div>

						<div class="group group2">
							<p class="thumbnail">
								<img src="http://webimage.10x10.co.kr/play/ground/20160627/img_place_05.png" alt="불광천 스튜디오&amp;레스토랑 반디앤보스케 여행 분위기, 휴양지 분위기 내고 싶다면 이곳으로! 마당에 카라반, 해먹등 여행느낌 물씬나는 소품들이 많아 아직 떠나지 못한 여름 휴가 기분을 만끽하기엔 안성맞춤 2층은 스튜디오로 장소 렌탈도 가능해요" />
								<span><img src="http://webimage.10x10.co.kr/play/ground/20160627/img_place_05_over.png" alt="" /></span>
							</p>
							<div class="btnMap">
								<a href="https://goo.gl/maps/nGbkYdJMTzj" target="_blank" title="반디앤보스케 위치 정보 구글맵으로 보기 새창" class="address">
									<i><img src="http://webimage.10x10.co.kr/play/ground/20160627/ico_map_blue.png" alt="" /></i>
									<span>서울 서대문구 북가좌동 345-30</span>
								</a>
							</div>
						</div>

						<div class="group group3">
							<p class="thumbnail">
								<img src="http://webimage.10x10.co.kr/play/ground/20160627/img_place_06.png" alt="전통 디저트 카페 병과점 미남미녀 제주도 종달리에 새로 생긴 핫플레이스 몸에 좋은 떡, 수정과, 식혜 등 전통 디저트만 취급하여 커피와 케이크가 지겹다! 하시는 분들에게 추천! 입소문을 빠르게 타고 있어 더 유명해지기 전에 먼저 가보세요" />
								<span><img src="http://webimage.10x10.co.kr/play/ground/20160627/img_place_06_over.png" alt="" /></span>
							</p>
							<div class="btnMap">
								<a href="https://goo.gl/maps/TjFeTSdZsyD2" target="_blank" title="미남미녀 위치 정보 구글맵으로 보기 새창" class="address">
									<i><img src="http://webimage.10x10.co.kr/play/ground/20160627/ico_map_blue.png" alt="" /></i>
									<span>제주도 구좌읍 종달로1길 102</span>
								</a>
							</div>
						</div>
					</div>
				</div>

				<div class="share">
					<p><img src="http://webimage.10x10.co.kr/play/ground/20160627/txt_share_v3.png" alt="나만 아는 물 좋은곳을 공유해주세요 추첨을 통해 5분께 텐바이텐 기프트카드 3만원권 증정 신청 기간은 6월 27일부터 7월 4일까지며, 당첨자 발표는 7월 5일 입니다. 인스타그램에 사진과 #텐바이텐물좋은곳 해시태그를 함께 업로드해주세요" /></p>
					<a href="https://www.instagram.com/explore/tags/텐바이텐물좋은곳/" target="_blank" title="#텐바이텐물좋은곳 인스타그램으로 이동 새창" class="btnInstagram">
						<img src="http://webimage.10x10.co.kr/play/ground/20160627/btn_instagram.png" alt="인스타그램에 공유하러 가기" />
						<i><img src="http://webimage.10x10.co.kr/play/ground/20160627/ico_instagram.png" alt="" /></i>
					</a>
				</div>

				<form name="frmcom" method="post" onSubmit="return false;" style="margin:0px;">
				<input type="hidden" name="iCC" value="<%=iCCurrpage%>"/>
				<input type="hidden" name="iCTot" value=""/>
				<input type="hidden" name="eCC" value="1">
				</form>
				<div class="instagram">
					<p class="noti"><img src="http://webimage.10x10.co.kr/play/ground/20160627/txt_noti_v1.png" alt="계정이 비공개인 경우, 집계가 되지 않습니다. 이벤트 기간 동안 #텐바이텐물좋은곳 해시태그로 업로드 한 사진은 이벤트 참여를 의미하며, 텐바이텐 플레이 페이지 노출에 동의하는 것으로 간주합니다." /></p>
					<% if oinstagramevent.fresultcount > 0 then %>
					<ul id="instagramlist">
						<% for i = 0 to oinstagramevent.fresultcount-1 %>
						<li>
							<a href="<%=oinstagramevent.FItemList(i).Flinkurl %>" target="_blank">
								<span class="thumbnail"><img src="<%=oinstagramevent.FItemList(i).Fimgurl%>" width="250" height="250" alt="" /></span>
								<div class="author"><span><%=printUserId(oinstagramevent.FItemList(i).Fuserid,2,"*")%></span> 님의 물 좋은 곳</div>
							</a>
						</li>
						<% next %>
					</ul>
					<% end if %>
					<!-- paging -->
					<div class="pageWrapV15">
						<%=fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,10,"jsGoComPage")%>
					</div>
				</div>
				
			</div>
		</div>
	</div>
<% set oinstagramevent = nothing %>
<!-- #include virtual="/lib/db/dbclose.asp" -->