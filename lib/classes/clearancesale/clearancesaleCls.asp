<%
'###########################################################
' Description : 클리어런스 세일 클래스
' Hieditor : 2016.01.25 유태욱 생성
'###########################################################
%>
<%
class CClearancesaleItem
	Private Sub Class_Initialize()
	End Sub
	Private Sub Class_Terminate()
	End Sub

end class

class CClearancesalelist
	dim FTenOnlyYn

	public FItemList()
	public Fitemid
	public FItemName
	public FSellCash
	public FOrgPrice
	public FBrandName
	public FSellyn
	public FSaleyn
	public FLimitNo
	public FLimityn
	public FLimitSold
	public Fregdate
	public FReipgodate
	public FItemcouponyn
	public FItemCouponValue
	public FItemCouponType
	public FItemScore
	public FImageList
	public FImageList120
	public FImageSmall
	public FImageIcon1
	public FImageicon2
	public FItemSize
	public Fitemdiv
	public FImageBasic
'	public FImageBasic600
	public Fmakerid
	public FEvalCnt
	Public FIsusing
	public FCurrPage
	public FPageSize
	public FPageCount
	public FTotalPage
	public FTotalCount
	public FScrollCount
	public FResultCount
	public FItemArr
	public FFavCount
	public FRectSortMethod
	public FminPrice
	public FmaxPrice
	public FRectCateCode	'카테고리 코드
	public FdeliType1		'무료배송 (업체무료 : 2, 텐배무료 : 4 )
	public FdeliType2		'텐배배송 (텐배 : 1 )
	public Fpojangok		'포장상품여부
	public FmaxSalePercent	'최대 세일 %
	public FLowStockcnt		'매진임박상품(한정30개이하)
	public FLimitedLowStock
	public FSpecialUserItem
	public Fmaxidx
	public Fbestitem
	public Fnowsellitemcnt
	public Fnewsellregdate

	'// 해외직구배송작업추가
	Public FDeliverFixDay
	public FadultType

	Private Sub Class_Initialize()
		FCurrPage = 1
		FPageSize = 50
		Fbestitem = 0
		FTotalCount = 0
		FLowStockcnt = 0
		FResultCount = 0
		FScrollCount = 10
		FmaxSalePercent = 0
		FLimitedLowStock = 0
	End Sub
	Private Sub Class_Terminate()
	End Sub

	'// 우수회원샵 상품 여부
	public Function IsSpecialUserItem() '!
	    dim uLevel
	    uLevel = GetLoginUserLevel()
		IsSpecialUserItem = (FSpecialUserItem>0) and (uLevel>0 and uLevel<>5)
	end Function

	'// 세일포함 실제가격
	public Function getRealPrice() '!
		getRealPrice = FSellCash

		if (IsSpecialUserItem()) then
			getRealPrice = getSpecialShopItemPrice(FSellCash)
		end if
	end Function

	'// 할인율 '!
	public Function getSalePro()
		if FOrgprice=0 then
			getSalePro = 0 & "%"
		else
			getSalePro = CLng((FOrgPrice-getRealPrice)/FOrgPrice*100) & "%"
		end if
	end Function

	'//품절여부
	public Function IsSoldOut()
		'isSoldOut = (FSellYn="N")
		IF FLimitNo<>"" and FLimitSold<>"" Then
			isSoldOut = (FSellYn<>"Y") or ((FLimitYn = "Y") and (clng(FLimitNo)-clng(FLimitSold)<1))
		Else
			isSoldOut = (FSellYn<>"Y")
		End If
	end Function

	'//세일상품여부
 	public Function IsSaleItem() '!
	    IsSaleItem = ((FSaleYn="Y") and (FOrgPrice-FSellCash>0)) or (IsSpecialUserItem)
	end Function

 	'// 상품 쿠폰 여부
	public Function IsCouponItem() '!
			IsCouponItem = (FItemCouponYN = "Y")
	end Function

	'//	한정 여부 '!
	public Function IsLimitItem()
			IsLimitItem= (FLimitYn="Y")
	end Function

	'// 텐바이텐 포장가능 상품 여부
	public Function IsPojangitem()
		IsPojangitem = (FPojangOk="Y")
	end Function

	'// 텐바이텐 독점상품 여부 '!
	public Function IsTenOnlyitem()
		IsTenOnlyitem = (FTenOnlyYn="Y")
	end Function

	'// 신상품 여부 '!
	public Function IsNewItem()
			IsNewItem =	(datediff("d",FRegdate,now())<= 14)
	end Function

	'// 무료 배송 쿠폰 여부 '?
	public function IsFreeBeasongCoupon()
		IsFreeBeasongCoupon = Fitemcoupontype="3"
	end function

	'// 쿠폰 적용가
	public Function GetCouponAssignPrice() '!
		if (IsCouponItem) then
			GetCouponAssignPrice = getRealPrice - GetCouponDiscountPrice
		else
			GetCouponAssignPrice = getRealPrice
		end if
	end Function

	'// 해외직구배송작업추가(원승현)
	Public Function IsDirectPurchase()
		IsDirectPurchase = false
		if (FDeliverFixDay = "G") Then
			IsDirectPurchase = true
		End if
	End Function

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

	'// 상품 쿠폰 내용
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

	'// 판매완료상품 시간
	public function Gettimeset()
		dim MyDate, dtDiff
			MyDate = now()
			dtDiff = DateDiff("s", Fnewsellregdate, MyDate)
			if dtDiff < 60 then
				response.write "조금전"
			elseif(dtDiff < 3600) then
				dtDiff= dtDiff/60
				response.write int(dtDiff)&"분전"
			elseif(dtDiff < 86400)  then
				dtDiff= dtDiff/3600
				response.write int(dtDiff)&"시간전"
			elseif(dtDiff < 2419200)  then
				dtDiff= dtDiff/86400
				response.write int(dtDiff)&"일전"
			else
				response.write "오래전"
			end if
	end function

	''최대 세일 % top 1
	public function fnGetMaxSalePercent
		dim sqlStr

		sqlStr = "exec [db_sitemaster].[dbo].[sp_Ten_clearance_maxsalepercent]"

		rsget.CursorLocation = adUseClient
		rsget.Open sqlStr, dbget, adOpenForwardOnly, adLockReadOnly

		If Not rsget.EOF Then
			FmaxSalePercent = rsget("SalePercent")
			fnGetmaxSalePercent = FmaxSalePercent
		ELSE
			fnGetmaxSalePercent = 0
		End if
		rsget.close
	end function


	'// 롤링1 실시간 인기급상승( 4시간동안 판매량 top20 중 랜덤 5개)
	public Sub fnGetbestitem
		dim sqlStr
			sqlStr = "exec [db_sitemaster].[dbo].[sp_Ten_clearance_rolling_best_cnt]"

