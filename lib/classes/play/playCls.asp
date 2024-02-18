<%
'//play class
Class CPlayContentsItem
    public Fidx
	Public Fidxsub
	public Flistimg
	Public Fitemid
	Public Fitemname
	public Fviewimg
	public Fviewtitle
	public Fviewtext
	Public Freservationdate
	Public Fstate
	Public Fviewno
	Public Forgimg
	Public Fworktext
	Public Fvideourl
	Public Fregdate
	Public Fmaxno
	Public Fminno
	Public Fmaxidx
	Public Fminidx

	Public FSubtitle
	Public FIsusing
	Public FPPimg

	Public Ffavcnt
	Public Fchkfav

	Public Ftagname
	Public Ftagurl

	Public Ftagcnt

	Public Fviewimg1
	Public Fviewimg2
	Public Fviewimg3
	Public Fviewimg4
	Public Fviewimg5

	Public Ftextimg
	Public FpartMDid
	Public FpartWDid
	Public FpartMDname
	Public FpartWDname
	Public Fitemcnt

	Public Fitemcnt1
	Public Fitemcnt2
	Public Fitemcnt3
	Public Fitemcnt4
	Public Fitemcnt5

	public Fplaymainimg
	public Fbeforeimg
	public Fafterimg
	public Ftopbgimg
	public Fsideltimg
	public Fsidertimg
	public FsubBGColor
	Public FmainBGColor
	public Fviewcontents
	public Fviewthumbimg1
	public Fviewthumbimg2

	public Fplaycate
	public FlistImage
	public FOpendate
	Public Fexec_check
	Public Fexec_filepath

    Private Sub Class_Initialize()

	End Sub

	Private Sub Class_Terminate()

	End Sub
end Class


