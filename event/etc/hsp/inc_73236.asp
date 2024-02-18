<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈
' History : 2016-06-07 이종화 생성
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
	eCode   =  66146
Else
	eCode   =  73236
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
.heySomething .topic {background-color:#c1d6d7;}
.heySomething .topic h2 {z-index:5;}
.heySomething .topic .figure {position:relative; width:100%; height:778px;}
.heySomething .topic .figure img {position:absolute; top:0; left:50%; margin-left:-950px;}

/* item */
.heySomething .itemB {padding-bottom:226px; background:none;}
.heySomething .itemB .bg {position:absolute; bottom:0; left:0; width:100%; height:226px; background-color:#f5f5f5;}
.heySomething .itemB h3 {position:relative; height:33px; text-align:center;}
.heySomething .itemB h3 .horizontalLine1, .heySomething .item h3 .horizontalLine2 {position:absolute; top:15px; width:330px; height:1px; background-color:#ddd;}
.heySomething .itemB h3 .horizontalLine1 {left:0;}
.heySomething .itemB h3 .horizontalLine2 {right:0;}
.heySomething .itemB .desc {margin-bottom:55px;}
.heySomething .itemB .desc .option {height:347px;}
.heySomething .itemB .slidewrap .slide {width:676px; height:550px;}
.heySomething .itemB .slidewrap .slide .slidesjs-container {height:550px !important;}
.heySomething .itemB .slidewrap .slide .slidesjs-previous {left:490px;}
.heySomething .itemB .slidesjs-pagination {bottom:-245px;}
.heySomething .itemB .slidesjs-pagination li a {height:156px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/73236/btn_pagination_item_01.jpg);}
@keyframes flip {
	0% {transform:translateZ(0) rotateX(0); animation-timing-function:ease-out;}
	40% {transform:translateZ(150px) rotateX(170deg); animation-timing-function:ease-out;}
	50% {transform:translateZ(150px) rotateX(190deg); animation-timing-function:ease-in;}
	80% {transform:translateZ(0) rotateX(360deg); animation-timing-function:ease-in;}
	100% {transform:translateZ(0) rotateX(360deg); animation-timing-function:ease-in;}
}
.flip {animation-name:flip; animation-duration:2s; animation-iteration-count:1; backface-visibility:visible;}

.heySomething .itemAdult {margin-top:50px;}
.heySomething .itemAdult .desc .option {top:148px; height:309px;}
.heySomething .itemAdult .slide .slidesjs-pagination li a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/73236/btn_pagination_item_02.jpg);}

/* visual */
.heySomething .visual {margin-top:400px; padding-bottom:0; text-align:center;}
.heySomething .visual .photo {overflow:hidden; width:998px; height:650px; margin:0 auto;}
@keyframes pulse {
	0% {transform:scale(1.2);}
	100% {transform:scale(1);}
}
.pulse {animation-name:pulse; animation-duration:1.5s; animation-iteration-count:1;}

/* brand */
.heySomething .brand {position:relative; height:1440px; margin-top:215px;}

