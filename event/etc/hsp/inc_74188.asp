<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈 : DAILYLIKE 전기방석
' History : 2016-11-15 원승현 생성
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
'	currenttime = #11/09/2016 09:00:00#

dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  66236
Else
	eCode   =  74188
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
.heySomething .topic {background-color:#e8e6db; z-index:1;}

/* item */
.heySomething .itemB {padding-bottom:470px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/74188/bg_line.png);}
.heySomething .itemB .plus {position:absolute; left:50%; top:640px; margin-left:-22px;}
.heySomething .itemB a.goItem {display:block;}
.heySomething .itemB .desc {padding-left:620px; min-height:410px;}
.heySomething .itemB .desc .option {top:105px;}
.heySomething .itemB .option .price {margin-top:55px;}
.heySomething .itemB .option .substance {position:static; padding-top:25px;}
.heySomething .itemB .option .btnget {position:static; padding-top:50px;}
.heySomething .itemB .slidewrap {width:400px; padding-top:115px;}
.heySomething .itemB .slidewrap .slide {width:400px; height:400px;}
.heySomething .itemB .slidesjs-pagination {bottom:-430px;}
.heySomething .itemB .slidesjs-pagination li a {width:215px; height:212px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/74188/bg_pagination.jpg);}
.heySomething .itemB .slidesjs-pagination .num02 a {background-position:-215px 0;}
.heySomething .itemB .slidesjs-pagination .num02 a:hover, .heySomething .itemB .slidesjs-pagination .num02 .active {background-position:-215px 100%;}
.heySomething .itemB .slidesjs-pagination .num03 a {background-position:-430px 0;}
.heySomething .itemB .slidesjs-pagination .num03 a:hover, .heySomething .itemB .slidesjs-pagination .num03 .active {background-position:-430px 100%;}
.heySomething .itemB .slidesjs-pagination .num04 a {background-position:100% 0;}
.heySomething .itemB .slidesjs-pagination .num04 a:hover, .heySomething .itemB .slidesjs-pagination .num04 .active {background-position:100% 100%;}

/* brand */
.heySomething .feature {text-align:center; margin-top:375px;}
.heySomething .feature ul {position:relative; width:1140px; height:632px; margin:56px auto 0;}
.heySomething .feature li {position:absolute; }
.heySomething .feature li div {width:100%; height:100%; background-position:50% 50%; background-size:120%;}
.heySomething .feature li.f01 {left:0; top:0; width:215px; height:223px; background-color:#d8a3a3;}
.heySomething .feature li.f01 div {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/74188/img_temperature_01.jpg);}
.heySomething .feature li.f02 {left:231px; top:0; width:215px; height:223px; background-color:#b7c8cb;}
.heySomething .feature li.f02 div {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/74188/img_temperature_02.jpg);}
.heySomething .feature li.f03 {left:0; bottom:0; width:447px; height:393px; background-color:#fee5c4;}
.heySomething .feature li.f03 div {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/74188/img_temperature_03.jpg);}
.heySomething .feature li.f04 {right:0; bottom:0; width:679px; height:632px; background-color:#ebe7de;}
.heySomething .feature li.f04 div {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/74188/img_temperature_04.jpg);}
.heySomething .brand {position:relative; height:1415px; margin-top:420px;}
.heySomething .brand .pic {position:relative; height:878px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/74188/bg_brand.jpg) 50% 0 no-repeat;}
.heySomething .brand .pic a {display:block; position:absolute; left:50%; top:0; width:1140px; height:100%; margin-left:-570px; text-indent:-999em;}
.heySomething .brand .text {padding-top:80px;}
.heySomething .brand .btnDown {margin-top:85px;}

