<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈 20
' History : 2016-02-16 원승현 생성
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
	eCode   =  66031
Else
	eCode   =  68959
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

dim itemid 
Dim hspchk
'// 현재 주소값 체크하여 신규, 구버전 확인
hspchk = Split(LCase(Request.ServerVariables("PATH_INFO")),"/")
%>
<style type="text/css">
@import url(http://fonts.googleapis.com/earlyaccess/nanumgothic.css);

/* title */
.heySomething .topic {background:#5d3409 url(http://webimage.10x10.co.kr/eventIMG/2016/hey/68959/img_item_represent.jpg) no-repeat 50% 0;}
.heySomething .topic h2 span {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_hey_something_project_white.png);}
.heySomething .topic .bnr {text-indent:-9999em;}
.heySomething .topic .bnr a {display:block; width:100%; height:780px;}

/* item */
.heySomething .itemC ul {position:relative; width:1140px; height:812px; margin:0 auto;}
.heySomething .itemC ul li {position:absolute;}
.heySomething .itemC ul li a {overflow:hidden; display:block; position:relative;}
.heySomething .itemC ul li a img {transition:transform 1s ease-in-out;}
.heySomething .itemC ul li a:hover img {transform:scale(1.1);}
.heySomething .itemC ul li a div {position:absolute; top:0; left:0; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/68959/bg_mask.png) repeat 0 0; text-align:center;}
.heySomething .itemC ul li a div {transition:opacity 0.7s ease-out; opacity:0; filter: alpha(opacity=0);}
.heySomething .itemC ul li a div span {display:table; width:100%; height:100%; color:#fff; font-family:'Nanum Gothic', sans-serif; font-size:15px; font-weight:bold; text-shadow:0 2px 3px #000;}
.heySomething .itemC ul li a div span i {display:table-cell; width:100%; font-style:normal; vertical-align:middle;}
.heySomething .itemC ul li a:hover div {opacity:1; filter: alpha(opacity=100); height:100%;}
.heySomething .itemC ul li.size319x319 {width:319px; height:319px;}
.heySomething .itemC ul li.size319x155 {width:319px; height:155px;}
.heySomething .itemC ul li.size155x155 {width:155px; height:155px;}
.heySomething .itemC ul li.size155x319 {width:155px; height:319px;}
.heySomething .itemC ul li.size237x483 {width:237px; height:483px;}
.heySomething .itemC ul li.size237x237 {width:237px; height:237px;}

.itemC ul li:nth-of-type(2) {animation-delay:0.2s;}
.itemC ul li:nth-of-type(3) {animation-delay:0.3s;}
.itemC ul li:nth-of-type(4) {animation-delay:0.4s;}
.itemC ul li:nth-of-type(5) {animation-delay:0.5s;}
.itemC ul li:nth-of-type(6) {animation-delay:0.2s;}
.itemC ul li:nth-of-type(7) {animation-delay:0.4s;}
.itemC ul li:nth-of-type(8) {animation-delay:0.5s;}
.itemC ul li:nth-of-type(9) {animation-delay:.0.3s;}
.itemC ul li:nth-of-type(10) {animation-delay:0.4s;}
.itemC ul li:nth-of-type(11) {animation-delay:0.2s;}
.itemC ul li:nth-of-type(12) {animation-delay:0.4s;}
.itemC ul li:nth-of-type(13) {animation-delay:0.5s;}
.itemC ul li:nth-of-type(14) {animation-delay:0.4s;}
.itemC ul li:nth-of-type(15) {animation-delay:0.2s;}

@keyframes fadeInSlideUp {
	0% {opacity:0; transform: translateY(50px);}
	100% {opacity:1;}
}
.fadeInSlideUp{opacity: 0; animation: fadeInSlideUp 1s cubic-bezier(0.2, 0.3, 0.25, 0.9) forwards;}

.heySomething .itemC ul li.item01 {top:0; left:0;}
.heySomething .itemC ul li.item02 {top:328px; left:0;}
.heySomething .itemC ul li.item03 {top:328px; left:164px;}
.heySomething .itemC ul li.item04 {top:0; left:328px;}
.heySomething .itemC ul li.item05 {top:0; left:492px;}
.heySomething .itemC ul li.item06 {top:164px; left:328px;}
.heySomething .itemC ul li.item07 {top:0; left:657px;}
.heySomething .itemC ul li.item08 {top:0; right:0;}
.heySomething .itemC ul li.item09 {top:246px; right:0;}
.heySomething .itemC ul li.item10 {bottom:0; left:0;}
.heySomething .itemC ul li.item11 {bottom:0; left:328px;}
.heySomething .itemC ul li.item12 {bottom:164px; left:656px;}
.heySomething .itemC ul li.item13 {bottom:164px; left:820px;}
.heySomething .itemC ul li.item14 {bottom:0; left:656px;}
.heySomething .itemC ul li.item15 {bottom:0; right:0;}

/* brand */
.heySomething .brand {position:relative; height:740px;}
.heySomething .brand h3 {position:relative; width:239px; height:36px; margin:0 auto;}
.heySomething .brand h3 span {position:absolute; top:0; height:36px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/68959/tit_hidehide.png) no-repeat 0 0; text-indent:-9999em; transition:1.5s ease-in-out; transform-origin:60% 0%; transform:rotateY(180deg); opacity:0;}
.heySomething .brand h3 .letter1 {left:0; width:28px;}
.heySomething .brand h3 .letter2 {left:37px; width:8px; background-position:-37px 0;}
.heySomething .brand h3 .letter3 {left:52px; width:31px; background-position:-52px 0;}
.heySomething .brand h3 .letter4 {left:92px; width:28px; background-position:-92px 0;}
.heySomething .brand h3 .letter5 {left:126px; width:30px; background-position:-126px 0;}
.heySomething .brand h3 .letter6 {left:163px; width:7px; background-position:-163px 0;}
.heySomething .brand h3 .letter7 {left:180px; width:28px; background-position:-180px 0;}
.heySomething .brand h3 .letter8 {left:214px; width:25px; background-position:-214px 0;}
.heySomething .brand h3 span.rerotate {transform:rotateY(0deg); opacity:1;}
.heySomething .brand .sea {margin-top:40px;}
.heySomething .brand p {margin-top:50px; margin-bottom:80px;}

