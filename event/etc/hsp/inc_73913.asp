<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈 : 일상의 +@ Tehtava
' History : 2016-11-08 유태욱 생성
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
<!-- #include virtual="/lib/classes/item/itemInfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryPrdCls.asp" -->
<%
dim oItem
dim currenttime
	currenttime =  now()
'	currenttime = #11/09/2016 09:00:00#

dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  66230
Else
	eCode   =  73913
End If

dim userid, commentcount, i
	userid = GetEncLoginUserID()

commentcount = getcommentexistscount(userid, eCode, "", "", "", "Y")

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
	iCPageSize = 8		'풀단이면 15개			'/수기이벤트 둘다 강제 12고정
else
	iCPageSize = 8		'메뉴가 있으면 10개			'/수기이벤트 둘다 강제 12고정
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

dim itemid 
Dim hspchk
'// 현재 주소값 체크하여 신규, 구버전 확인
hspchk = Split(LCase(Request.ServerVariables("PATH_INFO")),"/")
%>
<style type="text/css">
/* title */
.heySomething .topic {background-color:#f7f6f4;}
.heySomething .topic h2 {z-index:5;}
.heySomething .topic .figure a {display:block; position:relative; width:100%; height:779px;}
.heySomething .topic .figure img {position:absolute; top:0; left:50%; margin-left:-951px;}

/* item */
.heySomething .itemB {width:1140px; margin:405px auto 0; padding-bottom:0; background:none; border-bottom:1px solid #ddd;}
.heySomething .item h3 {position:relative; height:60px; text-align:center;}
.heySomething .item h3 .horizontalLine1, .heySomething .item h3 .horizontalLine2 {position:absolute; top:34px; width:273px; height:1px; background-color:#ddd;}
.heySomething .item h3 .horizontalLine1 {left:0;}
.heySomething .item h3 .horizontalLine2 {right:0;}
.heySomething .item .desc {min-height:530px; margin-top:105px;}
.heySomething .itemB .desc .option {top:0; left:85px; height:550px;}
.heySomething .item .option .substance {bottom:118px;}
.heySomething .itemB .slidewrap {padding-top:44px;}
.heySomething .itemB .slidewrap .slide {position:relative; width:666px; text-align:center;}
.heySomething .itemB .slidewrap .slide .slidesjs-previous {left:0;}
.heySomething .item .with {margin-top:67px; padding-bottom:52px; text-align:center; border:none;}
.heySomething .item .with span {position:relative; z-index:5;}
.heySomething .item .with ul {overflow:hidden; width:1143px; margin:65px auto 0;}
.heySomething .item .with ul li {float:left; width:377px; margin:0 2px;}
.heySomething .item .with ul li a {display:block; position:relative; width:100%; height:100%;}
.heySomething .item .with ul li span {display:block;}
.heySomething .item .with ul li .figure {overflow:hidden; width:377px; height:186px;}
/*.heySomething .item .with ul li .figure img {transition:all 0.5s; transform:scale(1);}
.heySomething .item .with ul li a:hover .figure img {transform:scale(0.9);}*/
.heySomething .itemB .with ul li .mask {position:absolute; top:0; left:0; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/73913/bg_mask.png) no-repeat 50% 0; transition:opacity 1s;}
.heySomething .item .with ul li .word {position:absolute; top:86px; left:0; width:100%; text-align:center;  transition:all 0.4s;}
.heySomething .itemB .with ul li a:hover .mask {opacity:0; filter:alpha(opacity=0);}
.heySomething .itemB .with ul li a:hover .word {margin-top:-61px; opacity:0; filter:alpha(opacity=0);}
.heySomething .itemB .with ul li a:hover .word {*opacity:0; filter:alpha(opacity=0);}
@media \0screen {
	.heySomething .itemB .with ul li a:hover .word {*opacity:0; filter:alpha(opacity=0);}
}

/* gallery */
.heySomething .gallery {margin-top:430px;}
.heySomething .gallery ul {overflow:hidden; width:1192px; margin:0 auto;}
.heySomething .gallery ul li {float:left; margin:19px 10px 0;}
.heySomething .gallery ul li img {transition:all 0.7s;}
.heySomething .gallery p {margin-top:45px; text-align:center;}
.heySomething .gallery ul li:nth-of-type(2) {animation-delay:0.4s;}
.heySomething .gallery ul li:nth-of-type(3) {animation-delay:0.2s;}
.heySomething .gallery ul li:nth-of-type(4) {animation-delay:0.3s;}
.heySomething .gallery ul li:nth-of-type(5) {animation-delay:0.5s;}
.heySomething .gallery ul li:nth-of-type(6) {animation-delay:0.4s;}
.heySomething .gallery ul li:nth-of-type(7) {animation-delay:0.3s;}
.heySomething .gallery ul li:nth-of-type(8) {animation-delay:0.2s;}

@keyframes fadeInSlideUp {
	0% {opacity:0; transform:translateY(60px);}
	100% {opacity:1;}
}
.fadeInSlideUp{opacity:0; animation:fadeInSlideUp 1s cubic-bezier(0.2, 0.3, 0.25, 0.9) forwards;}

.pulse {animation-name:pulse; animation-duration:2s; animation-iteration-count:1;}
@keyframes pulse {
	0% {transform:scale(1.1);}
	100% {transform:scale(1);}
}

/* brand */
.heySomething .brand {width:1140px; height:1130px; margin:447px auto 0;}
.heySomething .brand p {margin-top:80px;}

/* story */
.heySomething .story {margin-top:300px; padding-bottom:100px;}
.heySomething .rolling {margin-top:60px; padding-top:205px;}
.heySomething .rolling .pagination {top:0; width:930px; margin-left:-465px;}
.heySomething .rolling .swiper-pagination-switch {width:130px; height:161px; margin:0 28px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/73913/btn_pagination_story.png);}
.heySomething .rolling .pagination span.swiper-active-switch {background-position:0 100%;}
.heySomething .rolling .pagination span:first-child + span {background-position:-187px 0;}
.heySomething .rolling .pagination span:first-child + span.swiper-active-switch {background-position:-187px 100%;}
.heySomething .rolling .pagination span:first-child + span + span {background-position:-374px 0;}
.heySomething .rolling .pagination span:first-child + span + span.swiper-active-switch {background-position:-374px 100%;}
.heySomething .rolling .pagination span:first-child + span + span + span {background-position:-561px 0;}
.heySomething .rolling .pagination span:first-child + span + span + span.swiper-active-switch {background-position:-561px 100%;}
.heySomething .rolling .pagination span:first-child + span + span + span + span {background-position:100% 0;}
.heySomething .rolling .pagination span:first-child + span + span + span + span.swiper-active-switch {background-position:100% 100%;}
.heySomething .rolling .pagination span em {bottom:-794px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/73913/txt_story_desc_v1.png);}
.heySomething .rolling .pagination span .desc2 {background-position:0 -100px;}
.heySomething .rolling .pagination span .desc3 {background-position:0 -200px;}
.heySomething .rolling .pagination span .desc4 {background-position:0 -300px;}
.heySomething .rolling .pagination span .desc5 {background-position:0 -400px;}
.heySomething .rolling .btn-nav {top:490px;}
.heySomething .swipemask {top:205px;}

