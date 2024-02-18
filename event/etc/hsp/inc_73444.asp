<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈
' History : 2016-10-04 김진영 생성
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
	eCode   =  66210
Else
	eCode   =  73444
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
.heySomething .topic {height:794px; background-color:#414847;}
.heySomething .topic h2 {z-index:5;}
.heySomething .topic h2 span {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_hey_something_project_white.png);}
.heySomething .topic .figure {position:relative; width:100%; height:794px;}
.heySomething .topic .figure img {position:absolute; top:0; left:50%; margin-left:-951px;}

/* brand */
.heySomething .brand {position:relative; height:930px; margin-top:330px;}
.heySomething .brand ul {overflow:hidden; position:relative; width:706px; height:393px; margin:60px auto 0;}
.heySomething .brand ul li {position:absolute; top:0;}
.heySomething .brand ul li.brand1 {left:0;}
.heySomething .brand ul li.brand2 {left:237px;}
.heySomething .brand ul li.brand3 {right:0;}
.heySomething .brand ul li .over {position:absolute; top:0; left:0; opacity:0; filter:alpha(opacity=0); transition:opacity 0.4s;}
.heySomething .brand ul li:hover .over {opacity:1; filter:alpha(opacity=100);}
.heySomething .brand p {margin-top:75px;}

/* item */
.heySomething .itemB {margin-top:370px; padding-bottom:405px; background:none;}
.heySomething .itemB .bg {position:absolute; bottom:0; left:0; width:100%; height:303px; border-bottom:1px solid #ddd; background-color:#f5f5f5;}
.heySomething .itemB h3 {position:relative; height:54px; text-align:center;}
.heySomething .itemB h3 .horizontalLine1, .heySomething .item h3 .horizontalLine2 {position:absolute; top:17px; width:388px; height:1px; background-color:#ddd;}
.heySomething .itemB h3 .horizontalLine1 {left:0;}
.heySomething .itemB h3 .horizontalLine2 {right:0;}
.heySomething .itemB .desc {margin-top:115px;}
.heySomething .itemB .desc .option {top:0; height:550px;}
.heySomething .item .option .substance {bottom:100px;}
.heySomething .itemB .slidewrap .slide {width:676px; height:550px; margin-top:25px; text-align:center;}
.heySomething .itemB .slidewrap .slide .slidesjs-container {height:550px !important;}
.heySomething .itemB .slidewrap .slide .slidesjs-previous {left:490px;}
.heySomething .itemB .slidesjs-pagination {bottom:-360px;}
.heySomething .itemB .slidesjs-pagination li a {width:216px; height:211px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/73444/btn_pagination_item_01.png);}
.heySomething .itemB .slidesjs-pagination .num02 a {background-position:-259px 0;}
.heySomething .itemB .slidesjs-pagination .num02 a:hover, .heySomething .itemB .slidesjs-pagination .num02 .active {background-position:-259px 100%;}
.heySomething .itemB .slidesjs-pagination .num03 a {background-position:-516px 0;}
.heySomething .itemB .slidesjs-pagination .num03 a:hover, .heySomething .itemB .slidesjs-pagination .num03 .active {background-position:-516px 100%;}

.heySomething .itemShake {margin-top:170px;}
.heySomething .itemShake .desc {padding-left:0;}
.heySomething .itemShake .desc .option {left:720px;}
.heySomething .itemShake .slidewrap .slide {text-align:left; padding-left:46px;}
.heySomething .itemShake .slidewrap .slide .slidesjs-previous {left:0;}
.heySomething .itemShake .slidewrap .slide .slidesjs-next {right:510px;}
.heySomething .itemShake .slidesjs-pagination li a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/73444/btn_pagination_item_02.png);}

@keyframes flip {
	0% {transform:translateZ(0) rotateY(0); animation-timing-function:ease-out;}
	40% {transform:translateZ(150px) rotateY(170deg); animation-timing-function:ease-out;}
	50% {transform:translateZ(150px) rotateY(190deg); animation-timing-function:ease-in;}
	80% {transform:translateZ(0) rotateY(360deg); animation-timing-function:ease-in;}
	100% {transform:translateZ(0) rotateY(360deg); animation-timing-function:ease-in;}
}
.flip {animation-name:flip; animation-duration:2s; animation-iteration-count:1; backface-visibility:visible;}

