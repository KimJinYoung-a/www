<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 메리라이트 pc
' History : 2019-11-19 최종원 
'####################################################
%>
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<style>
.evt98738 {background:#fff;}
.evt98738 .merry-cont {position:relative; width:1140px; margin:0 auto;}
.evt98738 .bnr {background:#282b32;}
.evt98738 .topic {position:relative; height:759px; background:#6d716d url(//webimage.10x10.co.kr/fixevent/event/2019/98740/bg_topic.jpg) no-repeat 50% 0;}
.evt98738 .topic h2, .evt98738 .topic p {position:absolute; left:50%; opacity:0; transform:translateY(10px); transition:.8s;}
.evt98738 .topic .tit1 {top:80px; margin-left:-92px;}
.evt98738 .topic .tit2 {top:158px; margin-left:-286px;}
.evt98738 .topic .tit3 {top:350px; margin-left:-227px;}
.evt98738 .topic.on h2, .evt98738 .topic.on p {opacity:1; transform:translateY(0);}
.evt98738 .topic.on h2 {transition-delay:.4s;}
.evt98738 .topic.on .tit2 {transition-delay:.6s;}
.evt98738 .topic.on .tit3 {transition-delay:.8s;}
.evt98738 .merry-free {padding:90px 0 84px;}
.evt98738 .merry-free h3 {padding-bottom:43px;}
.evt98738 .merry-story {background-position:50% 0; background-repeat:no-repeat; background-color:#bcbbb6;}
.evt98738 .story1 {height:726px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/98740/bg_story_1.jpg); background-color:#e4e1e3;}
.evt98738 .story2 {height:1398px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/98740/bg_story_2.jpg); background-color:#e4e1e3;}
.evt98738 .story3 {height:756px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/98740/bg_story_3.jpg);}
.evt98738 .story4 {height:855px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/98740/bg_story_4.jpg);}
.evt98738 .merry-story p {position:absolute; transform:translateX(2rem); opacity:0; transition:.8s;}
.evt98738 .merry-story.story1 p {left:60px; top:309px;}
.evt98738 .merry-story.story2 p {left:60px; top:585px;}
.evt98738 .merry-story.story3 p {right:60px; top:138px;}
.evt98738 .merry-story.story4 p {left:60px; top:148px;}
.evt98738 .merry-story.move p {transform:translateX(0); opacity:1;}
.evt98738 .merry-feature {padding:110px 0; background:#ddd6d4;}
.evt98738 .merry-feature .make h3 {padding:115px 0 50px;}
.evt98738 .merry-feature .slide-wrap {position:relative; width:1020px; height:509px; margin:0 auto;}
.evt98738 .merry-feature .slick-arrow {bottom:30px; z-index:100; width:28px; height:47px; background:url(//webimage.10x10.co.kr/fixevent/event/2019/98740/btn_nav.png) no-repeat 0 0;}
.evt98738 .merry-feature .slick-prev {right:175px;}
.evt98738 .merry-feature .slick-next {right:38px; background-position:100% 0;}
.evt98738 .merry-feature .counter {position:absolute; right:75px; bottom:30px; width:90px; height:47px; font:normal 26px/47px'Roboto'; color:#fff;}
.evt98738 .merry-gift {padding:78px 0 60px;}
.evt98738 .evt-noti {position:relative; padding:62px 0; color:#fff; background-color:#3c3a3a;}
.evt98738 .evt-noti h3 {position:absolute; top:50%; left:207px; margin-top:-13px;}
.evt98738 .evt-noti ul {padding-left:360px;}
.evt98738 .evt-noti li {padding-top:20px; font-family:'Roboto', 'Noto Sans KR', 'Malgun Gothic', '맑은고딕', sans-serif; font-size:14px; line-height:1.1; text-align:left;}
.evt98738 .evt-noti li:first-child {padding-top:0;}
</style>
<script type="text/javascript">
$(function(){
    $('.topic').addClass('on');

    $('.slide').on('init', function(event, slick) {
        $(this).append('<div class="counter"><span class="current"></span> / <span class="total"></span></div>');
        $('.current').text(slick.currentSlide + 1);
        $('.total').text(slick.slideCount);
    })
    .slick({
        autoplay:true,
        autoplaySpeed:1500,
        speed:600,
        fade:true,
        arrows:true
    })
    .on('beforeChange', function(event, slick, currentSlide, nextSlide) {
        $('.current').text(nextSlide + 1);
    });

    $(window).scroll(function(){
		$('.merry-story').each(function(){
			var y = $(window).scrollTop() + $(window).height() * 0.5;
			var txtTop = $(this).offset().top;
			if(y > txtTop) {
				$(this).addClass('move');
			}
		});
	});
});
</script>
<!-- 98738 메리라이트 -->
                        <div class="evt98738">
                            <div class="bnr"><a href="/christmas/"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98740/bnr_christmas.jpg" alt="당신이 찾고 있는 크리스마스 소품의 모든 것"></a></div>
                            <div class="topic">
                                <p class="tit1"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98740/txt_vol1.png" alt="크리스마스 이벤트01"></p>
                                <h2 class="tit2"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98740/tit_merry_light.png" alt="Merry Light"></h2>
                                <p class="tit3"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98740/txt_subcopy.png" alt="당신의 반짝이는 크리스마스. 텐바이텐이 준비한 Merry Light와 행복한 시간을 보내세요."></p>
                            </div>
                            <div class="merry-free">
                                <div class="merry-cont">
                                    <h3><img src="//webimage.10x10.co.kr/fixevent/event/2019/98740/tit_gift.gif" alt="Merry Light 를 선물로 드립니다. 당신은, 배송비만 결제하세요."></h3>
                                    <div><img src="//webimage.10x10.co.kr/fixevent/event/2019/98740/img_move.gif" alt=""></div>
                                    <div><img src="//webimage.10x10.co.kr/fixevent/event/2019/98740/img_qr.png" alt=""></div>
                                </div>
                            </div>
                            <div class="merry-story story1">
                                <div class="merry-cont">
                                    <p><img src="//webimage.10x10.co.kr/fixevent/event/2019/98740/txt_story_1.png" alt="작은 스위치가 켜지는 순간 당신이 조금 더 행복해지기를 바랍니다."></p>
                                </div>
                            </div>
                            <div class="merry-story story2">
                                <div class="merry-cont">
                                    <p><img src="//webimage.10x10.co.kr/fixevent/event/2019/98740/txt_story_2.png" alt="책상 위, 잠들기 전의 침대 옆 반짝임이 필요한 공간이면 어느 곳이든."></p>
                                </div>
                            </div>
                            <div class="merry-story story3">
                                <div class="merry-cont">
                                    <p><img src="//webimage.10x10.co.kr/fixevent/event/2019/98740/txt_story_3.png" alt="친구들과 여러 개의 Merry Light를 모아 작지만 따듯한 마을을 완성해 보세요."></p>
                                </div>
                            </div>
                            <div class="merry-story story4">
                                <div class="merry-cont">
                                    <p><img src="//webimage.10x10.co.kr/fixevent/event/2019/98740/txt_story_4.png" alt="Merry Light 옆에 좋아하는 소품을 함께 놓아둘 수 있어요."></p>
                                </div>
                            </div>
                            <div class="merry-feature">
                                <div class="merry-cont">
                                    <div><img src="//webimage.10x10.co.kr/fixevent/event/2019/98740/img_feature.jpg" alt="Merry Light는 이렇게 구성되어 있어요"></div>
                                    <div class="make">
                                        <h3><img src="//webimage.10x10.co.kr/fixevent/event/2019/98740/tit_make.png" alt="간단하게 접어서 Merry Light를 완성해 보세요!"></h3>
                                        <div class="slide-wrap">
                                            <div class="slide">
                                                <div><img src="//webimage.10x10.co.kr/fixevent/event/2019/98740/img_slide_1.jpg" alt=""></div>
                                                <div><img src="//webimage.10x10.co.kr/fixevent/event/2019/98740/img_slide_2.jpg" alt=""></div>
                                                <div><img src="//webimage.10x10.co.kr/fixevent/event/2019/98740/img_slide_3.jpg" alt=""></div>
                                                <div><img src="//webimage.10x10.co.kr/fixevent/event/2019/98740/img_slide_4.jpg" alt=""></div>
                                                <div><img src="//webimage.10x10.co.kr/fixevent/event/2019/98740/img_slide_5.jpg" alt=""></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="merry-gift">
                                <div class="merry-cont"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98740/img_gift.jpg" alt="Merry Light 인증샷 남기고 또 다른 선물 받으세요!"></div>
                            </div>
                            <div class="bnr"><a href="/christmas/"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98740/bnr_christmas_2.jpg" alt="당신이 찾고 있는 크리스마스 소품의 모든 것"></a></div>
                            <% if date() <= Cdate("2019-11-20") then %>
                            <div class="bnr"><a href="/shopping/category_prd.asp?itemid=2592320"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98740/bnr_disney.jpg" alt="오늘 단 하루 50% 특가!"></a></div>
                            <% end if %>
                            <div class="evt-noti">
                                <div class="merry-cont">
                                    <h3><img src="//webimage.10x10.co.kr/fixevent/event/2019/98740/tit_noti.png" alt="이벤트 유의사항"></h3>
                                    <ul>
                                        <li>- 본 이벤트는 텐바이텐 APP에서만 참여 가능합니다.</li>
                                        <li>- 1일 1회 응모가 가능하며, 친구에게 공유 시 한 번 더 기회가 주어집니다. (하루 최대 2회 응모 가능)</li>
                                        <li>- 모든 상품의 당첨자가 결정되면 이벤트는 조기 마감될 수 있습니다.</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <!--// 98738 메리라이트 -->
<!-- #include virtual="/lib/db/dbclose.asp" -->