<%

Class DiaryItemsCls
	public fidx
	public fbrandid
	public fmainbrandimg
	public fbrandtext
	public fbrandmovieurl
	public fitemimgid
	public fitemid
	public fisusing
	public fsortnum
	public fregdate
	public fpcmainbrandtextimg
	public fmomainbrandimg
	public fleftright
	public FImageList
End Class

Class DiaryCls

	Public FItemList()
	public FOneItem
	Public FRectIdx
	Public FRectIsusing
	Public FRectbrandid
	
	public FResultCount
	public FPageSize
	public FCurrPage
	public Ftotalcount
	public FScrollCount
	public FTotalpage
	public FPageCount

	public sub fcontents_list()
		dim sqlStr,i

		'총 갯수 구하기
		sqlStr = "select count(*) as cnt" + vbcrlf
		sqlStr = sqlStr & " from db_diary2010.dbo.tbl_diaryspecial_brand" & vbcrlf
        sqlStr = sqlStr & " where 1=1 and isusing ='Y' "  & vbcrlf

		rsget.Open sqlStr,dbget,1
			FTotalCount = rsget("cnt")
		rsget.Close

		if FTotalCount < 1 then exit sub

		'데이터 리스트
		sqlStr = "select top " & Cstr(FPageSize * FCurrPage) + vbcrlf
		sqlStr = sqlStr & " idx, brandid, mainbrandimg, brandtext, brandmovieurl, isusing, sortnum, regdate, pcmainbrandtextimg, momainbrandimg, leftright" & vbcrlf
		sqlStr = sqlStr & " ,STUFF(( " & vbcrlf
'		sqlStr = sqlStr & " SELECT ',' + i.basicimage, '/!/'+cast(i.itemid as varchar(10)) " & vbcrlf
		sqlStr = sqlStr & " SELECT ',' + i.tentenimage200, '/!/'+cast(i.itemid as varchar(10)) " & vbcrlf
		sqlStr = sqlStr & " FROM db_item.dbo.tbl_item as i" & vbcrlf
		sqlStr = sqlStr & " WHERE i.itemid in (" & vbcrlf
		sqlStr = sqlStr & " select itemid from db_diary2010.dbo.tbl_diaryspecial_brand_itemid where vidx=a.idx" & vbcrlf
		sqlStr = sqlStr & " )" & vbcrlf
		sqlStr = sqlStr & " FOR XML PATH ('')) ,1,1,'') AS itemimgid " & vbcrlf
		sqlStr = sqlStr & " from db_diary2010.dbo.tbl_diaryspecial_brand a" & vbcrlf
        sqlStr = sqlStr & " where 1=1 and isusing = 'Y' " & vbcrlf

		sqlStr = sqlStr & " order by sortnum asc, idx desc " + vbcrlf

'response.write sqlStr &"<br>"
		rsget.pagesize = FPageSize
		rsget.Open sqlStr,dbget,1

        FtotalPage =  CInt(FTotalCount\FPageSize)
		if  (FTotalCount\FPageSize)<>(FTotalCount/FPageSize) then
			FtotalPage = FtotalPage +1
		end if
		FResultCount = rsget.RecordCount-(FPageSize*(FCurrPage-1))

        if (FResultCount<1) then FResultCount=0

        redim preserve FItemList(FResultCount)

		i=0
		if  not rsget.EOF  then
			rsget.absolutepage = FCurrPage
			do until rsget.EOF
				set FItemList(i) = new DiaryItemsCls

				FItemList(i).fidx				= rsget("idx")
				FItemList(i).fbrandid			= rsget("brandid")
				FItemList(i).fmainbrandimg	= rsget("mainbrandimg")
				FItemList(i).fbrandtext		= db2html(rsget("brandtext"))
				FItemList(i).fbrandmovieurl	= db2html(rsget("brandmovieurl"))
				FItemList(i).fitemimgid			= rsget("itemimgid")
				FItemList(i).fisusing			= rsget("isusing")
				FItemList(i).fsortnum			= rsget("sortnum")
				FItemList(i).fregdate			= rsget("regdate")

				FItemList(i).fpcmainbrandtextimg	= rsget("pcmainbrandtextimg")
				FItemList(i).fmomainbrandimg		= rsget("momainbrandimg")
				FItemList(i).fleftright			= rsget("leftright")
				
'				FItemList(i).FImageList	= "http://webimage.10x10.co.kr/image/list/" & GetImageSubFolderByItemid(FItemList(i).fevt_code) & "/" &db2html(rsget("ListImage"))
'				FItemList(i).FImageList120	= "http://webimage.10x10.co.kr/image/list120/" & GetImageSubFolderByItemid(FItemList(i).fevt_code) & "/" & db2html(rsget("ListImage120"))
'				FItemList(i).FImageSmall	= "http://webimage.10x10.co.kr/image/small/" & GetImageSubFolderByItemid(FItemList(i).fevt_code) & "/" &db2html(rsget("smallImage"))
'				FItemList(i).FImageicon1 = "http://webimage.10x10.co.kr/image/icon1/" & GetImageSubFolderByItemid(FItemList(i).fevt_code) & "/" & rsget("icon1image")
'				FItemList(i).FImageicon2 = "http://webimage.10x10.co.kr/image/icon2/" & GetImageSubFolderByItemid(FItemList(i).fevt_code) & "/" & rsget("icon2image")



				rsget.movenext
				i=i+1
			loop
		end if
		rsget.Close
	end sub

	
	Private Sub Class_Initialize()
		FCurrPage =1
		FPageSize = 50
		FResultCount = 0
		FScrollCount = 10
		FTotalCount =0
	End Sub
	Private Sub Class_Terminate()

	End Sub
	
	public Function HasPreScroll()
		HasPreScroll = StartScrollPage > 1
	end Function

	public Function HasNextScroll()
		HasNextScroll = FTotalPage > StartScrollPage + FScrollCount -1
	end Function

	public Function StartScrollPage()
		StartScrollPage = ((FCurrpage-1)\FScrollCount)*FScrollCount +1
	end Function

End Class

function getbrandname(makerid)
	dim sqlstr, tmpexists
	tmpexists=""

	if makerid="" then
		getbrandname=tmpexists
		exit function
	end if

	sqlstr = "select top 1 brandname from db_item.dbo.tbl_item where makerid='" & makerid &"'"
	
	'response.write sqlstr & "<Br>"
	rsget.CursorLocation = adUseClient
	rsget.CursorType=adOpenStatic
	rsget.Locktype=adLockReadOnly
	rsget.Open sqlstr, dbget
	if Not(rsget.EOF or rsget.BOF) then
		tmpexists=rsget("brandname")
	else
		tmpexists=""
	end if
	rsget.Close
	
	getbrandname=tmpexists
end function
%>