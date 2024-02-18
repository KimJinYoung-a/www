<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈 18
' History : 2016-01-19 유태욱 생성
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
	eCode   =  66004
Else
	eCode   =  68595
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

dim itemid, itemid1, itemid2, itemid3, itemid4
IF application("Svr_Info") = "Dev" THEN
	itemid1   =  1239115
	itemid2   =  1239227
	itemid3   =  1239226
	itemid4   =  1239221
Else
	itemid1   =  1418254
	itemid2   =  1418269
	itemid3   =  1418291
	itemid4   =  1418312
End If

Dim hspchk
'// 현재 주소값 체크하여 신규, 구버전 확인
hspchk = Split(LCase(Request.ServerVariables("PATH_INFO")),"/")
%>
<style type="text/css">
.evtEndWrapV15 {display:none;}
.heySomething .navigator {display:none;}

/* title */
.heySomething .topic {background-color:#d5cbc1; z-index:1;}

/* item */
.heySomething .item .option {height:440px;}
.heySomething .item .option .name {padding-bottom:30px;}
.heySomething .item .option .price {margin-top:10px;}
.heySomething .itemB {margin-bottom:280px;}
.heySomething .itemB .desc {padding-left:508px;}
.heySomething .itemB .slidewrap {width:550px; padding-top:72px;}
.heySomething .itemB .slidewrap .slide {width:550px; height:444px;}
.heySomething .itemB .slidewrap .slidesjs-pagination li a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/68595/bg_pagination.jpg);}
.heySomething .itemB .slidewrap.v2 .slidesjs-pagination li a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/68595/bg_pagination_v2.jpg);}

