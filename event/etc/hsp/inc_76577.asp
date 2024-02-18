<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈
' History : 2017-03-14 원승현 생성
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
	eCode   =  66290
Else
	eCode   =  76577
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
.heySomething .topic {height:778px; background-color:#f2f1f0;}
.heySomething .topic h2 {z-index:5;}
.heySomething .topic h2 span {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_hey_something_project.png);}
.heySomething .topic .figure {position:relative; width:100%; height:778px;}
.heySomething .topic .figure img {position:absolute; top:0; left:50%; margin-left:-951px;}

/* brand */
.heySomething .brand1 {overflow:hidden; position:relative; width:780px; height:800px; margin:325px auto 0; padding:0;}
.heySomething .brand1 h3 {position:absolute; right:0; bottom:0;}
.heySomething .brand1 ul li {position:absolute;}
.heySomething .brand1 ul li.first {top:0; left:0;}
.heySomething .brand1 ul li.second {top:0; right:0;}
.heySomething .brand1 ul li.third {bottom:0; left:0;}
.heySomething .brand2 {height:1200px; margin-top:435px;}
.heySomething .brand2 .photo {overflow:hidden; width:1140px; height:651px; margin:0 auto;}
.heySomething .brand2 .logo {margin-top:85px;}
.heySomething .brand2 p {margin-top:47px;}
.heySomething .brand .btnDown {margin-top:57px;}
@keyframes pulse {
	0% {transform:scale(1.2);}
	100% {transform:scale(1);}
}
.pulse {animation-name:pulse; animation-duration:2s; animation-iteration-count:1;}

