<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : [기프트카드 리뉴얼 기념] Gift Card 
' History : 2016-03-03 유태욱 생성
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
<%
dim currenttime
	currenttime =  now()
'																		currenttime = #03/07/2016 09:00:00#

dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  66055
Else
	eCode   =  69435
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
	iCPageSize = 5
else
	iCPageSize = 5
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
%>
<style type="text/css">
img {vertical-align:top;}

.evt69435 {background-color:#fff;}
.evt69435 button {background-color:transparent;}

.article {padding-bottom:30px; background:#f4d186 url(http://webimage.10x10.co.kr/eventIMG/2016/69435/bg_pattern.png) repeat 50% 0;}

.topic {position:relative; height:628px;}
.topic h2 .letter1 {position:absolute; top:126px; left:50%; z-index:5; margin-left:-325px;}
.topic h2 .letter2 {overflow:hidden; position:absolute; top:129px; left:50%; width:216px; height:138px; margin-left:-265px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/69435/tit_gift_card.png) no-repeat 0 0; text-indent:-9999em;}
.topic h2 .letter3 {overflow:hidden; position:absolute; top:129px; left:50%; width:267px; height:109px; margin-left:-30px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/69435/tit_gift_card.png) no-repeat 100% 0; text-indent:-9999em;}

@keyframes rotateIn {
	0% {transform-origin:center center; transform:rotateX(160deg); opacity:0;}
	100% {transform-origin:center center; transform:rotateX(0); opacity:1;}
}
.rotateIn {animation-name:rotateIn; animation-duration:3s; animation-fill-mode:both; animation-iteration-count:1;}
.rotateIn1 {animation-delay:0.5s;}
.rotateIn2 {animation-delay:1.5s;}

.topic .subcopy {position:absolute; top:286px; left:50%; width:343px; height:15px; margin-left:-171px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/69435/tit_gift_card.png) no-repeat -99px 100%; text-indent:-9999em;}
.topic .desc {position:absolute; top:366px; left:50%; width:960px; margin-left:-480px;}
.topic .desc ul {width:100%;}
.topic .desc ul li {position:relative; float:left; width:280px; height:182px; padding:0 9px 0 9px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/69435/bg_card_shadow.png) no-repeat 0 0;}
.topic .desc ul li .hover {display:none; position:absolute; left:50%; top:0; margin-left:-140px; z-index:100;}
/*.topic .desc ul li:nth-of-type(1) {animation-delay:2.2s;}
.topic .desc ul li:nth-of-type(2) {animation-delay:2.4s;}
.topic .desc ul li:nth-of-type(3) {animation-delay:2.6s;}

@keyframes fadeInSlideUp {
	0% {transform: translateY(0);}
	50% {transform: translateY(50px);}
	100% {transform: translateY(0);}
}
.fadeInSlideUp{animation:fadeInSlideUp 1s cubic-bezier(0.2, 0.3, 0.25, 0.9) forwards;}*/

.rolling {width:1140px; height:775px; margin:0 auto; background:url(http://webimage.10x10.co.kr/eventIMG/2016/69435/bg_imac.png) no-repeat 50% 0;}
.rolling .swiper {overflow:hidden; position:relative; width:1140px; margin:0 auto; padding-top:36px;}
.rolling .swiper .swiper-container {overflow:hidden;}
.rolling .swiper .swiper-wrapper {position:relative;}
.rolling .swiper .swiper-slide {overflow:hidden; float:left; position:relative; height:600px; padding-left:74px; text-align:left;}
.rolling .swiper .pagination {position:absolute; top:254px; right:0; width:10px; text-align:center;}
.rolling .swiper .pagination span {display:block; width:10px; height:24px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/69435/btn_pagination.png) no-repeat 50% 0; cursor:pointer;}
.rolling .swiper .pagination .swiper-active-switch {background-position:50% 100%;}

.btnget {margin-top:54px;}

.presentUse {margin-top:63px; padding:64px 0 78px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/69435/bg_mask.png) repeat 0 0;}

