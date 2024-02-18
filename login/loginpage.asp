<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
    '// STAFF거나 BIZ회원등급이고 BIZ모드상태면 b2b검색결과
    If request.cookies("bizMode") = "Y" Then
        server.Execute("/login/exc_b2b_loginpage.asp")

    '// 그 외 모두 일반 검색결과
    Else
        server.Execute("/login/exc_loginpage.asp")
    End If
%>
