<%
'#=========================================#
'# 어워드 아이템 클래스                    #
'#=========================================#
class CAwardItem
	public FItemID
	public FItemName
	public FSellYn
	public FLimitYn
	public FLimitNo
	public FLimitSold
	public FTenOnlyYn

	public FMakerID
	public FBrandName

	public FImageSmall
	public FImageList
	public FImageList120
	public FImageBasic
    public Ficon1image
    public Ficon2image
    public FBrandImage

	public FSellCash

	public FCurrRank
	public FLastRank

	public FSaleYN
	public FOrgPrice
	public FSalePrice

	public FItemCouponYN
	public FItemCouponType
	public FItemCouponValue
	public FCurrItemCouponIdx

    public FEvalcnt
    public FFavCount
    public FReIpgoDate

	public FSpecialUserItem
	public Freviewcnt
	public FCurrPos
	Public Fyyyy
	Public Flastweek

	Public FSocName_Kor

	Public FGiftFlg
	Public FHhitFlg
	Public FSaleFlg
	Public FSmileFlg
	Public FDGNComment
	Public FstoryTitle
	Public FstoryContent
	Public FNewFlg
	Public Fsoclogo
	public FSocname
	Public Fmodelimg

	Public Fmodelitem
	Public FModelBimg

	public FCateCode
    public Fregdate
    public FItemDiv
	public FadultType

	'// 해외직구배송작업추가
	Public FDeliverFixDay

    public Function IsNewItem()
        IsNewItem = datediff("d",FRegdate,Now()) < 14
    end function

	'// 마일리지샵 아이템 여부 '!
	public Function IsMileShopitem()
		IsMileShopitem = (FItemDiv="82")
	end Function

    '// 판매종료  여부 : 판매중인것만 불러옴.;
	public Function IsSoldOut() '!
	    isSoldOut = (FSellYn<>"Y") or ((FLimitYn = "Y") and (clng(FLimitNo)-clng(FLimitSold)<1))
	end Function

	'//	한정 여부
	public Function IsLimitItem() '!
			IsLimitItem= (FLimitYn="Y")
	end Function

	'//	텐바이텐 독점 여부
	public Function IsTenOnlyItem() '!
			IsTenOnlyItem= (FTenOnlyYn="Y")
	end Function

	'// 무료 배송 쿠폰 여부
	public function IsFreeBeasongCoupon() '?
		IsFreeBeasongCoupon = Fitemcoupontype="3"
	end function

	'// 한정 상품 남은 수량
	public Function FRemainCount()	'!
		if IsSoldOut then
			FRemainCount=0
		else
			FRemainCount=(clng(FLimitNo) - clng(FLimitSold))
		end if
	End Function

	'// 재입고 상품 여부
	public Function isReipgoItem()
		isReipgoItem = (datediff("d",FReIpgoDate,now())<= 14)
	end Function

	public function GetLevelUpCount()

		if (FCurrRank<FLastRank) then
			GetLevelUpCount = CStr(FLastRank-FCurrRank)
		elseif (FCurrRank=FLastRank) and (FLastRank="0") then
			GetLevelUpCount = ""
		elseif (FCurrRank=FLastRank) then
			GetLevelUpCount = ""
		elseif (FCurrRank>FLastRank) and (FLastRank="0") then
			GetLevelUpCount = ""
		else
			GetLevelUpCount = CStr(FCurrRank-FLastRank)
			if FCurrRank-FLastRank>=FCurrPos then
				GetLevelUpCount = ""
			end if
		end if
	end function

	public function GetLevelUpArrow()
		if (FCurrRank<FLastRank) then
			GetLevelUpArrow = "<img src='http://fiximage.10x10.co.kr/web2013/award/ico_rank_up.gif' alt='순위 상승' /> " & GetLevelUpCount()
		elseif (FCurrRank=FLastRank) and (FLastRank=0) then
			GetLevelUpArrow = ""
		elseif (FCurrRank=FLastRank) then
			'GetLevelUpArrow = "<img src='http://fiximage.10x10.co.kr/web2010/bestaward/ico_none.gif' align='absmiddle' style='display:inline;'> <font class='eng11px00'><b>0</b></font>"
			GetLevelUpArrow = ""
		elseif (FCurrRank>FLastRank) and (FLastRank=0) then
			GetLevelUpArrow = ""
		else
			GetLevelUpArrow = "<img src='http://fiximage.10x10.co.kr/web2013/award/ico_rank_down.gif' alt='순위 하락' /> " & GetLevelUpCount()
			if FCurrRank-FLastRank>=FCurrPos then
				'GetLevelUpArrow = "<font class='eng11px00'><b>0</b></font>"
				GetLevelUpArrow = ""
			end if
		end if
	end function

	public function GetLevelUpStr()

		if (FCurrRank<FLastRank) then
			GetLevelUpStr = "<font color=#C80708>▲" + CStr(FLastRank-FCurrRank) + "</font>"
		elseif (FCurrRank=FLastRank) and (FLastRank=0) then
			GetLevelUpStr = "<FONT color=#31AD00><B>NEW</B>"
		elseif (FCurrRank=FLastRank) then
			GetLevelUpStr = "&nbsp;<font color=#000000></font>"
		elseif (FCurrRank>FLastRank) and (FLastRank=0) then
			GetLevelUpStr = "<FONT color=#31AD00><B>NEW</B>"
		else
			GetLevelUpStr = "<font color=#005AFF>▼" + CStr(FCurrRank-FLastRank) + "</font>"
			if FCurrRank-FLastRank>=FCurrPos then
				GetLevelUpStr = "&nbsp;<font color=#000000></font>"
			end if
		end if
	end function

	public function GetSimpleUpStr()

		if (FCurrRank<FLastRank) then
			GetSimpleUpStr = "<font color=#C80708>+" + CStr(FLastRank-FCurrRank) + "</font>"
		elseif (FCurrRank=FLastRank) and (FLastRank=0) then
			GetSimpleUpStr = "<FONT color=#31AD00><B>NEW</B>"
		elseif (FCurrRank=FLastRank) then
			GetSimpleUpStr = "<font color=#000000></font>"
		elseif (FCurrRank>FLastRank) and (FLastRank=0) then
			GetSimpleUpStr = "<FONT color=#31AD00><B>NEW</B>"
		else
			GetSimpleUpStr = "<font color=#005AFF>-" + CStr(FCurrRank-FLastRank) + "</font>"
			if FCurrRank-FLastRank>=FCurrPos then
				GetSimpleUpStr = "<font color=#000000></font>"
			end if
		end if
	end function

	public function GetWriteDateStr()
		if IsNULL(Fregdate) then
			GetWriteDateStr = ""
		else
			GetWriteDateStr = Left(CStr(Fregdate),10)
		end if
	end function

	public function IsSpecialUserItem()
		IsSpecialUserItem = (FSpecialUserItem>0) and (getLoginUserLevel()>0 and getLoginUserLevel()<>5)
	end function

	public function IsSaleItem()
			IsSaleItem = ((FSaleYN="Y") and (FOrgPrice>FSellCash)) or (IsSpecialUserItem)
	end function

    public Function getSalePro()
		if FOrgprice=0 then
			getSalePro = 0
		else
			getSalePro = CLng((FOrgPrice-getRealPrice)/FOrgPrice*100) & "%"
		end if
	end Function

    public Function IsCouponItem()
			IsCouponItem = (FItemCouponYN="Y")
	end Function

	'// 쿠폰 적용가
	public Function GetCouponAssignPrice() '!
		if (IsCouponItem) then
			GetCouponAssignPrice = getRealPrice - GetCouponDiscountPrice
		else
			GetCouponAssignPrice = getRealPrice
		end if
	end Function

	'// 쿠폰 할인가
	public Function GetCouponDiscountPrice() '?
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

	' 상품 쿠폰 내용
	public function GetCouponDiscountStr() '!

		Select Case Fitemcoupontype
			Case "1"
				GetCouponDiscountStr =CStr(Fitemcouponvalue) + "%"
			Case "2"
				GetCouponDiscountStr =CStr(Fitemcouponvalue) + "원"
			Case "3"
				GetCouponDiscountStr ="무료배송"
			Case Else
				GetCouponDiscountStr = Fitemcoupontype
		End Select

    end function

	public function getOrgPrice()
		if FOrgPrice=0 then
			getOrgPrice = FSellCash
		else
			getOrgPrice = FOrgPrice
		end if
	end function

	public function getRealPrice()
		getRealPrice = FSellCash

		if (IsSpecialUserItem()) then
		    getRealPrice = getSpecialShopItemPrice(FSellCash)
		end if
	end Function
	
	'// 해외직구배송작업추가(원승현)
	Public Function IsDirectPurchase()
		IsDirectPurchase = false
		if (FDeliverFixDay = "G") Then
			IsDirectPurchase = true
		End if
	End Function


	Private Sub Class_Initialize()

	End Sub

	Private Sub Class_Terminate()

	End Sub
