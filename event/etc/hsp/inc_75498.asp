<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈
' History : 2017-01-10 원승현 생성
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
	eCode   =  66263
Else
	eCode   =  75498
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
.heySomething .topic {background-color:#ffe5f9; z-index:1;}

/* item */
.heySomething .itemB {height:1020px; padding-bottom:0; margin-top:365px; background:none;}
.heySomething .itemB .plus {position:absolute; left:50%; top:630px; margin-left:-22px;}
.heySomething .itemB a.goItem {display:block;}
.heySomething .itemB .desc {padding:38px 0 0 695px; min-height:auto;}
.heySomething .itemB .desc .option {top:134px; left:136px;}
.heySomething .itemB .option {height:auto;}
.heySomething .itemB .option .price {margin-top:45px; height:auto;}
.heySomething .itemB .option .substance {position:static; padding-top:85px;}
.heySomething .itemB .option .btnget {position:static; padding-top:43px;}
.heySomething .itemB .desc .slidewrap .slide {width:318px; height:466px; text-align:center; vertical-align:middle;}
.heySomething .itemB .desc .slidewrap .slide .slide03{margin-top:80px;}
.heySomething .itemB .desc .slidesjs-pagination {display:none;}

/* visual */
.heySomething .visual {position:relative; margin-top:43px;}
.heySomething .with {text-align:center;}
.heySomething .with p {margin:35px 0 28px;}
.heySomething #slider {margin-top:34px;}
.heySomething #slider .slide-img {display:table; position:relative; width:auto; height:231px; margin:0 65px;}
.heySomething #slider .slide-img a {display:table-cell; vertical-align:bottom;}
.heySomething #slider .slide-img a:hover {text-decoration:none;}
.heySomething #slider .slide-img .name {margin-top:18px;}
.heySomething .visual .arrow {text-align: center; margin-top:50px;}

/* items */
.heySomething .items {text-align:center; margin-top:415px;}
.heySomething .items ul {position:relative; width:1140px; height:675px; margin:0 auto;}
.heySomething .items li {position:absolute; overflow:hidden;}
.heySomething .items li a {cursor:pointer;}
.heySomething .items li.item01 {left:0; top:0; width:444px; height:675px; background-color:#ccf1ff;}
.heySomething .items li.item02 {left:464px; top:0; width:446px; height:212px; background-color:#f4f4f5;}
.heySomething .items li.item03 {right:0; top:0; width:212px; height:212px; background-color:#dfcbf3;}
.heySomething .items li.item04 {left:464px; top:232px; width:212px; height:212px; background-color:#91e8f2;}
.heySomething .items li.item05 {left:464px; bottom:0; width:212px; height:212px; background-color:#ffcded;}
.heySomething .items li.item06 {right:0; bottom:0; width:444px; height:444px; background-color:#fee1fc;}
@keyframes pulse {
	0% {transform:scale(1.2);}
	100% {transform:scale(1);}
}
.pulse {animation-name:pulse; animation-duration:2s; animation-iteration-count:1;}

/* brand */
.heySomething .brand {position:relative; height:721px; margin-top:450px; background:#b82db9 url(http://webimage.10x10.co.kr/eventIMG/2017/hey/75498/bg_brand.jpg) 50% 50% no-repeat;}
.heySomething .brand .text p:first-child{position:absolute; top:-146px; left:50%; margin-left:-202px; }
.heySomething .brand .text {padding:237px 0 238px;}
.heySomething .brand .text .txt01 {padding-bottom:34px;}
.heySomething .brand .pic .fg {position:absolute; top:0; left:50%;}
.heySomething .brand .pic .figure01 {top:278px; margin-left:-525px; animation:swing2 1.5s infinite forwards ease-in-out; transform-origin:50% 100%;}
.heySomething .brand .pic .figure02 {top:351px; margin-left:-285px; }
.heySomething .brand .pic .figure03 {top:218px; margin-left:305px; animation:swing 1s infinite forwards ease-in; transform-origin:50% 100%;}
.heySomething .brand .pic .figure04 {top:375px; margin-left:155px; }
.heySomething .brand .btnDown {margin-top:53px;}
.heySomething .itemB .slidewrap {width:442px;}
.heySomething .itemB .slidewrap .slide {width:442px; height:375px;}
@keyframes swing { 
	0%,100%{transform:rotate(2deg);} 
	50% {transform:rotate(-2deg);} 
}
@keyframes swing2 { 
	0%,100%{transform:rotate(1deg);} 
	50% {transform:rotate(-1deg);} 
}

/* story */
.heySomething .story {margin-top:374x;}
.heySomething .rolling {padding-top:230px;}
.heySomething .rolling .pagination {top:0; padding-left:175px;}
.heySomething .rolling .swiper-pagination-switch {width:158px; height:185px; margin:0 25px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/75498/bg_ico_01_v2.png);}
.heySomething .rolling .pagination span:first-child {background-position:0 0;}
.heySomething .rolling .pagination span.swiper-active-switch {background-position:0 100%;}
.heySomething .rolling .pagination span:first-child + span {background-position:-207px 0;}
.heySomething .rolling .pagination span:first-child + span.swiper-active-switch {background-position:-207px 100%;}
.heySomething .rolling .pagination span:first-child + span + span {background-position:100% 0;}
.heySomething .rolling .pagination span:first-child + span + span.swiper-active-switch {background-position:100% 100%;}
.heySomething .rolling .btn-nav {top:510px;}
.heySomething .swipemask {top:230px;}
.heySomething .rolling .pagination span em {height:41px; width:535px; margin-left:264px; bottom:-754px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/75498/txt_desc.png); cursor:default;}
.heySomething .rolling .pagination span .desc2 {background-position:0 -41px;}
.heySomething .rolling .pagination span .desc3 {background-position:0 100%;}

/* finish */
.heySomething .finish {position:relative; height:641px; margin-top:438px; background:#5eddfd url(http://webimage.10x10.co.kr/eventIMG/2017/hey/75498/bg_finish.jpg) 50% 0 no-repeat;}
.heySomething .finish a {display:block; height:100%;}
.heySomething .finish p {position:absolute; top:90px; left:50%; margin-left:-180px; z-index:10;}
.heySomething .finish p.t01 {width:198px; height:53px; }
.heySomething .finish p.t02 {width:149px; height:46px; margin-left:35px}

/* comment */
.heySomething .commentevet {margin-top:407px; padding-top:53px; }
.heySomething .commentevet textarea {margin-top:40px;}
.heySomething .commentevet .form {margin-top:28px;}
.heySomething .commentevet .form .choice {margin-left:5px;}
.heySomething .commentevet .form .choice li {width:120px; height:140px; margin:0;}
.heySomething .commentevet .form .choice li.ico2 {width:140px; margin:0 31px 0 27px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/75498/bg_ico_02.png);}
.heySomething .commentevet .form .choice li button.on {background-position:0 -144px;}
.heySomething .commentevet .form .choice li.ico2 button {width:140px; background-position:-145px 0;}
.heySomething .commentevet .form .choice li.ico2 button.on {width:140px; background-position:-145px -142px;}
.heySomething .commentevet .form .choice li.ico3 button { background-position:100% 0;}
.heySomething .commentevet .form .choice li.ico3 button.on {background-position:100% -142px;}
.heySomething .commentlist table td {padding:20px 0;}
.heySomething .commentlist table td strong {width:120px; height:140px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/75498/bg_ico_03_v2.png); background-position:0 0;}
.heySomething .commentlist table td .ico2 {width:136px; background-position:-132px 0;}
.heySomething .commentlist table td .ico3 {background-position:100% 0;}
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
		<% If not( left(currenttime,10)>="2017-01-10" and left(currenttime,10)<"2017-01-18" ) Then %>
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
			location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/eventmain.asp?eventid="&eCode)%>';
			return;
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
			location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/eventmain.asp?eventid="&eCode)%>';
			return;
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
			<div class="bnr"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/75498/img_item_represent.jpg" alt="TROLLS, FIND YOUR COLORS" /></div>
		</div>

		<!-- about -->
		<div class="about">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
			<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
		</div>

		<!-- item -->
		<div class="item itemB">
			<div class="inner">
				<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/75498/txt_troll.jpg" alt="Trolls 10x10 콜라보" /></h3>
				<a href="/shopping/category_prd.asp?itemid=1621114&amp;pEtr=75498" class="goItem">
				<div class="desc">
					<div class="option">
						<em class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/75498/txt_name.png" alt="Trolls Blind Bag (랜덤토이) Size : 10cm(제품별 상이) 소재 : PVC 제조사 : Hashrn" /></em>
						<%'' for dev msg : 상품코드 1621114, 할인기간 01/11 ~ 01/17 할인기간이 지나면  <strong class="discount">...</strong> 숨겨주세요 %>
						<%
							IF application("Svr_Info") = "Dev" THEN
								itemid = 1239226
							Else
								itemid = 1621114
							End If
							set oItem = new CatePrdCls
								oItem.GetItemData itemid
						%>
						<% If oItem.FResultCount > 0 Then %>
							<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
								<div class="price">
									<% If not( left(currenttime,10)>="2017-01-11" and left(currenttime,10)<"2017-01-18" ) Then %>
										<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
									<% else %>
										<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
									<% end if %>
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								</div>
							<% else %>
								<div class="price">
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								</div>
							<% End If %>
						<% End If %>
						<%	set oItem = nothing %>
						<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/75498/txt_substance.png" alt="매일 춤추고 노래하고 허그 하는 것이 제일 좋은 트롤! 알록달록한 세상에서 가장 행복한 트롤과 함께 놀아볼까요? * 사용연령 : 4세 이상 / 상품 특징 : 랜덤 토이" /></p>
						<div class="btnget">
							<img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러 가기" />
						</div>
					</div>
					<div class="slidewrap">
						<div id="slide01" class="slide">
							<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/75498/img_slide_01.jpg" alt="" /></div>
							<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/75498/img_slide_02.jpg" alt="" /></div>
							<div class="slide03"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/75498/img_slide_03.jpg" alt="" /></div>
						</div>
					</div>
				</div>
				</a>
			</div>

			<!-- visual -->
			<div class="visual">
				<div class="with">
					<span><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/ico_plus.png" alt="" /></span>
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/75498/txt_trolls.png" alt="어떤 트롤을 만나게 될지 궁금해!" /></p>
				</div>
				<div id="slider" class="slider-horizontal">
					<div class="slide-img">
						<a href="/shopping/category_prd.asp?itemid=1621114&amp;pEtr=75498">
							<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/75498/img_item_visual_01.jpg" alt="" />
						</a>
					</div>
					<div class="slide-img">
						<a href="/shopping/category_prd.asp?itemid=1621114&amp;pEtr=75498">
							<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/75498/img_item_visual_02.jpg" alt="" />
						</a>
					</div>
					<div class="slide-img">
						<a href="/shopping/category_prd.asp?itemid=1621114&amp;pEtr=75498">
							<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/75498/img_item_visual_03.jpg" alt="" />
						</a>
					</div>
					<div class="slide-img">
						<a href="/shopping/category_prd.asp?itemid=1621114&amp;pEtr=75498">
							<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/75498/img_item_visual_04.jpg" alt="" />
						</a>
					</div>
					<div class="slide-img">
						<a href="/shopping/category_prd.asp?itemid=1621114&amp;pEtr=75498">
							<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/75498/img_item_visual_05.jpg" alt="" />
						</a>
					</div>
					<div class="slide-img">
						<a href="/shopping/category_prd.asp?itemid=1621114&amp;pEtr=75498">
							<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/75498/img_item_visual_06.jpg" alt="" />
						</a>
					</div>
					<div class="slide-img">
						<a href="/shopping/category_prd.asp?itemid=1621114&amp;pEtr=75498">
							<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/75498/img_item_visual_07.jpg" alt="" />
						</a>
					</div>
					<div class="slide-img">
						<a href="/shopping/category_prd.asp?itemid=1621114&amp;pEtr=75498">
							<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/75498/img_item_visual_08.jpg" alt="" />
						</a>
					</div>
					<div class="slide-img">
						<a href="/shopping/category_prd.asp?itemid=1621114&amp;pEtr=75498">
							<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/75498/img_item_visual_09.jpg" alt="" />
						</a>
					</div>
					<div class="slide-img">
						<a href="/shopping/category_prd.asp?itemid=1621114&amp;pEtr=75498">
							<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/75498/img_item_visual_10.jpg" alt="" />
						</a>
					</div>
					<div class="slide-img">
						<a href="/shopping/category_prd.asp?itemid=1621114&amp;pEtr=75498">
							<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/75498/img_item_visual_11.jpg" alt="" />
						</a>
					</div>
					<div class="slide-img">
						<a href="/shopping/category_prd.asp?itemid=1621114&amp;pEtr=75498">
							<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/75498/img_item_visual_12.jpg" alt="" />
						</a>
					</div>
				</div>
				<p class="arrow"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/75498/img_nav.png" alt="" /></p>
			</div>
		</div>

		<!-- items -->
		<div class="items">
			<ul>
				<li class="item01"><a href="/shopping/category_prd.asp?itemid=1621114&amp;pEtr=75498"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/75498/img_troll_01.jpg" alt="" /></a></li>
				<li class="item02"><a href="/shopping/category_prd.asp?itemid=1621114&amp;pEtr=75498"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/75498/img_troll_02.jpg" alt="" /></a></li>
				<li class="item03"><a href="/shopping/category_prd.asp?itemid=1621114&amp;pEtr=75498"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/75498/img_troll_03.jpg" alt="" /></a></li>
				<li class="item04"><a href="/shopping/category_prd.asp?itemid=1621114&amp;pEtr=75498"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/75498/img_troll_04.jpg" alt="" /></a></li>
				<li class="item05"><a href="/shopping/category_prd.asp?itemid=1621114&amp;pEtr=75498"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/75498/img_troll_05.jpg" alt="" /></a></li>
				<li class="item06"><a href="/shopping/category_prd.asp?itemid=1621114&amp;pEtr=75498"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/75498/img_troll_06.jpg" alt="" /></a></li>
			</ul>
		</div>

		<!-- brand -->
		<div class="brand">
			<a href="/shopping/category_prd.asp?itemid=1621114&amp;pEtr=75498">
				<div class="text">
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/75498/txt_brand_name.png" alt="trolls 10x10 콜라보" /></p>
					<p class="txt01"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/75498/txt_brand_01.png" alt="TRUE COLORS!" /></p>
					<p class="txt02"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/75498/txt_brand_02.png" alt="매일 노래하고, 춤추고, 허그하는 흥 터지는 생명체 ”트롤” 잠깐의 행복을 위해 트롤을 잡아가는 우울한 생명체 “버겐” 귀여운 트롤친구들은 이 위기를 어떻게 극복할까요? 트롤과 함께 진정한 행복을 찾으러 떠나볼까요?" /></p>
				</div>
				<div class="pic">
					<div class="fg figure01"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/75498/img_monster_01.png" alt="" /></div>
					<div class="fg figure02"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/75498/img_monster_02.png" alt="" /></div>
					<div class="fg figure03"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/75498/img_monster_03.png" alt="" /></div>
					<div class="fg figure04"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/75498/img_monster_04.png" alt="" /></div>
				</div> 
			</a>
			<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="" /></div>
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
								<div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1621114&amp;pEtr=75498"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/75498/img_slide_story_01.jpg" alt="#Play Time 노는 게 제일 좋아! 누구보다 천진난만하고 사랑스러운 트롤!" /></a></div>
								<div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1621114&amp;pEtr=75498"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/75498/img_slide_story_02.jpg" alt="#Adventure Time 행복은 어디에 있을까?  호기심 가득한 눈망울로 모험을 떠난 트롤!" /></a></div>
								<div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1621114&amp;pEtr=75498"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/75498/img_slide_story_03.jpg" alt="#Party Time Drop The Beat! 흥부자 트롤과 미친듯이 놀아볼까요!" /></a></div>
							</div>
						</div>
					</div>
					<div class="pagination"></div>
				</div>
			</div>
		</div>

		<!-- finish -->
		<div class="finish">
			<a href="/shopping/category_prd.asp?itemid=1621114&amp;pEtr=75498">
				<p class="t01"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/75498/txt_finish_01.png" alt="sweety" /></p>
				<p class="t02"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/75498/txt_finish_02.png" alt="Trolls" /></p>
			</a>
		</div>

		<!-- comment -->
		<div class="commentevet">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/75498/tit_commnet.png" alt="Hey, something project, ‘True Colors! 나만의 모토’를 소개해주세요!" /></h3>
			<p class="hidden">정성껏 코멘트를 남겨주신 5분을 추첨하여 ‘Trolls_Blind bag (랜덤토이)’ 를 랜덤 발송 해드립니다</p>
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
							<li class="ico1"><button type="button" value="1">#Play Time</button></li>
							<li class="ico2"><button type="button" value="2">#Adventure Time</button></li>
							<li class="ico3"><button type="button" value="3">#Party Time</button></li>
						</ul>
						<textarea title="코멘트 쓰기" cols="60" rows="5" name="txtcomm1" id="txtcomm1" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();" <%IF NOT(IsUserLoginOK) THEN%>readonly<%END IF%>><%IF NOT IsUserLoginOK THEN%>로그인 후 글을 남길 수 있습니다.<% else %><%END IF%></textarea>
						<div class="note01 overHidden">
							<ul class="list01 ftLt">
								<li>입력하신 블로그 주소는 개인정보 유출로 인한 피해를 막고자 비공개로 텐바이텐에 접수됩니다.</li>
								<li>통신예절에 어긋나는 글이나 상업적인 글, 타 사이트에 관련된 글 또는 도용한 글은 관리자에 의해 사전 통보 없이 삭제될 수 있으며,<br>이벤트 참여에 제한을 받을 수 있습니다.</li>
							</ul>
							<input type="submit" class="ftRt btn btnW130 btnS1 btnRed" value="코멘트 남기기" onclick="jsSubmitComment(document.frmcom);return false;">
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
			<div class="commentlist"  id="commentlist">
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
												#Play Time
											<% Elseif split(arrCList(1,intCLoop),"!@#")(0)="2" Then %>
												#Adventure Time
											<% Elseif split(arrCList(1,intCLoop),"!@#")(0)="3" Then %>
												#Party Time
											<% else %>
												#Play Time
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
									<% end if %>
									<% If arrCList(8,i) <> "W" Then %>
										<br /><img src="http://fiximage.10x10.co.kr/web2013/event/ico_mobile.png" alt="모바일에서 작성됨">
									<% end if %>
								</td>
							</tr>
						<% next %>
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
<% End If %>
<script type="text/javascript" src="/lib/js/jquery.flowslider.js"></script>
<script type="text/javascript">
$(function(){
	$("#slider").FlowSlider({
		marginStart:0,
		marginEnd:0,
		startPosition:0.55
	});

	/* slide js */
	$("#slide01").slidesjs({
		width:"318",
		height:"466",
		pagination:{effect:"fade"},
		navigation:false,
		play:{interval:1800, effect:"fade", auto:true},
		effect:{fade: {speed:700, crossfade:true}
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

	/* animation effect */
	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 2500 ) {
			$(".heySomething .items ul li a img").addClass("pulse");
			featureAnimation()
		}
		if (scrollTop > 3300 ) {
			brandAnimation()
		}
		if (scrollTop > 5800 ) {
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
		$(".heySomething .topic h2 .letter1").delay(300).animate({"margin-top":"0", "opacity":"1"},800);
		$(".heySomething .topic h2 .letter2").delay(700).animate({"margin-top":"7px", "opacity":"1"},800);
		$(".heySomething .topic h2 .letter3").delay(1100).animate({"margin-top":"17px", "opacity":"1"},800);
	}

	$(".heySomething .items li img").css({"opacity":"0"});
	function featureAnimation() {
		$(".heySomething .items li.item01 img").delay(100).animate({"opacity":"1"},700);
		$(".heySomething .items li.item02 img").delay(200).animate({"opacity":"1"},700);
		$(".heySomething .items li.item03 img").delay(300).animate({"opacity":"1"},700);
		$(".heySomething .items li.item04 img").delay(500).animate({"opacity":"1"},700);
		$(".heySomething .items li.item05 img").delay(400).animate({"opacity":"1"},700);
		$(".heySomething .items li.item06 img").delay(200).animate({"opacity":"1"},700);
	}

	$(".heySomething .brand .text .txt01").css({"margin-top":"-30px","opacity":"0"});
	$(".heySomething .brand .text .txt02").css({"margin-top":"-20px","opacity":"0"});
	function brandAnimation() {
		$(".heySomething .brand .text .txt01").delay(100).animate({"margin-top":"0px","opacity":"1"},800);
		$(".heySomething .brand .text .txt02").delay(400).animate({"margin-top":"0px","opacity":"1"},1000);
	}

	$(".heySomething .finish p.t01").css({"margin-left":"35px","opacity":"0"});
	$(".heySomething .finish p.t02").css({"margin-left":"-180px","opacity":"0"});
	function finishAnimation() {
		$(".heySomething .finish p.t01").delay(100).animate({"margin-left":"-180px","opacity":"1"},1000);
		$(".heySomething .finish p.t02").delay(100).animate({"margin-left":"35px","opacity":"1"},1000);
	}
});
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->