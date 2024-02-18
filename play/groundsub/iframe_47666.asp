<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<%
	Dim snpTitle, snpLink, snpPre, snpTag2, snpImg
	snpTitle = URLEncodeUTF8("#Timecapsule @Timecapsule No.3 CARD 텐바이텐의 플레이 그라운드 세번째 주제,CARD")
	snpLink = URLEncodeUTF8("http://www.10x10.co.kr/play/playGround.asp?gidx=3&gcidx=10")
	snpPre = URLEncodeUTF8("텐바이텐 그라운드")
	snpTag2 = URLEncodeUTF8("#Timecapsule")

	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : 그라운드 GROUND 미래에서 온 카드"		'페이지 타이틀 (필수)
	strPageDesc = "텐바이텐 PLAY - GROUND 미래에서 온 카드" 	'페이지 설명
	strPageImage = ""		'페이지 요약 이미지(SNS 퍼가기용)
	strPageUrl = "http://www.10x10.co.kr/play/playGround.asp?gidx=3&gcidx=10"			'페이지 URL(SNS 퍼가기용)
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<%
'#### 2013-12-06 이종화 작성 ###################
Dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  21027
Else
	eCode   =  47666
End If

dim com_egCode, bidx
	Dim cEComment
	Dim iCTotCnt, arrCList,intCLoop, iSelTotCnt
	Dim iCPageSize, iCCurrpage
	Dim iCStartPage, iCEndPage, iCTotalPage, iCx,iCPerCnt
	Dim timeTern, totComCnt

	'파라미터값 받기 & 기본 변수 값 세팅
	iCCurrpage = requestCheckVar(Request("iCC"),10)	'현재 페이지 번호
	com_egCode = requestCheckVar(Request("eGC"),1)	'그룹 번호(엣지1, 초식2, 연하3)

	IF iCCurrpage = "" THEN iCCurrpage = 1
	IF iCTotCnt = "" THEN iCTotCnt = -1

	'// 그룹번호 랜덤으로 지정

	iCPageSize = 12		'한 페이지의 보여지는 열의 수
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
.playGr1209 {width:100%; background:#f6f6f6 url(http://webimage.10x10.co.kr/play/ground/20131209/bg_line_fix.gif) center 69px no-repeat;}
.timeCapsuleHead {width:1140px; margin:0 auto;}
.timeCapsuleHead h3 {padding-bottom:95px;}
.timeCapsuleHead .message {overflow:hidden; position:relative; z-index:5; width:1140px; height:178px;}
.timeCapsuleHead .message .bg {position:absolute; left:0; top:0; width:100%; height:100%; background:#f6f6f6 url(http://webimage.10x10.co.kr/play/ground/20131209/bg_txt_time_capsule.gif) left top no-repeat;}
.writeMeLetter {width:1140px; margin:0 auto; padding:60px 0 0 0;}
.writeMeLetter .writeMe {height:839px; margin-left:-125px; padding:64px 0 0 806px; background:#f6f6f6 url(http://webimage.10x10.co.kr/play/ground/20131209/bg_time_capsule.jpg) left top no-repeat;}
.writeMeLetter .writeMe .colorSelect {overflow:hidden; padding:30px 0 30px 70px; text-align:center;}
.writeMeLetter .writeMe .colorSelect li {float:left; width:58px; margin-right:30px;}
.writeMeLetter .writeMe .colorSelect li label {display:block; padding-bottom:10px;}
.writeMeLetter .writeMe .letterForm {width:420px; height:302px; padding:47px 0 0 33px; background:url(http://webimage.10x10.co.kr/play/ground/20131209/bg_letter.png) left top no-repeat;}
.writeMeLetter .writeMe .letterForm .letterWrite {width:341px; height:201px; padding:34px 17px 25px 18px; text-align:left;}
.writeMeLetter .writeMe .letterForm .letterWrite .letterSubjct {padding-bottom:20px;}
.writeMeLetter .writeMe .letterForm .letterWrite input, .writeMeLetter .writeMe .letterForm .letterWrite textarea {color:#919191; font-size:12px; font-family:verdana, tahoma, dotum, dotumche, '돋움', '돋움체', sans-serif;}
.writeMeLetter .writeMe .letterForm .letterWrite input {width:300px; vertical-align:top;}
.writeMeLetter .writeMe .letterForm .letterWrite textarea {width:327px; height:152px; border:0; background:url(http://webimage.10x10.co.kr/play/ground/20131209/bg_letter_line.png) left bottom no-repeat; line-height:1.8em;}
.writeMeLetter .writeMe .btnSubmit {padding-top:30px; text-align:center;}
.letterFromFuture {width:100%; background-color:#cdcdca; text-align:center;}
.letterFromFuture .futureCard {width:1140px; margin:0 auto; padding-bottom:185px;}
.timeCapsuleSlide {width:100%; background-color:#dfe0e0; text-align:center;}
.timeCapsuleSlide .slideWrap {position:relative; height:890px;}
.timeCapsuleSlide .slideWrap .slide {position:absolute; width:1920px; left:50%; top:0; margin-left:-960px;}
.timeCapsuleSlide .slideWrap .slidesjs-container {height:890px;}
.timeCapsuleSlide .slideWrap .slidesjs-navigation {display:block; position:absolute; top:445px; z-index:200; width:22px; height:38px; text-indent:-999em;}
.timeCapsuleSlide .slideWrap .slidesjs-previous {left:400px; background:url(http://webimage.10x10.co.kr/play/ground/20131209/btn_navigation.png) left top no-repeat;}
.timeCapsuleSlide .slideWrap .slidesjs-next {right:400px; background:url(http://webimage.10x10.co.kr/play/ground/20131209/btn_navigation.png) right top no-repeat;}
.timeCapsuleSlide .slideWrap .slidesjs-previous:hover {background:url(http://webimage.10x10.co.kr/play/ground/20131209/btn_navigation_over.png) left top no-repeat;}
.timeCapsuleSlide .slideWrap .slidesjs-next:hover {background:url(http://webimage.10x10.co.kr/play/ground/20131209/btn_navigation_over.png) right top no-repeat;}
.timeCapsuleView {text-align:center;}
.timeCapsuleView .btnBuy {padding:70px 0;}
.letterFromFutureList {}
.letterFromFutureList .letterCommenWrap {width:1140px; margin:0 auto; padding:50px 0 0 0; border-bottom:1px solid #fff;}
.letterFromFutureList .letterCommenWrap .winWay {position:relative; padding:0 0 100px 40px; border-bottom:1px solid #ddd;}
.letterFromFutureList .letterCommenWrap .winWay .btnWriteMe {position:absolute; right:0; top:0;}
.letterFromFutureList .letterCommenWrap .winWay .social {position:absolute; left:40px; top:30px;}
.letterFromFutureList .letterCommenWrap .letterCommenList {overflow:hidden; border-top:1px solid #fff; padding:30px 0;}
.letterFromFutureList .letterCommenWrap .letterCommenList .letterCommenRow {padding:0 0 0 55px; min-height:408px; background:url(http://webimage.10x10.co.kr/play/ground/20131209/bg_shelf.gif) left bottom no-repeat;}
.letterFromFutureList .letterCommenWrap .letterCommenList  .bottleComment {float:left; width:103px; height:187px; margin-top:50px; margin-right:35px; padding:90px 20px 0 16px; color:#fff; text-align:center;}
.letterFromFutureList .letterCommenWrap .letterCommenList .bottleComment .number {padding-bottom:17px;}
.letterFromFutureList .letterCommenWrap .letterCommenList .bottleComment .number strong {border-bottom:3px solid #fff;}
.letterFromFutureList .letterCommenWrap .letterCommenList .bottleComment .subject {padding-bottom:17px;}
.letterFromFutureList .letterCommenWrap .letterCommenList .bottlebg01 {background:url(http://webimage.10x10.co.kr/play/ground/20131209/bg_bottle_01.png) left top no-repeat;}
.letterFromFutureList .letterCommenWrap .letterCommenList .bottlebg02 {background:url(http://webimage.10x10.co.kr/play/ground/20131209/bg_bottle_02.png) left top no-repeat;}
.letterFromFutureList .letterCommenWrap .letterCommenList .bottlebg03 {background:url(http://webimage.10x10.co.kr/play/ground/20131209/bg_bottle_03.png) left top no-repeat;}
.letterFromFutureList .letterCommenWrap .letterCommenList .bottlebg04 {background:url(http://webimage.10x10.co.kr/play/ground/20131209/bg_bottle_04.png) left top no-repeat;}
.letterFromFutureList .letterCommenWrap .paging {padding-bottom:68px; border-bottom:1px solid #ddd;}
</style>
<script type="text/javascript" src="/lib/js/jquery.slides.min.js"></script>
<script type="text/javascript">
	$(function(){
			
		$(".writeMeLayer").hide();
		$(".btnWriteMe a").click(function(){
			$(".writeMeLayer").show();
		});

		$(".layerClose").click(function(){
			$(".writeMeLayer").hide();
		});


		$('.slide').slidesjs({
			height:'420px',
			pagination: false,
			navigation: {effect: "fade"},
			play: {interval:3000,effect: "fade",auto: false}
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

	    if(!(frm.spoint[0].checked||frm.spoint[1].checked||frm.spoint[2].checked||frm.spoint[3].checked)){
	    alert("컬러를 선택해주세요");
	    return false;
	   }

	   if(!frm.txtcommURL.value||frm.txtcommURL.value=="타이틀은 이벤트 화면에 공개됩니다.(최대 12자)"){
	    alert("타이틀을 입력해주세요");
		document.frmcom.txtcommURL.value="";
	    frm.txtcommURL.focus();
	    return false;
	   }

	   	if(GetByteLength(frm.txtcommURL.value)>24){
			alert('12자 까지 가능합니다.');
	    frm.txtcommURL.focus();
	    return false;
		}

	   if(!frm.txtcomm.value||frm.txtcomm.value=="미래의 나에게 편지를 써주세요.100분을 선정하여 당신의 카드를 담은 타임캡슐 키트를 보내드립니다."){
	    alert("편지를 입력해주세요");
		document.frmcom.txtcomm.value="";
	    frm.txtcomm.focus();
	    return false;
	   }

	   	if(GetByteLength(frm.txtcomm.value)>500){
			alert('250자 까지 가능합니다.');
	    frm.txtcomm.focus();
	    return false;
		}

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
			if(document.frmcom.txtcomm.value =="미래의 나에게 편지를 써주세요.100분을 선정하여 당신의 카드를 담은 타임캡슐 키트를 보내드립니다."){
				document.frmcom.txtcomm.value="";
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
			if(document.frmcom.txtcommURL.value =="타이틀은 이벤트 화면에 공개됩니다.(최대 12자)"){
				document.frmcom.txtcommURL.value="";
			}
			return true;
		} else {
			jsChklogin('<%=IsUserLoginOK%>');
		}

		return false;
	}

	function jsChkUnblur()
	{
		if(document.frmcom.txtcomm.value ==""){
			document.frmcom.txtcomm.value="미래의 나에게 편지를 써주세요.100분을 선정하여 당신의 카드를 담은 타임캡슐 키트를 보내드립니다.";
		}
	}

	function jsChkUnblur22()
	{
		if(document.frmcom.txtcommURL.value ==""){
			document.frmcom.txtcommURL.value="타이틀은 이벤트 화면에 공개됩니다.(최대 12자)";
		}
	}

	function Limit(obj)
	{
	   var maxLength = parseInt(obj.getAttribute("maxlength"));
	   if ( obj.value.length > maxLength ) {
		alert("미래의 나에게 편지를 써주세요.100분을 선정하여 당신의 카드를 담은 타임캡슐 키트를 보내드립니다.");
		obj.value = obj.value.substring(0,maxLength); //200자 이하 튕기기
		}
	}

//-->
</script>

<div class="playGr1209">
	<div class="timeCapsuleHead">
		<h3><img src="http://webimage.10x10.co.kr/play/ground/20131209/tit_time_capsule_project.gif" alt="TIME CAPSULE PROJECT Write a Card to me in the future 미래의 나에게 카드가 왔다!" /></h3>
		<div class="message">
			<div class="bg"></div>
			<p>어느 날 문득 미래에서 나에게 카드가 온다면?!</p>
			<p>타임캡슐 프로젝트는 현재의 내가 미래의 나에게 하고 싶은 말을 담아 편지를 쓰는 프로젝트입니다.</p>
			<p>반드시 이루고 싶은 목표, 간직하고 싶은 말들을 적어 내려가면서 지금의 나를 돌아보고 미래의 나를 위해 용기를 북돋아 주세요. </p>
			<p>텐바이텐이 당신이 적은 카드 메시지를 타임캡슐 키트에 담아 보내드립니다. 키트에는 메시지가 적힌 타임캡슐과 미래의 꿈을 적을 노트, 펜, 그리고 1년 사계절 함께 꿈을 키워 갈 비밀 씨앗, 과거의 물건을 담아 보관할 수 있는 메모리 팩이 함께 구성되어 있습니다.</p>
			<p>CHANGE, MAKE, HOPE, PASSION의 4가지 키워드를 선택하여 작성 가능하며, 선택하신 컬러의 타임캡슐로 배송 될 예정입니다.</p>
			<p>이벤트 기간 : 12.9 ~ 12.31, 당첨자 발표 : 01.02</p>
		</div>
	</div>

	<div class="writeMeLetter">
		<div class="writeMe" id="writeMeForm">
			<form name="frmcom" method="post" onSubmit="return jsSubmitComment(this);" style="margin:0px;">
			<input type="hidden" name="eventid" value="<%=eCode%>">
			<input type="hidden" name="bidx" value="<%=bidx%>">
			<input type="hidden" name="iCC" value="<%=iCCurrpage%>">
			<input type="hidden" name="iCTot" value="">
			<input type="hidden" name="mode" value="add">
			<input type="hidden" name="userid" value="<%=GetLoginUserID%>">
			<fieldset>
				<legend>미래의 나에게 편지쓰기</legend>
				<p><img src="http://webimage.10x10.co.kr/play/ground/20131209/txt_select_color_new.gif" alt="타임캡슐 컬러 선택하기" /></p>
				<ul class="colorSelect">
					<li>
						<label for="colorSelect01"><img src="http://webimage.10x10.co.kr/play/ground/20131209/ico_select_01_new.gif" alt="PASSION" /></label>
						<input type="radio" id="colorSelect01" name="spoint" value="1"/>
					</li>
					<li>
						<label for="colorSelect02"><img src="http://webimage.10x10.co.kr/play/ground/20131209/ico_select_02_new.gif" alt="CHANGE" /></label>
						<input type="radio" id="colorSelect02" name="spoint" value="2"/>
					</li>
					<li>
						<label for="colorSelect03"><img src="http://webimage.10x10.co.kr/play/ground/20131209/ico_select_03_new.gif" alt="HOPE" /></label>
						<input type="radio" id="colorSelect03" name="spoint" value="3"/>
					</li>
					<li>
						<label for="colorSelect04"><img src="http://webimage.10x10.co.kr/play/ground/20131209/ico_select_04_new.gif" alt="MAKE" /></label>
						<input type="radio" id="colorSelect04" name="spoint" value="4"/>
					</li>
				</ul>

				<div class="letterForm">
					<div class="letterWrite">
						<div class="letterSubjct">
							<img src="http://webimage.10x10.co.kr/play/ground/20131209/txt_to.gif" alt="TO." />
							<input type="text" name="txtcommURL" value="타이틀은 이벤트 화면에 공개됩니다.(최대 12자)" onClick="jsChklogin22('<%=IsUserLoginOK%>');" onblur="jsChkUnblur22()" onKeyUp="jsChklogin22('<%=IsUserLoginOK%>');return Limit(this);" maxlength="12" />
						</div>
						<textarea  cols="50" rows="6" name="txtcomm" title="메시지 입력" value="미래의 나에게 편지를 써주세요.100분을 선정하여 당신의 카드를 담은 타임캡슐 키트를 보내드립니다." class="txtInp"  onClick="jsChklogin11('<%=IsUserLoginOK%>');" onblur="jsChkUnblur()" onKeyUp="jsChklogin11('<%=IsUserLoginOK%>');return Limit(this);" <%IF NOT IsUserLoginOK THEN%>readonly<%END IF%>  autocomplete="off" maxlength="500">미래의 나에게 편지를 써주세요.100분을 선정하여 당신의 카드를 담은 타임캡슐 키트를 보내드립니다.</textarea>
					</div>
				</div>

				<p class="ct"><img src="http://webimage.10x10.co.kr/play/ground/20131209/txt_not_open_new.gif" alt="※ 참여하신 메세지는 다른 고객들에게는 보여지지 않습니다." /></p>

				<div class="btnSubmit">
					<input type="image" src="http://webimage.10x10.co.kr/play/ground/20131209/btn_submit.gif" alt="편지 등록하기" />
				</div>
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

	<div class="letterFromFuture">
		<div class="futureCard">
			<p><img src="http://webimage.10x10.co.kr/play/ground/20131209/txt_from_future_card.jpg" alt="미래에서 온 카드 여러분은 미래의 나에게 어떤 말을 해주고 싶나요? 1년 뒤 혹은 10년 뒤의 나를 그리며 격려의 메시지를 적어주세요.100분을 선정하여 당신의 카드를 담은 타임캡슐키트를 보내드립니다" /></p>
			<div class="btnWriteMe">
				<a href="#writeMeForm"><img src="http://webimage.10x10.co.kr/play/ground/20131209/btn_write_new.gif" alt="미래의 나에게 카드 쓰기" /></a>
			</div>
		</div>
	</div>

	<div class="timeCapsuleSlide">
		<div class="slideWrap">
			<div class="slide">
				<div><img src="http://webimage.10x10.co.kr/play/ground/20131209/img_slide_01.jpg" alt="타임캡슐, 흙, 씨앗, 노트, 펜, 메모리 팩" /></div>
				<div><img src="http://webimage.10x10.co.kr/play/ground/20131209/img_slide_02.jpg" alt="HOPE" /></div>
				<div><img src="http://webimage.10x10.co.kr/play/ground/20131209/img_slide_03.jpg" alt="CHANGE" /></div>
				<div><img src="http://webimage.10x10.co.kr/play/ground/20131209/img_slide_04.jpg" alt="PASSION" /></div>
				<div><img src="http://webimage.10x10.co.kr/play/ground/20131209/img_slide_05.jpg" alt="MAKE" /></div>
				<div><img src="http://webimage.10x10.co.kr/play/ground/20131209/img_slide_06.jpg" alt="CHANGE" /></div>
				<div><img src="http://webimage.10x10.co.kr/play/ground/20131209/img_slide_07.jpg" alt="Hope" /></div>
				<div><img src="http://webimage.10x10.co.kr/play/ground/20131209/img_slide_08.jpg" alt="" /></div>
				<div><img src="http://webimage.10x10.co.kr/play/ground/20131209/img_slide_09.jpg" alt="Change, Make" /></div>
			</div>
		</div>
	</div>

	<div class="timeCapsuleView">
		<div class="btnBuy">
			<a href="http://www.10x10.co.kr/shopping/category_prd.asp?itemid=974342" target="_blank"><img src="http://webimage.10x10.co.kr/play/ground/20131209/btn_buy.gif" alt="스페셜 에디션 타임캡슐 구매하기" title="새창" /></a>
		</div>
		<div>
			<img src="http://webimage.10x10.co.kr/play/ground/20131209/img_moving.gif" alt="Time Capsule DON'T OPEN UNTILE 2013 ~ 2026" />
		</div>
	</div>

	<div class="letterFromFutureList">
		<div class="letterCommenWrap">
			<div class="winWay">
				<p><img src="http://webimage.10x10.co.kr/play/ground/20131209/txt_win_way.gif" alt="타임캡슐 당첨확률을 높이는 방법! 코멘트를 작성후 트위터 또는 페이스북에 프로젝트 내용을 공유해주세요. SNS에 올릴때는 페이스북 @Timecapsule 트위터 #Timecapsule 이라는 해쉬태그를 달아주세요. 타임캡슐 100인에 당첨될 확률이 더욱 높아집니다." /></p>
				<div class="social">
					<a href="" onClick="popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>',''); return false;"><img src="http://fiximage.10x10.co.kr/web2013/common/sns_twitter.gif" alt="트위터" /></a>
					<a href="" onClick="popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','',''); return false;"><img src="http://fiximage.10x10.co.kr/web2013/common/sns_facebook.gif" alt="페이스북" /></a>
				</div>
				<div class="btnWriteMe">
					<a href="#writeMeForm"><img src="http://webimage.10x10.co.kr/play/ground/20131209/btn_write_new.gif" alt="미래의 나에게 카드 쓰기" /></a>
				</div>
			</div>

			<!-- Comment List -->
			<% IF isArray(arrCList) THEN %>
			<div class="letterCommenList">
			<% For intCLoop = 0 To UBound(arrCList,2)%>
			<% If intCLoop = 0 Or intCLoop = 6 then %>
				<div class="letterCommenRow">
			<% End If %>
					<div class="bottleComment bottlebg0<%=arrCList(3,intCLoop)%>">
						<div class="number"><strong>No. <%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1)) %></strong></div>
						<p class="subject"><strong><%=arrCList(7,intCLoop)%></strong></p>
						<div class="author">
							<span><%=Left(arrCList(4,intCLoop),10)%></span>
							<strong><%=printUserId(arrCList(2,intCLoop),2,"*")%>님</strong>
							<% if ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %>
							<a href="javascript:jsDelComment('<% = arrCList(0,intCLoop) %>')"><img src="http://fiximage.10x10.co.kr/web2009/common/cmt_del.gif" width="19" height="11" style="padding-left:5px;" border="0"></a>
							<% end if %>
						</div>
					</div>
			<% If intCLoop = 5 Or intCLoop = 11 Or intCLoop = UBound(arrCList,2)  then %>
				</div>
			<% End If %>
			<% Next %>
			</div>
			<!-- //Comment List -->
			<div class="pageWrapV15">
				<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
			</div>
			<% End If %>
		</div>
	</div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->