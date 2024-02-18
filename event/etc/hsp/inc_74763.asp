<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈
' History : 2016-12-06 이종화 생성
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
	eCode   =  66250
Else
	eCode   =  74763
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
.heySomething .topic {background-color:#b5977d; z-index:1;}
.heySomething .topic h2 span{background:url(http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_hey_something_project_white.png) no-repeat 0 0}

/* item */
.heySomething .itemB {padding-bottom:355px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/hey/common/bg_line.png);}
.heySomething .itemB a.goItem {display:block;}
.heySomething .itemB .desc {position:relative; margin-top:48px; padding-left:576px; min-height:410px;}
.heySomething .itemB .desc .option {position:absolute; top:30px; left:83px;}
.heySomething .itemB .option .price {margin-top:56px; height:auto;}
.heySomething .itemB .option .discount {position:absolute; top:-16px; left:265px; padding-top:0px;}
.heySomething .itemB .option .substance {position:static; padding-top:56px;}
.heySomething .itemB .option .btnget {position:static; padding-top:35px;}
.heySomething .itemB .slidewrap {width:561px; padding-top:50px;}
.heySomething .itemB .slidewrap .slide {width:561px; height:432px;}
.heySomething .itemB .slidewrap .slide .slidesjs-navigation {top:215px;}
.heySomething .itemB .slidewrap .slide .slidesjs-previous {left:520px;}
.heySomething .itemB ul.slidesjs-pagination {width:100%; position:absolute; bottom:-355px;}
.heySomething .itemB .slidesjs-pagination li {margin:50px auto;}
.heySomething .itemB .slidesjs-pagination li a {width:217px; height:157px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/74763/bg_pagination.png);}
.heySomething .itemB .slidesjs-pagination .num02 a {background-position:-257px 0;}
.heySomething .itemB .slidesjs-pagination .num02 a:hover, .heySomething .itemB .slidesjs-pagination .num02 .active {background-position:-257px  100%;}
.heySomething .itemB .slidesjs-pagination .num03 a {background-position:-514px 0;}
.heySomething .itemB .slidesjs-pagination .num03 a:hover, .heySomething .itemB .slidesjs-pagination .num03 .active {background-position:-514px 100%;}
.heySomething .itemB .slidesjs-pagination .num04 a {background-position:100% 0;}
.heySomething .itemB .slidesjs-pagination .num04 a:hover, .heySomething .itemB .slidesjs-pagination .num04 .active {background-position:100% 100%;}

/* visual */
.visual {width:1140px; margin:435px auto 445px;}

/* colorType */
.colorType {position:relative; height:382px; padding-top:122px; background:#eccfcf;}
.colorType .swiper-container {width:100%; height:100%;}
.colorType .swiper-slide {position:relative; float:left; width:352px; height:504px; text-align:center;}
.colorType .swiper-slide .on {display:none; position:absolute; left:50%; top:0; margin-left:-136px;}
.colorType .swiper-slide.color01 .on {display:block;}
.colorType .swiper-slide.color01 .off {display:none;}
.colorType .swiper-pagination {position:absolute; left:50%; top:200px; z-index:30; margin-left:201px;}
.colorType .swiper-pagination span {display:inline-block; width:22px; height:22px; margin:0 5px; cursor:pointer;}
.colorList {position:absolute; left:50%; top:67px; margin-left:146px}
.colorList li {display:none; position:absolute; left:0; top:0;z-index:20;}
.colorList li.color01 {display:block;}

/* brand */
.heySomething .brand {position:relative; height:670px; margin:525px 0 265px;}
.heySomething .brand h4 {margin-bottom:100px;}
.heySomething .brand p.brandTxt01 {margin-bottom:43px;}
.heySomething .brand p.brandTxt02 {margin-bottom:55px;}

/* look */
.look {position:relative; width:1140px; height:1170px; margin:0 auto;}
.look ul li {position:absolute; top:0; left:0; }
.look ul li:first-child {position:absolute; top:337px; left:155px; }
.look ul li:nth-child(2){position:absolute; top:770px; left:155px; }
.look ul li:nth-child(3){position:absolute; top:123px; left:595px;}
.look ul li:nth-child(4){position:absolute; top:665px; left:595px;}

/* story */
.heySomething .story {margin-top:325px; padding-bottom:120px;}
.heySomething .story h6 {padding-bottom:65px;}
.heySomething .rolling {position:relative; padding-top:170px;}
.heySomething .rollingwrap {margin-top:0;}
.heySomething .rolling .swiper-pagination-switch {width:145px; height:130px; margin:0 20px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/74763/bg_ico_01_v3.png) no-repeat 0 0;}
.heySomething .rolling .pagination {top:0; padding-left:135px;}
.heySomething .rolling .pagination span:first-child {background-position:0 0;}
.heySomething .rolling .pagination span.swiper-active-switch {background-position:0 100%;}
.heySomething .rolling .pagination span:first-child + span {background-position: -190px 0;}
.heySomething .rolling .pagination span:first-child + span.swiper-active-switch {background-position:-190px 100%;}
.heySomething .rolling .pagination span:first-child + span + span {background-position:-395px 0;}
.heySomething .rolling .pagination span:first-child + span + span.swiper-active-switch {background-position:-395px 100%;}
.heySomething .rolling .pagination span:first-child + span + span + span {background-position:-580px 0;}
.heySomething .rolling .pagination span:first-child + span + span + span.swiper-active-switch {background-position:-580px 100%;}
.heySomething .rolling .pagination span em {position:absolute; width:980px; height:45px; margin-left:110px; top:850px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/74763/txt_desc_v3.png); cursor:default;}
.heySomething .rolling .pagination span em.desc1 {background-position:0 0;}
.heySomething .rolling .pagination span em.desc2 {background-position:0 -63px;}
.heySomething .rolling .pagination span em.desc3 {background-position:0 -135px;}
.heySomething .rolling .pagination span em.desc4 {background-position:0 100%;}
.heySomething .rolling .btn-nav {top:480px;}
.heySomething .swipemask {height:100%; }

