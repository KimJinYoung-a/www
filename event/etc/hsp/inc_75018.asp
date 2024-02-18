<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈
' History : 2016-12-20 유태욱 생성
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
	eCode   =  66255
Else
	eCode   =  75018
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
.heySomething .topic {background-color:#e9d9c5; z-index:1;}

/* item */
.heySomething .itemA {margin-top:380px;}
.heySomething .itemA .desc {overflow:hidden; position:relative; min-height:auto; margin:84px 0 75px; padding-top:0;}
.heySomething .itemA .desc .option {float:left; width:380px; height:480px;}
.heySomething .itemA .desc .slidewrap {float:right; width:567px; height:493px; padding:47px 30px 0 0;}
.heySomething .itemA .slide {width:567px; height:493px; }
.heySomething .itemA .with ul {width:1080px; padding:75px 0 60px;}
.heySomething .itemA .with ul li {width:33.33333%; padding:0 0 35px;}

/* brand */
.heySomething .brand {position:relative; height:709px; margin-top:320px; padding-top:372px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/75018/bg_brand_v2.png) 50% 0 no-repeat;}
.heySomething .brand .btnDown {margin-top:85px;}
.heySomething .brand .logo {position:relative; width:363px; height:103px; margin:0 auto 68px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/75018/bg_line.png) 214px 0 no-repeat;}
.heySomething .brand .logo div {overflow:hidden; position:absolute; top:0;}
.heySomething .brand .logo img {position:relative;}
.heySomething .brand .logo .alice {left:0;}
.heySomething .brand .logo .tenten {right:0;}
.heySomething .brand p {position:relative;}
.heySomething .aliceTea {position:relative; height:823px; margin-top:400px; background:#fddfd8 url(http://webimage.10x10.co.kr/eventIMG/2016/hey/75018/img_tea.jpg) 50% 0 no-repeat;}
.heySomething .aliceTea a {display:block; position:absolute; left:0; top:0; width:100%; height:100%; text-indent:-999em;}

/* story */
.heySomething .story {padding-bottom:120px;}
.heySomething .rolling {margin-top:45px; padding-top:225px;}
.heySomething .rolling .swiper-pagination-switch {width:150px; height:180px; margin:0 40px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/75018/bg_ico_01_v7.png);}
.heySomething .rolling .pagination {top:0; padding-left:146px;}
.heySomething .rolling .pagination span em {bottom:-795px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/75018/txt_desc.png); cursor:default;}
.heySomething .rolling .pagination span:first-child {background-position:0 0;}
.heySomething .rolling .pagination span.swiper-active-switch {background-position:0 -180px;}
.heySomething .rolling .pagination span:first-child + span {background-position:-150px 0;}
.heySomething .rolling .pagination span:first-child + span.swiper-active-switch {background-position:-150px -180px;}
.heySomething .rolling .pagination span:first-child + span + span {background-position:-300px 0;}
.heySomething .rolling .pagination span:first-child + span + span.swiper-active-switch {background-position:-300px -180px;}
.heySomething .rolling .pagination span:first-child + span + span + span {background-position:-450px 0;}
.heySomething .rolling .pagination span:first-child + span + span + span.swiper-active-switch {background-position:-450px -180px;}
.heySomething .rolling .btn-nav {top:510px;}
.heySomething .swipemask {top:225px;}

