<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈 30 WWW
' History : 2016-05-03 유태욱 생성
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
dim oItem, itemid
dim currenttime
	currenttime =  now()
'																			currenttime = #03/02/2016 09:00:00#

dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  66118
Else
	eCode   =  70431
End If

dim userid, commentcount, i
	userid = GetEncLoginUserID()

commentcount = getcommentexistscount(userid, eCode, "", "", "", "Y")

dim cEComment ,blnFull, cdl, com_egCode, bidx, blnBlogURL, strBlogURL
dim iCTotCnt, arrCList,intCLoop, ecc
dim iCPageSize, iCCurrpage, isMyComm
dim iCStartPage, iCEndPage, iCTotalPage, iCx,iCPerCnt
	iCCurrpage	= requestCheckVar(Request("iCC"),10)	'현재 페이지 번호
	cdl			= requestCheckVar(Request("cdl"),3)
	blnFull		= requestCheckVar(Request("blnF"),10)
	blnBlogURL	= requestCheckVar(Request("blnB"),10)
	isMyComm	= requestCheckVar(request("isMC"),1)
	ecc	= requestCheckVar(request("ecc"),10)
	
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
	iCPageSize = 6
else
	iCPageSize = 6
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

dim itemid1, itemid2
IF application("Svr_Info") = "Dev" THEN
	itemid1   =  1239115
	itemid2   =  1239227
Else
	itemid1   =  1480689
	itemid2   =  1480688
End If

Dim hspchk
'// 현재 주소값 체크하여 신규, 구버전 확인
hspchk = Split(LCase(Request.ServerVariables("PATH_INFO")),"/")
%>
<style type="text/css">
/* title */
.heySomething .topic {background:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/70431/bg_item_kakao.jpg) repeat-x 0 0;}
.heySomething .topic .bnr {text-indent:-9999em;}
.heySomething .topic .bnr a {display:block; width:100%; height:778px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/70431/img_item_kakao.jpg) no-repeat 50% 0;}

