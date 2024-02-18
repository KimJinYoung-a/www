<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈 47
' History : 2016-09-06 원승현 생성
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
	eCode   =  66196
Else
	eCode   =  72882
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
.heySomething .topic {background-color:#f1f0f5;}
.heySomething .topic h2 {z-index:5;}
.heySomething .topic .figure {position:relative; width:100%; height:780px;}
.heySomething .topic .figure img {position:absolute; top:0; left:50%; margin-left:-950px;}

/* item */
.heySomething .itemB {padding-bottom:280px;}
.heySomething .item h3 {position:relative; height:57px; text-align:center;}
.heySomething .item h3 .horizontalLine1,
.heySomething .item h3 .horizontalLine2 {position:absolute; top:34px; width:282px; height:1px; background-color:#d9d9d9;}
.heySomething .item h3 .horizontalLine1 {left:0;}
.heySomething .item h3 .horizontalLine2 {right:0;}
.heySomething .itemB .desc {min-height:543px; padding:60px 0 120px 0;}
.heySomething .itemB .option {height:543px;}
.heySomething .itemB .slidewrap {width:1140px; height:540px;}
.heySomething .itemB .slidewrap .slide {width:1140px; height:540px;}
.slidesjs-container, .slidesjs-control {height:540px !important;}
.heySomething .itemB .slidewrap .slidesjs-slide {position:relative; text-align:right;}
.heySomething .itemB .slidewrap .slidesjs-slide img {padding-right:63px;}
.heySomething .itemB .slidewrap .slide .slidesjs-navigation {top:253px; margin-top:0;}
.heySomething .itemB .slidewrap .slide .slidesjs-previous {left:474px;}
.heySomething .itemB .slidewrap .slidesjs-slide .btnget {position:absolute; bottom:0; left:82px;}
.heySomething .itemB .slidewrap .slidesjs-slide .btnget img {padding-right:0;}
.heySomething .itemB .slidesjs-pagination {width:1164px; margin-left:-582px; bottom:-245px;}
.heySomething .itemB .slidesjs-pagination li {padding:0 12px;}
.heySomething .itemB .slidesjs-pagination li a {width:170px; height:192px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/72882/bg_pagination_item_01.png);}
.heySomething .itemB .slidesjs-pagination .num02 a {background-position:-194px 0;}
.heySomething .itemB .slidesjs-pagination .num02 a:hover, .heySomething .itemB .slidesjs-pagination .num02 .active {background-position:-194px 100%;}
.heySomething .itemB .slidesjs-pagination .num03 a {background-position:-388px 0;}
.heySomething .itemB .slidesjs-pagination .num03 a:hover, .heySomething .itemB .slidesjs-pagination .num03 .active {background-position:-388px 100%;}
.heySomething .itemB .slidesjs-pagination .num04 a {background-position:-582px 0;}
.heySomething .itemB .slidesjs-pagination .num04 a:hover, .heySomething .itemB .slidesjs-pagination .num04 .active {background-position:-582px 100%;}
.heySomething .itemB .slidesjs-pagination .num05 a {background-position:-776px 0;}
.heySomething .itemB .slidesjs-pagination .num05 a:hover, .heySomething .itemB .slidesjs-pagination .num05 .active {background-position:-776px 100%;}
.heySomething .itemB .slidesjs-pagination .num06 a {background-position:100% 0;}
.heySomething .itemB .slidesjs-pagination .num06 a:hover, .heySomething .itemB .slidesjs-pagination .num06 .active {background-position:100% 100%;}

.heySomething .item2 {margin-top:60px;}
.heySomething .item2 .slidesjs-pagination li a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/72882/bg_pagination_item_02.png);}

