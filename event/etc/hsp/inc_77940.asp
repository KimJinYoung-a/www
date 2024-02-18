<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈
' History : 2017-04-04 원승현 생성
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
'	currenttime = #05/20/2017 09:00:00#

dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  66327
Else
	eCode   =  77940
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
.heySomething .topic {height:778px; background-color:#642705;}
.heySomething .topic h2 {z-index:5;}
.heySomething .topic h2 span {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_hey_something_project_white.png);}
.heySomething .topic .figure {position:relative; width:100%; height:778px;}

/* brand */
.heySomething .brand {height:1005px; margin-top:235px;}
.heySomething .brand .figure {position:relative; width:1140px; margin:0 auto;}
.heySomething .brand .figure .bg {position:absolute; top:0; left:0; width:100%; height:100%; background-color:#000; opacity:0.4; filter:alpha(opacity=40);}
.heySomething .brand .figure + p {margin-top:97px;}
.heySomething .brand .btnDown {margin-top:100px;}

/* item */
.heySomething .item {margin-top:364px;}
.heySomething .item .desc {background-color:#f0f0f0;}
.heySomething .item .desc .descInner {overflow:hidden; width:1140px; margin:0 auto; padding-left:0;}
.heySomething .item .desc .option {position:static; float:left; width:222px; padding:117px 0 0 196px;}
.heySomething .item .desc .option .substance, .heySomething .item .option .btnget {position:static;}
.heySomething .item .desc .option .price {margin-top:70px;}
.heySomething .item .desc  .option .substance {margin-top:50px;}
.heySomething .item .desc  .option .btnget {margin-top:30px;}
.heySomething .item .desc .slidewrap {float:left; width:722px; position:relative;}
.heySomething .item .desc .slidewrap .slide {width:722px; height:655px;}
.heySomething .item .descB {margin:136px 0 362px;}
.heySomething .item .descB .option {float:right; height:auto; width:247px; padding:117px 190px 0 0;}
.heySomething .item .descB .slidewrap {width:693px;}
.heySomething .item .descB .slidewrap .slide {width:693px;}
.heySomething .item .descB .slidewrap .slide div:first-child + div,
.heySomething .item .descB .slidewrap .slide div:first-child + div + div
{margin-left:120px;}


/* gallery */
.gallery ul {position:relative; width:700px; height:810px; margin:0 auto 380px;}
.gallery ul li {position:absolute; top:0; left:0; background-color:#f5ebde;}
.gallery ul li:first-child + li {left:360px; background-color:#c6e9f1;}
.gallery ul li:first-child + li + li{top:360px; background-color:#ddf1d5;}
.gallery ul li:first-child + li + li + li{top:470px; left:360px; background-color:#ffe3dd;}
.gallery ul li img {opacity:0;}
.gallery .figure {position:relative; background-color:#f4f22e; }
.gallery .figure .bg {position:absolute; top:0; left:0; width:100%; margin-left:50%; height:585px; background-color:#ffb700;}
.gallery .figure img{display:block; position:relative; width:1140px; margin:0 auto; z-index:10;}

/* story */
.heySomething .story {margin-top:367px; padding-bottom:120px;}
.heySomething .story h3 {margin-bottom:65px;}
.heySomething .rolling {padding-top:175px;}
.heySomething .rolling .pagination {top:0; width:980px; margin-left:-490px;}
.heySomething .rolling .swiper-pagination-switch {width:110px; height:137px; margin:0 37px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/77940/btn_pagination_story.jpg);}
.heySomething .rolling .pagination span.swiper-active-switch {background-position:0 100%;}
.heySomething .rolling .pagination span:first-child + span {background-position:-184px 0;}
.heySomething .rolling .pagination span:first-child + span.swiper-active-switch {background-position:-184px 100%;}
.heySomething .rolling .pagination span:first-child + span + span {width:142px; background-position:-350px 0;}
.heySomething .rolling .pagination span:first-child + span + span.swiper-active-switch {background-position:-350px 100%;}
.heySomething .rolling .pagination span:first-child + span + span + span{background-position:-549px 0;}
.heySomething .rolling .pagination span:first-child + span + span + span.swiper-active-switch {background-position:-549px 100%;}
.heySomething .rolling .pagination span:first-child + span + span + span + span{background-position:100% 0;}
.heySomething .rolling .pagination span:first-child + span + span + span + span.swiper-active-switch {background-position:100% 100%;}
.heySomething .rolling .pagination span em {bottom:-770px; left:50%;height:100px; width:980px; margin-left:-490px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/77940/txt_story_desc.png); cursor:default;}
.heySomething .rolling .pagination span .desc2 {background-position:0 -100px;}
.heySomething .rolling .pagination span .desc3 {background-position:0 -200px;}
.heySomething .rolling .pagination span .desc4 {background-position:0 -300px;}
.heySomething .rolling .pagination span .desc5 {background-position:0 -400px;}
.heySomething .rolling .btn-nav {top:480px;}
.heySomething .swipemask {top:175px;}
.heySomething .mask-left {margin-left:-1470px;}
.heySomething .mask-right {margin-left:490px;}

/* finish */
.heySomething .finish {position:relative;  height:550px; margin-top:280px; background-color:#fff;}
.heySomething .finish div img {position:absolute; top:0; left:50%; margin-left:-525px}
.heySomething .finish p {position:absolute; top:64px; left:50%; margin-left:-451px; z-index:10;}
.heySomething .finish p span {width:293px; height:130px; margin:8px 0; background:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/77940/txt_logo.png) 0 0; text-indent:-999em; opacity:0;}
.heySomething .finish p .t2 { height:63px; background-position:0 -137px}
.heySomething .finish p .t3 { height:200px; background-position:0 100%;}

/* comment */
.heySomething .commentevet {margin-top:300px;}
.heySomething .commentevet .form {margin-top:20px;}
.heySomething .commentevet .form .choice li {width:110px; height:137px; margin-right:44px;}
.heySomething .commentevet .form .choice li.ico2{margin-right:28px;}
.heySomething .commentevet .form .choice li.ico3 {width:143px; margin-right:28px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/77940/img_comment_ico_1.png); background-position:0 0;}
.heySomething .commentevet .form .choice li.ico1 button.on {background-position:0 100%;}
.heySomething .commentevet .form .choice li.ico2 button {background-position:-154px 0;}
.heySomething .commentevet .form .choice li.ico2 button.on {background-position:-154px 100%;}
.heySomething .commentevet .form .choice li.ico3 button { background-position:-289px 0;}
.heySomething .commentevet .form .choice li.ico3 button.on {background-position:-289px 100%;}
.heySomething .commentevet .form .choice li.ico4 button {background-position:-459px 0;}
.heySomething .commentevet .form .choice li.ico4 button.on {background-position:-459px 100%;}
.heySomething .commentevet .form .choice li.ico5 button {background-position:100% 0;}
.heySomething .commentevet .form .choice li.ico5 button.on {background-position:100% 100%;}
.heySomething .commentevet textarea {margin-top:35px;}
.heySomething .commentlist table td strong {width:90px; height:90px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/77940/img_comment_ico_2.png); background-position:0 0;}
.heySomething .commentlist table td strong.ico2 {background-position:-90px 0;}
.heySomething .commentlist table td strong.ico3 {background-position:-182px 0;}
.heySomething .commentlist table td strong.ico4 {background-position:-273px 0;}
.heySomething .commentlist table td strong.ico5 {background-position:100% 0;}

</style>
<script type="text/javascript">
$(function(){
	/* slide js */
	$("#slide01").slidesjs({
		width:"722",
		height:"655",
		pagination:false,
		navigation:{effect:"fade"},
		play:{interval:3000, effect:"fade", auto:true},
		effect:{fade: {speed:800, crossfade:true}}
	});

	$("#slide02").slidesjs({
		width:"693",
		height:"655",
		pagination:false,
		navigation:{effect:"fade"},
		play:{interval:3100, effect:"fade", auto:true},
		effect:{fade: {speed:800, crossfade:true}}
	});

	/* swipe */
	var swiper1 = new Swiper('#rolling .swiper1',{
		centeredSlides:true,
		slidesPerView:"auto",
		loop: true,
		speed:1200,
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

	$('#rolling .pagination span,.btnNavigation').click(function(){
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
		if (scrollTop > 3500 ) {
			galleryAnimation();
		}
		if (scrollTop > 7000 ) {
			brandAnimation();
		}
	});

	/* title animation */
	titleAnimation();
	$(".heySomething .topic h2 span").css({"width":"50px", "opacity":"0"});
	function titleAnimation() {
		$(".heySomething .topic h2 .letter1").delay(100).animate({"width":"125px", "opacity":"1"},1200);
		$(".heySomething .topic h2 .letter2").delay(300).animate({"width":"349px", "opacity":"1"},1200);
		$(".heySomething .topic h2 .letter3").delay(500).animate({"width":"206px", "opacity":"1"},1200);
	}
	
	/* gallery animation */
	$(".gallery ul li img").css({"opacity":"0"});
	function galleryAnimation() {
		$(".gallery ul li:nth-child(1) img").delay(100).animate({"opacity":"1"},700);
		$(".gallery ul li:nth-child(2) img").delay(400).animate({"opacity":"1"},700);
		$(".gallery ul li:nth-child(3) img").delay(500).animate({"opacity":"1"},700);
		$(".gallery ul li:nth-child(4) img").delay(700).animate({"opacity":"1"},700);
	}
	
	/* finish animation */
	$(".heySomething .finish p .t1").css({"margin-left":"-50px", "opacity":"0"});
	$(".heySomething .finish p .t2").css({"opacity":"0"});
	$(".heySomething .finish p .t3").css({"margin-left":"50px", "opacity":"0"});
	function brandAnimation() {
		$(".heySomething .finish p .t1").delay(200).animate({"margin-left":"0","opacity":"1"},800);
		$(".heySomething .finish p .t2").delay(300).animate({"margin-left":"0","opacity":"1"},800);
		$(".heySomething .finish p .t3").delay(200).animate({"margin-left":"0","opacity":"1"},800);
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
		<% If not( left(currenttime,10)>="2017-05-17" and left(currenttime,10)<"2017-05-25" ) Then %>
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
					alert("코멘트를 남겨주세요.\n한글 400자 까지 작성 가능합니다.");
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
			<div class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/77940/img_item_represent.jpg" alt="무한도전 콜라보 스티키 몬스터" /></div>
		</div>

		<%' about %>
		<div class="about">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
			<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
		</div>

		<%' brand %>
		<div class="brand">
			<div class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/77940/img_brand.jpg" alt="" /></div>
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/77940/txt_brnad.png" alt="올해로 방송 11년, 500회를 훌쩍 넘긴 ‘무한도전’의 다섯 남자가‘스티키몬스터랩’을 만나 ‘무도몬’으로 돌아왔어요." /></p>
			<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="" /></div>
		</div>

		<%' item %>
		<div class="item">
			<div class="desc descA">
				<div class="descInner">
					<%' 상품 이름, 가격, 구매하기 %>
					<div class="option">
						<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/77940/txt_prd_name_1.png" alt="무도몬 쫄쫄이 인형" />
						<%'' for dev msg : 상품코드 1706097 할인기간 2017.05.17 ~ 05.24 할인기간 %>
						<%
							IF application("Svr_Info") = "Dev" THEN
								itemid = 1239226
							Else
								itemid = 1706097
							End If
							set oItem = new CatePrdCls
								oItem.GetItemData itemid
						%>
						<% If oItem.FResultCount > 0 Then %>
							<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
								<%' for dev msg : 할인기간 %>
								<div class="price" >
									<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem," Point"," won") %>(10%)</strong>
								</div>
							<% else %>
								<%'' for dev msg : 할인기간 종료 후 %>
								<div class="price priceEnd">
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem," Point"," won") %></strong>
								</div>
							<% end if %>
						<% end if %>
						<%	set oItem = nothing %>
						<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/77940/txt_prd_detail_1.png" alt="야무지게 무도 쫄쫄이를 챙겨입은 아이 쫄쫄이 인형을 데려가세요!" /></p>
						<div class="btnget"><a href="/shopping/category_prd.asp?itemid=1706097&pEtr=77940"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/77940/btn_go_buy.png" alt=" 구매하러 가기" /></a></div>
					</div>

					<!-- slide -->
					<div class="slidewrap">
						<div id="slide01" class="slide">
							<div><a href="/shopping/category_prd.asp?itemid=1706097&pEtr=77940"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/77940/img_slide_1_1_v2.jpg" alt="" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1706097&pEtr=77940"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/77940/img_slide_1_2_v2.jpg" alt="" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1706097&pEtr=77940"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/77940/img_slide_1_3_v2.jpg" alt="" /></a></div>
						</div>
					</div>
				</div>
			</div>

			<div class="desc descB">
				<div class="descInner">
					<!-- 상품 이름, 가격, 구매하기 -->
					<div class="option">
						<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/77940/txt_prd_name_2.png" alt="무도몬 트레이닝 인형" /></p>
						<%' for dev msg : 상품코드 1706096 할인기간 2017.05.17 ~ 05.24 할인기간 %>
						<%
							IF application("Svr_Info") = "Dev" THEN
								itemid = 1239226
							Else
								itemid = 1706096
							End If
							set oItem = new CatePrdCls
								oItem.GetItemData itemid
						%>
						<% If oItem.FResultCount > 0 Then %>
							<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
								<%' for dev msg : 할인기간 %>
								<div class="price" >
									<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem," Point"," won") %>(10%)</strong>
								</div>
							<% else %>
								<%'' for dev msg : 할인기간 종료 후 %>
								<div class="price priceEnd">
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem," Point"," won") %></strong>
								</div>
							<% end if %>
						<% end if %>
						<%	set oItem = nothing %>
						<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/77940/txt_prd_detail_2.png" alt="MC민지와 날유를 한 번에 연상시키는 아이 트레이닝 인형을 데려가세요!" /></p>
						<div class="btnget"><a href="/shopping/category_prd.asp?itemid=1706096&pEtr=77940"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/77940/btn_go_buy.png" alt=" 구매하러 가기" /></a></div>
					</div>

					<!-- slide -->
					<div class="slidewrap">
						<div id="slide02" class="slide">
							<div><a href="/shopping/category_prd.asp?itemid=1706096&pEtr=77940"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/77940/img_slide_2_1_v2.jpg" alt="" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1706096&pEtr=77940"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/77940/img_slide_2_2_v2.jpg" alt="" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1706096&pEtr=77940"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/77940/img_slide_2_3_v2.jpg" alt="" /></a></div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- gallery -->
		<div class="gallery">
			<ul>
				<li><a href="/shopping/category_prd.asp?itemid=1706096&pEtr=77940"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/77940/img_prd_1.jpg" alt="" /></a></li>
				<li><a href="/shopping/category_prd.asp?itemid=1706097&pEtr=77940"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/77940/img_prd_2.jpg" alt="" /></a></li>
				<li><a href="/shopping/category_prd.asp?itemid=1706096&pEtr=77940"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/77940/img_prd_3.jpg" alt="" /></a></li>
				<li><a href="/shopping/category_prd.asp?itemid=1706097&pEtr=77940"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/77940/img_prd_4.jpg" alt="" /></a></li>
			</ul>
			<div class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/77940/img_figure.jpg" alt="" /><div class="bg"></div></div>
		</div>

		<!-- story -->
		<div class="story">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/77940/tit_story.png" alt="무한도전 추격전 에피소드 중 BEST를 찾아라!" /></h3>
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
									<a href="/shopping/category_prd.asp?itemid=1706097&pEtr=77940" title="상품보러 가기"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/77940/img_slide_story_1.jpg" alt="Episode #1 진실게임" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1706096&pEtr=77940" title="상품보러 가기"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/77940/img_slide_story_2.jpg" alt="Episode #2 여드름 브레이크" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1706097&pEtr=77940" title="상품보러 가기"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/77940/img_slide_story_3.jpg" alt="Episode #3 돈가방을 갖고 튀어라" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=170609&pEtr=77940" title="상품보러 가기"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/77940/img_slide_story_4.jpg" alt="Episode #4 의상한 형제" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1706097&pEtr=77940" title="상품보러 가기"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/77940/img_slide_story_5.jpg" alt="Episode #5 스피드" /></a>
								</div>
							</div>
						</div>
					</div>
					<div class="pagination"></div>
				</div>
			</div>
		</div>

		<!-- finish -->
		<div class="finish">
			<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/77940/img_finish.jpg" alt="MUHAN DOJEON 콜라보 STICKY MONSTER LAB" /></div>
			<p>
				<span class="t1">MUHAN DOJEON</span>
				<span class="t2">콜라보</span>
				<span class="t3">STICKY MONSTER LAB</span>
		</div>

		<!-- comment -->
		<div class="commentevet">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/77940/tit_comment.png" alt="Hey, something project 무한도전 추격전 에피소드 중 BEST를 찾아주세요!" /></h3>
			<p class="hidden">무한도전 추격전 중 제일 재밌었다고 생각되는 제목을 클릭하고 이유를 적어주세요. 정성껏 코멘트를 남겨주신 8분을 뽑아 무도몬 인형 1종(랜덤발송)을 보내드립니다. 이벤트 기간은 2017년 5월 17일 수요일 부터 5월 24일 수요일 까지 입니다. 발표일은 5월 26일 금요일 입니다.</p>
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
					<legend>코멘트 작성 폼</legend>
						<ul class="choice">
							<li class="ico1"><button type="button" value="1">진실게임</button></li>
							<li class="ico2"><button type="button" value="2">여드름 브레이크"</button></li>
							<li class="ico3"><button type="button" value="3">돈가방을 갖고 튀어라</button></li>
							<li class="ico4"><button type="button" value="4">의상한 형제</button></li>
							<li class="ico5"><button type="button" value="5">스피드</button></li>
						</ul>
						<textarea title="코멘트 작성" cols="60" rows="5" name="txtcomm1" id="txtcomm1" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();" <%IF NOT(IsUserLoginOK) THEN%>readonly<%END IF%>><%IF NOT IsUserLoginOK THEN%>로그인 후 글을 남길 수 있습니다.<% else %><%END IF%></textarea>
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

			<!-- commentlist -->
			<div class="commentlist" id="commentlist">
				<p class="total">total <%= iCTotCnt %></p>
				<% IF isArray(arrCList) THEN %>
					<table>
						<caption>코멘트 목록 - 코멘트 작성시 선택 항목, 내용, 작성일자, 아이디 정보를 제공하는 표</caption>
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
												간편한 아침
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="2" then %>
												여드름 브레이크
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="3" then %>
												돈가방을 갖고 튀어라
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="4" then %>
												의상한 형제
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="5" then %>
												스피드
											<% else %>
												간편한 아침
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
							<% Next %>
						</tbody>
					</table>

					<%' paging %>
					<div class="pageWrapV15">
						<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
					</div>
				<% End If %>
			</div>
		</div>
<% If Not(Trim(hspchk(1)))="hsproject" Then %>
	</div>
<% End If %>
<!-- #include virtual="/lib/db/dbclose.asp" -->