/* finish */
.heySomething .finish {background-color:#fbf8f2; height:734px; margin-top:400px;}
.heySomething .finish .figure {position:absolute; top:0; left:50%; margin-left:-951px;}
.heySomething .finish p {top:207x; margin-left:-538px;}

/* comment */
.heySomething .commentevet {margin-top:330px;}
.heySomething .commentevet .form {margin-top:30px;}
.heySomething .commentevet .form .choice li {width:118px; height:148px; margin-right:27px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/73913/img_ico.png); background-position:0 0;}
.heySomething .commentevet .form .choice li button.on {background-position:0 100%;}
.heySomething .commentevet .form .choice li.ico2 button {background-position:-145px 0;}
.heySomething .commentevet .form .choice li.ico2 button.on {background-position:-145px 100%;}
.heySomething .commentevet .form .choice li.ico3 button {background-position:-290px 0;}
.heySomething .commentevet .form .choice li.ico3 button.on {background-position:-290px 100%;}
.heySomething .commentevet .form .choice li.ico4 button {background-position:-435px 0;}
.heySomething .commentevet .form .choice li.ico4 button.on {background-position:-435px 100%;}
.heySomething .commentevet .form .choice li.ico5 button {background-position:100% 0;}
.heySomething .commentevet .form .choice li.ico5 button.on {background-position:100% 100%;}

