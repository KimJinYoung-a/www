<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<HTML>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script type="text/javascript">
		function setLGDResult() {
			if( parent.LGD_window_type == "iframe" ){
				parent.setLGDResult();
			} else {
				opener.setLGDResult();
				window.close();
			}
		}
		
	</script>

</HEAD>

<body onload="setLGDResult()">
<%
Dim i
    ''주석처리하면 안됨. 
	For Each i In Request.Form
        Response.Write "<input type=hidden id=" & i & " " & "value='" & Request.Form(i)  & "' >"
  	Next
%>
</BODY>
</HTML>
