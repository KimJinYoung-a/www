<%
Function userInfo_chk()
	If request.cookies("update_chk") = "" Then
		Dim sqlStr
		sqlStr = "exec [db_sitemaster].[dbo].[sp_Ten_userInfo_cnt] '" + GetLoginUserID + "' " + vbcrlf

		rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
		rsget.Open sqlStr, dbget, 1

		If rsget("cnt") <> 0 Then
			response.write "<script>"
			response.write "location.href='"& referer &"';"
			response.write "</script>"
		Else
			response.write "<script>"
			response.write "alert('참여해주셔서 감사합니다.\n이벤트에 당첨되시면 회원 정보에 등록된\n핸드폰 번호로 당첨을 알려드립니다.\n\n핸드폰 번호, 주소에 변동이 있을 경우\n미리 회원 정보를 수정해주세요.');"
			response.write "</script>"
		End If
		response.Cookies("update_chk").domain = "10x10.co.kr"
		response.cookies("update_chk") = "Y"
		response.cookies("update_chk").expires = date + 90

		rsget.Close
	End If
End function
%>