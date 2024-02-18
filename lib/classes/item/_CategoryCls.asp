<%
'#######################################################
'	History	: 2008.03.26 허진원 생성
'			  2008.04.13 한용민 추가
'	Description : 카테고리 페이지(메인/목록) 클래스
'#######################################################

'#=========================================#
'# 상품 페이지 & 상품 리스트  클래스       #
'#=========================================#

CLASS CAutoCategory
	public FTotalCount
	public FCurrPage
	public FTotalPage
	public FPageSize
	public FResultCount
	public FScrollCount

	public FRectItemId
	public FRectDisp
	public FRectCD1
	public FRectCD2
	public FRectCD3
	public FRectMakerID
	public FItemList()

	public FDiscountRate
	public FCategoryList()
	public FCategorySubList()
	public FCategoryPrdList()
	public FCategoryBrand()
	public FCategoryPrd
	public FADD()

	public FResultBCount
	public RoundUP

	public FRectBestType

	public FRectCH
	public FRectOrder
	public FRectStyleGubun
	public FRectItemStyle
	public FRectSort
	public FNotinlist
	Public FRectitemarr
	Public Fdesignerid

	Public FRectOnlySellY

	public FRectPercentLow
    public FRectPercentHigh

    public FRectSearchFlag
    public FRectSortMethod
	public FRectSearchItemDiv
	public FRectIsBookCate
	public FBookDownDepNoYes
    
    Public FRectDelLimitCost '// 원클릭업셀 추가
	Public FRectUserId	'// 원클릭업셀 추가
	Public FRectTenBaeChk '// 원클릭업셀 추가
	Public FRectHappyTogetherType
	
	Private Sub Class_Initialize()
		FCurrPage =1
		FPageSize = 10
		FTotalPage = 1
		FResultCount = 0
		FScrollCount = 10
		FTotalCount =0
	End Sub

	Private Sub Class_Terminate()
	End Sub


    '// 카테고리 Left Happy Together && Left Category Best 목록 접수 //
    '// Happy Together 우선적으로 채운후 Category Best로 채움
    Public sub GetCateRightHappyTogetherNCateBestItemList()
        dim i, pItemArr, sqlStr, sqlStr2
		Dim rsMem
        const MaxTopN = 10


		sqlStr = "exec db_sitemaster.dbo.sp_Ten_happyTogether_List '" & CStr(FRectItemId) & "'," & (MaxTopN)

        '커서 위치 지정
'		rsget.CursorLocation = adUseClient
'		rsget.CursorType = adOpenStatic
'		rsget.LockType = adLockOptimistic
		set rsMem = getDBCacheSQL(dbget,rsget,"HappyTogether",sqlStr,60*1)
		if (rsMem is Nothing) then Exit sub ''추가

		FResultCount = rsMem.RecordCount
		redim preserve FItemList(FResultCount)

		i=0
		pItemArr =""

		if  not rsMem.EOF  then
			do until rsMem.eof
				set FItemList(i) = new CCategoryPrdItem

				FItemList(i).FItemID		= rsMem("itemid")
				FItemList(i).FItemName		= db2html(rsMem("itemname"))
				FItemList(i).FImageList		= "http://webimage.10x10.co.kr/image/list/" + GetImageSubFolderByItemid(rsMem("itemid")) + "/" + rsMem("listimage")
				FItemList(i).FImageList120	= "http://webimage.10x10.co.kr/image/list120/" + GetImageSubFolderByItemid(rsMem("itemid")) + "/" + rsMem("listimage120")
				FItemList(i).FIcon1Image  = "http://webimage.10x10.co.kr/image/icon1/" + GetImageSubFolderByItemid(rsMem("itemid")) + "/" + rsMem("icon1image")
				FItemList(i).FBrandName		= db2html(rsMem("brandname"))
				FItemList(i).FMakerID		= db2html(rsMem("makerid"))
				FItemList(i).Fitemdiv		= rsMem("itemdiv")

				FItemList(i).FSellCash 		= rsMem("sellcash")
				FItemList(i).FOrgPrice 		= rsMem("orgprice")
				FItemList(i).FSellyn 		= rsMem("sellyn")
				FItemList(i).FSaleyn 		= rsMem("sailyn")
				FItemList(i).FLimityn 		= rsMem("limityn")
				FItemList(i).FLimitNo      = rsMem("limitno")
				FItemList(i).FLimitSold    = rsMem("limitsold")
				FItemList(i).FItemcouponyn 	= rsMem("itemcouponyn")
				FItemList(i).FItemCouponValue 	= rsMem("itemCouponValue")
				FItemList(i).FItemCouponType 	= rsMem("itemCouponType")
				FItemList(i).FEvalCnt 	= rsMem("evalcnt")
				FItemList(i).FfavCount 	= rsMem("favcount")
                FItemList(i).FOptionCnt = rsMem("optioncnt")

                pItemArr = pItemArr + CStr(FItemList(i).FItemID) + ","
				i=i+1
				rsMem.moveNext
			loop
		end if

		rsMem.Close

		''결과 값이 MaxTopN개 미만인경우 중복 안되게 MaxTopN개 채움
		if (FResultCount<MaxTopN) Then

	   		If FRectDisp = "" OR FRectDisp = "0" Then
    			FRectDisp = "100"
    		End If

			sqlStr2 = "exec db_sitemaster.dbo.[sp_Ten_dispcateBestChoice_List] '" & FRectDisp & "','" & (Len(FRectDisp)/3) & "','" & CStr(FRectItemId) & "'," & MaxTopN
            '커서 위치 지정
'    		rsget.CursorLocation = adUseClient
'    		rsget.CursorType = adOpenStatic
'    		rsget.LockType = adLockOptimistic
			set rsMem = getDBCacheSQL(dbget,rsget,"HappyTogetherBest",sqlStr2,60*1)



    		if  not rsMem.EOF  then
    			do until rsMem.eof
                    if (InStr(pItemArr,CStr(rsMem("itemid")) & "," )>0) then
                        ''이미 표시된 상품인경우 skip
                    else
                        if (FResultCount>=MaxTopN) then Exit do
                        FResultCount = FResultCount + 1
                        redim preserve FItemList(FResultCount)
        				set FItemList(i) = new CCategoryPrdItem

        				FItemList(i).FItemID		= rsMem("itemid")
        				FItemList(i).FItemName		= db2html(rsMem("itemname"))
        				FItemList(i).FImageList		= "http://webimage.10x10.co.kr/image/list/" + GetImageSubFolderByItemid(rsMem("itemid")) + "/" + rsMem("listimage")
        				FItemList(i).FImageList120	= "http://webimage.10x10.co.kr/image/list120/" + GetImageSubFolderByItemid(rsMem("itemid")) + "/" + rsMem("listimage120")
						FItemList(i).FIcon1Image  = "http://webimage.10x10.co.kr/image/icon1/" + GetImageSubFolderByItemid(rsMem("itemid")) + "/" + rsMem("icon1image")
        				FItemList(i).FBrandName		= db2html(rsMem("brandname"))
        				FItemList(i).FMakerID		= db2html(rsMem("makerid"))
        				FItemList(i).Fitemdiv		= rsMem("itemdiv")
        				FItemList(i).FEvalCnt		= rsMem("evalcnt")
						FItemList(i).FSellCash 		= rsMem("sellcash")
						FItemList(i).FOrgPrice 		= rsMem("orgprice")
						FItemList(i).FSellyn 		= rsMem("sellyn")
						FItemList(i).FSaleyn 		= rsMem("sailyn")
						FItemList(i).FLimityn 		= rsMem("limityn")
						FItemList(i).FLimitNo      = rsMem("limitno")
						FItemList(i).FLimitSold    = rsMem("limitsold")
						FItemList(i).FItemcouponyn 	= rsMem("itemcouponyn")
						FItemList(i).FItemCouponValue 	= rsMem("itemCouponValue")
						FItemList(i).FItemCouponType 	= rsMem("itemCouponType")
		                FItemList(i).FOptionCnt = rsMem("optioncnt")

        				i=i+1
    				end if
    				rsMem.moveNext
    			loop
    		end if

    		rsMem.Close

		end if

    end Sub

	'// 쇼핑백에서 사용하는 해피투게더 목록
	'// 결과값이 MaxTopN개 이하이면 베스트 상품 뿌려줌
    Public sub GetCateRightHappyTogetherNCateBestItemShoppingBagList()
        dim i, pItemArr, sqlStr, sqlStr2
		Dim rsMem
        const MaxTopN = 10

		sqlStr = " Select  top "&MaxTopN
		sqlStr = sqlStr & " 	t2.itemid, t2.itemname, t2.listimage, t2.listimage120, t2.icon1image,  "
		sqlStr = sqlStr & " 	(Case When isNull(t2.frontMakerid,'')='' then t2.makerid else t2.frontMakerid end) as makerid, t2.brandname, t2.specialuseritem,  "
		sqlStr = sqlStr & " 	t2.itemdiv, t2.evalcnt, ic.favcount, isNull(t2.sellcash,0) as sellcash, isNull(t2.orgprice,0) as orgprice,  "
		sqlStr = sqlStr & " 	isNull(t2.sellyn,'') as sellyn, isNull(t2.sailyn,'') as sailyn, isNull(t2.limityn,'') as limityn, isNull(t2.itemcouponyn,'') as itemcouponyn,  "
		sqlStr = sqlStr & " 	isNull(t2.itemCouponValue,'') as itemCouponValue, isNull(t2.itemCouponType,'') as itemCouponType, t2.limitno, t2.limitsold, t2.optioncnt, t2.itemscore "
		sqlStr = sqlStr & " From "
		sqlStr = sqlStr & " ( "
		sqlStr = sqlStr & " 	Select distinct itemid2 From db_sitemaster.dbo.tbl_category_happyTogether  "
		sqlStr = sqlStr & " 	Where itemid1 in ("&FRectItemId&") And itemid2 not in ("&FRectItemId&") "
		sqlStr = sqlStr & " )t1 "
		sqlStr = sqlStr & " Join db_item.dbo.tbl_item as t2 on t1.itemid2=t2.itemid  "
		sqlStr = sqlStr & " Join [db_item].[dbo].tbl_item_Contents ic on t1.itemid2=ic.itemid  "
		sqlStr = sqlStr & " Where t2.sellyn='Y'  "
		sqlStr = sqlStr & " order by t2.itemscore desc "
        '커서 위치 지정
