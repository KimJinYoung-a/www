<%
'' Require iteminfoCls.asp

class CMyFavoriteCateCnt
    public FCdL
    public FCount

    Private Sub Class_Initialize()

	End Sub

	Private Sub Class_Terminate()

	End Sub

end Class


Class CMyFavorite
	public FItemList()

	public FTotalCount
	public FCurrPage
	public FTotalPage
	public FPageSize
	public FResultCount
	public FScrollCount

	public FRectDisp
	public FRectUserID
	public FRectCDL
	public FRectSortMethod
	public FFolderIdx
	public FOldFolderIdx
	public FRectOrderType
	public FFolderName
    public fviewisusing
    public FWishEventPrice
    public FWishEventTotalCnt
    public FRectviewisusing
    public FRectdeliType
    public FRectSellScope
    public Fevtcode
	public FItemID

	public FExB2BItemYn '// B2B 상품 조회 제외 여부(Y/N)

	Private Sub Class_Initialize()
		redim preserve FItemList(0)
		FCurrPage =1
		FPageSize = 10
		FResultCount = 0
		FScrollCount = 10
		FTotalCount = 0
	End Sub

	Private Sub Class_Terminate()

	End Sub

    public function GetCateFavCount(byval iCdL)
        '' Using Only CMyFavoriteCateCnt
        dim i

        GetCateFavCount = 0

        for i=0 to FResultCount-1
            if (FItemList(i).FCDL=iCdL) then
                GetCateFavCount = FItemList(i).FCount
                Exit function
            end if
        next
    end function

	'''장바구니용 위시리스트 5
	public Sub getBaguniFavList5()
		dim sqlStr, i
		sqlStr = "exec [db_my10x10].[dbo].sp_Ten_MyBaguniFavList " & CStr(FPageSize) & ",'" & FRectUserID & "'"

        rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic

		rsget.Open sqlStr,dbget,1


		FResultCount = rsget.RecordCount
        IF (FResultCount<1) then FResultCount=0
        FTotalCount = FResultCount
		redim preserve FItemList(FResultCount)
		i=0
		if  not rsget.EOF  then
			do until rsget.eof
				set FItemList(i)          = new CCategoryPrdItem

				FItemList(i).FItemID        = rsget("itemid")
				FItemList(i).FItemName      = db2html(rsget("itemname"))
				FItemList(i).Fmakerid       = rsget("makerid")
				FItemList(i).FBrandName     = db2html(rsget("brandname"))

				FItemList(i).FSellcash      = rsget("sellcash")
				FItemList(i).Fitemgubun     = rsget("itemgubun")
				FItemList(i).FImageList     = "http://webimage.10x10.co.kr/image/list/" + GetImageSubFolderByItemid(FItemList(i).FItemID) + "/" + rsget("listimage")
				FItemList(i).FImageSmall    = "http://webimage.10x10.co.kr/image/small/" + GetImageSubFolderByItemid(FItemList(i).FItemID) + "/" + rsget("smallimage")
				FItemList(i).FImageList120  = "http://webimage.10x10.co.kr/image/list120/" + GetImageSubFolderByItemid(FItemList(i).FItemID) + "/" + rsget("listimage120")
				FItemList(i).FImageIcon1	= "http://webimage.10x10.co.kr/image/icon1/" + GetImageSubFolderByItemid(FItemList(i).FItemID) + "/" + rsget("icon1Image")

				''품절된 상품중 이미지 없는것들 있음..
				if IsNULL(FItemList(i).FImageList120) then
				    FItemList(i).FImageList120 = FItemList(i).FImageList
				elseif (rsget("listimage120")="") then
				    FItemList(i).FImageList120 = FItemList(i).FImageList
				end if

				FItemList(i).FSellYn    = rsget("sellyn")
				FItemList(i).FLimitYn   = rsget("limityn")
				FItemList(i).FLimitNo   = rsget("limitno")
				FItemList(i).FLimitSold = rsget("limitsold")
				FItemList(i).FOptioncnt	= rsget("optioncnt")
                FItemList(i).FItemDiv 	= rsget("itemdiv")		'상품 속성

				FItemList(i).FSaleYn        = rsget("sailyn")
				''FItemList(i).FSalePrice     = rsget("sailprice")
				FItemList(i).FOrgPrice      = rsget("orgprice")
				FItemList(i).FSpecialUserItem   = rsget("specialuseritem")

				FItemList(i).Fitemcouponyn 		= rsget("itemcouponyn")
				FItemList(i).Fitemcoupontype 	= rsget("itemcoupontype")
				FItemList(i).Fitemcouponvalue 	= rsget("itemcouponvalue")
				FItemList(i).Fcurritemcouponidx = rsget("curritemcouponidx")

				FItemList(i).FRegdate           = rsget("itemregdate")
				FItemList(i).Fevalcnt           = rsget("evalcnt")
				FItemList(i).Fdeliverytype      = rsget("deliverytype")
				FItemList(i).FfavCount          = rsget("favcount")             ''2013/09/추가
				FItemList(i).FAdultType			= rsget("adultType")
				i=i+1
				rsget.moveNext
			loop
		end if

		rsget.Close
	end Sub

    public Sub getMyWishCateCount()
        dim sqlStr, i

        sqlStr = " select i.cate_large, Count(f.itemid) as Cnt"
        sqlStr = sqlStr + " from [db_my10x10].[dbo].tbl_myfavorite f, [db_item].[dbo].tbl_item i" + VbCrlf
		sqlStr = sqlStr + " where f.userid='" + FRectUserID + "'" + VbCrlf
		sqlStr = sqlStr + " and f.itemid=i.itemid" + VbCrlf
		sqlStr = sqlStr + " and f.fidx="+Cstr(FFolderIdx) + VbCrlf
		sqlStr = sqlStr + " group by i.cate_large"

		rsget.Open sqlStr,dbget,1

		FTotalCount  = 0
		FResultCount = rsget.RecordCount

		if (FResultCount<1) then FResultCount=0

		redim preserve FItemList(FResultCount)

		if Not rsget.Eof then
		    do until rsget.eof
				set FItemList(i)    = new CMyFavoriteCateCnt
    		    FItemList(i).FCDL   = rsget("cate_large")
    		    FItemList(i).FCount = rsget("Cnt")

    		    FTotalCount         = FTotalCount + FItemList(i).FCount
    		    i=i+1
    		    rsget.MoveNext
    		loop
		end if
		rsget.close

    end Sub

	public Sub getMyWishList()
		dim sqlStr, addSql, i

		'// 추가 쿼리 작성
		if FRectviewisusing <> "" then
			addSql = addSql + " and f.fidx <> 0 and b.viewisusing = 'Y'" + VbCrlf

			if FFolderIdx <> "0" and FFolderIdx <> "" then
				addSql = addSql + " and f.fidx="+Cstr(FFolderIdx) + VbCrlf
			end if
		else
			addSql = addSql + " and f.fidx="+Cstr(FFolderIdx) + VbCrlf
		end if

        if FRectSortMethod="coupon" then
            addSql = addSql + " and i.itemcouponyn='Y'"
        elseif FRectSortMethod="saleop" then
            addSql = addSql + " and i.sailyn='Y'"
        elseif FRectSortMethod="limit" then
            addSql = addSql + " and i.limityn='Y'"
        elseif FRectSortMethod="newitem" then
            addSql = addSql + " and datediff(day, i.regdate,getdate()) <=14"
        end if

		if FRectdeliType="TN" then
			'텐바이텐 배송
			addSql = addSql & " and (deliverytype='1' or deliverytype='4') "
		end if

		if FRectSellScope="Y" then
			'품절상품 제외
			addSql = addSql & " and (sellyn='Y') "
		end if

		'// 상품 전시 카테고리
		if FRectDisp<>"" then
			addSql = addSql & " and i.dispcate1='" & left(FRectDisp,3) & "' "
		end if

		'// B2B상품 제외
		If FExB2BItemYn = "Y" Then
			addSql = addSql & " and i.itemdiv <> 23 "
		End If

		'// 목록 개수 파악
		sqlStr = "select count(f.itemid) as cnt " + VbCrlf
		sqlStr = sqlStr + " from [db_my10x10].[dbo].tbl_myfavorite f" + VbCrlf
		sqlStr = sqlStr + " join [db_item].[dbo].tbl_item i " + VbCrlf
		sqlStr = sqlStr + " on f.itemid=i.itemid " + VbCrlf
		sqlStr = sqlStr + " join [db_item].[dbo].tbl_item_contents t " + VbCrlf
		sqlStr = sqlStr + "	on i.itemid=t.itemid " + VbCrlf
		sqlStr = sqlStr + " left join [db_my10x10].dbo.tbl_myfavorite_folder b" + VbCrlf
		sqlStr = sqlStr + " on f.fidx = b.fidx" + VbCrlf
		sqlStr = sqlStr + " where f.userid='" + FRectUserID + "'" & addSql + VbCrlf

		rsget.Open sqlStr,dbget,1
			FTotalCount = rsget("cnt")
		rsget.close

		'// 본문 접수
		sqlStr = "select top " + CStr(FPageSize*FCurrPage)
		sqlStr = sqlStr + " f.itemid, i.itemname, i.sellcash, i.orgprice, (Case When isNull(i.frontMakerid,'')='' then i.makerid else i.frontMakerid end) as makerid, i.brandname" + VbCrlf
		sqlStr = sqlStr + " , i.sellyn, i.sailyn, i.itemgubun, i.limityn, limitno, limitsold, i.listimage" + VbCrlf
		sqlStr = sqlStr + " , i.icon1Image, i.icon2Image, i.listimage120, i.smallimage, i.sailprice, i.optioncnt, i.evalcnt, i.specialuseritem" + VbCrlf
		sqlStr = sqlStr + " , i.itemcouponyn, i.itemcoupontype, i.itemcouponvalue, i.curritemcouponidx" + VbCrlf
		sqlStr = sqlStr + " , i.regdate as itemregdate, i.itemdiv, i.deliverytype, i.adultType,  t.favcount " + VbCrlf
		sqlStr = sqlStr + " ,(CASE WHEN (i.orgprice-i.sellcash)>0 THEN round((1-i.sellcash/i.orgprice)*100,0)WHEN (i.orgprice-i.sellcash)<=0 THEN 0 END) as SalePercent " + VbCrlf
		sqlStr = sqlStr + " from [db_my10x10].[dbo].tbl_myfavorite f" + VbCrlf
		sqlStr = sqlStr + " join [db_item].[dbo].tbl_item i " + VbCrlf
		sqlStr = sqlStr + " on f.itemid=i.itemid " + VbCrlf
		sqlStr = sqlStr + " join [db_item].[dbo].tbl_item_contents t " + VbCrlf
		sqlStr = sqlStr + "	on i.itemid=t.itemid " + VbCrlf
		sqlStr = sqlStr + " left join [db_my10x10].dbo.tbl_myfavorite_folder b" + VbCrlf
		sqlStr = sqlStr + " on f.fidx = b.fidx" + VbCrlf
		sqlStr = sqlStr + " where f.userid='" + FRectUserID + "'" & addSql + VbCrlf

		if FRectOrderType="new" then
		    sqlStr = sqlStr + " order by i.itemid desc"
		elseif FRectOrderType="fav" then
		    sqlStr = sqlStr + " order by i.itemscore desc, i.itemid desc"
		elseif FRectOrderType="highprice" then
		    sqlStr = sqlStr + " order by i.sellcash desc"
		elseif FRectOrderType="lowprice" then
		    sqlStr = sqlStr + " order by i.sellcash asc"
		elseif FRectOrderType="highsale" then					''높은할인율순
			sqlStr = sqlStr + " order by SalePercent desc"
		else
		    sqlStr = sqlStr + " order by f.regdate desc"
		end if

		rsget.pagesize = FPageSize

		'response.write sqlStr &"<br>"
		rsget.Open sqlStr, dbget, 1

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
			do until rsget.eof
				set FItemList(i)          = new CCategoryPrdItem

				FItemList(i).FItemID        = rsget("itemid")
				FItemList(i).FItemName      = db2html(rsget("itemname"))
				FItemList(i).Fmakerid       = rsget("makerid")
				FItemList(i).FBrandName     = db2html(rsget("brandname"))

				FItemList(i).FSellcash      = rsget("sellcash")
				FItemList(i).Fitemgubun     = rsget("itemgubun")
				FItemList(i).FImageList     = "http://webimage.10x10.co.kr/image/list/" + GetImageSubFolderByItemid(FItemList(i).FItemID) + "/" + rsget("listimage")
				FItemList(i).FImageSmall    = "http://webimage.10x10.co.kr/image/small/" + GetImageSubFolderByItemid(FItemList(i).FItemID) + "/" + rsget("smallimage")
				FItemList(i).FImageList120  = "http://webimage.10x10.co.kr/image/list120/" + GetImageSubFolderByItemid(FItemList(i).FItemID) + "/" + rsget("listimage120")
				FItemList(i).FImageIcon1	= "http://webimage.10x10.co.kr/image/icon1/" + GetImageSubFolderByItemid(FItemList(i).FItemID) + "/" + rsget("icon1Image")
				FItemList(i).FImageIcon2	= "http://webimage.10x10.co.kr/image/icon2/" + GetImageSubFolderByItemid(FItemList(i).FItemID) + "/" + rsget("icon2Image")

				''품절된 상품중 이미지 없는것들 있음..
				if IsNULL(FItemList(i).FImageList120) then
				    FItemList(i).FImageList120 = FItemList(i).FImageList
				elseif (rsget("listimage120")="") then
				    FItemList(i).FImageList120 = FItemList(i).FImageList
				end if

				FItemList(i).FSellYn    = rsget("sellyn")
				FItemList(i).FLimitYn   = rsget("limityn")
				FItemList(i).FLimitNo   = rsget("limitno")
				FItemList(i).FLimitSold = rsget("limitsold")
				FItemList(i).FOptioncnt	= rsget("optioncnt")
                		FItemList(i).FItemDiv 	= rsget("itemdiv")		'상품 속성

				FItemList(i).FSaleYn        = rsget("sailyn")
				''FItemList(i).FSalePrice     = rsget("sailprice")
				FItemList(i).FOrgPrice      = rsget("orgprice")
				FItemList(i).FSpecialUserItem   = rsget("specialuseritem")

				FItemList(i).Fitemcouponyn 		= rsget("itemcouponyn")
				FItemList(i).Fitemcoupontype 	= rsget("itemcoupontype")
				FItemList(i).Fitemcouponvalue 	= rsget("itemcouponvalue")
				FItemList(i).Fcurritemcouponidx = rsget("curritemcouponidx")

				FItemList(i).FRegdate           = rsget("itemregdate")
				FItemList(i).Fevalcnt           = rsget("evalcnt")
				FItemList(i).FfavCount          = rsget("favcount")
				FItemList(i).Fdeliverytype      = rsget("deliverytype")
				FItemList(i).FadultType			= rsget("adultType") '성인용품 여부 0 1 2
				i=i+1
				rsget.moveNext
			loop
		end if
		rsget.close
	end sub


	public Sub getMyWishListNoFidx()
		dim sqlStr, i

		sqlStr = " exec [db_my10x10].[dbo].[sp_Ten_MyWishList_Count] '" + CStr(FRectUserID) + "', '" + CStr(FRectCDL) + "', '" + CStr(FRectSortMethod) + "' "
		rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic

		rsget.Open sqlStr,dbget,1
			FTotalCount = rsget(0)
		rsget.close


		sqlStr = " exec [db_my10x10].[dbo].[sp_Ten_MyWishList] '" + CStr(FRectUserID) + "', '" + CStr(FRectCDL) + "', '" + CStr(FRectSortMethod) + "', " + CStr(FPageSize*FCurrPage) + " "
		rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic

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
			do until rsget.eof
				set FItemList(i)          = new CCategoryPrdItem

				FItemList(i).FItemID        = rsget("itemid")
				FItemList(i).FItemName      = db2html(rsget("itemname"))
				FItemList(i).Fmakerid       = rsget("makerid")
				FItemList(i).FBrandName     = db2html(rsget("brandname"))

				FItemList(i).FSellcash      = rsget("sellcash")
				FItemList(i).Fitemgubun     = rsget("itemgubun")
				FItemList(i).FImageList     = "http://webimage.10x10.co.kr/image/list/" + GetImageSubFolderByItemid(FItemList(i).FItemID) + "/" + rsget("listimage")
				FItemList(i).FImageSmall    = "http://webimage.10x10.co.kr/image/small/" + GetImageSubFolderByItemid(FItemList(i).FItemID) + "/" + rsget("smallimage")
               		 FItemList(i).FImageList120  = "http://webimage.10x10.co.kr/image/list120/" + GetImageSubFolderByItemid(FItemList(i).FItemID) + "/" + rsget("listimage120")

				''품절된 상품중 이미지 없는것들 있음..
				if IsNULL(FItemList(i).FImageList120) then
				    FItemList(i).FImageList120 = FItemList(i).FImageList
				elseif (rsget("listimage120")="") then
				    FItemList(i).FImageList120 = FItemList(i).FImageList
				end if

				FItemList(i).FSellYn    = rsget("sellyn")
				FItemList(i).FLimitYn   = rsget("limityn")
				FItemList(i).FLimitNo   = rsget("limitno")
				FItemList(i).FLimitSold = rsget("limitsold")
				FItemList(i).FOptioncnt	= rsget("optioncnt")


				FItemList(i).FSaleYn        = rsget("sailyn")
				''FItemList(i).FSalePrice     = rsget("sailprice")
				FItemList(i).FOrgPrice      = rsget("orgprice")
				FItemList(i).FSpecialUserItem   = rsget("specialuseritem")

				FItemList(i).Fitemcouponyn 		= rsget("itemcouponyn")
				FItemList(i).Fitemcoupontype 	= rsget("itemcoupontype")
				FItemList(i).Fitemcouponvalue 	= rsget("itemcouponvalue")
				FItemList(i).Fcurritemcouponidx = rsget("curritemcouponidx")

				FItemList(i).FRegdate           = rsget("itemregdate")
				FItemList(i).Fevalcnt           = rsget("evalcnt")
				FItemList(i).FfavCount          = rsget("favcount")
				i=i+1
				rsget.moveNext
			loop
		end if
		rsget.close
	end sub

	 public Sub delete(itemarray)
		dim sqlStr, i, oneitem, buf

		oneitem = Split(itemarray, ";")
		for i=0 to UBound(oneitem)
				  buf = Split(oneitem(i), ",")
				  if (UBound(buf) < 2) then exit for end if
		  sqlStr = "delete from [db_my10x10].[dbo].tbl_myfavorite" + VbCrlf
		  sqlStr = sqlStr + " where userid='" + FRectUserID + "'" + VbCrlf
		  sqlStr = sqlStr + " and itemid=" + CStr(buf(0))  +" and fidx= "+Cstr(FFolderIdx)+ VbCrlf
		  rsget.Open sqlStr,dbget,1
		  'response.write sqlStr
		next
	 end Sub

	 public Sub selectdelete(itemarray)
		dim sqlStr, i, oneitem, buf

		if (Left(itemarray,1)=",") then itemarray = Mid(itemarray,2,1024)
		if (Right(itemarray,1)=",") then itemarray = Left(itemarray,Len(itemarray) - 1)


		  sqlStr = "delete from [db_my10x10].[dbo].tbl_myfavorite" + VbCrlf
		  sqlStr = sqlStr + " where userid='" + FRectUserID + "'" + VbCrlf
		  sqlStr = sqlStr + " and itemid in (" + itemarray + ")" +" and fidx= "+Cstr(FFolderIdx)+ VbCrlf
		  rsget.Open sqlStr,dbget,1
		  'response.write sqlStr

	 end Sub


	'//선택상품 등록
	public Sub selectedinsert(itemarray)
		if (Left(itemarray,1)=",") then itemarray = Mid(itemarray,2,1024)
		if (Right(itemarray,1)=",") then itemarray = Left(itemarray,Len(itemarray) - 1)
		IF FFolderIdx = "" THEN FFolderIdx =0

		itemarray = split(itemarray,",")
		dbget.beginTrans
		for intloop = 0 to ubound(itemarray)
		    sqlStr = " IF Not Exists(SELECT itemid FROM [db_my10x10].[dbo].tbl_myfavorite WHERE userid ='" + FRectUserID + "' and itemid=" & itemarray(intLoop) & " and fidx="&FFolderIdx&" ) "
		    sqlStr = sqlStr + "	BEGIN " + VbCrlf
		    sqlStr = sqlStr + " insert into [db_my10x10].[dbo].tbl_myfavorite" + VbCrlf
		    sqlStr = sqlStr + " (userid,itemid,fidx,viewIsUsing)" + VbCrlf
		    sqlStr = sqlStr + " select '" + FRectUserID + "'," + CStr( itemarray(intLoop)) + ","+Cstr(FFolderIdx)+",isNull((select top 1 viewIsUsing from [db_my10x10].[dbo].tbl_myfavorite_folder where fidx="+Cstr(FFolderIdx)+"),'N')" + VbCrlf
		    sqlStr = sqlStr + "	END " + VbCrlf
		    dbget.Execute sqlStr
    		next

    		If dbget.Errors.Count <> 0 Then
    			dbget.RollbackTrans
		Else
    			dbget.CommitTrans
		End If
	End Sub

	'//특정상품 등록
	public Sub iteminsert(itemid)
		IF FFolderIdx = "" THEN FFolderIdx =0
		 sqlStr = " IF Not Exists(SELECT itemid FROM [db_my10x10].[dbo].tbl_myfavorite WHERE userid ='" + FRectUserID + "' and itemid=" & itemid & " and fidx="&FFolderIdx&" ) "
		    sqlStr = sqlStr + "	BEGIN " + VbCrlf
		    sqlStr = sqlStr + " insert into [db_my10x10].[dbo].tbl_myfavorite" + VbCrlf
		    sqlStr = sqlStr + " (userid,itemid,fidx,viewIsUsing)" + VbCrlf
		    sqlStr = sqlStr + " select '" + FRectUserID + "'," + CStr(itemid) + ","+Cstr(FFolderIdx)+",isNull((select top 1 viewIsUsing from [db_my10x10].[dbo].tbl_myfavorite_folder where fidx="+Cstr(FFolderIdx)+"),'N')" + VbCrlf
		    sqlStr = sqlStr + "	END " + VbCrlf
		    dbget.Execute sqlStr
	End Sub

 	'// 폴더 리스트 가져오기 '2010.04.09 한용민 수정
	public Function fnGetFolderList
		Dim strSql, i, arrRst, chkBF: chkBF=false
		strSql ="[db_my10x10].[dbo].sp_Ten_myfavoritefolder_GetList2 ('"&FRectUserID&"')"
		rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
		IF Not (rsget.EOF OR rsget.BOF) THEN
			arrRst = rsget.GetRows()

			'기본폴더 존재 여부 확인
			for i=0 to ubound(arrRst,2)
				if arrRst(0,i)="0" then
					chkBF = true
					exit for
				end if
			next

			'// 기본폴더 없으면 기본폴더 추가
			if Not(chkBF) then
				dim tmpArr
				redim tmpArr(3,ubound(arrRst,2)+1)
				tmpArr(0,0) = 0
				tmpArr(1,0) = "기본폴더"
				tmpArr(2,0) = "N"
				tmpArr(3,0) = 0

				for i=0 to ubound(arrRst,2)
					tmpArr(0,i+1) = arrRst(0,i)
					tmpArr(1,i+1) = arrRst(1,i)
					tmpArr(2,i+1) = arrRst(2,i)
					tmpArr(3,i+1) = arrRst(3,i)
				next
				arrRst = tmpArr
			end if
		END IF

		'결과 반환
		fnGetFolderList = arrRst
		rsget.close
	End Function


	'// 폴더 리스트 가져오기(팝업창으로 뜨는 폴더리스트 가져올땐 아래 프로시저로 불러옴(cnt값이 필요없음)
	public Function fnGetFolderList2
		Dim strSql, i, arrRst, chkBF: chkBF=false
		strSql ="[db_my10x10].[dbo].sp_Ten_myfavoritefolder_GetList ('"&FRectUserID&"')"
		rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
		IF Not (rsget.EOF OR rsget.BOF) THEN
			arrRst = rsget.GetRows()

			'기본폴더 존재 여부 확인
			for i=0 to ubound(arrRst,2)
				if arrRst(0,i)="0" then
					chkBF = true
					exit for
				end if
			next

			'// 기본폴더 없으면 기본폴더 추가
			if Not(chkBF) then
				dim tmpArr
				redim tmpArr(2,ubound(arrRst,2)+1)
				tmpArr(0,0) = 0
				tmpArr(1,0) = "기본폴더"
				tmpArr(2,0) = "N"

				for i=0 to ubound(arrRst,2)
					tmpArr(0,i+1) = arrRst(0,i)
					tmpArr(1,i+1) = arrRst(1,i)
					tmpArr(2,i+1) = arrRst(2,i)
				next
				arrRst = tmpArr
			end if
		END IF

		'결과 반환
		fnGetFolderList2 = arrRst
		rsget.close
	End Function


 	'// 공개여부 Y 위시리스트 가져오기 '2010.04.09 한용민 추가
	public Function fnmyfavorite_search
		Dim strSql
		strSql ="db_my10x10.dbo.sp_Ten_myfavorite_search ('"&FRectUserID&"')"

		'response.write strSql &"<br>"
		rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
		IF Not (rsget.EOF OR rsget.BOF) THEN
			fnmyfavorite_search = rsget.GetRows()
		END IF
		rsget.close
	End Function

	'// 새폴더 추가 '2010-04-09 한용민 수정
	public Function fnSetFolder
		Dim objCmd
		Dim intResult

		Set objCmd = Server.CreateObject("ADODB.Command")
		With objCmd
			.ActiveConnection =  dbget
			.CommandType = adCmdText
			.CommandText = "{?=call [db_my10x10].[dbo].sp_Ten_myfavoritefolder_insert ('"&FRectUserID&"','"&FFolderName&"','"&fviewisusing&"')}"
			.Parameters.Append .CreateParameter("RETURN_VALUE", adInteger, adParamReturnValue)
			.Execute, , adExecuteNoRecords
		End With
		intResult = objCmd(0).Value
		Set objCmd = nothing

		fnSetFolder = intResult
	End Function

	'//폴더 이동
	public Function fnChangeFolder(itemarray)
	Dim objCmd
	Dim intResult

		if (Left(itemarray,1)=",") then itemarray = Mid(itemarray,2,1024)
		if (Right(itemarray,1)=",") then itemarray = Left(itemarray,Len(itemarray) - 1)
		IF FFolderIdx = "" THEN FFolderIdx =0
		itemarray = split(itemarray,",")
		dbget.beginTrans
		for intloop = 0 to ubound(itemarray)
		Set objCmd = Server.CreateObject("ADODB.Command")
		With objCmd
			.ActiveConnection =  dbget
			.CommandType = adCmdText
			.CommandText = "{?=call [db_my10x10].[dbo].sp_Ten_myfavoritefolder_Change ('"&FRectUserID&"',"&itemarray(intloop)&","&FFolderIdx&","&FOldFolderIdx&")}"
			.Parameters.Append .CreateParameter("RETURN_VALUE", adInteger, adParamReturnValue)
			.Execute, , adExecuteNoRecords
		End With
		intResult = objCmd(0).Value
		Set objCmd = nothing
		if intResult = 0 THEN
			dbget.RollBackTrans
			exit for
		end if
		next
		dbget.CommitTrans
		fnChangeFolder = intResult
	End Function

	'//폴더명 수정 '2010.04.09 한용민 수정
	public Function fnSetFolderUpdate
	Dim objCmd
	Dim intResult

		Set objCmd = Server.CreateObject("ADODB.Command")
		With objCmd
			.ActiveConnection =  dbget
			.CommandType = adCmdText
			.CommandText = "{?=call [db_my10x10].[dbo].sp_Ten_myfavoritefolder_update ("&FFolderIdx&",'"&FFolderName&"','"&fviewisusing&"')}"
			.Parameters.Append .CreateParameter("RETURN_VALUE", adInteger, adParamReturnValue)
			.Execute, , adExecuteNoRecords
		End With
		intResult = objCmd(0).Value
		Set objCmd = nothing

		fnSetFolderUpdate = intResult
	End Function

		'//폴더 삭제
	public Function fnSetFolderDelete
	Dim objCmd
	Dim intResult

		Set objCmd = Server.CreateObject("ADODB.Command")
		With objCmd
			.ActiveConnection =  dbget
			.CommandType = adCmdText
			.CommandText = "{?=call [db_my10x10].[dbo].sp_Ten_myfavoritefolder_Delete ('"&FRectUserID&"',"&FFolderIdx&")}"
			.Parameters.Append .CreateParameter("RETURN_VALUE", adInteger, adParamReturnValue)
			.Execute, , adExecuteNoRecords
		End With
		intResult = objCmd(0).Value
		Set objCmd = nothing

		fnSetFolderDelete = intResult
	End Function

	'//폴더 정보 업데이트 (폴더별 상품수, 최근 업데이트 정보; 2013-12-19:허진원)
	public Sub fnUpdateFolderInfo()
		sqlStr = " update A " + VbCrlf
	    sqlStr = sqlStr + "	Set A.itemCnt=isNULL(B.cnt,0) " + VbCrlf
	    sqlStr = sqlStr + "		,A.lastupdate=isNULL(B.updt,getdate()) " + VbCrlf
	    sqlStr = sqlStr + "	from db_my10x10.dbo.tbl_myfavorite_folder as A " + VbCrlf
	    sqlStr = sqlStr + "		left join  ( " + VbCrlf
	    sqlStr = sqlStr + "			select fidx, count(*) cnt, max(isNull(lastupdate,regdate)) updt " + VbCrlf
	    sqlStr = sqlStr + "			from db_my10x10.dbo.tbl_myfavorite " + VbCrlf
	    sqlStr = sqlStr + "			where userid='" + FRectUserID + "' " + VbCrlf
	    sqlStr = sqlStr + "			group by fidx " + VbCrlf
	    sqlStr = sqlStr + "		) as B " + VbCrlf
	    sqlStr = sqlStr + "			on A.fidx=B.fidx " + VbCrlf
	    sqlStr = sqlStr + "	where A.userid='" + FRectUserID + "' and (isNULL(A.itemCnt,0)<>isNULL(B.cnt,0) or A.lastupdate<>B.updt)"  + VbCrlf '' 조건 추가 // left join 갯수 0/ 트리거에 변경내역만 반영되게.
		dbget.Execute sqlStr
	End Sub

 	'// ####### 위시리스트 이벤트 #######
	public Function fnWishListEventSave
		Dim strSql
		'// 2020 연말 위시 이벤트는 기존 저장된 위시 데이터 지우고 다시 넣지 않고 지금 위시하는 아이템 하나만 추가
		If (application("Svr_Info") = "Dev" And Fevtcode = "104280") Or (application("Svr_Info") <> "Dev" And Fevtcode = "108614") Then
		    strSql ="[db_my10x10].[dbo].sp_Ten_Wishlist_Event_New ('"&FRectUserID&"','"&FFolderIdx&"','"&FItemID&"','"&Fevtcode&"')"
            rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
            IF dbget.errors.count > 0 Then
                FResultCount = "x"
            Else
                FResultCount = "o"
            END IF
		Else
            strSql ="[db_my10x10].[dbo].sp_Ten_Wishlist_Event ('"&FRectUserID&"','"&FFolderIdx&"','"&Fevtcode&"')"
            rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
            IF dbget.errors.count > 0 Then
                FResultCount = "x"
            Else
                FResultCount = "o"
            END IF
		End If
	End Function

	public Function fnWishListEventView
		Dim strSql
		strSql ="[db_my10x10].[dbo].sp_Ten_Wishlist_EventView ('"&FRectUserID&"','"&FFolderIdx&"')"
		rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
		IF NOT rsget.Eof Then
			FWishEventPrice = rsget(0)
			FWishEventTotalCnt = rsget(1)
		Else
			FWishEventPrice = 0
			FWishEventTotalCnt = 0
		END IF
		rsget.close
	End Function
	'// ####### 위시리스트 이벤트 END #######


	'####### popular 리스트 -->
	public Function fnPopularList
		Dim strSql, i, orderby

		If FRectSortMethod <> "" Then
			SELECT CASE FRectSortMethod
				Case "1" : orderby = "p.regtime desc,"
				Case "2" : orderby = ""	'### 마지막 순서로 itemid desc 가 있음.
				Case "3" : orderby = "p.inCount desc,"
				Case "4" : orderby = "evalcnt desc,"
				Case "5" : orderby = "evalcnt asc,"
				Case "6" : orderby = "newid() asc,"
				Case Else orderby = ""
			END SELECT
		End If

		strSql = "EXECUTE [db_my10x10].[dbo].[sp_Ten_New_Popularlist_Count] '" & FpageSize & "', '" & FRectDisp & "'"

		'response.write strSql & "<br>"
		rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
		rsget.Open strSql,dbget,1
			FTotalCount = rsget(0)
			FTotalPage	= rsget(1)
		rsget.close

		If FTotalCount > 0 Then
			strSql = "EXECUTE [db_my10x10].[dbo].[sp_Ten_New_Popularlist] '" & (FpageSize*FCurrPage) & "', '" & FRectDisp & "', '" & FRectUserID & "', '" & orderby & "'"

			'response.write strSql & "<br>"
			rsget.CursorLocation = adUseClient
			rsget.CursorType = adOpenStatic
			rsget.LockType = adLockOptimistic
			rsget.pagesize = FPageSize
			rsget.Open strSql,dbget,1

			FResultCount = rsget.RecordCount-(FPageSize*(FCurrPage-1))
	        if (FResultCount<1) then FResultCount=0
			redim preserve FItemList(FResultCount)

			i=0
			if  not rsget.EOF  then
				rsget.absolutepage = FCurrPage
				do until rsget.eof
					set FItemList(i) = new CCategoryPrdItem

					FItemList(i).fEval_excludeyn 			= rsget("Eval_excludeyn")
					FItemList(i).FItemID        = rsget("itemid")
					FItemList(i).FInCount       = rsget("inCount")
					FItemList(i).FRegTime       = rsget("regtime")

					If rsget("basicimage600") = "" Then
						FItemList(i).FImageBasic	= "http://webimage.10x10.co.kr/image/basic/" + GetImageSubFolderByItemid(FItemList(i).FItemID) + "/" + rsget("basicimage")
					Else
						FItemList(i).FImageBasic	= "http://webimage.10x10.co.kr/image/basic600/" + GetImageSubFolderByItemid(FItemList(i).FItemID) + "/" + rsget("basicimage600")
					End If

					FItemList(i).Fmakerid       = rsget("makerid")
					FItemList(i).FBrandName     = db2html(rsget("brandname"))
					FItemList(i).FItemName      = db2html(rsget("itemname"))
					FItemList(i).FFavCount      = rsget("favcount")
					FItemList(i).FEvalCnt		= rsget("evalcnt")
					FItemList(i).FEvaluate		= rsget("evaluate")
					FItemList(i).FCateName		= rsget("code_nm")
					If Cstr(rsget("catecode")) <> "0" Then
						FItemList(i).FDisp		= Cstr(rsget("catecode"))
					End If

					FItemList(i).FSellCash = rsget("sellcash")
					FItemList(i).FOrgPrice = rsget("orgprice")
					FItemList(i).FSellyn = rsget("sellyn")
					FItemList(i).FSaleyn = rsget("sailyn")
					FItemList(i).FLimityn = rsget("limityn")
					FItemList(i).FItemcouponyn = rsget("itemcouponyn")
					FItemList(i).FItemCouponValue = rsget("itemCouponValue")
					FItemList(i).FItemCouponType = rsget("itemCouponType")
					FItemList(i).FMyCount = rsget("mycount")

					i=i+1
					rsget.moveNext
				loop
			end if
			rsget.close
		End If
	End Function

	public Function fnPopularList_CT
		Dim strSql, i, orderby

		If FRectSortMethod <> "" Then
			SELECT CASE FRectSortMethod
				Case "1" : orderby = "p.regtime desc,"
				Case "2" : orderby = ""	'### 마지막 순서로 itemid desc 가 있음.
				Case "3" : orderby = "p.inCount desc,"
				Case "4" : orderby = "evalcnt desc,"
				Case "5" : orderby = "evalcnt asc,"
				Case "6" : orderby = "newid() asc,"
				Case Else orderby = ""
			END SELECT
		End If

		strSql = "EXECUTE [db_appWish].[dbo].[sp_Ten_New_Popularlist_Count] '" & FpageSize & "', '" & FRectDisp & "'"

		'response.write strSql & "<br>"
		rsCTget.CursorLocation = adUseClient
		rsCTget.CursorType = adOpenStatic
		rsCTget.LockType = adLockOptimistic
		rsCTget.Open strSql,dbCTget,1
			FTotalCount = rsCTget(0)
			FTotalPage	= rsCTget(1)
		rsCTget.close

		If FTotalCount > 0 Then
			strSql = "EXECUTE [db_appWish].[dbo].[sp_Ten_New_Popularlist] '" & (FpageSize*FCurrPage) & "', '" & FRectDisp & "', '" & FRectUserID & "', '" & orderby & "'"

			'response.write strSql & "<br>"
			rsCTget.CursorLocation = adUseClient
			rsCTget.CursorType = adOpenStatic
			rsCTget.LockType = adLockOptimistic
			rsCTget.pagesize = FPageSize
			rsCTget.Open strSql,dbCTget,1

			FResultCount = rsCTget.RecordCount-(FPageSize*(FCurrPage-1))
	        if (FResultCount<1) then FResultCount=0
			redim preserve FItemList(FResultCount)

			i=0
			if  not rsCTget.EOF  then
				rsCTget.absolutepage = FCurrPage
				do until rsCTget.eof
					set FItemList(i) = new CCategoryPrdItem

					FItemList(i).fEval_excludeyn 			= rsCTget("Eval_excludeyn")
					FItemList(i).FItemID        = rsCTget("itemid")
					FItemList(i).FInCount       = rsCTget("inCount")
					FItemList(i).FRegTime       = rsCTget("regtime")

					If rsCTget("basicimage600") = "" Then
						FItemList(i).FImageBasic	= "http://webimage.10x10.co.kr/image/basic/" + GetImageSubFolderByItemid(FItemList(i).FItemID) + "/" + rsCTget("basicimage")
					Else
						FItemList(i).FImageBasic	= "http://webimage.10x10.co.kr/image/basic600/" + GetImageSubFolderByItemid(FItemList(i).FItemID) + "/" + rsCTget("basicimage600")
					End If

					FItemList(i).Fmakerid       = rsCTget("makerid")
					FItemList(i).FBrandName     = db2html(rsCTget("brandname"))
					FItemList(i).FItemName      = db2html(rsCTget("itemname"))
					FItemList(i).FFavCount      = rsCTget("favcount")
					FItemList(i).FEvalCnt		= rsCTget("evalcnt")
					FItemList(i).FEvaluate		= rsCTget("evaluate")
					FItemList(i).FCateName		= rsCTget("code_nm")
					If Cstr(rsCTget("catecode")) <> "0" Then
						FItemList(i).FDisp		= Cstr(rsCTget("catecode"))
					End If

					FItemList(i).FSellCash = rsCTget("sellcash")
					FItemList(i).FOrgPrice = rsCTget("orgprice")
					FItemList(i).FSellyn = rsCTget("sellyn")
					FItemList(i).FSaleyn = rsCTget("sailyn")
					FItemList(i).FLimityn = rsCTget("limityn")
					FItemList(i).FItemcouponyn = rsCTget("itemcouponyn")
					FItemList(i).FItemCouponValue = rsCTget("itemCouponValue")
					FItemList(i).FItemCouponType = rsCTget("itemCouponType")
					FItemList(i).FMyCount = rsCTget("mycount")
					FItemList(i).FAdultType = rsCTget("adultType")
					FItemList(i).FItemOptCount  = rsCTget("optioncnt")

					i=i+1
					rsCTget.moveNext
				loop
			end if
			rsCTget.close
		End If
	End Function

    '''장바구니용 popular 리스트 5 :: 비회원인경우
	public Sub getBaguniPopularList5()
		dim sqlStr, i
		sqlStr = "exec [db_my10x10].[dbo].sp_Ten_New_PopularlistBguniTop5 "

        rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic

		rsget.Open sqlStr,dbget,1


		FResultCount = rsget.RecordCount
        IF (FResultCount<1) then FResultCount=0
        FTotalCount = FResultCount
		redim preserve FItemList(FResultCount)
		i=0
		if  not rsget.EOF  then
			do until rsget.eof
				set FItemList(i)          = new CCategoryPrdItem

				FItemList(i).FItemID        = rsget("itemid")
				FItemList(i).FItemName      = db2html(rsget("itemname"))
				FItemList(i).Fmakerid       = rsget("makerid")
				FItemList(i).FBrandName     = db2html(rsget("brandname"))

				FItemList(i).FSellcash      = rsget("sellcash")
				FItemList(i).Fitemgubun     = rsget("itemgubun")
				FItemList(i).FImageList     = "http://webimage.10x10.co.kr/image/list/" + GetImageSubFolderByItemid(FItemList(i).FItemID) + "/" + rsget("listimage")
				FItemList(i).FImageSmall    = "http://webimage.10x10.co.kr/image/small/" + GetImageSubFolderByItemid(FItemList(i).FItemID) + "/" + rsget("smallimage")
				FItemList(i).FImageList120  = "http://webimage.10x10.co.kr/image/list120/" + GetImageSubFolderByItemid(FItemList(i).FItemID) + "/" + rsget("listimage120")
				FItemList(i).FImageIcon1	= "http://webimage.10x10.co.kr/image/icon1/" + GetImageSubFolderByItemid(FItemList(i).FItemID) + "/" + rsget("icon1Image")

				''품절된 상품중 이미지 없는것들 있음..
				if IsNULL(FItemList(i).FImageList120) then
				    FItemList(i).FImageList120 = FItemList(i).FImageList
				elseif (rsget("listimage120")="") then
				    FItemList(i).FImageList120 = FItemList(i).FImageList
				end if

				FItemList(i).FSellYn    = rsget("sellyn")
				FItemList(i).FLimitYn   = rsget("limityn")
				FItemList(i).FLimitNo   = rsget("limitno")
				FItemList(i).FLimitSold = rsget("limitsold")
				FItemList(i).FOptioncnt	= rsget("optioncnt")
                FItemList(i).FItemDiv 	= rsget("itemdiv")		'상품 속성

				FItemList(i).FSaleYn        = rsget("sailyn")
				''FItemList(i).FSalePrice     = rsget("sailprice")
				FItemList(i).FOrgPrice      = rsget("orgprice")
				FItemList(i).FSpecialUserItem   = rsget("specialuseritem")

				FItemList(i).Fitemcouponyn 		= rsget("itemcouponyn")
				FItemList(i).Fitemcoupontype 	= rsget("itemcoupontype")
				FItemList(i).Fitemcouponvalue 	= rsget("itemcouponvalue")
				FItemList(i).Fcurritemcouponidx = rsget("curritemcouponidx")

				FItemList(i).FRegdate           = rsget("itemregdate")
				FItemList(i).Fevalcnt           = rsget("evalcnt")
				FItemList(i).Fdeliverytype      = rsget("deliverytype")
				FItemList(i).FfavCount          = rsget("favcount")             ''2013/09/추가
				i=i+1
				rsget.moveNext
			loop
		end if

		rsget.Close
	end Sub

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

