<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  위시리스트 - 산타의 위시
' History : 2016-11-18 김진영 생성
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
<%
If Date() >= "2016-12-19"  Then				'12/19일에는 마일리지 이벤트로 강제 이동
	response.redirect("/event/eventmain.asp?eventid=74320")
End If

Dim eCode, subscriptcount, userid
Dim currenttime, systemok
IF application("Svr_Info") = "Dev" THEN
	eCode = "66238"
Else
	eCode = "74319"
End If
currenttime = date()

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
foldername = "산타의 WISH"

''응모 차단시 X로 변경
'systemok="X"
systemok="O"
If currenttime <= "2016-11-20" Then
	systemok="X"
	If userid = "kjy8517" or userid = "greenteenz" or userid = "jinyeonmi" or userid = "jj999a" or userid = "helele223" or userid = "photobyjeon" Then
		systemok="O"
	End if
End If

Dim strSql, vCount, vFolderName, vViewIsUsing
vCount = 0
strSql = "Select COUNT(fidx) From [db_my10x10].[dbo].[tbl_myfavorite_folder]  WHERE foldername = '" & trim(foldername) & "' and userid='" & userid & "' "
'response.write strSql
rsget.Open strSql,dbget,1
If Not rsget.Eof Then
	vCount = rsget(0)
Else
	vCount = 0
End If
rsget.Close

'// Facebook 오픈그래프 메타태그 작성
strHeaderAddMetaTag = "<meta property=""og:title"" content=""[텐바이텐] 산타의 WISH"" />" & vbCrLf &_
					"<meta property=""og:type"" content=""website"" />" & vbCrLf &_
					"<meta property=""og:url"" content=""http://www.10x10.co.kr/event/eventmain.asp?eventid=74319"" />" & vbCrLf
strPageImage =  "http://webimage.10x10.co.kr/eventIMG/2016/74319/m/img_kakao.jpg"
strPageTitle = "[텐바이텐] 산타의 WISH"
strPageKeyword = "[텐바이텐] 산타의 WISH"
strPageDesc = "크리스마스에 꼭 사고 싶은 선물을 위시리스트에 담아주세요!텐바이텐이 산타가 되어 선물을 드립니다!"

'// 쇼셜서비스로 글보내기 (2010.07.21; 허진원)
Dim vTitle, vLink, vPre, vImg
Dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
snpTitle	= Server.URLEncode("[텐바이텐] 산타의 WISH")
snpLink		= Server.URLEncode("http://www.10x10.co.kr/event/eventmain.asp?eventid=74319")
snpPre		= Server.URLEncode("10x10 WISH 이벤트")
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
/* christmas common */
img {vertical-align:top;}

.christmas {background-color:#fff;}
.christmas .head {overflow:hidden; position:relative; height:488px; background-color:#424444;}
.christmas .head .bg {position:absolute; top:0; left:0; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2016/74312/bg_light_01.png) no-repeat 50% 0;}
.christmas .head .light2 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/74312/bg_light_02.png);}
.christmas .head .star {background:url(http://webimage.10x10.co.kr/eventIMG/2016/74312/bg_star.png) no-repeat 50% 0;}
.christmas .head .light1 {animation-name:twinkle; animation-iteration-count:infinite; animation-duration:4s; animation-fill-mode:both; animation-delay:2s;}
.christmas .head .light2 {animation-name:twinkle; animation-iteration-count:infinite; animation-duration:4s; animation-fill-mode:both;}

.christmas .head .star {animation-name:twinkle2; animation-iteration-count:infinite; animation-duration:3s; animation-fill-mode:both;}
.christmas .head .inner {width:1140px; margin:0 auto;}
.christmas .head .hgroup {position:relative; height:388px; padding-top:35px;}
.christmas .head .hgroup .title {width:585px; margin:0 auto; padding-left:30px;}
.christmas .head .hgroup h2 {position:relative; width:585px; height:240px; margin:0 auto;}
.christmas .head .hgroup h2 span {display:block; position:absolute;}
.christmas .head .hgroup h2 .letter,
.christmas .head .hgroup h2 .year { width:50px; height:54px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/74312/tit_christmas.png) no-repeat -246px 0; text-indent:-999em;}
.christmas .head .hgroup h2 .letter1 {top:0; left:246px;}
.christmas .head .hgroup h2 .letter2 {top:74px; left:163px; width:212px; height:17px; background-position:-163px -64px;}
.christmas .head .hgroup h2 .letter3 {bottom:2px; left:0; width:585px; height:148px; background-position:50% -80px;}
.christmas .head .hgroup h2 .year {top:228px; left:195px; width:12px; height:22px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/74312/tit_christmas_2016.png) no-repeat 0 0;}
.christmas .head .hgroup h2 .year2 {left:242px; background-position:-47px 0;}
.christmas .head .hgroup h2 .year3 {left:289px; background-position:-94px 0;}
.christmas .head .hgroup h2 .year4 {left:332px; width:13px; background-position:-137px 0;}
.christmas .head .hgroup h2 .ico {top:123px; left:211px; animation-name:twinkle3; animation-iteration-count:infinite; animation-duration:3s; animation-fill-mode:both; animation-delay:1.8s;}
.christmas .head .hgroup p {margin-top:35px;}
@keyframes twinkle {
	0% {opacity:0.1;}
	50% {opacity:1;}
	100% {opacity:0.1;}
}
@keyframes twinkle2 {
	0% {opacity:1;}
	50% {opacity:0.1;}
	100% {opacity:2;}
}
@keyframes twinkle3 {
	0% {opacity:0;}
	50% {opacity:1;}
	100% {opacity:0;}
}

