<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
dim currentdate
	currentdate = date()
	'currentdate = "2015-03-09"
	
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

	If vEventID = "72841" Then
		vStartNo = "0"
	ElseIf vEventID = "72913" Then
		vStartNo = "0"
	ElseIf vEventID = "72914" Then
		vStartNo = "0"
	ElseIf vEventID = "72915" Then
		vStartNo = "0"
	ElseIf vEventID = "72916" Then
		vStartNo = "1"
	ElseIf vEventID = "72918" Then
		vStartNo = "2"
	ElseIf vEventID = "72919" Then
		vStartNo = "2"
	End IF
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
.hidden {visibility:hidden; width:0; height:0; overflow:hidden; position:absolute; top:-1000%; line-height:0;}

.rolling {position:relative; width:1140px; margin:0 auto;}
.rolling .line {position:absolute; top:0; right:45px; z-index:5; width:1px; height:130px; background-color:#fff;}
.rolling .swiper {overflow:hidden; position:relative; width:1050px; margin:0 auto;}
.rolling .swiper-container {overflow:hidden; width:1050px; height:130px;}
.rolling .swiper-wrapper {position:relative;}
.rolling .swiper .swiper-slide {overflow:hidden; float:left; width:210px !important; height:130px;}
.rolling .swiper .swiper-slide a,
.rolling .swiper .swiper-slide .coming {display:block; position:relative; width:100%; height:100%; line-height:130px;}
.rolling .swiper .swiper-slide a span, 
.rolling .swiper .swiper-slide .coming span {display:block; position:absolute; top:0; left:0; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2016/72841/img_navigator_v7.png) no-repeat 0 0;}
.rolling .swiper .swiper-slide a span {background-position:0 -130px; cursor:pointer;}
.rolling .swiper .swiper-slide a:hover span, .rolling .swiper .swiper-slide a.on span {background-position:0 100%;}

.rolling .swiper .nav2 a span {background-position:-210px -130px;}
.rolling .swiper .nav2 .coming span {background-position:-210px 0;}
.rolling .swiper .nav2 a:hover span, .rolling .swiper .nav2 a.on span {background-position:-210px 100%;}

.rolling .swiper .nav3 a span {background-position:-420px -130px;}
.rolling .swiper .nav3 .coming span {background-position:-420px 0;}
.rolling .swiper .nav3 a:hover span, .rolling .swiper .nav3 a.on span {background-position:-420px 100%;}

.rolling .swiper .nav4 a span {background-position:-630px -130px;}
.rolling .swiper .nav4 .coming span {background-position:-630px 0;}
.rolling .swiper .nav4 a:hover span, .rolling .swiper .nav4 a.on span {background-position:-630px 100%;}

.rolling .swiper .nav5 a span {background-position:-840px -130px;}
.rolling .swiper .nav5 .coming span {background-position:-840px 0;}
.rolling .swiper .nav5 a:hover span, .rolling .swiper .nav5 a.on span {background-position:-840px 100%;}

.rolling .swiper .nav6 a span {background-position:-1050px -130px;}
.rolling .swiper .nav6 .coming span {background-position:-1050px 0;}
.rolling .swiper .nav6 a:hover span, .rolling .swiper .nav6 a.on span {background-position:-1050px 100%;}

.rolling .swiper .nav7 a span {background-position:100% -130px;}
.rolling .swiper .nav7 .coming span {background-position:100% 0;}
.rolling .swiper .nav7 a:hover span, .rolling .swiper .nav7 a.on span {background-position:100% 100%;}

