<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/inc/head.asp" -->
<%
dim currentdate
	currentdate = date()
	'currentdate = "2021-06-14"
	'response.write currentdate

	Dim vEventID, vStartNo
	vEventID = requestCheckVar(Request("eventid"),9)

	If vEventID = "111853" Then '// 14일
		vStartNo = "0"
	ElseIf vEventID = "111883" Then '// 15일
		vStartNo = "1"
	ElseIf vEventID = "111884" Then '// 16일
		vStartNo = "2"
	ElseIf vEventID = "111922" Then '// 17일
		vStartNo = "3"
  ElseIf vEventID = "111995" Then '// 18일
    vStartNo = "4"
  ElseIf vEventID = "112009" Then '// 21일
    vStartNo = "5"
  ElseIf vEventID = "112010" Then '// 22일
    vStartNo = "6"
  ElseIf vEventID = "112011" Then '// 23일
    vStartNo = "7"
  ElseIf vEventID = "112012" Then '// 24일
    vStartNo = "8"
  ElseIf vEventID = "112013" Then '// 25일
    vStartNo = "9"
  ElseIf vEventID = "112014" Then '// 28일
    vStartNo = "10"
  ElseIf vEventID = "112016" Then '// 29일
    vStartNo = "11"
  ElseIf vEventID = "112017" Then '// 30일
    vStartNo = "12"
  ElseIf vEventID = "112178" Then '// 7/1일
    vStartNo = "13"
  ElseIf vEventID = "112231" Then '// 2일
    vStartNo = "14"
  ElseIf vEventID = "112245" Then '// 5일
    vStartNo = "15"
  ElseIf vEventID = "112246" Then '// 7일
    vStartNo = "16"
  ElseIf vEventID = "112247" Then '// 9일
    vStartNo = "17"
  ElseIf vEventID = "112248" Then '// 12일
    vStartNo = "18"
	else
		vStartNo = "0"
	End IF
%>

