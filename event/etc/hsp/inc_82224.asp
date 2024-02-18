<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'###########################################################
' Description : hey, something project 시리즈 96 
' TEN BY TEN X FROM AMOUR
' History : 2017-11-21 정태훈 생성
'###########################################################
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
'	currenttime = #11/10/2017 09:00:00#

dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  67463
Else
	eCode   =  82224
End If

dim userid, commentcount, i
	userid = GetEncLoginUserID()

if userid = "baboytw" or userid = "chaem35" or userid = "answjd248" or userid = "corpse2" then
	currenttime = #11/22/2017 09:00:00#
end if

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
.tMar20 {margin-top:20px;}
/* title */
.heySomething .topic {background-color:#bf8948;}

/* brand */
.heySomething .brand {position:relative; height:793px; margin:415px 0 320px; text-align:center;}
.heySomething .brand .btnDown {margin-top:53px;}

/* intro-slide */
.heySomething .wideSlide {background-color:#ffd895;}
.pink-slide {background-color:#fa9da6;}

/* item */
.heySomething .item {margin:410px auto 0;}
.heySomething .item .desc {width:1140px; min-height:423px; height:423px; margin:108px auto 0; padding:109px 0 0 0;}
.heySomething .item .inner {overflow:hidden; display:block; width:980px; margin:0 auto;}
.heySomething .item .figure {position:static; float:right;}
.heySomething .item .option {float:left; width:370px; height:425px;}
.heySomething .item .option .substance {bottom:57px;}
.heySomething .item .option .price {margin-top:36px;}
.heySomething .item .slide {position:absolute; top:0; overflow:visible !important; width:586px; height:446px;}
.heySomething .item .slide .slidesjs-navigation {position:absolute; top:0px; z-index:20; width:20px; height:446px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/82224/btn_nav.png) 0 0 no-repeat; text-indent:-999em;}
.heySomething .item .slide .slidesjs-previous {left:28px;}
.heySomething .item .slide .slidesjs-next {right:28px; background-position:100% 0;}
.heySomething .item .desc1 {margin-top:120px; padding-top:0; border-top:0;}
.heySomething .item .desc1 .slide {right:54px;}

.heySomething .item .desc2 {margin-top:138px; padding-top:139px;}
.heySomething .item .desc2:before {content:' '; display:inline-block; position:absolute; top:0; left:0; width:100%; height:1px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/82224/bg_line.png) repeat-x 0 0; }
.heySomething .item .desc2 .inner {margin-right:20px;}
.heySomething .item .desc2 .option {float:right; width:295px;}
.heySomething .item .desc2 .btnget {left:0;}
.heySomething .item .desc2 .figure {float:left;}
.heySomething .item .desc2 .slide {top:140px; left:80px;}

/* finish */
.heySomething .finish {height:630px; margin-top:427px; background:#e5e3e1 url(http://webimage.10x10.co.kr/eventIMG/2017/hey/82224/bg_finish.jpg) no-repeat 50% 0; text-align:center;}
.heySomething .finish p {position:absolute; top:166px; margin-left:-570px;}

/* story */
.heySomething .story {margin:350px 0 0;}
.heySomething .rollingwrap {margin-top:0;}
.heySomething .rolling {height:708px; padding-top:165px;}
.heySomething .rolling .swiper , .heySomething .rolling .swiper .swiper-container{height:708px;}
.heySomething .rolling .pagination {width:640px; margin-left:-320px;}
.heySomething .rolling .pagination span {margin:0 10px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/82224/bg_ico_1.png);}
.heySomething .rolling .pagination span em {bottom:-780px; left:-150px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/82224/txt_story_desc.png); cursor:default;}
.heySomething .rolling .btn-nav {top:490px;}
.heySomething .swipemask {top:165px; height:708px; }

