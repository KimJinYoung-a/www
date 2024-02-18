<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  위시리스트 - 오 마이 달님
' History : 2016-09-08 유태욱 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventCls.asp" -->
<!-- #include virtual="/event/etc/wishlist/wisheventCls.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<%
Dim eCode, subscriptcount, userid
Dim currenttime, systemok
IF application("Svr_Info") = "Dev" THEN
	eCode   =  "66197"
Else
	eCode   =  "72959"
End If

currenttime = now()
'															currenttime = #05/20/2016 10:05:00#

Dim ename, emimg, cEvent, blnitempriceyn, vreturnurl
vreturnurl = Request.ServerVariables("url") &"?"&Request.ServerVariables("QUERY_STRING")

Set cEvent = new ClsEvtCont
	cEvent.FECode = eCode
	cEvent.fnGetEvent
	
	eCode		= cEvent.FECode	
	ename		= cEvent.FEName
	emimg		= cEvent.FEMimg
	blnitempriceyn = cEvent.FItempriceYN	
Set cEvent = nothing
userid = GetEncLoginUserID()

Dim ifr, page, i, y
page = request("page")

If page = "" Then page = 1

Set ifr = new evt_wishfolder
	ifr.FPageSize	= 4
	ifr.FCurrPage	= page
	ifr.FeCode		= eCode
	ifr.Frectuserid = userid
	ifr.evt_wishfolder_list		'메인디비
'	ifr.evt_wishfolder_list_B	'캐쉬디비

Dim sp, spitemid, spimg
Dim arrCnt, foldername

	foldername = "달님♥"
	
	''응모 차단시 X로 변경
		'systemok="X"
		systemok="O"

	if left(currenttime,10)<"2016-09-12" then
		systemok="X"
		if userid = "baboytw" or userid = "greenteenz" or userid = "cogusdk" or userid = "jinyeonmi" then
			systemok="O"
		end if
	end if

	Dim strSql, vCount, vFolderName, vViewIsUsing
	vCount = 0

	strSql = "Select COUNT(fidx) From [db_my10x10].[dbo].[tbl_myfavorite_folder]  WHERE foldername = '" & trim(foldername) & "' and userid='" & userid & "' "
	'response.write strSql
	rsget.Open strSql,dbget,1
	IF Not rsget.Eof Then
		vCount = rsget(0)
	else
		vCount = 0
	END IF
	rsget.Close
%>
<style type="text/css">
img {vertical-align:top;}

.ohmyDalnim {background-color:#fff;}
.ohmyDalnim button {background-color:transparent;}

.ohmyDalnim .wish {position:relative; height:1140px; background:#2c0058 url(http://webimage.10x10.co.kr/eventIMG/2016/72959/bg_sky.jpg) no-repeat 0 0;}
.ohmyDalnim .wish .star {position:absolute; top:0; left:0;}
.ohmyDalnim .wish h2 {overflow:hidden; position:absolute; top:148px; left:314px; width:552px; height:127px;}
.ohmyDalnim .wish h2 span {position:absolute; top:0; left:0; width:84px; height:127px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/72959/tit_oh_my_dalnim.png); text-indent:-9999em;}
.ohmyDalnim .wish h2 .letter2 {left:121px; width:161px; background-position:-121px 0;}
.ohmyDalnim .wish h2 .letter3 {left:323px; width:152px; background-position:-323px 0;}
.ohmyDalnim .wish h2 .letter4 {left:493px; width:59px; background-position:-493px 0;}
.shake {animation-name:shake; animation-iteration-count:5; animation-duration:4s;}
@keyframes shake {
	from, to{ margin-left:-5px; animation-timing-function:ease-out;}
	50% {margin-left:0; animation-timing-function:ease-in;}
}

.ohmyDalnim .wish .subcopy {position:absolute; top:102px; left:50%; margin-left:-225px;}
.ohmyDalnim .wish .guide {position:absolute; bottom:87px; left:177px;}
.ohmyDalnim .wish .btnMake {position:absolute; top:393px; left:50%; width:474px; height:474px; margin-left:-237px;}
.updown {animation-name:updown; animation-iteration-count:infinite; animation-duration:1.5s;}
@keyframes updown {
	from, to {margin-top:0; animation-timing-function:linear;}
	50% {margin-top:5px; animation-timing-function:linear;}
}
.ohmyDalnim .wish .btnMake:hover {animation-play-state:paused;}

.ohmyDalnim .wish .btnMake .light {position:absolute; top:0; left:0; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2016/72959/img_light.png) no-repeat 50% 50%;}
.ohmyDalnim .wish .btnMake .word {position:absolute; left:0; top:-10px;}
.painting {animation-name:painting; animation-duration:3s; animation-fill-mode:both; animation-direction:alternate; animation-play-state:running; animation-iteration-count:infinite;}
@keyframes painting {
	0% {opacity:0; background-size:70% 70%;}
	100% {opacity:1; background-size:100% 100%;}
}

