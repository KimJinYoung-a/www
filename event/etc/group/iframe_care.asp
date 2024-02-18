<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/inc/head.asp" -->
<%
dim currentdate
	currentdate = date()

	Dim vEventID
	vEventID = requestCheckVar(Request("eventid"),9)
%>
<style type="text/css">
.careSeries {overflow:hidden; width:286px; height:34px;}
.careSeries ul {float:right; padding-right:34px;}
.careSeries li {float:left; width:34px; height:34px; margin-left:9px; }
.careSeries li span {display:block; position:relative; width:34px; height:34px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/78835/txt_nav_default.png) no-repeat 0 0;}
.careSeries li a {display:none; position:absolute; left:0; top:0; width:100%; height:100%; text-indent:-999em;}
.careSeries li.open span {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/78835/txt_nav.png)}
.careSeries li span a:hover,.careSeries li.current span {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/78835/txt_nav_on.png)}
.careSeries li.season1 span a,.careSeries li.season1 span {background-position:0 0;}
.careSeries li.season2 span a,.careSeries li.season2 span {background-position:-43px 0;}
.careSeries li.season3 span a,.careSeries li.season3 span {background-position:-86px 0;}
.careSeries li.season4 span a,.careSeries li.season4 span {background-position:-129px 0;}
.careSeries li.season5 span a,.careSeries li.season5 span {background-position:-172px 0;}
.careSeries li.open span a {display:block;}
</style>
</head>
<body>
<div class="careSeries">
	<ul>
		<%'  오픈된 이벤트 open, 오늘 날짜에 current 클래스 %>
		<% if currentdate < "2017-06-19" then %>
		<li class="season1">
		<% Else %>
		<li class="season1 open <%=CHKIIF(vEventID="78570"," current","")%>">
		<% End If %>
			<span><a href="/event/eventmain.asp?eventid=78570" target="_top">01.Cooling</a></span>
		</li>

		<% if currentdate < "2017-07-06" then %>
		<li class="season2">
		<% Else %>
		<li class="season2 open <%=CHKIIF(vEventID="78835"," current","")%>">
		<% End If %>
			<span><a href="/event/eventmain.asp?eventid=78835" target="_top">02. Rainy season</a></span>
		</li>

		<% if currentdate < "2017-07-13" then %>
		<li class="season3">
		<% Else %>
		<li class="season3 open <%=CHKIIF(vEventID="79187"," current","")%>">
		<% End If %>
			<span><a href="/event/eventmain.asp?eventid=79187" target="_top">03. Body</a></span>
		</li>

		<% if currentdate < "2017-08-24" then %>
		<li class="season4">
		<% Else %>
		<li class="season4 open <%=CHKIIF(vEventID="80104"," current","")%>">
		<% End If %>
			<span><a href="/event/eventmain.asp?eventid=80104" target="_top">04. After holiday</a></span>
		</li>

		<% if currentdate < "2017-11-23" then %>
		<li class="season5">
		<% Else %>
		<li class="season5 open <%=CHKIIF(vEventID="81514"," current","")%>">
		<% End If %>
			<span><a href="/event/eventmain.asp?eventid=81514" target="_top">05.</a></span>
		</li>
	</ul>
</div>
</body>
</html>