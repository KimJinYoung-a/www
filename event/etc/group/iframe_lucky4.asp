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
	If vEventID = "91202" Then '// 2018-12-12
		vStartNo = "0"
	ElseIf vEventID = "91229" Then '// 2018-12-13
		vStartNo = "0"
	ElseIf vEventID = "91264" Then '// 2018-12-14
		vStartNo = "0"
	ElseIf vEventID = "91265" Then '// 2018-12-15
		vStartNo = "0"
	ElseIf vEventID = "91266" Then '// 2018-12-17
		vStartNo = "1"
	ElseIf vEventID = "91140" Then '// 2018-12-18
		vStartNo = "2"
	ElseIf vEventID = "91258" Then '// 2018-12-19
		vStartNo = "3"
	ElseIf vEventID = "91311" Then '// 2018-12-20
		vStartNo = "4"
	ElseIf vEventID = "91468" Then '// 2018-12-21
		vStartNo = "5"
	ElseIf vEventID = "91402" Then '// 2018-12-22
		vStartNo = "6"
	ElseIf vEventID = "91440" Then '// 2018-12-24,25
		vStartNo = "7"
	ElseIf vEventID = "91314" Then '// 2018-12-26
		vStartNo = "8"
	ElseIf vEventID = "91477" Then '// 2018-12-27
		vStartNo = "9"
	ElseIf vEventID = "91509" Then '// 2018-12-28
		vStartNo = "10"
	ElseIf vEventID = "91582" Then '// 2018-12-29,30
		vStartNo = "10"
	ElseIf vEventID = "91545" Then '// 2018-12-31,1
		vStartNo = "10"
	ElseIf vEventID = "91383" Then '// 2019-01-02
		vStartNo = "10"
	else
		vStartNo = "0"
	End IF
