<%
'###########################################################
' Description :  사이트맵 클래스
' History : 2013.08.29 한용민 생성
'###########################################################

Class csitemap_item
	Public Fmakerid
	Public Fcatecode
	Public Fdepth
	Public Fcatename
	Public Fcatename_e
	Public Fuseyn
	Public FsortNo
	public fcate1name
	Public fisNew
End Class

Class csitemap
	Public FItemList()
	Public FOneItem
	Public FTotalCount
	Public FPageSize
	Public FCurrPage
	Public FResultCount
	Public FTotalPage
	Public FPageCount
	Public FScrollCount
	
	'//common/sitemap.asp
	Public Sub getdispCategory_2depth_all_notpaging
		Dim sqlStr, i, sqladd

		sqlStr = "exec db_item.[dbo].[sp_Ten_dispCategory_2depth_all_notpaging]"

		'Response.write sqlStr &"<br>"
        rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
        rsget.pagesize = FPageSize
		rsget.Open sqlStr,dbget,1

		Ftotalcount = rsget.RecordCount
		FResultCount = rsget.RecordCount
		Redim preserve FItemList(FResultCount)
		i = 0
		If  not rsget.EOF  then
			rsget.absolutepage = FCurrPage
			Do until rsget.eof
				Set FItemList(i) = new csitemap_item

					FItemList(i).fcatecode = rsget("catecode")
					FItemList(i).fdepth = rsget("depth")
					FItemList(i).fcatename = db2html(rsget("catename"))
					FItemList(i).fcatename_e = db2html(rsget("catename_e"))
					FItemList(i).fuseyn = rsget("useyn")
					FItemList(i).fsortNo = rsget("sortNo")
					FItemList(i).fcate1name = db2html(rsget("cate1name"))
					FItemList(i).fisNew = rsget("isnew")
					
				i = i + 1
				rsget.moveNext
			Loop
		End If
		rsget.Close
	End Sub
	
	Private Sub Class_Initialize()
		FCurrPage =1
		FPageSize = 50
		FResultCount = 0
		FScrollCount = 10
		FTotalCount =0
	End Sub
	Private Sub Class_Terminate()

	End Sub

	Public Function HasPreScroll()
		HasPreScroll = StartScrollPage > 1
	End Function

	Public Function HasNextScroll()
		HasNextScroll = FTotalPage > StartScrollPage + FScrollCount -1
	End Function

	Public Function StartScrollPage()
		StartScrollPage = ((FCurrpage-1)\FScrollCount)*FScrollCount +1
	End Function
End Class
%>	