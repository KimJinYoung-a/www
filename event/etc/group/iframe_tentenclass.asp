<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
dim currentdate
	currentdate = date()
	'currentdate = "2017-09-19"
	
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
	Dim vEventID
	vEventID = requestCheckVar(Request("eventid"),9)
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
.navigator {width:264px; height:70px; margin:0 auto;}
.navigator li {overflow:hidden; position:relative; float:left; width:88px; height:70px; text-align:center; background:url(http://webimage.10x10.co.kr/eventIMG/2017/80684/blt_round.png) no-repeat 0 49%;}
.navigator li:first-child {background:none;}
.navigator li a {display:block; height:70px;}
.navigator li.open img,
.navigator li.current img {margin-top:-70px;}
.navigator li.current:after {content:''; display:inline-block; position:absolute; left:0; bottom:0; width:100%; height:4px; background:#fff;}
</style>
</head>
<body>
<ul id="navigator" class="navigator">
	<% if currentdate < "2017-09-21" then %>
	<li><img src="http://webimage.10x10.co.kr/eventIMG/2017/80684/txt_date_1_v3.png" alt="09.21" /></li>
	<% Else %>
	<li class="open <%=CHKIIF(vEventID="80684"," current","")%>">
		<a href="/event/eventmain.asp?eventid=80684" target="_top"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80684/txt_date_1_v3.png" alt="09.21" /></a>
	</li>
	<% End If %>

	<% if currentdate < "2017-09-28" then %>
	<li><img src="http://webimage.10x10.co.kr/eventIMG/2017/80684/txt_date_2_v2.png" alt="09.28" /></li>
	<% Else %>
	<li class="open <%=CHKIIF(vEventID="80890"," current","")%>">
		<a href="/event/eventmain.asp?eventid=80890" target="_top"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80684/txt_date_2_v2.png" alt="09.28" /></a>
	</li>
	<% End If %>

	<% if currentdate < "2017-10-12" then %>
	<li><img src="http://webimage.10x10.co.kr/eventIMG/2017/80684/txt_date_3_v3.png" alt="10.12" /></li>
	<% Else %>
	<li class="open <%=CHKIIF(vEventID="81126"," current","")%>">
		<a href="/event/eventmain.asp?eventid=81126" target="_top"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80684/txt_date_3_v3.png" alt="10.12" /></a>
	</li>
	<% End If %>
</ul>
</body>
</html>