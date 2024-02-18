<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈 44
' History : 2016-08-09 김진영 생성
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
	eCode   =  66182
Else
	eCode   =  72536
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
.heySomething .topic {background-color:#f3f3f3;}
.heySomething .topic h2 {z-index:5;}
.heySomething .topic .figure a {display:block; position:relative; width:100%; height:780px;}
.heySomething .topic .figure img {position:absolute; top:0; left:50%; margin-left:-951px;}

/* item */
.heySomething .item {width:1140px; margin:368px auto 0; padding:0;}
.heySomething .item h3 {position:relative; height:75px;}
.heySomething .item h3 .noritake {position:absolute; top:0; left:50%; margin-left:-51px; z-index:5;}
.heySomething .item h3 .horizontalLine1, .heySomething .item h3 .horizontalLine2 {position:absolute; top:37px; width:470px; height:1px; background-color:#d9d9d9;}
.heySomething .item h3 .horizontalLine1 {left:0;}
.heySomething .item h3 .horizontalLine2 {right:0;}
.heySomething .item .desc {position:relative; width:980px; height:440px; margin:0 auto; padding-top:115px;}
.heySomething .item .desc .option {height:395px;}
.heySomething .item .desc a {display:block;}
.heySomething .item .desc a:hover {text-decoration:none;}
.heySomething .item .slidewrap {position:absolute; top:70px; right:0; width:590px; height:440px;}
.heySomething .item .with {margin-top:48px; border-bottom:1px solid #ddd;}
.heySomething .item .with span {position:relative; z-index:5;}
.heySomething .item .with {padding-bottom:66px; text-align:center;}
.heySomething .item .with ul {overflow:hidden; width:1020px; margin:40px auto 0;}
.heySomething .item .with ul li {float:left; width:180px; margin:0 12px;}
.heySomething .item .with ul li a {display:block; color:#777; font-size:11px;}
.heySomething .item .with ul li span {display:block; margin-top:10px;}

/* brand */
.heySomething .brand {position:relative; height:457px; margin-top:353px; padding-top:276px; background-color:#f5f3e6;}
.heySomething .brand .logo {position:absolute; top:113px; left:50%; margin-left:-51px;}
.pulse {animation-name:pulse; animation-duration:1s; animation-iteration-count:1;}
@keyframes pulse {
	0% {transform:scale(0.8);}
	100% {transform:scale(1);}
}

/* visual */
.heySomething .visual {position:relative; margin-top:465px;}
.heySomething .visual .figure {background-color:#fff;}

/* story */
.heySomething .story {margin-top:500px; padding-bottom:100px;}
.heySomething .story .rolling {padding-top:269px;}
.heySomething .story .rolling .txt {position:absolute; top:0; left:50%; margin-left:-161px;}
.heySomething .story .rolling .swiper .swiper-slide {width:979px;}
.heySomething .story .rolling .pagination {top:122px; width:736px; margin-left:-368px;}
.heySomething .story .rolling .swiper-pagination-switch {width:128px; height:128px; margin:0 28px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/72536/btn_story_pagination_v1.png);}
.heySomething .story .rolling .pagination span.swiper-active-switch {background-position:0 100%;}
.heySomething .story .rolling .pagination span:first-child + span {background-position:-185px 0;}
.heySomething .story .rolling .pagination span:first-child + span.swiper-active-switch {background-position:-185px 100%;}
.heySomething .story .rolling .pagination span:first-child + span + span {background-position:-370px 0;}
.heySomething .story .rolling .pagination span:first-child + span + span.swiper-active-switch {background-position:-370px 100%;}
.heySomething .story .rolling .pagination span:first-child + span + span + span {background-position:-555px 0;}
.heySomething .story .rolling .pagination span:first-child + span + span + span.swiper-active-switch {background-position:-555px 100%;}
.heySomething .story .rolling .pagination span em {bottom:-770px; left:50%;height:100px; width:980px; margin-left:-490px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/72536/txt_story_desc.jpg); cursor:default;}
.heySomething .story .rolling .pagination span .desc2 {background-position:0 -100px;}
.heySomething .story .rolling .pagination span .desc3 {background-position:0 -200px;}
.heySomething .story .rolling .pagination span .desc4 {background-position:0 -300px;}
.heySomething .story .rolling .pagination span .desc5 {background-position:0 100%;}
.heySomething .story .rolling .btn-nav {top:580px;}
.heySomething .swipemask {top:294px;}
.heySomething .mask-left {margin-left:-1470px;}
.heySomething .mask-right {margin-left:490px;}

/* portfolio */
.heySomething .portfolio {margin-top:430px;}
.heySomething .portfolio .rolling {padding-top:0; padding-bottom:95px;}
.heySomething .portfolio .rolling .swiper {height:452px;}
.heySomething .portfolio .rolling .swiper .swiper-container {height:452px;}
.heySomething .portfolio .rolling .swiper .swiper-slide {width:400px; padding:0 90px;}
.heySomething .portfolio .rolling .pagination {top:516px; width:360px; margin-left:-180px;}
.heySomething .portfolio .rolling .swiper-pagination-switch {width:30px; height:29px; margin:0 3px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/72536/btn_portfolio_pagination.png);}
.heySomething .portfolio .rolling .pagination span.swiper-active-switch {background-position:0 100%;}
.heySomething .portfolio .rolling .pagination span:first-child + span {background-position:-36px 0;}
.heySomething .portfolio .rolling .pagination span:first-child + span.swiper-active-switch {background-position:-36px 100%;}
.heySomething .portfolio .rolling .pagination span:first-child + span + span {background-position:-72px 0;}
.heySomething .portfolio .rolling .pagination span:first-child + span + span.swiper-active-switch {background-position:-72px 100%;}
.heySomething .portfolio .rolling .pagination span:first-child + span + span + span {background-position:-108px 0;}
.heySomething .portfolio .rolling .pagination span:first-child + span + span + span.swiper-active-switch {background-position:-108px 100%;}
.heySomething .portfolio .rolling .pagination span:first-child + span + span + span + span {background-position:-144px 0;}
.heySomething .portfolio .rolling .pagination span:first-child + span + span + span + span.swiper-active-switch {background-position:-144px 100%;}
.heySomething .portfolio .rolling .pagination span:first-child + span + span + span + span + span {background-position:-180px 0;}
.heySomething .portfolio .rolling .pagination span:first-child + span + span + span + span + span.swiper-active-switch {background-position:-180px 100%;}
.heySomething .portfolio .rolling .pagination span:first-child + span + span + span + span + span + span {background-position:-216px 0;}
.heySomething .portfolio .rolling .pagination span:first-child + span + span + span + span + span + span.swiper-active-switch {background-position:-216px 100%;}
.heySomething .portfolio .rolling .pagination span:first-child + span + span + span + span + span + span + span {background-position:-252px 0;}
.heySomething .portfolio .rolling .pagination span:first-child + span + span + span + span + span + span + span.swiper-active-switch {background-position:-252px 100%;}
.heySomething .portfolio .rolling .pagination span:first-child + span + span + span + span + span + span + span + span {background-position:-288px 0;}
.heySomething .portfolio .rolling .pagination span:first-child + span + span + span + span + span + span + span + span.swiper-active-switch {background-position:-288px 100%;}
.heySomething .portfolio .rolling .pagination span:first-child + span + span + span + span + span + span + span + span + span {background-position:-324px 0;}
.heySomething .portfolio .rolling .pagination span:first-child + span + span + span + span + span + span + span + span + span.swiper-active-switch {background-position:-324px 100%;}
.heySomething .portfolio .rolling .btn-nav {top:516px; width:29px; height:29px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/72536/btn_portfolio_nav.png);}
.heySomething .portfolio .rolling .arrow-left {margin-left:-215px;}
.heySomething .portfolio .rolling .arrow-right {margin-left:186px;}

/* finish */
.noritakeInstar {position:relative; overflow:hidden; width:1140px; margin:430px auto 0 auto; text-align:center;}
.noritakeInstar strong {display:block;}
.noritakeInstar a {display:block; position:absolute; right:0; top:214px;}
.noritakeInstar ul {overflow:hidden; width:1156px; margin:85px -8px 0 -8px;}
.noritakeInstar ul li {overflow:hidden; float:left; width:215px; height:215px; margin:8px; background-position:50% 50%; background-repeat:no-repeat; background-size:100%;}
.noritakeInstar ul li.insta01 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/72536/img_instar_01.jpg);}
.noritakeInstar ul li.insta02 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/72536/img_instar_02.jpg);}
.noritakeInstar ul li.insta03 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/72536/img_instar_03.jpg);}
.noritakeInstar ul li.insta04 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/72536/img_instar_04.jpg);}
.noritakeInstar ul li.insta05 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/72536/img_instar_05.jpg);}
.noritakeInstar ul li.insta06 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/72536/img_instar_06.jpg);}
.noritakeInstar ul li.insta07 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/72536/img_instar_07.jpg);}
.noritakeInstar ul li.insta08 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/72536/img_instar_08.jpg);}
.noritakeInstar ul li.insta09 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/72536/img_instar_09.jpg);}
.noritakeInstar ul li.insta10 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/72536/img_instar_10.jpg);}