end Class

'#=========================================#
'# 어워드 클래스                           #
'#=========================================#

class CAWard
	public FItemList()
	public FResultCount

	public FTotalPage
	public FPageSize
	public FScrollCount
	public FRectExtOnly
	public FRectJewelry
	public FRectFashion
	Public FRectCDL
	Public FRectCDM

	public FCateCode
	public FFavCount

	public FRectAwardgubun
	Public FRectLastWeek
	Public FPrevID
	Public FNextID

	public FMakerID1
	public FMakerID2
	public FMakerID3
	public FMakerID4
	Public FMoney1
	Public FMoney2
	Public FTotalCount
	public FCurrPage
	Public FPageCount
	public FDisp1
	public FDisp2

	Public FCdl

	public function GetImageFolerName(byval i)
	    GetImageFolerName = GetImageSubFolderByItemid(FItemList(i).FItemID)
	end function


	public Sub GetNormalItemList()
		dim sqlStr,i
		Dim rsMem
		sqlStr = "exec db_const.dbo.sp_Ten_awardItemList_2013  " & FPageSize & ",'" & FRectAwardgubun & "','" & FDisp1 & "','" & FDisp2 & "' "
		if FRectExtOnly=true then
			sqlStr = sqlStr + ",1"
		else
			sqlStr = sqlStr + ",0"
		end if
