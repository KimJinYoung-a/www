<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/login/checklogin.asp" -->
<%
	Dim vCooKies, vItemID, vTemp, i
	vItemID = Replace(requestCheckVar(Trim(request("itemid")),400)," ","")
	
	If isNumeric(Replace(vItemID,",","")) = False Then
		Response.End
	Else
		vTemp = Trim(request.cookies("todayviewitemidlist"))
		
		For i = LBound(Split(vItemID,",")) To UBound(Split(vItemID,","))
			vTemp = Replace(vTemp,Split(vItemID,",")(i),"")
			vTemp = Replace(vTemp,"||","|")
		Next
		
		IF vTemp = "|" Then
			vTemp = ""
		End If
		'response.cookies("todayviewitemidlist") = vTemp
	End IF
%>
<script>
function SetCookieTodayView(name, value) {
    var argv = SetCookieTodayView.arguments;
    var argc = SetCookieTodayView.arguments.length;
    var expires = (2 < argc) ? argv[2] : null;
    var path = (3 < argc) ? argv[3] : null;
    var domain = (4 < argc) ? argv[4] : null;
    var secure = (5 < argc) ? argv[5] : false;

    document.cookie = name + "=" + escape (value) +
    ((expires == null) ? "" :
    ("; expires=" + expires.toGMTString())) +
    ((path == null) ? "" : ("; path=" + path)) +
    ((domain == null) ? "" : ("; domain=" + domain)) +
    ((secure == true) ? "; secure" : "");
}

SetCookieTodayView("todayviewitemidlist", "<%=vTemp%>", null, "/", "10x10.co.kr");
parent.location.reload();
</script>