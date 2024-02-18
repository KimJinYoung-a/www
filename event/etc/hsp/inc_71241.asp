<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈
' History : 2016-06-14 원승현 생성
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
	eCode   =  66152
Else
	eCode   =  71241
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
.heySomething .topic {background-color:#473c42;}
.heySomething .topic h2 {z-index:5;}
.heySomething .topic h2 span {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_hey_something_project_white.png);}
.heySomething .topic .figure a {display:block; position:relative; width:100%; height:780px;}
.heySomething .topic .figure img {position:absolute; top:0; left:50%; margin-left:-951px;}

/* brand */
.heySomething .brand {margin-top:375px; height:751px; padding-top:119px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/71241/bg_iphone.png) no-repeat 50% 0;}
.heySomething .brand h3 {margin-left:-52px;}
.heySomething .brand .rolling {position:relative; width:736px; margin:87px auto 0; padding-top:0; text-align:left;}
.heySomething .brand .rolling .swiper {position:relative; height:246px; margin-left:123px; width:437px; }
.heySomething .brand .rolling .swiper .swiper-container {overflow:hidden; position:relative; width:437px;}
.heySomething .brand .rolling .swiper .swiper-wrapper {overflow:hidden; position:relative;}
.heySomething .brand .rolling .swiper .swiper-slide {width:437px !important; padding:0;}
.heySomething .brand .rolling .btn-nav {top:50%; margin-top:-32px;}
.heySomething .brand .rolling .btn-prev {margin-left:-391px;}
.heySomething .brand .rolling .btn-next {margin-left:312px; background-position:100% 0;}
.heySomething .brand p {margin-top:98px; margin-left:-32px;}
.heySomething .brand .btnDown {margin-left:-32px;}

/* item */
.heySomething .item {width:1140px; margin:476px auto 0; padding:0;}
.heySomething .item h3 {position:relative; height:58px; text-align:center;}
.heySomething .item h3 .horizontalLine1, .heySomething .item h3 .horizontalLine2 {position:absolute; top:26px; width:378px; height:1px; background-color:#ddd;}
.heySomething .item h3 .horizontalLine1 {left:0;}
.heySomething .item h3 .horizontalLine2 {right:0;}
.heySomething .item .desc {position:relative; width:1028px; height:387px; margin:70px auto 0; padding-bottom:72px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/70310/bg_line_dashed.png) repeat-x 0 100%;}
.heySomething .item .desc1 {margin-top:120px;}
.heySomething .item .desc4 {background:none;}
.heySomething .item .desc a {display:block; width:100%; height:100%; cursor:pointer;}
.heySomething .item .desc a:hover {text-decoration:none;}
.heySomething .item .option {height:378px;}
.heySomething .item .thumbnail {position:absolute; top:4px;}
.heySomething .item .descRight .thumbnail {right:17px;}
.heySomething .item .descRight .option {margin-left:27px;}
.heySomething .item .descLeft .option {margin-left:607px;}
.heySomething .item .descLeft .thumbnail {top:17px; left:5px;}

@keyframes flip {
	0% {transform:rotateX(120deg); animation-timing-function:ease-out;}
	100% {transform:rotateX(360deg); animation-timing-function:ease-in;}
}
.flip {animation-name:flip; animation-duration:1.2s; animation-iteration-count:1; backface-visibility:visible;}

