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
	If vEventID = "109400" Then '// 3월
		vStartNo = "0"
	ElseIf vEventID = "110610" Then '// 4월
		vStartNo = "0"
	ElseIf vEventID = "110745" Then '// 5월
		vStartNo = "0"
	ElseIf vEventID = "111478" Then '// 6월
		vStartNo = "1"
	ElseIf vEventID = "112366" Then '// 7월
		vStartNo = "2"
	ElseIf vEventID = "113196" Then '// 8월
		vStartNo = "3"
	ElseIf vEventID = "" Then '// 9월
		vStartNo = "4"
	ElseIf vEventID = "" Then '// 10월
		vStartNo = "5"
	else
		vStartNo = "6"
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
	<h2><img src="//webimage.10x10.co.kr/fixevent/event/2021/110610/tit_newitem.png" alt="이달의 신상"></h2>
	<div class="swiper-container">
		<ul class="swiper-wrapper">
			<%' 오픈된 이벤트 open, 오늘 날짜에 current 클래스 넣어주세요 %>
			<% if currentdate < "2021-03-17" then %>
			<li class="swiper-slide coming"><span>March</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="109400"," current","")%>">
				<a href="/event/eventmain.asp?eventid=109400" target="_top">March</a>
			<% End If %>
			</li>

			<% if currentdate < "2021-04-15" then %>
			<li class="swiper-slide coming"><span>April</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="110610"," current","")%>">
				<a href="/event/eventmain.asp?eventid=110610" target="_top">April</a>
			<% End If %>
			</li>

			<% if currentdate < "2021-05-12" then %>
			<li class="swiper-slide coming"><span>May</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="110745"," current","")%>">
				<a href="/event/eventmain.asp?eventid=110745" target="_top">May</a>
			<% End If %>
			</li>

            <% if currentdate < "2021-06-16" then %>
			<li class="swiper-slide coming"><span>June</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="111478"," current","")%>">
				<a href="/event/eventmain.asp?eventid=111478" target="_top">June</a>
			<% End If %>
			</li>

			<% if currentdate < "2021-07-14" then %>
			<li class="swiper-slide coming"><span>July</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="112366"," current","")%>">
				<a href="/event/eventmain.asp?eventid=112366" target="_top">July</a>
			<% End If %>
			</li>

			<% if currentdate < "2021-08-16" then %>
			<li class="swiper-slide coming"><span>August</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="113196"," current","")%>">
				<a href="/event/eventmain.asp?eventid=113196" target="_top">August</a>
			<% End If %>
			</li>

			<% if currentdate < "2021-09-30" then %>
			<li class="swiper-slide coming"><span>Coming<br/>Soon</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="000000"," current","")%>">
				<a href="/event/eventmain.asp?eventid=000000" target="_top">September</a>
			<% End If %>
			</li>
		</ul>
		<button class="btn-prev">이전</button>
		<button class="btn-next">다음</button>
	</div>
</div>
</body>
</html>