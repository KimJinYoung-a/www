<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈 21
' History : 2016-02-23 이종화 생성
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
	eCode   =  66048
Else
	eCode   =  69287
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
/* title */
.heySomething .topic {background-color:#d5cbc1; z-index:1;}

/* brand */
.heySomething .gallery {overflow:hidden; position:relative; width:809px; height:799px; margin:410px auto 0;}
.heySomething .gallery div {position:absolute;}
.heySomething .gallery .pic01 {left:0; top:0;}
.heySomething .gallery .pic02 {right:0; top:0;}
.heySomething .gallery .pic03 {left:0; bottom:0;}
.heySomething .gallery .pic04 {right:0; bottom:0;}
.heySomething .brand {position:relative; width:1140px; height:1114px; margin:0 auto; padding:550px 0;}
.heySomething .brand .slide {position:relative; width:1140px; height:688px;}
.heySomething .brand .slidesjs-navigation {display:block; position:absolute; z-index:10; top:50%; width:52px; height:96px; margin-top:-48px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/69287/btn_nav.png) no-repeat 0 0; text-indent:-999em;}
.heySomething .brand .slidesjs-previous {left:40px;}
.heySomething .brand .slidesjs-next {right:40px; background-position:100% 0;}
.heySomething .brand .desc {padding-top:55px;}

/* item */
.heySomething .item {width:1140px; margin:0 auto;}
.heySomething .item h3 {height:66px; margin-bottom:114px; text-align:center; background:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/69287/bg_line.png) 50% 0 no-repeat;}
.heySomething .item h3 span {overflow:hidden; display:block; width:226px; height:34px; margin:0 auto;}
.heySomething .item h3 span img {display:block;}
.heySomething .item.item01 {padding-bottom:85px; margin-bottom:85px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/69287/bg_dash.png) 50% 100% no-repeat;}
.heySomething .item.item03 {padding-top:85px; margin-top:85px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/69287/bg_dash.png) 50% 0 no-repeat;}
.heySomething .item .desc {position:relative; padding-left:84px;}
.heySomething .item .pic {position:absolute; right:100px; top:-20px;}
.heySomething .flowerBox {width:965px; margin:190px auto 0; text-align:left; background:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/69287/bg_line_pink.png) 0 0 repeat-x;}

/* story */
.heySomething .story h3 {margin-bottom:65px;}
.heySomething .rolling {padding-top:165px;}
.heySomething .rolling .pagination {top:0; width:880px; margin-left:-440px;}
.heySomething .rolling .swiper-pagination-switch {margin:0 15px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/69287/bg_ico.png);}
.heySomething .rolling .pagination span em {bottom:-780px; left:50%; margin-left:-490px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/69287/txt_story_desc.png); cursor:default;}
.heySomething .rolling .btn-nav {top:450px;}
.heySomething .swipemask {top:165px;}