/* story */
.heySomething .story {margin-top:300px; padding-bottom:120px;}
.heySomething .story h3 {margin-bottom:63px;}
.heySomething .rolling {padding-top:202px;}
.heySomething .rolling .pagination {top:0; width:844px; margin-left:-422px;}
.heySomething .rolling .swiper-pagination-switch {width:141px; height:165px; margin:0 35px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/73236/btn_pagination_story.png);}
.heySomething .rolling .pagination span.swiper-active-switch {background-position:0 100%;}
.heySomething .rolling .pagination span:first-child + span {background-position:-141px 0;}
.heySomething .rolling .pagination span:first-child + span.swiper-active-switch {background-position:-141px 100%;}
.heySomething .rolling .pagination span:first-child + span + span {background-position:-282px 0;}
.heySomething .rolling .pagination span:first-child + span + span.swiper-active-switch {background-position:-282px 100%;}
.heySomething .rolling .pagination span:first-child + span + span + span {background-position:100% 0;}
.heySomething .rolling .pagination span:first-child + span + span + span.swiper-active-switch {background-position:100% 100%;}
.heySomething .rolling .pagination span em {bottom:-788px; left:50%;height:120px; width:980px; margin-left:-490px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/73236/txt_story_desc.png); cursor:default;}
.heySomething .rolling .pagination span .desc2 {background-position:0 -120px;}
.heySomething .rolling .pagination span .desc3 {background-position:0 -240px;}
.heySomething .rolling .pagination span .desc4 {background-position:0 -360px;}
.heySomething .rolling .btn-nav {top:516px;}
.heySomething .swipemask {top:202px;}
.heySomething .mask-left {margin-left:-1470px;}
.heySomething .mask-right {margin-left:490px;}

/* finish */
.heySomething .finish {background-color:#d2afc5; height:770px; margin-top:400px;}
.heySomething .finish p {overflow:hidden; top:358px; width:301px; height:52px; margin-left:-520px;}
.heySomething .finish .figure {position:absolute; top:0; left:50%; margin-left:-950px;}

/* comment */
.heySomething .commentevet {margin-top:500px;}
.heySomething .commentevet .form {margin-top:25px;}
.heySomething .commentevet .form .choice li {width:131px; height:151px; margin-right:36px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/73236/img_ico.png); background-position:0 0;}
.heySomething .commentevet .form .choice li.ico1 button.on {background-position:0 100%;}
.heySomething .commentevet .form .choice li.ico2 button {background-position:-167px 0;}
.heySomething .commentevet .form .choice li.ico2 button.on {background-position:-167px 100%;}
.heySomething .commentevet .form .choice li.ico3 button {background-position:-334px 0;}
.heySomething .commentevet .form .choice li.ico3 button.on {background-position:-334px 100%;}
.heySomething .commentevet .form .choice li.ico4 button {background-position:100% 0;}
.heySomething .commentevet .form .choice li.ico4 button.on {background-position:100% 100%;}

.heySomething .commentevet textarea {margin-top:25px;}

