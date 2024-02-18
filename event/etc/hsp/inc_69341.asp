<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈 22
' History : 2016-02-29 유태욱 생성
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
dim oItem, itemid
dim currenttime
	currenttime =  now()
'	currenttime = #03/02/2016 09:00:00#

dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  66051
	itemid = 1239226
Else
	eCode   =  69341
	itemid = 1431913
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
	iCPageSize = 5		'풀단이면 15개			'/수기이벤트 둘다 강제 12고정
else
	iCPageSize = 5		'메뉴가 있으면 10개			'/수기이벤트 둘다 강제 12고정
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


set oItem = new CatePrdCls
	oItem.GetItemData itemid

Dim hspchk
'// 현재 주소값 체크하여 신규, 구버전 확인
hspchk = Split(LCase(Request.ServerVariables("PATH_INFO")),"/")
%>
<style type="text/css">
/* title */
.heySomething .topic {background:#f6f2f2 url(http://webimage.10x10.co.kr/eventIMG/2016/hey/69341/img_item_represent.jpg) no-repeat 50% 0;}
.heySomething .topic .bnr {text-indent:-9999em;}
.heySomething .topic .bnr a {display:block; width:100%; height:780px;}

/* item */
.heySomething .itemB {padding-bottom:38px; background:none;}
.heySomething .item h3 {position:relative; height:107px;}
.heySomething .item h3 .disney {position:absolute; top:0; left:402px;}
.heySomething .item h3 .tenten {position:absolute; top:0; left:628px;}
.heySomething .item h3 .verticalLine {position:absolute; top:25px; left:569px; width:1px; height:64px; background-color:#d9d9d9;}
.heySomething .item h3 .horizontalLine1, .heySomething .item h3 .horizontalLine2 {position:absolute; top:56px; width:329px; height:1px; background-color:#ddd;}
.heySomething .item h3 .horizontalLine1 {left:0;}
.heySomething .item h3 .horizontalLine2 {right:0;}
.heySomething .itemB .with {padding-bottom:90px; border-bottom:1px solid #ddd; text-align:center;}
.heySomething .itemB .with ul {overflow:hidden; width:1022px; margin:45px auto 0;}
.heySomething .itemB .with ul li {float:left; padding:0 20px;}
.heySomething .itemB .with ul li a {overflow:hidden; display:block; position:relative; width:471px; height:157px;}
.heySomething .itemB .with ul li .mask {position:absolute; top:0; left:0; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/69341/bg_mask.png) no-repeat 50% 0; transition:opacity 1s;}
.heySomething .itemB .with ul li .text {position:absolute; top:71px; left:0; width:100%; text-align:center;}
.heySomething .itemB .with ul li a:hover span {animation-duration:5s; animation-fill-mode:both; animation-iteration-count:infinite;}
.heySomething .itemB .with ul li a:hover .mask {opacity:0; filter:alpha(opacity=0);}
.heySomething .itemB .with ul li a:hover .text {margin:20px; animation-name:hinge;}
.heySomething .itemB .with ul li a:hover .text {*opacity:0; filter:alpha(opacity=0);}
@media \0screen {
	.heySomething .itemB .with ul li a:hover .text {*opacity:0; filter:alpha(opacity=0);}
}

@keyframes hinge {
	0% {transform:rotate(0); transform-origin:top left; animation-timing-function:ease-in-out;}
	20%, 60% {transform:rotate(80deg); transform-origin:top left; animation-timing-function:ease-in-out;}
	40% {transform:rotate(60deg); transform-origin:top left; animation-timing-function:ease-in-out;}
	80% {transform:rotate(60deg) translateY(0); transform-origin:top left; animation-timing-function:ease-in-out;}
	100% {transform:translateY(700px);}
}

/* visual */
.heySomething .visual {padding-bottom:0;}
.heySomething .visual .figure {background-color:#f8edf4;}

/* brand */
.heySomething .brand {height:517px; margin-top:215px;}

/* mickey */
.mickey {width:980px; margin:200px auto 0; text-align:center;}
.mickey .animation {position:relative; margin-top:70px;}
.mickey #animation1 {margin-top:0;}
.mickey .animation .violin {position:absolute; top:-42px; left:550px;}
.mickey .animation .airplane {position:absolute; top:288px; left:40px;}
.mickey .animation .bang {position:absolute; top:247px; left:293px;}
.mickey .animation .fight {position:absolute; bottom:54px; right:52px;}

.mickey .animation .balloon {position:absolute; top:-4px; right:114px;}
.mickey .animation .parachute {position:absolute; top:32px; left:157px;}
.mickey .animation .seesaw {position:absolute; top:335px; left:74px;}

.mickey .animation .climbing {overflow:hidden; position:absolute; top:0; right:199px; width:145px; height:250px;}
.mickey .animation .pull {overflow:hidden; position:absolute; bottom:85px; left:-31px; width:200px; text-align:right;}
.mickey .animation .voyage {position:absolute; bottom:90px; right:86px;}

.mickey .character {margin-top:250px; opacity:0; filter:alpha(opacity=100);}

.animated {animation-duration:3s; animation-fill-mode:both; animation-iteration-count:infinite;}
@keyframes flash {
	0%, 50%, 100% {opacity:1;}
	25%, 75% {opacity:0;}
}
.flash {animation-name:flash;}
@keyframes bouncing {
	0%, 20%, 50%, 80%, 100% {transform:translateY(0);}
	40% {transform:translateY(-30px);}
	60% {transform:translateY(-15px);}
}
.bouncing {animation-name:bouncing;}

.spin {animation:spin 5s linear infinite;}
@keyframes spin {100% {transform:rotateY(360deg);}}

@keyframes move {
	0% {transform:translateY(0);}
	50% {transform:translateX(100px);}
	100% {transform:translateY(0);}
}
.move {animation-name:move;}

@keyframes updown {
	0% {transform:translateY(0);}
	50% {transform:translateY(-15px);}
	100% {transform:translateY(0);}
}
.updown {animation-name:updown;}

@keyframes pulled {
	0% {transform:translateX(0);}
	50% {transform:translateX(15px);}
	100% {transform:translateX(0);}
}
.pulled {animation-name:pulled;}

@keyframes swing {
	0 {transform:rotate(0deg);}
	50% {transform:rotate(-5deg);}
	100% {transform:rotate(0deg);}
}
.swing {animation-name:swing; animation-duration:5s; transform-origin:60% 100%;}

.rollIn {animation-name:rollIn; animation-duration:3s; animation-fill-mode:both; animation-iteration-count:1;}
@keyframes rollIn {
	0% {opacity:0; transform:translateX(-100%) rotate(-120deg);}
	100% {opacity:1; transform:translateX(0px) rotate(0deg);}
}
@keyframes rotateIn {
	0% {transform-origin:50% 50%; transform: rotateY(-200deg); opacity:0;}
	 {transform-origin:50% 50%; transform: rotateY(0); opacity:1;}
}
.rotateIn {animation-name:rotateIn; animation-duration:3s; animation-fill-mode:both; animation-iteration-count:1;}

/* story */
.heySomething .rolling {width:100%; height:713px; padding-top:177px;}
.heySomething .slidesjs-slide {width:100%; height:713px;}
.heySomething .slidesjs-slide-01 {background:#fbe2b9 url(http://webimage.10x10.co.kr/eventIMG/2016/hey/69341/img_slide_01_v1.jpg) no-repeat 50% 0;}
.heySomething .slidesjs-slide-02 {background:#f6f4ee url(http://webimage.10x10.co.kr/eventIMG/2016/hey/69341/img_slide_02_v1.jpg) no-repeat 50% 0;}
.heySomething .slidesjs-slide-03 {background:#e1cea9 url(http://webimage.10x10.co.kr/eventIMG/2016/hey/69341/img_slide_03_v1.jpg) no-repeat 50% 0;}
.heySomething .slidesjs-slide-04 {background:#dfd3b2 url(http://webimage.10x10.co.kr/eventIMG/2016/hey/69341/img_slide_04_v1.jpg) no-repeat 50% 0;}
.heySomething .slidesjs-slide a {display:block; position:relative; width:100%; height:100%;}
.heySomething .slidesjs-slide .desc {position:absolute;}
.heySomething .slidesjs-slide-01 .desc {top:111px; left:50%; margin-left:-400px;}
.heySomething .slidesjs-slide-02 .desc {top:115px; left:50%; margin-left:223px;}
.heySomething .slidesjs-slide-03 .desc {top:128px; left:50%; margin-left:-417px;}
.heySomething .slidesjs-slide-04 .desc {top:189px; left:50%; margin-left:-371px;}
.heySomething .rolling .slidesjs-pagination {position:absolute; left:50%; top:0; width:704px; margin-left:-352px;}
.heySomething .rolling .slidesjs-pagination li {float:left; width:148px; height:150px; margin:0 14px;}
.heySomething .rolling .slidesjs-pagination li a {display:block; width:148px; height:150px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/69341/btn_pagination.png) no-repeat 0 0; text-indent:-999em;}
.heySomething .rolling .slidesjs-pagination li a:hover,
.heySomething .rolling .slidesjs-pagination li a.active {background-position:0 -150px;}
.heySomething .rolling .slidesjs-pagination .num02 a {background-position:-177px 0;}
.heySomething .rolling .slidesjs-pagination .num02 a:hover,
.heySomething .rolling .slidesjs-pagination .num02 .active {background-position:-177px -150px;}
.heySomething .rolling .slidesjs-pagination .num03 a {background-position:-354px 0;}
.heySomething .rolling .slidesjs-pagination .num03 a:hover,
.heySomething .rolling .slidesjs-pagination .num03 .active {background-position:-354px -150px;}
.heySomething .rolling .slidesjs-pagination .num04 a {background-position:100% 0;}
.heySomething .rolling .slidesjs-pagination .num04 a:hover,
.heySomething .rolling .slidesjs-pagination .num04 .active {background-position:100% -150px;}
.heySomething .rolling .slidesjs-navigation {position:absolute; top:510px; left:50%; z-index:50; width:33px; height:64px; background:transparent url(http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_nav.png) no-repeat 0 0; text-indent:-999em}
.heySomething .rolling .slidesjs-previous {margin-left:-554px;}
.heySomething .rolling .slidesjs-next {margin-left:525px; background-position:100% 0;}

/* finish */
.heySomething .finish {background-color:#fefdfe;}
.heySomething .finish .bg {position:absolute; top:0; left:0; z-index:5; width:100%; height:850px; background:transparent url(http://webimage.10x10.co.kr/eventIMG/2016/hey/69341/img_item_finish.jpg) no-repeat 50% 0; transition:all 0.5s;}
.heySomething .finish p {top:278px; margin-left:-470px;}

/* comment */
.heySomething .commentevet .form .choice li {width:132px; margin-right:18px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/69341/bg_ico_v1.png); background-position:0 0;}
.heySomething .commentevet .form .choice li.ico2 button {background-position:-150px 0;}
.heySomething .commentevet .form .choice li.ico3 button {background-position:-300px 0;}
.heySomething .commentevet .form .choice li.ico4 button {background-position:-450px 0;}

.heySomething .commentlist table td strong {height:116px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/69341/bg_ico_v1.png); background-position:0 -23px;}
.heySomething .commentlist table td strong.ico2 {background-position:-150px -23px;}
.heySomething .commentlist table td strong.ico3 {background-position:-300px -23px;}
.heySomething .commentlist table td strong.ico4 {background-position:-450px -23px;}
</style>
<script type='text/javascript'>

$(function(){
	<% if pagereload<>"" then %>
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
		<% If not( left(currenttime,10)>="2016-03-02" and left(currenttime,10)<"2016-03-09" ) Then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return false;
		<% else %>
			<% if commentcount>0 then %>
				alert("이벤트는 한번만 참여 가능 합니다.");
				return false;
			<% else %>
				if (frm.gubunval.value == ''){
					alert('가장 마음에 드는 디즈니 노트 활용법을 선택해 주세요.');
					return false;
				}
				if (frm.txtcomm1.value == '' || GetByteLength(frm.txtcomm1.value) > 800){
					alert("코맨트를 남겨주세요.\n한글 400자 까지 작성 가능합니다.");
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
			<div class="bnr"><a href="/shopping/category_prd.asp?itemid=1431913">Disney Vintage Note Set</a></div>
		</div>

		<%' about %>
		<div class="about">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
			<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
		</div>

		<%' item %>
		<div class="item itemB">
			<div class="inner">
				<h3>
					<span class="disney"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69341/img_logo_disney.png" alt="디즈니" /></span>
					<span class="tenten"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69341/img_logo_tenten.png" alt="텐바이텐" /></span>
					<span class="verticalLine"></span>
					<span class="horizontalLine1"></span>
					<span class="horizontalLine2"></span>
				</h3>
				<div class="desc">
					<%'' 상품 이름, 가격, 구매하기 %>
					<div class="option">
						<em class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69341/txt_name.png" alt="Disney Vintage Note Set" /></em>
						<% if oItem.FResultCount > 0 then %>
							<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
								<%	'' for dev msg :  상품코드 1431913, 할인기간 3/2~3/8 할인기간이 지나면  <strong class="discount">...</strong> 숨겨주세요 %>
								<%	'' for dev msg : 할인 %>
								<div class="price">
									<% If not( left(currenttime,10)>="2016-03-02" and left(currenttime,10)<"2016-03-09" ) Then %>
									<% else %>
										<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/txt_just_one_week.png" alt="단, 일주일만 just one week" /></strong>
										<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
									<% end if %>
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								</div>
							<% Else %>
								<%	''  for dev msg : 종료 후 %>
								<div class="price priceEnd">
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								</div>
							<% end if %>
						<% end if %>
						<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69341/txt_substance.png" alt="월트디즈니의 오리지널 포스터가 노트속으로! 클래식 감성을 간직한 노트 속에는 그 시절 추억과 향수가 담겨 있습니다." /></p>
						<div class="btnget"><a href="/shopping/category_prd.asp?itemid=1431913&amp;pEtr=69341"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="Disney Vintage Note Set 구매하러 가기" /></a></div>
					</div>

					<%'' slide %>
					<div class="slidewrap">
						<div id="slide01" class="slide">
							<div><a href="/shopping/category_prd.asp?itemid=1431913&amp;pEtr=69341"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69341/img_figure_01_v2.jpg" alt="덤보" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1431913&amp;pEtr=69341"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69341/img_figure_02_v2.jpg" alt="미키마우스" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1431913&amp;pEtr=69341"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69341/img_figure_03_v2.jpg" alt="미키마우스 월드 웨이브" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1431913&amp;pEtr=69341"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69341/img_figure_04_v2.jpg" alt="미키마우스" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1431913&amp;pEtr=69341"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69341/img_figure_05_v2.jpg" alt="백설공주" /></a></div>
						</div>
					</div>
				</div>

				<div class="with">
					<span><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/ico_plus.png" alt="" /></span>
					<ul>
						<li>
							<a href="/shopping/category_prd.asp?itemid=1434283&amp;pEtr=69341">
								<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69341/img_width_item_01.jpg" alt="Disney Vintage playing card" />
								<span class="mask"></span>
								<span class="text"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69341/txt_playing_card.png" alt="PLAYING CARD" /></span>
							</a>
						</li>
						<li>
							<a href="/shopping/category_prd.asp?itemid=1418361&amp;pEtr=69341">
								<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69341/img_width_item_02.jpg" alt="Disney Vintage 아이폰6/6S 케이스" />
								<span class="mask"></span>
								<span class="text"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69341/txt_ipone_case.png" alt="IPONE CASE" /></span>
							</a>
						</li>
					</ul>
				</div>
			</div>
		</div>

		<%'' visual %>
		<div class="visual">
			<div class="figure"><a href="/shopping/category_prd.asp?itemid=1431913&amp;pEtr=69341"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69341/img_item_visual_big.jpg" alt="" /></a></div>
		</div>

		<%'' brand %>
		<div class="brand">
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69341/txt_brand.png" alt="Money doesn&apos;t excite me, my ideas excited me. Walt Disney 디즈니는 1923 설립 이래로 필름스케치, 드로잉, 포스터 등 다양한 작업을 통해 디즈니 고유의 아트워크를 창조하고있습니다. 디즈니의 빈티지 컬렉션은 클래식 감성을 간직한 사랑스러운 디즈니 캐릭터를 통해 어린 시절의 추억과 향수를 불러일으킵니다." /></p>
			<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="" /></div>
		</div>

		<%'' featured %>
		<div class="mickey">
			<div id="animation1" class="animation yellow">
				<a href="/shopping/category_prd.asp?itemid=1431913&amp;pEtr=69341">
					<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69341/img_animation_01.jpg" alt="월트 디즈니 미키마우스 노트" />
					<span class="violin"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69341/img_character_violin.png" alt="" /></span>
					<span class="airplane"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69341/img_character_airplane.png" alt="" /></span>
					<span class="bang animated flash"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69341/img_character_bang.png" alt="" /></span>
					<span class="fight animated spin"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69341/img_character_fight.png" alt="" /></span>
				</a>
			</div>

			<div id="animation2" class="animation blue">
				<a href="/shopping/category_prd.asp?itemid=1431913&amp;pEtr=69341">
					<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69341/img_animation_02.jpg" alt="월트 디즈니 미키마우스 노트" />
					<span class="balloon animated bouncing"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69341/img_character_balloon.png" alt="" /></span>
					<span class="parachute"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69341/img_character_parachute.png" alt="" /></span>
					<span class="seesaw animated swing"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69341/img_character_seesaw.png" alt="" /></span>
				</a>
			</div>

			<div id="animation3" class="animation red">
				<a href="/shopping/category_prd.asp?itemid=1431913&amp;pEtr=69341">
					<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69341/img_animation_03.jpg" alt="미키마우스 와일드 웨이브 노트" />
					<span class="climbing"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69341/img_character_climbing.png" alt="" class="animated updown" /></span>
					<span class="pull"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69341/img_character_pull_v1.png" alt="" class="animated pulled" /></span>
					<span class="voyage"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69341/img_character_voyage.png" alt="" /></span>
				</a>
			</div>

			<div class="character animated"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69341/img_mickey.png" alt="" /></div>
		</div>

		<%''story %>
		<div class="story">
			<div id="slide02" class="rolling">
				<div class="slidesjs-slide-01">
					<a href="/shopping/category_prd.asp?itemid=1431913&amp;pEtr=69341">
						<p class="desc"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69341/txt_desc_01.png" alt="요리가 즐거워지는 레시피북" /></p>
					</a>
				</div>
				<div class="slidesjs-slide-02">
					<a href="/shopping/category_prd.asp?itemid=1431913&amp;pEtr=69341">
						<p class="desc"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69341/txt_desc_02.png" alt="익살스러운 미키와 함께하는 행복한 스쿨노트" /></p>
					</a>
				</div>
				<div class="slidesjs-slide-03">
					<a href="/shopping/category_prd.asp?itemid=1431913&amp;pEtr=69341">
						<p class="desc"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69341/txt_desc_03.png" alt="소중한 기억들을 간직해 줄 스크랩북" /></p>
					</a>
				</div>
				<div class="slidesjs-slide-04">
					<a href="/shopping/category_prd.asp?itemid=1431913&amp;pEtr=69341">
						<p class="desc"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69341/txt_desc_04_v1.png" alt="하얀 도화지 위 컬러를 담은 드로잉북" /></p>
					</a>
				</div>
			</div>
		</div>

		<%'' finish %>
		<div class="finish">
			<a href="/shopping/category_prd.asp?itemid=1431913&amp;pEtr=69341">
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69341/txt_finish.png" alt="Disney Vintage Edition" /></p>
				<div class="bg"></div>
			</a>
		</div>

		<%'' comment %>
		<div class="commentevet" id="commentlist">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69341/tit_comment.png" alt="Hey, something project 당신이 갖고 싶은 것" /></h3>
			<p class="hidden">가장 마음에 드는 디즈니 노트 활용법과 그 이유를 코멘트로 남겨주세요. 정성껏 코멘트를 남겨주신 5분을 추첨하여 Disney vintage Note set를 증정합니다. 코멘트 작성기간은 2016년 3월 2일부터 3월 8일까지며, 발표는 3월 14일 입니다.</p>

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
					<legend>Disney Vintage Edition 코멘트 쓰기</legend>
						<ul class="choice">
							<li class="ico1"><button type="button" value="1">레시피북</button></li>
							<li class="ico2"><button type="button" value="2">스쿨노트</button></li>
							<li class="ico3"><button type="button" value="3">스크랩북</button></li>
							<li class="ico4"><button type="button" value="4">드로잉북</button></li>
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

			<% '' commentlist %>
			<div class="commentlist">
				<p class="total">total <%= iCTotCnt %></p>
				<% IF isArray(arrCList) THEN %>
					<table>
						<caption>Disney Vintage Edition 코멘트 목록</caption>
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
												레시피북
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="2" then %>
												스쿨노트
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="3" then %>
												스크랩북
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="4" then %>
												드로잉북
											<% Else %>
												레시피북
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

					<%'' paging %>
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
	/* slide js */
	$("#slide01").slidesjs({
		width:"570",
		height:"485",
		pagination:false,
		navigation:{effect:"fade"},
		play:{interval:2500, effect:"fade", auto:true},
		effect:{fade: {speed:1200, crossfade:true}
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
		width:"1140",
		height:"713",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:5000, effect:"fade", auto:true},
		effect:{fade: {speed:800}},
		callback: {
			start: function() {
				$(".heySomething #slide02 .slidesjs-slide-01 .desc").css({"left":"40%", "opacity":"0"});
				$(".heySomething #slide02 .slidesjs-slide-02 .desc").css({"margin-left":"270px", "opacity":"0"});
				$(".heySomething #slide02 .slidesjs-slide-03 .desc").css({"left":"40%", "opacity":"0"});
				$(".heySomething #slide02 .slidesjs-slide-04 .desc").css({"left":"40%", "opacity":"0"});
			},
			complete: function() {
				$(".heySomething #slide02 .slidesjs-slide-01 .desc").delay(10).animate({"left":"50%", "opacity":"1"},500);
				$(".heySomething #slide02 .slidesjs-slide-02 .desc").delay(10).animate({"margin-left":"223px", "opacity":"1"},500);
				$(".heySomething #slide02 .slidesjs-slide-03 .desc").delay(10).animate({"left":"50%", "opacity":"1"},500);
				$(".heySomething #slide02 .slidesjs-slide-04 .desc").delay(10).animate({"left":"50%", "opacity":"1"},500);
			}
		}
	});

	$(".slidesjs-pagination li:nth-child(1)").addClass("page01");
	$(".slidesjs-pagination li:nth-child(2)").addClass("page02");
	$(".slidesjs-pagination li:nth-child(3)").addClass("page03");
	$(".slidesjs-pagination li:nth-child(4)").addClass("page04");


	//mouse control
	$('#slide01 .slidesjs-pagination > li a, #slide02 .slidesjs-pagination > li a').mouseenter(function(){
		$('a[data-slidesjs-item="' + $(this).attr("data-slidesjs-item") + '"]').trigger('click');
	});

	$(".slidesjs-pagination li:nth-child(1)").addClass("num01");
	$(".slidesjs-pagination li:nth-child(2)").addClass("num02");
	$(".slidesjs-pagination li:nth-child(3)").addClass("num03");
	$(".slidesjs-pagination li:nth-child(4)").addClass("num04");

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
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 800 ) {
			itemAnimation()
		}
		if (scrollTop > 3400 ) {
			brandAnimation()
		}
		if (scrollTop > 4600 ) {
			characterAnimation1();
		}
		if (scrollTop > 5200 ) {
			characterAnimation2();
		}
		if (scrollTop > 5900 ) {
			characterAnimation3();
		}
		if (scrollTop > 6700 ) {
			characterAnimation4();
		}
		if (scrollTop > 8000 ) {
			finishAnimation();
		}
	});

	/* title animation */
	titleAnimation()
	$(".heySomething .topic h2 span").css({"width":"50px", "opacity":"0"});
	function titleAnimation() {
		$(".heySomething .topic h2 .letter1").delay(100).animate({"width":"125px", "opacity":"1"},1200);
		$(".heySomething .topic h2 .letter2").delay(300).animate({"width":"349px", "opacity":"1"},1200);
		$(".heySomething .topic h2 .letter3").delay(500).animate({"width":"206px", "opacity":"1"},1200);
	}

	/* item animation */
	$(".heySomething .item h3 span").css({"opacity":"0"});
	$(".heySomething .item h3 .disney").css({"left":"502px"});
	$(".heySomething .item h3 .tenten").css({"left":"528px"});
	function itemAnimation() {
		$(".heySomething .item h3 .disney").delay(200).animate({"left":"402px", "opacity":"1"},1000);
		$(".heySomething .item h3 .tenten").delay(200).animate({"left":"628px", "opacity":"1"},1000);
		$(".heySomething .item h3 .horizontalLine1").delay(1000).animate({"opacity":"1"},500);
		$(".heySomething .item h3 .horizontalLine2").delay(1000).animate({"opacity":"1"},500);
		$(".heySomething .item h3 .verticalLine").delay(1000).animate({"opacity":"1"},500);
	}

	/* mickey character animation */
	$(".mickey .animation span").css({"opacity":"0"});
	$(".mickey .animation .violin").css({"top":"-80px"});
	$(".mickey .animation .airplane").css({"top":"350px", "left":"0"});
	function characterAnimation1() {
		$(".mickey .animation .violin").delay(50).animate({"top":"-42px", "opacity":"1"},1200);
		$(".mickey .animation .airplane").delay(500).animate({"top":"288px", "left":"40px", "opacity":"1"},800);
		$(".mickey .animation .bang").delay(1000).animate({"opacity":"1"},1200);
		$(".mickey .animation .fight").delay(1000).animate({"opacity":"1"},1200);
	}

	$(".mickey .animation .parachute").css({"top":"0", "left":"50px"});
	function characterAnimation2() {
		$(".mickey .animation .balloon").delay(100).animate({"opacity":"1"},1200);
		$(".mickey .animation .parachute").delay(500).animate({"top":"32px", "left":"157px", "opacity":"1"},1200);
		$(".mickey .animation .seesaw").delay(1000).animate({"opacity":"1"},1200);
	}

	$(".mickey .animation .voyage").css({"right":"0"});
	function characterAnimation3() {
		$(".mickey .animation .climbing").delay(100).animate({"opacity":"1"},1200);
		$(".mickey .animation .pull").delay(500).animate({"opacity":"1"},1200);
		$(".mickey .animation .voyage").delay(1000).animate({"right":"86px", "opacity":"1"},1200);
	}

	function characterAnimation4() {
		$(".mickey .character").addClass("rollIn");
	}

	/* brand animation */
	$(".heySomething .brand p").css({"height":"50px", "opacity":"0"});
	$(".heySomething .brand .btnDown").css({"opacity":"0"});
	function brandAnimation() {
		$(".heySomething .brand p").delay(50).animate({"height":"377px", "opacity":"1"},1200);
		$(".heySomething .brand .btnDown").delay(800).animate({"opacity":"1"},1200);
	}

	/* finish animation */
	function finishAnimation() {
		$(".heySomething .finish p").addClass("rotateIn");
	}
});
</script>
<% set oItem=nothing %>
<!-- #include virtual="/lib/db/dbclose.asp" -->