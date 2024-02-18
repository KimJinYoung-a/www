<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈 33
' History : 2016-05-24 원승현 생성
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

dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  66137
Else
	eCode   =  70817
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
.heySomething .topic {background-color:#f9f9f9;}
.heySomething .topic h2 {z-index:5;}
.heySomething .topic .figure a {display:block; position:relative; width:100%; height:780px;}
.heySomething .topic .figure img {position:absolute; top:0; left:50%; margin-left:-951px;}

/* item */
.heySomething .itemB {padding-bottom:38px; background:none;}
.heySomething .item h3 {position:relative; height:86px;}
.heySomething .item h3 .disney {position:absolute; top:0; left:393px; z-index:5; background-color:#fff;}
.heySomething .item h3 .tenten {position:absolute; top:39px; left:621px; z-index:5; background-color:#fff;}
.heySomething .item h3 .verticalLine {position:absolute; top:25px; left:569px; width:1px; height:64px; background-color:#d9d9d9;}
.heySomething .item h3 .horizontalLine1, .heySomething .item h3 .horizontalLine2 {position:absolute; top:56px; width:305px; height:1px; background-color:#d9d9d9;}
.heySomething .item h3 .horizontalLine1 {left:0;}
.heySomething .item h3 .horizontalLine2 {right:0;}
.heySomething .itemB .slidewrap .slide {width:610px;}
.heySomething .itemB .with {padding-bottom:90px; border-bottom:1px solid #ddd; text-align:center;}
.heySomething .itemB .with ul {overflow:hidden; width:1022px; margin:45px auto 0;}
.heySomething .itemB .with ul li {float:left; padding:0 20px;}
.heySomething .itemB .with ul li a {overflow:hidden; display:block; position:relative; width:471px; height:157px;}
.heySomething .itemB .with ul li .mask {position:absolute; top:0; left:0; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/69341/bg_mask.png) no-repeat 50% 0; transition:opacity 1s;}
.heySomething .itemB .with ul li .text {position:absolute; top:50%; left:0; width:100%; margin-top:-51px; text-align:center; transition:all 0.3s;}
.heySomething .itemB .with ul li a:hover .mask {opacity:0; filter:alpha(opacity=0);}
.heySomething .itemB .with ul li a:hover .text {margin-top:-61px; opacity:0; filter:alpha(opacity=0);}
.heySomething .itemB .with ul li a:hover .text {*opacity:0; filter:alpha(opacity=0);}
@media \0screen {
	.heySomething .itemB .with ul li a:hover .text {*opacity:0; filter:alpha(opacity=0);}
}

/* illust */
.illust {position:relative; width:727px; height:966px; margin:200px auto 0; text-align:center;}
.illust .pooh {position:absolute; top:0; left:59px; z-index:5;}
.illust .butterfly {position:absolute; top:650px; right:149px; z-index:5;}
.illust .friends {position:absolute; bottom:0; left:50%; margin-left:-393px;}
.updown {animation-name:updown; animation-iteration-count:infinite; animation-duration:1.5s;}
@keyframes updown {
	from, to{margin-top:0; animation-timing-function:linear;}
	50% {margin-top:5px; animation-timing-function:linear;}
}
.shake {animation-name:shake; animation-iteration-count:infinite; animation-duration:2s;}
@keyframes shake {
	from, to{margin-right:10px; animation-timing-function:ease-out;}
	50% {margin-right:0; animation-timing-function:ease-in;}
}

/* visual */
.heySomething .visual {position:relative; height:805px; margin-top:325px; background-color:#cecbc3;}
.heySomething .visual .figure {position:absolute; top:0; left:50%; margin-left:-951px;}

/* brand */
.heySomething .brand {position:relative; height:840px; margin-top:310px;}
.heySomething .brand .pooh {position:absolute; top:166px; left:50%; width:241px; margin-left:-120px; text-align:center;}
.heySomething .brand p {margin-top:437px;}

/* video */
.video {width:1140px; margin:150px auto 0;}

/* story */
.heySomething .story h3 {margin-bottom:0;}
.heySomething .rolling {margin-top:75px; padding-top:180px; padding-bottom:120px;}
.heySomething .rolling .pagination {top:0; width:940px; margin-left:-470px;}
.heySomething .rolling .pagination .swiper-pagination-switch {width:156px; height:156px; margin:0 16px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/70817/img_ico.png) no-repeat 0 0;}
.heySomething .rolling .pagination span.swiper-active-switch {background-position:0 -156px;}
.heySomething .rolling .pagination span:first-child + span {background-position:-172px 0;}
.heySomething .rolling .pagination span:first-child + span.swiper-active-switch {background-position:-172px -156px;}
.heySomething .rolling .pagination span:first-child + span + span {background-position:-353px 0;}
.heySomething .rolling .pagination span:first-child + span + span.swiper-active-switch {background-position:-353px -156px;}
.heySomething .rolling .pagination span:first-child + span + span + span {background-position:-528px 0;}
.heySomething .rolling .pagination span:first-child + span + span + span.swiper-active-switch {background-position:-528px -156px;}
.heySomething .rolling .pagination span:first-child + span + span + span + span {background-position:100% 0;}
.heySomething .rolling .pagination span:first-child + span + span + span + span.swiper-active-switch {background-position:100% -156px;}
.heySomething .rolling .pagination span em {bottom:-774px; left:50%;height:120px; width:980px; margin-left:-490px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/70817/txt_story_desc.png); cursor:default;}
.heySomething .rolling .pagination span .desc2 {background-position:0 -120px;}
.heySomething .rolling .pagination span .desc3 {background-position:0 -240px;}
.heySomething .rolling .pagination span .desc4 {background-position:0 -360px;}
.heySomething .rolling .pagination span .desc5 {background-position:0 100%;}
.heySomething .swipemask {top:180px;}

/* finish */
.heySomething .finish {background-color:#eee; height:732px; margin-top:310px;}
.heySomething .finish .figure {position:absolute; top:0; left:50%; margin-left:-951px;}
.heySomething .finish p {top:145px; margin-left:-483px;}

/* comment */
.heySomething .commentevet .form {margin-top:40px;}
.heySomething .commentevet .form .choice li {width:133px; margin-right:28px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/70817/img_ico.png); background-position:0 -312px;}
.heySomething .commentevet .form .choice li.ico2 button {background-position:-161px -312px;}
.heySomething .commentevet .form .choice li.ico2 button.on {background-position:-161px -471px;}
.heySomething .commentevet .form .choice li.ico3 button {background-position:-322px -312px;}
.heySomething .commentevet .form .choice li.ico3 button.on {background-position:-322px -471px;}
.heySomething .commentevet .form .choice li.ico4 button {background-position:-483px -312px;}
.heySomething .commentevet .form .choice li.ico4 button.on {background-position:-483px -471px;}
.heySomething .commentevet .form .choice li.ico5 button {background-position:-643px -312px;}
.heySomething .commentevet .form .choice li.ico5 button.on {background-position:-643px -471px;}
.heySomething .commentevet textarea {margin-top:50px;}

.heySomething .commentlist table td strong {height:100px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/70817/img_ico.png); background-position:0 -336px;}
.heySomething .commentlist table td strong.ico2 {background-position:-161px -336px;}
.heySomething .commentlist table td strong.ico3 {background-position:-322px -336px;}
.heySomething .commentlist table td strong.ico4 {background-position:-483px -336px;}
.heySomething .commentlist table td strong.ico5 {background-position:-643px -336px;}
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
		<% If not( left(currenttime,10)>="2016-05-24" and left(currenttime,10)<"2016-06-02" ) Then %>
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
			<div class="figure">
				<a href="/shopping/category_prd.asp?itemid=1488140&amp;pEtr=70817"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70817/img_item_represent.jpg" alt="Disney Pooh Tea Infuser" /></a>
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
					<span class="disney"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70817/img_logo_disney.png" alt="디즈니" /></span>
					<span class="tenten"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70817/img_logo_tenten.png" alt="텐바이텐" /></span>
					<span class="verticalLine"></span>
					<span class="horizontalLine1"></span>
					<span class="horizontalLine2"></span>
				</h3>
			<%
				IF application("Svr_Info") = "Dev" THEN
					itemid = 1239226
				Else
					itemid = 1488140
				End If
				set oItem = new CatePrdCls
					oItem.GetItemData itemid
			%>
				<div class="desc">
					<a href="/shopping/category_prd.asp?itemid=1488140&amp;pEtr=69341">
						<div class="option">
							<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70817/txt_name.png" alt="Disney Pooh Tea Infuser의 사이즈는 가로 11.5센치, 세로 68센치며, 소재는 푸드 그레이드 실리콘이며, 무게는 21g입니다." /></p>
							<%' for dev msg : 상품코드 1490116, 할인기간 5/18~5/24, 할인 종료 후 <strong class="discount">...</strong> 숨겨주세요 %>
						<% If oItem.FResultCount > 0 Then %>
							<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
							<div class="price">
								<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/txt_only_tenten_20percent.png" alt="텐바이텐에서만 ONLY 20%" /></strong>
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
							<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70817/txt_substance.png" alt="에이커 숲의 귀염둥이 푸가 전하는 따뜻한 메시지와 함께 숲 속에서의 행복한 힐링 티타임을 즐겨보세요! 매일 행복하진 않지만, 행복한 일은 매일 있어!" /></p>
							<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="Disney Pooh Tea Infuser 구매하러 가기" /></div>
						</div>
						<!-- slide -->
						<div class="slidewrap">
							<div id="slide" class="slide">
								<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70817/img_figure_front.jpg" alt="" /></div>
								<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70817/img_figure_back.jpg" alt="" /></div>
							</div>
						</div>
					</a>
				</div>
				<% set oItem=nothing %>
				<div class="with">
					<span><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/ico_plus.png" alt="" /></span>
					<ul>
						<li>
							<a href="/shopping/category_prd.asp?itemid=1473441&amp;pEtr=70817">
								<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70817/img_width_item_01.jpg" alt="" />
								<span class="mask"></span>
								<span class="text"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70817/txt_disney_vintage_cream_class.png" alt="Disney Vintage Cream Glass" /></span>
							</a>
						</li>
						<li>
							<a href="/shopping/category_prd.asp?itemid=1177009&amp;pEtr=70817">
								<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70817/img_width_item_02.jpg" alt="" />
								<span class="mask"></span>
								<span class="text"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70817/txt_pooh_pancake_book.png" alt="Winnie the Pooh pancake book" /></span>
							</a>
						</li>
					</ul>
				</div>
			</div>
		</div>


		<%' illust %>
		<div id="illust" class="illust">
			<div class="pooh updown"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70817/img_animation_pooh.png" alt="" /></div>
			<div class="butterfly shake"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70817/img_animation_butterfly.png" alt="" /></div>
			<div class="friends"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70817/img_animation_v2.png" alt="" /></div>
		</div>

		<%' visual %>
		<div class="visual">
			<div class="figure"><a href="/shopping/category_prd.asp?itemid=1488140&amp;pEtr=70817"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70817/img_item_visual_big.jpg" alt="" /></a></div>
		</div>

		<%' brand %>
		<div class="brand">
			<div class="logo"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70817/img_brand_logo.png" alt="" /></div>
			<div class="pooh"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70817/img_pooh.png" alt="" /></div>
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70817/txt_brand.png" alt="푸와 함께 하는 Healing Campooh 마음이 답답하고 힘들 때, 배가 나오고 어리석지만 사랑스러운 곰돌이 푸와 함께 오감을 자극하는 힐랭 캠푸를 떠나보세요!" /></p>
			<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="" /></div>
		</div>

		<%' video %>
		<div class="video">
			<iframe src="//player.vimeo.com/video/167359567" width="1140" height="640" frameborder="0" title="Disney Pooh Tea Infuser" webkitallowfullscreen="" mozallowfullscreen="" allowfullscreen=""></iframe>
		</div>

		<div class="story">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70817/tit_story.png" alt="오감자극 푸와 함께 하는 Healing Campooh" /></h3>
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
									<a href="/shopping/category_prd.asp?itemid=1488140&amp;pEtr=70817" title="Disney Pooh Tea Infuser"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70817/img_slide_01.jpg" alt="#Sight 고운 색감의 잎차가 사랑스럽게 우러나오는 힐링 타임" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1488140&amp;pEtr=70817"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70817/img_slide_02.jpg" alt="#Hearing 또르르~ 푸를 향해 떨어지는 물소리가 주는 여유로움" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1488140&amp;pEtr=70817"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70817/img_slide_03.jpg" alt="#Smell 음~ 푸가 전해준 행복한 향기" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1488140&amp;pEtr=70817"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70817/img_slide_04.jpg" alt="#Taste 달콤한 디저트와 함께하면 행복감은 두 배!" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1488140&amp;pEtr=70817"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70817/img_slide_05.jpg" alt="#Touch 통통한 푸의 배에 향긋한 잎차를 넣는 즐거움!" /></a>
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
			<a href="/shopping/category_prd.asp?itemid=1488140&amp;pEtr=70817">
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70817/txt_finish.png" alt="매일 행복하진 않지만, 행복한 일은 매일 있어! 푸와 함께하는, 오감 자극 Healing Campooh" /></p>
				<div class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70817/img_finish.jpg" alt="" /></div>
			</a>
		</div>


		<%' comment %>
		<div class="commentevet">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70817/tit_comment.png" alt="Hey, something project 당신이 갖고 싶은 것" /></h3>
			<p class="hidden">귀염둥이 푸와 함께 일상 속 힐링 캠푸를 떠나고 싶은 이유를 들려주세요! 정성껏 코멘트를 남겨주신 10분을 추첨하여 푸우 인퓨저를 선물로 드립니다 . 코멘트 작성기간은 2016년 5월 25일부터 6월 1일까지며, 발표는 6월 3일 입니다.</p>
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
				<form>
					<fieldset>
					<legend>Disney Pooh Tea Infuse 코멘트 쓰기</legend>
						<ul class="choice">
							<li class="ico1"><button type="button" value="1">Sight</button></li>
							<li class="ico2"><button type="button" value="2">Hearing</button></li>
							<li class="ico3"><button type="button" value="3">Smell</button></li>
							<li class="ico4"><button type="button" value="4">Taste</button></li>
							<li class="ico5"><button type="button" value="5">Touch</button></li>
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
			<%' commentlist %>
			<div class="commentlist" id="commentlist">
				<p class="total">total <%= iCTotCnt %></p>
				<% IF isArray(arrCList) THEN %>
				<table>
					<caption>그린 leaf 디퓨저 코멘트 목록 - 코멘트 작성시 선택 항목, 내용, 작성일자, 아이디 정보를 제공하는 표</caption>
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
										Sight
									<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="2" Then %>
										Hearing
									<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="3" Then %>
										Smell
									<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="4" Then %>
										Taste
									<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="5" Then %>
										Touch
									<% Else %>
										Sight
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
<% If Not(Trim(hspchk(1)))="hsproject" Then %>
	</div>
<% End If %>
<script type="text/javascript">
$(function(){
	/* slide js */
	$("#slide").slidesjs({
		width:"610",
		height:"485",
		pagination:false,
		navigation:false,
		play:{interval:1500, effect:"fade", auto:true},
		effect:{fade: {speed:500, crossfade:true}}
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
	$('.pagination span:nth-child(5)').append('<em class="desc5"></em>');

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
		if (scrollTop > 800 ) {
			itemAnimation();
		}
		if (scrollTop > 2500 ) {
			illustAnimation();
		}
		if (scrollTop > 4800 ) {
			brandAnimation();
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

	/* item animation */
	$(".heySomething .item h3 .disney").css({"left":"621px", "opacity":"0"});
	$(".heySomething .item h3 .tenten").css({"left":"393px","opacity":"0"});
	function itemAnimation() {
		$(".heySomething .item h3 .disney").delay(200).animate({"left":"393px", "opacity":"1"},1000);
		$(".heySomething .item h3 .tenten").delay(200).animate({"left":"621px", "opacity":"1"},1000);
	}

	/* illust animation */
	$(".heySomething .illust .butterfly").css({"opacity":"0"});
	function illustAnimation() {
		$(".heySomething .illust .pooh").delay(200).animate({"top":"117px", "left":"220px"},2000);
		$(".heySomething .illust .butterfly").delay(1000).animate({"opacity":"1"},1500);
	}

	/* brand animation */
	$(".heySomething .brand .pooh img").css({"width":"220px", "opacity":"0"});
	$(".heySomething .brand p").css({"height":"50px", "opacity":"0"});
	$(".heySomething .brand .btnDown").css({"opacity":"0"});
	function brandAnimation() {
		$(".heySomething .brand .pooh img").delay(50).animate({"width":"241px", "opacity":"1"},800);
		$(".heySomething .brand p").delay(800).animate({"height":"151px", "opacity":"1"},1000);
		$(".heySomething .brand .btnDown").delay(1700).animate({"opacity":"1"},1200);
	}

	/* finish animation */
	$(".heySomething .finish p").css({"margin-left":"-460px", "opacity":"0"});
	function finishAnimation() {
		$(".heySomething .finish p").delay(100).animate({"margin-left":"-483px", "opacity":"1"},800);
	}
});
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->