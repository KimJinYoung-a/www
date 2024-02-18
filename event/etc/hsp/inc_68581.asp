<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈
' History : 2016.01.11 한용민 생성
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
	'currenttime = #01/13/2016 09:00:00#

dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  66001
Else
	eCode   =  68581
End If

dim userid, commentcount, i
	userid = GetEncLoginUserID()

commentcount = getcommentexistscount(userid, eCode, "", "", "", "Y")

dim cEComment ,blnFull, cdl, com_egCode, bidx, blnBlogURL, strBlogURL
dim iCTotCnt, arrCList,intCLoop, pagereload
dim iCPageSize, iCCurrpage, isMyComm
dim iCStartPage, iCEndPage, iCTotalPage, iCx,iCPerCnt
	iCCurrpage	= getNumeric(requestCheckVar(Request("iCC"),10))	'현재 페이지 번호
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
IF application("Svr_Info") = "Dev" THEN
	itemid   =  1239115
Else
	itemid   =  1418361
End If

dim oItem
set oItem = new CatePrdCls
	oItem.GetItemData itemid

'dim itemid2, itemid3
'IF application("Svr_Info") = "Dev" THEN
'	itemid2   =  1239115
'	itemid3   =  1239115
'Else
'	itemid2   =  1378234
'	itemid3   =  1378199
'End If
   
'dim oItem2
'set oItem2 = new CatePrdCls
'	oItem2.GetItemData itemid2

'dim oItem3
'set oItem3 = new CatePrdCls
'	oItem3.GetItemData itemid3



Dim hspchk
'// 현재 주소값 체크하여 신규, 구버전 확인
hspchk = Split(LCase(Request.ServerVariables("PATH_INFO")),"/")

%>

<% '<!-- #include virtual="/lib/inc/head.asp" --> %>

<style type="text/css">
/* title */
.heySomething .topic {background-color:#f0f0f0; z-index:1;}

/* item */
.heySomething .itemB {padding-bottom:280px;}
.heySomething .itemB .desc {padding-left:547px;}
.heySomething .itemB .slidewrap {width:442px; padding-top:34px;}
.heySomething .itemB .slidewrap .slide {width:442px; height:520px;}
.heySomething .itemB .slidesjs-pagination {bottom:-228px; width:1106px; margin-left:-552px;}
.heySomething .itemB .slidesjs-pagination li {padding:0 7px;}
.heySomething .itemB .slidesjs-pagination li a {width:123px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/68581/bg_pagination.jpg);}
.heySomething .itemB .slidesjs-pagination li.item01 a {background-position:0 0;}
.heySomething .itemB .slidesjs-pagination li.item01 .active {background-position:0 -157px;}
.heySomething .itemB .slidesjs-pagination li.item02 a {background-position:-123px 0;}
.heySomething .itemB .slidesjs-pagination li.item02 .active {background-position:-123px -157px;}
.heySomething .itemB .slidesjs-pagination li.item03 a {background-position:-246px 0;}
.heySomething .itemB .slidesjs-pagination li.item03 .active {background-position:-246px -157px;}
.heySomething .itemB .slidesjs-pagination li.item04 a {background-position:-369px 0;}
.heySomething .itemB .slidesjs-pagination li.item04 .active {background-position:-369px -157px;}
.heySomething .itemB .slidesjs-pagination li.item05 a {background-position:-492px 0;}
.heySomething .itemB .slidesjs-pagination li.item05 .active {background-position:-492px -157px;}
.heySomething .itemB .slidesjs-pagination li.item06 a {background-position:-615px 0;}
.heySomething .itemB .slidesjs-pagination li.item06 .active {background-position:-615px -157px;}
.heySomething .itemB .slidesjs-pagination li.item07 a {background-position:-738px 0;}
.heySomething .itemB .slidesjs-pagination li.item07 .active {background-position:-738px -157px;}
.heySomething .itemB .slidesjs-pagination li.item08 a {background-position:-861px 0;}
.heySomething .itemB .slidesjs-pagination li.item08 .active {background-position:-861px -157px;}

