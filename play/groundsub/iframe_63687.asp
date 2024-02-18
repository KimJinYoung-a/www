<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<%
'########################################################
' PLAY #21 T-SHIRT_좋은 것, 좋은 것. 좋아하는 것!
' 2015-06-12 원승현 작성
'########################################################
Dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  63789
Else
	eCode   =  63687
End If

dim com_egCode, bidx
	Dim cEComment
	Dim iCTotCnt, arrCList,intCLoop, iSelTotCnt
	Dim iCPageSize, iCCurrpage
	Dim iCStartPage, iCEndPage, iCTotalPage, iCx,iCPerCnt
	Dim timeTern, totComCnt, iColorVal, eCC

	'파라미터값 받기 & 기본 변수 값 세팅
	iCCurrpage = requestCheckVar(Request("iCC"),10)	'현재 페이지 번호
	com_egCode = requestCheckVar(Request("eGC"),1)	
	eCC = requestCheckVar(Request("eCC"), 1) 

	IF iCCurrpage = "" THEN iCCurrpage = 1
	IF iCTotCnt = "" THEN iCTotCnt = -1

	'// 그룹번호 랜덤으로 지정

	iCPageSize = 12		'한 페이지의 보여지는 열의 수
	iCPerCnt = 10		'보여지는 페이지 간격

	iColorVal = 1

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
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/section.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<style type="text/css">
.groundHeadWrap {width:100%; background:#f9eacf;}
.groundCont {padding-bottom:0; background:#fafafa;}
.groundCont .grArea {width:100%;}
.groundCont .tagView {width:1100px; padding:0 20px 60px;}

img {vertical-align:top;}
.playGr20150615 {text-align:center;}
.favorCont {position:relative; width:1140px; margin:0 auto;}

.intro {height:1870px; padding-top:130px; background:url(http://webimage.10x10.co.kr/play/ground/20150615/bg_stripe.gif) 0 0 repeat;}
.intro .favorCont {width:1196px; padding-top:1126px; background:url(http://webimage.10x10.co.kr/play/ground/20150615/bg_shirts.png) 50% 0 no-repeat;}
.intro .copy {position:absolute; left:50%; top:226px; width:518px; margin-left:-200px;}
.intro .copy .with {position:relative; height:70px;overflow:hidden;}
.intro .copy .with span {position:absolute; left:50%; top:70px; width:272px; margin-left:-136px;}
.intro .copy .tit {position:relative;}
.intro .copy .tit p {position:absolute; margin-bottom:28px; width:100%; opacity:0;}
.intro .copy .tit p.t01 {left:-20px; top:0px;}
.intro .copy .tit p.t02 {right:-20px; top:153px;}
.intro .copy .tit p.t03 {top:330px;}
.intro .goApply {position:relative; left:51px; width:241px; margin:105px auto 0;}
.intro .goApply span {display:inline-block; position:absolute; left:50%; top:37px; width:20px; height:30px; margin-left:-10px; background:url(http://webimage.10x10.co.kr/play/ground/20150615/blt_arrow.gif) 0 0 no-repeat;}
.intro .chalk {display:inline-block; position:absolute; left:50%; top:1357px; width:246px; height:286px; margin-left:285px; background:url(http://webimage.10x10.co.kr/play/ground/20150615/bg_chalk.png) 0 0 no-repeat;}

.slideWrap {padding:150px 0 128px; background:#fff;}
.slideWrap .slide {position:relative; width:1140px; margin:0 auto; padding-bottom:60px;}
.slideWrap .slide .slidesjs-pagination {position:absolute; left:50%; bottom:0; overflow:hidden; width:188px; margin-left:-92px;}
.slideWrap .slide .slidesjs-pagination li {float:left; padding:0 10px;}
.slideWrap .slide .slidesjs-pagination li a {display:inline-block; width:11px; height:11px; text-indent:-9999px; background:url(http://webimage.10x10.co.kr/play/ground/20150615/btn_pagination.gif) 0 0 no-repeat;}
.slideWrap .slide .slidesjs-pagination li a.active {background-position:right 0;}

.silkScreen {height:1039px; background:url(http://webimage.10x10.co.kr/play/ground/20150615/bg_silk_screen.gif) 50% 0 no-repeat #f7f7f7;}
.silkScreen div {position:relative; width:1140px; margin:0 auto; padding-top:130px;}
.silkScreen div span {display:inline-block; position:absolute; left:581px; top:142px; width:20px; height:29px; background:url(http://webimage.10x10.co.kr/play/ground/20150615/blt_arrow02.gif) 0 0 no-repeat;}

.playBrandInfo {height:818px; background:url(http://webimage.10x10.co.kr/play/ground/20150615/bg_brand_info.jpg) 50% 0 no-repeat #242355; background-size:3000px 818px !important;}
.playBrandInfo .introuce {position:absolute; left:0px; top:128px; width:755px; height:0; background:url(http://webimage.10x10.co.kr/play/ground/20150615/txt_brand_info.png) 0 0 no-repeat; opacity:0;}
.playBrandInfo .pic {position:absolute; left:0; top:487px;}
.playBrandInfo .pic li {position:absolute; top:0; left:0; opacity:0;}
.playBrandInfo .pic li.p01 {z-index:60;}
.playBrandInfo .pic li.p02 {z-index:50;}
.playBrandInfo .pic li.p03 {z-index:40;}
.playBrandInfo .pic li.p04 {z-index:30;}
.playBrandInfo .pic li.p05 {z-index:20;}
.playBrandInfo .goBrand {display:none; position:absolute; right:0; top:274px;}
.playBrandInfo .line {display:inline-block; position:absolute; left:0; top:416px; width:0; height:1px; background:#9c99af;}

.myFavorWrite {padding-top:115px; text-align:center; background:url(http://webimage.10x10.co.kr/play/ground/20150615/bg_stripe.gif) 0 0 repeat;}
.myFavorWrite .favorCont {padding-bottom:115px;}
.myFavorWrite h3 {padding-bottom:65px;}
.myFavorWrite .info {background:#f4e1be;}
.myFavorWrite .writeCont {overflow:hidden; width:1140px; padding-top:100px;}
.myFavorWrite .writeCont div {width:872px; height:82px; padding-top:40px; background:#fff;}
.myFavorWrite .writeCont div img {vertical-align:middle;}
.myFavorWrite .writeCont div span {display:inline-block; border-bottom:3px solid #000; padding-bottom:3px; margin:0 20px 0 18px; vertical-align:middle;}
.myFavorWrite .writeCont div input {width:366px; height:35px; color:#000; font-size:35px; text-align:center; font-weight:bold; border:0; font-family:dotum, dotumche, '돋움', '돋움체';}
.myFavorWrite .writeCont p {width:267px;}

.myFavorList {width:1140px; margin:0 auto; padding:120px 0 125px;}
.myFavorList ul {overflow:hidden; margin-right:-57px;}
.myFavorList li {position:relative; float:left; width:242px; height:322px; margin:0 57px 55px 0; color:#000; text-align:left; line-height:1.1; background-repeat:no-repeat; background-position:0 20px;}
.myFavorList li.note01 {background-image:url(http://webimage.10x10.co.kr/play/ground/20150615/bg_cmt01.gif);}
.myFavorList li.note02 {background-image:url(http://webimage.10x10.co.kr/play/ground/20150615/bg_cmt02.gif);}
.myFavorList li.note03 {background-image:url(http://webimage.10x10.co.kr/play/ground/20150615/bg_cmt03.gif);}
.myFavorList li .num {font-size:11px; padding-left:25px;}
.myFavorList li .favor {position:absolute; left:38px; top:156px; font-size:18px; font-weight:bold; letter-spacing:-1px;}
.myFavorList li .writer {position:absolute; right:32px; bottom:24px; font-size:11px; text-align:right; font-weight:bold;}
</style>
<script type="text/javascript" src="/lib/js/jquery.slides.min.js"></script>
<script type="text/javascript">
$(function(){
	$('.slide').slidesjs({
		width:"1140",
		height:"802",
		navigation:false,
		pagination:{effect:"fade"},
		play: {interval:3500, effect:"fade", auto:true},
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
	$(".goApply a").click(function(event){
		event.preventDefault();
		window.parent.$('html,body').animate({scrollTop:$(this.hash).offset().top}, 800);
	});

	function intro () {
		$('.tit .t01').animate({left:'0',opacity:'1'}, 900);
		$('.tit .t02').delay(600).animate({right:'0',opacity:'1'}, 900);
		$('.tit .t03').delay(1000).animate({top:'310px',opacity:'1'}, 900);
		$('.with span').delay(2000).animate({top:'20px'}, 800 ).delay(200).effect( "bounce", {times:5}, 1500);
	}
	function brandInfo () {
		$('.playBrandInfo .introuce').animate({"height":"222px", "opacity":"1"}, 1800);
		$('.playBrandInfo .line').delay(1000).animate({"width":"1140px"}, 1500);
		$('.playBrandInfo .goBrand').delay(2500).fadeIn(500);
		$('.playBrandInfo .pic li.p01').delay(1800).animate({left:'0',opacity:'1'}, 1000 );
		$('.playBrandInfo .pic li.p02').delay(1900).animate({left:'234px',opacity:'1'},1000);
		$('.playBrandInfo .pic li.p03').delay(2000).animate({left:'468px',opacity:'1'},1000);
		$('.playBrandInfo .pic li.p04').delay(2100).animate({left:'702px',opacity:'1'},1000);
		$('.playBrandInfo .pic li.p05').delay(2200).animate({left:'935px',opacity:'1'},1000);
	}
	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 500 ) {
			intro ()
		}
		if (scrollTop > 4450 ) {
			brandInfo();
		}
	});

	<% if Request("iCC")<>"" or Request("eCC")<>"" then %>
		window.parent.$('html,body').animate({scrollTop:$('.myFavorList').offset().top+100}, 300);
	<% end if %>
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
	    alert("내용을 입력해주세요.");
		document.frmcom.qtext1.value="";
	    frm.qtext1.focus();
	    return false;
	   }


	   frm.action = "/play/groundsub/doEventSubscript63687.asp";
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


//-->
</script>
<div class="playGr20150615">
	<form name="frmcom" method="post" onSubmit="return jsSubmitComment(this);" style="margin:0px;">
	<input type="hidden" name="eventid" value="<%=eCode%>"/>
	<input type="hidden" name="bidx" value="<%=bidx%>"/>
	<input type="hidden" name="iCC" value="<%=iCCurrpage%>"/>
	<input type="hidden" name="iCTot" value=""/>
	<input type="hidden" name="mode" value="add"/>
	<input type="hidden" name="userid" value="<%=GetLoginUserID%>"/>
	<div class="intro">
		<div class="favorCont">
			<div class="copy">
				<p class="with" style="margin-bottom:60px;"><span><img src="http://webimage.10x10.co.kr/play/ground/20150615/txt_with_lazyowl.gif" alt="텐바이텐X레이지아울" /></span></p>
				<div class="tit">
					<p class="t01"><img src="http://webimage.10x10.co.kr/play/ground/20150615/tit_like01.png" alt="좋은 것," /></p>
					<p class="t02"><img src="http://webimage.10x10.co.kr/play/ground/20150615/tit_like02.png" alt="좋은 것." /></p>
					<p class="t03"><img src="http://webimage.10x10.co.kr/play/ground/20150615/tit_like03.png" alt="좋아하는 것" /></p>
				</div>
			</div>
			<p style="padding-left:100px;"><img src="http://webimage.10x10.co.kr/play/ground/20150615/txt_my_shirts.png" alt="내가 좋아하는 것을 담음 티셔츠를 만들어 보세요!" /></p>
			<p class="goApply"><a href="#myFavorWrite"><span></span><img src="http://webimage.10x10.co.kr/play/ground/20150615/btn_go_apply.png" alt="" /></a></p>
			<span class="chalk"></span>
		</div>
	</div>
	<div class="slideWrap">
		<div class="slide">
			<div><img src="http://webimage.10x10.co.kr/play/ground/20150615/img_slide01.gif" alt="" /></div>
			<div><img src="http://webimage.10x10.co.kr/play/ground/20150615/img_slide02.jpg" alt="" /></div>
			<div><img src="http://webimage.10x10.co.kr/play/ground/20150615/img_slide03.gif" alt="" /></div>
			<div><img src="http://webimage.10x10.co.kr/play/ground/20150615/img_slide04.jpg" alt="" /></div>
			<div><img src="http://webimage.10x10.co.kr/play/ground/20150615/img_slide05.gif" alt="" /></div>
			<div><img src="http://webimage.10x10.co.kr/play/ground/20150615/img_slide06.jpg" alt="" /></div>
		</div>
	</div>
	<div class="silkScreen">
		<div><span></span><img src="http://webimage.10x10.co.kr/play/ground/20150615/img_silk_screen.png" alt="실크스크린 작업 살펴보기" /></div>
	</div>
	<div class="playBrandInfo">
		<div class="favorCont">
			<div class="introuce"></div>
			<a href="/event/eventmain.asp?eventid=63751" class="goBrand"><img src="http://webimage.10x10.co.kr/play/ground/20150615/btn_go_brand3.gif" alt="브랜드 바로가기" /></a>
			<span class="line"></span>
			<ul class="pic">
				<li class="p01"><img src="http://webimage.10x10.co.kr/play/ground/20150615/img_brand01.png" alt="브랜드 상품 이미지" /></li>
				<li class="p02"><img src="http://webimage.10x10.co.kr/play/ground/20150615/img_brand02.png" alt="브랜드 상품 이미지" /></li>
				<li class="p03"><img src="http://webimage.10x10.co.kr/play/ground/20150615/img_brand03.png" alt="브랜드 상품 이미지" /></li>
				<li class="p04"><img src="http://webimage.10x10.co.kr/play/ground/20150615/img_brand04.png" alt="브랜드 상품 이미지" /></li>
				<li class="p05"><img src="http://webimage.10x10.co.kr/play/ground/20150615/img_brand05.png" alt="브랜드 상품 이미지" /></li>
			</ul>
		</div>
	</div>
	<!-- 코멘트 작성 -->
	<div class="myFavorWrite" id="myFavorWrite">
		<div class="favorCont">
			<h3><img src="http://webimage.10x10.co.kr/play/ground/20150615/tit_comment_event.png" alt="COMMENT EVENT" /></h3>
			<p><img src="http://webimage.10x10.co.kr/play/ground/20150615/txt_comment_event.png" alt="좋아하는 것을 적고 나만의 티셔츠 만들기를 신청하세요." /></p>
			<div class="writeCont">
				<div class="ftLt">
					<img src="http://webimage.10x10.co.kr/play/ground/20150615/txt_favor01.gif" alt="나는" />
					<span><input type="text"  name="qtext1" maxlength="10"/></span>
					<img src="http://webimage.10x10.co.kr/play/ground/20150615/txt_favor02.gif" alt="이(가) 좋아요" />
				</div>
				<p class="ftLt"><input type="image" src="http://webimage.10x10.co.kr/play/ground/20150615/btn_apply.gif" alt="신청하기" /></p>
			</div>
		</div>
		<div class="info"><p><img src="http://webimage.10x10.co.kr/play/ground/20150615/txt_class_info.gif" alt="" /></p></div>
	</div>
	<!--// 코멘트 작성 -->
	</form>
	<form name="frmdelcom" method="post" action="/play/groundsub/doEventSubscript63687.asp" style="margin:0px;">
	<input type="hidden" name="eventid" value="<%=eCode%>">
	<input type="hidden" name="bidx" value="<%=bidx%>">
	<input type="hidden" name="Cidx" value="">
	<input type="hidden" name="mode" value="del">
	<input type="hidden" name="userid" value="<%=GetLoginUserID%>">
	</form>

	<% IF isArray(arrCList) THEN %>
	<%' 코멘트 리스트 %>
	<div class="myFavorList">
		<ul>
			<%' for dev msg : li에 클래스 note01~03 랜덤으로 붙여주세요 / 리스트는 12개씩 노출됩니다. %>
			<% For intCLoop = 0 To UBound(arrCList,2) %>
				<% 
						Dim opt1 , opt2 , opt3
						If arrCList(1,intCLoop) <> "" then
							opt1 = SplitValue(arrCList(1,intCLoop),"//",0)
							opt2 = SplitValue(arrCList(1,intCLoop),"//",1)
							opt3 = SplitValue(arrCList(1,intCLoop),"//",2)
						End If 

					If iColorVal > 3 Then
						iColorVal = 1
					End If

				%>
				<li class="note0<%=iColorVal%>">
					<p class="num">no.<%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1)) %></p>
					<p class="favor"><%=opt1%></p>
					<p class="writer"><% If arrCList(8,intCLoop) = "M"  then%><img src="http://webimage.10x10.co.kr/play/ground/20150202/ico_mob.gif" alt="모바일에서 작성" /> <% End If %> <%=printUserId(arrCList(2,intCLoop),2,"*")%></p>
				</li>
				<%
					iColorVal = iColorVal + 1
				%>
			<% Next %>
		</ul>
		<div class="pageWrapV15 tMar20">
			<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
		</div>
	</div>
	<%'// 코멘트 리스트 %>
	<% End If %>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->