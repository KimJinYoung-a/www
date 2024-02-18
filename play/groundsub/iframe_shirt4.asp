<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/section.css" />
<style type="text/css">
.imFine .heading {position:relative;}
.imFine .heading h3 {position:absolute; top:20%; left:50%; margin-left:-565px;}
.imFine .intro {width:1140px; margin:0 auto; padding:180px 0 185px;}
.imFine .intro .topic {overflow:hidden; padding-bottom:120px;}
.imFine .intro .hello {float:left; position:relative; width:50%; height:210px;}
.imFine .intro .hello p {overflow:hidden; position:absolute; top:0; left:0;}
.imFine .intro .hello .second {height:76px;}
.imFine .intro .hello .third {height:150px;}
.imFine .intro .hello .last {height:210px;}
.imFine .intro .topic .copy {float:left; width:50%;}
.imFine .intro .buy {position:relative; margin-top:205px;}
.imFine .intro .buy .btnBuy {position:absolute; top:200px; right:215px;}
.imFine .wear {height:1094px; padding-top:197px; background:url(http://webimage.10x10.co.kr/play/ground/20140929/bg_line_pattern.gif) repeat-x 0 0; text-align:center;}
.imFine .wear .fineapple {overflow:hidden; position:relative; width:210px; margin:0 auto; text-align:center;}
.imFine .wear .fineapple span {float:left; padding:0 10px;}
.imFine .wear .fineapple .all {position:absolute; left:0; top:0;}
.imFine .wear .cut {margin-top:188px;}
.imFine .ending {position:relative;}
.imFine .ending p {position:absolute; top:45%; left:50%; margin-left:-355px;}
.imFine .figure img {min-width:1140px; width:100%;}
.animated {-webkit-animation-duration:5s; animation-duration:5s; -webkit-animation-fill-mode:both; animation-fill-mode:both;}
/* Bounce animation */
@-webkit-keyframes bounce {
	0%, 20%, 50%, 80%, 100% {-webkit-transform: translateY(-5px);}
	40% {-webkit-transform: translateY(-15px);}
	60% {-webkit-transform: translateY(-10px);}
}
@keyframes bounce {
	0%, 20%, 50%, 80%, 100% {transform: translateY(-5px);}
	40% {transform: translateY(-15px);}
	60% {transform: translateY(-10px);}
}
.bounce {-webkit-animation-name:bounce; animation-name:bounce; -webkit-animation-iteration-count:infinite; animation-iteration-count:infinite;}
</style>
<script type="text/javascript">
$(function(){
	function moveFine() {
		$(".fine").animate({"margin-top":"10px"},2000).animate({"margin-top":"-30px"},2000, moveFine);
	}
	moveFine();

	//Cache element collection and keep a reference to the visible element 
	var $elements = $(".blink").css("visibility","hidden"),
		$visible = $elements.first().css("visibility","visible");

	//Single interval function to handle blinking
	setInterval(function(){
		//Hide visible element
		$visible.css("visibility","hidden");
		//Find next one
		var $next = $visible.next(".blink");
		if(!$next.length)
			$next = $elements.first();
		//Show next element
		$visible = $next.css("visibility","visible");
	},2500);
});
</script>
<div class="playGr20140929">
	<div class="imFine">
		<div class="section heading">
			<h3 class="fine"><img src="http://webimage.10x10.co.kr/play/ground/20140929/tit_im_fine.png" alt="I&apos;m Find." /></h3>
			<div class="figure"><img src="http://webimage.10x10.co.kr/play/ground/20140929/img_shirt.jpg" alt="" /></div>
		</div>

		<div class="section intro">
			<div class="topic">
				<div class="hello">
					<p class="blink first"><img src="http://webimage.10x10.co.kr/play/ground/20140929/txt_hello_blink.gif" alt="" /></p>
					<p class="blink second"><img src="http://webimage.10x10.co.kr/play/ground/20140929/txt_hello.gif" alt="How are you?" /></p>
					<p class="blink third"><img src="http://webimage.10x10.co.kr/play/ground/20140929/txt_hello.gif" alt="I'm f ine!" /></p>
					<p class="blink last"><img src="http://webimage.10x10.co.kr/play/ground/20140929/txt_hello.gif" alt="and you?" /></p>
				</div>
				<p class="copy"><img src="http://webimage.10x10.co.kr/play/ground/20140929/txt_copy.gif" alt="&quot;저는 잘 지내요.&quot; &quot;당신은요?&quot; 텐바이텐 PLAY에서는 누군가에게 안부를 전하는 것이 점점 어려워지는 요즘 모두에게 안부를 묻고 싶어졌습니다. 그리고 그 마음을 담아 I'm fine! 셔츠를 제작하였습니다. Pine이라는 이름을 가지고 있는 파인애플과 나는 잘 지내요의 Fine이 만난 자수 셔츠! 모두가 &quot;안녕&quot;하기를 바라는 당신의 마음에 입혀 주세요." /></p>
			</div>

			<p><img src="http://webimage.10x10.co.kr/play/ground/20140929/img_and_you.jpg" alt="아임 파인 셔츠 왼쪽 소매에는 and you?라는 글자가 수 놓아져 있습니다." /></p>

			<div class="buy">
				<a href="/shopping/category_prd.asp?itemid=1131838" target="_blank" title="새창">
					<img src="http://webimage.10x10.co.kr/play/ground/20140929/img_shirt_buy.jpg" alt="텐바이텐 에디션 아임 파인 셔츠" />
					<span class="btnBuy animated bounce"><img src="http://webimage.10x10.co.kr/play/ground/20140929/btn_buy.gif" alt="구매하러 가기" /></span>
				</a>
			</div>
		</div>

		<div class="section gallery">
			<div class="figure"><img src="http://webimage.10x10.co.kr/play/ground/20140929/img_shirt_gallery.jpg" alt="" /></div>
		</div>

		<div class="section wear">
			<div class="fineapple"><img src="http://webimage.10x10.co.kr/play/ground/20140929/img_fineapple_all.gif" alt="" /></div>
			<div class="cut"><img src="http://webimage.10x10.co.kr/play/ground/20140929/img_shirt_wear_cut.jpg" alt="아임 파인 셔츠를 착용한 모습" /></div>
		</div>

		<div class="section ending">
			<p><img src="http://webimage.10x10.co.kr/play/ground/20140929/txt_everybody_find.png" alt="EVERYBODY&apos; FINE!" /></p>
			<div class="figure"><img src="http://webimage.10x10.co.kr/play/ground/20140929/img_shirt_with_pineapple.jpg" alt="" /></div>
		</div>
	</div>
</div>