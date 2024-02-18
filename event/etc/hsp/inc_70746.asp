<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈 29
' History : 2016-05-16 김진영 생성
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
	eCode   =  66131
Else
	eCode   =  70746
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
.heySomething .topic {background-color:#f6f4f1;}
.heySomething .topic h2 {z-index:5;}
.heySomething .topic .bnr a {display:block; position:relative; width:100%; height:780px;}
.heySomething .topic .bnr img {position:absolute; top:0; left:50%; margin-left:-951px;}

/* brand */
.heySomething .brand {position:relative; width:749px; height:734px; margin:360px auto 0; padding:0;}
.heySomething .brand h3 {position:absolute; bottom:0; left:0;}
.heySomething .brand ul li {position:absolute;}
.heySomething .brand ul li.first {top:0; left:0;}
.heySomething .brand ul li.second {top:0; right:0;}
.heySomething .brand ul li.third {right:0; bottom:0;}

/* story 1 */
.heySomething .story {padding:0;}
.heySomething .story1 {margin-top:410px;}
.heySomething .story1 h3 {margin-bottom:0;}
.heySomething .story1 .rolling {width:100%; height:870px; padding-top:0;}
.heySomething .slide {position:relative;}
.heySomething .rolling .slidesjs-slide {width:100%; height:870px;}
.heySomething .rolling .slidesjs-slide-01 {background-color:#a2b4ae;}
.heySomething .rolling .slidesjs-slide-02 {background-color:#f5f5f6;}
.heySomething .rolling .slidesjs-slide-03 {background-color:#ecebea;}
.heySomething .rolling .slidesjs-slide a {display:block; position:relative; width:100%; height:100%;}
.heySomething .slidesjs-slide .desc {position:absolute; z-index:10; top:400px; left:50%;}
.heySomething .slidesjs-slide .visual {position:absolute; top:0; left:50%; margin-top:0; margin-left:-951px;}
.heySomething .slidesjs-slide-01 .desc {margin-left:46px;}
.heySomething .slidesjs-slide-02 .desc {top:431px; margin-left:77px;}
.heySomething .slidesjs-slide-03 .desc {top:495px; margin-left:58px;}
.heySomething .rolling .slidesjs-navigation {position:absolute; top:50%; left:50%; z-index:50; width:54px; height:97px; margin-top:-48px; background:transparent url(http://webimage.10x10.co.kr/eventIMG/2016/hey/70746/btn_nav_white_v1.png) no-repeat 0 0; text-indent:-999em}
.heySomething .rolling .slidesjs-previous {margin-left:-540px;}
.heySomething .rolling .slidesjs-next {margin-left:490px; background-position:100% 0;}

/* item */
.heySomething .item {width:1140px; margin:436px auto 0; padding:0;}
.heySomething .item h3 {position:relative; height:52px; text-align:center;}
.heySomething .item h3 .horizontalLine1, .heySomething .item h3 .horizontalLine2 {position:absolute; top:31px; width:359px; height:1px; background-color:#ddd;}
.heySomething .item h3 .horizontalLine1 {left:0;}
.heySomething .item h3 .horizontalLine2 {right:0;}
.heySomething .item .desc {position:relative; width:1050px; height:394px; margin:150px auto 0; padding-bottom:165px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/70310/bg_line_dashed.png) repeat-x 0 100%;}
.heySomething .item .desc1 {margin-top:120px;}
.heySomething .item .desc3 {padding-bottom:100px; border-bottom:1px solid #ddd; background:none;}
.heySomething .item .desc .option {height:394px;}
.heySomething .item .desc a {display:block;}
.heySomething .item .desc a:hover {text-decoration:none;}
.heySomething .item .thumbnail {position:absolute; top:-17px;}
.heySomething .item .desc1 .thumbnail, .heySomething .item .desc3 .thumbnail {right:35px;}
.heySomething .item .desc1 .option, .heySomething .item .desc3 .option {margin-left:40px;}
.heySomething .item .desc2 .option {margin-right:40px;}
.heySomething .item .desc2 .thumbnail {top:-30px;}
.heySomething .item .desc3 .thumbnail {top:-70px;}
.heySomething .item .desc2 .option {float:right;}
.heySomething .item .desc2 .thumbnail {left:35px;}
.heySomething .item .with {margin-top:45px; border:none;}
.heySomething .item .with span {position:relative; z-index:5;}
.heySomething .item .with {border-bottom:1px solid #ddd; text-align:center;}
.heySomething .item .with ul {overflow:hidden; width:1010px; margin:0 auto; padding:45px 0;}
.heySomething .item .with ul li {float:left; width:178px; padding:0 12px;}
.heySomething .item .with ul li a {color:#777;}
.heySomething .item .with ul li span, .heySomething .with ul li strong {display:block; font-size:11px;}
.heySomething .item .with ul li span {margin-top:15px;}

/* story 2 */
.heySomething .story2 {margin-top:510px; padding-bottom:90px;}
.heySomething .story2 h3 {margin-bottom:45px;}
.heySomething .story2 .rolling {padding-top:178px;}
.heySomething .rolling .pagination {top:0; width:980px; margin-left:-490px;}
.heySomething .rolling .pagination .swiper-pagination-switch {float:none; position:absolute; top:0; left:155px; width:154px; height:154px; margin:0; background:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/70746/img_ico.png) no-repeat 0 0;}
.heySomething .rolling .pagination span.swiper-active-switch {z-index:5; background-position:0 -154px;}
.heySomething .rolling .pagination span:first-child + span {left:155px; background-position:0 0;}
.heySomething .rolling .pagination span:first-child + span.swiper-active-switch {background-position:0 -154px;}
.heySomething .rolling .pagination span:first-child + span + span {left:419px; background-position:-263px 0;}
.heySomething .rolling .pagination span:first-child + span + span.swiper-active-switch {background-position:-263px -154px;}
.heySomething .rolling .pagination span:first-child + span + span + span {left:419px; background-position:-263px 0;}
.heySomething .rolling .pagination span:first-child + span + span + span.swiper-active-switch {background-position:-263px -154px;}
.heySomething .rolling .pagination span:first-child + span + span + span + span {left:667px; background-position:-512px 0;}
.heySomething .rolling .pagination span:first-child + span + span + span + span.swiper-active-switch {background-position:-512px -154px;}
.heySomething .rolling .pagination span:first-child + span + span + span + span + span {left:667px; background-position:-512px 0;}
.heySomething .rolling .pagination span:first-child + span + span + span + span + span.swiper-active-switch {background-position:-512px -154px;}

.heySomething .rolling .pagination span em {top:808px; left:-155px; margin:0; width:980px; height:90px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/70746/txt_story_desc.png); cursor:default;}
.heySomething .rolling .pagination span .desc1,
.heySomething .rolling .pagination span .desc2 {background-position:0 100%;}
.heySomething .rolling .pagination span .desc3,
.heySomething .rolling .pagination span .desc4 {left:-419px; background-position:0 -90px;}
.heySomething .rolling .pagination span .desc5,
.heySomething .rolling .pagination span .desc6 {left:-667px; background-position:0 0;}
.heySomething .rolling .btn-nav {top:450px;}
.heySomething .swipemask {top:178px;}

/* finish */
.heySomething .finish {background-color:#edeae9; height:781px; margin-top:500px;}
.heySomething .finish .visual {position:absolute; top:0; left:50%; margin-top:0; margin-left:-951px;}
.heySomething .finish p {top:190px; width:456px; margin-left:-562px;}

/* comment */
.heySomething .commentevet .form {margin-top:7px;}
.heySomething .commentevet .form .choice li {width:112px; margin-right:20px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/70746/img_ico.png); background-position:0 -308px;}
.heySomething .commentevet .form .choice li .button .on {background-position:100% -308px;}
.heySomething .commentevet .form .choice li.ico2 button {background-position:-133px -308px;}
.heySomething .commentevet .form .choice li.ico2 button.on {background-position:-133px 100%;}
.heySomething .commentevet .form .choice li.ico3 button {background-position:-266px -308px;}
.heySomething .commentevet .form .choice li.ico3 button.on {background-position:-266px 100%;}

.heySomething .commentlist table td strong {height:80px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/70746/img_ico.png); background-position:0 -343px;}
.heySomething .commentlist table td strong.ico2 {background-position:-133px -343px;}
.heySomething .commentlist table td strong.ico3 {background-position:-266px -343px;}
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
		<% If not( left(currenttime,10)>="2016-05-16" and left(currenttime,10)<"2016-05-24" ) Then %>
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
			<div class="bnr">
				<a href="/shopping/category_prd.asp?itemid=1490115&amp;pEtr=70746"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70746/img_item_represent.jpg" alt="스몰카라 그린 leaf 디퓨저" /></a>
			</div>
		</div>
		<%' about %>
		<div class="about">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
			<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
		</div>
		<%' brand %>
		<div class="brand">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70746/img_brand_logo.jpg" alt="블루밍앤미 그린 leaf 디퓨저" /></h3>
			<ul>
				<li class="first"><a href="/shopping/category_prd.asp?itemid=1490114&amp;pEtr=70746"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70746/img_brand_01.jpg" alt="dried 유칼립투스" /></a>
				<li class="second"><a href="/shopping/category_prd.asp?itemid=1490115&amp;pEtr=70746"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70746/img_brand_02.jpg" alt="스몰카라" /></a>
				<li class="third"><a href="/shopping/category_prd.asp?itemid=1490116&amp;pEtr=70746"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70746/img_brand_03.jpg" alt="트로피칼" /></a>
			</ul>
		</div>
		<%' story 1 %>
		<div class="story story1">
			<div id="slide" class="rolling">
				<div class="slidesjs-slide-01">
					<a href="/shopping/category_prd.asp?itemid=1490115&amp;pEtr=70746">
						<p class="desc"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70746/txt_desc_01.png" alt="점점 더워지는 날씨, 싱그럽고 기분 좋게 하루를 보내는 방법 없을까요?" /></p>
						<div class="visual"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70746/img_slide_01_01_v1.jpg" alt="스몰카라" /></div>
					</a>
				</div>
				<div class="slidesjs-slide-02">
					<a href="/shopping/category_prd.asp?itemid=1490116&amp;pEtr=70746">
						<p class="desc"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70746/txt_desc_02.png" alt="블루밍앤미의 그린 leaf 디퓨저와 함께 해보세요" /></p>
						<div class="visual"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70746/img_slide_01_02.jpg" alt="트로피칼" /></div>
					</a>
				</div>
				<div class="slidesjs-slide-03">
					<a href="/shopping/category_prd.asp?itemid=1490114&amp;pEtr=70746">
						<p class="desc"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70746/txt_desc_03.png" alt="그러운 녹색의 식물과 6가지 향기가 여러분의 일상에 힐링을 선물해 드려요" /></p>
						<div class="visual"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70746/img_slide_01_03.jpg" alt="dried 유칼립투스" /></div>
					</a>
				</div>
			</div>
		</div>
		<%' item %>
		<div class="item">
			<div class="inner">
				<h3>
					<span class="logo"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70746/img_logo_blooming_and_me.png" alt="블루밍앤미" /></span>
					<span class="horizontalLine1"></span>
					<span class="horizontalLine2"></span>
				</h3>
			<%
				IF application("Svr_Info") = "Dev" THEN
					itemid = 1239226
				Else
					itemid = 1490116
				End If
				set oItem = new CatePrdCls
					oItem.GetItemData itemid
			%>
				<div class="desc desc1">
					<a href="/shopping/category_prd.asp?itemid=1490116&amp;pEtr=70310">
						<div class="option">
							<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70746/txt_name_tropical.png" alt="트로피칼 그린 leaf 디퓨저" /></p>
							<%' for dev msg : 상품코드 1490116, 할인기간 5/18~5/24, 할인 종료 후 <strong class="discount">...</strong> 숨겨주세요 %>
						<% If oItem.FResultCount > 0 Then %>
							<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
							<div class="price">
								<% If not( left(currenttime,10)>="2016-05-18" and left(currenttime,10)<="2016-05-24" ) Then %>
								<% Else %>
								<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/txt_only_20percent.png" alt="텐바이텐에서만 ONLY 20%" /></strong>
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
							<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러 가기" /></div>
						</div>
						<div class="thumbnail"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70746/img_item_tropical.jpg" alt="" /></div>
					</a>
				</div>
			<% set oItem=nothing %>
			<%
				IF application("Svr_Info") = "Dev" THEN
					itemid = 786868
				Else
					itemid = 1490115
				End If
				set oItem = new CatePrdCls
					oItem.GetItemData itemid
			%>
				<div class="desc desc2">
					<a href="/shopping/category_prd.asp?itemid=1490115&amp;pEtr=70310">
						<div class="option">
							<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70746/txt_name_small_kara.png" alt="스몰카라 그린 leaf 디퓨저" /></p>
							<%' for dev msg : 상품코드 1490115, 할인기간 5/18~5/24, 할인 종료 후 <strong class="discount">...</strong> 숨겨주세요 %>
						<% If oItem.FResultCount > 0 Then %>
							<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
							<div class="price">
								<% If not( left(currenttime,10)>="2016-05-18" and left(currenttime,10)<="2016-05-24" ) Then %>
								<% Else %>
								<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/txt_only_20percent.png" alt="텐바이텐에서만 ONLY 20%" /></strong>
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
							<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러 가기" /></div>
						</div>
						<div class="thumbnail"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70746/img_item_small_kara.jpg" alt="" /></div>
					</a>
				</div>
			<% set oItem=nothing %>
			<%
				IF application("Svr_Info") = "Dev" THEN
					itemid = 786868
				Else
					itemid = 1490114
				End If
				set oItem = new CatePrdCls
					oItem.GetItemData itemid
			%>
				<div class="desc desc3">
					<a href="/shopping/category_prd.asp?itemid=1490114&amp;pEtr=70310">
						<div class="option">
							<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70746/txt_name_dried_eucalyptus.png" alt="dried 유칼립투스 그린 leaf 디퓨저" /></p>
							<%' for dev msg : 상품코드 1490114, 할인기간 5/18~5/24, 할인 종료 후 <strong class="discount">...</strong> 숨겨주세요 %>
						<% If oItem.FResultCount > 0 Then %>
							<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
							<div class="price">
								<% If not( left(currenttime,10)>="2016-05-18" and left(currenttime,10)<="2016-05-24" ) Then %>
								<% Else %>
								<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/txt_only_20percent.png" alt="텐바이텐에서만 ONLY 20%" /></strong>
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
							<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러 가기" /></div>
						</div>
						<div class="thumbnail"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70746/img_item_dried_eucalyptus.jpg" alt="" /></div>
					</a>
				</div>
			<% set oItem=nothing %>
			</div>
		</div>
		<%' story 2 %>
		<div class="story story2">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70746/tit_story.png" alt="향기로 완성하는 공간 디자인 그린 leaf 디퓨저" /></h3>
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
									<a href="/shopping/category_prd.asp?itemid=1490115&amp;pEtr=70746" title="스몰카라 그린 leaf 디퓨저"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70746/img_slide_02_01.jpg" alt="자연을 담은 향기와 함께하는 기분 좋은 휴식을 즐겨 보세요" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1490115&amp;pEtr=70746" title="스몰카라 그린 leaf 디퓨저"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70746/img_slide_02_02.jpg" alt="" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1490116&amp;pEtr=70746" title="트로피칼 그린 leaf 디퓨저"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70746/img_slide_02_03.jpg" alt="화병 같은 그린 leaf 디퓨져가 카페 같은 주방을 만들어 드려요" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1490116&amp;pEtr=70746" title="트로피칼 그린 leaf 디퓨저"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70746/img_slide_02_04.jpg" alt="" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1490114&amp;pEtr=70746" title="dried 유칼립투스 그린 leaf 디퓨저"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70746/img_slide_02_05.jpg" alt="욕실에서 보내는 시간이 많아지는 여름 시즌을 위해 준비해 보세요" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1490114&amp;pEtr=70746" title="dried 유칼립투스 그린 leaf 디퓨저"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70746/img_slide_02_06.jpg" alt="" /></a>
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
			<a href="/shopping/category_prd.asp?itemid=1490115&amp;pEtr=70746">
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70746/txt_finish.png" alt="공간을 스타일링하고 디자인하는 여러 가지 방법이 있습니다. 이 중 가장 고급스럽고 세련된 공간 연출법은 향기로 완성하는 공간 디자인이 아닐까 합니다. 내가 머무는 공간, 나에게 소중한 공간을 향기로 디자인 해보세요. 코끝을 스치는 기분 좋은 향기가 여러분의 일상을 더욱 행복하게 해드릴 거에요." /></p>
				<div class="visual"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70746/img_finish.jpg" alt="" /></div>
			</a>
		</div>
		<%' comment %>
		<div class="commentevet">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70746/tit_comment.png" alt="Hey, something project 함께 하고 싶은 향기" /></h3>
			<p class="hidden">여러분은 어떤 공간에 어떤 디퓨저를 두고 싶으세요? 정성껏 코멘트를 남겨주신 분 중 3분을 선정하여 그린 leaf 디퓨저를 보내드려요. 코멘트 작성기간은 2016년 5월 18일부터 5월 24일까지며, 발표는 5월 27일 입니다.</p>
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
					<legend>그린 leaf 디퓨저 코멘트 쓰기</legend>
						<ul class="choice">
							<li class="ico1"><button type="button" value="1">bathroom</button></li>
							<li class="ico2"><button type="button" value="2">kitchen</button></li>
							<li class="ico3"><button type="button" value="3">bedroom</button></li>
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
										bathroom
									<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="2" Then %>
										kitchen
									<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="3" Then %>
										bedroom
									<% Else %>
										bathroom
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
		width:"1903",
		height:"870",
		pagination:false,
		navigation:{effect:"fade"},
		play:{interval:3000, effect:"fade", auto:true},
		effect:{fade: {speed:800}},
		callback: {
			start: function() {
				$(".heySomething #slide .slidesjs-slide .desc").css({"margin-top":"5px", "opacity":"0"});
			},
			complete: function() {
				$(".heySomething #slide .slidesjs-slide .desc").delay(10).animate({"margin-top":"0", "opacity":"1"},300);
			}
		}
	});

	/* swipe js */
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
	$('.pagination span:nth-child(6)').append('<em class="desc6"></em>');

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

	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 1000 ) {
			brandAnimation();
		}
		if (scrollTop > 8000 ) {
			finishAnimation();
		}
	});

	/* title animation */
	titleAnimation();
	$(".heySomething .topic h2 span").css({"opacity":"0"});
	$(".heySomething .topic h2 .letter1").css({"margin-top":"7px"});
	$(".heySomething .topic h2 .letter2").css({"margin-top":"15px"});
	$(".heySomething .topic h2 .letter3").css({"margin-top":"23px"});
	function titleAnimation() {
		$(".heySomething .topic h2 .letter1").delay(100).animate({"margin-top":"0", "opacity":"1"},700);
		$(".heySomething .topic h2 .letter2").delay(400).animate({"margin-top":"7px", "opacity":"1"},700);
		$(".heySomething .topic h2 .letter3").delay(800).animate({"margin-top":"17px", "opacity":"1"},700);
	}

	$(".heySomething .brand h3").css({"bottom":"-5px", "left":"-5px", "opacity":"0"});
	$(".heySomething .brand ul li.first").css({"top":"-5px", "left":"-5px", "opacity":"0"});
	$(".heySomething .brand ul li.second").css({"top":"-5px", "right":"-5px", "opacity":"0"});
	$(".heySomething .brand ul li.third").css({"bottom":"-5px", "right":"-5px", "opacity":"0"});
	function brandAnimation() {
		$(".heySomething .brand h3").delay(100).animate({"bottom":"0", "left":"0", "opacity":"1"},700);
		$(".heySomething .brand ul li.first").delay(100).animate({"top":"0", "left":"0", "opacity":"1"},700);
		$(".heySomething .brand ul li.second").delay(100).animate({"top":"0", "right":"0", "opacity":"1"},700);
		$(".heySomething .brand ul li.third").delay(100).animate({"bottom":"0", "right":"0", "opacity":"1"},700);
		
	}

	$(".heySomething .finish p").css({"height":"38px", "opacity":"0"});
	function finishAnimation() {
		$(".heySomething .finish p").delay(100).animate({"height":"316px", "opacity":"1"},1500);
	}
});
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->