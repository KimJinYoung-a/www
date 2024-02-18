<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
dim currentdate
	currentdate = date()
	'currentdate = "2015-03-09"
	
	'response.write currentdate

	Dim vEventID, tab1eCode, tab2eCode, eCode
	vEventID = requestCheckVar(Request("eventid"),9)
	If application("Svr_Info") = "Dev" Then
		eCode			= "75869"
		tab1eCode		= "75841"
		tab2eCode		= "75871"

	Else
		eCode			= "75869"
		tab1eCode		= "75841"
		tab2eCode		= "75871"
	End If
%>

<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
.trollTab {width:1124px; margin:0 auto; padding:115px 0 73px;}
.trollTab ul {padding-left:38px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/75869/bg_bar.png) no-repeat 50% 32px;}
.trollTab ul:after {content:" "; display:block; height:0; clear:both; visibility:hidden;}
.trollTab li {position:relative; float:left; width:340px; padding:0 5px;}
.trollTab li p {width:340px; height:146px; background-position:0 0; background-repeat:no-repeat; text-indent:-999em;}
.trollTab li.t1 p {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/75869/tab_01.png);}
.trollTab li.t2 p {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/75869/tab_02.png);}
.trollTab li.t3 p {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/75869/tab_03.png);}
.trollTab li.current p {background-position:0 100%;}
.trollTab li p a {display:block; height:146px;}
.trollTab li span {display:none; position:absolute; left:50%; bottom:146px; width:198px; margin-left:-99px; background-position:50% 0; background-repeat:no-repeat;}
.trollTab li.t1 span {height:115px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/75869/img_character_01.png);}
.trollTab li.t2 span {height:100px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/75869/img_character_02.png);}
.trollTab li.t3 span {height:103px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/75869/img_character_03.png);}
.trollTab li.current span {display:block; animation:move1 infinite 1.2s;}
.trollTab li em {position:absolute; left:50%; top:-16px; margin-left:58px;}
@keyframes move1 {
	0% {padding-bottom:0;}
	100% {padding-bottom:8px;}
}
</style>

</head>
<body>
<div class="trollTab">
	<ul>
		<%' 현재 보고있는 페이지에 클래스 current 넣어주세요 %>
		<li class="t1 <% If vEventID=eCode Then %>current<% End If %>">
			<span></span>
			<p><a href="/event/eventmain.asp?eventid=<%=eCode%>" target="_parent">트롤의 행복을 찾아줘!</a></p>
		</li>
		<li class="t2 <% If vEventID=tab1eCode Then %>current<% End If %>">
			<span></span>
			<!--<em><img src="http://webimage.10x10.co.kr/eventIMG/2017/75869/txt_open.png" alt="2월 6일 OPEN" /></em>-->
			<% If currentdate>="2017-02-06" Then %>
				<p><a href="/event/eventmain.asp?eventid=<%=tab1eCode%>" target="_parent">트롤의 달콤한 선물</a></p>
			<% Else %>
				<p>트롤의 무지갯빛 선물!</p>
			<% End If %>
		</li>
		<li class="t3 <% If vEventID=tab2eCode Then %>current<% End If %>"">
			<span></span>
			<!--<em><img src="http://webimage.10x10.co.kr/eventIMG/2017/75869/txt_open.png" alt="2월 6일 OPEN" /></em>-->
			<% If currentdate>="2017-02-06" Then %>
				<p><a href="/event/eventmain.asp?eventid=<%=tab2eCode%>" target="_parent">트롤과 함께여서 행복해!</a></p>
			<% Else %>
				<p>트롤과 함께여서 행복해!</p>
			<% End If %>
		</li>
	</ul>
</div>
</body>
</html>