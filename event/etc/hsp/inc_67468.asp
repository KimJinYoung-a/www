<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈 11
' History : 2015-11-17 유태욱 생성
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
	eCode   =  65950
Else
	eCode   =  67468
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
	itemid   =  1387369
End If

dim oItem
set oItem = new CatePrdCls
	oItem.GetItemData itemid

Dim hspchk
'// 현재 주소값 체크하여 신규, 구버전 확인
hspchk = Split(LCase(Request.ServerVariables("PATH_INFO")),"/")
%>
<style type="text/css">
/* title */
.heySomething .topic {background-color:#f7f4eb;}

/* item */
.heySomething .slidewrap {width:570px; padding-top:85px;}
.heySomething .slidesjs-pagination li a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/hey/67468/bg_pagination_v1.jpg);}

/* visual */
.heySomething .visual .figure {background-color:#090607;}
.heySomething #slider {height:193px;}
.heySomething #slider .slide-img {width:252px; height:193px; margin:0 37px;}

/* brand */
.heySomething .brand {position:relative; height:517px;}
.heySomething .brand .name {position:absolute; left:50%; top:0;  width:662px; height:62px; margin-left:-331px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/hey/67468/txt_intro_laundry.png) no-repeat 0 0; text-indent:-999em;}
.heySomething .brand .name span {display:block; position:absolute; right:0; top:16px; width:33px; height:31px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/hey/67468/txt_intro_plus.png) no-repeat 0 0; text-indent:-999em;}

/* story */
.heySomething .story {padding-bottom:0;}
.heySomething .rolling {width:100%; height:auto;}
.heySomething .rolling .bg {width:100%;}
.heySomething .rolling .slidesjs-pagination {position:absolute; left:50%; top:0; width:1290px; margin-left:-645px;}
.heySomething .rolling .slidesjs-pagination li {float:left; padding:0 54px;}
.heySomething .rolling .slidesjs-pagination li a {display:block; width:140px; height:140px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/hey/67468/bg_ico.png) no-repeat 0 0; text-indent:-999em;}
.heySomething .rolling .slidesjs-pagination li a:hover,
.heySomething .rolling .slidesjs-pagination li a.active {background-position:0 -150px;}
.heySomething .rolling .slidesjs-pagination .num02 a {background-position:-150px 0;}
.heySomething .rolling .slidesjs-pagination .num02 a:hover,
.heySomething .rolling .slidesjs-pagination .num02 .active {background-position:-150px -150px;}
.heySomething .rolling .slidesjs-pagination .num03 a {background-position:-300px 0;}
.heySomething .rolling .slidesjs-pagination .num03 a:hover,
.heySomething .rolling .slidesjs-pagination .num03 .active {background-position:-300px -150px;}
.heySomething .rolling .slidesjs-pagination .num04 a {background-position:-450px 0;}
.heySomething .rolling .slidesjs-pagination .num04 a:hover,
.heySomething .rolling .slidesjs-pagination .num04 .active {background-position:-450px -150px;}
.heySomething .rolling .slidesjs-pagination .num05 a {background-position:-600px 0;}
.heySomething .rolling .slidesjs-pagination .num05 a:hover,
.heySomething .rolling .slidesjs-pagination .num05 .active {background-position:-600px -150px;}

.heySomething .rolling .slidesjs-navigation {position:absolute; top:55%; z-index:50; width:33px; height:64px; background:transparent url(http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_nav.png) no-repeat 0 0; text-indent:-999em}
.heySomething .rolling .slidesjs-previous {left:22%;}
.heySomething .rolling .slidesjs-next {right:22%; background-position:100% 0;}
.heySomething .desc {position:absolute; z-index:100;}
.heySomething .desc1 {top:26%; left:29%;}
.heySomething .desc2 {top:28%; left:47.5%;}
.heySomething .desc3 {top:21%; left:58.5%;}
.heySomething .desc4 {top:44%; left:23.3%;}
.heySomething .desc5 {top:3.7%; left:22%;}

