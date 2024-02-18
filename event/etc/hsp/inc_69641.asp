<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈 26 WWW
' History : 2016-03-29 유태욱 생성
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
'																			currenttime = #03/02/2016 09:00:00#

dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  66097
Else
	eCode   =  69641
End If

dim userid, commentcount, i
	userid = GetEncLoginUserID()

commentcount = getcommentexistscount(userid, eCode, "", "", "", "Y")

dim cEComment ,blnFull, cdl, com_egCode, bidx, blnBlogURL, strBlogURL
dim iCTotCnt, arrCList,intCLoop, ecc
dim iCPageSize, iCCurrpage, isMyComm
dim iCStartPage, iCEndPage, iCTotalPage, iCx,iCPerCnt
	iCCurrpage	= requestCheckVar(Request("iCC"),10)	'현재 페이지 번호
	cdl			= requestCheckVar(Request("cdl"),3)
	blnFull		= requestCheckVar(Request("blnF"),10)
	blnBlogURL	= requestCheckVar(Request("blnB"),10)
	isMyComm	= requestCheckVar(request("isMC"),1)
	ecc	= requestCheckVar(request("ecc"),10)
	
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
	iCPageSize = 6
else
	iCPageSize = 6
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


Dim hspchk
'// 현재 주소값 체크하여 신규, 구버전 확인
hspchk = Split(LCase(Request.ServerVariables("PATH_INFO")),"/")
%>
<style type="text/css">
@import url(http://fonts.googleapis.com/earlyaccess/nanumgothic.css);

/* title */
.heySomething .topic {background:#f4f6f1 url(http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/img_item_represent.jpg) no-repeat 50% 0;}
.heySomething .topic .bnr {text-indent:-9999em;}
.heySomething .topic .bnr a {display:block; width:100%; height:780px;}

/* brand */
.heySomething .brandClaska {height:auto;}
.heySomething .brandClaska .inner {position:relative; height:542px; margin-top:115px;}
.heySomething .brandClaska .inner .photo, .heySomething .brand .inner p {position:absolute; top:0; left:50%;}
.heySomething .brandClaska .inner .photo {margin-left:-465px;}
.heySomething .brandClaska .inner p {top:113px; margin-left:31px;}

.heySomething .brandDo {height:1098px; padding:0;}
.heySomething .brandDo .intro {position:relative; width:1140px; margin:96px auto 0;}
.heySomething .brandDo .intro .dark {position:absolute; top:0; left:0;}
.heySomething .brandDo .intro p {position:absolute; top:225px; left:50%; margin-left:-207px;}
.heySomething .brandDo .intro p span {display:block; position:absolute; top:0; left:0; width:415px; height:30px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/txt_claska_do.png) no-repeat 50% 0; text-indent:-9999em;}
.heySomething .brandDo .intro p .letter2 {top:46px; background-position:50% -46px;}
.heySomething .brandDo .intro p .letter3 {top:84px; background-position:50% -84px;}
.heySomething .brandDo .intro p .letter4 {top:124px; background-position:50% -124px;}
.heySomething .brandDo .btnDown {margin-top:130px;}
.heySomething .brand .btnDown img {animation-iteration-count:0;}

/* gallery */
.gallery {position:relative; margin-top:170px;}
.gallery .bg img {width:100%;}
.gallery ul li {position:absolute;}
.gallery ul li a {overflow:hidden; display:block; position:relative;}
.gallery ul li .off img {width:100%; transition:transform 0.5s ease-in-out;}
.gallery ul li a:hover .off img {transform:scale(1.1);}
.gallery ul li .mask {position:absolute; top:0; left:0; width:100%; height:101%; background:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/bg_mask.png) repeat 0 0;}
.gallery ul li .mask {transition:opacity 0.2s ease-out; opacity:0; filter: alpha(opacity=0);}
.gallery ul li a:hover .mask {opacity:1; filter: alpha(opacity=100); height:101%;}
.gallery ul li .word {overflow:hidden; width:100%; height:64px; position:absolute; top:50%; left:0; margin-top:-32px; text-align:center;}
.gallery ul li .word b, .gallery ul li .word span {display:block; position:absolute; width:100%;}
.gallery ul li .word b {top:-45px; left:0; transition:top 0.35s linear;}
.gallery ul li .word span {bottom:-45px; left:0; transition:bottom 0.35s linear;}
.gallery ul li a:hover .word b {top:0;}
.gallery ul li a:hover .word span {bottom:0;}
.gallery ul li.item1 {top:0; left:0; width:23.38%;}
.gallery ul li.item2 {top:0; left:23.9%; width:27.43%;}
.gallery ul li.item3 {top:0; left:51.86%; width:21.28%;}
.gallery ul li.item4 {top:0; right:0; width:26.32%;}
.gallery ul li.item5 {bottom:0; left:0; width:33.15%;}
.gallery ul li.item6 {bottom:0; left:33.68%; width:17.65%;}
.gallery ul li.item7 {bottom:0; left:51.86%; width:21.33%;}
.gallery ul li.item8 {bottom:0; right:0; width:26.32%;}

