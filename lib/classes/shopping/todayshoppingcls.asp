<%
'' Require iteminfoCls.asp

Class CTodayShoppingCateCnt
    public FCDL
    public FCount

    Private Sub Class_Initialize()

	End Sub

    Private Sub Class_Terminate()

	End Sub
end Class

class CTodayShopping
    public FItemList()
    public FOneItem

	public FResultCount
	public FPageSize
	public FCurrpage
	public FTotalCount
	public FTotalPage
	public FScrollCount

    public FRectUserID
    public FRectCDL
	public FRectOrderType
	public FRectSortMethod
	public FRectSellYN
	public FRectDisp

	public function GetCommaDelimArr()
	    dim todayitemlistArr
        '' .js에서 Maxmum count 설정되어 있음. , (0) may be ''
        todayitemlistArr = Trim(request.cookies("todayviewitemidlist"))

        if (Left(todayitemlistArr,1)="|") then todayitemlistArr=Mid(todayitemlistArr,2,1024)

        if (Right(todayitemlistArr,1)="|") then todayitemlistArr=Left(todayitemlistArr,Len(todayitemlistArr)-1)

        todayitemlistArr = Replace(todayitemlistArr,"|",",")

	    GetCommaDelimArr = todayitemlistArr
    end function

	public function GetCateViewCount(iCdL)
	    GetCateViewCount = 0
	    '' Using Only CTodayShoppingCateCnt
        dim i

        GetCateViewCount = 0

        for i=0 to FResultCount-1
            if (FItemList(i).FCDL=iCdL) then
                GetCateViewCount = FItemList(i).FCount
                Exit function
            end if
        next
    end function


	public Sub getMyTodayViewCateCount()
	    dim sqlStr, todayitemlistArr

	    todayitemlistArr = GetCommaDelimArr

        if (todayitemlistArr="") then Exit Sub

        sqlStr = "select cate_large, count(itemid) as cnt"
        sqlStr = sqlStr + " from [db_item].[dbo].tbl_item"
        sqlStr = sqlStr + " where itemid in (" & todayitemlistArr & ")"
        sqlStr = sqlStr + " group by cate_large"

        rsget.Open sqlStr,dbget,1

		FTotalCount  = 0
		FResultCount = rsget.RecordCount

		if (FResultCount<1) then FResultCount=0

		redim preserve FItemList(FResultCount)

		if Not rsget.Eof then
		    do until rsget.eof
				set FItemList(i)    = new CTodayShoppingCateCnt
    		    FItemList(i).FCDL   = rsget("cate_large")
    		    FItemList(i).FCount = rsget("cnt")

    		    FTotalCount         = FTotalCount + FItemList(i).FCount
    		    i=i+1
    		    rsget.MoveNext
    		loop
		end if
		rsget.close

	end Sub

    public Sub getMyTodayMainViewList()
        dim sqlStr, i
'		FResultCount = 3 'top 3개 고정

        sqlStr = " Select top 3 * From "
        sqlStr = sqlStr + " ( "
        sqlStr = sqlStr + " 	select max(L.idx) as idx, i.cate_large, i.cate_mid, i.cate_small "
        sqlStr = sqlStr + " 		,i.itemid, i.itemname, i.sellcash, i.sellyn, i.limityn, i.limitno, i.limitsold "
        sqlStr = sqlStr + " 		,i.itemgubun, i.deliverytype, i.evalcnt, i.itemcouponyn, i.itemcoupontype, i.itemcouponvalue,i.curritemcouponidx "
        sqlStr = sqlStr + " 		,i.basicimage, i.smallimage, i.listimage, i.listimage120, i.icon1image, i.icon2image, (Case When isNull(i.frontMakerid,'')='' then i.makerid else i.frontMakerid end) as makerid, i.brandname, i.regdate, i.sailyn, i.sailprice "
        sqlStr = sqlStr + " 		,i.orgprice, i.specialuseritem, i.optioncnt, i.itemdiv "
        sqlStr = sqlStr + " 	From db_evt.[dbo].[tbl_itemevent_userLogData_FrontRecent] L "
        sqlStr = sqlStr + " 	inner join db_analyze_data_raw.dbo.tbl_item i on L.itemid = i.itemid "
        sqlStr = sqlStr + " 	Where L.type='item' And L.userid='"&FRectUserID&"' "
        sqlStr = sqlStr + " 	group by i.cate_large, i.cate_mid, i.cate_small "
        sqlStr = sqlStr + " 		,i.itemid, i.itemname, i.sellcash, i.sellyn, i.limityn, i.limitno, i.limitsold "
        sqlStr = sqlStr + " 		,i.itemgubun, i.deliverytype, i.evalcnt, i.itemcouponyn, i.itemcoupontype, i.itemcouponvalue,i.curritemcouponidx "
        sqlStr = sqlStr + " 		,i.basicimage, i.smallimage, i.listimage, i.listimage120, i.icon1image, i.icon2image, (Case When isNull(i.frontMakerid,'')='' then i.makerid else i.frontMakerid end), i.brandname, i.regdate, i.sailyn, i.sailprice "
        sqlStr = sqlStr + " 		,i.orgprice, i.specialuseritem, i.evalcnt, i.optioncnt, i.itemdiv "
        sqlStr = sqlStr + " )AA Where itemid is not null "
