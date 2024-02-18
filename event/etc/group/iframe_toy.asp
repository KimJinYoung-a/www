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
'연미님 코맨트
'1. 24Line부터 시작하는 vEventID를 각 날짜에 맞게 넣어주세요. ex) 11/14일에 이벤트코드가 정해지면 29Line에 74068이 아닌 그 이벤트코드로 수정
'2. swiper-slide에 이벤트코드 수정해주세요. ex) 11/14일에 이벤트코드가 정해지면 121Line에 74068이 아닌 그 이벤트코드 수정과 내용 수정
'#######################################################################
	Dim vEventID, vStartNo
	vEventID = requestCheckVar(Request("eventid"),9)

	If vEventID = "73902" Then
		vStartNo = "0"
	ElseIf vEventID = "74068" Then
		vStartNo = "0"
	ElseIf vEventID = "74158" Then
		vStartNo = "0"
	ElseIf vEventID = "74402" Then
		vStartNo = "1"
	ElseIf vEventID = "74472" Then
		vStartNo = "2"
	ElseIf vEventID = "74684" Then
		vStartNo = "3"
	ElseIf vEventID = "74841" Then
		vStartNo = "4"
	ElseIf vEventID = "75040" Then			'8회차(12/19)
		vStartNo = "6"
	ElseIf vEventID = "75230" Then			'9회차(12/27)
		vStartNo = "6"
	End If
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
body {/*background-color:#ffe46e;*/}

.hidden {visibility:hidden; width:0; height:0; overflow:hidden; position:absolute; top:-1000%; line-height:0;}

/* navigator */
.rolling {position:relative; z-index:20;}
.rolling .swiper {overflow:hidden; position:relative; width:720px;}
.rolling .swiper-container {overflow:hidden; width:648px; height:290px; margin:0 auto;}
.rolling .swiper-wrapper {position:relative;}
.rolling .swiper .swiper-slide {overflow:hidden; float:left; width:142px !important; height:290px; margin:0 10px; text-align:center;}
.rolling .swiper .swiper-slide a,
.rolling .swiper .swiper-slide .coming {display:block; position:relative; width:100%; height:100%; line-height:400px;}
.rolling .swiper .swiper-slide a span, 
.rolling .swiper .swiper-slide .coming span {display:block; position:absolute; top:0; left:0; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2016/73902/img_navigator_v14.png) no-repeat 0 0;}
.rolling .swiper .swiper-slide a span {background-position:0 -290px; cursor:pointer;}
.rolling .swiper .swiper-slide a:hover span, .rolling .swiper .swiper-slide a.on span {background-position:0 100%;}

.rolling .swiper .nav2 a span {background-position:-162px -290px;}
.rolling .swiper .nav2 .coming span {background-position:-162px 0;}
.rolling .swiper .nav2 a:hover span,
.rolling .swiper .nav2 a.on span {background-position:-162px 100%;}

.rolling .swiper .nav3 a span {background-position:-322px -290px;}
.rolling .swiper .nav3 .coming span {background-position:-322px 0;}
.rolling .swiper .nav3 a:hover span, .rolling .swiper .nav3 a.on span {background-position:-322px 100%;}

.rolling .swiper .nav4 a span {background-position:-484px -290px;}
.rolling .swiper .nav4 .coming span {background-position:-484px 0;}
.rolling .swiper .nav4 a:hover span, .rolling .swiper .nav4 a.on span {background-position:-484px 100%;}

.rolling .swiper .nav5 a span {background-position:-646px -290px;}
.rolling .swiper .nav5 .coming span {background-position:-646px 0;}
.rolling .swiper .nav5 a:hover span, .rolling .swiper .nav5 a.on span {background-position:-646px 100%;}

.rolling .swiper .nav6 a span {background-position:-807px -290px;}
.rolling .swiper .nav6 .coming span {background-position:-807px 0;}
.rolling .swiper .nav6 a:hover span, .rolling .swiper .nav6 a.on span {background-position:-807px 100%;}

.rolling .swiper .nav7 a span {background-position:-969px -290px;}
.rolling .swiper .nav7 .coming span {background-position:-969px 0;}
.rolling .swiper .nav7 a:hover span, .rolling .swiper .nav7 a.on span {background-position:-969px 100%;}

.rolling .swiper .nav8 a span {background-position:-1130px -290px;}
.rolling .swiper .nav8 .coming span {background-position:-1130px 0;}
.rolling .swiper .nav8 a:hover span, .rolling .swiper .nav8 a.on span {background-position:-1130px 100%;}

.rolling .swiper .nav9 a span {background-position:100% -290px;}
.rolling .swiper .nav9 .coming span {background-position:100% 0;}
.rolling .swiper .nav9 a:hover span, .rolling .swiper .nav9 a.on span {background-position:100% 100%;}

