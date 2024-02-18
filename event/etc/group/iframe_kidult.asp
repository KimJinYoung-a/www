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
	If vEventID = "83094" Then '// 12월
		vStartNo = "0"
	ElseIf vEventID = "83921" Then '// 1월
		vStartNo = "0"
	ElseIf vEventID = "84640" Then '// 2월
		vStartNo = "0"
	ElseIf vEventID = "85326" Then '// 3월
		vStartNo = "1"
	ElseIf vEventID = "86090" Then '// 4월
		vStartNo = "1"
	ElseIf vEventID = "86105" Then '// 5월
		vStartNo = "3"
	ElseIf vEventID = "88362" Then '// 8월
		vStartNo = "4"
	ElseIf vEventID = "89263" Then '// 9월
		vStartNo = "5"
	ElseIf vEventID = "90101" Then '// 10월
		vStartNo = "6"
	ElseIf vEventID = "90556" Then '// 11월
		vStartNo = "7"
	ElseIf vEventID = "90909" Then '// 12월
		vStartNo = "7"
	End IF
%>
<style type="text/css">
.navigation {width:546px; position:relative; height:25px !important; padding:0 10px;}
.navigation .swiper-container {width:100%; height:25px;}
.navigation .swiper-container:after {content:''; display:inline-block; position:absolute; left:0; top:0; width:3px; height:100%; background:#fff;}
.navigation li {position:relative; float:left; width:25%; height:25px; font-weight:bold; color:#b4b4b4; font:16px/25px 'Roboto','Noto Sans KR',sans-serif; text-align:center; cursor:context-menu;}
.navigation li:after {content:''; display:inline-block; position:absolute; left:0; top:0; width:2px; height:100%; background:#ffc600;}
.navigation li:first-child:after {display:none;}
.navigation li span {display:inline-block; width:100%; height:100%;}
.navigation li a {display:none; position:absolute; left:0; top:0; width:134px; height:25px; color:#b4b4b4;}
.navigation li.current a {color:#252525;}
.navigation li.open a {display:block; text-decoration:none;}
.navigation button {display:block; position:absolute; top:0; width:9px; height:25px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/83094/btn_nav.png) 0 50% no-repeat; text-indent:-999em; outline:none;}
.navigation .btnPrev {left:0;}
.navigation .btnNext {right:0; background-position:100% 0;}
</style>
<script type="text/javascript">
$(function(){
	var evtSwiper = new Swiper('.navigation .swiper-container',{
		initialSlide:<%=vStartNo%>,
		slidesPerView:4,
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
	$('.swiper-slide.coming').on('click', function(e){
		e.preventDefault();
		alert("오픈 예정 기획전 입니다.");
	});
});
</script>
</head>
<body>
<div class="navigation">
	<div class="swiper-container">
		<ul class="swiper-wrapper">
			<li class="swiper-slide month1 open <%=CHKIIF(vEventID="83094"," current","")%>"><a href="/event/eventmain.asp?eventid=83094" target="_top">12월호</a></li>

			<%' 오픈된 이벤트 open, 오늘 날짜에 current 클래스 넣어주세요 %>

			<% if currentdate < "2018-01-24" then %>
			<li class="swiper-slide coming"><span>1월호</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="83921"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=83921" target="_top"><b>1</b>월호</a>
			</li>

			<% if currentdate < "2018-02-21" then %>
			<li class="swiper-slide coming"><span>2월호</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="84640"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=84640" target="_top"><b>2</b>월호</a>
			</li>

			<% if currentdate < "2018-03-24" then %>
			<li class="swiper-slide coming"><span>3월호</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="85326"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=85326" target="_top"><b>3</b>월호</a>
			</li>

			<% if currentdate < "2018-04-25" then %>
			<li class="swiper-slide coming"><span>4월호</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="86090"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=86090" target="_top"><b>4</b>월호</a>
			</li>

			<% if currentdate < "2018-05-01" then %>
			<li class="swiper-slide coming"><span>5월호</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="86105"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=86105" target="_top"><b>5</b>월호</a>
			</li>

			<% if currentdate < "2018-08-06" then %>
			<li class="swiper-slide coming"><span>8월호</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="88362"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=88362" target="_top"><b>8</b>월호</a>
			</li>

			<% if currentdate < "2018-09-18" then %>
			<li class="swiper-slide coming"><span>9월호</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="89263"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=89263" target="_top"><b>9</b>월호</a>
			</li>

			<% if currentdate < "2018-10-30" then %>
			<li class="swiper-slide coming"><span>10월호</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="90101"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=90101" target="_top"><b>10</b>월호</a>
			</li>

			<% if currentdate < "2018-11-26" then %>
			<li class="swiper-slide coming">
				<span>11월호</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="90556"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=90556" target="_top">11월호</a>
			</li>

			<% if currentdate < "2018-12-05" then %>
			<li class="swiper-slide coming">
				<span>12월호</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="90909"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=90909" target="_top">12월호</a>
			</li>

			<% if currentdate < "2019-10-29" then %>
			<li class="swiper-slide coming">
				<span>1월호</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="0000"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=0000" target="_top">1월호</a>
			</li>

			<% if currentdate < "2019-10-29" then %>
			<li class="swiper-slide coming">
				<span>2월호</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="0000"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=0000" target="_top">2월호</a>
			</li>
		</ul>
	</div>
	<button class="btnPrev">이전</button>
	<button class="btnNext">다음</button>
</div>
</body>
</html>