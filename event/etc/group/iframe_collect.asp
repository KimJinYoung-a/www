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
	If vEventID = "118023" Then '// 3월
		vStartNo = "0"
	ElseIf vEventID = "118287" Then '// 4월
		vStartNo = "1"
	ElseIf vEventID = "118415" Then '// 5월
		vStartNo = "2"
	ElseIf vEventID = "118511" Then '// 6월
		vStartNo = "3"
	ElseIf vEventID = "118578" Then '// 7월
		vStartNo = "4"
	ElseIf vEventID = "119171" Then '// 8월
		vStartNo = "5"
	ElseIf vEventID = "119667" Then '// 8월
		vStartNo = "6"
	ElseIf vEventID = "" Then '// 10월
		vStartNo = "7"
	else
		vStartNo = "0"
	End IF
%>
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css"/>
<style type="text/css">
@font-face {
     font-family: 'DungGeunMo';
     src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_six@1.2/DungGeunMo.woff') format('woff');
     font-weight: normal;
     font-style: normal;
}
.navigator {position:relative;  width:960px; margin:0 auto;background:#8f4cff;padding:0 90px;overflow:hidden;}
.navigator .back{background:#6bff53;overflow:hidden;display:flex;align-items:center;padding:23px 0;justify-content:space-between;}

.navigator.ver02{background:#ff6efb;}
.navigator.ver03{background:#0bcf1d;}
.navigator.ver04{background:#0054ff;}
.navigator.ver05{background:#ff7200;}
.navigator.ver06{background:#f82b2b;}
.navigator.ver07{background:#00b6ff;}

.navigator.ver02 .back{background:#38efff;}
.navigator.ver03 .back{background:#f3ff38;}
.navigator.ver04 .back{background:#ff80f5;}
.navigator.ver05 .back{background:#bcff3c;}
.navigator.ver06 .back{background:#fff94c;}
.navigator.ver07 .back{background:#5f3cff;}

.navigator h2{float:left;width:40%;font-size:25px;font-family:'DungGeunMo';color:#000;text-align:center;}

.navigator .swiper-container {width:45%;padding:0 6%;margin-right:3%}
.navigator .swiper-wrapper {display:flex;}
.navigator .swiper-slide {width:132px !important; height:132px;margin:0 12px;}
.navigator .swiper-slide:first-child{margin-left:0;}
.navigator .swiper-slide .thumbnail{display:block;width:132px;height:132px;}
.navigator .swiper-slide .thumbnail img{width:100%;}
.navigator .swiper-slide span,
.navigator .swiper-slide a {width:132px; height:100%;color:#999; text-decoration:none;font-family:'DungGeunMo';position:relative;}
/* .navigator .swiper-slide.next:hover span{color:#000;} */
.navigator .swiper-slide span {font-size:22px; line-height:20px;position:relative;bottom:39px;left:50%;margin-left:-25%;text-align:center;letter-spacing:-0.05em;}
.navigator .swiper-slide em{display:block;margin-top:5px;}
.navigator .swiper-slide.current a {position:relative; color:#000; font-weight:500;font-family:'DungGeunMo';}
.navigator .swiper-slide.current a span{width:fit-content;color:#000;font-family:'DungGeunMo';padding-bottom:1px;border-bottom:2px solid #000;}

.navigator .swiper-button{position:absolute; top:23px; z-index:100; width:30px; height:132px; background:#6bff53 url(//webimage.10x10.co.kr/fixevent/event/2022/collect/arrow.png) 50% 50% no-repeat; font-size:0;}
.navigator.ver02 .swiper-button{position:absolute; top:23px; z-index:100; width:30px; height:132px; background:#38efff url(//webimage.10x10.co.kr/fixevent/event/2022/collect/arrow.png) 50% 50% no-repeat; font-size:0;}
.navigator.ver03 .swiper-button{position:absolute; top:23px; z-index:100; width:30px; height:132px; background:#f3ff38 url(//webimage.10x10.co.kr/fixevent/event/2022/collect/arrow.png) 50% 50% no-repeat; font-size:0;}
.navigator.ver04 .swiper-button{position:absolute; top:23px; z-index:100; width:30px; height:132px; background:#ff80f5 url(//webimage.10x10.co.kr/fixevent/event/2022/collect/arrow.png) 50% 50% no-repeat; font-size:0;}
.navigator.ver05 .swiper-button{position:absolute; top:23px; z-index:100; width:30px; height:132px; background:#bcff3c url(//webimage.10x10.co.kr/fixevent/event/2022/collect/arrow.png) 50% 50% no-repeat; font-size:0;}
.navigator.ver06 .swiper-button{position:absolute; top:23px; z-index:100; width:30px; height:132px; background:#fff94c url(//webimage.10x10.co.kr/fixevent/event/2022/collect/arrow.png) 50% 50% no-repeat; font-size:0;}
.navigator.ver07 .swiper-button{position:absolute; top:23px; z-index:100; width:30px; height:132px; background:#5f3cff url(//webimage.10x10.co.kr/fixevent/event/2022/collect/arrow.png) 50% 50% no-repeat; font-size:0;}

.navigator .swiper-button-prev {left:0;}
.navigator .swiper-button-next {right:0; transform:rotate(180deg);}
.swiper-button-prev:after, .swiper-rtl .swiper-button-next:after{content:none;}
.swiper-button-next:after, .swiper-rtl .swiper-button-prev:after{content:none;}
.swiper-button-next.swiper-button-disabled, .swiper-button-prev.swiper-button-disabled{opacity:1;}

</style>
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<script type="text/javascript">
$(function(){
	var evtSwiper = new Swiper('.navigator .swiper-container',{
		initialSlide:<%=vStartNo%>,
		slidesPerView:3,
		speed:300,
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

	// $('.swiper-slide.next').mouseenter(function(){
	// 	$(this).children().children('img').attr('src','//webimage.10x10.co.kr/fixevent/event/2022/collect/ver02.png');
	// });
	// $('.swiper-slide.next').mouseleave(function(){
	// 	$(this).children().children('img').attr('src','//webimage.10x10.co.kr/fixevent/event/2022/collect/next.png');
	// });
});
</script>
</head>
<body>
<% if vEventID="119667" then %>
<div id="navigator" class="navigator ver07">
<% Elseif vEventID="119171" then %>
<div id="navigator" class="navigator ver06">
<% Elseif vEventID="118578" then %>
<div id="navigator" class="navigator ver05">
<% ElseIf vEventID="118511" then %>
<div id="navigator" class="navigator ver04">
<% ElseIf vEventID="118415" then %>
<div id="navigator" class="navigator ver03">
<% ElseIf vEventID="118287" then %>
<div id="navigator" class="navigator ver02">
<% Else %>
<div id="navigator" class="navigator">
<% End If %>
	<div class="back">
		<h2>다른 컬렉션 보러가기</h2>
		<div class="swiper-container">
			<ul class="swiper-wrapper">
				<% if currentdate < "2022-04-20" then %>
				<li class="swiper-slide"><p class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/collect/ver01.png" alt=""></p><span>ver.01</span>
				<% Else %>
				<li class="swiper-slide <%=CHKIIF(vEventID="118023"," current","")%>">
					<a href="/event/eventmain.asp?eventid=118023" target="_top"><p class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/collect/ver01.png" alt=""></p><span>ver.01</span></a>
				<% End If %>
				</li>

				<% if currentdate < "2022-04-26" then %>
				<li class="swiper-slide"><p class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/collect/next.png" alt=""></p><span>ver.02</span>
				<% Else %>
				<li class="swiper-slide <%=CHKIIF(vEventID="118287"," current","")%>">
					<a href="/event/eventmain.asp?eventid=118287" target="_top"><p class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/collect/ver02.png" alt=""></p><span>ver.02</span></a>
				<% End If %>
				</li>

				<% if currentdate < "2022-05-10" then %>
				<li class="swiper-slide "><p class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/collect/next.png" alt=""></p><span>ver.03</span>
				<% Else %>
				<li class="swiper-slide <%=CHKIIF(vEventID="118415"," current","")%>">
					<a href="/event/eventmain.asp?eventid=118415" target="_top"><p class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/collect/ver03.png" alt=""></p><span>ver.03</span></a>
				<% End If %>
				</li>
				
				<% if currentdate < "2022-05-16" then %>
				<li class="swiper-slide"><p class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/collect/next.png" alt=""></p><span>ver.04</span>
				<% Else %>
				<li class="swiper-slide <%=CHKIIF(vEventID="118511"," current","")%>">
					<a href="/event/eventmain.asp?eventid=118511" target="_top"><p class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/collect/ver04.png" alt=""></p><span>ver.04</span></a>
				<% End If %>
				</li>

				<% if currentdate < "2022-05-19" then %>
				<li class="swiper-slide"><p class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/collect/next.png" alt=""></p><span>ver.05</span>
				<% Else %>
				<li class="swiper-slide <%=CHKIIF(vEventID="118578"," current","")%>">
					<a href="/event/eventmain.asp?eventid=118578" target="_top"><p class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/collect/ver05.png" alt=""></p><span>ver.05</span></a>
				<% End If %>
				</li>

				<% if currentdate < "2022-06-30" then %>
				<li class="swiper-slide"><p class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/collect/next.png" alt=""></p><span>ver.06</span>
				<% Else %>
				<li class="swiper-slide <%=CHKIIF(vEventID="119171"," current","")%>">
					<a href="/event/eventmain.asp?eventid=119171" target="_top"><p class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/collect/ver06.png" alt=""></p><span>ver.06</span></a>
				<% End If %>
				</li>

				<% if currentdate < "2022-08-09" then %>
				<li class="swiper-slide"><p class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/collect/next.png" alt=""></p><span>ver.07</span>
				<% Else %>
				<li class="swiper-slide <%=CHKIIF(vEventID="119667"," current","")%>">
					<a href="/event/eventmain.asp?eventid=119667" target="_top"><p class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/collect/ver07.png" alt=""></p><span>ver.07</span></a>
				<% End If %>
				</li>

				<% if currentdate < "2023-02-15" then %>
				<li class="swiper-slide"><p class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/collect/coming.png" alt=""></p><span></span>
				<% Else %>
				<li class="swiper-slide <%=CHKIIF(vEventID=""," current","")%>">
					<a href="/event/eventmain.asp?eventid=" target="_top"><p class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/collect/coming.png" alt=""></p><span></span></a>
				<% End If %>
				</li>
			</ul>
			<div class="swiper-button swiper-button-next"></div>
			<div class="swiper-button swiper-button-prev"></div>
			<div class="swiper-pagination"></div>
		</div>
	</div>
</div>
</body>
</html>