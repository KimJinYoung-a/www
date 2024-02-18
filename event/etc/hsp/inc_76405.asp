<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈
' History : 2016-12-06 이종화 생성
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
	eCode   =  66285
Else
	eCode   =  76405
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
.heySomething .topic {height:778px; background-color:#f9f9fc;}
.heySomething .topic h2 {z-index:5;}
.heySomething .topic .figure {position:relative; width:100%; height:794px;}
.heySomething .topic .figure img {position:absolute; top:0; left:50%; margin-left:-950px;}

/* item */
.heySomething .item {width:1050px; margin:365px auto 0;}
.heySomething .item h3 {position:relative; text-align:center;}
.heySomething .item h3 .horizontalLine1, .heySomething .item h3 .horizontalLine2 {position:absolute; top:17px; width:388px; height:1px; background-color:#ddd;}
.heySomething .item h3 .horizontalLine1 {left:0;}
.heySomething .item h3 .horizontalLine2 {right:0;}
.heySomething .item a:hover {text-decoration:none;}
.heySomething .item .slidewrap {margin-top:140px; padding-top:140px; border-top:1px dashed #cdcdcd; background-color:#fff;}
.heySomething .item h3 + .slidewrap {margin-top:50px; padding-top:0; border:0;}
.heySomething .item .slidewrap .desc {overflow:hidden; height:432px;}
.heySomething .item .slidewrap .option {position:static; width:440px;}
.heySomething .item .slidewrap .option,
.heySomething .item .slidewrap .figure {float:left;}
.heySomething .item .option .btnget,
.heySomething .item .option .substance {position:static;}
.heySomething .item .option .price {margin-top:40px; height:auto;}
.heySomething .item .option .price strong {color:#000;}
.heySomething .item .option .substance {margin-top:50px;}
.heySomething .item .option .btnget {margin-top:44px;}
.heySomething .item .slide {position:relative;}
.heySomething .item .slide .slidesjs-navigation {position:absolute; z-index:60; top:197px; width:21px; height:37px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_nav_grey.png) no-repeat 0 0; text-indent:-999em;}
.heySomething .item .slide .slidesjs-previous {left:396px;}
.heySomething .item .slide .slidesjs-next {right:0; background-position:100% 0;}
.heySomething .item .slidesjs-pagination {overflow:hidden; width:1056px; margin-top:155px;}
.heySomething .item .slidesjs-pagination li {float:left; width:184px; height:166px; margin-left:34px;}
.heySomething .item .slidesjs-pagination li:first-child {margin-left:0;}
.heySomething .item .slidesjs-pagination li a {display:block; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/76405/btn_pagination_slide_01.png) no-repeat 0 0; text-indent:-999em;}
.heySomething .item .slidesjs-pagination li .active {background-position:0 100%;}
.heySomething .item .slidesjs-pagination li:first-child + li a {background-position:-219px 0;}
.heySomething .item .slidesjs-pagination li:first-child + li a.active {background-position:-219px 100%;}
.heySomething .item .slidesjs-pagination li:first-child + li + li a {background-position:-437px 0;}
.heySomething .item .slidesjs-pagination li:first-child + li + li a.active {background-position:-437px 100%;}
.heySomething .item .slidesjs-pagination li:first-child + li + li + li a {background-position:-655px 0;}
.heySomething .item .slidesjs-pagination li:first-child + li + li + li a.active {background-position:-655px 100%;}
.heySomething .item .slidesjs-pagination li:first-child + li + li + li + li a {background-position:100% 0;}
.heySomething .item .slidesjs-pagination li:first-child + li + li + li + li a.active {background-position:100% 100%;}
.heySomething .item .slideB .option {float:right; padding-top:23px;}
.heySomething .item .slideB .slidesjs-pagination li a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/76405/btn_pagination_slide_02.png);}
.heySomething .item .slideB .slidesjs-previous {left:9px;}
.heySomething .item .slideB .slidesjs-next {right:477px;}

