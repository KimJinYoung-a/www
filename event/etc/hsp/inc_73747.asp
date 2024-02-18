<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈
' History : 2016-10-25 이종화 생성
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
	eCode   =  66220
Else
	eCode   =  73747
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
.heySomething .topic {background-color:#fbd1b9; z-index:1;}
.heySomething .topic h2 span {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_hey_something_project_white.png);}

/* item */
.heySomething .item h3 {padding-bottom:92px;}
.heySomething .item .option .substance {position:static; padding:55px 0 80px;}
.heySomething .item .option .btnget {position:static;}
.heySomething .itemA {margin-top:300px;}
.heySomething .itemA .figure {left:582px; top:0;}
.heySomething .itemA .desc { min-height:600px; padding-top:5px;}
.heySomething .itemA .desc .option {width:auto;}
.heySomething .itemA .with ul li {width:155px; padding:0 25px;}
.heySomething .itemC {margin-top:360px;}
.heySomething .itemC ul {position:relative; width:1140px; height:680px; margin:0 auto;}
.heySomething .itemC li {position:absolute;}
.heySomething .itemC li span {display:none; position:absolute; left:0; top:0;}
.heySomething .itemC li a:hover span {display:block;}
.heySomething .itemC li.item01 {left:0; top:0;}
.heySomething .itemC li.item02 {left:232px; top:0;}
.heySomething .itemC li.item03 {left:462px; top:0;}
.heySomething .itemC li.item04 {right:0; top:0;}
.heySomething .itemC li.item05 {left:0; top:232px;}
.heySomething .itemC li.item06 {left:232px; top:232px;}
.heySomething .itemC li.item07 {left:462px; top:232px;}
.heySomething .itemC li.item08 {left:0; bottom:0;}
.heySomething .itemC li.item09 {left:462px; bottom:0;}
.heySomething .itemC li.item10 {right:0; bottom:0;}

/* brand */
.heySomething .brand {position:relative; height:1295px; margin-top:360px;}
.heySomething .brand .text {padding:95px 0 30px;}
.heySomething .note {height:832px; margin-top:300px; background:#fef0b1 url(http://webimage.10x10.co.kr/eventIMG/2016/hey/73747/img_with.jpg) 50% 0 no-repeat;}

/* story */
.heySomething .story {margin-top:300px; padding-bottom:120px;}
.heySomething .story h3 {margin-bottom:65px;}
.heySomething .rolling {padding-top:200px;}
.heySomething .rolling .swiper-pagination-switch {width:150px; height:160px; margin:0 15px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/73747/bg_ico_01.jpg);}
.heySomething .rolling .pagination {top:0; padding-left:130px;}
.heySomething .rolling .pagination span em {bottom:-790px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/73747/txt_story_desc.png); cursor:default;}
.heySomething .rolling .pagination span:first-child {background-position:0 0;}
.heySomething .rolling .pagination span.swiper-active-switch {background-position:0 -160px;}
.heySomething .rolling .pagination span:first-child + span {background-position:-150px 0;}
.heySomething .rolling .pagination span:first-child + span.swiper-active-switch {background-position:-150px -160px;}
.heySomething .rolling .pagination span:first-child + span + span {background-position:-300px 0;}
.heySomething .rolling .pagination span:first-child + span + span.swiper-active-switch {background-position:-300px -160px;}
.heySomething .rolling .pagination span:first-child + span + span + span {background-position:-450px 0;}
.heySomething .rolling .pagination span:first-child + span + span + span.swiper-active-switch {background-position:-450px -160px;}
.heySomething .rolling .pagination span:first-child + span + span + span + span {background-position:-600px 0;}
.heySomething .rolling .pagination span:first-child + span + span + span + span.swiper-active-switch {background-position:-600px -160px;}
.heySomething .rolling .btn-nav {top:482px;}
.heySomething .swipemask {top:200px;}