function getmyfavoriteitem(userid)
dim sql

sql = "select count(itemid) as cnt" +vbcrlf
sql = sql & " from db_my10x10.dbo.tbl_myfavorite_folder a" +vbcrlf
sql = sql & " join db_my10x10.dbo.tbl_myfavorite b" +vbcrlf
sql = sql & " on a.fidx = b.fidx" +vbcrlf
sql = sql & " where b.fidx <> 0 and b.userid = '"&userid&"' and a.viewisusing='Y'" +vbcrlf

'response.write sql &"<br>"
rsget.open sql,dbget,1
	if not(rsget.bof or rsget.eof) then
		getmyfavoriteitem = rsget("cnt")
	else
		getmyfavoriteitem = 0
	end if
rsget.close()

end function

'// 공개된 폴더 주인ID 및 이름 반환
Sub getFavoriteOpenFolder(fid, byRef userid, byRef username)
	dim sql

	sql = "select F.userid, U.username " +vbcrlf
	sql = sql & " from db_my10x10.dbo.tbl_myfavorite_folder as F " +vbcrlf
	sql = sql & "	join db_user.dbo.tbl_user_n as U " +vbcrlf
	sql = sql & "		on F.userid=U.userid " +vbcrlf
	sql = sql & " where F.fidx='" & fid & "' and F.viewisusing='Y'" +vbcrlf

	rsget.open sql,dbget,1
		if not(rsget.bof or rsget.eof) then
			userid = rsget("userid")
			username = rsget("username")
		else
			userid = ""
			username = ""
		end if
	rsget.close()
end Sub


'// 위시액션(하루에 5개 이상담으면 쿠폰발급)
Function fnWishActionCoupon(uid)
	Dim strQuery
	strQuery ="[db_event].[dbo].sp_Ten_event_WishAction_coupon ('"&uid&"')"
	rsget.Open strQuery, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
		IF Not (rsget.EOF OR rsget.BOF) THEN
			fnWishActionCoupon = rsget(0)
		ELSE
			fnWishActionCoupon = null
		END If
	rsget.close
End Function

%>