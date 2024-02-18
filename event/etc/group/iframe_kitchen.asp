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
	If vEventID = "105693" Then '// 9월
		vStartNo = "0"
	ElseIf vEventID = "106171" Then '// 10월
		vStartNo = "0"
	ElseIf vEventID = "106956" Then '// 11월
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
.navigator {display:flex; align-items:center; justify-content:center; width:325px; height:92px; padding:0 20px 0 10px; margin:0 auto; box-sizing:border-box;}
.navigator h2 {padding-top:10px;}
.nav-wrapper {position:relative;}
.navigator .swiper-container {width:275px;}
.navigator .swiper-wrapper {display:flex;}
.navigator .swiper-slide {font-size:15px;}
.navigator .swiper-slide span,
.navigator .swiper-slide a {display:flex; justify-content:center; align-items:center; width:100%; height:100%; color:#999999; text-decoration:none;}
.navigator .swiper-slide.current a {width:41px; height:41px; margin:0 auto; position:relative; color:#000000; font-weight:700; border:2px solid #000; border-radius:50%;}
.navigator button {position:absolute; top:0; z-index:100; width:25px; height:100%; background:url(//webimage.10x10.co.kr/fixevent/event/2020/106171/btn_nav.png) 0% 50% no-repeat; font-size:0;}
.navigator .btn-prev {left:-25px;}
.navigator .btn-next {right:-25px; transform:scale(-1);}
</style>
<script type="text/javascript">
$(function(){
	var evtSwiper = new Swiper('.navigator .swiper-container',{
		initialSlide:<%=vStartNo%>,
		slidesPerView:4,
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
	<div class="nav-wrapper">
        <div class="swiper-container">
            <ul class="swiper-wrapper">
                <% if currentdate < "2020-09-01" then %>
                <li class="swiper-slide coming"><span>9월</span>
                <% Else %>
                <li class="swiper-slide open <%=CHKIIF(vEventID="105693"," current","")%>">
                <% End If %>
                    <a href="/event/eventmain.asp?eventid=105693" target="_top">9월</a>
                </li>

                <% if currentdate < "2020-10-08" then %>
                " then %>
                <li class="swiper-slide coming"><span>10월</span>
                <% Else %>
                <li class="swiper-slide open <%=CHKIIF(vEventID="106171"," current","")%>">
                <% End If %>
                    <a href="/event/eventmain.asp?eventid=106171" target="_top">10월</a>
                </li>

                <% if currentdate < "2020-11-02" then %>
                <li class="swiper-slide coming"><span>11월</span>
                <% Else %>
                <li class="swiper-slide open <%=CHKIIF(vEventID="106956"," current","")%>">
                <% End If %>
                    <a href="/event/eventmain.asp?eventid=106956" target="_top">11월</a>
                </li>

                <% if currentdate < "2030-10-01" then %>
                <li class="swiper-slide coming"><span>12월</span>
                <% Else %>
                <li class="swiper-slide open <%=CHKIIF(vEventID="000"," current","")%>">
                <% End If %>
                    <a href="/event/eventmain.asp?eventid=000" target="_top">12월</a>
                </li>

                <% if currentdate < "2030-10-01" then %>
                <li class="swiper-slide coming"><span>1월</span>
                <% Else %>
                <li class="swiper-slide open <%=CHKIIF(vEventID="000"," current","")%>">
                <% End If %>
                    <a href="/event/eventmain.asp?eventid=000" target="_top">1월</a>
                </li>

                <% if currentdate < "2030-10-01" then %>
                <li class="swiper-slide coming"><span>2월</span>
                <% Else %>
                <li class="swiper-slide open <%=CHKIIF(vEventID="000"," current","")%>">
                <% End If %>
                    <a href="/event/eventmain.asp?eventid=000" target="_top">2월</a>
                </li>

            </ul>
        </div>
        <button class="btn-prev">이전</button>
        <button class="btn-next">다음</button>
    </div>
</div>
</body>
</html>