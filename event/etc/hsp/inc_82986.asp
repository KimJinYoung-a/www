<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'###########################################################
' Description : hey, something project 시리즈 99
' 미키와 미니의 양말셋트
' History : 2017-12-12 정태훈 생성
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
	eCode   =  67491
Else
	eCode   =  82986
End If

dim userid, commentcount, i
	userid = GetEncLoginUserID()

if userid = "baboytw" or userid = "chaem35" or userid = "answjd248" or userid = "corpse2" or userid = "jinyeonmi" then
	currenttime = #12/13/2017 09:00:00#
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
/* title */
.heySomething .topic {background-color:#fdb3b6; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/82986/img_item_represent.jpg);}

/* item */
.heySomething .itemB {position:relative; width:1140px; margin:350px auto 0; padding-bottom:70px; border-bottom:1px solid #ddd; background:none;}
.heySomething .itemB .desc {width:1050px; min-height:517px; height:517px; margin:35px 0 auto; padding:0;}
.heySomething .itemB .desc .option {position:relative; top:auto; left:auto; height:468px; margin-left:40px;}
.heySomething .itemB .option a:hover {text-decoration:none;}
.heySomething .itemB .desc .name {padding-top:50px;}
.heySomething .itemB .slidewrap {position:absolute; top:0; right:0; width:493px; height:517px;}
.heySomething .itemB .slidewrap .slide {height:517px;}
.heySomething .itemB .slidewrap .slide .slidesjs-navigation {top:50%; width:28px; height:53px; margin-top:-26px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/82986/btn_slide_nav.png);}
.heySomething .itemB .slidewrap .slide .slidesjs-previous {left:20px;}
.heySomething .itemB .slidewrap .slide .slidesjs-next {left:auto; right:20px; background-position:100% 0;}

/* visual */
.heySomething .visual {position:relative; height:670px; margin-top:350px; background:#edece8 url(http://webimage.10x10.co.kr/eventIMG/2017/hey/82986/img_visual.jpg) 50% 0 no-repeat;}
.heySomething .visual p {position:absolute; top:299px; left:50%; margin-left:124px;}

/* brand */
.heySomething .brand {position:relative; height:760px; margin:350px 0 0; text-align:center;}
.heySomething .brand .btnDown {margin-top:54px;}

/* gift */
.heySomething .gift {margin-top:350px; text-align:center;}

/* story */
.heySomething .story {margin:340px 0 0;}
.heySomething .story h3 {position:absolute; top:17px; left:50%; margin-left:-480px;}
.heySomething .rollingwrap {margin-top:0;}
.heySomething .rolling {padding-top:180px;}
.heySomething .rolling .pagination {padding-left:547px;}
.heySomething .rolling .pagination span {width:90px; height:163px; margin:0 59px 0 0; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/82986/btn_paginaton_story_v2.png);}
.heySomething .rolling .pagination span.swiper-active-switch {background-position:0 100%;}
.heySomething .rolling .pagination span:first-child + span {background-position:-90px 0;}
.heySomething .rolling .pagination span:first-child + span.swiper-active-switch {background-position:-90px 100%;}
.heySomething .rolling .pagination span:first-child + span + span {background-position:-180px 0;}
.heySomething .rolling .pagination span:first-child + span + span.swiper-active-switch {background-position:-180px 100%;}
.heySomething .rolling .pagination span em {bottom:-789px; margin:0; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/82986/txt_story_desc.gif); cursor:default;}
.heySomething .rolling .btn-nav {top:445px;}
.heySomething .swipemask {top:180px;}

