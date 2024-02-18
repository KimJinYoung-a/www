<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈 6
' History : 2015.10.13 원승현 생성
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
	'currenttime = #10/07/2015 09:00:00#

dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  64918
Else
	eCode   =  66453
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
	itemid   =  1282696
End If

dim oItem
set oItem = new CatePrdCls
	oItem.GetItemData itemid

'dim itemid2, itemid3
'IF application("Svr_Info") = "Dev" THEN
'	itemid2   =  1239115
'	itemid3   =  1239115
'Else
'	itemid2   =  1364733
'	itemid3   =  1364741
'End If
   
'dim oItem2
'set oItem2 = new CatePrdCls
'	oItem2.GetItemData itemid2

'dim oItem3
'set oItem3 = new CatePrdCls
'	oItem3.GetItemData itemid3

Dim hspchk
'// 현재 주소값 체크하여 신규, 구버전 확인
hspchk = Split(LCase(Request.ServerVariables("PATH_INFO")),"/")
%>

<style type="text/css">
.evtEndWrapV15 {display:none;}

/* title */
.heySomething .topic {background-color:#f6e3e1;}

/* item */
.heySomething .item .option .price .discount {display:none;}
.heySomething .slidesjs-pagination li a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/hey/66453/bg_pagination.jpg);}

/* visual */
.heySomething .visual .figure {background-color:#fce7cf;}
.heySomething #slider {width:100%; height:240px; margin-top:20px;}
.heySomething #slider .slide-img {width:240px; height:240px; margin:0 40px;}

/* brand */
.heySomething .brand {height:590px;}

/* story */
.heySomething .rolling .pagination {width:960px; margin-left:-480px;}
.heySomething .rolling .swiper-pagination-switch {margin:0 10px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/hey/66453/bg_ico.png);}

.heySomething .rolling .pagination span em {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/hey/66453/txt_story_desc.png);}

