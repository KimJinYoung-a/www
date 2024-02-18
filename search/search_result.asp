<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
Response.CharSet = "UTF-8"

'#######################################################
'	History	: 2013.08.19 허진원 생성
'				2013.12.30 한용민 수정
'				2015.06.01 허진원 - 2015 리뉴얼
'				2021.04.23 B2B서비스로인해 execute페이지로 변경
'	Description : 검색 결과
'#######################################################
%>
<%
    '// STAFF거나 BIZ회원등급이고 BIZ모드상태면 b2b검색결과
    If request.cookies("bizMode") = "Y" Then
        server.Execute("/search/exc_b2b_search.asp")

    '// 그 외 모두 일반 검색결과
    Else
        server.Execute("/search/exc_search.asp")
    End If
%>