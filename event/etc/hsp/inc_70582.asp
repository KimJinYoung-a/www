<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈 31 WWW
' History : 2016-05-10 유태욱 생성
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
'																			currenttime = #03/02/2016 09:00:00#

dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  66122
Else
	eCode   =  70582
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

dim itemid
IF application("Svr_Info") = "Dev" THEN
	itemid   =  1239115
Else
	itemid   =  1479124
End If

set oItem = new CatePrdCls
	oItem.GetItemData itemid

Dim hspchk
'// 현재 주소값 체크하여 신규, 구버전 확인
hspchk = Split(LCase(Request.ServerVariables("PATH_INFO")),"/")
%>
<style type="text/css">
/* title */
.heySomething .topic {background-color:#fbd7b3;}
.heySomething .topic h2 {z-index:5;}
.heySomething .topic .bnr a {display:block; position:relative; width:100%; height:780px;}
.heySomething .topic .bnr img {position:absolute; top:0; left:50%; margin-left:-951px;}

/* item */
.heySomething .itemB {padding-bottom:313px;}
.heySomething .itemB h3 {position:relative; height:54px; text-align:center;}
.heySomething .itemB h3 .horizontalLine1, .heySomething .item h3 .horizontalLine2 {position:absolute; top:25px; width:432px; height:1px; background-color:#d9d9d9;}
.heySomething .itemB h3 .horizontalLine1 {left:0;}
.heySomething .itemB h3 .horizontalLine2 {right:0;}
.heySomething .itemB .desc {padding-left:415px;}
.heySomething .itemB .desc .option {z-index:50;}
.heySomething .itemB .slidewrap .slide {width:725px; height:575px;}
.heySomething .itemB .slidesjs-pagination {bottom:-259px;}
.heySomething .itemB .slidesjs-pagination li a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/70582/img_pagination.jpg);}

@keyframes flip {
	0% {transform:translateZ(0) rotateY(0) scale(1); animation-timing-function:ease-out;}
	40% {transform:translateZ(150px) rotateY(170deg) scale(1); animation-timing-function:ease-out;}
	50% {transform:translateZ(150px) rotateY(190deg) scale(1); animation-timing-function:ease-in;}
	80% {transform:translateZ(0) rotateY(360deg) scale(.95); animation-timing-function:ease-in;}
	100% {transform:translateZ(0) rotateY(360deg) scale(1); animation-timing-function:ease-in;}
}
.flip {animation-name:flip; animation-duration:2s; animation-iteration-count:1; backface-visibility:visible;}

