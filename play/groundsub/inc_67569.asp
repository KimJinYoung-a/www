<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<%
'########################################################
' PLAY #26 PRESENT 싹수가 노랗다
' 2015-11-20 원승현 작성
'########################################################
Dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  65958
Else
	eCode   =  67569
End If

dim com_egCode, bidx
	Dim cEComment
	Dim iCTotCnt, arrCList,intCLoop, iSelTotCnt
	Dim iCPageSize, iCCurrpage
	Dim iCStartPage, iCEndPage, iCTotalPage, iCx,iCPerCnt
	Dim timeTern, totComCnt, eCC

	'파라미터값 받기 & 기본 변수 값 세팅
	iCCurrpage = requestCheckVar(Request("iCC"),10)	'현재 페이지 번호
	com_egCode = requestCheckVar(Request("eGC"),1)	
	eCC = requestCheckVar(Request("eCC"), 1) 

	IF iCCurrpage = "" THEN iCCurrpage = 1
	IF iCTotCnt = "" THEN iCTotCnt = -1

	'// 그룹번호 랜덤으로 지정

	iCPageSize = 6		'한 페이지의 보여지는 열의 수
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
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/section.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<style type="text/css">
img {vertical-align:top;}
.groundHeadWrap {width:100%; background:#fff68e url(http://webimage.10x10.co.kr/play/ground/20151123/bg_pattern_v1.png) repeat-x 50% 0; background-size:initial;}
.groundCont {position:relative; padding-bottom:0;}
.groundCont .grArea {width:100%;}
.groundCont .tagView {position:absolute; bottom:30px; left:50%; width:1100px; margin-left:-570px; padding:28px 20px 60px; border-top:1px solid #dadfe4;}

.playGr20151123 {text-align:center;}

.topic {position:relative; height:442px; background:#fff68e url(http://webimage.10x10.co.kr/play/ground/20151123/bg_pattern_v1.png) repeat 50% 21px;}
.topic .hwrap {position:absolute; top:157px; left:50%; width:672px; margin-left:-336px;}
.topic .hwrap h3 .letter01 {position:absolute; top:120px; left:50%; z-index:10; margin-left:-233px;}
.topic .hwrap h3 .letter02 {position:absolute; top:249px; left:50%; z-index:10; margin-left:-235px;}
.topic .hwrap .box {position:absolute; top:9px; left:50%; z-index:5; margin-left:-336px;}
.topic .hwrap p {position:absolute; top:0; left:50%; z-index:10; margin-left:-190px;}

.plan {padding-top:292px; padding-bottom:341px; background:#96decb url(http://webimage.10x10.co.kr/play/ground/20151123/bg_socks.png) no-repeat 50% 0;}
.plan p {height:527px;}

.intro {position:relative; padding-top:413px; padding-bottom:149px; background:#9ea1da url(http://webimage.10x10.co.kr/play/ground/20151123/bg_dot_pattern_purple.png) repeat 0 0;}
.intro ul {overflow:hidden; position:absolute; top:-160px; left:50%; width:1080px; margin-left:-540px;}
.intro ul li {float:left; width:300px; height:460px; margin:0 30px; background:url(http://webimage.10x10.co.kr/play/ground/20151123/bg_box.png) no-repeat 50% 0;}
.intro ul li p {padding-top:60px;}
.intro ul li span {display:block;}
.intro ul li.intro01 span {margin-top:46px;}
.intro ul li.intro02 span {margin-top:61px;}
.intro ul li.intro03 span {margin-top:71px;}

.intro ul li{transition:2.2s ease-in-out; transform-origin:50% 0%; transform:rotateY(0deg);}
.intro ul li.rotate {transform:rotateY(360deg);}

/* play + with */
.playwithMe {overflow:hidden;}
.playwithMe .play, .playwithMe .with {float:left; position:relative; width:50%; height:700px;}
.playwithMe .play {background:#fff url(http://webimage.10x10.co.kr/play/ground/20151123/bg_socks_play.jpg) no-repeat 100% 0;}
.playwithMe .with {background:#e6edf3 url(http://webimage.10x10.co.kr/play/ground/20151123/bg_socks_with.jpg) no-repeat 0 0;}
.playwithMe .me {clear:left; position:relative; width:100%; height:680px; background:#b5bdc3 url(http://webimage.10x10.co.kr/play/ground/20151123/img_photo_foot.jpg) no-repeat 50% 0;}
.playwithMe .ico {position:absolute;}
.playwithMe .play p {position:absolute; top:121px; right:217px;}
.playwithMe .play .ico {top:110px; right:455px;}
.playwithMe .with p {position:absolute; top:412px; left:133px;}
.playwithMe .with .ico {top:400px; left:101px;}
.playwithMe .me p {position:absolute; top:223px; left:50%; margin-left:-491px;}

/* rolling */
.rolling {width:100%;}
.rolling .swiper {overflow:hidden; position:relative;}
.rolling .swiper .swiper-container {overflow:hidden;}
.rolling .swiper .swiper-wrapper {position:relative;}
.rolling .swiper .swiper-slide {overflow:hidden; float:left; position:relative; width:100%; min-width:1140px; height:920px; background-color:#2e2c22; text-align:center;}
.rolling .swiper .pagination {position:absolute; bottom:60px; left:0; width:100%; text-align:center;}
.rolling .swiper .pagination span {display:inline-block; *display:inline; *zoom:1; width:80px; height:4px; margin:0 10px; background-color:#f8f5e6; cursor:pointer; transition:background-color 1s ease;}
.rolling .swiper .pagination .swiper-active-switch {background-color:#2f2d23;}

.rolling .swiper .swiper-slide-1 {background-color:#1c6c45;}
.rolling .swiper .swiper-slide-2 {background-color:#3b4f99;}
.rolling .swiper .swiper-slide-3 {background-color:#1e6a4c;}
.rolling .swiper .swiper-slide-4 {background-color:#344b95;}

/* brand */
.brand {overflow:hidden;}
.brand .desc, .brand .name {float:left; position:relative; width:50%; height:480px;}
.brand .desc {background-color:#f5f5f5;}
.brand .desc p {position:absolute; top:150px; right:76px;}
.brand .desc .ico {position:absolute; top:130px; right:521px;}
.brand .name a {position:absolute; top:120px; left:178px;}
.brand .name a:hover img {-webkit-animation-name:bounce; -webkit-animation-iteration-count:infinite; -webkit-animation-duration:0.5s; animation-name:bounce; animation-iteration-count:infinite; animation-duration:0.5s;}
@-webkit-keyframes bounce {
	from, to{margin-top:0; -webkit-animation-timing-function:ease-out;}
	50% {margin-top:-7px; -webkit-animation-timing-function:ease-in;}
}
@keyframes bounce {
	from, to{margin-top:0; animation-timing-function:ease-out;}
	50% {margin-top:-7px; animation-timing-function:ease-in;}
}

/* comment */
.commentevt {padding-top:105px; padding-bottom:190px; border-top:10px solid #a7a7ac; background:#e8eef3 url(http://webimage.10x10.co.kr/play/ground/20151123/bg_dot_pattern_grey.png) repeat 0 1px;}
.form {width:1100px; margin:0 auto; text-align:left;}
.form .hwrap {position:relative; height:260px; padding-top:55px; padding-left:310px;}
.form .hwrap h4 {position:absolute; top:0; left:0;}
.form .hwrap span {position:absolute; top:160px; right:2px; z-index:5;}

.field {position:relative; padding:60px 80px 50px 50px; border-top:1px solid #cbcfdf; border-bottom:11px solid #cbcfdf; background-color:#f6f8fc;}
.field .name, .field .msg {position:relative; padding-left:158px;}
.field .name {padding-bottom:50px;}
.field .name label, .field .msg label {position:absolute; top:0; left:0;}
.field .name input, .field .msg textarea {margin-top:21px;}

.field .name input {width:500px; height:14px; padding:18px 20px; border:1px solid #c6c9d5; color:#888; font-size:12px; font-weight:bold; line-height:14px;}
.field .name input:focus {color:#000;}

.field .msg textarea {width:500px; height:64px; padding:18px 20px; border:1px solid #c6c9d5; color:#888; font-size:12px; line-height:1.5em;}
.field .msg textarea:focus {color:#000;}

.field .btnsubmit {position:absolute; top:91px; right:79px;}

.commentlist {overflow:hidden; width:1080px; margin:0 auto; padding-top:10px;}
.commentlist .col {float:left; position:relative; width:280px; height:340px; margin:40px 20px 0; padding:0 20px; background:url(http://webimage.10x10.co.kr/play/ground/20151123/bg_comment_box.png) no-repeat 0 0; text-align:left;}
.commentlist .col01 {background-position:0 0;}
.commentlist .col02 {background-position:-320px 0;}
.commentlist .col03 {background-position:-640px 0;}
.commentlist .col04 {background-position:100% 0;}

.commentlist .col .no {padding-top:32px; color:#888; font-size:13px; text-align:right; letter-spacing:-0.02em;}
.commentlist .col .team {margin-top:42px; color:#000; font-size:14px; line-height:1.25em; text-align:right;}
.commentlist .col .team strong {padding-left:10px; background:url(http://webimage.10x10.co.kr/play/ground/20151123/blt_circle.png) no-repeat 0 50%;}
.commentlist .col .team strong span {text-decoration:underline;}
.commentlist .col .msg {margin-top:5px; padding-left:11px; padding-left:11px; color:#000; font-size:12px; line-height:1.6em;}
.commentlist .col .id {margin-top:9px; color:#999; line-height:1.25em; text-align:right;}
.commentlist .col .mobile {padding-left:5px;}
.commentlist .col .btndelete {position:absolute; top:-14px; right:-14px; width:29px; height:29px; background-color:transparent; vertical-align:top;}

/* tiny scrollbar */
.scrollbarwrap {width:280px; margin:67px auto 0;}
.scrollbarwrap .viewport {overflow:hidden; position: relative; width:272px; height:100px;}
.scrollbarwrap .overview {position: absolute; top:0; left:0; width:100%;}
.scrollbarwrap .scrollbar {float:right; position:relative; width:3px; background-color:#eee;}
.scrollbarwrap.track {position: relative; width:3px; height:100%; background-color:#eee;}
.scrollbarwrap .thumb {overflow:hidden; position:absolute; top: 0; left:0; width:3px; height:24px; background-color:#7c7c7c; cursor:pointer;}
.scrollbarwrap .thumb .end {overflow:hidden; width:3px; height:5px;}
.scrollbarwrap .disable {display:none;}
.noSelect {user-select:none; -o-user-select:none; -moz-user-select:none; -khtml-user-select:none; -webkit-user-select:none;}

.pageWrapV15 {margin-top:50px;}
.pageWrapV15 .pageMove {display:none;}
.paging a.arrow, .paging a, .paging a.current {background-color:transparent;}

/* css3 animation */
.spin {-webkit-animation:spin 2.5s linear 2;
	-moz-animation:spin 2.5s linear 2;
	animation:spin 2.5s linear 2;
}
@-moz-keyframes spin {100% { -moz-transform: rotate(360deg);}}
@-webkit-keyframes spin {100% { -webkit-transform: rotate(360deg);}}
@keyframes spin {100% { -webkit-transform: rotate(360deg); transform:rotate(360deg);}}
</style>

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

	   if(!frm.qtext1.value || frm.qtext1.value == "10자 이내로 적어주세요." ){
	    alert("우리 팀 이름을 입력해주세요");
		document.frmcom.qtext1.value="";
	    frm.qtext1.focus();
	    return false;
	   }

	   if(!frm.qtext2.value || frm.qtext2.value == "100자 이내로 적어주세요."){
	    alert("응원의 메세지를 입력해주세요");
		document.frmcom.qtext2.value="";
	    frm.qtext2.focus();
	    return false;
	   }

		if (GetByteLength(frm.qtext2.value) > 241){
			alert("제한길이를 초과하였습니다. 100자 까지 작성 가능합니다.");
			frm.qtext2.focus();
			return;
		}


	   frm.action = "/play/groundsub/doEventSubscript67569.asp";
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
			if(document.frmcom.qtext1.value =="10자 이내로 적어주세요."){
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
			if(document.frmcom.qtext2.value =="100자 이내로 적어주세요."){
				document.frmcom.qtext2.value="";
			}
			return true;
		} else {
			jsChklogin('<%=IsUserLoginOK%>');
		}

		return false;
	}
//-->
</script>

<div class="playGr20151123">
	<article>
		<div id="titleAnimation" class="topic">
			<div class="hwrap">
				<h3>
					<span class="letter01"><img src="http://webimage.10x10.co.kr/play/ground/20151123/tit_socks_01.png" alt="싹수가" /></span>
					<span class="letter02"><img src="http://webimage.10x10.co.kr/play/ground/20151123/tit_socks_02.png" alt="노랗다" /></span>
				</h3>
				<p><img src="http://webimage.10x10.co.kr/play/ground/20151123/txt_collabo.png" alt="텐바이텐과 삭스타즈의 콜라보레이션" /></p>
				<div class="box"><img src="http://webimage.10x10.co.kr/play/ground/20151123/bg_box_title.png" alt="" /></div>
			</div>
		</div>

		<div id="planAnimation" class="plan">
			<p><img src="http://webimage.10x10.co.kr/play/ground/20151123/txt_plan.png" alt="싹수는 어떤 일이나 사람이 앞으로 잘 될 것 같은 낌새나 징조를 의미합니다. SOCKS의 발음과 비슷한 이 싹수가 노랗다고 표현하면 부정적인 표현이 되지만, 반대로 생각한다면 긍정적인 말이 될 수도 있죠. 노란 양말을 따뜻한 기운이라고 여기며 우리 팀에게 선물해보세요. 더 이상 싹수가 노랗다가 아니라 싹수가 보인다가 될 겁니다! 플레이와 함께 의미 있는 연말 선물로 따뜻한 기운과 소소한 재미를 나눠보세요 :)" /></p>
		</div>

		<div id="flipAnimation" class="intro">
			<ul>
				<li class="intro01">
					<p><img src="http://webimage.10x10.co.kr/play/ground/20151123/txt_intro_01.png" alt="박부장님의 검정 양말은 언제나 경조사만 기다리는 것 같이 검고 검다..." /></p>
					<span><img src="http://webimage.10x10.co.kr/play/ground/20151123/img_intro_animatin_01.png" alt="" /></span>
				</li>
				<li class="intro02">
					<p><img src="http://webimage.10x10.co.kr/play/ground/20151123/txt_intro_02.png" alt="김대리의 양말은 그 날의 패션과는 도통 합의점을 찾지 못한다." /></p>
					<span><img src="http://webimage.10x10.co.kr/play/ground/20151123/img_intro_animatin_02.gif" alt="" /></span>
				</li>
				<li class="intro03">
					<p><img src="http://webimage.10x10.co.kr/play/ground/20151123/txt_intro_03.png" alt="아직 젊은 막내 사원은 비가 오나, 눈이 오나 페이크 삭스만 신는다. 젊음이 좋네..." /></p>
					<span><img src="http://webimage.10x10.co.kr/play/ground/20151123/img_intro_animatin_03.png" alt="" /></span>
				</li>
			</ul>
			<p><img src="http://webimage.10x10.co.kr/play/ground/20151123/txt_plus.png" alt="사장님부터 막내 사원까지, 우리 과 선배부터 신입생까지 우리 팀에게 따뜻한 기운을 불어넣어 줄 팀싹수" /></p>
		</div>

		<div id="playwithMeAnimation" class="playwithMe">
			<div class="play">
				<p><img src="http://webimage.10x10.co.kr/play/ground/20151123/txt_play.png" alt="Play 일 할 때는 확실히! 놀 때도 확실히! 일을 잘하는 것도 좋지만, 잘 놀 줄 아는 것도 중요합니다." /></p>
				<span class="ico"><img src="http://webimage.10x10.co.kr/play/ground/20151123/ico_plus.png" alt="" /></span>
			</div>

			<div class="with">
				<p><img src="http://webimage.10x10.co.kr/play/ground/20151123/txt_with.png" alt="With 때로는 가족보다, 친구보다 더 오랜 시간을 함께 지내는 우리! 함께하는 시간 동안 서로에게 감사한 마음을 가져보세요." /></p>
				<span class="ico"><img src="http://webimage.10x10.co.kr/play/ground/20151123/ico_plus.png" alt="" /></span>
			</div>

			<div class="me">
				<p><img src="http://webimage.10x10.co.kr/play/ground/20151123/txt_play_with_me.png" alt="Play with me 양말을 신은 나와 함께 해주세요. 우리 모두 힘을 합쳐 내년에도 싹수를 키워봅시다!" /></p>
			</div>
		</div>

		<!-- rolling -->
		<div class="rolling">
			<div class="swiper">
				<div class="swiper-container">
					<div class="swiper-wrapper">
						<div class="swiper-slide swiper-slide-1"><img src="http://webimage.10x10.co.kr/play/ground/20151123/img_slide_01.jpg" alt="" /></div>
						<div class="swiper-slide swiper-slide-2"><img src="http://webimage.10x10.co.kr/play/ground/20151123/img_slide_02.jpg" alt="" /></div>
						<div class="swiper-slide swiper-slide-3"><img src="http://webimage.10x10.co.kr/play/ground/20151123/img_slide_03.jpg" alt="" /></div>
						<div class="swiper-slide swiper-slide-4"><img src="http://webimage.10x10.co.kr/play/ground/20151123/img_slide_04.jpg" alt="" /></div>
					</div>
					<div class="pagination"></div>
				</div>
			</div>
		</div>

		<!-- brand -->
		<div id="brandAnimation" class="brand">
			<div class="desc">
				<p><img src="http://webimage.10x10.co.kr/play/ground/20151123/txt_brand.png" alt="SMALL STEPS, FOR BETTER DAYS. 한껏 신경 써서 연출한 그날의 룩, 대충 고른 양말 하나로 인해 완전히 망칠 수도 있습니다. 잘 고른 양말 하나가 어쩌면 일상 전체를 바꿀 수도 있다는 믿음으로, 삭스타즈는 양말과 관련된 새로운 가치들을 여러분들께 전달하고 싶습니다." /></p>
				<span class="ico"><img src="http://webimage.10x10.co.kr/play/ground/20151123/ico_plus.png" alt="" /></span>
			</div>
			<div class="name">
				<a href="/street/street_brand_sub06.asp?makerid=sockstaz"><img src="http://webimage.10x10.co.kr/play/ground/20151123/btn_brand.png" alt="삭스타즈 브랜드 바로가기" /></a>
			</div>
		</div>

		<%' for dev msg : 코멘트 %>
		<!-- comment -->
		<div class="commentevt">
			<!-- form -->
			<div class="form">
				<form name="frmcom" method="post" onSubmit="return jsSubmitComment(this);" style="margin:0px;">
				<input type="hidden" name="eventid" value="<%=eCode%>"/>
				<input type="hidden" name="bidx" value="<%=bidx%>"/>
				<input type="hidden" name="iCC" value="<%=iCCurrpage%>"/>
				<input type="hidden" name="iCTot" value=""/>
				<input type="hidden" name="mode" value="add"/>
				<input type="hidden" name="userid" value="<%=GetEncLoginUserID%>"/>
				<input type="hidden" name="eCC" value="1">
					<fieldset>
					<legend>응원 메시지 작성 및 응모하기</legend>
						<div class="hwrap">
							<h4><img src="http://webimage.10x10.co.kr/play/ground/20151123/tit_comment.png" alt="싹수가 보인다 팀싹수 이벤트" /></h4>
							<p><img src="http://webimage.10x10.co.kr/play/ground/20151123/txt_comment.png" alt="우리 팀을 응원하는 메시지와 함께 응모해주세요! 응모해주신 분들 중 추첨을 통해 총 5팀에게 PLAY 팀싹수 PACKAGE 10족을 드립니다. 이벤트 기간은 2015년 11월 23일부터 12월 8일까지며, 당첨자 발표는 2015년 12월 9일 입니다." /></p>
							<span><img src="http://webimage.10x10.co.kr/play/ground/20151123/img_gift.jpg" alt="" /></span>
						</div>

						<div class="field">
							<div class="name">
								<label for="teamName"><img src="http://webimage.10x10.co.kr/play/ground/20151123/txt_label_name.png" alt="함께 하고픈 우리 팀 이름" /></label>
								<input type="text" id="teamName" value="10자 이내로 적어주세요." name="qtext1" placeholder="10자 이내로 적어주세요." onClick="jsChklogin11('<%=IsUserLoginOK%>');" maxlength="10"  />
							</div>

							<div class="msg">
								<label for="teamMsg"><img src="http://webimage.10x10.co.kr/play/ground/20151123/txt_label_msg.png" alt="응원의 메시지" /></label>
								<textarea cols="50" rows="6" id="teamMsg" placeholder="100자 이내로 적어주세요." name="qtext2" onClick="jsChklogin22('<%=IsUserLoginOK%>');">100자 이내로 적어주세요.</textarea>
							</div>

							<div class="btnsubmit"><input type="image" src="http://webimage.10x10.co.kr/play/ground/20151123/btn_submit.gif" alt="팀 싹 수 신청하기" /></div>
						</div>
					</fieldset>
				</form>
			</div>
			<form name="frmdelcom" method="post" action="/play/groundsub/doEventSubscript67569.asp" style="margin:0px;">
			<input type="hidden" name="eventid" value="<%=eCode%>">
			<input type="hidden" name="bidx" value="<%=bidx%>">
			<input type="hidden" name="Cidx" value="">
			<input type="hidden" name="mode" value="del">
			<input type="hidden" name="userid" value="<%=GetEncLoginUserID%>">
			</form>

			<% IF isArray(arrCList) THEN %>
			<!-- comment list -->
			<div class="commentlistWrap">
				<div id="commentlist" class="commentlist">
					<%' for dev msg : <div class="col">...</div>이 한 묶음입니다. %>
					<%' for dev msg : 한페이지당 6개 %>
					<% For intCLoop = 0 To UBound(arrCList,2) %>
						<% 
								Dim opt1 , opt2
								If arrCList(1,intCLoop) <> "" then
									opt1 = SplitValue(arrCList(1,intCLoop),"//",0)
									opt2 = SplitValue(arrCList(1,intCLoop),"//",1)
								End If 
						%>					
							<div class="col">
								<div class="no">no.<%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1)) %></div>
								<div class="team"><strong><span><%=opt1%></span></strong>팀</div>
								<div class="id">- <%=printUserId(arrCList(2,intCLoop),2,"*")%>님<% If arrCList(8,intCLoop) = "M"  then%><span class="mobile"><img src="http://webimage.10x10.co.kr/play/ground/20151123/ico_mobile.png" alt="모바일에서 작성된 글" /></span><% End If %></div>
								<div class="scrollbarwrap">
									<div class="scrollbar"><div class="track"><div class="thumb"><div class="end"></div></div></div></div>
									<div class="viewport">
										<div class="overview">
											<%' for dev msg : 응원 메시지 요기에 넣어주세요 %>
											<div class="msg"><%=opt2%></div>
										</div>
									</div>
								</div>
								<% if ((GetEncLoginUserID = arrCList(2,intCLoop)) or (GetEncLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %>
									<button type="button" class="btndelete" onclick="jsDelComment('<% = arrCList(0,intCLoop) %>');return false;"><img src="http://webimage.10x10.co.kr/play/ground/20151123/btn_del.png" alt="내가 쓴 글 삭제하기" /></button>
								<% End If %>
							</div>
					<% Next %>
				</div>

				<!-- paging -->
				<div class="pageWrapV15">
					<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
				</div>

			</div>
			<% End If %>
		</div>
	</article>
</div>

<script src="/lib/js/jquery.tinyscrollbar.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$('.scrollbarwrap').tinyscrollbar();
});

$(function(){
	/* swipe */
	var mySwiper = new Swiper('.swiper-container',{
		loop:true,
		resizeReInit:true,
		calculateHeight:true,
		pagination:'.pagination',
		paginationClickable:true,
		speed:2000,
		autoplay:3000,
		autoplayDisableOnInteraction:false,
		//mousewheelControl: true,
		simulateTouch:false
	});

	/* commentlist random bg */
	var randomList = ["col01", "col02", "col03", "col04"];
	var listSort = randomList.sort(function(){
		return Math.random() - Math.random();
	});
	$("#commentlist .col").each( function(index,item){
		$(this).addClass(listSort[index]);
	});

	/* animation effect */
	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 1000 ) {
			planAnimation();
		}
		if (scrollTop > 1400 ) {
			flipAnimation();
		}
		if (scrollTop > 2600 ) {
			playwithMeAnimation();
		}
		if (scrollTop > 4000 ) {
			brandAnimation();
		}
	});

	titleAnimation()
	$("#titleAnimation .hwrap ").css({"top":"200px"});
	$("#titleAnimation h3 span").css({"opacity":"0"});
	$("#titleAnimation h3 .letter01").css({"top":"140px"});
	$("#titleAnimation h3 .letter02").css({"top":"220px"});
	function titleAnimation() {
		$("#titleAnimation .hwrap ").delay(2200).animate({"top":"157px", "opacity":"1"},800);
		$("#titleAnimation h3 .letter01").delay(100).animate({"top":"120px", "opacity":"1"},1000);
		$("#titleAnimation h3 .letter02").delay(100).animate({"top":"249px", "opacity":"1"},1000);
		$("#titleAnimation p").delay(1500).effect("shake", {times:5},800);
	}

	$("#planAnimation p img").css({"height":"100px", "opacity":"0"});
	function planAnimation() {
		$("#planAnimation p img").delay(200).animate({"height":"527px", "opacity":"1"},1700);
	}

	function flipAnimation() {
		$("#flipAnimation ul li").delay(200).addClass("rotate", "slow");
	}

	$("#playwithMeAnimation p, #playwithMeAnimation span").css({"opacity":"0"});
	$("#playwithMeAnimation p").css({"margin-top":"7px"});
	function playwithMeAnimation() {
		$("#playwithMeAnimation .play p").delay(200).animate({"margin-top":"0", "opacity":"1"},800);
		$("#playwithMeAnimation span").delay(200).addClass("spin");
		$("#playwithMeAnimation .play span").delay(800).animate({"opacity":"1"},800);
		$("#playwithMeAnimation .with p").delay(1300).animate({"margin-top":"0", "opacity":"1"},800);
		$("#playwithMeAnimation .with span").delay(1600).animate({"opacity":"1"},800);
		$("#playwithMeAnimation .me p").delay(2300).animate({"margin-top":"0", "opacity":"1"},1200);
	}

	function brandAnimation() {
		$("#brandAnimation .desc span").delay(200).addClass("spin");
	}

	<% if eCC = "1" or iCCurrpage >= 2 then %>
		$('#commentevt').show();
		window.$('html,body').animate({scrollTop:$("#commentlist").offset().top}, 0);
	<% end if %>
});
</script>

<!-- #include virtual="/lib/db/dbclose.asp" -->