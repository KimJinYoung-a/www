<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'###########################################################
' Description : hey, something project 시리즈 85 Hello Brown!
' History : 2017-09-05 정태훈 생성
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
	eCode   =  66422
Else
	eCode   =  80243
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
.heySomething .topic {text-align:center; background-color:#38c781; z-index:1;}

/* brand */
.heySomething .brand {position:relative; height:975px; margin:330px 0 380px; text-align:center;}
.heySomething .brand p {margin-top:90px;}
.heySomething .brand .btnDown {margin-top:58px;}

/* item */
.heySomething .item {width:1140px; margin:0 auto;}
.heySomething .item .desc {position:relative; width:1050px; margin:108px auto 0;}
.heySomething .item .option {height:auto; padding:18px 0 436px;}
.heySomething .item .option .substance {position:static; margin-top:36px;}
.heySomething .item .option .btnget {position:static; margin-top:35px;}
.heySomething .item .option {text-align:left;} 
.heySomething .item .slide {position:absolute; right:0; top:0; overflow:visible !important; width:560px; height:522px;}
.heySomething .item .slide .slidesjs-pagination {position:absolute; left:0; bottom:-73px; width:100%; text-align:left;}
.heySomething .item .slide .slidesjs-pagination li {display:inline-block; padding-right:20px;}
.heySomething .item .slide .slidesjs-pagination li a {display:inline-block; width:52px; height:52px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/80243/img_small_prd.jpg) no-repeat 0 0;text-indent:-999em;}
.heySomething .item .slide .slidesjs-pagination li:first-child + li a {background-position:-72px 0;}
.heySomething .item .slide .slidesjs-pagination li:first-child + li + li a {background-position:-145px 0;}
.heySomething .item .slide .slidesjs-pagination li:first-child + li + li + li a {background-position:100% 0;}
.heySomething .item .slide .slidesjs-pagination li a.active {background-position:0 100%;}
.heySomething .item .slide .slidesjs-pagination li:first-child + li a.active {background-position:-72px 100%;}
.heySomething .item .slide .slidesjs-pagination li:first-child + li + li a.active {background-position:-145px 100%;}
.heySomething .item .slide .slidesjs-pagination li:first-child + li + li + li a.active {background-position:100% 100%;}

