<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  크리스마스 참여3 위시리스트 - 크리스마스 선물
' History : 2015-12-11 유태욱 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventCls.asp" -->
<!-- #include virtual="/event/etc/wishlist/wisheventCls.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<%
	dim eCode, subscriptcount, userid
	IF application("Svr_Info") = "Dev" THEN
		eCode   =  "64881"
	Else
		eCode   =  "67490"
	End If

	Dim ename, emimg, cEvent, blnitempriceyn
	set cEvent = new ClsEvtCont
	cEvent.FECode = eCode
	cEvent.fnGetEvent
	
	eCode		= cEvent.FECode	
	ename		= cEvent.FEName
	emimg		= cEvent.FEMimg
	blnitempriceyn = cEvent.FItempriceYN	

	set cEvent = nothing

	userid = getloginuserid()

	Dim ifr, page, i, y
	page = request("page")

	If page = "" Then page = 1

	set ifr = new evt_wishfolder
	ifr.FPageSize = 5
	ifr.FCurrPage = page
	ifr.FeCode = eCode

	ifr.Frectuserid = userid
	ifr.evt_wishfolder_list
%>
<style type="text/css">
/* 공통 */
img {vertical-align:top;}
.christmasCont {position:relative; width:1140px; margin:0 auto;}
.christmasHead {position:relative; height:488px; background:#d7d9db url(http://webimage.10x10.co.kr/eventIMG/2015/67495/bg_head.png) no-repeat 50% 0;}
.christmasHead .date {position:absolute; right:23px; top:22px;}
.christmasHead h2 {position:absolute; left:50%; top:211px; width:662px; height:141px; margin-left:-319px;}
.christmasHead h2 span {display:inline-block; position:absolute; z-index:50;}
.christmasHead h2 span.t01 {left:0;}
.christmasHead h2 span.t02 {left:55px;}
.christmasHead h2 span.t03 {left:134px;}
.christmasHead h2 span.t04 {left:208px;}
.christmasHead h2 span.t05 {left:251px;}
.christmasHead h2 span.t06 {left:319px;}
.christmasHead h2 span.t07 {left:363px;}
.christmasHead h2 span.t08 {left:486px;}
.christmasHead h2 span.t09 {left:561px;}
.christmasHead h2 span.deco {position:absolute; left:16px; top:-2px; width:600px; height:60px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/67495/bg_txt_snow.png) no-repeat 0 0;}
.christmasHead p {position:absolute;}
.christmasHead p.gold {left:50%; top:88px; margin-left:-155px; z-index:40;}
.christmasHead p.year {left:50%; top:180px; margin-left:-88px;}
.christmasHead p.copy {left:50%; top:355px; margin-left:-153px;}
.christmasHead p.laurel {left:50%; top:62px;  z-index:35; width:333px; height:246px; margin-left:-166px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/67495/bg_laurel.png) no-repeat 0 0;}
.christmasHead .snow {position:absolute; left:50%; top:0; z-index:20; width:2000px; height:488px; margin-left:-1000px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/67495/bg_snow.png) repeat-y 0 0;}
.christmasHead .navigator {position:absolute; left:50%; bottom:-77px; z-index:50; width:1218px; height:112px; margin-left:-609px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/67495/bg_tab.png) no-repeat 0 0;}
.christmasHead .navigator ul {padding:6px 0 0 27px;}
.christmasHead .navigator ul:after {content:' '; display:block; clear:both;}
.christmasHead .navigator li {position:relative; float:left; width:282px; height:57px;}
.christmasHead .navigator li a {display:block; width:100%; height:100%; background-position:0 0; background-repeat:no-repeat; text-indent:-9999px;}
.christmasHead .navigator li.styling a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/67495/tab_styling.png);}
.christmasHead .navigator li.party a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/67495/tab_party.png);}
.christmasHead .navigator li.present a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/67495/tab_present.png);}
.christmasHead .navigator li.enjoy a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/67495/tab_enjoy.png);}
.christmasHead .navigator li.enjoy em {display:block; position:absolute; left:115px; top:-17px; width:62px; height:47px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/67495/ico_apply.png) no-repeat 0 0; z-index:40;}
.christmasHead .navigator li.enjoy em.v2 {left:102px; width:92px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/67495/ico_apply_v2.png);}
.christmasHead .navigator li.enjoy em.v3 {left:102px; width:92px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/67495/ico_apply_v3.png);}
.christmasHead .navigator li.enjoy a:hover em {background-position:100% 0;}
.christmasHead .navigator ul li a:hover {background-position:0 -57px;}
.christmasHead .navigator ul li.current a {background-position:0 -114px;}
.christmasHead .navigator ul li.current a:after,
.christmasHead .navigator ul li a:hover:after {content:''; display:inline-block; position:absolute; left:0; top:-59px; width:282px; height:53px; }
.christmasHead .navigator ul li.current a:after  {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/67495/bg_tab_deco.png) !important;}
.christmasHead .navigator ul li a:hover:after {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/67495/bg_tab_deco_over.png);}
.christmasHead .navigator ul li.current.styling a:after,.christmasHead .navigator ul li.styling a:hover:after {height:71px; top:-77px; background-position:0 0;}
.christmasHead .navigator ul li.current.party a:after,.christmasHead .navigator ul li.party a:hover:after {background-position:0 -71px;}
.christmasHead .navigator ul li.current.present a:after,.christmasHead .navigator ul li.present a:hover:after {background-position:0 -124px;}
.christmasHead .navigator ul li.current.enjoy a:after,.christmasHead .navigator ul li.enjoy a:hover:after {background-position:0 -176px;}

