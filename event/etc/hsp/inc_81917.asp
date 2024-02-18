<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'###########################################################
' Description : hey, something project 시리즈 95 WWW
' 시간이 지닌 색
' History : 2017-11-14 유태욱 생성
'###########################################################
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
'	currenttime = #11/10/2017 09:00:00#

dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  67460
Else
	eCode   =  81917
End If

dim userid, commentcount, i
	userid = GetEncLoginUserID()

if userid = "baboytw" or userid = "chaem35" or userid = "answjd248" then
	currenttime = #11/15/2017 09:00:00#
end if

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
.heySomething .topic {background-color:#f4fafe; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/81917/img_item_represent.jpg);}

/* brand */
.heySomething .brand {position:relative; height:740px; margin:339px 0 0; text-align:center;}
.heySomething .frame {width:787px; height:503px; margin:35px auto 0; border:2px solid #e5ded0;}
.heySomething .frame img {margin-top:10px;}
.heySomething .brand .btnDown {margin-top:39px;}

/* item */
.heySomething .item {position:relative; width:1140px; margin:403px auto 0;}
.heySomething .item .name {position:absolute; top:165px; left:80px; z-index:15;}
.heySomething .item a {display:block;}
.heySomething .item .slidesjs-slide {width:1140px;}
.heySomething .slidesjs-slide a {overflow:hidden; position:relative; width:100%;}
.heySomething .slidesjs-slide .option {position:absolute; top:373px !important; left:80px; height:109px;}
.heySomething .item .option .price,
.heySomething .item .option .price s {margin-top:0;}
.heySomething .slidesjs-pagination li {float:left; width:181px; height:181px; margin-left:10px;}
.heySomething .slidesjs-pagination li:first-child {margin-left:0;}
.heySomething .slidesjs-pagination a {position:relative; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/81917/btn_pagination_item.jpg?v=1.0) 0 0 no-repeat; text-indent:-9999em;}
.heySomething .slidesjs-pagination .active {background-position:0 100%;}
.heySomething .slidesjs-pagination li:first-child + li a {background-position:-191px 0;}
.heySomething .slidesjs-pagination li:first-child + li .active {background-position:-191px 100%;}
.heySomething .slidesjs-pagination li:first-child + li + li a {background-position:-381px 0;}
.heySomething .slidesjs-pagination li:first-child + li + li .active {background-position:-381px 100%;}
.heySomething .slidesjs-pagination li:first-child + li + li + li a {background-position:-572px 0;}
.heySomething .slidesjs-pagination li:first-child + li + li + li .active {background-position:-572px 100%;}
.heySomething .slidesjs-pagination li:first-child + li + li + li + li a {background-position:-763px 0;}
.heySomething .slidesjs-pagination li:first-child + li + li + li + li .active {background-position:-763px 100%;}
.heySomething .slidesjs-pagination li:first-child + li + li + li + li + li a {background-position:100% 0;}
.heySomething .slidesjs-pagination li:first-child + li + li + li + li + li .active {background-position:100% 100%;}
.heySomething .slidesjs-pagination span {position:absolute; top:0; left:0; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/81917/bg_paginaton_item_txt.png) 0 0 no-repeat; transform:translateY(10px); transition:transform 0.5s ease-in-out 0s; opacity:0;}
.heySomething .slidesjs-pagination .active span {transform:translateY(0); opacity:1;}
.heySomething .slidesjs-pagination li:first-child + li span {background-position:-191px 0;}
.heySomething .slidesjs-pagination li:first-child + li + li span {background-position:-572px 0;}
.heySomething .slidesjs-pagination li:first-child + li + li + li span {background-position:-381px 0;}
.heySomething .slidesjs-pagination li:first-child + li + li + li + li span {background-position:-763px 0;}
.heySomething .slidesjs-pagination li:first-child + li + li + li + li + li span {background-position:100% 0;}

