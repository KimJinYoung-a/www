<%
Class ClsShoppingChance

 public FCPage	'Set 현재 페이지
 public FPSize	'Set 페이지 사이즈
 public FTotCnt	'Get 전체 레코드 갯수

 public FSCType		'전체/세일/사은/상품후기/신규/마감임박/랜덤 구분
 public FSCategory 	'카테고리 대분류
 public FSCateMid 	'카테고리 중분류
 public FEScope		'이벤트 범위
 public FselOp		'이벤트 정렬

	'###fnGetBannerList : 배너리스트  ###
	public Function fnGetBannerList
	    Dim strSql, strSqlCnt
        Dim rsMem
		strSqlCnt ="exec [db_event].[dbo].sp_Ten_event_shoppingchance_listCnt_New_2014 '"&FSCType&"','"&FSCategory&"','"&FSCateMid&"','"&FEScope&"'"
		'rsget.Open strSqlCnt, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
		set rsMem = getDBCacheSQL(dbget,rsget,"SPCS",strSqlCnt,60*5)
		if (rsMem is Nothing) then Exit function ''추가
		    
		IF Not (rsMem.EOF OR rsMem.BOF) THEN
			FTotCnt = rsMem(0)
		END IF
		rsMem.close

		IF FTotCnt > 0 THEN
			strSql = "exec [db_event].[dbo].sp_Ten_event_shoppingchance_list_New_2014 "&FCPage&","&FPSize&",'"&FSCType&"','"&FSCategory&"','"&FSCateMid&"','"&FEScope&"','"&FselOp&"'"
			'rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
			set rsMem = getDBCacheSQL(dbget,rsget,"SPCS",strSql,60*5)
			if (rsMem is Nothing) then Exit function ''추가
			IF Not (rsMem.EOF OR rsMem.BOF) THEN
				fnGetBannerList = rsMem.GetRows()
			END IF
			rsMem.close
		END IF
		set rsMem = Nothing
'response.write strSql
	End Function

	'###fnGetBannerListSpecialcorner : 우수회원 전용코너  ###
	public Function fnGetBannerListSpecialCorner
	    Dim strSql, strSqlCnt
        Dim rsMem
		strSqlCnt ="exec [db_event].[dbo].sp_Ten_event_special_corner_listCnt '"&FSCType&"','"&FSCategory&"','"&FSCateMid&"','"&FEScope&"'"
		'rsget.Open strSqlCnt, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
		set rsMem = getDBCacheSQL(dbget,rsget,"SPCS",strSqlCnt,180)
		if (rsMem is Nothing) then Exit function ''추가
		    
		IF Not (rsMem.EOF OR rsMem.BOF) THEN
			FTotCnt = rsMem(0)
		END IF
		rsMem.close

		IF FTotCnt > 0 THEN
			strSql = "[db_event].[dbo].sp_Ten_event_special_corner_list ("&FCPage&","&FPSize&",'"&FSCType&"','"&FSCategory&"','"&FSCateMid&"','"&FEScope&"','"&FselOp&"')"
			'rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
			set rsMem = getDBCacheSQL(dbget,rsget,"SPCS",strSql,180)
			if (rsMem is Nothing) then Exit function ''추가
			IF Not (rsMem.EOF OR rsMem.BOF) THEN
				fnGetBannerListSpecialCorner = rsMem.GetRows()
			END IF
			rsMem.close
		END IF
		set rsMem = Nothing
'response.write strSql
	End Function


End Class
%>