/* finish */
.heySomething .finish {height:734px; margin-top:300px; background:#9ebbe5 url(http://webimage.10x10.co.kr/eventIMG/2016/hey/73747/img_finish.jpg) 50% 0 no-repeat; text-indent:-999em;}

/* comment */
.heySomething .commentevet {margin-top:230px;}
.heySomething .commentevet textarea {margin-top:40px;}
.heySomething .commentevet .form {margin-top:45px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/73747/bg_ico_02.jpg);}
.heySomething .commentlist table td {padding:15px 0;}
.heySomething .commentlist table td strong {width:160px; height:132px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/73747/bg_ico_01.jpg); background-position:0 -160px;}
.heySomething .commentlist table td .ico2 {background-position:-150px -160px;}
.heySomething .commentlist table td .ico3 {background-position:-300px -160px;}
.heySomething .commentlist table td .ico4 {background-position:-450px -160px;}
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
		<% If not( left(currenttime,10)>="2016-10-26" and left(currenttime,10)<"2016-11-02" ) Then %>
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
			<div class="bnr"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73747/img_item_represent.jpg" alt="MARKS X PAUL &amp; JOE _ La Papeterie" /></div>
		</div>

		<%' about %>
		<div class="about">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
			<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
		</div>

		<%' item %>
		<div class="item itemA">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73747/txt_paul_n_joe.png" alt="Paul &amp; Joe La Papeterie" /></h3>
			<%' for dev msg : 상품코드 1544319, 할인기간 8/24 ~ 8/30 할인기간이 지나면  <strong class="discount">...</strong> 숨겨주세요 %>
			<%
				IF application("Svr_Info") = "Dev" THEN
					itemid = 1239226
				Else
					itemid = 1572519
				End If
				set oItem = new CatePrdCls
					oItem.GetItemData itemid
			%>
			<div class="desc">
				<div class="option">
					<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73747/txt_name.png" alt="[Mark's X Paul &amp; Joe] " /></p>
			<% If oItem.FResultCount > 0 Then %>
				<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
					<div class="price">
					<% If not( left(currenttime,10)>="2016-10-26" and left(currenttime,10)<="2016-11-01" ) Then %>
					<% Else %>
						<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/txt_only_10percent.png" alt="단, 일주일만 10%" /></strong>
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
					<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73747/txt_substance.png" alt="PAUL&amp;JO의 설립 20년 기념 첫 콜라보 스테이셔너리 라인(Stationery Line) PAUL&amp;JOE La Papeterie 간직하고픈 일러스트와 패셔너블한 디자인 문구를 만나보세요" /></p>
					<div class="btnget"><a href="/shopping/category_prd.asp?itemid=1572519&amp;pEtr=73747"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러 가기" /></a></div>
				</div>
				<div class="figure"><a href="/shopping/category_prd.asp?itemid=1572519&amp;pEtr=73747"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73747/img_note.jpg" alt="" /></a></div>
			<%	set oItem = nothing %>
			</div>
			<div class="with">
				<span><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/ico_plus.png" alt=""></span>
				<ul>
				<%
					IF application("Svr_Info") = "Dev" THEN
						itemid = 786868
					Else
						itemid = 1572512
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
				%>
					<li>
						<a href="/shopping/category_prd.asp?itemid=1572512&amp;pEtr=73747">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73747/img_with_item_01.jpg" alt="" />
							<span>Ballpoint pen</span>
					<% if oItem.FResultCount > 0 then %>
						<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
							<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> [<%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%]</strong>
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
						itemid = 1572540
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
				%>
					<li>
						<a href="/shopping/category_prd.asp?itemid=1572540&amp;pEtr=73747">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73747/img_with_item_02.jpg" alt="" />
							<span>Stationery case</span>
					<% if oItem.FResultCount > 0 then %>
						<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
							<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> [<%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%]</strong>
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
						itemid = 1572526
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
				%>
					<li>
						<a href="/shopping/category_prd.asp?itemid=1572526&amp;pEtr=73747">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73747/img_with_item_03.jpg" alt="" />
							<span>A6 Notebook</span>
					<% if oItem.FResultCount > 0 then %>
						<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
							<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> [<%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%]</strong>
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
						itemid = 1572518
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
				%>
					<li>
						<a href="/shopping/category_prd.asp?itemid=1572518&amp;pEtr=73747">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73747/img_with_item_04.jpg" alt="" />
							<span>Pen case</span>
					<% if oItem.FResultCount > 0 then %>
						<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
							<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> [<%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%]</strong>
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
						itemid = 1572541
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
				%>
					<li>
						<a href="/shopping/category_prd.asp?itemid=1572541&amp;pEtr=73747">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73747/img_with_item_05.jpg" alt="" />
							<span>Sticky notes set</span>
					<% if oItem.FResultCount > 0 then %>
						<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
							<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> [<%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%]</strong>
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

		<div class="item itemC">
			<ul>
				<li class="item01"><a href="/shopping/category_prd.asp?itemid=1572526&amp;pEtr=73747"><span><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73747/txt_item_01.jpg" alt="A6 Notebook" /></span><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73747/img_item_01.jpg" alt="" /></a></li>
				<li class="item02"><a href="/shopping/category_prd.asp?itemid=1572540&amp;pEtr=73747"><span><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73747/txt_item_02.jpg" alt="Stationery case" /></span><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73747/img_item_02.jpg" alt="" /></a></li>
				<li class="item03"><a href="/shopping/category_prd.asp?itemid=1572549&amp;pEtr=73747"><span><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73747/txt_item_03.jpg" alt="Message card" /></span><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73747/img_item_03.jpg" alt="" /></a></li>
				<li class="item04"><a href="/shopping/category_prd.asp?itemid=1572512&amp;pEtr=73747"><span><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73747/txt_item_04.jpg" alt="Ballpoint pen" /></span><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73747/img_item_04.jpg" alt="" /></a></li>
				<li class="item05"><a href="/shopping/category_prd.asp?itemid=1572541&amp;pEtr=73747"><span><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73747/txt_item_05.jpg" alt="Sticky notes set" /></span><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73747/img_item_05.jpg" alt="" /></a></li>
				<li class="item06"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73747/img_item_06.jpg" alt="" /></li>
				<li class="item07"><a href="/shopping/category_prd.asp?itemid=1572518&amp;pEtr=73747"><span><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73747/txt_item_07.jpg" alt="Pen case" /></span><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73747/img_item_07.jpg" alt="" /></a></li>
				<li class="item08"><a href="/shopping/category_prd.asp?itemid=1572557&amp;pEtr=73747"><span><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73747/txt_item_08.jpg" alt="Letter set" /></span><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73747/img_item_08.jpg" alt="" /></a></li>
				<li class="item09"><a href="/shopping/category_prd.asp?itemid=1572511&amp;pEtr=73747"><span><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73747/txt_item_09.jpg" alt="Masking tape 2set" /></span><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73747/img_item_09.jpg" alt="" /></a></li>
				<li class="item10"><a href="/shopping/category_prd.asp?itemid=1572519&amp;pEtr=73747"><span><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73747/txt_item_10.jpg" alt="A5 Notebook" /></span><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73747/img_item_10.jpg" alt="" /></a></li>
			</ul>
		</div>

		<%' brand %>
		<div class="brand">
			<div class="pic"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73747/img_brand.jpg" alt="" /></div>
			<p class="text"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73747/txt_brand.png" alt="전 세계에서 사랑받는 프랑스 디자이너 브랜드 'PAUL&JOE'-설립 20주년을 맞이하여 일본 디자인 문구 브랜드 “mark’s”와 콜라보한 스테이셔너리 라인(Stationery Line) [PAUL&JOE La Papeterie] 'La Papeterie'은 프랑스어로 “문구, 문구점”을 의미합니다.mark’s X PAUL&JOE는 패셔너블한 디자인과높은 품질의 문구를 제공합니다." /></p>
			<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="" /></div>
		</div>
		<div class="note"></div>

		<%' story %>
		<div class="story">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73747/tit_story.png" alt="떠오르는 그 마음, 적어보세요." /></h3>
			<div class="rollingwrap">
				<div class="rolling rolling1">
					<div class="swipemask mask-left"></div>
					<div class="swipemask mask-right"></div>
					<button type="button" class="btn-nav arrow-left">Previous</button>
					<button type="button" class="btn-nav arrow-right">Next</button>
					<div class="swiper">
						<div class="swiper-container swiper1">
							<div class="swiper-wrapper">
								<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73747/img_slide_01.jpg" alt="더 늦기 전에 감사함을 전해주세요." /></div>
								<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73747/img_slide_02.jpg" alt="나와 내 주변을 따뜻함으로 채워주세요." /></div>
								<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73747/img_slide_03.jpg" alt="소중한 지금 이 감정을 남겨주세요" /></div>
								<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73747/img_slide_04.jpg" alt="기억할 수 밖에 없는 감성적인 일러스트" /></div>
							</div>
						</div>
					</div>
					<div class="pagination"></div>
				</div>
			</div>
		</div>

		<%' finish %>
		<div class="finish">
			<div>간직하고 싶은 문구 MARKS X PAUL &amp; JOE La Papeterie</div>
		</div>
		
		<%' comment %>
		<div class="commentevet">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73747/tit_comment.png" alt="Hey, something project 올 해가 가기 전에.." /></h3>
			<p class="hidden">올 한 해가 가지 전에 전하고 싶은 마음을 적어주세요! 정성껏 코멘트를 남겨주신 3분을 추첨하여 Sticky notes set를 드립니다(랜덤 증정)</p>
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
							<li class="ico1"><button type="button" value="1">#마음을 전하다</button></li>
							<li class="ico2"><button type="button" value="2">#마음을 담다</button></li>
							<li class="ico3"><button type="button" value="3">#마음을 남기다</button></li>
							<li class="ico4"><button type="button" value="4">#마음을 기억하다</button></li>
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
												#마음을 전하다
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="2" then %>
												#마음을 담다
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="3" then %>
												#마음을 남기다
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="4" then %>
												#마음을 기억하다
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
	/* swipe */
	var swiper1 = new Swiper('.swiper1',{
		centeredSlides:true,
		slidesPerView:"auto",
		loop: true,
		speed:1500,
		autoplay:3000,
		simulateTouch:false,
		pagination: '.rolling1 .pagination',
		paginationClickable: true
	});
	$('.rolling1 .arrow-left').on('click', function(e){
		e.preventDefault()
		swiper1.swipePrev()
	});
	$('.rolling1 .arrow-right').on('click', function(e){
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

	/* animation effect */
	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 2300 ) {
			itemAnimation()
		}
	});

	/* title animation */
	titleAnimation()
	$(".heySomething .topic h2 span").css({"opacity":"0"});
	$(".heySomething .topic h2 .letter1").css({"margin-top":"7px"});
	$(".heySomething .topic h2 .letter2").css({"margin-top":"15px"});
	$(".heySomething .topic h2 .letter3").css({"margin-top":"23px"});
	function titleAnimation() {
		$(".heySomething .topic h2 .letter1").delay(300).animate({"margin-top":"0", "opacity":"1"},800);
		$(".heySomething .topic h2 .letter2").delay(700).animate({"margin-top":"7px", "opacity":"1"},800);
		$(".heySomething .topic h2 .letter3").delay(1100).animate({"margin-top":"17px", "opacity":"1"},800);
	}

	/* item animation */
	$(".heySomething .itemC li").css({"margin-top":"10px","opacity":"0"});
	function itemAnimation() {
		$(".heySomething .itemC li.item01").delay(800).animate({"margin-top":"0", "opacity":"1"},400);
		$(".heySomething .itemC li.item02").delay(300).animate({"margin-top":"0", "opacity":"1"},400);
		$(".heySomething .itemC li.item03").delay(700).animate({"margin-top":"0", "opacity":"1"},400);
		$(".heySomething .itemC li.item04").delay(600).animate({"margin-top":"0", "opacity":"1"},400);
		$(".heySomething .itemC li.item05").delay(900).animate({"margin-top":"0", "opacity":"1"},400);
		$(".heySomething .itemC li.item06").animate({"margin-top":"0", "opacity":"1"},400);
		$(".heySomething .itemC li.item07").delay(300).animate({"margin-top":"0", "opacity":"1"},400);
		$(".heySomething .itemC li.item08").delay(1000).animate({"margin-top":"0", "opacity":"1"},400);
		$(".heySomething .itemC li.item09").delay(500).animate({"margin-top":"0", "opacity":"1"},400);
		$(".heySomething .itemC li.item10").delay(700).animate({"margin-top":"0", "opacity":"1"},400);
	}
});
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->