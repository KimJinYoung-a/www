<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈
' History : 2017-06-27 원승현 생성
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
	eCode   =  66372
Else
	eCode   =  78730
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
.heySomething .topic {text-align:center; background-color:#f4ddbb; z-index:1;}

/* brand */
.heySomething .brand {position:relative; height:951px; margin:370px 0 133px; text-align:center;}
.heySomething .brand p {padding-top:82px;}
.heySomething .brand .btnDown {margin-top:95px;}

/* item */
.heySomething .item h3 {text-align:center;}
.heySomething .item a {text-decoration:none;}
.heySomething .item .option {width:476px; height:388px;}
.heySomething .item .option .only {margin-bottom:20px;}
.heySomething .item .option .price {margin-top:30px;}
.heySomething .item .option .substance {bottom:67px;}
.heySomething .itemA {width:100%; margin-top:0;}
.heySomething .itemA .desc {position:relative; min-height:544px; margin:0 auto; margin-top:50px; padding-top:58px;}
.heySomething .itemA.item1 .desc {border-bottom:1px dashed #cccccc;}
.heySomething .itemA .itemImage {position:absolute;}
.heySomething .itemA .itemImage {right:0; top:0;}
.heySomething .itemA.item2 .desc {padding-top:90px;}
.heySomething .itemA.item2 .option {height:454px;}
.heySomething .itemA.item2 .option .substance {bottom:70px;}
.heySomething .item .option .price {margin-top:35px;}

/* visual */
.heySomething .visual {position:relative; margin-top:85px;}
.heySomething .visual .slider-horizontal {margin:0 auto;}
.heySomething #slider {height:202px;}
.heySomething #slider .slide-img {display:table; position:relative; width:auto; height:202px; margin:0 28px;}
.heySomething #slider .slide-img a {display:table-cell; vertical-align:bottom;}
.heySomething #slider .slide-img a:hover {text-decoration:none;}

/* brand2 */
.heySomething .brand2 {height:813px; margin-top:350px;}
.heySomething .brand2 .wideSlide {height:813px;}
.heySomething .brand2 .wideSlide .swiper-container,
.heySomething .brand2 .wideSlide .swiper-wrapper,
.heySomething .brand2 .wideSlide .slidesjs-container,
.heySomething .brand2 .wideSlide .slidesjs-control,
.heySomething .brand2 .wideSlide .swiper-slide,
.heySomething .brand2 .wideSlide .swiper-slide img {height:100% !important;}

/* story */
.heySomething .story {margin-top:260px; padding-bottom:120px;}
.heySomething .rolling {margin-top:50px; padding-top:200px;}
.heySomething .rolling .pagination {top:0; padding-left:5px;}
.heySomething .rolling .pagination .span {border:solid 1px red;}
.heySomething .rolling .swiper-pagination-switch {height:166px;}
.heySomething .rolling .pagination span.swiper-active-switch {background-position:0 -168px;}
.heySomething .rolling .pagination span:first-child + span {background-position:-221px 0;}
.heySomething .rolling .pagination span:first-child + span.swiper-active-switch {background-position:-221px -168px;}
.heySomething .rolling .pagination span:first-child + span + span {background-position:-442px 0;}
.heySomething .rolling .pagination span:first-child + span + span.swiper-active-switch {background-position:-442px -168px;}
.heySomething .rolling .pagination span:first-child + span + span + span{background-position:100% 0;}
.heySomething .rolling .pagination span:first-child + span + span + span.swiper-active-switch{background-position:100% -168px;}
.heySomething .rolling .pagination span em {height:135px; bottom:-805px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/78730/txt_desc.png); cursor:default;}
.heySomething .rolling .pagination span .desc2 {background-position:0 -135px;}
.heySomething .rolling .pagination span .desc3 {background-position:0 -270px;}
.heySomething .rolling .pagination span .desc4 {background-position:0 -405px;}
.heySomething .rolling .swiper-pagination-switch {width:142px; margin:0 47px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/78730/bg_ico_1.png);}
.heySomething .rolling .btn-nav {top:486px;}
.heySomething .swipemask {top:200px; background-color:#000;}

/* finish */
.heySomething .finish {position:relative; height:511px; margin-top:285px; background:#e2d3b6 url(http://webimage.10x10.co.kr/eventIMG/2017/hey/78730/img_finish.jpg) 50% 0 no-repeat;}
.heySomething .finish a {display:block; position:absolute; left:50%; top:0; width:1140px; height:100%; margin-left:-570px;}
.heySomething .finish p {position:absolute; left:50%; top:173px; margin-left:215px;}

/* comment */
.heySomething .commentevet {margin-top:300px; padding-top:50px;}
.heySomething .commentevet textarea {margin-top:25px;}
.heySomething .commentevet .form {margin-top:30px;}
.heySomething .commentevet .form .choice li {width:132px; height:154px; margin-right:35px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/78730/bg_ico_2_v2.png);}
.heySomething .commentevet .form .choice li.ico2 button {background-position:-167px 0;}
.heySomething .commentevet .form .choice li.ico2 button.on {background-position:-167px 100%;}
.heySomething .commentevet .form .choice li.ico3 button {background-position:-334px 0;}
.heySomething .commentevet .form .choice li.ico3 button.on {background-position:-334px 100%;}
.heySomething .commentevet .form .choice li.ico4 button {background-position:100% 0;}
.heySomething .commentevet .form .choice li.ico4 button.on {background-position:100% 100%;}
.heySomething .commentlist table td {padding:20px 0;}
.heySomething .commentlist table td strong {width:160px; height:154px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/78730/bg_ico.png); background-position:0 0;}
.heySomething .commentlist table td .ico2 {background-position:-166px 0;}
.heySomething .commentlist table td .ico3 {background-position:-333px 0;}
.heySomething .commentlist table td .ico4 {background-position:-501px 0;}
</style>
<script type="text/javascript">
$(function(){
	// 16개 상품 롤링
	$("#slider").FlowSlider({
		marginStart:0,
		marginEnd:0,
		startPosition:0.55
	});

	// wide slide
	$('.heySomething .wideSlide .swiper-wrapper').slidesjs({
		width:1920,
		height:813,
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

	// story
	var swiper1 = new Swiper('.swiper1',{
		centeredSlides:true,
		slidesPerView:"auto",
		loop: true,
		speed:1500,
		autoplay:3000,
		simulateTouch:false,
		pagination: '.rolling1 .pagination',
		paginationClickable: true
	});
	$('.rolling1 .arrow-left').on('click', function(e){
		e.preventDefault()
		swiper1.swipePrev()
	});
	$('.rolling1 .arrow-right').on('click', function(e){
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
		<% If not( left(currenttime,10)>="2017-06-27" and left(currenttime,10)<"2017-07-20" ) Then %>
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
			<div class="bnr"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78730/img_item_represent.jpg" alt="WONDER GREEN" /></div>
		</div>

		<%' about %>
		<div class="about">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
			<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
		</div>

		<%' brand %>
		<div class="brand">
			<div class="pic"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78730/img_brand.jpg" alt="" /></div>
			<p class="text"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78730/txt_brand.png" alt="“당신이 사랑하는,당신의 소중한 반려견과 늘 함께하세요.”조금 느리지만 따뜻한 손길로 추억을 만드는 소소한 쌀이공방 반려동물의 사진을 이용하여 모색, 표정까지 꼭 닮은 핸드메이드 니들펠트 키링을 텐바이텐에서 만나보세요. " /></p>
			<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="" /></div>
		</div>

		<%' item %>
		<div class="item itemA item1">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78730/tit_SSAL_STUDIO.png" alt="SSAL STUDIO" /></h3>
			<div class="desc">
				<a href="/shopping/category_prd.asp?itemid=1737147&amp;pEtr=78730">
					<div class="option">
						<p class="only"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78730/txt_only_10x10.png" alt="only 10x10" /></p>
						<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78730/txt_name_1.png" alt="[한정] 반려견 시그니처 키링" /></p>
						<div class="price">
							<%
								IF application("Svr_Info") = "Dev" THEN
									itemid = 1239226
								Else
									itemid = 1737147
								End If
								set oItem = new CatePrdCls
									oItem.GetItemData itemid
							%>
							<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
							<%	set oItem = nothing %>
						</div>
						<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78730/txt_substance_1.png" alt="반려동물 사진으로 제작하는 쌀이공방 모색, 표정까지 내 아이와 꼭 닮은 맞춤 제작 시그니처 키링을 만나보세요." /></p>
						<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러가기" /></div>
					</div>
					<div class="itemImage"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78730/img_item_1.jpg" alt="" /></div>
				</a>
			</div>
		</div>
		<div class="item itemA item2">
			<div class="desc">
				<a href="/shopping/category_prd.asp?itemid=1737148&amp;pEtr=78730">
					<div class="option">
						<p class="only"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78730/txt_only_10x10.png" alt="only 10x10" /></p>
						<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78730/txt_name_2.png" alt="시그니처 키링" /></p>
						<div class="price">
							<%
								IF application("Svr_Info") = "Dev" THEN
									itemid = 1239226
								Else
									itemid = 1737148
								End If
								set oItem = new CatePrdCls
									oItem.GetItemData itemid
							%>
							<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
							<%	set oItem = nothing %>
						</div>
						<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78730/txt_substance_2.png" alt="시그니처 키링 컬러 : Vintage Silver / Vintage Gold 이니셜 : 1글자 선택소가죽 태슬 컬러 옵션" /></p>
						<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러가기" /></div>
					</div>
					<div class="itemImage"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78730/img_item_2.jpg" alt="" /></div>
				</a>
			</div>
		</div>


		<%' 10개 horizontal rolling %>
		<div class="visual">
			<div id="slider" class="slider-horizontal">
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1737147&amp;pEtr=75498">
						<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78730/img_item_visual_01.jpg" alt="반려견 시그니처 키링" />
					</a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1737147&amp;pEtr=78730">
						<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78730/img_item_visual_02.jpg" alt="반려견 시그니처 키링" />
					</a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1737147&amp;pEtr=78730">
						<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78730/img_item_visual_03.jpg" alt="반려견 시그니처 키링" />
					</a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1737147&amp;pEtr=78730">
						<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78730/img_item_visual_04.jpg" alt="반려견 시그니처 키링" />
					</a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1737147&amp;pEtr=78730">
						<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78730/img_item_visual_05.jpg" alt="반려견 시그니처 키링" />
					</a>
				</div>
				<div class="slide-img"> 
					<a href="/shopping/category_prd.asp?itemid=1737147&amp;pEtr=78730">
						<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78730/img_item_visual_06.jpg" alt="반려견 시그니처 키링" />
					</a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1737147&amp;pEtr=78730">
						<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78730/img_item_visual_07.jpg" alt="반려견 시그니처 키링" />
					</a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1737147&amp;pEtr=78730">
						<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78730/img_item_visual_08.jpg" alt="반려견 시그니처 키링" />
					</a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1737147&amp;pEtr=78730">
						<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78730/img_item_visual_01.jpg" alt="반려견 시그니처 키링" />
					</a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1737147&amp;pEtr=78730">
						<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78730/img_item_visual_02.jpg" alt="반려견 시그니처 키링" />
					</a>
				</div>
			</div>
		</div>

		<%' brand %>
		<div class="brand brand2">
			<div class="slideTemplateV15 wideSlide">
				<div class="swiper-container">
					<div class="swiper-wrapper">
						<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78730/img_brand_slide_1.jpg" alt="SSAL STUDIO" /></div>
						<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78730/img_brand_slide_2.jpg" alt="SSAL STUDIO" /></div>
					</div>
				</div>
			</div>
		</div>

		<%' story %>
		<div class="story">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78730/tit_story.png" alt="소중한반려견과 늘 함께하고 싶어!" /></h3>
			<div class="rollingwrap">
				<div class="rolling rolling1">
					<div class="swipemask mask-left"></div>
					<div class="swipemask mask-right"></div>
					<button type="button" class="btn-nav arrow-left">Previous</button>
					<button type="button" class="btn-nav arrow-right">Next</button>
					<div class="swiper">
						<div class="swiper-container swiper1">
							<div class="swiper-wrapper">
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1737147&amp;pEtr=78730">
										<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78730/img_slide_1.jpg" alt="# 차량고리 항상 지니고 다니는 차 키 또는 열쇠고리로 이용해보세요.  늘 함께하는 기분일 거예요." />
									</a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1737147&amp;pEtr=78730">
										<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78730/img_slide_2.jpg" alt="# 가방고리 미니미가 요기있네! 반려동물을 꼭 닮은 키링과 함께 외출하세요." />
									</a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1737147&amp;pEtr=78730">
										<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78730/img_slide_3.jpg" alt="# 핸드폰고리 자꾸 뒤를 돌아보게 만드는 귀여움! 키링 하나로 세상에 단 하나뿐인 케이스가 되요. " />
									</a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1737147&amp;pEtr=78730">
										<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78730/img_slide_4.jpg" alt="# 하네스장식 평범한 하네스도 특별하게 변신! 외출시간이 더 즐거워지겠죠? " />
									</a>
								</div>
							</div>
						</div>
					</div>
					<div class="pagination"></div>
				</div>
			</div>
		</div>

		<%' comment %>
		<div class="commentevet">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78730/tit_comment.png" alt="Hey, something project, 시그니처 키링을 사용하고 싶은 곳은 어디인가요?" /></h3>
			<p class="hidden">나의 반려동물을 꼭 닮은 쌀이공방 키링을 사용하고 싶은 곳과 이유를 남겨주세요 정성껏 코멘트를 남겨주신 5분께 텐바이텐 상품권 1만원 권을 선물로 드립니다.</p>
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
							<li class="ico1"><button type="button" value="1"># 차량고리</button></li>
							<li class="ico2"><button type="button" value="2"># 가방고리</button></li>
							<li class="ico3"><button type="button" value="3"># 핸드폰고리</button></li>
							<li class="ico4"><button type="button" value="4"># 하네스장식</button></li>
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
												# 차량고리
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="2" then %>
												# 가방고리
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="3" then %>
												# 핸드폰고리
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="4" then %>
												# 하네스장식
											<% else %>
												# 차량고리
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