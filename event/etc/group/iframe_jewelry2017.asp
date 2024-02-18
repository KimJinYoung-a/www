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
/* navigator */
.navigator {height:71px; background:#000 url(http://webimage.10x10.co.kr/eventIMG/2017/75327/txt_jewerly_story.png) no-repeat 0 100%;}
.navigator ul {position:absolute; top:24px; left:551px; width:570px; }
.navigator ul li {float:left; display:block; width:45px; height:25px; margin:2px 2px 0 0; }
.navigator ul li span,
.navigator ul li a,
.navigator ul li a:hover,
.navigator ul li a.on {display:block; width:100%; height:100%; margin-right:2px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/75327/txt_monthly_v3.png) 0 0 no-repeat; text-indent:-999em; transition:all 0.3s;}
.navigator ul li a.on,
.navigator ul li a:hover {margin-top:-3px;}
.navigator ul li.feb span {background-position:-48px 0;}
.navigator ul li.mar span {background-position:-95px 0;}
.navigator ul li.apr span {background-position:-142px 0;}
.navigator ul li.may span {background-position:-189px 0;}
.navigator ul li.jun span {background-position:-236px 0;}
.navigator ul li.jul span {background-position:-283px 0;}
.navigator ul li.aug span {background-position:-330px 0;}
.navigator ul li.sep span {background-position:-377px 0;}
.navigator ul li.oct span {background-position:-424px 0;}
.navigator ul li.nov span {background-position:-471px 0;}
.navigator ul li.dec span {background-position:-519px 0;}
.navigator ul li.jan a {background-position: 0 100%;}
.navigator ul li.feb a {background-position:-48px 100%;}
.navigator ul li.mar a {background-position:-95px 100%;}
.navigator ul li.apr a {background-position:-142px 100%;}
.navigator ul li.may a {background-position:-189px 100%;}
.navigator ul li.jun a{background-position:-236px 100%;}
.navigator ul li.jul a {background-position:-283px 100%;}
.navigator ul li.aug a {background-position:-330px 100%;}
.navigator ul li.sep a {background-position:-377px 100%;}
.navigator ul li.oct a {background-position:-424px 100%;}
.navigator ul li.nov a {background-position:-471px 100%;}
.navigator ul li.dec a{background-position:-519px 100%;}
.navigator ul li.jan a.on,
.navigator ul li.jan a:hover{background-position:0 -25px;}
.navigator ul li.feb a.on,
.navigator ul li.feb a:hover{background-position:-48px -25px;}
.navigator ul li.mar a.on,
.navigator ul li.mar a:hover {background-position:-95px -25px;}
.navigator ul li.apr a.on,
.navigator ul li.apr a:hover {background-position:-142px -25px;}
.navigator ul li.may a.on,
.navigator ul li.may a:hover {background-position:-189px -25px;}
.navigator ul li.jun a.on,
.navigator ul li.jun a:hover {background-position:-236px -25px;}
.navigator ul li.jul a.on,
.navigator ul li.jul a:hover {background-position:-283px -25px;}
.navigator ul li.aug a.on,
.navigator ul li.aug a:hover {background-position:-330px -25px;}
.navigator ul li.sep a.on,
.navigator ul li.sep a:hover {background-position:-377px -25px;}
.navigator ul li.oct a.on,
.navigator ul li.oct a:hover {background-position:-424px -25px;}
.navigator ul li.nov a.on,
.navigator ul li.nov a:hover {background-position:-471px -25px;}
.navigator ul li.dec a.on,
.navigator ul li.dec a:hover {background-position:-519px -25px;}
</style>
</head>
<body>
	<div class="navigator">
		<ul>
			<li class="jan"><a href="/event/eventmain.asp?eventid=75327" target="_top" <% If Request("eventid") = "75327" Then %>class="on"<% End If %>>1월</a></li>

			<% If currentdate < "2017-02-08" then %>
				<li class="feb"><span>2월</span></li>
			<% Else %>
				<li class="feb"><a href="/event/eventmain.asp?eventid=76019" target="_top" <% If Request("eventid") = "76019" Then %>class="on"<% End If %>>2월</a></li>
			<% End If %>

			<% If currentdate < "2017-03-08" then %>
				<li class="mar"><span>3월</span></li>
			<% Else %>
				<li class="mar"><a href="/event/eventmain.asp?eventid=76532" target="_top" <% If Request("eventid") = "76532" Then %>class="on"<% End If %>>3월</a></li>
			<% End If %>

			<% If currentdate < "2017-04-05" then %>
				<li class="apr"><span>4월</span></li>
			<% Else %>
				<li class="apr"><a href="/event/eventmain.asp?eventid=77138" target="_top" <% If Request("eventid") = "77138" Then %>class="on"<% End If %>>4월</a></li>
			<% End If %>

			<% If currentdate < "2017-05-10" then %>
				<li class="may"><span>5월</span></li>
			<% Else %>
				<li class="may"><a href="/event/eventmain.asp?eventid=77778" target="_top" <% If Request("eventid") = "77778" Then %>class="on"<% End If %>>5월</a></li>
			<% End If %>

			<% If currentdate < "2017-06-08" then %>
				<li class="jun"><span>6월</span></li>
			<% Else %>
				<li class="jun"><a href="/event/eventmain.asp?eventid=78363" target="_top" <% If Request("eventid") = "78363" Then %>class="on"<% End If %>>6월</a></li>
			<% End If %>

			<% If currentdate < "2017-07-07" then %>
				<li class="jul"><span>7월</span></li>
			<% Else %>
				<li class="jul"><a href="/event/eventmain.asp?eventid=00000" target="_top" <% If Request("eventid") = "00000" Then %>class="on"<% End If %>>7월</a></li>
			<% End If %>

			<% If currentdate < "2017-08-07" then %>
				<li class="aug"><span>8월</span></li>
			<% Else %>
				<li class="aug"><a href="/event/eventmain.asp?eventid=00000" target="_top" <% If Request("eventid") = "00000" Then %>class="on"<% End If %>>8월</a></li>
			<% End If %>

			<% If currentdate < "2017-09-07" then %>
				<li class="sep"><span>9월</span></li>
			<% Else %>
				<li class="sep"><a href="/event/eventmain.asp?eventid=00000" target="_top" <% If Request("eventid") = "00000" Then %>class="on"<% End If %>>10월</a></li>
			<% End If %>

			<% If currentdate < "2017-09-07" then %>
				<li class="oct"><span>10월</span></li>
			<% Else %>
				<li class="oct"><a href="/event/eventmain.asp?eventid=00000" target="_top" <% If Request("eventid") = "00000" Then %>class="on"<% End If %>>10월</a></li>
			<% End If %>

			<% If currentdate < "2017-11-07" then %>
				<li class="nov"><span>11월</span></li>
			<% Else %>
				<li class="nov"><a href="/event/eventmain.asp?eventid=00000" target="_top" <% If Request("eventid") = "00000" Then %>class="on"<% End If %>>11월</a></li>
			<% End If %>

			<% If currentdate < "2017-11-07" then %>
				<li class="dec"><span>12월</span></li>
			<% Else %>
				<li class="dec"><a href="/event/eventmain.asp?eventid=00000" target="_top" <% If Request("eventid") = "00000" Then %>class="on"<% End If %>>12월</a></li>
			<% End If %>
		</ul>
	</div>
</body>
</html>