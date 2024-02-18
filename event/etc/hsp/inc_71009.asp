<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈 34
' History : 2016-05-31 유태욱 생성
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

dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  66140
Else
	eCode   =  71009
End If

dim userid, commentcount, i
	userid = GetEncLoginUserID()

commentcount = getcommentexistscount(userid, eCode, "", "", "", "Y")

dim cEComment ,blnFull, cdl, com_egCode, bidx, blnBlogURL, strBlogURL
dim iCTotCnt, arrCList,intCLoop
dim iCPageSize, iCCurrpage, isMyComm
dim iCStartPage, iCEndPage, iCTotalPage, iCx,iCPerCnt
	iCCurrpage	= requestCheckVar(Request("iCC"),10)	'현재 페이지 번호
	cdl			= requestCheckVar(Request("cdl"),3)
	blnFull		= requestCheckVar(Request("blnF"),10)
	blnBlogURL	= requestCheckVar(Request("blnB"),10)
	isMyComm	= requestCheckVar(request("isMC"),1)

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
.heySomething .topic {background-color:#f9f9f9;}
.heySomething .topic h2 {z-index:5;}
.heySomething .topic .figure a {display:block; position:relative; width:100%; height:780px;}
.heySomething .topic .figure img {position:absolute; top:0; left:50%; margin-left:-951px;}

/* item */
.heySomething .itemA.v2 {margin-top:200px; border-top:1px solid #ddd;}
.heySomething .itemA .figure {top:55px;}
.heySomething .itemA .desc {padding-top:93px; min-height:470px;}
.heySomething .itemA .with {border-bottom:0;}
.heySomething .itemA .with ul {width:1030px; padding-bottom:0;}
.heySomething .itemA .with ul li {width:217px; padding:0 20px;}
.heySomething .item .option .price strong {color:#000; font-family:verdana, tahoma, sans-serif;}


/* visual */
.heySomething .willDuckoo {position:relative; height:595px; margin-top:180px; background:#fed649 url(http://webimage.10x10.co.kr/eventIMG/2016/hey/71009/img_figure.jpg) 50% 100% no-repeat;}
.heySomething .willDuckoo p {position:absolute; left:50%; top:93px; margin-left:-311px;}
.heySomething .willDuckoo ul {position:absolute; left:50%; top:235px; z-index:50; width:1140px; margin-left:-570px;}
.heySomething .willDuckoo li {float:left; width:20%;}
.heySomething .willDuckoo li a {display:block; height:280px; text-indent:-999em;}
.heySomething .willDuckoo .mask {position:absolute; left:50%; bottom:0; z-index:40; margin-left:-570px; width:1140px; height:380px; background:#fed649;}
.heySomething .welcomeDuckoo {position:relative; height:595px; margin-top:180px; background:#fed649 url(http://webimage.10x10.co.kr/eventIMG/2016/hey/71009/bg_welcome.jpg) 50% 50% no-repeat;}
.heySomething .welcomeDuckoo p {position:absolute; left:50%; top:252px; margin-left:-445px;}

/* brand */
.heySomething .brand {position:relative; height:682px; margin-top:540px;}

/* story */
.heySomething .story {margin-top:285px;}
.heySomething .story h3 {margin-bottom:0;}
.heySomething .rolling {margin-top:75px; padding-top:180px; padding-bottom:120px;}
.heySomething .rolling .pagination {top:0; width:850px; margin-left:-425px;}
.heySomething .rolling .pagination .swiper-pagination-switch {width:156px; height:156px; margin:0 7px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/71009/bg_ico_01.png) no-repeat 0 0;}
.heySomething .rolling .pagination span.swiper-active-switch {background-position:0 -156px;}
.heySomething .rolling .pagination span:first-child + span {background-position:-156px 0;}
.heySomething .rolling .pagination span:first-child + span.swiper-active-switch {background-position:-156px -156px;}
.heySomething .rolling .pagination span:first-child + span + span {background-position:-312px 0;}
.heySomething .rolling .pagination span:first-child + span + span.swiper-active-switch {background-position:-312px -156px;}
.heySomething .rolling .pagination span:first-child + span + span + span {background-position:-468px 0;}
.heySomething .rolling .pagination span:first-child + span + span + span.swiper-active-switch {background-position:-468px -156px;}
.heySomething .rolling .pagination span:first-child + span + span + span + span {background-position:100% 0;}
.heySomething .rolling .pagination span:first-child + span + span + span + span.swiper-active-switch {background-position:100% -156px;}
.heySomething .rolling .pagination span em {bottom:-774px; left:50%;height:120px; width:980px; margin-left:-490px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/71009/txt_story_desc.png); cursor:default;}
.heySomething .swipemask {top:180px;}

/* finish */
.heySomething .finish {background-color:#fbe3cf; height:850px; margin-top:325px;}
.heySomething .finish .figure {position:absolute; top:0; left:50%; margin-left:-951px;}
.heySomething .finish p {top:160px; margin-left:-372px;}

/* comment */
.heySomething .commentevet .form {margin-top:40px;}
.heySomething .commentevet .form .choice li {margin-right:55px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/71009/bg_ico_02.png);}
.heySomething .commentevet textarea {margin-top:50px;}
.heySomething .commentlist table td {padding:20px 0;}
.heySomething .commentlist table td strong {width:142px; height:105px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/71009/bg_ico_03.png); background-position:0 0;}
.heySomething .commentlist table td strong.ico2 {background-position:-142px 0;}
.heySomething .commentlist table td strong.ico3 {background-position:-284px 0;}
.heySomething .commentlist table td strong.ico4 {background-position:-426px 0;}
.heySomething .commentlist table td strong.ico5 {background-position:100% 0;}
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
		<% If not( left(currenttime,10)>="2016-05-31" and left(currenttime,10)<"2017-01-01" ) Then %>
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
}

</script>
<% If Not(Trim(hspchk(1)))="hsproject" Then %>
	<div class="heySomething">
<% End If %>
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
			<div class="figure">
				<a href="/shopping/category_prd.asp?itemid=1500617&amp;pEtr=71009"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71009/img_item_represent.jpg" alt="DUCKOO" /></a>
			</div>
		</div>

		<div class="about">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
			<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
		</div>

		<div class="item itemA">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71009/tit_duckoo.png" alt="DUCKOO" /></h3>
			<%
				IF application("Svr_Info") = "Dev" THEN
					itemid = 1239226
				Else
					itemid = 1500617
				End If
				set oItem = new CatePrdCls
					oItem.GetItemData itemid
			%>
			<div class="desc">
				<!-- 상품 이름, 가격, 구매하기 -->
				<div class="option">
					<em class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71009/txt_name_figure.png" alt="DUCKOO Series Figure" /></em>
					<% If oItem.FResultCount > 0 Then %>
						<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
							<div class="price">
								<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71009/txt_pre_open.png" alt="텐바이텐 단독 선오픈" /></strong>
								<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
								<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
							</div>
						<% Else %>
							<div class="price">
								<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71009/txt_pre_open.png" alt="텐바이텐 단독 선오픈" /></strong>
								<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
							</div>
						<% End If %>
					<% End If %>
					<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71009/txt_substance_figure.png" alt="귀여운 더쿠 피규어가 여름을 맞이하여 베이직 버전으로 돌아왔어요! 튜브를 타고 있는 더쿠! 더쿠 시리즈와 함께 이번 여름을 맞이하세요!" /></p>
					<div class="btnget"><a href="/shopping/category_prd.asp?itemid=1500617&amp;pEtr=71009"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러 가기" /></a></div>
				</div>
				<div class="figure"><a href="/shopping/category_prd.asp?itemid=1500617&amp;pEtr=71009"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71009/img_item_01.jpg" alt="베이직더쿠" /></a></div>
			</div>
			<div class="with">
				<ul>
					<li>
						<a href="/shopping/category_prd.asp?itemid=1464413&amp;pEtr=71009">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71009/img_duckoo_figure_02.jpg" alt="" />
							<span>BEING DUCKOO</span>
							<strong>39,000 won</strong>
						</a>
					</li>
					<li>
						<a href="/shopping/category_prd.asp?itemid=1464414&amp;pEtr=71009">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71009/img_duckoo_figure_03.jpg" alt="" />
							<span>CAMPING DUCKOO</span>
							<strong>39,000 won</strong>
						</a>
					</li>
					<li>
						<a href="/shopping/category_prd.asp?itemid=1464415&amp;pEtr=71009">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71009/img_duckoo_figure_04.jpg" alt="" />
							<span>WORKING DUCKOO</span>
							<strong>39,000 won</strong>
						</a>
					</li>
					<li>
						<a href="/shopping/category_prd.asp?itemid=1464416&amp;pEtr=71009">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71009/img_duckoo_figure_05.jpg" alt="" />
							<span>SWIMMING DUCKOO</span>
							<strong>39,000 won</strong>
						</a>
					</li>
				</ul>
			</div>
			<% set oItem=nothing %>
		</div>
		
		<div class="willDuckoo">
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71009/txt_duck_you.png" alt="WE WILL DUCKOO" /></p>
			<ul>
				<li><a href="/shopping/category_prd.asp?itemid=1500617&amp;pEtr=71009">BASIC DUCKOO</a></li>
				<li><a href="/shopping/category_prd.asp?itemid=1464415&amp;pEtr=71009">WORKING DUCKOO</a></li>
				<li><a href="/shopping/category_prd.asp?itemid=1464413&amp;pEtr=71009">BEING DUCKOO</a></li>
				<li><a href="/shopping/category_prd.asp?itemid=1464414&amp;pEtr=71009">CAMPING DUCKOO</a></li>
				<li><a href="/shopping/category_prd.asp?itemid=1464416&amp;pEtr=71009">SWIMMING DUCKOO</a></li>
			</ul>
			<div class="mask"></div>
		</div>

		<div class="item itemA v2">
			<%
				IF application("Svr_Info") = "Dev" THEN
					itemid = 1239226
				Else
					itemid = 1500618
				End If
				set oItem = new CatePrdCls
					oItem.GetItemData itemid
			%>
			<div class="desc">
				<div class="option">
					<em class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71009/txt_name_note.png" alt="DUCKOO Note" /></em>
					<% If oItem.FResultCount > 0 Then %>
						<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
							<div class="price">
								<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71009/txt_pre.png" alt="텐바이텐 선오픈" /></strong>
								<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
								<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
							</div>
						<% Else %>
							<div class="price">
								<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71009/txt_pre.png" alt="텐바이텐 선오픈" /></strong>
								<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
							</div>
						<% End If %>
					<% End If %>
					<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71009/txt_substance_note.png" alt="좋은 품질을 자랑하는 한국 폼텍과의 콜라보한 더쿠의 오감 노트! 더쿠피규어가 그려진 매력적인 노트로 언제나 더쿠와 함께해요!" /></p>
					<div class="btnget"><a href="/shopping/category_prd.asp?itemid=1500618&amp;pEtr=71009"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러 가기" /></a></div>
				</div>
				<div class="figure"><a href="/shopping/category_prd.asp?itemid=1500618&amp;pEtr=71009"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71009/img_note_01_v2.jpg" alt="냠냠노트" /></a></div>
			</div>
			<div class="with">
				<ul>
					<li>
						<a href="/shopping/category_prd.asp?itemid=1500621&amp;pEtr=71009">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71009/img_duckoo_note_02.jpg" alt="" />
							<span>톡톡노트</span>
							<strong>18,000 won</strong>
						</a>
					</li>
					<li>
						<a href="/shopping/category_prd.asp?itemid=1500620&amp;pEtr=71009">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71009/img_duckoo_note_03.jpg" alt="" />
							<span>봄봄노트</span>
							<strong>18,000 won</strong>
						</a>
					</li>
					<li>
						<a href="/shopping/category_prd.asp?itemid=1500623&amp;pEtr=71009">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71009/img_duckoo_note_04.jpg" alt="" />
							<span>유후노트</span>
							<strong>18,000 won</strong>
						</a>
					</li>
					<li>
						<a href="/shopping/category_prd.asp?itemid=1500619&amp;pEtr=71009">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71009/img_duckoo_note_05.jpg" alt="" />
							<span>킁킁노트</span>
							<strong>18,000 won</strong>
						</a>
					</li>
				</ul>
			</div>
			<% set oItem=nothing %>
		</div>
		
		<div class="welcomeDuckoo">
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71009/txt_welcome.png" alt="WELCOME TO DUCKOO WORLD" /></p>
		</div>

		<div class="brand">
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71009/txt_brand.gif" alt="초코사이다는 쓰고, 그리고, 만드는 콘텐츠 창작 집단입니다. 우리는 ‘더쿠(DUCKOO)’라는 캐릭터를 통해 ‘취미’와 ‘잉여’를 주제로 그래픽, 피규어, 영상을 만들고, 다른 브랜드와 협업을 전개합니다. 누구나 가진 소소한 것에 대한 호기심을 이야기하면서, 진정 하고 싶은 일을 스스로 알아가는 콘텐츠를 만듭니다. 그리고 이러한 주제를 조금 엉뚱하고 단순하게 표현합니다. 우리의 콘텐츠와 제품을 접하는 사람들이 많아지길 바라고, 즐거움과 위안뿐만 아니라 작은 동기까지도 얻기를 바랍니다. 그래서 그들의 새로운 이야기가 더 많이 생겨나고, 공유되면 좋겠습니다. YES I AM DUCKOO! YOU CAN BE DUCKOO!" /></p>
			<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="" /></div>
		</div>

		<div class="story">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71009/txt_story.png" alt="LET'S DUCK!" /></h3>
			<div class="rollingwrap">
				<div class="rolling">
					<div class="swipemask mask-left"></div>
					<div class="swipemask mask-right"></div>
					<button type="button" class="btn-nav arrow-left">Previous</button>
					<button type="button" class="btn-nav arrow-right">Next</button>
					<div class="swiper">
						<div class="swiper-container swiper1">
							<div class="swiper-wrapper">
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1500617&amp;pEtr=71009"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71009/img_slide_01.jpg" alt="#BASIC DUCKOO 미쳐 숨기지 못한 볼록한 배와 봉긋 솟은 꼬리. 갑자기 더워진 날씨에 튜브만 들고 뛰쳐나온 더쿠" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1464413&amp;pEtr=71009"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71009/img_slide_02.jpg" alt="#BEING DUCKOO 우연히 본 패션 잡지 기사를 따라 멀쩡한 깔깔이에 염색을 한 더쿠" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1464414&amp;pEtr=71009"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71009/img_slide_03.jpg" alt="#CAMPING DUCKOO 침낭에 꽂혀 추운 겨울 갑작스레 홀로 캠핑을 떠난 더쿠" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1464415&amp;pEtr=71009"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71009/img_slide_04.jpg" alt="#WORKING DUCKOO 드라마 속 실장님의 매력에 반해 워커홀릭을 자처한 더쿠" /></a>
								</div>
								<div class="swiper-slide">
									<a href="/shopping/category_prd.asp?itemid=1464416&amp;pEtr=71009"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71009/img_slide_05.jpg" alt="#SWIMMING DUCKOO 해양 다큐멘터리를 보고 난 뒤에는 해녀의 물질을 배운 더쿠" /></a>
								</div>
							</div>
						</div>
					</div>
					<div class="pagination"></div>
				</div>
			</div>
		</div>

		<div class="finish">
			<a href="/shopping/category_prd.asp?itemid=1488140&amp;pEtr=71009">
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71009/txt_finish.png" alt="물론 아직 뭐 하나 잘하진 못합니다. 가끔 주변에서 놀리거나 말리거나 비웃을 때도 있습니다. 그래도 좋아서 하는 일이기에 뚱한 표정 뒤로 즐거움이 가득합니다 남의 시선에서 얻는 안도가 아닌, 스스로 만든 행복이라 더 그렇습니다." /></p>
				<div class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71009/bg_finish.jpg" alt="" /></div>
			</a>
		</div>

		<div class="commentevet">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/71009/tit_comment_v2.png" alt="Hey, something project 나를 가장 닮은 더쿠" /></h3>
			<p class="hidden">내 모습을 가장 많이 닮은 더쿠는 무엇인가요? 정성껏 코멘트를 남겨주신 15분을 추첨하여 베이직 더쿠 5개 / 노트 5개 / 스티커 5개를 드립니다.(랜덤 발송)</p>

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
					<legend>Disney Pooh Tea Infuse 코멘트 쓰기</legend>
						<ul class="choice">
							<li class="ico1"><button type="button" value="1" >Basic</button></li>
							<li class="ico2"><button type="button" value="2">Being</button></li>
							<li class="ico3"><button type="button" value="3">Camping</button></li>
							<li class="ico4"><button type="button" value="4">Working</button></li>
							<li class="ico5"><button type="button" value="5">Swimming</button></li>
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
					<% If InStr(Request.ServerVariables("QUERY_STRING"), "&ecc=1") > 0 Then %>
					<% Else %>
						<input type="hidden" name="hookcode" value="&ecc=1">
					<% End If %>
				</form>
			</div>

			<div class="commentlist" id="commentlist">
				<p class="total">total <%= iCTotCnt %></p>
				<% IF isArray(arrCList) THEN %>
				<table>
					<caption>Disney Pooh Tea Infuse 코멘트 목록 - 코멘트 작성시 선택 항목, 내용, 작성일자, 아이디 정보를 제공하는 표</caption>
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
										Basic
									<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="2" Then %>
										Being
									<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="3" Then %>
										Camping
									<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="4" Then %>
										Working
									<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="5" Then %>
										Swimming
									<% Else %>
										Basic
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
								<% If arrCList(8,intCLoop) <> "W" Then %>
									<br /><img src="http://fiximage.10x10.co.kr/web2013/event/ico_mobile.png" alt="모바일에서 작성됨">
								<% end if %>
							</td>
						</tr>
						<% Next %>
					</tbody>
				</table>

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
	/* slide js */
	$("#slide01").slidesjs({
		width:"500",
		height:"500",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:2000, effect:"fade", auto:true},
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
	$("#slide02").slidesjs({
		width:"660",
		height:"560",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:2000, effect:"fade", auto:true},
		effect:{fade: {speed:700, crossfade:true}
		},
		callback: {
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

	/* animation effect */
	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 2100 ) {
			willAnimation()
		}
		if (scrollTop > 4200 ) {
			welcomeAnimation()
		}
		if (scrollTop > 7800 ) {
			finishAnimation();
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

	/* will duckoo animation */
	$(".heySomething .willDuckoo p").css({"margin-top":"10px","opacity":"0"});
	$(".heySomething .willDuckoo .mask").css({"opacity":"1"});
	function willAnimation() {
		$(".heySomething .willDuckoo p").delay(100).animate({"margin-top":"0", "opacity":"1"},500);
		$(".heySomething .willDuckoo .mask").delay(500).animate({"opacity":"0"},1000);
	}

	/* welcome duckoo animation */
	$(".heySomething .welcomeDuckoo p").css({"margin-top":"10px","opacity":"0"});
	function welcomeAnimation() {
		$(".heySomething .welcomeDuckoo p").delay(100).animate({"margin-top":"0", "opacity":"1"},500);
	}

	/* finish animation */
	$(".heySomething .finish p").css({"margin-left":"-460px", "opacity":"0"});
	function finishAnimation() {
		$(".heySomething .finish p").delay(100).animate({"margin-left":"-483px", "opacity":"1"},800);
	}
});
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->