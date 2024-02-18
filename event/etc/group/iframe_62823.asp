<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/inc/head.asp" -->
<%
	Dim vEventID
	vEventID = Request("eventid")
	If vEventID = "" Then
		vEventID = "62823"
	End If
	If isNumeric(vEventID) = False Then
		Response.End
	End If
	If Len(vEventID) <> 5 Then
		Response.End
	End If
%>
<style>
.navList {overflow:hidden;}
.navList li {float:left; width:76px; height:76px; margin-left:14px; background-position:left top; background-repeat:no-repeat;}
.navList li a {display:none; width:76px; height:76px; text-indent:-9999em;}
.navList li.no01, .navList li.no01 a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/62823/txt_series_navi01.png);}
.navList li.no02, .navList li.no02 a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/62823/txt_series_navi02.png);}
.navList li.no03, .navList li.no03 a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/62823/txt_series_navi03.png);}
.navList li.no04, .navList li.no04 a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/62823/txt_series_navi04.png);}
.navList li.no05, .navList li.no05 a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/62823/txt_series_navi05.png);}
.navList li.no06, .navList li.no06 a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/62823/txt_series_navi06.png);}
.navList li.no07, .navList li.no07 a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/62823/txt_series_navi07.png);}
.navList li.no08, .navList li.no08 a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/62823/txt_series_navi08.png);}
.navList li.open a {display:block; background-position:left -76px;}
.navList li.current a {display:block; background-position:left -152px !important;}
</style>
<ol class="navList">
	<li class="no01<%=CHKIIF(date()>="2015-05-27"," open","")%><%=CHKIIF(vEventID="62823"," current","")%>"><a href="/event/eventmain.asp?eventid=62823" target="_top">No.1</a></li>
	<li class="no02<%=CHKIIF(date()>="2015-07-01"," open","")%><%=CHKIIF(vEventID="64020"," current","")%>"><a href="/event/eventmain.asp?eventid=64020" target="_top">No.2</a></li>
	<li class="no03<%=CHKIIF(date()>="2015-07-31"," open","")%><%=CHKIIF(vEventID="65143"," current","")%>"><a href="/event/eventmain.asp?eventid=65143" target="_top">No.3</a></li>
	<li class="no04<%=CHKIIF(date()>="2015-08-26"," open","")%><%=CHKIIF(vEventID="65668"," current","")%>"><a href="/event/eventmain.asp?eventid=65668" target="_top">No.4</a></li>
	<li class="no05<%=CHKIIF(date()>="2015-09-30"," open","")%><%=CHKIIF(vEventID="66257"," current","")%>"><a href="/event/eventmain.asp?eventid=66257" target="_top">No.5</a></li>
	<li class="no06<%=CHKIIF(date()>="2015-10-28"," open","")%><%=CHKIIF(vEventID="66935"," current","")%>"><a href="/event/eventmain.asp?eventid=66935" target="_top">No.6</a></li>
	<li class="no07<%=CHKIIF(date()>="2015-11-30"," open","")%><%=CHKIIF(vEventID="67724"," current","")%>"><a href="/event/eventmain.asp?eventid=67724" target="_top">No.7</a></li>
	<li class="no08<%=CHKIIF(date()>="2015-12-30"," open","")%><%=CHKIIF(vEventID="68408"," current","")%>"><a href="/event/eventmain.asp?eventid=68408" target="_top">No.8</a></li>

</ol>
</body>
</html>