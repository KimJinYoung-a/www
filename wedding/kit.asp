<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventCls.asp" -->
<!-- #include virtual="/lib/classes/item/iteminfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<%
Dim eCode, intI, cEventItem, egCode, itemlimitcnt, eitemsort
eCode=67500
%>
<link rel="stylesheet" type="text/css" href="/lib/css/wedding2018.css?v=2.03" />
<script type="text/javascript" src="/event/etc/json/js_applyItemInfo.js"></script>
<script type="text/javascript">
$(function(){
	fnApplyItemInfoList({
		items:"1929160, 1916507, 1923319, 1919740, 1924512",
		target:"kit-list",
		fields:["sale","price"],
		unit:"ew"
	});
});
</script>
</head>
<body>
<div class="wrap fullEvt">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<!-- 	<base href="http://www.10x10.co.kr/"> -->
	<div class="container wedding2018">
		<!-- 웨딩기획전 -->
		<div id="contentWrap" class="simple-kit">
			<!-- #include virtual="/wedding/head.asp" -->
			<% server.Execute("/wedding/lib/wedding_kit.asp") %>
		</div>
		<div class="evtPdtListWrapV15">
		<% server.Execute("/wedding/evt_itemlist.asp") %>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->