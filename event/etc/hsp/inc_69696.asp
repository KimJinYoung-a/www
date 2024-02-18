<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈 25
' History : 2016-03-22 이종화 생성
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
	eCode   =  66080
Else
	eCode   =  69696
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
@import url(http://fonts.googleapis.com/earlyaccess/nanumgothic.css);

/* title */
.heySomething .topic {background:#e7f6fc url(http://webimage.10x10.co.kr/eventIMG/2016/hey/69696/img_item_represent.jpg) no-repeat 50% 0;}
.heySomething .topic .bnr {text-indent:-9999em;}
.heySomething .topic .bnr a {display:block; width:100%; height:780px;}

/* item */
.heySomething .itemA {padding-bottom:300px;}
.heySomething .itemA .desc {position:relative; padding-bottom:8px; border-bottom:1px solid #ddd;}
.heySomething .itemA .figure {top:10px; left:450px;}

/* visual */
.heySomething .visual .figure {position:relative; height:723px; background-color:#e3ebf9;}
.heySomething .visual .figure .bg {position:absolute; top:0; left:0; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/69696/img_item_visual_big.jpg) no-repeat 50% 0;}
.heySomething .visual .figure .image-zoom {animation-name:image-zoom; animation-duration:0.7s; animation-timing-function:linear; animation-fill-mode:forwards;}
@keyframes image-zoom {
	from {transform: scale(1.1);}
	to {transform: scale(1);}
}

.heySomething .visual .figure a {display:block; position:relative; width:100%; height:100%;}
.heySomething .visual .figure p {position:absolute; top:93px; left:50%;}
.heySomething .visual .figure .sentence1 {margin-left:-547px;}
.heySomething .visual .figure .sentence2 {margin-left:-82px;}
.heySomething .visual .figure .sentence3 {margin-left:395px;}

/* brand */
.heySomething .brand {height:630px;}
.heySomething .brand .inner {position:relative; height:489px;}
.heySomething .brand .inner .photo, .heySomething .brand .inner p {position:absolute; top:0; left:50%;}
.heySomething .brand .inner .photo {margin-left:-427px;}
.heySomething .brand .inner p {top:37px; margin-left:17px;}

/* story */
.heySomething .story {padding-bottom:0;}
.heySomething .rolling h3 {margin-bottom:0;}
.heySomething .rolling {padding-top:75px;}
.heySomething .rolling .pagination {display:none;}
.heySomething .rolling .btn-nav {top:357px;}
.heySomething .swipemask {top:75px;}

/* collection */
.collectionBeyondcloset {overflow:hidden; width:1146px; margin:400px auto 0;}
.collectionBeyondcloset .col {float:left; position:relative; width:382px; height:758px;}
.collectionBeyondcloset .col .hgroup {position:absolute; z-index:5;}
.collectionBeyondcloset .col .hgroup a {overflow:hidden; display:block; position:relative; width:184px; height:184px;}
.collectionBeyondcloset .col .hgroup a p {position:absolute; bottom:-184px; left:0; transition:bottom 0.8s;}
.collectionBeyondcloset .col .hgroup a:hover p {bottom:0;}
.collectionBeyondcloset .col ul {overflow:hidden;}
.collectionBeyondcloset .col ul li {overflow:hidden; float:left; margin:0 3px 7px 4px; width:184px; height:184px;}
.collectionBeyondcloset .col ul li a {display:block; position:relative; width:100%; height:100%;}
.collectionBeyondcloset .col ul li a div {position:absolute; top:0; left:0; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/68959/bg_mask.png) repeat 0 0; text-align:center;}
.collectionBeyondcloset .col ul li a div {transition:opacity 0.7s ease-out; opacity:0; filter: alpha(opacity=0);}
.collectionBeyondcloset .col ul li a div span {display:table; position:relative; width:100%; height:100%; color:#fff; font-family:'Nanum Gothic', sans-serif; font-size:15px; font-weight:bold; text-shadow:0 2px 3px #000;}
.collectionBeyondcloset .col ul li a div span i {display:table-cell; width:100%; font-style:normal; vertical-align:middle;}
.collectionBeyondcloset .col ul li a div span:after {content:' '; visibility:hidden; position:absolute; bottom:60px; left:50%; width:40px; height:1px; margin-left:-20px; background-color:#fff; -webkit-transform: scaleX(0); transform: scaleX(0); -webkit-transition: all 0.3s ease-in-out 0s;
 transition: all 0.3s ease-in-out 0s;}
 .collectionBeyondcloset .col ul li.type1 a div span:after {bottom:70px;}

.collectionBeyondcloset .col ul li a:hover div {opacity:1; filter: alpha(opacity=100); height:100%;}
.collectionBeyondcloset .col ul li a:hover span:after, .collectionBeyondcloset .col ul li a:hover span:focus:after {visibility:visible; -webkit-transform: scaleX(1); transform: scaleX(1);}

.collectionBeyondcloset .col1 .hgroup {top:0; left:4px;}
.collectionBeyondcloset .col1 ul li.item1 {margin-left:195px;}
.collectionBeyondcloset .col1 ul li.item6 {width:374px;}
.collectionBeyondcloset .col1 ul li.item6 a div span:after {bottom:70px;}

.collectionBeyondcloset .col2 .hgroup {right:3px; bottom:0;}
.collectionBeyondcloset .col2 ul li.item3, .collectionBeyondcloset .col2 ul li.item4 {margin-right:195px;}
.collectionBeyondcloset .col2 ul li.item5 {position:absolute; top:190px; right:0; width:184px; height:375px;}
.collectionBeyondcloset .col2 ul li.item5 a div span:after {bottom:150px;}

.collectionBeyondcloset .col3 .hgroup {top:0; right:3px;}
.collectionBeyondcloset .col3 ul li.item1 {margin-right:195px;}
.collectionBeyondcloset .col3 ul li.item4 {width:376px; height:376px;}
.collectionBeyondcloset .col3 ul li.item4 a div span:after {bottom:160px;}

/* finish */
.heySomething .finish {height:779px; background:#e4e8f3 url(http://webimage.10x10.co.kr/eventIMG/2016/hey/69696/img_finish.jpg) no-repeat 50% 0;}
.heySomething .finish a {display:block; width:100%; height:100%;}
.heySomething .finish p {top:419px; margin-left:293px;}

/* comment */
.heySomething .commentevet {margin-top:250px;}
.heySomething .commentevet .form {margin-top:26px;}
.heySomething .commentevet .form .choice li {width:111px; margin-right:20px;}
.heySomething .commentevet .form .choice li.ico2 {width:130px;}
.heySomething .commentevet .form .choice li.ico3 {margin-right:25px;}
.heySomething .commentevet .form .choice li.ico4 {width:118px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/69696/bg_ico.png); background-position:0 0;}
.heySomething .commentevet .form .choice li.ico2 button {background-position:-132px 0;}
.heySomething .commentevet .form .choice li.ico2 button.on {background-position:-132px 100%;}
.heySomething .commentevet .form .choice li.ico3 button {background-position:-284px 0;}
.heySomething .commentevet .form .choice li.ico3 button.on {background-position:-284px 100%;}
.heySomething .commentevet .form .choice li.ico4 button {background-position:100% 0;}
.heySomething .commentevet .form .choice li.ico4 button.on {background-position:100% 100%;}
.heySomething .commentevet textarea {margin-top:23px;}

.heySomething .commentlist table td strong {width:111px; height:111px; margin-left:20px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/69696/bg_ico.png); background-position:0 -6px;}
.heySomething .commentlist table td strong.ico2 {background-position:-143px -6px;}
.heySomething .commentlist table td strong.ico3 {background-position:-284px -6px;}
.heySomething .commentlist table td strong.ico4 {background-position:-426px -6px;}
</style>
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
		<% If not( left(currenttime,10)>="2016-03-23" and left(currenttime,10)<"2016-03-30" ) Then %>
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
			<div class="bnr"><a href="/shopping/category_prd.asp?itemid=1453423&amp;pEtr=69696">텐바이텐 단독 COOKIE DOG PATCH SWEAT SHIRT</a></div>
		</div>

		<%' about %>
		<div class="about">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
			<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
		</div>

		<%' item %>
		<div class="item itemA">
			<div class="inner">
				<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69696/tit_beyound_closet_tenten.png" alt="beyound closet &amp; 텐바이텐" /></h3>
				<%
				itemid = 1453423
				set oItem = new CatePrdCls
					oItem.GetItemData itemid
				%>
				<div class="desc">
					<div class="figure">
						<a href="/shopping/category_prd.asp?itemid=1453423&amp;pEtr=69696"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69696/img_figure.jpg" width="655" height="560" alt="틴틴 KEY RING"></a>
					</div>
					<div class="option">
						<em class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69696/txt_name.png" alt="Cookie Dog Patch Sweatshirts 텐바이텐 단독 상품 인디 핑크색으로 코코튼 100%로 입니다." /></em>
						<% if oItem.FResultCount > 0 then %>
							<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
								<div class="price">
									<% If not( left(currenttime,10)>="2016-03-23" and left(currenttime,10)<="2016-03-29" ) Then %>
									<% else %>
										<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/txt_just_one_week.png" alt="단, 일주일만 just one week" /></strong>
										<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %>won</s>
									<% end if %>
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								</div>
							<% Else %>
								<div class="price priceEnd">
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								</div>
							<% end if %>
						<% End If %>
						<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69696/txt_substance.png" alt="다양한 방법으로 변주된 강아지 캐릭터가 매력적인 비욘드클로젯 2016 S/S 아이러브펫 레이블의 텐바이텐 단독 컬러 에디션!" /></p>
						<div class="btnget"><a href="/shopping/category_prd.asp?itemid=1453423&amp;pEtr=69696"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="Cookie Dog Patch Sweatshirts 구매 하러 가기" /></a></div>
					</div>
				</div>
				<% set oItem=nothing %>
			</div>
		</div>

		<%' visual %>
		<div class="visual">
			<div class="figure">
				<a href="/shopping/category_prd.asp?itemid=1453423&amp;pEtr=69696">
					<div class="bg"></div>
					<p class="sentence1"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69696/txt_visual_01.png" alt="봄에 가장 입기 좋은 인디핑크 컬러와 가장 반응이 좋았던 COOKIE DOG 패치가 만나 사랑스러움을 더하였습니다" /></p>
					<p class="sentence2"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69696/txt_visual_02.png" alt="고밀도 원단으로 세탁 시 수축율을 최소화 하여 오래도록 착용이 가능합니다" /></p>
					<p class="sentence3"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69696/txt_visual_03.png" alt="위트있는 그래픽을 자체 개발된 패치를 사용하여 프레스로 접착하였습니다" /></p>
				</a>
			</div>
		</div>

		<%' brand %>
		<div class="brand">
			<div class="inner">
				<div class="photo"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69696/img_brand.jpg" alt="" /></div>
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69696/txt_brand.png" alt="비욘드 클로젯은 옷장을 넘어서란 의미를 가지고 있습니다. 옷장은 그 사람의 성격, 감성, 라이프스타일을 엿볼 수 있는 공간이라고 생각합니다. 나이와 상관없이 옷을 사랑하는 누구나 입을 수 있는 옷 이라는 슬로건을 가지고 비욘드 클로젯만의 스타일을 만듭니다. 컬렉션 라인인 beyondcloset과 세컨레이블인 beyondcloset campaign을 전개합니다." /></p>
			</div>
			<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="" /></div>
		</div>

		<%' story %>
		<div class="story">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69696/tit_story_lookbook.png" alt="Beyondcloset 2016 S/S Collection LOOKBOOK" /></h3>
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
									<a href="/street/street_brand_sub06.asp?makerid=beyondcloset"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69696/img_slide_01.jpg" alt="비욘드클로젯" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1428328&amp;pEtr=69696"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69696/img_slide_02.jpg" alt="CEREAL DOG PATCH SWEAT SHIRT" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1428231&amp;pEtr=69696"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69696/img_slide_03.jpg" alt="BC MARKET COACH 점퍼" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1428356&amp;pEtr=69696"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69696/img_slide_04.jpg" alt="LOGO PATTERN MIX SWEAT SHIRT" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1428360&amp;pEtr=69696"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69696/img_slide_05.jpg" alt="POPCORN DOG 후드" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1428303&amp;pEtr=69696"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69696/img_slide_06.jpg" alt="COOKIE APOLLO DOG 후드" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1428236&amp;pEtr=69696"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69696/img_slide_07.jpg" alt="CHUCHU DOG SHIRT" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1433680&amp;pEtr=69696"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69696/img_slide_08.jpg" alt="BASIC PREPPY LOGO V NECK SWEAT SHIRT" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1442069&amp;pEtr=69696"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69696/img_slide_09.jpg" alt="CHOCO BOARD DOG PATCH SWEAT SHIRT" /></a>
								</div>
							</div>
						</div>
					</div>
					<div class="pagination"></div>
				</div>
			</div>
		</div>

		<%' collection %>
		<div class="collectionBeyondcloset">
			<div class="col col1">
				<div class="hgroup">
					<a href="/street/street_brand_sub06.asp?makerid=beyondcloset">
						<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69696/tit_collection_the_bc_market.png" alt="THE BC MARKET Campaign label" /></h3>
						<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69696/txt_collection_the_bc_market.png" alt="비욘드 클로젯의 세컨드 레이블인 캠페인 라벨은 기존의 아이덴티티와 감성을 담은 디자인을 좀 더 대중적이고 합리적인 가격으로 많은 이들에게 알리는 것에 의의를 둔 레이블입니다" /></p>
					</a>
				</div>
				<ul>
					<li class="item1">
						<a href="/shopping/category_prd.asp?itemid=1428328&amp;pEtr=69696">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69696/img_collection_the_bc_market_01.jpg" alt="" />
							<div><span><i>CEREAL DOG PATCH SWEAT SHIRT</i></span></div>
						</a>
					</li>
					<li class="item2 type1">
						<a href="/shopping/category_prd.asp?itemid=1428231&amp;pEtr=69696">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69696/img_collection_the_bc_market_02.jpg" alt="" />
							<div><span><i>BC MARKET COACH JP</i></span></div>
						</a>
					</li>
					<li class="item3">
						<a href="/shopping/category_prd.asp?itemid=1428325&amp;pEtr=69696">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69696/img_collection_the_bc_market_03.jpg" alt="" />
							<div><span><i>PEANUT DOG PATCH SWEAT SHIRT</i></span></div>
						</a>
					</li>
					<li class="item4 type1">
						<a href="/shopping/category_prd.asp?itemid=1436001&amp;pEtr=69696">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69696/img_collection_the_bc_market_04.jpg" alt="" />
							<div><span><i>BC MARKET BROOCH</i></span></div>
						</a>
					</li>
					<li class="item5">
						<a href="/shopping/category_prd.asp?itemid=1429044&amp;pEtr=69696">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69696/img_collection_the_bc_market_05.jpg" alt="" />
							<div><span><i>BC MARKET LEATHER CAMP CAP</i></span></div>
						</a>
					</li>
					<li class="item6">
						<a href="/shopping/category_prd.asp?itemid=1428341&amp;pEtr=69696">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69696/img_collection_the_bc_market_06.jpg" alt="" />
							<div><span><i>MILK A-KING DOG PATCH SWEAT SHIRT</i></span></div>
						</a>
					</li>
				</ul>
			</div>

			<div class="col col2">
				<div class="hgroup">
					<a href="/street/street_brand_sub06.asp?makerid=beyondcloset">
						<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69696/tit_collection_i_love_pet.png" alt="I LOVE PET 위트있고 다양한 방법으로 변주된 강아지 캐릭터로 디자인된 레이블입니다. 수익금의 일부는 매달 동물 자유 연대에 기부합니다." /></h3>
						<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69696/txt_collection_i_love_pet.png" alt="" /></p>
					</a>
				</div>
				<ul>
					<li class="item1">
						<a href="/shopping/category_prd.asp?itemid=1442347&amp;pEtr=69696">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69696/img_collection_i_love_pet_01.jpg" alt="" />
							<div><span><i>CBC LOGO CHINO CAP (2016VER)</i></span></div>
						</a>
					</li>
					<li class="item2 type1">
						<a href="/shopping/category_prd.asp?itemid=1442359&amp;pEtr=69696">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69696/img_collection_i_love_pet_02.jpg" alt="" />
							<div><span><i>BC DOG I PHONE CASE</i></span></div>
						</a>
					</li>
					<li class="item3">
						<a href="/shopping/category_prd.asp?itemid=1442298&amp;pEtr=69696">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69696/img_collection_i_love_pet_03.jpg" alt="" />
							<div><span><i>COOKIE DOG PATCH SWEAT SHIRT</i></span></div>
						</a>
					</li>
					<li class="item4">
						<a href="/shopping/category_prd.asp?itemid=1442317&amp;pEtr=69696">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69696/img_collection_i_love_pet_04.jpg" alt="" />
							<div><span><i>FRANCE DOG WAPPEN HD (2016VER)</i></span></div>
						</a>
					</li>
					<li class="item5">
						<a href="/shopping/category_prd.asp?itemid=1442303&amp;pEtr=69696">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69696/img_collection_i_love_pet_05.jpg" alt="" />
							<div><span><i>POPCORN DOG PATCH SWEAT SHIRT</i></span></div>
						</a>
					</li>
					<li class="item6">
						<a href="/shopping/category_prd.asp?itemid=1442301&amp;pEtr=69696">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69696/img_collection_i_love_pet_06.jpg" alt="" />
							<div><span><i>RESTAURANT DOG <br />PATCH SWEAT SHIRT</i></span></div>
						</a>
					</li>
				</ul>
			</div>

			<div class="col col3">
				<div class="hgroup">
					<a href="/street/street_brand_sub06.asp?makerid=beyondcloset">
						<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69696/tit_collection_nomantic.png" alt="NOMANTIC Collection label" /></h3>
						<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69696/txt_collection_nomantic.png" alt="비욘드 클로젯은 2008년 디자이너 고태용이 런칭한 브랜드로 새로운 룩을 만들지만 때로는 클래식 또는 기존의 것을 위트있고 다양한 컬러와 패턴으로 재해석합니다" /></p>
					</a>
				</div>
				<ul>
					<li class="item1 type1">
						<a href="/shopping/category_prd.asp?itemid=1433689&amp;pEtr=69696">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69696/img_collection_nomantic_01.jpg" alt="" />
							<div><span><i>NOMANTIC HEART SH</i></span></div>
						</a>
					</li>
					<li class="item2">
						<a href="/shopping/category_prd.asp?itemid=1448288&amp;pEtr=69696">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69696/img_collection_nomantic_02.jpg" alt="" />
							<div><span><i>NOMANTIC KHAKI<br /> LONG JP</i></span></div>
						</a>
					</li>
					<li class="item3">
						<a href="/shopping/category_prd.asp?itemid=1433736&amp;pEtr=69696">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69696/img_collection_nomantic_03.jpg" alt="" />
							<div><span><i>NOMANTIC HEART<br /> LOGO CLUTCH</i></span></div>
						</a>
					</li>
					<li class="item4">
						<a href="/shopping/category_prd.asp?itemid=1433709&amp;pEtr=69696">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69696/img_collection_nomantic_04.jpg" alt="" />
							<div><span><i>NOMANTIC HEART LOGO SWEAT SHIRT</i></span></div>
						</a>
					</li>
				</ul>
			</div>
		</div>

		<%' finish %>
		<div class="finish">
			<a href="/shopping/category_prd.asp?itemid=1453423&amp;pEtr=69696">
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69696/txt_finish.png" alt="옷장을 넘어서, 일상에 스며드는" /></p>
			</a>
		</div>

		<%' comment %>
		<div class="commentevet">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69696/tit_comment.png" alt="Hey, something project 당신이 갖고 싶은 것" /></h3>
			<p class="hidden">Beyond closet의 다음 상품으로 갖고 싶은 디자인이나 컬러를 추천해 주세요 코멘트를 남겨주신 3분을 추첨하여 비욘드클로젯의 맨투맨 상품을 드립니다. 컬러는 랜덤으로 발송됩니다. 코멘트 작성기간은 2016년 3월 23일부터 3월 30일까지며, 발표는 4월 11일 입니다.</p>
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
							<li class="ico1"><button type="button" value="1">COOKIE DOG</button></li>
							<li class="ico2"><button type="button" value="2">CHOCO BOARD DOG</button></li>
							<li class="ico3"><button type="button" value="3">POPCORN DOG</button></li>
							<li class="ico4"><button type="button" value="4">RESTAURANT DOG</button></li>
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
												COOKIE DOG
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="2" then %>
												CHOCO BOARD DOG
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="3" then %>
												POPCORN DOG
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="4" then %>
												RESTAURANT DOG
											<% Else %>
												COOKIE DOG
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
<script type="text/javascript">
$(function(){
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

	/* swipe */
	var swiper1 = new Swiper('.swiper1',{
		centeredSlides:true,
		slidesPerView:"auto",
		loop: true,
		speed:1500,
		autoplay:3000,
		simulateTouch:false,
		pagination:false
	});

	$('.arrow-left').on('click', function(e){
		e.preventDefault()
		swiper1.swipePrev()
	});
	$('.arrow-right').on('click', function(e){
		e.preventDefault()
		swiper1.swipeNext()
	});

	/* animation effect */
	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 1950 ) {
			visaulAnimation()
		}
		if (scrollTop > 3200 ) {
			brandAnimation()
		}
		if (scrollTop > 6400 ) {
			finishAnimation()
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

	/* visaul animation */
	$(".heySomething .visual p").css({"margin-top":"10px", "opacity":"0"});
	function visaulAnimation() {
		$(".heySomething .visual .bg").addClass("image-zoom");
		$(".heySomething .visual .sentence1").delay(800).animate({"margin-top":"0", "opacity":"1"},600);
		$(".heySomething .visual .sentence2").delay(800).animate({"margin-top":"0", "opacity":"1"},600);
		$(".heySomething .visual .sentence3").delay(800).animate({"margin-top":"0", "opacity":"1"},600);
	}

	/* brand animation */
	$(".heySomething .brand .inner .photo").css({"margin-left":"-400px", "opacity":"0"});
	$(".heySomething .brand .inner p").css({"margin-left":"0px", "opacity":"0"});
	$(".heySomething .brand .btnDown").css({"opacity":"0"});
	function brandAnimation() {
		$(".heySomething .brand .inner .photo").delay(50).animate({"margin-left":"-427px", "opacity":"1"},800);
		$(".heySomething .brand .inner p").delay(50).animate({"margin-left":"17px", "opacity":"1"},800);
		$(".heySomething .brand .btnDown").delay(600).animate({"opacity":"1"},1000);
	}

	/* finish animation */
	$(".heySomething .finish p").css({"margin-left":"300px", "opacity":"0"});
	function finishAnimation() {
		$(".heySomething .finish p").delay(50).animate({"margin-left":"293px", "opacity":"1"},1000);
	}
});
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->