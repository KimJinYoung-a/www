<%
'####### 이 파일은 위시리스트 이벤트용 include. 같은 이름의 폴더 체크를 하는 용도.
If Now() > #02/11/2015 00:00:00# AND Now() < #02/28/2015 00:00:00# Then
	Dim vCheck
	vCheck = "x"

	If stype = "U" Then
		strSql = "[db_my10x10].[dbo].[sp_Ten_Wishlist_Event_NameCheck] ('"&fidx&"', '"&userid&"','"&foldername&"')"
		rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
		IF Not rsget.Eof Then
			vFolderName = rsget(0)
			vViewIsUsing = rsget(1)
		END IF
		rsget.close

		IF foldername <> vFolderName AND trim(foldername) = "넣어둬 넣어둬" Then

		Else
			vCheck = "o"
		End IF
	End IF

	If stype = "I" OR stype = "U" Then
		IF trim(foldername) = "넣어둬 넣어둬" Then
			Dim strSql, vCount, vFolderName, vViewIsUsing
			vCount = 0

			If vCheck = "x" Then
				'넣어둬 넣어둬 용
				strSql = "Select COUNT(fidx) From [db_my10x10].[dbo].[tbl_myfavorite_folder]  WHERE foldername = '" & trim(foldername) & "' and userid='" & userid & "' "
				rsget.Open strSql,dbget,1
				IF Not rsget.Eof Then
					vCount = rsget(0)
				END IF
				rsget.Close

'				'괜찮아요? 용
'				strSql = "Select COUNT(fidx) From [db_my10x10].[dbo].[tbl_myfavorite_folder]  WHERE foldername = '" & trim(foldername) & "' and userid='" & userid & "' "
'				rsget.Open strSql,dbget,1
'				IF Not rsget.Eof Then
'					vCount = rsget(0)
'				END IF
'				rsget.Close

'				기존 몽땅용
'				strSql = "[db_my10x10].[dbo].[sp_Ten_Wishlist_Event_NameCheck] ('0', '"&userid&"','"&foldername&"')"
'				rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
'				IF Not rsget.Eof Then
'					vCount = rsget(0)
'				END IF
'				rsget.close

				IF vCount > 0 Then
					Response.Write "<script>alert('한개의 폴더만 만들 수 있습니다.');history.back();</script>"
					dbget.close()
					Response.End
				End IF
			End IF
		End IF
	End IF
End If
%>