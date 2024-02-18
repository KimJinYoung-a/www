<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈 45
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
	eCode   =  66185
Else
	eCode   =  72508
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
.heySomething .topic {background-color:#ffe2d7;}
.heySomething .topic h2 {z-index:5;}
.heySomething .topic .figure a {display:block; position:relative; width:100%; height:780px;}
.heySomething .topic .figure img {position:absolute; top:0; left:50%; margin-left:-951px;}

/* item */
.heySomething .itemA h3 {margin-bottom:100px;}
.heySomething .itemA .desc {position:relative; min-height:445px; padding-top:0;}
.heySomething .itemA .desc .option {position:absolute; left:80px; top:-40px; width:380px; height:480px;}
.heySomething .itemA .with ul {width:1140px; padding:140px 0 85px 30px;}
.heySomething .itemA .with ul li {width:140px; padding:0 20px;}
.heySomething .itemA .slide {overflow:visible !important; width:1056px; height:445px;}
.heySomething .itemA .slidewrap .slide .slidesjs-navigation {position:absolute; z-index:60; top:170px; width:21px; height:37px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_nav_grey.png) no-repeat 0 0; text-indent:-999em;}
.heySomething .itemA .slidewrap .slide .slidesjs-previous {left:455px;}
.heySomething .itemA .slidewrap .slide .slidesjs-next {right:0px; background-position:100% 0;}
.heySomething .itemA .slide .itemImage {padding-left:574px;}
.heySomething .itemA .slide .goBuy {display:block; position:absolute; left:0; bottom:-20px; z-index:40; width:204px; height:38px; text-indent:-999em;}

/* brand */
.heySomething .visual {margin-top:400px; text-align:center;}
.heySomething .brand {position:relative; height:825px; margin-top:360px;}
.heySomething .brand .image {position:relative; width:770px; height:132px; margin:94px auto 60px;}
.heySomething .brand .image span {position:absolute; top:0;}
.heySomething .brand .image .i01 {left:0;}
.heySomething .brand .image .i02 {left:194px;}
.heySomething .brand .image .i03 {left:387px;}
.heySomething .brand .image .i04 {left:585px;}
.heySomething .brand .txt p {position:relative; margin-bottom:33px;}
.heySomething .brand .btnDown {margin-top:85px;}

/* another item */
.heySomething .anotherIitem {margin-top:445px;}
.heySomething .anotherIitem .image {text-align:center;}
.heySomething .anotherIitem #slider {height:241px; margin-top:110px; text-align:left;}
.heySomething .anotherIitem #slider .slide-img {width:180px; height:241px; margin:0 30px; cursor:pointer;}

/* story */
.heySomething .story {margin-top:400px; padding-bottom:0;}
.heySomething .story h3 {margin-bottom:0;}
.heySomething .rolling {margin-top:70px; padding-top:215px; padding-bottom:120px;}
.heySomething .rolling .pagination {top:0; width:760px; margin-left:-380px;}
.heySomething .rolling .pagination .swiper-pagination-switch {width:150px; height:180px; margin:0 20px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/72508/bg_ico_01.jpg) no-repeat 0 0;}
.heySomething .rolling .pagination span.swiper-active-switch {background-position:0 -180px;}
.heySomething .rolling .pagination span:first-child + span {background-position:-150px 0;}
.heySomething .rolling .pagination span:first-child + span.swiper-active-switch {background-position:-150px -180px;}
.heySomething .rolling .pagination span:first-child + span + span {background-position:-300px 0;}
.heySomething .rolling .pagination span:first-child + span + span.swiper-active-switch {background-position:-300px -180px;}
.heySomething .rolling .pagination span:first-child + span + span + span {background-position:-450px 0;}
.heySomething .rolling .pagination span:first-child + span + span + span.swiper-active-switch {background-position:-450px -180px;}
.heySomething .rolling .pagination span em {bottom:-792px; left:50%;height:120px; width:980px; margin-left:-490px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/72508/txt_story_desc.png); cursor:default;}
.heySomething .swipemask {top:215px;}

