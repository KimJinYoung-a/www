<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈 16
' History : 2015.12.22 원승현 생성
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
	'currenttime = #10/07/2015 09:00:00#

dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  65993
Else
	eCode   =  68133
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
IF application("Svr_Info") = "Dev" THEN
	itemid   =  1239115
Else
	itemid   =  1403591
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

<style type="text/css">
/* title */
.heySomething .topic {background:#eee9eb url(http://webimage.10x10.co.kr/eventIMG/2015/hey/68133/img_item_represent_v2.jpg) no-repeat 50% 0;}
.heySomething .topic h2 {top:39px; width:360px; height:189px; padding-top:10px; padding-left:20px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/hey/68133/bg_title.png);}
.heySomething .topic h2 .letter2 {margin-top:5px;}
.heySomething .topic h2 .letter3 {margin-top:8px;}
.heySomething .topic .bnr {text-indent:-9999em;}
.heySomething .topic .bnr a {display:block; width:100%; height:780px;}

/* item */
.heySomething .itemB {padding-bottom:261px;}
.heySomething .itemB .desc {padding-left:415px;}
.heySomething .itemB .desc .option {z-index:50;}
.heySomething .itemB h3 {
	transition:1.5s ease-in-out; transform-origin:60% 0%; transform:rotateX(200deg); opacity:0;
	-webkit-transition:1.5s ease-in-out; -webkit-transform-origin:60% 0%; -webkit-transform:rotateX(200deg);
}
.heySomething .itemB h3.rotate {transform:rotateX(360deg); -webkit-transform:rotateX(360deg); opacity:1;}
.heySomething .itemB .slidewrap .slide {width:725px; height:575px;}
.heySomething .itemB .slidesjs-pagination {bottom:-207px;}
.heySomething .itemB .slidesjs-pagination li a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/hey/68133/bg_pagination.jpg);}

