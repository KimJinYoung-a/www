<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<%
'########################################################
' PLAY 꽃보다 예쁜 우리 엄마
' 2015-04-30 한용민 작성
'########################################################
%>
<%
Dim eCode, eCodedisp
IF application("Svr_Info") = "Dev" THEN
	eCode   =  61791
	eCodedisp = 61792
Else
	eCode   =  62669
	eCodedisp = 62667
End If

userid = getloginuserid()

dim currenttime
	currenttime =  now()
	'currenttime = #05/18/2015 09:00:00#
	
dim userid, commentcount, i
	userid = getloginuserid()

commentcount = getcommentexistscount(userid, eCode, "", "", "", "")

dim cEComment ,blnFull, cdl, com_egCode, bidx, blnBlogURL, strBlogURL
dim iCTotCnt, arrCList,intCLoop
dim iCPageSize, iCCurrpage, isMyComm
dim iCStartPage, iCEndPage, iCTotalPage, iCx,iCPerCnt
	iCCurrpage	= requestCheckVar(Request("iCC"),10)	'현재 페이지 번호
	cdl			= requestCheckVar(Request("cdl"),3)
	blnFull		= requestCheckVar(Request("blnF"),10)
	blnBlogURL	= requestCheckVar(Request("blnB"),10)
	isMyComm	= requestCheckVar(request("isMC"),1)

IF blnFull = "" THEN blnFull = True
IF blnBlogURL = "" THEN blnBlogURL = False

IF iCCurrpage = "" THEN
	iCCurrpage = 1
END IF
IF iCTotCnt = "" THEN
	iCTotCnt = -1
END IF

iCPerCnt = 10		'보여지는 페이지 간격
'한 페이지의 보여지는 열의 수
if blnFull then
	iCPageSize = 5		'풀단이면 15개			'/수기이벤트 둘다 강제 12고정
else
	iCPageSize = 5		'메뉴가 있으면 10개			'/수기이벤트 둘다 강제 12고정
end if

'데이터 가져오기
set cEComment = new ClsEvtComment
	cEComment.FECode 		= eCode
	cEComment.FComGroupCode	= com_egCode
	cEComment.FEBidx    	= bidx
	cEComment.FCPage 		= iCCurrpage	'현재페이지
	cEComment.FPSize 		= iCPageSize	'페이지 사이즈
	if isMyComm="Y" then cEComment.FUserID = userid
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

/* iframe */
img {vertical-align:top;}

