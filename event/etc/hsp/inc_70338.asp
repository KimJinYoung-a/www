<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈 30
' History : 2016-04-19 원승현 생성
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

dim currenttime
	currenttime =  now()
	'currenttime = #10/07/2015 09:00:00#

dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  66111
Else
	eCode   =  70338
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
	iCPageSize = 5		'풀단이면 15개			'/수기이벤트 둘다 강제 12고정
else
	iCPageSize = 5		'메뉴가 있으면 10개			'/수기이벤트 둘다 강제 12고정
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
 
Dim hspchk
'// 현재 주소값 체크하여 신규, 구버전 확인
hspchk = Split(LCase(Request.ServerVariables("PATH_INFO")),"/")
%>
<style type="text/css">
/* title */
.heySomething .topic {background:#f4f4f4 url(http://webimage.10x10.co.kr/eventIMG/2016/hey/70338/img_item_represent.jpg) no-repeat 50% 0;}
.heySomething .topic .bnr {text-indent:-9999em;}
.heySomething .topic .bnr a {display:block; width:100%; height:780px;}

/* item */
.heySomething .itemB {background:none;}
.heySomething .item h3 {position:relative; height:86px;}
.heySomething .item h3 .disney {position:absolute; top:0; left:390px;}
.heySomething .item h3 .tenten {position:absolute; top:30px; left:592px;}
.heySomething .item h3 .verticalLine {position:absolute; top:17px; left:569px; width:1px; height:54px; background-color:#a5a5a5;}
.heySomething .item h3 .horizontalLine1, .heySomething .item h3 .horizontalLine2 {position:absolute; top:45px; width:370px; height:1px; background-color:#d9d9d9;}
.heySomething .item h3 .horizontalLine1 {left:0;}
.heySomething .item h3 .horizontalLine2 {right:0;}
.heySomething .item .slidewrap {padding-top:36px;}
.heySomething .item .with {border:none;}
.heySomething .item .with span {position:relative; z-index:5;}
.heySomething .item .with {border-bottom:1px solid #ddd; text-align:center;}
.heySomething .item .with ul {overflow:hidden; width:1028px; margin:0 auto; padding:45px 0;}
.heySomething .item .with ul li {float:left; width:217px; padding:0 20px;}
.heySomething .item .with ul li a {color:#777;}
.heySomething .item .with ul li span, .heySomething .with ul li strong {display:block; font-size:11px;}
.heySomething .item .with ul li span {margin-top:15px;}

/* visual */
.heySomething .visual {margin-top:430px;}
.heySomething .visual .figure {background-color:#f8edf4;}

/* brand */
.heySomething .brand {position:relative; height:505px; padding-top:412px;}
.heySomething .brand .alice {position:absolute; top:0; left:50%; margin-left:-255px;}

/* video */
.video {width:1140px; margin:300px auto 0;}

/* story */
.heySomething .rolling {padding-top:176px;}
.heySomething .rolling .pagination {top:0; width:824px; margin-left:-412px;}
.heySomething .rolling .swiper-pagination-switch {width:156px; height:156px; margin:0 25px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/70338/btn_pagination.png);}
.heySomething .rolling .pagination span.swiper-active-switch {background-position:0 100%;}
.heySomething .rolling .pagination span:first-child + span {background-position:-207px 0;}
.heySomething .rolling .pagination span:first-child + span.swiper-active-switch {background-position:-207px 100%;}
.heySomething .rolling .pagination span:first-child + span + span {background-position:-413px 0;}
.heySomething .rolling .pagination span:first-child + span + span.swiper-active-switch {background-position:-413px 100%;}
.heySomething .rolling .pagination span:first-child + span + span + span {background-position:100% 0;}
.heySomething .rolling .pagination span:first-child + span + span + span.swiper-active-switch {background-position:100% 100%;}
.heySomething .rolling .pagination span em {bottom:-770px; left:50%;height:120px; width:860px; margin-left:-430px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/70338/txt_story_desc.png); cursor:default;}
.heySomething .rolling .pagination span .desc2 {background-position:0 -120px;}
.heySomething .rolling .pagination span .desc3 {background-position:0 -240px;}
.heySomething .rolling .pagination span .desc4 {background-position:0 -360px;}
.heySomething .rolling .pagination span .desc5 {background-position:0 100%;}
.heySomething .swipemask {top:176px;}

/* finish */
.heySomething .finish {height:813px; background-color:#f4f4f0;}

/* comment */
.heySomething .commentevet .form .choice li {width:132px; margin-right:18px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/70338/bg_ico.png); background-position:0 0;}
.heySomething .commentevet .form .choice li.ico2 button {background-position:-150px 0;}
.heySomething .commentevet .form .choice li.ico3 button {background-position:-300px 0;}
.heySomething .commentevet .form .choice li.ico4 button {background-position:-450px 0;}

.heySomething .commentlist table td strong {height:106px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/70338/bg_ico.png); background-position:0 -18px;}
.heySomething .commentlist table td strong.ico2 {background-position:-150px -18px;}
.heySomething .commentlist table td strong.ico3 {background-position:-300px -18px;}
.heySomething .commentlist table td strong.ico4 {background-position:-450px -18px;}
</style>
<script type='text/javascript'>

$(function(){
	/* slide js */
	$("#slide").slidesjs({
		width:"590",
		height:"440",
		pagination:false,
		navigation:{effect:"fade"},
		play:{interval:2500, effect:"fade", auto:true},
		effect:{fade: {speed:1200, crossfade:true}
		},
		callback: {
			complete: function(number) {
				var pluginInstance = $('#slide').data('plugin_slidesjs');
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
	$(".form .choice li button").click(function(){
		$(".form .choice li button").removeClass("on");
		if ( $(this).hasClass("on")) {
			$(this).removeClass("on");
		} else {
			$(this).addClass("on");
		}
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
		if (scrollTop > 750 ) {
			itemAnimation()
		}
		if (scrollTop > 3500 ) {
			brandAnimation()
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

	/* item animation */
	$(".heySomething .item h3 span").css({"opacity":"0"});
	$(".heySomething .item h3 .disney").css({"left":"502px"});
	$(".heySomething .item h3 .tenten").css({"left":"528px"});
	function itemAnimation() {
		$(".heySomething .item h3 .disney").delay(200).animate({"left":"390px", "opacity":"1"},800);
		$(".heySomething .item h3 .tenten").delay(200).animate({"left":"592px", "opacity":"1"},800);
		$(".heySomething .item h3 .horizontalLine1").delay(800).animate({"opacity":"1"},500);
		$(".heySomething .item h3 .horizontalLine2").delay(800).animate({"opacity":"1"},500);
		$(".heySomething .item h3 .verticalLine").delay(800).animate({"opacity":"1"},500);
	}

	/* brand animation */
	$(".heySomething .brand .alice").css({"top":"-60px"});
	$(".heySomething .brand p").css({"height":"50px", "opacity":"0"});
	$(".heySomething .brand .btnDown").css({"opacity":"0"});
	function brandAnimation() {
		$(".heySomething .brand .alice").delay(50).animate({"top":"0"},800);
		$(".heySomething .brand p").delay(400).animate({"height":"367px", "opacity":"1"},600);
		$(".heySomething .brand .btnDown").delay(1500).animate({"opacity":"1"},1000);
	}

	/* finish animation */
	function finishAnimation() {
		$(".heySomething .finish p").addClass("rotateIn");
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
		<% If not( left(currenttime,10)>="2016-04-19" and left(currenttime,10)<"2016-04-26" ) Then %>
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
			<div class="bnr"><a href="/shopping/category_prd.asp?itemid=1473441&amp;pEtr=70338">Disney Vintage Cream Glass</a></div>
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
					<span class="disney"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70338/img_logo_disney.png" alt="디즈니" /></span>
					<span class="tenten"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70338/img_logo_tenten.png" alt="텐바이텐" /></span>
					<span class="verticalLine"></span>
					<span class="horizontalLine1"></span>
					<span class="horizontalLine2"></span>
				</h3>
				<%
				dim itemid, oItem
				itemid = 1473441
				set oItem = new CatePrdCls
					oItem.GetItemData itemid
				%>
				<div class="desc">
					<%' 상품 이름, 가격, 구매하기 %>
					<div class="option">
						<em class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70338/txt_name.png" alt="Disney Vintage Cream Glass 텐바이텐 단독 제작 지름 7.5cm, 높이 9cm 소재 유리 " /></em>
						<% if oItem.FResultCount > 0 then %>
							<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
							<div class="price">
								<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/txt_only_<%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>percent.png" alt="단, 일주일만 ONLY <%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%" /></strong>
								<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
								<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
							</div>
							<% Else %>
							<%' for dev msg : 종료 후 %>
							<div class="price priceEnd">
								<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
							</div>
							<% End If %>
						<% End If %>
						<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70338/txt_substance.png" alt="365일, 당신의 일상에서 늘 함께하는 컵 디즈니 친구들과 함께라면, 평범한 일상이 좀 더 즐거워지지 않을까요?" /></p>
						<div class="btnget"><a href="/shopping/category_prd.asp?itemid=1473441&amp;pEtr=70338"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="Disney Vintage Cream Glass 구매하러 가기" /></a></div>
					</div>

					<%' slide %>
					<div class="slidewrap">
						<div id="slide" class="slide">
							<div><a href="/shopping/category_prd.asp?itemid=1473441&amp;pEtr=70338"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70338/img_slide_01.jpg" alt="house " /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1473441&amp;pEtr=70338"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70338/img_slide_02.jpg" alt="덤보" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1473441&amp;pEtr=70338"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70338/img_slide_03.jpg" alt="덤보" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1473441&amp;pEtr=70338"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70338/img_slide_04.jpg" alt="덤보" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1431913&amp;pEtr=70338"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70338/img_slide_06.jpg" alt="덤보" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1431913&amp;pEtr=70338"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70338/img_slide_06.jpg" alt="덤보" /></a></div>
						</div>
					</div>
				</div>
				<%
					Set oItem = Nothing
				%>

				<%' for dev msg : 가격 부분만 개발 해주세요 %>
				<div class="with">
					<span><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/ico_plus.png" alt="" /></span>
					<ul>
						<%
						Dim itemid2, oItem2
						itemid2 = 1450239
						set oItem2 = new CatePrdCls
							oItem2.GetItemData itemid2
						%>
						<li>
							<a href="/shopping/category_prd.asp?itemid=1450239&amp;pEtr=70338">
								<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70338/img_with_item_01.jpg" alt="" />
								<span>Vintage Mickey&amp;Mini_Pouch</span>
								<strong><%= FormatNumber(oItem2.Prd.FSellCash,0) & chkIIF(oItem2.Prd.IsMileShopitem,"Point","won") %></strong>
							</a>
						</li>
						<%
							Set oItem2 = Nothing
						%>

						<%
							Dim itemid3, oItem3
							itemid3 = 1434283
							set oItem3 = new CatePrdCls
								oItem3.GetItemData itemid3

						%>
						<li>
							<a href="/shopping/category_prd.asp?itemid=1434283&amp;pEtr=70338">
								<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70338/img_with_item_02.jpg" alt="" />
								<span>Vintage_PLAYING CARDS</span>
								<strong><%= FormatNumber(oItem3.Prd.FSellCash,0) & chkIIF(oItem3.Prd.IsMileShopitem,"Point","won") %></strong>
							</a>
						</li>
						<%
							Set oItem3 = Nothing
						%>

						<%
							Dim itemid4, oItem4
							itemid4 = 1431913
							set oItem4 = new CatePrdCls
								oItem4.GetItemData itemid4
						%>
						<li>
							<a href="/shopping/category_prd.asp?itemid=1431913&amp;pEtr=70338">
								<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70338/img_with_item_03.jpg" alt="" />
								<span>Vintage Mickey_Note (5종세트)</span>
								<strong><%= FormatNumber(oItem4.Prd.FSellCash,0) & chkIIF(oItem4.Prd.IsMileShopitem,"Point","won") %></strong>
							</a>
						</li>
						<%
							Set oItem4 = Nothing
						%>

						<%
							Dim itemid5, oItem5
							itemid5 = 1418361
							set oItem5 = new CatePrdCls
								oItem5.GetItemData itemid5
						%>
						<li>
							<a href="/shopping/category_prd.asp?itemid=1418361&amp;pEtr=70338">
								<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70338/img_with_item_04.jpg" alt="" />
								<span>Vintage Mickey_아이폰6/6S 케이스</span>
								<strong><%= FormatNumber(oItem5.Prd.FSellCash,0) & chkIIF(oItem5.Prd.IsMileShopitem,"Point","won") %></strong>
							</a>
						</li>
						<%
							Set oItem5 = Nothing
						%>

					</ul>
				</div>
			</div>
		</div>

		<%' visual %>
		<div class="visual">
			<div class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70338/img_item_visual_big.jpg" alt="" /></div>
		</div>

		<%' brand %>
		<div class="brand">
			<div class="alice"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70338/img_alice.png" alt="" /></div>
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70338/txt_brand.png" alt="Money doesn&apos;t excite me, my ideas excited me. Walt Disney 디즈니는 1923 설립 이래로 필름스케치, 드로잉, 포스터 등 다양한 작업을 통해 디즈니 고유의 아트워크를 창조하고있습니다. 디즈니의 빈티지 컬렉션은 클래식 감성을 간직한 사랑스러운 디즈니 캐릭터를 통해 어린 시절의 추억과 향수를 불러일으킵니다." /></p>
			<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="" /></div>
		</div>

		<%' movie %>
		<div class="video">
			<iframe src="//player.vimeo.com/video/163368427" width="1140" height="640" frameborder="0" title="Juice Recipe" webkitallowfullscreen="" mozallowfullscreen="" allowfullscreen=""></iframe>
		</div>

		<%' story %>
		<div class="story">
			<div class="rollingwrap">
				<div class="rolling">
					<div class="swipemask mask-left"></div>
					<div class="swipemask mask-right"></div>
					<button type="button" class="btn-nav arrow-left">Previous</button>
					<button type="button" class="btn-nav arrow-right">Next</button>
					<div class="swiper">
						<div class="swiper-container swiper1">
							<div class="swiper-wrapper" style="height:630px;">
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1473441&amp;pEtr=70338"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70338/img_swiper_01.jpg" alt="house 당신의 아침을 즐겁게 만들어 줄 위트 있는 일러스트 하루의 출발을 디즈니 친구들과 웃음으로 시작해보세요" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1473441&amp;pEtr=70338"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70338/img_swiper_02.jpg" alt="office 나른한 오후 , 오늘도 열심히 일하는 당신에게 주는 선물 디즈니 친구들이 당신을 응원할게요." /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1473441&amp;pEtr=70338"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70338/img_swiper_03.jpg" alt="school 수학,과학,영어… 지끈지끈 머리가 아파올 때, 유쾌한 디즈니 친구들과 10분의 휴식을 가져보세요." /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1473441&amp;pEtr=70338"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70338/img_swiper_04.jpg" alt="picnic 살랑살랑 봄바람이 불어, 나들이가기 딱 좋은 요즘 조금 더 즐거운 피크닉을 만들어 보는 건 어떨까요?" /></a>
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
			<a href="/shopping/category_prd.asp?itemid=1473441&amp;pEtr=70338"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70338/img_item_finish.jpg" alt="Disney Vintage Cream Glass" /></a>
		</div>

		<%' comment %>
		<div class="commentevet">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70338/tit_comment_v1.png" alt="Hey, something project 당신이 갖고 싶은 것" /></h3>
			<p class="hidden">평범했던 일상 속에서 재미있었던 에피소드를 들려주세요. 정성껏 코멘트를 남겨주신 3분을 추첨하여, Disney Vintage Cream Glass를 증정합니다. 코멘트 작성기간은 2016년 4월 20일부터 4월 26일까지며, 발표는 4월 27일 입니다.</p>
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
							<li class="ico1"><button type="button" value="1">house</button></li>
							<li class="ico2"><button type="button" value="2">office</button></li>
							<li class="ico3"><button type="button" value="3">school</button></li>
							<li class="ico4"><button type="button" value="4">picnic</button></li>
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
						<caption>코멘트 목록</caption>
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
												house
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="2" then %>
												office
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="3" then %>
												school
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="4" then %>
												picnic
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
		<%'' // 수작업 영역 끝 %>

<% If Not(Trim(hspchk(1)))="hsproject" Then %>
	</div>
<% End If %>

<!-- #include virtual="/lib/db/dbclose.asp" -->