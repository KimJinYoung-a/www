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
	If vEventID = "101636" Then '// 4월
		vStartNo = "0"
	ElseIf vEventID = "102755" Then '// 5월
		vStartNo = "0"
	ElseIf vEventID = "103741" Then '// 6월
		vStartNo = "1"
	ElseIf vEventID = "" Then '// 7월
		vStartNo = "2"
	ElseIf vEventID = "" Then '// 8월
		vStartNo = "3"
	else
		vStartNo = "0"
	End IF
%>
<style type="text/css">
.navigator {position:relative; width:1140px; margin:0 auto; padding-top:15px; background:url(//webimage.10x10.co.kr/eventIMG/2020/102755/tit_decoview.png) 30px 30px no-repeat}
.navigator:after {content:' '; display:block; float:none; clear:both;}
.navigator .swiper-container {float:right; width:444px; padding:0 27px;}
.navigator .swiper-wrapper {display:flex;}
.navigator .swiper-slide {width:33.3%; height:43px; font-size:14px; border:3px solid #fff; box-sizing:border-box;}
.navigator .swiper-slide span,
.navigator .swiper-slide a {display:flex; justify-content:center; align-items:center; width:100%; height:100%; color:#777; text-decoration:none;}
.navigator .swiper-slide.current {border-color:#000;}
.navigator .swiper-slide.current a {color:#000; font-weight:600;}
.navigator button {position:absolute; top:0; z-index:100; width:28px; height:100%; background:#fff url(//webimage.10x10.co.kr/eventIMG/2020/101636/btn_nav.png) 50% 50% no-repeat; font-size:0;}
.navigator .btn-prev {left:-1px;}
.navigator .btn-next {right:-1px; transform:rotate(180deg);}
</style>
<script type="text/javascript">
$(function(){
	var evtSwiper = new Swiper('.navigator .swiper-container',{
		initialSlide:<%=vStartNo%>,
		slidesPerView:3,
		speed:300
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
	<div class="swiper-container">
		<ul class="swiper-wrapper">
			<%' 오픈된 이벤트 open, 오늘 날짜에 current 클래스 넣어주세요 %>
			<% if currentdate < "2020-03-27" then %>
			<li class="swiper-slide coming"><span>2020.4</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="101636"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=101636" target="_top">2020.4 봄소리</a>
			</li>

			<% if currentdate < "2020-05-18" then %>
			<li class="swiper-slide coming"><span>2020.5</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="102755"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=102755" target="_top">2020.5 여름준비</a>
			</li>

			<% if currentdate < "2020-06-23" then %>
			<li class="swiper-slide coming"><span>2020.6</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="103741"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=103741" target="_top">2020.6 시원한 창</a>
			</li>

			<% if currentdate < "2022-01-01" then %>
			<!-- <li class="swiper-slide coming"><span>2020.7</span> -->
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="000"," current","")%>">
			<% End If %>
				<!-- <a href="/event/eventmain.asp?eventid=000" target="_top">2020.7</a>
			</li> -->
		</ul>
		<button class="btn-prev">이전</button>
		<button class="btn-next">다음</button>
	</div>
</div>
</body>
</html>