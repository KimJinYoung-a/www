<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'###########################################################
' Description : hey, something project 시리즈 98
' 마음을 더한 순한 비누
' History : 2017-12-05 정태훈 생성
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
	eCode   =  67486
Else
	eCode   =  82605
End If

dim userid, commentcount, i
	userid = GetEncLoginUserID()

if userid = "baboytw" or userid = "chaem35" or userid = "answjd248" or userid = "corpse2" or userid = "jinyeonmi" then
	currenttime = #12/06/2017 09:00:00#
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
.heySomething .topic {background-color:#f9cdd2;}

/* brand */
.heySomething .brand {position:relative; height:820px; margin:332px 0 470px; text-align:center;}
.heySomething .brand .btnDown {margin-top:85px;}

/* item */
.heySomething .item {margin:410px auto 220px; text-align:center;}
.heySomething .item .desc {position:relative; width:1140px; min-height:330px; height:330px; margin:0 auto; padding:140px 0 150px;}
.heySomething .item .desc:before {content:' '; display:inline-block; position:absolute; top:0; left:0; width:100%; height:1px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/82224/bg_line.png) repeat-x 0 0; }
.heySomething .item .inner {overflow:hidden; display:block; width:1140px; margin:0 auto;}
.heySomething .item .figure {position:static; float:right;}
.heySomething .item .option {float:left; height:330px; padding-left:80px; text-align:left;}
.heySomething .item .option .price {margin-top:26px;}
.heySomething .item .option .btnget {left:80px;}
.heySomething .item .item1:before{display:none;}
.heySomething .item .item2 .option {padding-right:67px;}
.heySomething .item .desc2 {padding-top:139px;}
.heySomething .item .desc2 .inner {margin-right:20px;}
.heySomething .item .desc2 .option {float:right;}
.heySomething .item .desc2 .figure {float:left;}

/* item-gallery */
.item-gallery {text-align:center;}

/* finish */
.heySomething .finish {height:670px; margin-top:375px; background:#efefef url(http://webimage.10x10.co.kr/eventIMG/2017/hey/82605/bg_finish.jpg) no-repeat 50% 0; text-align:center;}
.heySomething .finish p {position:absolute; top:275px; margin-left:-478px;}

/* story */
.heySomething .story {margin:310px 0 0;}
.heySomething .rollingwrap {margin-top:0;}
.heySomething .rolling {height:708px; padding-top:175px;}
.heySomething .rolling .swiper , .heySomething .rolling .swiper .swiper-container{height:708px;}
.heySomething .rolling .pagination {width:704px; margin-left:-352px;}
.heySomething .rolling .pagination span {margin:0 18px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/82605/bg_ico_1.png);}
.heySomething .rolling .pagination span em {bottom:-780px; left:-150px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/82605/txt_story_desc.png); cursor:default;}
.heySomething .rolling .btn-nav {top:490px;}
.heySomething .swipemask {top:165px; height:708px; }

/* comment */
.heySomething .commentevet {padding-top:52px; margin-top:370px}
.heySomething .commentevet textarea {margin-top:0;}
.heySomething .commentevet .form {margin-top:0;}
.heySomething .commentevet .form .choice {margin-left:-20px;}
.heySomething .commentevet .form .choice li {width:110px; height:150px; margin:0 10px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/82605/bg_ico_2.png);}
.heySomething .commentevet .form .choice li.ico1 button{background-position:-20px 0;}
.heySomething .commentevet .form .choice li.ico1 button.on{background-position:-20px -150px;}
.heySomething .commentevet .form .choice li.ico2 button{background-position:-170px 0;}
.heySomething .commentevet .form .choice li.ico2 button.on{background-position:-170px -150px;}
.heySomething .commentevet .form .choice li.ico3 button{background-position:-320px 0;}
.heySomething .commentevet .form .choice li.ico3 button.on{background-position:-320px -150px;}
.heySomething .commentevet .form .choice li.ico4 button{background-position:-470px 0;}
.heySomething .commentevet .form .choice li.ico4 button.on{background-position:-470px -150px;}
.heySomething .commentlist table td strong {width:130px; height:150px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/82605/bg_ico_2.png); background-position:-20px 0;}
.heySomething .commentlist table td .ico2 {background-position:-170px 0;}
.heySomething .commentlist table td .ico3 {background-position:-320px 0;}
.heySomething .commentlist table td .ico4 {background-position:-470px 0;}
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
});

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
		<% If not( left(currenttime,10) >= "2017-12-05" and left(currenttime,10) < "2017-12-26" ) Then %>
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

