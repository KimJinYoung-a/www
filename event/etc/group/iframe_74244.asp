<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
dim currentdate
	currentdate = date()
	'currentdate = "2016-10-24"
	
	'response.write currentdate
%>
<%
'#######################################################################
'	작업자 전달 사항
'
'	* 어드민에 소스 넣을때 뭐뭐뭐.asp 뒤에 ?eventid=코드 꼭 넣으세요!!
'	* 이 페이지에 소스 수정시 몇 탄이벤트코드 에 해당 코드 넣어주면 됩니다.
'
'#######################################################################
	Dim vEventID, vStartNo
	vEventID = requestCheckVar(Request("eventid"),9)

	If vEventID = "74244" Then
		vStartNo = "0"
	ElseIf vEventID = "74357" Then
		vStartNo = "0"
	ElseIf vEventID = "74358" Then
		vStartNo = "0"
	ElseIf vEventID = "74359" Then
		vStartNo = "0"
	ElseIf vEventID = "74428" Then
		vStartNo = "3"
	ElseIf vEventID = "74429" Then
		vStartNo = "4"
	ElseIf vEventID = "74430" Then
		vStartNo = "4"
	ElseIf vEventID = "74530" Then
		vStartNo = "5"
	ElseIf vEventID = "74532" Then
		vStartNo = "5"
	ElseIf vEventID = "74573" Then
		vStartNo = "5"
	else
		vStartNo = "0"
	End IF