'		response.write sqlStr
'		rsget.CursorLocation = adUseClient
'		rsget.CursorType = adOpenStatic
'		rsget.LockType = adLockOptimistic
'		rsget.Open sqlStr,dbget,1
		set rsMem = getDBCacheSQL(dbget,rsget,"AWARD1",sqlStr,60*5)
		if (rsMem is Nothing) then Exit sub ''추가

		FResultCount = rsMem.Recordcount

		redim preserve FItemList(FResultCount)
		i=0
		if  not rsMem.EOF  then
			do until rsMem.eof
				set FItemList(i) = new CAwardItem

				FItemList(i).FItemID    = rsMem("itemid")
				FItemList(i).FItemName  = db2html(rsMem("itemname"))
				FItemList(i).FMakerID   = rsMem("makerid")
				FItemList(i).FBrandName = db2html(rsMem("brandname"))

				FItemList(i).FImageSmall= "http://webimage.10x10.co.kr/image/small/" + GetImageFolerName(i) + "/" + rsMem("smallimage")
				FItemList(i).FImageList = "http://webimage.10x10.co.kr/image/list/" + GetImageFolerName(i) + "/" + rsMem("listimage")
				FItemList(i).FImageList120 = "http://webimage.10x10.co.kr/image/list120/" + GetImageFolerName(i) + "/" + rsMem("listimage120")
				FItemList(i).FImageBasic = rsMem("basicimage")

                FItemList(i).Ficon1image = rsMem("icon1image")
                FItemList(i).Ficon2image = rsMem("icon2image")


				if FItemList(i).FImageBasic<>"" then
					FItemList(i).FImageBasic = "http://webimage.10x10.co.kr/image/basic/" + GetImageFolerName(i) + "/" + FItemList(i).FImageBasic
				end if

                if FItemList(i).Ficon1image<>"" then
					FItemList(i).Ficon1image = "http://webimage.10x10.co.kr/image/icon1/" + GetImageFolerName(i) + "/" + FItemList(i).Ficon1image
				end if

				if FItemList(i).Ficon2image<>"" then
					FItemList(i).Ficon2image = "http://webimage.10x10.co.kr/image/icon2/" + GetImageFolerName(i) + "/" + FItemList(i).Ficon2image
				end if

				FItemList(i).FSellCash  = rsMem("sellcash")

				FItemList(i).FCurrRank     = rsMem("currrank")
				FItemList(i).FLastRank     = rsMem("lastrank")


				FItemList(i).FSaleYN    		= rsMem("sailyn")
				FItemList(i).FSalePrice 		= rsMem("sailprice")
				FItemList(i).FOrgPrice   		= rsMem("orgprice")

				FItemList(i).FSpecialUserItem   = rsMem("specialuseritem")
				FItemList(i).Freviewcnt         = rsMem("evalcnt")
				FItemList(i).FRegdate           = rsMem("regdate")

				FItemList(i).FItemCouponYN      = rsMem("itemcouponyn")
                FItemList(i).FItemCouponType    = rsMem("itemcoupontype")
                FItemList(i).FItemCouponValue   = rsMem("itemcouponvalue")
                FItemList(i).FCurrItemCouponIdx = rsMem("curritemcouponidx")

                FItemList(i).FEvalcnt           = rsMem("Evalcnt")
                FItemList(i).FReIpgoDate        = rsMem("reipgodate")

                FItemList(i).FSellYn            = rsMem("sellyn")
                FItemList(i).FLimitYn           = rsMem("limityn")
                FItemList(i).FLimitNo           = rsMem("limitno")
                FItemList(i).FLimitSold         = rsMem("limitsold")
                FItemList(i).FTenOnlyYn         = rsMem("tenOnlyYn")

                FItemList(i).FCateCode          = rsMem("dispcate1")
				FItemList(i).FFavCount   	    = rsMem("favcount")

				'// 해외직구배송작업추가(원승현)
				FItemList(i).FDeliverFixDay		= rsMem("deliverfixday")

				FItemList(i).FCurrPos = i+1

				i=i+1
				rsMem.moveNext
			loop
		end if

		rsMem.Close

	end Sub

	public Sub GetNormalItemList5down()		'카테고리메인에 베스트 5개 부분에 5개 상품이 아닐경우.
		dim sqlStr,i
		sqlStr = "exec db_const.dbo.sp_Ten_awardItemList_5down " & FPageSize & ",'" & FRectAwardgubun & "','" & FRectCDL & "','" & FRectCDM & "'"
		if FRectExtOnly=true then
			sqlStr = sqlStr + ",1"
		else
			sqlStr = sqlStr + ",0"
		end if

		'response.write sqlStr
		rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
		rsget.Open sqlStr,dbget,1
		FResultCount = rsget.Recordcount

		redim preserve FItemList(FResultCount)
		i=0
		if  not rsget.EOF  then
			do until rsget.eof
				set FItemList(i) = new CAwardItem

				FItemList(i).FItemID    = rsget("itemid")
				FItemList(i).FItemName  = db2html(rsget("itemname"))
				FItemList(i).FMakerID   = rsget("makerid")
				FItemList(i).FBrandName = db2html(rsget("brandname"))

				FItemList(i).FImageSmall= "http://webimage.10x10.co.kr/image/small/" + GetImageFolerName(i) + "/" + rsget("smallimage")
				FItemList(i).FImageList = "http://webimage.10x10.co.kr/image/list/" + GetImageFolerName(i) + "/" + rsget("listimage")
				FItemList(i).FImageList120 = "http://webimage.10x10.co.kr/image/list120/" + GetImageFolerName(i) + "/" + rsget("listimage120")
				FItemList(i).FImageBasic = rsget("basicimage")

                FItemList(i).Ficon1image = rsget("icon1image")
                FItemList(i).Ficon2image = rsget("icon2image")


				if FItemList(i).FImageBasic<>"" then
					FItemList(i).FImageBasic = "http://webimage.10x10.co.kr/image/basic/" + GetImageFolerName(i) + "/" + FItemList(i).FImageBasic
				end if

                if FItemList(i).Ficon1image<>"" then
					FItemList(i).Ficon1image = "http://webimage.10x10.co.kr/image/icon1/" + GetImageFolerName(i) + "/" + FItemList(i).Ficon1image
				end if

				if FItemList(i).Ficon2image<>"" then
					FItemList(i).Ficon2image = "http://webimage.10x10.co.kr/image/icon2/" + GetImageFolerName(i) + "/" + FItemList(i).Ficon2image
				end if

				FItemList(i).FSellCash  = rsget("sellcash")

				FItemList(i).FCurrRank     = rsget("currrank")
				FItemList(i).FLastRank     = rsget("lastrank")


				FItemList(i).FSaleYN    = rsget("sailyn")
				FItemList(i).FSalePrice = rsget("sailprice")
				FItemList(i).FOrgPrice   = rsget("orgprice")

				FItemList(i).FSpecialUserItem   = rsget("specialuseritem")
				FItemList(i).Freviewcnt         = rsget("evalcnt")
				FItemList(i).FRegdate           = rsget("regdate")

				FItemList(i).FItemCouponYN      = rsget("itemcouponyn")
                FItemList(i).FItemCouponType    = rsget("itemcoupontype")
                FItemList(i).FItemCouponValue   = rsget("itemcouponvalue")
                FItemList(i).FCurrItemCouponIdx = rsget("curritemcouponidx")

                FItemList(i).FEvalcnt           = rsget("Evalcnt")
                FItemList(i).FReIpgoDate        = rsget("reipgodate")

                FItemList(i).FSellYn            = rsget("sellyn")
                FItemList(i).FLimitYn           = rsget("limityn")
                FItemList(i).FLimitNo           = rsget("limitno")
                FItemList(i).FLimitSold         = rsget("limitsold")
                FItemList(i).FTenOnlyYn         = rsget("tenOnlyYn")
                FItemList(i).FadultType         = rsget("adultType")				

				FItemList(i).FCurrPos = i+1

				i=i+1
				rsget.moveNext
			loop
		end if

		rsget.Close

	end Sub

	'// 카테고리 지정시 목록 클래스 //
	public Sub GetBrandAwardList()
		dim sqlStr,i
		Dim rsMem
		sqlStr = "exec db_const.dbo.sp_Ten_awardBrandList_2013 " & FPageSize & ",'" & FDisp1 & "','" & FRectAwardgubun & "'"
