<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/inc/head.asp" -->
<%
dim currentdate
	currentdate = date()
	'currentdate = "2018-11-28"
	'response.write currentdate

	Dim vEventID, vStartNo
	vEventID = requestCheckVar(Request("eventid"),9)
	If vEventID = "114127" Then '// 12월
		vStartNo = "0"
	ElseIf vEventID = "000000" Then '// 1월
		vStartNo = "0"
	else
		vStartNo = "0"
	End IF
%>
<style type="text/css">
.monthTab {position:relative; width:1920px; height:100px; overflow:hidden;}
.monthTab .swiper-container {width:1140px; overflow:hidden; margin:auto;}
.monthTab .swiper-container:before {content:''; position:absolute; top:0; left:0; height:100%; width:0.2rem; background-color:#fff; z-index:97;}
.monthTab .swiper-container:after {content:''; position:absolute; top:0; right:0; height:100%; width:0.2rem; background-color:#fff; z-index:97;}
.monthTab ul {margin:0 auto; z-index:96;}
.monthTab ul li {float:left;}
.monthTab ul li a {display:block;line-height:100px; height:100px; text-align:center; font-weight:500; font-family:'Roboto', 'Noto Sans KR', 'malgun Gothic', '맑은고딕', sans-serif; color:#b0b0b0; font-size:23px; text-decoration:none;}
.monthTab ul li.current a {color:#333; font-weight:bold;font-size:30px;width:822px;}
.monthTab button {position:absolute; top:0; z-index:10; padding-right:1px; outline:none; background-color:#fff;}
.monthTab button img {vertical-align:top;}
.monthTab .btnPrev {left:0;}
.monthTab .btnNext {right:0;}
</style>
<script type="text/javascript">
$(function(){
	var evtSwiper = new Swiper('.monthTab .swiper-container',{
		initialSlide:<%=vStartNo%>,
		slidesPerView:3,
		speed:300
	})
	$('.monthTab .btnPrev').on('click', function(e){
		e.preventDefault();
		evtSwiper.swipePrev();
	})
	$('.monthTab .btnNext').on('click', function(e){
		e.preventDefault();
		evtSwiper.swipeNext();
	});
	$('.monthTab .coming').on('click', function(e){
		e.preventDefault();
		alert("오픈 예정 기획전 입니다.");
	});
});
</script>
</head>
<body>
<div class="monthTab">
	<div class="swiper-container">
		<ul class="swiper-wrapper">
			<%' 오픈된 이벤트 open, 오늘 날짜에 current 클래스 넣어주세요 %>
			<% if currentdate < "2021-09-28" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="114127"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=114127" target="_top">스폰지밥</a>
			</li>

			<% if currentdate < "2021-10-31" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="000000"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=000000" target="_top">what's next?</a>
			</li>
		</ul>
	</div>
</div>
</body>
</html>