<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈
' History : 2017-02-21 김진영 생성
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
	eCode   =  66281
Else
	eCode   =  76302
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
.heySomething .topic {background-color:#ffc3bb; z-index:1;}

/* item */
.heySomething .itemA {margin-top:380px;}
.heySomething .itemA .desc {overflow:hidden; position:relative; min-height:auto; margin:65px 0 50px; padding-top:0;}
.heySomething .itemA .desc .option {float:left; width:380px; height:480px;}
.heySomething .item .option .priceEnd strong {font-size:25px;}
.heySomething .itemA .desc .slidewrap {float:right; width:567px; height:493px; padding:0;}
.heySomething .itemA .slide {width:459px; height:408px; margin:0 auto;}
.heySomething .itemA .with {border:none;}
.heySomething .itemA .with ul {width:1140px; padding:51px 0 0;}
.heySomething .itemA .with ul li {width:20%; padding:0;}
.heySomething .itemA .with ul li span {margin-left:23px;}
.heySomething .itemA .with ul li + li + li + li + li span {margin-left:0px;}
.heySomething .itemA .with ul li + li + li + li span {margin-left:0px;}
.heySomething .with ul li strong {display:inline-block;}

/* visual */
.heySomething .visual {height:812px; margin-top:360px; background:#c5bdee url(http://webimage.10x10.co.kr/eventIMG/2017/hey/76302/bg_purple.jpg) 50% 0 no-repeat;}

/* brand */
.heySomething .brand {position:relative; height:709px; margin-top:492px;}
.heySomething .brand .logo {position:relative; margin:0 auto; padding-bottom:58px;}
.heySomething .brand .logo img {margin-right:10px;}
.heySomething .brandTxt {position:relative; padding-bottom:165px;}
.heySomething .brandTxt02 {position:relative; height:635px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/76302/img_logo_02.jpg) 53% 0 no-repeat;}
.heySomething .txt {position:absolute; top:74px; left:50%; margin-left:-280px;}
.heySomething .brand .btnDown {margin-top:105px;}

/* story */
.heySomething .story {padding-bottom:120px; margin-top:1130px;}
.heySomething .rolling {margin-top:45px; padding-top:210px;}
.heySomething .rolling .swiper-pagination-switch {width:141px; height:169px; margin:0 32px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/76302/bg_ico_01.png);}
.heySomething .rolling .pagination {top:0; padding-left:195px;}
.heySomething .rolling .pagination span em {bottom:-805px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/76302/txt_desc_v2.png); cursor:default;}
.heySomething .rolling .pagination span:first-child {background-position:0 0;}
.heySomething .rolling .pagination span.swiper-active-switch {background-position:0 -169px;}
.heySomething .rolling .pagination span:first-child + span {background-position:-205px 0;}
.heySomething .rolling .pagination span:first-child + span.swiper-active-switch {background-position:-205px -169px;}
.heySomething .rolling .pagination span:first-child + span + span {background-position:100% 0;}
.heySomething .rolling .pagination span:first-child + span + span.swiper-active-switch {background-position:100% -169px;}
.heySomething .rolling .btn-nav {top:510px;}
.heySomething .swipemask {top:209px;}

