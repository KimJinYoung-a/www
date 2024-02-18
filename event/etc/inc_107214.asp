<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<%
'#################################################################
' Description : 탐앤탐스 이벤트 - 놀러와 우리의 다꾸홈카페로
' History : 2020-11-12 허진원
'#################################################################
%>
<%
Dim userid, currentDate, eventStartDate, eventEndDate
currentDate =  now()
userid = GetEncLoginUserID()
eventStartDate  = cdate("2020-11-18")		'이벤트 시작일
eventEndDate 	= cdate("2020-12-01")		'이벤트 종료일

if userid="ley330" or userid="greenteenz" or userid="rnldusgpfla" or userid="kobula" or userid="thensi7" or userid = "motions" or userid = "jj999a" or userid = "phsman1" or userid = "jjia94" or userid = "seojb1983" or userid = "kny9480" or userid = "bestksy0527" or userid = "mame234" or userid = "corpse2" or userid = "starsun726" then
	currentDate = #11/19/2020 09:00:00#
end if

Dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  103266
Else
	eCode   =  107214
End If

dim subscriptcount
	

If userid <> "" then
	'금일 참여횟수 확인
	subscriptcount = getevent_subscriptexistscount(eCode, userid, left(currentDate,10), "", "")
Else
	subscriptcount = 0