/* 참여#3 */
.enjoyV3 {margin-bottom:-80px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/67490/bg_stripe.png) 0 0 repeat;}
.enjoyV3 .christmasCont {width:100%; background:#fff url(http://webimage.10x10.co.kr/eventIMG/2015/67490/bg_gradation.png) 50% 0 repeat-x;}
.enjoyV3 .christmasCont .applyEvt {background:url(http://webimage.10x10.co.kr/eventIMG/2015/67490/bg_snow.png) 0 0 repeat-y;}
.enjoyV3 .xMasWish {position:relative; left:-12px; width:1176px; padding-top:45px; margin:0 auto;}
.enjoyV3 .putMyWish {height:415px; padding:105px 180px 0; background:url(http://webimage.10x10.co.kr/eventIMG/2015/67490/bg_box.png) 0 0 no-repeat;}
.enjoyV3 .putMyWish .myFolder {position:relative; padding-bottom:3px; border-bottom:2px solid #000;}
.enjoyV3 .putMyWish .myFolder strong {font-size:13px; line-height:16px; color:#000; padding-right:5px;}
.enjoyV3 .putMyWish .myFolder .goMywish {position:absolute; right:0; top:3px; z-index:50;}
.enjoyV3 .putMyWish .putList {overflow:hidden; padding:42px 0 27px;}
.enjoyV3 .putMyWish .putList ul {overflow:hidden; width:830px; height:150px; margin-right:-16px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/67490/bg_product.png) repeat-x 0 0;}
.enjoyV3 .putMyWish .putList li {float:left; width:150px; margin-right:16px;}
.enjoyV3 .putMyWish .putList li img {width:150px; height:150px;}
.enjoyV3 .makeFolder {position:absolute; right:5px; top:13px; z-index:40; width:339px; height:596px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/67490/btn_make_folder.png) 0 0 no-repeat;}
.enjoyV3 .makeFolder a {display:block; position:absolute; left:20px; bottom:65px; width:220px; height:220px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/67490/bg_blank.png) 0 0 repeat; text-indent:-9999px;}
.makeFolder.move {-webkit-animation-name: bounce; -webkit-animation-iteration-count:3; -webkit-animation-duration:0.8s; -moz-animation-name: bounce; -moz-animation-iteration-count:3; -moz-animation-duration:0.8s; -ms-animation-name: bounce; -ms-animation-iteration-count:3; -ms-animation-duration:0.8s;}
.friendsWish {width:1066px; margin:0 auto; padding:18px 0 82px;}
.friendsWish dl {padding-bottom:70px;}
.friendsWish dt {height:32px; padding:0 52px; text-align:left; background:url(http://webimage.10x10.co.kr/eventIMG/2015/67490/bg_line.png) 0 100% repeat-x;}
.friendsWish dt span {display:inline-block; padding-left:30px; color:#000; font-size:13px; line-height:21px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/67490/ico_cart.png) 0 0 no-repeat;}
.friendsWish ul {overflow:hidden; padding:45px 26px 0;}
.friendsWish li {float:left; width:150px; padding:0 26px;}
.friendsWish li img {width:150px; height:150px;}
.friendsWish .pageMove {display:none;}
.friendsWish .pageWrapV15 {display:inline-block; background:url(http://webimage.10x10.co.kr/eventIMG/2015/67490/bg_pagination.png) 100% 0 no-repeat;}
.friendsWish .paging {display:inline-block; width:auto; height:35px; padding:6px 9px 0; background:url(http://webimage.10x10.co.kr/eventIMG/2015/67490/bg_pagination_lt.png) 0 0 no-repeat;}
.friendsWish .paging a {width:28px; height:28px; line-height:27px; border:0; background:none;}
.friendsWish .paging a.current:hover {background:none;}
.friendsWish .paging a span {color:#b58d5a;}
.friendsWish .paging a.current span {color:#000;}
.friendsWish .paging a.arrow span {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/67490/btn_pagination.png); width:28px; height:28px; padding:0;}
.friendsWish .paging a.first span {background-position:0 0;}
.friendsWish .paging a.prev span {background-position:-28px 0;}
.friendsWish .paging a.next span {background-position:-56px 0;}
.friendsWish .paging a.end span {background-position:100% 0;}
.evtNoti {overflow:hidden; width:960px; margin:0 auto; padding:72px 0 62px; text-align:left;}
.evtNoti .ftRt {padding-top:48px;}
.evtNoti ul {padding-top:25px;}
.evtNoti li {padding:0 0 9px 12px; font-size:11px; line-height:13px; color:#000; background:url(http://webimage.10x10.co.kr/eventIMG/2015/67490/blt_arrow.png) 0 2px no-repeat;}
.evtNoti li a {display:inline-block; position:relative; top:-2px;}
.evtNoti li img {vertical-align:middle;}
@-webkit-keyframes bounce {
	from, to{margin-top:0; -webkit-animation-timing-function: ease-out;}
	50% {margin-top:12px; -webkit-animation-timing-function: ease-in;}
}
@-moz-keyframes bounce {
	from, to{margin-top:0; -moz-animation-timing-function: ease-out;}
	50% {margin-top:12px; -moz-animation-timing-function: ease-in;}
}
@-ms-keyframes bounce {
	from, to{margin-top:0; -ms-animation-timing-function: ease-out;}
	50% {margin-top:12px; -ms-animation-timing-function: ease-in;}
}
</style>
<script>
function jsGoPage(iP){
	document.pageFrm.page.value = iP;
	document.pageFrm.submit();
}
<% if page>1 then %>
	$(function(){
	    var val = $('#friendsWish').offset();
	    $('html,body').animate({scrollTop:val.top},100);
	});
//	setTimeout("$('html,body',document).scrollTop(1400);", 200);
<% end if %>

$(function(){
	// titleAnimation
	$('.christmasHead p.laurel').css({"opacity":"0"});
	$('.christmasHead p.gold').css({"margin-top":"10px","opacity":"0"});
	$('.christmasHead p.year').css({"margin-top":"3px","opacity":"0"});
	$('.christmasHead h2 span').css({"opacity":"0"});
	$('.christmasHead h2 span.deco').css({"margin-top":"-3px","opacity":"0"});
	$('.christmasHead p.copy').css({"margin-top":"5px","opacity":"0"});
	function titleAnimation() {
		$('.christmasHead p.laurel').animate({"opacity":"1"},800);
		$('.christmasHead p.gold').delay(300).animate({"margin-top":"0","opacity":"1"},800);
		$('.christmasHead p.year').delay(800).animate({"margin-top":"0","opacity":"1"},800);
		$('.christmasHead h2 span.t01').delay(1500).animate({"opacity":"1"},800);
		$('.christmasHead h2 span.t02').delay(1800).animate({"opacity":"1"},800);
		$('.christmasHead h2 span.t03').delay(2100).animate({"opacity":"1"},800);
		$('.christmasHead h2 span.t04').delay(1900).animate({"opacity":"1"},800);
		$('.christmasHead h2 span.t05').delay(2300).animate({"opacity":"1"},800);
		$('.christmasHead h2 span.t06').delay(1600).animate({"opacity":"1"},800);
		$('.christmasHead h2 span.t07').delay(1700).animate({"opacity":"1"},800);
		$('.christmasHead h2 span.t08').delay(2000).animate({"opacity":"1"},800);
		$('.christmasHead h2 span.t09').delay(2200).animate({"opacity":"1"},800);
		$('.christmasHead h2 span.deco').delay(2500).animate({"margin-top":"0","opacity":"1"},1500);
		$('.christmasHead p.copy').delay(3200).animate({"margin-top":"-4px","opacity":"1"},500).animate({"margin-top":"0"},500);
	}
	titleAnimation();
	function moveIcon () {
		$(".enjoy em").animate({"margin-top":"0"},500).animate({"margin-top":"3px"},500, moveIcon);
	}
	moveIcon();
/*
	$('.makeFolder a').mouseover(function() {
		$(this).parent('.makeFolder').addClass('move');
	});
	$('.makeFolder a').mouseleave(function() {
		$(this).parent('.makeFolder').removeClass('move');
	});
*/
});
/* snow */
var scrollSpeed =40;
var current = 0;
var direction = 'h';
function bgscroll(){
	current -= -1;
	$('.snow').css("backgroundPosition", (direction == 'h') ? "0 " + current+"px" : current+"px 0");
}
function bgscroll2(){
	current -= -1;
	$('.applyEvt').css("backgroundPosition", (direction == 'h') ? "0 " + current+"px" : current+"px 0");
}
setInterval("bgscroll()", scrollSpeed);
setInterval("bgscroll2()", scrollSpeed);

function jsSubmit()
{
	<% If IsUserLoginOK() Then %>
		<% If Now() > #12/20/2015 23:59:59# Then %>
			alert("이벤트가 종료되었습니다.");
			return;
		<% Else %>
			<% If date() >= "2015-12-14" and date() < "2015-12-21" Then %>
				var frm = document.frm;
				frm.action="/event/etc/wishlist/wishfolderProc.asp";
				frm.hidM.value='I';
				frm.submit();
			<% else %>
				alert("이벤트 응모 기간이 아닙니다.");
				return;
			<% end if %>
		<% end if %>
	<% else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return;
		}
	<% end if %>
}
</script>
<%
Dim sp, spitemid, spimg
Dim arrCnt, foldername

	foldername = "크리스마스 선물"
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
</script>
<form name="frm" method="post">
<input type="hidden" name="hidM" value="I">
<input type="hidden" name="foldername" value="<%=foldername%>">
<input type="hidden" name="eventid" value="<%=eCode%>">
	<div class="contF contW">
		<div class="christmas2015">
			<div class="christmasHead">
				<div class="christmasCont">
					<p class="date"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67495/txt_date.png" alt="2015.11.23~12.25" /></p>
					<p class="gold"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67495/tit_gold_magic.png" alt="GOLD MAGIC" /></p>
					<p class="laurel"></p>
					<p class="year"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67495/tit_2015.png" alt="2015" /></p>
					<h2>
						<a href="/event/eventmain.asp?eventid=67483">
							<span class="t01"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67495/tit_christmas_c.png" alt="C" /></span>
							<span class="t02"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67495/tit_christmas_h.png" alt="H" /></span>
							<span class="t03"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67495/tit_christmas_r.png" alt="R" /></span>
							<span class="t04"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67495/tit_christmas_i.png" alt="I" /></span>
							<span class="t05"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67495/tit_christmas_s.png" alt="S" /></span>
							<span class="t06"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67495/tit_christmas_t.png" alt="T" /></span>
							<span class="t07"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67495/tit_christmas_m.png" alt="M" /></span>
							<span class="t08"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67495/tit_christmas_a.png" alt="A" /></span>
							<span class="t09"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67495/tit_christmas_s.png" alt="S" /></span>
							<span class="deco"></span>
						</a>
					</h2>
					<p class="copy"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67495/txt_copy.png" alt="품격있는 컬러로 완성하는 크리스마스 데커레이션" /></p>
				</div>
				<div class="navigator">
					<ul>
						<li class="styling"><a href="/event/eventmain.asp?eventid=67483">CHRISTMAS STYLING</a></li>
						<li class="party"><a href="/event/eventmain.asp?eventid=67485">MAKE PARTY</a></li>
						<li class="present"><a href="/event/eventmain.asp?eventid=67487">SPECIAL PRESENT</a></li>
						<li class="enjoy current"><a href="" onclick="return false;">EVJOY TOGETHER<em class="v3">참여</em></a></li>
					</ul>
				</div>
				<div class="snow"></div>
			</div>

			<%''// 참여이벤트 #3 %>
			<div class="enjoyTogether">
				<div class="enjoyV3">
					<div class="christmasCont">
						<div class="applyEvt">
							<div class="xMasWish">
								<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/67490/tit_santa.png" alt="텐바이텐이 여러분의 산타가 되어드려요" /></h3>
								<% If IsUserLoginOK() Then %>
									<% if vCount > 0 then %>
										<div class="putMyWish">
											<div class="myFolder">
												<strong><%= userid %></strong><img src="http://webimage.10x10.co.kr/eventIMG/2015/67490/txt_folder.png" alt="님의 [크리스마스 선물] 위시 폴더" />
												<a href="/my10x10/mywishlist.asp" target="_top" class="goMywish"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67490/btn_my_wish.png" alt="나의 위시 보러가기" /></a>
											</div>
											<div class="putList">
												<ul>
												<% if ifr.FmyTotalCount > 0 then %>
													<%
														if isarray(Split(ifr.Fmylist,",")) then
															arrCnt = Ubound(Split(ifr.Fmylist,","))
														else
															arrCnt=0
														end if
							
														If ifr.FmyTotalCount > 4 Then
															arrCnt = 5
														Else
															arrCnt = ifr.FmyTotalCount
														End IF
							
														For y = 0 to CInt(arrCnt) - 1
															sp = Split(ifr.Fmylist,",")(y)
															spitemid = Split(sp,"|")(0)
															spimg	 = Split(sp,"|")(1)
													%>
													<li><a href="<%=wwwURL%>/<%=spitemid%>" target="_top"><img src="http://webimage.10x10.co.kr/image/icon2/<%=GetImageSubFolderByItemid(spitemid)%>/<%=spimg%>" /></a></li>
													<%
														Next
													%>
												<% end if %>
												</ul>
											</div>
											<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/67490/txt_tip.png" alt="최소 5개 이상의 상품을 담아주셔야 당첨이 됩니다." /></p>
										</div>
									<% else %>
										<div><img src="http://webimage.10x10.co.kr/eventIMG/2015/67490/txt_process.png" alt="이벤트 참여 방법" /></div>
									<% end if %>
								<% else %>
									<div><img src="http://webimage.10x10.co.kr/eventIMG/2015/67490/txt_process.png" alt="이벤트 참여 방법" /></div>
								<% end if %>
								<div class="makeFolder">
									<a href="" onclick="jsSubmit(); return false;">위시폴더 만들고 이벤트 참여하기</a>
								</div>
							</div>
						</div>
						<%''// 친구들 위시보기 %>
						<% If ifr.FResultCount > 0 Then %>
							<div class="friendsWish" id="friendsWish">
								<% For i = 0 to ifr.FResultCount -1 %>
									<dl>
										<dt><span><strong><%=printUserId(ifr.FList(i).FUserid,2,"*")%></strong>의 위시리스트</span></dt>
										<dd>
											<ul>
											<%
												if isarray(Split(ifr.FList(i).FArrIcon2Img,",")) then
													arrCnt = Ubound(Split(ifr.FList(i).FArrIcon2Img,","))
												else
													arrCnt=0
												end if
						
												If ifr.FList(i).FCnt > 4 Then
													arrCnt = 5
												Else
													arrCnt = ifr.FList(i).FCnt
												End IF
						
												For y = 0 to CInt(arrCnt) - 1
													sp = Split(ifr.FList(i).FArrIcon2Img,",")(y)
													spitemid = Split(sp,"|")(0)
													spimg	 = Split(sp,"|")(1)
											%>
												<li><a href="<%=wwwURL%>/<%=spitemid%>"><img src="http://webimage.10x10.co.kr/image/icon2/<%=GetImageSubFolderByItemid(spitemid)%>/<%=spimg%>" alt="" /></a></li>
											<% 
												next
											%>
											</ul>
										</dd>
									</dl>
								<% next %>
								<div class="pageWrapV15 tMar10">
									<%= fnDisplayPaging_New(page,ifr.FTotalCount,5,10,"jsGoPage") %>
								</div>
							</div>
						<% end if %>
					</div>
					<div class="evtNoti">
						<div class="ftLt">
							<h4><img src="http://webimage.10x10.co.kr/eventIMG/2015/67490/tit_noti.png" alt="유의사항은 꼭 읽어주세요!" /></h4>
							<ul>
								<li>본 이벤트에서 <a href="" onclick="return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67490/btn_apply.png" alt="참여하기" /></a> 를 클릭하셔야만 이벤트 참여가 가능합니다.</li>
								<li><a href="" onclick="return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67490/btn_apply.png" alt="참여하기" /></a> 클릭 시 위시리스트에 &lt;크리스마스 선물&gt; 폴더가 자동 생성됩니다.</li>
								<li>수동으로 생성하시거나 기존에 있던 폴더의 이름을 수정하면 이벤트 참여가 불가합니다.</li>
								<li>위시리스트에 &lt;크리스마스 선물&gt; 폴더는 한 ID당 1개만 생성이 가능합니다.</li>
								<li>해당 폴더에 5개 이상의 상품, 총 금액이 50만원 이상이 되도록 넣어주세요.</li>
								<li>당첨되는 고객께는 &lt;텐바이텐 기프트카드 10만원권&gt;을 드릴 예정입니다.</li>
								<li>해당 폴더 외 다른 폴더에 담으시는 상품은 이벤트 응모와는 무관 합니다.</li>
								<li>당첨되는 고객께는 개인정보 확인 후에 경품이 지급됩니다.</li>
								<li>본 이벤트는 12월20일 23시59분까지 담겨진 상품을 기준으로 선정합니다.</li>
								<li>위시리스트 속 상품은 최근 5개만 보여집니다.</li>
								<li>당첨자 안내는 12월21일에 공지사항을 통해 진행 됩니다.</li>
							</ul>
						</div>
						<div class="ftRt">
							<div><img src="http://webimage.10x10.co.kr/eventIMG/2015/67490/img_wish_ex.png" alt="" /></div>
						</div>
					</div>
				</div>
			</div>
			<%''//참여이벤트 #3 %>
		</div>
	</div>
</form>
<form name="pageFrm" method="get" action="<%=CurrURL()%>">
	<input type="hidden" name="eventid" value="<%=eCode%>">
<input type="hidden" name="page" value="">
</form>
<!-- #include virtual="/lib/db/dbclose.asp" -->
