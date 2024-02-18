<%@  codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<%
'########################################################
' PLAY #23 summer 5주차 
' 2015-08-28 이종화 작성
'########################################################
Dim eCode , sqlStr , userid , totcnt , iCTotCnt
IF application("Svr_Info") = "Dev" THEN
	eCode   =  "64868"
Else
	eCode   =  "65880"
End If

userid = GetEncLoginUserID

If GetEncLoginUserID <> "" then
	sqlStr = "select count(*) from db_event.dbo.tbl_event_subscript where userid = '"& userid &"' and evt_code = '"& ecode &"' " 
	rsget.CursorLocation = adUseClient
	rsget.Open sqlStr, dbget, adOpenForwardOnly, adLockReadOnly 

	IF Not rsget.Eof Then
		totcnt = rsget(0)
	End IF
	rsget.close()
End If 

	sqlStr = "select count(*) from db_event.dbo.tbl_event_subscript where evt_code = '"& ecode &"' " 
	rsget.CursorLocation = adUseClient
	rsget.Open sqlStr, dbget, adOpenForwardOnly, adLockReadOnly 

	IF Not rsget.Eof Then
		iCTotCnt = rsget(0)
	End IF
	rsget.close()
%>
<style type="text/css">
img {vertical-align:top;}
.playGr20150831 {overflow:hidden; text-align:center;}
.intro {position:relative; height:1220px; text-align:left; background:url(http://webimage.10x10.co.kr/play/ground/20150831/bg_intro.gif) 50% 0 no-repeat;}
.intro .starFall {position:absolute; left:50%; width:1920px; height:1368px; margin-left:-960px; z-index:40; background-position:50% 0; background-repeat:no-repeat; opacity:0;}
.intro .f01 {top:30px; background-image:url(http://webimage.10x10.co.kr/play/ground/20150831/bg_point_star01.png);}
.intro .f02 {top:5px; background-image:url(http://webimage.10x10.co.kr/play/ground/20150831/bg_point_star02.png);}
.intro .title {position:absolute; left:262px; top:266px; width:656px; height:574px; background:url(http://webimage.10x10.co.kr/play/ground/20150831/bg_tv.png) 0 0 no-repeat; z-index:50;}
.intro .title h2 {position:relative; margin:51px 0 0 57px;}
.intro .title h2 div {overflow:hidden;}
.intro .title h2 div p {overflow:hidden; float:left; height:107px; padding-right:35px;}
.intro .title h2 div p img {display:inline-block;}
.intro .title h2 div p.t01 img {margin-top:108px;}
.intro .title h2 div p.t02 img {margin-top:-108px;}
.intro .title h2 div p.t03 img {margin-top:108px;}
.intro .title h2 div p.t04 img {margin-top:-108px;}
.intro .title .line {position:absolute; top:125px; width:0; height:9px; background:#fff;}
.intro .title .line01 {left:1px;}
.intro .title .line02 {left:282px;}
.intro .with {padding:157px 0 0 132px;}
.intro .project {text-align:center; padding-top:934px;}
.purpose {/*height:825px;*/ background:url(http://webimage.10x10.co.kr/play/ground/20150831/bg_blue01.gif) 50% 0 no-repeat; background-size:100% 100%;}
.purpose .storySlide {overflow:hidden; width:1140px;}
.purpose .swiper-slide {overflow:hidden; height:300px;}
.purpose .swiper-slide p {padding-bottom:38px;}
.purpose .swiper-slide.scene02 p {margin-top:250px; opacity:0;}
.purpose .swiper-slide.scene03 p {margin-top:250px; opacity:0;}
.rooftopTv {height:1516px; padding-top:147px; background:url(http://webimage.10x10.co.kr/play/ground/20150831/bg_blue02.gif) 50% 0 no-repeat;}
.rooftopView {overflow:hidden; position:relative; width:265px; height:186px; margin:0 auto;}
.rooftopView span {display:inline-block; position:absolute; left:0; height:25px; background-position:0 0; background-repeat:no-repeat;}
.rooftopView span.t01 {top:0; background-image:url(http://webimage.10x10.co.kr/play/ground/20150831/txt_tv01.gif)}
.rooftopView span.t02 {top:49px; background-image:url(http://webimage.10x10.co.kr/play/ground/20150831/txt_tv02.gif)}
.rooftopView span.t03 {top:100px; background-image:url(http://webimage.10x10.co.kr/play/ground/20150831/txt_tv03.gif)}
.rooftopView span.t04 {bottom:-40px;}
.rooftopView span.line {left:50%; bottom:0; height:1px; width:0; margin-left:0; background:#fff;}
.tenDayInfo {height:1190px; background:url(http://webimage.10x10.co.kr/play/ground/20150831/bg_blue03.gif) 50% 0 no-repeat;}
.tenDayInfo .summerCont {width:1760px; height:784px; margin-top:124px; background:url(http://webimage.10x10.co.kr/play/ground/20150831/bg_rooftop_tv.png) 0 65px no-repeat;}
.tenDayInfo .deco {position:absolute;}
.tenDayInfo .d01 {left:400px; top:524px;}
.tenDayInfo .d02 {left:543px; top:-2px;}
.tenDayInfo .d03 {left:850px; top:710px; -webkit-animation-duration:4000ms; -webkit-animation-iteration-count: infinite; -webkit-animation-timing-function: linear; -moz-animation-duration:4000ms; -moz-animation-iteration-count: infinite; -moz-animation-timing-function: linear; -ms-animation-duration:4000ms; -ms-animation-iteration-count: infinite; -ms-animation-timing-function: linear; animation-duration:4000ms; animation-iteration-count: infinite; animation-timing-function: linear; animation-name:spin; -webkit-animation-name:spin; -moz-animation-name: spin; -ms-animation-name: spin;}
.aboutMic {height:625px; padding-top:200px; background:url(http://webimage.10x10.co.kr/play/ground/20150831/bg_sky01.gif) 50% 0 no-repeat;}
.aboutMic .infoSlide .slidesjs-slide a {display:block; position:absolute; height:20px; text-indent:-9999px;}
.aboutMic .infoSlide a.goLink01 {left:475px; top:200px; width:230px;}
.aboutMic .infoSlide a.goLink02 {left:395px; top:46px; width:295px;}
.aboutMic .slidesjs-pagination {position:absolute; left:50%; top:370px; width:48px; margin-left:-24px; z-index:30;}
.aboutMic .slidesjs-pagination li {float:left; width:12px; padding:0 6px;}
.aboutMic .slidesjs-pagination li a {display:block; height:12px; background:#8a8b8d; text-indent:-9999px; border-radius:50%;}
.aboutMic .slidesjs-pagination li a.active {background:#3db8d0;}
.aboutMic .moon {position:absolute; left:29px; top:-80px;}
.applyTv .sky {background:url(http://webimage.10x10.co.kr/play/ground/20150831/bg_sky02.gif) 50% 0 no-repeat;}
.applyTv .sky .summerCont {height:454px; background-position:0 0; background-repeat:no-repeat;}
.applyTv .sky .star01 {background-image:url(http://webimage.10x10.co.kr/play/ground/20150831/bg_star01.png);}
.applyTv .sky .star02 {background-image:url(http://webimage.10x10.co.kr/play/ground/20150831/bg_star02.png);}
.applyTv .sky .star03 {background-image:url(http://webimage.10x10.co.kr/play/ground/20150831/bg_star03.png);}
.applyTv .sky .star04 {background-image:url(http://webimage.10x10.co.kr/play/ground/20150831/bg_star04.png);}
.applyTv .sky .star05 {background-image:url(http://webimage.10x10.co.kr/play/ground/20150831/bg_star05.png);}
.applyTv .invite {height:444px; background:url(http://webimage.10x10.co.kr/play/ground/20150831/bg_invite.gif) 50% 0 no-repeat;}
.applyTv .invite .summerCont {overflow:hidden; padding-top:75px;}
.applyTv .invite .ftRt {text-align:right; margin-top:-17px;}
.applyTv .invite .count {padding:22px 17px 0 0; color:#94e3f8;}
.applyTv .invite .count strong {display:inline-block; position:relative; top:-2px; vertical-align:top; font-size:32px; line-height:26px; padding:0 5px 0 12px; font-family:tahoma; font-weight:normal;}
@-ms-keyframes spin {from {-ms-transform: rotate(0deg);} to {-ms-transform: rotate(360deg);}}
@-moz-keyframes spin {from { -moz-transform: rotate(0deg);} to { -moz-transform: rotate(360deg);}}
@-webkit-keyframes spin {from { -webkit-transform: rotate(0deg);} to { -webkit-transform: rotate(360deg);}}
@keyframes spin {from {transform:rotate(0deg);} to { transform:rotate(-360deg);}}
.text p {position:relative; top:5px; padding-bottom:15px; opacity:0;}
.goApply {opacity:0;}
@media all and (min-width:1920px){
	.fullBg {background-size:100% 100% !important;}
}
</style>
<script type="text/javascript">
<!--
 	function jsSubmitComment(frm){
		<% if Not(IsUserLoginOK) then %>
		    jsChklogin('<%=IsUserLoginOK%>');
		    return false;
		<% end if %>
	   
	   var frm = document.frmcom;
	   frm.action = "/play/groundsub/doeventsubscript65880.asp";
	   frm.submit();
	   return true;
	}

//	if($(':radio[name="votet"]:checked').length < 1){
//			alert('');						
//			return false;
//	}

$(function(){
	$('.infoSlide').slidesjs({
		width:"1124",
		height:"312",
		navigation:false,
		pagination:{effect:"slide"},
		play: {interval:4500, effect:"slide", auto:false},
		effect:{slide: {speed:1000}
		},
		callback: {
			complete: function(number) {
				var pluginInstance = $('.infoSlide').data('plugin_slidesjs');
				setTimeout(function() {
					pluginInstance.play(true);
				}, pluginInstance.options.play.interval);
			}
		}
	});
	function intro() {
		$('.intro .f01').animate({"top":"0","opacity":"1"}, 3000);
		$('.intro .f02').animate({"top":"0","opacity":"1"}, 2000);
		$('.intro .line').animate({"width":"95px"}, 800);
		$('.intro .title h2 div p img').delay(800).animate({"margin-top":"0"}, 1000);
	}
	function moveStar() {
		$(".f01").animate({"opacity":"1"},1000).animate({"opacity":"0.5"},1500, moveStar);
		$(".f02").animate({"opacity":"0.5"},2000).animate({"opacity":"1"},1000, moveStar);
	}
	function purpose () {
		$('.tt01').animate({"top":"0","opacity":"1"}, 800);
		$('.tt02').delay(800).animate({"top":"0","opacity":"1"}, 800);

		$('.tt03').delay(1400).animate({"top":"0","opacity":"1"}, 800);
		$('.tt04').delay(2000).animate({"top":"0","opacity":"1"}, 800);
		$('.tt05').delay(2500).animate({"top":"0","opacity":"1"}, 800);

		$('.tt06').delay(3300).animate({"top":"0","opacity":"1"}, 800);
		$('.tt07').delay(4000).animate({"top":"0","opacity":"1"}, 800);
		$('.goApply').delay(4200).animate({"opacity":"1"}, 800);
	}
	$(".goApply").click(function(event){
		event.preventDefault();
		window.parent.$('html,body').animate({scrollTop:$(this.hash).offset().top}, 800);
	});
	function view() {
		$('.rooftopView span.t01').animate({"width":"220px"}, 800);
		$('.rooftopView span.t02').delay(800).animate({"width":"178px"}, 800);
		$('.rooftopView span.t03').delay(1600).animate({"width":"240px"}, 800);
		$('.rooftopView span.line').delay(2000).animate({"width":"100%","margin-left":"-133px"}, 800);
		$('.rooftopView span.t04').delay(2600).animate({"bottom":"12px"}, 800);
	}
	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 300 ) {
			intro();
			moveStar();
		}
		if (scrollTop > 1150 ) {
			purpose();
		}
		if (scrollTop > 2400 ) {
			view();
		}
	});
});
//-->
</script>
<div class="playGr20150831">
	<div class="intro fullBg">
		<div class="starFall f01"></div>
		<div class="starFall f02"></div>
		<div class="summerCont">
			<div class="title">
				<p class="with"><img src="http://webimage.10x10.co.kr/play/ground/20150831/txt_tenten_micimpact.png" alt="텐바이텐X마이크임팩트" /></p>
				<h2>
					<div>
						<p class="t01"><img src="http://webimage.10x10.co.kr/play/ground/20150831/tit_rooftop1.png" alt="옥" /></p>
						<p class="t02 tMar30"><img src="http://webimage.10x10.co.kr/play/ground/20150831/tit_rooftop2.png" alt="상" /></p>
						<p class="t03"><img src="http://webimage.10x10.co.kr/play/ground/20150831/tit_rooftop3.png" alt="티" /></p>
						<p class="t04 tMar30"><img src="http://webimage.10x10.co.kr/play/ground/20150831/tit_rooftop4.png" alt="비" /></p>
					</div>
					<span class="line line01"></span>
					<span class="line line02"></span>
				</h2>
			</div>
			<p class="project"><img src="http://webimage.10x10.co.kr/play/ground/20150831/txt_sensitivity.png" alt="버쩍 마른 감수성 찾기 프로젝트" /></p>
		</div>
	</div>
	<div class="purpose fullBg">
		<div class="summerCont">
			<div class="storySlide">
				<div class="text">
					<div><img src="http://webimage.10x10.co.kr/play/ground/20150831/img_mic.png" alt="" /></div>
					<p class="tt01"><img src="http://webimage.10x10.co.kr/play/ground/20150831/txt_purpose01_01.png" alt="옥상에 대한 로망이 있으신가요?" /></p>
					<p class="tt02"><img src="http://webimage.10x10.co.kr/play/ground/20150831/txt_purpose01_02.png" alt="가장 높이, 넓은 공간을 품고 있는 멋진 곳 눈 앞으로는 동네를 한 가득, 하늘 위로는 쏟아지는 별을 가득 느낄 수 있습니다." /></p>
					<p class="tt03" style="margin:75px 0 0;"><img src="http://webimage.10x10.co.kr/play/ground/20150831/txt_purpose02_01.png" alt="나중에 꼭 넓은 옥상이 있는 집이 생기면" /></p>
					<p class="tt04"><img src="http://webimage.10x10.co.kr/play/ground/20150831/txt_purpose02_02.png" alt="사랑하는 친구들과 맛있는 음식, 내가 좋아하는 것들을 마음껏 나누고 싶다 생각했습니다." /></p>
					<p class="tt05"><img src="http://webimage.10x10.co.kr/play/ground/20150831/txt_purpose02_03.png" alt="어느덧 여름이 지나고, 기분 좋은 시원한 바람이 불어옵니다. 한 여름 밤을 다시 한번 기억하며" /></p>
					<p class="tt06" style="margin:75px 0 0;"><img src="http://webimage.10x10.co.kr/play/ground/20150831/txt_purpose03_01.png" alt="평범할 수 있지만, 특별한 공간에서의 특별한 시간" /></p>
					<p class="tt07" style="margin-bottom:40px;"><img src="http://webimage.10x10.co.kr/play/ground/20150831/txt_purpose03_02.png" alt="옥상티비 텐바이텐 DAY에 여러분을 초대합니다. 당신의 소중한 사람들과 함께 도심 속 옥상으로 놀러 오세요" /></p>
					<a href="#applyTv" class="goApply"><img src="http://webimage.10x10.co.kr/play/ground/20150831/btn_go_apply.png" alt="옥상티비 신청하러 가기" /></a>
				</div>
			</div>
		</div>
	</div>
	<div class="rooftopTv fullBg">
		<div class="summerCont">
			<div class="bPad30"><img src="http://webimage.10x10.co.kr/play/ground/20150831/img_character.png" alt="마이크임팩트 캐릭터" /></div>
			<p class="rooftopView">
				<img src="http://webimage.10x10.co.kr/play/ground/20150831/txt_tv_view.gif" alt="탁 트인 도심 속 옥상에서 시원한 밤 공기와 함께 영화를 관람 할 수 있는" />
				<span class="t01"></span>
				<span class="t02"></span>
				<span class="t03"></span>
				<span class="t04"><img src="http://webimage.10x10.co.kr/play/ground/20150831/txt_tv04.gif" alt="" /></span>
				<span class="line"></span>
			</p>
			<div style="padding-top:114px;"><img src="http://webimage.10x10.co.kr/play/ground/20150831/img_concert.png" alt="" /></div>
			<p style="padding-top:80px;"><img src="http://webimage.10x10.co.kr/play/ground/20150831/txt_tip.png" alt="마이크임팩트 옥상티비는 5월~9월 매주 목요일 저녁 8시에 상시 진행되며, 참여 비용, 신청 등 복잡한 절차 없이 참여가 가능하오니 많은 관심 바랍니다" /></p>
		</div>
	</div>
	<div class="tenDayInfo fullBg">
		<p><img src="http://webimage.10x10.co.kr/play/ground/20150831/txt_ten_day.png" alt="옥상티비 텐바이텐DAY 안내:한 팀당 (2인 한 팀) 맥주 2병과 간단한 간식이 제공됩니다. 추첨을 통해 텐바이텐이 준비한 스페셜 기프트를 드립니다. 맛있는 음식과, 돗자리를 가지고 오신다면 옥상티비를 더욱 즐겁게 관람하실 수 있어요! 우천 시, 옥상티비 텐바이텐 day는 취소됩니다." /></p>
		<div class="summerCont">
			<div><img src="http://webimage.10x10.co.kr/play/ground/20150831/img_benefit.png" alt="문라이즈 킹덤:12살 소년 소녀가 감쪽같이 사라졌다?! 여름의 끝, 뉴 펜잔스 섬을 발칵 뒤집어 놓은 기상천외 실종사건" /></div>
			<div class="deco d01"><img src="http://webimage.10x10.co.kr/play/ground/20150831/img_deco_line.gif" alt="" /></div>
			<div class="deco d02"><img src="http://webimage.10x10.co.kr/play/ground/20150831/img_deco_triangle.gif" alt="" /></div>
			<div class="deco d03"><img src="http://webimage.10x10.co.kr/play/ground/20150831/img_deco_triangle02.png" alt="" /></div>
		</div>
	</div>
	<div class="aboutMic fullBg">
		<div class="summerCont">
			<div class="moon"><img src="http://webimage.10x10.co.kr/play/ground/20150831/img_moon.gif" alt="" /></div>
			<div class="infoSlide">
				<div>
					<img src="http://webimage.10x10.co.kr/play/ground/20150831/txt_brand_info01.png" alt="" />
					<a href="http://square.micimpact.com" class="goLink01" target="_blank">마이크임팩트 바로가기</a>
				</div>
				<div>
					<img src="http://webimage.10x10.co.kr/play/ground/20150831/txt_brand_info02.png" alt="" />
					<a href="http://wonderwomanfestival.com/2015/ " class="goLink02" target="_blank">원더우먼 페스티벌 바로가기</a>
				</div>
			</div>
		</div>
	</div>
	<!-- 응모하기 -->
	<form name="frmcom" method="post" style="margin:0px;">
	<div class="applyTv" id="applyTv" >
		<div class="sky fullBg">
			<div class="summerCont star0<%=totcnt%>"></div>
		</div>
		<div class="invite fullBg">
			<div class="summerCont">
				<p class="ftLt"><img src="http://webimage.10x10.co.kr/play/ground/20150831/txt_invite.png" alt="한 여름 밤을 다시 한번 추억 할 옥상티비 텐바이텐DAY에 여러분들 초대합니다. 응모하신 분들 중 50명(1인 2매)을 추첨해 옥상티비 텐바이텐DAY 티켓을 선물로 드립니다." /></p>
				<div class="ftRt">
					<a href="#" onclick="jsSubmitComment();return false;"><img src="http://webimage.10x10.co.kr/play/ground/20150831/btn_apply.png" alt="응모하기" /></a>
					<p class="count">
						<img src="http://webimage.10x10.co.kr/play/ground/20150831/txt_count01.png" alt="총" />
						<strong><%=iCTotCnt%></strong>
						<img src="http://webimage.10x10.co.kr/play/ground/20150831/txt_count02.png" alt="개의 별이 떴습니다." />
					</p>
				</div>
			</div>
		</div>
	</div>
	</form>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->