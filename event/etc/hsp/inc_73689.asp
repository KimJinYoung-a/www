<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈
' History : 2016-10-18 이종화 생성
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
	eCode   =  73689
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
.heySomething .topic {background-color:#debeb1;}
.heySomething .topic h2 {z-index:5;}
.heySomething .topic .figure a {display:block; position:relative; width:100%; height:778px;}
.heySomething .topic .figure img {position:absolute; top:0; left:50%; margin-left:-951px;}

/* intro */
.heySomething .intro {margin-top:305px;}
.heySomething .intro .photo {overflow:hidden; width:1140px; height:686px; margin:0 auto;}
@keyframes pulse {
	0% {transform:scale(1.2);}
	100% {transform:scale(1);}
}
.pulse {animation-name:pulse; animation-duration:1.5s; animation-iteration-count:1;}

/* item */
.heySomething .itemB {width:1140px; margin:405px auto 0; padding-bottom:0; background:none; border-bottom:1px solid #ddd;}
.heySomething .item h3 {position:relative; height:86px;}
.heySomething .item h3 .disney {position:absolute; top:0; left:393px; z-index:5; background-color:#fff;}
.heySomething .item h3 .tenten {position:absolute; top:39px; left:621px; z-index:5; background-color:#fff;}
.heySomething .item h3 .verticalLine {position:absolute; top:25px; left:569px; width:1px; height:64px; background-color:#d9d9d9;}
.heySomething .item h3 .horizontalLine1, .heySomething .item h3 .horizontalLine2 {position:absolute; top:56px; width:305px; height:1px; background-color:#d9d9d9;}
.heySomething .item h3 .horizontalLine1 {left:0;}
.heySomething .item h3 .horizontalLine2 {right:0;}
.heySomething .item .desc {min-height:530px; margin-top:70px;}
.heySomething .itemB .desc .option {top:20px; left:85px; height:435px;}
.heySomething .item .option .price {margin-top:18px;}
.heySomething .item .option .substance {bottom:62px;}
.heySomething .itemB .slidewrap .slide {position:relative; width:666px; text-align:center;}
.heySomething .itemB .slidewrap .slide .slidesjs-previous {left:0;}
.heySomething .item .with {margin-top:0; border:none;}
.heySomething .item .with span {position:relative; z-index:5;}
.heySomething .item .with {padding-bottom:42px; text-align:center;}
.heySomething .item .with ul {overflow:hidden; width:1000px; margin:40px auto 0;}
.heySomething .item .with ul li {float:left; width:174px; margin:0 13px;}
.heySomething .item .with ul li a {display:block; color:#777; font-size:11px;}
.heySomething .item .with ul li span {display:block; margin-top:10px;}

/* visual */
.heySomething .visual {position:relative; margin-top:315px; text-align:center;}

/* brand */
.heySomething .brand {width:1140px; height:1010px; margin:380px auto 0;}

/* story */
.heySomething .story {margin-top:420px; padding-bottom:120px;}
.heySomething .rolling {padding-top:218px;}
.heySomething .rolling .pagination {top:0; width:892px; margin-left:-446px;}
.heySomething .rolling .swiper-pagination-switch {width:153px; height:184px; margin:0 35px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/73689/btn_pagination_story.png);}
.heySomething .rolling .pagination span.swiper-active-switch {background-position:0 100%;}
.heySomething .rolling .pagination span:first-child + span {background-position:-221px 0;}
.heySomething .rolling .pagination span:first-child + span.swiper-active-switch {background-position:-221px 100%;}
.heySomething .rolling .pagination span:first-child + span + span {background-position:-440px 0;}
.heySomething .rolling .pagination span:first-child + span + span.swiper-active-switch {background-position:-440px 100%;}
.heySomething .rolling .pagination span:first-child + span + span + span {background-position:100% 0;}
.heySomething .rolling .pagination span:first-child + span + span + span.swiper-active-switch {background-position:100% 100%;}
.heySomething .rolling .pagination span em {bottom:-784px; left:50%;height:120px; width:980px; margin-left:-490px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/73689/txt_story_desc.png); cursor:default;}
.heySomething .rolling .pagination span .desc2 {background-position:0 -120px;}
.heySomething .rolling .pagination span .desc3 {background-position:0 -240px;}
.heySomething .rolling .pagination span .desc4 {background-position:0 -360px;}
.heySomething .rolling .pagination span .desc5 {background-position:0 100%;}
.heySomething .rolling .btn-nav {top:490px;}
.heySomething .swipemask {top:218px;}

/* finish */
.heySomething .finish {background-color:#181814; height:813px; margin-top:400px;}
.heySomething .finish .figure {position:absolute; top:0; left:50%; margin-left:-951px;}
.heySomething .finish p {top:246px; margin-left:-542px;}

/* comment */
.heySomething .commentevet {margin-top:330px;}
.heySomething .commentevet .form {margin-top:30px;}
.heySomething .commentevet .form .choice li {width:124px; height:149px; margin-right:21px;}
.heySomething .commentevet .form .choice li.ico1 {margin-right:15px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/73689/img_ico.png); background-position:0 0;}
.heySomething .commentevet .form .choice li button.on {background-position:0 100%;}
.heySomething .commentevet .form .choice li.ico2 button {background-position:-145px 0;}
.heySomething .commentevet .form .choice li.ico2 button.on {background-position:-145px 100%;}
.heySomething .commentevet .form .choice li.ico3 button {background-position:-289px 0;}
.heySomething .commentevet .form .choice li.ico3 button.on {background-position:-289px 100%;}
.heySomething .commentevet .form .choice li.ico4 button {background-position:100% 0;}
.heySomething .commentevet .form .choice li.ico4 button.on {background-position:100% 100%;}

.heySomething .commentevet textarea {margin-top:27px;}

.heySomething .commentlist table td strong {width:124px; height:149px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/73689/img_ico.png); background-position:0 0;}
.heySomething .commentlist table td strong.ico2 {background-position:-145px 0;}
.heySomething .commentlist table td strong.ico3 {background-position:-289px 0;}
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
		<% If not( left(currenttime,10)>="2016-10-19" and left(currenttime,10)<"2016-10-26" ) Then %>
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
				<a href="/shopping/category_prd.asp?itemid=1566125&pEtr=73689"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73689/img_item_represent.jpg" alt="Disney Alice Scratch Book" /></a>
			</div>
		</div>

		<%' about %>
		<div class="about">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
			<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
		</div>

		<%' intro %>
		<div id="intro" class="intro">
			<div class="photo"><a href="/shopping/category_prd.asp?itemid=1566125&pEtr=73689"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73689/img_alice_scratch_book.jpg" alt="" /></a></div>
		</div>

		<%' item %>
		<div class="item itemB">
			<div class="bg"></div>
			<div class="inner">
				<h3>
					<span class="disney"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73689/img_logo_disney.png" alt="디즈니" /></span>
					<span class="tenten"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73689/img_logo_tenten.png" alt="텐바이텐" /></span>
					<span class="verticalLine"></span>
					<span class="horizontalLine1"></span>
					<span class="horizontalLine2"></span>
				</h3>
				<%
					itemid = 1566125
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
				%>
				<div class="desc">
					<a href="/shopping/category_prd.asp?itemid=1566125&pEtr=73689">
						<div class="option">
							<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73689/txt_name.png" alt="Disney Alice Scratch Book은 텐바이텐 단독 제작 상품으로 가로 20센치, 세로 25.8센치며, 일러스트 4장과 무지 4장으로 구성되어 있습니다." /></p>
							<% If oItem.FResultCount > 0 Then %>
								<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
									<div class="price">
									<% If not( left(currenttime,10)>="2016-10-19" and left(currenttime,10)<="2016-10-25" ) Then %>
									<% Else %>
										<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/txt_only_10percent.png" alt="단 일주일만 only 10%" /></strong>
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
							<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73689/txt_substance.png" alt="반짝이는 순간, 시작되는 모험 Alice in onderland 스크래치북! 앨리스 일러스트 페이지 4장과 자신만의 일러스트와 메세지를 적을 수 있는 4장의 무지 페이지로 구성되어 있습니다." /></p>
							<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="Disney Alice Scratch Book 구매하러 가기" /></div>
						</div>
						<%' slide %>
						<div class="slidewrap">
							<div id="slide" class="slide">
								<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73689/img_slide_item_01_v1.jpg" alt="앨리스" /></div>
								<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73689/img_slide_item_02.jpg" alt="모자장수" /></div>
								<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73689/img_slide_item_03.jpg" alt="붉은 여왕" /></div>
								<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73689/img_slide_item_04.jpg" alt="시계토끼" /></div>
							</div>
						</div>
					</a>
				</div>
				<% set oItem=nothing %>
				<div class="with">
					<span><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/ico_plus.png" alt="" /></span>
					<ul>
						<%
							itemid = 1335553
							set oItem = new CatePrdCls
								oItem.GetItemData itemid
						%>
						<li>
							<a href="/shopping/category_prd.asp?itemid=1335553&pEtr=73689">
								<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73689/img_with_item_01.jpg" alt="" />
								<span>스크래치 전용펜</span>
								<% if oItem.FResultCount > 0 then %>
									<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
									<div><s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s> <b><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></b> <b class="cRd0V15">[<%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%]</b></div>
									<% Else %>
									<div><b><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></b></div>
									<% End If %>
								<% End If %>
							</a>
						</li>
						<% set oItem=nothing %>
						<%
							itemid = 1543210
							set oItem = new CatePrdCls
								oItem.GetItemData itemid
						%>
						<li>
							<a href="/shopping/category_prd.asp?itemid=1543210&pEtr=73689">
								<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73689/img_with_item_02.jpg" alt="" />
								<span>Holgram Post Card</span>
								<% if oItem.FResultCount > 0 then %>
									<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
									<div><s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s> <b><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></b> <b class="cRd0V15">[<%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%]</b></div>
									<% Else %>
									<div><b><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></b></div>
									<% End If %>
								<% End If %>
							</a>
						</li>
						<% set oItem=nothing %>
						<%
							itemid = 1509349
							set oItem = new CatePrdCls
								oItem.GetItemData itemid
						%>
						<li>
							<a href="/shopping/category_prd.asp?itemid=1509349&pEtr=73689">
								<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73689/img_with_item_03.jpg" alt="" />
								<span>Alice in Wonderland_Note</span>
								<% if oItem.FResultCount > 0 then %>
									<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
									<div><s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s> <b><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></b> <b class="cRd0V15">[<%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%]</b></div>
									<% Else %>
									<div><b><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></b></div>
									<% End If %>
								<% End If %>
							</a>
						</li>
						<% set oItem=nothing %>
						<%
							itemid = 1413577
							set oItem = new CatePrdCls
								oItem.GetItemData itemid
						%>
						<li>
							<a href="/shopping/category_prd.asp?itemid=1413577&pEtr=73689">
								<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73689/img_with_item_04.jpg" alt="" />
								<span>Alice_Playing Cards</span>
								<% if oItem.FResultCount > 0 then %>
									<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
									<div><s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s> <b><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></b> <b class="cRd0V15">[<%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%]</b></div>
									<% Else %>
									<div><b><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></b></div>
									<% End If %>
								<% End If %>
							</a>
						</li>
						<% set oItem=nothing %>
						<%
							itemid = 1542686
							set oItem = new CatePrdCls
								oItem.GetItemData itemid
						%>
						<li>
							<a href="/shopping/category_prd.asp?itemid=1542686&pEtr=73689">
								<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73689/img_with_item_05.jpg" alt="" />
								<span>Holgram Note</span>
								<% if oItem.FResultCount > 0 then %>
									<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
									<div><s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s> <b><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></b> <b class="cRd0V15">[<%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%]</b></div>
									<% Else %>
									<div><b><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></b></div>
									<% End If %>
								<% End If %>
							</a>
						</li>
						<% set oItem=nothing %>
					</ul>
				</div>
			</div>
		</div>

		<%' visual %>
		<div class="visual">
			<a href="/shopping/category_prd.asp?itemid=1566125&pEtr=73689"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73689/img_visual_ani_v1.gif" alt="Disney Alice Scratch Book" /></a>
		</div>

		<%' brand %>
		<div id="brand" class="brand">
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73689/txt_brand.jpg" alt="나른한 여름 오후, 언니가 읽어주는 역사 얘기를 들으며 졸고 있던 꼬마 소녀 앨리스는 하얀 토끼가 뛰어가는 걸 보고 뒤를 쫓아간다. 토끼굴 아래로 굴러 떨어진 주인공 앨리스가 이상한 약을 마시고 몸이 줄어들거나 커지기를 반복하면서 땅속나라 Wonderland의 모험이 펼쳐진다." /></p>
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
									<a href="/shopping/category_prd.asp?itemid=1566125&pEtr=73689" title="Disney Alice Scratch Book 보러가기"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73689/img_slide_story_01.jpg" alt="#Party 환상의 세계로 이끄는 시계토끼와 함께 상상만 해도 즐거운 파티" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1566125&pEtr=73689" title="Disney Alice Scratch Book 보러가기"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73689/img_slide_story_02.jpg" alt="#Artwork 벽에 걸린 꿈이 말하는 이야기를 들어보아요" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1566125&pEtr=73689" title="Disney Alice Scratch Book 보러가기"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73689/img_slide_story_03_v1.jpg" alt="#Letter 소중한 사람에게 특별한 메시지를 전해보는 건 어떨까요?" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1566125&pEtr=73689" title="Disney Alice Scratch Book 보러가기"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73689/img_slide_story_04.jpg" alt="#Healing 잠시 머문 나만의 시간, 언제나 우리를 기다리는 환상의 나라로 함께 떠나요" /></a>
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
			<a href="/shopping/category_prd.asp?itemid=1566125&pEtr=73689" title="Disney Alice Scratch Book 보러가기">
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73689/txt_finish.png" alt="상상이 현실이 되는 Wonderland" /></p>
				<div class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73689/img_finish.jpg" alt="" /></div>
			</a>
		</div>
		
		<%' comment %>
		<div class="commentevet">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73689/tit_comment.png" alt="Hey, something project 나만의 빛나는 순간" /></h3>
			<p class="hidden">현실 속에서 상상하던 나만의 빛나는 순간은 언제인지 적어주세요! 정성껏 코멘트를 남겨주신 10분을 추첨하여 앨리스 스크래치 북을 드립니다.코멘트 작성기간은 2016년 10월 19일부터 10월 25일까지며, 발표는 10월 26일 입니다.</p>
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
					<legend>현실 속에서 상상하던 나만의 빛나는 순간 선택하고 코멘트 쓰기</legend>
						<ul class="choice">
							<li class="ico1"><button type="button" value="1">Party</button></li>
							<li class="ico2"><button type="button" value="2">Artwork</button></li>
							<li class="ico3"><button type="button" value="3">Letter</button></li>
							<li class="ico4"><button type="button" value="4">Healing</button></li>
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
												Party
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="2" then %>
												Artwork
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="3" then %>
												Letter
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="4" then %>
												Healing
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
	$("#slide").slidesjs({
		width:"650",
		height:"530",
		pagination:false,
		navigation:{effect:"fade"},
		play:{interval:2000, effect:"fade", auto:true},
		effect:{fade: {speed:1000, crossfade:true}}
	});

	/* swipe */
	var swiper1 = new Swiper('#rolling .swiper1',{
		centeredSlides:true,
		slidesPerView:"auto",
		loop: true,
		speed:1500,
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

	$('#rolling .pagination span,.btn-nav').click(function(){
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
		if (scrollTop > 700 ) {
			$(".heySomething #intro .photo img").addClass("pulse");
		}
		if (scrollTop > 1400 ) {
			itemAnimation();
		}
		if (scrollTop > 6700 ) {
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

	/* finish animation */
	$(".heySomething .finish p").css({"margin-left":"-500px", "opacity":"0"});
	function finishAnimation() {
		$(".heySomething .finish p").delay(100).animate({"margin-left":"-542px", "opacity":"1"},1000);
	}
});
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->