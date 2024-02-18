<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈 23
' History : 2016-03-08 유태욱 생성
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
dim oItem, itemid
dim currenttime
	currenttime =  now()
'																			currenttime = #03/02/2016 09:00:00#

dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  66060
Else
	eCode   =  69521
End If

dim userid, commentcount, i
	userid = GetEncLoginUserID()

commentcount = getcommentexistscount(userid, eCode, "", "", "", "Y")

dim cEComment ,blnFull, cdl, com_egCode, bidx, blnBlogURL, strBlogURL
dim iCTotCnt, arrCList,intCLoop, ecc
dim iCPageSize, iCCurrpage, isMyComm
dim iCStartPage, iCEndPage, iCTotalPage, iCx,iCPerCnt
	iCCurrpage	= requestCheckVar(Request("iCC"),10)	'현재 페이지 번호
	cdl			= requestCheckVar(Request("cdl"),3)
	blnFull		= requestCheckVar(Request("blnF"),10)
	blnBlogURL	= requestCheckVar(Request("blnB"),10)
	isMyComm	= requestCheckVar(request("isMC"),1)
	ecc	= requestCheckVar(request("ecc"),10)
	
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


Dim hspchk
'// 현재 주소값 체크하여 신규, 구버전 확인
hspchk = Split(LCase(Request.ServerVariables("PATH_INFO")),"/")
%>
<style type="text/css">
/* title */
.heySomething .topic {background-color:#edecea; z-index:1;}

/* item */
.heySomething .itemA .figure {top:93px; left:665px}
.heySomething .itemA .desc {padding-top:93px; min-height:470px;}
.heySomething .itemA .with ul {width:1030px;}
.heySomething .itemA .with ul li {width:217px; padding:0 20px;}
.heySomething .item .option .price strong {color:#000; font-family:verdana, tahoma, sans-serif;}

/* visual */
.heySomething .visual .figure {background-color:#fff;}

/* brand */
.heySomething .brand {position:relative; height:605px;}
.heySomething .brand .info {width:280px; height:465px; margin:0 auto; font-size:0; line-height:0; text-indent:-9999px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/69521/txt_designer.png) 50% 0 no-repeat;}

/* gallery */
.heySomething .gallery {overflow:hidden; position:relative; width:749px; height:734px; margin:230px auto 0;}
.heySomething .gallery div {position:absolute;}
.heySomething .gallery .pic01 {left:0; top:0;}
.heySomething .gallery .pic02 {right:0; top:0;}
.heySomething .gallery .pic03 {left:0; bottom:0;}
.heySomething .gallery .pic04 {right:0; bottom:0;}

/* story */
.heySomething .story {padding-top:0; margin-top:424px;}
.heySomething .rolling {padding-top:204px;}
.heySomething .rolling .pagination {top:0; width:824px; margin-left:-412px;}
.heySomething .rolling .swiper-pagination-switch {width:130px; height:130px; margin:0 38px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/69521/bg_ico.png);}
.heySomething .rolling .pagination span.swiper-active-switch {background-position:0 -130px;}
.heySomething .rolling .pagination span:first-child + span {background-position:-206px 0;}
.heySomething .rolling .pagination span:first-child + span.swiper-active-switch {background-position:-206px -130px;}
.heySomething .rolling .pagination span:first-child + span + span {background-position:-412px 0;}
.heySomething .rolling .pagination span:first-child + span + span.swiper-active-switch {background-position:-412px -130px;}
.heySomething .rolling .pagination span:first-child + span + span + span {background-position:-618px 0;}
.heySomething .rolling .pagination span:first-child + span + span + span.swiper-active-switch {background-position:-618px -130px;}

.heySomething .rolling .pagination span em {bottom:-850px; left:50%; margin-left:-490px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/69521/txt_slide_desc.jpg); cursor:default;}
.heySomething .rolling .btn-nav {top:488px;}
.heySomething .swipemask {top:205px;}

