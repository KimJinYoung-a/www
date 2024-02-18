<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<%
'============== 모바일 접근시 모바일 페이지 이동(referer가 10x10이면 이동안함) ============
if InStr(request.ServerVariables("HTTP_REFERER"),"10x10.co.kr")<1 then
	if Not(Request("mfg")="pc" or session("mfg")="pc") then
		if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
			dim mRdSite: mRdSite = requestCheckVar(request("rdsite"),32)
			Response.Redirect "http://m.10x10.co.kr/event/eventmain.asp?eventid=73053" & chkIIF(mRdSite<>"","&rdsite=" & mRdSite,"")
			REsponse.End
		end if
	end if
end if

	'// 쇼셜서비스로 글보내기 (2010.07.21; 허진원)
	Dim vTitle, vLink, vPre, vImg, vIsEnd, vQuery, vState, vNowTime, vCouponMaxCount
	Dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
	snpTitle	= Server.URLEncode("[텐바이텐] 15주년 이벤트")
	snpLink		= Server.URLEncode("http://www.10x10.co.kr/event/15th/index.asp")
	snpPre		= Server.URLEncode("10x10 이벤트")
	
	
	'// Facebook 오픈그래프 메타태그 작성
	strHeaderAddMetaTag = "<meta property=""og:title"" content=""[텐바이텐] 15주년 이벤트"" />" & vbCrLf &_
						"<meta property=""og:type"" content=""website"" />" & vbCrLf &_
						"<meta property=""og:url"" content=""http://www.10x10.co.kr/event/15th/index.asp"" />" & vbCrLf
	
	strHeaderAddMetaTag = strHeaderAddMetaTag & "<meta property=""og:image"" content=""http://webimage.10x10.co.kr/eventIMG/2016/15th/73053/m/img_kakao.jpg"" />" & vbCrLf &_
												"<link rel=""image_src"" href=""http://webimage.10x10.co.kr/eventIMG/2016/15th/73053/m/img_kakao.jpg"" />" & vbCrLf
	
	strPageTitle = "[텐바이텐] 15주년 이벤트"
	strPageKeyword = "[텐바이텐] 15주년 이벤트"
	strPageDesc = "[텐바이텐] 이벤트 - 15주년 기념, 최대 30% 할인 쿠폰과 다양한 이벤트가 당신을 기다립니다."


	If Now() < #10/15/2016 00:00:00# Then
		vCouponMaxCount = 48
	Else
		vCouponMaxCount = 13
	End If


'#######
' vState = "0" ### 이벤트 종료됨.
' vState = "1" ### 쿠폰다운가능.
' vState = "2" ### 다운 가능 시간 아님.
' vState = "3" ### 이미 받음.
' vState = "4" ### 한정수량 오버됨.
' vState = "5" ### 로그인안됨.
	If IsUserLoginOK() Then
		If Now() > #10/24/2016 23:59:59# Then
			vIsEnd = True
			vState = "0"	'### 이벤트 종료됨. 0
		Else
			vIsEnd = False
		End If
		
		If Not vIsEnd Then	'### 이벤트 종료안됨.
			vQuery = "select convert(int,replace(convert(char(8),getdate(),8),':',''))"
			rsget.CursorLocation = adUseClient
			rsget.Open vQuery,dbget,adOpenForwardOnly,adLockReadOnly
			vNowTime = rsget(0)	'### DB시간받아옴.
			rsget.close

			'If vNowTime > 100000 AND vNowTime < 235959 Then	'### 15시에서 24시 사이 다운가능. 1
			If vNowTime > 150000 AND vNowTime < 235959 Then	'### 15시에서 24시 사이 다운가능. 1
				vQuery = "select count(sub_idx) from [db_event].[dbo].[tbl_event_subscript] where userid = '" & getencLoginUserid() & "' and evt_code = '73053'"
				rsget.CursorLocation = adUseClient
				rsget.Open vQuery,dbget,adOpenForwardOnly,adLockReadOnly
				If rsget(0) > 0 Then	' ### 이미 받음. 3
					vState = "3"
				End IF
				rsget.close
				
				If vState <> "3" Then	'### 한정수량 계산
					vQuery = "select count(sub_idx) from [db_event].[dbo].[tbl_event_subscript] where evt_code = '73053' and sub_opt1 = convert(varchar(10),getdate(),120)"
					rsget.CursorLocation = adUseClient
					rsget.Open vQuery,dbget,adOpenForwardOnly,adLockReadOnly
					If rsget(0) >= vCouponMaxCount Then	' 한정수량 100 오버됨. 4
						vState = "4"
					Else
						vState = "1"	'### 쿠폰다운가능.
					End IF
					rsget.close
				End IF
			Else	' ### 다운 가능 시간 아님. 2
				vState = "2"
			End IF
		End IF
	Else
		vState = "5"	'### 로그인안됨.
	End IF
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventCls.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<style type="text/css">
/* teN15th commen */
img {vertical-align:top;}
#contentWrap {padding:0;}
.gnbWrapV15 {height:38px;}

