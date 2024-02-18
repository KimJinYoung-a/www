<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'###########################################################
' Description : hey, something project 시리즈 93
' 당신만을 위한 슈즈, veronica for LONDON
' History : 2017-10-30 정태훈 생성
'###########################################################
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
	eCode   =  67446
Else
	eCode   =  81542
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
.tMar20 {margin-top:20px;}
/* title */
.heySomething .topic {background-color:#bf8948;}
.heySomething .topic h2 span {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_hey_something_project_white.png);}

/* item */
.heySomething .item {margin:400px auto 0;}
.heySomething .itemA .desc {width:1140px; min-height:410px; margin:108px auto 0; padding:109px 0 0 0; border-top:1px dashed #ccc;}
.heySomething .itemA .desc1 {margin-top:135px; padding-top:0; border-top:0;}
.heySomething .itemA .inner {overflow:hidden; display:block; width:980px; margin:0 auto 137px;}

.heySomething .itemA .figure {position:static; float:right; margin-right:-110px;}
.heySomething .itemA .desc .option {float:left; width:370px; height:268px;}
.heySomething .itemA .desc2 .option {float:right; width:295px; padding-left:75px;}
.heySomething .itemA .desc2 .btnget {left:75px;}
.heySomething .item .option .price {margin-top:65px;}
.thumb {overflow:hidden; height:992px;}
.thumb li img{width:560px; height:485px;}

/* brand */
.heySomething .brand {position:relative; height:645px; margin:480px 0 0; text-align:center;}
.heySomething .brand .btnDown {margin-top:53px;}

/* gallery */
.gallery {padding:360px 0 475px;}
.gallery ul {position:relative; width:850px; height:930px; margin:0 auto;}
.gallery li {position:absolute; background-color:#dee4e7;}
.gallery li img {opacity:0;}
.gallery .gallery1 {top:0; left:0; }
.gallery .gallery2 {top:0; right:0;background-color:#dbcdbf;}
.gallery .gallery3 {bottom:0; left:0; background-color:#d9e0e4;}
.gallery .gallery4 {bottom:0; right:0; background-color:#d9e0e4;}
.gallery .gallery2 img {animation-delay:0.6s;}
.gallery .gallery3 img {animation-delay:0.3s;}
.opacity {animation:opacity 2.2s cubic-bezier(0.19, 1, 0.22, 1) forwards;}
@keyframes opacity {
	0% {opacity:0;}
	100% {opacity:1;}
}

/* special */
.special {text-align:center;}
.special p {margin-bottom:53px;}

/* story */
.heySomething .story {margin:200px 0 0;}
.heySomething .rollingwrap {margin-top:0;}
.heySomething .rolling {padding-top:165px;}
.heySomething .rolling .swiper .swiper-slide {padding:0 40px;}
.heySomething .rolling .pagination {margin-left:-320px;}
.heySomething .rolling .pagination span {margin:0 10px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/81542/bg_ico_1.png);}
.heySomething .rolling .pagination span em {bottom:-780px; left:-150px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/81542/txt_story_desc.png); cursor:default;}
.heySomething .rolling .btn-nav {top:445px;}
.heySomething .swipemask {top:165px;}

/* finish */
.heySomething .finish {height:630px; padding-top:120px; background:#d5ceb7 url(http://webimage.10x10.co.kr/eventIMG/2017/hey/81542/bg_finish.jpg) no-repeat 50% 0; text-align:center;}
.heySomething .finish p {top:0; margin-left:-951px;}

/* comment */
.heySomething .commentevet {padding-top:52px; margin-top:420px}
.heySomething .commentevet textarea {margin-top:0;}
.heySomething .commentevet .form {margin-top:0;}
.heySomething .commentevet .form .choice {margin-left:-20px;}
.heySomething .commentevet .form .choice li {width:150px; height:150px; margin-right:-30px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/81542/bg_ico_2_v3.png);}

.heySomething .commentlist table td strong {width:150px; height:150px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/81542/bg_ico_2_v3.png); background-position:0 0}
.heySomething .commentlist table td .ico2 {background-position:-150px 0;}
.heySomething .commentlist table td .ico3 {background-position:-300px 0;}
.heySomething .commentlist table td .ico4 {background-position:-450px 0;}
</style>
<script  src='/lib/js/jquery.elevateZoom-3.0.8.min.js'></script>
<script type="text/javascript">
$(function(){
	$('#zoom-1').elevateZoom({
		zoomType: "inner",
		zoomWindowFadeIn: 500,
		zoomWindowFadeOut: 750,
	});
	$('#zoom-2').elevateZoom({
		zoomType: "inner",
		zoomWindowFadeIn: 500,
		zoomWindowFadeOut: 750
	});
	$('#zoom-3').elevateZoom({
		zoomType: "inner",
		zoomWindowFadeIn: 500,
		zoomWindowFadeOut: 750
	});
	$('#zoom-4').elevateZoom({
		zoomType: "inner",
		zoomWindowFadeIn: 500,
		zoomWindowFadeOut: 750
	});
});
</script>
<script type="text/javascript">
<!--
function jsGoComPage(iP){
	document.frmcom.iCC.value = iP;
	document.frmcom.iCTot.value = "<%=iCTotCnt%>";
	document.frmcom.submit();
}

function jsSubmitComment(frm){
	<% If IsUserLoginOK() Then %>
		<% If not( left(currenttime,10)>="2017-10-30" and left(currenttime,10)<"2018-11-08" ) Then %>
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
//-->
</script> 
			<% If Not(Trim(hspchk(1)))="hsproject" Then %>
			<div class="heySomething">
			<% end if %>
				<% If Not(Trim(hspchk(1)))="hsproject" Then %>
					<%' for dev mgs :  탭 navigator %>
					<div class="navigator">
						<ul>
							<!-- #include virtual="/event/etc/inc_66049_menu.asp" -->
						</ul>
						<span class="line"></span>
					</div>
				<% End If %>
				<div class="topic">
					<h2>
						<span class="letter1">Hey,</span>
						<span class="letter2">something</span>
						<span class="letter3">project</span>
					</h2>
					<div class="bnr"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81542/img_item_represent.jpg" alt="veronica" /></div>
				</div>

				<!-- about -->
				<div class="about">
					<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
					<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
				</div>
				<%
					IF application("Svr_Info") = "Dev" THEN
						itemid = 1239226
					Else
						itemid = 1818061
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
				%>
				<!-- item -->
				<div class="item itemA">
					<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81542/tit_veronica.gif" alt="veronica for london" /></h3>
					<div class="desc desc1">
						<a href="/shopping/category_prd.asp?itemid=1818061&pEtr=81542" class="inner">
							<div class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81542/img_item.jpg" alt="" /></div>
							<div class="option">
								<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81542/txt_item_01.gif" alt="ONLY 텐바이텐 VWMS TINKLE FLAT(Black) " /></p>
							<% If oItem.FResultCount > 0 Then %>
								<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
								<div class="price">
									<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> <span>(<%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%)</span></strong>
								</div>
								<% Else %>
								<div class="price priceEnd" >
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								</div>
								<% End If %>
							<% End If %>
								<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러가기" /></div>
							</div>
						</a>
						<ul class="thumb">
							<li class="ftLt"><img id="zoom-1" src='http://webimage.10x10.co.kr/eventIMG/2017/hey/81542/img_item_sm_1.jpg' data-zoom-image="http://webimage.10x10.co.kr/eventIMG/2017/hey/81542/img_item_lg_1.jpg"/></li>
							<li class="ftRt"><img id="zoom-2" src='http://webimage.10x10.co.kr/eventIMG/2017/hey/81542/img_item_sm_2.jpg' data-zoom-image="http://webimage.10x10.co.kr/eventIMG/2017/hey/81542/img_item_lg_2.jpg"/></li>
							<li class="ftLt tMar20"><img id="zoom-3" src='http://webimage.10x10.co.kr/eventIMG/2017/hey/81542/img_item_sm_3.jpg' data-zoom-image="http://webimage.10x10.co.kr/eventIMG/2017/hey/81542/img_item_lg_3.jpg"/></li>
							<li class="ftRt tMar20"><img id="zoom-4" src='http://webimage.10x10.co.kr/eventIMG/2017/hey/81542/img_item_sm_4.jpg' data-zoom-image="http://webimage.10x10.co.kr/eventIMG/2017/hey/81542/img_item_lg_4.jpg"/></li>
						</ul>
					</div>
				</div>

				<!-- brand -->
				<div class="brand">
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81542/txt_brand.jpg" alt="Veronica Symbol Logo Sharing Joyful Changes 내사랑은 쉽습니다. 사랑하는 사람을 생각하며 디자인 놀이를 하면 되니까요." /></p>
					<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="아래로 이동" /></div>
				</div>

				<!-- gallery -->
				<div class="gallery" id="gallery">
					<ul>
						<li class="gallery1"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81542/img_gallery_1.jpg" alt="" /></li>
						<li class="gallery2"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81542/img_gallery_2.jpg" alt="" /></li>
						<li class="gallery3"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81542/img_gallery_3.jpg" alt="" /></li>
						<li class="gallery4"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81542/img_gallery_4.jpg" alt="" /></li>
					</ul>
				</div>

				<div class="special">
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81542/txt_special_emotion.png" alt="심플한 슈즈에 담긴 특별한 감성" /></p>
					<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81542/img_special_emotion.jpg" alt="" /></div>
				</div>

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
										<div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1818061&pEtr=81542"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81542/img_slide_story_01.jpg" alt="#Present 소중한 그대, 좋은 길만 가길.. 더 좋은 길로 안내해줄 베로니카를 선물하세요." /></a></div>
										<div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1818061&pEtr=81542"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81542/img_slide_story_02.jpg" alt="#Love 모든 것의 시작은 사랑입니다. 사랑하는 사람을 위해 만든 베로니카 포 런던." /></a></div>
										<div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1818061&pEtr=81542"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81542/img_slide_story_03.jpg" alt="#Well 잘 만든 슈즈. 베로니카는 자연 친화적인 소재를 사용하여 제작 합니다." /></a></div>
										<div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1818061&pEtr=81542"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81542/img_slide_story_04.jpg" alt="#Relax 내발에 꼭 맞는 슈즈. 3단계로 선택할 수 있는 발볼 사이즈로 조금더 편안한 하루를 보내세요" /></a></div>
									</div>
								</div>
							</div>
							<div class="pagination"></div>
						</div>
					</div>
				</div>

				<!--- finish -->
				<div class="finish"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81542/txt_finish.png" alt="베로니카와 당신이 함께 할 시간들이 행복하길 바랍니다." /></div>

				<!-- comment -->
				<div class="commentevet">
					<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81542/tit_comment.gif" alt="Hey, something project, 언제 베로니카 슈즈를 신고 싶나요?" /></h3>
					<p class="hidden">텐바이텐 X 베로니카 상품을 보고 언제 TINKLE FLAT슈즈를 신고 싶은지 남겨주세요! 정성스러운 댓글을 남겨주신 5분을 선정해  텐바이텐 1만원권 상품권을 드립니다! </p>
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
									<li class="ico1"><button type="button" value="1">#Present</button></li>
									<li class="ico2"><button type="button" value="2">#Love</button></li>
									<li class="ico3"><button type="button" value="3">#Well</button></li>
									<li class="ico4"><button type="button" value="4">#Relax</button></li>
								</ul>
								<textarea title="코멘트 작성" cols="60" rows="5" name="txtcomm1" id="txtcomm1" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();" <%IF NOT(IsUserLoginOK) THEN%>readonly<%END IF%>><%IF NOT IsUserLoginOK THEN%>로그인 후 글을 남길 수 있습니다.<% else %><%END IF%></textarea>
								<div class="note01 overHidden">
									<ul class="list01 ftLt">
										<li>입력하신 블로그 주소는 개인정보 유출로 인한 피해를 막고자 비공개로 텐바이텐에 접수됩니다.</li>
										<li>통신예절에 어긋나는 글이나 상업적인 글, 타 사이트에 관련된 글 또는 도용한 글은 관리자에 의해 사전 통보 없이 삭제될 수 있으며,<br>이벤트 참여에 제한을 받을 수 있습니다.</li>
									</ul>
									<input type="submit" class="ftRt btn btnW130 btnS1 btnRed" value="코멘트 남기기" onclick="jsSubmitComment(document.frmcom); return false;" />
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
					<div class="commentlist">
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
									#Present
									<% elseif split(arrCList(1,intCLoop),"!@#")(0)="2" then %>
									#Love
									<% elseif split(arrCList(1,intCLoop),"!@#")(0)="3" then %>
									#Well
									<% elseif split(arrCList(1,intCLoop),"!@#")(0)="4" then %>
									#Relax
									<% else %>
									#Present
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
										<button type="button" class="btndel" onclick="jsDelComment('<% = arrCList(0,intCLoop) %>'); return false;"><img src="http://fiximage.10x10.co.kr/web2013/event/btn_cmt_close.gif" alt="코멘트 삭제"></button>
										<% end if %>
										<% If arrCList(8,i) <> "W" Then %>
										<br /><img src="http://fiximage.10x10.co.kr/web2013/event/ico_mobile.png" alt="모바일에서 작성됨">
										<% end if %>
									</td>
								</tr>
								<% Next %>
							</tbody>
						</table>
						<% End If %>

						<!-- paging -->
						<div class="pageWrapV15">
							<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
						</div>
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

	/* title animation */
	titleAnimation();
	$(".heySomething .topic h2 span").css({"opacity":"0"});
	$(".heySomething .topic h2 .letter1").css({"margin-top":"7px"});
	$(".heySomething .topic h2 .letter2").css({"margin-top":"15px"});
	$(".heySomething .topic h2 .letter3").css({"margin-top":"23px"});
	function titleAnimation() {
		$(".heySomething .topic h2 .letter1").delay(300).animate({"margin-top":"0", "opacity":"1"},800);
		$(".heySomething .topic h2 .letter2").delay(700).animate({"margin-top":"7px", "opacity":"1"},800);
		$(".heySomething .topic h2 .letter3").delay(1100).animate({"margin-top":"17px", "opacity":"1"},800);
	}

	/* gallery animation */
	function galleryAnimation() {
		var window_top = $(window).scrollTop();
		var div_top = $(".heySomething .gallery").offset().top;
		if (window_top > div_top){
			$("#gallery ul li img").addClass("opacity");
		} else {
			$("#gallery ul li img").removeClass("opacity");
		}
	}
	$(function() {$(window).scroll(galleryAnimation);});
});
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->