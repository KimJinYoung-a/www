<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 텐바이텐 X 영화 <캡틴 아메리카: 시빌 워>  WWW
' History : 2016.04.20 유태욱 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
dim eCode, userid, currenttime, subscriptcount, tcapcnt, tironcnt, totalcnt
	IF application("Svr_Info") = "Dev" THEN
		eCode = "66112"
	Else
		eCode = "70195"
	end if

currenttime = now()
'															currenttime = #03/14/2016 10:05:00#

userid = GetEncLoginUserID()

subscriptcount=0
'//본인 참여 여부
if userid<>"" then
	subscriptcount = getevent_subscriptexistscount(eCode, userid, "", "", left(currenttime,10))
end if

totalcnt = getevent_subscripttotalcount(eCode, "", "", "")
tcapcnt = getevent_subscripttotalcount(eCode, "1", "", "")
tironcnt = getevent_subscripttotalcount(eCode, "2", "", "")

dim tcapgraph, tirongraph, tcapNum, tironpNum, tcapdonationCost, tirondonationCost

tcapgraph = 0
tirongraph = 0
IF tcapcnt="" then tcapcnt=0
IF tironcnt="" then tironcnt=0
IF isNull(totalcnt) then totalcnt=0

if totalcnt = 0 then totalcnt = 1

tcapgraph = Int( tcapcnt / totalcnt * 100  )	'게이지바 % 계산
tirongraph = Int( tironcnt / totalcnt * 100  )	'게이지바 % 계산

if tcapgraph > 100 then tcapgraph = 100
if tirongraph > 100 then tirongraph = 100
	
'// 쇼셜서비스로 글보내기 (2010.07.21; 허진원)
Dim vTitle, vLink, vPre, vImg

dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
snpTitle = Server.URLEncode("[텐바이텐] 캡틴 아메리카: 시빌 워")
snpLink = Server.URLEncode("http://www.10x10.co.kr/event/eventmain.asp?eventid="&eCode)
snpPre = Server.URLEncode("10x10 이벤트")
snpImg = Server.URLEncode("http://webimage.10x10.co.kr/eventIMG/2015/68041/m/bnr_kakao.jpg")

