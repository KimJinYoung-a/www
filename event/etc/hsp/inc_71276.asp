<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈 37
' History : 2016-06-21 유태욱 생성
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
	'currenttime = #10/07/2015 09:00:00#
 
dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  66156
Else
	eCode   =  71276
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

dim itemid 
Dim hspchk
'// 현재 주소값 체크하여 신규, 구버전 확인
hspchk = Split(LCase(Request.ServerVariables("PATH_INFO")),"/")
%>
<style type="text/css">
/* title */
.heySomething .topic {background-color:#f9f9f9;}
.heySomething .topic h2 {z-index:5;}
.heySomething .topic .figure a {display:block; position:relative; width:100%; height:780px;}
.heySomething .topic .figure img {position:absolute; top:0; left:50%; margin-left:-951px;}

/* brand */
.heySomething .brand {position:relative; height:1015px; margin-top:443px;}
.heySomething .brand .intro {position:relative; width:997px; margin:84px auto 0; text-align:left;}
.heySomething .brand .intro .logo {position:absolute; top:0; left:213px;}
.heySomething .brand .intro p {padding-left:415px;}

/* item */
.heySomething .itemB {margin-top:412px; padding-bottom:0; background:none;}
.heySomething .item h3 {position:relative; height:139px;}
.heySomething .item h3 .logo {position:absolute; top:0; left:50%; margin-left:-61px;}
.heySomething .item h3 .horizontalLine1, .heySomething .item h3 .horizontalLine2 {position:absolute; top:72px; width:450px; height:1px; background-color:#d9d9d9;}
.heySomething .item h3 .horizontalLine1 {left:0;}
.heySomething .item h3 .horizontalLine2 {right:0;}
.heySomething .item .desc {min-height:486px;}
.heySomething .item .slidewrap {padding-top:36px;}
.heySomething .itemB .slidewrap .slide {position:relative; width:655px; height:450px;}
.heySomething .itemB .slidewrap .slide .slidesjs-previous {left:0;}
.heySomething .item .with {margin-top:130px; border:none;}
.heySomething .item .with span {position:relative; z-index:5;}
.heySomething .item .with {border-bottom:1px solid #ddd; text-align:center;}
.heySomething .item .with ul {overflow:hidden; width:1060px; margin:0 auto; padding:0 0 45px 80px;}
.heySomething .item .with ul li {float:left; margin-right:38px;}
.heySomething .item .with ul li a {color:#777;}
.heySomething .item .with ul li span, .heySomething .with ul li strong {display:block; font-size:11px;}
.heySomething .item .with ul li span {margin-top:15px;}

/* story */
.heySomething .story {margin-top:400px;}
.heySomething .rolling {padding-top:152px;}
.heySomething .rolling .pagination {top:0; width:960px; margin-left:-480px;}
.heySomething .rolling .swiper-pagination-switch {width:128px; height:128px; margin:0 32px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/71276/btn_pagination.png);}
.heySomething .rolling .pagination span.swiper-active-switch {background-position:0 100%;}
.heySomething .rolling .pagination span:first-child + span {background-position:-192px 0;}
.heySomething .rolling .pagination span:first-child + span.swiper-active-switch {background-position:-192px 100%;}
.heySomething .rolling .pagination span:first-child + span + span {background-position:-384px 0;}
.heySomething .rolling .pagination span:first-child + span + span.swiper-active-switch {background-position:-384px 100%;}
.heySomething .rolling .pagination span:first-child + span + span + span {background-position:-578px 0;}
.heySomething .rolling .pagination span:first-child + span + span + span.swiper-active-switch {background-position:-578px 100%;}
.heySomething .rolling .pagination span:first-child + span + span + span + span {background-position:100% 0;}
.heySomething .rolling .pagination span:first-child + span + span + span + span.swiper-active-switch {background-position:100% 100%;}
.heySomething .rolling .pagination span em {bottom:-784px; left:50%;height:120px; width:980px; margin-left:-490px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/71276/txt_story_desc.png); cursor:default;}
.heySomething .rolling .pagination span .desc2 {background-position:0 -120px;}
.heySomething .rolling .pagination span .desc3 {background-position:0 -240px;}
.heySomething .rolling .pagination span .desc4 {background-position:0 -360px;}
.heySomething .rolling .pagination span .desc5 {background-position:0 100%;}
.heySomething .rolling .btn-nav {top:462px;}
.heySomething .swipemask {top:152px;}

/* finish */
.heySomething .finish {background-color:#eceae9; height:813px; margin-top:390px;}
.heySomething .finish .figure {position:absolute; top:0; left:50%; margin-left:-951px;}
.heySomething .finish p {top:228px; margin-left:-487px;}

/* comment */
.heySomething .commentevet .form .choice li {width:99px; height:120px; margin-right:32px;}
.heySomething .commentevet .form .choice li.ico1 {margin-right:15px;}
.heySomething .commentevet .form .choice li.ico2 {width:136px; margin-right:15px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/71276/img_ico.png); background-position:0 1px;}
.heySomething .commentevet .form .choice li button.on {background-position:0 -121px;}
.heySomething .commentevet .form .choice li.ico2 button {background-position:-114px 0;}
.heySomething .commentevet .form .choice li.ico2 button.on {background-position:-114px -121px;}
.heySomething .commentevet .form .choice li.ico3 button {background-position:-262px 0;}
.heySomething .commentevet .form .choice li.ico3 button.on {background-position:-262px -121px;}
.heySomething .commentevet .form .choice li.ico4 button {background-position:-392px 0;}
.heySomething .commentevet .form .choice li.ico4 button.on {background-position:-392px -121px;}
.heySomething .commentevet .form .choice li.ico5 button {background-position:-523px 0;}
.heySomething .commentevet .form .choice li.ico5 button.on {background-position:-523px -121px;}

.heySomething .commentevet textarea {margin-top:30px;}

.heySomething .commentlist table td strong {width:99px; height:120px; margin-left:18px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/71276/img_ico.png); background-position:0 0;}
.heySomething .commentlist table td strong.ico2 {width:136px; margin-left:0; background-position:-114px 0;}
.heySomething .commentlist table td strong.ico3 {background-position:-262px 0;}
.heySomething .commentlist table td strong.ico4 {background-position:-392px 0;}
.heySomething .commentlist table td strong.ico5 {background-position:-523px 0;}
</style>
<script type="text/javascript">
$(function(){
	/* slide js */
	$("#slide").slidesjs({
		width:"665",
		height:"450",
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
		if (scrollTop > 1500 ) {
			brandAnimation();
		}
		if (scrollTop > 5400 ) {
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
	$(".heySomething .brand .logo").css({"left":"250px", "opacity":"0"});
	$(".heySomething .brand p").css({"height":"50px", "opacity":"0"});
	$(".heySomething .brand .btnDown").css({"opacity":"0"});
	function brandAnimation() {
		$(".heySomething .brand .logo").delay(100).animate({"left":"213px", "opacity":"1"},500);
		$(".heySomething .brand p").delay(700).animate({"height":"252px", "opacity":"1"},600);
		$(".heySomething .brand .btnDown").delay(1200).animate({"opacity":"1"},1000);
	}

	/* finish animation */
	$(".heySomething .finish p").css({"margin-left":"-450px", "opacity":"0"});
	function finishAnimation() {
		$(".heySomething .finish p").delay(100).animate({"margin-left":"-470px", "opacity":"1"},700);
	}
});

$(function(){
	<% if pagereload<>"" then %>
		//pagedown();
		setTimeout("pagedown()",500);
	<% end if %>
});

function pagedown(){
	window.$('html,body').animate({scrollTop:$("#commentlist").offset().top}, 0);
}

function jsGoComPage(iP){
	document.frmcom.iCC.value = iP;
	document.frmcom.iCTot.value = "<%=iCTotCnt%>";
	document.frmcom.submit();
}

function jsSubmitComment(frm){
	<% If IsUserLoginOK() Then %>
		<% If not( left(currenttime,10)>="2016-06-21" and left(currenttime,10)<"2016-06-30" ) Then %>
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
				<a href="/shopping/category_prd.asp?itemid=1504531&amp;pEtr=71276"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71276/img_item_represent.jpg" alt="dinosaur 4D+ 입체 카드" /></a>
			</div>
		</div>

		<%' about %>
		<div class="about">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
			<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
		</div>

		<%' brand %>
		<div class="brand">
			<div class="photo"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71276/img_brand.jpg" alt="" /></div>
			<div class="intro">
				<div class="logo"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71276/img_logo_deny.png" alt="DENY Design 로고" /></div>
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71276/txt_brand.png" alt="Where the magic happens 미국 콜로라도에 위치한 DENY DESIGN은 고정관념을 깨는 모던스타일의 인테리어 상품을 소개하고 있습니다. DENY DESIGN은 고객의 개인 아트워크나 그래픽을 구매하여 누구나 자신만의 일상용품을 디자인할 수 있는 기회를 제공합니다. 당신의 꿈이 현실이 되는 공간, DENY DESIGN과 함께 마술같은 변화를 경험하세요." /></p>
			</div>
			<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="" /></div>
		</div>

		<%' item %>
		<div class="item itemB">
			<div class="inner">
				<h3>
					<span class="logo"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71276/img_logo_deny.png" alt="DENY Design" /></span>
					<span class="horizontalLine1"></span>
					<span class="horizontalLine2"></span>
				</h3>
				<%
				itemid = 1504534
				set oItem = new CatePrdCls
					oItem.GetItemData itemid
				%>
				<div class="desc">
					<div class="option">
						<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71276/txt_name.png" alt="DENY Tapestries는 폴리에스테르 소재로 가로 127센치, 세로 152센치 입니다." /></p>
						<%'' for dev msg : 상품코드 1504534, 할인기간 6/22 ~ 6/28 할인기간이 지나면  <strong class="discount">...</strong> 숨겨주세요 %>
						<%'' 일주일동안만 할인이 진행하기 때문에 6/22 ~ 6/28일 기간이 지난 후에는 <strong class="discount">...</strong> 숨겨주세요 %>
						<% if oItem.FResultCount > 0 then %>
							<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
							<div class="price">
								<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/txt_only_<%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>percent.png" alt="단, 일주일만 <%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%" /></strong>
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

						<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71276/txt_substance.png" alt="작은 변화로 지루한 공간이 크게 달라질 수 있어요 DENY의 타피스트리 하나로 집안 분위기를 화사하게 Change up!" /></p>
						<div class="btnget"><a href="/street/street_brand_sub06.asp?makerid=DENY1010"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="Disney Vintage Cream Glass 구매하러 가기" /></a></div>
					</div>

					<%'' slide %>
					<div class="slidewrap">
						<div id="slide" class="slide">
							<div><a href="/shopping/category_prd.asp?itemid=1504528&amp;pEtr=71276"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71276/img_slide_item_01.jpg" alt="WILD MONTANA" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1504531&amp;pEtr=71276"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71276/img_slide_item_02.jpg" alt="CRYSTAL BLUE" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1504532&amp;pEtr=71276"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71276/img_slide_item_03.jpg" alt="BEACH TOWER" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1504533&amp;pEtr=71276"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71276/img_slide_item_04.jpg" alt="SOUTH PACIFIC ISLANDS" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1504534&amp;pEtr=71276"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71276/img_slide_item_05.jpg" alt="STARDUST COVERING NEW YORK" /></a></div>
						</div>
					</div>
				</div>
				<% set oItem=nothing %>

				<!-- for dev msg : 가격 부분만 개발 해주세요 -->
				<div class="with">
					<ul>
						<%
						itemid = 1504528
						set oItem = new CatePrdCls
							oItem.GetItemData itemid
						%>
						<li>
							<a href="/shopping/category_prd.asp?itemid=1504528&amp;pEtr=71276">
								<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71276/img_with_item_01.jpg" alt="" />
								<span>WILD MONTANA</span>
								<% if oItem.FResultCount > 0 then %>
									<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
										<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
									<% Else %>
										<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
									<% End If %>
								<% End If %>
							</a>
						</li>
						<% set oItem=nothing %>

						<%
						itemid = 1504531
						set oItem = new CatePrdCls
							oItem.GetItemData itemid
						%>
						<li>
							<a href="/shopping/category_prd.asp?itemid=1504531&amp;pEtr=71276">
								<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71276/img_with_item_02.jpg" alt="" />
								<span>CRYSTAL BLUE</span>
								<% if oItem.FResultCount > 0 then %>
									<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
										<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
									<% Else %>
										<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
									<% End If %>
								<% End If %>
							</a>
						</li>
						<% set oItem=nothing %>

						<%
						itemid = 1504532
						set oItem = new CatePrdCls
							oItem.GetItemData itemid
						%>
						<li>
							<a href="/shopping/category_prd.asp?itemid=1504532&amp;pEtr=71276">
								<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71276/img_with_item_03.jpg" alt="" />
								<span>BEACH TOWER 5</span>
								<% if oItem.FResultCount > 0 then %>
									<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
										<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
									<% Else %>
										<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
									<% End If %>
								<% End If %>
							</a>
						</li>
						<% set oItem=nothing %>

						<%
						itemid = 1504533
						set oItem = new CatePrdCls
							oItem.GetItemData itemid
						%>
						<li style="margin-right:28px;">
							<a href="/shopping/category_prd.asp?itemid=1504533&amp;pEtr=71276">
								<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71276/img_with_item_04.jpg" alt="" />
								<span>SOUTH PACIFIC ISLANDS</span>
								<% if oItem.FResultCount > 0 then %>
									<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
										<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
									<% Else %>
										<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
									<% End If %>
								<% End If %>
							</a>
						</li>
						<% set oItem=nothing %>

						<%
						itemid = 1504534
						set oItem = new CatePrdCls
							oItem.GetItemData itemid
						%>
						<li>
							<a href="/shopping/category_prd.asp?itemid=1504534&amp;pEtr=71276">
								<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71276/img_with_item_05.jpg" alt="" />
								<span>STARDUST COVERING NEW YORK</span>
								<% if oItem.FResultCount > 0 then %>
									<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
										<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
									<% Else %>
										<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
									<% End If %>
								<% End If %>
							</a>
						</li>
						<% set oItem=nothing %>
					</ul>
				</div>
			</div>
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
									<a href="/shopping/category_prd.asp?itemid=1504534&amp;pEtr=71276" title="stardust covering new york 상품 보러가기"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71276/img_slide_story_01.jpg" alt="#new york 방 한 켠, 찬란한 뉴욕의 밤! 당신이 꿈꾸는 모든 것이 현실이 되는 곳. 지금 당장 뉴욕의 밤거리를 걸어볼까요?" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1504533&amp;pEtr=71276" title="south pacific islands 상품 보러가기"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71276/img_slide_story_02.jpg" alt="#south pacific islands 평화롭고 여유로운 내 사랑 하와이, 망고주스 마시며 힐링 중 #바다 #하와이 #여행 #내방스타그램" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1504531&amp;pEtr=71276" title="crystal blue 상품 보러가기"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71276/img_slide_story_03.jpg" alt="#crystal blue 바다 위에서 즐기는 피크닉 살랑이는 바람이 더욱 시원하게 느껴지는 이유" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1504528&amp;pEtr=71276" title="wild montana 상품 보러가기"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71276/img_slide_story_04.jpg" alt="#wild montana 몬타나의 청량한 공기를 느껴보세요. 덮고 있는 것만으로도 힐링이 되는 기분, 나는 지금 몬타나에 있다!" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1504532&amp;pEtr=71276" title="beach tower 상품 보러가기"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71276/img_slide_story_05.jpg" alt="#beach tower 해변을 정찰하는 비치타워 안에서는 무엇이? 올 휴가 때 입을 내 옷들이 숨겨져 있는 건 비밀" /></a>
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
			<a href="/shopping/category_prd.asp?itemid=1504531&amp;pEtr=71276">
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71276/txt_finish.png" alt="Where the magic happens 디나이 디자인" /></p>
				<div class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71276/img_finish.jpg" alt="crystal blue" /></div>
			</a>
		</div>

		<%' comment %>
		<div class="commentevet">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71276/tit_comment.png" alt="Hey, something project 당신이 갖고 싶은 것" /></h3>
			<p class="hidden">가장 마음에 드는 디자인과 그 이유를 코멘트로 남겨주세요. 정성껏 코멘트를 남겨주신 5분을 추첨하여 DENY 타피스트리를 증정합니다. 코멘트 작성기간은 2016년 6월 21일부터 6월 28일까지며, 발표는 7월 1일 입니다.</p>

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
					<legend>DENY 타피스트리 코멘트 쓰기</legend>
						<ul class="choice">
							<li class="ico1"><button type="button" value="1">new york</button></li>
							<li class="ico2"><button type="button" value="2">south pacific island</button></li>
							<li class="ico3"><button type="button" value="3">crystal blue</button></li>
							<li class="ico4"><button type="button" value="4">wild montana</button></li>
							<li class="ico5"><button type="button" value="5">beach tower</button></li>
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
						<caption>DENY 타피스트리 코멘트 목록 - 코멘트 작성시 선택 항목, 내용, 작성일자, 아이디 정보를 제공하는 표</caption>
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
											new york
										<% elseif split(arrCList(1,intCLoop),"!@#")(0)="2" then %>
											south pacific island
										<% elseif split(arrCList(1,intCLoop),"!@#")(0)="3" then %>
											crystal blue
										<% elseif split(arrCList(1,intCLoop),"!@#")(0)="4" then %>
											wild montana
										<% elseif split(arrCList(1,intCLoop),"!@#")(0)="5" then %>
											beach tower
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