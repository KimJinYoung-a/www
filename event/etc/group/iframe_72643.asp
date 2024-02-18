<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- INCLUDE Virtual="/lib/chkDevice.asp" -->
<%
'####################################################
' Description : the pen fair
' History : 2016-08-26 유태욱 생성
'####################################################
%>
<%
Dim Ecode

Ecode = requestCheckVar(Request("eventid"),8)
%>
<style>
.penNav {width:1140px; height:103px;}
.penNav ul {overflow:hidden;}
.penNav li {float:left; width:228px; height:103px; background-position:0 0; background-repeat:no-repeat;}
.penNav li span {display:block; width:228px; height:103px;}
.penNav li a {display:none; width:228px; height:103px; text-indent:-999em;}
.penNav li.nav1,.penNav li.nav1 span {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/72643/txt_nav_1.png);}
.penNav li.nav2,.penNav li.nav2 span {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/72643/txt_nav_2.png);}
.penNav li.nav3,.penNav li.nav3 span {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/72643/txt_nav_3_v1.png);}
.penNav li.nav4,.penNav li.nav4 span {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/72643/txt_nav_4.png);}
.penNav li.nav5,.penNav li.nav5 span {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/72643/txt_nav_5_v2.png);}
.penNav li.open span {background-position:0 -103px;}
.penNav li.current span {background-position:0 100%;}
.penNav li.open span a,
.penNav li.current span a {display:block;}
</style>
</head>
<body>
	<div class="penNav">
		<ul>
			<!-- for dev msg : 오픈된 페이지 open / 현재 보고있는 페이지 current 클래스 붙여주세요-->
			<% If Date() >="2016-08-26" then %>
				<li class="nav1 <% If Date() >="2016-08-26" then %>open<% end if %> <% if Ecode="72643" then %> current<% end if %>"><span><a href="<% If Date() >="2016-08-26" then %>/event/eventmain.asp?eventid=72643<% end if %>" target="_top">25가지 볼펜</a></span></li>
				<li class="nav2 <% If Date() >="2016-09-05" then %>open<% end if %> <% if Ecode="72720" then %> current<% end if %>"><span><a href="<% If Date() >="2016-09-05" then %>/event/eventmain.asp?eventid=72720<% end if %>" target="_top">25가지 젤펜</a></span></li>

				<li class="nav3 <% If Date() >="2016-09-12" then %>open<% end if %> <% if Ecode="72923" then %> current<% end if %>"><span><a href="<% If Date() >="2016-09-12" then %>/event/eventmain.asp?eventid=72923<% end if %>" target="_top">25가지 만년필/캘리펜</a></span></li>
				<li class="nav4 <% If Date() >="2016-09-19" then %>open<% end if %> <% if Ecode="72924" then %> current<% end if %>"><span><a href="<% If Date() >="2016-09-19" then %>/event/eventmain.asp?eventid=72924<% end if %>" target="_top">25가지 멀티펜/젤펜</a></span></li>
				<li class="nav5 <% If Date() >="2016-09-26" then %>open<% end if %> <% if Ecode="73013" then %> current<% end if %>"><span><a href="<% If Date() >="2016-09-26" then %>/event/eventmain.asp?eventid=73013<% end if %>" target="_top">25가지 펠트팁펜</a></span></li>
			<% end if %>
		</ul>
	</div>
</body>
</html>