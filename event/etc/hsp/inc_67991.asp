<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈 15
' History : 2015-12-08 이종화 생성
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
	eCode   =  65984
Else
	eCode   =  67991
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
	itemid   =  1405559
End If

dim oItem
set oItem = new CatePrdCls
	oItem.GetItemData itemid

Dim hspchk
'// 현재 주소값 체크하여 신규, 구버전 확인
hspchk = Split(LCase(Request.ServerVariables("PATH_INFO")),"/")

%>
<style type="text/css">
/* title */
.heySomething .topic {background-color:#f0f0f0; z-index:1;}

/* item */
.heySomething .itemA .figure {margin-top:55px;}
.heySomething .itemA #slide01 {width:480px; height:402px;}
.heySomething .itemA .with {border-bottom:0;}
.heySomething .itemA .with ul {width:1030px;}
.heySomething .itemA .with ul li {width:217px; padding:0 20px;}

/* visual */
.heySomething .visual .figure {background-color:#fff;}

/* brand */
.heySomething .brand {position:relative; height:1130px;}
.heySomething .brand .name {overflow:hidden; position:relative; width:362px; height:105px; margin:48px auto 110px;}
.heySomething .brand .name em {display:inline-block; position:absolute; left:214px; top:37px; z-index:20; width:1px; height:64px; background:#d9d9d9;}
.heySomething .brand .name span {display:inline-block; position:absolute; top:0; z-index:10;}
.heySomething .brand .name span.n01 {left:0;}
.heySomething .brand .name span.n02 {right:0;}
.heySomething .brand .info {position:relative; width:261px; height:350px; margin:0 auto;}
.heySomething .brand .info p {position:absolute;}
.heySomething .brand .info p.t01 {top:0; left:28px; width:194px; height:128px;}
.heySomething .brand .info p.t01 img {display:inline-block; position:absolute; left:50%; top:50%; width:100%;}
.heySomething .brand .info p.t02 {top:150px; left:0;}

/* story */
.heySomething .story {padding-top:0;}
.heySomething .story h3 {margin-bottom:52px;}
.heySomething .rolling {padding-top:204px;}
.heySomething .rolling .pagination {top:0; width:824px; margin-left:-412px;}
.heySomething .rolling .swiper-pagination-switch {width:150px; height:165px; margin:0 28px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/hey/67991/bg_ico.png);}
.heySomething .rolling .pagination span.swiper-active-switch {background-position:0 -165px;}
.heySomething .rolling .pagination span:first-child + span {background-position:-150px 0;}
.heySomething .rolling .pagination span:first-child + span.swiper-active-switch {background-position:-150px -165px;}
.heySomething .rolling .pagination span:first-child + span + span {background-position:-300px 0;}
.heySomething .rolling .pagination span:first-child + span + span.swiper-active-switch {background-position:-300px -165px;}
.heySomething .rolling .pagination span:first-child + span + span + span {background-position:-450px 0;}
.heySomething .rolling .pagination span:first-child + span + span + span.swiper-active-switch {background-position:-450px -165px;}
.heySomething .rolling .pagination span:first-child + span + span + span + span {background-position:-600px 0;}
.heySomething .rolling .pagination span:first-child + span + span + span + span.swiper-active-switch {background-position:-600px -165px;}
.heySomething .rolling .pagination span:first-child + span + span + span + span + span {background-position:-750px 0;}
.heySomething .rolling .pagination span:first-child + span + span + span + span + span.swiper-active-switch {background-position:-750px -165px;}
.heySomething .rolling .pagination span:first-child + span + span + span + span + span + span {background-position:100% 0;}
.heySomething .rolling .pagination span:first-child + span + span + span + span + span + span.swiper-active-switch {background-position:100% -165px;}
.heySomething .rolling .pagination span em {bottom:-800px; left:50%; margin-left:-490px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/hey/67991/txt_story_desc.png); cursor:default;}
.heySomething .rolling .btn-nav {top:488px;}
.heySomething .swipemask {top:205px;}

/* finish */
.heySomething .finish {background-color:#f3dfdb;}
.heySomething .finish .bg {position:absolute; top:0; left:0; z-index:5; width:100%; height:850px; background:transparent url(http://webimage.10x10.co.kr/eventIMG/2015/hey/67991/img_finish.jpg) no-repeat 50% 0;}

/* comment */
.heySomething .commentevet .form .choice li {height:165px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/hey/67991/bg_ico.png);}
.heySomething .commentevet .form .choice li.ico1 button {background-position:0 -330px;}
.heySomething .commentevet .form .choice li.ico1 button.on {background-position:0 100%;}
.heySomething .commentevet .form .choice li.ico2 button {background-position:-150px -330px;}
.heySomething .commentevet .form .choice li.ico2 button.on {background-position:-150px 100%;}
.heySomething .commentevet .form .choice li.ico3 button {background-position:-300px -330px;}
.heySomething .commentevet .form .choice li.ico3 button.on {background-position:-300px 100%;}
.heySomething .commentevet .form .choice li.ico4 button {background-position:-450px -330px;}
.heySomething .commentevet .form .choice li.ico4 button.on {background-position:-450px 100%;}
.heySomething .commentevet textarea {margin-top:20px;}

.heySomething .commentlist table td {padding:20px 0;}
.heySomething .commentlist table td strong {height:136px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/hey/67991/bg_ico.png);}
.heySomething .commentlist table td .ico1 {background-position:0 -352px;}
.heySomething .commentlist table td .ico2 {background-position:-150px -352px;}
.heySomething .commentlist table td .ico3 {background-position:-300px -352px;}
.heySomething .commentlist table td .ico4 {background-position:-450px -352px;}
.heySomething .commentlist table td .ico5 {background-position:-600px -352px;}
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
		<% If not( left(currenttime,10)>="2015-12-16" and left(currenttime,10)<"2015-12-24" ) Then %>
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
			<div class="bnr"><a href="/shopping/category_prd.asp?itemid=1405559&amp;pEtr=67991"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67991/img_item_represent.jpg" alt="Alice tea Party" /></a></div>
		</div>

		<%' about %>
		<div class="about">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
			<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
		</div>

		<%' item %>
		<div class="item itemA">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67991/tit_alice.png" alt="앨리스와 텐바이텐의 만남" /></h3>
			<%
			itemid = 1405559
			set oItem = new CatePrdCls
				oItem.GetItemData itemid
			%>
			<div class="desc">
				<div class="figure">
					<div id="slide01" class="slide">
						<a href="/shopping/category_prd.asp?itemid=1405559&amp;pEtr=67991"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67991/img_move_item_01.jpg" alt="앨리스 티팟" /></a>
						<a href="/shopping/category_prd.asp?itemid=1405559&amp;pEtr=67991"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67991/img_move_item_02.jpg" alt="" /></a>
						<a href="/shopping/category_prd.asp?itemid=1405559&amp;pEtr=67991"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67991/img_move_item_03.jpg" alt="" /></a>
						<a href="/shopping/category_prd.asp?itemid=1405559&amp;pEtr=67991"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67991/img_move_item_04.jpg" alt="" /></a>
					</div>
				</div>
				<div class="option">
					<em class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67991/txt_name.png" alt="[Disney] Alice Tea pot set" /></em>
					<% if oItem.FResultCount > 0 then %>
						<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
							<div class="price">
								<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/txt_only_<%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>percent.png" alt="단, 일주일만 ONLY <%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%" /></strong>
								<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
								<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
							</div>
						<% Else %>
							<%' for dev msg : 종료 후 %>
							<div class="price priceEnd">
								<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
							</div>
						<% End If %>
					<% end if %>
					<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67991/txt_substance.png" alt="앨리스와 함께하는 호기심 가득한 티타임" /></p>
					<div class="btnget"><a href="/shopping/category_prd.asp?itemid=1405559&amp;pEtr=67991"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="전기방석 구매하러 가기" /></a></div>
				</div>
			</div>
			<% set oItem=nothing %>
			
			<div class="with">
				<span><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/ico_plus.png" alt="" /></span>
				<ul>
					<li>
					<%
					itemid = 1405559
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
					%>
						<a href="/shopping/category_prd.asp?itemid=1405559&amp;pEtr=67991">
							<img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67991/img_item_01.jpg" alt="" />
							<span>Alice Tea pot set</span>
							<% if oItem.FResultCount > 0 then %>
								<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> <em class="cRd0V15">[<%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%]</em></strong>
								<% Else %>
									<%' for dev msg : 종료 후 %>
									<div class="price priceEnd">
										<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
									</div>
								<% End If %>
							<% end if %>
						</a>
					</li>
					<% set oItem=nothing %>

					<li>
					<%
					itemid = 1405564
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
					%>
						<a href="/shopping/category_prd.asp?itemid=1405564&amp;pEtr=67991">
							<img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67991/img_item_02.jpg" alt="" />
							<span>Alice Spoon & Fork set</span>
							<% if oItem.FResultCount > 0 then %>
								<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> <em class="cRd0V15">[<%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%]</em></strong>
								<% Else %>
									<%' for dev msg : 종료 후 %>
									<div class="price priceEnd">
										<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
									</div>
								<% End If %>
							<% end if %>
						</a>
					</li>
					<% set oItem=nothing %>

					<li>
					<%
					itemid = 1407890
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
					%>
						<a href="/shopping/category_prd.asp?itemid=1407890&amp;pEtr=67991">
							<img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67991/img_item_03.jpg" alt="" />
							<span>Alice Kitchen Towel</span>
							<% if oItem.FResultCount > 0 then %>
								<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> <em class="cRd0V15">[<%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%]</em></strong>
								<% Else %>
									<%' for dev msg : 종료 후 %>
									<div class="price priceEnd">
										<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
									</div>
								<% End If %>
							<% end if %>
						</a>
					</li>
					<% set oItem=nothing %>

					<li>
					<%
					itemid = 1407891
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
					%>
						<a href="/shopping/category_prd.asp?itemid=1407891&amp;pEtr=67991">
							<img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67991/img_item_04.jpg" alt="" />
							<span>Alice Tea Cozy</span>
							<% if oItem.FResultCount > 0 then %>
								<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> <em class="cRd0V15">[<%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%]</em></strong>
								<% Else %>
									<%' for dev msg : 종료 후 %>
									<div class="price priceEnd">
										<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
									</div>
								<% End If %>
							<% end if %>
						</a>
					</li>
					<% set oItem=nothing %>
				</ul>
			</div>
		</div>

		<%' visual %>
		<div class="visual">
			<div class="figure"><a href="/shopping/category_prd.asp?itemid=1405559&amp;pEtr=67991"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67991/img_item_visual_big.jpg" alt="" /></a></div>
		</div>

		<%' brand %>
		<div class="brand">
			<div class="pic"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67991/img_character.png" alt="" /></div>
			<p class="name">
				<span class="n01"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67991/logo_alice.png" alt="" /></span>
				<span class="n02"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67991/logo_10x10.png" alt="" /></span>
				<em></em>
			</p>
			<div class="info">
				<p class="t01"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67991/txt_brand_01.png" alt="" /></p>
				<p class="t02"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67991/txt_brand_02.png" alt="나른한 여름 오후, 언니가 읽어주는 역사 얘기를 들으며 졸고 있던 꼬마 소녀 앨리스는 하얀 토끼가 뛰어가는 걸 보고 뒤를 쫓아간다. 토끼굴 아래로 굴러 떨어진 주인공 앨리스가 이상한 약을 마시고 몸이 줄어들거나 커지기를 반복하면서 땅속 나라 “Wonderland”의 모험이 펼쳐진다." /></p>
			</div>
			<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="" /></div>
		</div>

		<%' story %>
		<div class="story">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67991/txt_story.png" alt="앨리스와 함께하는 호기심 가득한 Tea Time" /></h3>
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
									<a href="/shopping/category_prd.asp?itemid=1405559&amp;pEtr=67991"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67991/img_slide_01.jpg" alt="성냥과 마찰을 일으켜 불을 켜는 적린 match striker은 수성용액을 최적으로 배합하여 너무 쉽게 불이 붙지 않도록 안전성을 확보하였습니다." /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1405559&amp;pEtr=67991"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67991/img_slide_02.jpg" alt="너무 높지 않은 8cm의 스틱 캔들은 모든 케익에 가장 적합한 높이와 크기이며 11개로 구성 되어 있습니다." /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1405559&amp;pEtr=67991"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67991/img_slide_03.jpg" alt="함께 구성 되어 있는 메시지 카드에 따뜻한 마음을 담아 전해보세요." /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1405559&amp;pEtr=67991"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67991/img_slide_04.jpg" alt="겨울 느낌이 물씬 나는 일러스트와  고급스런 금속 핀으로 고정 된 종이 봉투 포장으로 선물하기에도 좋습니다." /></a>
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
			<a href="/shopping/category_prd.asp?itemid=1405559&amp;pEtr=67991">
				<div class="bg"></div>
			</a>
		</div>

		<%' comment %>
		<div class="commentevet" id="commentlist">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67991/tit_comment.png" alt="Hey, something project 당신이 갖고 싶은 것" /></h3>
			<p class="hidden">정성껏 코멘트를 남겨주신 3분을 추첨하여 Alice Tea pot set를 선물로 드립니다. 기간:2015.12.16~12.23/발표:12.24</p>
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
							<li class="ico1"><button type="button" value="1">PARTY</button></li>
							<li class="ico2"><button type="button" value="2">TALK</button></li>
							<li class="ico3"><button type="button" value="3">GAME</button></li>
							<li class="ico4"><button type="button" value="4">HEALING</button></li>
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
												PARTY
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="2" then %>
												TALK
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="3" then %>
												GAME
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="4" then %>
												HEALING
											<% Else %>
												PARTY
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
<% End If %>
<script type="text/javascript" src="/lib/js/jquery.flowslider.js"></script>
<script type="text/javascript">
$(function(){
	/* swipe */
	var swiper1 = new Swiper('.swiper1',{
		centeredSlides:true,
		slidesPerView:"auto",
		loop: true,
		speed:1500,
		autoplay:5000,
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

	$("#slide01").slidesjs({
		width:"480",
		height:"402",
		pagination:false,
		navigation:false,
		play:{interval:600, effect:"fade", auto:true},
		effect:{fade: {speed:1000, crossfade:true}
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

	var conChk = 0;
	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 3750 ) {
			if (conChk==0){
				brandAnimation()
			}
		}
	});

	titleAnimation()
	$(".heySomething .topic h2 span").css({"opacity":"0"});
	$(".heySomething .topic h2 .letter1").css({"margin-top":"7px"});
	$(".heySomething .topic h2 .letter2").css({"margin-top":"15px"});
	$(".heySomething .topic h2 .letter3").css({"margin-top":"23px"});
	function titleAnimation() {
		$(".heySomething .topic h2 .letter1").delay(400).animate({"margin-top":"0", "opacity":"1"},800);
		$(".heySomething .topic h2 .letter2").delay(800).animate({"margin-top":"7px", "opacity":"1"},800);
		$(".heySomething .topic h2 .letter3").delay(1200).animate({"margin-top":"17px", "opacity":"1"},800);
	}

	$(".heySomething .brand .pic").css({"margin-left":"10px","opacity":"0"});
	$(".heySomething .brand .name .n01").css({"left":"200px","opacity":"0"});
	$(".heySomething .brand .name .n02").css({"right":"200px","opacity":"0"});
	$(".heySomething .brand .name em").css({"top":"70px","height":"0"});
	$(".heySomething .brand .t01 img").css({"width":"0"});
	$(".heySomething .brand .t02").css({"margin-top":"10px" ,"opacity":"0"});
	$(".heySomething .brand .btnDown").css({"opacity":"0"});
	function brandAnimation() {
		conChk = 1;
		$(".heySomething .brand .pic").animate({"margin-left":"0","opacity":"1"},1000);
		$(".heySomething .brand .n01").delay(900).animate({"left":"0","opacity":"1"},1000);
		$(".heySomething .brand .n02").delay(900).animate({"right":"0","opacity":"1"},1000);
		$(".heySomething .brand .name em").delay(1500).animate({"top":"37px","height":"64px"},900);
		$(".heySomething .brand .t01 img").delay(2200).animate({"width":"105%","margin-top":"-33%" ,"margin-left":"-52.5%"},600).animate({"width":"100%","margin-left":"-50%"},300);
		$(".heySomething .brand .t02").delay(3000).animate({"margin-top":"0","opacity":"1"},1000);
		$(".heySomething .brand .btnDown").delay(4000).animate({"margin-top":"62px", "opacity":"1"},1000);
	}
});
</script>
<%
set oItem=nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->