/* visual */
.heySomething .visual {margin-top:0; padding-top:430px; }
.heySomething .visual .figure {position:relative; width:100%; height:400px; background-color:#1e2022;}
.heySomething .visual .figure a {position:absolute; top:0; left:50%; margin-left:-950px;}
.heySomething .visual .figure a p {position:absolute; top:72px; left:50%; margin-left:-112px;}
.slideUp {animation:slideUp 2s cubic-bezier(0.19, 1, 0.22, 1) forwards;}
@keyframes slideUp {
	0% {margin-top:50px; opacity:0;}
	100% {margin-top:0; opacity:1;}
}

/* brand */
.heySomething .brand {position:relative; height:1050px; margin-top:0; padding-top:480px;}
.heySomething .brand ul {overflow:hidden; position:relative; width:858px; height:468px; margin:60px auto 0;}
.heySomething .brand ul li {position:absolute; width:470px; height:230px; background-color:#535353;}
.heySomething .brand ul li img {opacity:0;}
.heySomething .brand ul li.brand1 {top:0; left:0; width:380px; height:468px;}
.heySomething .brand ul li.brand2 {top:0; right:0;}
.heySomething .brand ul li.brand3 {right:0; bottom:0;}
.heySomething .brand ul li:nth-child(2) img {animation-delay:0.3s;}
.heySomething .brand ul li:nth-child(3) img {animation-delay:0.6s;}
.opacity {animation:opacity 2s cubic-bezier(0.19, 1, 0.22, 1) forwards;}
@keyframes opacity {
	0% {opacity:0;}
	100% {opacity:1;}
}
.heySomething .brand p {margin-top:60px;}

/* story */
.heySomething .story {margin-top:450px; padding-bottom:120px;}
.heySomething .rollingwrap {margin-top:0;}
.heySomething .rolling {padding-top:0;}
.heySomething .swiper-slide {position:relative;}
.heySomething .rolling .pagination {width:980px; height:0; margin-left:-490px;}
.heySomething .rolling .swiper-pagination-switch {width:0; height:0;}
.heySomething .rolling .pagination span em {bottom:-750px; left:50%;height:120px; width:980px; margin-left:-490px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/76405/txt_story_desc.gif); cursor:default;}
.heySomething .rolling .btn-nav {top:309px;}
.heySomething .swipemask {top:0;}
.heySomething .mask-left {margin-left:-1470px;}
.heySomething .mask-right {margin-left:490px;}
.heySomething .itemList {position:absolute; top:0; left:0; z-index:30; width:980px; height:630px;}
.heySomething .itemList li {position:absolute; top:317px; left:107px; animation:bounce infinite 0.7s;}
.heySomething .itemList li img {transition:transform .7s ease;}
.heySomething .itemList li.item2 {top:452px; left:169px; animation-delay:0.2s;}
.heySomething .itemList li.item3 {top:288px; left:365px;}
.heySomething .itemList li.item4 {top:224px; left:647px; animation-delay:0.4s;}
.heySomething .itemList li.item5 {top:428px; left:710px;}
.heySomething .quality .itemList li {top:57px; left:353px;}
.heySomething .quality .itemList li.item2 {top:382px; left:105px;}
.heySomething .quality .itemList li.item3 {top:170px; left:595px;}
.heySomething .quality .itemList li.item4 {top:443px; left:558px;}
.heySomething .quality .itemList li.item5 {top:528px; left:571px;}
@keyframes bounce {
	from, to{margin-top:0; animation-timing-function:ease-out;}
	50% {margin-top:-5px; animation-timing-function:ease-in;}
}
.heySomething .itemList li a:hover img,
.heySomething .itemList li a:focus img {transform:rotate(-360deg);}

/* instagram */
.heySomething .instagram {position:relative; width:982px; margin:440px auto 0;}
.heySomething .instagram h3 {position:absolute; top:0; left:0;}
.heySomething .instagram h3 i {display:block; margin-bottom:29px; transform-origin:0 50%;}
.heySomething .instagram h3 a:hover i {animation:rotateIn 1s 1; animation-fill-mode:both;}
@keyframes rotateIn {
	0% {transform:rotate(-200deg);}
	100% {transform:rotate(0);}
}
.heySomething .instagram ul {overflow:hidden;}
.heySomething .instagram ul li {float:left; margin:30px 30px 0 0;}
.heySomething .instagram ul li:first-child {float:right; margin:0 0 0 340px;}
.heySomething .instagram .logo {position:absolute; right:93px; bottom:88px;}

/* finish */
.heySomething .finish {height:570px; margin-top:455px; background-color:#fbfcfe;}
.heySomething .finish .figure {overflow:hidden; position:absolute; top:0; left:50%; margin-left:-950px;}

/* comment */
.heySomething .commentevet {margin-top:410px;}
.heySomething .commentevet .form {margin-top:30px;}
.heySomething .commentevet .form .choice li {width:120px; height:120px; margin-right:35px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/76405/img_ico.gif); background-position:0 0;}
.heySomething .commentevet .form .choice li.ico1 button.on {background-position:0 100%;}
.heySomething .commentevet .form .choice li.ico2 button {background-position:-155px 0;}
.heySomething .commentevet .form .choice li.ico2 button.on {background-position:-155px 100%;}
.heySomething .commentevet .form .choice li.ico3 button {background-position:-309px 0;}
.heySomething .commentevet .form .choice li.ico3 button.on {background-position:-309px 100%;}
.heySomething .commentevet .form .choice li.ico4 button {background-position:100% 0;}
.heySomething .commentevet .form .choice li.ico4 button.on {background-position:100% 100%;}

.heySomething .commentevet textarea {margin-top:57px;}

.heySomething .commentlist table td strong {width:120px; height:120px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/76405/img_ico.gif); background-position:0 0;}
.heySomething .commentlist table td strong.ico2 {background-position:-155px 0;}
.heySomething .commentlist table td strong.ico3 {background-position:-309px 0;}
.heySomething .commentlist table td strong.ico4 {background-position:100% 0;}

