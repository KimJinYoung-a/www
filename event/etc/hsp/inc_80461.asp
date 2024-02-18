<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'###########################################################
' Description : hey, something project 시리즈 87 KooRoom
' History : 2017-09-11 정태훈 생성
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
	eCode   =  66424
Else
	eCode   =  80461
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
.heySomething .topic {text-align:center; background-color:#b9dadf; z-index:1;}

/* brand */
.heySomething .brand {position:relative; height:857px; margin:305px 0 370px; text-align:center;}
.heySomething .brand .btnDown {margin-top:67px;}

/* item */
.heySomething .item {width:1140px;  margin:0 auto;}
.heySomething .item h3 {padding-bottom:118px;}
.heySomething .item .desc {position:relative;}
.heySomething .item .option {height:455px; padding-left:155px;}
.heySomething .item .option .substance {position:static; margin-top:40px;}
.heySomething .item .option .btnget {position:static; margin-top:35px;}
.heySomething .item .slide {position:absolute; right:65px; top:-22px; overflow:visible !important; width:526px; height:477px;}

/* story */
.heySomething .wide {position:relative; height:672px; margin:560px 0 433px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/80461/img_wide.jpg) 50% 0 no-repeat;}
.heySomething .wide a {display:block; position:absolute; left:50%; top:0; width:1140px; height:650px; margin-left:-570px; text-indent:-999em;}

