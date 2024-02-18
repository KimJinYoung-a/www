<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="utf-8" %>
<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
body {background-color:transparent;}
.navigator {width:990px; height:150px; margin:10px auto 0;}
.navigator:after {content:' '; display:block; clear:both;}
.navigator li {float:left; width:141px; height:140px; margin:0 12px;}
.navigator li a,
.navigator li span {overflow:hidden; display:block; position:relative; width:100%; height:140px; color:#000; font-size:12px; line-height:140px; text-align:center;}
.navigator li a i,
.navigator li span i {display:block; position:absolute; top:0; left:0; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2016/68963/bg_navigator_v4.png) no-repeat 0 0;}
.navigator li a.today {animation-name:bounce; animation-iteration-count:infinite; animation-duration:1s;}
@keyframes bounce {
	from, to{margin-top:0; animation-timing-function:ease-out;}
	50% {margin-top:3px; animation-timing-function:ease-in;}
}

.navigator li a i {background-position:0 100%;}
.navigator li a.today i {background-position:0 -140px;}

.navigator li.nav2 span i {background-position:-164px 0;}
.navigator li.nav2 a i {background-position:-164px 100%;}
.navigator li.nav2 .today i {background-position:-164px -140px;}

.navigator li.nav3 span i {background-position:-328px 0;}
.navigator li.nav3 a i {background-position:-328px 100%;}
.navigator li.nav3 .today i {background-position:-328px -140px;}

.navigator li.nav4 span i {background-position:-491px 0;}
.navigator li.nav4 a i {background-position:-491px 100%;}
.navigator li.nav4 .today i {background-position:-491px -140px;}

.navigator li.nav5 span i {background-position:-655px 0;}
.navigator li.nav5 a i {background-position:-655px 100%;}
.navigator li.nav5 .today i {background-position:-655px -140px;}

.navigator li.nav6 span i {background-position:100% 0;}
.navigator li.nav6 a i {background-position:100% 100%;}
.navigator li.nav6 .today i {background-position:100% -140px;}
</style>
</head>
<body>
<% 
'		68963 #1일차 디자인문구
'		68985 #2일차 여행/취미
'		68935 #3일차 패션
'		68967 #4일차 디지털
'		68983 #5일차 뷰티
'		68970 #6일차 패브릭/수납
%>
	<ul class="navigator">
		<li class="nav1"><a href="/event/eventmain.asp?eventid=68963" target="_top" class="<%=chkiif(Date()="2016-02-05","today","")%>"><i></i>02.05 (금)<%=chkiif(Date()="2016-02-05"," 오늘 단 하루","")%></a></li>

		<% If Date() >="2016-02-06" then %>
		<li class="nav2"><a href="/event/eventmain.asp?eventid=68985" target="_top" class="<%=chkiif(Date()="2016-02-06","today","")%>"><i></i>02.06 (토)<%=chkiif(Date()="2016-02-06"," 오늘 단 하루","")%></a></li>
		<% Else %>
		<li class="nav2"><span><i></i>02.06 (토)</span></li>
		<% End If %>

		<% If Date() >="2016-02-07" then %>
		<li class="nav3"><a href="/event/eventmain.asp?eventid=68935" target="_top" class="<%=chkiif(Date()="2016-02-07","today","")%>"><i></i>02.07 (일)<%=chkiif(Date()="2016-02-07"," 오늘 단 하루","")%></a></li>
		<% Else %>
		<li class="nav3"><span><i></i>02.07 (일)</span></li>
		<% End If %>

		<% If Date() >="2016-02-08" then %>
		<li class="nav4"><a href="/event/eventmain.asp?eventid=68967" target="_top" class="<%=chkiif(Date()="2016-02-08","today","")%>"><i></i>02.08 (월)<%=chkiif(Date()="2016-02-08"," 오늘 단 하루","")%></a></li>
		<% Else %>
		<li class="nav4"><span><i></i>02.08 (월)</span></li>
		<% End If %>

		<% If Date() >="2016-02-09" then %>
		<li class="nav5"><a href="/event/eventmain.asp?eventid=68983" target="_top" class="<%=chkiif(Date()="2016-02-09","today","")%>"><i></i>02.09 (화)<%=chkiif(Date()="2016-02-09"," 오늘 단 하루","")%></a></li>
		<% Else %>
		<li class="nav5"><span><i></i>02.09 (화)</span></li>
		<% End If %>

		<% If Date() >="2016-02-10" then %>
		<li class="nav6"><a href="/event/eventmain.asp?eventid=68970" target="_top" class="<%=chkiif(Date()="2016-02-10","today","")%>"><i></i>02.10 (수)<%=chkiif(Date()="2016-02-10"," 오늘 단 하루","")%></a></li>
		<% Else %>
		<li class="nav6"><span><i></i>02.10 (수)</span></li>
		<% End If %>
	</ul>
</body>
</html>