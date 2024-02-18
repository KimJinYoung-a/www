<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈
' History : 2016-10-11 유태욱 생성
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
	'currenttime = #10/07/2015 09:00:00#

dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  66219
Else
	eCode   =  73551
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
.heySomething .topic {background-color:#acadb1; z-index:1;}

/* item */
.heySomething .itemB {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/73551/bg_line.png);}
.heySomething .itemB h3 {margin-bottom:64px;}
.heySomething .itemB .desc {min-height:480px; padding-left:0;}
.heySomething .itemB .desc .option {top:12px;}
.heySomething .itemB .slidewrap {width:980px; margin:0 auto; padding-top:0px;}
.heySomething .itemB .slidewrap .slide {width:980px; height:480px; padding-left:0px;}
.heySomething .itemB .slidewrap .slidesjs-pagination {bottom:-263px;}
.heySomething .itemB .slidewrap .slidesjs-pagination li a {height:156px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/73551/bg_pagination.jpg);}
.heySomething .itemB .slidewrap .slide .slidesjs-previous {left:470px;}
.heySomething .itemB .slidewrap .slide .slidesjs-slide {overflow:hidden;}
.heySomething .itemB .slidewrap .slide .price {position:absolute; left:0; top:203px; font-size:20px; color:#000; font-family:verdana, tahoma, sans-serif;}
.heySomething .itemB .slidewrap .slide .pic {float:right; padding-right:74px;}
.heySomething .itemB .slidewrap .slide .goGet {display:block; position:absolute; left:0; bottom:45px; width:202px; height:42px; text-indent:-999px;}

/* brand */
.heySomething .goBuy .pic {height:700px; margin:400px 0 95px; background:#f2f2f2 url(http://webimage.10x10.co.kr/eventIMG/2016/hey/73551/img_bigmon.jpg) 50% 0 no-repeat;}
.heySomething .brand {position:relative; height:980px; margin-top:240px;}
.heySomething .brand .pic {padding:75px 0 52px;}

/* story */
.heySomething .story {margin-top:220px; padding-bottom:120px;}
.heySomething .story h3 {margin-bottom:50px;}
.heySomething .rolling {padding-top:200px;}
.heySomething .rolling .swiper-pagination-switch {width:150px; height:170px; margin:0 15px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/73551/bg_ico_01.jpg);}
.heySomething .rolling .pagination {top:0; padding-left:130px;}
.heySomething .rolling .pagination span em {bottom:-780px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/73551/txt_story_desc.png); cursor:default;}
.heySomething .rolling .pagination span:first-child {background-position:0 0;}
.heySomething .rolling .pagination span.swiper-active-switch {background-position:0 -170px;}
.heySomething .rolling .pagination span:first-child + span {background-position:-150px 0;}
.heySomething .rolling .pagination span:first-child + span.swiper-active-switch {background-position:-150px -170px;}
.heySomething .rolling .pagination span:first-child + span + span {background-position:-300px 0;}
.heySomething .rolling .pagination span:first-child + span + span.swiper-active-switch {background-position:-300px -170px;}
.heySomething .rolling .pagination span:first-child + span + span + span {background-position:-450px 0;}
.heySomething .rolling .pagination span:first-child + span + span + span.swiper-active-switch {background-position:-450px -170px;}
.heySomething .rolling .pagination span:first-child + span + span + span + span {background-position:-600px 0;}
.heySomething .rolling .pagination span:first-child + span + span + span + span.swiper-active-switch {background-position:-600px -170px;}
.heySomething .rolling .btn-nav {top:450px;}
.heySomething .swipemask {top:200px;}

/* finish */
.heySomething .finish {height:auto; margin-top:410px; text-align:center; background:#fff;}

/* comment */
.heySomething .commentevet textarea {margin-top:40px;}
.heySomething .commentevet .form {margin-top:45px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/73551/bg_ico_02.jpg);}