/* visual */
.heySomething .visual .figure {background-color:#fff;}

/* brand */
.heySomething .brand {position:relative; height:932px;}
.heySomething .brand .poster {position:relative; width:637px; height:449px; margin:0 auto;}
.heySomething .brand .poster div {position:absolute; z-index:20;}
.heySomething .brand .poster .p01 {left:0; top:0;  z-index:30;}
.heySomething .brand .poster .p02 {left:160px; top:0;}
.heySomething .brand .poster .p03 {left:320px; top:0;}
.heySomething .brand .poster .p04 {left:480px; top:0;}
.heySomething .brand .poster .p05 {left:0; top:226px;}
.heySomething .brand .poster .p06 {left:160px; top:226px;}
.heySomething .brand .poster .p07 {left:320px; top:226px;}
.heySomething .brand .poster .p08 {left:480px; top:226px;}
.heySomething .brand .name {overflow:hidden; position:relative; width:354px; height:94px; margin:62px auto 58px;}
.heySomething .brand .name em {display:inline-block; position:absolute; left:194px; top:21px; z-index:20; width:1px; height:64px; background:#d9d9d9;}
.heySomething .brand .name span {display:inline-block; position:absolute; top:0; z-index:10;;}
.heySomething .brand .name span.n01 {left:0;}
.heySomething .brand .name span.n02 {right:0;}
.heySomething .brand .info {position:relative; padding-bottom:90px;}

/* story */
.heySomething .story h3 {margin-bottom:30px;}
.heySomething .rolling {padding-top:200px;}
.heySomething .rolling .pagination {top:0; width:1000px; margin-left:-500px;}
.heySomething .rolling .swiper-pagination-switch {width:150px; height:165px; margin:0 25px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/68581/bg_ico.png);}
.heySomething .rolling .pagination span.swiper-active-switch {background-position:0 -165px;}
.heySomething .rolling .pagination span:first-child + span.swiper-active-switch {background-position:-150px -165px;}
.heySomething .rolling .pagination span:first-child + span + span.swiper-active-switch {background-position:-300px -165px;}
.heySomething .rolling .pagination span:first-child + span + span + span.swiper-active-switch {background-position:-450px -165px;}
.heySomething .rolling .pagination span:first-child + span + span + span + span.swiper-active-switch {background-position:-600px -165px;}
.heySomething .rolling .pagination span:first-child + span + span + span + span + span.swiper-active-switch {background-position:-750px -165px;}
.heySomething .rolling .pagination span:first-child + span + span + span + span + span + span.swiper-active-switch {background-position:100% -165px;}
.heySomething .rolling .pagination span em {bottom:-790px; left:50%; margin-left:-490px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/68581/txt_story_desc.png); cursor:default;}
.heySomething .rolling .btn-nav {top:488px;}
.heySomething .swipemask {top:205px;}

