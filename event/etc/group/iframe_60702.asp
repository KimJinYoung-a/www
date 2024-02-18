<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
dim currentdate
	currentdate = date()
	'currentdate = "2015-03-09"
	
	'response.write currentdate
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
/* iframe css */
.serise ul {overflow:hidden; padding-left:15px;}
.serise ul li {float:left; height:36px; text-align:center; text-indent:-999em;}
.serise ul li.nav1 {width:42px;}
.serise ul li.nav2 {width:41px;}
.serise ul li.nav3 {width:43px;}
.serise ul li.nav4 {width:41px;}
.serise ul li.nav5 {width:43px;}
.serise ul li.nav6 {width:41px;}
.serise ul li.nav7 {width:43px;}
.serise ul li.nav8 {width:42px;}
.serise ul li.nav9 {width:43px;}
.serise ul li.nav10 {width:38px;}
.serise ul li span {display:block; width:100%; height:36px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/61904/bg_nav_off.png) no-repeat 0 0;}
.serise ul li.nav1 span {background-position:0 0;}
.serise ul li.nav2 span {background-position:-42px 0;}
.serise ul li.nav3 span {background-position:-83px 0;}
.serise ul li.nav4 span {background-position:-126px 0;}
.serise ul li.nav5 span {background-position:-167px 0;}
.serise ul li.nav6 span {background-position:-210px 0;}
.serise ul li.nav7 span {background-position:-251px 0;}
.serise ul li.nav8 span {background-position:-294px 0;}
.serise ul li.nav9 span {background-position:-336px 0;}
.serise ul li.nav10 span {background-position:100% 0;}
.serise ul li a {display:block; width:100%; height:36px;}
.serise ul li.nav1 a {width:42px;}
.serise ul li.nav1 a:hover, 
.serise ul li.nav1 a.on {background:url(http://webimage.10x10.co.kr/eventIMG/2015/61904/bg_nav_01_on.png) no-repeat 0 0;}
.serise ul li.nav1 a:hover span, .serise ul li.nav1 a.on span {background:none;}
.serise ul li.nav2 a:hover, 
.serise ul li.nav2 a.on {background:url(http://webimage.10x10.co.kr/eventIMG/2015/61904/bg_nav_02_on.png) no-repeat 0 0;}
.serise ul li.nav2 a:hover span, .serise ul li.nav2 a.on span {background:none;}
</style>
</head>
<!-- iframe -->
<body>
<div class="serise">
	<ul>
		<li class="nav1"><a href="/event/eventmain.asp?eventid=60702" target="_top" <% If Request("eventid") = "60702" Then %>class="on"<% End If %>><span>01</span></a></li>
		<% if currentdate < "2015-04-27" then %>
			<li class="nav2"><span>02</span></li>
		<% Else %>
			<li class="nav2"><a href="/event/eventmain.asp?eventid=61904" target="_top" <% If Request("eventid") = "61904" Then %>class="on"<% End If %>><span>02</span></a></li>
		<% end if %>
			<li class="nav3"><span>03</span></li>
			<li class="nav4"><span>04</span></li>
			<li class="nav5"><span>05</span></li>
			<li class="nav6"><span>06</span></li>
			<li class="nav7"><span>07</span></li>
			<li class="nav8"><span>08</span></li>
			<li class="nav9"><span>09</span></li>
			<li class="nav10"><span>10</span></li>
	</ul>
</div>
<!-- //iframe -->
</body>
</html>