/* intro */
.intro {position:relative; height:538px; margin-bottom:365px; background:#fce9c2 url(http://webimage.10x10.co.kr/eventIMG/2017/hey/80243/bg_yellow.jpg) no-repeat 50% 0;}
.intro span {position:absolute; top:190px; left:50%; margin-left:-547px;}
.intro span:first-child + span {top:247px;}
.intro span:first-child + span + span{top:302px;}

/* function */
.function {width:906px; margin:0 auto; padding:94px 104px; border:solid 12px #fafafa;}

/* story */
.heySomething .story {margin-top:392px; padding-bottom:130px;}
.heySomething .rollingwrap {margin-top:0;}
.heySomething .rolling {padding-top:114px;}
.heySomething .rolling .pagination {top:0; padding-left:45px;}
.heySomething .rolling .pagination span {width:192px; height:63px; margin:0 15px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/80243/bg_ico_1.png);}
.heySomething .rolling .pagination span:first-child {background-position:0 0;}
.heySomething .rolling .pagination span:first-child.swiper-active-switch {background-position:0 100%;}
.heySomething .rolling .pagination span:first-child + span {background-position:-222px 0;}
.heySomething .rolling .pagination span:first-child + span.swiper-active-switch {background-position:-222px 100%;}
.heySomething .rolling .pagination span:first-child + span + span {background-position:-444px 0;}
.heySomething .rolling .pagination span:first-child + span + span.swiper-active-switch {background-position:-444px 100%;}
.heySomething .rolling .pagination span:first-child + span + span + span{background-position:100% 0;}
.heySomething .rolling .pagination span:first-child + span + span + span.swiper-active-switch{background-position:100% 100%;}
.heySomething .rolling .pagination span em {bottom:-820px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/80243/txt_desc.png); cursor:default;}
.heySomething .rolling .btn-nav {top:457px;}
.heySomething .swipemask {top:114px; background-color:#fff;}

/* comment */
.heySomething .commentevet {margin-top:350px;}
.heySomething .commentevet textarea {margin-top:20px;}
.heySomething .commentevet .form {margin-top:10px;}
.heySomething .commentevet .form .choice {margin-left:-10px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/80243/bg_ico_2.png);}
.heySomething .commentlist table td strong {height:110px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/80243/bg_ico_3.png); background-position:0 0;}
.heySomething .commentlist table td .ico2 {background-position:0 -111px;}
.heySomething .commentlist table td .ico3 {background-position:0 -222px;}
.heySomething .commentlist table td .ico4 {background-position:0 100%}
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
		<% If not( left(currenttime,10)>="2017-09-05" and left(currenttime,10)<"2017-09-13" ) Then %>
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
					<div class="bnr"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80243/img_item_represent.jpg" alt="브라이언 스마트펜" /></div>
				</div>

				<!-- about -->
				<div class="about">
					<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
					<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
				</div>

				<!-- brand -->
				<div class="brand">
					<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80243/img_brand.jpg" alt="" />
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80243/txt_brand.jpg" alt="neo smartpen 우리는 종이에 디지털 정보를 저장하는 Ncode 기술을 바탕으로종이에 그려지는 펜의 움직임을 연구합니다 Ncode 기술로 펜으로 책을 읽어 주거나, 볼펜으로 노트에 기록한 내용을 디지털화하여 저장/전송하는 솔루션으로 새로운 가치를 창출하고 펜과 종이(paper 2.0)의 역사를 이어가려 합니다." /></p>
					<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="우리는 종이에 디지털 정보를 저장하는 Ncode 기술을 바탕으로 종이에 그려지는 펜의 움직임을 연구합니다" /></div>
				</div>
				<%
					IF application("Svr_Info") = "Dev" THEN
						itemid = 1239226
					Else
						itemid = 1782554
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
				%>
				<!-- item -->
				<div class="item">
					<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80243/tit_neo.jpg" alt="Neo smartpen 콜라보 10x10" /></h3>
					<div class="desc">
						<div class="option">
							<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80243/txt_name.png" alt="Hello Brown! 네오 스마트펜, 브라운과 만나다" /></p>
							<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80243/txt_substance.png" alt="네오 스마트펜 브라운 리미티드 에디션(텐바이텐 단독 선오픈/한정수량) 네오스마트팬 브라운 리미티드 에디션 구매시 N 프로페셔널미니노트를 증정합니다. 사이즈 길이 149.6mm / 두께 10.4-10.9mm 무게 17.4g(펜캡제외) 구성 네오스마트펜 M1 / 브라운 피규어 / N Brown notebook 충전 전용 이블 / 리필펜팁 / 사용설명서 ※ 리필펜팁은 D1타입의 스탠다드 펜심입니다(몽블랑,파카,라미, 파이로트, 제브라 등)" /></p>
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
							<div class="btnget"><a href="/shopping/category_prd.asp?itemid=1782554&amp;pEtr=80243"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러가기" /></a></div>
						</div>
						<div class="slide">
							<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80243/img_item1.jpg" alt="Hello Brown! 네오 스마트펜" />
							<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80243/img_item2.jpg" alt="Hello Brown! 네오 스마트펜" />
							<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80243/img_item3.jpg" alt="Hello Brown! 네오 스마트펜" />
							<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80243/img_item4.jpg" alt="Hello Brown! 네오 스마트펜" />
						</div>
					</div>
				</div>
				<!--// item -->
				<%	set oItem = nothing %>
				<div class="intro">
					<a href="/shopping/category_prd.asp?itemid=1782554&pEtr=80243">
						<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80243/txt_intro1.png" alt="라인프렌즈 브라운과 캐주얼한 옷으로 갈아입은" /></span>
						<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80243/txt_intro2.png" alt="네오 스마트펜의 특별한 만남!" /></span>
						<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80243/txt_intro3.png" alt="이제 종이에 쓰고 디지털로 저장하세요" /></span>
					</a>
				</div>

				<div class="function">
					<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80243/txt_how_to.jpg" alt="종이 위의 모든 아이디어를 디지털화해 보세요 앱은 꺼두셔도 되요 네오스마트펜의 전원만 켜주세요 손으로 쓴 글씨도 타이핑한 텍스트로 변환해줍니다 필기와 동시에 현장음을 녹음 저장해 보세요 종이에 필기하고 수정/편집은 스마트폰에서전용 어플리케이션 NEO NOTES로 모든 필기를 쉽게 관리하세요" />
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
										<div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1782554&amp;pEtr=80243"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80243/img_slide_1.jpg" alt="package 네오 스마트펜 라인프렌즈 에디션은 캐주얼한 디자인을 바탕으로 브라운을 상징하는 컬러를 패키지에 적용하였습니다" /></a></div>
										<div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1782554&amp;pEtr=80243"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80243/img_slide_2.jpg" alt="smartpen 네오 스마트펜 라인프렌즈 에디션은 세계에서 가장 얇은 광학식 필기펜으로 특별함에 특별함을 더했습니다" /></a></div>
										<div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1782554&amp;pEtr=80243"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80243/img_slide_3.jpg" alt="notebook 노트 우측 상단의 라인 아이콘을 체크하면 해당 페이지는 라인 앱을 통해 쉽고 간편하게 공유 할 수 있습니다 (이메일 박스 체크 시 해당 페이지 자동 이메일 전송 가능)" /></a></div>
										<div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1782554&amp;pEtr=80243"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80243/img_slide_4.jpg" alt="kidult 브라운 피규어 악세서리는 네오스마트펜 상단 부분에 끼워 사용할 수 있는 아이템으로, 오직 네오 스마트펜 라인프렌즈 에디션에서만 만나 볼 수 있습니다" /></a></div>
									</div>
								</div>
							</div>
							<div class="pagination"></div>
						</div>
					</div>
				</div>

				<!-- comment -->
				<div class="commentevet">
					<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/80243/tit_comment.png" alt="Hey, something project, 네오 스마트펜 라인프렌즈 에디션의 가장 기대되는점은 무엇인가요?" /></h3>
					<p class="hidden">네오 스마트펜 라인프렌즈 에디션에 가장 기대되는 기능은 무엇인가요? 정성껏 코멘트를 남겨주신 3분을 추첨하여, 1등(1명) 네오스마트펜 N2 / 2등(2명) N 프로페셔널 노트를 증정합니다</p>
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
									<li class="ico1"><button type="button" value="1">#Package</button></li>
									<li class="ico2"><button type="button" value="2">#smart pen</button></li>
									<li class="ico3"><button type="button" value="3">#note book</button></li>
									<li class="ico4"><button type="button" value="4">#kidult</button></li>
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
									#Package
									<% elseif split(arrCList(1,intCLoop),"!@#")(0)="2" then %>
									#smart pen
									<% elseif split(arrCList(1,intCLoop),"!@#")(0)="3" then %>
									#note book
									<% elseif split(arrCList(1,intCLoop),"!@#")(0)="4" then %>
									#kidult
									<% else %>
									#Package
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
				<!-- // 수작업 영역 끝 -->
<script type="text/javascript">
$(function(){
	$(".item .slide").slidesjs({
		width:"560",
		height:"522",
		pagination:{effect:"fade"},
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
		if (scrollTop > 3100 ) {
			txtAni();
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
	$(".intro span").css({"opacity":"0"});
	$(".intro span:nth-child(1)").css({"margin-top":"7px"});
	$(".intro span:nth-child(2)").css({"margin-top":"15px"});
	$(".intro span:nth-child(3)").css({"margin-top":"23px"});
	function txtAni() {
		$(".intro span:nth-child(1)").delay(300).animate({"margin-top":"0", "opacity":"1"},800);
		$(".intro span:nth-child(2)").delay(700).animate({"margin-top":"0", "opacity":"1"},800);
		$(".intro span:nth-child(3)").delay(1100).animate({"margin-top":"0", "opacity":"1"},800);
	}
});
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->