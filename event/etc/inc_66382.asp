<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈 4
' History : 2015.09.25 한용민 생성
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
dim currenttime
	currenttime =  now()
	'currenttime = #09/30/2015 09:00:00#

dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  64898
Else
	eCode   =  66382
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
IF application("Svr_Info") = "Dev" THEN
	itemid   =  1239115
Else
	itemid   =  1358365
End If

dim oItem
set oItem = new CatePrdCls
	oItem.GetItemData itemid


Dim hspchk
'// 현재 주소값 체크하여 신규, 구버전 확인
hspchk = Split(LCase(Request.ServerVariables("PATH_INFO")),"/")
%>
<style type="text/css">
.evtEndWrapV15 {display:none;}

/* title */
.heySomething .topic {background-color:#eaeaea;}

/* item */
.heySomething .slidesjs-pagination li a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/66382/bg_pagination.jpg);}

/* visual */
.heySomething .visual .figure {background-color:#6d6c6d;}
.heySomething #slider {height:257px;}
.heySomething #slider .slide-img {width:290px; height:257px; margin:0 37px;}

/* brand */
.heySomething .brand {height:740px}

/* story */
.heySomething .rolling .pagination {position:absolute; left:50%; top:0; width:980px; margin-left:-490px;}
.heySomething .rolling .swiper-pagination-switch {margin:0 11px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/66382/bg_ico.png);}
.heySomething .rolling .pagination span em {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/66382/txt_story_desc.png);}

