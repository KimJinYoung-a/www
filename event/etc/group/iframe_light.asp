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
	If vEventID = "114141" Then '// 7월
		vStartNo = "0"
	ElseIf vEventID = "114410" Then '// 8월
		vStartNo = "1"
	ElseIf vEventID = "114913" Then '// 9월
		vStartNo = "2"
	ElseIf vEventID = "115165" Then '// 10월
		vStartNo = "3"
	ElseIf vEventID = "115330" Then '// 11월
		vStartNo = "4"
	ElseIf vEventID = "115725" Then '// 12월
		vStartNo = "5"
	ElseIf vEventID = "115993" Then '// 1월
		vStartNo = "6"
	ElseIf vEventID = "116532" Then '// 2월
		vStartNo = "7"
  ElseIf vEventID = "117002" Then '// 3월
		vStartNo = "8"
  ElseIf vEventID = "117535" Then '// 4월
		vStartNo = "9"
	else
		vStartNo = "0"
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
    <h2><img src="//webimage.10x10.co.kr/fixevent/event/2021/114141/tit_light.png" alt="spectrum of light"></h2>
    <div class="swiper-container">
      <ul class="swiper-wrapper">
        <%' 오픈된 이벤트 open, 오늘 날짜에 current 클래스 넣어주세요 %>
        <% if currentdate < "2021-10-07" then %>
        <li class="swiper-slide coming"><span>Green</span>
        <% Else %>
        <li class="swiper-slide open <%=CHKIIF(vEventID="114141"," current","")%>">
          <a href="/event/eventmain.asp?eventid=114141" target="_top">Green</a>
        <% End If %>
        </li>
  
        <% if currentdate < "2021-10-21" then %>
        <li class="swiper-slide coming"><span>Blue</span>
        <% Else %>
        <li class="swiper-slide open <%=CHKIIF(vEventID="114410"," current","")%>">
          <a href="/event/eventmain.asp?eventid=114410" target="_top">Blue</a>
        <% End If %>
        </li>

        <% if currentdate < "2021-11-04" then %>
        <li class="swiper-slide coming"><span>Orange</span>
        <% Else %>
        <li class="swiper-slide open <%=CHKIIF(vEventID="114913"," current","")%>">
          <a href="/event/eventmain.asp?eventid=114913" target="_top">Orange</a>
        <% End If %>
        </li>

		    <% if currentdate < "2021-11-18" then %>
        <li class="swiper-slide coming"><span>Purple</span>
        <% Else %>
        <li class="swiper-slide open <%=CHKIIF(vEventID="115165"," current","")%>">
          <a href="/event/eventmain.asp?eventid=115165" target="_top">Purple</a>
        <% End If %>
        </li>

		    <% if currentdate < "2021-12-02" then %>
        <li class="swiper-slide coming"><span>Black</span>
        <% Else %>
        <li class="swiper-slide open <%=CHKIIF(vEventID="115330"," current","")%>">
          <a href="/event/eventmain.asp?eventid=115330" target="_top">Black</a>
        <% End If %>
        </li>

        <% if currentdate < "2021-12-16" then %>
        <li class="swiper-slide coming"><span>Red</span>
        <% Else %>
        <li class="swiper-slide open <%=CHKIIF(vEventID="115725"," current","")%>">
          <a href="/event/eventmain.asp?eventid=115725" target="_top">Red</a>
        <% End If %>
        </li>

        <% if currentdate < "2022-01-05" then %>
        <li class="swiper-slide coming"><span>Pink</span>
        <% Else %>
        <li class="swiper-slide open <%=CHKIIF(vEventID="115993"," current","")%>">
          <a href="/event/eventmain.asp?eventid=115993" target="_top">Pink</a>
        <% End If %>
        </li>

        <% if currentdate < "2022-02-08" then %>
        <li class="swiper-slide coming"><span>White</span>
        <% Else %>
        <li class="swiper-slide open <%=CHKIIF(vEventID="116532"," current","")%>">
          <a href="/event/eventmain.asp?eventid=116532" target="_top">White</a>
        <% End If %>
        </li>

        <% if currentdate < "2022-03-08" then %>
        <li class="swiper-slide coming"><span>Yellow</span>
        <% Else %>
        <li class="swiper-slide open <%=CHKIIF(vEventID="117002"," current","")%>">
          <a href="/event/eventmain.asp?eventid=117002" target="_top">Yellow</a>
        <% End If %>
        </li>

        <% if currentdate < "2022-04-05" then %>
        <li class="swiper-slide coming"><span>Mint</span>
        <% Else %>
        <li class="swiper-slide open <%=CHKIIF(vEventID="117535"," current","")%>">
          <a href="/event/eventmain.asp?eventid=117535" target="_top">Mint</a>
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