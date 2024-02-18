<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<%
    '// B2B 모드 변경 후 이동 시켜주는 페이지

    Dim REFERER, bizMode
    REFERER = Request.ServerVariables("HTTP_REFERER")
    bizMode = Request("mode")

    Response.Cookies("bizMode").domain = "10x10.co.kr"
    Response.Cookies("bizMode") = bizMode

    If bizMode = "Y" Then
        Response.Redirect wwwUrl & "/biz/"
    Else
        Response.Redirect wwwUrl & "/"
    End If
%>