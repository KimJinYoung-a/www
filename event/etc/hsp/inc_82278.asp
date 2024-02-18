<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'###########################################################
' Description : hey, something project 시리즈 97
' 삭스어필 크리스마스, 온기를 전하다
' History : 2017-11-28 정태훈 생성
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
	eCode   =  67466
Else
	eCode   =  82278
End If

dim userid, commentcount, i
	userid = GetEncLoginUserID()

if userid = "baboytw" or userid = "chaem35" or userid = "answjd248" or userid = "corpse2" or userid = "jinyeonmi" then
	currenttime = #11/29/2017 09:00:00#
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
.heySomething .topic {background:#f2eee7 url(http://webimage.10x10.co.kr/eventIMG/2017/hey/82278/bg_item_represent.jpg) no-repeat 50% 0;}

/* brand */
.heySomething .brand {position:relative; height:1064px; margin-top:463px; text-align:center;}
.heySomething .brand p {margin-top:89px;}
.heySomething .brand .btnDown {margin-top:80px;}

/* intro */
.heySomething .intro {margin-top:400px;}
.wideSlide .slidesjs-container,
.wideSlide .slidesjs-control,
.wideSlide .swiper-slide img {height:810px !important;}

/* item */
.heySomething .itemB {margin-top:403px; padding-bottom:280px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/82278/bg_line.gif) repeat-x 0 100%}
.heySomething .itemB h3 + .desc {margin-top:90px;}
.heySomething .itemB .desc {min-height:540px; padding:0 0 108px 0;}
.heySomething .item .option .substance {position:static; margin-top:41px;}
.heySomething .itemB .desc .option {top:41px; height:540px;}
.heySomething .itemB .slidewrap {width:1140px; height:540px;}
.heySomething .itemB .slidewrap .slide {width:1140px; height:540px;}
.heySomething .itemB .slidesjs-container,
.heySomething .itemB .slidesjs-control {height:540px !important;}
.heySomething .itemB .slidesjs-slide {position:relative; text-align:right;}
.heySomething .itemB .slidesjs-slide img {padding-right:64px;}
.heySomething .itemB .slidewrap .slide .slidesjs-navigation {top:252px; margin-top:0;}
.heySomething .itemB .slidewrap .slide .slidesjs-previous {left:474px;}
.heySomething .itemB .slidewrap .slide .slidesjs-next {left:1120px;}
.heySomething .itemB .slidesjs-slide .btnget {position:absolute; bottom:40px; left:82px;}
.heySomething .itemB .slidesjs-pagination {width:1040px; margin-left:-520px; bottom:-235px;}
.heySomething .itemB .slidesjs-pagination li {padding:0 20px;}
.heySomething .itemB .slidesjs-pagination li a {position:relative; width:220px; height:192px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/82278/btn_pagination_item.jpg?v=1.0);}
.heySomething .itemB .slidesjs-pagination li .active {background-position:0 0;}
.heySomething .itemB .slidesjs-pagination li:first-child + li a {background-position:-220px 0;}
.heySomething .itemB .slidesjs-pagination li:first-child + li + li a {background-position:-440px 0;}
.heySomething .itemB .slidesjs-pagination li:first-child + li + li + li a {background-position:-660px 0;}
.heySomething .itemB .line {position:absolute; top:0; left:0; width:212px; height:184px; border:4px solid #d50c0c; transition:opacity 0.2s; opacity:0;}
.heySomething .itemB .active .line {opacity:1;}
.heySomething .item2,.heySomething .item3 {margin-top:127px;}
.heySomething .item2 .desc, .heySomething .item3 .desc {padding-bottom:92px;}
.heySomething .item2 .desc .option {top:20px; left:810px;}
.heySomething .item2 .slidesjs-slide {text-align:left;}
.heySomething .item2 .slidesjs-slide img {padding-left:64px;}
.heySomething .item2 .slidesjs-slide .btnget {position:absolute; bottom:56px; left:810px;}
.heySomething .item2 .slidesjs-slide .btnget img {padding-left:0;}
.heySomething .item2 .slidewrap .slide .slidesjs-previous {left:0;}
.heySomething .item2 .slidewrap .slide .slidesjs-next {left:647px;}
.heySomething .item2 .slidesjs-pagination li a {background-position:0 -192px;}
.heySomething .item2 .slidesjs-pagination li .active {background-position:0 -192px;}
.heySomething .item2 .slidesjs-pagination li:first-child + li a {background-position:-220px -192px;}
.heySomething .item2 .slidesjs-pagination li:first-child + li + li a {background-position:-440px -192px;}
.heySomething .item2 .slidesjs-pagination li:first-child + li + li + li a {background-position:-660px -192px;}
.heySomething .item3 .desc .option {top:36px;}
.heySomething .item3 .slidesjs-slide .btnget {bottom:42px;}
.heySomething .item3 .slidesjs-pagination {width:780px; margin-left:-390px;}
.heySomething .item3 .slidesjs-pagination li a {background-position:0 100%;}
.heySomething .item3 .slidesjs-pagination li .active {background-position:0 100%;}
.heySomething .item3 .slidesjs-pagination li:first-child + li a {background-position:-220px 100%;}
.heySomething .item3 .slidesjs-pagination li:first-child + li + li a {background-position:-440px 100%;}
.heySomething .item3 .slidesjs-pagination li:first-child + li + li + li a {background:none;}

/* chritmas */
.heySomething .chritmas {position:relative; height:930px; margin-top:400px; background-color:#970f0f; text-align:center;}
.heySomething .chritmas .bg {position:absolute; top:auto; bottom:0; left:0; width:100%; height:400px; background-color:#154941;}
.heySomething .chritmas p {position:relative; z-index:10; width:1140px; margin:0 auto;}

/* story */
.heySomething .story {margin:380px 0 0;}
.heySomething .rollingwrap {margin-top:0;}
.heySomething .rolling {padding:165px 0 120px;}
.heySomething .rolling .pagination {padding-left:190px;}
.heySomething .rolling .pagination span {width:140px; height:140px; margin-right:90px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/82278/bg_ico.png);}
.heySomething .rolling .pagination span.swiper-active-switch {background-position:0 -140px;}
.heySomething .rolling .pagination span:first-child + span {background-position:-230px 0;}
.heySomething .rolling .pagination span:first-child + span.swiper-active-switch {background-position:-230px -140px;}
.heySomething .rolling .pagination span:first-child + span + span {background-position:-460px 0;}
.heySomething .rolling .pagination span:first-child + span + span.swiper-active-switch {background-position:-460px -140px;}
.heySomething .rolling .pagination span em {bottom:-775px; height:120px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/82278/txt_story_desc.gif); cursor:default;}
.heySomething .swipemask {top:165px;}

/* finish */
.heySomething .finish {height:290px; margin-top:284px; padding-top:210px; background:#a4572c url(http://webimage.10x10.co.kr/eventIMG/2017/hey/82278/bg_finish.jpg) no-repeat 50% 0; text-align:center;}

/* comment */
.heySomething .commentevet {margin-top:413px}
.heySomething .commentevet .form {margin-top:15px;}
.heySomething .commentevet .form .choice li {margin-right:15px;}
.heySomething .commentevet .form .choice li,
.heySomething .commentlist table td strong {width:132px; height:132px;}
.heySomething .commentevet .form .choice li button,
.heySomething .commentlist table td strong {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/82278/bg_ico.png); background-position:0 -280px;}
.heySomething .commentevet .form .choice li.ico2 button {background-position:-147px -280px;}
.heySomething .commentevet .form .choice li.ico2 button.on {background-position:-147px -412px;}
.heySomething .commentevet .form .choice li.ico3 button{background-position:-291px -280px;}
.heySomething .commentevet .form .choice li.ico3 button.on {background-position:-291px -412px;}
.heySomething .commentevet textarea {margin-top:30px;}
.heySomething .commentlist table td .ico2 {background-position:-147px -280px;}
.heySomething .commentlist table td .ico3 {background-position:-291px -280px;}
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
		<% If not( left(currenttime,10) >= "2017-11-29" and left(currenttime,10) < "2017-12-07" ) Then %>
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
				<div class="topic">
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
					<a href="/street/street_brand_sub06.asp?makerid=socksappeal">
						<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82278/tit_brand.gif" alt="socks appeal" /></h3>
						<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82278/txt_brand.jpg" alt="찬바람 부는 겨울, 정류장에서 버스를 기다립니다. 따듯한 커피를 손에 꽉 쥐고 생각에 빠집니다. 나의 올 한해는 어땠을까? 머리 속을 스쳐가는 고마운 사람들 당신의 2017년을 따듯하게 만들어준 사람들에게 특별한 선물이 없을까요? 삭스어필이 제안하는 손에서 발끝까지 따듯한 겨울 식지 않는 온기를 선물하세요." /></p>
						<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="" /></div>
					</a>
				</div>

				<!-- intro  -->
				<div class="intro slideTemplateV15 wideSlide">
					<div class="swiper-container">
						<div class="swiper-wrapper">
							<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82278/img_slide_intro_01.jpg" alt="" /></div>
							<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82278/img_slide_intro_02.jpg" alt="" /></div>
							<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82278/img_slide_intro_03.jpg" alt="" /></div>
							<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82278/img_slide_intro_04.jpg" alt="" /></div>
						</div>
						<div class="pagination"></div>
						<button class="slideNav btnPrev">이전</button>
						<button class="slideNav btnNext">다음</button>
					</div>
				</div>
				<%
				IF application("Svr_Info") = "Dev" THEN
					itemid = 1239226
				Else
					itemid = 1843948
				End If
				set oItem = new CatePrdCls
					oItem.GetItemData itemid
				%>
				<!-- item -->
				<div class="item itemB">
					<div class="inner">
						<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82278/tit_brand.gif" alt="socks appeal" /></h3>

						<div class="desc">
							<!-- 상품 이름, 가격, 구매하기 -->
							<div class="option">
								<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82278/txt_item_name_01.gif" alt="텐바이텐 단독 선 오픈 SOCKSAPPEAL Dot Socks, Free Size 230~275 Dot Santa, Dot Rudolph, Dot Ornament, Dot Holytree" /></p>
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
								<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82278/txt_item_substance_01.gif" alt="사랑스러운 도트 패턴에 눈을 깜빡이는 귀여운 산타와 루돌프가 숨어 있습니다. 크리스마스를 대표하는 컬러감이 소장하고 싶은 욕구를 자극하네요." /></p>
							</div>
							<!-- slide -->
							<div class="slidewrap">
								<div id="slide01" class="slide">
									<div>
										<a href="/shopping/category_prd.asp?itemid=1843948&pEtr=82278">
											<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82278/img_slide_item_01_01.jpg" alt="" />
											<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="SML dot santa socks 구매하러 가기" /></div>
										</a>
									</div>
									<div>
										<a href="/shopping/category_prd.asp?itemid=1843947&pEtr=82278">
											<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82278/img_slide_item_01_02.jpg" alt="" />
											<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="SML dot rudolph socks 구매하러 가기" /></div>
										</a>
									</div>
									<div>
										<a href="/shopping/category_prd.asp?itemid=1843946&pEtr=82278">
											<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82278/img_slide_item_01_03.jpg" alt="" />
											<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="dot ornament socks 구매하러 가기" /></div>
										</a>
									</div>
									<div>
										<a href="/shopping/category_prd.asp?itemid=1843952&pEtr=82278">
											<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82278/img_slide_item_01_04.jpg" alt="" />
											<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="dot holy tree socks 구매하러 가기" /></div>
										</a>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<%
				set oItem = nothing
				%>
				<%
				IF application("Svr_Info") = "Dev" THEN
					itemid = 1239226
				Else
					itemid = 1843949
				End If
				set oItem = new CatePrdCls
					oItem.GetItemData itemid
				%>
				<div class="item itemB item2">
					<div class="inner">
						<div class="desc">
							<!-- 상품 이름, 가격, 구매하기 -->
							<div class="option">
								<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82278/txt_item_name_02.gif" alt="텐바이텐 단독 선 오픈 SOCKSAPPEAL Pattern Socks, Free Size 230~275 Pattern Snowman, Pattern Christmas tree, Pattern Holytree, Pattern Santa" /></p>
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
								<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82278/txt_item_substance_02.gif" alt="모든 것이 특별한 크리스마스의 행복, 딥한 컬러감에 생기를 불어넣어주는 디자인 패턴을 보고 있으면 짙은 미소가 번집니다." /></p>
							</div>

							<!-- slide -->
							<div class="slidewrap">
								<div id="slide02" class="slide">
									<div>
										<a href="/shopping/category_prd.asp?itemid=1843949&pEtr=82278">
											<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82278/img_slide_item_02_01.jpg" alt="" />
											<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="pattern snowman socks 구매하러 가기" /></div>
										</a>
									</div>
									<div>
										<a href="/shopping/category_prd.asp?itemid=1843956&pEtr=82278">
											<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82278/img_slide_item_02_02.jpg" alt="" />
											<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="pattern christmas tree socks 구매하러 가기" /></div>
										</a>
									</div>
									<div>
										<a href="/shopping/category_prd.asp?itemid=1843951&pEtr=82278">
											<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82278/img_slide_item_02_03.jpg" alt="" />
											<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="pattern holytree socks 구매하러 가기" /></div>
										</a>
									</div>
									<div>
										<a href="/shopping/category_prd.asp?itemid=1843950&pEtr=82278">
											<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82278/img_slide_item_02_04.jpg" alt="" />
											<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="pattern santa socks 구매하러 가기" /></div>
										</a>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<%
				set oItem = nothing
				%>
				<%
				IF application("Svr_Info") = "Dev" THEN
					itemid = 1239226
				Else
					itemid = 1843953
				End If
				set oItem = new CatePrdCls
					oItem.GetItemData itemid
				%>
				<div class="item itemB item3">
					<div class="inner">
						<div class="desc">
							<!-- 상품 이름, 가격, 구매하기 -->
							<div class="option">
								<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82278/txt_item_name_03.gif" alt="텐바이텐 단독 선 오픈 SOCKSAPPEAL Gradation Socks, Free Size 230~275 Wool Snowman, Wool Rudolph, Wool Christmas tree" /></p>
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
								<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82278/txt_item_substance_03.gif" alt="닿는 것만으로도 기분이 좋아지는 부드러운 울의 촉감, 그 따듯함이 특별한 크리스마스 자수를 입어 배가 되었습니다." /></p>
							</div>

							<!-- slide -->
							<div class="slidewrap">
								<div id="slide03" class="slide">
									<div>
										<a href="/shopping/category_prd.asp?itemid=1843953&pEtr=82278">
											<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82278/img_slide_item_03_01.jpg" alt="" />
											<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="gradation snowman socks 구매하러 가기" /></div>
										</a>
									</div>
									<div>
										<a href="/shopping/category_prd.asp?itemid=1843954&pEtr=82278">
											<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82278/img_slide_item_03_02.jpg" alt="" />
											<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="gradation rudolph socks 구매하러 가기" /></div>
										</a>
									</div>
									<div>
										<a href="/shopping/category_prd.asp?itemid=1843955&pEtr=82278">
											<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82278/img_slide_item_03_03.jpg" alt="" />
											<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="gradation christmas tree socks 구매하러 가기" /></div>
										</a>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<%
				set oItem = nothing
				%>
				<!-- chritmas -->
				<div class="chritmas">
					<div class="bg"></div>
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82278/txt_finish.jpg" alt="삭스어필과 함께하는 크리스마스 준비 12월 한 달 동안 삭스어필 크리스마스 컵슬리브 패키지를 20%할인합니다 연말연시를 귀엽고 따뜻한 삭스어필 양말과 함께해보아요" /></p>
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
								<div class="swiper-container swiper1">
									<div class="swiper-wrapper"> 
										<div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1843956&pEtr=82278" title="pattern christmas tree socks"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82278/img_slide_story_01.jpg" alt="12월이 되면 거리를 가득 매우는 노래 캐롤. 화려하게 반짝이는 거리를 걸으며 입김을 내며 열심히 따라부르고 있는 당신, 올 한해도 고생했어요." /></a></div>
										<div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1843949&pEtr=82278" title="pattern snowman socks"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82278/img_slide_story_02.jpg" alt="어릴적, 눈이 잔뜩 오는 날 아빠따라 추운 것도 잊은채 만들었던 첫 눈사람. 당신의 첫 눈 사람은 누구와 함께 만들었나요?" /></a></div>
										<div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1843950&pEtr=82278" title="pattern santa tree socks"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82278/img_slide_story_03.jpg" alt="어릴적엔 산타를 기다렸는데 언제부턴가 산타가 되어가는 내 모습. 받는 기쁨보다 주는 기쁨이 더 큰 요즘. 산타의 가장 큰 선물은 사랑이라는 것 이제야 알것 같아요." /></a></div>
									</div>
								</div>
							</div>
							<div class="pagination"></div>
						</div>
					</div>
				</div>

				<!-- finish -->
				<div class="finish">
					<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82278/txt_finish.png" alt="socks appeal" /></span>
				</div>

				<!-- comment -->
				<div class="commentevet">
					<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82278/tit_comment.gif" alt="Hey, something project, 삭스어필, 크리스마스의 행복을 전합니다." /></h3>
					<p class="hidden">당신에게 가장 설레는 크리스마스의 추억은 무엇인가요? 그 이유를 코멘트로 남겨주세요 가장 설레는 크리스마스를 소개해준 5분에게 삭스어필 크리스마스양말 3pcs Box를 선물로 드립니다. 디자인 랜덤증정, 기간 2017.11.29 ~ 12.06, 발표 12.08</p>
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
									<li class="ico1"><button type="button" value="1" onfocus="this.blur();">#캐롤</button></li>
									<li class="ico2"><button type="button" value="2" onfocus="this.blur();">#눈사람</button></li>
									<li class="ico3"><button type="button" value="3" onfocus="this.blur();">#산타</button></li>
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
										<strong  class="ico<%= split(arrCList(1,intCLoop),"!@#")(0) %>">
										<% if split(arrCList(1,intCLoop),"!@#")(0)="1" Then %>
										#캐롤
										<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="2" Then %>
										#눈사람
										<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="3" Then %>
										#산타
										<% Else %>
										#캐롤
										<% End If %>
										</strong></td>
									<% End If %>
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
										<button type="button" class="btndel"><img src="http://fiximage.10x10.co.kr/web2013/event/btn_cmt_close.gif" alt="코멘트 삭제"></button>
										<% end if %>
										<% If arrCList(8,i) <> "W" Then %>
										<br /><img src="http://fiximage.10x10.co.kr/web2013/event/ico_mobile.png" alt="모바일에서 작성됨">
										<% end if %>
									</td>
								</tr>
								<% next %>
							</tbody>
						</table>
						<% End If %>
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
	/* slide template type - wide slide */
	$('.wideSlide .swiper-wrapper').slidesjs({
		width:1920,
		height:810,
		pagination:{effect:'fade'},
		navigation:{effect:'fade'},
		play:{interval:3000, effect:'fade', auto:false},
		effect:{fade: {speed:1200, crossfade:true}}
	});

	/* slide js */
	$("#slide01").slidesjs({
		width:"1140",
		height:"540",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:1900, effect:"fade", auto:true},
		effect:{slide: {speed:1500}}
	});
	$("#slide02").slidesjs({
		width:"1140",
		height:"540",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:2500, effect:"fade", auto:true},
		effect:{slide: {speed:1500}}
	});
	$("#slide03").slidesjs({
		width:"1140",
		height:"540",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:1900, effect:"fade", auto:true},
		effect:{slide: {speed:1500}}
	});

	$(".item .slidesjs-pagination li a").append('<span class="line"></span>');

	/* mouse control */
	$('#slide01 .slidesjs-pagination > li a, #slide02 .slidesjs-pagination > li a, #slide03 .slidesjs-pagination > li a').mouseenter(function(){
		$('a[data-slidesjs-item="' + $(this).attr("data-slidesjs-item") + '"]').trigger('click');
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
	$(".form .choice li button").click(function(){
		$(".form .choice li button").removeClass("on");
		if ( $(this).hasClass("on")) {
			$(this).removeClass("on");
		} else {
			$(this).addClass("on");
		}
	});

	/* title animation */
	titleAnimation();
	$(".heySomething .topic h2 span").css({"opacity":"0"});
	$(".heySomething .topic h2 .letter1").css({"margin-top":"7px"});
	$(".heySomething .topic h2 .letter2").css({"margin-top":"15px"});
	$(".heySomething .topic h2 .letter3").css({"margin-top":"23px"});
	function titleAnimation() {
		$(".heySomething .topic h2 .letter1").delay(300).animate({"margin-top":"0", "opacity":"1"},800);
		$(".heySomething .topic h2 .letter2").delay(700).animate({"margin-top":"7px", "opacity":"1"},800);
		$(".heySomething .topic h2 .letter3").delay(1100).animate({"margin-top":"17px", "opacity":"1"},800);
	}

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

});
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->