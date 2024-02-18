<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
'####################################################
' Description : 2018 텐큐베리감사 - 100원의 기적
' History : 2018-03-26 이종화
'####################################################

'============== 모바일 접근시 모바일 페이지 이동(referer가 10x10이면 이동안함) ============
if InStr(request.ServerVariables("HTTP_REFERER"),"10x10.co.kr")<1 then
	if Not(Request("mfg")="pc" or session("mfg")="pc") then
		if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
			dim mRdSite: mRdSite = requestCheckVar(request("rdsite"),32)
			Response.Redirect "http://m.10x10.co.kr/event/eventmain.asp?eventid=85145" & chkIIF(mRdSite<>"","&rdsite=" & mRdSite,"")
			REsponse.End
		end if
	end if
end If

Dim ecode : eCode = "85145"
Dim actdate : actdate = Date()

'// SNS 공유용
Dim vTitle, vLink, vPre, vImg
Dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
snpTitle	= Server.URLEncode("[텐바이텐] 텐큐-100원의 기적")
snpLink		= Server.URLEncode("http://www.10x10.co.kr/event/tenq/miracle.asp")
snpPre		= Server.URLEncode("10x10 이벤트")
snpImg		= Server.URLEncode("http://webimage.10x10.co.kr/eventIMG/2018/85145/etcitemban20180327095902.JPEG")


'// Facebook 오픈그래프 메타태그 작성
strPageTitle = "[텐바이텐] 텐큐-100원의 기적"
strPageKeyword = "[텐바이텐] 텐큐-100원의 기적"
strPageDesc = "4/2 ~ 16, 총 15일간 매일 다른 상품들을 100원에 만나보세요!"
strPageUrl = "http://www.10x10.co.kr/event/tenq/miracle.asp"
strPageImage = "http://webimage.10x10.co.kr/eventIMG/2018/85145/etcitemban20180327095902.JPEG"

Dim vUserID
vUserID		= GetEncLoginUserID

Dim vQuery , myevtdaycnt
If vUserID <> "" Then 
	vQuery = ""
	vQuery = vQuery & " select top 1 sub_opt1 From [db_event].[dbo].[tbl_event_subscript] Where evt_code="& eCode &" and userid='"& vUserID &"' and datediff(day,regdate,getdate()) = 0 "
	rsget.Open vQuery, dbget, 1
	IF Not rsget.Eof Then
		myevtdaycnt = rsget(0)
	End If 
	rsget.close
End If 

'#################################################################################################
'// 당첨자 리스트
'#################################################################################################
Dim sqlStr
Dim win1 , win2 , win3 , win4 , win5 , win6 , win7 , win8 , win9 , win10
Dim win11 , win12 , win13 , win14 , win15
sqlStr = ""
sqlStr = sqlStr & " SELECT isnull([2018-04-02],'') as win1 , isnull([2018-04-03],'') as win2 , isnull([2018-04-04],'') as win3 , isnull([2018-04-05],'') as win4 , isnull([2018-04-06],'') as win5 , isnull([2018-04-07],'') as win6 , isnull([2018-04-08],'') as win7 , isnull([2018-04-09],'') as win8 " & vbCrlf
sqlStr = sqlStr & " , isnull([2018-04-10],'') as win9 , isnull([2018-04-11],'') as win10 , isnull([2018-04-12],'') as win11 , isnull([2018-04-13],'') as win12 , isnull([2018-04-14],'') as win13 , isnull([2018-04-15],'') as win14 , isnull([2018-04-16],'') as win15 " & vbCrlf
sqlStr = sqlStr & " FROM " & vbCrlf
sqlStr = sqlStr & " ( " & vbCrlf
sqlStr = sqlStr & " 	SELECT convert(varchar(10),regdate,120) as rgt , userid " & vbCrlf
sqlStr = sqlStr & " 	FROM db_event.[dbo].[tbl_event_subscript] WITH(NOLOCK) " & vbCrlf
sqlStr = sqlStr & " 	WHERE evt_code = "& ecode &" and sub_opt2 = 1 " & vbCrlf
sqlStr = sqlStr & " 	GROUP BY userid , convert(varchar(10),regdate,120) " & vbCrlf
sqlStr = sqlStr & " ) AS A " & vbCrlf
sqlStr = sqlStr & " PIVOT " & vbCrlf
sqlStr = sqlStr & " ( " & vbCrlf
sqlStr = sqlStr & " 	MIN(userid) " & vbCrlf
sqlStr = sqlStr & " 	FOR rgt IN ([2018-04-02] , [2018-04-03] , [2018-04-04] , [2018-04-05] , [2018-04-06] , [2018-04-07] ,[2018-04-08] ,[2018-04-09] ,[2018-04-10] , [2018-04-11] ,[2018-04-12]  ,[2018-04-13] ,[2018-04-14] ,[2018-04-15] ,[2018-04-16]) " & vbCrlf
sqlStr = sqlStr & " ) A "


