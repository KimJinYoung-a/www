<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈 3
' History : 2015.09.22 한용민 생성
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
	'currenttime = #09/23/2015 09:00:00#

dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  64893
Else
	eCode   =  66242
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
	itemid   =  1354437
End If

dim oItem
set oItem = new CatePrdCls
	oItem.GetItemData itemid

Dim hspchk
'// 현재 주소값 체크하여 신규, 구버전 확인
hspchk = Split(LCase(Request.ServerVariables("PATH_INFO")),"/")

%>
<style type="text/css">
img {vertical-align:top;}
.evtEndWrapV15 {display:none;}

/* title */
.heySomething .topic {background-color:#f5eae0;}

/* item */
.heySomething .itemA .with ul {width:1032px;}
.heySomething .itemA .with ul li {width:300px; padding:0 22px;}

/* visual */
.heySomething .visual .figure {background-color:#f3f1f1;}
.heySomething #slider {height:270px;}
.heySomething #slider .slide-img {width:290px; height:270px; margin:0 40px;}

/* brand */
.heySomething .brand {height:720px;}

/* story */
.heySomething .rolling .pagination {width:950px; margin-left:-475px;}
.heySomething .rolling .swiper-pagination-switch {margin:0 25px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/66242/bg_ico.png);}

.heySomething .rolling .pagination span em {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/66242/txt_story_desc.png);}