/* finish */
.heySomething .finish {background-color:#d4cbb9;}
.heySomething .finish p {/*left:50%; top:40.7%; margin-left:-437px; width:229px; height:159px;*/}
.heySomething .finish .bg {position:absolute; top:0; left:0;; z-index:5; width:100%; height:850px; background:transparent url(http://webimage.10x10.co.kr/eventIMG/2015/hey/67468/img_item_finish.jpg) no-repeat 50% 0;}
.heySomething .finish .txt {position:absolute; left:50%; top:40.7%; z-index:10; margin-left:-437px; width:300px; height:159px;}
.heySomething .finish .message {width:300px;}
.heySomething .finish .message span {display:block; height:19px; margin-bottom:18px; background-position:0 0; background-repeat:no-repeat; text-indent:-9999px;}
.heySomething .finish .message span.m01 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/hey/67468/txt_finish_message_01.png);}
.heySomething .finish .message span.m02 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/hey/67468/txt_finish_message_02.png);}
.heySomething .finish .logo {position:absolute; left:0; bottom:0;}
.heySomething .finish .line {display:block; position:absolute; left:0; top:95px; width:30px; height:1px; background-color:#948e82;}

/* comment */
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/hey/67468/bg_ico.png);}
.heySomething .commentevet .form .choice li.ico1 button {background-position:0 -300px;}
.heySomething .commentevet .form .choice li.ico1 button.on {background-position:0 100%;}
.heySomething .commentevet .form .choice li.ico2 button {background-position:-150px -300px;}
.heySomething .commentevet .form .choice li.ico2 button.on {background-position:-150px 100%;}
.heySomething .commentevet .form .choice li.ico3 button {background-position:-300px -300px;}
.heySomething .commentevet .form .choice li.ico3 button.on {background-position:-300px 100%;}
.heySomething .commentevet .form .choice li.ico4 button {background-position:-450px -300px;}
.heySomething .commentevet .form .choice li.ico4 button.on {background-position:-450px 100%;}
.heySomething .commentevet .form .choice li.ico5 button {background-position:-600px -300px;}
.heySomething .commentevet .form .choice li.ico5 button.on {background-position:-600px 100%;}

.heySomething .commentlist table td strong {height:98px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/hey/67468/bg_ico.png);}
.heySomething .commentlist table td .ico1 {background-position:0 -329px;}
.heySomething .commentlist table td .ico2 {background-position:-150px -329px;}
.heySomething .commentlist table td .ico3 {background-position:-300px -329px;}
.heySomething .commentlist table td .ico4 {background-position:-450px -329px;}
.heySomething .commentlist table td .ico5 {background-position:-600px -329px;}

.rotate {-webkit-animation-duration:3700ms; -webkit-animation-iteration-count:1; -webkit-animation-timing-function: linear; -moz-animation-duration:3700ms; -moz-animation-iteration-count:1; -moz-animation-timing-function: linear; -ms-animation-duration:3700ms; -ms-animation-iteration-count:1; -ms-animation-timing-function: linear; animation-duration:3700ms; animation-iteration-count:1; animation-timing-function: linear; animation-name:spin; -webkit-animation-name:spin; -moz-animation-name: spin; -ms-animation-name: spin;}
@-ms-keyframes spin {from {-ms-transform: rotate(0deg);} to {-ms-transform: rotate(360deg);}}
@-moz-keyframes spin {from { -moz-transform: rotate(0deg);} to { -moz-transform: rotate(360deg);}}
@-webkit-keyframes spin {from { -webkit-transform: rotate(0deg);} to { -webkit-transform: rotate(360deg);}}
@keyframes spin {from {transform:rotate(0deg);} to { transform:rotate(-360deg);}}
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
		<% If not( left(currenttime,10)>="2015-11-18" and left(currenttime,10)<"2015-11-26" ) Then %>
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
	<div class="heySomething">
