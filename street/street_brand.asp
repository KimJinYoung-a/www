<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'###########################################################
' Description :  브랜드스트리트
' History : 2013.08.29 한용민 생성
'###########################################################
%>
<%
dim makerid
	makerid = request("makerid")
Dim gaParam
	gaParam = request("gaParam")

response.redirect "/street/street_brand_sub06.asp?makerid="&makerid&"&gaParam="&gaParam

response.end
%>