.spin {animation:spin 5s linear 5;}
@keyframes spin {100% {transform:rotateY(360deg);}}

.navigator {width:1140px; height:65px;}
.navigator ul {overflow:hidden;}
.navigator ul li {float:left; width:285px; height:65px; }
.navigator ul li a {display:block; position:relative; width:100%; height:100%; color:#fff; text-align:center;}
.navigator ul li a span { position:absolute; top:0; left:0; width:100%; height:100%; background:#fff url(http://webimage.10x10.co.kr/eventIMG/2016/74312/img_navigator.gif) no-repeat 0 0; cursor:pointer;}
.navigator ul li a:hover span {background-position:0 -65px;}
.navigator ul li a.on span {background-position:0 100%;}
.navigator ul li.nav2 a span {background-position:-285px 0;}
.navigator ul li.nav2 a:hover span {background-position:-285px -65px;}
.navigator ul li.nav2 a.on span {background-position:-285px 100%;}
.navigator ul li.nav3 a span {background-position:-570px 0;}
.navigator ul li.nav3 a:hover span {background-position:-570px -65px;}
.navigator ul li.nav3 a.on span {background-position:-570px 100%;}
.navigator ul li.nav4 a span {background-position:100% 0;}
.navigator ul li.nav4 a:hover span {background-position:100% -65px;}
.navigator ul li.nav4 a.on span {background-position:100% 100%;}

/* 74319 */

.evt74319 {position:relative; background: #fff;}
.evt74319 .pageMove {display:none; }
.mainConts {background:#f7f5f2 url(http://webimage.10x10.co.kr/eventIMG/2016/74312/bg_tree.png) repeat-x 50% 0;}
.prowish {position:relative; width:100%; margin:0 auto; padding:75px 0 65px 0; background:url(http://webimage.10x10.co.kr/eventIMG/2016/74314/bg_pattern.png) 50% 0 ;}
.prowish h2 {height:165px; padding-bottom:15px;}
.santa {position:absolute; left:50%; top:135px; margin-left:533px; animation:5s santa ease-in-out 1; /* z-index:10; */}
@keyframes santa {
	0% {left:50%; top:223px; margin-left:-800px;}
	100% {left:50%; top:135px; margin-left:533px;}
}
.myWishFolder {position:relative; width:1080px; height:1041px; margin:0 auto; background:url(http://webimage.10x10.co.kr/eventIMG/2016/74319/bg_folder_after_event.png) 50% 0 no-repeat;}
.myWishFolder h3 {padding-top:98px; font-size:16px;}
.myWishFolder ul {overflow:hidden; margin:43px 55px;}
.myWishFolder ul li {position:relative; float:left; width:152px; height:154px; padding:0 4.5px;}
.myWishFolder ul li img {width:152px; height:152px; border-radius:50%; border:solid 2px #e9e9e9;}
.myWishFolder a.goItem {display:block; width:150px; height:150px; position:absolute; right:60px; top:167px; z-index:20;}
.myWishFolder .nowPrice {position:absolute; top:421px; left:50%; width:100%; margin-left:-540px;}
.myWishFolder .nowPrice img {margin-top:6px;}
.myWishFolder .nowPrice span {padding:0 3px 0 10px; font-size:36px; line-height:1; color:#d23030; font-weight:600; letter-spacing:-0.05em;}

.tip {overflow:hidden; width:1080px;margin:50px auto 0;}
.tip .tipTxt {float:left; padding-left:103px;}
.tip .sns {position:relative; float:right; padding-right:95px;}
.tip .sns a {display:block; width:53px; height:100%; position:absolute; top:0; text-indent:-999em;}
.tip .sns a.fb {right:183px;}
.tip .sns a.tw {right:113px;}
.sns {display:inline-block;}

.joinMethod {position:relative; width:1140px; margin:10px auto 0 auto;}
.joinMethod .join a {display:block; overflow:hidden; position:absolute; left:133px; top:153px; width:227px; height:221px;}
.joinMethod .join a:hover {animation:1s zoom ease-in-out infinite alternate;}
@keyframes zoom {
	0%,100% {transform:scale(1);}
	50% {transform:scale(1.1);}
}
.joinMethod span {position:absolute; animation:1s balloon ease-in-out infinite alternate;}
.joinMethod span.click01 {left:130px; top:128px; }
.joinMethod span.click02 {left:284px; top:139px; }
@keyframes balloon {
	0% {margin-top:0;}
	50% {margin-top:-7px;}
	100% {margin-top:0;}
}
.joinMethod p a {display:block; position:absolute; right:0; bottom:65px;}
.goSns {overflow:hidden; position:absolute; left:50%; top:70px; width:45px; margin-left:527px;}
.goSns a {position:absolute; left:0; overflow:hidden; display:block; width:45px; height:45px; text-indent:-999em; z-index:50;}
.goSns a.fbLink {top:0;}
.goSns a.twLink {bottom:0;} 

.friendsWish {position:relative; padding:80px 0;}
.friendsWish .frWishList {width:980px; margin:0 auto 50px; padding:20px 40px 30px 40px;}
.friendsWish dl {width:980px; padding:38px 0 25px; border-bottom:1px solid #e9e9e9;}
.friendsWish dt {padding:10px 0 15px 0; text-align:left;}
.friendsWish dt span {display:block; height:12px; padding:5px 0 5px 30px; line-height:12px; color:#717171; background:url(http://webimage.10x10.co.kr/eventIMG/2016/74319/ico_tree.png) 0 50% no-repeat;}
.friendsWish dd {padding:15px 0 10px 0;}
.friendsWish ul {overflow:hidden; width:980px; margin:0 auto;}
.friendsWish ul li {position:relative; float:left; width:150px; height:154px; margin:0 25px;}
.friendsWish ul li:first-child {margin-left:0;}
.friendsWish ul li img {width:150px; height:150px; border-radius:50%; border:solid 2px #e9e9e9;}

.paging {height:30px}

.paging a {height:30px; width:30px; border:none; line-height:30px;}
.paging a span{color:#c6c6c6;}
.paging a.arrow {border-radius:50%;}
.paging a:hover {background-color:transparent;}
.paging a.first span{width:30px; height:30px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/74319/btn_arrow01.png) 0 50% no-repeat;}
.paging a.prev span{width:29px; height:29px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/74319/btn_arrow02.png) 0 50% no-repeat;}
.paging a.next span{width:29px; height:29px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/74319/btn_arrow03.png) 0 50% no-repeat;}
.paging a.end span{width:29px; height:29px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/74319/btn_arrow04.png) 0 50% no-repeat;}
.paging a.current span{color:#c49b4d;}
.paging a.current {border:none;}


.notiWrap {padding:55px 0 43px; background:#efefef;}
.notiWrap .evtNoti {overflow:hidden; width:980px; margin:0 auto;}
.notiWrap .evtNoti h4 {float:left; width:124px; padding:42px 85px 0 10px; text-align:center;}
.notiWrap .evtNoti ul {float:left; text-align:left;}
.notiWrap .evtNoti li {font-size:11px; line-height:12px; color:#8e8e8e;padding:0 0 14px 15px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/74319/blt_round.png) 0 3px no-repeat;}
</style>
<script type="text/javascript">
$(function(){
	/* title animation */
	animation();
	$("#animation span").css({"margin-top":"5px", "opacity":"0"});
	$("#animation .ico").css({"margin-top":"0"});
	$("#animation .letter3").css({"margin-bottom":"10px", "opacity":"0"});
	function animation () {
		$("#animation .letter1").delay(100).animate({"margin-top":"0", "opacity":"1"},800);
		$("#animation .letter2").delay(500).animate({"margin-top":"0", "opacity":"1"},1000);
		$("#animation .letter3").delay(500).animate({"margin-bottom":"0", "opacity":"1"},1000);
		$("#animation .ico").delay(500).animate({"margin-top":"0", "opacity":"1",},800);
		$("#animation .year1").delay(900).animate({"margin-top":"0", "opacity":"1",},800);
		$("#animation .year2").delay(1100).animate({"margin-top":"0", "opacity":"1",},800);
		$("#animation .year3").delay(1300).animate({"margin-top":"0", "opacity":"1",},800);
		$("#animation .year4").delay(1500).animate({"margin-top":"0", "opacity":"1",},800);
	}
});
function jsGoPage(iP){
	document.pageFrm.page.value = iP;
	document.pageFrm.submit();
}

function jsSubmit()
{
<% If systemok="X" then %>
	alert("이벤트 응모 기간이 아닙니다.");
	return;
<% Else %>
	<% If IsUserLoginOK() Then %>
		<% If Now() > #12/18/2016 23:59:59# Then %>
			alert("이벤트가 종료되었습니다.");
			return;
		<% Else %>
			<% If Now() > #11/18/2016 00:00:00# and Now() < #12/18/2016 23:59:59# Then %>
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

function snschk(snsnum) {
	if(snsnum == "tw") {
		popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>');
	}else if(snsnum=="fb"){
		popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','');
	}else if(snsnum=="ka"){
		alert('잘못된 접속 입니다.');
		return false;
	}
}
</script>
<div class="evt74319 christmas">
<form name="frm" method="post">
<input type="hidden" name="hidM" value="I">
<input type="hidden" name="foldername" value="<%=foldername%>">
<input type="hidden" name="eventid" value="<%=eCode%>">
<input type="hidden" name="returnurl" value="<%=vreturnurl%>">
	<!-- head -->
	<div class="head">
		<div class="bg light light1"></div>
		<div class="bg light light2"></div>
		<div class="bg star"></div>
		<div class="inner">
			<div class="hgroup">
				<div class="title">
					<h2 id="animation">
						<span class="letter letter1 spin"></span>
						<span class="letter letter2">Turn on your</span>
						<span class="letter letter3">Christmas</span>
						<span class="year year1">2</span>
						<span class="year year2">0</span>
						<span class="year year3">1</span>
						<span class="year year4">6</span>
						<span class="ico"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74312/img_light.png" alt="" /></span>
					</h2>
				</div>
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/74312/txt_date.png" alt="빛나는 당신의 잊지 못할 크리스마스를 위하여! 기획전 기간은 2016년 11월 21일부터 12월 23일까지 진행합니다." /></p>
			</div>

			<div class="navigator">
				<ul>
					<li class="nav1"><a href="/event/eventmain.asp?eventid=74313&eGc=193502"><span></span>Christmas colors</a></li>
					<li class="nav2"><a href="/event/eventmain.asp?eventid=74313&eGc=193503"><span></span>Christmas space</a></li>
					<li class="nav3"><a href="/event/eventmain.asp?eventid=74314"><span></span>Special present</a></li>
					<li class="nav4"><a href="/event/eventmain.asp?eventid=74319" class="on"><span></span>Enjoy with 텐바이텐</a></li>
				</ul>
			</div>
		</div>
	</div>

	<div class="mainConts">
		<div class="prowish">
			<h2><img src="http://webimage.10x10.co.kr/eventIMG/2016/74319/tit_wish_v2.png" alt="크리스마스에 놀러온 산타의 Wish" /></h2>
			<p class="santa"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74319/img_santa.png" alt="" /></p>
		<% If vCount < 1 Then %>
			<%' 참여전 %>
			<div class="joinMethod">
				<p class="join">
					<a href="" onclick="jsSubmit(); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74319/img_wish.png" alt="산타의 Wish 참여하기<" /></a>
					<span class="click01"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74319/txt_click01.png" alt="click" /></span>
					<span class="click02"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74319/txt_click02.png" alt="click" /></span>
					<img src="http://webimage.10x10.co.kr/eventIMG/2016/74319/bg_folder_before_event.png" alt="이벤트 참여방법" />
				</p>
			</div>
		<% Else %>
			<%' 참여후 %>
			<div class="myWishFolder">
				<h3><%= userid %> 님의 산타의 위시 폴더</h3>
				<ul>
				<%
					If ifr.FmyTotalCount > 0 Then
						If isarray(Split(ifr.Fmylist,",")) then
							arrCnt = Ubound(Split(ifr.Fmylist,","))
						Else
							arrCnt=0
						End if
	
						If ifr.FmyTotalCount > 4 Then
							arrCnt = 5
						Else
							arrCnt = ifr.FmyTotalCount
						End If
						
						Dim totcash : totcash = 0 '//합계금액
						For y = 0 to cint(ifr.FmyTotalCount) - 1
							sp = Split(ifr.Fmylist,",")(y)
							totcash  = totcash + Split(sp,"|")(2)
						Next
	
						For y = 0 to CInt(arrCnt) - 1
							sp = Split(ifr.Fmylist,",")(y)
							spitemid = Split(sp,"|")(0)
							spimg	 = Split(sp,"|")(1)
				%>
					<li><a href="<%=wwwURL%>/<%=spitemid%>" target="_top"><img src="http://webimage.10x10.co.kr/image/icon2/<%=GetImageSubFolderByItemid(spitemid)%>/<%=spimg%>" alt="" /></a></li>

				<%
						Next
					End If 
				%>
				</ul>
				<a href="/my10x10/mywishlist.asp" class="goItem"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74319/btn_folder_view.png" alt="그 이외 상품 확인하러 가기" /></a>
				<div class="nowPrice">
					<img src="http://webimage.10x10.co.kr/eventIMG/2016/74319/txt_now1.png" alt="현재 합계금액" /><span><%=FormatNumber(totcash,0)%></span><img src="http://webimage.10x10.co.kr/eventIMG/2016/74319/txt_now2.png" alt="원" />
				</div>
			</div>
		<% End If %>
			<div class="tip">
				<span class="tipTxt"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74319/txt_wish_tip.png" alt="당첨 TIP" /></span>
				<span class="sns">
					<img src="http://webimage.10x10.co.kr/eventIMG/2016/74319/img_sns_share.png" alt="친구에게 공유하기" />
					<a href="" target="_blank" onclick="snschk('fb');return false;" class="fb">facebook</a>
					<a href="" target="_blank" onclick="snschk('tw');return false;" class="tw">twitter</a>
				</span>
			</div>
		</div>
	</div>

<%' 친구들 위시 %>
<% If ifr.FResultCount > 0 Then %>
	<div class="friendsWish">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/74319/tit_friend_wish.png" alt="이미 손 빠르게 움직이고 있는 친구들" /></h3>
		<div class="frWishList">
		<% For i = 0 to ifr.FResultCount -1 %>
			<dl>
				<dt><span><strong><%=printUserId(ifr.FList(i).FUserid,2,"*")%></strong> 님의 위시리스트</span></dt>
				<dd>
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
						<li><a href="<%=wwwURL%>/<%=spitemid%>" target="_top"><img src="http://webimage.10x10.co.kr/image/icon2/<%= GetImageSubFolderByItemid(spitemid) %>/<%= spimg %>" alt="" /></a></li>
			<% Next %>
					</ul>
				</dd>
			</dl>
		<% Next %>
		</div>
		<div class="pageWrapV15">
			<%= fnDisplayPaging_New(page,ifr.FTotalCount,4,10,"jsGoPage") %>
		</div>
		<i class="decoHill3"></i>
		<i class="decoHill4"></i>
	</div>
<% End If %>
	<div class="notiWrap">
		<div class="evtNoti">
			<h4><img src="http://webimage.10x10.co.kr/eventIMG/2016/74319/tit_noti.png" alt="이벤트 유의사항" /></h4>
			<ul>
				<li>본 이벤트에서 참여하기를 클릭하셔야만 이벤트 참여가 가능합니다.</li>
				<li>참여하기 클릭 시, 위시리스트에 &lt;산타의 WISH&gt; 폴더가 자동 생성됩니다.</li>
				<li>수동으로 생성하시거나 기존에 있던 폴더의 이름을 수정하면 이벤트 참여가 불가합니다. </li>
				<li>위시리스트에 &lt;산타의 WISH&gt; 폴더는 한 ID당 1개만 생성이 가능합니다.</li>
				<li>해당 폴더에 5개 이상의 상품, 총 금액이 10만원 이상이 되도록 넣어주세요. </li>
				<li>해당 폴더 외에 다른 폴더에 담으시는 상품은 이벤트 응모와는 무관 합니다. </li>
				<li>본 이벤트는 12월 18일 23시59분59초까지 담겨진 상품을 기준으로 선정합니다.</li>
				<li>위시리스트 속 상품은 최근 5개만 보여집니다. </li>
				<li>당첨자 안내는 12월 19일에 공지사항을 통해 진행됩니다.</li>
			</ul>
		</div>
	</div>
</form>
</div>

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