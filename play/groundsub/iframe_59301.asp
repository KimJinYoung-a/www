<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<%
'########################################################
' PLAY #17 SHOE 3주차
' 2015-02-12 이종화 작성
'########################################################
Dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  "21472"
Else
	eCode   =  "59301"
End If

dim com_egCode, bidx
	Dim cEComment
	Dim iCTotCnt, arrCList,intCLoop, iSelTotCnt
	Dim iCPageSize, iCCurrpage
	Dim iCStartPage, iCEndPage, iCTotalPage, iCx,iCPerCnt
	Dim timeTern, totComCnt

	'파라미터값 받기 & 기본 변수 값 세팅
	iCCurrpage = requestCheckVar(Request("iCC"),10)	'현재 페이지 번호
	com_egCode = requestCheckVar(Request("eGC"),1)	

	IF iCCurrpage = "" THEN iCCurrpage = 1
	IF iCTotCnt = "" THEN iCTotCnt = -1

	'// 그룹번호 랜덤으로 지정

	iCPageSize = 15		'한 페이지의 보여지는 열의 수
	iCPerCnt = 10		'보여지는 페이지 간격

	'선택범위 리플개수 접수
	set cEComment = new ClsEvtComment

	cEComment.FECode 		= eCode
	cEComment.FComGroupCode	= com_egCode
	cEComment.FEBidx    	= bidx
	cEComment.FCPage 		= iCCurrpage	'현재페이지
	cEComment.FPSize 		= iCPageSize	'페이지 사이즈
	cEComment.FTotCnt 		= iCTotCnt  '전체 레코드 수

	arrCList = cEComment.fnGetComment		'리스트 가져오기
	iSelTotCnt = cEComment.FTotCnt '리스트 총 갯수
	set cEComment = nothing

	'코멘트 데이터 가져오기
	set cEComment = new ClsEvtComment

	cEComment.FECode 		= eCode
	'cEComment.FComGroupCode	= com_egCode
	cEComment.FEBidx    	= bidx
	cEComment.FCPage 		= iCCurrpage	'현재페이지
	cEComment.FPSize 		= iCPageSize	'페이지 사이즈
	cEComment.FTotCnt 		= iCTotCnt  '전체 레코드 수

	arrCList = cEComment.fnGetComment		'리스트 가져오기
	iCTotCnt = cEComment.FTotCnt '리스트 총 갯수
	set cEComment = nothing

	iCTotalPage 	=  Int(iCTotCnt/iCPageSize)	'전체 페이지 수
	IF (iCTotCnt MOD iCPageSize) > 0 THEN	iCTotalPage = iCTotalPage + 1
