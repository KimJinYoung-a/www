<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈 41
' History : 2016-07-26 김진영 생성
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
	eCode   =  66175
Else
	eCode   =  71999
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
.heySomething .topic {background-color:#f8f5f5;}
.heySomething .topic h2 {z-index:5;}
.heySomething .topic .figure a {display:block; position:relative; width:100%; height:780px;}
.heySomething .topic .figure img {position:absolute; top:0; left:50%; margin-left:-951px;}

/* item */
.heySomething .itemB {width:1140px; margin:0 auto; margin-top:376px; padding-bottom:86px; background:none; border-bottom:1px solid #ddd;}
.heySomething .item h3 {position:relative; height:102px;}
.heySomething .item h3 .imeangreen {position:absolute; top:0; left:372px; z-index:5;}
.heySomething .item h3 .tenten {position:absolute; top:32px; left:601px; z-index:5;}
.heySomething .item h3 .collabo {position:absolute; top:37px; left:556px;}
.heySomething .item h3 .horizontalLine1, .heySomething .item h3 .horizontalLine2 {position:absolute; top:50px; width:340px; height:1px; background-color:#d9d9d9;}
.heySomething .item h3 .horizontalLine1 {left:0;}
.heySomething .item h3 .horizontalLine2 {right:0;}
.heySomething .item .desc {min-height:486px;}
.heySomething .itemB .slidewrap .slide {position:relative; width:666px;}
.heySomething .itemB .slidewrap .slide .slidesjs-previous {left:0;}

/* intro */
.heySomething .intro {height:948px; margin-top:290px; text-align:center;}
.heySomething .intro .photo {overflow:hidden; width:935px; height:585px; margin:0 auto;}
.heySomething .intro h3 {margin-top:80px;}
.heySomething .intro ul {overflow:hidden; width:792px; margin:73px auto 0;}
.heySomething .intro ul li {float:left; margin:0 35px;}
@keyframes pulse {
	0% {transform:scale(1.2);}
	100% {transform:scale(1);}
}
.pulse {animation-name:pulse; animation-duration:1.5s; animation-iteration-count:1;}


/* brand */
.heySomething .brand {width:1140px; height:720px; margin:405px auto 0;}
.heySomething .brand h3 {position:relative; height:102px;}
.heySomething .brand h3 .imeangreen {position:absolute; top:0; left:372px; z-index:5;}
.heySomething .brand h3 .tenten {position:absolute; top:32px; left:601px; z-index:5;}
.heySomething .brand h3 .collabo {position:absolute; top:37px; left:556px;}
.heySomething .brand h3 .horizontalLine1, .heySomething .brand h3 .horizontalLine2 {position:absolute; top:50px; width:340px; height:1px; background-color:#d9d9d9;}
.heySomething .brand h3 .horizontalLine1 {left:0;}
.heySomething .brand h3 .horizontalLine2 {right:0;}

/* day */
.heySomething .day {margin:425px auto 0;}
.heySomething .day .figure {position:relative; height:811px;}
.heySomething .day .figure img {position:absolute; top:0; left:50%; margin-left:-951px;}
.heySomething .day .with {margin-top:75px; text-align:center;}
.heySomething .day .with ul {overflow:hidden; width:1140px; margin:77px auto 0;}
.heySomething .day .with ul li {float:left; width:172px; padding:0 9px;}
.heySomething .day .with ul li a {color:#777;}
.heySomething .day .with ul li span,
.heySomething .day .with ul li b {display:block; font-size:11px;}
.heySomething .day .with ul li span {margin-top:15px;}

/* video */
.video {width:1140px; margin:515px auto 0;}

/* story */
.heySomething .story {margin-top:420px; padding-bottom:120px;}
.heySomething .rolling {padding-top:165px;}
.heySomething .rolling .pagination {top:0; width:760px; margin-left:-380px;}
.heySomething .rolling .swiper-pagination-switch {width:144px; height:144px; margin:0 23px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/71999/btn_pagination.png);}
.heySomething .rolling .pagination span.swiper-active-switch {background-position:0 100%;}
.heySomething .rolling .pagination span:first-child + span {background-position:-191px 0;}
.heySomething .rolling .pagination span:first-child + span.swiper-active-switch {background-position:-191px 100%;}
.heySomething .rolling .pagination span:first-child + span + span {background-position:-383px 0;}
.heySomething .rolling .pagination span:first-child + span + span.swiper-active-switch {background-position:-383px 100%;}
.heySomething .rolling .pagination span:first-child + span + span + span {background-position:100% 0;}
.heySomething .rolling .pagination span:first-child + span + span + span.swiper-active-switch {background-position:100% 100%;}
.heySomething .rolling .pagination span em {bottom:-770px; left:50%;height:120px; width:980px; margin-left:-490px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/71999/txt_story_desc.png); cursor:default;}
.heySomething .rolling .pagination span .desc2 {background-position:0 -120px;}
.heySomething .rolling .pagination span .desc3 {background-position:0 -240px;}
.heySomething .rolling .pagination span .desc4 {background-position:0 -360px;}
.heySomething .rolling .pagination span .desc5 {background-position:0 100%;}
.heySomething .rolling .btn-nav {top:475px;}
.heySomething .swipemask {top:165px;}

/* comment */
.heySomething .commentevet {margin-top:315px;}
.heySomething .commentevet .form .choice li {width:118px; height:118px; margin-right:27px;}
.heySomething .commentevet .form .choice li.ico1 {margin-right:15px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/71999/img_ico.png); background-position:0 0;}
.heySomething .commentevet .form .choice li button.on {background-position:0 100%;}
.heySomething .commentevet .form .choice li.ico2 button {background-position:-145px 0;}
.heySomething .commentevet .form .choice li.ico2 button.on {background-position:-145px 100%;}
.heySomething .commentevet .form .choice li.ico3 button {background-position:-290px 0;}
.heySomething .commentevet .form .choice li.ico3 button.on {background-position:-290px 100%;}
.heySomething .commentevet .form .choice li.ico4 button {background-position:100% 0;}
.heySomething .commentevet .form .choice li.ico4 button.on {background-position:100% 100%;}

.heySomething .commentevet textarea {margin-top:30px;}

.heySomething .commentlist table td strong {width:118px; height:118px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/71999/img_ico.png); background-position:0 0;}
.heySomething .commentlist table td strong.ico2 {background-position:-145px 0;}
.heySomething .commentlist table td strong.ico3 {background-position:-290px 0;}
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
		<% If not( left(currenttime,10) >= "2016-07-26" and left(currenttime,10) <= "2016-08-02" ) Then %>
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
				<a href="/shopping/category_prd.asp?itemid=1534200&amp;pEtr=71999"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71999/img_item_represent.jpg" alt="바캉스 클렌즈" /></a>
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
			<%
				IF application("Svr_Info") = "Dev" THEN
					itemid = 1239226
				Else
					itemid = 1534200
				End If
				set oItem = new CatePrdCls
					oItem.GetItemData itemid
			%>
				<h3>
					<span class="imeangreen"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71999/img_logo_i_mean_green.png" alt="I mean green" /></span>
					<span class="collabo"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71999/txt_collabo.png" alt="" /></span>
					<span class="tenten"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71999/img_logo_tenbyten.png" alt="텐바이텐" /></span>
					<span class="horizontalLine1"></span>
					<span class="horizontalLine2"></span>
				</h3>
				<div class="desc">
					<a href="/shopping/category_prd.asp?itemid=1534200&amp;pEtr=71999">
						<div class="option">
							<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71999/txt_name.png" alt="바캉스 클렌즈는 텐바이텐 단독 상품으로 원재료는 과일, 채소며, 콜드프레스주스 6종으로 구성되어 있습니다." /></p>
					<%' for dev msg : 상품코드 1534200, 할인기간 7/27 ~ 8/2 할인기간이 지나면  <strong class="discount">...</strong> 숨겨주세요 %>
					<% If oItem.FResultCount > 0 Then %>
						<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
							<div class="price">
								<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/txt_only_tenten_14percent.png" alt="텐바이텐에서만 only 14%" /></strong>
								<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
								<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
							</div>
						<% Else %>
						<%' for dev msg : 할인 안할 경우 %>
							<div class="price priceEnd">
								<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
							</div>
						<% End If %>
					<% End If %>
							<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71999/txt_substance.png" alt="뜨거운 여름, 바캉스를 떠나시나요? 밖으로 안으로 인아웃 뷰티 프로젝트 클렌즈 프로그램을 당신에게 소개합니다 " /></p>
							<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="바캉스 클렌즈 구매하러 가기" /></div>
						</div>
			<% set oItem = nothing %>
						<div class="slidewrap">
							<div id="slide" class="slide">
								<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71999/img_slide_item_01.jpg" alt="트로피칼 샤워와 바디 앤드 케일" /></div>
								<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71999/img_slide_item_02.jpg" alt="마이 퍼니 캐롯과 핑크 원더랜드" /></div>
								<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71999/img_slide_item_03.jpg" alt="스트레이트 온 레드와 아이민 그린" /></div>
							</div>
						</div>
					</a>
				</div>
			</div>
		</div>
		<%' intro %>
		<div id="intro" class="intro">
			<div class="photo"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71999/img_vacance_cleanse.jpg" alt="" /></div>
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71999/tit_summer_season.png" alt="본격, 여름시즌!" /></h3>
			<ul>
				<li><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71999/txt_summer_season_01.png" alt="뺄건 빼고 더할건 더한 주스클렌즈" /></li>
				<li><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71999/txt_summer_season_02.png" alt="피부에 윤기는 더하고 라인은 슬림하게" /></li>
				<li><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71999/txt_summer_season_03.png" alt="가격도 맛도 부담없이 텐바이텐에서만 만나요" /></li>
			</ul>
		</div>
		<%' brand %>
		<div id="brand" class="brand">
			<h3>
				<span class="imeangreen"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71999/img_logo_i_mean_green.png" alt="I mean green" /></span>
				<span class="collabo"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71999/txt_collabo.png" alt="" /></span>
				<span class="tenten"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71999/img_logo_tenbyten.png" alt="텐바이텐" /></span>
				<span class="horizontalLine1"></span>
				<span class="horizontalLine2"></span>
			</h3>
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71999/txt_brand.jpg" alt="Good Culture from Good Food 모든 사람들이 건강한 라이프 스타일을 즐길 수 있도록 좋은 음식으로 좋은 문화를 만드는데 앞장서겠습니다. 출근하기 급급한 아침, 장보기 조차 버거운 퇴근길, 익숙해져만 가는 인스턴트 식사. 현대인들이 바빠도 잘 챙겨먹는 사회를 꿈꾸며 아이민그린이 시작되었습니다." /></p>
			<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="" /></div>
		</div>
		<%' day %>
		<div class="day">
			<p class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71999/txt_day.jpg" alt="바캉스클렌즈와 함께 하는 하루 클렌즈 경험이 많은 분들은 체질과 취향에 맞게 주스를 음용하셔도 큰 상관은 없지만 처음 클렌즈를 진행하시는 분들은 아래 순서를 지켜서 해보시는 것을 추천드립니다. 아침엔 활력을 불어넣는 뿌리채소 주소 스트레이트 온 레드와 마이 퍼니 캐롯, 오후엔 에너지와 비타민을 공급하는 과일 주스 트로피칼 샤워와 핑크 원더랜드, 저녁엔 하루의 독소를 없애주는 그린 주스 바디 앤드 케일과 아이민 그린" /></p>
			<div class="with">
				<span><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/ico_plus.png" alt="" /></span>
				<ul>
				<%
					IF application("Svr_Info") = "Dev" THEN
						itemid = 786868
					Else
						itemid = 1484540
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
				%>
					<li>
						<a href="/shopping/category_prd.asp?itemid=1484540&amp;pEtr=71999">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71999/img_with_item_01.jpg" alt="" />
							<span>우유치즈와 제철과일</span>
						<% if oItem.FResultCount > 0 then %>
							<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
								<b><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></b>
							<% Else %>
								<b><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></b>
							<% End If %>
						<% End If %>
						</a>
					</li>
					<% set oItem=nothing %>
				<%
					IF application("Svr_Info") = "Dev" THEN
						itemid = 786868
					Else
						itemid = 1484539
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
				%>
					<li>
						<a href="/shopping/category_prd.asp?itemid=1484539&amp;pEtr=71999">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71999/img_with_item_02.jpg" alt="" />
							<span>연어와 제철그린페스토</span>
						<% if oItem.FResultCount > 0 then %>
							<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
								<b><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></b>
							<% Else %>
								<b><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></b>
							<% End If %>
						<% End If %>
						</a>
					</li>
					<% set oItem=nothing %>
				<%
					IF application("Svr_Info") = "Dev" THEN
						itemid = 786868
					Else
						itemid = 1484538
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
				%>
					<li>
						<a href="/shopping/category_prd.asp?itemid=1484538&amp;pEtr=71999">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71999/img_with_item_03.jpg" alt="" />
							<span>아이민 콥</span>
						<% if oItem.FResultCount > 0 then %>
							<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
								<b><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></b>
							<% Else %>
								<b><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></b>
							<% End If %>
						<% End If %>
						</a>
					</li>
					<% set oItem=nothing %>
				<%
					IF application("Svr_Info") = "Dev" THEN
						itemid = 786868
					Else
						itemid = 1484536
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
				%>
					<li>
						<a href="/shopping/category_prd.asp?itemid=1484536&amp;pEtr=71999">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71999/img_with_item_04.jpg" alt="" />
							<span>버섯가지와 커리소스</span>
						<% if oItem.FResultCount > 0 then %>
							<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
								<b><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></b>
							<% Else %>
								<b><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></b>
							<% End If %>
						<% End If %>
						</a>
					</li>
					<% set oItem=nothing %>
				<%
					IF application("Svr_Info") = "Dev" THEN
						itemid = 786868
					Else
						itemid = 1484535
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
				%>
					<li>
						<a href="/shopping/category_prd.asp?itemid=1484535&amp;pEtr=71999">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71999/img_with_item_05.jpg" alt="" />
							<span>하베스트 크런치</span>
						<% if oItem.FResultCount > 0 then %>
							<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
								<b><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></b>
							<% Else %>
								<b><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></b>
							<% End If %>
						<% End If %>
						</a>
					</li>
					<% set oItem=nothing %>
				<%
					IF application("Svr_Info") = "Dev" THEN
						itemid = 786868
					Else
						itemid = 1484533
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
				%>
					<li>
						<a href="/shopping/category_prd.asp?itemid=1484533&amp;pEtr=71999">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71999/img_with_item_06.jpg" alt="" />
							<span>멕시칸 아보쉬림프</span>
						<% if oItem.FResultCount > 0 then %>
							<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
								<b><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></b>
							<% Else %>
								<b><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></b>
							<% End If %>
						<% End If %>
						</a>
					</li>
					<% set oItem=nothing %>
				</ul>
			</div>
		</div>
		<%' video %>
		<div class="video">
			<iframe src="//player.vimeo.com/video/175636589" width="1140" height="640" frameborder="0" title="바캉스 클렌즈" webkitallowfullscreen="" mozallowfullscreen="" allowfullscreen=""></iframe>
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
									<a href="/shopping/category_prd.asp?itemid=1534200&amp;pEtr=71999" title="마이 퍼니 캐롯 바캉스 클렌즈 보러가기"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71999/img_slide_story_01.jpg" alt="#피부미인 뜨거운 햇빛에도 반짝 반짝 빛나는 피부의 비결! 혈액순환과 비타민 공급으로 피부미인이 되어보세요" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1534200&amp;pEtr=71999" title="핑크 원더랜드, 아이민 그린 바캉스 클렌즈 보러가기"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71999/img_slide_story_02.jpg" alt="#속 편한 사람 상쾌한 아침, 속 편한 당신! 휴가철 과식으로 소화불량이 잦은 당신을 위해 위를 보호하는 성분이 풍부한 양배추로 속이 보호되고 편안하게 만들어줍니다." /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1534200&amp;pEtr=71999" title="스트레이트 온 레드 바캉스 클렌즈 보러가기"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71999/img_slide_story_03.jpg" alt="#에너자이저 휴가지에서도 생기 넘치는 에너자이저 당신! 당근,비트와 같은 뿌리채소로 당신이 경험하게 될 놀라운 에너지" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1534200&amp;pEtr=71999" title="트로피칼 샤워, 바디 앤드 케일 바캉스 클렌즈 보러가기"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71999/img_slide_story_04.jpg" alt="#핫바디 쿨한 여름 핫한 바디라인 자연이 선사하는 풍부한 비타민과 건강을 생각한 디톡스 몸에 좋은 슈퍼푸드 케일과 식욕을 억제하는 자몽으로 더 가벼운 여름이 될거에요" /></a>
								</div>
							</div>
						</div>
					</div>
					<div class="pagination"></div>
				</div>
			</div>
		</div>
		<%' comment %>
		<div class="commentevet">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71999/tit_comment.png" alt="Hey, something project 내가 되고 싶은 바캉스피플" /></h3>
			<p class="hidden">이번 바캉스에서 어떤 사람이 되고 싶나요? 정성껏 코멘트를 남겨주신 5분을 추첨하여, 아이민그린 쿨링백을 선물로 드립니다. 코멘트 작성기간은 2016년 7월 27일부터 8월 2일까지며, 발표는 8월 5일 입니다.</p>
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
					<legend>내가 되고 싶은 바캉스피플 선택하고 코멘트 쓰기</legend>
						<ul class="choice">
							<li class="ico1"><button type="button" value="1">피부미인</button></li>
							<li class="ico2"><button type="button" value="2">속 편한 사람</button></li>
							<li class="ico3"><button type="button" value="3">에너자이너</button></li>
							<li class="ico4"><button type="button" value="4">핫바디</button></li>
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
					<caption>내가 되고 싶은 바캉스피플 코멘트 목록 - 코멘트 작성시 선택 항목, 내용, 작성일자, 아이디 정보를 제공하는 표</caption>
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
										피부미인
									<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="2" Then %>
										속 편한 사람
									<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="3" Then %>
										에너자이너
									<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="4" Then %>
										핫바디
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
		width:"666",
		height:"485",
		pagination:false,
		navigation:{effect:"fade"},
		play:{interval:2000, effect:"fade", auto:true},
		effect:{fade: {speed:1000, crossfade:true}
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
		speed:1500,
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
		if (scrollTop > 800 ) {
			itemAnimation();
		}
		if (scrollTop > 1700 ) {
			$(".heySomething #intro .photo img").addClass("pulse");
		}
		if (scrollTop > 2400 ) {
			introAnimation();
		}
	});

	/* title animation */
	titleAnimation()
	$(".heySomething .topic h2 span").css({"width":"50px", "opacity":"0"});
	function titleAnimation() {
		$(".heySomething .topic h2 .letter1").delay(100).animate({"width":"125px", "opacity":"1"},1200);
		$(".heySomething .topic h2 .letter2").delay(300).animate({"width":"349px", "opacity":"1"},1200);
		$(".heySomething .topic h2 .letter3").delay(500).animate({"width":"206px", "opacity":"1"},1200);
	}

	/* item animation */
	$(".heySomething .item h3 .imeangreen").css({"left":"621px", "opacity":"0"});
	$(".heySomething .item h3 .tenten").css({"left":"393px","opacity":"0"});
	function itemAnimation() {
		$(".heySomething .item h3 .imeangreen").delay(200).animate({"left":"372px", "opacity":"1"},1000);
		$(".heySomething .item h3 .tenten").delay(200).animate({"left":"601px", "opacity":"1"},1000);
	}

	/* intro animation */
	$(".heySomething #intro ul li").css({"margin-top":"5px", "opacity":"0"});
	function introAnimation() {
		$(".heySomething #intro ul li:nth-child(1)").delay(100).animate({"margin-top":"0", "opacity":"1"},800);
		$(".heySomething #intro ul li:nth-child(2)").delay(400).animate({"margin-top":"0", "opacity":"1"},800);
		$(".heySomething #intro ul li:nth-child(3)").delay(800).animate({"margin-top":"0", "opacity":"1"},800);
	}
});
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->