<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈 79 창가의 고양이를 위한 공간  
' History : 2017-07-18 유태욱 생성
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
'	currenttime = #05/20/2017 09:00:00#

dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  66397
Else
	eCode   =  79256
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
.heySomething .topic {text-align:center; background-color:#f6fcf0; z-index:1;}

/* item */
.heySomething .item {width:1140px; margin:0 auto;}
.heySomething .item .desc {position:relative; width:1050px; height:655px; margin:0 auto;}
.heySomething .item .desc > a {display:block; padding:200px 0 0 40px; text-decoration:none;}
.heySomething .item .option .btnget {position:static; margin-top:45px;}
.heySomething .item .slide {position:absolute; right:15px;}
.heySomething .item1 {background:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/79256/bg_dash.png) 50% 100% no-repeat;}
.heySomething .item1 .slide {top:174px; width:590px; height:330px;}
.heySomething .item2 .slide {top:130px; width:550px; height:405px;}
.heySomething .item2 .desc > a {padding-top:160px;}

/* brand */
.heySomething .brand {position:relative; height:396px; margin:370px 0 190px; text-align:center;}
.heySomething .brand .btnDown {margin-top:70px;}
.heySomething .itemStory {margin-top:280px; text-align:center;}
.heySomething .itemStory .txt {padding:115px 0 110px;}
.heySomething .itemStory iframe {vertical-align:top;}

/* story */
.heySomething .howto {padding:295px 0 420px;}
.heySomething .story {margin-top:335px; padding-bottom:120px;}
.heySomething .rolling {padding-top:205px;}
.heySomething .rolling .pagination {top:0; padding-left:153px;}
.heySomething .rolling .pagination span em {bottom:-805px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/79256/txt_desc.png); cursor:default;}
.heySomething .rolling .swiper-pagination-switch {width:150px; height:150px; margin:0 37px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/79256/bg_ico_1.png);}
.heySomething .rolling .btn-nav {top:486px;}
.heySomething .swipemask {top:205px; background-color:#000;}

.heySomething .finish {height:810px; margin-top:290px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/79256/img_finish.jpg) 50% 50% no-repeat;}

/* comment */
.heySomething .commentevet {margin-top:300px;}
.heySomething .commentevet textarea {margin-top:25px;}
.heySomething .commentevet .form {margin-top:25px;}
.heySomething .commentevet .form .choice {margin-left:-10px;}
.heySomething .commentevet .form .choice li {margin-right:4px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/79256/bg_ico_2.png);}
.heySomething .commentlist table td {padding:10px 0 10px 10px;}
.heySomething .commentlist table td strong {height:150px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/79256/bg_ico_2.png); background-position:0 0;}
.heySomething .commentlist table td .ico2 {background-position:-150px 0;}
.heySomething .commentlist table td .ico3 {background-position:-300px 0;}
</style>
<script type="text/javascript">

