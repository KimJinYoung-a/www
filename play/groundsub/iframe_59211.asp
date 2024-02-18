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
' PLAY #17 SHOES
' 2015-01-30 이종화 작성
'########################################################
Dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  21457
Else
	eCode   =  59211
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
.playGr20150202 .paging a {background-color:transparent !important;}
.shoesCont {width:1140px; margin:0 auto;}
.intro {height:820px; text-align:center; background:url(http://webimage.10x10.co.kr/play/ground/20150202/bg_intro.gif) repeat-x left top;}
.intro .shoesCont {position:relative;}
.intro h2 {padding-top:153px;}
.intro p {position:absolute; left:50%; top:380px; margin-left:-358px; opacity:0.8;}
.purpose {height:90px; background:url(http://webimage.10x10.co.kr/play/ground/20150202/bg_intro02.gif) repeat-x left top;}
.purpose p {padding-top:36px;}
.section01 {height:940px; background:url(http://webimage.10x10.co.kr/play/ground/20150202/bg_shoes.jpg) no-repeat center top;}
.section01 .shoesCont {position:relative; height:940px;}
.section01 .shoesCont p {position:absolute; right:-20px; bottom:125px; z-index:30; opacity:0;}
.section02 {position:relative; overflow:hidden; min-width:1540px; height:988px; background:#f7f4f0;}
.section02 .goApply {position:absolute; right:0; top:0;}
.section02 .shoesCont {float:left; margin:0 0 0 80px; padding-top:200px; width:570px; overflow:hidden;}
.section02 .shoesCont h3 {padding-bottom:62px;}
.section02 .shoesCont .txt {font-family:'batang'; font-size:15px; color:#323232; letter-spacing:-1px; width:100%; height:400px; display:none;}
.section02 .shoesCont .txt div {width:100%; height:27px;}
.section02 .shoesCont .txt p {height:27px;}
.photo {text-align:center;}
.photo img {width:100%;}
.section03 {height:1294px; text-align:center; background:url(http://webimage.10x10.co.kr/play/ground/20150202/bg_pattern_square.gif) repeat left top;}
.section03 h3 {padding:122px 0 25px;}
.section03 .collabo {padding-top:117px;}

.section04 {padding-bottom:130px; background:#f4f4f4;}
.lookBook {position:relative; overflow:hidden; width:1440px; margin:0 auto;}
.lookBook h3 {padding:108px 0 58px; text-align:center;}
.lookBook .slideWrap {position:relative; width:1040px;}
.lookBook .slideWrap .slide {width:100%;}
.lookBook .slidesjs-pagination {position:absolute; left:1080px; top:30px; z-index:30;}
.lookBook .slidesjs-pagination li {width:17px; height:17px; padding-bottom:8px;}
.lookBook .slidesjs-pagination li a {display:block; width:17px; height:17px; background:url(http://webimage.10x10.co.kr/play/ground/20150202/blt_pagination.gif) left top no-repeat; text-indent:-9999px;}
.lookBook .slidesjs-pagination li a.active {background-position:left -17px;}
.lookBook .brandInfo {position:absolute; right:0; bottom:5%;}
.lookBook .brandInfo a {display:inline-block; margin:48px 0 0 15px;}

.shoesCmtWrite {height:1110px; background:url(http://webimage.10x10.co.kr/play/ground/20150202/bg_comment_write.jpg) left top no-repeat;}
.shoesCmtWrite h3 {text-align:center; padding:157px 0 28px;}
.dearFather {overflow:hidden; width:954px; height:606px; padding:82px 64px 0 70px; margin:0 auto; background:url(http://webimage.10x10.co.kr/play/ground/20150202/bg_paper.png) left top no-repeat;}
.dearFather .ftLt {width:480px;}
.dearFather .ftLt h4 {padding-bottom:118px;}
.dearFather .ftRt {width:380px;}
.dearFather .ftRt label {display:inline-block; vertical-align:top; padding-right:18px;}
.dearFather .ftRt p input {width:180px; height:42px; padding-right:3px; vertical-align:top; text-align:center; border:1px solid #c5c5c5; font-size:18px; color:#555; font-family:'batang';}
.dearFather .ftRt .wMsgWrap {height:240px; padding:12px 30px; margin:21px 0; background:#eee;}
.dearFather .ftRt .wMsg {background:url(http://webimage.10x10.co.kr/play/ground/20150202/bg_line.gif) left top repeat;}
.dearFather .ftRt .wMsg textarea {overflow:auto; width:100%; height:214px; border:0; padding:0; margin-top:6px; color:#222; font-size:16px; line-height:44px; font-family:'batang'; background:none; vertical-align:middle;}
.dearFather .ftRt .from {text-align:right; padding-bottom:32px;}
.dearFather .ftRt .from span {display:inline-block; padding-top:16px;}

.shoesCmtList {width:1150px; margin:0 auto; padding:98px 0 48px;}
.shoesCmtList ul {overflow:hidden; width:1185px;}
.shoesCmtList li {position:relative; float:left; width:310px; height:333px; padding:0 63px 67px 22px;}
.shoesCmtList li.c01 {background:url(http://webimage.10x10.co.kr/play/ground/20150202/bg_cmt01.gif) left top no-repeat;}
.shoesCmtList li.c02 {background:url(http://webimage.10x10.co.kr/play/ground/20150202/bg_cmt02.gif) left top no-repeat;}
.shoesCmtList li .cInfo {overflow:hidden; padding:22px 0 45px 0;}
.shoesCmtList li .cInfo span {float:left; display:inline-block; color:#806545; font-size:13px; line-height:14px; vertical-align:middle;}
.shoesCmtList li .cInfo span.writer {padding-left:15px; margin-left:16px; background:url(http://webimage.10x10.co.kr/play/ground/20150202/bg_bar.gif) left top no-repeat;}
.shoesCmtList li .cInfo span.writer img {vertical-align:middle; padding-right:8px; margin-top:-2px;}
.shoesCmtList li .message .txt {overflow:auto; width:268px; height:102px; padding:18px 20px; margin:16px 0; color:#333; font-size:13px; line-height:20px; border:1px solid #b5a99b; background:#fff;}
.shoesCmtList li .message .dear em {width:56px; background:url(http://webimage.10x10.co.kr/play/ground/20150202/txt_cmt_dear.gif) left top no-repeat;}
.shoesCmtList li .message .from {text-align:right;}
.shoesCmtList li .message .from em {width:58px; background:url(http://webimage.10x10.co.kr/play/ground/20150202/txt_cmt_from.gif) left top no-repeat;}
.shoesCmtList li.c02 .message em {background-position:left -19px;}
.shoesCmtList li .message span {display:block; color:#111; font-size:16px; line-height:24px; font-weight:bold; font-family:'batang';}
.shoesCmtList li .message em {display:inline-block; height:19px; margin-right:10px; color:transparent;}
.shoesCmtList li .del {position:absolute; left:335px; top:6px;}
.goEirene {width:250px; height:90px; background:url(http://webimage.10x10.co.kr/play/ground/20150202/btn_brand.gif) left top no-repeat; text-indent:-9999px;}
.goEirene:hover {background-position:left -90px;}

@media all and (min-width:1920px) {
	.section01 {background-size:100% 100% !important;}
	.shoesCmtWrite {background-size:100% 100%;}
}

@media all and (min-width:1910px) {
	.lookBook {width:1780px;}
	.lookBook .slideWrap {width:1380px;}
	.lookBook .slidesjs-pagination {left:1410px;}
}

@media all and (max-width:1140px) {
	.shoesCmtWrite {background-size:100% 100%;}
}

</style>
<script type="text/javascript" src="/lib/js/jquery.slides.min.js"></script>
<script type="text/javascript" src="/lib/js/textualizer.min.js"></script>
<script type="text/javascript">
$(function(){
	$('.shoesCmtList li:nth-child(odd)').addClass('c01');
	$('.shoesCmtList li:nth-child(even)').addClass('c02');

	$(".slide").slidesjs({
		width:"1380",
		height:"942",
		pagination:{effect:"fade"},
		navigation:false,
		play:{interval:3500, effect:"fade", auto:true},
		effect:{fade: {speed:1500, crossfade:true}
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

	$(".goCmt").click(function(event){
		event.preventDefault();
		window.parent.$('html,body').animate({scrollTop:$(this.hash).offset().top}, 800);
	});
	var txt01 = $('.anim01');
	var txt02 = $('.anim02');
	var txt03 = $('.anim03');
	var txt04 = $('.anim04');
	var txt05 = $('.anim05');
	var txt06 = $('.anim06');
	var txt07 = $('.anim07');
	var txt08 = $('.anim08');
	var txt09 = $('.anim09');
	var txt10 = $('.anim10');
	var txt11 = $('.anim11');
	var options = {
		duration: 10,
		rearrangeDuration: 10,
		effect:'fadeIn', // fadeIn,slideLeft,slideTop,random
		centered:false,
		loop: false
	}

	$('.intro p').animate({"margin-left":"-378px","opacity":"1"}, 2000);
	var conChk = 0;
	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 1100){
			$(".section01 .shoesCont p").delay(300).animate({"bottom":"135px","opacity":"1"}, 1000);
		}
		if (scrollTop > 1850){
			if (conChk==0){ 
				$('.section02 .shoesCont .txt').css('display','block');
				playtxtAnim()
			}
		}
		
	});

	function playtxtAnim() {
		conChk = 1;
		txt01.textualizer(options);
		txt02.textualizer(options);
		txt03.textualizer(options);
		txt04.textualizer(options);
		txt05.textualizer(options);
		txt06.textualizer(options);
		txt07.textualizer(options);
		txt08.textualizer(options);
		txt09.textualizer(options);
		txt10.textualizer(options);
		txt11.textualizer(options);
		txt01.textualizer('start');
		txt02.textualizer('start');
		txt03.textualizer('start');
		txt04.textualizer('start');
		txt05.textualizer('start');
		txt06.textualizer('start');
		txt07.textualizer('start');
		txt08.textualizer('start');
		txt09.textualizer('start');
		txt10.textualizer('start');
		txt11.textualizer('start');
		return false;
	}
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

	   if(!frm.qtext1.value || frm.qtext1.value == "10자 이내" ){
	    alert("Dear 입력해주세요");
		document.frmcom.qtext1.value="";
	    frm.qtext1.focus();
	    return false;
	   }

	   if(!frm.qtext2.value || frm.qtext2.value == "최대 120자 작성 가능"){
	    alert("내용을 입력해주세요");
		document.frmcom.qtext2.value="";
	    frm.qtext2.focus();
	    return false;
	   }

		if (GetByteLength(frm.qtext2.value) > 241){
			alert("제한길이를 초과하였습니다. 120자 까지 작성 가능합니다.");
			frm.qtext2.focus();
			return;
		}

	   if(!frm.qtext3.value || frm.qtext3.value == "10자 이내" ){
	    alert("From 입력해주세요");
		document.frmcom.qtext3.value="";
	    frm.qtext3.focus();
	    return false;
	   }

	   frm.action = "doEventSubscript59211.asp";
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
			if(document.frmcom.qtext1.value =="10자 이내"){
				document.frmcom.qtext1.value="";
			}
			return true;
		} else {
			jsChklogin('<%=IsUserLoginOK%>');
		}

		return false;
	}

	function jsChklogin22(blnLogin)
	{
		if (blnLogin == "True"){
			if(document.frmcom.qtext2.value =="최대 120자 작성 가능"){
				document.frmcom.qtext2.value="";
			}
			return true;
		} else {
			jsChklogin('<%=IsUserLoginOK%>');
		}

		return false;
	}

	function jsChklogin33(blnLogin)
	{
		if (blnLogin == "True"){
			if(document.frmcom.qtext3.value =="10자 이내"){
				document.frmcom.qtext3.value="";
			}
			return true;
		} else {
			jsChklogin('<%=IsUserLoginOK%>');
		}

		return false;
	}

//-->
</script>
<div class="playGr20150202">
	<!-- intro -->
	<div class="intro">
		<div class="shoesCont">
			<h2><img src="http://webimage.10x10.co.kr/play/ground/20150202/tit_shoes.png" alt="" /></h2>
			<p><img src="http://webimage.10x10.co.kr/play/ground/20150202/img_shoes.png" alt="" /></p>
		</div>
	</div>
	<div class="purpose">
		<div class="shoesCont">
			<p><img src="http://webimage.10x10.co.kr/play/ground/20150202/txt_project_purpose.png" alt="" /></p>
		</div>
	</div>
	<!--// intro -->

	<!-- section01 -->
	<div class="section01">
		<div class="shoesCont">
			<p><img src="http://webimage.10x10.co.kr/play/ground/20150202/txt_good_shoes.png" alt="" /></p>
		</div>
	</div>
	<!--// section01 -->

	<!-- section02 -->
	<div class="section02">
		<div class="shoesCont">
			<h3><img src="http://webimage.10x10.co.kr/play/ground/20150202/tit_make_shoes.png" alt="" /></h3>
			<div class="txt">
				<div class="anim01"><p>‘아버지의 구두를 주의 깊게 살펴본 적이 있나요? </p></div>
				<div class="anim02"><p>’신입사원 시절, 정신 없는 하루를 보내고 터벅터벅 집에 돌아오는 길에</p></div>
				<div class="anim03"><p>불현듯 떠올랐던 것은 ‘우리 아버지’ 였습니다.</p></div>

				<div class="anim04 tMar30"><p>그 자리에 가봐야 알 수 있는 길이 있듯이, 사회 속에서 이리저리 치이다 보니</p></div>
				<div class="anim05"><p>“나의 아버지도 많이 힘드셨겠구나.”라는 생각이 들어 가슴이 아팠습니다.</p></div>

				<div class="anim06 tMar30"><p>텐바이텐 플레이는</p></div>
				<div class="anim07"><p>사회로 한 발짝 나아갈 준비를 하는 예비 직장인과</p></div>
				<div class="anim08"><p>지금을 열심히 사는 직장인을 응원하는 마음을</p></div>
				<div class="anim09"><p>그리고 무엇보다, 당신의 아버지에게 감사하는 마음을 담아 이 프로젝트를 준비했습니다. </p></div>

				<div class="anim10 tMar30"><p>지금 가고 있는 길이 조금은 멀고, 험하고 혹은 더딘 걸음일지라도,</p></div>
				<div class="anim11"><p>텐바이텐과 에이레네는 당신이 향하는 길을 응원합니다.</p></div>
			</div>
		</div>
		<p class="goApply">
			<img src="http://webimage.10x10.co.kr/play/ground/20150202/btn_go_apply.jpg" alt="" usemap="#Map" />
			<map name="Map" id="Map">
				<area shape="rect" coords="3,371,233,436" href="#shoesCmtWrite" class="goCmt" />
			</map>
		</p>
	</div>
	<p class="photo"><img src="http://webimage.10x10.co.kr/play/ground/20150202/img_making_shoes.jpg" alt="" /></p>
	<!--// section02 -->

	<!-- section03 -->
	<div class="section03">
		<div class="shoesCont">
			<h3><img src="http://webimage.10x10.co.kr/play/ground/20150202/tit_making.png" alt="" /></h3>
			<div><iframe src="//player.vimeo.com/video/117561207" width="1140" height="640" frameborder="0" webkitallowfullscreen="" mozallowfullscreen="" allowfullscreen=""></iframe></div>
			<div class="collabo">
				<p><img src="http://webimage.10x10.co.kr/play/ground/20150202/txt_collaboration.png" alt="" /></p>
			</div>
		</div>
	</div>
	<!--// section03 -->

	<!-- LOOK BOOK -->
	<div class="section04">
		<div class="lookBook">
			<h3><img src="http://webimage.10x10.co.kr/play/ground/20150202/tit_lookbook.png" alt="LOOK BOOK" /></h3>
			<div class="slideWrap">
				<div class="slide">
					<img src="http://webimage.10x10.co.kr/play/ground/20150202/img_slide01.jpg" alt="" />
					<img src="http://webimage.10x10.co.kr/play/ground/20150202/img_slide02.jpg" alt="" />
					<img src="http://webimage.10x10.co.kr/play/ground/20150202/img_slide03.jpg" alt="" />
					<img src="http://webimage.10x10.co.kr/play/ground/20150202/img_slide04.jpg" alt="" />
					<img src="http://webimage.10x10.co.kr/play/ground/20150202/img_slide05.jpg" alt="" />
					<img src="http://webimage.10x10.co.kr/play/ground/20150202/img_slide06.jpg" alt="" />
				</div>
			</div>
			<div class="brandInfo">
				<p><img src="http://webimage.10x10.co.kr/play/ground/20150202/txt_brand_info.gif" alt="보이지 않는 부분까지 까다롭게 제작합니다." /></p>
				<a href="/street/street_brand_sub06.asp?makerid=eirene" target="_top" class="goEirene">브랜드 사이트 바로가기</a>
			</div>
		</div>
	</div>
	<!--// LOOK BOOK -->

	<form name="frmcom" method="post" onSubmit="return jsSubmitComment(this);" style="margin:0px;">
	<input type="hidden" name="eventid" value="<%=eCode%>"/>
	<input type="hidden" name="bidx" value="<%=bidx%>"/>
	<input type="hidden" name="iCC" value="<%=iCCurrpage%>"/>
	<input type="hidden" name="iCTot" value=""/>
	<input type="hidden" name="mode" value="add"/>
	<input type="hidden" name="userid" value="<%=GetLoginUserID%>"/>
	<!-- 코멘트 작성-->
	<div class="shoesCmtWrite" id="shoesCmtWrite">
		<h3><img src="http://webimage.10x10.co.kr/play/ground/20150202/tit_comment_event.png" alt="COMMENT EVENT" /></h3>
		<div class="dearFather">
			<div class="ftLt">
				<h4><img src="http://webimage.10x10.co.kr/play/ground/20150202/tit_message.gif" alt="사랑하는 당신의 아버지에게 메세지를 남겨주세요" /></h4>
				<p><img src="http://webimage.10x10.co.kr/play/ground/20150202/txt_event_info.gif" alt="수제화는 추후 당첨이 된 분에 한해, 모델과 사이즈 등 자세한 정보를 받아 제작될 예정이며 제작기간은 10일 정도 소요됩니다. 이벤트 응모 시 자동으로 정보제공 동의로 간주하며, 당첨 후 사진이나 인터뷰 요청등의 당첨 활용 목적 외에 다른 곳에서는 사용하지 않습니다." /></p>
			</div>
			<div class="ftRt">
				<p class="dear">
					<label for="msgDear"><img src="http://webimage.10x10.co.kr/play/ground/20150202/txt_dear.gif" alt="Dear" /></label>
					<input type="text" id="msgDear" value="10자 이내" name="qtext1" onClick="jsChklogin11('<%=IsUserLoginOK%>');" maxlength="10" />
				</p>
				<div class="wMsgWrap">
					<div class="wMsg"><textarea cols="20" rows="10" name="qtext2" onClick="jsChklogin22('<%=IsUserLoginOK%>');">최대 120자 작성 가능</textarea></div>
				</div>
				<p class="from">
					<label for="msgFrom"><img src="http://webimage.10x10.co.kr/play/ground/20150202/txt_from.gif" alt="From" /></label>
					<input type="text" id="msgFrom" value="10자 이내" name="qtext3" onClick="jsChklogin33('<%=IsUserLoginOK%>');" maxlength="10" />
					<span><img src="http://webimage.10x10.co.kr/play/ground/20150202/txt_from_ex.gif" alt="ex) 자랑스러운 큰 아들, 귀염둥이 막내 등" /></span>
				</p>
				<input type="image" src="http://webimage.10x10.co.kr/play/ground/20150202/btn_submit.gif" alt="등록하기" />
			</div>
		</div>
	</div>
	<!--// 코멘트 작성 -->
	</form>
	<form name="frmdelcom" method="post" action="doEventSubscript59211.asp" style="margin:0px;">
	<input type="hidden" name="eventid" value="<%=eCode%>">
	<input type="hidden" name="bidx" value="<%=bidx%>">
	<input type="hidden" name="Cidx" value="">
	<input type="hidden" name="mode" value="del">
	<input type="hidden" name="userid" value="<%=GetLoginUserID%>">
	</form>

	<% IF isArray(arrCList) THEN %>
	<!-- 코멘트 리스트-->
	<div class="shoesCmtList">
		<!-- for dev msg : 리스트는 6개씩 노출됩니다 -->
		<ul>
			<% For intCLoop = 0 To UBound(arrCList,2) %>
				<% 
						Dim opt1 , opt2 , opt3
						If arrCList(1,intCLoop) <> "" then
							opt1 = SplitValue(arrCList(1,intCLoop),"//",0)
							opt2 = SplitValue(arrCList(1,intCLoop),"//",1)
							opt3 = SplitValue(arrCList(1,intCLoop),"//",2)
						End If 
				%>
			<li>
				<div class="cInfo">
					<span class="num">no.<%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1)) %></span>
					<span class="writer"><% If arrCList(8,intCLoop) = "M"  then%><img src="http://webimage.10x10.co.kr/play/ground/20150202/ico_mob.gif" alt="모바일에서 작성" /><% End If %><%=printUserId(arrCList(2,intCLoop),2,"*")%></span>
				</div>
				<div class="message">
					<span class="dear"><em>Dear</em><%=opt1%></span>
					<p class="txt"><%=opt2%></p>
					<span class="from"><em>From</em><%=opt3%></span>
				</div>
				<% if ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %>
				<p class="del"><a href="javascript:jsDelComment('<% = arrCList(0,intCLoop) %>');"><img src="http://webimage.10x10.co.kr/play/ground/20150202/btn_delete.gif" alt="삭제" /></a></p>
				<% end if %>
			</li>
			<% Next %>
		</ul>
		<div class="pageWrapV15">
			<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
		</div>
	</div>
	<!--// 코멘트 리스트-- -->
	<% End If %>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->