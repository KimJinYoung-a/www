<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈 12
' History : 2015-11-24 유태욱 생성
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
	eCode   =  65959
Else
	eCode   =  67650
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
IF application("Svr_Info") = "Dev" THEN
	itemid   =  1239115
Else
	itemid   =  1394199
End If

Dim hspchk
'// 현재 주소값 체크하여 신규, 구버전 확인
hspchk = Split(LCase(Request.ServerVariables("PATH_INFO")),"/")
%>
<style type="text/css">
/* title */
.heySomething .topic {background-color:#f0eedb;}

/* item */
.heySomething .itemA .with ul {width:1032px;}
.heySomething .itemA .with ul li {width:300px; padding:0 22px;}

/* visual */
.heySomething .visual .figure {background-color:#60b197;}

/* brand */
.heySomething .brand {height:870px;}
.brand .pooh {position:relative; width:337px; height:459px; margin:0 auto;}
.brand .pooh .clap {position:absolute; top:0; left:1px;}
.brand .pooh .character {position:absolute; top:149px; left:49px;}
.brand .pooh span {display:block;}
.brand .logo {position:relative; width:414px; height:144px; margin:50px auto 0;}
.brand .logo span {position:absolute;}
.brand .logo .disney {top:9px; left:0;}
.brand .logo .tenten {top:0; left:275px;}
.brand .logo .line {top:21px; left:207px; width:1px; height:64px; background-color:#d9d9d9;}
.heySomething .brand .btnDown {-webkit-animation-iteration-count:0;}

/* story */
.heySomething .rolling {padding-top:205px;}
.heySomething .rolling .pagination {width:975px; margin-left:-487px;}
.heySomething .rolling .swiper-pagination-switch {width:165px; height:165px; margin:0 15px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/hey/67650/bg_ico_v9.png);}
.heySomething .rolling .pagination span:first-child {background-position:0 0;}
.heySomething .rolling .pagination span.swiper-active-switch {background-position:0 -165px;}
.heySomething .rolling .pagination span:first-child + span {background-position:-165px 0;}
.heySomething .rolling .pagination span:first-child + span.swiper-active-switch {background-position:-165px -165px;}
.heySomething .rolling .pagination span:first-child + span + span {background-position:-330px 0;}
.heySomething .rolling .pagination span:first-child + span + span.swiper-active-switch {background-position:-330px -165px;}
.heySomething .rolling .pagination span:first-child + span + span + span {background-position:-495px 0;}
.heySomething .rolling .pagination span:first-child + span + span + span.swiper-active-switch {background-position:-495px -165px;}
.heySomething .rolling .pagination span:first-child + span + span + span + span {background-position:-660px 0;}
.heySomething .rolling .pagination span:first-child + span + span + span + span.swiper-active-switch {background-position:-660px -165px;}
.heySomething .rolling .pagination span:first-child + span + span + span + span + span {background-position:100% 0;}
.heySomething .rolling .pagination span:first-child + span + span + span + span + span.swiper-active-switch {background-position:100% -165px;}

.heySomething .rolling .pagination span em {bottom:-791px;}
.heySomething .rolling .pagination span em {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/hey/67650/txt_story_desc.png);}

.heySomething .swipemask {top:205px;}

/* finish */
.heySomething .finish {height:auto; background-color:#fff;}
.heySomething .finish a {background-color:#e3dcd1;}
.heySomething .finish p {overflow:hidden; position:static; width:1140px; height:auto; margin:10px auto 0; background-color:#fff; text-align:right;}

/* comment */
.heySomething .commentevet .form .choice li {width:165px; height:165px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/hey/67650/bg_ico_v9.png); background-position:0 -330px;}
.heySomething .commentevet .form .choice li.ico1 button.on {background-position:0 100%;}
.heySomething .commentevet .form .choice li.ico2 button {background-position:-165px -330px;}
.heySomething .commentevet .form .choice li.ico2 button.on {background-position:-165px 100%;}
.heySomething .commentevet .form .choice li.ico3 button {background-position:-330px -330px;}
.heySomething .commentevet .form .choice li.ico3 button.on {background-position:-330px 100%;}
.heySomething .commentevet .form .choice li.ico4 button {background-position:-495px -330px;}
.heySomething .commentevet .form .choice li.ico4 button.on {background-position:-495px 100%;}
.heySomething .commentevet .form .choice li.ico5 button {background-position:100% -330px;}
.heySomething .commentevet .form .choice li.ico5 button.on {background-position:-660px 100%;}

.heySomething .commentlist table td:first-child {padding:0 0 20px;}
.heySomething .commentlist table td strong {width:165px; height:165px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/hey/67650/bg_ico_v9.png) no-repeat 0 -330px;}
.heySomething .commentlist table td .ico2 {background-position:-165px -330px;}
.heySomething .commentlist table td .ico3 {background-position:-330px -330px;}
.heySomething .commentlist table td .ico4 {background-position:-495px -330px;}
.heySomething .commentlist table td .ico5 {background-position:-660px -330px;}
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
		<% If not( left(currenttime,10)>="2015-11-25" and left(currenttime,10)<"2015-12-03" ) Then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return false;
		<% else %>
			<% if commentcount>4 then %>
				alert("이벤트는 5회까지 참여 가능 합니다.");
				return false;
			<% else %>
				if (frm.gubunval.value == ''){
					alert('원하는 것을 선택해 주세요.');
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
			<div class="bnr"><a href="/shopping/category_prd.asp?itemid=1394199"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67650/img_item_represent.jpg" alt="" /></a></div>
		</div>

		<%' about %>
		<div class="about">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
			<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
		</div>

		<%' item %>
		<div class="item itemA">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67650/tit_disney_pooh.png" alt="디즈니 푸와 텐바이텐의 콜라보래이션" /></h3>
			<%
			itemid = 1394199
			set oItem = new CatePrdCls
				oItem.GetItemData itemid
			%>
			<div class="desc">
				<div class="figure">
					<a href="/shopping/category_prd.asp?itemid=1394199"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67650/img_item_animation.gif" alt="Pooh 전기방석" /></a>
				</div>
				<div class="option">
					<em class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67650/txt_name.png" alt="디즈니 푸 전기방석" /></em>
					<% if oItem.FResultCount > 0 then %>
						<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
							<div class="price">
								<% If not( left(currenttime,10)>="2015-11-25" and left(currenttime,10)<"2015-12-02" ) Then %>
								<% else %>
									<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/txt_only_<%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>percent.png" alt="단, 일주일만 ONLY <%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%" /></strong>
								<% end if %>
								<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
								<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
							</div>
						<% Else %>
							<%' for dev msg : 종료 후 %>
							<div class="price priceEnd">
								<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
							</div>
						<% End If %>
					<% end if %>
					<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67650/txt_substance.png" alt="마음까지 따스해지는 전기방석/전기요 소중한 사람에게 따스함을 선물하세요." /></p>
					<div class="btnget"><a href="/shopping/category_prd.asp?itemid=1394199"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="전기방석 구매하러 가기" /></a></div>
				</div>
			</div>
			<% set oItem=nothing %>
			
			<div class="with">
				<span><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/ico_plus.png" alt="" /></span>
				<ul>
					<li>
					<%
					itemid = 1394199
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
					%>
						<a href="/shopping/category_prd.asp?itemid=1394199">
							<img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67650/img_with_item_01.jpg" alt="" />
							<span>Pooh_전기방석 (single)</span>
							<% if oItem.FResultCount > 0 then %>
								<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								<% Else %>
									<%' for dev msg : 종료 후 %>
									<div class="price priceEnd">
										<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
									</div>
								<% End If %>
							<% end if %>
						</a>
					</li>
					<% set oItem=nothing %>

					<li>
					<%
					itemid = 1394209
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
					%>
						<a href="/shopping/category_prd.asp?itemid=1394209">
							<img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67650/img_with_item_02.jpg" alt="" />
							<span>Pooh_전기방석 (double)</span>
							<% if oItem.FResultCount > 0 then %>
								<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								<% Else %>
									<%' for dev msg : 종료 후 %>
									<div class="price priceEnd">
										<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
									</div>
								<% End If %>
							<% end if %>
						</a>
					</li>
					<% set oItem=nothing %>

					<li>
					<%
					itemid = 1394222
					set oItem = new CatePrdCls
						oItem.GetItemData itemid
					%>
						<a href="/shopping/category_prd.asp?itemid=1394222">
							<img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67650/img_with_item_03.jpg" alt="" />
							<span>Pooh_전기요 (single)</span>
							<% if oItem.FResultCount > 0 then %>
								<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								<% Else %>
									<%' for dev msg : 종료 후 %>
									<div class="price priceEnd">
										<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
									</div>
								<% End If %>
							<% end if %>
						</a>
					</li>
					<% set oItem=nothing %>
				</ul>
			</div>
		</div>

		<%' visual %>
		<div class="visual">
			<div class="figure"><a href="/shopping/category_prd.asp?itemid=1394199"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67650/img_item_visual_big.jpg" alt="" /></a></div>
		</div>

		<%' brand %>
		<div class="brand">
			<div class="pooh">
				<span class="clap"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67650/txt_clap_v1.png" alt="" /></span>
				<span class="character"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67650/img_pooh.png" alt="" /></span>
			</div>
			<p class="congratulate"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67650/txt_congratulate.png" alt="짝!짝!짝! 만남을 축하해요!" /></p>
			<div class="logo">
				<span class="disney"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67650/img_logo_01.png" alt="" /></span>
				<span class="tenten"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67650/img_logo_02.png" alt="" /></span>
				<span class="line"></span>
			</div>
			<p class="everyday"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67650/txt_every_day.png" alt="We cannot be happy every day, but happy things happen every day." /></p>
			<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="" /></div>
		</div>

		<%' story %>
		<div class="story">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67650/tit_story.png" alt="따스함을 찾아 떠나는 POOH의 여행" /></h3>
			<div class="rollingwrap">
				<div class="rolling">
					<div class="swipemask mask-left"></div>
					<div class="swipemask mask-right"></div>
					<button type="button" class="btn-nav arrow-left">Previous</button>
					<button type="button" class="btn-nav arrow-right">Next</button>
					<div class="swiper">
						<div class="swiper-container swiper1">
							<div class="swiper-wrapper" style="height:630px;">
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1394199"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67650/img_slide_01.jpg" alt="시린 겨울 필수품, 마음을 담아 소중한 사람에게 선물하세요 정성을 담은 손편지와 함께라면 더욱 좋겠죠!" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1394209"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67650/img_slide_02.jpg" alt="그 자리만큼은 항상 따뜻하게 유지될 수 있도록 등까지 빈틈없이 감싸줄게요" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1394222"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67650/img_slide_03.jpg" alt="오늘은 사랑하는 가족들과 그간 못다한 담소를 나눠요 폭신하고 따스한 푸우와 함께라면 더욱 행복할거에요" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1394222"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67650/img_slide_04.jpg" alt="꿀-처럼 달콤한 휴식을 가져보는 것 어때요? 따끈 따끈하게 데워진 이불 속, 그리고 향 좋은 커피와 책 한 권" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1394199"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67650/img_slide_05.jpg" alt="어린 시절, 일요일 아침 8시에 졸린 눈 비비며 꼭 챙겨보던 디즈니 만화동산 기억하시나요? 아련한 추억에 마음까지 따스해질거에요" /></a>
								</div>
							</div>
						</div>
					</div>
					<div class="pagination"></div>
				</div>
			</div>
		</div>

		<%' finish %>
		<div class="finish">
			<a href="/shopping/category_prd.asp?itemid=1394222">
				<img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67650/img_item_finish.jpg" alt="" />
			</a>
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67650/txt_copyright.png" alt="Copyright Disney. Based on the Winnie the Pooh words by A.A. Milne and E. H. Shepard" /></p>
		</div>

		<%' comment %>
		<div class="commentevet" id="commentlist" >
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/67650/tit_comment.png" alt="Hey, something project 당신이 갖고 싶은 것" /></h3>
			<p class="hidden">정성껏 코멘트를 남겨주신 5분을 추첨하여 위니더푸우 전기방석 1인용을 선물로 드립니다. 기간 : 2015.11.25 ~ 12.02 / 발표 : 12.03</p>

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
					<legend>Disney Pooh 전기방석 코멘트 쓰기</legend>
						<ul class="choice">
							<li class="ico1"><button type="button" value="1">GIFT</button></li>
							<li class="ico2"><button type="button" value="2">STUDY</button></li>
							<li class="ico3"><button type="button" value="3">TOGETHER</button></li>
							<li class="ico4"><button type="button" value="4">SLEEP</button></li>
							<li class="ico5"><button type="button" value="5">MEMORY</button></li>
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

			<%' commentlist %>
			<div class="commentlist">
				<p class="total">total <%= iCTotCnt %></p>
				<% IF isArray(arrCList) THEN %>
					<table>
						<caption>Disney Pooh 전기방석 코멘트 목록</caption>
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
												GIFT
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="2" then %>
												STUDY
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="3" then %>
												TOGETHER
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="4" then %>
												MEMORY
											<% elseif split(arrCList(1,intCLoop),"!@#")(0)="5" then %>
												PICINIC
											<% Else %>
												GIFT
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

	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 3200 ) {
			brandAnimation()
		}
		if (scrollTop > 5900 ) {
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
		$(".heySomething .topic h2 .letter1").delay(400).animate({"margin-top":"0", "opacity":"1"},800);
		$(".heySomething .topic h2 .letter2").delay(800).animate({"margin-top":"7px", "opacity":"1"},800);
		$(".heySomething .topic h2 .letter3").delay(1200).animate({"margin-top":"17px", "opacity":"1"},800);
		$(".heySomething .topic h2 .letter4").delay(1800).animate({"opacity":"1"},800);
	}

	/* brand animation */
	$(".heySomething .brand .logo span").css({"opacity":"0"});
	$(".heySomething .brand .logo .disney").css({"left":"50px"});
	$(".heySomething .brand .logo .tenten").css({"left":"210px"});
	$(".heySomething .brand p").css({"margin-top":"7px", "opacity":"0"});
	$(".heySomething .brand .btnDown").css({"opacity":"0"});
	function brandAnimation() {
		$(".heySomething .brand .congratulate").delay(1000).animate({"margin-top":"0", "opacity":"1"},1000);
		$(".heySomething .brand .logo .disney").delay(1500).animate({"left":"0", "opacity":"1"},1200);
		$(".heySomething .brand .logo .tenten").delay(1500).animate({"left":"275px", "opacity":"1"},1200);
		$(".heySomething .brand .logo .line").delay(1500).animate({"opacity":"1"},1200);
		$(".heySomething .brand .everyday").delay(2200).animate({"margin-top":"0", "opacity":"1"},1200);
		$(".heySomething .brand .btnDown").delay(2700).animate({"opacity":"1"},1200);
		$(".heySomething .brand .clap").delay(500).effect("bounce", {times:5},1000);
	}

	/* finish animation */
	$(".heySomething .finish p em").css({"opacity":"0"});
	$(".heySomething .finish p .letter1").css({"margin-left":"7px"});
	$(".heySomething .finish p .letter2").css({"margin-left":"7px"});
	$(".heySomething .finish p span").css({"width":"0"});
	function finishAnimation() {
		$(".heySomething .finish p .letter1").delay(400).animate({"margin-left":"0", "opacity":"1"},800);
		$(".heySomething .finish p .letter2").delay(900).animate({"margin-left":"0", "opacity":"1"},800);
		$(".heySomething .finish p span").delay(1500).animate({"width":"68px", "opacity":"1"},800);
	}
});
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->