/* finish */
.heySomething .finish {background-color:#f8f8f8;}
.heySomething .finish p {top:103px; left:50%; z-index:10; margin-left:-185px; width:340px; height:197px;}
.heySomething .finish p strong {width:340px; background:transparent url(http://webimage.10x10.co.kr/eventIMG/2015/hey/66453/txt_finish.png) no-repeat 50% 0;}
.heySomething .finish p .letter1 {height:106px;}
.heySomething .finish p .letter2 {margin-top:42px; height:48px;}
.heySomething .finish p span {margin:0 auto; background-color:#d8d8d8;}
.heySomething .finish .bg {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/hey/66453/img_item_finish.jpg);}

/* comment */
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/hey/66453/bg_ico.png);}

.heySomething .commentlist table td strong {background:url(http://webimage.10x10.co.kr/eventIMG/2015/hey/66453/bg_ico.png) no-repeat 0 -32px;}
.commentlist table td .ico2 {background-position:-150px -32px;}
.commentlist table td .ico3 {background-position:-300px -32px;}
.commentlist table td .ico4 {background-position:-450px -32px;}
.commentlist table td .ico5 {background-position:-600px -32px;}
.commentlist table td .ico6 {background-position:100% -32px;}
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
		<% If not( left(currenttime,10)>="2015-10-13" and left(currenttime,10)<"2015-10-22" ) Then %>
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
<% If Not(Trim(hspchk(1)))="hsproject" Then %>
<div class="evt66637">
	<div class="heySomething">
<% End If %>
		<%' title, nav %>
		<div class="topic">
			<h2>
				<span class="letter1">Hey,</span>
				<span class="letter2">something</span>
				<span class="letter3">project</span>
				<!--span class="letter4">DESIGN FINGERS VOL.2</span-->
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
			<div class="bnr"><a href="/street/street_brand_sub06.asp?makerid=lonazapatillas"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/66453/img_item_represent.jpg" alt="lona" /></a></div>
		</div>

		<%' about %>
		<div class="about">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
			<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
		</div>

		<%' item %>
		<div class="item itemB">
			<div class="inner">
				<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/66453/tit_lona.png" alt="lona" /></h3>
				<div class="desc">
					<%' 상품 이름, 가격, 구매하기 %>
					<div class="option">
						<em class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/66453/txt_name.png" alt="Lona Mujer" /></em>
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

						<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/66453/txt_substance.png" alt="지역발전에 일조한 창의적 혁신 세 친구의 행복한 콜라보레이션" /></p>
						<div class="btnget"><a href="/street/street_brand_sub06.asp?makerid=lonazapatillas"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러 가기" /></a></div>
					</div>

					<%' slide %>
					<div class="slidewrap">
						<div id="slide" class="slide">
							<div><a href="/street/street_brand_sub06.asp?makerid=lonazapatillas"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/66453/img_figure_01.jpg" alt="" /></a></div>
							<div><a href="/street/street_brand_sub06.asp?makerid=lonazapatillas"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/66453/img_figure_02.jpg" alt="" /></a></div>
							<div><a href="/street/street_brand_sub06.asp?makerid=lonazapatillas"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/66453/img_figure_03.jpg" alt="" /></a></div>
							<div><a href="/street/street_brand_sub06.asp?makerid=lonazapatillas"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/66453/img_figure_04.jpg" alt="" /></a></div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<%' visual %>
		<div class="visual">
			<div class="figure"><a href="/street/street_brand_sub06.asp?makerid=lonazapatillas"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/66453/img_item_visual_big.jpg" alt="" /></a></div>

			<div id="slider" class="slider-horizontal">
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1282696"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/66453/img_item_visual_01.jpg" alt="Negra" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1282695"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/66453/img_item_visual_02.jpg" alt="Crema" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1282684"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/66453/img_item_visual_03.jpg" alt="Estampada" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1282677"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/66453/img_item_visual_04.jpg" alt="Terracota" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1282674"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/66453/img_item_visual_05.jpg" alt="Indigo" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1282657"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/66453/img_item_visual_06.jpg" alt="Blanca" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1282656"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/66453/img_item_visual_07.jpg" alt="Burdeo" /></a>
				</div>
			</div>
		</div>

		<%' brand %>
		<div class="brand">
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/66453/txt_brand.png" alt="각기 다른 분야의 세 친구가 만나 칠레 스니커즈 브랜드 로나가 탄생합니다. 가방 브랜드 코요테, 리빙 디자인그룹 밍카 인-하우스 그리고 자파테리아 마에스트라라는 슈즈 제작 전문 공장, 이 셋의 실험적인 협업으로 로나가 탄생합니다. 이들은 브랜드 발전을 위해 고민하던 중 작은 변화가 지역 사회에 도움이 될 수 있다는 것을 깨닫고 일자리 창출을 위해 생산만큼은 현지에서 이루어져야 한다는 것을 브랜드 철학으로 삼게 됩니다. 나아가 지역 마스터 장인들의 손재주를 활용한다는 것은 로나의 큰 자부심이 됩니다. 로나는 지역발전에 일조한 창의적 혁신이자 세 친구의 행복한 콜라보레이션 작업입니다." /></p>
			<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="" /></div>
		</div>

		<%' story %>
		<div class="story">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/66453/tit_story.png" alt="세 친구의 행복한 콜라보레이션" /></h3>
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
									<a href="/street/street_brand_sub06.asp?makerid=lonazapatillas"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/66453/img_slide_01.jpg" alt="쿠션 처리된 인솔은 발의 피로를 덜어주고 두툼한 밑창은 편안한 착화감을 선물합니다." /></a>
								</div>
								<div class="swiper-slide">
									<a href="/street/street_brand_sub06.asp?makerid=lonazapatillas"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/66453/img_slide_02.jpg" alt="어디에든 무난하게 어울리는 베이직한 디자인의 로나는 이제 당신의 데일리 슈즈로 거듭납니다." /></a>
								</div>
								<div class="swiper-slide">
									<a href="/street/street_brand_sub06.asp?makerid=lonazapatillas"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/66453/img_slide_03.jpg" alt="작은 파우치가 가져다줄 작지만 큰 변화, 구두는 포기할 수 없지만 산책의 여유는 포기하지 마세요." /></a>
								</div>
								<div class="swiper-slide">
									<a href="/street/street_brand_sub06.asp?makerid=lonazapatillas"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/66453/img_slide_04.jpg" alt="로나슈즈는 천연 코튼 캔버스로 제작됩니다. 소재의 낭비를 최소화하기 위해 재단부터 심혈을 기울입니다." /></a>
								</div>
								<div class="swiper-slide">
									<a href="/street/street_brand_sub06.asp?makerid=lonazapatillas"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/66453/img_slide_05.jpg" alt="지역 발전에 일조한 로나의 자부심 MADE IN CHILE 로나슈즈는 마스터 장인의 기술을 이용하여 정성껏 제작됩니다." /></a>
								</div>
								<div class="swiper-slide">
									<a href="/street/street_brand_sub06.asp?makerid=lonazapatillas"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/66453/img_slide_06.jpg" alt="좋은 곳으로, 향기가 가득한 길로 데려가 줄 좋은 신발입니다. 오랫동안 함께 가는 신발을 선물하세요." /></a>
								</div>
							</div>
						</div>
					</div>
					<div class="pagination"></div>
				</div>
			</div>
		</div>

		<%' finish %>
		<div class="finish">
			<a href="/street/street_brand_sub06.asp?makerid=lonazapatillas">
				<p>
					<strong class="letter1">세 친구의 행복한 콜라보레이션</strong>
					<span></span>
					<strong class="letter2">lona</strong>
				</p>
				<div class="bg"></div>
			</a>
		</div>

		<%' comment %>
		<div class="commentevet">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/66453/tit_want.png" alt="Hey, something project 당신이 갖고 싶은 것" /></h3>
			<p class="hidden">정성껏 코멘트를 남겨주신 3분을 추첨하여 Lona 슈즈를 선물로 드립니다. 코멘트 기재시, 사이즈 기재 필수이며, 컬러는 랜덤으로 배송됩니다. 기간 : 2015.10.07 ~ 10.14 / 발표 : 10.15</p>

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
					<legend>Lona 슈즈 코멘트 쓰기</legend>
						<ul class="choice">
							<li class="ico1"><button type="button" value="1">Comfort</button></li>
							<li class="ico2"><button type="button" value="2">Basic</button></li>
							<li class="ico3"><button type="button" value="3">Easy</button></li>
							<li class="ico4"><button type="button" value="4">Eco</button></li>
							<li class="ico5"><button type="button" value="5">Local</button></li>
							<li class="ico6"><button type="button" value="6">Together</button></li>
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

			<%' commentlist %>
			<div class="commentlist" id="commentlist">
				<p class="total">total <%= iCTotCnt %></p>
				<% IF isArray(arrCList) THEN %>
					<table>
						<caption>Lona 슈즈 코멘트 목록</caption>
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
												Comfort
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="2" then %>
												Basic
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="3" then %>
												Easy
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="4" then %>
												Eco
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="5" then %>
												Local
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="6" then %>
												Together
											<% Else %>
												Comfort
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
					<%' paging %>
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
	})

	$('.arrow-left').on('click', function(e){
		e.preventDefault()
		swiper1.swipePrev()
	})
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
		if (scrollTop > 3300 ) {
			brandAnimation()
		}
		if (scrollTop > 5900 ) {
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
		$(".heySomething .brand p").delay(500).animate({"height":"448px", "opacity":"1"},1800);
		$(".heySomething .brand .btnDown").delay(3000).animate({"margin-top":"62px", "opacity":"1"},800);
	}

	/* finish animation */
	$(".heySomething .finish p strong").css({"opacity":"0"});
	$(".heySomething .finish p .letter1").css({"margin-top":"7px"});
	$(".heySomething .finish p .letter2").css({"margin-top":"49px"});
	$(".heySomething .finish p span").css({"width":"0"});
	$(".heySomething .finish .bg").css({"opacity":"0.3"});
	function finishAnimation() {
		$(".heySomething .finish p .letter1").delay(300).animate({"margin-top":"0", "opacity":"1"},800);
		$(".heySomething .finish p .letter2").delay(700).animate({"margin-top":"42px", "opacity":"1"},800);
		$(".heySomething .finish p span").delay(1000).animate({"width":"68px", "opacity":"1"},1000);
		$(".heySomething .finish .bg").delay(1000).animate({"opacity":"1"},2000);
	}
});

</script>

<%
set oItem=nothing
'set oItem2=nothing
'set oItem3=nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->