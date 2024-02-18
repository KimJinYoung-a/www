<%

'// 웹, 앱, 모바일에 공통적으로 적용하려면 /imgstatic/lib/badgelib.asp 참조
'// 어드민에 파일 생성(로그 등록 + 쿠키X = 재로그인시 알림 받음)

'' /lib/util/myalarmlib.asp
'' /lib/util/scm_myalarmlib.asp

''  msgdiv 	구분					입력 시점
'' ===========================================================================
''  000		단체알림
'' 	001		신규가입쿠폰			회원가입시
'' 	002		쿠폰만료				일 1회(새벽)
'' 	003		장바구니 상품 이벤트	MyAlarm_CheckNewMyAlarm 실행시
'' 	004		위시 상품 이벤트		MyAlarm_CheckNewMyAlarm 실행시
'' 	005		1:1 상담				일 1회(새벽,어제날짜로)
'' 	006		상품 QnA				일 1회(새벽,어제날짜로)
'' 	007		이벤트 당첨				일 1회
''  901		관심상품 없음
''  902		관련이벤트 없음

Function MyAlarm_InsertMyAlarm(userid, msgdiv, title, subtitle, contents, wwwTargetURL)
	dim strSql, i

	'// 중복입력 안함(1:!상담, 상품QNA는 허용)
	strSql = "exec [db_my10x10].[dbo].[usp_Ten_MyAlarm_ProcInsertLOG] '" + CStr(userid) + "', '" + CStr(msgdiv) + "', '" + CStr(html2db(title)) + "', '" + CStr(html2db(subtitle)) + "', '" + CStr(html2db(contents)) + "', '" + CStr(wwwTargetURL) + "'"
	dbget.Execute strSql

	response.Cookies("myalarm").domain = "10x10.co.kr"
	response.Cookies("myalarm")("newmyalarm") = "Y"
End Function

Function MyAlarm_CheckNewMyAlarm(userid, userlevel)
	dim strSql, result

	MyAlarm_CheckNewMyAlarm = False
	result = "N"

	'// MY알림 : 장바구니 상품, 위시 상품에 대한 이벤트 알림 데이타 생성
	strSql = " exec [db_my10x10].[dbo].[usp_Ten_MyAlarm_CreateEventMyAlarm] '" + CStr(userid) + "' "
	dbget.Execute(strSql)

	'// MY알림 : 쿠폰만료 체크
	strSql = " exec [db_my10x10].[dbo].[usp_Ten_MyAlarm_CreateCouponExpireMyAlarm] '" + CStr(userid) + "' "
	dbget.Execute(strSql)

	strSql = " [db_my10x10].[dbo].[usp_Ten_MyAlarm_CheckNewMyAlarm] ('" + CStr(userid) + "', " + CStr(userlevel) + ") "
	rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
	IF Not (rsget.EOF OR rsget.BOF) THEN
		result = rsget("newalarmexist")
	END IF
	rsget.close

	response.Cookies("myalarm").domain = "10x10.co.kr"
	response.Cookies("myalarm")("checkdate") = Left(FormatDate(Now, "0000.00.00-00:00:00"), 13)
	if (result = "Y") then
		response.Cookies("myalarm")("newmyalarm") = "Y"
		MyAlarm_CheckNewMyAlarm = True
	else
		response.Cookies("myalarm")("newmyalarm") = "N"
	end if
End Function

Function MyAlarm_SetNewMyAlarmAsRead(userid)
	dim strSql, result

	MyAlarm_SetNewMyAlarmAsRead = True

	strSql = " exec [db_my10x10].[dbo].[usp_Ten_MyAlarm_SetNewMyAlarmAsRead] '" + CStr(userid) + "' "
	dbget.Execute(strSql)

	response.Cookies("myalarm").domain = "10x10.co.kr"
	response.Cookies("myalarm")("newmyalarm") = "N"
End Function

'// 하루치만(페이제 상단 마이알림)
Function MyAlarm_MyAlarmList(userid, yyyymmdd, userlevel)
	Dim strSql

	strSql =" [db_my10x10].[dbo].[usp_Ten_MyAlarmGetList] ('" + CStr(userid) + "', '" + CStr(yyyymmdd) + "', " + CStr(userlevel) + ") "
	rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
	IF Not (rsget.EOF OR rsget.BOF) THEN
		MyAlarm_MyAlarmList = rsget.GetRows()
	END IF
	rsget.close
end Function

'// 5일치(마이 텐바이텐 마이알림)
Function MyAlarm_MyAlarmList_MAIN(userid, userlevel)
	Dim strSql

	strSql =" [db_my10x10].[dbo].[usp_Ten_MyAlarmGetList_MAIN] ('" + CStr(userid) + "', " + CStr(userlevel) + ") "
	rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
	IF Not (rsget.EOF OR rsget.BOF) THEN
		MyAlarm_MyAlarmList_MAIN = rsget.GetRows()
	END IF
	rsget.close
end Function

%>