'		rsget.CursorLocation = adUseClient
'		rsget.CursorType = adOpenStatic
'		rsget.LockType = adLockOptimistic
		rsget.Open sqlStr, dbget, 1



		FResultCount = rsget.RecordCount
		redim preserve FItemList(FResultCount)

		i=0
		pItemArr =""

		if  not rsget.EOF  then
			do until rsget.eof
				set FItemList(i) = new CCategoryPrdItem

				FItemList(i).FItemID		= rsget("itemid")
				FItemList(i).FItemName		= db2html(rsget("itemname"))
				FItemList(i).FImageList		= "http://webimage.10x10.co.kr/image/list/" + GetImageSubFolderByItemid(rsget("itemid")) + "/" + rsget("listimage")
				FItemList(i).FImageList120	= "http://webimage.10x10.co.kr/image/list120/" + GetImageSubFolderByItemid(rsget("itemid")) + "/" + rsget("listimage120")
				FItemList(i).FIcon1Image  = "http://webimage.10x10.co.kr/image/icon1/" + GetImageSubFolderByItemid(rsget("itemid")) + "/" + rsget("icon1image")
				FItemList(i).FBrandName		= db2html(rsget("brandname"))
				FItemList(i).FMakerID		= db2html(rsget("makerid"))
				FItemList(i).Fitemdiv		= rsget("itemdiv")

				FItemList(i).FSellCash 		= rsget("sellcash")
				FItemList(i).FOrgPrice 		= rsget("orgprice")
				FItemList(i).FSellyn 		= rsget("sellyn")
				FItemList(i).FSaleyn 		= rsget("sailyn")
				FItemList(i).FLimityn 		= rsget("limityn")
				FItemList(i).FLimitNo      = rsget("limitno")
				FItemList(i).FLimitSold    = rsget("limitsold")
				FItemList(i).FItemcouponyn 	= rsget("itemcouponyn")
				FItemList(i).FItemCouponValue 	= rsget("itemCouponValue")
				FItemList(i).FItemCouponType 	= rsget("itemCouponType")
				FItemList(i).FEvalCnt 	= rsget("evalcnt")
				FItemList(i).FfavCount 	= rsget("favcount")
                FItemList(i).FOptionCnt = rsget("optioncnt")

                pItemArr = pItemArr + CStr(FItemList(i).FItemID) + ","
				i=i+1
				rsget.moveNext
			loop
		end if

		rsget.Close

		''결과 값이 MaxTopN개 미만인경우 중복 안되게 MaxTopN개 채움
		if (FResultCount<MaxTopN) Then

	   		If FRectDisp = "" OR FRectDisp = "0" Then
    			FRectDisp = "100"
    		End If

			sqlStr2 = "exec db_const.dbo.sp_Ten_awardItemList_2013 "&MaxTopN&",'b','','', 0"
            '커서 위치 지정
