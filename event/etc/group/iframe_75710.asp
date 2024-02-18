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
'		initialSlide:vStartNo, // 23일~29일:7, 30일~2월5일:14, 2월6일~2월12일:21
	If vEventID = "75710" Then '// 2017-01-16
		vStartNo = "0"
	ElseIf vEventID = "75758" Then '// 2017-01-17
		vStartNo = "0"
	ElseIf vEventID = "75752" Then '// 2017-01-18
		vStartNo = "0"
	ElseIf vEventID = "75761" Then '// 2017-01-19
		vStartNo = "0"
	ElseIf vEventID = "75759" Then '// 2017-01-20
		vStartNo = "1"
	ElseIf vEventID = "75768" Then '// 2017-01-23
		vStartNo = "2"
	ElseIf vEventID = "75872" Then '// 2017-01-24
		vStartNo = "3"
	ElseIf vEventID = "75855" Then '// 2017-01-25
		vStartNo = "4"
	ElseIf vEventID = "75843" Then '// 2017-01-26
		vStartNo = "5"
	ElseIf vEventID = "75864" Then '// 2017-01-30
		vStartNo = "6"
	ElseIf vEventID = "75942" Then '// 2017-01-31
		vStartNo = "7"
	ElseIf vEventID = "75984" Then '// 2017-02-01
		vStartNo = "8"
	ElseIf vEventID = "76014" Then '// 2017-02-02
		vStartNo = "9"
	ElseIf vEventID = "75966" Then '// 2017-02-03
		vStartNo = "10"
	ElseIf vEventID = "75981" Then '// 2017-02-06
		vStartNo = "11"
	ElseIf vEventID = "75968" Then '// 2017-02-07
		vStartNo = "13"
	ElseIf vEventID = "75967" Then '// 2017-02-08
		vStartNo = "14"
	ElseIf vEventID = "75988" Then '// 2017-02-09
		vStartNo = "14"
	ElseIf vEventID = "75989" Then '// 2017-02-10
		vStartNo = "14"
	else
		vStartNo = "0"
	End IF

%>

