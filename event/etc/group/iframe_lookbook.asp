<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/inc/head.asp" -->
<%
dim currentdate
	currentdate = date()
	'currentdate = "2018-08-20"
	'response.write currentdate

	Dim vEventID, vStartNo
	vEventID = requestCheckVar(Request("eventid"),9)
	If vEventID = "88272" Then '// vol.01
		vStartNo = "0"
	ElseIf vEventID = "88538" Then '// vol.02
		vStartNo = "0"
	ElseIf vEventID = "88664" Then '// vol.03
		vStartNo = "0"
	ElseIf vEventID = "88789" Then '// vol.04
		vStartNo = "0"
	ElseIf vEventID = "88948" Then '// vol.05
		vStartNo = "0"
	ElseIf vEventID = "88949" Then '// vol.06
		vStartNo = "1"
	ElseIf vEventID = "88950" Then '// vol.07
		vStartNo = "2"
	ElseIf vEventID = "89466" Then '// vol.08
		vStartNo = "3"
	ElseIf vEventID = "89467" Then '// vol.09
		vStartNo = "4"
	ElseIf vEventID = "89874" Then '// vol.10
		vStartNo = "5"
	ElseIf vEventID = "90123" Then '// vol.11
		vStartNo = "6"
	ElseIf vEventID = "90311" Then '// vol.12
		vStartNo = "7"
	ElseIf vEventID = "90312" Then '// vol.13
		vStartNo = "8"
	ElseIf vEventID = "91087" Then '// vol.14
		vStartNo = "9"
	ElseIf vEventID = "91587" Then '// vol.15
		vStartNo = "10"
	ElseIf vEventID = "91912" Then '// vol.16
		vStartNo = "11"
	ElseIf vEventID = "92279" Then '// vol.17
		vStartNo = "12"
	ElseIf vEventID = "92841" Then '// vol.18
		vStartNo = "13"
	ElseIf vEventID = "93135" Then '// vol.19
		vStartNo = "14"
	ElseIf vEventID = "93391" Then '// vol.20
		vStartNo = "15"
	ElseIf vEventID = "94003" Then '// vol.21
		vStartNo = "16"
	ElseIf vEventID = "94324" Then '// vol.22
		vStartNo = "17"
	else
		vStartNo = "0"
	End IF
