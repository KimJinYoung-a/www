<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
dim currentdate
	currentdate = date()
	'currentdate = "2017-08-22"
	
	'response.write currentdate

	Dim vEventID, vStartNo
	vEventID = requestCheckVar(Request("eventid"),9)
	If vEventID = "82559" Then
		vStartNo = "0"
	ElseIf vEventID = "82825" Then
		vStartNo = "0"
	ElseIf vEventID = "83060" Then
		vStartNo = "0"
	ElseIf vEventID = "83514" Then
		vStartNo = "1"
	End If
	
%>
<%
'#######################################################################
'	작업자 전달 사항
'
'	* 어드민에 소스 넣을때 뭐뭐뭐.asp 뒤에 ?eventid=코드 꼭 넣으세요!!
'	* 이 페이지에 소스 수정시 몇 탄이벤트코드 에 해당 코드 넣어주면 됩니다.
'
'#######################################################################
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
.navigator {position:relative; width:1140px; height:42px;}
.navigator:after {content:' '; display:block; clear:both;}
.navigator h1 {float:left; padding-top:9px;}
.navigator .nav {float:right; position:relative; width:198px; padding-left:50px;}
.nav .swiper-container {overflow:hidden; width:171px;}
.nav .swiper-slide {float:left; width:42px; height:42px;}
.nav .swiper-slide:first-child {margin-left:0;}
.nav a, .nav .coming {display:block; position:relative; width:42px; height:42px;}
.nav .bg {position:absolute; top:0; left:0; width:100%; height:100%; background:#fff url(http://webimage.10x10.co.kr/eventIMG/2017/82559/img_navigator_v3.gif) no-repeat 0 0;}
.nav a .bg {cursor:pointer;}
.nav a:hover .bg,
.nav .on .bg {background-position:0 100%;}
.nav .nav2 span {background-position:-42px 0;}
.nav .nav2 a:hover .bg,
.nav .nav2 .on .bg {background-position:-42px 100%;}

.nav .nav3 span {background-position:-84px 0;}
.nav .nav3 a:hover .bg,
.nav .nav3 .on .bg {background-position:-84px 100%;}

.nav .nav4 span {background-position:-126px 0;}
.nav .nav4 a:hover .bg,
.nav .nav4 .on .bg {background-position:-126px 100%;}

.nav .nav5 span {background-position:-168px 0;}
.nav .nav5 a:hover .bg,
.nav .nav5 .on .bg {background-position:-168px 100%;}

.nav .nav6 span {background-position:-210px 0;}
.nav .nav6 a:hover .bg,
.nav .nav6 .on .bg {background-position:-210px 100%;}


.nav .btn-nav {position:absolute; top:0; width:40px; height:42px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/82559/btn_tab_nav.gif) no-repeat 0 0; text-indent:-9999em; outline:none;}
.nav .btn-prev {left:0;}
.nav .btn-next {right:-15px; background-position:100% 0;}
</style>
</head>
<body>
<div class="navigator">
	<h1><img src="http://webimage.10x10.co.kr/eventIMG/2017/82559/txt_diary_journal.gif" alt="Log your life Diary Journal" /></h1>
	<div id="nav" class="nav">
		<div class="swiper-container">
			<ul class="swiper-wrapper">
				<li class="swiper-slide nav1"><a href="/event/eventmain.asp?eventid=82559" target="_top" <%=CHKIIF(vEventID="82559"," class='on'","")%>><span class="bg"></span>01 from 529</a></li>

				<% if currentdate < "2017-12-07" then %>
				<li class="swiper-slide nav2"><span class="coming"><span class="bg"></span>02</span></li>
				<% Else %>
				<li class="swiper-slide nav2"><a href="/event/eventmain.asp?eventid=82825" target="_top" <%=CHKIIF(vEventID="82825"," class='on'","")%>><span class="bg"></span>02 초은</a></li>
				<% End If %>

				<% if currentdate < "2017-12-19" then %>
				<li class="swiper-slide nav3"><span class="coming"><span class="bg"></span>03</span></li>
				<% Else %>
				<li class="swiper-slide nav3"><a href="/event/eventmain.asp?eventid=83060" target="_top" <%=CHKIIF(vEventID="83060"," class='on'","")%>><span class="bg"></span>03 밀키웨이</a></li>
				<% End If %>

				<% if currentdate < "2018-01-10" then %>
				<li class="swiper-slide nav4"><span class="coming"><span class="bg"></span>04</span></li>
				<% Else %>
				<li class="swiper-slide nav4"><a href="/event/eventmain.asp?eventid=83514" target="_top" <%=CHKIIF(vEventID="83514"," class='on'","")%>><span class="bg"></span>04 HEE EUN LEE</a></li>
				<% End If %>

				<li class="swiper-slide nav5"><span class="coming"><span class="bg"></span>05</span></li>
				<li class="swiper-slide nav6"><span class="coming"><span class="bg"></span>06</span></li>
			</ul>
		</div>
		<button type="button" class="btn-nav btn-prev">Previous</button>
		<button type="button" class="btn-nav btn-next">Next</button>
	</div>
</div>
</body>
<script type="text/javascript">
$(function(){
	/* swipe */
	if ($("#nav .swiper-container .swiper-slide").length > 3) {
		var navSwiper = new Swiper("#nav .swiper-container",{
			initialSlide:<%=vStartNo%>,
			loop:false,
			speed:700,
			autoplay:false,
			slidesPerView:3,
			simulateTouch:false,
		});
	} else {
		$("#nav .btn-nav").hide();
		var navSwiper = new Swiper("#nav .swiper-container",{
			initialSlide:<%=vStartNo%>,
			loop:false,
			speed:700,
			autoplay:false,
			slidesPerView:3,
			simulateTouch:false,
		});
	}

	$("#nav .btn-prev").on("click", function(e){
		e.preventDefault();
		navSwiper.swipePrev();
	})
	$("#nav .btn-next").on("click", function(e){
		e.preventDefault();
		navSwiper.swipeNext();
	});

	$("#nav .swiper-slide .coming").click(function(){
		alert("coming soon");
	});
});
</script>
</html>