'    		rsget.CursorLocation = adUseClient
'    		rsget.CursorType = adOpenStatic
'    		rsget.LockType = adLockOptimistic
			set rsMem = getDBCacheSQL(dbget,rsget,"HappyTogetherShoppingBagBest",sqlStr2,60*1)



    		if  not rsMem.EOF  then
    			do until rsMem.eof
                    if (InStr(pItemArr,CStr(rsMem("itemid")) & "," )>0) then
                        ''이미 표시된 상품인경우 skip
                    else
                        if (FResultCount>=MaxTopN) then Exit do
                        FResultCount = FResultCount + 1
                        redim preserve FItemList(FResultCount)
        				set FItemList(i) = new CCategoryPrdItem

        				FItemList(i).FItemID		= rsMem("itemid")
        				FItemList(i).FItemName		= db2html(rsMem("itemname"))
        				FItemList(i).FImageList		= "http://webimage.10x10.co.kr/image/list/" + GetImageSubFolderByItemid(rsMem("itemid")) + "/" + rsMem("listimage")
        				FItemList(i).FImageList120	= "http://webimage.10x10.co.kr/image/list120/" + GetImageSubFolderByItemid(rsMem("itemid")) + "/" + rsMem("listimage120")
						FItemList(i).FIcon1Image  = "http://webimage.10x10.co.kr/image/icon1/" + GetImageSubFolderByItemid(rsMem("itemid")) + "/" + rsMem("icon1image")
        				FItemList(i).FBrandName		= db2html(rsMem("brandname"))
        				FItemList(i).FMakerID		= db2html(rsMem("makerid"))
        				FItemList(i).FEvalCnt		= rsMem("evalcnt")
						FItemList(i).FSellCash 		= rsMem("sellcash")
						FItemList(i).FOrgPrice 		= rsMem("orgprice")
						FItemList(i).FSellyn 		= rsMem("sellyn")
						FItemList(i).FSaleyn 		= rsMem("sailyn")
						FItemList(i).FLimityn 		= rsMem("limityn")
						FItemList(i).FLimitNo      = rsMem("limitno")
						FItemList(i).FLimitSold    = rsMem("limitsold")
						FItemList(i).FItemcouponyn 	= rsMem("itemcouponyn")
						FItemList(i).FItemCouponValue 	= rsMem("itemCouponValue")
						FItemList(i).FItemCouponType 	= rsMem("itemCouponType")

        				i=i+1
    				end if
    				rsMem.moveNext
    			loop
    		end if

    		rsMem.Close

		end if

    end Sub

	'// 해피투게더 테스트버전(동시에 구매한 상품), skyer9, 2017-06-02
	Public sub GetHappySameTimeItemList()
		Dim i, strSql
		const MaxTopN = 5

		'// 추천상품 목록접수
		strSql = "Select top " & MaxTopN & " i.itemid, i.itemname, i.listimage, i.listimage120, i.icon1image,  "
		strSql = strSql & "	(Case When isNull(i.frontMakerid,'')='' then i.makerid else i.frontMakerid end) as makerid, "
		strSql = strSql & "	i.brandname, i.specialuseritem, i.itemdiv, i.evalcnt, ic.favcount, "
		strSql = strSql & "	isNull(i.sellcash,0) as sellcash, isNull(i.orgprice,0) as orgprice, "
		strSql = strSql & "	isNull(i.sellyn,'') as sellyn, isNull(i.sailyn,'') as sailyn, isNull(i.limityn,'') as limityn, "
		strSql = strSql & "	isNull(i.itemcouponyn,'') as itemcouponyn, isNull(i.itemCouponValue,'') as itemCouponValue, "
		strSql = strSql & "	isNull(i.itemCouponType,'') as itemCouponType,  i.limitno, i.limitsold, i.optioncnt "
		strSql = strSql & "from "
		strSql = strSql & "	( "
		''strSql = strSql & "		select " & FRectItemId & " as itemidB, 0 as rnk "
		''strSql = strSql & "		union "
		strSql = strSql & "		select top 5 itemidB, rnk from [db_temp].[dbo].[tbl_item_item_view_together_TEST] where itemidA = " & FRectItemId & " and cnt >= 1 order by rnk "
		strSql = strSql & "	) s "
		strSql = strSql & "	join [db_item].[dbo].tbl_item i "
		strSql = strSql & "	on "
		strSql = strSql & "		s.itemidB = i.itemid "
		strSql = strSql & "	Join [db_item].[dbo].tbl_item_Contents ic  "
		strSql = strSql & "	on i.itemid=ic.itemid "
		strSql = strSql & "where 1 = 1 "
		strSql = strSql & "	and i.sellyn='Y' "
		strSql = strSql & "order by s.rnk "
		''response.Write strSql
		rsget.Open strSql, dbget, 1

		FResultCount = rsget.RecordCount
		redim preserve FItemList(FResultCount)

		i=0
		if  not rsget.EOF  then
			do until rsget.eof
				set FItemList(i) = new CCategoryPrdItem

				FItemList(i).FItemID		= rsget("itemid")
				FItemList(i).FItemName		= db2html(rsget("itemname"))
				FItemList(i).FImageList		= "http://webimage.10x10.co.kr/image/list/" + GetImageSubFolderByItemid(rsget("itemid")) + "/" + rsget("listimage")
				FItemList(i).FImageList120	= "http://webimage.10x10.co.kr/image/list120/" + GetImageSubFolderByItemid(rsget("itemid")) + "/" + rsget("listimage120")
				FItemList(i).FIcon1Image  = "http://webimage.10x10.co.kr/image/icon1/" + GetImageSubFolderByItemid(rsget("itemid")) + "/" + rsget("icon1image")
				FItemList(i).FBrandName		= db2html(rsget("brandname"))
				FItemList(i).FMakerID		= db2html(rsget("makerid"))
				FItemList(i).Fitemdiv		= rsget("itemdiv")

				FItemList(i).FSellCash 		= rsget("sellcash")
				FItemList(i).FOrgPrice 		= rsget("orgprice")
				FItemList(i).FSellyn 		= rsget("sellyn")
				FItemList(i).FSaleyn 		= rsget("sailyn")
				FItemList(i).FLimityn 		= rsget("limityn")
				FItemList(i).FLimitNo      = rsget("limitno")
				FItemList(i).FLimitSold    = rsget("limitsold")
				FItemList(i).FItemcouponyn 	= rsget("itemcouponyn")
				FItemList(i).FItemCouponValue 	= rsget("itemCouponValue")
				FItemList(i).FItemCouponType 	= rsget("itemCouponType")
				FItemList(i).FEvalCnt 	= rsget("evalcnt")
				FItemList(i).FfavCount 	= rsget("favcount")
                FItemList(i).FOptionCnt = rsget("optioncnt")

				i=i+1
				rsget.moveNext
			loop
		end if

		rsget.Close
	End Sub

	'// 해피투게더 신규(기존 best에서 채우던 방식 말고 순수 해피투게더 데이터만) 2017.06.08 원승현
	'// sp_Ten_happyTogether_List => sp_Ten_happyTogether_List_V2 2017.06.15 eastone
    Public sub GetCateRightHappyTogetherList()
        dim i, pItemArr, sqlStr, sqlStr2
		Dim rsMem
        const MaxTopN = 20

        if (FRectHappyTogetherType="v4") then  ''2018/05/31 nvshop 으로 들어올경우 같은 카테고리 상품만 제안.
            sqlStr = "exec db_sitemaster.dbo.sp_Ten_happyTogether_List_V4 '" & CStr(FRectItemId) & "'," & (MaxTopN)&",'nvshop'"
        else
		    sqlStr = "exec db_sitemaster.dbo.sp_Ten_happyTogether_List_V3 '" & CStr(FRectItemId) & "'," & (MaxTopN)
	    end if

        '커서 위치 지정
'		rsget.CursorLocation = adUseClient
'		rsget.CursorType = adOpenStatic
'		rsget.LockType = adLockOptimistic
		set rsMem = getDBCacheSQL(dbget,rsget,"HappyTogether",sqlStr,60*60)
		if (rsMem is Nothing) then Exit sub ''추가

		FResultCount = rsMem.RecordCount
		redim preserve FItemList(FResultCount)

		i=0
		pItemArr =""

		if  not rsMem.EOF  then
			do until rsMem.eof
				set FItemList(i) = new CCategoryPrdItem

				FItemList(i).FItemID		= rsMem("itemid")
				FItemList(i).FItemName		= db2html(rsMem("itemname"))
				FItemList(i).FImageList		= "http://webimage.10x10.co.kr/image/list/" + GetImageSubFolderByItemid(rsMem("itemid")) + "/" + rsMem("listimage")
				FItemList(i).FImageList120	= "http://webimage.10x10.co.kr/image/list120/" + GetImageSubFolderByItemid(rsMem("itemid")) + "/" + rsMem("listimage120")
				FItemList(i).FIcon1Image  = "http://webimage.10x10.co.kr/image/icon1/" + GetImageSubFolderByItemid(rsMem("itemid")) + "/" + rsMem("icon1image")
				FItemList(i).FBrandName		= db2html(rsMem("brandname"))
				FItemList(i).FMakerID		= db2html(rsMem("makerid"))
				FItemList(i).Fitemdiv		= rsMem("itemdiv")

				FItemList(i).FSellCash 		= rsMem("sellcash")
				FItemList(i).FOrgPrice 		= rsMem("orgprice")
				FItemList(i).FSellyn 		= rsMem("sellyn")
				FItemList(i).FSaleyn 		= rsMem("sailyn")
				FItemList(i).FLimityn 		= rsMem("limityn")
				FItemList(i).FLimitNo      = rsMem("limitno")
				FItemList(i).FLimitSold    = rsMem("limitsold")
				FItemList(i).FItemcouponyn 	= rsMem("itemcouponyn")
				FItemList(i).FItemCouponValue 	= rsMem("itemCouponValue")
				FItemList(i).FItemCouponType 	= rsMem("itemCouponType")
				FItemList(i).FEvalCnt 	= rsMem("evalcnt")
				FItemList(i).FfavCount 	= rsMem("favcount")
                FItemList(i).FOptionCnt = rsMem("optioncnt")

                pItemArr = pItemArr + CStr(FItemList(i).FItemID) + ","
				i=i+1
				rsMem.moveNext
			loop
		end if

		rsMem.Close
    end Sub


	'// 다른사람이 본 위시콜렉션 신규 2017.06.08 원승현
    Public sub GetTogetherWishCollection()
        dim i, pItemArr, sqlStr, sqlStr2
		Dim rsMem
        const MaxTopN = 10

		'# 새벽 리빌딩 시간동안은 결과 반환 안함 (2017.06.15; 원승현)
		''IF (formatdatetime(now(),4)>"02:50:00") and (formatdatetime(now(),4)<"05:00:00") then
		IF (formatdatetime(now(),4)>"03:40:00") and (formatdatetime(now(),4)<"04:00:01") then
			FResultCount = 0
			Exit Sub
		end If

		IF (formatdatetime(now(),4)>"03:00:00") and (formatdatetime(now(),4)<"03:15:01") then
			FResultCount = 0
			Exit Sub
		end If

		sqlStr = " Select top "&MaxTopN&" itemid, itemcount, itemname, listimage, listimage120, icon1image, brandname, makerid, itemdiv, sellcash, orgprice, sellyn, sailyn, limityn, limitno, "
		sqlStr = sqlStr & " 			limitsold, itemcouponyn, itemcouponvalue, itemcoupontype, evalcnt, favcount, optioncnt "
		sqlStr = sqlStr & " 		From "
		sqlStr = sqlStr & " 		( "
		sqlStr = sqlStr & " 			Select Fb.itemid, count(Fb.userid) as itemcount, i.itemname, i.listimage, i.listimage120, i.icon1image, i.brandname, i.makerid, i.itemdiv, i.sellcash, "
		sqlStr = sqlStr & " 				i.orgprice, i.sellyn, i.sailyn, i.limityn, i.limitno, i.limitsold, i.itemcouponyn, i.itemcouponvalue, i.itemcoupontype, i.evalcnt, i.favcount, i.optioncnt "
		sqlStr = sqlStr & " 			From "
		sqlStr = sqlStr & " 			( "
		sqlStr = sqlStr & " 				Select regdate, itemid, userid From [db_AppWish].[dbo].[tbl_myfavorite] Where itemid='"&CStr(FRectItemId)&"' "
		sqlStr = sqlStr & " 			) Fa "
		sqlStr = sqlStr & " 			inner join [db_AppWish].[dbo].[tbl_myfavorite] Fb on Fa.userid = Fb.userid "
		sqlStr = sqlStr & " 			inner join [db_AppWish].[dbo].[tbl_item] i on Fb.itemid = i.itemid and i.sellyn='Y'"
		sqlStr = sqlStr & " 			Where Fb.itemid <> '"&CStr(FRectItemId)&"' And Fb.regdate >= dateadd(yy, -1, getdate()) "
		sqlStr = sqlStr & " 			group by Fb.itemid, i.itemname, i.listimage, i.listimage120, i.icon1image, i.brandname, i.makerid, i.itemdiv, i.sellcash, "
		sqlStr = sqlStr & " 				i.orgprice, i.sellyn, i.sailyn, i.limityn, i.limitno, i.limitsold, i.itemcouponyn, i.itemcouponvalue, i.itemcoupontype, i.evalcnt, i.favcount, i.optioncnt "
		sqlStr = sqlStr & " 		)AA order by itemcount desc "