/* story */
.heySomething .story {padding-bottom:0;}
.heySomething .story h3 {margin-bottom:70px;}
.heySomething .rolling {width:1140px; margin:0 auto; padding-top:0;}
.heySomething .slide {position:relative;}
.heySomething .slide .slidesjs-slide {position:relative; height:785px;}
.heySomething .slide .desc {position:absolute; bottom:0; left:0; width:1140px; height:145px; background-color:#ffe267; text-align:left;}
.heySomething .slide .desc .bg {position:absolute; bottom:0; left:0; width:1140px; height:145px; background-color:#ffe267;}
.heySomething .slide .desc p {position:relative; z-index:5; margin:51px 0 0 132px;}
.heySomething .slide .slidesjs-slide-02 .desc .bg {background-color:#ffb074;}
.heySomething .slide .slidesjs-slide-03 .desc .bg {background-color:#ffcbea;}
.heySomething .slide .slidesjs-slide-04 .desc .bg {background-color:#8fd7fd;}
.heySomething .slide .slidesjs-slide-05 .desc .bg {background-color:#7dc387;}
.heySomething .slide .slidesjs-slide .item li {position:absolute; z-index:10;}
.heySomething .slide .slidesjs-slide .item img {transition:transform .7s ease;}
.heySomething .slide .slidesjs-slide .item a:hover img {transform:rotate(360deg);}
.heySomething .slide .slidesjs-slide-01 .item li.item01 {top:237px; left:200px;}
.heySomething .slide .slidesjs-slide-01 .item li.item02 {top:357px; left:388px;}
.heySomething .slide .slidesjs-slide-01 .item li.item03 {top:130px; left:526px;}
.heySomething .slide .slidesjs-slide-01 .item li.item04 {top:89px; left:701px;}
.heySomething .slide .slidesjs-slide-01 .item li.item05 {top:146px; right:149px;}
.heySomething .slide .slidesjs-slide-01 .item li.item06 {top:314px; right:233px;}
.heySomething .slide .slidesjs-slide-01 .item li.item07 {top:466px; right:39px;}

.heySomething .slide .slidesjs-slide-02 .item li.item01 {top:123px; left:136px;}
.heySomething .slide .slidesjs-slide-02 .item li.item02 {top:325px; left:393px;}
.heySomething .slide .slidesjs-slide-02 .item li.item03 {top:255px; left:545px;}
.heySomething .slide .slidesjs-slide-02 .item li.item04 {top:73px; right:201px;}
.heySomething .slide .slidesjs-slide-02 .item li.item05 {top:211px; right:165px;}
.heySomething .slide .slidesjs-slide-02 .item li.item06 {top:432px; right:336px;}

.heySomething .slide .slidesjs-slide-03 .item li.item01 {top:182px; left:124px;}
.heySomething .slide .slidesjs-slide-03 .item li.item02 {top:332px; left:104px;}
.heySomething .slide .slidesjs-slide-03 .item li.item03 {top:50px; left:284px;}
.heySomething .slide .slidesjs-slide-03 .item li.item04 {top:180px; left:494px;}
.heySomething .slide .slidesjs-slide-03 .item li.item05 {top:91px; left:678px;}
.heySomething .slide .slidesjs-slide-03 .item li.item06 {top:102px; right:109px;}
.heySomething .slide .slidesjs-slide-03 .item li.item07 {top:254px; right:159px;}

.heySomething .slide .slidesjs-slide-04 .item li.item01 {top:383px; left:62px;}
.heySomething .slide .slidesjs-slide-04 .item li.item02 {top:338px; left:287px;}
.heySomething .slide .slidesjs-slide-04 .item li.item03 {top:268px; left:480px;}
.heySomething .slide .slidesjs-slide-04 .item li.item04 {top:328px; right:424px;}
.heySomething .slide .slidesjs-slide-04 .item li.item05 {top:240px; right:48px;}

.heySomething .slide .slidesjs-slide-05 .item {position:absolute; top:166px; left:545px; z-index:10;}

.heySomething .slide .slidesjs-navigation {position:absolute; z-index:10; top:50%; width:93px; height:64px; margin-top:-32px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/68959/btn_nav.png) no-repeat 0 0; text-indent:-999em;}
.heySomething .slide .slidesjs-previous {left:0;}
.heySomething .slide .slidesjs-next {right:0; background-position:100% 0;}

/* finish */
.heySomething .finish {height:799px; background:#753a0c url(http://webimage.10x10.co.kr/eventIMG/2016/hey/68959/bg_finish.jpg) no-repeat 50% 0;}
.heySomething .finish a {position:relative; display:block; width:100%; height:100%;}
.heySomething .finish p {position:absolute; top:245px; left:50%; width:135px; height:50px; margin-left:285px;}
.heySomething .finish p span {position:absolute; width:135px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/68959/txt_finish.png) no-repeat 0 0; text-indent:-9999em;}
.heySomething .finish p .letter1 {top:0; left:0; height:22px;}
.heySomething .finish p .letter2 {right:0; bottom:0; height:18px; margin-top:0; background-position:0 100%;}

/* comment */
.heySomething .commentevet .form .choice {margin-bottom:33px;}
.heySomething .commentevet .form .choice li {width:131px; height:151px; margin-right:35px;}
.heySomething .commentevet .form .choice li.ico4 {margin-right:27px;}
.heySomething .commentevet .form .choice li.ico5 {width:145px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/68959/bg_ico_v2.jpg);}
.heySomething .commentevet .form .choice li.ico2 button {background-position:-167px 0;}
.heySomething .commentevet .form .choice li.ico2 button.on {background-position:-167px 100%;}
.heySomething .commentevet .form .choice li.ico3 button {background-position:-334px 0;}
.heySomething .commentevet .form .choice li.ico3 button.on {background-position:-334px 100%;}
.heySomething .commentevet .form .choice li.ico4 button {background-position:-501px 0;}
.heySomething .commentevet .form .choice li.ico4 button.on {background-position:-501px 100%;}
.heySomething .commentevet .form .choice li.ico5 button {background-position:-660px 0;}
.heySomething .commentevet .form .choice li.ico5 button.on {background-position:-660px 100%;}

.heySomething .commentlist table td strong {width:145px; height:151px; margin:0 auto; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/68959/bg_ico_v2.jpg); background-position:0 0;}
.heySomething .commentlist table td .ico2 {background-position:-167px 0;}
.heySomething .commentlist table td .ico3 {background-position:-334px 0;}
.heySomething .commentlist table td .ico4 {background-position:-501px 0;}
.heySomething .commentlist table td .ico5 {background-position:-660px 0;}
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
		<% If not( left(currenttime,10)>="2016-02-16" and left(currenttime,10)<"2016-02-24" ) Then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return false;
		<% else %>
			<% if commentcount>4 then %>
				alert("이벤트는 5회까지 참여 가능 합니다.");
				return false;
			<% else %>
				if (frm.gubunval.value == ''){
					alert('원하는 스타일을 선택해 주세요.');
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
			<div class="bnr"><a href="/street/street_brand_sub06.asp?makerid=HIGHTIDE&amp;pEtr=68959">HIGHTIDE</a></div>
		</div>

		<%' about %>
		<div class="about">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
			<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
		</div>

		<%' item %>
		<div class="item itemC">
			<ul>
				<li class="item01 size319x319">
					<a href="/shopping/category_prd.asp?itemid=1423342&amp;pEtr=68959">
						<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68959/img_item_01.jpg" width="319" height="319" alt="" />
						<div><span><i>Penco Clampy Clip Color<br /> ￦4,300</i></span></div>
					</a>
				</li>
				<li class="item02 size155x155">
					<a href="/shopping/category_prd.asp?itemid=1423411&amp;pEtr=68959">
						<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68959/img_item_02.jpg" width="155" height="155" alt="" />
						<div><span><i>Sticky Memo<br /> ￦7,800</i></span></div>
					</a>
				</li>
				<li class="item03 size155x155">
					<a href="/shopping/category_prd.asp?itemid=1423415&amp;pEtr=68959">
						<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68959/img_item_03.jpg" width="155" height="155" alt="" />
						<div><span><i>Metal Book Stand<br /> ￦12,400</i></span></div>
					</a>
				</li>
				<li class="item04 size155x155">
					<a href="/shopping/category_prd.asp?itemid=1423338&amp;pEtr=68959">
						<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68959/img_item_04.jpg" width="155" height="155" alt="" />
						<div><span><i>Penco Clampy Clip Gold<br /> ￦2,800</i></span></div>
					</a>
				</li>
				<li class="item05 size155x155">
					<a href="/shopping/category_prd.asp?itemid=1423409&amp;pEtr=68959">
						<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68959/img_item_05.jpg" width="155" height="155" alt="" />
						<div><span><i>Penco Clipboard O/S Gold<br /> ￦10,000</i></span></div>
					</a>
				</li>
				<li class="item06 size319x319">
					<a href="/shopping/category_prd.asp?itemid=1423449&amp;pEtr=68959">
						<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68959/img_item_06.jpg" width="319" height="319" alt="" />
						<div><span><i>Ifuku Kazuhiko Reading Paper Box<br /> ￦16,000</i></span></div>
					</a>
				</li>
				<li class="item07 size237x483">
					<a href="/shopping/category_prd.asp?itemid=1423443&amp;pEtr=68959">
						<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68959/img_item_07.jpg" width="237" height="483" alt="" />
						<div><span><i>Smart Card Case<br /> ￦34,000</i></span></div>
					</a>
				</li>
				<li class="item08 size237x237">
					<a href="/shopping/category_prd.asp?itemid=1423414&amp;pEtr=68959">
						<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68959/img_item_08.jpg" width="237" height="237" alt="" />
						<div><span><i>Little Toy Pocket Album <!-- - House --><br /> ￦31,000</i></span></div>
					</a>
				</li>
				<li class="item09 size237x237">
					<a href="/shopping/category_prd.asp?itemid=1423413&amp;pEtr=68959">
						<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68959/img_item_09.jpg" width="237" height="237" alt="" />
						<div><span><i>Standing Notes <!-- - World Sports --><br /> ￦6,500</i></span></div>
					</a>
				</li>
				<li class="item10 size319">
					<a href="/shopping/category_prd.asp?itemid=1423439&amp;pEtr=68959">
						<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68959/img_item_10.jpg" width="319" height="319" alt="" />
						<div><span><i>Bankbook Case <!-- Classic--><br /> ￦16,000</i></span></div>
					</a>
				</li>
				<li class="item11 size319">
					<a href="/shopping/category_prd.asp?itemid=1423426&amp;pEtr=68959">
						<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68959/img_item_11.jpg" width="319" height="319" alt="" />
						<div><span><i>Viale Book Marker<br /> ￦3,800</i></span></div>
					</a>
				</li>
				<li class="item12 width155A">
					<a href="/shopping/category_prd.asp?itemid=1423419&amp;pEtr=68959">
						<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68959/img_item_12.jpg" width="155" height="155" alt="" />
						<div><span><i>Three Wire Display Stand<br /> ￦2,800</i></span></div>
					</a>
				</li>
				<li class="item13 size155x155">
					<a href="/shopping/category_prd.asp?itemid=1423440&amp;pEtr=68959">
						<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68959/img_item_13.jpg" width="155" height="155" alt="" />
						<div><span><i>Pass&amp;Card Case <!-- - Classic --><br /> ￦11,000</i></span></div>
					</a>
				</li>
				<li class="item14 size319x155">
					<a href="/shopping/category_prd.asp?itemid=1423445&amp;pEtr=68959">
						<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68959/img_item_14.jpg" width="319" height="155" alt="" />
						<div><span><i>Wire Clip Bookmarker<br /> ￦7,500</i></span></div>
					</a>
				</li>
				<li class="item15 size155x319">
					<a href="/shopping/category_prd.asp?itemid=1423410&amp;pEtr=68959">
						<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68959/img_item_15.jpg" width="155" height="319" alt="" />
						<div><span><i>Penco Storage Container<br /> ￦23,000</i></span></div>
					</a>
				</li>
			</ul>
		</div>

		<%' brand %>
		<div id="brandAnimation" class="brand">
			<h3>
				<span class="letter1">H</span>
				<span class="letter2">I</span>
				<span class="letter3">D</span>
				<span class="letter4">E</span>
				<span class="letter5">H</span>
				<span class="letter6">I</span>
				<span class="letter7">D</span>
				<span class="letter8">E</span>
			</h3>
			<div class="sea"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68959/img_sea.jpg" alt="" /></div>
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68959/txt_brand.png" alt="High tide가 가진 만조라는 뜻처럼 HIGHTIDE라는 이름은 언제나 가득 채워져 있는 느낌을 줍니다. 마음까지 채울 수 있는 제품을 만들고자 하는 생각에서 시작하였습니다. 당신의 개인적인 일상과 작업 공간 사이를 긍정적인 기운으로 풍족하게 채워 주는 그런 제품들. HIGHTIDE로 인해 당신의 생활과 마음 모두, 가득 채워지기를 바랍니다." /></p>
			<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="" /></div>
		</div>

		<%' story %>
		<div class="story">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68959/tit_story.png" alt="DELIVER FULFILLING PRODUCTS" /></h3>
			<div class="rolling">
				<div id="slide" class="slide">
					<div class="slidesjs-slide-01">
						<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68959/img_slide_01.jpg" width="1140" height="785" alt="" />
						<ul class="item">
							<li class="item01">
								<a href="/shopping/category_prd.asp?itemid=1423342&amp;pEtr=68959"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68959/btn_plus.png" alt="Penco Clampy Clip Color" /></a>
							</li>
							<li class="item02">
								<a href="/shopping/category_prd.asp?itemid=1423354&amp;pEtr=68959"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68959/btn_plus.png" alt="Penco Clipboard O/S A5" /></a>
							</li>
							<li class="item03">
								<a href="/shopping/category_prd.asp?itemid=1423355&amp;pEtr=68959"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68959/btn_plus.png" alt="Penco Clipboard O/S A4" /></a>
							</li>
							<li class="item04">
								<a href="/shopping/category_prd.asp?itemid=1423339&amp;pEtr=68959"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68959/btn_plus.png" alt="Penco Clampy Clip Silver M" /></a>
							</li>
							<li class="item05">
								<a href="/shopping/category_prd.asp?itemid=1423341&amp;pEtr=68959"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68959/btn_plus.png" alt="Penco Clampy Clip Gold M" /></a>
							</li>
							<li class="item06">
								<a href="/shopping/category_prd.asp?itemid=1423409&amp;pEtr=68959"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68959/btn_plus.png" alt="Penco Clipboard O/S Gold A4" /></a>
							</li>
							<li class="item07">
								<a href="/shopping/category_prd.asp?itemid=1423345&amp;pEtr=68959"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68959/btn_plus.png" alt="Penco Clipboard O/S Check" /></a>
							</li>
						</ul>
						<div class="desc">
							<div class="bg"></div>
							<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68959/txt_desc_01.png" alt="Collection #1 OLD-SCHOOL CLIP클릭 몇 번이면 온갖 것들이 한 폴더에 담기는 요즘 시대의 가장 아날로그적인 ‘묶음’ 도구, 클립과 클립보드. 조금은 투박하지만 종이냄새 물씬 나는, 나만의 빈티지 클립 컬렉션." /></p>
						</div>
					</div>
					<div class="slidesjs-slide-02">
						<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68959/img_slide_02.jpg" width="1140" height="785" alt="" />
						<ul class="item">
							<li class="item01">
								<a href="/shopping/category_prd.asp?itemid=1423437&amp;pEtr=68959"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68959/btn_plus.png" alt="Document Case A4 Classic" /></a>
							</li>
							<li class="item02">
								<a href="/shopping/category_prd.asp?itemid=1423443&amp;pEtr=68959"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68959/btn_plus.png" alt="Smart Card Case" /></a>
							</li>
							<li class="item03">
								<a href="/shopping/category_prd.asp?itemid=1423439&amp;pEtr=68959"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68959/btn_plus.png" alt="Bankbook Case Classic" /></a>
							</li>
							<li class="item04">
								<a href="/shopping/category_prd.asp?itemid=1423442&amp;pEtr=68959"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68959/btn_plus.png" alt="Case Holder 2P Classic" /></a>
							</li>
							<li class="item05">
								<a href="/shopping/category_prd.asp?itemid=1423441&amp;pEtr=68959"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68959/btn_plus.png" alt="Case Holder 1P Classic" /></a>
							</li>
							<li class="item06">
								<a href="/shopping/category_prd.asp?itemid=1423440&amp;pEtr=68959"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68959/btn_plus.png" alt="Pass&amp;Card Case Classic" /></a>
							</li>
						</ul>
						<div class="desc">
							<div class="bg"></div>
							<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68959/txt_desc_02.png" alt="Collection #2 MY IMPORTANT 독일어로 나의 중요한 이라는 뜻의 MEINE WICHTIGE. 서류, 통장, 명함, 여권이야말로 종이로 된 것들 중 개인에게 가장 중요한 것. 중요한 것을 가장 멋스럽게 담을 수 있는 아이템." /></p>
						</div>
					</div>
					<div class="slidesjs-slide-03">
						<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68959/img_slide_03.jpg" width="1140" height="785" alt="" />
						<ul class="item">
							<li class="item01">
								<a href="/shopping/category_prd.asp?itemid=1423444&amp;pEtr=68959"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68959/btn_plus.png" alt="Shoehorn Keychain" /></a>
							</li>
							<li class="item02">
								<a href="/shopping/category_prd.asp?itemid=1423449&amp;pEtr=68959"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68959/btn_plus.png" alt="Ifuku Kazuhiko Reading Paper Box" /></a>
							</li>
							<li class="item03">
								<a href="/shopping/category_prd.asp?itemid=1423413&amp;pEtr=68959"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68959/btn_plus.png" alt="Standing Notes World Sports" /></a>
							</li>
							<li class="item04">
								<a href="/shopping/category_prd.asp?itemid=1423411&amp;pEtr=68959"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68959/btn_plus.png" alt="Sticky Memo Funny Face" /></a>
							</li>
							<li class="item05">
								<a href="/shopping/category_prd.asp?itemid=1423412&amp;pEtr=68959"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68959/btn_plus.png" alt="Standing Notes" /></a>
							</li>
							<li class="item06">
								<a href="/shopping/category_prd.asp?itemid=1423414&amp;pEtr=68959"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68959/btn_plus.png" alt="Little Toy Pocket Album House" /></a>
							</li>
							<li class="item07">
								<a href="/shopping/category_prd.asp?itemid=1423447&amp;pEtr=68959"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68959/btn_plus.png" alt="Penco Bat pen" /></a>
							</li>
						</ul>
						<div class="desc">
							<div class="bg"></div>
							<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68959/txt_desc_03.png" alt="Collection #3 HAPPY VIRUS 생동감 넘치는 접착 메모지, 집 모양 앨범, 야구배트 펜, 책처럼 생긴 수납 박스… 소소한 아이디어들이 일상 가득 해피 바이러스로! 바쁜 하루를 지내다 시선이 멈췄을 때 조금은 행복해지는 작은 사치." /></p>
						</div>
					</div>
					<div class="slidesjs-slide-04">
						<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68959/img_slide_04.jpg" width="1140" height="785" alt="" />
						<ul class="item">
							<li class="item01">
								<a href="/shopping/category_prd.asp?itemid=1423445&amp;pEtr=68959"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68959/btn_plus.png" alt="Wire Clip Bookmarker" /></a>
							</li>
							<li class="item02">
								<a href="/shopping/category_prd.asp?itemid=1423429&amp;pEtr=68959"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68959/btn_plus.png" alt="Ifuku Pen Hook Clips" /></a>
							</li>
							<li class="item03">
								<a href="/shopping/category_prd.asp?itemid=1423415&amp;pEtr=68959"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68959/btn_plus.png" alt="Metal Book Stand" /></a>
							</li>
							<li class="item04">
								<a href="/shopping/category_prd.asp?itemid=1423426&amp;pEtr=68959"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68959/btn_plus.png" alt="Viale Book Marker" /></a>
							</li>
							<li class="item05">
								<a href="/shopping/category_prd.asp?itemid=1423419&amp;pEtr=68959"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68959/btn_plus.png" alt="Three Wire Display Stand S" /></a>
							</li>
						</ul>
						<div class="desc">
							<div class="bg"></div>
							<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68959/txt_desc_04.png" alt="Collection #4 BOOKWORM 책벌레의 기본 아이템은 뭐니뭐니해도 북마크와 북스탠드. 다양한 사이즈의 북스탠드부터 페이지를 고정시키거나 펜을 꽂을 수 있는 북마크까지. 독서의 품격을 높여줄 아이템으로 풍성해지는 마음의 양식." /></p>
						</div>
					</div>
					<div class="slidesjs-slide-05">
						<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68959/img_slide_05.jpg" width="1140" height="785" alt="" />
						<div class="item">
							<a href="/shopping/category_prd.asp?itemid=1423410&amp;pEtr=68959"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68959/btn_plus.png" alt="Penco Storage Container" /></a>
						</div>
						<div class="desc">
							<div class="bg"></div>
							<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68959/txt_desc_05.png" alt="Collection #5 STORAGE IN STORAGE 선물 상자를 열면 또 다른 선물상자가 나오듯, 4개의 수납박스가 한 번에. 살 때마다 사이즈로 고민하던 수납박스 대신 하나하나 채워 차곡차곡 쌓아 놓는 재미로 가득." /></p>
						</div>
					</div>
				</div>
			</div>
		</div>

		<%' finish %>
		<div id="finishAnimation" class="finish">
			<a href="/street/street_brand_sub06.asp?makerid=HIGHTIDE&amp;pEtr=68959">
				<p>
					<span class="letter1">일상 가득히</span>
					<span class="letter2">HIGHTIDE</span>
				</p>
			</a>
		</div>

		<%' comment %>
		<div class="commentevet">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68959/tit_comment.png" alt="Hey, something project 당신이 갖고 싶은 것" /></h3>
			<p class="hidden">HIGHTIDE 상품 중 가장 탐나는 상품은 무엇인가요? 정성껏 코멘트를 남겨주신 3분을 추첨하여 해당 컬렉션의 상품을 드립니다. 상품은 랜덤발송입니다. 코멘트 작성 기간은 2016년 2월 17일부터 2월 23일까지며 발표일은 2월 25일입니다.</p>
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
							<li class="ico1"><button type="button" value="1">OLD-SCHOOL CLIP</button></li>
							<li class="ico2"><button type="button" value="2">MY IMPORTANT</button></li>
							<li class="ico3"><button type="button" value="3">HAPPY VIRUS</button></li>
							<li class="ico4"><button type="button" value="4">BOOKWORM</button></li>
							<li class="ico5"><button type="button" value="5">STORAGE IN STORAGE</button></li>
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

			<% '' commentlist %>
			<div class="commentlist" id="commentlist">
				<p class="total">total <%= iCTotCnt %></p>
				<% IF isArray(arrCList) THEN %>
					<table>
						<caption>코멘트 목록</caption>
						<colgroup>
							<col style="width:180px;" />
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
												OLD-SCHOOL CLIP
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="2" then %>
												MY IMPORTANT
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="3" then %>
												HAPPY VIRUS
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="4" then %>
												BOOKWORM
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="5" then %>
												STORAGE IN STORAGE
											<% Else %>
												OLD-SCHOOL CLIP
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
		<%'' // 수작업 영역 끝 %>

<% If Not(Trim(hspchk(1)))="hsproject" Then %>
	</div>
<% End If %>
<script type="text/javascript">

$(function(){
	/* slide js */
	$("#slide").slidesjs({
		width:"1140",
		height:"785",
		pagination:false,
		navigation:{effect:"fade"},
		play:{interval:3500, effect:"fade", auto:false},
		effect:{fade: {speed:1000, crossfade:true}},
		callback: {
			start: function() {
				$(".heySomething #slide .slidesjs-slide .desc .bg").css({"width":"0", "opacity":"0"});
				$(".heySomething #slide .slidesjs-slide .desc p").css({"margin-top":"56px", "opacity":"0"});
			},
			complete: function() {
				$(".heySomething #slide .slidesjs-slide .desc .bg").delay(10).animate({"width":"1140px", "opacity":"1"},200);
				$(".heySomething #slide .slidesjs-slide .desc p").delay(10).animate({"margin-top":"51px", "opacity":"1"},500);
			}
		}
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
		if (scrollTop > 800 ) {
			slideUpAnimation();
		}
		if (scrollTop > 1900) {
			brandAnimation();
		}
		if (scrollTop > 5000) {
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

	/* slideUp animation */
	function slideUpAnimation () {
		$(".heySomething .itemC ul li").addClass("fadeInSlideUp");
	}

	/* brand animation */
	function brandAnimation() {
		$("#brandAnimation h3 span").delay(200).addClass("rerotate", "slow");
	}

	/* finish animation */
	$("#finishAnimation p span").css({"opacity":"0"});
	$("#finishAnimation p .letter1").css({"left":"-100px"});
	$("#finishAnimation p .letter2").css({"right":"-100px"});

	function finishAnimation() {
		$("#finishAnimation p .letter1").delay(100).animate({"left":"0", "opacity":"1"},1000);
		$("#finishAnimation p .letter2").delay(100).animate({"right":"0", "opacity":"1"},1000);
	}

});
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->