/* comment */
.heySomething .commentevet {margin:0 auto 100px;}
.heySomething .commentevet .form .choice li {width:111px; height:111px; margin-right:30px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/69521/bg_ico2.png);}
.heySomething .commentevet .form .choice li.ico1 button {background-position:0 0;}
.heySomething .commentevet .form .choice li.ico1 button.on {background-position:0 -111px;}
.heySomething .commentevet .form .choice li.ico2 button {background-position:-141px 0;}
.heySomething .commentevet .form .choice li.ico2 button.on {background-position:-141px -111px;}
.heySomething .commentevet .form .choice li.ico3 button {background-position:-283px 0;}
.heySomething .commentevet .form .choice li.ico3 button.on {background-position:-283px -111px;}
.heySomething .commentevet .form .choice li.ico4 button {background-position:-424px 0;}
.heySomething .commentevet .form .choice li.ico4 button.on {background-position:-424px -111px;}
.heySomething .commentevet textarea {margin-top:20px;}

.heySomething .commentlist table td {padding:20px 0;}
.heySomething .commentlist table td strong {width:111px; height:111px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/69521/bg_ico2.png);}
.heySomething .commentlist table td .ico1 {background-position:0 0;}
.heySomething .commentlist table td .ico2 {background-position:-141px 0;}
.heySomething .commentlist table td .ico3 {background-position:-283px 0;}
.heySomething .commentlist table td .ico4 {background-position:-424px 0;}
</style>
<script type='text/javascript'>
<% if Request("iCC") <> "" or request("ecc") <> "" then %>
	$(function(){
		var val = $('#commentlist').offset();
	    $('html,body').animate({scrollTop:val.top},0);
	});
<% end if %>

function jsGoComPage(iP){
	document.frmcom.iCC.value = iP;
	document.frmcom.iCTot.value = "<%=iCTotCnt%>";
	document.frmcom.submit();
}

