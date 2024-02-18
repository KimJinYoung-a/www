<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/inc/head.asp" -->
<%
dim currentdate
	currentdate = date()
	'currentdate = "2019-12-02"
	'response.write currentdate

	Dim vEventID, vStartNo
	vEventID = requestCheckVar(Request("eventid"),9)
	If vEventID = "110839" Then '// vol.1
		vStartNo = "0"
	ElseIf vEventID = "111316" Then '// vol.2
		vStartNo = "0"
	ElseIf vEventID = "111704" Then '// vol.3
		vStartNo = "1"
	ElseIf vEventID = "112715" Then '// vol.4
		vStartNo = "2"
	ElseIf vEventID = "" Then '// vol.5
		vStartNo = "3"
	ElseIf vEventID = "" Then '// vol.6
		vStartNo = "4"
	ElseIf vEventID = "" Then '// vol.7
		vStartNo = "5"
	ElseIf vEventID = "" Then '// vol.8
		vStartNo = "6"
	else
		vStartNo = "0"
	End IF
%>
<style type="text/css">
.navigator {position:relative; overflow:hidden; width:1140px; margin:0 auto;}
.navigator h2 {float:left; padding-top:5px;}
.navigator .swiper-container {float:right; width:300px; padding:0 40px;}
.navigator .swiper-wrapper {display:flex;}
.navigator .swiper-slide {width:33.3%; height:60px;}
.navigator .swiper-slide span,
.navigator .swiper-slide a {display:flex; justify-content:center; align-items:center; width:100%; height:100%; text-align:center; color:#909090; text-decoration:none;}
.navigator .swiper-slide span {font-size:18px; line-height:20px;}
.navigator .swiper-slide a {font-size:20px;}
.navigator .swiper-slide.current a {position:relative; color:#484848; font-weight:700;}
.navigator button {position:absolute; top:0; z-index:100; width:40px; height:100%; background:#fff url(//webimage.10x10.co.kr/eventIMG/2020/101636/btn_nav.png) 50% 50% no-repeat; font-size:0;}
.navigator .btn-prev {left:0;}
.navigator .btn-next {right:0; transform:scaleX(-1);}
</style>
<script type="text/javascript">
$(function(){
	var evtSwiper = new Swiper('.navigator .swiper-container',{
		initialSlide:<%=vStartNo%>,
		slidesPerView:3,
		speed:300
	});
	$('.navigator .btn-prev').on('click', function(e){
		e.preventDefault();
		evtSwiper.swipePrev();
	})
	$('.navigator .btn-next').on('click', function(e){
		e.preventDefault();
		evtSwiper.swipeNext();
	});
	$('.navigator .coming').on('click', function(e){
		e.preventDefault();
		alert("오픈 예정 기획전 입니다 :)");
	});
});
</script>
</head>
<body>
<div id="navigator" class="navigator">
	<h2><img src="//webimage.10x10.co.kr/fixevent/event/2021/110839/tit_newitem.png" alt="먼슬리 신상"></h2>
	<div class="swiper-container">
		<ul class="swiper-wrapper">
			<%' 오픈된 이벤트 open, 오늘 날짜에 current 클래스 넣어주세요 %>
			<% if currentdate < "2021-05-03" then %>
			<li class="swiper-slide coming"><span>Vol.1</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="110839"," current","")%>">
				<a href="/event/eventmain.asp?eventid=110839" target="_top">Vol.1</a>
			<% End If %>
			</li>

			<% if currentdate < "2021-05-17" then %>
			<li class="swiper-slide coming"><span>Vol.2</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="111316"," current","")%>">
				<a href="/event/eventmain.asp?eventid=111316" target="_top">Vol.2</a>
			<% End If %>
			</li>

			<% if currentdate < "2021-06-03" then %>
			<li class="swiper-slide coming"><span>Vol.3</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="111704"," current","")%>">
				<a href="/event/eventmain.asp?eventid=111704" target="_top">Vol.3</a>
			<% End If %>
			</li>

				<% if currentdate < "2021-07-15" then %>
			<li class="swiper-slide coming"><span>comming<br/>soon</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="112715"," current","")%>">
				<a href="/event/eventmain.asp?eventid=112715" target="_top">Vol.4</a>
			<% End If %>
			</li>
		</ul>
		<button class="btn-prev">이전</button>
		<button class="btn-next">다음</button>
	</div>
</div>
</body>
</html>