Class CPlayContents
    public FOneItem
    public FItemList()

	public FTotalCount
	public FCurrPage
	public FTotalPage
	public FPageSize
	public FResultCount
	Public FReusltidx
	public FScrollCount

    public FRectIdx
	Public FRectsubIdx
    public FRectPlaycate
	Public FRectviewno

	Public FRecttitle
	Public FRectstate

	Public FRPlaycate
	Public FRectTag

	Public FRectNo

	Public Fuserid
	Public Fplaycode
	public favcnt
    public chkfav
    public FRecentGIdx
    public FRecentGCIdx



	public Sub GetRecentPG()
		dim sqlStr
		sqlStr = "select top 1 gidx from db_sitemaster.dbo.tbl_play_ground_main where state = 7 and convert(varchar(10),getdate(),120) >= reservationdate order by reservationdate desc, viewno desc"
		rsget.Open SqlStr, dbget, 1
		if Not rsget.Eof then
			FRecentGIdx = rsget("gidx")
		end if
		rsget.Close
		If FRecentGIdx <> "" Then
			sqlStr = "select top 1 gcidx from db_sitemaster.dbo.tbl_play_ground_sub where gidx = '" & FRecentGIdx & "' and state = 7 and convert(varchar(10),getdate(),120) >= reservationdate order by reservationdate desc, viewno desc"
			rsget.Open SqlStr, dbget, 1
			if Not rsget.Eof then
				FRecentGCIdx = rsget("gcidx")
			end if
			rsget.Close
		End If
	end Sub


	'play ground 2013-09-16 이종화
	public Sub GetRowGroundMain()
	dim sqlStr , sqlsearch

	if FRectIdx <> "0" then
			sqlsearch = sqlsearch & " and m.gidx = '"& FRectIdx &"'"
	end If

	sqlStr = "select top 1 * "
	sqlStr = sqlStr + " from db_sitemaster.dbo.tbl_play_ground_main as m "
	sqlStr = sqlStr + " inner join db_sitemaster.dbo.tbl_play_ground_sub as s on m.gidx = s.gidx "
	sqlStr = sqlStr + " where m.state = 7 and convert(varchar(10),getdate(),120) >= m.reservationdate " & sqlsearch
    sqlStr = sqlStr & " order by s.gcidx DESC , s.viewno desc , m.reservationdate desc"
	'response.write sqlStr &"<Br>"
	rsget.Open SqlStr, dbget, 1

	set FOneItem = new CPlayContentsItem

	if Not rsget.Eof then

		FOneItem.Fidx					= rsget("gidx")
		FOneItem.Fviewno				= rsget("viewno")
		FOneItem.Flistimg				= rsget("titleimg")
		FOneItem.Fviewtitle				= rsget("viewtitle")
		FOneItem.Fplaymainimg			= rsget("playmainimg")

	end if
	rsget.Close
	end Sub

	public Sub GetRowGroundMain_review()
	dim sqlStr , sqlsearch

	if FRectIdx <> "0" then
			sqlsearch = sqlsearch & " and m.gidx = '"& FRectIdx &"'"
	end If

	sqlStr = "select top 1 * "
	sqlStr = sqlStr + " from db_sitemaster.dbo.tbl_play_ground_main as m "
	sqlStr = sqlStr + " inner join db_sitemaster.dbo.tbl_play_ground_sub as s on m.gidx = s.gidx "
	sqlStr = sqlStr + " where 1=1 " & sqlsearch
    sqlStr = sqlStr & " order by s.gcidx DESC , s.viewno desc , m.reservationdate desc"
	'response.write sqlStr &"<Br>"
	rsget.Open SqlStr, dbget, 1

	set FOneItem = new CPlayContentsItem

	if Not rsget.Eof then

		FOneItem.Fidx						= rsget("gidx")
		FOneItem.Fviewno				= rsget("viewno")
		FOneItem.Flistimg					= rsget("titleimg")
		FOneItem.Fviewtitle				= rsget("viewtitle")
		FOneItem.Fplaymainimg			= rsget("playmainimg")

	end if
	rsget.Close
	end Sub

	public function fnGetGroundMainList()
        dim sqlStr, sqlsearch, i

		'// 결과수 카운트
		sqlStr = "select count(*) as cnt"
        sqlStr = sqlStr & " from db_sitemaster.dbo.tbl_play_ground_main"
        sqlStr = sqlStr & " where state = 7 and convert(varchar(10),getdate(),120) >= reservationdate " & sqlsearch

		'response.write sqlStr &"<Br>"
        rsget.Open sqlStr,dbget,1
            FTotalCount = rsget("cnt")
        rsget.Close

		if FTotalCount < 1 then exit function

        '// 본문 내용 접수
        sqlStr = "select top " + Cstr(FPageSize * FCurrPage)
        sqlStr = sqlStr & " gidx , viewno , viewtitle , titleimg , reservationdate , state "
        sqlStr = sqlStr & " from db_sitemaster.dbo.tbl_play_ground_main "
        sqlStr = sqlStr & " where state = 7 and convert(varchar(10),getdate(),120) >= reservationdate " & sqlsearch
        sqlStr = sqlStr & " order by viewNo DESC, reservationdate desc"

		'' response.write sqlStr &"<Br>"
		'' response.end
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
                set FItemList(i) = new CPlayContentsItem

                FItemList(i).Fidx						= rsget("gidx")
				FItemList(i).Fviewno					= rsget("viewno")
                FItemList(i).Fviewtitle				= rsget("viewtitle")
				FItemList(i).Flistimg					= rsget("titleimg")

                rsget.movenext
                i=i+1
            loop
        end if
        rsget.Close
    end Function

	public function fnGetGroundMainList_review()
        dim sqlStr, sqlsearch, i

		'// 결과수 카운트
		sqlStr = "select count(*) as cnt"
        sqlStr = sqlStr & " from db_sitemaster.dbo.tbl_play_ground_main"
        sqlStr = sqlStr & " where 1=1 " & sqlsearch

		'response.write sqlStr &"<Br>"
        rsget.Open sqlStr,dbget,1
            FTotalCount = rsget("cnt")
        rsget.Close

		if FTotalCount < 1 then exit function

        '// 본문 내용 접수
        sqlStr = "select top " + Cstr(FPageSize * FCurrPage)
        sqlStr = sqlStr & " gidx , viewno , viewtitle , titleimg , reservationdate , state "
        sqlStr = sqlStr & " from db_sitemaster.dbo.tbl_play_ground_main "
        sqlStr = sqlStr & " where 1=1 " & sqlsearch
        sqlStr = sqlStr & " order by viewNo DESC, reservationdate desc"

		'' response.write sqlStr &"<Br>"
		'' response.end
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
                set FItemList(i) = new CPlayContentsItem

                FItemList(i).Fidx						= rsget("gidx")
				FItemList(i).Fviewno					= rsget("viewno")
                FItemList(i).Fviewtitle				= rsget("viewtitle")
				FItemList(i).Flistimg					= rsget("titleimg")

                rsget.movenext
                i=i+1
            loop
        end if
        rsget.Close
    end Function

	'play ground Sub 2013-09-23 이종화
	public Sub GetRowGroundSub()
	dim sqlStr

	If FRectsubIdx = "" then
		sqlStr = "select top 1 * "
		sqlStr = sqlStr & " , (select count(*) from db_my10x10.dbo.tbl_myfavorite_play where codeidx = s.gidx and subcodeidx = s.gcidx and playcode = "& Fplaycode &") as favcnt "
	    sqlStr = sqlStr & " , (select count(*) from db_my10x10.dbo.tbl_myfavorite_play where codeidx = s.gidx and subcodeidx = s.gcidx and playcode = "& Fplaycode &" and userid = '"& Fuserid &"') as chkfav "
		sqlStr = sqlStr + " from db_sitemaster.dbo.tbl_play_ground_sub as s"
		sqlStr = sqlStr + " where state = 7 and convert(varchar(10),getdate(),120) >= reservationdate and gidx=" + CStr(FRectIdx)
		sqlStr = sqlStr + " order by viewno asc"
	Else
		sqlStr = "select top 1 * "
		sqlStr = sqlStr & " , (select count(*) from db_my10x10.dbo.tbl_myfavorite_play where codeidx = s.gidx and subcodeidx = s.gcidx and playcode = "& Fplaycode &") as favcnt "
		sqlStr = sqlStr & " , (select count(*) from db_my10x10.dbo.tbl_myfavorite_play where codeidx = s.gidx and subcodeidx = s.gcidx and playcode = "& Fplaycode &" and userid = '"& Fuserid &"') as chkfav "
		sqlStr = sqlStr + " from db_sitemaster.dbo.tbl_play_ground_sub as s"
		sqlStr = sqlStr + " where state = 7 and convert(varchar(10),getdate(),120) >= reservationdate and gcidx=" + CStr(FRectsubIdx) + " and gidx=" + CStr(FRectIdx)
	End If
	'response.write sqlStr &"<Br>"
	rsget.Open SqlStr, dbget, 1
	FResultCount = rsget.RecordCount

	set FOneItem = new CPlayContentsItem

	if Not rsget.Eof then

		FOneItem.Fidx				= rsget("gcidx")
		FOneItem.Fidxsub			= rsget("gidx")
		FOneItem.Fviewno			= rsget("viewno")
		FOneItem.Fviewtitle			= rsget("viewtitle")

		FOneItem.Fplaymainimg		= rsget("playmainimg")
		FOneItem.Fbeforeimg			= rsget("viewthumbimg1")
		FOneItem.Fafterimg			= rsget("viewthumbimg2")
		FOneItem.Ftopbgimg			= rsget("viewbgimg")
		FOneItem.Fsideltimg			= rsget("downsideimg1")

		FOneItem.FsubBGColor		= rsget("downbgcolor")
		FOneItem.Fviewcontents		= rsget("viewcontents")

        FOneItem.Ffavcnt			= rsget("favcnt")
        FOneItem.Fchkfav			= rsget("chkfav")
        FOneItem.Fexec_check		= rsget("exec_check")
        FOneItem.Fexec_filepath		= rsget("exec_filepath")

	end if
	rsget.Close
	end Sub

	public Sub GetRowGroundSub_review()
	dim sqlStr

	If FRectsubIdx = "" then
		sqlStr = "select top 1 * "
		sqlStr = sqlStr & " , (select count(*) from db_my10x10.dbo.tbl_myfavorite_play where codeidx = s.gidx and subcodeidx = s.gcidx and playcode = "& Fplaycode &") as favcnt "
	    sqlStr = sqlStr & " , (select count(*) from db_my10x10.dbo.tbl_myfavorite_play where codeidx = s.gidx and subcodeidx = s.gcidx and playcode = "& Fplaycode &" and userid = '"& Fuserid &"') as chkfav "
		sqlStr = sqlStr + " from db_sitemaster.dbo.tbl_play_ground_sub as s"
		sqlStr = sqlStr + " where 1=1 and gidx=" + CStr(FRectIdx)
		sqlStr = sqlStr + " order by viewno asc"
	Else
		sqlStr = "select top 1 * "
		sqlStr = sqlStr & " , (select count(*) from db_my10x10.dbo.tbl_myfavorite_play where codeidx = s.gidx and subcodeidx = s.gcidx and playcode = "& Fplaycode &") as favcnt "
		sqlStr = sqlStr & " , (select count(*) from db_my10x10.dbo.tbl_myfavorite_play where codeidx = s.gidx and subcodeidx = s.gcidx and playcode = "& Fplaycode &" and userid = '"& Fuserid &"') as chkfav "
		sqlStr = sqlStr + " from db_sitemaster.dbo.tbl_play_ground_sub as s"
		sqlStr = sqlStr + " where 1=1 and gcidx=" + CStr(FRectsubIdx) + " and gidx=" + CStr(FRectIdx)
	End If
	'response.write sqlStr &"<Br>"
	rsget.Open SqlStr, dbget, 1
	FResultCount = rsget.RecordCount

	set FOneItem = new CPlayContentsItem

	if Not rsget.Eof then

		FOneItem.Fidx				= rsget("gcidx")
		FOneItem.Fidxsub			= rsget("gidx")
		FOneItem.Fviewno			= rsget("viewno")
		FOneItem.Fviewtitle			= rsget("viewtitle")

		FOneItem.Fplaymainimg		= rsget("playmainimg")
		FOneItem.Fbeforeimg			= rsget("viewthumbimg1")
		FOneItem.Fafterimg			= rsget("viewthumbimg2")
		FOneItem.Ftopbgimg			= rsget("viewbgimg")
		FOneItem.Fsideltimg			= rsget("downsideimg1")

		FOneItem.FsubBGColor		= rsget("downbgcolor")
		FOneItem.Fviewcontents		= rsget("viewcontents")

        FOneItem.Ffavcnt			= rsget("favcnt")
        FOneItem.Fchkfav			= rsget("chkfav")
        FOneItem.Fexec_check		= rsget("exec_check")
        FOneItem.Fexec_filepath		= rsget("exec_filepath")

	end if
	rsget.Close
	end Sub

	public function fnGetGroundSubList()
        dim sqlStr, sqlsearch, i

		if FRectIdx <> "0" then
				sqlsearch = sqlsearch & " and gidx = '"& FRectIdx &"'"
		end If

		'// 결과수 카운트
		sqlStr = "select count(*) as cnt"
        sqlStr = sqlStr & " from db_sitemaster.dbo.tbl_play_ground_sub"
        sqlStr = sqlStr & " where 1=1 " & sqlsearch

		'response.write sqlStr &"<Br>"
        rsget.Open sqlStr,dbget,1
            FTotalCount = rsget("cnt")
        rsget.Close

		if FTotalCount < 1 then exit function

        '// 본문 내용 접수
        sqlStr = "select top 4"
        sqlStr = sqlStr & " gcidx , gidx , viewno , viewtitle , viewthumbimg1 , viewthumbimg2 "
        sqlStr = sqlStr & " from db_sitemaster.dbo.tbl_play_ground_sub "
        sqlStr = sqlStr & " where state = 7 and convert(varchar(10),getdate(),120) >= reservationdate " & sqlsearch
        sqlStr = sqlStr & " order by viewNo asc"

		'response.write sqlStr &"<Br>"
        rsget.pagesize = FPageSize
        rsget.Open sqlStr,dbget,1

		FResultCount = rsget.RecordCount

        if (FResultCount<1) then FResultCount=0

        redim preserve FItemList(FResultCount)

        i=0
        if  not rsget.EOF  then
            rsget.absolutepage = FCurrPage
            do until rsget.EOF
                set FItemList(i) = new CPlayContentsItem

				FItemList(i).Fidxsub					= rsget("gcidx")
                FItemList(i).Fidx						= rsget("gidx")
				FItemList(i).Fviewno					= rsget("viewno")
                FItemList(i).Fviewtitle				= rsget("viewtitle")
				FItemList(i).Fviewthumbimg1	= rsget("viewthumbimg1")
				FItemList(i).Fviewthumbimg2	= rsget("viewthumbimg2")

                rsget.movenext
                i=i+1
            loop
        end if
        rsget.Close
    end Function

	public function fnGetGroundSubList_review()
        dim sqlStr, sqlsearch, i

		if FRectIdx <> "0" then
				sqlsearch = sqlsearch & " and gidx = '"& FRectIdx &"'"
		end If

		'// 결과수 카운트
		sqlStr = "select count(*) as cnt"
        sqlStr = sqlStr & " from db_sitemaster.dbo.tbl_play_ground_sub"
        sqlStr = sqlStr & " where 1=1 " & sqlsearch

		'response.write sqlStr &"<Br>"
        rsget.Open sqlStr,dbget,1
            FTotalCount = rsget("cnt")
        rsget.Close

		if FTotalCount < 1 then exit function

        '// 본문 내용 접수
        sqlStr = "select top 4"
        sqlStr = sqlStr & " gcidx , gidx , viewno , viewtitle , viewthumbimg1 , viewthumbimg2 "
        sqlStr = sqlStr & " from db_sitemaster.dbo.tbl_play_ground_sub "
        sqlStr = sqlStr & " where 1=1 " & sqlsearch
        sqlStr = sqlStr & " order by viewNo asc"

		'response.write sqlStr &"<Br>"
        rsget.pagesize = FPageSize
        rsget.Open sqlStr,dbget,1

		FResultCount = rsget.RecordCount

        if (FResultCount<1) then FResultCount=0

        redim preserve FItemList(FResultCount)

        i=0
        if  not rsget.EOF  then
            rsget.absolutepage = FCurrPage
            do until rsget.EOF
                set FItemList(i) = new CPlayContentsItem

				FItemList(i).Fidxsub					= rsget("gcidx")
                FItemList(i).Fidx						= rsget("gidx")
				FItemList(i).Fviewno					= rsget("viewno")
                FItemList(i).Fviewtitle				= rsget("viewtitle")
				FItemList(i).Fviewthumbimg1	= rsget("viewthumbimg1")
				FItemList(i).Fviewthumbimg2	= rsget("viewthumbimg2")

                rsget.movenext
                i=i+1
            loop
        end if
        rsget.Close
    end Function

	'play picture diary 2013-09-03 이종화
	public Sub GetOneRowContent()
	dim sqlStr
	sqlStr = "select * "
	sqlStr = sqlStr + ", isnull((select max(viewno) from db_sitemaster.dbo.tbl_play_picture_diary where viewno < d.viewno ),0) as maxno "
	sqlStr = sqlStr + ", isnull((select pdidx from db_sitemaster.dbo.tbl_play_picture_diary where viewno = (select max(viewno) from db_sitemaster.dbo.tbl_play_picture_diary where viewno < d.viewno ) and state = 7 and convert(varchar(10),getdate(),120) >= reservationdate),0) as maxidx  "
	sqlStr = sqlStr + ", isnull((select min(viewno) from db_sitemaster.dbo.tbl_play_picture_diary where viewno > d.viewno ),0) as minno "
	sqlStr = sqlStr + ", isnull((select pdidx from db_sitemaster.dbo.tbl_play_picture_diary where viewno = (select min(viewno) from db_sitemaster.dbo.tbl_play_picture_diary where viewno > d.viewno ) and state = 7 and convert(varchar(10),getdate(),120) >= reservationdate),0) as minidx  "
	sqlStr = sqlStr & " , (select count(*) from db_my10x10.dbo.tbl_myfavorite_play where codeidx = d.pdidx and playcode = "& Fplaycode &") as favcnt "
    sqlStr = sqlStr & " , (select count(*) from db_my10x10.dbo.tbl_myfavorite_play where codeidx = d.pdidx and playcode = "& Fplaycode &" and userid = '"& Fuserid &"') as chkfav "
	sqlStr = sqlStr + " from db_sitemaster.dbo.tbl_play_picture_diary as d"
	sqlStr = sqlStr + " where viewno=" + CStr(FRectviewno)
	'response.write sqlstr &"<br/>"
	rsget.Open SqlStr, dbget, 1
	FResultCount = rsget.RecordCount

	set FOneItem = new CPlayContentsItem

	if Not rsget.Eof then

		FOneItem.Fidx						= rsget("pdidx")
		FOneItem.Flistimg					= rsget("listimg")
		FOneItem.Fviewimg				= rsget("viewimg")
		FOneItem.Fviewtitle				= rsget("viewtitle")
		FOneItem.Fviewtext				= rsget("viewtext")
		FOneItem.Freservationdate	= rsget("reservationdate")
		FOneItem.Fstate					= rsget("state")
		FOneItem.Fviewno				= rsget("viewno")
		FOneItem.Forgimg				= rsget("orgimg")
		FOneItem.Fworktext				= rsget("worktext")
		FOneItem.Fregdate				= rsget("regdate")
		FOneItem.Fmaxno				= rsget("maxno")
		FOneItem.Fminno					= rsget("minno")
		FOneItem.Fmaxidx				= rsget("maxidx")
		FOneItem.Fminidx					= rsget("minidx")
        FOneItem.Ffavcnt					= rsget("favcnt")
        FOneItem.Fchkfav					= rsget("chkfav")

	end if
	rsget.Close
	end Sub

	'Play Tag
	public function GetRowTagContent()
		dim sqlStr, sqlsearch, i

		if FRectIdx <> "" then
			sqlsearch = sqlsearch & " and playidx="& FRectIdx &""
		end If

		if FRectsubIdx <> "" then
			sqlsearch = sqlsearch & " and playidxsub="& FRectsubIdx &""
		end if

		if Fplaycode <> "" then
			sqlsearch = sqlsearch & " and playcate='"& Fplaycode &"'"
		end if

		'// 결과수 카운트
		sqlStr = "select count(*) as cnt"
		sqlStr = sqlStr & " from db_sitemaster.dbo.tbl_play_tag"
		sqlStr = sqlStr & " where 1=1 " & sqlsearch

		'response.write sqlStr &"<Br>"
		rsget.Open sqlStr,dbget,1
			FTotalCount = rsget("cnt")
		rsget.Close

		if FTotalCount < 1 then exit function

		'// 본문 내용 접수
		sqlStr = "select "
		sqlStr = sqlStr & " tagname , tagurl "
		sqlStr = sqlStr & " from db_sitemaster.dbo.tbl_play_tag"
		sqlStr = sqlStr & " where 1=1 " & sqlsearch
		sqlStr = sqlStr & " order by tagidx asc "

		'response.write sqlStr &"<Br>"
		rsget.Open sqlStr,dbget,1
		redim preserve FItemList(FTotalCount)

		i=0
		if  not rsget.EOF  then
			rsget.absolutepage = FCurrPage
			do until rsget.EOF
				set FItemList(i) = new CPlayContentsItem

				FItemList(i).Ftagname        = rsget("tagname")
				FItemList(i).Ftagurl            = rsget("tagurl")

				rsget.movenext
				i=i+1
			loop
		end if
		rsget.Close
    end Function

	'PlayStyleItem
	public function GetRowStyleItemList()
		dim sqlStr, sqlsearch, i

		'// 결과수 카운트
		sqlStr = "select count(*) as cnt"
		sqlStr = sqlStr & " from db_sitemaster.dbo.tbl_play_style_item as S inner join db_item.dbo.tbl_item as i on S.itemid = i.itemid  "
		sqlStr = sqlStr & " where S.styleidx = '" & FRectIdx & "' and S.itemid <> '' "

		'response.write sqlStr &"<Br>"
		rsget.Open sqlStr,dbget,1
			FTotalCount = rsget("cnt")
		rsget.Close

		if FTotalCount < 1 then exit function

		'// 본문 내용 접수
		sqlStr = "select "
		sqlStr = sqlStr & " S.styleitemidx, S.styleidx , S.itemid, i.itemname, i.listimage , S.viewidx "
		sqlStr = sqlStr & " from db_sitemaster.dbo.tbl_play_style_item as S inner join db_item.dbo.tbl_item as i on S.itemid = i.itemid "
		sqlStr = sqlStr & " where S.styleidx = '" & FRectIdx & "' and S.itemid <> '' "
		sqlStr = sqlStr & " order by newid() "

		'response.write sqlStr &"<Br>"
		rsget.Open sqlStr,dbget,1
		redim preserve FItemList(FTotalCount)

		i=0
		if  not rsget.EOF  then
			rsget.absolutepage = FCurrPage
			do until rsget.EOF
				set FItemList(i) = new CPlayContentsItem

				FItemList(i).Ftagname		= rsget("styleitemidx")
				FItemList(i).Fidx				= rsget("styleidx")
				FItemList(i).Fitemid			= rsget("itemid")
				FItemList(i).Fitemname		= rsget("itemname")
				FItemList(i).Flistimg			= rsget("listimage")
				FItemList(i).Fviewno			= rsget("viewidx")

				rsget.movenext
				i=i+1
			loop
		end if
		rsget.Close
    end Function

	public function fnGetPictureDiaryList()
        dim sqlStr, i

		'// 결과수 카운트
		sqlStr = "select count(*) as cnt"
        sqlStr = sqlStr & " from db_sitemaster.dbo.tbl_play_picture_diary"
        sqlStr = sqlStr & " where  state = 7 and convert(varchar(10),getdate(),120) >= reservationdate "

		'response.write sqlStr &"<Br>"
        rsget.Open sqlStr,dbget,1
            FTotalCount = rsget("cnt")
        rsget.Close

		if FTotalCount < 1 then exit function

        '// 본문 내용 접수
        sqlStr = "select top " + Cstr(FPageSize * FCurrPage)
        sqlStr = sqlStr & " pdidx , viewtitle , listimg , viewno "
        sqlStr = sqlStr & " , (select count(*) from db_my10x10.dbo.tbl_myfavorite_play where codeidx = pdidx and playcode = "& Fplaycode &") as favcnt "
        sqlStr = sqlStr & " , (select count(*) from db_my10x10.dbo.tbl_myfavorite_play where codeidx = pdidx and playcode = "& Fplaycode &" and userid = '"& Fuserid &"') as chkfav "
        sqlStr = sqlStr & " from db_sitemaster.dbo.tbl_play_picture_diary"
        sqlStr = sqlStr & " where state = 7 and convert(varchar(10),getdate(),120) >= reservationdate"
        sqlStr = sqlStr & " order by viewNo DESC"

		'response.write sqlStr &"<Br>"
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
                set FItemList(i) = new CPlayContentsItem

                FItemList(i).Fidx						= rsget("pdidx")
                FItemList(i).Fviewtitle				= rsget("viewtitle")
                FItemList(i).Flistimg					= rsget("listimg")
                FItemList(i).Fviewno					= rsget("viewno")
                FItemList(i).Ffavcnt					= rsget("favcnt")
                FItemList(i).Fchkfav					= rsget("chkfav")

                rsget.movenext
                i=i+1
            loop
        end if
        rsget.Close
    end Function

	'play style+ 2013-09-05 이종화
	public Sub GetOneRowStyleContent()
	dim sqlStr
	sqlStr = "select * "
	sqlStr = sqlStr & " , (select count(*) from db_my10x10.dbo.tbl_myfavorite_play as p where p.codeidx = "& FRectIdx &" and p.playcode = "& Fplaycode &") as favcnt "
	sqlStr = sqlStr & " , (select count(*) from db_my10x10.dbo.tbl_myfavorite_play as p where p.codeidx = "& FRectIdx &" and p.playcode = "& Fplaycode &" and p.userid = '"& Fuserid &"') as chkfav "
	sqlStr = sqlStr + " from db_sitemaster.dbo.tbl_play_style_list"
	sqlStr = sqlStr + " where styleidx=" + CStr(FRectIdx)
	'response.write sqlStr
	rsget.Open SqlStr, dbget, 1
	FResultCount = rsget.RecordCount

	set FOneItem = new CPlayContentsItem

	if Not rsget.Eof then

		FOneItem.Fidx						= rsget("styleidx")
		FOneItem.Fviewimg1			= rsget("viewimg1")
		FOneItem.Fviewimg2			= rsget("viewimg2")
		FOneItem.Fviewimg3			= rsget("viewimg3")
		FOneItem.Fviewimg4			= rsget("viewimg4")
		FOneItem.Fviewimg5			= rsget("viewimg5")
		FOneItem.Ftextimg				= rsget("textimg")
		FOneItem.Fviewtitle				= rsget("viewtitle")
		FOneItem.Fviewno				= rsget("viewno")
		FOneItem.Ffavcnt					= rsget("favcnt")
        FOneItem.Fchkfav					= rsget("chkfav")

	end if
	rsget.Close
	end Sub

	'스타일 플러스 리스트
	public function fnGetStylePlusList()
        dim sqlStr, sqlsearch, i

		'// 결과수 카운트
		sqlStr = "select count(*) as cnt"
        sqlStr = sqlStr & " from db_sitemaster.dbo.tbl_play_style_list"
		sqlStr = sqlStr & " where state = 7 and convert(varchar(10),getdate(),120) >= reservationdate"

		'response.write sqlStr &"<Br>"
        rsget.Open sqlStr,dbget,1
            FTotalCount = rsget("cnt")
        rsget.Close

		if FTotalCount < 1 then exit function

        '// 본문 내용
        sqlStr = "select top " + Cstr(FPageSize * FCurrPage)
        sqlStr = sqlStr & " l.styleidx ,l.listimg , l.viewimg1, l.viewimg2, l.viewimg3, l.viewimg4, l.viewimg5 ,l.textimg , l.viewno , l.viewtitle  "
        sqlStr = sqlStr & " , (select count(*) from db_my10x10.dbo.tbl_myfavorite_play as p where p.codeidx = l.styleidx and p.playcode = "& Fplaycode &") as favcnt "
        sqlStr = sqlStr & " , (select count(*) from db_my10x10.dbo.tbl_myfavorite_play as p where p.codeidx = l.styleidx and p.playcode = "& Fplaycode &" and p.userid = '"& Fuserid &"') as chkfav "
        sqlStr = sqlStr & " from db_sitemaster.dbo.tbl_play_style_list as L"
		sqlStr = sqlStr & " where l.state = 7 and convert(varchar(10),getdate(),120) >= l.reservationdate"
        sqlStr = sqlStr & " order by l.viewNo DESC, l.reservationdate desc"

		'response.write sqlStr &"<Br>"
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
                set FItemList(i) = new CPlayContentsItem

                FItemList(i).Fidx						= rsget("styleidx")
				FItemList(i).Fviewno					= rsget("viewno")
                FItemList(i).Flistimg					= rsget("listimg")
                FItemList(i).Ftextimg					= rsget("textimg")
                FItemList(i).Fviewtitle				= rsget("viewtitle")

                FItemList(i).Fviewimg1				= rsget("viewimg1")
                FItemList(i).Fviewimg2				= rsget("viewimg2")
                FItemList(i).Fviewimg3				= rsget("viewimg3")
                FItemList(i).Fviewimg4				= rsget("viewimg4")
                FItemList(i).Fviewimg5				= rsget("viewimg5")

                FItemList(i).Ffavcnt					= rsget("favcnt")
                FItemList(i).Fchkfav					= rsget("chkfav")

                rsget.movenext
                i=i+1
            loop
        end if
        rsget.Close
    end Function

	public Sub GetFingersContent()
	dim sqlStr
	sqlStr = "select "
	sqlStr = sqlStr & "  (select count(*) from db_my10x10.dbo.tbl_myfavorite_play where codeidx = "& FRectIdx &" and playcode = "& Fplaycode &") as favcnt "
	sqlStr = sqlStr & " , (select count(*) from db_my10x10.dbo.tbl_myfavorite_play where codeidx = "& FRectIdx &" and playcode = "& Fplaycode &" and userid = '"& Fuserid &"') as chkfav "
	sqlStr = sqlStr + " from db_my10x10.dbo.tbl_myfavorite_play"
	sqlStr = sqlStr + " where codeidx='"& FRectIdx &"'"
