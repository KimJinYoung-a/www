<%@ codepage="65001" language="VBScript" %>
<% response.Charset="UTF-8" %>
<%
 
''카카오페이
' Dim objKMPay1, objKMPay2
' Set objKMPay1 = Server.CreateObject("LGCNS.KMPayService.MPayCallWebService")
' Set objKMPay2 = Server.CreateObject("LGCNS.CNSPayService.CnsPayWebConnector")

' SET objKMPay1 = Nothing
' SET objKMPay2 = Nothing

 
dim xmlHttp
Set xmlHttp = server.CreateObject("Microsoft.XMLHTTP")
SET xmlHttp = Nothing
 
dim oXML
Set oXML = Server.CreateObject("Msxml2.ServerXMLHTTP.3.0")
Set oXML = Nothing


dim objEncData
Set objEncData = Server.CreateObject("CAPICOM.EncryptedData")
set objEncData = Nothing


dim fso
set fso=Server.CreateObject("Scripting.FileSystemObject")
if (NOT fso.FileExists(server.mappath("/chtml/dispcate/html/") & "\"&"cate_menu_new_all.js")) then
response.write "<font color=red><b>TTT</b></font>"
end if
set fso=Nothing


'set fso=Server.CreateObject("Scripting.FileSystemObject")
'if (NOT fso.FileExists(server.mappath("/chtml/dispcate/html/") & "\"&"cate_menu_new_all_TT.js")) then
'response.write "<font color=blue>TT</font>"
'end if
'set fso=Nothing
'
'set fso=Server.CreateObject("Scripting.FileSystemObject")
'if (NOT fso.FileExists(server.mappath("/chtml/dispcate/html/") & "\"&"cate_menu_js_loader_T.html")) then
'response.write "<font color=cyan>T</font>"
'end if
'set fso=Nothing
%> 
<font size="2">.
<%="Now : " & now%><br>
<%="SVR : " & Application("Svr_Info")%><br>
<%
''Application("G_1STSCH_ADDR")="192.168.0.210"
'Application("G_2NDSCH_ADDR")="192.168.0.207"
response.write Application("G_1STSCH_ADDR") & "<br>"
response.write Application("G_2NDSCH_ADDR") & "<br>"
response.write Application("G_3RDSCH_ADDR") & "<br>"
response.write Application("G_4THSCH_ADDR") & "<br>"
%>
</font>
<%
response.end


	Dim sCurrUrl, sCurrFile
	sCurrUrl = Request.ServerVariables("url")
	sCurrFile = right(sCurrUrl,len(sCurrUrl)-inStrRev(sCurrUrl,"/"))
	sCurrUrl = left(sCurrUrl,inStrRev(sCurrUrl,"/"))
	response.Write sCurrUrl & ", " & sCurrFile
%>
<br>
<TABLE border=0 width="100%" cellpadding="3" cellspacing="2" bgcolor="#FFFFFF">
<% For Each key in Request.ServerVariables %>
    <TR>
        <TD bgcolor="#E8E8E8"><%=key %></TD>
        <TD bgcolor="#F2F2F2">
        <% 
            if Request.ServerVariables(key) = "" Then
                Response.Write "&nbsp;" 
            else 
                Response.Write Request.ServerVariables(key)
            end if
        %>
        </TD>
    </TR>
<% Next %>
</TABLE>