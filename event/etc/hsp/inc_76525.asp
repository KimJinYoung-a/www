<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈
' History : 2017-03-07 김진영 생성
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
Dim oItem
Dim currenttime
	currenttime =  now()
Dim eCode

IF application("Svr_Info") = "Dev" THEN
	eCode   =  66287
Else
	eCode   =  76525
End If

Dim userid, commentcount, i

userid = GetEncLoginUserID()
commentcount = getcommentexistscount(userid, eCode, "", "", "", "Y")

Dim cEComment ,blnFull, cdl, com_egCode, bidx, blnBlogURL, strBlogURL
Dim iCTotCnt, arrCList,intCLoop, pagereload
Dim iCPageSize, iCCurrpage, isMyComm
Dim iCStartPage, iCEndPage, iCTotalPage, iCx,iCPerCnt
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
.heySomething .topic {height:778px; background-color:#414847;}
.heySomething .topic h2 {z-index:5;}
.heySomething .topic h2 span {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_hey_something_project_white.png);}
.heySomething .topic .figure {position:relative; width:100%; height:778px;}
.heySomething .topic .figure img {position:absolute; top:0; left:50%; margin-left:-951px;}

/* item */
.heySomething .itemB {width:1140px; margin:370px auto 0; padding-bottom:0; border-bottom:1px solid #ddd; background:none;}
.heySomething .itemB h3 {position:relative; height:41px; text-align:center;}
.heySomething .itemB h3 .horizontalLine1, .heySomething .item h3 .horizontalLine2 {position:absolute; top:21px; width:340px; height:1px; background-color:#ddd;}
.heySomething .itemB h3 .horizontalLine1 {left:0;}
.heySomething .itemB h3 .horizontalLine2 {right:0;}
.heySomething .itemB .desc {overflow:hidden; width:1140px; margin:80px auto 0; padding-left:0;}
.heySomething .itemB .desc .option {position:static; float:left; width:389px; padding-left:85px;}
.heySomething .itemB .slidewrap {float:left; width:666px; position:relative;}
.heySomething .itemB .slidewrap .slide {width:666px; height:430px;}
.heySomething .itemB .descB {margin-top:100px;}
.heySomething .itemB .descB .option {float:right; height:auto;}
.heySomething .item .option .substance, .heySomething .item .option .btnget {position:static;}
.heySomething .item .option .substance {margin-top:65px;}
.heySomething .item .option .btnget {margin-top:30px;}
.heySomething .item .line {width:980px; margin:0 auto; border-top:1px dashed #cecece;}
.heySomething .itemB .slide .slidesjs-previous {left:0 !important;}
.heySomething .itemB .slide .slidesjs-next {right:0;}

/* brand */
.heySomething .brand {height:1046px; margin-top:360px;}
.heySomething .brand .figure {position:relative; width:1140px; margin:0 auto;}
.heySomething .brand .figure .bg {position:absolute; top:0; left:0; width:100%; height:100%; background-color:#000; opacity:0.4; filter:alpha(opacity=40);}
.heySomething .brand .figure p {position:absolute; top:270px; left:50%; width:509px; margin-left:-254px;}
.heySomething .brand .figure p span {display:block; width:100%; height:19px; margin-top:22px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/76525/txt_brand_01.png) 50% 0 no-repeat; text-indent:-9999em;}
.heySomething .brand .figure p .letter1 {margin-top:0;}
.heySomething .brand .figure p .letter2 {background-position:50% -40px;}
.heySomething .brand .figure p .letter3 {background-position:50% 100%;}
.heySomething .brand .figure + p {margin-top:74px;}

/* story */
.heySomething .story {margin-top:367px; padding-bottom:120px;}
.heySomething .story h3 {margin-bottom:70px;}
.heySomething .rolling {padding-top:165px;}
.heySomething .rolling .pagination {top:0; width:870px; margin-left:-435px;}
.heySomething .rolling .swiper-pagination-switch {width:144px; height:144px; margin:0 73px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/76525/btn_pagination_story.gif);}
.heySomething .rolling .pagination span.swiper-active-switch {background-position:0 100%;}
.heySomething .rolling .pagination span:first-child + span {background-position:-290px 0;}
.heySomething .rolling .pagination span:first-child + span.swiper-active-switch {background-position:-290px 100%;}
.heySomething .rolling .pagination span:first-child + span + span {background-position:100% 0;}
.heySomething .rolling .pagination span:first-child + span + span.swiper-active-switch {background-position:100% 100%;}
.heySomething .rolling .pagination span em {bottom:-771px; left:50%;height:120px; width:980px; margin-left:-490px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/76525/txt_story_desc.gif); cursor:default;}
.heySomething .rolling .pagination span .desc2 {background-position:0 -120px;}
.heySomething .rolling .pagination span .desc3 {background-position:0 -240px;}
.heySomething .rolling .pagination span .desc4 {background-position:0 -360px;}
.heySomething .rolling .btn-nav {top:476px;}
.heySomething .swipemask {top:165px;}
.heySomething .mask-left {margin-left:-1470px;}
.heySomething .mask-right {margin-left:490px;}

/* finish */
.heySomething .finish {background-color:#54575e; height:823px; margin-top:378px;}
.heySomething .finish .figure {position:absolute; top:0; left:50%; margin-left:-951px;}

/* comment */
.heySomething .commentevet {margin-top:298px;}
.heySomething .commentevet .form {margin-top:20px;}
.heySomething .commentevet .form .choice li {width:118px; height:119px; margin-right:7px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/76525/img_comment_ico.gif); background-position:0 0;}
.heySomething .commentevet .form .choice li.ico1 button.on {background-position:0 100%;}
.heySomething .commentevet .form .choice li.ico2 button {background-position:-125px 0;}
.heySomething .commentevet .form .choice li.ico2 button.on {background-position:-125px 100%;}
.heySomething .commentevet .form .choice li.ico3 button {background-position:100% 0;}
.heySomething .commentevet .form .choice li.ico3 button.on {background-position:100% 100%;}
.heySomething .commentevet textarea {margin-top:15px;}
.heySomething .commentlist table td strong {width:118px; height:119px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/76525/img_comment_ico.gif); background-position:0 0;}
.heySomething .commentlist table td strong.ico2 {background-position:-125px 0;}
.heySomething .commentlist table td strong.ico3 {background-position:100% 0;}
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
		<% If not( left(currenttime,10)>="2017-03-07" and left(currenttime,10)<="2017-03-14" ) Then %>
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
				<a href="/shopping/category_prd.asp?itemid=1659068&pEtr=76525"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76525/img_item_represent.jpg" alt="슈퍼스무디 시크릿블랙" /></a>
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
					<span class="logo"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76525/img_logo_intake_tenten.gif" alt="인테이크 and 텐바이텐" /></span>
					<span class="horizontalLine1"></span>
					<span class="horizontalLine2"></span>
				</h3>
				<div class="desc descA">
				<%' 상품 이름, 가격, 구매하기 %>
					<div class="option">
						<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76525/txt_name_01.gif" alt="슈퍼스무디 시크릿 블랙 30g 14팩 + 쉐이커" /></p>
				<%' for dev msg : 상품코드 1659068 할인기간 2017.03.08 ~ 03.14 할인기간이 지나면 <strong class="discount">...</strong> 숨겨주세요 %>
				<%
					IF application("Svr_Info") = "Dev" THEN
						itemid = 1239226
					Else
						itemid = 1659068
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
				%>
				<% If oItem.FResultCount > 0 Then %>
					<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
						<div class="price">
						<% If not( left(currenttime,10)>="2017-03-08" and left(currenttime,10)<"2017-03-14" ) Then %>
						<% else %>
							<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/txt_only_23percent.png" alt="단, 일주일만 ONLY 23%" /></strong>
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
						<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76525/txt_substance.gif" alt="100kcal 가벼운 한 끼 12가지 슈퍼푸드와 다양한 영양소를 한 곳에 담아 영양밸런스까지 맞춘 슈퍼 스무디" /></p>
						<div class="btnget"><a href="/shopping/category_prd.asp?itemid=1659068&pEtr=76525"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt=" 구매하러 가기" /></a></div>
					</div>

					<%' slide %>
					<div class="slidewrap">
						<div id="slide01" class="slide">
							<div><a href="/shopping/category_prd.asp?itemid=1659068&pEtr=76525"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76525/img_slide_item_01_01.jpg" alt="슈퍼 스무디" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1659068&pEtr=76525"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76525/img_slide_item_01_02.jpg" alt="쉐이커" /></a></div>
						</div>
					</div>
				</div>

				<div class="line"></div>

				<div class="desc descB">
				<%' 상품 이름, 가격, 구매하기 %>
					<div class="option">
						<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76525/txt_name_02.gif" alt="슈퍼스무디 시크릿 블랙 3개월 패키지 + 체중계" /></p>
				<%' for dev msg : 상품코드 1659069 할인기간 2017.03.08 ~ 03.14 할인기간이 지나면 <strong class="discount">...</strong> 숨겨주세요 %>
				<%
					IF application("Svr_Info") = "Dev" THEN
						itemid = 1239226
					Else
						itemid = 1659069
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
				%>
				<% If oItem.FResultCount > 0 Then %>
					<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
						<div class="price">
						<% If not( left(currenttime,10)>="2017-03-08" and left(currenttime,10)<"2017-03-14" ) Then %>
						<% else %>
							<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/txt_only_38percent.png" alt="단, 일주일만 ONLY 38%" /></strong>
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
						<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76525/txt_substance.gif" alt="100kcal 가벼운 한 끼 12가지 슈퍼푸드와 다양한 영양소를 한 곳에 담아 영양밸런스까지 맞춘 슈퍼 스무디" /></p>
						<div class="btnget"><a href="/shopping/category_prd.asp?itemid=1659069&pEtr=76525"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt=" 구매하러 가기" /></a></div>
					</div>

					<%' slide %>
					<div class="slidewrap">
						<div id="slide02" class="slide">
							<div><a href="/shopping/category_prd.asp?itemid=1659069&pEtr=76525"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76525/img_slide_item_02_01.jpg" alt="슈퍼 스무디" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1659069&pEtr=76525"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76525/img_slide_item_02_02.jpg" alt="윈마이미니 체중계" /></a></div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<%' brand %>
		<div class="brand">
			<div class="figure">
				<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76525/img_brand.jpg" alt="" />
				<div class="bg"></div>
				<p>
					<span class="letter1">균형있는 영양과 함께 다이어트를 하고싶은 분에게,</span>
					<span class="letter2">간편한 한 끼로 식사를 대용하며 다이어트를 하고 싶으신 분에게.</span>
					<span class="letter3">인테이크가 선물처럼 전하는 Super smoothie secret black</span>
				</p>
			</div>
			<p><a href="/street/street_brand_sub06.asp?makerid=intakefoods" title="브랜드 스트리트로 이동"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76525/txt_brand_02.gif" alt="건강한 라이프스타일 푸드 인테이크 인테이크는 니즈, 건강, 영양, 편의, 합리, 미래지향 6가지 기준을 바탕으로 건강한 라이프스타일을 위한 식품을 설계합니다." /></a></p>
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
									<a href="/shopping/category_prd.asp?itemid=1659069&pEtr=76525"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76525/img_slide_story_01.jpg" alt="#간편한 아침 입맛 없는 아침, 위와 장이 부담스럽지 않은 식사를 찾고 계신가요? 슈퍼스무디 시크릿블랙으로 12가지 슈퍼푸드를 한번에 섭취하세요." /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1659069&pEtr=76525"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76525/img_slide_story_02.jpg" alt="#균형있는 점심 식물성 단백질, 식이섬유 4종, 비타민 8종, 미네랄 3종, 아미노산 9종으로 구성되어 영양밸런스까지 갖춘 슈퍼스무디와 함께하는 점심식사" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1659069&pEtr=76525"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76525/img_slide_story_03.jpg" alt="#가벼운 저녁 무엇보다 중요한 칼로리, 100kcal로 가벼운 식사가 가능해요. 우유 200ml와 함께해도 240kcal로 착한데다 피부에 좋은 성분도 함께 마실 수 있습니다." /></a>
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
			<a href="/shopping/category_prd.asp?itemid=1659068&pEtr=76525">
				<div class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76525/img_finish.jpg" alt="슈퍼스무디 시크릿블랙" /></div>
			</a>
		</div>
		
		<%' comment %>
		<div class="commentevet">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76525/tit_comment.gif" alt="Hey, something project 아무도 모르게, 시크릿 다이어트" /></h3>
			<p class="hidden">갈수록 따뜻해지는 날씨에 얇아지는 옷깃, 여름을 두려워하고 계신가요? 매일 결심만 하던 다이어트, 식욕을 가장 참기 힘들어 슈퍼스무디가 꼭 필요한 시간을 알려주세요. 정성껏 코멘트를 남겨주신 3분을 추첨하여 슈퍼스무디 블랙시크릿 1box을 선물로 드립니다. 코멘트 작성기간은 2017년 3월 8일부터 3월 14일까지며, 발표는 3월 16일 입니다.</p>
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
							<li class="ico1"><button type="button" value="1">간편한 아침</button></li>
							<li class="ico2"><button type="button" value="2">균형있는 점심</button></li>
							<li class="ico3"><button type="button" value="3">가벼운 저녁</button></li>
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
												간편한 아침
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="2" then %>
												균형있는 점심
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="3" then %>
												가벼운 저녁
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
		width:"666",
		height:"430",
		pagination:false,
		navigation:{effect:"fade"},
		play:{interval:3000, effect:"fade", auto:true},
		effect:{fade: {speed:800, crossfade:true}}
	});

	$("#slide02").slidesjs({
		width:"666",
		height:"430",
		pagination:false,
		navigation:{effect:"fade"},
		play:{interval:3100, effect:"fade", auto:true},
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
		if (scrollTop > 2500 ) {
			brandAnimation();
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
	
	/* brand animation */
	$(".brand .figure .bg, .brand .figure p span").css({"opacity":"0"});
	$(".brand .figure p span").css({"margin-top":"35px"});
	function brandAnimation() {
		$(".brand .figure .bg").delay(0).animate({"opacity":"0.4"},800);
		$(".brand .figure p .letter1").delay(300).animate({"margin-top":"22px", "opacity":"1"},1000);
		$(".brand .figure p .letter2").delay(700).animate({"margin-top":"22px", "opacity":"1"},1000);
		$(".brand .figure p .letter3").delay(1100).animate({"margin-top":"22px", "opacity":"1"},1000);
	}
});
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->