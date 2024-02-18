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
	If vEventID = "112673" Then '// 7월
		vStartNo = "0"
	ElseIf vEventID = "113103" Then '// 8월
		vStartNo = "1"
	ElseIf vEventID = "113647" Then '// 9월
		vStartNo = "2"
	ElseIf vEventID = "113979" Then '// 10월
		vStartNo = "3"
	ElseIf vEventID = "114256" Then '// 11월
		vStartNo = "4"
	ElseIf vEventID = "114849" Then '// 12월
		vStartNo = "5"
	ElseIf vEventID = "" Then '// 1월
		vStartNo = "6"
	ElseIf vEventID = "" Then '// 2월
		vStartNo = "7"
	else
		vStartNo = "6"
	End IF
%>
<style type="text/css">
.wrap-bg { width:100%; height:120px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/113103/bg_newmovie.jpg) no-repeat 50% 0;}
.navigator {position:relative; overflow:hidden; width:1140px; margin:0 auto; padding:40px 0 20px;}
.navigator h2 {float:left; padding-top:22px;}
.navigator .swiper-container {float:right; width:300px; padding:0 40px;}
.navigator .swiper-wrapper {display:flex;}
.navigator .swiper-slide {width:33.3%; height:60px;}
.navigator .swiper-slide span,
.navigator .swiper-slide a {display:flex; justify-content:center; align-items:center; width:100%; height:100%; text-align:center; color:#999999; text-decoration:none;}
.navigator .swiper-slide span {font-size:18px; line-height:20px;}
.navigator .swiper-slide a {font-size:20px;}
.navigator .swiper-slide.current a {position:relative; color:#fff; font-weight:700;}
.navigator button {position:absolute; top:0; z-index:100; width:40px; height:100%; background:#011111 url(///webimage.10x10.co.kr/fixevent/event/2021/113103/btn_nav.png) 50% 50% no-repeat; font-size:0;}
.navigator .btn-prev {left:0;}
.navigator .btn-next {right:0; transform:scaleX(-1);}
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
<div class="wrap-bg">
  <div id="navigator" class="navigator">
    <h2><img src="//webimage.10x10.co.kr/fixevent/event/2021/113103/tit_newmovie.png" alt="life is a movie"></h2>
    <div class="swiper-container">
      <ul class="swiper-wrapper">
        <%' 오픈된 이벤트 open, 오늘 날짜에 current 클래스 넣어주세요 %>
        <% if currentdate < "2021-07-17" then %>
        <li class="swiper-slide coming"><span>July</span>
        <% Else %>
        <li class="swiper-slide open <%=CHKIIF(vEventID="112673"," current","")%>">
          <a href="/event/eventmain.asp?eventid=112673" target="_top">July</a>
        <% End If %>
        </li>
  
        <% if currentdate < "2021-08-16" then %>
        <li class="swiper-slide coming"><span>August</span>
        <% Else %>
        <li class="swiper-slide open <%=CHKIIF(vEventID="113103"," current","")%>">
          <a href="/event/eventmain.asp?eventid=113103" target="_top">August</a>
        <% End If %>
        </li>

        <% if currentdate < "2021-09-13" then %>
        <li class="swiper-slide coming"><span>September</span>
        <% Else %>
        <li class="swiper-slide open <%=CHKIIF(vEventID="113647"," current","")%>">
          <a href="/event/eventmain.asp?eventid=113647" target="_top">September</a>
        <% End If %>
        </li>

		    <% if currentdate < "2021-10-11" then %>
        <li class="swiper-slide coming"><span>October</span>
        <% Else %>
        <li class="swiper-slide open <%=CHKIIF(vEventID="113979"," current","")%>">
          <a href="/event/eventmain.asp?eventid=113979" target="_top">October</a>
        <% End If %>
        </li>

        <% if currentdate < "2021-11-08" then %>
        <li class="swiper-slide coming"><span>November</span>
        <% Else %>
        <li class="swiper-slide open <%=CHKIIF(vEventID="114256"," current","")%>">
          <a href="/event/eventmain.asp?eventid=114256" target="_top">November</a>
        <% End If %>
        </li>

        <% if currentdate < "2021-12-06" then %>
        <li class="swiper-slide coming"><span>December</span>
        <% Else %>
        <li class="swiper-slide open <%=CHKIIF(vEventID="114849"," current","")%>">
          <a href="/event/eventmain.asp?eventid=114849" target="_top">December</a>
        <% End If %>
        </li>
      </ul>
      <button class="btn-prev">이전</button>
      <button class="btn-next">다음</button>
    </div>
  </div>
</div>
</body>
</html>