<% End If %>
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
			<div class="bnr"><a href="/street/street_brand_sub06.asp?makerid=laundrymat001"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67468/img_item_represent.jpg" alt="LAUNDRY.MAT+" /></a></div>
		</div>

		<%' about %>
		<div class="about">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
			<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
		</div>

		<%' item %>
		<div class="item itemB">
			<div class="inner">
				<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67468/tit_laundry_mat.png" alt="LAUNDRY.MAT+" /></h3>
				<div class="desc">
				<%' 상품 이름, 가격, 구매하기 %>
					<div class="option">
						<em class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67468/txt_name.png" alt="WOOL KNIT MUFFLER" /></em>
						<% if oItem.FResultCount > 0 then %>
							<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
								<!--div class="price">
									<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/txt_only_<%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>percent.png" alt="단, 일주일만 ONLY <%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%" /></strong>
									<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								</div-->
							<% Else %>
								<%' for dev msg : 종료 후 %>
								<div class="price priceEnd">
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								</div>
							<% End If %>
						<% end if %>
						<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67468/txt_substance.png" alt="날씨가 아무리 춥다고 마음까지 추워지면 되나요? 당신의 일상 속의 따스함을 위한 런드리맷 플러스의 11가지 머플러" /></p>
						<div class="btnget">
							<a href="/shopping/category_prd.asp?itemid=1387369"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러 가기" /></a>
						</div>
					</div>

					<div class="slidewrap">
						<div id="slide01" class="slide">
							<div><a href="/shopping/category_prd.asp?itemid=1387369"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67468/img_figure_01_v1.jpg" alt="" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1387369"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67468/img_figure_02_v1.jpg" alt="" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1387369"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67468/img_figure_03_v1.jpg" alt="" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1387369"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67468/img_figure_04_v1.jpg" alt="" /></a></div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<%' visual %>
		<div class="visual">
			<div class="figure"><a href="/street/street_brand_sub06.asp?makerid=laundrymat001"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67468/img_item_visual_big.jpg" alt="" /></a></div>

			<div id="slider" class="slider-horizontal">
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1387369"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67468/img_item_visual_01.jpg" alt="IVORY" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1387369"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67468/img_item_visual_02.jpg" alt="BEIGE" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1387369"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67468/img_item_visual_03.jpg" alt="PINK" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1387369"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67468/img_item_visual_04.jpg" alt="SKYBLUE" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1387369"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67468/img_item_visual_05.jpg" alt="GRAY" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1387369"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67468/img_item_visual_06.jpg" alt="BROWN" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1387369"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67468/img_item_visual_07.jpg" alt="KHAKI" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1387369"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67468/img_item_visual_08.jpg" alt="BLUE" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1387369"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67468/img_item_visual_09.jpg" alt="NAVY" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1387369"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67468/img_item_visual_10.jpg" alt="WINE" /></a>
				</div>
				<div class="slide-img">
					<a href="/shopping/category_prd.asp?itemid=1387369"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67468/img_item_visual_11.jpg" alt="BLACK" /></a>
				</div>
			</div>
		</div>

		<%' brand %>
		<div class="brand">
			<p class="name">LAUNDRY.MAT<span>+</span></p>
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67468/txt_intro.png" alt="오늘도 똑같은 하루를 시작합니다. 어찌보면 평범하고 지루하기 짝이 없는 하루 같아도 그 안에서 우리는 소소한 따뜻함을 발견합니다. 원사부터 가공까지 직접 제작하고 워싱 후 가공으로 더 부드럽게! 여기, 따스함이 베어있는 11가지 머플러를 만나보세요." /></p>
			<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="" /></div>
		</div>

		<%' story %>
		<div class="story">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67468/tit_story.png" alt="일상 속 따스함을 느끼고 싶을 때" /></h3>
			<div id="slide02" class="rolling">
				<div>
					<a href="/shopping/category_prd.asp?itemid=1387369">
						<img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67468/img_slide_01.jpg" alt="" class="bg" />
						<p class="desc desc1"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67468/txt_desc_01.png" alt="" /></p>
					</a>
				</div>
				<div>
					<a href="/shopping/category_prd.asp?itemid=1387369">
						<img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67468/img_slide_02.jpg" alt="" class="bg" />
						<p class="desc desc2"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67468/txt_desc_02.png" alt="" /></p>
					</a>
				</div>
				<div>
					<a href="/shopping/category_prd.asp?itemid=1387369">
						<img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67468/img_slide_03.jpg" alt="" class="bg" />
						<p class="desc desc3"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67468/txt_desc_03.png" alt="" /></p>
					</a>
				</div>
				<div>
					<a href="/shopping/category_prd.asp?itemid=1387369">
						<img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67468/img_slide_04.jpg" alt="" class="bg" />
						<p class="desc desc4"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67468/txt_desc_04.png" alt="" /></p>
					</a>
				</div>
				<div>
					<a href="/shopping/category_prd.asp?itemid=1387369">
						<img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67468/img_slide_05.jpg" alt="" class="bg" />
						<p class="desc desc5"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67468/txt_desc_05.png" alt="" /></p>
					</a>
				</div>
			</div>
		</div>

		<%' finish %>
		<div class="finish">
			<a href="/shopping/category_prd.asp?itemid=1387369">
				<div class="txt">
					<div class="message">
						<span class="m01 anim01">당신이 있는 곳에</span>
						<span class="m02 anim02">늘 따스함이 함께 하길</span>
					</div>
					<div class="logo"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67468/txt_finish02.png" alt="" /></div>
					<span class="line"></span>
				</div>
				<div class="bg"></div>
			</a>
		</div>

		<%' comment %>
		<div class="commentevet" id="commentlist" >
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67468/tit_comment.png" alt="Hey, something project 당신이 갖고 싶은 것" /></h3>
			<p class="hidden">정성껏 코멘트를 남겨주신 3분을 추첨하여 런드리맷 플러스 머플러를 선물로 드립니다.(컬러는 랜덤으로 배송됩니다) 기간:2015.11.18~11.25/발표:11.26</p>
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
					<legend>런드리맷 플러스 코멘트 쓰기</legend>
						<ul class="choice">
							<li class="ico1"><button type="button" value="1">Monday</button></li>
							<li class="ico2"><button type="button" value="2">Tuesday</button></li>
							<li class="ico3"><button type="button" value="3">Wednesday</button></li>
							<li class="ico4"><button type="button" value="4">Thursday</button></li>
							<li class="ico5"><button type="button" value="5">Friday</button></li>
						</ul>
						<textarea title="코멘트 쓰기" cols="60" rows="5" name="txtcomm1" id="txtcomm1" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();" <%IF NOT(IsUserLoginOK) THEN%>readonly<%END IF%>><%IF NOT IsUserLoginOK THEN%>로그인 후 글을 남길 수 있습니다.<% else %><%END IF%></textarea>
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
						<caption>런드리맷 플러스 코멘트 목록</caption>
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
												Monday
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="2" then %>
												Tuesday
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="3" then %>
												Wednesday
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="4" then %>
												Thursday
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="5" then %>
												Friday
											<% Else %>
												Monday
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
				<% End If %>
			</div>
		</div>
		<!-- // 수작업 영역 끝 -->

