<%
Class CCateContentsCodeItem
    public Fposcode
    public Fposname
    public FposVarname
    public Flinktype
    public Ffixtype
    public Fimagewidth
    public Fimageheight
    public FuseSet			'한페이지에 사용될 이미지수
    public Fisusing

    
    public function getlinktypeName()
        select case Flinktype
            case "L"
                getlinktypeName = "링크"
            case "M"
                getlinktypeName = "맵"
            case "F"
                getlinktypeName = "플래시"
            case "X"
                getlinktypeName = "XML"
            case else
                getlinktypeName = Flinktype
        end select
    end function
    
    public function getfixtypeName()
        select case Ffixtype
            case "K"
                getfixtypeName = "관리자확정시"
            case "R"
                getfixtypeName = "실시간"
            case "D"
                getfixtypeName = "일별"
            case "W"
                getfixtypeName = "주별"
            case else
                getfixtypeName = Flinktype
        end select
    end function
    
    Private Sub Class_Initialize()

	End Sub

	Private Sub Class_Terminate()

	End Sub
	
end Class 

Class CCateContentsCode
    public FOneItem
    public FItemList()

	public FTotalCount
	public FCurrPage
	public FTotalPage
	public FPageSize
	public FResultCount
	public FScrollCount
    
    public FRectPoscode
    
    public Sub GetOneContentsCode()
        dim SqlStr
        SqlStr = "select top 1 * "
        SqlStr = SqlStr + " from [db_sitemaster].[dbo].tbl_category_contents_poscode"
        SqlStr = SqlStr + " where poscode=" + CStr(FRectPoscode)
        
        rsget.Open SqlStr, dbget, 1
        FResultCount = rsget.RecordCount
        
        set FOneItem = new CCateContentsCodeItem
        if Not rsget.Eof then
            
            FOneItem.Fposcode		= rsget("poscode")
            FOneItem.Fposname		= db2html(rsget("posname"))
            FOneItem.FposVarname	= rsget("posVarname")
            FOneItem.Flinktype		= rsget("linktype")
            FOneItem.Ffixtype		= rsget("fixtype")
            FOneItem.Fimagewidth	= rsget("imagewidth")
            FOneItem.FuseSet		= rsget("useSet")
            FOneItem.Fisusing		= rsget("isusing")
            
            FOneItem.Fimageheight = rsget("imageheight")
        end if
        rsget.close
    end Sub
    
    public Sub GetposcodeList()
        dim sqlStr
        sqlStr = "select count(poscode) as cnt from [db_sitemaster].[dbo].tbl_category_contents_poscode"
        rsget.Open sqlStr, dbget, 1
		FTotalCount = rsget("cnt")
		rsget.close
        
        sqlStr = "select top " + CStr(FPageSize * FCurrPage) + " * from [db_sitemaster].[dbo].tbl_category_contents_poscode "
        sqlStr = sqlStr + " order by poscode desc"
        
        rsget.pagesize = FPageSize
		rsget.Open sqlStr, dbget, 1

		FtotalPage =  CInt(FTotalCount\FPageSize)
		if  (FTotalCount\FPageSize)<>(FTotalCount/FPageSize) then
			FtotalPage = FtotalPage +1
		end if
		FResultCount = rsget.RecordCount-(FPageSize*(FCurrPage-1))

		redim preserve FItemList(FResultCount)
		if  not rsget.EOF  then
		        i = 0
			rsget.absolutepage = FCurrPage
			do until rsget.eof
				set FItemList(i) = new CCateContentsCodeItem

				FItemList(i).Fposcode		= rsget("poscode")
                FItemList(i).Fposname		= db2html(rsget("posname"))
                FItemList(i).FposVarname	= rsget("posVarname")
                FItemList(i).Flinktype		= rsget("linktype")
                FItemList(i).Ffixtype		= rsget("fixtype")
                FItemList(i).Fimagewidth	= rsget("imagewidth")
                FItemList(i).Fimageheight	= rsget("imageheight")
                FItemList(i).FuseSet		= rsget("useSet")
                FItemList(i).Fisusing		= rsget("isusing")

				i=i+1
				rsget.moveNext
			loop
		end if
		rsget.close
    end Sub

    Private Sub Class_Initialize()
		redim  FItemList(0)

		FCurrPage         = 1
		FPageSize         = 10
		FResultCount      = 0
		FScrollCount      = 10
		FTotalCount       = 0

	End Sub

	Private Sub Class_Terminate()

    End Sub

    public Function HasPreScroll()
		HasPreScroll = StarScrollPage > 1
	end Function

	public Function HasNextScroll()
		HasNextScroll = FTotalPage > StarScrollPage + FScrollCount -1
	end Function

	public Function StarScrollPage()
		StarScrollPage = ((FCurrpage-1)\FScrollCount)*FScrollCount +1
	end Function
