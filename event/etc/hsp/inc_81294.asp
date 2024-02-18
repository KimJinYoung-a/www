<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'###########################################################
' Description : hey, something project 시리즈 92
' 너와 나, 우리 둘의 테이블에
' History : 2017-10-16 정태훈 생성
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
	eCode   =  67445
Else
	eCode   =  81294
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
.heySomething .topic {background-color:#e8e8e9;}

/* brand */
.heySomething .brand {position:relative; height:600px; margin:355px 0 0; text-align:center;}
.heySomething .brand .btnDown {margin-top:53px;}

/* item */
.heySomething .item {margin:400px auto 0;}
.heySomething .itemA .desc {width:1140px; min-height:410px; height:410px; margin:108px auto 0; padding:109px 0 0 0; border-top:1px dashed #ccc;}
.heySomething .itemA .desc1 {margin-top:99px; padding-top:0; border-top:0;}
.heySomething .itemA .inner {overflow:hidden; display:block; width:980px; margin:0 auto;}
.heySomething .itemA .figure {position:static; float:right;}
.heySomething .itemA .desc .option {float:left; width:370px; height:410px;}
.heySomething .itemA .desc2 .figure {float:left;}
.heySomething .itemA .desc2 .option {float:right; width:295px; padding-left:75px;}
.heySomething .itemA .desc2 .btnget {left:75px;}
.heySomething .item .option .price {margin-top:46px;}

/* story */
.heySomething .story {margin:486px 0 0;}
.heySomething .rollingwrap {margin-top:0;}
.heySomething .rolling {padding-top:79px;}
.heySomething .rolling .pagination {padding-left:105px;}
.heySomething .rolling .pagination span {width:180px; height:40px; margin:0 39px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/81294/btn_pagination_story.gif);}
.heySomething .rolling .pagination span.swiper-active-switch {background-position:0 -40px;}
.heySomething .rolling .pagination span:first-child + span {background-position:-180px 0;}
.heySomething .rolling .pagination span:first-child + span.swiper-active-switch {background-position:-180px -40px;}
.heySomething .rolling .pagination span:first-child + span + span {background-position:100% 0;}
.heySomething .rolling .pagination span:first-child + span + span.swiper-active-switch {background-position:100% -40px;}
.heySomething .rolling .pagination span em {bottom:-789px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/81294/txt_story_desc.gif); cursor:default;}
.heySomething .rolling .btn-nav {top:445px;}
.heySomething .swipemask {top:79px;}