%>
<link rel="stylesheet" type="text/css" href="/lib/css/section.css" />
<style type="text/css">
img {vertical-align:top;}
.playGr20150216 {overflow:hidden;}
.intro {height:742px; background:url(http://webimage.10x10.co.kr/play/ground/20150216/img_intro.gif) center top no-repeat #f3f3f3;}
.applyEvent {padding:62px 0 55px; background:url(http://webimage.10x10.co.kr/play/ground/20150216/bg_slash.gif) left top repeat;}
.applyCont {overflow:hidden; width:1140px; margin:0 auto;}
.applyCont .ftRt {text-align:right; padding-top:20px;}
.applyCont .count {padding:25px 7px 0 0;}
.applyCont .count span {display:inline-block; padding:0 5px 0 8px; margin-top:-2px; font-size:42px; line-height:42px; color:#f6cc47; font-family:dotum;}
.applyCont .count span,
.applyCont .count img {vertical-align:middle;}
.cardGallery .pic {height:1177px; border-top:3px solid #000;}
.cardGallery .g01 {background:url(http://webimage.10x10.co.kr/play/ground/20150216/img_card01.jpg) center top no-repeat;}
.cardGallery .g02 {background:url(http://webimage.10x10.co.kr/play/ground/20150216/img_card02.jpg) center top no-repeat;}
.cardGallery .g03 {background:url(http://webimage.10x10.co.kr/play/ground/20150216/img_card03.jpg) center top no-repeat;}
.pictogram {text-align:center; padding:85px 0; background:#36cfbb;}
.mainCopy {position:relative; height:1077px; border-top:3px solid #fff; border-bottom:3px solid #2b2b2b; background:url(http://webimage.10x10.co.kr/play/ground/20150216/img_main_pic.jpg) center top no-repeat;}
.mainCopy .copy {overflow:hidden; position:absolute; left:50%; top:290px; width:368px; height:496px; margin-left:-184px; background:url(http://webimage.10x10.co.kr/play/ground/20150216/txt_copy_frame.png) center top no-repeat;}
.mainCopy .copy .txt {position:relative; overflow:hidden; width:100%; height:390px;}
.mainCopy .copy p {position:absolute;}
.mainCopy .copy p.c01 {left:-190px; top:0;}
.mainCopy .copy p.c02 {left:0; top:-180px;}
.mainCopy .copy p.c03 {left:0; top:205px;}
.mainCopy .copy p.c04 {right:-180px; top:0;}
.walkWithYou {height:737px; border-top:3px solid #2b2b2b; border-bottom:3px solid #2b2b2b; background:#f5f5f1;}
.walkWithYou .walkCont {position:relative; width:1000px; padding-top:165px; margin:0 auto;}
.walkWithYou .walkCont .ftLt {padding-top:62px;}
.walkWithYou .walkCont .ftRt p {padding-bottom:35px;}
.cardInfo {}
.cardInfo li {overflow:hidden; height:700px; border-bottom:2px solid #929292;}
.cardInfo li.typeA {background:url(http://webimage.10x10.co.kr/play/ground/20150216/bg_pattern01.gif) center top no-repeat;}
.cardInfo li.typeB {background:url(http://webimage.10x10.co.kr/play/ground/20150216/bg_pattern02.gif) center top no-repeat;}
.cardCont {position:relative; width:1140px; height:700px; margin:0 auto; background:url(http://webimage.10x10.co.kr/play/ground/20150216/blt_arrow.gif) center 30px no-repeat;}
.wishCard .cardCont {background:none;}
.cardCont h3 {position:absolute; z-index:40;}
.typeA .cardCont h3 {left:80px;}
.typeB .cardCont h3 {right:80px;}
.cardCont h3 img {overflow:hidden; display:block; position:absolute; left:0; top:0; z-index:40;}
.cardCont h3 span {overflow:hidden; display:block; position:absolute; left:0; top:0; width:100%; height:100%; background:#000; z-index:30;}
.cardCont h3 span em {display:block; position:absolute; left:-50px; top:0; width:35px; height:60px; z-index:35;}
.wishCard h3 {top:281px; width:125px; height:110px;}
.activeCard h3 {top:260px; width:177px; height:111px;}
.loveCard h3 {top:260px; width:125px; height:112px;}
.kindCard h3 {top:272px;width:123px; height:110px;}
.wishCard h3 span em {background:#ff8383; width:42px;}
.activeCard h3 span em {background:#f6ca40;}
.loveCard h3 span em {background:#86c9fa; width:32px;}
.kindCard h3 span em {background:#2ec897;}
.cardCont p {position:absolute;}
.cardCont .desc {position:absolute; z-index:50; opacity:0;}
.typeA .cardCont .desc {left:90px;}
.typeB .cardCont .desc {right:90px;}
.wishCard .cardCont .desc {top:422px;} 
.activeCard .cardCont .desc {top:402px;}
.loveCard .cardCont .desc {top:402px;}
.kindCard .cardCont .desc {top:412px;}
.cardCont .word {position:absolute; bottom:202px; z-index:40; opacity:0;}
.wishCard .cardCont .word {left:295px;}
.activeCard .cardCont .word {left:668px;}
.loveCard .cardCont .word {left:323px;}
.kindCard .cardCont .word {left:775px;}
.cardCont .pic {bottom:-450px;}
.typeA .cardCont .pic {right:80px;}
.typeB .cardCont .pic {left:80px;}
.cardCont .gift {bottom:53px;}
.typeA .cardCont .gift {left:80px;}
.typeB .cardCont .gift {right:80px;}
@media all and (min-width:1920px) {
	.mainCopy {background-size:100% 100%;}
	.cardGallery .pic {background-size:100% 100%;}
}
</style>
<script type="text/javascript">
$(function(){
	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 1850){
			$('.copy p.c01').animate({left:'0'},700);
			$('.copy p.c02').animate({top:'0'},800);
			$('.copy p.c03').animate({top:'0'},900);
			$('.copy p.c04').animate({right:'0'},1000);
		}
		if (scrollTop > 2800){
			$('.wishCard .pic').animate({bottom:'0'},1200);
			$('.wishCard .desc').delay(400).animate({left:'80px',opacity:'1'},1000);
			$('.wishCard .word').delay(1200).animate({left:'305px',opacity:'1'},1400);
			$('.wishCard h3 span em').delay(1050).animate({left:'0'},1000);
		}
		if (scrollTop > 3500){
			$('.activeCard .pic').animate({bottom:'0'},1200);
			$('.activeCard .desc').delay(400).animate({right:'80px',opacity:'1'},1000);
			$('.activeCard .word').delay(1200).animate({left:'658px',opacity:'1'},1400);
			$('.activeCard h3 span em').delay(1050).animate({left:'0'},1000);
		}
		if (scrollTop > 4200){
			$('.loveCard .pic').animate({bottom:'0'},1200);
			$('.loveCard .desc').delay(400).animate({left:'80px',opacity:'1'},1000);
			$('.loveCard .word').delay(1200).animate({left:'333px',opacity:'1'},1400);
			$('.loveCard h3 span em').delay(1050).animate({left:'0'},1000);
		}
		if (scrollTop > 4900){
			$('.kindCard .pic').animate({bottom:'0'},1200);
			$('.kindCard .desc').delay(400).animate({right:'80px',opacity:'1'},1000);
			$('.kindCard .word').delay(1200).animate({left:'765px',opacity:'1'},1400);
			$('.kindCard h3 span em').delay(1050).animate({left:'0'},1000);
		}
	});
	$(".walkWithYou a").click(function(event){
		event.preventDefault();
		window.parent.$('html,body').animate({scrollTop:$(this.hash).offset().top}, 800);
	});
});
</script>
<script type="text/javascript">
<!--
 	function jsSubmitComment(){
		<% if Not(IsUserLoginOK) then %>
		    jsChklogin('<%=IsUserLoginOK%>');
		    return false;
		<% end if %>

	   var frm = document.frmcom;
	   frm.action = "doEventSubscript59301.asp";
	   frm.submit();
	   return true;
	}
//-->
</script>
<div class="playGr20150216">
	<div class="intro"></div>
	<div class="walkWithYou">
		<div class="walkCont">
			<p class="ftLt"><img src="http://webimage.10x10.co.kr/play/ground/20150216/txt_walk_together.gif" alt="가치걷기" /></p>
			<div class="ftRt">
				<p><img src="http://webimage.10x10.co.kr/play/ground/20150216/txt_with01.gif" alt="" /></p>
				<p><img src="http://webimage.10x10.co.kr/play/ground/20150216/txt_with02.gif" alt="" /></p>
				<p><img src="http://webimage.10x10.co.kr/play/ground/20150216/txt_with03.gif" alt="" /></p>
				<p><img src="http://webimage.10x10.co.kr/play/ground/20150216/txt_with04.gif" alt="" /></p>
				<a href="#applyEvent"><img src="http://webimage.10x10.co.kr/play/ground/20150216/btn_go_apply.gif" alt="가치걷기 신청하러가기" /></a>
			</div>
		</div>
	</div>
	<div class="pictogram"><p><img src="http://webimage.10x10.co.kr/play/ground/20150216/img_icon.jpg" alt="" /></p></div>
	<div class="mainCopy">
		<div class="copy">
			<div class="txt">
				<p class="c01"><img src="http://webimage.10x10.co.kr/play/ground/20150216/txt_copy01.png" alt="가" /></p>
				<p class="c02"><img src="http://webimage.10x10.co.kr/play/ground/20150216/txt_copy02.png" alt="치" /></p>
				<p class="c03"><img src="http://webimage.10x10.co.kr/play/ground/20150216/txt_copy03.png" alt="걷" /></p>
				<p class="c04"><img src="http://webimage.10x10.co.kr/play/ground/20150216/txt_copy04.png" alt="기" /></p>
			</div>
		</div>
	</div>
	<div class="cardInfo">
		<ul>
			<li class="wishCard typeA">
				<div class="cardCont">
					<h3><img src="http://webimage.10x10.co.kr/play/ground/20150216/tit_wish_card.png" alt="WISH CARD" /><span><em></em></span></h3>
					<p class="desc"><img src="http://webimage.10x10.co.kr/play/ground/20150216/txt_desc_w.png" alt="신발, 양말, 이어폰 등 WISH 에 넣어두었던 걷기에 필요한 상품을 구매해보세요." /></p>
					<p class="word"><img src="http://webimage.10x10.co.kr/play/ground/20150216/txt_word_w.png" alt="W" /></p>
					<p class="gift"><img src="http://webimage.10x10.co.kr/play/ground/20150216/txt_gift_card.gif" alt="10X10 GIFT CARD" /></p>
					<p class="pic"><img src="http://webimage.10x10.co.kr/play/ground/20150216/img_card_w.png" alt="카드이미지" /></p>
				</div>
			</li>
			<li class="activeCard typeB">
				<div class="cardCont">
					<h3><img src="http://webimage.10x10.co.kr/play/ground/20150216/tit_active_card.png" alt="ACTIVE CARD" /><span><em></em></span></h3>
					<p class="desc"><img src="http://webimage.10x10.co.kr/play/ground/20150216/txt_desc_a.png" alt="신발, 양말, 이어폰 등 WISH 에 넣어두었던 걷기에 필요한 상품을 구매해보세요." /></p>
					<p class="word"><img src="http://webimage.10x10.co.kr/play/ground/20150216/txt_word_a.png" alt="A" /></p>
					<p class="gift"><img src="http://webimage.10x10.co.kr/play/ground/20150216/txt_tmoney_card.gif" alt="10X10 GIFT CARD" /></p>
					<p class="pic"><img src="http://webimage.10x10.co.kr/play/ground/20150216/img_card_a.png" alt="카드이미지" /></p>
				</div>
			</li>
			<li class="loveCard typeA">
				<div class="cardCont">
					<h3><img src="http://webimage.10x10.co.kr/play/ground/20150216/tit_love_card.png" alt="LOVE CARD" /><span><em></em></span></h3>
					<p class="desc"><img src="http://webimage.10x10.co.kr/play/ground/20150216/txt_desc_l.png" alt="신발, 양말, 이어폰 등 WISH 에 넣어두었던 걷기에 필요한 상품을 구매해보세요." /></p>
					<p class="word"><img src="http://webimage.10x10.co.kr/play/ground/20150216/txt_word_l.png" alt="L" /></p>
					<p class="gift"><img src="http://webimage.10x10.co.kr/play/ground/20150216/txt_socar_card.gif" alt="10X10 GIFT CARD" /></p>
					<p class="pic"><img src="http://webimage.10x10.co.kr/play/ground/20150216/img_card_l.png" alt="카드이미지" /></p>
				</div>
			</li>
			<li class="kindCard typeB">
				<div class="cardCont">
					<h3><img src="http://webimage.10x10.co.kr/play/ground/20150216/tit_kind_card.png" alt="KIND CARD" /><span><em></em></span></h3>
					<p class="desc"><img src="http://webimage.10x10.co.kr/play/ground/20150216/txt_desc_k.png" alt="신발, 양말, 이어폰 등 WISH 에 넣어두었던 걷기에 필요한 상품을 구매해보세요." /></p>
					<p class="word"><img src="http://webimage.10x10.co.kr/play/ground/20150216/txt_word_k.png" alt="K" /></p>
					<p class="gift"><img src="http://webimage.10x10.co.kr/play/ground/20150216/txt_music_card.gif" alt="10X10 GIFT CARD" /></p>
					<p class="pic"><img src="http://webimage.10x10.co.kr/play/ground/20150216/img_card_k.png" alt="카드이미지" /></p>
				</div>
			</li>
		</ul>
	</div>
	<!-- 응모하기 -->
	<form name="frmcom" method="post" style="margin:0px;">
	<input type="hidden" name="eventid" value="<%=eCode%>"/>
	<input type="hidden" name="bidx" value="<%=bidx%>"/>
	<input type="hidden" name="iCC" value="<%=iCCurrpage%>"/>
	<input type="hidden" name="iCTot" value=""/>
	<input type="hidden" name="mode" value="add"/>
	<input type="hidden" name="spoint" value="1">
	<input type="hidden" name="userid" value="<%=GetLoginUserID%>"/>
	<div class="applyEvent" id="applyEvent">
		<div class="applyCont">
			<p class="ftLt"><img src="http://webimage.10x10.co.kr/play/ground/20150216/txt_apply_kit.png" alt="응모하신 분들 중 5분을 추첨해 텐바이텐 PLAY가 제작한 가치걷기 KIT를 선물로 드립니다." /></p>
			<div class="ftRt">
				<a href="" onclick="jsSubmitComment();return false;"><img src="http://webimage.10x10.co.kr/play/ground/20150216/btn_walk_together.png" alt="가치걷기 신청하기" /></a>
				<p class="count">
					<img src="http://webimage.10x10.co.kr/play/ground/20150216/txt_count_walk01.png" alt="총" />
					<span><%=iCTotCnt%></span>
					<img src="http://webimage.10x10.co.kr/play/ground/20150216/txt_count_walk02.png" alt="명이 같이 걷고 있습니다." />
				</p>
			</div>
		</div>
	</div>
	</form>
	<!--// 응모하기 -->
	<div class="cardGallery">
		<div class="pic g01"></div>
		<div class="pic g02"></div>
		<div class="pic g03"></div>
	</div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->