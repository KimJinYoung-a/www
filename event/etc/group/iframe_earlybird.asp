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

	If vEventID = "80653" Then
		vStartNo = "0"
	ElseIf vEventID = "80655" Then
		vStartNo = "0"
	ElseIf vEventID = "80656" Then
		vStartNo = "0"
	ElseIf vEventID = "80657" Then
		vStartNo = "1"
	ElseIf vEventID = "80720" Then
		vStartNo = "2"
	ElseIf vEventID = "80749" Then
		vStartNo = "3"
	ElseIf vEventID = "80771" Then
		vStartNo = "4"
	ElseIf vEventID = "80852" Then
		vStartNo = "5"
	ElseIf vEventID = "80854" Then
		vStartNo = "6"
	ElseIf vEventID = "80855" Then
		vStartNo = "7"
	ElseIf vEventID = "80856" Then
		vStartNo = "8"
	ElseIf vEventID = "80857" Then
		vStartNo = "9"
	ElseIf vEventID = "80858" Then
		vStartNo = "10"
	ElseIf vEventID = "80859" Then
		vStartNo = "10"
	ElseIf vEventID = "80860" Then
		vStartNo = "10"
	End IF
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
.earlyDiaryNav {position:relative; width:1140px; height:120px; margin:0 auto; z-index:1;}
.earlyDiaryNav .swiper-container {width:100%; height:120px;}
.earlyDiaryNav .swiper-slide {height:78px !important;}
.earlyDiaryNav li {position:relative; float:left; width:228px; }
.earlyDiaryNav li span {display:block; overflow:hidden; height:78px;}
.earlyDiaryNav li a {overflow:hidden; width:228px; height:78px;}
.earlyDiaryNav li img {display:block;}
.earlyDiaryNav li.open img {margin-top:-78px;}
.earlyDiaryNav li.current img {margin-top:-156px;}
.earlyDiaryNav li.current:after {content:''; display:inline-block; position:absolute; left:63px; top:78px; width:100px; height:42px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/early/bg_tab_current.png) no-repeat 0 0;}
.earlyDiaryNav button {position:absolute; top:0; outline:none; background:transparent;}
.earlyDiaryNav .btnPrev {left:0;}
.earlyDiaryNav .btnNext {right:0;}
</style>
</head>
<body>
<div class="earlyDiaryNav">
	<div class="swiper-container">
		<ul class="swiper-wrapper">
			<li class="swiper-slide open <%=CHKIIF(vEventID="80653"," current","")%>">
				<a href="/event/eventmain.asp?eventid=80653" target="_top"><span><img src="http://webimage.10x10.co.kr/eventIMG/2017/early/tab_1.png" alt="루카랩" /></span></a>
			</li>

			<% if currentdate < "2017-09-19" then %>
			<li class="swiper-slide"><span><img src="http://webimage.10x10.co.kr/eventIMG/2017/early/tab_2.png" alt="인디고" /></span></li>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="80655"," current","")%>">
				<a href="/event/eventmain.asp?eventid=80655" target="_top"><span><img src="http://webimage.10x10.co.kr/eventIMG/2017/early/tab_2.png" alt="인디고" /></span></a>
			</li>
			<% End If %>

			<% if currentdate < "2017-09-20" then %>
			<li class="swiper-slide"><span><img src="http://webimage.10x10.co.kr/eventIMG/2017/early/tab_3.png" alt="라이브워크" /></span></li>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="80656"," current","")%>">
				<a href="/event/eventmain.asp?eventid=80656" target="_top"><span><img src="http://webimage.10x10.co.kr/eventIMG/2017/early/tab_3.png" alt="라이브워크" /></span></a>
			</li>
			<% End If %>

			<% if currentdate < "2017-09-21" then %>
			<li class="swiper-slide"><span><img src="http://webimage.10x10.co.kr/eventIMG/2017/early/tab_4.png" alt="아이코닉" /></span></li>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="80657"," current","")%>">
				<a href="/event/eventmain.asp?eventid=80657" target="_top"><span><img src="http://webimage.10x10.co.kr/eventIMG/2017/early/tab_4.png" alt="아이코닉" /></span></a>
			</li>
			<% End If %>

			<% if currentdate < "2017-09-22" then %>
			<li class="swiper-slide"><span><img src="http://webimage.10x10.co.kr/eventIMG/2017/early/tab_5.png" alt="" /></span></li>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="80720"," current","")%>">
				<a href="/event/eventmain.asp?eventid=80720" target="_top"><span><img src="http://webimage.10x10.co.kr/eventIMG/2017/early/tab_5.png" alt="데일리라이크" /></span></a>
			</li>
			<% End If %>

			<% if currentdate < "2017-09-25" then %>
			<li class="swiper-slide"><span><img src="http://webimage.10x10.co.kr/eventIMG/2017/early/tab_6.png" alt="" /></span></li>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="80749"," current","")%>">
				<a href="/event/eventmain.asp?eventid=80749" target="_top"><span><img src="http://webimage.10x10.co.kr/eventIMG/2017/early/tab_6.png" alt="아르디움" /></span></a>
			</li>
			<% End If %>

			<% if currentdate < "2017-09-26" then %>
			<li class="swiper-slide"><span><img src="http://webimage.10x10.co.kr/eventIMG/2017/early/tab_7.png" alt="" /></span></li>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="80771"," current","")%>">
				<a href="/event/eventmain.asp?eventid=80771" target="_top"><span><img src="http://webimage.10x10.co.kr/eventIMG/2017/early/tab_7.png" alt="리훈" /></span></a>
			</li>
			<% End If %>

			<% if currentdate < "2017-09-27" then %>
			<li class="swiper-slide"><span><img src="http://webimage.10x10.co.kr/eventIMG/2017/early/tab_8.png" alt="" /></span></li>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="80852"," current","")%>">
				<a href="/event/eventmain.asp?eventid=80852" target="_top"><span><img src="http://webimage.10x10.co.kr/eventIMG/2017/early/tab_8.png" alt="아이코닉" /></span></a>
			</li>
			<% End If %>

			<% if currentdate < "2017-09-28" then %>
			<li class="swiper-slide"><span><img src="http://webimage.10x10.co.kr/eventIMG/2017/early/tab_9.png" alt="" /></span></li>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="80854"," current","")%>">
				<a href="/event/eventmain.asp?eventid=80854" target="_top"><span><img src="http://webimage.10x10.co.kr/eventIMG/2017/early/tab_9.png" alt="세컨드맨션" /></span></a>
			</li>
			<% End If %>

			<% if currentdate < "2017-09-29" then %>
			<li class="swiper-slide"><span><img src="http://webimage.10x10.co.kr/eventIMG/2017/early/tab_10.png" alt="" /></span></li>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="80855"," current","")%>">
				<a href="/event/eventmain.asp?eventid=80855" target="_top"><span><img src="http://webimage.10x10.co.kr/eventIMG/2017/early/tab_10.png" alt="페이퍼리안" /></span></a>
			</li>
			<% End If %>

			<% if currentdate < "2017-10-02" then %>
			<li class="swiper-slide"><span><img src="http://webimage.10x10.co.kr/eventIMG/2017/early/tab_11_v2.png" alt="" /></span></li>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="80856"," current","")%>">
				<a href="/event/eventmain.asp?eventid=80856" target="_top"><span><img src="http://webimage.10x10.co.kr/eventIMG/2017/early/tab_11_v2.png" alt="플라잉웨일즈" /></span></a>
			</li>
			<% End If %>

			<% if currentdate < "2017-10-10" then %>
			<li class="swiper-slide"><span><img src="http://webimage.10x10.co.kr/eventIMG/2017/early/tab_12.png" alt="" /></span></li>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="80857"," current","")%>">
				<a href="/event/eventmain.asp?eventid=80857" target="_top"><span><img src="http://webimage.10x10.co.kr/eventIMG/2017/early/tab_12.png" alt="세컨드맨션" /></span></a>
			</li>
			<% End If %>

			<% if currentdate < "2017-10-11" then %>
			<li class="swiper-slide"><span><img src="http://webimage.10x10.co.kr/eventIMG/2017/early/tab_13.png" alt="" /></span></li>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="80858"," current","")%>">
				<a href="/event/eventmain.asp?eventid=80858" target="_top"><span><img src="http://webimage.10x10.co.kr/eventIMG/2017/early/tab_13.png" alt="인디고" /></span></a>
			</li>
			<% End If %>

			<% if currentdate < "2017-10-12" then %>
			<li class="swiper-slide"><span><img src="http://webimage.10x10.co.kr/eventIMG/2017/early/tab_14.png" alt="" /></span></li>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="80859"," current","")%>">
				<a href="/event/eventmain.asp?eventid=80859" target="_top"><span><img src="http://webimage.10x10.co.kr/eventIMG/2017/early/tab_14.png" alt="비온뒤" /></span></a>
			</li>
			<% End If %>

			<% if currentdate < "2017-10-13" then %>
			<li class="swiper-slide"><span><img src="http://webimage.10x10.co.kr/eventIMG/2017/early/tab_15.png" alt="" /></span></li>
			<% Else %>
			<li class="swiper-slide open <%=CHKIIF(vEventID="80860"," current","")%>">
				<a href="/event/eventmain.asp?eventid=80860" target="_top"><span><img src="http://webimage.10x10.co.kr/eventIMG/2017/early/tab_15.png" alt="잼스튜디오" /></span></a>
			</li>
			<% End If %>
		</ul>
	</div>
	<button type="button" class="btnPrev"><img src="http://webimage.10x10.co.kr/eventIMG/2017/early/btn_prev.png" alt="이전" /></button>
	<button type="button" class="btnNext"><img src="http://webimage.10x10.co.kr/eventIMG/2017/early/btn_next.png" alt="다음" /></button>
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