end Class

Class CCateContentsItem
    public Fidx
    public Fcdl
    public Fcdm
    public Fcodename
    public Fcdmname
    public Fposcode
    public FposVarname
    public Fposname
    public Flinktype
    public Ffixtype
    public Fimageurl
    public Fonimageurl
    public Foffimageurl
    public Flinkurl
    public Fimagewidth
    public Fimageheight
    public FuseSet
    public Fstartdate
    public Fenddate
    public Fregdate
    public Freguserid
    public Fisusing
    public FsortNo
    public Fdesc
	public Fregname
	public Fworkername
	public Fworkeruserid
	public Fdisp1
    
    
    public function IsEndDateExpired()
        IsEndDateExpired = now()>Cdate(Fenddate)
    end function

    public function GetImageUrl()
        if (IsNULL(Fimageurl) or (Fimageurl="")) then
            GetImageUrl = ""
        else
            GetImageUrl = staticImgUrl & "/category/" + Fimageurl
        end if
    end Function
    
	public function GetOnImageUrl()
        if (IsNULL(Fimageurl) or (Fimageurl="")) then
            GetOnImageUrl = ""
        else
            GetOnImageUrl = staticImgUrl & "/category/" + Fonimageurl
        end if
    end Function
    
	public function GetOffImageUrl()
        if (IsNULL(Fimageurl) or (Fimageurl="")) then
            GetOffImageUrl = ""
        else
            GetOffImageUrl = staticImgUrl & "/category/" + Foffimageurl
        end if
    end function

    public function getlinktypeName()
        select case Flinktype
            case "L"
                getlinktypeName = "링크"
            case "M"
                getlinktypeName = "맵"
            case "F"
                getlinktypeName = "플래시"
            case "X"
                getlinktypeName = "XML"
            case else
                getlinktypeName = Flinktype
        end select
    end function
    
    public function getfixtypeName()
        select case Ffixtype
            case "K"
                getfixtypeName = "관리자확정시"
            case "R"
                getfixtypeName = "실시간"
            case "D"
                getfixtypeName = "일별"
            case "W"
                getfixtypeName = "주별"
            case else
                getfixtypeName = Flinktype
        end select
    end function
    
    Private Sub Class_Initialize()

	End Sub

	Private Sub Class_Terminate()

	End Sub
end Class