End If
%>
<style type="text/css">
.evt107214 .section-01 {background:#fff;}
.evt107214 .section-02 {padding-bottom:80px; background:#fef6eb;}
.evt107214 .section-02 .input-area {display:flex; align-items:center; justify-content:center; padding-bottom:104px;}
.evt107214 .section-02 .input-area button {width:110px; height:81px; font-size:28px; color:#fff; font-weight:700; background-color: rgb(87, 42, 49);} 
.evt107214 .section-02 .input-area input {width:398px; height:79px; margin-right:5px; padding-left:43px; border:1px solid #572931; border-radius:0; font-size:22px; color:#999; font-weight:700;}
.evt107214 .section-02 .input-area input::placeholder {font-size:22px; color:#999; font-weight:700;}
.evt107214 .section-03 {padding-bottom:80px; background:#fcead3;}
.evt107214 .section-03 .detail-area {padding:0 27px; background:#fff;}
.evt107214 .section-03 .detail-area .info {display:none;}
.evt107214 .section-03 .detail-area .tit {position:relative; height:56px; line-height:56px; padding-left:19px; text-align:left; background:#572a31; font-size:26px; color:#fff; font-weight:700; cursor:pointer;}
.evt107214 .section-03 .detail-area .tit:after {content:""; display:inline-block; position:absolute; right:29px; top:23px; width:19px; height:12px; background:url(//webimage.10x10.co.kr/fixevent/event/2020/107214/icon_arrow.png) no-repeat 0 0; background-size:100%; transition: .5s ease;}
.evt107214 .section-03 .detail-area .tit.rotate:after {transform:rotate(180deg);}
.evt107214 .section-03 .item-area {width:1100px; margin:0 auto; display:flex; align-items:flex-start; justify-content:space-between;}
.evt107214 .section-03 .glft-content {padding-bottom:50px; background:#fff; border-radius:0 0 50px 50px;}
.evt107214 .section-04 {background:#fff6ec;}
.evt107214 .section-04 {padding-bottom:80px;}
.evt107214 .section-04 .info-detail {position:relative; width:1100px; margin:80px auto 0;}
.evt107214 .section-04 .info-detail .txt01 {position:absolute; left:0; top:314px;}
.evt107214 .section-04 .info-detail .txt02 {position:absolute; right:0; bottom:81px;}
.evt107214 .section-04 .info-detail .txt-box {height:189px; width:1000px; margin:0 auto; background:#ffb800;}
.evt107214 .section-04 .info-detail .txt-box img {padding-top:40px;}
.evt107214 .section-05 {background:#572931;}
.evt107214 .pop-container {display:none; position:fixed; left:0; top:0; width:100vw; height:100vh; background-color:rgba(0, 0, 0,0.702); z-index:150;}
.evt107214 .pop-container .pop-inner {position:relative; width:100%; height:100%; padding-top:98px;}
.evt107214 .pop-container .pop-inner a {display:inline-block;}
.evt107214 .pop-container .pop-inner .btn-close {position:absolute; right:28px; top:28px; width:41px; height:41px; background:url(//webimage.10x10.co.kr/fixevent/event/2020/107214/icon_close.png) no-repeat 0 0; background-size:100%; text-indent:-9999px;} 
.evt107214 .pop-container .pop-contents {position:relative; width:584px; margin:0 auto;}
.evt107214 .vod-wrap {position:relative; width:920px; height:520px; margin:0 auto;}
.evt107214 .vod-wrap .vod video {width:920px; height:520px; position:absolute; top:0; left:0; bottom:0; width:100%; height:100%;}
.evt107214 .vod-wrap .btn-play {position:absolute; top:0; left:0; width:100%; height:100%; z-index:10; background:transparent;}
.evt107214 .vod-wrap .btn-play:after {content:''; width:920px; height:520px; position:absolute; top:50%; left:50%; transform:translate(-50%, -50%); background:url(//webimage.10x10.co.kr/fixevent/event/2020/107214/img_play.png) 0 0 no-repeat; background-size:100% auto; z-index:-1;}
.evt107214 .slide-wrap {position:relative;}
.evt107214 .slide-wrap .story-slider {position:relative;width:950px; height:560px; margin:0 auto; cursor:grab;}
.evt107214 .slide-wrap .story-slider span {display:inline-block; float:left; margin-top:390px; transform:translateX(600px); transition:all .6s;}
.evt107214 .slide-wrap .story-slider .slick-active span {transform:translateX(0);}
.evt107214 .slide-wrap .story-slider .slide-item .thumb {position:relative; z-index:10;}
.evt107214 .slide-wrap .pagination-progressbar {position:absolute; left:50%; bottom:0; z-index:10; width:950px; height:10px; background:#fcead3; transform:translate(-50%,0);}
.evt107214 .slide-wrap .pagination-progressbar-fill {position:absolute; left:0; top:0; width:100%; height:100%; transform:scale(0); transform-origin:left top; transition-duration:300ms; background:#572a31;}
.bnr-evtV19 {display:none;}
</style>
<script>
$(function(){
    /* vedio 재생 */
    $('.vod .btn-play').click(function(){
		$(this).fadeOut();
		$(this).next('iframe')[0].src += '?autoplay=1&rel=0';
	});
    /* 자세히 보기 아코디언 */
    var tit = $(".evt107214 .tit");
    $(tit).on("click",function(){
        $(this).next(".info").slideToggle(500); 
        $(this).toggleClass("rotate");
    });
    /* slide */
    var slider = $('.story-slider');
	var amt = slider.find('.slide-item').length;
	var progress = $('.pagination-progressbar-fill');
	if (amt > 1) {
		slider.on('init', function(){
			var init = (1 / amt).toFixed(2);
			progress.css('transform', 'scaleX(' + init + ') scaleY(1)');
		});
		slider.on('beforeChange', function(event, slick, currentSlide, nextSlide){
			var calc = ( (nextSlide+1) / slick.slideCount ).toFixed(2);
			progress.css('transform', 'scaleX(' + calc + ') scaleY(1)');
		});
		slider.slick({
			autoplay: true,
			autoplaySpeed: 1800,
			arrows: true,
			fade: true,
			speed: 1000
		});
	} else {
		$(this).find('.pagination-progressbar').hide();
	}
    /* text slide up */
    $(window).scroll(function(){
        var scrollTop = $(window).scrollTop();
        var ani_point01 = $(".item-top01").offset().top;
        var ani_point02 = $(".item-top02").offset().top;
		if (scrollTop > ani_point01 ) {
			titleAnimation();
		}
		if (scrollTop > ani_point02 ) {
			titleAnimation();
        }
	});
	$(".txt01").css({"top":"334px", "opacity":"0"});
	$(".txt02").css({"bottom":"61px", "opacity":"0"});
	$(".txt03").css({"padding-top":"60px", "opacity":"0"});
	function titleAnimation() {
		$(".txt01").delay(300).animate({"top":"314px", "opacity":"1"},700);
		$(".txt02").delay(700).animate({"bottom":"81px", "opacity":"1"},700);
		$(".txt03").delay(1000).animate({"padding-top":"40px", "opacity":"1"},700);
    }
    /* popup */
    // 정답 기재 후 등록 클릭시 호출 팝업
	$("#btnAnswer").on("click", function(){
		var ans = $("#txtAnswer").val();
		<% If IsUserLoginOK() Then %>
			<% If not( left(currentDate,10) >= "2020-11-18" and left(currentDate,10) <= "2020-12-01" ) Then %>
				alert("이벤트 응모 기간이 아닙니다.");
				return;
			<% else %>
				<% if subscriptcount>0 then %>
					alert("오늘 이미 답을 제출하셨어요.\n하루에 한 번 참여 가능 합니다.");
					return;
				<% else %>
					if (ans == '' || GetByteLength(ans) > 2 || !IsDigit(ans)){
						alert("정답은 숫자 2자 이내입니다.");
						$("#txtAnswer").focus();
						return;
					}

					$.ajax({
						type: "post",
						url: "/event/lib/actEventSubscript.asp",
						data: "evt_code=<%=eCode%>&evt_option=<%=left(currentDate,10)%>&evt_option2="+ans+"&flgChkOpt=100",
						cache: false,
						success: function(message) {
							var rst = JSON.parse(message);
							if(rst.result=="00") {
								$(".pop-container").fadeIn();
								fnAmplitudeEventMultiPropertiesAction('click_event_apply','evtcode','<%=eCode%>');
							} else if(rst.result=="04") {
								alert('오늘 이미 답을 제출하셨어요.\n하루에 한 번 참여 가능 합니다.');
							} else {
								alert(rst.message);
							}
						},
						error: function(err) {
							console.log(err.responseText);
						}
					});
				<% end if %>
			<% end if %>
		<% Else %>
			if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
				top.location.href="/login/loginpage.asp?vType=G";
				return false;
			}
			return false;
		<% End IF %>
	});
	// 팝업 닫기
	$(".evt107214 .btn-close").on("click", function(){
		$(".pop-container").fadeOut();
	});
});
</script>
<div class="evt107214">
	<div class="topic">
		<h2><img src="//webimage.10x10.co.kr/fixevent/event/2020/107214/img_tit.jpg" alt="다꾸홈카페 로 놀러와~!"></h2>
	</div>
	<div class="section-01">
		<img src="//webimage.10x10.co.kr/fixevent/event/2020/107214/img_tit_sub01.jpg" alt="텐바이텐과 탐앤탐스가 다꾸홈카페를 준비해보았어요! 지금 이벤트 참여하고 다꾸홈카페의 주인공에 도전해보세요!">
	</div>
	<div class="section-02">
		<h3><img src="//webimage.10x10.co.kr/fixevent/event/2020/107214/img_tit_sub02.jpg" alt="아래 영상 속에서 텐텐x탐탐 문구가 몇번 등장할까요?"></h3>
		<div class="input-area">
			<input id="txtAnswer" type="number" placeholder="정답 등록 예시 ) 7" maxlength="2" />
			<button type="button" id="btnAnswer" class="btn-enter">등록</button>
		</div>
		<!-- 영상 영역 -->
		<div class="video-area">
            <div class="vod-wrap">
                <div class="vod">
                    <!-- <button class="btn-play"><img src="//webimage.10x10.co.kr/fixevent/event/2020/107214/img_btn_play.png" alt="image"></button> -->
                    <iframe src="https://www.youtube.com/embed/z4gJyRjiNLM" width="920" height="520" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen=""></iframe>
                </div>
            </div>
        </div>
		<!-- //영상 영역 -->
	</div>
	<div class="section-03">
		<h3><img src="//webimage.10x10.co.kr/fixevent/event/2020/107214/img_tit_sub03.jpg" alt="이벤트 당첨 상품 당첨자 중 추첨을 통해 아래 상품 1종을 드립니다."></h3>
		<div class="item-area">
			<div class="glft-content">
				<img src="//webimage.10x10.co.kr/fixevent/event/2020/107214/img_item_info01.jpg" alt="다꾸 홈카페 gift set">
				<div class="detail-area">
					<div class="tit">상품 자세히 보기</div>
					<div class="info">
						<img src="//webimage.10x10.co.kr/fixevent/event/2020/107214/img_acc_info01.jpg" alt="아스카소 드림머신, 마샬 액톤 2 스피커, 더 칼립소 에스프로소잔 세트, 더 칼립소 골드 로고 머그컵, 텐바이텐 다꾸 아이템 10만원 상당, 탐앤탐스 2021 플러나 1종">
					</div>
				</div>
			</div>
			<div class="glft-content">
				<img src="//webimage.10x10.co.kr/fixevent/event/2020/107214/img_item_info02.jpg" alt="탐앤탐스 마이탐 프레즐 세트 쿠폰">
				<div class="detail-area">
					<div class="tit">상품 자세히 보기</div>
					<div class="info">
						<img src="//webimage.10x10.co.kr/fixevent/event/2020/107214/img_acc_info02.jpg" alt="마이탐 프레즐 쿠폰 사용 기간, 마이탐 프레즐 쿠폰 사용 방법">
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="section-04">
		<h3><img src="//webimage.10x10.co.kr/fixevent/event/2020/107214/img_tit_sub04.jpg" alt="다꾸홈카페 구경하기 지금 당장 다꾸하고 싶게 만드는 다꾸홈카페! 여러분들도 집에서 쉽게 즐기실 수 있어요!"></h3>
		<div class="slide-wrap">
            <div class="story-slider">
                <div class="slide-item">
                    <img src="//webimage.10x10.co.kr/fixevent/event/2020/107214/img_slide01.png" alt="slide 01">
                </div>
                <div class="slide-item">
                    <img src="//webimage.10x10.co.kr/fixevent/event/2020/107214/img_slide02.png" alt="slide 02">
                    </div>
                <div class="slide-item">
                    <img src="//webimage.10x10.co.kr/fixevent/event/2020/107214/img_slide03.png" alt="slide 03">
                </div>
            </div>
            <div class="pagination-progressbar"><span class="pagination-progressbar-fill"></span></div>
        </div>
		<div class="info-detail item-top01">
			<img src="//webimage.10x10.co.kr/fixevent/event/2020/107214/img_item01.jpg" alt="다꾸홈카페">
			<div class="txt01"><img src="//webimage.10x10.co.kr/fixevent/event/2020/107214/img_txt01.png" alt="텐바이텐에서 만날 수 있는 다양한 다꾸템과 함께 다꾸 즐기기!"></div>
			<div class="txt02"><img src="//webimage.10x10.co.kr/fixevent/event/2020/107214/img_txt02.png" alt="탐엔탐스 홈카페 아이템으로 나만의 홈카페를 열어보세요."></div>
		</div>
		<div class="info-detail item-top02">
			<img src="//webimage.10x10.co.kr/fixevent/event/2020/107214/img_item02.jpg" alt="다꾸홈카페">
			<div class="txt-box"><img src="//webimage.10x10.co.kr/fixevent/event/2020/107214/img_txt03.png" alt="날씨가 추워진 요즘, 집에서 따뜻한 나만의 다꾸홈카페를 즐겨보세요." class="txt03"></div>
		</div>
	</div>
	<div class="section-05">
		<img src="//webimage.10x10.co.kr/fixevent/event/2020/107214/img_noti.jpg" alt="유의사항">
	</div>
	<div class="pop-container">
		<div class="pop-inner">
			<div class="pop-contents">
				<img src="//webimage.10x10.co.kr/fixevent/event/2020/107214/img_pop.png" alt="정답 제출 알림 팝업">
				<button type="button" class="btn-close">닫기</button>
			</div>
		</div>
	</div>
</div>