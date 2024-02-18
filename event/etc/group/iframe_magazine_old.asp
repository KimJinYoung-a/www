<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/inc/head.asp" -->
<%
dim currentdate
	currentdate = date()
	'currentdate = "2017-08-14"
	'response.write currentdate

	Dim vEventID, vStartNo
	vEventID = requestCheckVar(Request("eventid"),9)
	If vEventID = "81442" Then '// 10월
		vStartNo = "0"
	ElseIf vEventID = "82284" Then '// 11월
		vStartNo = "0"
	ElseIf vEventID = "82895" Then '// 12월
		vStartNo = "0"
	ElseIf vEventID = "00000" Then '// 1월
		vStartNo = "1"
	ElseIf vEventID = "00000" Then '// 2월
		vStartNo = "2"
	ElseIf vEventID = "00000" Then '// 3월
		vStartNo = "3"
	else
		vStartNo = "0"
	End IF
%>
<style type="text/css">
.navigation {position:relative; width:305px; height:25px; padding:0 29px;}
.navigation .swiper-container {width:100%; height:38px;}
.navigation li {position:relative; float:left; width:51px !important; height:25px; margin:0 5px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/81442/txt_month.png) 0 0 no-repeat;}
.navigation li a {display:none; position:absolute; left:0; top:0; width:51px; height:25px; text-indent:-999em;}
.navigation li.current {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/81442/txt_month_on.png);}
.navigation li.open a {display:block;}
.navigation li.month2 {background-position:-51px 0;}
.navigation li.month3 {background-position:-102px 0;}
.navigation li.month4 {background-position:-153px 0;}
.navigation li.month5 {background-position:-204px 0;}
.navigation li.month6 {background-position:-255px 0;}
.navigation button {display:block; position:absolute; top:0; width:9px; height:25px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/81442/btn_nav_month.png) 0 0 no-repeat; text-indent:-999em; outline:none;}
.navigation .btnPrev {left:0;}
.navigation .btnNext {right:0; background-position:100% 0;}
</style>
<script type="text/javascript">
$(function(){
	var evtSwiper = new Swiper('.navigation .swiper-container',{
		initialSlide:<%=vStartNo%>,
		slidesPerView:5,
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
});
</script>
</head>
<body>
<div class="navigation">
	<div class="swiper-container">
		<ul class="swiper-wrapper">
			<li class="swiper-slide month1 open <%=CHKIIF(vEventID="81442"," current","")%>"><a href="/event/eventmain.asp?eventid=81442" target="_top">10월</a></li>

			<%'  오픈된 이벤트 open, 오늘 날짜에 current 클래스 넣어주세요 %>
			<% if currentdate < "2017-11-22" then %>
			<li class="swiper-slide month2">
			<% Else %>
			<li class="swiper-slide month2 open <%=CHKIIF(vEventID="82284"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=82284" target="_top">11월</a>
			</li>

			<% if currentdate < "2017-12-14" then %>
			<li class="swiper-slide month3">
			<% Else %>
			<li class="swiper-slide month3 open <%=CHKIIF(vEventID="82895"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=82895" target="_top">12월</a>
			</li>

			<% if currentdate < "2018-01-00" then %>
			<li class="swiper-slide month4">
			<% Else %>
			<li class="swiper-slide month4 open <%=CHKIIF(vEventID="80231"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=80231" target="_top">1월</a>
			</li>

			<% if currentdate < "2018-02-00" then %>
			<li class="swiper-slide month5">
			<% Else %>
			<li class="swiper-slide month5 open <%=CHKIIF(vEventID="81322"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=81322" target="_top">2월</a>
			</li>

			<% if currentdate < "2018-03-00" then %>
			<li class="swiper-slide month6">
			<% Else %>
			<li class="swiper-slide month6 open <%=CHKIIF(vEventID="00000"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=00000" target="_top">3월</a>
			</li>

		</ul>
	</div>
	<button class="btnPrev">이전</button>
	<button class="btnNext">다음</button>
</div>
</body>
</html>