/* finish */
.heySomething .finish {height:630px; margin-top:453px; background:#c1c4c6 url(http://webimage.10x10.co.kr/eventIMG/2017/hey/81917/bg_finish.jpg) 50% 0 no-repeat;}
.heySomething .finish p {top:237px; margin-left:-496px; width:323px; height:142px;}
.heySomething .finish p .letter {width:100%; height:68px; background:transparent url(http://webimage.10x10.co.kr/eventIMG/2017/hey/81917/txt_finish.png) 0 0 no-repeat; text-indent:-999em; opacity:0;}
.heySomething .finish p .letter2 {height:60px; margin-top:14px; background-position:0 100%;}
.move1 {animation:move1 1.5s forwards; animation-fill-mode:both;}
.move2 {animation:move2 1.5s forwards; animation-fill-mode:both;}
@keyframes move1 {
	0% {transform:translateX(50px); opacity:0;}
	100% {transform:translateX(0); opacity:1;}
}
@keyframes move2 {
	0% {transform:translateX(-50px); opacity:0;}
	100% {transform:translateX(0); opacity:1;}
}

/* story */
.heySomething .story {margin:450px 0 0;}
.heySomething .rollingwrap {margin-top:0;}
.heySomething .rolling {padding-top:173px;}
.heySomething .rolling .pagination {padding-left:88px;}
.heySomething .rolling .pagination span {width:90px; height:138px; margin:0 22px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/81917/bg_paginaton_story.png);}
.heySomething .rolling .pagination span.swiper-active-switch {background-position:0 100%;}
.heySomething .rolling .pagination span:first-child + span {background-position:-134px 0;}
.heySomething .rolling .pagination span:first-child + span.swiper-active-switch {background-position:-134px 100%;}
.heySomething .rolling .pagination span:first-child + span + span {background-position:-268px 0;}
.heySomething .rolling .pagination span:first-child + span + span.swiper-active-switch {background-position:-268px 100%;}
.heySomething .rolling .pagination span:first-child + span + span + span {background-position:-401px 0;}
.heySomething .rolling .pagination span:first-child + span + span + span.swiper-active-switch {background-position:-401px 100%;}
.heySomething .rolling .pagination span:first-child + span + span + span + span {background-position:-535px 0;}
.heySomething .rolling .pagination span:first-child + span + span + span + span.swiper-active-switch {background-position:-535px 100%;}
.heySomething .rolling .pagination span:first-child + span + span + span + span + span {background-position:100% 0;}
.heySomething .rolling .pagination span:first-child + span + span + span + span + span.swiper-active-switch {background-position:100% 100%;}
.heySomething .rolling .pagination span em {bottom:-789px; margin:0; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/81917/txt_story_desc_v1.gif); cursor:default;}
.heySomething .rolling .btn-nav {top:445px;}
.heySomething .swipemask {top:173px;}

/* comment */
.heySomething .commentevet {margin-top:429px;}
.heySomething .commentevet {padding-top:52px;}
.heySomething .commentevet textarea {margin-top:37px;}
.heySomething .commentevet .form {margin-top:30px;}
.heySomething .commentevet .form .choice li {width:85px; height:118px; margin-right:25px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/81917/bg_ico_comment.png);}
.heySomething .commentevet .form .choice li.ico2 button {background-position:-117px 0;}
.heySomething .commentevet .form .choice li.ico2 button.on {background-position:-117px 100%;}
.heySomething .commentevet .form .choice li.ico3 button {background-position:-234px 0;}
.heySomething .commentevet .form .choice li.ico3 button.on {background-position:-234px 100%;}
.heySomething .commentevet .form .choice li.ico4 button {background-position:-351px 0;}
.heySomething .commentevet .form .choice li.ico4 button.on {background-position:-351px 100%;}
.heySomething .commentevet .form .choice li.ico5 button {background-position:-468px 0;}
.heySomething .commentevet .form .choice li.ico5 button.on {background-position:-468px 100%;}
.heySomething .commentevet .form .choice li.ico6 button {background-position:100% 0;}
.heySomething .commentevet .form .choice li.ico6 button.on {background-position:100% 100%;}
.heySomething .commentlist table td strong {width:85px; height:118px; margin-left:40px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/81917/bg_ico_comment.png); background-position:0 0;}
.heySomething .commentlist table td .ico2 {background-position:-117px 0;}
.heySomething .commentlist table td .ico3 {background-position:-234px 0;}
.heySomething .commentlist table td .ico4 {background-position:-351px 0;}
.heySomething .commentlist table td .ico5 {background-position:-468px 0;}
.heySomething .commentlist table td .ico6 {background-position:100% 0;}
</style>
<script type="text/javascript">
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
		<% If not( left(currenttime,10) >= "2017-11-15" and left(currenttime,10) < "2017-11-23" ) Then %>
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
					alert("코멘트를 남겨주세요.\n한글 400자 까지 작성 가능합니다.");
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
			top.location.href="/login/loginpage.asp?vType=G";
			return false;
//			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
//			winLogin.focus();
//			return false;
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
			top.location.href="/login/loginpage.asp?vType=G";
			return false;