/* claska item */
.claskaItem {position:relative; height:640px; margin-top:305px; background-color:#efefed; background-repeat:no-repeat; background-position:50% 0;}
.claskaItem h4 {position:absolute; top:135px; left:50%; z-index:10; margin-left:83px;}
.claskaItem p {position:absolute; top:217px; left:50%; z-index:10; margin-left:83px;}
.claskaItem .btnGroup {overflow:hidden; position:absolute; z-index:10; top:479px; left:50%; margin-left:83px;}
.claskaItem .btnGroup a {overflow:hidden; float:left; position:relative; width:147px; margin-right:9px;}
.claskaItem .btnGroup a img {transition:all 0.5s;}
.claskaItem .btnGroup a:hover img {margin-left:-147px;}
.claskaItem .btnGroup a:after {content:' '; display:block; position:absolute; top:0; left:0; z-index:5; width:1px; height:40px; background-color:#484848;}

.typeLeft h4 {margin-left:-480px;}
.typeLeft p {margin-left:-480px;}
.typeLeft .btnGroup {margin-left:-480px;}

.slide {position:relative;}
.slide .slidesjs-container, .slide .slidesjs-control {height:640px !important;}
.slide .swiper-slide {height:640px;}
.slide .swiper-slide img {height:640px;}
.slidesjs-pagination {overflow:hidden; position:absolute; bottom:20px; left:50%; z-index:50; width:30px; margin-left:-15px;}
.slidesjs-pagination li {float:left; padding:0 2px;}
.slidesjs-pagination li a {display:block; width:11px; height:11px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/btn_pagination.png) no-repeat 50% 0; transition:0.5s ease; text-indent:-999em;}
.slidesjs-pagination li a.active {background-position:50% 100%;}

.claskaItem1 {margin-top:560px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/img_item_canvas_tote_bag.jpg);}
.claskaItem1 .btnGroup a {width:148px;}
.claskaItem1 .btnGroup a:hover img {margin-left:-148px;}

.claskaItem2 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/img_item_straw_hat.jpg);}
.claskaItem2 p {top:194px;}
.claskaItem2 .btnGroup {top:491px;}

.claskaItem3 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/img_item_canvasz_ippered_pouch.jpg);}
.claskaItem3 h4 {top:144px;}
.claskaItem3 p {top:271px;}
.claskaItem3 .btnGroup {top:494px;}

.claskaItem4 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/img_item_sway_tokyo_tote_bag.jpg);}
.claskaItem4 h4 {top:161px;}
.claskaItem3 p {top:243px;}
.claskaItem4 .btnGroup {top:488px;}

.claskaItem5 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/img_item_mambo_tote_bag.jpg);}
.claskaItem5 h4 {top:130px;}
.claskaItem5 p {top:211px;}
.claskaItem5 .btnGroup {top:483px;}

.claskaItem6 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/img_item_mambo_zippered_pouch.jpg);}
.claskaItem6 h4 {top:157px;}
.claskaItem6 p {top:238px;}
.claskaItem6 .btnGroup {top:458px;}
.claskaItem6 .btnGroup a {width:148px;}
.claskaItem6 .btnGroup a:hover img {margin-left:-148px;}