/* visual */
.heySomething .visual {margin-top:280px; text-align:center; background-color:#fff;}
.heySomething .visual .slide {position:relative; overflow:visible !important; width:1140px; height:760px; margin:120px auto 418px;}
.heySomething .visual .slidesjs-navigation {display:block; position:absolute; z-index:10; bottom:-60px; width:6px; height:9px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/68595/btn_nav.png) no-repeat 0 0; text-indent:-999em;}
.heySomething .visual .slidesjs-previous {left:457px;}
.heySomething .visual .slidesjs-next {right:457px; background-position:100% 0;}
.heySomething .visual .slidesjs-pagination {overflow:hidden; position:absolute; bottom:-58px; left:50%; z-index:50; width:157px; margin-left:-78px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/68595/bg_line.png) repeat-x 0 0;}
.heySomething .visual .slidesjs-pagination li {float:left; padding-left:23px;}
.heySomething .visual .slidesjs-pagination li.num01 {padding-left:0;}
.heySomething .visual .slidesjs-pagination li a {display:block; width:7px; height:7px;  text-indent:-999em; transition:all .5s; background:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/68595/btn_pagination.png) no-repeat 0 0;}
.heySomething .visual .slidesjs-pagination li a.active {background-position:100% 0;}
.heySomething .visual .slidesjs-slide .slideCont {height:760px; background-position:50% 50%; background-repeat:no-repeat;}
.heySomething .visual .slidesjs-slide .bg {opacity:0;}
.heySomething .visual .slide .desc p {overflow:hidden; position:absolute; z-index:50;}
.heySomething .visual .slide .desc img {display:block;}
.heySomething .visual .slide .scene01 .desc01 {display:block; position:absolute; left:50%; top:122px; width:377px;height:88px; margin-left:-188px;}
.heySomething .visual .slide .scene01 .desc01 span {display:block; position:absolute; top:0; height:88px; text-indent:-9999px; z-index:50; background:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/68595/txt_desc01_01.png) no-repeat 0 0; }
.heySomething .visual .slide .scene01 .desc01 span.t01 {left:0; width:82px;}
.heySomething .visual .slide .scene01 .desc01 span.t02 {left:149px; width:86px; background-position:-149px 0;}
.heySomething .visual .slide .scene01 .desc01 span.t03 {right:0; width:74px; background-position:100% 0;}
.heySomething .visual .slide .scene01 .desc02 {left:50%; top:246px; margin-left:-73px;}
.heySomething .visual .slide .scene02 .desc01 {left:50%; top:152px; margin-left:-210px;}
.heySomething .visual .slide .scene03 { background-color:#e2d9d7;}
.heySomething .visual .slide .scene03 .slideCont {opacity:0; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/68595/img_slide_03.jpg); background-size:120%;}
.heySomething .visual .slide .scene03 .desc01 {left:90px; top:580px;}
.heySomething .visual .slide .scene04 .desc01 {left:90px; top:110px;}
.heySomething .visual .slide .scene05 {background:#e2dad8;}
.heySomething .visual .slide .scene05 .desc01 {left:50%; top:120px; margin-left:-209px;}
.heySomething .visual .slide .scene06 .desc01 {left:57px; top:382px; width:236px;}
.heySomething .visual .slide .scene06 .desc02 {left:812px; top:382px; width:274px;}
.heySomething .visual .slide .scene06 .desc01 img {margin-left:236px;}
.heySomething .visual .slide .scene06 .desc02 img {margin-left:-274px;}

.heySomething .visual .moviewrap {height:840px; background:#dad4d1 url(http://webimage.10x10.co.kr/eventIMG/2016/hey/68595/bg_movie.jpg) 50% 0 no-repeat;}
.heySomething .visual .movie {width:960px; height:540px; padding-top:150px; margin:0 auto;}
.heySomething .visual .info {padding:55px 0; background-color:#f4f1ec;}

/* brand */
.heySomething .brand {position:relative; height:825px; padding-top:175px;}
.heySomething .brand h3 {position:absolute; left:50%; top:0; margin-left:-104px;}
.heySomething .brand h3 img {display:block; -webkit-transform: rotateY(-180deg); transform: rotateY(-180deg);}
.heySomething .brand h3 img.flipped {-webkit-transform: rotateY(0deg); transform: rotateY(0deg); -webkit-transition: -webkit-transform 2s; transition: transform 2s;}
.heySomething .brand .pic {overflow:hidden; width:750px; margin:0 auto 98px;}
.heySomething .brand .pic div {float:left; width:240px; height:480px; margin:0 5px;}
.heySomething .brand .desc {position:absolute; left:50%; bottom:0; margin-left:-242px;}

/* featured */
.heySomething .featured {text-align:center; padding:360px 0 0;}
.heySomething .featured .with ul {overflow:hidden; width:1140px; margin:0 auto; padding-top:60px;}
.heySomething .featured .with li {position:relative; float:left; padding:0 30px; font-family:arial;}
.heySomething .featured .with li a {text-decoration:none;}
.heySomething .featured .with .name {padding-top:24px; font-weight:bold; font-size:16px; line-height:18px; color:#000;}
.heySomething .featured .with .price {font-size:14px; color:#777; padding-top:5px;}
.heySomething .featured .with .price s {display:block; line-height:14px; padding-bottom:4px;}
.heySomething .featured .with .price strong {font-size:16px; line-height:16px;}
.heySomething .featured .with .soldout {position:absolute; lefT:50%; top:68px; margin-left:-100px; z-index:20;}

/* finish */
.heySomething .finish {height:auto; background-color:#fff;}
.heySomething .finish #gallery {height:740px; margin-top:80px; text-align:left;}
.heySomething .finish #gallery .item {margin-top:0;}
.heySomething .finish #gallery .www_FlowSlider_com-branding {display:none !important;}

/* comment */
.heySomething .commentevet {margin-top:160px;}
.heySomething .commentevet .form .choice li {width:160px; height:200px; margin-right:40px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/68595/bg_ico.jpg);}
.heySomething .commentevet .form .choice li.ico1 button {background-position:0 0;}
.heySomething .commentevet .form .choice li.ico1 button.on {background-position:0 -200px;}
.heySomething .commentevet .form .choice li.ico2 button {background-position:-160px 0;}
.heySomething .commentevet .form .choice li.ico2 button.on {background-position:-160px -200px;}
.heySomething .commentevet .form .choice li.ico3 button {background-position:-320px 0;}
.heySomething .commentevet .form .choice li.ico3 button.on {background-position:-320px -200px;}
.heySomething .commentevet .form .choice li.ico4 button {background-position:-480px 0;}
.heySomething .commentevet .form .choice li.ico4 button.on {background-position:-480px -200px;}
.heySomething .commentevet textarea {margin-top:40px;}

.heySomething .commentlist table td {padding:22px 0;}
.heySomething .commentlist table td strong {height:100px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/68595/bg_ico.jpg);}
.heySomething .commentlist table td .ico1 {background-position:-10px -400px;}
.heySomething .commentlist table td .ico2 {background-position:-170px -400px;}
.heySomething .commentlist table td .ico3 {background-position:-330px -400px;}
.heySomething .commentlist table td .ico4 {background-position:-490px -400px;}
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
		<% If not( left(currenttime,10)>="2016-01-20" and left(currenttime,10)<"2016-01-27" ) Then %>
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
			<div class="bnr"><a href="/shopping/category_prd.asp?itemid=1418254&amp;pEtr=68595"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68595/img_item_represent.jpg" alt="Vintage Mickey" /></a></div>
		</div>

		<%' about %>
		<div class="about">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
			<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
		</div>

		<%' item %>
		<div class="item itemB">
			<div class="inner">
				<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68595/tit_ground.png" alt="THIS IS GROUND" /></h3>
				<%
				itemid = itemid2
				set oItem = new CatePrdCls
					oItem.GetItemData itemid
				%>
				<div class="desc">
					<div class="option">
						<em class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68595/txt_name_v2.png" alt="Mod Mobile 2" /></em>
						<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68595/txt_just_1week.png" alt="JUST 1WEEK" /></p>
						<% if oItem.FResultCount > 0 then %>
							<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
								<%	'' for dev msg : 할인 %>
								<div class="price">
									<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								</div>
							<% else %>
								<%	''  for dev msg : 종료 후 %>
								<div class="price priceEnd">
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								</div>
							<% end if %>
						<% end if %>
						<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68595/txt_substance.png" alt="진정한 CARRYALL이란 이런 것! 당신이 가지고 다니는 모든 것이 멋스럽게 한 곳에. 최고급 가죽을 사용해 핸드크래프트로 제작된 MOD가 완벽한 구성으로 당신의 라이프스타일을 담아 냅니다." /></p>
						<div class="btnget">
							<a href="/shopping/category_prd.asp?itemid=1418269&amp;pEtr=68595"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러 가기" /></a>
						</div>
					</div>
					<div class="slidewrap v2">
						<div id="slide01" class="slide">
							<div><a href="/shopping/category_prd.asp?itemid=1418269&amp;pEtr=68595"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68595/img_figure_01_v2.jpg" alt="" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1418269&amp;pEtr=68595"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68595/img_figure_02_v2.jpg" alt="" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1418269&amp;pEtr=68595"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68595/img_figure_03_v2.jpg" alt="" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1418269&amp;pEtr=68595"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68595/img_figure_04_v2.jpg" alt="" /></a></div>
						</div>
					</div>
				</div>
				<% set oItem=nothing %>
			</div>
		</div>

		<%' visual %>
		<div class="visual">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68595/txt_carry.png" alt="CARRY ALL CARRY YOUR LIFESTYLE" /></h3>
			<div id="slide02" class="slide">
				<div class="scene01">
					<div class="slideCont">
						<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68595/img_slide_01.jpg" alt="" />
						<div class="desc">
							<p class="desc01">
								<span class="t01">M</span>
								<span class="t02">O</span>
								<span class="t03">D</span>
							</p>
							<p class="desc02"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68595/txt_desc01_02.png" alt="TABLET2" /></p>
						</div>
					</div>
				</div>
				<div class="scene02">
					<div class="slideCont">
						<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68595/img_slide_02.jpg" alt="" />
						<div class="desc">
							<p class="desc01"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68595/txt_desc02_01.png" alt="사용할수록 더욱 멋스러워지는 최고급 레더" /></p>
						</div>
					</div>
				</div>
				<div class="scene03">
					<div class="slideCont">
						<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68595/img_slide_03.jpg" alt="" class="bg" />
						<div class="desc">
							<p class="desc01"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68595/txt_desc03_01.png" alt="타블렛 수납이 아니라도 다양한 용도로 사용 가능한 사이즈" /></p>
						</div>
					</div>
				</div>
				<div class="scene04">
					<div class="slideCont">
						<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68595/img_slide_04.jpg" alt="" />
						<div class="desc">
							<p class="desc01"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68595/txt_desc04_01.png" alt="사용자의 라이프스타일을 고려한 Modular Insert System" /></p>
						</div>
					</div>
				</div>
				<div class="scene05">
					<div class="slideCont">
						<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68595/img_slide_05.jpg" alt="" class="bg" />
						<div class="desc">
							<p class="desc01"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68595/txt_desc05_01.png" alt="기분이 좋아지는 심플한 패키지" /></p>
						</div>
					</div>
				</div>
				<div class="scene06">
					<div class="slideCont">
						<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68595/img_slide_06.jpg" alt="" />
						<div class="desc">
							<p class="desc01"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68595/txt_desc06_01.png" alt="단하나의 MOD로" /></p>
							<p class="desc02"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68595/txt_desc06_02.png" alt="정리되는 당신의 일상" /></p>
						</div>
					</div>
				</div>
			</div>
			<div class="preview">
				<div class="moviewrap">
					<div class="movie"><iframe width="960" height="540" src="https://www.youtube.com/embed/YA_5BeOdHjI" frameborder="0" allowfullscreen></iframe></div>
				</div>
				<div class="info"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68595/txt_insert_system.jpg" alt="Modular Insert System" /></div>
			</div>
		</div>

		<%' brand %>
		<div class="brand">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68595/txt_brand_01.png" alt="THIS IS GROUND" /></h3>
			<div class="pic">
				<div class="p01"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68595/img_work_01.jpg" alt="" /></div>
				<div class="p02"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68595/img_work_02.jpg" alt="" /></div>
				<div class="p03"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68595/img_work_03.jpg" alt="" /></div>
			</div>
			<p class="desc"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68595/txt_brand_02.png" alt="THIS IS GROUND는 사용자의 니즈와 그들의 진화된 기어를 위한 상품을 만듭니다. 2013년에 런칭하여 한달만에 애플스토어 내에 자리를 잡은 바 있으며 자체적으로 선별한 미국산 최고급 레더를 사용하여 로스엔젤레스를 중심으로 디자인과 핸드크래프트 작업이 이루어지고 있습니다. 전세계 100만개 이상 판매한 Cord Taco와 수많은 매니아를 보유한 MOD2등 다양한 사용자에 맞춘 다양한 상품들로 많은 사랑을 받고 있습니다." /></p>
		</div>

		<%' featured %>
		<div class="featured">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68595/tit_featured.png" alt="FEATURED" /></h3>
			<div class="with">
				<ul>
					<%'' for dev msg : 현재 가격 적용될 수 있게 해주세요! %>
					<li>
					<%
					itemid = itemid1
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
					%>
						<p class="soldout"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68595/txt_soldout.png" alt="SOLD OUT" /></p>
						<a href="/shopping/category_prd.asp?itemid=1418254&amp;pEtr=68595">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68595/img_item_04.jpg" alt="" />
							<p class="name">MOD TABLET 2 Mini</p>
							<div class="price">
							<% if oItem.FResultCount > 0 then %>
								<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
									<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
									<strong class="cRd0V15"><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								<% Else %>
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								<% end if %>
							<% end if %>
							</div>
						</a>
					<% set oItem=nothing %>
					</li>
					<li>
					<%
					itemid = itemid3
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
					%>
						<a href="/shopping/category_prd.asp?itemid=1418291&amp;pEtr=68595">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68595/img_item_02.jpg" alt="" />
							<p class="name">STASH (iPhone6)</p>
							<div class="price">
							<% if oItem.FResultCount > 0 then %>
								<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
									<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
									<strong class="cRd0V15"><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								<% Else %>
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								<% end if %>
							<% end if %>
							</div>
						</a>
					<% set oItem=nothing %>
					</li>
					<li>
					<%
					itemid = itemid4
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
					%>
						<a href="/shopping/category_prd.asp?itemid=1418312&amp;pEtr=68595">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68595/img_item_03.jpg" alt="" />
							<p class="name">CORD TACOS - Grande 3 Pack</p>
							<div class="price">
							<% if oItem.FResultCount > 0 then %>
								<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
									<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
									<strong class="cRd0V15"><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								<% Else %>
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								<% end if %>
							<% end if %>
							</div>
						</a>
					<% set oItem=nothing %>
					</li>
				</ul>
			</div>
		</div>

		<%' finish %>
		<div class="finish">
			<h3 class="ct"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68595/tit_users.png" alt="MOD USERS" /></h3>
			<div id="gallery" class="slider-horizontal">
				<div class="item"><a href="https://www.instagram.com/thisisground/" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68595/img_use_travel.jpg" alt="TRAVEL" /></a></div>
				<div class="item"><a href="https://www.instagram.com/thisisground/" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68595/img_use_study.jpg" alt="STUDY" /></a></div>
				<div class="item"><a href="https://www.instagram.com/thisisground/" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68595/img_use_daylife.jpg" alt="DAYLIFE" /></a></div>
				<div class="item"><a href="https://www.instagram.com/thisisground/" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68595/img_use_business.jpg" alt="BUSINESS" /></a></div>
			</div>
			<div class="tPad40 ct"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68595/txt_instagram.png" alt="THIS IS GROUND INSTAGRAM" /></div>
		</div>

		<%' comment %>
		<div class="commentevet">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/68595/tit_comment.jpg" alt="Hey, something project 당신의 스타일" /></h3>
			<p class="hidden">MOD2가 함께라면 가장 좋을 것 같은 순간은 언제인가요? 코멘트를 남겨주신 1분을 추첨하여 THIS IS GROUND의 Cord Tacos 스페셜 에디션을 드립니다.(5개 세트 / 비매품) 기간:2016.01.20~01.26/발표:01.28</p>
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
							<li class="ico1"><button type="button" value="1">BUSINESS</button></li>
							<li class="ico2"><button type="button" value="2">DAYLIFE</button></li>
							<li class="ico3"><button type="button" value="3">STUDY</button></li>
							<li class="ico4"><button type="button" value="4">TRAVEL</button></li>
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
												BUSINESS
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="2" then %>
												DAYLIFE
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="3" then %>
												STUDY
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="4" then %>
												TRAVEL
											<% Else %>
												BUSINESS
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
<script type="text/javascript" src="/lib/js/jquery.flowslider.js"></script>
<script type="text/javascript">
$(function(){

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
		width:"550",
		height:"444",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:2000, effect:"fade", auto:true},
		effect:{fade: {speed:1000, crossfade:true}
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
		height:"760",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:4000, effect:"fade", auto:true},
		effect:{fade: {speed:1300, crossfade:true}
		},
		callback: {
			start: function(number) {
				$('.scene01 .desc01 span.t01').delay(100).animate({"margin-top":"40px","opacity":"0"},1000);
				$('.scene01 .desc01 span.t02').delay(100).animate({"margin-top":"-40px","opacity":"0"},1000);
				$('.scene01 .desc01 span.t03').delay(100).animate({"margin-top":"40px","opacity":"0"},1000);
				$('.scene01 .desc02').delay(100).animate({"margin-top":"-10px","opacity":"0"},1000);
				$('.scene02 .desc01').delay(100).animate({"margin-top":"-250px","opacity":"0"},500);
				$('.scene03 .slideCont').delay(300).animate({backgroundSize:'120%','opacity':'0'}, 300);
				$('.scene04 .desc01').delay(800).animate({"margin-left":"-530px"},500);
				$('.scene05 .bg').delay(300).animate({"margin-top":"30px","opacity":"0"},500);
				$('.scene05 .desc01').delay(300).animate({"opacity":"0"},500);
				$('.scene06 .desc01 img').delay(500).animate({"margin-left":"236px"},500);
				$('.scene06 .desc02 img').delay(500).animate({"margin-left":"-274px"},500);
				if ($('.visual .slidesjs-pagination li.num01 a').hasClass('active')) {
					$('.scene01 .desc01 span').animate({"margin-top":"0","opacity":"1"},800);
					$('.scene01 .desc02').delay(700).animate({"margin-top":"0","opacity":"1"},600);
				}
				if ($('.visual .slidesjs-pagination li.num02 a').hasClass('active')) {
					$('.scene02 .desc01').delay(100).animate({"margin-top":"0","opacity":"1"},800);
				}
				if ($('.visual .slidesjs-pagination li.num03 a').hasClass('active')) {
					$('.scene03 .slideCont').animate({backgroundSize:'100%','opacity':'1'}, 1000);
				}
				if ($('.visual .slidesjs-pagination li.num04 a').hasClass('active')) {
					$('.scene04 .desc01').delay(100).animate({"margin-left":"0"},800);
				}
				if ($('.visual .slidesjs-pagination li.num05 a').hasClass('active')) {
					$('.scene05 .bg').delay(200).animate({"margin-top":"0","opacity":"1"},1000);
					$('.scene05 .desc01').delay(500).animate({"opacity":"1"},1000);
				}
				if ($('.visual .slidesjs-pagination li.num06 a').hasClass('active')) {
					$('.scene06 .desc01 img').animate({"margin-left":"0"},900);
					$('.scene06 .desc02 img').delay(700).animate({"margin-left":"0"},900);
				}
			},
			complete: function(number) {
				var pluginInstance = $('#slide02').data('plugin_slidesjs');
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
	$(".slidesjs-pagination li:nth-child(5)").addClass("num05");
	$(".slidesjs-pagination li:nth-child(6)").addClass("num06");

	$("#gallery").FlowSlider({
		marginStart:0,
		marginEnd:0,
		position:0.0,
		startPosition:0
	});

	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 4950 ) {
			brandAnimation()
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

	/* brand animation */
	$(".heySomething .brand h3 img").css({"opacity":"0"});
	$(".heySomething .brand .pic div img").css({"margin-left":"-20px","opacity":"0"});
	$(".heySomething .brand .desc").css({"margin-bottom":"-10px","opacity":"0"});
	function brandAnimation() {
		//conChk = 1;
		$(".heySomething .brand h3 img").addClass("flipped").animate({"opacity":"1"},800);
		$(".heySomething .brand .pic .p01 img").delay(500).animate({"margin-left":"0","opacity":"1"},800);
		$(".heySomething .brand .pic .p02 img").delay(800).animate({"margin-left":"0","opacity":"1"},800);
		$(".heySomething .brand .pic .p03 img").delay(1100).animate({"margin-left":"0","opacity":"1"},800);
		$(".heySomething .brand .desc").delay(1400).animate({"margin-bottom":"0","opacity":"1"},800);
	}

});
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->