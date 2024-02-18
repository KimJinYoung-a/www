<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈
' History : 2016-11-01 이종화 생성
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
	eCode   =  66225
Else
	eCode   =  73896
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
.heySomething .topic {background-color:#fbd1b9; z-index:1;}

/* item */
.heySomething .item h3 {margin-bottom:110px;}
.heySomething .item .slidewrap {position:absolute; right:72px; top:36px; width:480px; height:340px;}
.heySomething .item .option .substance {position:static; padding-top:30px;}
.heySomething .itemA .desc {min-height:485px; padding-top:0;}
.heySomething .itemA .desc > a {text-decoration:none;}
.heySomething .itemA .with {border-bottom:0;}
.heySomething .itemA .with ul {width:1140px; margin-top:72px; padding:0; /*background:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/73896/bg_item.png) 50% 0 no-repeat;*/}
.heySomething .itemA .with ul li {width:190px; padding:0; text-align:center;}
.heySomething .itemA .with ul li span {padding-bottom:3px; font-size:12px; line-height:16px;}
.heySomething .itemA .with ul li strong {font-size:12px;}

/* brand */
.heySomething .brand {position:relative; height:860px; margin-top:420px;}
.heySomething .brand .text {height:730px;}

/* story */
.heySomething .story {margin-top:300px; padding-bottom:120px;}
.heySomething .rolling {padding-top:227px;}
.heySomething .rolling .swiper-pagination-switch {width:160px; height:190px; margin:0 22px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/73896/bg_ico_01.png);}
.heySomething .rolling .pagination {top:0; padding-left:90px;}
.heySomething .rolling .pagination span em {bottom:-790px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/73896/txt_story_desc.png); cursor:default;}
.heySomething .rolling .pagination span:first-child {background-position:0 0;}
.heySomething .rolling .pagination span.swiper-active-switch {background-position:0 -190px;}
.heySomething .rolling .pagination span:first-child + span {background-position:-160px 0;}
.heySomething .rolling .pagination span:first-child + span.swiper-active-switch {background-position:-160px -190px;}
.heySomething .rolling .pagination span:first-child + span + span {background-position:-320px 0;}
.heySomething .rolling .pagination span:first-child + span + span.swiper-active-switch {background-position:-320px -190px;}
.heySomething .rolling .pagination span:first-child + span + span + span {background-position:-480px 0;}
.heySomething .rolling .pagination span:first-child + span + span + span.swiper-active-switch {background-position:-480px -190px;}
.heySomething .rolling .pagination span:first-child + span + span + span + span {background-position:-640px 0;}
.heySomething .rolling .pagination span:first-child + span + span + span + span.swiper-active-switch {background-position:-640px -190px;}
.heySomething .rolling .btn-nav {top:510px;}
.heySomething .swipemask {top:227px;}

/* finish */
.heySomething .finish {height:712px; margin-top:400px; background:#f7f7f7 url(http://webimage.10x10.co.kr/eventIMG/2016/hey/73896/bg_finish.jpg) 50% 0 no-repeat; text-indent:-999em;}
.heySomething .finish p {top:230px; margin-left:-486px; width:311px; height:73px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/73896/txt_finish.png) 0 0 no-repeat;}
.heySomething .finish a {display:block; position:absolute; left:0; top:0; width:100%; height:100%; text-indent:-999em;}

