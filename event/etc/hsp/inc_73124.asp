<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈 48
' History : 2016-09-20 원승현 생성
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
	eCode   =  66203
Else
	eCode   =  73124
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
.heySomething .topic {background-color:#ebebeb;}
.heySomething .topic h2 {z-index:5;}
.heySomething .topic .figure {position:relative; width:100%; height:780px;}
.heySomething .topic .figure img {position:absolute; top:0; left:50%; margin-left:-950px;}

/* item */
.heySomething .itemB {padding-bottom:313px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/73124/bg_line.png);}
.heySomething .itemB h3 {position:relative; height:129px; text-align:center;}
.heySomething .itemB h3 .horizontalLine1, .heySomething .item h3 .horizontalLine2 {position:absolute; top:63px; width:436px; height:1px; background-color:#ddd;}
.heySomething .itemB h3 .horizontalLine1 {left:0;}
.heySomething .itemB h3 .horizontalLine2 {right:0;}
.heySomething .itemB .desc {min-height:618px; padding-left:484px; padding-bottom:120px;}
.heySomething .itemB .desc .option {z-index:50; height:534px;}
.heySomething .item .option .substance {bottom:99px;}
.heySomething .itemB .slidewrap .slide {width:655px; height:612px;}
.heySomething .itemB .slidewrap .slide .slidesjs-navigation {margin-top:-30px;}
.heySomething .itemB .slidewrap .slide .slidesjs-previous {left:530px;}
.heySomething .itemB .slidesjs-pagination {bottom:-268px;}
.heySomething .itemB .slidesjs-pagination li a {width:217px; height:211px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/73124/btn_pagination_item_v3.jpg);}
.heySomething .itemB .slidesjs-pagination li.num02 a {background-position:-259px 0;}
.heySomething .itemB .slidesjs-pagination li.num03 a {background-position:-515px 0;}
.heySomething .itemB .slidesjs-pagination .num02 a:hover, .heySomething .itemB .slidesjs-pagination .num02 .active {background-position:-259px 100%;}
.heySomething .itemB .slidesjs-pagination .num03 a:hover, .heySomething .itemB .slidesjs-pagination .num03 .active {background-position:-515px 100%;}

@keyframes flip {
	0% {transform:translateZ(0) rotateY(0); animation-timing-function:ease-out;}
	40% {transform:translateZ(150px) rotateY(170deg); animation-timing-function:ease-out;}
	50% {transform:translateZ(150px) rotateY(190deg); animation-timing-function:ease-in;}
	80% {transform:translateZ(0) rotateY(360deg); animation-timing-function:ease-in;}
	100% {transform:translateZ(0) rotateY(360deg); animation-timing-function:ease-in;}
}
.flip {animation-name:flip; animation-duration:2s; animation-iteration-count:1; backface-visibility:visible;}

/* visual */
.heySomething .visual {margin-top:498px; padding-bottom:0;}
.heySomething .visual .figure {overflow:hidden; position:relative; height:988px; background-color:#f4f4f6;}
.heySomething .visual .figure img {position:absolute; top:0; left:50%; margin-left:-951px;}

/* brand */
.heySomething .brand {position:relative; height:958px; margin-top:500px;}
.heySomething .brand p {position:absolute; top:107px; left:50%; z-index:20; margin-left:-570px;}
.heySomething .brand .slide {overflow:hidden; position:relative; height:789px; text-align:center;}
.heySomething .brand .slide .slidesjs-container, .heySomething .brand .slide .slidesjs-control {overflow:hidden; height:789px !important;}
.heySomething .brand .slide .slidesjs-slide {position:relative; width:100%; height:789px; !important; background:#f4f4f4 url(http://webimage.10x10.co.kr/eventIMG/2016/hey/73124/img_slide_brand_01.jpg) no-repeat 50% 0;}
.heySomething .brand .slide .slidesjs-slide a {display:block; width:100%; height:789px;}
.heySomething .brand .slide .slidesjs-slide-02 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/73124/img_slide_brand_02.jpg);}
.heySomething .brand .slide .slidesjs-slide-03 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/73124/img_slide_brand_03.jpg);}
.heySomething .brand .slide .slidesjs-slide-04 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/73124/img_slide_brand_04.jpg);}
.heySomething .brand .slide .slidesjs-slide img {position:absolute; top:0; left:50%; margin-left:-960px;}

