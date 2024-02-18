<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventCls.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
'####################################################
' Description : 핑크스타그램
' History : 2016-10-07 김진영 작성
'####################################################
Dim currentDate, eCode, currTabNum, i
currentDate = Date()
IF application("Svr_Info") = "Dev" THEN
	eCode   =  66217
Else
	eCode   =  73370
End If

If currentDate <= "2016-10-10" Then
	currTabNum = 0
ElseIf currentDate = "2016-10-11" Then
	currTabNum = 1
ElseIf currentDate = "2016-10-12" Then
	currTabNum = 2
ElseIf currentDate = "2016-10-13" Then
	currTabNum = 3
ElseIf (currentDate = "2016-10-14") OR (currentDate = "2016-10-15") OR (currentDate = "2016-10-16") Then
	currTabNum = 4
ElseIf currentDate = "2016-10-17" Then
	currTabNum = 5
ElseIf currentDate = "2016-10-18" Then
	currTabNum = 6
ElseIf currentDate = "2016-10-19" Then
	currTabNum = 7
ElseIf currentDate = "2016-10-20" Then
	currTabNum = 8
ElseIf (currentDate = "2016-10-21") OR (currentDate = "2016-10-22") OR (currentDate = "2016-10-23") Then
	currTabNum = 9
ElseIf currentDate >= "2016-10-24" Then
	currTabNum = 10