/* visual */
.heySomething .visual {padding-bottom:0; background-color:#898f90;}
.heySomething .visual .figure {position:relative; width:100%; height:813px;}
.heySomething .visual .figure img {position:absolute; top:0; left:50%; margin-left:-950px;}

/* brand */
.heySomething .brand {height:1855px;}
.heySomething .brand .image {overflow:hidden; width:840px; height:252px; margin:114px auto 0;}
.heySomething .brand p {margin-top:70px;}
.heySomething .brand2 {margin-top:193px;}
.heySomething .brand2 .image {margin-top:98px;}

/* story */
.heySomething .story {margin-top:420px; padding-bottom:120px;}
.heySomething .rolling {padding-top:163px;}
.heySomething .rolling .pagination {top:0; width:800px; margin-left:-400px;}
.heySomething .rolling .swiper-pagination-switch {width:140px; height:140px; margin:0 30px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/72882/btn_pagination_story.png);}
.heySomething .rolling .pagination span.swiper-active-switch {background-position:0 100%;}
.heySomething .rolling .pagination span:first-child + span {background-position:-200px 0;}
.heySomething .rolling .pagination span:first-child + span.swiper-active-switch {background-position:-200px 100%;}
.heySomething .rolling .pagination span:first-child + span + span {background-position:-399px 0;}
.heySomething .rolling .pagination span:first-child + span + span.swiper-active-switch {background-position:-399px 100%;}
.heySomething .rolling .pagination span:first-child + span + span + span {background-position:100% 0;}
.heySomething .rolling .pagination span:first-child + span + span + span.swiper-active-switch {background-position:100% 100%;}
.heySomething .rolling .pagination span em {bottom:-775px; left:50%;height:120px; width:980px; margin-left:-490px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/72882/txt_story_desc.png); cursor:default;}
.heySomething .rolling .pagination span .desc2 {background-position:0 -120px;}
.heySomething .rolling .pagination span .desc3 {background-position:0 -240px;}
.heySomething .rolling .pagination span .desc4 {background-position:0 -360px;}
.heySomething .rolling .btn-nav {top:475px;}
.heySomething .swipemask {top:163px;}
.heySomething .mask-left {margin-left:-1470px;}
.heySomething .mask-right {margin-left:490px;}

/* finish */
.heySomething .finish {background-color:#fa2b2e; height:813px; margin-top:400px;}
.heySomething .finish .figure {position:absolute; top:0; left:50%; margin-left:-950px;}

/* comment */
.heySomething .commentevet {margin-top:370px;}
.heySomething .commentevet .form {margin-top:15px;}
.heySomething .commentevet .form .choice li {width:133px; height:133px; margin-right:36px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/72882/img_ico.png); background-position:0 0;}
.heySomething .commentevet .form .choice li button.on {background-position:0 100%;}
.heySomething .commentevet .form .choice li.ico2 button {background-position:-147px 0;}
.heySomething .commentevet .form .choice li.ico2 button.on {background-position:-147px 100%;}
.heySomething .commentevet .form .choice li.ico3 button {background-position:-291px 0;}
.heySomething .commentevet .form .choice li.ico3 button.on {background-position:-291px 100%;}
.heySomething .commentevet .form .choice li.ico4 button {background-position:100% 0;}
.heySomething .commentevet .form .choice li.ico4 button.on {background-position:100% 100%;}

.heySomething .commentevet textarea {margin-top:30px;}

.heySomething .commentlist table td strong {width:133px; height:133px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/72882/img_ico.png); background-position:0 0;}
.heySomething .commentlist table td strong.ico2 {background-position:-147px 0;}
.heySomething .commentlist table td strong.ico3 {background-position:-291px 0;}
.heySomething .commentlist table td strong.ico4 {background-position:100% 0;}

/* css3 animation */
.flip {animation-name:flip; animation-duration:1.5s; animation-iteration-count:1; backface-visibility:visible;}
@keyframes flip {
	0% {transform:rotateX(120deg) rotateX(30px); opacity:0.5; animation-timing-function:ease-out;}
	100% {transform:rotateX(360deg) rotateX(0); opacity:1; animation-timing-function:ease-in;}
}

