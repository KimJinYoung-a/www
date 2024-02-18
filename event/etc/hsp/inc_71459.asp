<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈 38
' History : 2016-06-28 김진영 생성
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
	eCode   =  66161
Else
	eCode   =  71459
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
.heySomething .topic {background-color:#f9f9f9;}
.heySomething .topic h2 {z-index:5;}
.heySomething .topic .figure a {display:block; position:relative; width:100%; height:780px;}
.heySomething .topic .figure img {position:absolute; top:0; left:50%; margin-left:-951px;}

/* item */
.heySomething .itemA .desc { min-height:370px; padding-top:0;}
.heySomething .itemA .desc .option {width:auto;}
.heySomething .itemA.glass .desc {margin-top:84px;}
.heySomething .itemA.glass .figure {left:713px; top:25px;}
.heySomething .itemA.glass .slide {width:240px; height:420px;}
.heySomething .itemA.coaster {margin-top:120px; padding-top:120px; border-top:1px solid #ddd;}
.heySomething .itemA.coaster .desc {width:505px; padding-left:635px;}
.heySomething .itemA.coaster .figure {left:0; top:70px;}
.heySomething .itemA .with {padding-top:65px;}
.heySomething .itemA .with ul {width:1180px; padding:70px 0 65px;}
.heySomething .itemA .with ul li {width:255px; padding:0 15px;}

/* visual */
.heySomething .doriGlass {position:relative; height:692px; margin-top:400px; background:#f6fbfb url(http://webimage.10x10.co.kr/eventIMG/2016/hey/71459/img_glass.jpg) 50% 0 no-repeat;}
.heySomething .doriGlass a {display:block; position:absolute; left:0; top:0; width:100%; height:692px; text-indent:-999em;}

/* brand */
.heySomething .brand {position:relative; height:auto; margin-top:318px;}
.heySomething .brand > div {position:relative; height:700px; margin-top:65px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/71459/bg_brand.png) 50% 0 no-repeat;}
.heySomething .brand p {position:absolute; left:50%; top:168px; margin-left:-122px;}
.heySomething .brand span {position:absolute; left:50%;}
.heySomething .brand span.fish01 {top:96px; margin-left:-218px; animation: move01 1.5s ease-in-out 0.1s 100 alternate;}
.heySomething .brand span.fish02 {top:200px; margin-left:164px; animation: move02 1s ease-in-out 0.1s 100 alternate;}
.heySomething .brand span.fish03 {top:400px; margin-left:-300px; animation: move03 2s ease-in-out 0.1s 100 alternate;}
.heySomething .brand .btnDown {position:absolute; left:50%; top:627px; margin:0 0 0 -25px;}
@keyframes move01 {from {transform:translate(-5px,-10px);} to {transform:translate(5px,5px);}}
@keyframes move02 {from {transform:translate(-5px,0);} to {transform:translate(-10px,5px);}}
@keyframes move03 {from {transform:translate(10px,0);} to {transform:translate(-10px,0);}}

/* story */
.heySomething .story {margin-top:450px; padding-bottom:0;}
.heySomething .story h3 {margin-bottom:0;}
.heySomething .rolling {margin-top:75px; padding-top:180px; padding-bottom:120px;}
.heySomething .rolling .pagination {top:0; width:900px; margin-left:-450px;}
.heySomething .rolling .pagination .swiper-pagination-switch {width:156px; height:156px; margin:0 12px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/71459/bg_ico_01.png) no-repeat 0 0;}
.heySomething .rolling .pagination span.swiper-active-switch {background-position:0 -156px;}
.heySomething .rolling .pagination span:first-child + span {background-position:-156px 0;}
.heySomething .rolling .pagination span:first-child + span.swiper-active-switch {background-position:-156px -156px;}
.heySomething .rolling .pagination span:first-child + span + span {background-position:-312px 0;}
.heySomething .rolling .pagination span:first-child + span + span.swiper-active-switch {background-position:-312px -156px;}
.heySomething .rolling .pagination span:first-child + span + span + span {background-position:-468px 0;}
.heySomething .rolling .pagination span:first-child + span + span + span.swiper-active-switch {background-position:-468px -156px;}
.heySomething .rolling .pagination span:first-child + span + span + span + span {background-position:100% 0;}
.heySomething .rolling .pagination span:first-child + span + span + span + span.swiper-active-switch {background-position:100% -156px;}
.heySomething .rolling .pagination span em {bottom:-774px; left:50%;height:120px; width:980px; margin-left:-490px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/71459/txt_story_desc.png); cursor:default;}
.heySomething .swipemask {top:180px;}