/* finish */
.heySomething .finish {background-color:#f2f0e9;}
.heySomething .finish p {top:153px; left:50%; margin-left:-490px; width:220px; height:177px;}
.heySomething .finish p em {width:220px; height:176px; background:transparent url(http://webimage.10x10.co.kr/eventIMG/2015/66382/txt_with.png) no-repeat 0 0;}
.heySomething .finish p span {background-color:#928f8f;}

/* comment */
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/66382/bg_ico.png);}

.heySomething .commentlist table td strong {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/66382/bg_ico.png);}
</style>
<script type='text/javascript'>

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
		<% If not( left(currenttime,10)>="2015-09-30" and left(currenttime,10)<"2015-10-07" ) Then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return false;
		<% else %>
			<% if commentcount>4 then %>
				alert("이벤트는 5회까지 참여 가능 합니다.");
				return false;
			<% else %>
				if (frm.gubunval.value == ''){
					alert('원하는 것을 선택해 주세요.');
					return false;
				}
				if (frm.txtcomm1.value == '' || GetByteLength(frm.txtcomm1.value) > 400){
					alert("코맨트를 남겨주세요.\n400자 까지 작성 가능합니다.");
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
</head>
<body>

<% If Not(Trim(hspchk(1)))="hsproject" Then %>
<div class="evt66382">
	<div class="heySomething">
<% End If %>
		<!-- title, nav -->
		<div class="topic">
			<h2>
				<span class="letter1">Hey,</span>
				<span class="letter2">something</span>
				<span class="letter3">project</span>
				<!--span class="letter4">DESIGN FINGERS VOL.2</span-->
			</h2>

			<% If Not(Trim(hspchk(1)))="hsproject" Then %>
				<% '<!-- for dev mgs :  탭 navigator --> %>
				<div class="navigator">
					<ul>
						<!-- #include virtual="/event/etc/inc_66049_menu.asp" -->
					</ul>
					<span class="line"></span>
				</div>
			<% End If %>
			<div class="bnr"><a href="/shopping/category_prd.asp?itemid=1358365"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66382/img_item_represent.jpg" alt="브릿 스티치" /></a></div>
		</div>

		<!-- about -->
		<div class="about">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/66049/tit_about.png" alt="About Hey, something project" /></h3>
			<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
		</div>

		<!-- item -->
		<div class="item itemB">
			<div class="inner">
				<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/66382/tit_britstitch.png" alt="BRIT-STITCH" /></h3>
				<div class="desc">
					<div class="slidewrap">
						<div id="slide" class="slide">
							<div><a href="/shopping/category_prd.asp?itemid=1358365"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66382/img_figure_01.jpg" alt="" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1358365"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66382/img_figure_02.jpg" alt="" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1358365"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66382/img_figure_03.jpg" alt="" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1358365"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66382/img_figure_04.jpg" alt="" /></a></div>
						</div>
					</div>
					<div class="option">
						<em class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66382/txt_name.png" alt="Half Pint Warm Sand" /></em>

						<% if oItem.FResultCount > 0 then %>
							<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
								<div class="price">
									<% If oItem.Prd.FOrgprice = 0 Then %>
									<% else %>
										<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66049/txt_only_<%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>percent.png" alt="단, 일주일만 ONLY 20%" /></strong>
									<% end if %>
	
									<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								</div>
							<% else %>
								<div class="price priceEnd">
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								</div>
							<% end if %>
						<% end if %>

						<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66382/txt_substance.png" alt="영국 어느 마을의 우유 배달부로부터 시작된 브릿-스티치의 역사. 이 작은 가방 속에는 45년의 흔적이 고스란히 담겨있습니다." /></p>
						<div class="btnget"><a href="/shopping/category_prd.asp?itemid=1358365"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66049/btn_get.gif" alt="구매하러 가기" /></a></div>
					</div>
				</div>
			</div>
		</div>

		<!-- visual -->
		<div class="visual">
			<div class="figure"><a href="/shopping/category_prd.asp?itemid=1358365"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66382/img_item_visual_big.jpg" alt="" /></a></div>

			<div id="slider" class="slider-horizontal">
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1358365"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66382/img_item_visual_01.jpg" alt="JAZZY" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1358365"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66382/img_item_visual_02.jpg" alt="WARM SAND" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1358365"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66382/img_item_visual_03.jpg" alt="PURPLE HEART" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1358365"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66382/img_item_visual_04.jpg" alt="VINTAGE RED" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1358365"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66382/img_item_visual_05.jpg" alt="OLIVE" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1358365"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66382/img_item_visual_06.jpg" alt="BLACK" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1358365"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66382/img_item_visual_07.jpg" alt="White" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1358365"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66382/img_item_visual_08.jpg" alt="EMERALD" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1358365"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66382/img_item_visual_09.jpg" alt="CHOCOLATE BROWN" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1358365"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66382/img_item_visual_10.jpg" alt="INSIGNIA" /></a>
				</div>
			</div>
		</div>

		<!-- brand -->
		<div class="brand">
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/66382/txt_plan.png" alt="When we say our bags have vintage heritage, we really mean it. 우리의 가방에는 전통과 역사가 깃들어있다고 말합니다, 정말 사실이기 때문이죠. By. Brit-Stitch 영국의 마스터 장인이었던 피터 존스은 1967년 그가 살던 지역의 우유 배달부 토비의 수금가방을 제작해줍니다. 약 45년이 흐른 뒤 토비는 스트랩 교체를 위해 공방을 찾아옵니다. 시간의 흔적을 그대로 담은 토비의 가방을 보고 감동을 느낀 직원들은 이를 현재적 감각으로 재해석하여 클래식모던 스타일의 가방을 디자인하기에 이르렀으며 이로써 브릿-스티치가 탄생하게 됩니다." /></p>
			<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66049/btn_arrow_down.png" alt="" /></div>
		</div>

		<!-- story -->
		<div class="story">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/66382/tit_story.png" alt="작은 가방 속에 담긴 수 많은 이야기" /></h3>
			<div class="rollingwrap">
				<div class="rolling">
					<div class="swipemask mask-left"></div>
					<div class="swipemask mask-right"></div>
					<button type="button" class="btn-nav arrow-left">Previous</button>
					<button type="button" class="btn-nav arrow-right">Next</button>
					<div class="swiper">
						<div class="swiper-container swiper1">
							<div class="swiper-wrapper" style="height:630px;">
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1358365"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66382/img_slide_01.jpg" alt="45년의 역사를 고스란히 간직한 토비의 가방을 보며 브릿-스티치는 매일 그 때의 감동을 기억합니다." /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1358365"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66382/img_slide_02.jpg" alt="사용하면 할수록 더더욱 유용한 가방. 작지만 당신에게 꼭 필요한 것들은 거기에 있을 거에요." /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1358365"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66382/img_slide_03.jpg" alt="모든 재료 공수와 공정은 영국 현지에서 이루어집니다. MADE IN BRITAIN의 자존심은 한 번도 변한 적이 없습니다." /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1358365"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66382/img_slide_04.jpg" alt="과거로부터 배우고 성장합니다. 브릿-스티치를 위한 작은 의견도 놓치지 않습니다." /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1358365"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66382/img_slide_05.jpg" alt="브릿-스티치는 고급 프리미엄 소가죽으로 제작됩니다. 세월의 흔적은 가죽에 고스란히 입혀집니다." /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1358365"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66382/img_slide_06.jpg" alt="다양한 컬러는 브릿-스티치에게 놀이와 같습니다. 색채가 주는 즐거움은 일상의 활력이 되기도 합니다." /></a>
								</div>
							</div>
						</div>
					</div>
					<div class="pagination"></div>
				</div>
			</div>
		</div>

		<!-- finish -->
		<div class="finish">
			<a href="/shopping/category_prd.asp?itemid=1358365">
				<p>
					<em>작은 가방 속에 담긴 수 많은 이야기</em>
					<span></span>
				</p>
				<img src="http://webimage.10x10.co.kr/eventIMG/2015/66382/img_item_finish_v1.jpg" alt="브릿-스티치" />
			</a>
		</div>

		<!-- comment -->
		<div class="commentevet">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/66382/tit_want.png" alt="Hey, something project 당신이 갖고 싶은 것" /></h3>
			<p class="hidden">정성껏 코멘트를 남겨주신 3분을 추첨하여 브릿-스티치의 Half Pint를 선물로 드립니다. 컬러는 랜덤으로 배송됩니다. 기간 : 2015.09.30 ~ 10.07 / 발표 : 10.12</p>

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
					<legend>베로니카포런던 코멘트 쓰기</legend>
						<ul class="choice">
							<li class="ico1"><button type="button" value="1">Remember</button></li>
							<li class="ico2"><button type="button" value="2">More</button></li>
							<li class="ico3"><button type="button" value="3">Stay</button></li>
							<li class="ico4"><button type="button" value="4">Learn</button></li>
							<li class="ico5"><button type="button" value="5">Share</button></li>
							<li class="ico6"><button type="button" value="6">Play</button></li>
						</ul>
						<textarea name="txtcomm1" id="txtcomm1" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();" <%IF NOT(IsUserLoginOK) THEN%>readonly<%END IF%> title="" cols="60" rows="5"><%IF NOT IsUserLoginOK THEN%>로그인 후 글을 남길 수 있습니다.<% else %><%END IF%></textarea>
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

			<!-- commentlist -->
			<div class="commentlist" id="commentlist">
				<div class="total">total <%= iCTotCnt %></div>
				
				<% IF isArray(arrCList) THEN %>
					<table>
						<caption>브릿 스티치 코멘트 목록</caption>
						<colgroup>
							<col style="width:150px;" />
							<col style="width:*;" />
							<col style="width:110px;" />
							<col style="width:120px;" />
							<col style="width:10px;" />
						</colgroup>
						<thead>
						<tr>
							<th scope="col"></th>
							<th scope="col">내용</th>
							<th scope="col">작성일자</th>
							<th scope="col">아이디</th>
							<th scope="col"></th>
						</tr>
						</thead>
						<tbody>
							<% For intCLoop = 0 To UBound(arrCList,2) %>
							<tr>
								<td>
									<% if isarray(split(arrCList(1,intCLoop),"!@#")) then %>
										<strong class="ico<%= split(arrCList(1,intCLoop),"!@#")(0) %>">
											<% if split(arrCList(1,intCLoop),"!@#")(0)="1" then %>
												Remember
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="2" then %>
												More
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="3" then %>
												Stay
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="4" then %>
												Learn
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="5" then %>
												Share
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="6" then %>
												Play
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
							<% Next %>
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
</div>
<% End If %>

<script type="text/javascript" src="/lib/js/jquery.flowslider.js"></script>
<script type="text/javascript">
$(function(){
	$("#slider").FlowSlider({
		marginStart:0,
		marginEnd:0,
		//position:0.0,
		startPosition:0.55
	});

	/* swipe */
	var swiper1 = new Swiper('.swiper1',{
		centeredSlides:true,
		slidesPerView:"auto",
		loop: true,
		speed:1200,
		autoplay:3000,
		simulateTouch:false,
		pagination: '.pagination',
		paginationClickable: true
	});

	$('.arrow-left').on('click', function(e){
		e.preventDefault()
		swiper1.swipePrev()
	});
	$('.arrow-right').on('click', function(e){
		e.preventDefault()
		swiper1.swipeNext()
	});

	$('.pagination span:nth-child(1)').append('<em class="desc1"></em>');
	$('.pagination span:nth-child(2)').append('<em class="desc2"></em>');
	$('.pagination span:nth-child(3)').append('<em class="desc3"></em>');
	$('.pagination span:nth-child(4)').append('<em class="desc4"></em>');
	$('.pagination span:nth-child(5)').append('<em class="desc5"></em>');
	$('.pagination span:nth-child(6)').append('<em class="desc6"></em>');

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
		//alert( $(this).val() );
		frmcom.gubunval.value = $(this).val()
		$(".form .choice li button").removeClass("on");
		if ( $(this).hasClass("on")) {
			$(this).removeClass("on");
		} else {
			$(this).addClass("on");
		}
	});

	/* slide js */
	$("#slide").slidesjs({
		width:"570",
		height:"485",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:2500, effect:"fade", auto:true},
		effect:{fade: {speed:2000, crossfade:true}
		},
		callback: {
			complete: function(number) {
				var pluginInstance = $('#slide').data('plugin_slidesjs');
				setTimeout(function() {
					pluginInstance.play(true);
				}, pluginInstance.options.play.interval);
			}
		}
	});
	//mouse control
	$('#slide .slidesjs-pagination > li a').mouseenter(function(){
		$('a[data-slidesjs-item="' + $(this).attr("data-slidesjs-item") + '"]').trigger('click');
	});

	$(".slidesjs-pagination li:nth-child(1)").addClass("num01");
	$(".slidesjs-pagination li:nth-child(2)").addClass("num02");
	$(".slidesjs-pagination li:nth-child(3)").addClass("num03");
	$(".slidesjs-pagination li:nth-child(4)").addClass("num04");

	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 3200 ) {
			brandAnimation()
		}
		if (scrollTop > 6000 ) {
			finishAnimation()
		}
	});

	/* title animation */
	titleAnimation()
	$(".heySomething .topic h2 span").css({"opacity":"0"});
	$(".heySomething .topic h2 .letter1").css({"margin-top":"7px"});
	$(".heySomething .topic h2 .letter2").css({"margin-top":"15px"});
	$(".heySomething .topic h2 .letter3").css({"margin-top":"23px"});
	function titleAnimation() {
		$(".heySomething .topic h2 .letter1").delay(400).animate({"margin-top":"0", "opacity":"1"},800);
		$(".heySomething .topic h2 .letter2").delay(800).animate({"margin-top":"7px", "opacity":"1"},800);
		$(".heySomething .topic h2 .letter3").delay(1200).animate({"margin-top":"17px", "opacity":"1"},800);
		$(".heySomething .topic h2 .letter4").delay(1800).animate({"opacity":"1"},800);
	}

	/* brand animation */
	$(".heySomething .brand p").css({"height":"0", "opacity":"0"});
	$(".heySomething .brand .btnDown").css({"margin-top":"70px", "opacity":"0"});
	function brandAnimation() {
		$(".heySomething .brand p").delay(500).animate({"height":"597px", "opacity":"1"},1800);
		$(".heySomething .brand .btnDown").delay(3000).animate({"margin-top":"62px", "opacity":"1"},800);
	}

	/* finish animation */
	$(".heySomething .finish p em").css({"margin-left":"7px", "opacity":"0"});
	$(".heySomething .finish p span").css({"width":"0"});
	function finishAnimation() {
		$(".heySomething .finish p em").delay(400).animate({"margin-left":"0", "opacity":"1"},800);
		$(".heySomething .finish p span").delay(900).animate({"width":"68px", "opacity":"1"},800);
	}
});
</script>

<!-- #include virtual="/lib/db/dbclose.asp" -->