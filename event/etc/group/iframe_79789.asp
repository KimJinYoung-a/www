<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 핑크스타그램2
' History : 2017-08-09 유태욱 생성
'####################################################
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<%
dim currentdate
	currentdate = date()
	'currentdate = "2017-08-14"

	Dim vEventID, vStartNo
	vEventID = requestCheckVar(Request("eventid"),9)
	If vEventID = "79660" Then
		vStartNo = "0"
	ElseIf vEventID = "79789" Then
		vStartNo = "0"
	ElseIf vEventID = "79931" Then
		vStartNo = "0"
	ElseIf vEventID = "79988" Then
		vStartNo = "0"
	ElseIf vEventID = "80212" Then
		vStartNo = "1"
	ElseIf vEventID = "81371" Then
		vStartNo = "2"
	ElseIf vEventID = "82474" Then
		vStartNo = "3"
	ElseIf vEventID = "83112" Then
		vStartNo = "4"
	ElseIf vEventID = "83997" Then
		vStartNo = "6"
	ElseIf vEventID = "84271" Then
		vStartNo = "6"
	else
		vStartNo = "0"
	End IF
%>
<style type="text/css">
.pinkSeries {background-color:#e13874;}
.pinkSeries .swiper {overflow:hidden; position:relative; width:920px; height:84px; padding:0 50px; margin:0 auto;}

.pinkSeries .swiper .swiper-wrapper {overflow:hidden;}
.pinkSeries .swiper .swiper-slide {float:left; position:relative; width:83px !important; height:84px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2018/84271/bg_nav.png?v=1);}
.pinkSeries .swiper .swiper-slide.on,
.pinkSeries .swiper .swiper-slide.open {padding-right:8px;}
.pinkSeries .swiper .swiper-slide:after {display:inline-block; position:absolute; top:24px; right:0; content:' '; width:2px; height:36px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/79789/bg_nav_v5.png?v=1) no-repeat  -832px -192px;}
.pinkSeries .swiper .swiper-slide.on:after,
.pinkSeries .swiper .swiper-slide.open:after {display:none;}

.pinkSeries .swiper .pink-slide-1 {background-position:-8px -160px;}
.pinkSeries .swiper .pink-slide-1.on,
.pinkSeries .swiper .pink-slide-1.open{width:175px !important;}
.pinkSeries .swiper .pink-slide-1.on {background-position:0 0;}
.pinkSeries .swiper .pink-slide-1.open { background-position:0 -84px;}

.pinkSeries .swiper .pink-slide-2 {background-position:-88px -160px;}
.pinkSeries .swiper .pink-slide-2.on,
.pinkSeries .swiper .pink-slide-2.open{width:179px !important;}
.pinkSeries .swiper .pink-slide-2.on {background-position:-185px 0;}
.pinkSeries .swiper .pink-slide-2.open { background-position:-185px -84px;}

.pinkSeries .swiper .pink-slide-3 {background-position:-170px -160px;}
.pinkSeries .swiper .pink-slide-3.on,
.pinkSeries .swiper .pink-slide-3.open{width:163px !important;}
.pinkSeries .swiper .pink-slide-3.on {background-position:-371px 0;}
.pinkSeries .swiper .pink-slide-3.open { background-position:-371px -84px;}

.pinkSeries .swiper .pink-slide-4 {background-position:-252px -160px;}
.pinkSeries .swiper .pink-slide-4.on,
.pinkSeries .swiper .pink-slide-4.open{width:149px !important;}
.pinkSeries .swiper .pink-slide-4.on {background-position:-543px 0;}
.pinkSeries .swiper .pink-slide-4.open { background-position:-543px -84px;}

.pinkSeries .swiper .pink-slide-5 {background-position:-336px -160px;}
.pinkSeries .swiper .pink-slide-5.on,
.pinkSeries .swiper .pink-slide-5.open{width:239px !important;}
.pinkSeries .swiper .pink-slide-5.on {background-position:-700px 0;}
.pinkSeries .swiper .pink-slide-5.open { background-position:-700px -84px;}

