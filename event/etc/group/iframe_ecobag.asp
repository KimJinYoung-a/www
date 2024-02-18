<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/inc/head.asp" -->
<%
dim currentdate
	currentdate = date()
	'currentdate = "2015-03-09"
	'response.write currentdate

	Dim vEventID, vStartNo
	vEventID = requestCheckVar(Request("eventid"),9)
	If vEventID = "77954" Then '// 5월
		vStartNo = "0"
	ElseIf vEventID = "78366" Then '// 6월
		vStartNo = "0"
	ElseIf vEventID = "79244" Then '// 7월
		vStartNo = "0"
	ElseIf vEventID = "77954" Then '// 8월
		vStartNo = "1"
	ElseIf vEventID = "80552" Then '// 9월
		vStartNo = "2"
	ElseIf vEventID = "81098" Then '// 10월
		vStartNo = "2"
	ElseIf vEventID = "81543" Then '// 11월
		vStartNo = "3"
	ElseIf vEventID = "82985" Then '// 12월
		vStartNo = "5"
	ElseIf vEventID = "86441" Then '// 2018년 5월
		vStartNo = "5"
	ElseIf vEventID = "87368" Then '// 2018년 6월
		vStartNo = "7"
	ElseIf vEventID = "88116" Then '// 2018년 7월
		vStartNo = "8"
	ElseIf vEventID = "88904" Then '// 2018년 9월
		vStartNo = "10"
	ElseIf vEventID = "90218" Then '// 2018년 11월
		vStartNo = "10"
	else
		vStartNo = "0"
	End IF
