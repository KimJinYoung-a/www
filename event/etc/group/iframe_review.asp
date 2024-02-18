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
	If vEventID = "102724" Then '// 5월
		vStartNo = "0"
	ElseIf vEventID = "103824" Then '// 6월
		vStartNo = "0"
	ElseIf vEventID = "104729" Then '// 7월
		vStartNo = "0"
	ElseIf vEventID = "106273" Then '// 8월
		vStartNo = "0"
	ElseIf vEventID = "" Then '// 9월
		vStartNo = "0"
	ElseIf vEventID = "106986" Then '// 10월
		vStartNo = "0"
	ElseIf vEventID = "" Then '// 11월
		vStartNo = "0"
	ElseIf vEventID = "" Then '// 12월
		vStartNo = "0"
	ElseIf vEventID = "" Then '// 1월
		vStartNo = "1"
	else
		vStartNo = "0"
	End IF
%>
<style type="text/css">
.navigator {position:relative; overflow:hidden; width:1040px; margin:0 auto;}
.navigator .swiper-container {width:366px; height:45px; padding:0 58px; margin:0 auto;}
.navigator .swiper-wrapper {display:flex; width:100% !important;}
.navigator .swiper-slide {width:45px; height:45px; margin:0 8px; font-size:15px;}
.navigator .swiper-slide span,
.navigator .swiper-slide a {display:flex; justify-content:center; align-items:center; width:41px; height:41px; color:#999; text-decoration:none;}
.navigator .swiper-slide.current a {position:relative; color:#000; font-weight:800;  border:solid 2px #000; border-radius:50%;}
.navigator button {position:absolute; top:0; z-index:100; width:12px; height:100%; background:#fff url(http://webimage.10x10.co.kr/eventIMG/2020/102724/img_btn.png) 50% 50% no-repeat; font-size:0;}
.navigator .btn-prev {left:0;}
.navigator .btn-next {right:0; transform:rotate(180deg);}
</style>
<script type="text/javascript">
$(function(){
	var evtSwiper = new Swiper('.navigator .swiper-container',{
		initialSlide:<%=vStartNo%>,
		slidesPerView:'auto',
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
	<div class="swiper-container">
		<ul class="swiper-wrapper">

			<% if currentdate < "2020-06-25" then %>
			<li class="swiper-slide coming"><span>7월</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="103824"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=103824" target="_top">7월</a>
			</li>

			<% if currentdate < "2020-07-29" then %>
			<li class="swiper-slide coming"><span>8월</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="104729"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=104729" target="_top">8월</a>
			</li>

			<% if currentdate < "2020-09-24" then %>
			<li class="swiper-slide coming"><span>9월</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="106273"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=106273" target="_top">9월</a>
			</li>

			<% if currentdate < "2020-10-27" then %>
			<li class="swiper-slide coming"><span>10월</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="106986"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=106986" target="_top">10월</a>
			</li>

			<% if currentdate < "2022-01-01" then %>
			<li class="swiper-slide coming"><span>11월</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="000"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=000" target="_top">11월</a>
			</li>

			<% if currentdate < "2022-01-01" then %>
			<li class="swiper-slide coming"><span>12월</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="000"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=000" target="_top">12월</a>
			</li>

		</ul>
		<button class="btn-prev">이전</button>
		<button class="btn-next">다음</button>
	</div>
</div>
</body>
</html>