Class CCateContents
    public FOneItem
    public FItemList()

	public FTotalCount
	public FCurrPage
	public FTotalPage
	public FPageSize
	public FResultCount
	public FScrollCount
       
    public FRectIdx
    public FRectIsusing
    public FRectPoscode
    public FRectfixtype
    public FRectValiddate
    public FRectCdl
    public FRectCdm
    public FRectDisp1
    public FRectSelDate
    
    
    public function GetNowDateTime()
        dim sqlStr
        sqlStr = "select convert(varchar(19),getdate(),21) as nowdatetime "
        
        rsget.Open SqlStr, dbget, 1
        if Not rsget.Eof then
            GetNowDateTime = rsget("nowdatetime")
        end if
        rsget.Close
    end function
    
    
    public Sub GetOneCateContents()
        dim sqlStr
        sqlStr = "select top 1 c.*, p.posname, p.useSet "
        sqlStr = sqlStr + " ,(Case When isNull(c.reguserid,'')<>'' Then (SELECT username from db_partner.dbo.tbl_user_tenbyten WHERE userid = c.reguserid ) Else '' end) as regname "
        sqlStr = sqlStr + " ,(Case When isNull(c.workeruserid,'')<>'' Then (SELECT username from db_partner.dbo.tbl_user_tenbyten WHERE userid = c.workeruserid ) Else '' end) as workername "
        sqlStr = sqlStr + " from [db_sitemaster].[dbo].tbl_category_contents c"
        sqlStr = sqlStr + " left join [db_sitemaster].[dbo].tbl_category_contents_poscode p"
        sqlStr = sqlStr + " on c.poscode=p.poscode"
        sqlStr = sqlStr + " where idx=" + CStr(FRectIdx)
        
        rsget.Open SqlStr, dbget, 1
        FResultCount = rsget.RecordCount
        
        set FOneItem = new CCateContentsItem
        
        if Not rsget.Eof then
    
    		FOneItem.Fidx			= rsget("idx")
            FOneItem.Fposcode		= rsget("poscode")
            FOneItem.Fposname		= db2html(rsget("posname"))
            FOneItem.FposVarname	= rsget("posVarname")
            FOneItem.Flinktype		= rsget("linktype")
            FOneItem.Ffixtype		= rsget("fixtype")
            FOneItem.Fimageurl		= db2html(rsget("imageurl"))
            FOneItem.Flinkurl		= db2html(rsget("linkurl"))
            FOneItem.Fimagewidth	= rsget("imagewidth")
            FOneItem.Fimageheight	= rsget("imageheight")
            FOneItem.FuseSet		= rsget("useSet")
            FOneItem.Fstartdate		= rsget("startdate")
            FOneItem.Fenddate		= rsget("enddate")
            FOneItem.Fregdate		= rsget("regdate")
            FOneItem.Freguserid		= rsget("reguserid")
            FOneItem.Fcdl			= rsget("cdl")
            FOneItem.Fcdm			= rsget("cdm")
            FOneItem.Fdisp1			= rsget("disp1")
            FOneItem.Fisusing		= rsget("isusing")
            FOneItem.FsortNo		= rsget("sortNo")
            FOneItem.Fdesc			= db2html(rsget("desc"))
            FOneItem.Fonimageurl	= rsget("onimgurl") '2011-04-07 추가 이종화
            FOneItem.Foffimageurl	= rsget("offimgurl") '2011-04-07 추가 이종화
            FOneItem.Fregname		= rsget("regname")
			FOneItem.Fworkername	= rsget("workername")
			If isNull(rsget("workeruserid")) Then
				FOneItem.Fworkeruserid	= ""
			Else
				FOneItem.Fworkeruserid	= rsget("workeruserid")
			End If

        end if
        rsget.Close
    end Sub

    
    public Sub GetMainContentsValidList()
        dim sqlStr, i , yyyymmdd, nowdatetime
        nowdatetime = GetNowDateTime()
        yyyymmdd = Left(nowdatetime,10)
        
        sqlStr = "select top " + CStr(FPageSize) + " * "
        sqlStr = sqlStr + " from [db_sitemaster].[dbo].tbl_category_contents"
        sqlStr = sqlStr + " where 1=1 and poscode='" + FRectPoscode + "'"
        sqlStr = sqlStr + " and isusing='Y'"
        
        If FRectDisp1 <> "" Then
        	sqlStr = sqlStr + " and disp1 = '" & FRectDisp1 & "' "
        End If
        
        if FRectSelDate<>"" then
        	sqlStr = sqlStr + " and '" & FRectSelDate & "' between startdate and enddate "
        else
        	sqlStr = sqlStr + " and enddate>'" + nowdatetime + "'"
        end if

        sqlStr = sqlStr + " order by sortNo asc, idx desc"
        
        'response.write sqlStr &"<br>"	
        rsget.Open SqlStr, dbget, 1
        
        FResultCount = rsget.RecordCount
        FTotalCount = FResultCount
        
        redim preserve FItemList(FResultCount)
		if  not rsget.EOF  then
		    i = 0
			do until rsget.eof
				set FItemList(i) = new CCateContentsItem

				FItemList(i).Fidx			= rsget("idx")
                FItemList(i).Fposcode		= rsget("poscode")
                FItemList(i).FposVarname	= rsget("posVarname")
                FItemList(i).Flinktype		= rsget("linktype")
                FItemList(i).Ffixtype		= rsget("fixtype")
                FItemList(i).Fimageurl		= db2html(rsget("imageurl"))
                FItemList(i).Flinkurl		= db2html(rsget("linkurl"))
                FItemList(i).Fimagewidth	= rsget("imagewidth")
                FItemList(i).Fimageheight	= rsget("imageheight")
                FItemList(i).Fstartdate		= rsget("startdate")
                FItemList(i).Fenddate		= rsget("enddate")
                FItemList(i).Fregdate		= rsget("regdate")
                FItemList(i).Freguserid		= rsget("reguserid")
                FItemList(i).Fisusing		= rsget("isusing")
                FItemList(i).FsortNo		= rsget("sortNo")


				i=i+1
				rsget.moveNext
			loop
		end if
		rsget.close
        
    End Sub
    

    Private Sub Class_Initialize()
		redim  FItemList(0)

		FCurrPage         = 1
		FPageSize         = 10
		FResultCount      = 0
		FScrollCount      = 10
		FTotalCount       = 0

	End Sub

	Private Sub Class_Terminate()

    End Sub

    public Function HasPreScroll()
		HasPreScroll = StarScrollPage > 1
	end Function

	public Function HasNextScroll()
		HasNextScroll = FTotalPage > StarScrollPage + FScrollCount -1
	end Function

	public Function StarScrollPage()
		StarScrollPage = ((FCurrpage-1)\FScrollCount)*FScrollCount +1
	end Function
end Class
%>
