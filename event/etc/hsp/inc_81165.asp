<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'###########################################################
' Description : hey, something project 시리즈 91
' 띵동 - 꽃다발이 도착했습니다.
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
	eCode   =  67444
Else
	eCode   =  81165
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
.heySomething .topic {text-align:center; background-color:#edecef; z-index:1;}

/* brand */
.heySomething .brand {position:relative; height:1062px; margin:355px 0 382px; text-align:center;}
.heySomething .brand p{margin-top:87px;}
.heySomething .brand .btnDown {margin-top:49px;}

/* item */
.heySomething .item {width:1140px;  margin:0 auto; padding-bottom:427px;}
.heySomething .item h3 {padding-bottom:189px;}
.heySomething .item .desc {position:relative;}
.heySomething .item .option {height:365px; padding-left:80px;}
.heySomething .item .option .price {margin-top:40px;}
.heySomething .item .option .substance {position:static; margin-top:85px;}
.heySomething .item .option .btnget {position:static; margin-top:40px;}
.heySomething .item .slide {position:absolute; right:80px; top:-120px; overflow:visible !important; width:571px; height:571px;}
.heySomething .item .slide .slidesjs-navigation {position:absolute; top:262px; width:24px; height:60px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/81165/btn_nav.png) 0 0 no-repeat; text-indent:-999em;}
.heySomething .item .slide .slidesjs-previous {left:-72px;}
.heySomething .item .slide .slidesjs-next {right:-72px; background-position:100% 0;}
.heySomething .item .slide .slidesjs-pagination {position:absolute; left:50%; bottom:-35px; width:72px; margin-left:-36px;}
.heySomething .item .slide .slidesjs-pagination li {float:left; width:12px; padding:0 6px;}
.heySomething .item .slide .slidesjs-pagination li a {display:block; height:12px; background:#d8d8d8; border-radius:50%; text-indent:-999em;}
.heySomething .item .slide .slidesjs-pagination li a.active {background:#666;}
.heySomething .item .more-item {padding-top:192px;}
.heySomething .flower {position:relative; height:538px; background:#f3f3f5 url(http://webimage.10x10.co.kr/eventIMG/2017/hey/81165/bg_flower.jpg) 50% 0 no-repeat;}
.heySomething .flower img {position:absolute; left:50%; top:175px; margin-left:-527px;}

/* flower-rolling */
.heySomething .flower-rolling {text-align:center;}
.heySomething .flower-rolling #slide {padding:437px 0 50px; text-align:left;}
.heySomething .flower-rolling #slide .slide-img {width:290px; height:290px; margin:0 30px;}

/* story */
.heySomething .story {margin:310px 0 365px; padding-bottom:120px;}
.heySomething .rollingwrap {margin-top:0;}
.heySomething .rolling .pagination {top:0; padding-left:166px;}
.heySomething .rolling .pagination span {margin:0 40px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/81165/bg_ico_1.png);}
.heySomething .rolling .pagination span em {bottom:-770px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/81165/txt_desc.png); cursor:default;}
.heySomething .rolling .btn-nav {top:445 px;}

/* comment */
.heySomething .commentevet {margin-top:360px; padding-top:52px;}
.heySomething .commentevet textarea {margin-top:49px;}
.heySomething .commentevet .form {margin-top:30px;}
.heySomething .commentevet .form .choice {margin-left:-19px;}
.heySomething .commentevet .form .choice li {width:150px; height:150px; margin-right:-9px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/81165/bg_ico_2.png);}
.heySomething .commentlist table td {padding:20px 0;}
.heySomething .commentlist table td strong {height:150px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/81165/bg_ico_2.png); background-position:0 0;}
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
		<% If not( left(currenttime,10)>="2017-10-16" and left(currenttime,10)<"2017-10-26" ) Then %>
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
					<div class="bnr"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81165/img_item_represent.jpg" alt="MOOOI" /></div>
				</div>

				<!-- about -->
				<div class="about">
					<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
					<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
				</div>

				<!-- brand -->
				<div class="brand">
					<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81165/img_flower.jpg" alt="오늘도 정신 없이 바쁜 하루였어요.  몸과 마음은 지치고, 그렇게 소소한 행복은 지나치곤 하죠. 이젠 모이가 그 빈자리를 채워주세요" />
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81165/txt_flower.png" alt="" /></p>
					<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="아래로 이동" /></div>
				</div>
				<%
					IF application("Svr_Info") = "Dev" THEN
						itemid = 1239226
					Else
						itemid = 1794100
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
				%>
				<!-- item -->
				<div class="item">
					<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81165/tit_moool.png" alt="moooi" /></h3>
					<div class="desc">
						<div class="option">
							<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81165/txt_name.png" alt="모이 [MOOOI] 꽃 정기 구독 서비스" /></p>
							<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81165/txt_substance.png" alt="구성 전용 박스 + 모이 화병 + 사진 엽서 + 리플렛 ※ 화병과 리플렛은 첫 배송에만 보내 드립니다 " /></p>
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
							<div class="btnget"><a href="/shopping/category_prd.asp?itemid=1794100&amp;pEtr=81165"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러가기" /></a></div>
						</div>
						<div class="slide">
							<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81165/img_item1_1.jpg" alt="" />
							<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81165/img_item1_2.jpg" alt="" />
							<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81165/img_item1_3.jpg" alt="" />
						</div>
						<div class="more-item ct"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81165/img_item_list.jpg" alt="구성 전용 박스 + 모이 화병 + 사진 엽서 + 리플렛" /></div>
					</div>
				</div>
				<!--// item -->
				<%	set oItem = nothing %>
				<div class="flower"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81165/txt_flower_sub.png" alt="계절을 담은, 계절을 닮은 꽃을 정기적으로 받는 가장 편리한 방법 MOOOI" /></div>

				<!-- flower rolling -->
				<div class="flower-rolling">
					<div id="slide" class="slider-horizontal">
						<div class="slide-img"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81165/img_item2_1.jpg" alt="" /></div>
						<div class="slide-img"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81165/img_item2_2.jpg" alt="" /></div>
						<div class="slide-img"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81165/img_item2_3.jpg" alt="" /></div>
						<div class="slide-img"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81165/img_item2_4.jpg" alt="" /></div>
						<div class="slide-img"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81165/img_item2_5.jpg" alt="" /></div>
						<div class="slide-img"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81165/img_item2_6.jpg" alt="" /></div>
						<div class="slide-img"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81165/img_item2_7.jpg" alt="" /></div>
						<div class="slide-img"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81165/img_item2_8.jpg" alt="" /></div>
					</div>
					<a href="http://www.moooi.kr/" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81165/txt_moool_history.png" alt="MOOOI history 더보러 가기" /></a>
				</div>
				<!--// flower rolling -->

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
										<div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1784821&amp;pEtr=81165"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81165/img_slide_1.jpg" alt="" /></a></div>
										<div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1784821&amp;pEtr=81165"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81165/img_slide_2.jpg" alt="" /></a></div>
										<div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1784821&amp;pEtr=81165"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81165/img_slide_3.jpg" alt="" /></a></div>
									</div>
								</div>
							</div>
							<div class="pagination"></div>
						</div>
					</div>
				</div>
				<div class="thumb ct"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81165/img_finish.jpg" alt="" /></div>

				<!-- comment -->
				<div class="commentevet">
					<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/81165/tit_comment.png" alt="Hey, something project, 특별하고 색다른 가을을 선물하는 모이" /></h3>
					<p class="hidden">지금 당신에게 모이의 꽃이 필요한 이유는 무엇인가요? 정성껏 코멘트를 남겨주신 3분을 추첨하여 꽃다발(랜덤)을 선물로 드립니다</p>
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
									<li class="ico1"><button type="button" value="1">#선물</button></li>
									<li class="ico2"><button type="button" value="2">#기분전환</button></li>
									<li class="ico3"><button type="button" value="3">#인테리어</button></li>
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
									#선물
									<% elseif split(arrCList(1,intCLoop),"!@#")(0)="2" then %>
									#기분전환
									<% elseif split(arrCList(1,intCLoop),"!@#")(0)="3" then %>
									#인테리어
									<% else %>
									#선물
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
		width:"571",
		height:"571",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:2700, effect:"fade", auto:true},
		effect:{fade:{speed:800, crossfade:true}}
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

	$(".flower-rolling #slide").FlowSlider({
		marginStart:0,
		marginEnd:0,
		startPosition:0.55
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

	$(".heySomething .flower img").css({"opacity":"0","margin-top":"-20px"});
	function moooiAni() {
		$(".heySomething .flower img").animate({"opacity":"1","margin-top":"0"},800);
	}

	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		//console.log(scrollTop)
		if (scrollTop > 4000 ) {
			moooiAni();
		}
	});
});
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->