<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
.luckyDay {position:relative; width:1140px; height:110px; padding:30px 0 40px; background:#daeaf2;}
.luckyDay .swiper-container {width:910px; height:125px; margin:0 auto; }
.luckyDay li {position:relative; overflow:hidden; float:left; height:110px;  text-align:center;}
.luckyDay li a {display:none;}
.luckyDay li.open a {display:block; position:absolute; left:10px; top:0; width:110px; height:110px; text-indent:-999em;}
.luckyDay li.current img {margin-top:-130px;}
.luckyDay li.soldout img {margin-top:-260px;}
.luckyDay button {display:block; position:absolute; top:30px; width:34px; height:110px; background-position:50% 50%; background-repeat:no-repeat; background-color:transparent; text-indent:-999em;}
.luckyDay .btnPrev {left:80px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/75710/btn_prev_date.png);}
.luckyDay .btnNext {right:80px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/75710/btn_next_date.png);}
</style>
<script type="text/javascript">
$(function(){
	// iframe
	var evtSwiper = new Swiper('.luckyDay .swiper-container',{
		initialSlide:<%=vStartNo%>, // 23일~29일:7, 30일~2월5일:14, 2월6일~2월12일:21
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
			<% if currentdate < "2017-01-16" then %>
				<li class="swiper-slide">
			<% Else %>
				<li class="swiper-slide soldout open <%=CHKIIF(vEventID="75710"," current","")%>">
			<% End If %>
				<img src="http://webimage.10x10.co.kr/eventIMG/2017/75710/txt_date_0116.png" alt="1월 16일" />
				<a href="/event/eventmain.asp?eventid=75710" target="_top">이벤트 바로가기</a>
			</li>

			<% if currentdate < "2017-01-17" then %>
				<li class="swiper-slide">
			<% Else %>
				<li class="swiper-slide soldout open <%=CHKIIF(vEventID="75758"," current","")%>">
			<% End If %>
				<img src="http://webimage.10x10.co.kr/eventIMG/2017/75710/txt_date_0117.png" alt="1월 17일" />
				<a href="/event/eventmain.asp?eventid=75758" target="_top">이벤트 바로가기</a>
			</li>

			<% if currentdate < "2017-01-18" then %>
				<li class="swiper-slide">
			<% Else %>
				<li class="swiper-slide open <%=CHKIIF(vEventID="75752"," current","")%>">
			<% End If %>
				<img src="http://webimage.10x10.co.kr/eventIMG/2017/75710/txt_date_0118.png" alt="1월 18일" />
				<a href="/event/eventmain.asp?eventid=75752" target="_top">이벤트 바로가기</a>
			</li>

			<% if currentdate < "2017-01-19" then %>
				<li class="swiper-slide">
			<% Else %>
				<li class="swiper-slide soldout open <%=CHKIIF(vEventID="75761"," current","")%>">
			<% End If %>
				<img src="http://webimage.10x10.co.kr/eventIMG/2017/75710/txt_date_0119.png" alt="1월 19일" />
				<a href="/event/eventmain.asp?eventid=75761" target="_top">이벤트 바로가기</a>
			</li>

			<% if currentdate < "2017-01-20" then %>
				<li class="swiper-slide">
			<% Else %>
				<li class="swiper-slide open <%=CHKIIF(vEventID="75759"," current","")%>">
			<% End If %>
				<img src="http://webimage.10x10.co.kr/eventIMG/2017/75710/txt_date_0120.png" alt="1월 20일" />
				<a href="/event/eventmain.asp?eventid=75759" target="_top">이벤트 바로가기</a>
			</li>

			<% if currentdate < "2017-01-23" then %>
				<li class="swiper-slide">
			<% Else %>
				<li class="swiper-slide open <%=CHKIIF(vEventID="75768"," current","")%>">
			<% End If %>
				<img src="http://webimage.10x10.co.kr/eventIMG/2017/75710/txt_date_0123.png" alt="1월 23일" />
				<a href="/event/eventmain.asp?eventid=75768" target="_top">이벤트 바로가기</a>
			</li>

			<% if currentdate < "2017-01-24" then %>
				<li class="swiper-slide">
			<% Else %>
				<li class="swiper-slide open <%=CHKIIF(vEventID="75872"," current","")%>">
			<% End If %>
				<img src="http://webimage.10x10.co.kr/eventIMG/2017/75710/txt_date_0124.png" alt="1월 24일" />
				<a href="/event/eventmain.asp?eventid=75872" target="_top">이벤트 바로가기</a>
			</li>

			<% if currentdate < "2017-01-25" then %>
				<li class="swiper-slide">
			<% Else %>
				<li class="swiper-slide soldout open <%=CHKIIF(vEventID="75855"," current","")%>">
			<% End If %>
				<img src="http://webimage.10x10.co.kr/eventIMG/2017/75710/txt_date_0125.png" alt="1월 25일" />
				<a href="/event/eventmain.asp?eventid=75855" target="_top">이벤트 바로가기</a>
			</li>

			<% if currentdate < "2017-01-26" then %>
				<li class="swiper-slide">
			<% Else %>
				<li class="swiper-slide open <%=CHKIIF(vEventID="75843"," current","")%>">
			<% End If %>
				<img src="http://webimage.10x10.co.kr/eventIMG/2017/75710/txt_date_0126.png" alt="1월 26일" />
				<a href="/event/eventmain.asp?eventid=75843" target="_top">이벤트 바로가기</a>
			</li>

			<% if currentdate < "2017-01-30" then %>
				<li class="swiper-slide">
			<% Else %>
				<li class="swiper-slide soldout open <%=CHKIIF(vEventID="75864"," current","")%>">
			<% End If %>
				<img src="http://webimage.10x10.co.kr/eventIMG/2017/75710/txt_date_0130.png" alt="1월 30일" />
				<a href="/event/eventmain.asp?eventid=75864" target="_top">이벤트 바로가기</a>
			</li>

			<% if currentdate < "2017-01-31" then %>
				<li class="swiper-slide">
			<% Else %>
				<li class="swiper-slide open <%=CHKIIF(vEventID="75942"," current","")%>">
			<% End If %>
				<img src="http://webimage.10x10.co.kr/eventIMG/2017/75710/txt_date_0131.png" alt="1월 31일" />
				<a href="/event/eventmain.asp?eventid=75942" target="_top">이벤트 바로가기</a>
			</li>

			<% if currentdate < "2017-02-01" then %>
				<li class="swiper-slide">
			<% Else %>
				<li class="swiper-slide soldout open <%=CHKIIF(vEventID="75984"," current","")%>">
			<% End If %>
				<img src="http://webimage.10x10.co.kr/eventIMG/2017/75710/txt_date_0201.png" alt="2월 1일" />
				<a href="/event/eventmain.asp?eventid=75984" target="_top">이벤트 바로가기</a>
			</li>

			<% if currentdate < "2017-02-02" then %>
				<li class="swiper-slide">
			<% Else %>
				<li class="swiper-slide open <%=CHKIIF(vEventID="76014"," current","")%>">
			<% End If %>
				<img src="http://webimage.10x10.co.kr/eventIMG/2017/75710/txt_date_0202.png" alt="2월 2일" />
				<a href="/event/eventmain.asp?eventid=76014" target="_top">이벤트 바로가기</a>
			</li>

			<% if currentdate < "2017-02-03" then %>
				<li class="swiper-slide">
			<% Else %>
				<li class="swiper-slide soldout open <%=CHKIIF(vEventID="75966"," current","")%>">
			<% End If %>
				<img src="http://webimage.10x10.co.kr/eventIMG/2017/75710/txt_date_0203.png" alt="2월 3일" />
				<a href="/event/eventmain.asp?eventid=75966" target="_top">이벤트 바로가기</a>
			</li>

			<% if currentdate < "2017-02-06" then %>
				<li class="swiper-slide">
			<% Else %>
				<li class="swiper-slide open <%=CHKIIF(vEventID="75981"," current","")%>">
			<% End If %>
				<img src="http://webimage.10x10.co.kr/eventIMG/2017/75710/txt_date_0206.png" alt="2월 6일" />
				<a href="/event/eventmain.asp?eventid=75981" target="_top">이벤트 바로가기</a>
			</li>

			<% if currentdate < "2017-02-07" then %>
				<li class="swiper-slide">
			<% Else %>
				<li class="swiper-slide open <%=CHKIIF(vEventID="75968"," current","")%>">
			<% End If %>
				<img src="http://webimage.10x10.co.kr/eventIMG/2017/75710/txt_date_0207.png" alt="2월 7일" />
				<a href="/event/eventmain.asp?eventid=75968" target="_top">이벤트 바로가기</a>
			</li>

			<% if currentdate < "2017-02-08" then %>
				<li class="swiper-slide">
			<% Else %>
				<li class="swiper-slide soldout open <%=CHKIIF(vEventID="75967"," current","")%>">
			<% End If %>
				<img src="http://webimage.10x10.co.kr/eventIMG/2017/75710/txt_date_0208.png" alt="2월 8일" />
				<a href="/event/eventmain.asp?eventid=75967" target="_top">이벤트 바로가기</a>
			</li>

			<% if currentdate < "2017-02-09" then %>
				<li class="swiper-slide">
			<% Else %>
				<li class="swiper-slide open <%=CHKIIF(vEventID="75988"," current","")%>">
			<% End If %>
				<img src="http://webimage.10x10.co.kr/eventIMG/2017/75710/txt_date_0209.png" alt="2월 9일" />
				<a href="/event/eventmain.asp?eventid=75988" target="_top">이벤트 바로가기</a>
			</li>

			<% if currentdate < "2017-02-10" then %>
				<li class="swiper-slide">
			<% Else %>
				<li class="swiper-slide open <%=CHKIIF(vEventID="75989"," current","")%>">
			<% End If %>
				<img src="http://webimage.10x10.co.kr/eventIMG/2017/75710/txt_date_0210.png" alt="2월 10일" />
				<a href="/event/eventmain.asp?eventid=75989" target="_top">이벤트 바로가기</a>
			</li>
		</ul>
	</div>
	<button class="btnPrev">이전</button>
	<button class="btnNext">다음</button>
</div>

</body>
</html>