%>
<style type="text/css">
.monthTab {position:relative; height:74px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/77954/bg_tab.png) 0 0 repeat-x;}
.monthTab .swiper-container {width:1090px; height:73px; margin:0 auto; padding-top:2px;}
.monthTab ul {overflow:hidden;}
.monthTab li {position:relative; float:left; width:20%; height:72px; background-position:0 0; background-repeat:no-repeat;}
.monthTab li:after {content:''; position:absolute; left:0; bottom:5px; width:100%; height:1px; background:#c0c0c0;}
.monthTab li a {display:none;}
.monthTab li.open a {display:block; height:67px; text-indent:-999em;}
.monthTab li.current {background-position:0 106%;}
.monthTab li.current a {display:block; height:67px; text-indent:-999em;}
.monthTab li.current:after {bottom:1px; z-index:20; width:218px; height:6px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/77954/blt_arrow.png) 0 0 no-repeat;}
.monthTab li.month1 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/77954/tab_may.png);}
.monthTab li.month2 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/77954/tab_june.png);}
.monthTab li.month3 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/77954/tab_july_v2.png);}
.monthTab li.month4 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/77954/tab_august_v3.png);}
.monthTab li.month5 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/80552/tab_september.png);}
.monthTab li.month6 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/81098/tab_october.png);}
.monthTab li.month7 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/81543/tab_nov.png);}
.monthTab li.month8 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/82985/tab_dec.png);}
.monthTab li.month9 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2018/86441/tab_may_v2.png?v=1.1);}
.monthTab li.month10 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2018/87368/tab_june.png);}
.monthTab li.month11 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2018/88116/tab_july.png);}
.monthTab li.month12 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2018/86441/tab_august.png);}
.monthTab li.month13 {background-image:url(http://webimage.10x10.co.kr/fixevent/event/2018/88904/tab_september.gif);}
.monthTab li.month14 {background-image:url(http://webimage.10x10.co.kr/fixevent/event/2018/88904/tab_october.gif);}
.monthTab li.month15 {background-image:url(http://webimage.10x10.co.kr/fixevent/event/2018/90218/tab_november.gif);}
.monthTab button {overflow:hidden; position:absolute; top:2px; z-index:10; height:65px; padding-right:1px; outline:none; background-color:#fff;}
.monthTab button img {vertical-align:top;}
.monthTab .btnPrev {left:0;}
.monthTab .btnNext {right:0;}
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
	$('.monthTab .next-eco').on('click', function(e){
		alert("오픈 예정 기획전 입니다.");
	});
});
</script>
</head>
<body>
<div class="monthTab">
	<div class="swiper-container">
		<ul class="swiper-wrapper">
			<%'  오픈된 이벤트 open, 오늘 날짜에 current 클래스 넣어주세요 %>
			<% if currentdate < "2017-05-17" then %>
			<li class="swiper-slide month1">
			<% Else %>
			<li class="swiper-slide month1 open <%=CHKIIF(vEventID="77954"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=77954" target="_top">5월호</a>
			</li>

			<% if currentdate < "2017-06-14" then %>
			<li class="swiper-slide month2">
			<% Else %>
			<li class="swiper-slide month2 open <%=CHKIIF(vEventID="78366"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=78366" target="_top">6월호</a>
			</li>

			<% if currentdate < "2017-07-19" then %>
			<li class="swiper-slide month3">
			<% Else %>
			<li class="swiper-slide month3 open <%=CHKIIF(vEventID="79244"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=79244" target="_top">7월호</a>
			</li>

			<% if currentdate < "2017-08-16" then %>
			<li class="swiper-slide month4">
			<% Else %>
			<li class="swiper-slide month4 open <%=CHKIIF(vEventID="79952"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=79952" target="_top">8월호</a>
			</li>

			<% if currentdate < "2017-09-13" then %>
			<li class="swiper-slide month5">
			<% Else %>
			<li class="swiper-slide month5 open <%=CHKIIF(vEventID="80552"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=80552" target="_top">9월호</a>
			</li>

			<% if currentdate < "2017-10-11" then %>
			<li class="swiper-slide month6">
			<% Else %>
			<li class="swiper-slide month6 open <%=CHKIIF(vEventID="81098"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=81098" target="_top">10월호</a>
			</li>

			<% if currentdate < "2017-10-31" then %>
			<li class="swiper-slide month7">
			<% Else %>
			<li class="swiper-slide month7 open <%=CHKIIF(vEventID="81543"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=81543" target="_top">11월호</a>
			</li>

			<% if currentdate < "2017-12-14" then %>
			<li class="swiper-slide month8">
			<% Else %>
			<li class="swiper-slide month8 open <%=CHKIIF(vEventID="82985"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=82985" target="_top">12월호</a>
			</li>

			<% if currentdate < "2018-05-14" then %>
			<li class="swiper-slide month9">
			<% Else %>
			<li class="swiper-slide month9 open <%=CHKIIF(vEventID="86441"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=86441" target="_top">5월호</a>
			</li>

			<% if currentdate < "2018-06-25" then %>
			<li class="swiper-slide month10">
			<% Else %>
			<li class="swiper-slide month10 open <%=CHKIIF(vEventID="87368"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=87368" target="_top">6월호</a>
			</li>

			<% if currentdate < "2018-07-26" then %>
			<li class="swiper-slide month11">
			<% Else %>
			<li class="swiper-slide month11 open <%=CHKIIF(vEventID="88116"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=88116" target="_top">7월호</a>
			</li>

			<% if currentdate < "2018-08-29" then %>
			<li class="swiper-slide month13 next-eco">
			<% Else %>
			<li class="swiper-slide month13 open <%=CHKIIF(vEventID="88904"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=88904" target="_top">9월호</a>
			</li>

			<% if currentdate < "2018-11-05" then %>
			<li class="swiper-slide month15">
			<% Else %>
			<li class="swiper-slide month15 open <%=CHKIIF(vEventID="90218"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=90218" target="_top">11월호</a>
			</li>

		</ul>
	</div>
	<button class="btnPrev"><img src="http://webimage.10x10.co.kr/eventIMG/2017/77954/btn_prev.png" alt="이전" /></button>
	<button class="btnNext"><img src="http://webimage.10x10.co.kr/eventIMG/2017/77954/btn_next.png" alt="다음" /></button>
</div>

</body>
</html>