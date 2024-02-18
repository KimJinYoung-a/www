<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈
' History : 2017-05-23 원승현 생성
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
	eCode   =  66330
Else
	eCode   =  78079
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
.heySomething .topic {text-align:center; background-color:#f4f1ee; z-index:1;}

/* item */
.heySomething .itemA {margin-top:370px;}
.heySomething .itemA .desc {position:relative; min-height:500px;  padding-top:0;}
.heySomething .itemA .desc .option {margin-top:132px;}
.heySomething .itemA .slidewrap {position:absolute; right:175px; top:-67px; width:290px; height:565px;}
.heySomething .itemA .slidewrap .slide {position:relative; overflow:visible !important; width:290px; height:565px;}
.heySomething .itemA .slidewrap .slide .slidesjs-navigation {position:absolute; z-index:60; top:50%; width:21px; height:37px; margin-top:-18px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_nav_grey.png) no-repeat 0 0; text-indent:-999em;}
.heySomething .itemA .slidewrap .slide .slidesjs-previous {left:-209px;}
.heySomething .itemA .slidewrap .slide .slidesjs-next {right:-175px; background-position:100% 0;}

/* brand */
.heySomething .brand {position:relative; height:1056px; margin-top:245px; text-align:center;}
.heySomething .brand .pic {padding-bottom:65px;}
.heySomething .brand .btnDown {margin-top:75px;}

/* story */
.heySomething .story {margin-top:262px; padding-bottom:120px;}
.heySomething .rolling {margin-top:50px; padding-top:200px;}
.heySomething .rolling .swiper-pagination-switch {width:142px; height:165px; margin:0 40px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/78079/bg_ico_01.png);}
.heySomething .rolling .pagination span em {bottom:-785px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/78079/txt_desc.png); cursor:default;}
.heySomething .rolling .pagination {top:0; padding-left:160px;}
.heySomething .rolling .pagination span:first-child {background-position:0 0;}
.heySomething .rolling .pagination span.swiper-active-switch {background-position:0 -175px;}
.heySomething .rolling .pagination span:first-child + span {background-position:-221px 0;}
.heySomething .rolling .pagination span:first-child + span.swiper-active-switch {background-position:-221px -175px;}
.heySomething .rolling .pagination span:first-child + span + span {background-position:-442px 0;}
.heySomething .rolling .pagination span:first-child + span + span.swiper-active-switch {background-position:-442px -175px;}
.heySomething .rolling .btn-nav {top:486px;}
.heySomething .swipemask {top:200px;}