/* finish */
.heySomething .finish {background-color:#ebd7d4;}
.heySomething .finish p {top:120px; left:50%; margin-left:194px; width:292px; height:225px;}
.heySomething .finish p em {width:351px; background:transparent url(http://webimage.10x10.co.kr/eventIMG/2015/66242/txt_with.png) no-repeat 0 0;}
.heySomething .finish p .letter1 {height:156px;}
.heySomething .finish p .letter2 {margin-top:42px; height:27px;}
.heySomething .finish p span {background-color:#928f8f;}

/* comment */
.heySomething .commentevet .form .choice li button {background:transparent url(http://webimage.10x10.co.kr/eventIMG/2015/66242/bg_ico.png) no-repeat 0 -300px;}
.heySomething .commentevet .form .choice li.ico1 button.on {background-position:0 100%;}
.heySomething .commentevet .form .choice li.ico2 button {background-position:-150px -300px;}
.heySomething .commentevet .form .choice li.ico2 button.on {background-position:-150px 100%;}
.heySomething .commentevet .form .choice li.ico3 button {background-position:-300px -300px;}
.heySomething .commentevet .form .choice li.ico3 button.on {background-position:-300px 100%;}
.heySomething .commentevet .form .choice li.ico4 button {background-position:-450px -300px;}
.heySomething .commentevet .form .choice li.ico4 button.on {background-position:-450px 100%;}
.heySomething .commentevet .form .choice li.ico5 button {background-position:-600px -300px;}
.heySomething .commentevet .form .choice li.ico5 button.on {background-position:-600px 100%;}

.heySomething .commentlist table td strong {width:150px; height:85px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/66242/bg_ico.png) no-repeat 0 -335px;}
.heySomething .commentlist table td .ico2 {background-position:-150px -335px;}
.heySomething .commentlist table td .ico3 {background-position:-300px -335px;}
.heySomething .commentlist table td .ico4 {background-position:-450px -335px;}
.heySomething .commentlist table td .ico5 {background-position:-600px -335px;}
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
		<% If not( left(currenttime,10)>="2015-09-23" and left(currenttime,10)<"2015-10-08" ) Then %>
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
</head>
<body>

<% If Not(Trim(hspchk(1)))="hsproject" Then %>
<div class="evt66242">
	<div class="heySomething">
<% End If %>
		<!-- title, nav -->
		<div class="topic">
			<h2>
				<span class="letter1">Hey,</span>
				<span class="letter2">something</span>
				<span class="letter3">project</span>
				<!--span class="letter4">DESIGN FINGERS VOL.2</span-->
			</h2>

			<% If Not(Trim(hspchk(1)))="hsproject" Then %>
				<div class="navigator">
					<ul>
						<!-- #include virtual="/event/etc/inc_66049_menu.asp" -->
					</ul>
					<span class="line"></span>
				</div>
			<% End If %>
			<div class="bnr"><a href="/street/street_brand_sub06.asp?makerid=circusboyband"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66242/img_item_represent.jpg" alt="서커스보이밴드" /></a></div>
		</div>

		<!-- about -->
		<div class="about">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/66049/tit_about.png" alt="About Hey, something project" /></h3>
			<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
		</div>

		<!-- item -->
		<div class="item itemA">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/66242/tit_circus_boy_band.png" alt="CIRCUS BOY BAND" /></h3>
			<div class="desc">
				<div class="figure">
					<a href="/shopping/category_prd.asp?itemid=1354437"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66242/img_item_animation.gif" width="570" height="485" alt="" /></a>
				</div>
				<div class="option">
					<em class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66242/txt_name.png" alt="스트라이프 티셔츠 5 color, Free to all" /></em>

					<% if oItem.FResultCount > 0 then %>
						<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
							<div class="price">
								<% If oItem.Prd.FOrgprice = 0 Then %>
								<% else %>
									<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/txt_only_<%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>percent.png" alt="단, 일주일만 ONLY 20%" /></strong>
								<% end if %>

								<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
								<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
							</div>
						<% else %>
							<div class="price priceEnd">
								<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
							</div>
						<% end if %>
					<% end if %>

					<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66242/txt_substance.png" alt="당신의 상상을 건드립니다. 평범한 스트라이프의 작은 변신. 서커스 보이밴드와 함께하는 일상의 작은 유쾌함을 느껴보세요." /></p>
					<div class="btnget"><a href="/shopping/category_prd.asp?itemid=1354437"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66049/btn_get.gif" alt="구매하러 가기" /></a></div>
				</div>
			</div>

			<div class="with">
				<span><img src="http://webimage.10x10.co.kr/eventIMG/2015/66049/ico_plus.png" alt="" /></span>
				<ul>
					<li>
						<a href="/shopping/category_prd.asp?itemid=1354437">
							<img src="http://webimage.10x10.co.kr/eventIMG/2015/66242/img_with_item_01.jpg" alt="" />
							<span>CBB Stripe t-shirts (5type)</span>

							<% if oItem.FResultCount > 0 then %>
								<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								<% else %>
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								<% end if %>
							<% end if %>
						</a>
					</li>
					<li>
						<a href="/shopping/category_prd.asp?itemid=1328744">
							<img src="http://webimage.10x10.co.kr/eventIMG/2015/66242/img_with_item_02.jpg" alt="" />
							<span>Sticker boy desk mat (4type)</span>
							<strong>9,800 won</strong>
						</a>
					</li>
					<li>
						<a href="/shopping/category_prd.asp?itemid=1354335">
							<img src="http://webimage.10x10.co.kr/eventIMG/2015/66242/img_with_item_03.jpg" alt="" />
							<span>Space mouse pad (3type)</span>
							<strong>4,000 won</strong>
						</a>
					</li>
				</ul>
			</div>
		</div>

		<!-- visual -->
		<div class="visual">
			<div class="figure"><a href="/street/street_brand_sub06.asp?makerid=circusboyband"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66242/img_item_visual_big.jpg" alt="" /></a></div>

			<div id="slider" class="slider-horizontal">
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1354437"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66242/img_item_visual_01.jpg" alt="STRIPE T Plant" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1354437"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66242/img_item_visual_02.jpg" alt="STRIPE T Bird" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1354437"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66242/img_item_visual_03.jpg" alt="STRIPE T Owl" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1354437"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66242/img_item_visual_04.jpg" alt="STRIPE T Glasses" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1354437"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66242/img_item_visual_05.jpg" alt="STRIPE T Balloon" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1328744"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66242/img_item_visual_06.jpg" alt="Desk mat space travel" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1328744"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66242/img_item_visual_07.jpg" alt="Desk mat sticker boy" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1328744"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66242/img_item_visual_08.jpg" alt="Desk mat market" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1328744"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66242/img_item_visual_09.jpg" alt="Desk mat hope" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1354335"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66242/img_item_visual_10.jpg" alt="Mouse pad space travel" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1354335"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66242/img_item_visual_11.jpg" alt="Mouse pad sticker boy" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1354335"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66242/img_item_visual_12.jpg" alt="Mouse pad market" /></a>
				</div>
			</div>
		</div>

		<!-- brand -->
		<div class="brand">
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/66242/txt_plan.png" alt="빠른 걸음에 치이는 아침부터 피곤에 젖은 저녁까지 일상은 매일이 똑같습니다. 그렇기 때문에 다른 사람보다 좀 더 특별한 무언가를 자꾸 갈망하죠. 생각의 각도를 조금만 바꾸어 보세요. 일상은 이미 그 자체로 특별합니다. 유쾌한 상상만으로 일상에서 재미를 얻을 수 있도록 당신과 가장 가까운 즐거움을 디자인 합니다. 여기, 보는 것 만으로도 웃음이 나는 서커스 보이밴드를 소개합니다. 나에게 딱 맞는 아이템을 고르는 사이, 새로운 즐거움을 찾게 될 거에요! 당신의 매일에 스며들어 서커스와 같은 일상을 선물합니다" /></p>
			<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66049/btn_arrow_down.png" alt="" /></div>
		</div>

		<!-- story -->
		<div class="story">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/66242/tit_story.png" alt="서커스보이밴드의 유쾌함을 일상에서" /></h3>
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
									<a href="/shopping/category_prd.asp?itemid=1354437"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66242/img_slide_01.jpg" alt="일상의 작은 빈틈을 활용하세요. 화분을 기르거나, 반려동물과 산책하는 전환이 당신에게 필요해요." /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1354437"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66242/img_slide_02.jpg" alt="친구들과 함께 오늘을 추억하세요. 간단한 스냅사진 한 장이 만들어주는 특별함은 생각보다 크답니다." /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1354437"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66242/img_slide_03.jpg" alt="놀러 가기 딱 좋은 선선한 날씨. 여행은 언제나 좋은 결과를 가져다 주죠." /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1354335"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66242/img_slide_04.jpg" alt="콘서트, 한정판, 기차표,페스티벌 유연하게 클릭할 일이 많은 요즘, 성공률이 좋은 요즈음^^" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1328744"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66242/img_slide_05.jpg" alt="가끔 엉뚱한 상상에 빠져 본 적 있지 않아요? 잠시 쉬어가는 타이밍, 난 우주를 여행하는 꿈을 꾸곤 해요." /></a>
								</div>
							</div>
						</div>
					</div>
					<div class="pagination"></div>
				</div>
			</div>
		</div>

		<!-- finish -->
		<div class="finish">
			<a href="/street/street_brand_sub06.asp?makerid=circusboyband">
				<p>
					<em class="letter1">당신의 일상에 약간의 유쾌함을</em>
					<span></span>
					<em class="letter2">CIRCUS BOY BAND</em>
				</p>
				<img src="http://webimage.10x10.co.kr/eventIMG/2015/66242/img_item_finish.jpg" alt="" />
			</a>
		</div>

		<!-- comment -->
		<div class="commentevet">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/66242/tit_want.png" alt="Hey, something project 당신이 갖고 싶은 것" /></h3>
			<p class="hidden">정성껏 코멘트를 남겨주신 5분을 추첨하여 서커스보이밴드 스트라이프 티셔츠를 선물로 드립니다. 기간 : 2015.09.12 ~ 10.07 / 발표 : 10.08</p>

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
					<legend>베로니카포런던 코멘트 쓰기</legend>
						<ul class="choice">
							<li class="ico1"><button type="button" value="1">취미 갖기</button></li>
							<li class="ico2"><button type="button" value="2">사진 찍기</button></li>
							<li class="ico3"><button type="button" value="3">여행 가기</button></li>
							<li class="ico4"><button type="button" value="4">콘서트 가기</button></li>
							<li class="ico5"><button type="button" value="5">쉬는 시간</button></li>
						</ul>
						<textarea name="txtcomm1" id="txtcomm1" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();" <%IF NOT(IsUserLoginOK) THEN%>readonly<%END IF%> title="" cols="60" rows="5"><%IF NOT IsUserLoginOK THEN%>로그인 후 글을 남길 수 있습니다.<% else %><%END IF%></textarea>
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

			<!-- commentlist -->
			<div class="commentlist" id="commentlist">
				<div class="total">total <%= iCTotCnt %></div>
				
				<% IF isArray(arrCList) THEN %>
					<table>
						<colgroup>
							<col style="width:150px;" />
							<col style="width:*;" />
							<col style="width:110px;" />
							<col style="width:120px;" />
							<col style="width:10px;" />
						</colgroup>
						<thead>
						<tr>
							<th scope="col"></th>
							<th scope="col">내용</th>
							<th scope="col">작성일자</th>
							<th scope="col">아이디</th>
							<th scope="col"></th>
						</tr>
						</thead>
						<tbody>
							<% For intCLoop = 0 To UBound(arrCList,2) %>
							<tr>
								<td>
									<% if isarray(split(arrCList(1,intCLoop),"!@#")) then %>
										<strong class="ico<%= split(arrCList(1,intCLoop),"!@#")(0) %>">
											<% if split(arrCList(1,intCLoop),"!@#")(0)="1" then %>
												취미 갖기
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="2" then %>
												사진 찍기
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="3" then %>
												여행 가기
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="4" then %>
												콘서트가기
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="5" then %>
												쉬는 시간
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

					<!-- paging -->
					<div class="pageWrapV15">
						<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
					</div>
				<% end if %>
			</div>
		</div>
<% If Not(Trim(hspchk(1)))="hsproject" Then %>
	</div>
</div>
<% End If %>

<script type="text/javascript" src="/lib/js/jquery.flowslider.js"></script>
<script type="text/javascript">
$(function(){
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
		loop: true,
		speed:1200,
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

	$(".form .choice li button").click(function(){
		//alert( $(this).val() );
		frmcom.gubunval.value = $(this).val()

		$(".form .choice li button").removeClass("on");
		if ( $(this).hasClass("on")) {
			$(this).removeClass("on");
		} else {
			$(this).addClass("on");
		}
	});

	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 3200 ) {
			brandAnimation()
		}
		if (scrollTop > 5900 ) {
			finishAnimation()
		}
	});

	/* title animation */
	titleAnimation()
	$(".heySomething .topic h2 span").css({"opacity":"0"});
	$(".heySomething .topic h2 .letter1").css({"margin-top":"7px"});
	$(".heySomething .topic h2 .letter2").css({"margin-top":"15px"});
	$(".heySomething .topic h2 .letter3").css({"margin-top":"23px"});
	function titleAnimation() {
		$(".heySomething .topic h2 .letter1").delay(400).animate({"margin-top":"0", "opacity":"1"},800);
		$(".heySomething .topic h2 .letter2").delay(800).animate({"margin-top":"7px", "opacity":"1"},800);
		$(".heySomething .topic h2 .letter3").delay(1200).animate({"margin-top":"17px", "opacity":"1"},800);
		$(".heySomething .topic h2 .letter4").delay(1800).animate({"opacity":"1"},800);
	}

	/* brand animation */
	$(".heySomething .brand p").css({"height":"0", "opacity":"0"});
	$(".heySomething .brand .btnDown").css({"margin-top":"70px", "opacity":"0"});
	function brandAnimation() {
		$(".heySomething .brand p").delay(500).animate({"height":"721px", "opacity":"1"},1800);
		$(".heySomething .brand .btnDown").delay(3000).animate({"margin-top":"62px", "opacity":"1"},800);
	}

	/* finish animation */
	$(".heySomething .finish p em").css({"opacity":"0"});
	$(".heySomething .finish p .letter1").css({"margin-left":"7px"});
	$(".heySomething .finish p .letter2").css({"margin-left":"7px"});
	$(".heySomething .finish p span").css({"width":"0"});
	function finishAnimation() {
		$(".heySomething .finish p .letter1").delay(400).animate({"margin-left":"0", "opacity":"1"},800);
		$(".heySomething .finish p .letter2").delay(900).animate({"margin-left":"0", "opacity":"1"},800);
		$(".heySomething .finish p span").delay(1500).animate({"width":"68px", "opacity":"1"},800);
	}
});
</script>

<!-- #include virtual="/lib/db/dbclose.asp" -->