/* finish */
.heySomething .finish {background-color:#f7f7f7;}
.heySomething .finish .bg {position:absolute; top:0; left:0; z-index:5; width:100%; height:850px; background:transparent url(http://webimage.10x10.co.kr/eventIMG/2016/hey/68581/img_finish.jpg) no-repeat 50% 0;}
.heySomething .finish p {top:304px; left:50%; margin-left:-525px; width:341px; height:244px;}

/* comment */
.heySomething .commentevet .form .choice li {height:165px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/68581/bg_ico.png);}
.heySomething .commentevet .form .choice li.ico1 button {background-position:0 -330px;}
.heySomething .commentevet .form .choice li.ico1 button.on {background-position:0 100%;}
.heySomething .commentevet .form .choice li.ico2 button {background-position:-150px -330px;}
.heySomething .commentevet .form .choice li.ico2 button.on {background-position:-150px 100%;}
.heySomething .commentevet .form .choice li.ico3 button {background-position:-300px -330px;}
.heySomething .commentevet .form .choice li.ico3 button.on {background-position:-300px 100%;}
.heySomething .commentevet .form .choice li.ico4 button {background-position:-450px -330px;}
.heySomething .commentevet .form .choice li.ico4 button.on {background-position:-450px 100%;}
.heySomething .commentevet .form .choice li.ico5 button {background-position:-600px -330px;}
.heySomething .commentevet .form .choice li.ico5 button.on {background-position:-600px 100%;}
.heySomething .commentevet textarea {margin-top:30px;}

.heySomething .commentlist table td {padding:20px 0;}
.heySomething .commentlist table td strong {height:132px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/68581/bg_ico.png);}
.heySomething .commentlist table td .ico1 {background-position:0 -358px;}
.heySomething .commentlist table td .ico2 {background-position:-150px -358px;}
.heySomething .commentlist table td .ico3 {background-position:-300px -358px;}
.heySomething .commentlist table td .ico4 {background-position:-450px -358px;}
.heySomething .commentlist table td .ico5 {background-position:-600px -358px;}
</style>
<script type='text/javascript'>

$(function(){
	<% if pagereload<>"" then %>
		//pagedown();
		setTimeout("pagedown()",1000);
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
		<% If not( left(currenttime,10)>="2016-01-13" and left(currenttime,10)<"2016-01-21" ) Then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return false;
		<% else %>
			<% if commentcount>4 then %>
				alert("이벤트는 5회까지 참여 가능 합니다.");
				return false;
			<% else %>
				if (frm.gubunval.value == ''){
					alert('원하는 것을 선택해 주세요.');
					return false;
				}
				if (frm.txtcomm1.value == '' || GetByteLength(frm.txtcomm1.value) > 400){
					alert("코맨트를 남겨주세요.\n400자 까지 작성 가능합니다.");
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
<div class="evt66453">
	<div class="heySomething">
<% End If %>

<% '<!-- title, nav --> %>
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
		
	<div class="bnr">
		<a href="/shopping/category_prd.asp?itemid=1418361&amp;pEtr=68581" target="_blank">
		<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68581/img_item_represent.jpg" alt="Vintage Mickey" /></a>
	</div>
</div>

<% '<!-- about --> %>
<div class="about">
	<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
	<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
</div>

<% '<!-- item --> %>
<div class="item itemB">
	<div class="inner">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68581/tit_disney_10x10.png" alt="디즈니와 텐바이텐의 만남" /></h3>
		<div class="desc">
			<div class="option">
				<em class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68581/txt_name.png" alt="[Disney] Vintage Poster 아이폰6/6S 케이스" /></em>
				
				<% if oItem.FResultCount > 0 then %>
					<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
						<% '<!-- for dev msg : 할인 --> %>
						<div class="price">
							<strong class="discount">
								<img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/txt_only_<%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>percent.png" alt="단, 일주일만 ONLY <%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%" />
							</strong>
							<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
							<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
						</div>
					<% Else %>	
						<% '<!-- for dev msg : 종료 후 --> %>
						<div class="price priceEnd">
							<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
						</div>
					<% End If %>
				<% end if %>

				<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68581/txt_substance.png" alt="월드 디즈니 오리지널 포스터를 아이폰 케이스로 소장하세요. Walt Disney Vintage Poster collection" /></p>
				<div class="btnget">
					<a href="/shopping/category_prd.asp?itemid=1418361&amp;pEtr=68581" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러 가기" /></a>
				</div>
			</div>
			<div class="slidewrap">
				<div id="slide01" class="slide">
					<div><a href="/shopping/category_prd.asp?itemid=1418361&amp;pEtr=68581" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68581/img_item_01.jpg" alt="" /></a></div>
					<div><a href="/shopping/category_prd.asp?itemid=1418361&amp;pEtr=68581" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68581/img_item_02.jpg" alt="" /></a></div>
					<div><a href="/shopping/category_prd.asp?itemid=1418361&amp;pEtr=68581" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68581/img_item_03.jpg" alt="" /></a></div>
					<div><a href="/shopping/category_prd.asp?itemid=1418361&amp;pEtr=68581" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68581/img_item_04.jpg" alt="" /></a></div>
					<div><a href="/shopping/category_prd.asp?itemid=1418361&amp;pEtr=68581" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68581/img_item_05.jpg" alt="" /></a></div>
					<div><a href="/shopping/category_prd.asp?itemid=1418361&amp;pEtr=68581" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68581/img_item_06.jpg" alt="" /></a></div>
					<div><a href="/shopping/category_prd.asp?itemid=1418361&amp;pEtr=68581" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68581/img_item_07.jpg" alt="" /></a></div>
					<div><a href="/shopping/category_prd.asp?itemid=1418361&amp;pEtr=68581" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68581/img_item_08.jpg" alt="" /></a></div>
				</div>
			</div>
		</div>
	</div>
</div>

<% '<!-- visual --> %>
<div class="visual">
	<div class="figure"><a href="/shopping/category_prd.asp?itemid=1418361&amp;pEtr=68581" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68581/img_item_visual_big.jpg" alt="" /></a></div>
</div>

<% '<!-- brand --> %>
<div class="brand">
	<div class="poster">
		<div class="p01"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68581/img_poster_01.jpg" alt="" /></div>
		<div class="p02"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68581/img_poster_02.jpg" alt="" /></div>
		<div class="p03"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68581/img_poster_03.jpg" alt="" /></div>
		<div class="p04"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68581/img_poster_04.jpg" alt="" /></div>
		<div class="p05"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68581/img_poster_05.jpg" alt="" /></div>
		<div class="p06"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68581/img_poster_06.jpg" alt="" /></div>
		<div class="p07"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68581/img_poster_07.jpg" alt="" /></div>
		<div class="p08"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68581/img_poster_08.jpg" alt="" /></div>
	</div>
	<p class="name">
		<span class="n01"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68581/logo_disney.png" alt="Disney" /></span>
		<span class="n02"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68581/logo_10x10.png" alt="10x10" /></span>
		<em></em>
	</p>
	<div class="info">
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68581/txt_brand.png" alt="월드 디즈니 오리지널 포스터를 아이폰 케이스로 소장하세요. Walt Disney Vintage Poster collection" /></p>
	</div>
	<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="" /></div>
</div>

<% '<!-- story --> %>
<div class="story">
	<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68581/txt_story.png" alt="365일 당신과 함께하는 DISNEY의 빈티지 감성" /></h3>
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
							<a href="/shopping/category_prd.asp?itemid=1418361&amp;pEtr=68581" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68581/img_slide_01.jpg" alt="" /></a>
						</div>
						<div class="swiper-slide">
							<a href="/shopping/category_prd.asp?itemid=1418361&amp;pEtr=68581" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68581/img_slide_02.jpg" alt="" /></a>
						</div>
						<div class="swiper-slide">
							<a href="/shopping/category_prd.asp?itemid=1418361&amp;pEtr=68581" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68581/img_slide_03.jpg" alt="" /></a>
						</div>
						<div class="swiper-slide">
							<a href="/shopping/category_prd.asp?itemid=1418361&amp;pEtr=68581" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68581/img_slide_04.jpg" alt="" /></a>
						</div>
						<div class="swiper-slide">
							<a href="/shopping/category_prd.asp?itemid=1418361&amp;pEtr=68581" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68581/img_slide_05.jpg" alt="" /></a>
						</div>
					</div>
				</div>
			</div>
			<div class="pagination"></div>
		</div>
	</div>
</div>

<% '<!-- finish --> %>
<div class="finish">
	<a href="/shopping/category_prd.asp?itemid=1418361&amp;pEtr=68581" target="_blank">
		<div class="bg"></div>
		<p class="txt"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68581/txt_finish.png" alt="Disney Vintage Collection - 디즈니는 1923년 설립 이래로 필름스케치, 드로잉, 포스터 등 다양한 작업을 통해 디즈니 고유의 아트워크를 창조하고 있습니다. 디즈니의 빈티지 컬렉션은 클래식 감성을 간직한 사랑스러운 디즈니 캐릭터를 통해 어린 시절의 추억과 향수를 불러일으킵니다." /></p>
	</a>
</div>

<% '<!-- comment --> %>
<div class="commentevet">
	<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68581/tit_comment.png" alt="Hey, something project 당신이 갖고 싶은 것" /></h3>
	<p class="hidden">가장 마음에 드는 케이스와 그 이유를 남겨주세요. 정성껏 코멘트를 남겨주신 3분을 추첨하여 [Disney] Vintage Poster 아이폰6/6S 케이스를 선물로 드립니다. 기간:2016.01.13~01.20/발표:01.21</p>
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
				<li class="ico1"><button type="button" value="1">STUDY</button></li>
				<li class="ico2"><button type="button" value="2">FASHION</button></li>
				<li class="ico3"><button type="button" value="3">HOME</button></li>
				<li class="ico4"><button type="button" value="4">TRAVEL</button></li>
				<li class="ico5"><button type="button" value="5">COUPLE</button></li>
			</ul>
			<textarea name="txtcomm1" id="txtcomm1" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();" <%IF NOT(IsUserLoginOK) THEN%>readonly<%END IF%> title="코멘트 쓰기" cols="60" rows="5"><%IF NOT IsUserLoginOK THEN%>로그인 후 글을 남길 수 있습니다.<% else %><%END IF%></textarea>
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

	<% '<!-- commentlist --> %>
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
										STUDY
									<% elseif split(arrCList(1,intCLoop),"!@#")(0)="2" then %>
										FASHION
									<% elseif split(arrCList(1,intCLoop),"!@#")(0)="3" then %>
										HOME
									<% elseif split(arrCList(1,intCLoop),"!@#")(0)="4" then %>
										TRAVEL
									<% elseif split(arrCList(1,intCLoop),"!@#")(0)="5" then %>
										COUPLE
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
</div>
<% End If %>

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

	/* slide js */
	$("#slide01").slidesjs({
		width:"442",
		height:"520",
		pagination:{effect:"slide"},
		navigation:{effect:"slide"},
		play:{interval:1900, effect:"slide", auto:true},
		effect:{slide: {speed:1500}
		},
		callback: {
			complete: function(number) {
				var pluginInstance = $('#slide01').data('plugin_slidesjs');
				setTimeout(function() {
					pluginInstance.play(true);
				}, pluginInstance.options.play.interval);
			}
		}
	});

	$(".slidesjs-pagination li:nth-child(1)").addClass("item01");
	$(".slidesjs-pagination li:nth-child(2)").addClass("item02");
	$(".slidesjs-pagination li:nth-child(3)").addClass("item03");
	$(".slidesjs-pagination li:nth-child(4)").addClass("item04");
	$(".slidesjs-pagination li:nth-child(5)").addClass("item05");
	$(".slidesjs-pagination li:nth-child(6)").addClass("item06");
	$(".slidesjs-pagination li:nth-child(7)").addClass("item07");
	$(".slidesjs-pagination li:nth-child(8)").addClass("item08");

	var conChk = 0;
	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 3900 ) {
			if (conChk==0){
				brandAnimation()
			}
		}
		if (scrollTop > 6600 ) {
			finishAnimation()
		}
	});

	/* title animation */
	titleAnimation()
	$(".heySomething .topic h2 span").css({"opacity":"0"});
	$(".heySomething .topic h2 .letter1").css({"margin-top":"7px"});
	$(".heySomething .topic h2 .letter2").css({"margin-top":"15px"});
	$(".heySomething .topic h2 .letter3").css({"margin-top":"23px"});
	function titleAnimation() {
		$(".heySomething .topic h2 .letter1").delay(400).animate({"margin-top":"0", "opacity":"1"},800);
		$(".heySomething .topic h2 .letter2").delay(800).animate({"margin-top":"7px", "opacity":"1"},800);
		$(".heySomething .topic h2 .letter3").delay(1200).animate({"margin-top":"17px", "opacity":"1"},800);
	}

	/* brand animation */
	$(".heySomething .brand .poster div").css({"left":"240px","top":"113px"});
	$(".heySomething .brand .btnDown").css({"opacity":"0"});
	$(".heySomething .brand .name em").css({"top":"53px","height":"0"});
	$(".heySomething .brand .name .n01").css({"left":"30px","opacity":"0"});
	$(".heySomething .brand .name .n02").css({"right":"30px","opacity":"0"});
	$(".heySomething .brand .info").css({"top":"10px","opacity":"0"});
	function brandAnimation() {
		conChk = 1;
		$(".heySomething .brand .poster .p01").animate({"left":"0","top":"0"},800);
		$(".heySomething .brand .poster .p02").animate({"left":"160px","top":"0"},800);
		$(".heySomething .brand .poster .p03").animate({"left":"320px","top":"0"},800);
		$(".heySomething .brand .poster .p04").animate({"left":"480px","top":"0"},800);
		$(".heySomething .brand .poster .p05").animate({"left":"0","top":"226px"},800);
		$(".heySomething .brand .poster .p06").animate({"left":"160px","top":"226px"},800);
		$(".heySomething .brand .poster .p07").animate({"left":"320px","top":"226px"},800);
		$(".heySomething .brand .poster .p08").animate({"left":"480px","top":"226px"},800);
		$(".heySomething .brand .name em").delay(700).animate({"top":"21px","height":"64px"},600);
		$(".heySomething .brand .name .n01").delay(1200).animate({"left":"0","opacity":"1"},800);
		$(".heySomething .brand .name .n02").delay(1200).animate({"right":"0","opacity":"1"},800);

		$(".heySomething .brand .info").delay(1900).animate({"top":"0", "opacity":"1"},500);
		$(".heySomething .brand .btnDown").delay(2200).animate({"margin-top":"62px", "opacity":"1"},1000);
	}

	$(".heySomething .finish .txt").css({"margin-left":"-515px","opacity":"0"});
	function finishAnimation() {
		$(".heySomething .finish .txt").animate({"margin-left":"-525px","opacity":"1"},1500);
	}
	
});
</script>

<%
set oItem=nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->