/* video */
.video {width:1140px; margin:375px auto 0;}

/* comment */
.heySomething .commentevet .form {margin-top:26px;}
.heySomething .commentevet .form .choice li {width:113px; margin-right:33px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/bg_ico_v1.png); background-position:0 0;}
.heySomething .commentevet .form .choice li.ico2 button {background-position:-146px 0;}
.heySomething .commentevet .form .choice li.ico2 button.on {background-position:-146px 100%;}
.heySomething .commentevet .form .choice li.ico3 button {background-position:-292px 0;}
.heySomething .commentevet .form .choice li.ico3 button.on {background-position:-292px 100%;}
.heySomething .commentevet .form .choice li.ico4 button {background-position:-438px 0;}
.heySomething .commentevet .form .choice li.ico4 button.on {background-position:-438px 100%;}
.heySomething .commentevet .form .choice li.ico5 button {background-position:-584px 0;}
.heySomething .commentevet .form .choice li.ico5 button.on {background-position:-584px 100%;}
.heySomething .commentevet .form .choice li.ico6 button {background-position:100% 0;}
.heySomething .commentevet .form .choice li.ico6 button.on {background-position:100% 100%;}
.heySomething .commentevet textarea {margin-top:23px;}

.heySomething .commentlist table td strong {width:113px; height:113px; margin-left:20px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/bg_ico_v1.png); background-position:0 -18px;}
.heySomething .commentlist table td strong.ico2 {background-position:-146px -18px;}
.heySomething .commentlist table td strong.ico3 {background-position:-292px -18px;}
.heySomething .commentlist table td strong.ico4 {background-position:-438px -18px;}
.heySomething .commentlist table td strong.ico5 {background-position:-584px -18px;}
.heySomething .commentlist table td strong.ico6 {background-position:100% -18px;}
</style>
<script type='text/javascript'>
<% if Request("iCC") <> "" or request("ecc") <> "" then %>
	$(function(){
		var val = $('#commentlist').offset();
	    $('html,body').animate({scrollTop:val.top},0);
	});
<% end if %>

function jsGoComPage(iP){
	document.frmcom.iCC.value = iP;
	document.frmcom.iCTot.value = "<%=iCTotCnt%>";
	document.frmcom.submit();
}

