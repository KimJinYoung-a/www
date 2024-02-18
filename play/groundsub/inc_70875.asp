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
'####################################################
' Description : PLAY 30-4 W sns공유
' History : 2016-05-20 원승현 생성
'####################################################
Dim eCode , pagereload, userid
IF application("Svr_Info") = "Dev" THEN
	eCode   =  66134
Else
	eCode   =  70875
End If


userid = GetEncLoginUserID()

'// 쇼셜서비스로 글보내기 (2010.07.21; 허진원)
Dim vTitle, vLink, vPre, vImg

dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
snpTitle = Server.URLEncode("#서울재즈페스티벌 공식굿즈 둘러보고, 초대권도 받아야지! #텐바이텐 #서재페 #SJF2016")
snpLink = Server.URLEncode("http://bit.ly/10x10sjf2016")
snpPre = Server.URLEncode("텐바이텐")

'기본 태그
snpTag = Server.URLEncode("텐바이텐")
snpTag2 = Server.URLEncode("#10x10")

%>
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/section.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<style type="text/css">
.groundWrap {width:100%; background-color:#f9bbb8;}
.groundCont {position:relative; padding-bottom:0; background-color:#fff;}
.groundCont .grArea {width:100%;}
.groundCont .tagView {width:1100px; margin-top:30px; padding:28px 20px 60px;}

img {vertical-align:top;}

.playGr20160523 button {background-color:transparent;}

.sjfHead {display:table; width:100%; height:969px; background:#5766a2 url(http://webimage.10x10.co.kr/play/ground/20160523/bg_sjf_head.png) 50% 0 repeat-x; text-align:center;}
.sjfHead h2 {display:table-cell; vertical-align:middle;}

.goFestival {width:100%; height:420px; background-color:#fbb56f;}
.gosjfWrap {overflow:hidden; width:1140px; margin:0 auto;}
.gosjfWrap p {float:left; padding:100px 0 0 37px}
.gosjfWrap .youtube {float:right; padding:45px 25px 0 0;}

.lineUp {position:relative; overflow:hidden; width:100%; height:751px;}
.lineupView {position:absolute; left:0; top:0; width:50%; height:751px;}
.lineupView div {position:absolute; right:0; top:0; width:100%; height:751px; background:url(http://webimage.10x10.co.kr/play/ground/20160523/img_lineup.png) 100% 0 no-repeat; z-index:100;}
.lineupView div a {display:block; position:absolute; right:300px; top:410px; width:245px; height:100px; background-color:rgba(0,0,0,0)}
.lineupView span {position:absolute; left:0; top:0; width:50%; height:751px; background-color:#f1a598; content:''; z-index:50;}
.lineUp .slide {width:100%; height:751px;}
.lineUp .slide p {width:100%; height:751px; background-position:50% 50%; background-repeat:no-repeat;}
.lineUp .slide p a {display:block; width:100%; height:751px;}
.lineUp .s01 {background-color:#bfcce3; background-image:url(http://webimage.10x10.co.kr/play/ground/20160523/img_slide1.jpg);}
.lineUp .s02 {background-color:#fbe2c0; background-image:url(http://webimage.10x10.co.kr/play/ground/20160523/img_slide2.jpg);}
.lineUp .s03 {background-color:#b8c5ec; background-image:url(http://webimage.10x10.co.kr/play/ground/20160523/img_slide3.jpg);}
.lineUp .s04 {background-color:#e5e5e4; background-image:url(http://webimage.10x10.co.kr/play/ground/20160523/img_slide4.jpg);}
.lineUp .s05 {background-color:#f1e8dc; background-image:url(http://webimage.10x10.co.kr/play/ground/20160523/img_slide5.jpg);}
.lineUp .slidesjs-pagination {overflow:hidden; position:absolute; bottom:30px; left:50%; z-index:50; width:399px; margin-left:260px;}
.lineUp .slidesjs-pagination li {float:left; padding:0 6px;}
.lineUp .slidesjs-pagination li a {display:block; width:10px; height:10px; background:url(http://webimage.10x10.co.kr/play/ground/20160523/img_slide_paging.png) 100% 0 no-repeat; transition:0.5s ease-out; text-indent:-999em;}
.lineUp .slidesjs-pagination li a.active {width:20px; background-position:0 0;}

.sjfSns {position:relative; height:450px; background:#4f5d98 url(http://webimage.10x10.co.kr/play/ground/20160523/bg_sjf_sns.jpg) 50% 0 no-repeat;}
.sjfSns ul {position:absolute; top:175px; left:50%; margin-left:100px;}
.sjfSns ul li {position:relative; float:left; padding:0 17px;}
.sjfSns ul li p {display:none; position:absolute; left:50%; top:80%; margin-left:-70px;}
.sjfSns ul li p a {overflow:hidden; display:block; position:absolute; left:10px; top:62px; right:10px; height:50px; text-indent:-999em;}

.sjfCont {height:2260px; padding-top:100px; background:url(http://webimage.10x10.co.kr/play/ground/20160523/bg_sjf_cont.png) 50% 0 repeat-x;}
.sjfInner {width:100%; margin:0 auto;}

.swiper-container {text-align:center;}
.swiper-container strong {position:absolute; left:50%; z-index:50;}
.swiper-container .slidesjs-pagination {position:absolute; left:50%; width:46px; height:255px; z-index:50; background:url(http://webimage.10x10.co.kr/play/ground/20160523/bg_sjf_cont_scroll.png) 50% 100% no-repeat;}
.swiper-container .slidesjs-pagination .slidesjs-pagination-item {display:block; width:46px; height:82px; vertical-align:bottom;}
.swiper-container .slidesjs-pagination .slidesjs-pagination-item a {overflow:hidden; display:block; width:46px; height:82px; margin-top:45px; z-index:60; text-indent:-999em;}
.swiper-container .slidesjs-pagination .slidesjs-pagination-item:first-child a {background:url(http://webimage.10x10.co.kr/play/ground/20160523/bg_sjf_cont_controller2.png) 50% 100% no-repeat;}
.swiper-container .slidesjs-pagination .slidesjs-pagination-item:last-child a {background:url(http://webimage.10x10.co.kr/play/ground/20160523/bg_sjf_cont_controller.png) 50% 100% no-repeat;}
.swiper-container .slidesjs-pagination .slidesjs-pagination-item a.active {background:none; transition:1s ease-in-out;}
.heelDeco {position:absolute; left:50%; width:53px; height:56px; background:url(http://webimage.10x10.co.kr/play/ground/20160523/bg_sjf_cont_deco.png) 50% 50% no-repeat; z-index:50;}

.swiper1 {height:415px;}
.swiper1 strong {top:58px; margin-left:-395px;}
.swiper1 .slidesjs-pagination {top:58px; margin-left:515px;}
.swiper1 .heelDeco {bottom:45px; margin-left:515px;}

.swiper2 {height:425px; margin-top:150px}
.swiper2 strong {top:58px; margin-left:125px;}
.swiper2 .slidesjs-pagination {top:58px; margin-left:-565px;}
.swiper2 .heelDeco {bottom:53px; margin-left:-563px;}

.swiper3 {height:415px; margin-top:170px;}
.swiper3 strong {top:58px; margin-left:-395px;}
.swiper3 .slidesjs-pagination {top:58px; margin-left:515px;}
.swiper3 .heelDeco {bottom:45px; margin-left:515px;}

.swiper4 {height:425px; margin-top:170px}
.swiper4 strong {top:58px; margin-left:180px;}
.swiper4 .slidesjs-pagination {top:58px; margin-left:-565px;}
.swiper4 .heelDeco {bottom:55px; margin-left:-563px;}
</style>
<script type="text/javascript">
<!--
$(function(){
	/* 더블클릭시 최상단으로 이동 이벤트 없애기 */
	$(document).unbind("dblclick").dblclick(function () {});

	/* slide js */
	$("#slide").slidesjs({
		//width:"100%",
		height:"751",
		pagination:{effect:"fade"},
		navigation:{active:false, effect:"fade"},
		play:{interval:2500, effect:"fade", auto:true},
		effect:{fade: {speed:1000}},
		callback: {
			complete: function(number) {
				var pluginInstance = $('#slide').data('plugin_slidesjs');
				setTimeout(function() {
					pluginInstance.play(true);
				}, pluginInstance.options.play.interval);
			}
		}
	});

	$("#vSlide1").slidesjs({
		width:"1140",
		height:"415",
		pagination:{effect:"fade"},
		navigation:{active:false, effect:"fade"},
		play:{interval:2500, effect:"fade", auto:false},
		effect:{fade: {speed:600}},
		callback: {
			complete: function(number) {
				var pluginInstance = $('#slide').data('plugin_slidesjs');
				setTimeout(function() {
					pluginInstance.play(true);
				}, pluginInstance.options.play.interval);
			}
		}
	});

	$("#vSlide2").slidesjs({
		width:"1140",
		height:"425",
		pagination:{effect:"fade"},
		navigation:{active:false, effect:"fade"},
		play:{interval:2500, effect:"fade", auto:false},
		effect:{fade: {speed:600}},
		callback: {
			complete: function(number) {
				var pluginInstance = $('#slide').data('plugin_slidesjs');
				setTimeout(function() {
					pluginInstance.play(true);
				}, pluginInstance.options.play.interval);
			}
		}
	});

	$("#vSlide3").slidesjs({
		width:"1140",
		height:"385",
		pagination:{effect:"fade"},
		navigation:{active:false, effect:"fade"},
		play:{interval:2500, effect:"fade", auto:false},
		effect:{fade: {speed:600}},
		callback: {
			complete: function(number) {
				var pluginInstance = $('#slide').data('plugin_slidesjs');
				setTimeout(function() {
					pluginInstance.play(true);
				}, pluginInstance.options.play.interval);
			}
		}
	});

	$("#vSlide4").slidesjs({
		width:"1140",
		height:"415",
		pagination:{effect:"fade"},
		navigation:{active:false, effect:"fade"},
		play:{interval:2500, effect:"fade", auto:false},
		effect:{fade: {speed:600}},
		callback: {
			complete: function(number) {
				var pluginInstance = $('#slide').data('plugin_slidesjs');
				setTimeout(function() {
					pluginInstance.play(true);
				}, pluginInstance.options.play.interval);
			}
		}
	});

	/* sns instagram */
	$(".btnInsta").click(function(){
		if($(this).children('p').is(':hidden')){
			$(this).find('p').show();
		} else {
			$(this).find('p').hide();
		};
	});
});

function jsevtchk(sns){
	<% If not(left(now(),10)>="2016-05-20" and left(now(),10)<"2016-05-27" ) Then '오픈시 이벤트 기간 23~26일로 수정 %>
		alert('이벤트 응모 기간이 아닙니다.');
		return;
	<% else %>
		<% if IsUserLoginOK then %>
		var result;
			$.ajax({
				type:"GET",
				url:"/play/groundsub/doEventSubscript70875.asp",
				data: "mode=sns&snsgubun="+sns,
				dataType: "text",
				async:false,
				cache:false,
				success : function(Data){
					result = jQuery.parseJSON(Data);
					if(result.stcode=="tw") 
					{
						parent.popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>')
						return false;
					}
					else if(result.stcode=="fb")
					{
						popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','');
						return false;
					}
				}
			});	
		<% else %>
			jsChklogin('<%=IsUserLoginOK%>');
			return;
		<% end if %>
	<% end if %>
}
//-->
</script>
<div class="groundCont">
	<div class="grArea">
		<div class="playGr20160523">
			<div class="sjfHead">
				<h2><img src="http://webimage.10x10.co.kr/play/ground/20160523/tit_sjf.png" alt="JAZZ UP YOUR SOUL - Seoul Jazz Festival 2016" /></h2>
			</div>

			<div class="sjfCont">
				<div class="sjfInner">
					<div class="swiper-container swiper1">
						<strong><img src="http://webimage.10x10.co.kr/play/ground/20160523/txt_sjf_cont1.png" alt="" /></strong>
						<div id="vSlide1" class="vSlide1">
							<p><img src="http://webimage.10x10.co.kr/play/ground/20160523/img_sjf_cont1a.jpg" alt="" /></p>
							<p><img src="http://webimage.10x10.co.kr/play/ground/20160523/img_sjf_cont1b.jpg" alt="" /></p>
						</div>
						<p class="heelDeco"></p>
					</div>
					<div class="swiper-container swiper2">
						<strong><img src="http://webimage.10x10.co.kr/play/ground/20160523/txt_sjf_cont2.png" alt="" /></strong>
						<div id="vSlide2" class="vSlide2">
							<p><img src="http://webimage.10x10.co.kr/play/ground/20160523/img_sjf_cont2a.jpg" alt="" /></p>
							<p><img src="http://webimage.10x10.co.kr/play/ground/20160523/img_sjf_cont2b.jpg" alt="" /></p>
						</div>
						<p class="heelDeco"></p>
					</div>
					<div class="swiper-container swiper3">
						<strong><img src="http://webimage.10x10.co.kr/play/ground/20160523/txt_sjf_cont3.png" alt="" /></strong>
						<div id="vSlide3" class="vSlide3">
							<p><img src="http://webimage.10x10.co.kr/play/ground/20160523/img_sjf_cont3a.jpg" alt="" /></p>
							<p><img src="http://webimage.10x10.co.kr/play/ground/20160523/img_sjf_cont3b.jpg" alt="" /></p>
						</div>
						<p class="heelDeco"></p>
					</div>
					<div class="swiper-container swiper4">
						<strong><img src="http://webimage.10x10.co.kr/play/ground/20160523/txt_sjf_cont4.png" alt="" /></strong>
						<div id="vSlide4" class="vSlide4">
							<p><img src="http://webimage.10x10.co.kr/play/ground/20160523/img_sjf_cont4a.jpg" alt="" /></p>
							<p><img src="http://webimage.10x10.co.kr/play/ground/20160523/img_sjf_cont4b.jpg" alt="" /></p>
						</div>
						<p class="heelDeco"></p>
					</div>
				</div>

			</div>

			<div class="goFestival">
				<div class="gosjfWrap">
					<p><img src="http://webimage.10x10.co.kr/play/ground/20160523/txt_sjf_go.png" alt="GO! FESTIVAL" /></p>
					<div class="youtube">
						<iframe src="https://www.youtube.com/embed/d-E3RTYe82k" frameborder="0" width="540" height="330" title="Seoul Jazz Festival 2016" allowfullscreen></iframe>
					</div>
				</div>
			</div>

			<div class="lineUp">
				<div class="lineupView"><div><a href="/event/eventmain.asp?eventid=70864" target="_blank"></a></div><span></span></div>
				<div id="slide" class="slide">
					<p class="s01"><a href="/event/eventmain.asp?eventid=70864" target="_blank"></a></p>
					<p class="s02"><a href="/event/eventmain.asp?eventid=70864" target="_blank"></a></p>
					<p class="s03"><a href="/event/eventmain.asp?eventid=70864" target="_blank"></a></p>
					<p class="s04"><a href="/event/eventmain.asp?eventid=70864" target="_blank"></a></p>
					<p class="s05"><a href="/event/eventmain.asp?eventid=70864" target="_blank"></a></p>
				</div>
			</div>

			<%' sns %>
			<div class="sjfSns">
				<ul>
					<li class="btnInsta"><span><img src="http://webimage.10x10.co.kr/play/ground/20160523/btn_sjf_sns1.png" alt="Instagram" /></span>
						<p>
							<a href="https://www.instagram.com/your10x10/" target="blank">인스타그램 바로가기</a>
							<img src="http://webimage.10x10.co.kr/play/ground/20160523/lyr_sjf_sns1.png" alt="본페이지를 캡쳐해서 포스팅해주세요" />
						</p>
					</li>
					<li><a href="" onclick="jsevtchk('fb');return false;"><img src="http://webimage.10x10.co.kr/play/ground/20160523/btn_sjf_sns2.png" alt="Facebook" /></a></li>
					<li><a href="" onclick="jsevtchk('tw');return false;"><img src="http://webimage.10x10.co.kr/play/ground/20160523/btn_sjf_sns3.png" alt="Twitter" /></a></li>
				</ul>
			</div>
			<!--// sns -->
		</div>

<!-- #include virtual="/lib/db/dbclose.asp" -->