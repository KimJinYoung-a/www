<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈
' History : 2017-04-04 원승현 생성
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
	eCode   =  66299
Else
	eCode   =  77234
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
.heySomething .topic {height:778px; background:#5d6788 url(http://webimage.10x10.co.kr/eventIMG/2017/hey/77234/img_item_represent.jpg) 50% 0 no-repeat;}

/* brand */
.heySomething .brand {height:820px; margin-top:304px;}
.heySomething .brand iframe {background-color:#000;}
.heySomething .brand p {margin-top:95px;}

/* item */
.heySomething .itemB {width:1140px; margin:324px auto 0; padding-bottom:0; background:none;}
.heySomething .item h3 {position:relative; height:auto; text-align:center;}
.heySomething .item h3 .horizontalLine1, .heySomething .item h3 .horizontalLine2 {position:absolute; top:24px; width:393px; height:1px; background-color:#d9d9d9;}
.heySomething .item h3 .horizontalLine1 {left:0;}
.heySomething .item h3 .horizontalLine2 {right:0;}
.heySomething .item .desc {min-height:403px; margin-top:135px; padding-left:524px;}
.heySomething .itemB .desc .option {top:10px; left:85px; height:387px;}
.heySomething .item .option .price {margin-top:18px;}
.heySomething .item .option .price strong {display:inline; color:#000;}
.heySomething .item .option .price strong:first-child {display:inline-block; *display:inline; *zooom:1; margin:30px 8px 0 0;}
.heySomething .item .option .substance {position:static; margin-top:68px;}
.heySomething .itemB .slidewrap .slide {width:609px; height:403px;}
.heySomething .item .with {margin-top:68px; padding-bottom:0; border:none; text-align:center;}
.heySomething .item .with span {position:relative; z-index:5;}
.heySomething .item .with ul {overflow:hidden; width:1014px; margin:40px auto 0;}
.heySomething .item .with ul li {float:left; width:298px; margin:45px 20px 0;}
.heySomething .item .with ul li a {display:block; color:#777; font-size:11px;}
.heySomething .item .with ul li span {display:block; margin-top:13px;}

/* author */
.heySomething .author {margin-top:374px; padding:160px 0 120px; background-color:#f2f2f0; text-align:center;}
.heySomething .author p {width:1279px; margin:130px auto 0;}
.heySomething .author p:first-child {margin-top:0; padding-bottom:141px; border-bottom:1px solid #c5c5c3;}

/* story */
.heySomething .story {margin-top:367px; padding-bottom:120px;}
.heySomething .story h3 {margin-bottom:60px;}
.heySomething .rolling {padding-top:205px;}
.heySomething .rolling .pagination {top:0; width:880px; margin-left:-440px;}
.heySomething .rolling .swiper-pagination-switch {width:140px; height:159px; margin:0 40px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/77234/btn_pagination_story.png);}
.heySomething .rolling .pagination span.swiper-active-switch {background-position:0 100%;}
.heySomething .rolling .pagination span:first-child + span {background-position:-220px 0;}
.heySomething .rolling .pagination span:first-child + span.swiper-active-switch {background-position:-220px 100%;}
.heySomething .rolling .pagination span:first-child + span + span {background-position:-444px 0;}
.heySomething .rolling .pagination span:first-child + span + span.swiper-active-switch {background-position:-444px 100%;}
.heySomething .rolling .pagination span:first-child + span + span + span {background-position:100% 0;}
.heySomething .rolling .pagination span:first-child + span + span + span.swiper-active-switch {background-position:100% 100%;}
.heySomething .rolling .pagination span em {bottom:-768px; left:50%;height:92px; width:980px; margin-left:-490px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/77234/txt_story_desc.gif); cursor:default;}
.heySomething .rolling .pagination span .desc2 {background-position:0 -92px;}
.heySomething .rolling .pagination span .desc3 {background-position:0 -184px;}
.heySomething .rolling .pagination span .desc4 {background-position:0 -276px;}
.heySomething .rolling .btn-nav {top:476px;}
.heySomething .swipemask {top:205px;}
.heySomething .mask-left {margin-left:-1470px;}
.heySomething .mask-right {margin-left:490px;}

/* intro */
.heySomething .intro {margin-top:277px; text-align:center;}
.heySomething .intro div {margin-top:74px;}
.heySomething .intro p {margin-top:70px;}

/* finish */
.heySomething .finish {height:894px; margin-top:350px; background:#54575e url(http://webimage.10x10.co.kr/eventIMG/2017/hey/77234/bg_finish.jpg) 50% 0 no-repeat; text-align:center;}
.heySomething .finish p {position:static; width:auto; margin-left:0; padding-top:171px;}

/* comment */
.heySomething .commentevet {margin-top:244px;}
.heySomething .commentevet .form {margin-top:24px;}
.heySomething .commentevet .form .choice li {width:129px; height:129px; margin-right:10px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/77234/img_comment_ico.png); background-position:0 0;}
.heySomething .commentevet .form .choice li.ico1 button.on {background-position:0 100%;}
.heySomething .commentevet .form .choice li.ico2 button {background-position:-139px 0;}
.heySomething .commentevet .form .choice li.ico2 button.on {background-position:-139px 100%;}
.heySomething .commentevet .form .choice li.ico3 button {background-position:-278px 0;}
.heySomething .commentevet .form .choice li.ico3 button.on {background-position:-278px 100%;}
.heySomething .commentevet .form .choice li.ico4 button {background-position:100% 0;}
.heySomething .commentevet .form .choice li.ico4 button.on {background-position:100% 100%;}
.heySomething .commentevet textarea {margin-top:15px;}
.heySomething .commentlist table td strong {width:129px; height:129px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/77234/img_comment_ico.png); background-position:0 0;}
.heySomething .commentlist table td strong.ico2 {background-position:-139px 0;}
.heySomething .commentlist table td strong.ico3 {background-position:-278px 0;}
.heySomething .commentlist table td strong.ico4 {background-position:100% 0;}
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
		<% If not( left(currenttime,10)>="2017-04-04" and left(currenttime,10)<"2017-04-12" ) Then %>
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
				if (frm.txtcomm1.value == '' || GetByteLength(frm.txtcomm1.value) > 1200){
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
		</div>

		<%' about %>
		<div class="about">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
			<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
		</div>

		<%' brand1 %>
		<div class="brand">
			<iframe src="https://www.youtube.com/embed/1B-Z3Qie5Ts" width="1088" height="382" frameborder="0" title="디뮤지엄 유스 청춘의 열병, 그 못다한 이야기" webkitallowfullscreen="" mozallowfullscreen="" allowfullscreen=""></iframe>
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/77234/txt_brand_v1.gif" alt="지금, 당신의 YOUTH를 깨워라! 디뮤지엄(D MUSEUM)은 오는 5월 28일까지 자유, 반항, 순수, 열정 등 유스컬처의 다양한 감성을 새로운 방식과 시각으로 선보이는 YOUTH 청춘의 열병, 그 못다한 이야기 전시를 개최합니다. 텐바이텐에서 유스컬처의 역동성을 담은 특별한 오리지널 굿즈를 만나보세요." /></p>
			<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="" /></div>
		</div>

		<%' item %>
		<div class="item itemB">
			<div class="inner">
				<h3>
					<span class="logo"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/77234/img_logo_d_museum.gif" alt="D MUSEUM" /></span>
					<span class="horizontalLine1"></span>
					<span class="horizontalLine2"></span>
				</h3>
				<div class="desc">
					<a href="/shopping/category_prd.asp?itemid=1673277&pEtr=77234">
						<%' 상품 이름, 가격, 구매하기 %>
						<div class="option">
							<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/77234/txt_name.gif" alt="디뮤지엄 YOUTH 에코백, 종류 LOVER, MAN 코튼 100% MADE IN KOREA" /></p>
							<%'' for dev msg : 상품코드 1673277 가격부분 개발해주세요! 할인 없이 진행됩니다. %>
							<%
								IF application("Svr_Info") = "Dev" THEN
									itemid = 1239226
								Else
									itemid = 1673277
								End If
								set oItem = new CatePrdCls
									oItem.GetItemData itemid
							%>
							<% If oItem.FResultCount > 0 Then %>
								<div class="price">
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
									<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/txt_only_online.png" alt="온라인 단독판매" /></strong>
								</div>
							<% End If %>
							<%	set oItem = nothing %>
							<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/77234/txt_substance.gif" alt="미술관 대표 상품인 에코백으로 화이트 원단에는 Masha Demianova의 작품을, 데님 컬러에는 Paolo Raeli의 작품을 삽입하였습니다." /></p>
							<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="디뮤지엄 YOUTH 에코백 구매하러 가기" /></div>
						</div>
						<%' slide %>
						<div class="slidewrap">
							<div id="slide" class="slide">
								<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/77234/img_slide_item_01.jpg" alt="" /></div>
								<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/77234/img_slide_item_02.jpg" alt="" /></div>
							</div>
						</div>
					</a>
				</div>

				<%' for dev msg : 가격 부분 개발 해주세요 %>
				<div class="with">
					<span><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/ico_plus.png" alt="" /></span>
					<ul>
						<li>
							<a href="/shopping/category_prd.asp?itemid=1673281&pEtr=77234">
							<%
								IF application("Svr_Info") = "Dev" THEN
									itemid = 1239226
								Else
									itemid = 1673281
								End If
								set oItem = new CatePrdCls
									oItem.GetItemData itemid
							%>
							<% If oItem.FResultCount > 0 Then %>
								<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/77234/img_with_item_01.jpg" alt="" />
								<span>대림미술관&amp;디뮤지엄X카웨코 만년필</span>
								<div><b><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></b></div>
							<% End If %>
							<%	set oItem = nothing %>
							</a>
						</li>
						<li>
							<a href="/shopping/category_prd.asp?itemid=1673279&pEtr=77234">
							<%
								IF application("Svr_Info") = "Dev" THEN
									itemid = 1239226
								Else
									itemid = 1673279
								End If
								set oItem = new CatePrdCls
									oItem.GetItemData itemid
							%>
							<% If oItem.FResultCount > 0 Then %>
								<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/77234/img_with_item_02.jpg" alt="" />
								<span>디뮤지엄 YOUTH 노트</span>
								<div><b><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></b></div>
							<% End If %>
							<%	set oItem = nothing %>
							</a>
						</li>
						<li>
							<a href="/shopping/category_prd.asp?itemid=1673276&pEtr=77234">
							<%
								IF application("Svr_Info") = "Dev" THEN
									itemid = 1239226
								Else
									itemid = 1673276
								End If
								set oItem = new CatePrdCls
									oItem.GetItemData itemid
							%>
							<% If oItem.FResultCount > 0 Then %>
								<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/77234/img_with_item_03.jpg" alt="" />
								<span>디뮤지엄 YOUTH 핀버튼</span>
								<div><b><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></b></div>
							<% End If %>
							<%	set oItem = nothing %>
							</a>
						</li>
						<li>
							<a href="/shopping/category_prd.asp?itemid=1673275&pEtr=77234">
							<%
								IF application("Svr_Info") = "Dev" THEN
									itemid = 1239226
								Else
									itemid = 1673275
								End If
								set oItem = new CatePrdCls
									oItem.GetItemData itemid
							%>
							<% If oItem.FResultCount > 0 Then %>
								<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/77234/img_with_item_04.jpg" alt="" />
								<span>디뮤지엄 YOUTH 토트백</span>
								<div><b><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></b></div>
							<% End If %>
							<%	set oItem = nothing %>
							</a>
						</li>
						<li>
							<a href="/shopping/category_prd.asp?itemid=1673273&pEtr=77234">
							<%
								IF application("Svr_Info") = "Dev" THEN
									itemid = 1239226
								Else
									itemid = 1673273
								End If
								set oItem = new CatePrdCls
									oItem.GetItemData itemid
							%>
							<% If oItem.FResultCount > 0 Then %>
								<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/77234/img_with_item_05.jpg" alt="" />
								<span>디뮤지엄 YOUTH 아이폰 케이스 (6/6S/7)</span>
								<div><b><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></b></div>
							<% End If %>
							<%	set oItem = nothing %>
							</a>
						</li>
						<li>
							<a href="/shopping/category_prd.asp?itemid=1673274&pEtr=77234">
							<%
								IF application("Svr_Info") = "Dev" THEN
									itemid = 1239226
								Else
									itemid = 1673274
								End If
								set oItem = new CatePrdCls
									oItem.GetItemData itemid
							%>
							<% If oItem.FResultCount > 0 Then %>
								<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/77234/img_with_item_06.jpg" alt="" />
								<span>디뮤지엄 YOUTH 필통</span>
								<div><b><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></b></div>
							<% End If %>
							<%	set oItem = nothing %>
							</a>
						</li>
					</ul>
				</div>
			</div>
		</div>

		<%' author %>
		<div class="author">
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/77234/txt_author_01.png" alt="러시아 출신으로 모스크바와 뉴욕을 중심으로 활동하고 있는 사진작가 마샤 데미아노바는 여성의 시선 female gaze을 주제로 섬세하면서도 강인한 여인들의 모습을 사진으로 담는다. 그의 사진은 대체적으로 간결한 구성을 취하며 황량하고 몽환적인 분위기로 자유롭지만 동시에 쓸쓸하고 고독한 유스 Youth의 단면을 보여준다." /></p>
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/77234/txt_author_02.png" alt="사진작가 파올로 라엘리는 가까운 친구들이 경험한 인생의 아름다운 순간들과 일상을 카메라에 담아냄으로써 청춘이라는 시기에 겪을 수 있는 모호한 측면들을 다채롭게 녹여낸다. 사전 계획 없이 피사체들이 움직이는 생동감 넘치는 순간을 포착하는 그의 사진들은 종종 초점이 맞지 않은 모습 그대로 자연스럽게 기록된다. 그의 작업은 삶의 최고의 순간들을 자축하는 수단이자 그가 포착한 기억들을 다른 사람들이 경험할 수 있게 하는 매개체이다." /></p>
		</div>


		<%' story %>
		<div class="story">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/77234/tit_story.gif" alt="지금, 당신의 YOUTH를 깨워라!" /></h3>
			<div class="rollingwrap">
				<div id="rolling" class="rolling">
					<div class="swipemask mask-left"></div>
					<div class="swipemask mask-right"></div>
					<button type="button" class="btn-nav arrow-left">Previous</button>
					<button type="button" class="btn-nav arrow-right">Next</button>
					<div class="swiper">
						<div class="swiper-container swiper1">
							<div class="swiper-wrapper" style="height:630px;">
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1673277&pEtr=77234" title="디뮤지엄 YOUTH 상품보러 가기"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/77234/img_slide_story_01.jpg" alt="순수 영원히 늙고 싶지 않다. 청춘을 위한 우리의 자세" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1673274&pEtr=77234" title="필통 상품보러 가기"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/77234/img_slide_story_02.jpg" alt="반항 반항이 세상을 바꾼다. 거침없이 저항하라" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1673276&pEtr=77234" title="핀버튼 상품보러 가기"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/77234/img_slide_story_03.jpg" alt="자유 두려움 없이 표현할 수 있는 용기" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1673273&pEtr=77234" title="아이폰케이스 6 6S 7 상품보러 가기"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/77234/img_slide_story_04.jpg" alt="열정 청춘은 아름답다. 설령 모자라거나 서툴러도" /></a>
								</div>
							</div>
						</div>
					</div>
					<div class="pagination"></div>
				</div>
			</div>
		</div>

		<%' intro %>
		<div class="intro">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/77234/img_logo_d_museum.gif" alt="D MUSEUM" /></h3>
			<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/77234/img_d_museum.jpg" alt="" /></div>
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/77234/txt_d_museum.gif" alt="한남동의 문화예술 아지트 2016년 설립 20주년을 맞이하는 대림문화재단은 한남동 독서당로에 디뮤지엄을 개관하고 기존의 대림미술관에서 선보여온 다양한 콘텐츠들을 더 확장된 공간에서 보다 많은 이들에게 문화 예술의 수준 높은 감성을 제시할 것입니다." /></p>
		</div>

		<%' finish %>
		<div class="finish">
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/77234/txt_special_gift.jpg" alt="SPECIAL GIFT 디뮤지엄 YOUTH의 상품을 구매하신 고객님께 구매금액대별 유스 전시 티켓을 드립니다 15,000원 이상 구매시 유스 전시 프리티켓 1매 증정 30,000원 이상 구매스 유스 전시 프리티켓 2매 증정 2017. 4. 5~소진 시까지. 제공되는 티켓은 1인 1매 사용가능하며, 티켓이용기간 2017.02.08~ 2017.05.28 중 제한 없이 재관람이 가능합니다. 단, 대림미술관&디뮤지엄 모바일 앱 다운로드 및 인포데스크에서 회원 로그인 인증 후 입장가능하며, 대기인원이 있는 경우 입장이 지연될 수 있습니다. 대림미술관 인포데스크에서 온라인회원 가입 후 사용하셔도 무방하나, 미리 가입하시고 스마트폰 앱을 설치 하시고 오시면 입장이 보다 빠르고 편리하며,  앱을 통해 무료로 전시 오디오 가이드도 들으실 수 있습니다" /></p>
		</div>

		<%' comment %>
		<div class="commentevet">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/77234/tit_comment.gif" alt="Hey, something project 당신의 YOUTH" /></h3>
			<p class="hidden">당신에게 YOUTH란 무엇인가요? 정성껏 코멘트를 남겨주신 10분을 추첨하여 유스 토트백과 전시티켓 2매를 드립니다. 토트백 디자인 랜덤 발송. 코멘트 작성기간은 2017년 4월 5일부터 4월 11일까지며, 발표는 4월 12일 입니다.</p>
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
							<li class="ico1"><button type="button" value="1">순수</button></li>
							<li class="ico2"><button type="button" value="2">반항</button></li>
							<li class="ico3"><button type="button" value="3">자유</button></li>
							<li class="ico4"><button type="button" value="4">열정</button></li>
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
									<% if isarray(split(arrCList(1,intCLoop),"!@#")) then %>
										<strong class="ico<%= split(arrCList(1,intCLoop),"!@#")(0) %>">
											<% if split(arrCList(1,intCLoop),"!@#")(0)="1" then %>
												순수
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="2" then %>
												반항
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="3" then %>
												자유
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="4" then %>
												열정
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
	/* slide js */
	$("#slide").slidesjs({
		width:"609",
		height:"403",
		pagination:false,
		navigation:false,
		play:{interval:2000, effect:"fade", auto:true},
		effect:{fade: {speed:1000, crossfade:true}}
	});

	/* swipe */
	var swiper1 = new Swiper('#rolling .swiper1',{
		centeredSlides:true,
		slidesPerView:"auto",
		loop: true,
		speed:1200,
		autoplay:3000,
		simulateTouch:false,
		pagination: '#rolling .pagination',
		paginationClickable: true
	});

	$('#rolling .arrow-left').on('click', function(e){
		e.preventDefault()
		swiper1.swipePrev()
	});
	$('#rolling .arrow-right').on('click', function(e){
		e.preventDefault()
		swiper1.swipeNext()
	});

	$('#rolling .pagination span:nth-child(1)').append('<em class="desc1"></em>');
	$('#rolling .pagination span:nth-child(2)').append('<em class="desc2"></em>');
	$('#rolling .pagination span:nth-child(3)').append('<em class="desc3"></em>');
	$('#rolling .pagination span:nth-child(4)').append('<em class="desc4"></em>');

	$('#rolling .pagination span em').hide();
	$('#rolling .pagination .swiper-active-switch em').show();

	setInterval(function() {
		$('#rolling .pagination span em').hide();
		$('#rolling .pagination .swiper-active-switch em').show();
	}, 500);

	$('#rolling .pagination span,.btnNavigation').click(function(){
		$('#rolling .pagination span em').hide();
		$('#rolling .pagination .swiper-active-switch em').show();
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
	titleAnimation();
	$(".heySomething .topic h2 span").css({"width":"50px", "opacity":"0"});
	function titleAnimation() {
		$(".heySomething .topic h2 .letter1").delay(100).animate({"width":"125px", "opacity":"1"},1200);
		$(".heySomething .topic h2 .letter2").delay(300).animate({"width":"349px", "opacity":"1"},1200);
		$(".heySomething .topic h2 .letter3").delay(500).animate({"width":"206px", "opacity":"1"},1200);
	}
});
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->