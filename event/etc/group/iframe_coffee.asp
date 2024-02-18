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
	If vEventID = "112289" Then '// 7월
		vStartNo = "0"
	ElseIf vEventID = "112830" Then '// 8월
		vStartNo = "0"
	ElseIf vEventID = "113538" Then '// 9월
		vStartNo = "1"
	ElseIf vEventID = "114069" Then '// 10월
		vStartNo = "2"
	ElseIf vEventID = "114705" Then '// 11월
		vStartNo = "3"
	ElseIf vEventID = "115302" Then '// 12월
		vStartNo = "4"
	ElseIf vEventID = "116003" Then '// 01월
		vStartNo = "5"
	ElseIf vEventID = "116529" Then '// 02월
		vStartNo = "6"
    ElseIf vEventID = "117280" Then '// 03월
		vStartNo = "7"  
	ElseIf vEventID = "117594" Then '// 04월
		vStartNo = "8"   
	ElseIf vEventID = "118166" Then '// 05월
		vStartNo = "9"   
	ElseIf vEventID = "118423" Then '// 06월
		vStartNo = "10"   
	ElseIf vEventID = "119205" Then '// 07월
		vStartNo = "11" 
	ElseIf vEventID = "119530" Then '// 08월
		vStartNo = "12" 
	ElseIf vEventID = "119871" Then '// 09월
		vStartNo = "13" 
	ElseIf vEventID = "120310" Then '// 10월
		vStartNo = "14"
	ElseIf vEventID = "120962" Then '// 11월
		vStartNo = "15"	
	else
		vStartNo = "0"
	End IF