/* finish */
.heySomething .finish {height:850px; margin-top:500px; background:#ffbcc2 url(http://webimage.10x10.co.kr/eventIMG/2017/hey/76302/bg_finish.jpg) 50% 0 no-repeat;}

/* comment */
.heySomething .commentevet {margin-top:430px;}
.heySomething .commentevet textarea {margin-top:40px;}
.heySomething .commentevet .form {margin-top:30px;}
.heySomething .commentevet .form .choice {margin-left:-10px;}
.heySomething .commentevet .form .choice li {width:113px; height:135px; padding:0 25px;}
.heySomething .commentevet .form .choice li:first-child {padding-left:8px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/76302/bg_ico_02.png);}
.heySomething .commentevet .form .choice li.ico2 button {background-position:-162px 0;}
.heySomething .commentevet .form .choice li.ico2 button.on {background-position:-162px 100%;}
.heySomething .commentevet .form .choice li.ico3 button {background-position:100% 0;}
.heySomething .commentevet .form .choice li.ico3 button.on {background-position:100% 100%;}
.heySomething .commentlist table td {padding:30px 0;}
.heySomething .commentlist table td strong {height:75px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/76302/bg_ico_03.png); background-position:0 0;}
.heySomething .commentlist table td .ico2 {background-position:-150px 0;}
.heySomething .commentlist table td .ico3 {background-position:100% 0;} 
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
		<% If not( left(currenttime,10)>="2017-02-21" and left(currenttime,10)<="2017-02-28" ) Then %>
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
			<div class="bnr"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76302/img_item_represent.jpg" alt="P.S I LOVE MOONLIGHT" /></div>
		</div>

		<%' about %>
		<div class="about">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
			<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
		</div>

		<%' item %>
		<div class="item itemA">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76302/tit_moonlight.png" alt="P.S I LOVE MOONLIGHT" /></h3>
			<a href="/shopping/category_prd.asp?itemid=1654080&amp;pEtr=76302" class="goItem">
				<div class="desc">
					<div class="option">
						<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76302/txt_name.png" alt="[10X10] M.P.R MEMO PAD " /></p>
				<%'' for dev msg : 상품코드 1654080, 할인기간 02/22 ~ 02/28이 지나면  <strong class="discount">...</strong> 숨겨주세요 %>
				<%
					IF application("Svr_Info") = "Dev" THEN
						itemid = 1239226
					Else
						itemid = 1654080
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
						If oItem.FResultCount > 0 Then
							If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN
				%>
						<div class="price">
				<%
								If not( left(currenttime,10)>="2017-02-21" and left(currenttime,10)<="2017-02-28" ) Then %>
				<%				Else %>
							<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/txt_only_10percent.png" alt="단, 일주일만 10%" /></strong>
							<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
				<%				End If %>
							<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
						</div>
				<%			Else %>
						<div class="price priceEnd">
							<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
						</div>
				<%			End If 
						End If 
					set oItem = nothing
				%>
						<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76302/txt_substance.png" alt="텐바이텐과 문라잇펀치로맨스의 콜라보 텐바이텐의 메인컬러인 레드를 시작으로 문라잇펀치로맨스의 핑크와 바이올렛까지, 총 3가지 컬러를 준비했어요. 꼭꼭 기억하고 싶은 일들을 날짜와 함께 적으실 수 있답니다.  오직 텐바이텐에서만 만나보실 수 있어요! " /></p>
						<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러가기" /></div>
					</div>
					<div class="slidewrap">
						<div id="slide01" class="slide">
							<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76302/img_itme_01_v2.jpg" alt="" /></div>
							<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76302/img_itme_02_v2.jpg" alt="" /></div>
							<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76302/img_itme_03_v2.jpg" alt="" /></div>
						</div>
					</div>
				</div>
			</a>

			<div class="with">
				<span><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/ico_plus.png" alt="" /></span>
				<ul>
					<li>
						<a href="/shopping/category_prd.asp?itemid=1654082&amp;pEtr=76302">
							<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76302/img_with_01.jpg" alt="M.P.R memo pad_red" />
							<span><strong>(10x10)</strong> M.P.R memo pad_red</span>
							<strong></strong>
						</a>
					</li>
					<li>
						<a href="/shopping/category_prd.asp?itemid=1654081&amp;pEtr=76302">
							<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76302/img_with_02.jpg" alt="M.P.R memo pad_violet" />
							<span><strong>(10x10)</strong> M.P.R memo pad_violet</span>
						</a>
					</li>
					<li>
						<a href="/shopping/category_prd.asp?itemid=1546840&amp;pEtr=76302">
							<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76302/img_with_03.jpg" alt="pink heart memo pad_ L" />
							<span>pink heart memo pad_ L</span>
						</a>
					</li>
					<li>
						<a href="/shopping/category_prd.asp?itemid=1626022&amp;pEtr=76302">
							<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76302/img_with_04.jpg" alt="starry night memo pad" />
							<span>starry night memo pad</span>
						</a>
					</li>
					<li>
						<a href="/shopping/category_prd.asp?itemid=1546602&amp;pEtr=76302">
							<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76302/img_with_05.jpg" alt="rainbow memo pad " />
							<span>rainbow memo pad </span>
						</a>
					</li>
				</ul>
			</div>
		</div>

		<div class="visual"></div>

		<%' brand %>
		<div class="brand">
			<div class="text">
				<div class="logo"><a href="/street/street_brand_sub06.asp?makerid=moonlightpunchromance"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76302/img_logo.jpg" alt="" /></a></div>
				<div class="brandTxt"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76302/txt_brand.png" alt="문라잇펀치로맨스는 아스라한 달빛 샤워를 받는듯한 느낌을 가진 핑크와 퍼플을 메인 컬러로 레트로한 디자인을 지향하는 문구 브랜드입니다. 현실과 가상 세계를 이어주는 재미있는 디자인으로 여러분을 언제든  원하는 세계로 잠깐 순간 이동할 수 있도록 도와드릴게요!" /></div>
				<div class="brandTxt02"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76302/txt_logo.gif" alt="아련한 달빛의 노래 서글퍼 울고 있는 내게 작지만 큰 위로가 돼 그날의 우리를 기억해" class="txt"/></div>
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
								<div class="swiper-slide"><a href="/street/street_brand_sub06.asp?makerid=moonlightpunchromance"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76302/img_slide_01.jpg" alt="#diary" /></a></div>
								<div class="swiper-slide"><a href="/street/street_brand_sub06.asp?makerid=moonlightpunchromance"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76302/img_slide_02.jpg" alt="#gift" /></a></div>
								<div class="swiper-slide"><a href="/street/street_brand_sub06.asp?makerid=moonlightpunchromance"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76302/img_slide_03.jpg" alt="#to do list" /></a></div>
							</div>
						</div>
					</div>
					<div class="pagination"></div>
				</div>
			</div>
		</div>
		<%' finish %>
		<div class="finish"></div>

		<%' comment %>
		<div class="commentevet">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76302/tit_comment.png" alt="Hey, something project, 나만의 Sweet Time을 소개해주세요!" /></h3>
			<p class="hidden">스트로베리 홍차처럼 달콤한 나만의 시간을 소개해주세요! 정성껏 코멘트를 남겨주신 5분을 추첨하여 [Disney]Alice_Strawberry Black Tea Set (7개입)를 랜덤 발송 해드립니다.</p>
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
							<li class="ico1"><button type="button" value="1">#SWEET TIME</button></li>
							<li class="ico2"><button type="button" value="2">#SWEET TALK</button></li>
							<li class="ico3"><button type="button" value="3">#SWEET GIFT</button></li>
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

			<!-- commentlist -->
			<div class="commentlist"  id="commentlist">
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
												#SWEET TIME
											<% Elseif split(arrCList(1,intCLoop),"!@#")(0)="2" Then %>
												#SWEET TALK
											<% Elseif split(arrCList(1,intCLoop),"!@#")(0)="3" Then %>
												#SWEET GIFT
											<% else %>
												#SWEET TIME
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
									<% end if %>
									<% If arrCList(8,i) <> "W" Then %>
										<br /><img src="http://fiximage.10x10.co.kr/web2013/event/ico_mobile.png" alt="모바일에서 작성됨">
									<% end if %>
								</td>
							</tr>
						<% next %>
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
<% End If %>
<script type="text/javascript">
$(function(){
	/* slide js */
	$("#slide01").slidesjs({
		width:"567",
		height:"493",
		pagination:false,
		navigation:false,
		play:{interval:2000, effect:"fade", auto:true},
		effect:{fade: {speed:900, crossfade:true}
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
		if (scrollTop > 3100 ) {
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

	$(".heySomething .brand .logo").css({"top":"50px","opacity":"0"});
	$(".heySomething .brand .brandTxt").css({"top":"15px","opacity":"0"});
	$(".heySomething .brand .btnDown").css({"opacity":"0"});
	function brandAnimation() {
		$(".heySomething .brand .logo").animate({"top":"0","opacity":"1"},900);
		$(".heySomething .brand .brandTxt").delay(700).animate({"top":"0","opacity":"1"},700);
		$(".heySomething .brand .btnDown").delay(1500).animate({"opacity":"1"},900);
	}
});
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->