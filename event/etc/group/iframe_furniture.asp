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
	If vEventID = "113827" Then '// 9월
		vStartNo = "0"
	ElseIf vEventID = "" Then '// 10월
		vStartNo = "0"
	ElseIf vEventID = "" Then '// 11월
		vStartNo = "1"
	ElseIf vEventID = "" Then '// 12월
		vStartNo = "2"
	ElseIf vEventID = "" Then '// 1월
		vStartNo = "3"
	ElseIf vEventID = "" Then '// 2월
		vStartNo = "4"
	else
		vStartNo = "0"
	End IF
%>
<style type="text/css">
.navigator {display:flex; align-items:center; justify-content:space-between; width:1140px; height:135px; padding:0 20px 0 10px; margin:0 auto; box-sizing:border-box;}
.navigator h2 {padding-top:10px;}
.nav-wrapper {position:relative;}
.navigator .swiper-container {width:315px;}
.navigator .swiper-wrapper {display:flex;}
.navigator .swiper-slide {font-size:20px;}
.navigator .swiper-slide span,
.navigator .swiper-slide a {display:flex; justify-content:center; align-items:center; width:100%; height:100%; color:#bfa79a; text-decoration:none;}
.navigator .swiper-slide.current a {position:relative; color:#785a49; font-weight:700;}
.navigator button {position:absolute; top:0; z-index:100; width:25px; height:100%; background:#fbf4ec url(//webimage.10x10.co.kr/fixevent/event/2020/106058/btn_nav.png?v=1.01) 0% 50% no-repeat; font-size:0;}
.navigator .btn-prev {left:-25px;}
.navigator .btn-next {right:-25px; transform:scale(-1);}
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
		alert("오픈 예정 기획전 입니다.");
	});
});
</script>
</head>
<body>
<div id="navigator" class="navigator">
	<h2><img src="//webimage.10x10.co.kr/fixevent/event/2020/106058/tit_furniture.png" alt="가구 소식"></h2>
	<div class="nav-wrapper">
        <div class="swiper-container">
            <ul class="swiper-wrapper">
                <% if currentdate < "2021-09-06" then %>
                <li class="swiper-slide coming"><span>#9월</span>
                <% Else %>
                <li class="swiper-slide open <%=CHKIIF(vEventID="113827"," current","")%>">
                <% End If %>
                    <a href="/event/eventmain.asp?eventid=13827" target="_top">#9월</a>
                </li>

                <% if currentdate < "2021-10-06" then %>
                <li class="swiper-slide coming"><span>#10월</span>
                <% Else %>
                <li class="swiper-slide open <%=CHKIIF(vEventID="000"," current","")%>">
                <% End If %>
                    <a href="/event/eventmain.asp?eventid=000" target="_top">#10월</a>
                </li>

                <% if currentdate < "2021-11-06" then %>
                <li class="swiper-slide coming"><span>#11월</span>
                <% Else %>
                <li class="swiper-slide open <%=CHKIIF(vEventID="000"," current","")%>">
                <% End If %>
                    <a href="/event/eventmain.asp?eventid=000" target="_top">#11월</a>
                </li>

                <% if currentdate < "2021-12-06" then %>
                <li class="swiper-slide coming"><span>#12월</span>
                <% Else %>
                <li class="swiper-slide open <%=CHKIIF(vEventID="000"," current","")%>">
                <% End If %>
                    <a href="/event/eventmain.asp?eventid=000" target="_top">#12월</a>
                </li>

                <% if currentdate < "2022-01-06" then %>
                <li class="swiper-slide coming"><span>#1월</span>
                <% Else %>
                <li class="swiper-slide open <%=CHKIIF(vEventID="000"," current","")%>">
                <% End If %>
                    <a href="/event/eventmain.asp?eventid=000" target="_top">#1월</a>
                </li>

                <% if currentdate < "2022-02-06" then %>
                <li class="swiper-slide coming"><span>#2월</span>
                <% Else %>
                <li class="swiper-slide open <%=CHKIIF(vEventID="000"," current","")%>">
                <% End If %>
                    <a href="/event/eventmain.asp?eventid=000" target="_top">#2월</a>
                </li>

            </ul>
        </div>
        <button class="btn-prev">이전</button>
        <button class="btn-next">다음</button>
    </div>
</div>
</body>
</html>