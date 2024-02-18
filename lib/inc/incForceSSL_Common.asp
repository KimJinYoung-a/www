<%
	Dim sslCheckUrl : sslCheckUrl = LCase(Request.ServerVariables("URL"))

	If Request.ServerVariables("SERVER_PORT")=80 and left(Request.ServerVariables("REMOTE_ADDR"),9)<>"10.10.10." and application("Svr_Info")<>"Dev" _
		And InStr(sslCheckUrl, "/shopping/category_prd.asp") = 0 AND InStr(sslCheckUrl, "/shopping/inc_itemDescription_iframe.asp") = 0 _
		AND InStr(sslCheckUrl, "/deal/deal.asp") = 0 AND InStr(sslCheckUrl, "/my10x10/popmyfavorite.asp") = 0 _
		AND InStr(sslCheckUrl, "/my10x10/myfavorite_process.asp") = 0 AND InStr(sslCheckUrl, "/my10x10/doitemqna.asp") = 0 Then
		
		Dim strSslSecureURL
		strSslSecureURL = "https://"
		strSslSecureURL = strSslSecureURL & Request.ServerVariables("SERVER_NAME")
		strSslSecureURL = strSslSecureURL & Request.ServerVariables("URL")
		if Request.ServerVariables("QUERY_STRING")<>"" then
			strSslSecureURL = strSslSecureURL & "?" & Request.ServerVariables("QUERY_STRING")
		end if
		Response.Redirect strSslSecureURL
	End If
%>