<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%Response.Addheader "P3P","policyref='/w3c/p3p.xml', CP='NOI DSP LAW NID PSA ADM OUR IND NAV COM'"%>

<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"

dim bannerImg, bannerMap
if Datediff("d","2009-11-01",date())>=0 then
	bannerImg = "http://fiximage.10x10.co.kr/web2009/okcashbag/okCashbagEventPop091101.jpg"
	bannerMap = "34,184,384,300"
elseif Datediff("d","2009-09-01",date())>=0 then
	bannerImg = "http://fiximage.10x10.co.kr/web2009/okcashbag/okCashbagEventPop090901.gif"
	bannerMap = "34,184,384,300"
elseif Datediff("d","2009-08-01",date())>=0 then
	bannerImg = "http://fiximage.10x10.co.kr/web2009/okcashbag/okCashbagEventPop090801.gif"
	bannerMap = "34,184,384,300"
elseif Datediff("d","2009-07-01",date())>=0 then
	bannerImg = "http://fiximage.10x10.co.kr/web2009/okcashbag/okCashbagEventPop090701.gif"
	bannerMap = "34,184,384,300"
elseif Datediff("d","2009-06-01",date())>=0 then
	bannerImg = "http://fiximage.10x10.co.kr/web2009/okcashbag/okCashbagEventPop090601.gif"
	bannerMap = "34,184,384,300"
else
	bannerImg = "http://fiximage.10x10.co.kr/web2009/okcashbag/okCashbagEventPop090401.gif"
	bannerMap = "34,147,384,263"
end if
%>
<!-- #include virtual="/lib/inc/incPopHeader.asp" -->
<script language="javascript">
<!--
	function setCookie( name, value, expiredays) {
		var todayDate = new Date();
		var dom = document.domain;
		var _domain = "";
		if(dom.indexOf("10x10.co.kr") > 0){
			_domain = "10x10.co.kr";
		}
		todayDate.setDate( todayDate.getDate() + expiredays );
		document.cookie = name + "=" + escape( value ) + "; domain="+_domain+"; path=/; expires=" + todayDate.toGMTString() + ";"
	}
	
	function closeWin() { 
		setCookie( "okCashbagPopChk", "done" , 1 ); 
		self.close();
	}

	function goJoinPage() {
		opener.location="/member/join.asp";
		self.close();
	}

	document.title='OKCashBag';
//-->
</script>
<table width="420" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
	<td><img src="<%=bannerImg%>" width="420" height="380" usemap="#CpMap" /></td>
</tr>
<tr>
	<td align="right" onClick="closeWin()" style="padding:3px 10px 3px 0;font-family: malgun gothic,dotum;font-size: 11px; COLOR: #888888;cursor:pointer;">창닫기</td>
</tr>
</table>
<map name="CpMap" id="CpMap"><area shape="rect" coords="<%=bannerMap%>" href="javascript:goJoinPage()" /></map>
</body>
</html>
