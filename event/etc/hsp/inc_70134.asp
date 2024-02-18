<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈 26
' History : 2016-03-22 이종화 생성
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
	eCode   =  66103
Else
	eCode   =  70134
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
.heySomething .topic {background-color:#f7f3f1; z-index:1;}

/* wide slide */
.slide {position:relative; margin-top:255px;}
.slide .slidesjs-navigation {display:block; position:absolute; top:50%; z-index:500; width:50px; height:70px; margin-top:-35px; background-image:url(http://fiximage.10x10.co.kr/web2015/event/btn_slide_nav.png); background-repeat:no-repeat; background-color:transparent; text-indent:-9999px;}
.slide .slidesjs-previous {background-position:50% 0;}
.slide .slidesjs-previous:hover {background-position:50% -100px;}
.slide .slidesjs-next {background-position:50% -200px;}
.slide .slidesjs-next:hover {background-position:50% -300px;}
.slide .slidesjs-pagination {display:block; position:absolute; left:50%; bottom:23px; z-index:50; width:1140px; height:24px; margin-left:-570px; text-align:center;}
.slide .slidesjs-pagination li {display:inline;}
.slide .slidesjs-pagination li a {display:inline-block; width:24px; height:24px; font-size:0; line-height:0; color:transparent; cursor:pointer; vertical-align:top; background:url(http://fiximage.10x10.co.kr/web2015/event/btn_slide_pagination.png) no-repeat 0 0;}
.slide .slidesjs-pagination li a.active {background-position:100% 0;}
.slide .slidesjs-container, .slide .slidesjs-control {height:835px !important;}
.slide .swiper-slide {overflow:hidden; height:800px; background-repeat:repeat; background-position:0 0;}
.slide .swiper-slide img {display:block; position:absolute; left:50%; top:0; width:1920px; height:835px; margin-left:-960px;}
.slide .slidesjs-navigation {left:50%;}
.slide .slidesjs-previous {margin-left:-555px;}
.slide .slidesjs-next {margin-left:505px;}

/* brand */
.heySomething .brand {position:relative; width:1140px; height:935px; margin:200px auto 0;}

/* item */
.heySomething .item {width:1140px; padding:118px 0; margin:0 auto; background:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/70134/bg_dash.png) 50% 0 no-repeat;}
.heySomething .item h3 {position:relative; height:41px; margin:360px 0 135px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/70134/bg_line.png) 0 0 no-repeat;}
.heySomething .item h3 span {position:absolute; top:0; opacity:0;}
.heySomething .item h3 span.t01 {left:332px;}
.heySomething .item h3 span.t02 {left:633px;}
.heySomething .item .desc {position:relative; padding-left:84px;}
.heySomething .item .pic {position:absolute; left:626px; top:-15px;}
.heySomething .item.item01 {padding-top:0; background:none;}
.heySomething .item.item02 .desc {padding-left:694px;}
.heySomething .item.item02 .pic {left:72px;}
.heySomething .item.item03 {border-bottom:1px solid #ddd;}
.heySomething .item .option {text-align:left;}

/* story */
.heySomething .story {padding-top:0;}
.heySomething .story h3 {margin-bottom:50px;}
.heySomething .rolling {padding-top:165px;}
.heySomething .rolling .pagination {top:0; width:700px; margin-left:-350px;}
.heySomething .rolling .swiper-pagination-switch {width:150px; height:150px; margin:0 13px 0 12px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/70134/bg_ico.png);}
.heySomething .rolling .pagination span em {bottom:-765px; left:50%; margin-left:-490px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/70134/txt_story_desc.png); cursor:default;}
.heySomething .rolling .btn-nav {top:450px;}
.heySomething .swipemask {top:165px;}

/* comment */
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/70134/bg_ico_comment.png);}
.heySomething .commentlist table td {padding:0;}
.heySomething .commentlist table td strong {height:150px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/70134/bg_ico_comment.png);}
.heySomething .commentlist table td .ico1 {background-position:0 0;}
.heySomething .commentlist table td .ico2 {background-position:-150px 0;}
.heySomething .commentlist table td .ico3 {background-position:-300px 0;}
.heySomething .commentlist table td .ico4 {background-position:-450px 0;}
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
		<% If not( left(currenttime,10)>="2016-04-12" and left(currenttime,10)<"2016-04-20" ) Then %>
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
			<div class="bnr"><a href="/shopping/category_prd.asp?itemid=1467985&amp;pEtr=70134"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70134/img_item_represent.jpg" alt="MEANINGLESS X TENBYTEN" /></a></div>
		</div>

		<%' about %>
		<div class="about">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
			<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
		</div>

		<%' item %>
		<div class="item item01">
			<div class="inner">
				<h3>
					<span class="t01"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70134/tit_meaningless.png" alt="MEANINGLESS" /></span>
					<span class="t02"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70134/tit_10x10.png" alt="TENBYTEN " /></span>
				</h3>
				<%
				itemid = 1467985
				set oItem = new CatePrdCls
					oItem.GetItemData itemid
				%>
				<div class="desc">
					<div class="option">
						<em class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70134/txt_name_01.png" alt="STRIPE SLEEVELESS" /></em>
						<% if oItem.FResultCount > 0 then %>
							<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
							<div class="price">
								<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/txt_only_<%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>percent.png" alt="단, 일주일만 ONLY <%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%" /></strong>
								<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
								<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
							</div>
							<% Else %>
							<%' for dev msg : 종료 후 %>
							<div class="price priceEnd">
								<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
							</div>
							<% End If %>
						<% End If %>
						<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70134/txt_substance_01.png" alt="활동적인 아이들을 위한 스트라이프 슬리브" /></p>
						<div class="btnget">
							<a href="/shopping/category_prd.asp?itemid=1467985&amp;pEtr=70134"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러 가기" /></a>
						</div>
					</div>
					<div class="pic"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70134/img_style_01_v2.jpg" alt="" /></div>
				</div>
				<% set oItem=nothing %>
			</div>
		</div>
		<div class="item item02">
			<div class="inner">
				<%
				itemid = 1467692
				set oItem = new CatePrdCls
					oItem.GetItemData itemid
				%>
				<div class="desc">
					<div class="option">
						<em class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70134/txt_name_02.png" alt="STRIPE DAILY T" /></em>
						<% if oItem.FResultCount > 0 then %>
							<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
							<div class="price">
								<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/txt_only_<%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>percent.png" alt="단, 일주일만 ONLY <%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%" /></strong>
								<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
								<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
							</div>
							<% Else %>
							<%' for dev msg : 종료 후 %>
							<div class="price priceEnd">
								<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
							</div>
							<% End If %>
						<% End If %>
						<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70134/txt_substance_02.png" alt="평범한듯 트렌디한 하루 스트라이프 데일리 티셔츠" /></p>
						<div class="btnget">
							<a href="/shopping/category_prd.asp?itemid=1467692&amp;pEtr=70134"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러 가기" /></a>
						</div>
					</div>
					<div class="pic"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70134/img_style_02_v2.jpg" alt="" /></div>
				</div>
				<% set oItem=nothing %>
			</div>
		</div>
		<div class="item item03">
			<div class="inner">
				<%
				itemid = 1467690
				set oItem = new CatePrdCls
					oItem.GetItemData itemid
				%>
				<div class="desc">
					<div class="option">
						<em class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70134/txt_name_03.png" alt="CELIN SPAN T" /></em>
						<% if oItem.FResultCount > 0 then %>
							<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
							<div class="price">
								<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/txt_only_<%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>percent.png" alt="단, 일주일만 ONLY <%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%" /></strong>
								<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
								<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
							</div>
							<% Else %>
							<%' for dev msg : 종료 후 %>
							<div class="price priceEnd">
								<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
							</div>
							<% End If %>
						<% End If %>
						<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70134/txt_substance_03.png" alt="꽃놀이 갈 때 입고 싶은 옷 셀린스판 티셔츠" /></p>
						<div class="btnget">
							<a href="/shopping/category_prd.asp?itemid=1467690&amp;pEtr=70134"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러 가기" /></a>
						</div>
					</div>
					<div class="pic"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70134/img_style_03.jpg" alt="" /></div>
				</div>
				<% set oItem=nothing %>
			</div>
		</div>

		<%' wide slide %>
		<div id="slide01" class="slide">
			<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70134/img_wide_01.jpg" alt="" /></div>
			<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70134/img_wide_02.jpg" alt="" /></div>
			<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70134/img_wide_03.jpg" alt="" /></div>
			<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70134/img_wide_04.jpg" alt="" /></div>
			<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70134/img_wide_05.jpg" alt="" /></div>
		</div>

		<%' brand %>
		<div class="brand">
			<p class="info"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70134/txt_brand.jpg" alt="meaningless는 감성 패션 브랜드입니다. 강아지 체형에 맞게 활동성과 패션을 고려하여 합리적인 가격으로 제작되었습니다. 사람과 강아지 사이의 행복과 사랑은 얼마만큼의 깊이일까요? 우리에게 자신의 모든 시간을 내어주고 기다림을 아낌없이 반복하는 우리들의 강아지들에게 작은 선물을 해주세요. 강아지가 원하는 행복은 크고 거창한 것이 아니라 항상 옆에 끝까지 있어주는 한결같은 사랑입니다." /></p>
			<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="" /></div>
		</div>

		<%' story %>
		<div class="story">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70134/txt_story.png" alt="반려견과의 간단한 약속 몇 가지" /></h3>
			<div class="rollingwrap">
				<div class="rolling">
					<div class="swipemask mask-left"></div>
					<div class="swipemask mask-right"></div>
					<button type="button" class="btn-nav arrow-left">Previous</button>
					<button type="button" class="btn-nav arrow-right">Next</button>
					<div class="swiper">
						<div class="swiper-container swiper1">
							<div class="swiper-wrapper">
								<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70134/img_slide_01.jpg" alt="모든 반려견들은 산책을 좋아합니다. 특히 온종일 집안에서 주인을 기다리는 개들에게 산책만큼 훌륭한 선물은 없습니다." /></div>
								<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70134/img_slide_02.jpg" alt="집안에 물건들이 남아나질 않나요? 우리 강아지들이 관심을 보일만한 장난감을 선물하고 같이 놀아주세요." /></div>
								<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70134/img_slide_03.jpg" alt="하루종일 당신만 기다린 반려견을 꼬옥 안아주세요. 사랑받고 있다고 확신할 거예요." /></div>
								<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70134/img_slide_04.jpg" alt="칭찬 받을 일이 있다면 꼭 간식으로 보상해주세요. 착한 반려견이 되는 가장 좋은 방법입니다." /></div>
							</div>
						</div>
					</div>
					<div class="pagination"></div>
				</div>
			</div>
		</div>

		
		<%' comment %>
		<div class="commentevet">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70134/tit_comment.png" alt="Hey, something project 내가 놓치고 있었던 약속" /></h3>
			<p class="hidden">바쁘다던 핑계로 반려견에게 해주지 못했던 약속은 무엇인가요? 정성스러운 코멘트를 남겨주신 3분을 선정하여,미닝러스 티셔츠를 선물로 드립니다.(랜덤발송) 기간 : 2016.04.13 ~ 04.19 / 발표 : 04.20</p>
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
							<li class="ico1"><button type="button" value="1">GO OUT</button></li>
							<li class="ico2"><button type="button" value="2">PLAY</button></li>
							<li class="ico3"><button type="button" value="3">HUG</button></li>
							<li class="ico4"><button type="button" value="4">FEED</button></li>
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
												GO OUT
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="2" then %>
												PLAY
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="3" then %>
												HUG
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="4" then %>
												FEED
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
<script type="text/javascript">
$(function(){
	/* swipe */
	var swiper1 = new Swiper('.swiper1',{
		centeredSlides:true,
		slidesPerView:"auto",
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

	/* slide js */
	$("#slide01").slidesjs({
		width:"1920",
		height:"835",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:3200, effect:"fade", auto:true},
		effect:{fade: {speed:1500, crossfade:true}
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

	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 900 ) {
			nameAnimation()
		}
		if (scrollTop > 4400 ) {
			brandAnimation()
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

	/* brand animation */
	$(".heySomething .item h3 .t01").css({"margin-left":"35px", "opacity":"0"});
	$(".heySomething .item h3 .t02").css({"margin-left":"-35px", "opacity":"0"});
	function nameAnimation() {
		$(".heySomething .item h3 span").delay(500).animate({"margin-left":"0", "opacity":"1"},1300);
	}

	$(".heySomething .brand .info").css({"height":"150px", "opacity":"0"});
	$(".heySomething .brand .btnDown").css({"margin-top":"70px", "opacity":"0"});
	function brandAnimation() {
		$(".heySomething .brand .info").delay(500).animate({"height":"800px", "opacity":"1"},1800);
		$(".heySomething .brand .btnDown").delay(2200).animate({"margin-top":"62px", "opacity":"1"},800);
	}
	
});
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->