'			response.write sqlStr
'			response.end

			rsget.CursorLocation = adUseClient
			rsget.Open sqlStr, dbget, adOpenForwardOnly, adLockReadOnly

			IF Not (rsget.EOF OR rsget.BOF) THEN
				Fbestitem = rsget("cnt")
			END IF
			rsget.close

		IF Fbestitem > 4 Then
			sqlStr = "exec [db_sitemaster].[dbo].[sp_Ten_clearance_rolling_best_list]"

'			response.write sqlStr
'			response.end

			rsget.CursorLocation = adUseClient
			rsget.Open sqlStr, dbget, adOpenForwardOnly, adLockReadOnly

			i=0
			Fbestitem=5
			redim preserve FItemList(Fbestitem)
			if  not rsget.EOF  then
				do until rsget.eof
					set FItemList(i) = new CClearancesalelist
						FItemList(i).Fitemid				= rsget("itemid")
						FItemList(i).FSellYn				= rsget("sellyn")
						FItemList(i).FSaleYn     		= rsget("sailyn")
						FItemList(i).FRegdate 			= rsget("regdate")
						FItemList(i).Fevalcnt 			= rsget("evalCnt")
						FItemList(i).FItemSize			= rsget("evalCnt")
						FItemList(i).Fitemdiv			= rsget("itemdiv")
						FItemList(i).FLimitYn			= rsget("limityn")
						FItemList(i).FLimitNo			= rsget("limitno")
						FItemList(i).Fmakerid			= rsget("makerid")
						FItemList(i).FSellcash			= rsget("sellcash")
						FItemList(i).FOrgPrice			= rsget("orgprice")
						FItemList(i).FitemScore 			= rsget("itemScore")
						FItemList(i).FLimitSold			= rsget("limitsold")
						FItemList(i).FReipgodate			= rsget("reipgodate")
		              FItemList(i).Fitemcouponyn 		= rsget("itemcouponYn")
						FItemList(i).Fitemcoupontype	= rsget("itemCouponType")
						FItemList(i).FItemCouponValue	= rsget("itemCouponValue")
						FItemList(i).FItemName			= db2html(rsget("itemname"))
						FItemList(i).FBrandName  		= db2html(rsget("brandname"))
						FItemList(i).FImageList			= "http://webimage.10x10.co.kr/image/list/"&GetImageSubFolderByItemid(rsget("itemid"))&"/"& rsget("listimage")
						FItemList(i).FImageList120		= "http://webimage.10x10.co.kr/image/list120/"&GetImageSubFolderByItemid(rsget("itemid"))&"/"& rsget("listimage120")
						FItemList(i).FImageSmall		= "http://webimage.10x10.co.kr/image/small/"&GetImageSubFolderByItemid(rsget("itemid"))&"/"& rsget("smallImage")
						FItemList(i).FImageIcon1		= "http://webimage.10x10.co.kr/image/icon1/"&GetImageSubFolderByItemid(rsget("itemid"))&"/"& rsget("icon1image")
						FItemList(i).FImageIcon2		= "http://webimage.10x10.co.kr/image/icon2/"&GetImageSubFolderByItemid(rsget("itemid"))&"/"& rsget("icon2image")
						FItemList(i).FImageBasic		= "http://webimage.10x10.co.kr/image/basic/"&GetImageSubFolderByItemid(rsget("itemid"))&"/"& rsget("basicimage")
					i=i+1
					rsget.moveNext
				loop
			end if
			rsget.Close
		END IF
	End Sub

	'// 롤링2 매진임박, 재고가 얼마남지 않은 상품(한정상품 재고 asc top 5)
	public Sub fnGetLimitedLowStock
		dim sqlStr
			sqlStr = "exec [db_sitemaster].[dbo].[sp_Ten_Clearance_Rolling_LimitLowStock_Cnt]"

