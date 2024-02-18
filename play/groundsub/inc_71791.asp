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
' Description : PLAY 32-2 W
' History : 2016-07-08 원승현 생성
'####################################################
Dim eCode , pagereload
IF application("Svr_Info") = "Dev" THEN
	eCode   =  66167
Else
	eCode   =  71791
End If

dim com_egCode, bidx , commentcount
	Dim cEComment
	Dim iCTotCnt, arrCList,intCLoop, iSelTotCnt
	Dim iCPageSize, iCCurrpage
	Dim iCStartPage, iCEndPage, iCTotalPage, iCx,iCPerCnt
	Dim timeTern, totComCnt, eCC

	'파라미터값 받기 & 기본 변수 값 세팅
	iCCurrpage = requestCheckVar(Request("iCC"),10)	'현재 페이지 번호
	com_egCode = requestCheckVar(Request("eGC"),1)
	eCC = requestCheckVar(Request("eCC"), 1) 
	pagereload	= requestCheckVar(request("pagereload"),2)

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
%>
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/section.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<style type="text/css">
.groundWrap {width:100%; background:#e0e1df url(http://webimage.10x10.co.kr/play/ground/20160711/bg_head.jpg) 50% 0 no-repeat; background-size:1920px 260px !important;}
.groundCont {position:relative; padding-bottom:0; background-color:#fff;}
.groundCont .grArea {width:100%;}
.groundCont .tagView {width:1100px; margin-top:30px; padding:28px 20px 60px;}
.floatMenu {display:none; position:fixed; right:5%; bottom:50px; z-index:10000;}
.jewelryCont {position:relative; width:1140px; margin:0 auto;}
.intro {height:887px; padding-top:80px; background:#d8d8d8 url(http://webimage.10x10.co.kr/play/ground/20160711/bg_intro.jpg) 50% 0 no-repeat;}
.intro .title {position:relative; width:660px; height:802px; margin:0 auto; background:url(http://webimage.10x10.co.kr/play/ground/20160711/bg_line.png) 0 0 no-repeat;}
.intro .valuable {position:absolute; left:50%; top:106px; margin-left:-141px;}
.intro h2 p {position:absolute; left:50%; top:181px; margin-left:-190px;}
.intro h2 span {display:block; position:absolute; top:228px;}
.intro h2 span.t1 {left:159px;}
.intro h2 span.t2 {left:204px; height:126px; background:url(http://webimage.10x10.co.kr/play/ground/20160711/tit_jewelry_02.png) 50% 0 no-repeat;}
.intro h2 span.t3 {left:375px;}
.intro .purpose {position:absolute; left:50%; top:446px; margin-left:-181px;}
.jewelryBox .tabNav {height:879px; padding-top:97px; background:#554e45 url(http://webimage.10x10.co.kr/play/ground/20160711/bg_tab.png) 50% 0 no-repeat;}
.jewelryBox .tabNav ul {position:relative; width:750px; height:738px; margin:0 auto;}
.jewelryBox .tabNav li {position:absolute;}
.jewelryBox .tabNav li span {display:none; position:absolute; left:34px; bottom:34px; width:370px; height:113px; background:url(http://webimage.10x10.co.kr/play/ground/20160711/bg_current.png) 0 0 no-repeat;}
.jewelryBox .tabNav li.current span {display:block;}
.jewelryBox .tabNav li.jBox1 {left:-34px; bottom:-34px;}
.jewelryBox .tabNav li.jBox2 {right:-34px; top:-34px;}
.jewelryBox .tabNav li.jBox3 {left:-34px; top:-34px;}
.jewelryBox .tabNav li.jBox4 {right:-34px; bottom:-34px;}
.jewelryBox .jContent {min-width:1140px; position:relative; height:886px; border-bottom:3px solid #fff; background-position:50% 0; background-repeat:no-repeat; background-size:2300px;}
.jewelryBox .jContent .txt {position:absolute; left:50%; margin-top:10px; opacity:0;}
.jewelryBox #tab1 {background-image:url(http://webimage.10x10.co.kr/play/ground/20160711/img_cont_01.jpg); background-color:#cd8a5b;}
.jewelryBox #tab2 {background-image:url(http://webimage.10x10.co.kr/play/ground/20160711/img_cont_02.jpg); background-color:#dbdad8;}
.jewelryBox #tab3 {background-image:url(http://webimage.10x10.co.kr/play/ground/20160711/img_cont_03.jpg); background-color:#f5f0ea;}
.jewelryBox #tab4 {height:866px; background-image:url(http://webimage.10x10.co.kr/play/ground/20160711/img_cont_04.jpg); background-color:#eae9e8; background-size:2300px;}
.jewelryBox #tab1 .txt {top:250px; margin-left:-160px;}
.jewelryBox #tab2 .txt {top:125px; margin-left:-602px;}
.jewelryBox #tab3 .txt {top:91px; margin-left:-245px;}
.jewelryBox #tab4 .txt {top:205px; margin-left:-457px;}
.yourItem {position:relative; background:#90d7d1;}
.yourItem .bg {position:absolute; left:0%; top:0; width:50%; height:100%; margin-left:-570px; background:#a4dee9;}
.jewelryWrite {height:487px; text-align:center; background:#dd9939 url(http://webimage.10x10.co.kr/play/ground/20160711/bg_diamond.png) 50% 0 no-repeat;}
.jewelryWrite h3 {padding:77px 0 36px;}
.jewelryWrite .writeBox {position:relative; width:705px; height:186px; margin:0 auto; text-align:left; background:#f8f8f8;}
.jewelryWrite .writeBox input {width:240px; height:60px; padding:0 10px; font-size:20px; border:1px solid #9e9e9e;}
.jewelryWrite .writeBox .btnApply {position:absolute; right:0; top:0;}
.jewelryWrite .myJewelryIs {padding:28px 0 0 78px;}
.jewelryList {padding:50px 0 80px; background:#ddd url(http://webimage.10x10.co.kr/play/ground/20160711/blt_arrow.png) 50% 0 no-repeat;}
.jewelryList .jewelryCont {width:1180px;}
.jewelryList .total {padding:0 28px 20px 0; text-align:right; font-size:12px; color:#777; font-family:arial; letter-spacing:1px;}
.jewelryList ul {overflow:hidden;}
.jewelryList li {float:left; position:relative; width:207px; height:206px; margin:0 16px 15px 15px; padding:0 30px 8px 26px; background:url(http://webimage.10x10.co.kr/play/ground/20160711/bg_box.png) 0 0 no-repeat;}
.jewelryList li p {padding:58px 0 40px; font-size:18px; line-height:27px; color:#505050; font-weight:bold;}
.jewelryList li p em {color:#e9a33a;}
.jewelryList li div {overflow:hidden; padding-top:7px; color:#b3b3b3; border-top:1px solid #e0e0e0;}
.jewelryList li .writer {float:left;}
.jewelryList li .writer img {margin-right:0.5rem;}
.jewelryList li .num {float:right; text-align:right;}
.jewelryList .delete {display:inline-block; position:absolute; right:16px; top:10px;}
.jewelryList .pageMove,
.jewelryList .paging .first,
.jewelryList .paging .end {display:none;}
.jewelryList .paging {height:34px;}
.jewelryList .paging a {height:34px; line-height:34px; border:1px solid #dd9939; background-color:#ddd; margin:0 9px; border-radius:50%;}
.jewelryList .paging a span {width:34px; height:34px; font-size:12px; font-weight:bold; color:#dd9939; padding:0;}
.jewelryList .paging a.arrow {background-color:#fff; border:0;}
.jewelryList .paging a.arrow span {width:34px; height:34px; background-image:url(http://webimage.10x10.co.kr/play/ground/20160711/paging_arrow.png); background-repeat:no-repeat; background-color:#ddd; text-indent:-9999px; padding:0;}
.jewelryList .paging a.current {background-color:#dd9939; border:1px solid #dd9939; color:#fff;}
.jewelryList .paging a.current span,
.jewelryList .paging a.current:hover {color:#fff; background-color:#dd9939;}
.jewelryList .paging a.prev span {background-position:0 0;}
.jewelryList .paging a.next span {background-position:100% 0;}
.jewelryList .paging a:hover {color:#fff; background-color:#dd9939;}
.jewelryList .paging a:hover span {color:#fff;}
</style>
<script type="text/javascript">
$(function(){

	<% if pagereload<>"" then %>
		setTimeout("pagedown()",500);
	<% end if %>

	// title animation
	$(".intro h2 p").css({"margin-top":"5px","opacity":"0"});
	$(".intro h2 span.t1").css({"margin-left":"50px","opacity":"0"});
	$(".intro h2 span.t2").css({"left":"244px","width":"0"});
	$(".intro h2 span.t3").css({"margin-left":"-70px","opacity":"0"});
	$(".intro .purpose").css({"margin-top":"10px","opacity":"0"});
	function titleAnimation() {
		$(".intro h2 p").delay(100).animate({"margin-top":"0",'opacity':'1'},1000);
		$(".intro h2 span.t1").delay(1000).animate({"margin-left":"0",'opacity':'1'},1200);
		$(".intro h2 span.t2").delay(1000).animate({"left":"204px","width":"164px"},1200);
		$(".intro h2 span.t3").delay(1000).animate({"margin-left":"0",'opacity':'1'},1200);
		$(".intro .purpose").delay(1800).animate({"margin-top":"0",'opacity':'1'},800);
	}
	
	// tab
	$(".jewelryBox .tabNav li a").click(function(event){
		$(".jewelryBox .tabNav li").removeClass('current');
		$(this).parents('li').addClass('current');
		var currentTab = $(this).attr('name');
		$('.jewelryBox #'+currentTab).delay(50).animate({backgroundSize:'1920px', "opacity":"1"},1200);
		$('.jewelryBox #'+currentTab).find('.txt').delay(100).animate({"margin-top":"0","opacity":"1"},900);
		event.preventDefault();
		window.parent.$('html,body').animate({scrollTop:$(this.hash).offset().top}, 800);
	});
	$(".floatMenu a").click(function(event){
		event.preventDefault();
		window.parent.$('html,body').animate({scrollTop:$(this.hash).offset().top}, 800);
	});

	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 100) {
			titleAnimation();
		}
		if (scrollTop > 2300) {
			$('.floatMenu').fadeIn();
			$('.jewelryBox #tab1').delay(50).animate({backgroundSize:'1920px', "opacity":"1"},1200);
			$('.jewelryBox #tab1 .txt').delay(100).animate({"margin-top":"0","opacity":"1"},900);
		}
		if (scrollTop > 3200) {
			$('.jewelryBox #tab2').delay(50).animate({backgroundSize:'1920px', "opacity":"1"},1200);
			$('.jewelryBox #tab2 .txt').delay(100).animate({"margin-top":"0","opacity":"1"},900);
		}
		if (scrollTop > 4100) {
			$('.jewelryBox #tab3').delay(50).animate({backgroundSize:'1920px', "opacity":"1"},1200);
			$('.jewelryBox #tab3 .txt').delay(100).animate({"margin-top":"0","opacity":"1"},900);
		}
		if (scrollTop > 5000) {
			$('.jewelryBox #tab4').delay(50).animate({backgroundSize:'1920px', "opacity":"1"},1200);
			$('.jewelryBox #tab4 .txt').delay(100).animate({"margin-top":"0","opacity":"1"},900);
		}
	});
});

function pagedown(){
	window.$('html,body').animate({scrollTop:$(".jewelryList").offset().top}, 0);
}

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

	if(!frm.txtcomm.value){
		alert("여러분의 보석함은 어떤 모습인가요?");
		document.frmcom.txtcomm.value="";
		frm.txtcomm.focus();
		return false;
	}

	if (GetByteLength(frm.txtcomm.value) > 14){
		alert("제한길이를 초과하였습니다. 7자 까지 작성 가능합니다.");
		frm.txtcomm.focus();
		return;
	}

	frm.action = "/play/groundsub/doEventSubscript71791.asp";
	frm.submit();
	return true;
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
		if(document.frmcom.txtcomm.value =="7자 이내로 적어주세요."){
			document.frmcom.txtcomm.value="";
		}
		return true;
	} else {
		jsChklogin('<%=IsUserLoginOK%>');
	}

	return false;
}

function fnOverNumberCut(){
	var t = $("#txtcomm").val();
	if($("#txtcomm").val().length >= 7){
		$("#txtcomm").val(t.substr(0, 7));
	}
}
//-->
</script>
<div class="groundCont">
	<div class="grArea">

		<%' JEWELRY #2 %>
		<div class="playGr20160711">
			<%' intro %>
			<div class="intro">
				<div class="title">
					<p class="valuable"><img src="http://webimage.10x10.co.kr/play/ground/20160711/txt_valuable.png" alt="VALUABLE" /></p>
					<h2>
						<p><img src="http://webimage.10x10.co.kr/play/ground/20160711/tit_precious.png" alt="소중함을 담은" /></p>
						<span class="t1"><img src="http://webimage.10x10.co.kr/play/ground/20160711/tit_jewelry_01.png" alt="보석함" /></span>
						<span class="t2"></span>
						<span class="t3"><img src="http://webimage.10x10.co.kr/play/ground/20160711/tit_jewelry_03.png" alt="" /></span>
					</h2>
					<p class="purpose"><img src="http://webimage.10x10.co.kr/play/ground/20160711/txt_purpose.png" alt="여러분의 보석함은 어떤 모습인가요? 어렸을 적 엄마와 함께 찍었던 사진이 담긴 앨범, 별보며 들었던 설렘 가득한 그 노래 리스트, 우리는 각자 자신만의 보석함에 소중한 것을 담곤 합니다. 여러분의 보석함은 어떤 것인가요? 어떤 것을 담느냐에 따라 달라지는 보석함의 모습! 여러분의 보석함에 소중한 것을 담아보세요!" /></p>
				</div>
			</div>

			<%' 보석함 %>
			<div class="jewelryBox">
				<p class="floatMenu"><a href="#tabNav"><img src="http://webimage.10x10.co.kr/play/ground/20160711/btn_go.png" alt="" /></a></p>
				<div class="tabNav" id="tabNav">
					<ul>
						<li class="jBox1 current"><a href="#tab1" name="tab1"><span></span><img src="http://webimage.10x10.co.kr/play/ground/20160711/tab_01.png" alt="추억함" /></a></li>
						<li class="jBox2"><a href="#tab2" name="tab2"><span></span><img src="http://webimage.10x10.co.kr/play/ground/20160711/tab_02.png" alt="노래함" /></a></li>
						<li class="jBox3"><a href="#tab3" name="tab3"><span></span><img src="http://webimage.10x10.co.kr/play/ground/20160711/tab_03.png" alt="기억함" /></a></li>
						<li class="jBox4"><a href="#tab4" name="tab4"><span></span><img src="http://webimage.10x10.co.kr/play/ground/20160711/tab_04.png" alt="보관함" /></a></li>
					</ul>
				</div>
				<div id="tab1" class="jContent">
					<span class="arrow"><img src="http://webimage.10x10.co.kr/playmo/ground/20160711/blt_triangle.png" alt="" /></span>
					<p class="txt"><img src="http://webimage.10x10.co.kr/play/ground/20160711/txt_cont_01.png" alt="기억함 - 그때 그 추억을 고스란히 담아 미래에 꺼내볼 수 있는 보석함" /></p>
				</div>
				<div id="tab2" class="jContent">
					<p class="txt"><img src="http://webimage.10x10.co.kr/play/ground/20160711/txt_cont_02.png" alt="노래함 -함께 별보며 들었던 노래를 생생하게 들을 수 있는 보석함" /></p>
				</div>
				<div id="tab3" class="jContent">
					<p class="txt"><img src="http://webimage.10x10.co.kr/play/ground/20160711/txt_cont_03.png" alt="추억함 - 여행에서 만난 반짝였던 순간, 기억을 담은 보석함 " /></p>
				</div>
				<div id="tab4" class="jContent">
					<p class="txt"><img src="http://webimage.10x10.co.kr/play/ground/20160711/txt_cont_04.png" alt="보관함 - 나의 이야기와 작업물들을 꾹꾹 담은 보석함 " /></p>
				</div>
			</div>

			<%' 여러분 %>
			<div class="yourItem">
				<div class="jewelryCont">
					<p><img src="http://webimage.10x10.co.kr/play/ground/20160711/txt_put.jpg" alt="4가지의 보석함에 소중한 것들을 담아주세요." usemap="#itemMap" /></p>
					<map name="itemMap" id="itemMap">
						<area shape="rect" coords="503,305,688,512" href="/shopping/category_prd.asp?itemid=1427082&amp;pEtr=71791" alt="에그 타임 캡슐" />
						<area shape="rect" coords="757,117,1051,507" href="/shopping/category_prd.asp?itemid=917509&amp;pEtr=71791" alt="아이코닉 포토인 포토앨범" />
						<area shape="rect" coords="501,556,692,720" href="/shopping/category_prd.asp?itemid=1091239&amp;pEtr=71791" alt="아이리버 스피커" />
						<area shape="rect" coords="771,528,1042,722" href="/shopping/category_prd.asp?itemid=851761&amp;pEtr=71791" alt="유에너스 카드형 USB메모리 16GB" />
					</map>
				</div>
				<div class="bg"></div>
			</div>

			<%' 코멘트 작성 %>
			<form name="frmcom" method="post" onSubmit="return false;" style="margin:0px;">
			<input type="hidden" name="eventid" value="<%=eCode%>"/>
			<input type="hidden" name="bidx" value="<%=bidx%>"/>
			<input type="hidden" name="iCC" value="<%=iCCurrpage%>"/>
			<input type="hidden" name="iCTot" value=""/>
			<input type="hidden" name="mode" value="add"/>
			<input type="hidden" name="userid" value="<%=GetEncLoginUserID%>"/>
			<input type="hidden" name="eCC" value="1">
			<input type="hidden" name="pagereload" value="ON">
			<div class="jewelryWrite">
				<div class="jewelryCont">
					<h3><img src="http://webimage.10x10.co.kr/play/ground/20160711/txt_apply.png" alt="여러분의 보석함은 어떤 모습인가요? 여러분의 보석함을 소개해주세요! 추첨을 통해 5분에게 소중함을 담은 보석함Kit를 드립니다." /></h3>
					<div class="writeBox">
						<div class="myJewelryIs">
							<p><img src="http://webimage.10x10.co.kr/play/ground/20160711/txt_my_01.png" alt="나의 보석함은" /></p>
							<p><input type="text" placeholder="7자 이내로 입력" id="txtcomm" placeholder="5자 이내" name="txtcomm" onkeyup="fnOverNumberCut();" onClick="jsChklogin22('<%=IsUserLoginOK%>');" maxlength="7" /><img src="http://webimage.10x10.co.kr/play/ground/20160711/txt_my_02.png" alt="다." /></p>
						</div>
						<button type="submit" class="btnApply" onclick="jsSubmitComment(document.frmcom);"><img src="http://webimage.10x10.co.kr/play/ground/20160711/btn_apply.png" alt="응모하기" /></button>
					</div>
				</div>
			</div>
			</form>
			<form name="frmdelcom" method="post" action="/play/groundsub/doEventSubscript71791.asp" style="margin:0px;">
			<input type="hidden" name="eventid" value="<%=eCode%>">
			<input type="hidden" name="bidx" value="<%=bidx%>">
			<input type="hidden" name="Cidx" value="">
			<input type="hidden" name="mode" value="del">
			<input type="hidden" name="userid" value="<%=GetEncLoginUserID%>">
			<input type="hidden" name="pagereload" value="ON">
			</form>
			<%' 코멘트 리스트 %>
			<% IF isArray(arrCList) THEN %>
				<div class="jewelryList"  id="commentlist">
					<div class="jewelryCont">
						<p class="total">Total.<%=FormatNumber(iCTotCnt,0)%></p>
						<ul>
							<%' 리스트 8개씩 노출 %>
							<% For intCLoop = 0 To UBound(arrCList,2) %>
								<li>
									<p>나의 보석함은<br/><em><%=arrCList(1,intCLoop)%></em>다.</p>
									<div>
										<span class="writer"><% If arrCList(8,intCLoop) = "M" Then %><img src="http://webimage.10x10.co.kr/play/ground/20160711/ico_mobile.png" alt="모바일에서 작성" /><% End If %><%=printUserId(arrCList(2,intCLoop),2,"*")%></span>
										<span class="num">No.<%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1)) %></span>
									</div>
									<% if ((GetEncLoginUserID = arrCList(2,intCLoop)) or (GetEncLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %>
										<a href="" class="delete" onclick="jsDelComment('<% = arrCList(0,intCLoop) %>');return false;"><img src="http://webimage.10x10.co.kr/play/ground/20160711/btn_delete.png" alt="삭제" /></a>
									<% End If %>
								</li>
							<% Next %>
						</ul>
						<div class="pageWrapV15 tMar20">
							<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
						</div>
					</div>
				</div>
			<% End If %>
		</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->