/* finish */
.heySomething .finish {height:495px; margin-top:300px; background:#d7ccbc url(http://webimage.10x10.co.kr/eventIMG/2016/hey/74763/bg_finish.jpg) 50% 0 no-repeat; text-indent:-999em;}
.heySomething .finish a {display:block; position:absolute; left:50%; top:0; width:1140px; height:100%; margin-left:-500px;}
.heySomething .finish p {position:absolute; left:0; background:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/74763/txt_finish.png) 0 0 no-repeat;}
.heySomething .finish p.t01 {top:160px; width:226px; height:65px;}
.heySomething .finish p.t02 {top:280px; width:226px; height:55px; background-position:0 100%;}

/* comment */
.heySomething .commentevet {margin-top:320px;}
.heySomething .commentevet textarea {margin-top:36px;}
.heySomething .commentevet .form {margin-top:35px;}
.heySomething .commentevet .form .choice {margin-left:0px;}
.heySomething .commentevet .form .choice li{width:160px; height:110px;}
.heySomething .commentevet .form .choice li button, .heySomething .commentevet .form .choice li button.on {width:110px; height:110px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/74763/bg_ico_02.png);}
.heySomething .commentevet .form .choice li.ico1 button{background-position:0 0}
.heySomething .commentevet .form .choice li.ico1 button.on{background-position:0 100%}
.heySomething .commentevet .form .choice li.ico2 button{background-position:-160px 0;}
.heySomething .commentevet .form .choice li.ico2 button.on{background-position:-160px 100%;}
.heySomething .commentevet .form .choice li.ico3 button{background-position:-315px 0;}
.heySomething .commentevet .form .choice li.ico3 button.on{background-position:-315px 100%;}
.heySomething .commentevet .form .choice li.ico4 button{background-position:100% 0;}
.heySomething .commentevet .form .choice li.ico4 button.on{background-position:100% 100%;}
.heySomething .commentevet textarea {margin-top:65px;}
.heySomething .commentlist table td {padding:10px 0;}
.heySomething .commentlist table td strong {width:110px; height:110px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/74763/bg_ico_03.png); background-position:0 0;}
.heySomething .commentlist table td .ico2 {background-position:-110px 0;}
.heySomething .commentlist table td .ico3 {background-position:-220px 0;}
.heySomething .commentlist table td .ico4 {background-position:100% 0;}
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
		<% If not( left(currenttime,10)>="2016-12-07" and left(currenttime,10)<"2016-12-14" ) Then %>
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
			<div class="bnr"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74763/img_item_represent_v2.jpg" alt="스누피와 친구들 &amp; 가필드 2017 캘린더" /></div>
		</div>

		<%' about %>
		<div class="about">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
			<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
		</div>

		<%' item %>
		<div class="item itemB">
			<div class="inner">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74763/txt_laundary.jpg" alt="laundry.mat" /></h3>
			<a href="/shopping/category_prd.asp?itemid=1614923&amp;pEtr=74763">
			<%' for dev msg : 상품코드 1544319, 할인기간 8/24 ~ 8/30 할인기간이 지나면  <strong class="discount">...</strong> 숨겨주세요 %>
			<%
				IF application("Svr_Info") = "Dev" THEN
					itemid = 1239226
				Else
					itemid = 1614923
				End If
				set oItem = new CatePrdCls
					oItem.GetItemData itemid
			%>
			<div class="desc">
				<div class="option">
					<em class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74763/txt_name.png" alt="PETIT KNIT MUFFLER" /></em>
					<% If oItem.FResultCount > 0 Then %>
						<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
							<div class="price">
							<% If not( left(currenttime,10)>="2016-08-24" and left(currenttime,10)<="2016-08-30" ) Then %>
								<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74763/icon_one_plus_one.png" alt="1+1" /></strong>
								<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
							<% Else %>
								<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
							<% End If %>
								<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> (<%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%)</strong>
							</div>
						<% Else %>
							<%' for dev msg : 종료 후 %>
							<div class="price priceEnd">
								<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
							</div>
						<% End If %>
					<% End If %>
					<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74763/txt_substance.png" alt="더 따뜻한 당신의 일상을 위해, 귀여운 당신에게 어울리는 런드리맷 플러스의 8가지 쁘띠 머플러" /></p>
					<div class="btnget">
						<img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러 가기" />
					</div>
				</div>

				<div class="slidewrap">
					<div id="slide01" class="slide">
						<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74763/img_item_01.jpg" alt="" /></div>
						<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74763/img_item_02.jpg" alt="" /></div>
						<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74763/img_item_03.jpg" alt="" /></div>
						<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74763/img_item_04.jpg" alt="" /></div>
					</div>
				</div>
			</div>
			<%	set oItem = nothing %>
			</a>
			</div>
		</div>

		<%' visual%>
		<div class="visual"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74763/img_item.jpg" alt="" /></div>

		<%' color %>
		<div class="colorType">
			<div class="swiper-container">
				<div class="swiper-wrapper">
					<div class="swiper-slide color01">
						<div class="on"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74763/img_slide_muffler_01_on.png" alt="" /></div>
						<div class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74763/img_slide_muffler_01_off.png" alt="" /></div>
					</div>
					<div class="swiper-slide color02">
						<div class="on"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74763/img_slide_muffler_02_on.png" alt="" /></div>
						<div class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74763/img_slide_muffler_02_off.png" alt="" /></div>
					</div>
					<div class="swiper-slide color03">
						<div class="on"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74763/img_slide_muffler_03_on.png" alt="" /></div>
						<div class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74763/img_slide_muffler_03_off.png" alt="" /></div>
					</div>
					<div class="swiper-slide color04">
						<div class="on"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74763/img_slide_muffler_04_on.png" alt="" /></div>
						<div class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74763/img_slide_muffler_04_off.png" alt="" /></div>
					</div>
					<div class="swiper-slide color05">
						<div class="on"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74763/img_slide_muffler_05_on.png" alt="" /></div>
						<div class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74763/img_slide_muffler_05_off.png" alt="" /></div>
					</div>
					<div class="swiper-slide color06">
						<div class="on"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74763/img_slide_muffler_06_on.png" alt="" /></div>
						<div class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74763/img_slide_muffler_06_off.png" alt="" /></div>
					</div>
					<div class="swiper-slide color07">
						<div class="on"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74763/img_slide_muffler_07_on.png" alt="" /></div>
						<div class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74763/img_slide_muffler_07_off.png" alt="" /></div>
					</div>
					<div class="swiper-slide color08">
						<div class="on"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74763/img_slide_muffler_08_on.png" alt="" /></div>
						<div class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74763/img_slide_muffler_08_off.png" alt="" /></div>
					</div>
				</div>
				<div class="swiper-pagination"></div>
			</div>
			<ul class="colorList">
				<li class="color01"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74763/txt_slide_color_01.png" alt="" /></li>
				<li class="color02"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74763/txt_slide_color_02_v2.png" alt="" /></li>
				<li class="color03"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74763/txt_slide_color_03_v2.png" alt="" /></li>
				<li class="color04"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74763/txt_slide_color_04_v2.png" alt="" /></li>
				<li class="color05"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74763/txt_slide_color_05_v2.png" alt="" /></li>
				<li class="color06"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74763/txt_slide_color_06_v2.png" alt="" /></li>
				<li class="color07"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74763/txt_slide_color_07_v2.png" alt="" /></li>
				<li class="color08"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74763/txt_slide_color_08_v2.png" alt="" /></li>
			</ul>
		</div>

		<%' brand %>
		<div class="brand">
			<h4><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74763/txt_brand_01.png" alt="laundry.mat+" /></h4>
			<p class="brandTxt01"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74763/txt_brand_02.png" alt="오늘도 똑같은 하루를 시작합니다. 어찌보면 평범하고 지루하기 짝이 없는 날인 것 같아도 그 안에서 우리는 소소한 하루를 보내고 있습니다. 마음 먹은 일이 뜻대로 되지 않을 때 또는 예기치 못한 행운을 발견하였을 때 이렇게 생각해보면 어떨까요? “이게 다 내가 귀여운 탓이다!” " /></p>
			<p class="brandTxt02"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74763/txt_brand_03.png" alt="여기, 귀여운 당신에게 어울리는 8가지 머플러를 만나보세요" /></p>
			<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="" /></div>
		</div>

		<%' look %>
		<div class="look">
			<h5><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74763/txt_happy_together.png" alt="HAPPY TOGETHER 함께하면 더욱 따뜻해지는 겨울! 1+1으로 친구와 연인과 가족과 함께 따스함을 나누세요" /></h5>
			<ul>
				<li><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74763/img_happy_01.jpg" alt="" /></li>
				<li><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74763/img_happy_02.jpg" alt="" /></li>
				<li><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74763/img_happy_03.jpg" alt="" /></li>
				<li><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74763/img_happy_04.jpg" alt="" /></li>
			</ul>
		</div>

		<%' story %>
		<div class="story">
			<h6><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74763/tit_special_day.png" alt="소소하지만 사소하지 않은, 우리의 특별한 날들" /></h6>
			<div class="rollingwrap">
				<div class="rolling rolling1">
					<div class="swipemask mask-left"></div>
					<div class="swipemask mask-right"></div>
					<button type="button" class="btn-nav arrow-left">Previous</button>
					<button type="button" class="btn-nav arrow-right">Next</button>
					<div class="swiper">
						<div class="swiper-container swiper1">
							<div class="swiper-wrapper">
								<div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1614923&amp;pEtr=74763"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74763/img_slide_01.jpg" alt="# coffee time 카페에 흐르던 음악, 그때의 커피 향기 소소한 커피타임에 어울리는 BEIGE & BROWN" /></a></div>
								<div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1614923&amp;pEtr=74763"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74763/img_slide_02.jpg" alt="# happy birthday 사랑스러운 너를 위해, 이세상 가장 따뜻한 케익을 준비했어! PINK & RASPBERRY" /></a></div>
								<div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1614923&amp;pEtr=74763"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74763/img_slide_03.jpg" alt="# gloomy day 오늘처럼 조금 우울한 날에는 그 우울함마저도 즐기는 건 어떨까요, GRAY & BLUE" /></a></div>
								<div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1614923&amp;pEtr=74763"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74763/img_slide_04.jpg" alt="# merry christmas 올해 크리스마스에도 사랑하는 가족, 연인, 친구와 함께 더 따뜻하게! WINE & GREEN" /></a></div>
							</div>
						</div>
					</div>
					<div class="pagination"></div>
				</div>
			</div>
		</div>

		<%' finish %>
		<div class="finish">
			<a href="/street/street_brand_sub06.asp?makerid=laundrymat001">
				<p class="t01">소소한 나의 하루에 따스한 귀여움 더하기</p>
				<p class="t02">LAUNDRY.MAT +</p>
			</a>
		</div>
		
		<%' comment %>
		<div class="commentevet">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74763/tit_comment.png" alt="Hey, something project, 올 한해, 가장 고마웠던 사람은 누구인가요?" /></h3>
			<p class="hidden">정성껏 코멘트를 남겨주신 5분을 추첨하여 PETIT WOOL MUFFLER 제품을 1+1으로 선물 드립니다. (컬러 랜덤)</p>
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
							<li class="ico1"><button type="button" value="1"># coffee time</button></li>
							<li class="ico2"><button type="button" value="2"># happy birthday</button></li>
							<li class="ico3"><button type="button" value="3"># gloomy day</button></li>
							<li class="ico4"><button type="button" value="4"># merry christmas</button></li>
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
												# coffee time
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="2" then %>
												# happy birthday
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="3" then %>
												# gloomy day
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="4" then %>
												# merry christmas
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
		width:"561",
		height:"432",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:1800, effect:"fade", auto:true},
		effect:{fade: {speed:700, crossfade:true}
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
	$(".slidesjs-pagination li:nth-child(1)").addClass("num01");
	$(".slidesjs-pagination li:nth-child(2)").addClass("num02");
	$(".slidesjs-pagination li:nth-child(3)").addClass("num03");
	$(".slidesjs-pagination li:nth-child(4)").addClass("num04");

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
		if (scrollTop > 4200 ) {
			brandAnimation01()
		}
		if (scrollTop > 5400 ) {
			lookAnimation()
		}
		if (scrollTop > 8100 ) {
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
		$(".heySomething .topic h2 .letter1").delay(300).animate({"margin-top":"0", "opacity":"1"},800);
		$(".heySomething .topic h2 .letter2").delay(700).animate({"margin-top":"7px", "opacity":"1"},800);
		$(".heySomething .topic h2 .letter3").delay(1100).animate({"margin-top":"17px", "opacity":"1"},800);
	}

	$(".brand p").css({"opacity":"0"});
	$(".brand h4").css({"margin-top":"7px","opacity":"0"});
	$(".brand .brandTxt01").css({"margin-top":"7px"});
	$(".brand .brandTxt01").css({"margin-top":"15px"});
	$(".brand .btnDown").css({"opacity":"0"});
	function brandAnimation01() {
		$(".brand h4").delay(100).animate({"margin-top":"0px","opacity":"1"},900);
		$(".brand .brandTxt01").delay(500).animate({"margin-top":"7px","opacity":"1"},900);
		$(".brand .brandTxt02").delay(900).animate({"margin-top":"17px","opacity":"1"},900);
		$(".brand .btnDown").delay(1200).animate({"opacity":"1"},1000);
	}

	$(".look li").css({"margin-top":"10px","opacity":"0"});
	function lookAnimation() {
		$(".look li:first-child").delay(0).animate({"margin-top":"0px","opacity":"1"},1000);
		$(".look li:nth-child(2)").delay(400).animate({"margin-top":"0px","opacity":"1"},1000);
		$(".look li:nth-child(3)").delay(700).animate({"margin-top":"0px","opacity":"1"},1000);
		$(".look li:nth-child(4)").delay(900).animate({"margin-top":"0px","opacity":"1"},1000);
	}

	$(".heySomething .finish p.t01").css({"margin-left":"-20px","opacity":"0"});
	$(".heySomething .finish p.t02").css({"margin-left":"-20px","opacity":"0"});
	function finishAnimation() {
		$(".heySomething .finish p").delay(100).animate({"margin-left":"0","opacity":"1"},1000);
	}
});