'	response.write sqlstr

	rsget.Open SqlStr, dbget, 1
	FResultCount = rsget.RecordCount

	set FOneItem = new CPlayContentsItem

	if Not rsget.Eof then

		FOneItem.Ffavcnt					= rsget("favcnt")
        FOneItem.Fchkfav					= rsget("chkfav")


	end if
	rsget.Close
	end Sub

	public function fnGetFingersList()
        dim sqlStr, i

		'// 결과수 카운트
		sqlStr = "select count(*) as cnt"
        sqlStr = sqlStr & " from db_sitemaster.dbo.tbl_designfingers"
        sqlStr = sqlStr & " where convert(varchar(10),getdate(),120) >= Opendate"

		'response.write sqlStr &"<Br>"
        rsget.Open sqlStr,dbget,1
            FTotalCount = rsget("cnt")
        rsget.Close

		if FTotalCount < 1 then exit function

        '// 본문 내용 접수
        sqlStr = "select top " + Cstr(FPageSize * FCurrPage)
        sqlStr = sqlStr & " * , Convert(varchar(10),RegDate,120) AS RegDate, d.IsMovie "
        sqlStr = sqlStr & " , (select count(*) from db_my10x10.dbo.tbl_myfavorite_play as p where p.codeidx =d.DFSeq and p.playcode = "& Fplaycode &") as favcnt "
        sqlStr = sqlStr & " , (select count(*) from db_my10x10.dbo.tbl_myfavorite_play as p where p.codeidx =d.DFSeq and p.playcode = "& Fplaycode &" and p.userid = '"& Fuserid &"') as chkfav "
		sqlStr = sqlStr & " from db_sitemaster.dbo.tbl_designfingers as d "
        sqlStr = sqlStr & " where convert(varchar(10),getdate(),120) >= d.opendate and d.IsUsing = 1 AND d.IsDisplay = 1"
        sqlStr = sqlStr & " order by d.DFSeq DESC, d.opendate desc"

		'response.write sqlStr &"<Br>"
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
                set FItemList(i) = new CPlayContentsItem