function jsSubmitComment(frm){
	<% If IsUserLoginOK() Then %>
		<% if commentcount>0 then %>
			alert("이벤트는 한번만 참여 가능 합니다.");
			return false;
		<% else %>
			if (frm.gubunval.value == ''){
				alert('원하는 항목을 선택해 주세요.');
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
			<div class="bnr"><a href="/street/street_brand_sub06.asp?makerid=kokacharm"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69521/img_item_represent.jpg" alt="TOGETHER SPRING!" /></a></div>
		</div>
	
		<%' about %>
		<div class="about">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
			<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
		</div>
	
		<%' item %>
		<div class="item itemA">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69521/tit_kokacharm.png" alt="KOKACHARM" /></h3>
	
			<div class="desc">
				<%'' 상품 이름, 가격, 구매하기 %>
				<div class="option">
					<em class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69521/txt_name_v2.png" alt="[꼬까참새] 댄디 삼총사" /></em>
					<%
					IF application("Svr_Info") = "Dev" THEN
						itemid = 1239226
					Else
						itemid = 1448011
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
					%>
						<% if oItem.FResultCount > 0 then %>
							<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
								<div class="price">
									<% If not( left(currenttime,10)>="2016-03-09" and left(currenttime,10)<"2017-01-01" ) Then %>
									<% else %>
										<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/txt_just_one_week.png" alt="단, 일주일만 just one week" /></strong>
										<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
									<% end if %>
										<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
									<p class="tMar10"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69521/txt_brand_v2.png" alt="심플한 체크무늬의 베이직한 라운지 웨어, 꼬까참새 신상을 초대합니다." /></p>
								</div>
							<% Else %>
									<%	''  for dev msg : 종료 후 %>
									<div class="price priceEnd">
										<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
									</div>
							<% end if %>
						<% end if %>
					<% set oItem=nothing %>
					<p class="substance"><a href="/shopping/category_prd.asp?itemid=1133678"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69521/txt_gift.png" alt="이벤트 기간동안 꼬까참새 상품을 5만원 이상 구매하신 모든 분께 스마일조명을 선물로 드립니다.(컬러랜덤)" /></a></p>
					<div class="btnget"><a href="/shopping/category_prd.asp?itemid=1448011&amp;pEtr=69521"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러 가기" /></a></div>
				</div>
				<div class="figure"><a href="/shopping/category_prd.asp?itemid=1448011&amp;pEtr=69521"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69521/img_item1_v2.jpg" alt="꼬까참새 - 댄디 삼총사" /></a></div>
			</div>
	
			<div class="with">
				<span><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/ico_plus.png" alt="" /></span>
				<ul>
					<li>
					<%
					IF application("Svr_Info") = "Dev" THEN
						itemid = 786868
					Else
						itemid = 1448019
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
					%>
						<a href="/shopping/category_prd.asp?itemid=1448019&amp;pEtr=69521">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69521/img_item2_v2.jpg" alt="" />
							<span>[꼬까참새] 심플체크</span>
							<% if oItem.FResultCount > 0 then %>
								<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
							<% end if %>
						</a>
					<% set oItem=nothing %>
					</li>
					<li>
					<%
					IF application("Svr_Info") = "Dev" THEN
						itemid = 279397
					Else
						itemid = 1448043
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
					%>
						<a href="/shopping/category_prd.asp?itemid=1448043&amp;pEtr=69521">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69521/img_item3.jpg" alt="" />
							<span>[꼬까참새] 골든아티스트</span>
							<% if oItem.FResultCount > 0 then %>
								<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
							<% end if %>
						</a>
					<% set oItem=nothing %>
					</li>
					<li>
					<%
					IF application("Svr_Info") = "Dev" THEN
						itemid = 1158976
					Else
						itemid = 1448030
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
					%>
						<a href="/shopping/category_prd.asp?itemid=1448030&amp;pEtr=69521">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69521/img_item4.jpg" alt="" />
							<span>[꼬까참새] 캔디바</span>
							<% if oItem.FResultCount > 0 then %>
								<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
							<% end if %>
						</a>
					<% set oItem=nothing %>
					</li>
					<li>
					<%
					IF application("Svr_Info") = "Dev" THEN
						itemid = 1176228
					Else
						itemid = 1445498
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
					%>
						<a href="/shopping/category_prd.asp?itemid=1445498&amp;pEtr=69521">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69521/img_item5.jpg" alt="" />
							<span>[꼬까참새] 정글삭스</span>
							<% if oItem.FResultCount > 0 then %>
								<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
							<% end if %>
						</a>
					<% set oItem=nothing %>
					</li>
				</ul>
			</div>
		</div>
	
		<%'' visual %>
		<div class="visual">
			<div class="figure"><a href="/shopping/category_prd.asp?itemid=1445498&amp;pEtr=69521"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69521/img_item_visual_big.jpg" alt="" /></a></div>
		</div>
	
		<%'' brand %>
		<div class="brand">
			<div class="info">단조롭고 심심한 일상에서 소소한 즐거움을 드리고 싶었습니다. 눈에 띄는 화려함 대신 입힐수록 손이 가고 마음이 가는 아이들이 있습니다. 간결함과 베이직함 속에 디테일은 놓치지 않은 그 즐거움을 공감하고 소통하며 일상에서의 특별함을 차곡차곡 담아낼 것입니다. / designer. 박선영 2016</div>
			<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="" /></div>
		</div>
	
		<%'' gallery %>
		<div class="gallery">
			<a href="/street/street_brand_sub06.asp?makerid=kokacharm">
				<div class="pic01"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69521/img_gallery_01.jpg" alt="" /></div>
				<div class="pic02"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69521/img_gallery_02.jpg" alt="" /></div>
				<div class="pic03"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69521/img_gallery_03.jpg" alt="" /></div>
				<div class="pic04"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69521/img_gallery_04.jpg" alt="" /></div>
			</a>
		</div>
	
		<%''story %>
		<div class="story">
			<div class="rollingwrap">
				<div class="rolling">
					<div class="swipemask mask-left"></div>
					<div class="swipemask mask-right"></div>
					<button type="button" class="btn-nav arrow-left">Previous</button>
					<button type="button" class="btn-nav arrow-right">Next</button>
					<div class="swiper">
						<div class="swiper-container swiper1">
							<div class="swiper-wrapper" style="height:630px;">
								<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69521/img_slide_01.jpg" alt="아이들 스스로 쉽게 입고 벗을 수 있는 루즈핏의 라운지웨어로 목부분은 넉넉한 폭을 주고, 허리밴딩은 너무 조이지 않도록 디자인 되었습니다. 편안한 순면100%의 이지웨어로 촉감이 부드럽고 세탁이 용이합니다." /></div>
								<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69521/img_slide_02.jpg" alt="어깨, 패턴 등의 재미있는 디자인 요소는 집에서 뿐만 아니라 어린이집, 유치원에서도 맘껏 뛰어놀기 좋은 어느 곳에서나 잘 어울리는 통통 튀는 디자인입니다." /></div>
								<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69521/img_slide_03.jpg" alt="양말과, 실내복은 아이들의 필수품으로 선물하기에 좋은 아이템입니다. 별도로 구매 가능한 선물 패키지 구성을 함께 구성하신다면 어떤분께 선물해도 만족도 100%를 자랑할 것입니다." /></div>
								<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69521/img_slide_04.jpg" alt="형제들끼리, 친구들끼리 귀여운 커플룩을 연출할 수 있습니다. 획일된 커플웨어가 아닌, 다양성을 살리면서도 서로의 개성을 느낄 수 있는 꼬까참새만의 디자인은, 아이들을 보는 어른들의 마음까지 행복하게 해줍니다." /></div>
							</div>
						</div>
					</div>
					<div class="pagination"></div>
				</div>
			</div>
		</div>
	
		<%'' comment %>
		<div class="commentevet" id="commentlist">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69521/tit_comment.png" alt="Hey, something project 너에게 하고 싶은말" /></h3>
			<p class="hidden">정성껏 코멘트를 남겨주신 3분을 추첨하여, 꼬까참새의 신상내의와 양말을 드립니다. 기간 : 2016.03.09 ~ 03.15 / 발표 : 03.16</p>
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
				<input type="hidden" name="txtcomm">
				<input type="hidden" name="gubunval">
				<% If InStr(Request.ServerVariables("QUERY_STRING"), "&ecc=1") > 0 Then %>
				<% Else %>
					<input type="hidden" name="hookcode" value="&ecc=1">
				<% End If %>
					<fieldset>
					<legend>코멘트 쓰기</legend>
						<ul class="choice">
							<li class="ico1"><button type="button" value="1">EASY</button></li>
							<li class="ico2"><button type="button" value="2">FUN</button></li>
							<li class="ico3"><button type="button" value="3">PRESENT</button></li>
							<li class="ico4"><button type="button" value="4">TOGETHER</button></li>
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
					<% If InStr(Request.ServerVariables("QUERY_STRING"), "&ecc=1") > 0 Then %>
					<% Else %>
						<input type="hidden" name="hookcode" value="&ecc=1">
					<% End If %>
				</form>
			</div>
	
			<% '' commentlist %>
			<div class="commentlist">
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
													EASY
												<% elseif split(arrCList(1,intCLoop),"!@#")(0)="2" then %>
													FUN
												<% elseif split(arrCList(1,intCLoop),"!@#")(0)="3" then %>
													PRESENT
												<% elseif split(arrCList(1,intCLoop),"!@#")(0)="4" then %>
													TOGETHER
												<% Else %>
													EASY
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
		
					<%'' paging %>
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
	/* swipe */
	var swiper1 = new Swiper('.swiper1',{
		centeredSlides:true,
		slidesPerView:"auto",
		loop: true,
		speed:1500,
		autoplay:5000,
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

	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 4450 ) {
			galleryAnimation()
		}
		if (scrollTop > 3380 ) {
			brandAnimation()
		}
	});

	/* gallery animation */
	$(".heySomething .gallery div").css({"opacity":"0"});
	$(".heySomething .gallery div.pic01").css({"left":"-30px"});
	$(".heySomething .gallery div.pic02").css({"top":"-30px"});
	$(".heySomething .gallery div.pic03").css({"bottom":"-30px"});
	$(".heySomething .gallery div.pic04").css({"right":"-30px"});
	function galleryAnimation() {
		$(".heySomething .gallery div.pic01").delay(100).animate({"left":"0","opacity":"1"},900);
		$(".heySomething .gallery div.pic02").delay(100).animate({"top":"0","opacity":"1"},900);
		$(".heySomething .gallery div.pic03").delay(100).animate({"bottom":"0","opacity":"1"},900);
		$(".heySomething .gallery div.pic04").delay(100).animate({"right":"0","opacity":"1"},900);
	}

	/* brand animation */
	$(".heySomething .brand .info").css({"height":"0", "opacity":"0"});
	$(".heySomething .brand .btnDown").css({"margin-top":"70px", "opacity":"0"});
	function brandAnimation() {
		$(".heySomething .brand .info").delay(500).animate({"height":"465px", "opacity":"1"},1800);
		$(".heySomething .brand .btnDown").delay(2200).animate({"margin-top":"62px", "opacity":"1"},800);
	}
	
});
</script>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->