'		sqlStr = " Select top "&MaxTopN&" itemid, itemcount, itemname, listimage, listimage120, icon1image, brandname, makerid, itemdiv, sellcash, orgprice, sellyn, sailyn, limityn, limitno, "
'		sqlStr = sqlStr & " 			limitsold, itemcouponyn, itemcouponvalue, itemcoupontype, evalcnt, optioncnt "
'		sqlStr = sqlStr & " 		From "
'		sqlStr = sqlStr & " 		( "
'		sqlStr = sqlStr & " 			Select Fb.itemid, count(Fb.userid) as itemcount, i.itemname, i.listimage, i.listimage120, i.icon1image, i.brandname, i.makerid, i.itemdiv, i.sellcash, "
'		sqlStr = sqlStr & " 				i.orgprice, i.sellyn, i.sailyn, i.limityn, i.limitno, i.limitsold, i.itemcouponyn, i.itemcouponvalue, i.itemcoupontype, i.evalcnt, i.optioncnt "
'		sqlStr = sqlStr & " 			From "
'		sqlStr = sqlStr & " 			( "
'		sqlStr = sqlStr & " 				Select regdate, itemid, userid From [db_my10x10].[dbo].[tbl_myfavorite] Where itemid='"&CStr(FRectItemId)&"' "
'		sqlStr = sqlStr & " 			) Fa "
'		sqlStr = sqlStr & " 			inner join [db_my10x10].[dbo].[tbl_myfavorite] Fb on Fa.userid = Fb.userid "
'		sqlStr = sqlStr & " 			inner join [db_item].[dbo].[tbl_item] i on Fb.itemid = i.itemid and i.sellyn='Y'"
'		sqlStr = sqlStr & " 			Where Fb.itemid <> '"&CStr(FRectItemId)&"' And Fb.regdate >= dateadd(yy, -1, getdate()) "
'		sqlStr = sqlStr & " 			group by Fb.itemid, i.itemname, i.listimage, i.listimage120, i.icon1image, i.brandname, i.makerid, i.itemdiv, i.sellcash, "
'		sqlStr = sqlStr & " 				i.orgprice, i.sellyn, i.sailyn, i.limityn, i.limitno, i.limitsold, i.itemcouponyn, i.itemcouponvalue, i.itemcoupontype, i.evalcnt, i.optioncnt "
'		sqlStr = sqlStr & " 		)AA order by itemcount desc "

        '커서 위치 지정
'		rsget.CursorLocation = adUseClient
'		rsget.CursorType = adOpenStatic
'		rsget.LockType = adLockOptimistic
		'' set rsMem = getDBCacheSQL(dbget,rsget,"WishCollectionNewList",sqlStr,60*60)
		set rsMem = getDBCacheSQL(dbAppWishget,rsAppWishget,"WishCollectionNewList",sqlStr,60*60)
		if (rsMem is Nothing) then Exit sub ''추가

		FResultCount = rsMem.RecordCount
		redim preserve FItemList(FResultCount)

		i=0
		pItemArr =""

		if  not rsMem.EOF  then
			do until rsMem.eof
				set FItemList(i) = new CCategoryPrdItem

				FItemList(i).FItemID		= rsMem("itemid")
				FItemList(i).FItemName		= db2html(rsMem("itemname"))
				FItemList(i).FImageList		= "http://webimage.10x10.co.kr/image/list/" + GetImageSubFolderByItemid(rsMem("itemid")) + "/" + rsMem("listimage")
				FItemList(i).FImageList120	= "http://webimage.10x10.co.kr/image/list120/" + GetImageSubFolderByItemid(rsMem("itemid")) + "/" + rsMem("listimage120")
				FItemList(i).FIcon1Image  = "http://webimage.10x10.co.kr/image/icon1/" + GetImageSubFolderByItemid(rsMem("itemid")) + "/" + rsMem("icon1image")
				FItemList(i).FBrandName		= db2html(rsMem("brandname"))
				FItemList(i).FMakerID		= db2html(rsMem("makerid"))
				FItemList(i).Fitemdiv		= rsMem("itemdiv")

				FItemList(i).FSellCash 		= rsMem("sellcash")
				FItemList(i).FOrgPrice 		= rsMem("orgprice")
				FItemList(i).FSellyn 		= rsMem("sellyn")
				FItemList(i).FSaleyn 		= rsMem("sailyn")
				FItemList(i).FLimityn 		= rsMem("limityn")
				FItemList(i).FLimitNo      = rsMem("limitno")
				FItemList(i).FLimitSold    = rsMem("limitsold")
				FItemList(i).FItemcouponyn 	= rsMem("itemcouponyn")
				FItemList(i).FItemCouponValue 	= rsMem("itemCouponValue")
				FItemList(i).FItemCouponType 	= rsMem("itemCouponType")
				FItemList(i).FEvalCnt 	= rsMem("evalcnt")
				'FItemList(i).FfavCount 	= rsMem("favcount")
                FItemList(i).FOptionCnt = rsMem("optioncnt")

				i=i+1
				rsMem.moveNext
			loop
		end if

		rsMem.Close
    end Sub

    '// Recopick 추천상품 및 Category Best 목록 접수 //
    Public sub GetRecoPick_CateBestItemList()
        dim i, pItemArr, strSql, tmpFrectitemArr, tf, vcustomOrderBy, isCustomOrderBy
        const MaxTopN = 10

		tmpFrectitemArr = Split(FRectitemarr, ",")
		vcustomOrderBy = "order by case i.itemid "
		For tf = 0 To UBound(tmpFrectitemArr)
			vcustomOrderBy = vcustomOrderBy & " when "&tmpFrectitemArr(tf)&" then "&tf+1
		Next
		vcustomOrderBy = vCustomOrderBy & " else 11 end "

		'// 추천상품 목록접수
		strSql = "Select top " & MaxTopN & " i.itemid, i.itemname, i.listimage, i.listimage120, i.icon1image,  "
		strSql = strSql & "	(Case When isNull(i.frontMakerid,'')='' then i.makerid else i.frontMakerid end) as makerid, "
		strSql = strSql & "	i.brandname, i.specialuseritem, i.itemdiv, i.evalcnt, ic.favcount, "
		strSql = strSql & "	isNull(i.sellcash,0) as sellcash, isNull(i.orgprice,0) as orgprice, "
		strSql = strSql & "	isNull(i.sellyn,'') as sellyn, isNull(i.sailyn,'') as sailyn, isNull(i.limityn,'') as limityn, "
		strSql = strSql & "	isNull(i.itemcouponyn,'') as itemcouponyn, isNull(i.itemCouponValue,'') as itemCouponValue, "
		strSql = strSql & "	isNull(i.itemCouponType,'') as itemCouponType,  i.limitno, i.limitsold, i.optioncnt "
		strSql = strSql & "from  [db_item].[dbo].tbl_item i "
		strSql = strSql & "	Join [db_item].[dbo].tbl_item_Contents ic  "
		strSql = strSql & "	on i.itemid=ic.itemid "
		strSql = strSql & "where i.itemid in (" & FRectitemarr & ") "
		strSql = strSql & "	and i.sellyn='Y' "
		If FRectItemId <> "" Then
			strSql = strSql & "	and i.itemid<>" & FRectItemId & " "
		End If