/* finish */
.heySomething .finish {background-color:#8bcadd; height:712px; margin-top:445px;}
.heySomething .finish .figure {position:absolute; top:0; left:50%; margin-left:-951px;}
.heySomething .finish p {top:152px; width:234px; height:157px;; margin-left:-388px;}

/* comment */
.heySomething .commentevet .form {margin-top:40px;}
.heySomething .commentevet .form .choice li {margin-right:25px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/71459/bg_ico_02.png);}
.heySomething .commentevet textarea {margin-top:50px;}
.heySomething .commentlist table td {padding:20px 0;}
.heySomething .commentlist table td strong {height:90px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/71459/bg_ico_03.png);}
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
		<% If not( left(currenttime,10)>="2016-06-28" and left(currenttime,10)<"2016-07-06" ) Then %>
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
				<a href="/shopping/category_prd.asp?itemid=1516362&amp;pEtr=71459"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71459/img_item_represent.jpg" alt="Finding Dory" /></a>
			</div>
		</div>
		<%' about %>
		<div class="about">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
			<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
		</div>
		<%' item %>
		<div class="item itemA glass">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71459/tit_10x10_disney.jpg" alt="DUCKOO" /></h3>
			<%
				IF application("Svr_Info") = "Dev" THEN
					itemid = 1239226
				Else
					itemid = 1516362
				End If
				set oItem = new CatePrdCls
					oItem.GetItemData itemid
			%>
			<div class="desc">
				<div class="option">
					<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71459/txt_name_cup.png" alt="[Disney]Finding Dory_Glass Cup" /></p>
			<%' for dev msg : 상품코드 1516362, 할인기간 6/29 ~ 7/5 할인기간이 지나면  <strong class="discount">...</strong> 숨겨주세요 %>
			<% If oItem.FResultCount > 0 Then %>
				<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
					<div class="price">
						<% If not( left(currenttime,10)>="2016-06-29" and left(currenttime,10)<="2016-07-05" ) Then %>
						<% Else %>
						<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/txt_only_10percent.png" alt="단, 일주일만 10%" /></strong>
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
					<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71459/txt_substance_01.png" alt="뜨거운 여름! 잃어버린 가족을 찾아 떠나는 도리와 함께다양하고 시원한 여름 음료를 즐겨보세요~" /></p>
					<div class="btnget"><a href="/shopping/category_prd.asp?itemid=1516362&amp;pEtr=71459"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러 가기" /></a></div>
				</div>
				<div class="figure">
					<div class="slide">
						<a href="/shopping/category_prd.asp?itemid=1516362&amp;pEtr=71459"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71459/img_slide_item_01.jpg" alt="" /></a>
						<a href="/shopping/category_prd.asp?itemid=1516362&amp;pEtr=71459"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71459/img_slide_item_02.jpg" alt="" /></a>
					</div>
				</div>
			</div>
		</div>
			<% set oItem=nothing %>
		<%
			IF application("Svr_Info") = "Dev" THEN
				itemid = 786868
			Else
				itemid = 1509356
			End If
			set oItem = new CatePrdCls
				oItem.GetItemData itemid
		%>
		<div class="item itemA coaster">
			<div class="desc">
				<div class="option">
					<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71459/txt_name_coaster.png" alt="[Disney]Finding Dory_Coaster" /></p>
			<%' for dev msg : 상품코드 1509356, 할인기간 6/29 ~ 7/5 할인기간이 지나면  <strong class="discount">...</strong> 숨겨주세요 %>
			<% If oItem.FResultCount > 0 Then %>
				<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
					<div class="price">
						<% If not( left(currenttime,10)>="2016-06-29" and left(currenttime,10)<="2016-07-05" ) Then %>
						<% Else %>
						<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/txt_only_10percent.png" alt="단, 일주일만 10%" /></strong>
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
			<% set oItem=nothing %>
					<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71459/txt_substance_02.png" alt="늘 밝고 긍정적인 기운을 주위에 전파하던 도리의 가족들을 찾기 위해 말린과 니모 부자를 시작으로 동료들이 재집결! 개성있는 새로운 캐릭터들을 코스터로 만나보세요!" /></p>
					<div class="btnget"><a href="/shopping/category_prd.asp?itemid=1509356&amp;pEtr=71459"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러 가기" /></a></div>
				</div>
				<div class="figure"><a href="/shopping/category_prd.asp?itemid=1509356&amp;pEtr=71459"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71459/img_coaster.jpg" alt="코스터" /></a></div>
			</div>
			<div class="with">
				<span><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/ico_plus.png" alt=""></span>
				<ul>
				<%
					IF application("Svr_Info") = "Dev" THEN
						itemid = 786868
					Else
						itemid = 1507612
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
				%>
					<li>
						<a href="/shopping/category_prd.asp?itemid=1507612&amp;pEtr=71459">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71459/img_with_item_01.jpg" alt="" />
							<span>Finding Dory_PLAYING CARDS</span>
					<% if oItem.FResultCount > 0 then %>
						<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
							<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
						<% Else %>
							<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
						<% End If %>
					<% End If %>
						</a>
					</li>
					<% set oItem=nothing %>
	
				<%
					IF application("Svr_Info") = "Dev" THEN
						itemid = 786868
					Else
						itemid = 1507611
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
				%>
					<li>
						<a href="/shopping/category_prd.asp?itemid=1507611&amp;pEtr=71459">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71459/img_with_item_02.jpg" alt="" />
							<span>Pattern Dory_iPhone6/6S Case</span>
					<% if oItem.FResultCount > 0 then %>
						<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
							<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
						<% Else %>
							<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
						<% End If %>
					<% End If %>
						</a>
					</li>
					<% set oItem=nothing %>
	
				<%
					IF application("Svr_Info") = "Dev" THEN
						itemid = 786868
					Else
						itemid = 1507610
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
				%>
					<li>
						<a href="/shopping/category_prd.asp?itemid=1507610&amp;pEtr=71459">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71459/img_with_item_03.jpg" alt="" />
							<span>Fantastic Dory_iPhone6/6S Case</span>
					<% if oItem.FResultCount > 0 then %>
						<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
							<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
						<% Else %>
							<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
						<% End If %>
					<% End If %>
						</a>
					</li>
					<% set oItem=nothing %>
	
				<%
					IF application("Svr_Info") = "Dev" THEN
						itemid = 786868
					Else
						itemid = 1507606
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
				%>
					<li>
						<a href="/shopping/category_prd.asp?itemid=1507606&amp;pEtr=71459">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71459/img_with_item_04.jpg" alt="" />
							<span>Stripe Dory_ iPhone6/6S Case</span>
					<% if oItem.FResultCount > 0 then %>
						<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
							<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
						<% Else %>
							<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
						<% End If %>
					<% End If %>
						</a>
					</li>
					<% set oItem=nothing %>
				</ul>
			</div>
		</div>
		<div class="doriGlass">
			<a href="/shopping/category_prd.asp?itemid=1516362&amp;pEtr=71459">[Disney]Finding Dory_Glass Cup 상품 보러가기</a>
		</div>
		<%' brand %>
		<div class="brand">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71459/tit_brand.png" alt="tit_brand" /></h3>
			<div>
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71459/txt_brand.png" alt="잃어버린 가족을 찾아 떠나는 모태 건망증 도리와 함께 올 여름, 우리를 시원하게 해줄  나라별 대표 아이스 음료를 찾아 떠나보아요! 시원함을 찾아서 GO! GO!" /></p>
				<span class="fish01"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71459/img_fish_01.png" alt="" /></span>
				<span class="fish02"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71459/img_fish_02.png" alt="" /></span>
				<span class="fish03"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71459/img_fish_03.png" alt="" /></span>
				<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="" /></div>
			</div>
		</div>
		<%' story %>
		<div class="story">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71459/txt_story.png" alt="시원함을 찾아서" /></h3>
			<div class="rollingwrap">
				<div class="rolling">
					<div class="swipemask mask-left"></div>
					<div class="swipemask mask-right"></div>
					<button type="button" class="btn-nav arrow-left">Previous</button>
					<button type="button" class="btn-nav arrow-right">Next</button>
					<div class="swiper">
						<div class="swiper-container swiper1">
							<div class="swiper-wrapper">
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1516362&amp;pEtr=71459"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71459/img_slide_story_01.jpg" alt="#Greece-지중해의 멋진 순백의 섬! 보기만 해도 시원해지는 블루 레몬에이드" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1516362&amp;pEtr=71459"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71459/img_slide_story_02.jpg" alt="#Italy-제대로 된 최상의 커피를 즐기고 싶다면! 커피 여행은 이탈리아로~" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1516362&amp;pEtr=71459"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71459/img_slide_story_03.jpg" alt="# Maldives-모히또 가서 몰디브 한 잔 어때요?" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1516362&amp;pEtr=71459"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71459/img_slide_story_04.jpg" alt="#California-태평양 근처의 눈부신 캘리포니아 해변에서의 오렌지 주스!" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1516362&amp;pEtr=71459"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71459/img_slide_story_05.jpg" alt="#U.S.A-뜨거운 여름! 시원한 청량감에 코가 절로 찡긋!" /></a>
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
			<a href="/shopping/category_prd.asp?itemid=1509356&amp;pEtr=71459">
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71459/txt_finish.png" alt="무더운 여름, 도리와 함께 시원함을 찾아서" /></p>
				<div class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71459/bg_finish.jpg" alt="" /></div>
			</a>
		</div>
		<%' comment %>
		<div class="commentevet">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71459/tit_comment.png" alt="Hey, something project 당신이 마시고 싶은 것" /></h3>
			<p class="hidden">도리와 니모 유리컵에 담아 마시고 싶은 음료는 무엇인가요? 정성껏 코멘트를 남겨주신 10분을 추첨하여 도리 코스터를 선물로 드립니다.</p>
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
					<legend>Finding Dori 코멘트 쓰기</legend>
						<ul class="choice">
							<li class="ico1"><button type="button" value="1">Greece</button></li>
							<li class="ico2"><button type="button" value="2">Italy</button></li>
							<li class="ico3"><button type="button" value="3">Maldives</button></li>
							<li class="ico4"><button type="button" value="4">California</button></li>
							<li class="ico5"><button type="button" value="5">USA</button></li>
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
					<caption>Finding Dori 코멘트 목록 - 코멘트 작성시 선택 항목, 내용, 작성일자, 아이디 정보를 제공하는 표</caption>
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
										Greece
									<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="2" Then %>
										Italy
									<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="3" Then %>
										Maldives
									<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="4" Then %>
										Taiwan
									<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="5" Then %>
										USA
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
	$(".slide").slidesjs({
		width:"240",
		height:"420",
		pagination:false,
		navigation:false,
		play:{interval:2500, effect:"fade", auto:true},
		effect:{fade: {speed:1200, crossfade:true}
		}
	});

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

	/* animation effect */
	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 6900 ) {
			finishAnimation();
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

	/* finish animation */
	$(".heySomething .finish p").css({"margin-left":"-368px", "opacity":"0"});
	function finishAnimation() {
		$(".heySomething .finish p").delay(100).animate({"margin-left":"-388px", "opacity":"1"},800);
	}
});
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->