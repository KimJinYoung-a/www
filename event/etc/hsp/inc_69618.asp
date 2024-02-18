<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈 24
' History : 2016-03-15 김진영 생성
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
dim oItem, itemid
dim currenttime
	currenttime =  now()
'																			currenttime = #03/02/2016 09:00:00#

dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  66064
Else
	eCode   =  69618
End If

dim userid, commentcount, i
	userid = GetEncLoginUserID()

commentcount = getcommentexistscount(userid, eCode, "", "", "", "Y")

dim cEComment ,blnFull, cdl, com_egCode, bidx, blnBlogURL, strBlogURL
dim iCTotCnt, arrCList,intCLoop, ecc
dim iCPageSize, iCCurrpage, isMyComm
dim iCStartPage, iCEndPage, iCTotalPage, iCx,iCPerCnt
	iCCurrpage	= requestCheckVar(Request("iCC"),10)	'현재 페이지 번호
	cdl			= requestCheckVar(Request("cdl"),3)
	blnFull		= requestCheckVar(Request("blnF"),10)
	blnBlogURL	= requestCheckVar(Request("blnB"),10)
	isMyComm	= requestCheckVar(request("isMC"),1)
	ecc	= requestCheckVar(request("ecc"),10)
	
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


Dim hspchk
'// 현재 주소값 체크하여 신규, 구버전 확인
hspchk = Split(LCase(Request.ServerVariables("PATH_INFO")),"/")
%>
<style type="text/css">
/* title */
.heySomething .topic {background:#f8e194 url(http://webimage.10x10.co.kr/eventIMG/2016/hey/69618/img_item_represent.jpg) no-repeat 50% 0;}
.heySomething .topic .bnr {text-indent:-9999em;}
.heySomething .topic .bnr a {display:block; width:100%; height:780px;}

/* item */
.heySomething .item h3 {position:relative; z-index:5; height:52px;}
.heySomething .item h3 .tintin {position:absolute; top:0; left:50%; margin-left:-118px;}
.flip {animation-name:flip; animation-duration:3s; animation-fill-mode:both; animation-iteration-count:1; backface-visibility:visible;}
@keyframes flip {
	0% {transform:translateZ(0) rotateY(0) scale(1); animation-timing-function: ease-out;}
	40% {transform:translateZ(150px) rotateY(170deg) scale(1); animation-timing-function: ease-out;}
	50% {transform:translateZ(150px) rotateY(190deg) scale(1); animation-timing-function: ease-in;}
	80% {transform:translateZ(0) rotateY(360deg) scale(.95); animation-timing-function: ease-in;}
	100% {transform:translateZ(0) rotateY(360deg) scale(1); animation-timing-function: ease-in;}
}

.heySomething .item h3 .horizontalLine1, .heySomething .item h3 .horizontalLine2 {position:absolute; top:50%; z-index:5; width:410px; height:1px; margin-top:-1px; background-color:#ddd;}
.heySomething .item h3 .horizontalLine1 {left:0;}
.heySomething .item h3 .horizontalLine2 {right:0;}
.heySomething .item .option .price strong {color:#3a940e;}
.heySomething .itemA .desc {position:relative;}
.heySomething .itemA .figure {top:28px; left:485px;}
.heySomething .itemA .with {border:none;}
.heySomething .itemA .with span {position:relative; z-index:5;}

/* visual */
.heySomething .visual .figure {background-color:#d0e4fc;}
.heySomething #slider {height:187px; text-align:left;}
.heySomething #slider .slide-img {width:178px; height:187px; margin:0 18px; text-align:center;}

/* brand */
.heySomething .brand {height:940px; padding:140px 0 0; background-color:#f4b363;}

/* comic book */
.comicbook {padding-top:240px;}
.comicbook ul {position:relative; width:960px; height:700px; margin:0 auto;}
.comicbook ul li.scene1 {position:absolute; top:0; left:0;}
.comicbook ul li.scene2 {position:absolute; bottom:0; left:0;}
.comicbook ul li.scene3 {position:absolute; top:0; right:0;}
.comicbook ul li p {position:absolute;}
.comicbook ul li p a:hover img {animation-name:bounce; animation-iteration-count:5; animation-duration:0.7s;}
@keyframes bounce {
	from, to{margin-top:0; animation-timing-function:ease-out;}
	50% {margin-top:5px; animation-timing-function:ease-in;}
}
.comicbook ul li.scene1 p {top:-40px; left:-80px;}
.comicbook ul li.scene2 p {top:186px; left:-50px;}
.comicbook ul li.scene3 .link1 {top:130px; left:-50px;}
.comicbook ul li.scene3 .link2 {top:510px; right:-90px;}

/* story */
.heySomething .story {margin-top:310px; padding-bottom:140px;}
.heySomething .rolling {margin-top:73px; padding-top:160px;}
.heySomething .rolling .pagination {top:-28px; width:850px; margin-left:-425px;}
.heySomething .rolling .swiper-pagination-switch {width:120px; height:150px; margin:0 25px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/69618/btn_pagination.png);}
.heySomething .rolling .pagination span.swiper-active-switch {background-position:0 100%;}
.heySomething .rolling .pagination span:first-child + span {background-position:-170px 0;}
.heySomething .rolling .pagination span:first-child + span.swiper-active-switch {background-position:-170px 100%;}
.heySomething .rolling .pagination span:first-child + span + span {background-position:-340px 0;}
.heySomething .rolling .pagination span:first-child + span + span.swiper-active-switch {background-position:-340px 100%;}
.heySomething .rolling .pagination span:first-child + span + span + span {background-position:-510px 0;}
.heySomething .rolling .pagination span:first-child + span + span + span.swiper-active-switch {background-position:-510px 100%;}
.heySomething .rolling .pagination span:first-child + span + span + span + span {background-position:100% 0;}
.heySomething .rolling .pagination span:first-child + span + span + span + span.swiper-active-switch {background-position:100% 100%;}
.heySomething .rolling .pagination span em {bottom:-808px; left:50%;height:140px; margin-left:-490px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/69618/txt_story_desc.png); cursor:default;}
.heySomething .rolling .pagination span .desc2 {background-position:0 -140px;}
.heySomething .rolling .pagination span .desc3 {background-position:0 -280px;}
.heySomething .rolling .pagination span .desc4 {background-position:0 -420px;}
.heySomething .rolling .pagination span .desc5 {background-position:0 100%;}

/* finish */
.heySomething .finish {height:800px; background:#edf5fb url(http://webimage.10x10.co.kr/eventIMG/2016/hey/69618/img_finish.jpg) no-repeat 50% 0;}
.heySomething .finish a {display:block; width:100%; height:100%;}
.heySomething .finish p {top:161px; margin-left:-468px;}
.heySomething .finish ul {overflow:hidden; position:absolute; top:67px; left:50%; width:705px; margin-left:-94px;}
.heySomething .finish ul li {float:left; width:214px; margin-right:21px; margin-bottom:16px;}
@keyframes lightSpeedIn {
	0% {transform:translateX(5%); opacity:0;}
	100% {transform:translateX(0%); opacity:1;}
}
.lightSpeedIn {animation-name:lightSpeedIn; animation-timing-function:ease-out; animation-duration:3s; animation-fill-mode:both; animation-iteration-count:1;}

/* comment */
.heySomething .commentevet {margin-top:250px;}
.heySomething .commentevet .form {margin-top:20px;}
.heySomething .commentevet .form .choice li {width:100px; margin-right:30px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/69618/bg_ico.png); background-position:0 0;}
.heySomething .commentevet .form .choice li.ico2 button {background-position:-130px 0;}
.heySomething .commentevet .form .choice li.ico2 button.on {background-position:-130px 100%;}
.heySomething .commentevet .form .choice li.ico3 button {background-position:-260px 0;}
.heySomething .commentevet .form .choice li.ico3 button.on {background-position:-260px 100%;}
.heySomething .commentevet .form .choice li.ico4 button {background-position:-390px 0;}
.heySomething .commentevet .form .choice li.ico4 button.on {background-position:-390px 100%;}
.heySomething .commentevet .form .choice li.ico5 button {background-position:100% 0;}
.heySomething .commentevet .form .choice li.ico5 button.on {background-position:100% 100%;}

.heySomething .commentlist table td strong {width:100px; height:100px; margin-left:20px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/69618/bg_ico.png); background-position:0 -25px;}
.heySomething .commentlist table td strong.ico2 {background-position:-130px -25px;}
.heySomething .commentlist table td strong.ico3 {background-position:-260px -25px;}
.heySomething .commentlist table td strong.ico4 {background-position:-390px -25px;}
.heySomething .commentlist table td strong.ico5 {background-position:100% -25px;}
</style>
<script type='text/javascript'>
<% if Request("iCC") <> "" or request("ecc") <> "" then %>
	$(function(){
		var val = $('#commentlist').offset();
	    $('html,body').animate({scrollTop:val.top},0);
	});
<% end if %>

function jsGoComPage(iP){
	document.frmcom.iCC.value = iP;
	document.frmcom.iCTot.value = "<%=iCTotCnt%>";
	document.frmcom.submit();
}

function jsSubmitComment(frm){
	<% If IsUserLoginOK() Then %>
		<% if commentcount>0 then %>
			alert("이벤트는 한번만 참여 가능 합니다.");
			return false;
		<% else %>
			if (frm.gubunval.value == ''){
				alert('원하는 항목을 선택해 주세요.');
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
			<div class="bnr"><a href="/street/street_brand_sub06.asp?makerid=tintin1010">TINTIN</a></div>
		</div>
	
		<%' about %>
		<div class="about">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
			<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
		</div>
	
		<%' item %>
		<div class="item itemA">
			<div class="inner">
				<h3>
					<span class="tintin"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69618/img_logo_tintin.png" alt="TINTIN" /></span>
					<span class="horizontalLine1"></span>
					<span class="horizontalLine2"></span>
				</h3>	
				<div class="desc">
					<div class="figure">
						<a href="/shopping/category_prd.asp?itemid=1449129&amp;pEtr=69618"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69618/img_figure.jpg" width="570" height="592" alt="틴틴 KEY RING"></a>
					</div>
					<div class="option">
						<em class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69618/txt_name.png" alt="TINTIN Putsits Trench 8.5cm" /></em>

		<%
			IF application("Svr_Info") = "Dev" THEN
				itemid = 1239226
			Else
				itemid = 1449129
			End If
			' for dev msg : 상품코드 1449129, 할인기간 3/16~3/22 할인기간이 지나면 <strong class="discount">...</strong> 숨겨주세요
			Set oItem = new CatePrdCls
				oItem.GetItemData itemid
				If oItem.FResultCount > 0 then 
					IF (oItem.Prd.FItemCouponYN="Y") THEN 
		%>
						<div class="price">
		<%
						If not( left(currenttime,10)>="2016-03-16" and left(currenttime,10)<"2016-03-23" ) Then
						Else
		%>
							<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69618/txt_only_20percent_coupon.png" alt="단, 일주일만 20%" /></strong>
							<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %>won</s>
		<%				End If %>
						<% If oitem.Prd.isCouponItem Then %>
							<strong><%= FormatNumber(oItem.Prd.GetCouponAssignPrice,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
						<% Else %>
							<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
						<% End If %>
						</div>
		<%			Else %>
						<div class="price priceEnd">
							<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
						</div>
		<%
					End If
				End if 
			Set oItem = nothing 
		%>
						<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69618/txt_substance.png" alt="유럽의 국민 캐릭터 틴틴! 전세계적으로 인기있는 틴틴을 텐바이텐에서 만나보세요! 틴틴을 검색하면 손에 꼽히게 가장 많이 나오는 이미지로, 그만큼 인기있는 피규어 틴틴, 또 어딜가려는거니" /></p>
						<div class="btnget"><a href="/street/street_brand_sub06.asp?makerid=tintin1010"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="TINTIN 브랜드샵 보러가기" /></a></div>
					</div>
				</div>

				<div class="with">
					<span><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/ico_plus.png" alt="" /></span>
					<ul>
						<li>
					<%
						IF application("Svr_Info") = "Dev" THEN
							itemid = 786868
						Else
							itemid = 1441770
						End If
						Set oItem = new CatePrdCls
							oItem.GetItemData itemid
					%>
							<a href="/shopping/category_prd.asp?itemid=1441770&amp;pEtr=69618">
								<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69618/img_with_item_01.jpg" alt="" />
								<span>BOX SCENE - On the Aurora</span>
							<% If oItem.FResultCount > 0 Then %>
								<% If oitem.Prd.isCouponItem Then %>
									<strong><%= FormatNumber(oItem.Prd.GetCouponAssignPrice,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								<% Else %>
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								<% End If %>
							<% End if %>
							</a>
					<% Set oItem = nothing %>
						</li>
						<li>
					<%
						IF application("Svr_Info") = "Dev" THEN
							itemid = 786868
						Else
							itemid = 1441776
						End If
						Set oItem = new CatePrdCls
							oItem.GetItemData itemid
					%>
							<a href="/shopping/category_prd.asp?itemid=1441776&amp;pEtr=69618">
								<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69618/img_with_item_02.jpg" alt="" />
								<span>On the Aurora (box)</span>
							<% If oItem.FResultCount > 0 Then %>
								<% If oitem.Prd.isCouponItem Then %>
									<strong><%= FormatNumber(oItem.Prd.GetCouponAssignPrice,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								<% Else %>
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								<% End If %>
							<% End if %>
							</a>
					<% Set oItem = nothing %>
						</li>
						<li>
					<%
						IF application("Svr_Info") = "Dev" THEN
							itemid = 786868
						Else
							itemid = 1441789
						End If
						Set oItem = new CatePrdCls
							oItem.GetItemData itemid
					%>
							<a href="/shopping/category_prd.asp?itemid=1441789&amp;pEtr=69618">
								<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69618/img_with_item_03.jpg" alt="" />
								<span>Tintin in a diving suit</span>
							<% If oItem.FResultCount > 0 Then %>
								<% If oitem.Prd.isCouponItem Then %>
									<strong><%= FormatNumber(oItem.Prd.GetCouponAssignPrice,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								<% Else %>
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								<% End If %>
							<% End if %>
							</a>
					<% Set oItem = nothing %>
						</li>
						<li>
					<%
						IF application("Svr_Info") = "Dev" THEN
							itemid = 786868
						Else
							itemid = 1449178
						End If
						Set oItem = new CatePrdCls
							oItem.GetItemData itemid
					%>
							<a href="/shopping/category_prd.asp?itemid=1449178&amp;pEtr=69618">
								<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69618/img_with_item_04.jpg" alt="" />
								<span>Tintin puzzle and poste</span>
							<% If oItem.FResultCount > 0 Then %>
								<% If oitem.Prd.isCouponItem Then %>
									<strong><%= FormatNumber(oItem.Prd.GetCouponAssignPrice,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								<% Else %>
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								<% End If %>
							<% End if %>
							</a>
					<% Set oItem = nothing %>
						</li>
					</ul>
				</div>
			</div>
		</div>
	
		<%'' visual %>
		<div class="visual">
			<div class="figure"><a href="/street/street_brand_sub06.asp?makerid=tintin1010"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69618/img_item_visual_big.jpg" alt="" /></a></div>
			<div id="slider" class="slider-horizontal">
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1449131&amp;pEtr=69618"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69618/img_item_visual_01.jpg" alt="KEY RING 3 option" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1449129&amp;pEtr=69618"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69618/img_item_visual_02.jpg" alt="KEY RING 9 option" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1449258&amp;pEtr=69618"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69618/img_item_visual_03.jpg" alt="KEY RING PLUSH SNOWY" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1449178&amp;pEtr=69618"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69618/img_item_visual_04.jpg" alt="puzzle and poster 5 option" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1441824&amp;pEtr=69618"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69618/img_item_visual_05.jpg" alt="ROCKET 8.5cm" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1441820&amp;pEtr=69618"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69618/img_item_visual_06.jpg" alt="CALCULUS SUITCASE 5.5cm" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1441815&amp;pEtr=69618"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69618/img_item_visual_07.jpg" alt="HOMSON WALKING STICK 6cm" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1441813&amp;pEtr=69618"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69618/img_item_visual_08.jpg" alt="HADDOCK IN DE RALLY 9cm" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1441812&amp;pEtr=69618"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69618/img_item_visual_09.jpg" alt="SNOWY WALKING+BONE 4.5cm" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1441811&amp;pEtr=69618"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69618/img_item_visual_10.jpg" alt="NOWY LYING 4.5cm" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1441810&amp;pEtr=69618"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69618/img_item_visual_11.jpg" alt="BLUE PULLOVER 8.5cm" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1441809&amp;pEtr=69618"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69618/img_item_visual_12.jpg" alt="PUTSITS TRENCH 8.5cm" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1441806&amp;pEtr=69618"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69618/img_item_visual_13.jpg" alt="TINTIN LOTUS 9cm" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1441804&amp;pEtr=69618"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69618/img_item_visual_14.jpg" alt="TINTIN SEATED TIBET 3.8cm" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1441800&amp;pEtr=69618"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69618/img_item_visual_15.jpg" alt="TINTIN SEATED TIBET 5.5cm" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1441797&amp;pEtr=69618"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69618/img_item_visual_16.jpg" alt="TINTIN WELCOMES 6cm" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1441793&amp;pEtr=69618"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69618/img_item_visual_17.jpg" alt="TINTIN WELCOMES 9cm" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1441789&amp;pEtr=69618"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69618/img_item_visual_18.jpg" alt="Tintin in a diving suit box" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1441782&amp;pEtr=69618"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69618/img_item_visual_19.jpg" alt="Showing Tintin a crab tin box" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1441780&amp;pEtr=69618"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69618/img_item_visual_20.jpg" alt="TINTIN RAILWAY box" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1441776&amp;pEtr=69618"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69618/img_item_visual_21.jpg" alt="On the Aurora box" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1441770&amp;pEtr=69618"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69618/img_item_visual_22.jpg" alt="CENE Tintin in his armchai box" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1441765&amp;pEtr=69618"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69618/img_item_visual_23.jpg" alt="SCENE TINTIN COGARS box" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1441755&amp;pEtr=69618"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69618/img_item_visual_24.jpg" alt="SCENE TINTIN COW-BOY box" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1441752&amp;pEtr=69618"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69618/img_item_visual_25.jpg" alt="SCENE TINTIN EXPLORER box" /></a>
				</div>
			</div>
		</div>
	
		<%'' brand %>
		<div class="brand">
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69618/txt_brand.png" alt="Money doesn&apos;t excite me, my ideas excited me. Walt Disney 디즈니는 1923 설립 이래로 필름스케치, 드로잉, 포스터 등 다양한 작업을 통해 디즈니 고유의 아트워크를 창조하고있습니다. 디즈니의 빈티지 컬렉션은 클래식 감성을 간직한 사랑스러운 디즈니 캐릭터를 통해 어린 시절의 추억과 향수를 불러일으킵니다." /></p>
			<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="" /></div>
		</div>
	
		<%'' comic book %>
		<div class="comicbook">
			<ul>
				<li class="scene1">
					<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69618/img_comicbook_01.jpg" alt="" />
					<p><a href="/shopping/category_prd.asp?itemid=1441809&amp;pEtr=69618" title="PUTSITS TRENCH 8.5cm 상품 보러가기"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69618/txt_speech_bubble_01.png" alt="소년기자 틴틴 주인공으로, 세계를 모험하면서 정의를 실현하는 벨기에기자" /></a></p>
				</li>
				<li class="scene2">
					<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69618/img_comicbook_02.jpg" alt="" />
					<p><a href="/shopping/category_prd.asp?itemid=1441811&amp;pEtr=69618" title="SNOWY LYING 4.5cm 상품 보러가기"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69618/txt_speech_bubble_02.png" alt="틴틴의 단짝 애견 스노위 가끔 개답지 않은 생각을 하며 뼈다귀를 좋아하고 술을 좋아한다." /></a></p>
				</li>
				<li class="scene3">
					<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69618/img_comicbook_03_v1.png" alt="" />
					<p class="link1"><a href="/shopping/category_prd.asp?itemid=1449131&amp;pEtr=69618" title=" KEY RING 3 option상품 보러가기"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69618/txt_speech_bubble_03.png" alt="틴틴의 조력자 쌍둥이 형사 톰슨 형사임에도 불구하고 멍청한 캐릭터로 어딜가나 사고만 친다" /></a></p>
					<p class="link2"><a href="/shopping/category_prd.asp?itemid=1449129&amp;pEtr=69618" title="KEY RING 9 option 상품 보러가기"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69618/txt_speech_bubble_04.png" alt="틴틴의 모험파트너 아독선장 : 평생을 바다에서 보낸 사나이 말랑말랑한 마음이 숨겨져 있다." /></a></p>
				</li>
			</ul>
		</div>
	
		<%''story %>
		<div class="story">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69618/tit_story.png" alt="흥미진진 틴틴의 모험 이야기" /></h3>
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
									<a href="/shopping/category_prd.asp?itemid=1441809&amp;pEtr=69618" title="PUTSITS TRENCH 8.5cm 상품 보러가기"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69618/img_slide_01.jpg" alt="CITY 도시로 간 틴틴: #도시여행#쇼핑#먹방찍으러갑니다#활기#야경" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1441755&amp;pEtr=69618" title="SCENE TINTIN COW-BOY box상품 보러가기"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69618/img_slide_02.jpg" alt="MOUNTAIN 산으로 간 틴틴: #자연속에서의힐링#피톤치드#꽃놀이" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1441793&amp;pEtr=69618" title="TINTIN WELCOMES 9cm 상품 보러가기"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69618/img_slide_03.jpg" alt="PALACE 고궁으로 간 틴틴: #경복궁야간개장#전통이살아숨쉬는곳#고궁" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1441800&amp;pEtr=69618" title="TINTIN SEATED TIBET 5.5cm 상품 보러가기"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69618/img_slide_04.jpg" alt="CAFE 카페로 간 틴틴: #핫플레이스#여유#커피#예쁜카페는사랑입니다" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1441770&amp;pEtr=69618" title="SCENE Tintin in his armchai box 상품 보러가기"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69618/img_slide_05.jpg" alt="BOOK STORE 서점으로 간 틴틴: #서점에서책한권#여유#힐링#마음의양식" /></a>
								</div>
							</div>
						</div>
					</div>
					<div class="pagination"></div>
				</div>
			</div>
		</div>

		<%''finish %>
		<div class="finish">
			<a href="https://www.instagram.com/jskglobal_tintin/" target="_blank" title="틴틴 인스타그램 페이지로 이동 새창">
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69618/txt_finish_v1.png" alt="나는 틴틴주의자! 오랜시간 사랑받는 틴틴! #틴틴 #틴틴과 함께 여행가자! #어디까지 가봤니 #추억을 담는 또 하나의 방법 @jskglobal_tintin" /></p>
				<ul>
					<li><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69618/img_instagram_01.png" alt="" /></li>
					<li><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69618/img_instagram_02.png" alt="" /></li>
					<li><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69618/img_instagram_03.png" alt="" /></li>
					<li><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69618/img_instagram_04.png" alt="" /></li>
					<li><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69618/img_instagram_05.png" alt="" /></li>
					<li><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69618/img_instagram_06.png" alt="" /></li>
					<li><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69618/img_instagram_07.png" alt="" /></li>
					<li><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69618/img_instagram_08.png" alt="" /></li>
					<li><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69618/img_instagram_09.png" alt="" /></li>
				</ul>
			</a>
		</div>

		<%'' comment %>
		<div class="commentevet" id="commentlist">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69618/tit_comment.png" alt="Hey, something project 당신의 스타일" /></h3>
			<p class="hidden">여러분이 틴틴과 함께 떠나고 싶은 곳은 어디인가요? 가고 싶은곳과 그 이유를 코멘트로 남겨주세요! 정성껏 코멘트를 남겨주신 3분을 추첨하여 틴틴의모험 키링을 증정합니다. 디자인은 랜덤입니다. 코멘트 작성기간은 2016년 3월 16일부터 3월 22일까지며, 발표는 3월 23일 입니다.</p>
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
				<input type="hidden" name="txtcomm">
				<input type="hidden" name="gubunval">
				<% If InStr(Request.ServerVariables("QUERY_STRING"), "&ecc=1") > 0 Then %>
				<% Else %>
					<input type="hidden" name="hookcode" value="&ecc=1">
				<% End If %>
					<fieldset>
					<legend>틴틴 코멘트 쓰기</legend>
						<ul class="choice">
							<li class="ico1"><button type="button" value="1">CITY</button></li>
							<li class="ico2"><button type="button" value="2">MOUNTAIN</button></li>
							<li class="ico3"><button type="button" value="3">PALACE</button></li>
							<li class="ico4"><button type="button" value="4">CAFE</button></li>
							<li class="ico5"><button type="button" value="5">BOOK STORE</button></li>
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
					<% If InStr(Request.ServerVariables("QUERY_STRING"), "&ecc=1") > 0 Then %>
					<% Else %>
						<input type="hidden" name="hookcode" value="&ecc=1">
					<% End If %>
				</form>
			</div>
	
			<% '' commentlist %>
			<div class="commentlist">
				<p class="total">total <%= iCTotCnt %></p>
				<% IF isArray(arrCList) THEN %>
					<table>
						<caption>틴틴 코멘트 목록</caption>
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
													CITY
												<% elseif split(arrCList(1,intCLoop),"!@#")(0)="2" then %>
													MOUNTAIN
												<% elseif split(arrCList(1,intCLoop),"!@#")(0)="3" then %>
													PALACE
												<% elseif split(arrCList(1,intCLoop),"!@#")(0)="4" then %>
													CAFE
												<% elseif split(arrCList(1,intCLoop),"!@#")(0)="4" then %>
													BOOK STORE
												<% Else %>
													CITY
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
										<% If arrCList(8,intCLoop) <> "W" Then %>
											<br /><img src="http://fiximage.10x10.co.kr/web2013/event/ico_mobile.png" alt="모바일에서 작성됨">
										<% end if %>
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
	
<script type="text/javascript" src="/lib/js/jquery.flowslider.js"></script>
<script type="text/javascript">
$(function(){
	/* flowslider */
	$("#slider").FlowSlider({
		marginStart:0,
		marginEnd:0,
		//position:0.0,
		startPosition:0.55
	});

	/* swipe */
	var swiper1 = new Swiper('.swiper1',{
		centeredSlides:true,
		slidesPerView:"auto",
		//initialSlide:0,
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
	$(".form .choice li:first-child button").addClass("on");
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
		if (scrollTop > 1000 ) {
			itemAnimation()
		}
		if (scrollTop > 3950 ) {
			brandAnimation()
		}
		if (scrollTop > 5100 ) {
			comicbookAnimation()
		}
		if (scrollTop > 7200 ) {
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
		$(".heySomething .item h3 .tintin").addClass("flip");
	}

	/* brand animation */
	$(".heySomething .brand p").css({"height":"100px", "opacity":"0"});
	$(".heySomething .brand .btnDown").css({"opacity":"0"});
	function brandAnimation() {
		$(".heySomething .brand p").delay(50).animate({"height":"646px", "opacity":"1"},1200);
		$(".heySomething .brand .btnDown").delay(800).animate({"opacity":"1"},1200);
	}

	/* comicbook animation */
	$(".heySomething .comicbook ul li").css({"opacity":"0"});
	$(".heySomething .comicbook ul .scene1").css({"top":"50px", "left":"50px"});
	$(".heySomething .comicbook ul .scene2").css({"bottom":"50px", "left":"50px"});
	$(".heySomething .comicbook ul .scene3").css({"top":"50px", "right":"50px"});
	function comicbookAnimation() {
		$(".heySomething .comicbook ul .scene1").delay(50).animate({"top":"0", "left":"0", "opacity":"1"},600);
		$(".heySomething .comicbook ul .scene2").delay(50).animate({"bottom":"0", "left":"0", "opacity":"1"},600);
		$(".heySomething .comicbook ul .scene3").delay(50).animate({"top":"0", "right":"0", "opacity":"1"},600);
	}

	/* finish animation */
	function finishAnimation() {
		$(".heySomething .finish ul").addClass("lightSpeedIn");
	}
});
</script>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->