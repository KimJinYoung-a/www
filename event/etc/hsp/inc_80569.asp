<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'###########################################################
' Description : hey, something project 시리즈 88
' 언제 어디서나,편안하게,당신곁에
' History : 2017-09-19 정태훈 생성
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
	eCode   =  66431
Else
	eCode   =  80569
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
.heySomething .topic {text-align:center; background-color:#b47628; z-index:1;}
.heySomething .topic h2 span {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_hey_something_project_white.png);}

/* brand */
.heySomething .brand {position:relative; height:655px; margin:400px 0 481px; text-align:center;}
.heySomething .brand .btnDown {margin-top:67px;}

/* item */
.heySomething .item {width:1140px;  margin:0 auto; border-bottom:1px dashed  #cdcdcd;}
.heySomething .item3 {border-bottom:none;}
.heySomething .item .desc {position:relative; margin-top:150px;}
.heySomething .item1 .desc {margin-top:142px;}
.heySomething .item .option {height:415px; padding-left:80px; text-align:left;}
.heySomething .item .option .price {margin-top:35px;}
.heySomething .item .option .substance {position:static; margin-top:40px;}
.heySomething .item .option .btnget {position:static; margin-top:28px;}
.heySomething .item .prdImg {position:absolute; right:100px; top:-80px;}

/* collabo */
.heySomething .collabo {position:relative; height:560px; margin-top:205px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/80569/bg_grey.jpg) 50% 0 no-repeat;}
.heySomething .collabo img{position:absolute; top:158px; left:50%; margin-left:115px;}

