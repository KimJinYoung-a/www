<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
'########################################################
' Description :  PLAY #27.SCENT_순정한 향기 
' History : 2016-02-12 유태욱 작성
'########################################################
dim currenttime
	currenttime =  now()
	'currenttime = #02/15/2016 09:00:00#

dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  66028
Else
	eCode   =  69163
End If

dim userid, commentcount, i
	userid = GetEncLoginUserID()

commentcount = getcommentexistscount(userid, eCode, "", "", "", "Y")

dim cEComment ,blnFull, cdl, com_egCode, bidx, blnBlogURL, strBlogURL
dim iCTotCnt, arrCList,intCLoop, ecc
dim iCPageSize, iCCurrpage, isMyComm
dim iCStartPage, iCEndPage, iCTotalPage, iCx,iCPerCnt
	iCCurrpage	= requestCheckVar(Request("iCC"),10)	'현재 페이지 번호
	cdl			= requestCheckVar(Request("cdl"),3)
	blnFull		= requestCheckVar(Request("blnF"),10)
	blnBlogURL	= requestCheckVar(Request("blnB"),10)
	isMyComm	= requestCheckVar(request("isMC"),1)
	ecc	= requestCheckVar(request("ecc"),10)

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
	iCPageSize = 8
else
	iCPageSize = 8
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
.groundWrap {width:100%; background:#ebd3c8 url(http://webimage.10x10.co.kr/play/ground/20160215/bg_head.jpg) no-repeat 50% 0;}
.groundCont {position:relative; padding-bottom:0; background-color:#fff;}
.groundCont .grArea {width:100%;}
.groundCont .tagView {position:absolute; bottom:30px; left:50%; width:1100px; margin-left:-570px; padding:28px 20px 60px; border-top:1px solid #e4d1c8;}

img {vertical-align:top;}

.desc {color:#6d6262;}

.hidden {visibility:hidden; width:0; height:0;}

.topic {position:relative; height:960px; background:#fae5e3 url(http://webimage.10x10.co.kr/play/ground/20160215/bg_topic.jpg) no-repeat 50% -2px;}
.topic h3 {position:absolute; top:222px; left:50%; margin-left:-502px;}
.topic .photo {position:absolute; top:135px; left:50%; margin-left:25px;}
.topic .desc {position:absolute; bottom:0; left:50%; height:560px; margin-left:-494px;}
.topic .desc .line {position:absolute; top:0; left:0; width:6px; height:100%; background-color:#f1d9d6;}
.topic .desc p {margin:45px 0 0 55px;}
.topic .desc .btnevent {position:absolute; top:393px; left:55px;}

.story .row {position:relative;}
.story .intro .hgroup {position:absolute; top:184px; left:50%; z-index:10; width:734px; height:50px; margin-left:-367px; text-align:center;}
.story .intro .hgroup span {position:absolute; bottom:0; height:3px; background-color:#86564c;}
.story .intro .hgroup .line1 {left:0; width:266px;}
.story .intro .hgroup .line2 {right:0; width:281px;}
.story .intro .desc {height:911px; background:#f6f1ec url(http://webimage.10x10.co.kr/play/ground/20160215/bg_color_01.jpg) repeat-x 0 0;}
.story .desc .bg {position:absolute; top:0; left:50%; margin-left:-960px;}

.story .desc {overflow:hidden; position:relative; z-index:5; width:100%; height:911px; color:#6d6262;}

.story .mike {position:absolute; top:450px; left:50%; z-index:10; margin-left:-443px; text-align:center;}
.story .mike .ico img {animation:leftright; animation-iteration-count:infinite; animation-duration:1s; transform:rotate(0deg);}
@keyframes leftright {
	0% {transform:rotate(-1deg);}
	50% {transform:rotate(15deg);}
	100% {transform:rotate(-1deg);}
}

.story .mike .line {position:absolute; top:70px; left:50%; width:4px; height:280px; margin-left:-2px; background-color:#f0edeb;}
.story .itemwrap {position:absolute; top:1105px; left:50%; width:300px; height:425px; margin-left:190px; z-index:10;}
.story .item img {position:absolute; top:185px; left:25px; transition:transform .8s ease-out;}
.story .item:hover img {transform:rotate(360deg);}
.story .lyPerfume {position:absolute; left:-380px; top:-63px; z-index:20;}
.story .lyPerfume a {position:absolute; top:194px; left:20px; width:340px; height:160px; text-indent:-9999em;}
.story .lyPerfume .btnclose {position:absolute; top:234px; left:391px; background-color:transparent;}

.story .story1st .desc {height:1530px; background:#e0d5d0 url(http://webimage.10x10.co.kr/play/ground/20160215/bg_color_02_v1.jpg) repeat-x 0 0;}
.story .story1st .desc .word {position:absolute; top:213px; left:50%; z-index:20; margin-left:-330px;}
.story .story1st .gallery {position:absolute; top:500px; left:50%; z-index:20; width:984px; margin-left:-365px;}
.story .story1st .gallery .photo1 {position:absolute; top:0; left:0;}
.story .story1st .gallery .photo2 {position:absolute; top:260px; right:0;}
.story .story1st .mike {top:1040px;}
.story .story1st .mike .line {height:240px;}

.story .story2nd .desc {height:2125px; background:#e0d5d0 url(http://webimage.10x10.co.kr/play/ground/20160215/bg_color_03_v1.jpg) repeat-x 0 0;}
.story .story2nd .desc .word {position:absolute; top:208px; left:50%; z-index:20; margin-left:54px;}
.story .story2nd .gallery {position:absolute; top:645px; left:50%; z-index:20; margin-left:-635px;}
.story .story2nd .mike {top:1270px;}
.story .story2nd .mike .line {height:380px;}
.story .story2nd .itemwrap {top:1500px;}
.story .story2nd .item img {top:183px; left:50px;}
.story .story2nd .film {position:absolute; bottom:74px; left:50%; z-index:10; margin-left:-442px;}
.story .story2nd .lyPerfume {left:-360px;}
.story .story2nd .btnclose {top:232px; left:395px;}

.movie .desc {overflow:hidden; position:relative; z-index:5; height:1414px; border-bottom:10px solid #e0c3ba; background:#eed6cd url(http://webimage.10x10.co.kr/play/ground/20160215/bg_color_pink.jpg) repeat-x 0 0;}
.movie .poster {position:absolute; top:150px; left:50%; z-index:10; width:502px; height:673px; margin-left:-546px;}
.movie .poster .poster1 {position:absolute; top:0; left:0; z-index:15;}
.movie .poster .poster2 {position:absolute; top:85px; left:55px;}
.movie .video {position:absolute; top:488px; left:50%; z-index:10; margin-left:-30px;}

.commentevt {min-height:1338px; padding-top:92px; background:#f9e5dc url(http://webimage.10x10.co.kr/play/ground/20160215/bg_paper_pink.jpg) repeat 50% 0;}

.form {position:relative; width:1146px; margin:0 auto;}
.form .perfume {position:absolute; top:352px; left:370px;}
.form .field {position:absolute; top:68px; left:570px; width:480px;}
.form .field input {vertical-align:top;}
.form .field ul {overflow:hidden;}
.form .field ul li {float:left; margin-right:40px; text-align:center;}
.form .field ul li label {display:block;}
.form .field p {margin-top:26px;}
.form .field .itext {position:absolute; top:298px; left:0; width:210px; height:40px; padding:0 15px; background-color:#fce2db; color:#000; font-size:20px; font-family:'Dotum', 'Verdana'; font-weight:bold; line-height:40px;}
::-webkit-input-placeholder {color:#fff;}
::-moz-placeholder {color:#fff;} /* firefox 19+ */
:-ms-input-placeholder {color:#fff;} /* ie */
input:-moz-placeholder {color:#fff;}
.form .field .btnsubmit {position:relative; width:529px; margin-top:30px; text-align:right; cursor:pointer;}
.form .field .btnsubmit span {position:absolute; top:31px; left:0; width:280px; height:1px; background-color:#e6e6e6; transition:all 0.8s;}
.form .field .btnsubmit:hover span {background-color:#e88469;}

.commentlist {width:1120px; margin:0 auto;}
.commentlist .total {padding-right:18px; padding-bottom:6px; border-bottom:2px solid #eed7cd; color:#92796d; text-align:right;}
.commentlist ul {overflow:hidden; padding-top:42px;}
.commentlist ul li {float:left; position:relative; width:201px; height:99px; margin:0 4px 7px; padding:68px 30px 45px 41px; background:url(http://webimage.10x10.co.kr/play/ground/20160215/bg_comment_box.png) no-repeat 50% 0; font-family:'Dotum', 'Verdana';}
.commentlist ul li span {display:block;}
.commentlist ul li p span {margin-bottom:10px;}
.commentlist ul li p b {color:#f46d52; font-size:16px; line-height:19px;}
.commentlist ul li .id {margin-top:40px; padding-right:13px; color:#666; font-size:11px; line-height:11px; text-align:right;}
.commentlist ul li .btndel {position:absolute; top:17px; right:31px;}

.pageWrapV15 {margin-top:38px;}
.pageWrapV15 .pageMove {display:none;}
.paging a.arrow, .paging a, .paging a.current {background-color:transparent;}

/* css3 animation */
.animated {animation-duration:1.5s; animation-fill-mode:both; animation-iteration-count:1;}

.lightSpeedIn {animation-name: lightSpeedIn; animation-timing-function:ease-out;}
@keyframes lightSpeedIn {
	0% {transform:translateX(5%) skewX(0deg); opacity:0;}
	100% {transform:translateX(0%) skewX(0deg); opacity:1;}
}

.bounce {animation-duration:2s; animation-name:bounce; animation-iteration-count:infinite;}
@keyframes bounce {
	0%, 20%, 50%, 80%, 100% {transform: translateY(0);}
	40% {transform: translateY(-10px);}
	60% {transform: translateY(-5px);}
}
</style>
<script type="text/javascript">
$(function(){
	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 300 ) {
			titleEffect();
		}
	});

	$(".topic .desc p").css({"margin-left":"60px", "opacity":"0"});
	$(".topic .desc .btnevent").css({"margin-top":"5px", "opacity":"0"});
	$(".topic .desc .line").css({"height":"0"});
	function titleEffect() {
		$(".topic .desc p").delay(300).animate({"margin-left":"55px", "opacity":"1"},800);
		$(".topic .desc .line").delay(800).animate({"height":"100%"},1000);
		$(".topic .desc .btnevent").delay(900).animate({"margin-top":"0", "opacity":"1"},1000);
	}

	$("#btnevent").click(function(event){
		event.preventDefault();
		window.parent.$('html,body').animate({scrollTop:$(this.hash).offset().top},1000);
	});

	$(".lyPerfume").hide();
	$(".itemwrap .item").click(function(){
		$(this).next().show();
		$(".itemwrap .item img").css({"opacity":"0"});
		return false;
	});
	$(".itemwrap .btnclose").click(function(){
		$(".itemwrap .item img").css({"opacity":"1"});
		$(".lyPerfume").hide();
	});

	// Label Select
	$(".form label").click(function(){
		labelID = $(this).attr("for");
		$('#'+labelID).trigger("click");
	});
});

<% if Request("iCC") <> "" or request("ecc") <> "" then %>
	$(function(){
		var val = $('#commentlist').offset();
	    $('html,body').animate({scrollTop:val.top},100);
	});
<% end if %>

function jsGoComPage(iP){
	document.frmcom.iCC.value = iP;
	document.frmcom.iCTot.value = "<%=iCTotCnt%>";
	document.frmcom.submit();
}

function jsSubmitComment(frm){
	<% If IsUserLoginOK() Then %>
		<% If not( left(currenttime,10)>="2016-02-15" and left(currenttime,10)<"2016-02-22" ) Then %>				//날짜 확인!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
			alert("이벤트 응모 기간이 아닙니다.");
			return false;
		<% else %>
			<% if commentcount>0 then %>																						//숫자 확인!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
				alert("한 ID당 한번만 참여할 수 있습니다.");
				return false;
			<% else %>
				var tmpdateval='';
				for (var i=0; i < frm.txtcomm1.length; i++){
					if (frm.txtcomm1[i].checked){
						tmpdateval = frm.txtcomm1[i].value;
					}
				}
				if (tmpdateval==''){
					alert('첫사랑과 어울리는 향기를\n선택해 주세요.');
					return false;
				}

				if (frm.txtcomm2.value == '' || GetByteLength(frm.txtcomm2.value) > 20 || frm.txtcomm2.value == '10자 내로 입력'){
					alert("띄어쓰기 포함\n최대 한글 10자 이내로 적어주세요.");
					frm.txtcomm2.focus();
					return false;
				}

				frm.spoint.value = tmpdateval
				frm.txtcomm.value = frm.txtcomm2.value
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
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return false;
		}
		return false;
	}

	if (frmcom.txtcomm2.value == '10자 내로 입력'){
		frmcom.txtcomm2.value = '';
	}

}
</script>
<div class="groundCont">
	<div class="grArea">
		<div class="playGr20160215">
			<div class="topic">
				<h3 class="animated lightSpeedIn"><img src="http://webimage.10x10.co.kr/play/ground/20160215/tit_unforgettable_scent.png" alt="순정한 향기" /></h3>
				<span class="photo"><img src="http://webimage.10x10.co.kr/play/ground/20160215/img_photo_together.png" alt="" /></span>
				<div class="desc">
					<span class="line"></span>
					<p><img src="http://webimage.10x10.co.kr/play/ground/20160215/txt_topic.png" alt="텐바이텐 플레이 스물일곱 번째 주제는 기억을 가장 불러 일으키기 쉬운 매개체, 향기입니다. 흘러나오는 라디오 속 목소리에 첫사랑을 느끼는 영화 순정 향기 속에서 그 시절의 감성을 찾는 플레이. 두 매개체는 다른 모습이지만 순수했던 기억을 떠올리며 추억 여행을 하게 만든다는 점이 참 닮아있습니다. 오늘, 텐바이텐 플레이는 영화 속 내용처럼 라디오 속 목소리를 들으며 시작됩니다." /></p>
					<a href="#commentevt" id="btnevent" class="btnevent"><img src="http://webimage.10x10.co.kr/play/ground/20160215/btn_event.png" alt="이벤트 참여하기" /></a>
				</div>
			</div>

			<div class="story">
				<div class="row intro">
					<div class="hgroup">
						<h4><img src="http://webimage.10x10.co.kr/play/ground/20160215/tit_story.png" alt="DJ 텐텐의 볼륨을 올려요"/></h4>
						<span class="line1 animated bounce"></span>
						<span class="line2 animated bounce"></span>
					</div>
					<div class="desc">
						<p class="bg"><img src="http://webimage.10x10.co.kr/play/ground/20160215/bg_01.jpg" alt="네, DJ텐바이텐의 볼륨을 올려요입니다. 오늘은 첫사랑의 향수가 담긴 사연들이 많이 올라왔네요. 대부분의 사람에게 첫사랑은 행복한 기억보단 미련으로 더 많이 남는 것 같아요. 사연을 들으며 그때 그 시절 아련한 추억 속으로 여행을 떠나볼까요?" /></p>
					</div>
					<div class="mike">
						<span class="ico"><img src="http://webimage.10x10.co.kr/play/ground/20160215/ico_mike.png" alt="" /></span>
						<span class="line"></span>
					</div>
				</div>

				<div class="row story1st">
					<div class="desc">
						<h5 class="hidden">첫번째 사연, 범실의 이야기</h5>
						<p class="word"><img src="http://webimage.10x10.co.kr/play/ground/20160215/txt_story_01.png" alt="안녕하세요. 저는 범실이라고 합니다. 제 첫사랑은 너무 떨려 말도 못 건넸지만, 그 아이에게 모든 것을 다 내어주고 싶을 만큼 서로를 순수하게 좋아할 수 있던 아이, 수옥이었습니다. 그때 그 시절이 그립네요... " /></p>
						<p class="bg"><img src="http://webimage.10x10.co.kr/play/ground/20160215/bg_txt_story_01_v3.jpg" alt="모든 것을 다 내어주고 싶었다니. 여러분, 풋풋한 사랑의 향기가 여기까지 느껴지지 않아요? 사연을 보내주신 범실님께는 파릇파릇한 풋사랑의 향기가 느껴지는 [나가 옆에서 지켜 줄거여 평생] 향수를 선물로 드릴게요!" /></p>
					</div>
					<div class="itemwrap">
						<a href="#lyPerfume01" class="item"><img src="http://webimage.10x10.co.kr/play/ground/20160215/btn_plus.png" alt="나가 옆에서 지켜줄거여 평생 향수" /></a>
						<div id="lyPerfume01" class="lyPerfume">
							<p><img src="http://webimage.10x10.co.kr/play/ground/20160215/txt_perfume_01.png" alt="독특한 마일드 플로럴 아침 햇살을 머금은 프리지아 천연감" /></p>
							<a href="http://www.le-plein.co.kr/" target="_blank" title="르플랑 홈페이지로 이동 새창">르플랑은 국내외 유명 아티스트들과 함께 협업하여 진행하는 향기 프로젝트 브랜드입니다.</a>
							<button type="button" class="btnclose"><img src="http://webimage.10x10.co.kr/play/ground/20160215/btn_close.png" alt="닫기" /></button>
						</div>
					</div>
					<ul class="gallery">
						<li class="photo1"><img src="http://webimage.10x10.co.kr/play/ground/20160215/img_photo_beomsil_01.png" alt="" /></li>
						<li class="photo2"><img src="http://webimage.10x10.co.kr/play/ground/20160215/img_photo_beomsil_02.png" alt="" /></li>
					</ul>
					<div class="mike">
						<span class="ico"><img src="http://webimage.10x10.co.kr/play/ground/20160215/ico_mike.png" alt="" /></span>
						<span class="line"></span>
					</div>
				</div>

				<div class="row story2nd">
					<div class="desc">
						<h5 class="hidden">첫번째 사연, 수옥의 이야기</h5>
						<p class="word"><img src="http://webimage.10x10.co.kr/play/ground/20160215/txt_story_02.png" alt="안녕하세요 DJ 텐바이텐님! 저는 수옥이라고 합니다. 저에게 첫사랑은 아쉬움이에요. 그 고마움과 그 그리움을.. 사랑이란 말로 전하지 못했을 때, 평생 아쉬움으로 남거든요. 23년 전 그 사람이 아직도 떠올라요. 한 번 만이라도 그 마음을 전할 수 있다면 얼마나 좋을 까요?" /></p>
						<p class="bg"><img src="http://webimage.10x10.co.kr/play/ground/20160215/bg_txt_story_02_v2.jpg" alt="" alt="두 번째 사연, 수옥님의 이야기 잘 들었어요. 전하지 못하는 사랑은, 수많은 시간이 흘러도 아쉬움으로 남는 다는 말이 공감 되네요. 사연을 들려주신 수옥님께는 이름마저 그리움의 잔잔한 향기가 풍겨오는 [세상 천지가 우리 둘 밖에 없는 것 같다야] 향수를 선물로 드리겠습니다!" /></p>
					</div>

					<div class="itemwrap">
						<a href="#lyPerfume02" class="item"><img src="http://webimage.10x10.co.kr/play/ground/20160215/btn_plus.png" alt="세상 천지가 우리 둘 밖에 없는 것 같다야 향수" /></a>
						<div id="lyPerfume02" class="lyPerfume">
							<p><img src="http://webimage.10x10.co.kr/play/ground/20160215/txt_perfume_02.png" alt="첫향은 상쾌하고 시원한 눈꽃 결정 그리고 설레임, 잔향은 바닐라의 달콤함" /></p>
							<a href="http://www.le-plein.co.kr/" target="_blank" title="르플랑 홈페이지로 이동 새창">르플랑은 국내외 유명 아티스트들과 함께 협업하여 진행하는 향기 프로젝트 브랜드입니다.</a>
							<button type="button" class="btnclose"><img src="http://webimage.10x10.co.kr/play/ground/20160215/btn_close.png" alt="닫기" /></button>
						</div>
					</div>
					<div class="gallery"><img src="http://webimage.10x10.co.kr/play/ground/20160215/img_photo_suok.png" alt="" /></div>
					<div class="mike">
						<span class="ico"><img src="http://webimage.10x10.co.kr/play/ground/20160215/ico_mike.png" alt="" /></span>
						<span class="line"></span>
					</div>
					<span class="film"><img src="http://webimage.10x10.co.kr/play/ground/20160215/ico_film.gif" alt="" /></span>
				</div>
			</div>

			<div class="movie">
				<div class="desc">
					<div class="bg"><img src="http://webimage.10x10.co.kr/play/ground/20160215/bg_txt_moive_v1.jpg" alt="두 분의 사연을 듣고 나니, 딱 어울리는 영화 한편이 생각 나네요. 오늘 소개할 영화는 바로 두 분의 마음과 닮은 영화 순정 입니다!" /></div>
					<div class="hidden">
						<h4>영화 순정</h4>
						<p>23년 전 첫사랑의 목소리가 라디오에서 흘러나왔다…</p>
						<ul>
							<li>장르 : 드라마</li>
							<li>감독 : 이은희</li>
							<li>출연 : 도경수, 김소현, 연준석, 이다윗, 주다영 등</li>
							<li>개봉 : 2016년 2월 24일</li>
						</ul>
						<h5>SYNOPSYS</h5>
						<p>라디오 DJ 형준은 어느 날, 생방송 중에 도착한 낯익은 이름의 편지 한 통에 당혹스러움을 감추지 못한다. 사연을 보낸 이는 바로 23년 전 가슴 한 켠에 묻어두었던 첫사랑의 이름 정수옥. 그녀의 손글씨로 정성스레 쓰인 노트를 보며 형준은 잊고 지냈던 23년 전의 기억들이 되살아나기 시작하는데…</p>
						<p>1991년, 여름방학을 맞아 수옥이 기다리고 있는 고향 섬마을에 모인 범실과 친구들. 다섯이어야 오롯이 하나가 되는 이들은 함께여서 더욱 빛나는 시간들로 여름날의 추억을 쌓아간다. 그리고, 수옥이 원하는 것이라면 뭐든지 해주고 싶은 범실의 마음… 열일곱 범실과 수옥에게 잊을 수 없는 특별한 순간이 찾아온다!</p>
						<p>과거와 현재를 넘나드는 단 하나의 첫사랑! 그 해 여름, 아련한 추억 속으로 음악비행이 시작된다!</p>
					</div>
					<div class="poster">
						<span class="poster1 swing"><img src="http://webimage.10x10.co.kr/play/ground/20160215/img_poster_01.png" alt="" /></span>
						<span class="poster2"><img src="http://webimage.10x10.co.kr/play/ground/20160215/img_poster_02.png" alt="" /></span>
					</div>
					<div class="video">
						<iframe src="http://serviceapi.rmcnmv.naver.com/flash/outKeyPlayer.nhn?vid=799FF694743CD144128F56CCFFDC8184EB86&outKey=V122c219c12c63c465192062e833f97b7da2e5d408f06cb50b1af062e833f97b7da2e&controlBarMovable=true&jsCallable=true&skinName=default" width="512" height="293" frameborder="0" title="영화 순정 예고편" webkitallowfullscreen="" mozallowfullscreen="" allowfullscreen=""></iframe>
					</div>
				</div>
			</div>

			<div id="commentevt" class="commentevt">
				<div class="form">
					<form name="frmcom" method="post" onSubmit="return false;" style="margin:0px;">
					<input type="hidden" name="eventid" value="<%=eCode%>">
					<input type="hidden" name="com_egC" value="<%=com_egCode%>">
					<input type="hidden" name="bidx" value="0">
					<input type="hidden" name="iCC" value="<%=iCCurrpage%>">
					<input type="hidden" name="iCTot" value="">
					<input type="hidden" name="mode" value="add">
					<input type="hidden" name="spoint" value="0">
					<input type="hidden" name="isMC" value="<%=isMyComm%>">
					<% If InStr(Request.ServerVariables("QUERY_STRING"), "&ecc=1") > 0 Then %>
					<% Else %>
						<input type="hidden" name="hookcode" value="&ecc=1">
					<% End If %>
					<input type="hidden" name="txtcomm">
						<fieldset>
						<legend>당신의 첫사랑과 어울리는 향기를 선택하고 느낌 적기</legend>
							<p><img src="http://webimage.10x10.co.kr/play/ground/20160215/txt_comment.png" alt="당신의 첫사랑과 어울리는 향기를 고르고 느낌을 공유해주세요. 추첨을 통해 150분에게 영화 순정 전용 예매권과 순정한 향기가 담긴 향수를 선물로 드립니다." /></p>
							<span class="perfume"><img src="http://webimage.10x10.co.kr/play/ground/20160215/img_perfume.png" alt="" /></span>
							<div class="field">
								<ul>
									<li>
										<label for="perfume01"><img src="http://webimage.10x10.co.kr/play/ground/20160215/txt_label_01.jpg" alt="범실의 이야기가 담긴 향기" /></label>
										<input type="radio" id="perfume01" name="txtcomm1" value="1" />
									</li>
									<li>
										<label for="perfume02"><img src="http://webimage.10x10.co.kr/play/ground/20160215/txt_label_02.jpg" alt="수옥과 범실의 추억이 담긴 향기" /></label>
										<input type="radio" id="perfume02" name="txtcomm1" value="2" />
									</li>
								</ul>
								<p><img src="http://webimage.10x10.co.kr/play/ground/20160215/txt_my_first_love.png" alt="나에게 첫사랑은" /></p>
								<input type="text" title="나의 첫사랑에 대한 느낌 적기" name="txtcomm2" id="txtcomm2" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();" value="<%IF NOT IsUserLoginOK THEN%>10자 내로 입력<% else %>10자 내로 입력<%END IF%>" class="itext" />
								<div class="btnsubmit">
									<span></span>
									<input type="image" src="http://webimage.10x10.co.kr/play/ground/20160215/btn_submit.png" onclick="jsSubmitComment(document.frmcom); return false;" alt="응모하기" />
								</div>
							</div>
						</fieldset>
					</form>

					<form name="frmdelcom" method="post" action = "/event/lib/comment_process.asp" style="margin:0px;">
						<input type="hidden" name="eventid" value="<%=eCode%>">
						<input type="hidden" name="com_egC" value="<%=com_egCode%>">
						<input type="hidden" name="bidx" value="<%=bidx%>">
						<input type="hidden" name="Cidx" value="">
						<input type="hidden" name="mode" value="del">
						<% If InStr(Request.ServerVariables("QUERY_STRING"), "&ecc=1") > 0 Then %>
						<% Else %>
							<input type="hidden" name="hookcode" value="&ecc=1">
						<% End If %>
					</form>
				</div>

				<% IF isArray(arrCList) THEN %>
					<div class="commentlist" id="commentlist">
						<p class="total"><b>Total</b> <%= iCTotCnt %></p>
						<ul>
							<% For intCLoop = 0 To UBound(arrCList,2) %>
								<li>
									<p>
										<span><img src="http://webimage.10x10.co.kr/play/ground/20160215/txt_first_love_is_01.png" alt="나에게 첫사랑은" /></span>
										<b><%=ReplaceBracket(db2html(arrCList(1,intCLoop)))%></b>
										<img src="http://webimage.10x10.co.kr/play/ground/20160215/txt_first_love_is_02.png" alt="다." />
									</p>
									<span class="id"><%=printUserId(arrCList(2,intCLoop),2,"*")%> 
										<% If arrCList(8,intCLoop) = "M"  then%>
											<img src="http://webimage.10x10.co.kr/play/ground/20160215/ico_mobile.png" alt="모바일에서 작성된 글" />
										<% end if %>
									</span>
									<% if ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %>
										<button type="button" onclick="jsDelComment('<% = arrCList(0,intCLoop) %>'); return false;" class="btndel"><img src="http://webimage.10x10.co.kr/play/ground/20160215/btn_del.png" alt="삭제" /></button>
									<% end if %>
								</li>
							<% next %>
						</ul>
						<div class="pageWrapV15">
							<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
						</div>
					</div>
				<% end if %>
			</div>
		</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->