'		rsget.CursorLocation = adUseClient
'		rsget.CursorType = adOpenStatic
'		rsget.LockType = adLockOptimistic
'		rsget.Open sqlStr,dbget,1

		set rsMem = getDBCacheSQL(dbget,rsget,"AWARD",sqlStr,60*5)
		if (rsMem is Nothing) then Exit sub ''추가

		FResultCount = rsMem.Recordcount

		redim preserve FItemList(FResultCount)
		i=0
		if  not rsMem.EOF  then
			do until rsMem.eof
				set FItemList(i) = new CAwardItem

				FItemList(i).FMakerID		= rsMem("userid")
				FItemList(i).FSocname		= db2html(rsMem("socname"))
				FItemList(i).FSocname_Kor	= db2html(rsMem("socname_kor"))

				FItemList(i).FDGNComment	= db2html(rsMem("dgncomment"))
				FItemList(i).FstoryTitle	= db2html(rsMem("storyTitle"))
				FItemList(i).FstoryContent	= db2html(rsMem("storyContent"))

				If isNull(rsMem("soclogo")) Then
					FItemList(i).Fsoclogo		= "http://fiximage.10x10.co.kr/web2009/bestaward/nologo.gif"
				Else
					FItemList(i).Fsoclogo		= "http://webimage.10x10.co.kr/image/brandlogo/" & db2html(rsMem("soclogo"))
				End IF

				FItemList(i).FGiftFlg		= rsMem("giftflg")
				FItemList(i).FHhitFlg		= rsMem("hitflg")
				FItemList(i).FSaleFlg		= rsMem("saleflg")
				FItemList(i).FSmileFlg		= rsMem("smileflg")
				FItemList(i).FNewFlg		= rsMem("newflg")

				FItemList(i).Fmodelitem		= rsMem("modelitem")
				FItemList(i).FItemID		= FItemList(i).Fmodelitem

				FItemList(i).FCateCode		= rsMem("catecode")		'전시카테고리

                FItemList(i).FImageSmall= "http://webimage.10x10.co.kr/image/small/" + GetImageFolerName(i) + "/" + rsMem("smallimage")
				FItemList(i).FImageList = "http://webimage.10x10.co.kr/image/list/" + GetImageFolerName(i) + "/" + rsMem("listimage")
				FItemList(i).FImageList120 = "http://webimage.10x10.co.kr/image/list120/" + GetImageFolerName(i) + "/" + rsMem("listimage120")
				FItemList(i).FImageBasic = rsMem("basicimage")

                FItemList(i).Ficon1image = rsMem("icon1image")
                FItemList(i).Ficon2image = rsMem("icon2image")


				if FItemList(i).FImageBasic<>"" then
					FItemList(i).FImageBasic = "http://webimage.10x10.co.kr/image/basic/" + GetImageFolerName(i) + "/" + FItemList(i).FImageBasic
				end if

                if FItemList(i).Ficon1image<>"" then
					FItemList(i).Ficon1image = "http://webimage.10x10.co.kr/image/icon1/" + GetImageFolerName(i) + "/" + FItemList(i).Ficon1image
				end if

				if FItemList(i).Ficon2image<>"" then
					FItemList(i).Ficon2image = "http://webimage.10x10.co.kr/image/icon2/" + GetImageFolerName(i) + "/" + FItemList(i).Ficon2image
				end if

				FItemList(i).FBrandImage = fnGetBrandImage(FItemList(i).Fmodelitem, rsMem("brandImage"))

				i=i+1
				rsMem.moveNext
			loop
		end if

		rsMem.Close

	end Sub

	'// 가격별 베스트 셀러 //
	public Sub GetBestSellersPrice()
		dim sqlStr,i
		Dim rsMem

		sqlStr = "exec db_const.dbo.sp_Ten_AwardBestSellers_Price_2013 '" & FDisp1 & "','" & FMoney1 & "','" & FMoney2 & "','" & FDisp2 & "'"
