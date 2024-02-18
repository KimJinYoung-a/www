<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈
' History : 2017-06-13 원승현 생성
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
	eCode   =  66339
Else
	eCode   =  78508
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
.heySomething .topic {background-color:#fffae7;}
.heySomething .topic h2 {z-index:5;}
.heySomething .topic .figure a {display:block; position:relative; width:100%; height:780px;}
.heySomething .topic .figure img {position:absolute; top:0; left:50%; margin-left:-951px;}

/* brand */
.heySomething .brand1 {overflow:hidden; position:relative; width:780px; height:798px; margin:405px auto 0; padding:0;}
.heySomething .brand1 h3 {position:absolute; right:0; bottom:0;}
.heySomething .brand1 ul li {position:absolute;}
.heySomething .brand1 ul li.first {top:0; left:0;}
.heySomething .brand1 ul li.second {top:0; right:0;}
.heySomething .brand1 ul li.third {bottom:0; left:0;}
.heySomething .brand2 {position:relative; height:870px; margin-top:500px;}
.heySomething .brand2 .txt {position:absolute; top:420px; left:50%; margin-left:75px; z-index:20;}
.heySomething .slideTemplateV15, 
.wideSlide .slidesjs-container,
.wideSlide .slidesjs-control,
.wideSlide .swiper-slide,
.wideSlide .swiper-slide img{height:870px !important;}
.brand2 .slideTemplateV15 .slidesjs-pagination {display:none;}

/* item */
.heySomething .item {width:1140px; margin:504px auto 0; padding:0;}
.heySomething .item h3 {position:relative; height:48px; text-align:center;}
.heySomething .item h3 .horizontalLine1, .heySomething .item h3 .horizontalLine2 {position:absolute; top:21px; width:298px; height:1px; background-color:#ddd;}
.heySomething .item h3 .horizontalLine1 {left:0;}
.heySomething .item h3 .horizontalLine2 {right:0;}
.heySomething .item .desc {position:relative; width:1140px; height:395px; margin:150px auto 0; padding-bottom:165px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/70310/bg_line_dashed.png) repeat-x 0 100%;}
.heySomething .item .desc1 {margin-top:120px;}
.heySomething .item .desc2 {padding-bottom:120px;}
.heySomething .item .desc3 {padding-bottom:100px; border-bottom:1px solid #ddd; background:none;}
.heySomething .item .desc .option {height:395px; text-align:left;}
.heySomething .item .desc .option {margin-left:35px;}
.heySomething .item .desc2 .option {float:right; margin-right:90px;}
.heySomething .item .desc .option .substance {bottom:95xp;}
.heySomething .item .desc3 .option .substance {bottom:116px;}
.heySomething .item .desc a:hover {text-decoration:none;}
.heySomething .item .desc .thumbnail {width:522px; height:295px; position:absolute; top:100px;} 
.heySomething .item .desc1 .thumbnail {right:145px;}
.heySomething .item .desc2 .thumbnail {top:50px; left:67px;}
.heySomething .item .desc3 .thumbnail {top:35px; right:85px;}
.heySomething .item .desc1 .slidewrap .slidesjs-control > div:first-child {top:5px !important; left:20px !important;}
.heySomething .item .desc .slidewrap .slidesjs-navigation {display:none;}

/* story */
.heySomething .story {margin-top:452px; padding-bottom:0;}
.heySomething .story h3 {margin-bottom:0;}
.heySomething .rolling {margin-top:58px; padding-top:132px;}
.heySomething .rolling .pagination {top:0; width:696px; margin-left:-261px;}
.heySomething .rolling .pagination .swiper-pagination-switch {width:102px; height:102px; margin:0 36px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/78508/img_ico.png) no-repeat 0 0;}
.heySomething .rolling .pagination span.swiper-active-switch {background-position:0 -102px;}
.heySomething .rolling .pagination span:first-child + span {background-position:-174px 0;}
.heySomething .rolling .pagination span:first-child + span.swiper-active-switch {background-position:-174px -102px;}
.heySomething .rolling .pagination span:first-child + span + span {background-position:-348px 0;}
.heySomething .rolling .pagination span:first-child + span + span.swiper-active-switch {background-position:-348px -102px;}
.heySomething .rolling .pagination span:first-child + span + span + span {background-position:-522px 0;}
.heySomething .rolling .pagination span:first-child + span + span + span.swiper-active-switch {background-position:-522px -102px;}
.heySomething .rolling .pagination span em {bottom:-762px; left:50%;height:100px; width:980px; margin-left:-490px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/78508/txt_story_desc.png); cursor:default;}
.heySomething .rolling .pagination span .desc2 {background-position:0 -100px;}
.heySomething .rolling .pagination span .desc3 {background-position:0 -200px;}
.heySomething .rolling .pagination span .desc4 {background-position:0 100%;}
.heySomething .swipemask {top:132px;}
.heySomething .rolling .btn-nav {top:442px;}

