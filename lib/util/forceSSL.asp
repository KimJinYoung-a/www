<%
   If Request.ServerVariables("SERVER_PORT")=80 and left(Request.ServerVariables("REMOTE_ADDR"),9)<>"10.10.10." Then
      Dim strSecureURL
      strSecureURL = "https://"
      if instr(Request.ServerVariables("SERVER_NAME"),"www")>0 then
      	strSecureURL = strSecureURL & Request.ServerVariables("SERVER_NAME")
      else
      	strSecureURL = strSecureURL & "www.10x10.co.kr"
      end if
      strSecureURL = strSecureURL & Request.ServerVariables("URL")

	  if Request.Querystring <> "" then
		  strSecureURL = strSecureURL & "?" & Request.Querystring
	  end if

      Response.Redirect strSecureURL
   End If
%>
