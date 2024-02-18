<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : PLAYing Vol.4 W
' History : 2016-12-16 원승현 생성
'####################################################
%>
<!-- #include Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<%
dim oItem
dim currenttime
	currenttime =  now()
'	currenttime = #11/09/2016 09:00:00#

dim eCode, jnum
IF application("Svr_Info") = "Dev" THEN
	eCode   =  66253
Else
	eCode   =  75138
End If

dim userid, commentcount, i, vDIdx
	userid = GetEncLoginUserID()

commentcount = getcommentexistscount(userid, eCode, "", "", "", "Y")
vDIdx = request("didx")
jnum = 1


dim cEComment ,blnFull, cdl, com_egCode, bidx, blnBlogURL, strBlogURL
dim iCTotCnt, arrCList,intCLoop, pagereload
dim iCPageSize, iCCurrpage, isMyComm
dim iCStartPage, iCEndPage, iCTotalPage, iCx,iCPerCnt
	iCCurrpage	= requestCheckVar(Request("iCC"),10)	'현재 페이지 번호
	cdl			= requestCheckVar(Request("cdl"),3)
	blnFull		= requestCheckVar(Request("blnF"),10)
	blnBlogURL	= requestCheckVar(Request("blnB"),10)
	isMyComm	= requestCheckVar(request("isMC"),1)
	pagereload	= requestCheckVar(request("pagereload"),2)

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
	iCPageSize = 4		'풀단이면 15개			'/수기이벤트 둘다 강제 12고정
else
	iCPageSize = 4		'메뉴가 있으면 10개			'/수기이벤트 둘다 강제 12고정
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
<style type="text/css">
.boxingDay {text-align:center;}