/* finish */
.heySomething .finish {height:781px; background:#fffef4 url(http://webimage.10x10.co.kr/eventIMG/2017/hey/78508/img_finish.jpg) no-repeat 50% 0; margin-top:590px;}
.heySomething .finish p {width:291px; position:absolute; top:120px; left:50%; margin-left:-146px;}

/* comment */
.heySomething .commentevet {margin-top:465px; padding-top:50px;}
.heySomething .commentevet .form {margin-top:25px;}
.heySomething .commentevet .form .choice li {width:92px; height:92px; margin-right:22px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/78508/img_ico.png); background-position:0 -204px;}
.heySomething .commentevet .form .choice li.ico2 button {background-position:-114px -204px;}
.heySomething .commentevet .form .choice li.ico2 button.on {background-position:-114px -296px;}
.heySomething .commentevet .form .choice li.ico3 button {background-position:-228px -204px;}
.heySomething .commentevet .form .choice li.ico3 button.on {background-position:-228px -296px;}
.heySomething .commentevet textarea {margin-top:25px;}
.heySomething .commentlist table td strong {width:92px; height:92px; margin-left:18px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/78508/img_ico.png); background-position:0 -204px;}
.heySomething .commentlist table td strong.ico2 {background-position:-114px -204px;}
.heySomething .commentlist table td strong.ico3 {background-position:-228px -204px;}

