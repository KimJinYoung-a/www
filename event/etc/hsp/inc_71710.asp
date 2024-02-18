<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈 39
' History : 2016-07-05 김진영 생성
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
	eCode   =  66166
Else
	eCode   =  71710
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
.heySomething .topic {background-color:#85dae2;}
.heySomething .topic h2 {z-index:5;}
.heySomething .topic .figure a {display:block; position:relative; width:100%; height:780px;}
.heySomething .topic .figure img {position:absolute; top:0; left:50%; margin-left:-951px;}

/* item */
.heySomething .itemB {padding-bottom:390px;}
.heySomething .itemB .desc {padding-left:625px;}
.heySomething .itemB .desc .option {top:108px;}
.heySomething .slidewrap {width:360px; padding-top:90px;}
.heySomething .itemB .slidewrap .slide {width:360px; height:432px;}
.heySomething .itemB .slidesjs-pagination {bottom:-336px;}
.heySomething .slidesjs-pagination li a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/71710/bg_pagination.jpg);}
.heySomething .itemB .slidewrap .slide .slidesjs-previous {left:470px;}

/* feature */
.heySomething .feature {position:relative; height:937px; margin-top:395px; background:#01b2f0 url(http://webimage.10x10.co.kr/eventIMG/2016/hey/71710/img_visual.jpg) 50% 0 no-repeat;}
.heySomething .feature p {position:absolute; left:50%; z-index:30;}
.heySomething .feature .f01 {top:190px; margin-left:200px;}
.heySomething .feature .f02 {top:400px; margin-left:275px;}
.heySomething .feature .f03 {top:610px; margin-left:350px;}

/* brand */
.heySomething .brand { height:605px;}
.heySomething .brand .inner {position:relative; width:800px; height:530px; margin:0 auto;}
.heySomething .brand .pic {position:absolute; top:0; left:0;}
.heySomething .brand .txt {position:absolute; top:0; right:0;}
.heySomething .brand .btnDown {margin-top:0;}

/* story */
.heySomething .yourStyle {padding-top:412px; text-align:center;}
.heySomething .story {margin-top:345px; padding-bottom:0;}
.heySomething .story h3 {margin-bottom:0;}
.heySomething .rolling {margin-top:67px; padding-top:240px; padding-bottom:120px;}
.heySomething .rolling .pagination {top:0; width:880px; margin-left:-440px;}
.heySomething .rolling .pagination .swiper-pagination-switch {width:150px; height:180px; margin:0 35px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/71710/ico_01.jpg) no-repeat 0 0;}
.heySomething .rolling .pagination span.swiper-active-switch {background-position:0 -180px;}
.heySomething .rolling .pagination span:first-child + span {background-position:-150px 0;}
.heySomething .rolling .pagination span:first-child + span.swiper-active-switch {background-position:-150px -180px;}
.heySomething .rolling .pagination span:first-child + span + span {background-position:-300px 0;}
.heySomething .rolling .pagination span:first-child + span + span.swiper-active-switch {background-position:-300px -180px;}
.heySomething .rolling .pagination span:first-child + span + span + span {background-position:-450px 0;}
.heySomething .rolling .pagination span:first-child + span + span + span.swiper-active-switch {background-position:-450px -180px;}
.heySomething .rolling .pagination span em {bottom:-810px; left:50%;height:120px; width:980px; margin-left:-490px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/71710/txt_story_desc.png); cursor:default;}
.heySomething .rolling .btn-nav {top:523px;}
.heySomething .swipemask {top:240px;}

