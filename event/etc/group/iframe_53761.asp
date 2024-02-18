<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  이벤트코드 53761 BEST TRAVEL BRAND5
' History : 2014.07.25 이종화 생성
'####################################################

 Dim eCode ,  egCode

	eCode = getNumeric(requestCheckVar(Request("eventid"),8)) '이벤트 코드번호
	egCode = getNumeric(requestCheckVar(Request("eGC"),8))	'이벤트 그룹코드

	If egCode = "100455" Then
		If Now() < #07/29/2014 00:00:00# Then
			Response.write "<script>alert('7월 29일 오픈 예정입니다');history.back(-1);</script>"
		End If 
	End If 
	
	If egCode = "100456" Then
		If Now() < #07/30/2014 00:00:00# Then
			Response.write "<script>alert('7월 30일 오픈 예정입니다');history.back(-1);</script>"
		End If 
	End If 

	If egCode = "100457" Then
		If Now() < #07/31/2014 00:00:00# Then
			Response.write "<script>alert('7월 31일 오픈 예정입니다');history.back(-1);</script>"
		End If 
	End If 

	If egCode = "100458" Then
		If Now() < #08/01/2014 00:00:00# Then
			Response.write "<script>alert('8월 1일 오픈 예정입니다');history.back(-1);</script>"
		End If 
	End If 