rsget.Open sqlStr,dbget,1
If not rsget.EOF Then
	win1 = rsget("win1")
	win2 = rsget("win2")
	win3 = rsget("win3")
	win4 = rsget("win4")
	win5 = rsget("win5")
	win6 = rsget("win6")
	win7 = rsget("win7")
	win8 = rsget("win8")
	win9 = rsget("win9")
	win10 = rsget("win10")
	win11 = rsget("win11")
	win12 = rsget("win12")
	win13 = rsget("win13")
	win14 = rsget("win14")
	win15 = rsget("win15")
End If
rsget.close
'#################################################################################################
'// 상품 당첨 여부 onoff
Function onoffimg(v)
	Select Case CStr(v)
		Case "2018-04-02"
			onoffimg = chkiif(win1<>"","<img src='http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/today_soldout_0402.jpg?v=1' alt='' />","<img src='http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/today_0402.jpg?v=1' alt='' />")
		Case "2018-04-03"
			onoffimg = chkiif(win2<>"","<img src='http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/today_soldout_0403.jpg?v=1' alt='' />","<img src='http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/today_0403.jpg?v=1' alt='' />")
		Case "2018-04-04"
			onoffimg = chkiif(win3<>"","<img src='http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/today_soldout_0404.jpg?v=1' alt='' />","<img src='http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/today_0404.jpg?v=1' alt='' />")
		Case "2018-04-05"
			onoffimg = chkiif(win4<>"","<img src='http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/today_soldout_0405.jpg?v=1' alt='' />","<img src='http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/today_0405.jpg?v=1' alt='' />")
		Case "2018-04-06"
			onoffimg = chkiif(win5<>"","<img src='http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/today_soldout_0406.jpg?v=1' alt='' />","<img src='http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/today_0406.jpg?v=1' alt='' />")
		Case "2018-04-07"
			onoffimg = chkiif(win6<>"","<img src='http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/today_soldout_0407.jpg?v=1' alt='' />","<img src='http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/today_0407.jpg?v=1' alt='' />")
		Case "2018-04-08"
			onoffimg = chkiif(win7<>"","<img src='http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/today_soldout_0408.jpg?v=1' alt='' />","<img src='http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/today_0408.jpg?v=1' alt='' />")
		Case "2018-04-09"
			onoffimg = chkiif(win8<>"","<img src='http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/today_soldout_0409.jpg?v=1' alt='' />","<img src='http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/today_0409.jpg?v=1' alt='' />")
		Case "2018-04-10"
			onoffimg = chkiif(win9<>"","<img src='http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/today_soldout_0410.jpg?v=1' alt='' />","<img src='http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/today_0410.jpg?v=1' alt='' />")
		Case "2018-04-11"
			onoffimg = chkiif(win10<>"","<img src='http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/today_soldout_0411.jpg?v=1' alt='' />","<img src='http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/today_0411.jpg?v=1' alt='' />")
		Case "2018-04-12"
			onoffimg = chkiif(win11<>"","<img src='http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/today_soldout_0412.jpg?v=1' alt='' />","<img src='http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/today_0412.jpg?v=1' alt='' />")
		Case "2018-04-13"
			onoffimg = chkiif(win12<>"","<img src='http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/today_soldout_0413.jpg?v=1' alt='' />","<img src='http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/today_0413.jpg?v=1' alt='' />")
		Case "2018-04-14"
			onoffimg = chkiif(win13<>"","<img src='http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/today_soldout_0414.jpg?v=1' alt='' />","<img src='http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/today_0414.jpg?v=1' alt='' />")
		Case "2018-04-15"
			onoffimg = chkiif(win14<>"","<img src='http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/today_soldout_0415.jpg?v=1' alt='' />","<img src='http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/today_0415.jpg?v=1' alt='' />")
		Case "2018-04-16"
			onoffimg = chkiif(win15<>"","<img src='http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/today_soldout_0416.jpg?v=1' alt='' />","<img src='http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/today_0416.jpg?v=1' alt='' />")
		Case Else
			onoffimg = chkiif(win1<>"","<img src='http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/today_soldout_0402.jpg?v=1' alt='' />","<img src='http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/today_0402.jpg?v=1' alt='' />")
	end Select
