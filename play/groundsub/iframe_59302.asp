<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<%
Dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  "21472"
Else
	eCode   =  "59302"
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

	'arrCList = cEComment.fnGetComment		'리스트 가져오기
	'iSelTotCnt = cEComment.FTotCnt '리스트 총 갯수
	set cEComment = nothing

	'코멘트 데이터 가져오기
	set cEComment = new ClsEvtComment

	cEComment.FECode 		= eCode
	'cEComment.FComGroupCode	= com_egCode
	cEComment.FEBidx    	= bidx
	cEComment.FCPage 		= iCCurrpage	'현재페이지
	cEComment.FPSize 		= iCPageSize	'페이지 사이즈
	cEComment.FTotCnt 		= iCTotCnt  '전체 레코드 수

	'arrCList = cEComment.fnGetComment		'리스트 가져오기
	'iCTotCnt = cEComment.FTotCnt '리스트 총 갯수
	set cEComment = nothing

	iCTotalPage 	=  Int(iCTotCnt/iCPageSize)	'전체 페이지 수
	IF (iCTotCnt MOD iCPageSize) > 0 THEN	iCTotalPage = iCTotalPage + 1

	Dim vQuery, vArr, v1Count, v2Count, v3Count, i
	vQuery = "select evtcom_point, count(evtcom_idx) from [db_event].[dbo].[tbl_event_comment] where evt_code = '" & eCode & "' group by evtcom_point"
	rsget.Open vQuery, dbget, 1
	if not rsget.eof then
		vArr = rsget.getrows()
	end if

	v1Count = "0"
	v2Count = "0"
	v3Count = "0"

	IF isArray(vArr) THEN
		For i =0 To UBound(vArr,2)
			if vArr(0,i) = "1" then
				v1Count = vArr(1,i)
			end if
			if vArr(0,i) = "2" then
				v2Count = vArr(1,i)
			end if
			if vArr(0,i) = "3" then
				v3Count = vArr(1,i)
			end if
		Next
	End IF