.heySomething .commentlist table td strong {height:150px; margin-top:-20px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/73551/bg_ico_02.jpg); background-position:0 0;}
.heySomething .commentlist table td .ico2 {background-position:-150px 0;}
.heySomething .commentlist table td .ico3 {background-position:-300px 0;}
.heySomething .commentlist table td .ico4 {background-position:-450px 0;}
</style>
<script type='text/javascript'>

$(function(){
	<% if pagereload<>"" then %>
		//pagedown();
		setTimeout("pagedown()",500);
	<% end if %>
});

function pagedown(){
	window.$('html,body').animate({scrollTop:$("#commentlist").offset().top}, 0);
}

function jsGoComPage(iP){
	document.frmcom.iCC.value = iP;
	document.frmcom.iCTot.value = "<%=iCTotCnt%>";
	document.frmcom.submit();
}

function jsSubmitComment(frm){
	<% If IsUserLoginOK() Then %>
		<% If not( left(currenttime,10)>="2016-10-11" and left(currenttime,10)<"2016-10-19" ) Then %>
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
			<div class="bnr"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73551/img_item_represent.jpg" alt="STICKY MONSTER LAB" /></div>
		</div>

		<%' about %>
		<div class="about">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
			<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
		</div>

		<%' item %>
		<div class="item itemB">
			<div class="inner">
				<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73551/tit_sml_3rd.png" alt="STICKY MONSTER LAB X 3RD ROUND" /></h3>
				<div class="desc">
					<div class="option">
						<em class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73551/txt_name.png" alt="[SML X 3RD ROUND] SML LIFE" /></em>
						<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73551/txt_substance.png" alt="대세 창작 스튜디오 Sticky Monster Lab과 3rd Round의 합작! 스티키 몬스터랩의 두번째 패브릭인형을 텐바이텐에서 가장 먼저 만나보세요" /></p>
						<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러 가기" /></div>
					</div>
					<div class="slidewrap">
						<div id="slide01" class="slide">
						<%
							itemid = 1576373
							set oItem = new CatePrdCls
								oItem.GetItemData itemid
						%>
							<div>
								<!-- 1576373 -->
								<% If oItem.FResultCount > 0 Then %>
									<div class="price"><strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong></div>
								<% End If %>
								<a href="/shopping/category_prd.asp?itemid=1576373&amp;pEtr=73551" class="pic"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73551/img_item_01.jpg" alt="" /></a>
								<a href="/shopping/category_prd.asp?itemid=1576373&amp;pEtr=73551" class="goGet">구매하러 가기</a>
							</div>
						<% set oItem=nothing %>

						<%
							itemid = 1576368
							set oItem = new CatePrdCls
								oItem.GetItemData itemid
						%>
							<div>
								<!-- 1576365 -->
								<% If oItem.FResultCount > 0 Then %>
									<div class="price"><strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong></div>
								<% End If %>
								<a href="/shopping/category_prd.asp?itemid=1576368&amp;pEtr=73551" class="pic"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73551/img_item_02.jpg" alt="" /></a>
								<a href="/shopping/category_prd.asp?itemid=1576368&amp;pEtr=73551" class="goGet">구매하러 가기</a>
							</div>
						<% set oItem=nothing %>

						<%
							itemid = 1576365
							set oItem = new CatePrdCls
								oItem.GetItemData itemid
						%>
							<div>
								<!-- 1576372 -->
								<% If oItem.FResultCount > 0 Then %>
									<div class="price"><strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong></div>
								<% End If %>
								<a href="/shopping/category_prd.asp?itemid=1576365&amp;pEtr=73551" class="pic"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73551/img_item_03.jpg" alt="" /></a>
								<a href="/shopping/category_prd.asp?itemid=1576365&amp;pEtr=73551" class="goGet">구매하러 가기</a>
							</div>
						<% set oItem=nothing %>

						<%
							itemid = 1506304
							set oItem = new CatePrdCls
								oItem.GetItemData itemid
						%>
							<div>
								<!-- 1506304 -->
								<% If oItem.FResultCount > 0 Then %>
									<div class="price"><strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong></div>
								<% End If %>
								<a href="/shopping/category_prd.asp?itemid=1506304&amp;pEtr=73551" class="pic"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73551/img_item_04.jpg" alt="" /></a>
								<a href="/shopping/category_prd.asp?itemid=1506304&amp;pEtr=73551" class="goGet">구매하러 가기</a>
							</div>
						<% set oItem=nothing %>
						</div>
					</div>
				</div>
			</div>
		</div>

		<%' brand %>
		<div class="goBuy">
			<div class="pic"></div>
			<div class="ct">
				<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73551/img_go_sml.jpg" alt="" usemap="#smlMap" />
				<map name="smlMap" id="smlMap">
					<area shape="rect" coords="11,249,153,282" href="/shopping/category_prd.asp?itemid=1576373&amp;pEtr=73551" onfocus="this.blur();" />
					<area shape="rect" coords="11,284,153,317" href="/shopping/category_prd.asp?itemid=1576372&amp;pEtr=73551" onfocus="this.blur();" />
					<area shape="rect" coords="12,320,152,352" href="/shopping/category_prd.asp?itemid=1576370&amp;pEtr=73551" onfocus="this.blur();" />
					<area shape="rect" coords="283,251,430,281" href="/shopping/category_prd.asp?itemid=1576365&amp;pEtr=73551" onfocus="this.blur();" />
					<area shape="rect" coords="283,282,432,318" href="/shopping/category_prd.asp?itemid=1576363&amp;pEtr=73551" onfocus="this.blur();" />
					<area shape="rect" coords="283,321,431,351" href="/shopping/category_prd.asp?itemid=1576361&amp;pEtr=73551" onfocus="this.blur();" />
					<area shape="rect" coords="563,251,711,283" href="/shopping/category_prd.asp?itemid=1576368&amp;pEtr=73551" onfocus="this.blur();" />
					<area shape="rect" coords="561,285,712,318" href="/shopping/category_prd.asp?itemid=1576367&amp;pEtr=73551" onfocus="this.blur();" />
					<area shape="rect" coords="561,320,710,353" href="/shopping/category_prd.asp?itemid=1576366&amp;pEtr=73551" onfocus="this.blur();" />
					<area shape="rect" coords="841,250,988,282" href="/shopping/category_prd.asp?itemid=1506304&amp;pEtr=73551" onfocus="this.blur();" />
					<area shape="rect" coords="841,283,985,318" href="/shopping/category_prd.asp?itemid=1506305&amp;pEtr=73551" onfocus="this.blur();" />
					<area shape="rect" coords="842,320,984,351" href="/shopping/category_prd.asp?itemid=1506306&amp;pEtr=73551" onfocus="this.blur();" />
				</map>
			</div>
		</div>
		<div class="brand">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73551/tit_sml.png" alt="STICKY MONSTER LAB" /></h3>
			<div class="pic"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73551/img_brand.jpg" alt="" /></div>
			<p class="text"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73551/txt_brand.png" alt="STICKY MONSTER LAB - 그들은 다양한 창작자들로 구성되어 2007년에 설립된 창의적인 스튜디오입니다. 우리의 현실을 반영하여 공감할 수 있을만한 괴물 세계의 일상 애니메이션을 생산했습니다. 현재 그들은 일러스트레이션, 그래픽 디자인, 제품 디자인 등 다방면에서 활동하며 여러 분야에서 두각을 나타내고 있습니다." /></p>
			<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="" /></div>
		</div>

		<%' story %>
		<div class="story">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73551/tit_story.png" alt="함께 하면 행복한 SML" /></h3>
			<div class="rollingwrap">
				<div class="rolling rolling1">
					<div class="swipemask mask-left"></div>
					<div class="swipemask mask-right"></div>
					<button type="button" class="btn-nav arrow-left">Previous</button>
					<button type="button" class="btn-nav arrow-right">Next</button>
					<div class="swiper">
						<div class="swiper-container swiper1">
							<div class="swiper-wrapper">
								<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73551/img_slide_01.jpg" alt="#YELLOW - 데굴데굴 굴러다닐 듯 동글동글 귀여운 옐로우 몬" /></div>
								<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73551/img_slide_02.jpg" alt="#BIRD - 뒤뚱뒤뚱 귀여운 자태의 바디와 깜찍한 부리가 매력 포인트!" /></div>
								<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73551/img_slide_03.jpg" alt="#BIG - 보기만 해도 푸근한 빅몬, 널 끌어안으면 세상을 다 가진듯해" /></div>
								<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73551/img_slide_04.jpg" alt="#RED - SML의 대표적인 캐릭터 레드몬! 보면 볼 수록 행복해지는 귀여운 페이스" /></div>
							</div>
						</div>
					</div>
					<div class="pagination"></div>
				</div>
			</div>
		</div>

		<%' finish %>
		<div class="finish">
			<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73551/img_finish.jpg" alt="언제 어디서나 함께해도 웃음 짓게 하는 너-" /></div>
		</div>

		<%' comment %>
		<div class="commentevet">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/73551/tit_comment.png" alt="Hey, something project 함께 하면 행복한 SML" /></h3>
			<p class="hidden">당신이 함께 하고 싶은 캐릭터는 어떤 캐릭터인가요? 정성껏 코멘트를 남겨주신 10분을 추첨하여 SML 사인 인형을 선물로 드립니다.</p>
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
							<li class="ico1"><button type="button" value="1">#YELLOW</button></li>
							<li class="ico2"><button type="button" value="2">#BIRD</button></li>
							<li class="ico3"><button type="button" value="3">#BIG</button></li>
							<li class="ico4"><button type="button" value="4">#RED</button></li>
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
							<% If isarray(split(arrCList(1,intCLoop),"!@#")) Then %>
								<strong class="ico<%= split(arrCList(1,intCLoop),"!@#")(0) %>">
									<% If split(arrCList(1,intCLoop),"!@#")(0)="1" Then %>
										#마셔보다
									<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="2" Then %>
										#선물해보다
									<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="3" Then %>
										#만들어보다
									<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="4" Then %>
										#나눠보다
									<% End If %>
								</strong>
							<% End If %>
							</td>
							<td class="lt">
							<% If isarray(split(arrCList(1,intCLoop),"!@#")) Then %>
								<% If ubound(split(arrCList(1,intCLoop),"!@#")) > 0 Then %>
									<%=ReplaceBracket(db2html( split(arrCList(1,intCLoop),"!@#")(1) ))%>
								<% End If %>
							<% End If %>
							</td>
							<td><%= FormatDate(arrCList(4,intCLoop),"0000.00.00") %></td>
							<td>
								<em><%=printUserId(arrCList(2,intCLoop),2,"*")%></em>
								<% If ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") Then %>
									<button type="button" onclick="jsDelComment('<% = arrCList(0,intCLoop) %>'); return false;" class="btndel"><img src="http://fiximage.10x10.co.kr/web2013/event/btn_cmt_close.gif" alt="코멘트 삭제"></button>
								<% End If %>
								<% If arrCList(8,intCLoop) <> "W" Then %>
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
		<!-- // 수작업 영역 끝 -->
<% If Not(Trim(hspchk(1)))="hsproject" Then %>
	</div>
<% End If %>
<script type="text/javascript">
$(function(){
	/* slide js */
	$("#slide01").slidesjs({
		width:"980",
		height:"480",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:2500, effect:"fade", auto:true},
		effect:{fade: {speed:900, crossfade:true}
		},
		callback: {
			complete: function(number) {
				var pluginInstance = $('#slide01').data('plugin_slidesjs');
				setTimeout(function() {
					pluginInstance.play(true);
				}, pluginInstance.options.play.interval);
			}
		}
	});
	$(".slidesjs-pagination li:nth-child(1)").addClass("num01");
	$(".slidesjs-pagination li:nth-child(2)").addClass("num02");
	$(".slidesjs-pagination li:nth-child(3)").addClass("num03");
	$(".slidesjs-pagination li:nth-child(4)").addClass("num04");

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
<!-- #include virtual="/lib/db/dbclose.asp" -->