/* visual */
.heySomething .visual {margin-top:250px; padding-bottom:0;}
.heySomething .visual .figure {position:relative; height:792px; background-color:#ecdeba;}
.heySomething .visual .figure img {position:absolute; top:0; left:50%; margin-left:-951px;}

/* how to play */
.howtoplay {margin-top:365px; text-align:center;}

/* video */
.video {width:1020px; height:700px; margin:300px auto 0;}
.video .downloadApp {overflow:hidden; padding-top:40px;}
.video .downloadApp li {float:left; margin-left:27px;}
.video .downloadApp li:first-child {margin-left:0;}
.video .downloadApp li a:hover img {animation-name:bounce; animation-iteration-count:infinite; animation-duration:0.5s;}
@keyframes bounce {
	from, to{margin-top:0; animation-timing-function:ease-out;}
	50% {margin-top:-5px; animation-timing-function:ease-in;}
}

/* finish */
.heySomething .finish {background-color:#e8e7e5; height:656px; margin-top:370px;}
.heySomething .finish .figure {position:absolute; top:0; left:50%; margin-left:-951px;}
.heySomething .finish p {top:151px; margin-left:-470px;}

/* comment */
.heySomething .commentevet {margin-top:320px;}
.heySomething .commentevet .form {margin-top:50px;}
.heySomething .commentevet .form .choice {padding-left:22px;}
.heySomething .commentevet .form .choice li {width:112px; height:112px; margin-right:93px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/71241/img_ico.png); background-position:-205px 0;}
.heySomething .commentevet .form .choice li.ico1 button.on {background-position:-205px -112px;}
.heySomething .commentevet .form .choice li.ico2 button {background-position:-410px 0;}
.heySomething .commentevet .form .choice li.ico2 button.on {background-position:-410px -112px;}
.heySomething .commentevet .form .choice li.ico3 button {background-position:0 0;}
.heySomething .commentevet .form .choice li.ico3 button.on {background-position:0 -112px;}
.heySomething .commentevet .form .choice li.ico4 button {background-position:100% 0;}
.heySomething .commentevet .form .choice li.ico4 button.on {background-position:100% -112px;}
.heySomething .commentevet textarea {margin-top:25px;}

.heySomething .commentlist table td strong {width:112px; height:112px; margin-left:18px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/71241/img_ico.png); background-position:-205px 100%;}
.heySomething .commentlist table td strong.ico2 {background-position:-410px 100%;}
.heySomething .commentlist table td strong.ico3 {background-position:0 100%;}
.heySomething .commentlist table td strong.ico4 {background-position:100% 100%;}
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
		<% If not( left(currenttime,10)>="2016-06-14" and left(currenttime,10)<"2016-12-31" ) Then %>
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
				<a href="/shopping/category_prd.asp?itemid=1510692&amp;pEtr=71241"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71241/img_item_represent.jpg" alt="dinosaur 4D+ 입체 카드" /></a>
			</div>
		</div>

		<%' about %>
		<div class="about">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
			<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
		</div>

		<%' brand %>
		<div class="brand">
			<h3 class="logo"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71241/img_logo_octagon_studio.png" alt="octagon studio" /></h3>
			<div id="rolling" class="rolling">
				<div class="swiper">
					<div class="swiper-container swiper1">
						<div class="swiper-wrapper">
							<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71241/img_slide_01.jpg" alt="" /></div>
							<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71241/img_slide_02.jpg" alt="" /></div>
							<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71241/img_slide_03.jpg" alt="" /></div>
							<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71241/img_slide_04.jpg" alt="" /></div>
							<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71241/img_slide_05.jpg" alt="" /></div>
							<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71241/img_slide_06.jpg" alt="" /></div>
							<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71241/img_slide_07.jpg" alt="" /></div>
							<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71241/img_slide_08.jpg" alt="" /></div>
							<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71241/img_slide_09.jpg" alt="" /></div>
						</div>
					</div>
					<div class="pagination"></div>
					<button type="button" class="btn-nav btn-prev">Previous</button>
					<button type="button" class="btn-nav btn-next">Next</button>
				</div>
			</div>
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71241/txt_brand.png" alt="증강현실로 창의적인 경험을 제공하며 실감나는 입체 영상과 함께 단어와 관련 지식을 쉽고 흥미롭게 익힐 수 있는 4D 증강현실 입체 카드" /></p>
			<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="" /></div>
		</div>

		<%' item %>
		<div class="item">
			<div class="inner">
				<h3>
					<span class="logo"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71241/img_logo_octagon_studio_4d.png" alt="octagon studio 4D+" /></span>
					<span class="horizontalLine1"></span>
					<span class="horizontalLine2"></span>
				</h3>

				<%
				itemid = 1510691
				set oItem = new CatePrdCls
					oItem.GetItemData itemid
				%>
				<div class="desc desc1 descRight">
					<a href="/shopping/category_prd.asp?itemid=1510691&amp;pEtr=71241">
						<div class="option">
							<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71241/txt_name_space.png" alt="space 4D+ 우주카드 37장, 설명카드 1장 및 시리얼넘버로 구성되어 있습니다." /></p>
							<% if oItem.FResultCount > 0 then %>
								<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
								<div class="price">
									<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/txt_only_<%= Format00(2, fix((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>percent.png" alt="단 일주일만 only <%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%" /></strong>
									<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								</div>
								<% Else %>
								<%' for dev msg : 종료 후 %>
								<div class="price priceEnd">
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								</div>
								<% End If %>
							<% End If %>
							<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71241/txt_substance_space.png" alt="환상적인 우주 탐사의 경험을 할 수 있는 SPACE 4D+ 태양계, 행성, 위성, 탐사선 등 우주 공간에 대한 플래시 카드입니다. 우주의 신비 속으로 들어와 보세요!" /></p>
							<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러 가기" /></div>
						</div>
						<div class="thumbnail"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71241/img_item_space.jpg" alt="" /></div>
					</a>
				</div>
				<% set oItem=nothing %>
				
				<%
				itemid = 1510692
				set oItem = new CatePrdCls
					oItem.GetItemData itemid
				%>
				<div class="desc desc2 descLeft">
					<a href="/shopping/category_prd.asp?itemid=1510692&amp;pEtr=71241">
						<div class="option">
							<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71241/txt_name_dinosaur.png" alt="dinosaur 4D+ 공룡카드 20장, 설명카드 1장 및 시리얼넘버로 구성되어 있습니다." /></p>
							<% if oItem.FResultCount > 0 then %>
								<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
								<div class="price">
									<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/txt_only_<%= Format00(2, fix((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>percent.png" alt="단 일주일만 only <%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%" /></strong>
									<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								</div>
								<% Else %>
								<%' for dev msg : 종료 후 %>
								<div class="price priceEnd">
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								</div>
								<% End If %>
							<% End If %>
							<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71241/txt_substance_dinosaur.png" alt="살아 숨쉬는 신비한 공룡의 세계! 바로 눈앞에서 1억 4천만년전 중생대 백악기에 살았던 공룡들을 만날 수 있습니다" /></p>
							<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러 가기" /></div>
						</div>
						<div class="thumbnail"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71241/img_item_dinosaur.jpg" alt="" /></div>
					</a>
				</div>
				<% set oItem=nothing %>

				<%
				itemid = 1510694
				set oItem = new CatePrdCls
					oItem.GetItemData itemid
				%>
				<div class="desc desc3 descRight">
					<a href="/shopping/category_prd.asp?itemid=1510694&amp;pEtr=71241">
						<div class="option">
							<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71241/txt_name_animal.png" alt="animal 4D+ 동물카드 26장, 설명카드 1장 및 먹이카드로 구성되어 있습니다." /></p>
							<% if oItem.FResultCount > 0 then %>
								<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
								<div class="price">
									<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/txt_only_<%= Format00(2, fix((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>percent.png" alt="단 일주일만 only <%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%" /></strong>
									<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								</div>
								<% Else %>
								<%' for dev msg : 종료 후 %>
								<div class="price priceEnd">
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								</div>
								<% End If %>
							<% End If %>
							<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71241/txt_substance_animal.png" alt="동물의 왕국에 오신걸 환영합니다. A~Z 알파벳 동물로 구성된 animal 4D+ 동물들의 습성을 이해할 수 있도록 먹이를 줄 수 있는 먹이카드도 같이 활용해보세요!" /></p>
							<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러 가기" /></div>
						</div>
						<div class="thumbnail"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71241/img_item_animal.jpg" alt="" /></div>
					</a>
				</div>
				<% set oItem=nothing %>

				<%
				itemid = 1510693
				set oItem = new CatePrdCls
					oItem.GetItemData itemid
				%>
				<div class="desc desc4 descLeft">
					<a href="/shopping/category_prd.asp?itemid=1510693&amp;pEtr=71241">
						<div class="option">
							<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71241/txt_name_octaland.png" alt="octaland 4D+ 직업 24장, 설명카드 1장 및 시리얼넘버로 구성되어 있습니다." /></p>
							<% if oItem.FResultCount > 0 then %>
								<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
								<div class="price">
									<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/txt_only_<%= Format00(2, fix((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>percent.png" alt="단 일주일만 only <%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%" /></strong>
									<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								</div>
								<% Else %>
								<%' for dev msg : 종료 후 %>
								<div class="price priceEnd">
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								</div>
								<% End If %>
							<% End If %>
							<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71241/txt_substance_octaland.png" alt="다양한 직업들을 만나봐요! 사육사, 우주비행사, 요리사, 선생님등 다양한 직업들을 한자리에!" /></p>
							<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러 가기" /></div>
						</div>
						<div class="thumbnail"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71241/img_item_octaland.jpg" alt="" /></div>
					</a>
				</div>
				<% set oItem=nothing %>
			</div>
		</div>

		<%' visual %>
		<div class="visual">
			<div class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71241/img_item_visual_big.jpg" alt="space, animal, dinosaur, octaland 4D+ 입체 카드" /></div>
		</div>

		<%' how to play %>
		<div class="howtoplay">
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71241/txt_how_to_play.jpg" alt="how to play 플레이스토어나 앱스토어에서 앱을 다운 받아 실행합니다. Animal 4D+, Octaland 4D+, Space 4D+, Dinosaur 4D+ 카메라의 카드의 동물 및 사물을 인식시키면, 카드의 그림들이 살아나요! 시리얼넘버 등록은 필수입니다. Interaction 버튼을 누르면 동물에게 먹이를 주며 동물들의 습성도 함께 학습할 수 있습니다." /></p>
		</div>

		<%' video %>
		<div class="video">
			<iframe src="//player.vimeo.com/video/170130981" width="1020" height="573" frameborder="0" title="Octagon studio 4D card" webkitallowfullscreen="" mozallowfullscreen="" allowfullscreen=""></iframe>
			<ul class="downloadApp">
				<li class="android"><a href="https://play.google.com/store/apps/developer?id=Octagon+Studio" title="플레이스토어 옥타곤스튜디오로 이동 새창 열림" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71241/btn_app_android.png" alt="안드로이드 앱 보러가기" /></a>
				<li class="ios"><a href="https://itunes.apple.com/kr/developer/octagon-studio-ltd/id998405180?l=en" title="앱스토어 옥타곤스튜디오로 이동 새창 열림" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71241/btn_app_ios.png" alt="아이폰 앱 보러가기" /></a>
			</ul>
		</div>

		<%' finish %>
		<div class="finish">
			<a href="/shopping/category_prd.asp?itemid=1510691&amp;pEtr=71241">
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71241/txt_finish.png" alt="증강현실을 통한 실감나는 입체영상으로 잊을 수 없는 창의적인 경험을 선사합니다!" /></p>
				<div class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71241/img_finish.jpg" alt="space 4D+" /></div>
			</a>
		</div>
		
		<%' comment %>
		<div class="commentevet">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71241/tit_comment.png" alt="Hey, something project 내가 경험 하고 싶은 것" /></h3>
			<p class="hidden">지내가 가장 경험하고 싶은 4D+ 카드는 무엇인가요? 정성스러운 코멘트를 남겨주신 5분을 추첨하여 4D+ 카드 1종을 랜덤으로 드립니다. 코멘트 작성기간은 2016년 6월 15일부터 6월 21일까지며, 발표는 6월 22일 입니다.</p>

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
					<legend>가장 경험하고 싶은 flash card 4D+ 코멘트 쓰기</legend>
						<ul class="choice">
							<li class="ico1"><button type="button" value="1">space 4D+</button></li>
							<li class="ico2"><button type="button" value="2">dinosaur 4D+</button></li>
							<li class="ico3"><button type="button" value="3">anmal 4D+</button></li>
							<li class="ico4"><button type="button" value="4">octaland 4D+</button></li>
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
						<caption>flash card 4D+ 코멘트 목록 - 코멘트 작성시 선택 항목, 내용, 작성일자, 아이디 정보를 제공하는 표</caption>
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
												space 4D+
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="2" then %>
												dinosaur 4D+												
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="3" then %>
												anmal 4D+
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="4" then %>
												octaland 4D+
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
<script type="text/javascript" src="/lib/js/jquery.flowslider.js"></script>
<script type="text/javascript">
$(function(){
	/* swipe js */
	var mySwiper = new Swiper("#rolling .swiper-container",{
		loop:true,
		resizeReInit:true,
		calculateHeight:true,
		pagination:false,
		speed:1000,
		autoplay:2000
	})

	$("#rolling .btn-prev").on("click", function(e){
		e.preventDefault()
		mySwiper.swipePrev()
	});

	$("#rolling .btn-next").on("click", function(e){
		e.preventDefault()
		mySwiper.swipeNext()
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
		if (scrollTop > 2200 ) {
			$(".heySomething .item h3 .logo img").addClass("flip");
		}
		if (scrollTop > 8200 ) {
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

	/* finish animation */
	$(".heySomething .finish p").css({"margin-left":"-450px", "opacity":"0"});
	function finishAnimation() {
		$(".heySomething .finish p").delay(100).animate({"margin-left":"-470px", "opacity":"1"},1000);
	}
});

</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->