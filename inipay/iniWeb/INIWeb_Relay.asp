<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script>
        	function Submit_me(){
       		//frm.target="INIpayStd_Return";
        	frm.submit();
       		//window.close();
        }
        </script>
    </head>

    <body bgcolor="#FFFFFF" text="#242424" leftmargin=0 topmargin=15 marginwidth=0 marginheight=0 bottommargin=0 rightmargin=0 onload="Submit_me()">
<%
'===== 상단에서 받은 폼값 다시 만들기 ==========
'payViewType을 popup사용시 실제 return 받을 페이지 설정 *request returnUrl page 
dim i,iitem
Response.Write "<form name='frm' method='post' action='/inipay/iniWeb/INIWeb_return.asp'>"&Chr(10)
i=0
For each iitem in Request.Form
    for i = 1 to Request.Form(iitem).Count
		Response.Write "<input type='text' name='"&iitem&"' value='"&Request.Form(iitem)(i)&"'>"&Chr(10)
 Next
Next
	Response.Write "</form>"
%>
    </body>
</html>