<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈 46
' History : 2016-08-30 김진영 생성
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
	eCode   =  66190
Else
	eCode   =  72728
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
.heySomething .topic {background-color:#acadb1; z-index:1;}
.heySomething .topic h2 span {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_hey_something_project_white.png);}

/* item */
.heySomething .itemWrap {text-align:center; width:1140px; margin:0 auto; margin-top:418px; border-bottom:1px solid #ddd;}
.heySomething .item {width:1140px;margin:0 auto; text-align:left;}
.heySomething .item .inner {position:relative; width:980px;  height:570px; padding-top:115px; margin:0 auto; background:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/69287/bg_dash.png) 50% 100% no-repeat;}
.heySomething .item .desc a {display:block;}
.heySomething .item .desc a:hover {text-decoration:none;}
.heySomething .item .option .substance {position:static; margin-top:65px;}
.heySomething .item .option .btnget {position:static; margin-top:35px;}
.heySomething .item .pic {position:absolute;}
.heySomething .item02 .inner {width:368px; padding-left:612px;}
.heySomething .item03 .inner {background:none;}
.heySomething .item01 .pic {right:28px; top:172px;}
.heySomething .item02 .pic {left:-28px; top:167px;}
.heySomething .item03 .pic {right:-10px; top:129px;}

/* brand */
.heySomething .healthyWater {position:relative; height:810px; margin-top:400px; background:#f6f6f8 url(http://webimage.10x10.co.kr/eventIMG/2016/hey/72728/bg_1day_pack.jpg) 50% 0 no-repeat;}
.heySomething .healthyWater p {position:absolute; left:50%; top:138px; margin-left:-223px;}
.heySomething .brand {position:relative; width:452px; height:82px; padding-top:668px; margin:488px auto 0;}
.heySomething .brand span {overflow:hidden; display:block; position:absolute; left:0; width:452px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/72728/txt_brand.png) 0 0 no-repeat; text-indent:-999em;}
.heySomething .brand .title .t01 {top:0; height:64px; background-position:0 0;}
.heySomething .brand .title .t02 {top:117px; height:31px; background-position:0 -117px;}
.heySomething .brand .title .t03 {top:197px; height:48px; background-position:0 -197px;}
.heySomething .brand .text .t04 {top:326px; height:262px; background-position:0 -326px;}

/* story */
.heySomething .waterPack {margin-top:395px;}
.heySomething .waterPack .rolling2 {padding-top:0; padding-bottom:0;}
.heySomething .waterPack .rolling2 .swiper {height:453px;}
.heySomething .waterPack .rolling2 .swiper .swiper-container {height:453px;}
.heySomething .waterPack .rolling2 .swiper .swiper-slide {width:402px; padding:0 90px;}
.heySomething .waterPack .rolling2 .pagination {overflow:hidden; top:527px; width:175px; height:7px; padding:0 11px; margin-left:-87px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/72728/bg_line.png) 0 0 repeat-x;}
.heySomething .waterPack .rolling2 .pagination em {display:inline-block; float:left; width:7px; height:7px; margin:0 11px;}
.heySomething .waterPack .rolling2 .pagination em.swiper-active-switch {background:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/72728/btn_pagination.png) 0 0 no-repeat;}
.heySomething .waterPack .rolling2 .btn-nav {display:block; position:absolute; top:515px; width:26px; height:30px; text-indent:0; background:#fff;}
.heySomething .waterPack .rolling2 .arrow-left {margin-left:-120px;}
.heySomething .waterPack .rolling2 .arrow-right {margin-left:120px;}

.heySomething .instagramEvent {text-align:center; margin-top:495px;}
.heySomething .story h3 {margin-bottom:25px;}
.heySomething .rolling1 .pagination {top:0; padding-left:200px; width:680px;}
.heySomething .rolling1 .swiper-pagination-switch {margin:0 15px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/72728/bg_ico_01.png);}
.heySomething .rolling1 .pagination span em {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/72728/txt_story_desc.png); cursor:default;}
.heySomething .rolling1 .btn-nav {top:450px;}