/* item */
.heySomething .item {width:100%; margin-top:355px;}
.heySomething .item .inner {width:1140px; margin:0 auto;}
.heySomething .item h3 {position:relative; height:48px; text-align:center;}
.heySomething .item h3 .logo img {}
.heySomething .item h3 .horizontalLine1, .heySomething .item h3 .horizontalLine2 {position:absolute; top:25px; width:260px; height:1px; background-color:#d9d9d9;}
.heySomething .item h3 .horizontalLine1 {left:0;}
.heySomething .item h3 .horizontalLine2 {right:0;}
.heySomething .item .desc {position:relative; width:1010px; margin:85px auto 0;}
.heySomething .item .desc a {display:block;}
.heySomething .item .desc a:hover {text-decoration:none;}
.heySomething .item .thumbnail {position:absolute; top:0; right:0;}
.heySomething .item .option {height:536px; text-align:left;}
.heySomething .item .with {margin-top:95px; background-color:#f4f4f4; text-align:center;}
.heySomething .item .with ul {overflow:hidden; width:1140px; margin:0 auto; padding:45px 0;}
.heySomething .item .with ul li {float:left; width:170px; padding-right:24px;}
.heySomething .item .with ul li:last-child {padding-right:0;}

@keyframes flip {
	0% {transform:rotateY(180deg); animation-timing-function:ease-out;}
	100% {transform:rotateY(360deg); animation-timing-function:ease-in;}
}
.flip {animation-name:flip; animation-duration:1.2s; animation-iteration-count:1; backface-visibility:visible;}

/* visual */
.visual {position:relative; margin-top:385px;}
.visual .visual1 {height:738px; background:#c4e9f3 url(http://webimage.10x10.co.kr/eventIMG/2016/hey/70431/img_item_visual_big1.jpg) no-repeat 50% 0;}
.visual .visual2 {height:858px; margin-top:222px; background:#ffe1d1 url(http://webimage.10x10.co.kr/eventIMG/2016/hey/70431/img_item_visual_big2.jpg) no-repeat 50% 0;}

/* brand */
.heySomething .brand {position:relative; height:1776px;}
.heySomething .brand div {position:relative; width:1140px; margin:0 auto; text-align:center;}
.heySomething .brand .info {margin-top:115px;}
.heySomething .brand .brand1 {height:742px;}
.heySomething .brand .brand2 {height:698px; margin-top:195px;}
.heySomething .brand .btnDown {margin-top:70px; animation:jump 2.2s ease-in-out}
@keyframes jump {
	0% {margin-top:70px;}
	100% {margin-top:60px;}
}

/* story */
.heySomething .story {padding-bottom:200px; text-align:center;}
.heySomething .rollingwrap {margin-top:60px;}
.heySomething .rolling {padding-top:170px;}
.heySomething .rolling .pagination {top:0;}
.heySomething .rolling .pagination .swiper-pagination-switch {width:156px; height:156px; margin-right:8px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/70431/bg_ico_v1.png) no-repeat 0 0;}
.heySomething .rolling .pagination .swiper-pagination-switch:last-child {margin-right:0;}
.heySomething .rolling .pagination span.swiper-active-switch {background-position:0 -185px;}
.heySomething .rolling .pagination span:first-child + span {background-position:-164px 0;}
.heySomething .rolling .pagination span:first-child + span.swiper-active-switch {background-position:-164px -185px;}
.heySomething .rolling .pagination span:first-child + span + span {background-position:-328px 0;}
.heySomething .rolling .pagination span:first-child + span + span.swiper-active-switch {background-position:-328px -185px;}
.heySomething .rolling .pagination span:first-child + span + span + span {background-position:-492px 0;}
.heySomething .rolling .pagination span:first-child + span + span + span.swiper-active-switch {background-position:-492px -185px;}
.heySomething .rolling .pagination span:first-child + span + span + span + span{background-position:-656px 0;}
.heySomething .rolling .pagination span:first-child + span + span + span + span.swiper-active-switch {background-position:-656px -185px;}
.heySomething .rolling .pagination span:first-child + span + span + span + span + span {background-position:-820px 0;}
.heySomething .rolling .pagination span:first-child + span + span + span + span + span.swiper-active-switch {background-position:-820px -185px;}
.heySomething .rolling .pagination span em {bottom:-845px; left:50%; height:200px; width:980px; margin-left:-490px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/70431/txt_story_desc.png); cursor:default;}
.heySomething .rolling .pagination span .desc2 {background-position:0 -200px;}
.heySomething .rolling .pagination span .desc3 {background-position:0 -400px;}
.heySomething .rolling .pagination span .desc4 {background-position:0 -600px;}
.heySomething .rolling .pagination span .desc5 {background-position:0 -800px;}
.heySomething .rolling .pagination span .desc6 {background-position:0 -1000px;}
.heySomething .rolling .pagination span .desc7 {background-position:0 -1200px;}

.heySomething .rolling .btn-nav {top:450px;}
.heySomething .swipemask {top:170px;}

/* comment */
.heySomething .commentevet .form .choice li {width:132px; margin-right:16px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/70431/bg_ico_v1.png); background-position:0 -400px;}
.heySomething .commentevet .form .choice li.ico1 button.on {background-position:0 -565px;}
.heySomething .commentevet .form .choice li.ico2 button {background-position:-148px -400px;}
.heySomething .commentevet .form .choice li.ico2 button.on {background-position:-148px -565px;}
.heySomething .commentevet .form .choice li.ico3 button {background-position:-296px -400px;}
.heySomething .commentevet .form .choice li.ico3 button.on {background-position:-296px -565px;}
.heySomething .commentevet .form .choice li.ico4 button {background-position:-444px -400px;}
.heySomething .commentevet .form .choice li.ico4 button.on {background-position:-444px -565px;}
.heySomething .commentevet .form .choice li.ico5 button {background-position:-592px -400px;}
.heySomething .commentevet .form .choice li.ico5 button.on {background-position:-592px -565px;}
.heySomething .commentevet .form .choice li.ico6 button {background-position:-740px -400px;}
.heySomething .commentevet .form .choice li.ico6 button.on {background-position:-740px -565px;}

.heySomething .commentlist table td strong {width:130px; height:95px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/70431/bg_ico_v1.png); background-position:0 -419px;}
.heySomething .commentlist table td strong.ico2 {background-position:-148px -419px;}
.heySomething .commentlist table td strong.ico3 {background-position:-296px -419px;}
.heySomething .commentlist table td strong.ico4 {background-position:-444px -419px;}
.heySomething .commentlist table td strong.ico5 {background-position:-592px -419px;}
.heySomething .commentlist table td strong.ico6 {background-position:-740px -419px;}
.heySomething .commentlist table td.lt {padding-right:0;}
.heySomething .commentlist table td .cmtBox {height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/70431/txt_cmtt_box_btm.png) 100% 100% no-repeat;}
.heySomething .commentlist table td .cmtBox div {padding:20px 30px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/70431/txt_cmtt_box_top.png) 100% 0 no-repeat;}
</style>
<script type="text/javascript">
$(function(){
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
	$('.pagination span:nth-child(6)').append('<em class="desc6"></em>');

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

	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 900 ) {
			$(".heySomething .item h3 .logo img").addClass("flip");
		}
		if (scrollTop > 3300 ) {
			brandAnimation()
		}
		if (scrollTop > 3900 ) {
			brandAnimation2()
		}
	});

	/* title animation */
	titleAnimation()
	$(".heySomething .topic h2 span").css({"opacity":"0"});
	$(".heySomething .topic h2 .letter1").css({"margin-top":"7px"});
	$(".heySomething .topic h2 .letter2").css({"margin-top":"15px"});
	$(".heySomething .topic h2 .letter3").css({"margin-top":"23px"});
	function titleAnimation() {
		$(".heySomething .topic h2 .letter1").delay(100).animate({"margin-top":"0", "opacity":"1"},700);
		$(".heySomething .topic h2 .letter2").delay(400).animate({"margin-top":"7px", "opacity":"1"},700);
		$(".heySomething .topic h2 .letter3").delay(800).animate({"margin-top":"17px", "opacity":"1"},700);
	}

	/* brand animation */
	$(".heySomething .brand1 .info").css({"height":"150px", "opacity":"0"});
	function brandAnimation() {
		$(".heySomething .brand1 .info").delay(400).animate({"height":"547px", "opacity":"1"},1800);
	}
	$(".heySomething .brand2 .info").css({"height":"150px", "opacity":"0"});
	function brandAnimation2() {
		$(".heySomething .brand2 .info").delay(400).animate({"height":"529px", "opacity":"1"},1800);
	}
});

