<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈 14
' History : 2015-12-08 이종화 생성
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
	eCode   =  65967
Else
	eCode   =  67763
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
	itemid   =  1393633
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
.heySomething .topic {background-color:#f0f0f0; z-index:1;}

/* item */
.heySomething .slidewrap {width:570px; padding-top:85px;}
.heySomething .slidesjs-pagination li a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/bg_pagination.jpg);}

/* visual */
.heySomething .visual .figure {background-color:#f6f6f6;}

/* brand */
.heySomething .brand {position:relative; height:988px;}
.heySomething .brand .name {overflow:hidden; position:relative; width:369px; height:73px; margin:0 auto;}
.heySomething .brand .name em {display:inline-block; position:absolute; left:0; top:0; z-index:20; width:369px; height:73px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/txt_logo.png) no-repeat 0 0;}
.heySomething .brand .name span {display:inline-block; position:absolute; z-index:10; height:73px; text-indent:-9999px;}
.heySomething .brand .name span.n01 {left:0; bottom:0; width:210px; background:#4d4d4d;}
.heySomething .brand .name span.n02 {left:225px; top:0; width:150px; background:#ff6c31;}
.heySomething .brand .info {width:500px; margin:0 auto; padding-top:77px;}
.heySomething .brand .info .pic {overflow:hidden; padding-bottom:80px;}
.heySomething .brand .info p {position:relative;}

/* story */
.heySomething .story {padding-top:0; padding-bottom:280px;}
.heySomething .rolling {width:100%; height:auto;}
.heySomething .rolling .bg {width:100%;}
.heySomething .rolling .slidesjs-pagination {position:absolute; left:50%; top:0; width:1290px; margin-left:-645px;}
.heySomething .rolling .slidesjs-pagination li {float:left; padding:0 54px;}
.heySomething .rolling .slidesjs-pagination li a {display:block; width:140px; height:140px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/bg_ico.png) no-repeat 0 0; text-indent:-999em;}
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

.heySomething .rolling .slidesjs-navigation {position:absolute; top:55%; z-index:50; width:33px; height:64px; background:transparent url(http://webimage.10x10.co.kr/eventIMG/2015/hey/67211/btn_nav.png) no-repeat 0 0; text-indent:-999em}
.heySomething .rolling .slidesjs-previous {left:22%;}
.heySomething .rolling .slidesjs-next {right:22%; background-position:100% 0;}
.heySomething .desc {position:absolute; z-index:100;}
.heySomething .desc1 {top:30.6%; left:28%;}
.heySomething .desc2 {top:47%; left:44.2%;}
.heySomething .desc3 {top:21%; left:31.3%;}
.heySomething .desc4 {top:21%; left:60%;}
.heySomething .desc5 {top:43.5%; left:56%;}

/* detail */
.heySomething .detail {text-align:center; padding-bottom:300px;}

/* variation */
.heySomething .variation {text-align:center;}
.heySomething .variation .slide {position:relative; width:534px; margin:0 auto;}
.heySomething .variation .color {padding:55px 0 250px;}
.heySomething .variation .color .slide {padding-bottom:65px;}
.heySomething .variation .color .slide .slidesjs-pagination {display:none;}
.heySomething .variation #slider {height:80px; margin-top:0; text-align:left;}
.heySomething .variation #slider .slide-img {width:80px; height:80px; margin:0 35px; cursor:pointer;}
.heySomething .variation .brightness {padding-bottom:208px;}
.heySomething .variation .brightness .slide {overflow:visible !important; padding:42px 0 138px;}
.heySomething .variation .brightness .slidesjs-pagination {position:absolute; left:50%; bottom:0; width:1050px; margin-left:-525px;}
.heySomething .variation .brightness .slidesjs-pagination li {float:left; padding:0 35px;}
.heySomething .variation .brightness .slidesjs-pagination li a {display:block; width:80px; height:80px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/btn_bright_level.png); background-repeat:no-repeat; text-indent:-999em;}
.heySomething .variation .brightness .slidesjs-pagination li.num01 a {background-position:0 0;}
.heySomething .variation .brightness .slidesjs-pagination li.num02 a {background-position:-80px 0;}
.heySomething .variation .brightness .slidesjs-pagination li.num03 a {background-position:-160px 0;}
.heySomething .variation .brightness .slidesjs-pagination li.num04 a {background-position:-240px 0;}
.heySomething .variation .brightness .slidesjs-pagination li.num05 a {background-position:-320px 0;}
.heySomething .variation .brightness .slidesjs-pagination li.num06 a {background-position:-400px 0;}
.heySomething .variation .brightness .slidesjs-pagination li.num07 a {background-position:-480px 0;}

/* finish */
.heySomething .finish {background-color:#d4cbb9;}
.heySomething .finish .bg {position:absolute; top:0; left:0; z-index:5; width:100%; height:850px; background:transparent url(http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/img_item_finish.jpg) no-repeat 50% 0;}
.heySomething .finish .logo {position:absolute; left:50%; top:50%; z-index:10; margin:-37px 0 0 -184px;}

/* comment */
.heySomething .commentevet {margin-top:190px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/bg_ico.png);}
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

.heySomething .commentlist table td strong {height:98px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/bg_ico.png);}
.heySomething .commentlist table td .ico1 {background-position:0 -327px;}
.heySomething .commentlist table td .ico2 {background-position:-150px -327px;}
.heySomething .commentlist table td .ico3 {background-position:-300px -327px;}
.heySomething .commentlist table td .ico4 {background-position:-450px -327px;}
.heySomething .commentlist table td .ico5 {background-position:-600px -327px;}
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
		<% If not( left(currenttime,10)>="2015-12-09" and left(currenttime,10)<="2015-12-15" ) Then %>
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
			<div class="bnr"><a href="/shopping/category_prd.asp?itemid=1393633"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/img_item_represent.jpg" alt="Hello Kitty LED lamp" /></a></div>
		</div>

		<%' about %>
		<div class="about">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
			<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
		</div>

		<%' item %>
		<div class="item itemB">
			<div class="inner">
				<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/tit_base.png" alt="base NL" /></h3>
				<div class="desc">
				<%' 상품 이름, 가격, 구매하기 %>
					<div class="option">
						<em class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/txt_name.png" alt="Hello Kitty LED lamp" /></em>
						<% if oItem.FResultCount > 0 then %>
							<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
								<div class="price">
									<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/txt_only_<%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>percent.png" alt="텐바이텐에서만 ONLY <%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%" /></strong>
									<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								</div>
							<% Else %>
								<%' for dev msg : 종료 후 %>
								<div class="price priceEnd" style="display:none;">
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								</div>
							<% End If %>
						<% end if %>
						<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/txt_substance.png" alt="‘헬로 키티’가 조명으로 탄생했습니다. LED 조명은 장시간 사용에도 뜨거워지지 않아 안전하고 16가지 다양한 컬러모드로 공간은 특별해집니다." /></p>
						<div class="btnget">
							<a href="/shopping/category_prd.asp?itemid=1393633"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러 가기" /></a>
						</div>
					</div>

					<div class="slidewrap">
						<div id="slide01" class="slide">
							<div><a href="/shopping/category_prd.asp?itemid=1393633"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/img_figure_01.jpg" alt="" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1393633"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/img_figure_02.jpg" alt="" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1393633"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/img_figure_03.jpg" alt="" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1393633"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/img_figure_04.jpg" alt="" /></a></div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<%' visual %>
		<div class="visual">
			<div class="figure"><a href="/shopping/category_prd.asp?itemid=1393633"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/img_item_visual_big.jpg" alt="" /></a></div>
		</div>

		<%' brand %>
		<div class="brand">
			<p class="name">
				<span class="n01">BASE</span>
				<span class="n02">NL</span>
				<em></em>
			</p>
			<div class="info">
				<div class="pic">
					<div class="ftLt"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/img_director.jpg" alt="" /></div>
					<div class="ftRt"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/img_ceo.jpg" alt="" /></div>
				</div>
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/txt_brand.jpg" alt="BASE NL은 네덜란드 기반의 디자인 그룹으로 일상생활을 더욱 편리하고 특별하게 만들어줄 인테리어 제품을 디자인합니다. 첫 프로젝트로 탄생한 제품은 전 세계적으로 많은 사랑을 받고있는 캐릭터 ‘헬로키티’를 모티브로 한 플로어 조명입니다. LED를 사용하여 장시간 사용에도 뜨거워지지 않아 아이 방에 두기 안전하고16컬러로 조명 모드를 변경할 수 있어 일상에 즐거움을 선사합니다." /></p>
			</div>
			<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="" /></div>
		</div>

		<%' story %>
		<div class="story">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/txt_story.png" alt="삶을 더욱 편리하고 아름답게 만들어 줄 디자인" /></h3>
			<div id="slide02" class="rolling">
				<div>
					<a href="/shopping/category_prd.asp?itemid=1393633">
						<img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/img_slide_01.jpg" alt="" class="bg" />
						<p class="desc desc1"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/txt_desc_01.png" alt="" /></p>
					</a>
				</div>
				<div>
					<a href="/shopping/category_prd.asp?itemid=1393633">
						<img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/img_slide_02.jpg" alt="" class="bg" />
						<p class="desc desc2"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/txt_desc_02.png" alt="" /></p>
					</a>
				</div>
				<div>
					<a href="/shopping/category_prd.asp?itemid=1393633">
						<img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/img_slide_03.jpg" alt="" class="bg" />
						<p class="desc desc3"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/txt_desc_03.png" alt="" /></p>
					</a>
				</div>
				<div>
					<a href="/shopping/category_prd.asp?itemid=1393633">
						<img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/img_slide_04.jpg" alt="" class="bg" />
						<p class="desc desc4"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/txt_desc_04.png" alt="" /></p>
					</a>
				</div>
				<div>
					<a href="/shopping/category_prd.asp?itemid=1393633">
						<img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/img_slide_05.jpg" alt="" class="bg" />
						<p class="desc desc5"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/txt_desc_05.png" alt="" /></p>
					</a>
				</div>
			</div>
		</div>

		<%' detail %>
		<div class="detail">
			<div><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/img_detail.jpg" alt="" /></div>
			<div class="tMar100"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/img_led.jpg" alt="" /></div>
		</div>

		<%' variation %>
		<div class="variation">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/txt_color_variation.png" alt="Color variation" /></h3>
			<div class="color">
				<div id="slide03" class="slide">
					<div><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/img_item_color_01.jpg" alt="" /></div>
					<div><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/img_item_color_02.jpg" alt="" /></div>
					<div><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/img_item_color_03.jpg" alt="" /></div>
					<div><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/img_item_color_04.jpg" alt="" /></div>
					<div><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/img_item_color_05.jpg" alt="" /></div>
					<div><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/img_item_color_06.jpg" alt="" /></div>
					<div><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/img_item_color_07.jpg" alt="" /></div>
					<div><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/img_item_color_08.jpg" alt="" /></div>
					<div><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/img_item_color_09.jpg" alt="" /></div>
					<div><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/img_item_color_10.jpg" alt="" /></div>
					<div><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/img_item_color_11.jpg" alt="" /></div>
					<div><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/img_item_color_12.jpg" alt="" /></div>
					<div><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/img_item_color_13.jpg" alt="" /></div>
					<div><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/img_item_color_14.jpg" alt="" /></div>
					<div><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/img_item_color_15.jpg" alt="" /></div>
					<div><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/img_item_color_16.jpg" alt="" /></div>
				</div>
				<div id="slider" class="slider-horizontal">
					<div class="slide-img"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/img_color_nav_01.png" alt="" /></div>
					<div class="slide-img"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/img_color_nav_02.png" alt="" /></div>
					<div class="slide-img"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/img_color_nav_03.png" alt="" /></div>
					<div class="slide-img"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/img_color_nav_04.png" alt="" /></div>
					<div class="slide-img"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/img_color_nav_05.png" alt="" /></div>
					<div class="slide-img"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/img_color_nav_06.png" alt="" /></div>
					<div class="slide-img"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/img_color_nav_07.png" alt="" /></div>
					<div class="slide-img"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/img_color_nav_08.png" alt="" /></div>
					<div class="slide-img"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/img_color_nav_09.png" alt="" /></div>
					<div class="slide-img"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/img_color_nav_10.png" alt="" /></div>
					<div class="slide-img"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/img_color_nav_11.png" alt="" /></div>
					<div class="slide-img"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/img_color_nav_12.png" alt="" /></div>
					<div class="slide-img"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/img_color_nav_13.png" alt="" /></div>
					<div class="slide-img"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/img_color_nav_14.png" alt="" /></div>
					<div class="slide-img"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/img_color_nav_15.png" alt="" /></div>
					<div class="slide-img"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/img_color_nav_16.png" alt="" /></div>
				</div>
			</div>
			<div class="brightness">
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/txt_bright.png" alt="총 7단계의 밝기 조절이 가능합니다." /></p>
				<div id="slide04" class="slide">
					<div><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/img_item_bright_01.jpg" alt="" /></div>
					<div><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/img_item_bright_02.jpg" alt="" /></div>
					<div><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/img_item_bright_03.jpg" alt="" /></div>
					<div><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/img_item_bright_04.jpg" alt="" /></div>
					<div><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/img_item_bright_05.jpg" alt="" /></div>
					<div><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/img_item_bright_06.jpg" alt="" /></div>
					<div><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/img_item_bright_07.jpg" alt="" /></div>
				</div>
			</div>
			<div class="warn"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/txt_warning.png" alt="Safety Warnings:본 제품은 조명입니다. 실내에서 사용할 것을 권장하며 습하지 않은 공간에서 이용하세요. 내부 조명의 필름 케이블이나 코드가 손상되어 안전상의 문제가 발생할 수 있는 경우, 제조자 혹은 서비스 센터를 통해 교환이 가능합니다. 확실하지 않은 경우 BaseNL에 문의하세요" /></div>
		</div>

		<%' setup %>
		
		<%' finish %>
		<div class="finish">
			<a href="/shopping/category_prd.asp?itemid=1393633">
				<div class="logo"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/txt_finish.png" alt="" /></div>
				<div class="bg"></div>
			</a>
		</div>

		<%' comment %>
		<div class="commentevet" id="commentlist">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67763/tit_comment.png" alt="Hey, something project 당신이 갖고 싶은 것" /></h3>
			<p class="hidden">BASE NL의 텐바이텐 런칭을 축하해주세요. 정성껏 코멘트를 남겨주신 1분을 추첨하여 Hello Kitty LED lamp를 드립니다. 기간:2015.12.09~12.21/발표:12.21</p>
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
					<legend>baseNL 코멘트 쓰기</legend>
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
						<caption>baseNL 코멘트 목록</caption>
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
<% If Not(Trim(hspchk(1)))="hsproject" Then %>
	</div>
<% End If %>
<script type="text/javascript" src="/lib/js/jquery.flowslider.js"></script>
<script type="text/javascript">
$(function(){
	$("#slider").FlowSlider({
		marginStart:0,
		marginEnd:0,
		startPosition:0.55
	});

	/* comment write ico select */
	$(".form .choice li:first-child button").addClass("on");
	frmcom.gubunval.value = '1';
	$(".form .choice li button").click(function(){
		frmcom.gubunval.value = $(this).val();
		$(".form .choice li button").removeClass("on");
		if ( $(this).hasClass("on")) {
			$(this).removeClass("on");
		} else {
			$(this).addClass("on");
		}
	});

	/* slide js */
	$("#slide01").slidesjs({
		width:"500",
		height:"495",
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

	$("#slide03").slidesjs({
		width:"534",
		height:"534",
		pagination:{effect:"fade"},
		navigation:false,
		play:{interval:900, effect:"fade", auto:true},
		effect:{fade: {speed:1000}}
	});

	$("#slide04").slidesjs({
		width:"534",
		height:"534",
		pagination:{effect:"fade"},
		navigation:false,
		play:{interval:800, effect:"fade", auto:true},
		effect:{fade: {speed:1000}}
	});

	$(".slidesjs-pagination li:nth-child(1)").addClass("num01");
	$(".slidesjs-pagination li:nth-child(2)").addClass("num02");
	$(".slidesjs-pagination li:nth-child(3)").addClass("num03");
	$(".slidesjs-pagination li:nth-child(4)").addClass("num04");
	$(".slidesjs-pagination li:nth-child(5)").addClass("num05");
	$(".slidesjs-pagination li:nth-child(6)").addClass("num06");
	$(".slidesjs-pagination li:nth-child(7)").addClass("num07");

	var conChk = 0;
	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 3700 ) {
			if (conChk==0){
				brandAnimation()
			}
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
	$(".heySomething .brand .name span").css({"height":"0"});

	$(".heySomething .brand .info .ftLt").css({"margin-left":"10px","opacity":"0"});
	$(".heySomething .brand .info .ftRt").css({"margin-right":"10px","opacity":"0"});
	$(".heySomething .brand .info p").css({"top":"-10px","opacity":"0"});
	$(".heySomething .brand .btnDown").css({"opacity":"0"});
	function brandAnimation() {
		conChk = 1;
		$(".heySomething .brand .name span.n01").animate({"height":"73px"},500);
		$(".heySomething .brand .name span.n02").animate({"height":"73px"},500);
		$(".heySomething .brand .info div").delay(500).animate({"margin-left":"0","margin-right":"0", "opacity":"1"},500);
		$(".heySomething .brand .info p").delay(1000).animate({"top":"0","opacity":"1"},500);
		$(".heySomething .brand .btnDown").delay(1200).animate({"margin-top":"62px", "opacity":"1"},800);
	}
	$('#slider .slide-img img').each(function(index){
		$(this).addClass('c0' + index);
	});
	$('.color .slide .slidesjs-pagination li a').each(function(index){
		$(this).addClass('c0' + index);
	});
	
	$('.slide-img img').click(function(){
		var currentColor = $(this).attr('class');
		$('.color .slide .slidesjs-pagination li a.'+currentColor).click();
	});

});
</script>
<%
set oItem=nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->