'		strSql = strSql & "order by i.itemscore desc"
		strSql = strSql & vcustomOrderBy
		rsget.Open strSql, dbget, 1

		FResultCount = rsget.RecordCount
		redim preserve FItemList(FResultCount)

		i=0
		pItemArr =""

		if  not rsget.EOF  then
			do until rsget.eof
				set FItemList(i) = new CCategoryPrdItem

				FItemList(i).FItemID		= rsget("itemid")
				FItemList(i).FItemName		= db2html(rsget("itemname"))
				FItemList(i).FImageList		= "http://webimage.10x10.co.kr/image/list/" + GetImageSubFolderByItemid(rsget("itemid")) + "/" + rsget("listimage")
				FItemList(i).FImageList120	= "http://webimage.10x10.co.kr/image/list120/" + GetImageSubFolderByItemid(rsget("itemid")) + "/" + rsget("listimage120")
				FItemList(i).FIcon1Image  = "http://webimage.10x10.co.kr/image/icon1/" + GetImageSubFolderByItemid(rsget("itemid")) + "/" + rsget("icon1image")
				FItemList(i).FBrandName		= db2html(rsget("brandname"))
				FItemList(i).FMakerID		= db2html(rsget("makerid"))
				FItemList(i).Fitemdiv		= rsget("itemdiv")

				FItemList(i).FSellCash 		= rsget("sellcash")
				FItemList(i).FOrgPrice 		= rsget("orgprice")
				FItemList(i).FSellyn 		= rsget("sellyn")
				FItemList(i).FSaleyn 		= rsget("sailyn")
				FItemList(i).FLimityn 		= rsget("limityn")
				FItemList(i).FLimitNo      = rsget("limitno")
				FItemList(i).FLimitSold    = rsget("limitsold")
				FItemList(i).FItemcouponyn 	= rsget("itemcouponyn")
				FItemList(i).FItemCouponValue 	= rsget("itemCouponValue")
				FItemList(i).FItemCouponType 	= rsget("itemCouponType")
				FItemList(i).FEvalCnt 	= rsget("evalcnt")
				FItemList(i).FfavCount 	= rsget("favcount")
                FItemList(i).FOptionCnt = rsget("optioncnt")
				FItemList(i).FUseETC	= "R"		'레코픽 추천

                pItemArr = pItemArr + CStr(FItemList(i).FItemID) + ","
				i=i+1
				rsget.moveNext
			loop
		end if

		rsget.Close

		''결과 값이 MaxTopN개 미만인경우 중복 안되게 MaxTopN개 채움
		if (FResultCount<MaxTopN) then
			'//전시카테고리 베스트

	        '커서 위치 지정
			rsget.CursorLocation = adUseClient
			rsget.CursorType = adOpenStatic
			rsget.LockType = adLockOptimistic

			If FRectDisp = "" OR FRectDisp = "0" Then
				FRectDisp = "100"
			End If



			'저장프로시저 실행
			rsget.Open "exec db_sitemaster.dbo.[sp_Ten_dispcateBestChoice_List] '" & FRectDisp & "','" & (Len(FRectDisp)/3) & "','" & CStr(FRectItemId) & "'," & MaxTopN , dbget

			if  not rsget.EOF  then
				do until rsget.eof
	                if (InStr(pItemArr,CStr(rsget("itemid")) & "," )>0) then
	                    ''이미 표시된 상품인경우 skip
	                else
	                    if (FResultCount>=MaxTopN) then Exit do
	                    FResultCount = FResultCount + 1
	                    redim preserve FItemList(FResultCount)
	    				set FItemList(i) = new CCategoryPrdItem

	    				FItemList(i).FItemID		= rsget("itemid")
	    				FItemList(i).FItemName		= db2html(rsget("itemname"))
	    				FItemList(i).FImageList		= "http://webimage.10x10.co.kr/image/list/" + GetImageSubFolderByItemid(rsget("itemid")) + "/" + rsget("listimage")
	    				FItemList(i).FImageList120	= "http://webimage.10x10.co.kr/image/list120/" + GetImageSubFolderByItemid(rsget("itemid")) + "/" + rsget("listimage120")
						FItemList(i).FIcon1Image  = "http://webimage.10x10.co.kr/image/icon1/" + GetImageSubFolderByItemid(rsget("itemid")) + "/" + rsget("icon1image")
	    				FItemList(i).FBrandName		= db2html(rsget("brandname"))
	    				FItemList(i).FMakerID		= db2html(rsget("makerid"))
	    				FItemList(i).Fitemdiv		= rsget("itemdiv")
	    				FItemList(i).FEvalCnt		= rsget("evalcnt")
						FItemList(i).FSellCash 		= rsget("sellcash")
						FItemList(i).FOrgPrice 		= rsget("orgprice")
						FItemList(i).FSellyn 		= rsget("sellyn")
						FItemList(i).FSaleyn 		= rsget("sailyn")
						FItemList(i).FLimityn 		= rsget("limityn")
						FItemList(i).FLimitNo      = rsget("limitno")
						FItemList(i).FLimitSold    = rsget("limitsold")
						FItemList(i).FItemcouponyn 	= rsget("itemcouponyn")
						FItemList(i).FItemCouponValue 	= rsget("itemCouponValue")
						FItemList(i).FItemCouponType 	= rsget("itemCouponType")
		                FItemList(i).FOptionCnt = rsget("optioncnt")
						FItemList(i).FUseETC	= "T"		'텐바이텐 베스트

	    				i=i+1
					end if
					rsget.moveNext
				loop
			end if
    		rsget.Close
		end if
    end Sub

    
    '// 원클릭 업셀 관련
    Public sub GetOneClickUpSellItemList()
        dim i, pItemArr, sqlStr, sqlStr2
        const MaxTopN = 10

		If FRectTenBaeChk Then
			FRectTenBaeChk = "true"
		Else
			FRectTenBaeChk = "false"
		End If
		sqlStr = "exec db_sitemaster.dbo.[sp_Ten_oneClickUpSellList] '" & MaxTopN & "','" & FRectUserId & "','" & FRectDisp &"','" & FRectDelLimitCost & "', '"&FRectMakerID&"', '"&FRectTenBaeChk&"'"

		rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenForwardOnly
		rsget.LockType = adLockReadOnly
		rsget.Open sqlStr, dbget

		FResultCount = rsget.RecordCount
		Redim preserve FItemList(FResultCount)

		i = 0
		if  not rsget.EOF  Then
			Do until rsget.EOF
				Set FItemList(i) = new CCategoryPrdItem

				FItemList(i).FItemID		= rsget("itemid")
				FItemList(i).FItemName		= db2html(rsget("itemname"))
				FItemList(i).FImageList		= "http://webimage.10x10.co.kr/image/list/" + GetImageSubFolderByItemid(rsget("itemid")) + "/" + rsget("listimage")
				FItemList(i).FImageList120	= "http://webimage.10x10.co.kr/image/list120/" + GetImageSubFolderByItemid(rsget("itemid")) + "/" + rsget("listimage120")
				FItemList(i).FIcon1Image  = "http://webimage.10x10.co.kr/image/icon1/" + GetImageSubFolderByItemid(rsget("itemid")) + "/" + rsget("icon1image")
				FItemList(i).FBrandName		= db2html(rsget("brandname"))
				FItemList(i).FMakerID		= db2html(rsget("makerid"))
				FItemList(i).Fitemdiv		= rsget("itemdiv")

				FItemList(i).FSellCash 		= rsget("sellcash")
				FItemList(i).FOrgPrice 		= rsget("orgprice")
				FItemList(i).FSellyn 		= rsget("sellyn")
				FItemList(i).FSaleyn 		= rsget("sailyn")
				FItemList(i).FLimityn 		= rsget("limityn")
				FItemList(i).FLimitNo      = rsget("limitno")
				FItemList(i).FLimitSold    = rsget("limitsold")
				FItemList(i).FItemcouponyn 	= rsget("itemcouponyn")
				FItemList(i).FItemCouponValue 	= rsget("itemCouponValue")
				FItemList(i).FItemCouponType 	= rsget("itemCouponType")
				FItemList(i).FEvalCnt 	= rsget("evalcnt")
				'FItemList(i).FfavCount 	= rsget("favcount")
                FItemList(i).FOptionCnt = rsget("optioncnt")
				rsget.movenext
				i=i+1
			Loop
		end if
		rsget.close
    end Sub
    
    
    Public function GetDownCateList()
    dim i, sql
    	sql = "EXEC [db_item].[dbo].[sp_Ten_Display_DownCateList] '" & FRectDisp & "'"
		rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
		rsget.Open sql, dbget
		If Not rsget.Eof Then
			GetDownCateList = rsget.GetRows()
		End If
		rsget.Close()
    end function


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



