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
	eCode   =  66414
Else
	eCode   =  79984
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
.heySomething {text-align:center;}

/* title */
.heySomething .topic {text-align:center; background-color:#93dafe; z-index:1;}

/* brand */
.heySomething .brand {position:relative; height:995px; margin:405px 0 250px; text-align:center;}
.heySomething .brand p {margin-top:90px;}
.heySomething .brand .btnDown {margin-top:95px;}

/* item */
.heySomething .item {width:1140px; margin:0 auto; text-align:left;}
.heySomething .item .desc {position:relative; width:1050px; height:535px; margin:0 auto 340px;}
.heySomething .item .desc > a {display:block; padding:130px 0 0 35px; text-decoration:none;}
.heySomething .item .option {height:346px;}
.heySomething .item .option .substance {bottom:85px;}
.heySomething .item .option .btnget {margin-top:45px;}
.heySomething .item .slide {position:absolute; top:74px; right:35px; width:630px; height:450px;}

/* feature */
.feature {margin-top:355px;}
.feature .gallery {position:relative; width:980px; height:739px; margin:130px auto 0;}
.feature .gallery li{position:absolute; opacity:0;}
.feature .gallery li.g1 {top:0; left:0;}
.feature .gallery li.g2 {top:0; right:0;}
.feature .gallery li.g3 {bottom:0; left:0;}
.feature .gallery li.g4 {bottom:0; left:247px;}
.feature .gallery li.g5 {bottom:0; right:0;}

/* story */
.heySomething .story {margin-top:379px; padding-bottom:120px;}
.heySomething .rolling {padding-top:159px;}
.heySomething .rolling .pagination {top:0; padding-left:147px;}
.heySomething .rolling .pagination span em {bottom:-780px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/79984/txt_desc.png); cursor:default;}
.heySomething .rolling .pagination span {width:130px; height:130px; margin:0 22px;background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/79984/bg_ico_1.jpg);}
.heySomething .rolling .pagination span:first-child + span {background-position:-172px 0;}
.heySomething .rolling .pagination span:first-child + span + span{background-position:-350px 0;}
.heySomething .rolling .pagination span:first-child + span + span + span{background-position:100% 0;}
.heySomething .rolling .pagination span:first-child.swiper-active-switch {background-position:0 -138px;}
.heySomething .rolling .pagination span:first-child + span.swiper-active-switch {background-position:-172px -138px;}
.heySomething .rolling .pagination span:first-child + span + span.swiper-active-switch {background-position:-350px -138px;}
.heySomething .rolling .pagination span:first-child + span + span + span.swiper-active-switch {background-position:100% -138px;}
.heySomething .rolling .btn-nav {top:442px;}
.heySomething .swipemask {top:159px; background-color:#fff;}

/* comment */
.heySomething .commentevet {margin-top:350px;}
.heySomething .commentevet textarea {margin-top:25px; width:1050px; height:98px; padding:10px;}
.heySomething .commentevet .form {margin-top:25px;}

.heySomething .commentevet .form .choice li {width:100px; height:100px; margin-right:13px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/79984/bg_ico_2.png);}
.heySomething .commentevet .form .choice li.ico2 button {background-position:-113px 0;}
.heySomething .commentevet .form .choice li.ico3 button {background-position:-226px 0;}
.heySomething .commentevet .form .choice li.ico4 button {background-position:-339px 0;}
.heySomething .commentevet .form .choice li.ico1 button.on {background-position:-2px 100%;}
.heySomething .commentevet .form .choice li.ico2 button.on {background-position:-115px 100%;}
.heySomething .commentevet .form .choice li.ico3 button.on {background-position:-228px 100%;}
.heySomething .commentevet .form .choice li.ico4 button.on {background-position:100% 100%;}