$(function(){
	/* slide js */
	$("#slide01").slidesjs({
		width:"316",
		height:"475",
		pagination:false,
		navigation:{effect:"fade"},
		play:{interval:1800, effect:"fade", auto:true},
		effect:{fade: {speed:800, crossfade:true}}
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
		<% If not( left(currenttime,10)>="2017-07-19" and left(currenttime,10)<"2017-08-10" ) Then %>
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
			<div class="bnr"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79256/img_item_represent.jpg" alt="창가의 고양이를 위한 공간" /></div>
		</div>

		<!-- about -->
		<div class="about">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
			<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
		</div>

		<!-- brand -->
		<div class="brand">
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79256/txt_brand.png" alt="K&amp;H는 미국의 애완동물 용품 전문업체로 그 품질과 혁신적인 디자인으로 전세계에서 각 광받고 있는 기업입니다. 또한 제품의 안전성과 더불어 수의사와 전문가들로 구성된 자문단을 운영하여 동물을 이해하고, 동물들이 좋아하는 제품을 개발하여 반려동물의 삶의 질을 향상시키는데 공헌하고 있습니다." /></p>
			<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="" /></div>
		</div>

		<!-- item(상품2개) -->
		<%
			IF application("Svr_Info") = "Dev" THEN
				itemid = 1239226
			Else
				itemid = 1721964
			End If
			set oItem = new CatePrdCls
				oItem.GetItemData itemid
		%>
		<div class="item item1">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79256/tit_knh.png" alt="K&amp;H PET PRODUCTS" /></h3>
			<div class="desc">
				<a href="/shopping/category_prd.asp?itemid=1721964&amp;pEtr=79256">
					<div class="option">
						<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79256/txt_name_1.png" alt="Window Bed Kitty Sill Green" /></p>
						<%' for dev msg : 상품코드 1721964, 할인기간 07/19 ~ 07/25 할인기간이 지나면  <strong class="discount">...</strong> 숨겨주세요 %>

						<% If oItem.FResultCount > 0 Then %>
							<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
								<div class="price">
									<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> <span>(<%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%)</span></strong>
								</div>
							<% Else %>
								<%' for dev msg : 할인 안할 경우 %>
								<div class="price priceEnd">
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								</div>
							<% End If %>
						<% End If %>
						<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러가기" /></div>
					</div>
					<div class="slide">
						<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79256/img_item1_1.jpg" alt="" />
						<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79256/img_item1_2.jpg" alt="" />
						<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79256/img_item1_3.jpg" alt="" />
						<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79256/img_item1_4.jpg" alt="" />
					</div>
				</a>
			</div>
		</div>
		<%	set oItem = nothing %>

		<%
			IF application("Svr_Info") = "Dev" THEN
				itemid = 1239226
			Else
				itemid = 1721981
			End If
			set oItem = new CatePrdCls
				oItem.GetItemData itemid
		%>
		<div class="item item2">
			<div class="desc">
				<a href="/shopping/category_prd.asp?itemid=1721981&amp;pEtr=79256">
					<div class="option">
						<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79256/txt_name_2.png" alt="Window Bubble Pod Tan" /></p>
						<%' for dev msg : 상품코드 1721981, 할인기간 07/19 ~ 07/25 할인기간이 지나면  <strong class="discount">...</strong> 숨겨주세요 %>
						<% If oItem.FResultCount > 0 Then %>
							<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
								<div class="price">
									<s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> <span>(<%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%)</span></strong>
								</div>
							<% else %>
								<!-- for dev msg : 할인 안할 경우 -->
								<div class="price priceEnd">
									<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
								</div>
							<% end if %>
						<% end if %>
						<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러가기" /></div>
					</div>
					<div class="slide">
						<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79256/img_item2_1.jpg" alt="" />
						<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79256/img_item2_2.jpg" alt="" />
						<img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79256/img_item2_3.jpg" alt="" />
					</div>
				</a>
			</div>
		</div>
		<%	set oItem = nothing %>
		<!--// item -->

		<div class="itemStory">
			<div class="video"><iframe src="https://player.vimeo.com/video/225354329" width="864" height="485" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe></div>
			<p class="txt"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79256/txt_story.png" alt="창가의 고양이를 위한 공간" /></p>
			<div class="pic"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79256/img_picture.jpg" alt="" /></div>
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
								<div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1721964&amp;pEtr=79256"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79256/img_slide_1.jpg" alt="#안식처" /></a></div>
								<div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1721981&amp;pEtr=79256"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79256/img_slide_2.jpg" alt="#하우스" /></a></div>
								<div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1721964&amp;pEtr=79256"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79256/img_slide_3.jpg" alt="#놀이터" /></a></div>
							</div>
						</div>
					</div>
					<div class="pagination"></div>
				</div>
			</div>
		</div>

		<div class="finish"></div>

		<!-- comment -->
		<div class="commentevet">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/79256/tit_comment.png" alt="Hey, something project, 윈도우베드는 고양이에게 어떤 공간이 될까요?" /></h3>
			<p class="hidden">정성껏 코멘트를 남겨주신 2분을 추첨하여 Window Bed Kitty Sill Green (1명)/ Window Bubble Pod Tan(1명)을 선물로 드립니다.</p>
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
							<li class="ico1"><button type="button" value="1">#안식처</button></li>
							<li class="ico2"><button type="button" value="2">#하우스</button></li>
							<li class="ico3"><button type="button" value="3">#놀이터</button></li>
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
										<% if isarray(split(arrCList(1,intCLoop),"!@#")) then %>
											<strong class="ico<%= split(arrCList(1,intCLoop),"!@#")(0) %>">
												<% if split(arrCList(1,intCLoop),"!@#")(0)="1" then %>
													#안식처
												<% elseif split(arrCList(1,intCLoop),"!@#")(0)="2" then %>
													#하우스
												<% elseif split(arrCList(1,intCLoop),"!@#")(0)="3" then %>
													#놀이터
												<% else %>
													#안식처
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

					<!-- paging -->
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
	$('.item1 .slide').slidesjs({
		width:570,
		height:290,
		pagination:false,
		navigation:false,
		play:{interval:1800, effect:'fade', auto:true},
		effect:{fade: {speed:1000, crossfade:true}
		}
	});
	$('.item2 .slide').slidesjs({
		width:550,
		height:405,
		pagination:false,
		navigation:false,
		play:{interval:2000, effect:'fade', auto:true},
		effect:{fade: {speed:1200, crossfade:true}
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
});
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->