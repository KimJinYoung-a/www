<%@  codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "utf-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<%
'####################################################
' Description : 정기세일 메인페이지
' History : 2020-03-27 이종화 생성
'####################################################
dim aType : aType = RequestCheckVar(request("atype"),2)
dim vDisp : vDisp = RequestCheckVar(request("disp"),3)
dim dateGubun : dateGubun = RequestCheckVar(request("dategubun"),1)	'기간별 검색 w:주간, m:월간

if dateGubun="" then dateGubun="w"

Response.Cookies("sale2020")("atype") = aType
Response.Cookies("sale2020")("disp") = vDisp
Response.Cookies("sale2020")("dategubun") = dateGubun
%>
</head>
<body>
<div id="eventDetailV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container fullEvt">
		<div id="contentWrap">
			<div class="eventWrapV15">
                <% server.Execute("/event/sale2020/index.asp") %>
            </div>
        </div>
    </div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>