/* finish */
.heySomething .beyondCollection {width:1140px; margin:0 auto; padding-top:360px; text-align:center;}
.heySomething .beyondCollection ul {position:relative; width:1140px; height:678px; margin-top:70px;}
.heySomething .beyondCollection li {position:absolute; width:216px; height:216px;}
.heySomething .beyondCollection li a {overflow:hidden; position:relative; display:block; width:100%; height:100%; background-position:50% 50%; background-repeat:no-repeat; background-size:115%;}
.heySomething .beyondCollection li a:after {content:''; display:inline-block; position:absolute; left:50%; bottom:70px; width:0; height:1px; background:#fff; transition:all .4s .2s;}
.heySomething .beyondCollection li a:hover:after {width:40px; margin-left:-20px;}
.heySomething .beyondCollection li a:hover {background-size:115%;}
.heySomething .beyondCollection li a div {display:none; position:absolute; left:0; top:0; width:100%; height:100%;}
.heySomething .beyondCollection li a p {display:table; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/71710/bg_mask.png) 0 0 repeat;}
.heySomething .beyondCollection li a span {display:table-cell; width:100%; vertical-align:middle; color:#fff; font-family:'Nanum Gothic', sans-serif; font-size:15px; text-shadow:0 2px 2px #000; letter-spacing:0.025em;}
.heySomething .beyondCollection li.item01 {left:0; top:0; background:#ddc8c7;}
.heySomething .beyondCollection li.item02 {left:230px; top:0; background:#ffe18c;}
.heySomething .beyondCollection li.item03 {left:460px; top:0; width:445px; background:#f3f1f2;}
.heySomething .beyondCollection li.item04 {right:0; top:0; background:#0395dc;}
.heySomething .beyondCollection li.item05 {left:0; top:230px; background:#0395dc;}
.heySomething .beyondCollection li.item06 {left:230px; top:230px; background:#f3f1f2;}
.heySomething .beyondCollection li.item07 {left:460px; top:230px; background:#ebd6d5}
.heySomething .beyondCollection li.item08 {right:0; top:230px; width:447px; height:447px; background:#ffe18c;}
.heySomething .beyondCollection li.item09 {left:0; bottom:0; width:445px; background:#f9f3f4;}
.heySomething .beyondCollection li.item10 {left:460px; bottom:0; background:#0395dc;}
.heySomething .beyondCollection li.item01 a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/71710/img_item_01.jpg);}
.heySomething .beyondCollection li.item02 a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/71710/img_item_02.jpg);}
.heySomething .beyondCollection li.item03 a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/71710/img_item_03.jpg);}
.heySomething .beyondCollection li.item04 a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/71710/img_item_04.jpg);}
.heySomething .beyondCollection li.item05 a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/71710/img_item_05.jpg);}
.heySomething .beyondCollection li.item06 a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/71710/img_item_06.jpg);}
.heySomething .beyondCollection li.item07 a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/71710/img_item_07.jpg);}
.heySomething .beyondCollection li.item08 a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/71710/img_item_08.jpg);}
.heySomething .beyondCollection li.item09 a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/71710/img_item_09.jpg);}
.heySomething .beyondCollection li.item10 a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/71710/img_item_10.jpg);}
.heySomething .beyondCollection li.item08 a:after {bottom:197px;}

