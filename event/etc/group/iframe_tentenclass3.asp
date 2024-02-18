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
	If vEventID = "95354" Then '// 7월
		vStartNo = "0"
	ElseIf vEventID = "96299" Then '// 8월
		vStartNo = "0"
	ElseIf vEventID = "96997" Then '// 9월
		vStartNo = "0"
	ElseIf vEventID = "97525" Then '// 10월
		vStartNo = "1"
	ElseIf vEventID = "98311" Then '// 11월
		vStartNo = "2"
	ElseIf vEventID = "99015" Then '// 12월
		vStartNo = "3"
	ElseIf vEventID = "99736" Then '// 1월
		vStartNo = "4"
	ElseIf vEventID = "100275" Then '// 2월
		vStartNo = "5"
	ElseIf vEventID = "100919" Then '// 3월
		vStartNo = "6"
	ElseIf vEventID = "101739" Then '// 4월
		vStartNo = "7"
	ElseIf vEventID = "102412" Then '// 5월
		vStartNo = "8"
	ElseIf vEventID = "103062" Then '// 6월
		vStartNo = "9"
	ElseIf vEventID = "103875" Then '// 7월
		vStartNo = "10"
	ElseIf vEventID = "104696" Then '// 8월
		vStartNo = "11"
	ElseIf vEventID = "105290" Then '// 9월
		vStartNo = "12"
	ElseIf vEventID = "106362" Then '// 10월
		vStartNo = "13"
	ElseIf vEventID = "106363" Then '// 11월
		vStartNo = "14"
	ElseIf vEventID = "106364" Then '// 12월
		vStartNo = "15"
	else
		vStartNo = "0"
	End IF
%>
<style type="text/css">
.monthTab {position:relative; width:1140px; height:78px; overflow:hidden; border-bottom:1px solid #bfbfbf; background-color:#fff;}
.monthTab .swiper-container {width:1080px; height:78px; overflow:hidden; margin:auto;}
.monthTab .swiper-container:before {content:''; position:absolute; top:0; left:0; height:100%; width:0.2rem; background-color:#fff; z-index:97;}
.monthTab .swiper-container:after {content:''; position:absolute; top:0; right:0; height:100%; width:0.2rem; background-color:#fff; z-index:97;}
.monthTab ul {margin:0 auto; z-index:96;}
.monthTab ul li {float:left; width:216px; height:26px !important; padding:28px 0 26px;}
.monthTab ul li a {display:block; width:216px; height:26px; border-right:1px solid #999; text-align:center; font-weight:500; font-family:'Roboto', 'Noto Sans KR', 'malgun Gothic', '맑은고딕', sans-serif; color:#999; font-size:18px; text-decoration:none;}
.monthTab ul li.current a {color:#000;}
.monthTab button {display:inline-block; position:absolute; top:2px; z-index:10; width:31px; height:78px; outline:none; background-color:#fff; background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/95354/btn_date_nav.png); text-indent:-999em;}
.monthTab .btnPrev {left:0;}
.monthTab .btnNext {right:0; transform:rotate(180deg);}
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
			<% if currentdate < "2019-07-01" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="95354"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=95354" target="_top"><strong>19.07</strong> &#183; JULY</a>
			</li>

			<% if currentdate < "2019-08-01" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="96299"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=96299" target="_top"><strong>19.08</strong> &#183; AUGUST</a>
			</li>

			<% if currentdate < "2019-09-01" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="96997"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=96997" target="_top"><strong>19.09</strong> &#183; SEPTEMBER</a>
			</li>

			<% if currentdate < "2019-10-01" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="97525"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=97525" target="_top"><strong>19.10</strong> &#183; OCTOBER</a>
			</li>

			<% if currentdate < "2019-11-01" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="98311"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=98311" target="_top"><strong>19.11</strong> &#183; NOVEMBER</a>
			</li>

			<% if currentdate < "2019-12-01" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="99015"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=99015" target="_top"><strong>19.12</strong> &#183; DECEMBER</a>
			</li>

			<% if currentdate < "2020-01-01" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="99736"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=99736" target="_top"><strong>20.01</strong> &#183; JANUARY</a>
			</li>

			<% if currentdate < "2020-02-01" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="100275"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=100275" target="_top"><strong>20.02</strong> &#183; FEBRUARY</a>
			</li>

			<% if currentdate < "2020-03-01" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="100919"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=100919" target="_top"><strong>20.03</strong> &#183; MARCH</a>
			</li>

			<% if currentdate < "2020-04-01" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="101739"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=101739" target="_top"><strong>20.04</strong> &#183; APRIL</a>
			</li>

			<% if currentdate < "2020-05-01" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="102412"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=102412" target="_top"><strong>20.05</strong> &#183; MAY</a>
			</li>

			<% if currentdate < "2020-06-01" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="103062"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=103062" target="_top"><strong>20.06</strong> &#183; JUNE</a>
			</li>

			<% if currentdate < "2020-07-01" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="103875"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=103875" target="_top"><strong>20.07</strong> &#183; JULY</a>
			</li>

			<% if currentdate < "2020-08-01" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="104696"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=104696" target="_top"><strong>20.08</strong> &#183; AUGUST</a>
			</li>

			<% if currentdate < "2020-09-01" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="105290"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=105290" target="_top"><strong>20.09</strong> &#183; SEPTEMBER</a>
			</li>

			<% if currentdate < "2020-10-01" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="106362"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=106362" target="_top"><strong>20.10</strong> &#183; OCTOBER</a>
			</li>

			<% if currentdate < "2020-11-01" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="106363"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=106363" target="_top"><strong>20.11</strong> &#183; NOVEMBER</a>
			</li>

			<% if currentdate < "2020-12-01" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="106364"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=106364" target="_top"><strong>20.12</strong> &#183; DECEMBER</a>
			</li>
		</ul>
	</div>
	<button class="btnPrev">이전</button>
	<button class="btnNext">다음</button>
</div>

</body>
</html>