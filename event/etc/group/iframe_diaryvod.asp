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
	If vEventID = "89316" Then '// vol.1
		vStartNo = "0"
	ElseIf vEventID = "89423" Then '// vol.2
		vStartNo = "0"
	ElseIf vEventID = "89628" Then '// vol.3
		vStartNo = "1"
	ElseIf vEventID = "89817" Then '// vol.4
		vStartNo = "2"
	ElseIf vEventID = "89818" Then '// vol.5
		vStartNo = "3"
	ElseIf vEventID = "90070" Then '// vol.6
		vStartNo = "4"
	ElseIf vEventID = "90249" Then '// vol.7
		vStartNo = "5"
	ElseIf vEventID = "90582" Then '// vol.8
		vStartNo = "6"
	ElseIf vEventID = "90718" Then '// vol.9
		vStartNo = "7"
	ElseIf vEventID = "90879" Then '// vol.10
		vStartNo = "8"
	ElseIf vEventID = "90871" Then '// vol.11
		vStartNo = "9"
	ElseIf vEventID = "91292" Then '// vol.12
		vStartNo = "10"
	ElseIf vEventID = "91894" Then '// vol.13
		vStartNo = "11"
	ElseIf vEventID = "92235" Then '// vol.14
		vStartNo = "12"
	ElseIf vEventID = "93796" Then '// vol.15
		vStartNo = "13"
	ElseIf vEventID = "93883" Then '// vol.16
		vStartNo = "14"
	ElseIf vEventID = "93887" Then '// vol.17
		vStartNo = "15"
	ElseIf vEventID = "94995" Then '// vol.18
		vStartNo = "16"
	ElseIf vEventID = "95454" Then '// vol.19
		vStartNo = "17"
	ElseIf vEventID = "95779" Then '// vol.20
		vStartNo = "18"
	ElseIf vEventID = "95898" Then '// vol.21
		vStartNo = "19"
	ElseIf vEventID = "96769" Then '// vol.22
		vStartNo = "20"
	else
		vStartNo = "0"
	End IF
