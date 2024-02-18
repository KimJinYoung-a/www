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
	If vEventID = "90691" Then '// 12월
		vStartNo = "0"
	ElseIf vEventID = "91631" Then '// 1월
		vStartNo = "0"
	ElseIf vEventID = "92378" Then '// 2월
		vStartNo = "0"
	ElseIf vEventID = "92873" Then '// 3월
		vStartNo = "1"
	ElseIf vEventID = "93618" Then '// 4월
		vStartNo = "2"
	ElseIf vEventID = "94259" Then '// 5월
		vStartNo = "3"
	ElseIf vEventID = "95103" Then '// 6월
		vStartNo = "4"
	ElseIf vEventID = "95698" Then '// 7월
		vStartNo = "5"
	ElseIf vEventID = "96535" Then '// 8월
		vStartNo = "6"
	ElseIf vEventID = "97185" Then '// 9월
		vStartNo = "7"
	ElseIf vEventID = "97793" Then '// 10월
		vStartNo = "8"
	ElseIf vEventID = "98410" Then '// 11월
		vStartNo = "9"
	ElseIf vEventID = "99103" Then '// 12월
		vStartNo = "10"
	ElseIf vEventID = "99708" Then '// 1월
		vStartNo = "11"
	ElseIf vEventID = "100282" Then '// 2월
		vStartNo = "12"
	ElseIf vEventID = "101008" Then '// 3월
		vStartNo = "13"
	ElseIf vEventID = "102453" Then '// 5월
		vStartNo = "14"
	ElseIf vEventID = "103133" Then '// 6월
		vStartNo = "15"
	ElseIf vEventID = "104157" Then '// 7월
		vStartNo = "16"
	ElseIf vEventID = "104770" Then '// 8월
		vStartNo = "17"
	ElseIf vEventID = "105425" Then '// 9월
		vStartNo = "18"
	ElseIf vEventID = "106341" Then '// 10월
		vStartNo = "19"
	ElseIf vEventID = "106998" Then '// 11월
		vStartNo = "20"
	ElseIf vEventID = "107947" Then '// 12월
		vStartNo = "21"
	ElseIf vEventID = "108695" Then '// 1월
		vStartNo = "22"
    ElseIf vEventID = "109266" Then '// 2월
        vStartNo = "23"
    ElseIf vEventID = "109739" Then '// 3월
        vStartNo = "24"
    ElseIf vEventID = "110259" Then '// 4월
        vStartNo = "25"
    ElseIf vEventID = "110996" Then '// 5월
        vStartNo = "26"
	ElseIf vEventID = "111387" Then '// 6월
        vStartNo = "27"
	ElseIf vEventID = "112278" Then '// 7월
        vStartNo = "28"
	ElseIf vEventID = "113022" Then '// 8월
        vStartNo = "29"
	ElseIf vEventID = "113686" Then '// 9월
        vStartNo = "30"
	ElseIf vEventID = "114091" Then '// 10월
        vStartNo = "31"
    ElseIf vEventID = "115003" Then '// 11월
        vStartNo = "32"
    ElseIf vEventID = "115416" Then '// 12월
        vStartNo = "33" 
	ElseIf vEventID = "116218" Then '// 1월
        vStartNo = "34"
    ElseIf vEventID = "116610" Then '// 2월
        vStartNo = "35" 
	ElseIf vEventID = "117207" Then '// 3월
        vStartNo = "36"	   
	ElseIf vEventID = "117765" Then '// 4월
        vStartNo = "37"   
	ElseIf vEventID = "118286" Then '// 5월
        vStartNo = "38"	   
	ElseIf vEventID = "118700" Then '// 6월
        vStartNo = "39"
	ElseIf vEventID = "119051" Then '// 7월
        vStartNo = "40"	
	ElseIf vEventID = "119529" Then '// 8월
        vStartNo = "41"	
	ElseIf vEventID = "119978" Then '// 9월
        vStartNo = "42"	
	else
		vStartNo = "0"
	End IF
