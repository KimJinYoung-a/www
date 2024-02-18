﻿<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈 13
' History : 2015-12-01 유태욱 생성
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
	eCode   =  65965
Else
	eCode   =  67728
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
IF application("Svr_Info") = "Dev" THEN
	itemid   =  1239115
Else
	itemid   =  1395718
End If

set oItem = new CatePrdCls
	oItem.GetItemData itemid

Dim hspchk
'// 현재 주소값 체크하여 신규, 구버전 확인
hspchk = Split(LCase(Request.ServerVariables("PATH_INFO")),"/")
%>
<style type="text/css">
/* title */
.heySomething .topic {background-color:#e9e9ea;}

/* item */
.heySomething .itemB {padding-bottom:261px;}
.heySomething .itemB .slidewrap .slide {height:565px;}
.heySomething .itemB .slidesjs-pagination {bottom:-207px;}
.heySomething .itemB .slidesjs-pagination li a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/hey/67728/bg_pagination.jpg);}
.heySomething .item h3 {position:relative; height:107px;}
.heySomething .item h3 .tenten {position:absolute; top:0; left:402px;}
.heySomething .item h3 .oimu {position:absolute; top:0; left:628px;}
.heySomething .item h3 .verticalLine {position:absolute; top:25px; left:569px; width:1px; height:64px; background-color:#d9d9d9;}
.heySomething .item h3 .horizontalLine1, .heySomething .item h3 .horizontalLine2 {position:absolute; top:56px; width:329px; height:1px; background-color:#ddd;}
.heySomething .item h3 .horizontalLine1 {left:0;}
.heySomething .item h3 .horizontalLine2 {right:0;}

/* visual */
.heySomething .visual {padding-bottom:0;}
.heySomething .visual .figure {background-color:#c2c2c2;}

/* brand */
.heySomething .brand {height:730px; padding:290px 0 210px;}

/* story */
.heySomething .story h3 {margin-bottom:73px;}
.heySomething .rolling {padding-top:160px;}
.heySomething .rolling .pagination {top:-28px; width:824px; margin-left:-412px;}
.heySomething .rolling .swiper-pagination-switch {width:150px; height:150px; margin:0 28px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/hey/67728/bg_ico.png);}
.heySomething .rolling .pagination span em {bottom:-788px; left:50%; margin-left:-490px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/hey/67728/txt_story_desc.png); cursor:default;}

/* finish */
.heySomething .finish {background-color:#ccc;}
.heySomething .finish .bg {position:absolute; top:0; left:0; z-index:5; width:100%; height:850px; background:transparent url(http://webimage.10x10.co.kr/eventIMG/2015/hey/67728/img_item_finish.jpg) no-repeat 50% 0; transition:all 0.5s;}
.heySomething .finish .blur {filter:blur(5px); -webkit-filter:blur(5px); -moz-filter: blur(5px); -o-filter:blur(5px); -ms-filter:blur(5px);}

/* comment */
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/hey/67728/bg_ico.png); background-position:0 -300px;}
.heySomething .commentevet .form .choice li.ico2 button {background-position:-150px -300px;}
.heySomething .commentevet .form .choice li.ico3 button {background-position:-300px -300px;}
.heySomething .commentevet .form .choice li.ico4 button {background-position:-450px -300px;}

.heySomething .commentlist table td strong {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/hey/67728/bg_ico.png); background-position:0 -334px;}
.heySomething .commentlist table td strong.ico2 {background-position:-150px -334px;}
.heySomething .commentlist table td strong.ico3 {background-position:-300px -334px;}
.heySomething .commentlist table td strong.ico4 {background-position:-450px -334px;}
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
		<% If not( left(currenttime,10)>="2015-12-02" and left(currenttime,10)<"2015-12-10" ) Then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return false;
		<% else %>
			<% if commentcount>4 then %>
				alert("이벤트는 5회까지 참여 가능 합니다.");
				return false;
			<% else %>
				if (frm.gubunval.value == ''){
					alert('원하는 것을 선택해 주세요.');
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
			<div class="bnr"><a href="/shopping/category_prd.asp?itemid=1395718&amp;pEtr=67728"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67728/img_item_represent.jpg" alt="윈터 원더랜드 세트" /></a></div>
		</div>

		<%' about %>
		<div class="about">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
			<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
		</div>

		<%' item %>
		<div class="item itemB">
			<div class="inner">
				<h3>
					<span class="tenten"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67728/img_logo_tenten.png" alt="텐바이텐" /></span>
					<span class="oimu"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67728/img_logo_oimu.png" alt="OIMU" /></span>
					<span class="verticalLine"></span>
					<span class="horizontalLine1"></span>
					<span class="horizontalLine2"></span>
				</h3>
				<div class="desc">
					<div class="option">
						<em class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67728/txt_name.png" alt="윈터 원더랜드 세트 성냥 캔들 카드" /></em>
						<%''// for dev msg : 할인기간 12/02~12/08 할인기간이 지나면  <strong class="discount">...</strong> 숨겨주세요 %>
						<% if oItem.FResultCount > 0 then %>
							<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
								<div class="price">
									<% If not( left(currenttime,10)>="2015-12-02" and left(currenttime,10)<"2015-12-09" ) Then %>
									<% else %>
										<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/txt_only_<%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>percent.png" alt="단, 일주일만 ONLY <%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%" /></strong>
									<% end if %>
									<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								</div>
							<% Else %>
								<%' for dev msg : 종료 후 %>
								<div class="price priceEnd">
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								</div>
							<% End If %>
						<% end if %>
						<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67728/txt_substance.png" alt="과거와 현재의 가치를 잇는 디자인 스튜디오 OIMU의 WINTER WONDERLAND SET" /></p>
						<div class="btnget"><a href="/shopping/category_prd.asp?itemid=1395718&amp;pEtr=67728"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="윈터 원더랜드 세트 구매하러 가기" /></a></div>
					</div>

					<%' slide %>
					<div class="slidewrap">
						<div id="slide" class="slide">
							<div><a href="/shopping/category_prd.asp?itemid=1395718&amp;pEtr=67728"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67728/img_figure_01.jpg" alt="" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1395718&amp;pEtr=67728"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67728/img_figure_02.jpg" alt="" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1395718&amp;pEtr=67728"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67728/img_figure_03.jpg" alt="" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1395718&amp;pEtr=67728"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67728/img_figure_04.jpg" alt="" /></a></div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<%' visual %>
		<div class="visual">
			<div class="figure"><a href="/shopping/category_prd.asp?itemid=1395718&amp;pEtr=67728"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67728/img_item_visual_big.jpg" alt="윈터 원더랜드 세트" /></a></div>
		</div>

		<%' brand %>
		<div class="brand">
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67728/txt_brand.jpg" alt="오이뮤는 해방 후 1950년대 부터 2010년도까지 유엔 팔각 성냥을 생산해 왔던 유엔 상사와 협업을 통하여 사라져가는 성냥의 수명을 연장시키고 과거와 현재의 가치를 잇는 역할을 합니다. 2015년 텐바이텐과 오이뮤가 콜라보레이션 하여 겨울 시즌 홈파티를 위한 윈터 원더랜드 세트를 제작 하였습니다. 윈터 원더랜드 세트는 스틱양초와 성냥, 카드로 구성되어 소중한 사람들과 따뜻한 마음을 나눌 수 있는 파티에 도움을 드리고자 합니다." /></p>
			<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="" /></div>
		</div>

		<%' story %>
		<div class="story">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67728/tit_story.png" alt="텐바이텐과 오이뮤 그리고 유엔 상사의 만남" /></h3>
			<div class="rollingwrap">
				<div class="rolling">
					<div class="swipemask mask-left"></div>
					<div class="swipemask mask-right"></div>
					<button type="button" class="btn-nav arrow-left">Previous</button>
					<button type="button" class="btn-nav arrow-right">Next</button>
					<div class="swiper">
						<div class="swiper-container swiper1">
							<div class="swiper-wrapper" style="height:630px;">
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1395718&amp;pEtr=67728"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67728/img_slide_01.jpg" alt="성냥과 마찰을 일으켜 불을 켜는 적린 match striker은 수성용액을 최적으로 배합하여 너무 쉽게 불이 붙지 않도록 안전성을 확보하였습니다." /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1395718&amp;pEtr=67728"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67728/img_slide_02.jpg" alt="너무 높지 않은 8cm의 스틱 캔들은 모든 케익에 가장 적합한 높이와 크기이며 11개로 구성 되어 있습니다." /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1395718&amp;pEtr=67728"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67728/img_slide_03.jpg" alt="함께 구성 되어 있는 메시지 카드에 따뜻한 마음을 담아 전해보세요." /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1395718&amp;pEtr=67728"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67728/img_slide_04.jpg" alt="겨울 느낌이 물씬 나는 일러스트와  고급스런 금속 핀으로 고정 된 종이 봉투 포장으로 선물하기에도 좋습니다." /></a>
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
			<a href="/shopping/category_prd.asp?itemid=1395718&amp;pEtr=67728" title="윈터 원더랜드 세트">
				<div class="bg"></div>
			</a>
		</div>

		<%' comment %>
		<div class="commentevet" id="commentlist" >
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67728/tit_comment.png" alt="Hey, something project 당신이 갖고 싶은 것" /></h3>
			<p class="hidden">정성껏 코멘트를 남겨주신 5분을 추첨하여 윈터 원더랜드 세트를 선물로 드립니다. 컬러는 랜덤으로 배송됩니다. 기간 : 2015.12.2 ~ 12.9 / 발표 : 12.10</p>

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
					<legend>윈터 원더랜드 세트 코멘트 쓰기</legend>
						<ul class="choice">
							<li class="ico1"><button type="button" value="1">Match</button></li>
							<li class="ico2"><button type="button" value="2">Candle</button></li>
							<li class="ico3"><button type="button" value="3">Card</button></li>
							<li class="ico4"><button type="button" value="4">Package</button></li>
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

			<%' commentlist %>
			<div class="commentlist">
				<p class="total">total <%= iCTotCnt %></p>
				<% IF isArray(arrCList) THEN %>
					<table>
						<caption>윈터 원더랜드 세트 코멘트 목록</caption>
						<colgroup>
							<col style="width:150px;" />
							<col style="width:*;" />
							<col style="width:110px;" />
							<col style="width:120px;" />
							<col style="width:10px;" />
						</colgroup>
						<thead>
						<tr>
							<th scope="col"></th>
							<th scope="col">내용</th>
							<th scope="col">작성일자</th>
							<th scope="col">아이디</th>
							<th scope="col"></th>
						</tr>
						</thead>
						<tbody>
							<% For intCLoop = 0 To UBound(arrCList,2) %>
							<tr>
								<td>
									<% if isarray(split(arrCList(1,intCLoop),"!@#")) then %>
										<strong class="ico<%= split(arrCList(1,intCLoop),"!@#")(0) %>">
											<% if split(arrCList(1,intCLoop),"!@#")(0)="1" then %>
												Match
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="2" then %>
												Candle
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="3" then %>
												Card
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="4" then %>
												Package
											<% Else %>
												Match
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
	$(".finish .bg").addClass("blur");

	/* swipe */
	var swiper1 = new Swiper('.swiper1',{
		centeredSlides:true,
		slidesPerView:"auto",
		//initialSlide:0,
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
	$("#slide").slidesjs({
		width:"570",
		height:"565",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:2500, effect:"fade", auto:true},
		effect:{fade: {speed:2000, crossfade:true}
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
	//mouse control
	$('#slide .slidesjs-pagination > li a').mouseenter(function(){
		$('a[data-slidesjs-item="' + $(this).attr("data-slidesjs-item") + '"]').trigger('click');
	});

	$(".slidesjs-pagination li:nth-child(1)").addClass("num01");
	$(".slidesjs-pagination li:nth-child(2)").addClass("num02");
	$(".slidesjs-pagination li:nth-child(3)").addClass("num03");
	$(".slidesjs-pagination li:nth-child(4)").addClass("num04");

	/* animation effect */
	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 800 ) {
			itemAnimation()
		}
		if (scrollTop > 3200 ) {
			brandAnimation()
		}
		if (scrollTop > 6500 ) {
			finishAnimation()
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
	$(".heySomething .item h3 span").css({"opacity":"0"});
	$(".heySomething .item h3 .tenten").css({"left":"502px"});
	$(".heySomething .item h3 .oimu").css({"left":"528px"});
	function itemAnimation() {
		$(".heySomething .item h3 .tenten").delay(200).animate({"left":"402px", "opacity":"1"},1000);
		$(".heySomething .item h3 .oimu").delay(200).animate({"left":"628px", "opacity":"1"},1000);
		$(".heySomething .item h3 .horizontalLine1").delay(1000).animate({"opacity":"1"},500);
		$(".heySomething .item h3 .horizontalLine2").delay(1000).animate({"opacity":"1"},500);
		$(".heySomething .item h3 .verticalLine").delay(1000).animate({"opacity":"1"},500);
	}

	/* brand animation */
	$(".heySomething .brand p").css({"height":"0", "opacity":"0"});
	$(".heySomething .brand .btnDown").css({"margin-top":"70px", "opacity":"0"});
	function brandAnimation() {
		$(".heySomething .brand p").delay(500).animate({"height":"796px", "opacity":"1"},1500);
		$(".heySomething .brand .btnDown").delay(2500).animate({"margin-top":"62px", "opacity":"1"},800);
	}

	/* finish animation */
	function finishAnimation() {
		$(".finish .bg").removeClass("blur");
	}
});
</script>
<% set oItem=nothing %>
<!-- #include virtual="/lib/db/dbclose.asp" -->