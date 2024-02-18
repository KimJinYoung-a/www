<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/inc/head.asp" -->
<%
dim currentdate
	currentdate = date()
	'currentdate = "2018-08-14"
	'response.write currentdate

	Dim vEventID, vStartNo
	vEventID = requestCheckVar(Request("eventid"),9)
	If vEventID = "79155" Then '// vol1
		vStartNo = "0"
	ElseIf vEventID = "82317" Then '// vol2
		vStartNo = "0"
	ElseIf vEventID = "0000" Then '// vol3
		vStartNo = "0"
	ElseIf vEventID = "00000" Then '// vol4
		vStartNo = "1"
	ElseIf vEventID = "00000" Then '// vol5
		vStartNo = "2"
	ElseIf vEventID = "00000" Then '// vol6
		vStartNo = "3"
	ElseIf vEventID = "00000" Then '// vol7
		vStartNo = "3"
	ElseIf vEventID = "00000" Then '// vol8
		vStartNo = "3"
	ElseIf vEventID = "00000" Then '// vol9
		vStartNo = "3"
	ElseIf vEventID = "00000" Then '// vol10
		vStartNo = "3"
	ElseIf vEventID = "00000" Then '// vol11
		vStartNo = "3"
	ElseIf vEventID = "00000" Then '// vol12
		vStartNo = "3"
	ElseIf vEventID = "00000" Then '// vol13
		vStartNo = "3"
	ElseIf vEventID = "00000" Then '// vol14
		vStartNo = "3"
	else
		vStartNo = "0"
	End IF
%>
<style type="text/css">
.navigation {width:367px; position:relative; height:35px!important; padding:0 28px;}
.navigation .swiper-container {width:100%; height:35px;}
.navigation li {position:relative; float:left; width:auto !important; color:#c3c2c2; font:600 17px 'AvenirNext-Regular', 'AppleSDGothicNeo-Regular', 'RobotoRegular', 'Noto Sans', sans-serif; text-align:center; cursor:context-menu;}
.navigation li:after {content:' '; display:inline-block; position:absolute; top:50%; right:0; width:1px; height:9px; margin-top:-4px; background-color:#d0d0d0;}
.navigation li a {position:relative; display:none; margin:0 21px; line-height:35px;}
.navigation li.open a {display:inline-block; text-decoration:none; color:#000;}
.navigation li.current a {padding:0 18px; background-color:#000; font-size:18px; color:#fff; letter-spacing:2px;}
.navigation li span {display:inline-block; height:100%; padding:0 18px; line-height:35px; letter-spacing:1px; color:#c3c2c2;}
.navigation button {display:inline-block; position:absolute; top:0; width:9px; height:35px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/82317/btn_nav.png) 0 50% no-repeat; text-indent:-999em; outline:none;}
.navigation .btnPrev {left:0;}
.navigation .btnNext {right:0; background-position:100% 50%;}
</style>
<script type="text/javascript">
$(function(){
	var evtSwiper = new Swiper('.navigation .swiper-container',{
		initialSlide:<%=vStartNo%>,
		slidesPerView:4,
		slidesPerGroup : 4,
		speed:200
	})
	$('.navigation .btnPrev').on('click', function(e){
		e.preventDefault();
		evtSwiper.swipePrev();
	})
	$('.navigation .btnNext').on('click', function(e){
		e.preventDefault();
		evtSwiper.swipeNext();
	});
	$(".navigation .swiper-slide.coming").click(function(){
		alert("Coming soon");
	});
});
</script>
</head>
<body>
<div class="navigation">
	<div class="swiper-container">
		<ul class="swiper-wrapper">
			<li class="swiper-slide open <%=CHKIIF(vEventID="79155"," current","")%>"><a href="/event/eventmain.asp?eventid=79155" target="_top">vol.1</a></li>

			<%'  오픈된 이벤트 open, 오늘 날짜에 current 클래스 넣어주세요 %>

			<% if currentdate < "2017-12-22" then %>
			<li class="swiper-slide coming">
				<span>vol.2</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="82317"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=82317" target="_top">vol.2</a>
			</li>

			<% if currentdate < "2018-01-30" then %>
			<li class="swiper-slide coming">
				<span>vol.3</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="81322"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=81322" target="_top">vol.3</a>
			</li>

			<% if currentdate < "2018-02-30" then %>
			<li class="swiper-slide coming">
				<span>vol.4</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="00000"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=00000" target="_top">vol.4</a>
			</li>

			<% if currentdate < "2018-03-30" then %>
			<li class="swiper-slide coming">
				<span>vol.5</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="00000"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=00000" target="_top">vol.5</a>
			</li>

			<% if currentdate < "2018-04-30" then %>
			<li class="swiper-slide coming">
				<span>vol.6</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="00000"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=00000" target="_top">vol.6
			</li>

			<% if currentdate < "2018-05-30" then %>
			<li class="swiper-slide coming">
				<span>vol.7</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="00000"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=00000" target="_top">vol.7</a>
			</li>

			<% if currentdate < "2018-06-30" then %>
			<li class="swiper-slide coming">
				<span>vol.8</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="00000"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=00000" target="_top">vol.8</a>
			</li>

			<% if currentdate < "2018-07-30" then %>
			<li class="swiper-slide coming">
				<span>vol.9</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="00000"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=00000" target="_top">vol.9</a>
			</li>

			<% if currentdate < "2018-08-30" then %>
			<li class="swiper-slide coming">
				<span>vol.10</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="00000"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=00000" target="_top">vol.10</a>
			</li>

		</ul>
	</div>
	<button class="btnPrev">이전</button>
	<button class="btnNext">다음</button>
</div>
</body>
</html>