.myWishList {position:absolute; top:456px; left:50%; width:899px; height:320px; margin-left:-449px; padding-top:34px; background:#6c23b6 url(http://webimage.10x10.co.kr/eventIMG/2016/72959/bg_no_image_v1.png) no-repeat 50% 50%;}
.myWishList h3, .myWishList .total {color:#fef168; font-family:'Dotum', '돋움'; font-size:15px;}
.myWishList ul {overflow:hidden; position:absolute; top:95px; left:70px;}
.myWishList ul li {float:left; margin-right:10px;}
.myWishList ul li a {display:block; position:relative;}
.myWishList ul li a span { position:absolute; top:0; left:0; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2016/72959/bg_mask_purple.png) no-repeat 0 0; cursor:pointer;}
.myWishList .total {margin-top:240px; font-size:34px; line-height:30px; text-align:center;}
.myWishList .btnMore {position:absolute; top:111px; right:68px;}

.noti {position:relative; padding:45px 0 44px; background-color:#eee; text-align:left;}
.noti h3 {position:absolute; top:50%; left:100px; margin-top:-35px;}
.noti ul {margin-left:271px; padding-left:45px; border-left:1px solid #fff;}
.noti ul li {position:relative; margin-top:7px; padding-left:10px; color:#707384; font-family:'Gulim', '굴림', 'Verdana'; font-size:12px; line-height:1.5em;}
.noti ul li:first-child {margin-top:0;}
.noti ul li span {position:absolute; top:7px; left:0; width:5px; height:1px; background-color:#707384;}

.ohmyDalnim .wishList .item {width:978px; margin:-1px auto 0; padding-top:46px; border-top:1px solid #ebebeb;}
.ohmyDalnim .wishList .item h4 {padding-left:34px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/72959/ico_heart.png) no-repeat 6px 0; color:#717171; font-weight:normal; text-align:left;}
.ohmyDalnim .wishList .item h4 b {font-weight:bold;}
.ohmyDalnim .wishList .item ul {overflow:hidden; width:1042px; margin:33px -16px 0; padding-bottom:42px;}
.ohmyDalnim .wishList .item ul li {float:left; padding:0 26px;}
.ohmyDalnim .wishList .item ul li a {overflow:hidden; display:block; border:1px solid #e7e7e7; border-radius:50%;}
.ohmyDalnim .wishList .item ul li img {border-radius:50%;}

/* paging */
.pageWrapV15 {margin-top:49px;}
.pageWrapV15 .pageMove {display:none;}
.paging {height:29px;}
.paging a {height:29px; border:0;}
.paging a:hover, .paging a.arrow, .paging a, .paging a.current, .paging a.current:hover {border:0; background-color:transparent;}
.paging a span {height:29px; color:#c6c6c6; font-family:'Dotum', '돋움'; line-height:29px;}
.paging a.current span {color:#ff8383;}
.paging a.arrow span {width:29px; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2016/72959/btn_pagination.png) no-repeat 0 0;}
.paging a.next span {background-position:0 -29px;}
.paging a.first span {background-position:0 -58px;}
.paging a.end span {background-position:0 100%;}
.paging a.prev {margin-right:5px;}
.paging a.next {margin-left:5px;}

.twinkle {animation-name:twinkle; animation-iteration-count:infinite; animation-duration:2.5s; animation-fill-mode:both;}
@keyframes twinkle {
	0% {opacity:0;}
	100% {opacity:1;}
}
</style>
<script type="text/javascript">
$(function(){	
	/* title animation */
	animation();
	$("#animation span").css({"opacity":"0"});
	$("#animation .letter2, #animation .letter3").css({"margin-top":"10px"});
	$("#animation .letter1").css({"margin-top":"30px"});
	function animation () {
		$("#animation .letter1").delay(0).animate({"margin-top":"0", "opacity":"1"},700);
		$("#animation .letter2").delay(500).animate({"margin-top":"0", "opacity":"1"},700);
		$("#animation .letter3").delay(900).animate({"margin-top":"0", "opacity":"1"},700);
		$("#animation .letter4").delay(1300).animate({"margin-top":"0", "opacity":"1"},700);
	}
});

function jsGoPage(iP){
	document.pageFrm.page.value = iP;
	document.pageFrm.submit();
}

function jsSubmit()
{
<% if systemok="X" then %>
	alert("이벤트 응모 기간이 아닙니다.");
	return;
<% else %>
	<% If IsUserLoginOK() Then %>
		<% If Now() > #09/25/2016 23:59:59# Then %>
			alert("이벤트가 종료되었습니다.");
			return;
		<% Else %>
			<% If Now() > #09/08/2016 00:00:00# and Now() < #09/25/2016 23:59:59# Then %>
				var frm = document.frm;
				frm.action ="/event/etc/wishlist/wishfolderProc.asp";
				frm.hidM.value ='I';
				frm.submit();
			<% Else %>
				alert("이벤트 응모 기간이 아닙니다.");
				return;
			<% End If %>
		<% End If %>
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return;
		}
	<% End If %>
<% end if %>
}

</script>

<form name="frm" method="post">
<input type="hidden" name="hidM" value="I">
<input type="hidden" name="foldername" value="<%=foldername%>">
<input type="hidden" name="eventid" value="<%=eCode%>">
<input type="hidden" name="returnurl" value="<%=vreturnurl%>">
	<!-- [W] 72959 위시이벤트 - 오 마이 달님 -->
	<div class="evt72959 ohmyDalnim">
		<div class="wish">
			<div class="star twinkle"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72959/img_star.png" alt="" /></div>
			<h2 id="animation">
				<span class="letter1">오,</span>
				<span class="letter2">마이</span>
				<span class="letter3">달님</span>
				<span class="letter4 shake"></span>
			</h2>
			<p class="subcopy"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72959/txt_oh_my_dalnim_v1.png" alt="이번 추석에는 소원을 들어주세요 달님에게 갖고 싶었던 소원을 담아보세요! 추첨을 통해 총 20분에게 기프트카드 1만원권을 드립니다! 당첨자발표는 2016년 9월 20일 화요일입니다." /></p>

			<p class="guide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72959/txt_event_guide.png" alt="이벤트 참여 방법은 본 이벤트를 통해서 달님&hearts; 위시폴더 만들고 이벤트 참여하기 버튼을 클릭하면 달님&hearts; 폴더를 자동 생성 됩니다. 원하는 상품의 상세페이지에서 위시아이콘을 클릭, 달님&hearts;폴더에 여러분의 위시 상품을 5개 이상 담아주세요!" /></p>

			<% if vCount < 1 then %>
				<!-- for dev msg : 달님폴더 생성 전, 클릭 후 숨겨주세요 -->
				<button type="button" onclick="jsSubmit(); return false;" class="btnMake updown">
					<span class="light painting"></span>
					<span class="word" ><img src="http://webimage.10x10.co.kr/eventIMG/2016/72959/btn_make_v1.png"  alt="달님&hearts; 위시폴더 만들고 이벤트 참여하기" /></span>
				</button>
			<% else %>
				<!-- for dev msg : 달님폴더 생성 후 -->
				<div class="myWishList">
					<h3><%= userid %> 님의 [달님&hearts;] 위시폴더</h3>
					<ul>
					<% if ifr.FmyTotalCount > 0 then %>
					<%
						if isarray(Split(ifr.Fmylist,",")) then
							arrCnt = Ubound(Split(ifr.Fmylist,","))
						else
							arrCnt=0
						end if
	
						If ifr.FmyTotalCount > 3 Then
							arrCnt = 4
						Else
							arrCnt = ifr.FmyTotalCount
						End If
						
						Dim totcash : totcash = 0 '//합계금액
						For y = 0 to cint(ifr.FmyTotalCount) - 1
							sp = Split(ifr.Fmylist,",")(y)
							totcash  = totcash + Split(sp,"|")(2)
						next
	
						For y = 0 to CInt(arrCnt) - 1
							sp = Split(ifr.Fmylist,",")(y)
							spitemid = Split(sp,"|")(0)
							spimg	 = Split(sp,"|")(1)
					%>
						<li><a href="<%=wwwURL%>/<%=spitemid%>" target="_top"><img src="http://webimage.10x10.co.kr/image/icon2/<%=GetImageSubFolderByItemid(spitemid)%>/<%=spimg%>" width="142" height="142" alt="" /><span></span></a></li>
					<%
						Next
					%>
					<% end if %>
					</ul>
					<div class="btnMore"><a href="/my10x10/mywishlist.asp"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72959/btn_more.png" alt="그 이외 상품 확인하러 가기" /></a></div>
					<div class="total">
						<img src="http://webimage.10x10.co.kr/eventIMG/2016/72959/txt_total_01.png" alt="현재 합계금액" />
						<b><%=FormatNumber(totcash,0)%></b>
						<img src="http://webimage.10x10.co.kr/eventIMG/2016/72959/txt_total_02.png" alt="원" />
					</div>
				</div>
			<% end if %>
		</div>

		<div class="noti">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/72959/tit_noti.png" alt="이벤트 유의사항" /></h3>
			<ul>
				<li><span></span>본 이벤트에서 참여하기를 클릭하셔야만 이벤트 참여가 가능합니다.</li>
				<li><span></span>참여하기 클릭 시, 위시리스트에 &lt;달님&hearts;&gt; 폴더가 자동 생성됩니다.</li>
				<li><span></span>수동으로 생성하시거나 기존에 있던 폴더의 이름을 수정하면 이벤트 참여가 불가합니다.</li>
				<li><span></span>위시리스트에 &lt;달님&hearts;&gt; 폴더는 한 ID당 1개만 생성이 가능합니다.</li>
				<li><span></span>해당 폴더에 5개 이상의 상품이 되도록 넣어주세요.</li>
				<li><span></span>해당 폴더 외에 다른 폴더에 담으시는 상품은 이벤트 응모와는 무관 합니다.</li>
				<li><span></span>당첨자에 한 해 개인정보를 요청하게 되며, 개인정보 확인 후 경품이 지금 됩니다.</li>
				<li><span></span>본 이벤트는 9월 19일 23시 59분 59초 까지 담겨진 상품을 기준으로 선정합니다.</li>
				<li><span></span>위시리스트 속 상품은 최근 5개만 보여집니다.</li>
				<li><span></span>당첨자 안내는 9월 20일에 공지사항을 통해 진행됩니다.</li>
			</ul>
		</div>

		<% If ifr.FResultCount > 0 Then %>
			<div class="wishList">
				<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/72959/tit_wish_list.png" alt="다른 친구들의 소원을 확인해보세요!" /></h3>
				<div class="itemList">
					<% For i = 0 to ifr.FResultCount -1 %>
						<div class="item">
							<h4><b><%=printUserId(ifr.FList(i).FUserid,2,"*")%></b> 님의 위시리스트</h4>
							<ul>
							<%
								arrCnt=0
								if ifr.FList(i).FArrIcon2Img<>"" and not(isnull(ifr.FList(i).FArrIcon2Img)) then
									if isarray(Split(ifr.FList(i).FArrIcon2Img,",")) then
										arrCnt = Ubound(Split(ifr.FList(i).FArrIcon2Img,","))
									end if
								end if
		
								If ifr.FList(i).FCnt > 4 Then
									arrCnt = 5
								Else
									arrCnt = ifr.FList(i).FCnt
								End IF
		
								For y = 0 to CInt(arrCnt) - 1
									if ifr.FList(i).FArrIcon2Img<>"" and not(isnull(ifr.FList(i).FArrIcon2Img)) then
										if isarray(Split(ifr.FList(i).FArrIcon2Img,",")) then
											sp = Split(ifr.FList(i).FArrIcon2Img,",")(y)
		
											if isarray(Split(sp,"|")) then
												spitemid = Split(sp,"|")(0)
												spimg	 = Split(sp,"|")(1)
											end if
										end if
									end if
							%>
								<li><a href="<%=wwwURL%>/<%=spitemid%>" target="_top"><img src="http://webimage.10x10.co.kr/image/icon2/<%= GetImageSubFolderByItemid(spitemid) %>/<%= spimg %>" width="150" height="150" alt="" /></a></li>
							<%	Next %>
							</ul>
						</div>
					<% next %>
				</div>
	
				<!-- paging -->
				<div class="pageWrapV15 tMar20">
					<%= fnDisplayPaging_New(page,ifr.FTotalCount,4,10,"jsGoPage") %>
				</div>
			</div>
		<% end if %>
	</div>
</form>
<form name="pageFrm" method="get" action="<%=CurrURL()%>">
	<input type="hidden" name="eventid" value="<%=eCode%>">
	<input type="hidden" name="ICC" value="<%= page %>">
<input type="hidden" name="page" value="">
</form>
<% Set ifr = nothing %>
<script type="text/javascript">
<% if Request("iCC") <> "" then %>
	$(function(){
		window.$('html,body').animate({scrollTop:$(".friendsWish").offset().top}, 0);
	});
<% end if %>
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->