/* css3 animation */
.pulse {animation-name:pulse; animation-duration:3s; animation-iteration-count:1;}
@keyframes pulse {
	0% {transform:scale(1.2);}
	100% {transform:scale(1);}
}
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
		<% If not( left(currenttime,10)>="2017-03-01" and left(currenttime,10)<"2017-03-08" ) Then %>
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
				<a href="/street/street_brand_sub06.asp?makerid=PRAS1010"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76405/img_item_represent.jpg" alt="프라스 브랜드 스트리트로 이동" /></a>
			</div>
		</div>

		<%' about %>
		<div class="about">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
			<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
		</div>

		<%' item %>
		<div class="item">
			<h3>
				<span class="logo"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76405/img_logo_pras_01.png" alt="PRAS" /></span>
				<span class="horizontalLine1"></span>
				<span class="horizontalLine2"></span>
			</h3>
			
			<%' slide 1 %>
			<div class="slidewrap slideA">
				<div id="slide01" class="slide">
					<% 
						Dim itemarr , itemaltarr
						IF application("Svr_Info") = "Dev" THEN
							itemarr = array(786868,786868,786868,786868,786868)
							itemaltarr = array("Shellcap Low KINARI x BLACK","Shellcap Low KINARI OFF x WHITE","Shellcap Low KURO OFF x WHITE","Shellcap Low KURO x BLACK","Shellcap Low Hanelca SUMI x BLACK")
						Else
							itemarr = array(1652915,1652916,1652927,1652926,1652933)
							itemaltarr = array("Shellcap Low KINARI x BLACK","Shellcap Low KINARI OFF x WHITE","Shellcap Low KURO OFF x WHITE","Shellcap Low KURO x BLACK","Shellcap Low Hanelca SUMI x BLACK")
						End If

						Dim lp 
						For lp = 0 To ubound(itemarr) '5개

						set oItem = new CatePrdCls
							oItem.GetItemData itemarr(lp)
							'Response.write itemarr(lp) &"<br/>"
						
					%>
					<% If oItem.FResultCount > 0 Then %>
					<div class="desc">
						<div class="option">
							<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76405/txt_name_shoes_0<%=(lp+1)%>.png" alt="Shellcap Low KINARI x BLACK" /></p>
							<div class="price">
								<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
							</div>
							<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76405/txt_substance_shoes.png" alt="뛰어난 퀄리티를 자랑하는 코지마 캔버스를 사용한 스니커즈입니다. 발가락 보호를 위한 Shellcap은 조개를 모티브로 제작된 점이 특징입니다. PRAS 스니커즈는 주문·제작 시스템으로 수개월 간의 수작업으로 진행되어 만들어졌습니다. 일본 장인들의 기술을 고스란히 담아낸 PRAS를 소개합니다." /></p>
							<div class="btnget"><a href="/shopping/category_prd.asp?itemid=<%=itemarr(lp)%>&pEtr=76405"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러 가기" /></a></div>
						</div>
						<div class="figure"><a href="/shopping/category_prd.asp?itemid=<%=itemarr(lp)%>&pEtr=76405"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76405/img_figure_shoes_0<%=(lp+1)%>.gif" alt="" /></a></div>
					</div>
					<% End If %>
					<% 
						set oItem=nothing
						Next 
					%>
				</div>
			</div>

			<%' slide 2 %>
			<div class="slidewrap slideB">
				<div id="slide02" class="slide">
					<% 
						Dim itemarr2 , itemaltarr2
						IF application("Svr_Info") = "Dev" THEN
							itemarr2 = array(786868,786868,786868,786868,786868)
							itemaltarr2 = array("Shoulder Tote KINARI x SUMI","Passport Case KINARI x SUMI","Document Case KINARI x SUMI","Kamibukuro KINARI x SUMI","Shose Case KINARI 100% cotton")
						Else
							itemarr2 = array(1652967,1652934,1652966,1652968,1654154)
							itemaltarr2 = array("Shoulder Tote KINARI x SUMI","Passport Case KINARI x SUMI","Document Case KINARI x SUMI","Kamibukuro KINARI x SUMI","Shose Case KINARI 100% cotton")
						End If

						Dim lp2 
						For lp2 = 0 To ubound(itemarr2) '5개

						set oItem = new CatePrdCls
							oItem.GetItemData itemarr2(lp2)
					%>
					<% If oItem.FResultCount > 0 Then %>
					<div class="desc">
						<div class="option">
							<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76405/txt_name_acc_0<%=lp2+1%>.png" alt="<%=itemaltarr2(lp2)%>" /></p>
							<div class="price">
								<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
							</div>
							<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76405/txt_substance_acc.png" alt="PRAS의 견고한 캔버스 천은 세월이 흘러도 멋스러움을 간직합니다. 무심한 듯 유니크한 KINARI x SUMI시리즈들을 소개합니다. PRAS 잡화 라인은 오직 텐바이텐에서만 만나보실 수 있어요!" /></p>
							<div class="btnget"><a href="/shopping/category_prd.asp?itemid=<%=itemarr2(lp2)%>&pEtr=76405"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러 가기" /></a></div>
						</div>
						<div class="figure"><a href="/shopping/category_prd.asp?itemid=<%=itemarr2(lp2)%>&pEtr=76405"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76405/img_figure_acc_0<%=lp2+1%>.gif" alt="" /></a></div>
					</div>
					<% End If %>
					<% 
						set oItem=nothing

						Next 
					%>
				</div>
			</div>
		</div>

		<%' visual %>
		<div class="visual">
			<div class="figure">
				<a href="/street/street_brand_sub06.asp?makerid=PRAS1010">
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76405/txt_visual.png" alt="Anywhere You Go" /></p>
					<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76405/img_visual.jpg" alt="PRAS Shellcap Low" />
				</a>
			</div>
		</div>

		<%' brand %>
		<div id="brand" class="brand">
			<a href="/street/street_brand_sub06.asp?makerid=PRAS1010" title="프라스 브랜드 스트리트로 이동">
				<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey//76405/img_logo_pras_02.png" alt="프라스" /></h3>
				<ul>
					<li class="brand1"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76405/img_brand_01.jpg" alt="" /></li>
					<li class="brand2"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76405/img_brand_02.jpg" alt="" /></li>
					<li class="brand3"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76405/img_brand_03.jpg" alt="" /></li>
				</ul>
			</a>
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76405/txt_brand.png" alt="" /></p>
			<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="" /></div>
		</div>

		<%' story %>
		<div class="story">
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
									<a href="/street/street_brand_sub06.asp?makerid=PRAS1010"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76405/img_slide_story_01.jpg" alt="" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/street/street_brand_sub06.asp?makerid=PRAS1010"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76405/img_slide_story_02.jpg" alt="" /></a>
								</div>
								<div class="swiper-slide feet">
									<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76405/img_slide_story_03.jpg" alt="" />
									<ul class="itemList">
										<li class="item1"><a href="/shopping/category_prd.asp?itemid=1652933&pEtr=76405"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76405/btn_plus.png" alt="Shellcap Low Hanelca SUMI x BLACK" /></a></li>
										<li class="item2"><a href="/shopping/category_prd.asp?itemid=1652916&pEtr=76405"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76405/btn_plus.png" alt="Shellcap Low KINARI x OFF WHITE" /></a></li>
										<li class="item3"><a href="/shopping/category_prd.asp?itemid=1652927&pEtr=76405"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76405/btn_plus.png" alt="hellcap Low KURO x OFF WHITE" /></a></li>
										<li class="item4"><a href="/shopping/category_prd.asp?itemid=1652915&pEtr=76405"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76405/btn_plus.png" alt="Shellcap Low KINARI x BLACK" /></a></li>
										<li class="item5"><a href="/shopping/category_prd.asp?itemid=1652926&pEtr=76405"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76405/btn_plus.png" alt="Shellcap Low KURO x BLACK" /></a></li>
									</ul>
								</div>
								<div class="swiper-slide quality">
									<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76405/img_slide_story_04.jpg" alt="" />
									<ul class="itemList">
										<li class="item1"><a href="/shopping/category_prd.asp?itemid=1652967&pEtr=76405"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76405/btn_plus.png" alt="Shoulder Tote KINARI x SUMI" /></a></li>
										<li class="item2"><a href="/shopping/category_prd.asp?itemid=1652933&pEtr=76405"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76405/btn_plus.png" alt="Shellcap Low Hanelca SUMI x BLACK" /></a></li>
										<li class="item3"><a href="/shopping/category_prd.asp?itemid=1652968&pEtr=76405"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76405/btn_plus.png" alt="Kamibukuro KINARI x SUM" /></a></li>
										<li class="item4"><a href="/shopping/category_prd.asp?itemid=1652934&pEtr=76405"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76405/btn_plus.png" alt=" Passport Case KINARI x SUMI" /></a></li>
										<li class="item5"><a href="/shopping/category_prd.asp?itemid=1652966&pEtr=76405"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76405/btn_plus.png" alt="Document Case KINARI x SUMI" /></a></li>
									</ul>
								</div>
							</div>
						</div>
					</div>
					<div class="pagination"></div>
				</div>
			</div>
		</div>

		<%' finish %>
		<div id="finish" class="finish">
			<a href="/street/street_brand_sub06.asp?makerid=PRAS1010">
				<div class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76405/img_finish.jpg" alt="The Mason Shaker" /></div>
			</a>
		</div>

		<%' instagram %>
		<div class="instagram">
			<h3>
				<a href="http://pras2015.jp/instagram/" target="_blank">
					<i><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76405/ico_instagram.png" alt="" /></i>
					<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76405/tit_pras_instagram.png" alt="프라스 인스타그램 공식계정으로 이동 새창" />
				</a>
			</h3>
			<ul>
				<li><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76405/img_instagram_01.jpg" alt="" /></li>
				<li><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76405/img_instagram_02.jpg" alt="" /></li>
				<li><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76405/img_instagram_03.jpg" alt="" /></li>
			</ul>
			<span class="logo"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76405/img_logo_pras_01.png" alt="Paradise rubber athletics shoes" /></span>
		</div>
		
		<%' comment %>
		<div class="commentevet">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76405/tit_comment.gif" alt="Hey, something project 당신이 신고 싶은 것" /></h3>
			<p class="hidden">내가 가장 신고 싶은 신발은 무엇인가요? 정성껏 코멘트를 남겨주신 1분을 추첨하여 PRAS 슈즈를 선물로 드립니다. 코멘트 기재시, 사이즈 기재 필수며, 스타일은 랜덤으로 배송됩니다. 코멘트 작성기간은 2017년 3월 1일부터 3월 7일까지며, 발표는 2017년 3월 8일 입니다.</p>
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
							<li class="ico1"><button type="button" value="1">Value</button></li>
							<li class="ico2"><button type="button" value="2">Minimal</button></li>
							<li class="ico3"><button type="button" value="3">Feet</button></li>
							<li class="ico4"><button type="button" value="4">Quality</button></li>
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

			<% '' commentlist %>
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
												Value
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="2" then %>
												Minimal
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="3" then %>
												Feet
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="4" then %>
												Quality
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
	/* slide js */
	$("#slide01").slidesjs({
		width:"1050",
		height:"432",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:false
	});

	$("#slide02").slidesjs({
		width:"1050",
		height:"432",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:false
	});

	//mouse control
	$('#slide01 .slidesjs-pagination > li a').mouseenter(function(){
		$('#slide01 a[data-slidesjs-item="' + $(this).attr("data-slidesjs-item") + '"]').trigger('click');
	});
	$('#slide02 .slidesjs-pagination > li a').mouseenter(function(){
		$('#slide02 a[data-slidesjs-item="' + $(this).attr("data-slidesjs-item") + '"]').trigger('click');
	});

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

	/* title animation */
	titleAnimation();
	$(".heySomething .topic h2 span").css({"width":"50px", "opacity":"0"});
	function titleAnimation() {
		$(".heySomething .topic h2 .letter1").delay(100).animate({"width":"125px", "opacity":"1"},1200);
		$(".heySomething .topic h2 .letter2").delay(300).animate({"width":"349px", "opacity":"1"},1200);
		$(".heySomething .topic h2 .letter3").delay(500).animate({"width":"206px", "opacity":"1"},1200);
	}
	
	/* visual animation */
	function visualAnimation() {
		var window_top = $(window).scrollTop();
		var div_top = $(".heySomething .visual").offset().top;
		if (window_top > div_top){
			$(".heySomething .visual p").addClass("slideUp");
		} else {
			$(".heySomething .visual p").removeClass("slideUp");
		}
	}

	/* brand animation */
	function brandAnimation() {
		var window_top = $(window).scrollTop();
		var div_top = $(".heySomething .brand").offset().top;
		if (window_top > div_top){
			$("#brand ul li img").addClass("opacity");
		} else {
			$("#brand ul li img").removeClass("opacity");
		}
	}

	/* finish animation */
	function finishAnimation() {
		var window_top = $(window).scrollTop();
		var div_top = $("#rolling").offset().top;
		if (window_top > div_top){
			$("#finish .figure img").addClass("pulse");
		} else {
			$("#finish .figure img").removeClass("pulse");
		}
	}

	$(function() {
		$(window).scroll(visualAnimation);
		visualAnimation();

		$(window).scroll(brandAnimation);
		brandAnimation();

		$(window).scroll(finishAnimation);
		finishAnimation();
	});
});
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->