<% If Not(Trim(hspchk(1)))="hsproject" Then %>
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

	/* slide js */
	$("#slide01").slidesjs({
		width:"570",
		height:"475",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:2500, effect:"fade", auto:true},
		effect:{fade: {speed:2000, crossfade:true}
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

	$("#slide02").slidesjs({
		width:"1903",
		height:"780",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:5000, effect:"fade", auto:true},
		effect:{fade: {speed:800}}
	});

	$(".slidesjs-pagination li:nth-child(1)").addClass("num01");
	$(".slidesjs-pagination li:nth-child(2)").addClass("num02");
	$(".slidesjs-pagination li:nth-child(3)").addClass("num03");
	$(".slidesjs-pagination li:nth-child(4)").addClass("num04");
	$(".slidesjs-pagination li:nth-child(5)").addClass("num05");

	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 3600 ) {
			brandAnimation()
		}
		if (scrollTop > 5900 ) {
			finishAnimation();
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
	$(".heySomething .brand .name").css({"width":"0"});
	$(".heySomething .brand .name span").css({"opacity":"0"});
	function brandAnimation() {
		$(".heySomething .brand .name").animate({"width":"662px", "opacity":"1"},2500);
		$(".heySomething .brand .name span").delay(2300).animate({"opacity":"1"},600).addClass('rotate');
		$(".heySomething .brand .btnDown").delay(2800).animate({"margin-top":"62px", "opacity":"1"},800);
	}

	/* finish animation */
	$(".finish .message span.m01").css({"margin-left":"5px", "opacity":"0"});
	$(".finish .message span.m02").css({"margin-left":"5px", "opacity":"0"});
	$(".finish .line").css({"width":"0"});
	$(".finish .logo").css({"margin-bottom":"-5px", "opacity":"0"});
	function finishAnimation() {
		$(".finish .message span.m01").animate({"margin-left":"0", "opacity":"1"},900);
		$(".finish .message span.m02").delay(800).animate({"margin-left":"0", "opacity":"1"},900);
		$(".finish .line").delay(1100).animate({"width":"30px"},1000);
		$(".finish .logo").delay(1900).animate({"margin-bottom":"0", "opacity":"1"},900);
	}

});
</script>
<%
set oItem=nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->