.pinkSeries .swiper .pink-slide-6 {background-position:-418px -160px;}
.pinkSeries .swiper .pink-slide-6.on,
.pinkSeries .swiper .pink-slide-6.open{width:209px !important;}
.pinkSeries .swiper .pink-slide-6.on {background-position:-947px 0;}
.pinkSeries .swiper .pink-slide-6.open {background-position:-947px -84px;}

.pinkSeries .swiper .pink-slide-7 {background-position:-500px -160px;}
.pinkSeries .swiper .pink-slide-7.on,
.pinkSeries .swiper .pink-slide-7.open{width:223px !important;}
.pinkSeries .swiper .pink-slide-7.on {background-position:-1166px 0;}
.pinkSeries .swiper .pink-slide-7.open {background-position:-1166px -84px;}

.pinkSeries .swiper .pink-slide-8 {background-position:-583px -160px;}
.pinkSeries .swiper .pink-slide-8.on,
.pinkSeries .swiper .pink-slide-8.open{width:224px !important;}
.pinkSeries .swiper .pink-slide-8.on {background-position:-1400px 0;}
.pinkSeries .swiper .pink-slide-8.open {background-position:-1400px -84px;}

.pinkSeries .swiper .pink-slide-9 {background-position:-665px -160px;}
.pinkSeries .swiper .pink-slide-9.on,
.pinkSeries .swiper .pink-slide-9.open{width:210px !important;}
.pinkSeries .swiper .pink-slide-9.on {background-position:-1634px 0;}
.pinkSeries .swiper .pink-slide-9.open {background-position:-1634px -84px;}

.pinkSeries .swiper .pink-slide-10 {background-position:-665px -160px;}
.pinkSeries .swiper .pink-slide-10.on,
.pinkSeries .swiper .pink-slide-10.open{width:210px !important;}
.pinkSeries .swiper .pink-slide-10.on {background-position:-1852px 0;}
.pinkSeries .swiper .pink-slide-10.open {background-position:-1852px -84px;}

.pinkSeries .swiper .pink-slide-10 {background-position:-746px -160px;}
.pinkSeries .swiper .pink-slide-10:after {display:none;}
.pinkSeries .swiper .swiper-slide a {display:inline-block; width:100%; height:100%; text-indent:-999em;}

.pinkSeries .btn-nav {position:absolute; top:0; width:30px; height:84px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/79789/btn_nav.png) no-repeat 0 50%; text-indent:-9999em;}
.pinkSeries .btn-prev {left:78px;}
.pinkSeries .btn-next {right:78px; background-position:100% 50%;}

</style>
<script type="text/javascript">
	$(function(){
		var swiper1 = new Swiper('.pinkSeries .swiper-container',{
			initialSlide:<%=vStartNo%>,
			slidesPerView: 'auto',
			loop:false,
			speed:800,
			simulateTouch:false,
			slidesPerView:'auto'
		});
		$(".btn-prev").on("click", function(e){
			e.preventDefault()
			swiper1.swipePrev()
		})
		$(".btn-next").on("click", function(e){
			e.preventDefault()
			swiper1.swipeNext()
		});
	});
