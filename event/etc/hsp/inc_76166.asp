<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈
' History : 2017-02-14 원승현 생성
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
	eCode   =  66278
Else
	eCode   =  76166
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
.heySomething .topic {background-color:#f6eddc; z-index:1;}
.heySomething .topic h2 span{background:url(http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_hey_something_project.png) no-repeat 0 0}

/* item */
.heySomething .itemB {padding-bottom:390px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/hey/common/bg_line.png);}
.heySomething .itemB a.goItem {display:block;}
.heySomething .itemB .desc {position:relative; padding-left:550px; min-height:410px;}
.heySomething .itemB .desc .option {position:absolute; top:0; left:83px;}
.heySomething .itemB .option .price {margin-top:28px; height:auto;}
.heySomething .itemB .option .substance {position:static; padding-top:50px;}
.heySomething .itemB .option .btnget {position:static; padding-top:50px;}
.heySomething .itemB .slidewrap {width:561px; margin-top:82px;}
.heySomething .itemB .slidewrap .slide {width:561px; height:432px;}
.heySomething .itemB .slidewrap .slide .slidesjs-navigation {top:200px;}
.heySomething .itemB .slidewrap .slide .slidesjs-previous {left:520px;}
.heySomething .itemB ul.slidesjs-pagination {width:100%; position:absolute; bottom:-393px; margin-left:-555px;}
.heySomething .itemB .slidesjs-pagination li {margin:50px auto;}
.heySomething .itemB .slidesjs-pagination li a {width:185px; height:166px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/76166/bg_pagination.png);}
.heySomething .itemB .slidesjs-pagination .num02 a {background-position:-218px 0;}
.heySomething .itemB .slidesjs-pagination .num02 a:hover, .heySomething .itemB .slidesjs-pagination .num02 .active {background-position:-218px  100%;}
.heySomething .itemB .slidesjs-pagination .num03 a {background-position:-437px 0;}
.heySomething .itemB .slidesjs-pagination .num03 a:hover, .heySomething .itemB .slidesjs-pagination .num03 .active {background-position:-437px 100%;}
.heySomething .itemB .slidesjs-pagination .num04 a {background-position:-655px 0;}
.heySomething .itemB .slidesjs-pagination .num04 a:hover, .heySomething .itemB .slidesjs-pagination .num04 .active {background-position:-655px 100%;}
.heySomething .itemB .slidesjs-pagination .num05 a {background-position:100% 0;}
.heySomething .itemB .slidesjs-pagination .num05 a:hover, .heySomething .itemB .slidesjs-pagination .num05 .active {background-position:100% 100%;}

