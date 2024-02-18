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
	If vEventID = "93203" Then '// 2019-03-12
		vStartNo = "0"
	ElseIf vEventID = "93528" Then '// 2019-03-27
		vStartNo = "0"
	ElseIf vEventID = "93789" Then '// 2019-04-10
		vStartNo = "0"
	ElseIf vEventID = "94554" Then '// 2019-05-21
		vStartNo = "0"
    ElseIf vEventID = "95259" Then '// 2019-06-19
        vStartNo = "1"
    ElseIf vEventID = "103012" Then '// 2020-05-28
        vStartNo = "2"
	else
		vStartNo = "0"
	End IF
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
.lucky-day {position:relative; width:1140px; height:224px; background:#fff;}
.lucky-day .swiper-container {width:900px; height:224px; margin:0 auto; }
.lucky-day li {position:relative; overflow:hidden; float:left; text-align:center; cursor:pointer;}
.lucky-day li a {display:block; position:absolute; left:0; top:0; width:100%; height:224px; text-indent:-999em;}
.lucky-day li.current img {margin-top:-276px;}
.lucky-day li.coming img {margin-top:0;}
.lucky-day button {display:block; position:absolute; top:0; width:120px; height:224px; outline: none}
.lucky-day .btnPrev {left:0;}
.lucky-day .btnNext {right:0;}
</style>
<script type="text/javascript">
$(function(){
	// iframe
	var evtSwiper = new Swiper('.lucky-day .swiper-container',{
		initialSlide:<%=vStartNo%>,
		slidesPerView:5,
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

			<% if currentdate < "2019-03-12" then %>
				<li class="swiper-slide coming">
			<% Else %>
				<li class="swiper-slide <%=CHKIIF(vEventID="93203"," current","")%>">
			<% End If %>
				<img src="//webimage.10x10.co.kr/fixevent/event/2019/93528/btn_navi_01.jpg" alt="1 펜슬">
				<a href="/event/eventmain.asp?eventid=93203" target="_top">이벤트 바로가기</a>
			</li>

			<% if currentdate < "2019-03-27" then %>
				<li class="swiper-slide coming">
			<% Else %>
				<li class="swiper-slide <%=CHKIIF(vEventID="93528"," current","")%>">
			<% End If %>
				<img src="//webimage.10x10.co.kr/fixevent/event/2019/93528/btn_navi_02.jpg" alt="2 아보카도">
				<a href="/event/eventmain.asp?eventid=93528" target="_top">이벤트 바로가기</a>
			</li>

			<% if currentdate < "2019-04-10" then %>
				<li class="swiper-slide coming">
			<% Else %>
				<li class="swiper-slide <%=CHKIIF(vEventID="93789"," current","")%>">
			<% End If %>
			<img src="//webimage.10x10.co.kr/fixevent/event/2019/93789/btn_navi_03.jpg?v=1.0" alt="3 반려동물">
				<a href="/event/eventmain.asp?eventid=93789" target="_top">이벤트 바로가기</a>
			</li>

			<% if currentdate < "2019-05-21" then %>
				<li class="swiper-slide coming">
				<img src="//webimage.10x10.co.kr/fixevent/event/2019/93528/btn_navi_04.jpg?v=1.01" alt="오픈예정">
			<% Else %>
				<li class="swiper-slide <%=CHKIIF(vEventID="94554"," current","")%>">
			<% End If %>
            <img src="//webimage.10x10.co.kr/fixevent/event/2019/94554/btn_navi_04.jpg?v=1.01" alt="4 magazine B BLUE BOTTLE COFFEE">
				<a href="/event/eventmain.asp?eventid=94554" target="_top">이벤트 바로가기</a>
			</li>

			<% if currentdate < "2019-06-19" then %>
				<li class="swiper-slide coming">
            	<img src="//webimage.10x10.co.kr/fixevent/event/2019/93528/btn_navi_05.jpg?v=1.01" alt="오픈예정">
			<% Else %>
				<li class="swiper-slide <%=CHKIIF(vEventID="95259"," current","")%>">
			<% End If %>
            <img src="//webimage.10x10.co.kr/fixevent/event/2019/95259/btn_navi_05.jpg?v=1.01" alt="5">
				<a href="/event/eventmain.asp?eventid=95259" target="_top">이벤트 바로가기</a>
			</li>

			<% if currentdate < "2020-05-28" then %>
			<li class="swiper-slide coming">
				<img src="//webimage.10x10.co.kr/fixevent/event/2019/95259/btn_navi_06.jpg" alt="오픈예정">
			<% Else %>
				<li class="swiper-slide <%=CHKIIF(vEventID="103012"," current","")%>">
			<% End If %>
				<img src="//webimage.10x10.co.kr/fixevent/event/2020/103012/btn_navi_06.jpg" alt="6">
				<a href="/event/eventmain.asp?eventid=103012" target="_top">이벤트 바로가기</a>
			</li>

			<% if currentdate < "2021-05-28" then %>
			<li class="swiper-slide coming">
				<img src="//webimage.10x10.co.kr/fixevent/event/2020/103012/btn_navi_07.jpg" alt="오픈예정">
			<% Else %>
				<li class="swiper-slide <%=CHKIIF(vEventID="000000"," current","")%>">
			<% End If %>
				<img src="//webimage.10x10.co.kr/fixevent/event/2020/000000/btn_navi_06.jpg" alt="6">
				<a href="/event/eventmain.asp?eventid=000000" target="_top">이벤트 바로가기</a>
			</li>

		</ul>
	</div>
	<button class="btnPrev"><img src="//webimage.10x10.co.kr/fixevent/event/2019/93528/btn_navi_prev.jpg" alt=""></button>
	<button class="btnNext"><img src="//webimage.10x10.co.kr/fixevent/event/2019/93528/btn_navi_next.jpg" alt=""></button>
</div>

</body>
</html>