'                FItemList(i).FDFSeq						= rsget("DFSeq")
'				FItemList(i).Ftitle						= rsget("title")
'                FItemList(i).Flistimg					= rsget("listimg")
'                FItemList(i).FImgURL					= rsget("ImgURL")
'                FItemList(i).FCommentCnt				= rsget("CommentCnt")
'                FItemList(i).FPrizeDate					= rsget("PrizeDate")
'                FItemList(i).FRegDate					= rsget("RegDate")
'                FItemList(i).FIsMovie					= rsget("IsMovie")
                FItemList(i).Ffavcnt					= rsget("favcnt")
                FItemList(i).Fchkfav					= rsget("chkfav")

                rsget.movenext
                i=i+1
            loop
        end if
        rsget.Close
    end Function

    'play VideoClip 2013-09-13 이종화
	public Sub GetOneRowVideoClipContent()
	dim sqlStr
	sqlStr = "select * "
	sqlStr = sqlStr & " , (select count(*) from db_my10x10.dbo.tbl_myfavorite_play as p where p.codeidx = "& FRectIdx &" and p.playcode = "& Fplaycode &") as favcnt "
	sqlStr = sqlStr & " , (select count(*) from db_my10x10.dbo.tbl_myfavorite_play as p where p.codeidx = "& FRectIdx &" and p.playcode = "& Fplaycode &" and p.userid = '"& Fuserid &"') as chkfav "
	sqlStr = sqlStr + " from db_sitemaster.dbo.tbl_play_video_clip"
	sqlStr = sqlStr + " where vidx=" + CStr(FRectIdx)
	rsget.Open SqlStr, dbget, 1
	FResultCount = rsget.RecordCount

	set FOneItem = new CPlayContentsItem

	if Not rsget.Eof then

		FOneItem.Fidx						= rsget("vidx")
		FOneItem.Flistimg					= rsget("listimg")
		FOneItem.Fviewtitle					= rsget("viewtitle")
		FOneItem.Fviewtext					= rsget("viewtext")
		FOneItem.Freservationdate			= rsget("reservationdate")
		FOneItem.Fstate						= rsget("state")
		FOneItem.Fviewno					= rsget("viewno")
		FOneItem.Fworktext					= rsget("worktext")
		FOneItem.Fvideourl					= rsget("videourl")
		FOneItem.Fregdate					= rsget("regdate")
		FOneItem.Ffavcnt					= rsget("favcnt")
        FOneItem.Fchkfav					= rsget("chkfav")


	end if
	rsget.Close
	end Sub

	public function fnGetVideoClipList()
        dim sqlStr, i

		'// 결과수 카운트
		sqlStr = "select count(*) as cnt"
        sqlStr = sqlStr & " from db_sitemaster.dbo.tbl_play_video_clip"
        sqlStr = sqlStr & " where state = 7 and convert(varchar(10),getdate(),120) >= reservationdate"

		'response.write sqlStr &"<Br>"
        rsget.Open sqlStr,dbget,1
            FTotalCount = rsget("cnt")
        rsget.Close

		if FTotalCount < 1 then exit function

        '// 본문 내용 접수
        sqlStr = "select top " + Cstr(FPageSize * FCurrPage)
        sqlStr = sqlStr & " vidx , viewno , listimg , viewtitle , reservationdate , state , videourl"
        sqlStr = sqlStr & " , (select count(*) from db_my10x10.dbo.tbl_myfavorite_play as p where p.codeidx = vidx and p.playcode = "& Fplaycode &") as favcnt "
        sqlStr = sqlStr & " , (select count(*) from db_my10x10.dbo.tbl_myfavorite_play as p where p.codeidx = vidx and p.playcode = "& Fplaycode &" and p.userid = '"& Fuserid &"') as chkfav "
		sqlStr = sqlStr & " from db_sitemaster.dbo.tbl_play_video_clip "
        sqlStr = sqlStr & " where state = 7 and convert(varchar(10),getdate(),120) >= reservationdate"
        sqlStr = sqlStr & " order by viewNo DESC, reservationdate desc"

		'response.write sqlStr &"<Br>"
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
                set FItemList(i) = new CPlayContentsItem

                FItemList(i).Fidx						= rsget("vidx")
				FItemList(i).Fviewno					= rsget("viewno")
                FItemList(i).Flistimg					= rsget("listimg")
                FItemList(i).Fviewtitle					= rsget("viewtitle")
                FItemList(i).Freservationdate			= rsget("reservationdate")
                FItemList(i).Fstate						= rsget("state")
                FItemList(i).Fvideourl					= rsget("videourl")
                FItemList(i).Ffavcnt					= rsget("favcnt")
                FItemList(i).Fchkfav					= rsget("chkfav")

                rsget.movenext
                i=i+1
            loop
        end if
        rsget.Close
    end Function

	Public Sub sbGetPhotoPickItem
		Dim sqlStr, i, sqladd
		sqlStr = "exec [db_sitemaster].[dbo].[sp_Ten_play_PhotoPick_Cnt]"
		rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
		rsget.pagesize = FPageSize
		rsget.Open sqlStr,dbget,1
			FTotalCount = rsget("cnt")
		rsget.Close
		If FTotalCount < 1 then exit Sub
		sqlStr = "exec [db_sitemaster].[dbo].[sp_Ten_play_PhotoPick_List] '" & CStr(FPageSize*FCurrPage) & "'"

		'Response.write sqlStr &"<br>"
        rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
        rsget.pagesize = FPageSize
		rsget.Open sqlStr,dbget,1

	    FtotalPage = CInt(FTotalCount\FPageSize)
		if  (FTotalCount\FPageSize)<>(FTotalCount/FPageSize) then
			FtotalPage = FtotalPage +1
		end if
		FResultCount = rsget.RecordCount-(FPageSize*(FCurrPage-1))

        if (FResultCount<1) then FResultCount=0

		Redim preserve FItemList(FResultCount)
		i = 0
		If  not rsget.EOF  then
			rsget.absolutepage = FCurrPage
			Do until rsget.eof
				Set FItemList(i) = new CPlayContentsItem
					FItemList(i).Fidx		= rsget("idx")
					FItemList(i).FViewtitle	= rsget("viewtitle")
					FItemList(i).FSubtitle	= rsget("subtitle")
					FItemList(i).FIsusing	= rsget("isusing")
					FItemList(i).FPPimg		= rsget("PPimg")
					FItemList(i).FRegdate	= rsget("regdate")
				i = i + 1
				rsget.moveNext
			Loop
		End If
		rsget.Close
	End Sub

	Public Sub sbGetPhotoPickOneItem
		Dim sqlStr, i, sqladd
		sqlStr = "exec [db_sitemaster].[dbo].[sp_Ten_play_PhotoPick_OneItem] '" & FRectIdx & "' "
        rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
        rsget.pagesize = FPageSize
		rsget.Open sqlStr,dbget,1
		FResultCount = rsget.RecordCount
		If Not rsget.Eof Then
			Set FOneItem = new CPlayContentsItem
				FOneItem.Fidx		= rsget("idx")
				FOneItem.FViewtitle	= rsget("viewtitle")
				FOneItem.FSubtitle	= rsget("subtitle")
				FOneItem.FIsusing	= rsget("isusing")
				FOneItem.FPPimg		= rsget("PPimg")
				FOneItem.FRegdate	= rsget("regdate")
		End If
		rsget.Close
	End Sub

	'//play main페이지 top banner
	public Sub GetOneRowGroundPlayMain()
		dim sqlStr

		sqlStr = "select top 1 s.gcidx , s.gidx , s.viewno , s.viewtitle , s.playmainimg , s.mainbgcolor "
		sqlStr = sqlStr + " from db_sitemaster.dbo.tbl_play_ground_sub as s "
		sqlStr = sqlStr + " inner join db_sitemaster.dbo.tbl_play_ground_main as m "
		sqlStr = sqlStr + " on s.gidx = m.gidx "
		sqlStr = sqlStr + " where s.state = 7 and convert(varchar(10),getdate(),120) >= s.reservationdate "
		sqlStr = sqlStr + " order by m.viewno desc , s.viewno desc "
		'response.write sqlStr &"<Br>"
		rsget.Open SqlStr, dbget, 1
		FResultCount = rsget.RecordCount

		set FOneItem = new CPlayContentsItem

		if Not rsget.Eof then

			FOneItem.Fidx						= rsget("gcidx")
			FOneItem.Fidxsub					= rsget("gidx")
			FOneItem.Fviewno				= rsget("viewno")
			FOneItem.Fviewtitle				= rsget("viewtitle")
			FOneItem.Fplaymainimg		= rsget("playmainimg")
			FOneItem.FmainBGColor		= rsget("mainbgcolor")

		end if
		rsget.Close
	End Sub

	public function fnStylePlayMain()
        dim sqlStr ,i

		'// 본문 내용 접수
        sqlStr = "select top 3 "
        sqlStr = sqlStr & " styleidx , listimg , viewtitle "
        sqlStr = sqlStr & " from db_sitemaster.dbo.tbl_play_style_list "
        sqlStr = sqlStr & " where state = 7 and convert(varchar(10),getdate(),120) >= reservationdate "
        sqlStr = sqlStr & " order by styleidx desc "

		'response.write sqlStr &"<Br>"
        rsget.pagesize = FPageSize
        rsget.Open sqlStr,dbget,1

		FResultCount = rsget.RecordCount

        if (FResultCount<1) then FResultCount=0

        redim preserve FItemList(FResultCount)

	    i=0
        if  not rsget.EOF  then
            rsget.absolutepage = FCurrPage
            do until rsget.EOF
                set FItemList(i) = new CPlayContentsItem

				FItemList(i).Fidx						= rsget("styleidx")
				FItemList(i).Fviewtitle				= rsget("viewtitle")
				FItemList(i).Fplaymainimg			= rsget("listimg")

                rsget.movenext
                i=i+1
            loop
        end if
        rsget.Close
    end Function

	public function fnGroundPlayMain()
        dim sqlStr ,i

		'// 본문 내용 접수
        sqlStr = "select top 1 "
        sqlStr = sqlStr & " gidx , viewtitle , mainimg "
        sqlStr = sqlStr & " from db_sitemaster.dbo.tbl_play_ground_main "
        sqlStr = sqlStr & " where state = 7 and convert(varchar(10),getdate(),120) >= reservationdate "
        sqlStr = sqlStr & " order by gidx desc ,viewno desc "

		'response.write sqlStr &"<Br>"
        rsget.pagesize = FPageSize
        rsget.Open sqlStr,dbget,1

		FResultCount = rsget.RecordCount

        if (FResultCount<1) then FResultCount=0

        redim preserve FItemList(FResultCount)

        i=0
        if  not rsget.EOF  then
            rsget.absolutepage = FCurrPage
            do until rsget.EOF
                set FItemList(i) = new CPlayContentsItem

				FItemList(i).Fidx						= rsget("gidx")
				FItemList(i).Fviewtitle				= rsget("viewtitle")
				FItemList(i).Fplaymainimg		= rsget("mainimg")

                rsget.movenext
                i=i+1
            loop
        end if
        rsget.Close
    end Function

	public function fnPictureDiaryPlayMain()
        dim sqlStr ,i

		'// 본문 내용 접수
        sqlStr = "select top 3 "
        sqlStr = sqlStr & " pdidx , viewno , viewtitle , listimg "
        sqlStr = sqlStr & " from db_sitemaster.dbo.tbl_play_picture_diary "
        sqlStr = sqlStr & " where state = 7 and convert(varchar(10),getdate(),120) >= reservationdate "
        sqlStr = sqlStr & " order by viewno desc , pdidx desc "

		'response.write sqlStr &"<Br>"
        rsget.pagesize = FPageSize
        rsget.Open sqlStr,dbget,1

		FResultCount = rsget.RecordCount

        if (FResultCount<1) then FResultCount=0

        redim preserve FItemList(FResultCount)

        i=0
        if  not rsget.EOF  then
            rsget.absolutepage = FCurrPage
            do until rsget.EOF
                set FItemList(i) = new CPlayContentsItem

				FItemList(i).Fidx						= rsget("pdidx")
				FItemList(i).Fviewno					= rsget("viewno")
				FItemList(i).Fviewtitle				= rsget("viewtitle")
				FItemList(i).Flistimg					= rsget("listimg")

                rsget.movenext
                i=i+1
            loop
        end if
        rsget.Close
    end Function

	public function fnDeignfingersPlayMain()
        dim sqlStr ,i

		'// 본문 내용 접수
        sqlStr = "select top 2 dfseq , title  "
        sqlStr = sqlStr & " , (select imgurl from db_sitemaster.dbo.tbl_designfingers_image where dfseq = d.dfseq and dfcodeseq = 8) as listimg "
        sqlStr = sqlStr & " from db_sitemaster.dbo.tbl_designfingers as d "
        sqlStr = sqlStr & " where convert(varchar(10),getdate(),120) >= d.opendate and d.IsUsing = 1 AND d.IsDisplay = 1 "
        sqlStr = sqlStr & " order by d.DFSeq DESC, d.opendate desc "

		'response.write sqlStr &"<Br>"
        rsget.pagesize = FPageSize
        rsget.Open sqlStr,dbget,1

		FResultCount = rsget.RecordCount

        if (FResultCount<1) then FResultCount=0

        redim preserve FItemList(FResultCount)

        i=0
        if  not rsget.EOF  then
            rsget.absolutepage = FCurrPage
            do until rsget.EOF
                set FItemList(i) = new CPlayContentsItem

				FItemList(i).Fidx						= rsget("dfseq")
				FItemList(i).Fviewtitle				= rsget("title")
				FItemList(i).Flistimg					= rsget("listimg")

                rsget.movenext
                i=i+1
            loop
        end if
        rsget.Close
    end Function

	public function fncolortrendPlayMain()
        dim sqlStr ,i

		'// 본문 내용 접수
        sqlStr = "select top 2 "
        sqlStr = sqlStr & " ctcode , colorcode , colortitle , listimg "
        sqlStr = sqlStr & " from db_item.dbo.tbl_colortrend "
        sqlStr = sqlStr & " where state = 7 and convert(varchar(10),getdate(),120) >= startdate "
        sqlStr = sqlStr & " order by startdate desc "

		'response.write sqlStr &"<Br>"
        rsget.pagesize = FPageSize
        rsget.Open sqlStr,dbget,1

		FResultCount = rsget.RecordCount

        if (FResultCount<1) then FResultCount=0

        redim preserve FItemList(FResultCount)

        i=0
        if  not rsget.EOF  then
            rsget.absolutepage = FCurrPage
            do until rsget.EOF
                set FItemList(i) = new CPlayContentsItem

				FItemList(i).Fidx						= rsget("ctcode")
				FItemList(i).Fidxsub					= rsget("colorcode")
				FItemList(i).Fviewtitle				= rsget("colortitle")
				FItemList(i).Flistimg					= rsget("listimg")

                rsget.movenext
                i=i+1
            loop
        end if
        rsget.Close
    end Function

	public function fnVideoClipPlayMain()
        dim sqlStr ,i

		'// 본문 내용 접수
        sqlStr = "select top 2 "
        sqlStr = sqlStr & " vidx , listimg , viewtitle "
        sqlStr = sqlStr & " from db_sitemaster.dbo.tbl_play_video_clip "
        sqlStr = sqlStr & " where state = 7 and convert(varchar(10),getdate(),120) >= reservationdate "
        sqlStr = sqlStr & " order by vidx desc "

		'' response.write sqlStr &"<Br>"
		'' response.end
        rsget.pagesize = FPageSize
        rsget.Open sqlStr,dbget,1

		FResultCount = rsget.RecordCount

        if (FResultCount<1) then FResultCount=0

        redim preserve FItemList(FResultCount)

        i=0
        if  not rsget.EOF  then
            rsget.absolutepage = FCurrPage
            do until rsget.EOF
                set FItemList(i) = new CPlayContentsItem

				FItemList(i).Fidx						= rsget("vidx")
				FItemList(i).Fviewtitle				= rsget("viewtitle")
				FItemList(i).Flistimg					= rsget("listimg")

                rsget.movenext
                i=i+1
            loop
        end if
        rsget.Close
    end Function

	Public Sub sbGetMainplayBanner
		Dim sqlStr, i
		sqlStr = "exec [db_sitemaster].[dbo].[sp_Ten_MainplayBanner]"
		'Response.write sqlStr &"<br>"
        rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
		rsget.Open sqlStr,dbget,1
		FResultCount = rsget.RecordCount
        If (FResultCount<1) then FResultCount=0
        redim preserve FItemList(FResultCount)
        i=0
		If  not rsget.EOF  then
			rsget.absolutepage = FCurrPage
			Do until rsget.eof
				Set FItemList(i) = new CPlayContentsItem
					FItemList(i).Fplaycate	= rsget("playcate")
					FItemList(i).FIdx		= rsget("idx")
					FItemList(i).FlistImage	= rsget("listImage")
					FItemList(i).FOpendate	= rsget("opendate")
					FItemList(i).Fviewno	= rsget("sortNo")
				i = i + 1
				rsget.moveNext
			Loop
		End If
		rsget.Close
	End Sub

	'play ground sns공유시 og태그에 들어갈 해당 회차에 맞는 이미지 가져오기
	public Sub GetGroundMainOgImg()
	dim sqlStr , sqlsearch

	if FRectIdx <> "0" then
			sqlsearch = sqlsearch & " and m.gidx = '"& FRectIdx &"'"
	end If
	if FRectsubIdx <> "0" then
			sqlsearch = sqlsearch & " and s.gcidx = '"& FRectsubIdx &"'"
	end If

	sqlStr = "select top 1 * "
	sqlStr = sqlStr + " from db_sitemaster.dbo.tbl_play_ground_main as m "
	sqlStr = sqlStr + " inner join db_sitemaster.dbo.tbl_play_ground_sub as s on m.gidx = s.gidx "
	sqlStr = sqlStr + " where m.state = 7 and convert(varchar(10),getdate(),120) >= m.reservationdate " & sqlsearch
    sqlStr = sqlStr & " order by s.gcidx DESC , s.viewno desc , m.reservationdate desc"
	'response.write sqlStr &"<Br>"
	rsget.Open SqlStr, dbget, 1

	set FOneItem = new CPlayContentsItem

	if Not rsget.Eof then
		FOneItem.Fplaymainimg			= rsget("playmainimg")
	end if
	rsget.Close
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