/* comment */
.heySomething .commentevet .form {margin-top:40px;}
.heySomething .commentevet .form .choice li {margin-right:25px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/71710/ico_02.jpg);}
.heySomething .commentevet textarea {margin-top:50px;}
.heySomething .commentlist table td {padding:15px 0;}
.heySomething .commentlist table td strong {height:143px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/71710/ico_02.jpg); background-position:0 0;}
.heySomething .commentlist table td .ico2 {background-position:-150px 0;}
.heySomething .commentlist table td .ico3 {background-position:-300px 0;}
.heySomething .commentlist table td .ico4 {background-position:-450px 0;}
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
		<% If not( left(currenttime,10) >= "2016-07-05" and left(currenttime,10) <= "2016-07-12" ) Then %>
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
				<a href="/shopping/category_prd.asp?itemid=1523830&amp;pEtr=71710"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71710/img_item_represent.jpg" alt="Finding Dory" /></a>
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
				<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71710/tit_beyond_10x10.png" alt="beyond closet X 10X10" /></h3>
			<%
				IF application("Svr_Info") = "Dev" THEN
					itemid = 1239226
				Else
					itemid = 1523830
				End If
				set oItem = new CatePrdCls
					oItem.GetItemData itemid
			%>
				<div class="desc">
					<div class="option">
						<em class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71710/txt_name.png" alt="PREPPY LOGO PATCH VEST (2colors)" /></em>
				<%' for dev msg : 상품코드 1523830, 할인기간 7/6 ~ 7/12 할인기간이 지나면  <strong class="discount">...</strong> 숨겨주세요 %>
				<% If oItem.FResultCount > 0 Then %>
					<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
						<div class="price">
						<% If not( left(currenttime,10)>="2016-07-06" and left(currenttime,10)<="2016-07-12" ) Then %>
						<% Else %>
							<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/txt_only_10percent.png" alt="단, 일주일만 ONLY 10%" /></strong>
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
						<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71710/txt_substance.png" alt="텐바이텐 온라인 단독 상품인 비욘드클로젯의 베이직 로고 베스트입니다. YELLOW,RED 두 색상으로 기존의 로고 베스트와 다른 느낌을 연출 할 수 있습니다. 온라인! 오직 텐바이텐에서만 만나보세요" /></p>
						<div class="btnget">
							<a href="/shopping/category_prd.asp?itemid=1523830&amp;pEtr=71710"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러 가기" /></a>
						</div>
					</div>
			<% set oItem = nothing %>
					<div class="slidewrap">
						<div id="slide01" class="slide">
							<div><a href="/shopping/category_prd.asp?itemid=1523830&amp;pEtr=71710"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71710/img_slide_item_01.jpg" alt="" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1523830&amp;pEtr=71710"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71710/img_slide_item_02.jpg" alt="" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1523830&amp;pEtr=71710"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71710/img_slide_item_03.jpg" alt="" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1523830&amp;pEtr=71710"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71710/img_slide_item_04.jpg" alt="" /></a></div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<%' feature %>
		<div class="feature">
			<p class="f01"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71710/txt_feature_01.png" alt="온라인에서는 오직 텐바이텐에서만 만나 볼 수 있는 상품으로 유니크합니다." /></p>
			<p class="f02"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71710/txt_feature_02.png" alt="고밀도 원단으로 세탁 시 수축을 최소화하여 오래도록 착용이 가능합니다." /></p>
			<p class="f03"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71710/txt_feature_03.png" alt="반팔, 긴팔, 셔츠 등을 레이어드하여 여러가지 스타일을 연출할 수 있습니다." /></p>
		</div>
		<%' brand %>
		<div class="brand">
			<div class="inner">
				<div class="pic"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71710/img_brand.jpg" alt=""></div>
				<p class="txt"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71710/txt_brand.png" alt="비욘드 클로젯은 옷장을 넘어서란 의미를 가지고 있습니다. 옷장은 그 사람의 성격, 감성, 라이프스타일을 엿볼 수 있는 공간이라고 생각합니다. 나이와 상관없이 옷을 사랑하는 누구나 입을 수 있는 옷 이라는 슬로건을 가지고 비욘드 클로젯만의 스타일을 만듭니다. 컬렉션 라인인 beyondcloset과 세컨레이블인 beyondcloset campaign을 전개합니다."></p>
			</div>
			<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="" /></div>
		</div>
		<%' story %>
		<div class="yourStyle"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71710/img_phone.jpg" alt="YOUR STYLE" /></div>
		<div class="story">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71710/txt_story.png" alt="DAILY STYLING with BEYONDCLOSET" /></h3>
			<div class="rolling">
				<div class="swipemask mask-left"></div>
				<div class="swipemask mask-right"></div>
				<button type="button" class="btn-nav arrow-left">Previous</button>
				<button type="button" class="btn-nav arrow-right">Next</button>
				<div class="swiper">
					<div class="swiper-container swiper1">
						<div class="swiper-wrapper">
							<div class="swiper-slide">
								<a href="/shopping/category_prd.asp?itemid=1523830&amp;pEtr=71710"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71710/img_slide_story_01.jpg" alt="#GIRLISH" /></a>
							</div>
							<div class="swiper-slide">
								<a href="/shopping/category_prd.asp?itemid=1523830&amp;pEtr=71710"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71710/img_slide_story_02.jpg" alt="#CASUAL" /></a>
							</div>
							<div class="swiper-slide">
								<a href="/shopping/category_prd.asp?itemid=1523830&amp;pEtr=71710"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71710/img_slide_story_03.jpg" alt="#SPORTY" /></a>
							</div>
							<div class="swiper-slide">
								<a href="/shopping/category_prd.asp?itemid=1523830&amp;pEtr=71710"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71710/img_slide_story_04.jpg" alt="#COUPLE&amp;TWIN" /></a>
							</div>
						</div>
					</div>
				</div>
				<div class="pagination"></div>
			</div>
		</div>
		<%' finish %>
		<div class="beyondCollection">
			<div><a href="https://www.instagram.com/your10x10_style/" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71710/img_beyond_instagram.png" alt="텐바이텐 인스타그램 바로가기" /></a></div>
			<ul>
				<li class="item01"><a href="/shopping/category_prd.asp?itemid=1515432&amp;pEtr=71710"><div><p><span>TROPICAL DOG PRINT<br />1/2 TS INDI PINK</span></p></div></a></li>
				<li class="item02"><a href="/shopping/category_prd.asp?itemid=1509892&amp;pEtr=71710"><div><p><span>PREPPY LOGO STRIPE<br />12 TS INDI PINK</span></p></div></a></li>
				<li class="item03"><a href="/shopping/category_prd.asp?itemid=1519386&amp;pEtr=71710"><div><p><span>NOMANTIC HEART LOGO SLEEVELESS WHITE</span></p></div></a></li>
				<li class="item04"><a href="/shopping/category_prd.asp?itemid=1484607&amp;pEtr=71710"><div><p><span>PREPPY LOGO 1/2<br />SWEAT SHIRT YELLOW</span></p></div></a></li>
				<li class="item05"><a href="/shopping/category_prd.asp?itemid=1482788&amp;pEtr=71710"><div><p><span>NEW APOLLO DOG SOCKS</span></p></div></a></li>
				<li class="item06"><a href="/shopping/category_prd.asp?itemid=1476919&amp;pEtr=71710"><div><p><span>PREPPY LOGO PATCH<br />VEST NAVY</span></p></div></a></li>
				<li class="item07"><a href="/shopping/category_prd.asp?itemid=1490770&amp;pEtr=71710"><div><p><span>JOHN-MUSIC DOG<br />I PHONE6 & 6S INDI PINK</span></p></div></a></li>
				<li class="item08"><a href="/street/street_brand_sub06.asp?makerid=beyondcloset"><div><p><span style="font-size:20px;">BEYOND CLOSET</span></p></div></a></li>
				<li class="item09"><a href="/shopping/category_prd.asp?itemid=1523830&amp;pEtr=71710"><div><p><span>PREPPY LOGO PATCH VEST WHITE (2colors)</span></p></div></a></li>
				<li class="item10"><a href="/shopping/category_prd.asp?itemid=1490823&amp;pEtr=71710"><div><p><span>ICE CREAM DOG 1/2 TS [NEON SIGN LINE] WHITE</span></p></div></a></li>
			</ul>
		</div>
		<%' comment %>
		<div class="commentevet">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71710/tit_comment.png" alt="Hey, something project 당신이 좋아하는 스타일" /></h3>
			<p class="hidden">당신이 가장 입고 싶은 스타일은 무엇인가요? 그 이유를 코멘트로 남겨주세요. 코멘트를 남겨주신 5분을 추첨하여 비욘드클로젯의 핸드폰 케이스를 드립니다.(랜덤증정)</p>
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
							<li class="ico1"><button type="button" value="1">GIRLISH</button></li>
							<li class="ico2"><button type="button" value="2">CASUAL</button></li>
							<li class="ico3"><button type="button" value="3">SPORTY</button></li>
							<li class="ico4"><button type="button" value="4">COUPLE&amp;TWIN</button></li>
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
										GIRLISH
									<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="2" Then %>
										CASUAL
									<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="3" Then %>
										SPORTY
									<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="4" Then %>
										COUPLE&amp;TWIN
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
	/* slide js */
	$("#slide01").slidesjs({
		width:"360",
		height:"432",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:2500, effect:"fade", auto:true},
		effect:{fade: {speed:900, crossfade:true}
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
	$(".slidesjs-pagination li:nth-child(1)").addClass("num01");
	$(".slidesjs-pagination li:nth-child(2)").addClass("num02");
	$(".slidesjs-pagination li:nth-child(3)").addClass("num03");
	$(".slidesjs-pagination li:nth-child(4)").addClass("num04");

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

	$(".beyondCollection li a").css({"opacity":"0"});
	$('div.beyondCollection ul li a').mouseover(function(){
		$(this).children('div').fadeIn();
	});
	$('div.beyondCollection ul li a').mouseleave(function(){
		$(this).children('div').fadeOut();
	});
	/* animation effect */
	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 2600 ) {
			featureAnimation();
		}
		if (scrollTop > 3600 ) {
			brand();
		}
		if (scrollTop > 7500 ) {
			$(".beyondCollection li.item01 a,.beyondCollection li.item03 a").animate({backgroundSize:'100%', "opacity":"1"},1000);
			$(".beyondCollection li.item02 a,.beyondCollection li.item04 a").delay(400).animate({backgroundSize:'100%', "opacity":"1"},1000);
			$(".beyondCollection li.item05 a,.beyondCollection li.item08 a").delay(600).animate({backgroundSize:'100%', "opacity":"1"},1000);
			$(".beyondCollection li.item06 a,.beyondCollection li.item10 a").delay(200).animate({backgroundSize:'100%', "opacity":"1"},1000);
			$(".beyondCollection li.item07 a,.beyondCollection li.item09 a").delay(800).animate({backgroundSize:'100%', "opacity":"1"},1000);
		}
	});

	/* title */
	titleAnimation()
	$(".heySomething .topic h2 span").css({"width":"50px", "opacity":"0"});
	function titleAnimation() {
		$(".heySomething .topic h2 .letter1").delay(100).animate({"width":"125px", "opacity":"1"},1200);
		$(".heySomething .topic h2 .letter2").delay(300).animate({"width":"349px", "opacity":"1"},1200);
		$(".heySomething .topic h2 .letter3").delay(500).animate({"width":"206px", "opacity":"1"},1200);
	}

	/* feature */
	$(".heySomething .feature p").css({"left":"49%", "opacity":"0"});
	function featureAnimation() {
		$(".heySomething .feature .f01").delay(100).animate({"left":"50%", "opacity":"1"},900);
		$(".heySomething .feature .f02").delay(500).animate({"left":"50%", "opacity":"1"},900);
		$(".heySomething .feature .f03").delay(800).animate({"left":"50%", "opacity":"1"},900);
	}

	/* brand */
	$(".heySomething .brand .pic").css({"left":"-40px", "opacity":"0"});
	$(".heySomething .brand .txt").css({"right":"-40px", "opacity":"0"});
	$(".heySomething .brand .btnDown").css({"opacity":"0"});
	function brand() {
		$(".heySomething .brand .pic").delay(50).animate({"left":"0", "opacity":"1"},1000);
		$(".heySomething .brand .txt").delay(50).animate({"right":"0", "opacity":"1"},1000);
		$(".heySomething .brand .btnDown").delay(700).animate({"opacity":"1"},1000);
	}

});
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->