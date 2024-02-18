<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈
' History : 2017-05-30 원승현 생성
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
	eCode   =  66332
Else
	eCode   =  78174
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
.heySomething {text-align:center;}

/* title */
.heySomething .topic {height:778px; background:#eac7a2 url(http://webimage.10x10.co.kr/eventIMG/2017/hey/78174/img_item_represent_v2.jpg) 50% 0 no-repeat;}

/* brand */
.heySomething .brand {height:860px; margin-top:400px;}
.heySomething .brand p {margin-top:65px;}

/* item */
.heySomething .itemB {width:1140px; margin:390px auto 0; padding-bottom:0; background:none;}
.heySomething .item h3 {position:relative;}
.heySomething .item .desc {min-height:420px; margin-top:145px; padding-left:434px;}
.heySomething .itemB .desc .option {top:15px; left:85px; height:370px;}
.heySomething .item .option .price {margin-top:35px;}
.heySomething .item .option .substance {position:static; margin-top:140px;}
.heySomething .item .with {margin-top:120px; padding-bottom:0; border:none; text-align:center;}
.heySomething .item .with span {position:relative; z-index:5;}
.heySomething .item .with ul {overflow:hidden; width:1024px; margin:40px auto 400px;}
.heySomething .item .with ul li {float:left; width:210px; margin:0 23px;}
.heySomething .item .with ul li a {display:block; color:#777; font-size:11px;}
.heySomething .item .with ul li a p {margin-top:15px;}
.heySomething .item .with ul li a .price {line-height:17px;}
.heySomething .item .with ul li a .price span {letter-spacing:0.5px; font-weight:bold;}
.heySomething .item .with ul li a .price .discount span{padding-left:4px; color:#d50c0c;}

/* fabric */
.fabric {position:relative; height:415px; background:#e6cdb8 url(http://webimage.10x10.co.kr/eventIMG/2017/hey/78174/bg_fabric.jpg) no-repeat 50% 0;}
.fabric p {position:absolute; top:132px; left:50%; margin-left:-493px;}

/* gallery */
.gallery {margin-top:330px;}
.gallery ul {position:relative; height:920px; width:1020px; margin:0 auto;}
.gallery ul li{position:absolute; top:0;}
.gallery ul li:first-child {left:55px;}
.gallery ul li:first-child + li {top:120px; right:46px;}
.gallery ul li:first-child + li + li{top:665px;left:0;}
.gallery ul li:first-child + li + li + li{top:498px; right:0;}

/* story */
.heySomething .story {margin-top:400px; padding-bottom:120px;}
.heySomething .story h3 {margin-bottom:60px;}
.heySomething .rolling {padding-top:202px;}
.heySomething .rolling .pagination {top:0; width:820px; margin-left:-410px;}
.heySomething .rolling .swiper-pagination-switch {width:143px; height:143px; margin:0 31px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/78174/btn_pagination_story.png) 0 0;}
.heySomething .rolling .pagination span.swiper-active-switch {background-position:0 0;}
.heySomething .rolling .pagination span:first-child {background-position: 0 100%;}
.heySomething .rolling .pagination span:first-child.swiper-active-switch {background-position:0 0;} 
.heySomething .rolling .pagination span:first-child + span {background-position:-205px 100%;}
.heySomething .rolling .pagination span:first-child + span.swiper-active-switch {background-position:-205px 0;}
.heySomething .rolling .pagination span:first-child + span + span {background-position:-408px 100%;}
.heySomething .rolling .pagination span:first-child + span + span.swiper-active-switch {background-position:-408px 0;}
.heySomething .rolling .pagination span:first-child + span + span + span {background-position:100% 100%;}
.heySomething .rolling .pagination span:first-child + span + span + span.swiper-active-switch {background-position:100% 0;}
.heySomething .rolling .pagination span em {bottom:-782px; left:50%;height:92px; width:980px; margin-left:-490px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/78174/txt_story_desc.png); cursor:default;}
.heySomething .rolling .pagination span .desc2 {background-position:0 -92px;}
.heySomething .rolling .pagination span .desc3 {background-position:0 -184px;}
.heySomething .rolling .pagination span .desc4 {background-position:0 100%;}
.heySomething .rolling .btn-nav {top:476px;}
.heySomething .swipemask {top:202px;}
.heySomething .mask-left {margin-left:-1472px;}
.heySomething .mask-right {margin-left:492px;}

/* finish */
.heySomething .finish {height:471px; margin-top:360px; background:#b99b7f url(http://webimage.10x10.co.kr/eventIMG/2017/hey/78174/bg_finish_v2.jpg) 50% 0 no-repeat; text-align:center;}
.heySomething .finish p {position:absolute; top:195px; left:50%; margin-left:-280px;}

/* comment */
.heySomething .commentevet {margin-top:400px;}
.heySomething .commentevet .form {margin-top:55px;}
.heySomething .commentevet .form .choice li {width:130px; height:128px; margin-right:58px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/78174/img_comment_ico.png); background-position:0 0;}
.heySomething .commentevet .form .choice li.ico1 button.on {background-position:0 100%;}
.heySomething .commentevet .form .choice li.ico2 button {background-position:-185px 0;}
.heySomething .commentevet .form .choice li.ico2 button.on {background-position:-185px 100%;}
.heySomething .commentevet .form .choice li.ico3 button {background-position:-369px 0;}
.heySomething .commentevet .form .choice li.ico3 button.on {background-position:-369px 100%;}
.heySomething .commentevet .form .choice li.ico4 button {background-position:100% 0;}
.heySomething .commentevet .form .choice li.ico4 button.on {background-position:100% 100%;}
.heySomething .commentevet textarea {margin-top:55px;}
.heySomething .commentlist table td {padding:20px 0;}
.heySomething .commentlist table td strong {width:104px; height:104px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/78174/img_comment_ico_2.png); background-position:0 0;}
.heySomething .commentlist table td strong.ico2 {background-position:-127px 0;}
.heySomething .commentlist table td strong.ico3 {background-position:-254px 0;}
.heySomething .commentlist table td strong.ico4 {background-position:100% 0;}

</style>
<script type="text/javascript">
$(function(){
	
	/* animation effect */
	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 4200 ) {
			galleryAnimation();
		}
		if(scrollTop > 500) {
			brandAnimation();
		}
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

	/* title animation */
	titleAnimation();
	$(".heySomething .topic h2 span").css({"width":"50px", "opacity":"0"});
	function titleAnimation() {
		$(".heySomething .topic h2 .letter1").delay(100).animate({"width":"125px", "opacity":"1"},1200);
		$(".heySomething .topic h2 .letter2").delay(300).animate({"width":"349px", "opacity":"1"},1200);
		$(".heySomething .topic h2 .letter3").delay(500).animate({"width":"206px", "opacity":"1"},1200);
	}

	/* brandAnimation */
	$(".heySomething .brand img").css({"opacity":"0"});
	function brandAnimation() {
		$(".heySomething .brand img").delay(100).animate({"opacity":"1"},700);
	}

	/* galleryAnimation */
	$(".heySomething .gallery ul li:nth-child(1)").css({"top":"-20px", "left":"-20px", "opacity":"0"});
	$(".heySomething .gallery ul li:nth-child(2)").css({"top":"-20px", "right":"-20px", "opacity":"0"});
	$(".heySomething .gallery ul li:nth-child(3)").css({"top":"685px", "left":"-20px", "opacity":"0"});
	$(".heySomething .gallery ul li:nth-child(4)").css({"top":"528px", "right":"-20px", "opacity":"0"});
	function galleryAnimation() {
		$(".heySomething .gallery ul li:nth-child(1)").delay(100).animate({"top":"0", "left":"55px", "opacity":"1"},700);
		$(".heySomething .gallery ul li:nth-child(2)").delay(100).animate({"top":"120px", "right":"46px", "opacity":"1"},700);
		$(".heySomething .gallery ul li:nth-child(3)").delay(100).animate({"top":"665px", "left":"0", "opacity":"1"},700);
		$(".heySomething .gallery ul li:nth-child(4)").delay(100).animate({"top":"498px", "right":"0", "opacity":"1"},700);
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
		<% If not( left(currenttime,10)>="2017-05-30" and left(currenttime,10)<"2017-06-07" ) Then %>
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
		</div>

		<%' about %>
		<div class="about">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
			<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
		</div>

		<%' brand %>
		<div class="brand">
			<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78174/img_cool_enough_intro.jpg" alt="" />
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78174/txt_cool_enough_txt.png" alt="일상 속에서 사용 되어지는 평범한 물건들 안에서 새로운 디자인의 기능성을 발견하고자 합니다. 생활 속에서 자연스럽게 쓰여지는 평범한 물건들에는 사용자의 감성과 삶의 깊이를 담고 있다고 생각합니다. 쿨 이너프 스튜디오의 또 다른 멋스러움, 시크하고 세련된 컬러인 BLACK ITEM을 텐바이텐에서 만나보세요." /></p>
			<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="" /></div>
		</div>

		<%' item %>
		<div class="item itemB">
			<h3><span class="logo"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78174/txt_logo.png" alt="cool enough studio" /></span></h3>
			<div class="desc">
				<a href="/shopping/category_prd.asp?itemid=1714230&amp;pEtr=78174">
					<div class="option">
						<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78174/txt_prd_name.png" alt="THE BAND BLACK " /></p>
						<%'' for dev msg : 상품코드 1714230, 할인기간 05/31 ~ 06/06 할인기간이 지나면  <strong class="discount">...</strong> 숨겨주세요 %>
						<%
							IF application("Svr_Info") = "Dev" THEN
								itemid = 1239226
							Else
								itemid = 1714230
							End If
							set oItem = new CatePrdCls
								oItem.GetItemData itemid
						%>
						<% If oItem.FResultCount > 0 Then %>
							<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
								<div class="price">
									<% If not( left(currenttime,10)>="2017-05-31" and left(currenttime,10)<"2017-06-07" ) Then %>
										<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
									<% else %>
										<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
										<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> <span>(20%)</strong>
									<% end if %>
								</div>
							<% else %>
								<div class="price priceEnd">
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								</div>
							<% End If %>
						<% End If %>
						<%	set oItem = nothing %>
						<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78174/txt_prd_details.png" alt="크고 부드러운 와이어로 머리조임 없이  편안한 밴드입니다. 나를 가꾸는 시간에도 아름다워지세요." /></p>
						<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러 가기" /></div>
					</div>
				</a>
				<div class="prdImg">
					<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78174/img_prd.jpg" alt="" />
				</div>
			</div>
			<div class="with">
				<span><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/ico_plus.png" alt="" /></span>
				<ul>
					<li>
						<a href="/shopping/category_prd.asp?itemid=1714228&amp;pEtr=78174">
							<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78174/img_prd_1.jpg" alt="" />
							<p>THE TOWEL SLIPPERS</p>
							<div class="price">
								<% If not( left(currenttime,10)>="2017-05-31" and left(currenttime,10)<"2017-06-07" ) Then %>
									<span class="normal">20,000won</span>
								<% else %>
									<s>20,000</s>
									<span  class="discount">16,000won<span>[20%]</span></span>
								<% end if %>
							</div>
						</a>
					</li>
					<li>
						<a href="/shopping/category_prd.asp?itemid=1714231&amp;pEtr=78174">
							<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78174/img_prd_2.jpg" alt="" />
							<p>THE PILLOW COVER</p>
							<div class="price">
								<% If not( left(currenttime,10)>="2017-05-31" and left(currenttime,10)<"2017-06-07" ) Then %>
									<span class="normal">30,000won</span>
								<% else %>
									<s>30,000</s>
									<span class="discount">22,500won<span>[20%]</span></span>
								<% end if %>
							</div>
						</a>
					</li>
					<li>
						<a href="/shopping/category_prd.asp?itemid=1714232&pEtr=78174">
							<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78174/img_prd_3.jpg" alt="" />
							<p>THE SLEEPING MASK</p>
							<div class="price">
								<% If not( left(currenttime,10)>="2017-05-31" and left(currenttime,10)<"2017-06-07" ) Then %>
									<span class="normal">18,000won</span>
								<% else %>
									<s>18,000</s>
									<span class="discount">14,400won<span>[20%]</span></span>
								<% end if %>
							</div>
						</a>
					</li>
					<li>
						<a href="/shopping/category_prd.asp?itemid=1714229&pEtr=78174">
							<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78174/img_prd_4.jpg" alt="" />
							<p>THE TOWEL</p>
							<div class="price">
								<% If not( left(currenttime,10)>="2017-05-31" and left(currenttime,10)<"2017-06-07" ) Then %>
									<span class="normal">12,000won</span>
								<% else %>
									<s>12,000</s>
									<span class="discount">9,600won<span>[20%]</span></span>
								<% end if %>
							</div>
						</a>
					</li>
				</ul>
			</div>
		</div>

		<%' fabric %>
		<div class="fabric">
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78174/txt_fabric.png" alt="Ultrafine microfiber 제품에 사용되는 극세사 원단 중에서도 최고급 원단을 사용했습니다. 극세사 패브릭은 세상에서 가장 가는 소재로 피부에 자극이 없으며, 탈수력과 건조력이 기존 타월소재보다 좋아 청결을 유지하기 용이합니다. 부드러운 소재를 사용하여 자극이 없고 순한 촉감이 편안한 사용감을 드립니다. " /></p>
		</div>

		<%' gallery %>
		<div class="gallery">
			<ul>
				<li><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78174/img_gallery_1.jpg" alt="" /></li>
				<li><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78174/img_gallery_2.jpg" alt="" /></li>
				<li><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78174/img_gallery_3.jpg" alt="" /></li>
				<li><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78174/img_gallery_4.jpg" alt="" /></li>
			</ul>
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
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1714230&pEtr=78174" title=""><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78174/img_slide_1.jpg" alt="# ONLY FOR ME  씻는 시간만큼은 오롯이 나에게 집중하세요. 쉬는 시간이 예뻐지는 THE BAND " /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1714228&pEtr=78174" title=""><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78174/img_slide_2.jpg" alt="# WITH PEOPLE 적당한 굽과 가벼운 무게감으로 내 발보다 더 편안합니다.  소중한 사람과 함께 집 안에서 신는 THE TOWEL " /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1714231&pEtr=78174" title=""><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78174/img_slide_3.jpg" alt="# GOOD SLEEP 좋은 잠은 우리 삶의 질을 변화시킵니다. 깊은 잠을 도와줄 THE PILLOW COVER & THE SLEEPIN" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1714229&pEtr=78174" title=""><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78174/img_slide_4.jpg" alt="# NEW CLEANING 보송보송한 수건에 클렌징 케이스까지, 새로운 수납을 만나보세요. 부드러운 촉감으로 기분까지 좋게 만드는 THE TOWEL" /></a>
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
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78174/txt_finish_v2.png" alt="삶을 아름답게 COOL ENOUGH STUDIO" /></p>
		</div>

		<%' comment %>
		<div class="commentevet">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78174/tit_comment.png" alt="Hey, something project 나에게 주는 편안한 휴식" /></h3>
			<p class="hidden">나만의 여름휴가 계획을 알려주세요!  정성스런 댓글을 남겨주신 3분께 쿨이너프스튜디오 세트 상품을 선물로 드립니다 이벤트 기간은 2017년 5월 31일 부터 6월6일 입니다. 당첨자 발표는 6월7일 입니다.</p>
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
							<li class="ico1"><button type="button" value="1">#ONLY FOR ME</button></li>
							<li class="ico2"><button type="button" value="2">#WITH PEOPLE</button></li>
							<li class="ico3"><button type="button" value="3">#GOOD SLEEP</button></li>
							<li class="ico4"><button type="button" value="4">#NEW CLEANING</button></li>
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
												#ONLY FOR ME
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="2" then %>
												#WITH PEOPLE
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="3" then %>
												#GOOD SLEEP
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="4" then %>
												#NEW CLEANING
											<% else %>
												#ONLY FOR ME
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