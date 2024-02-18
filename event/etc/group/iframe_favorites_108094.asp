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
	If vEventID = "109208" Then '// vol.1 오프투얼론
		vStartNo = "0"
	ElseIf vEventID = "108094" Then '// vol.2 서촌도감
		vStartNo = "0"
	ElseIf vEventID = "108730" Then '// vol.3 미술관옆작업실
		vStartNo = "0"
	ElseIf vEventID = "109897" Then '// vol.4 핀란드프로젝트
		vStartNo = "1"
	ElseIf vEventID = "110643" Then '// vol.5 커피한잔
		vStartNo = "2"
	ElseIf vEventID = "" Then '// vol.6 마지막 브랜드
		vStartNo = "3"
	else
		vStartNo = "0"
	End IF
%>
<style>
body {background:#fff;}
.navi-wraps {display:flex; align-items: center; justify-content: space-between; width:1140px; margin:0 auto; background:#fff;}
.monthTab {position:relative; width:300px; height:120px; padding:0 25px; overflow:hidden; border-bottom:1px solid #ccc;}
.monthTab .swiper-container {width:300px; overflow:hidden; margin:auto;}
.monthTab .swiper-container:before {content:''; position:absolute; top:0; left:0; height:100%; width:0.2rem; background-color:#fff; z-index:97;}
.monthTab .swiper-container:after {content:''; position:absolute; top:0; right:0; height:100%; width:0.2rem; background-color:#fff; z-index:97;}
.monthTab ul {display:flex; align-items:center; height:120px !important; margin:0 auto; z-index:96;}
.monthTab ul li {width:auto; height:120px !important; line-height:120px; text-align:center;}
.monthTab ul li span {display:inline-block; width:100%; text-align:center; font-weight:500; font-family:'Roboto', 'Noto Sans KR', 'malgun Gothic', '맑은고딕', sans-serif; color:#888; font-size:18px; text-decoration:none;}
.monthTab ul li span.txt {display:inline-block; width:64px; height:32px; margin:0 10px; vertical-align:middle; background:url(//webimage.10x10.co.kr/fixevent/event/2020/108094/txt_soon.png) no-repeat 0 0; background-size: 100%;}
.monthTab ul li a {display:block; width:auto; height:120px; text-align:center; font-weight:500; font-family:'Roboto', 'Noto Sans KR', 'malgun Gothic', '맑은고딕', sans-serif; color:#888; font-size:18px; text-decoration:none;}
.monthTab ul li.swiper-slide.current a {color:#191919; font-weight:700;}

.monthTab button {position:absolute; top:0; z-index:10; width:25px; height:100%; outline:none;}
.monthTab .btnPrev {left:0; background: #fff url(//webimage.10x10.co.kr/fixevent/event/2020/108094/m/icon_left.png) no-repeat 0 50%; background-size: 6px 13px;}
.monthTab .btnNext {right:0; background: #fff url(//webimage.10x10.co.kr/fixevent/event/2020/108094/m/icon_right.png) no-repeat right 50%; background-size: 6px 13px;}
</style>
<script type="text/javascript">
$(function(){
	var evtSwiper = new Swiper('.monthTab .swiper-container',{
		initialSlide:1,
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
<div class="navi-wraps">
<div><img src="//webimage.10x10.co.kr/fixevent/event/2020/108094/txt_nav_tit.png?v=2" alt="텐바이텐X서촌도감 즐겨찾길"></div>
<div class="monthTab">
	<div class="swiper-container">
		<ul class="swiper-wrapper">
			<%' 오픈된 이벤트 open, 오늘 날짜에 current 클래스 넣어주세요 %>
			<% if currentdate < "2021-02-15" then %>
			<li class="swiper-slide coming">
                <span>Vol.1</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="109208"," current","")%>">
				<a href="/event/eventmain.asp?eventid=109208" target="_top">Vol.1</a>
            <% End If %>
			</li>

			<% if currentdate < "2021-02-24" then %>
			<li class="swiper-slide coming">
                <span class="txt"></span>
			<% Else %>
            <li class="swiper-slide open current <%=CHKIIF(vEventID="108094"," current","")%>">
				<a href="/event/eventmain.asp?eventid=108094" target="_top">Vol.2</a>
			<% End If %>
			</li>

			<% if currentdate < "2021-03-05" then %>
			<li class="swiper-slide coming">
                <span class="txt"></span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="108730"," current","")%>">
				<a href="/event/eventmain.asp?eventid=108730" target="_top">Vol.3</a>
			<% End If %>
			</li>

			<% if currentdate < "2021-04-02" then %>
			<li class="swiper-slide coming">
                <span class="txt"></span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="109897"," current","")%>">
				<a href="/event/eventmain.asp?eventid=109897" target="_top">Vol.4</a>
			<% End If %>
			</li>

			<% if currentdate < "2021-04-23" then %>
			<li class="swiper-slide coming">
                <span class="txt"></span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="110643"," current","")%>">
				<a href="/event/eventmain.asp?eventid=110643" target="_top">Vol.5</a>
			<% End If %>
			</li>

            <% if currentdate < "2021-05-02" then %>
			<li class="swiper-slide coming">
                <span class="txt"></span>
			<% Else %>
            <li class="swiper-slide open <%=CHKIIF(vEventID=""," current","")%>">
				<a href="/event/eventmain.asp?eventid=" target="_top">Vol.6</a>
			<% End If %>
			</li>
		</ul>
	</div>
	<button class="btnPrev"></button>
	<button class="btnNext"></button>
</div>
</div>
</body>
</html>