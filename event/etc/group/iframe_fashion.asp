<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/inc/head.asp" -->
<%
dim currentdate
	currentdate = date()
	'currentdate = "2019-12-02"
	'response.write currentdate

	Dim vEventID, vStartNo
	vEventID = requestCheckVar(Request("eventid"),9)
	If vEventID = "117496" Then '// 4월4일
		vStartNo = "0"
	ElseIf vEventID = "118108" Then '// 4월25일
		vStartNo = "0"
	ElseIf vEventID = "118878" Then '// 5월
		vStartNo = "0"
	ElseIf vEventID = "" Then '// 6월
		vStartNo = "1"
	ElseIf vEventID = "" Then '// 7월
		vStartNo = "2"
	ElseIf vEventID = "" Then '// 8월
		vStartNo = "3"
	else
		vStartNo = "4"
	End IF
%>
<style type="text/css">
.navigator {position:relative; overflow:hidden; width:1140px; margin:0 auto; height:425px;}
/* seriesTab */
.navigator li{list-style:none;}
.navigator .tab_title{position:absolute; width:170px; top:100px; left:50%; margin-left:-490px;}
.navigator .swiper-container{width:700px; height:250px; left:50%; margin-left:-215px; top:85px;padding-left:35px}
.navigator .swiper-wrapper{display:flex;}
.navigator .swiper-slide{cursor:pointer;margin:0 16px;}
.navigator .swiper-slide.coming{cursor:initial;}
.navigator .swiper-slide img{width:197px;}
.navigator .swiper-slide .img{position:relative;}
.navigator .swiper-slide.current .img::after{width:197px; height:250px; box-sizing:border-box; position:absolute; content:''; border:5px solid #3d52b5; border-radius:15px; left:0; top:0;}
.navigator .swiper-button-prev{width:13px; padding:0 5px; height:100%; background:url(//webimage.10x10.co.kr/fixevent/event/2022/118878/arrow.png) #000 no-repeat center; background-size:13px; position:absolute; top:50%; left:0px; transform:rotate(180deg) translateY(50%); cursor:pointer;}
.navigator .swiper-button-prev::before{display:none;}
.navigator .swiper-button-next{width:13px; padding:0 5px; height:100%; background:url(//webimage.10x10.co.kr/fixevent/event/2022/118878/arrow.png) #000 no-repeat center; background-size:13px; position:absolute; top:50%; right:0px; transform:translateY(-50%); cursor:pointer;}
.navigator .swiper-button-next::after{display:none;}
</style>
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<script type="text/javascript">
$(function(){
	var seriesSwiper = new Swiper('.navigator .swiper-container',{
		initialSlide:<%=vStartNo%>,
		slidesPerView:3,
		loop:true,
		navigation: {
          nextEl: ".swiper-button-next",
          prevEl: ".swiper-button-prev",
        },
	});

	$('.navigator .coming').on('click', function(e){
		e.preventDefault();
		alert("오픈 예정 기획전 입니다 :)");
	});
});
</script>
</head>
<body>
<div id="navigator" class="navigator">
	<li class="tab_title"><img src="//webimage.10x10.co.kr/fixevent/event/2022/117496/tab_title.png" alt=""></li>
	<div class="swiper-container">
		<ul class="swiper-wrapper">
			<%' 오픈된 이벤트 open, 오늘 날짜에 current 클래스 넣어주세요 %>
			<% if currentdate < "2022-04-04" then %>
			<li class="swiper-slide coming"><p class="img"><img src="//webimage.10x10.co.kr/fixevent/event/2022/117496/magazine01.png" alt=""></p>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="117496"," current","")%>">
				<a href="/event/eventmain.asp?eventid=117496" target="_top"><p class="img"><img src="//webimage.10x10.co.kr/fixevent/event/2022/117496/magazine01.png" alt=""></p></a>
			<% End If %>
			</li>

			<% if currentdate < "2022-04-25" then %>
			<li class="swiper-slide coming"><p class="img"><img src="//webimage.10x10.co.kr/fixevent/event/2022/117496/magazine02_g.png" alt=""></p>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="118108"," current","")%>">
				<a href="/event/eventmain.asp?eventid=118108" target="_top"><p class="img"><img src="//webimage.10x10.co.kr/fixevent/event/2022/118108/magazine02.png" alt=""></p></a>
			<% End If %>
			</li>

			<% if currentdate < "2022-06-22" then %>
			<li class="swiper-slide coming "><p class="img"><img src="//webimage.10x10.co.kr/fixevent/event/2022/118108/magazine03_g.png" alt=""></p>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="118878"," current","")%>">
				<a href="/event/eventmain.asp?eventid=118878" target="_top"><p class="img"><img src="//webimage.10x10.co.kr/fixevent/event/2022/118878/magazine03.png" alt=""></p></a>
			<% End If %>
			</li>

			<% if currentdate < "2022-07-16" then %>
			<li class="swiper-slide coming "><p class="img"><img src="//webimage.10x10.co.kr/fixevent/event/2022/118878/magazine04_g.png" alt=""></p>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID=""," current","")%>">
				<a href="/event/eventmain.asp?eventid=" target="_top"><p class="img"><img src="//webimage.10x10.co.kr/fixevent/event/2022/118108/magazine03_g.png" alt=""></p></a>
			<% End If %>
			</li>
			
		</ul>
		<div class="swiper-button swiper-button-prev"></div>
		<div class="swiper-button swiper-button-next"></div>
	</div>
</div>
</body>
</html>