<% if Request("iCC") <> "" or request("ecc") <> "" then %>
	$(function(){
		var val = $('#commentlist').offset();
	    $('html,body').animate({scrollTop:val.top},0);
	});
<% end if %>

function jsGoComPage(iP){
	document.frmcom.iCC.value = iP;
	document.frmcom.iCTot.value = "<%=iCTotCnt%>";
	document.frmcom.submit();
}

function jsSubmitComment(frm){
	<% If IsUserLoginOK() Then %>
		<% if commentcount>0 then %>
			alert("이벤트는 한번만 참여 가능 합니다.");
			return false;
		<% else %>
			if (frm.gubunval.value == ''){
				alert('원하는 항목을 선택해 주세요.');
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
		<%'' title, nav %>
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
			<div class="bnr"><a href="/shopping/category_prd.asp?itemid=1480689&amp;pEtr=70431">socks appeal x kakao friends</a></div>
		</div>

		<%'' about %>
		<div class="about">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
			<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
		</div>

		<%'' item %>
		<div class="item">
			<div class="inner">
				<h3>
					<span class="logo"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70431/img_logo_socks_kakao.png" alt="socks appeal x kakao friends" /></span>
					<span class="horizontalLine1"></span>
					<span class="horizontalLine2"></span>
				</h3>
				<%
				itemid = itemid1
				set oItem = new CatePrdCls
					oItem.GetItemData itemid
				%>
				<div class="desc desc1">
					<a href="/shopping/category_prd.asp?itemid=1480689&amp;pEtr=70431">
						<div class="option">
							<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70431/txt_name_01.png" alt="" /></p>
							
							<% if oItem.FResultCount > 0 then %>
								<% if oItem.Prd.isCouponItem then %>
									<%	'' for dev msg : 할인 %>
									<div class="price">
										<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/txt_only_10percent_coupon.png" alt="텐바이텐에서만 ONLY 10%" /></strong>
										<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
										<strong style="color:#3a940e;"><%= FormatNumber(oItem.Prd.GetCouponAssignPrice,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
										<p class="tMar10"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70431/txt_gift_01.png" alt="" /></p>
									</div>
								<% else %>
									<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
										<%	'' for dev msg : 할인 %>
										<div class="price">
											<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/txt_only_10percent_coupon.png" alt="텐바이텐에서만 ONLY 10%" /></strong>
											<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
											<strong style="color:#3a940e;"><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
											<p class="tMar10"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70431/txt_gift_01.png" alt="" /></p>
										</div>
									<% else %>
										<%'' for dev msg : 종료 후  %>
										<div class="price priceEnd">
											<strong class="discount"><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
										</div>
									<% end if %>
								<% end if %>
							<% end if %>
							<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70431/txt_substance_01.png" alt="" /></p>
							<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러 가기" /></div>
						</div>
						<div class="thumbnail"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70431/img_item_01.jpg" alt="" /></div>
					</a>
				</div>
				<% set oItem=nothing %>
			</div>
			<%'' for dev msg : 가격 부분만 개발 해주세요  %>
			<div class="with">
				<ul>
					<li>
						<a href="/street/street_brand_sub06.asp?makerid=socksappeal">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70431/img_with_item_01.jpg" alt="" />
						</a>
					</li>
					<li>
						<a href="/street/street_brand_sub06.asp?makerid=socksappeal">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70431/img_with_item_02.jpg" alt="" />
						</a>
					</li>
					<li>
						<a href="/street/street_brand_sub06.asp?makerid=socksappeal">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70431/img_with_item_03.jpg" alt="" />
						</a>
					</li>
					<li>
						<a href="/street/street_brand_sub06.asp?makerid=socksappeal">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70431/img_with_item_04.jpg" alt="" />
						</a>
					</li>
					<li>
						<a href="/street/street_brand_sub06.asp?makerid=socksappeal">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70431/img_with_item_05.jpg" alt="" />
						</a>
					</li>
					<li>
						<a href="/street/street_brand_sub06.asp?makerid=socksappeal">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70431/img_with_item_06.jpg" alt="" />
						</a>
					</li>
				</ul>
			</div>

			<div class="inner">
				<%
				itemid = itemid2
				set oItem = new CatePrdCls
					oItem.GetItemData itemid
				%>
				<div class="desc desc2">
					<a href="/shopping/category_prd.asp?itemid=1480688&amp;pEtr=70431">
						<div class="option">
							<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70431/txt_name_02.png" alt="" /></p>
							<% if oItem.FResultCount > 0 then %>
								<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
									<%	'' for dev msg : 할인 %>
									<div class="price">
										<strong><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/common/txt_only_33percent.png" alt="텐바이텐에서만 ONLY 10%" /></strong>
										<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
										<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
									</div>
								<% else %>
									<%'' for dev msg : 종료 후  %>
									<div class="price priceEnd">
										<strong class="discount"><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
									</div>
								<% end if %>
							<% end if %>
							<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70431/txt_substance_02.png" alt="" /></p>
							<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러 가기" /></div>
						</div>
						<div class="thumbnail"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70431/img_item_02.jpg" alt="" /></div>
					</a>
				</div>
				<% set oItem=nothing %>
			</div>
			<%'' for dev msg : 가격 부분만 개발 해주세요  %>
			<div class="with">
				<ul>
					<li>
						<a href="/street/street_brand_sub06.asp?makerid=socksappeal">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70431/img_with_item_11.jpg" alt="" />
						</a>
					</li>
					<li>
						<a href="/street/street_brand_sub06.asp?makerid=socksappeal">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70431/img_with_item_12.jpg" alt="" />
						</a>
					</li>
					<li>
						<a href="/street/street_brand_sub06.asp?makerid=socksappeal">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70431/img_with_item_13.jpg" alt="" />
						</a>
					</li>
					<li>
						<a href="/street/street_brand_sub06.asp?makerid=socksappeal">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70431/img_with_item_14.jpg" alt="" />
						</a>
					</li>
					<li>
						<a href="/street/street_brand_sub06.asp?makerid=socksappeal">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70431/img_with_item_15.jpg" alt="" />
						</a>
					</li>
					<li>
						<a href="/street/street_brand_sub06.asp?makerid=socksappeal">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70431/img_with_item_16.jpg" alt="" />
						</a>
					</li>
				</ul>
			</div>
		</div>

		<%'' brand  %>
		<div class="brand">
			<div class="brand1">
				<p class="logo"><a href="/street/street_brand_sub06.asp?makerid=socksappeal"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70431/txt_brand1_logo.png" alt="SOCKS APPEAL" /></a></p>
				<p class="info"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70431/txt_brand1.png" alt="" /></p>
			</div>
			<div class="brand2">
				<p class="logo"><a href="/street/street_brand_sub06.asp?makerid=socksappeal"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70431/txt_brand2_logo.png" alt="KAKAO FRIENDS" /></a></p>
				<p class="info"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70431/txt_brand2.png" alt="" /></p>
			</div>
			<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="" /></div>
		</div>

		<%''  story  %>
		<div class="story">
			<p class="tit"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70431/tit_story.png" alt="신발 벗고 자랑하고 싶은 귀여움!" /></p>
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
									<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70431/img_slide_01.jpg" alt="" />
								</div>
								<div class="swiper-slide">
									<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70431/img_slide_02.jpg" alt="" />
								</div>
								<div class="swiper-slide">
									<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70431/img_slide_03.jpg" alt="" />
								</div>
								<div class="swiper-slide">
									<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70431/img_slide_04.jpg" alt="" />
								</div>
								<div class="swiper-slide">
									<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70431/img_slide_05.jpg" alt="" />
								</div>
								<div class="swiper-slide">
									<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70431/img_slide_06.jpg" alt="" />
								</div>
							</div>
						</div>
					</div>
					<div class="pagination"></div>
				</div>
			</div>
		</div>

		<%'' visual  %>
		<div class="visual">
			<div class="visual1"></div>
			<div class="visual2"></div>
		</div>

		<%''  comment %>
		<div class="commentevet">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70431/tit_comment.png" alt="Hey, something project 함께 하고 싶은 사람" /></h3>
			<p class="hidden">SOCKSAPPEAL X KAKAO 상품 중 가장 탐나는 상품은 무엇인가요? 코멘트를 남겨주신 3분을 추첨하여 카카오양말 2set를 선물로 드립니다.(랜덤발송) 코멘트 작성기간은 2016년 5월 4일부터 5월 10일까지며, 발표는 5월 16일 입니다.</p>
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
				<input type="hidden" name="txtcomm">
				<input type="hidden" name="gubunval">
				<% If InStr(Request.ServerVariables("QUERY_STRING"), "&ecc=1") > 0 Then %>
				<% Else %>
					<input type="hidden" name="hookcode" value="&ecc=1">
				<% End If %>
					<fieldset>
					<legend>SOCKSAPPEAL X KAKAO 코멘트 쓰기</legend>
						<ul class="choice">
							<li class="ico1"><button type="button" value="1">#MUJI&CON</button></li>
							<li class="ico2"><button type="button" value="2">#FRODO</button></li>
							<li class="ico3"><button type="button" value="3">#NEO</button></li>
							<li class="ico4"><button type="button" value="4">#JAY-G</button></li>
							<li class="ico5"><button type="button" value="5">#APEACH</button></li>
							<li class="ico6"><button type="button" value="6">#TUBE</button></li>
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
					<% If InStr(Request.ServerVariables("QUERY_STRING"), "&ecc=1") > 0 Then %>
					<% Else %>
						<input type="hidden" name="hookcode" value="&ecc=1">
					<% End If %>
				</form>
			</div>

			<%''  commentlist %>
			<div class="commentlist" id="commentlist">
				<p class="total">total <%= iCTotCnt %></p>
				<% IF isArray(arrCList) THEN %>
					<table>
						<caption>MY BEANS thank you 코멘트 목록 - 코멘트 작성시 선택 항목, 내용, 작성일자, 아이디 정보를 제공하는 표</caption>
						<colgroup>
							<col style="width:130px;" />
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
													MUJI&CON
												<% elseif split(arrCList(1,intCLoop),"!@#")(0)="2" then %>
													FRODO
												<% elseif split(arrCList(1,intCLoop),"!@#")(0)="3" then %>
													NEO
												<% elseif split(arrCList(1,intCLoop),"!@#")(0)="4" then %>
													JAY-G
												<% elseif split(arrCList(1,intCLoop),"!@#")(0)="5" then %>
													APEACH
												<% elseif split(arrCList(1,intCLoop),"!@#")(0)="6" then %>
													TUBE
												<% Else %>
													MUJI&CON
												<% end if %>
											</strong>
										<% end if %>
									</td>
									<td class="lt">
										<div class="cmtBox">
											<div>
												<% if isarray(split(arrCList(1,intCLoop),"!@#")) then %>
													<% if ubound(split(arrCList(1,intCLoop),"!@#")) > 0 then %>
														<%=ReplaceBracket(db2html( split(arrCList(1,intCLoop),"!@#")(1) ))%>
													<% end if %>
												<% end if %>	
											</div>
										</div>
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
	
					<%''  paging %>
					<div class="pageWrapV15">
						<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
					</div>
				<% End If %>
			</div>
		</div>
		<%''  // 수작업 영역 끝 %>
<% If Not(Trim(hspchk(1)))="hsproject" Then %>
	</div>
<% End If %>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->