/* comment */
.heySomething .commentevet {margin-top:230px;}
.heySomething .commentevet textarea {margin-top:40px;}
.heySomething .commentevet .form {margin-top:45px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/73896/bg_ico_02.png);}
.heySomething .commentlist table td {padding:20px 0;}
.heySomething .commentlist table td strong {height:136px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/73896/bg_ico_02.png); background-position:0 0;}
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
		<% If not( left(currenttime,10)>="2016-11-02" and left(currenttime,10)<"2016-11-09" ) Then %>
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
			<div class="bnr"><a href="/street/street_brand_sub06.asp?makerid=simonschuster"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73896/img_item_represent.jpg" alt="스누피와 친구들 &amp; 가필드 2017 캘린더" /></a></div>
		</div>

		<%' about %>
		<div class="about">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
			<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
		</div>

		<%' item %>
		<div class="item itemA">
			<div class="inner">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73896/txt_peanuts.png" alt="PEANUTS" /></h3>
			<%' for dev msg : 상품코드 1544319, 할인기간 8/24 ~ 8/30 할인기간이 지나면  <strong class="discount">...</strong> 숨겨주세요 %>
			<%
				IF application("Svr_Info") = "Dev" THEN
					itemid = 1239226
				Else
					itemid = 1545423
				End If
				set oItem = new CatePrdCls
					oItem.GetItemData itemid
			%>
				<div class="desc">
					<a href="/shopping/category_prd.asp?itemid=1545423&amp;pEtr=73896">
						<div class="option">
							<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73896/txt_name.png" alt="PEANUTS DAY TO DAY 2017" /></p>
							<% If oItem.FResultCount > 0 Then %>
								<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
									<div class="price">
									<% If not( left(currenttime,10)>="2016-11-02" and left(currenttime,10)<="2016-11-08" ) Then %>
									<% Else %>
										<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/txt_only_10percent.png" alt="단, 일주일만 10%" /></strong>
										<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
									<% End If %>
										<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
									</div>
								<% Else %>
									<%' for dev msg : 종료 후 %>
									<div class="price priceEnd">
										<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
									</div>
								<% End If %>
							<% End If %>
							<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73896/txt_substance.png" alt="풍부한 상상력과 자신감으로 무장한 원조 비글미 스누피, 끝까지 포기하지 않는 우리의 사랑스러운 친구 찰리브라운, 그리고 엉뚱한 피너츠 친구들과 함께 일상을 유쾌하게 만들어요!" /></p>
							<div class="btnget"><a href="/shopping/category_prd.asp?itemid=1545423&amp;pEtr=73896"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="PEANUTS DAY TO DAY 2017 구매하러 가기" /></a></div>
						</div>

						<div class="slidewrap">
							<div id="slide" class="slide">
								<div><a href="/shopping/category_prd.asp?itemid=1545423&amp;pEtr=73896"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73896/img_item_01.jpg" alt="" /></a></div>
								<div><a href="/shopping/category_prd.asp?itemid=1545423&amp;pEtr=73896"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73896/img_item_02.jpg" alt="" /></a></div>
								<div><a href="/shopping/category_prd.asp?itemid=1545423&amp;pEtr=73896"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73896/img_item_03.jpg" alt="" /></a></div>
								<div><a href="/shopping/category_prd.asp?itemid=1545423&amp;pEtr=73896"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73896/img_item_04.jpg" alt="" /></a></div>
							</div>
						</div>
					</a>
				</div>
			<%	set oItem = nothing %>
				<div class="with">
					<span><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/ico_plus.png" alt=""></span>
					<ul>
					<%
						Dim itemarr
						IF application("Svr_Info") = "Dev" THEN
							itemarr = array(786868,786868,786868,786868,786868,786868)
						Else
							itemarr = array(1545424,1545425,1545422,1495674,1495626,1507390)
						End If

						Dim lp 
						For lp = 0 To 5 '6개

						set oItem = new CatePrdCls
							oItem.GetItemData itemarr(lp)
					%>
						<li>
							<a href="/shopping/category_prd.asp?itemid=<%=itemarr(lp)%>&amp;pEtr=73896">
								<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73896/img_with_item_0<%=lp+1%>.png" alt="" />
								<% If lp = 0 then %>
								<span>PEANUTS<br />WEEKLY PLANNER 2017</span>
								<% elseIf lp = 1 Then %>
								<span>PEANUTS MINI<br />DAY TO DAY 2017</span>
								<% elseIf lp = 2 Then %>
								<span>GAFIELD<br />DAY TO DAY 2017</span>
								<% elseIf lp = 3 Then %>
								<span>PEANUTS<br />WALL 2017 </span>
								<% elseIf lp = 4 Then %>
								<span>PEANUTS<br />MINI WALL 2017</span>
								<% elseIf lp = 5 Then %>
								<span>GAFIELD<br />WALL 2017</span>
								<% End If %>
						<% if oItem.FResultCount > 0 then %>
							<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
								<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> [<%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%]</strong>
							<% Else %>
								<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
							<% End If %>
						<% End If %>
							</a>
						</li>
					<% 
						set oItem=nothing

						Next 
					%>
					</ul>
				</div>
			</div>
		</div>

		<%' brand %>
		<div class="brand">
			<div class="text"><a href="/street/street_brand_sub06.asp?makerid=simonschuster"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73896/txt_brand.png" alt="‘피너츠’시리즈는 전 세계 21개 언어로 번역돼 60년이 넘는 시간 동안 세대와 국경을 초월, 약 3억 5천만 명의 독자들에게 사랑받았습니다. 사랑스럽고, 천진난만한 장난꾸러기들이 전하는 유쾌한 웃음과 따뜻한 격려는 많은 이들에게 행복을 전해주었습니다. 언제나 내 곁에 있어주는 ‘PEANUTS’ 주인공들과 친구가 될 준비가 되었나요?" /></a></div>
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
								<div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1545424&amp;pEtr=73896"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73896/img_slide_01.jpg" alt="Today is 무엇이든 꿈꾸는 스누피와 함께 즐거운 상상을 펼쳐보아요!" /></a></div>
								<div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1545425&amp;pEtr=73896"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73896/img_slide_02.jpg" alt="Today is 괴팍한 성격을 가지고 있지만, 마음 상담소 주인이기도 한 샐리와 함께 포토타임을 가져보아요!" /></a></div>
								<div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1545423&amp;pEtr=73896"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73896/img_slide_03.jpg" alt="Today is 불운의 아이콘이자 불굴의 아이콘! 절대 포기하지 않는 우리의 사랑스러운 친구 찰리 브라운! 마음이 울적할 때 함께 컬러링 하지 않을래?" /></a></div>
								<div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1545423&amp;pEtr=73896"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73896/img_slide_04.jpg" alt="Today is 찰리와 베스트 프렌드이자 어린이 철학가인 라이너스와 함께 즐거운 단어 게임 한 판 어때요" /></a></div>
							</div>
						</div>
					</div>
					<div class="pagination"></div>
				</div>
			</div>
		</div>

		<%' finish %>
		<div class="finish">
			<p>2017, 네가 있어 참 다행이야!</p>
			<a href="/street/street_brand_sub06.asp?makerid=simonschuster">사이먼 앤 슈스터 바로가기</a>
		</div>
		
		<%' comment %>
		<div class="commentevet">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73896/tit_comment.png" alt="Hey, something project 2016, 즐거웠던 나만의 한 컷!.." /></h3>
			<p class="hidden">올해 가장 즐거웠던 나만의 한 컷을 적어주세요! 정성껏 코멘트를 남겨주신 5분을 추천하여 2017년 PENUTS 위클리 플래너를 발송해드립니다.</p>
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
							<li class="ico1"><button type="button" value="1">#HOPEFUL</button></li>
							<li class="ico2"><button type="button" value="2">#CHEERFUL</button></li>
							<li class="ico3"><button type="button" value="3">#COLORFUL</button></li>
							<li class="ico4"><button type="button" value="4">#JOYFUL</button></li>
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
												#HOPEFUL
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="2" then %>
												#CHEERFUL
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="3" then %>
												#COLORFUL
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="4" then %>
												#JOYFUL
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
	$("#slide").slidesjs({
		width:"480",
		height:"340",
		pagination:false,
		navigation:false,
		play:{interval:2000, effect:"fade", auto:true},
		effect:{fade: {speed:800, crossfade:true}}
	});

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
		if (scrollTop > 5100 ) {
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

	/* finish animation */
	$(".heySomething .finish p").css({"width":"0","opacity":"0"});
	function finishAnimation() {
		$(".heySomething .finish p").delay(100).animate({"width":"311px","opacity":"1"},1400);
	}
});
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->