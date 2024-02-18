<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/section.css" />
<style type="text/css">
img {vertical-align:top;}
.fallinginShirt {background:url(http://webimage.10x10.co.kr/play/ground/20140901/bg_paper.gif) no-repeat 50% 530px;}
.fallinginShirt .movie {position:relative; z-index:10; width:1140px; margin:0 auto; padding-bottom:27px; background:url(http://webimage.10x10.co.kr/play/ground/20140901/bg_shadow.png) no-repeat 50% 100%;}
.fallinginShirt .movie .video {background-color:#fff; padding:25px 20px 20px;}
.fallinginShirt .movie .video .bnr {margin-bottom:15px; text-align:right;}
.fallinginShirt .topic {position:relative; width:1140px; margin:0 auto; padding:338px 0 113px; text-align:center;}
.fallinginShirt .topic h3, .fallinginShirt .topic p {position:relative; z-index:10;}
.fallinginShirt .topic p {margin-top:55px;}
.fallinginShirt .topic .sun {position:absolute; top:-150px; left:260px; z-index:5;}
.fallinginShirt .topic .bird {position:absolute; top:110px; left:295px; z-index:5;}
.fallinginShirt .fall-silde {overflow:hidden; position:relative; height:790px;}
.fallinginShirt .fall-silde h4 {position:relative; z-index:50; width:1140px; height:398px; margin:0 auto;}
.fallinginShirt .fall-silde h4 img {position:absolute; top:97px; left:0; z-index:50;}
.fallinginShirt .slide {position:absolute; top:0; left:50%; width:1920px; margin-left:-960px;}
.fallinginShirt .slidesjs-pagination {overflow:hidden; position:absolute; bottom:83px; left:50%; z-index:50; width:150px; margin-left:-75px;}
.fallinginShirt .slidesjs-pagination li {float:left; padding:0 8px;}
.fallinginShirt .slidesjs-pagination li a {display:block; width:14px; height:14px; background-image:url(http://webimage.10x10.co.kr/play/ground/20140901/btn_paging.png); background-repeat:no-repeat; background-position:0 0; text-indent:-999em;}
.fallinginShirt .slidesjs-pagination li a.active {background-position:100% 0;}
</style>
<script type="text/javascript" src="/lib/js/jquery.slides.min.js"></script>
<script type="text/javascript">
$(function(){
	$(".slide").slidesjs({
		width:"1920",
		height:"790",
		pagination:{effect:"fade"},
		navigation:false,
		play:{interval:5000, effect:"fade", auto:true},
		effect:{fade: {speed:1000, crossfade:true}
		},
		callback: {
			complete: function(number) {
				var pluginInstance = $(".slide").data("plugin_slidesjs");
				setTimeout(function() {
					pluginInstance.play(true);
				}, pluginInstance.options.play.interval);
			}
		}
	});

	function moveBird() {
		$(".bird").animate({"margin-top":"20px"},1000).animate({"margin-top":"10px"},1000, moveBird);
	}
	moveBird();
});
</script>
<div class="playGr20140901">
	<div class="fallinginShirt">
		<div class="section movie">
			<div class="video">
				<div class="bnr"><a href="http://www.better-taste.com/" target="_blank" title="새창"><img src="http://webimage.10x10.co.kr/play/ground/20140901/img_bnr_bts.gif" alt="roduction BTS - Better Taste Stuido www.better-taste.com" /></a></div>
				<iframe src="//player.vimeo.com/video/104672910" width="1100" height="619" frameborder="0" title="SHIRTS" webkitallowfullscreen="" mozallowfullscreen="" allowfullscreen=""></iframe>
			</div>
		</div>
		<div class="section topic">
			<h3><img src="http://webimage.10x10.co.kr/play/ground/20140901/tit_falling_in_shirt.png" alt="Falling in Shirts" /></h3>
			<p><img src="http://webimage.10x10.co.kr/play/ground/20140901/txt_topic.png" alt="플레이 열두 번째 이야기는 셔츠입니다. 무더운 여름이 지나가고, 선선한 가을이 돌아왔습니다. 짧은 반팔 대신 셔츠를 자주 입게 되는 계절. 살랑살랑 불어오는 가을 바람에 흩날리는 셔츠 자락과  따뜻한 노을 빛이 번지는 하얀 셔츠를 영상에 담아보았습니다. 이번 영상을 통해 가을에 물든 셔츠를 만나보세요-" /></p>
			<span class="sun"><img src="http://webimage.10x10.co.kr/play/ground/20140901/img_sun.png" alt="" /></span>
			<span class="bird"><img src="http://webimage.10x10.co.kr/play/ground/20140901/img_bird.png" alt="" /></span>
		</div>

		<div class="section fall-silde">
			<h4><img src="http://webimage.10x10.co.kr/play/ground/20140901/tit_montens_with_shirts.png" alt="MONTENS WITH SHIRTS AUTUMN REEZE, WARM SUNSET, AND SOFT SHIRTS" /></h4>
			<div class="slide">
				<div><img src="http://webimage.10x10.co.kr/play/ground/20140901/img_slide_01.jpg" alt="" /></div>
				<div><img src="http://webimage.10x10.co.kr/play/ground/20140901/img_slide_02.jpg" alt="" /></div>
				<div><img src="http://webimage.10x10.co.kr/play/ground/20140901/img_slide_03.jpg" alt="" /></div>
				<div><img src="http://webimage.10x10.co.kr/play/ground/20140901/img_slide_04.jpg" alt="" /></div>
				<div><img src="http://webimage.10x10.co.kr/play/ground/20140901/img_slide_05.jpg" alt="" /></div>
			</div>
		</div>
	</div>
</div>
