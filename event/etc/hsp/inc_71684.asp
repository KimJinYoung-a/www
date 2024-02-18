<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈 40
' History : 2016-07-11 김진영 생성
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
Dim oItem
Dim currenttime
	currenttime =  now()
	'currenttime = #10/07/2015 09:00:00#

Dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  66169
Else
	eCode   =  71684
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
.heySomething .topic {background-color:#fefefe;}
.heySomething .topic h2 {z-index:5;}
.heySomething .topic .figure a {display:block; position:relative; width:100%; height:780px;}
.heySomething .topic .figure img {position:absolute; top:0; left:50%; margin-left:-951px;}

/* item */
.heySomething .itemB {margin-top:376px; padding-bottom:0; background:none;}
.heySomething .item h3 {position:relative; height:86px;}
.heySomething .item h3 .disney {position:absolute; top:0; left:393px; z-index:5; background-color:#fff;}
.heySomething .item h3 .tenten {position:absolute; top:38px; left:621px; z-index:5; background-color:#fff;}
.heySomething .item h3 .verticalLine {position:absolute; top:20px; left:569px; width:1px; height:64px; background-color:#d9d9d9;}
.heySomething .item h3 .horizontalLine1, .heySomething .item h3 .horizontalLine2 {position:absolute; top:50px; width:322px; height:1px; background-color:#d9d9d9;}
.heySomething .item h3 .horizontalLine1 {left:0;}
.heySomething .item h3 .horizontalLine2 {right:0;}
.heySomething .item .desc {min-height:486px;}
.heySomething .item .slidewrap {padding-top:36px;}
.heySomething .itemB .slidewrap .slide {position:relative; width:600px; height:600px;}
.heySomething .item .with {margin-top:10px; border:none;}
.heySomething .item .with span {position:relative; z-index:5;}
.heySomething .item .with {padding-bottom:66px; border-bottom:1px solid #ddd; text-align:center;}
.heySomething .item .with ul {overflow:hidden; width:1140px; margin:75px auto 0;}
.heySomething .item .with ul li {float:left; width:255px; margin-right:40px}
.heySomething .item .with ul li.last {margin-right:0;}
.heySomething .item .with ul li a {color:#777;}
.heySomething .item .with ul li span, .heySomething .with ul li strong {display:block; font-size:11px;}
.heySomething .item .with ul li span {margin-top:15px;}

/* brand */
.heySomething .brand {height:1573px; margin-top:415px;}
.heySomething .brand h3 {width:1140px; margin:0 auto; text-align:left;}
.heySomething .brand h3 img {margin-left:-58px;}
.heySomething .brand .desc {position:relative; height:714px; margin-top:313px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/71684/bg_pattern_flower.jpg) repeat-x 0 0;}
.heySomething .brand .desc p {position:absolute; top:67px; left:50%; margin-left:-287px;}

.rollIn {animation-name:rollIn; animation-duration:1.8s; animation-fill-mode:both; animation-iteration-count:1;}
@keyframes rollIn {
	0% {transform:translateX(-100%) rotate(-120deg);}
	100% {transform:translateX(0px) rotate(0deg);}
}

/* visual */
.heySomething .visual {position:relative; margin-top:63px;}
.heySomething #slider .slide-img {width:auto; height:216px; margin:0 60px;}
.heySomething .visual .btnDown {margin-top:200px; text-align:center;}

/* story */
.heySomething .story {margin-top:300px; padding-bottom:0;}
.heySomething .rolling {padding-top:199px;}
.heySomething .rolling .pagination {top:0; width:900px; margin-left:-450px;}
.heySomething .rolling .swiper-pagination-switch {width:156px; height:156px; margin:0 12px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/71684/btn_pagination.png);}
.heySomething .rolling .pagination span.swiper-active-switch {background-position:0 100%;}
.heySomething .rolling .pagination span:first-child + span {background-position:-172px 0;}
.heySomething .rolling .pagination span:first-child + span.swiper-active-switch {background-position:-172px 100%;}
.heySomething .rolling .pagination span:first-child + span + span {background-position:-353px 0;}
.heySomething .rolling .pagination span:first-child + span + span.swiper-active-switch {background-position:-353px 100%;}
.heySomething .rolling .pagination span:first-child + span + span + span {background-position:-529px 0;}
.heySomething .rolling .pagination span:first-child + span + span + span.swiper-active-switch {background-position:-529px 100%;}
.heySomething .rolling .pagination span:first-child + span + span + span + span {background-position:100% 0;}
.heySomething .rolling .pagination span:first-child + span + span + span + span.swiper-active-switch {background-position:100% 100%;}
.heySomething .swipemask {top:199px;}

/* comment */
.heySomething .commentevet {margin-top:365px;}
.heySomething .commentevet .form .choice li {width:133px; height:133px; margin-right:32px;}
.heySomething .commentevet .form .choice li.ico1 {margin-right:15px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/71684/img_ico.png); background-position:0 0;}
.heySomething .commentevet .form .choice li button.on {background-position:0 100%;}
.heySomething .commentevet .form .choice li.ico2 button {background-position:-156px 0;}
.heySomething .commentevet .form .choice li.ico2 button.on {background-position:-156px 100%;}
.heySomething .commentevet .form .choice li.ico3 button {background-position:-329px 0;}
.heySomething .commentevet .form .choice li.ico3 button.on {background-position:-329px 100%;}
.heySomething .commentevet .form .choice li.ico4 button {background-position:-487px 0;}
.heySomething .commentevet .form .choice li.ico4 button.on {background-position:-487px 100%;}
.heySomething .commentevet .form .choice li.ico5 button {background-position:100% 0;}
.heySomething .commentevet .form .choice li.ico5 button.on {background-position:100% 100%;}

.heySomething .commentevet textarea {margin-top:30px;}

.heySomething .commentlist table td strong {width:133px; height:133px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/71684/img_ico.png); background-position:0 0;}
.heySomething .commentlist table td strong.ico2 {background-position:-156px 0;}
.heySomething .commentlist table td strong.ico3 {background-position:-329px 0;}
.heySomething .commentlist table td strong.ico4 {background-position:-487px 0;}
.heySomething .commentlist table td strong.ico5 {background-position:100% 0;}
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
		<% If not( left(currenttime,10) >= "2016-07-12" and left(currenttime,10) <= "2016-07-19" ) Then %>
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
				<a href="/shopping/category_prd.asp?itemid=1523841&amp;pEtr=71684"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71684/img_item_represent.jpg" alt="Disney Jungle Book Toiletry" /></a>
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
				<h3>
					<span class="disney"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71684/img_logo_disney.png" alt="디즈니" /></span>
					<span class="tenten"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71684/img_logo_tenten.png" alt="텐바이텐" /></span>
					<span class="verticalLine"></span>
					<span class="horizontalLine1"></span>
					<span class="horizontalLine2"></span>
				</h3>
				<div class="desc">
					<a href="/shopping/category_prd.asp?itemid=1523839&amp;pEtr=71684">
						<div class="option">
							<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71684/txt_name.png" alt="Disney Jungle Book Make Up Pouch" /></p>
							<%' for dev msg : 상품코드 1523839 디즈니 상품은 할인 없이 진행합니다. %>
							<div class="price">
								<strong>16,000won</strong>
							</div>
							<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71684/txt_substance.png" alt="디즈니 정글북과 텐바이텐의 만남으로 탄생된 2016 트로피칼 라인업을 소개합니다." /></p>
							<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="Disney Jungle Book Make Up Pouch구매하러 가기" /></div>
						</div>
						<%' slide %>
						<div class="slidewrap">
							<div id="slide" class="slide">
								<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71684/img_slide_item_01.jpg" alt="" /></div>
								<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71684/img_slide_item_02.jpg" alt="" /></div>
								<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71684/img_slide_item_03.jpg" alt="" /></div>
								<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71684/img_slide_item_04.jpg" alt="" /></div>
							</div>
						</div>
					</a>
				</div>
				<%' for dev msg : 가격 부분만 개발 해주세요 %>
				<div class="with">
					<span><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/ico_plus.png" alt="" /></span>
					<ul>
				<%
					IF application("Svr_Info") = "Dev" THEN
						itemid = 786868
					Else
						itemid = 1523840
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
				%>
						<li>
							<a href="/shopping/category_prd.asp?itemid=1523840&amp;pEtr=71684">
								<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71684/img_with_item_01.jpg" alt="" />
								<span>[Disney] Jungle Book_Flat Multi Pouch(S)</span>
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
						itemid = 1523841
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
				%>
						<li>
							<a href="/shopping/category_prd.asp?itemid=1523841&amp;pEtr=71684">
								<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71684/img_with_item_02.jpg" alt="" />
								<span>[Disney] Jungle Book_Toiletry</span>
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
						itemid = 1526096
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
				%>
						<li>
							<a href="/shopping/category_prd.asp?itemid=1526096&amp;pEtr=71684">
								<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71684/img_with_item_03.jpg" alt="" />
								<span>[Disney]Jungle Book_Tropical Mat</span>
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
						itemid = 1523836
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
				%>
						<li class="last">
							<a href="/shopping/category_prd.asp?itemid=1523836&amp;pEtr=71684">
								<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71684/img_with_item_04.jpg" alt="" />
								<span>[Disney] Jungle Book_Stand</span>
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
		</div>
		<%' brand %>
		<div id="brand" class="brand">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71684/tit_junglebook_tenbyten_collabo.png" alt="정글북과 텐바이텐의 콜라보레이션" /></h3>
			<div class="desc">
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71684/txt_brand.png" alt="부모를 잃고 늑대에게 키워진 인간의 아이 모글리가 유일한 안식처였던 정글이 위험한 장소가 된 것을 깨닫고, 그를 지켜준 동물 친구들과 모험을 떠나는 이야기" /></p>
			</div>
		</div>
		<%' visual %>
		<div class="visual">
			<div id="slider" class="slider-horizontal">
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1523840&amp;pEtr=71684"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71684/img_item_visual_01.png" alt="Flat Multi Pouch" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1523844&amp;pEtr=71684"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71684/img_item_visual_02.png" alt="Basic Pouch Small" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1523839&amp;pEtr=71684"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71684/img_item_visual_03.png" alt="Make Up Pouch" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1523843&amp;pEtr=71684"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71684/img_item_visual_04.png" alt="Basic Pouch Large" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1523838&amp;pEtr=71684"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71684/img_item_visual_05.png" alt="Sleep Mask" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1523841&amp;pEtr=71684"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71684/img_item_visual_06.png" alt="Toiletry" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1523833&amp;pEtr=71684"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71684/img_item_visual_07.png" alt="Beach Towel" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1523842&amp;pEtr=71684"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71684/img_item_visual_08.png" alt="Snack Bag" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1523836&amp;pEtr=71684"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71684/img_item_visual_09.png" alt="Stand" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1520149&amp;pEtr=71684"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71684/img_item_visual_10.png" alt="Rug medium" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1520151&amp;pEtr=71684"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71684/img_item_visual_11.png" alt="Rug Large" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1526096&amp;pEtr=71684"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71684/img_item_visual_12.png" alt="Tropical Mat" /></a>
				</div>
			</div>
			<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="" /></div>
		</div>
		<%' story %>
		<div class="story">
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
									<a href="/shopping/category_prd.asp?itemid=1523839&amp;pEtr=71684" title="Flat Multi Pouch 상품 보러가기"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71684/img_slide_story_01.jpg" alt="Daily 바쁜 일상에서 여름을 느끼는 방법" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1520151&amp;pEtr=71684" title="Rug Large 상품 보러가기"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71684/img_slide_story_02.jpg" alt="Home 작은 변화만으로 집안에 이국적인 느낌 물씬 집안에서도 휴양지에 온 듯 시원하게" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1523841&amp;pEtr=71684" title="Toiletry 상품 보러가기"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71684/img_slide_story_03.jpg" alt="Travel 컴팩트한 토일렛 파우치로 완벽한 여름휴가를 만들어 드릴게요" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1523833&amp;pEtr=71684" title="Beach Towel 상품 보러가기"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71684/img_slide_story_04.jpg" alt="Beach 비치타월을 걸치면 왠지 내 몸이 더 시원해질 것 같아!" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1526096&amp;pEtr=71684" title="Tropical Mat 상품 보러가기"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71684/img_slide_story_05.jpg" alt="Picnic 멀리 떠날 필요 없어요 도심 속에서 휴가를 즐기는 방법" /></a>
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
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71684/tit_comment.png" alt="Hey, something project 어떤 상품을 갖고 싶나요?" /></h3>
			<p class="hidden">정글북과 텐바이텐의 콜라보레이션 상품들 중, 가장 갖고 싶은 상품과 그 이유를 적어주세요. 정성껏 코멘트를 남겨주신 10분을 추첨하여, 해당 상품을 선물로 드립니다. 코멘트 작성기간은 2016년 7월 13일부터 7월 19일까지며, 발표는 7월 21일 입니다.</p>
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
					<legend>정글북과 텐바이텐의 콜라보레이션 상품 중 가장 갖고 싶은 상품 코멘트 쓰기</legend>
						<ul class="choice">
							<li class="ico1"><button type="button" value="1">Daily</button></li>
							<li class="ico2"><button type="button" value="2">Home</button></li>
							<li class="ico3"><button type="button" value="3">Travel</button></li>
							<li class="ico4"><button type="button" value="4">Beach</button></li>
							<li class="ico5"><button type="button" value="5">Picnic</button></li>
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
					<caption>정글북과 텐바이텐의 콜라보레이션 상품 중 가장 갖고 싶은 상품 코멘트 목록 - 코멘트 작성시 선택 항목, 내용, 작성일자, 아이디 정보를 제공하는 표</caption>
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
										Daily
									<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="2" Then %>
										Home
									<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="3" Then %>
										Travel
									<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="4" Then %>
										Beach
									<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="5" Then %>
										Picnic
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
	$("#slider").FlowSlider({
		marginStart:0,
		marginEnd:0,
		//position:0.0,
		startPosition:0.55,
		animation: "Transition",
		animationOptions: {
			transition: function(t) {
				if(t <= 0.5) return 1.5 * t;
				return 0.5 * t + 0.5;
			},
			minTime:400,
			maxTime:400
		}
	});

	/* slide js */
	$("#slide").slidesjs({
		width:"600",
		height:"600",
		pagination:false,
		navigation:false,
		play:{interval:2000, effect:"fade", auto:true},
		effect:{fade: {speed:800, crossfade:true}
		},
		callback: {
			complete: function(number) {
				var pluginInstance = $('#slide').data('plugin_slidesjs');
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
			itemAnimation();
		}
		if (scrollTop > 3300 ) {
			$(".heySomething #brand .desc p").addClass("rollIn");
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

	/* item animation */
	$(".heySomething .item h3 .disney").css({"left":"621px", "opacity":"0"});
	$(".heySomething .item h3 .tenten").css({"left":"393px","opacity":"0"});
	function itemAnimation() {
		$(".heySomething .item h3 .disney").delay(200).animate({"left":"393px", "opacity":"1"},1000);
		$(".heySomething .item h3 .tenten").delay(200).animate({"left":"621px", "opacity":"1"},1000);
	}
});
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->