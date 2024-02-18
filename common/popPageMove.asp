<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<!-- #include virtual="/lib/util/commlib.asp" -->

<%
dim isOpen, strPath,blnclose

isOpen  = requestCheckVar(request("isOpen"),2)
strPath = requestCheckVar(request("strPath"),128)
blnclose = requestCheckVar(request("blnclose"),1)

%>
<script type="text/javascript">
function jsReload(isOpen, strPath,blnclose){
	if (isOpen == "on"){
		if(strPath=="") {
			opener.top.location.reload();
		} else {
			opener.top.location.href=strPath;
		}

		if(blnclose=="Y"){		
		    self.close();
		}
	} else {
		if(strPath=="") {
			location.reload();
		} else {
			location.href=strPath;
		}
	}
}

jsReload('<%= isOpen %>','<%= strPath %>','<%= blnclose %>');	
</script>	

