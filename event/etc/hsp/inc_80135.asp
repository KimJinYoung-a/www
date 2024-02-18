<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈 84 칼로리컷
' History : 2017-08-21 정태훈 생성
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
	eCode   =  66420
Else
	eCode   =  80135
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
<script type="text/javascript" src="/lib/js/jquery.flowslider.js"></script>
<style type="text/css">
/* title */
.heySomething .topic {text-align:center; background-color:#f6f5f6; z-index:1;}

/* brand */
.heySomething .brand {position:relative; height:605px; margin:335px 0 400px; text-align:center;}
.heySomething .brand .btnDown {margin-top:78px;}

/* item */
.heySomething .item {width:1140px; margin:0 auto;}
.heySomething .item .desc {position:relative; width:980px; margin:44px auto 0;}
.heySomething .item .option {height:auto; padding:82px 0 330px;}
.heySomething .item .option .substance {position:static; margin-top:40px;}
.heySomething .item .option .btnget {position:static; margin-top:35px;}
.heySomething .item .slide {position:absolute; right:60px; top:0; overflow:visible !important; width:477px; height:477px;}
.heySomething .item .slide .slidesjs-navigation {display:block; overflow:hidden; position:absolute; top:50%; width:40px; height:40px; margin-top:-20px; text-indent:-999em; z-index:10; background:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/80135/btn_nav.png) no-repeat 0 0;}
.heySomething .item .slide .slidesjs-previous {left:-85px; }
.heySomething .item .slide .slidesjs-next {right:-85px; background-position:100% 0;}
.heySomething .item .slide .slidesjs-pagination {position:absolute; left:0; bottom:-45px; width:100%; text-align:center;}
.heySomething .item .slide .slidesjs-pagination li {display:inline-block; padding:0 5px;}
.heySomething .item .slide .slidesjs-pagination li a {display:inline-block; width:12px; height:12px; background-color:#d8d8d8; border-radius:50%; text-indent:-999em;}
.heySomething .item .slide .slidesjs-pagination li a.active {background-color:#666;}

/* story */
.heySomething .composition {position:relative; height:650px; margin:0 0 392px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/80135/img_wide_pic.jpg) 50% 0 no-repeat;}
.heySomething .composition a {display:block; position:absolute; left:50%; top:0; width:1140px; height:650px; margin-left:-570px;}
.heySomething .monthlyBox {text-align:center;}
.heySomething .monthlyBox #slide {padding:80px 0 75px; text-align:left;}
.heySomething .monthlyBox #slide .slide-img {width:213px; height:318px; margin:0 30px;}

.heySomething .story {margin-bottom:340px; padding-bottom:120px;}
.heySomething .rollingwrap {margin-top:0;}
.heySomething .rolling {padding-top:174px;}
.heySomething .rolling .pagination {top:0; padding-left:160px;}
.heySomething .rolling .pagination span {height:150px; margin:0 10px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/80135/bg_ico_1.png);}
.heySomething .rolling .pagination span em {bottom:-795px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/80135/txt_desc.png); cursor:default;}
.heySomething .rolling .btn-nav {top:457px;}
.heySomething .swipemask {top:174px; background-color:#fff;}

/* comment */
.heySomething .commentevet {margin-top:380px;}
.heySomething .commentevet textarea {margin-top:20px;}
.heySomething .commentevet .form {margin-top:10px;}
.heySomething .commentevet .form .choice {margin-left:-10px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/80135/bg_ico_2.png);}
.heySomething .commentlist table td strong {height:100px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/80135/bg_ico_2.png); background-position:0 -21px;}
.heySomething .commentlist table td .ico2 {background-position:-150px -21px;}
.heySomething .commentlist table td .ico3 {background-position:-300px -21px;}
.heySomething .commentlist table td .ico4 {background-position:-450px -21px;}
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
		<% If not( left(currenttime,10)>="2017-08-21" and left(currenttime,10)<"2017-09-23" ) Then %>
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
					<div class="bnr"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80135/img_item_represent.jpg" alt="베이컨박스" /></div>
				</div>

				<!-- about -->
				<div class="about">
					<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
					<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
				</div>

				<!-- brand -->
				<div class="brand">
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80135/txt_brand.png" alt="항상 충분히 챙겨주지 못해 미안한 마음. 늘 건강하고 즐거웠으면 하는 마음을 알기에, 그 마음을 담아 베이컨박스가 다양한 제품을 제작하고 모아서 한 달에 한 번 찾아갑니다." /></p>
					<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="" /></div>
				</div>
				<%
					IF application("Svr_Info") = "Dev" THEN
						itemid = 1239226
					Else
						itemid = 1776727
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
				%>
				<!-- item -->
				<div class="item">
					<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80135/tit_bacon.png" alt="BACON" /></h3>
					<div class="desc">
						<div class="option">
							<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80135/txt_name.png" alt="9월 베이컨박스 I♥NY" /></p>
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
							<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80135/txt_substance.png" alt="베이컨박스는 매달 프리미엄 간식, 디자인 장난감, 그리고 계절에 맞는 다양한 용품과 악세서리 등 총 7만원 상당의 6여 종의 제품으로 구성됩니다." /></p>
							<div class="btnget"><a href="/shopping/category_prd.asp?itemid=1776727&amp;pEtr=80135"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러가기" /></a></div>
						</div>
						<div class="slide">
							<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80135/img_item_1.jpg" alt="" />
							<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80135/img_item_2.jpg" alt="" />
							<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80135/img_item_3.jpg" alt="" />
							<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80135/img_item_4.jpg" alt="" />
							<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80135/img_item_5.jpg" alt="" />
							<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80135/img_item_6.jpg" alt="" />
							<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80135/img_item_7.jpg" alt="" />
							<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80135/img_item_8.jpg" alt="" />
						</div>
					</div>
				</div>
				<!--// item -->
				<%	set oItem = nothing %>
				<div class="composition">
					<a href="/shopping/category_prd.asp?itemid=1776727&amp;pEtr=80135">베이컨박스 - 2017년 9월 I♥NY 구매하러가기</a>
				</div>

				<div class="monthlyBox">
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80135/txt_subject.png" alt="" /></p>
					<div id="slide" class="slider-horizontal">
						<div class="slide-img"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80135/img_box_1.jpg" alt="" /></div>
						<div class="slide-img"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80135/img_box_2.jpg" alt="" /></div>
						<div class="slide-img"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80135/img_box_3.jpg" alt="" /></div>
						<div class="slide-img"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80135/img_box_4.jpg" alt="" /></div>
						<div class="slide-img"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80135/img_box_5.jpg" alt="" /></div>
						<div class="slide-img"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80135/img_box_6.jpg" alt="" /></div>
						<div class="slide-img"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80135/img_box_7.jpg" alt="" /></div>
						<div class="slide-img"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80135/img_box_8.jpg" alt="" /></div>
					</div>
					<a href="https://www.baconbox.co/" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80135/btn_more.png" alt="베이컨박스 더 보러 가기" /></a>
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
										<div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1776727&amp;pEtr=80135"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80135/img_slide_1.jpg" alt="" /></a></div>
										<div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1776727&amp;pEtr=80135"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80135/img_slide_2.jpg" alt="" /></a></div>
										<div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1776727&amp;pEtr=80135"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80135/img_slide_3.jpg" alt="" /></a></div>
										<div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1776727&amp;pEtr=80135"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80135/img_slide_4.jpg" alt="" /></a></div>
									</div>
								</div>
							</div>
							<div class="pagination"></div>
						</div>
					</div>
				</div>

				<div class="moon ct"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80135/img_moon.gif" alt="" /></div>
 
				<!-- comment -->
				<div class="commentevet">
					<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80135/tit_comment.png" alt="Hey, something project, 9월 베이컨박스에서 가장 마음에 드는 구성품은?" /></h3>
					<p class="hidden">시원한 얼음잔에 담고 싶은 나만의 이야기는 무엇인가요? 정성껏 코멘트를 남겨주신 3분을 추첨하여 유어브리즈 얼음잔 2P(오늘 날씨 맑음+그해 여름 첫사랑)를 선물로 드립니다.</p>
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
									<li class="ico1"><button type="button" value="1">#TOY</button></li>
									<li class="ico2"><button type="button" value="2">#SCARF</button></li>
									<li class="ico3"><button type="button" value="3">#PERFUME</button></li>
									<li class="ico4"><button type="button" value="4">#FOOD</button></li>
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
										#TOY
										<% elseif split(arrCList(1,intCLoop),"!@#")(0)="2" then %>
										#SCARF
										<% elseif split(arrCList(1,intCLoop),"!@#")(0)="3" then %>
										#PERFUME
										<% elseif split(arrCList(1,intCLoop),"!@#")(0)="4" then %>
										#FOOD
										<% else %>
										#TOY
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
	$(".item .slide").slidesjs({
		width:"477",
		height:"477",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:2000, effect:"fade", auto:true},
		effect:{fade: {speed:900, crossfade:true}}
	});

	$(".monthlyBox #slide").FlowSlider({
		marginStart:0,
		marginEnd:0,
		startPosition:0.55
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
		if (scrollTop > 3550 ) {
			withAnimation();
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

	
	$(".withHitchhiker .pic p").css({"margin-left":"-507px","opacity":"0"});
	function withAnimation() {
		$(".withHitchhiker .pic p").delay(10).animate({"margin-left":"-487px", "opacity":"1"},1200);
	}
});
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->