/* finish */
.heySomething .finish {background-color:#f3dec8; height:689px; margin-top:360px;}
.heySomething .finish .figure {position:absolute; top:0; left:50%; margin-left:-951px;}
.heySomething .finish .txt span {position:absolute; left:50%; margin-left:-497px; z-index:40;}
.heySomething .finish .txt .t01 {top:306px;}
.heySomething .finish .txt .t02 {top:356px;}

/* comment */
.heySomething .commentevet .form {margin-top:40px;}
.heySomething .commentevet .form .choice li {margin-right:0;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/72508/bg_ico_02.jpg);}
.heySomething .commentevet textarea {margin-top:50px;}
.heySomething .commentlist table td {padding:10px 0;}
.heySomething .commentlist table td strong {height:150px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/72508/bg_ico_02.jpg) 0 0 no-repeat;}
.heySomething .commentlist table td .ico2 {background-position:-150px 0;}
.heySomething .commentlist table td .ico3 {background-position:-300px 0;}
.heySomething .commentlist table td .ico4 {background-position:-450px 0;}

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
		<% If not( left(currenttime,10) >= "2016-08-23" and left(currenttime,10) <= "2016-08-30" ) Then %>
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
				<a href="/shopping/category_prd.asp?itemid=1544313&amp;pEtr=72508"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72508/img_item_represent.jpg" alt="Rifle Paper" /></a>
			</div>
		</div>
		<%' about %>
		<div class="about">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
			<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
		</div>
		<%' brand %>
		<div class="brand">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72508/txt_brand.png" alt="Rifle Paper" /></h3>
			<div class="image">
				<span class="i01"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72508/img_brand_01.jpg" alt="" /></span>
				<span class="i02"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72508/img_brand_02.jpg" alt="" /></span>
				<span class="i03"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72508/img_brand_03.jpg" alt="" /></span>
				<span class="i04"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72508/img_brand_04.jpg" alt="" /></span>
			</div>
			<div class="txt">
				<p class="t01"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72508/txt_brand_01.png" alt="Rifle Paper는 미국 플로리다주 Winter Park에서 디자이너 Anna Bond와 그의 남편 Nathan이 설립한 일러스트 디자인 스튜디오입니다." /></p>
				<p class="t02"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72508/txt_brand_02.png" alt="모든 Rifle Paper의 제품은 미국 현지에서 친환경 지류와 물감을 조합하여 핸드프린팅된 일러스트가 메인으로 자리잡고 있으며 사랑스럽고 몽환적인 일러스트가 특징입니다." /></p>
				<p class="t03"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72508/txt_brand_03.png" alt="따뜻한 손 끝에서 시작되는 Rifle Paper의 감성을 여러분께 선보입니다." /></p>
			</div>
			<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="" /></div>
		</div>
		<div class="visual"><a href="/shopping/category_prd.asp?itemid=1544317&amp;pEtr=72508"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72508/img_diary.jpg" alt="" /></a></div>
		<%' item %>
		<div class="item itemA">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72508/img_mark.png" alt="" /></h3>
			<%' for dev msg : 상품코드 1544319, 할인기간 8/24 ~ 8/30 할인기간이 지나면  <strong class="discount">...</strong> 숨겨주세요 %>
			<%
				IF application("Svr_Info") = "Dev" THEN
					itemid = 1239226
				Else
					itemid = 1544319
				End If
				set oItem = new CatePrdCls
					oItem.GetItemData itemid
			%>
			<div class="desc">
				<div class="option">
					<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72508/txt_name.png" alt="[Disney]Finding Dory_Coaster" /></p>
			<% If oItem.FResultCount > 0 Then %>
				<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
					<div class="price">
					<% If not( left(currenttime,10)>="2016-08-24" and left(currenttime,10)<="2016-08-30" ) Then %>
					<% Else %>
						<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/txt_only_10percent.png" alt="단, 일주일만 10%" /></strong>
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
					<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72508/txt_substance.png" alt="디자이너의 따뜻한 감성이 담긴 일러스트 플래너입니다. 2016년 8월 부터 다음 해 12월까지 17개월을 2017년까지 쓸 수 있습니다. 라이플 페이퍼의 넉넉한 속지, 따뜻한 감성의 일러스트와 함께 17개월을 보내보아요. 쓰고 있는 플래너가 질렸다거나, 2017년을 미리 앞서서 계획하고 싶은 이들에게 소개해드립니다." /></p>
					<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="" /></div>
				</div>
			<%	set oItem = nothing %>
				<div class="slidewrap">
					<div id="slide01" class="slide">
						<div>
							<a href="/shopping/category_prd.asp?itemid=1544319&amp;pEtr=72508" class="itemImage"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72508/img_slide_item_01.jpg" alt="" /></a>
							<a href="/shopping/category_prd.asp?itemid=1544319&amp;pEtr=72508" class="goBuy">구매하러가기</a>
						</div>
						<div>
							<a href="/shopping/category_prd.asp?itemid=1544320&amp;pEtr=72508" class="itemImage"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72508/img_slide_item_02.jpg" alt="" /></a>
							<a href="/shopping/category_prd.asp?itemid=1544320&amp;pEtr=72508" class="goBuy">구매하러가기</a>
						</div>
						<div>
							<a href="/shopping/category_prd.asp?itemid=1544317&amp;pEtr=72508" class="itemImage"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72508/img_slide_item_03.jpg" alt="" /></a>
							<a href="/shopping/category_prd.asp?itemid=1544317&amp;pEtr=72508" class="goBuy">구매하러가기</a>
						</div>
						<div>
							<a href="/shopping/category_prd.asp?itemid=1544318&amp;pEtr=72508" class="itemImage"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72508/img_slide_item_04.jpg" alt="" /></a>
							<a href="/shopping/category_prd.asp?itemid=1544318&amp;pEtr=72508" class="goBuy">구매하러가기</a>
						</div>
						<div>
							<a href="/shopping/category_prd.asp?itemid=1544313&amp;pEtr=72508" class="itemImage"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72508/img_slide_item_05.jpg" alt="" /></a>
							<a href="/shopping/category_prd.asp?itemid=1544313&amp;pEtr=72508" class="goBuy">구매하러가기</a>
						</div>
						<div>
							<a href="/shopping/category_prd.asp?itemid=1544312&amp;pEtr=72508" class="itemImage"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72508/img_slide_item_06.jpg" alt="" /></a>
							<a href="/shopping/category_prd.asp?itemid=1544312&amp;pEtr=72508" class="goBuy">구매하러가기</a>
						</div>
					</div>
				</div>
			</div>
			<div class="with">
				<ul>
				<%
					IF application("Svr_Info") = "Dev" THEN
						itemid = 786868
					Else
						itemid = 1544319
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
				%>
					<li>
						<a href="/shopping/category_prd.asp?itemid=1544319&amp;pEtr=72508">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72508/img_with_item_01.jpg" alt="" />
							<span>2017 Jardin de Paris<br />Spiral Bound Planner </span>
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
					IF application("Svr_Info") = "Dev" THEN
						itemid = 786868
					Else
						itemid = 1544320
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
				%>
					<li>
						<a href="/shopping/category_prd.asp?itemid=1544320&amp;pEtr=72508">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72508/img_with_item_02.jpg" alt="" />
							<span>2017 Jardin de Paris<br />Spiral Bound Planner</span>
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
					IF application("Svr_Info") = "Dev" THEN
						itemid = 786868
					Else
						itemid = 1544317
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
				%>
					<li>
						<a href="/shopping/category_prd.asp?itemid=1544317&amp;pEtr=72508">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72508/img_with_item_03.jpg" alt="" />
							<span>2017 Rosa<br />Covered Spiral Planner</span>
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
					IF application("Svr_Info") = "Dev" THEN
						itemid = 786868
					Else
						itemid = 1544318
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
				%>
					<li>
						<a href="/shopping/category_prd.asp?itemid=1544318&amp;pEtr=72508">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72508/img_with_item_04.jpg" alt="" />
							<span>2017 Jardin de paris<br />Covered Spiral Planner</span>
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
					IF application("Svr_Info") = "Dev" THEN
						itemid = 786868
					Else
						itemid = 1544313
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
				%>
					<li>
						<a href="/shopping/category_prd.asp?itemid=1544313&amp;pEtr=72508">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72508/img_with_item_05.jpg" alt="" />
							<span>2017 Desktop<br />Covered Spiral Planner </span>
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
					IF application("Svr_Info") = "Dev" THEN
						itemid = 786868
					Else
						itemid = 1544312
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
				%>
					<li>
						<a href="/shopping/category_prd.asp?itemid=1544312&amp;pEtr=72508">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72508/img_with_item_06.jpg" alt="" />
							<span>2017 Scarlett Birch Floral<br />Covered Spiral Planner</span>
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
		<%' another item %>
		<div class="anotherIitem">
			<div class="image"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72508/img_rifle_paper.jpg" alt="" /></div>
			<div id="slider" class="slider-horizontal">
				<div class="slide-img"><a href="/shopping/category_prd.asp?itemid=1032229&amp;pEtr=72508"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72508/img_another_01.jpg" alt="" /></a></div>
				<div class="slide-img"><a href="/shopping/category_prd.asp?itemid=1229774&amp;pEtr=72508"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72508/img_another_02.jpg" alt="" /></a></div>
				<div class="slide-img"><a href="/shopping/category_prd.asp?itemid=974321&amp;pEtr=72508"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72508/img_another_03.jpg" alt="" /></a></div>
				<div class="slide-img"><a href="/shopping/category_prd.asp?itemid=1229775&amp;pEtr=72508"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72508/img_another_04.jpg" alt="" /></a></div>
				<div class="slide-img"><a href="/shopping/category_prd.asp?itemid=974324&amp;pEtr=72508"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72508/img_another_05.jpg" alt="" /></a></div>
				<div class="slide-img"><a href="/shopping/category_prd.asp?itemid=1260641&amp;pEtr=72508"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72508/img_another_06.jpg" alt="" /></a></div>
				<div class="slide-img"><a href="/shopping/category_prd.asp?itemid=1201875&amp;pEtr=72508"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72508/img_another_07.jpg" alt="" /></a></div>
				<div class="slide-img"><a href="/shopping/category_prd.asp?itemid=1156177&amp;pEtr=72508"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72508/img_another_08.jpg" alt="" /></a></div>
				<div class="slide-img"><a href="/shopping/category_prd.asp?itemid=1113764&amp;pEtr=72508"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72508/img_another_09.jpg" alt="" /></a></div>
			</div>
		</div>
		<%' story %>
		<div class="story">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72508/txt_story.png" alt="시간을 그려가는 17-MONTH-PLANNERS" /></h3>
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
									<a href="/shopping/category_prd.asp?itemid=1544319&amp;pEtr=72508"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72508/img_slide_story_01.jpg" alt="#PATTERN-디자이너의 따뜻한 일러스트 4종을 만나 보세요. 보기만 해도 사랑스러운 일러스트가 담긴 플래너에 우리들의 소중한 17개월을 기록해보아요." /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1544319&amp;pEtr=72508"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72508/img_slide_story_02.jpg" alt="#SIZE-간편성과 휴대성을 살린, 사용자 맞춤 PLANNER로서 2가지로 된 크기와 클래식 스타일,넘기기 편하도록 스프링으로 제본된 플래너를 선택할 수 있어요." /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1544319&amp;pEtr=72508"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72508/img_slide_story_03.jpg" alt="# SPECIAL-2016년 8월 부터 다음 해 12월까지 17개월을 2017년까지 쓸 수 있습니다. 어디에서도 볼 수 없는 특별한 17-MONTH PLANNER는 앞으로를 더욱 더 빛나게 해드립니다." /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1544319&amp;pEtr=72508"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72508/img_slide_story_04.jpg" alt="#FUNCTIONAL-디자인만큼 속지 구성도 알찬 17-MONTH PLANNER. Important Date, Note, Monthly,AUG 2016 - DEC 2017, CONTACTS의 무엇 하나 놓칠 수 없는 구성으로 여러분들을 찾아갑니다." /></a>
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
			<div class="txt">
				<span class="t01"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72508/txt_finish_01.png" alt="시간을 그려가는" /></span>
				<span class="t02"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72508/txt_finish_02.png" alt="17-MONTH PLANNER" /></span>
			</div>
			<div class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72508/bg_finish.jpg" alt="" /></div>
		</div>
		<%' comment %>
		<div class="commentevet">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72508/tit_comment.png" alt="Hey, something project Rifle Paper, 시간을 담다" /></h3>
			<p class="hidden">올해 여러분들의 하반기 다짐을 적어주세요. 정성껏 코멘트를 남겨주신 5분을 추첨하여 Rifle Paper의 17-Month planner를 증정합니다.</p>
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
					<legend>Rifle Paper 코멘트 쓰기</legend>
						<ul class="choice">
							<li class="ico1"><button type="button" value="1">PATTERN</button></li>
							<li class="ico2"><button type="button" value="2">SIZE</button></li>
							<li class="ico3"><button type="button" value="3">SPECIAL</button></li>
							<li class="ico4"><button type="button" value="4">FUNCTIONAL</button></li>
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
					<caption>Rifle Paper 코멘트 목록 - 코멘트 작성시 선택 항목, 내용, 작성일자, 아이디 정보를 제공하는 표</caption>
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
										PATTERN
									<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="2" Then %>
										SIZE
									<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="3" Then %>
										SPECIAL
									<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="4" Then %>
										FUNCTIONAL
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
	// flow slider
	$("#slider").FlowSlider({
		marginStart:0,
		marginEnd:0,
		//position:0.0,
		startPosition:0.55
	});

	/* slide js */
	$("#slide01").slidesjs({
		width:"1055",
		height:"445",
		pagination:false,
		navigation:{effect:"fade"},
		play:{interval:2500, effect:"fade", auto:false},
		effect:{fade: {speed:800, crossfade:true}
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

	/* animation effect */
	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 1000 ) {
			brandAnimation();
		}
		if (scrollTop > 8050 ) {
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
	$(".heySomething .brand .image span").css({"left":"50%", "opacity":"0"});
	$(".heySomething .brand .txt p").css({"top":"10px", "opacity":"0"});
	$(".heySomething .brand .btnDown").css({"opacity":"0"});
	function brandAnimation() {
		$(".heySomething .brand .image .i01").delay(50).animate({"left":"0", "opacity":"1"},1100);
		$(".heySomething .brand .image .i02").delay(50).animate({"left":"194px", "opacity":"1"},1100);
		$(".heySomething .brand .image .i03").delay(50).animate({"left":"387px", "opacity":"1"},1100);
		$(".heySomething .brand .image .i04").delay(50).animate({"left":"585px", "opacity":"1"},1100);
		$(".heySomething .brand .txt .t01").delay(900).animate({"top":"0", "opacity":"1"},600);
		$(".heySomething .brand .txt .t02").delay(1200).animate({"top":"0", "opacity":"1"},600);
		$(".heySomething .brand .txt .t03").delay(1400).animate({"top":"0", "opacity":"1"},600);
		$(".heySomething .brand .btnDown").delay(1900).animate({"opacity":"1"},500);
	}

	/* finish animation */
	$(".heySomething .finish .t01").css({"margin-left":"-517px", "opacity":"0"});
	$(".heySomething .finish .t02").css({"margin-left":"-477px", "opacity":"0"});
	function finishAnimation() {
		$(".heySomething .finish .t01").delay(100).animate({"margin-left":"-497px", "opacity":"1"},1100);
		$(".heySomething .finish .t02").delay(100).animate({"margin-left":"-497px", "opacity":"1"},1100);
	}
});
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->