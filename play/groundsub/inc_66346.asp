<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<%
'########################################################
' PLAY #25 CAMERA 찰칵
' 2015-09-18 원승현 작성
'########################################################
Dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  64891
Else
	eCode   =  66346
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

	iCPageSize = 8		'한 페이지의 보여지는 열의 수
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
/* scm 등록 부분 */
.groundWrap {width:100%; background:#08b971 url(http://webimage.10x10.co.kr/play/ground/20150921/bg_pattern_green_01.png) no-repeat 50% 0; background-size:1920px auto !important;}
.groundCont {background-color:#fff;}
.groundCont .grArea {width:100%;}
.groundCont .tagView {width:1100px; padding:30px 20px 60px;}
/* scm 등록 부분 */

img {vertical-align:top;}
.playGr20150921 button {background-color:transparent;}
.topic {height:1528px; padding-top:287px; background:#08b971 url(http://webimage.10x10.co.kr/play/ground/20150921/bg_pattern_green_02_v2.png) no-repeat 50% 0; text-align:center;}
.topic .hwrap {position:relative; width:744px; height:384px; margin:0 auto 145px;}
.topic .hwrap h3 {position:absolute; top:78px; left:83px; width:530px; height:246px;}
/*.topic .hwrap h3 span {position:absolute;}
.topic .hwrap h3 .letter1 {top:0; left:0;}
.topic .hwrap h3 .letter2 {top:115px; left:396px;}
.topic .hwrap h3 .letter3 {top:114px; left:237px;}*/
.topic .plan {width:485px; margin:0 auto;}
.topic .plan p {width:485px; background:url(http://webimage.10x10.co.kr/play/ground/20150921/txt_plan.png) no-repeat 50% 0; text-indent:-999em;}
.topic .plan .plan1 {height:82px;}
.topic .plan .plan2 {height:78px; margin-top:66px; background-position:0 -148px;}
.topic .plan .plan3 {height:111px; margin-top:72px; background-position:0 -298px;}
.topic .plan .plan4 {height:13px; margin-top:56px; background-position:0 -464px;}
.topic .plan .plan5 {height:62px; margin-top:57px; background-position:0 100%;}

.article {position:relative; height:1036px;}
.article .start {position:absolute; top:0; left:0; width:100%; height:1036px; z-index:50; background-color:#cbcbcb; text-align:center;}
.start h4 {position:absolute; top:500px; left:50%; width:1133px; height:42px; margin-left:-566px;}
.start h4 span {position:absolute; top:0; height:42px; background:url(http://webimage.10x10.co.kr/play/ground/20150921/tit_start.png) no-repeat 0 0; text-indent:-999em;}
.start h4 .letter1 {left:0; width:355px;}
.start h4 .letter2 {left:780px; width:354px; background-position:100% 0;}
.start .btnstart {position:absolute; top:360px; left:50%; z-index:10; margin-left:-160px;}
.start .line {position:absolute; top:-213px; left:50%; margin-left:-5px; width:3px; height:591px; background:url(http://webimage.10x10.co.kr/play/ground/20150921/bg_green_line.png) repeat-y 50% 0;}

.rolling {width:100%;}
.rolling .swiper {overflow:hidden; position:relative;}
.rolling .swiper .swiper-container {overflow:hidden;}
.rolling .swiper .swiper-wrapper {position:relative;}
.rolling .swiper .swiper-slide {overflow:hidden; float:left; position:relative; width:100%; min-width:1140px; height:1036px; text-align:center;}
.rolling .swiper .btn-prev, .rolling .swiper .btn-next {position:absolute; bottom:75px; left:50%; width:66px; height:84px; text-indent:-9999px; background:url(http://webimage.10x10.co.kr/play/ground/20150921/btn_nav.png) no-repeat 0 0;}
.rolling .swiper .btn-prev {margin-left:-93px;}
.rolling .swiper .btn-prev:hover {background-position:0 -85px;}
.rolling .swiper .btn-next {margin-left:29px; background-position:100% 0;}
.rolling .swiper .btn-next:hover {background-position:100% -85px;}
.rolling .swiper .pagination {display:none; position:absolute; top:370px; left:50%; margin-left:-160px; text-align:center;}
.rolling .swiper .pagination span {display:block; display:none; width:11px; height:11px; margin-top:10px; background:url(http://webimage.10x10.co.kr/play/ground/20150713/btn_pagination.png) no-repeat 0 0; cursor:pointer;}
.rolling .swiper .pagination span:nth-child(2) {display:block; width:320px; height:320px; background:url(http://webimage.10x10.co.kr/play/ground/20150921/btn_start.png) no-repeat 0 0;}
.rolling .swiper .pagination .swiper-active-switch {background-position:100% 0;}

.rolling .swiper .swiper-slide .desc {padding-top:126px;}

.swiper-slide .graphic {position:absolute;}
.swiper-slide-1 {background:#d5c9ac url(http://webimage.10x10.co.kr/play/ground/20150921/bg_beige.png) repeat-x 50% 0;}
.swiper-slide-1 .btnfake {position:absolute; bottom:75px; left:50%; margin-left:-93px; width:66px; height:84px; text-indent:-9999px; background:url(http://webimage.10x10.co.kr/play/ground/20150921/btn_nav.png) no-repeat 0 100%;}
.swiper-slide-1 .graphic {top:400px; left:50%; margin-left:-299px;}
.swiper-slide-2, .swiper-slide-3 {background:#adced6 url(http://webimage.10x10.co.kr/play/ground/20150921/bg_sky.png) repeat-x 50% 0;}
.swiper-slide-2 .graphic, .swiper-slide-3 .graphic {position:absolute; top:411px; left:50%; margin-left:-291px;}
.swiper-slide-2 .people01 {position:absolute; top:627px; left:50%; z-index:5; margin-left:190px;}

.swiper-slide-3 .filmcase {position:absolute; top:461px; left:50%; z-index:5; margin-left:-291px;}
.swiper-slide-3 .film {overflow:hidden; position:absolute; top:504px; left:50%; margin-left:-291px; width:1093px;}
.swiper-slide-3 .film span {float:left;}
.swiper-slide-3 .people02 {}

.swiper-slide-4 {background:#b0d1d9 url(http://webimage.10x10.co.kr/play/ground/20150921/bg_mint_v1.png) repeat-x 50% 0;}
.swiper-slide-4 .graphic {top:325px; left:50%; margin-left:-510px;}
.swiper-slide-4 .after {position:absolute; top:209px; left:50%; margin-left:-510px; height:0; transition:opacity 0.8s ease-out; opacity:0; filter: alpha(opacity=0);}
.swiper-slide-4 .after.show {opacity:1; filter: alpha(opacity=100); height:509px;}
.swiper-slide-4 .btnpush {position:absolute; top:320px; left:50%; z-index:55; margin-left:-240px; -webkit-animation-fill-mode:both; animation-fill-mode:both; webkit-animation-name:bounce; animation-name:bounce; -webkit-animation-duration:3s; animation-duration:3s; -webkit-animation-iteration-count:infinite; animation-iteration-count:infinite;}
/* Bounce animation */
@-webkit-keyframes bounce {
	0%, 20%, 50%, 80%, 100% {-webkit-transform: translateY(0);}
	40% {-webkit-transform: translateY(-10px);}
	60% {-webkit-transform: translateY(-10px);}
}
@keyframes bounce {
	0%, 20%, 50%, 80%, 100% {transform: translateY(0);}
	40% {transform: translateY(-10px);}
	60% {transform: translateY(-10px);}
}

.swiper-slide-5 {background:#ff6b5b url(http://webimage.10x10.co.kr/play/ground/20150921/bg_pattern_red.png) no-repeat 50% 0;}
.swiper-slide-5 .inner {position:relative; width:1140px; height:712px; margin:0 auto; padding-top:128px; background:url(http://webimage.10x10.co.kr/play/ground/20150921/bg_round_box_v1.png) no-repeat 50% 208px; text-align:center;}
.swiper-slide-5 .inner h4 {margin-bottom:77px;}
.swiper-slide-5 .inner .btngo {position:absolute; top:475px; right:206px;}
.swiper-slide-5 .btnfake {position:absolute; bottom:75px; left:50%; margin-left:29px; width:66px; height:84px; text-indent:-9999px; background:url(http://webimage.10x10.co.kr/play/ground/20150921/btn_nav.png) no-repeat 100% 100%;}

.article .commentevt {display:none; position:absolute; top:0; left:0; width:100%; height:965px; z-index:50; background-color:#ff915b;}
.article .commentevt .inner {position:relative; width:1140px; height:951px; margin:0 auto;}
.article .commentevt .btnclose {position:absolute; top:35px; right:20px;}

.form .itext {width:122px; height:123px; background:url(http://webimage.10x10.co.kr/play/ground/20150921/bg_input_text.png) no-repeat 50% 0; color:#656565; font-size:50px; font-family:'Verdana'; line-height:123px; text-align:center;}
.form .field {position:relative; margin:55px 0 57px; padding-left:287px;}
.form .field .btnsubmit {position:absolute; top:15px; left:585px;}
.form .field .itext {margin-right:7px; vertical-align:top;}

.commentlist {padding-top:20px; border-top:1px dashed #e48251;}
.commentlist ul {overflow:hidden; width:1148px; margin:0 auto; padding-left:39px;}
.commentlist ul li {float:left; width:245px; height:174px; margin-right:42px; padding-top:24px; background-repeat:no-repeat; background-position:0 0;}
.commentlist ul li.bg1 {background-image:url(http://webimage.10x10.co.kr/play/ground/20150921/bg_comment_01.png);}
.commentlist ul li.bg2 {background-image:url(http://webimage.10x10.co.kr/play/ground/20150921/bg_comment_02.png);}
.commentlist ul li span, .commentlist ul li strong {display:block;}
.commentlist ul li .no {position:relative; padding-left:3px; font-size:11px; color:#000;}
.commentlist ul li .no em {position:absolute; top:0; right:40px; text-align:right;}
.commentlist ul li strong {width:120px; height:22px; margin-top:86px; margin-left:46px; color:#fff; font-size:22px; line-height:22px; text-align:center;}

.pageWrapV15 {margin-top:35px;}
.pageWrapV15 .pageMove {display:none;}
.paging a {border:1px solid #d77a4d;}
.paging a, .paging a:hover, .paging a.arrow, .paging a.current {background-color:transparent;}
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

		<% if not(left(now(), 10) >= "2015-09-18" And left(now(), 10) < "2015-10-03") then %>
		    alert("이벤트 기간이 아닙니다..");
			return false;
		<% end if %>

	   if(frm.caText1.value == "" ){
	    alert("상상하신 셔터음을 입력해주세요.");
		document.frmcom.caText1.value="";
	    frm.caText1.focus();
	    return false;
	   }

	   if(frm.caText2.value == "" ){
	    alert("상상하신 셔터음을 입력해주세요.");
		document.frmcom.caText2.value="";
	    frm.caText2.focus();
	    return false;
	   }


	   frm.action = "/play/groundsub/doEventSubscript66346.asp";
	   return true;
	}

	function jsDelComment(cidx)	{
		if(confirm("삭제하시겠습니까?")){
			document.frmdelcom.Cidx.value = cidx;
	   		document.frmdelcom.submit();
		}
	}
//-->
</script>
<form name="frmcom" method="post" onSubmit="return jsSubmitComment(this);" style="margin:0px;">
<input type="hidden" name="eventid" value="<%=eCode%>"/>
<input type="hidden" name="bidx" value="<%=bidx%>"/>
<input type="hidden" name="iCC" value="<%=iCCurrpage%>"/>
<input type="hidden" name="iCTot" value=""/>
<input type="hidden" name="mode" value="add"/>
<input type="hidden" name="userid" value="<%=GetEncLoginUserID%>"/>
<input type="hidden" name="eCC" value="1">
<div class="playGr20150921">
	<div class="section topic">
		<div class="hwrap">
			<h3><img src="http://webimage.10x10.co.kr/play/ground/20150921/tit_shutter_v1.png" alt="찰칵" />
				<!--span class="letter1"><img src="http://webimage.10x10.co.kr/play/ground/20150921/tit_chal.png" alt="찰" /></span>
				<span class="letter2"><img src="http://webimage.10x10.co.kr/play/ground/20150921/tit_kak.png" alt="칵" /></span>
				<span class="letter3"><img src="http://webimage.10x10.co.kr/play/ground/20150921/tit_deco.png" alt="" /></span-->
			</h3>
			<div class="camera"><img src="http://webimage.10x10.co.kr/play/ground/20150921/img_camera.jpg" alt="" /></div>
		</div>
		<div class="plan">
			<p class="plan1">무엇이든 빠르고 정확해야만 하는 강박관념 속에 살고 있는 우리에게 여유와 감성을 찾게 해줄 수 있는 것이 무얼까 떠올려 보았을 때 문득 일회용 카메라가 생각났습니다.</p>
			<p class="plan2">그럴싸한 멋이 있는 겉모습도 아니고, 찍었던 사진을 미리 볼 수도 없습니다. 멀리 있는 것을 찍기 위해서는 한 발자국 더 움직여야하고 때로는 불편하기도 한 완전 수동식 카메라.</p>
			<p class="plan3">하지만 꾸밈 없이 날 것의 결과물을 내어주는 필름의 솔직함과, 담고 싶은 순간을 위해 조금 더 집중하게 되고 한 장 한 장 신중하게 찍게 되는 특별한 매력과 재미가 있습니다.</p>
			<p class="plan4">처음 만나거나 혹은 오랜만에 만날 일회용 카메라!</p>
			<p class="plan5">지금 당신의 상상 속 카메라의 셔터음은 어떤 소리인가요?</p>
		</div>
	</div>

	<div class="section article">
		<div class="start">
			<h4>
				<span class="letter1">일회용카메라로</span>
				<span class="letter2">촬영하기</span>
			</h4>
			<button type="button" class="btnstart"><img src="http://webimage.10x10.co.kr/play/ground/20150921/btn_start.png" alt="스타트" /></button>
			<div class="line"></div>
		</div>

		<%' swipe %>
		<div class="rolling">
			<div class="swiper">
				<div class="swiper-container swiper1">
					<div class="swiper-wrapper">
						<div class="swiper-slide swiper-slide-1">
							<p class="desc"><img src="http://webimage.10x10.co.kr/play/ground/20150921/txt_step_01.png" alt="1 구도 잡기 먼저 차분하게 여유를 가지고 주위를 둘러보세요. 멀리 있는 것을 찍기 위해서 한 발자국 더 움직여보고 신중하게, 집중해서 구도를 잡아보세요!" /></p>
							<div class="graphic"><img src="http://webimage.10x10.co.kr/play/ground/20150921/img_step_01.png" alt="" /></div>
							<div class="btnfake"></div>
						</div>
						<div class="swiper-slide swiper-slide-2">
							<p class="desc"><img src="http://webimage.10x10.co.kr/play/ground/20150921/txt_step_02.png" alt="2 필름 돌려주기 찍고자 하는 피사체가 생겼다면, 필름감기레버를 멈출 때까지 돌려주세요! 카메라 안의 필름은 촬영을 준비합니다." /></p>
							<div class="graphic updown"><img src="http://webimage.10x10.co.kr/play/ground/20150921/img_step_02_02_v1.png" alt="" /></div>
							<div class="people01"><img src="http://webimage.10x10.co.kr/play/ground/20150921/img_people_01.png" alt="" /></div>
						</div>
						<div class="swiper-slide swiper-slide-3">
							<p class="desc"><img src="http://webimage.10x10.co.kr/play/ground/20150921/txt_step_02.png" alt="" /></p>
							<div class="graphic"><img src="http://webimage.10x10.co.kr/play/ground/20150921/img_step_02_02_v1.png" alt="" /></div>
							<div class="filmcase"><img src="http://webimage.10x10.co.kr/play/ground/20150921/img_film_case.png" alt="" /></div>
							<div class="film">
								<span class="filmline"><img src="http://webimage.10x10.co.kr/play/ground/20150921/img_film_v1.png" alt="" /></span>
								<span class="people02"><img src="http://webimage.10x10.co.kr/play/ground/20150921/img_people_02.png" alt="" /></span>
							</div>
						</div>
						<div class="swiper-slide swiper-slide-4">
							<p class="desc"><img src="http://webimage.10x10.co.kr/play/ground/20150921/txt_step_03.png" alt="3 셔터 누르기 자, 이제 셔터를 누릅니다. 카메라의 가장 상단에 있는 버튼을 눌러보세요!" /></p>
							<button type="button" class="btnpush"><img src="http://webimage.10x10.co.kr/play/ground/20150921/btn_push.png" alt="" /></button>
							<div class="graphic"><img src="http://webimage.10x10.co.kr/play/ground/20150921/img_step_03_01_v1.png" alt="" /></div>
							<div class="after"><img src="http://webimage.10x10.co.kr/play/ground/20150921/img_step_03_02_v1.png" alt="" /></div>
						</div>
						<div class="swiper-slide swiper-slide-5">
							<div class="inner">
								<h4><img src="http://webimage.10x10.co.kr/play/ground/20150921/tit_question.png" alt="Q.셔터음을 상상해보세요!" /></h4>
								<p><img src="http://webimage.10x10.co.kr/play/ground/20150921/txt_gift.png" alt="우리는 보통 카메라의 셔터음을  찰칵 으로 기억합니다. 여러분의 상상을 더해 새로운 셔터음을 만들어보세요! 응모하신 분들 중 추첨을 통해 총 5분에게 일회용카메라와 필름을 선물로 드립니다." /></p>
								<a href="#commentevt" id="btngo" class="btngo"><img src="http://webimage.10x10.co.kr/play/ground/20150921/btn_go.gif" alt="응모하러 가기" /></a>
							</div>
							<div class="btnfake"></div>
						</div>
					</div>
				<!--div class="pagination"></div-->
			</div>
			<div class="btnwrap">
				<button type="button" class="btn-prev">이전</button>
				<button type="button" class="btn-next">다음</button>
			</div>
		</div>

		<%' for dev msg : 요기부터 개발해주세요 %>
		<div id="commentevt" class="commentevt">
			<div class="inner">
				<!-- form -->
				<div class="form">
					<fieldset>
					<legend>새로운 셔터음 만들기</legend>
						<p><img src="http://webimage.10x10.co.kr/play/ground/20150921/txt_imagine.png" alt="" /></p>
						<div class="field">
							<input type="text" name="caText1" id="caText1" class="itext" maxLength="1" />
							<input type="text" name="caText2" id="caText2" class="itext" maxLength="1" />
							<div class="btnsubmit"><input type="image" src="http://webimage.10x10.co.kr/play/ground/20150921/btn_submit.png" alt="응모하기" onclick="jsSubmitComment();return false;" /></div>
						</div>
					</fieldset>
				</div>
				<% If iCTotCnt > 0 Then %>
					<%' comment list %>
					<div class="commentlist">
						<ul>
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
									<li>
										<span class="no">NO.<%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1)) %> <em><%=printUserId(arrCList(2,intCLoop),2,"*")%></em></span>
										<strong><%=opt1%></strong>
									</li>
								<%
									iColorVal = iColorVal + 1
								%>
							<% Next %>
						</ul>
						<!-- paging -->
						<div class="pageWrapV15">
							<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
						</div>
					</div>
				<% End If %>
				<button type="button" id="btnclose" class="btnclose"><img src="http://webimage.10x10.co.kr/play/ground/20150921/btn_close.png" alt="" /></button>
			</div>
		</div>
	</div>
</div>
</form>
<script>
<!--

$(function(){
	$('.btn-prev').hide();
	if ($('.swiper1 .swiper-wrapper .swiper-slide').length > 1) {
		mySwiper = new Swiper('.swiper1',{
			loop:false,
			resizeReInit:true,
			calculateHeight:true,
			pagination:false,
			paginationClickable:true,
			speed:1000,
			autoplay:false,
			autoplayDisableOnInteraction: true,
			allowSwipeToPrev:true,
			simulateTouch:false,
			onSlideChangeStart: function(){
				$(".swiper-slide-2 .updown").css({"top":"300px"});
				$(".swiper-slide-2 .people01").css({"margin-left":"700px"});
				$(".swiper-slide-3 .filmline").css({"width":"350px"});
				$(".swiper-slide-active").find(".updown").delay(1000).animate({"top":"411px"},2000);
				$(".swiper-slide-active").find(".people01").delay(100).animate({"margin-left":"190px"},2000);
				$(".swiper-slide-active").find(".filmline").delay(500).animate({"width":"584px"},3000);
				$(".swiper-slide-1 .btnfake").hide();
				$(".swiper-slide-active .btnfake").hide();
			},
			onSlideChangeEnd: function () {
				$(".swiper-slide-5 .btnfake").show();
				$('.btn-prev').show()
				$('.btn-next').show()
				if(mySwiper.activeIndex==0){
					$('.btn-prev').hide()
				}
				if(mySwiper.activeIndex==mySwiper.slides.length-1){
					$('.btn-next').hide()
				}
			}
		});
	} else {
		$('.btn-prev').hide();
		$('.btn-next').hide();
	}

	$('.btn-prev').on('click', function(e){
		e.preventDefault()
		mySwiper.swipePrev()
	});
	$('.btn-next').on('click', function(e){
		e.preventDefault()
		mySwiper.swipeNext()
	});

	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 200 ) {
			titleAnimation();
		}
		if (scrollTop > 900 ) {
			planAnimation();
		}
		if (scrollTop > 2200 ) {
			startAnimation();
		}
	});

	/* title animation */
	function titleAnimation() {
		$(".hwrap h3").delay(100).effect("explode", {times:5},1300);
		$(".hwrap h3").delay(900).effect("fade");
	}

	/* start button */
	$(".btnstart").css({"top":"280px"});
	$(".start h4 span").css({"opacity":"0"});
	$(".start h4 .letter1").css({"left":"50px"});
	$(".start h4 .letter2").css({"left":"750px"});
	function startAnimation() {
		$(".start h4 .letter1").delay(800).animate({"left":"0", "opacity":"1"},1000);
		$(".start h4 .letter2").delay(1200).animate({"left":"780px", "opacity":"1"},1000);
		$(".btnstart").delay(200).animate({"top":"360px"},2000);
	}

	$(".btnstart").click(function(){
		$(".start").delay(200).animate({"width":"0"},500);
		$(".btnstart, .start .line, .start h4").hide();
		$(".swiper-slide-1 .graphic").delay(500).animate({"margin-left":"-299px"},3000);
	});
	$(".swiper-slide-1 .graphic").css({"margin-left":"600px"});
	

	$(".btnpush").click(function(){
		$(".after").addClass("show");
		$(".swiper-slide-4 .graphic").fadeOut();
		$(".btnpush").fadeOut();
	});

	$("#btngo").click(function(){
		$("#commentevt").slideDown();
	});
	$("#btnclose").click(function(){
		$("#commentevt").slideUp();
	});

	/* comment random bg */
	var classes = ["bg1", "bg2"];
	$(".commentlist ul li").each(function(){
		$(this).addClass(classes[~~(Math.random()*classes.length)]);
	});

	$(".plan p").css({"opacity":"0"});
	$(".plan .plan1").css({"margin-top":"7px"});
	$(".plan .plan2").css({"margin-top":"60px"});
	$(".plan .plan3").css({"margin-top":"65px"});
	$(".plan .plan4").css({"margin-top":"63px"});
	$(".plan .plan5").css({"margin-top":"65px"});
	function planAnimation () {
		$(".plan .plan1").delay(200).animate({"margin-top":"0", "opacity":"1"},1200);
		$(".plan .plan2").delay(600).animate({"margin-top":"66px", "opacity":"1"},1200);
		$(".plan .plan3").delay(1000).animate({"margin-top":"72px", "opacity":"1"},1200);
		$(".plan .plan4").delay(1500).animate({"margin-top":"56px", "opacity":"1"},1200);
		$(".plan .plan5").delay(2000).animate({"margin-top":"57px", "opacity":"1"},1200);
	}


	<% if eCC = "1" then %>
		$('#commentevt').show();
		window.$('html,body').animate({scrollTop:$("#commentevt").offset().top}, 0);
	<% end if %>
});

//-->
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->