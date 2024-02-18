<%
Class CMyOrderItem
	public FItemList()

	public FResultCount
	public FPageSize
	public FCurrpage
	public FTotalCount
	public FTotalPage
	public FScrollCount

	public FRectUserID
	public FRectSortMethod
	public FRectDisp
    
    '// 내 주문 상품 목록 접수
    public Sub getMyOrderItemList()
        dim sqlStr, i
        
    'response.end
    
        sqlStr = "exec db_order.dbo.sp_Ten_MyOrderItemList_CNT_2015 '"&FRectUserID&"','"&FRectDisp&"'"
        rsget.CursorLocation = adUseClient
        rsget.Open sqlStr, dbget, adOpenForwardOnly, adLockReadOnly
        
        IF Not (rsget.EOF OR rsget.BOF) THEN
			FTotalCount = rsget("CNT")
		end if
		rsget.Close

        if (FTotalCount<1) then
            FtotalPage = 0
            Exit Sub
        end if
        
        sqlStr = "exec db_order.dbo.sp_Ten_MyOrderItemList_LIST_2015 '"&FRectUserID&"','"&FRectDisp&"',"&FPageSize&","&FCurrPage&",'"&FRectSortMethod&"'"
        rsget.CursorLocation = adUseClient
        rsget.Open sqlStr, dbget, adOpenForwardOnly, adLockReadOnly

        
        FtotalPage =  CInt(FTotalCount\FPageSize)
		if  (FTotalCount\FPageSize)<>(FTotalCount/FPageSize) then
			FtotalPage = FtotalPage +1
		end if
		FResultCount = rsget.RecordCount

		if (FResultCount<1) then FResultCount=0

		redim preserve FitemList(FResultCount)
		i=0
		if Not(rsget.EOF or rsget.BOF) then
			do until rsget.eof
				set FItemList(i) = new CCategoryPrdItem

				FItemList(i).FItemID       = rsget("itemid")
				FItemList(i).FItemName     = db2html(rsget("itemname"))
				FItemList(i).FItemDiv 	    = rsget("oitemdiv")		'상품 속성

				FItemList(i).FSellcash     = rsget("reducedprice")
				FItemList(i).FSellYn       = rsget("sellyn")
				FItemList(i).FLimitYn      = rsget("limityn")
				FItemList(i).FLimitNo      = rsget("limitno")
				FItemList(i).FLimitSold    = rsget("limitsold")
				'FItemList(i).Fitemgubun    = rsget("itemgubun")
				FItemList(i).FDeliverytype = rsget("odlvtype") 'rsget("deliverytype")

				FItemList(i).Fevalcnt       = rsget("evalcnt")
				'FItemList(i).Fitemcouponyn  = rsget("itemcouponyn")
				'FItemList(i).Fitemcoupontype 	= rsget("itemcoupontype")
				'FItemList(i).Fitemcouponvalue 	= rsget("itemcouponvalue")
				'FItemList(i).Fcurritemcouponidx = rsget("curritemcouponidx")

				FItemList(i).FImageBasic = "http://webimage.10x10.co.kr/image/basic/" + GetImageSubFolderByItemid(FItemList(i).FItemID) + "/" + rsget("basicimage")

				FItemList(i).FMakerID   = rsget("makerid")
				FItemList(i).FBrandName = db2html(rsget("brandname"))
				FItemList(i).FRegdate   = rsget("regdate")

				
				FItemList(i).FOrgPrice   = rsget("itemcostCouponNotApplied") ''rsget("orgprice")
				
				if (CLNG(FItemList(i).FOrgPrice)>CLNG(FItemList(i).FSellcash)) then
				    FItemList(i).FSaleYn = "Y"
				else
				    FItemList(i).FSaleYn = "N"
			    end if
				''FItemList(i).FSaleYn    = ''rsget("issailitem") ''rsget("sailyn")
				
				'FItemList(i).FSpecialuseritem = rsget("specialuseritem")
				FItemList(i).Fevalcnt = rsget("evalcnt")
				FItemList(i).FOptioncnt	= rsget("optioncnt")
				FItemList(i).FfavCount = rsget("favcount")

				FItemList(i).Forderserial		= rsget("orderserial")
				FItemList(i).ForderDate			= rsget("orderDate")
				FItemList(i).ForderOption		= rsget("orderOption")
				FItemList(i).ForderOptionName	= rsget("orderOptionName")
				FItemList(i).ForderCnt			= rsget("ordcnt")

				rsget.movenext
				i=i+1
			loop
		end if
		rsget.close
		

	End Sub
	
	'// 내 주문 상품 목록 접수
    public Sub getMyOrderItemList_OLD()
        dim sqlStr, addSql, i
        
        if FRectUserID="" then Exit Sub
        
        addSql = "	and m.userid='" & FRectUserID & "' "
        if (FRectDisp<>"") then
            addSql = addSql & " and i.dispcate1 = '" & FRectDisp & "'"
        end if

		''sqlStr = sqlStr & "	and i.sellyn in ('Y','S') "		'현재 기준 품절 제외(X)

		'// 총 갯수 및 페이징 수
		sqlStr =	"Select Count(d.itemid), CEILING(CAST(Count(d.itemid) AS FLOAT)/" & FPageSize & ") "
		sqlStr = sqlStr & "from db_order.dbo.tbl_order_master as m "
		sqlStr = sqlStr & "	join db_order.dbo.tbl_order_detail as d "
		sqlStr = sqlStr & "		on m.orderserial=d.orderserial "
		sqlStr = sqlStr & "	join db_item.dbo.tbl_item as i "
		sqlStr = sqlStr & "		on d.itemid=i.itemid "
		sqlStr = sqlStr & "where m.ipkumdiv>3 "
		sqlStr = sqlStr & "	and m.jumundiv<>'9' "
		sqlStr = sqlStr & "	and m.cancelyn='N' "
		sqlStr = sqlStr & "	and m.sitename='10x10' "
		sqlStr = sqlStr & "	and d.cancelyn<>'Y' "
		sqlStr = sqlStr & "	and d.itemid>0 "
		sqlStr = sqlStr & "	and i.isusing='Y' " & addSql
		
		rsget.Open sqlStr,dbget,1
			FTotalCount = rsget(0)
			FtotalPage = rsget(1)
		rsget.Close

		if Cint(FtotalPage)>0 and Cint(FtotalPage)<Cint(FCurrpage) then
			FCurrpage = FtotalPage
		end if

		'// 목록 접수
		sqlStr =	"Select top " & CStr(FPageSize*FCurrpage) & " "
        sqlStr = sqlStr & " i.itemid, i.itemname, i.sellcash, i.sellyn, i.limityn, i.limitno, i.limitsold "
        sqlStr = sqlStr & " ,i.itemgubun, i.deliverytype, i.evalcnt, i.itemcouponyn, i.itemcoupontype, i.itemcouponvalue,i.curritemcouponidx "
        sqlStr = sqlStr & " ,i.basicimage, (Case When isNull(i.frontMakerid,'')='' then i.makerid else i.frontMakerid end) as makerid, i.brandname, i.regdate, i.sailyn, i.sailprice "
        sqlStr = sqlStr & " ,i.orgprice, i.specialuseritem, i.evalcnt, i.optioncnt, i.itemdiv, c.favcount "
        sqlStr = sqlStr & " ,m.orderserial, m.regdate as orderDate, d.itemoption as orderOption, d.itemoptionname as orderOptionName, g.ordcnt "
		sqlStr = sqlStr & "from db_order.dbo.tbl_order_master as m "
		sqlStr = sqlStr & "	join db_order.dbo.tbl_order_detail as d "
		sqlStr = sqlStr & "		on m.orderserial=d.orderserial "
		sqlStr = sqlStr & "	join db_item.dbo.tbl_item as i "
		sqlStr = sqlStr & "		on d.itemid=i.itemid "
		sqlStr = sqlStr & "	join db_item.dbo.tbl_item_Contents as c "
		sqlStr = sqlStr & "		on i.itemid=c.itemid "

		sqlStr = sqlStr & "	join ( "
		sqlStr = sqlStr & "		Select od.itemid, count(*) as ordcnt "
		sqlStr = sqlStr & "		from db_order.dbo.tbl_order_master as om "
		sqlStr = sqlStr & "			join db_order.dbo.tbl_order_detail as od "
		sqlStr = sqlStr & "				on om.orderserial=od.orderserial "
		sqlStr = sqlStr & "		where om.ipkumdiv>3 "
		sqlStr = sqlStr & "			and om.jumundiv<>'9' "
		sqlStr = sqlStr & "			and om.cancelyn='N' "
		sqlStr = sqlStr & "			and om.sitename='10x10' "
		sqlStr = sqlStr & "			and od.cancelyn<>'Y' "
		sqlStr = sqlStr & "			and od.itemid>0 "
		sqlStr = sqlStr & "			and om.userid='" & FRectUserID & "' "
		sqlStr = sqlStr & "		group by od.itemid "
		sqlStr = sqlStr & "	) as g "
		sqlStr = sqlStr & "		on d.itemid=g.itemid "

		sqlStr = sqlStr & "where m.ipkumdiv>3 "
		sqlStr = sqlStr & "	and m.jumundiv<>'9' "
		sqlStr = sqlStr & "	and m.cancelyn='N' "
		sqlStr = sqlStr & "	and m.sitename='10x10' "
		sqlStr = sqlStr & "	and d.cancelyn<>'Y' "
		sqlStr = sqlStr & "	and d.itemid>0 "
		sqlStr = sqlStr & "	and i.isusing='Y' " & addSql

		Select Case FRectSortMethod
			Case "reg"
				sqlStr = sqlStr & " Order by m.idx desc, i.itemid desc, d.itemoption "
			Case "best"
				sqlStr = sqlStr & " Order by i.itemscore desc, m.idx desc, i.itemid desc, d.itemoption "
			Case Else
				sqlStr = sqlStr & " Order by m.idx desc, i.itemid desc, d.itemoption "
		End Select

		rsget.pagesize = FPageSize
		rsget.Open sqlStr,dbget,1

		FResultCount = rsget.RecordCount-(FPageSize*(FCurrPage-1))
		if (FResultCount<1) then FResultCount=0

		redim preserve FitemList(FResultCount)
		i=0
		if Not(rsget.EOF or rsget.BOF) then
			rsget.absolutepage = FCurrPage
			do until rsget.eof
				set FItemList(i) = new CCategoryPrdItem

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

				FItemList(i).FImageBasic = "http://webimage.10x10.co.kr/image/basic/" + GetImageSubFolderByItemid(FItemList(i).FItemID) + "/" + rsget("basicimage")

				FItemList(i).FMakerID   = rsget("makerid")
				FItemList(i).FBrandName = db2html(rsget("brandname"))
				FItemList(i).FRegdate   = rsget("regdate")

				FItemList(i).FSaleYn    = rsget("sailyn")
				FItemList(i).FOrgPrice   = rsget("orgprice")
				FItemList(i).FSpecialuseritem = rsget("specialuseritem")
				FItemList(i).Fevalcnt = rsget("evalcnt")
				FItemList(i).FOptioncnt	= rsget("optioncnt")
				FItemList(i).FfavCount = rsget("favcount")

				FItemList(i).Forderserial		= rsget("orderserial")
				FItemList(i).ForderDate			= rsget("orderDate")
				FItemList(i).ForderOption		= rsget("orderOption")
				FItemList(i).ForderOptionName	= rsget("orderOptionName")
				FItemList(i).ForderCnt			= rsget("ordcnt")

				rsget.movenext
				i=i+1
			loop
		end if
		rsget.close
	End Sub


	'//-----------
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
End Class
%>