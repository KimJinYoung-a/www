<%
Class Hitchhiker
	Public FHVol
	Public FEvt_code
	Public FUserlevel
	Public FVHVol
	Public FUserId
	Public FAppCount

	Public Function fnGetHitchCont
		Dim strSql
		strSql =""
		strSql = strSql & " select top 1 HVol, evt_code " & vbcrlf
		strSql = strSql & " ,(select top 1 userlevel from db_user.dbo.tbl_logindata where userlevel in (3, 4, 6, 7) and userid = '"&FUserId&"') as ulevel " & vbcrlf
		strSql = strSql & " ,(select top 1 HVol from [db_user].[dbo].[tbl_user_hitchhiker] as h where h.hvol = v.hvol and userid = '"&FUserId&"') as VHVol" & vbcrlf
		strSql = strSql & " ,(SELECT COUNT(1) FROM db_user.dbo.tbl_user_hitchhiker WHERE HVol = v.Hvol) as appCount" & vbcrlf
		strSql = strSql & " from db_event.dbo.tbl_vip_hitchhiker as v " & vbcrlf
		If GetLoginUserID = "10x10vvip" or GetLoginUserID = "10x10vipgold" or GetLoginUserID="dlwjseh" Then
			strSql = strSql & " where isusing = 'Y' " & vbcrlf
		Else
			strSql = strSql & " where getdate()>= startdate and getdate() <= enddate " & vbcrlf
			strSql = strSql & " and isusing = 'Y' " & vbcrlf
		End If
		rsget.Open strSql, dbget, 1
'rw strSql
		If rsget.RecordCount > 0 Then
			IF not rsget.EOF THEN
				FHVol 		= rsget("HVol")
				FEvt_code 	= rsget("evt_code")
				FUserlevel 	= rsget("ulevel")
				FVHVol 		= rsget("VHVol")
				FAppCount   = rsget("appCount")
			END IF
		Else
			FHVol = ""
			FEvt_code = ""
			FUserlevel = ""
			FVHVol = ""
			FAppCount = 0
		End If
		rsget.Close
	End Function
End Class
%>