'#=========================================#
'# 상품 페이지 & 상품 리스트  추가 함수    #
'#=========================================#

'// 카테고리 코드 > 이름으로 변환
Function getCategoryNameDB(cd1,cd2,cd3)
	Dim SQL

	'유효성 검사
	if cd1="" then
		Exit Function
	end if

	''SQL =	"exec [db_item].[dbo].sp_Ten_category_name '" & cd1 & "', '" & cd2 & "', '" & cd3 & "'"
	SQL =	"exec [db_item].[dbo].sp_Ten_category_name_2013 '" & cd1 & "', '" & cd2 & "', '" & cd3 & "'"
	rsget.CursorLocation = adUseClient
	rsget.CursorType = adOpenStatic
	rsget.LockType = adLockOptimistic
	rsget.Open SQL, dbget
		if NOT(rsget.EOF or rsget.BOF) then
			getCategoryNameDB = db2html(rsget(0))
		end if
	rsget.Close
End Function

'// 카테고리 관련 링크 테이블 출력
Sub printCategoryRelateLink(cd1,cd2,cd3)
	Dim SQL, strTemp

	'유효성 검사
	if cd1="" or cd2="" then
		Exit Sub
	end if

	SQL =	"exec [db_item].[dbo].sp_Ten_category_RelateLink '" & cd1 & "', '" & cd2 & "', '" & cd3 & "'"
	rsget.CursorLocation = adUseClient
	rsget.CursorType = adOpenStatic
	rsget.LockType = adLockOptimistic
	rsget.Open SQL, dbget
		if NOT(rsget.EOF or rsget.BOF) then
			'테이블 시작
			strTemp = "<table border='0' cellspacing='0' cellpadding='0'>" &_
					"<tr>" &_
					"	<td style='padding-right:7px;'><img src='http://fiximage.10x10.co.kr/web2008/category/check_title.gif' width='103' height='16'></td>" &_
					"	<td class='gray11px02' style='padding-top:3px;'>"
			'내용 출력
			Do Until rsget.EOF
				strTemp = strTemp & "		<a href='" & rsget(1) & "' class='link_gray11px01'>" & rsget(0) & "</a>"
			rsget.MoveNext
				if NOt(rsget.EOF) then strTemp = strTemp & "<span class='wordspace01'> | </span>"
			loop
			'테이블 끝
			strTemp = strTemp & "	</td>" &_
					"</tr>" &_
					"</table>"
		end if
	rsget.Close

	Response.Write strTemp
End Sub

'// 카테고리 Histoty 출력
Sub printCategoryHistory(code)
	dim strHistory, strLink, SQL, i, j
	j = (len(code)/3)

	'히스토리 기본
	strHistory = "<a href='/'>HOME</a>"

	'// 카테고리 이름 접수
	SQL = "SELECT ([db_item].[dbo].[getCateCodeFullDepthName]('" & code & "'))"
	rsget.Open SQL, dbget, 1

	if NOT(rsget.EOF or rsget.BOF) then
		If Not(isNull(rsget(0))) Then
			for i = 1 to j
				strHistory = strHistory & "&nbsp;&gt;&nbsp;<a href=""/shopping/category_list.asp?disp="&Left(code,(3*i))&""">"
				if i = j then
					strHistory = strHistory & "<strong>" & Split(db2html(rsget(0)),"^^")(i-1) & "</strong>"
				else
					strHistory = strHistory & Split(db2html(rsget(0)),"^^")(i-1)
				end if
				strHistory = strHistory & "</a>"
			next
		End If
	end if

	rsget.Close

	Response.Write strHistory
end Sub

''캐시
Sub printCategoryHistory_B(byRef code)
	dim strHistory, strLink, SQL, i, j
	j = (len(code)/3)

	'히스토리 기본
	strHistory = ""

	'// 카테고리 이름 접수
	SQL = "SELECT ([db_item].[dbo].[getCateCodeFullDepthNameUse]('" & code & "'))"
	''rsget.Open SQL, dbget, 1
	Dim rsMem : set rsMem = getDBCacheSQL(dbget,rsget,"CATEH",SQL,60*60)
	if (rsMem is Nothing) then ''추가
		code=0
		Exit Sub
	end if
	if NOT(rsMem.EOF or rsMem.BOF) then
		If Not(isNull(rsMem(0))) Then
			for i = 1 to j
				strHistory = strHistory & "&nbsp;&gt;&nbsp;<a href=""/shopping/category_list.asp?disp="&Left(code,(3*i))&""">"
				if i = j then
					strHistory = strHistory & "<strong>" & Split(db2html(rsMem(0)),"^^")(i-1) & "</strong>"
				else
					strHistory = strHistory & Split(db2html(rsMem(0)),"^^")(i-1)
				end if
				strHistory = strHistory & "</a>"
			next
		End If
	end if

	rsMem.Close

	if trim(strHistory)<>"" then
		Response.Write "<a href='/'>HOME</a>" & strHistory
	else
		code=0
	end if
end Sub

function GetCategoryListAll_B(code)
	dim SQL

	GetCategoryListAll_B = ""

	'// 카테고리 이름
	SQL = "SELECT ([db_item].[dbo].[getCateCodeFullDepthName]('" & code & "'))"
	Dim rsMem : set rsMem = getDBCacheSQL(dbget,rsget,"CATEH",SQL,60*60)
	if (rsMem is Nothing) then Exit function ''추가
	if NOT(rsMem.EOF or rsMem.BOF) then
		If Not(isNull(rsMem(0))) Then
			GetCategoryListAll_B = Replace(db2html(rsMem(0)), "^^", ", ")
		End If
	end if
	rsMem.Close
end function

function GetCategoryUseYN(disp)
	dim query1

	GetCategoryUseYN = "Y"

	query1 = " select IsNull(useyn, 'N') as useyn from [db_item].[dbo].tbl_display_cate "
	query1 = query1 & " where catecode = '" & disp & "' "

	dim rsMem : set rsMem = getDBCacheSQL(dbget,rsget,"CTDP",query1,60*5)
	if (rsMem is Nothing) then Exit Function ''추가
	'response.write query1 & "!!" & disp
	IF Not (rsMem.EOF OR rsMem.BOF) THEN
		GetCategoryUseYN = Cstr(rsMem("useyn"))
	END IF
	rsMem.close
end function

'// 쿠폰의 숫자를 이미지로 출력 (2010.03.27; 허진원 생성)
Sub printCouponNumberImg(cpnNo)
	Dim lp, tmpNo, strRst, strDiv

	if instr(cpnNo,"원")>0 then
		'원할인 쿠폰
		cpnNo = replace(cpnNo,"원 할인","")
		strDiv = "<img src='http://fiximage.10x10.co.kr/web2013/common/cp_num_won.png' alt='원' />"
	else
		'%할인 쿠폰
		cpnNo = replace(cpnNo,"%","")
		strDiv = "<img src='http://fiximage.10x10.co.kr/web2013/common/cp_num_per.png' alt='%' />"
	end if

	For lp=1 to len(cpnNo)
		tmpNo = mid(cpnNo, lp, 1)
		if tmpNo="," then
			tmpNo="_comma"	'자릿수 콤마를 url값으로 변경
		else
			tmpNo="0" & tmpNo '숫자
		end if
		strRst = strRst & "<img src='http://fiximage.10x10.co.kr/web2013/common/cp_num" & tmpNo & ".png' alt='" & tmpNo & "' />"
	Next

	Response.Write strRst & strDiv
end Sub