$(function(){
	var colorSwiper = new Swiper('.colorType .swiper-container',{
		loop:true,
		autoplay:2000,
		speed:1000,
		centeredSlides:true,
		pagination:'.swiper-pagination',
		paginationClickable: true,
		slidesPerView:'auto',
		onSlideChangeStart: function(swiper){
			$(".swiper-slide").find(".on").delay(100).css('display','none');
			$(".swiper-slide-active").find(".on").delay(100).css('display','block');
			$(".swiper-slide").find(".off").delay(100).css('display','block');
			$(".swiper-slide-active").find(".off").delay(100).css('display','none');
			$('.colorList li').css('display','none');
			if ($('.swiper-slide-active').is(".color01")) {
				$('.colorType').css('background','#eccfcf');
				$('.colorList .color01').css('display','block');
			}
			if ($('.swiper-slide-active').is(".color02")) {
				$('.colorType').css('background','#e5e0d3');
				$('.colorList .color02').css('display','block');
			}
			if ($('.swiper-slide-active').is(".color03")) {
				$('.colorType').css('background','#dcdcdc');
				$('.colorList .color03').css('display','block');
			}
			if ($('.swiper-slide-active').is(".color04")) {
				$('.colorType').css('background','#d1d4cc');
				$('.colorList .color04').css('display','block');
			}
			if ($('.swiper-slide-active').is(".color05")) {
				$('.colorType').css('background','#d3a8a8');
				$('.colorList .color05').css('display','block');
			}
			if ($('.swiper-slide-active').is(".color06")) {
				$('.colorType').css('background','#c2c8d1');
				$('.colorList .color06').css('display','block');
			}
			if ($('.swiper-slide-active').is(".color07")) {
				$('.colorType').css('background','#b6a79d');
				$('.colorList .color07').css('display','block');
			}
			if ($('.swiper-slide-active').is(".color08")) {
				$('.colorType').css('background','#e6d8d8');
				$('.colorList .color08').css('display','block');
			}
		}
	})
});
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->