/* finish */
.heySomething .finish {height:850px; margin-top:386px; background:#f3f3f1 url(http://webimage.10x10.co.kr/eventIMG/2017/hey/82986/img_finish.jpg) 50% 0 no-repeat;}
.heySomething .finish p {top:341px; margin-left:-526px;}

/* comment */
.heySomething .commentevet {margin-top:400px;}
.heySomething .commentevet {padding-top:52px;}
.heySomething .commentevet textarea {margin-top:37px;}
.heySomething .commentevet .form {margin-top:30px;}
.heySomething .commentevet .form .choice {padding-left:31px;}
.heySomething .commentevet .form .choice li {width:78px; height:141px; margin-right:50px;}
.heySomething .commentevet .form .choice li button {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/82986/ico_comment_v1.png);}
.heySomething .commentevet .form .choice li.ico2 button {background-position:-78px 0;}
.heySomething .commentevet .form .choice li.ico2 button.on {background-position:-78px 100%;}
.heySomething .commentevet .form .choice li.ico3 button {background-position:-156px 0;}
.heySomething .commentevet .form .choice li.ico3 button.on {background-position:-156px 100%;}
.heySomething .commentlist table td strong {width:78px; height:141px; margin-left:31px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/hey/82986/ico_comment_v1.png); background-position:0 100%;}
.heySomething .commentlist table td .ico2 {background-position:-78px 100%;}
.heySomething .commentlist table td .ico3 {background-position:-156px 100%;}
</style>
<script type="text/javascript">
<!--
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
		<% If not( left(currenttime,10) >= "2017-12-13" and left(currenttime,10) < "2017-12-20" ) Then %>
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
//-->
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
				<div id="topic" class="topic">
					<h2>
						<span class="letter1">Hey,</span>
						<span class="letter2">something</span>
						<span class="letter3">project</span>
					</h2>
				</div>

				<!-- about -->
				<div class="about">
					<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/tit_about.png" alt="About Hey, something project" /></h3>
					<p class="hidden">텐바이텐만의 시각으로 주목해야 할 상품을 선별해 소개하고 새로운 트렌드를 제안하는 ONLY 텐바이텐만의 프로젝트</p>
				</div>
				<%
				IF application("Svr_Info") = "Dev" THEN
					itemid = 1239226
				Else
					itemid = 1855690
				End If
				set oItem = new CatePrdCls
					oItem.GetItemData itemid
				%>
				<!-- item -->
				<div class="item itemB">
					<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82986/tit_disney_tenten.gif" alt="DISNEY and 텐바이텐" /></h3>
					<div class="desc">
						<div class="option">
							<a href="/shopping/category_prd.asp?itemid=1855690&pEtr=82986">
								<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82986/txt_item_name.gif" alt="DISNEY Mickey &amp; Minnie Socks Set" /></p>
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
								<p class="substance"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82986/txt_item_desc.gif" alt="디즈니의 사랑스러운 캐릭터들을 다양한 상품들에 녹여내는 Disney Edition. 이번에는 매일 신는 양말에 귀여운 미키와 미니 커플이 나란히 사랑하는 사람과 나누어신기 좋은 미키 미니 양말을 소개합니다." /></p>
								<div class="btnget"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_get.gif" alt="구매하러 가기" /></div>
							</a>
						</div>

						<div class="slidewrap">
							<div id="slide" class="slide">
								<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82986/img_item_slide_01.jpg" alt="" /></div>
								<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82986/img_item_slide_02.jpg" alt="" /></div>
								<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82986/img_item_slide_03.jpg" alt="" /></div>
								<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82986/img_item_slide_04.jpg" alt="" /></div>
							</div>
						</div>
					</div>
				</div>
				<% Set oItem = Nothing %>

				<!-- brand -->
				<div class="visual">
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82986/txt_visual.png" alt="Hey Mickey! Oh! Mickey- you&#39;re so fine you blow my mind" /></p>
				</div>

				<!-- brand -->
				<div class="brand">
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82986/txt_brand.jpg" alt="DISNEY and 텐바이텐 크리스마스에 더욱 어울리는 커플양말 셋트, 우정양말로도 좋아요. 특별한 날 신으면 더욱 특별해 보이는 미키와 미니의 양말 셋트를 만나보세요! 산타를 기다리며 걸어두는 것도 좋겠죠?" /></p>
					<div class="btnDown"><img src="http://webimage.10x10.co.kr/eventIMG/2015/hey/common/btn_arrow_down.png" alt="" /></div>
				</div>

				<!-- gift -->
				<div class="gift">
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82986/txt_gift.jpg" alt="GIFT FOR LOVE HAPPY CHRISTMAS WITH" /></p>
				</div>

				<!-- story -->
				<div class="story">
					<div class="rollingwrap">
						<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82986/tit_story.gif" alt="크리스마스에 걸고 싶은 소원을 골라주세요!" /></h3>
						<div id="rolling" class="rolling">
							<div class="swipemask mask-left"></div>
							<div class="swipemask mask-right"></div>
							<button type="button" class="btn-nav arrow-left">Previous</button>
							<button type="button" class="btn-nav arrow-right">Next</button>
							<div class="swiper">
								<div class="swiper-container">
									<div class="swiper-wrapper">
										<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82986/img_story_slide_01.jpg" alt="#사랑 새해에는 진정한 사랑을 만나게 해주세요! 내 사람과 진정한 사랑을 하고 싶어요!" /></div>
										<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82986/img_story_slide_02.jpg" alt="#건강 새해에는 에너지 넘치는 나, 건강한 나를 만나고 싶어요!!" /></div>
										<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82986/img_story_slide_03.jpg" alt="#돈 새해에는 돈 많이 많이~ 벌게 해주세요!" /></div>
									</div>
								</div>
							</div>
							<div class="pagination"></div>
						</div>
					</div>
				</div>

				<!-- finish -->
				<div class="finish">
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82986/txt_finish.png" alt="텐바이텐의 감성과 만난 디즈니의 귀여운 미키와 미니!" /></p>
				</div>

				<!-- comment -->
				<div class="commentevet">
					<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/hey/82986/tit_comment_v1.gif" alt="Hey, something project, 크리스마스에 걸고 싶은 소원 " /></h3>
					<p class="hidden">새해에 원하는 소원 하나 골라주세요! 코멘트 써주신 분 5분을 뽑아 디즈니 양말셋트를 드립니다. 기간 : 2017. 12. 13 ~ 12. 19, 발표 : 12. 22</p>
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
									<li class="ico1"><button type="button" value="1" onfocus="this.blur();">사랑</button></li>
									<li class="ico2"><button type="button" value="2" onfocus="this.blur();">건강</button></li>
									<li class="ico3"><button type="button" value="3" onfocus="this.blur();">돈</button></li>
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
								<col style="width:160px;" />
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
										사랑
										<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="2" Then %>
										건강
										<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="3" Then %>
										돈
										<% Else %>
										사랑
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
						<% end if %>
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
	/* slide js */
	$("#slide").slidesjs({
		width:"493",
		height:"517",
		pagination:false,
		navigation:{effect:"fade"},
		play:{interval:2000, effect:"fade", auto:true},
		effect:{fade: {speed:1000, crossfade:true}}
	});

	/* swipe */
	var swiper1 = new Swiper("#rolling .swiper-container",{
		centeredSlides:true,
		slidesPerView:"auto",
		loop: true,
		speed:1500,
		autoplay:3000,
		simulateTouch:false,
		pagination:"#rolling .pagination",
		paginationClickable: true
	});
	$("#rolling .arrow-left").on("click", function(e){
		e.preventDefault()
		swiper1.swipePrev()
	});
	$("#rolling .arrow-right").on("click", function(e){
		e.preventDefault()
		swiper1.swipeNext()
	});

	$("#rolling .pagination span:nth-child(1)").append('<em class="desc1"></em>');
	$("#rolling .pagination span:nth-child(2)").append('<em class="desc2"></em>');
	$("#rolling .pagination span:nth-child(3)").append('<em class="desc3"></em>');
	$("#rolling .pagination span:nth-child(4)").append('<em class="desc4"></em>');
	$("#rolling .pagination span:nth-child(5)").append('<em class="desc5"></em>');
	$("#rolling .pagination span:nth-child(6)").append('<em class="desc6"></em>');

	$("#rolling .pagination span em").hide();
	$("#rolling .pagination .swiper-active-switch em").show();

	setInterval(function() {
		$("#rolling .pagination span em").hide();
		$("#rolling .pagination .swiper-active-switch em").show();
	}, 500);
	$("#rolling .pagination span, .btnNavigation").click(function(){
		$("#rolling .pagination span em").hide();
		$("#rolling .pagination .swiper-active-switch em").show();
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
	$("#topic h2 span").css({"opacity":"0"});
	$("#topic h2 .letter1").css({"margin-top":"7px"});
	$("#topic h2 .letter2").css({"margin-top":"15px"});
	$("#topic h2 .letter3").css({"margin-top":"23px"});
	function titleAnimation() {
		$("#topic h2 .letter1").delay(300).animate({"margin-top":"0", "opacity":"1"},800);
		$("#topic h2 .letter2").delay(700).animate({"margin-top":"7px", "opacity":"1"},800);
		$("#topic h2 .letter3").delay(1100).animate({"margin-top":"17px", "opacity":"1"},800);
	}

	/* finish animation */
	function finishAnimation() {
		var window_top = $(window).scrollTop();
		var div_top = $("#finish").offset().top-200;
		if (window_top > div_top){
			$("#finish .letter1").addClass("move1");
			$("#finish .letter2").addClass("move2");
		} else {
			$("#finish .letter1").removeClass("move1");
			$("#finish .letter2").removeClass("move2");
		}
	}
	$(function() {$(window).scroll(finishAnimation);});
});
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->