End function

'// 2배배너 노출 시간
Function doubletime(v)
	Select Case CStr(v)
		Case "2018-04-02"
			doubletime = chkiif(hour(now) < 14,"<span></span><p><img src='http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/txt_double_0402.png' alt='' /></p>","")
		Case "2018-04-03"
			doubletime = chkiif(hour(now) < 18,"<span></span><p><img src='http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/txt_double_0403.png' alt='' /></p>","")
		Case "2018-04-04"
			doubletime = chkiif(hour(now) < 20,"<span></span><p><img src='http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/txt_double_0404.png' alt='' /></p>","")
		Case "2018-04-05"
			doubletime = chkiif(hour(now) < 13,"<span></span><p><img src='http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/txt_double_0405.png' alt='' /></p>","")
		Case "2018-04-06"
			doubletime = chkiif(hour(now) < 11,"<span></span><p><img src='http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/txt_double_0406.png' alt='' /></p>","")
		Case "2018-04-07"
			doubletime = chkiif(hour(now) < 16,"<span></span><p><img src='http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/txt_double_0407.png' alt='' /></p>","")
		Case "2018-04-08"
			doubletime = chkiif(hour(now) < 11,"<span></span><p><img src='http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/txt_double_0408.png' alt='' /></p>","")
		Case "2018-04-09"
			doubletime = chkiif(hour(now) < 20,"<span></span><p><img src='http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/txt_double_0409.png?v=1' alt='' /></p>","")
		Case "2018-04-10"
			doubletime = chkiif(hour(now) < 16,"<span></span><p><img src='http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/txt_double_0410.png?v=1' alt='' /></p>","")
		Case "2018-04-11"
			doubletime = chkiif(hour(now) < 20,"<span></span><p><img src='http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/txt_double_0411.png?v=1' alt='' /></p>","")
		Case "2018-04-12"
			doubletime = chkiif(hour(now) < 17,"<span></span><p><img src='http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/txt_double_0412.png?v=1' alt='' /></p>","")
		Case "2018-04-13"
			doubletime = chkiif(hour(now) < 19,"<span></span><p><img src='http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/txt_double_0413.png?v=1' alt='' /></p>","")
		Case "2018-04-14"
			doubletime = chkiif(hour(now) < 13,"<span></span><p><img src='http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/txt_double_0414.png?v=1' alt='' /></p>","")
		Case "2018-04-15"
			doubletime = chkiif(hour(now) < 16,"<span></span><p><img src='http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/txt_double_0415.png?v=1' alt='' /></p>","")
		Case "2018-04-16"
			doubletime = chkiif(hour(now) < 19,"<span></span><p><img src='http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/txt_double_0416.png?v=1' alt='' /></p>","")
		Case Else
			doubletime = chkiif(hour(now) < 14,"<span></span><p><img src='http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/txt_double_0402.png' alt='' /></p>","")
	end Select
End Function

'// 당첨 여부
Function statewinlose(v)
	Select Case CStr(v)
		Case "2018-04-02"
			statewinlose = chkiif(win1<>"",true,false)
		Case "2018-04-03"
			statewinlose = chkiif(win2<>"",true,false)
		Case "2018-04-04"
			statewinlose = chkiif(win3<>"",true,false)
		Case "2018-04-05"
			statewinlose = chkiif(win4<>"",true,false)
		Case "2018-04-06"
			statewinlose = chkiif(win5<>"",true,false)
		Case "2018-04-07"
			statewinlose = chkiif(win6<>"",true,false)
		Case "2018-04-08"
			statewinlose = chkiif(win7<>"",true,false)
		Case "2018-04-09"
			statewinlose = chkiif(win8<>"",true,false)
		Case "2018-04-10"
			statewinlose = chkiif(win9<>"",true,false)
		Case "2018-04-11"
			statewinlose = chkiif(win10<>"",true,false)
		Case "2018-04-12"
			statewinlose = chkiif(win11<>"",true,false)
		Case "2018-04-13"
			statewinlose = chkiif(win12<>"",true,false)
		Case "2018-04-14"
			statewinlose = chkiif(win13<>"",true,false)
		Case "2018-04-15"
			statewinlose = chkiif(win14<>"",true,false)
		Case "2018-04-16"
			statewinlose = chkiif(win15<>"",true,false)
		Case Else
			statewinlose = chkiif(win1<>"",true,false)
	end Select
End function										

%>
<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
.tenq .inner {position:relative; width:1140px; margin:0 auto;}
.tenq button {background-color:transparent; vertical-align:top;}

