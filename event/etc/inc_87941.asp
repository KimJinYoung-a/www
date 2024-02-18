<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : 훈남정음 캐릭터 중 정음이와 어울리는 토이는?
' History : 2018-06-07 최종원
'###########################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<%
dim eCode, vUserID, sqlstr, cnt

IF application("Svr_Info") = "Dev" THEN
	eCode = "68520"
Else
	eCode = "87941"
End If

%>
<style type="text/css">
.cmtGroupBarV17 {display:none;}
.evt87941 {position:relative; background:#f6f6f6;}
.evt87941 .btn-card {position:absolute; left:50%; top:40px; z-index:40; margin-left:387px; animation:bounce 1s 50;}
.slide {position:relative; width:1140px; height:568px; background:url(http://webimage.10x10.co.kr/eventIMG/2018/87941/bg_slide.png) no-repeat 0 0;}
.slide .slidesjs-pagination {position:absolute; right:315px; bottom:200px; z-index:30; width:100px; height:10px;}
.slide .slidesjs-pagination li {display:inline-block; padding:0 5px;}
.slide .slidesjs-pagination li a {display:inline-block; width:10px; height:10px; background:url(http://webimage.10x10.co.kr/eventIMG/2018/87941/btn_pagination.png) no-repeat 0 0; text-indent:-999em;}
.slide .slidesjs-pagination li a.active {background-position:100% 0;}
.slide .slidesjs-navigation {display:inline-block; position:absolute; top:236px; z-index:10; width:36px; height:64px; background:url(http://webimage.10x10.co.kr/eventIMG/2018/87941/bg_nav.png) no-repeat 0 0; text-indent:-999em;}
.slide .slidesjs-previous {left:160px;}
.slide .slidesjs-next {right:160px; background-position:100% 0;}
.noti {position:relative; padding-bottom:58px; margin:0 60px;}
.noti h3 {position:absolute; left:119px; top:105px; z-index:10;}
.noti ul {position:relative; width:612px; padding:58px 0 58px 412px; background-color:#e1dacd; color:#3e3e3e; line-height:20px; text-align:left;}
.noti ul:before {display:inline-block; position:absolute; top:46px; left:328px; width:1px; height:139px; background-color: #b4aea4; content:' ';}
.noti ul li {padding-left:9px; text-indent:-9px; color:#656565; font-size:11px; line-height:2;}
</style>
<script type="text/javascript" src="/lib/js/jquery.kxbdmarquee.js"></script>
<script style="text/javascript">
$(function(){
	$('.slide').slidesjs({
		width:1140,
		height:568,
		pagination:{effect:'fade'},
		navigation:{effect:'fade'},
		play:{interval:2000, effect:'fade', auto:true},
		effect:{fade: {speed:500, crossfade:true}
		},
		callback: {
			complete: function(number) {
				var pluginInstance = $('.slide').data('plugin_slidesjs');
				setTimeout(function() {
					pluginInstance.play(true);
				}, pluginInstance.options.play.interval);
			}
		}
	});
});
</script>
						<!-- 텐텐백서 vol.02 -->
						<div class="evt87941">
							<h2><img src="http://webimage.10x10.co.kr/eventIMG/2018/87941/tit_play.jpg" alt="텐텐백서 vol.02" /></h2>
							<p><img src="http://webimage.10x10.co.kr/eventIMG/2018/87941/txt_play.jpg" alt="텐바이텐의 상품 추천 서비스 조각과 감성 컨텐츠 플레잉이 만나 쇼핑 플레이리스트 PLAY로 다시 태어났습니다! PLAY 기능에 대해 알아볼까요?" /></p>
							<div class="slide">
								<img src="http://webimage.10x10.co.kr/eventIMG/2018/87941/img_slide_1.jpg" alt="새로운 컨텐츠 보기!" />
								<img src="http://webimage.10x10.co.kr/eventIMG/2018/87941/img_slide_2.jpg" alt="연관 상품 소개!" />
								<img src="http://webimage.10x10.co.kr/eventIMG/2018/87941/img_slide_3.jpg" alt="영상으로 상품 보기!" />
								<img src="http://webimage.10x10.co.kr/eventIMG/2018/87941/img_slide_4.jpg" alt="보고 싶은 것만 쏙쏙!" />
								<img src="http://webimage.10x10.co.kr/eventIMG/2018/87941/img_slide_5.jpg" alt="기록하기!" />
							</div>
							<p><img src="http://webimage.10x10.co.kr/eventIMG/2018/87941/txt_qr.png" alt="지금 텐바이텐 앱을 업데이트하고 PLAY를 구경해보세요! ※ 현재 IOS만 지원됩니다.(Android 올 하반기 오픈 예정) ※ PLAY는 APP 최신버전에서만 확인할 수있습니다. " /></p>
							<div class="noti">
								<h3><img src="http://webimage.10x10.co.kr/eventIMG/2018/87941/tit_noti.png" alt="유의사항" /></h3>
								<ul>
									<li>- 본 이벤트는 기간 동안 ID 당 1회만 응모하실 수 있습니다.</li>
									<li>- 통신예절에 어긋나는 글이나 상업적인 글, 타 사이트에 관련된 글 또는 도용한 글은<br>관리자에 의해 사전 통보 없이 삭제될 수 있으며, 이벤트 참여에 제한을 받을 수 있습니다.</li>
									<li>- 당첨자 발표는 2018년 8월 3일 사이트 내 공지사항에 게시될 예정입니다.</li>
									<li>- PLAY는 현재 iOS 최신버전 앱에서만 지원되는 기능입니다.</li>
								</ul>
							</div>
							<div><img src="http://webimage.10x10.co.kr/eventIMG/2018/87941/txt_cmt_evt.png" alt="play 에 대한 기대평을 남겨주세요! 정성껏 댓글을 남겨주신 50분을 추첨하여  기프트 카드 1만원권  을 선물합니다!" /></div>
						</div>
						<!--// 텐텐백서 vol.02 -->

<!-- #include virtual="/lib/db/dbclose.asp" -->