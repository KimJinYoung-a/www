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
	If vEventID = "100700" Then '// Vol.1
		vStartNo = "0"
	ElseIf vEventID = "101555" Then '// Vol.2
		vStartNo = "0"
	ElseIf vEventID = "102167" Then '// Vol.3
		vStartNo = "1"
	ElseIf vEventID = "102819" Then '// Vol.4
		vStartNo = "2"
	ElseIf vEventID = "103595" Then '// Vol.5
		vStartNo = "3"
	ElseIf vEventID = "104545" Then '// Vol.6
		vStartNo = "4"
	ElseIf vEventID = "105287" Then '// Vol.7
		vStartNo = "5"
	ElseIf vEventID = "106064" Then '// Vol.8
		vStartNo = "6"
	ElseIf vEventID = "106907" Then '// Vol.9
		vStartNo = "7"
	ElseIf vEventID = "107793" Then '// Vol.10
		vStartNo = "8"
	ElseIf vEventID = "" Then '// Vol.11
		vStartNo = "9"
	else
		vStartNo = "0"
	End IF
%>
<style type="text/css">
.navigator {position:relative; overflow:hidden; width:1040px; margin:0 auto;}
.navigator h2 {float:left; padding-top:10px;}
.navigator .swiper-container {float:right; width:310px; padding:0 24px;}
.navigator .swiper-wrapper {display:flex;}
.navigator .swiper-slide {width:25%; height:60px;font-size:18px;}
.navigator .swiper-slide span,
.navigator .swiper-slide a {display:flex; justify-content:center; align-items:center; width:100%; height:100%; color:#909090; text-decoration:none;}
.navigator .swiper-slide.current a {position:relative; color:#484848; font-weight:500;}
.navigator .swiper-slide.current a:after {content:''; display:inline-block; position:absolute; left:50%; top:6px; width:6px; height:6px; margin-left:-3px; background:#484848; border-radius:50%;}
.navigator button {position:absolute; top:0; z-index:100; width:24px; height:100%; background:#fff url(//webimage.10x10.co.kr/eventIMG/2020/101555/btn_nav.png) 50% 50% no-repeat; font-size:0;}
.navigator .btn-prev {left:0;}
.navigator .btn-next {right:0; transform:rotate(180deg);}
</style>
<script type="text/javascript">
$(function(){
	var evtSwiper = new Swiper('.navigator .swiper-container',{
		initialSlide:<%=vStartNo%>,
		slidesPerView:4,
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
	<h2><img src="//webimage.10x10.co.kr/eventIMG/2020/101555/tit_deccu.png" alt="이달의 데꾸데리어"></h2>
	<div class="swiper-container">
		<ul class="swiper-wrapper">
			<%' 오픈된 이벤트 open, 오늘 날짜에 current 클래스 넣어주세요 %>
			<% if currentdate < "2020-02-19" then %>
			<li class="swiper-slide coming"><span>Vol.1</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="100700"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=100700" target="_top">Vol.1</a>
			</li>

			<% if currentdate < "2020-03-26" then %>
			<li class="swiper-slide coming"><span>Vol.2</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="101555"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=101555" target="_top">Vol.2</a>
			</li>

			<% if currentdate < "2020-04-29" then %>
			<li class="swiper-slide coming"><span>Vol.3</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="102167"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=102167" target="_top">Vol.3</a>
			</li>

			<% if currentdate < "2020-05-26" then %>
			<li class="swiper-slide coming"><span>Vol.4</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="102819"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=102819" target="_top">Vol.4</a>
			</li>

			<% if currentdate < "2020-07-01" then %>
			<li class="swiper-slide coming"><span>Vol.5</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="103595"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=103595" target="_top">Vol.5</a>
			</li>

			<% if currentdate < "2020-08-03" then %>
			<li class="swiper-slide coming"><span>Vol.6</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="104545"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=104545" target="_top">Vol.6</a>
			</li>

			<% if currentdate < "2020-09-02" then %>
			<li class="swiper-slide coming"><span>Vol.7</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="105287"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=105287" target="_top">Vol.7</a>
			</li>

			<% if currentdate < "2020-10-05" then %>
			<li class="swiper-slide coming"><span>Vol.8</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="106064"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=106064" target="_top">Vol.8</a>
			</li>

			<% if currentdate < "2020-11-03" then %>
			<li class="swiper-slide coming"><span>Vol.9</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="106907"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=106907" target="_top">Vol.9</a>
			</li>

			<% if currentdate < "2020-12-01" then %>
			<li class="swiper-slide coming"><span>Vol.10</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="107793"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=107793" target="_top">Vol.10</a>
			</li>
		</ul>
		<button class="btn-prev">이전</button>
		<button class="btn-next">다음</button>
	</div>
</div>
</body>
</html>