/* gallery */
.gallery {padding-top:360px;}
.gallery ul {position:relative; width:880px; margin:0 auto;}
.gallery li {background-color:#dee4e7;}
.gallery li img {opacity:0;}
.gallery .gallery1 {width:480px; height:372px;}
.gallery .gallery2 {width:480px; height:296px; margin-top:4px; background-color:#dbcdbf;}
.gallery .gallery3 {position:absolute; top:0; right:0; width:396px; height:672px; background-color:#d9e0e4;}
.gallery .gallery2 img {animation-delay:0.6s;}
.gallery .gallery3 img {animation-delay:0.3s;}
.opacity {animation:opacity 2.2s cubic-bezier(0.19, 1, 0.22, 1) forwards;}
@keyframes opacity {
	0% {opacity:0;}
	100% {opacity:1;}
}

/* finish */
.heySomething .finish {height:670px; margin-top:400px; background-color:#f7f8f9;}
.heySomething .finish p {top:0; margin-left:-951px;}

/* comment */
.heySomething .commentevet {padding-top:52px;}
.heySomething .commentevet textarea {margin-top:56px;}
.heySomething .commentevet .form {margin-top:32px;}
.heySomething .commentevet .form .choice li {width:98px; height:98px; margin-right:25px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/81294/bg_commnet_ico.png);}
.heySomething .commentevet .form .choice li.ico2 button {background-position:-98px 0;}
.heySomething .commentevet .form .choice li.ico2 button.on {background-position:-98px 100%;}
.heySomething .commentevet .form .choice li.ico3 button {background-position:100% 0;}
.heySomething .commentevet .form .choice li.ico3 button.on {background-position:100% 100%;}
.heySomething .commentlist table td strong {width:98px; height:98px; margin-left:14px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/81294/bg_commnet_ico.png); background-position:0 0;}
.heySomething .commentlist table td .ico2 {background-position:-98px 0;}
.heySomething .commentlist table td .ico3 {background-position:100% 0;}
</style>
<script type="text/javascript">
<!--
function jsGoComPage(iP){
	document.frmcom.iCC.value = iP;
	document.frmcom.iCTot.value = "<%=iCTotCnt%>";
	document.frmcom.submit();
}

function jsSubmitComment(frm){
	<% If IsUserLoginOK() Then %>
		<% If not( left(currenttime,10)>="2017-10-16" and left(currenttime,10)<"2018-01-01" ) Then %>
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
					<div class="bnr"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81294/img_item_represent.jpg" alt="MOOOI" /></div>
				</div>

				<!-- about -->
				<div class="about">
					<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
					<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
				</div>

				<!-- brand -->
				<div class="brand">
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81294/txt_brand.jpg" alt="Sharing Joyful Changes 따뜻한 일상의 이야기 부드러운 햇살이 창가로 들어오는 하루, 함께 하는 이와 편안한 시간을 보내며 특별한 일상 속 이야기를 만들어보세요" /></p>
					<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="" /></div>
				</div>
				<%
					IF application("Svr_Info") = "Dev" THEN
						itemid = 1239226
					Else
						itemid = 1808742
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
				%>
				<!-- item -->
				<div class="item itemA">
					<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81294/tit_bowlbowl.gif" alt="보울보울과 텐바이텐" /></h3>
					<div class="desc desc1">
						<a href="/shopping/category_prd.asp?itemid=1808742&pEtr=81294" class="inner">
							<div class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81294/img_item_01.jpg" alt="" /></div>
							<div class="option">
								<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81294/txt_item_01.gif" alt="ONLY 텐바이텐 볼볼 빈티지 2인 홈세트 뉴트럴 컬러의 로맨틱한 파우더핑크와 톤 다운된 애쉬그레이 컬러가 주방 분위기를 빈티지하게 만들어 줍니다." /></p>
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
					</div>
					<%	set oItem = nothing %>
					<%
						IF application("Svr_Info") = "Dev" THEN
							itemid = 1239226
						Else
							itemid = 1808743
						End If
						set oItem = new CatePrdCls
							oItem.GetItemData itemid
					%>
					<div class="desc desc2">
						<a href="/shopping/category_prd.asp?itemid=1808743&pEtr=81294" class="inner">
							<div class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81294/img_item_02.jpg" alt="" /></div>
							<div class="option">
								<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81294/txt_item_02.gif" alt="볼볼 파우더핑크 2인 홈세트 뉴트럴 컬러의 로맨틱한 파우더핑크컬러로 화사하고 따뜻한 분위기를 연출해요. Soft Matt의 질감으로 화사함과 함께 빈티지한 느낌을 더해줍니다." /></p>
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
					</div>
					<%	set oItem = nothing %>
					<%
						IF application("Svr_Info") = "Dev" THEN
							itemid = 1239226
						Else
							itemid = 1808744
						End If
						set oItem = new CatePrdCls
							oItem.GetItemData itemid
					%>
					<div class="desc desc3">
						<a href="/shopping/category_prd.asp?itemid=1808744&pEtr=81294" class="inner">
							<div class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81294/img_item_03.jpg" alt="" /></div>
							<div class="option">
								<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81294/txt_item_03.gif" alt="볼볼 화이트 블라썸 2인 홈세트 순백의 스노우화이트컬러와 로맨틱한 파우더핑크 컬러로 주방 분위기를 화사하고 따뜻하게 만들어 줍니다." /></p>
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
					</div>
				</div>
				<%	set oItem = nothing %>
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
										<div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1784821&pEtr=81294"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81294/img_slide_story_01.jpg" alt="#PINK &amp; GRAY 로맨틱한 핑크와 모던 빈티지한 그레이의 조합으로 감성적이면서 차분한 분위기의 테이블 " /></a></div>
										<div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1784821&pEtr=81294"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81294/img_slide_story_02.jpg" alt="#POWDER PINK Soft Matt 질감에 러블리한 핑크 컬러가 더해져  심플하면서도 품격 있게, 핑크빛으로 물든 테이블" /></a></div>
										<div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1784821&pEtr=81294"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81294/img_slide_story_03.jpg" alt="#WHITE &amp; PINK 순백의 화이트컬러와 로맨틱한 핑크컬러의 조합으로  화사하고 따뜻한 분위기의 테이블" /></a></div>
									</div>
								</div>
							</div>
							<div class="pagination"></div>
						</div>
					</div>
				</div>

				<!-- gallery -->
				<div id="gallery" class="gallery">
					<ul>
						<li class="gallery1"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81294/img_gallery_01.jpg" alt="" /></li>
						<li class="gallery2"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81294/img_gallery_02.jpg" alt="" /></li>
						<li class="gallery3"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81294/img_gallery_03.jpg" alt="" /></li>
					</ul>
				</div>

				<!-- finish -->
				<div class="finish">
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81294/txt_finish.jpg" alt="무광 특유의 모던하고 빈티지한 느낌의 볼볼시리즈 BOWL BOWL" /></p>
				</div>

				<!-- comment -->
				<div class="commentevet">
					<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81294/tit_comment.gif" alt="Hey, something project, 당신과 어울리는 테이블" /></h3>
					<p class="hidden">가장 마음에 드는 컬러 구성의 상품과, 이유를 남겨주세요! 정성껏 코멘트를 남겨주신 4분을 추첨하여 골라주신 상품 중 1개 구성을 선물로 드립니다. 기간 2017.10.25 ~ 10.31, 발표 11.01</p>
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
									<li class="ico1"><button type="button" value="1">PINK &amp; GRAY</button></li>
									<li class="ico2"><button type="button" value="2">POWDER PINK</button></li>
									<li class="ico3"><button type="button" value="3">WHITE &amp; PINK</button></li>
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
									#PINK &amp; GRAY
									<% elseif split(arrCList(1,intCLoop),"!@#")(0)="2" then %>
									#POWDER PINK
									<% elseif split(arrCList(1,intCLoop),"!@#")(0)="3" then %>
									#WHITE &amp; PINK
									<% else %>
									#PINK &amp; GRAY
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