/* story */
.heySomething .story {margin-top:500px; padding-bottom:120px;}
.heySomething .story h3 {margin-bottom:63px;}
.heySomething .rolling {padding-top:206px;}
.heySomething .rolling .pagination {top:0; width:760px; margin-left:-380px;}
.heySomething .rolling .swiper-pagination-switch {width:144px; height:145px; margin:0 23px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/73124/btn_pagination_story.png);}
.heySomething .rolling .pagination span.swiper-active-switch {background-position:0 100%;}
.heySomething .rolling .pagination span:first-child + span {background-position:-191px 0;}
.heySomething .rolling .pagination span:first-child + span.swiper-active-switch {background-position:-191px 100%;}
.heySomething .rolling .pagination span:first-child + span + span {background-position:-383px 0;}
.heySomething .rolling .pagination span:first-child + span + span.swiper-active-switch {background-position:-383px 100%;}
.heySomething .rolling .pagination span:first-child + span + span + span {background-position:100% 0;}
.heySomething .rolling .pagination span:first-child + span + span + span.swiper-active-switch {background-position:100% 100%;}
.heySomething .rolling .pagination span em {bottom:-811px; left:50%;height:120px; width:980px; margin-left:-490px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/73124/txt_story_desc.png); cursor:default;}
.heySomething .rolling .pagination span .desc2 {background-position:0 -120px;}
.heySomething .rolling .pagination span .desc3 {background-position:0 -240px;}
.heySomething .rolling .pagination span .desc4 {background-position:0 -360px;}
.heySomething .rolling .btn-nav {top:516px;}
.heySomething .swipemask {top:206px;}
.heySomething .mask-left {margin-left:-1470px;}
.heySomething .mask-right {margin-left:490px;}

/* gallery */
.gallery {margin-top:500px; text-align:center;}

/* finish */
.heySomething .finish {background-color:#f4f1ea; height:688px; margin-top:400px;}
.heySomething .finish p {top:263px; margin-left:-583px;}
.heySomething .finish .figure {position:absolute; top:0; left:50%; margin-left:-950px;}

/* comment */
.heySomething .commentevet {margin-top:500px;}
.heySomething .commentevet .form {margin-top:25px;}
.heySomething .commentevet .form .choice li {width:118px; height:145px; margin-right:26px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/73124/img_ico.png); background-position:0 0;}
.heySomething .commentevet .form .choice li.ico1 button.on {background-position:0 100%;}
.heySomething .commentevet .form .choice li.ico2 button {background-position:-145px 0;}
.heySomething .commentevet .form .choice li.ico2 button.on {background-position:-145px 100%;}
.heySomething .commentevet .form .choice li.ico3 button {background-position:-290px 0;}
.heySomething .commentevet .form .choice li.ico3 button.on {background-position:-290px 100%;}
.heySomething .commentevet .form .choice li.ico4 button {background-position:100% 0;}
.heySomething .commentevet .form .choice li.ico4 button.on {background-position:100% 100%;}

.heySomething .commentevet textarea {margin-top:25px;}