End If
%>
<style type="text/css">
img {vertical-align:top;}
.evt73370 {background-color:#feacc0;}
.evt73370 .section {position:relative;}
.evt73370 .pinkSlide {position:absolute; left:50%; top:100px; width:1040px; height:640px; margin-left:-520px;}
.evt73370 .pinkSlide .swiper-container {width:100%; height:640px;}
.evt73370 .pinkSlide .swiper-container:before {position:absolute; left:0; top:0; width:10px; height:640px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/73370/img_slide_deco_lt.png) no-repeat 0 0; content:''; z-index:10;}
.evt73370 .pinkSlide .swiper-container:after {position:absolute; right:0; top:0; width:10px; height:640px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/73370/img_slide_deco_rt.png) no-repeat 100% 0; content:''; z-index:10;}
.evt73370 .pinkSlide .swiper-container .swiper-slide {position:relative; float:left;}
.evt73370 .pinkSlide .swiper-container .swiper-slide i {overflow:hidden; display:none; position:absolute; right:40px; top:0; width:113px; height:120px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/73370/img_today.png) no-repeat 50% 0; text-indent:-999em; z-index:10;}
.evt73370 .pinkSlide .swiper-container .swiper-slide .itemLink1 {overflow:hidden; display:block; position:absolute; left:0px; top:0; width:520px; height:640px; background-color:rgba(255,255,255,0); text-indent:-999em; z-index:15;}
.evt73370 .pinkSlide .swiper-container .swiper-slide .itemLink2 {overflow:hidden; display:block; position:absolute; right:0; top:0; width:520px; height:640px; background-color:rgba(255,255,255,0); text-indent:-999em; z-index:15;}
.evt73370 .pinkSlide .swiper-container div.today i {display:block;}
.evt73370 .pinkSlide .slideNav {overflow:hidden; display:block; position:absolute; top:0; width:80px; height:640px; background-position:50% 50%; background-repeat:no-repeat; background-color:transparent; text-indent:-999em; outline:none; z-index:20;}
.evt73370 .pinkSlide .btnPrev {left:10px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/73370/btn_slide_prev.png);}
.evt73370 .pinkSlide .btnNext {right:10px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/73370/btn_slide_next.png);}
.evt73370 .pinkSlide .pagination {overflow:hidden; position:absolute; left:50%; bottom:-60px; width:792px; height:28px; margin-left:-410px; padding:0 14px; text-align:center; background:url(http://webimage.10x10.co.kr/eventIMG/2016/73370/bg_slide_nav_v1.png) no-repeat 0 0;}
.evt73370 .pinkSlide .pagination span {float:left; width:34px; height:28px; margin:0 16px; cursor:pointer;}
.evt73370 .pinkSlide .pagination span.swiper-active-switch {background:url(http://webimage.10x10.co.kr/eventIMG/2016/73370/img_slide_nav.png) no-repeat 50% 0;}
.evt73370 .vodArea {padding-bottom:90px;}
</style>
<script type="text/javascript">
$(function(){
	if ($(".pinkSlide .swiper-container .swiper-slide").length > 1) {
		pinkSlide = new Swiper('.pinkSlide .swiper-container',{
			initialSlide:<%= currTabNum %>,
			loop:true,
			autoplay:3000,
			autoplayDisableOnInteraction:false,
			speed:800,
			pagination:".pinkSlide .pagination",
			paginationClickable:true,
			nextButton:'.pinkSlide .swiper-button-prev',
			prevButton:'.pinkSlide .swiper-button-prev'
		});
	} else {
		pinkSlide = new Swiper('.pinkSlide .swiper-container',{
			initialSlide:0,
			loop:false,
			pagination:".pinkSlide .pagination",
			paginationClickable:true,
			noSwipingClass:".noswiping",
			noSwiping:true
		});
	}

	$('.pinkSlide .btnPrev').on('click', function(e){
		e.preventDefault()
		pinkSlide.swipePrev()
	});

	$('.pinkSlide .btnNext').on('click', function(e){
		e.preventDefault()
		pinkSlide.swipeNext()
	});
});
</script>
<div class="evt73370">
	<h2><img src="http://webimage.10x10.co.kr/eventIMG/2016/73370/tit_pinkstargram.png" alt="Pinkstagram X Ten by Ten" /></h2>

	<div class="section">
		<div class="pinkSlide">
			<div class="swiper-container">
				<div class="swiper-wrapper">
				<% If currentDate >= "2016-10-07" Then %>
					<div class="swiper-slide<%= Chkiif(currTabNum="0", " today", "") %>">
						<a href="/shopping/category_prd.asp?itemid=1568983&pEtr=73370" title="구매하러가기"><i>Today pink</i><img src="http://webimage.10x10.co.kr/eventIMG/2016/73370/img_slide01.jpg" alt="샌드위치 시계 230N pinklemonade edition" /></a>
					</div>
				<% End If %>
				<% If currentDate >= "2016-10-11" Then %>
					<div class="swiper-slide<%= Chkiif(currTabNum="1", " today", "") %>">
						<a href="/shopping/category_prd.asp?itemid=1574245&pEtr=73370" title="구매하러가기"><i>Today pink</i><img src="http://webimage.10x10.co.kr/eventIMG/2016/73370/img_slide02.jpg" alt="Valentine pink_5cm" /></a>
					</div>
				<% End If %>
				<% If currentDate >= "2016-10-12" Then %>
					<div class="swiper-slide<%= Chkiif(currTabNum="2", " today", "") %>">
						<a href="/shopping/category_prd.asp?itemid=1575176&pEtr=73370" title="구매하러가기"><i>Today pink</i><img src="http://webimage.10x10.co.kr/eventIMG/2016/73370/img_slide03.jpg" alt="Special limited-e" /></a>
					</div>
				<% End If %>
				<% If currentDate >= "2016-10-13" Then %>
					<div class="swiper-slide<%= Chkiif(currTabNum="3", " today", "") %>">
						<a href="/shopping/category_prd.asp?itemid=1571817&pEtr=73370" title="구매하러가기"><i>Today pink</i><img src="http://webimage.10x10.co.kr/eventIMG/2016/73370/img_slide04.jpg" alt="과자전 Love&Thanks 순이 인형" /></a>
					</div>
				<% End If %>
				<% If currentDate >= "2016-10-14" Then %>
					<div class="swiper-slide<%= Chkiif(currTabNum="4", " today", "") %>">
						<a href="/shopping/category_prd.asp?itemid=1575177&pEtr=73370" title="구매하러가기"><i>Today pink</i><img src="http://webimage.10x10.co.kr/eventIMG/2016/73370/img_slide05.jpg" alt="Kafka called crow boy for Phonecase" /></a>
					</div>
				<% End If %>
				<% If currentDate >= "2016-10-17" Then %>
					<div class="swiper-slide<%= Chkiif(currTabNum="5", " today", "") %>">
						<a href="/shopping/category_prd.asp?itemid=1548822&pEtr=73370" title="구매하러가기"><i>Today pink</i><img src="http://webimage.10x10.co.kr/eventIMG/2016/73370/img_slide06.jpg" alt="groovy 80's pink" /></a>
					</div>
				<% End If %>
				<% If currentDate >= "2016-10-18" Then %>
					<div class="swiper-slide<%= Chkiif(currTabNum="6", " today", "") %>">
						<a href="/shopping/category_prd.asp?itemid=1575179&pEtr=73370" title="구매하러가기"><i>Today pink</i><img src="http://webimage.10x10.co.kr/eventIMG/2016/73370/img_slide07_v1.jpg" alt="DAY MAKE-UP POUCH 핑크 에디션" /></a>
					</div>
				<% End If %>
				<% If currentDate >= "2016-10-19" Then %>
					<div class="swiper-slide<%= Chkiif(currTabNum="7", " today", "") %>">
						<a href="/shopping/category_prd.asp?itemid=1575178&pEtr=73370" title="구매하러가기"><i>Today pink</i><img src="http://webimage.10x10.co.kr/eventIMG/2016/73370/img_slide08.jpg" alt="헤이로즈 -리얼 코튼 백" /></a>
					</div>
				<% End If %>
				<% If currentDate >= "2016-10-20" Then %>
					<div class="swiper-slide<%= Chkiif(currTabNum="8", " today", "") %>">
						<a href="/shopping/category_prd.asp?itemid=1573879&pEtr=73370" title="구매하러가기"><i>Today pink</i><img src="http://webimage.10x10.co.kr/eventIMG/2016/73370/img_slide09.jpg" alt="3560 클로젯 메탈행거 4단 핑크" /></a>
					</div>
				<% End If %>
				<% If currentDate >= "2016-10-21" Then %>
					<div class="swiper-slide<%= Chkiif(currTabNum="9", " today", "") %>">
						<a href="/shopping/category_prd.asp?itemid=1574052&pEtr=73370" title="구매하러가기"><i>Today pink</i><img src="http://webimage.10x10.co.kr/eventIMG/2016/73370/img_slide10.jpg" alt="미래식사 밀스 핑크에디션 1.0 보틀형" /></a>
					</div>
				<% End If %>
				<% If currentDate >= "2016-10-24" Then %>
					<div class="swiper-slide<%= Chkiif(currTabNum="10", " today", "") %>">
						<a href="/shopping/category_prd.asp?itemid=1568068&pEtr=73370" title="구매하러가기"><i>Today pink</i><img src="http://webimage.10x10.co.kr/eventIMG/2016/73370/img_slide11.jpg" alt="라이브워크 6달플래너 - DAILY SLOWLY PINK" /></a>
					</div>
					<div class="swiper-slide<%= Chkiif(currTabNum="10", " today", "") %>">
						<a href="/shopping/category_prd.asp?itemid=1577612&pEtr=73370" title="구매하러가기"><i>Today pink</i><img src="http://webimage.10x10.co.kr/eventIMG/2016/73370/img_slide12.jpg" alt="[Disney]Alice_Pink memo pad" /></a>
					</div>
				<% End If %>
				</div>
			</div>
			<div class="pagination"></div>
			<button type="button" class="slideNav btnPrev">이전</button>
			<button type="button" class="slideNav btnNext">다음</button>
		</div>
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/73370/img_pinkstargram.png" alt="PINK.STARGRAM" usemap="#pinkgramMap" /></p>
		<map name="pinkgramMap">
			<area shape="rect" coords="90,0,1050,100" href="https://www.instagram.com/pink.stargram/" target="_blank" alt="핑크스타그램 구경가기" />
		</map>
		<div class="vodArea">
			<iframe src="https://player.vimeo.com/video/185909000" width="960" height="540" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
		</div>
	</div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->