'============조건분기====================                  
        if FRectSellYN = "Y" Then
        	sqlStr = sqlStr + " and AA.sellyn = 'Y'"
        End IF

        sqlStr = sqlStr + " order by idx desc "
'============조건분기====================                 
        
        rsEVTget.Open sqlStr, dbEVTget, 1
		FResultCount = rsEVTget.RecordCount
        if (FResultCount<1) then FResultCount=0

        redim preserve FItemList(FResultCount)
		i=0
		if Not rsEVTget.Eof then
			rsEVTget.absolutepage = FCurrPage
			do until rsEVTget.eof
				set FItemList(i) = new CCategoryPrdItem

				FItemList(i).FItemID       = rsEVTget("itemid")
				FItemList(i).FItemName     = db2html(rsEVTget("itemname"))
				FItemList(i).FItemDiv 	= rsEVTget("itemdiv")		'상품 속성

				FItemList(i).FSellcash     = rsEVTget("sellcash")
				FItemList(i).FSellYn       = rsEVTget("sellyn")
				FItemList(i).FLimitYn      = rsEVTget("limityn")
				FItemList(i).FLimitNo      = rsEVTget("limitno")
				FItemList(i).FLimitSold    = rsEVTget("limitsold")
				FItemList(i).Fitemgubun    = rsEVTget("itemgubun")
				FItemList(i).FDeliverytype = rsEVTget("deliverytype")

				FItemList(i).Fevalcnt       = rsEVTget("evalcnt")
				FItemList(i).Fitemcouponyn  = rsEVTget("itemcouponyn")
				FItemList(i).Fitemcoupontype 	= rsEVTget("itemcoupontype")
				FItemList(i).Fitemcouponvalue 	= rsEVTget("itemcouponvalue")
				FItemList(i).Fcurritemcouponidx = rsEVTget("curritemcouponidx")
				
				If FItemList(i).FItemDiv="21" Then
					if instr(rsEVTget("basicimage"),"/") > 0 then
						FItemList(i).FImageBasic = "http://webimage.10x10.co.kr/image/basic/" + rsEVTget("basicimage")
					Else
						FItemList(i).FImageBasic = "http://webimage.10x10.co.kr/image/basic/" + GetImageSubFolderByItemid(FItemList(i).FItemID) + "/" + rsEVTget("basicimage")
					End If
				Else
				FItemList(i).FImageBasic = "http://webimage.10x10.co.kr/image/basic/" + GetImageSubFolderByItemid(FItemList(i).FItemID) + "/" + rsEVTget("basicimage")
				End If
				FItemList(i).FImageSmall = "http://webimage.10x10.co.kr/image/small/" + GetImageSubFolderByItemid(FItemList(i).FItemID) + "/" + rsEVTget("smallimage")
				FItemList(i).FImageList = "http://webimage.10x10.co.kr/image/list/" + GetImageSubFolderByItemid(FItemList(i).FItemID) + "/" + rsEVTget("listimage")
				FItemList(i).FImageList120 = "http://webimage.10x10.co.kr/image/list120/" + GetImageSubFolderByItemid(FItemList(i).FItemid) + "/" + rsEVTget("listimage120")				
				FItemList(i).FImageicon2 = "http://webimage.10x10.co.kr/image/icon2/" + GetImageSubFolderByItemid(FItemList(i).FItemid) + "/" + rsEVTget("icon2image")

				FItemList(i).FMakerID   = rsEVTget("makerid")
				FItemList(i).FBrandName = db2html(rsEVTget("brandname"))
				FItemList(i).FRegdate   = rsEVTget("regdate")

				FItemList(i).FSaleYn    = rsEVTget("sailyn")				
				FItemList(i).FOrgPrice   = rsEVTget("orgprice")
				FItemList(i).FSpecialuseritem = rsEVTget("specialuseritem")
				FItemList(i).Fevalcnt = rsEVTget("evalcnt")
				FItemList(i).FOptioncnt	= rsEVTget("optioncnt")
				rsEVTget.movenext
				i=i+1
			loop
		end if
		rsEVTget.close
    end Sub

	'사용안함
    public Sub getMyTodayViewList()
        dim sqlStr, todayitemlistArr, i

        todayitemlistArr = GetCommaDelimArr

        if (todayitemlistArr="") then Exit Sub

        sqlStr = "select count(i.itemid) as cnt "
        sqlStr = sqlStr + " from [db_item].[dbo].tbl_item as i"
        sqlStr = sqlStr + " where i.itemid in (" & todayitemlistArr & ")"
        if (FRectDisp<>"") then
            sqlStr = sqlStr + " and i.dispcate1 = '" & FRectDisp & "'"
        end if
        if FRectSellYN = "Y" Then
        	sqlStr = sqlStr + " and i.sellyn = 'Y'"
        End IF

        if (FRectSortMethod="saleop") then
            sqlStr = sqlStr + " and i.sailyn='Y'"
        elseif (FRectSortMethod="coupon") then
            sqlStr = sqlStr + " and i.itemcouponyn='Y'"
        elseif (FRectSortMethod="newitem") then
            sqlStr = sqlStr + " and datediff(day,i.regdate,getdate())<=14"
        elseif (FRectSortMethod="limit") then
            sqlStr = sqlStr + " and i.limityn='Y'"
        end if

        rsget.Open sqlStr,dbget,1
			FTotalCount = rsget("cnt")
		rsget.close


        sqlStr = "select top " & CStr(FPageSize*FCurrPage) & " i.cate_large, i.cate_mid, i.cate_small"
        sqlStr = sqlStr + " ,i.itemid, i.itemname, i.sellcash, i.sellyn, i.limityn, i.limitno, i.limitsold"
        sqlStr = sqlStr + " ,i.itemgubun, i.deliverytype, i.evalcnt, i.itemcouponyn, i.itemcoupontype, i.itemcouponvalue,i.curritemcouponidx"
        sqlStr = sqlStr + " ,i.basicimage, i.smallimage, i.listimage, i.listimage120, i.icon1image, i.icon2image, (Case When isNull(i.frontMakerid,'')='' then i.makerid else i.frontMakerid end) as makerid, i.brandname, i.regdate, i.sailyn, i.sailprice"
        sqlStr = sqlStr + " ,i.orgprice, i.specialuseritem, i.evalcnt, i.optioncnt, i.itemdiv"
        sqlStr = sqlStr + " from [db_item].[dbo].tbl_item as i"
        sqlStr = sqlStr + " where i.itemid in (" & todayitemlistArr & ")"
        if (FRectDisp<>"") then
            sqlStr = sqlStr + " and i.dispcate1 = '" & FRectDisp & "'"
        end if
        if FRectSellYN = "Y" Then
        	sqlStr = sqlStr + " and i.sellyn = 'Y'"
        End IF

        if (FRectSortMethod="saleop") then
            sqlStr = sqlStr + " and i.sailyn='Y'"
        elseif (FRectSortMethod="coupon") then
            sqlStr = sqlStr + " and i.itemcouponyn='Y'"
        elseif (FRectSortMethod="newitem") then
            sqlStr = sqlStr + " and datediff(day,i.regdate,getdate())<=14"
        elseif (FRectSortMethod="limit") then
            sqlStr = sqlStr + " and i.limityn='Y'"
        end if

        if FRectOrderType="fav" then
            sqlStr = sqlStr + " order by i.itemscore desc, i.itemid desc"
        elseif (FRectOrderType="highprice") then
            sqlStr = sqlStr + " order by i.sellcash desc"
        elseif (FRectOrderType="lowprice") then
            sqlStr = sqlStr + " order by i.sellcash asc"
        else
            sqlStr = sqlStr + " order by i.itemid desc"
        end if

        rsget.pagesize = FPageSize
        rsget.Open sqlStr, dbget, 1

        FtotalPage =  CInt(FTotalCount\FPageSize)
		if  (FTotalCount\FPageSize)<>(FTotalCount/FPageSize) then
			FtotalPage = FtotalPage +1
		end if
		FResultCount = rsget.RecordCount-(FPageSize*(FCurrPage-1))

        if (FResultCount<1) then FResultCount=0

        redim preserve FItemList(FResultCount)
		i=0
		if Not rsget.Eof then
			rsget.absolutepage = FCurrPage
			do until rsget.eof
				set FItemList(i) = new CCategoryPrdItem

				''카테고리 변경(참조 : db_item.dbo.tbl_display_cate_item)
				''FItemList(i).FcdL          = rsget("cate_large")
				''FItemList(i).FcdM          = rsget("cate_mid")
				''FItemList(i).FcdS          = rsget("cate_small")

				FItemList(i).FItemID       = rsget("itemid")
				FItemList(i).FItemName     = db2html(rsget("itemname"))
				FItemList(i).FItemDiv 	= rsget("itemdiv")		'상품 속성

				FItemList(i).FSellcash     = rsget("sellcash")
				FItemList(i).FSellYn       = rsget("sellyn")
				FItemList(i).FLimitYn      = rsget("limityn")
				FItemList(i).FLimitNo      = rsget("limitno")
				FItemList(i).FLimitSold    = rsget("limitsold")
				FItemList(i).Fitemgubun    = rsget("itemgubun")
				FItemList(i).FDeliverytype = rsget("deliverytype")

				FItemList(i).Fevalcnt       = rsget("evalcnt")
				FItemList(i).Fitemcouponyn  = rsget("itemcouponyn")
				FItemList(i).Fitemcoupontype 	= rsget("itemcoupontype")
				FItemList(i).Fitemcouponvalue 	= rsget("itemcouponvalue")
				FItemList(i).Fcurritemcouponidx = rsget("curritemcouponidx")
				
				If FItemList(i).FItemDiv="21" Then
					if instr(rsget("basicimage"),"/") > 0 then
						FItemList(i).FImageBasic = "http://webimage.10x10.co.kr/image/basic/" + rsget("basicimage")
					Else
						FItemList(i).FImageBasic = "http://webimage.10x10.co.kr/image/basic/" + GetImageSubFolderByItemid(FItemList(i).FItemID) + "/" + rsget("basicimage")
					End If
				Else
					FItemList(i).FImageBasic = "http://webimage.10x10.co.kr/image/basic/" + GetImageSubFolderByItemid(FItemList(i).FItemID) + "/" + rsget("basicimage")
				End If
				FItemList(i).FImageSmall = "http://webimage.10x10.co.kr/image/small/" + GetImageSubFolderByItemid(FItemList(i).FItemID) + "/" + rsget("smallimage")
				FItemList(i).FImageList = "http://webimage.10x10.co.kr/image/list/" + GetImageSubFolderByItemid(FItemList(i).FItemID) + "/" + rsget("listimage")
				FItemList(i).FImageList120 = "http://webimage.10x10.co.kr/image/list120/" + GetImageSubFolderByItemid(FItemList(i).FItemid) + "/" + rsget("listimage120")
				''FItemList(i).FImageicon1 = "http://webimage.10x10.co.kr/image/icon1/" + GetImageSubFolderByItemid(FItemList(i).FItemid) + "/" + rsget("icon1image")
				FItemList(i).FImageicon2 = "http://webimage.10x10.co.kr/image/icon2/" + GetImageSubFolderByItemid(FItemList(i).FItemid) + "/" + rsget("icon2image")

				FItemList(i).FMakerID   = rsget("makerid")
				FItemList(i).FBrandName = db2html(rsget("brandname"))
				FItemList(i).FRegdate   = rsget("regdate")

				FItemList(i).FSaleYn    = rsget("sailyn")
				'FItemList(i).FSalePrice = rsget("sailprice")
				FItemList(i).FOrgPrice   = rsget("orgprice")
				FItemList(i).FSpecialuseritem = rsget("specialuseritem")
				FItemList(i).Fevalcnt = rsget("evalcnt")
				FItemList(i).FOptioncnt	= rsget("optioncnt")
				rsget.movenext
				i=i+1
			loop
		end if
		rsget.close
    end Sub

    public Sub getMyTodayViewListNew()
        dim sqlStr, i

        sqlStr = " Select count(itemid) as cnt From "
        sqlStr = sqlStr + " ( "
        sqlStr = sqlStr + " 	select i.cate_large, i.cate_mid, i.cate_small "
        sqlStr = sqlStr + " 		,i.itemid, i.itemname, i.sellcash, i.sellyn, i.limityn, i.limitno, i.limitsold "
        sqlStr = sqlStr + " 		,i.itemgubun, i.deliverytype, i.evalcnt, i.itemcouponyn, i.itemcoupontype, i.itemcouponvalue,i.curritemcouponidx "
        sqlStr = sqlStr + " 		,i.basicimage, i.smallimage, i.listimage, i.listimage120, i.icon1image, i.icon2image, (Case When isNull(i.frontMakerid,'')='' then i.makerid else i.frontMakerid end) as makerid, i.brandname, i.regdate, i.sailyn, i.sailprice "
        sqlStr = sqlStr + " 		,i.orgprice, i.specialuseritem, i.optioncnt, i.itemdiv, i.dispcate1 "
        sqlStr = sqlStr + " 	From db_evt.[dbo].[tbl_itemevent_userLogData_FrontRecent] L "
        sqlStr = sqlStr + " 	inner join db_analyze_data_raw.dbo.tbl_item i on L.itemid = i.itemid "
        sqlStr = sqlStr + " 	Where L.type='item' And L.userid='"&FRectUserID&"' "
        sqlStr = sqlStr + " 	group by i.cate_large, i.cate_mid, i.cate_small "
        sqlStr = sqlStr + " 		,i.itemid, i.itemname, i.sellcash, i.sellyn, i.limityn, i.limitno, i.limitsold "
        sqlStr = sqlStr + " 		,i.itemgubun, i.deliverytype, i.evalcnt, i.itemcouponyn, i.itemcoupontype, i.itemcouponvalue,i.curritemcouponidx "
        sqlStr = sqlStr + " 		,i.basicimage, i.smallimage, i.listimage, i.listimage120, i.icon1image, i.icon2image, (Case When isNull(i.frontMakerid,'')='' then i.makerid else i.frontMakerid end), i.brandname, i.regdate, i.sailyn, i.sailprice "
        sqlStr = sqlStr + " 		,i.orgprice, i.specialuseritem, i.evalcnt, i.optioncnt, i.itemdiv, i.dispcate1 "
        sqlStr = sqlStr + " )AA Where itemid is not null "

		if (FRectDisp<>"") then
            sqlStr = sqlStr + " and dispcate1 = '" & FRectDisp & "'"
        end if
        if FRectSellYN = "Y" Then
        	sqlStr = sqlStr + " and sellyn = 'Y'"
        End IF

        'if (FRectSortMethod="saleop") then
        '    sqlStr = sqlStr + " and i.sailyn='Y'"
        'elseif (FRectSortMethod="coupon") then
        '    sqlStr = sqlStr + " and i.itemcouponyn='Y'"
        'elseif (FRectSortMethod="newitem") then
        '    sqlStr = sqlStr + " and datediff(day,i.regdate,getdate())<=14"
        'elseif (FRectSortMethod="limit") then
        '    sqlStr = sqlStr + " and i.limityn='Y'"
        'end if

        rsEVTget.Open sqlStr,dbEVTget,1
			FTotalCount = rsEVTget("cnt")
		rsEVTget.close

        sqlStr = " Select top " & CStr(FPageSize*FCurrPage) & " * From "
        sqlStr = sqlStr + " ( "
        sqlStr = sqlStr + " 	select max(L.idx) as idx, i.cate_large, i.cate_mid, i.cate_small "
        sqlStr = sqlStr + " 		,i.itemid, i.itemname, i.sellcash, i.sellyn, i.limityn, i.limitno, i.limitsold "
        sqlStr = sqlStr + " 		,i.itemgubun, i.deliverytype, i.evalcnt, i.itemcouponyn, i.itemcoupontype, i.itemcouponvalue,i.curritemcouponidx "
        sqlStr = sqlStr + " 		,i.basicimage, i.smallimage, i.listimage, i.listimage120, i.icon1image, i.icon2image, (Case When isNull(i.frontMakerid,'')='' then i.makerid else i.frontMakerid end) as makerid, i.brandname, i.regdate, i.sailyn, i.sailprice "
        sqlStr = sqlStr + " 		,i.orgprice, i.specialuseritem, i.optioncnt, i.itemdiv, i.dispcate1 "
        sqlStr = sqlStr + " 	From db_evt.[dbo].[tbl_itemevent_userLogData_FrontRecent] L "
        sqlStr = sqlStr + " 	inner join db_analyze_data_raw.dbo.tbl_item i on L.itemid = i.itemid "
        sqlStr = sqlStr + " 	Where L.type='item' And L.userid='"&FRectUserID&"' "
        sqlStr = sqlStr + " 	group by i.cate_large, i.cate_mid, i.cate_small "
        sqlStr = sqlStr + " 		,i.itemid, i.itemname, i.sellcash, i.sellyn, i.limityn, i.limitno, i.limitsold "
        sqlStr = sqlStr + " 		,i.itemgubun, i.deliverytype, i.evalcnt, i.itemcouponyn, i.itemcoupontype, i.itemcouponvalue,i.curritemcouponidx "
        sqlStr = sqlStr + " 		,i.basicimage, i.smallimage, i.listimage, i.listimage120, i.icon1image, i.icon2image, (Case When isNull(i.frontMakerid,'')='' then i.makerid else i.frontMakerid end), i.brandname, i.regdate, i.sailyn, i.sailprice "
        sqlStr = sqlStr + " 		,i.orgprice, i.specialuseritem, i.evalcnt, i.optioncnt, i.itemdiv, i.dispcate1 "
        sqlStr = sqlStr + " )AA Where itemid is not null "

        if (FRectDisp<>"") then
            sqlStr = sqlStr + " and dispcate1 = '" & FRectDisp & "'"
        end if
        if FRectSellYN = "Y" Then
        	sqlStr = sqlStr + " and sellyn = 'Y'"
        End If
		sqlStr = sqlStr + " order by idx desc "

        'if (FRectSortMethod="saleop") then
        '    sqlStr = sqlStr + " and i.sailyn='Y'"
        'elseif (FRectSortMethod="coupon") then
        '    sqlStr = sqlStr + " and i.itemcouponyn='Y'"
        'elseif (FRectSortMethod="newitem") then
        '    sqlStr = sqlStr + " and datediff(day,i.regdate,getdate())<=14"
        'elseif (FRectSortMethod="limit") then
        '    sqlStr = sqlStr + " and i.limityn='Y'"
        'end if

        'if FRectOrderType="fav" then
        '    sqlStr = sqlStr + " order by i.itemscore desc, i.itemid desc"
        'elseif (FRectOrderType="highprice") then
        '    sqlStr = sqlStr + " order by i.sellcash desc"
        'elseif (FRectOrderType="lowprice") then
        '    sqlStr = sqlStr + " order by i.sellcash asc"
        'else
        '    sqlStr = sqlStr + " order by i.itemid desc"
        'end if

        rsEVTget.pagesize = FPageSize
        rsEVTget.Open sqlStr, dbEVTget, 1

        FtotalPage =  CInt(FTotalCount\FPageSize)
		if  (FTotalCount\FPageSize)<>(FTotalCount/FPageSize) then
			FtotalPage = FtotalPage +1
		end if
		FResultCount = rsEVTget.RecordCount-(FPageSize*(FCurrPage-1))

        if (FResultCount<1) then FResultCount=0

        redim preserve FItemList(FResultCount)
		i=0
		if Not rsEVTget.Eof then
			rsEVTget.absolutepage = FCurrPage
			do until rsEVTget.eof
				set FItemList(i) = new CCategoryPrdItem

				''카테고리 변경(참조 : db_item.dbo.tbl_display_cate_item)
				''FItemList(i).FcdL          = rsget("cate_large")
				''FItemList(i).FcdM          = rsget("cate_mid")
				''FItemList(i).FcdS          = rsget("cate_small")

				FItemList(i).FItemID       = rsEVTget("itemid")
				FItemList(i).FItemName     = db2html(rsEVTget("itemname"))
				FItemList(i).FItemDiv 	= rsEVTget("itemdiv")		'상품 속성

				FItemList(i).FSellcash     = rsEVTget("sellcash")
				FItemList(i).FSellYn       = rsEVTget("sellyn")
				FItemList(i).FLimitYn      = rsEVTget("limityn")
				FItemList(i).FLimitNo      = rsEVTget("limitno")
				FItemList(i).FLimitSold    = rsEVTget("limitsold")
				FItemList(i).Fitemgubun    = rsEVTget("itemgubun")
				FItemList(i).FDeliverytype = rsEVTget("deliverytype")

				FItemList(i).Fevalcnt       = rsEVTget("evalcnt")
				FItemList(i).Fitemcouponyn  = rsEVTget("itemcouponyn")
				FItemList(i).Fitemcoupontype 	= rsEVTget("itemcoupontype")
				FItemList(i).Fitemcouponvalue 	= rsEVTget("itemcouponvalue")
				FItemList(i).Fcurritemcouponidx = rsEVTget("curritemcouponidx")

				FItemList(i).FImageBasic = "http://webimage.10x10.co.kr/image/basic/" + GetImageSubFolderByItemid(FItemList(i).FItemID) + "/" + rsEVTget("basicimage")
				FItemList(i).FImageSmall = "http://webimage.10x10.co.kr/image/small/" + GetImageSubFolderByItemid(FItemList(i).FItemID) + "/" + rsEVTget("smallimage")
				FItemList(i).FImageList = "http://webimage.10x10.co.kr/image/list/" + GetImageSubFolderByItemid(FItemList(i).FItemID) + "/" + rsEVTget("listimage")
				FItemList(i).FImageList120 = "http://webimage.10x10.co.kr/image/list120/" + GetImageSubFolderByItemid(FItemList(i).FItemid) + "/" + rsEVTget("listimage120")
				''FItemList(i).FImageicon1 = "http://webimage.10x10.co.kr/image/icon1/" + GetImageSubFolderByItemid(FItemList(i).FItemid) + "/" + rsEVTget("icon1image")
				
				If FItemList(i).FItemDiv="21" Then
					if instr(rsEVTget("icon2image"),"/") > 0 then
						FItemList(i).FImageicon2 = "http://webimage.10x10.co.kr/image/icon2/" + rsEVTget("icon2image")
					Else
						FItemList(i).FImageicon2 = "http://webimage.10x10.co.kr/image/icon2/" + GetImageSubFolderByItemid(FItemList(i).FItemid) + "/" + rsEVTget("icon2image")
					End If
				Else
					FItemList(i).FImageicon2 = "http://webimage.10x10.co.kr/image/icon2/" + GetImageSubFolderByItemid(FItemList(i).FItemid) + "/" + rsEVTget("icon2image")
				End If
				FItemList(i).FMakerID   = rsEVTget("makerid")
				FItemList(i).FBrandName = db2html(rsEVTget("brandname"))
				FItemList(i).FRegdate   = rsEVTget("regdate")

				FItemList(i).FSaleYn    = rsEVTget("sailyn")
				'FItemList(i).FSalePrice = rsEVTget("sailprice")
				FItemList(i).FOrgPrice   = rsEVTget("orgprice")
				FItemList(i).FSpecialuseritem = rsEVTget("specialuseritem")
				FItemList(i).Fevalcnt = rsEVTget("evalcnt")
				FItemList(i).FOptioncnt	= rsEVTget("optioncnt")
				rsEVTget.movenext
				i=i+1
			loop
		end if
		rsEVTget.close
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

	Private Sub Class_Initialize()
		redim preserve FItemList(0)
		FResultCount  = 0
		FTotalCount = 0
		FPageSize = 12
		FCurrpage = 1
		FScrollCount = 10
	End Sub


    Private Sub Class_Terminate()

	End Sub

end Class

%>