.feature {position:relative; width:824px; height:711px; margin:0 auto 500px;}
.feature div {position:absolute;}
.feature div img {opacity:0;}
.feature .pic1 {left:0; top:0; background:#ece4e2;}
.feature .pic2 {right:0; top:0; background:#927055;}
.feature .pic3 {left:0; bottom:0; background:#f7edea;}
.feature .pic4 {right:0; bottom:0; background:#d7eced;}

.together {text-align:center;}

.heySomething .story {margin-bottom:340px; padding-bottom:120px;}
.heySomething .rollingwrap {margin-top:0;}
.heySomething .rolling {padding-top:184px;}
.heySomething .rolling .pagination {top:0; padding-left:140px;}
.heySomething .rolling .pagination span {height:150px; margin:0 38px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/80461/bg_ico_1.png);}
.heySomething .rolling .pagination span em {bottom:-795px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/80461/txt_desc.png); cursor:default;}
.heySomething .rolling .btn-nav {top:457px;}
.heySomething .swipemask {top:184px; background-color:#fff;}

/* comment */
.heySomething .commentevet {margin-top:205px;}
.heySomething .commentevet textarea {margin-top:35px;}
.heySomething .commentevet .form {margin-top:25px;}
.heySomething .commentevet .form .choice li {margin-right:10px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/80461/bg_ico_1.png);}
.heySomething .commentlist table td strong {height:132px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/80461/bg_ico_2.png); background-position:0 0;}
.heySomething .commentlist table td .ico2 {background-position:-150px 0;}
.heySomething .commentlist table td .ico3 {background-position:-300px 0;}
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
		<% If not( left(currenttime,10)>="2017-09-12" and left(currenttime,10)<"2017-09-28" ) Then %>
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
					<div class="bnr"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80461/img_item_represent.jpg" alt="쿠룸 쿡북" /></div>
				</div>

				<!-- about -->
				<div class="about">
					<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
					<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
				</div>

				<!-- brand -->
				<div class="brand">
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80461/txt_brand.jpg" alt="KOOROOM은 어릴 적부터 상상력 가득하고 감성이 풍부한 디자인을 보고 자란다면, 그 기억들이 아이들의 감성을 더욱 풍요롭게 하며 창의적이고 긍정적인 삶을 만들어 줄 수 있다는 믿음으로 시작됐습니다. 몇 번 사용하고 버려지는 물건이 아닌, 오랫동안 간직하고 싶고 그 무엇보다 우리 아이에게 선물하고 싶은 것들로 가득 채워나갈 예정입니다" /></p>
					<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="" /></div>
				</div>
				<%
					IF application("Svr_Info") = "Dev" THEN
						itemid = 1239226
					Else
						itemid = 1787743
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
				%>
				<!-- item -->
				<div class="item">
					<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80461/tit_buy.jpg" alt="COOKBOOK X 10x10" /></h3>
					<div class="desc">
						<div class="option">
							<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80461/txt_name.png" alt="ONLY 10X10 쿡북+키트" /></p>
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
							<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80461/txt_substance.png" alt="음식 재료에 유쾌한 상상력을 발휘하여 자신만의 작품으로 표현할 수 있는 쿠룸 쿡북 엄마와 아이의 밥먹는 시간이 더욱 친근하고 즐거워지실 거에요." /></p>
							<div class="btnget"><a href="/shopping/category_prd.asp?itemid=1787743&amp;pEtr=80461"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러가기" /></a></div>
						</div>
						<div class="slide">
							<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80461/img_item_1.jpg" alt="" />
							<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80461/img_item_2.jpg" alt="" />
							<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80461/img_item_3.jpg" alt="" />
							<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80461/img_item_4.jpg" alt="" />
							<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80461/img_item_5.jpg" alt="" />
						</div>
					</div>
				</div>
				<!--// item -->
				<%	set oItem = nothing %>
				<div class="wide">
					<a href="/shopping/category_prd.asp?itemid=1787743&amp;pEtr=80461">쿠룸 쿡북 구매하러가기</a>
				</div>

				<div class="feature">
					<div class="pic1"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80461/img_story_1.jpg" alt="" /></div>
					<div class="pic2"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80461/img_story_2.jpg" alt="" /></div>
					<div class="pic3"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80461/img_story_3.jpg" alt="" /></div>
					<div class="pic4"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80461/img_story_4.jpg" alt="" /></div>
				</div>

				<div class="together">
					<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80461/img_material.jpg" alt="" /></div>
					<div style="padding:50px 0 100px;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80461/img_together.gif" alt="" /></div>
					<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80461/txt_together.png" alt="우리 엄마, 아빠 얼굴도 만들어 보고 내얼굴도 만들어 보아요! 엇 근데 자세히 보니 눈이 계란후라이였네요! 코는 옥수수, 입은 수박이에요! 오늘 식탁에 등장하는 반찬은 어떤 모양일까요? 쿠룸의 쿡북으로 아이와 둘만의 요리를 만들어보세요!" /></div>
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
										<div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1787743&amp;pEtr=80461"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80461/img_slide_1.jpg" alt="" /></a></div>
										<div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1787743&amp;pEtr=80461"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80461/img_slide_2.jpg" alt="" /></a></div>
										<div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1787743&amp;pEtr=80461"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80461/img_slide_3.jpg" alt="" /></a></div>
									</div>
								</div>
							</div>
							<div class="pagination"></div>
						</div>
					</div>
				</div>

				<!-- comment -->
				<div class="commentevet">
					<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80461/tit_comment.png" alt="Hey, something project, 쿡북으로 할 수 있는 3가지 레시피" /></h3>
					<p class="hidden">쿡북으로 하고 싶은 나만의 레시피는 무엇인가요? 정성껏 코멘트를 남겨주신 5분을 추첨하여 쿡북+키트를 선물로 드립니다.</p>
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
									<li class="ico1"><button type="button" value="1">#그리기</button></li>
									<li class="ico2"><button type="button" value="2">#붙이기</button></li>
									<li class="ico3"><button type="button" value="3">#오리기</button></li>
								</ul>
								<textarea title="코멘트 작성" cols="60" rows="5" name="txtcomm1" id="txtcomm1" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();" <%IF NOT(IsUserLoginOK) THEN%>readonly<%END IF%>><%IF NOT IsUserLoginOK THEN%>로그인 후 글을 남길 수 있습니다.<% else %><%END IF%></textarea>
								<div class="note01 overHidden">
									<ul class="list01 ftLt">
										<li>입력하신 블로그 주소는 개인정보 유출로 인한 피해를 막고자 비공개로 텐바이텐에 접수됩니다.</li>
										<li>통신예절에 어긋나는 글이나 상업적인 글, 타 사이트에 관련된 글 또는 도용한 글은 관리자에 의해 사전 통보 없이 삭제될 수 있으며,<br>이벤트 참여에 제한을 받을 수 있습니다.</li>
									</ul>
									<input type="submit" class="ftRt btn btnW130 btnS1 btnRed" value="코멘트 남기기" onclick="jsSubmitComment(document.frmcom); return false;">
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
									#그리기
									<% elseif split(arrCList(1,intCLoop),"!@#")(0)="2" then %>
									#붙이기
									<% elseif split(arrCList(1,intCLoop),"!@#")(0)="3" then %>
									#오리기
									<% else %>
									#그리기
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
										<% End If %>
										<% If arrCList(8,i) <> "W" Then %>
										<br /><img src="http://fiximage.10x10.co.kr/web2013/event/ico_mobile.png" alt="모바일에서 작성됨">
										<% End If %>
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
	$(".item .slide").slidesjs({
		width:"526",
		height:"477",
		pagination:false,
		navigation:false,
		play:{interval:1900, effect:"fade", auto:true},
		effect:{fade: {speed:800, crossfade:true}}
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

	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 4450) {
			$(".feature .pic1 img").delay(100).animate({"opacity":"1"},1200);
			$(".feature .pic2 img").delay(300).animate({"opacity":"1"},1200);
			$(".feature .pic3 img").delay(500).animate({"opacity":"1"},1200);
			$(".feature .pic4 img").delay(700).animate({"opacity":"1"},1200);
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
});
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->