@keyframes pulse {
	0% {transform:scale(1.2);}
	100% {transform:scale(1);}
}
.pulse {animation-name:pulse; animation-duration:1.5s; animation-iteration-count:1;}
</style>
<script type="text/javascript" src="/lib/js/jquery.flowslider.js"></script>
<script type='text/javascript'>
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
		<% If not( left(currenttime,10) >= "2016-09-06" and left(currenttime,10) <= "2016-09-13" ) Then %>
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
				<a href="/shopping/category_prd.asp?itemid=1561881&amp;pEtr=72882"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72882/img_item_represent.jpg" alt="matches navy pattern socks" /></a>
			</div>
		</div>

		<%' about %>
		<div class="about">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
			<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
		</div>

		<%' item %>
		<div class="item itemB">
			<div class="inner">
				<%
					Dim itemid
					IF application("Svr_Info") = "Dev" THEN
						itemid = 1239230
					Else
						itemid = 1561880
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
				%>
				<h3>
					<span class="logo"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72882/img_logo_socks_appeal_sticky.png" alt="삭스어필과 스티키몬스터랩" /></span>
					<span class="horizontalLine1"></span>
					<span class="horizontalLine2"></span>
				</h3>
				<div class="desc">
					<%' 상품 이름, 가격, 구매하기 %>
					<div class="option">
						<em class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72882/txt_name_01.png" alt="19일 예약 발송 SOCKSAPPEAL과 SML 콜라보 Fruits / Pattern socks 텐바이텐 단독 선오픈 프리사이즈로 230~275 apple, cherry, orange, pineapple, heart ring, heart arrow" /></em>
						<%' for dev msg : 상품코드 1561880 할인기간 9/7~9/13 할인기간이 지나면  <strong class="discount">...</strong> 숨겨주세요 %>
						<% If oItem.FResultCount > 0 Then %>
							<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
								<div class="price">
								<% If not( left(currenttime,10)>="2016-09-07" and left(currenttime,10)<"2016-09-14" ) Then %>
								<% Else %>
									<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/txt_only_10percent.png" alt="텐바이텐에서만 ONLY 10%" /></strong>
									<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
								<% End If %>
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								</div>
							<% Else %>
								<%' for dev msg : 종료 후 %>
								<div class="price priceEnd">
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								</div>
							<% End If %>
						<% End If %>
						<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72882/txt_substance_01.png" alt="양말계의 최강자 Socks appeal과 요즘 대세 Sticky monster lab의 SEASON.02! 과일몬으로 변신한 두 번째 라인업을 텐바이텐에서 가장 먼저 만나보세요." /></p>
					</div>
				<% set oItem = nothing %>

					<%' slide %>
					<div class="slidewrap">
						<div id="slide01" class="slide">
							<div>
								<a href="/shopping/category_prd.asp?itemid=1561880&amp;pEtr=72882">
									<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72882/img_slide_item_01_01.jpg" alt="" />
									<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="apple Fruits socks 구매하러 가기" /></div>
								</a>
							</div>
							<div>
								<a href="/shopping/category_prd.asp?itemid=1561880&amp;pEtr=72882">
									<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72882/img_slide_item_01_02.jpg" alt="" />
									<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="cherry Fruits socks 구매하러 가기" /></div>
								</a>
							</div>
							<div>
								<a href="/shopping/category_prd.asp?itemid=1561880&amp;pEtr=72882">
									<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72882/img_slide_item_01_03.jpg" alt="" />
									<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="orange Fruits socks 구매하러 가기" /></div>
								</a>
							</div>
							<div>
								<a href="/shopping/category_prd.asp?itemid=1561880&amp;pEtr=72882">
									<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72882/img_slide_item_01_04.jpg" alt="" />
									<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="pineapple Fruits socks 구매하러 가기" /></div>
								</a>
							</div>
							<div>
								<a href="/shopping/category_prd.asp?itemid=1561880&amp;pEtr=72882">
									<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72882/img_slide_item_01_05.jpg" alt="" />
									<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="burgundy stripe Pattern socks 구매하러 가기" /></div>
								</a>
							</div>
							<div>
								<a href="/shopping/category_prd.asp?itemid=1561880&amp;pEtr=72882">
									<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72882/img_slide_item_01_06.jpg" alt="" />
									<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="navy stripe Pattern socks 구매하러 가기" /></div>
								</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="item itemB item2">
			<div class="inner">
				<%
					Dim itemid2
					IF application("Svr_Info") = "Dev" THEN
						itemid2 = 1239231
					Else
						itemid2 = 1561881
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid2
				%>
				<div class="desc">
					<%' 상품 이름, 가격, 구매하기 %>
					<div class="option">
						<em class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72882/txt_name_02.png" alt="19일 예약 발송 SOCKSAPPEAL과 SML 콜라보 Pattern socks 텐바이텐 단독 선오픈 프리사이즈로 230~275 cloud, rainbow,  french fries, hamburger, match navy , match yellow" /></em>
						<%' for dev msg : 상품코드 1561881, 할인기간 9/7~9/13 할인기간이 지나면  <strong class="discount">...</strong> 숨겨주세요 %>
						<% If oItem.FResultCount > 0 Then %>
							<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
								<div class="price">
								<% If not( left(currenttime,10)>="2016-09-07" and left(currenttime,10)<"2016-09-14" ) Then %>
								<% Else %>
									<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/txt_only_10percent.png" alt="텐바이텐에서만 ONLY 10%" /></strong>
									<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
								<% End If %>
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								</div>
							<% Else %>
								<%' for dev msg : 종료 후 %>
								<div class="price priceEnd">
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								</div>
							<% End If %>
						<% End If %>

						<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72882/txt_substance_02.png" alt="양말계의 최강자 Socks appeal과 요즘 대세 Sticky monster lab 의 만남! 몬스터들이 어떤모습으로 변신할까요 일상속의 소소함, 늘 내 곁에 있어줘!" /></p>
					</div>
				<% set oItem = nothing %>

					<%' slide %>
					<div class="slidewrap">
						<div id="slide02" class="slide">
							<div>
								<a href="/shopping/category_prd.asp?itemid=1561881&amp;pEtr=72882">
									<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72882/img_slide_item_02_01.jpg" alt="" />
									<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="rain Pattern socks 구매하러 가기" /></div>
								</a>
							</div>
							<div>
								<a href="/shopping/category_prd.asp?itemid=1561881&amp;pEtr=72882">
									<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72882/img_slide_item_02_02.jpg" alt="" />
									<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="rainbow Pattern socks 구매하러 가기" /></div>
								</a>
							</div>
							<div>
								<a href="/shopping/category_prd.asp?itemid=1561881&amp;pEtr=72882">
									<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72882/img_slide_item_02_03.jpg" alt="" />
									<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="french Pattern socks 구매하러 가기" /></div>
								</a>
							</div>
							<div>
								<a href="/shopping/category_prd.asp?itemid=1561881&amp;pEtr=72882">
									<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72882/img_slide_item_02_04.jpg" alt="" />
									<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="hamburger Pattern socks 구매하러 가기" /></div>
								</a>
							</div>
							<div>
								<a href="/shopping/category_prd.asp?itemid=1561881&amp;pEtr=72882">
									<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72882/img_slide_item_02_05.jpg" alt="" />
									<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="matches navy Pattern socks 구매하러 가기" /></div>
								</a>
							</div>
							<div>
								<a href="/shopping/category_prd.asp?itemid=1561881&amp;pEtr=72882">
									<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72882/img_slide_item_02_06.jpg" alt="" />
									<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="matches yellow Pattern socks 구매하러 가기" /></div>
								</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<%' visual %>
		<div class="visual">
			<div class="figure"><a href="/shopping/category_prd.asp?itemid=1561881&amp;pEtr=72882"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72882/img_item_visual_big.jpg" alt="rainbow pattern socks" /></a></div>
		</div>

		<%' brand %>
		<div id="brand" class="brand">
			<div class="about brand1">
				<a href="/street/street_brand_sub06.asp?makerid=socksappeal" title="삭스어필 브랜드 스트리트로 이동">
					<span class="logo"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72882/img_logo_socks_appeal.png" alt="Socks appeal" /></span>
					<div class="image"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72882/img_brand_01.jpg" alt="About socks appeal" /></div>
				</a>
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72882/txt_brand_01.png" alt="삭스어필은 일상의 모든 것들을 재미있는 시선으로 바라봅니다. 재미있는 일상이 삭스어필에게는 곧 모티브가 됩니다. 그래서 일상의 위트를 발견하고 좋은 레그웨어에 담아내는 것, 그리고 전달하는 것, 그래서 유쾌한 신사 숙녀들이 그들의 재치를 더욱 어필할 수 있도록 하는 것. 그것이 삭스어필이 하는 일입니다." /></p>
			</div>
			<div class="about brand2">
				<a href="/street/street_brand_sub06.asp?makerid=smlgroup" title="스티키몬스터랩 브랜드 스트리트로 이동">
					<span class="logo"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72882/img_logo_sticky_monster_lab.png" alt="Sticky monster lab" /></span>
					<div class="image"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72882/img_brand_02.jpg" alt="About Sticky Monster Lab" /></div>
				</a>
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72882/txt_brand_02.png" alt="그들은 다양한 창작자들로 구성되어 2007년에 설립 된 창의적인 스튜디오 입니다. 우리의 현실을 반영하여 공감할 수 있을만한 괴물세계의 일상 애니메이션을 생산했습니다. 현재 그들은 일러스트레이션, 그래픽 디자인, 제품 디자인 등 다방면에서 활동하며 여러 분야에서 두각을 나타내고 있습니다." /></p>
			</div>
			<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="" /></div>
		</div>

		<%' story %>
		<div class="story">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72882/tit_story.png" alt="매일매일 다른 소소한 행복" /></h3>
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
									<a href="/shopping/category_prd.asp?itemid=1561880&amp;pEtr=72882" title="apple fruit socks 보러가기"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72882/img_slide_story_01.jpg" alt="#Fruits 음~! 과일과 함께할 땐 언제나 기분이 좋아져 내 얼굴같이 예쁜 사과, 앙증맞은 체리, 상큼한 오렌지, 멋쟁이 파인애플 오늘은 어떤 과일로 기분이 좋아질까?" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1561881&amp;pEtr=72882" title="hamburger pattern socks 보러가기"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72882/img_slide_story_02.jpg" alt="#Yum-yum 냠냐암~ 햄버거를 먹을 때 나는 너무나도 행복해! 특히 난 먹음직스러운 브라운패티의 불고기버거를 좋아한다구~ 아참! 햄버거에 감자튀김이 빠질 순 없지" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1561881&amp;pEtr=72882" title="rain pattern socks 보러가기"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72882/img_slide_story_03.jpg" alt="#Weather 오늘은 웬지 모르게 기분이 꿀꿀한 날이야… 예쁜 양말로 기분을 풀어볼까? 혹시 모르잖아, 번개같던 마음에 햇빛이 들어올지" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1561881&amp;pEtr=72882" title="matches yellow pattern socks 보러가기"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72882/img_slide_story_04.jpg" alt="#Heart 점점 추워지는 날씨… 따뜻한 마음이 필요해! 혹시 성냥팔이 소녀 이야기 들어봤어? 작은 성냥이 소녀를 따뜻하게 해준 것처럼 포근해지는거 말야" /></a>
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
			<a href="/shopping/category_prd.asp?itemid=1561880&amp;pEtr=72882">
				<div class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72882/img_finish.jpg" alt="navy stripe Pattern socks" /></div>
			</a>
		</div>

		<%' comment %>
		<div class="commentevet">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72882/tit_comment.png" alt="Hey, something project 당신이 원하는 행복" /></h3>
			<p class="hidden">당신이 신었을 때 가장 행복할 것 같은 양말은 무엇인가요? 그 이유를 코멘트로 남겨주세요 정성껏 코멘트를 남겨주신 10분을 추첨하여 양말2개가 랜덤으로 담긴 미스테리박스를 증정합니다. 코멘트 작성기간은 2016년 9월 7일부터 9월 13일까지며, 발표는 9월 19일 입니다.</p>

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
					<legend>당신이 신었을 때 가장 행복할 것 같은 양말은 무엇인지 그 이유를 코멘트로 써주세요</legend>
						<ul class="choice">
							<li class="ico1"><button type="button" value="1">Fruits</button></li>
							<li class="ico2"><button type="button" value="2">Yum-yum</button></li>
							<li class="ico3"><button type="button" value="3">Weather</button></li>
							<li class="ico4"><button type="button" value="4">Heart</button></li>
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
							<% If isarray(split(arrCList(1,intCLoop),"!@#")) Then %>
								<strong class="ico<%= split(arrCList(1,intCLoop),"!@#")(0) %>">
									<% If split(arrCList(1,intCLoop),"!@#")(0)="1" Then %>
										#Fruits
									<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="2" Then %>
										#YUM-YUM
									<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="3" Then %>
										#WEATHER
									<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="4" Then %>
										#HEART
									<% End If %>
								</strong>
							<% End If %>
							</td>
							<td class="lt">
							<% If isarray(split(arrCList(1,intCLoop),"!@#")) Then %>
								<% If ubound(split(arrCList(1,intCLoop),"!@#")) > 0 Then %>
									<%=ReplaceBracket(db2html( split(arrCList(1,intCLoop),"!@#")(1) ))%>
								<% End If %>
							<% End If %>
							</td>
							<td><%= FormatDate(arrCList(4,intCLoop),"0000.00.00") %></td>
							<td>
								<em><%=printUserId(arrCList(2,intCLoop),2,"*")%></em>
							<% If ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") Then %>
								<button type="button" onclick="jsDelComment('<% = arrCList(0,intCLoop) %>'); return false;" class="btndel"><img src="http://fiximage.10x10.co.kr/web2013/event/btn_cmt_close.gif" alt="코멘트 삭제"></button>
							<% End If %>
							<% If arrCList(8,intCLoop) <> "W" Then %>
								<br /><img src="http://fiximage.10x10.co.kr/web2013/event/ico_mobile.png" alt="모바일에서 작성됨">
							<% End If %>
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
<script type="text/javascript">
$(function(){
	/* slide js */
	$("#slide01").slidesjs({
		width:"1140",
		height:"540",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:1900, effect:"fade", auto:true},
		effect:{slide: {speed:1500}}
	});
	$("#slide02").slidesjs({
		width:"1140",
		height:"540",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:2500, effect:"fade", auto:true},
		effect:{slide: {speed:1500}}
	});

	//mouse control
	$('#slide01 .slidesjs-pagination > li a, #slide02 .slidesjs-pagination > li a').mouseenter(function(){
		$('a[data-slidesjs-item="' + $(this).attr("data-slidesjs-item") + '"]').trigger('click');
	});

	$(".slidesjs-pagination li:nth-child(1)").addClass("num01");
	$(".slidesjs-pagination li:nth-child(2)").addClass("num02");
	$(".slidesjs-pagination li:nth-child(3)").addClass("num03");
	$(".slidesjs-pagination li:nth-child(4)").addClass("num04");
	$(".slidesjs-pagination li:nth-child(5)").addClass("num05");
	$(".slidesjs-pagination li:nth-child(6)").addClass("num06");

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
		if (scrollTop > 800 ) {
			$(".heySomething .item h3 .logo img").addClass("flip");
		}
		if (scrollTop > 4600 ) {
			$(".heySomething #brand .brand1 .image img").addClass("pulse");
		}
		if (scrollTop > 5300 ) {
			$(".heySomething #brand .brand2 .image img").addClass("pulse");
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
});



</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->