/* item */
.heySomething .itemB {width:1140px; margin:370px auto 0; padding-bottom:0; border-bottom:1px solid #ddd; background:none;}
.heySomething .itemB h3 {position:relative; height:72px; text-align:center;}
.heySomething .itemB h3 .horizontalLine1, .heySomething .item h3 .horizontalLine2 {position:absolute; top:46px; width:468px; height:1px; background-color:#ddd;}
.heySomething .itemB h3 .horizontalLine1 {left:0;}
.heySomething .itemB h3 .horizontalLine2 {right:0;}
.heySomething .itemB .desc {overflow:hidden; width:1140px; margin:75px auto 0; padding-left:0;}
.heySomething .itemB .desc .option {position:static; float:left; width:389px; padding-left:93px;}
.heySomething .itemB .slidewrap {float:left; width:623px; position:relative;}
.heySomething .itemB .slidewrap .slide {width:623px; height:483px;}
.heySomething .item .option .substance, .heySomething .item .option .btnget {position:static;}
.heySomething .item .option .substance {margin-top:65px;}
.heySomething .item .option .btnget {margin-top:30px;}
.heySomething .itemB .slidewrap .slide .slidesjs-navigation {margin-top:-45px;}
.heySomething .itemB .slide .slidesjs-previous {left:-23px !important;}
.heySomething .itemB .slide .slidesjs-next {right:-23px !important;;}
.heySomething .itemB h4 {margin-top:40px;}
.heySomething .itemB .with {width:1140px; margin:80px 0 85px; border:none; text-align:center;}
.heySomething .itemB .with ul {width:1100px; height:265px; margin:0 auto;}
.heySomething .itemB .with ul li {float:left; width:33.33%; margin:60px auto 0; text-align:center;}
.heySomething .itemB .with ul li .itemImg {display:block;}
.heySomething .itemB .with ul li .itemName {display:inline-block; margin-top:16px; line-height:11px; color:#777777;}
.heySomething .itemB .with ul li strong {color:#777777;}

/* story */
.heySomething .story {margin-top:251px;}
.heySomething .story h3 {margin-bottom:70px;}
.heySomething .rolling {padding-top:165px;}
.heySomething .rolling .pagination {top:0; width:895px; margin-left:-447px;}
.heySomething .rolling .swiper-pagination-switch {width:125px; height:125px; margin:0 27px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/76577/btn_pagination_story.png);}
.heySomething .rolling .pagination span.swiper-active-switch {background-position:0 100%;}
.heySomething .rolling .pagination span:first-child + span {background-position:-180px 0;}
.heySomething .rolling .pagination span:first-child + span.swiper-active-switch {background-position:-180px 100%;}
.heySomething .rolling .pagination span:first-child + span + span {background-position:-360px 0;}
.heySomething .rolling .pagination span:first-child + span + span.swiper-active-switch {background-position:-360px 100%;}
.heySomething .rolling .pagination span:first-child + span + span + span {background-position:-540px 0;}
.heySomething .rolling .pagination span:first-child + span + span + span.swiper-active-switch {background-position:-540px 100%;}
.heySomething .rolling .pagination span:first-child + span + span + span + span {background-position:100% 0;}
.heySomething .rolling .pagination span:first-child + span + span + span + span.swiper-active-switch {background-position:100% 100%;}
.heySomething .rolling .pagination span em {bottom:-744px; left:50%;height:41px; width:980px; margin-left:-490px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/76577/txt_story_desc.png); cursor:default;}
.heySomething .rolling .pagination span .desc2 {background-position:0 -41px;}
.heySomething .rolling .pagination span .desc3 {background-position:0 -82px;}
.heySomething .rolling .pagination span .desc4 {background-position:0 -123px;}
.heySomething .rolling .pagination span .desc5 {background-position:0 100%;}
.heySomething .rolling .btn-nav {top:476px;}
.heySomething .swipemask {top:165px;}
.heySomething .mask-left {margin-left:-1470px;}
.heySomething .mask-right {margin-left:490px;}

/* finish */
.heySomething .finish {background-color:#ddf1ee; height:823px; margin-top:420px;}
.heySomething .finish .figure {position:absolute; top:0; left:50%; margin-left:-951px;}

/* comment */
.heySomething .commentevet {margin-top:298px;}
.heySomething .commentevet .form {margin-top:25px;}
.heySomething .commentevet .form .choice li {width:108px; height:108px; margin-right:30px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/76577/img_comment_ico.png); background-position:0 0;}
.heySomething .commentevet .form .choice li.ico1 button.on {background-position:0 100%;}
.heySomething .commentevet .form .choice li.ico2 button {background-position:-138px 0;}
.heySomething .commentevet .form .choice li.ico2 button.on {background-position:-138px 100%;}
.heySomething .commentevet .form .choice li.ico3 button {background-position:-277px 0;}
.heySomething .commentevet .form .choice li.ico3 button.on {background-position:-277px 100%;}
.heySomething .commentevet .form .choice li.ico4 button {background-position:-415px 0;}
.heySomething .commentevet .form .choice li.ico4 button.on {background-position:-415px 100%;}
.heySomething .commentevet .form .choice li.ico5 button {background-position:100% 0;}
.heySomething .commentevet .form .choice li.ico5 button.on {background-position:100% 100%;}
.heySomething .commentevet textarea {margin-top:22px;}
.heySomething .commentlist table td {padding:20px 0;}
.heySomething .commentlist table td strong {width:108px; height:108px; margin-left:6px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/76577/img_comment_ico.png); background-position:0 0;}
.heySomething .commentlist table td strong.ico2 {background-position:-138px 0;}
.heySomething .commentlist table td strong.ico3 {background-position:-277px 0;}
.heySomething .commentlist table td strong.ico4 {background-position:-415px 0;}
.heySomething .commentlist table td strong.ico5 {background-position:100% 0;}
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
		<% If not( left(currenttime,10)>="2017-03-14" and left(currenttime,10)<"2017-03-23" ) Then %>
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
				<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76577/img_item_represent.jpg" alt="FILO PEBBLE COLLECTION" />
			</div>
		</div>

		<%' about %>
		<div class="about">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
			<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
		</div>

		<%' brand1 %>
		<div class="brand brand1">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76577/img_brand_logo.jpg" alt="filo" /></h3>
			<ul>
				<li class="first"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76577/img_brand_01.jpg" />
				<li class="second"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76577/img_brand_02.jpg" /></li>
				<li class="third"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76577/img_brand_03.jpg" /></li>
			</ul>
		</div>

		<%' brand2 %>
		<div class="brand brand2">
			<div class="photo"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76577/img_brand_04.jpg" alt="" /></div>
			<div class="logo"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76577/img_logo_filo.png" alt="filo" /></div>
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76577/txt_brand_filo.png" alt="색다른 현대적 접근으로 편안하고 의미있는 디자인을 생각하는 프리미엄 쿠션 브랜드 우리의 일상 중 '기대고, 베고, 앉는' 가장 편안한 순간을 위해 컬렉션마다 디자이너와 함께 새로운 쿠션을 기획합니다. 필로의 모든 모델은 4-6개의 입체 패턴이 사용되며 공정은 100% 핸드메이드 방식으로 제작됩니다." /></p>
			<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="아래로" /></div>
		</div>

		<%' item %>
		<div class="item itemB">
			<div class="inner">
				<h3>
					<span class="logo"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76577/img_logo_filo_02.png" alt="filo" /></span>
					<span class="horizontalLine1"></span>
					<span class="horizontalLine2"></span>
				</h3>
				<div class="desc descA">
					<%' 상품 이름, 가격, 구매하기 %>
					<div class="option">
						<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76577/txt_prd_name.png" alt="Filo Pebble CollectionAmber(xs)" /></p>
						<%'' for dev msg : 상품코드 1661501, 할인기간 2017.03.15 ~ 03.22 할인기간이 지나면  <strong class="discount">...</strong> 숨겨주세요 %>
						<%
							IF application("Svr_Info") = "Dev" THEN
								itemid = 1239226
							Else
								itemid = 1661501
							End If
							set oItem = new CatePrdCls
								oItem.GetItemData itemid
						%>

						<% If oItem.FResultCount > 0 Then %>
							<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
								<div class="price">
									<% If not( left(currenttime,10)>="2017-03-15" and left(currenttime,10)<"2017-03-23" ) Then %>
									<% else %>
										<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/txt_only_10percent.png" alt="단, 일주일만 ONLY 10%" /></strong>
										<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
									<% end if %>
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								</div>
							<% else %>
								<div class="price priceEnd">
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								</div>
							<% End If %>
						<% End If %>
						<%	set oItem = nothing %>
						<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76577/txt_substance.png" alt="당신의 기대고, 베고, 앉는 순간을 가장 편안하게 해 줄 필로 페블 컬렉션" /></p>
						<div class="btnget"><a href="/shopping/category_prd.asp?itemid=1661501&pEtr=76577"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러 가기" /></a></div>
					</div>


					<%' slide %>
					<div class="slidewrap">
						<div id="slide01" class="slide">
							<div><a href="/shopping/category_prd.asp?itemid=1661501&pEtr=76577"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76577/img_slide_01.jpg" alt="filo Amber 필로 앰버 돌멩이쿠션/쿠션 (XS) gray" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1661501&pEtr=76577"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76577/img_slide_02.jpg" alt="filo Amber 필로 앰버 돌멩이쿠션/쿠션 (XS) pink beige" /></a></div>
						</div>
					</div>

					<%' with %>
					<div class="with">
						<span><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/ico_plus.png" alt=""></span>
						<h4><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76577/txt_prd_set.png" alt="pebble collection set"></h4>
						<ul>
							<li>
								<a href="/shopping/category_prd.asp?itemid=1662835&amp;pEtr=76577">
									<span class="itemImg"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76577/img_with_item_01.jpg" alt="filo Trio Set [3ea]" /></span>
									<span class="itemName">filo Trio Set [3ea]</span>
									<%
										IF application("Svr_Info") = "Dev" THEN
											itemid = 1239226
										Else
											itemid = 1662835
										End If
										set oItem = new CatePrdCls
											oItem.GetItemData itemid
									%>
									<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
										<% If not( left(currenttime,10)>="2017-03-15" and left(currenttime,10)<"2017-03-23" ) Then %>
										<% else %>
											<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> <em style="color:#d50c0c">[20%]</em> </strong>
										<% End If %>
									<% else %>
										<%' for dev msg : 할인기간 종료후 %>
										<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
									<% End If %>
									<%	set oItem = nothing %>
								</a>
							</li>
							<li>
								<a href="/shopping/category_prd.asp?itemid=1662837&amp;pEtr=76577">
									<span class="itemImg"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76577/img_with_item_02.jpg" alt="filo Family Set [5ea]" /></span>
									<span class="itemName">filo Family Set [5ea]</span>
									<%
										IF application("Svr_Info") = "Dev" THEN
											itemid = 1239226
										Else
											itemid = 1662837
										End If
										set oItem = new CatePrdCls
											oItem.GetItemData itemid
									%>
									<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
										<% If not( left(currenttime,10)>="2017-03-15" and left(currenttime,10)<"2017-03-23" ) Then %>
										<% else %>
											<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> <em style="color:#d50c0c">[20%]</em> </strong>
										<% End If %>
									<% else %>
										<%' for dev msg : 할인기간 종료후 %>									
										<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
									<% End If %>
									<%	set oItem = nothing %>
								</a>
							</li>
							<li>
								<a href="/shopping/category_prd.asp?itemid=1662836&amp;pEtr=76577">
									<span class="itemImg"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76577/img_with_item_03.jpg" alt="filo Quartet Set [4ea]" /></span>
									<span class="itemName">filo Quartet Set [4ea]</span>
									<%
										IF application("Svr_Info") = "Dev" THEN
											itemid = 1239226
										Else
											itemid = 1662836
										End If
										set oItem = new CatePrdCls
											oItem.GetItemData itemid
									%>
									<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
										<% If not( left(currenttime,10)>="2017-03-15" and left(currenttime,10)<"2017-03-23" ) Then %>
										<% else %>
											<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> <em style="color:#d50c0c">[20%]</em> </strong>
										<% End If %>
									<% else %>
										<%' for dev msg : 할인기간 종료후 %>									
										<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
									<% End If %>
									<%	set oItem = nothing %>
								</a>
							</li>
						</ul>
					</div>
				</div>
			</div>
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
									<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76577/img_slide_story_01.jpg" alt="Relax" usemap="#storyMap1"/>
								</div>
								<div class="swiper-slide">
									<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76577/img_slide_story_02.jpg" alt="homedeco" usemap="#storyMap2"/>
								</div>
								<div class="swiper-slide">
									<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76577/img_slide_story_03.jpg" alt="comfort" usemap="#storyMap3"/>
								</div>
								<div class="swiper-slide">
									<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76577/img_slide_story_04.jpg" alt="nature" usemap="#storyMap4"/>
								</div>
								<div class="swiper-slide">
									<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76577/img_slide_story_05.jpg" alt="together" usemap="#storyMap5"/>
								</div>
							</div>
						</div>
					</div>
					<div class="pagination"></div>
				</div>
			</div>
			<map name="storyMap1" id="storyMap1">
				<area shape="rect" coords="241,85,523,564" href="/shopping/category_prd.asp?itemid=1659858&pEtr=76577" onfocus="this.blur();" alt="filo Boulder 필로 보울더 돌멩이쿠션/1인용소파/쿠션 (L)">
				<area shape="rect" coords="749,165,975,447" href="/shopping/category_prd.asp?itemid=1661503&pEtr=76577" onfocus="this.blur();" alt="filo May 필로 메이 돌멩이쿠션/쿠션 (S)">
			</map>
			<map name="storyMap2" id="storyMap2">
				<area shape="rect" coords="164,224,341,344" href="/shopping/category_prd.asp?itemid=1661502&pEtr=76577" onfocus="this.blur();" alt="filo Copper 필로 코퍼 돌멩이쿠션/쿠션 (M)">
				<area shape="rect" coords="527,229,676,342" href="/shopping/category_prd.asp?itemid=1661501&pEtr=76577" onfocus="this.blur();" alt="filo Amber 필로 앰버 돌멩이쿠션/쿠션 (XS)">
				<area shape="rect" coords="226,383,457,548" href="/shopping/category_prd.asp?itemid=1659862&pEtr=76577" onfocus="this.blur();" alt="filo Lava 필로 라바 돌멩이쿠션/1인용소파/쿠션 (XL)">
				<area shape="rect" coords="599,462,753,577" href="/shopping/category_prd.asp?itemid=1661503&pEtr=76577" onfocus="this.blur();" alt="filo May 필로 메이 돌멩이쿠션/쿠션 (S)">
				<area shape="rect" coords="774,331,936,490" href="/shopping/category_prd.asp?itemid=1659858&pEtr=76577" onfocus="this.blur();" alt="filo Boulder 필로 보울더 돌멩이쿠션/1인용소파/쿠션 (L)">
			</map>
			<map name="storyMap3" id="storyMap3">
				<area shape="rect" coords="342,286,684,568" href="/shopping/category_prd.asp?itemid=1661503&pEtr=76577" onfocus="this.blur();" alt="filo May 필로 메이 돌멩이쿠션/쿠션 (S)">
			</map>
			<map name="storyMap4" id="storyMap4">
				<area shape="rect" coords="139,299,310,427" href="/shopping/category_prd.asp?itemid=1661501&pEtr=76577" onfocus="this.blur();" alt="filo Amber 필로 앰버 돌멩이쿠션/쿠션 (XS)">
				<area shape="rect" coords="374,361,704,560" href="/shopping/category_prd.asp?itemid=1659858&pEtr=76577" onfocus="this.blur();" alt="filo Boulder 필로 보울더 돌멩이쿠션/1인용소파/쿠션 (L)">
				<area shape="rect" coords="660,185,902,333" href="/shopping/category_prd.asp?itemid=1659862&pEtr=76577" onfocus="this.blur();" alt="filo Lava 필로 라바 돌멩이쿠션/1인용소파/쿠션 (XL)">
			</map>
			<map name="storyMap5" id="storyMap5">
				<area shape="rect" coords="260,373,655,596" href="/shopping/category_prd.asp?itemid=1659858&pEtr=76577" onfocus="this.blur();" alt=" filo Copper 필로 코퍼 돌멩이쿠션/쿠션 (M-Pink)">
			</map>
		</div>

		<%' finish %>
		<div class="finish">
			<div class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76577/img_finish.jpg" alt="" /></div>
		</div>

		<%' comment %>
		<div class="commentevet">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76577/tit_comment.png" alt="Hey, something project 가장 편안한 순간을 함께" /></h3>
			<p class="hidden">필로의 페블쿠션을 어떤 용도로 사용하고 싶으신가요? 정성껏 코멘트를 남겨주신 3분을 추첨하여 필로 페블 쿠션을 선물로 드립니다! (컬러/사이즈 랜덤) 코멘트 작성기간은 2017년 3월 15일부터 3월 22일까지며, 발표는 3월 22일 입니다.</p>
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
							<li class="ico1"><button type="button" value="1">RELAX</button></li>
							<li class="ico2"><button type="button" value="2">HOME DECO</button></li>
							<li class="ico3"><button type="button" value="3">COMPORT</button></li>
							<li class="ico4"><button type="button" value="4">NATURE</button></li>
							<li class="ico5"><button type="button" value="5">TOGETHER</button></li>
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
												RELAX
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="2" then %>
												HOME DECO
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="3" then %>
												COMPORT
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="4" then %>
												NATURE
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="5" then %>
												TOGETHER
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
		width:"623",
		height:"483",
		pagination:false,
		navigation:{effect:"fade"},
		play:{interval:3000, effect:"fade", auto:true},
		effect:{fade: {speed:800, crossfade:true}}
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

	$('#rolling .pagination span:nth-child(1)').append('<em class="desc1"></em>');
	$('#rolling .pagination span:nth-child(2)').append('<em class="desc2"></em>');
	$('#rolling .pagination span:nth-child(3)').append('<em class="desc3"></em>');
	$('#rolling .pagination span:nth-child(4)').append('<em class="desc4"></em>');
	$('#rolling .pagination span:nth-child(5)').append('<em class="desc5"></em>');

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
		if (scrollTop > 1100 ) {
			brandAnimation1();
		}
		if (scrollTop > 2000 ) {
			$(".heySomething .brand2 .photo img").addClass("pulse");
		}
		if (scrollTop > 6000 ) {
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

	/* brand animation1 */
	$(".heySomething .brand1 h3").css({"bottom":"-20px", "right":"-20px", "opacity":"0"});
	$(".heySomething .brand1 ul li.first").css({"top":"-20px", "left":"-20px", "opacity":"0"});
	$(".heySomething .brand1 ul li.second").css({"top":"-20px", "right":"-20px", "opacity":"0"});
	$(".heySomething .brand1 ul li.third").css({"bottom":"-20px", "left":"-20px", "opacity":"0"});
	function brandAnimation1() {
		$(".heySomething .brand1 h3").delay(100).animate({"bottom":"0", "right":"0", "opacity":"1"},700);
		$(".heySomething .brand1 ul li.first").delay(100).animate({"top":"0", "left":"0", "opacity":"1"},700);
		$(".heySomething .brand1 ul li.second").delay(100).animate({"top":"0", "right":"0", "opacity":"1"},700);
		$(".heySomething .brand1 ul li.third").delay(100).animate({"bottom":"0", "left":"0", "opacity":"1"},700);
	}

	/* finish animation */
	$(".heySomething .finish .figure img").css({"opacity":"0"});
	function finishAnimation() {
		$(".heySomething .finish .figure img").delay(100).animate({"opacity":"1"},1200);
	}
});

</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->