.playGr20150518 .topic {overflow:hidden; position:relative; height:920px; background-color:#fdfdfd;}
.playGr20150518 .topic .inner {position:relative; width:1140px; margin:0 auto;}
.playGr20150518 .topic .inner .hgroup {position:absolute; top:85px; right:35px; z-index:5; width:460px; height:300px;}
.playGr20150518 .topic .inner .hgroup p {text-indent:-999em;}
.playGr20150518 .topic .inner .hgroup .word1 {width:460px; height:50px; background:url(http://webimage.10x10.co.kr/play/ground/20150518/bg_topic.png) no-repeat 0 0;}
.playGr20150518 .topic .inner .hgroup span {display:block; background:url(http://webimage.10x10.co.kr/play/ground/20150518/bg_topic.png) no-repeat 0 0; text-indent:-999em;}
.playGr20150518 .topic .inner .hgroup h1 {position:relative; height:210px;}
.playGr20150518 .topic .inner .hgroup h1 span {position:absolute;}
.playGr20150518 .topic .inner .hgroup .word2 {top:0; left:0; width:294px; height:100px; background-position:0 -52px;}
.playGr20150518 .topic .inner .hgroup .word3 {top:0; right:0; width:166px; height:100px; background-position:-294px -52px;}
.playGr20150518 .topic .inner .hgroup .word4 {top:100px; left:0; width:228px; height:100px; background-position:0 -160px;}
.playGr20150518 .topic .inner .hgroup .word5 {top:100px; left:228px; width:232px; height:100px; background-position:-228px -160px;}
.playGr20150518 .topic .inner .hgroup .word6 {width:460px; height:40px; background:url(http://webimage.10x10.co.kr/play/ground/20150518/bg_topic.png) no-repeat 0 100%;}
.playGr20150518 .topic .bg {position:absolute; top:0; left:50%; width:1920px; height:920px; margin-left:-960px; background:url(http://webimage.10x10.co.kr/play/ground/20150518/img_photo_01.jpg) no-repeat 50% 0;}

.playGr20150518 .intro {height:460px; background:#f2e8e7 url(http://webimage.10x10.co.kr/play/ground/20150518/bg_pink_paper.png) repeat-x 50% 0;}
.playGr20150518 .intro .inner {position:relative; width:1140px; margin:0 auto; padding-top:70px;}
.playGr20150518 .intro .inner h2 {padding-left:52px;}
.playGr20150518 .intro .inner p {margin-top:30px; padding-left:60px;}
.playGr20150518 .intro .inner .imac {position:absolute; top:100px; right:45px;}

.playGr20150518 .story {position:relative; height:695px; padding-top:85px; background:#e7d9dc url(http://webimage.10x10.co.kr/play/ground/20150518/img_flower_crown_v1.jpg) no-repeat 50% 0;}
.playGr20150518 .story .box {width:510px; height:360px; margin:0 auto; padding-top:150px; background:url(http://webimage.10x10.co.kr/play/ground/20150518/bg_diamond.png) no-repeat 50% 0;}
.playGr20150518 .story .box p {width:310px; margin:23px auto 0; padding-right:15px; color:#3f3b39; text-align:center;}
.playGr20150518 .story .box p:first-child {margin-top:10px;}
.playGr20150518 .story .box span {display:block; width:8px; height:1px; margin:25px 0 0 240px; background-color:#bcbcbc;}
.playGr20150518 .story .btnleave {position:absolute; top:640px; left:50%; margin-left:-208px;}
.playGr20150518 .story .btnleave:hover {-webkit-animation-name:updown; -webkit-animation-iteration-count: infinite; -webkit-animation-duration:0.5s; -moz-animation-name: updown; -moz-animation-iteration-count: infinite; -moz-animation-duration:0.5s; -ms-animation-name: updown; -ms-animation-iteration-count: infinite; -ms-animation-duration:0.5s;}
@-webkit-keyframes updown {
	from, to{margin-top:0; -webkit-animation-timing-function:ease-out;}
	50% {margin-top:5px; -webkit-animation-timing-function:ease-in;}
}
@keyframes updown {
	from, to{margin-top:0; animation-timing-function:ease-out;}
	50% {margin-top:5px; animation-timing-function:ease-in;}
}

.playGr20150518 .article {position:relative; background:#fffdf5 url(http://webimage.10x10.co.kr/play/ground/20150518/bg_photo.jpg) no-repeat 50% 100%;}
.playGr20150518 .article .movie {height:1203px; padding-top:137px; background:#faf9e2 url(http://webimage.10x10.co.kr/play/ground/20150518/bg_leaf.png) no-repeat 50% 0;}
.playGr20150518 .video {width:743px; height:421px; margin:0 auto; padding:12px 12px 11px 13px; background:url(http://webimage.10x10.co.kr/play/ground/20150518/bg_frame.png) no-repeat 50% 0;}
.prologue {padding-top:30px; text-align:center;}
.prologue p {margin-top:30px;}
.rolling {position:absolute; top:1095px; left:50%; width:1138px; height:797px; margin-left:-569px; background:url(http://webimage.10x10.co.kr/play/ground/20150518/bg_slide.png) no-repeat 50% 0;}
.slide-wrap {position:relative; padding:9px 10px 28px 8px;}
.slide {height:760px;}
.slide .slidesjs-navigation {position:absolute; top:358px; width:55px; height:56px; background:url(http://webimage.10x10.co.kr/play/ground/20150518/btn_nav.png) no-repeat 0 0; text-indent:-999em;}
.slide .slidesjs-previous {left:-95px; background-position:0 0;}
.slide .slidesjs-next {right:-95px; background-position:100% 0;}
.playGr20150518 .article .letters {width:1140px; margin:0 auto; height:978px; padding-top:622px;}
.playGr20150518 .article .letters .desc {position:relative; padding-left:48px;}
.playGr20150518 .article .letters .bg {background:url(http://webimage.10x10.co.kr/play/ground/20150518/bg_letter.png) no-repeat 48px 0;}
.playGr20150518 .article .letters .desc .heart {position:absolute; bottom:0; left:107px;}
.lalasnap {margin-top:225px; padding-left:48px;}

.commentevt {padding-top:100px; padding-bottom:145px; border-top:6px solid #f3c9b6; background:#f8efe8 url(http://webimage.10x10.co.kr/play/ground/20150518/bg_pink.png) repeat 50% 0;}

.commentevt .inner {width:1140px; margin:0 auto; border-bottom:1px solid #ebe0da;}
.commentevt .field {position:relative; padding:0 0 70px 120px; background:url(http://webimage.10x10.co.kr/play/ground/20150518/bg_dashed_line.png) no-repeat 50% 100%;}
.commentevt .field .hgroup {position:relative; padding-top:110px;}
.commentevt .field .hgroup h2 {position:absolute; top:9px; left:0;}
.commentevt .field .hgroup .brush {position:absolute; top:9px; left:150px;}
.commentevt .field .hgroup .flower {position:absolute; top:0; left:640px;}
.commentevt .field .itext {width:726px; height:70px; padding:0 30px; border:2px solid #f3b7ab; color:#999; font-family:'Batang', '바탕', 'Arial'; font-size:13px; line-height:70px;}
::-webkit-input-placeholder { color:#999; }
::-moz-placeholder { color:#999; } /* firefox 19+ */
:-ms-input-placeholder { color:#999; } /* ie */
input:-moz-placeholder { color:#999; }
.commentevt .field .itext:focus {color:#333;}
.commentevt .field .btnsubmit {position:absolute; top:70px; right:30px; width:178px; height:154px; background:url(http://webimage.10x10.co.kr/play/ground/20150518/bg_btn_submit.png) no-repeat 0 0;}
.commentevt .field .btnsubmit span {position:absolute; bottom:45px; left:70px;}
.commentevt .field .btnsubmit span {-webkit-animation-fill-mode:both; animation-fill-mode:both; -webkit-animation-duration:1s; animation-duration:1s; -webkit-animation-name:flash; animation-name:flash; -webkit-animation-iteration-count:infinite; animation-iteration-count:infinite;}

.commentevt .commentlist {overflow:hidden; padding-bottom:70px;}
.commentevt .commentlist ul {width:980px; margin:0 auto; padding-top:40px;}
.commentevt .commentlist ul li {position:relative; padding:20px 0 20px 142px; border-bottom:1px solid #ecdcd4; zoom:1;}
.commentevt .commentlist ul li .no {position:absolute; top:26px; left:45px; width:77px; height:20px; margin-top:-10px; background:url(http://webimage.10x10.co.kr/play/ground/20150518/bg_round_box.png) no-repeat 50% 0; color:#fff; font-family:'Verdana', 'Arial'; font-weight:bold; line-height:20px; text-align:center;}
.commentevt .commentlist ul li p {padding-left:10px; background:url(http://webimage.10x10.co.kr/play/ground/20150518/blt_arrow_01.png) no-repeat 0 3px; font-size:13px; line-height:13px;}
.commentevt .commentlist ul li p strong {color:#333; font-family:'Batang', '바탕', 'Arial'; font-weight:normal;}
.commentevt .commentlist ul li p .id {display:block; margin-top:10px; padding-right:35px; color:#777; font-family:'Dotum', '돋움', 'Verdana';}
.commentevt .commentlist ul li p .id img {vertical-align:middle;}
.btndel {margin-left:3px; width:23px; height:23px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/61867/btn_del.png) no-repeat 50% 0; text-indent:-999em;}
.commentevt .pageWrapV15 {padding-top:40px}
.commentevt .paging a, .commentevt .paging a:hover {background-color:transparent;}
.pageMove {display:none;}

.animated {
	-webkit-animation-duration:5s;
	animation-duration:5s; 
	-webkit-animation-fill-mode:both;
	animation-fill-mode:both;
	-webkit-animation-iteration-count:infinite;
	animation-iteration-count:infinite;
}

/* flash animation */
@-webkit-keyframes flash {
	0% {opacity:0;}
	100% {opacity:1;}
}
@keyframes flash {
	0% {opacity:0;}
	100% {opacity:1;}
}
.flash {-webkit-animation-duration:1s; animation-duration:1s; -webkit-animation-name:flash; animation-name:flash; -webkit-animation-iteration-count:infinite; animation-iteration-count:infinite;}
</style>
<script type="text/javascript">

function jsGoComPage(iP){
	document.frmcom.iCC.value = iP;
	document.frmcom.iCTot.value = "<%=iCTotCnt%>";
	document.frmcom.submit();
}

function jsSubmitComment(frm){
	<% If IsUserLoginOK() Then %>
		<% If not( left(currenttime,10)>="2015-05-18" and left(currenttime,10)<"2017-06-01" ) Then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return false;
		<% else %>
			<% if commentcount>5 then %>
				alert("이벤트는 5회만 참여하실수 있습니다.");
				return false;
			<% else %>

				if (frm.txtcomm.value == '' || GetByteLength(frm.txtcomm.value) > 100 || frm.txtcomm.value == '100자 이내로 입력해주세요'){
					alert("코맨트를 남겨주세요.\n100자 까지 작성 가능합니다.");
					frm.txtcomm.focus();
					return false;
				}

			   frm.action = "/event/lib/comment_process.asp";
			   frm.submit();
			<% end if %>
		<% end if %>
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return false;
		}
		return false;
	<% End IF %>
}

function jsDelComment(cidx)	{
	if(confirm("삭제하시겠습니까?")){
		document.frmdelcom.Cidx.value = cidx;
   		document.frmdelcom.submit();
	}
}

function jsCheckLimit() {
	if ("<%=IsUserLoginOK%>"=="False") {
		jsChklogin('<%=IsUserLoginOK%>');
		return false;
	}

//	if (frmcom.txtcomm1.value == '100자 이내로 입력해주세요'){
//		frmcom.txtcomm1.value = '';
//	}
}

//내코멘트 보기
function fnMyComment() {
	document.frmcom.isMC.value="<%=chkIIF(isMyComm="Y","N","Y")%>";
	document.frmcom.iCC.value=1;
	document.frmcom.submit();
}

</script>
</head>
<body>

<!-- iframe -->
<div class="playGr20150518">
	<div class="topic">
		<div class="inner">
			<div class="hgroup">
				<p class="word1">텐바이텐과 랄라스냅</p>
				<h1>
					<span class="word2">꽃보다</span>
					<span class="word3">예쁜</span>
					<span class="word4">우리</span>
					<span class="word5">엄마</span>
				</h1>
				<p class="word6">여전히 아름다운 엄마와 딸의 추억 만들기 프로젝트</p>
			</div>
		</div>
		<div class="bg"></div>
	</div>

	<div class="intro">
		<div class="inner">
			<h2><img src="http://webimage.10x10.co.kr/play/ground/20150518/tit_intro.png" alt="사전 이벤트 진행" /></h2>
			<p><img src="http://webimage.10x10.co.kr/play/ground/20150518/txt_intro.png" alt="텐바이텐 PLAY GROUND 5월 주제는 달콤하고 아름다운 꽃 FLOWER입니다. 세상에는 수많은 꽃들이 있습니다. 꽃, 아름다운 것에 대해 생각하다 문득 엄마를 떠올렸습니다. 언제나, 그 자리에서 지친 일상에 좋은 향기가 되어주는 우리 엄마. 흔히 친구, 남자친구 또는 새로 맞이하는 남편과 추억을 담는 화보. 이번만큼은 여전히 아름답게 피고 있는 엄마와의 화보를 촬영해 드립니다. " /></p>
			<span class="imac"><img src="http://webimage.10x10.co.kr/play/ground/20150518/img_imac.png" alt="" /></span>
		</div>
	</div>

	<div class="story">
		<div class="box">
			<p class="word1">여느 부부처럼 아빠가 살아계셨으면<br /> 올해가 25주년, 은혼식을 맞이하셨을 엄마.</p>
			<p class="word2">다른 친구들처럼 리마인드 웨딩을 준비해드리고 싶지만, 엄마는 혼자라는 게 주목 받으실까봐 싫어하시더라고요.</p>
			<p class="word3">리마인드 웨딩 대신에<br /> 저와 함께 좋은 추억 남겨드리고 싶어요.</p>
			<span class="word4"></span>
			<p class="word5">현지영 (guswldud**)</p>
		</div>
		<div class="btnleave"><a href="#commentevt"><img src="http://webimage.10x10.co.kr/play/ground/20150518/btn_leave.png" alt="우리 엄마에게도 사랑의 메시지 전하기" /></a></div>
	</div>

	<div class="article">
		<div class="movie">
			<div class="video">
				<iframe src="//player.vimeo.com/video/127792073" width="740" height="416" frameborder="0" title="꽃보다 예쁜 우리 엄마" webkitallowfullscreen="" mozallowfullscreen="" allowfullscreen=""></iframe>
			</div>
			<div class="prologue">
				<p><img src="http://webimage.10x10.co.kr/play/ground/20150518/txt_prologue_01.png" alt="2015년 5월 10일" /></p>
				<p><img src="http://webimage.10x10.co.kr/play/ground/20150518/txt_prologue_02.png" alt="화창한 오월 어느 날, 예쁜 미소를 가진 모녀를 만났습니다. 제주도에서 올라와 서울에서 직장생활을 시작한 씩씩한 딸, 이벤트 당첨 소식을 들으시고, 제주도에서 새벽 비행기를 타고 오신 소녀 같은 엄마" /></p>
				<p><img src="http://webimage.10x10.co.kr/play/ground/20150518/txt_prologue_03.png" alt="웃는 모습은 물론 발 크기, 키까지 똑 닮은 모녀. 도란도란 사이좋은 모녀를 보면서 보는 이들마저 흐뭇한 마음으로 촬영을 진행할 수 있었습니다." /></p>
				<p><img src="http://webimage.10x10.co.kr/play/ground/20150518/txt_prologue_04.png" alt="노을공원 바람의 광장. 쏟아지던 햇살도, 초록빛이 가득한 장소도, 알맞게 불어오던 바람도 좋았습니다. 어쩌면 이 모든 것들이 선물처럼 느껴지는 하루였습니다." /></p>
				<p><img src="http://webimage.10x10.co.kr/play/ground/20150518/txt_prologue_05.png" alt="텐바이텐과 랄라스냅, 그리고 모녀가 함께 촬영한 그 날의 아름다운 순간을 공개합니다" /></p>
			</div>
		</div>

		<div class="rolling">
			<div class="slide-wrap">
				<div id="slide1" class="slide">
					<img src="http://webimage.10x10.co.kr/play/ground/20150518/img_slide_01.jpg" alt="" />
					<img src="http://webimage.10x10.co.kr/play/ground/20150518/img_slide_02.jpg" alt="" />
					<img src="http://webimage.10x10.co.kr/play/ground/20150518/img_slide_03.jpg" alt="" />
					<img src="http://webimage.10x10.co.kr/play/ground/20150518/img_slide_04.jpg" alt="" />
					<img src="http://webimage.10x10.co.kr/play/ground/20150518/img_slide_05.jpg" alt="" />
					<img src="http://webimage.10x10.co.kr/play/ground/20150518/img_slide_06.jpg" alt="" />
				</div>
			</div>
		</div>

		<div class="letters">
			<div class="desc bg">
				<p><img src="http://webimage.10x10.co.kr/play/ground/20150518/txt_letter.png" alt="사랑하는 엄마 다른 친구들처럼 결혼 25주년 기념 리마인드 웨딩 선물을 정말 해주고 싶었는데, 현실적으로 어려우니까 남편보다 더 든든한 딸들이 있다는 걸 보여주고 싶었어. 그리고 엄마의 아름다운 지금 모습을 조금 더 소중하게 간직하고 싶어서 이벤트를 신청하게 되었는데, 이렇게 함께 할 수 있어 정말 기뻤어. 먼 길인데 와줘서 정말 고맙고, 하루 종일 예쁘게 웃는 엄마 보면서 나도 정말 행복한 하루 보낸 것 같아. 혼자서도 때로는 강하게 때로는 친구처럼 우리 세 딸 예쁘게 잘 키워줘서 정말 정말 고마워. 세상 그 무엇보다 아름답고 향기로운 엄마! 사랑해" /></p>
				<span class="heart flash animated"><img src="http://webimage.10x10.co.kr/play/ground/20150518/img_heart.png" alt="" /></span>
			</div>

			<p class="lalasnap">
				<img src="http://webimage.10x10.co.kr/play/ground/20150518/txt_about_lalasnap.jpg" alt="랄라스냅은 남는 건 사진뿐이라는 슬로건 아래 기존 웨딩 촬영과는차별화된 촬영으로 특별한 날을 아름다운 추억으로 남겨드립니다. 일대일 맞춤으로 스페셜한 웨딩 촬영을 추구하며, 빈티지한 색감과 동화 같은 콘셉트로 꽃과 함께 하는 스냅사진을 전문적으로 촬영합니다." usemap="#sitelink" />
				<map name="sitelink" id="sitelink">
					<area shape="rect" coords="250,134,455,170" href="http://www.lalasnap.com/xe/" target="_blank" title="새창" alt="랄라스냅 홈페이지" />
					<area shape="rect" coords="473,134,686,171" href="http://lalasnap_.blog.me" target="_blank" title="새창" alt="랄라스냅 블로그" />
				</map>
			</p>
		</div>
	</div>

	<!-- comment event -->
	<div id="commentevt" class="commentevt">
		<div class="inner">
			<form name="frmcom" method="post" onSubmit="return false;" style="margin:0px;">
			<input type="hidden" name="eventid" value="<%=eCode%>">
			<input type="hidden" name="com_egC" value="<%=com_egCode%>">
			<input type="hidden" name="bidx" value="<%=bidx%>">
			<input type="hidden" name="iCC" value="<%=iCCurrpage%>">
			<input type="hidden" name="iCTot" value="">
			<input type="hidden" name="mode" value="add">
			<input type="hidden" name="spoint" value="0">
			<input type="hidden" name="isMC" value="<%=isMyComm%>">
			<div class="field">
				<div class="hgroup">
					<h2><img src="http://webimage.10x10.co.kr/play/ground/20150518/tit_leave_message.png" alt="엄마에게 사랑의 메시지를 남겨주세요!" /></h2>
					<span class="brush"><img src="http://webimage.10x10.co.kr/play/ground/20150518/bg_brush.png" alt="" /></span>
					<span class="flower animated pulse"><img src="http://webimage.10x10.co.kr/play/ground/20150518/img_flower.png" alt="" /></span>
				</div>
				<input type="text" name="txtcomm" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();" <%IF NOT(IsUserLoginOK) THEN%>readonly<%END IF%> value="<%IF NOT IsUserLoginOK THEN%>로그인 후 글을 남길 수 있습니다.<% else %><%END IF%>" title="" placeholder="엄마에게 보내는 사랑의 메시지(100자 이내)" class="itext" />
				<div class="btnsubmit">
					<input type="image" onclick="jsSubmitComment(frmcom); return false;" src="http://webimage.10x10.co.kr/play/ground/20150518/btn_submit.png" alt="메시지 남기기" />
					<span><img src="http://webimage.10x10.co.kr/play/ground/20150518/blt_arrow_02.png" alt="" /></span>
				</div>
			</div>
			</form>
			<form name="frmdelcom" method="post" action = "/event/lib/comment_process.asp" style="margin:0px;">
				<input type="hidden" name="eventid" value="<%=eCode%>">
				<input type="hidden" name="com_egC" value="<%=com_egCode%>">
				<input type="hidden" name="bidx" value="<%=bidx%>">
				<input type="hidden" name="Cidx" value="">
				<input type="hidden" name="mode" value="del">
				<input type="hidden" name="userid" value="<%=GetLoginUserID%>">
			</form>

			<% IF isArray(arrCList) THEN %>
				<div class="commentlist">
					<ul>
						<% ' <!-- for dev msg : 한 페이지당 5개씩 보여주세요 --> %>
						<%
						dim rndNo : rndNo = 1
						
						For intCLoop = 0 To UBound(arrCList,2)
						
						randomize
						rndNo = Int((2 * Rnd) + 1)
						%>
							<li>
								<span class="no">no.<%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1))%></span>
								<p>
									<strong><%=ReplaceBracket(db2html( arrCList(1,intCLoop) ))%></strong> 
									<span class="id">
										- <%=printUserId(arrCList(2,intCLoop),2,"*")%>님의 메시지
									
										<% If arrCList(8,i) <> "W" Then %>
											 <img src="http://webimage.10x10.co.kr/play/ground/20150518/ico_mobile.png" alt="모바일에서 작성된 글" />
										<% end if %>
										
										<% if ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %>
											<button type="button" onclick="jsDelComment('<% = arrCList(0,intCLoop) %>');return false;" class="btndel">삭제</button>
										<% end if %>
									</span>
								</p>
							</li>
						<%
						Next
						%>	
					</ul>
	
					<% IF isArray(arrCList) THEN %>
						<div class="pageWrapV15">
							<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
						</div>
					<% end if %>
				</div>
			<% end if %>
		</div>
	</div>
</div>
<!-- //iframe -->

<!-- for dev msg : body 끝나기전에 js 넣어주세요 -->
<script type="text/javascript" src="/lib/js/jquery.slides.min.js"></script>
<script type="text/javascript">
$(function(){
	/* slide */
	$('#slide1').slidesjs({
		width:"1120",
		height:"760",
		pagination:false,
		navigation:{effect:"fade"},
		play:{interval:3500, effect:"fade", auto:true},
		effect:{fade: {speed:1500, crossfade:true}
		},
		callback: {
			complete: function(number) {
				var pluginInstance = $('#slide1').data('plugin_slidesjs');
				setTimeout(function() {
					pluginInstance.play(true);
				}, pluginInstance.options.play.interval);
			}
		}
	});

	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 100){
			animation1();
		}
		if (scrollTop > 1500 ) {
			animation2();
		}
		if (scrollTop > 4000) {
			animation3();
		}
		if (scrollTop > 5000 ) {
			animation4();
		}
	});

	$(".topic .hgroup p").css({"opacity":"0"});
	$(".topic .hgroup span").css({"opacity":"0"});
	$(".topic .hgroup .word6").css({"margin-top":"10px"});
	function animation1 () {
		$(".topic .hgroup .word1").delay(3600).animate({"opacity":"1"},700);
		$(".topic .hgroup .word2").delay(2000).animate({"opacity":"1"},2000);
		$(".topic .hgroup .word3").delay(500).animate({"opacity":"1"},500);
		$(".topic .hgroup .word4").delay(900).animate({"opacity":"1"},500);
		$(".topic .hgroup .word5").delay(1300).animate({"opacity":"1"},500);
		$(".topic .hgroup .word6").delay(3000).animate({"opacity":"1", "margin-top":"0"},700);
	}

	$(".story .box p").css({"opacity":"0"});
	$(".story .box span").css({"opacity":"0"});
	function animation2 () {
		$(".story .box .word1").delay(500).animate({"opacity":"1"},700);
		$(".story .box .word2").delay(1000).animate({"opacity":"1"},700);
		$(".story .box .word3").delay(1500).animate({"opacity":"1"},700);
		$(".story .box .word4").delay(2000).animate({"opacity":"1"},1000);
		$(".story .box .word5").delay(2500).animate({"opacity":"1"},700);
	}

	$(".letters .desc").removeClass("bg");
	$(".letters .bg").css({"width":"0"});
	$(".letters .desc p").css({"opacity":"0"});
	function animation3 () {
		$(".letters .desc p").delay(100).animate({"opacity":"1"},500);
		$(".letters .desc").stop(true,false).addClass('bg', {duration:800}).animate({"width":"677px"},800);
	}

	$(".commentevt h2").css({"opacity":"0", "margin-top":"10px"});
	$(".commentevt .flower").css({"opacity":"0", "margin-top":"7px"});
	$(".commentevt .brush img").css({"opacity":"0", "width":"0", "height":"61px"});
	function animation4 () {
		$(".commentevt h2").delay(500).animate({"opacity":"1", "margin-top":"0"},800);
		$(".commentevt .flower").delay(1500).animate({"opacity":"1", "margin-top":"0"},800);
		$(".commentevt .brush img").delay(2000).animate({"opacity":"1", "width":"273px", "height":"61px"},1500);
	}
});
</script>
</body>
</html>

<!-- #include virtual="/lib/poptailer.asp" -->
<!-- #include virtual="/lib/db/dbclose.asp" -->