.miracle {margin-top:-45px !important}
.miracle {background-color:#2b3fae;}
.miracle .topic .project {padding:113px 0 32px;}
.miracle .topic h2 {padding-bottom:38px;}

.miracle .challenge {position:relative; width:950px; height:832px; margin:0 auto;}
.miracle .challenge .double {position:absolute; right:148px; top:72px; width:184px; height:184px;}
.miracle .challenge .double span {display:block; position:absolute; left:0; top:0; width:184px; height:184px; background:url(http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/bg_line.png) 50% 50% no-repeat; animation:move1 1.2s infinite cubic-bezier(1,.1,.7,.46);}
.miracle .challenge .btn-group {position:absolute; left:50%; top:550px; width:364px; margin-left:-182px;}
.miracle .challenge .btn-group button {display:block; margin-bottom:15px;}

.miracle .share {padding:75px 0; text-align:left; background-color:#ff57d9;}
.miracle .share p {padding-left:108px;}
.miracle .share a {position:absolute; right:132px; top:2px;}

.miracle .winner {padding:94px 0 112px; background-color:#ffcae5;}
.miracle .winner h3 {padding-bottom:65px;}
.miracle .winner .list {position:relative;}
.miracle .winner .swiper-container,.miracle .winner .swiper-wrapper {height:290px;}
.miracle .winner .swiper-container {width:1075px; margin:0 auto;}
.miracle .winner button {position:absolute; top:127px; outline:none;}
.miracle .winner button.btn-prev {left:-31px;}
.miracle .winner button.btn-next {right:-31px;}
.miracle .winner .swiper-slide {float:left; width:215px;}
.miracle .winner .item {width:182px; height:263px; margin:0 auto; background-image:url(http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/img_next.png?v=1); background-repeat:no-repeat;}

.miracle .winner .date0402 .item {background-position:-860px 0;}
.miracle .winner .date0403 .item {background-position:-645px 0;}
.miracle .winner .date0404 .item {background-position:-430px 0;}
.miracle .winner .date0405 .item {background-position:-215px 0;}
.miracle .winner .date0406 .item {background-position:0 0;}
.miracle .winner .date0407 .item {background-position:-860px -274px;}
.miracle .winner .date0408 .item {background-position:-645px -274px;}
.miracle .winner .date0409 .item {background-position:-430px -274px;}
.miracle .winner .date0410 .item {background-position:-215px -274px;}
.miracle .winner .date0411 .item {background-position:0 -274px;}
.miracle .winner .date0412 .item {background-position:-860px -548px;}
.miracle .winner .date0413 .item {background-position:-645px -548px;}
.miracle .winner .date0414 .item {background-position:-430px -548px;}
.miracle .winner .date0415 .item {background-position:-215px -548px;}
.miracle .winner .date0416 .item {background-position:0 -548px;}

.miracle .winner .name {display:none; padding-top:12px; font:bold 14px/1 dotum; color:#2b3fae;}
.miracle .winner .finish .item {background-image:url(http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/img_winner_is.png?v=1);}
.miracle .winner .finish .name {display:block;}
.miracle .noti {padding:80px 0; background:#131a43;}
.miracle .noti h3 {position:absolute; left:135px; top:50%; margin-top:-14px;}
.miracle .noti ul {padding-left:332px; text-align:left;}
.miracle .noti li {color:#fff; padding:18px 0 0 11px; line-height:16px; text-indent:-11px;}
.miracle .noti li:first-child {padding-top:0;}

.layer {position:fixed; left:50% !important; top:50% !important; z-index:99999; background-color:#f4f5fb; border-radius:20px; box-shadow:0 0 50px 50px rgba(0,0,0,.1);}
.layer .btn-close {position:absolute; right:24px; top:27px; background-color:transparent;}
.layer-schedule {width:1022px; height:704px; margin:-352px 0 0 -511px;}
.layer-result {width:880px; height:675px; margin:-337px 0 0 -440px; text-align:center;}
.layer-result .code {position:absolute; left:24px; bottom:20px; color:#d1d1d1; font-size:13px;}

.scrollbarwrap {width:944px; height:400px; margin:0 auto;}
.scrollbarwrap .viewport {width:924px; height:445px;}
.scrollbarwrap .overview {color:#666; line-height:18px; padding-bottom:60px; text-align:center;}
.scrollbarwrap .scrollbar {float:right; position:relative; width:6px; height:400px !important;}
.scrollbarwrap .track {position: relative; width:10px; height:400px !important; background-color:#fff; border-radius:12px;}
.scrollbarwrap .thumb {overflow:hidden; position:absolute; top: 0; left:-2px; width:14px; height:24px; background:url(http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/bg_scroll.png?v=1.3) 50% 0 no-repeat; cursor:pointer; border-radius:12px;}
.scrollbarwrap .thumb .end {overflow:hidden; width:3px; height:5px;}
.scrollbarwrap .disable {display:none;}

@keyframes move1 {
	from {transform:rotate(0);}
	to {transform:rotate(360deg);}
}
</style>
<script src="/lib/js/jquery.tinyscrollbar.js"></script>
<script style="text/javascript">
$(function(){
	// 지난당첨자
	var winnerSwiper = new Swiper('.winner .swiper-container',{
		slidesPerView:5,
		slidesPerGroup :5,
		speed:900,
		<% if date() > "2018-04-06" and date() < "2018-04-12" then %>
		initialSlide : 5 ,
		<% elseif date() > "2018-04-11" then %>
		initialSlide : 10 ,
		<% end if %>
		onSlideChangeStart: function (winnerSwiper) {
			$('.winner .btn-prev').fadeIn();
			$('.winner .btn-next').fadeIn();
			if ($('.date0402').hasClass('swiper-slide-visible')) {
				$('.winner .btn-prev').fadeOut();
			}
			if ($('.date0416').hasClass('swiper-slide-visible')) {
				$('.winner .btn-next').fadeOut();
			}
		}
	});
	if ($('.date0402').hasClass('swiper-slide-visible')) {
		$('.winner .btn-prev').fadeOut();
	}
	if ($('.date0416').hasClass('swiper-slide-visible')) {
		$('.winner .btn-next').fadeOut();
	}
	$('.winner .btn-prev').on('click', function(e){
		e.preventDefault();
		$('.winner .btn-next').fadeIn();
		winnerSwiper.swipePrev();
	})
	$('.winner .btn-next').on('click', function(e){
		e.preventDefault();
		$('.winner .btn-prev').fadeIn();
		winnerSwiper.swipeNext();
	});

	// 일정보기 스크롤
	$('.btn-schedule').click(function(){
		$('.scrollbarwrap').tinyscrollbar();
	});
});

// gogogo
function checkmyprize(){
	<% If Not(IsUserLoginOK) Then %>
		if ("<%=IsUserLoginOK%>"=="False") {
			if(confirm("로그인을 하셔야 응모할 수 있습니다.")){
				var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
				winLogin.focus();
				return;
			}
		}
	<% else %>
		<% If Now() > #03/25/2018 23:59:59# And Now() < #04/16/2018 23:59:59# Then '테스트용 %>
		<%' If Now() > #04/01/2018 23:59:59# And Now() < #04/16/2018 23:59:59# Then %>
			$.ajax({
				type:"GET",
				url:"/event/tenq/miracle_proc.asp",
				data: "mode=add",
				dataType: "text",
				async:false,
				cache:true,
				success : function(Data, textStatus, jqXHR){
					if (jqXHR.readyState == 4) {
						if (jqXHR.status == 200) {
							//console.log(Data);
							if(Data!="") {
								var str;
								for(var i in Data){
									 if(Data.hasOwnProperty(i)){
										str += Data[i];
									}
								}
								str = str.replace("undefined","");
								res = str.split("|");
								//console.log(res[1]);
								if (res[0]=="OK"){
									$("#resulthtml").empty().html(res[1]);
									viewPoupLayer('modal',$('#lyrResult').html());
									return false;
								} else {
									errorMsg = res[1].replace(">?n", "\n");
									alert(errorMsg);
									document.location.reload();
									return false;
								}
							} else {
								alert("잘못된 접근 입니다.");
								document.location.reload();
								return false;
							}
						}
					}
				},
				error:function(jqXHR, textStatus, errorThrown){
					alert("잘못된 접근 입니다.");
					document.location.reload();
					return false;
				}
			});
		<% Else %>
			alert("이벤트 응모 기간이 아닙니다.");
			return;				
		<% End If %>
	<% End If %>
}

function sharesns(snsnum) {
	<% If vUserID = "" Then %>
		if ("<%=IsUserLoginOK%>"=="False") {
			if(confirm("로그인을 하셔야 응모할 수 있습니다.")){
				var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
				winLogin.focus();
				return;
			}
		}
	<% End If %>
	<% If vUserID <> "" Then %>
		var reStr;
		var str = $.ajax({
			type: "GET",
			url:"/event/tenq/miracle_proc.asp",
			data: "mode=snschk&snsnum="+snsnum,
			dataType: "text",
			async: false
		}).responseText;
			reStr = str.split("|");
			if(reStr[1] == "tw") {
				popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>');
			}else if(reStr[1]=="fb"){
				popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','');
			}else if(reStr[1]=="pt"){
				popSNSPost('pt','<%=snpTitle%>','<%=snpLink%>','','<%=snpImg%>');
			}else if(reStr[1] == "none"){
				alert('참여 이력이 없습니다.\n응모후 이용 하세요');
				return false;
			}else if(reStr[1] == "end"){
				alert('공유는 하루에 1회만 가능합니다.');
				return false;
			}else{
				alert('오류가 발생했습니다.');
				return false;
			}
	<% End If %>
}


function goDirOrdItem(tm){
<% If IsUserLoginOK() Then %>
	<%' If Now() > #03/25/2018 23:59:59# And Now() < #04/16/2018 23:59:59# Then '테스트용 %>
	<% If Now() > #04/01/2018 23:59:59# And Now() < #04/16/2018 23:59:59# Then %>
		$("#itemid").val(tm);
		document.directOrd.submit();
	<% else %>
		alert("이벤트 응모 기간이 아닙니다.");
		return;
	<% end if %>
<% Else %>
	if(confirm("로그인을 하셔야 응모할 수 있습니다.")){
		top.location.href="/login/loginpage.asp?vType=G";
		return false;
	}
<% End IF %>
}
</script>
</head>
<body>
<div id="eventDetailV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container fullEvt">
		<div id="contentWrap">
			<div class="eventWrapV15">
				<div class="eventContV15 tMar15">
					<div class="contF contW">
						<!-- 텐큐베리감사 : 100원의 기적 -->
						<div class="evt85145 tenq miracle">
							<%' nav 영역 %>
							<!-- #include virtual="/event/tenq/nav.asp" -->
							<div class="topic">
								<p class="project"><img src="http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/txt_project.png" alt="10x10=100 Project" /></p>
								<h2><img src="http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/tit_miracle_100.png" alt="100원의 기적" /></h2>
								<p class="subcopy"><img src="http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/txt_subcopy.png" alt="엄청난 상품을 100원에 구매할 수 있는 기적에 도전하세요!" /></p>
							</div>

							<%'!-- 응모 --%>
							<div class="challenge">
								<%'!-- 오늘의 상품 : 날짜별로 이미지명 바뀜 (0402~0416) --%>
								<div class="today-item">
									<div>
										<%=onoffimg(actdate)%>
									</div>
								</div>
								<%'!-- 당첨확률 2배 : 날짜별로 이미지명 바뀜 (0402~0416) --%>
								<div class="double">
									<%=doubletime(actdate)%>
								</div>
								<div class="btn-group">
									<% If statewinlose(actdate) Then %>
									<button class="btn-soldout"><img src="http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/btn_soldout.png" alt="오늘의 당첨자가 나왔습니다" /></button>									
									<% Else %>
									<button class="btn-submit" onclick="checkmyprize();"><img src="http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/btn_miracle.png" alt="기적에 도전하기" /></button>
									<% End If %>
									<button class="btn-schedule" onclick="viewPoupLayer('modal',$('#lyrSch').html());return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/btn_schedule.png" alt="일정 보기" /></button>
								</div>

								<%'!-- 응모결과 레이어 --%>
								<div id="lyrResult" style="display:none;">
									<div class="layer layer-result">
										<div id="resulthtml"></div>
										<button type="button" class="btn-close" onclick="ClosePopLayer()"><img src="http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/btn_close.png" alt="닫기" /></button>
									</div>
								</div>

								<%'!-- 일정 보기 레이어 --%>
								<div id="lyrSch" style="display:none;">
									<div class="layer layer-schedule">
										<h3><img src="http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/tit_schedule.png" alt="100원의 기적 상품 일정표" /></h3>
										<div class="scrollbarwrap">
											<div class="scrollbar"><div class="track"><div class="thumb"><div class="end"></div></div></div></div>
											<div class="viewport">
												<div class="overview">
													<div><img src="http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/img_item_list.png" alt="100원의 기적 상품 일정표" usemap="#itemMap" /></div>
													<map name="itemMap" id="itemMap">
														<area shape="rect" onfocus="this.blur();" coords="3,44,151,225" href="/shopping/category_prd.asp?itemid=1913823&pEtr=85145" alt="LG그램 13인치" />
														<area shape="rect" onfocus="this.blur();" coords="174,43,326,226" href="/shopping/category_prd.asp?itemid=1865049&pEtr=85145" alt="닌텐도 스위치 본체" />
														<area shape="rect" onfocus="this.blur();" coords="524,42,675,226" href="/shopping/category_prd.asp?itemid=1675624&pEtr=85145" alt="브리츠 멀티플레이어" />
														<area shape="rect" onfocus="this.blur();" coords="699,43,846,227" href="/shopping/category_prd.asp?itemid=1551196&pEtr=85145" alt="소니 미러리스 A6000L" />
														<area shape="rect" onfocus="this.blur();" coords="3,331,150,513" href="/shopping/category_prd.asp?itemid=1844676&pEtr=85145" alt="다이슨 헤어드라이어" />
														<area shape="rect" onfocus="this.blur();" coords="175,331,325,514" href="/shopping/category_prd.asp?itemid=1191473&pEtr=85145" alt="발뮤다 공기청정기" />
														<area shape="rect" onfocus="this.blur();" coords="525,331,676,513" href="/shopping/category_prd.asp?itemid=884073&pEtr=85145" alt="미스터 마리아 미피 램프S" />
														<area shape="rect" onfocus="this.blur();" coords="698,331,845,510" href="/shopping/category_prd.asp?itemid=1918634&pEtr=85145" alt="다이슨 V10 앱솔루트" />
														<area shape="rect" onfocus="this.blur();" coords="3,622,151,799" href="/shopping/category_prd.asp?itemid=1740531&pEtr=85145" alt="드롱기 커피머신" />
														<area shape="rect" onfocus="this.blur();" coords="176,621,324,797" href="/shopping/category_prd.asp?itemid=1710848&pEtr=85145" alt="발뮤다 더 팟 전기주전자" />
														<area shape="rect" onfocus="this.blur();" coords="350,623,498,799" href="/shopping/category_prd.asp?itemid=1404033&pEtr=85145" alt="폴라로이드 즉석 카메라" />
														<area shape="rect" onfocus="this.blur();" coords="524,621,673,798" href="/shopping/category_prd.asp?itemid=1485011&pEtr=85145" alt="포켓 빔프로젝터" />
														<area shape="rect" onfocus="this.blur();" coords="699,622,846,799" href="/shopping/category_prd.asp?itemid=1404416&pEtr=85145" alt="발뮤다 더 토스터" />
													</map>
												</div>
											</div>
										</div>
										<button type="button" class="btn-close" onclick="ClosePopLayer()"><img src="http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/btn_close.png" alt="닫기" /></button>
									</div>
								</div>
							</div>

							<%'!-- SNS공유 --%>
							<div class="share" id="moreshare" style="display:<%=chkiif(myevtdaycnt = 1 ,"","none")%>;">
								<div class="inner">
									<p><img src="http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/txt_friend.png" alt="다시 응모하고 싶을 땐, 친구찬스!" /></p>
									<a href="" onclick="sharesns('fb');return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/btn_facebook.png" alt="페이스북으로 공유하기" /></a>
								</div>
							</div>

							<%'!-- 지난 당첨자 --%>
							<div class="winner">
								<div class="inner">
									<h3><img src="http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/tit_winner.png" alt="지난 당첨자를 소개합니다" /></h3>
									<div class="list">
										<div class="swiper-container">
											<div class="swiper-wrapper">
												<%'!-- for dev msg : 당첨자 발표 후에는 클래스 finish 붙여주세요 --%>
												<div class="swiper-slide date0402<%=chkiif(win1<>""," finish","")%>">
													<div class="item"></div>
													<%=chkiif(win1<>"","<p class='name'>"& printUserId(win1,2,"*") &"</p>","")%>
												</div>
												<div class="swiper-slide date0403<%=chkiif(win2<>""," finish","")%>">
													<div class="item"></div>
													<%=chkiif(win2<>"","<p class='name'>"& printUserId(win2,2,"*") &"</p>","")%>
												</div>
												<div class="swiper-slide date0404<%=chkiif(win3<>""," finish","")%>">
													<div class="item"></div>
													<%=chkiif(win3<>"","<p class='name'>"& printUserId(win3,2,"*") &"</p>","")%>
												</div>
												<div class="swiper-slide date0405<%=chkiif(win4<>""," finish","")%>">
													<div class="item"></div>
													<%=chkiif(win4<>"","<p class='name'>"& printUserId(win4,2,"*") &"</p>","")%>
												</div>
												<div class="swiper-slide date0406<%=chkiif(win5<>""," finish","")%>">
													<div class="item"></div>
													<%=chkiif(win5<>"","<p class='name'>"& printUserId(win5,2,"*") &"</p>","")%>
												</div>
												<div class="swiper-slide date0407<%=chkiif(win6<>""," finish","")%>">
													<div class="item"></div>
													<%=chkiif(win6<>"","<p class='name'>"& printUserId(win6,2,"*") &"</p>","")%>
												</div>
												<div class="swiper-slide date0408<%=chkiif(win7<>""," finish","")%>">
													<div class="item"></div>
													<%=chkiif(win7<>"","<p class='name'>"& printUserId(win7,2,"*") &"</p>","")%>
												</div>
												<div class="swiper-slide date0409<%=chkiif(win8<>""," finish","")%>">
													<div class="item"></div>
													<%=chkiif(win8<>"","<p class='name'>"& printUserId(win8,2,"*") &"</p>","")%>
												</div>
												<div class="swiper-slide date0410<%=chkiif(win9<>""," finish","")%>">
													<div class="item"></div>
													<%=chkiif(win9<>"","<p class='name'>"& printUserId(win9,2,"*") &"</p>","")%>
												</div>
												<div class="swiper-slide date0411<%=chkiif(win10<>""," finish","")%>">
													<div class="item"></div>
													<%=chkiif(win10<>"","<p class='name'>"& printUserId(win10,2,"*") &"</p>","")%>
												</div>
												<div class="swiper-slide date0412<%=chkiif(win11<>""," finish","")%>">
													<div class="item"></div>
													<%=chkiif(win11<>"","<p class='name'>"& printUserId(win11,2,"*") &"</p>","")%>
												</div>
												<div class="swiper-slide date0413<%=chkiif(win12<>""," finish","")%>">
													<div class="item"></div>
													<%=chkiif(win12<>"","<p class='name'>"& printUserId(win12,2,"*") &"</p>","")%>
												</div>
												<div class="swiper-slide date0414<%=chkiif(win13<>""," finish","")%>">
													<div class="item"></div>
													<%=chkiif(win13<>"","<p class='name'>"& printUserId(win13,2,"*") &"</p>","")%>
												</div>
												<div class="swiper-slide date0415<%=chkiif(win14<>""," finish","")%>">
													<div class="item"></div>
													<%=chkiif(win14<>"","<p class='name'>"& printUserId(win14,2,"*") &"</p>","")%>
												</div>
												<div class="swiper-slide date0416<%=chkiif(win15<>""," finish","")%>">
													<div class="item"></div>
													<%=chkiif(win15<>"","<p class='name'>"& printUserId(win15,2,"*") &"</p>","")%>
												</div>
											</div>
										</div>
										<button class="btn-prev"><img src="http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/btn_prev.png" alt="이전" /></button>
										<button class="btn-next"><img src="http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/btn_next.png" alt="다음" /></button>
									</div>
								</div>
							</div>

							<%'!-- 유의사항 --%>
							<div class="noti">
								<div class="inner">
									<h3><img src="http://webimage.10x10.co.kr/eventIMG/2018/tenq/85145/tit_noti.png" alt="유의사항" /></h3>
									<ul>
										<li>- 100원의 기적은 매일 다른 상품(총 15개)으로 새롭게 구성됩니다.</li>
										<li>- 구매자에게는 상품에 따라 세무신고에 필요한 개인정보를 요청할 수 있습니다. 제세공과금은 텐바이텐 부담입니다.</li>
										<li>- 본 이벤트의 상품은 즉시 결제로만 구매할 수 있으며 배송 후 반품/교환/구매취소가 불가능합니다.<br />하루에 ID 당 1회 응모만 가능하며 친구 초대 시, 한 번 더 응모 기회가 주어집니다.</li>
										<li>- 무료배송쿠폰은 ID 당 하루에 최대 2회까지 발행되며 발급 당일 자정 기준으로 자동 소멸합니다.<br />(1만 원 이상 구매 시, 텐바이텐 배송상품만 사용 가능)</li>
									</ul>
								</div>
							</div>
						</div>
						<%'!--// 텐큐베리감사 : 100원의 기적 --%>
					</div>
				</div>
			</div>
		</div>
	</div>
	<form method="post" name="directOrd" action="/inipay/shoppingbag_process.asp">
		<input type="hidden" name="itemid" id="itemid" value="">
		<input type="hidden" name="itemoption" value="0000">
		<input type="hidden" name="itemea" value="1">
		<input type="hidden" name="mode" value="DO1">
	</form>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->