%>
<style type="text/css">
.navigation {position:relative; overflow:hidden; padding:0 120px;}
.navigation li {float:left; height:40px; line-height:40px; font-family:'RobotoRegular', 'Noto Sans', sans-serif; font-size:15px; color:#737373; text-align:center; cursor:pointer;}
.navigation li.open a {color:#212121;}
.navigation li.current a {font-weight:600; color:#ff8484;}
.navigation li a {display:block; position:relative; width:90%; height:100%; margin:0 auto; text-decoration:none;}
.navigation li.current a:after {content:''; position:absolute; top:0; left:50%; margin-left:-2px; width:4px; height:4px; background-color:#ff6969; border-radius:100%;}
.navigation button {display:block; position:absolute; top:8px; width:19px; height:24px; padding:5px; font-size:0; background-color:transparent; outline:none;}
.navigation .btnPrev {left:95px;}
.navigation .btnNext {right:95px;}
</style>
<script type="text/javascript">
$(function(){
	var evtSwiper = new Swiper('.navigation .swiper-container',{
		initialSlide:<%=vStartNo%>,
		slidesPerView:8,
		speed:200
	})
	$('.navigation .btnPrev').on('click', function(e){
		e.preventDefault();
		evtSwiper.swipePrev();
	})
	$('.navigation .btnNext').on('click', function(e){
		e.preventDefault(); 
		evtSwiper.swipeNext();
	});
	$('.swiper-slide.next').on('click', function(e){
		e.preventDefault();
		alert("오픈 예정 기획전 입니다.");
	});
});
</script>
</head>
<body>
<div class="navigation">
	<div class="swiper-container">
		<ul class="swiper-wrapper">
			<li class="swiper-slide open <%=CHKIIF(vEventID="88272"," current","")%>"><a href="/event/eventmain.asp?eventid=88272" target="_top">vol.01</a></li>
			<li class="swiper-slide open <%=CHKIIF(vEventID="88538"," current","")%>"><a href="/event/eventmain.asp?eventid=88538" target="_top">vol.02</a></li>

			<%' 오픈된 이벤트 open, 오늘 날짜에 current 클래스 넣어주세요 %>
			<% if currentdate < "2018-08-21" then %>
			<li class="swiper-slide next">vol.03</li>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="88664"," current","")%>"><a href="/event/eventmain.asp?eventid=88664" target="_top">vol.03</a></li>
			<% End If %>

			<% if currentdate < "2018-08-27" then %>
			<li class="swiper-slide next">vol.04</li>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="88789"," current","")%>"><a href="/event/eventmain.asp?eventid=88789" target="_top">vol.04</a></li>
			<% End If %>

			<% if currentdate < "2018-09-04" then %>
			<li class="swiper-slide next">vol.05</li>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="88948"," current","")%>"><a href="/event/eventmain.asp?eventid=88948" target="_top">vol.05</a></li>
			<% End If %>

			<% if currentdate < "2018-09-11" then %>
			<li class="swiper-slide next">vol.06</li>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="88949"," current","")%>"><a href="/event/eventmain.asp?eventid=88949" target="_top">vol.06</a></li>
			<% End If %>

			<% if currentdate < "2018-09-18" then %>
			<li class="swiper-slide next">vol.07</li>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="88950"," current","")%>"><a href="/event/eventmain.asp?eventid=88950" target="_top">vol.07</a></li>
			<% End If %>

			<% if currentdate < "2018-09-25" then %>
			<li class="swiper-slide next">vol.08</li>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="89466"," current","")%>"><a href="/event/eventmain.asp?eventid=89466" target="_top">vol.08</a></li>
			<% End If %>
			
			<% if currentdate < "2018-10-02" then %>
			<li class="swiper-slide next">vol.09</li>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="89467"," current","")%>"><a href="/event/eventmain.asp?eventid=89467" target="_top">vol.09</a></li>
			<% End If %>
			
			<% if currentdate < "2018-10-16" then %>
			<li class="swiper-slide next">vol.10</li>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="89874"," current","")%>"><a href="/event/eventmain.asp?eventid=89874" target="_top">vol.10</a></li>
			<% End If %>
			
			<% if currentdate < "2018-10-30" then %>
			<li class="swiper-slide next">vol.11</li>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="90123"," current","")%>"><a href="/event/eventmain.asp?eventid=90123" target="_top">vol.11</a></li>
			<% End If %>
			
			<% if currentdate < "2018-11-13" then %>
			<li class="swiper-slide next">vol.12</li>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="90311"," current","")%>"><a href="/event/eventmain.asp?eventid=90311" target="_top">vol.12</a></li>
			<% End If %>
			
			<% if currentdate < "2018-11-26" then %>
			<li class="swiper-slide next">vol.13</li>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="90312"," current","")%>"><a href="/event/eventmain.asp?eventid=90312" target="_top">vol.13</a></li>
			<% End If %>
			
			<% if currentdate < "2018-12-11" then %>
			<li class="swiper-slide next">vol.14</li>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="91087"," current","")%>"><a href="/event/eventmain.asp?eventid=91087" target="_top">vol.14</a></li>
			<% End If %>
			
			<% if currentdate < "2019-01-04" then %>
			<li class="swiper-slide next">vol.15</li>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="91587"," current","")%>"><a href="/event/eventmain.asp?eventid=91587" target="_top">vol.15</a></li>
			<% End If %>
			
			<% if currentdate < "2019-01-22" then %>
			<li class="swiper-slide next">vol.16</li>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="91912"," current","")%>"><a href="/event/eventmain.asp?eventid=91912" target="_top">vol.16</a></li>
			<% End If %>

			<% if currentdate < "2019-02-12" then %>
			<li class="swiper-slide next">vol.17</li>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="92279"," current","")%>"><a href="/event/eventmain.asp?eventid=92279" target="_top">vol.17</a></li>
			<% End If %>

			<% if currentdate < "2019-02-26" then %>
			<li class="swiper-slide next">vol.18</li>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="92841"," current","")%>"><a href="/event/eventmain.asp?eventid=92841" target="_top">vol.18</a></li>
			<% End If %>

			<% if currentdate < "2019-03-12" then %>
			<li class="swiper-slide next">vol.19</li>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="93135"," current","")%>"><a href="/event/eventmain.asp?eventid=93135" target="_top">vol.19</a></li>
			<% End If %>

			<% if currentdate < "2019-04-09" then %>
			<li class="swiper-slide next">vol.20</li>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="93391"," current","")%>"><a href="/event/eventmain.asp?eventid=93391" target="_top">vol.20</a></li>
			<% End If %>

			<% if currentdate < "2019-04-23" then %>
			<li class="swiper-slide next">vol.21</li>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="94003"," current","")%>"><a href="/event/eventmain.asp?eventid=94003" target="_top">vol.21</a></li>
			<% End If %>

			<% if currentdate < "2019-05-08" then %>
			<li class="swiper-slide next">vol.22</li>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="94324"," current","")%>"><a href="/event/eventmain.asp?eventid=94324" target="_top">vol.22</a></li>
			<% End If %>
		</ul>
	</div>
	<button class="btnPrev"><img src="http://webimage.10x10.co.kr/eventIMG/2018/88664/btn_prev.png" alt="이전" /></button>
	<button class="btnNext"><img src="http://webimage.10x10.co.kr/eventIMG/2018/88664/btn_next.png" alt="다음" /></button>
</div>
</body>
</html>