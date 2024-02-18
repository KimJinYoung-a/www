<%
class CCBankingItem

	public Fidx
	public Fbankdate
	public Fjukyo
	public Ftenbank
    public FCount

	Private Sub Class_Initialize()

	End Sub

	Private Sub Class_Terminate()

	End Sub
end Class

Class CBanking

	public FItemList()
	public FTotalCount
	public FCurrPage
	public FTotalPage
	public FPageSize
	public FResultCount
	public FScrollCount
	public FPCount
	public FRectSearchText
	public FRectSearch

	Private Sub Class_Initialize()
		redim preserve FItemList(0)

		FCurrPage         = 1
		FPageSize         = 10
		FResultCount      = 0
		FScrollCount      = 10
		FTotalCount       = 0

	End Sub

	Private Sub Class_Terminate()

	End Sub

    public Sub GetRecentBankingListDate()
        dim sql, i

        sql = "exec [db_order].[dbo].sp_Ten_UnConfirmedIpkumSummary " + CStr(FPageSize) + "," + "7"
		rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
        rsget.pagesize = FPageSize

		rsget.Open sql, dbget, 1

		FResultCount = rsget.RecordCount
		FTotalCount  = FResultCount

		redim preserve FItemList(FResultCount)

		if  not rsget.EOF  then
		    i = 0
			rsget.absolutepage = FCurrPage
			do until rsget.eof
				set FItemList(i) = new CCBankingItem

				FItemList(i).Fbankdate    = rsget("bankdate")
				FItemList(i).FCount       = rsget("cnt")

				i=i+1
				rsget.moveNext
			loop
		end if
		rsget.close
    end Sub

	public Sub GetBankingList()
		dim sql, i

		sql = "select count(idx) as cnt "
		sql = sql + " from [db_order].[dbo].tbl_ipkum_list "
		sql = sql + " where datediff(m,bankdate,getdate()) <= 2"
		sql = sql + " and ipkumstate = 1"
    		if FRectSearch = "dt" then
    		    sql = sql + " and bankdate= '" + FRectSearchText + "'"
    		elseif FRectSearch = "nm" then
    		    sql = sql + " and jukyo like '" + FRectSearchText + "%'"
    		end if

		rsget.Open sql, dbget, 1
		FTotalCount = rsget("cnt")
		rsget.close


		sql = "select top " + CStr(FPageSize * FCurrPage) + " idx, bankdate, jukyo, tenbank"
		sql = sql + " from [db_order].[dbo].tbl_ipkum_list"
		sql = sql + " where datediff(m,bankdate,getdate()) <= 2"
		sql = sql + " and ipkumstate = 1"
    		if FRectSearch = "dt" then
    		    sql = sql + " and bankdate= '" + FRectSearchText + "'"
    		elseif FRectSearch = "nm" then
    		    sql = sql + " and jukyo like '" + FRectSearchText + "%'"
    		end if
		sql = sql + " order by idx desc"

		rsget.pagesize = FPageSize
		rsget.Open sql, dbget, 1

		FtotalPage =  CInt(FTotalCount\FPageSize)
		if  (FTotalCount\FPageSize)<>(FTotalCount/FPageSize) then
			FtotalPage = FtotalPage +1
		end if
		FResultCount = rsget.RecordCount-(FPageSize*(FCurrPage-1))
		if (FResultCount<1) then FResultCount=0

		FPCount = FCurrPage - 1
		redim preserve FItemList(FResultCount)
		if  not rsget.EOF  then
		    i = 0
			rsget.absolutepage = FCurrPage
			do until rsget.eof
				set FItemList(i) = new CCBankingItem

				FItemList(i).Fidx           = rsget("idx")
				FItemList(i).Fbankdate      = rsget("bankdate")
				FItemList(i).Fjukyo         = rsget("jukyo")
				FItemList(i).Ftenbank       = rsget("tenbank")

				i=i+1
				rsget.moveNext
			loop
		end if
		rsget.close
	end sub


	public Function HasPreScroll()
		HasPreScroll = StartScrollPage > 1
	end Function

	public Function HasNextScroll()
		HasNextScroll = FTotalPage > StartScrollPage + FScrollCount -1
	end Function

	public Function StartScrollPage()
		StartScrollPage = ((FCurrpage-1)\FScrollCount)*FScrollCount +1
	end Function
end Class

%>