/* story */
.heySomething .story {margin:375px 0 340px; padding-bottom:120px;}
.heySomething .rollingwrap {margin-top:0;}
.heySomething .rolling {padding-top:156px;}
.heySomething .rolling .pagination {top:0; padding-left:180px;}
.heySomething .rolling .pagination span {height:150px; margin:0 36px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/80569/bg_ico2.png);}
.heySomething .rolling .pagination span em {bottom:-795px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/80569/txt_desc.png); cursor:default;}
.heySomething .rolling .btn-nav {top:457px;}
.heySomething .swipemask {top:156px; background-color:#fff;}

/* galley */
.gallery {position:relative; width:849px; height:929px; margin:140px auto;}
.gallery div {position:absolute;}
.gallery div img{opacity:0;}
.gallery .pic1 {top:0; left:0; background-color:#cec9bb;}
.gallery .pic2 {top:0; right:0; background-color:#e49d51;}
.gallery .pic3 {bottom:0; left:0; background-color:#a79a7c;}
.gallery .pic4 {bottom:0; right:0; background-color:#e4f1f3;}

/* comment */
.heySomething .commentevet {margin-top:395px;}
.heySomething .commentevet textarea {margin-top:35px;}
.heySomething .commentevet .form {margin-top:25px;}
.heySomething .commentevet .form .choice li {width:92px; height:92px; margin-right:22px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/80569/bg_ico1.png);}
.heySomething .commentevet .form .choice li.ico1 button {background-position:-29px -29px;}
.heySomething .commentevet .form .choice li.ico1 button.on {background-position:-29px -179px;}
.heySomething .commentevet .form .choice li.ico2 button {background-position:-179px -29px;}
.heySomething .commentevet .form .choice li.ico2 button.on {background-position:-179px -179px;}
.heySomething .commentevet .form .choice li.ico3 button {background-position:-329px -29px;}
.heySomething .commentevet .form .choice li.ico3 button.on {background-position:-329px -179px;}
.heySomething .commentlist table td {padding:5px 0;}
.heySomething .commentlist table td strong {height:150px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/80569/bg_ico1.png); background-position:0 0;}
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
		<% If not( left(currenttime,10)>="2017-09-20" and left(currenttime,10)<"2017-09-27" ) Then %>
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
					<div class="bnr"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80569/img_item_represent.jpg" alt="" /></div>
				</div>

				<!-- about -->
				<div class="about">
					<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
					<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
				</div>

				<!-- brand -->
				<div class="brand">
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80569/txt_brand.jpg" alt="karen white 클래식한 디자인에 고급스러운 소재와 섬세한 디테일, 꼼꼼한 마무리와 공정에 집중한 디자이너 슈즈 브랜드 입니다." /></p>
					<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="" /></div>
				</div>
				<%
					IF application("Svr_Info") = "Dev" THEN
						itemid = 1239226
					Else
						itemid = 1789493
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
				%>
				<!-- item -->
				<div class="item item1">
					<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80569/tit_buy.jpg" alt="karen white" /></h3>
					<div class="desc">
						<div class="option">
							<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80569/txt_name1.png" alt="School 블랙" /></p>
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
							<div class="btnget"><a href="/shopping/category_prd.asp?itemid=1789493&amp;pEtr=80569"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러가기" /></a></div>
						</div>
						<div class="prdImg"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80569/img_item1.jpg" alt="School 블랙 이미지" /></div>
					</div>
				</div>
				<%	set oItem = nothing %>
				<%
					IF application("Svr_Info") = "Dev" THEN
						itemid = 1239226
					Else
						itemid = 1789494
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
				%>
				<div class="item item2">
					<div class="desc">
						<div class="option">
							<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80569/txt_name2.png" alt="Tomorrow 브라운" /></p>
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
							<div class="btnget"><a href="/shopping/category_prd.asp?itemid=1789494&amp;pEtr=80569"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러가기" /></a></div>
						</div>
						<div class="prdImg"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80569/img_item2.jpg" alt="Tomorrow 브라운 이미지" /></div>
					</div>
				</div>
				<%	set oItem = nothing %>
				<%
					IF application("Svr_Info") = "Dev" THEN
						itemid = 1239226
					Else
						itemid = 1789492
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
				%>
				<div class="item item3">
					<div class="desc">
						<div class="option">
							<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80569/txt_name3.png" alt="Today 블랙" /></p>
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
							<div class="btnget"><a href="/shopping/category_prd.asp?itemid=1789492&amp;pEtr=80569"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러가기" /></a></div>
						</div>
						<div class="prdImg"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80569/img_item3.jpg" alt="Today 블랙 이미지" /></div>
					</div>
				</div>
				<%	set oItem = nothing %>

				<div class="collabo"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80569/txt_callabo.png" alt="꾸미지 않은 듯한 내츄럴함 편안한 착화감 합리적인 럭셔리 karen white ENBYTEN" /></div>

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
										<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80569/img_slide_1.jpg" alt="#Comfort 편안한 착화감을 우선으로 생각합니다 " /></div>
										<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80569/img_slide_2.jpg" alt="#Natural 어디에나 신어도 자연스럽게 어울리는 디자인" /></div>
										<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80569/img_slide_3.jpg" alt="#Luxury 고급스럽지만 부담스럽지 않은 합리적인 가격" /></div>
									</div>
								</div>
							</div>
							<div class="pagination"></div>
						</div>
					</div>
				</div>

				<!-- gallery -->
				<div class="gallery">
					<div class="pic1"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80569/img_gallery1.jpg" alt="" /></div>
					<div class="pic2"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80569/img_gallery2.jpg" alt="" /></div>
					<div class="pic3"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80569/img_gallery3.jpg" alt="" /></div>
					<div class="pic4"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80569/img_gallery4.jpg" alt="" /></div>
				</div>

				<!-- comment -->
				<div class="commentevet">
					<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80569/tit_comment.png" alt="Hey, something project, 당신은 어떤 구두를 좋아하시나요?" /></h3>
					<p class="hidden">텐바이텐 X 카렌화이트 상품을 보고 마음에 드는상품 이름과, 마음에 드는 이유를 남겨주세요!정성스러운 댓글을 남겨주신 3분을 선정해 텐바이텐 1만원권 상품권을 드립니다! </p>
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
									<li class="ico1"><button type="button" value="1">#Comfort</button></li>
									<li class="ico2"><button type="button" value="2">#Natural</button></li>
									<li class="ico3"><button type="button" value="3">#Luxury</button></li>
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
									#Comfort
									<% elseif split(arrCList(1,intCLoop),"!@#")(0)="2" then %>
									#Natural
									<% elseif split(arrCList(1,intCLoop),"!@#")(0)="3" then %>
									#Luxury
									<% else %>
									#Comfort
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
		//console.log(scrollTop);
		if (scrollTop > 6286) {
			$(".gallery .pic1 img").delay(100).animate({"opacity":"1"},1200);
			$(".gallery .pic2 img").delay(300).animate({"opacity":"1"},1200);
			$(".gallery .pic3 img").delay(500).animate({"opacity":"1"},1200);
			$(".gallery .pic4 img").delay(700).animate({"opacity":"1"},1200);
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