.heySomething .commentevet textarea {margin-top:43px;}

.heySomething .commentlist table td strong {width:130px; height:130px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/73913/btn_pagination_story.png); background-position:0 -161px;}
.heySomething .commentlist table td strong.ico2 {background-position:-187px -161px;}
.heySomething .commentlist table td strong.ico3 {background-position:-374px -161px;}
.heySomething .commentlist table td strong.ico4 {background-position:-561px -161px;}
.heySomething .commentlist table td strong.ico5 {background-position:100% -161px;}
</style>
<script type="text/javascript">
$(function(){
	/* slide js */
	$("#slide").slidesjs({
		width:"638",
		height:"480",
		pagination:false,
		navigation:{effect:"fade"},
		play:{interval:2000, effect:"fade", auto:true},
		effect:{fade: {speed:1000, crossfade:true}}
	});

	/* swipe */
	var swiper1 = new Swiper('#rolling .swiper1',{
		centeredSlides:true,
		slidesPerView:"auto",
		loop: true,
		speed:1500,
		autoplay:3000,
		simulateTouch:false,
		pagination: '#rolling .pagination',
		paginationClickable: true
	});

	$('#rolling .arrow-left').on('click', function(e){
		e.preventDefault()
		swiper1.swipePrev()
	});
	$('#rolling .arrow-right').on('click', function(e){
		e.preventDefault()
		swiper1.swipeNext()
	});

	$('#rolling .pagination span:nth-child(1)').append('<em class="desc1"></em>');
	$('#rolling .pagination span:nth-child(2)').append('<em class="desc2"></em>');
	$('#rolling .pagination span:nth-child(3)').append('<em class="desc3"></em>');
	$('#rolling .pagination span:nth-child(4)').append('<em class="desc4"></em>');
	$('#rolling .pagination span:nth-child(5)').append('<em class="desc5"></em>');

	$('#rolling .pagination span em').hide();
	$('#rolling .pagination .swiper-active-switch em').show();

	setInterval(function() {
		$('#rolling .pagination span em').hide();
		$('#rolling .pagination .swiper-active-switch em').show();
	}, 500);

	$('#rolling .pagination span,.btn-nav').click(function(){
		$('#rolling .pagination span em').hide();
		$('#rolling .pagination .swiper-active-switch em').show();
	});

	/* comment write ico select */
	$(".form .choice li:first-child button").addClass("on");
	frmcom.gubunval.value = '1';
	$(".form .choice li button").click(function(){
		frmcom.gubunval.value = $(this).val()
		$(".form .choice li button").removeClass("on");
		if ( $(this).hasClass("on")) {
			$(this).removeClass("on");
		} else {
			$(this).addClass("on");
		}
	});

	/* animation effect */
	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 2400) {
			$(".heySomething .gallery ul li").addClass("fadeInSlideUp");
			$(".heySomething .gallery ul li .off img").addClass("pulse");
		}
		if (scrollTop > 3450 ) {
			brandAnimation();
		}
		if (scrollTop > 6600 ) {
			finishAnimation();
		}
	});

	/* title animation */
	titleAnimation()
	$(".heySomething .topic h2 span").css({"width":"50px", "opacity":"0"});
	function titleAnimation() {
		$(".heySomething .topic h2 .letter1").delay(100).animate({"width":"125px", "opacity":"1"},1200);
		$(".heySomething .topic h2 .letter2").delay(300).animate({"width":"349px", "opacity":"1"},1200);
		$(".heySomething .topic h2 .letter3").delay(500).animate({"width":"206px", "opacity":"1"},1200);
	}

	/* brand animation */
	$(".heySomething .brand p").css({"height":"50px", "opacity":"0"});
	$(".heySomething .brand .btnDown").css({"opacity":"0"});
	function brandAnimation() {
		$(".heySomething .brand p").delay(800).animate({"height":"228px", "opacity":"1"},1000);
		$(".heySomething .brand .btnDown").delay(1700).animate({"opacity":"1"},1200);
	}

	/* finish animation */
	$(".heySomething .finish p").css({"margin-top":"-100px", "opacity":"0"});
	function finishAnimation() {
		$(".heySomething .finish p").delay(100).animate({"margin-top":"0", "opacity":"1"},1000);
	}
});