/* finish */
.heySomething .finish {height:870px; margin-top:370px; background:#d8cdf2 url(http://webimage.10x10.co.kr/eventIMG/2016/hey/75018/bg_finish.jpg) 50% 0 no-repeat;}
.heySomething .finish a {display:block; position:absolute; left:50%; top:0; width:1140px; height:100%; margin-left:-570px;}
.heySomething .finish p {position:absolute; left:15px; top:230px; }

/* comment */
.heySomething .commentevet {margin-top:430px;}
.heySomething .commentevet textarea {margin-top:40px;}
.heySomething .commentevet .form {margin-top:45px;}
.heySomething .commentevet .form .choice {margin-left:-10px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/75018/bg_ico_02_v3.png);}
.heySomething .commentlist table td {padding:0 0 15px;}
.heySomething .commentlist table td strong {height:150px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/75018/bg_ico_02_v3.png); background-position:0 0;}
.heySomething .commentlist table td .ico2 {background-position:-150px 0;}
.heySomething .commentlist table td .ico3 {background-position:-300px 0;}
.heySomething .commentlist table td .ico4 {background-position:-450px 0;}
.heySomething .commentlist table td.lt {padding:15px 10px 0 0;}
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
		<% If not( left(currenttime,10)>="2016-12-20" and left(currenttime,10)<"2016-12-28" ) Then %>
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
			<div class="bnr"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/75018/img_item_represent.jpg" alt="alice in wonderland" /></div>
		</div>

		<!-- about -->
		<div class="about">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
			<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
		</div>

		<!-- item -->
		<div class="item itemA">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/75018/tit_alice_10x10.png" alt="ALICE in WONDERLAND X 10x10" /></h3>
			<a href="/shopping/category_prd.asp?itemid=1612371&amp;pEtr=75018" class="goItem">
				<div class="desc">
					<div class="option">
						<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/75018/txt_name_v2.png" alt="[Disney] Alice 스트로베리 홍차(7개입)" /></p>
						<%'' for dev msg : 상품코드 1612371, 할인기간 12/21 ~ 12/27 할인기간이 지나면  <strong class="discount">...</strong> 숨겨주세요 %>
						<%
							IF application("Svr_Info") = "Dev" THEN
								itemid = 1239226
							Else
								itemid = 1612371
							End If
							set oItem = new CatePrdCls
								oItem.GetItemData itemid
						%>
						<% If oItem.FResultCount > 0 Then %>
							<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
								<div class="price">
									<% If not( left(currenttime,10)>="2016-12-21" and left(currenttime,10)<="2016-12-27" ) Then %>
									<% else %>
										<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/txt_only_10percent.png" alt="단, 일주일만 10%" /></strong>
										<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
									<% end if %>
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								</div>
							<% else %>
								<div class="price priceEnd">
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								</div>
							<% End If %>
						<% End If %>
						<%	set oItem = nothing %>
						<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/75018/txt_substance_v2.png" alt="이상한 나라의 앨리스’ 주인공들과 함께 티타임을 더욱 풍부하게 즐겨보아요! 달콤한 티와 함께 메시지를 담아 마음을 전하세요. 방안 가득 향긋한 스트로베리 홍차 향이 퍼지며 나만의 WONDER LAND가 펼쳐집니다." /></p>
						<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러가기" /></div>
					</div>
					<div class="slidewrap">
						<div id="slide01" class="slide">
							<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/75018/img_item_01.jpg" alt="" /></div>
							<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/75018/img_item_02.jpg" alt="" /></div>
						</div>
					</div>
				</div>
			</a>
			<div class="with">
				<span><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/ico_plus.png" alt="" /></span>
				<ul>
					<li>
						<a href="/shopping/category_prd.asp?itemid=1422085&amp;pEtr=75018">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/75018/img_with_01.jpg" alt="" />
							<span>[Disney]Alice_Tea cup 2set (4pcs)</span>
							<% If not( left(currenttime,10)>="2016-12-20" and left(currenttime,10)<="2016-12-27" ) Then %>
								<strong>60,000won</strong>
							<% else %>
								<% if left(currenttime,10)="2016-12-21" then %>
									<strong>36,000won (40%)</strong>
								<% else %>
									<strong>48,000won (20%)</strong>
								<% end if %>
							<% end if %>
						</a>
					</li>
					<li>
						<a href="/shopping/category_prd.asp?itemid=1405559&amp;pEtr=75018">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/75018/img_with_02.jpg" alt="" />
							<span>[Disney]Alice_Tea pot set</span>
							<% If not( left(currenttime,10)>="2016-12-20" and left(currenttime,10)<="2016-12-27" ) Then %>
								<strong>120,000won</strong>
							<% else %>
								<% if left(currenttime,10)="2016-12-21" then %>
									<strong>72,000won (40%)</strong>
								<% else %>
									<strong>96,000won (20%)</strong>
								<% end if %>
							<% end if %>
						</a>
					</li>
					<li>
						<a href="/shopping/category_prd.asp?itemid=1474756&amp;pEtr=75018">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/75018/img_with_03.jpg" alt="" />
							<span>[Disney]Alice_Cushion (4style)</span>
							<% If not( left(currenttime,10)>="2016-12-20" and left(currenttime,10)<="2016-12-27" ) Then %>
								<strong>39,000won</strong>
							<% else %>
								<strong>31,200won (20%)</strong>
							<% end if %>
						</a>
					</li>
					<li>
						<a href="/shopping/category_prd.asp?itemid=1593649&amp;pEtr=75018">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/75018/img_with_04.jpg" alt="" />
							<span>[Disney]Alice Poster</span>
							<% If not( left(currenttime,10)>="2016-12-20" and left(currenttime,10)<="2016-12-27" ) Then %>
								<strong>12,000won</strong>
							<% else %>
								<strong>9,600won (20%)</strong>
							<% end if %>
						</a>
					</li>
					<li>
						<a href="/shopping/category_prd.asp?itemid=1542686&amp;pEtr=75018">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/75018/img_with_05.jpg" alt="" />
							<span>[Disney]Alice_Hologram Note</span>
							<% If not( left(currenttime,10)>="2016-12-20" and left(currenttime,10)<="2016-12-27" ) Then %>
								<strong>14,000won</strong>
							<% else %>
								<strong>11,200won (20%)</strong>
							<% end if %>
						</a>
					</li>
					<li>
						<a href="/shopping/category_prd.asp?itemid=1413577&amp;pEtr=75018">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/75018/img_with_06.jpg" alt="" />
							<span>[Disney]Alice_Playing Cards</span>
							<% If not( left(currenttime,10)>="2016-12-20" and left(currenttime,10)<="2016-12-27" ) Then %>
								<strong>12,000won</strong>
							<% else %>
								<strong>9,600won (20%)</strong>
							<% end if %>
						</a>
					</li>
				</ul>
			</div>
		</div>

		<!-- brand -->
		<div class="brand">
			<div class="text">
				<div class="logo">
					<div class="alice"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/75018/txt_logo_alice.png" alt="" /></div>
					<div class="tenten"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/75018/txt_logo_10x10.png" alt="" /></div>
				</div>
				<p class="t1"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/75018/txt_brand_01.png" alt="나른한 오후, 언니와 책을 읽고 있던 앨리스는 뛰어가는 하얀 토끼를 따라 토끼 굴로 뛰어들었습니다. 그렇게 시작된 이상한 나라에서의 모험! 앨리스의 달콤한 꿈일까요? 아니면 모두가 꿈꾸는 Wonderland일까요?" /></p>
				<p class="t2 tMar35"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/75018/txt_brand_02.png" alt="방안 가득 향긋한 스트로베리 홍차 향이 퍼지며 나만의 Wonderland가 펼쳐집니다. 앨리스와 함께 달콤한 티타임을 가져보아요." /></p>
			</div>
			<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="" /></div>
		</div>
		<div class="aliceTea"><a href="/shopping/category_prd.asp?itemid=1612371&amp;pEtr=75018">[Disney]Alice_스트로베리 홍차</a></div>

		<!-- story -->
		<div class="story">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/75018/tit_story.png" alt="앨리스와 함께하는 달콤한 시간" /></h3>
			<div class="rollingwrap">
				<div class="rolling rolling1">
					<div class="swipemask mask-left"></div>
					<div class="swipemask mask-right"></div>
					<button type="button" class="btn-nav arrow-left">Previous</button>
					<button type="button" class="btn-nav arrow-right">Next</button>
					<div class="swiper">
						<div class="swiper-container swiper1">
							<div class="swiper-wrapper">
								<div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1612371&amp;pEtr=75018"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/75018/img_slide_03.jpg" alt="#MY SWEET TIME - 찻잔 가득 채워진 홍차처럼 흩어진 질문에 나만의 답을 채우는 시간" /></a></div>
								<div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1612371&amp;pEtr=75018"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/75018/img_slide_02.jpg" alt="#SWEET TALK - 방 안 가득 퍼진 달콤한 홍차 향, 그리고 소중한 사람들과 함께하는 티타임 " /></a></div>
								<div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1612371&amp;pEtr=75018"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/75018/img_slide_01.jpg" alt="#SWEET GIFT - 달콤한 시간을 선물하세요! 티백 뒷면 메시지를 적어 마음도 함께 전하면 어떨까요?" /></a></div>
							</div>
						</div>
					</div>
					<div class="pagination"></div>
				</div>
			</div>
		</div>

		<!-- finish -->
		<div class="finish">
			<a href="/street/street_brand_sub06.asp?makerid=disney10x10">
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/75018/txt_finish.png" alt="SWEET TIME with ALICE" /></p>
			</a>
		</div>

		<!-- comment -->
		<div class="commentevet">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/75018/tit_comment_v3.png" alt="Hey, something project, 나만의 Sweet Time을 소개해주세요!" /></h3>
			<p class="hidden">스트로베리 홍차처럼 달콤한 나만의 시간을 소개해주세요! 정성껏 코멘트를 남겨주신 5분을 추첨하여 [Disney]Alice_스트로베리 홍차(7개입)를 발송해드립니다.</p>
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
							<li class="ico1"><button type="button" value="1">#SWEET TIME</button></li>
							<li class="ico2"><button type="button" value="2">#SWEET TALK</button></li>
							<li class="ico3"><button type="button" value="3">#SWEET GIFT</button></li>
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
												#SWEET TIME
											<% Elseif split(arrCList(1,intCLoop),"!@#")(0)="2" Then %>
												#SWEET TALK
											<% Elseif split(arrCList(1,intCLoop),"!@#")(0)="3" Then %>
												#SWEET GIFT
											<% else %>
												#SWEET TIME
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
<script type="text/javascript">
$(function(){
	/* slide js */
	$("#slide01").slidesjs({
		width:"567",
		height:"493",
		pagination:false,
		navigation:false,
		play:{interval:2000, effect:"fade", auto:true},
		effect:{fade: {speed:900, crossfade:true}
		}
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
		if (scrollTop > 3400 ) {
			brandAnimation()
		}
		if (scrollTop > 7300 ) {
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

	$(".heySomething .brand .logo .alice").css({"left":"50px","opacity":"0"});
	$(".heySomething .brand .logo .tenten").css({"right":"50px","opacity":"0"});
	$(".heySomething .brand .text p").css({"top":"15px","opacity":"0"});
	$(".heySomething .brand .btnDown").css({"opacity":"0"});
	function brandAnimation() {
		$(".heySomething .brand .logo .alice").animate({"left":"0","opacity":"1"},900);
		$(".heySomething .brand .logo .tenten").animate({"right":"0","opacity":"1"},900);
		$(".heySomething .brand .text .t1").delay(700).animate({"top":"0","opacity":"1"},700);
		$(".heySomething .brand .text .t2").delay(1000).animate({"top":"0","opacity":"1"},700);
		$(".heySomething .brand .btnDown").delay(1500).animate({"opacity":"1"},900);
	}

	$(".heySomething .finish p").css({"margin-left":"-10px","opacity":"0"});
	function finishAnimation() {
		$(".heySomething .finish p").delay(100).animate({"margin-left":"0","opacity":"1"},1000);
	}
});
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->