.rolling .swiper .swiper-slide a i {visibility:hidden; position:absolute; bottom:0; left:50%; width:210px; height:4px; margin-left:-105px; background-color:#3d6587; transform:scaleX(0); transition:all 0.3s ease-in-out 0s;}
.rolling .swiper .swiper-slide a:hover i, .rolling .swiper .swiper-slide a.on i {visibility:visible; transform:scaleX(1);}
.rolling .swiper .nav2 a i {background-color:#ac2525;}
.rolling .swiper .nav3 a i {background-color:#7e5d96;}
.rolling .swiper .nav4 a i {background-color:#d25327;}
.rolling .swiper .nav5 a i {background-color:#327467;}
.rolling .swiper .nav6 a i {background-color:#b98739;}
.rolling .swiper .nav7 a i {background-color:#d6385f;}

.rolling .btn-nav {position:absolute; top:0; width:30px; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2016/72841/btn_nav_grey.png) no-repeat 50% 0; text-indent:-9999em;}
.rolling .btn-prev {left:16px;}
.rolling .btn-next {right:16px; background-position:50% 100%;}
</style>
</head>
<body>
	<div id="rolling" class="rolling">
		<h1 class="hidden">HOT BRAND WEEK</h1>
		<span class="line"></span>
		<div class="swiper">
			<div class="swiper-container swiper1">
				<ul class="swiper-wrapper">
					<li class="swiper-slide nav1">
						<a href="/event/eventmain.asp?eventid=72841" target="_top" <%=CHKIIF(vEventID="72841"," class='on'","")%>><span></span>비욘드 클로젯<i></i></a>
					</li>

					<% if currentdate < "2016-09-06" then %>
					<li class="swiper-slide nav2">
						<span class="coming"><span></span>9월 6일 화요일 coming soon</span>
					</li>
					<% Else %>
					<li class="swiper-slide nav2">
						<a href="/event/eventmain.asp?eventid=72913" target="_top" <%=CHKIIF(vEventID="72913"," class='on'","")%>><span></span>조셉앤스테이시<i></i></a>
					</li>
					<% End If %>

					<% if currentdate < "2016-09-07" then %>
					<li class="swiper-slide nav3">
						<span class="coming"><span></span>9월 7일 수요일 coming soon</span>
					</li>
					<% Else %>
					<li class="swiper-slide nav3">
						<a href="/event/eventmain.asp?eventid=72914" target="_top" <%=CHKIIF(vEventID="72914"," class='on'","")%>><span></span>카렌화이트<i></i></a>
					</li>
					<% End If %>

					<% if currentdate < "2016-09-08" then %>
					<li class="swiper-slide nav4">
						<span class="coming"><span></span>9월 8일 목요일 coming soon</span>
					</li>
					<% Else %>
					<li class="swiper-slide nav4">
						<a href="/event/eventmain.asp?eventid=72915" target="_top" <%=CHKIIF(vEventID="72915"," class='on'","")%>><span></span>지홍<i></i></a>
					</li>
					<% End If %>

					<% if currentdate < "2016-09-09" then %>
					<li class="swiper-slide nav5">
						<span class="coming"><span></span>9월 9일 금요일 coming soon</span>
					</li>
					<% Else %>
					<li class="swiper-slide nav5">
						<a href="/event/eventmain.asp?eventid=72916" target="_top" <%=CHKIIF(vEventID="72916"," class='on'","")%>><span></span>에이들<i></i></a>
					</li>
					<% End If %>

					<% if currentdate < "2016-09-12" then %>
					<li class="swiper-slide nav6">
						<span class="coming"><span></span>9월 12일 월요일 coming soon</span>
					</li>
					<% Else %>
					<li class="swiper-slide nav6">
						<a href="/event/eventmain.asp?eventid=72918" target="_top" <%=CHKIIF(vEventID="72918"," class='on'","")%>><span></span>화이트블랭크<i></i></a>
					</li>
					<% End If %>

					<% if currentdate < "2016-09-13" then %>
					<li class="swiper-slide nav7">
						<span class="coming"><span></span>9월 13일 월요일 coming soon</span>
					</li>
					<% Else %>
					<li class="swiper-slide nav7">
						<a href="/event/eventmain.asp?eventid=72919" target="_top" <%=CHKIIF(vEventID="72919"," class='on'","")%>><span></span>쎄쎄쎄<i></i></a>
					</li>
					<% End If %>
				</ul>
			</div>
		</div>
		<button type="button" class="btn-nav btn-prev">Previous</button>
		<button type="button" class="btn-nav btn-next">Next</button>
	</div>
</body>
<script type="text/javascript">
$(function(){
	var swiper1 = new Swiper("#rolling .swiper1",{
		initialSlide:<%=vStartNo%>,
		speed:800,
		simulateTouch:false,
		slidesPerView:"auto"
	});
	$("#rolling .btn-prev").on("click", function(e){
		e.preventDefault()
		swiper1.swipePrev()
	})
	$("#rolling .btn-next").on("click", function(e){
		e.preventDefault()
		swiper1.swipeNext()
	});
});
</script>
</html>