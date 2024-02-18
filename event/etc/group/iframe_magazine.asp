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
	If vEventID = "114969" Then '// 1월
		vStartNo = "0"
	ElseIf vEventID = "115372" Then '// 2월
		vStartNo = "1"
	ElseIf vEventID = "115996" Then '// 3월
		vStartNo = "2"
	ElseIf vEventID = "116531" Then '// 4월
		vStartNo = "3"
	ElseIf vEventID = "117003" Then '// 5월
		vStartNo = "4"
	ElseIf vEventID = "117537" Then '// 6월
		vStartNo = "5"
	ElseIf vEventID = "119100" Then '//7월
		vStartNo = "6"
	ElseIf vEventID = "" Then '// 8월
		vStartNo = "7"
	else
		vStartNo = "0"
	End IF
%>
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css"/>
<style type="text/css">
.navigator {position:relative;  width:1920px; margin:0 auto;background:#71cc38;padding:125px 0;}

.navigator h2{margin-left:434px;margin-bottom:35px;}
.navigator .swiper-container {width:100%;padding-bottom:50px;margin-left:434px;}
.navigator .swiper-wrapper {display:flex;}
.navigator .swiper-slide {width:250px !important; height:100%;display:flex; justify-content:center; align-items:center;margin-right:20px; flex-direction:column;}
.navigator .swiper-slide:first-child{margin-left:0;}
.navigator .swiper-slide .thumbnail{display:block;width:250px;height:250px;background:#FDD56F;margin-bottom:15px;}
.navigator .swiper-slide .thumbnail img{width:100%;}
.navigator .swiper-slide span,
.navigator .swiper-slide a {width:250px; height:100%; text-align:center; color:#fff; text-decoration:none;}
.navigator .swiper-slide span {font-size:18px; line-height:20px;}
.navigator .swiper-slide em{display:block;margin-top:5px;}
.navigator .swiper-slide.current a {position:relative; color:#222; font-weight:700;}
.navigator .swiper-slide.current a span{width:fit-content;color:#222;}
.navigator .swiper-button{display:none;position:absolute; top:0; z-index:100; width:40px; height:100%; background:#fff url(//webimage.10x10.co.kr/eventIMG/2020/101636/btn_nav.png) 50% 50% no-repeat; font-size:0;}
.navigator .swiper-button-prev {left:0;}
.navigator .swiper-button-next {right:0; transform:scaleX(-1);}
.navigator .swiper-pagination{top:calc(100% - 5px);height:5px; width:100%; background-color:#F0F0F0;}
.navigator .swiper-pagination .swiper-pagination-progressbar-fill{background: #222;}

</style>
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<script type="text/javascript">
$(function(){
	var evtSwiper = new Swiper('.navigator .swiper-container',{
		initialSlide:<%=vStartNo%>,
		slidesPerView:5.5,
		speed:300,
		pagination: {
          el: ".swiper-pagination",
          type: "progressbar",
        },
		navigation: {
          nextEl: ".swiper-button-next",
          prevEl: ".swiper-button-prev",
        },
	});

	$('.navigator .btn-prev').on('click', function(e){
		e.preventDefault();
		evtSwiper.swipePrev();
	})
	$('.navigator .btn-next').on('click', function(e){
		e.preventDefault();
		evtSwiper.swipeNext();
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
	<h2><img src="//webimage.10x10.co.kr/fixevent/event/2022/magazine/title.png" alt="magazine"></h2>
	<div class="swiper-container">
		<ul class="swiper-wrapper">
			<%' 오픈된 이벤트 open, 오늘 날짜에 current 클래스 넣어주세요 %>
			<% if currentdate < "2021-11-15" then %>
			<li class="swiper-slide coming"><p class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/magazine/season01.png" alt=""></p><span>VOL.1<em>그 도시의 밤</em></span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="114969"," current","")%>">
				<a href="/event/eventmain.asp?eventid=114969 target="_top"><p class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/magazine/season01.png" alt=""></p><span>VOL.1<em>그 도시의 밤</em></span></a>
			<% End If %>
			</li>

			<% if currentdate < "2021-12-15" then %>
			<li class="swiper-slide coming"><p class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/magazine/season02.png" alt=""></p><span>VOL.2<em>매듭의 계절</em></span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="115372"," current","")%>">
				<a href="/event/eventmain.asp?eventid=115372" target="_top"><p class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/magazine/season02.png" alt=""></p><span>VOL.2<em>매듭의 계절</em></span></a>
			<% End If %>
			</li>

			<% if currentdate < "2022-01-04" then %>
			<li class="swiper-slide coming "><p class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/magazine/season03.png" alt=""></p><span>VOL.3<em>추억 사진관</em></span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="115996"," current","")%>">
				<a href="/event/eventmain.asp?eventid=115996" target="_top"><p class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/magazine/season03.png" alt=""></p><span>VOL.3<em>추억 사진관</em></span></a>
			<% End If %>
			</li>
			
            <% if currentdate < "2022-02-15" then %>
			<li class="swiper-slide coming"><p class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/magazine/season04.png" alt=""></p><span>VOL.4<em>보통의 날</em></span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="116531"," current","")%>">
				<a href="/event/eventmain.asp?eventid=116531" target="_top"><p class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/magazine/season04.png" alt=""></p><span>VOL.4<em>보통의 날</em></span></a>
			<% End If %>
			</li>

			<% if currentdate < "2022-03-15" then %>
			<li class="swiper-slide coming"><p class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/magazine/season05.png" alt=""></p><span>VOL.5<em>청춘</em></span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="117003"," current","")%>">
				<a href="/event/eventmain.asp?eventid=117003" target="_top"><p class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/magazine/season05.png" alt=""></p><span>VOL.5<em>청춘</em></span></a>
			<% End If %>
			</li>

			<% if currentdate < "2022-04-12" then %>
			<li class="swiper-slide coming"><p class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/magazine/season06.png" alt=""></p><span>특별호<em>봄과 여름 사이</em></span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="117537"," current","")%>">
				<a href="/event/eventmain.asp?eventid=117537" target="_top"><p class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/magazine/season06.png" alt=""></p><span>특별호<em>봄과 여름 사이</em></span></a>
			<% End If %>
			</li>

			<% if currentdate < "2022-07-06" then %>
			<li class="swiper-slide coming"><p class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/magazine/season07.png" alt=""></p><span>VOL.7<em>여름의 기록</em></span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="119100"," current","")%>">
				<a href="/event/eventmain.asp?eventid=119100" target="_top"><p class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/magazine/season07.png" alt=""></p><span>VOL.7<em>여름의 기록</em></span></a>
			<% End If %>
			</li>

			<% if currentdate < "2022-09-30" then %>
			<li class="swiper-slide coming"><p class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/magazine/coming.png" alt=""></p><span>VOL.8<em>Coming Soon</em></span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="000000"," current","")%>">
				<a href="/event/eventmain.asp?eventid=000000" target="_top"><p class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/magazine/coming.png" alt=""></p><span>VOL.8<em>Coming Soon</em></span></a>
			<% End If %>
			</li>
		</ul>
		<div class="swiper-button swiper-button-next"></div>
      	<div class="swiper-button swiper-button-prev"></div>
     	<div class="swiper-pagination"></div>
	</div>
</div>
</body>
</html>