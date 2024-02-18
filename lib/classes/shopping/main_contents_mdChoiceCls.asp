<%
'-----------------------------------------------------------------------
' 이벤트 전역변수 선언 (2008.04.16; 허진원)
'-----------------------------------------------------------------------
 Dim staticImgUrl,uploadUrl,wwwUrl
 IF application("Svr_Info")="Dev" THEN
 	staticImgUrl	= "http://imgstatic.10x10.co.kr"	'테스트
 	uploadUrl		= "http://testimgstatic.10x10.co.kr"
 	wwwUrl			= "http://2011www.10x10.co.kr"
 ELSE
 	staticImgUrl	= "http://imgstatic.10x10.co.kr"	
 	uploadUrl		= "http://imgstatic.10x10.co.kr"
 	wwwUrl			= "http://www.10x10.co.kr"
 END IF	
'-----------------------------------------------------------------------

Class CMDChoiceItem
    public Fphotoimg
    public Flinkinfo
    public Ftextinfo
    public Flinkitemid
	public FitemName
	public FImageList
	public FImageList120
	Public FTentenImage200
	public FImageIcon1
	public FOrgprice
	public FSaleyn
	public FSellCash
	public Fitemcouponyn
	public Fitemcouponvalue
	public Fitemcoupontype
	public Fidx
	
	public Fstartdate
	public Fenddate

	'// 쿠폰 적용가
	public Function GetCouponAssignPrice() '!
		if (FItemCouponYN="Y") then
			GetCouponAssignPrice = getRealPrice - GetCouponDiscountPrice
		else
			GetCouponAssignPrice = getRealPrice
		end if
	end Function

	'// 쿠폰 할인가 '?
	public Function GetCouponDiscountPrice() 
		Select case Fitemcoupontype
			case "1" ''% 쿠폰
				GetCouponDiscountPrice = CLng(Fitemcouponvalue*getRealPrice/100)
			case "2" ''원 쿠폰
				GetCouponDiscountPrice = Fitemcouponvalue
			case "3" ''무료배송 쿠폰
			    GetCouponDiscountPrice = 0
			case else
				GetCouponDiscountPrice = 0
		end Select

	end Function

	'// 상품 할인율
	public Function getSalePro() 
		if FOrgprice=0 then
			getSalePro = 0
		else
			getSalePro = CLng((FOrgPrice-getRealPrice)/FOrgPrice*100)
		end if
	end Function

	'// 쿠폰 할인율
	public Function getCouponPro() 
		if FOrgprice=0 then
			getCouponPro = 0
		else
			getCouponPro = CLng((FOrgPrice-GetCouponAssignPrice)/FOrgPrice*100)
		end if
	end Function

	'// 상품/쿠폰 할인율
	public Function getSalePercent() 
		dim sSprc, sPer
		sSprc=0 : sPer=0

		if FOrgprice>0 then
			if FSaleyn="Y" then
				sSprc = sSprc + FOrgPrice-getRealPrice
				if Fitemcouponyn="Y" then sSprc = sSprc + GetCouponDiscountPrice
			else
				if Fitemcouponyn="Y" then sSprc = FOrgPrice-GetCouponAssignPrice
			end if
			sPer = CLng(sSprc/FOrgPrice*100)
		end if
		
		getSalePercent = sPer
	end Function

	public function getRealPrice()
		getRealPrice = FSellCash
	end function

    Private Sub Class_Initialize()

	End Sub

	Private Sub Class_Terminate()

	End Sub
end Class