%>
<style>
.monthTab {position:relative; width:1140px; height:52px; overflow:hidden; border-bottom:1px solid #ccc; margin-bottom:30px;}
.monthTab .swiper-container {width:1080px; overflow:hidden; margin:auto;}
.monthTab .swiper-container:before {content:''; position:absolute; top:0; left:0; height:100%; width:0.2rem; background-color:#fff; z-index:97;}
.monthTab .swiper-container:after {content:''; position:absolute; top:0; right:0; height:100%; width:0.2rem; background-color:#fff; z-index:97;}
.monthTab ul {margin:0 auto; z-index:96;}
.monthTab ul li {float:left; width:216px; padding:13px 0;}
.monthTab ul li a {display:block; width:216px; height:26px; border-right:1px solid #999; text-align:center; font-weight:500; font-family:'Roboto', 'Noto Sans KR', 'malgun Gothic', '맑은고딕', sans-serif; color:#999; font-size:16px; text-decoration:none;}
.monthTab ul li.current a {color:#000; font-weight:bold;}
.monthTab button {position:absolute; top:0; z-index:10; padding-right:1px; outline:none; background-color:#fff;}
.monthTab button img {vertical-align:top;}
.monthTab .btnPrev {left:0;}
.monthTab .btnNext {right:0;}
</style>
<script type="text/javascript">
$(function(){
	var evtSwiper = new Swiper('.monthTab .swiper-container',{
		initialSlide:<%=vStartNo%>,
		slidesPerView:5,
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
			<% if currentdate < "2018-11-28" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="90691"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=90691" target="_top">12월호</a>
			</li>

			<% if currentdate < "2019-01-03" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="91631"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=91631" target="_top">1월호</a>
			</li>

			<% if currentdate < "2019-02-07" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="92378"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=92378" target="_top">2월호</a>
			</li>

			<% if currentdate < "2019-03-06" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="92873"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=92873" target="_top">3월호</a>
			</li>

			<% if currentdate < "2019-04-10" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="93618"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=93618" target="_top">4월호</a>
			</li>

			<% if currentdate < "2019-05-15" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="94259"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=94259" target="_top">5월호</a>
			</li>

			<% if currentdate < "2019-06-12" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="95103"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=95103" target="_top">6월호</a>
			</li>

			<% if currentdate < "2019-07-02" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="95698"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=95698" target="_top">7월호</a>
			</li>

			<% if currentdate < "2019-08-06" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="96535"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=96535" target="_top">8월호</a>
			</li>

			<% if currentdate < "2019-09-06" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="97185"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=97185" target="_top">9월호</a>
			</li>

			<% if currentdate < "2019-10-08" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="97793"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=97793" target="_top">10월호</a>
			</li>

			<% if currentdate < "2019-11-06" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="98410"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=98410" target="_top">11월호</a>
			</li>

			<% if currentdate < "2019-12-05" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="99103"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=99103" target="_top">12월호</a>
			</li>

			<% if currentdate < "2020-01-01" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="99708"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=99708" target="_top">1월호</a>
			</li>

			<% if currentdate < "2020-02-01" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="100282"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=100282" target="_top">2월호</a>
			</li>

			<% if currentdate < "2020-03-01" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="101008"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=101008" target="_top">3월호</a>
			</li>

			<% if currentdate < "2020-05-01" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="102453"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=102453" target="_top">5월호</a>
			</li>

			<% if currentdate < "2020-06-01" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="103133"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=103133" target="_top">6월호</a>
			</li>

			<% if currentdate < "2020-07-07" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="104157"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=104157" target="_top">7월호</a>
			</li>

			<% if currentdate < "2020-08-01" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="104770"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=104770" target="_top">8월호</a>
			</li>

			<% if currentdate < "2020-09-01" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="105425"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=105425" target="_top">9월호</a>
			</li>

			<% if currentdate < "2020-10-01" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="106341"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=106341" target="_top">10월호</a>
			</li>

			<% if currentdate < "2020-11-01" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="106998"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=106998" target="_top">11월호</a>
			</li>

			<% if currentdate < "2020-12-01" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="107947"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=107947" target="_top">12월호</a>
			</li>

			<% if currentdate < "2021-01-01" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="108695"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=108695" target="_top">1월호</a>
			</li>

            <% if currentdate < "2021-02-01" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="109266"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=109266" target="_top">2월호</a>
			</li>

            <% if currentdate < "2021-03-01" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="109739"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=109739" target="_top">3월호</a>
			</li>

            <% if currentdate < "2021-04-01" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="110259"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=110259" target="_top">4월호</a>
			</li>

            <% if currentdate < "2021-05-01" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="110996"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=110996" target="_top">5월호</a>
			</li>

			<% if currentdate < "2021-06-01" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="111387"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=111387" target="_top">6월호</a>
			</li>

			<% if currentdate < "2021-07-01" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="112278"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=112278" target="_top">7월호</a>
			</li>

			<% if currentdate < "2021-08-01" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="113022"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=113022" target="_top">8월호</a>
			</li>

			<% if currentdate < "2021-09-01" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="113686"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=113686" target="_top">9월호</a>
			</li>

			<% if currentdate < "2021-10-01" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="114091"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=114091" target="_top">10월호</a>
			</li>

            <% if currentdate < "2021-11-01" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="115003"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=115003" target="_top">11월호</a>
			</li>

            <% if currentdate < "2021-12-01" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="115416"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=115416" target="_top">12월호</a>
			</li>

			<% if currentdate < "2022-01-01" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="116218"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=116218" target="_top">1월호</a>
			</li>

            <% if currentdate < "2022-02-01" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="116610"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=116610" target="_top">2월호</a>
			</li>

			<% if currentdate < "2022-03-01" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="117207"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=117207" target="_top">3월호</a>
			</li>

			<% if currentdate < "2022-04-01" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="117765"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=117765" target="_top">4월호</a>
			</li>
			
			<% if currentdate < "2022-05-01" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="118286"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=118286" target="_top">5월호</a>
			</li>
			
			<% if currentdate < "2022-06-01" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="118700"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=118700" target="_top">6월호</a>
			</li>

			<% if currentdate < "2022-07-01" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="119051"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=119051" target="_top">7월호</a>
			</li>

			<% if currentdate < "2022-08-01" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="119529"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=119529" target="_top">8월호</a>
			</li>

			<% if currentdate < "2022-09-05" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="119978"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=119978" target="_top">9월호</a>
			</li>
		</ul>
	</div>
	<button class="btnPrev"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90691/btn_prev.png" alt="이전"></button>
	<button class="btnNext"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90691/btn_next.png" alt="다음"></button>
</div>
</body>
</html>