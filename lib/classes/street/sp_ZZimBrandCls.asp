<%
'#######################################################
'	History	:  2009.04.15 한용민 2008프론트이동/추가/수정
'	Description : 찜브랜드
'#######################################################
%>
<%
Class CMyZZimBrandItem
    public Fmakerid
    public Fsocname
    public Fsocname_kor
    public Fsoclogo
    public Fdgncomment
    public Fmodelitem
    public Fmodelitem2
    public Fmodelimg
    public Fmodelbimg
    public Fmodelbimg2
	public Ficon1image
	public Ficon2image
	public FbasicImage
    public Fcatecode
    public FCateName
	public Fnewflg
	public Fsaleflg

    Private Sub Class_Initialize()
	End Sub

	Private Sub Class_Terminate()
	End Sub
End Class

Class CZZimBrandCategoryCount
    public FCDL
	public FCount

    Private Sub Class_Initialize()
	End Sub

	Private Sub Class_Terminate()
	End Sub
end Class

Class CMyZZimBrandBestItem
    public Fmakerid
	public FarrItemID
	public FarrSmallImage

    Private Sub Class_Initialize()
	End Sub

	Private Sub Class_Terminate()
	End Sub
End Class

Class CMyZZimBrand
    public FOneItem
	public FItemList()

	public FTotalCount
	public FCurrPage
	public FTotalPage
	public FPageSize
	public FScrollCount
	public FResultCount

	public FRectMakerid
	public FRectUserID
	public FRectCDL
	public FRectOrder

    '// My 찜브랜드 카테고리 갯수
    public sub GetMyZimBrandCategoryCount()
        Dim SqlStr, i
        sqlStr = " select c.catecode,  count(m.makerid) as cnt"
        sqlStr = sqlStr + " from [db_my10x10].[dbo].tbl_mybrand m,"
        sqlStr = sqlStr + " [db_user].[dbo].tbl_user_c c"
        sqlStr = sqlStr + " where m.userid='" + FRectUserID + "'"
        sqlStr = sqlStr + " and m.makerid=c.userid"
        sqlStr = sqlStr + " and c.isusing='Y'"
        sqlStr = sqlStr + " group by c.catecode"

        rsget.Open sqlStr,dbget,1

		FResultCount = rsget.RecordCount

		if (FResultCount<1) then FResultCount=0

		redim preserve FItemList(FResultCount)

		if Not rsget.Eof then
		    do until rsget.eof
				set FItemList(i)    = new CZZimBrandCategoryCount
    		    FItemList(i).FCDL     = rsget("catecode")
    		    FItemList(i).FCount   = rsget("Cnt")

    		    FTotalCount           = FTotalCount + FItemList(i).FCount
    		    i=i+1
    		    rsget.MoveNext
    		loop
		end if
		rsget.close

    End Sub

    public function GetCateZimBrandCount(byval iCdL)
        dim i

        GetCateZimBrandCount = 0

        for i=0 to FResultCount-1
            if (FItemList(i).FCDL=iCdL) then
                GetCateZimBrandCount = FItemList(i).FCount
                Exit function
            end if
        next
    end function

    '// My 찜브랜드
	public sub GetMyZZimBrand()
		Dim SqlStr, i

		if FRectUserid = "" then
			FResultCount = 0
			exit sub
		end if

		sqlStr = "exec db_my10x10.dbo.sp_Ten_MyZzimBrand_2013_cnt '" & FRectUserid & "'," & FPageSize & ",'" & FRectCDL & "'"

		rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
		rsget.Open sqlStr,dbget,1
			FTotalCount = rsget(0)
			FtotalPage	= rsget(1)
		rsget.close


		sqlStr = "exec db_my10x10.dbo.sp_Ten_MyZzimBrand_2021 '" & FRectUserid & "'," & FPageSize & ", " & FCurrPage & ",'" & FRectCDL & "','" & FRectOrder & "'"

		'response.write sqlStr&"<br>"
		rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
		rsget.pagesize = FPageSize
		rsget.Open sqlStr,dbget,1

		FResultCount = rsget.RecordCount-(FPageSize*(FCurrPage-1))
        if (FResultCount<1) then FResultCount=0
		redim preserve FItemList(FResultCount)
		i=0
		if  not rsget.EOF  then
			rsget.absolutepage = FCurrPage
			do until rsget.eof
				set FItemList(i) = new CMyZZimBrandItem

				FItemList(i).Fmakerid		= rsget("userid")
				FItemList(i).Fsocname		= db2html(rsget("socname"))
				FItemList(i).Fsocname_kor	= db2html(rsget("socname_kor"))
				FItemList(i).Fsoclogo		= db2html(rsget("soclogo"))
				FItemList(i).Fdgncomment	= db2html(rsget("dgncomment"))
				FItemList(i).Fmodelitem	    = rsget("modelitem")
				FItemList(i).Fmodelitem2	= rsget("modelitem2")
				FItemList(i).ficon2image	= rsget("icon2image")
				FItemList(i).Fmodelimg		= "http://webimage.10x10.co.kr/image/small/" + GetImageSubFolderByItemid(FItemList(i).Fmodelitem) + "/" + db2html(rsget("modelimg"))
				FItemList(i).Fmodelbimg	    = "http://webimage.10x10.co.kr/image/list/" + GetImageSubFolderByItemid(FItemList(i).Fmodelitem) + "/" + rsget("modelbimg")
				FItemList(i).Fmodelbimg2	= "http://webimage.10x10.co.kr/image/list/" + GetImageSubFolderByItemid(FItemList(i).Fmodelitem2) + "/" + rsget("modelbimg2")
				FItemList(i).ficon1image	= "http://webimage.10x10.co.kr/image/icon1/" + GetImageSubFolderByItemid(FItemList(i).Fmodelitem) + "/" + rsget("icon1image")
				FItemList(i).ficon2image	= "http://webimage.10x10.co.kr/image/icon2/" + GetImageSubFolderByItemid(FItemList(i).Fmodelitem) + "/" + rsget("icon2image")
				FItemList(i).FbasicImage	= fnGetBrandImage(FItemList(i).Fmodelitem, rsget("basicimage"))
				If IsNull(FItemList(i).FbasicImage) Or Trim(FItemList(i).FbasicImage) = "" Then
					FItemList(i).FbasicImage = "https://fiximage.10x10.co.kr/m/2020/common/no_img.svg"
				End If

				FItemList(i).Fsaleflg    	= rsget("saleflg")
				FItemList(i).Fnewflg     	= rsget("newflg")

				i=i+1
				rsget.moveNext
			loop

		end if
		rsget.Close
	end sub

    '// My 찜브랜드 베스트 상품
	public sub GetMyZZimBrandBestItem(arrMakerID, bestItemCount)
		Dim SqlStr, i, j

		if arrMakerID = "" then
			FResultCount = 0
			exit sub
		end if

		'// arrMakerID : "hitchhiker,SESAMEOIL"
		sqlStr = " exec [db_my10x10].[dbo].[sp_Ten_MyZzimBrandBestItem] '" + CStr(arrMakerID) + "', " + CStr(bestItemCount) + " "

		''response.write sqlStr&"<br>"
		rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
		rsget.pagesize = 100
		rsget.Open sqlStr,dbget,1

		FResultCount = rsget.RecordCount
        if (FResultCount<1) then FResultCount=0
		redim preserve FItemList(FResultCount)
		i=0
		if  not rsget.EOF  then
			rsget.absolutepage = 1
			do until rsget.eof
				set FItemList(i) = new CMyZZimBrandBestItem

				FItemList(i).Fmakerid		= rsget("makerid")
				FItemList(i).FarrItemID		= rsget("arrItemID")
				FItemList(i).FarrSmallImage	= rsget("arrSmallImage")

				if FItemList(i).FarrItemID<>"" then 
					FItemList(i).FarrItemID 	= Split(FItemList(i).FarrItemID, ",")
					FItemList(i).FarrSmallImage = Split(FItemList(i).FarrSmallImage, ",")

					for j = 0 to UBound(FItemList(i).FarrSmallImage)
						FItemList(i).FarrSmallImage(j) = "http://webimage.10x10.co.kr/image/small/" + GetImageSubFolderByItemid(FItemList(i).FarrItemID(j)) + "/" + FItemList(i).FarrSmallImage(j)
					next
				end if

				i=i+1
				rsget.moveNext
			loop

		end if
		rsget.Close
	end sub

    Private Sub Class_Initialize()
		redim preserve FItemList(0)
		FCurrPage =1
		FPageSize = 10
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

%>