/* comment */
.heySomething .commentevet {padding-top:52px; margin-top:260px}
.heySomething .commentevet textarea {margin-top:0;}
.heySomething .commentevet .form {margin-top:0;}
.heySomething .commentevet .form .choice {margin-left:-20px;}
.heySomething .commentevet .form .choice li {width:150px; height:150px; margin-right:-30px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/82224/bg_ico_2.png);}
.heySomething .commentlist table td strong {width:150px; height:150px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/82224/bg_ico_2.png); background-position:0 0}
.heySomething .commentlist table td .ico2 {background-position:-150px 0;}
.heySomething .commentlist table td .ico3 {background-position:-300px 0;}
.heySomething .commentlist table td .ico4 {background-position:-450px 0;}
</style>
<script type="text/javascript">
$(function(){
	// wide slide
	$('.wideSlide .swiper-wrapper').slidesjs({
		width:1920,
		height:800,
		pagination:{effect:'fade'},
		navigation:{effect:'fade'},
		play:{interval:3000, effect:'fade', auto:false},
		effect:{fade: {speed:1200, crossfade:true}
		},
		callback: {
			complete: function(number) {
				var pluginInstance = $('.wideSlide .swiper-wrapper').data('plugin_slidesjs');
				setTimeout(function() {
					pluginInstance.play(true);
				}, pluginInstance.options.play.interval);
			}
		}
	});

	$(".desc1 .slide").slidesjs({
		width:"586",
		height:"446",
		pagination:false,
		navigation:{effect:"fade"},
		play:{interval:2700, effect:"fade", auto:true},
		effect:{fade:{speed:800, crossfade:true}}
	});

	$(".desc2 .slide").slidesjs({
		width:"586",
		height:"446",
		pagination:false,
		navigation:{effect:"fade"},
		play:{interval:2700, effect:"fade", auto:true},
		effect:{fade:{speed:800, crossfade:true}}
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

});
</script>
<script type="text/javascript">
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
		<% If not( left(currenttime,10) >= "2017-11-22" and left(currenttime,10) < "2017-12-14" ) Then %>
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
					alert("코멘트를 남겨주세요.\n한글 400자 까지 작성 가능합니다.");
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
			top.location.href="/login/loginpage.asp?vType=G";
			return false;
//			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
//			winLogin.focus();
//			return false;
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
			top.location.href="/login/loginpage.asp?vType=G";
			return false;
//			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
//			winLogin.focus();
//			return false;
		}
		return false;
	}
}
</script>
			<% If Not(Trim(hspchk(1)))="hsproject" Then %>
			<div class="heySomething">
			<% end if %>
			<% If Not(Trim(hspchk(1)))="hsproject" Then %>
				<%' for dev mgs :  탭 navigator %>
				<div class="navigator">
					<ul>
						<!-- #include virtual="/event/etc/inc_66049_menu.asp" -->
					</ul>
					<span class="line"></span>
				</div>
			<% End If %>
				<div class="topic">
					<h2>
						<span class="letter1">Hey,</span>
						<span class="letter2">something</span>
						<span class="letter3">project</span>
					</h2>
					<div class="bnr"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82224/img_item_represent.jpg" alt="from Amour" /></div>
				</div>

				<!-- about -->
				<div class="about">
					<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
					<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
				</div>

				<!-- brand -->
				<div class="brand">
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82224/txt_brand.jpg" alt="사랑으로부터 라는 의미를 지닌 브랜드 FROM AMOUR" /></p>
					<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="아래로 이동" /></div>
				</div>

				<!-- intro-slide -->
				<div class="slideTemplateV15 wideSlide">
					<div class="swiper-container">
						<div class="swiper-wrapper">
							<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82224/img_slide_1.jpg" alt="" /></div>
							<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82224/img_slide_2.jpg" alt="" /></div>
							<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82224/img_slide_3.jpg" alt="" /></div>
							<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82224/img_slide_4.jpg" alt="" /></div>
							<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82224/img_slide_5.jpg" alt="" /></div>
						</div>
						<div class="pagination"></div>
						<button class="slideNav btnPrev">이전</button>
						<button class="slideNav btnNext">다음</button>
					</div>
				</div>
				<%
				IF application("Svr_Info") = "Dev" THEN
					itemid = 1239226
				Else
					itemid = 1836137
				End If
				set oItem = new CatePrdCls
					oItem.GetItemData itemid
				%>
				<!-- item -->
				<div class="item itemA">
					<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82224/tit_from_amour.png" alt="FROM AMOUR" /></h3>
					<div class="desc desc1">
						<a href="/shopping/category_prd.asp?itemid=1836137&pEtr=82224" class="inner">
							<div class="figure">
								<div class="slide slide1">
									<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82224/img_slide_item1_1.jpg" alt="" />
									<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82224/img_slide_item1_2.jpg" alt="" />
									<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82224/img_slide_item1_3.jpg" alt="" />
								</div>
							</div>
							<div class="option">
								<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82224/txt_item_1.gif" alt="프롬아무르 후리스" /></p>
							<% If oItem.FResultCount > 0 Then %>
								<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
								<div class="price">
									<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> <span>(<%= Format00(1, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%)</span></strong>
								</div>
								<% Else %>
								<div class="price priceEnd" >
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								</div>
								<% End If %>
							<% End If %>
								<div class="substance">
									<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82224/txt_desc_1_v2.gif" alt="코튼 소재보다 부드러운 촉감과 보온성을 지닌 후리스 집업. 실내, 실외에서도 편안하게 입을 수 있습니다." />
								</div>
								<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러가기" /></div>
							</div>
						</a>
					</div>
					<%
					set oItem = nothing
					%>
					<%
					IF application("Svr_Info") = "Dev" THEN
						itemid = 1239226
					Else
						itemid = 1836140
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
					%>
					<div class="desc desc2">
						<a href="/shopping/category_prd.asp?itemid=1836140&pEtr=81294" class="inner">
							<div class="figure">
								<div class="slide slide2">
									<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82224/img_slide_item2_1.jpg" alt="" />
									<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82224/img_slide_item2_2.jpg" alt="" />
									<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82224/img_slide_item2_3.jpg" alt="" />
								</div>
							</div>
							<div class="option">
								<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82224/txt_item_2.gif" alt="프롬아무르 후리스 체크" /></p>
							<% If oItem.FResultCount > 0 Then %>
								<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
								<div class="price">
									<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> <span>(<%= Format00(1, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%)</span></strong>
								</div>
								<% Else %>
								<div class="price priceEnd" >
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								</div>
								<% End If %>
							<% End If %>
								<div class="substance">
									<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82224/txt_desc_2.gif" alt="코튼 소재보다 부드러운 촉감과 보온성을 지닌 후리스 집업. 실내, 실외에서도 편안하게 입을 수 있습니다." />
								</div>
								<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러가기" /></div>
							</div>
						</a>
					</div>
					<%
					set oItem = nothing
					%>
				</div>

				<!-- finish -->
				<div class="finish">
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82224/txt_finish.png" alt="TEN BY TEN 콜라보 FROM AMOUR" /></p>
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
										<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82224/img_slide_story_1.jpg" alt="" /></div>
										<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82224/img_slide_story_2.jpg" alt="" /></div>
										<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82224/img_slide_story_3.jpg" alt="" /></div>
										<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82224/img_slide_story_4.jpg" alt="" /></div>
									</div>
								</div>
							</div>
							<div class="pagination"></div>
						</div>
					</div>
				</div>

				<!-- comment -->
				<div class="commentevet">
					<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82224/tit_comment.gif" alt="Hey, something project, 너에게 꼭 어울리는 컬러가 있어 " /></h3>
					<p class="hidden">나의 반려동물에게 어울리는 컬러는 무엇인가요? 정성스러운 코멘트를 남겨주신 3분을 선정하여 텐바이텐 상품권 1만원권을 선물로 드립니다.</p>
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
									<li class="ico1"><button type="button" value="1" onfocus="this.blur();">#PINK</button></li>
									<li class="ico2"><button type="button" value="2" onfocus="this.blur();">#IVORY</button></li>
									<li class="ico3"><button type="button" value="3" onfocus="this.blur();">#RED</button></li>
									<li class="ico4"><button type="button" value="4" onfocus="this.blur();">#GRAY</button></li>
								</ul>
								<textarea title="코멘트 작성" cols="60" rows="5" name="txtcomm1" id="txtcomm1" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();" <%IF NOT(IsUserLoginOK) THEN%>readonly<%END IF%>><%IF NOT IsUserLoginOK THEN%>로그인 후 글을 남길 수 있습니다.<% else %><%END IF%></textarea>
								<div class="note01 overHidden">
									<ul class="list01 ftLt">
										<li>입력하신 블로그 주소는 개인정보 유출로 인한 피해를 막고자 비공개로 텐바이텐에 접수됩니다.</li>
										<li>통신예절에 어긋나는 글이나 상업적인 글, 타 사이트에 관련된 글 또는 도용한 글은 관리자에 의해 사전 통보 없이 삭제될 수 있으며,<br>이벤트 참여에 제한을 받을 수 있습니다.</li>
									</ul>
									<input type="submit" class="ftRt btn btnW130 btnS1 btnRed" value="코멘트 남기기" onclick="jsSubmitComment(document.frmcom); return false;" />
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
									<% If isarray(split(arrCList(1,intCLoop),"!@#")) Then %>
										<strong  class="ico<%= split(arrCList(1,intCLoop),"!@#")(0) %>">
										<% if split(arrCList(1,intCLoop),"!@#")(0)="1" Then %>
										#PINK
										<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="2" Then %>
										#IVORY
										<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="3" Then %>
										#RED
										<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="4" Then %>
										#GRAY
										<% Else %>
										#PINK
										<% End If %>
										</strong></td>
									<% End If %>
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
						<% End If %>
						<div class="pageWrapV15">
							<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
						</div>
					</div>
				</div>
			<% If Not(Trim(hspchk(1)))="hsproject" Then %>
			</div>
			<% End If %>
<script type="text/javascript">
$(function(){
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
	$(".form .choice li button").click(function(){
		$(".form .choice li button").removeClass("on");
		if ( $(this).hasClass("on")) {
			$(this).removeClass("on");
		} else {
			$(this).addClass("on");
		}
	});

	/* title animation */
	titleAnimation();
	$(".heySomething .topic h2 span").css({"opacity":"0"});
	$(".heySomething .topic h2 .letter1").css({"margin-top":"7px"});
	$(".heySomething .topic h2 .letter2").css({"margin-top":"15px"});
	$(".heySomething .topic h2 .letter3").css({"margin-top":"23px"});
	function titleAnimation() {
		$(".heySomething .topic h2 .letter1").delay(300).animate({"margin-top":"0", "opacity":"1"},800);
		$(".heySomething .topic h2 .letter2").delay(700).animate({"margin-top":"7px", "opacity":"1"},800);
		$(".heySomething .topic h2 .letter3").delay(1100).animate({"margin-top":"17px", "opacity":"1"},800);
	}

	/* gallery animation */
	function galleryAnimation() {
		var window_top = $(window).scrollTop();
		var div_top = $(".heySomething .gallery").offset().top;
		if (window_top > div_top){
			$("#gallery ul li img").addClass("opacity");
		} else {
			$("#gallery ul li img").removeClass("opacity");
		}
	}
	$(function() {$(window).scroll(galleryAnimation);});
});
</script>
</body>
</html>