/* visual */
.heySomething .visual {padding-bottom:0;}
.heySomething .visual .figure {position:relative; height:805px; background-color:#d4de93;}
.heySomething .visual .figure img {position:absolute; top:0; left:50%; margin-left:-951px;}

/* brand */
.heySomething .brand {position:relative; height:445px; padding-top:595px;}
.heySomething .brand .logo {overflow:hidden; position:absolute; top:0; left:50%; height:54px; margin-left:-99px;}
.heySomething .brand .photo {overflow:hidden;position:absolute; top:135px; left:50%; width:400px; height:385px; margin-left:-200px; background-color:#c1dca4; text-align:center;}
@keyframes pulse {
	0% {transform:scale(1.2);}
	100% {transform:scale(1);}
}
.pulse {animation-name:pulse; animation-duration:1.2s; animation-iteration-count:1;}

.heySomething .brand p {margin-top:0;}

/* story */
.heySomething .story {padding-bottom:505px;}
.heySomething .story h3 {margin-bottom:0;}
.heySomething .story .rolling {width:100%; height:767px; margin-top:65px; padding-top:135px;}
.heySomething .slidesjs-slide {width:100%; height:767px;}
.heySomething .story .slidesjs-slide-01 {background-color:#fdf9f4;}
.heySomething .story .slidesjs-slide-02 {background-color:#eae6e4;}
.heySomething .story .slidesjs-slide-03 {background-color:#f4f0ed;}
.heySomething .story .slidesjs-slide-04 {background-color:#f0e8e2;}
.heySomething .slidesjs-slide a {display:block; position:relative; width:100%; height:100%;}
.heySomething .slidesjs-slide .desc {position:absolute; z-index:10; left:50%;}
.heySomething .slidesjs-slide .visual {position:absolute; top:0; left:50%; margin-top:0; margin-left:-951px;}
.heySomething .slidesjs-slide-01 .desc {top:187px; margin-left:226px;}
.heySomething .slidesjs-slide-02 .desc {top:176px; margin-left:300px;}
.heySomething .slidesjs-slide-03 .desc {top:253px; margin-left:-239px;}
.heySomething .slidesjs-slide-04 .desc {top:132px; margin-left:-106px;}

.heySomething .rolling .slidesjs-pagination {position:absolute; left:50%; top:0; width:700px; margin-left:-350px;}
.heySomething .rolling .slidesjs-pagination li {float:left; width:105px; height:105px; margin:0 35px;}
.heySomething .rolling .slidesjs-pagination li a {display:block; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/70582/img_ico.png) no-repeat 0 0; text-indent:-999em;}
.heySomething .rolling .slidesjs-pagination li a:hover,
.heySomething .rolling .slidesjs-pagination li a.active {background-position:0 -105px;}
.heySomething .rolling .slidesjs-pagination .num02 a {background-position:-174px 0;}
.heySomething .rolling .slidesjs-pagination .num02 a:hover,
.heySomething .rolling .slidesjs-pagination .num02 .active {background-position:-174px -105px;}
.heySomething .rolling .slidesjs-pagination .num03 a {background-position:-349px 0;}
.heySomething .rolling .slidesjs-pagination .num03 a:hover,
.heySomething .rolling .slidesjs-pagination .num03 .active {background-position:-349px -105px;}
.heySomething .rolling .slidesjs-pagination .num04 a {background-position:-523px 0;}
.heySomething .rolling .slidesjs-pagination .num04 a:hover,
.heySomething .rolling .slidesjs-pagination .num04 .active {background-position:-523px -105px;}

.heySomething .rolling .slidesjs-navigation {position:absolute; top:50%; left:50%; z-index:50; width:33px; height:64px; margin-top:-32px; background:transparent url(http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_nav.png) no-repeat 0 0; text-indent:-999em}
.heySomething .rolling .slidesjs-previous {margin-left:-552px;}
.heySomething .rolling .slidesjs-next {margin-left:527px; background-position:100% 0;}

/* detail */
.heySomething .detail {position:relative; height:694px; background-color:#f5f4f0;}
.heySomething .detail h3 {position:absolute; top:122px; left:50%; z-index:15; margin-left:-421px;}
.heySomething .detail .rolling {height:694px; padding-top:0;}
.heySomething .detail .slidesjs-slide {height:694px;}
.heySomething .detail .slidesjs-slide-01 .desc {top:205px; margin-left:217px;}
.heySomething .detail .slidesjs-slide-02 .desc {top:122px; margin-left:130px;}

/* comment */
.heySomething .commentevet {margin-top:500px;}
.heySomething .commentevet .form {margin-top:0;}
.heySomething .commentevet .form .choice li {width:93px; margin-right:26px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/70582/img_ico.png); background-position:0 -210px;}
.heySomething .commentevet .form .choice li.ico1 button.on {background-position:0 100%;}
.heySomething .commentevet .form .choice li.ico2 button {background-position:-119px -210px;}
.heySomething .commentevet .form .choice li.ico2 button.on {background-position:-119px 100%;}
.heySomething .commentevet .form .choice li.ico3 button {background-position:-236px -210px;}
.heySomething .commentevet .form .choice li.ico3 button.on {background-position:-236px 100%;}
.heySomething .commentevet .form .choice li.ico4 button {background-position:-355px -210px;}
.heySomething .commentevet .form .choice li.ico4 button.on {background-position:-355px 100%;}

.heySomething .commentevet textarea {margin-top:0;}

.heySomething .commentlist table td strong {width:93px; height:93px; margin:0 0 0 27px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/70582/img_ico.png); background-position:0 -239px;}
.heySomething .commentlist table td strong.ico2 {background-position:-119px -239px;}
.heySomething .commentlist table td strong.ico3 {background-position:-236px -239px;}
.heySomething .commentlist table td strong.ico4 {background-position:-355px -239px;}
</style>
<script type="text/javascript">
$(function(){
	/* slide js */
	$("#slide01").slidesjs({
		width:"724",
		height:"500",
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
		height:"694",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:3000, effect:"fade", auto:true},
		effect:{fade: {speed:800}},
		callback: {
			start: function() {
				$(".heySomething #slide02 .slidesjs-slide .desc").css({"margin-top":"5px", "opacity":"0"});
			},
			complete: function() {
				$(".heySomething #slide02 .slidesjs-slide .desc").delay(10).animate({"margin-top":"0", "opacity":"1"},300);
			}
		}
	});

	$("#slide03").slidesjs({
		width:"1903",
		height:"694",
		pagination:false,
		navigation:{effect:"fade"},
		play:{interval:2500, effect:"fade", auto:true},
		effect:{fade: {speed:1000}}
	});

	//mouse control
	$('#slide01 .slidesjs-pagination > li a, #slide02 .slidesjs-pagination > li a').mouseenter(function(){
		$('a[data-slidesjs-item="' + $(this).attr("data-slidesjs-item") + '"]').trigger('click');
	});

	$("#slide01 .slidesjs-pagination li:nth-child(1), #slide02 .slidesjs-pagination li:nth-child(1)").addClass("num01");
	$("#slide01 .slidesjs-pagination li:nth-child(2), #slide02 .slidesjs-pagination li:nth-child(2)").addClass("num02");
	$("#slide01 .slidesjs-pagination li:nth-child(3), #slide02 .slidesjs-pagination li:nth-child(3)").addClass("num03");
	$("#slide01 .slidesjs-pagination li:nth-child(4), #slide02 .slidesjs-pagination li:nth-child(4)").addClass("num04");

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
		if (scrollTop > 900 ) {
			$(".heySomething .item h3 .logo img").addClass("flip");
		}
		if (scrollTop > 3700 ) {
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
	$(".heySomething .brand .logo img").css({"margin-top":"-10px", "opacity":"0"});
	$(".heySomething .brand .photo").css({"margin-top":"10px", "opacity":"0"});
	$(".heySomething .brand .photo img").css({"opacity":"0"});
	$(".heySomething .brand p").css({"height":"50px", "opacity":"0"});
	$(".heySomething .brand .btnDown").css({"opacity":"0"});
	function brandAnimation() {
		$(".heySomething .brand .logo img").delay(10).animate({"margin-top":"0", "opacity":"1"},500);
		$(".heySomething .brand .photo").delay(10).animate({"margin-top":"0", "opacity":"1"},500);
		$(".heySomething .brand .photo img").delay(300).animate({"opacity":"1"},500);
		$(".heySomething .brand p").delay(300).animate({"height":"294px", "opacity":"1"},1200);
		$(".heySomething .brand .btnDown").delay(1000).animate({"opacity":"1"},1200);
	}
});

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
				alert("코멘트를 남겨주세요.\n한글 400자 까지 작성 가능합니다.");
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
			<div class="bnr">
				<a href="/shopping/category_prd.asp?itemid=1479124&amp;pEtr=70582"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70582/img_item_represent.jpg" alt="EMIE 블루투스 스피커" /></a>
			</div>
		</div>

		<%'' about %>
		<div class="about">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
			<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
		</div>

		<%'' item %>
		<div class="item itemB">
			<div class="inner">
				<h3>
					<span class="logo"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70582/img_logo_emie.png" alt="EMIE" /></span>
					<span class="horizontalLine1"></span>
					<span class="horizontalLine2"></span>
				</h3>
				<div class="desc">
					<%'' 상품 이름, 가격, 구매하기 %>
					<div class="option">
						<em class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70582/txt_name.png" alt="EMIE Bluetooth speaker" /></em>
						<%''for dev msg : 상품코드 1479124 할인기간 5/11~5/17 할인기간이 지나면 <strong class="discount">...</strong> 숨겨주세요 %>
						<% if oItem.FResultCount > 0 then %>
							<% if oItem.Prd.isCouponItem then %>
								<div class="price">
									<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/txt_only_05percent.png" alt="단, 일주일만 ONLY 5%" /></strong>
									<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
									<strong><%= FormatNumber(oItem.Prd.GetCouponAssignPrice,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								</div>
							<% else %>
								<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
									<%	'' for dev msg : 할인 %>
									<div class="price">
										<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/txt_only_05percent.png" alt="단, 일주일만 ONLY 5%" /></strong>
										<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
										<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
									</div>
								<% else %>
									<%'' for dev msg : 종료 후  %>
									<div class="price priceEnd">
										<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
									</div>
								<% end if %>
							<% end if %>
						<% end if %>
						<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70582/txt_substance.png" alt="단정한 당신의 공간을 채워 줄 첫 블루투스 스피커. 본 상품은 예약판매 상품으로, 5.18일 순차배송됩니다." /></p>
						<div class="btnget"><a href="/shopping/category_prd.asp?itemid=1479124&amp;pEtr=70582"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="EMIE Bluetooth speaker 구매하러 가기" /></a></div>
					</div>

					<%	'' slide  %>
					<div class="slidewrap">
						<div id="slide01" class="slide">
							<div><a href="/shopping/category_prd.asp?itemid=1479124&amp;pEtr=70582"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70582/img_figure_01.jpg" alt="EMIE 블루투스 스피커 정면" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1479124&amp;pEtr=70582"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70582/img_figure_02.jpg" alt="EMIE 블루투스 스피커 좌측" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1479124&amp;pEtr=70582"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70582/img_figure_03.jpg" alt="EMIE 블루투스 스피커 측면" /></a></div>
							<div><a href="/shopping/category_prd.asp?itemid=1479124&amp;pEtr=70582"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70582/img_figure_04.jpg" alt="EMIE 블루투스 스피커 뒷면" /></a></div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<%'' visual  %>
		<div class="visual">
			<div class="figure"><a href="/shopping/category_prd.asp?itemid=1479124&amp;pEtr=70582"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70582/img_item_visual_big.jpg" alt="책상 위의 EMIE 블루투스 스피커" /></a></div>
		</div>

		<%'' brand  %>
		<div class="brand">
			<span class="logo"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70582/img_logo_emie.png" alt="EMIE" /></span>
			<div class="photo"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70582/img_brand.jpg" alt="" /></div>
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70582/txt_brand.png" alt="크레이티브 디자인 그룹의 첫 블루투스 스피커 EMIE는 2011년 10월 중국 Shenzhen에서 설립된 기업으로 중국내 타 업체와 다르게 뛰어난 디자인과 성능에 초점을 맞춘 젊고 크리에이티브한 디자인 그룹입니다. 지난 2012년 스마트폰 보조배터리를 시작으로 하여 블루투스 스피커, 스마트 워치 등의 스마트 액세서리를 만들어왔으며, 2013년 ~ 2015년 레드닷 어워드 디자인 부분에서 수상하는 등 젊고 아름다운 제품으로 전세계 소비자들에게 꾸준히 사랑을 받고 있습니다." /></p>
			<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="" /></div>
		</div>

		<%''  story  %>
		<div class="story">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70582/tit_story.png" alt="스피커 들여다 보기" /></h3>
			<div id="slide02" class="rolling">
				<div class="slidesjs-slide-01">
					<a href="/shopping/category_prd.asp?itemid=1479124&amp;pEtr=70582">
						<p class="desc"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70582/txt_desc_01.png" alt="동행합니다 당신의 시간을 잔잔한 음악을 듣고 싶을 때" /></p>
						<div class="visual"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70582/img_slide_01_01.jpg" alt="" /></div>
					</a>
				</div>
				<div class="slidesjs-slide-02">
					<a href="/shopping/category_prd.asp?itemid=1479124&amp;pEtr=70582">
						<p class="desc"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70582/txt_desc_02.png" alt="부담스럽지 않은 크기 집안 어디에 놓아도 손바닥 크기" /></p>
						<div class="visual"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70582/img_slide_01_02.jpg" alt="" /></div>
					</a>
				</div>
				<div class="slidesjs-slide-03">
					<a href="/shopping/category_prd.asp?itemid=1479124&amp;pEtr=70582">
						<p class="desc"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70582/txt_desc_03.png" alt="노브를 천천히 돌려주세요 버튼을 누르거나 어렵지 않아요" /></p>
						<div class="visual"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70582/img_slide_01_03.jpg" alt="" /></div>
					</a>
				</div>
				<div class="slidesjs-slide-04">
					<a href="/shopping/category_prd.asp?itemid=1479124&amp;pEtr=70582">
						<p class="desc"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70582/txt_desc_04.png" alt="자동으로 종료 됩니다 비 작동 상태가 되면 " /></p>
						<div class="visual"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70582/img_slide_01_04.jpg" alt="" /></div>
					</a>
				</div>
			</div>
		</div>

		<%''  detail  %>
		<div class="detail">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70582/tit_detail.png" alt="스피커 자세히 보기" /></h3>
			<div id="slide03" class="rolling">
				<div class="slidesjs-slide-01">
					<a href="/shopping/category_prd.asp?itemid=1479124&amp;pEtr=70582">
						<p class="desc"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70582/txt_detail_01.png" alt="꺼짐 2초 동안 버튼을 누르세요. 볼륨 증가/감소 시계/시계 반대 방향으로 회전, 일시정지 블루투스 연결 상태에서 노브를 누르세요. 페어링 모드 두번 빠르게 누르면 푸른 빛이 납니다. 배터리 부족 시 배터리 경보 빛이 1분 켜집니다. 충전 팁 충전 중 레드라이트가 꺼지면 충전이 완료된 것 입니다" /></p>
						<div class="visual"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70582/img_slide_02_01.jpg" alt="" /></div>
					</a>
				</div>
				<div class="slidesjs-slide-02">
					<a href="/shopping/category_prd.asp?itemid=1479124&amp;pEtr=70582">
						<p class="desc"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70582/txt_detail_02.png" alt="제조사명 EMIE, 모델명 MR04, 블루투스 CSR 블루투스 3.0, 스피커 1.5인치 2W 스테레오 서라운드, 주파수대역 20Hz ~ 20kHz, 배터리 520MAH 리튬이온 충전지, 사용시간 최대 6시간, 사이즈 가로 115mm 세로 68mm 대각선 30mm" /></p>
						<div class="visual"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70582/img_slide_02_02.jpg" alt="" /></div>
					</a>
				</div>
			</div>
		</div>

		<%''  comment %>
		<div class="commentevet">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/70582/tit_comment.png" alt="Hey, something project 당신이 갖고 싶은 것" /></h3>
			<p class="hidden">EMIE 블루투스 스피커의 텐바이텐 런칭을 축하해주세요 정성스러운 코멘트를 남겨주신 5분을 선정하여 EMIE 블루투스 스피커를 선물로 드립니다. 코멘트 작성기간은 2016년 5월 11일부터 5월 17일까지며, 발표는 5월 8일 입니다.</p>

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
					<legend>EMIE 블루투스 스피커 코멘트 쓰기</legend>
						<ul class="choice">
							<li class="ico1"><button type="button" value="1">잔잔하게</button></li>
							<li class="ico2"><button type="button" value="2">아담하게</button></li>
							<li class="ico3"><button type="button" value="3">간단하게</button></li>
							<li class="ico4"><button type="button" value="4">스마트하게</button></li>
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
						<caption>EMIE 블루투스 스피커 코멘트 목록 - 코멘트 작성시 선택 항목, 내용, 작성일자, 아이디 정보를 제공하는 표</caption>
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
													잔잔하게
												<% elseif split(arrCList(1,intCLoop),"!@#")(0)="2" then %>
													아담하게
												<% elseif split(arrCList(1,intCLoop),"!@#")(0)="3" then %>
													간단하게
												<% elseif split(arrCList(1,intCLoop),"!@#")(0)="4" then %>
													스마트하게
												<% Else %>
													잔잔하게
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
							<% next %>
						</tbody>
					</table>
	
					<%''  paging %>
					<div class="pageWrapV15">
						<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
					</div>
				<% end if %>
			</div>
		</div>
		<%''  // 수작업 영역 끝 %>
<% If Not(Trim(hspchk(1)))="hsproject" Then %>
	</div>
<% End If %>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->