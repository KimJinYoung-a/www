<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
    '// STAFF거나 BIZ회원등급이고 BIZ모드상태면 b2b카테고리 리스트
    If request.cookies("bizMode") = "Y" Then
        server.Execute("/shopping/exc_b2b_category_list.asp")

    '// 그 외 모두 일반 카테고리 리스트
    Else
        server.Execute("/shopping/exc_category_list.asp")
    End If
%>