/* finish */
.heySomething .finish {height:auto; margin-top:350px; text-align:center; background-color:#95a896;}
.heySomething .finish .txt {position:absolute; left:50%; top:210px; margin-left:-533px;}

/* comment */
.heySomething .commentevet .form {margin-top:45px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/72728/bg_ico_02.png);}
.heySomething .commentlist table td {padding:0;}
.heySomething .commentlist table td strong {height:150px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/72728/bg_ico_02.png); background-position:0 0;}
.heySomething .commentlist table td .ico2 {background-position:-150px 0;}
.heySomething .commentlist table td .ico3 {background-position:-300px 0;}
.heySomething .commentlist table td .ico4 {background-position:-450px 0;}
</style>
<script type="text/javascript" src="/lib/js/jquery.flowslider.js"></script>
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
		<% If not( left(currenttime,10) >= "2016-08-30" and left(currenttime,10) <= "2016-09-06" ) Then %>
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
			<div class="bnr"><a href="/shopping/category_prd.asp?itemid=1553684&amp;pEtr=72728"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72728/img_item_represent.jpg" alt="Talk About Flower class" /></a></div>
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
				<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72536/img_item_represent.jpg" alt="NORITAKE" />
			</div>
		</div>
		<%' about %>
		<div class="about">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
			<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
		</div>

		<%' item(총3개) %>
		<div class="itemWrap">
			<h3 class="bPad15"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72728/tit_bantable_tenten.png" alt="BAN TABLE X ten by ten" /></h3>
			<div class="item item01">
				<div class="inner">
				<%
					IF application("Svr_Info") = "Dev" THEN
						itemid = 1239226
					Else
						itemid = 1553684
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
				%>
					<div class="desc">
						<a href="/shopping/category_prd.asp?itemid=1553684&amp;pEtr=72728">
							<div class="option">
								<em class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72728/txt_name_01.png" alt="과일 워터팩 7days" /></em>
						<%' for dev msg : 상품코드 1553684, 할인기간 8/31 ~ 9/6 할인기간이 지나면  <strong class="discount">...</strong> 숨겨주세요 %>
						<% If oItem.FResultCount > 0 Then %>
							<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
								<div class="price">
								<% If not( left(currenttime,10)>="2016-08-31" and left(currenttime,10)<="2016-09-06" ) Then %>
								<% Else %>
									<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/txt_only_10percent.png" alt="텐바이텐에서만 ONLY 10%" /></strong>
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
								<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72728/txt_substance_01.png" alt="건강하고 맛있게 마시는 물 색다른 맛과 향,색으로 이제까지 마셨던 물은 잊고 비타민 가득한 워터 디톡스를 경험해 보세요" /></p>
								<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러 가기" /></div>
							</div>
							<div class="pic"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72728/img_item_01.jpg" alt="" /></div>
						</a>
					</div>
				<% set oItem = nothing %>
				</div>
			</div>
			<div class="item item02">
				<div class="inner">
				<%
					IF application("Svr_Info") = "Dev" THEN
						itemid = 1239226
					Else
						itemid = 1553685
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
				%>
					<div class="desc">
						<a href="/shopping/category_prd.asp?itemid=1553685&amp;pEtr=72728">
							<div class="option">
								<em class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72728/txt_name_02.png" alt="과일 워터팩 15days" /></em>
						<%' for dev msg : 상품코드 1553685, 할인기간 8/31 ~ 9/6 할인기간이 지나면  <strong class="discount">...</strong> 숨겨주세요 %>
						<% If oItem.FResultCount > 0 Then %>
							<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
								<div class="price">
								<% If not( left(currenttime,10)>="2016-08-31" and left(currenttime,10)<="2016-09-06" ) Then %>
								<% Else %>
									<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/txt_only_10percent.png" alt="텐바이텐에서만 ONLY 10%" /></strong>
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
								<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72728/txt_substance_02.png" alt="2주간의 워터 디톡스 단지 물마시는 습관으로 예뻐질 수 있다는 것, 믿어지시나요?" /></p>
								<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러 가기" /></div>
							</div>
							<div class="pic"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72728/img_item_02.jpg" alt="" /></div>
						</a>
					</div>
				<% set oItem = nothing %>
				</div>
			</div>
			<div class="item item03">
				<div class="inner">
				<%
					IF application("Svr_Info") = "Dev" THEN
						itemid = 1239226
					Else
						itemid = 1553686
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
				%>
					<div class="desc">
						<a href="/shopping/category_prd.asp?itemid=1553686&amp;pEtr=72728">
							<div class="option">
								<em class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72728/txt_name_03.png" alt="과일 워터팩 30days" /></em>
						<%' for dev msg : 상품코드 1553686, 할인기간 8/31 ~ 9/6 할인기간이 지나면  <strong class="discount">...</strong> 숨겨주세요 %>
						<% If oItem.FResultCount > 0 Then %>
							<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
								<div class="price">
								<% If not( left(currenttime,10)>="2016-08-31" and left(currenttime,10)<="2016-09-06" ) Then %>
								<% Else %>
									<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/txt_only_10percent.png" alt="텐바이텐에서만 ONLY 10%" /></strong>
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
								<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72728/txt_substance_03.png" alt="한 달의 기적 이번 달은 커피대신 비타민워터로 보내 보세요.산뜻하고 가벼워진 몸을 느끼실 수 있을거에요" /></p>
								<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러 가기" /></div>
							</div>
							<div class="pic"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72728/img_item_03.jpg" alt="" /></div>
						</a>
					</div>
				<% set oItem = nothing %>	
				</div>
			</div>
		</div>
		<%' brand %>
		<div class="healthyWater">
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72728/txt_healthy_water.png" alt="하루 2L 물로 몸도 기분도 산뜻하게 - 컨디션과 기분에 따라 원하는 워터팩으로 하루를 건강하고 편안하게 보내보세요." /></p>
		</div>
		<div class="brand">
			<p class="title">
				<span class="t01">BAN TABLE</span>
				<span class="t02">그리고</span>
				<span class="t03">( )보다 프로젝트</span>
			</p>
			<p class="text"><span class="t04">반테이블은 음식을 선물화하여 판매하는 먹거리 선물가게 입니다. ‘(   ) 보다 프로젝트’ 는 우리 주변의 소외된 곳을 둘러보고 식탁의 가치를 사람들과 함께 나누는 활동을 하고 싶어 진행하게된 프로젝트입니다. 시각 중심 사고인 보는 것에 의미를 가둬두지 않고, 경험의 의미를 담아 ‘~해보다’라는 뜻입니다. 또한 시각 장애인의 활동 확장성을 높이고, 일반인의 참여로 시각 장애에 대한 인식 개선을 꾀하고자 하는 프로젝트입니다.</span></p>
			<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="" /></div>
		</div>
		<%' water pack rolling %>
		<div class="waterPack">
			<div class="rolling rolling2">
				<div class="swiper">
					<div class="swiper-container swiper2">
						<div class="swiper-wrapper" style="height:453px;">
							<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72728/img_pack_01.jpg" alt="" /></div>
							<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72728/img_pack_02.jpg" alt="" /></div>
							<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72728/img_pack_03.jpg" alt="" /></div>
							<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72728/img_pack_04.jpg" alt="" /></div>
							<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72728/img_pack_05.jpg" alt="" /></div>
							<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72728/img_pack_06.jpg" alt="" /></div>
						</div>
					</div>
				</div>
				<div class="pagination"></div>
				<button type="button" class="btn-nav arrow-left"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72728/btn_prev.png" alt="" /></button>
				<button type="button" class="btn-nav arrow-right"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72728/btn_next.png" alt="" /></button>
			</div>
		</div>
		<%' story %>
		<div class="instagramEvent"><a href="https://www.instagram.com/your10x10/" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72728/txt_instagram.png" alt="" /></a></div>
		<div class="story">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72728/tit_story.png" alt="함께 하고 싶은 나만의 ( )보다" /></h3>
			<div class="rollingwrap">
				<div class="rolling rolling1">
					<div class="swipemask mask-left"></div>
					<div class="swipemask mask-right"></div>
					<button type="button" class="btn-nav arrow-left">Previous</button>
					<button type="button" class="btn-nav arrow-right">Next</button>
					<div class="swiper">
						<div class="swiper-container swiper1">
							<div class="swiper-wrapper">
								<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72728/img_slide_01.jpg" alt="#마셔보다 - 다가오는 가을, 향긋하고 산뜻한 워터팩으로 촉촉한 하루로 관리해 보세요." /></div>
								<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72728/img_slide_02.jpg" alt="#선물해보다 - No 색소, No 카페인으로 남녀노소 누구나 편안하게 즐길 수 있는 워터팩을 선물해보세요." /></div>
								<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72728/img_slide_03.jpg" alt="#만들어보다 - 최상의 블랜딩 조합으로 맛과 향이 좋은 당신만의 워터팩을 만들어 보세요." /></div>
								<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72728/img_slide_04.jpg" alt="#나눠보다 - 점자도 하나의 언어로 생각하도록 하는 보다프로젝트데 동참해주세요." /></div>
							</div>
						</div>
					</div>
					<div class="pagination"></div>
				</div>
			</div>
		</div>
		<%' finish %>
		<div class="finish">
			<p class="txt"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72728/txt_finish.png" alt="새로운 워터팩은 ‘( ) 보다 프로젝트’ 와 함께합니다. 반테이블 워터팩의 수익금 중 일부는 시각장애인을 위한 도서제작에 활용됩니다.볼 수 있다는 것에 감사하며, 시각장애인들이 더 밝게 웃을 수 있는 세상을 함께 만들어주세요" /></p>
			<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72728/bg_finish.jpg" alt="" />
		</div>

		<%' comment %>
		<div class="commentevet">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/72728/tit_comment.png" alt="Hey, something project 함께 하고 싶은 나만의 [   ]보다" /></h3>
			<p class="hidden">올해 여러분들의 하반기 다짐을 적어주세요. 정성껏 코멘트를 남겨주신 5분을 추첨하여 Rifle Paper의 17-Month planner를 증정합니다.</p>
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
							<li class="ico1"><button type="button" value="1">#마셔보다</button></li>
							<li class="ico2"><button type="button" value="2">#선물해보다</button></li>
							<li class="ico3"><button type="button" value="3">#만들어보다</button></li>
							<li class="ico4"><button type="button" value="4">#나눠보다</button></li>
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
								<strong class="ico<%= split(arrCList(1,intCLoop),"!@#")(0) %>">
									<% If split(arrCList(1,intCLoop),"!@#")(0)="1" Then %>
										#마셔보다
									<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="2" Then %>
										#선물해보다
									<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="3" Then %>
										#만들어보다
									<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="4" Then %>
										#나눠보다
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

	var swiper2 = new Swiper('.swiper2',{
		centeredSlides:true,
		slidesPerView:"auto",
		loop: true,
		speed:800,
		autoplay:2800,
		simulateTouch:false,
		pagination: '.rolling2 .pagination',
		paginationElement: 'em',
		paginationClickable: true
	});

	$('.rolling2 .arrow-left').on('click', function(e){
		e.preventDefault()
		swiper2.swipePrev()
	});
	$('.rolling2 .arrow-right').on('click', function(e){
		e.preventDefault()
		swiper2.swipeNext()
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
		if (scrollTop > 4700 ) {
			brandAnimation()
		}
		if (scrollTop > 9400 ) {
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

	/* brand animation */
	$(".heySomething .brand .title .t01").css({"margin-top":"10px", "opacity":"0"});
	$(".heySomething .brand .title .t02").css({"margin-left":"-10px", "opacity":"0"});
	$(".heySomething .brand .title .t03").css({"margin-top":"10px", "opacity":"0"});
	$(".heySomething .brand .text span").css({"margin-top":"10px", "opacity":"0"});
	$(".heySomething .brand .btnDown").css({"opacity":"0"});
	function brandAnimation() {
		$(".heySomething .brand .title .t01").delay(100).animate({"margin-top":"0", "opacity":"1"},600);
		$(".heySomething .brand .title .t02").delay(600).animate({"margin-left":"0", "opacity":"1"},900);
		$(".heySomething .brand .title .t03").delay(1000).animate({"margin-top":"0", "opacity":"1"},600);
		$(".heySomething .brand .text span").delay(1400).animate({"margin-top":"0", "opacity":"1"},600);
		$(".heySomething .brand .btnDown").delay(2000).animate({"opacity":"1"},800);
	}

	/* finish animation */
	$(".heySomething .finish .txt").css({"left":"49%","opacity":"0"});
	function finishAnimation() {
		$(".heySomething .finish .txt").delay(100).animate({"opacity":"1","left":"50%"},1200);
	}
});
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->