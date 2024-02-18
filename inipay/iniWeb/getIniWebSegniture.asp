<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<!-- #include virtual="/inipay/iniWeb/INIWeb_Util.asp" -->
<%
    '// 주문 후 결제 변경일 경우 oid값은 orderserial로 날려준다.
    If Trim(request("ords")) <> "" Then
        INIWEB_oid = request("ords")
    End If
    
%>
<input type=hidden name=oid value="<%=INIWEB_oid%>">
<input type=hidden name=timestamp value="<%=INIWEB_timestamp%>">
<input type=hidden name=signature value="<%=getIniWebSignature(INIWEB_oid,request("prc"),INIWEB_timestamp)%>">
