<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈 67 LOVE DOG
' History : 2017-03-21 유태욱 생성
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
'	currenttime = #03/22/2017 09:00:00#

dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  66291
Else
	eCode   =  76797
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
.heySomething .topic {height:778px; background-color:#fbfcfd;}
.heySomething .topic h2 {z-index:5;}
.heySomething .topic .figure {position:relative; width:100%; height:778px;}
.heySomething .topic .figure img {position:absolute; top:0; left:50%; margin-left:-951px;}

/* brand */
.heySomething .brand {position:relative; height:1102px; margin-top:360px;}
.heySomething .brand p {margin-top:154px;}
.heySomething .brand .ani {position:absolute; top:390px; left:50%; margin-left:160px;}
.heySomething .brand .btnDown {margin-top:220px;}

/* item */
.heySomething .item {margin-top:139px;}
.heySomething .item .desc {height:663px; margin-top:274px; background-color:#f8f8f8;}
.heySomething .item .desc1 {margin-top:0;}
.heySomething .item .desc3 {margin-top:296px;}
.heySomething .item .desc2,
.heySomething .item .desc3 {background:#f8f8f8 url(http://webimage.10x10.co.kr/eventIMG/2017/hey/76797/bg_item_02.jpg) 50% 0 no-repeat;}
.heySomething .item .desc3 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/76797/bg_item_03.jpg);}
.heySomething .item .desc > a {display:block; position:relative; width:1140px; margin:0 auto;}
.heySomething .item .desc .option {position:absolute; top:0; left:88px; z-index:10; height:100%;}
.heySomething .item .desc2 .option {left:777px;}
.heySomething .item .option .price {margin-top:61px;}
.heySomething .item .option .name {padding-top:112px;}
.heySomething .item .option .substance {position:absolute; bottom:99px; left:0;}
.heySomething .item .option .btnget {bottom:185px;}

.heySomething .item .inner {position:relative; width:1280px; margin:0 auto;}
.heySomething .item .hgroup {position:absolute; height:auto;}
.heySomething .item .hgroup .price {margin-top:27px;}
.heySomething .item .hgroup .price s {color:#777; font-size:16px;}
.heySomething .item .hgroup .price strong {font-family:'Arial'; font-size:18px;}
.heySomething .item .inner .figure {position:absolute;}
.heySomething .item ul {overflow:hidden;}
.heySomething .item ul li {overflow:hidden; float:left; margin:5px;}
.heySomething .item ul li:nth-child(2) img {animation-delay:0.2s;}
.heySomething .item ul li:nth-child(3) img {animation-delay:0.4s;}
.heySomething .item ul li:nth-child(4) img {animation-delay:0.3s;}
.heySomething .item ul li:nth-child(5) img {animation-delay:0.5s;}
.heySomething .pocketT {margin-top:0; padding-top:462px;}
.pocketT ul {height:905px;}
.pocketT ul li {background-color:#f2f2f2;}
.pocketT ul li.item3, .pocketT ul li.item4, .pocketT ul li.item5, .pocketT ul li.item6 {position:absolute; bottom:0; left:5px; margin:0;}
.pocketT ul li.item4 {left:602px;}
.pocketT ul li.item5 {left:909px;}
.pocketT ul li.item6 {left:283px;}
.pocketT .hgroup {top:390px; left:651px;}
.pocketT .figure {top:5px; right:5px;}
.heySomething .pocketT .hgroup .price {margin-top:31px;}
.heySomething .longSocks {margin-top:105px;}
.longSocks .hgroup {top:575px; left:370px;}
.longSocks ul li.item5 {float:right;}
.longSocks .figure {bottom:0; left:660px;}
.coverSocks .figure {bottom:0; left:5px;}
.heySomething .coverSocks {margin-top:-5px;}
.heySomething .coverSocks .inner {width:1270px;}
.heySomething .coverSocks ul li {margin:10px 0 0 0;}
.coverSocks ul li.item4 {margin-left:302px;}
.heySomething .coverSocks .hgroup {top:10px; right:2px; width:244px; height:215px; padding:98px 0 0 56px; background-color:#f8f8f8;}
.longSocks ul li a img, .coverSocks ul li a img  {transition:opacity 1s;}
.longSocks ul li a:hover img , .coverSocks ul li a:hover img {opacity:0.6;}

.heySomething .event {margin-top:263px; text-align:center;}

/* story */
.heySomething .story {margin-top:505px; padding-bottom:180px;}
.heySomething .story h3 {margin-bottom:53px;}
.heySomething .rolling {padding-top:227px;}
.heySomething .rolling .pagination {top:0; width:603px; margin-left:-301px;}
.heySomething .rolling .swiper-pagination-switch {width:137px; height:165px; margin:0 32px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/76797/btn_pagination_story_v1.jpg);}
.heySomething .rolling .pagination span.swiper-active-switch {background-position:0 100%;}
.heySomething .rolling .pagination span:first-child + span {background-position:-202px 0;}
.heySomething .rolling .pagination span:first-child + span.swiper-active-switch {background-position:-202px 100%;}
.heySomething .rolling .pagination span:first-child + span + span {background-position:100% 0;}
.heySomething .rolling .pagination span:first-child + span + span.swiper-active-switch {background-position:100% 100%;}
.heySomething .rolling .pagination span em {bottom:-812px; left:50%; width:980px; margin-left:-490px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/76797/txt_story_desc_v1.gif); cursor:default;}
.heySomething .rolling .btn-nav {top:538px;}
.heySomething .swipemask {top:227px; background-color:#000;}

/* finish */
.heySomething .finish {height:818px; padding-top:400px; margin-top:0; background-color:transparent;}
.heySomething .finish p {top:524px; left:50%; margin-left:-135px;}
.heySomething .finish .figure {position:absolute; top:400px; left:50%; margin-left:-951px;}

/* comment */
.heySomething .commentevet {margin-top:270px;}
.heySomething .commentevet .form {margin-top:40px;}
.heySomething .commentevet .form .choice li {width:130px; height:156px; margin-right:36px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/76797/img_comment_ico.gif); background-position:0 0;}
.heySomething .commentevet .form .choice li.ico1 button.on {background-position:0 100%;}
.heySomething .commentevet .form .choice li.ico2 button {background-position:-166px 0;}
.heySomething .commentevet .form .choice li.ico2 button.on {background-position:-166px 100%;}
.heySomething .commentevet .form .choice li.ico3 button {background-position:100% 0;}
.heySomething .commentevet .form .choice li.ico3 button.on {background-position:100% 100%;}
.heySomething .commentevet textarea {margin-top:40px;}
.heySomething .commentlist table td strong {width:96px; height:96px; margin-left:21px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/76797/img_comment_ico_samll.gif); background-position:0 0;}
.heySomething .commentlist table td strong.ico2 {background-position:-96px 0;}
.heySomething .commentlist table td strong.ico3 {background-position:100% 0;}

/* css3 animation */
.slideUp {animation:slideUp 4s cubic-bezier(0.19, 1, 0.22, 1) forwards;}
@keyframes slideUp {
	0% {margin-top:100px; opacity:0;}
	100% {margin-top:0; opacity:1;}
}
.pulse {animation:pulse 2s 1;}
@keyframes pulse {
	0% {transform:scale(1.2); opacity:0;}
	100% {transform:scale(1); opacity:1;}
}
</style>
<script type="text/javascript">
$(function(){
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

	/* title animation */
	titleAnimation();
	$(".heySomething .topic h2 span").css({"width":"50px", "opacity":"0"});
	function titleAnimation() {
		$(".heySomething .topic h2 .letter1").delay(100).animate({"width":"125px", "opacity":"1"},1200);
		$(".heySomething .topic h2 .letter2").delay(300).animate({"width":"349px", "opacity":"1"},1200);
		$(".heySomething .topic h2 .letter3").delay(500).animate({"width":"206px", "opacity":"1"},1200);
	}

	/* item animation for pocekt T */
	function itemAnimation() {
		var window_top = $(window).scrollTop();
		var div_top = $(".heySomething .pocketT").offset().top;
		if (window_top > div_top){
			$(".pocketT ul li img").addClass("pulse");
		} else {
			$(".pocketT ul li img").removeClass("pulse");
		}
	}

	/* finish animation */
	function finishAnimation() {
		var window_top = $(window).scrollTop();
		var div_top = $(".heySomething .finish").offset().top;
		if (window_top > div_top){
			$(".heySomething .finish p img").addClass("slideUp");
		} else {
			$(".heySomething .finish p img").removeClass("slideUp");
		}
	}

	$(function() {
		$(window).scroll(itemAnimation);
		itemAnimation();

		$(window).scroll(finishAnimation);
		finishAnimation();
	});
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
		<% If not( left(currenttime,10)>="2017-03-21" and left(currenttime,10)<"2017-03-30" ) Then %>
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
				<a href="/shopping/category_prd.asp?itemid=1667442&pEtr=76797"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76797/img_item_represent.jpg" alt="lovedog cardigan, bichon" /></a>
			</div>
		</div>

		<%' about %>
		<div class="about">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
			<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
		</div>

		<%' brand %>
		<div class="brand">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76797/tit_brand.gif" alt="삭스어필과 텐바이텐의 콜라보레이션" /></h3>
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76797/txt_brand.jpg" alt="Love Dog 삭스어필에서 가장 많은 사랑을 받아온 비숑(Bichon), 비글(Beagle), 닥스훈트 (Dauchshund)가 봄을 맞아 부드러운 소재의 가디건으로 출시되었습니다! 오직 텐바이텐에서만 만나보실 수 있는 사랑스러운 러브독 가디건으로 봄을 만끽해보세요!" /></p>
			<div class="ani"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76797/img_character_ani.gif" alt="" /></div>
			<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="" /></div>
		</div>

		<%' item %>
		<div class="item cardigan">
			<h3 class="hidden">Cardigan</h3>
			<div class="desc desc1">
				<%' 상품 이름, 가격, 구매하기 %>
				<a href="/shopping/category_prd.asp?itemid=1667455&pEtr=76797">
					<div class="option">
						<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76797/txt_name_01.png" alt="단독 Socksappeal and TenByTen Lovedog Cardigan Dachshund" /></p>
						<% 'for dev msg : 상품코드 1667455 할인기간 2017.03.22 ~ 03.28 할인기간이 지나면 <strong class="discount">...</strong> 숨겨주세요 %>
						<%
							IF application("Svr_Info") = "Dev" THEN
								itemid = 1239226
							Else
								itemid = 1667455
							End If
							set oItem = new CatePrdCls
								oItem.GetItemData itemid
						%>
						<% If oItem.FResultCount > 0 Then %>
							<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
								<%' for dev msg : 할인기간 %>
								<div class="price">
									<% If not( left(currenttime,10)>="2017-03-22" and left(currenttime,10)<"2017-03-30" ) Then %>
									<% else %>
										<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/txt_only_10percent.png" alt="텐바이텐에서만 10%" /></strong>
										<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
									<% end if %>
										<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								</div>
							<% else %>
								<%'' for dev msg : 할인기간 종료 후 %>
								<div class="price priceEnd">
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								</div>
							<% End If %>
						<% end if %>
						<%	set oItem = nothing %>
						<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76797/txt_substance.png" alt="소재 코튼 100%로 S사이즈는 어깨 35cm 가슴 47 cm 소매60cm 총길이 57cm며,  M은 어깨 36cm 가슴 48cm 소매 62cm 총길이 60cm 입니다." /></p>
						<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.png" alt="구매하러 가기" /></div>
					</div>
					<div class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76797/img_item_01.jpg" alt="" /></div>
				</a>
			</div>

			<div class="desc desc2">
				<a href="/shopping/category_prd.asp?itemid=1667444&pEtr=76797">
					<div class="option">
						<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76797/txt_name_02.png" alt="Lovedog Cardigan Beagle" /></p>
						<%'' for dev msg : 상품코드 1667444 할인기간 2017.03.22 ~ 03.28 할인기간이 지나면 <strong class="discount">...</strong> 숨겨주세요 %>
						<%
							IF application("Svr_Info") = "Dev" THEN
								itemid = 1239226
							Else
								itemid = 1667444
							End If
							set oItem = new CatePrdCls
								oItem.GetItemData itemid
						%>
						<% If oItem.FResultCount > 0 Then %>
							<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
								<!-- for dev msg : 할인기간 -->
								<div class="price">
									<% If not( left(currenttime,10)>="2017-03-22" and left(currenttime,10)<"2017-03-30" ) Then %>
									<% else %>
										<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/txt_only_10percent.png" alt="텐바이텐에서만 10%" /></strong>
										<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
									<% end if %>
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								</div>
							<% else %>
								<%'' for dev msg : 할인기간 종료 후 %>
								<div class="price priceEnd" >
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								</div>
							<% End If %>
						<% end if %>
						<%	set oItem = nothing %>
						<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76797/txt_substance.png" alt="" /></p>
						<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.png" alt="구매하러 가기" /></div>
					</div>
					<div class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76797/img_item_02.jpg" alt="" /></div>
				</a>
			</div>

			<div class="desc desc3">
				<!-- 상품 이름, 가격, 구매하기 -->
				<a href="/shopping/category_prd.asp?itemid=1667442&pEtr=76797">
					<div class="option">
						<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76797/txt_name_03.png" alt="Lovedog Cardigan Bichon" /></p>
						<%' for dev msg : 상품코드 1667442 할인기간 2017.03.22 ~ 03.28 할인기간이 지나면 <strong class="discount">...</strong> 숨겨주세요 %>
						<%
							IF application("Svr_Info") = "Dev" THEN
								itemid = 1239226
							Else
								itemid = 1667442
							End If
							set oItem = new CatePrdCls
								oItem.GetItemData itemid
						%>
						<% If oItem.FResultCount > 0 Then %>
							<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
								<div class="price">
									<% If not( left(currenttime,10)>="2017-03-22" and left(currenttime,10)<"2017-03-30" ) Then %>
									<% else %>
										<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/txt_only_10percent.png" alt="텐바이텐에서만 10%" /></strong>
										<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
									<% end if %>
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								</div>
							<% else %>
								<%' for dev msg : 할인기간 종료 후 %>
								<div class="price priceEnd">
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								</div>
							<% End If %>
						<% end if %>
						<%	set oItem = nothing %>
						<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76797/txt_substance.png" alt="" /></p>
						<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.png" alt="구매하러 가기" /></div>
					</div>
					<div class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76797/img_item_03.jpg" alt="" /></div>
				</a>
			</div>
		</div>

		<div class="item pocketT">
			<div class="inner">
				<div class="option hgroup">
					<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76797/tit_item_pocket_t.png" alt="5 colors Pocket T" /></h3>
					<%''  for dev msg : 가격부분 개발해주세요 상품코드 1669880 %>
						<%
							IF application("Svr_Info") = "Dev" THEN
								itemid = 1239226
							Else
								itemid = 1669880
							End If
							set oItem = new CatePrdCls
								oItem.GetItemData itemid
						%>
						<% If oItem.FResultCount > 0 Then %>
							<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
								<div class="price">
									<% If not( left(currenttime,10)>="2017-03-22" and left(currenttime,10)<"2017-03-30" ) Then %>
									<% else %>
										<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
										<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> [10%]</strong>
									<% end if %>
								</div>
							<% else %>
								<div class="price">
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								</div>
							<% End If %>
						<% end if %>
						<%	set oItem = nothing %>
				</div>
				<ul>
					<li class="item1"><a href="/shopping/category_prd.asp?itemid=1669880&pEtr=76797"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76797/img_item_pocket_t_01.jpg" alt="pug" /></a></li>
					<li class="item2"><a href="/shopping/category_prd.asp?itemid=1669883&pEtr=76797"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76797/img_item_pocket_t_02.jpg" alt="beagle" /></a></li>
					<li class="item3"><a href="/shopping/category_prd.asp?itemid=1669879&pEtr=76797"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76797/img_item_pocket_t_03_v1.jpg" alt="collie" /></a></li>
					<li class="item4"><a href="/shopping/category_prd.asp?itemid=1669882&pEtr=76797"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76797/img_item_pocket_t_04.jpg" alt="dachshund" /></a></li>
					<li class="item5"><a href="/shopping/category_prd.asp?itemid=1669889&pEtr=76797"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76797/img_item_pocket_t_05.jpg" alt="french bulldog" /></a></li>
					<li class="item6"><a href="/shopping/category_prd.asp?itemid=1669884&pEtr=76797"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76797/img_item_pocket_t_06.jpg" alt="bichon" /></a></li>
				</ul>
				<div class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76797/img_item_logo_01.png" alt="" /></div>
			</div>
		</div>

		<div class="event">
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76797/txt_event_v1.png" alt="Eevent LOVEDOG 출시 기념! 커버삭스&amp;롱삭스 4개 이상 구매시, 커버삭스 1종 증정 " /></p>
		</div>

		<div class="item longSocks">
			<div class="inner">
				<div class="option hgroup">
					<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76797/tit_item_long_socks.png" alt="5 colors Long Socks" /></h3>
					<%' ' for dev msg : 가격부분 개발해주세요 상품코드 1458245 %>
						<%
							IF application("Svr_Info") = "Dev" THEN
								itemid = 1239226
							Else
								itemid = 1458245
							End If
							set oItem = new CatePrdCls
								oItem.GetItemData itemid
						%>
						<% If oItem.FResultCount > 0 Then %>
							<div class="price">
								<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
							</div>
						<% end if %>
						<%	set oItem = nothing %>
				</div>
				<ul>
					<li class="item1"><a href="/shopping/category_prd.asp?itemid=1458245&pEtr=76797"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76797/img_item_lip_socks_01.jpg" alt="pug" /></a></li>
					<li class="item2"><a href="/shopping/category_prd.asp?itemid=1015706&pEtr=76797"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76797/img_item_lip_socks_02.jpg" alt="beagle" /></a></li>
					<li class="item3"><a href="/shopping/category_prd.asp?itemid=1584229&pEtr=76797"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76797/img_item_lip_socks_03.jpg" alt="bichon" /></a></li>
					<li class="item4"><a href="/shopping/category_prd.asp?itemid=1388794&pEtr=76797"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76797/img_item_lip_socks_04.jpg" alt="collie" /></a></li>
					<li class="item5"><a href="/shopping/category_prd.asp?itemid=949842&pEtr=76797"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76797/img_item_lip_socks_05.jpg" alt="dachshund" /></a></li>
				</ul>
				<div class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76797/img_item_logo_02.png" alt="" /></div>
			</div>
		</div>

		<div class="item coverSocks">
			<div class="inner">
				<div class="option hgroup">
					<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76797/tit_item_cover_socks.png" alt="6 colors Cover Socks" /></h3>
						<%
							IF application("Svr_Info") = "Dev" THEN
								itemid = 1239226
							Else
								itemid = 1669898
							End If
							set oItem = new CatePrdCls
								oItem.GetItemData itemid
						%>
						<% If oItem.FResultCount > 0 Then %>
							<div class="price">
								<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
							</div>
						<% end if %>
						<%	set oItem = nothing %>
				</div>
				<ul>
					<li class="item1"><a href="/shopping/category_prd.asp?itemid=1669898&pEtr=76797"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76797/img_item_cover_socks_01.jpg" alt="bichon" /></a></li>
					<li class="item2"><a href="/shopping/category_prd.asp?itemid=1669893&pEtr=76797"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76797/img_item_cover_socks_02.jpg" alt="dachshund" /></a></li>
					<li class="item3"><a href="/shopping/category_prd.asp?itemid=1669899&pEtr=76797"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76797/img_item_cover_socks_03.jpg" alt="beagle" /></a></li>
					<li class="item4"><a href="/shopping/category_prd.asp?itemid=1669890&pEtr=76797"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76797/img_item_cover_socks_04.jpg" alt="french bulldog" /></a></li>
					<li class="item5"><a href="/shopping/category_prd.asp?itemid=1669897&pEtr=76797"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76797/img_item_cover_socks_05.jpg" alt="collie" /></a></li>
					<li class="item6"><a href="/shopping/category_prd.asp?itemid=1669896&pEtr=76797"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76797/img_item_cover_socks_06.jpg" alt="pug" /></a></li>
				</ul>
				<div class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76797/img_item_logo_03.png" alt="" /></div>
			</div>
		</div>

		<%' story %>
		<div class="story">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76797/tit_story.gif" alt="LOVE DOG과 사랑스러운 봄을!" /></h3>
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
									<a href="/shopping/category_prd.asp?itemid=1667442&pEtr=76797" title="lovedog cardigan bichon 상품보러 가기"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76797/img_slide_story_01.jpg" alt="#Bichon 새하얀 털이 몽실몽실한 비숑! 사랑스러운 핑크 컬러에 부드러운 매력으로 보기만 해도 행복해집니다." /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1667444&pEtr=76797" title="lovedog cardigan beagle"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76797/img_slide_story_02.jpg" alt="#Beagle 말썽꾸러기라고 하기엔 너무나 귀여운 비글! 깊은 네이비 컬러에 장난스러운 표정으로 매일 함께 하고 싶어집니다." /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1667455&pEtr=76797" title="lovedog cardigan dachshund"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76797/img_slide_story_03.jpg" alt="#Dachshund 다리가 짧지만 그 모습이 매력만점인 닥스훈트! 차분하고 따뜻한 베이지 컬러에 위풍당당한 포즈로 자신감을 더해줍니다." /></a>
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
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76797/txt_finish.png" alt="언제나 당신 곁에 LOVE DOG" /></p>
			<div class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76797/img_finish.jpg" alt="" /></div>
		</div>

		<%' comment %>
		<div class="commentevet">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76797/tit_comment.gif" alt="Hey, something project 당신이 갖고 싶은 것" /></h3>
			<p class="hidden">이번 봄, 당신이 함께 하고 싶은 강아지는 어떤 강아지인가요? 정성껏 코멘트를 남겨주신 3분을 추첨하여 삭스어필X텐바이텐 가디건, 페이크삭스 1종을 선물로 드립니다. 컬러 디자인랜덤, 가디건 사이즈는 M으로 배송됩니다. 코멘트 작성기간은 2017년 3월 22일부터 3월 29일까지며, 발표는 3월 31일 입니다.</p>

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
							<li class="ico1"><button type="button" value="1">Bichon</button></li>
							<li class="ico2"><button type="button" value="2">Beagle</button></li>
							<li class="ico3"><button type="button" value="3">Dachshund</button></li>
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

			<% '' commentlist %>
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
												Bichon
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="2" then %>
												Beagle
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="3" then %>
												Dachshund
											<% else %>
												Bichon
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