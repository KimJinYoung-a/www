<%@ codepage="65001" language="VBScript" %>
<%
	''####### 이미지 원래 사이즈 900 x 800
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Untitled Document</title>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
}
-->
</style>
<script language="JavaScript">
<!--
function FlashEmbed(fid,fn,wd,ht,para)
{
	document.write('<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0" width="' + wd + '" height="' + ht + '" id="' + fid + '" align="middle">');
	document.write('<param name="allowScriptAccess" value="always">');
	document.write('<param name="movie" value="' + fn + para + '">');
	document.write('<param name="menu" value="false">');
	document.write('<param name="quality" value="high">');
	document.write('<param name="wmode" value="transparent">');
	document.write('<embed src="' + fn + para + '" menu="false" quality="high" wmode="transparent" width="' + wd + '" height="' + ht + '" name="' + fid + '" align="middle" allowScriptAccess="always" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />');
	document.write('</object>');
}
//-->
</script>
<link href="/lib/css/2009ten.css" rel="stylesheet" type="text/css">
</head>

<body marginwidth = "0" marginheight = "0" leftmargin = "0" topmargin = "0">
	<div style="width:100%; height:100%;">
		<script language="javascript">FlashEmbed("street_index","posswf.swf","100%","100%","?streeturl=/offshop/flash/point1010mainflash_431.txt&q=<%=LEFT(now(),10)%>");</script>
	</div>
</body>
</html>
