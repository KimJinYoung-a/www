<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈 42
' History : 2016-08-01 김진영 생성
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
	eCode   =  66177
Else
	eCode   =  72182
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
.heySomething .topic {background-color:#e8e8ea;}
.heySomething .topic h2 {top:53px; z-index:5; width:365px; height:193px; margin-left:-534px; padding-top:4px; padding-left:12px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/72182/bg_white.png);}
.heySomething .topic h2 .letter2 {margin-top:9px;}
.heySomething .topic h2 .letter3 {margin-top:9px;}

.heySomething .topic .figure a {display:block; position:relative; width:100%; height:780px;}
.heySomething .topic .figure img {position:absolute; top:0; left:50%; margin-left:-951px;}

/* gallery */
.heySomething .gallery {margin-top:395px;}
.heySomething .gallery ul {position:relative; width:740px; height:554px; margin:0 auto;}
.heySomething .gallery ul li {overflow:hidden; position:absolute; width:364px; height:332px;}
.heySomething .gallery ul li.gallery1 {top:0; left:0;}
.heySomething .gallery ul li.gallery2 {top:0; right:0; height:210px;}
.heySomething .gallery ul li.gallery3 {bottom:0; left:0; height:210px;}
.heySomething .gallery ul li.gallery4 {right:0; bottom:0;}
.heySomething .gallery ul li a {overflow:hidden; display:block; width:100%; height:100%; background-color:#f9f9f9;}
.heySomething .gallery ul li a .off {display:block; overflow:hidden;}
.heySomething .gallery ul li .on {overflow:hidden; position:absolute; top:0; left:0; width:100%; height:0; background-color:#f9f9f9; opacity:0; filter:alpha(opacity=0); transition:opacity 0.1s linear;}
.heySomething .gallery ul li .on img {position:absolute; top:50%; left:50%; margin:-110px 0 0 -69px; transition:all 0.7s;}
.heySomething .gallery ul li.gallery2 .on img {margin:-60px 0 0 -131px;}
.heySomething .gallery ul li.gallery3 .on img {margin:-60px 0 0 -84px;}
.heySomething .gallery ul li.gallery4 .on img {margin:-150px 0 0 -59px;}
.heySomething .gallery ul li.gallery1 a:hover .on img {margin:-128px 0 0 -69px;}
.heySomething .gallery ul li.gallery2 a:hover .on img {margin:-55px 0 0 -131px;}
.heySomething .gallery ul li.gallery3 a:hover .on img {margin:-67px 0 0 -84px;}
.heySomething .gallery ul li.gallery4 a:hover .on img {margin:-122px 0 0 -59px;}
.heySomething .gallery ul li a:hover .on {height:100%; opacity:1; filter:alpha(opacity=100); cursor:pointer;}

.heySomething .gallery ul li:nth-of-type(2) {animation-delay:0.1s;}
.heySomething .gallery ul li:nth-of-type(3) {animation-delay:0.2s;}
.heySomething .gallery ul li:nth-of-type(4) {animation-delay:0.3s;}

@keyframes fadeInSlideUp {
	0% {opacity:0; transform:translateY(50px);}
	100% {opacity:1;}
}
.fadeInSlideUp{opacity:0; animation:fadeInSlideUp 1s cubic-bezier(0.2, 0.3, 0.25, 0.9) forwards;}

.pulse {animation-name:pulse; animation-duration:2s; animation-iteration-count:1;}
@keyframes pulse {
	0% {transform:scale(1.1);}
	100% {transform:scale(1);}
}

/* item */
.heySomething .itemB {margin-top:350px; padding-bottom:0; background:none;}
.heySomething .item h3 {position:relative; height:126px; text-align:center;}
.heySomething .item h3 .horizontalLine1,
.heySomething .item h3 .horizontalLine2 {position:absolute; top:73px; width:462px; height:1px; background-color:#ddd;}
.heySomething .item h3 .horizontalLine1 {left:0;}
.heySomething .item h3 .horizontalLine2 {right:0;}
.heySomething .item .desc {min-height:486px;}
.heySomething .itemB .desc .option {height:367px;}
.heySomething .itemB .slidewrap {position:absolute; top:0; right:0; width:1140px; height:486px;}
.heySomething .itemB .slidewrap .slide {width:1140px;}
.heySomething .itemB .slidewrap .slidesjs-slide {position:relative; text-align:right;}
.heySomething .itemB .slidewrap .slidesjs-slide .btnget {position:absolute; top:397px; left:82px;}
.heySomething .itemB .slidewrap .slide .slidesjs-previous {left:485px;}
.heySomething .itemB .slidewrap .slide .slidesjs-next {right:76px;}
.heySomething .item .with {margin-top:48px; border:none;}
.heySomething .item .with span {position:relative; z-index:5;}
.heySomething .item .with {padding-bottom:66px; text-align:center;}
.heySomething .item .with ul {overflow:hidden; width:1020px; margin:40px auto 0;}
.heySomething .item .with ul li {float:left; width:180px; margin:0 12px;}
.heySomething .item .with ul li a {display:block; color:#777; font-size:11px;}
.heySomething .item .with ul li span {display:block; margin-top:10px;}

/* visual */
.heySomething .visual {margin-top:475px;}
.heySomething .visual .figure {position:relative; height:881px; background-color:#010101;}
.heySomething .visual .figure img {position:absolute; top:0; left:50%; margin-left:-951px;}

/* brand */
.heySomething .brand {position:relative; height:445px; margin-top:320px;}
.heySomething .brand p {margin-top:50px;}

/* story */
.heySomething .story {margin-top:420px; padding-bottom:120px;}
.heySomething .rolling {padding-top:202px;}
.heySomething .rolling .swiper .swiper-slide {padding:0;}
.heySomething .rolling .pagination {top:0; width:844px; margin-left:-422px;}
.heySomething .rolling .swiper-pagination-switch {width:141px; height:165px; margin:0 35px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/72182/btn_pagination.png);}
.heySomething .rolling .pagination span.swiper-active-switch {background-position:0 100%;}
.heySomething .rolling .pagination span:first-child + span {background-position:-212px 0;}
.heySomething .rolling .pagination span:first-child + span.swiper-active-switch {background-position:-212px 100%;}
.heySomething .rolling .pagination span:first-child + span + span {background-position:-423px 0;}
.heySomething .rolling .pagination span:first-child + span + span.swiper-active-switch {background-position:-423px 100%;}
.heySomething .rolling .pagination span:first-child + span + span + span {background-position:100% 0;}
.heySomething .rolling .pagination span:first-child + span + span + span.swiper-active-switch {background-position:100% 100%;}
.heySomething .rolling .pagination span em {bottom:-787px; left:50%;height:120px; width:980px; margin-left:-490px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/72182/txt_story_desc.png); cursor:default;}
.heySomething .rolling .pagination span .desc2 {background-position:0 -120px;}
.heySomething .rolling .pagination span .desc3 {background-position:0 -240px;}
.heySomething .rolling .pagination span .desc4 {background-position:0 -360px;}
.heySomething .rolling .pagination span .desc5 {background-position:0 100%;}
.heySomething .rolling .btn-nav {top:475px;}
.heySomething .swipemask {top:202px;}
.heySomething .mask-left {margin-left:-1470px;}
.heySomething .mask-right {margin-left:490px;}

/* finish */
.heySomething .finish {background-color:#e5e4e3; height:850px; margin-top:400px;}
.heySomething .finish .figure {position:absolute; top:0; left:50%; margin-left:-951px;}
.heySomething .finish p {top:382px; margin-left:267px;}

/* comment */
.heySomething .commentevet {margin-top:370px;}
.heySomething .commentevet .form .choice li {width:131px; height:154px; margin-right:36px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/72182/img_ico.png); background-position:0 0;}
.heySomething .commentevet .form .choice li button.on {background-position:0 100%;}
.heySomething .commentevet .form .choice li.ico2 button {background-position:-167px 0;}
.heySomething .commentevet .form .choice li.ico2 button.on {background-position:-167px 100%;}
.heySomething .commentevet .form .choice li.ico3 button {background-position:-334px 0;}
.heySomething .commentevet .form .choice li.ico3 button.on {background-position:-334px 100%;}
.heySomething .commentevet .form .choice li.ico4 button {background-position:100% 0;}
.heySomething .commentevet .form .choice li.ico4 button.on {background-position:100% 100%;}

.heySomething .commentevet textarea {margin-top:40px;}

.heySomething .commentlist table td strong {width:131px; height:154px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/72182/img_ico.png); background-position:0 0;}
.heySomething .commentlist table td strong.ico2 {background-position:-167px 0;}
.heySomething .commentlist table td strong.ico3 {background-position:-334px 0;}
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
		<% If not( left(currenttime,10) >= "2016-08-01" and left(currenttime,10) <= "2016-08-09" ) Then %>
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
				<a href="/street/street_brand_sub06.asp?makerid=halfartist" title="하프아티스트 브랜드 스트리트으로 이동"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72182/img_item_represent.jpg" alt="굿모닝 굿나잇 다이아몬드 솝" /></a>
			</div>
		</div>
		<%' about %>
		<div class="about">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
			<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
		</div>
		<%' gallery %>
		<div class="gallery">
			<ul>
				<li class="gallery1">
					<a href="/shopping/category_prd.asp?itemid=1537568&amp;pEtr=72182">
						<span class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72182/img_gallery_01_off.jpg" alt="굿모닝 비누 다이아몬드 카렌듈라 샤워" /></span>
						<span class="on"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72182/img_gallery_01.png" alt="" /></span>
					</a>
				</li>
				<li class="gallery2">
					<a href="/shopping/category_prd.asp?itemid=1537564&amp;pEtr=72182">
						<span class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72182/img_gallery_02_off.jpg" alt="굿 럭 캔디비누" /></span>
						<span class="on"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72182/img_gallery_02.png" alt="" /></span>
					</a>
				</li>
				<li class="gallery3">
					<a href="/shopping/category_prd.asp?itemid=1537566&amp;pEtr=72182">
						<span class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72182/img_gallery_03_off.jpg" alt="굿나잇 비누 다이아몬드 크리미 린넨" /></span>
						<span class="on"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72182/img_gallery_03.png" alt="" /></span>
					</a>
				</li>
				<li class="gallery4">
					<a href="/shopping/category_prd.asp?itemid=1537571&amp;pEtr=72182">
						<span class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72182/img_gallery_04_off.jpg" alt="굿모닝 비누 초콜릿 프레시 밀크" /></span>
						<span class="on"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72182/img_gallery_04.png" alt="" /></span>
					</a>
				</li>
			</ul>
		</div>
		<%' item %>
		<div class="item itemB">
			<div class="inner">
				<h3>
					<span class="half"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72182/img_logo_half.png" alt="하프 아티스트" /></span>
					<span class="horizontalLine1"></span>
					<span class="horizontalLine2"></span>
				</h3>
			<%
				IF application("Svr_Info") = "Dev" THEN
					itemid = 1239226
				Else
					itemid = 1537568
				End If
				set oItem = new CatePrdCls
					oItem.GetItemData itemid
			%>
				<div class="desc">
					<div class="option">
						<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72182/txt_name.png" alt="굿모닝, 굿나잇 다이아몬드 솝 Calendula Shower, Creamy Linen" /></p>
						<%' for dev msg : 상품코드 1537568, 할인기간 8/3 ~ 8/9 할인기간이 지나면  <strong class="discount">...</strong> 숨겨주세요 %>
					<% If oItem.FResultCount > 0 Then %>
						<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
							<div class="price">
							<% If not( left(currenttime,10)>="2016-08-01" and left(currenttime,10)<="2016-08-09" ) Then %>
							<% Else %>
								<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/txt_preopen_10percent.png" alt="텐바이텐 단독 선오픈 10%" /></strong>
								<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
							<% End If %>
								<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
							</div>
						<% Else %>
						<%' for dev msg : 할인 안할 경우 %>
							<div class="price priceEnd">
								<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
							</div>
						<% End If %>
					<% End If %>
						<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72182/txt_substance.png" alt="브랜드 이니셜인 알파벳 A를 마주보게 하여 마름모 형태로 독특하게 디자인된 다이아몬드솝" /></p>
					</div>
			<% set oItem = nothing %>
					<%' slide %>
					<div class="slidewrap">
						<div id="slide" class="slide">
							<div>
								<a href="/shopping/category_prd.asp?itemid=1537568&amp;pEtr=72182">
									<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72182/img_slide_item_01.jpg" alt="굿모닝 비누 다이아몬드 카렌듈라 샤워" />
									<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러 가기" /></div>
								</a>
							</div>
							<div>
								<a href="/shopping/category_prd.asp?itemid=1537566&amp;pEtr=72182">
									<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72182/img_slide_item_02.jpg" alt="굿나잇 비누 다이아몬드 크리미 린넨" />
									<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러 가기" /></div>
								</a>
							</div>
						</div>
					</div>
				</div>
				<div class="with">
					<span><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/ico_plus.png" alt="" /></span>
					<ul>
				<%
					IF application("Svr_Info") = "Dev" THEN
						itemid = 786868
					Else
						itemid = 1537569
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
				%>
						<li>
							<a href="/shopping/category_prd.asp?itemid=1537569&amp;pEtr=72182">
								<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72182/img_with_item_01.jpg" alt="" />
								<span>굿나잇 비누 초콜릿 &apos;스태리 나잇&apos;</span>
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
					IF application("Svr_Info") = "Dev" THEN
						itemid = 786868
					Else
						itemid = 1537570
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
				%>
						<li>
							<a href="/shopping/category_prd.asp?itemid=1537570&amp;pEtr=72182">
								<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72182/img_with_item_02.jpg" alt="" />
								<span>굿나잇 비누 초콜릿 &apos;크리미 린넨&apos;</span>
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
					IF application("Svr_Info") = "Dev" THEN
						itemid = 786868
					Else
						itemid = 1537572
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
				%>
						<li>
							<a href="/shopping/category_prd.asp?itemid=1537572&amp;pEtr=72182">
								<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72182/img_with_item_03.jpg" alt="" />
								<span>굿모닝 비누 초콜릿 &apos;카렌듈라 샤워&apos;</span>
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
					IF application("Svr_Info") = "Dev" THEN
						itemid = 786868
					Else
						itemid = 1537571
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
				%>
						<li>
							<a href="/shopping/category_prd.asp?itemid=1537571&amp;pEtr=72182">
								<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72182/img_with_item_04.jpg" alt="" />
								<span>굿모닝 비누 초콜릿 &apos;프레시 밀크&apos;</span>
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
					IF application("Svr_Info") = "Dev" THEN
						itemid = 786868
					Else
						itemid = 1537564
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
				%>
						<li>
							<a href="/shopping/category_prd.asp?itemid=1537564&amp;pEtr=72182">
								<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72182/img_with_item_05.jpg" alt="" />
								<span>굿 럭 캔디 비누</span>
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
			<div class="figure"><a href="/shopping/category_prd.asp?itemid=1537569&amp;pEtr=72182"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72182/img_item_visual_big.jpg" alt="굿나잇 비누 초콜릿 스태리 나잇" /></a></div>
		</div>
		<%' brand %>
		<div class="brand">
			<div class="logo"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72182/img_logo_half.png" alt="" /></div>
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72182/txt_brand.png" alt="하프 아티스트는 당신의 하루의 시작과 마무리를 함께하고자 합니다. 행운이 따를 것 같은 상쾌한 아침을 선물해주고, 센치한 기분으로 터덜터덜 돌아온 저녁에 따뜻하게 맞아주는, 친구 같은 향기.. 하프 아티스트를 소개합니다." /></p>
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
									<a href="/street/street_brand_sub06.asp?makerid=halfartist" title="하프아티스트 브랜드 스트리트으로 이동"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72182/img_slide_story_01.jpg" alt="#Present 나를 위한 선물은 물론, 소중한 이를 위한 선물! 특별한 그대를 위해 선물해보세요. 가장 좋은 선물은 나의 작은 일상을 나누는 것이니까요." /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1537569&amp;pEtr=72182" title="굿나잇 비누 초콜릿 스태리 나잇 보러가기"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72182/img_slide_story_02.jpg" alt="#Organic 유기농, 친환경 원료를 사용하여 당신에게 꼭 필요한 성분만 넣었어요. 아무리 좋은 향기라도 성분이 유해하다면 비누로서의 가치가 없어요." /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1537564&amp;pEtr=72182" title="굿 럭 캔디 비누 보러가기"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72182/img_slide_story_03.jpg" alt="#Daily 집으로 돌아와 샤워기에 몸을 맡길 때, 기분 좋은 온도의 물줄기와 욕실을 채우는 촉촉한 온기, 코끝부터 온몸을 감싸는 은은한 비누 향기. 비로소 하루의 피곤함이 노곤하게 녹아 내립니다." /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1537564&amp;pEtr=72182" title="굿 럭 캔디 비누 보러가기"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72182/img_slide_story_04.jpg" alt="#Lucky 그대에게 주고 싶은 한마디, 더욱 아름답게 전달하고 싶었어요. 12가지의 행운의 단어를 담아 랜덤으로 행운을 드려요." /></a>
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
			<a href="/shopping/category_prd.asp?itemid=1537565&amp;pEtr=72182" title="선물용 패브릭 파우치 보러가기">
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72182/txt_finish.png" alt="당신의 소중한 하루의  시작과 마무리를 함께 할게요 하프 아티스트" /></p>
				<div class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72182/img_finish.jpg" alt="" /></div>
			</a>
		</div>
		<%' comment %>
		<div class="commentevet">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72182/tit_comment.png" alt="Hey, something project 함께 하고 싶은 달콤한 비누" /></h3>
			<p class="hidden">아티스트라고 느껴지는 순간은 언제인가요? 스스로 예술적 감성이 충만하다고 느껴지는 순간을 공유해 주세요. 정성껏 코멘트를 남겨주신 5분을 추첨하여 천연 비누 제품과 함께 핸드메이드 앞치마를 선물로 드립니다. 코멘트 작성기간은 2016년 8월 3일부터 8월 9일까지며, 발표는 8월 10일 입니다.</p>
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
					<legend>스스로 예술적 감성이 충만하다고 느껴지는 순간이 언제 인지 코멘트를 써주세요</legend>
						<ul class="choice">
							<li class="ico1"><button type="button" value="1">Present</button></li>
							<li class="ico2"><button type="button" value="2">Organic</button></li>
							<li class="ico3"><button type="button" value="3">Daily</button></li>
							<li class="ico4"><button type="button" value="4">Lucky</button></li>
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
					<caption>하프 아티스트 코멘트 목록 - 코멘트 작성시 선택 항목, 내용, 작성일자, 아이디 정보를 제공하는 표</caption>
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
										Present
									<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="2" Then %>
										Organic
									<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="3" Then %>
										Daily
									<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="4" Then %>
										Lucky
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
	$("#slide").slidesjs({
		pagination:false,
		navigation:{effect:"fade"},
		play:{interval:2000, effect:"fade", auto:true},
		effect:{fade: {speed:800, crossfade:true}
		},
		callback: {
			complete: function(number) {
				var pluginInstance = $('#slide').data('plugin_slidesjs');
				setTimeout(function() {
					pluginInstance.play(true);
				}, pluginInstance.options.play.interval);
			}
		}
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
		if (scrollTop > 900) {
			$(".heySomething .gallery ul li").addClass("fadeInSlideUp");
			$(".heySomething .gallery ul li .off img").addClass("pulse");
		}
		if (scrollTop > 4300) {
			brandAnimation();
		}
		if (scrollTop > 7000) {
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

	/* brand animation */
	$(".heySomething .brand p").css({"height":"50px", "opacity":"0"});
	$(".heySomething .brand .btnDown").css({"opacity":"0"});
	function brandAnimation() {
		$(".heySomething .brand p").delay(100).animate({"height":"130px", "opacity":"1"},800);
		$(".heySomething .brand .btnDown").delay(1000).animate({"opacity":"1"},1200);
	}

	/* finish animation */
	$(".heySomething .finish p").css({"margin-left":"300px", "opacity":"0"});
	function finishAnimation() {
		$(".heySomething .finish p").delay(100).animate({"margin-left":"267px", "opacity":"1"},1000);
	}
});
</script>
<!--[if lte IE 9]>
	<script type="text/javascript">
		$(function(){
			$(".heySomething .gallery ul li").css({"opacity":"1"});
		});
	</script>
<![endif]-->
<!-- #include virtual="/lib/db/dbclose.asp" -->