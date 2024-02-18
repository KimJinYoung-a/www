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
	If vEventID = "58690" Then
		vStartNo = "0"
	ElseIf vEventID = "59424" Then
		vStartNo = "1"
	ElseIf vEventID  = "60362" Then
		vStartNo = "2"
	ElseIf vEventID  = "61617" Then
		vStartNo = "3"
	ElseIf vEventID = "62652" Then
		vStartNo = "4"
	ElseIf vEventID = "63718" Then
		vStartNo = "5"
	ElseIf vEventID = "65128" Then
		vStartNo = "6"
	ElseIf vEventID = "65362" Then
		vStartNo = "7"
	ElseIf vEventID = "66270" Then
		vStartNo = "8"
	ElseIf vEventID = "66930" Then
		vStartNo = "9"
	ElseIf vEventID = "67355" Then
		vStartNo = "10"
	ElseIf vEventID = "68253" Then
		vStartNo = "11"
	ElseIf vEventID = "68775" Then
		vStartNo = "12"
	ElseIf vEventID = "69162" Then
		vStartNo = "13"
	ElseIf vEventID = "69681" Then
		vStartNo = "14"
	ElseIf vEventID = "69988" Then
		vStartNo = "15"
	ElseIf vEventID = "70547" Then
		vStartNo = "16"
	ElseIf vEventID = "71022" Then
		vStartNo = "17"
	ElseIf vEventID = "71877" Then
		vStartNo = "18"
	ElseIf vEventID = "72648" Then
		vStartNo = "19"
	ElseIf vEventID = "73120" Then
		vStartNo = "20"
	ElseIf vEventID = "73853" Then
		vStartNo = "21"
	ElseIf vEventID = "74031" Then
		vStartNo = "22"
	ElseIf vEventID = "74342" Then
		vStartNo = "23"
	ElseIf vEventID = "75401" Then
		vStartNo = "24"
	ElseIf vEventID = "78006" Then
		vStartNo = "25"
	ElseIf vEventID = "78457" Then
		vStartNo = "26"
	ElseIf vEventID = "79200" Then
		vStartNo = "27"
	ElseIf vEventID = "79652" Then
		vStartNo = "28"
	ElseIf vEventID = "80424" Then
		vStartNo = "29"
	ElseIf vEventID = "81419" Then
		vStartNo = "30"
	End IF
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
<% If Request("eventid") = 58690 Then '# 01 %>
body {background-color:#fdfbdf;}
<% ElseIf Request("eventid") = 59424 Then '# 02. %>
body {background-color:#d9dce9;}
<% ElseIf Request("eventid") = 60362 Then '# 03. %>
body {background-color:#ff850e;}
<% ElseIf Request("eventid") = 61617 Then '# 04. %>
body {background-color:#fffff6;}
<% ElseIf Request("eventid") = 62652 Then '# 05. %>
body {background-color:#ffa336;}
<% ElseIf Request("eventid") = 63718 Then '# 06. %>
body {background-color:#ebdaa9;}
<% ElseIf Request("eventid") = 65128 Then '# 07. %>
body {background-color:#f4de52;}
<% ElseIf Request("eventid") = 65362 Then '# 08. %>
body {background-color:#42455b;}
<% ElseIf Request("eventid") = 66270 Then '# 09. %>
body {background-color:#eedad8;}
<% ElseIf Request("eventid") = 67604 Then '# 10. %>
body {background-color:#d0fae0;}
<% ElseIf Request("eventid") = 67355 Then '# 11. %>
body {background-color:#fbd793;}
<% ElseIf Request("eventid") = 68253 Then '# 12. %>
body {background-color:#262626;}
<% ElseIf Request("eventid") = 68775 Then '# 13. %>
body {background-color:#61ccd1;}
<% ElseIf Request("eventid") = 69681 Then '# 14. %>
body {background-color:#e9e0cc;}
<% ElseIf Request("eventid") = 69988 Then '# 15. %>
body {background-color:#ffcdda;}
<% ElseIf Request("eventid") = 70547 Then '# 16. %>
body {background-color:#aef6f9;}
<% ElseIf Request("eventid") = 71022 Then '# 17. %>
body {background-color:#262626;}
.rolling .swiper .swiper-slide span {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/71022/bg_navigator_71022.png) !important;}
<% ElseIf Request("eventid") = 71877 Then '# 19. %>
body {background-color:#e6e5db;}
<% ElseIf Request("eventid") = 72648 Then '# 20. %>
body {background-color:#e6e5db;}
<% ElseIf Request("eventid") = 73120 Then '# 21. %>
body {background-color:#f6f6df;}
<% ElseIf Request("eventid") = 73853 Then '# 22. %>
body {background-color:#edd7b5;}
<% ElseIf Request("eventid") = 74031 Then '# 23. %>
body {background-color:#a2c7cb;}
<% ElseIf Request("eventid") = 74342 Then '# 24. %>
body {background-color:#f3e5a6;}
<% ElseIf Request("eventid") = 78006 Then '# 25. %>
body {background-color:#f7dbd6;}
<% ElseIf Request("eventid") = 78457 Then '# 26. %>
body {background-color:#968b6c;}
<% ElseIf Request("eventid") = 79200 Then '# 27. %>
body {background-color:#f8ce25;}
<% ElseIf Request("eventid") = 79652 Then '# 28. %>
body {background-color:#71bf44;}
<% ElseIf Request("eventid") = 80424 Then '# 29. %>
body {background-color:#fbd24e;}
<% ElseIf Request("eventid") = 81419 Then '# 30. %>
body {background-color:#4f4f4f;}
<% End If %>

.rolling {position:relative; width:1000px; margin:0 auto;}
.rolling .swiper {overflow:hidden; position:relative; width:910px; margin:0 auto; padding-top:22px;}
.rolling .swiper-container {overflow:hidden; width:910px; height:108px; margin:0 auto;}
.rolling .swiper .swiper-wrapper {position:relative;}
.rolling .swiper .swiper-slide {overflow:hidden; float:left; width:130px !important; height:108px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/book/bg_navigator_v14.png) no-repeat 0 0;}
.rolling .swiper .swiper-slide a,
.rolling .swiper .swiper-slide span {display:block; width:108px; height:108px; margin:0 11px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/book/bg_navigator_v14.png) no-repeat 0 0; text-indent:-9999em;}
.rolling .swiper .swiper-slide a {background-position:0 -108px;}
.rolling .swiper .swiper-slide a:hover, .rolling .swiper .swiper-slide a.on {background-position:0 100%;}
.rolling .swiper .swiper-slide-02 a {background-position:-108px -108px;}
.rolling .swiper .swiper-slide-02 a:hover, .rolling .swiper .swiper-slide-02 a.on {background-position:-108px 100%;}
.rolling .swiper .swiper-slide-03 a {background-position:-216px -108px;}
.rolling .swiper .swiper-slide-03 a:hover, .rolling .swiper .swiper-slide-03 a.on {background-position:-216px 100%;}
.rolling .swiper .swiper-slide-04 a {background-position:-324px -108px;}
.rolling .swiper .swiper-slide-04 a:hover, .rolling .swiper .swiper-slide-04 a.on {background-position:-324px 100%;}
.rolling .swiper .swiper-slide-05 a {background-position:-432px -108px;}
.rolling .swiper .swiper-slide-05 a:hover, .rolling .swiper .swiper-slide-05 a.on {background-position:-432px 100%;}
.rolling .swiper .swiper-slide-06 a {background-position:-540px -108px;}
.rolling .swiper .swiper-slide-06 a:hover, .rolling .swiper .swiper-slide-06 a.on {background-position:-540px 100%;}
.rolling .swiper .swiper-slide-07 a {background-position:-648px -108px;}
.rolling .swiper .swiper-slide-07 a:hover, .rolling .swiper .swiper-slide-07 a.on {background-position:-648px 100%;}
.rolling .swiper .swiper-slide-08 a {background-position:-756px -108px;}
.rolling .swiper .swiper-slide-08 a:hover, .rolling .swiper .swiper-slide-08 a.on {background-position:-756px 100%;}
.rolling .swiper .swiper-slide-09 a {background-position:-864px -108px;}
.rolling .swiper .swiper-slide-09 a:hover, .rolling .swiper .swiper-slide-09 a.on {background-position:-864px 100%;}
.rolling .swiper .swiper-slide-10 a {background-position:-972px -108px;}
.rolling .swiper .swiper-slide-10 a:hover, .rolling .swiper .swiper-slide-10 a.on {background-position:-972px 100%;}
.rolling .swiper .swiper-slide-11 a {background-position:-1080px -108px;}
.rolling .swiper .swiper-slide-11 a:hover, .rolling .swiper .swiper-slide-11 a.on {background-position:-1080px 100%;}
.rolling .swiper .swiper-slide-12 a {background-position:-1188px -108px;}
.rolling .swiper .swiper-slide-12 a:hover, .rolling .swiper .swiper-slide-12 a.on {background-position:-1188px 100%;}
.rolling .swiper .swiper-slide-13 a {background-position:-1296px -108px;}
.rolling .swiper .swiper-slide-13 a:hover, .rolling .swiper .swiper-slide-13 a.on {background-position:-1296px 100%;}
.rolling .swiper .swiper-slide-14 span {background-position:-1404px 0;}
.rolling .swiper .swiper-slide-14 a {background-position:-1404px -108px;}
.rolling .swiper .swiper-slide-14 a:hover, .rolling .swiper .swiper-slide-14 a.on {background-position:-1404px 100%;}
.rolling .swiper .swiper-slide-15 span {background-position:-1512px 0;}
.rolling .swiper .swiper-slide-15 a {background-position:-1512px -108px;}
.rolling .swiper .swiper-slide-15 a:hover, .rolling .swiper .swiper-slide-15 a.on {background-position:-1512px 100%;}
.rolling .swiper .swiper-slide-16 span {background-position:-1620px 0;}
.rolling .swiper .swiper-slide-16 a {background-position:-1620px -108px;}
.rolling .swiper .swiper-slide-16 a:hover, .rolling .swiper .swiper-slide-16 a.on {background-position:-1620px 100%;}
.rolling .swiper .swiper-slide-17 span {background-position:-1728px 0;}
.rolling .swiper .swiper-slide-17 a {background-position:-1728px -108px;}
.rolling .swiper .swiper-slide-17 a:hover, .rolling .swiper .swiper-slide-17 a.on {background-position:-1728px 100%;}
.rolling .swiper .swiper-slide-18 span {background-position:-1836px 0;}
.rolling .swiper .swiper-slide-18 a {background-position:-1836px -108px;}
.rolling .swiper .swiper-slide-18 a:hover, .rolling .swiper .swiper-slide-18 a.on {background-position:-1836px 100%;}
.rolling .swiper .swiper-slide-19 span {background-position:-1944px 0;}
.rolling .swiper .swiper-slide-19 a {background-position:-1944px -108px;}
.rolling .swiper .swiper-slide-19 a:hover, .rolling .swiper .swiper-slide-19 a.on {background-position:-1944px 100%;}
.rolling .swiper .swiper-slide-20 span {background-position:-2052px 0;}
.rolling .swiper .swiper-slide-20 a {background-position:-2052px -108px;}
.rolling .swiper .swiper-slide-20 a:hover, .rolling .swiper .swiper-slide-20 a.on {background-position:-2052px 100%;}
.rolling .swiper .swiper-slide-21 span {background-position:-2160px 0;}
.rolling .swiper .swiper-slide-21 a {background-position:-2160px -108px;}
.rolling .swiper .swiper-slide-21 a:hover, .rolling .swiper .swiper-slide-21 a.on {background-position:-2160px -108px;}
.rolling .swiper .swiper-slide-22 span {background-position:-2268px 0;}
.rolling .swiper .swiper-slide-22 a {background-position:-2268px -108px;}
.rolling .swiper .swiper-slide-22 a:hover, .rolling .swiper .swiper-slide-22 a.on {background-position:-2268px 100%;}
.rolling .swiper .swiper-slide-23 span {background-position:-2376px 0;}
.rolling .swiper .swiper-slide-23 a {background-position:-2376px -108px;}
.rolling .swiper .swiper-slide-23 a:hover, .rolling .swiper .swiper-slide-23 a.on {background-position:-2376px 100%;}
.rolling .swiper .swiper-slide-24 span {background-position:-2484px 0;}
.rolling .swiper .swiper-slide-24 a {margin-right:0; padding-right: 11px; background-position:-2484px -108px;}
.rolling .swiper .swiper-slide-24 a:hover, .rolling .swiper .swiper-slide-24 a.on {background-position:-2484px 100%;}

/* 2017 */
.rolling .swiper .swiper-slide-2017 a,
.rolling .swiper .swiper-slide-2017 span {background:url(http://webimage.10x10.co.kr/eventIMG/2017/book/img_navigator_v8.png);}
.rolling .swiper .swiper-slide-25 span {background-position:0 0;}
.rolling .swiper .swiper-slide-25 a {background-position:0 -108px;}
.rolling .swiper .swiper-slide-25 a:hover, .rolling .swiper .swiper-slide-25 a.on {background-position:0 100%;}

.rolling .swiper .swiper-slide-26 span {background-position:-108px -108px;}
.rolling .swiper .swiper-slide-26 a {background-position:-108px -108px;}
.rolling .swiper .swiper-slide-26 a:hover, .rolling .swiper .swiper-slide-26 a.on {background-position:-108px 100%;}

.rolling .swiper .swiper-slide-27 span {background-position:-216px 0;}
.rolling .swiper .swiper-slide-27 a {background-position:-216px -108px;}
.rolling .swiper .swiper-slide-27 a:hover, .rolling .swiper .swiper-slide-27 a.on {background-position:-216px 100%;}

.rolling .swiper .swiper-slide-28 span {background-position:-324px 0;}
.rolling .swiper .swiper-slide-28 a {background-position:-324px -108px;}
.rolling .swiper .swiper-slide-28 a:hover, .rolling .swiper .swiper-slide-28 a.on {background-position:-324px 100%;}

.rolling .swiper .swiper-slide-29 span {background-position:-432px 0;}
.rolling .swiper .swiper-slide-29 a {background-position:-432px -108px;}
.rolling .swiper .swiper-slide-29 a:hover, .rolling .swiper .swiper-slide-29 a.on {background-position:-432px 100%;}

.rolling .swiper .swiper-slide-30 span {background-position:-540px 0;}
.rolling .swiper .swiper-slide-30 a {background-position:-540px -108px;}
.rolling .swiper .swiper-slide-30 a:hover, .rolling .swiper .swiper-slide-30 a.on {background-position:-540px 100%;}

.rolling .swiper .swiper-slide-31 span {background-position:-648px 0;}
.rolling .swiper .swiper-slide-31 a {background-position:-648px -108px;}
.rolling .swiper .swiper-slide-31 a:hover, .rolling .swiper .swiper-slide-31 a.on {background-position:-648px 100%;}

.rolling .swiper .swiper-slide-32 span {background-position:-756px 0;}
.rolling .swiper .swiper-slide-32 a {background-position:-756px -108px;}
.rolling .swiper .swiper-slide-32 a:hover, .rolling .swiper .swiper-slide-32 a.on {background-position:-756px 100%;}

.rolling .btn-nav {position:absolute; top:22px; width:30px; height:108px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/book/btn_nav.png) no-repeat 0 50%; text-indent:-9999em;}
.rolling .btn-prev {left:0;}
.rolling .btn-next {right:0; background-position:100% 50%;}
</style>
</head>
<body>
	<div class="rolling">
		<div class="swiper">
			<div class="swiper-container swiper1">
				<ul class="swiper-wrapper">
					<li class="swiper-slide swiper-slide-01">
						<a href="/event/eventmain.asp?eventid=58690" target="_top" <%=CHKIIF(vEventID="58690"," class='on'","")%>>#01 1월의 책 DOG YEARS</a>
					</li>
					<li class="swiper-slide swiper-slide-02">
						<a href="/event/eventmain.asp?eventid=59424" target="_top" <%=CHKIIF(vEventID="59424"," class='on'","")%>>#02 2월의 책 Before after</a>
					</li>
					<li class="swiper-slide swiper-slide-03">
						<a href="/event/eventmain.asp?eventid=60362" target="_top" <%=CHKIIF(vEventID="60362"," class='on'","")%>>#03 3월의 책 우주 우표책</a>
					</li>
					<li class="swiper-slide swiper-slide-04">
						<a href="/event/eventmain.asp?eventid=61617" target="_top" <%=CHKIIF(vEventID="61617"," class='on'","")%>>#04 4월의 책 우리가족 평균연령 60세!</a>
					</li>
					<li class="swiper-slide swiper-slide-05">
						<a href="/event/eventmain.asp?eventid=62652" target="_top" <%=CHKIIF(vEventID="62652"," class='on'","")%>>#05 5월의 책 COLOR THIS BOOK</a>
					</li>
					<li class="swiper-slide swiper-slide-06">
						<a href="/event/eventmain.asp?eventid=63718" target="_top" <%=CHKIIF(vEventID="63718"," class='on'","")%>>#06 6월의 책 HOW OLD ARE YOU</a>
					</li>
					<li class="swiper-slide swiper-slide-07">
						<a href="/event/eventmain.asp?eventid=65128" target="_top" <%=CHKIIF(vEventID="65128"," class='on'","")%>>#07 7월의 책 이환천의 문학살롱</a>
					</li>
					<li class="swiper-slide swiper-slide-08">
						<a href="/event/eventmain.asp?eventid=65362" target="_top" <%=CHKIIF(vEventID="65362"," class='on'","")%>>#08 8월의 책 반 고흐</a>
					</li>
					<li class="swiper-slide swiper-slide-09">
						<a href="/event/eventmain.asp?eventid=66270" target="_top" <%=CHKIIF(vEventID="66270"," class='on'","")%>>#09 9월의 책 케이트와 고양이의 ABC</a>
					</li>
					<li class="swiper-slide swiper-slide-10">
						<a href="/event/eventmain.asp?eventid=66930" target="_top" <%=CHKIIF(vEventID="66930"," class='on'","")%>>#10 10월의 책 주말클렌즈</a>
					</li>
					<li class="swiper-slide swiper-slide-11">
						<a href="/event/eventmain.asp?eventid=67355" target="_top" <%=CHKIIF(vEventID="67355"," class='on'","")%>>#11 11월의 책 상상고양이</a>
					</li>
					<li class="swiper-slide swiper-slide-12">
						<a href="/event/eventmain.asp?eventid=68253" target="_top" <%=CHKIIF(vEventID="68253"," class='on'","")%>>#12 12월의 책 갱상도 사투리 배우러 들온나</a>
					</li>
					<li class="swiper-slide swiper-slide-13">
						<a href="/event/eventmain.asp?eventid=68775" target="_top" <%=CHKIIF(vEventID="68775"," class='on'","")%>>#13 1월의 책 DOG YEARS</a>
					</li>
					<li class="swiper-slide swiper-slide-14">
						<a href="/event/eventmain.asp?eventid=69162" target="_top" <%=CHKIIF(vEventID="69162"," class='on'","")%>>#14 2월의 책 GIRLS ON FILM BOYS ON FILM</a>
					</li>
					<li class="swiper-slide swiper-slide-15">
						<a href="/event/eventmain.asp?eventid=69681" target="_top" <%=CHKIIF(vEventID="69681"," class='on'","")%>>#14 3월의 책 첫번째 리틀위버</a>
					</li>
					<li class="swiper-slide swiper-slide-16">
						<a href="/event/eventmain.asp?eventid=69988" target="_top" <%=CHKIIF(vEventID="69988"," class='on'","")%>>#15 4월의 Grand Budapest Hotel</a>
					</li>
					<li class="swiper-slide swiper-slide-17">
						<a href="/event/eventmain.asp?eventid=70547" target="_top" <%=CHKIIF(vEventID="70547"," class='on'","")%>>#17 5월의 책 바닷마을 다이어리</a>
					</li>
					<li class="swiper-slide swiper-slide-18">
						<a href="/event/eventmain.asp?eventid=71022" target="_top" <%=CHKIIF(vEventID="71022"," class='on'","")%>>#18 6월의 책 치킨의 50가지 그림자</a>
					</li>

					<% if currentdate < "2016-07-20" then %>
					<li class="swiper-slide swiper-slide-19">
						<span>#19 7월의 책 오픈예정</span>
					</li>
					<% Else %>
					<li class="swiper-slide swiper-slide-19">
						<a href="/event/eventmain.asp?eventid=71877" target="_top" <%=CHKIIF(vEventID="71877"," class='on'","")%>>#19 7월의 책 쓰담쓰담</a>
					</li>
					<% End If %>

					<% if currentdate < "2016-08-31" then %>
					<li class="swiper-slide swiper-slide-20">
						<span>#20 8월의 책 오픈예정</span>
					</li>
					<% Else %>
					<li class="swiper-slide swiper-slide-20">
						<a href="/event/eventmain.asp?eventid=72648" target="_top" <%=CHKIIF(vEventID="72648"," class='on'","")%>>#20 8월의 책 라이언 맥긴리</a>
					</li>
					<% End If %>

					<% if currentdate < "2016-09-21" then %>
					<li class="swiper-slide swiper-slide-21">
						<span>#21 9월의 책 오픈예정</span>
					</li>
					<% Else %>
					<li class="swiper-slide swiper-slide-21">
						<a href="/event/eventmain.asp?eventid=73120" target="_top" <%=CHKIIF(vEventID="73120"," class='on'","")%>>#21 9월의 책 너의 속이 궁금해</a>
					</li>
					<% End If %>

					<% if currentdate < "2016-10-26" then %>
					<li class="swiper-slide swiper-slide-22">
						<span>#22 10월의 책 오픈예정</span>
					</li>
					<% Else %>
					<li class="swiper-slide swiper-slide-22">
						<a href="/event/eventmain.asp?eventid=73853" target="_top" <%=CHKIIF(vEventID="73853"," class='on'","")%>>#22 10월의 책 어바웃 해피니스</a>
					</li>
					<% End If %>

					<% if currentdate < "2016-11-09" then %>
					<li class="swiper-slide swiper-slide-23">
						<span>#23 11월의 책 오픈예정</span>
					</li>
					<% Else %>
					<li class="swiper-slide swiper-slide-23">
						<a href="/event/eventmain.asp?eventid=74031" target="_top" <%=CHKIIF(vEventID="74031"," class='on'","")%>>#23 11월의 책 구름 껴도 맑음</a>
					</li>
					<% End If %>

					<% if currentdate < "2016-11-30" then %>
					<li class="swiper-slide swiper-slide-24">
						<span>#24 11월의 책 오픈예정</span>
					</li>
					<% Else %>
					<li class="swiper-slide swiper-slide-24">
						<a href="/event/eventmain.asp?eventid=74342" target="_top" <%=CHKIIF(vEventID="74342"," class='on'","")%>>#24 2016년 12월의 책 VOICE</a>
					</li>
					<% End If %>

					<!-- 2017년도에는 클래스 swiper-slide-2017이 붙습니다. -->
					<% if currentdate < "2017-01-11" then %>
					<li class="swiper-slide swiper-slide-2017 swiper-slide-25">
						<span>#25 2017년 1월의 책 오픈예정</span>
					</li>
					<% Else %>
					<li class="swiper-slide swiper-slide-2017 swiper-slide-25">
						<a href="/event/eventmain.asp?eventid=75401" target="_top" <%=CHKIIF(vEventID="75401"," class='on'","")%>>#25 2017년 1월의 책 실어증입니다, 일하기싫어증</a>
					</li>
					<% End If %>

					<% if currentdate < "2017-05-24" then %>
					<li class="swiper-slide swiper-slide-2017 swiper-slide-26">
						<span>#25 2017년 1월의 책 오픈예정</span>
					</li>
					<% Else %>
					<li class="swiper-slide swiper-slide-2017 swiper-slide-26">
						<a href="/event/eventmain.asp?eventid=78006" target="_top" <%=CHKIIF(vEventID="78006"," class='on'","")%>>#26 2017년 5월의 당신이 사랑하는 순간</a>
					</li>
					<% End If %>

					<% if currentdate < "2017-06-21" then %>
					<li class="swiper-slide swiper-slide-2017 swiper-slide-27">
						<span>#27 2017년 6월의 책 오픈예정</span>
					</li>
					<% Else %>
					<li class="swiper-slide swiper-slide-2017 swiper-slide-27">
						<a href="/event/eventmain.asp?eventid=78457" target="_top" <%=CHKIIF(vEventID="78457"," class='on'","")%>>#27 2017년 6월의 책 편안하고 사랑스럽고 그래</a>
					</li>
					<% End If %>

					<% if currentdate < "2017-07-26" then %>
					<li class="swiper-slide swiper-slide-2017 swiper-slide-28">
						<span>#27 2017년 7월의 책 오픈예정</span>
					</li>
					<% Else %>
					<li class="swiper-slide swiper-slide-2017 swiper-slide-28">
						<a href="/event/eventmain.asp?eventid=79200" target="_top" <%=CHKIIF(vEventID="79200"," class='on'","")%>>#27 2017년 7월의 책 프리다칼로</a>
					</li>
					<% End If %>

					<% if currentdate < "2017-08-09" then %>
					<li class="swiper-slide swiper-slide-2017 swiper-slide-29">
						<span>#27 2017년 8월의 책 오픈예정</span>
					</li>
					<% Else %>
					<li class="swiper-slide swiper-slide-2017 swiper-slide-29">
						<a href="/event/eventmain.asp?eventid=79652" target="_top" <%=CHKIIF(vEventID="79652"," class='on'","")%>>#27 2017년 8월의 책 시바견 곤 이야기</a>
					</li>
					<% End If %>

					<% if currentdate < "2017-09-14" then %>
					<li class="swiper-slide swiper-slide-2017 swiper-slide-30">
						<span>#29 2017년 9월의 책 오픈예정</span>
					</li>
					<% Else %>
					<li class="swiper-slide swiper-slide-2017 swiper-slide-30">
						<a href="/event/eventmain.asp?eventid=80424" target="_top" <%=CHKIIF(vEventID="80424"," class='on'","")%>>#29 2017년 9월의 책 바게트호텔</a>
					</li>
					<% End If %>

					<% if currentdate < "2017-10-26" then %>
					<li class="swiper-slide swiper-slide-2017 swiper-slide-31">
						<span>#30 2017년 10월의 책 오픈예정</span>
					</li>
					<% Else %>
					<li class="swiper-slide swiper-slide-2017 swiper-slide-31">
						<a href="/event/eventmain.asp?eventid=81419" target="_top" <%=CHKIIF(vEventID="81419"," class='on'","")%>>#30 2017년 10월의 책 머무르는 말들</a>
					</li>
					<% End If %>

					<li class="swiper-slide swiper-slide-2017 swiper-slide-32">
						<span>#31 2017년 11월의 책 오픈예정</span>
				</ul>
			</div>
		</div>
		<button type="button" class="btn-nav btn-prev">Previous</button>
		<button type="button" class="btn-nav btn-next">Next</button>
	</div>
</body>
<script type="text/javascript">
$(function(){
	/* swipe */
	/*if ($(".swiper-slide-active").is(".swiper-slide-02")) {
		$(".swiper-wrapper").css("padding-left","0");
	});*/

	var swiper1 = new Swiper('.swiper1',{
		loop:true,
		centeredSlides:true,
		slidesPerView:7,
		slidesPerGroup:7,
		speed:800,
		simulateTouch:false,
		initialSlide:<%=vStartNo%>,
		onSlideChangeStart: function (swiper1) {
			if ($(".swiper-slide-active").is(".swiper-slide-01")) {
				$(".swiper-wrapper").css("padding-left","0");
			} else if ($(".swiper-slide-active").is(".swiper-slide-23")) {
				$(".swiper-slide-23").removeClass("swiper-slide-active");
				$(".swiper-slide-24").addClass("swiper-slide-active");
				$(".swiper-wrapper").css("padding-left","780px");
			}
		}
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
</html>