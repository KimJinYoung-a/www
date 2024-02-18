<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%Response.Addheader "P3P","policyref='/w3c/p3p.xml', CP='NOI DSP LAW NID PSA ADM OUR IND NAV COM'"%>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>

<%
dim backpath

backpath = request("backpath")


response.Cookies("tinfo").domain = "10x10.co.kr"
response.Cookies("tinfo") = ""
response.Cookies("tinfo").Expires = Date - 1


session.abandon

dim referer
referer = request.ServerVariables("HTTP_REFERER")


response.redirect "/offshop/"

%>