%>
<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
.evt53761 {position:relative; text-align:center;}
.evt53761 {position:relative;}
.evt53761 .travelBrand {height:183px; padding-left:152px;  background:url(http://webimage.10x10.co.kr/eventIMG/2014/53761/bg_date_tab.jpg) left top no-repeat;}
.evt53761 .travelBrand ul {overflow:hidden;}
.evt53761 .travelBrand ul li {float:left; width:167px; height:183px; }
.evt53761 .travelBrand ul li a {display:block; height:183px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2014/53761/tab_off.jpg); background-repeat:no-repeat; text-indent:-9999px;}
.evt53761 .travelBrand ul li.open a{background-image:url(http://webimage.10x10.co.kr/eventIMG/2014/53761/tab_open.jpg);}
.evt53761 .travelBrand ul li.on a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2014/53761/tab_on.jpg);}
.evt53761 .travelBrand ul li.tb02 {width:166px;}
.evt53761 .travelBrand ul li.tb01 a {background-position:left top;}
.evt53761 .travelBrand ul li.tb02 a {background-position:-167px top;}
.evt53761 .travelBrand ul li.tb03 a {background-position:-333px top;}
.evt53761 .travelBrand ul li.tb04 a {background-position:-500px top;}
.evt53761 .travelBrand ul li.tb05 a {background-position:-667px top;}
</style>
</head>
<body>
<div class="evt53761">
	<div class="travelBrand">
		<ul>
				<li class="tb01 <%=chkiif(Now() > #07/28/2014 00:00:00#,"open","")%> <%=chkiif(egCode=""," on","")%>"><a href="/event/eventmain.asp?eventid=53761" target="_parent">28일 - MONOPOLY</a></li>
				<li class="tb02 <%=chkiif(Now() > #07/29/2014 00:00:00#,"open","")%> <%=chkiif(egCode="100455"," on","")%>"><a href="<%=chkiif(Now() > #07/29/2014 00:00:00# ,"/event/eventmain.asp?eventid=53761&eGc=100455","javascript:alert('7월 29일 오픈 예정입니다.');")%>" target="_parent">29일 - ANORAK</a></li>
				<li class="tb03 <%=chkiif(Now() > #07/30/2014 00:00:00#,"open","")%> <%=chkiif(egCode="100456"," on","")%>"><a href="<%=chkiif(Now() > #07/30/2014 00:00:00# ,"/event/eventmain.asp?eventid=53761&eGc=100456","javascript:alert('7월 30일 오픈 예정입니다.');")%>" target="_parent">30일 - INVITE.L</a></li>
				<li class="tb04 <%=chkiif(Now() > #07/31/2014 00:00:00#,"open","")%> <%=chkiif(egCode="100457"," on","")%>"><a href="<%=chkiif(Now() > #07/31/2014 00:00:00# ,"/event/eventmain.asp?eventid=53761&eGc=100457","javascript:alert('7월 31일 오픈 예정입니다.');")%>" target="_parent">31일 - WEEKADE</a></li>
				<li class="tb05 <%=chkiif(Now() > #08/01/2014 00:00:00#,"open","")%> <%=chkiif(egCode="100458"," on","")%>"><a href="<%=chkiif(Now() > #08/01/2014 00:00:00# ,"/event/eventmain.asp?eventid=53761&eGc=100458","javascript:alert('8월 1일 오픈 예정입니다.');")%>" target="_parent">1일 - INSTAX</a></li>
		</ul>
	</div>
	<% If Now() > #07/28/2014 00:00:00# And egCode= "" Then %>
	<div>
		<img src="http://webimage.10x10.co.kr/eventIMG/2014/53761/img_monopoly.jpg" alt="MONOPOLY" usemap="#map2" />
		<map name="map2" id="map2">
				<area shape="rect" coords="236,247,530,670" href="/shopping/category_prd.asp?itemid=1101073" target="_top" />
				<area shape="rect" coords="609,247,907,669" href="/shopping/category_prd.asp?itemid=1101072" target="_top" />
		</map>
	</div>
	<% ElseIf Now() > #07/29/2014 00:00:00# And egCode= "100455" Then %>
	<div>
		<img src="http://webimage.10x10.co.kr/eventIMG/2014/53761/img_anorak.jpg" alt="MONOPOLY" usemap="#map3" />
		<map name="map3" id="map3">
			<area shape="rect" coords="118,251,404,671" href="/shopping/category_prd.asp?itemid=1051261" target="_top" />
			<area shape="rect" coords="425,249,714,670" href="/shopping/category_prd.asp?itemid=1051262" target="_top" />
			<area shape="rect" coords="732,250,1029,670" href="/shopping/category_prd.asp?itemid=1051271" target="_top" />
		</map>
	</div>
	<% ElseIf Now() > #07/30/2014 00:00:00# And egCode= "100456" Then %>
	<div>
		<img src="http://webimage.10x10.co.kr/eventIMG/2014/53761/img_invitel.jpg" alt="INVITE.L" usemap="#map4" />
		<map name="map4" id="map4">
			<area shape="rect" coords="118,251,404,671" href="/shopping/category_prd.asp?itemid=1103485" target="_top" />
			<area shape="rect" coords="425,249,714,670" href="/shopping/category_prd.asp?itemid=1103487" target="_top" />
			<area shape="rect" coords="732,250,1029,670" href="/shopping/category_prd.asp?itemid=1103488" target="_top" />
		</map>
	</div>
	<% ElseIf Now() > #07/31/2014 00:00:00# And egCode= "100457" Then %>
	<div>
		<img src="http://webimage.10x10.co.kr/eventIMG/2014/53761/img_weekade.jpg" alt="WEEKADE" usemap="#map5" />
		<map name="map5" id="map5">
			<area shape="rect" coords="118,251,404,671" href="/shopping/category_prd.asp?itemid=1079570" target="_top" />
			<area shape="rect" coords="425,249,714,670" href="/shopping/category_prd.asp?itemid=1075748" target="_top" />
			<area shape="rect" coords="732,250,1029,670" href="/shopping/category_prd.asp?itemid=1075747" target="_top" />
		</map>
	</div>
	<% ElseIf Now() > #08/01/2014 00:00:00# And egCode= "100458" Then %>
	<div>
		<img src="http://webimage.10x10.co.kr/eventIMG/2014/53761/img_instax.jpg" alt="INSTAX" usemap="#map6" />
		<map name="map6" id="map6">
			<area shape="rect" coords="118,251,404,671" href="/shopping/category_prd.asp?itemid=1087961" target="_top" />
			<area shape="rect" coords="425,249,714,670" href="/shopping/category_prd.asp?itemid=1039511" target="_top" />
			<area shape="rect" coords="732,250,1029,670" href="/shopping/category_prd.asp?itemid=957974" target="_top" />
		</map>
	</div>
	<% End If %>
</div>
</body>
</html>