/* visual */
.heySomething .visual {padding-bottom:0;}
.heySomething .visual .figure {background-color:#f8edf4;}
.heySomething #slider {height:390px; margin-top:100px;}
.heySomething #slider .slide-img {width:250px; height:390px; margin:0 20px;}
.heySomething #slider .slide-img ul {padding-left:40px;}
.heySomething #slider .slide-img ul li {width:190px; height:35px;}
.heySomething #slider .slide-img ul li a {overflow:hidden; display:block; position:relative; width:100%; height:100%; color:#777; font-size:11px; line-height:35px; text-align:center;}
.heySomething #slider .slide-img ul li a span {display:block; position:absolute; top:0; left:0; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2015/hey/68133/bg_txt_option.png) no-repeat 0 0;}
.heySomething #slider .slide-img ul li.option2 a span {background-position:0 -35px;}
.heySomething #slider .slide-img ul li.option3 a span {background-position:0 -71px;}
.heySomething #slider .slide-img ul li.option4 a span {background-position:0 -106px;}

/* brand */
.heySomething .brand {height:552px;}
.heySomething .brand p {margin-top:42px;}

/* story */
.heySomething .rolling {width:100%; height:780px;}
.heySomething .slidesjs-slide {width:100%;  height:780px;}
.heySomething .slidesjs-slide-01 {background:#fdbe8a url(http://webimage.10x10.co.kr/eventIMG/2015/hey/68133/bg_img_slide_01.jpg) no-repeat 50% 0;}
.heySomething .slidesjs-slide-02 {background:#c28d3b url(http://webimage.10x10.co.kr/eventIMG/2015/hey/68133/bg_img_slide_02.jpg) no-repeat 50% 0;}
.heySomething .slidesjs-slide-03 {background:#74cbdd url(http://webimage.10x10.co.kr/eventIMG/2015/hey/68133/bg_img_slide_03.jpg) no-repeat 50% 0;}
.heySomething .slidesjs-slide-04 {background:#01aad5 url(http://webimage.10x10.co.kr/eventIMG/2015/hey/68133/bg_img_slide_04.jpg) no-repeat 50% 0;}
.heySomething .slidesjs-slide-05 {background:#f7f7f7 url(http://webimage.10x10.co.kr/eventIMG/2015/hey/68133/bg_img_slide_05.jpg) no-repeat 50% 0;}
.heySomething .slidesjs-slide-06 {background:#facb00 url(http://webimage.10x10.co.kr/eventIMG/2015/hey/68133/bg_img_slide_06.jpg) no-repeat 50% 0;}
.heySomething .slidesjs-slide a {display:block; position:relative; width:100%; height:100%;}
.heySomething .slidesjs-slide .desc {position:absolute;}
.heySomething .slidesjs-slide-01 .desc {top:173px; left:50%; margin-left:184px;}
.heySomething .slidesjs-slide-02 .desc {top:203px; left:50%; margin-left:-284px;}
.heySomething .slidesjs-slide-03 .desc {top:642px; left:50%; margin-left:-173px;}
.heySomething .slidesjs-slide-04 .desc {top:185px; left:50%; margin-left:-253px;}
.heySomething .slidesjs-slide-05 .desc {top:173px; left:50%; margin-left:-210px;}
.heySomething .slidesjs-slide-06 .desc {top:95px; left:50%; margin-left:143px;}

.heySomething .rolling .slidesjs-pagination {position:absolute; left:50%; top:0; width:1020px; margin-left:-510px;}
.heySomething .rolling .slidesjs-pagination li {float:left; width:150px; height:150px; margin:0 10px;}
.heySomething .rolling .slidesjs-pagination li a {display:block; width:150px; height:150px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/hey/68133/bg_ico.png) no-repeat 0 0; text-indent:-999em;}
.heySomething .rolling .slidesjs-pagination li a:hover,
.heySomething .rolling .slidesjs-pagination li a.active {background-position:0 -150px;}
.heySomething .rolling .slidesjs-pagination .num02 a {background-position:-150px 0;}
.heySomething .rolling .slidesjs-pagination .num02 a:hover,
.heySomething .rolling .slidesjs-pagination .num02 .active {background-position:-150px -150px;}
.heySomething .rolling .slidesjs-pagination .num03 a {background-position:-300px 0;}
.heySomething .rolling .slidesjs-pagination .num03 a:hover,
.heySomething .rolling .slidesjs-pagination .num03 .active {background-position:-300px -150px;}
.heySomething .rolling .slidesjs-pagination .num04 a {background-position:-450px 0;}
.heySomething .rolling .slidesjs-pagination .num04 a:hover,
.heySomething .rolling .slidesjs-pagination .num04 .active {background-position:-450px -150px;}
.heySomething .rolling .slidesjs-pagination .num05 a {background-position:-600px 0;}
.heySomething .rolling .slidesjs-pagination .num05 a:hover,
.heySomething .rolling .slidesjs-pagination .num05 .active {background-position:-600px -150px;}
.heySomething .rolling .slidesjs-pagination .num06 a {background-position:-750px 0;}
.heySomething .rolling .slidesjs-pagination .num06 a:hover,
.heySomething .rolling .slidesjs-pagination .num06 .active {background-position:-750px -150px;}

.heySomething .rolling .slidesjs-navigation {position:absolute; top:510px; left:50%; z-index:50; width:33px; height:64px; background:transparent url(http://webimage.10x10.co.kr/eventIMG/2015/hey/68133/btn_nav.png) no-repeat 0 0; text-indent:-999em}
.heySomething .rolling .slidesjs-previous {margin-left:-545px;}
.heySomething .rolling .slidesjs-next {margin-left:520px; background-position:100% 0;}

/* finish */
.heySomething .finish {background-color:#fbdc9a;}
.heySomething .finish .bg {position:absolute; top:0; left:0; z-index:5; width:100%; height:850px; background:transparent url(http://webimage.10x10.co.kr/eventIMG/2015/hey/68133/img_item_finish_v1.jpg) no-repeat 50% 0; transition:all 0.5s;}
.heySomething .finish p {top:165px; margin-left:60px;}

/* comment */
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/hey/68133/bg_ico.png); background-position:0 -300px;}
.heySomething .commentevet .form .choice li.ico1 button.on {background-position:0 100%;}
.heySomething .commentevet .form .choice li.ico2 button {background-position:-150px -300px;}
.heySomething .commentevet .form .choice li.ico3 button {background-position:-300px -300px;}
.heySomething .commentevet .form .choice li.ico4 button {background-position:-450px -300px;}
.heySomething .commentevet .form .choice li.ico5 button {background-position:-600px -300px;}
.heySomething .commentevet .form .choice li.ico6 button {background-position:-750px -300px;}

.heySomething .commentlist table td strong {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/hey/68133/bg_ico.png); background-position:0 -20px;}
.heySomething .commentlist table td strong.ico2 {background-position:-150px -20px;}
.heySomething .commentlist table td strong.ico3 {background-position:-300px -20px;}
.heySomething .commentlist table td strong.ico4 {background-position:-450px -20px;}
.heySomething .commentlist table td strong.ico5 {background-position:-600px -20px;}
.heySomething .commentlist table td strong.ico6 {background-position:-750px -20px;}
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
		<% If not( left(currenttime,10)>="2015-12-22" and left(currenttime,10)<"2015-12-30" ) Then %>
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
			<div class="bnr"><a href="/street/street_brand_sub06.asp?makerid=woouf1010">WOOUF</a></div>
		</div>

		<%' about %>
		<div class="about">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
			<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
		</div>

		<%' item %>
		<div class="item itemB">
			<div class="inner">
				<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/68133/tit_woouf.png" alt="WOOUF" /></h3>
				<div class="desc">
				<%' 상품 이름, 가격, 구매하기 %>
					<div class="option">
						<em class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/68133/txt_name.png" alt="WOOUF Laptop Sleeve 13형" /></em>
						<% if oItem.FResultCount > 0 then %>
							<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
								<div class="price">
									<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/txt_only_<%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>percent.png" alt="텐바이텐에서만 ONLY <%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%" /></strong>
									<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								</div>
							<% Else %>
								<%' for dev msg : 종료 후 %>
								<div class="price priceEnd" style="display:none;">
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								</div>
							<% End If %>
						<% end if %>
						<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/68133/txt_substance.png" alt="늘 비슷한 옷으로 지루해하던 노트북과 태블릿PC가 풍성한 패턴 속에 푹 빠졌어요! 스페인의 젊은 감각이 모여 만들어 낸 재미있는 상상을 부르는 6개의 슬리브 이야기." /></p>
						<div class="btnget">
							<a href="/shopping/category_prd.asp?itemid=1403591&amp;pEtr=68133"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="Laptop Sleeve Pineapple 13형 구매하러 가기" /></a>
						</div>
					</div>

					<div class="slidewrap">
						<div id="slide01" class="slide">
							<div><a href="/shopping/category_prd.asp?itemid=1403591&amp;pEtr=68133"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/68133/img_figure_01_v1.jpg" alt="" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1403591&amp;pEtr=68133"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/68133/img_figure_02_v1.jpg" alt="" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1403591&amp;pEtr=68133"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/68133/img_figure_03_v1.jpg" alt="" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1403591&amp;pEtr=68133"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/68133/img_figure_04_v2.jpg" alt="" /></a></div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<%' visual %>
		<div class="visual">
			<div class="figure"><a href="/shopping/category_prd.asp?itemid=1403591&amp;pEtr=68133"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/68133/img_item_visual_big.jpg" alt="Laptop Sleeve Pineapple" /></a></div>
			<div id="slider" class="slider-horizontal">
				<div class="slide-img">
					<img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/68133/img_item_visual_01.png" alt="Banana" />
					<ul>
						<li class="option1"><a href="/shopping/category_prd.asp?itemid=1403587&amp;pEtr=68133"><span></span>Laptop 13인치</a></li>
						<li class="option2"><a href="/shopping/category_prd.asp?itemid=1403586&amp;pEtr=68133"><span></span>Laptop 11인치</a></li>
						<li class="option3"><a href="/shopping/category_prd.asp?itemid=1385708&amp;pEtr=68133"><span></span>iPad</a></li>
						<li class="option4"><a href="/shopping/category_prd.asp?itemid=1385757&amp;pEtr=68133"><span></span>iPad Mini</a></li>
					</ul>
				</div>
				<div class="slide-img">
					<img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/68133/img_item_visual_02.png" alt="Cactus" />
					<ul>
						<li class="option1"><a href="/shopping/category_prd.asp?itemid=1403589&amp;pEtr=68133"><span></span>Laptop 13인치</a></li>
						<li class="option2"><a href="/shopping/category_prd.asp?itemid=1403588&amp;pEtr=68133"><span></span>Laptop 11인치</a></li>
						<li class="option3"><a href="/shopping/category_prd.asp?itemid=1385744&amp;pEtr=68133"><span></span>iPad</a></li>
						<li class="option4"><a href="/shopping/category_prd.asp?itemid=1385761&amp;pEtr=68133"><span></span>iPad Mini</a></li>
					</ul>
				</div>
				<div class="slide-img">
					<img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/68133/img_item_visual_03.png" alt="Pineapple" />
					<ul>
						<li class="option1"><a href="/shopping/category_prd.asp?itemid=1403591&amp;pEtr=68133"><span></span>Laptop 13인치</a></li>
						<li class="option2"><a href="/shopping/category_prd.asp?itemid=1403590&amp;pEtr=68133"><span></span>Laptop 11인치</a></li>
						<li class="option3"><a href="/shopping/category_prd.asp?itemid=1385747&amp;pEtr=68133"><span></span>iPad</a></li>
						<li class="option4"><a href="/shopping/category_prd.asp?itemid=1385764&amp;pEtr=68133"><span></span>iPad Mini</a></li>
					</ul>
				</div>
				<div class="slide-img">
					<img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/68133/img_item_visual_04.png" alt="Cats" />
					<ul>
						<li class="option1"><a href="/shopping/category_prd.asp?itemid=1403595&amp;pEtr=68133"><span></span>Laptop 13인치</a></li>
						<li class="option2"><a href="/shopping/category_prd.asp?itemid=1403594&amp;pEtr=68133"><span></span>Laptop 11인치</a></li>
						<li class="option3"><a href="/shopping/category_prd.asp?itemid=1385752&amp;pEtr=68133"><span></span>iPad</a></li>
						<li class="option4"><a href="/shopping/category_prd.asp?itemid=1385767&amp;pEtr=68133"><span></span>iPad Mini</a></li>
					</ul>
				</div>
				<div class="slide-img">
					<img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/68133/img_item_visual_05.png" alt="Dripping" />
					<ul>
						<li class="option1"><a href="/shopping/category_prd.asp?itemid=1403597&amp;pEtr=68133"><span></span>Laptop 13인치</a></li>
						<li class="option2"><a href="/shopping/category_prd.asp?itemid=1403596&amp;pEtr=68133"><span></span>Laptop 11인치</a></li>
						<li class="option3"><a href="/shopping/category_prd.asp?itemid=1385754&amp;pEtr=68133"><span></span>iPad</a></li>
						<li class="option4"><a href="/shopping/category_prd.asp?itemid=1385770&amp;pEtr=68133"><span></span>iPad Mini</a></li>
					</ul>
				</div>
				<div class="slide-img">
					<img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/68133/img_item_visual_06.png" alt="School" />
					<ul>
						<li class="option1"><a href="/shopping/category_prd.asp?itemid=1403593&amp;pEtr=68133"><span></span>Laptop 13인치</a></li>
						<li class="option2"><a href="/shopping/category_prd.asp?itemid=1403592&amp;pEtr=68133"><span></span>Laptop 11인치</a></li>
						<li class="option3"><a href="/shopping/category_prd.asp?itemid=1385750&amp;pEtr=68133"><span></span>iPad</a></li>
						<li class="option4"><a href="/shopping/category_prd.asp?itemid=1385766&amp;pEtr=68133"><span></span>iPad Mini</a></li>
					</ul>
				</div>
			</div>
		</div>

		<%' brand %>
		<div class="brand">
			<span class="logo"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/68133/img_logo_woouf.png" alt="woouf" /></span>
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/68133/txt_brand.png" alt="10년간 패션 업계에서 종사하던 Pablo Martinez와 Alice Penaud는 그들의 지식과 경험을 인테리어 디자인에 적용시켜 유니크하고 독창적인 브랜드 Woouf를 만들었습니다. 그들은 도시 문화, 음악, 예술, 일상 오브젝트 등에서 영감을 받은 독특한 빈백 Bean Bag 컬렉션을 시작으로 젊고 감각적인 이들을 위한 다양한 제품을 디자인하였습니다. 지금은 25개가 넘는 나라에 제품을 판매하며 전세계적으로 많은 사랑을 받고 있습니다." /></p>
			<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="" /></div>
		</div>

		<%' story %>
		<div class="story">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/68133/tit_story.png" alt="도톰한 슬리브 속 익살스러운 상상" /></h3>
			<div id="slide02" class="rolling">
				<div class="slidesjs-slide-01">
					<a href="/street/street_brand_sub06.asp?makerid=woouf1010">
						<p class="desc"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/68133/txt_desc_01.png" alt="바나나, 하면 떠오르는 말장난. 바나나를 먹으면 나한테 반하나?" /></p>
					</a>
				</div>
				<div class="slidesjs-slide-02">
					<a href="/street/street_brand_sub06.asp?makerid=woouf1010">
						<p class="desc"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/68133/txt_desc_02.png" alt="선인장은 짝사랑 같다. 물을 주지 않아도, 어루만져 주지 않아도 어딘가에서 조용히 꽃을 피우는 수많은 짝사랑들..!" /></p>
					</a>
				</div>
				<div class="slidesjs-slide-03">
					<a href="/street/street_brand_sub06.asp?makerid=woouf1010">
						<p class="desc"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/68133/txt_desc_03.png" alt="파인애플, 통통하고 거친 우리 엄마의 손을 닮았다" /></p>
					</a>
				</div>
				<div class="slidesjs-slide-04">
					<a href="/street/street_brand_sub06.asp?makerid=woouf1010">
						<p class="desc"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/68133/txt_desc_04.png" alt="어린 마음에도 불쌍했던 추억의 애니메이션 꾸러기 수비대의 고양이. 오도카니 앉아 있는 고양이들을 보면 가끔 그 생각이 나 측은하다." /></p>
					</a>
				</div>
				<div class="slidesjs-slide-05">
					<a href="/street/street_brand_sub06.asp?makerid=woouf1010">
						<p class="desc"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/68133/txt_desc_05.png" alt="다 먹은 우유갑을 접을 때 입구에서 퐁퐁 나오던 우유 방울, 아니면 에에에취! 영혼까지 빠져나갈 것만 같은 시원한 재채기" /></p>
					</a>
				</div>
				<div class="slidesjs-slide-06">
					<a href="/street/street_brand_sub06.asp?makerid=woouf1010">
						<p class="desc"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/68133/txt_desc_06.png" alt="이제는 추억의 드라마나 영화에서나 볼 수 있는 교련복, 혹은 개학 전날 새벽 잠결에 봤던 텔레비전 노이즈 화면" /></p>
					</a>
				</div>
			</div>
		</div>

		<%' finish %>
		<div class="finish">
			<a href="/street/street_brand_sub06.asp?makerid=woouf1010">
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/68133/txt_finish.png" alt="즐거운 상상으로 가득한 일상" /></p>
				<div class="bg"></div>
			</a>
		</div>

		<%' comment %>
		<div class="commentevet">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/68133/tit_comment_v2.png" alt="Hey, something project 당신이 갖고 싶은 것" /></h3>
			<p class="hidden">무엇을 상상하든, 자유! 어떻게 표현하든, 그것 또한 자유! WOOUF 슬리브의 패턴을 보고 연상되는 것을 자유롭게 적어 주세요. 정성껏 코멘트를 남겨주신 3분을 추첨하여 WOOUF 아이패드 슬리브를 드립니다. 원하는 사이즈를 꼭 기재해 주세요  13인치, 11인치, iPad, iPand Mini 중 택1 디자인은 랜덤 발송됩니다. 코멘트 작성기간은 2015년 12월 23일부터 12월 29일까지며, 발표는 12월 31일 입니다.</p>

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
					<legend>WOOUF 코멘트 쓰기</legend>
						<ul class="choice">
							<li class="ico1"><button type="button" value="1">Banana</button></li>
							<li class="ico2"><button type="button" value="2">Cactus</button></li>
							<li class="ico3"><button type="button" value="3">Pineapple</button></li>
							<li class="ico4"><button type="button" value="4">Cats</button></li>
							<li class="ico5"><button type="button" value="5">Dripping</button></li>
							<li class="ico6"><button type="button" value="6">School</button></li>
						</ul>
						<textarea name="txtcomm1" id="txtcomm1" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();" <%IF NOT(IsUserLoginOK) THEN%>readonly<%END IF%> title="" cols="60" rows="5"><%IF NOT IsUserLoginOK THEN%>로그인 후 글을 남길 수 있습니다.<% else %><%END IF%></textarea>
						<div class="note01 overHidden">
							<ul class="list01 ftLt">
								<li>입력하신 블로그 주소는 개인정보 유출로 인한 피해를 막고자 비공개로 텐바이텐에 접수됩니다.</li>
								<li>통신예절에 어긋나는 글이나 상업적인 글, 타 사이트에 관련된 글 또는 도용한 글은 관리자에 의해 사전 통보 없이 삭제될 수 있으며,<br>이벤트 참여에 제한을 받을 수 있습니다.</li>
							</ul>
							<input type="submit" onclick="jsSubmitComment(document.frmcom); return false;"  class="ftRt btn btnW130 btnS1 btnRed" value="코멘트 남기기">
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
						<caption>WOOUF 코멘트 목록</caption>
						<colgroup>
							<col style="width:150px;" />
							<col style="width:*;" />
							<col style="width:110px;" />
							<col style="width:120px;" />
							<col style="width:10px;" />
						</colgroup>
						<thead>
						<tr>
							<th scope="col"></th>
							<th scope="col">내용</th>
							<th scope="col">작성일자</th>
							<th scope="col">아이디</th>
							<th scope="col"></th>
						</tr>
						</thead>
						<tbody>
							<% For intCLoop = 0 To UBound(arrCList,2) %>
							<tr>
								<td>
									<% if isarray(split(arrCList(1,intCLoop),"!@#")) then %>
										<strong class="ico<%= split(arrCList(1,intCLoop),"!@#")(0) %>">
											<% if split(arrCList(1,intCLoop),"!@#")(0)="1" then %>
												Banana
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="2" then %>
												Cactus
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="3" then %>
												Pineapple
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="4" then %>
												Cats
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="5" then %>
												Dripping
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="6" then %>
												School
											<% Else %>
												Banana
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

<script type="text/javascript" src="/lib/js/jquery.flowslider.js"></script>
<script type="text/javascript">
$(function(){
	$("#slider").FlowSlider({
		marginStart:0,
		marginEnd:0,
		//position:0.0,
		startPosition:0.55
	});

	/* slide js */
	$("#slide01").slidesjs({
		width:"725",
		height:"485",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:2500, effect:"fade", auto:true},
		effect:{fade: {speed:2000, crossfade:true}
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

	$("#slide02").slidesjs({
		width:"1140",
		height:"780",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:5000, effect:"fade", auto:true},
		effect:{fade: {speed:800}},
		callback: {
			start: function() {
				$(".heySomething #slide02 .slidesjs-slide .desc").css({"margin-top":"5px", "opacity":"0"});
			},
			complete: function() {
				$(".heySomething #slide02 .slidesjs-slide .desc").delay(10).animate({"margin-top":"0", "opacity":"1"},500);
			}
		}
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
		if (scrollTop > 700 ) {
			itemAnimation()
		}
		if (scrollTop > 3400 ) {
			brandAnimation()
		}
		if (scrollTop > 6000 ) {
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

	/* item animation */
	function itemAnimation() {
		$(".heySomething .item h3").delay(50).addClass("rotate");
	}

	/* brand animation */
	$(".heySomething .brand p").css({"height":"50px", "opacity":"0"});
	$(".heySomething .brand .btnDown").css({"opacity":"0"});
	function brandAnimation() {
		$(".heySomething .brand p").delay(50).animate({"height":"221px", "opacity":"1"},1200);
		$(".heySomething .brand .btnDown").delay(800).animate({"opacity":"1"},1200);
	}

	$(".heySomething .finish p").css({"width":"100px", "opacity":"0"});
	/* finish animation */
	function finishAnimation() {
		$(".heySomething .finish p").delay(50).animate({"width":"304px", "opacity":"1"},1000);
	}
});
</script>
<%
set oItem=nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->