/* story */
.heySomething .story {margin-top:360px; padding-bottom:120px;}
.heySomething .rolling {padding-top:215px;}
.heySomething .rolling .swiper-pagination-switch {width:150px; height:180px; margin:0 40px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/74188/bg_ico_01.png);}
.heySomething .rolling .pagination {top:0; padding-left:146px;}
.heySomething .rolling .pagination span em {bottom:-785px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/74188/txt_desc.png); cursor:default;}
.heySomething .rolling .pagination span:first-child {background-position:0 0;}
.heySomething .rolling .pagination span.swiper-active-switch {background-position:0 -180px;}
.heySomething .rolling .pagination span:first-child + span {background-position:-150px 0;}
.heySomething .rolling .pagination span:first-child + span.swiper-active-switch {background-position:-150px -180px;}
.heySomething .rolling .pagination span:first-child + span + span {background-position:-300px 0;}
.heySomething .rolling .pagination span:first-child + span + span.swiper-active-switch {background-position:-300px -180px;}
.heySomething .rolling .pagination span:first-child + span + span + span {background-position:-450px 0;}
.heySomething .rolling .pagination span:first-child + span + span + span.swiper-active-switch {background-position:-450px -180px;}
.heySomething .rolling .btn-nav {top:510px;}
.heySomething .swipemask {top:215px;}

/* finish */
.heySomething .finish {height:712px; background:#e3dbbb url(http://webimage.10x10.co.kr/eventIMG/2016/hey/74188/bg_finish.jpg) 50% 0 no-repeat; text-indent:-999em;}
.heySomething .finish a {display:block; position:absolute; left:50%; top:0; width:1140px; height:100%; margin-left:-570px;}
.heySomething .finish p {position:absolute; left:0; background:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/74188/txt_finish.png) 0 0 no-repeat;}
.heySomething .finish p.t01 {top:227px; width:334px; height:34px;}
.heySomething .finish p.t02 {top:278px; width:264px; height:48px; background-position:0 100%;}

