<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈 43
' History : 2016-08-09 김진영 생성
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
	eCode   =  66180
Else
	eCode   =  72343
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
.heySomething .topic {background-color:#adeeff;}
.heySomething .topic h2 {z-index:5;}
.heySomething .topic .figure a {display:block; position:relative; width:100%; height:780px;}
.heySomething .topic .figure img {position:absolute; top:0; left:50%; margin-left:-951px;}

/* item */
.heySomething .item {width:1140px; margin:368px auto 0; padding:0;}
.heySomething .item h3 {position:relative; height:119px;}
.heySomething .item h3 .mbc {position:absolute; top:0; left:394px; z-index:5;}
.heySomething .item h3 .oxford {position:absolute; top:0; left:636px; z-index:5;}
.heySomething .item h3 .collabo {position:absolute; top:39px; left:553px;}
.heySomething .item h3 .horizontalLine1, .heySomething .item h3 .horizontalLine2 {position:absolute; top:50px; width:322px; height:1px; background-color:#d9d9d9;}
.heySomething .item h3 .horizontalLine1 {left:0;}
.heySomething .item h3 .horizontalLine2 {right:0;}
.heySomething .item .desc {position:relative; width:1140px; height:505px; margin:0 auto; padding-top:70px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/72343/bg_line_dashed.png) repeat-x 0 100%;text-align:left;}
.heySomething .item .desc2 {height:500px; padding-top:125px;}
.heySomething .item .desc3 {height:489px; padding-top:111px; background:none;}
.heySomething .item .desc .option {height:395px;}
.heySomething .item .desc a {display:block;}
.heySomething .item .desc a:hover {text-decoration:none;}
.heySomething .item .slidewrap {position:absolute; top:0; width:600px; height:550px;}
.heySomething .item .desc1 .slidewrap {right:0;}
.heySomething .item .desc1 .option, .heySomething .item .desc3 .option {margin-left:85px;}
.heySomething .item .desc2 .option {margin-left:694px;}
.heySomething .item .desc2 .slidewrap {top:24px; left:0; height:600px;}
.heySomething .item .desc3 .slidewrap {right:0; height:600px;}
.heySomething .item .option .price strong {color:#3a940e;}
.heySomething .item .option .priceEnd strong {color:#000;}

/* visual */
.heySomething .visual {position:relative; margin-top:21px;}
.heySomething .with {text-align:center;}
.heySomething #slider {margin-top:34px;}
.heySomething #slider .slide-img {width:auto; height:235px; margin:0 60px;}
.heySomething #slider .slide-img a {color:#636363;}
.heySomething #slider .slide-img a:hover {text-decoration:none;}
.heySomething #slider .slide-img span {display:block; font-size:12px; line-height:1.5em;}
.heySomething #slider .slide-img .name {margin-top:18px;}

/* brand */
.heySomething .brand {position:relative; height:290px; margin-top:425px; padding-top:260px;}
.heySomething .brand .logo {position:absolute; top:0; left:50%; margin-left:-102px;}
.pulse {animation-name:pulse; animation-duration:1s; animation-iteration-count:1;}
@keyframes pulse {
	0% {transform:scale(0.8);}
	100% {transform:scale(1);}
}

/* video */
.video {width:960px; margin:350px auto 0;}

/* story */
.heySomething .story {margin-top:354px; padding-bottom:0;}
.heySomething .rolling {padding-top:154px;}
.heySomething .rolling .swiper .swiper-slide {width:979px;}
.heySomething .rolling .pagination {top:0; width:786px; margin-left:-393px;}
.heySomething .rolling .swiper-pagination-switch {width:115px; height:115px; margin:0 8px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/72343/btn_pagination.png);}
.heySomething .rolling .pagination span.swiper-active-switch {background-position:0 100%;}
.heySomething .rolling .pagination span:first-child + span {background-position:-132px 0;}
.heySomething .rolling .pagination span:first-child + span.swiper-active-switch {background-position:-132px 100%;}
.heySomething .rolling .pagination span:first-child + span + span {background-position:-264px 0;}
.heySomething .rolling .pagination span:first-child + span + span.swiper-active-switch {background-position:-264px 100%;}
.heySomething .rolling .pagination span:first-child + span + span + span {background-position:-397px 0;}
.heySomething .rolling .pagination span:first-child + span + span + span.swiper-active-switch {background-position:-397px 100%;}
.heySomething .rolling .pagination span:first-child + span + span + span + span {background-position:-529px 0;}
.heySomething .rolling .pagination span:first-child + span + span + span + span.swiper-active-switch {background-position:-529px 100%;}
.heySomething .rolling .pagination span:first-child + span + span + span + span + span {background-position:100% 0;}
.heySomething .rolling .pagination span:first-child + span + span + span + span + span.swiper-active-switch {background-position:100% 100%;}
.heySomething .rolling .btn-nav {top:464px;}
.heySomething .swipemask {top:154px;}
.heySomething .mask-left {margin-left:-1470px;}
.heySomething .mask-right {margin-left:490px;}

/* finish */
.heySomething .finish {height:712px; margin-top:530px; background:#d2f9ff url(http://webimage.10x10.co.kr/eventIMG/2016/hey/72343/bg_sky.jpg) no-repeat 50% 0;}
.heySomething .finish .figure {position:absolute; top:107px; left:50%; margin-left:-127px;}
.heySomething .finish .cloud {position:absolute; top:125px; left:50%; margin-left:-768px;}
.heySomething .finish .cloud {animation-name:shake; animation-iteration-count:infinite; animation-duration:5s;}
@keyframes shake {
	from, to{ margin-left:-768px; animation-timing-function:ease-out;}
	50% {margin-left:-708px; animation-timing-function:ease-in;}
}
.heySomething .finish p {top:291px; margin-left:-570px;}

/* comment */
.heySomething .commentevet {margin-top:370px;}
.heySomething .commentevet .form .choice li {width:133px; height:133px; margin-right:58px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/72343/img_ico.png); background-position:0 0;}
.heySomething .commentevet .form .choice li button.on {background-position:0 100%;}
.heySomething .commentevet .form .choice li.ico2 button {background-position:-191px 0;}
.heySomething .commentevet .form .choice li.ico2 button.on {background-position:-191px 100%;}
.heySomething .commentevet .form .choice li.ico3 button {background-position:100% 0;}
.heySomething .commentevet .form .choice li.ico3 button.on {background-position:100% 100%;}

.heySomething .commentevet textarea {margin-top:40px;}

.heySomething .commentlist table td strong {width:112px; height:112px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/72343/img_ico_02.png); background-position:0 0;}
.heySomething .commentlist table td strong.ico2 {background-position:0 -148px;}
.heySomething .commentlist table td strong.ico3 {background-position:0 100%;}
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
		<% If not( left(currenttime,10) >= "2016-08-09" and left(currenttime,10) <= "2016-08-16" ) Then %>
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
				<a href="/shopping/category_prd.asp?itemid=1543277&amp;pEtr=72343"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72343/img_item_represent.jpg" alt="MBC 라디오스튜디오" /></a>
			</div>
		</div>
		<%' about %>
		<div class="about">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
			<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
		</div>
		<%' item %>
		<div class="item">
			<div class="inner">
				<h3>
					<span class="mbc"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72343/img_logo_mbc_brand_store.png" alt="MBC 브랜드 스토어" /></span>
					<span class="collabo"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72343/txt_collabo.png" alt="와" /></span>
					<span class="oxford"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72343/img_logo_oxford.png" alt="옥스포드 콜라보레이션" /></span>
					<span class="horizontalLine1"></span>
					<span class="horizontalLine2"></span>
				</h3>
			<%
				IF application("Svr_Info") = "Dev" THEN
					itemid = 1239226
				Else
					itemid = 1543277
				End If
				set oItem = new CatePrdCls
					oItem.GetItemData itemid
			%>
				<div class="desc desc1">
					<a href="/shopping/category_prd.asp?itemid=1543277&amp;pEtr=71159">
						<div class="option">
							<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72343/txt_name_01.png" alt="MBC 라디오 스튜디오 텐바이텐 단독 선오픈 상품으로 완제품의 크기는 가로 19.2센치 세로 8.7센치며, 패키지 크기는 가로 32센치 세로 23센치입니다." /></p>
					<%' for dev msg : 상품코드 1543277 할인 중 %>
					<% If oItem.FResultCount > 0 Then %>
						<% IF (oItem.Prd.FItemCouponYN="Y") THEN  %>
							<div class="price">
							<% If oitem.Prd.isCouponItem Then %>
								<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/txt_only_tenten_10percent_coupon.png" alt="텐바이텐에서 ONLY 10%" /></strong>
								<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
								<strong><%= FormatNumber(oItem.Prd.GetCouponAssignPrice,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
							<% Else %>
								<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
							<% End If %>
							</div>
						<% Else %>
						<%' for dev msg : 할인 전 / 종료후 %>
							<div class="price priceEnd">
								<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
							</div>
						<% End If %>
					<% End If %>
							<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72343/txt_substance_01.png" alt="MBC와 옥스포드가 콜라보레이션 하여 출시한 MBC라디오 스튜디오! MBC의 보이는 라디오를 방송하는 가든스튜디오의 디테일이 살아있어요!" /></p>
							<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러 가기" /></div>
						</div>
						<%' slide %>
						<div class="slidewrap">
							<div id="slide1" class="slide">
								<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72343/img_slide_item_01_01.jpg" alt="" /></div>
								<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72343/img_slide_item_01_02.jpg" alt="" /></div>
								<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72343/img_slide_item_01_03.jpg" alt="" /></div>
							</div>
						</div>
					</a>
				</div>
			<% set oItem = nothing %>
			<%
				IF application("Svr_Info") = "Dev" THEN
					itemid = 1239226
				Else
					itemid = 1543276
				End If
				set oItem = new CatePrdCls
					oItem.GetItemData itemid
			%>
				<div class="desc desc2">
					<a href="/shopping/category_prd.asp?itemid=1543276&amp;pEtr=71159">
						<div class="option">
							<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72343/txt_name_02.png" alt="MBC 라디오 중계차 텐바이텐 단독 선오픈" /></p>
					<%' for dev msg : 상품코드 1543276 할인 중 %>
					<% If oItem.FResultCount > 0 Then %>
						<% IF (oItem.Prd.FItemCouponYN="Y") THEN  %>
							<div class="price">
							<% If oitem.Prd.isCouponItem Then %>
								<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/txt_only_tenten_10percent_coupon.png" alt="텐바이텐에서 ONLY 10%" /></strong>
								<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
								<strong><%= FormatNumber(oItem.Prd.GetCouponAssignPrice,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
							<% Else %>
								<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
							<% End If %>
							</div>
						<% Else %>
						<%' for dev msg : 할인 전 / 종료후 %>
							<div class="price priceEnd">
								<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
							</div>
						<% End If %>
					<% End If %>
							<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72343/txt_substance_02.png" alt="MBC와 옥스포드가 콜라보레이션 하여 출시한 MBC라디오 중계차 블럭! MBC의 보이는 라디오를 방송하는 야외 라디오 스튜디오의 디테일이 살아있어요!" /></p>
							<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러 가기" /></div>
						</div>
						<%' slide %>
						<div class="slidewrap">
							<div id="slide2" class="slide">
								<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72343/img_slide_item_02_01.jpg" alt="" /></div>
								<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72343/img_slide_item_02_02.jpg" alt="" /></div>
								<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72343/img_slide_item_02_03.jpg" alt="" /></div>
							</div>
						</div>
					</a>
				</div>
			<% set oItem = nothing %>
			<%
				IF application("Svr_Info") = "Dev" THEN
					itemid = 1239226
				Else
					itemid = 1543275
				End If
				set oItem = new CatePrdCls
					oItem.GetItemData itemid
			%>
				<div class="desc desc3">
					<a href="/shopping/category_prd.asp?itemid=1543275&amp;pEtr=71159">
						<div class="option">
							<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72343/txt_name_03.png" alt="MBC 방송헬기 텐바이텐 온라인몰 단독 판매!" /></p>
					<%' for dev msg : 상품코드 1543275 할인 중 %>
					<% If oItem.FResultCount > 0 Then %>
						<% IF (oItem.Prd.FItemCouponYN="Y") THEN  %>
							<div class="price">
							<% If oitem.Prd.isCouponItem Then %>
								<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/txt_only_tenten_10percent_coupon.png" alt="텐바이텐에서 ONLY 10%" /></strong>
								<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
								<strong><%= FormatNumber(oItem.Prd.GetCouponAssignPrice,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
							<% Else %>
								<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
							<% End If %>
							</div>
						<% Else %>
						<%' for dev msg : 할인 전 / 종료후 %>
							<div class="price priceEnd">
								<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
							</div>
						<% End If %>
					<% End If %>
							<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72343/txt_substance_03.png" alt="MBC와 옥스포드가 콜라보레이션 하여 출시한 MBC라디오 방송헬기! 전국 방방곡곡을 누비는 생동감 넘치는 MBC의 헬기를 블록으로 만나보세요!" /></p>
							<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러 가기" /></div>
						</div>
						<%' slide %>
						<div class="slidewrap">
							<div id="slide3" class="slide">
								<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72343/img_slide_item_03_01.jpg" alt="" /></div>
								<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72343/img_slide_item_03_02.jpg" alt="" /></div>
								<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72343/img_slide_item_03_03.jpg" alt="" /></div>
							</div>
						</div>
					</a>
				</div>
			<% set oItem = nothing %>
			</div>
		</div>
		<%' visual %>
		<div class="visual">
			<div class="with">
				<span><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/ico_plus.png" alt="" /></span>
			</div>
			<%' for dev msg : 금액부분 개발해주세요 %>
			<div id="slider" class="slider-horizontal">
			<%
				IF application("Svr_Info") = "Dev" THEN
					itemid = 786868
				Else
					itemid = 1543295
				End If
				set oItem = new CatePrdCls
					oItem.GetItemData itemid
			%>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1543295&amp;pEtr=72343" style="padding-left:10px;">
						<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72343/img_item_visual_01.png" alt="" />
						<span class="name">엠빅 세라믹 머그컵 2종</span>
					<% If oItem.FResultCount > 0 Then %>
						<span class="price"><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></span>
					<% End If %>
					</a>
				</div>
			<%
				set oItem = nothing
				IF application("Svr_Info") = "Dev" THEN
					itemid = 786868
				Else
					itemid = 1543286
				End If
				set oItem = new CatePrdCls
					oItem.GetItemData itemid
			%>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1543286&amp;pEtr=72343">
						<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72343/img_item_visual_02.png" alt="" />
						<span class="name">엠빅 비치볼</span>
					<% If oItem.FResultCount > 0 Then %>
						<span class="price"><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></span>
					<% End If %>
					</a>
				</div>
			<%
				set oItem = nothing
				IF application("Svr_Info") = "Dev" THEN
					itemid = 786868
				Else
					itemid = 1543284
				End If
				set oItem = new CatePrdCls
					oItem.GetItemData itemid
			%>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1543284&amp;pEtr=72343">
						<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72343/img_item_visual_03.png" alt="" />
						<span class="name">MBC 엽서세트</span>
					<% If oItem.FResultCount > 0 Then %>
						<span class="price"><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></span>
					<% End If %>
					</a>
				</div>
			<%
				set oItem = nothing
				IF application("Svr_Info") = "Dev" THEN
					itemid = 786868
				Else
					itemid = 1543282
				End If
				set oItem = new CatePrdCls
					oItem.GetItemData itemid
			%>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1543282&amp;pEtr=72343">
						<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72343/img_item_visual_04.png" alt="" />
						<span class="name">엠빅 마이크 인형 2종</span>
					<% If oItem.FResultCount > 0 Then %>
						<span class="price"><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></span>
					<% End If %>
					</a>
				</div>
			<%
				set oItem = nothing
				IF application("Svr_Info") = "Dev" THEN
					itemid = 786868
				Else
					itemid = 1543285
				End If
				set oItem = new CatePrdCls
					oItem.GetItemData itemid
			%>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1543285&amp;pEtr=72343">
						<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72343/img_item_visual_05.png" alt="" />
						<span class="name">MBC 양말세트</span>
					<% If oItem.FResultCount > 0 Then %>
						<span class="price"><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></span>
					<% End If %>
					</a>
				</div>
			<%
				set oItem = nothing
				IF application("Svr_Info") = "Dev" THEN
					itemid = 786868
				Else
					itemid = 1543278
				End If
				set oItem = new CatePrdCls
					oItem.GetItemData itemid
			%>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1543278&amp;pEtr=72343">
						<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72343/img_item_visual_06.png" alt="" />
						<span class="name">엠빅 인형 중형</span>
					<% If oItem.FResultCount > 0 Then %>
						<span class="price"><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></span>
					<% End If %>
					</a>
				</div>
			<%
				set oItem = nothing
				IF application("Svr_Info") = "Dev" THEN
					itemid = 786868
				Else
					itemid = 1543105
				End If
				set oItem = new CatePrdCls
					oItem.GetItemData itemid
			%>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1543105&amp;pEtr=72343">
						<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72343/img_item_visual_07.png" alt="" />
						<span class="name">방송사 사람들 뱃지 6종</span>
					<% If oItem.FResultCount > 0 Then %>
						<span class="price"><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></span>
					<% End If %>
					</a>
				</div>
			<%
				set oItem = nothing
				IF application("Svr_Info") = "Dev" THEN
					itemid = 786868
				Else
					itemid = 1543277
				End If
				set oItem = new CatePrdCls
					oItem.GetItemData itemid
			%>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1543277&amp;pEtr=72343">
						<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72343/img_item_visual_08.png" alt="" />
						<span class="name">MBC 라디오 스튜디오</span>
					<% If oItem.FResultCount > 0 Then %>
						<span class="price"><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></span>
					<% End If %>
					</a>
				</div>
			<%
				set oItem = nothing
				IF application("Svr_Info") = "Dev" THEN
					itemid = 786868
				Else
					itemid = 1543276
				End If
				set oItem = new CatePrdCls
					oItem.GetItemData itemid
			%>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1543276&amp;pEtr=72343">
						<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72343/img_item_visual_09.png" alt="" />
						<span class="name">MBC 라디오 중계차</span>
					<% If oItem.FResultCount > 0 Then %>
						<span class="price"><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></span>
					<% End If %>
					</a>
				</div>
			<%
				set oItem = nothing
				IF application("Svr_Info") = "Dev" THEN
					itemid = 786868
				Else
					itemid = 1543275
				End If
				set oItem = new CatePrdCls
					oItem.GetItemData itemid
			%>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1543275&amp;pEtr=72343">
						<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72343/img_item_visual_10.png" alt="" />
						<span class="name">MBC 방송헬기</span>
					<% If oItem.FResultCount > 0 Then %>
						<span class="price"><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></span>
					<% End If %>
					</a>
				</div>
			<% set oItem = nothing %>
			</div>
		</div>
		<%' brand %>
		<div class="brand">
			<div class="logo">
				<a href="/street/street_brand_sub06.asp?makerid=mbcbrandstore" title="MBC브랜드스토어 브랜드 스트릿 페이지로으로 이동"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72343/img_logo_mbc_brand_store_white.png" alt="MBC BRAND STORE 로고" /></a>
			</div>
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72343/txt_brand.png" alt="" /></p>
			<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="MBC 브랜드 스토어는 MBC브랜드와 주요 프로그램 이미지를 활용하여 MBC의 핵심가치인 신뢰, 즐거움, 감동을 녹인 제품을 만들고 있습니다." /></div>
		</div>
		<%' video %>
		<div class="video">
			<iframe src="//player.vimeo.com/video/177529564" width="960" height="540" frameborder="0" title="MBC와 옥스포드 볼록의 콜라보레이션" webkitallowfullscreen="" mozallowfullscreen="" allowfullscreen=""></iframe>
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
									<a href="/shopping/category_prd.asp?itemid=1543277&amp;pEtr=72343"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72343/img_slide_story_01.jpg" alt="상암동의 명물로 자리 잡은 MBC라디오 가든 스튜디오! 1층 광장을 지나 정문으로 들어오는 길에 커다란 통유리창 스튜디오가 바로 가든 스튜디오입니다." /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1543277&amp;pEtr=72343"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72343/img_slide_story_02.jpg" alt="MBC라디오 스튜디오" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1543276&amp;pEtr=72343"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72343/img_slide_story_03.jpg" alt="청취자들과 눈을 마주보며 이야기를 나눌 수 있는 라디오 교류의 장 라디오 중계차! 이루마의 골든디스크, 정오의희망곡 등 프로그램이 상암 야외광장 등에서 생방, 녹화 진행 중입니다." /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1543276&amp;pEtr=72343"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72343/img_slide_story_04.jpg" alt="MBC라디오 중계차" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1543275&amp;pEtr=72343"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72343/img_slide_story_05.jpg" alt="전국 방방 곡곡을 누비며 대한민국의 생생한 이야기를 전달 하고 있는 방송 헬기! 독도 진입이 가능한 MBC헬기 답게 독도 위 헬리포트가 있어요!" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1543275&amp;pEtr=72343"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72343/img_slide_story_06.jpg" alt="MBC방송 헬기" /></a>
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
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72343/txt_finish.png" alt="MBC브랜드 스토어는 MBC브랜드의 가치를 녹인 제품을 만들고 고객과 직접 소통하고 평범한 일상속 특별한 경험을 제공합니다. 지루한 일상속에 위트있고 재미있는 공간이 되어주는 MBC브랜드 스토어" /></p>
			<div class="figure"><a href="/shopping/category_prd.asp?itemid=1543275&amp;pEtr=72343"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72343/img_item_helicopter.png" alt="MBC 방송헬기" /></a></div>
			<span class="cloud"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72343/img_cloud.png" alt="" /></span>
		</div>

		<%' comment %>
		<div class="commentevet">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72343/tit_comment.jpg" alt="Hey, something project 어떤 상품을 갖고 싶나요?" /></h3>
			<p class="hidden">MBC라디오 스튜디오, 라디오 중계차의 모티브가된 라디오! 라디오로 멋진 삼행시를 지으신 분 중 7분을 추첨하여 MBC라디오 중계차 블록 2명, 엠빅 마이크인형 2명, 엠빅인형 3명을 선정하여 드립니다. 랜덤으로 증정합니다. 코멘트 작성기간은 2016년 8월 10일부터 8월 16일까지며, 발표는 8월 17일 입니다.</p>

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
					<legend>MBC 브랜드 스토어와 옥스포드 콜라보 상품 중 가장 갖고 상품을 선택하고 라디오로 멋진 삼행시 짓기</legend>
						<ul class="choice">
							<li class="ico1"><button type="button" value="1">Garden studio</button></li>
							<li class="ico2"><button type="button" value="2">Broadcast van</button></li>
							<li class="ico3"><button type="button" value="3">Helicopter</button></li>
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
					<caption>라디오 삼행시 목록 - 상품 선택 항목, 내용, 작성일자, 아이디 정보를 제공하는 표</caption>
					<colgroup>
						<col style="width:150px;" />
						<col style="width:*;" />
						<col style="width:110px;" />
						<col style="width:120px;" />
					</colgroup>
					<thead>
					<tr>
						<th scope="col">상품 선택 항목</th>
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
										Garden studio
									<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="2" Then %>
										Broadcast van
									<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="3" Then %>
										Helicopter
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
	$("#slide1").slidesjs({
		width:"600",
		height:"550",
		pagination:false,
		navigation:false,
		play:{interval:2000, effect:"fade", auto:true},
		effect:{fade: {speed:1000, crossfade:true}}
	});
	$("#slide2").slidesjs({
		width:"600",
		height:"600",
		pagination:false,
		navigation:false,
		play:{interval:1500, effect:"fade", auto:true},
		effect:{fade: {speed:1000, crossfade:true}}
	});
	$("#slide3").slidesjs({
		width:"600",
		height:"600",
		pagination:false,
		navigation:false,
		play:{interval:2500, effect:"fade", auto:true},
		effect:{fade: {speed:1000, crossfade:true}}
	});

	$("#slider").FlowSlider({
		marginStart:0,
		marginEnd:0,
		//position:0.0,
		startPosition:0.55
	});

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
		if (scrollTop > 600) {
			itemAnimation();
		}
		if (scrollTop > 3800) {
			$(".heySomething .brand .logo").addClass("pulse");
			brandAnimation();
		}
		if (scrollTop > 6500) {
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

	/* item animation */
	$(".heySomething .item h3 .mbc").css({"left":"636px", "opacity":"0"});
	$(".heySomething .item h3 .oxford").css({"left":"394px","opacity":"0"});
	function itemAnimation() {
		$(".heySomething .item h3 .mbc").delay(200).animate({"left":"394px", "opacity":"1"},800);
		$(".heySomething .item h3 .oxford").delay(200).animate({"left":"636px", "opacity":"1"},800);
	}

	/* brand animation */
	$(".heySomething .brand p").css({"height":"10px", "opacity":"0"});
	$(".heySomething .brand .btnDown").css({"opacity":"0"});
	function brandAnimation() {
		$(".heySomething .brand p").delay(500).animate({"height":"105px", "opacity":"1"},800);
		$(".heySomething .brand .btnDown").delay(1200).animate({"opacity":"1"},1200);
	}

	/* finish animation */
	$(".heySomething .finish .figure").css({"margin-top":"50px", "margin-left":"127px", "opacity":"0"});
	function finishAnimation() {
		$(".heySomething .finish .figure").delay(100).animate({"margin-top":"0", "margin-left":"-127px", "opacity":"1"},1200);
	}
});
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->