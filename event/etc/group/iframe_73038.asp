<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
dim currentdate
	currentdate = date()
	'currentdate = "2016-09-13"
	
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

	If vEventID = "73038" Then
		vStartNo = "0"
	ElseIf vEventID = "73039" Then
		vStartNo = "0"
	ElseIf vEventID = "73050" Then
		vStartNo = "0"
	ElseIf vEventID = "73137" Then
		vStartNo = "0"
	ElseIf vEventID = "73204" Then
		vStartNo = "2"
	ElseIf vEventID = "73205" Then
		vStartNo = "3"
	ElseIf vEventID = "73206" Then
		vStartNo = "3"
	ElseIf vEventID = "73207" Then
		vStartNo = "3"
	End IF
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
.earlyDiaryNav {position:relative; width:1140px; height:78px; margin:0 auto; z-index:1;}
.earlyDiaryNav .swiper-container {width:100%; height:78px;}
.earlyDiaryNav li {position:relative; float:left; width:228px; height:78px; background-position:50% 0; background-repeat:no-repeat; text-indent:-999em;}
.earlyDiaryNav li a {overflow:hidden; display:none; width:228px; height:78px; text-indent:-999em;}
.earlyDiaryNav li.nav1 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/73038/tab_nav01.png);}
.earlyDiaryNav li.nav2 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/73038/tab_nav02.png);}
.earlyDiaryNav li.nav3 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/73038/tab_nav03.png);}
.earlyDiaryNav li.nav4 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/73038/tab_nav04.png);}
.earlyDiaryNav li.nav5 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/73038/tab_nav05.png);}
.earlyDiaryNav li.nav6 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/73038/tab_nav06.png);}
.earlyDiaryNav li.nav7 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/73038/tab_nav07.png);}
.earlyDiaryNav li.nav8 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/73038/tab_nav08.png);}
.earlyDiaryNav li.current {background-position:50% 100%;}
.earlyDiaryNav li.open a {display:block;}
.earlyDiaryNav .slideNav {overflow:hidden; position:absolute; top:0; width:47px; height:78px; background-position:50% 0; background-repeat:no-repeat; background-color:transparent; text-indent:-999em; outline:none;}
.earlyDiaryNav .btnPrev {left:0; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/73038/btn_tab_prev.png);}
.earlyDiaryNav .btnNext {right:0; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/73038/btn_tab_next.png);}
</style>
</head>
<body>
<div class="earlyDiaryNav">
	<div class="swiper-container">
		<ul class="swiper-wrapper">
			<li class="swiper-slide nav1 open <%=CHKIIF(vEventID="73038"," current","")%>">
				<a href="/event/eventmain.asp?eventid=73038" target="_top">09.21 아이코닉</a>
			</li>

			<% if currentdate < "2016-09-22" then %>
			<li class="swiper-slide nav2">09.22 인디고</li>
			<% Else %>
			<li class="swiper-slide nav2 open <%=CHKIIF(vEventID="73039"," current","")%>">
				<a href="/event/eventmain.asp?eventid=73039" target="_top">09.22 인디고</a>
			</li>
			<% End If %>

			<% if currentdate < "2016-09-23" then %>
			<li class="swiper-slide nav3">09.23 안테나샵</li>
			<% Else %>
			<li class="swiper-slide nav3 open <%=CHKIIF(vEventID="73050"," current","")%>">
				<a href="/event/eventmain.asp?eventid=73050" target="_top">09.23 안테나샵</a>
			</li>
			<% End If %>

			<% if currentdate < "2016-09-26" then %>
			<li class="swiper-slide nav4">09.26 7321</li>
			<% Else %>
			<li class="swiper-slide nav4 open <%=CHKIIF(vEventID="73137"," current","")%>">
				<a href="/event/eventmain.asp?eventid=73137" target="_top">09.26 7321</a>
			</li>
			<% End If %>

			<% if currentdate < "2016-09-27" then %>
			<li class="swiper-slide nav5">09.27 라이브워크</li>
			<% Else %>
			<li class="swiper-slide nav5 open <%=CHKIIF(vEventID="73204"," current","")%>">
				<a href="/event/eventmain.asp?eventid=73204" target="_top">09.27 라이브워크</a>
			</li>
			<% End If %>

			<% if currentdate < "2016-09-28" then %>
			<li class="swiper-slide nav6">09.28 세컨드맨션</li>
			<% Else %>
			<li class="swiper-slide nav6 open <%=CHKIIF(vEventID="73205"," current","")%>">
				<a href="/event/eventmain.asp?eventid=73205" target="_top">09.28 세컨드맨션</a>
			</li>
			<% End If %>

			<% if currentdate < "2016-09-29" then %>
			<li class="swiper-slide nav7">09.29 풀디자인</li>
			<% Else %>
			<li class="swiper-slide nav7 open <%=CHKIIF(vEventID="73206"," current","")%>">
				<a href="/event/eventmain.asp?eventid=73206" target="_top">09.29 풀디자인</a>
			</li>
			<% End If %>

			<% if currentdate < "2016-09-30" then %>
			<li class="swiper-slide nav8">09.30 아르디움</li>
			<% Else %>
			<li class="swiper-slide nav8 open <%=CHKIIF(vEventID="73207"," current","")%>">
				<a href="/event/eventmain.asp?eventid=73207" target="_top">09.30 아르디움</a>
			</li>
			<% End If %>
		</ul>
	</div>
	<button type="button" class="slideNav btnPrev">이전</button>
	<button type="button" class="slideNav btnNext">다음</button>
</div>

</body>
<script type="text/javascript">
$(function(){
	earlyDiarySwiper = new Swiper('.earlyDiaryNav .swiper-container',{
		initialSlide:<%=vStartNo%>,
		loop:false,
		autoplay:false,
		speed:500,
		slidesPerView:'5',
		pagination:false,
		nextButton:'.earlyDiaryNav .btnNext',
		prevButton:'.earlyDiaryNav .btnPrev'
	});

	$('.earlyDiaryNav .btnPrev').on('click', function(e){
		e.preventDefault()
		earlyDiarySwiper.swipePrev()
	});

	$('.earlyDiaryNav .btnNext').on('click', function(e){
		e.preventDefault()
		earlyDiarySwiper.swipeNext()
	});
});
</script>
</html>