/* comment */
.commentevet {width:1140px; margin:0 auto; text-align:left;}
.commentevet .form {width:1050px; margin:0 auto;}
.commentevet textarea {width:1028px; height:78px; margin-top:10px; padding:10px; border:1px solid #ccc; background-color:#f5f5f5;}
.commentevet .note01 {margin-top:6px;}
.commentevet .note01 ul li {color:#888;}

.commentlist {width:1050px; margin:0 auto;}
.commentlist .total {margin-top:50px; color:#999; font-family:'Verdana', 'Dotum'; font-size:11px; font-weight:bold; text-align:right;}
.commentlist table {margin-top:10px; border-top:1px solid #ddd; text-align:center;}
.commentlist table thead {display:none;}
.commentlist table th {display:block; visibility:hidden; width:0; height:0;}
.commentlist table th, .commentlist table td {border-bottom:1px solid #ddd; color:#777; font-size:11px; line-height:1.5em;}
.commentlist table td {padding:30px 0;}
.commentlist table td.lt {padding-right:10px;word-break:break-all;}
.commentlist table td em {font-weight:bold;}
.commentlist table td span {display:block; width:111px; height:111px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/69435/bg_card_img_v2.png); background-position:no-repeat;}
.commentlist table td .ico1 {background-position:0 0;}
.commentlist table td .ico2 {background-position:0 -146px;}
.commentlist table td .ico3 {background-position:0 -292px;}
.commentlist table td .ico4 {background-position:0 -438px;}
.commentlist table td .ico5 {background-position:0 -584px;}
.commentlist table td .ico6 {background-position:0 -730px;}
.commentlist table td .ico7 {background-position:0 100%;}
.commentlist table td .btndel {margin-top:3px; background-color:transparent;}

/* paging */
.pageWrapV15 {margin-top:20px;}
</style>
<script type="text/javascript">
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
			alert("한 ID당 한번만 참여할 수 있습니다.");
			return false;
		<% else %>

			if (frm.txtcomm.value == '' || GetByteLength(frm.txtcomm.value) > 600 || frm.txtcomm.value == '300자 이내로 적어주세요.'){
				alert("띄어쓰기 포함\n최대 한글 300자 이내로 적어주세요.");
				frm.txtcomm.focus();
				return false;
			}

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
	if (frmcom.txtcomm.value == '300자 이내로 적어주세요.'){
		frmcom.txtcomm.value = '';
	}

}

</script>
<div class="evt69435">
	<div class="article">
		<div class="topic">
			<h2>
				<span class="letter1"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69435/ico_renewal.png" alt="Renewal" /></span>
				<span class="letter2">Gift</span>
				<span class="letter3">Card</span>
			</h2>
			<p class="subcopy">더 쉬워진 기프트카드로 마음을 담아 선물하세요!</p>

			<div class="desc">
				<a href="https://www.10x10.co.kr/giftcard/">
					<ul>
						<li class="card1">
							<div class="default"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69435/txt_card_01.png" alt="카드 선택부터 결제까지 한 번에 한 페이지에서 원하는 카드를 선택하고, 결제까지 한 번에 할 수 있어 간편합니다." /></div>
							<div class="hover"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69435/img_card_01.png" alt="" /></div>
						</li>
						<li class="card2" style="margin-top:30px;">
							<div class="default"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69435/img_card_02.png" alt="" /></div>
							<div class="hover"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69435/txt_card_02.png" alt="내가 직접 만드는 기프트 카드 내가 원하는 이미지와 메시지로 세상에 단 하나밖에 없는 특별한 카드를 선물하세요" /></div>
						</li>
						<li class="card3">
							<div class="default"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69435/txt_card_03.png" alt="언제 어디서나 쓸 수 있다 텐바이텐 온라인 사이트 및 오프라인 매장에서도 사용 가능합니다." /></div>
							<div class="hover"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69435/img_card_03.png" alt="" /></div>
						</li>
					</ul>
				</a>
			</div>
		</div>

		<div class="rolling">
			<div class="swiper">
				<div class="swiper-container">
					<div class="swiper-wrapper">
						<div class="swiper-slide">
							<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/69435/img_slide_01.png" alt="스텝 1 기프트 카드 메뉴 클릭" /></p>
						</div>
						<div class="swiper-slide">
							<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/69435/img_slide_02.png" alt="스텝 2 카드이미지 또는 사진 등록" /></p>
						</div>
						<div class="swiper-slide">
							<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/69435/img_slide_03.png" alt="스텝 3 메시지 입력" /></p>
						</div>
						<div class="swiper-slide">
							<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/69435/img_slide_04.png" alt="스텝 4 금액 선택 후 연락처 입력" /></p>
						</div>
						<div class="swiper-slide">
							<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/69435/img_slide_05.png" alt="스텝 5 결제하고 선물하기" /></p>
						</div>
					</div>
					<div class="pagination"></div>
				</div>
			</div>
		</div>

		<div class="btnget"><a href="https://www.10x10.co.kr/giftcard/"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69435/btn_get.png" alt="기프트카드 구매하러 가기" /></a></div>

		<div class="presentUse">
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/69435/txt_giftcard_present_use.png" alt="급히 선물을 준비해야 할 때, 간소한 선물을 해야 할 때, 특별한 선물을 하고 싶을 때, 무엇을 살지 고민 될 때 기프트 카드를 선물하세요! 기프트 카드 선물을 받으셨다면 기프트 카드 메시지가 수신되며 로그인 후 카드 등록 후 온라인 결제 시 사용 하실 수 있으며, 오프라인에서는 인증번호 제시 후 사용하실 수 있습니다." /></p>
		</div>
	</div>

	<div class="commentevet" id="commentlist">
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/69435/txt_comment_v1.jpg" alt="이 카드로 선물하고 싶어요! 기프트카드로 어떤 분에게 선물하고 싶은지에 대해 정성껏 코멘트를 남겨주신 4분을 선정하여, 텐바이텐 기프트카드 50,000원 권을 선물로 드립니다. 기간은 2016년 3월 7일부터 3월 13일 까지며, 당첨자 발표는 2016년 3월 15일 화요일입니다." /></p>

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
			<% If InStr(Request.ServerVariables("QUERY_STRING"), "&ecc=1") > 0 Then %>
			<% Else %>
				<input type="hidden" name="hookcode" value="&ecc=1">
			<% End If %>
				<fieldset>
				<legend>어떤 분께 기프트 카드를 선물하고 싶은지 코멘트 쓰기</legend>
					<textarea cols="60" rows="5" name="txtcomm" id="txtcomm" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();"><% IF NOT IsUserLoginOK THEN %>로그인 후 글을 남길 수 있습니다.<% else %>300자 이내로 적어주세요.<%END IF%></textarea>
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

		<% IF isArray(arrCList) THEN %>
			<div class="commentlist">
				<p class="total">total <%= iCTotCnt %></p>
				<table>
					<caption>기프트카드 코멘트 목록</caption>
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
								<td><span></span></td>
								<td class="lt"><%=ReplaceBracket(db2html(arrCList(1,intCLoop)))%></td>
								<td><%= FormatDate(arrCList(4,intCLoop),"0000.00.00") %></td>
								<td>
									<em><%=printUserId(arrCList(2,intCLoop),2,"*")%></em>
									<% if ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %>
										<button type="button" onclick="jsDelComment('<% = arrCList(0,intCLoop) %>'); return false;" class="btndel"><img src="http://fiximage.10x10.co.kr/web2013/event/btn_cmt_close.gif" alt="코멘트 삭제"></button>
									<% end if %>
									<% if arrCList(8,intCLoop) <> "W" then %>
										<br /><img src="http://fiximage.10x10.co.kr/web2013/event/ico_mobile.png" alt="모바일에서 작성됨">
									<% end if %>
								</td>
							</tr>
						<% next %>
					</tbody>
				</table>
	
				<div class="pageWrapV15">
					<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
			</div>
		<% end if %>
	</div>
</div>
<script type="text/javascript">
	var mySwiper = new Swiper('.swiper-container',{
		mode:'vertical',
		loop:true,
		resizeReInit:true,
		calculateHeight:true,
		pagination:'.pagination',
		paginationClickable:true,
		speed:1200,
		autoplay:3500,
		autoplayDisableOnInteraction:false,
		simulateTouch:false
	});

	$('.swiper .btn-prev').on('click', function(e){
		e.preventDefault()
		mySwiper.swipePrev()
	});

	$('.swiper .btn-next').on('click', function(e){
		e.preventDefault()
		mySwiper.swipeNext()
	});


var random = [ 'ico1', 'ico2', 'ico3', 'ico4', 'ico5', 'ico6', 'ico7'];
	var sort = random.sort(function(){
		return Math.random() - Math.random();
	});

	$('.commentlist table td span').each( function(index,item){
		$(this).addClass(sort[index]);
	});
	$(function(){
		$('.desc ul li').mouseover(function(){
			$(this).children('.hover').fadeIn();
			$(this).children('.default').fadeOut();
		});
		$('.desc ul li').mouseleave(function(){
			$(this).children('.hover').fadeOut();
			$(this).children('.default').fadeIn();
		});
	});
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->