%>
<style type="text/css">
.lucky-day {position:relative; width:1140px; height:110px; padding-top:30px; background:#daeaf2;}
.lucky-day .swiper-container {width:910px; height:110px; margin:0 auto; }
.lucky-day li {position:relative; overflow:hidden; float:left; height:110px; text-align:center; cursor:pointer;}
.lucky-day li a {display:block; position:absolute; left:10px; top:0; width:110px; height:110px; text-indent:-999em;}
.lucky-day li.current img {margin-top:-120px;}
.lucky-day li.coming img {margin-top:-240px;}
.lucky-day li.soldout img {margin-top:-360px;}
.lucky-day button {display:block; position:absolute; top:30px; width:34px; height:110px; background-position:50% 50%; background-repeat:no-repeat; background-color:transparent; text-indent:-999em;}
.lucky-day .btnPrev {left:80px; background-image:url(http://webimage.10x10.co.kr/fixevent/even/91202/btn_prev_date.png);}
.lucky-day .btnNext {right:80px; background-image:url(http://webimage.10x10.co.kr/fixevent/even/91202/btn_next_date.png);}
</style>
<script type="text/javascript">
$(function(){
	// iframe
	var evtSwiper = new Swiper('.lucky-day .swiper-container',{
		initialSlide:<%=vStartNo%>,
		slidesPerView:7,
		speed:300
	})
	$('.lucky-day .btnPrev').on('click', function(e){
		e.preventDefault();
		evtSwiper.swipePrev();
	})
	$('.lucky-day .btnNext').on('click', function(e){
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

<div class="lucky-day">
	<div class="swiper-container">
		<ul class="swiper-wrapper">
			<%' 솔드아웃 된 탭에 soldout 클래스 추가 <li class="swiper-slide soldout">...</li>%>
			<% if currentdate < "2018-12-12" then %>
				<li class="swiper-slide coming">
			<% Else %>
				<li class="swiper-slide <%=CHKIIF(vEventID="91202"," current","")%>">
			<% End If %>
				<img src="http://webimage.10x10.co.kr/fixevent/event/2018/91202/txt_date_1212.png?v=1.0" alt="2018년 12월 12일" />
				<a href="/event/eventmain.asp?eventid=91202" target="_top">이벤트 바로가기</a>
			</li>

			<% if currentdate < "2018-12-13" then %>
				<li class="swiper-slide coming">
			<% Else %>
				<li class="swiper-slide <%=CHKIIF(vEventID="91229"," current","")%>">
			<% End If %>
				<img src="http://webimage.10x10.co.kr/fixevent/event/2018/91202/txt_date_1213.png?v=1.0" alt="2018년 12월 13일" />
				<a href="/event/eventmain.asp?eventid=91229" target="_top">이벤트 바로가기</a>
			</li>

			<% if currentdate < "2018-12-14" then %>
				<li class="swiper-slide coming">
			<% Else %>
				<li class="swiper-slide <%=CHKIIF(vEventID="91264"," current","")%>">
			<% End If %>
				<img src="http://webimage.10x10.co.kr/fixevent/event/2018/91202/txt_date_1214.png?v=1.0" alt="2018년 12월 14일" />
				<a href="/event/eventmain.asp?eventid=91264" target="_top">이벤트 바로가기</a>
			</li>

			<% if currentdate < "2018-12-15" then %>
				<li class="swiper-slide coming">
			<% Else %>
				<li class="swiper-slide <%=CHKIIF(vEventID="91265"," current","")%>">
			<% End If %>
				<img src="http://webimage.10x10.co.kr/fixevent/event/2018/91202/txt_date_1215.png?v=1.0" alt="2018년 12월 15일" />
				<a href="/event/eventmain.asp?eventid=91265" target="_top">이벤트 바로가기</a>
			</li>

			<% if currentdate < "2018-12-17" then %>
				<li class="swiper-slide coming">
			<% Else %>
				<li class="swiper-slide <%=CHKIIF(vEventID="91266"," current","")%>">
			<% End If %>
				<img src="http://webimage.10x10.co.kr/fixevent/event/2018/91202/txt_date_1217.png?v=1.0" alt="2018년 12월 17일" />
				<a href="/event/eventmain.asp?eventid=91266" target="_top">이벤트 바로가기</a>
			</li>

			<% if currentdate < "2018-12-18" then %>
				<li class="swiper-slide coming">
			<% Else %>
				<li class="swiper-slide <%=CHKIIF(vEventID="91140"," current","")%>">
			<% End If %>
				<img src="http://webimage.10x10.co.kr/fixevent/event/2018/91202/txt_date_1218.png?v=1.0" alt="2018년 12월 18일" />
				<a href="/event/eventmain.asp?eventid=91140" target="_top">이벤트 바로가기</a>
			</li>

			<% if currentdate < "2018-12-19" then %>
				<li class="swiper-slide coming">
			<% Else %>
				<li class="swiper-slide <%=CHKIIF(vEventID="91258"," current","")%>">
			<% End If %>
				<img src="http://webimage.10x10.co.kr/fixevent/event/2018/91202/txt_date_1219.png?v=1.0" alt="2018년 12월 19일" />
				<a href="/event/eventmain.asp?eventid=91258" target="_top">이벤트 바로가기</a>
			</li>

			<% if currentdate < "2018-12-20" then %>
				<li class="swiper-slide coming">
			<% Else %>
				<li class="swiper-slide <%=CHKIIF(vEventID="91311"," current","")%>">
			<% End If %>
				<img src="http://webimage.10x10.co.kr/fixevent/event/2018/91202/txt_date_1220.png?v=1.0" alt="2018년 12월 20일" />
				<a href="/event/eventmain.asp?eventid=91311" target="_top">이벤트 바로가기</a>
			</li>

			<% if currentdate < "2018-12-21" then %>
				<li class="swiper-slide coming">
			<% Else %>
				<li class="swiper-slide <%=CHKIIF(vEventID="91468"," current","")%>">
			<% End If %>
				<img src="http://webimage.10x10.co.kr/fixevent/event/2018/91202/txt_date_1221.png?v=1.0" alt="2018년 12월 21일" />
				<a href="/event/eventmain.asp?eventid=91468" target="_top">이벤트 바로가기</a>
			</li>

			<% if currentdate < "2018-12-22" then %>
				<li class="swiper-slide coming">
			<% Else %>
				<li class="swiper-slide <%=CHKIIF(vEventID="91402"," current","")%>">
			<% End If %>
				<img src="http://webimage.10x10.co.kr/fixevent/event/2018/91202/txt_date_1222.png?v=1.0" alt="2018년 12월 22,23일" />
				<a href="/event/eventmain.asp?eventid=91402" target="_top">이벤트 바로가기</a>
			</li>

			<% if currentdate < "2018-12-24" then %>
				<li class="swiper-slide coming">
			<% Else %>
				<li class="swiper-slide <%=CHKIIF(vEventID="91440"," current","")%>">
			<% End If %>
				<img src="http://webimage.10x10.co.kr/fixevent/event/2018/91202/txt_date_1224.png?v=1.02" alt="2018년 12월 24,25일" />
				<a href="/event/eventmain.asp?eventid=91440" target="_top">이벤트 바로가기</a>
			</li>

			<% if currentdate < "2018-12-26" then %>
				<li class="swiper-slide coming">
			<% Else %>
				<li class="swiper-slide <%=CHKIIF(vEventID="91314"," current","")%>">
			<% End If %>
				<img src="http://webimage.10x10.co.kr/fixevent/event/2018/91202/txt_date_1226.png?v=1.0" alt="2018년 12월 26일" />
				<a href="/event/eventmain.asp?eventid=91314" target="_top">이벤트 바로가기</a>
			</li>

			<% if currentdate < "2018-12-27" then %>
				<li class="swiper-slide coming">
			<% Else %>
				<li class="swiper-slide <%=CHKIIF(vEventID="91477"," current","")%>">
			<% End If %>
				<img src="http://webimage.10x10.co.kr/fixevent/event/2018/91202/txt_date_1227.png?v=1.0" alt="2018년 12월 27일" />
				<a href="/event/eventmain.asp?eventid=91477" target="_top">이벤트 바로가기</a>
			</li>

			<% if currentdate < "2018-12-28" then %>
				<li class="swiper-slide coming">
			<% Else %>
				<li class="swiper-slide <%=CHKIIF(vEventID="91509"," current","")%>">
			<% End If %>
				<img src="http://webimage.10x10.co.kr/fixevent/event/2018/91202/txt_date_1228.png?v=1.0" alt="2018년 12월 28일" />
				<a href="/event/eventmain.asp?eventid=91509" target="_top">이벤트 바로가기</a>
			</li>

			<% if currentdate < "2018-12-29" then %>
				<li class="swiper-slide coming">
			<% Else %>
				<li class="swiper-slide <%=CHKIIF(vEventID="91582"," current","")%>">
			<% End If %>
				<img src="http://webimage.10x10.co.kr/fixevent/event/2018/91202/txt_date_1229.png?v=1.0" alt="2018년 12월 29,30일" />
				<a href="/event/eventmain.asp?eventid=91582" target="_top">이벤트 바로가기</a>
			</li>

			<% if currentdate < "2018-12-31" then %>
				<li class="swiper-slide coming">
			<% Else %>
				<li class="swiper-slide <%=CHKIIF(vEventID="91545"," current","")%>">
			<% End If %>
				<img src="http://webimage.10x10.co.kr/fixevent/event/2018/91202/txt_date_1231.png?v=1.02" alt="2018년 12월 31,1일" />
				<a href="/event/eventmain.asp?eventid=91545" target="_top">이벤트 바로가기</a>
			</li>

			<% if currentdate < "2019-01-02" then %>
				<li class="swiper-slide coming">
			<% Else %>
				<li class="swiper-slide <%=CHKIIF(vEventID="91383"," current","")%>">
			<% End If %>
				<img src="http://webimage.10x10.co.kr/fixevent/event/2018/91202/txt_date_0102.png?v=1.01" alt="2019년 1월 2일" />
				<a href="/event/eventmain.asp?eventid=91383" target="_top">이벤트 바로가기</a>
			</li>
		</ul>
	</div>
	<button class="btnPrev">이전</button>
	<button class="btnNext">다음</button>
</div>
</body>
</html>