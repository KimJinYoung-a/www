<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
dim currentdate
	currentdate = date()
	'currentdate = "2015-03-09"
	
	'response.write currentdate

	Dim vEventID, vStartNo
	vEventID = requestCheckVar(Request("eventid"),9)
	If vEventID = "81998" Then '// 2017-11-13
		vStartNo = "0"
	ElseIf vEventID = "82060" Then '// 2017-11-14
		vStartNo = "0"
	ElseIf vEventID = "81950" Then '// 2017-11-15
		vStartNo = "0"
	ElseIf vEventID = "81951" Then '// 2017-11-16
		vStartNo = "0"
	ElseIf vEventID = "82182" Then '// 2017-11-17
		vStartNo = "1"
	ElseIf vEventID = "81971" Then '// 2017-11-20
		vStartNo = "2"
	ElseIf vEventID = "82201" Then '// 2017-11-21
		vStartNo = "3"
	ElseIf vEventID = "81990" Then '// 2017-11-22
		vStartNo = "4"
	ElseIf vEventID = "82199" Then '// 2017-11-23
		vStartNo = "5"
	ElseIf vEventID = "81989" Then '// 2017-11-24
		vStartNo = "6"
	ElseIf vEventID = "82484" Then '// 2017-11-28
		vStartNo = "7"
	ElseIf vEventID = "82501" Then '// 2017-11-29
		vStartNo = "8"
	ElseIf vEventID = "82630" Then '// 2017-11-30
		vStartNo = "9"
	ElseIf vEventID = "82292" Then '// 2017-12/04
		vStartNo = "9"
	else
		vStartNo = "0"
	End IF

%>
<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
.luckyDay {position:relative; width:1140px; height:110px; padding:30px 0 38px; background:#df9682 url(http://webimage.10x10.co.kr/eventIMG/2017/81998/bg_nav.jpg) repeat-x;}
.luckyDay .swiper-container {width:910px; height:125px; margin:0 auto; }
.luckyDay li {position:relative; overflow:hidden; float:left; height:110px; text-align:center;}
.luckyDay li a {display:none;}
.luckyDay li.open a {display:block; position:absolute; left:10px; top:0; width:110px; height:110px; text-indent:-999em;}
.luckyDay li.current img {margin-top:-130px;}
.luckyDay li.soldout img {margin-top:-260px;}
.luckyDay button {display:block; position:absolute; top:30px; width:34px; height:110px; background-position:50% 50%; background-repeat:no-repeat; background-color:transparent; text-indent:-999em;}
.luckyDay .btnPrev {left:80px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/81998/btn_prev_date.png);}
.luckyDay .btnNext {right:80px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/81998/btn_next_date.png);}
</style>
<script type="text/javascript">
$(function(){
	// iframe
	var evtSwiper = new Swiper('.luckyDay .swiper-container',{
		initialSlide:<%=vStartNo%>,
		slidesPerView:7,
		speed:300
	})
	$('.luckyDay .btnPrev').on('click', function(e){
		e.preventDefault();
		evtSwiper.swipePrev();
	})
	$('.luckyDay .btnNext').on('click', function(e){
		e.preventDefault();
		evtSwiper.swipeNext();
	});
});
</script>
</head>
<body>