%>
<link rel="stylesheet" type="text/css" href="/lib/css/section.css" />
<style type="text/css">
/* iframe css */
.playGr20150223 {}
.section1 {overflow:hidden; position:relative; height:800px; background:#2a2a2a url(http://webimage.10x10.co.kr/play/ground/20150223/bg_dark.png) no-repeat 50% 0;}
.section1 .topic {position:relative; width:1140px; margin:0 auto; padding-top:286px;}
.section1 .topic h1 {margin-left:489px;}
.section1 .topic p {margin-top:7px; margin-left:840px;}
.section1 .topic .person {position:absolute; top:153px; left:-106px; z-index:10;}
.section1 .line {position:absolute; top:265px; left:50%; z-index:5; width:3000px; margin-left:-1500px;}
.section2, .section3 {overflow:hidden; min-width:1140px; height:900px; background-color:#fafafa;}
.section2 .col, .section3 .col {float:left; width:50%; height:900px;}
.section2 .col1 {position:relative;}
.section2 .col1 p {position:absolute; top:50%; left:25%; margin-top:-26px;}
@media all and (min-width:1920px) {
	.section2 .col1 p {left:30%;}
}
.section2 .col1 {background:#fafafa url(http://webimage.10x10.co.kr/play/ground/20150223/bg_photo_01_left.jpg) no-repeat 100% 0;}
.section2 .col2 {background:#aeaeae url(http://webimage.10x10.co.kr/play/ground/20150223/bg_photo_01_right.jpg) no-repeat 0 0;}
.section3 .col1 {background:#656565 url(http://webimage.10x10.co.kr/play/ground/20150223/bg_photo_02_left.jpg) no-repeat 100% 0;}
.section3 .col2 {position:relative; background:#fafafa url(http://webimage.10x10.co.kr/play/ground/20150223/bg_photo_02_right.jpg) no-repeat 0 0;}
.section3 .col2 .desc {position:absolute; top:302px; left:30%;}
.section3 .col2 .desc p {margin-bottom:36px;}

.section4 {background:#d7d7d7 url(http://webimage.10x10.co.kr/play/ground/20150223/bg_polygon.png) no-repeat 50% 722px; text-align:center;}
.section4 .hgroup {padding-top:130px; padding-bottom:72px;}
.section4 h2 {position:relative; padding-bottom:12px;}
.section4 h2 span {position:absolute; bottom:0; left:50%; width:422px; margin-left:-211px; border-bottom:4px solid #000;}
.section4 .hgroup p {margin-top:40px;}
.section4 .article {overflow:hidden; position:relative; z-index:5; width:1048px; height:511px; margin:0 auto; padding-bottom:172px;}
.section4 .article .bg {position:absolute; left:0; top:0; width:100%; height:100%;}
.section4 .article .desc {width:400px;}
.section4 .article1 .bg {background:url(http://webimage.10x10.co.kr/play/ground/20150223/bg_profile_01.png) no-repeat 0 0;}
.section4 .article2 .bg {background:url(http://webimage.10x10.co.kr/play/ground/20150223/bg_profile_02.png) no-repeat 0 0;}
.section4 .article2 .desc {padding-left:300px;}
.section4 .article2 {padding-bottom:119px;}
.section4 .article3 {padding-bottom:129px;}
.section4 .article3 .bg {background:url(http://webimage.10x10.co.kr/play/ground/20150223/bg_profile_03.png) no-repeat 0 0;}

.section5 {padding:120px 0 106px; background:#3f3f3f url(http://webimage.10x10.co.kr/play/ground/20150223/bg_pattern_grid.png) repeat 0 0;}
.event {width:1140px; margin:0 auto; text-align:center;}
.event h2 {position:relative; padding-bottom:12px;}
.event h2 span {position:absolute; bottom:0; left:50%; width:390px; margin-left:-195px; border-bottom:4px solid #edf569;}
.event h2 + p {margin-top:84px;}
.field ul {overflow:hidden; width:1050px; margin:96px auto 76px;}
.field ul li {float:left; position:relative; margin:0 31px;}
.field ul li label {display:block; margin-bottom:19px;}
.field ul li p {position:absolute; top:216px; left:0; width:100%;}
.field ul li p img {vertical-align:middle; margin-top:-10px;}
.field ul li p em {color:#edf569; font-family:'Courier New', 'Verdana', 'Dotum'; font-size:34px; line-height:0.75em;}
.field ul li p span {display:block;}
</style>
<script type="text/javascript" src="/lib/js/jquery.slides.min.js"></script>
<script type="text/javascript">

</script>
<script type="text/javascript">
<!--
 	function jsSubmitComment(){
	   var frm = document.frmcom;
		<% if Not(IsUserLoginOK) then %>
		    jsChklogin('<%=IsUserLoginOK%>');
		    return false;
		<% else %>
			if (!frm.spoint[0].checked && !frm.spoint[1].checked && !frm.spoint[2].checked)
			{
				alert("당신의 집을 안전하게 지켜줄 '그'를 선택하세요!")
				return false;
			}
		<% end if %>

	   frm.action = "doEventSubscript59302.asp";
	   frm.submit();
	   return true;
	}
//-->
</script>
<div class="playGr20150223">
	<div class="shoesGuard">
		<div id="animation1" class="section1">
			<div class="topic">
				<h1><img src="http://webimage.10x10.co.kr/play/ground/20150223/tit_shoes_guard.png" alt="신발가드" /></h1>
				<p><img src="http://webimage.10x10.co.kr/play/ground/20150223/txt_shoes_guard.png" alt="혼자 사는 당신을 지켜주는 든든한 신발가드" /></p>
				<span class="person"><img src="http://webimage.10x10.co.kr/play/ground/20150223/img_person.png" alt="" /></span>
			</div>
			<div class="line"><img src="http://webimage.10x10.co.kr/play/ground/20150223/bg_line.png" alt="" /></div>
		</div>

		<div class="section2">
			<div id="animation2" class="col col1">
				<p><img src="http://webimage.10x10.co.kr/play/ground/20150223/txt_somebody.png" alt="혼자 있는 무서움 속에서 나를 지켜 줄 든든한 누군가가 필요하신가요?" /></p>
			</div>
			<div class="col col2"></div>
		</div>

		<div class="section3">
			<div class="col col1"></div>
			<div id="animation3" class="col col2">
				<div class="desc">
					<p><img src="http://webimage.10x10.co.kr/play/ground/20150223/txt_mean_01.png" alt="텐바이텐 플레이는 단순히 이동하기 위해 신는 신발이 아닌 함께 두는 존재만으로도 안심되는 신발가드를 준비하였습니다." /></p>
					<p><img src="http://webimage.10x10.co.kr/play/ground/20150223/txt_mean_02.png" alt="특히나 혼자 사는 분들에게 필요한 안전한 보디가드 그 역할을 해 줄 신발가드를 현관에 함께 두세요." /></p>
					<p><img src="http://webimage.10x10.co.kr/play/ground/20150223/txt_mean_03.png" alt="어두운 밤, 무서움으로부터 신발가드가 여러분을 지켜드릴 거에요." /></p>
				</div>
			</div>
		</div>

		<div class="section4">
			<div class="hgroup">
				<h2><img src="http://webimage.10x10.co.kr/play/ground/20150223/tit_profile.png" alt="Shoes Guard PROFILE" /><span></span></h2>
				<p><img src="http://webimage.10x10.co.kr/play/ground/20150223/txt_define.png" alt="신발가드란 혼자 사니는 분들의 집에 두는 남자 신발로 텐바이텐이 보내드리는 슈즈 보디가드의 신조어입니다." /></p>
			</div>

			<div class="article article1">
				<div class="bg"></div>
				<div class="desc">
					<h3>신사옵화</h3>
					<p>똑 부러지며 날렵한 얼굴에 정갈한 매무새를 지닌, 스마트하며 일 처리가 깔끔한 남자. 온종일 서 있을 수 없는 체력 부족의 단점과 재빨리 착용하고 뛰쳐나가기에는 다소 어려운 순발력의 부재가 있지만, 전투력만큼은 남들 못지 않은 편. 주 무기에는 정강이 히트가 있음.</p>
				</div>
			</div>

			<div class="article article2">
				<div class="bg"></div>
				<div class="desc">
					<h3>몸짱옵화</h3>
					<p>다부진 체격과 단단한 근육으로 무장한 전직 운동선수 출신인 몸짱옵화. 운동을 좋아하는 그에게는 전광석화와 같은 스피드가 있으며, 가볍고 날렵한 몸놀림은 언제든지 발 빠른 추격을 가능하게 함. 하지만 다소 약한 피부로 인해 보호력이 떨어지는 것이 유일한 약점. 주 무기에는 돌려차기, 이단옆차기, 점프가 있음.</p>
				</div>
			</div>

			<div class="article article3">
				<div class="bg"></div>
				<div class="desc">
					<h3>키다리옵화</h3>
					<p>자칫 군인으로 보일 수 있지만 모델같이 큰 키와 묵직한 매력을 지닌 남자. 자유로운 영혼을 지닌 듯 하지만 그렇다고 부드럽다고는 할 수는 없는 터프한 성격. 전투력, 보호력, 체력 등 모든 면에서 우월하지만, 순발력은 다소 떨어지는 것이 약점. 주 무기에는 찍어차기가 있음.</p>
				</div>
			</div>
		</div>

		<!-- event -->
		<div class="section5">
			<div class="event">
				<h2><img src="http://webimage.10x10.co.kr/play/ground/20150223/tit_event.png" alt="Shoes Guard EVENT" /><span></span></h2>
				<p><img src="http://webimage.10x10.co.kr/play/ground/20150223/txt_event.png" alt="당신의 집을 안전하게 지켜줄 그를 선택하세요! 추첨을 통해 3분께 신발가드가 찾아갑니다. 이벤트 기간은 2월 23일부터 3월 4일까지며 발표는 3월 6일입니다. 신발 사이즈는 랜덤으로 발송됩니다." /></p>
				<div id="field" class="field">
					<form name="frmcom" method="post" style="margin:0px;">
					<input type="hidden" name="eventid" value="<%=eCode%>"/>
					<input type="hidden" name="bidx" value="<%=bidx%>"/>
					<input type="hidden" name="iCC" value="<%=iCCurrpage%>"/>
					<input type="hidden" name="iCTot" value=""/>
					<input type="hidden" name="mode" value="add"/>
					<input type="hidden" name="userid" value="<%=GetLoginUserID%>"/>
						<fieldset>
						<legend>당신의 집을 안정하세 지켜줄 그 선택하기</legend>
							<ul>
								<li>
									<label for="select01"><img src="http://webimage.10x10.co.kr/play/ground/20150223/txt_label_01.png" alt="신사옵화" /></label>
									<input type="radio" id="select01" name="spoint" value="1" />
									<p>
										<em><%=v1Count%></em> <img src="http://webimage.10x10.co.kr/play/ground/20150223/txt_num_01.png" alt="명이" />
										<span><img src="http://webimage.10x10.co.kr/play/ground/20150223/txt_num_02.png" alt="보호의 손길을 기다리고있습니다!" /></span>
									</p>
								</li>
								<li>
									<label for="select02"><img src="http://webimage.10x10.co.kr/play/ground/20150223/txt_label_02.png" alt="몸짱옵화" /></label>
									<input type="radio" id="select02" name="spoint" value="2" />
									<p>
										<em><%=v2Count%></em> <img src="http://webimage.10x10.co.kr/play/ground/20150223/txt_num_01.png" alt="명이" />
										<span><img src="http://webimage.10x10.co.kr/play/ground/20150223/txt_num_02.png" alt="보호의 손길을 기다리고있습니다!" /></span>
									</p>
								</li>
								<li>
									<label for="select03"><img src="http://webimage.10x10.co.kr/play/ground/20150223/txt_label_03.png" alt="키다리옵화" /></label>
									<input type="radio" id="select03" name="spoint" value="3" />
									<p>
										<em><%=v3Count%></em> <img src="http://webimage.10x10.co.kr/play/ground/20150223/txt_num_01.png" alt="명이" />
										<span><img src="http://webimage.10x10.co.kr/play/ground/20150223/txt_num_02.png" alt="보호의 손길을 기다리고있습니다!" /></span>
									</p>
								</li>
							</ul>
							<img src="http://webimage.10x10.co.kr/play/ground/20150223/btn_submit.png" alt="응모하기" style="cursor:pointer;" onclick="jsSubmitComment();return false;" />
						</fieldset>
					</form>
				</div>
			</div>
		</div>

	</div>
</div>
<script type="text/javascript">
$(function(){
	/* label select */
	$("#field label").click(function(){
		labelID = $(this).attr("for");
		$('#'+labelID).trigger("click");
	});

	/* animation effect */
	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 20 ) {
			animation1();
		}
		if (scrollTop > 1000 ) {
			animation2();
		}
		if (scrollTop > 1700 ) {
			animation3();
		}
		if (scrollTop > 2800 ) {
			animation4();
		}
		if (scrollTop > 5000 ) {
			animation5();
		}
	});

	$("#animation1 .line").hide().animate({width:"0"},100);
	$("#animation1 h1").css({"opacity":"0"});
	$("#animation1 p").css({"opacity":"0"});
	$("#animation1 .person").css({"opacity":"0"});
	function animation1 () {
		$(".line").show().animate({width:"3000px"},2500);
		$("#animation1 .person").delay(100).animate({"opacity":"1"},500);
		$("#animation1 h1").delay(100).animate({"opacity":"1"},1000);
		$("#animation1 p").delay(500).animate({"opacity":"1"},2000);
	}

	$("#animation2 p").hide();
	function animation2 () {
		$("#animation2 p").fadeIn("slow");
	}

	$("#animation3 .desc").hide();
	function animation3 () {
		$("#animation3 .desc").fadeIn("slow");
	}

	$(".section4 h2 span").animate({width:"0"}, 100);
	function animation4 () {
		$(".section4 h2 span").animate({width:"422px"},900);
	}

	$(".event h2 span").animate({width:"0"}, 100);
	function animation5 () {
		$(".event h2 span").animate({width:"390px"},900);
	}
});
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->