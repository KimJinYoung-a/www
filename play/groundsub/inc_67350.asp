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
' PLAY #26	PRESENT _ 선물말이야  
' 2015-11-13 원승현 작성
'########################################################
Dim eCode , sqlStr , userid , totcnt , iCTotCnt
IF application("Svr_Info") = "Dev" THEN
	eCode   =  "65948"
Else
	eCode   =  "67350"
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
.groundHeadWrap {width:100%; background:url(http://webimage.10x10.co.kr/play/ground/20151116/bg_pattern_slash.png) 0 0 repeat-x; background-size:50px 272px;}
.groundCont {padding-bottom:0; text-align:center; background:url(http://webimage.10x10.co.kr/play/ground/20151116/bg_pattern_slash02.png) 0 100% repeat-x;}
.groundCont .grArea {width:100%;}
.groundCont .tagView {width:1100px; padding:32px 20px 60px; border-top:1px solid #eddbd0;}

.presentCont {position:relative; width:1140px; margin:0 auto;}
.topDeco {height:12px; background:url(http://webimage.10x10.co.kr/play/ground/20151116/bg_pattern_slash.png) 0 100% repeat-x;}
.topDeco div {height:12px; background:url(http://webimage.10x10.co.kr/play/ground/20151116/bg_pattern_triangle.png) 0 100% repeat-x;}
.intro {position:relative; background-color:#fb9175;}
.intro .presentCont {height:525px; padding-top:105px;  background:url(http://webimage.10x10.co.kr/play/ground/20151116/bg_intro.png) 50% 0 no-repeat;}
.intro .title {position:relative;  width:872px; height:217px; margin:0 auto;}
.intro h3 span {display:inline-block; position:absolute; left:0; top:0;}
.intro span.deco {display:inline-block; position:absolute; left:440px; top:0;}
.intro .line {display:inline-block; position:absolute; left:50%; top:399px; width:20px; height:1px; margin-left:-10px; background-color:#fdd0c4;}
.intro .firework {position:absolute; left:50%; top:0; margin-left:-770px;}
.purpose {position:relative; height:580px; background-color:#eee2db;}
.purpose .presentCont {position:absolute; left:50%; bottom:0; width:1226px; height:670px; margin-left:-613px; background:url(http://webimage.10x10.co.kr/play/ground/20151116/img_letter_bag.png) 0 100% no-repeat;}
.purpose .letter {overflow:hidden; position:absolute; left:235px; top:-120px; height:635px; z-index:20;}
.purpose .bag {position:absolute; left:224px; top:283px; width:778px; height:235px; z-index:20; background:url(http://webimage.10x10.co.kr/play/ground/20151116/img_letter_bag02.png) 0 0 no-repeat;}
.presentItem {border-top:20px solid #d6c4ba; border-bottom:10px solid #cec9c7;}
.presentItem .presentCont {height:740px;}
.presentItem .item {height:740px; background-position:50% 0; background-repeat:no-repeat;}
.presentItem .shoes {background-image:url(http://webimage.10x10.co.kr/play/ground/20151116/img_shoes.jpg); background-color:#e5e7f4;}
.presentItem .handkerchief {background-image:url(http://webimage.10x10.co.kr/play/ground/20151116/img_handkerchief.jpg); background-color:#ffcc42;}
.presentItem .wallet {background-image:url(http://webimage.10x10.co.kr/play/ground/20151116/img_wallet.jpg); background-color:#fea792;}
.presentItem .mirror {background-image:url(http://webimage.10x10.co.kr/play/ground/20151116/img_mirror.jpg); background-color:#f0f2f4;}
.presentItem .meaning {overflow:hidden; position:absolute; left:40px; top:102px;}
.presentItem .meaning h4 {float:left;}
.presentItem .meaning p {float:left; padding-left:15px;}
.presentItem .pdtLink {display:block; position:absolute; left:140px; top:300px; width:410px; height:300px; background:url(http://webimage.10x10.co.kr/play/ground/20151116/bg_blank.png) 0 0 repeat; text-indent:-9999px; text-align:left;}
.presentItem .talisman {position:absolute;}
.presentItem .shoes .talisman {right:105px; top:205px;}
.presentItem .handkerchief .talisman {right:100px; top:168px;}
.presentItem .wallet .talisman {right:83px; top:200px;}
.presentItem .mirror .talisman {right:115px; top:140px;}
.presentItem .desc {position:absolute; top:650px; right:22px;}
.presentItem .shoes .deco {position:absolute; left:-500px; bottom:70px; width:536px; height:240px; background:url(http://webimage.10x10.co.kr/play/ground/20151116/bg_shoes.png) 0 0 no-repeat;}
.swipeWrap {position:relative;}
.swipeWrap .swiperNum {position:absolute; left:50%; bottom:40px; z-index:50; width:1320px; height:13px; margin-left:-660px; text-align:center;}
.swipeWrap .swiperNum span {display:inline-block; width:13px; height:13px; margin:0 11px; text-indent:-999em; cursor:pointer; vertical-align:top; z-index:50; transition:all 0.3s; background:url(http://webimage.10x10.co.kr/play/ground/20151116/btn_pagination.png) repeat left top;}
.swipeWrap .swiperNum .swiper-active-switch {background-position:100% 0;}
.swiper {position:relative; width:1320px; height:800px; margin:0 auto;}
.swiper .swiperWrap {position:absolute; left:50%; top:0; width:6600px; margin-left:-3300px;}
.swiper .swiper-container {overflow:hidden; position:relative; width:100%; height:800px;}
.swiper .swiper-wrapper {position:relative; width:100%;}
.swiper .swiper-slide {position:relative; float:left; width:1320px !important;}
.mask {position:absolute; top:0; width:50%; z-index:50; height:800px; background:url(http://webimage.10x10.co.kr/play/ground/20151116/bg_mask.png) repeat 0 0;}
.mask.left {left:0; margin-left:-660px;}
.mask.right {left:50%; margin-left:660px;}
.btmDeco {height:10px; background:url(http://webimage.10x10.co.kr/play/ground/20151116/bg_pattern_triangle02.png) repeat-x 0 0;}
.getTalisman {padding:105px 0 70px;}
.getTalisman h4 {padding-bottom:60px;}
.getTalisman .eventApply {position:relative; width:909px; margin:0 auto; padding-bottom:72px;}
.getTalisman .btnApply {position:absolute; left:579px; top:239px;}
.getTalisman .count span {position:relative; display:inline-block; height:55px; padding:5px 35px 0 25px; background:url(http://webimage.10x10.co.kr/play/ground/20151116/bg_count_rt.png) no-repeat 100% 0;}
.getTalisman .count span:after {content:' '; display:inline-block; position:absolute; left:-10px; top:0; width:10px; height:60px; background:url(http://webimage.10x10.co.kr/play/ground/20151116/bg_count_lt.png) no-repeat 100% 0;}
.getTalisman .count strong {color:#4e3d38; font-size:35px; line-height:45px; padding:0 10px 0 14px; font-family:verdana; vertical-align:top;}
</style>
<script type="text/javascript">
<!--
 	function jsSubmitComment(){
		<% if Not(IsUserLoginOK) then %>
		    jsChklogin('<%=IsUserLoginOK%>');
		    return false;
		<% end if %>


	   <% if totcnt >= 5 then %>
			alert("최대 5회까지만 참여하실 수 있습니다.");
			return false;
	   <% end if %>
	   
	   var frm = document.frmcom;
	   frm.action = "/play/groundsub/doeventsubscript67350.asp";
	   frm.submit();
	   return true;
	}



//-->
</script>
<div class="groundCont">
	<div class="grArea">
		<div class="playGr20151116">
			<div class="topDeco"><div></div></div>
			<div class="intro">
				<div class="presentCont">
					<div class="title">
						<h3>
							<span class="t01"><img src="http://webimage.10x10.co.kr/play/ground/20151116/tit_present01.png" alt="선물 말-이야" /></span>
							<span class="t02"><img src="http://webimage.10x10.co.kr/play/ground/20151116/tit_present02.png" alt="" /></span>
							<span class="t03"><img src="http://webimage.10x10.co.kr/play/ground/20151116/tit_present03.png" alt="" /></span>
							<span class="t04"><img src="http://webimage.10x10.co.kr/play/ground/20151116/txt_dash.png" alt="" /></span>
							<span class="t05"><img src="http://webimage.10x10.co.kr/play/ground/20151116/tit_present04.png" alt="" /></span>
							<span class="t06"><img src="http://webimage.10x10.co.kr/play/ground/20151116/tit_present05.png" alt="" /></span>
							<span class="t07"><img src="http://webimage.10x10.co.kr/play/ground/20151116/bg_title.png" alt="" /></span>
						</h3>
						<span class="deco"><img src="http://webimage.10x10.co.kr/play/ground/20151116/ico_present.png" alt="" /></span>
					</div>
					<p class="copy"><img src="http://webimage.10x10.co.kr/play/ground/20151116/txt_copy.png" alt="선물에 의미를 더해줄 부적" /></p>
					<span class="line"></span>
				</div>
				<div class="firework"><img src="http://webimage.10x10.co.kr/play/ground/20151116/bg_firework.png" alt="" /></div>
			</div>
			<div class="purpose">
				<div class="presentCont">
					<div class="letter"><p><img src="http://webimage.10x10.co.kr/play/ground/20151116/txt_letter.png" alt="꽃에는 그 의미를 지칭하는 꽃말들이 있습니다. 선물에도 미신처럼 따라다니는 선물말이 있습니다. 주는 사람을 망설여지게 하거나, 받는 사람에게 한 번쯤 생각하게 만드는 여러 가지 의미와 미신들! 하지만 이제 이 부적들과 함께 마음 놓고 선물하고, 좋은 의미는 더욱 재미있게 만들어보세요!" /></p></div>
					<div class="bag"></div>
				</div>
			</div>
			<!-- 아이템 소개 -->
			<div class="presentItem">
				<div class="item shoes">
					<div class="presentCont">
						<div class="meaning">
							<h4><img src="http://webimage.10x10.co.kr/play/ground/20151116/txt_shoes.png" alt="신발" /></h4>
							<p><img src="http://webimage.10x10.co.kr/play/ground/20151116/txt_shoes_desc.png" alt="연인에게 신발을 선물하면 그 신발을 신고 떠나 헤어지게 된다." /></p>
						</div>
						<a href="/shopping/category_prd.asp?itemid=1188907" class="pdtLink">[Excelsior] Low Cut, U3199</a>
						<div class="talisman"><img src="http://webimage.10x10.co.kr/play/ground/20151116/img_talisman_shoes.png" alt="부적이미지" /></div>
						<p class="desc"><img src="http://webimage.10x10.co.kr/play/ground/20151116/txt_talisman01.png" alt="신발을 선물할 땐 이별택시 부적" /></p>
						<div class="deco"></div>
					</div>
				</div>
				<div class="item handkerchief">
					<div class="presentCont">
						<div class="meaning">
							<h4><img src="http://webimage.10x10.co.kr/play/ground/20151116/txt_handkerchief.png" alt="손수건" /></h4>
							<p><img src="http://webimage.10x10.co.kr/play/ground/20151116/txt_handkerchief_desc.png" alt="손수건은 슬픔을 의미해서 눈물을 부른다." /></p>
						</div>
						<a href="/shopping/category_prd.asp?itemid=1285323" class="pdtLink">아이코닉 에브리데이 행키 v.3</a>
						<div class="talisman"><img src="http://webimage.10x10.co.kr/play/ground/20151116/img_talisman_handkerchief.png" alt="부적이미지" /></div>
						<p class="desc"><img src="http://webimage.10x10.co.kr/play/ground/20151116/txt_talisman02.png" alt="손수건을 선물할 땐 울면 안돼 부적" /></p>
					</div>
				</div>
				<div class="item wallet">
					<div class="presentCont">
						<div class="meaning">
							<h4><img src="http://webimage.10x10.co.kr/play/ground/20151116/txt_wallet.png" alt="지갑" /></h4>
							<p><img src="http://webimage.10x10.co.kr/play/ground/20151116/txt_wallet_desc.png" alt="빨간 지갑을 선물하며 돈을 넣어 주면, 부자가 된다." /></p>
						</div>
						<a href="/shopping/category_prd.asp?itemid=1339984" class="pdtLink">Fennec Mini Pocket Red</a>
						<div class="talisman"><img src="http://webimage.10x10.co.kr/play/ground/20151116/img_talisman_wallet.png" alt="부적이미지" /></div>
						<p class="desc"><img src="http://webimage.10x10.co.kr/play/ground/20151116/txt_talisman03.png" alt="지갑을 선물할 땐 돈 들어와 부적" /></p>
					</div>
				</div>
				<div class="item mirror">
					<div class="presentCont">
						<div class="meaning">
							<h4><img src="http://webimage.10x10.co.kr/play/ground/20151116/txt_mirror.png" alt="거울" /></h4>
							<p><img src="http://webimage.10x10.co.kr/play/ground/20151116/txt_mirror_desc.png" alt="나의 있는 그대로를 사랑해주고, 나만 바라봐 주기를." /></p>
						</div>
						<a href="/shopping/category_prd.asp?itemid=1114756" class="pdtLink">THE MIRROR</a>
						<div class="talisman"><img src="http://webimage.10x10.co.kr/play/ground/20151116/img_talisman_mirror.png" alt="부적이미지" /></div>
						<p class="desc"><img src="http://webimage.10x10.co.kr/play/ground/20151116/txt_talisman04.png" alt="거울을 선물할 땐 경국지색 부적" /></p>
					</div>
				</div>
			</div>
			<!--// 아이템 소개 -->
			<div class="swipeWrap">
				<div class="swiper">
					<div class="swiperWrap">
						<div class="swiper-container">
							<div class="swiper-wrapper">
								<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/play/ground/20151116/img_slide04.jpg" alt="" /></div>
								<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/play/ground/20151116/img_slide05.jpg" alt="" /></div>
								<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/play/ground/20151116/img_slide01.jpg" alt="" /></div>
								<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/play/ground/20151116/img_slide02.jpg" alt="" /></div>
								<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/play/ground/20151116/img_slide03.jpg" alt="" /></div>
							</div>
						</div>
					</div>
				</div>
				<div class="swiperNum"></div>
				<div class="mask left"></div>
				<div class="mask right"></div>
			</div>
			<div class="btmDeco"><div></div></div>
			<!-- 이벤트 참여 -->
			<div class="getTalisman" id="tGetTalisman">
				<div class="presentCont">
					<h4><img src="http://webimage.10x10.co.kr/play/ground/20151116/tit_event.png" alt="선물말이야 이벤트" /></h4>
					<div class="eventApply">
						<div><img src="http://webimage.10x10.co.kr/play/ground/20151116/txt_event.png" alt="지금 선물을 망설이거나 고민 중이신가요? 이 부적 카드들과 함께 자신 있게, 즐겁게 선물하세요! 응모해주신 분들  중 추첨을 통해 총 5분에게  선물말이야 부적 PACK 을 드립니다." /></div>
						<input type="image" src="http://webimage.10x10.co.kr/play/ground/20151116/btn_apply.png" alt="응모하기" class="btnApply" onclick="jsSubmitComment();return false;" />
					</div>
					<div class="count">
						<span>
							<img src="http://webimage.10x10.co.kr/play/ground/20151116/txt_count01.png" alt="총" />
							<strong><%=iCTotCnt%></strong><img src="http://webimage.10x10.co.kr/play/ground/20151116/txt_count02.png" alt="명이 부적카드를 신청했습니다." />
						</span>
					</div>
				</div>
			</div>
			<!--// 이벤트 참여 -->
		</div>
	</div>
</div>
<form name="frmcom" method="post">
	<input type="hidden" name="giftUserId" value="<%=userid%>">
</form>
<script>
$(function(){
	//animation
	function moveBalloon() {
		$(".intro .deco").animate({"margin-top":"0"},400).animate({"margin-top":"-5px"},400, moveBalloon);
	}
	$('.intro .firework').css({"margin-top":"-10px","opacity":"0"});
	$('.intro h3 span').css({"margin-left":"-8px","opacity":"0"});
	$('.intro h3 span.t07').css({"margin-left":"0","margin-top":"10px"});
	$('.intro .deco').css({"opacity":"0"});
	$('.intro .copy').css({"margin-top":"5px","opacity":"0"});
	function intro() {
		conChk = 1;
		$('.intro h3 .t07').animate({"margin-top":"-5px","opacity":"1"},600).animate({"margin-top":"0"},600);
		$('.intro h3 .t01').delay(500).animate({"margin-left":"0","opacity":"1"},400);
		$('.intro h3 .t02').delay(700).animate({"margin-left":"0","opacity":"1"},400);
		$('.intro h3 .t03').delay(900).animate({"margin-left":"0","opacity":"1"},400);
		$('.intro h3 .t04').delay(1300).animate({"margin-left":"0","opacity":"1"},400);
		$('.intro h3 .t05').delay(1500).animate({"margin-left":"0","opacity":"1"},400);
		$('.intro h3 .t06').delay(1700).animate({"margin-left":"0","opacity":"1"},400);
		$('.intro .deco').delay(2000).animate({"opacity":"1"},600);
		moveBalloon();
		$('.intro .firework').delay(2100).animate({"margin-top":"0","opacity":"1"},1000).effect("pulsate", {times:2},300 );
		$('.intro .copy').delay(3800).animate({"margin-top":"0","opacity":"1"},1000);
	}
	$('.letter p').css({"margin-top":"360px"});
	$('.talisman').css({"margin-right":"30px","opacity":"0"});

	var mySwiper = new Swiper('.swiper-container',{
		slidesPerView:5,
		loop: true,
		speed:1800, 
		autoplay:4000,
		simulateTouch:false,
		pagination:'.swiperNum',
		paginationClickable:true
	});
	var conChk = 0;
	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 300 ) {
			if (conChk==0){
				intro()
			}
		}
		if (scrollTop > 820 ) {
			$('.letter p').animate({"margin-top":"0"},800);
		}
		if (scrollTop > 1650 ) {
			$('.shoes .talisman').animate({"margin-right":"0","opacity":"1"},500);
		}
		if (scrollTop > 2350 ) {
			$('.handkerchief .talisman').animate({"margin-right":"0","opacity":"1"},500);
		}
		if (scrollTop > 3050 ) {
			$('.wallet .talisman').animate({"margin-right":"0","opacity":"1"},500);
		}
		if (scrollTop > 3800 ) {
			$('.mirror .talisman').animate({"margin-right":"0","opacity":"1"},500);
		}
	});
});
</script>

<!-- #include virtual="/lib/db/dbclose.asp" -->