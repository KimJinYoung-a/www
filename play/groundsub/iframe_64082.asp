<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : PLAY NICE DREAM
' History : 2015.06.26 한용민 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->

<%
Dim eCode, eCodedisp
IF application("Svr_Info") = "Dev" THEN
	eCode   =  63803
	eCodedisp = 63803
Else
	eCode   =  64082
	eCodedisp = 64082
End If

userid = getloginuserid()

dim currenttime
	currenttime =  now()
	'currenttime = #06/29/2015 09:00:00#
	
dim userid, commentcount, i, vreload
	userid = getloginuserid()
	vreload	= requestCheckVar(Request("vreload"),10)

commentcount = getcommentexistscount(userid, eCode, "", "", "", "Y")

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
	iCPageSize = 12		'풀단이면 15개			'/수기이벤트 둘다 강제 12고정
else
	iCPageSize = 12		'메뉴가 있으면 10개			'/수기이벤트 둘다 강제 12고정
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
img {vertical-align:top;}
.groundHeadWrap {width:100%; background:#dfdfdf;}
.groundCont {padding-bottom:0; background:#fff;}
.groundCont .grArea {width:100%;}
.groundCont .tagView {width:1100px; padding:130px 20px 60px;}
.intro {height:1123px; background:#767674 url(http://webimage.10x10.co.kr/play/ground/20150629/bg_intro.jpg) 50% 0 no-repeat;}
.intro .frame {position:absolute; left:50%; top:95px; width:685px; height:613px; margin-left:-343px; background:url(http://webimage.10x10.co.kr/play/ground/20150629/bg_title_frame.png) 0 0 no-repeat;}
.intro .frame .tit {padding:177px 0 0 12px;}
.intro .frame .tit p {position:relative; height:212px;}
.intro .frame .tit p span {display:inline-block; position:absolute; left:301px; top:100px; opacity:0;}
.intro .frame .with {position:absolute; left:50%; margin-left:-203px; bottom:92px; opacity:0;}
.dreamCont {position:relative; width:1140px; margin:0 auto;}
.purpose {background:url(http://webimage.10x10.co.kr/play/ground/20150629/bg_pink.gif) 0 0 repeat-x;}
.purpose .dreamCont {width:1276px; height:927px; background:url(http://webimage.10x10.co.kr/play/ground/20150629/bg_purpose.png) 50% 0 no-repeat;}
.purpose .dreamCont p {position:absolute; left:68px; top:192px; width:407px; height:0; opacity:0; background:url(http://webimage.10x10.co.kr/play/ground/20150629/txt_good_dream.png) 0 0 no-repeat;}
.purpose .dreamCont .goKit {display:block; overflow:hidden; position:absolute; left:64px; top:678px; width:301px; height:60px; opacity:0;}
.purpose .dreamCont .goKit:hover img {margin-left:-301px;}
.everyNight { background:url(http://webimage.10x10.co.kr/play/ground/20150629/bg_my_story.jpg) 50% 0 no-repeat;}
.everyNight .dreamCont {height:3111px;}
.everyNight h3 {position:absolute; left:0; top:90px;  font-size:35px; color:#3c3c3c; font-weight:normal; font-family:'NanumMyeongjo','batang','바탕';}
.everyNight p {position:absolute; opacity:0;}
.everyNight .t01 {left:10px; top:186px;}
.everyNight .t02 {right:95px; bottom:590px;}
.everyNight .pic {position:absolute; right:-280px; bottom:-100px;}
.dreamKit {padding:100px 0; text-align:center;}
.dreamKit .dreamCont {position:relative; padding-top:90px;}
.dreamKit .composition .goBuy {overflow:hidden; position:absolute; right:125px; bottom:0; width:325px; height:66px;}
.dreamKit .composition .goBuy:hover img {margin-left:-325px;}
.niceDream {height:619px; background:#f5e6c9 url(http://webimage.10x10.co.kr/play/ground/20150629/bg_nice.jpg) 50% 0 no-repeat;}
.niceDream .dreamCont {padding-top:190px; text-align:center;}
.niceDream .dreamCont h3 {padding-bottom:105px;}
.niceDream .dreamCont h3 span {display:inline-block; padding:0 16px; position:relative; opacity:0;}
.niceDream .dreamCont h3 span.w01 {top:-10px;}
.niceDream .dreamCont h3 span.w02 {bottom:-10px;}
.niceDream .dreamCont div {position:relative;}
.niceDream .dreamCont p {position:absolute; left:0; width:100%; opacity:0;}
.niceDream .dreamCont p.t01 {top:0;}
.niceDream .dreamCont p.t02 {top:25px; }
.niceDream .dreamCont p.t03 {top:55px;}
.niceDream .dreamCont p.t04 {top:85px;}
.niceDream .dreamCont .line {display:inline-block; position:absolute; left:50%; top:272px; width:0; height:1px; margin-left:-37px; background:#5f574a;}
.fullImg img {width:100%;}
.brandStory {padding:192px 0; background:#f8f8f8;}
.brandStory .dreamCont {height:395px;}
.brandStory p {margin-top:78px;}
.brandStory .goBrand {position:absolute; right:0px; bottom:0px; overflow:hidden; display:block; width:160px; height:160px;}
.brandStory .goBrand:hover img {margin-left:-160px;}
.specialEvent {text-align:center; padding-bottom:105px; background:#fff6e6;}
.specialEvent h3 {padding:140px 0 75px;}
.specialEvent .step {position:relative; overflow:hidden; width:1140px; height:308px; padding:4px; margin:0 auto 33px; background:url(http://webimage.10x10.co.kr/play/ground/20150629/bg_box.png) 0 0 no-repeat;}
.specialEvent .step .num {float:left;}
.specialEvent .selectShirt {float:left; overflow:hidden; padding-top:42px; padding-left:70px;}
.specialEvent .selectShirt div {float:left; text-align:center; padding:0 22px;}
.specialEvent .selectShirt input {vertical-align:top;}
.specialEvent .selectShirt label {display:block; vertical-align:top; padding-top:10px;}
.specialEvent .writeShirt {float:left; padding-left:48px; padding-top:67px; text-align:left;}
.specialEvent .writeShirt .msg {width:480px; padding-bottom:8px; margin-bottom:45px; border-bottom:4px solid #3c3c3c;}
.specialEvent .writeShirt .msg input {border:0; color:#3c3c3c; text-align:left; font-weight:bold; font-size:50px; font-family:dotum;}
.specialEvent .writeShirt .btnSubmit {position:absolute; right:64px; top:70px;}
.shirtList {overflow:hidden; width:1140px; margin:0 auto;}
.shirtList ul {overflow:hidden; margin-left:-52px; padding:105px 0 60px;}
.shirtList li {float:left; width:246px; margin-bottom:50px; margin-left:52px; line-height:14px; text-align:center;}
.shirtList li .msg {height:208px; padding-top:78px; font-size:15px; font-weight:bold; color:#fff; background-position:0 0; background-repeat:no-repeat;}
.shirtList li.shirt01 .msg {color:#3c3c3c; background-image:url(http://webimage.10x10.co.kr/play/ground/20150629/bg_cmt_shirt01.jpg);}
.shirtList li.shirt02 .msg {background-image:url(http://webimage.10x10.co.kr/play/ground/20150629/bg_cmt_shirt02.jpg);}
.shirtList li.shirt03 .msg { background-image:url(http://webimage.10x10.co.kr/play/ground/20150629/bg_cmt_shirt03.jpg);}
.shirtList li .num {padding-top:5px; font-size:12px; color:#3c3c3c;}
.shirtList li .writer {padding-top:5px; font-size:13px; color:#3c3c3c; font-weight:bold;}
.shirtList li .writer .btn {margin-top:-3px;}
</style>
<script>
$(function(){
//	$(".goKit").click(function(event){
//		event.preventDefault();
//		window.parent.$('html,body').animate({scrollTop:$(this.hash).offset().top}, 800);
//	});
	$('.shirtList li:nth-child(even)').css('margin-top','62px');
	function intro () {
		$('.intro .frame .tit span.t01').animate({"opacity":"1","left":"174px", "top":"0"}, 1500);
		$('.intro .frame .tit span.t02').animate({"opacity":"1","left":"277px", "top":"0"}, 1500);
		$('.intro .frame .tit span.t03').animate({"opacity":"1","left":"326px", "top":"-2px"},1500);
		$('.intro .frame .tit span.t04').animate({"opacity":"1","left":"426px", "top":"0"},1500);
		$('.intro .frame .tit span.t05').animate({"opacity":"1","left":"93px", "top":"125px"},1500);
		$('.intro .frame .tit span.t06').animate({"opacity":"1","left":"194px", "top":"125px"},1500);
		$('.intro .frame .tit span.t07').animate({"opacity":"1","left":"290px", "top":"125px"},1500);
		$('.intro .frame .tit span.t08').animate({"opacity":"1","left":"373px", "top":"125px"},1500);
		$('.intro .frame .tit span.t09').animate({"opacity":"1","left":"485px", "top":"125px"},1500);
		$('.intro .frame .with').delay(1500).animate({"opacity":"1"},2000);
	}
	function niceDream () {
		$('.niceDream h3 span.w01').animate({"opacity":"1","top":"0"}, 1500);
		$('.niceDream h3 span.w02').animate({"opacity":"1","bottom":"0"}, 1500);
		$('.niceDream .line').delay(500).animate({"width":"75px"}, 1500);
		$('.niceDream p.t01').delay(1500).animate({"opacity":"1","top":"0"}, 1000);
		$('.niceDream p.t02').delay(1800).animate({"opacity":"1","top":"30px"}, 1000);
		$('.niceDream p.t03').delay(2100).animate({"opacity":"1","top":"60px"}, 1000);
		$('.niceDream p.t04').delay(2400).animate({"opacity":"1","top":"90px"}, 1000);
	}
	var conChk = 0;
	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 400 ) {
			intro();
		}
		if (scrollTop > 1200 ) {
			$('.purpose p').animate({"opacity":"1","height":"437px"}, 3100);
			$('.purpose .goKit').delay(2900).animate({"opacity":"1"}, 1500);
		}
		if (scrollTop > 2500 ) {
			if (conChk==0){ 
				everyNight();
			}
		}
		if (scrollTop > 4450 ) {
			$('.everyNight .t02').animate({"opacity":"1","right":"105px"}, 1500);
		}
		if (scrollTop > 5450 ) {
			niceDream ();
		}
	});
	function changeText(cont1,cont2,speed){
		var Otext=cont1.text();
		var Ocontent=Otext.split("");
		var i=0;
		function show(){
			if(i<Ocontent.length){
				cont2.append(Ocontent[i]);
				i=i+1;
			};
		};
		var typing=setInterval(show,speed);
	}
	function everyNight() {
		conChk = 1;
		$('.everyNight .t01').delay(1400).animate({"opacity":"1","left":"0"}, 1500);
		changeText($(".everyNight h3 span"),$(".everyNight h3 .copy"),150);
		clearInterval(typing);
		return false;
	}
	
	<% if vreload<>"" then %>
		//setTimeout("pagedown()",500);
	<% end if %>
});

function pagedown(){
	window.parent.$('html,body').animate({scrollTop:$("#shirtList").offset().top}, 0);
}

function jsGoComPage(iP){
	document.frmcom.iCC.value = iP;
	document.frmcom.iCTot.value = "<%=iCTotCnt%>";
	document.frmcom.submit();
}

function jsSubmitComment(frm){
	<% If IsUserLoginOK() Then %>
		<% If not( left(currenttime,10)>="2015-06-29" and left(currenttime,10)<"2015-07-13" ) Then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return false;
		<% else %>
			<% if commentcount>5 then %>
				alert("이벤트는 5회만 참여하실수 있습니다.");
				return false;
			<% else %>
				var tmpcolorgubun='';
				for (var i = 0; i < frm.colorgubun.length; i++){
					if (frm.colorgubun[i].checked){
						tmpcolorgubun = frm.colorgubun[i].value;
					}
				}
				if (tmpcolorgubun==''){
					alert('원하는 컬러를 선택해 주세요.');
					return false;
				}

				if (frm.txtcomm1.value == '여덟자까지 입력'){
					frm.txtcomm1.value = '';
				}
				//alert( frm.txtcomm1.value );
				if (frm.txtcomm1.value == '' || GetByteLength(frm.txtcomm1.value) > 16 || frm.txtcomm1.value == '8자 이내로 입력해주세요'){
					alert("코맨트를 남겨주세요.\n8자 까지 작성 가능합니다.");
					frm.txtcomm1.focus();
					return false;
				}
				
				frm.txtcomm.value = tmpcolorgubun + '!@#' + frm.txtcomm1.value
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

	if (frmcom.txtcomm1.value == '여덟자까지 입력'){
		frmcom.txtcomm1.value = '';
	}
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

<!-- T-SHIRTS #4 -->
<div class="playGr20150629">
	<div class="intro">
		<div class="dreamCont">
			<div class="frame">
				<div class="tit">
					<p>
						<span class="t01"><img src="http://webimage.10x10.co.kr/play/ground/20150629/tit_intro_n.png" alt="" /></span>
						<span class="t02"><img src="http://webimage.10x10.co.kr/play/ground/20150629/tit_intro_i.png" alt="" /></span>
						<span class="t03"><img src="http://webimage.10x10.co.kr/play/ground/20150629/tit_intro_c.png" alt="" /></span>
						<span class="t04"><img src="http://webimage.10x10.co.kr/play/ground/20150629/tit_intro_e.png" alt="" /></span>
						<span class="t05"><img src="http://webimage.10x10.co.kr/play/ground/20150629/tit_intro_d.png" alt="" /></span>
						<span class="t06"><img src="http://webimage.10x10.co.kr/play/ground/20150629/tit_intro_r.png" alt="" /></span>
						<span class="t07"><img src="http://webimage.10x10.co.kr/play/ground/20150629/tit_intro_e.png" alt="" /></span>
						<span class="t08"><img src="http://webimage.10x10.co.kr/play/ground/20150629/tit_intro_a.png" alt="" /></span>
						<span class="t09"><img src="http://webimage.10x10.co.kr/play/ground/20150629/tit_intro_m.png" alt="" /></span>
					</p>
				</div>
				<p class="with"><img src="http://webimage.10x10.co.kr/play/ground/20150629/txt_with.png" alt="" /></p>
			</div>
		</div>
	</div>
	<div class="purpose">
		<div class="dreamCont">
			<p></p>
			<a href="/shopping/category_prd.asp?itemid=1307015" target="_blank" class="goKit"><img src="http://webimage.10x10.co.kr/play/ground/20150629/btn_go_kit.gif" alt="" /></a>
		</div>
	</div>
	<div class="everyNight">
		<div class="dreamCont">
			<h3><span style="display:none;">매일 밤 우리는</span><span class="copy"></span></h3>
			<p class="t01"><img src="http://webimage.10x10.co.kr/play/ground/20150629/txt_night01.png" alt="" /></p>
			<p class="t02"><img src="http://webimage.10x10.co.kr/play/ground/20150629/txt_night02.png" alt="" /></p>
			<div class="pic"><img src="http://webimage.10x10.co.kr/play/ground/20150629/img_eye_patch.png" alt="" /></div>
		</div>
	</div>
	<div class="niceDream">
		<div class="dreamCont">
			<h3>
				<span class="w01"><img src="http://webimage.10x10.co.kr/play/ground/20150629/tit_nice.png" alt="NICE" /></span>
				<span class="w02"><img src="http://webimage.10x10.co.kr/play/ground/20150629/tit_life.png" alt="LIFE" /></span>
				<span class="w01"><img src="http://webimage.10x10.co.kr/play/ground/20150629/tit_nice.png" alt="NICE" /></span>
				<span class="w02"><img src="http://webimage.10x10.co.kr/play/ground/20150629/tit_dream.png" alt="DREAM" /></span>
			</h3>
			<div>
				<p class="t01"><img src="http://webimage.10x10.co.kr/play/ground/20150629/txt_dream01.png" alt="" /></p>
				<p class="t02"><img src="http://webimage.10x10.co.kr/play/ground/20150629/txt_dream02.png" alt="" /></p>
				<p class="t03"><img src="http://webimage.10x10.co.kr/play/ground/20150629/txt_dream03.png" alt="" /></p>
				<p class="t04"><img src="http://webimage.10x10.co.kr/play/ground/20150629/txt_dream04.png" alt="" /></p>
			</div>
			<span class="line"></span>
		</div>
	</div>
	<div class="dreamKit">
		<div class="dreamCont" id="dreamKit">
			<h3><img src="http://webimage.10x10.co.kr/play/ground/20150629/tit_nice_dream.gif" alt="NICE DREAM" /></h3>
			<div class="composition">
				<div><a href="/shopping/category_prd.asp?itemid=1307015" target="_blank"><img src="http://webimage.10x10.co.kr/play/ground/20150629/img_kit.jpg" alt="키트 구성" /></a></div>
				<a href="/shopping/category_prd.asp?itemid=1307015" target="_blank" class="goBuy"><img src="http://webimage.10x10.co.kr/play/ground/20150629/btn_go_buy.gif" alt="구매하러가기" /></a>
			</div>
		</div>
	</div>
	<div class="fullImg"><a href="/shopping/category_prd.asp?itemid=1307015" target="_blank"><img src="http://webimage.10x10.co.kr/play/ground/20150629/img_night_clothes01.jpg" alt="잠옷 이미지" /></a></div>
	<div class="brandStory">
		<div class="dreamCont">
			<h3><img src="http://webimage.10x10.co.kr/play/ground/20150629/tit_about.gif" alt="ABOUT ithinkso" /></h3>
			<p><img src="http://webimage.10x10.co.kr/play/ground/20150629/txt_brand01.gif" alt="Ithinkso, 나도 그렇게 생각해" /></p>
			<p><img src="http://webimage.10x10.co.kr/play/ground/20150629/txt_brand02.gif" alt="가장 아름다운 감성, 누군가와의 공감.." /></p>
			<a href="/street/street_brand_sub06.asp?makerid=ithinkso" target="_blank" class="goBrand"><img src="http://webimage.10x10.co.kr/play/ground/20150629/btn_go_brand.gif" alt="브랜드 바로가기" /></a>
		</div>
	</div>
	<div class="fullImg"><a href="/shopping/category_prd.asp?itemid=1307015" target="_blank"><img src="http://webimage.10x10.co.kr/play/ground/20150629/img_night_clothes02.jpg" alt="잠옷 이미지" /></a></div>
	<% '<!-- 문구 작성 --> %>
	<form name="frmcom" method="post" onSubmit="return false;" style="margin:0px;">
	<input type="hidden" name="eventid" value="<%=eCode%>">
	<input type="hidden" name="com_egC" value="<%=com_egCode%>">
	<input type="hidden" name="bidx" value="<%=bidx%>">
	<input type="hidden" name="iCC" value="<%=iCCurrpage%>">
	<input type="hidden" name="iCTot" value="">
	<input type="hidden" name="mode" value="add">
	<input type="hidden" name="spoint" value="0">
	<input type="hidden" name="isMC" value="<%=isMyComm%>">
	<input type="hidden" name="vreload" value="ON">
	<input type="hidden" name="txtcomm">
	<div class="specialEvent">
		<h3><img src="http://webimage.10x10.co.kr/play/ground/20150629/tit_special_event.gif" alt="SPECIAL EVENT - 당신의 Nice Dream을 만들어 드립니다." /></h3>
		<div class="dreamCont">
			<div class="step">
				<p class="num"><img src="http://webimage.10x10.co.kr/play/ground/20150629/txt_step01.gif" alt="STEP01 - 당신이 원하는 컬러를 선택하세요." /></p>
				<div class="selectShirt">
					<div>
						<input type="radio" name="colorgubun" value="1" id="s01" />
						<label for="s01"><img src="http://webimage.10x10.co.kr/play/ground/20150629/img_select_shirt01.gif" alt="흰색 잠옷" /></label>
					</div>
					<div>
						<input type="radio" name="colorgubun" value="2" id="s02" />
						<label for="s02"><img src="http://webimage.10x10.co.kr/play/ground/20150629/img_select_shirt02.gif" alt="분홍색 잠옷" /></label>
					</div>
					<div>
						<input type="radio" name="colorgubun" value="3" id="s03" />
						<label for="s03"><img src="http://webimage.10x10.co.kr/play/ground/20150629/img_select_shirt03.gif" alt="연두색 잠옷" /></label>
					</div>
				</div>
			</div>
			<div class="step">
				<p class="num"><img src="http://webimage.10x10.co.kr/play/ground/20150629/txt_step02.gif" alt="STEP02 - 당신이 원하는 문구를 입력하세요." /></p>
				<div class="writeShirt">
					<div class="msg"><input type="text" name="txtcomm1" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();" <%IF NOT(IsUserLoginOK) THEN%>readonly<%END IF%> value="<%IF NOT IsUserLoginOK THEN%><% '로그인 후 글을 남길 수 있습니다. %><% else %>여덟자까지 입력<%END IF%>" /></div>
					<p><img src="http://webimage.10x10.co.kr/play/ground/20150629/txt_noti.gif" alt="원하는 문구는 캘리로 변환하여 티셔츠에 작업됩니다./ 작성하신 문구는 자수로 작업됩니다./티셔츠 사이즈는 고르실 수 없으며, FREE 사이즈 하나로만 만들어 집니다" /></p>
					<p class="btnSubmit"><input type="image" onclick="jsSubmitComment(frmcom); return false;" src="http://webimage.10x10.co.kr/play/ground/20150629/btn_enter.gif" alt="입력하기" /></p>
				</div>
			</div>
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
	<% '<!--// 문구 작성 --> %>

	<% IF isArray(arrCList) THEN %>
		<% '<!-- 티셔츠 리스트 --> %>
		<div class="shirtList" id="shirtList">
			<ul>
				<% '<!-- 티셔츠 선택에 따라 클래스 shirt01~03붙여주세요 / 리스트는 12개씩 노출됩니다. --> %>
				<%
				dim tmpcolorgubun , colorgubun, txtval
				dim rndNo : rndNo = 1
				
				For intCLoop = 0 To UBound(arrCList,2)
				
				randomize
				rndNo = Int((4 * Rnd) + 1)
				
				tmpcolorgubun = ""
				colorgubun = 1
				txtval=""
				tmpcolorgubun = split( arrCList(1,intCLoop) ,"!@#")
				if isarray(tmpcolorgubun) then
					colorgubun = tmpcolorgubun(0)

					if ubound(tmpcolorgubun) > 0 then
						txtval = tmpcolorgubun(1)
					end if
				end if
				'response.write arrCList(1,intCLoop)
				%>
				<li class="shirt0<%= colorgubun %>">
					<p class="msg">
						<%=ReplaceBracket(db2html( txtval ))%>
					</p>
					<p class="num">NO.<%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1))%></p>
					<p class="writer">
						<%=printUserId(arrCList(2,intCLoop),2,"*")%>
						
						<% if ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %>
							 <a href="" onclick="jsDelComment('<% = arrCList(0,intCLoop) %>');return false;" class="btn btnS2 btnGry3">삭제</a>
						<% end if %>
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
		<!--// 티셔츠 리스트 -->
	<% end if %>
</div>
<!-- // T-SHIRTS #4 -->

</body>
</html>

<!-- #include virtual="/lib/db/dbclose.asp" -->