%>
<style type="text/css">
.navigation {width:219px; position:relative; height:47px !important; padding:6px 26px;}
.navigation .swiper-container {width:100%; height:47px;}
.navigation .swiper-container:after {content:''; display:inline-block; position:absolute; left:0; top:0; width:3px; height:100%; background:#fff;}
.navigation li {position:relative; float:left; width:73px; height:47px; text-align:center; cursor:context-menu;}
.navigation li span, .navigation li a {overflow:hidden; width:73px; height:47px; background:url(//webimage.10x10.co.kr/fixevent/event/2018/89423/nav_series_off.png) no-repeat; text-indent:-9999em;}
.navigation li span {display:inline-block;}
.navigation li a {display:none; position:absolute; left:0; top:0;}
.navigation li.open a {display:inline-block;}
.navigation li.current a {background:url(//webimage.10x10.co.kr/fixevent/event/2018/89423/nav_series_on.png) no-repeat;}
.navigation li.vol1 span, .navigation li.vol1 a {background-position:0 0;}
.navigation li.vol2 span, .navigation li.vol2 a {background-position:-73px 0;}
.navigation li.vol3 span, .navigation li.vol3 a {background-position:-146px 0;}
.navigation li.vol4 span, .navigation li.vol4 a {background-position:-219px 0;}
.navigation li.vol5 span, .navigation li.vol5 a {background-position:-292px 0;}
.navigation li.vol6 span, .navigation li.vol6 a {background-position:-365px 0;}
.navigation li.vol7 span, .navigation li.vol7 a {background-position:-438px 0;}
.navigation li.vol8 span, .navigation li.vol8 a {background-position:-511px 0;}
.navigation li.vol9 span, .navigation li.vol9 a {background-position:-584px 0;}
.navigation li.vol10 span, .navigation li.vol10 a {background-position:-657px 0;}
.navigation li.vol11 span, .navigation li.vol11 a {background-position:-730px 0;}
.navigation li.vol12 span, .navigation li.vol12 a {background-position:-803px 0;}
.navigation li.vol13 span, .navigation li.vol13 a {background-position:-876px 0;}
.navigation li.vol14 span, .navigation li.vol14 a {background-position:-949px 0;}
.navigation li.vol15 span, .navigation li.vol15 a {background-position:-1022px 0;}
.navigation li.vol16 span, .navigation li.vol16 a {background-position:-1095px 0;}
.navigation li.vol17 span, .navigation li.vol17 a {background-position:-1168px 0;}
.navigation li.vol18 span, .navigation li.vol18 a {background-position:-1241px 0;}
.navigation li.vol19 span, .navigation li.vol19 a {background-position:-1314px 0;}
.navigation li.vol20 span, .navigation li.vol20 a {background-position:-1387px 0;}
.navigation li.vol21 span, .navigation li.vol21 a {background-position:-1460px 0;}
.navigation li.vol22 span, .navigation li.vol22 a {background-position:-1533px 0;}
.navigation li.vol23 span, .navigation li.vol23 a {background-position:-1606px 0;}
.navigation li.vol24 span, .navigation li.vol24 a {background-position:-1679px 0;}
.navigation button {display:block; position:absolute; top:6px; width:9px; height:47px; background:url(//webimage.10x10.co.kr/fixevent/event/2018/89423/btn_slide_nav.png) 0 50% no-repeat; text-indent:-999em; outline:none;}
.navigation .btnPrev {left:0;}
.navigation .btnNext {right:0; background-position:100% 50%;}
</style>
<script type="text/javascript">
$(function(){
	var evtSwiper = new Swiper('.navigation .swiper-container',{
		initialSlide:<%=vStartNo%>,
		slidesPerView:3,
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
			<li class="swiper-slide vol1 open <%=CHKIIF(vEventID="89316"," current","")%>"><a href="/event/eventmain.asp?eventid=89316" target="_top">vol.1</a></li>

			<%' 오픈된 이벤트 open, 오늘 날짜에 current 클래스 넣어주세요 %>

			<% if currentdate < "2018-09-24" then %>
			<li class="swiper-slide vol2 coming">
				<span>vol.2</span>
			<% Else %>
			<li class="swiper-slide vol2 open <%=CHKIIF(vEventID="89423"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=89423" target="_top">vol.2</a>
			</li>

			<% if currentdate < "2018-10-08" then %>
			<li class="swiper-slide vol3 coming">
				<span>vol.3</span>
			<% Else %>
			<li class="swiper-slide vol3 open <%=CHKIIF(vEventID="89628"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=89628" target="_top">vol.3</a>
			</li>

			<% if currentdate < "2018-10-15" then %>
			<li class="swiper-slide vol4 coming">
				<span>vol.4</span>
			<% Else %>
			<li class="swiper-slide vol4 open <%=CHKIIF(vEventID="89817"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=89817" target="_top">vol.4</a>
			</li>

			<% if currentdate < "2018-10-22" then %>
			<li class="swiper-slide vol5 coming">
				<span>vol.5</span>
			<% Else %>
			<li class="swiper-slide vol5 open <%=CHKIIF(vEventID="89818"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=89818" target="_top">vol.5</a>
			</li>

			<% if currentdate < "2018-10-29" then %>
			<li class="swiper-slide vol6 coming">
				<span>vol.6</span>
			<% Else %>
			<li class="swiper-slide vol6 open <%=CHKIIF(vEventID="90070"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=90070" target="_top">vol.6</a>
			</li>

			<% if currentdate < "2018-11-12" then %>
			<li class="swiper-slide vol7 coming">
				<span>vol.7</span>
			<% Else %>
			<li class="swiper-slide vol7 open <%=CHKIIF(vEventID="90249"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=90249" target="_top">vol.7</a>
			</li>

			<% if currentdate < "2018-11-19" then %>
			<li class="swiper-slide vol8 coming">
				<span>vol.8</span>
			<% Else %>
			<li class="swiper-slide vol8 open <%=CHKIIF(vEventID="90582"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=90582" target="_top">vol.8</a>
			</li>

			<% if currentdate < "2018-11-26" then %>
			<li class="swiper-slide vol9 coming">
				<span>vol.9</span>
			<% Else %>
			<li class="swiper-slide vol9 open <%=CHKIIF(vEventID="90718"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=90718" target="_top">vol.9</a>
			</li>

			<% if currentdate < "2018-12-03" then %>
			<li class="swiper-slide vol10 coming">
				<span>vol.10</span>
			<% Else %>
			<li class="swiper-slide vol10 open <%=CHKIIF(vEventID="90879"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=90879" target="_top">vol.10</a>
			</li>

			<% if currentdate < "2018-12-10" then %>
			<li class="swiper-slide vol11 coming">
				<span>vol.11</span>
			<% Else %>
			<li class="swiper-slide vol11 open <%=CHKIIF(vEventID="90871"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=90871" target="_top">vol.11</a>
			</li>

			<% if currentdate < "2018-12-17" then %>
			<li class="swiper-slide vol12 coming">
				<span>vol.12</span>
			<% Else %>
			<li class="swiper-slide vol12 open <%=CHKIIF(vEventID="91292"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=91292" target="_top">vol.12</a>
			</li>

			<% if currentdate < "2019-01-14" then %>
			<li class="swiper-slide vol13 coming">
				<span>vol.13</span>
			<% Else %>
			<li class="swiper-slide vol13 open <%=CHKIIF(vEventID="91894"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=91894" target="_top">vol.13</a>
			</li>

			<% if currentdate < "2019-01-28" then %>
			<li class="swiper-slide vol14 coming">
				<span>vol.14</span>
			<% Else %>
			<li class="swiper-slide vol14 open <%=CHKIIF(vEventID="92235"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=92235" target="_top">vol.14</a>
			</li> 

			<% if currentdate < "2019-04-11" then %>
			<li class="swiper-slide vol15 coming">
				<span>vol.15</span>
			<% Else %>
			<li class="swiper-slide vol15 open <%=CHKIIF(vEventID="93796"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=93796" target="_top">vol.15</a>
			</li>

			<% if currentdate < "2019-04-18" then %>
			<li class="swiper-slide vol16 coming">
				<span>vol.16</span>
			<% Else %>
			<li class="swiper-slide vol16 open <%=CHKIIF(vEventID="93883"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=93883" target="_top">vol.16</a>
			</li> 

			<% if currentdate < "2019-04-19" then %>
			<li class="swiper-slide vol17 coming">
				<span>vol.17</span>
			<% Else %>
			<li class="swiper-slide vol17 open <%=CHKIIF(vEventID="93887"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=93887" target="_top">vol.17</a>
			</li>

			<% if currentdate < "2019-06-03" then %>
			<li class="swiper-slide vol18 coming">
				<span>vol.18</span>
			<% Else %>
			<li class="swiper-slide vol18 open <%=CHKIIF(vEventID="94995"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=94995" target="_top">vol.18</a>
			</li> 

			<% if currentdate < "2019-06-26" then %>
			<li class="swiper-slide vol19 coming">
				<span>vol.19</span>
			<% Else %>
			<li class="swiper-slide vol19 open <%=CHKIIF(vEventID="95454"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=95454" target="_top">vol.19</a>
			</li>

			<% if currentdate < "2019-07-10" then %>
			<li class="swiper-slide vol20 coming">
				<span>vol.20</span>
			<% Else %>
			<li class="swiper-slide vol20 open <%=CHKIIF(vEventID="95779"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=95779" target="_top">vol.20</a>
			</li>

			<% if currentdate < "2019-07-24" then %>
			<li class="swiper-slide vol21 coming">
				<span>vol.21</span>
			<% Else %>
			<li class="swiper-slide vol21 open <%=CHKIIF(vEventID="95898"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=95898" target="_top">vol.21</a>
			</li> 

			<% if currentdate < "2019-08-21" then %>
			<li class="swiper-slide vol22 coming">
				<span>vol.22</span>
			<% Else %>
			<li class="swiper-slide vol22 open <%=CHKIIF(vEventID="96769"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=96769" target="_top">vol.22</a>
			</li> 

			<% if currentdate < "2019-12-24" then %>
			<li class="swiper-slide vol23 coming">
				<span>vol.23</span>
			<% Else %>
			<li class="swiper-slide vol23 open <%=CHKIIF(vEventID="00000"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=00000" target="_top">vol.23</a>
			</li> 

			<% if currentdate < "2019-12-24" then %>
			<li class="swiper-slide vol24 coming">
				<span>vol.24</span>
			<% Else %>
			<li class="swiper-slide vol24 open <%=CHKIIF(vEventID="00000"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=00000" target="_top">vol.24</a>
			</li>
		</ul>
	</div>
	<button class="btnPrev">이전</button>
	<button class="btnNext">다음</button>
</div>
</body>
</html>