<style type="text/css">
.monthTab {position:relative; width:1140px; height:170px; overflow:hidden;background:url(//webimage.10x10.co.kr/fixevent/event/2021/<%=vEventID%>/date_area.jpg) no-repeat 0 0;}
.monthTab .swiper-container {position:absolute;right:129px;width:250px; overflow:hidden; margin:auto;}
.monthTab .swiper-container:before {content:''; position:absolute; top:0; left:0; height:100%; width:0.2rem; z-index:97;}
.monthTab .swiper-container:after {content:''; position:absolute; top:0; right:0; height:100%; width:0.2rem; z-index:97;}
.monthTab ul {margin:0 auto; z-index:96;}
.monthTab ul li {float:left; padding:52px 0;}
.monthTab ul li:last-child {width:0 !important;}
.monthTab ul li a {display:block; width:81px; height:26px; text-align:center; font-weight:500; font-family:'Roboto', 'Noto Sans KR', 'malgun Gothic', '맑은고딕', sans-serif; color:#fff; font-size:26px; text-decoration:none;}
.monthTab ul li.current a {color:#00FFD2; font-weight:bold;}
.monthTab ul li.current a.color_16{color:#e9ff6f;}
.monthTab ul li.current a.color_18{color:#e0ff34;}
.monthTab ul li.current a.color_21{color:#b0d7fc;}
.monthTab ul li.current a.color_22{color:#fff497;}
.monthTab ul li.current a.color_23{color:#adffa9;}
.monthTab ul li.current a.color_24{color:#faff68;}
.monthTab ul li.current a.color_29{color:#e3ff72;}
.monthTab ul li.current a.color_30{color:#f7ff72;}
.monthTab ul li.current a.color_1{color:#fff005;}
.monthTab ul li.current a.color_2{color:#c7eaff;}
.monthTab ul li.current a.color_5{color:#f7ff72;}
.monthTab ul li.current a.color_7{color:#e2ff8b;}
.monthTab ul li.current a.color_9{color:#f7ff72;}
.monthTab button {position:absolute; top:60px; z-index:10; padding-right:1px; outline:none;background:transparent;}
.monthTab button img {vertical-align:top;}
.monthTab .btnPrev {left:735px;}
.monthTab .btnNext {right:103px;}
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
		alert("아직 오픈전입니다. 해당 이벤트는 내일 확인해주세요.");
	});

});
</script>

</head>
<body>
    <div id="monthTab" class="monthTab">
        <div class="swiper-container">
            <ul class="swiper-wrapper">
                <%' 오픈된 이벤트 open, 오늘 날짜에 current 클래스 넣어주세요 %>
                <% if currentdate < "2021-06-14" then %>
                <li class="swiper-slide coming">
                <% Else %>
                <li class="swiper-slide open <%=CHKIIF(vEventID="111853"," current","")%>">
                <% End If %>
                    <a href="/event/eventmain.asp?eventid=111853" target="_top">14</a>
                </li>

                <% if currentdate < "2021-06-15" then %>
                <li class="swiper-slide coming">
                <% Else %>
                <li class="swiper-slide open <%=CHKIIF(vEventID="111883"," current","")%>">
                <% End If %>
                    <a href="/event/eventmain.asp?eventid=111883" target="_top">15</a>
                </li>

                <% if currentdate < "2021-06-16" then %>`
                <li class="swiper-slide coming">
                <% Else %>
                <li class="swiper-slide open <%=CHKIIF(vEventID="111884"," current","")%>">
                <% End If %>
                    <a href="/event/eventmain.asp?eventid=111884" target="_top" class="color_16">16</a>
                </li>

				        <% if currentdate < "2021-06-17" then %>`
                <li class="swiper-slide coming">
                <% Else %>
                <li class="swiper-slide open <%=CHKIIF(vEventID="111922"," current","")%>">
                <% End If %>
                    <a href="/event/eventmain.asp?eventid=111922" target="_top" class="color_16">17</a>
                </li>

                <% if currentdate < "2021-06-18" then %>`
                <li class="swiper-slide coming">
                <% Else %>
                <li class="swiper-slide open <%=CHKIIF(vEventID="111995"," current","")%>">
                <% End If %>
                    <a href="/event/eventmain.asp?eventid=111995" target="_top" class="color_18">18</a>
                </li>

                <% if currentdate < "2021-06-21" then %>`
                <li class="swiper-slide coming">
                <% Else %>
                <li class="swiper-slide open <%=CHKIIF(vEventID="112009"," current","")%>">
                <% End If %>
                    <a href="/event/eventmain.asp?eventid=112009" target="_top" class="color_21">21</a>
                </li>

                <% if currentdate < "2021-06-22" then %>`
                <li class="swiper-slide coming">
                <% Else %>
                <li class="swiper-slide open <%=CHKIIF(vEventID="112010"," current","")%>">
                <% End If %>
                    <a href="/event/eventmain.asp?eventid=112010" target="_top" class="color_22">22</a>
                </li>

                <% if currentdate < "2021-06-23" then %>`
                <li class="swiper-slide coming">
                <% Else %>
                <li class="swiper-slide open <%=CHKIIF(vEventID="112011"," current","")%>">
                <% End If %>
                    <a href="/event/eventmain.asp?eventid=112011" target="_top" class="color_23">23</a>
                </li>

                <% if currentdate < "2021-06-24" then %>`
                <li class="swiper-slide coming">
                <% Else %>
                <li class="swiper-slide open <%=CHKIIF(vEventID="112012"," current","")%>">
                <% End If %>
                    <a href="/event/eventmain.asp?eventid=112012" target="_top" class="color_24">24</a>
                </li>

                <% if currentdate < "2021-06-25" then %>`
                <li class="swiper-slide coming">
                <% Else %>
                <li class="swiper-slide open <%=CHKIIF(vEventID="112013"," current","")%>">
                <% End If %>
                    <a href="/event/eventmain.asp?eventid=112013" target="_top" class="color_24">25</a>
                </li>

                <% if currentdate < "2021-06-28" then %>`
                <li class="swiper-slide coming">
                <% Else %>
                <li class="swiper-slide open <%=CHKIIF(vEventID="112014"," current","")%>">
                <% End If %>
                    <a href="/event/eventmain.asp?eventid=112014" target="_top" class="color_24">28</a>
                </li>

                <% if currentdate < "2021-06-29" then %>`
                <li class="swiper-slide coming">
                <% Else %>
                <li class="swiper-slide open <%=CHKIIF(vEventID="112016"," current","")%>">
                <% End If %>
                    <a href="/event/eventmain.asp?eventid=112016" target="_top" class="color_29">29</a>
                </li>

                <% if currentdate < "2021-06-30" then %>`
                <li class="swiper-slide coming">
                <% Else %>
                <li class="swiper-slide open <%=CHKIIF(vEventID="112017"," current","")%>">
                <% End If %>
                    <a href="/event/eventmain.asp?eventid=112017" target="_top" class="color_30">30</a>
                </li>

                <% if currentdate < "2021-07-01" then %>`
                <li class="swiper-slide coming">
                <% Else %>
                <li class="swiper-slide open <%=CHKIIF(vEventID="112178"," current","")%>">
                <% End If %>
                    <a href="/event/eventmain.asp?eventid=112178" target="_top" class="color_1">1</a>
                </li>

                <% if currentdate < "2021-07-02" then %>`
                <li class="swiper-slide coming">
                <% Else %>
                <li class="swiper-slide open <%=CHKIIF(vEventID="112231"," current","")%>">
                <% End If %>
                    <a href="/event/eventmain.asp?eventid=112231" target="_top" class="color_2">2</a>
                </li>

                <% if currentdate < "2021-07-05" then %>`
                <li class="swiper-slide coming">
                <% Else %>
                <li class="swiper-slide open <%=CHKIIF(vEventID="112245"," current","")%>">
                <% End If %>
                    <a href="/event/eventmain.asp?eventid=112245" target="_top" class="color_5">5</a>
                </li>

                <% if currentdate < "2021-07-07" then %>`
                <li class="swiper-slide coming">
                <% Else %>
                <li class="swiper-slide open <%=CHKIIF(vEventID="112246"," current","")%>">
                <% End If %>
                    <a href="/event/eventmain.asp?eventid=112246" target="_top" class="color_7">7</a>
                </li>

                <% if currentdate < "2021-07-09" then %>`
                <li class="swiper-slide coming">
                <% Else %>
                <li class="swiper-slide open <%=CHKIIF(vEventID="112247"," current","")%>">
                <% End If %>
                    <a href="/event/eventmain.asp?eventid=112247" target="_top" class="color_9">9</a>
                </li>

            </ul>
        </div>
        <button class="btnPrev"><img src="http://webimage.10x10.co.kr/fixevent/event/2021/111853/btn_prev.png" alt="이전"></button>
        <button class="btnNext"><img src="http://webimage.10x10.co.kr/fixevent/event/2021/111853/btn_next.png" alt="다음"></button>
    </div>
</body>
</html>