/* book */
.heySomething .book {width:1140px; margin:490px auto 0;}
.heySomething .book .slide {position:relative;}
.heySomething .book .slide .slidesjs-pagination {overflow:hidden; position:absolute; bottom:24px; left:0; z-index:10; width:100%; text-align:center;}
.heySomething .book .slide .slidesjs-pagination li {display:inline-block; *display:inline; zoom:1;}
.heySomething .book .slide .slidesjs-pagination li a {display:block; width:24px; height:24px; background:url(http://fiximage.10x10.co.kr/web2015/event/btn_slide_pagination.png) no-repeat 0 0; text-indent:-9999em; transition:all 0.5s;}
.heySomething .book .slide .slidesjs-pagination li .active {background-position:100% 0;}
.heySomething .book .slide .slidesjs-navigation {display:block; position:absolute; top:50%; z-index:500; width:50px; height:70px; margin-top:-35px; background:transparent url(http://fiximage.10x10.co.kr/web2015/event/btn_slide_nav.png) no-repeat 50% -100px; text-indent:-9999px;}
.heySomething .book .slide .slidesjs-previous {left:15px;}
.heySomething .book .slide .slidesjs-next {right:15px;background-position:50% -300px;}

/* visual */
.heySomething .visual {margin-top:490px; background-color:#3c2f23;}
.heySomething .visual .figure {position:relative; width:100%; height:735px;}
.heySomething .visual .figure img {position:absolute; top:0; left:50%; margin-left:-951px;}

/* story */
.heySomething .story {margin-top:450px; padding-bottom:120px;}
.heySomething .story h3 {margin-bottom:70px;}
.heySomething .rolling {padding-top:200px;}
.heySomething .rolling .pagination {top:0; width:748px; margin-left:-374px;}
.heySomething .rolling .swiper-pagination-switch {width:131px; height:131px; margin:0 28px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/73444/btn_pagination_story.png);}
.heySomething .rolling .pagination span.swiper-active-switch {background-position:0 100%;}
.heySomething .rolling .pagination span:first-child + span {background-position:-187px 0;}
.heySomething .rolling .pagination span:first-child + span.swiper-active-switch {background-position:-187px 100%;}
.heySomething .rolling .pagination span:first-child + span + span {background-position:-375px 0;}
.heySomething .rolling .pagination span:first-child + span + span.swiper-active-switch {background-position:-375px 100%;}
.heySomething .rolling .pagination span:first-child + span + span + span {background-position:100% 0;}
.heySomething .rolling .pagination span:first-child + span + span + span.swiper-active-switch {background-position:100% 100%;}
.heySomething .rolling .pagination span em {bottom:-829px; left:50%;height:120px; width:980px; margin-left:-490px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/73444/txt_story_desc.png); cursor:default;}
.heySomething .rolling .pagination span .desc2 {background-position:0 -120px;}
.heySomething .rolling .pagination span .desc3 {background-position:0 -240px;}
.heySomething .rolling .pagination span .desc4 {background-position:0 -360px;}
.heySomething .rolling .btn-nav {top:516px;}
.heySomething .swipemask {top:200px;}
.heySomething .mask-left {margin-left:-1470px;}
.heySomething .mask-right {margin-left:490px;}

/* enjoy */
.heySomething .enjoy {position:relative; width:889px; margin:375px auto 0;}
.heySomething .enjoy p {position:absolute; top:150px; left:0;}

/* instagram */
.heySomething .instagram {margin-top:500px; padding:70px 0 73px; background-color:#e2f0f9; text-align:center;}
.heySomething .instagram ul {overflow:hidden; width:1192px; margin:0 auto;}
.heySomething .instagram ul li {float:left; margin:20px 10px 0;}
.heySomething .instagram .btnInstagram {margin-top:45px;}
.heySomething .instagram .btnInstagram img {animation-name:bounce; animation-iteration-count:infinite; animation-duration:1s;}
@keyframes bounce {
	from, to {transform:translateY(5px);}
	50% {transform:translateY(0);}
}

/* finish */
.heySomething .finish {background-color:#54575e; height:630px; margin-top:520px;}
.heySomething .finish p {overflow:hidden; top:145px; width:340px; height:340px; margin-left:-570px;}
.heySomething .finish .figure {position:absolute; top:0; left:50%; margin-left:-951px;}

/* comment */
.heySomething .commentevet {margin-top:500px;}
.heySomething .commentevet .form {margin-top:25px;}
.heySomething .commentevet .form .choice li {width:118px; height:144px; margin-right:27px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/73444/img_ico.png); background-position:0 0;}
.heySomething .commentevet .form .choice li.ico1 button.on {background-position:0 100%;}
.heySomething .commentevet .form .choice li.ico2 button {background-position:-145px 0;}
.heySomething .commentevet .form .choice li.ico2 button.on {background-position:-145px 100%;}
.heySomething .commentevet .form .choice li.ico3 button {background-position:-290px 0;}
.heySomething .commentevet .form .choice li.ico3 button.on {background-position:-290px 100%;}
.heySomething .commentevet .form .choice li.ico4 button {background-position:100% 0;}
.heySomething .commentevet .form .choice li.ico4 button.on {background-position:100% 100%;}

.heySomething .commentevet textarea {margin-top:25px;}

.heySomething .commentlist table td strong {width:118px; height:144px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/73444/img_ico.png); background-position:0 0;}
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
		<% If not( left(currenttime,10) >= "2016-10-04" and left(currenttime,10) <= "2016-10-11" ) Then %>
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
			<div class="figure">
				<a href="/shopping/category_prd.asp?itemid=1563651&pEtr=73444"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73444/img_item_represent.jpg" alt="The Mason Shaker" /></a>
			</div>
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
				<a href="/shopping/category_prd.asp?itemid=1563651&pEtr=73444"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73444/img_item_represent.jpg" alt="The Mason Shaker" /></a>
			</div>
		</div>
		<%' about %>
		<div class="about">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
			<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
		</div>

		<%' brand %>
		<div class="brand">
			<a href="/street/street_brand_sub06.asp?makerid=wandp" title="더블유앤피 브랜드 스트리트로 이동">
				<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73444/img_logo_wp_design_01.png" alt="더블유앤피" /></h3>
				<ul>
					<li class="brand1">
						<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73444/img_brand_01.jpg" alt="" />
						<span class="over"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73444/img_brand_01_over.jpg" alt="" /></span>
					</li>
					<li class="brand2">
						<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73444/img_brand_02.jpg" alt="" />
						<span class="over"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73444/img_brand_02_over.jpg" alt="" /></span>
					</li>
					<li class="brand3">
						<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73444/img_brand_03.jpg" alt="" />
						<span class="over"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73444/img_brand_03_over.jpg" alt="" /></span>
					</li>
				</ul>
			</a>
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73444/txt_brand.png" alt="" /></p>
			<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="" /></div>
		</div>

		<%' item %>
		<div class="item itemB">
			<div class="bg"></div>
			<div class="inner">
				<h3>
					<span class="logo"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73444/img_logo_wp_design_02.png" alt="더블유앤피" /></span>
					<span class="horizontalLine1"></span>
					<span class="horizontalLine2"></span>
				</h3>
			<%
				IF application("Svr_Info") = "Dev" THEN
					itemid = 1239226
				Else
					itemid = 1563651
				End If
				set oItem = new CatePrdCls
					oItem.GetItemData itemid
			%>
				<div class="desc">
					<%' 상품 이름, 가격, 구매하기 %>
					<div class="option">
						<em class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73444/txt_name_01.png" alt="The Mason Shaker 크기 32oz, 재질 3Glass, High Quality Stainless Steel and a Shot of Southern Sensibility" /></em>
				<%' for dev msg : 상품코드 1563651 할인기간 10/5~10/11 할인기간이 지나면 <strong class="discount">...</strong> 숨겨주세요 %>
				<%' for dev msg : 할인기간 %>
				<% If oItem.FResultCount > 0 Then %>
					<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
						<div class="price">
						<% If not( left(currenttime,10)>="2016-10-05" and left(currenttime,10)<="2016-10-11" ) Then %>
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
						<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73444/txt_substance_01.png" alt="" /></p>
						<div class="btnget"><a href="/shopping/category_prd.asp?itemid=1563651&pEtr=73444"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="Kakao pink apeach classics tiny 구매하러 가기" /></a></div>
					</div>
					<%' slide %>
					<div class="slidewrap">
						<div id="slide01" class="slide">
							<div><a href="/shopping/category_prd.asp?itemid=1563651&pEtr=73444"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73444/img_slide_item_01_01.jpg" alt="The Mason Shaker 정면" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1563651&pEtr=73444"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73444/img_slide_item_01_02.jpg" alt="" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1563651&pEtr=73444"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73444/img_slide_item_01_03.jpg" alt="The Mason Shaker 뒷모습" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1563651&pEtr=73444"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73444/img_slide_item_01_04.jpg" alt="The Mason Shaker 패키지" /></a></div>
						</div>
					</div>
				</div>
			<% set oItem = nothing %>
			</div>
		</div>

		<div class="item itemB itemShake">
			<div class="bg"></div>
			<div class="inner">
			<%
				IF application("Svr_Info") = "Dev" THEN
					itemid = 1239226
				Else
					itemid = 1563652
				End If
				set oItem = new CatePrdCls
					oItem.GetItemData itemid
			%>
				<div class="desc">
					<%' 상품 이름, 가격, 구매하기 %>
					<div class="option">
						<em class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73444/txt_name_02.png" alt="Shake A New Perspective 168 Pages Premium soft cover 30+ original seasonal recipes and features" /></em>
				<%' for dev msg : 상품코드 1563652 할인기간 10/5~10/11 할인기간이 지나면 <strong class="discount">...</strong> 숨겨주세요 %>
				<%' for dev msg : 할인기간 %>
				<% If oItem.FResultCount > 0 Then %>
					<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
						<div class="price">
						<% If not( left(currenttime,10)>="2016-10-05" and left(currenttime,10)<="2016-10-11" ) Then %>
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
						<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73444/txt_substance_02.png" alt="W&amp;P Design의 칵테일 철학이 담긴 책 shake입니다. 보기만 해도 칵테일을 마시고 있는 듯한 다채로운 이미지들과 함께 30여가지의 칵테일 레시피와 계절별 칵테일을 엿볼 수 있습니다. 칵테일은 사서 마셔야 한다는 생각에서 벗어나 직접 칵테일 만들어 먹을 수 있도록 칵테일의 기본부터 차근차근 알려주는 친절한 shake를 소개합니다." /></p>
						<div class="btnget"><a href="/shopping/category_prd.asp?itemid=1563652&pEtr=73444"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="Kakao chambray  apeach classics women 구매하러 가기" /></a></div>
					</div>

					<%' slide %>
					<div class="slidewrap">
						<div id="slide02" class="slide">
							<div><a href="/shopping/category_prd.asp?itemid=1563652&pEtr=73444"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73444/img_slide_item_02_01.jpg" alt="Shake 책 정면" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1563652&pEtr=73444"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73444/img_slide_item_02_02.jpg" alt="Shake 책 좌측 모습" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1563652&pEtr=73444"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73444/img_slide_item_02_03.jpg" alt="" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1563652&pEtr=73444"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73444/img_slide_item_02_04.jpg" alt="Shake 책 뒷모습" /></a></div>
						</div>
					</div>
				</div>
				<% set oItem = nothing %>
			</div>
		</div>
		<%' book %>
		<div class="book">
			<div id="slide03" class="slide">
				<div><a href="/shopping/category_prd.asp?itemid=1563652&pEtr=73444"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73444/img_slide_book_01.jpg" alt="Shake 책" /></a></div>
				<div><a href="/shopping/category_prd.asp?itemid=1563652&pEtr=73444"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73444/img_slide_book_02.jpg" alt="" /></a></div>
				<div><a href="/shopping/category_prd.asp?itemid=1563652&pEtr=73444"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73444/img_slide_book_03.jpg" alt="" /></a></div>
				<div><a href="/shopping/category_prd.asp?itemid=1563652&pEtr=73444"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73444/img_slide_book_04.jpg" alt="" /></a></div>
				<div><a href="/shopping/category_prd.asp?itemid=1563652&pEtr=73444"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73444/img_slide_book_05.jpg" alt="" /></a></div>
			</div>
		</div>

		<%' visual %>
		<div class="visual">
			<div class="figure"><a href="/shopping/category_prd.asp?itemid=1563651&pEtr=73444"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73444/img_visual_big.jpg" alt="The Mason Shaker" /></a></div>
		</div>

		<%' story %>
		<div class="story">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73444/tit_story.png" alt="Shake up your HOME BAR!" /></h3>
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
									<a href="/shopping/category_prd.asp?itemid=1563651&pEtr=73444" title="The Mason Shaker 상품보러 가기"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73444/img_slide_story_01.jpg" alt="#Fun 휴대성 좋은 The Mason Shaker 하나. 가방 안에 쏙 넣으면 어디서든지 칵테일을 즐길 수 있어요. 혼자 여행하면서 홀짝홀짝 혼술하는, 다 함께 칵테일을 마시면서 피크닉을 즐기는 상상해보아요!" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1563651&pEtr=73444"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73444/img_slide_story_02.jpg" alt="#Simple SIMPLE IS THE BEST! 재료가 많지 않더라도 맛 좋은 칵테일을 즐길 수 있어요. 5~6가지 재료로 다양하게 제조할 수 있도록 shake가 칵테일의 세계로 안내합니다." /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1563651&pEtr=73444"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73444/img_slide_story_03.jpg" alt="#Social 칵테일은 같이 즐겨야 제 맛이지! 직접 만든 칵테일을 지인들에게 선보이면서 즐겁고 정답게 칵테일 건배를 해보아요." /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1563651&pEtr=73444"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73444/img_slide_story_04.jpg" alt="#More 칵테일만 담으라고 있는 메이슨자가 아니죠! 다양한 응용이 가능한 메이슨자에 담고자 하는 음식을 넣어보아요!" /></a>
								</div>
							</div>
						</div>
					</div>
					<div class="pagination"></div>
				</div>
			</div>
		</div>

		<div class="enjoy">
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73444/txt_enjoy.png" alt="Enjoy various ways" /></p>
			<a href="/shopping/category_prd.asp?itemid=1563651&pEtr=73444"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73444/img_enjoy.png" alt="The Mason Shaker" /></a>
		</div>

		<%' instagram %>
		<div class="instagram">
			<ul>
				<li><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73444/img_instagram_01.png" alt="Unique mason jar" /></li>
				<li><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73444/img_instagram_02.jpg" alt="" /></li>
				<li><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73444/img_instagram_03.jpg" alt="" /></li>
				<li><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73444/img_instagram_04.jpg" alt="" /></li>
				<li><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73444/img_instagram_05.jpg" alt="" /></li>
				<li><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73444/img_instagram_06.jpg" alt="" /></li>
				<li><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73444/img_instagram_07.jpg" alt="" /></li>
				<li><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73444/img_instagram_08.jpg" alt="" /></li>
			</ul>
			<div class="btnInstagram">
				<a href="https://www.instagram.com/wandpdesign/" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73444/btn_instagram.png" alt="WANDP DESIGN 인스타그램 공식계정으로 이동 새창" /></a>
			</div>
		</div>

		<%' finish %>
		<div class="finish">
			<a href="/shopping/category_prd.asp?itemid=1563651&pEtr=73444">
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73444/txt_finish.png" alt="즐거움을 흔들다 W&amp;P DESIGN " /></p>
				<div class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73444/img_finish.jpg" alt="The Mason Shaker" /></div>
			</a>
		</div>

		<%' comment %>
		<div class="commentevet">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73444/tit_comment.png" alt="Hey, something project 마시고 싶은 그 순간" /></h3>
			<p class="hidden">당신은 칵테일이 가장 생각나는 순간이 언제인가요? 정성껏 코멘트를 남겨주신 5분을 추첨하여 W&amp;P DESIGN의 The Mason Shaker 또는 shake 도서를 증정합니다. 랜덤 증정 코멘트 작성기간은 2016년 10월 5일부터 10월 11일까지며, 발표는 10월 12일 입니다.</p>
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
					<legend>당신은 칵테일이 가장 생각나는 순간이 언제인지 코멘트 쓰기</legend>
						<ul class="choice">
							<li class="ico1"><button type="button" value="1">Fun</button></li>
							<li class="ico2"><button type="button" value="2">Simple</button></li>
							<li class="ico3"><button type="button" value="3">Social</button></li>
							<li class="ico4"><button type="button" value="4">More</button></li>
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
										Fun
									<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="2" Then %>
										Simple
									<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="3" Then %>
										Social
									<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="4" Then %>
										More
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
		width:"520",
		height:"483",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:2000, effect:"fade", auto:true},
		effect:{fade: {speed:1000, crossfade:true}}
	});

	$("#slide02").slidesjs({
		width:"520",
		height:"483",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:2500, effect:"fade", auto:true},
		effect:{fade: {speed:1000, crossfade:true}}
	});

	$("#slide03").slidesjs({
		width:"1140",
		height:"683",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:2000, effect:"fade", auto:true},
		effect:{fade: {speed:1200, crossfade:true}}
	});

	//mouse control
	$('.slide .slidesjs-pagination > li a').mouseenter(function(){
		$('a[data-slidesjs-item="' + $(this).attr("data-slidesjs-item") + '"]').trigger('click');
	});

	$(".slide .slidesjs-pagination li:nth-child(1)").addClass("num01");
	$(".slide .slidesjs-pagination li:nth-child(2)").addClass("num02");
	$(".slide .slidesjs-pagination li:nth-child(3)").addClass("num03");
	$(".slide .slidesjs-pagination li:nth-child(4)").addClass("num04");

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
			brandAnimation();
		}
		if (scrollTop > 1500 ) {
			$(".heySomething .item h3 .logo img").addClass("flip");
		}
		if (scrollTop > 9000 ) {
			enjoyAnimation();
		}
		if (scrollTop > 9600 ) {
			instagramAnimation();
		}
		if (scrollTop > 11000 ) {
			finishAnimation();
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
	$(".heySomething .brand ul li.brand1").css({"left":"237px"});
	$(".heySomething .brand ul li.brand3").css({"right":"237px"});
	function brandAnimation() {
		$(".heySomething .brand ul li.brand1").delay(100).animate({"left":"0", "opacity":"1"},800);
		$(".heySomething .brand ul li.brand2").delay(100).animate({"opacity":"1"},800);
		$(".heySomething .brand ul li.brand3").delay(100).animate({"right":"0", "opacity":"1"},800);
	}

	/* instagram animation */
	$(".heySomething .instagram ul li").css({"opacity":"0"});
	function instagramAnimation() {
		$(".heySomething .instagram ul li:nth-child(1)").delay(100).animate({"opacity":"1"},800);
		$(".heySomething .instagram ul li:nth-child(2)").delay(500).animate({"opacity":"1"},800);
		$(".heySomething .instagram ul li:nth-child(3)").delay(300).animate({"opacity":"1"},800);
		$(".heySomething .instagram ul li:nth-child(4)").delay(200).animate({"opacity":"1"},800);
		$(".heySomething .instagram ul li:nth-child(5)").delay(100).animate({"opacity":"1"},800);
		$(".heySomething .instagram ul li:nth-child(6)").delay(400).animate({"opacity":"1"},800);
		$(".heySomething .instagram ul li:nth-child(7)").delay(300).animate({"opacity":"1"},800);
		$(".heySomething .instagram ul li:nth-child(8)").delay(800).animate({"opacity":"1"},800);
	}

	/* enjoy animation */
	$(".heySomething .enjoy p").css({"left":"50px", "opacity":"0"});
	function enjoyAnimation() {
		$(".heySomething .enjoy p").delay(100).animate({"left":"0", "opacity":"1"},1000);
	}

	/* finish animation */
	$(".heySomething .finish p img").css({"margin-top":"50px", "opacity":"0"});
	function finishAnimation() {
		$(".heySomething .finish p img").delay(100).animate({"margin-top":"0", "opacity":"1"},900);
	}
});
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->