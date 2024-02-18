<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
.fiveNav {}
.fiveNav ul {overflow:hidden; width:763px; height:165px;}
.fiveNav li {float:left; width:152px; height:165px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/60121/tab_five_dessert.png); background-repeat:no-repeat;}
.fiveNav li a {display:none; width:100%; height:165px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/60121/tab_five_dessert.png); background-repeat:no-repeat; text-indent:-9999px;}
.fiveNav li.open a {display:block;}
.fiveNav li.days01 {background-position:left top;}
.fiveNav li.days02 {background-position:-152px top;}
.fiveNav li.days03 {background-position:-304px top;}
.fiveNav li.days04 {background-position:-456px top;}
.fiveNav li.days05 {width:155px; background-position:right top;}
.fiveNav li.days01.open a {background-position:left top;}
.fiveNav li.days02.open a {background-position:-152px top;}
.fiveNav li.days03.open a {background-position:-304px top;}
.fiveNav li.days04.open a {background-position:-456px top;}
.fiveNav li.days05.open a {width:155px; background-position:right top;}
.fiveNav li.days01.current a {background-position:left bottom;}
.fiveNav li.days02.current a {background-position:-152px bottom;}
.fiveNav li.days03.current a {background-position:-304px bottom;}
.fiveNav li.days04.current a {background-position:-456px bottom;}
.fiveNav li.days05.current a {background-position:right bottom;}
</style>
</head>
<body>
<div class="fiveNav">
	<ul>
		<!-- 현재 보고있는 페이지 currunt / 오픈된페이지 open -->
		<li class="days01 open<% If Request("eventid") = "60121" Then Response.Write " current" End If %>"><a href="/event/eventmain.asp?eventid=60121" target="_top">월요일</a></li>
		<li class="days02<% If Now() > #03/10/2015 00:00:00# Then Response.Write " open" End If %><% If Request("eventid") = "60123" Then Response.Write " current" End If %>"><a href="/event/eventmain.asp?eventid=60123" target="_top">화요일</a></li>
		<li class="days03<% If Now() > #03/11/2015 00:00:00# Then Response.Write " open" End If %><% If Request("eventid") = "60124" Then Response.Write " current" End If %>"><a href="/event/eventmain.asp?eventid=60124" target="_top">수요일</a></li>
		<li class="days04<% If Now() > #03/12/2015 00:00:00# Then Response.Write " open" End If %><% If Request("eventid") = "60125" Then Response.Write " current" End If %>"><a href="/event/eventmain.asp?eventid=60125" target="_top">목요일</a></li>
		<li class="days05<% If Now() > #03/13/2015 00:00:00# Then Response.Write " open" End If %><% If Request("eventid") = "60126" Then Response.Write " current" End If %>"><a href="/event/eventmain.asp?eventid=60126" target="_top">금요일</a></li>
	</ul>
</div>
</body>
</html>