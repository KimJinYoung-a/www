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
	If vEventID = "000000" Then '// 1월
		vStartNo = "0"
	ElseIf vEventID = "116853" Then '// 2월
		vStartNo = "0"
	ElseIf vEventID = "117097" Then '// 3월
		vStartNo = "1"
	ElseIf vEventID = "" Then '// 4월
		vStartNo = "2"
	ElseIf vEventID = "" Then '// 5월
		vStartNo = "3"
	ElseIf vEventID = "" Then '// 6월
		vStartNo = "4"
	ElseIf vEventID = "" Then '// 7월
		vStartNo = "5"
	ElseIf vEventID = "" Then '// 8월
		vStartNo = "6"
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
			<% if currentdate < "2022-01-15" then %>
			<li class="swiper-slide coming"><span><b>#1월의</b>파우치</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="000000"," current","")%>"><a href="/event/eventmain.asp?eventid=000000" target="_top"><b>#1월의</b>파우치</a>
			<% End If %>
			</li>

			<% if currentdate < "2022-02-15" then %>
			<li class="swiper-slide coming"><span><b>#2월의</b>파우치</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="116853"," current","")%>"><a href="/event/eventmain.asp?eventid=116853" target="_top"><b>#2월의</b>파우치</a>
			<% End If %>
			</li>

			<% if currentdate < "2022-03-14" then %>
			<li class="swiper-slide coming"><span><b>#3월의</b>파우치</span>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="117097"," current","")%>"><a href="/event/eventmain.asp?eventid=117097" target="_top"><b>#3월의</b>파우치</a>
			<% End If %>
            </li>

			
		</ul>
    </div>
    <button class="btn-prev">이전</button>
	<button class="btn-next">다음</button>
</div>
</body>
</html>