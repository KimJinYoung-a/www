<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- INCLUDE Virtual="/lib/chkDevice.asp" -->

<%
dim currentdate
	currentdate = date()
	'currentdate = "2015-03-09"
	
	'response.write currentdate
%>
<style type="text/css">
.navigator {width:1140px; height:85px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/65671/bg_nav.png) no-repeat 0 0; text-align:left;}
.navigator strong {display:block; visibility:hidden; width:0; height:0;}
.navigator ul {overflow:hidden; width:809px; margin-left:331px;}
.navigator ul li {float:left; width:160px; margin-right:40px; height:85px; font-size:11px; line-height:85px; text-align:center; text-indent:-999em;}
.navigator ul li a {display:block; width:160px; height:85px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/65671/bg_nav.png) no-repeat -331px 0;}
.navigator ul li a:hover, .navigator ul li a.on {background-position:-331px 100%;}
.navigator ul li.nav2 a {background-position:-532px 0;}
.navigator ul li.nav2 a:hover, .navigator ul li.nav2 a.on {background-position:-532px 100%;}
.navigator ul li.nav3 a {background-position:-731px 0;}
.navigator ul li.nav3 a:hover, .navigator ul li.nav3 a.on {background-position:-731px 100%;}
.navigator ul li.nav4 a {background-position:-931px 0;}
.navigator ul li.nav4 a:hover, .navigator ul li.nav4 a.on {background-position:-931px 100%;}

/* 룸 별로 스타일 변경되는 부분입니다. */
<% If Request("eventid") = 65671 Then		'### 01.KITCHEN %>
.navigator {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/65671/bg_nav<% If Now() > #09/14/2015 00:00:00# Then %>_0914<% Else %>_0907<% End If %>.png);}
.navigator ul li a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/65671/bg_nav<% If Now() > #09/14/2015 00:00:00# Then %>_0914<% Else %>_0907<% End If %>.png);}
<% ElseIf Request("eventid") = 65779 Then		'### 02.LIBRARY ROOM %>
.navigator {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/65779/bg_nav<% If Now() > #09/14/2015 00:00:00# Then %>_0914<% Else %>_0907<% End If %>.png);}
.navigator ul li a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/65779/bg_nav<% If Now() > #09/14/2015 00:00:00# Then %>_0914<% Else %>_0907<% End If %>.png);}
<% ElseIf Request("eventid") = 65919 Then		'### 03.BEDROOM %>
.navigator {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/65919/bg_nav<% If Now() > #09/14/2015 00:00:00# Then %>_0914<% End If %>.png);}
.navigator ul li a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/65919/bg_nav<% If Now() > #09/14/2015 00:00:00# Then %>_0914<% End If %>.png);}
<% ElseIf Request("eventid") = 66036 Then		'### 04.LIVING ROOM %>
.navigator {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/66036/bg_nav.png);}
.navigator ul li a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/66036/bg_nav.png);}
<% End If %>
</style>
</head>
<body>
<div class="navigator">
	<strong>MY DREAM HOUSE</strong>
	<ul>
		<li class="nav1"><a href="/event/eventmain.asp?eventid=65671" target="_top" <% If Request("eventid") = "65671" Then %>class="on"<% End If %>>01. KITCHEN</a></li>
		<% If Now() > #08/31/2015 00:00:00# Then %>
			<li class="nav2"><a href="/event/eventmain.asp?eventid=65779" target="_top" <% If Request("eventid") = "65779" Then %>class="on"<% End If %>>02. LIBRARY ROOM</a></li>
		<% Else %>
			<li class="nav2">02. LIBRARY ROOM</li>
		<% End If %>

		<% If Now() > #09/07/2015 00:00:00# Then %>
			<li class="nav3"><a href="/event/eventmain.asp?eventid=65919" target="_top" <% If Request("eventid") = "65919" Then %>class="on"<% End If %>>03. BEDROOM</a></li>
		<% Else %>
			<li class="nav3">03. BEDROOM</li>
		<% End If %>

		<% If Now() > #09/14/2015 00:00:00# Then %>
			<li class="nav4"><a href="/event/eventmain.asp?eventid=66036" target="_top" <% If Request("eventid") = "66036" Then %>class="on"<% End If %>>04. LIVING ROOM</a></li>
		<% Else %>
			<li class="nav4">04. LIVING ROOM</li>
		<% End If %>
	</ul>
</div>
</body>
</html>