'			response.write sqlStr
'			response.end

			rsget.CursorLocation = adUseClient
			rsget.Open sqlStr, dbget, adOpenForwardOnly, adLockReadOnly

			IF Not (rsget.EOF OR rsget.BOF) THEN
				FLowStockcnt = rsget("cnt")
			END IF
			rsget.close

		IF FLowStockcnt > 4 Then
			sqlStr = "exec [db_sitemaster].[dbo].[sp_Ten_Clearance_Rolling_LimitLowStock_List]"

'			response.write sqlStr
'			response.end

			rsget.CursorLocation = adUseClient
			rsget.Open sqlStr, dbget, adOpenForwardOnly, adLockReadOnly

			i=0
			FLowStockcnt=5
			redim preserve FItemList(FLowStockcnt)
			if  not rsget.EOF  then
				do until rsget.eof
					set FItemList(i) = new CClearancesalelist
						FItemList(i).Fitemid			= rsget("itemid")
						FItemList(i).FSellYn			= rsget("sellyn")
						FItemList(i).FSaleYn     		= rsget("sailyn")
						FItemList(i).FRegdate 			= rsget("regdate")
						FItemList(i).Fevalcnt 			= rsget("evalCnt")
						FItemList(i).FItemSize			= rsget("evalCnt")
						FItemList(i).Fitemdiv			= rsget("itemdiv")
						FItemList(i).FLimitYn			= rsget("limityn")
						FItemList(i).FLimitNo			= rsget("limitno")
						FItemList(i).Fmakerid			= rsget("makerid")
						FItemList(i).FSellcash			= rsget("sellcash")
						FItemList(i).FOrgPrice			= rsget("orgprice")
						FItemList(i).FitemScore 		= rsget("itemScore")
						FItemList(i).FLimitSold			= rsget("limitsold")
						FItemList(i).FReipgodate		= rsget("reipgodate")
		                FItemList(i).Fitemcouponyn 		= rsget("itemcouponYn")
						FItemList(i).Fitemcoupontype	= rsget("itemCouponType")
						FItemList(i).FItemCouponValue	= rsget("itemCouponValue")
						FItemList(i).FLimitedLowStock	= rsget("LimitedLowStock")
						FItemList(i).FItemName			= db2html(rsget("itemname"))
						FItemList(i).FBrandName  		= db2html(rsget("brandname"))
						FItemList(i).FImageList			= "http://webimage.10x10.co.kr/image/list/"&GetImageSubFolderByItemid(rsget("itemid"))&"/"& rsget("listimage")
						FItemList(i).FImageList120		= "http://webimage.10x10.co.kr/image/list120/"&GetImageSubFolderByItemid(rsget("itemid"))&"/"& rsget("listimage120")
						FItemList(i).FImageSmall		= "http://webimage.10x10.co.kr/image/small/"&GetImageSubFolderByItemid(rsget("itemid"))&"/"& rsget("smallImage")
						FItemList(i).FImageIcon1		= "http://webimage.10x10.co.kr/image/icon1/"&GetImageSubFolderByItemid(rsget("itemid"))&"/"& rsget("icon1image")
						FItemList(i).FImageIcon2		= "http://webimage.10x10.co.kr/image/icon2/"&GetImageSubFolderByItemid(rsget("itemid"))&"/"& rsget("icon2image")
						FItemList(i).FImageBasic		= "http://webimage.10x10.co.kr/image/basic/"&GetImageSubFolderByItemid(rsget("itemid"))&"/"& rsget("basicimage")
					i=i+1
					rsget.moveNext
				loop
			end if
			rsget.Close
		END IF
	End Sub

	'// 롤링3, 방금전 판매된 상품(top 5)
	public Sub fnGetNewsellitem
		dim sqlStr
			sqlStr = "exec [db_sitemaster].[dbo].[sp_Ten_Clearance_Rolling_NewSellitem_cnt]"