Class CMDChoice
    public FItemList()

	public FPageSize
	public FResultCount
       
    public Sub GetMDChoiceList()
        dim sqlStr, i

		sqlStr = "select top " & FPageSize & " m.photoimg, m.linkinfo, m.textinfo, m.linkitemid, m.idx, "
		sqlStr = sqlStr & " i.itemid, i.itemname, i.listImage120,i.icon1Image, i.sellcash, i.orgprice, "
		sqlStr = sqlStr & " i.sailyn, i.itemcouponyn, i.itemcouponvalue, i.itemcoupontype, i.tentenimage200, m.startdate, m.enddate "
		sqlStr = sqlStr & " from [db_sitemaster].[dbo].tbl_main_mdchoice_flash as m "
		sqlStr = sqlStr & " Join [db_item].[dbo].tbl_item as i "
		sqlStr = sqlStr & "		on m.linkitemid=i.itemid "
		sqlStr = sqlStr + " where m.isusing in ('Y','M') "
		sqlStr = sqlStr + " and convert(varchar(10),m.startdate,21)<=convert(varchar(10),getdate(),21)"  ''2017/10/26 수정. by eastone, m.startdate desc
		sqlStr = sqlStr + " order by m.startdate desc, m.disporder, m.idx desc"

		rsget.Open sqlStr, dbget, 1

		FResultCount = rsget.RecordCount

		redim preserve FItemList(FResultCount)
		if  not rsget.EOF  then
		    i = 0
			do until rsget.eof
				set FItemList(i) = new CMDChoiceItem

				if Not(rsget("photoimg")="" or isNull(rsget("photoimg"))) then FItemList(i).Fphotoimg		= staticImgUrl & "/contents/maincontents/" + rsget("photoimg")
				if Not(rsget("listImage120")="" or isNull(rsget("icon1Image"))) then FItemList(i).FImageList	= "http://webimage.10x10.co.kr/image/icon1/" + GetImageSubFolderByItemid(rsget("itemid")) + "/" + rsget("icon1Image")
				FItemList(i).Flinkinfo		= db2html(rsget("linkinfo"))
				FItemList(i).Ftextinfo		= db2html(rsget("textinfo"))
				FItemList(i).Flinkitemid	= db2html(rsget("linkitemid"))
				FItemList(i).Fidx			= rsget("idx")

				FItemList(i).FitemName		= db2html(rsget("itemname"))
				FItemList(i).FOrgprice		= rsget("orgprice")
				FItemList(i).FSaleyn		= rsget("sailyn")
				FItemList(i).FSellCash		= rsget("sellcash")
				FItemList(i).Fitemcouponyn	= rsget("itemcouponyn")
				FItemList(i).Fitemcouponvalue	= rsget("itemcouponvalue")
				FItemList(i).Fitemcoupontype	= rsget("itemcoupontype")
				if Not(rsget("tentenimage200")="" or isNull(rsget("tentenimage200"))) then FItemList(i).FTentenImage200	= "http://webimage.10x10.co.kr/image/tenten200/" + GetImageSubFolderByItemid(rsget("itemid")) + "/" + rsget("tentenimage200")

				FItemList(i).Fstartdate	= rsget("startdate")
				FItemList(i).Fenddate	= rsget("enddate")

				i=i+1
				rsget.moveNext
			loop
		end if
		rsget.close
    end Sub

    public Sub GetMobileMDChoiceList()
        dim sqlStr, i

		sqlStr = "select top " & FPageSize & " m.photoimg, m.linkinfo, m.textinfo, m.linkitemid, "
		sqlStr = sqlStr & " i.itemid, i.itemname, i.listImage, i.listImage120, i.icon1Image, i.sellcash, i.orgprice, "
		sqlStr = sqlStr & " i.sailyn, i.itemcouponyn, i.itemcouponvalue, i.itemcoupontype, i.tentenimage200 "
		sqlStr = sqlStr & " from [db_sitemaster].[dbo].tbl_main_mdchoice_flash as m "
		sqlStr = sqlStr & " Join [db_item].[dbo].tbl_item as i "
		sqlStr = sqlStr & "		on m.linkitemid=i.itemid "
		sqlStr = sqlStr & " where m.isusing='M' "
		sqlStr = sqlStr & " order by m.disporder, m.idx desc"

		rsget.Open sqlStr, dbget, 1

		FResultCount = rsget.RecordCount

		redim preserve FItemList(FResultCount)
		if  not rsget.EOF  then
		    i = 0
			do until rsget.eof
				set FItemList(i) = new CMDChoiceItem

				FItemList(i).Fphotoimg		= staticImgUrl & "/contents/maincontents/" + rsget("photoimg")
				FItemList(i).Flinkinfo		= db2html(rsget("linkinfo"))
				FItemList(i).Ftextinfo		= db2html(rsget("textinfo"))
				FItemList(i).Flinkitemid	= db2html(rsget("linkitemid"))

				FItemList(i).FitemName		= db2html(rsget("itemname"))
				FItemList(i).FImageList		= "http://webimage.10x10.co.kr/image/list/" + GetImageSubFolderByItemid(rsget("itemid")) + "/" + rsget("listImage")
				FItemList(i).FImageList120	= "http://webimage.10x10.co.kr/image/list120/" + GetImageSubFolderByItemid(rsget("itemid")) + "/" + rsget("listImage120")
				FItemList(i).FImageIcon1	= "http://webimage.10x10.co.kr/image/icon1/" + GetImageSubFolderByItemid(rsget("itemid")) + "/" + rsget("icon1Image")
				FItemList(i).FOrgprice		= rsget("orgprice")
				FItemList(i).FSaleyn		= rsget("sailyn")
				FItemList(i).FSellCash		= rsget("sellcash")
				FItemList(i).Fitemcouponyn	= rsget("itemcouponyn")
				FItemList(i).Fitemcouponvalue	= rsget("itemcouponvalue")
				FItemList(i).Fitemcoupontype	= rsget("itemcoupontype")
				if Not(rsget("tentenimage200")="" or isNull(rsget("tentenimage200"))) then FItemList(i).FTentenImage200	= "http://webimage.10x10.co.kr/image/tenten200/" + GetImageSubFolderByItemid(rsget("itemid")) + "/" + rsget("tentenimage200")

				i=i+1
				rsget.moveNext
			loop
		end if
		rsget.close
    end Sub

    Private Sub Class_Initialize()
		redim  FItemList(0)
		FPageSize         = 10
	End Sub

	Private Sub Class_Terminate()

    End Sub

end Class
%>
