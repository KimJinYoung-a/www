<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈
' History : 2017-06-05 원승현 생성
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
	eCode   =  66335
Else
	eCode   =  78236
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
.heySomething .topic {text-align:center; background-color:#f4f1ee; z-index:1;}

/* item */
.heySomething .item a {text-decoration:none;}
.heySomething .item .option {width:350px; margin-left:90px;}
.heySomething .item .option .price {margin-top:75px;}
.heySomething .itemA {width:100%; margin-top:0; background-color:#f7f7f7;}
.heySomething .itemA h3 {padding-bottom:68px; text-align:center; background:#fff;}
.heySomething .itemA .desc {position:relative; min-height:425px; margin:0 auto; padding:125px 0 105px;}
.heySomething .itemImage {position:absolute;}
.heySomething .item1 .itemImage {right:23px; top:135px;}
.heySomething .item2 {margin-top:25px;}
.heySomething .item2 .itemImage {left:0; top:175px;}
.heySomething .item2 .option {margin-left:655px;}

/* brand */
.heySomething .brand {position:relative; height:1005px; margin:280px 0 300px; text-align:center;}
.heySomething .brand p {padding-top:82px;}
.heySomething .brand .btnDown {margin-top:140px;}

/* story */
.heySomething .howto {padding:295px 0 420px;}
.heySomething .story {margin-top:395px; padding-bottom:120px;}
.heySomething .rolling {margin-top:45px; padding-top:195px;}
.heySomething .rolling .pagination {top:0; padding-left:132px;}
.heySomething .rolling .pagination span em {bottom:-805px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/78236/txt_desc.png); cursor:default;}
.heySomething .rolling .swiper-pagination-switch {width:142px; margin:0 47px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/78236/bg_ico_1.png);}
.heySomething .rolling .btn-nav {top:486px;}
.heySomething .swipemask {top:195px; background-color:#000;}

/* finish */
.heySomething .finish {height:645px; margin-top:375px; background:#a8e3e2 url(http://webimage.10x10.co.kr/eventIMG/2017/hey/78236/bg_finish.jpg) 50% 0 no-repeat;}
.heySomething .finish a {display:block; position:absolute; left:50%; top:0; width:1140px; height:100%; margin-left:-570px;}
.heySomething .finish p {position:absolute; left:72px; top:195px; margin-left:0;}

/* comment */
.heySomething .commentevet textarea {margin-top:25px;}
.heySomething .commentevet .form {margin-top:25px;}
.heySomething .commentevet .form .choice {margin-left:-10px;}
.heySomething .commentevet .form .choice li {margin-right:4px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/78236/bg_ico_2.png);}
.heySomething .commentlist table td {padding:15px 0;}
.heySomething .commentlist table td strong {height:150px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/78236/bg_ico_2.png); background-position:-10px 0;}
.heySomething .commentlist table td .ico2 {background-position:-160px 0;}
.heySomething .commentlist table td .ico3 {background-position:-310px 0;}

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
		<% If not( left(currenttime,10)>="2017-06-05" and left(currenttime,10)<"2017-07-01" ) Then %>
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
			<div class="bnr"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78236/img_item_represent.jpg" alt="WONDER GREEN" /></div>
		</div>

		<%' about %>
		<div class="about">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
			<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
		</div>

		<%' brand %>
		<div class="brand">
			<div class="pic"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78236/img_brand.jpg" alt="" /></div>
			<p class="text"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78236/txt_brand.png" alt="건강한 삶의 답은 일상생활 속 식생활에 담겨 있습니다. 매일 건강을 챙기기에는 바쁜 나날을 보내고 있는 당신을 위해 원더그린은 누구나 매일 건강을 챙길 수 있도록  간편하게, 재밌게, 더 건강하게 구성한 헬시 박스를 배달합니다. 과중한 업무, 운동 부족, 나쁜 식습관, 스트레스 등으로 찌든  내 몸을 정화하는 시간 원더그린을 만나보세요 " /></p>
			<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="" /></div>
		</div>

		<%' item %>
		<div class="item itemA item1">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78236/tit_wondergreen_10x10.png" alt="WONDER GREEN X 10x10" /></h3>
			<div class="desc">
				<a href="/shopping/category_prd.asp?itemid=1723851&amp;pEtr=78236">
					<div class="option">
						<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78236/txt_name_1.png" alt="2주 리프레시워터 썸머 스페셜" /></p>
						<%' for dev msg : 상품코드 1723851, 할인기간 06/07 ~ 06/13 할인기간이 지나면  <strong class="discount">...</strong> 숨겨주세요 %>
						<%
							IF application("Svr_Info") = "Dev" THEN
								itemid = 1239226
							Else
								itemid = 1723851
							End If
							set oItem = new CatePrdCls
								oItem.GetItemData itemid
						%>
						<% If oItem.FResultCount > 0 Then %>
							<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
								<div class="price">
									<% If not( left(currenttime,10)>="2017-06-07" and left(currenttime,10)<"2017-06-14" ) Then %>
										<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %>
									<% else %>
										<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
										<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> <span>(19%)</strong>
									<% end if %>
								</div>
							<% else %>
								<div class="price priceEnd">
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								</div>
							<% End If %>
						<% End If %>
						<%	set oItem = nothing %>
						<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78236/txt_substance_1.png" alt="당신의 생기 있고 건강한 여름을 위해 [텐바이텐x원더그린] 2주 리프레시워터 썸머 스페셜 을 만나보세요" /></p>
						<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78236/btn_get.gif" alt="구매하러가기" /></div>
					</div>
					<div class="itemImage"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78236/img_item_1.jpg" alt="" /></div>
				</a>
			</div>
		</div>
		<div class="item itemA item2">
			<div class="desc">
				<a href="/shopping/category_prd.asp?itemid=1723852&amp;pEtr=78236">
					<div class="option">
						<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78236/txt_name_2.png" alt="2주 리프레시워터 썸머 스페셜" /></p>
						<%' for dev msg : 상품코드 1723852, 할인기간 06/07 ~ 06/13 할인기간이 지나면  <strong class="discount">...</strong> 숨겨주세요 %>
						<%
							IF application("Svr_Info") = "Dev" THEN
								itemid = 1239226
							Else
								itemid = 1723852
							End If
							set oItem = new CatePrdCls
								oItem.GetItemData itemid
						%>
						<% If oItem.FResultCount > 0 Then %>
							<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
								<div class="price">
									<% If not( left(currenttime,10)>="2017-06-07" and left(currenttime,10)<"2017-06-14" ) Then %>
										<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %>
									<% else %>
										<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
										<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> <span>(15%)</strong>
									<% end if %>
								</div>
							<% else %>
								<div class="price priceEnd">
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								</div>
							<% End If %>
						<% End If %>
						<%	set oItem = nothing %>
						<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78236/txt_substance_2.png" alt="나를 위해 매일 꾸준하게 챙겨 먹는다면 지친 몸과 피부에 활력을 더할 수 있어요" /></p>
						<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78236/btn_get.gif" alt="구매하러가기" /></div>
					</div>
					<div class="itemImage"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78236/img_item_2.jpg" alt="" /></div>
				</a>
			</div>
		</div>

		<div class="howto ct"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78236/img_howto.png" alt="HOW TO USE" /></div>
		<div class="squareItem ct"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78236/img_item_3.jpg" alt="" /></div>

		<%' story %>
		<div class="story">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78236/tit_story.png" alt="퍽퍽한 내 일상에 촉촉함이 필요한 순간" /></h3>
			<div class="rollingwrap">
				<div class="rolling rolling1">
					<div class="swipemask mask-left"></div>
					<div class="swipemask mask-right"></div>
					<button type="button" class="btn-nav arrow-left">Previous</button>
					<button type="button" class="btn-nav arrow-right">Next</button>
					<div class="swiper">
						<div class="swiper-container swiper1">
							<div class="swiper-wrapper">
								<div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1723852&amp;pEtr=78236"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78236/img_slide_1.jpg" alt="#DAILY 아무리 자도 자도 하루 종일 피곤함을 느끼는 나에게 힘을 주소 싶을 때" /></a></div>
								<div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1723851&amp;pEtr=78236"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78236/img_slide_2.jpg" alt="#DIET 다이어트에 지친 나를 위해 칼로리 걱정 없이 수분 보충이 필요할 때" /></a></div>
								<div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1723851&amp;pEtr=78236"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78236/img_slide_3.jpg" alt="#CLEANSE 각종 미세먼지에 건조해진 기관지를 촉촉하고 꺠끗하게 적셔주고 싶을 때" /></a></div>
							</div>
						</div>
					</div>
					<div class="pagination"></div>
				</div>
			</div>
		</div>

		<%' finish %>
		<div class="finish">
			<a href="/street/street_brand_sub06.asp?makerid=wondergreen">
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78236/txt_finish.png" alt="내 몸에 하루 필요한 물 1.6L 원더그린과 함께 시작해보세요" /></p>
			</a>
		</div>

		<%' comment %>
		<div class="commentevet">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78236/tit_comment.png" alt="Hey, something project, 내 일상에 촉촉함이 필요한 순간!" /></h3>
			<p class="hidden">반복되는 일상 속, 리프레시 워터가 필요한 순간은 언제인가요? 정성껏 코멘트를 남겨주신 10분에게 원더그린 하루과일칩(2팩)을 선물로 드립니다</p>
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
							<li class="ico1"><button type="button" value="1">#DAILY</button></li>
							<li class="ico2"><button type="button" value="2">#DIET</button></li>
							<li class="ico3"><button type="button" value="3">#CLEANSE</button></li>
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
												#DAILY
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="2" then %>
												#DIET
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="3" then %>
												#CLEANSE
											<% else %>
												#DAILY
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