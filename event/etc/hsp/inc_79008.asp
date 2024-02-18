<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈
' History : 2017-07-11 원승현 생성
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
	eCode   =  66385
Else
	eCode   =  79008
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
.heySomething .topic {height:778px; background:#e8e8e8 url(http://webimage.10x10.co.kr/eventIMG/2017/hey/79008/bg_visual.jpg) 50% 0 no-repeat;}

/* brand */
.heySomething .brand {height:1055px; margin-top:400px; margin-bottom:375px;}
.heySomething .brand p {margin-top:75px;}

/* item */
.heySomething .item h3 {text-align:center;}
.heySomething .item a {text-decoration:none;}  
.heySomething .item {width:100%; margin-top:0;}
.heySomething .item .desc {position:relative; min-height:590px; margin:0 auto; padding:155px 85px 0; border-bottom:1px dashed #cccccc;}
.heySomething .item .desc .option {width:476px; height:420px; margin-left:45px;}
.heySomething .item .desc .option .price {margin-top:30px;}
.heySomething .item .desc .option .substance {bottom:70px;}
.heySomething .item .desc .thumbnail {position:absolute; width:630px; height:450px; top:135px; right:125px;}
.heySomething .item .desc .thumbnail .slidesjs-navigation {display:block; overflow:hidden; position:absolute; bottom:0; width:35px; height:35px; text-indent:-999em; z-index:10;}
.heySomething .item .desc .thumbnail .slidesjs-previous {right:37px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/79008/btn_slide_prev.png) no-repeat 0 0;}
.heySomething .item .desc .thumbnail .slidesjs-next {right:0; background:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/79008/btn_slide_next.png) no-repeat 0 0;}
.heySomething .item2 .desc {border:none;}

/* visual */
.heySomething .visual {margin-bottom:40px; margin-top:240px; background-color:#eeeff0; text-align:center;}

/* gallery */
.gallery {overflow:hidden; height:968px; margin-top:320px;}
.gallery ul {overflow:hidden; width:731px; margin:0 auto;}
.gallery ul li {position:relative; float:left; overflow:hidden;}
.gallery ul li:first-child {margin:0 8px 8px 0;}
.gallery ul li:first-child span {top:60px; left:171px}
.gallery ul li:first-child + li {margin-bottom:8px;}
.gallery ul li:first-child + li span {bottom:77px; left:83px;}
.gallery ul li:first-child + li + li {margin-top:-120px; margin-right:8px;}
.gallery ul li:first-child + li + li span {left:91px; top:98px;}
.gallery ul li:first-child + li + li + li span {left:119px; top:101px;}
.gallery ul li span {position:absolute;}
.gallery ul li span img {opacity:0;}
.gallery ul li p img {opacity:0;}
.gallery div {padding-top:70px; text-align:center;}
.scale {animation: scale 1.2s ease-in-out 1;}
@keyframes scale{
0% {transform: scale(1.2); -webkit-transform:scale(1.2);}
100% {transform: scale(1.0); -webkit-transform:scale(1.0);}
}

/* story */
.heySomething .story {margin-top:400px; padding-bottom:120px;}
.heySomething .story h3 {margin-bottom:60px;}
.heySomething .rolling {padding-top:202px;}
.heySomething .rolling .pagination {top:0; width:615px; margin-left:-307px;}
.heySomething .rolling .swiper-pagination-switch {width:141px; height:141px; margin:0 32px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/79008/btn_pagination_story.png) 0 0;}
.heySomething .rolling .pagination span.swiper-active-switch {background-position:0 0;}
.heySomething .rolling .pagination span:first-child {background-position: 0 100%;}
.heySomething .rolling .pagination span:first-child.swiper-active-switch {background-position:0 0;} 
.heySomething .rolling .pagination span:first-child + span {background-position:-205px 100%;}
.heySomething .rolling .pagination span:first-child + span.swiper-active-switch {background-position:-205px 0;}
.heySomething .rolling .pagination span:first-child + span + span {background-position:-410px 100%;}
.heySomething .rolling .pagination span:first-child + span + span.swiper-active-switch {background-position:-410px 0;}
.heySomething .rolling .pagination span em {bottom:-832px; left:50%; height:135px; width:980px; margin-left:-490px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/79008/txt_story_desc.png); cursor:default;}
.heySomething .rolling .pagination span .desc2 {background-position:0 -135px;}
.heySomething .rolling .pagination span .desc3 {background-position:0 -270px;}
.heySomething .rolling .btn-nav {top:476px;}
.heySomething .swipemask {top:202px;}
.heySomething .mask-left {margin-left:-1472px;}
.heySomething .mask-right {margin-left:492px;}