'			response.write sqlStr
'			response.end

			rsget.CursorLocation = adUseClient
			rsget.Open sqlStr, dbget, adOpenForwardOnly, adLockReadOnly

			IF Not (rsget.EOF OR rsget.BOF) THEN
				Fnowsellitemcnt = rsget("cnt")
			END IF
			rsget.close

		IF Fnowsellitemcnt > 4 Then
			sqlStr = "exec [db_sitemaster].[dbo].[sp_Ten_Clearance_Rolling_NewSellitem_List]"

'			response.write sqlStr
'			response.end
			rsget.CursorLocation = adUseClient
			rsget.Open sqlStr, dbget, adOpenForwardOnly, adLockReadOnly

			i=0
			Fnowsellitemcnt=5
			redim preserve FItemList(Fnowsellitemcnt)
			if  not rsget.EOF  then
				do until rsget.eof
					set FItemList(i) = new CClearancesalelist
						FItemList(i).Fitemid			= rsget("itemid")
						FItemList(i).FSellYn			= rsget("sellyn")
						FItemList(i).FSaleYn     		= rsget("sailyn")
						FItemList(i).FRegdate 			= rsget("regdate")
						FItemList(i).Fevalcnt 			= rsget("evalCnt")
						FItemList(i).FItemSize			= rsget("evalCnt")
						FItemList(i).Fitemdiv			= rsget("itemdiv")
						FItemList(i).FLimitYn			= rsget("limityn")
						FItemList(i).FLimitNo			= rsget("limitno")
						FItemList(i).Fmakerid			= rsget("makerid")
						FItemList(i).FSellcash			= rsget("sellcash")
						FItemList(i).FOrgPrice			= rsget("orgprice")
						FItemList(i).FitemScore 		= rsget("itemScore")
						FItemList(i).FLimitSold			= rsget("limitsold")
						FItemList(i).FReipgodate		= rsget("reipgodate")
		                FItemList(i).Fitemcouponyn 		= rsget("itemcouponYn")
						FItemList(i).Fitemcoupontype	= rsget("itemCouponType")
						FItemList(i).Fnewsellregdate	= rsget("newsellregdate")
						FItemList(i).FItemCouponValue	= rsget("itemCouponValue")
						FItemList(i).FItemName			= db2html(rsget("itemname"))
						FItemList(i).FBrandName  		= db2html(rsget("brandname"))
						FItemList(i).FImageList			= "http://webimage.10x10.co.kr/image/list/"&GetImageSubFolderByItemid(rsget("itemid"))&"/"& rsget("listimage")
						FItemList(i).FImageList120		= "http://webimage.10x10.co.kr/image/list120/"&GetImageSubFolderByItemid(rsget("itemid"))&"/"& rsget("listimage120")
						FItemList(i).FImageSmall		= "http://webimage.10x10.co.kr/image/small/"&GetImageSubFolderByItemid(rsget("itemid"))&"/"& rsget("smallImage")
						FItemList(i).FImageIcon1		= "http://webimage.10x10.co.kr/image/icon1/"&GetImageSubFolderByItemid(rsget("itemid"))&"/"& rsget("icon1image")
						FItemList(i).FImageIcon2		= "http://webimage.10x10.co.kr/image/icon2/"&GetImageSubFolderByItemid(rsget("itemid"))&"/"& rsget("icon2image")
						FItemList(i).FImageBasic		= "http://webimage.10x10.co.kr/image/basic/"&GetImageSubFolderByItemid(rsget("itemid"))&"/"& rsget("basicimage")
					i=i+1
					rsget.moveNext
				loop
			end if
			rsget.Close
		END IF
	End Sub

	''클리어런스 상품 리스트
	public Sub fnGetClearancesaleList
		dim sqlStr, sqlsearch, i, vOrderBy

		'상품 총 갯수 구하기
		sqlStr = "exec [db_sitemaster].[dbo].[sp_Ten_clearance_list_cnt] '"&FminPrice&"', '"&FmaxPrice&"', '"&FRectCateCode&"', '"&FdeliType1&"', '"&FdeliType2&"', '"&Fpojangok&"', "&FPageSize&""

		'response.write sqlStr
		'response.end

		dim rsMem : set rsMem = getDBCacheSQL(dbget,rsget,"DIAW",sqlStr,180)
        if (rsMem is Nothing) then Exit Sub ''추가
			Fmaxidx = rsMem("idx")
			FTotalCount = rsMem("cnt")
			FTotalPage = rsMem("totPg")
		rsMem.Close

		'지정페이지가 전체 페이지보다 클 때 함수종료
		if Cint(FCurrPage)>Cint(FTotalPage) then
			FResultCount = 0
			exit sub
		end if

		If FTotalCount > 0 Then
			if FRectSortMethod="ne" then						''신상순
				vOrderBy = vOrderBy & " order by i.itemid desc"
			elseif FRectSortMethod="be" then					''인기순
				vOrderBy = vOrderBy & " order by i.itemscore desc"
			elseif FRectSortMethod="lp" then					''낮은가격순
				vOrderBy = vOrderBy & " order by i.sellcash asc"
			elseif FRectSortMethod="hp" then					''높은가격순
				vOrderBy = vOrderBy & " order by i.sellcash desc"
			elseif FRectSortMethod="hs" then					''높은할인율순
				vOrderBy = vOrderBy & " order by SalePercent desc"
			else
				vOrderBy = vOrderBy & " order by i.itemid desc"
			end if

			'데이터 리스트
			sqlStr = " EXECUTE [db_sitemaster].[dbo].[sp_Ten_clearance_list] '" & Cstr(FPageSize * FCurrPage) & "', '"&FminPrice&"', '"&FmaxPrice&"', '"&FRectCateCode&"', '"&FdeliType1&"', '"&FdeliType2&"', '"&Fpojangok&"', "&Fmaxidx&", '"&vOrderBy&"' "

			'response.write sqlStr
			'response.end

			set rsMem = getDBCacheSQL(dbget,rsMem,"DIAW",sqlStr,180)
	        if (rsMem is Nothing) then Exit Sub ''추가

			rsMem.pagesize = FPageSize
			
			FResultCount = rsMem.RecordCount-(FPageSize*(FCurrPage-1))
	        if (FResultCount<1) then FResultCount=0
			redim preserve FItemList(FResultCount)
			
			if  not rsMem.EOF  then
				rsMem.absolutePage=FCurrPage
				do until rsMem.eof
					set FItemList(i) = new CClearancesalelist
	
					FItemList(i).Fitemid			= rsMem("itemid")
					FItemList(i).FSellYn			= rsMem("sellyn")
					FItemList(i).FSaleYn     		= rsMem("sailyn")
					FItemList(i).FRegdate 			= rsMem("regdate")
					FItemList(i).Fevalcnt 			= rsMem("evalCnt")
					FItemList(i).FItemSize			= rsMem("evalCnt")
					FItemList(i).Ffavcount			= rsMem("favcount")
					FItemList(i).Fitemdiv			= rsMem("itemdiv")
					FItemList(i).FLimitYn			= rsMem("limityn")
					FItemList(i).FLimitNo			= rsMem("limitno")
					FItemList(i).Fmakerid			= rsMem("makerid")
					FItemList(i).FSellcash			= rsMem("sellcash")
					FItemList(i).FOrgPrice			= rsMem("orgprice")
					FItemList(i).FitemScore 		= rsMem("itemScore")
					FItemList(i).FLimitSold			= rsMem("limitsold")
					FItemList(i).FReipgodate		= rsMem("reipgodate")
	                FItemList(i).Fitemcouponyn 		= rsMem("itemcouponYn")
					FItemList(i).Fitemcoupontype	= rsMem("itemCouponType")
					FItemList(i).FItemCouponValue	= rsMem("itemCouponValue")
					FItemList(i).FItemName			= db2html(rsMem("itemname"))
					FItemList(i).FBrandName  		= db2html(rsMem("brandname"))
					FItemList(i).FImageList			= "http://webimage.10x10.co.kr/image/list/"&GetImageSubFolderByItemid(rsMem("itemid"))&"/"& rsMem("listimage")
					FItemList(i).FImageList120		= "http://webimage.10x10.co.kr/image/list120/"&GetImageSubFolderByItemid(rsMem("itemid"))&"/"& rsMem("listimage120")
					FItemList(i).FImageSmall		= "http://webimage.10x10.co.kr/image/small/"&GetImageSubFolderByItemid(rsMem("itemid"))&"/"& rsMem("smallImage")
					FItemList(i).FImageIcon1		= "http://webimage.10x10.co.kr/image/icon1/"&GetImageSubFolderByItemid(rsMem("itemid"))&"/"& rsMem("icon1image")
					FItemList(i).FImageIcon2		= "http://webimage.10x10.co.kr/image/icon2/"&GetImageSubFolderByItemid(rsMem("itemid"))&"/"& rsMem("icon2image")
					FItemList(i).FImageBasic		= "http://webimage.10x10.co.kr/image/basic/"&GetImageSubFolderByItemid(rsMem("itemid"))&"/"& rsMem("basicimage")
					FItemList(i).FadultType			= rsMem("adultType")

					'// 해외직구배송작업추가
					FItemList(i).FDeliverFixDay		= rsMem("deliverfixday")

					i=i+1
					rsMem.moveNext
				loop
			end if
			rsMem.Close
			'response.write sqlStr &"<br>"
		end if
	end Sub

	'// 클리어런스 세일 상품 여부 확인
	public function fnIsClearanceItem()
		dim sqlStr

		sqlStr = "exec [db_sitemaster].[dbo].[sp_Ten_Clearance_itemChk] '" & Fitemid & "'"
		rsget.CursorLocation = adUseClient
		rsget.Open sqlStr, dbget, adOpenForwardOnly, adLockReadOnly

		If Not rsget.EOF Then
			fnIsClearanceItem = rsget("cnt")>0
		ELSE
			fnIsClearanceItem = false
		End if
		rsget.close
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
end class

%>
	