</script>
</head>
<body>
	<!-- pinkStagram -->
	<div class="pinkSeries rolling">
		<div class="swiper">
			<div class="swiper-container">
				<ul class="swiper-wrapper">
					<!-- for dev msg // 오픈된 탭 :open // 현재탭 :on -->

					<li class="swiper-slide pink-slide-1 <% if vEventID = "79660" then %> on <% elseif currentdate >= "2017-08-03" Then %> open<% end if %>">
						<a href="/event/eventmain.asp?eventid=79660" target="_top">01 # 멍멍이쿨매트</a>
					</li>
					<li class="swiper-slide pink-slide-2 <% if vEventID = "79789" then %> on <% elseif currentdate >= "2017-08-10" Then %> open<% end if %>">
						<% If currentdate >= "2017-08-10" Then %>
							<a href="/event/eventmain.asp?eventid=79789" target="_top">02 # FRITZ 콜드브루</a>
						<% else %>
							<a href="" onclick="return false;">02</a>
						<% end if %>
					</li>
					<li class="swiper-slide pink-slide-3 <% if vEventID = "79931" then %> on <% elseif currentdate >= "2017-08-17" Then %> open<% end if %>">
						<% If currentdate >= "2017-08-17" Then %>
							<a href="/event/eventmain.asp?eventid=79931" target="_top">03 #BIC핑크볼펜</a>
						<% else %>
							<a href="" onclick="return false;">03</a>
						<% end if %>
					</li>
					<li class="swiper-slide pink-slide-4 <% if vEventID = "79988" then %> on <% elseif currentdate >= "2017-08-24" Then %> open<% end if %>">
						<% If currentdate >= "2017-08-24" Then %>
							<a href="/event/eventmain.asp?eventid=79988" target="_top">04 #미미츠보씰</a>
						<% else %>
							<a href="" onclick="return false;">04</a>
						<% end if %>
					</li>
					<li class="swiper-slide pink-slide-5 <% if vEventID = "80212" then %> on <% elseif currentdate >= "2017-08-31" Then %> open<% end if %>">
						<% If currentdate >= "2017-08-31" Then %>
							<a href="/event/eventmain.asp?eventid=80212" target="_top">05#미드나잇인서울</a>
						<% else %>
							<a href="" onclick="return false;">05</a>
						<% end if %>
					</li>
					<li class="swiper-slide pink-slide-6 <% if vEventID = "81371" then %> on <% elseif currentdate >= "2017-10-25" Then %> open<% end if %>">
						<% If currentdate >= "2017-10-25" Then %>
							<a href="/event/eventmain.asp?eventid=81371" target="_top">06#백설공주 애플블랙티</a>
						<% else %>
							<a href="" onclick="return false;">06</a>
						<% end if %>
					</li>
					<li class="swiper-slide pink-slide-7 <% if vEventID = "82474" then %> on <% elseif currentdate >= "2017-11-29" Then %> open<% end if %>">
						<% If currentdate >= "2017-11-29" Then %>
							<a href="/event/eventmain.asp?eventid=82474" target="_top">07</a>
						<% else %>
							<a href="" onclick="return false;">07</a>
						<% end if %>
					</li>
					<li class="swiper-slide pink-slide-8 <% if vEventID = "83112" then %> on <% elseif currentdate >= "2017-12-21" Then %> open<% end if %>">
						<% If currentdate >= "2017-12-21" Then %>
							<a href="/event/eventmain.asp?eventid=83112" target="_top">08 #인테이크 핑크 칼로리컷</a>
						<% else %>
							<a href="" onclick="return false;">08</a>
						<% end if %>
					</li>
					<li class="swiper-slide pink-slide-9 <% if vEventID = "83997" then %> on <% elseif currentdate >= "2018-01-30" Then %> open<% end if %>">
						<% If currentdate >= "2018-01-30" Then %>
							<a href="/event/eventmain.asp?eventid=83997" target="_top">09 #어반약과 핑크에디션 핑크에디션</a>
						<% else %>
							<a href="" onclick="return false;">09</a>
						<% end if %>
					</li>
					<li class="swiper-slide pink-slide-10 <% if vEventID = "84271" then %> on <% elseif currentdate >= "2018-02-05" Then %> open<% end if %>">
						<% If currentdate >= "2017-02-05" Then %>
							<a href="" target="_top">10 #위니비니 핑크에디션</a>
						<% else %>
							<a href="" onclick="return false;">10</a>
						<% end if %>
					</li>
				</ul>
			</div>
		</div>
		<button type="button" class="btn-nav btn-prev">Previous</button>
		<button type="button" class="btn-nav btn-next">Next</button>
	</div>
</body>
</html>