Function CategoryNameUseLeftMenuDB(code)
	Dim vName, vQuery
	vQuery = "select db_item.dbo.getDisplayCateName('"&code&"')"
	'rsget.Open vQuery, dbget, 1
	Dim rsMem : set rsMem = getDBCacheSQL(dbget,rsget,"CATEL",vQuery,60*60)
	if (rsMem is Nothing) then Exit Function ''추가
	if NOT(rsMem.EOF or rsMem.BOF) Then
		vName = rsMem(0)
	End IF
	rsMem.close

	CategoryNameUseLeftMenuDB = vName
End Function

Function CategoryKeywordsDB(code)
	Dim vKeywords, vQuery
	vQuery = "select db_item.dbo.getDisplayCateKeywords('"&code&"')"
	Dim rsMem : set rsMem = getDBCacheSQL(dbget,rsget,"CATEL",vQuery,60*60)
	if (rsMem is Nothing) then Exit Function
	if NOT(rsMem.EOF or rsMem.BOF) Then
		vKeywords = rsMem(0)
	End IF
	rsMem.close

	CategoryKeywordsDB = vKeywords
End Function


Function fnGetDispcateArray()
	fnGetDispcateArray = Array("101","102","103","104","124","121","122","120","112","119","117","116","125","118","115","110")
End Function


Function CategoryNameUseLeftMenu(code)
	Dim vName
	SELECT Case code
		Case "101" : vName = "디자인문구"
		Case "102" : vName = "디지털/핸드폰"
		Case "103" : vName = "캠핑/트래블"
		Case "104" : vName = "토이"
		Case "114" : vName = "가구"
		Case "106" : vName = "홈인테리어"
		Case "112" : vName = "키친"
		Case "119" : vName = "푸드"
		Case "117" : vName = "패션의류"
		Case "116" : vName = "패션잡화"
		Case "118" : vName = "뷰티"
		Case "115" : vName = "베이비"
		Case "110" : vName = "Cat&Dog"
		Case "121" : vName = "가구/수납"
		Case "122" : vName = "데코/조명"
		Case "120" : vName = "패브릭/생활"
		Case "124" : vName = "디자인가전"
		Case "125" : vName = "주얼리/시계"
	End SELECT
	CategoryNameUseLeftMenu = vName
End Function