%>
<style type="text/css">
.navigator {position:relative; width:657px; height:63px; margin:8px auto 0; padding:11px 34px 0;}
.navigator .swiper-slide {float:left; width:33.33333%;  text-align:center;}
.navigator .swiper-slide span,
.navigator .swiper-slide a {padding:0 1px; color:#c3c3c3; text-decoration:none; font:300 18px/1.1 'Noto Sans KR';}
.navigator .swiper-slide b {position:relative; top:-2px; padding-right:8px; vertical-align:middle;}
.navigator .swiper-slide.current{height:30px !important;}
.navigator .swiper-slide.current a {position:relative; color:#393939;}
.navigator .swiper-slide.current a:after {content:''; position:absolute; left:0; bottom:-3px; width:100%; height:2px; background:#585858;}
.navigator .swiper-slide.coming b,
.navigator .swiper-slide.open b {font-weight:400;}
.navigator .swiper-slide.open.current b {font-weight:600;}
.navigator .swiper-slide.open.current a {font-weight:400;}
.navigator button {position:absolute; top:11px; z-index:100; width:15px; height:24px; background:#fff url(//webimage.10x10.co.kr/eventIMG/2020/102974/btn_nav.png) 50% 50% no-repeat; font-size:0;}
.navigator .btn-prev {left:0;}
.navigator .btn-next {right:0; transform:rotate(180deg);}
</style>
<script type="text/javascript">
$(function(){
	var evtSwiper = new Swiper('.navigator .swiper-container',{
		initialSlide:<%=vStartNo%>,
		slidesPerView:3
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
	<div class="swiper-container">
		<ul class="swiper-wrapper">
			<% if currentdate < "2021-07-01" then %>
			<li class="swiper-slide coming"><span><b>7월호</b>프릳츠&라이언커피</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="112289"," current","")%>"><a href="/event/eventmain.asp?eventid=112289" target="_top"><b>7월호</b>프릳츠&라이언커피</a>
			<% End If %>
			</li>

			<% if currentdate < "2021-08-01" then %>
			<li class="swiper-slide coming"><span><b>8월호</b>탐앤탐스&일리</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="112830"," current","")%>"><a href="/event/eventmain.asp?eventid=112830" target="_top"><b>8월호</b>탐앤탐스&일리</a>
			<% End If %>
			</li>

			<% if currentdate < "2021-09-01" then %>
			<li class="swiper-slide coming"><span><b>9월호</b>제주 마이빈스</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="113538"," current","")%>"><a href="/event/eventmain.asp?eventid=113538" target="_top"><b>9월호</b>제주 마이빈스</a>
			<% End If %>
            </li>

			<% if currentdate < "2021-10-01" then %>
			<li class="swiper-slide coming"><span><b>10월호</b>coming soon</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="114069"," current","")%>"><a href="/event/eventmain.asp?eventid=114069" target="_top"><b>10월호</b>인터내셔널 로스트</a>
			<% End If %>
            </li>

			<% if currentdate < "2021-11-01" then %>
			<li class="swiper-slide coming"><span><b>11월호</b>coming soon</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="114705"," current","")%>"><a href="/event/eventmain.asp?eventid=114705" target="_top"><b>11월호</b>헬리빈</a>
			<% End If %>
            </li>

			<% if currentdate < "2021-12-01" then %>
			<li class="swiper-slide coming"><span><b>12월호</b>coming soon</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="115302"," current","")%>"><a href="/event/eventmain.asp?eventid=115302" target="_top"><b>12월호</b>핸디엄</a>
			<% End If %>
            </li>

			<% if currentdate < "2022-01-01" then %>
			<li class="swiper-slide coming"><span><b>1월호</b>더네이버스</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="116003"," current","")%>"><a href="/event/eventmain.asp?eventid=116003" target="_top"><b>1월호</b>더네이버스</a>
			<% End If %>
            </li>

			<% if currentdate < "2022-02-10" then %>
			<li class="swiper-slide coming"><span><b>2월호</b>프릳츠</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="116529"," current","")%>"><a href="/event/eventmain.asp?eventid=116529" target="_top"><b>2월호</b>프릳츠</a>
			<% End If %>
            </li>

			<% if currentdate < "2022-03-08" then %>
			<li class="swiper-slide coming"><span><b>3월호</b>TOM N TOMS</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="117280"," current","")%>"><a href="/event/eventmain.asp?eventid=117280" target="_top"><b>3월호</b>TOM N TOMS</a>
			<% End If %>
            </li>

            <% if currentdate < "2022-04-01" then %>
			<li class="swiper-slide coming"><span><b>4월호</b>STARBUCKS</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="117594"," current","")%>"><a href="/event/eventmain.asp?eventid=117594" target="_top"><b>4월호</b>STARBUCKS</a>
			<% End If %>
            </li>

			<% if currentdate < "2022-05-01" then %>
			<li class="swiper-slide coming"><span><b>5월호</b>coming soon</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="118166"," current","")%>"><a href="/event/eventmain.asp?eventid=118166" target="_top"><b>5월호</b>LIONCOFFEE</a>
			<% End If %>
            </li>

			<% if currentdate < "2022-06-01" then %>
			<li class="swiper-slide coming"><span><b>6월호</b>coming soon</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="118423"," current","")%>"><a href="/event/eventmain.asp?eventid=118423" target="_top"><b>6월호</b>COFFEE LIBRE</a>
			<% End If %>
            </li>

			<% if currentdate < "2022-07-07" then %>
			<li class="swiper-slide coming"><span><b>7월호</b>coming soon</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="119205"," current","")%>"><a href="/event/eventmain.asp?eventid=119205" target="_top"><b>7월호</b>HYDRO DUCH&Altdif</a>
			<% End If %>
            </li>

			<% if currentdate < "2022-08-01" then %>
			<li class="swiper-slide coming"><span><b>8월호</b>coming soon</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="119530"," current","")%>"><a href="/event/eventmain.asp?eventid=119530" target="_top"><b>8월호</b>NESPRESSO&SSANGGYE</a>
			<% End If %>
            </li>

			<% if currentdate < "2022-09-01" then %>
			<li class="swiper-slide coming"><span><b>9월호</b>coming soon</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="119871"," current","")%>"><a href="/event/eventmain.asp?eventid=119871" target="_top"><b>9월호</b>HANDIUM&ALOHWA</a>
			<% End If %>
            </li>

			<% if currentdate < "2022-10-03" then %>
			<li class="swiper-slide coming"><span><b>10월호</b>COMING SOON</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="120310"," current","")%>"><a href="/event/eventmain.asp?eventid=120310" target="_top"><b>10월호</b>FRITZ&NOKCHAWON</a>
			<% End If %>
            </li>

			<% if currentdate < "2022-11-07" then %>
			<li class="swiper-slide coming"><span><b>11월호</b>COMING SOON</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="120962"," current","")%>"><a href="/event/eventmain.asp?eventid=120962" target="_top"><b>12월호</b>ILLY&TEAZEN</a>
			<% End If %>
            </li>

			<% if currentdate < "2022-12-01" then %>
			<li class="swiper-slide coming"><span><b>12월호</b>COMING SOON</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="000000"," current","")%>"><a href="/event/eventmain.asp?eventid=000000" target="_top"><b>11월호</b>COMING SOON</a>
			<% End If %>
            </li>

		</ul>
    </div>
    <button class="btn-prev">이전</button>
	<button class="btn-next">다음</button>
</div>
</body>
</html>