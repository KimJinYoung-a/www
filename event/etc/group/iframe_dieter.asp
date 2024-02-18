<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/inc/head.asp" -->
<%
dim currentdate
	currentdate = date()
	'currentdate = "2017-07-17"
	'response.write currentdate

	Dim vEventID, vStartNo
	vEventID = requestCheckVar(Request("eventid"),9)
	If vEventID = "78222" Then '// 6월
		vStartNo = "0"
	ElseIf vEventID = "78929" Then '// 7월
		vStartNo = "0"
	ElseIf vEventID = "79726" Then '// 8월
		vStartNo = "0"
	ElseIf vEventID = "80231" Then '// 9월
		vStartNo = "1"
	ElseIf vEventID = "81322" Then '// 10월
		vStartNo = "2"
	ElseIf vEventID = "82106" Then '// 11월
		vStartNo = "3"
	ElseIf vEventID = "83054" Then '// 12월
		vStartNo = "3"
	else
		vStartNo = "0"
	End IF
%>
<style type="text/css">
.navigation {overflow:hidden; width:1140px; height:73px;}
.navigation p {float:left; padding:21px 0 0 65px;}
.navigation .monthTab {position:relative; float:right; width:340px; margin-top:11px; padding:0 40px;}
.navigation .swiper-container {width:100%; height:38px;}
.navigation li {position:relative; float:left; width:38px !important; height:38px; margin:0 15px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/78929/txt_month.png) 0 0 no-repeat;}
.navigation li:after {content:''; display:inline-block; position:absolute; left:-15px; top:15px; width:1px; height:9px; background-color:#d0d0d0;}
.navigation li:first-child:after {display:none;}
.navigation li a {display:none; position:absolute; left:0; top:0; width:38px; height:38px; text-indent:-999em;}
.navigation li.current {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/78929/txt_month_on.png?v=1);}
.navigation li.open a {display:block;}
.navigation li.month2 {background-position:-38px 0;}
.navigation li.month3 {background-position:-76px 0;}
.navigation li.month4 {background-position:-114px 0;}
.navigation li.month5 {background-position:-152px 0;}
.navigation li.month6 {background-position:-190px 0;}
.navigation li.month7 {background-position:100% 0;}
.navigation button {display:block; position:absolute; top:0; width:38px; height:38px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/78929/btn_nav.png) 0 0 no-repeat; text-indent:-999em;}
.navigation .btnPrev {left:3px;;}
.navigation .btnNext {right:3px; background-position:100% 0;}
</style>
<script type="text/javascript">
$(function(){
	var evtSwiper = new Swiper('.monthTab .swiper-container',{
		initialSlide:<%=vStartNo%>,
		slidesPerView:5,
		speed:300
	})
	$('.monthTab .btnPrev').on('click', function(e){
		e.preventDefault();
		evtSwiper.swipePrev();
	})
	$('.monthTab .btnNext').on('click', function(e){
		e.preventDefault();
		evtSwiper.swipeNext();
	});
});
</script>
</head>
<body>
<div class="navigation">
	<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/78929/txt_monthly_diet.png" alt="MONTHLY DIET" /></p>
	<div class="monthTab">
		<div class="swiper-container">
			<ul class="swiper-wrapper">
				<li class="swiper-slide month1 open <%=CHKIIF(vEventID="78222"," current","")%>"><a href="/event/eventmain.asp?eventid=78222" target="_top">6월</a></li>

				<%'  오픈된 이벤트 open, 오늘 날짜에 current 클래스 넣어주세요 %>
				<% if currentdate < "2017-07-17" then %>
				<li class="swiper-slide month2">
				<% Else %>
				<li class="swiper-slide month2 open <%=CHKIIF(vEventID="78929"," current","")%>">
				<% End If %>
					<a href="/event/eventmain.asp?eventid=78929" target="_top">7월</a>
				</li>

				<% if currentdate < "2017-08-14" then %>
				<li class="swiper-slide month3">
				<% Else %>
				<li class="swiper-slide month3 open <%=CHKIIF(vEventID="79726"," current","")%>">
				<% End If %>
					<a href="/event/eventmain.asp?eventid=79726" target="_top">8월</a>
				</li>

				<% if currentdate < "2017-09-05" then %>
				<li class="swiper-slide month4">
				<% Else %>
				<li class="swiper-slide month4 open <%=CHKIIF(vEventID="80231"," current","")%>">
				<% End If %>
					<a href="/event/eventmain.asp?eventid=80231" target="_top">9월</a>
				</li>

				<% if currentdate < "2017-10-24" then %>
				<li class="swiper-slide month5">
				<% Else %>
				<li class="swiper-slide month5 open <%=CHKIIF(vEventID="81322"," current","")%>">
				<% End If %>
					<a href="/event/eventmain.asp?eventid=81322" target="_top">10월</a>
				</li>

				<% if currentdate < "2017-11-20" then %>
				<li class="swiper-slide month6">
				<% Else %>
				<li class="swiper-slide month6 open <%=CHKIIF(vEventID="82106"," current","")%>">
				<% End If %>
					<a href="/event/eventmain.asp?eventid=82106" target="_top">11월</a>
				</li>

				<% if currentdate < "2017-12-18" then %>
				<li class="swiper-slide month7">
				<% Else %>
				<li class="swiper-slide month7 open <%=CHKIIF(vEventID="83054"," current","")%>">
				<% End If %>
					<a href="/event/eventmain.asp?eventid=83054" target="_top">12월</a>
				</li>
			</ul>
		</div>
		<button class="btnPrev">이전</button>
		<button class="btnNext">다음</button>
	</div>
</div>
</body>
</html>