/* finish */
.heySomething .finish {position:relative; height:611px; margin-top:340px; background:#7f6f55 url(http://webimage.10x10.co.kr/eventIMG/2017/hey/79008/bg_finish.jpg) 50% 0 no-repeat;}
.heySomething .finish a {overflow:hidden; display:block; position:absolute; top:0; left:50%; width:1140px; height:611px; margin-left:-570px; text-indent:-999em; z-index:10;}
.heySomething .finish strong {position:absolute; left:50%; top:50%; margin:-85px 0 0; z-index:5;}

/* comment */
.heySomething .commentevet {margin-top:400px;}
.heySomething .commentevet .form {margin-top:55px;}
.heySomething .commentevet .form .choice li {width:127px; height:127px; margin-right:58px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/79008/img_comment_ico.png); background-position:0 0;}
.heySomething .commentevet .form .choice li.ico1 button.on {background-position:0 100%;}
.heySomething .commentevet .form .choice li.ico2 button {background-position:-185px 0;}
.heySomething .commentevet .form .choice li.ico2 button.on {background-position:-185px 100%;}
.heySomething .commentevet .form .choice li.ico3 button {background-position:-369px 0;}
.heySomething .commentevet .form .choice li.ico3 button.on {background-position:-369px 100%;}
.heySomething .commentevet textarea {margin-top:55px;}
.heySomething .commentlist table td {padding:20px 0;}
.heySomething .commentlist table td strong {width:103px; height:103px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/79008/img_comment_ico_2.png); background-position:0 0;}
.heySomething .commentlist table td strong.ico2 {background-position:-127px 0;}
.heySomething .commentlist table td strong.ico3 {background-position:-253px 0;}
</style>
<script type="text/javascript">
$(function(){

	/* slide js */
	$("#slide01").slidesjs({
		width:"630",
		height:"450",
		pagination:false,
		navigation:{effect:"fade"},
		play:{interval:2000, effect:"fade", auto:true},
		effect:{fade: {speed:1000, crossfade:true}}
	});

	$("#slide02").slidesjs({
		width:"630",
		height:"450",
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
		if (scrollTop > 4200) {
			galleryAnimation();
		}
	});

	/* title animation */
	titleAnimation()
	$(".heySomething .topic h2 span").css({"opacity":"0"});
	$(".heySomething .topic h2 .letter1").css({"margin-top":"7px"});
	$(".heySomething .topic h2 .letter2").css({"margin-top":"15px"});
	$(".heySomething .topic h2 .letter3").css({"margin-top":"23px"});
	function titleAnimation() {
		$(".heySomething .topic h2 .letter1").delay(300).animate({"margin-top":"0", "opacity":"1"},800);
		$(".heySomething .topic h2 .letter2").delay(700).animate({"margin-top":"7px", "opacity":"1"},800);
		$(".heySomething .topic h2 .letter3").delay(1100).animate({"margin-top":"17px", "opacity":"1"},800);
	}

	/* gallery animation*/
	$(".gallery ul li p img").css({"opacity":"0"});
	$(".gallery ul li span img").css({"opacity":"0"});
	$(".gallery ul li:nth-child(1) span img").css({"margin-top":"-17px"});
	$(".gallery ul li:nth-child(2) span img").css({"margin-top":"17px"});
	$(".gallery ul li:nth-child(3) span img").css({"margin-top":"22px"});
	$(".gallery ul li:nth-child(4) span img").css({"margin-top":"15px"});
	$(".gallery div").css({"margin-top":"40px", "opacity":"0"});
	function galleryAnimation() {
		setTimeout(function(){
			$(".gallery ul li:nth-child(1) p img").addClass("scale").animate({"opacity":"1"});
			$(".gallery ul li:nth-child(1) span img").delay(300).animate({"margin-top":"0", "opacity":"1"},1300);
			$(".gallery ul li:nth-child(4) p img").addClass("scale").animate({"opacity":"1"});
			$(".gallery ul li:nth-child(4) span img").delay(400).animate({"margin-top":"0", "opacity":"1"},1500);
		}, 500);
		setTimeout(function(){
			$(".gallery ul li:nth-child(2) p img").addClass("scale").animate({"opacity":"1"});
			$(".gallery ul li:nth-child(2) span img").delay(300).animate({"margin-top":"0", "opacity":"1"},1600);
			$(".gallery ul li:nth-child(3) p img").addClass("scale").animate({"opacity":"1"});
			$(".gallery ul li:nth-child(3) span img").delay(500).animate({"margin-top":"0", "opacity":"1"},1400);
		}, 800);
		setTimeout(function(){
			$(".gallery div").delay(1000).animate({"margin-top":"0", "opacity":"1"},800);
		}, 800);
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
		<% If not( left(currenttime,10)>="2017-07-11" and left(currenttime,10)<"2017-07-19" ) Then %>
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
<script type="text/javascript" src="/lib/js/jquery.flowslider.js"></script>
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
		</div>

		<%' about %>
		<div class="about">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
			<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
		</div>

		<%' brand %>
		<div class="brand">
			<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79008/img_rawrow_eyewear_brand.jpg" alt="" />
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79008/txt_rawrow_eyewear_brand.png" alt="[RAW] 날것, 본질의 가치에 집중하여, 물건 본연의 역할에 충실한 제품을 만들다. 우리는 안경의 본질에 대해 묻고 또 물었습니다. 누군가에게 안경은 그저 시력을 보호하는 의료용 도구 이기도 하고 누군가에게는 자신의 스타일을 표현하는 도구 입니다. 가장 가벼운 것 중에, 가장 튼튼한 물질 100% '베타티타늄'으로 만든 세계에서 두 번째로 가벼운 안경, 기존 R EYE가 가진 장점은 그대로 남기고 더 많은 사람들이 R EYE를 선택할 수 있도록 컬러와 디자인의 폭을 넓혔습니다." /></p>
			<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="" /></div>
		</div>

		<%' item %>
		<div class="item itemA item1">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79008/tit_rawrow.png" alt="RAWROW" /></h3>
			<div class="desc">
				<a href="/shopping/category_prd.asp?itemid=1750257&amp;pEtr=79008">
					<div class="option">
						<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79008/txt_name_1.png" alt="R EYE 240 BETA TITANIUM 46 (5color)" /></p>
						<%' for dev msg : 상품코드 1750257, 할인기간 07/12 ~ 07/18 할인기간이 지나면  <strong class="discount">...</strong> 숨겨주세요(상품 2개) %>
						<%
							IF application("Svr_Info") = "Dev" THEN
								itemid = 1239226
							Else
								itemid = 1750257
							End If
							set oItem = new CatePrdCls
								oItem.GetItemData itemid
						%>						
						<% If oItem.FResultCount > 0 Then %>
							<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
								<div class="price">
									<% If not( left(currenttime,10)>="2017-07-12" and left(currenttime,10)<"2017-07-19" ) Then %>
										<strong><%= FormatNumber(oItem.Prd.getOrgPrice,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
									<% Else %>
										<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
										<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> <span>(<%= Format00(2, Fix((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%)</span></strong>
									<% End If %>
								</div>
							<% Else %>
								<%' for dev msg :종료후 %>
								<div class="price priceEnd">
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								</div>
							<% End If %>
						<% End If %>
						<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="R EYE 240 BETA TITANIUM 46 (5color) 구매하러가기" /></div>
					</div>
				</a>
				<div class="thumbnail">
					<div class="slidewrap">
						<div id="slide01" class="slide">
							<div><a href="/shopping/category_prd.asp?itemid=1750261&amp;pEtr=79008"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79008/img_slide_prd_1_1.jpg" alt="R EYE 240 BETA TITANIUM 46 (5color)" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1750261&amp;pEtr=79008"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79008/img_slide_prd_1_2.jpg" alt="R EYE 240 BETA TITANIUM 46 (5color)" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1750261&amp;pEtr=79008"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79008/img_slide_prd_1_3.jpg" alt="R EYE 240 BETA TITANIUM 46 (5color)" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1750261&amp;pEtr=79008"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79008/img_slide_prd_1_4.jpg" alt="R EYE 240 BETA TITANIUM 46 (5color)" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1750261&amp;pEtr=79008"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79008/img_slide_prd_1_5.jpg" alt="R EYE 240 BETA TITANIUM 46 (5color)" /></a></div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="item itemA item2">
			<div class="desc">
				<a href="/shopping/category_prd.asp?itemid=1750261&amp;pEtr=79008">
					<div class="option">
						<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79008/txt_name_2.png" alt="R EYE 250 BETA TITANIUM 46 (5color)" /></p>
						<%' for dev msg : 상품코드 1750261, 할인기간 07/12 ~ 07/18 할인기간이 지나면  <strong class="discount">...</strong> 숨겨주세요(상품 2개) %>
						<%
							IF application("Svr_Info") = "Dev" THEN
								itemid = 1239226
							Else
								itemid = 1750261
							End If
							set oItem = new CatePrdCls
								oItem.GetItemData itemid
						%>						
						<% If oItem.FResultCount > 0 Then %>
							<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
								<div class="price">
									<% If not( left(currenttime,10)>="2017-07-12" and left(currenttime,10)<"2017-07-19" ) Then %>
										<strong><%= FormatNumber(oItem.Prd.getOrgPrice,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won")  %></strong>
									<% Else %>
										<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
										<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> <span>(<%= Format00(2, Fix((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%)</span></strong>
									<% End If %>
								</div>
							<% Else %>
								<%' for dev msg :종료후 %>
								<div class="price priceEnd">
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								</div>
							<% End If %>
						<% End If %>
						<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="R EYE 250 BETA TITANIUM 46 (5color) 구매하러가기" /></div>
					</div>
				</a>
				<div class="thumbnail">
					<div class="slidewrap">
						<div id="slide02" class="slide">
							<div><a href="/shopping/category_prd.asp?itemid=1750261&amp;pEtr=79008"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79008/img_slide_prd_2_1.jpg" alt="R EYE 250 BETA TITANIUM 46 (5color)" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1750261&amp;pEtr=79008"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79008/img_slide_prd_2_2.jpg" alt="R EYE 250 BETA TITANIUM 46 (5color)" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1750261&amp;pEtr=79008"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79008/img_slide_prd_2_3.jpg" alt="R EYE 250 BETA TITANIUM 46 (5color)" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1750261&amp;pEtr=79008"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79008/img_slide_prd_2_4.jpg" alt="R EYE 250 BETA TITANIUM 46 (5color)" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1750261&amp;pEtr=79008"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79008/img_slide_prd_2_5.jpg" alt="R EYE 250 BETA TITANIUM 46 (5color)" /></a></div>
						</div>
					</div>
				</div>
			</div>
		</div>


		<%' visual %>
		<div class="visual">
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79008/img_rawrow_eyewear.jpg" alt="10년을 생각하며 만든 안경 - 이 정도면 참 괜찮은 안경이다. 생각하여 만들었습니다." /></p>
		</div>

		<%' gallery %>
		<div class="gallery">
			<ul>
				<li>
					<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79008/txt_gallery1.png" alt="어디 한번 휘어봐요" /></span>
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79008/img_gallery1.jpg" alt="" /></p>
				</li>
				<li>
					<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79008/txt_gallery2.png" alt="세상에서 두번째로 가벼운" /></span>
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79008/img_gallery2.jpg" alt="" /></p>
				</li>
				<li>
					<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79008/txt_gallery3.png" alt="코에 자국나지 않는 방법" /></span>
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79008/img_gallery3.jpg" alt="" /></p>
				</li>
				<li>
					<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79008/txt_gallery4.png" alt="숨은 디테일 찾기" /></span>
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79008/img_gallery4.jpg" alt="" /></p>
				</li>
			</ul>
			<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79008/txt_gallery_v2.png" alt="" /></div>
		</div>

		<%' story %>
		<div class="story">
			<div class="rollingwrap">
				<div id="rolling" class="rolling">
					<div class="swipemask mask-left"></div>
					<div class="swipemask mask-right"></div>
					<button type="button" class="btn-nav arrow-left">Previous</button>
					<button type="button" class="btn-nav arrow-right">Next</button>
					<div class="swiper">
						<div class="swiper-container swiper1">
							<div class="swiper-wrapper" style="height:630px;">
								<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79008/img_slide01.jpg" alt="#보다 가벼운 : 보다 가볍게, 오늘 하루를 시작하세요!" /></div>
								<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79008/img_slide02.jpg" alt="#보다 특별한 : 더 특별해진 R EYE와 함께하는 일상" /></div>
								<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79008/img_slide03.jpg" alt="#보다 오래도록 : 10년 안경이 될 수 있도록, 보다 오래도록 함께 하고싶은 안경" /></div>
							</div>
						</div>
					</div>
					<div class="pagination"></div>
				</div>
			</div>
		</div>

		<%' finish %>
		<div class="finish">
			<a href="/street/street_brand_sub06.asp?makerid=rawrow">브랜드로 바로 이동</a>
			<strong><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79008/txt_finish.png" alt="우린 앞으로도 계속, 가볍고 편안하고 만만한 안경 다운 안경을 만들거에요. RAWROW" /></strong>
		</div>

		<%' comment %>
		<div class="commentevet">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79008/tit_comment.png" alt="Hey, something project 여러분에게 안경이란 어떤 의미인가요?" /></h3>
			<p class="hidden">정성껏 코멘트를 남겨주신 1분을 추첨하여 로우로우의 R EYE 240 or 250 BETA TITANIUM 제품을 선물 드립니다. </p>
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
					<legend>코멘트 쓰기</legend>
						<ul class="choice">
							<li class="ico1"><button type="button" value="1">#보다 가벼운</button></li>
							<li class="ico2"><button type="button" value="2">#보다 특별한</button></li>
							<li class="ico3"><button type="button" value="3">#보다 오래도록</button></li>
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

			<%' commentlist %>
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
												#보다 가벼운
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="2" then %>
												#보다 특별한
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="3" then %>
												#보다 오래도록
											<% else %>
												#보다 가벼운
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