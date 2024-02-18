<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈
' History : 2016-12-13 유태욱 생성
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
	eCode   =  66251
Else
	eCode   =  74912
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
.heySomething .topic {background-color:#e8e6db; z-index:1;}

/* item */
.heySomething .itemB {height:910px; padding-bottom:0; margin-top:365px; background:none;}
.heySomething .itemB .plus {position:absolute; left:50%; top:630px; margin-left:-22px;}
.heySomething .itemB a.goItem {display:block;}
.heySomething .itemB .desc {padding:90px 0 0 585px; min-height:390px;}
.heySomething .itemB .desc .option {top:98px; left:86px;}
.heySomething .itemB .option .price {margin-top:45px;}
.heySomething .itemB .option .substance {position:static; padding-top:30px;}
.heySomething .itemB .option .btnget {position:static; padding-top:40px;}
.heySomething .itemB .itemList {margin-top:130px;}
.heySomething .itemB .with {border:none; text-align:center; margin:80px 0;}
.heySomething .itemB .with ul {width:1140px; margin:0 auto;}
.heySomething .itemB .with ul li {float:left; width:150px; margin:60px 15px 0; text-align:center;}
.heySomething .itemB .with ul li .itemImg {display:block; height:170px;}
.heySomething .itemB .with ul li:nth-child(6) .itemImg img {padding-top:25px;}
.heySomething .itemB .with ul li .itemName {display:inline-block; margin-top:23px; color:#777777;}
.heySomething .itemB .with ul li strong {color:#777777;}

/* brand */
.heySomething .items {text-align:center; margin-top:480px;}
.heySomething .items ul {position:relative; width:1140px; height:675px; margin:56px auto 0;}
.heySomething .items li {position:absolute;}
.heySomething .items li a {color:transparent; cursor:pointer;}
.heySomething .items li div {width:100%; height:100%; background-position:50% 50%; background-size:120%;}
.heySomething .items li div {width:100%; height:100%; background-position:50% 50%; background-size:120%;}
.heySomething .items li.item01 {left:0; top:0; width:444px; height:443px; background-color:#fdde3a;}
.heySomething .items li.item01 div {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/74912/img_monster_01.jpg);}
.heySomething .items li.item02 {left:0; top:465px; width:444px; height:212px; background-color:#efeff0;}
.heySomething .items li.item02 div {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/74912/img_monster_02.jpg);}
.heySomething .items li.item03 {left:460px; top:0; width:446px; height:212px; background-color:#fc9a07;}
.heySomething .items li.item03 div {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/74912/img_monster_03.jpg);}
.heySomething .items li.item04 {left:460px; top:230px; width:212px; height:212px; background-color:#84d1f1;}
.heySomething .items li.item04 div {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/74912/img_monster_05.jpg);}
.heySomething .items li.item05 {left:460px; bottom:0; width:212px; height:212px; background-color:#faddc7;}
.heySomething .items li.item05 div {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/74912/img_monster_04.jpg);}
.heySomething .items li.item06 {right:0; top:0; width:212px; height:212px; background-color:#efeff0;}
.heySomething .items li.item06 div {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/74912/img_monster_06.jpg);}
.heySomething .items li.item07 {right:0; bottom:0; width:444px; height:444px; background-color:#ccf86d;}
.heySomething .items li.item07 div {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/74912/img_monster_07.jpg);}
.heySomething .brand {position:relative; height:800px; margin-top:428px;}
.heySomething .brand .text p:first-child{padding-bottom:63px;}
.heySomething .brand .pic .figure01 {position:absolute; top:172px; left:50%; margin-left:235px; }
.heySomething .brand .pic .figure02 {position:absolute; top:268px; left:50%; margin-left:-270px; }
.heySomething .brand .btnDown {margin-top:65px;}
.heySomething .itemB .slidewrap {width:442px;}
.heySomething .itemB .slidewrap .slide {width:442px; height:375px;}

/* story */
.heySomething .story {margin-top:360px; padding-bottom:120px;}
.heySomething .rolling {padding-top:230px;}
.heySomething .rolling .pagination {top:0; padding-left:80px;}
.heySomething .rolling .swiper-pagination-switch {width:157px; height:185px; margin:0 24px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/74912/bg_ico_01.png);}
.heySomething .rolling .pagination span:first-child {background-position:0 0;}
.heySomething .rolling .pagination span.swiper-active-switch {background-position:0 100%;}
.heySomething .rolling .pagination span:first-child + span {background-position:-207px 0;}
.heySomething .rolling .pagination span:first-child + span.swiper-active-switch {background-position:-207px 100%;}
.heySomething .rolling .pagination span:first-child + span + span {background-position:-415px 0;}
.heySomething .rolling .pagination span:first-child + span + span.swiper-active-switch {background-position:-415px 100%;}
.heySomething .rolling .pagination span:first-child + span + span + span {background-position:-620px 0;}
.heySomething .rolling .pagination span:first-child + span + span + span.swiper-active-switch {background-position:-620px 100%;}
.heySomething .rolling .btn-nav {top:510px;}
.heySomething .swipemask {top:230px;}
.heySomething .rolling .pagination span em {height:42px; width:745px; margin-left:180px; bottom:-754px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/74912/txt_desc_v2.png); cursor:default;}
.heySomething .rolling .pagination span .desc2 {margin-left:140px; background-position:0 -43px;}
.heySomething .rolling .pagination span .desc3 {margin-left:140px; background-position:0 -84px;}
.heySomething .rolling .pagination span .desc4 {margin-left:120px; background-position:0 -124px;}


/* finish */
.heySomething .finish {position:relative; height:712px; background:#e3dbbb url(http://webimage.10x10.co.kr/eventIMG/2016/hey/74912/bg_finish.jpg) 50% 0 no-repeat; text-indent:-999em;}
.heySomething .finish a {display:block; position:absolute; left:50%; top:0; width:1140px; height:100%; margin-left:-570px;}
.heySomething .finish p {position:absolute; width:332px; left:400px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/74912/txt_finish.png) 0 0 no-repeat;}
.heySomething .finish p.t01 {top:293px;height:19px;}
.heySomething .finish p.t02 {top:332px; width:428px; height:80px; background-position:0 100%;}

/* comment */
.heySomething .commentevet {margin-top:500px; padding-top:53px; }
.heySomething .commentevet textarea {margin-top:40px;}
.heySomething .commentevet .form {margin-top:45px;}
.heySomething .commentevet .form .choice {margin-left:-10px;}
.heySomething .commentevet .form .choice li {width:122px; height:143px; margin:0 15px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/74912/bg_ico_02.png);}
.heySomething .commentlist table td {padding:20px 0;}
.heySomething .commentlist table td strong {height:143px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/hey/74912/bg_ico_02.png); background-position:0 0;}
.heySomething .commentlist table td .ico2 {background-position:-150px 0;}
.heySomething .commentlist table td .ico3 {background-position:-300px 0;}
.heySomething .commentlist table td .ico4 {background-position:-450px 0;}

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
		<% If not( left(currenttime,10)>="2016-12-13" and left(currenttime,10)<"2016-12-20" ) Then %>
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
			<div class="bnr"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74912/img_item_represent.jpg" alt="지친 일상에 달콤함을!" /></div>
		</div>

		<!-- about -->
		<div class="about">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
			<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
		</div>

		<!-- item -->
		<div class="item itemB">
			<div class="inner">
				<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74912/txt_sweet_monster.jpg" alt="sweet monster table talk the work & life balance" /></h3>
				<a href="/shopping/category_prd.asp?itemid=1618383&amp;pEtr=74912" class="goItem">
					<div class="desc">
						<div class="option">
							<em class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74912/txt_name.png" alt="몬스터 동전지갑" /></em>
							<%'' for dev msg : 상품코드 1618383 할인기간 12/14~12/20 할인기간이 지나면 <div class="price">~</div> 를 <div class="price priceEnd">~</div>로 대체 %>
							<%
								IF application("Svr_Info") = "Dev" THEN
									itemid = 1239226
								Else
									itemid = 1618383
								End If
								set oItem = new CatePrdCls
									oItem.GetItemData itemid
							%>
							<% If oItem.FResultCount > 0 Then %>
								<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
									<div class="price">
										<% If not( left(currenttime,10)>="2016-12-14" and left(currenttime,10)<="2016-12-20" ) Then %>
										<% else %>
											<strong class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/txt_only_15percent.png" alt="단, 일주일만 ONLY 15%" /></strong>
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
							<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74912/txt_substance.png" alt="작은 위로를 줄 수 있는 달콤한 존재, 스위트몬스터! 달콤한 선물로 사람들에게 행복하고 즐거운 기분을 주는 축제를 만듭니다" /></p>
							<div class="btnget">
								<img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러 가기" />
							</div>
						</div>
						<div class="slidewrap">
							<div id="slide01" class="slide">
								<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74912/img_slide_01.png" alt="" /></div>
								<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74912/img_slide_02.png" alt="" /></div>
								<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74912/img_slide_03.png" alt="" /></div>
								<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74912/img_slide_04.png" alt="" /></div>
							</div>
						</div>
					</div>
				</a>
				<div class="with">
					<span><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/ico_plus.png" alt=""></span>
					<ul>
						<li>
							<a href="/shopping/category_prd.asp?itemid=1618385&amp;pEtr=74912">
								<span class="itemImg"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74912/img_with_item_01.jpg" alt="" /></span>
								<span class="itemName">몬스터 밀크캔디 30정</span>
								<% If not( left(currenttime,10)>="2016-12-14" and left(currenttime,10)<="2016-12-20" ) Then %>
									<strong>11,000 won</strong>
								<% else %>
									<strong>9,350 won <em style="color:red">[15%]</em> </strong>
								<% end if %>
							</a>
						</li>
						<li>
							<a href="/shopping/category_prd.asp?itemid=1618511&amp;pEtr=74912">
								<span class="itemImg"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74912/img_with_item_02.jpg" alt="" /></span>
								<span class="itemName">몬스터 젤펜 0.4</span>
								<% If not( left(currenttime,10)>="2016-12-14" and left(currenttime,10)<="2016-12-20" ) Then %>
									<strong>3,800 won</strong>
								<% else %>
									<strong>3,230 won <em style="color:red">[15%]</em> </strong> 
								<% end if %>
							</a>
						</li>
						<li>
							<a href="/shopping/category_prd.asp?itemid=1618394&amp;pEtr=74912">
								<span class="itemImg"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74912/img_with_item_03.jpg" alt="" /></span>
								<span class="itemName">몬스터 아이스크림 퍼프</span>
								<% If not( left(currenttime,10)>="2016-12-14" and left(currenttime,10)<="2016-12-20" ) Then %>
									<strong>5,000 won</strong>
								<% else %>
									<strong>4,250 won <em style="color:red">[15%]</em> </strong> 
								<% end if %>
							</a>
						</li>
						<li>
							<a href="/shopping/category_prd.asp?itemid=1618384&amp;pEtr=74912">
								<span class="itemImg"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74912/img_with_item_04.jpg" alt="" /></span>
								<span class="itemName">몬스터 밀크캔디 50정</span>
								<% If not( left(currenttime,10)>="2016-12-14" and left(currenttime,10)<="2016-12-20" ) Then %>
									<strong>6,500 won</strong>
								<% else %>
									<strong>5,520won <em style="color:red">[15%]</em> </strong> 
								<% end if %>
							</a>
						</li>
						<li>
							<a href="/shopping/category_prd.asp?itemid=1618513&amp;pEtr=74912">
								<span class="itemImg"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74912/img_with_item_05.jpg" alt="" /></span>
								<span class="itemName">몬스터 핸디 노트</span>
								<% If not( left(currenttime,10)>="2016-12-14" and left(currenttime,10)<="2016-12-20" ) Then %>
									<strong>2,400 won</strong>
								<% else %>
									<strong>2,040 won <em style="color:red">[10%]</em> </strong> 
								<% end if %>
							</a>
						</li>
						<li>
							<a href="/shopping/category_prd.asp?itemid=1618387&amp;pEtr=74912">
								<span class="itemImg"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74912/img_with_item_06.jpg" alt="" /></span>
								<span class="itemName">몬스터 밀키 에어퍼프 6종</span>
								<% If not( left(currenttime,10)>="2016-12-14" and left(currenttime,10)<="2016-12-20" ) Then %>
									<strong>2,000 won</strong>
								<% else %>
									<strong>9,350 won <em style="color:red">[15%]</em> </strong> 
								<% end if %>
							</a>
						</li>
					</ul>
				</div>
			</div>
		</div>

		<!-- items -->
		<div class="items">
			<ul>
				<li class="item01"><a href="/shopping/category_prd.asp?itemid=1618513&amp;pEtr=74912"><div></div>몬스터 핸디 노트</a></li>
				<li class="item02"><a href="/shopping/category_prd.asp?itemid=1618385&amp;pEtr=74912"><div></div>몬스터 밀크캔디</a></li>
				<li class="item03"><a href="/shopping/category_prd.asp?itemid=1618388&amp;pEtr=74912"><div></div>몬스터 원형 틴케이스&에어퍼프 세트</a></li>
				<li class="item04"><a href="/shopping/category_prd.asp?itemid=1617790&amp;pEtr=74912"><div></div>배터리 파우치</a></li>
				<li class="item05"><a href="/shopping/category_prd.asp?itemid=1618381&amp;pEtr=74912"><div></div>몬스터 롱 틴케이스</a></li>
				<li class="item06"><a href="/shopping/category_prd.asp?itemid=1617788&amp;pEtr=74912"><div></div>몬스터 파우치 (L)</a></li>
				<li class="item07"><a href="/shopping/category_prd.asp?itemid=1618509&amp;pEtr=74912"><div></div>몬스터 밀크 뮤직 토이</a></li>
			</ul>
		</div>

		<!-- brand -->
		<div class="brand">
			<a href="/event/eventmain.asp?eventid=74981">
				<div class="text">
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74912/txt_brand_name.png" alt="sweet monster Table talk" /></p>
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74912/txt_brand.png" alt="작은 위로를 줄 수 있는 달콤한 존재! 스위트몬스터! 달콤한 선물로 사람들에게 행복하고 즐거운 기분을 주는 축제를 만듭니다" /></p>
				</div>
				<div class="pic">
					<img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74912/img_monsters_v2.png" alt="" />
					<div class="figure01"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74912/img_fire_work_02.gif" alt="" /></div>
					<div class="figure02"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74912/img_fire_work.gif" alt="" /></div>
				</div>
			</a>
			<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="" /></div>
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
								<div class="swiper-slide"><a href="/event/eventmain.asp?eventid=74981"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74912/img_slide_01.jpg" alt="#ORANGE 까칠한 성격을 소유자로 헤어 스타일링과 메이크업에 관심이 많으며 사람들에게 행운을 주는 것을 즐기는 행운의 아이콘" /></a></div>
								<div class="swiper-slide"><a href="/event/eventmain.asp?eventid=74981"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74912/img_slide_02.jpg" alt="#CHOCOMON 감성적인 로맨티시스트로 사람들에게 선물하는 것을 좋아한다 듬직한 등치지만 내면은 달콤함으로 무장되어 친구들이 힘들" /></a></div>
								<div class="swiper-slide"><a href="/event/eventmain.asp?eventid=74981"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74912/img_slide_03.jpg" alt="#BLUEMON 산만한 덩치로 엉뚱한 표정, 익살스러우면서도 귀여운 면이 있다 세상에 없는 재미있는 아이스크림을 만드는 것이 취미이고 팝몬이 베스트 프렌즈이다" /></a></div>
								<div class="swiper-slide"><a href="/event/eventmain.asp?eventid=74981"><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74912/img_slide_04.jpg" alt="#COOKIEMON 항상 다른 컬러의 염색으로 녹차, 초코 등의 작은 가루의 크런치로 변신 마술이 가능하며 사람들 눈에 안 띄는 것을 즐기는 소심함을 가지고 있다" /></a></div>
							</div>
						</div>
					</div>
					<div class="pagination"></div>
				</div>
			</div>
		</div>

		<!-- finish -->
		<div class="finish">
			<a href="/event/eventmain.asp?eventid=74981">
				<p class="t01">행복하고 즐거운 기분을 주는 </p>
				<p class="t02">스위트 몬스터</p>
			</a>
		</div>

		<!-- comment -->
		<div class="commentevet">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/hey/74912/tit_commnet.png" alt="Hey, something project, 가장 달콤하게 다가오는 음식은 무엇인가요?" /></h3>
			<p class="hidden">정성껏 코멘트를 남겨주신 5분을 선정하여 달콤한 스위트 몬스터 상품을 보내 드립니다!</p>
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
							<li class="ico1"><button type="button" value="1">#ORANGEMON</button></li>
							<li class="ico2"><button type="button" value="2">#CHOCOMON</button></li>
							<li class="ico3"><button type="button" value="3">#BLUEMON</button></li>
							<li class="ico4"><button type="button" value="4">#COOKIEMON</button></li>
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
										<strong class="ico<%= split(arrCList(1,intCLoop),"!@#")(0) %>">
											<% If split(arrCList(1,intCLoop),"!@#")(0)="1" Then %>
												#ORANGEMON
											<% Elseif split(arrCList(1,intCLoop),"!@#")(0)="2" Then %>
												#CHOCOMON
											<% Elseif split(arrCList(1,intCLoop),"!@#")(0)="3" Then %>
												#BLUEMON
											<% Elseif split(arrCList(1,intCLoop),"!@#")(0)="4" Then %>
												#COOKIEMON
											<% else %>
												#ORANGEMON
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
		width:"441",
		height:"375",
		pagination:{effect:"fade"},
		navigation:false,
		play:{interval:1800, effect:"fade", auto:true},
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

	/* animation effect */
	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 2500 ) {
			featureAnimation()
		}
		if (scrollTop > 6300 ) {
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

	$(".items li div").css({"opacity":"0"});
	function featureAnimation() {
		$(".items li.item01 div").delay(100).animate({backgroundSize:"100%","opacity":"1"},900);
		$(".items li.item02 div").delay(300).animate({backgroundSize:"100%","opacity":"1"},900);
		$(".items li.item03 div").delay(200).animate({backgroundSize:"100%","opacity":"1"},900);
		$(".items li.item04 div").delay(400).animate({backgroundSize:"100%","opacity":"1"},900);
		$(".items li.item05 div").delay(300).animate({backgroundSize:"100%","opacity":"1"},900);
		$(".items li.item06 div").delay(400).animate({backgroundSize:"100%","opacity":"1"},900);
		$(".items li.item07 div").delay(300).animate({backgroundSize:"100%","opacity":"1"},900);
	}

	$(".heySomething .finish p.t01").css({"margin-left":"-10px","opacity":"0"});
	$(".heySomething .finish p.t02").css({"margin-left":"10px","opacity":"0"});
	function finishAnimation() {
		$(".heySomething .finish p").delay(100).animate({"margin-left":"0","opacity":"1"},1000);
	}
});
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->