$(function(){
	<% if pagereload<>"" then %>
		//pagedown();
		setTimeout("pagedown()",500);
	<% end if %>
});

function pagedown(){
	//document.getElementById('commentlist').scrollIntoView();
	window.$('html,body').animate({scrollTop:$("#commentlist").offset().top}, 0);
}

function jsGoComPage(iP){
	document.frmcom.iCC.value = iP;
	document.frmcom.iCTot.value = "<%=iCTotCnt%>";
	document.frmcom.submit();
}

function jsSubmitComment(frm){
	<% If IsUserLoginOK() Then %>
		<% If not( left(currenttime,10)>="2016-11-09" and left(currenttime,10)<"2016-11-16" ) Then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return false;
		<% else %>
			<% if commentcount>4 then %>
				alert("이벤트는 5회까지 참여 가능 합니다.");
				return false;
			<% else %>
				if (frm.gubunval.value == ''){
					alert('원하는 아이콘을 선택해 주세요.');
					return false;
				}
				if (frm.txtcomm1.value == '' || GetByteLength(frm.txtcomm1.value) > 800){
					alert("코맨트를 남겨주세요.\n한글 400자 까지 작성 가능합니다.");
					frm.txtcomm1.focus();
					return false;
				}
				frm.txtcomm.value = frm.gubunval.value + '!@#' + frm.txtcomm1.value
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
<% If Not(Trim(hspchk(1)))="hsproject" Then %>
	<div class="heySomething">
<% end if %>
		<%' title, nav %>
		<div class="topic">
			<h2>
				<span class="letter1">Hey,</span>
				<span class="letter2">something</span>
				<span class="letter3">project</span>
			</h2>
			<% If Not(Trim(hspchk(1)))="hsproject" Then %>
				<%' for dev mgs :  탭 navigator %>
				<div class="navigator">
					<ul>
						<!-- #include virtual="/event/etc/inc_66049_menu.asp" -->
					</ul>
					<span class="line"></span>
				</div>
			<% End If %>

			<div class="figure">
				<a href="/shopping/category_prd.asp?itemid=1578129&pEtr=73913"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73913/img_item_represent.jpg" alt="Reversible Room Socks" /></a>
			</div>
		</div>

		<%' about %>
		<div class="about">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
			<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
		</div>

		<%' item %>
		<div class="item itemB">
			<div class="inner">
				<h3>
					<span class="logo"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73913/img_logo_tehtava.png" alt="Tehtava" /></span>
					<span class="horizontalLine1"></span>
					<span class="horizontalLine2"></span>
				</h3>
				<%
					IF application("Svr_Info") = "Dev" THEN
						itemid = 1239226
					Else
						itemid = 1578118
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
				%>
				<div class="desc">
					<a href="/shopping/category_prd.asp?itemid=1578118&pEtr=73913">
						<div class="option">
							<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73913/txt_name.png" alt="Tehtava Reversible room socks 양말 사이즈는 230에서 240mm이며 장갑사이즈는 여성 프리 사이즈로 25센치입니다." /></p>
							<%' for dev msg : 상품코드 1578118 할인 중, 11/9~11/15 할인기간이 지나면 <strong class="discount">...</strong> 숨겨주세요 %>
							
							<% If oItem.FResultCount > 0 Then %>
								<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
									<div class="price">
										<% If not( left(currenttime,10)>="2016-11-09" and left(currenttime,10)<="2016-11-15" ) Then %>
										<% Else %>
											<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/txt_only_10percent.png" alt="단 일주일만 only 10%" /></strong>
											<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
										<% end if %>
										<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
									</div>
								<% else %>
									<%' for dev msg : 종료 후 %>
									<div class="price priceEnd">
										<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
									</div>
								<% end if %>
							<% end if %>
							<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73913/txt_substance.png" alt="Tehtava+ 2016 AUTUMN &amp; WINTER 시리즈 양면으로 사용 가능한 포근한 Room Socks 세련된 디자인에 스크린 터치가 가능한 Touch Screen Gloves 스크린 터치가 가능한 감각적인 도트 디자인의 Knit Gloves 섬세하고 포근한 Tehtava+의 겨울 감성을 만나보세요" /></p>
							<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="Tehtava Reversible room socks 구매하러 가기" /></div>
						</div>

						<%' slide %>
						<div class="slidewrap">
							<div id="slide" class="slide">
								<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73913/img_slide_item_01.jpg" alt="" /></div>
								<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73913/img_slide_item_02.jpg" alt="" /></div>
							</div>
						</div>
					</a>
				</div>
				<%	set oItem = nothing %>

				<div class="with">
					<span><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/ico_plus.png" alt="" /></span>
					<ul>
						<li>
							<a href="/event/eventmain.asp?eventid=74091&eGc=192662">
								<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73913/img_with_item_01_v1.jpg" alt="" /></span>
								<span class="mask"></span>
								<span class="word"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73913/txt_with_item_01_v1.png" alt="Reversible Room Socks 더 보러 가기 2017 Tehtava+ 신상출시 기획전으로 이동" /></span>
							</a>
						</li>
						<li>
							<a href="/event/eventmain.asp?eventid=74091&eGc=192663">
								<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73913/img_with_item_02_v1.jpg" alt="" /></span>
								<span class="mask"></span>
								<span class="word"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73913/txt_with_item_02_v1.png" alt="Touch Screen Gloves 더 보러 가기 2017 Tehtava+ 신상출시 기획전으로 이동" /></span>
							</a>
						</li>
						<li>
							<a href="/event/eventmain.asp?eventid=74091&eGc=192664">
								<span class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73913/img_with_item_03_v1.jpg" alt="" /></span>
								<span class="mask"></span>
								<span class="word"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73913/txt_with_item_03_v1.png" alt="Knit Gloves 더 보러 가기 2017 Tehtava+ 신상출시 기획전으로 이동" /></span>
							</a>
						</li>
					</ul>
				</div>
			</div>
		</div>

		<%' gallery %>
		<div class="gallery">
			<a href="/street/street_brand_sub06.asp?makerid=tehtava" title="테스타바 브랜드 스트리트로 이동">
				<ul>
					<li><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73913/img_gallery_01.jpg" alt="Reversible Room Sock 차콜 블루" /></li>
					<li><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73913/img_gallery_02.jpg" alt="Reversible Room Socks 민트 핑크" /></li>
					<li><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73913/img_gallery_03.jpg" alt="Touch Screen Gloves" /></li>
					<li><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73913/img_gallery_04.jpg" alt="Touch Screen Gloves" /></li>
					<li><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73913/img_gallery_05.jpg" alt="Touch Screen Gloves" /></li>
					<li><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73913/img_gallery_06.jpg" alt="Reversible Room Socks 연두 베이지" /></li>
					<li><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73913/img_gallery_07.jpg" alt="Reversible Room Socks 베이지 민트" /></li>
					<li><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73913/img_gallery_08.jpg" alt="Touch Screen Gloves" /></li>
				</ul>
			</a>
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73913/txt_tehtava_2016_fw.png" alt="TEHTAVA PLUS 2016 F/W" /></p>
		</div>

		<%' brand %>
		<div id="brand" class="brand">
			<div class="figure">
				<a href="/street/street_brand_sub06.asp?makerid=tehtava" title="브랜드 스트리트로 이동"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73913/img_brand.jpg" alt="테스타바" /></a>
			</div>
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73913/txt_brand.png" alt="디자인에 실용을 담다 TEHTAVA 플러스 테스타바는 핀란드어로 기능이라는 뜻을 가진 단어입니다. 테스타바 플러스에서는 기능성 있는 소재와 아이템을 소비자가 선택하는 재미를 더했습니다. 세련된 북유럽 스타일의 패브릭 제품과 생활 소품을 만나보세요. 당신의 매일 매일을 돋보이게하는 기능 아이템을 소개합니다." /></p>
			<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="" /></div>
		</div>

		<%' story %>
		<div class="story">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73913/tit_story.png" alt="겨울의 길목에서 만난 아늑함" /></h3>
			<div class="rollingwrap">
				<div id="rolling" class="rolling">
					<div class="swipemask mask-left"></div>
					<div class="swipemask mask-right"></div>
					<button type="button" class="btn-nav arrow-left">Previous</button>
					<button type="button" class="btn-nav arrow-right">Next</button>
					<div class="swiper">
						<div class="swiper-container swiper1">
							<div class="swiper-wrapper" style="height:630px;">
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1578158&pEtr=73913" title="Reversible Room Socks 민트 핑크 상품보러 가기"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73913/img_slide_story_01.jpg" alt="#Cozy 나른한 주말, 혼자만의 티 타임과 함께! 느긋하게 독서를 즐기고 싶다면" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1578129&pEtr=73913" title="Reversible Room Socks 핑크 상품보러 가기"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73913/img_slide_story_02.jpg" alt="#Warm 차가운 마루에서도 온 몸이 움츠려 들지 않아도 되는 나만의 비결" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1578118&pEtr=73913" title="Reversible Room Socks 연두 베이지 상품보러 가기"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73913/img_slide_story_03.jpg" alt="#Family 오늘은 어떤색을 신어볼까? 따뜻한 겨울을 위한 우리 가족 필수템" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/event/eventmain.asp?eventid=74091&eGc=192663" title="Touch Screen Gloves 더 보러 가기 2017 Tehtava+ 신상출시 기획전으로 이동"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73913/img_slide_story_04.jpg" alt="#Slim 따뜻하고 싶지만 투박하여 미뤄왔던 터치 장갑에 대한 고민은 이제 그만!" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/event/eventmain.asp?eventid=74091&eGc=192663" title="Touch Screen Gloves 더 보러 가기 2017 Tehtava+ 신상출시 기획전으로 이동"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73913/img_slide_story_05.jpg" alt="#Touch 너를 기다리는 이 순간에도 너에게 문자를 보내는 나의 손은 오늘도 따뜻" /></a>
								</div>
							</div>
						</div>
					</div>
					<div class="pagination"></div>
				</div>
			</div>
		</div>

		<%' finish %>
		<div class="finish">
			<a href="/shopping/category_prd.asp?itemid=1578118&pEtr=73913" title="Reversible Room Socks 보러가기">
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73913/txt_finish.png" alt="겨울에 감성을 더하는 TEHTAVA 플러스" /></p>
				<div class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73913/img_finish_v1.jpg" alt="" /></div>
			</a>
		</div>

		<%' comment %>
		<div class="commentevet">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73913/tit_comment.png" alt="Hey, something project 나와 잘 맞는 룸삭스 컬러는?" /></h3>
			<p class="hidden">가장 마음에 드는 룸삭스의 컬러와 컨셉을 선정해주세요. 정성껏 코멘트를 남겨주신 5분을 추첨하여, 테스타바 장갑을 선물로 드립니다. 코멘트 작성기간은 2016년 11월 9일부터 11월 215일까지며, 발표는 11월 16일 입니다.</p>

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
					<legend>가장 마음에 드는 룸삭스의 컬러와 컨셉 선택하고 코멘트 쓰기</legend>
						<ul class="choice">
							<li class="ico1"><button type="button" value="1">Cozy</button></li>
							<li class="ico2"><button type="button" value="2">Warm</button></li>
							<li class="ico3"><button type="button" value="3">Family</button></li>
							<li class="ico4"><button type="button" value="4">Slim</button></li>
							<li class="ico5"><button type="button" value="5">Touch</button></li>
						</ul>
						<textarea title="코멘트 쓰기" cols="60" rows="5" name="txtcomm1" id="txtcomm1" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();" <%IF NOT(IsUserLoginOK) THEN%>readonly<%END IF%>><%IF NOT IsUserLoginOK THEN%>로그인 후 글을 남길 수 있습니다.<% else %><%END IF%></textarea>
						<div class="note01 overHidden">
							<ul class="list01 ftLt">
								<li>입력하신 블로그 주소는 개인정보 유출로 인한 피해를 막고자 비공개로 텐바이텐에 접수됩니다.</li>
								<li>통신예절에 어긋나는 글이나 상업적인 글, 타 사이트에 관련된 글 또는 도용한 글은 관리자에 의해 사전 통보 없이 삭제될 수 있으며,<br>이벤트 참여에 제한을 받을 수 있습니다.</li>
							</ul>
							<input type="submit" onclick="jsSubmitComment(document.frmcom); return false;" class="ftRt btn btnW130 btnS1 btnRed" value="코멘트 남기기">
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
			</div>

			<% '' commentlist %>
			<div class="commentlist" id="commentlist">
				<p class="total">total <%= iCTotCnt %></p>
				<% IF isArray(arrCList) THEN %>
				<table>
					<caption>Tehtava 플러스 룸삭스 컬러 코멘트 목록 - 코멘트 작성시 선택 항목, 내용, 작성일자, 아이디 정보를 제공하는 표</caption>
					<colgroup>
						<col style="width:150px;" />
						<col style="width:*;" />
						<col style="width:110px;" />
						<col style="width:120px;" />
					</colgroup>
					<thead>
					<tr>
						<th scope="col"></th>
						<th scope="col">내용</th>
						<th scope="col">작성일자</th>
						<th scope="col">아이디</th>
					</tr>
					</thead>
					<tbody>
						<% For intCLoop = 0 To UBound(arrCList,2) %>
							<tr>
								<td>
									<% if isarray(split(arrCList(1,intCLoop),"!@#")) then %>
										<strong class="ico<%= split(arrCList(1,intCLoop),"!@#")(0) %>">
											<% if split(arrCList(1,intCLoop),"!@#")(0)="1" then %>
												Cozy
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="2" then %>
												Warm
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="3" then %>
												Family
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="4" then %>
												Slim
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="5" then %>
												Touch
											<% end if %>
										</strong>
									<% end if %>
								</td>
								<td class="lt">
									<% if isarray(split(arrCList(1,intCLoop),"!@#")) then %>
										<% if ubound(split(arrCList(1,intCLoop),"!@#")) > 0 then %>
											<%=ReplaceBracket(db2html( split(arrCList(1,intCLoop),"!@#")(1) ))%>
										<% end if %>
									<% end if %>
								</td>
								<td><%= FormatDate(arrCList(4,intCLoop),"0000.00.00") %></td>
								<td>
									<em><%=printUserId(arrCList(2,intCLoop),2,"*")%></em>
									<% if ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %>
										<button type="button" onclick="jsDelComment('<% = arrCList(0,intCLoop) %>'); return false;" class="btndel"><img src="http://fiximage.10x10.co.kr/web2013/event/btn_cmt_close.gif" alt="코멘트 삭제"></button>
									<% end if %>
									<% If arrCList(8,i) <> "W" Then %>
										<br /><img src="http://fiximage.10x10.co.kr/web2013/event/ico_mobile.png" alt="모바일에서 작성됨">
									<% end if %>
								</td>
							</tr>
						<% next %>
					</tbody>
				</table>
				<%' paging %>
				<div class="pageWrapV15">
					<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
				</div>
				<% end if %>
			</div>
		</div>
		<%'' // 수작업 영역 끝 %>
<% If Not(Trim(hspchk(1)))="hsproject" Then %>
	</div>
<% End If %>
<!-- #include virtual="/lib/db/dbclose.asp" -->