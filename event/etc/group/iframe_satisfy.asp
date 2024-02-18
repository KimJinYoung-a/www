<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/inc/head.asp" -->
<%
dim currentdate
	currentdate = date()
	'currentdate = "2019-11-01"
	'response.write currentdate

	Dim vEventID, vStartNo
	vEventID = requestCheckVar(Request("eventid"),9)
	If vEventID = "97475" Then '// 10월
		vStartNo = "0"
	ElseIf vEventID = "97927" Then '// 11월
		vStartNo = "0"
	ElseIf vEventID = "98890" Then '// 12월
		vStartNo = "1"
	ElseIf vEventID = "99782" Then '// 1월
		vStartNo = "2"
	ElseIf vEventID = "100368" Then '// 2월
		vStartNo = "3"
	ElseIf vEventID = "100920" Then '// 3월
		vStartNo = "4"
	ElseIf vEventID = "" Then '// 4월
		vStartNo = "5"
	ElseIf vEventID = "" Then '// 5월
		vStartNo = "6"
	ElseIf vEventID = "" Then '// 6월
		vStartNo = "7"
	else
		vStartNo = "0"
	End IF
%>
<style type="text/css">
.monthTab {position:relative; overflow:hidden; width:390px; height:40px; padding:0 20px;}
.monthTab .swiper-container {height:40px}
.monthTab ul li {float:left;}
.monthTab ul li a {overflow:hidden; position:relative; display:flex; justify-content:center; align-items:center; width:130px; height:40px; color:#777; font-size:13px; text-decoration:none; white-space:nowrap; letter-spacing:-0.01em;}
.monthTab ul li a strong {overflow:hidden; margin-left:5px; font-weight:400; text-overflow:ellipsis;}
.monthTab ul li.current a {color:#000;}
.monthTab ul li.current a::after {content:''; position:absolute; left:0; bottom:0; width:100%; height:3px; background:#000;}
.monthTab button {display:inline-block; position:absolute; top:0; z-index:10; width:20px; height:40px; outline:none; background-color:transparent; background:url(//webimage.10x10.co.kr/fixevent/event/2019/97927/btn_date_nav.png) no-repeat 0 50%; text-indent:-999em;}
.monthTab .btnPrev {left:0;}
.monthTab .btnNext {right:0; transform:scaleX(-1);}
</style>
<script type="text/javascript">
$(function(){
	var evtSwiper = new Swiper('.monthTab .swiper-container',{
		initialSlide:<%=vStartNo%>,
		slidesPerView:3,
		speed:300
	});
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
		alert("오픈 예정 기획전 입니다 :)");
	});
});
</script>
</head>
<body>
<div class="monthTab">
	<div class="swiper-container">
		<ul class="swiper-wrapper">
			<%' 오픈된 이벤트 open, 오늘 날짜에 current 클래스 넣어주세요 %>
			<% if currentdate < "2019-10-01" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="97475"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=97475" target="_top">#10월호<strong>다독多讀</strong></a>
			</li>

			<% if currentdate < "2019-11-01" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="97927"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=97927" target="_top">#11월호<strong>깊은 잠</strong></a>
			</li>

			<% if currentdate < "2019-12-02" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="98890"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=98890" target="_top">#12월호<strong>Winter 'Home'liday</strong></a>
			</li>

			<% if currentdate < "2020-01-02" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="99782"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=99782" target="_top">#1월호<strong>새해 목표</strong></a>
			</li>

			<% if currentdate < "2020-02-04" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="100368"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=100368" target="_top">#2월호<strong>새해 새집 새방</strong></a>
			</li>

			<% if currentdate < "2020-03-03" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="100920"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=100920" target="_top">#3월호<strong>집 밖은 위험해</strong></a>
			</li>

			<% if currentdate < "2020-12-01" then %>
			<li class="swiper-slide coming">
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="000000"," current","")%>">
			<% End If %>
				<a href="/event/eventmain.asp?eventid=000000" target="_top">#4월호<strong></strong></a>
			</li>

		</ul>
	</div>
	<button class="btnPrev">이전</button>
	<button class="btnNext">다음</button>
</div>
</body>
</html>