/* comment */
.heySomething .commentevet {margin-top:430px;}
.heySomething .commentevet textarea {margin-top:40px;}
.heySomething .commentevet .form {margin-top:45px;}
.heySomething .commentevet .form .choice {margin-left:-10px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/74188/bg_ico_02.png);}
.heySomething .commentlist table td {padding:10px 0;}
.heySomething .commentlist table td strong {height:150px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/74188/bg_ico_02.png); background-position:0 0;}
.heySomething .commentlist table td .ico2 {background-position:-150px 0;}
.heySomething .commentlist table td .ico3 {background-position:-300px 0;}
.heySomething .commentlist table td .ico4 {background-position:-450px 0;}
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
		<% If not( left(currenttime,10)>="2016-11-15" and left(currenttime,10)<"2018-01-01" ) Then %>
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
			location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/eventmain.asp?eventid="&eCode)%>';
			return;
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
			location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/eventmain.asp?eventid="&eCode)%>';
			return;
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
			<div class="bnr"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74188/img_item_represent.jpg" alt="소소한 일상에 온기를 더하다 Dailylike 전기방석" /></div>
		</div>

		<%' about %>
		<div class="about">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
			<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
		</div>

		<%' item %>
		<div class="item itemB">
			<div class="inner">
				<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74188/txt_dailylike.png" alt="Dailylike" /></h3>
				<%
					IF application("Svr_Info") = "Dev" THEN
						itemid = 1239226
					Else
						itemid = 1599887
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
				%>
				<a href="/shopping/category_prd.asp?itemid=1599887&amp;pEtr=74188" class="goItem">
					<div class="desc">
						<div class="option">
							<em class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74188/txt_name.png" alt="[Dailylike] 전기방석" /></em>
							<%' for dev msg : 상품코드 1599887 할인기간 11/16~1122 할인기간이 지나면 <strong class="discount">...</strong> 숨겨주세요 %>
							<% If oItem.FResultCount > 0 Then %>
								<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
									<div class="price">
										<% If not( left(currenttime,10)>="2016-11-16" and left(currenttime,10)<="2016-11-22" ) Then %>
										<% Else %>
											<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/txt_only_20percent.png" alt="단, 일주일만 ONLY 20%" /></strong>
											<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
										<% End If %>
										<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
									</div>
								<% else %>
									<%' for dev msg : 종료 후 %>
									<div class="price priceEnd" style="display:none;">
										<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
									</div>
								<% End If %>
							<% End If %>
							<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74188/txt_substance.png" alt="데일리라이크의 동물 친구들과 함께 따스한 겨울나기" /></p>
							<div class="btnget">
								<img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러 가기" />
							</div>
						</div>
						<div class="slidewrap">
							<div id="slide01" class="slide">
								<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74188/img_item_01.jpg" alt="" /></div>
								<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74188/img_item_02.jpg" alt="" /></div>
								<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74188/img_item_03.jpg" alt="" /></div>
								<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74188/img_item_04.jpg" alt="" /></div>
							</div>
						</div>
					</div>
				</a>
				<span class="plus"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/ico_plus.png" alt="" /></span>
			</div>
		</div>
		<%	set oItem = nothing %>

		<%' brand %>
		<div class="feature">
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74188/txt_temperature.gif" alt="Temperature Control 안전 온도 조절기로 고/저 2단계 설정이 가능하며 과열에 대비한 자동 차단 기능이 있어 더욱 안전합니다." /></p>
			<ul>
				<li class="f01"><div></div></li>
				<li class="f02"><div></div></li>
				<li class="f03"><div></div></li>
				<li class="f04"><div></div></li>
			</ul>
		</div>
		<div class="brand">
			<div class="pic"><a href="/shopping/category_prd.asp?itemid=1599887&amp;pEtr=74188">데일리라이크 전기방석</a></div>
			<div class="text">
				<p><a href="/street/street_brand_sub06.asp?makerid=dailylike"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74188/txt_brand.png" alt="소소한 당신의 일상을 응원합니다. 차 한 잔의 따뜻하고 작은 수다를 즐기고 직접 구운 쿠키를 나누어 먹을 줄 알며 아끼는 옷은 오래오래 입고 직접 쓴 연필 글씨에 더 감동합니다. 누군가의 이야기라면 조용히 귀담아 들을 줄 아는 그 누구보다 자신의 작은 주변을 아끼고 사랑하는 착한 쉼표, 데일리라이크" /></a></p>
			</div>
			<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="" /></div>
		</div>

		<%' story %>
		<div class="story">
			<div class="rollingwrap">
				<div class="rolling rolling1">
					<div class="swipemask mask-left"></div>
					<div class="swipemask mask-right"></div>
					<button type="button" class="btn-nav arrow-left">Previous</button>
					<button type="button" class="btn-nav arrow-right">Next</button>
					<div class="swiper">
						<div class="swiper-container swiper1">
							<div class="swiper-wrapper">
								<div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1599887&amp;pEtr=74188"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74188/img_slide_01.jpg" alt="#알파카:촉감이 좋고 부드러워서 너무 좋아하는 알파카 털실의 주인공이었네요! 그 귀엽고 부드러운 털을 상상하며 작고 귀여운 아기 알파카를 그렸답니다. 부드럽고 따뜻할 것 같은 모습이 내 귀여운 친구를 닮았네요." /></a></div>
								<div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1599887&amp;pEtr=74188"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74188/img_slide_02.jpg" alt="#플라밍고:아무 이유 없이 그냥 좋아하는 것 들이 있습니다. 한 번도 본 적 없는 플라밍고. 깃털의 화려한 색깔 때문일까요? 그 오묘한 빛깔과 우아한 자태 때문일까요?" /></a></div>
								<div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1599887&amp;pEtr=74188"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74188/img_slide_03.jpg" alt="#크리스마스:곧 다가올 크리스마스를 위해 집 앞 나무와 빨갛게 열린 열매를 따고 땅에 떨어져 있는 솔방울도 주워다 올려 놓아 볼 생각이에요.재즈 풍의 캐럴을 은은하게 틀어놓고, 그들과 함께 할 시간을 기다려 봅니다" /></a></div>
							</div>
						</div>
					</div>
					<div class="pagination"></div>
				</div>
			</div>
		</div>

		<%' finish %>
		<div class="finish">
			<a href="/street/street_brand_sub06.asp?makerid=dailylike">
				<p class="t01">We like Dailylike</p>
				<p class="t02">소소한 일상처럼 언제나 당신 곁에 데일리라이크</p>
			</a>
		</div>

		<%' comment %>
		<div class="commentevet">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74188/tit_comment.png" alt="Hey, something project, 당신이 갖고 싶은 것" /></h3>
			<p class="hidden">데일리라이크의 감성이 담긴 패턴 3가지 중, 가장 마음에 와닿는 패턴과 그 이유를 남겨주세요. 정성껏 코멘트를 남겨주신 3분에게 데일리라이크의 방석을 선물로 드립니다. (디자인 랜덤 발송)</p>

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
							<li class="ico1"><button type="button" value="1">#ALPACA</button></li>
							<li class="ico2"><button type="button" value="2">#FLAMINGO</button></li>
							<li class="ico3"><button type="button" value="3">#CHRISTMAS</button></li>
						</ul>
						<textarea title="코멘트 쓰기" cols="60" rows="5" name="txtcomm1" id="txtcomm1" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();" <%IF NOT(IsUserLoginOK) THEN%>readonly<%END IF%>><%IF NOT IsUserLoginOK THEN%>로그인 후 글을 남길 수 있습니다.<% else %><%END IF%></textarea>
						<div class="note01 overHidden">
							<ul class="list01 ftLt">
								<li>입력하신 블로그 주소는 개인정보 유출로 인한 피해를 막고자 비공개로 텐바이텐에 접수됩니다.</li>
								<li>통신예절에 어긋나는 글이나 상업적인 글, 타 사이트에 관련된 글 또는 도용한 글은 관리자에 의해 사전 통보 없이 삭제될 수 있으며,<br>이벤트 참여에 제한을 받을 수 있습니다.</li>
							</ul>
							<input type="submit" class="ftRt btn btnW130 btnS1 btnRed" value="코멘트 남기기" onclick="jsSubmitComment(document.frmcom);return false;">
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
												#ALPACA
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="2" then %>
												#FLAMINGO
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="3" then %>
												#CHRISTMAS
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
						<% next %>
					</tbody>
				</table>
				<%' paging %>
				<div class="pageWrapV15">
					<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
				</div>
				<% end if %>
			</div>
		</div>
		<%'' // 수작업 영역 끝 %>
