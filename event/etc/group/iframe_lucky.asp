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
	If vEventID = "78064" Then '// 2017-05-22
		vStartNo = "0"
	ElseIf vEventID = "78073" Then '// 2017-05-23
		vStartNo = "0"
	ElseIf vEventID = "78128" Then '// 2017-05-24
		vStartNo = "0"
	ElseIf vEventID = "78070" Then '// 2017-05-25
		vStartNo = "0"
	ElseIf vEventID = "78069" Then '// 2017-05-26
		vStartNo = "1"
	ElseIf vEventID = "78072" Then '// 2017-05-27,28
		vStartNo = "2"
	ElseIf vEventID = "78074" Then '// 2017-05-29
		vStartNo = "2"
	ElseIf vEventID = "78265" Then '// 2017-05-30
		vStartNo = "2"
	ElseIf vEventID = "78129" Then '// 2017-05-31
		vStartNo = "2"
	else
		vStartNo = "0"
	End IF
%>
<style type="text/css">
.luckyDay {position:relative; width:1140px; height:110px; padding:30px 0 40px; background:#dafad9;}
.luckyDay .swiper-container {width:910px; height:125px; margin:0 auto; }
.luckyDay li {position:relative; overflow:hidden; float:left; height:110px; text-align:center;}
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
			<% if currentdate < "2017-05-22" then %>
			<li class="swiper-slide">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="78064"," current","")%>">
			<% End If %>
				<img src="http://webimage.10x10.co.kr/eventIMG/2017/78064/txt_date_0522.png" alt="5월 22일" />
				<a href="/event/eventmain.asp?eventid=78064" target="_top">이벤트 바로가기</a>
			</li>

			<% if currentdate < "2017-05-23" then %>
			<li class="swiper-slide">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="78073"," current","")%>">
			<% End If %>
				<img src="http://webimage.10x10.co.kr/eventIMG/2017/78064/txt_date_0523.png" alt="5월 23일" />
				<a href="/event/eventmain.asp?eventid=78073" target="_top">이벤트 바로가기</a>
			</li>

			<% if currentdate < "2017-05-24" then %>
			<li class="swiper-slide">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="78128"," current","")%>">
			<% End If %>
				<img src="http://webimage.10x10.co.kr/eventIMG/2017/78064/txt_date_0524.png" alt="5월 24일" />
				<a href="/event/eventmain.asp?eventid=78128" target="_top">이벤트 바로가기</a>
			</li>

			<% if currentdate < "2017-05-25" then %>
			<li class="swiper-slide">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="78070"," current","")%>">
			<% End If %>
				<img src="http://webimage.10x10.co.kr/eventIMG/2017/78064/txt_date_0525.png" alt="5월 25일" />
				<a href="/event/eventmain.asp?eventid=78070" target="_top">이벤트 바로가기</a>
			</li>

			<% if currentdate < "2017-05-26" then %>
			<li class="swiper-slide">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="78069"," current","")%>">
			<% End If %>
				<img src="http://webimage.10x10.co.kr/eventIMG/2017/78064/txt_date_0526.png" alt="5월 26일" />
				<a href="/event/eventmain.asp?eventid=78069" target="_top">이벤트 바로가기</a>
			</li>

			<% if currentdate < "2017-05-27" then %>
			<li class="swiper-slide">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="78072"," current","")%>">
			<% End If %>
				<img src="http://webimage.10x10.co.kr/eventIMG/2017/78064/txt_date_0527.png" alt="5월 27일~28일" />
				<a href="/event/eventmain.asp?eventid=78072" target="_top">이벤트 바로가기</a>
			</li>

			<% if currentdate < "2017-05-29" then %>
			<li class="swiper-slide">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="78074"," current","")%>">
			<% End If %>
				<img src="http://webimage.10x10.co.kr/eventIMG/2017/78064/txt_date_0529.png" alt="5월 29일" />
				<a href="/event/eventmain.asp?eventid=78074" target="_top">이벤트 바로가기</a>
			</li>

			<% if currentdate < "2017-05-30" then %>
			<li class="swiper-slide">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="78265"," current","")%>">
			<% End If %>
				<img src="http://webimage.10x10.co.kr/eventIMG/2017/78064/txt_date_0530.png" alt="5월 30일" />
				<a href="/event/eventmain.asp?eventid=78265" target="_top">이벤트 바로가기</a>
			</li>

			<% if currentdate < "2017-05-31" then %>
			<li class="swiper-slide">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="78129"," current","")%>">
			<% End If %>
				<img src="http://webimage.10x10.co.kr/eventIMG/2017/78064/txt_date_0531.png" alt="5월 31일" />
				<a href="/event/eventmain.asp?eventid=78129" target="_top">이벤트 바로가기</a>
			</li>
		</ul>
	</div>
	<button class="btnPrev">이전</button>
	<button class="btnNext">다음</button>
</div>
</body>
</html>