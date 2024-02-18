<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/inc/head.asp" -->
<%
	Dim vEventID
	vEventID = Request("eventid")
	If vEventID = "" Then
		vEventID = "64210"
	End If
	If isNumeric(vEventID) = False Then
		Response.End
	End If
	If Len(vEventID) <> 5 Then
		Response.End
	End If
%>
<style>
.navList {overflow:hidden;float:right;}
.navList li {float:left; width:50px; height:24px; margin-left:10px; background-position:0 0; background-repeat:no-repeat;}
.navList li a {display:none; width:100%; height:24px; text-indent:-9999px;}
.navList li.open a, .navList li.curent a {display:block;}
.navList li.c01 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/64210/nav_series_01.gif);}
.navList li.c02 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/64210/nav_series_02.gif);}
.navList li.c03 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/64210/nav_series_03.gif);}
.navList li.c04 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/64210/nav_series_04.gif);}
.navList li.c05 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/64210/nav_series_05.gif);}
.navList li.open {background-position:0 -24px;}
.navList li.current {width:120px; background-position:0 -48px;}
</style>
<ul class="navList">
		<li class="c01<%=CHKIIF(date()>="2015-07-06"," open","")%><%=CHKIIF(vEventID="64210"," current","")%>"><a href="/event/eventmain.asp?eventid=64210" target="_top">#01 PINK</a></li>
		<li class="c02<%=CHKIIF(date()>="2015-07-13"," open","")%><%=CHKIIF(vEventID="64323"," current","")%>"><a href="/event/eventmain.asp?eventid=64323" target="_top">#02 BLUE</a></li>
		<li class="c03<%=CHKIIF(date()>="2015-07-20"," open","")%><%=CHKIIF(vEventID="64325"," current","")%>"><a href="/event/eventmain.asp?eventid=64325" target="_top">#03 PURPLE</a></li>
		<li class="c04<%=CHKIIF(date()>="2015-07-27"," open","")%><%=CHKIIF(vEventID="65043"," current","")%>"><a href="/event/eventmain.asp?eventid=65043" target="_top">#04 ROSE GOLD</a></li>
		<li class="c05<%=CHKIIF(date()>="2015-08-03"," open","")%><%=CHKIIF(vEventID="65221"," current","")%>"><a href="/event/eventmain.asp?eventid=65221" target="_top">#05 BLACK</a></li>
</ul>
</body>
</html>