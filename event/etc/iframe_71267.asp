<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  [SUMMER BRAND WEEK]
' History : 2016-06-13 김진영 생성
'####################################################
%>
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<!-- #INCLUDE Virtual="/lib/util/pageformlib.asp" -->
<%
Dim evt_code : evt_code = request("eventid")
Dim styleSTR, currentDate, i

IF application("Svr_Info") = "Dev" THEN	'	테섭이벤트코드
	currentDate =  date()+1
Else
	currentDate =  date()
End If

Dim vEventID, vStartNo
vEventID = requestCheckVar(Request("eventid"),6)

Select Case vEventID
	Case "71267"		vStartNo = 0
	Case "71315"		vStartNo = 1
	Case "71304"		vStartNo = 2
	Case "71333"		vStartNo = 3
	Case "71335"		vStartNo = 4
	Case "71317"		vStartNo = 5
	Case "71322"		vStartNo = 6
	Case "71318"		vStartNo = 7
	Case "71320"		vStartNo = 8
	Case "71312"		vStartNo = 9
	Case "71336"		vStartNo = 10
	Case "71337"		vStartNo = 11
	Case "71334"		vStartNo = 12
	Case "71313"		vStartNo = 13
	Case "71319"		vStartNo = 14
	Case "71316"		vStartNo = 15
	Case Else			vStartNo = 0
End Select
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
img {vertical-align:top;}
.navigator {overflow:hidden; position:relative; height:213px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/71267/bg_brand_tab.jpg) no-repeat 0 0;}
.navigator .swiper1 {overflow:hidden; position:relative; width:890px; height:161px; margin:0 auto; padding:26px 0; text-align:left;}
.navigator .swiper-wrapper {overflow:hidden;}
.navigator .swiper1 .swiper-slide {float:left; width:158px !important; padding:0 10px;}
.navigator .swiper1 .swiper-slide span {display:block; width:158px; height:161px; background-position:0 0; background-repeat:no-repeat;}
.navigator .swiper1 .swiper-slide.date0615 span {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/71267/tab_0615.png);}
.navigator .swiper1 .swiper-slide.date0616 span {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/71267/tab_0616.png);}
.navigator .swiper1 .swiper-slide.date0617 span {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/71267/tab_0617.png);}
.navigator .swiper1 .swiper-slide.date0618 span {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/71267/tab_0618.png);}
.navigator .swiper1 .swiper-slide.date0619 span {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/71267/tab_0619_v1.png);}
.navigator .swiper1 .swiper-slide.date0620 span {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/71267/tab_0620.png);}
.navigator .swiper1 .swiper-slide.date0621 span {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/71267/tab_0621.png);}
.navigator .swiper1 .swiper-slide.date0622 span {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/71267/tab_0622.png);}
.navigator .swiper1 .swiper-slide.date0623 span {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/71267/tab_0623.png);}
.navigator .swiper1 .swiper-slide.date0624 span {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/71267/tab_0624.png);}
.navigator .swiper1 .swiper-slide.date0625 span {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/71267/tab_0625.png);}
.navigator .swiper1 .swiper-slide.date0626 span {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/71267/tab_0626.png);}
.navigator .swiper1 .swiper-slide.date0627 span {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/71267/tab_0627.png);}
.navigator .swiper1 .swiper-slide.date0628 span {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/71267/tab_0628.png);}
.navigator .swiper1 .swiper-slide.date0629 span {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/71267/tab_0629.png);}
.navigator .swiper1 .swiper-slide.date0630 span {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/71267/tab_0630.png);}
.navigator .swiper1 .swiper-slide a {display:none; width:158px; height:161px;}
.navigator .swiper1 .swiper-slide.current span {background-position:0 -161px;}
.navigator .swiper1 .swiper-slide.current span a,
.navigator .swiper1 .swiper-slide.finish span a {display:block; text-indent:-9999px;}
.navigator .swiper1 .swiper-slide.finish span {background-position:0 100%;}
.navigator button {display:block; position:absolute; top:0; z-index:50; background:transparent;}
.navigator .prev {left:60px;}
.navigator .next {right:60px;}
</style>
<script type="text/javascript">
$(function(){
	/* swipe */
	var mySwiper = new Swiper('.swiper1',{
		initialSlide:<%=vStartNo%>,
		speed:500,
		autoplay:false,
		slidesPerView:5,
		pagination:false,
		nextButton:'.next',
		prevButton:'.prev'
	})
	$('.prev').on('click', function(e){
		e.preventDefault()
		mySwiper.swipePrev()
	})
	$('.next').on('click', function(e){
		e.preventDefault()
		mySwiper.swipeNext()
	});
});
</script>
</head>
<body>
<div class="navigator">
	<div class="swiper-container swiper1">
		<div class="swiper-wrapper">
		<%
		For i = 15 to 30 
			If i = day(currentDate) Then
				styleSTR = " current"
			ElseIf i > day(currentDate) Then
				styleSTR = ""
			Else
				styleSTR = " finish"
			End If
			Select Case i
				Case "15"		evt_code = "71267"
				Case "16"		evt_code = "71315"
				Case "17"		evt_code = "71304"
				Case "18"		evt_code = "71333"
				Case "19"		evt_code = "71335"
				Case "20"		evt_code = "71317"
				Case "21"		evt_code = "71322"
				Case "22"		evt_code = "71318"
				Case "23"		evt_code = "71320"
				Case "24"		evt_code = "71312"
				Case "25"		evt_code = "71336"
				Case "26"		evt_code = "71337"
				Case "27"		evt_code = "71334"
				Case "28"		evt_code = "71313"
				Case "29"		evt_code = "71319"
				Case "30"		evt_code = "71316"
			End Select
		%>
			<div class="swiper-slide date06<%= i %> <%= styleSTR %>"><span><a href="/event/eventmain.asp?eventid=<%= evt_code %>" target="_top">6월 <%= i %>일</a></span></div><%' 해당 날짜일때 current / 지나면 finish / 이후는 없음 %>
		<% Next %>
		</div>
	</div>
	<button type="button" class="prev"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71267/btn_prev.png" alt="이전" /></button>
	<button type="button" class="next"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71267/btn_next.png" alt="다음" /></button>
</div>
</body>
</html>