'response.write sqlStr
'		rsget.CursorLocation = adUseClient
'		rsget.CursorType = adOpenStatic
'		rsget.LockType = adLockOptimistic
'		rsget.Open sqlStr,dbget,1
'		FResultCount = rsget.Recordcount

		set rsMem = getDBCacheSQL(dbget,rsget,"AWARD",sqlStr,60*5)
		if (rsMem is Nothing) then Exit sub ''추가

		FResultCount = rsMem.Recordcount

		redim preserve FItemList(FResultCount)
		i=0
		if  not rsMem.EOF  then
			do until rsMem.eof
				set FItemList(i) = new CAwardItem

				FItemList(i).FItemDiv    = rsMem("itemdiv")
				FItemList(i).FItemID    = rsMem("itemid")
				FItemList(i).FItemName  = db2html(rsMem("itemname"))

				FItemList(i).FMakerID   = rsMem("makerid")
				FItemList(i).FBrandName = db2html(rsMem("brandname"))

				FItemList(i).FImageSmall= "http://webimage.10x10.co.kr/image/small/" + GetImageFolerName(i) + "/" + rsMem("smallimage")
				FItemList(i).FImageList = "http://webimage.10x10.co.kr/image/list/" + GetImageFolerName(i) + "/" + rsMem("listimage")
				FItemList(i).FImageList120 = "http://webimage.10x10.co.kr/image/list120/" + GetImageFolerName(i) + "/" + rsMem("listimage120")
				FItemList(i).FImageBasic = rsMem("basicimage")

                FItemList(i).Ficon1image = rsMem("icon1image")
                FItemList(i).Ficon2image = rsMem("icon2image")


				if FItemList(i).FImageBasic<>"" then
					FItemList(i).FImageBasic = "http://webimage.10x10.co.kr/image/basic/" + GetImageFolerName(i) + "/" + FItemList(i).FImageBasic
				end if

                if FItemList(i).Ficon1image<>"" then
					FItemList(i).Ficon1image = "http://webimage.10x10.co.kr/image/icon1/" + GetImageFolerName(i) + "/" + FItemList(i).Ficon1image
				end if

				if FItemList(i).Ficon2image<>"" then
					FItemList(i).Ficon2image = "http://webimage.10x10.co.kr/image/icon2/" + GetImageFolerName(i) + "/" + FItemList(i).Ficon2image
				end if


				FItemList(i).FSellCash  = rsMem("sellcash")

				FItemList(i).FCurrRank     = rsMem("currrank")
				FItemList(i).FLastRank     = rsMem("lastrank")


				FItemList(i).FSaleYN    = rsMem("sailyn")
				FItemList(i).FSalePrice = rsMem("sailprice")
				FItemList(i).FOrgPrice   = rsMem("orgprice")

				FItemList(i).FSpecialUserItem   = rsMem("specialuseritem")
				FItemList(i).Freviewcnt         = rsMem("evalcnt")
				FItemList(i).FRegdate           = rsMem("regdate")

				FItemList(i).FItemCouponYN      = rsMem("itemcouponyn")
                FItemList(i).FItemCouponType    = rsMem("itemcoupontype")
                FItemList(i).FItemCouponValue   = rsMem("itemcouponvalue")
                FItemList(i).FCurrItemCouponIdx = rsMem("curritemcouponidx")

                FItemList(i).FEvalcnt           = rsMem("Evalcnt")
                FItemList(i).FReIpgoDate        = rsMem("reipgodate")

                FItemList(i).FSellYn            = rsMem("sellyn")
                FItemList(i).FLimitYn           = rsMem("limityn")
                FItemList(i).FLimitNo           = rsMem("limitno")
                FItemList(i).FLimitSold         = rsMem("limitsold")
                FItemList(i).FFavCount         = rsMem("favcount")

				'// 해외직구배송작업추가(원승현)
				FItemList(i).FDeliverFixDay		= rsMem("deliverfixday")

				FItemList(i).FCurrPos = i+1

				i=i+1
				rsMem.moveNext
			loop
		end if

		rsMem.Close

	end Sub

	'// 브랜드 베스트상품 목록 //
	public sub GetBrandAwardTop4ItemList()
		dim sqlStr, i

		'// 목록 접수 //
		sqlStr =	"exec db_const.dbo.sp_Ten_AwardBrandTop4ItemList " & FpageSize & ",'" & FMakerID1 & "','" & FMakerID2 & "','" & FMakerID3 & "','" & FMakerID4 & "'"

		rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
		rsget.Open sqlStr,dbget

		FResultCount = rsget.RecordCount

		redim preserve FItemList(FResultCount)
		i=0
		if  not rsget.EOF  then
			do until rsget.eof
				set FItemList(i) = new CAwardItem

				FItemList(i).FitemId		= rsget("itemid")
				FItemList(i).Ficon1Image	= "http://webimage.10x10.co.kr/image/icon1/" + GetImageSubFolderByItemid(rsget("itemid")) + "/" + rsget("icon1image")
				FItemList(i).FItemName		= rsget("itemname")
				FItemList(i).FMakerID		= rsget("makerid")

				i=i+1
				rsget.moveNext
			loop

		end if
		rsget.Close
	end sub


	'// 지난주 브랜드 목록 클래스 //
	public Sub GetBrandLastWeekList()
		dim sqlStr,i

		'주간 인기 브랜드 접수
		sqlStr =	"Select top " & CStr(FPageSize) & "  yyyy, lastweek, makerid, modelitem, modelimg, socname_kor " &_
					"From [db_log].[dbo].tbl_brand_award_week_log " &_
					"Where awardgubun='" & FRectAwardgubun + "'" &_
					"		and lastweek = " & Cstr(FRectLastWeek) &_
					" Order by point desc "

		rsget.Open sqlStr,dbget,1
		FResultCount = rsget.Recordcount

		redim preserve FItemList(FResultCount)
		i=0
		if  not rsget.EOF  then
			do until rsget.eof
				set FItemList(i) = new CAwardItem

				FItemList(i).Fyyyy			= rsget("yyyy")
				FItemList(i).Flastweek		= rsget("lastweek")
				FItemList(i).Fmakerid		= rsget("makerid")
				FItemList(i).Fsocname_kor	= db2html(rsget("socname_kor"))
				FItemList(i).FItemID		= rsget("modelitem")
				FItemList(i).Fmodelimg		= "http://webimage.10x10.co.kr/image/small/" + GetBrandImageFolerName(FItemList(i).FItemID) + "/" + rsget("modelimg")

				i=i+1
				rsget.moveNext
			loop
		end if

		rsget.Close


		sqlStr = "select top 1 MIN(lastweek) as mweek from (" + vbcrlf
		sqlStr = sqlStr + " select  lastweek" + vbcrlf
		sqlStr = sqlStr + " from [db_log].[dbo].tbl_brand_award_week_log" + vbcrlf
		sqlStr = sqlStr + " where awardgubun='" + FRectAwardgubun + "'"
		sqlStr = sqlStr + " and (lastweek > " + CStr(FRectLastWeek) + ") "
		sqlStr = sqlStr + " group by lastweek" + vbcrlf
		sqlStr = sqlStr + ") as T" + vbcrlf

		rsget.Open sqlStr, dbget, 1
		if  not rsget.EOF  then
              FPrevID = rsget("mweek")
		else
		      FPrevID = -1
		end if
		rsget.close

		sqlStr = "select top 1 MAX(lastweek) as mweek from (" + vbcrlf
		sqlStr = sqlStr + " select  lastweek" + vbcrlf
		sqlStr = sqlStr + " from [db_log].[dbo].tbl_brand_award_week_log" + vbcrlf
		sqlStr = sqlStr + " where awardgubun='" + FRectAwardgubun + "'"
		sqlStr = sqlStr + " and (lastweek < " + CStr(FRectLastWeek) + ") "
		sqlStr = sqlStr + ") as T" + vbcrlf

		rsget.Open sqlStr, dbget, 1
		if  not rsget.EOF  then
              FNextID = rsget("mweek")
		else
		      FNextID = -1
		end if
		rsget.close

	end Sub

	'// 탭 버튼 클릭시 해당 목록 클래스 //		'//street/index.asp
	Public Sub GetBrandChoiceList_new2013()
		Dim sqlStr,i

		sqlStr = "exec db_const.dbo.sp_Ten_ChoiceBrandList_cnt_new " & FPageSize & ", '" & FRectAwardgubun & "', '"&FCdl&"'"
		rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
		rsget.Open sqlStr,dbget,1
			FTotalCount = rsget("cnt")
			FTotalPage = rsget("totPg")
		rsget.close

		'지정페이지가 전체 페이지보다 클 때 함수종료
		if Cint(FCurrPage)>Cint(FTotalPage) then
			FResultCount = 0
			exit sub
		end if

		sqlStr = "exec db_const.dbo.sp_Ten_ChoiceBrandList_new " & FPageSize & ", " & FCurrPage & ",'" & FRectAwardgubun & "', '"&FCdl&"'"
		rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
		rsget.pagesize = FPageSize
		rsget.Open sqlStr,dbget,1
		
		If (FCurrPage * FPageSize < FTotalCount) Then
			FResultCount = FPageSize
		Else
			FResultCount = FTotalCount - FPageSize*(FCurrPage-1)
		End If

		FTotalPage = (FTotalCount\FPageSize)
		If (FTotalPage<>FTotalCount/FPageSize) Then FTotalPage = FTotalPage +1
			
		Redim preserve FItemList(FResultCount)
		FPageCount = FCurrPage - 1

		i=0
		if  not rsget.EOF  then
			rsget.absolutepage = FCurrPage
			do until rsget.eof
				set FItemList(i) = new CAwardItem

				FItemList(i).FMakerID		= rsget("userid")
				FItemList(i).FSocname		= db2html(rsget("socname"))
				FItemList(i).FSocname_Kor	= db2html(rsget("socname_kor"))
				If isNull(rsget("soclogo")) Then
					FItemList(i).Fsoclogo		= "http://fiximage.10x10.co.kr/web2009/bestaward/nologo.gif"
				Else
					FItemList(i).Fsoclogo		= "http://webimage.10x10.co.kr/image/brandlogo/" & db2html(rsget("soclogo"))
				End IF

				FItemList(i).FGiftFlg		= rsget("giftflg")
				FItemList(i).FHhitFlg		= rsget("hitflg")
				FItemList(i).FSaleFlg		= rsget("saleflg")
				FItemList(i).FSmileFlg		= rsget("smileflg")
				FItemList(i).FNewFlg		= rsget("newflg")

				FItemList(i).Fmodelitem		= rsget("modelitem")
				FItemList(i).FItemID		= FItemList(i).Fmodelitem
				FItemList(i).FCateCode		= rsget("catecode")
                
                FItemList(i).FImageSmall= "http://webimage.10x10.co.kr/image/small/" + GetImageFolerName(i) + "/" + rsget("smallimage")
				FItemList(i).FImageList = "http://webimage.10x10.co.kr/image/list/" + GetImageFolerName(i) + "/" + rsget("listimage")
				FItemList(i).FImageList120 = "http://webimage.10x10.co.kr/image/list120/" + GetImageFolerName(i) + "/" + rsget("listimage120")
				FItemList(i).FImageBasic = rsget("basicimage")
                
                FItemList(i).Ficon1image = rsget("icon1image")
                FItemList(i).Ficon2image = rsget("icon2image")
                

				if FItemList(i).FImageBasic<>"" then
					FItemList(i).FImageBasic = "http://webimage.10x10.co.kr/image/basic/" + GetImageFolerName(i) + "/" + FItemList(i).FImageBasic
				end if
                
                if FItemList(i).Ficon1image<>"" then
					FItemList(i).Ficon1image = "http://image.10x10.co.kr/image/icon1/" + GetImageFolerName(i) + "/" + FItemList(i).Ficon1image   ''아카마이테스트 webimage => image
				end if
				
				if FItemList(i).Ficon2image<>"" then
					FItemList(i).Ficon2image = "http://webimage.10x10.co.kr/image/icon2/" + GetImageFolerName(i) + "/" + FItemList(i).Ficon2image
				end if

				FItemList(i).FBrandImage = fnGetBrandImage(FItemList(i).Fmodelitem, rsget("brandImage"))
				
				i=i+1
				rsget.moveNext
			loop
		end if
		rsget.Close
	end Sub

	'// 탭 버튼 클릭시 해당 목록 클래스 //		'//street/index.asp
	Public Sub GetBrandChoiceList_add2013()
		Dim sqlStr,i

		sqlStr = "exec db_const.dbo.sp_Ten_ChoiceBrandList_cnt2013 " & FPageSize & ", '" & FRectAwardgubun & "', '"&FCdl&"'"
		rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
		rsget.Open sqlStr,dbget,1
			FTotalCount = rsget("cnt")
			FTotalPage = rsget("totPg")
		rsget.close

		'지정페이지가 전체 페이지보다 클 때 함수종료
		if Cint(FCurrPage)>Cint(FTotalPage) then
			FResultCount = 0
			exit sub
		end if

		sqlStr = "exec db_const.dbo.sp_Ten_ChoiceBrandList_new2013 " & FPageSize & ", " & FCurrPage & ",'" & FRectAwardgubun & "', '"&FCdl&"'"
		rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
		rsget.pagesize = FPageSize
		rsget.Open sqlStr,dbget,1
		
		If (FCurrPage * FPageSize < FTotalCount) Then
			FResultCount = FPageSize
		Else
			FResultCount = FTotalCount - FPageSize*(FCurrPage-1)
		End If

		FTotalPage = (FTotalCount\FPageSize)
		If (FTotalPage<>FTotalCount/FPageSize) Then FTotalPage = FTotalPage +1
			
		Redim preserve FItemList(FResultCount)
		FPageCount = FCurrPage - 1

		i=0
		if  not rsget.EOF  then
			rsget.absolutepage = FCurrPage
			do until rsget.eof
				set FItemList(i) = new CAwardItem

				FItemList(i).FMakerID		= rsget("userid")
				FItemList(i).FSocname		= db2html(rsget("socname"))
				FItemList(i).FSocname_Kor	= db2html(rsget("socname_kor"))
				If isNull(rsget("soclogo")) Then
					FItemList(i).Fsoclogo		= "http://fiximage.10x10.co.kr/web2009/bestaward/nologo.gif"
				Else
					FItemList(i).Fsoclogo		= "http://webimage.10x10.co.kr/image/brandlogo/" & db2html(rsget("soclogo"))
				End IF

				FItemList(i).FGiftFlg		= rsget("giftflg")
				FItemList(i).FHhitFlg		= rsget("hitflg")
				FItemList(i).FSaleFlg		= rsget("saleflg")
				FItemList(i).FSmileFlg		= rsget("smileflg")
				FItemList(i).FNewFlg		= rsget("newflg")

				FItemList(i).Fmodelitem		= rsget("modelitem")
				FItemList(i).FItemID		= FItemList(i).Fmodelitem
				FItemList(i).FCateCode		= rsget("catecode")
                
                FItemList(i).FImageSmall= "http://webimage.10x10.co.kr/image/small/" + GetImageFolerName(i) + "/" + rsget("smallimage")
				FItemList(i).FImageList = "http://webimage.10x10.co.kr/image/list/" + GetImageFolerName(i) + "/" + rsget("listimage")
				FItemList(i).FImageList120 = "http://webimage.10x10.co.kr/image/list120/" + GetImageFolerName(i) + "/" + rsget("listimage120")
				FItemList(i).FImageBasic = rsget("basicimage")
                
                FItemList(i).Ficon1image = rsget("icon1image")
                FItemList(i).Ficon2image = rsget("icon2image")
                

				if FItemList(i).FImageBasic<>"" then
					FItemList(i).FImageBasic = "http://webimage.10x10.co.kr/image/basic/" + GetImageFolerName(i) + "/" + FItemList(i).FImageBasic
				end if
                
                if FItemList(i).Ficon1image<>"" then
					FItemList(i).Ficon1image = "http://image.10x10.co.kr/image/icon1/" + GetImageFolerName(i) + "/" + FItemList(i).Ficon1image   ''아카마이테스트 webimage => image
				end if
				
				if FItemList(i).Ficon2image<>"" then
					FItemList(i).Ficon2image = "http://webimage.10x10.co.kr/image/icon2/" + GetImageFolerName(i) + "/" + FItemList(i).Ficon2image
				end if

				FItemList(i).FBrandImage = fnGetBrandImage(FItemList(i).Fmodelitem, rsget("brandImage"))
				
				i=i+1
				rsget.moveNext
			loop
		end if

		rsget.Close
	end Sub

	public function GetBrandImageFolerName(byval itemid)
    	If itemid <> ""  then
    		GetBrandImageFolerName = GetImageSubFolderByItemid(itemid)
    	End if
	end function

	'### 가격별 베스트 셀러. 카테고리별 가격 범위.
	Public Function GetPriceBetween(vCdl)
		Select Case vCdl
			Case "010"	'#전체
				GetPriceBetween = "3000,5000,10000"
			Case "101"	'#디자인문구
				GetPriceBetween = "5000,10000,30000"
			Case "102"	'#핸드폰/디지털
				GetPriceBetween = "15000,30000,50000"
			Case "103"	'#캠핑/트래블
				GetPriceBetween = "10000,30000,50000"
			Case "104"	'#토이/취미
				GetPriceBetween = "5000,10000,30000"
			Case "114"	'#가구
				GetPriceBetween = "30000,100000,500000"
			Case "106"	'#홈인테리어
				GetPriceBetween = "10000,30000,50000"
			Case "112"	'#키친
				GetPriceBetween = "10000,30000,50000"
			Case "117"	'#패션의류
				GetPriceBetween = "10000,30000,50000"
			Case "116"	'#잡화
				GetPriceBetween = "10000,30000,50000"
			Case "118"	'#뷰티/다이어트
				GetPriceBetween = "10000,30000,50000"
			Case "119"	'#푸드
				GetPriceBetween = "10000,15000,20000"
			Case "115"	'#베이비/키즈
				GetPriceBetween = "10000,30000,50000"
			Case "110"	'#CAT&DOG
				GetPriceBetween = "5000,10000,30000"
			Case "121"	'#가구/수납
				GetPriceBetween = "30000,50000,300000"
			Case "122"	'#데코/조명
				GetPriceBetween = "10000,30000,50000"
			Case "120"	'#패브릭/생활
				GetPriceBetween = "10000,30000,50000"
			Case "124"	'#디자인가전
				GetPriceBetween = "15000,30000,50000"
			Case "125"	'#주얼리/시계
				GetPriceBetween = "10000,30000,50000"
			Case Else
				GetPriceBetween = "10000,30000,50000"
		End Select
	End Function


	Private Sub Class_Initialize()
		FCurrPage =1
		FPageSize = 50
		FResultCount = 0
		FScrollCount = 10
		FTotalCount =0
	End Sub

	Private Sub Class_Terminate()

	End Sub

	Public Function HasPreScroll()
		HasPreScroll = StartScrollPage > 1
	End Function

	Public Function HasNextScroll()
		HasNextScroll = FTotalPage > StartScrollPage + FScrollCount -1
	End Function

	Public Function StartScrollPage()
		StartScrollPage = ((FCurrpage-1)\FScrollCount)*FScrollCount +1
	End Function




end Class
%>
