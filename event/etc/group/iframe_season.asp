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
	If vEventID = "114969" Then '// 1월
		vStartNo = "0"
	ElseIf vEventID = "115372" Then '// 2월
		vStartNo = "1"
	ElseIf vEventID = "115996" Then '// 3월
		vStartNo = "2"
	ElseIf vEventID = "116531" Then '// 4월
		vStartNo = "3"
	ElseIf vEventID = "117003" Then '// 5월
		vStartNo = "4"
	ElseIf vEventID = "117537" Then '// 6월
		vStartNo = "5"
	ElseIf vEventID = "119100" Then '// 7월
		vStartNo = "6"
	ElseIf vEventID = "" Then '// 8월
		vStartNo = "7"
	else
		vStartNo = "8"
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
	<h2><img src="//webimage.10x10.co.kr/fixevent/event/2021/114969/tit_season.png" alt="magazine 계절잡지"></h2>
	<div class="swiper-container">
		<ul class="swiper-wrapper">
			<%' 오픈된 이벤트 open, 오늘 날짜에 current 클래스 넣어주세요 %>
			<% if currentdate < "2021-11-15" then %>
			<li class="swiper-slide coming"><span>Vol.1</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="114969"," current","")%>">
				<a href="/event/eventmain.asp?eventid=114969" target="_top">Vol.1</a>
			<% End If %>
			</li>

			<% if currentdate < "2021-12-13" then %>
			<li class="swiper-slide coming"><span>Vol.2</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="115372"," current","")%>">
				<a href="/event/eventmain.asp?eventid=115372" target="_top">Vol.2</a>
			<% End If %>
			</li>

			<% if currentdate < "2022-01-04" then %>
			<li class="swiper-slide coming"><span>Vol.3</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="115996"," current","")%>">
				<a href="/event/eventmain.asp?eventid=115996" target="_top">Vol.3</a>
			<% End If %>
			</li>

			<% if currentdate < "2022-02-15" then %>
			<li class="swiper-slide coming"><span>Vol.4</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="116531"," current","")%>">
				<a href="/event/eventmain.asp?eventid=116531" target="_top">Vol.4</a>
			<% End If %>
			</li>

			<% if currentdate < "2022-03-15" then %>
			<li class="swiper-slide coming"><span>Vol.5</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="117003"," current","")%>">
				<a href="/event/eventmain.asp?eventid=117003" target="_top">Vol.5</a>
			<% End If %>
			</li>

			<% if currentdate < "2022-04-12" then %>
			<li class="swiper-slide coming"><span>특별호</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="117537"," current","")%>">
				<a href="/event/eventmain.asp?eventid=117537" target="_top">특별호</a>
			<% End If %>
			</li>

			<% if currentdate < "2022-07-06" then %>
			<li class="swiper-slide coming"><span>Vol.7</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="119100"," current","")%>">
				<a href="/event/eventmain.asp?eventid=119100" target="_top">Vol.7</a>
			<% End If %>
			</li>

			<% if currentdate < "2022-09-05" then %>
			<li class="swiper-slide coming"><span>Coming<br/>Soon</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="000000"," current","")%>">
				<a href="/event/eventmain.asp?eventid=000000" target="_top">Coming<br>soon</a>
			<% End If %>
			</li>

		</ul>
		<button class="btn-prev">이전</button>
		<button class="btn-next">다음</button>
	</div>
</div>
</body>
</html>