.rolling .btnNav {position:absolute; top:168px; width:20px; height:121px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/73902/btn_nav.png) no-repeat 0 50%; text-indent:-9999em;}
.rolling .btnPrev {left:0;}
.rolling .btnNext {right:0; background-position:100% 50%;}
</style>
</head>
<body>
	<div id="navigator" class="rolling">
		<h1 class="hidden">아트토이 스토리</h1>
		<div class="swiper">
			<div class="swiper-container">
				<ul class="swiper-wrapper">
					<li class="swiper-slide nav1">
						<a href="/event/eventmain.asp?eventid=73902" target="_top" <%=CHKIIF(vEventID="73902"," class='on'","")%>><span></span>11월 2일 수요일 Sonny Angel</a>
					</li>

					<% if currentdate < "2016-11-07" then %>
					<li class="swiper-slide nav2">
						<span class="coming"><span></span>11월 7일 월요일 WHO&apos;s Next?</span>
					</li>
					<% Else %>
					<li class="swiper-slide nav2">
						<a href="/event/eventmain.asp?eventid=74068" target="_top" <%=CHKIIF(vEventID="74068"," class='on'","")%>><span></span>11월 7일 월요일 Superfiction</a>
					</li>
					<% End If %>

					<% If currentdate < "2016-11-14" Then %>
					<li class="swiper-slide nav3">
						<span class="coming"><span></span>11월 14일 월요일 WHO&apos;s Next?</span>
					</li>
					<% Else %>
					<li class="swiper-slide nav3">
						<a href="/event/eventmain.asp?eventid=74158" target="_top" <%=CHKIIF(vEventID="74158"," class='on'","")%>><span></span>11월 14일 월요일 Playmobil</a>
					</li>
					<% End If %>

					<% If currentdate < "2016-11-21" Then %>
					<li class="swiper-slide nav4">
						<span class="coming"><span></span>11월 21일 월요일 WHO&apos;s Next?</span>
					</li>
					<% Else %>
					<li class="swiper-slide nav4">
						<a href="/event/eventmain.asp?eventid=74402" target="_top" <%=CHKIIF(vEventID="74402"," class='on'","")%>><span></span>11월 21일 월요일 130BO</a>
					</li>
					<% End If %>

					<% If currentdate < "2016-11-28" Then %>
					<li class="swiper-slide nav5">
						<span class="coming"><span></span>11월 28일 월요일 WHO&apos;s Next?</span>
					</li>
					<% Else %>
					<li class="swiper-slide nav5">
						<a href="/event/eventmain.asp?eventid=74472" target="_top" <%=CHKIIF(vEventID="74472"," class='on'","")%>><span></span>11월 28일 월요일 seulgie</a>
					</li>
					<% End If %>

					<% If currentdate < "2016-12-07" Then %>
					<li class="swiper-slide nav6">
						<span class="coming"><span></span>12월 7일 수요일 WHO&apos;s Next?</span>
					</li>
					<% Else %>
					<li class="swiper-slide nav6">
						<a href="/event/eventmain.asp?eventid=74684" target="_top" <%=CHKIIF(vEventID="74684"," class='on'","")%>><span></span>12월 7일 수요일 무한도전과 SML</a>
					</li>
					<% End If %>

					<% If currentdate < "2016-12-12" Then %>
					<li class="swiper-slide nav7">
						<span class="coming"><span></span>12월 12일 월요일 WHO&apos;s Next?</span>
					</li>
					<% Else %>
					<li class="swiper-slide nav7">
						<a href="/event/eventmain.asp?eventid=74841" target="_top" <%=CHKIIF(vEventID="74841"," class='on'","")%>><span></span>12월 12일 월요일 DUCKOO </a>
					</li>
					<% End If %>
					
					<% If currentdate < "2016-12-19" Then %>
					<li class="swiper-slide nav8">
						<span class="coming"><span></span>12월 19일 월요일 WHO&apos;s Next?</span>
					</li>
					<% Else %>
					<li class="swiper-slide nav8">
						<a href="/event/eventmain.asp?eventid=75040" target="_top" <%=CHKIIF(vEventID="75040"," class='on'","")%>><span></span>12월 19일 월요일 Goolygooly</a>
					</li>
					<% End If %>

					<% If currentdate < "2016-12-27" Then %>
					<li class="swiper-slide nav9">
						<span class="coming"><span></span>12월 27 화요일 WHO&apos;s Next?</span>
					</li>
					<% Else %>
					<li class="swiper-slide nav9">
						<a href="/event/eventmain.asp?eventid=75230" target="_top" <%=CHKIIF(vEventID="75230"," class='on'","")%>><span></span>12월 27 화요일 COOLRAIN</a>
					</li>
					<% End If %>

				</ul>
			</div>
		</div>
		<button type="button" class="btnNav btnPrev">Previous</button>
		<button type="button" class="btnNav btnNext">Next</button>
	</div>
</body>
<script type="text/javascript">
$(function(){
	/* navigator */
	var swiper1 = new Swiper("#navigator .swiper-container",{
		initialSlide:<%=vStartNo%>,
		speed:1000,
		simulateTouch:false,
		slidesPerView:4
	});
	$("#navigator .btnPrev").on("click", function(e){
		e.preventDefault()
		swiper1.swipePrev()
	});
	$("#navigator .btnNext").on("click", function(e){
		e.preventDefault()
		swiper1.swipeNext()
	});
});
</script>
</html>