/* visual */
.visual {height:920px; margin-top:395px; background:#e6dec9 url(http://webimage.10x10.co.kr/eventIMG/2017/hey/76166/img_item.jpg) no-repeat 50% 0;}

/* brand */
.heySomething .brand {position:relative; height:670px; margin:340px 0 0;}
.heySomething .brand h4 {margin-bottom:90px;}
.heySomething .brand p.brandTxt01 {margin-bottom:43px;}
.heySomething .brand p.brandTxt02 {margin-bottom:55px;}

/* items */
.heySomething .items {text-align:center; margin-top:415px;}
.heySomething .items ul {position:relative; width:1140px; height:675px; margin:0 auto;}
.heySomething .items li {position:absolute; overflow:hidden;}
.heySomething .items li a {cursor:pointer;}
.heySomething .items li.item01 {left:0; top:0; width:444px; height:673px; background-color:#b18053;}
.heySomething .items li.item02 {left:460px; top:0; width:332px; height:429px; background-color:#efdabd;}
.heySomething .items li.item03 {left:460px; bottom:0; width:332px; height:228px; background-color:#858043;}
.heySomething .items li.item04 {right:0px; top:0px; width:332px; height:228px; background-color:#0d0d0f;}
.heySomething .items li.item05 {right:0px; bottom:0; width:332px; height:429px; background-color:#fe7a23;}
@keyframes pulse {
	0% {transform:scale(1.2);}
	100% {transform:scale(1);}
}
.pulse {animation-name:pulse; animation-duration:2s; animation-iteration-count:1;}

/* story */
.heySomething .story {margin-top:465px; padding-bottom:515px;}
.heySomething .story h6 {padding-bottom:65px;}
.heySomething .story .swiper-slide {position:relative;}
.heySomething .story .swiper-slide span {position:absolute; top:0; left:0; z-index:10;}
.heySomething .rolling {position:relative; padding-top:177px;}
.heySomething .rollingwrap {margin-top:0;}
.heySomething .story .swiper-slide span {position:absolute; top:150px; left:81px; opacity:0;}
.heySomething .story .swiper-slide-active span{top:100px; opacity:1; transition:2s; }
.heySomething .story .swiper-slide.slideImg2 span{top:130px; left:285px;}
.heySomething .story .swiper-slide-active.slideImg2 span{top:80px;}
.heySomething .story .swiper-slide.slideImg3 span{top:345px; left:550px;}
.heySomething .story .swiper-slide-active.slideImg3 span{top:395px;}
.heySomething .story .swiper-slide.slideImg4 span{top:358px; left:100px;}
.heySomething .story .swiper-slide-active.slideImg4 span{top:378px;}
.heySomething .rolling .swiper-pagination-switch {width:120px; height:120px; margin:0 49px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/76166/bg_ico_01.png) no-repeat 0 0;}
.heySomething .rolling .pagination {top:0; padding-left:54px;}
.heySomething .rolling .pagination span:first-child {background-position:0 0;}
.heySomething .rolling .pagination span.swiper-active-switch {background-position:0 100%;}
.heySomething .rolling .pagination span:first-child + span {background-position: -219px 0;}
.heySomething .rolling .pagination span:first-child + span.swiper-active-switch {background-position:-219px 100%;}
.heySomething .rolling .pagination span:first-child + span + span {background-position:-437px 0;}
.heySomething .rolling .pagination span:first-child + span + span.swiper-active-switch {background-position:-437px 100%;}
.heySomething .rolling .pagination span:first-child + span + span + span {background-position:100% 0;}
.heySomething .rolling .pagination span:first-child + span + span + span.swiper-active-switch {background-position:100% 100%;}
.heySomething .rolling .btn-nav {top:490px;}
.heySomething .swipemask {height:100%; }

/* finish */
.heySomething .finish {width:889px; height:570px; margin:0 auto;/* height:495px; margin-top:300px; background:#d7ccbc url(http://webimage.10x10.co.kr/eventIMG/2017/hey/76166/bg_finish.jpg) 50% 0 no-repeat; text-indent:-999em; */}

/* comment */
.heySomething .commentevet {margin-top:473px; padding-top:45px;}
.heySomething .commentevet textarea {margin-top:36px;}
.heySomething .commentevet .form {margin-top:30px;}
.heySomething .commentevet .form .choice {margin-left:0px;}
.heySomething .commentevet .form .choice li{width:120px; height:120px; margin-right:35px;}
.heySomething .commentevet .form .choice li button, .heySomething .commentevet .form .choice li button.on {width:120px; height:120px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/76166/bg_ico_02.png);}
.heySomething .commentevet .form .choice li.ico1 button{background-position:0 0}
.heySomething .commentevet .form .choice li.ico1 button.on{background-position:0 100%}
.heySomething .commentevet .form .choice li.ico2 button{background-position:-155px 0;}
.heySomething .commentevet .form .choice li.ico2 button.on{background-position:-155px 100%;}
.heySomething .commentevet .form .choice li.ico3 button{background-position:-309px 0;}
.heySomething .commentevet .form .choice li.ico3 button.on{background-position:-309px 100%;}
.heySomething .commentevet .form .choice li.ico4 button{background-position:100% 0;}
.heySomething .commentevet .form .choice li.ico4 button.on{background-position:100% 100%;}
.heySomething .commentevet textarea {margin-top:55px;}
.heySomething .commentlist table td {padding:28px 0 40px;}
.heySomething .commentlist table td strong {width:120px; height:120px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/76166/bg_ico_02.png); background-position:0 0;}
.heySomething .commentlist table td .ico2 {background-position:-155px 0;}
.heySomething .commentlist table td .ico3 {background-position:-309px 0;}
.heySomething .commentlist table td .ico4 {background-position:100% 0;}
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
		<% If not( left(currenttime,10)>="2017-02-14" and left(currenttime,10)<"2017-02-22" ) Then %>
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
			<div class="bnr"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76166/img_item_represent.jpg" alt="metal et Linnen" /></div>
		</div>

		<%' about %>
		<div class="about">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
			<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
		</div>

		<%' item %>
		<div class="item itemB">
			<div class="inner">
				<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76166/txt_metal.png" alt="metal et Linnen" /></h3>
				<a href="/shopping/category_prd.asp?itemid=1646491&amp;pEtr=76166" class="goItem">
					<div class="desc">
						<div class="option">
							<em class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76166/txt_name.png" alt="MAKE IT YOURSELF WATCH" /></em>
							<%'' for dev msg : 상품코드 1621114, 할인기간 01/11 ~ 01/17 할인기간이 지나면  <strong class="discount">...</strong> 숨겨주세요 %>
							<%
								IF application("Svr_Info") = "Dev" THEN
									itemid = 1239226
								Else
									itemid = 1646491
								End If
								set oItem = new CatePrdCls
									oItem.GetItemData itemid
							%>
							<% If oItem.FResultCount > 0 Then %>
								<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
									<div class="price">
										<% If not( left(currenttime,10)>="2017-02-15" and left(currenttime,10)<"2017-02-22" ) Then %>
										<% else %>
											<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/txt_only_41percent.png" alt="단, 일주일만 ONLY 41%" /></strong>
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
							<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76166/txt_substance_v2.png" alt="하나 하나의 옵션을 선택하면, 그에 맞게 수작업으로 제작되는 세상에 단 하나 뿐인 시계 나만의 각인 메시지를 더해 더욱 더 특별하게, 흘러가는 소중한 우리의 시간을 기억하세요" /></p>
							<div class="btnget">
								<img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러 가기" />
							</div>
						</div>
						<div class="slidewrap">
							<div id="slide01" class="slide">
								<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76166/img_item_01.jpg" alt="" /></div>
								<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76166/img_item_02.jpg" alt="" /></div>
								<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76166/img_item_03.jpg" alt="" /></div>
								<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76166/img_item_04.jpg" alt="" /></div>
								<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76166/img_item_05.jpg" alt="" /></div>
							</div>
						</div>
					</div>
				</a>
			</div>
		</div>

		<%' visual %>
		<div class="visual"></div>

		<%' brand %>
		<div class="brand">
			<h4><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76166/txt_brand_01.png" alt="metal et linnen" /></h4>
			<p class="brandTxt01"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76166/txt_brand_02.png" alt="메탈엣린넨(Metal et Linnen)은 시계의 주요 소재들인 차가운 이미지의 메탈(Metal)과 따뜻하고 편안한 이미지의 린넨(Linnen)의 합성어로, 상반된 두 가지의 소재들을 매력적으로 사용한 작가들의 손길에 아날로그 감성이 더해진, 수공예 시계 브랜드 입니다. MAKE IT YOURSELF WATCH는 부품 하나 하나 당신을 위해 생각하며 만든 그 소중한 마음씨를 담은 세상에 오직 하나뿐인 시계입니다. " /></p>
			<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="" /></div>
		</div>

		<%' items %>
		<div class="items">
			<ul> 
				<li class="item01"><a href="/shopping/category_prd.asp?itemid=1646491&amp;pEtr=76166"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76166/img_metal_01.jpg" alt="" /></a></li>
				<li class="item02"><a href="/shopping/category_prd.asp?itemid=1646491&amp;pEtr=76166"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76166/img_metal_02.jpg" alt="" /></a></li>
				<li class="item03"><a href="/shopping/category_prd.asp?itemid=1646491&amp;pEtr=76166"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76166/img_metal_03.jpg" alt="" /></a></li>
				<li class="item04"><a href="/shopping/category_prd.asp?itemid=1646491&amp;pEtr=76166"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76166/img_metal_04.jpg" alt="" /></a></li>
				<li class="item05"><a href="/shopping/category_prd.asp?itemid=1646491&amp;pEtr=76166"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76166/img_metal_05.jpg" alt="" /></a></li>
			</ul>
		</div>

		<%' story %>
		<div class="story">
			<h6><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76166/txt_story.png" alt="소소하지만 사소하지 않은, 우리의 특별한 날들" /></h6>
			<div class="rollingwrap">
				<div class="rolling rolling1">
					<div class="swipemask mask-left"></div>
					<div class="swipemask mask-right"></div>
					<button type="button" class="btn-nav arrow-left">Previous</button>
					<button type="button" class="btn-nav arrow-right">Next</button>
					<div class="swiper">
						<div class="swiper-container swiper1">
							<div class="swiper-wrapper">
								<div class="swiper-slide slideImg1"><a href="/shopping/category_prd.asp?itemid=1646491&amp;pEtr=76166"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76166/img_slide_watch_01.jpg" alt="" /><span><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76166/txt_slide_01.png" alt="“당신을 생각하며 만드는 시계”" /></span></a></div>
								<div class="swiper-slide slideImg2"><a href="/shopping/category_prd.asp?itemid=1646491&amp;pEtr=76166"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76166/img_slide_watch_02.jpg" alt="" /><span><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76166/txt_slide_02.png" alt="“잠깐 보고싶은데, 시간 괜찮아?”" /></span></a></div>
								<div class="swiper-slide slideImg3"><a href="/shopping/category_prd.asp?itemid=1646491&amp;pEtr=76166"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76166/img_slide_watch_03.jpg" alt="" /><span><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76166/txt_slide_03.png" alt="“시간이 기억이 되고 기억은 추억이 된다”" /></span></a></div>
								<div class="swiper-slide slideImg4"><a href="/shopping/category_prd.asp?itemid=1646491&amp;pEtr=76166"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76166/img_slide_watch_04.jpg" alt="" /><span><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76166/txt_slide_04.png" alt="“우리 함께, 천천히 느리게 걷자”" /></span></a></div>
							</div>
						</div>
					</div>
					<div class="pagination"></div>
				</div>
			</div>
		</div>

		<%' finish %>
		<div class="finish"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76166/img_finish.jpg" alt="" /></div>

		<%' comment %>
		<div class="commentevet">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/76166/tit_comment_v2.png" alt="Hey, something project, 특별한 메시지의 시계를 선물하고 싶은 사람은? " /></h3>
			<p class="hidden">정성껏 코멘트를 남겨주신 1분을 추첨하여 메탈엣린넨의 MAKE IT YOURSELF 제품을 선물 드립니다. </p>
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
							<li class="ico1"><button type="button" value="1"># make</button></li>
							<li class="ico2"><button type="button" value="2"># moment</button></li>
							<li class="ico3"><button type="button" value="3"># remember</button></li>
							<li class="ico4"><button type="button" value="4"># together</button></li>
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
												# make
											<% Elseif split(arrCList(1,intCLoop),"!@#")(0)="2" Then %>
												# moment
											<% Elseif split(arrCList(1,intCLoop),"!@#")(0)="3" Then %>
												# remember
											<% Elseif split(arrCList(1,intCLoop),"!@#")(0)="4" Then %>
												# together
											<% else %>
												# make
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
		width:"561",
		height:"432",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:2500, effect:"fade", auto:true},
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
	$(".slidesjs-pagination li:nth-child(5)").addClass("num05");

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
		if (scrollTop > 3000 ) {
			brandAnimation01()
		}
		if (scrollTop > 4100 ) {
			$(".heySomething .items ul li a img").addClass("pulse");
			featureAnimation()
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

	$(".brand p").css({"opacity":"0"});
	$(".brand h4").css({"margin-top":"7px","opacity":"0"});
	$(".brand .brandTxt01").css({"margin-top":"7px"});
	$(".brand .btnDown").css({"opacity":"0"});
	function brandAnimation01() {
		$(".brand h4").delay(100).animate({"margin-top":"0px","opacity":"1"},900);
		$(".brand .brandTxt01").delay(500).animate({"margin-top":"7px","opacity":"1"},900);
		$(".brand .btnDown").delay(1200).animate({"opacity":"1"},1000);
	}

	$(".heySomething .items li img").css({"opacity":"0"});
	function featureAnimation() {
		$(".heySomething .items li.item01 img").delay(100).animate({"opacity":"1"},700);
		$(".heySomething .items li.item02 img").delay(200).animate({"opacity":"1"},700);
		$(".heySomething .items li.item03 img").delay(300).animate({"opacity":"1"},700);
		$(".heySomething .items li.item04 img").delay(500).animate({"opacity":"1"},700);
		$(".heySomething .items li.item05 img").delay(400).animate({"opacity":"1"},700);
	}

});
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->