//			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
//			winLogin.focus();
//			return false;
		}
		return false;
	}
}
</script>

	<% If Not(Trim(hspchk(1)))="hsproject" Then %>
	<div class="heySomething">
	<% end if %>
		<% If Not(Trim(hspchk(1)))="hsproject" Then %>
			<%' for dev mgs :  탭 navigator %>
			<div class="navigator">
				<ul>
					<!-- #include virtual="/event/etc/inc_66049_menu.asp" -->
				</ul>
				<span class="line"></span>
			</div>
		<% End If %>
		<div id="topic" class="topic">
			<h2>
				<span class="letter1">Hey,</span>
				<span class="letter2">something</span>
				<span class="letter3">project</span>
			</h2>
		</div>

		<!-- about -->
		<div class="about">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
			<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
		</div>

		<!-- brand -->
		<div class="brand">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81917/tit_brand.gif" alt="시간을 뉘어놓는 시간 TIME TRAY" /></h3>
			<div class="frame"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81917/img_brand_ani.gif" alt="" /></div>
			<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="" /></div>
		</div>

		<!-- item -->
		<div class="item">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81917/tit_vilivstudio.gif" alt="VILIVSTUDIO" /></h3>
			
			<div class="slidewrap">
				<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81917/txt_item_name.gif" alt="Time Tra는 스몰, 라지 사이즈, 핑크, 네이비, 그린, 그레이, 레드, 블랙 6가지 컬러로 시계를 모티브로 하여 디자인 되었습니다. 시침과 분침의 이미지를 파티션으로 형상화하여 원하는대로 공간을 자유자재로 조절할 수 있어 더욱 실용적으로 활용이 가능합니다." /></p>
				<div id="slide" class="slide">
					<%
					IF application("Svr_Info") = "Dev" THEN
						itemid = 1239226
					Else
						itemid = 1812275
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
					%>
					<div class="desc">
						<a href="/shopping/category_prd.asp?itemid=1812275&pEtr=81917">
							<div class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81917/img_item_01.jpg" alt="핑크" /></div>
							<div class="option">
							<% If oItem.FResultCount > 0 Then %>
								<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
								<div class="price">
									<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> <span>(<%= Format00(1, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%)</span></strong>
								</div>
								<% Else %>
								<div class="price priceEnd" >
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								</div>
								<% End If %>
							<% End If %>
								<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러 가기" /></div>
							</div>
						</a>
					</div>
					<%
					set oItem = nothing
					%>

					<%
					IF application("Svr_Info") = "Dev" THEN
						itemid = 1239226
					Else
						itemid = 1812277
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
					%>
					<div class="desc">
						<a href="/shopping/category_prd.asp?itemid=1812277&pEtr=81917">
							<div class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81917/img_item_02.jpg" alt="네이비" /></div>
							<div class="option">
							<% If oItem.FResultCount > 0 Then %>
								<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
								<div class="price">
									<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> <span>(<%= Format00(1, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%)</span></strong>
								</div>
								<% Else %>
								<div class="price priceEnd" >
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								</div>
								<% End If %>
							<% End If %>
								<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러 가기" /></div>
							</div>
						</a>
					</div>
					<%
					set oItem = nothing
					%>

					<%
					IF application("Svr_Info") = "Dev" THEN
						itemid = 1239226
					Else
						itemid = 1812276
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
					%>
					<div class="desc">
						<a href="/shopping/category_prd.asp?itemid=1812276&pEtr=81917">
							<div class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81917/img_item_03.jpg" alt="그린" /></div>
							<div class="option">
							<% If oItem.FResultCount > 0 Then %>
								<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
								<div class="price">
									<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> <span>(<%= Format00(1, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%)</span></strong>
								</div>
								<% Else %>
								<div class="price priceEnd" >
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								</div>
								<% End If %>
							<% End If %>
								<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러 가기" /></div>
							</div>
						</a>
					</div>
					<%
					set oItem = nothing
					%>

					<%
					IF application("Svr_Info") = "Dev" THEN
						itemid = 1239226
					Else
						itemid = 1812273
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
					%>
					<div class="desc">
						<a href="/shopping/category_prd.asp?itemid=1812273&pEtr=81917">
							<div class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81917/img_item_04.jpg" alt="그레이" /></div>
							<div class="option">
							<% If oItem.FResultCount > 0 Then %>
								<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
								<div class="price">
									<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> <span>(<%= Format00(1, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%)</span></strong>
								</div>
								<% Else %>
								<div class="price priceEnd" >
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								</div>
								<% End If %>
							<% End If %>
								<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러 가기" /></div>
							</div>
						</a>
					</div>
					<%
					set oItem = nothing
					%>

					<%
					IF application("Svr_Info") = "Dev" THEN
						itemid = 1239226
					Else
						itemid = 1812278
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
					%>
					<div class="desc">
						<a href="/shopping/category_prd.asp?itemid=1812278&pEtr=81917">
							<div class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81917/img_item_05.jpg" alt="레드" /></div>
							<div class="option">
							<% If oItem.FResultCount > 0 Then %>
								<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
								<div class="price">
									<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> <span>(<%= Format00(1, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%)</span></strong>
								</div>
								<% Else %>
								<div class="price priceEnd" >
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								</div>
								<% End If %>
							<% End If %>
								<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러 가기" /></div>
							</div>
						</a>
					</div>
					<%
					set oItem = nothing
					%>

					<%
					IF application("Svr_Info") = "Dev" THEN
						itemid = 1239226
					Else
						itemid = 1812274
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
					%>
					<div class="desc">
						<a href="/shopping/category_prd.asp?itemid=1812274&pEtr=81917">
							<div class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81917/img_item_06.jpg" alt="블랙" /></div>
							<div class="option">
							<% If oItem.FResultCount > 0 Then %>
								<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
								<div class="price">
									<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> <span>(<%= Format00(1, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%)</span></strong>
								</div>
								<% Else %>
								<div class="price priceEnd" >
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								</div>
								<% End If %>
							<% End If %>
								<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러 가기" /></div>
							</div>
						</a>
					</div>
					<%
					set oItem = nothing
					%>
				</div>
			</div>
		</div>

		<!-- finish -->
		<div id="finish" class="finish">
			<p>
				<span class="letter letter1">작은 것들을 더 소중하고 돋보이게</span>
				<span class="letter letter2">TIME TRAY</span>
			</p>
		</div>

		<!-- story -->
		<div class="story">
			<div class="rollingwrap">
				<div id="rolling" class="rolling">
					<div class="swipemask mask-left"></div>
					<div class="swipemask mask-right"></div>
					<button type="button" class="btn-nav arrow-left">Previous</button>
					<button type="button" class="btn-nav arrow-right">Next</button>
					<div class="swiper">
						<div class="swiper-container">
							<div class="swiper-wrapper">
								<div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1812275&pEtr=81917"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81917/img_slide_story_01.jpg" alt="사랑스러움으로 물든 Pink" /></a></div>
								<div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1812277&pEtr=81917"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81917/img_slide_story_02.jpg" alt="겨울 밤이 생각나는 Navy" /></a></div>
								<div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1812276&pEtr=81917"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81917/img_slide_story_03.jpg" alt="올해의 컬러 Green" /></a></div>
								<div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1812273&pEtr=81917"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81917/img_slide_story_04.jpg" alt="때로는 아날로그 감성 Gray" /></a></div>
								<div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1812278&pEtr=81917"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81917/img_slide_story_05.jpg" alt="매혹적 그리고 치명적인 Red" /></a></div>
								<div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1812274&pEtr=81917"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81917/img_slide_story_06.jpg" alt="무심한듯 시크하게 Black" /></a></div>
							</div>
						</div>
					</div>
					<div class="pagination"></div>
				</div>
			</div>
		</div>

		<!-- comment -->
		<div class="commentevet">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81917/tit_comment_v1.jpg" alt="Hey, something project, 당신과 어울리는 테이블" /></h3>
			<p class="hidden">빌리브스튜디오의 트레이 중 가장 마음에 드는 컬러나, 새로운 컬러가 출시된다면 가장 갖고 싶은 컬러는 무엇인가요? 정성스러운 코멘트를 남겨주신 5분을 추첨하여 명함꽂이 or 황동 마그넷을 선물로 드립니다. 랜덤발송 기간 : 2017.11.15 ~ 11.22, 발표 : 11.23</p>
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
							<li class="ico1"><button type="button" value="1">PINK</button></li>
							<li class="ico2"><button type="button" value="2">NAVY</button></li>
							<li class="ico3"><button type="button" value="3">GREEN</button></li>
							<li class="ico4"><button type="button" value="4">GRAY</button></li>
							<li class="ico5"><button type="button" value="5">RED</button></li>
							<li class="ico6"><button type="button" value="6">BLACK</button></li>
						</ul>
						<textarea title="코멘트 작성" cols="60" rows="5" name="txtcomm1" id="txtcomm1" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();" <%IF NOT(IsUserLoginOK) THEN%>readonly<%END IF%>><%IF NOT IsUserLoginOK THEN%>로그인 후 글을 남길 수 있습니다.<% else %><%END IF%></textarea>
						<div class="note01 overHidden">
							<ul class="list01 ftLt">
								<li>입력하신 블로그 주소는 개인정보 유출로 인한 피해를 막고자 비공개로 텐바이텐에 접수됩니다.</li>
								<li>통신예절에 어긋나는 글이나 상업적인 글, 타 사이트에 관련된 글 또는 도용한 글은 관리자에 의해 사전 통보 없이 삭제될 수 있으며,<br>이벤트 참여에 제한을 받을 수 있습니다.</li>
							</ul>
							<input type="submit" class="ftRt btn btnW130 btnS1 btnRed" value="코멘트 남기기" onclick="jsSubmitComment(document.frmcom); return false;" />
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

			<!-- commentlist -->
			<div class="commentlist" id="commentlist">
				<p class="total">total <%= iCTotCnt %></p>
				<% IF isArray(arrCList) THEN %>
				<table>
					<caption>코멘트 목록 - 코멘트 작성시 선택 항목, 내용, 작성일자, 아이디 정보를 제공하는 표</caption>
					<colgroup>
						<col style="width:160px;" />
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
												PINK
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="2" then %>
												NAVY
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="3" then %>
												GREEN
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="4" then %>
												GRAY
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="5" then %>
												RED
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="6" then %>
												BLACK
											<% else %>
												PINK
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
						<% next %>
					</tbody>
				</table>
				<% end if %>
			<!-- paging -->
			<div class="pageWrapV15">
				<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
			</div>
			</div>
		</div>
	<% If Not(Trim(hspchk(1)))="hsproject" Then %>
	</div>
	<% End If %>
<script type="text/javascript">
$(function(){
	/* slide js */
	$("#slide").slidesjs({
		width:"1140",
		height:"572",
		pagination:{effect:"fade"},
		navigation:false,
		play:false,
		effect:{fade: {speed:500, crossfade:true}}
	});
	$("#slide .slidesjs-pagination li a").append('<span></span>');

	/* mouse control */
	$('#slide .slidesjs-pagination > li a').mouseenter(function(){
		$('#slide a[data-slidesjs-item="' + $(this).attr("data-slidesjs-item") + '"]').trigger('click');
	});


	/* swipe */
	var swiper1 = new Swiper("#rolling .swiper-container",{
		centeredSlides:true,
		slidesPerView:"auto",
		loop: true,
		speed:1500,
		autoplay:3000,
		simulateTouch:false,
		pagination:"#rolling .pagination",
		paginationClickable: true
	});
	$("#rolling .arrow-left").on("click", function(e){
		e.preventDefault()
		swiper1.swipePrev()
	});
	$("#rolling .arrow-right").on("click", function(e){
		e.preventDefault()
		swiper1.swipeNext()
	});

	$("#rolling .pagination span:nth-child(1)").append('<em class="desc1"></em>');
	$("#rolling .pagination span:nth-child(2)").append('<em class="desc2"></em>');
	$("#rolling .pagination span:nth-child(3)").append('<em class="desc3"></em>');
	$("#rolling .pagination span:nth-child(4)").append('<em class="desc4"></em>');
	$("#rolling .pagination span:nth-child(5)").append('<em class="desc5"></em>');
	$("#rolling .pagination span:nth-child(6)").append('<em class="desc6"></em>');

	$("#rolling .pagination span em").hide();
	$("#rolling .pagination .swiper-active-switch em").show();

	setInterval(function() {
		$("#rolling .pagination span em").hide();
		$("#rolling .pagination .swiper-active-switch em").show();
	}, 500);
	$("#rolling .pagination span, .btnNavigation").click(function(){
		$("#rolling .pagination span em").hide();
		$("#rolling .pagination .swiper-active-switch em").show();
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
	$("#topic h2 span").css({"opacity":"0"});
	$("#topic h2 .letter1").css({"margin-top":"7px"});
	$("#topic h2 .letter2").css({"margin-top":"15px"});
	$("#topic h2 .letter3").css({"margin-top":"23px"});
	function titleAnimation() {
		$("#topic h2 .letter1").delay(300).animate({"margin-top":"0", "opacity":"1"},800);
		$("#topic h2 .letter2").delay(700).animate({"margin-top":"7px", "opacity":"1"},800);
		$("#topic h2 .letter3").delay(1100).animate({"margin-top":"17px", "opacity":"1"},800);
	}

	/* finish animation */
	function finishAnimation() {
		var window_top = $(window).scrollTop();
		var div_top = $("#finish").offset().top-200;
		if (window_top > div_top){
			$("#finish .letter1").addClass("move1");
			$("#finish .letter2").addClass("move2");
		} else {
			$("#finish .letter1").removeClass("move1");
			$("#finish .letter2").removeClass("move2");
		}
	}
	$(function() {$(window).scroll(finishAnimation);});
});
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->