<% If Not(Trim(hspchk(1)))="hsproject" Then %>
	</div>
<% End If %>
<script type="text/javascript" src="/lib/js/jquery.flowslider.js"></script>
<script>
$(function(){
	/* slide js */
	$("#slide01").slidesjs({
		width:"400",
		height:"400",
		pagination:{effect:"fade"},
		navigation:false,
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
		if (scrollTop > 2650 ) {
			feaureAnimation()
		}
		if (scrollTop > 4500 ) {
			brandAnimation()
		}
		if (scrollTop > 7000 ) {
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

	$(".feature li div").css({"opacity":"0"});
	function feaureAnimation() {
		$(".feature li.f01 div").delay(100).animate({backgroundSize:"100%","opacity":"1"},900);
		$(".feature li.f02 div").delay(300).animate({backgroundSize:"100%","opacity":"1"},900);
		$(".feature li.f03 div").delay(200).animate({backgroundSize:"100%","opacity":"1"},900);
		$(".feature li.f04 div").delay(400).animate({backgroundSize:"100%","opacity":"1"},900);
	}

	$(".heySomething .brand .text").css({"height":"0","opacity":"0"});
	$(".heySomething .brand .btnDown").css({"opacity":"0"});
	function brandAnimation() {
		$(".heySomething .brand .text").delay(100).animate({"height":"288px","opacity":"1"},1000);
		$(".heySomething .brand .btnDown").delay(1200).animate({"opacity":"1"},1000);
	}

	$(".heySomething .finish p.t01").css({"margin-left":"-10px","opacity":"0"});
	$(".heySomething .finish p.t02").css({"margin-left":"10px","opacity":"0"});
	function finishAnimation() {
		$(".heySomething .finish p").delay(100).animate({"margin-left":"0","opacity":"1"},1000);
	}
});
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->