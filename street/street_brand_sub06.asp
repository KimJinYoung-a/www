<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% Response.CharSet = "UTF-8" %>
<%
    '// STAFF거나 BIZ회원등급이고 BIZ모드상태면 b2b검색결과
    If request.cookies("bizMode") = "Y" And (session("ssnuserlevel") = "7" OR session("ssnuserlevel") = "9") Then
        server.Execute("/biz/brand.asp")

    '// 그 외 모두 일반 검색결과
    Else
        server.Execute("/street/exec_street_brand_sub06.asp")
    End If
%>