%>
<!-- #include virtual="/lib/inc/head.asp" -->
</head>
<body>
<script>
$(function(){
	var dateSwiper = new Swiper('.navList .swiper-container',{
		initialSlide:<%=vStartNo%>,
		slidesPerView:5,
		//slidesPerGroup:5,
		speed:600,
		pagination:false,
		nextButton:'.navList .btnNext',
		prevButton:'.navList .btnPrev'
	});
	$('.navList .btnPrev').on('click', function(e){
		e.preventDefault();
		dateSwiper.swipePrev();
	});
	$('.navList .btnNext').on('click', function(e){
		e.preventDefault();
		dateSwiper.swipeNext();
	});
});
</script>
<style>
.navList .swiper-container {width:1025px; height:122px; margin:0 auto;}
.navList li {position:relative; float:left; width:132px !important; height:92px; margin:0 36px 0 37px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/74244/txt_nav_v2.png) 0 0 no-repeat;}
.navList li span {display:block; width:132px; height:122px; margin:0 auto; background:url(http://webimage.10x10.co.kr/eventIMG/2016/74244/txt_nav_v2.png) 0 0 no-repeat;text-indent:-999em;}
.navList li.date1115 {background-position:-132px 0;}
.navList li.date1116 {background-position:-264px 0;}
.navList li.date1117 {background-position:-396px 0;}
.navList li.date1118 {background-position:-528px 0;}
.navList li.date1121 {background-position:-660px 0;}
.navList li.date1122 {background-position:-792px 0;}
.navList li.date1123 {background-position:-928px 0;}
.navList li.date1124 {background-position:-1058px 0;}
.navList li.date1125 {background-position:-1188px 0;}
.navList li.date1114.open span {background-position:0 -122px;}
.navList li.date1115.open span {background-position:-132px -122px;}
.navList li.date1116.open span {background-position:-264px -122px;}
.navList li.date1117.open span {background-position:-396px -122px;}
.navList li.date1118.open span {background-position:-528px -122px;}
.navList li.date1121.open span {background-position:-660px -122px;}
.navList li.date1122.open span {background-position:-792px -122px;}
.navList li.date1123.open span {background-position:-928px -122px;}
.navList li.date1124.open span {background-position:-1067px -122px;}
.navList li.date1125.open span {background-position:-1198px -122px;}
.navList li.date1114.today span {background-position:0 100%;}
.navList li.date1115.today span {background-position:-132px 100%;}
.navList li.date1116.today span {background-position:-264px 100%;}
.navList li.date1117.today span {background-position:-396px 100%;}
.navList li.date1118.today span {background-position:-528px 100%;}
.navList li.date1121.today span {background-position:-660px 100%;}
.navList li.date1122.today span {background-position:-792px 100%;}
.navList li.date1123.today span {background-position:-928px 100%;}
.navList li.date1124.today span {background-position:-1067px 100%;}
.navList li.date1125.today span {background-position:-1198px 100%;}
.navList li.open, .navList li.today {background:none;}
.navList li a {display:block; height:100%; text-indent:-999em;}
.navList button {position:absolute; top:13px; background:transparent;}
.navList .btnPrev {left:0;}
.navList .btnNext {right:0;}
</style>
	<div class="navList">
		<div class="swiper-container">
			<ul class="swiper-wrapper">
				<!-- for dev msg : 오픈된 페이지 open, 오늘날짜 탭에는 today  클래스 붙여주세요-->
				<li class="swiper-slide date1114 open"><span>11.14(월) INVETE.L</span></li>

				<% if currentdate <> "2016-11-15" then %>
					<li class="swiper-slide date1115 <%=CHKIIF(currentdate < "2016-11-16",""," open")%>"><span>11.15(화) ICONIC</span></li>
				<% else %>
					<li class="swiper-slide date1115 open <%=CHKIIF(vEventID="74357"," today","")%>"><span><a href="/event/eventmain.asp?eventid=74357" target="_top">11.15(화) ICONIC</a></span></li>
				<% end if %>

				<% if currentdate <> "2016-11-16" then %>
					<li class="swiper-slide date1116 <%=CHKIIF(currentdate < "2016-11-17",""," open")%>"><span>11.16(수) LIVEWORK</span></li>
				<% else %>
					<li class="swiper-slide date1116 open <%=CHKIIF(vEventID="74358"," today","")%>"><span><a href="/event/eventmain.asp?eventid=74358" target="_top">11.16(수) LIVEWORK</span></a></li>
				<% end if %>

				<% if currentdate <> "2016-11-17" then %>
					<li class="swiper-slide date1117 <%=CHKIIF(currentdate < "2016-11-18",""," open")%>"><span>11.17(목) ARDIUM</span></li>
				<% else %>
					<li class="swiper-slide date1117 open <%=CHKIIF(vEventID="74359"," today","")%>"><span><a href="/event/eventmain.asp?eventid=74359" target="_top">11.17(목) ARDIUM</a></span></li>
				<% end if %>

				<% if currentdate <> "2016-11-18" then %>
					<li class="swiper-slide date1118 <%=CHKIIF(currentdate < "2016-11-19",""," open")%>"><span>11.18(금) TIUM</a></li>
				<% else %>
					<li class="swiper-slide date1118 open <%=CHKIIF(vEventID="74428"," today","")%>"><span><a href="/event/eventmain.asp?eventid=74428" target="_top">11.18(금) TIUM</a></span></li>
				<% end if %>

				<% if currentdate <> "2016-11-21" then %>
					<li class="swiper-slide date1121 <%=CHKIIF(currentdate < "2016-11-22",""," open")%>"><span>11.21(월) LAMY</a></li>
				<% else %>
					<li class="swiper-slide date1121 open <%=CHKIIF(vEventID="74429"," today","")%>"><span><a href="/event/eventmain.asp?eventid=74429" target="_top">11.21(월) LAMY</a></span></li>
				<% end if %>

				<% if currentdate <> "2016-11-22" then %>
					<li class="swiper-slide date1122 <%=CHKIIF(currentdate < "2016-11-23",""," open")%>"><span>11.22(화) MMMG</span></li>
				<% else %>
					<li class="swiper-slide date1122 open <%=CHKIIF(vEventID="74430"," today","")%>"><span><a href="/event/eventmain.asp?eventid=74430" target="_top">11.22(화) MMMG</a></span></li>
				<% end if %>

				<% if currentdate <> "2016-11-23" then %>
					<li class="swiper-slide date1123 <%=CHKIIF(currentdate < "2016-11-24",""," open")%>"><span>11.23(수)</span></li>
				<% else %>
					<li class="swiper-slide date1123 open <%=CHKIIF(vEventID="74530"," today","")%>"><span><a href="/event/eventmain.asp?eventid=74530" target="_top">11.23(수)</a></span></li>
				<% end if %>

				<% if currentdate <> "2016-11-24" then %>
					<li class="swiper-slide date1124 <%=CHKIIF(currentdate < "2016-11-25",""," open")%>"><span>1.24(목)</span></li>
				<% else %>
					<li class="swiper-slide date1124 open <%=CHKIIF(vEventID="74532"," today","")%>"><span><a href="/event/eventmain.asp?eventid=74532" target="_top">11.24(목)</a></span></li>
				<% end if %>

				<% if currentdate <> "2016-11-25" then %>
					<li class="swiper-slide date1125 <%=CHKIIF(currentdate < "2016-11-26",""," open")%>"><span>11.25(금)</span></li>
				<% else %>
					<li class="swiper-slide date1125 open <%=CHKIIF(vEventID="74573"," today","")%>"><span><a href="/event/eventmain.asp?eventid=74573" target="_top">11.25(금)</a></span></li>
				<% end if %>
			</ul>
		</div>
		<button class="btnPrev"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74244/btn_prev.png" alt="이전" /></button>
		<button class="btnNext"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74244/btn_next.png" alt="다음" /></button>
	</div>
</body>
</html>