/* comment */
.heySomething .commentevet {margin-top:370px;}
.heySomething .commentevet .form {margin-top:25px;}
.heySomething .commentevet .form .choice li {width:100px; height:100px; margin-right:13px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/72536/img_ico_v1.png); background-position:0 0;}
.heySomething .commentevet .form .choice li button.on {background-position:0 100%;}
.heySomething .commentevet .form .choice li.ico2 button {background-position:-113px 0;}
.heySomething .commentevet .form .choice li.ico2 button.on {background-position:-113px 100%;}
.heySomething .commentevet .form .choice li.ico3 button {background-position:-226px 0;}
.heySomething .commentevet .form .choice li.ico3 button.on {background-position:-226px 100%;}
.heySomething .commentevet .form .choice li.ico4 button {background-position:100% 0;}
.heySomething .commentevet .form .choice li.ico4 button.on {background-position:100% 100%;}

.heySomething .commentevet textarea {margin-top:30px;}

.heySomething .commentlist table td strong {width:100px; height:100px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/72536/img_ico_v1.png); background-position:0 0;}
.heySomething .commentlist table td strong.ico2 {background-position:-113px 0;}
.heySomething .commentlist table td strong.ico3 {background-position:-226px 0;}
.heySomething .commentlist table td strong.ico4 {background-position:100% 0;}
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
		<% If not( left(currenttime,10) >= "2016-08-13" and left(currenttime,10) <= "2016-08-23" ) Then %>
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
				<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72536/img_item_represent.jpg" alt="NORITAKE" />
			</div>
		</div>
		<%' about %>
		<div class="about">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
			<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
		</div>
		<%' item %>
		<div class="item">
			<div class="inner">
				<h3>
					<span class="noritake"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72536/img_logo_n.png" alt="NORITAKE" /></span>
					<span class="horizontalLine1"></span>
					<span class="horizontalLine2"></span>
				</h3>
			<%
				IF application("Svr_Info") = "Dev" THEN
					itemid = 1239226
				Else
					itemid = 1542357
				End If
				set oItem = new CatePrdCls
					oItem.GetItemData itemid
			%>
				<div class="desc">
					<a href="/shopping/category_prd.asp?itemid=1542357&amp;pEtr=72536">
						<div class="option">
							<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72536/txt_name_01.png" alt="NORITAKE - INSIGHT BOY 핸드폰 케이스 입니다." /></p>
					<%' for dev msg : 상품코드 1542357 %>
					<% If oItem.FResultCount > 0 Then %>
							<div class="price">
								<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
							</div>
					<% End If %>
							<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72536/txt_substance_01.png" alt="2014년 7월에 발행된 전자책 ‘눈빛’의 커버 일러스트로 많은 사랑을 받고 있는 노리타케의 대표적인 일러스트입니다. 무심한듯한 소년의 표정에서 유쾌한 상상을 떠올리게 됩니다" /></p>
							<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러 가기" /></div>
						</div>
						<%' slide %>
						<div class="slidewrap">
							<div id="slide1" class="slide">
								<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72536/img_slide_item_01.jpg" alt="" /></div>
							</div>
						</div>
					</a>
				</div>
			<% set oItem = nothing %>
				<div class="with">
					<span><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/ico_plus.png" alt="" /></span>
					<ul>
				<%
					IF application("Svr_Info") = "Dev" THEN
						itemid = 786868
					Else
						itemid = 1531576
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
				%>
						<li>
							<a href="/shopping/category_prd.asp?itemid=1531576&amp;pEtr=72536">
								<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72536/img_with_item_01.jpg" alt="" />
								<span>CITY TOTE BAG</span>
							<% If oItem.FResultCount > 0 Then %>
								<div><b><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></b></div>
							<% End If %>
							</a>
						</li>
				<%
					set oItem = nothing
					IF application("Svr_Info") = "Dev" THEN
						itemid = 786868
					Else
						itemid = 1531454
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
				%>
						<li>
							<a href="/shopping/category_prd.asp?itemid=1531454&amp;pEtr=72536">
								<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72536/img_with_item_02.jpg" alt="" />
								<span>THIS IS PEN</span>
							<% If oItem.FResultCount > 0 Then %>
								<div><b><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></b></div>
							<% End If %>
							</a>
						</li>
				<%
					set oItem = nothing
					IF application("Svr_Info") = "Dev" THEN
						itemid = 786868
					Else
						itemid = 1531572
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
				%>
						<li>
							<a href="/shopping/category_prd.asp?itemid=1531572&amp;pEtr=72536">
								<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72536/img_with_item_03.jpg" alt="" />
								<span>YELLOW CARD</span>
							<% If oItem.FResultCount > 0 Then %>
								<div><b><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></b></div>
							<% End If %>
							</a>
						</li>
				<%
					set oItem = nothing
					IF application("Svr_Info") = "Dev" THEN
						itemid = 786868
					Else
						itemid = 1531653
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
				%>
						<li>
							<a href="/shopping/category_prd.asp?itemid=1531653&amp;pEtr=72536">
								<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72536/img_with_item_04.jpg" alt="" />
								<span>PULL T SHIRTS</span>
							<% If oItem.FResultCount > 0 Then %>
								<div><b><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></b></div>
							<% End If %>
							</a>
						</li>
				<%
					set oItem = nothing
					IF application("Svr_Info") = "Dev" THEN
						itemid = 786868
					Else
						itemid = 1531653
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
				%>
						<li>
							<a href="/shopping/category_prd.asp?itemid=1531555&amp;pEtr=72536">
								<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72536/img_with_item_05.jpg" alt="" />
								<span>VOTE B3 POSTER</span>
							<% If oItem.FResultCount > 0 Then %>
								<div><b><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></b></div>
							<% End If %>
							</a>
						</li>
				<% set oItem = nothing %>
					</ul>
				</div>
			</div>
		</div>		
		<%' brand %>
		<div class="brand">
			<div class="logo">
				<a href="/street/street_brand_sub06.asp?makerid=noritake" title="NORITAKE 브랜드 스트릿 페이지로으로 이동"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72536/img_logo_noritake.png" alt="NORITAKE" /></a>
			</div>
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72536/txt_brand.png" alt="ORITAKE는 일본의 일러스트레이터입니다. 심플한 흑백 드로잉으로 광고, 서적, 패션까지 다양한 장르에서 활동하고 있으며 개인전과 벽화 작업으로 국/내외에서 많은 사랑을 받고 있습니다. 또한 NORITAKE만의 감성으로 문구, 잡화 등의 자체 상품을 제작, 판매하고 있습니다." /></p>
			<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="" /></div>
		</div>
		<%' visual %>
		<div class="visual">
			<div class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72536/img_item_visual_big.jpg" alt="" /></div>
		</div>
		<%' story %>
		<div class="story">
			<div class="rollingwrap">
				<div id="rolling" class="rolling">
					<strong class="txt"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72536/txt_story.png" alt="NORITAKE - 다양한 공간에서 작품이 되다" /></strong>
					<div class="swipemask mask-left"></div>
					<div class="swipemask mask-right"></div>
					<button type="button" class="btn-nav arrow-left">Previous</button>
					<button type="button" class="btn-nav arrow-right">Next</button>
					<div class="swiper">
						<div class="swiper-container swiper1">
							<div class="swiper-wrapper" style="height:630px;">
								<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72536/img_story_01.jpg" alt="[#DESK] #펜 #노트 #엽서 #뱃지 #THIS IS PEN #SUPER BINDING NOTE #IPHONE CASE" /></div>
								<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72536/img_story_02.jpg" alt="[#GALLERY] #포스터 #엽서 #전시회 #일러스트 #SUPER MANUAL #EXHIBITION #ILLUSTRATION" /></div>
								<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72536/img_story_03.jpg" alt="[#LIBRARY] #잡지 #북커버_디자인 #일러스트북 #서재 #BRUTUS #MAGAZINE #IT IS IT" /></div>
								<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72536/img_story_04.jpg" alt="[#LIFE] #에코백 #티셔츠 #MUSIC TODAY #BOB # INSIGHT BOY #TOTE BAG #WHITE #GRAY" /></div>
							</div>
						</div>
					</div>
					<div class="pagination"></div>
				</div>
			</div>
		</div>
		<%' portfolio %>
		<div class="portfolio">
			<div class="rollingwrap">
				<div id="rolling2" class="rolling">
					<div class="swiper">
						<div class="swiper-container swiper2">
							<div class="swiper-wrapper" style="height:452px;">
								<div class="swiper-slide" style="width:640px"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72536/img_portfolio_01.jpg" alt="#MUJI (2015.12.26)" /></div>
								<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72536/img_portfolio_02.jpg" alt="#SELF DEFENSE (2014.09.05)" /></div>
								<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72536/img_portfolio_03.jpg" alt="#BRUTUS" /></div>
								<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72536/img_portfolio_04.jpg" alt="PAN (2015.03.19)" /></div>
								<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72536/img_portfolio_05.jpg" alt="THE FORECAST 2016 (2015.12.07)" /></div>
								<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72536/img_portfolio_06.jpg" alt="DETOUR (2016.02.12)" /></div>
								<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72536/img_portfolio_07.jpg" alt="JR SHINJUKU MIRAINATOWER (2016.05.04)" /></div>
								<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72536/img_portfolio_08.jpg" alt="悲しみの底で猫が教えてくれた大切なこと (2015.04.25)" /></div>
								<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72536/img_portfolio_09.jpg" alt="TEA WAY ART COLLECTION (2015.11.15)" /></div>
								<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72536/img_portfolio_10.jpg" alt="The Big Issue Taiwan vol.61 (2015.06.15)" /></div>
							</div>
						</div>
					</div>
					<div class="pagination"></div>
					<button type="button" class="btn-nav arrow-left">Previous</button>
					<button type="button" class="btn-nav arrow-right">Next</button>
				</div>
			</div>
		</div>
		<%' finish %>
		<div class="noritakeInstar">
			<strong><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72536/txt_n_instar.png" alt="" /></strong>
			<a href="https://www.instagram.com/noritake_org" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72536/link_n_instar.png" alt="" /></a>
			<ul>
				<li class="insta01"></li>
				<li class="insta02"></li>
				<li class="insta03"></li>
				<li class="insta04"></li>
				<li class="insta05"></li>
				<li class="insta06"></li>
				<li class="insta07"></li>
				<li class="insta08"></li>
				<li class="insta09"></li>
				<li class="insta10"></li>
			</ul>
		</div>

		<%' comment %>
		<div class="commentevet">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72536/tit_comment.png" alt="Hey, something project 심플함의 미학" /></h3>
			<p class="hidden">NORITAKE를 어떠한 공간에서 만나고 싶나요? 정성껏 코멘트를 남겨주신 5분을 추첨하여 공간에 어울리는 노리타케 상품을 드립니다 (랜덤증정) 코멘트 작성기간은 2016년 8월 17일부터 8월 23일까지며, 발표는 8월 24일 입니다.</p>

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
					<legend>NORITAKE를 어떠한 공간에서 만나고 싶은지 코멘트 작성하기</legend>
						<ul class="choice">
							<li class="ico1"><button type="button" value="1">#DESK</button></li>
							<li class="ico2"><button type="button" value="2">#GALLERY</button></li>
							<li class="ico3"><button type="button" value="3">#LIBRARY</button></li>
							<li class="ico4"><button type="button" value="4">#LIFE</button></li>
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
					<caption>상품 선택 항목, 내용, 작성일자, 아이디 정보를 제공하는 표</caption>
					<colgroup>
						<col style="width:150px;" />
						<col style="width:*;" />
						<col style="width:110px;" />
						<col style="width:120px;" />
					</colgroup>
					<thead>
					<tr>
						<th scope="col">상품 선택 항목</th>
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
										#DESK
									<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="2" Then %>
										#GALLERY
									<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="3" Then %>
										#LIBRARY
									<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="4" Then %>
										#LIFE
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
				<%'' paging %>
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

	/* swipe */
	var swiper2 = new Swiper('#rolling2 .swiper2',{
		centeredSlides:true,
		slidesPerView:"auto",
		loop: true,
		speed:800,
		autoplay:2800,
		simulateTouch:false,
		pagination: '#rolling2 .pagination',
		paginationClickable: true
	});

	$('#rolling2 .arrow-left').on('click', function(e){
		e.preventDefault()
		swiper2.swipePrev()
	});
	$('#rolling2 .arrow-right').on('click', function(e){
		e.preventDefault()
		swiper2.swipeNext()
	});

	/* finish */
	$('div.noritakeInstar ul li').mouseover(function(){
		$(this).animate({backgroundSize:'115%'},500);
	});
	$('div.noritakeInstar ul li').mouseout(function(){
		$(this).animate({backgroundSize:'100%'},300);
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
		if (scrollTop > 2500) {
			$(".heySomething .brand .logo").addClass("pulse");
			brandAnimation();
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

	/* brand animation */
	$(".heySomething .brand p").css({"height":"10px", "opacity":"0"});
	$(".heySomething .brand .btnDown").css({"opacity":"0"});
	function brandAnimation() {
		$(".heySomething .brand p").delay(500).animate({"height":"227px", "opacity":"1"},800);
		$(".heySomething .brand .btnDown").delay(1200).animate({"opacity":"1"},1200);
	}
});
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->