<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<%
'####################################################
' Description : PLAY 28 W
' History : 2016-03-02 이종화 생성
'####################################################
Dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  66033
Else
	eCode   =  69489
End If

dim com_egCode, bidx  , commentcount
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


	Dim snpTitle, snpLink, snpPre, snpTag, snpTag2
	snpTitle = Server.URLEncode("스물여덟 번째 이야기 SHOWER")
	snpLink = Server.URLEncode("http://www.10x10.co.kr/play/playGround.asp?gidx=28&gcidx=110")
	snpPre = Server.URLEncode("텐바이텐 그라운드")
	snpTag = Server.URLEncode("텐바이텐 " & Replace("#28 스물여덟 번째 이야기 SHOWER"," ",""))
	snpTag2 = Server.URLEncode("#10x10")

	commentcount = getcommentexistscount(GetEncLoginUserID, eCode, "", "", "", "Y")

%>
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/section.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<style type="text/css">
.groundWrap {width:100%; background-color:#ffc427;}
.groundCont {position:relative; padding-bottom:0; background-color:#fff;}
.groundCont .grArea {width:100%;}
.groundCont .tagView {display:none; width:1100px; margin-top:30px; padding:28px 20px 60px;}

img {vertical-align:top;}

.topic {position:relative; height:1384px; background:#2a292c url(http://webimage.10x10.co.kr/play/ground/20160307/bg_light_off.jpg) no-repeat 50% 0;}
.topic .on {position:absolute; top:0; left:0; width:100%; height:1387px; background:#2a292c url(http://webimage.10x10.co.kr/play/ground/20160307/bg_light_on.jpg) no-repeat 50% 0;}
.topic .on {animation-name:twinkle; animation-iteration-count:infinite; animation-duration:5s; animation-fill-mode:both;}
@keyframes twinkle {
	0% {opacity:0;}
	50% {opacity:1;}
	100% {opacity:0;}
}

.topic .playMusic {position:absolute; top:28px; left:50%; margin-left:447px;}
.topic h3 {position:absolute; top:395px; left:50%; width:324px; height:324px; margin-left:-162px;}
.topic h3 span {position:absolute; display:block; background:url(http://webimage.10x10.co.kr/play/ground/20160307/tit_talk.png) no-repeat 50% 0; text-indent:-9999em;}
.topic h3 .letter1 {top:0; left:0; width:324px; height:15px;}
.topic h3 .letter2 {top:122px; left:0; width:142px; height:73px; background-position:0 -122px;}
.topic h3 .letter3 {top:122px; right:0; width:142px; height:73px; background-position:100% -122px;}
.topic h3 .letter4 {bottom:0; left:0; width:324px; height:82px; background-position:100% 100%;}
.topic .come {position:absolute; top:877px; left:50%; margin-left:-260px;}
.topic .come {animation-name:move; animation-duration:2s; animation-fill-mode:both; animation-iteration-count:1; animation-delay:3.5s;}

@keyframes fadeInSlideUp {
	0% {transform: translateY(0);}
	50% {transform: translateY(15px);}
	100% {transform: translateY(0);}
}
.fadeInSlideUp{animation:fadeInSlideUp 1s cubic-bezier(0.2, 0.3, 0.25, 0.9) forwards; animation-delay:1s; animation-iteration-count:2;}
.topic h3 .letter3 {animation-delay:2s;}

@keyframes move {
	0% {transform:translateY(50px); opacity:0.5;}
	100% {transform:translateY(0); opacity:1;}
}

.preview {overflow:hidden; position:relative; height:2135px; padding-top:182px; background:#2c2b2b url(http://webimage.10x10.co.kr/play/ground/20160307/bg_dark.jpg) no-repeat 50% 0; text-align:center;}
.preview h4 {position:relative; z-index:5;}
.preview span {display:block;}
.preview .left {position:absolute; top:150px; left:50%; z-index:5; width:952px; margin-left:-1103px;}
.preview .left .frame {position:absolute; top:0; left:0;}
.preview .left .light {position:absolute; top:502px; left:453px;}
.preview .left .carefully {position:absolute; top:684px; left:560px; z-index:5;}
.preview .left .carefully span {position:absolute; top:0; left:0;}
.preview .mother {position:absolute; top:485px; left:50%; z-index:5; margin-left:38px;}
.preview .running {position:absolute; top:1035px; left:50%; z-index:5; margin-left:36px;}
.preview .right {position:absolute; top:1265px; left:50%; z-index:5; width:995px; margin-left:241px;}
.preview .right .frame {position:absolute; top:0; right:0;}
.preview .right .light {position:absolute; top:160px; left:-195px;}
.preview .right .adult {position:absolute; top:255px; left:20px; z-index:5;}
.preview .slow {position:absolute; bottom:295px; left:50%; z-index:5; margin-left:-495px;}

.preview #cursor {position:absolute; z-index:0; width:749px; height:671px; background:url(http://webimage.10x10.co.kr/play/ground/20160307/img_light_cursor.png) no-repeat 50% 0;}

.book {overflow:hidden; position:relative; height:1240px; background-color:#ffc425; text-align:center;}
.book .album {position:relative; width:936px; margin:0 auto;}
.book .album .video {position:absolute; top:30px; right:70px;}
.book .gallery {overflow:hidden; position:absolute; bottom:0; left:50%; width:1920px; height:453px; margin-left:-960px;}
.book .gallery li {position:absolute; top:0;}
.book .gallery li.gallery1 {left:0;}
.book .gallery li.gallery2 {left:620px;}
.book .gallery li.gallery3 {right:0;}

.about {position:relative; height:492px; background-color:#ffc425; text-align:center;}
.about .shareSns {position:absolute; top:224px; left:50%; width:165px; margin-left:316px;}
.about .shareSns li {float:left; width:48px; margin-right:7px;}
.about .shareSns li a {display:block; position:relative; width:100%; height:48px; background:url(http://webimage.10x10.co.kr/play/ground/20160307/ico_sns.png) no-repeat 0 0; color:#000; font-size:11px; line-height:48px; text-align:center;}
.about .shareSns li.twitter a {background-position:-55px 0;}
.about .shareSns li.link a {background-position:100% 0;}
.about .shareSns li a span {visibility:hidden; position:absolute; top:-60px; left:-10px; z-index:5; width:60px; height:60px; border:4px solid #fff; border-radius:50%; background:rgba(255,255,255,0.3); text-shadow:1px 1px 1px rgba(0, 0, 0, 0.1); font-size:11px; line-height:60px;}
.about .shareSns li a span {transform:translateX(0) rotate(0deg) scale(0.3); transition:all 0.3s ease-in-out;}
.about .shareSns li a:hover {text-decoration:none;}
.about .shareSns li a:hover span {visibility:visible; opacity:0.9; transform:translate(0px) rotate(0deg) scale(1);}

.commentevt {padding-bottom:120px; background:#333 url(http://webimage.10x10.co.kr/play/ground/20160307/bg_chair.png) no-repeat 50% 0; text-align:center;}

.form {overflow:hidden; width:894px; margin:0 auto;}
.form textarea {overflow:hidden; float:left; width:660px; height:58px; padding:10px 25px; border:0; background-color:#232323; color:#fff; font-family:'새굴림', 'Verdana'; font-size:20px; font-weight:bold; line-height:1.5em;}
.form .btnSubmet {float:left;}

.commentlist {width:1210px; margin:86px auto 0; border-top:1px solid #292929;}
.commentlist .total {margin-top:10px; padding-right:32px; color:#ffc427; font-family:'Verdana'; font-size:11px; text-align:right;}
.commentlist ul {overflow:hidden; width:1232px; margin-top:20px; margin-right:-92px; padding-left:14px;}
.commentlist ul li {float:left; position:relative; width:182px; height:170px; margin-right:50px; padding:50px 42px 0 34px; background:url(http://webimage.10x10.co.kr/play/ground/20160307/bg_commnet_box.png) no-repeat 50% 0; text-align:left;}
.commentlist ul li:nth-child(5),
.commentlist ul li:nth-child(6),
.commentlist ul li:nth-child(7),
.commentlist ul li:nth-child(8) {background-position:50% 100%;}
.commentlist ul li .no, .commentlist ul li .id {color:#222; font-family:'Verdana'; font-size:11px;}
.commentlist ul li .no {position:absolute; top:50px; right:42px;}
.commentlist ul li .no img {vertical-align:0px;}
.commentlist ul li .id {display:block; padding-bottom:4px; border-bottom:1px solid #dfdfdf;}
.commentlist ul li .msg {color:#505050; font-family:dotum, 'Verdana'; font-size:14px; font-weight:bold; line-height:1.313rem;}
.commentlist ul li .btndel {position:absolute; top:25px; right:25px; background-color:transparent;}

/* tiny scrollbar */
.scrollbarwrap {width:182px; margin:15px auto 0;}
.scrollbarwrap .viewport {overflow:hidden; position: relative; width:177px; height:78px; padding-bottom:3px;}
.scrollbarwrap .overview {position: absolute; top:0; left:0; width:100%;}
.scrollbarwrap .scrollbar {float:right; position:relative; width:3px; background-color:#ddd;}
.scrollbarwrap.track {position: relative; width:3px; height:100%; background-color:#ddd;}
.scrollbarwrap .thumb {overflow:hidden; position:absolute; top: 0; left:0; width:3px; height:24px; background-color:#3f3f3f; cursor:pointer;}
.scrollbarwrap .thumb .end {overflow:hidden; width:3px; height:5px;}
.scrollbarwrap .disable {display:none;}
.noSelect {user-select:none; -o-user-select:none; -moz-user-select:none; -khtml-user-select:none; -webkit-user-select:none;}

/* paging */
.pageWrapV15 {margin-top:50px;}
.pageWrapV15 .pageMove {display:none;}
.paging a {width:36px; height:36px; margin:0 4px; border:0; background:url(http://webimage.10x10.co.kr/play/ground/20160307/bg_paging_circle.png) no-repeat 0 0;}
.paging a span {height:36px; line-height:36px; color:#ffc427;}
.paging a.current {background-position:0 100%;}
.paging a.current span {color:#000;}
.paging a:hover, .paging a.arrow, .paging a, .paging a.current, .paging a.current:hover {border:0; background-color:transparent;}
.paging .first, .paging .end {display:none;}
.paging a.arrow span {background:none;}
.paging .prev, 
.paging .next {background:url(http://webimage.10x10.co.kr/play/ground/20160307/btn_nav.png) no-repeat 0 0;}
.paging .next {background-position:100% 0;}
</style>
<script type="text/javascript">
<!--
$(document ).mousemove(function( event ) {
	$("#cursor").position({
		my: "center",
		at: "center",
		of: event,
		collision: "none"
	});
});


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

		<% if commentcount>0 then %>
			alert("한 ID당 한번만 참여할 수 있습니다.");
			return false;
		<% else %>
		   if(!frm.txtcomm.value){
			alert("작가 이석원에게 하고 싶은 질문을 입력해주세요");
			document.frmcom.txtcomm.value="";
			frm.qtext2.focus();
			return false;
		   }

			if (GetByteLength(frm.txtcomm.value) > 100){
				alert("제한길이를 초과하였습니다. 100자 까지 작성 가능합니다.");
				frm.txtcomm.focus();
				return;
			}

		   frm.action = "/play/groundsub/doEventSubscript69489.asp";
		   return true;
		 <% end if %>
	}

	function jsDelComment(cidx)	{
		if(confirm("삭제하시겠습니까?")){
			document.frmdelcom.Cidx.value = cidx;
	   		document.frmdelcom.submit();
		}
	}

	function jsChklogin22(blnLogin)
	{
		if (blnLogin == "True"){
			if(document.frmcom.txtcomm.value =="100자 이내로 적어주세요."){
				document.frmcom.txtcomm.value="";
			}
			return true;
		} else {
			jsChklogin('<%=IsUserLoginOK%>');
		}

		return false;
	}

	function copy_url(url) {
		var IE=(document.all)?true:false;
		if (IE) {
			if(confirm("이 글의 URL 주소를 클립보드에 복사하시겠습니까?"))
				window.clipboardData.setData("Text", url);
		} else {
			temp = prompt("이 글의 트랙백 주소입니다. Ctrl+C를 눌러 클립보드로 복사하세요", url);
		}
	}
//-->
</script>
<div class="groundCont">
	<div class="grArea">
		<div class="playGr20160307">
			<div class="topic">
				<div class="on"></div>
				<!--<p class="playMusic"><img src="http://webimage.10x10.co.kr/play/ground/20160307/txt_play_music.png" alt="음악재생 중입니다." /></p>-->
				<h3>
					<span class="letter1">텐바이텐 X 달출판사</span>
					<span class="letter2 fadeInSlideUp">민낯</span>
					<span class="letter3 fadeInSlideUp">토크</span>
					<span class="letter4"></span>
				</h3>
				<p class="come"><img src="http://webimage.10x10.co.kr/play/ground/20160307/txt_come.png" alt="많은 사람들에게 보여지는 모습을 준비하는 과정. 텐바이텐 PLAY 3월 주제는 샤워입니다. 순간순간 결코 아름답지 않은 자세를 취해야 비로소 구석 깊은 곳까지 깨끗한 상태가 될 수 있는 그 시간. 아름답게 보여지는 모습을 위한 일련의 과정들이 때로는 우리들을 지치게 합니다. 막 샤워하고 나온 듯 겉치장은 벗어 던지고 본연의 나를 맞이하는 진솔한 시간. 작가 이석원과 함께하는 잡담회에 놀러오세요!" /></p>
			</div>

			<div id="preview" class="preview">
				<h4><img src="http://webimage.10x10.co.kr/play/ground/20160307/tit_preview.png" alt="도서 보통의 존재 미리보기" /></h4>
				<div class="left">
					<span class="fame"><img src="http://webimage.10x10.co.kr/play/ground/20160307/img_frame_left.png" alt="" /></span>
					<span class="light"><img src="http://webimage.10x10.co.kr/play/ground/20160307/img_light_left.png" alt="" /></span>
					<p class="carefully">
						<span class="off"><img src="http://webimage.10x10.co.kr/play/ground/20160307/txt_preview_carefully.png" alt="비밀을 보여주면 달아날 거란 생각에 두려움을 갖곤 하지만 사실은 더욱 큰 사랑을 느끼게 되므로 이것이야말로 사랑의 반전인 것이다. 따라서, 비밀공개는 신중히" /></span>
						<span class="on"><img src="http://webimage.10x10.co.kr/play/ground/20160307/txt_preview_carefully_on.png" alt="비밀을 보여주면 달아날 거란 생각에 두려움을 갖곤 하지만 사실은 더욱 큰 사랑을 느끼게 되므로 이것이야말로 사랑의 반전인 것이다. 따라서, 비밀공개는 신중히" /></span>
					</p>
				</div>
				<p class="mother"><img src="http://webimage.10x10.co.kr/play/ground/20160307/txt_preview_mother.png" alt="올해 어머니의 칠순을 맞이하는 나의 마음은 애닯다. 내가 보기엔 아직은 그저 나이가 좀 많은 아줌마에 불과한 우리 어머니는 남들에게는 진작 할머니로 보였을 것이다. 어렸을적, 엄마가 내 고통의 전부일때가 있었다. 언제나 나의 모든 것을 통네하고 억압하고 두려움을 주던 엄마 때문에 나는 마음속으로 엄마만 없다면 엄마만 없다면… 하고 얼마나 되뇌었는지 모른다. 그런 어머니가 이제 정말로 인생의 황혼 길에 접어든 노인이 되셨다." /></p>
				<p class="running"><img src="http://webimage.10x10.co.kr/play/ground/20160307/txt_preview_running.png" alt="이어달리기 연애란 이 사람한테 받은 걸 저 사람한테 주는 이어달리기와도 같은 것이어서 전에 사람한테 주지 못한 걸 이번 사람한테 주고 전에 사람한테 당한 걸 죄 없는 이번 사람한테 푸는 이상한 게임이다. 불공정하고 이치에 안 맞긴 하지만 이 특이한 이어달리기의 경향이 대체로 그렇다." /></p>

				<div class="right">
					<span class="fame"><img src="http://webimage.10x10.co.kr/play/ground/20160307/img_frame_right.png" alt="" /></span>
					<span class="light"><img src="http://webimage.10x10.co.kr/play/ground/20160307/img_light_right.png" alt="" /></span>
					<p class="adult"><img src="http://webimage.10x10.co.kr/play/ground/20160307/txt_preview_adult.png" alt="어른, 자신에게 선물을 하게 되는 순간부터." /></p>
				</div>
				<p class="slow"><img src="http://webimage.10x10.co.kr/play/ground/20160307/txt_preview_slow.png" alt="도로에서 가장 느리게 달리는 차는 항상 나다. 그래서 내 뒤에 오는 차들은 거의 어김없이 클랙슨을 누르며 답답해하다가 쌩, 하고 추월을 하곤 한다. 너네는 좋겠다. 그렇게 급한 일, 종요한 일, 가치 있는 일이 있어서. 그렇게 미친 듯이 가야 할 곳이 있어서. 오늘도 나는 가장 느리게 달린다." /></p>
				<span id="cursor"></span>
			</div>

			<div class="book">
				<p><img src="http://webimage.10x10.co.kr/play/ground/20160307/txt_book.jpg" alt="보통의 존재 그에게는 무슨 일이 있었던 것일까? 책에는 아무리 궁금해 해도 알 수 없었던 그 남자, 이석원의 속마음에 대한 이야기가 고스란히 담겨 있다. 이석원이 아무렇지 않은 듯 술술 풀어낸 언어의 강물 위에는 말하고 싶어도 너무나 내밀해서 함부로 꺼낼 수 없거나 말하지 않아도 된다고 생각해왔던 이야기들이 흐른다." /></p>
				<!--
				<div class="album">
					<p><img src="http://webimage.10x10.co.kr/play/ground/20160307/txt_sisters_album.jpg" alt="이토록 절실한 울림! 완벽한 각각의 내러티브를 갖춘 열 개의 이야기 가장 보통의 존재 당신은 음악을 듣고 있는 것인가, 아니면 책이나 영화를 보고 있는 것인가! 앨범이 사라져가는 시대에 진정한 앨범의 가치를 구현한 언니네 이발관" /></p>
					<div class="video">
						<iframe src="https://www.youtube.com/embed/1UcHGQNqV4c?rel=0&autoplay=1" width="244" height="163" frameborder="0" title="언니네 이발관 5집 가장 보통의 존재" webkitallowfullscreen="" mozallowfullscreen="" allowfullscreen=""></iframe>
					</div>
				</div>
				-->
				<ul id="gallery" class="gallery">
					<li class="gallery1"><img src="http://webimage.10x10.co.kr/play/ground/20160307/img_book_01.jpg" alt="" /></li>
					<li class="gallery2"><img src="http://webimage.10x10.co.kr/play/ground/20160307/img_book_02.jpg" alt="" /></li>
					<li class="gallery3"><img src="http://webimage.10x10.co.kr/play/ground/20160307/img_book_03.jpg" alt="" /></li>
				</ul>
			</div>

			<div class="about">
				<p><img src="http://webimage.10x10.co.kr/play/ground/20160307/txt_about.png" alt="독자들의 마음을 두드리고 위로하는 도서 보통의 존재가 사랑받은지 6년이 지났습니다. 한정판 Black Edition의 발행을 기념하며 텐바이텐과 이석원이 만드는 특별한 공연에 초대합니다! 2016년 3월 17일 목요일 오후 7시반 장소는 대학로 텐바이텐 2층 라운지, 드레스코드는 블랙입니다. 콘서트 후 작가님과 단체사진 촬영이 있습니다." /></p>
				<!-- sns -->
				<ul class="shareSns">
					<li class="facebook"><a href="#" onClick="popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','',''); return false;"><span>페이스북</span></a></li>
					<li class="twitter"><a href="#" onClick="popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>',''); return false;"><span>트위터</span></a></li>
					<li class="link"><a href="#" onclick="copy_url('http://www.10x10.co.kr/play/playGround.asp?gidx=28&gcidx=110')"><span>URL</span></a></li>
				</ul>
			</div>

			<!-- comment form -->
			<div class="commentevt">
				<p><img src="http://webimage.10x10.co.kr/play/ground/20160307/txt_event.png" alt="작가 이석원에게 하고 싶은 질문이 있나요? 사연을 남겨주신 분들 중 추첨을 통해 토크 콘서트 민낯토크에 초대합니다. 이벤트 기간은 3월 7일부터 13일까지며, 당첨자 발표는 3월 14일입니다." /></p>
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
							<legend>작가 이석원에게 하고 싶은 질문 쓰기</legend>
							<textarea cols="60" rows="5" title="질문 쓰기" placeholder="100자 이내로 적어주세요." name="txtcomm" onClick="jsChklogin22('<%=IsUserLoginOK%>');"></textarea>
							<span class="btnSubmit"><input type="image" src="http://webimage.10x10.co.kr/play/ground/20160307/btn_submit.png" alt="응모하기"/></span>
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
				<div class="commentlist" id="commentlist">
					<p class="total">Total <%=FormatNumber(iCTotCnt,0)%></p>
					<ul>
						<%	For intCLoop = 0 To UBound(arrCList,2)	%>
						<li>
							<span class="no">No. <%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1)) %><% If arrCList(8,intCLoop) = "M"  then%> <img src="http://webimage.10x10.co.kr/play/ground/20160215/ico_mobile.png" alt="모바일에서 작성된 글" /><% End If %></span>
							<span class="id"><%=printUserId(arrCList(2,intCLoop),2,"*")%></span>
							<div class="scrollbarwrap">
								<div class="scrollbar"><div class="track"><div class="thumb"><div class="end"></div></div></div></div>
								<div class="viewport">
									<div class="overview">
										<p class="msg"><%=arrCList(1,intCLoop)%></p>
									</div>
								</div>
							</div>
							<% if ((GetEncLoginUserID = arrCList(2,intCLoop)) or (GetEncLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %>
							<button type="button" class="btndel" onclick="jsDelComment('<% = arrCList(0,intCLoop) %>');return false;"><img src="http://webimage.10x10.co.kr/play/ground/20160215/btn_del.png" alt="삭제" /></button>
							<% End If %>
						</li>
						<% Next %>
					</ul>
					<div class="pageWrapV15">
						<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
					</div>
				</div>
				<% End If %>
			</div>
		</div>
		<script src="/lib/js/jquery.tinyscrollbar.js"></script>
		<script type="text/javascript">
		$(function(){
			$('.scrollbarwrap').tinyscrollbar();

			$(window.parent).scroll(function(){
				var scrollTop = $(window.parent).scrollTop();
				if (scrollTop > 2200) {
					previewAnimation1();
				}
				if (scrollTop > 3300) {
					previewAnimation2();
				}
				if (scrollTop > 4800) {
					galleryAnimation();
				}
			});

			$("#preview .left .light").css({"opacity":"0"});
			$("#preview .left .carefully .on").css({"opacity":"0"});
			function previewAnimation1() {
				$("#preview .left .light").delay(200).animate({"opacity":"1"},800);
				$("#preview .left .carefully .on").delay(200).animate({"opacity":"1"},800);
				$("#preview .left .carefully .off").delay(200).animate({"opacity":"0"},300);
				$("#preview .right .light").delay(1500).animate({"height":"383px", "opacity":"1"},800);
			}

			$("#preview .right .light").css({"height":"0", "opacity":"0"});
			function previewAnimation2() {
				$("#preview .right .light").delay(200).animate({"height":"383px", "opacity":"1"},1200);
			}

			$("#gallery li.gallery1").css({"left":"400px"});
			$("#gallery li.gallery2").css({"z-index":"5"});
			$("#gallery li.gallery3").css({"right":"400px"});
			function galleryAnimation() {
				$("#gallery .gallery1").delay(100).animate({"left":"0"},800);
				$("#gallery .gallery2").delay(100).animate({"opacity":"1"},800);
				$("#gallery .gallery3").delay(100).animate({"right":"0", "opacity":"1"},800);
			}

			<% if eCC = "1" or iCCurrpage >= 2 then %>
				$('#commentevt').show();
				window.$('html,body').animate({scrollTop:$("#commentlist").offset().top}, 0);
			<% end if %>
		});
		</script>
		<!-- #include virtual="/lib/db/dbclose.asp" -->