<div class="luckyDay">
	<div class="swiper-container">
		<ul class="swiper-wrapper">
			<%'  오픈된 이벤트 open, 오늘 날짜에 current 클래스 넣어주세요 %>
			<% if currentdate < "2017-11-13" then %>
				<li class="swiper-slide">
			<% Else %>
				<li class="swiper-slide open <%=CHKIIF(vEventID="81998"," current","")%>">
			<% End If %>
				<img src="http://webimage.10x10.co.kr/eventIMG/2017/81998/txt_date_1113.png" alt="11월 13일" />
				<a href="/event/eventmain.asp?eventid=81998" target="_top">이벤트 바로가기</a>
			</li>

			<% if currentdate < "2017-11-14" then %>
				<li class="swiper-slide">
			<% Else %>
				<li class="swiper-slide open <%=CHKIIF(vEventID="82060"," current","")%>">
			<% End If %>
				<img src="http://webimage.10x10.co.kr/eventIMG/2017/81998/txt_date_1114.png" alt="11월 14일" />
				<a href="/event/eventmain.asp?eventid=82060" target="_top">이벤트 바로가기</a>
			</li>

			<% if currentdate < "2017-11-15" then %>
				<li class="swiper-slide">
			<% Else %>
				<li class="swiper-slide open <%=CHKIIF(vEventID="81950"," current","")%>">
			<% End If %>
				<img src="http://webimage.10x10.co.kr/eventIMG/2017/81998/txt_date_1115.png" alt="11월 15일" />
				<a href="/event/eventmain.asp?eventid=81950" target="_top">이벤트 바로가기</a>
			</li>

			<% if currentdate < "2017-11-16" then %>
				<li class="swiper-slide">
			<% Else %>
				<li class="swiper-slide open <%=CHKIIF(vEventID="81951"," current","")%>">
			<% End If %>
				<img src="http://webimage.10x10.co.kr/eventIMG/2017/81998/txt_date_1116.png" alt="11월 16일" />
				<a href="/event/eventmain.asp?eventid=81951" target="_top">이벤트 바로가기</a>
			</li>

			<% if currentdate < "2017-11-17" then %>
				<li class="swiper-slide">
			<% Else %>
				<li class="swiper-slide open <%=CHKIIF(vEventID="82182"," current","")%>">
			<% End If %>
				<img src="http://webimage.10x10.co.kr/eventIMG/2017/81998/txt_date_1117.png" alt="11월 17일" />
				<a href="/event/eventmain.asp?eventid=82182" target="_top">이벤트 바로가기</a>
			</li>

			<% if currentdate < "2017-11-20" then %>
				<li class="swiper-slide">
			<% Else %>
				<li class="swiper-slide open <%=CHKIIF(vEventID="81971"," current","")%>">
			<% End If %>
				<img src="http://webimage.10x10.co.kr/eventIMG/2017/81998/txt_date_1120.png" alt="11월 20일" />
				<a href="/event/eventmain.asp?eventid=81971" target="_top">이벤트 바로가기</a>
			</li>

			<% if currentdate < "2017-11-21" then %>
				<li class="swiper-slide">
			<% Else %>
				<li class="swiper-slide open <%=CHKIIF(vEventID="82201"," current","")%>">
			<% End If %>
				<img src="http://webimage.10x10.co.kr/eventIMG/2017/81998/txt_date_1121.png" alt="11월 21일" />
				<a href="/event/eventmain.asp?eventid=82201" target="_top">이벤트 바로가기</a>
			</li>

			<% if currentdate < "2017-11-22" then %>
				<li class="swiper-slide">
			<% Else %>
				<li class="swiper-slide open <%=CHKIIF(vEventID="81990"," current","")%>">
			<% End If %>
				<img src="http://webimage.10x10.co.kr/eventIMG/2017/81998/txt_date_1122.png" alt="11월 22일" />
				<a href="/event/eventmain.asp?eventid=81990" target="_top">이벤트 바로가기</a>
			</li>

			<% if currentdate < "2017-11-23" then %>
				<li class="swiper-slide">
			<% Else %>
				<li class="swiper-slide open <%=CHKIIF(vEventID="82199"," current","")%>">
			<% End If %>
				<img src="http://webimage.10x10.co.kr/eventIMG/2017/81998/txt_date_1123.png" alt="11월 23일" />
				<a href="/event/eventmain.asp?eventid=82199" target="_top">이벤트 바로가기</a>
			</li>

			<% if currentdate < "2017-11-24" then %>
				<li class="swiper-slide">
			<% Else %>
				<li class="swiper-slide open <%=CHKIIF(vEventID="81989"," current","")%>">
			<% End If %>
				<img src="http://webimage.10x10.co.kr/eventIMG/2017/81998/txt_date_1124.png" alt="11월 24일" />
				<a href="/event/eventmain.asp?eventid=81989" target="_top">이벤트 바로가기</a>
			</li>

			<% if currentdate < "2017-11-28" then %>
				<li class="swiper-slide">
			<% Else %>
				<li class="swiper-slide open <%=CHKIIF(vEventID="82484"," current","")%>">
			<% End If %>
				<img src="http://webimage.10x10.co.kr/eventIMG/2017/81998/txt_date_1128.png" alt="11월 28일" />
				<a href="/event/eventmain.asp?eventid=82484" target="_top">이벤트 바로가기</a>
			</li>

			<% if currentdate < "2017-11-30" then %>
				<li class="swiper-slide">
			<% Else %>
				<li class="swiper-slide open <%=CHKIIF(vEventID="82630"," current","")%>">
			<% End If %>
				<img src="http://webimage.10x10.co.kr/eventIMG/2017/81998/txt_date_1130_v1.png" alt="11월 30일" />
				<a href="/event/eventmain.asp?eventid=82630" target="_top">이벤트 바로가기</a>
			</li>

			<% if currentdate < "2017-12-04" then %>
				<li class="swiper-slide">
			<% Else %>
				<li class="swiper-slide open <%=CHKIIF(vEventID="82292"," current","")%>">
			<% End If %>
				<img src="http://webimage.10x10.co.kr/eventIMG/2017/82630/txt_date_1204.png" alt="12월 04일" />
				<a href="/event/eventmain.asp?eventid=82292" target="_top">이벤트 바로가기</a>
			</li>
		</ul>
	</div>
	<button class="btnPrev">이전</button>
	<button class="btnNext">다음</button>
</div>
</body>
</html>