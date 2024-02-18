<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈
' History : 2017-06-27 원승현 생성
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
'	currenttime = #05/20/2017 09:00:00#

dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  66379
Else
	eCode   =  78959
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
.heySomething .topic {text-align:center; background-color:#8de1fe; z-index:1;}

/* about */
.about {margin-bottom:335px;}

/* item */
.heySomething .item h3 {text-align:center;}
.heySomething .item a {text-decoration:none;}
.heySomething .item {width:100%; margin-top:0;}
.heySomething .item .desc {position:relative; min-height:500px; margin:0 auto; margin-top:30px; padding:110px 85px 0; border-bottom:1px solid #cccccc;}
.heySomething .item4 .desc {border:none;}
.heySomething .item2 .desc,
.heySomething .item3 .desc
{min-height:405px; padding-top:80px;}
.heySomething .item1 .desc .option {width:476px; height:363px; margin-left:60px;}
.heySomething .item2 .desc .option{height:285px; margin-left:670px;}
.heySomething .item3 .desc .option {height:285px;}
.heySomething .item .desc .option .price {margin-top:30px;}
.heySomething .item2 .desc .option .price,
.heySomething .item3 .desc .option .price
{margin-top:50px;}
.heySomething .item .desc .option .substance {bottom:70px;}
.heySomething .item2 .desc .option .substance,
.heySomething .item3 .desc .option .substance
{bottom:65px;}
.heySomething .item .desc .thumbnail {position:absolute; width:316px; height:475px; top:30px;}
.heySomething .item1 .desc .thumbnail {right:175px;}
.heySomething .item2 .desc .thumbnail {width:350px; height:250px; top:105px; left:145px;}
.heySomething .item3 .desc .thumbnail {top:105px; right:190px;}
.heySomething .item .desc .thumbnail .slidesjs-navigation {display:none;}

.heySomething .itemA .with {border:none; text-align:center; }
.heySomething .itemA .with ul {width:1080px; margin:0 auto; padding:45px 0 5px;}
.heySomething .itemA .with ul li {float:left; width:300px; padding:0; margin:0 30px; text-align:center; font-size:11px; line-height:11px;}
.heySomething .itemA .with ul li .itemImg {display:block; height:210px; margin-top:0; z-index:10;}
.heySomething .itemA .with ul li .itemName {display:inline-block; margin-top:15px; color:#777777;}
.heySomething .itemA .with ul li span.salePrice {margin-top:10px;}
.heySomething .itemA .with ul li span.salePrice strong {display:inline-block; color:#777777;}
.heySomething .itemA .with ul li span.price {margin-top:10px; font-weight:bold;}

/* visual */
.heySomething .visual{margin-bottom:40px; margin-top:430px; text-align:center;}
.heySomething .visual .txt {position:relative; width:100%; height:608px; margin-top:45px; background:#37b6c8 url(http://webimage.10x10.co.kr/eventIMG/2017/hey/78959/bg_visual.jpg) no-repeat 50% 100%; }
.heySomething .visual .txt p {padding-top:206px;}
.heySomething .visual .deco span {position:absolute; top:105px; left:50%; margin-left:-423px; opacity:0;}
.heySomething .visual .deco span.deco2 {top:55px; margin-left:50px; opacity:0;}
.heySomething .visual .deco span.deco3 {top:305px; margin-left:180px;}
.heySomething .visual .deco span.deco4 {top:438px; margin-left:-215px;}
.btnDown {text-align:center;}
.move{animation:move 1.2s 20;} 
@keyframes move { from to {transform:translateY(0); animation-timing-function:ease-out;} 50% {transform:translateY(-5px); animation-timing-function:ease-in;} }

/* gallery */
.gallery {margin-top:320px;}
.gallery ul{overflow:hidden; width:1013px; margin:0 auto;}
.gallery ul li{float:left; overflow:hidden;}
.gallery ul li:first-child {margin:0 8px 8px 0;}
.gallery ul li:first-child + li {margin-bottom:8px;}
.gallery ul li:first-child + li + li{margin-right:8px;}
.gallery ul li img {opacity:0;}
.scale {animation: scale 1.2s ease-in-out 1;}
@keyframes scale{
0% {transform: scale(1.2); -webkit-transform:scale(1.2);}
100% {transform: scale(1.0); -webkit-transform:scale(1.0);}
}

/* collectionImg */
.collectionImg {margin-top:345px; text-align:center;}

/* story */
.heySomething .story {margin-top:345px; padding-bottom:120px;}
.heySomething .rollingwrap {margin:0;}
.heySomething .rolling {padding-top:235px;}
.heySomething .rolling .pagination {padding-left:128px;}
.heySomething .rolling .swiper-pagination-switch {height:168px;  margin:0 35px;}
.heySomething .rolling .swiper-pagination-switch {width:160px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/78959/bg_ico_1_v2.jpg);}
.heySomething .rolling .pagination span.swiper-active-switch {background-position:0 100%;}
.heySomething .rolling .pagination span:first-child + span {background-position:-237px 0;}
.heySomething .rolling .pagination span:first-child + span.swiper-active-switch {background-position:-237px 100%;}
.heySomething .rolling .pagination span:first-child + span + span {background-position:100% 0;}
.heySomething .rolling .pagination span:first-child + span + span.swiper-active-switch {background-position:100%  100%;}
.heySomething .rolling .pagination span em {height:120px; bottom:-818px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/78959/txt_desc.png); cursor:default;}
.heySomething .rolling .btn-nav {top:486px;}
.heySomething .swipemask {top:235px; background-color:#000;}

/* finish */
.heySomething .finish {position:relative; height:644px; margin-top:480px; background:#ade6fe url(http://webimage.10x10.co.kr/eventIMG/2017/hey/78959/collectionImg.jpg) 50% 0 no-repeat;}
.heySomething .finish p {opacity:0;}
.heySomething .finish .t1 {top:252px; margin-left:-254px;}
.heySomething .finish .t2 {top:365px; margin-left:-163px;}

/* comment */
.heySomething .commentevet {margin-top:470px; padding-top:50px;}
.heySomething .commentevet textarea {margin-top:25px;}
.heySomething .commentevet .form {margin-top:30px;}
.heySomething .commentevet .form .choice li {width:122px; height:141px; margin-right:20px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/78959/bg_ico_2_v3.jpg);}
.heySomething .commentevet .form .choice li.ico1 button {background-position:1px 0;}
.heySomething .commentevet .form .choice li.ico1 button.on {background-position:0 -141px;}
.heySomething .commentevet .form .choice li.ico2 button {background-position:-157px 0;}
.heySomething .commentevet .form .choice li.ico2 button.on {background-position:-158px -141px;}
.heySomething .commentevet .form .choice li.ico3 button {background-position:-315px 0;}
.heySomething .commentevet .form .choice li.ico3 button.on {background-position:-316px -141px;}

.heySomething .commentlist table td {padding:20px 0;}
.heySomething .commentlist table td strong {width:122px; height:128px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/78959/bg_ico_2_v3.jpg); background-position:0 -13px;}
.heySomething .commentlist table td .ico2 {background-position:-158px -13px;}
.heySomething .commentlist table td .ico3 {background-position:-316px -13px;}
</style>
<script type="text/javascript">

$(function(){
	/* slide js */
	$("#slide01").slidesjs({
		width:"316",
		height:"475",
		pagination:false,
		navigation:{effect:"fade"},
		play:{interval:1800, effect:"fade", auto:true},
		effect:{fade: {speed:800, crossfade:true}}
	});
});

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
		<% If not( left(currenttime,10)>="2017-07-04" and left(currenttime,10)<"2017-07-12" ) Then %>
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
			<div class="bnr"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78959/img_item_represent.gif" alt="Hey, something project" /></div>
		</div>

		<!-- about -->
		<div class="about">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
			<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
		</div>

		<!-- item -->
		<%
			IF application("Svr_Info") = "Dev" THEN
				itemid = 1239226
			Else
				itemid = 1712139
			End If
			set oItem = new CatePrdCls
				oItem.GetItemData itemid
		%>
		<div class="item itemA item1">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78959/tit_under_the_sea.png" alt="Disney와 텐바이텐의 콜라보" /></h3>
			<div class="desc">
				<a href="/shopping/category_prd.asp?itemid=1712139&amp;pEtr=78959">
					<div class="option">
						<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78959/txt_name_1.png" alt="[Disney] Ariel 유리글라스 " /></p>
						<% If oItem.FResultCount > 0 Then %>
							<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
								<div class="price">
									<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> <span>(<%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%)</span></strong>
								</div>
							<% Else %>
								<%' for dev msg :종료후 %>
								<div class="price priceEnd">
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								</div>
							<% End If %>
						<% End If %>

						<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78959/txt_substance_1.png" alt="에리얼 (Ariel) 추억의 에리얼과 신비로운 보라와 베이비블루 컬러의 조개들의 조화가 아름다운 유리컵 언더더씨 (Under the sea) 세바스챤과 플라운더의 패턴이 돋보이는 시원함이 느껴지는 유니크 유리컵" /></p>
						<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러가기" /></div>
					</div>
				</a>
				<div class="thumbnail">
					<div class="slidewrap">
						<div id="slide01" class="slide">
							<div><a href="/shopping/category_prd.asp?itemid=1712139&pEtr=78959"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78959/img_slide_prd_1_1.jpg" alt="[Disney] Ariel 유리글라스" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1712139&pEtr=78959"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78959/img_slide_prd_1_2.jpg" alt="[Disney] Ariel 유리글라스" /></a></div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<%	set oItem = nothing %>

		<%
			IF application("Svr_Info") = "Dev" THEN
				itemid = 1239226
			Else
				itemid = 1736459
			End If
			set oItem = new CatePrdCls
				oItem.GetItemData itemid
		%>
		<div class="item itemA item2">
			<div class="desc">
				<a href="/shopping/category_prd.asp?itemid=1736459&amp;pEtr=78959">
					<div class="option">
						<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78959/txt_name_2_1.png" alt="[Disney] Ariel 뱃지" /></p>
						<% If oItem.FResultCount > 0 Then %>
							<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
								<div class="price">
									<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> <span>(<%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%)</span></strong>
								</div>
							<% Else %>
								<%' for dev msg :종료후 %>
								<div class="price priceEnd">
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								</div>
							<% End If %>
						<% End If %>
						<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78959/txt_substance_2.png" alt="고퀄리티를 자랑하는 인어공주 뱃지 시리즈 에리얼과 세바스찬, 플라운더까지 3가지 종류를 만나보실 수 있어요!" /></p>
						<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러가기" /></div>
					</div>
					<div class="thumbnail"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78959/img_slide_prd_2_1.jpg" alt="[Disney] Ariel 뱃지" /></div>
				</a>
			</div>
		</div>
		<%	set oItem = nothing %>

		<%
			IF application("Svr_Info") = "Dev" THEN
				itemid = 1239226
			Else
				itemid = 1736460
			End If
			set oItem = new CatePrdCls
				oItem.GetItemData itemid
		%>
		<div class="item itemA item1 item3">
			<div class="desc">
				<a href="/shopping/category_prd.asp?itemid=1736460&amp;pEtr=78959">
					<div class="option">
						<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78959/txt_name_2_2.png" alt="[Disney] Ariel 뱃지" /></p>
						<% If oItem.FResultCount > 0 Then %>
							<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
								<div class="price">
									<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> <span>(<%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%)</span></strong>
								</div>
							<% Else %>
								<%' for dev msg :종료후 %>
								<div class="price priceEnd">
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								</div>
							<% End If %>
						<% End If %>
						<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78959/txt_substance_2.png" alt="고퀄리티를 자랑하는 인어공주 뱃지 시리즈 에리얼과 세바스찬, 플라운더까지 3가지 종류를 만나보실 수 있어요!" /></p>
						<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러가기" /></div>
					</div>
					<div class="thumbnail"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78959/img_slide_prd_2_2.jpg" alt="[Disney] Ariel 뱃지" /></div>
				</a>
			</div>
		</div>
		<%	set oItem = nothing %>

		<%
			IF application("Svr_Info") = "Dev" THEN
				itemid = 1239226
			Else
				itemid = 1736461
			End If
			set oItem = new CatePrdCls
				oItem.GetItemData itemid
		%>
		<div class="item itemA item2 item4">
			<div class="desc">
				<a href="/shopping/category_prd.asp?itemid=1736461&amp;pEtr=78959">
					<div class="option">
						<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78959/txt_name_2_3.png" alt="[Disney] Ariel 뱃지" /></p>
						<% If oItem.FResultCount > 0 Then %>
							<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
								<div class="price">
									<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> <span>(<%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%)</span></strong>
								</div>
							<% Else %>
								<%' for dev msg :종료후 %>
								<div class="price priceEnd">
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								</div>
							<% End If %>
						<% End If %>
						<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78959/txt_substance_2.png" alt="고퀄리티를 자랑하는 인어공주 뱃지 시리즈 에리얼과 세바스찬, 플라운더까지 3가지 종류를 만나보실 수 있어요!" /></p>
						<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러가기" /></div>
					</div>
					<div class="thumbnail"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78959/img_slide_prd_2_3.jpg" alt="[Disney] Ariel 뱃지" /></div>
				</a>
			</div>
		<%	set oItem = nothing %>

			<div class="with">
				<span><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/ico_plus.png" alt=""></span>
				<ul>
					<%
						IF application("Svr_Info") = "Dev" THEN
							itemid = 1239226
						Else
							itemid = 1714017
						End If
						set oItem = new CatePrdCls
							oItem.GetItemData itemid
					%>
					<li>
						<a href="/shopping/category_prd.asp?itemid=1714017&pEtr=78959">
							<span class="itemImg"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78959/img_with_item_1_v2.jpg" alt="[Disney] Ariel 비치타올 (E)" /></span>
							<span class="itemName">[Disney] Ariel 비치타올</span>
							<% If oItem.FResultCount > 0 Then %>
								<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
									<span class="salePrice"><s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s> <strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> <em style="color:red">[<%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%]</em></strong> </span>
								<% Else %>
									<%' for dev msg :종료후 %>
									<span class="price"><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></span>
								<% End If %>
							<% End If %>							
						</a>
					</li>
					<%	set oItem = nothing %>

					<%
						IF application("Svr_Info") = "Dev" THEN
							itemid = 1239226
						Else
							itemid = 1683251
						End If
						set oItem = new CatePrdCls
							oItem.GetItemData itemid
					%>
					<li>
						<a href="/shopping/category_prd.asp?itemid=1683251&pEtr=78959">
							<span class="itemImg"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78959/img_with_item_2_v2.jpg" alt="[Disney] Princess_Memo Pad (E)" /></span>
							<span class="itemName">[Disney] Princess_Memo Pad</span>
							<% If oItem.FResultCount > 0 Then %>
								<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
									<span class="salePrice"><s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s> <strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> <em style="color:red">[<%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%]</em></strong> </span>
								<% Else %>
									<%' for dev msg :종료후 %>
									<span class="price"><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></span>
								<% End If %>
							<% End If %>	
						</a>
					</li>
					<%	set oItem = nothing %>

					<%
						IF application("Svr_Info") = "Dev" THEN
							itemid = 1239226
						Else
							itemid = 1683206
						End If
						set oItem = new CatePrdCls
							oItem.GetItemData itemid
					%>
					<li>
						<a href="/shopping/category_prd.asp?itemid=1683206&pEtr=78959">
							<span class="itemImg"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78959/img_with_item_3_v2.jpg" alt="[Disney] Princess Hologram Post Card (E)" /></span>
							<span class="itemName">[Disney] Princess Hologram Post Card</span>
							<% If oItem.FResultCount > 0 Then %>
								<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
									<span class="salePrice"><s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s> <strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> <em style="color:red">[<%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%]</em></strong> </span>
								<% Else %>
									<%' for dev msg :종료후 %>
									<span class="price"><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></span>
								<% End If %>
							<% End If %>	
						</a>
					</li>
					<%	set oItem = nothing %>
				</ul>
			</div>
		</div>

		<!-- visual-->
		<div class="visual">
			<p class="logo"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78959/txt_disney_1010.jpg" alt="" /></p>
			<div class="txt">
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78959/txt_visual.png" alt="안데르센의 동화 인어공주를 바탕으로 1989년에 제작된 디즈니의 28번째 장편 애니메이션! 인간 세계가 너무 궁금한 인어 왕국 공주 에리얼과 그녀를 사랑하는 아버지 트라이튼왕, 그녀를 걱정하는 친구들인 세바스찬과 플라운더, 헛소리하는 갈매기 스커틀 목소리를 담보로 한 거래로 에리얼을 유혹하는 우르 술라의 추억! 인어공주의 목소리와 영상의 조화가너무나 아름다운 영화를 ‘인어공주’ 굿즈로 만나보세요!" /></p>
				<div class="deco">
					<span class="deco1"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78959/img_deco_1.png" alt="" /></span>
					<span class="deco2"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78959/img_deco_2.png" alt="" /></span>
					<span class="deco3"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78959/img_deco_3.png" alt="" /></span>
					<span class="deco4"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78959/img_deco_4.png" alt="" /></span>
				</div>
			</div>
		</div>
		<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="" /></div>

		<!-- gallery -->
		<div class="gallery">
			<ul>
				<li><a href="/shopping/category_prd.asp?itemid=1736460&pEtr=78959"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78959/img_gallery_1.png" alt="[Disney]Ariel_플라운더 뱃지" /></a></li>
				<li><a href="/shopping/category_prd.asp?itemid=1683251&pEtr=78959"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78959/img_gallery_2.png" alt="[Disney]Princess_Memo Pad" /></a></li>
				<li><a href="/shopping/category_prd.asp?itemid=1712139&pEtr=78959"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78959/img_gallery_3.png" alt="[Disney]Ariel_유리글라스" /></a></li>
				<li><a href="/shopping/category_prd.asp?itemid=1714017&pEtr=78959"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78959/img_gallery_4.png" alt="[Disney]Ariel_비치타올" /></a></li>
			</ul>
		</div>

		<div class="collectionImg"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78959/img_item_collection.jpg" alt="" /></div>

		<!-- story -->
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
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1736459&amp;pEtr=78959">
										<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78959/img_slide_1.jpg" alt="[Disney]Ariel_인어공주 뱃지" />
									</a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1736461&amp;pEtr=78959">
										<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78959/img_slide_2.jpg" alt="[Disney]Ariel_세바스찬 뱃지" />
									</a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1736460&amp;pEtr=78959">
										<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78959/img_slide_3.jpg" alt="[Disney]Ariel_플라운더 뱃지" />
									</a>
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
			<p class="t1"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78959/txt_finish_1.png" alt="who says that my dremas how to stay just my dreams" /></p>
			<p class="t2"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78959/txt_finish_2.png" alt="나의 꿈이 꿈으로만 남는다고 누가 그러던가요?" /></p>
		</div>

		<!-- comment -->
		<div class="commentevet">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78959/tit_comment.png" alt="Hey, something project, 바닷속의 아름다운 목소리 인어공주와 함께!" /></h3>
			<p class="hidden">좋아하는 캐릭터를 하나 선택하시고, 인어공주를 좋아하는 이유 혹은 인어공주의 추억을 써주세요 정성껏 코멘트를 남겨주신 5분께 ‘유리컵 에리얼’을 랜덤으로 증정해 드립니다</p>
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
							<li class="ico1"><button type="button" value="1"># Erieol</button></li>
							<li class="ico2"><button type="button" value="2"># Sebastian</button></li>
							<li class="ico3"><button type="button" value="3"># Flounder</button></li>
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
										<% if isarray(split(arrCList(1,intCLoop),"!@#")) then %>
											<strong class="ico<%= split(arrCList(1,intCLoop),"!@#")(0) %>">
												<% if split(arrCList(1,intCLoop),"!@#")(0)="1" then %>
													# Erieol
												<% elseif split(arrCList(1,intCLoop),"!@#")(0)="2" then %>
													# Sebastian
												<% elseif split(arrCList(1,intCLoop),"!@#")(0)="3" then %>
													# Flounde
												<% else %>
													#Erieol
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
				<% End If %>
			</div>
		</div>
<% If Not(Trim(hspchk(1)))="hsproject" Then %>
	</div>
<% End If %>

<script type="text/javascript">
$(function(){

	// wide slide
	$('.heySomething .wideSlide .swiper-wrapper').slidesjs({
		width:1920,
		height:813,
		navigation:{effect:'fade'},
		play:{interval:1800, effect:'fade', auto:false},
		effect:{fade: {speed:1200, crossfade:true}
		},
		callback: {
			complete: function(number) {
				var pluginInstance = $('.wideSlide .swiper-wrapper').data('plugin_slidesjs');
				setTimeout(function() {
					pluginInstance.play(true);
				}, pluginInstance.options.play.interval);
			}
		}
	});

	// story
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
		if (scrollTop > 3500) {
			visualAnimation();
		}
		if (scrollTop > 4700) {
			galleryAnimation();
		}
		if (scrollTop > 8000) {
			finishAnimation();
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

	/* visual animation */
	$(".heySomething .visual .deco span.deco1").css({"opacity":"0"});
	$(".heySomething .visual .deco span.deco2").css({"top":"0px", "margin-left":"150px", "opacity":"0"});
	$(".heySomething .visual .deco span.deco3").css({"top":"350px", "margin-left":"210px", "opacity":"0"});
	$(".heySomething .visual .deco span.deco4").css({"top":"450", "margin-left":"-250px", "opacity":"0"});
	function visualAnimation() {
		$(".heySomething .visual .deco span.deco1").delay(450).animate({"opacity":"1"},800);
		setTimeout(function(){
		$(".heySomething .visual .deco span.deco2").addClass("move").animate({"top":"55px", "margin-left":"50px", "opacity":"1"},800);
		}, 500);
		setTimeout(function(){
		$(".heySomething .visual .deco span.deco3").addClass("move").animate({"top":"305px", "margin-left":"180px", "opacity":"1"},800);
		}, 800);
		setTimeout(function(){
		$(".heySomething .visual .deco span.deco4").addClass("move").animate({"top":"438px", "margin-left":"-215px", "opacity":"1"},800);
		}, 600);

	}

	/* gallery animation*/
	$(".gallery ul li img").css({"opacity":"0"});
	function galleryAnimation() {
		setTimeout(function(){
			$(".gallery ul li:nth-child(1) img").addClass("scale").animate({"opacity":"1"});
			$(".gallery ul li:nth-child(4) img").addClass("scale").animate({"opacity":"1"});
		}, 500);
		setTimeout(function(){
			$(".gallery ul li:nth-child(2) img").addClass("scale").animate({"opacity":"1"});
			$(".gallery ul li:nth-child(3) img").addClass("scale").animate({"opacity":"1"});
		}, 800);
	}

	/* finish animation */
	$(".heySomething .finish p").css({"opacity":"0"});
		$(".heySomething .finish .t1").css({"margin-left":"-300px", "opacity":"0"});
		$(".heySomething .finish .t2").css({"margin-left":"-100px", "opacity":"0"});
	function finishAnimation() {
		$(".heySomething .finish .t1").delay(300).animate({"margin-left":"-254px", "opacity":"1"},500);
		$(".heySomething .finish .t2").delay(400).animate({"margin-left":"-163px", "opacity":"1"},800);
	}

});
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->