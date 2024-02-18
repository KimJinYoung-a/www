<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  위시리스트 - PROWISH 101  
' History : 2016-03-31 김진영 생성
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
IF application("Svr_Info") = "Dev" THEN
	eCode   =  "66096"
Else
	eCode   =  "69919"
End If

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
	ifr.FPageSize	= 5
	ifr.FCurrPage	= page
	ifr.FeCode		= eCode
	ifr.Frectuserid = userid
	ifr.evt_wishfolder_list		'메인디비
	'ifr.evt_wishfolder_list_B	'캐쉬디비

'// 쇼셜서비스로 글보내기 (2010.07.21; 허진원)
Dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
snpTitle = Server.URLEncode(ename)
snpLink = Server.URLEncode("http://www.10x10.co.kr/event/" & ecode)
snpPre = Server.URLEncode("텐바이텐 이벤트")
snpTag = Server.URLEncode("텐바이텐 " & Replace(ename," ",""))
snpTag2 = Server.URLEncode("#10x10")
snpImg = Server.URLEncode(emimg)
%>
<style type="text/css">
img {vertical-align:top;}
.evt69919 {position:relative; background:#f8f8f8 url(http://webimage.10x10.co.kr/eventIMG/2016/69919/bg_head.png) 0 0 repeat-x;}
.evt69919 .pageMove {display:none;}
.prowish {width:100%; margin:0 auto; padding:75px 0 0 0; background:#ffbf67 url(http://webimage.10x10.co.kr/eventIMG/2016/69919/bg_head2.png) 0 0 no-repeat;}
.prowish h2 {height:483px; padding-bottom:40px;}
.joinMethod {position:relative; width:1140px; height:685px; margin:10px auto 0 auto;}
.joinMethod button {overflow:hidden; position:absolute; left:155px; top:120px; width:215px; height:200px; background-color:rgba(255,255,255,0); outline:none; text-indent:-999em; z-index:50;}
.joinMethod span {position:absolute; left:233px; top:70px; animation:1s balloon ease-in-out infinite alternate;}
@keyframes balloon {
	0% {margin-top:0;}
	50% {margin-top:-7px;}
	100% {margin-top:0;}
}
.joinMethod p {position:relative; width:995px; margin:0 auto; padding:10px 0 65px 0; text-align:left;}
.joinMethod p a {position:absolute; right:0; bottom:55px;}
.goSns {overflow:hidden; position:absolute; left:50%; top:70px; width:45px; margin-left:527px;}
.goSns a {position:absolute; left:0; overflow:hidden; display:block; width:45px; height:45px; text-indent:-999em; z-index:50;}
.goSns a.fbLink {top:0;}
.goSns a.twLink {bottom:0;}

.myWishFolder {position:relative; width:1136px; height:451px; margin:10px auto 0 auto; padding-top:47px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/69919/img_wish_folder.png) 50% 0 no-repeat;}
.myWishFolder h3 {display:inline-block; max-width:500px; padding-left:50px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/69919/img_wish_folder_deco1.png) 0 0 no-repeat;}
.myWishFolder h3 p {padding-right:50px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/69919/img_wish_folder_deco2.png) 100% 0 no-repeat; font-size:16px; line-height:1.2; font-weight:bold; color:#ff8383;}
.myWishFolder ul {overflow:hidden; margin:47px 50px;}
.myWishFolder ul li {position:relative; float:left; width:160px; height:160px; margin:0 1px; padding:5px;}
.myWishFolder ul li span {position:absolute; left:0; top:0; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2016/69919/img_wish_mask2.png) 50% 50% no-repeat; z-index:10;}
.myWishFolder ul li img {width:160px; height:160px;}
.myWishFolder button {position:absolute; right:60px; top:140px; background-color:rgba(255,255,255,0); outline:none;}
.nowPrice {position:absolute; left:50%; top:340px; width:862px; margin-left:-431px; padding-top:40px; border-top:1px solid #f5f5f5; text-align:center; vertical-align:top;}
.nowPrice img {margin-top:6px;}
.nowPrice span {padding:0 3px 0 10px; font-size:36px; line-height:1; color:#ff5565; font-weight:600; letter-spacing:-0.05em;}

.friendsWish {position:relative; padding:80px 0;}
.friendsWish .frWishList {width:1060px; margin:40px auto; padding:20px 40px 30px 40px;}
.friendsWish dl {width:1060px; padding:25px 0; border-bottom:1px solid #e9e9e9;}
.friendsWish dt {padding:10px 0 15px 50px; text-align:left;}
.friendsWish dt span {display:block; height:12px; padding:5px 0 5px 30px; line-height:12px; color:#717171; background:url(http://webimage.10x10.co.kr/eventIMG/2016/69919/ico_heart.png) 0 50% no-repeat;}
.friendsWish dd {padding:15px 0 10px 0;}
.friendsWish ul {overflow:hidden; width:1010px; margin:0 auto;}
.friendsWish ul li {position:relative; float:left; width:150px; height:150px; margin:0 21px; padding:5px;}
.friendsWish ul li span {position:absolute; left:0; top:0; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2016/69919/img_wish_mask.png) 50% 50% no-repeat; z-index:10;}
.friendsWish ul li img {width:150px; height:150px;}
.notiWrap {padding:30px 0 20px; background:#efefef;}
.notiWrap .evtNoti {overflow:hidden; width:1140px; margin:0 auto;}
.notiWrap .evtNoti h3 {float:left; width:300px; padding-top:50px; text-align:center;}
.notiWrap .evtNoti ul {float:left; text-align:left;}
.notiWrap .evtNoti li {font-size:11px; line-height:12px; color:#8e8e8e; padding:0 0 12px 15px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/69919/blt_round.png) 0 3px no-repeat;}
</style>
<script>
var q_move ;
var q_top = 70;
$(document).ready(function() {
	var contH = $('.prowish').outerHeight()-365;
	q_move = $(".goSns");
	$(window).scroll(function(){
		q_move.stop();
		var thisTop = $(document).scrollTop();
		if (thisTop >= 0 && thisTop <= contH) {
			q_move.animate({"top":$(document).scrollTop() + q_top + "px"},400);
		} else {
			q_move.css("top", contH);
		}
	});
});

function jsGoPage(iP){
	document.pageFrm.page.value = iP;
	document.pageFrm.submit();
}
<% If page > 1 Then %>
	setTimeout("$('html,body',document).scrollTop(1400);", 200);
<% End If %>

function jsSubmit()
{
	<% If IsUserLoginOK() Then %>
		<% If Now() > #04/08/2016 23:59:59# Then %>
			alert("이벤트가 종료되었습니다.");
			return;
		<% Else %>
			<% If Now() > #04/04/2016 00:00:00# and Now() < #04/08/2016 23:59:59# Then '#02/10/2016 10:00:00# %>
				var frm = document.frm;
				frm.action="/event/etc/wishlist/wishfolderProc.asp";
				frm.hidM.value='I';
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
}

function getsnscnt(snsno) {
	<% If IsUserLoginOK() Then %>
		var str = $.ajax({
			type: "GET",
			url: "/event/etc/wishlist/wishfolderProc.asp",
			data: "hidM=S&snsno="+snsno+"&eventid="+<%=eCode%>,
			dataType: "text",
			async: false
		}).responseText;
		if(str=="tw") {
			popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>');
		}else if(str=="fb"){
			popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','');
		}else{
			alert('오류가 발생했습니다.');
			return false;
		}
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return;
		}
	<% End If %>
}
</script>
<%
Dim sp, spitemid, spimg
Dim arrCnt, foldername

foldername = "PROWISH 101"
Dim strSql, vCount, vFolderName, vViewIsUsing
vCount = 0

strSql = "Select COUNT(fidx) From [db_my10x10].[dbo].[tbl_myfavorite_folder]  WHERE foldername = '" & trim(foldername) & "' and userid='" & userid & "' "
rsget.Open strSql,dbget,1
IF Not rsget.Eof Then
	vCount = rsget(0)
Else
	vCount = 0
END IF
rsget.Close
%>
<form name="frm" method="post">
<input type="hidden" name="hidM" value="I">
<input type="hidden" name="foldername" value="<%=foldername%>">
<input type="hidden" name="eventid" value="<%=eCode%>">
<input type="hidden" name="returnurl" value="<%=vreturnurl%>">
<div class="evt69919">
	<div class="prowish">
		<h2><img src="http://webimage.10x10.co.kr/eventIMG/2016/69919/tit_wish.png" alt="PROWISH101" /></h2>
		<% If vCount > 0 Then %>
		<div class="myWishFolder">
			<h3><p><%= userid %> 님의 [PROWISH 101] 위시 폴더</p></h3>
			<ul>
			<%
				If ifr.FmyTotalCount > 0 then 
					If isarray(Split(ifr.Fmylist,",")) Then
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
				<li><a href="<%=wwwURL%>/<%=spitemid%>" target="_top"><span></span><img src="http://webimage.10x10.co.kr/image/icon2/<%=GetImageSubFolderByItemid(spitemid)%>/<%=spimg%>"  /></a></li>
			<%
					Next
				End If 
			%>
			</ul>
			<button onclick="location.href='/my10x10/mywishlist.asp'; return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69919/btn_folder_view.png" alt="그 이외 상품 확인하러 가기" /></button>
			<div class="nowPrice">
				<img src="http://webimage.10x10.co.kr/eventIMG/2016/69919/txt_now1.png" alt="현재 합계금액" /><span><%=FormatNumber(totcash,0)%></span><img src="http://webimage.10x10.co.kr/eventIMG/2016/69919/txt_now2.png" alt="원" />
			</div>
		</div>
		<% End If %>
		<div class="joinMethod">
			<button onclick="jsSubmit(); return false;">PROWISH101 이벤트 참여하기</button>
			<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/69919/ico_click.png" alt="clcik" /></span>
			<img src="http://webimage.10x10.co.kr/eventIMG/2016/69919/img_wish_join.png" alt="이벤트 참여방법" />
			<p>
				<img src="http://webimage.10x10.co.kr/eventIMG/2016/69919/txt_wish_tip_v2.png" alt="당첨 TIP" />
				<a href="/event/eventmain.asp?eventid=69789"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69919/btn_wish_view.png" alt="담고싶은 상품 보러가기" /></a>
			</p>
		</div>
	</div>
	<div class="goSns">
		<a href="#" onclick="getsnscnt('fb');return false;" class="fbLink">Facebook</a>
		<a href="#" onclick="getsnscnt('tw');return false;" class="twLink">Twitter</a>
		<img src="http://webimage.10x10.co.kr/eventIMG/2016/69919/btn_sns.png" alt="" />
	</div>
	<% If ifr.FResultCount > 0 Then %>
	<div class="friendsWish">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/69919/tit_friend_wish.png" alt="이미 손 빠르게 움직이고 있는 친구들" /></h3>
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
						<li><a href="<%=wwwURL%>/<%=spitemid%>" target="_top"><img src="http://webimage.10x10.co.kr/image/icon2/<%=GetImageSubFolderByItemid(spitemid)%>/<%=spimg%>" /></a></li>
						<%	Next %>	
					</ul>
				</dd>
			</dl>
			<% Next %>
		</div>
		<div class="pageWrapV15">
			<%= fnDisplayPaging_New(page,ifr.FTotalCount,5,10,"jsGoPage") %>
		</div>
		<i class="decoHill3"></i>
		<i class="decoHill4"></i>
	</div>
	<% End If %>
	<div class="notiWrap">
		<div class="evtNoti">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/69919/tit_noti.png" alt="이벤트 유의사항" /></h3>
			<ul>
				<li>본 이벤트에서 참여하기를 클릭하셔야만 이벤트 참여가 가능합니다.</li>
				<li>참여하기 클릭 시, 위시리스트에 &lt;PROWISH 101&gt; 폴더가 자동 생성됩니다.</li>
				<li>수동으로 생성하시거나 기존에 있던 폴더의 이름을 수정하면 이벤트 참여가 불가합니다.</li>
				<li>위시리스트에 &lt;PROWISH 101&gt; 폴더는 한 ID당 1개만 생성이 가능합니다.</li>
				<li>해당 폴더에 5개 이상의 상품, 총 금액이 101만원 이상이 되도록 넣어주세요.</li>
				<li>해당 폴더 외에 다른 폴더에 담으시는 상품은 이벤트 응모와는 무관 합니다.</li>
				<li>당첨자에 한 해 개인정보를 요청하게 되며, 개인정보 확인 후 경품이 지금 됩니다.</li>
				<li>본 이벤트는 4월 8일 23시59분59초까지 담겨진 상품을 기준으로 선정합니다.</li>
				<li>위시리스트 속 상품은 최근 5개만 보여집니다.</li>
				<li>당첨자 안내는 4월 12일에 공지사항을 통해 진행됩니다.</li>
			</ul>
		</div>
	</div>
</div>
</form>
<form name="pageFrm" method="get" action="<%=CurrURL()%>">
	<input type="hidden" name="eventid" value="<%=eCode%>">
<input type="hidden" name="page" value="">
</form>
<% Set ifr = nothing %>
<!-- #include virtual="/lib/db/dbclose.asp" -->