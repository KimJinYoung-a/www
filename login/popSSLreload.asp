<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<!-- #include virtual="/lib/util/commlib.asp" -->

<%
dim isOpen, strPath,blnclose
isOpen  = request("isOpen")
strPath = request("strPath")
blnclose = request("blnclose")

%>
<script type="text/javascript">
<!--
function jsReload(isOpen, strPath,blnclose){
	if (isOpen == "on"){
		if(blnclose=="Y"){
			opener.top.location.reload();
			self.close();	//2008.04.11 정윤정 추가
			return;  //2016/01/07
		}else if(blnclose=="YY"){//sns로그인
			opener.location.replace(strPath);
			self.close();	//2008.04.11 정윤정 추가
			return;  //2016/01/07
		}else if(blnclose=="YI"){//sns pop 로그인
//			opener.close();
			opener.top.location.reload();	
		} else {
			opener.top.location.reload();	
		}
	}

	location.href = strPath;		
}

jsReload('<%= isOpen %>','<%= strPath %>','<%= blnclose %>');	
//-->
</script>	

