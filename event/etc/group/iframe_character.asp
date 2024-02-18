<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/inc/head.asp" -->
<%
dim currentdate
	currentdate = date()
	'currentdate = "2018-05-14"
	'response.write currentdate

	Dim vEventID, vStartNo
	vEventID = requestCheckVar(Request("eventid"),9)
	If vEventID = "86367" Then
		vStartNo = "0"
	ElseIf vEventID = "86645" Then
		vStartNo = "0"
	ElseIf vEventID = "86766" Then
		vStartNo = "0"
	ElseIf vEventID = "86951" Then
		vStartNo = "0"
	ElseIf vEventID = "87124" Then
		vStartNo = "0"
	ElseIf vEventID = "87274" Then
		vStartNo = "1"
	else
		vStartNo = "0"
	End IF
%>
<style type="text/css">
.lineup {position:relative; height:154px;}
.lineup .swiper-container {width:755px; height:154px; margin:0 auto;}
.lineup li {position:relative; float:left; width:121px !important; height:121px; margin:34px 15px 0; background-position:0 0; background-repeat:no-repeat;}
.lineup li.week1 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2018/86367/tab_0514_v2.png?v=1);}
.lineup li.week2 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2018/86367/tab_0521.png?v=1.1);}
.lineup li.week3 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2018/86367/tab_0528.png?v=1.2);}
.lineup li.week4 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2018/86367/tab_0604.png?v=1.1);}
.lineup li.week5 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2018/86367/tab_0611.png?v=1.1);}
.lineup li.week6 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2018/86367/tab_0618.png?v=1.1);}
.lineup li a {display:none; width:121px; height:154px; text-indent:-999em;}
.lineup li.open {height:154px; margin-top:0; background-position:-130px 100%;}
.lineup li.current {height:154px; margin-top:0; background-position:100% 0;}
.lineup li.open a,
.lineup li.current a {display:block;}
.lineup button {position:absolute; bottom:0; background:transparent; outline:none;}
.lineup button.btn-prev {left:0;}
.lineup button.btn-next {right:0;}
</style>
<script type="text/javascript">
$(function(){
	var dateSwiper = new Swiper('.lineup .swiper-container',{
		initialSlide:<%=vStartNo%>,
		slidesPerView:5,
		speed:300
	})
	$('.lineup .btn-prev').on('click', function(e){
		e.preventDefault();
		dateSwiper.swipePrev();
	})
	$('.lineup .btn-next').on('click', function(e){
		e.preventDefault();
		dateSwiper.swipeNext();
	});
});
</script>
</head>
<body>
<div class="lineup">
	<div class="swiper-container">
		<ul class="swiper-wrapper">
			<%'  오픈된 이벤트 open, 오늘 날짜에 current 클래스 넣어주세요 %>
			<% if currentdate < "2018-05-14" then %>
			<li class="swiper-slide week1">
			<% Else %>
			<li class="swiper-slide week1 open <%=CHKIIF(vEventID="86367"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=86367" target="_top">05.14</a>
			</li>

			<% if currentdate < "2018-05-21" then %>
			<li class="swiper-slide week2">
			<% Else %>
			<li class="swiper-slide week2 open <%=CHKIIF(vEventID="86645"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=86645" target="_top">05.21</a>
			</li>

			<% if currentdate < "2018-05-28" then %>
			<li class="swiper-slide week3">
			<% Else %>
			<li class="swiper-slide week3 open <%=CHKIIF(vEventID="86766"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=86766" target="_top">05.28</a>
			</li>

			<% if currentdate < "2018-06-04" then %>
			<li class="swiper-slide week4">
			<% Else %>
			<li class="swiper-slide week4 open <%=CHKIIF(vEventID="86951"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=86951" target="_top">06.04</a>
			</li>

			<% if currentdate < "2018-06-11" then %>
			<li class="swiper-slide week5">
			<% Else %>
			<li class="swiper-slide week5 open <%=CHKIIF(vEventID="87124"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=87124" target="_top">06.11</a>
			</li>

			<% if currentdate < "2018-06-18" then %>
			<li class="swiper-slide week6">
			<% Else %>
			<li class="swiper-slide week6 open <%=CHKIIF(vEventID="87274"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=87274" target="_top">06.18</a>
			</li>

		</ul>
	</div>
	<button class="btn-prev"><img src="http://webimage.10x10.co.kr/eventIMG/2018/86367/btn_prev.png?v=1" alt="이전" /></button>
	<button class="btn-next"><img src="http://webimage.10x10.co.kr/eventIMG/2018/86367/btn_next.png?v=1" alt="다음" /></button>
</div>
</body>
</html>