/* finish */
.heySomething .finish {height:auto; background-color:#fff;}
.heySomething .finish .txt {position:absolute; left:50%; top:150px; margin-left:-480px;}

/* comment */
.heySomething .commentevet {margin-top:360px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/69287/bg_ico_comment.png);}
.heySomething .commentlist table td strong {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/69287/bg_ico_comment.png);}
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
		<% If not( left(currenttime,10)>="2016-02-24" and left(currenttime,10)<"2016-03-02" ) Then %>
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
			<div class="bnr"><a href="/shopping/category_prd.asp?itemid=1437549&amp;pEtr=69287"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69287/img_item_represent.jpg" alt="Talk About Flower class" /></a></div>
		</div>

		<%' about %>
		<div class="about">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
			<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
		</div>

		<%' brand %>
		<div class="gallery">
			<a href="/street/street_brand_sub06.asp?makerid=talkabout">
				<div class="pic01"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69287/img_flower_01.jpg" alt="" /></div>
				<div class="pic02"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69287/img_flower_02.jpg" alt="" /></div>
				<div class="pic03"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69287/img_flower_03.jpg" alt="" /></div>
				<div class="pic04"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69287/txt_talk_about.jpg" alt="" /></div>
			</a>
		</div>
		<div class="brand">
			<div id="slide01" class="slide">
				<div><a href="/shopping/category_prd.asp?itemid=1437549&amp;pEtr=69287"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69287/img_brand_01.jpg" alt="" /></a></div>
				<div><a href="/shopping/category_prd.asp?itemid=1437549&amp;pEtr=69287"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69287/img_brand_02.jpg" alt="" /></a></div>
				<div><a href="/shopping/category_prd.asp?itemid=1437623&amp;pEtr=69287"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69287/img_brand_03.jpg" alt="" /></a></div>
				<div><a href="/shopping/category_prd.asp?itemid=1437623&amp;pEtr=69287"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69287/img_brand_04.jpg" alt="" /></a></div>
			</div>
			<p class="desc"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69287/txt_brand.png" alt="무언가에 집중한 적 있으세요? 새로운 것에 몰입하는 시간은 지루한 일상에 새로운 즐거움을 느낄 수 있게 해준답니다. 반복적인 일상을 보내고 있는 당신에게 추천하는 플라워 원데이 클래스 단지 좋아함만이 아닌 조금 더 전문적인 플라워 클래스의 첫 걸음, 하비 클래스 꽃의 종류와 형태 그리고 색감을 이해하여 무작정 자유로운 스타일이 아닌 언밸런스 안에서의 자유로운 밸런스 프렌치 스타일의 플라워 디자인을 배워보세요!" /></p>
			<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="" /></div>
		</div>

		<%' item %>
		<div class="item item01">
			<div class="inner">
				<h3>
					<span class="t01"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69287/tit_talk_about.png" alt="TALK ABOUT " /></span>
					<span class="t02"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69287/tit_flower_studio.png" alt="FLOWER STUDIO" /></span>
				</h3>
				<%
				itemid = 1437549
				set oItem = new CatePrdCls
					oItem.GetItemData itemid
				%>
				<div class="desc">
					<div class="option">
						<em class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69287/txt_name_01.png" alt="HOBBY CLASS 4주 과정" /></em>
						<% if oItem.FResultCount > 0 then %>
							<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
							<div class="price">
								<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/txt_only_<%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>percent.png" alt="단, 일주일만 ONLY <%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%" /></strong>
								<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
								<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
							</div>
							<% Else %>
							<%' for dev msg : 종료 후 %>
							<div class="price priceEnd">
								<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
							</div>
							<% End If %>
						<% End If %>
						<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69287/txt_substance_01.png" alt="꽃을 이해하고 꽃과 가까워질 수 있는 즐겁고 설레는 시간으로 봄을 시작하세요!" /></p>
						<div class="btnget">
							<a href="/shopping/category_prd.asp?itemid=1437549&amp;pEtr=69287"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러 가기" /></a>
						</div>
					</div>
					<div class="pic"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69287/img_item_01.png" alt="" /></div>
				</div>
				<% set oItem=nothing %>
			</div>
		</div>
		<div class="item item02">
			<div class="inner">
				<%
				itemid = 1437623
				set oItem = new CatePrdCls
					oItem.GetItemData itemid
				%>
				<div class="desc">
					<div class="option">
						<em class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69287/txt_name_02.png" alt="HOBBY CLASS 4주 과정" /></em>
						<% if oItem.FResultCount > 0 then %>
							<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
							<div class="price">
								<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/txt_only_<%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>percent.png" alt="단, 일주일만 ONLY <%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%" /></strong>
								<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
								<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
							</div>
							<% Else %>
							<%' for dev msg : 종료 후 %>
							<div class="price priceEnd">
								<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
							</div>
							<% End If %>
						<% End If %>
						<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69287/txt_substance_02.png" alt="꽃을 이해하고 꽃과 가까워질 수 있는 즐겁고 설레는 시간으로 봄을 시작하세요!" /></p>
						<div class="btnget">
							<!--<a href="/shopping/category_prd.asp?itemid=1437623&amp;pEtr=69287"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러 가기" /></a>-->
							<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69287/txt_soldout.png" alt="SOLDOUT" /></p>
						</div>
					</div>
					<div class="pic"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69287/img_item_02.png" alt="" /></div>
				</div>
				<% set oItem=nothing %>
			</div>
		</div>
		<div class="item item03">
			<div class="inner">
				<%
				itemid = 1443276
				set oItem = new CatePrdCls
					oItem.GetItemData itemid
				%>
				<div class="desc">
					<div class="option">
						<em class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69287/txt_name_03.png" alt="Take ME  Home" /></em>
						<% if oItem.FResultCount > 0 then %>
							<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
							<div class="price">
								<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/txt_only_<%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>percent.png" alt="단, 일주일만 ONLY <%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%" /></strong>
								<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
								<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
							</div>
							<% Else %>
							<%' for dev msg : 종료 후 %>
							<div class="price priceEnd">
								<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
							</div>
							<% End If %>
						<% End If %>
						<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69287/txt_substance_03.png" alt="지인들과 좋은 시간과 추억 또는 축하하는 날, 이동과 시간에 구애 받지 않고 우리 집에서 배우는 플라워 클래스" /></p>
						<div class="btnget">
							<a href="/shopping/category_prd.asp?itemid=1443276&amp;pEtr=69287"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러 가기" /></a>
						</div>
					</div>
					<div class="pic"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69287/img_item_03.png" alt="" /></div>
				</div>
				<% set oItem=nothing %>
			</div>
		</div>

		<div class="flowerBox"><a href="http://www.thefingers.co.kr/lecture/lecturedetail.asp?lec_idx=13654&cate_large=30 " target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69287/btn_flower_box.png" alt="텐바이텐에서 배울 수 있는 토크어바웃 플라워 박스" /></a></div>

		<%' story %>
		<div class="story">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69287/txt_story.png" alt="언밸런스 안의 밸런스, 프랜치 스타일" /></h3>
			<div class="rollingwrap">
				<div class="rolling">
					<div class="swipemask mask-left"></div>
					<div class="swipemask mask-right"></div>
					<button type="button" class="btn-nav arrow-left">Previous</button>
					<button type="button" class="btn-nav arrow-right">Next</button>
					<div class="swiper">
						<div class="swiper-container swiper1">
							<div class="swiper-wrapper">
								<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69287/img_slide_01.jpg" alt="매일 다양한 업무와 반복적인 일상에 지친 나를 위한 선물. 새로운 것을 배우고 집중하며 느낄 수 있는 즐거움을 선사합니다." /></div>
								<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69287/img_slide_02.jpg" alt="취미가 아닌 좀 더 제대로 배워보고 싶은 플라워 클래스의 첫걸음. 스킬 만큼이나 즐겁고 설레는 시간으로 배우는 것이 더욱 중요합니다." /></div>
								<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69287/img_slide_03.jpg" alt="꽃의 시즌에 따라 컨셉을 정하고 형태와 색감을 정합니다. 컨셉에 따라 아낌없이 여러 종류의 꽃과 소재가 사용되며 다양한 수입 꽃도 함께 사용됩니다." /></div>
								<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69287/img_slide_04.jpg" alt="획일화된 디자인이 아닌 수강생의 감성을 존중하며 상세하게 피드백 되는 수업이 되고자 합니다." /></div>
								<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69287/img_slide_05.jpg" alt="소소히 나누는 이야기와 함께 자신을 위로하는 편안한 시간을 나누고자 합니다." /></div>
							</div>
						</div>
					</div>
					<div class="pagination"></div>
				</div>
			</div>
		</div>

		<%' finish %>
		<div class="finish">
			<a href="/shopping/category_prd.asp?itemid=1437549&amp;pEtr=69287">
				<p class="txt"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69287/txt_finish.png" alt="토크어바웃은 플라워 스튜디오 입니다. 꽃에는 저마다의 스토리가 있습니다. 우리는 스토리로부터 영감을  받아 감각적인 디자인과 스타일링으로 토크어바웃만의 플라워 문화를 만들고자 합니다. 당신의 라이프스타일의 새로운 변화를 기대하세요." /></p>
				<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69287/img_finish.jpg" alt="" />
			</a>
		</div>

		<%' comment %>
		<div class="commentevet">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/69287/tit_comment.png" alt="Hey, something project 함께 하고 싶은 사람" /></h3>
			<p class="hidden">설날에 가족과 함께 하고 싶은 감성고기와 그 이유를 남겨주세요. 정성껏 코멘트를 남겨주신 5분을 선정하여 후식으로 좋은 아이스크림케이크(4개입) 녹차/라즈베리/유자 중 한가지 맛을 선물로 드립니다. (랜덤증정)</p>
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
							<li class="ico1"><button type="button" value="1">For me</button></li>
							<li class="ico2"><button type="button" value="2">First Step</button></li>
							<li class="ico3"><button type="button" value="3">Design</button></li>
							<li class="ico4"><button type="button" value="4">Creative</button></li>
							<li class="ico5"><button type="button" value="5">Comfortable</button></li>
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
												For Me
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="2" then %>
												First Step
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="3" then %>
												Design
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="4" then %>
												Creative
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="5" then %>
												Comfortable
											<% Else %>
												For Me
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

	/* swipe */
	var swiper1 = new Swiper('.swiper1',{
		centeredSlides:true,
		slidesPerView:"auto",
		loop: true,
		speed:1500,
		autoplay:3000,
		simulateTouch:false,
		pagination: '.pagination',
		paginationClickable: true
	});
	$('.arrow-left').on('click', function(e){
		e.preventDefault()
		swiper1.swipePrev()
	});
	$('.arrow-right').on('click', function(e){
		e.preventDefault()
		swiper1.swipeNext()
	});
	$('.pagination span:nth-child(1)').append('<em class="desc1"></em>');
	$('.pagination span:nth-child(2)').append('<em class="desc2"></em>');
	$('.pagination span:nth-child(3)').append('<em class="desc3"></em>');
	$('.pagination span:nth-child(4)').append('<em class="desc4"></em>');
	$('.pagination span:nth-child(5)').append('<em class="desc5"></em>');
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

	/* slide js */
	$("#slide01").slidesjs({
		width:"1140",
		height:"688",
		pagination:false,
		navigation:{effect:"fade"},
		play:{interval:3000, effect:"fade", auto:true},
		effect:{fade: {speed:1200, crossfade:true}
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

	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 1200 ) {
			brandAnimation()
		}
		if (scrollTop > 3950 ) {
			itemTitAnimation()
		}
		if (scrollTop > 7350 ) {
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

	/* brand animation */
	$(".heySomething .gallery div").css({"opacity":"0"});
	$(".heySomething .gallery div.pic01").css({"left":"-30px"});
	$(".heySomething .gallery div.pic02").css({"top":"-30px"});
	$(".heySomething .gallery div.pic03").css({"bottom":"-30px"});
	$(".heySomething .gallery div.pic04").css({"right":"-30px"});
	function brandAnimation() {
		$(".heySomething .gallery div.pic01").delay(100).animate({"left":"0","opacity":"1"},900);
		$(".heySomething .gallery div.pic02").delay(100).animate({"top":"0","opacity":"1"},900);
		$(".heySomething .gallery div.pic03").delay(100).animate({"bottom":"0","opacity":"1"},900);
		$(".heySomething .gallery div.pic04").delay(100).animate({"right":"0","opacity":"1"},900);
	}

	/* item animation */
	$(".heySomething .item h3 span.t01 img").css({"margin-top":"-34px"});
	$(".heySomething .item h3 span.t02 img").css({"margin-top":"34px"});
	function itemTitAnimation() {
		$(".heySomething .item h3 span img").delay(100).animate({"margin-top":"0"},900);
	}

	/* finish animation */
	$(".heySomething .finish .txt").css({"margin-left":"-490px","opacity":"0"});
	function finishAnimation() {
		$(".heySomething .finish .txt").delay(100).animate({"opacity":"1","margin-left":"-480px"},1500);
	}
});
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->