.heySomething .commentlist table td strong {width:131px; height:151px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/73236/img_ico.png); background-position:0 0;}
.heySomething .commentlist table td strong.ico2 {background-position:-167px 0;}
.heySomething .commentlist table td strong.ico3 {background-position:-334px 0;}
.heySomething .commentlist table td strong.ico4 {background-position:100% 0;}
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
		<% If not( left(currenttime,10)>="2016-09-28" and left(currenttime,10)<"2016-10-05" ) Then %>
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
				<a href="/shopping/category_prd.asp?itemid=1569790&pEtr=73236"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73236/img_item_represent.jpg" alt="Kakao chambray apeach classics women" /></a>
			</div>
		</div>

		<%' about %>
		<div class="about">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
			<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
		</div>

		<%' item %>
		<div class="item itemB">
			<div class="bg"></div>
			<div class="inner">
				<h3>
					<span class="logo"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73236/img_logo_toms_kakao.png" alt="탐스와 카카오 프렌즈의 콜라보레이션" /></span>
					<span class="horizontalLine1"></span>
					<span class="horizontalLine2"></span>
				</h3>
				<%
					itemid = 1569789
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
				%>
				<div class="desc">
					<div class="option">
						<em class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73236/txt_name_01.png" alt="Kakao pink apeach classics tiny 텐바이텐 단독 선오픈 9월 30일 출고 예정으로 120~180 사이즈 10단위" /></em>
						<%' for dev msg : 상품코드 1569789 할인없이 진행합니다. %>
						<% If oItem.FResultCount > 0 Then %>
						<div class="price">
							<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
						</div>
						<% End If %>
						<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73236/txt_substance_01.png" alt="착한 브랜드 탐스와 카카오프렌즈의 공식 콜라보레이션 상품으로 Kakao Friends의 캐릭터 어피치를 탐스에 담았습니다. 우리 아이를 닮은 사랑스런 신발을 선물하세요." /></p>
						<div class="btnget"><a href="/shopping/category_prd.asp?itemid=1569789&pEtr=73236"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="Kakao pink apeach classics tiny 구매하러 가기" /></a></div>
					</div>
					<%' slide %>
					<div class="slidewrap">
						<div id="slide01" class="slide">
							<div><a href="/shopping/category_prd.asp?itemid=1569789&pEtr=73236"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73236/img_slide_item_01_01.jpg" alt="" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1569789&pEtr=73236"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73236/img_slide_item_01_02.jpg" alt="" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1569789&pEtr=73236"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73236/img_slide_item_01_03.jpg" alt="" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1569789&pEtr=73236"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73236/img_slide_item_01_04.jpg" alt="" /></a></div>
						</div>
					</div>
				</div>
				<% set oItem=nothing %>
			</div>
		</div>

		<div class="item itemB itemAdult">
			<div class="bg"></div>
			<div class="inner">
				<%
					itemid = 1569790
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
				%>
				<div class="desc">
					<div class="option">
						<em class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73236/txt_name_02.png" alt="Kakao chambray apeach classics women 텐바이텐 단독 선오픈 9월 30일 출고 예정으로 220~260 사이즈 5단위" /></em>
						<%' for dev msg : 상품코드 1569789 할인없이 진행합니다. %>
						<% If oItem.FResultCount > 0 Then %>
						<div class="price">
							<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
						</div>
						<% End If %>
						<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73236/txt_substance_02.png" alt="신발 뒷부분에 숨어있는 어피치를 찾아보세요! 우리 아이와 함께 커플 탐스로 나들이 떠나보아요 " /></p>
						<div class="btnget"><a href="/shopping/category_prd.asp?itemid=1569790&pEtr=73236"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="Kakao chambray  apeach classics women 구매하러 가기" /></a></div>
					</div>
					<%' slide %>
					<div class="slidewrap">
						<div id="slide02" class="slide">
							<div><a href="/shopping/category_prd.asp?itemid=1569790&pEtr=73236"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73236/img_slide_item_02_01.jpg" alt="" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1569790&pEtr=73236"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73236/img_slide_item_02_02.jpg" alt="" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1569790&pEtr=73236"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73236/img_slide_item_02_03.jpg" alt="" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1569790&pEtr=73236"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73236/img_slide_item_02_04.jpg" alt="" /></a></div>
						</div>
					</div>
				</div>
				<% set oItem=nothing %>
			</div>
		</div>

		<%' visual %>
		<div id="visual" class="visual">
			<div class="photo"><a href="/shopping/category_prd.asp?itemid=1569789&pEtr=73236"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73236/img_item_visual_big.jpg" alt="Kakao pink apeach classics tiny" /></a></div>
		</div>

		<%' brand %>
		<div class="brand">
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73236/txt_brand_toms.jpg" alt="2006년 여름, 아르헨티나를 여행중인 미국의 한 청년은 고민했습니다. 수십 킬로미터를 맨발로 걷는 저 아이들에게 도움을 줄 수 있는 방법은 없을까? 한 켤레가 팔릴 때마다, 신발이 없는 아이들에게 한 켤레를 선물하자! 그 따뜻한 관심에서 시작된 우리 아이들의 내일을 위한 신발 TOMorrow&apos;s Shoes, TOMS" /></p>
			<p style="margin-top:210px;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73236/txt_brand_kakao_v1.png" alt="8명의 매력적인 친구들로 이루어진 Kakao friends! 그 중, 유전자 변이로 자웅동주가 된 것을 알고 복숭아 나무에서 탈출한 악동 복숭아 APEACH 애교 넘치는 표정과 행동으로 귀요미 역할을 합니다. 우리집에도 이 귀요미가 살고 있는 것 같아요!" /></p>
			<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="" /></div>
		</div>

		<%' story %>
		<div class="story">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73236/tit_story.png" alt="따뜻한 TOMS에 담긴 특별한 감성" /></h3>
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
									<a href="/shopping/category_prd.asp?itemid=1569789&pEtr=73236" title="Kakao pink apeach classics tiny 상품보러 가기"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73236/img_slide_story_01.jpg" alt="#Love 사랑하는 아이에겐, 사랑스러운 신발이 필요해요! 내 인생을 핑크빛으로 물들게 해준 나의 아이에게" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1569789&pEtr=73236" title="Kakao pink apeach classics tiny 상품보러 가기"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73236/img_slide_story_02.jpg" alt="#Together 네가 뱃속에 있었을 때부터 꼭 해보고 싶었던 1순위 아장아장 걷기 시작할 때, 너와 함께하는 커플 슈즈" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1569790&pEtr=73236" title="Kakao chambray apeach classics women 상품보러 가기"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73236/img_slide_story_03.jpg" alt="#Play 그래, 이 세상 모든 것이 신기할 나이지! 탐스 위의 인형 참은 즐거운 놀이감이 될 수 있어요" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1569790&pEtr=73236" title="Kakao chambray apeach classics women 상품보러 가기"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73236/img_slide_story_04.jpg" alt="#One for one 탐스를 사면, 누군가의 아이도 행복해집니다.  따뜻한 그 마음을 함께 누려보세요!" /></a>
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
			<a href="/shopping/category_prd.asp?itemid=1569789&pEtr=73236">
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73236/txt_finish.png" alt="매일 매일이 사랑스러운, 우리 아이와 함께하는 슈즈 TOMS" /></p>
				<div class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73236/img_finish_v1.jpg" alt="Kakao pink apeach classics tiny" /></div>
			</a>
		</div>
		
		<%' comment %>
		<div class="commentevet">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73236/tit_comment.png" alt="Hey, something project 엄마와 아이의 한 걸음" /></h3>
			<p class="hidden">우리 아이가 가장 사랑스러워 보일 때는 언제인가요? 정성껏 코멘트를 남겨주신 4분을 추첨하여 TOMS와 카카오프렌즈 콜라보레이션 제품을 선물로 드립니다. 코멘트 기재시, 희망 사이즈 기재 필수 Women 2분, TINY 2분 증정, 코멘트 작성기간은 2016년 9월 28일부터 10월 4일까지며, 발표는 10월 5일 입니다.</p>
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
					<legend>우리 아이가 가장 사랑스러워 보일 때는 언제인지 코멘트 쓰기</legend>
						<ul class="choice">
							<li class="ico1"><button type="button" value="1">Love</button></li>
							<li class="ico2"><button type="button" value="2">Together</button></li>
							<li class="ico3"><button type="button" value="3">Play</button></li>
							<li class="ico4"><button type="button" value="4">One for one</button></li>
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
												Love
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="2" then %>
												Together
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="3" then %>
												Play
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="4" then %>
												One for one
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
		width:"676",
		height:"550",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:2000, effect:"fade", auto:true},
		effect:{fade: {speed:1500, crossfade:true}}
	});

	$("#slide02").slidesjs({
		width:"676",
		height:"550",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:2500, effect:"fade", auto:true},
		effect:{fade: {speed:1500, crossfade:true}}
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
		if (scrollTop > 3000 ) {
			$(".heySomething #visual .photo img").addClass("pulse");
		}
		if (scrollTop > 7300 ) {
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
	$(".heySomething .finish p img").css({"margin-top":"50px", "opacity":"0"});
	function finishAnimation() {
		$(".heySomething .finish p img").delay(100).animate({"margin-top":"0", "opacity":"1"},900);
	}
});
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->