<%

'// 검색어 저장 및 표시

Class SearchKeywordRecommandItems

	Private Sub Class_initialize()

	End Sub

	Private Sub Class_Terminate()

	End Sub

	Public FrecommandKeyword
	Public FsearchCount

End Class

class CKeywordCls

	public FItemList()

    public FCurrPage
    public FTotalPage
    public FPageSize
    public FResultCount
    public FScrollCount
    public FTotalCount

	public FRectSearchKeyword

	'// 검색어 저장
	public Function SaveToDatabase(currKeyword, prevKeyword)

		'// @siteGubun : PC/MO : PC 또는 모바일
		dbget.execute "EXECUTE db_log.dbo.usp_Ten_SaveKeyword '" & html2db(Left(currKeyword, 60)) & "', '" + CStr(html2db(Left(prevKeyword, 60))) + "', 'PC' "

	end function

	public Function SaveToDatabaseWithResultCount(currKeyword, prevKeyword, searchResult)

		'// @siteGubun : PC/MO : PC 또는 모바일
		dbget.execute "EXECUTE db_log.dbo.usp_Ten_SaveKeywordWithResultCount '" & html2db(Left(currKeyword, 60)) & "', '" + CStr(html2db(Left(prevKeyword, 60))) + "', 'PC', " + CStr(searchResult) + " "

	end function

	public Function SaveToDatabaseWithDataArray(currKeyword, prevKeyword, dataArray)
		dim searchResult, userid, ipaddress

		searchResult = 0
		userid = ""
		ipaddress = ""

		if IsArray(dataArray) then

			if (UBound(dataArray) >= 0) then
				searchResult = dataArray(0)
			end if

			if (UBound(dataArray) >= 1) then
				userid = dataArray(1)
			end if

			if (UBound(dataArray) >= 2) then
				ipaddress = dataArray(2)
			end if

		end if

		'// @siteGubun : PC/MO : PC 또는 모바일
		if (searchResult="") then searchResult=0
		'rw "EXECUTE db_log.dbo.usp_Ten_SaveKeywordWithResultCount '" & html2db(Left(currKeyword, 60)) & "', '" + CStr(html2db(Left(prevKeyword, 60))) + "', 'PC', " + CStr(searchResult) + ", '" + CStr(userid) + "', '" + CStr(ipaddress) + "' "
		dbget.execute "EXECUTE db_log.dbo.usp_Ten_SaveKeywordWithResultCount '" & html2db(Left(currKeyword, 60)) & "', '" + CStr(html2db(Left(prevKeyword, 60))) + "', 'PC', " + CStr(searchResult) + ", '" + CStr(userid) + "', '" + CStr(ipaddress) + "' "

	end function

	public Function getRecommendKeyWordsProc
	dim sqlStr, i

		'// 20글자를 넘어가면 추천키워드가 없다.
		sqlStr = "exec db_log.dbo.usp_Ten_Recommand_Keyword_List '" + CStr(html2db(Left(FRectSearchKeyword, 20))) + "' "
		''rw sqlStr

		rsget.CursorLocation = 3
		rsget.pagesize = 5				'// 5개
		rsget.Open sqlStr, dbget, 3, 1

		FResultCount = rsget.RecordCount
        if FResultCount<1 then FResultCount=0

		FTotalCount = FResultCount

        redim preserve FItemList(FResultCount)
        if  not rsget.EOF  then
            i = 0
			rsget.absolutepage = 1
            do until rsget.eof
                set FItemList(i) = new SearchKeywordRecommandItems

                FItemList(i).FrecommandKeyword  = rsget("fullKeyword")
				FItemList(i).FsearchCount       = rsget("searchCount")

                rsget.MoveNext
                i = i + 1
            loop
        end if
        rsget.close
	end function

	Private Sub Class_Initialize()

	End Sub

	Private Sub Class_Terminate()

	End Sub

end class

%>