.heySomething .commentlist table td strong {width:118px; height:145px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/73124/img_ico.png); background-position:0 0;}
.heySomething .commentlist table td strong.ico2 {background-position:-145px 0;}
.heySomething .commentlist table td strong.ico3 {background-position:-290px 0;}
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
		<% If not( left(currenttime,10) >= "2016-09-21" and left(currenttime,10) < "2016-09-28" ) Then %>
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
				<a href="/shopping/category_prd.asp?itemid=1540234&pEtr=73124"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73124/img_item_represent.jpg" alt="클라이네자케 올인원 파우치 SUM Rose red" /></a>
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
						itemid = 1540234
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
				%>
				<h3>
					<span class="logo"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73124/img_logo_kleinesache.png" alt="KLEINESACHE" /></span>
					<span class="horizontalLine1"></span>
					<span class="horizontalLine2"></span>
				</h3>
				<div class="desc">
					<%' 상품 이름, 가격, 구매하기 %>
					<div class="option">
						<em class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73124/txt_name_v1.png" alt="클라이네자케 올인원 파우치 SUM Rose Red, 버건디" /></em>
						<%' for dev msg : 상품코드 1540234 할인기간 9/21~9/27 할인기간이 지나면 <strong class="discount">...</strong> 숨겨주세요 %>
						<% If oItem.FResultCount > 0 Then %>
							<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
								<div class="price">
								<% If not( left(currenttime,10)>="2016-09-21" and left(currenttime,10)<"2016-09-28" ) Then %>
								<% Else %>
									<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/txt_only_10percent.png" alt="단, 일주일만 ONLY10%" /></strong>
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
						<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73124/txt_substance.png" alt="매일 나와 함께하는 지갑, 스마트폰, 차키, 이어폰 등 그 모든 것들을 이 파우치 하나로! 당신을 위한 세심한 배려를 확인해보세요. SUM은 iPhone 6, 6S, SUM+는 iPhone 6Plus, 6S Plus, GALAXY NOTE, LG G5" /></p>
						<div class="btnget"><a href="/shopping/category_prd.asp?itemid=1540234&pEtr=73124"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="클라이네자케 올인원 파우치 SUM Rose red 구매하러 가기" /></a></div>
					</div>
				<% set oItem = nothing %>

					<%' slide %>
					<div class="slidewrap">
						<div id="slide01" class="slide">
							<div><a href="/shopping/category_prd.asp?itemid=1540234&pEtr=73124"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73124/img_slide_item_01.jpg" alt="올인원 파우치 썸 로즈레드" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1540234&pEtr=73124"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73124/img_slide_item_02_v1.jpg" alt="올인원 파우치 썸 버건디" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1540234&pEtr=73124"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73124/img_slide_item_03.jpg" alt="" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1540234&pEtr=73124"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73124/img_slide_item_04_v1.jpg" alt="" /></a></div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<%' visual %>
		<div class="visual">
			<div class="figure"><a href="/shopping/category_prd.asp?itemid=1540234&pEtr=73124"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73124/img_item_visual_big.jpg" alt="" /></a></div>
		</div>

		<%' brand %>
		<div class="brand">
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73124/txt_brand.png" alt="우리는 많은 작은 물건들을 가지고 다닙니다. 때로는 우리를 귀찮게 하는 것들 말이죠. 사실, 생각해보면 매일 사용하는 것들은 정말 작은 물건들인데 말이죠. 우리는 자주 떨어뜨리게 되고, 깜빡하기 쉬운 매일 필요한 소품들을 하나로 묶을 파우치를 만들었습니다. 손에 쥐었을 때, 그립감이 좋고 시선을 방해하지 않는 심플함, 스스로 자리 잡는 탄탄함을 전달하고 싶었습니다. 우리는 이 파우치로 작은 소품들과 함께하는 당신의 일상이 좀 더 멋져지길 기대합니다." /></p>
			<div id="slide02" class="slide">
				<div class="slidesjs-slide-01"><a href="/shopping/category_prd.asp?itemid=1540234&pEtr=73124" title="썸플러스 SUM, SUM+ 2color 보러가기"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73124/img_white.png" alt="" /></a></div>
				<div class="slidesjs-slide-02"><a href="/shopping/category_prd.asp?itemid=1540234&pEtr=73124"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73124/img_white.png" alt="" /></a></div>
				<div class="slidesjs-slide-03"><a href="/shopping/category_prd.asp?itemid=1540234&pEtr=73124"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73124/img_white.png" alt="" /></a></div>
				<div class="slidesjs-slide-04"><a href="/shopping/category_prd.asp?itemid=1540234&pEtr=73124"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73124/img_white.png" alt="" /></a></div>
			</div>
			<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="" /></div>
		</div>

		<%' story %>
		<div class="story">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73124/tit_story.png" alt="나의 모든 일상과 함께하는 파우치" /></h3>
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
									<a href="/shopping/category_prd.asp?itemid=1540234&pEtr=73124" title="썸플러스 SUM, SUM+ 2color 보러가기"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73124/img_slide_story_01.jpg" alt="#WORK 지갑과 펜 케이스가 만나다!  간단한 필기구부터, 체크리스트, 카드 수납까지! 올인원 파우치에 쏙!" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1540234&pEtr=73124"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73124/img_slide_story_02.jpg" alt="#DAILY 스마트폰 시대에 꼭 필요한 데일리 아이템 보조배터리, 이어폰, 연결선 까지 쏙 들어가는 사이즈" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1540234&pEtr=73124"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73124/img_slide_story_03.jpg" alt="#MAKE-UP 메이크업파우치 따로, 폰 파우치 따로는 이제 그만! 매일 쓰는 필수품들만 넣어다니세요." /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1540234&pEtr=73124"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73124/img_slide_story_04.jpg" alt="#FOR MAN 심플한 디자인으로, 내 남자친구 선물로도 딱! 한손에 쏙 들어오는 사이즈로, 그를 위해 센스를 보여주세요." /></a>
								</div>
							</div>
						</div>
					</div>
					<div class="pagination"></div>
				</div>
			</div>
		</div>

		<%' gallery %>
		<div class="gallery">
			<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73124/img_gallery.jpg" alt="" />
		</div>

		<%' finish %>
		<div class="finish">
			<a href="/shopping/category_prd.asp?itemid=1540234&pEtr=73124">
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73124/txt_finish.png" alt="매일 내 일상에 함께하는 작은 물건들 그 물건들을 하나로 묶어주는 똑똑한 파우치, KLEINE SACHE" /></p>
				<div class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73124/img_finish.jpg" alt="" /></div>
			</a>
		</div>

		<%' comment %>
		<div class="commentevet">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73124/tit_comment.png" alt="Hey, something project 당신이 갖고 싶은 것" /></h3>
			<p class="hidden">정성껏 코멘트를 남겨주신 3분을 추첨하여 클라이네자케 SUM 제품을 선물로 드립니다. 색상 랜덤이며, 코멘트 작성기간은 2016년 9월 21일부터 9월 27일까지며, 발표는 9월 29일 입니다.</p>

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
					<legend>클라이네자케 SUM 코멘트 쓰기</legend>
						<ul class="choice">
							<li class="ico1"><button type="button" value="1">WORK</button></li>
							<li class="ico2"><button type="button" value="2">DAILY</button></li>
							<li class="ico3"><button type="button" value="3">MAKE-UP</button></li>
							<li class="ico4"><button type="button" value="4">FOR MAN</button></li>
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
										WORK
									<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="2" Then %>
										DAILY
									<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="3" Then %>
										MAKE-UP
									<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="4" Then %>
										FOR MAN
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
		width:"655",
		height:"612",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:2500, effect:"fade", auto:true},
		effect:{fade: {speed:2000, crossfade:true}}
	});

	$("#slide02").slidesjs({
		width:"1140",
		height:"789",
		pagination:false,
		navigation:false,
		play:{interval:1800, effect:"fade", auto:true},
		effect:{fade: {speed:700}}
	});

	//mouse control
	$('#slide01 .slidesjs-pagination > li a').mouseenter(function(){
		$('a[data-slidesjs-item="' + $(this).attr("data-slidesjs-item") + '"]').trigger('click');
	});

	$("#slide01 .slidesjs-pagination li:nth-child(1)").addClass("num01");
	$("#slide01 .slidesjs-pagination li:nth-child(2)").addClass("num02");
	$("#slide01 .slidesjs-pagination li:nth-child(3)").addClass("num03");
	$("#slide01 .slidesjs-pagination li:nth-child(4)").addClass("num04");

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
		if (scrollTop > 900 ) {
			$(".heySomething .item h3 .logo img").addClass("flip");
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