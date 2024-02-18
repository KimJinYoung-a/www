<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : 내게 너무 완벽한 웨딩
' History : 2015.10.05 유태욱 생성
'####################################################
%>
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<%
dim currenttime
	currenttime =  now()
	'currenttime = #09/23/2015 09:00:00#

dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  64906
Else
	eCode   =  66104
End If
%>
<style type="text/css">
img {vertical-align:top;}
.myPerfectWedding {height:2102px; background:#f9dac8 url(http://webimage.10x10.co.kr/eventIMG/2015/66104/bg_flower.jpg) 50% 0 no-repeat;}
.weddingWrap {width:915px; margin:0 auto; padding:165px 0 0;}
.weddingHead {position:relative; padding-bottom:47px;}
.weddingHead .date {position:absolute; right:-29px; top:-39px; margin-top:-3px;}
.weddingHead .myPerfect {position:relative; top:-5px; padding:10px 0 14px; opacity:0; filter:alpha(opacity=0);}
.weddingHead .attention {opacity:0; filter:alpha(opacity=0);}
.weddingHead .tit h2 {position:relative; width:464px; height:117px; margin:0 auto;}
.weddingHead .tit h2 span {display:inline-block; position:absolute; top:0; opacity:0; margin-left:-5px; filter:alpha(opacity=0);}
.weddingHead .tit h2 span.t01 {left:0;}
.weddingHead .tit h2 span.t02 {left:100px;}
.weddingHead .tit h2 span.t03 {left:157px;}
.weddingHead .tit h2 span.t04 {left:225px;}
.weddingHead .tit h2 span.t05 {left:296px;}
.weddingHead .tit h2 span.t06 {left:334px;}
.weddingHead .tit h2 span.t07 {left:395px;}
.weddingHead .tit h2 span.point {left:309px; top:2px;}
.relatedEvt {overflow:hidden; padding:50px 0 26px 22px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/66104/bg_double_line.gif) 0 0 repeat-x;}
.relatedEvt div {float:left; padding:0 20px;}
.brandBigSale {position:relative; width:820px; padding:42px 0 60px; margin:0 auto; border-top:1px solid #f4f4f4;}
.brandBigSale h3 {padding-bottom:27px;}
.brandBigSale .btnMore {position:absolute; right:0; top:89px;}
.slide {position:relative; width:820px; height:390px; margin:0 auto; padding-bottom:20px;}
.slide .slidesjs-pagination {overflow:hidden; position:absolute; left:50%; bottom:0; width:97px; z-index:30; margin-left:-47px;}
.slide .slidesjs-pagination li {float:left; width:9px; height:8px; margin:0 5px;}
.slide .slidesjs-pagination li a {display:block; width:100%; height:8px; text-indent:-9999px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/66104/btn_pagination.gif);}
.slide .slidesjs-pagination li a.active {background-position:100% 0;}
</style>
<script type="text/javascript">
$(function(){
	// title animation
	$('.myPerfect').delay(200).animate({"top":"0","opacity":"1"},800);
	$('.tit h2 span.t01').delay(1000).animate({"opacity":"1","margin-left":"0"},500);
	$('.tit h2 span.t02').delay(1250).animate({"opacity":"1","margin-left":"0"},500);
	$('.tit h2 span.t03').delay(1500).animate({"opacity":"1","margin-left":"0"},500);
	$('.tit h2 span.t04').delay(1750).animate({"opacity":"1","margin-left":"0"},500);
	$('.tit h2 span.t05').delay(2000).animate({"opacity":"1","margin-left":"0"},500);
	$('.tit h2 span.t06').delay(2250).animate({"opacity":"1","margin-left":"0"},500);
	$('.tit h2 span.t07').delay(2500).animate({"opacity":"1","margin-left":"0"},500);
	$('.point').delay(3000).animate({"margin-top":"5px","opacity":"1"},500).animate({"margin-top":"0"},200);
	$('.attention').delay(3700).animate({"opacity":"1"},1000);
	// slide
	$('.slide').slidesjs({
		width:"820",
		height:"390",
		pagination:{effect:"fade"},
		navigation:false,
		play:{interval:2400, effect:"fade", auto:true},
		effect:{fade: {speed:600, crossfade:true}
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
	<!-- 2015웨딩기획전 : 메인 -->
	<div class="wedding2015">
		<div class="myPerfectWedding">
			<div class="weddingWrap">
				<div class="weddingHead">
					<div class="tit">
						<p class="guideBook"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66104/txt_guide_book.gif" alt="2015 F/W WEDDING GUIDE BOOK" /></p>
						<p class="myPerfect"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66104/txt_my_perfect.gif" alt="내게 너무 완벽한" /></p>
						<h2>
							<span class="t01"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66104/tit_wedding01.png" alt="W" /></span>
							<span class="t02"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66104/tit_wedding02.png" alt="E" /></span>
							<span class="t03"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66104/tit_wedding03.png" alt="D" /></span>
							<span class="t04"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66104/tit_wedding03.png" alt="D" /></span>
							<span class="t05"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66104/tit_wedding04.png" alt="I" /></span>
							<span class="t06"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66104/tit_wedding05.png" alt="N" /></span>
							<span class="t07"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66104/tit_wedding06.png" alt="G" /></span>
							<span class="point"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66104/img_point.png" alt="" /></span>
						</h2>
						<p class="attention"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66104/txt_attention.gif" alt="복잡하고 번거로운 웨딩이 싫다면 주목 해주세요" /></p>
						<p class="date"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66104/txt_date.gif" alt="09.21~10.19" /></p>
					</div>
				</div>
				<div class="weddingContent">
					<div class="relatedEvt">
						<div><a href="/event/eventmain.asp?eventid=66105"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66104/bnr_furniture.jpg" alt="" /></a></div>
						<div><a href="/event/eventmain.asp?eventid=66106"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66104/bnr_styling.jpg" alt="" /></a></div>
						<div><a href="/event/eventmain.asp?eventid=66107"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66104/bnr_self.jpg" alt="" /></a></div>
					</div>
					<div class="brandBigSale">
						<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/66104/tit_brand_sale.gif" alt="BRAND BIG SALE #15 - 마음까지 포근해지는 특별한 혜택" /></h3>
						<a href="/event/eventmain.asp?eventid=66108" class="btnMore"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66104/btn_more_brand.gif" alt="할인 브랜드 더 보러가기" /></a>
						<div class="slide">
							<a href="/street/street_brand_sub06.asp?makerid=arenazz"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66104/img_slide_brand01.jpg" alt="BLOOMING&ME" /></a>
							<a href="/street/street_brand_sub06.asp?rect=&prvtxt=&rstxt=&extxt=&sflag=n&dispCate=&cpg=1&chkr=False&chke=False&makerid=buy_beam&sscp=N&psz=50&srm=ne&iccd=0&styleCd=&attribCd=&icoSize=M&arrCate=121101&deliType=&minPrc=&maxPrc=&lstDiv=brand&slidecode=5&shopview=1"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66104/img_slide_brand02.jpg" alt="BUY BEAM" /></a>
							<a href="/street/street_brand_sub06.asp?makerid=designersroom"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66104/img_slide_brand03.jpg" alt="DESIGNERS ROOM" /></a>
							<a href="/street/street_brand_sub06.asp?makerid=maatila"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66104/img_slide_brand04.jpg" alt="MAATILA" /></a>
							<a href="/street/street_brand_sub06.asp?rect=&prvtxt=&rstxt=&extxt=&sflag=n&dispCate=&cpg=&chkr=False&chke=False&makerid=ssueim&sscp=Y&psz=50&srm=ne&iccd=&styleCd=&attribCd=&icoSize=M&arrCate=112&deliType=&minPrc=&maxPrc=&lstDiv=brand&slidecode=5&shopview=1"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66104/img_slide_brand05.jpg" alt="SSUEIM" /></a>
						</div>
					</div>

					<!-- 배너 이미지 및 링크 수정(10.05) -->
					<% If left(currenttime,10)<"2015-10-06" Then %>
						<div><a href="/event/eventmain.asp?eventid=66174"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66104/bnr_love_house.gif" alt="LOVE HOUSE" /></a></div>
					<% else %>
					<div><a href="/event/eventmain.asp?eventid=66393"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66104/bnr_love_house_v2.gif" alt="텐바이텐과 함께 러브하우스를 꾸며 줄 WOOZOO를 소개합니다." /></a></div>
					<% end if %>
				</div>
			</div>
		</div>
	</div>
	<!--// 2015웨딩기획전 : 메인 -->
	