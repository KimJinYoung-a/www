<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- INCLUDE Virtual="/lib/chkDevice.asp" -->
<%
'####################################################
' Description : 2016 웨딩 just 1week big sale
' History : 2016-03-25 유태욱 생성
'####################################################
%>
<style type="text/css">
body {background-color:transparent;}
.navigator {width:800px; height:195px; margin:0 auto;}
.navigator:after {content:' '; display:block; clear:both;}
.navigator li {float:left; position:relative; width:150px; height:150px; padding-top:45px; margin:0 25px;}
.navigator li a,
.navigator li span {display:block; position:relative; width:100%; height:150px; color:#000; font-size:12px; line-height:150px; text-align:center;}
.navigator li a i,
.navigator li span i {display:block; position:absolute; top:0; left:0; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2016/69756/bg_navigator_date.png) no-repeat 0 0;}
.navigator li .dDay {position:absolute; top:0; left:50%; margin-left:-49px; animation-name:bounce; animation-iteration-count:infinite; animation-duration:2s;}
@keyframes bounce {
	0%, 20%, 50%, 80%, 100% {transform:translateY(0);}
	40% {transform:translateY(7px);}
	60% {transform:translateY(3px);}
}

.navigator li span i {background-position:0 100%;}
.navigator li .today i {background-position:0 -150px;}
.navigator li span.done i {background-position:0 100%;}

.navigator li.nav2 span i {background-position:-199px 0;}
.navigator li.nav2 .today i {background-position:-199px -150px;}
.navigator li.nav2 span.done i {background-position:-199px 100%;}

.navigator li.nav3 span i {background-position:-398px 0;}
.navigator li.nav3 .today i {background-position:-398px -150px;}
.navigator li.nav3 span.done i {background-position:-398px 100%;}

.navigator li.nav4 span i {background-position:100% 0;}
.navigator li.nav4 .today i {background-position:100% -150px;}
.navigator li.nav4 span.done i {background-position:100% 100%;}
</style>
</head>
<body>
<% 
'		69757 JUST 1 WEEK BIG SALE #1 : 3.28-4.03
'		69758 JUST 1 WEEK BIG SALE #2 : 4.04-4.10
'		69759 JUST 1 WEEK BIG SALE #3 : 4.11-4.17
'		69760 JUST 1 WEEK BIG SALE #4 : 4.18-4.24
%>
	<ul class="navigator">
		<% If Date() >="2016-03-25" and Date() < "2016-04-04"then %>
			<li class="nav1">
				<a href="/event/eventmain.asp?eventid=69757" target="_top" class="today">
					<i></i>1주차 3.28-4.03
				</a>
				<% if Date() ="2016-04-03" then %>
					<b class="dDay"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69756/ico_d_day_3.png" alt="D-day" /></b>
				<% end if %>
				<% if Date() ="2016-04-02" then %>
					<b class="dDay"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69756/ico_d_day_2.png" alt="D-1" /></b>
				<% end if %>
				<% if Date() ="2016-04-01" then %>
					<b class="dDay"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69756/ico_d_day_1.png" alt="D-2" /></b>
				<% end if %>
			</li>
		<% else %>
			<% if Date() > "2016-04-03"then %>
				<li class="nav1">
					<span class="done">
						<i></i>1주차 3.28-4.03
					</span>
				</li>
			<% else %>
				<li class="nav1">
					<span>
						<i></i>1주차 3.28-4.03
					</span>
				</li>
			<% end if %>
		<% end if %>

		<% If Date() >="2016-04-04" and Date() < "2016-04-11"then %>
			<li class="nav2">
				<a href="/event/eventmain.asp?eventid=69758" target="_top" class="today">
					<i></i>2주차 4.04-4.10
				</a>
				<% if Date() ="2016-04-10" then %>
					<b class="dDay"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69756/ico_d_day_3.png" alt="D-day" /></b>
				<% end if %>
				<% if Date() ="2016-04-09" then %>
					<b class="dDay"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69756/ico_d_day_2.png" alt="D-1" /></b>
				<% end if %>
				<% if Date() ="2016-04-08" then %>
					<b class="dDay"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69756/ico_d_day_1.png" alt="D-2" /></b>
				<% end if %>
			</li>
		<% else %>
			<% if Date() > "2016-04-10"then %>
				<li class="nav2">
					<span class="done">
						<i></i>2주차 4.04-4.10
					</span>
				</li>
			<% else %>
				<li class="nav2">
					<span>
						<i></i>2주차 4.04-4.10
					</span>
				</li>
			<% end if %>
		<% end if %>

		<% If Date() >="2016-04-11" and Date() < "2016-04-18"then %>
			<li class="nav3">
				<a href="/event/eventmain.asp?eventid=69759" target="_top" class="today">
					<i></i>3주차 4.11-4.17
				</a>
				<% if Date() ="2016-04-18" then %>
					<b class="dDay"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69756/ico_d_day_3.png" alt="D-day" /></b>
				<% end if %>
				<% if Date() ="2016-04-17" then %>
					<b class="dDay"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69756/ico_d_day_2.png" alt="D-1" /></b>
				<% end if %>
				<% if Date() ="2016-04-16" then %>
					<b class="dDay"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69756/ico_d_day_1.png" alt="D-2" /></b>
				<% end if %>
			</li>
		<% else %>
			<% if Date() > "2016-04-17"then %>
				<li class="nav3">
					<span class="done">
						<i></i>3주차 4.11-4.17
					</span>
				</li>
			<% else %>
				<li class="nav3">
					<span>
						<i></i>3주차 4.11-4.17
					</span>
				</li>
			<% end if %>
		<% end if %>

		<% If Date() >="2016-04-18" and Date() < "2016-04-25"then %>
			<li class="nav4">
				<a href="/event/eventmain.asp?eventid=69760" target="_top" class="today">
					<i></i>4주차 4.18-4.24
				</a>
				<% if Date() ="2016-04-24" then %>
					<b class="dDay"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69756/ico_d_day_3.png" alt="D-day" /></b>
				<% end if %>
				<% if Date() ="2016-04-23" then %>
					<b class="dDay"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69756/ico_d_day_2.png" alt="D-1" /></b>
				<% end if %>
				<% if Date() ="2016-04-22" then %>
					<b class="dDay"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69756/ico_d_day_1.png" alt="D-2" /></b>
				<% end if %>
			</li>
		<% else %>
			<% if Date() > "2016-04-24"then %>
				<li class="nav4">
					<span class="done">
						<i></i>4주차 4.18-4.24
					</span>
				</li>
			<% else %>
				<li class="nav4">
					<span>
						<i></i>4주차 4.18-4.24
					</span>
				</li>
			<% end if %>
		<% end if %>
	</ul>
</body>
</html>