'기본 태그
snpTag = Server.URLEncode("텐바이텐")
snpTag2 = Server.URLEncode("#10x10")
%>
<style type="text/css">
img {vertical-align:top;}
.evt70195 {position:relative; background:#171818 url(http://webimage.10x10.co.kr/eventIMG/2016/70195/bg_civil_war.jpg) no-repeat 50% 0;}
.civilWar {position:relative; width:1140px; margin:0 auto;}
.civilWar h2 {padding:153px 0 50px;}
.civilWar .txt {padding-bottom:70px;}
.civilWar .vote {width:820px; margin:0 auto;}
.civilWar .date {position:absolute; right:0; top:45px; z-index:20;}
.civilWar .selectTeam {overflow:hidden; width:464px; margin:0 auto 40px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/70195/txt_vs.png) no-repeat 50% 50%;}
.civilWar .selectTeam button {display:block; width:178px; height:178px; background-repeat:no-repeat; background-position:0 0; background-color:transparent; text-indent:-999em; outline:none;}
.civilWar .selectTeam button:hover,
.civilWar .selectTeam button.current {background-position:100% 0;}
.civilWar .selectTeam .btnCaptain {float:left; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/70195/btn_captain.png);}
.civilWar .selectTeam .btnIron {float:right; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/70195/btn_iron.png);}
.civilWar .viewResult .bar {overflow:hidden; width:820px; height:30px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/70195/bg_bar.png) 0 0 no-repeat;}
.civilWar .viewResult .bar p {height:30px;}
.civilWar .viewResult .bar .teamCt {float:left;}
.civilWar .viewResult .bar .teamIr {float:right; min-width:14px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/70195/bg_bar_red.png) 100% 0 no-repeat;}
.civilWar .viewResult .count {overflow:hidden; padding:13px 25px 0; color:#b1b1b1; line-height:18px; text-align:center;}
.civilWar .viewResult .count div {width:95px;}
.civilWar .viewResult .count em {letter-spacing:1px;}
.civilWar .viewResult .count .teamCt em {color:#2055cd;}
.civilWar .viewResult .count .teamIr em {color:#e61921;}
.civilWar .movieInfo {position:relative; padding-bottom:70px; margin-top:75px; text-align:left;}
.civilWar .movieInfo .bigImage {position:relative; width:600px; height:350px;}
.civilWar .movieInfo .bigImage div {display:none; position:absolute; left:0; top:0;}
.civilWar .movieInfo .bigImage div.s00 {display:block;}
.civilWar .movieInfo .synopsis {position:absolute; right:-92px; top:-40px;}
.civilWar .movieInfo .preview {position:relative; margin-top:55px;}
.civilWar .movieInfo button {position:absolute; top:50%; margin-top:-17px; background:transparent;}
.civilWar .movieInfo button.prev {left:0px;}
.civilWar .movieInfo button.next {right:0px;}
.civilWar .movieInfo .swiper-container {overflow:hidden; position:relative; width:1020px; height:111px; margin:0 auto;}
.civilWar .movieInfo .swiper-wrapper {position:relative; width:100%;}
.civilWar .movieInfo .swiper-slide {position:relative; float:left; width:190px;}
.civilWar .movieInfo .swiper-slide span {display:inline-block; width:190px; background:#000;}
.civilWar .movieInfo .swiper-slide img {width:190px; opacity:0.4;}
.civilWar .movieInfo .swiper-slide-active img {opacity:1;}
.civilWar .movieInfo .pagination {display:none;}
.civilWar .selectGift {text-align:center; padding-top:52px;}
.civilWar .selectGift ul {overflow:hidden; width:800px; height:220px; padding:20px 0 0 20px; margin-bottom:45px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/70195/bg_box.png) 0 0 no-repeat;}
.civilWar .selectGift li {float:left;}
.civilWar .selectGift li label {display:block;}
.civilWar .shareSns {position:relative; margin-top:90px;}
.civilWar .shareSns a {position:absolute; top:16px;}
.civilWar .shareSns a.btnFb {right:185px;}
.civilWar .shareSns a.btnTw {right:120px;}
.evtNoti {padding:35px 0 20px; text-align:left; background:#efefef;}
.evtNoti .inner {overflow:hidden; width:956px; margin:0 auto;}
.evtNoti .inner h3 {float:left; width:212px; padding-top:25px;}
.evtNoti .inner ul {float:left; width:740px;}
.evtNoti .inner li {font-size:11px; line-height:12px; color:#8e8e8e; padding:0 0 12px 15px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/70195/blt_round.png) 0 1px no-repeat;}
</style>
<script type="text/javascript">
$(function(){
	$(".selectTeam button").click(function(){
		$(".selectTeam button").removeClass("current");
		$(this).addClass("current");
		window.parent.$('html,body').animate({scrollTop:600},300);
		$("#selectGiftshow").show();
		frmcom.gubunval.value = $(this).val()
	});
	$(".swiper-slide-active").find("img").css("opacity","1");
	var mySwiper = new Swiper('.preview .swiper-container',{
		slidesPerView:5,
		centeredSlides:true,
		loop:true,
		speed:800,
		pagination:'.pagination',
		paginationClickable:true,
		autoplay:false,
		onSlideChangeStart: function (mySwiper){
			$(".swiper-slide").find("img").delay(50).animate({"opacity":"0.4"},300);
			$(".swiper-slide-active").find("img").delay(100).animate({"opacity":"1"},400);
			$('.bigImage div').fadeOut();
			if ($('.swiper-slide-active').hasClass("s00")) {$('.bigImage .s00').fadeIn();}
			if ($('.swiper-slide-active').hasClass("s01")) {$('.bigImage .s01').fadeIn();}
			if ($('.swiper-slide-active').hasClass("s02")) {$('.bigImage .s02').fadeIn();}
			if ($('.swiper-slide-active').hasClass("s03")) {$('.bigImage .s03').fadeIn();}
			if ($('.swiper-slide-active').hasClass("s04")) {$('.bigImage .s04').fadeIn();}
			if ($('.swiper-slide-active').hasClass("s05")) {$('.bigImage .s05').fadeIn();}
			if ($('.swiper-slide-active').hasClass("s06")) {$('.bigImage .s06').fadeIn();}
			if ($('.swiper-slide-active').hasClass("s07")) {$('.bigImage .s07').fadeIn();}
			if ($('.swiper-slide-active').hasClass("s08")) {$('.bigImage .s08').fadeIn();}
			if ($('.swiper-slide-active').hasClass("s09")) {$('.bigImage .s09').fadeIn();}
		}
	})
	$('.prev').on('click', function(e){
		e.preventDefault()
		mySwiper.swipePrev()
	})
	$('.next').on('click', function(e){
		e.preventDefault()
		mySwiper.swipeNext()
	});
});

function jsevtgo(e){
	<% If IsUserLoginOK() Then %>
		<% If not( left(currenttime,10)>="2016-04-20" and left(currenttime,10)<"2016-04-27" ) then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return;
		<% else %>
			<% if subscriptcount > 0 then %>
				<% if left(currenttime,10)="2016-04-26" then %>
					alert('하루 한 번만 응모할 수 있습니다.\n감사합니다.');
				<% else %>
					alert('하루 한 번만 응모할 수 있습니다.\n내일 또 응모해주세요.');
				<% end if %>
				return;
			<% else %>
				var giftgubun = $(":input:radio[name=giftitem]:checked").val();
				var teamgubun = frmcom.gubunval.value;
	
				if (teamgubun == ""){
					alert('팀을 선택해 주세요!');
					return false;
				}
	
				if (giftgubun == null){
					alert('상품을 선택해 주세요!');
					return false;
				}
	
				var str = $.ajax({
					type: "POST",
					url: "/event/etc/doeventsubscript/doEventSubscript70195.asp",
					data: "mode=evtgo",
					data: "mode=evtgo&teamgubun="+teamgubun+"&itemgubun="+giftgubun,
					dataType: "text",
					async: false
				}).responseText;
				var str1 = str.split("||")
				if (str1[0] == "11"){
					<% if left(currenttime,10)="2016-04-26" then %>
						alert('응모해주셔서 감사합니다.\n드디어 내일이 개봉이에요!');
					<% else %>
						alert('응모해주셔서 감사합니다.\n내일 또 응모해주세요!');
					<% end if %>
					parent.location.reload();
					return false;
				}else if (str1[0] == "01"){
					alert('잘못된 접속입니다.');
					return false;
				}else if (str1[0] == "02"){
					alert('텐바이텐 로그인 후\n응모하실 수 있습니다.');
					return false;
				}else if (str1[0] == "03"){
					alert('이벤트 기간이 아닙니다.');
					return false;		
				}else if (str1[0] == "04"){
					<% if left(currenttime,10)="2016-04-26" then %>
						alert('하루 한 번만 응모할 수 있습니다.\n감사합니다.');
					<% else %>
						alert('하루 한 번만 응모할 수 있습니다.\n내일 또 응모해주세요.');
					<% end if %>
					return false;
				}else if (str1[0] == "00"){
					alert('정상적인 경로가 아닙니다.');
					return false;
				}else{
					alert('오류가 발생했습니다.');
					return false;
				}
			<% end if %>
		<% end if %>
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return false;
		}
		return false;
	<% End IF %>
}
</script>
	<!-- 텐바이텐X시빌워 -->
	<div class="evt70195">
		<div class="civilWar">
			<h2><img src="http://webimage.10x10.co.kr/eventIMG/2016/70195/tit_civil_war.png" alt="투표는 시작되었다" /></h2>
			<p class="txt"><img src="http://webimage.10x10.co.kr/eventIMG/2016/70195/txt_vote.png" alt="응원하는 팀에 투표하세요" /></p>
			<p class="date"><img src="http://webimage.10x10.co.kr/eventIMG/2016/70195/txt_date.png" alt="이벤트기간 : 2016.4.20 ~ 4.26" /></p>
			<div class="vote">
				<div class="selectTeam">
					<button type="button" id="tcap" value="1" class="btnCaptain">팀 캡틴 선택하기</button>
					<button type="button" id="tiron" value="2" class="btnIron">팀 아이언맨 선택하기</button>
				</div>
				<div class="viewResult">
					<% if subscriptcount < 1 then %>
						<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/70195/txt_hidden.png" alt="득표율은 최종 응모 후 확인할 수 있습니다." /></p>
					<% else %>
						<div class="bar">
							<p class="teamCt" style="width:<%= tcapgraph %>%;"></p>
							<p class="teamIr" style="width:<%= tirongraph %>%;"></p>
						</div>
					<% end if %>
					
					<% if subscriptcount < 1 then %>
					<% else %>
						<div class="count">
							<div class="teamCt ftLt">
								<p>팀 캡틴</p>
								<p><em><%= tcapcnt %></em>표 (<em><%= tcapgraph %></em>%)</p>
							</div>
							<div class="teamIr ftRt">
								<p>팀 아이언맨</p>
								<p><em><%= tironcnt %></em>표 (<em><%= tirongraph %></em>%)</p>
							</div>
						</div>
					<% end if %>
					<div class="selectGift" id="selectGiftshow" style="display:none">
						<ul>
							<li>
								<input type="radio" id="gift1" name="giftitem" value="1" />
								<label for="gift1"><img src="http://webimage.10x10.co.kr/eventIMG/2016/70195/img_gift_01.jpg" alt="오리지널 무선스피커 6명" /></label>
							</li>
							<li>
								<input type="radio" id="gift2" name="giftitem" value="2" />
								<label for="gift2"><img src="http://webimage.10x10.co.kr/eventIMG/2016/70195/img_gift_02.jpg" alt="오리지널 USB 8GB 6명" /></label>
							</li>
							<li>
								<input type="radio" id="gift3" name="giftitem" value="3" />
								<label for="gift3"><img src="http://webimage.10x10.co.kr/eventIMG/2016/70195/img_gift_03.jpg" alt="오리지널 핸드폰 충전기 6명" /></label>
							</li>
							<li>
								<input type="radio" id="gift4" name="giftitem" value="4" />
								<label for="gift4"><img src="http://webimage.10x10.co.kr/eventIMG/2016/70195/img_gift_04.jpg" alt="오리지널 반팔 티셔츠 6명" /></label>
							</li>
							<li>
								<input type="radio" id="gift5" name="giftitem" value="5" />
								<label for="gift5"><img src="http://webimage.10x10.co.kr/eventIMG/2016/70195/img_gift_05.jpg" alt="영화 예매권 50명" /></label>
							</li>
							<li>
								<input type="radio" id="gift6" name="giftitem" value="6" />
								<label for="gift6"><img src="http://webimage.10x10.co.kr/eventIMG/2016/70195/img_gift_06.jpg" alt="그래픽노블" /></label>
							</li>
						</ul>
						<button type="button" onclick="jsevtgo(); return false;" class="btnSubmit"><img src="http://webimage.10x10.co.kr/eventIMG/2016/70195/btn_apply.png" alt="경품 응모하기" /></button>
					</div>
				</div>
				<form name="frmcom" method="post" onSubmit="return false;" style="margin:0px;">
					<input type="hidden" name="gubunval">
				</form>
			</div>

			<div class="shareSns">
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/70195/txt_share.png" alt="텐바이텐X영화 &lt;캡틴 아메리카:시빌 워&gt; 이벤트 친구들에게 소문을 내면 당첨확률이 올라간다!" /></p>
				<a href="" onclick="popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','');return false;" class="btnFb"><img src="http://webimage.10x10.co.kr/eventIMG/2016/70195/btn_facebook.png" alt="페이스북" /></a>
				<a href="" onclick="popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>'); return false;" class="btnTw"><img src="http://webimage.10x10.co.kr/eventIMG/2016/70195/btn_twitter.png" alt="트위터" /></a>
			</div>

			<div class="movieInfo">
				<p class="synopsis"><img src="http://webimage.10x10.co.kr/eventIMG/2016/70195/txt_synopsis.png" alt="어벤져스 VS 어벤져스 분열은 시작되었다! 어벤져스와 관련된 사고로 부수적인 피해가 일어나자 정부는 어벤져스를 관리하고 감독하는 시스템인 일명‘슈퍼히어로 등록제’를 내놓는다. 어벤져스 내부는 정부의 입장을 지지하는 찬성파(팀 아이언맨)와 이전처럼 정부의 개입 없이 자유롭게 인류를 보호해야 한다는 반대파(팀 캡틴)로 나뉘어 대립하기 시작하는데..." /></p>
				<div class="bigImage">
					<div class="s00"><iframe width="600" height="350" src="https://www.youtube.com/embed/EDfBPe3URhU" frameborder="0" allowfullscreen></iframe></div>
					<div class="s01"><img src="http://webimage.10x10.co.kr/eventIMG/2016/70195/img_slide_01.jpg" alt="" /></div>
					<div class="s02"><img src="http://webimage.10x10.co.kr/eventIMG/2016/70195/img_slide_02.jpg" alt="" /></div>
					<div class="s03"><img src="http://webimage.10x10.co.kr/eventIMG/2016/70195/img_slide_03.jpg" alt="" /></div>
					<div class="s04"><img src="http://webimage.10x10.co.kr/eventIMG/2016/70195/img_slide_04.jpg" alt="" /></div>
					<div class="s05"><img src="http://webimage.10x10.co.kr/eventIMG/2016/70195/img_slide_05.jpg" alt="" /></div>
					<div class="s06"><img src="http://webimage.10x10.co.kr/eventIMG/2016/70195/img_slide_06.jpg" alt="" /></div>
					<div class="s07"><img src="http://webimage.10x10.co.kr/eventIMG/2016/70195/img_slide_07.jpg" alt="" /></div>
					<div class="s08"><img src="http://webimage.10x10.co.kr/eventIMG/2016/70195/img_slide_08.jpg" alt="" /></div>
					<div class="s09"><img src="http://webimage.10x10.co.kr/eventIMG/2016/70195/img_slide_09.jpg" alt="" /></div>
				</div>
				<div class="preview">
					<button type="button" class="prev"><img src="http://webimage.10x10.co.kr/eventIMG/2016/70195/btn_prev.png" alt="이전" /></button>
					<button type="button" class="next"><img src="http://webimage.10x10.co.kr/eventIMG/2016/70195/btn_next.png" alt="다음" /></button>
					<div class="pagination"></div>
					<div class="swiper-container">
						<div class="swiper-wrapper">
							<div class="swiper-slide s00"><span><img src="http://webimage.10x10.co.kr/eventIMG/2016/70195/img_slide_00.jpg" alt="" /></span></div>
							<div class="swiper-slide s01"><span><img src="http://webimage.10x10.co.kr/eventIMG/2016/70195/img_slide_01.jpg" alt="" /></span></div>
							<div class="swiper-slide s02"><span><img src="http://webimage.10x10.co.kr/eventIMG/2016/70195/img_slide_02.jpg" alt="" /></span></div>
							<div class="swiper-slide s03"><span><img src="http://webimage.10x10.co.kr/eventIMG/2016/70195/img_slide_03.jpg" alt="" /></span></div>
							<div class="swiper-slide s04"><span><img src="http://webimage.10x10.co.kr/eventIMG/2016/70195/img_slide_04.jpg" alt="" /></span></div>
							<div class="swiper-slide s05"><span><img src="http://webimage.10x10.co.kr/eventIMG/2016/70195/img_slide_05.jpg" alt="" /></span></div>
							<div class="swiper-slide s06"><span><img src="http://webimage.10x10.co.kr/eventIMG/2016/70195/img_slide_06.jpg" alt="" /></span></div>
							<div class="swiper-slide s07"><span><img src="http://webimage.10x10.co.kr/eventIMG/2016/70195/img_slide_07.jpg" alt="" /></span></div>
							<div class="swiper-slide s08"><span><img src="http://webimage.10x10.co.kr/eventIMG/2016/70195/img_slide_08.jpg" alt="" /></span></div>
							<div class="swiper-slide s09"><span><img src="http://webimage.10x10.co.kr/eventIMG/2016/70195/img_slide_09.jpg" alt="" /></span></div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="evtNoti">
			<div class="inner">
				<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/70195/tit_noti.png" alt="이벤트 유의사항" /></h3>
				<ul>
					<li>텐바이텐 ID로 로그인 후 응모 가능합니다.</li>
					<li>당첨자는 2016년 4월 27일 수요일에 텐바이텐 홈페이지에서 발표합니다.</li>
					<li>당첨 경품은  선택한 상품에서 변경될 수 있습니다.</li>
					<li>당첨자와 수령자는 동일해야 하며, 당첨 상품 양도는 불가합니다.</li>
					<li>정확한 발표 및 공지를 위해 마이텐바이텐의 개인정보를 업데이트 해주세요.</li>
					<li>이벤트 종료 후 경품 변경은 불가합니다.</li>
				</ul>
			</div>
		</div>
	</div>
	<!--// 텐바이텐X시빌워 -->
<!-- #include virtual="/lib/db/dbclose.asp" -->
