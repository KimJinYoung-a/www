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
.navigator {overflow:hidden; width:264px; height:70px; margin:0 auto;}
.navigator li {display:none; overflow:hidden; position:relative; float:left; width:88px; height:70px; text-align:center; background:url(http://webimage.10x10.co.kr/eventIMG/2017/80684/blt_round.png) no-repeat 100% 50%;}
.navigator li a {display:block; height:70px;}
.navigator li.open img,
.navigator li.current img {margin-top:-70px;}
.navigator li.current:after {content:''; display:inline-block; position:absolute; left:0; bottom:0; width:100%; height:4px; background:#fff;}
</style>
<script>
$(function(){
	$(".navigator li.open").last().show().css("background","none");
	$(".navigator li.open").last().prev().show();
	$(".navigator li.open").last().prev().prev().show();
});
</script>
</head>
<body>
<ul id="navigator" class="navigator">
	<% if currentdate < "2017-10-19" then %>
	<li><img src="http://webimage.10x10.co.kr/eventIMG/2017/80684/txt_date_4.png" alt="10.19" /></li>
	<% Else %>
	<li class="open <%=CHKIIF(vEventID="81215"," current","")%>">
		<a href="/event/eventmain.asp?eventid=81215" target="_top"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80684/txt_date_4.png" alt="10.19" /></a>
	</li>
	<% End If %>

	<% if currentdate < "2017-10-26" then %>
	<li><img src="http://webimage.10x10.co.kr/eventIMG/2017/80684/txt_date_5.png" alt="10.26" /></li>
	<% Else %>
	<li class="open <%=CHKIIF(vEventID="81398"," current","")%>">
		<a href="/event/eventmain.asp?eventid=81398" target="_top"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80684/txt_date_5.png" alt="10.26" /></a>
	</li>
	<% End If %>

	<% if currentdate < "2017-11-02" then %>
	<li><img src="http://webimage.10x10.co.kr/eventIMG/2017/80684/txt_date_6.png" alt="11.02" /></li>
	<% Else %>
	<li class="open <%=CHKIIF(vEventID="81647"," current","")%>">
		<a href="/event/eventmain.asp?eventid=81647" target="_top"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80684/txt_date_6.png" alt="11.02" /></a>
	</li>
	<% End If %>

	<% if currentdate < "2017-11-09" then %>
	<li><img src="http://webimage.10x10.co.kr/eventIMG/2017/80684/txt_date_7.png" alt="11.09" /></li>
	<% Else %>
	<li class="open <%=CHKIIF(vEventID="81838"," current","")%>">
		<a href="/event/eventmain.asp?eventid=81838" target="_top"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80684/txt_date_7.png" alt="11.09" /></a>
	</li>
	<% End If %>

	<% if currentdate < "2017-11-16" then %>
	<li><img src="http://webimage.10x10.co.kr/eventIMG/2017/80684/txt_date_8.png" alt="11.16" /></li>
	<% Else %>
	<li class="open <%=CHKIIF(vEventID="82076"," current","")%>">
		<a href="/event/eventmain.asp?eventid=82076" target="_top"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80684/txt_date_8.png" alt="11.16" /></a>
	</li>
	<% End If %>

	<% if currentdate < "2017-11-23" then %>
	<li><img src="http://webimage.10x10.co.kr/eventIMG/2017/80684/txt_date_9.png" alt="11.23" /></li>
	<% Else %>
	<li class="open <%=CHKIIF(vEventID="82195"," current","")%>">
		<a href="/event/eventmain.asp?eventid=82195" target="_top"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80684/txt_date_9.png" alt="11.23" /></a>
	</li>
	<% End If %>

	<% if currentdate < "2017-11-30" then %>
	<li><img src="http://webimage.10x10.co.kr/eventIMG/2017/80684/txt_date_10.png" alt="11.30" /></li>
	<% Else %>
	<li class="open <%=CHKIIF(vEventID="82514"," current","")%>">
		<a href="/event/eventmain.asp?eventid=82514" target="_top"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80684/txt_date_10.png" alt="11.30" /></a>
	</li>
	<% End If %>

	<% if currentdate < "2017-12-07" then %>
	<li><img src="http://webimage.10x10.co.kr/eventIMG/2017/80684/txt_date_11.png" alt="12.07" /></li>
	<% Else %>
	<li class="open <%=CHKIIF(vEventID="82776"," current","")%>">
		<a href="/event/eventmain.asp?eventid=82776" target="_top"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80684/txt_date_11.png" alt="12.07" /></a>
	</li>
	<% End If %>

	<% if currentdate < "2017-12-14" then %>
	<li><img src="http://webimage.10x10.co.kr/eventIMG/2017/80684/txt_date_12.png" alt="12.14" /></li>
	<% Else %>
	<li class="open <%=CHKIIF(vEventID="82988"," current","")%>">
		<a href="/event/eventmain.asp?eventid=82988" target="_top"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80684/txt_date_12.png" alt="12.14" /></a>
	</li>
	<% End If %>

	<% if currentdate < "2017-12-21" then %>
	<li><img src="http://webimage.10x10.co.kr/eventIMG/2017/80684/txt_date_13.png" alt="12.21" /></li>
	<% Else %>
	<li class="open <%=CHKIIF(vEventID="83161"," current","")%>">
		<a href="/event/eventmain.asp?eventid=83161" target="_top"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80684/txt_date_13.png" alt="12.21" /></a>
	</li>
	<% End If %>

	<% if currentdate < "2017-12-28" then %>
	<li><img src="http://webimage.10x10.co.kr/eventIMG/2017/80684/txt_date_14.png" alt="12.28" /></li>
	<% Else %>
	<li class="open <%=CHKIIF(vEventID="83172"," current","")%>">
		<a href="/event/eventmain.asp?eventid=83172" target="_top"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80684/txt_date_14.png" alt="12.28" /></a>
	</li>
	<% End If %>

	<% if currentdate < "2018-01-04" then %>
	<li><img src="http://webimage.10x10.co.kr/eventIMG/2017/80684/txt_date_15.png" alt="01.04" /></li>
	<% Else %>
	<li class="open <%=CHKIIF(vEventID="83483"," current","")%>">
		<a href="/event/eventmain.asp?eventid=83483" target="_top"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80684/txt_date_15.png" alt="01.04" /></a>
	</li>
	<% End If %>

	<% if currentdate < "2018-01-11" then %>
	<li><img src="http://webimage.10x10.co.kr/eventIMG/2017/80684/txt_date_16.png" alt="01.11" /></li>
	<% Else %>
	<li class="open <%=CHKIIF(vEventID="83619"," current","")%>">
		<a href="/event/eventmain.asp?eventid=83619" target="_top"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80684/txt_date_16.png" alt="01.11" /></a>
	</li>
	<% End If %>

	<% if currentdate < "2018-01-17" then %>
	<li><img src="http://webimage.10x10.co.kr/eventIMG/2017/80684/txt_date_0117.png" alt="01.17" /></li>
	<% Else %>
	<li class="open <%=CHKIIF(vEventID="83732"," current","")%>">
		<a href="/event/eventmain.asp?eventid=83732" target="_top"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80684/txt_date_0117.png" alt="01.17" /></a>
	</li>
	<% End If %>

	<% if currentdate < "2018-01-23" then %>
	<li><img src="http://webimage.10x10.co.kr/eventIMG/2017/80684/txt_date_0123.png" alt="01.23" /></li>
	<% Else %>
	<li class="open <%=CHKIIF(vEventID="83943"," current","")%>">
		<a href="/event/eventmain.asp?eventid=83943" target="_top"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80684/txt_date_0123.png" alt="01.23" /></a>
	</li>
	<% End If %>

	<% if currentdate < "2018-01-26" then %>
	<li><img src="http://webimage.10x10.co.kr/eventIMG/2017/80684/txt_date_0126.png" alt="01.26" /></li>
	<% Else %>
	<li class="open <%=CHKIIF(vEventID="84017"," current","")%>">
		<a href="/event/eventmain.asp?eventid=84017" target="_top"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80684/txt_date_0126.png" alt="01.26" /></a>
	</li>
	<% End If %>

	<% if currentdate < "2018-01-30" then %>
	<li><img src="http://webimage.10x10.co.kr/eventIMG/2017/80684/txt_date_0130.png" alt="01.30" /></li>
	<% Else %>
	<li class="open <%=CHKIIF(vEventID="84203"," current","")%>">
		<a href="/event/eventmain.asp?eventid=84203" target="_top"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80684/txt_date_0130.png" alt="01.30" /></a>
	</li>
	<% End If %>

</ul>
</body>
</html>