.boxingDay .topic {height:874px; padding-top:86px; background-color:#fdcb61;}
.boxingDay .topic .hgroup {width:495px; height:232px; margin:0 auto; padding-top:230px; background:url(http://webimage.10x10.co.kr/playing/thing/vol004/img_box_animmation_v2.gif) 10px 0 no-repeat;}
.boxingDay .topic .hgroup h2 {position:relative; width:156px; height:169px; margin:0 auto; color:#000; font-size:12px;}
.boxingDay .topic .hgroup h2 .letter {position:absolute; width:74px; height:75px; text-align:left;}
.boxingDay .topic .hgroup h2 .letter span {position:absolute; top:0; left:0; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/playing/thing/vol004/tit_boxing_day_v1.png) 0 0 no-repeat;}
.boxingDay .topic .hgroup h2 .letter1 {top:0; left:0;}
.boxingDay .topic .hgroup h2 .letter2 {top:0; right:0; width:72px; padding-right:2px; text-align:right;}
.boxingDay .topic .hgroup h2 .letter2 span {background-position:100% 0;}
.boxingDay .topic .hgroup h2 .letter3 {bottom:0; left:0;}
.boxingDay .topic .hgroup h2 .letter3 span {background-position:0 100%;}
.boxingDay .topic .hgroup h2 .letter4 {right:0; bottom:0; width:72px; padding-right:2px; text-align:right;}
.boxingDay .topic .hgroup h2 .letter4 span {background-position:100% 100%;}
.boxingDay .topic p {margin-top:44px;}

.boxingDay .rolling {height:813px;}
.slide {overflow:hidden; position:relative; height:813px; text-align:center;}
.slide .slidesjs-container, .slide .slidesjs-control {overflow:hidden; height:813px !important;}
.slide .slidesjs-slide {position:relative; width:100%; height:813px; !important; background:#eaeceb url(http://webimage.10x10.co.kr/playing/thing/vol004/img_slide_01_v2.jpg) 50% 50% no-repeat; background-size:cover;}
.slide .slidesjs-slide a {display:block; width:100%; height:813px;}
.slide .slidesjs-slide-02 {background-color:#d7dbde; background-image:url(http://webimage.10x10.co.kr/playing/thing/vol004/img_slide_02_v2.jpg);}
.slide .slidesjs-slide-03 {background-color:#d1d8db; background-image:url(http://webimage.10x10.co.kr/playing/thing/vol004/img_slide_03_v2.jpg);}
.slide .slidesjs-slide-04 {background-color:#d7dbde; background-image:url(http://webimage.10x10.co.kr/playing/thing/vol004/img_slide_04_v2.jpg);}
.slide .slidesjs-slide p {position:absolute; top:50%; left:50%; margin:-197px 0 0 -317px;}
.slidesjs-pagination {overflow:hidden; position:absolute; bottom:27px; left:50%; z-index:50; width:132x; margin-left:-66px;}
.slidesjs-pagination li {float:left;}
.slidesjs-pagination li a {display:block; width:33px; height:18px; background:url(http://webimage.10x10.co.kr/playing/thing/vol004/btn_slide_pagination.png) 0 0 no-repeat; text-indent:-999em; transition:all 0.5s;}
.slidesjs-pagination li a.active {background-position:0 100%;}

.boxingDay .kit {overflow:hidden; position:relative; height:1372px; background-color:#d3edf3;}
.boxingDay .kit .hgroup {position:absolute; top:132px; left:50%; width:753px; margin-left:-254px;}
.boxingDay .kit .hgroup .line {display:block; width:753px; height:5px; background-color:#000;}
.boxingDay .kit .hgroup h3 {position:relative; width:140px; height:76px; margin:40px 0 0 613px;}
.boxingDay .kit .hgroup h3 .letter {overflow:hidden; display:block; position:absolute; width:140px; height:35px; color:#000; line-height:35px;}
.boxingDay .kit .hgroup h3 .letter span {position:absolute; top:0; left:0; width:100%; height:100%; background:#d3edf3 url(http://webimage.10x10.co.kr/playing/thing/vol004/tit_kit_v1.png) 0 0 no-repeat;}
.boxingDay .kit .hgroup h3 .letter1 {top:0; left:0;}
.boxingDay .kit .hgroup h3 .letter2 { right:0; bottom:0;}
.boxingDay .kit .hgroup h3 .letter2 span {background-position:0 100%;}
.moveLeft {animation:moveLeft 1.5s;}
.moveRight {animation:moveRight 1.5s;}
@keyframes moveLeft {
	0% {margin-left:10px; opacity:0;}
	100% {margin-left:0; opacity:1;}
}
@keyframes moveRight {
	0% {margin-right:10px; opacity:0;}
	100% {margin-right:0; opacity:1;}
}
.scale {animation:scale 2s; animation-delay:1s; transform-origin:0 0;}
@keyframes scale {
	0% {transform:scaleX(0); opacity:0;}
	100% {transform:scaleX(1); opacity:1;}
}

.boxingDay .kit .cloud {position:absolute; top:816px; left:50%; margin-left:-1132px;}
.boxingDay .kit .cloud2 {top:524px; margin-left:596px;}
.boxingDay .kit .cloud1 {animation:cloud1 infinite 2.5s;}
.boxingDay .kit .cloud2 {animation:cloud2 infinite 2.5s;}
@keyframes cloud1 {
	from, to {margin-left:-1132x; animation-timing-function:ease-out;}
	50% {margin-left:-1122px; animation-timing-function:ease-in;}
}
@keyframes cloud2 {
	from, to{ margin-left:596px animation-timing-function:ease-out;}
	50% {margin-left:576px; animation-timing-function:ease-in;}
}

.boxingDay .cheer {height:860px; background:#ffe4d1 url(http://webimage.10x10.co.kr/playing/thing/vol004/bg_cheer_v1.jpg) 50% 50% no-repeat; background-size:cover;}
.boxingDay .cheer p {padding-top:106px;}

.boxingDay .commentEvent {padding:60px 0 78px; background-color:#76c2de;}
.boxingDay .form {position:relative; width:1140px; margin:0 auto; }
.boxingDay .form .inner {position:relative; width:632px; height:205px; margin:27px auto 0; padding-top:70px; background:url(http://webimage.10x10.co.kr/playing/thing/vol004/bg_note.png) 50% 0 no-repeat;  text-align:left;}
.boxingDay .form ul {width:272px; margin-left:80px; text-align:left;}
.boxingDay .form ul li {overflow:hidden; padding:8px 0; border-top:1px solid #d2dbde; font-size:17px;}
.boxingDay .form ul li.no1 {border-top:0; padding-top:0;}
.boxingDay .form ul li span,
.boxingDay .form ul li input {float:left; height:40px; font-size:17px; line-height:40px;}
.boxingDay .form ul li span {overflow:hidden; width:52px; position:relative; color:#131313; text-align:center;}
.boxingDay .form ul li input {width:210px; padding:0 5px; background-color:#e4f3f8; color:#000; font-family:Dotum, '돋움', Verdana; font-weight:bold;}
.boxingDay .form ul li span i {position:absolute; top:0; left:0; width:100%; height:100%; background:#e4f3f8 url(http://webimage.10x10.co.kr/playing/thing/vol004/txt_no.png) 50% 10px no-repeat;}
.boxingDay .form ul li.no2 span i {background-position:50% -48px;}
.boxingDay .form ul li.no3 span i {background-position:50% -107px;}
.boxingDay .form input::-webkit-input-placeholder {color:#76c2de;}
.boxingDay .form input::-moz-placeholder {color:#76c2de;} /* firefox 19+ */
.boxingDay .form input:-ms-input-placeholder {color:#76c2de;} /* ie */
.boxingDay .form input:-moz-placeholder {color:#76c2de;}
.boxingDay .form .btnSubmit {position:absolute; top:85px; right:-17px;}

.boxingDay .comment {position:relative; width:1140px; margin:0 auto;}
.boxingDay .commentList {overflow:hidden; width:973px; margin:0 auto;}
.boxingDay .commentList .article {float:left; position:relative; width:180px; height:172px; margin-right:15px; padding:170px 26px 0; background:#e4f3f8 url(http://webimage.10x10.co.kr/playing/thing/vol004/bg_comment.gif) 0 0 no-repeat; text-align:left;}
.boxingDay .commentList .article2 {background-position:-247px 0;}
.boxingDay .commentList .article3 {background-position:-496px 0;}
.boxingDay .commentList .article4 {margin-right:0; background-position:100% 0;}
.boxingDay .commentList .article .info {position:relative;  color:#000; font-size:13px; font-family:Verdana; font-weight:bold;}
.boxingDay .commentList .article .info .no {position:absolute; top:0; right:0;}
.boxingDay .commentList .article .info .no img {vertical-align:-1px;}
.boxingDay .commentList .article ul {margin-top:20px;}
.boxingDay .commentList .article ul li {color:#6b6b6b; font-family:Dotum, '돋움', Verdana; font-size:15px;}
.boxingDay .commentList .article .btndel {position:absolute; right:5px; bottom:5px; background-color:transparent;}

.boxingDay .commentEvent .object {position:absolute; z-index:5;}
.boxingDay .commentEvent .form .object {bottom:-89px; right:17px;}
.boxingDay .commentEvent .comment .object {bottom:45px; left:30px;}

.boxingDay .pageWrapV15 {margin-top:35px;}
.pageWrapV15 .pageMove {display:none;}
.paging a {width:47px; height:36px; margin:0; border:0;}
.paging a span {height:36px; padding:0; color:#fff; font-family:Dotum, '돋움', Verdana; font-size:15px; line-height:36px;}
.paging a.current span {background:url(http://webimage.10x10.co.kr/playing/thing/vol004/btn_pagination.png) 50% 0 no-repeat;}
.paging a:hover, .paging a.arrow, .paging a, .paging a.current, .paging a.current:hover {border:0; background-color:transparent;}
.paging .first, .paging .end {display:none;}
.paging a.arrow span {background:none;}
.paging a.current span {color:#fff; font-weight:normal;}
.paging .prev, 
.paging .next {background:url(http://webimage.10x10.co.kr/playing/thing/vol004/btn_pagination.png) 50% -36px no-repeat;}
.paging .next {background-position:50% 100%;}

.boxingDay .volume {background-color:#fdcb61;}

@keyframes swing {
	20% {transform:rotate(15deg);}
	40% {transform:rotate(-10deg);}
	60% {transform:rotate(5deg);}
	80% {transform:rotate(-5deg);}
	100% {transform:rotate(0deg);}
}
.swing {animation:swing infinite 3s;}
</style>
<script type="text/javascript">

$(function(){
	<% if pagereload<>"" then %>
		//pagedown();
		setTimeout("pagedown()",500);
	<% end if %>
});

$(function(){
	/* ttle animation */
	titleAnimation();
	$("#animation .letter").css({"opacity":"0"});
	$("#animation .letter1").css({"top":"-40%", "left":"-30%"});
	$("#animation .letter2").css({"top":"-40%", "right":"-30%"});
	$("#animation .letter3").css({"bottom":"-40%", "left":"-30%"});
	$("#animation .letter4").css({"bottom":"-40%", "right":"-30%"});
	function titleAnimation() {
		$("#animation .letter1").delay(100).animate({"top":"0", "left":"0", "opacity":"1"},800);
		$("#animation .letter2").delay(100).animate({"top":"0", "right":"0", "opacity":"1"},800);
		$("#animation .letter3").delay(100).animate({"bottom":"0", "left":"0", "opacity":"1"},800);
		$("#animation .letter4").delay(100).animate({"bottom":"0", "right":"0", "opacity":"1"},800);
	}

	/* slide js */
	$("#slide").slidesjs({
		width:"1140",
		height:"813",
		pagination:{effect:"fade"},
		navigation:false,
		play:{interval:2500, effect:"fade", auto:true},
		effect:{fade: {speed:900}}
	});

	/* animation effect */
	$(window).scroll(function(){
		var scroll_position = $(window).scrollTop();
		console.log(scroll_position)
		if(scroll_position>=1600){
			$("#kit h3 .letter1").addClass("moveLeft");
			$("#kit h3 .letter2").addClass("moveRight");
		}else{
			$("#kit h3 .letter1").removeClass("moveLeft");
			$("#kit h3 .letter2").removeClass("moveRight");
		}
	});
});

function pagedown(){
	//document.getElementById('commentlist').scrollIntoView();
	window.$('html,body').animate({scrollTop:$(".comment").offset().top}, 0);
}

function jsGoComPage(iP){
	document.frmcom.iCC.value = iP;
	document.frmcom.iCTot.value = "<%=iCTotCnt%>";
	document.frmcom.submit();
}

function jsSubmitComment(frm){
	<% If IsUserLoginOK() Then %>
		<% if commentcount>4 then %>
			alert("이벤트는 5회까지 참여 가능 합니다.");
			return false;
		<% else %>
			if(!frm.txtcomm1.value){
				alert("상자에 3가지 모두 담아주세요!");
				document.frmcom.txtcomm1.value="";
				frm.txtcomm1.focus();
				return false;
			}

			if (GetByteLength(frm.txtcomm1.value) > 18){
				alert("제한길이를 초과하였습니다. 9자 까지 작성 가능합니다.");
				frm.txtcomm1.focus();
				return;
			}

			if(!frm.txtcomm2.value){
				alert("상자에 3가지 모두 담아주세요!");
				document.frmcom.txtcomm2.value="";
				frm.txtcomm2.focus();
				return false;
			}

			if (GetByteLength(frm.txtcomm2.value) > 18){
				alert("제한길이를 초과하였습니다. 9자 까지 작성 가능합니다.");
				frm.txtcomm2.focus();
				return;
			}

			if(!frm.txtcomm3.value){
				alert("상자에 3가지 모두 담아주세요!");
				document.frmcom.txtcomm3.value="";
				frm.txtcomm3.focus();
				return false;
			}

			if (GetByteLength(frm.txtcomm3.value) > 18){
				alert("제한길이를 초과하였습니다. 9자 까지 작성 가능합니다.");
				frm.txtcomm3.focus();
				return;
			}

			document.frmcom.txtcomm.value = document.frmcom.txtcomm1.value+"||"+document.frmcom.txtcomm2.value+"||"+document.frmcom.txtcomm3.value;
			frm.action = "/event/lib/comment_process.asp";
			frm.submit();
		<% end if %>
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/playing/view.asp?didx="&vDIdx)%>';
			return;
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
			location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/playing/view.asp?didx="&vDIdx)%>';
			return;
		}
		return false;
	}

	//if (frmcom.txtcomm.value == ''){
	//	frmcom.txtcomm.value = '';
	//}	
}

//내코멘트 보기
function fnMyComment() {
	document.frmcom.isMC.value="<%=chkIIF(isMyComm="Y","N","Y")%>";
	document.frmcom.iCC.value=1;
	document.frmcom.submit();
}
</script>

<div class="thingVol004 boxingDay">
	<div class="section topic">
		<div class="hgroup">
			<h2 id="animation">
				<span class="letter letter1"><span></span>박</span>
				<span class="letter letter2"><span></span>싱</span>
				<span class="letter letter3"><span></span>데</span>
				<span class="letter letter4"><span></span>이</span>
			</h2>
		</div>
		<p><img src="http://webimage.10x10.co.kr/playing/thing/vol004/txt_boxing_day_v2.png" alt="크리스마스 다음 날은 Boxing Day! 텐바이텐 플레잉의 박싱 데이는 상자에 지난 추억들을 담고 내년을 준비하는, 한 해를 정리하는 날입니다. 텐텐 Boxing Day에 여러분의 추억을 정리해주세요!" /></p>
	</div>

	<div class="section rolling">
		<div id="slide" class="slide">
			<div class="slidesjs-slide-01">
				<p><img src="http://webimage.10x10.co.kr/playing/thing/vol004/txt_desc_01_v1.png" alt="2016년 마지막 달 12월, 남은 한 달이 아쉽나요?" /></p>
			</div>
			<div class="slidesjs-slide-02">
				<p><img src="http://webimage.10x10.co.kr/playing/thing/vol004/txt_desc_02_v1.png" alt="2016년 동안 무얼 해왔는지 정리해보셨나요?" /></p>
			</div>
			<div class="slidesjs-slide-03">
				<p><img src="http://webimage.10x10.co.kr/playing/thing/vol004/txt_desc_03_v1.png" alt="소중하게 생각하던 것들을 어디에 뒀는지 기억나지 않은 적 있다면," /></p>
			</div>
			<div class="slidesjs-slide-04">
				<p><img src="http://webimage.10x10.co.kr/playing/thing/vol004/txt_desc_04_v1.png" alt="당신의 기억들을 잘 정리해  상자에 담아주세요!" /></p>
			</div>
		</div>
	</div>

	<div id="kit" class="section kit">
		<div class="hgroup">
			<span class="line"></span>
			<h3>
				<span class="letter letter1"><span></span>박싱데이</span>
				<span class="letter letter2"><span></span>Kit</span>
			</h3>
		</div>
		<p><img src="http://webimage.10x10.co.kr/playing/thing/vol004/txt_kit_v2.jpg" alt="박싱데이 키트는 박스 3개, 스티커 10개, 체크리스크 엽서 3개, 테이프, 비닐팩으로 구성되어 있습니다." /></p>
		<p><img src="http://webimage.10x10.co.kr/playing/thing/vol004/txt_how_to_v2.png" alt="How to boxing Step 1 2016년의 정리해야 될 것들을 담아주세요! Step 2 정리된 추억들이 새지 않도록 테이프로 단단히 봉해주세요. Step 3 담은 물건이 무엇인지 구분할 수 있도록 스티커를 붙입니다. Step 4 정리 후 남은 버릴 것들을 봉투에 꽁꽁 묶어 버려주세요! 정리 상자 완성!" /></p>
		<div class="cloud cloud1"><img src="http://webimage.10x10.co.kr/playing/thing/vol004/img_cloud_01.png" alt="" ></div>
		<div class="cloud cloud2"><img src="http://webimage.10x10.co.kr/playing/thing/vol004/img_cloud_02.png" alt="" ></div>
	</div>

	<div class="section cheer">
		<p><img src="http://webimage.10x10.co.kr/playing/thing/vol004/txt_cheer_v1.png" alt="깔끔하게 정리한 당신의 2016년 행복한 2017년의 시작 텐바이텐 Boxing Day는 여러분의 마지막과 새로운 시작을 응원합니다!" /></p>
	</div>

	<div class="section commentEvent">
		<!-- form -->
		<div class="form">
			<form name="frmcom" method="post" onSubmit="return false;" style="margin:0px;">
			<input type="hidden" name="eventid" value="<%=eCode%>">
			<input type="hidden" name="com_egC" value="<%=com_egCode%>">
			<input type="hidden" name="bidx" value="<%=bidx%>">
			<input type="hidden" name="iCC" value="<%=iCCurrpage%>">
			<input type="hidden" name="iCTot" value="">
			<input type="hidden" name="mode" value="add">
			<input type="hidden" name="spoint" value="0">
			<input type="hidden" name="isMC" value="<%=isMyComm%>">
			<input type="hidden" name="pagereload" value="ON">
			<input type="hidden" name="txtcomm">
			<input type="hidden" name="gubunval">
				<fieldset>
				<legend>상자에 담고 싶은 물건 적고 응모하기</legend>
					<p><img src="http://webimage.10x10.co.kr/playing/thing/vol004/txt_comment_v1.gif" alt="텐바이텐 박싱데이에  정리상자를 만나보세요! 여러분은 2016년 상자에 무엇을 담아 정리하고 싶나요? 상자에 담고 싶은 물건을 적고 응모해주세요! 당첨된 50분께는 Boxing Day Kit를 드립니다. 이벤트기간은 12월 19일부터 1월 1일이며, 당첨자발표는 1월 2일 월요일입니다." /></p>
					<div class="inner">
						<ul>
							<li class="no1">
								<span><i></i>1)</span><input type="text" id="txtcomm1" name="txtcomm1" onClick="jsCheckLimit();" title="상자에 담고 싶은 첫번째 물건 입력" placeholder="9자 이내로 입력해 주세요." maxlength="9" />
							</li>
							<li class="no2">
								<span><i></i>2)</span><input type="text" id="txtcomm2" name="txtcomm2" onClick="jsCheckLimit();" title="상자에 담고 싶은 두번째 물건 입력" placeholder="9자 이내로 입력해 주세요." maxlength="9" />
							</li>
							<li class="no3">
								<span><i></i>3)</span><input type="text" id="txtcomm3" name="txtcomm3" onClick="jsCheckLimit();" title="상자에 담고 싶은 세번째 물건 입력" placeholder="9자 이내로 입력해 주세요." maxlength="9" />
							</li>
						</ul>
						<div class="btnSubmit">
							<input type="image" src="http://webimage.10x10.co.kr/playing/thing/vol004/btn_submit_v1.png" alt="상자에 담기" onclick="jsSubmitComment(document.frmcom);return false;" />
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
				<input type="hidden" name="pagereload" value="ON">
			</form>
			<span class="object swing"><img src="http://webimage.10x10.co.kr/playing/thing/vol004/txt_forbid.png" alt="" /></span>
		</div>

		<%' comment list %>
		<% IF isArray(arrCList) THEN %>
		<div class="comment">
			<span class="object"><img src="http://webimage.10x10.co.kr/playing/thing/vol004/img_pot.png" alt="" /></span>
			<div class="commentList">
				<%' for dev msg : 한 페이지당 4개씩 보여주세요 %>
				<% For intCLoop = 0 To UBound(arrCList,2) %>
					<div class="article article<%=jnum%>">
						<div class="info"><span class="id"><%=chrbyte(printUserId(arrCList(2,intCLoop),2,"*"),10,"Y")%></span> <span class="no">no.<%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1)) %> <% If arrCList(8,intCLoop) <> "W" Then %> <img src="http://webimage.10x10.co.kr/play/ground/20160215/ico_mobile.png" alt="모바일에서 작성된 글" /><% End If %></span></div>
						<ul>
							<% if isarray(split(arrCList(1,intCLoop),"||")) then %>
								<% if ubound(split(arrCList(1,intCLoop),"||")) > 0 then %>
									<li>1) <%=ReplaceBracket(db2html( split(arrCList(1,intCLoop),"||")(0) ))%></li>
									<li>2) <%=ReplaceBracket(db2html( split(arrCList(1,intCLoop),"||")(1) ))%></li>
									<li>3) <%=ReplaceBracket(db2html( split(arrCList(1,intCLoop),"||")(2) ))%></li>
								<% End If %>
							<% End If %>
						</ul>
						<% If ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") Then %>
							<button type="button" class="btndel" onclick="jsDelComment('<% = arrCList(0,intCLoop) %>'); return false;"><img src="http://webimage.10x10.co.kr/play/ground/20160307/btn_del.png" alt="내 코멘트 삭제하기" /></button>
						<% End If %>
					</div>
				<%
					If jnum >=4 Then
						jnum = 1
					Else
						jnum = jnum + 1
					End If
				%>
				<% Next %>
			</div>

			<%' pagination %>
			<div class="pageWrapV15">
				<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
			</div>
		</div>
		<% End If %>
	</div>

	<%' volume %>
	<div class="volume">
		<p><img src="http://webimage.10x10.co.kr/playing/thing/vol004/txt_vol004_v1.png" alt="Volume 4 Thing의 사물에 대한 생각 박싱데이" /></p>
	</div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->