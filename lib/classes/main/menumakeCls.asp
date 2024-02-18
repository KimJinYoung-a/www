<%
Class CMainMenuItem
	public Ftype
	public Fnumber
	public Fvalue
	public Fcodename
	public Fcatecode
	public Fdepth
	public Fcatename
	public Fdep3exist
	public Fdep4list

	
	Private Sub Class_Initialize()
	End Sub

	Private Sub Class_Terminate()
	End Sub
	
end Class

Class CMainMenu
    public FOneItem
    public FItemList()
	public FResultCount
    public FRectCateCode
    public FRectUseYN
	public Fsubject
	public Flinkurl
	public Fimgurl
    
    
    public Function GetMainMenuListNew()
    	dim sqlStr, addSql, i
    	
    	'### select 2depthcode, 2depthname, isnew
		sqlStr = "SELECT " & _
				 "	A.catecode, A.catename, A.isnew " & _
				 "FROM [db_item].[dbo].[tbl_display_cate] AS A " & _
				 "WHERE Left(A.catecode,3) = '" & FRectCateCode & "' AND A.depth = 2 AND A.useyn = 'Y' " & _
				 "	ORDER BY A.sortNo ASC "
		rsget.Open sqlStr,dbget, 1
		FResultCount = rsget.RecordCount
		IF not rsget.EOF THEN
			GetMainMenuListNew = rsget.getRows() 
		END IF	
		rsget.close
    End Function
    
    
    public Function GetMainMenuListNewDepth3()
    	dim sqlStr, addSql, i
    	
    	'### select 2depthcode, 2depthname, isnew
		sqlStr = "SELECT " & _
				 "	A.catecode, A.catename, A.isnew " & _
				 "FROM [db_item].[dbo].[tbl_display_cate] AS A " & _
				 "WHERE Left(A.catecode,6) = '" & FRectCateCode & "' AND A.depth = 3 AND A.useyn = 'Y' " & _
				 "	ORDER BY A.sortNo ASC "
		rsget.Open sqlStr,dbget,1
		FResultCount = rsget.RecordCount
		IF not rsget.EOF THEN
			GetMainMenuListNewDepth3 = rsget.getRows() 
		END IF	
		rsget.close
    End Function
    
    
    '####### Left 카테고리메뉴 생성 쿼리.
    public Sub GetLeftMenuList()
    	dim sqlStr, addSql, i
		
		Dim vArr2, vArr3, j, k, vTotalCount
		sqlStr = "SELECT c.catecode, c.depth, c.catename, "
		sqlStr = sqlStr & "	(select count(catecode) from [db_item].[dbo].[tbl_display_cate] where Left(catecode,6) = c.catecode and depth in(3) AND useyn = '" & FRectUseYN & "') as isexist "
		sqlStr = sqlStr & " , '' as dep4list "
		sqlStr = sqlStr & "	FROM [db_item].[dbo].[tbl_display_cate] AS c "
    	sqlStr = sqlStr & "	WHERE Left(c.catecode,3) = '" & FRectCateCode & "' and c.depth in(2) AND c.useyn = '" & FRectUseYN & "' ORDER BY c.sortNo ASC "
		rsget.Open sqlStr, dbget, 1
		if Not(rsget.EOF or rsget.BOF) then
			vArr2 = rsget.getRows()
			vTotalCount = rsget.RecordCount
		end if
		rsget.close
		
		sqlStr = "SELECT c.catecode, c.depth, c.catename, "
		sqlStr = sqlStr & "	1 as isexist "
		sqlStr = sqlStr & " , '' AS dep4list "
		'sqlStr = sqlStr & " , isNull( "
		'sqlStr = sqlStr & " 	STUFF(( "
		'sqlStr = sqlStr & " 		SELECT ',' + cast(cc.catecode as varchar(15)) + '||' + cc.catename "
		'sqlStr = sqlStr & " 		FROM [db_item].[dbo].[tbl_display_cate] AS cc "
		'sqlStr = sqlStr & " 		WHERE cc.depth = 4 and Left(cc.catecode,9) = c.catecode "
		'sqlStr = sqlStr & "				and cc.useyn = '" & FRectUseYN & "' "
		'sqlStr = sqlStr & " 		ORDER BY cc.sortNo ASC "
		'sqlStr = sqlStr & " 	FOR XML PATH('') "
		'sqlStr = sqlStr & " 	), 1, 1, '') "
		'sqlStr = sqlStr & " 	,'') AS dep4list "
		sqlStr = sqlStr & "	FROM [db_item].[dbo].[tbl_display_cate] AS c "
    	sqlStr = sqlStr & "	WHERE Left(c.catecode,3) = '" & FRectCateCode & "' and c.depth in(3) AND c.useyn = '" & FRectUseYN & "' ORDER BY Left(c.catecode,6) ASC, c.sortNo ASC "
		rsget.Open sqlStr, dbget, 1
		if Not(rsget.EOF or rsget.BOF) then
			vArr3 = rsget.getRows()
			vTotalCount = vTotalCount + rsget.RecordCount
		end if
		rsget.close

		FResultCount = vTotalCount
		redim preserve FItemList(FResultCount)
		k = 0
		For i=0 To UBound(vArr2,2)
			set FItemList(k) = new CMainMenuItem
            FItemList(k).Fcatecode	= vArr2(0,i)
            FItemList(k).Fdepth		= vArr2(1,i)
            FItemList(k).Fcatename	= db2html(vArr2(2,i))
            FItemList(k).Fdep3exist	= vArr2(3,i)
            FItemList(k).Fdep4list	= vArr2(4,i)
			k=k+1
			For j=0 To UBound(vArr3,2)
				If CStr(vArr2(0,i)) = Left(CStr(vArr3(0,j)),6) Then
					set FItemList(k) = new CMainMenuItem
		            FItemList(k).Fcatecode	= vArr3(0,j)
		            FItemList(k).Fdepth		= vArr3(1,j)
		            FItemList(k).Fcatename	= db2html(vArr3(2,j))
		            FItemList(k).Fdep3exist	= vArr3(3,j)
		            FItemList(k).Fdep4list	= vArr3(4,j)
					k=k+1
				Else
				
				End If
				

			Next
		Next
    End Sub
    
    
    '####### BOOK Left 북카테고리메뉴 생성 쿼리.
    public Sub GetBOOKLeftMenuList()
    	dim sqlStr, addSql, i
		
		'### 1Depth 받아옴.
		Dim vDep1, j, k, vTotalCount, vDep1Cnt
		sqlStr = "SELECT c.catecode, c.depth, c.catename, "
		sqlStr = sqlStr & "	(select catecode from [db_item].[dbo].[tbl_display_cate] where Left(catecode,3) = c.catecode and catename = 'BOOK' and depth in(2)) AS dep2code "
		sqlStr = sqlStr & "	FROM [db_item].[dbo].[tbl_display_cate] AS c "
    	sqlStr = sqlStr & "	WHERE c.depth = '1' AND c.useyn = '" & FRectUseYN & "' ORDER BY c.sortNo ASC "
		rsget.Open sqlStr, dbget, 1
		if Not(rsget.EOF or rsget.BOF) then
			vDep1Cnt = rsget.recordcount
			vDep1 = rsget.getRows()
		end if
		rsget.close
		

		'### 1depth 돌려서 3dep 카테고리 가져옴. 1dep 수만큼 돔.
		vTotalCount = 0
		Dim vArr(20)
		For j=0 To UBound(vDep1,2)
			sqlStr = "SELECT c.catecode, c.depth, c.catename "
			sqlStr = sqlStr & "	FROM [db_item].[dbo].[tbl_display_cate] AS c "
	    	sqlStr = sqlStr & "	WHERE Left(c.catecode,6) = '" & vDep1(3,j) & "' and c.depth = '3' AND c.useyn = '" & FRectUseYN & "' ORDER BY c.sortNo ASC, c.catecode "
			rsget.Open sqlStr, dbget, 1
			if Not(rsget.EOF or rsget.BOF) then
				vTotalCount = vTotalCount + rsget.recordcount
				vArr(j) = rsget.getRows()
			end if
			rsget.close
		Next
		
		'### 1뎁과 3뎁 카운트수를 더함. 총배열수를 구하기위해.
		vTotalCount = vTotalCount + vDep1Cnt

		i = 0
		j = 0
		k = 0
		
		redim preserve FItemList(vTotalCount-1)
		
		For j=0 To UBound(vDep1,2)
			set FItemList(k) = new CMainMenuItem
			FItemList(k).Fcatecode	= vDep1(3,j)
			FItemList(k).Fdepth		= "1"
			FItemList(k).Fcatename	= db2html(vDep1(2,j))
			FItemList(k).Fdep3exist	= CHKIIF(IsArray(vArr(j)),1,0)
			k=k+1

			if IsArray(vArr(j)) Then
				For i=0 To UBound(vArr(j),2)
					set FItemList(k) = new CMainMenuItem
					FItemList(k).Fcatecode	= vArr(j)(0,i)
					FItemList(k).Fdepth		= "3"
					FItemList(k).Fcatename	= db2html(vArr(j)(2,i))
					FItemList(k).Fdep3exist	= "1"
					k=k+1

				Next
			end if
		Next
		FResultCount = vTotalCount
    End Sub


    public Sub GetCateTopBannerImg()
    	dim sqlStr, addSql, i
		sqlStr = "SELECT Top 1 " & _
				 "	a.linkurl, a.imgurl " & _
				 "FROM [db_item].[dbo].[tbl_display_cate_menu_top] as a " & _
				 "WHERE a.disp1 = '" & FRectCateCode & "' AND a.type = 'topbanner' AND a.useyn = 'y' " & _
				 "	ORDER BY a.sortno ASC, a.idx DESC "
		rsget.Open sqlStr,dbget,1
		FResultCount = rsget.RecordCount
		IF not rsget.EOF THEN
			Flinkurl = Trim(rsget("linkurl"))
			Fimgurl = Trim(rsget("imgurl"))
		END IF
		rsget.close
    End Sub
    
    
	Private Sub Class_Initialize()
		redim  FItemList(0)
		FResultCount = 0
	End Sub

	Private Sub Class_Terminate()
	End Sub
end Class
%>