</style>
<script type="text/javascript">
$(function(){
	
	/* slide js */
	$("#slide01").slidesjs({
		width:"522",
		height:"295",
		pagination:false,
		navigation:{effect:"fade"},
		play:{interval:1800, effect:"fade", auto:true},
		effect:{fade: {speed:800, crossfade:true}}
	});
	
	/* slide js */
	$("#slide02").slidesjs({
		width:"522",
		height:"295",
		pagination:false,
		navigation:{effect:"fade"},
		play:{interval:1800, effect:"fade", auto:true},
		effect:{fade: {speed:800, crossfade:true}}
	});
	
	/* slide js */
	$("#slide03").slidesjs({
		width:"522",
		height:"295",
		pagination:false,
		navigation:{effect:"fade"},
		play:{interval:1800, effect:"fade", auto:true},
		effect:{fade: {speed:800, crossfade:true}}
	});

	// wide slide
	$('.wideSlide .swiper-wrapper').slidesjs({
		width:1920,
		height:870,
		navigation:{effect:'fade'},
		play:{interval:1800, effect:'fade', auto:false},
		effect:{fade: {speed:1200, crossfade:true}
		},
		callback: {
			complete: function(number) {
				var pluginInstance = $('.wideSlide .swiper-wrapper').data('plugin_slidesjs');
				setTimeout(function() {
					pluginInstance.play(true);
				}, pluginInstance.options.play.interval);
			}
		}
	});


	/* swipe */
	var swiper1 = new Swiper('.swiper1',{
		centeredSlides:true,
		slidesPerView:"auto",
		loop: true,
		speed:1500,
		autoplay:3000,
		simulateTouch:false,
		pagination: '.pagination',
		paginationClickable: true
	});
	$('.arrow-left').on('click', function(e){
		e.preventDefault()
		swiper1.swipePrev()
	});
	$('.arrow-right').on('click', function(e){
		e.preventDefault()
		swiper1.swipeNext()
	});

	$('.pagination span:nth-child(1)').append('<em class="desc1"></em>');
	$('.pagination span:nth-child(2)').append('<em class="desc2"></em>');
	$('.pagination span:nth-child(3)').append('<em class="desc3"></em>');
	$('.pagination span:nth-child(4)').append('<em class="desc4"></em>');
	$('.pagination span:nth-child(5)').append('<em class="desc5"></em>');

	$('.pagination span em').hide();
	$('.pagination .swiper-active-switch em').show();

	setInterval(function() {
		$('.pagination span em').hide();
		$('.pagination .swiper-active-switch em').show();
	}, 500);

	$('.pagination span,.btnNavigation').click(function(){
		$('.pagination span em').hide();
		$('.pagination .swiper-active-switch em').show();
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
		if (scrollTop > 900 ) {
			brandAnimation();
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
	$(".heySomething .brand1 h3").css({"bottom":"-20px", "right":"-20px", "opacity":"0"});
	$(".heySomething .brand1 ul li.first").css({"top":"-20px", "left":"-20px", "opacity":"0"});
	$(".heySomething .brand1 ul li.second").css({"top":"-20px", "right":"-20px", "opacity":"0"});
	$(".heySomething .brand1 ul li.third").css({"bottom":"-20px", "left":"-20px", "opacity":"0"});
	function brandAnimation() {
		$(".heySomething .brand1 h3").delay(100).animate({"bottom":"0", "right":"0", "opacity":"1"},700);
		$(".heySomething .brand1 ul li.first").delay(100).animate({"top":"0", "left":"0", "opacity":"1"},700);
		$(".heySomething .brand1 ul li.second").delay(100).animate({"top":"0", "right":"0", "opacity":"1"},700);
		$(".heySomething .brand1 ul li.third").delay(100).animate({"bottom":"0", "left":"0", "opacity":"1"},700);
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
		<% If not( left(currenttime,10)>="2017-06-13" and left(currenttime,10)<"2017-06-22" ) Then %>
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
			<div class="figure">
				<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78508/img_item_represent.jpg" alt="자연이 들려주는 이야기, GENTLE BREEZE" />
			</div>
		</div>

		<%' about %>
		<div class="about">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
			<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
		</div>

		<%' brand %>
		<div class="brand brand1">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78508/img_brand_logo.jpg" alt="젠틀브리즈" /></h3>
			<ul>
				<li class="first"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78508/img_brand_01.jpg" alt="젠틀브리즈" /></li>
				<li class="second"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78508/img_brand_02.jpg" alt="젠틀브리즈" /></li>
				<li class="third"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78508/img_brand_03.jpg" alt="젠틀브리즈" /></li>
			</ul>
		</div>

		<%' brand2 %>
		<div class="brand brand2">
			<div class="slideTemplateV15 wideSlide">
				<div class="swiper-container">
					<div class="swiper-wrapper">
						<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78508/img_brand_slide_1.jpg" alt="젠틀브리즈" /></div>
						<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78508/img_brand_slide_2.jpg" alt="젠틀브리즈" /></div>
						<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78508/img_brand_slide_3.jpg" alt="젠틀브리즈" /></div>
					</div>
				</div>
			</div>
		</div>

		<%' item %>
		<div class="item">
			<div class="inner">
				<h3>
					<span class="logo"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78508/img_logo.png" alt="젠틀브리즈" /></span>
					<span class="horizontalLine1"></span>
					<span class="horizontalLine2"></span>
				</h3>

				<div class="desc desc1">
					<a href="/shopping/category_prd.asp?itemid=1709650&amp;pEtr=78508">
						<div class="option">
							<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78508/txt_prd_name_1.png" alt="Flat Brimmed  Straw Ribbon Hat (4color)" /></p>
							<%' for dev msg : 상품코드 1709650, 할인기간 06/14 ~ 06/21 할인기간이 지나면  <strong class="discount">...</strong> 숨겨주세요 %>
							<%
								IF application("Svr_Info") = "Dev" THEN
									itemid = 1239226
								Else
									itemid = 1709650
								End If
								set oItem = new CatePrdCls
									oItem.GetItemData itemid
							%>
							<% If oItem.FResultCount > 0 Then %>
								<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
									<div class="price">
										<% If not( left(currenttime,10)>="2017-06-14" and left(currenttime,10)<"2017-06-22" ) Then %>
											<strong><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></strong>
										<% Else %>
											<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/txt_only_tenten_20percent.png" alt="텐바이텐에서 ONLY 20%" /></strong>
											<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
											<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
										<% End If %>
									</div>
								<% Else %>
									<%' for dev msg :종료후 %>
									<div class="price priceEnd">
										<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
									</div>
								<% End If %>
								<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78508/txt_prd_details_1.png" alt="찬란한 여름 태양이 내리쬐는  그 곳으로 떠나요" /></p>
								<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러 가기" /></div>
							<% End If %>
							<%	set oItem = nothing %>
						</div>
					</a>
					<div class="thumbnail">
						<div class="slidewrap">
							<div id="slide01" class="slide">
								<div><a href="/shopping/category_prd.asp?itemid=1709650&pEtr=78508"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78508/img_slide_prd_1_1.png" alt="Flat Brimmed  Straw Ribbon Hat (4color)" /></a></div>
								<div><a href="/shopping/category_prd.asp?itemid=1709650&pEtr=78508"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78508/img_slide_prd_1_2.png" alt="Flat Brimmed  Straw Ribbon Hat (4color)" /></a></div>
								<div><a href="/shopping/category_prd.asp?itemid=1709650&pEtr=78508"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78508/img_slide_prd_1_3.png" alt="Flat Brimmed  Straw Ribbon Hat (4color)" /></a></div>
								<div><a href="/shopping/category_prd.asp?itemid=1709650&pEtr=78508"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78508/img_slide_prd_1_4.png" alt="Flat Brimmed  Straw Ribbon Hat (4color)" /></a></div>
							</div>
						</div>
					</div>
				</div>

				<div class="desc desc2">
					<a href="/shopping/category_prd.asp?itemid=1709669&amp;pEtr=78508">
						<div class="option">
							<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78508/txt_prd_name_2.png" alt="Raffia Bucket Hat (2color)" /></p>
							<%' for dev msg : 상품코드 1709669, 할인기간 06/14 ~ 06/21 할인기간이 지나면  <strong class="discount">...</strong> 숨겨주세요 %>
							<%
								IF application("Svr_Info") = "Dev" THEN
									itemid = 1239226
								Else
									itemid = 1709669
								End If
								set oItem = new CatePrdCls
									oItem.GetItemData itemid
							%>
							<% If oItem.FResultCount > 0 Then %>
								<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
									<div class="price">
										<% If not( left(currenttime,10)>="2017-06-14" and left(currenttime,10)<"2017-06-22" ) Then %>
											<strong><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></strong>
										<% Else %>
											<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/txt_only_tenten_20percent.png" alt="텐바이텐에서 ONLY 20%" /></strong>
											<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
											<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
										<% End If %>
									</div>
								<% Else %>
									<%' for dev msg :종료후 %>
									<div class="price priceEnd">
										<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
									</div>
								<% End If %>
							<% End If %>
							<%	set oItem = nothing %>
							<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78508/txt_prd_details_2.png" alt="꾸밈없이 편하고 자연스러운  그 곳의 이야기 " /></p>
							<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러 가기" /></div>
						</div>
					</a>
					<div class="thumbnail">
						<div class="slidewrap">
							<div id="slide02" class="slide">
								<div><a href="/shopping/category_prd.asp?itemid=1709669&pEtr=78508"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78508/img_slide_prd_2_1.png" alt="Raffia Bucket Hat (2color)" /></a></div>
								<div><a href="/shopping/category_prd.asp?itemid=1709669&pEtr=78508"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78508/img_slide_prd_2_2.png" alt="Raffia Bucket Hat (2color)" /></a></div>
							</div>
						</div>
					</div>
				</div>

				<div class="desc desc3">
					<a href="/shopping/category_prd.asp?itemid=1709632&amp;pEtr=78508">
						<div class="option">
							<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78508/txt_prd_name_3.png" alt="Wide Raffia Hat (2color)" /></p>
							<%' for dev msg : 상품코드 1709632, 할인기간 06/14 ~ 06/21 할인기간이 지나면  <strong class="discount">...</strong> 숨겨주세요 %>
							<%
								IF application("Svr_Info") = "Dev" THEN
									itemid = 1239226
								Else
									itemid = 1709632
								End If
								set oItem = new CatePrdCls
									oItem.GetItemData itemid
							%>
							<% If oItem.FResultCount > 0 Then %>
								<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
									<div class="price">
										<% If not( left(currenttime,10)>="2017-06-14" and left(currenttime,10)<"2017-06-22" ) Then %>
											<strong><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></strong>
										<% Else %>
											<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/txt_only_tenten_20percent.png" alt="텐바이텐에서 ONLY 20%" /></strong>
											<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
											<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
										<% End If %>
									</div>
								<% Else %>
									<%' for dev msg :종료후 %>
									<div class="price priceEnd">
										<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
									</div>
								<% End If %>
							<% End If %>
							<%	set oItem = nothing %>
							<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78508/txt_prd_details_3.png" alt="우리의 뜨거운 여름을 부탁해! " /></p>
							<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러 가기" /></div>
						</div>
					</a>
					<div class="thumbnail">
						<div class="slidewrap">
							<div id="slide03" class="slide">
								<div><a href="/shopping/category_prd.asp?itemid=1709632&pEtr=78508"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78508/img_slide_prd_3_1.png" alt="" /></a></div>
								<div><a href="/shopping/category_prd.asp?itemid=1709632&pEtr=78508"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78508/img_slide_prd_3_2.png" alt="" /></a></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<%' story %>
		<div class="story">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71159/tit_story.png" alt="How to  feel the breeze" /></h3>
			<div class="rollingwrap">
				<div class="rolling">
					<div class="swipemask mask-left"></div>
					<div class="swipemask mask-right"></div>
					<button type="button" class="btn-nav arrow-left">Previous</button>
					<button type="button" class="btn-nav arrow-right">Next</button>
					<div class="swiper">
						<div class="swiper-container swiper1">
							<div class="swiper-wrapper">
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1709632&amp;pEtr=78508"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78508/img_slide_1.jpg" alt="#Story 사람, 장소, 전통의 오래된 이야기를 현대적인 감각으로 전하고 있습니다 " /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1709650&amp;pEtr=78508"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78508/img_slide_2.jpg" alt="#Culture 우리는 지역 사회를 지원하고 전통 공예를 보전하는 것을 목표로 합니다."/></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1709669&amp;pEtr=78508"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78508/img_slide_3.jpg" alt="#People 삶의 이야기를 담아 한땀 한땀 정성스럽게 제작 됩니다" /></a>
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
			<a href="/shopping/category_prd.asp?itemid=1493473&amp;pEtr=78508">
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78508/txt_finish.png" alt="당신이 있는 바로 그 곳에 기분 좋은 미풍이 함께 하길 바랍니다" /></p>
			</a>
		</div>

		<%' comment %>
		<div class="commentevet">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78508/tit_comment.png" alt="Hey, something project 당신이 원하는 바람" /></h3>
			<p class="hidden">지금 이 순간 당신이 원하는 바람(WISH)은 무엇인가요? 정성껏 코멘트를 남겨주신 5분을 선정하여 젠틀브리즈 모자를 선물로 드립니다. (상품 랜덤) 코멘트 작성기간은 2017년 6월 14일부터 6월 21일까지며, 발표는 6월26일 입니다.</p>
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
							<li class="ico1"><button type="button" value="1">story</button></li>
							<li class="ico2"><button type="button" value="2">culture</button></li>
							<li class="ico3"><button type="button" value="3">people</button></li>
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
												story
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="2" then %>
												culture
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="3" then %>
												people
											<% else %>
												story
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