<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'###########################################################
' Description : hey, something project 시리즈 94 WWW
' 세상에 하나뿐인, 널 위한 마카롱
' History : 2017-11-07 유태욱 생성
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
'	currenttime = #11/10/2017 09:00:00#

dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  67458
Else
	eCode   =  81716
End If

dim userid, commentcount, i
	userid = GetEncLoginUserID()

if userid = "baboytw" or userid = "chaem35" or userid = "answjd248" then
	currenttime = #11/10/2017 09:00:00#
end if

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
.heySomething .topic {background-color:#ffd0c6;}

/* brand */
.heySomething .brand {position:relative; height:824px; margin:295px 0 0; text-align:center;}
.heySomething .brand .btnDown {margin-top:50px;}

/* item */
.heySomething .itemA {margin-top:300px;}
.heySomething .itemA .inner {display:block; margin-top:82px; text-decoration:none;}
.heySomething .itemA .figure {left:524px; top:0; width:570px; height:422px;}
.heySomething .itemA .desc {width:1010px; min-height:370px; height:370px; padding:52px 0 0 130px;}
.heySomething .itemA .option .substance {position:static; padding-top:35px;}
.heySomething .itemA .option .btnget {position:static; padding-top:25px;}

/* story */
.heySomething .story {margin-top:322px; padding-bottom:90px;}
.heySomething .rollingwrap {margin-top:0;}
.heySomething .rolling {padding-top:140px;}
.heySomething .rolling .pagination {padding-left:208px;}
.heySomething .rolling .pagination span {margin:0 22px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/81716/bg_ico_1.png);}
.heySomething .rolling .pagination span em {bottom:-720px; height:90px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/81716/txt_desc.png); cursor:default;}
.heySomething .rolling .btn-nav {top:448px;}
.heySomething .swipemask {top:140px; background-color:#000;}

/* gallery */
.gallery {padding-top:340px;}
.gallery ul {position:relative; width:743px; height:674px; margin:0 auto;}
.gallery li {overflow:hidden; position:absolute;}
.gallery li img {transform:scale(1.3); transition:all 1.8s;}
.gallery .gallery1 {left:0; top:0; width:428px; height:674px;}
.gallery .gallery2 {right:0; top:0; width:297px; height:374px;}
.gallery .gallery3 {right:0; bottom:0; width:297px; height:283px;}
.gallery li.scale img {transform:scale(1);}

/* finish */
.heySomething .finish {height:720px; margin-top:368px; background:#bceceb url(http://webimage.10x10.co.kr/eventIMG/2017/hey/81716/bg_finish.jpg) 50% 0 no-repeat;}
.heySomething .finish p {top:128px; margin-left:-357px;}

/* comment */
.heySomething .commentevet {margin-top:390px; padding-top:52px;}
.heySomething .commentevet textarea {margin-top:30px;}
.heySomething .commentevet .form {margin-top:15px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/81716/bg_ico_2_v2.png);}
.heySomething .commentlist table td strong {height:98px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/81716/bg_ico_2_v2.png); background-position:0 -25px;}
.heySomething .commentlist table td .ico2 {background-position:-150px -25px;}
.heySomething .commentlist table td .ico3 {background-position:-300px -25px;}
</style>
<script type="text/javascript">
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
		<% If not( left(currenttime,10) >= "2017-11-08" and left(currenttime,10) < "2017-11-16" ) Then %>
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
			top.location.href="/login/loginpage.asp?vType=G";
			return false;
//			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
//			winLogin.focus();
//			return false;
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
			top.location.href="/login/loginpage.asp?vType=G";
			return false;