Function CategorySelectBoxOption(code)
	Dim vBody
	vBody = "<option value="""">전체 카테고리</option>"
	vBody = vBody & "<option value=""101"" " & CHKIIF(code="101","selected","") & ">디자인문구</option>"
	vBody = vBody & "<option value=""102"" " & CHKIIF(code="102","selected","") & ">디지털/핸드폰</option>"
	vBody = vBody & "<option value=""103"" " & CHKIIF(code="103","selected","") & ">캠핑/트래블</option>"
	vBody = vBody & "<option value=""104"" " & CHKIIF(code="104","selected","") & ">토이</option>"
	vBody = vBody & "<option value=""124"" " & CHKIIF(code="124","selected","") & ">디자인가전</option>"
	vBody = vBody & "<option value=""121"" " & CHKIIF(code="121","selected","") & ">가구/수납</option>"
	vBody = vBody & "<option value=""122"" " & CHKIIF(code="122","selected","") & ">데코/조명</option>"
	vBody = vBody & "<option value=""120"" " & CHKIIF(code="120","selected","") & ">패브릭/생활</option>"
	vBody = vBody & "<option value=""112"" " & CHKIIF(code="112","selected","") & ">키친</option>"
	vBody = vBody & "<option value=""119"" " & CHKIIF(code="119","selected","") & ">푸드</option>"
	vBody = vBody & "<option value=""117"" " & CHKIIF(code="117","selected","") & ">패션의류</option>"
	vBody = vBody & "<option value=""116"" " & CHKIIF(code="116","selected","") & ">패션잡화</option>"
	vBody = vBody & "<option value=""125"" " & CHKIIF(code="125","selected","") & ">주얼리/시계</option>"
	vBody = vBody & "<option value=""118"" " & CHKIIF(code="118","selected","") & ">뷰티</option>"
	vBody = vBody & "<option value=""115"" " & CHKIIF(code="115","selected","") & ">베이비/키즈</option>"
	vBody = vBody & "<option value=""110"" " & CHKIIF(code="110","selected","") & ">Cat&Dog</option>"

	CategorySelectBoxOption = vBody
End Function


Function fnAwardBestCategoryLI(code,url)
	Dim vBody
	vBody = ""
	vBody = vBody & "<li><a href=""" & url & "disp=101"" class=""" & chkIIF(code="101","on","") & """>디자인문구</a></li>" & vbCrLf
	vBody = vBody & "<li><a href=""" & url & "disp=102"" class=""" & chkIIF(code="102","on","") & """>디지털/핸드폰</a></li>" & vbCrLf
	vBody = vBody & "<li><a href=""" & url & "disp=103"" class=""" & chkIIF(code="103","on","") & """>캠핑/트래블</a></li>" & vbCrLf
	vBody = vBody & "<li><a href=""" & url & "disp=104"" class=""" & chkIIF(code="104","on","") & """>토이</a></li>" & vbCrLf
	vBody = vBody & "<li><a href=""" & url & "disp=124"" class=""" & chkIIF(code="124","on","") & """>디자인가전</a></li>" & vbCrLf
	vBody = vBody & "<li><a href=""" & url & "disp=121"" class=""" & chkIIF(code="121","on","") & """>가구/수납</a></li>" & vbCrLf
	vBody = vBody & "<li><a href=""" & url & "disp=122"" class=""" & chkIIF(code="122","on","") & """>데코/조명</a></li>" & vbCrLf
	vBody = vBody & "<li><a href=""" & url & "disp=120"" class=""" & chkIIF(code="120","on","") & """>패브릭/생활</a></li>" & vbCrLf
	vBody = vBody & "<li><a href=""" & url & "disp=112"" class=""" & chkIIF(code="112","on","") & """>키친</a></li>" & vbCrLf
	vBody = vBody & "<li><a href=""" & url & "disp=119"" class=""" & chkIIF(code="119","on","") & """>푸드</a></li>" & vbCrLf
	vBody = vBody & "<li><a href=""" & url & "disp=117"" class=""" & chkIIF(code="117","on","") & """>패션의류</a></li>" & vbCrLf
	vBody = vBody & "<li><a href=""" & url & "disp=116"" class=""" & chkIIF(code="116","on","") & """>패션잡화</a></li>" & vbCrLf
	vBody = vBody & "<li><a href=""" & url & "disp=125"" class=""" & chkIIF(code="125","on","") & """>주얼리/시계</a></li>" & vbCrLf
	vBody = vBody & "<li><a href=""" & url & "disp=118"" class=""" & chkIIF(code="118","on","") & """>뷰티</a></li>" & vbCrLf
	vBody = vBody & "<li><a href=""" & url & "disp=115"" class=""" & chkIIF(code="115","on","") & """>베이비/키즈</a></li>" & vbCrLf
	vBody = vBody & "<li><a href=""" & url & "disp=110"" class=""" & chkIIF(code="110","on","") & """>Cat&amp;Dog</a></li>" & vbCrLf

	fnAwardBestCategoryLi = vBody
End Function


Function fnAwardBestCategoryHeaderSSL()
	Dim vBody
	vBody = ""
	vBody = vBody & "<li><p onClick=""location.href='"&wwwUrl&"/shopping/category_main.asp?disp=101';"">디자인문구</p></li>" & vbCrLf
	vBody = vBody & "<li><p onClick=""location.href='"&wwwUrl&"/shopping/category_main.asp?disp=102';"">디지털/핸드폰</p></li>" & vbCrLf
	vBody = vBody & "<li><p onClick=""location.href='"&wwwUrl&"/shopping/category_main.asp?disp=103';"">캠핑/트래블</p></li>" & vbCrLf
	vBody = vBody & "<li><p onClick=""location.href='"&wwwUrl&"/shopping/category_main.asp?disp=104';"">토이</p></li>" & vbCrLf
	vBody = vBody & "<li><p onClick=""location.href='"&wwwUrl&"/shopping/category_main.asp?disp=124';"">디자인가전</p></li>" & vbCrLf
	vBody = vBody & "<li><p onClick=""location.href='"&wwwUrl&"/shopping/category_main.asp?disp=121';"">가구/수납</p></li>" & vbCrLf
	vBody = vBody & "<li><p onClick=""location.href='"&wwwUrl&"/shopping/category_main.asp?disp=122';"">데코/조명</p></li>" & vbCrLf
	vBody = vBody & "<li><p onClick=""location.href='"&wwwUrl&"/shopping/category_main.asp?disp=120';"">패브릭/생활</p></li>" & vbCrLf
	vBody = vBody & "<li><p onClick=""location.href='"&wwwUrl&"/shopping/category_main.asp?disp=112';"">키친</p></li>" & vbCrLf
	vBody = vBody & "<li><p onClick=""location.href='"&wwwUrl&"/shopping/category_main.asp?disp=119';"">푸드</p></li>" & vbCrLf
	vBody = vBody & "<li><p onClick=""location.href='"&wwwUrl&"/shopping/category_main.asp?disp=117';"">패션의류</p></li>" & vbCrLf
	vBody = vBody & "<li><p onClick=""location.href='"&wwwUrl&"/shopping/category_main.asp?disp=116';"">패션잡화</p></li>" & vbCrLf
	vBody = vBody & "<li><p onClick=""location.href='"&wwwUrl&"/shopping/category_main.asp?disp=125';"">주얼리/시계</p></li>" & vbCrLf
	vBody = vBody & "<li><p onClick=""location.href='"&wwwUrl&"/shopping/category_main.asp?disp=118';"">뷰티</p></li>" & vbCrLf
	vBody = vBody & "<li><p onClick=""location.href='"&wwwUrl&"/shopping/category_main.asp?disp=115';"">베이비/키즈</p></li>" & vbCrLf
	vBody = vBody & "<li><p onClick=""location.href='"&wwwUrl&"/shopping/category_main.asp?disp=110';"">Cat&amp;Dog</p></li>" & vbCrLf

	fnAwardBestCategoryHeaderSSL = vBody
End Function


Function fnBrandStreetCategoryHeaderAct(code,jsname,charcd,Lang,scTxt)
	Dim vBody, vPage
	If jsname = "SearchModrecmd" Then
		vPage = ", ''"
	End If
	vBody = ""
	vBody = vBody & "<li style=""cursor:pointer;"" " & chkiif(code="101","class='current'","") & " onclick="""&jsname&"('"&charcd&"', '"&Lang&"', '101', '', '"&scTxt&"'"&vPage&");"">디자인문구</li>" & vbCrLf
	vBody = vBody & "<li style=""cursor:pointer;"" " & chkiif(code="102","class='current'","") & " onclick="""&jsname&"('"&charcd&"', '"&Lang&"', '102', '', '"&scTxt&"'"&vPage&");"">디지털/핸드폰</li>" & vbCrLf
	vBody = vBody & "<li style=""cursor:pointer;"" " & chkiif(code="103","class='current'","") & " onclick="""&jsname&"('"&charcd&"', '"&Lang&"', '103', '', '"&scTxt&"'"&vPage&");"">캠핑/트래블</li>" & vbCrLf
	vBody = vBody & "<li style=""cursor:pointer;"" " & chkiif(code="104","class='current'","") & " onclick="""&jsname&"('"&charcd&"', '"&Lang&"', '104', '', '"&scTxt&"'"&vPage&");"">토이</li>" & vbCrLf
	vBody = vBody & "<li style=""cursor:pointer;"" " & chkiif(code="124","class='current'","") & " onclick="""&jsname&"('"&charcd&"', '"&Lang&"', '124', '', '"&scTxt&"'"&vPage&");"">디자인가전</li>" & vbCrLf
	vBody = vBody & "<li style=""cursor:pointer;"" " & chkiif(code="121","class='current'","") & " onclick="""&jsname&"('"&charcd&"', '"&Lang&"', '121', '', '"&scTxt&"'"&vPage&");"">가구/수납</li>" & vbCrLf
	vBody = vBody & "<li style=""cursor:pointer;"" " & chkiif(code="122","class='current'","") & " onclick="""&jsname&"('"&charcd&"', '"&Lang&"', '122', '', '"&scTxt&"'"&vPage&");"">데코/조명</li>" & vbCrLf
	vBody = vBody & "<li style=""cursor:pointer;"" " & chkiif(code="120","class='current'","") & " onclick="""&jsname&"('"&charcd&"', '"&Lang&"', '120', '', '"&scTxt&"'"&vPage&");"">패브릭/생활</li>" & vbCrLf
	vBody = vBody & "<li style=""cursor:pointer;"" " & chkiif(code="112","class='current'","") & " onclick="""&jsname&"('"&charcd&"', '"&Lang&"', '112', '', '"&scTxt&"'"&vPage&");"">키친</li>" & vbCrLf
	vBody = vBody & "<li style=""cursor:pointer;"" " & chkiif(code="119","class='current'","") & " onclick="""&jsname&"('"&charcd&"', '"&Lang&"', '119', '', '"&scTxt&"'"&vPage&");"">푸드</li>" & vbCrLf
	vBody = vBody & "<li style=""cursor:pointer;"" " & chkiif(code="117","class='current'","") & " onclick="""&jsname&"('"&charcd&"', '"&Lang&"', '117', '', '"&scTxt&"'"&vPage&");"">패션의류</li>" & vbCrLf
	vBody = vBody & "<li style=""cursor:pointer;"" " & chkiif(code="116","class='current'","") & " onclick="""&jsname&"('"&charcd&"', '"&Lang&"', '116', '', '"&scTxt&"'"&vPage&");"">패션잡화</li>" & vbCrLf
	vBody = vBody & "<li style=""cursor:pointer;"" " & chkiif(code="125","class='current'","") & " onclick="""&jsname&"('"&charcd&"', '"&Lang&"', '125', '', '"&scTxt&"'"&vPage&");"">주얼리/시계</li>" & vbCrLf
	vBody = vBody & "<li style=""cursor:pointer;"" " & chkiif(code="118","class='current'","") & " onclick="""&jsname&"('"&charcd&"', '"&Lang&"', '118', '', '"&scTxt&"'"&vPage&");"">뷰티</li>" & vbCrLf
	vBody = vBody & "<li style=""cursor:pointer;"" " & chkiif(code="115","class='current'","") & " onclick="""&jsname&"('"&charcd&"', '"&Lang&"', '115', '', '"&scTxt&"'"&vPage&");"">베이비/키즈</li>" & vbCrLf
	vBody = vBody & "<li style=""cursor:pointer;"" " & chkiif(code="110","class='current'","") & " onclick="""&jsname&"('"&charcd&"', '"&Lang&"', '110', '', '"&scTxt&"'"&vPage&");"">Cat&amp;Dog</li>" & vbCrLf

	fnBrandStreetCategoryHeaderAct = vBody
End Function


'// 내가 찜한 브랜드 여부
Function getIsMyFavBrand(uid,mkr)
	dim strSQL
	strSQL = "execute [db_my10x10].[dbo].[sp_Ten_MyZzimBrand_cnt] '" & CStr(uid) & "',1,'','" & cStr(mkr) & "'"
	rsget.CursorLocation = adUseClient
	rsget.CursorType=adOpenStatic
	rsget.Locktype=adLockReadOnly
	rsget.Open strSQL, dbget

	if rsget("cnt")>0 then
		getIsMyFavBrand = true
	else
		getIsMyFavBrand = false
	end if
	rsget.Close
end Function

'// 내가 찜한 상품 여부(위시)
Function getIsMyFavItem(uid,iid)
	dim strSQL
	strSQL = "execute [db_my10x10].[dbo].[sp_Ten_MyWishList_Count] '" & CStr(uid) & "','',''," & cStr(iid)

	rsget.CursorLocation = adUseClient
	rsget.CursorType=adOpenStatic
	rsget.Locktype=adLockReadOnly
	rsget.Open strSQL, dbget

	if rsget("cnt")>0 then
		getIsMyFavItem = true
	else
		getIsMyFavItem = false
	end if
	rsget.Close
end Function

Function getEvaluateAvgPoint(itemid)
	dim strSQL
	strSQL = "execute [db_board].[dbo].[sp_Ten_Evaluate_Tpoint_Const] " & itemid
	rsget.CursorLocation = adUseClient
	rsget.CursorType=adOpenStatic
	rsget.Locktype=adLockReadOnly
	rsget.Open strSQL, dbget

	getEvaluateAvgPoint = 0

	if NOT(rsget.EOF or rsget.BOF) Then
		if rsget("TotalPoint")>0 then
			getEvaluateAvgPoint = Round(rsget("TotalPoint"),1) + 1
		end if
	end if

	rsget.Close
end Function

%>