/* teN15th main */
.teN15thMain {color:#fff;  background:#1c1a4f url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73053/bg_night.jpg) no-repeat 50% 0;}
.teN15thMain .tenHead {position:absolute; left:50%; top:0; width:1140px; margin-left:-570px;}
.teN15thMain .tenHead h2 {padding-top:56px;}
.teN15thMain .tenHead .date {position:absolute; right:18px; top:30px;}
.teN15thMain .tenHead .deco span {position:absolute; background-repeat:no-repeat; background-position:100% 100%;}
.teN15thMain .tenHead .deco .star1 {left:39px; top:139px; width:54px; height:46px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73053/img_star_01.png);}
.teN15thMain .tenHead .deco .star2 {left:-36px; top:135px; width:166px; height:137px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73053/img_star_02.png);}
.teN15thMain .tenHead .deco .star3 {left:947px; top:134px; width:250px; height:251px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73053/img_star_03.png);}
.teN15thMain .tenHead .deco .star4 {left:1026px; top:287px; width:62px; height:64px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73053/img_star_04.png);}
.teN15thMain .tenNav {position:relative; width:1140px; height:1497px; margin:0 auto;}
.teN15thMain .tenNav li {position:absolute; z-index:110;}
.teN15thMain .tenNav li a {display:block; width:100%; height:100%; background-position:0 0; background-repeat:no-repeat;}
.teN15thMain .tenNav li span {display:none; width:100%; height:100%; background-position:0 0; background-repeat:no-repeat; text-indent:-999em;}
.teN15thMain .tenNav li a:hover span {display:block;}
.teN15thMain .tenNav .nav1 {right:37px; top:432px; width:370px; height:220px;}
.teN15thMain .tenNav .nav1 a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73053/nav_01.gif);}
.teN15thMain .tenNav .nav1 span {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73053/nav_01_on.gif);}
.teN15thMain .tenNav .nav2 {left:0; top:432px; width:420px; height:240px;}
.teN15thMain .tenNav .nav2 a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73053/nav_02.gif);}
.teN15thMain .tenNav .nav2 span {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73053/nav_02_on.gif);}
.teN15thMain .tenNav .nav3 {left:0; top:1012px; width:300px; height:220px;}
.teN15thMain .tenNav .nav3 a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73053/nav_03.gif);}
.teN15thMain .tenNav .nav3 span {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73053/nav_03_on.gif);}
.teN15thMain .tenNav .nav4 {right:40px; top:1073px; width:360px; height:200px;}
.teN15thMain .tenNav .nav4 a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73053/nav_04.gif);}
.teN15thMain .tenNav .nav4 span {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73053/nav_04_on.gif);}
.teN15thMain .tenNav .nav5 {right:-50px; top:705px; width:340px; height:300px;}
.teN15thMain .tenNav .nav5 a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73053/nav_05.gif);}
.teN15thMain .tenNav .nav5 span {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73053/nav_05_on.gif);}
.teN15thMain .tenNav .coupon {position:absolute; left:50%; top:649px; width:578px; height:443px; margin-left:-289px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73053/img_coupon.gif) 0 0 no-repeat;}
.teN15thMain .tenNav .coupon button {display:block; position:absolute; left:50%; top:275px; z-index:100; margin-left:-134px; background:transparent; animation: bounce1 50 1s 1s; outline:none;}
.teN15thMain .tenNav .coupon .light {position:absolute; left:88px; top:-72px; width:404px; height:417px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73053/img_lamp.png) 0 0 no-repeat;}
.teN15thMain .tenShare {height:158px; border-top:3px solid #363636; border-bottom:3px solid #363636; text-align:left; background:#1e1e1e url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73053/bg_dot.png) repeat 0 0;}
.teN15thMain .tenShare div {position:relative; width:1140px; margin:0 auto;}
.teN15thMain .tenShare p {padding:68px 0 0 38px;}
.teN15thMain .tenShare ul {overflow:hidden; position:absolute; right:40px; top:50px;}
.teN15thMain .tenShare li {float:left; padding-left:40px;}
.couponCont {position:fixed; left:50% !important; width:694px; height:494px; margin-left:-347px; z-index:99999;}
.couponCont div {position:relative; width:694px; height:494px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73053/img_coupon_layer.png) repeat 0 0;}
.couponCont .close {position:absolute; right:-22px; top:-22px; background:transparent;}
.couponCont .limit {position:absolute; right:134px; top:82px;}
.couponCont a {position:absolute; top:82px; padding:250px 30px 20px;}
.couponCont .btn1 {left:101px; animation: bounce2 30 .8s;}
.couponCont .btn2 {left:391px; animation: bounce3 30 1.1s;}