//			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
//			winLogin.focus();
//			return false;
		}
		return false;
	}
}
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
			<div class="bnr"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81716/img_item_represent.jpg" alt="에다케이커리" /></div>
		</div>

		<!-- about -->
		<div class="about">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
			<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
		</div>

		<!-- brand -->
		<div class="brand">
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81716/txt_brand.jpg" alt="에다케이커리는 천연 식용색소를 사용하여 메시지, 로고 또는 다양한 사진 이미지 등을 마카롱 위에 직접 프린팅 하여 만들어주는 목동의 한 카페 입니다. 생일, 기념일, 아기 돌잔치, 연예인 팬클럽, 기업 행사 등 여러 곳에서 사랑 받고 있는 에다케이커리 마카롱으로 마음을 전해보세요" /></p>
			<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="" /></div>
		</div>

		<%
		IF application("Svr_Info") = "Dev" THEN
			itemid = 1239226
		Else
			itemid = 1827940
		End If
		set oItem = new CatePrdCls
			oItem.GetItemData itemid
		%>
		<!-- item -->
		<div class="item itemA">
			<h3 class="ct"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81716/txt_logo.png" alt="에다케이커리와 텐바이텐" /></h3>
			<a href="/shopping/category_prd.asp?itemid=1827940&pEtr=81716" class="inner">
				<div class="desc">
					<div class="option">
						<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81716/txt_name.png" alt="에다케이커리 주문제작 마카롱" /></p>
						<% If oItem.FResultCount > 0 Then %>
							<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
							<div class="price">
								<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
								<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> <span>(<%= Format00(1, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%)</span></strong>
							</div>
							<% Else %>
							<div class="price priceEnd" >
								<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
							</div>
							<% End If %>
						<% End If %>
						<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81716/txt_substance.png" alt="전하고 싶은 메시지 또는, 친구, 연인, 가족부터 좋아하는 연예인과 캐릭터 사진까지 자유롭게 새길 수 있는 특별한 마카롱" /></p>
						<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러가기" /></div>
					</div>
					<div class="figure">
						<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81716/img_item_1.jpg" alt="" />
						<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81716/img_item_2.jpg" alt="" />
					</div>
				</div>
			</a>
		</div>
		<%
		set oItem = nothing
		%>

		<!-- gallery -->
		<div id="gallery" class="gallery">
			<ul>
				<li class="gallery1"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81716/bg_cut_1.jpg" alt="" /></li>
				<li class="gallery2"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81716/bg_cut_2.jpg" alt="" /></li>
				<li class="gallery3"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81716/bg_cut_3.jpg" alt="" /></li>
			</ul>
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
								<div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1827940&pEtr=81716"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81716/img_slide_story_01.jpg" alt="#사랑해 언제나 내 편이 되어주는 너에게 하고 싶은 말" /></a></div>
								<div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1827940&pEtr=81716"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81716/img_slide_story_02.jpg" alt="#축하해 오늘 가장 축하 받아야 할 너에게 하고 싶은 말" /></a></div>
								<div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1827940&pEtr=81716"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81716/img_slide_story_03.jpg" alt="#응원해 공부하느라 지쳐있을 너에게 하고 싶은 말" /></a></div>
							</div>
						</div>
					</div>
					<div class="pagination"></div>
				</div>
			</div>
		</div>

		<!-- finish -->
		<div class="finish">
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81716/txt_finish.png" alt="달콤한 마카롱 위에 사랑의 메시지, 로고 또는 받는 사람의 사진이나 캐릭터 등이 그려진 나만의 마카롱을 제작하여 특별한 날을 더욱 특별하게 기념해보세요." /></p>
		</div>

		<!-- comment -->
		<div class="commentevet">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81716/tit_comment.jpg" alt="Hey, something project, 마카롱으로 전하고 싶은 나만의 메시지" /></h3>
			<p class="hidden">에다케이커리 마카롱에 어떤 메시지를 적어 누구에게 선물하고 싶으신가요? 정성껏 코멘트를 남겨주신 5분을 추첨하여 에다케이커리 머랭쿠키를 선물로 드립니다. 기간 : 2017.11.08(수) ~ 11.15(수) / 발표 : 11.16(목)</p>
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
							<li class="ico1"><button type="button" value="1">#사랑해</button></li>
							<li class="ico2"><button type="button" value="2">#축하해</button></li>
							<li class="ico3"><button type="button" value="3">#응원해</button></li>
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
												#사랑해
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="2" then %>
												#축하해
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="3" then %>
												#응원해
											<% else %>
												#사랑해
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
	/* slide */
	$(".item .figure").slidesjs({
		width:"570",
		height:"422",
		pagination:false,
		navigation:false,
		play:{interval:3500, effect:"fade", auto:true},
		effect:{fade: {speed:900, crossfade:true}}
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
			$("#gallery ul li").addClass("scale");
		} else {
			$("#gallery ul li").removeClass("scale");
		}
	}
	$(function() {$(window).scroll(galleryAnimation);});
});
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->