/* finish */
.heySomething .finish {height:756px; margin-top:275px; background:#f7f7fa url(http://webimage.10x10.co.kr/eventIMG/2017/hey/78079/bg_finish.jpg) 50% 0 no-repeat;}
.heySomething .finish a {display:block; position:absolute; left:50%; top:0; width:1140px; height:100%; margin-left:-570px;}
.heySomething .finish p {position:absolute; left:810px; top:345px; margin-left:0;}

/* comment */
.heySomething .commentevet {margin-top:275px;}
.heySomething .commentevet textarea {margin-top:20px;}
.heySomething .commentevet .form {margin-top:25px;}
.heySomething .commentevet .form .choice {margin-left:-10px;}
.heySomething .commentevet .form .choice li {width:132px; height:152px; margin-right:35px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/78079/bg_ico_02.png);}
.heySomething .commentevet .form .choice li.ico2 button {background-position:-167px 0;}
.heySomething .commentevet .form .choice li.ico2 button.on {background-position:-167px 100%;}
.heySomething .commentevet .form .choice li.ico3 button {background-position:-334px 0;}
.heySomething .commentevet .form .choice li.ico3 button.on {background-position:-334px 100%;}
.heySomething .commentlist table td {padding:15px 0;}
.heySomething .commentlist table td strong {height:70px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/78079/bg_ico_02.png); background-position:0 -26px;}
.heySomething .commentlist table td .ico2 {background-position:-167px -26px;}
.heySomething .commentlist table td .ico3 {background-position:-334px -26px;}
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
		<% If not( left(currenttime,10)>="2017-05-23" and left(currenttime,10)<"2017-05-31" ) Then %>
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
			<div class="bnr"><a href="/shopping/category_prd.asp?itemid=1708836&amp;pEtr=78079"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78079/img_item_represent.jpg" alt="midnight circus" /></a></div>
		</div>

		<%' about %>
		<div class="about">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
			<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
		</div>

		<%' item %>
		<div class="item itemA">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78079/txt_logo.png" alt="midnight circus" /></h3>
			<div class="desc">
				<div class="option">
					<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78079/txt_name.png" alt="[단독] Kimono Fringe Robe" /></p>
					<%' for dev msg : 상품코드 1708836, 할인기간 05/24 ~ 05/30 할인기간이 지나면  <strong class="discount">...</strong> 숨겨주세요 %>
					<%
						IF application("Svr_Info") = "Dev" THEN
							itemid = 1239226
						Else
							itemid = 1708836
						End If
						set oItem = new CatePrdCls
							oItem.GetItemData itemid
					%>
					<% If oItem.FResultCount > 0 Then %>
						<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
							<%' for dev msg : 할인기간 %>
							<div class="price" >
								<% If not( left(currenttime,10)>="2017-05-24" and left(currenttime,10)<"2017-05-31" ) Then %>
									<strong><%= FormatNumber(oItem.Prd.getOrgPrice,0) & chkIIF(oItem.Prd.IsMileShopitem," Point"," won") %></strong>
								<% else %>
									<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %>(20%)</strong>
								<% end if %>
							</div>
						<% else %>
							<%'' for dev msg : 할인기간 종료 후 %>
							<div class="price priceEnd">
								<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
							</div>
						<% end if %>
					<% end if %>
					<%	set oItem = nothing %>
					<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78079/txt_substance.png" alt="소재 Rayon 100%, 사이즈(CM) 어깨 50 / 가슴 53 / 소매 40 / 총길이 109" /></p>
					<div class="btnget"><a href="/shopping/category_prd.asp?itemid=1708836&amp;pEtr=78079"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러가기" /></a></div>
				</div>
				<div class="slidewrap">
					<div id="slide01" class="slide">
						<div><a href="/shopping/category_prd.asp?itemid=1708836&amp;pEtr=78079"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78079/img_item_01.jpg" alt="" /></a></div>
						<div><a href="/shopping/category_prd.asp?itemid=1708836&amp;pEtr=78079"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78079/img_item_02.jpg" alt="" /></a></div>
					</div>
				</div>
			</div>
		</div>

		<%' brand %>
		<div class="brand">
			<div class="pic"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78079/img_brand.jpg" alt="" /></div>
			<p class="text"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78079/txt_brand.png" alt="프랑스 사람들은 한 해를 여행을 계획하는데, 여행을 하는데, 여행의 추억을 되새기는데 보낸다고 하죠. 매일 밤 꿈 속에서 여행을 떠나고, 그 여행에서의 추억은 일상을 더욱 행복하게 만듭니다. 이 모든 순간을 더욱 편안하고 여유롭게 도와줄 미드나잇서커스 패턴 로브를 만나보세요." /></p>
			<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="" /></div>
		</div>
		<div class="ct"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78079/img_brand_02.jpg" alt="" /></div>

		<%' story %>
		<div class="story">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78079/tit_story.png" alt="꿈을 꾸고 여행하고 일상을 사랑하세요!" /></h3>
			<div class="rollingwrap">
				<div class="rolling rolling1">
					<div class="swipemask mask-left"></div>
					<div class="swipemask mask-right"></div>
					<button type="button" class="btn-nav arrow-left">Previous</button>
					<button type="button" class="btn-nav arrow-right">Next</button>
					<div class="swiper">
						<div class="swiper-container swiper1">
							<div class="swiper-wrapper">
								<div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1708836&amp;pEtr=78079"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78079/img_slide_01.jpg" alt="잠을 자는 동안에도 우리는 여행을 꿈꾸죠!" /></a></div>
								<div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1708836&amp;pEtr=78079"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78079/img_slide_02.jpg" alt="잠시, 일상에서 벗어나 행복한 여행을 떠나보는건 어때요?" /></a></div>
								<div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1708836&amp;pEtr=78079"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78079/img_slide_03.jpg" alt="즐거웠던 여행의 추억은 일상을 더욱 행복하게 만듭니다." /></a></div>
							</div>
						</div>
					</div>
					<div class="pagination"></div>
				</div>
			</div>
		</div>

		<%' finish %>
		<div class="finish">
			<a href="/street/street_brand_sub06.asp?makerid=circusmaster">
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78079/txt_finish.png" alt="A comfortable life midnight circus" /></p>
			</a>
		</div>

		<%' comment %>
		<div class="commentevet">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/78079/tit_comment_v2.png" alt="Hey, something project, 꿈을 꾸고, 여행하고, 일상을 사랑하세요!" /></h3>
			<p class="hidden">당신이 꿈꾸는 여행은 어떤 것인가요? 정성스러운 댓글을 남겨주신 2분께 미드나잇서커스 ROBE를 선물로 드립니다. (패턴 1개씩)</p>
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
							<li class="ico1"><button type="button" value="1">#SLEEP</button></li>
							<li class="ico2"><button type="button" value="2">#VACANCE</button></li>
							<li class="ico3"><button type="button" value="3">#DAILY</button></li>
						</ul>
						<textarea title="코멘트 작성" cols="60" rows="5" name="txtcomm1" id="txtcomm1" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();" <%IF NOT(IsUserLoginOK) THEN%>readonly<%END IF%>><%IF NOT IsUserLoginOK THEN%>로그인 후 글을 남길 수 있습니다.<% else %><%END IF%></textarea>
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
												#SLEEP
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="2" then %>
												#VACANCE
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="3" then %>
												#DAILY
											<% else %>
												#SLEEP
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
										<% End If %>
										<% If arrCList(8,i) <> "W" Then %>
											<br /><img src="http://fiximage.10x10.co.kr/web2013/event/ico_mobile.png" alt="모바일에서 작성됨">
										<% End If %>
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
<% If Not(Trim(hspchk(1)))="hsproject" Then %>
	</div>
<% End If %>
<!-- #include virtual="/lib/db/dbclose.asp" -->

<script type="text/javascript">
$(function(){
	/* slide js */
	$("#slide01").slidesjs({
		width:"290",
		height:"565",
		pagination:false,
		navigation:{effect:"fade"},
		play:{interval:2000, effect:"fade", auto:true},
		effect:{fade: {speed:900, crossfade:true}
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
	titleAnimation()
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