@keyframes bounce1 {
	from, to{margin-top:0; animation-timing-function:ease-in;}
	50% {margin-top:4px; animation-timing-function:ease-out;}
}
@keyframes bounce2 {
	from, to{margin-top:0; animation-timing-function:ease-in;}
	50% {margin-top:4px; animation-timing-function:ease-in;}
}
@keyframes bounce3 {
	from, to{margin-top:0; animation-timing-function:ease-in;}
	50% {margin-top:4px; animation-timing-function:ease-in;}
}

.tenComment {padding:20px 0 100px; background:#fff url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73053/bg_light.png) 0 0 repeat-x;}
.tenComment .tenCmtWrite {background:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73053/bg_dot_02.png) 0 0 repeat ;}
.tenComment .tenCont {padding:60px 0 50px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73053/bg_light_02.png) 50% 0 no-repeat ;}
.tenComment h3 {padding-bottom:60px;}
.tenComment .msg {position:relative; width:900px; height:80px; padding:15px 20px; margin:0 auto; background:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73053/bg_box.png) 0 0 no-repeat ; text-align:left;}
.tenComment .msg textarea {overflow:auto; width:760px; height:75px; padding:0; font-size:12px; line-height:1.5; vertical-align:top; border:0;}
.tenComment .msg button {position:absolute; right:5px; top:5px; background:transparent; outline:none;}
.tenComment .pageMove {display:none;}
.tenComment .tenCmtList ul {overflow:hidden; width:1050px; margin:0 auto; padding:70px 45px 0; border-bottom:1px solid #eee;}
.tenComment .tenCmtList li {position:relative; float:left; width:240px; height:320px; margin:0 15px 40px; padding:0 40px; font-size:11px; text-align:left; background:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73053/bg_comment.png) 0 0 no-repeat;}
.tenComment .tenCmtList li.cmt01 {background-position:0 0;}
.tenComment .tenCmtList li.cmt02 {background-position:-330px 0;}
.tenComment .tenCmtList li.cmt03 {background-position:100% 0;}
.tenComment .tenCmtList li.cmt04 {background-position:0 100%;}
.tenComment .tenCmtList li.cmt05 {background-position:-330px 100%;}
.tenComment .tenCmtList li.cmt06 {background-position:100% 100%;}
.tenComment .tenCmtList li .num {display:inline-block; color:#333; padding:50px 0 20px; }
.tenComment .tenCmtList li .writer {position:absolute; left:40px; bottom:40px; color:#999; font-family:verdana;}
.tenComment .tenCmtList li .writer .mobile {display:inline-block; width:9px; height:15px; margin-left:5px; text-indent:-999em; background:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73053/ico_mobile.png) 0 0 no-repeat;}
.tenComment .tenCmtList li .btnDelete {display:inline-block; position:absolute; right:40px; top:50px; width:38px; height:16px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73053/btn_delete.png) 0 0 no-repeat; text-indent:-999em;}
.scrollbarwrap {width:100%;}
.scrollbarwrap .viewport {overflow:hidden; position: relative; width:230px; height:158px;}
.scrollbarwrap .overview {color:#666; line-height:18px;}
.scrollbarwrap .scrollbar {float:right; position:relative; width:3px;}
.scrollbarwrap.track {position: relative; width:3px; height:100%; background-color:#ddd;}
.scrollbarwrap .thumb {overflow:hidden; position:absolute; top: 0; left:0; width:3px; height:24px; background-color:#aaa; cursor:pointer; border-radius:3px;}
.scrollbarwrap .thumb .end {overflow:hidden; width:3px; height:5px;}
.scrollbarwrap .disable {display:none;}
</style>
<script src="/lib/js/jquery.tinyscrollbar.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$('.scrollbarwrap').tinyscrollbar();
});

$(function(){

	starAnimation()
	$(".tenHead .deco span").css({"width":"0", "height":"0"});
	function starAnimation() {
		$(".tenHead .deco .star1").delay(100).animate({"width":"54px", "height":"46px"},1000);
		$(".tenHead .deco .star2").delay(800).animate({"width":"166px", "height":"137px"},1200);
		$(".tenHead .deco .star3").delay(400).animate({"width":"250px", "height":"251px"},1300);
		$(".tenHead .deco .star4").delay(900).animate({"width":"62px", "height":"64px"},1200);
		$(".tenHead .deco span").delay(3000).animate({"opacity":"0"},1200).animate({"width":"0", "height":"0"},500).animate({"opacity":"1"},1200);
	}
	setInterval(function() {
		starAnimation()
	}, 5000);

	$(".tenComment .tenCmtList li:nth-child(1)").addClass("cmt01");
	$(".tenComment .tenCmtList li:nth-child(2)").addClass("cmt02");
	$(".tenComment .tenCmtList li:nth-child(3)").addClass("cmt03");
	$(".tenComment .tenCmtList li:nth-child(4)").addClass("cmt04");
	$(".tenComment .tenCmtList li:nth-child(5)").addClass("cmt05");
	$(".tenComment .tenCmtList li:nth-child(6)").addClass("cmt06");
});

function jsDownCoupon(stype,idx){
	<% if Not(IsUserLoginOK) then %>
		jsEventLogin();
	<% else %>
		if(confirm('쿠폰을 받으시겠습니까?')) {
			var frm;
			frm = document.frmC;
			frm.stype.value = stype;
			frm.idx.value = idx;
			frm.submit();
		}
	<% end if %>
}

function js15thCouponDown(){
<% If vIsEnd Then %>
	alert("이벤트가 종료되었습니다.");
	return false;
<% End If %>

<% If IsUserLoginOK() Then %>
	$.ajax({
		type: "GET",
		url: "/event/15th/doeventsubscript/index_proc.asp",
		data: "mode=G",
		cache: false,
		success: function(str) {
			str = str.replace("undefined","");
			res = str.split("|");
			if (res[0]=="OK") {
				alert(res[1]);
				top.location.reload();
				return false;
			} else {
				errorMsg = res[1].replace(">?n", "\n");
				alert(errorMsg );
				return false;
			}
		}
		,error: function(err) {
			console.log(err.responseText);
			alert("통신중 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
		}
	});
<% else %>
	jsEventLogin();
	return false;
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

function jsEventLogin(){
	if(confirm("로그인을 하셔야 쿠폰을 다운받으실수 있습니다.")){
		location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/15th/")%>';
		return;
	}
}

function jsUserCountT(){
	$.ajax({
		type: "GET",
		url: "/event/15th/doeventsubscript/usercount.asp",
		cache: false,
		success: function(str) { }
	});
}
</script>
</head>
<body>
<div id="eventDetailV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container fullEvt">
		<div id="contentWrap">
			<div class="eventWrapV15">
				<div class="eventContV15">
					<div class="contF contW">
						<div class="teN15thMain">
							<div class="tenHead">
								<h2><a href="/event/15th/"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73053/tit_15th.gif" alt="teN 15th" /></a></h2>
								<p class="date"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73053/txt_date.png" alt="2016.10.10~10.24(15일간)" /></p>
								<div class="deco">
									<span class="star1"></span>
									<span class="star2"></span>
									<span class="star3"></span>
									<span class="star4"></span>
								</div>
							</div>
							<div class="tenNav">
								<ul>
									<li class="nav1"><a href="walkingman.asp"><span>매일매일 출석체크 [워킹맨]</span></a></li>
									<li class="nav2"><a href="discount.asp"><span>매일 오전 10시 할인에 도전하라 [비정상할인]</span></a></li>
									<li class="nav3"><a href="sns.asp"><span>특급 콜라보레이션! [전국 영상자랑]</span></a></li>
									<li class="nav4"><a href="tv.asp"><span>일상을 담아라 [나의 리틀텔레비전]</span></a></li>
									<li class="nav5"><a href="gift.asp"><span>팡팡 터지는 구매사은품 [사은품을 부탁해]</span></a></li>
								</ul>
								<div class="coupon">
									<% if Not(IsUserLoginOK) then %>
										<button type="button" class="btnCoupon" onclick="jsEventLogin();return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73053/btn_coupon.png" alt="15주년 쿠폰/타임쿠폰 다운받기" /></button>
									<% Else %>
										<button type="button" class="btnCoupon" onclick="viewPoupLayer('modal',$('#lyrCoupon').html());jsUserCountT();return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73053/btn_coupon.png" alt="15주년 쿠폰/타임쿠폰 다운받기" /></button>
									<% End IF %>
									<span class="light"></span>
								</div>
								<% if IsUserLoginOK then %>
								<div id="lyrCoupon" style="display:none;">
									<div class="couponCont">
										<div>
										<%
											Dim vDownImg
											If vState = "2" Then
												vDownImg = "btn_download_off.png"
											ElseIf vState = "4" Then
												vDownImg = "btn_soldout.png"
											Else
												vDownImg = "btn_download_02.png"
											End If
										%>
											<p class="limit"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73053/txt_limit_<%=vCouponMaxCount+2%>.gif" alt="쿠폰" /></p>
											<% If Not vIsEnd Then %>
											<a href="javascript:jsDownCoupon('prd,prd,prd','11960,11961,11962');" class="btn1"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73053/btn_download_01.png" alt="15주년 할인쿠폰 발급받기" /></a>
											<a href="" class="btn2" onClick="<% If vState="1" OR vState = "3" OR vState = "2" Then %>js15thCouponDown();<% Else %>return false;<% End If %>"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73053/<%=vDownImg%>" alt="타임쿠폰 발급받기" /></a>
											<% End If %>
										</div>
										<button type="button" class="close" onclick="ClosePopLayer()"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73053/btn_close.png" alt="닫기" /></button>
									</div>
								</div>
								<% End IF %>
							</div>
							<div class="tenShare">
								<div>
									<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73053/txt_share.png" alt="텐바이텐 15주년 이야기, 친구와 함께라면!" /></p>
									<ul>
										<li><a href="" target="_blank" onclick="snschk('fb');return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/btn_facebook.png" alt="텐바이텐 15주년 이야기 페이스북으로 공유" /></a></li>
										<li><a href="" target="_blank" onclick="snschk('tw');return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/btn_twitter.png" alt="텐바이텐 15주년 이야기 트위터로 공유" /></a></li>
									</ul>
								</div>
							</div>
							<!-- #include virtual="/event/15th/comment.asp" -->
						</div>
						<form name="frmC" method="get" action="/shoppingtoday/couponshop_process.asp" style="margin:0px;">
						<input type="hidden" name="stype" value="">
						<input type="hidden" name="idx" value="">
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->