.heySomething .commentlist table td {padding:24px 0 24px 15px;}
.heySomething .commentlist table td strong {width:100px; height:100px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/79984/bg_ico_2.png); background-position:0 0;}
.heySomething .commentlist table td .ico2 {background-position:-113px 0;}
.heySomething .commentlist table td .ico3 {background-position:-226px 0;}
.heySomething .commentlist table td .ico4 {background-position:-339px 0;}
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
		<% If not( left(currenttime,10)>="2017-08-21" and left(currenttime,10)<"2017-09-01" ) Then %>
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
					<div class="bnr"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79984/img_item_represent.jpg" alt="칼로리컷 헤이썸띵" /></div>
				</div>

				<!-- about -->
				<div class="about">
					<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
					<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
				</div>

				<!-- brand -->
				<div class="brand">
					<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79984/img_brand.jpg" alt="" />
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79984/txt_brand.png" alt="INTAKE 인테이크푸즈는 'Eating' 과 'Intake'는 같지 않다라는 전제를 바탕으로 식문화의 혁신을 선도하는 식품 브랜드 전문 기업입니다. 인테이크푸즈는 소비자가 식품에 대해 올바르게 인식할 수 있도록 식품컨텐츠를 개발하고 이를 식품 브랜드에 자연스럽게 녹여 확산시키며, 이를 통해 소비자의 라이프스타일을 변화시키는 것을 목표로 하고 있습니다." /></p>
					<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="" /></div>
				</div>
				<%
					IF application("Svr_Info") = "Dev" THEN
						itemid = 1239226
					Else
						itemid = 1774239
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
				%>
				<div class="item">
					<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79984/tit_intake.png" alt="INTAKE 10X10" /></h3>
					<div class="desc">
						<a href="/shopping/category_prd.asp?itemid=1774239&pEtr=79984">
							<div class="option">
								<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79984/txt_name.png" alt="칼로리컷 츄어블" /></p>
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
								<p class="substance">
									<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79984/txt_substance.png" alt="개별 포장으로 편리해진 휴대성과 상큼한 레몬맛이 추가되어 돌아온 씹어먹는 츄어블 형태의 NEW 칼로리컷 맛있게 먹고 칼로리를 CUT 하세요!" />
								</p>
								<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러가기" /></div>
							</div>
							<div class="slide">
								<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79984/img_item1.jpg" alt="" />
								<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79984/img_item2.jpg" alt="" />
							</div>
						</a>
					</div>
				</div>
				<%	set oItem = nothing %>

				<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79984/img_item.jpg" alt="" /></div>

				<div class="feature">
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79984/txt_feature.png" alt="칼로리컷 츄어블 체지방 감소에 도움을 주는 가르시니아 캄보지아 추출물 함유되어 탄수화물이 지방으로 합성되는 것을 억제하여, 체지방 감소에 도움을 줍니다. 어디서나 즐길 수 있는 간편한 포장법으로 식사 후에 가볍고 맛있게 씹어먹을 수 있답니다. " /></p>
					<ul class="gallery">
						<li class="g1"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79984/img_gallery_1.jpg" alt="" /></li>
						<li class="g2"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79984/img_gallery_2.jpg" alt="" /></li>
						<li class="g3"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79984/img_gallery_3.jpg" alt="" /></li>
						<li class="g4"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79984/img_gallery_4.jpg" alt="" /></li>
						<li class="g5"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79984/img_gallery_5.jpg" alt="" /></li>
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
										<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79984/img_slide_1.jpg" alt="#NEW" /></div>
										<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79984/img_slide_2.jpg" alt="#CUTE" /></div>
										<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79984/img_slide_3.jpg" alt="#CONVENIENT" /></div>
										<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79984/img_slide_4.jpg" alt="#CHEWABLE" /></div>
									</div>
								</div>
							</div>
							<div class="pagination"></div>
						</div>
					</div>
				</div>
				
				<!-- comment -->
				<div class="commentevet">
					<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79984/tit_commnet.png" alt="Hey, something project, 새로워진 칼로리컷의 가장 기대되는 점" /></h3>
					<p class="hidden">칼로리를 CUT! 해주는 칼로리컷의 새로운 모습 중 가장 기대되는 점 무엇인가요? 정성껏 코멘트를 남겨주신 분을 추첨하여 인테이크 다이어트 키트 증정(5만원 상당)을 선물로 드립니다</p>
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
									<li class="ico1"><button type="button" value="1">#NEW</button></li>
									<li class="ico2"><button type="button" value="2">#CUTE</button></li>
									<li class="ico3"><button type="button" value="3">#CONVENIENT</button></li>
									<li class="ico4"><button type="button" value="4">#CHEWABLE</button></li>
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
										#NEW
										<% elseif split(arrCList(1,intCLoop),"!@#")(0)="2" then %>
										#CUTE
										<% elseif split(arrCList(1,intCLoop),"!@#")(0)="3" then %>
										#CONVENIENT
										<% elseif split(arrCList(1,intCLoop),"!@#")(0)="4" then %>
										#CHEWABLE
										<% else %>
										#NEW
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
	$('.slide').slidesjs({
		width:630,
		height:450,
		pagination:false,
		navigation:false,
		play:{interval:1800, effect:'fade', auto:true},
		effect:{fade: {speed:1000, crossfade:true}
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


	/* animation effect */
	$(window.parent).scroll(function(){
		var gallery = $(".feature").offset().top;
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > gallery) {
			galleryAnimation();
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
	$(".heySomething .gallery li").css({"opacity":"0"});
	function galleryAnimation() {
		$(".heySomething .gallery li:nth-child(1)").delay(100).animate({"opacity":"1"},800);
		$(".heySomething .gallery li:nth-child(2)").delay(300).animate({"opacity":"1"},800);
		$(".heySomething .gallery li:nth-child(3)").delay(500).animate({"opacity":"1"},800);
		$(".heySomething .gallery li:nth-child(4)").delay(500).animate({"opacity":"1"},800);
		$(".heySomething .gallery li:nth-child(5)").delay(300).animate({"opacity":"1"},800);
	}
});
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->