</head>
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
					<div class="bnr"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82605/img_item_represent.jpg" alt="plus PONYBROWN" /></div>
				</div>

				<!-- about -->
				<div class="about">
					<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
					<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
				</div>

				<!-- brand -->
				<div class="brand">
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82605/txt_brand.jpg" alt="포니브라운 플러스는 감각적인 캐릭터 디자인으로 사랑받으며 높은 품질의 제품 생산 노하우를 바탕으로 탄생한 코스" /></p>
					<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="아래로 이동" /></div>
				</div>
				<%
				IF application("Svr_Info") = "Dev" THEN
					itemid = 1239226
				Else
					itemid = 1849970
				End If
				set oItem = new CatePrdCls
					oItem.GetItemData itemid
				%>
				<!-- item -->
				<div class="item">
					<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82605/tit_plus_ponybrown.jpg" alt="plus PONYBROWN X TEN BY TEN" /></h3>
					<div class="desc desc1 item1">
						<a href="/shopping/category_prd.asp?itemid=1849970&pEtr=82605" class="inner">
							<div class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82605/img_item_1.jpg" alt="포니브라운 올리브 고트밀크 솝" /></div>
							<div class="option">
								<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82605/txt_item_1.png" alt="언센티드 오리지널" /></p>
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
								<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러가기" /></div>
							</div>
						</a>
					</div>
					<% Set oItem = Nothing %>
					<%
					IF application("Svr_Info") = "Dev" THEN
						itemid = 1239226
					Else
						itemid = 1849971
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
					%>
					<div class="desc desc2 item2">
						<a href="/shopping/category_prd.asp?itemid=1849971&pEtr=81294" class="inner">
							<div class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82605/img_item_2.jpg" alt="포니브라운 올리브 고트밀크 솝" /></div>
							<div class="option">
								<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82605/txt_item_2.png" alt="마누카허니 & 카카두플럼" /></p>
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
								<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러가기" /></div>
							</div>
						</a>
					</div>
					<% Set oItem = Nothing %>
					<%
					IF application("Svr_Info") = "Dev" THEN
						itemid = 1239226
					Else
						itemid = 1849973
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
					%>
					<div class="desc desc1 item3">
						<a href="/shopping/category_prd.asp?itemid=1849973&pEtr=82605" class="inner">
							<div class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82605/img_item_3.jpg" alt="포니브라운 올리브 고트밀크 솝 " /></div>
							<div class="option">
								<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82605/txt_item_3.png" alt="레몬머틀 & 유칼립투스" /></p>
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
								<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러가기" /></div>
							</div>
						</a>
					</div>
					<% Set oItem = Nothing %>
					<%
					IF application("Svr_Info") = "Dev" THEN
						itemid = 1239226
					Else
						itemid = 1849972
					End If
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
					%>
					<div class="desc desc2 item4">
						<a href="/shopping/category_prd.asp?itemid=1849972&pEtr=81294" class="inner">
							<div class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82605/img_item_4.jpg" alt="포니브라운 올리브 고트밀크 솝" /></div>
							<div class="option">
								<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82605/txt_item_4_v2.png" alt="라벤더 & 와일드 카모마일" /></p>
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
								<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러가기" /></div>
							</div>
						</a>
					</div>
				</div>
				<% Set oItem = Nothing %>
				<!--- gallery -->
				<div class="item-gallery"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82605/img_item_list.jpg" alt="" /></div>

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
										<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82605/img_slide_story_1.jpg" alt="# Original 천연 원료 고유의 향도 최소화하여 엄마와 아이가 함께 사용하기 좋아요" /></div>
										<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82605/img_slide_story_2.jpg" alt="# Honey & Plum 강력한 보습 성분과 비타민으로 피부를 건강하게 가꾸어줘요" /></div>
										<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82605/img_slide_story_3.jpg" alt="# Lemon & Eucalyptus 레몬머틀과 유칼립투스가 피부 염증 및 자극 완화에 도움을 줘요." /></div>
										<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82605/img_slide_story_4.jpg" alt="# Lavender & Chamomile 라벤더와 카모마일이 피부 보습 및 트러블 케어에 도움을 줘요" /></div>
									</div>
								</div>
							</div>
							<div class="pagination"></div>
						</div>
					</div>
				</div>

				<!-- finish -->
				<div class="finish">
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82605/txt_finish.png" alt="무향료, 무방부제, 무색소 순한 저자극 천연 비누 천연 유래 순비누 계면활성제를 사용하여 유아들도 안심하고 사용할 수 있는 순한 저자극 비누입니다. 사용 후 당김 없고 탁월한 수분감으로 촉촉하고 부드러운 피부를 느껴보세요 !" /></p>
				</div>

				<!-- comment -->
				<div class="commentevet">
					<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82605/tit_comment.gif" alt="Hey, something project, 당신이 원하는 것" /></h3>
					<p class="hidden">포니브라운 올리브 고트 밀크 솝 4종 중 어떤 비누를 가장 사용해보고 싶으신가요? 정성껏 코멘트를 남겨주신 10분을 추첨하여 포니브라운 드림 마스크 세트(10매입/랜덤)을 선물로 드립니다.</p>
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
									<li class="ico1"><button type="button" value="1" onfocus="this.blur();">#Original</button></li>
									<li class="ico2"><button type="button" value="2" onfocus="this.blur();">#Honey& Plum</button></li>
									<li class="ico3"><button type="button" value="3" onfocus="this.blur();">#Lemon& Eucalyptus</button></li>
									<li class="ico4"><button type="button" value="4" onfocus="this.blur();">#Lavender& Chamomile</button></li>
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
										#Original
										<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="2" Then %>
										#Honey& Plum
										<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="3" Then %>
										#Lemon& Eucalyptus
										<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="4" Then %>
										#Lavender& Chamomile
										<% Else %>
										#Original
										<% End If %>
										</strong></td>
									<% End If %>
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
										<button type="button" class="btndel" onclick="jsDelComment('<% = arrCList(0,intCLoop) %>'); return false;"><img src="http://fiximage.10x10.co.kr/web2013/event/btn_cmt_close.gif" alt="코멘트 삭제"></button>
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