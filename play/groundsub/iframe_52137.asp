<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<%
'#### 2014-05-20 이종화 작성 play_sub ###################
Dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  21178
Else
	eCode   =  52137
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

	iCPageSize = 8		'한 페이지의 보여지는 열의 수
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
.groundCont {min-width:1140px; background-color:#f9faff;}
.groundCont .grArea {width:100%;}
.groundCont .tagView {width:1100px; margin:0 auto; padding:32px 20px 50px; border-top:1px solid #e6e4d9;}
.playGr20140526 {width:100%;}
.lunchKiki .section {}
.lunchKiki .section1 {height:1030px; background:url(http://webimage.10x10.co.kr/play/ground/20140526/bg_pattern_dot_sky.gif) left top repeat;}
.lunchKiki .section1 .group {position:relative; height:1030px; background:url(http://webimage.10x10.co.kr/play/ground/20140526/bg_island.png) 72% 24px no-repeat;}
.lunchKiki .section1 .group .part {position:absolute; left:0; top:593px; z-index:20; width:100%; height:441px; background:url(http://webimage.10x10.co.kr/play/ground/20140526/bg_pattern_wave.png) left top repeat-x;}
.lunchKiki .section1 .group .part .area {width:1140px; margin:-506px auto 0; padding-bottom:119px; background:url(http://webimage.10x10.co.kr/play/ground/20140526/bg_under_the_sea.gif) left bottom no-repeat; text-align:center;}
.lunchKiki .section2 {height:1382px; background:url(http://webimage.10x10.co.kr/play/ground/20140526/bg_pattern_comb.gif) left top repeat-x;}
.lunchKiki .section2 .group {*overflow:hidden; position:relative;}
.lunchKiki .section2 .group .part {position:relative; width:1140px; height:1382px; margin:0 auto; background:url(http://webimage.10x10.co.kr/play/ground/20140526/bg_tv.png) center 430px no-repeat; text-align:center;}
.lunchKiki .section2 .part .plamtreeLeft {position:absolute; top:0; left:-400px; z-index:10;}
.lunchKiki .section2 .part .plamtreeRight {position:absolute; top:0; right:-400px; z-index:10;}
@media all and (min-width:1920px) {
	.lunchKiki .section2 .part .plamtreeLeft {position:absolute; left:-600px;}
	.lunchKiki .section2 .part .plamtreeRight {position:absolute; right:-600px;}
}
.lunchKiki .section2 .group .part h4 {position:relative; z-index:30; margin-top:-33px; *margin-top:0;}
.lunchKiki .section2 .group .part p {margin-top:36px;}
.lunchKiki .section2 .group .part .bnr {padding-top:105px; padding-right:102px; text-align:right;}
.lunchKiki .section2 .group .part .movie {margin:17px 0 0 70px; text-align:left;}
.lunchKiki .section2 .group .part .sponsor {position:absolute; left:75px; bottom:222px; padding-left:10px; background:url(http://webimage.10x10.co.kr/play/ground/20140526/blt_suqare_brown.gif) left 7px no-repeat; color:#82650d; font-weight:normal;}
.lunchKiki .section2 .group .part .btnGo {margin-top:17px; padding-right:72px; text-align:right;}
.lunchKiki .section3 {border-top:10px solid #ffb884; background:url(http://webimage.10x10.co.kr/play/ground/20140526/bg_pattern_dot_pink.gif) left top repeat;}
.lunchKiki .section3 .group {width:1140px; margin:0 auto; padding-bottom:74px;}
.lunchKiki .section3 .group h4 {position:relative; z-index:20; text-align:center;}
.lunchKiki .section3 .group .part {position:relative; z-index:10; margin-top:-72px; padding:109px 56px 67px; border:1px solid #f2d5c0; background-color:#fff; text-align:left;}
.lunchKiki .section3 .group .part p {padding-left:390px;}
.lunchKiki .section3 .group .part p:first-child {margin-top:24px;}
.lunchKiki .section3 .group .part ul {overflow:hidden; padding:51px 0 0 16px; border-top:1px solid #f2efed;}
.lunchKiki .section3 .group .part ul li {float:left; padding-right:61px;}
.lunchKiki .section3 .group .part .photo {position:absolute; top:109px; left:67px;}
.lunchKiki .section3 .group .part .bg {position:absolute; top:-74px; right:0;}
.lunchKiki .section3 .group .btnGo {margin-top:25px; padding-right:19px; text-align:right;}
.lunchKiki .section3 .group .btnGo a {margin-left:14px;}
.lunchKiki .section4 {border-top:10px solid #dfd1fd; background:url(http://webimage.10x10.co.kr/play/ground/20140526/bg_pattern_stripe.gif) left top repeat;}
.lunchKiki .section4 .group {width:1140px; margin:0 auto; padding-bottom:80px; text-align:center;}
.lunchKiki .section4 .group h4 {margin-top:-20px;}
.lunchKiki .section4 .group p {margin-top:46px;}
.lunchKiki .section5 {margin-top:-18px; height:420px; background:url(http://webimage.10x10.co.kr/play/ground/20140526/bg_pattern_wave_purple.png) left top repeat-x;}
.lunchKiki .section5 .group {position:relative; width:1140px; margin:0 auto; padding:70px 0 38px; background:url(http://webimage.10x10.co.kr/play/ground/20140526/bg_pattern_purple.png) left 20px no-repeat; text-align:center;}
.lunchKiki .section5 .group .btnGo {position:absolute; top:-86px; right:0;}
.lunchKiki .section5 .group .part {position:relative; width:633px; height:84px; margin:23px auto 0; padding:33px 0 0 73px; background:url(http://webimage.10x10.co.kr/play/ground/20140526/bg_round_box.png) left top no-repeat; text-align:left;}
.lunchKiki .section5 .group .part strong {color:#888; font-size:20px; font-family:'Dotum', 'Verdana';}
.lunchKiki .section5 .group .part span {margin:0 19px 0 4px;}
.lunchKiki .section5 .group .part span input {width:36px; height:36px; margin-left:10px; border:2px solid #bbb; color:#444; font-size:26px; font-family:'Dotum', 'Verdana'; font-weight:bold; line-height:36px; text-align:center;}
.lunchKiki .section5 .group .part .btnSubmit {position:absolute; top:32px; right:-26px;}
.lunchKiki .section5 .group .gift {margin-top:30px; color:#fff; font-weight:bold; line-height:2em; text-align:center;}
.lunchKiki .section5 .group .gift strong {display:inline-block; padding:0 5px; line-height:1.5em; background-color:#674fb5;}
.lunchKiki .section5 .group .gift em {display:block; color:#110637;}
.lunchKiki .section6 {border-top:10px solid #b0a0e6; background-color:#f9faff;}
.lunchKiki .section6 .group {width:1140px; margin:0 auto; padding:45px 0 60px;}
.lunchKiki .section6 .group .formMobile {padding-right:32px; color:#888; text-align:right;}
.lunchKiki .section6 .group .formMobile span {display:inline-block; padding-bottom:2px; border-bottom:1px solid #d9d9d9;}
.lunchKiki .section6 .group .formMobile span img {margin-top:-1px; vertical-align:middle;}
.lunchKiki .section6 .group .part {overflow:hidden; width:1141px; margin-right:-1px; padding-left:19px;}
.lunchKiki .section6 .group .part .area {float:left; position:relative; height:114px;margin:20px 23px 0 0; padding-top:22px;}
.lunchKiki .section6 .group .part .area .num {display:block; position:absolute; top:100px; width:114px; color:#fff; font-size:11px; text-align:center;}
.lunchKiki .section6 .group .part .area .id {color:#999;}
.lunchKiki .section6 .group .part .area .song {margin-top:20px; color:#777; font-size:20px; font-family:'Dotum', 'Verdana'; font-weight:bold;}
.lunchKiki .section6 .group .part .area .date {display:block; margin-top:10px; color:#999; text-align:right;}
.lunchKiki .section6 .group .part .area .date img {margin-top:-2px; vertical-align:middle;}
.lunchKiki .section6 .group .part .area .btnDel {position:absolute; top:10px; right:10px; width:21px; height:21px; background:url(http://webimage.10x10.co.kr/play/ground/20140526/btn_del.png) left top no-repeat; text-indent:-999em;}
.lunchKiki .section6 .group .part .bg1 {width:342px; padding-right:32px; padding-left:164px; background:url(http://webimage.10x10.co.kr/play/ground/20140526/bg_song_box_01.png) left top no-repeat;}
.lunchKiki .section6 .group .part .bg1 .num {left:11px;}
.lunchKiki .section6 .group .part .bg1 .song strong {color:#2ccbc9;}
.lunchKiki .section6 .group .part .bg2 {width:341px; padding-right:138px; padding-left:59px; background:url(http://webimage.10x10.co.kr/play/ground/20140526/bg_song_box_02.png) left top no-repeat;}
.lunchKiki .section6 .group .part .bg2 .num {right:11px;}
.lunchKiki .section6 .group .part .bg2 .song strong {color:#ff8173;}
.lunchKiki .section6 .group .part .bg3 {width:342px; padding-right:32px; padding-left:164px; background:url(http://webimage.10x10.co.kr/play/ground/20140526/bg_song_box_03.png) left top no-repeat;}
.lunchKiki .section6 .group .part .bg3 .num {left:11px;}
.lunchKiki .section6 .group .part .bg3 .song strong {color:#ffbb29;}
.lunchKiki .section6 .group .part .bg4 {width:341px; padding-right:138px; padding-left:59px;  background:url(http://webimage.10x10.co.kr/play/ground/20140526/bg_song_box_04.png) left top no-repeat;}
.lunchKiki .section6 .group .part .bg4 .num {right:11px;}
.lunchKiki .section6 .group .part .bg4 .song strong {color:#987cf5;}
.lunchKiki .section6 .group .paging {margin-top:60px;}
.lunchKiki .section6 .group .paging a {background-color:transparent;}
</style>
<script type="text/javascript">
$(function(){
	/* Move */
	$(".btnMove a").click(function(event){
		event.preventDefault();
		window.parent.$('html,body').animate({scrollTop:$(this.hash).offset().top}, 500);
	});
});
</script>
<script type="text/javascript">
<!--
 	function jsGoComPage(iP){
		document.frmcom.iCC.value = iP;
		document.frmcom.iCTot.value = "<%=iCTotCnt%>";
		document.frmcom.submit();
	}

	function jsSubmitComment(frm){
		<% if Not(IsUserLoginOK) then %>
		    jsChklogin('<%=IsUserLoginOK%>');
		    return false;
		<% end if %>

	   if(!frm.msg1.value || frm.msg1.value == "런"){
	    alert("가사를 바꿔주세요");
		document.frmcom.msg1.value="";
	    frm.msg1.focus();
	    return false;
	   }

	   if(!frm.msg2.value || frm.msg2.value == "치"){
	    alert("가사를 바꿔주세요");
		document.frmcom.msg2.value="";
	    frm.msg2.focus();
	    return false;
	   }

	   if(!frm.msg3.value || frm.msg3.value == "런"){
	    alert("가사를 바꿔주세요");
		document.frmcom.msg3.value="";
	    frm.msg3.focus();
	    return false;
	   }

	   if(!frm.msg4.value || frm.msg4.value == "치"){
	    alert("가사를 바꿔주세요");
		document.frmcom.msg4.value="";
	    frm.msg4.focus();
	    return false;
	   }

	   document.frmcom.txtcomm.value = document.frmcom.msg1.value + document.frmcom.msg2.value + document.frmcom.msg3.value + document.frmcom.msg4.value;

	   frm.action = "/event/lib/comment_process.asp";
	   return true;
	}

	function jsDelComment(cidx)	{
		if(confirm("삭제하시겠습니까?")){
			document.frmdelcom.Cidx.value = cidx;
	   		document.frmdelcom.submit();
		}
	}

	function jsChklogin11(blnLogin)
	{
		if (blnLogin == "True"){
			if(document.frmcom.msg1.value == "런"){
				document.frmcom.msg1.value="";
			}
			if(document.frmcom.msg2.value == "치"){
				document.frmcom.msg2.value="";
			}
			if(document.frmcom.msg3.value == "런"){
				document.frmcom.msg3.value="";
			}
			if(document.frmcom.msg4.value == "치"){
				document.frmcom.msg4.value="";
			}
			return true;
		} else {
			jsChklogin('<%=IsUserLoginOK%>');
		}

		return false;
	}
//-->
</script>
<div class="playGr20140526">
	<div class="lunchKiki">
		<div class="section section1">
			<div class="group">
				<div class="part">
					<div class="area">
						<h3><img src="http://webimage.10x10.co.kr/play/ground/20140526/tit_lunch_kiki.png" alt="Aloha! Kunch - kiki" /></h3>
						<p style="margin-top:63px;"><img src="http://webimage.10x10.co.kr/play/ground/20140526/txt_lunch_kiki_invite.png" alt="일상 속 하와이로 당신을 초대합니다. 런치키키는 LUNCH 점심과 하와이어인 kiki 쏘다 뜻을 가진 합성어로 점심을 쏘다라는 뜻을 가지고 있어요! " /></p>
						<p style="margin-top:150px;"><img src="http://webimage.10x10.co.kr/play/ground/20140526/txt_lunch_kiki_01.png" alt="푸른 파도가 넘실거리고 아름다운 하늘과 청명한 날씨를 자랑하는 지상낙원 하와이. 그리고 우리가 매일 기다리는 점심시간! " /></p>
						<p style="margin-top:30px;"><img src="http://webimage.10x10.co.kr/play/ground/20140526/txt_lunch_kiki_02.png" alt="텐바이텐 PLAY는 런치박스라는 아이템을 준비하면서 하루의 중간 지점, 점심시간에 대해 다시 한 번 생각해보게 되었어요. 누군가에게는 달콤한 휴식시간 또는 맛있는 즐거움을 주는 런치타임을 더욱 행복하게 해줄 방법이 없을까. 바쁜 일상 속 마치 따뜻한 나라로 휴가를 온 느낌처럼 아름다운 멜로디를 가진 멋진 하와이 음악과 함께 하는 여유롭고 마음 편안한 런치타임을 선물하고 싶었습니다." /></p>
						<p style="margin-top:25px;"><img src="http://webimage.10x10.co.kr/play/ground/20140526/txt_lunch_kiki_03.png" alt="텐바이텐과 본격 하와이 음악 밴드 마푸키키가 함께 만든 런치송 일상 속 하와이를 즐길 수 있는 런치콘서트에 여러분을 초대합니다." /></p>
					</div>
				</div>
			</div>
		</div>

		<div class="section section2">
			<div id="lunchSong" class="group">
				<div class="part">
					<div class="plamtreeLeft"><img src="http://webimage.10x10.co.kr/play/ground/20140526/bg_palmtree_left.png" alt="" /></div>
					<div class="plamtreeRight"><img src="http://webimage.10x10.co.kr/play/ground/20140526/bg_palmtree_right.png" alt="" /></div>
					<h4><img src="http://webimage.10x10.co.kr/play/ground/20140526/tit_lunch_song.png" alt="LUNCH SONG : TENBYTEN과 마푸키키" /></h4>
					<p><img src="http://webimage.10x10.co.kr/play/ground/20140526/txt_lunch_song.png" alt="텐바이텐과 마푸키키가 함께 만든 런치송을 감상하세요! 마푸키키의 첫번째 앨범에 실리게 될 [훌라 한 번 출래요]라는 곡을 텐바이텐과 함께 하와이안 런치 타임을 즐길 수 있는 곡으로 바꿔 보았어요!" /></p>
					<div class="bnr"><a href="http://www.better-taste.com/" target="_blank" title="새창"><img src="http://webimage.10x10.co.kr/play/ground/20140526/img_bnr_bts.gif" alt="Production BTS - Better Taste Stuido www.better-taste.com" /></a></div>
					<div class="movie">
						<iframe src="//player.vimeo.com/video/96153443" width="1000" height="564" frameborder="0" title="LUNCH SONG" webkitallowfullscreen="" mozallowfullscreen="" allowfullscreen=""></iframe>
					</div>
					<p class="sponsor">런치송 뮤직비디오 장소협찬 : <strong>홍대 봉주르 하와이</strong></p>
					<div class="btnGo btnMove"><a href="#lunchConcert"><img src="http://webimage.10x10.co.kr/play/ground/20140526/btn_go_event.gif" alt="이벤트 참여하기" /></a></div>
				</div>
			</div>
		</div>

		<div class="section section3">
			<div class="group">
				<h4><img src="http://webimage.10x10.co.kr/play/ground/20140526/tit_mapukiki.png" alt="마푸키키" /></h4>
				<div class="part">
					<p><img src="http://webimage.10x10.co.kr/play/ground/20140526/txt_mapukiki_01.gif" alt="알로하! 향긋한 꽃 향기라는 뜻의 마푸(Mapu)와 발사하다, 쏘다 라는 뜻의 키키(kiki)의 하와이어 합성어로 낭만적인 남국의 향기를 쏘는 밴드라는 의미의 향기를 발산하는 트리오입니다." /></p>
					<p><img src="http://webimage.10x10.co.kr/play/ground/20140526/txt_mapukiki_02.gif" alt="하와이의 행복한 향기를 여러분에게 마구 쏘아드리고 싶은 마음을 담아 만들게 되었어요! 하와이와 같은 남국의 휴양지에서 들을 수 있는 여유로운 노래를 위주로 연주하고 부르는 3인조 밴드 입니다!" /></p>
					<p><img src="http://webimage.10x10.co.kr/play/ground/20140526/txt_mapukiki_03.gif" alt="바쁜 일상생활에 지친 이들에게 남국의 여유가 넘치는 휴양지의 휴식을 안겨주고자 만든 밴드지만 정작 활동하면서는 멤버 본인들이 심신의 엄청난 힐링을 경험 하고 있어요. : )" /></p>
					<p style="padding-bottom:29px;"><img src="http://webimage.10x10.co.kr/play/ground/20140526/txt_mapukiki_04.gif" alt="왼쪽부터 순서대로 이동걸, 김영진, 조태준" /></p>
					<div class="photo"><img src="http://webimage.10x10.co.kr/play/ground/20140526/img_photo_mapukiki.jpg" alt="마푸키키 포스터" /></div>
					<ul>
						<li><img src="http://webimage.10x10.co.kr/play/ground/20140526/txt_mapukiki_mem_01.gif" alt="이동걸 : 인디애나에서의 외로운 유학시절 마음을 달래려 시작했던 우쿨렐레때문에 무작정 하와이로 박사과정 유학을 떠난 낭만파 유학생. 그는 우연한 기회로 만난 조태준으로 인해 박사과정을 중단하고 본격 예술인의 길로 접어 들게 된다. 하와이의 모든 것을 사랑하는 하와이 전령사." /></li>
						<li><img src="http://webimage.10x10.co.kr/play/ground/20140526/txt_mapukiki_mem_02.gif" alt="조태준 : 하찌와 TJ, 우쿨렐레 피크닉의 멤버로 활약하며 우쿨렐레 아이콘으로 떠오른 그는 베스트셀러 우쿨렐레 교재 [쉐리봉 우쿨렐레]의 저자이기도 하다. 다양한 장르의 음악 작업을 하고 있지만 사랑에 빠진 우쿨렐레와의 달콤한 시간을 누구보다도 사랑하는 순수한 남자" /></li>
						<li><img src="http://webimage.10x10.co.kr/play/ground/20140526/txt_mapukiki_mem_03.gif" alt="김영진 : 작곡가 및 프로듀서로 활동하던 김영진은 반짝이는 음악적 센스를 뽐내며 찰랑이는 우쿨렐레 사운드에 중심을 잡는 베이스를 얹어주는 마푸키키의 막내동이다. 베이스를 연주하며 싱글벙글 웃는 그의 플레이는 보는  사람들의 마음까지 한없이 행복하게 한다." /></li>
					</ul>
					<div class="bg"><img src="http://webimage.10x10.co.kr/play/ground/20140526/bg_cloud.png" alt="" /></div>
				</div>
				<div class="btnGo">
					<a href="http://www.facebook.com/mapukiki" target="_blank" title="새창"><img src="http://webimage.10x10.co.kr/play/ground/20140526/btn_go_facebook.png" alt="Facebook" /></a>
					<a href="https://twitter.com/mapukiki" target="_blank" title="새창"><img src="http://webimage.10x10.co.kr/play/ground/20140526/btn_go_twitter.png" alt="Twitter" /></a>
				</div>
			</div>
		</div>

		<div class="section section4">
			<div class="group">
				<h4><img src="http://webimage.10x10.co.kr/play/ground/20140526/tit_lunch_concert.png" alt="텐바이텐과 마푸키키가 함께하는 ALOHA! LUNCH - KIKI" /></h4>
				<p><img src="http://webimage.10x10.co.kr/play/ground/20140526/txt_lunch_concert.png" alt="텐바이텐과 마푸키키가 준비한 일상 속 하와이로의 여행 하와이의 청명한 하늘과 짙푸른 바다를 연상시키는 마푸키키 앨범발매 쇼케이스 런치 콘서트에 여러분을 초대합니다! 장소 : 서울의 좋고 예쁜 곳 어딘가, 시간 : 2014년 6월 22일 점심, 스페셜 기프트 : 알로하 런치박스" /></p>
			</div>
		</div>

		<!-- 런치송 가사 바꾸기 폼 -->
		<div class="section section5">
			<div id="lunchConcert" class="group">
				<h4><img src="http://webimage.10x10.co.kr/play/ground/20140526/tit_lunch_song_change.png" alt="텐바이텐X마푸키키 런치송을 듣고 네모 안의 가사를 바꿔 주세요!" /></h4>
				<div class="btnGo btnMove"><a href="#lunchSong"><img src="http://webimage.10x10.co.kr/play/ground/20140526/btn_go_lunch_song.png" alt="런치송 감상하기" /></a></div>
				<form name="frmcom" method="post" onSubmit="return jsSubmitComment(this);" style="margin:0px;">
				<input type="hidden" name="eventid" value="<%=eCode%>">
				<input type="hidden" name="bidx" value="<%=bidx%>">
				<input type="hidden" name="iCC" value="<%=iCCurrpage%>">
				<input type="hidden" name="iCTot" value="">
				<input type="hidden" name="mode" value="add">
				<input type="hidden" name="userid" value="<%=GetLoginUserID%>">
				<input type="hidden" name="txtcomm">
					<fieldset>
					<legend>런치송 가사 바꾸기</legend>
						<div class="part">
							<strong>둘이- 우리 둘이</strong>
							<span>
								<input type="text" title="첫번째 글자 입력" value="런" name="msg1" maxlength="1" onClick="jsChklogin11('<%=IsUserLoginOK%>');" onKeyUp="jsChklogin11('<%=IsUserLoginOK%>');"/>
								<input type="text" title="두번째 글자 입력" value="치" name="msg2" maxlength="1" onClick="jsChklogin11('<%=IsUserLoginOK%>');" onKeyUp="jsChklogin11('<%=IsUserLoginOK%>');"/>
								<input type="text" title="세번째 글자 입력" value="런" name="msg3" maxlength="1" onClick="jsChklogin11('<%=IsUserLoginOK%>');" onKeyUp="jsChklogin11('<%=IsUserLoginOK%>');"/>
								<input type="text" title="네번째 글자 입력" value="치" name="msg4" maxlength="1" onClick="jsChklogin11('<%=IsUserLoginOK%>');" onKeyUp="jsChklogin11('<%=IsUserLoginOK%>');"/>
							</span>
							<strong>with me~</strong>
							<div class="btnSubmit"><input type="image" src="http://webimage.10x10.co.kr/play/ground/20140526/btn_enter_event.png" alt="이벤트 참여" /></div>
						</div>
						<p class="gift">정성스럽게 댓글을 남겨주신 50분을 추첨해 <strong>런치 콘서트(1인 2매) 입장권 + 알로하 기프트박스</strong>를 선물로 드립니다. <em>이벤트 기간 : 2014.05.26 - 06.10 당첨자 발표 : 2014.06.11</em></p>
					</fieldset>
				</form>
				<form name="frmdelcom" method="post" action="/event/lib/comment_process.asp" style="margin:0px;">
				<input type="hidden" name="eventid" value="<%=eCode%>">
				<input type="hidden" name="bidx" value="<%=bidx%>">
				<input type="hidden" name="Cidx" value="">
				<input type="hidden" name="mode" value="del">
				<input type="hidden" name="userid" value="<%=GetLoginUserID%>">
				</form>
			</div>
		</div>
		<!-- //런치송 가사 바꾸기 폼 -->
		<% IF isArray(arrCList) THEN %>
		<!-- 런치송 가사 List -->
		<div class="section section6">
			<div class="group">
				<p class="formMobile"><span><img src="http://webimage.10x10.co.kr/play/ground/20140526/ico_mobile.png" alt="모바일" /> 아이콘은 모바일에서 작성한 코멘트입니다.</span></p>
				<div class="part">
					<% For intCLoop = 0 To UBound(arrCList,2) %>
					<div class="area bg<%=chkiif(intCLoop>=4,(intCLoop+1)-4,intCLoop+1)%>">
						<span class="num">no.<%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1)) %></span>
						<div class="id"><span><%=printUserId(arrCList(2,intCLoop),2,"*")%></span> 님의 런치송</div>
						<div class="song">둘이- 우리 둘이 <strong><%=nl2br(arrCList(1,intCLoop))%></strong> with me</div>
						<span class="date"><% If arrCList(8,intCLoop) = "M"  then%><img src="http://webimage.10x10.co.kr/play/ground/20140526/ico_mobile.png" alt="모바일에서 작성" /><% End If %> <%=formatdate(arrCList(4,intCLoop),"0000.00.00")%></span>
						<% if ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %>
						<button type="button" class="btnDel" onclick="jsDelComment('<% = arrCList(0,intCLoop) %>')"><span>삭제</span></button>
						<% End If %>
					</div>
					<% next %>
				</div>
				<div class="pageWrapV15">
					<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
				</div>
			</div>
		</div>
		<% End If %>
		<!-- //런치송 가사 List -->
	</div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->