function jsSubmitComment(frm){
	<% If IsUserLoginOK() Then %>
		<% if commentcount>0 then %>
			alert("이벤트는 한번만 참여 가능 합니다.");
			return false;
		<% else %>
			if (frm.gubunval.value == ''){
				alert('원하는 항목을 선택해 주세요.');
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
		<%'' title, nav %>
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
			<div class="bnr"><a href="/shopping/category_prd.asp?itemid=1449822&amp;pEtr=69641">Straw Hat Brim</a></div>
		</div>

		<%' about %>
		<div class="about">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
			<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
		</div>

		<%'' brand : about CLASKA %>
		<div class="brand brandClaska">
			<a href="/street/street_brand_sub06.asp?makerid=CLASKA">
				<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/tit_brand_claska.png" alt="CLASKA" /></h3>
				<div class="inner">
					<div class="photo"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/img_hotel_claska.jpg" alt="" /></div>
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/txt_brand_claska.png" alt="CLASKA는 일본의 유명 부띠끄 호텔입니다. 메구로 거리의 오래된 호텔을 리모델링하여  다이닝&amp;카페&amp;갤러리샵 등을 갖춘 복합 시설로 재탄생시키면서 핫한 명소로 이름을 알리게 되었습니다." /></p>
				</div>
			</a>
		</div>

		<%''  brand : about CLASKA Gallery & Shop Do %>
		<div class="brand brandDo">
			<a href="/street/street_brand_sub06.asp?makerid=CLASKA">
				<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/tit_claska_do.png" alt="CLASKA Gallery &amp; Shop Do" /></h3>
				<div class="intro">
					<div class="light"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/img_claska_do_light.jpg" alt="" /></div>
					<div class="dark"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/img_claska_do_dark.jpg" alt="" /></div>
					<p>
						<span class="letter1">CLASKA 2층에 본점을 둔 CLASKA Gallery &amp; Shop DO는</span>
						<span class="letter2">전통적인 수공예품에서부터 신진 디자이너들의 제품까지</span>
						<span class="letter3">다양한 아이템을 갖춘 라이프스타일 샵입니다.</span>
						<span class="letter4">갤러리 공간을 마련해 수시로 전시도 진행하고 있습니다.</span>
					</p>
				</div>
			</a>
			<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="" /></div>
		</div>

		<%'' gallery %>
		<div id="gallery" class="gallery">
			<ul>
				<li class="item1">
					<a href="#claskaItem5">
						<span class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/img_item_01.jpg" alt="" /></span>
						<span class="mask"></span>
						<div class="word">
							<b><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/txt_item_01.png" alt="Mambo Tote Bag" /></b>
							<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/btn_detail.png" alt="" /></span>
						</div>
					</a>
				</li>
				<li class="item2">
					<a href="#claskaItem1">
						<span class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/img_item_02.jpg" alt="Canvas Tote Bag G&amp;S DO" /></span>
						<span class="mask"></span>
						<div class="word">
							<b><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/txt_item_02.png" alt="" /></b>
							<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/btn_detail.png" alt="" /></span>
						</div>
					</a>
				</li>
				<li class="item3">
					<a href="#claskaItem1">
						<span class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/img_item_03.jpg" alt="" /></span>
						<span class="mask"></span>
						<div class="word">
							<b><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/txt_item_03.png" alt="Canvas Tote Bag G&amp;S DO" /></b>
							<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/btn_detail.png" alt="" /></span>
						</div>
					</a>
				</li>
				<li class="item4">
					<a href="#claskaItem3">
						<span class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/img_item_04.jpg" alt="" /></span>
						<span class="mask"></span>
						<div class="word">
							<b><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/txt_item_04.png" alt="Canvas Zippered Pouch G&amp;S DO" /></b>
							<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/btn_detail.png" alt="" /></span>
						</div>
					</a>
				</li>
				<li class="item5">
					<a href="#claskaItem3">
						<span class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/img_item_05.jpg" alt="" /></span>
						<span class="mask"></span>
						<div class="word">
							<b><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/txt_item_05.png" alt="Canvas Zippered Pouch G&amp;S DO" /></b>
							<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/btn_detail.png" alt="" /></span>
						</div>
					</a>
				</li>
				<li class="item6">
					<a href="#claskaItem2">
						<span class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/img_item_06.jpg" alt="" /></span>
						<span class="mask"></span>
						<div class="word">
							<b><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/txt_item_06.png" alt="Straw Hat Brim" /></b>
							<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/btn_detail.png" alt="" /></span>
						</div>
					</a>
				</li>
				<li class="item7">
					<a href="#claskaItem2">
						<span class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/img_item_07.jpg" alt="" /></span>
						<span class="mask"></span>
						<div class="word">
							<b><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/txt_item_07.png" alt="Straw Hat Hanon" /></b>
							<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/btn_detail.png" alt="" /></span>
						</div>
					</a>
				</li>
				<li class="item8">
					<a href="#claskaItem6">
						<span class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/img_item_08.jpg" alt="" /></span>
						<span class="mask"></span>
						<div class="word">
							<b><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/txt_item_08.png" alt="MAMBO Zippered Pouch" /></b>
							<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/btn_detail.png" alt="" /></span>
						</div>
					</a>
				</li>
			</ul>
			<div class="bg"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/img_item_gallery_white.png" alt="" /></div>
		</div>

		<div id="claskaItem1" class="claskaItem claskaItem1">
			<h4><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/tit_item_canvas_tote_bag.png" alt="Canvas Tote Bag G&amp;S DO" /></h4>
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/txt_item_canvas_tote_bag.png" alt="CLASKA Gallery &amp; Shop DO의 시그니처 캔버스백입니다. 일본 오카야마 현의 전통이 깊은 직물 공장에서 제조한 면으로 만들었습니다. 짧은 여행에도 좋을 넉넉한 사이즈와 실용적인 내부포켓. 많이 넣을 땐 예쁘게 모양을 잡아 어깨에 메기 좋은 넓은 어깨끈, 적게 넣을 땐 가볍고 댄디하게 들 수 있는 손잡이, 입구를 한 번 막아주는 가운데 버튼까지. 군더더기가 하나도 없는 놀랍도록 심플한 캔버스백을 소개합니다." /></p>
			<div class="btnGroup">
				<a href="/shopping/category_prd.asp?itemid=1449827&amp;pEtr=69641"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/btn_shop.png" alt="Canvas Tote Bag G&amp;S DO 구매하러 가기" /></a>
			</div>
		</div>


		<div id="claskaItem2" class="claskaItem typeLeft claskaItem2">
			<div id="slide01" class="slide">
				<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/img_item_straw_hat_hanon_v1.jpg" alt="Straw Hat Hanon" /></div>
				<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/img_item_straw_hat_brim_v1.jpg" alt="Straw Hat Brim" /></div>
			</div>
			<h4><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/tit_item_straw_hat.png" alt="" /></h4>
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/txt_item_straw_hat.png" alt="일본 사이타마 현은 옛부터 밀짚모자 제조가 왕성했던 지역입니다. 최근에는 대량생산된 값싼 밀짚모자가 많아져 모두 사라지고 현재는 불과 4,5채의 공방만이 남아 있습니다. 그 중 에서도 가장 오래 된 공방에 부탁해 CLASKA Gallery &amp; Shop DO만의 밀짚모자를 만들었습니다. 동양인의 두상을 고려해 틀을 짜고 진짜 밀짚 Straw으로 정성스럽게 엮어 만들고 있습니다. 가드닝, 피크닉, 여행 등에 모두 활용할 수 있습니다." /></p>
			<div class="btnGroup">
				<a href="/shopping/category_prd.asp?itemid=1449822&amp;pEtr=69641"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/btn_shop_brim.png" alt="Straw Brim Hanon 구매하러 가기" /></a>
				<a href="/shopping/category_prd.asp?itemid=1449823&amp;pEtr=69641"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/btn_shop_hanon.png" alt="Straw Hat Hanon 구매하러 가기" /></a>
			</div>
		</div>

		<div id="claskaItem3" class="claskaItem claskaItem3">
			<h4><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/tit_item_canvasz_ippered_pouch.png" alt="Canvas Zippered Pouch G&amp;S DO" /></h4>
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/txt_item_canvasz_ippered_pouch.png" alt="CLASKA Gallery &amp; Shop DO의 오리지널 박스 파우치입니다. 평소에는 가방 안에 굴러다니는 소품들을 정리하고, 여행 때는 많은 소지품을 한 번에 담아 구분하기에 좋습니다. 코튼 캔버스의 유쾌한 감촉이 매력적인 박스 파우치. S, L 2가지 사이즈로 용도에 따라 선택할 수 있습니다." /></p>
			<div class="btnGroup">
				<a href="/shopping/category_prd.asp?itemid=1449825&amp;pEtr=69641"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/btn_shop_small.png" alt="Canvas Zippered Pouch G&amp;S DO 스몰 구매하러 가기" /></a>
				<a href="/shopping/category_prd.asp?itemid=1449826&amp;pEtr=69641"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/btn_shop_large.png" alt="Canvas Zippered Pouch G&amp;S DO 라지 구매하러 가기" /></a>
			</div>
		</div>

		<div id="claskaItem4" class="claskaItem typeLeft claskaItem4">
			<div id="slide02" class="slide">
				<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/img_item_sway_tokyo_tote_bag_small.jpg" alt="SWAY TOKYO tote Bag samll" /></div>
				<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/img_item_sway_tokyo_tote_bag_large.jpg" alt="SWAY TOKYO tote Bag large" /></div>
			</div>
			<h4><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/tit_item_sway_tokyo_tote_bag.png" alt="SWAY TOKYO tote Bag" /></h4>
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/txt_item_sway_tokyo_tote_bag.png" alt="SWAY는 일러스트레이터 시오카와 이즈미가 프렌치 불독을 모티브로 작업한 일러스트입니다. 화가 났나 싶다가도 축 늘어진 뺨이 귀여운 그림을 심플하게 담아내 많은 인기를 끌고 있는 제품입니다. 산책 및 외출에 가볍게 함께 해 주세요. 2가지 사이즈라 엄마와 아이가 예쁘게 커플로 매치할 수 있습니다." /></p>
			<div class="btnGroup">
				<a href="/shopping/category_prd.asp?itemid=1449831&amp;pEtr=69641"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/btn_shop_small.png" alt="Straw Brim Hanon 구매하러 가기" /></a>
				<a href="/shopping/category_prd.asp?itemid=1449830&amp;pEtr=69641"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/btn_shop_large.png" alt="Straw Hat Hanon 구매하러 가기" /></a>
			</div>
		</div>

		<div id="claskaItem5" class="claskaItem claskaItem5">
			<h4><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/tit_item_mambo_tote_bag.png" alt="MAMBO Tote Bag" /></h4>
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/txt_item_mambo_tote_bag.png" alt="SWAY의 뒤를 이어 비숑 프리제를 모티브로 한 시오카와 이즈미의 MAMBO 단순히 선과 점으로만 그려진 무심한 일러스트임에도 무언가 말을 걸어올 것만 같은 눈과 입이 사랑스럽습니다. 보드라운 원단이 너무나 매력적인 이 MAMBO 가방은 2가지 사이즈로 준비되어 있어 쇼핑이나 여행에도, 가벼운 피크닉에도 모두 안성맞춤입니다." /></p>
			<div class="btnGroup">
				<a href="/shopping/category_prd.asp?itemid=1449829&amp;pEtr=69641"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/btn_shop_small.png" alt="MAMBO Tote Bag 스몰 구매하러 가기" /></a>
				<a href="/shopping/category_prd.asp?itemid=1449828&amp;pEtr=69641"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/btn_shop_large.png" alt="MAMBO Tote Bag 라지 구매하러 가기" /></a>
			</div>
		</div>

		<div id="claskaItem6" class="claskaItem typeLeft claskaItem6">
			<h4><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/tit_item_mambo_zippered_pouch.png" alt="MAMBO Zippered Pouch" /></h4>
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/txt_item_mambo_zippered_pouch.png" alt="하얀 MAMBO 가방에 컬러풀한 MAMBO도 쏙! 심플한 일러스트만으로 디자인하면서도 포인트를 주기에 너무나 좋은 3가지 컬러로 만들었습니다. 가벼운 선물임에도 웃음을 함께 선물할 수 있어요. 스테이셔너리, 작은 화장품 등 다양한 용도로 사용하세요." /></p>
			<div class="btnGroup">
				<a href="/shopping/category_prd.asp?itemid=1449824&amp;pEtr=69641"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/btn_shop.png" alt="MAMBO Zippered Pouch 구매하러 가기" /></a>
			</div>
		</div>

		<%''  movie %>
		<div class="video">
			<iframe src="//player.vimeo.com/video/160848183" width="1140" height="642" frameborder="0" title="Claska" webkitallowfullscreen="" mozallowfullscreen="" allowfullscreen=""></iframe>
		</div>

		<%''  comment %>
		<div class="commentevet">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69641/tit_comment.png" alt="Hey, something project 당신이 갖고 싶은 것" /></h3>
			<p class="hidden">여행에도 일상에도 꼭 지니고 싶은 CLASKA! CLASKA의 특별한 제품들 중 가장 가지고 싶은 것은 무엇인가요? 코멘트를 남겨주신 3분을 추첨하여 해당 제품을 드립니다. 디자인, 사이즈, 컬러는 랜덤으로 발송됩니다. 코멘트 작성기간은 2016년 3월 30일부터 4월 5일까지며, 발표는 4월 7일 입니다.</p>
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
				<input type="hidden" name="txtcomm">
				<input type="hidden" name="gubunval">
				<% If InStr(Request.ServerVariables("QUERY_STRING"), "&ecc=1") > 0 Then %>
				<% Else %>
					<input type="hidden" name="hookcode" value="&ecc=1">
				<% End If %>
					<fieldset>
					<legend>CLASKA 코멘트 쓰기</legend>
						<ul class="choice">
							<li class="ico1"><button type="button" value="1">Canvas Tote Bag</button></li>
							<li class="ico2"><button type="button" value="2">Straw Hat</button></li>
							<li class="ico3"><button type="button" value="3">Canvas Zippered Pouch</button></li>
							<li class="ico4"><button type="button" value="4">Sway Tokyo tote Bag</button></li>
							<li class="ico5"><button type="button" value="5">Mambo Tote Bag</button></li>
							<li class="ico6"><button type="button" value="6">Mambo Zippered Pouch</button></li>
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
					<% If InStr(Request.ServerVariables("QUERY_STRING"), "&ecc=1") > 0 Then %>
					<% Else %>
						<input type="hidden" name="hookcode" value="&ecc=1">
					<% End If %>
				</form>
			</div>

			<%''  commentlist %>
			<div class="commentlist" id="commentlist">
				<p class="total">total <%= iCTotCnt %></p>
				<% IF isArray(arrCList) THEN %>
					<table>
						<caption>CLASKA 코멘트 목록</caption>
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
													Canvas Tote Bag
												<% elseif split(arrCList(1,intCLoop),"!@#")(0)="2" then %>
													Straw Hat
												<% elseif split(arrCList(1,intCLoop),"!@#")(0)="3" then %>
													Canvas Zippered Pouch
												<% elseif split(arrCList(1,intCLoop),"!@#")(0)="4" then %>
													Sway Tokyo tote Bag
												<% elseif split(arrCList(1,intCLoop),"!@#")(0)="5" then %>
													Mambo Tote Bag
												<% elseif split(arrCList(1,intCLoop),"!@#")(0)="6" then %>
													Mambo Zippered Pouch
												<% Else %>
													Canvas Tote Bag
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

					<%''  paging %>
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
	$("#gallery ul li a").click(function(event){
		event.preventDefault();
		window.parent.$('html,body').animate({scrollTop:$(this.hash).offset().top},1200);
	});

	/* slide js */
	$("#slide01").slidesjs({
		width:"1904",
		height:"640",
		pagination:{effect:"fade"},
		navigation:false,
		play:{interval:3000, effect:"fade", auto:true},
		effect:{fade: {speed:1500}},
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
		width:"1904",
		height:"640",
		pagination:{effect:"fade"},
		navigation:false,
		play:{interval:2500, effect:"fade", auto:true},
		effect:{fade: {speed:1500}},
		callback: {
			complete: function(number) {
				var pluginInstance = $('#slide01').data('plugin_slidesjs');
				setTimeout(function() {
					pluginInstance.play(true);
				}, pluginInstance.options.play.interval);
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

	/* animation effect */
	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 2200 ) {
			brandAnimation()
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

	/* brand animation */
	$(".heySomething .brandDo .intro .dark").css({"opacity":"0"});
	$(".heySomething .brandDo .intro p span").css({"margin-top":"2px", "opacity":"0"});
	function brandAnimation() {
		$(".heySomething .brandDo .intro .dark").delay(10).animate({"opacity":"1"},600);
		$(".heySomething .brandDo .intro p .letter1").delay(700).animate({"margin-top":"0", "opacity":"1"},800);
		$(".heySomething .brandDo .intro p .letter2").delay(1000).animate({"margin-top":"0", "opacity":"1"},800);
		$(".heySomething .brandDo .intro p .letter3").delay(1300).animate({"margin-top":"0", "opacity":"1"},800);
		$(".heySomething .brandDo .intro p .letter4").delay(1600).animate({"margin-top":"0", "opacity":"1"},800);
	}
});
</script>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->