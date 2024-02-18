<%

class CEvaluateSearcherItem
	Public Fidx
	public FUserID
	public FTitle
	public FUesdContents
	public FManiaPoint
	public FTotalPoint
	public FPoint
	public FPoint_fun
	public FPoint_dgn
	public FPoint_prc
	public FPoint_stf
	public Fimgsmall
	public fEval_excludeyn
	public FEval_isusing

	public FIcon1
	public FIcon2

	public Flinkimg1
	public Flinkimg2
	public Flinkimg3
	public Flinkimg4
	public Flinkimg5

	Public FImgContents1
	Public FImgContents2
	Public FImgContents3
	Public FImgContents4
	Public FImgContents5

	public FItemID
	public Fimglist
	Public Fgubun
	public FRegdate

	Public FItemname
	Public FItemCost
	Public FItemDiv
	Public FItemOption
	''Public FOpenOptionYN			'// 사옹안함(옵션 비공개로 하면 옵션명을 날린다.)
	Public FOptionName
	Public FMakerName
	Public FMakerID
	Public FOrderSerial
	Public FOrderDate
	Public FImageList100
	Public FImageList120
	Public FEvalRegDate
	Public FEvalCnt
	Public FEvalcnt_photo '2012 포토cnt
	Public FEvalcnt_tester '2012 테스터cnt
	Public FEvalOffCnt		'2018 오프샵cnt

	Public FFavCount

	Public F100ShopIdx
	Public FCouponName
	Public FCouponValue
	Public FCouponType
	Public FCouponStartDate
	Public FCouponExpireDate
	Public Fminbuyprice

	Public Fhitcount
	Public Fcommentcount
	Public Fscoresum
	Public Fsellcash
	Public Fcontents
	Public Fnourlfile1
	Public Ffile1
	Public Fnourlfile2
	Public Ffile2
	Public Fnourlfile3
	Public Ffile3
	Public Fnourlfile4
	Public Ffile4
	Public Fnourlfile5
	Public Ffile5
	Public Fnourlicon1

	Public FstartDate
	Public FendDate

	Public FUseGood
	Public FUseBad
	Public FUseETC
	Public FMyBlog
	Public FIsPhoto
	Public FDetailIDX
	Public FShopName

    public function IsTicketItem
        IsTicketItem = false
        if IsNULL(FItemDiv) then Exit function

        IsTicketItem = (FItemDiv="08")
    end function

	public Function getUsingTitle(LimitSize)

		if Len(FUesdContents) > LimitSize then
			getUsingTitle = Left(FUesdContents,LimitSize) + "..."
		else
			getUsingTitle = FUesdContents
		end if

	end Function

	public function IsPhotoExist()
		IsPhotoExist = (Flinkimg1<>"") or (Flinkimg2<>"")
	end function

	public Function getLinkImage1()
		if Fgubun="0" then
			getLinkImage1 = "http://imgstatic.10x10.co.kr/goodsimage/" + GetImageSubFolderByItemid(Fitemid) + "/" + Flinkimg1
		else
			getLinkImage1 = "http://imgstatic.10x10.co.kr/contents/maniaimg/evaluate/" & CStr(Fgubun) & "/file1/" + Flinkimg1
		end if
	end function

	public Function getLinkImage2()
		if Fgubun="0" then
			getLinkImage2 =	"http://imgstatic.10x10.co.kr/goodsimage/" + GetImageSubFolderByItemid(Fitemid) + "/" + Flinkimg2
		else
			getLinkImage2 = "http://imgstatic.10x10.co.kr/contents/maniaimg/evaluate/" & CStr(Fgubun) & "/file2/" + Flinkimg2
		end if
	end function

	public Function getLinkImage3()
		if Fgubun="0" then
			getLinkImage3 =	"http://imgstatic.10x10.co.kr/goodsimage/" + GetImageSubFolderByItemid(Fitemid) + "/" + Flinkimg3
		else
			getLinkImage3 = "http://imgstatic.10x10.co.kr/contents/maniaimg/evaluate/" & CStr(Fgubun) & "/file3/" + Flinkimg3
		end if
	end function

	public Function getLinkImage4()
		if Fgubun="0" then
			getLinkImage4 =	"http://imgstatic.10x10.co.kr/goodsimage/" + GetImageSubFolderByItemid(Fitemid) + "/" + Flinkimg4
		else
			getLinkImage4 = "http://imgstatic.10x10.co.kr/contents/maniaimg/evaluate/" & CStr(Fgubun) & "/file4/" + Flinkimg4
		end if
	end function

	public Function getLinkImage5()
		if Fgubun="0" then
			getLinkImage5 =	"http://imgstatic.10x10.co.kr/goodsimage/" + GetImageSubFolderByItemid(Fitemid) + "/" + Flinkimg5
		else
			getLinkImage5 = "http://imgstatic.10x10.co.kr/contents/maniaimg/evaluate/" & CStr(Fgubun) & "/file5/" + Flinkimg5
		end if
	end function

	public Function getIconImage1()
		if Fgubun="0" then
			getIconImage1 =	"http://imgstatic.10x10.co.kr/goodsimage/" + GetImageSubFolderByItemid(Fitemid) + "/" + FIcon1
		else
			getIconImage1 = "http://imgstatic.10x10.co.kr/contents/maniaimg/evaluate/" & CStr(Fgubun) & "/icon1/" + FIcon1
		end if
	end function

	public Function getIconImage2()
		if Fgubun="0" then
			getIconImage2 =	"http://imgstatic.10x10.co.kr/goodsimage/" + GetImageSubFolderByItemid(Fitemid) + "/" + FIcon2
		else
			getIconImage2 = "http://imgstatic.10x10.co.kr/contents/maniaimg/evaluate/" & CStr(Fgubun) & "/icon2/" + FIcon2
		end if
	end function


	Private Sub Class_Terminate()

	End Sub

	public sub Class_Initialize()

	end sub
end Class

Class CEvaluateSearcher
	public FItemList()
	public FcdLCnt()
	public FcdLTotalPage
	public FEvalItem


	public FTotTotalCount
	public FTotalCount
	public FResultCount
	public FCurrPage
	public FTotalPage
	public FPageSize
	public FScrollCount

	public FGubun
	public FIdx
	public FRectUserID
	public FRectItemID
	public FECode				'// 이벤트코드
	Public FCateCode			'// 카테고리 코드(2013-09-26 skyer9)
	public FDiscountRate
	public FRectStartPoint
	public FSortMethod
	public FEvalDiv
	public FRectcdL
	public FRectEvaluatedYN
	public FRectOrderSerial
	public FRectOption
	public FRectSearchtype
	public FRectsearchrect
	public FRectMileage

	Private Sub Class_Initialize()
		redim preserve FItemList(0)

		FCurrPage     = 1
		FPageSize     = 5
		FResultCount  = 0
		FScrollCount  = 10
		FTotalCount   = 0

		FDiscountRate = 1
	End Sub

	Private Sub Class_Terminate()

	End Sub



	public sub getItemEvalList()
		dim sqlStr,i

		sqlStr = "exec [db_board].[dbo].[usp_WWW_Board_ItemEvaluate_TotalCount_Get] '" & CStr(FPageSize) & "','" + Cstr(FRectItemID) + "','" + Cstr(FEvalDiv)+ "','" + Cstr(FsortMethod)+ "','" + Cstr(FRectOption) + "'" + vbcrlf

		rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
		rsget.Open sqlStr,dbget

		FTotalCount = rsget("TotalCnt")
		FTotalPage =  rsget("TotalPage")
		rsget.close

		sqlStr = "exec [db_board].[dbo].[usp_WWW_Board_ItemEvaluate_List_Get] '" +  CStr(FPageSize) + "','" + CStr(FCurrPage) + "','" + Cstr(FRectItemID) + "','" + Cstr(FEvalDiv)+ "','" + Cstr(FsortMethod) + "','" + Cstr(FRectOption) + "'" + vbcrlf
'Response.write sqlStr
		rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
		rsget.Open sqlStr,dbget

		FResultCount = rsget.RecordCount

		redim preserve FItemList(FResultCount)
		i=0
		if  not rsget.EOF  then
			do until rsget.eof
				set FItemList(i) = new CEvaluateSearcherItem


				FItemList(i).Fidx				= rsget("idx")
				FItemList(i).Fgubun			= rsget("Gubun")
				FItemList(i).FUserID			= rsget("UserID")
				FItemList(i).FItemID			= rsget("ItemID")
				FItemList(i).FTotalPoint			= rsget("TotalPoint")
				FItemList(i).FUesdContents 	= db2html(rsget("contents"))
				FItemList(i).FPoint_fun			= rsget("Point_Function")
				FItemList(i).FPoint_dgn			= rsget("Point_Design")
				FItemList(i).FPoint_prc			= rsget("Point_Price")
				FItemList(i).FPoint_stf			= rsget("Point_Satisfy")
				FItemList(i).FRegdate 		= rsget("RegDate")
				FItemList(i).Flinkimg1		= rsget("file1")
				FItemList(i).Flinkimg2		= rsget("file2")
				FItemList(i).Flinkimg3		= rsget("file3")''2017-07-28 유태욱 추가 및 프로시저 수정
				FItemList(i).FOptionName		= rsget("itemoptionname")
				FItemList(i).FShopName			= rsget("shopname")

				'// 과거자료 중 0점이 존재 1점으로 표시
				if FItemList(i).FTotalPoint="0" then FItemList(i).FTotalPoint="1"
				if FItemList(i).FPoint_fun="0" then FItemList(i).FPoint_fun="1"
				if FItemList(i).FPoint_dgn="0" then FItemList(i).FPoint_dgn="1"
				if FItemList(i).FPoint_prc="0" then FItemList(i).FPoint_prc="1"
				if FItemList(i).FPoint_stf="0" then FItemList(i).FPoint_stf="1"

				i=i+1
				rsget.moveNext
			loop
		end if

		rsget.Close
	end sub

	public sub getItemEvalOne()
		dim sqlStr,i

		sqlStr = "exec [db_board].[dbo].sp_Ten_Evaluate '1','1','" + Cstr(FRectItemID) + "','','" + Cstr(FIdx) + "',''" + vbcrlf


		rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
		rsget.Open sqlStr,dbget

		FResultCount = rsget.RecordCount

		i=0
		set FEvalItem = new CEvaluateSearcherItem
		if  not rsget.EOF  then
			FEvalItem.Fidx			= rsget("idx")
			FEvalItem.Fgubun		= rsget("Gubun")
			FEvalItem.FUserID		= rsget("UserID")
			FEvalItem.FItemID		= rsget("ItemID")
			FEvalItem.FTotalPoint	= rsget("TotalPoint")
			FEvalItem.FUesdContents = db2html(rsget("contents"))
			FEvalItem.FPoint_fun	= rsget("Point_Function")
			FEvalItem.FPoint_dgn	= rsget("Point_Design")
			FEvalItem.FPoint_prc	= rsget("Point_Price")
			FEvalItem.FPoint_stf	= rsget("Point_Satisfy")
			FEvalItem.FRegdate 		= rsget("RegDate")
			FEvalItem.Flinkimg1		= rsget("file1")
			FEvalItem.Flinkimg2		= rsget("file2")
			FEvalItem.FOptionName	= rsget("itemoptionname")

		end if

		rsget.Close
	end sub

	public sub getBestItemEvalList()
		dim sqlStr,i

		sqlStr = "exec [db_board].[dbo].sp_Ten_BestGoodUsing '" +  CStr(FPageSize) + "','" + Cstr(FRectItemID) + "','" + Cstr(Fidx) + "'" + vbcrlf

		rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
		rsget.Open sqlStr,dbget

		FResultCount = rsget.RecordCount

		redim preserve FItemList(FResultCount)
		i=0
		if  not rsget.EOF  then
			do until rsget.eof
				set FItemList(i) = new CEvaluateSearcherItem

				FItemList(i).Fidx				= rsget("idx")
				FItemList(i).FUserID			= rsget("UserID")
				FItemList(i).FItemID			= rsget("ItemID")
				FItemList(i).FTotalPoint		= rsget("TotalPoint")
				FItemList(i).FUesdContents 		= db2html(rsget("contents"))
				FItemList(i).FRegdate 			= rsget("RegDate")

				i=i+1
				rsget.moveNext
			loop
		end if

		rsget.Close
	end sub

	public Sub GetHisGoodUsingList()
		dim sqlStr,i

		sqlStr = "exec [db_board].[dbo].ten_fingers_goodusing_tcnt '" + Cstr(FRectItemID) + "'" + vbcrlf

		rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
		rsget.Open sqlStr, dbget, 1

		FTotalCount = rsget("cnt")
		rsget.close



		sqlStr = "exec [db_board].[dbo].ten_fingers_goodusing '" +  CStr(FPageSize*FCurrPage) + "','" + Cstr(FRectItemID) + "'" + vbcrlf


		rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
		rsget.pagesize = FPageSize
		rsget.Open sqlStr,dbget,1

		FTotalPage =  CInt(FTotalCount\FPageSize)
		if  (FTotalCount\FPageSize)<>(FTotalCount/FPageSize) then
			FTotalPage = FTotalPage +1
		end if
		FResultCount = rsget.RecordCount-(FPageSize*(FCurrPage-1))

		redim preserve FItemList(FResultCount)
		i=0
		if  not rsget.EOF  then
			rsget.absolutepage = FCurrPage
			do until rsget.eof
				set FItemList(i) = new CEvaluateSearcherItem

					 FItemList(i).Fgubun = rsget("gubun")
					 FItemList(i).FUserID       = rsget("userid")
					 FItemList(i).FItemID       = rsget("itemid")
					 FItemList(i).FPoint        = rsget("TotalPoint")
					 FItemList(i).FUesdContents = db2html(rsget("contents"))
					 FItemList(i).FPoint_fun       = rsget("Point_Function")
					 FItemList(i).FPoint_dgn        = rsget("Point_Design")
					 FItemList(i).FPoint_prc        = rsget("Point_Price")
					 FItemList(i).FPoint_stf        = rsget("Point_Satisfy")
					 FItemList(i).FRegdate 	= rsget("regdate")
					 FItemList(i).Flinkimg1	= rsget("file1")
					 FItemList(i).Flinkimg2	= rsget("file2")

				i=i+1
				rsget.moveNext
			loop
		end if
		rsget.close

	end Sub

	'' Top N개
	public Sub GetTopEventGoodUsingList()
		dim sqlStr,i

		sqlStr = "exec [db_board].[dbo].[sp_Ten_event_GoodUsing_Tcnt_New] '" & CStr(FPageSize) & "','" + Cstr(FRectItemID) + "','" + Cstr(FRectStartPoint) + "','" + Cstr(Fidx) + "','" + Cstr(FsortMethod)+ "','" + Cstr(FRectOption) + "','" + Cstr(FECode) + "'" + vbcrlf

		rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
		rsget.Open sqlStr,dbget

		FTotalCount = rsget("TotalCnt")
		FTotalPage =  rsget("TotalPage")
		rsget.close

		If FGubun = "" Then
		    if (FTotalCount>0) then
    			sqlStr = "exec [db_board].[dbo].[sp_Ten_event_GoodUsing_New] '" +  CStr(FPageSize) + "','" + CStr(FCurrPage) + "','" + Cstr(FRectItemID) + "','" + Cstr(FRectStartPoint) + "','" + Cstr(Fidx) + "','" + Cstr(FsortMethod) + "','" + Cstr(FRectOption) + "','" + Cstr(FECode) + "'" + vbcrlf

    			rsget.CursorLocation = adUseClient
    			rsget.CursorType = adOpenStatic
    			rsget.LockType = adLockOptimistic
    			rsget.Open sqlStr,dbget

    			FResultCount = rsget.RecordCount

    			redim preserve FItemList(FResultCount)
    			i=0
    			if  not rsget.EOF  then
    				do until rsget.eof
    					set FItemList(i) = new CEvaluateSearcherItem


    					FItemList(i).Fidx				= rsget("idx")
    					FItemList(i).Fgubun			= rsget("Gubun")
    					FItemList(i).FUserID			= rsget("UserID")
    					FItemList(i).FItemID			= rsget("ItemID")
    					FItemList(i).FTotalPoint			= rsget("TotalPoint")
    					FItemList(i).FUesdContents 	= db2html(rsget("contents"))
    					FItemList(i).FPoint_fun			= rsget("Point_Function")
    					FItemList(i).FPoint_dgn			= rsget("Point_Design")
    					FItemList(i).FPoint_prc			= rsget("Point_Price")
    					FItemList(i).FPoint_stf			= rsget("Point_Satisfy")
    					FItemList(i).FRegdate 		= rsget("RegDate")
    					FItemList(i).Flinkimg1		= rsget("file1")
    					FItemList(i).Flinkimg2		= rsget("file2")
    					FItemList(i).FOptionName		= rsget("itemoptionname")
    					FItemList(i).FItemname		= db2html(rsget("itemname"))
    					FItemList(i).FMakerID		= rsget("makerid")
    					FItemList(i).FMakerName		= db2html(rsget("brandname"))
    					FItemList(i).FItemID		= rsget("itemid")
    					FItemList(i).FImageList120	= "http://webimage.10x10.co.kr/image/list120/"&GetImageSubFolderByItemid(rsget("itemid"))&"/"&rsget("listimage120")


    					'// 과거자료 중 0점이 존재 1점으로 표시
    					if FItemList(i).FTotalPoint="0" then FItemList(i).FTotalPoint="1"
    					if FItemList(i).FPoint_fun="0" then FItemList(i).FPoint_fun="1"
    					if FItemList(i).FPoint_dgn="0" then FItemList(i).FPoint_dgn="1"
    					if FItemList(i).FPoint_prc="0" then FItemList(i).FPoint_prc="1"
    					if FItemList(i).FPoint_stf="0" then FItemList(i).FPoint_stf="1"

    					i=i+1
    					rsget.moveNext
    				loop
    			end if

    			rsget.Close
    		end if
		End IF
    end Sub

    '' Top N개 캐시 2015 추가
	public Sub GetTopEventGoodUsingList_B()
		dim sqlStr,i

		sqlStr = "exec [db_board].[dbo].[sp_Ten_event_GoodUsing_Tcnt_New] '" & CStr(FPageSize) & "','" + Cstr(FRectItemID) + "','" + Cstr(FRectStartPoint) + "','" + Cstr(Fidx) + "','" + Cstr(FsortMethod)+ "','" + Cstr(FRectOption) + "','" + Cstr(FECode) + "'" + vbcrlf

		dim rsMem : set rsMem = getDBCacheSQL(dbget,rsget,"SPCS",sqlStr,60*20)
		if (rsMem is Nothing) then Exit Sub ''추가
		    
		IF Not (rsMem.EOF OR rsMem.BOF) THEN
    		FTotalCount = rsMem("TotalCnt")
    		FTotalPage =  rsMem("TotalPage")
		END IF
		rsMem.close

		If FGubun = "" Then
		    if (FTotalCount>0) then
    			sqlStr = "exec [db_board].[dbo].[sp_Ten_event_GoodUsing_New] '" +  CStr(FPageSize) + "','" + CStr(FCurrPage) + "','" + Cstr(FRectItemID) + "','" + Cstr(FRectStartPoint) + "','" + Cstr(Fidx) + "','" + Cstr(FsortMethod) + "','" + Cstr(FRectOption) + "','" + Cstr(FECode) + "'" + vbcrlf

    			set rsMem = getDBCacheSQL(dbget,rsget,"SPCS",sqlStr,60*20)
			    if (rsMem is Nothing) then Exit Sub ''추가
			    
			    FResultCount = rsMem.RecordCount

    			redim preserve FItemList(FResultCount)
    			i=0
    			if  not rsMem.EOF  then
    				do until rsMem.eof
    					set FItemList(i) = new CEvaluateSearcherItem


    					FItemList(i).Fidx				= rsMem("idx")
    					FItemList(i).Fgubun			    = rsMem("Gubun")
    					FItemList(i).FUserID			= rsMem("UserID")
    					FItemList(i).FItemID			= rsMem("ItemID")
    					FItemList(i).FTotalPoint		= rsMem("TotalPoint")
    					FItemList(i).FUesdContents 	    = db2html(rsMem("contents"))
    					FItemList(i).FPoint_fun			= rsMem("Point_Function")
    					FItemList(i).FPoint_dgn			= rsMem("Point_Design")
    					FItemList(i).FPoint_prc			= rsMem("Point_Price")
    					FItemList(i).FPoint_stf			= rsMem("Point_Satisfy")
    					FItemList(i).FRegdate 		= rsMem("RegDate")
    					FItemList(i).Flinkimg1		= rsMem("file1")
    					FItemList(i).Flinkimg2		= rsMem("file2")
    					FItemList(i).FOptionName	= rsMem("itemoptionname")
    					FItemList(i).FItemname		= db2html(rsMem("itemname"))
    					FItemList(i).FMakerID		= rsMem("makerid")
    					FItemList(i).FMakerName		= db2html(rsMem("brandname"))
    					FItemList(i).FItemID		= rsMem("itemid")
    					FItemList(i).FImageList120	= "http://webimage.10x10.co.kr/image/list120/"&GetImageSubFolderByItemid(rsMem("itemid"))&"/"&rsMem("listimage120")


    					'// 과거자료 중 0점이 존재 1점으로 표시
    					if FItemList(i).FTotalPoint="0" then FItemList(i).FTotalPoint="1"
    					if FItemList(i).FPoint_fun="0" then FItemList(i).FPoint_fun="1"
    					if FItemList(i).FPoint_dgn="0" then FItemList(i).FPoint_dgn="1"
    					if FItemList(i).FPoint_prc="0" then FItemList(i).FPoint_prc="1"
    					if FItemList(i).FPoint_stf="0" then FItemList(i).FPoint_stf="1"

    					i=i+1
    					rsMem.moveNext
    				loop
    			end if

    			rsMem.Close
    		end if
		End IF
    end Sub

	public Sub GetEventGoodUsingList()
		dim sqlStr,i

		sqlStr = "exec [db_board].[dbo].sp_Ten_event_goodusing_tcnt '" + Cstr(FECode) + "'" + vbcrlf

		rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
		rsget.Open sqlStr, dbget, 1

		FTotalCount = rsget(0)
		rsget.close



		sqlStr = "exec  [db_board].[dbo].sp_Ten_event_goodusing '" +  CStr(FPageSize*FCurrPage) + "','" + Cstr(FECode) + "'" + vbcrlf

		rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
		rsget.pagesize = FPageSize
		rsget.Open sqlStr,dbget,1

		FTotalPage =  CInt(FTotalCount\FPageSize)
		if  (FTotalCount\FPageSize)<>(FTotalCount/FPageSize) then
			FTotalPage = FTotalPage +1
		end if
		FResultCount = rsget.RecordCount-(FPageSize*(FCurrPage-1))

		redim preserve FItemList(FResultCount)
		i=0
		if  not rsget.EOF  then
			rsget.absolutepage = FCurrPage
			do until rsget.eof
				set FItemList(i) = new CEvaluateSearcherItem

					 FItemList(i).Fgubun = rsget("gubun")
					 FItemList(i).FUserID       = rsget("userid")
					 FItemList(i).FItemID       = rsget("itemid")
					 FItemList(i).FTotalPoint   = rsget("TotalPoint")
					 FItemList(i).FUesdContents = db2html(rsget("contents"))
					 FItemList(i).FPoint_fun       = rsget("Point_Function")
					 FItemList(i).FPoint_dgn        = rsget("Point_Design")
					 FItemList(i).FPoint_prc        = rsget("Point_Price")
					 FItemList(i).FPoint_stf        = rsget("Point_Satisfy")
					 FItemList(i).FRegdate 	= rsget("regdate")
					 FItemList(i).Flinkimg1	= rsget("file1")
					 FItemList(i).Flinkimg2	= rsget("file2")
					 FItemList(i).FImageList100 	= "http://webimage.10x10.co.kr/image/list/" + GetImageSubFolderByItemid(rsget("itemid")) + "/" + rsget("listimage")
					 FItemList(i).Fimgsmall			= "http://webimage.10x10.co.kr/image/small/" + GetImageSubFolderByItemid(rsget("itemid")) + "/" + rsget("smallimage")
				If FItemList(i).Fgubun = "01" then
					 if FItemList(i).Flinkimg1<>"" then
						 FItemList(i).Flinkimg1 = "http://imgstatic.10x10.co.kr/goodsimage/" + GetImageSubFolderByItemid(FItemList(i).FItemID) + "/" + FItemList(i).Flinkimg1
					 end if

					 if FItemList(i).Flinkimg2<>"" then
						 FItemList(i).Flinkimg2 = "http://imgstatic.10x10.co.kr/goodsimage/" + GetImageSubFolderByItemid(FItemList(i).FItemID) + "/" + FItemList(i).Flinkimg2
					 end If
				elseIf FItemList(i).Fgubun = "02" then
					 if FItemList(i).Flinkimg1<>"" then
						 FItemList(i).Flinkimg1 = "http://imgstatic.10x10.co.kr/contents/album/" + FItemList(i).Flinkimg1
					 end if

					 if FItemList(i).Flinkimg2<>"" then
						 FItemList(i).Flinkimg2 = "http://imgstatic.10x10.co.kr/contents/album/" + FItemList(i).Flinkimg2
					 end If
				elseIf FItemList(i).Fgubun = "03" then
					 if FItemList(i).Flinkimg1<>"" then
						 FItemList(i).Flinkimg1 = "http://imgstatic.10x10.co.kr/contents/maniaimg/evaluate/file1/" + FItemList(i).Flinkimg1
					 end if

					 if FItemList(i).Flinkimg2<>"" then
						 FItemList(i).Flinkimg2 = "http://imgstatic.10x10.co.kr/contents/maniaimg/evaluate/file2/" + FItemList(i).Flinkimg2
					 end If
				End If

				i=i+1
				rsget.moveNext
			loop
		end if
		rsget.close

	end Sub

	'' 카테고리 관련 상품후기 Top N개
	public Sub GetTopCateGoodUsingList()
		dim sqlStr,i

		sqlStr = "exec  [db_board].[dbo].[sp_Ten_Category_goodusing] '" +  CStr(FPageSize*FCurrPage) + "','" + Cstr(FRectCdl) + "','" + Cstr(FRectStartPoint) + "'" + vbcrlf

		rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
		rsget.pagesize = FPageSize
		rsget.Open sqlStr,dbget,1

		FResultCount = rsget.RecordCount
        if (FResultCount<1) then FResultCount=0

		redim preserve FItemList(FResultCount)
		i=0
		if  not rsget.EOF  then
			rsget.absolutepage = FCurrPage
			do until rsget.eof
				set FItemList(i) = new CEvaluateSearcherItem

					 FItemList(i).Fgubun = rsget("gubun")
					 FItemList(i).FUserID       = rsget("userid")
					 FItemList(i).FItemID       = rsget("itemid")
					 FItemList(i).FTotalPoint   = rsget("TotalPoint")
					 FItemList(i).FUesdContents = db2html(rsget("contents"))
					 FItemList(i).FPoint_fun       = rsget("Point_Function")
					 FItemList(i).FPoint_dgn        = rsget("Point_Design")
					 FItemList(i).FPoint_prc        = rsget("Point_Price")
					 FItemList(i).FPoint_stf        = rsget("Point_Satisfy")
					 FItemList(i).FRegdate 	= rsget("regdate")
					 FItemList(i).Flinkimg1	= rsget("file1")
					 FItemList(i).Flinkimg2	= rsget("file2")
					 FItemList(i).FImageList100 	= "http://webimage.10x10.co.kr/image/list/" + GetImageSubFolderByItemid(rsget("itemid")) + "/" + rsget("listimage")
					 FItemList(i).Fimgsmall			= "http://webimage.10x10.co.kr/image/small/" + GetImageSubFolderByItemid(rsget("itemid")) + "/" + rsget("smallimage")
				If FItemList(i).Fgubun = "01" then
					 if FItemList(i).Flinkimg1<>"" then
						 FItemList(i).Flinkimg1 = "http://imgstatic.10x10.co.kr/goodsimage/" + GetImageSubFolderByItemid(FItemList(i).FItemID) + "/" + FItemList(i).Flinkimg1
					 end if

					 if FItemList(i).Flinkimg2<>"" then
						 FItemList(i).Flinkimg2 = "http://imgstatic.10x10.co.kr/goodsimage/" + GetImageSubFolderByItemid(FItemList(i).FItemID) + "/" + FItemList(i).Flinkimg2
					 end If
				elseIf FItemList(i).Fgubun = "02" then
					 if FItemList(i).Flinkimg1<>"" then
						 FItemList(i).Flinkimg1 = "http://imgstatic.10x10.co.kr/contents/album/" + FItemList(i).Flinkimg1
					 end if

					 if FItemList(i).Flinkimg2<>"" then
						 FItemList(i).Flinkimg2 = "http://imgstatic.10x10.co.kr/contents/album/" + FItemList(i).Flinkimg2
					 end If
				elseIf FItemList(i).Fgubun = "03" then
					 if FItemList(i).Flinkimg1<>"" then
						 FItemList(i).Flinkimg1 = "http://imgstatic.10x10.co.kr/contents/maniaimg/evaluate/file1/" + FItemList(i).Flinkimg1
					 end if

					 if FItemList(i).Flinkimg2<>"" then
						 FItemList(i).Flinkimg2 = "http://imgstatic.10x10.co.kr/contents/maniaimg/evaluate/file2/" + FItemList(i).Flinkimg2
					 end If
				End If

				i=i+1
				rsget.moveNext
			loop
		end if
		rsget.close

    end Sub

	'// 후기쓴 상품 리스트
	Public Sub EvalutedItemList()

		dim sqlStr,i
			sqlStr = "" &_

				" select Count(e.idx) as TotalCnt , Ceiling(cast(count(e.idx) as Float)/" & Cstr(FPageSize) & ") as TotalPage " &_
				" FROM  db_board.[dbo].tbl_Item_Evaluate e "&_
				" JOIN db_item.[dbo].tbl_item i "&_
				" 	on e.itemid=i.itemid "&_
				" WHERE userid='" & FRectUserID & "' "&_
				" and e.isusing='Y' "
				if FRectcdL<>"" then
					sqlStr = sqlStr & " and i.cate_large='" & FRectcdL & "'"
				end if

				''FCateCode


				rsget.open sqlStr ,dbget,1

				IF not rsget.eof THEN
					FTotalCount = rsget("TotalCnt")
					FTotalPage =  rsget("TotalPage")
				End if
				rsget.close


			sqlStr = " " &_
				" SELECT Top " & Cstr(FPageSize*(FCurrPage)) &_
				"   e.idx , e.gubun , e.contents ,  e.regdate , e.orderserial,e.itemoption " &_
				" , e.file1 , e.file2 , e.file3 ,e.file4 , e.file5 "&_
				" , isnull(e.TotalPoint,0) as TotalPoint "&_
				" , isnull(e.Point_function,0) as Point_function "&_
				" , isnull(e.Point_Design,0) as Point_Design "&_
				" , isnull(e.Point_Price,0) as Point_Price "&_
				" , isnull(e.Point_satisfy,0) as Point_satisfy "&_
				" , i.itemid , i.itemname , i.sellcash , (Case When isNull(i.frontMakerid,'')='' then i.makerid else i.frontMakerid end) as makerid , i.brandname , i.listimage120 , i.listimage , i.itemdiv  "&_
				" , o.optionname "&_
				" FROM  db_board.[dbo].tbl_Item_Evaluate e "&_
				" JOIN db_item.[dbo].tbl_item i "&_
				" 	on e.itemid=i.itemid "&_
				" LEFT JOIN db_item.[dbo].tbl_item_option o "&_
				" 	on e.itemid=o.itemid and e.itemoption = o.itemoption  "&_
				" WHERE userid='" & FRectUserID & "' "&_
				" and e.isusing='Y' "
				if FRectcdL<>"" then
					sqlStr = sqlStr & " and i.cate_large='" & FRectcdL & "'"
				end if

				'response.write sqlStr


				Select Case FSortMethod

					case "Best" '//베스트 상품순 많이 -- 인기 상품 우선
						sqlStr = sqlStr & " ORDER by i.itemscore desc, i.itemid desc "
					case "Buy"	'//구매 일자 순 -- 주문 번호 내림차순
						sqlStr = sqlStr & " ORDER by e.orderserial desc "
					case "Reg"	'//작성 일자순 -- 후기 작성 일자,상품 번호
						sqlStr = sqlStr & " ORDER by e.regdate desc,i.itemid desc "
					case "Photo"'//포토 상품 후기순 -- 이미지 있는것 먼저,상품 번호 내림차순
						sqlStr = sqlStr & " ORDER by e.file1 desc, e.orderserial desc ,e.itemid  "
				end Select


			rsget.pagesize = FPageSize
			rsget.open sqlStr ,dbget,1

			FResultCount = rsget.RecordCount-(FPageSize*(FCurrPage-1))

			redim preserve FItemList(FResultCount)
			i=0

			IF not rsget.eof THEN
				rsget.absolutepage = FCurrPage
				do until rsget.eof

					set FItemList(i) = new CEvaluateSearcherItem

					FItemList(i).FItemID 			= rsget("itemid")
					FItemList(i).FItemname 			= db2html(rsget("itemname"))
					FItemList(i).FItemCost			= rsget("sellcash")
					FItemList(i).FOptionName = db2html(rsget("optionname"))
					FItemList(i).FItemDiv			= rsget("itemdiv")
					FItemList(i).FMakerName			= db2html(rsget("brandname"))
					FItemList(i).FMakerID			= rsget("makerID")
					FItemList(i).FOrderSerial 		= rsget("orderserial")
					FItemList(i).FItemOption 		= rsget("itemoption")
					FItemList(i).FOrderDate 		= rsget("regdate")
					FItemList(i).FImageList100 	= "http://webimage.10x10.co.kr/image/list/" + GetImageSubFolderByItemid(rsget("itemid")) + "/" + rsget("listimage")
					FItemList(i).FImageList120 	= "http://webimage.10x10.co.kr/image/list120/" + GetImageSubFolderByItemid(rsget("itemid")) + "/" + rsget("listimage120")

					FItemList(i).Fidx					= rsget("idx")
					FItemList(i).Fgubun				= rsget("Gubun")

					FItemList(i).FTotalPoint		= rsget("TotalPoint")
					FItemList(i).FUesdContents 	= db2html(rsget("contents"))
					FItemList(i).FPoint_fun			= rsget("Point_Function")
					FItemList(i).FPoint_dgn			= rsget("Point_Design")
					FItemList(i).FPoint_prc			= rsget("Point_Price")
					FItemList(i).FPoint_stf			= rsget("Point_Satisfy")

					FItemList(i).Flinkimg1			= rsget("file1")
					FItemList(i).Flinkimg2			= rsget("file2")
					FItemList(i).Flinkimg3			= rsget("file3")
					FItemList(i).Flinkimg4			= rsget("file4")
					FItemList(i).Flinkimg5			= rsget("file5")

					FItemList(i).FRegDate		= rsget("regdate")

					i=i+1
					rsget.movenext
				loop
			END IF

			rsget.close

	End Sub

	'// 최근 3개월 이내 구매 & 후기 안쓰인 상품 리스트
	Public Sub NotEvalutedItemList()

		'// 과거 카테고리 사용 함수(사용하지 말것)

		dim sqlStr ,i

		sqlStr = "" &_
				" select Count(m.orderserial) as TotalCnt , Ceiling(cast(count(m.orderserial) as Float)/" & Cstr(FPageSize) & ") as TotalPage " &_
				" FROM [db_order].[dbo].tbl_Order_Master m  "&_
				" JOIN [db_order].[dbo].tbl_Order_Detail d  "&_
				" 	on m.OrderSerial= d.OrderSerial and m.sitename='10x10' and m.ipkumdiv>=7  "&_
				" 	and m.cancelyn='N' and m.jumundiv<>9 and d.cancelyn<>'Y'  "&_
				" 	and d.itemid<>0  "&_
				"	and (m.userDisplayYn is null or m.userDisplayYn='Y') " &_
				" JOIN [db_item].[dbo].tbl_Item i  "&_
				" 	on d.itemid=i.itemid  "&_
				" LEFT JOIN db_board.[dbo].tbl_Item_Evaluate e  "&_
				" 	on e.UserID='" & FRectUserID & "' and m.OrderSerial = e.OrderSerial and d.Itemid=e.itemid and d.ItemOption = e.ItemOption   "&_
				" WHERE e.idx is null " &_
				" 	and m.userid='" & FRectUserID & "'  "

				if FRectcdL<>"" then
					sqlStr = sqlStr & " and i.cate_large='" & FRectcdL & "'"
				end if

				' 3개월 제한 - 2007/07월 이후  " m.regdate > dateadd(month,-3,convert(varchar(10),getdate(),121)) "


				rsget.open sqlStr ,dbget,1

				IF not rsget.eof THEN
					FTotalCount = rsget("TotalCnt")
					FTotalPage =  rsget("TotalPage")
				End if
				rsget.close

		sqlStr = " " &_
				" SELECT TOP " & Cstr(FPageSize*(FCurrPage)) &_
				"  i.itemid , i.sellcash , i.itemname , i.brandname , (Case When isNull(i.frontMakerid,'')='' then i.makerid else i.frontMakerid end) as makerid , i.listimage120, i.listimage, i.icon2image, d.oitemdiv as itemdiv, i.evalcnt, IsNull(c.favcount, 0) as favcount "&_
				" , d.itemoption , o.optionname "&_
				" , m.orderserial ,m.regdate" &_
				" FROM [db_order].[dbo].tbl_Order_Master m  "&_
				" JOIN [db_order].[dbo].tbl_Order_Detail d  "&_
				" 	on m.OrderSerial= d.OrderSerial and m.sitename='10x10' and m.ipkumdiv>=7  "&_
				" 	and m.cancelyn='N' and m.jumundiv<>9 and d.cancelyn<>'Y'  "&_
				" 	and d.itemid<>0  "&_
				"	and (m.userDisplayYn is null or m.userDisplayYn='Y') " &_
				" JOIN [db_item].[dbo].tbl_Item i  "&_
				" 	on d.itemid=i.itemid  "&_
				" LEFT JOIN [db_item].[dbo].tbl_item_Contents c  "&_
				" 	on d.itemid=c.itemid  "&_
				" LEFT JOIN db_item.[dbo].tbl_item_option o "&_
				" 	on d.itemid = o.itemid and d.itemoption = o.itemoption "&_
				" LEFT JOIN db_board.[dbo].tbl_Item_Evaluate e  "&_
				" 	on e.UserID='" & FRectUserID & "' and m.OrderSerial = e.OrderSerial and d.Itemid=e.itemid and d.ItemOption = e.ItemOption  "&_
				" WHERE e.idx is null " &_
				"  and m.userid='" & FRectUserID & "'  "

				if FRectcdL<>"" then
					sqlStr = sqlStr & " and i.cate_large='" & FRectcdL & "'"
				end if

				' 3개월 제한 - 2007/07월 이후 제한  " m.regdate > dateadd(month,-3,convert(varchar(10),getdate(),121)) "


				Select Case FSortMethod

				case "Best" '//베스트 상품순 -- 인기 상품 우선
					sqlStr = sqlStr & " ORDER by i.itemscore desc, i.itemid desc "
				case "Buy"	'//구매 일자 순 -- 주문 번호 내림차순
					sqlStr = sqlStr & " ORDER by m.orderserial desc "
				case "Reg"	'//작성 유효 일자순 -- 주문 번호 올림차순
					sqlStr = sqlStr & " ORDER by m.orderserial,i.itemid desc "
				case "Photo"'//포토 상품 후기순 -- 이미지 있는것 먼저,상품 번호 내림차순
					sqlStr = sqlStr & " ORDER by e.file1 desc, e.orderserial desc  "
			end Select


			rsget.pagesize = FPageSize
			rsget.open sqlStr ,dbget,1

			FResultCount = rsget.RecordCount-(FPageSize*(FCurrPage-1))
			if (FResultCount<1) then FResultCount=0
			redim preserve FItemList(FResultCount)
			i=0

			IF not rsget.eof THEN
				rsget.absolutepage = FCurrPage
				do until rsget.eof

					set FItemList(i) = new CEvaluateSearcherItem

					FItemList(i).FItemID 			= rsget("itemid")
					FItemList(i).FItemname 			= db2html(rsget("itemname"))
					FItemList(i).FItemCost			= rsget("sellcash")
					FItemList(i).FItemOption 		= rsget("itemoption")
					FItemList(i).FOptionName 		= db2html(rsget("optionname"))
					FItemList(i).FItemDiv			= rsget("itemdiv")
					FItemList(i).FMakerName			= db2html(rsget("brandname"))
					FItemList(i).FMakerID			= rsget("makerID")
					FItemList(i).FOrderSerial 		= rsget("orderserial")
					FItemList(i).FOrderDate 		= rsget("regdate")
					FItemList(i).FImageList100 		= "http://webimage.10x10.co.kr/image/list/" + GetImageSubFolderByItemid(rsget("itemid")) + "/" + rsget("listimage")
					FItemList(i).FImageList120 		= "http://webimage.10x10.co.kr/image/list120/" + GetImageSubFolderByItemid(rsget("itemid")) + "/" + rsget("listimage120")
					FItemList(i).FIcon2 			= "http://webimage.10x10.co.kr/image/icon2/" + GetImageSubFolderByItemid(rsget("itemid")) + "/" + rsget("icon2image")
					FItemList(i).FRegDate			= rsget("regdate")
					FItemList(i).FEvalCnt			= rsget("evalcnt")
					FItemList(i).FFavCount			= rsget("favcount")

					i=i+1
					rsget.movenext
				loop
			END IF

			rsget.close

	End Sub

	'// 후기 안쓴 상품
	Public Sub getNotEvaluatedItem()
		dim sqlStr

		sqlStr = " " &_
			" SELECT top 1 " &_
			"  d.orderserial, d.itemid,d.itemoption, d.oitemdiv as itemdiv  " &_
			" ,i.itemid,i.sellcash,i.itemname,i.brandname , i.listimage , i.listImage120  " &_
			" ,o.optionname " &_
			" , e.idx ,e.gubun,  e.TotalPoint , e.Point_Function , e.Point_Design , e.Point_Price , e.Point_Satisfy " &_
			" , e.icon1, e.icon2 , e.file1 , e.file2 , e.file3 , e.file4 , e.file5" &_
			" , e.Contents as UsedContents , e.imgcontents1 , e.imgcontents2 , e.imgcontents3 , e.imgcontents4 , e.imgcontents5 " &_
			" , s.idx as couponshopidx, s.couponname, s.couponvalue, s.coupontype ,s.couponstartdate, s.couponexpiredate, s.minbuyprice, i.icon2image  " &_
			" , (Case When isNull(i.frontMakerid,'')='' then i.makerid else i.frontMakerid end) as makerid " &_
			" FROM db_order.[dbo].tbl_order_master m  " &_
			" JOIN db_order.[dbo].tbl_order_detail d  " &_
			" 	on m.OrderSerial= d.OrderSerial and m.sitename='10x10' and m.ipkumdiv>=7 and m.cancelyn='N' and m.jumundiv<>'9' and d.cancelyn<>'Y' and d.itemid<>'0'  " &_
			" JOIN db_item.[dbo].tbl_item i  " &_
			" 	on d.itemid=i.itemid  " &_
			" LEFT JOIN db_item.[dbo].tbl_item_option o  " &_
			" 	on d.itemid=o.itemid and d.itemoption = o.itemoption  " &_
			" left join db_board.[dbo].tbl_item_evaluate e " &_
			" 	on e.orderserial = d.orderserial and e.itemid=d.itemid and e.itemoption = d.itemoption and m.userid= e.userid and e.isusing='Y' " &_
			" LEFT JOIN [db_sitemaster].[dbo].tbl_100proshop s  " &_
			" 	on s.itemid=d.itemid  " &_
			"		and s.startdate<=m.regdate and s.enddate>=m.regdate " &_
			"		and datediff(d,s.startdate,getdate()) between 0 and 7 " &_
			" WHERE d.itemid='" & FRectItemID & "'  " &_
			" and m.userid='" & FRectUserID & "'  " &_
			" and m.OrderSerial='" & FRectOrderSerial & "'  " &_
			" and d.itemoption ='" & FRectOption & "'  "

			' 3개월 제한 - 2007/07월 이후 제한  " m.regdate > dateadd(month,-3,convert(varchar(10),getdate(),121)) "
			'"		and s.couponstartdate<=getdate() and s.couponexpiredate>getdate()  " &_

			'response.write sqlStr

			rsget.open sqlStr ,dbget,1

			FResultCount = rsget.RecordCount

			set FEvalItem = new CEvaluateSearcherItem
			IF not rsget.eof THEN

					FEvalItem.FItemID 			= rsget("itemid")
					FEvalItem.FItemname 		= db2html(rsget("itemname"))
					FEvalItem.FItemCost			= rsget("sellcash")
					FEvalItem.FItemOption 		= rsget("itemoption")
					FEvalItem.FOptionName 		= db2html(rsget("optionname"))
					''FEvalItem.FOpenOptionYN		= "Y"
					FEvalItem.FMakerName		= db2html(rsget("BrandName"))
					FEvalItem.FMakerID			= rsget("makerID")
					FEvalItem.FImageList100 	= "http://webimage.10x10.co.kr/image/list/" + GetImageSubFolderByItemid(rsget("itemid")) + "/" + rsget("listimage")
					FEvalItem.FImageList120 	= "http://webimage.10x10.co.kr/image/list120/" + GetImageSubFolderByItemid(rsget("itemid")) + "/" + rsget("listimage120")
					FEvalItem.FIcon2 			= "http://webimage.10x10.co.kr/image/icon2/" + GetImageSubFolderByItemid(rsget("itemid")) + "/" + rsget("icon2image")
					FEvalItem.FOrderSerial		= rsget("orderserial")

					FEvalItem.Fidx				= rsget("idx")
					FEvalItem.Fgubun			= rsget("Gubun")
					FEvalItem.FUesdContents 	= db2html(rsget("usedcontents"))
					FEvalItem.FTotalPoint		= rsget("TotalPoint")
					FEvalItem.FPoint_fun		= rsget("Point_Function")
					FEvalItem.FPoint_dgn		= rsget("Point_Design")
					FEvalItem.FPoint_prc		= rsget("Point_Price")
					FEvalItem.FPoint_stf		= rsget("Point_Satisfy")
					FEvalItem.Flinkimg1			= rsget("file1")
					FEvalItem.Flinkimg2			= rsget("file2")
					FEvalItem.Flinkimg3			= rsget("file3")
					FEvalItem.Flinkimg4			= rsget("file4")
					FEvalItem.Flinkimg5			= rsget("file5")


					FEvalItem.F100ShopIdx 		= rsget("couponshopidx")
					FEvalItem.FCouponName       = db2html(rsget("couponname"))
					FEvalItem.FCouponValue      = rsget("couponvalue")
					FEvalItem.FCouponType       = rsget("coupontype")
					FEvalItem.FCouponStartDate  = rsget("couponstartdate")
					FEvalItem.FCouponExpireDate = rsget("couponexpiredate")
					FEvalItem.Fminbuyprice		= rsget("minbuyprice")

					FEvalItem.Fitemdiv          = rsget("itemdiv")

			END IF

			rsget.close

	End Sub

	'// 후기 안쓴 상품
	Public Sub getNotEvaluatedOffShopItem()
		dim sqlStr

		sqlStr = " SELECT top 1 " & vbcrlf
		sqlStr = sqlStr + "  d.orderno, d.itemid,d.itemoption	" & vbcrlf
		sqlStr = sqlStr + " ,i.itemid,i.sellcash,i.itemname,i.brandname , i.listimage , i.listImage120  " & vbcrlf
		sqlStr = sqlStr + " ,o.optionname " & vbcrlf
		sqlStr = sqlStr + " , e.idx ,e.gubun,  e.TotalPoint , e.Point_Function , e.Point_Design , e.Point_Price , e.Point_Satisfy " & vbcrlf
		sqlStr = sqlStr + " , e.icon1, e.icon2 , e.file1 , e.file2 , e.file3 , e.file4 , e.file5" & vbcrlf
		sqlStr = sqlStr + " , e.Contents as UsedContents , e.imgcontents1 , e.imgcontents2 , e.imgcontents3 , e.imgcontents4 , e.imgcontents5 " & vbcrlf
		sqlStr = sqlStr + " , s.idx as couponshopidx, s.couponname, s.couponvalue, s.coupontype ,s.couponstartdate, s.couponexpiredate, s.minbuyprice, i.icon2image  " & vbcrlf
		sqlStr = sqlStr + " , (Case When isNull(i.frontMakerid,'')='' then i.makerid else i.frontMakerid end) as makerid " & vbcrlf
		sqlStr = sqlStr + " FROM [db_shop].[dbo].[tbl_shopjumun_master] m  " & vbcrlf
		sqlStr = sqlStr + " JOIN [db_shop].[dbo].[tbl_shopjumun_detail] d  " & vbcrlf
		sqlStr = sqlStr + " 	on m.orderno= d.orderno and m.cancelyn='N' and d.cancelyn<>'Y' and d.itemid<>'0' and d.itemid<>'100'  " & vbcrlf
		sqlStr = sqlStr + " JOIN db_item.[dbo].tbl_item i  " & vbcrlf
		sqlStr = sqlStr + " 	on d.itemid=i.itemid  " & vbcrlf
		sqlStr = sqlStr + " LEFT JOIN db_item.[dbo].tbl_item_option o  " & vbcrlf
		sqlStr = sqlStr + " 	on d.itemid=o.itemid and d.itemoption = o.itemoption  " & vbcrlf
		sqlStr = sqlStr + " left join db_board.[dbo].tbl_item_evaluate e " & vbcrlf
		sqlStr = sqlStr + " 	on e.orderserial = d.orderno and e.itemid=d.itemid and e.itemoption = d.itemoption and e.userid='" & FRectUserID & "' and e.isusing='Y' " & vbcrlf
		sqlStr = sqlStr + " LEFT JOIN [db_sitemaster].[dbo].tbl_100proshop s  " & vbcrlf
		sqlStr = sqlStr + " 	on s.itemid=d.itemid  " & vbcrlf
		sqlStr = sqlStr + "		and s.startdate<=m.regdate and s.enddate>=m.regdate " & vbcrlf
		sqlStr = sqlStr + "		and datediff(d,s.startdate,getdate()) between 0 and 7 " & vbcrlf
		sqlStr = sqlStr + " WHERE d.itemid='" & FRectItemID & "'  " & vbcrlf
		sqlStr = sqlStr + " and m.orderno='" & FRectOrderSerial & "'  " & vbcrlf
		sqlStr = sqlStr + " and d.itemoption ='" & FRectOption & "'  "

			' 3개월 제한 - 2007/07월 이후 제한  " m.regdate > dateadd(month,-3,convert(varchar(10),getdate(),121)) "
			'"		and s.couponstartdate<=getdate() and s.couponexpiredate>getdate()  " &_

			'response.write sqlStr
			'Response.end
			rsget.open sqlStr ,dbget,1

			FResultCount = rsget.RecordCount

			set FEvalItem = new CEvaluateSearcherItem
			IF not rsget.eof THEN

					FEvalItem.FItemID 			= rsget("itemid")
					FEvalItem.FItemname 		= db2html(rsget("itemname"))
					FEvalItem.FItemCost			= rsget("sellcash")
					FEvalItem.FItemOption 		= rsget("itemoption")
					FEvalItem.FOptionName 		= db2html(rsget("optionname"))
					''FEvalItem.FOpenOptionYN		= "Y"
					FEvalItem.FMakerName		= db2html(rsget("BrandName"))
					FEvalItem.FMakerID			= rsget("makerID")
					FEvalItem.FImageList100 	= "http://webimage.10x10.co.kr/image/list/" + GetImageSubFolderByItemid(rsget("itemid")) + "/" + rsget("listimage")
					FEvalItem.FImageList120 	= "http://webimage.10x10.co.kr/image/list120/" + GetImageSubFolderByItemid(rsget("itemid")) + "/" + rsget("listimage120")
					FEvalItem.FIcon2 			= "http://webimage.10x10.co.kr/image/icon2/" + GetImageSubFolderByItemid(rsget("itemid")) + "/" + rsget("icon2image")
					FEvalItem.FOrderSerial		= rsget("orderno")

					FEvalItem.Fidx				= rsget("idx")
					FEvalItem.Fgubun			= rsget("Gubun")
					FEvalItem.FUesdContents 	= db2html(rsget("usedcontents"))
					FEvalItem.FTotalPoint		= rsget("TotalPoint")
					FEvalItem.FPoint_fun		= rsget("Point_Function")
					FEvalItem.FPoint_dgn		= rsget("Point_Design")
					FEvalItem.FPoint_prc		= rsget("Point_Price")
					FEvalItem.FPoint_stf		= rsget("Point_Satisfy")
					FEvalItem.Flinkimg1			= rsget("file1")
					FEvalItem.Flinkimg2			= rsget("file2")
					FEvalItem.Flinkimg3			= rsget("file3")
					FEvalItem.Flinkimg4			= rsget("file4")
					FEvalItem.Flinkimg5			= rsget("file5")


					FEvalItem.F100ShopIdx 		= rsget("couponshopidx")
					FEvalItem.FCouponName       = db2html(rsget("couponname"))
					FEvalItem.FCouponValue      = rsget("couponvalue")
					FEvalItem.FCouponType       = rsget("coupontype")
					FEvalItem.FCouponStartDate  = rsget("couponstartdate")
					FEvalItem.FCouponExpireDate = rsget("couponexpiredate")
					FEvalItem.Fminbuyprice		= rsget("minbuyprice")

					'FEvalItem.Fitemdiv          = rsget("itemdiv")

			END IF

			rsget.close

	End Sub

	'// 후기쓴 상품 리스트(2013-09-26 신규 카테고리 대응)
	Public Sub EvalutedItemListNew()

		dim sqlStr, addSql, i
        
        if (FRectUserID="") then Exit sub ''2015/04/13추가

		'// ====================================================================
		sqlStr = "EXEC [db_board].[dbo].[usp_WWW_My10x10_ItemEvaluted_TotalCount_Get] " & Cstr(FPageSize) & ", '" & Cstr(FRectUserID) & "', '"& Cstr(FCateCode) & "'"
		rsget.open sqlStr ,dbget,1
		IF not rsget.eof THEN
			FTotalCount = rsget("TotalCnt")
			FTotalPage =  rsget("TotalPage")
		End if
		rsget.close

		'// ====================================================================
		sqlStr = "EXEC [db_board].[dbo].[usp_WWW_My10x10_ItemEvaluted_List_Get] " & Cstr(FPageSize) & ", " &  Cstr(FCurrPage) & ", '"  & Cstr(FRectUserID) & "', '"& Cstr(FCateCode) & "', '" & Cstr(FSortMethod) & "'"

		rsget.pagesize = FPageSize
		rsget.cursorlocation=3
		rsget.open sqlStr ,dbget,1
		FResultCount = rsget.RecordCount
		redim preserve FItemList(FResultCount)
		i=0
		IF not rsget.eof THEN
			'rsget.absolutepage = FCurrPage
			do until rsget.eof
				set FItemList(i) = new CEvaluateSearcherItem
				FItemList(i).fEval_excludeyn 			= rsget("Eval_excludeyn")
				FItemList(i).FItemID 			= rsget("itemid")
				FItemList(i).FItemname 			= db2html(rsget("itemname"))
				FItemList(i).FItemCost			= rsget("sellcash")
				FItemList(i).FOptionName = db2html(rsget("optionname"))
				FItemList(i).FItemDiv			= rsget("itemdiv")
				FItemList(i).FMakerName			= db2html(rsget("brandname"))
				FItemList(i).FMakerID			= rsget("makerID")
				FItemList(i).FOrderSerial 		= rsget("orderserial")
				FItemList(i).FItemOption 		= rsget("itemoption")
				FItemList(i).FOrderDate 		= rsget("regdate")
				FItemList(i).FImageList100 	= "http://webimage.10x10.co.kr/image/list/" + GetImageSubFolderByItemid(rsget("itemid")) + "/" + rsget("listimage")
				FItemList(i).FImageList120 	= "http://webimage.10x10.co.kr/image/list120/" + GetImageSubFolderByItemid(rsget("itemid")) + "/" + rsget("listimage120")

				FItemList(i).Fidx					= rsget("idx")
				FItemList(i).Fgubun				= rsget("Gubun")

				FItemList(i).FTotalPoint		= rsget("TotalPoint")
				FItemList(i).FUesdContents 	= db2html(rsget("contents"))
				FItemList(i).FPoint_fun			= rsget("Point_Function")
				FItemList(i).FPoint_dgn			= rsget("Point_Design")
				FItemList(i).FPoint_prc			= rsget("Point_Price")
				FItemList(i).FPoint_stf			= rsget("Point_Satisfy")

				FItemList(i).Flinkimg1			= rsget("file1")
				FItemList(i).Flinkimg2			= rsget("file2")
				FItemList(i).Flinkimg3			= rsget("file3")
				FItemList(i).Flinkimg4			= rsget("file4")
				FItemList(i).Flinkimg5			= rsget("file5")
				FItemList(i).FShopName			= rsget("shopname")
				FItemList(i).FRegDate		= rsget("regdate")

				i=i+1
				rsget.movenext
			loop
		END IF

		rsget.close

	End Sub
    
    Public Sub NotEvalutedItemTop1()
        dim sqlStr
        

        sqlStr = " exec db_board.[dbo].[sp_Ten_NotEvalutedItemTop1] '"&FRectUserID&"'"
        'rsget.CursorLocation = adUseClient
		'rsget.CursorType = adOpenForwardOnly ''adOpenStatic  ''adOpenForwardOnly
		'rsget.LockType = adLockReadOnly ''adLockOptimistic ''adLockReadOnly
		rsget.Open sqlStr,dbget

		FResultCount = rsget.RecordCount
		if (FResultCount<1) then FResultCount=0
		redim preserve FItemList(FResultCount)
		i=0

		IF not rsget.eof THEN
			do until rsget.eof

				set FItemList(i) = new CEvaluateSearcherItem

				FItemList(i).FItemID 			= rsget("itemid")
				FItemList(i).FItemname 			= db2html(rsget("itemname"))
				FItemList(i).FItemCost			= rsget("sellcash")
				FItemList(i).FItemOption 		= rsget("itemoption")
				FItemList(i).FOptionName 		= db2html(rsget("optionname"))
				FItemList(i).FItemDiv			= rsget("itemdiv")
				FItemList(i).FMakerName			= db2html(rsget("brandname"))
				FItemList(i).FMakerID			= rsget("makerID")
				FItemList(i).FOrderSerial 		= rsget("orderserial")
				FItemList(i).FOrderDate 		= rsget("regdate")
				FItemList(i).FImageList100 		= "http://webimage.10x10.co.kr/image/list/" + GetImageSubFolderByItemid(rsget("itemid")) + "/" + rsget("listimage")
				FItemList(i).FImageList120 		= "http://webimage.10x10.co.kr/image/list120/" + GetImageSubFolderByItemid(rsget("itemid")) + "/" + rsget("listimage120")
				FItemList(i).FIcon2 			= "http://webimage.10x10.co.kr/image/icon2/" + GetImageSubFolderByItemid(rsget("itemid")) + "/" + rsget("icon2image")
				FItemList(i).FRegDate			= rsget("regdate")
				FItemList(i).FEvalCnt			= rsget("evalcnt")
				FItemList(i).FFavCount			= rsget("favcount")

				i=i+1
				rsget.movenext
			loop
		END IF

		rsget.close
		
    end Sub

	'//상품후기 체크용 2017-05-23 이종화
	Public Sub MyNotEvalutedItem_Top1()
        dim sqlStr
        
        sqlStr = "exec db_board.[dbo].[sp_Ten_MyNotEvalutedItem_Top1] '"&FRectUserID&"' , '"&FRectItemID&"'"
		rsget.Open sqlStr,dbget , 1

		FResultCount = rsget.RecordCount
		set FEvalItem = new CEvaluateSearcherItem
		IF not rsget.eof THEN
			FEvalItem.FOrderSerial 		= rsget("orderserial")  '//주문번호
			FEvalItem.FItemID 			= rsget("itemid")		'//상품코드
			FEvalItem.FItemOption 		= rsget("itemoption")	'//상품옵션
			FEvalItem.Fidx 				= rsget("idx")			'//후기IDX
			FEvalItem.FEval_isusing     = rsget("isusing")			'//후기 사용 유무
		END IF

		rsget.close
    end Sub
    
	'// 최근 3개월 이내 구매 & 후기 안쓰인 상품 리스트(2013-09-26 신규 카테고리 대응)
	Public Sub NotEvalutedItemListNew()

		dim sqlStr, addSql, i
        if (FRectUserID="") then Exit Sub ''2015/04/17 추가

		'// ====================================================================
		sqlStr = "EXEC [db_board].[dbo].[usp_WWW_My10x10_ItemNotEvaluted_TotalCount_Get] " & Cstr(FPageSize) & ", '" & Cstr(FRectUserID) & "', '"& Cstr(FCateCode) & "'"
		rsget.open sqlStr ,dbget,1
		IF not rsget.eof THEN
			FTotalCount = rsget("TotalCnt")
			FTotalPage =  rsget("TotalPage")
		End if
		rsget.close

		'// ====================================================================
		sqlStr = "EXEC [db_board].[dbo].[usp_WWW_My10x10_ItemNotEvaluted_List_Get] " & Cstr(FPageSize) & ", " &  Cstr(FCurrPage) & ", '"  & Cstr(FRectUserID) & "', '"& Cstr(FCateCode) & "', '" & Cstr(FSortMethod) & "'"
		rsget.pagesize = FPageSize
		rsget.cursorlocation=3
		rsget.open sqlStr ,dbget,1

		FResultCount = rsget.RecordCount
		if (FResultCount<1) then FResultCount=0
		redim preserve FItemList(FResultCount)
		i=0

		IF not rsget.eof THEN
			'rsget.absolutepage = FCurrPage
			do until rsget.eof

				set FItemList(i) = new CEvaluateSearcherItem

				FItemList(i).FItemID 			= rsget("itemid")
				FItemList(i).FItemname 			= db2html(rsget("itemname"))
				FItemList(i).FItemCost			= rsget("sellcash")
				FItemList(i).FItemOption 		= rsget("itemoption")
				FItemList(i).FOptionName 		= db2html(rsget("optionname"))
				'FItemList(i).FItemDiv			= rsget("itemdiv")
				FItemList(i).FMakerName			= db2html(rsget("brandname"))
				FItemList(i).FMakerID			= rsget("makerID")
				FItemList(i).FOrderSerial 		= rsget("orderserial")
				FItemList(i).FOrderDate 		= rsget("regdate")
				FItemList(i).FImageList100 		= "http://webimage.10x10.co.kr/image/list/" + GetImageSubFolderByItemid(rsget("itemid")) + "/" + rsget("listimage")
				FItemList(i).FImageList120 		= "http://webimage.10x10.co.kr/image/list120/" + GetImageSubFolderByItemid(rsget("itemid")) + "/" + rsget("listimage120")
				FItemList(i).FIcon2 			= "http://webimage.10x10.co.kr/image/icon2/" + GetImageSubFolderByItemid(rsget("itemid")) + "/" + rsget("icon2image")
				FItemList(i).FRegDate			= rsget("regdate")
				FItemList(i).FEvalCnt			= rsget("evalcnt")
				FItemList(i).FFavCount			= rsget("favcount")
				FItemList(i).FDetailIDX			= rsget("idx")
				FItemList(i).FShopName			= rsget("shopname")

				i=i+1
				rsget.movenext
			loop
		END IF

		rsget.close

	End Sub

	'// 후기 쓴 상품
	Public Sub getEvaluatedItem()
		dim sqlStr

		sqlStr = " " &_
			" SELECT top 1 " &_
			" e.idx , e.gubun , e.orderserial, e.itemoption , o.optionname, i.itemdiv, i.icon2image  " &_
			" , e.TotalPoint , e.Point_Function , e.Point_Design , e.Point_Price , e.Point_Satisfy " &_
			" , e.icon1, e.icon2 , e.file1 , e.file2 , e.file3 , e.file4 , e.file5" &_
			" ,e.title , e.Contents as UsedContents , e.imgcontents1 , e.imgcontents2 , e.imgcontents3 , e.imgcontents4 , e.imgcontents5 " &_
			" ,i.itemid,i.sellcash,i.itemname,i.brandname , i.listimage , i.listImage120 " &_
			" FROM db_board.[dbo].tbl_item_evaluate e " &_
			" JOIN db_item.[dbo].tbl_item i " &_
			" 	on i.itemid= e.itemid " &_
			" LEFT JOIN db_item.[dbo].tbl_item_option o " &_
			" 	on e.itemid=o.itemid and e.itemoption = o.itemoption " &_
			" WHERE e.isusing='Y' and e.userid='" & CStr(userid) & "' " &_
			" 	and e.itemid='" & CStr(itemid) & "' " &_
			" 	and e.OrderSerial='" & CStr(FRectOrderSerial) & "' " &_
			" 	and e.itemoption ='" & CStr(FRectOption) & "' "
			rsget.open sqlStr ,dbget,1

			FResultCount = rsget.RecordCount

			set FEvalItem = new CEvaluateSearcherItem
			IF not rsget.eof THEN

					FEvalItem.FItemID 			= rsget("itemid")
					FEvalItem.FItemname 		= db2html(rsget("itemname"))
					FEvalItem.FItemCost			= rsget("sellcash")
					FEvalItem.FItemOption 		= rsget("itemoption")
					''FEvalItem.FOpenOptionYN 	= rsget("openOptionYN")

					FEvalItem.FOptionName 		= db2html(rsget("optionname"))
					FEvalItem.FMakerName		= db2html(rsget("BrandName"))
					FEvalItem.FImageList100 	= "http://webimage.10x10.co.kr/image/list/" + GetImageSubFolderByItemid(rsget("itemid")) + "/" + rsget("listimage")
					FEvalItem.FImageList120 	= "http://webimage.10x10.co.kr/image/list120/" + GetImageSubFolderByItemid(rsget("itemid")) + "/" + rsget("listimage120")
					FEvalItem.FIcon2 			= "http://webimage.10x10.co.kr/image/icon2/" + GetImageSubFolderByItemid(rsget("itemid")) + "/" + rsget("icon2image")
					FEvalItem.FOrderSerial		= rsget("orderserial")

					FEvalItem.Fidx				= rsget("idx")
					FEvalItem.Fgubun			= rsget("Gubun")
					FEvalItem.FTitle			= rsget("title")
					FEvalItem.FUesdContents 	= db2html(rsget("usedcontents"))

					FEvalItem.FTotalPoint		= rsget("TotalPoint")
					FEvalItem.FPoint_fun		= rsget("Point_Function")
					FEvalItem.FPoint_dgn		= rsget("Point_Design")
					FEvalItem.FPoint_prc		= rsget("Point_Price")
					FEvalItem.FPoint_stf		= rsget("Point_Satisfy")

					FEvalItem.FIcon1			= rsget("Icon1")

					FEvalItem.Flinkimg1			= rsget("file1")
					FEvalItem.Flinkimg2			= rsget("file2")
					FEvalItem.Flinkimg3			= rsget("file3")
					FEvalItem.Flinkimg4			= rsget("file4")
					FEvalItem.Flinkimg5			= rsget("file5")

					FEvalItem.FImgContents1		= rsget("imgcontents1")
					FEvalItem.FImgContents2		= rsget("imgcontents2")
					FEvalItem.FImgContents3		= rsget("imgcontents3")
					FEvalItem.FImgContents4		= rsget("imgcontents4")
					FEvalItem.FImgContents5		= rsget("imgcontents5")

					FEvalItem.Fitemdiv          = rsget("itemdiv")
			END IF

			rsget.close

	End Sub

		'// 후기 쓴 상품(오프라인)
	Public Sub getEvaluatedOffShopItem()
		dim sqlStr

		sqlStr = " " &_
			" SELECT top 1 " &_
			" e.idx , e.gubun , e.orderserial, e.itemoption , o.optionname, i.itemdiv, i.icon2image  " &_
			" , e.TotalPoint , e.Point_Function , e.Point_Design , e.Point_Price , e.Point_Satisfy " &_
			" , e.icon1, e.icon2 , e.file1 , e.file2 , e.file3 , e.file4 , e.file5" &_
			" ,e.title , e.Contents as UsedContents , e.imgcontents1 , e.imgcontents2 , e.imgcontents3 , e.imgcontents4 , e.imgcontents5 " &_
			" ,i.itemid,i.sellcash,i.itemname,i.brandname , i.listimage , i.listImage120 " &_
			" FROM db_board.[dbo].tbl_item_evaluate_Offshop e " &_
			" JOIN db_item.[dbo].tbl_item i " &_
			" 	on i.itemid= e.itemid " &_
			" LEFT JOIN db_item.[dbo].tbl_item_option o " &_
			" 	on e.itemid=o.itemid and e.itemoption = o.itemoption " &_
			" WHERE e.isusing='Y' and e.userid='" & CStr(userid) & "' " &_
			" 	and e.itemid='" & CStr(itemid) & "' " &_
			" 	and e.OrderSerial='" & CStr(FRectOrderSerial) & "' " &_
			" 	and e.itemoption ='" & CStr(FRectOption) & "' "

			rsget.open sqlStr ,dbget,1

			FResultCount = rsget.RecordCount

			set FEvalItem = new CEvaluateSearcherItem
			IF not rsget.eof THEN

					FEvalItem.FItemID 			= rsget("itemid")
					FEvalItem.FItemname 		= db2html(rsget("itemname"))
					FEvalItem.FItemCost			= rsget("sellcash")
					FEvalItem.FItemOption 		= rsget("itemoption")
					''FEvalItem.FOpenOptionYN 	= rsget("openOptionYN")

					FEvalItem.FOptionName 		= db2html(rsget("optionname"))
					FEvalItem.FMakerName		= db2html(rsget("BrandName"))
					FEvalItem.FImageList100 	= "http://webimage.10x10.co.kr/image/list/" + GetImageSubFolderByItemid(rsget("itemid")) + "/" + rsget("listimage")
					FEvalItem.FImageList120 	= "http://webimage.10x10.co.kr/image/list120/" + GetImageSubFolderByItemid(rsget("itemid")) + "/" + rsget("listimage120")
					FEvalItem.FIcon2 			= "http://webimage.10x10.co.kr/image/icon2/" + GetImageSubFolderByItemid(rsget("itemid")) + "/" + rsget("icon2image")
					FEvalItem.FOrderSerial		= rsget("orderserial")

					FEvalItem.Fidx				= rsget("idx")
					FEvalItem.Fgubun			= rsget("Gubun")
					FEvalItem.FTitle			= rsget("title")
					FEvalItem.FUesdContents 	= db2html(rsget("usedcontents"))

					FEvalItem.FTotalPoint		= rsget("TotalPoint")
					FEvalItem.FPoint_fun		= rsget("Point_Function")
					FEvalItem.FPoint_dgn		= rsget("Point_Design")
					FEvalItem.FPoint_prc		= rsget("Point_Price")
					FEvalItem.FPoint_stf		= rsget("Point_Satisfy")

					FEvalItem.FIcon1			= rsget("Icon1")

					FEvalItem.Flinkimg1			= rsget("file1")
					FEvalItem.Flinkimg2			= rsget("file2")
					FEvalItem.Flinkimg3			= rsget("file3")
					FEvalItem.Flinkimg4			= rsget("file4")
					FEvalItem.Flinkimg5			= rsget("file5")

					FEvalItem.FImgContents1		= rsget("imgcontents1")
					FEvalItem.FImgContents2		= rsget("imgcontents2")
					FEvalItem.FImgContents3		= rsget("imgcontents3")
					FEvalItem.FImgContents4		= rsget("imgcontents4")
					FEvalItem.FImgContents5		= rsget("imgcontents5")

					FEvalItem.Fitemdiv          = rsget("itemdiv")
			END IF

			rsget.close

	End Sub
	
	Public Function getEvaluatedTotalMileCnt()
		dim sqlStr
        if (FRectUserID="") then Exit function ''2015/04/13 추가
        
			sqlStr = "EXEC [db_board].[dbo].[usp_WWW_My10x10_ItemNotEvaluted_CheckMile_Get] " & Cstr(FRectMileage) & ", '" & Cstr(FRectUserID) & "'"
			rsget.open sqlStr ,dbget,1
'response.write sqlStr
			IF not rsget.eof THEN
				getEvaluatedTotalMileCnt = rsget.GetRows()
			END IF
			rsget.close
	End Function
	

	''// 매니아 상품 후기  읽기

	Public Sub getEvaluatedItemByIDX(byval idx)
		dim sqlStr

		sqlStr = " " &_
			" SELECT top 1 " &_
			" e.idx , e.userid, e.gubun , e.orderserial, e.itemoption , o.optionname  " &_
			" , e.TotalPoint , e.ManiaPoint , e.Point_Function , e.Point_Design , e.Point_Price , e.Point_Satisfy " &_
			" , e.icon1, e.icon2 , e.file1 , e.file2 , e.file3 , e.file4 , e.file5" &_
			" ,e.title , e.Contents as UsedContents , e.imgcontents1 , e.imgcontents2 , e.imgcontents3 , e.imgcontents4 , e.imgcontents5 " &_
			" ,i.itemid,i.sellcash,i.itemname,i.brandname , i.listimage , i.listImage120 " &_
			" FROM db_board.[dbo].tbl_item_evaluate e " &_
			" JOIN db_item.[dbo].tbl_item i " &_
			" 	on i.itemid= e.itemid " &_
			" LEFT JOIN db_item.[dbo].tbl_item_option o " &_
			" 	on e.itemid=o.itemid and e.itemoption = o.itemoption " &_
			" WHERE e.isusing='Y' and e.idx='" & CStr(idx) & "' "


			rsget.open sqlStr ,dbget,1

			FResultCount = rsget.RecordCount

			set FEvalItem = new CEvaluateSearcherItem
			IF not rsget.eof THEN

					FEvalItem.FItemID 			= rsget("itemid")
					FEvalItem.FItemname 			= db2html(rsget("itemname"))
					FEvalItem.FItemCost			= rsget("sellcash")
					FEvalItem.FItemOption 		= rsget("itemoption")
					FEvalItem.FOptionName = db2html(rsget("optionname"))
					FEvalItem.FMakerName			= db2html(rsget("BrandName"))
					FEvalItem.FImageList100 	= "http://webimage.10x10.co.kr/image/list/" + GetImageSubFolderByItemid(rsget("itemid")) + "/" + rsget("listimage")
					FEvalItem.FImageList120 	= "http://webimage.10x10.co.kr/image/list120/" + GetImageSubFolderByItemid(rsget("itemid")) + "/" + rsget("listimage120")
					FEvalItem.FOrderSerial		= rsget("orderserial")

					FEvalItem.Fidx					= rsget("idx")
					FEvalItem.Fgubun				= rsget("Gubun")
					FEvalItem.FUserID				= rsget("userid")
					FEvalItem.FTitle				= rsget("title")
					FEvalItem.FUesdContents 	= db2html(rsget("usedcontents"))

					FEvalItem.FTotalPoint		= rsget("TotalPoint")
					FEvalItem.FManiaPoint		= rsget("ManiaPoint")

					FEvalItem.FPoint_fun			= rsget("Point_Function")
					FEvalItem.FPoint_dgn			= rsget("Point_Design")
					FEvalItem.FPoint_prc			= rsget("Point_Price")
					FEvalItem.FPoint_stf			= rsget("Point_Satisfy")

					FEvalItem.FIcon1				= rsget("Icon1")
					FEvalItem.FIcon2				= rsget("Icon2")
					FEvalItem.Flinkimg1			= rsget("file1")
					FEvalItem.Flinkimg2			= rsget("file2")
					FEvalItem.Flinkimg3			= rsget("file3")
					FEvalItem.Flinkimg4			= rsget("file4")
					FEvalItem.Flinkimg5			= rsget("file5")

					FEvalItem.FImgContents1			= rsget("imgcontents1")
					FEvalItem.FImgContents2			= rsget("imgcontents2")
					FEvalItem.FImgContents3			= rsget("imgcontents3")
					FEvalItem.FImgContents4			= rsget("imgcontents4")
					FEvalItem.FImgContents5			= rsget("imgcontents5")


			END IF

			rsget.close

	End Sub

	'// 포토후기 최근 당첨자 //
	public Sub getPhotoEvaluateLastWinner()
		dim sql, i
		sql = "select top 1 a.id, a.gubun,a.masterid, a.userid, a.title, a.contents,"
		sql = sql + " a.point1, a.point2, a.point3, a.point4, a.hitcount, a.commentcount,"
		sql = sql + " a.scoresum, a.regdate, a.icon1, a.icon2, a.itemid, i.itemname, i.sellcash, (Case When isNull(i.frontMakerid,'')='' then i.makerid else i.frontMakerid end) as makerid, i.listimage"
		sql = sql + " from [db_board].[dbo].[tbl_user_goodusing] a left join [db_item].[dbo].tbl_item i on a.itemid = i.itemid"
		sql = sql + " where a.isselected = 'Y' "
		sql = sql + " and a.itemid<>0"
		sql = sql + " and a.isdelete <> 'Y'"
		''sql = sql + " and file1 is Not NULL"
		''sql = sql + " and file1<>''"
		sql = sql + " order by a.id desc "

		rsget.Open sql, dbget, 1
		FResultCount = rsget.RecordCount

		if  not rsget.EOF  then
		    set FEvalItem = new CEvaluateSearcherItem
			FEvalItem.Fidx           = rsget("id")
			FEvalItem.Fgubun		   = rsget("gubun")
			FEvalItem.Ftitle			= db2html(rsget("title"))
			FEvalItem.FUesdContents     = db2html(rsget("contents"))
			FEvalItem.Fuserid       = rsget("userid")
			FEvalItem.Fhitcount     = rsget("hitcount")
			FEvalItem.Fcommentcount = rsget("commentcount")
			FEvalItem.Fscoresum     = Cint((rsget("point1") + rsget("point2") + rsget("point3") + rsget("point4")) / 4)
			FEvalItem.Fregdate      = rsget("regdate")
			FEvalItem.Fitemid    = rsget("itemid")

			FEvalItem.FImgList        = "http://webimage.10x10.co.kr/image/list/" + GetImageSubFolderByItemid(FEvalItem.Fitemid) + "/" + rsget("listimage")

			If FEvalItem.Fgubun = "01" then
					 FEvalItem.Ficon1        = "http://webimage.10x10.co.kr/image/list/" + GetImageSubFolderByItemid(FEvalItem.Fitemid) + "/" + rsget("listimage")
					 FEvalItem.Ficon2        = "http://webimage.10x10.co.kr/image/list/" + GetImageSubFolderByItemid(FEvalItem.Fitemid) + "/" + rsget("listimage")
			ElseIf FEvalItem.Fgubun = "02" Then
				 if (Not IsNUll(rsget("icon1"))) and (rsget("icon1") <> "") then
					 FEvalItem.Ficon1    = "http://imgstatic.10x10.co.kr/contents/album" + rsget("icon1")
				 end if

				 if (Not IsNUll(rsget("icon2"))) and (rsget("icon2") <> "") then
					 FEvalItem.Ficon2    = "http://imgstatic.10x10.co.kr/contents/album" + rsget("icon2")
				 end If
			ElseIf FEvalItem.Fgubun = "03" Then
				 if (Not IsNUll(rsget("icon1"))) and (rsget("icon1") <> "") then
					 FEvalItem.Ficon1    = "http://imgstatic.10x10.co.kr/contents/maniaimg/evaluate/" & CStr(rsget("masterid")) & + "/icon1/" + rsget("icon1")
				 end if

				 if (Not IsNUll(rsget("icon2"))) and (rsget("icon2") <> "") then
					 FEvalItem.Ficon2    = "http://imgstatic.10x10.co.kr/contents/maniaimg/evaluate/" & CStr(rsget("masterid")) & + "/icon2/" + rsget("icon2")
				 end If
			End if

			FEvalItem.Fitemname    = db2html(rsget("itemname"))
			FEvalItem.Fsellcash    = rsget("sellcash")
			FEvalItem.Fmakerid    = rsget("makerid")

			if IsNULL(FEvalItem.Fsellcash) then FItemList(i).Fsellcash=0
		end if
		rsget.Close
	end sub


	'// 포토후기 목록 접수 //
	public sub getPhotoEvaluateList()
		dim sql, i,ordersql
		dim addSql

		sql = "select count(a.id) as TotalCnt "
		sql = sql + " from [db_board].[dbo].[tbl_user_goodusing] a left join [db_item].[dbo].tbl_item i on a.itemid=i.itemid"
		sql = sql + " where a.file1 is Not NULL"
		sql = sql + " and a.file1<>''"
		sql = sql + " and a.itemid<>0"
		sql = sql + " and a.isdelete <> 'Y' "

		addSql = ""
		if FRectCDL <> "" then
		   addSql = addSql + " and i.cate_large = '" + FRectCDL + "'"
	    end if

		if Frectsearchtype="chktitle" then
			addSql = addSql + " and a.title like '%" + FRectsearchrect + "%'"
		elseif Frectsearchtype="chkitem" then
			addSql = addSql + " and i.itemname like '%" + FRectsearchrect + "%'"
		elseif Frectsearchtype="chkuser" then
			addSql = addSql + " and a.userid='" + FRectsearchrect + "'"
		end if

		sql = sql + addSql

		'' 검색조건이 없을경우 최근 500건만
		if addSql<>"" then
			rsget.Open sql, dbget, 1
			FTotalCount = rsget("TotalCnt")
			rsget.close
		else
			FTotalCount = 500
		end if

		if FTotalCount>500 then FTotalCount=500


		sql = "select top " + CStr(FPageSize * FCurrPage) + " a.id, a.gubun,a.masterid, a.title, a.userid, a.contents,"
		sql = sql + " a.point1, a.point2, a.point3, a.point4, a.hitcount, a.commentcount,"
		sql = sql + " a.scoresum, a.regdate, a.icon1, a.icon2, a.itemid, i.itemname, i.sellcash, (Case When isNull(i.frontMakerid,'')='' then i.makerid else i.frontMakerid end) as makerid, i.listimage"
		sql = sql + " from [db_board].[dbo].[tbl_user_goodusing] a left join [db_item].[dbo].tbl_item i on a.itemid=i.itemid"
		sql = sql + " where a.file1 is Not NULL and a.file1<>''"
		sql = sql + " and a.itemid<>0"
		sql = sql + " and a.isdelete <> 'Y' "

		sql = sql + addSql

		sql = sql + " order by a.id desc "

		rsget.pagesize = FPageSize
		rsget.Open sql, dbget, 1

		FtotalPage =  CInt(FTotalCount\FPageSize)
		if  (FTotalCount\FPageSize)<>(FTotalCount/FPageSize) then
			FtotalPage = FtotalPage +1
		end if
		FResultCount = rsget.RecordCount-(FPageSize*(FCurrPage-1))
		'FPCount = FCurrPage - 1

		redim preserve FItemList(FResultCount)
		if  not rsget.EOF  then
		    i = 0
			rsget.absolutepage = FCurrPage
			do until rsget.eof
				set FItemList(i) = new CEvaluateSearcherItem

				FItemList(i).Fgubun       = rsget("gubun")
				FItemList(i).Fidx           = rsget("id")
				FItemList(i).Ftitle        = db2html(rsget("title"))
				FItemList(i).FUesdContents     = db2html(rsget("contents"))
				FItemList(i).Fuserid       = rsget("userid")

				FItemList(i).Fhitcount     = rsget("hitcount")
				FItemList(i).Fcommentcount = rsget("commentcount")
				FItemList(i).Fscoresum     = Cint((rsget("point1") + rsget("point2") + rsget("point3") + rsget("point4")) / 4)
				FItemList(i).Fregdate      = rsget("regdate")
				FItemList(i).Fitemid    = rsget("itemid")

				FItemList(i).FImgList        = "http://webimage.10x10.co.kr/image/list/" + GetImageSubFolderByItemid(FItemList(i).Fitemid) + "/" + rsget("listimage")

				If FItemList(i).Fgubun = "01" then
						 FItemList(i).Ficon1        = "http://webimage.10x10.co.kr/image/list/" + GetImageSubFolderByItemid(FItemList(i).Fitemid) + "/" + rsget("listimage")
						 FItemList(i).Ficon2        = "http://webimage.10x10.co.kr/image/list/" + GetImageSubFolderByItemid(FItemList(i).Fitemid) + "/" + rsget("listimage")
				ElseIf FItemList(i).Fgubun = "02" Then
					 if (Not IsNUll(rsget("icon1"))) and (rsget("icon1") <> "") then
						 FItemList(i).Ficon1    = "http://imgstatic.10x10.co.kr/contents/album" + rsget("icon1")
					 end if

					 if (Not IsNUll(rsget("icon2"))) and (rsget("icon2") <> "") then
						 FItemList(i).Ficon2    = "http://imgstatic.10x10.co.kr/contents/album" + rsget("icon2")
					 end If
				ElseIf FItemList(i).Fgubun = "03" Then
					 if (Not IsNUll(rsget("icon1"))) and (rsget("icon1") <> "") then
						 FItemList(i).Ficon1    = "http://imgstatic.10x10.co.kr/contents/maniaimg/evaluate/" & CStr(rsget("masterid")) & + "/icon1/" + rsget("icon1")
					 end if

					 if (Not IsNUll(rsget("icon2"))) and (rsget("icon2") <> "") then
						 FItemList(i).Ficon2    = "http://imgstatic.10x10.co.kr/contents/maniaimg/evaluate/" & CStr(rsget("masterid")) & + "/icon2/" + rsget("icon2")
					 end If
				End if

				FItemList(i).Fitemname    = db2html(rsget("itemname"))
				FItemList(i).Fsellcash    = rsget("sellcash")
				FItemList(i).Fmakerid    = rsget("makerid")

				if IsNULL(FItemList(i).Fsellcash) then FItemList(i).Fsellcash=0
				i=i+1
				rsget.moveNext
			loop
		end if
		rsget.close
	end sub

	'// 포토후기 조회수 증가
	public Sub addCount(byVal v)
		dim sql

        sql = " update [db_board].[dbo].[tbl_user_goodusing] " + VbCrlf
        sql = sql + "set hitcount = hitcount + 1 " + VbCrlf
        sql = sql + " where id = " + CStr(v)  + " "
        rsget.Open sql, dbget, 1
	end sub


	'// 포토후기 상세 내용 접수 //
	public Sub GetAlbumAllRead(byVal v)
		dim sql, i

        FTotalCount = 1

		sql = "select top 1 a.id, a.gubun, a.title, a.contents, a.userid, a.file1, a.file2, a.file3, a.file4, a.file5, a.hitcount, a.commentcount,"
		sql = sql + " a.imgcontents2, a.imgcontents3, a.imgcontents4, a.imgcontents5,"
		sql = sql + " a.point1, a.point2, a.point3, a.point4, a.scoresum, a.regdate, a.masterid, "
		sql = sql + " a.icon1, a.icon2, a.itemid, i.itemname, i.sellcash, (Case When isNull(i.frontMakerid,'')='' then i.makerid else i.frontMakerid end) as makerid "
		sql = sql + " from [db_board].[dbo].[tbl_user_goodusing] a left join [db_item].[dbo].tbl_item i on a.itemid = i.itemid"
		sql = sql + " where a.isdelete <> 'Y' "
		sql = sql + " and (a.id = " + CStr(v) + ")"
		rsget.pagesize = FPageSize
		rsget.Open sql, dbget, 1

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
				set FItemList(i) = new CEvaluateSearcherItem

				FItemList(i).Fidx           = rsget("id")
				FItemList(i).Fgubun       = rsget("gubun")
				FItemList(i).Ftitle        = db2html(rsget("title"))
				FItemList(i).Fcontents     = db2html(rsget("contents"))
				FItemList(i).Fuserid       = rsget("userid")
				FItemList(i).Fitemid    = rsget("itemid")

				If rsget("gubun") = "01" Then

					 FItemList(i).Fnourlfile1 = rsget("file1")
					 if (Not IsNULL(rsget("file1"))) and (rsget("file1") <> "") then
								FItemList(i).Ffile1 = "http://imgstatic.10x10.co.kr/goodsimage/" + GetImageFolerName(i) + "/" + rsget("file1")
					 end if

					 FItemList(i).Fnourlfile2 = rsget("file2")
					 if (Not IsNULL(rsget("file2"))) and (rsget("file2") <> "") then
								FItemList(i).Ffile2 = "http://imgstatic.10x10.co.kr/goodsimage/" + GetImageFolerName(i) + "/" + rsget("file2")
					 end if
					 FItemList(i).Fnourlfile3 = rsget("file3")
					 FItemList(i).Fnourlfile4 = rsget("file4")
					 FItemList(i).Fnourlfile5 = rsget("file5")

				ElseIf rsget("gubun") = "02" Then
					 FItemList(i).Fnourlfile1 = rsget("file1")
					 if (Not IsNULL(rsget("file1"))) and (rsget("file1") <> "") then
								FItemList(i).Ffile1 = "http://imgstatic.10x10.co.kr/contents/album/" + rsget("file1")
					 end if

					 FItemList(i).Fnourlfile2 = rsget("file2")
					 if (Not IsNULL(rsget("file2"))) and (rsget("file2") <> "") then
								FItemList(i).Ffile2 = "http://imgstatic.10x10.co.kr/contents/album/" + rsget("file2")
					 end if

					 FItemList(i).Fnourlfile3 = rsget("file3")
					 if (Not IsNULL(rsget("file3"))) and (rsget("file3") <> "") then
								FItemList(i).Ffile3 = "http://imgstatic.10x10.co.kr/contents/album/" + rsget("file3")
					 end If

					 FItemList(i).Fnourlfile4 = rsget("file4")
					 FItemList(i).Fnourlfile5 = rsget("file5")

				ElseIf rsget("gubun") = "03" Then
					 FItemList(i).Fnourlfile1 = rsget("file1")
					 if (Not IsNULL(rsget("file1"))) and (rsget("file1") <> "") then
								FItemList(i).Ffile1 = "http://imgstatic.10x10.co.kr/contents/maniaimg/evaluate/" & CStr(rsget("masterid")) & + "/file1/" + rsget("file1")
					 end if

					 FItemList(i).Fnourlfile2 = rsget("file2")
					 if (Not IsNULL(rsget("file2"))) and (rsget("file2") <> "") then
								FItemList(i).Ffile2 = "http://imgstatic.10x10.co.kr/contents/maniaimg/evaluate/" & CStr(rsget("masterid")) & + "/file2/" + rsget("file2")
					 end if

					 FItemList(i).Fnourlfile3 = rsget("file3")
					 if (Not IsNULL(rsget("file3"))) and (rsget("file3") <> "") then
								FItemList(i).Ffile3 = "http://imgstatic.10x10.co.kr/contents/maniaimg/evaluate/" & CStr(rsget("masterid")) & + "/file3/" + rsget("file3")
					 end if

					 FItemList(i).Fnourlfile4 = rsget("file4")
					 if (Not IsNULL(rsget("file4"))) and (rsget("file4") <> "") then
								FItemList(i).Ffile4 = "http://imgstatic.10x10.co.kr/contents/maniaimg/evaluate/" & CStr(rsget("masterid")) & + "/file4/" + rsget("file4")
					 end if

					 FItemList(i).Fnourlfile5 = rsget("file5")
					 if (Not IsNULL(rsget("file5"))) and (rsget("file5") <> "") then
								FItemList(i).Ffile5 = "http://imgstatic.10x10.co.kr/contents/maniaimg/evaluate/" & CStr(rsget("masterid")) & + "/file5/" + rsget("file5")
					 end if
				End If

				FItemList(i).Fnourlicon1 = rsget("icon1")
				if (Not IsNULL(rsget("icon1"))) and (rsget("icon1") <> "") then
				        FItemList(i).Ficon1 = "http://imgstatic.10x10.co.kr/contents/album" + rsget("icon1")
				end if

				if (Not IsNULL(rsget("icon2"))) and (rsget("icon2") <> "") then
				        FItemList(i).Ficon2 = "http://imgstatic.10x10.co.kr/contents/album" + rsget("icon2")
				end if

				FItemList(i).Fimgcontents2     = db2html(rsget("imgcontents2"))
				FItemList(i).Fimgcontents3     = db2html(rsget("imgcontents3"))
				FItemList(i).Fimgcontents4     = db2html(rsget("imgcontents4"))
				FItemList(i).Fimgcontents5     = db2html(rsget("imgcontents5"))

				FItemList(i).Fhitcount     = rsget("hitcount")
				FItemList(i).Fcommentcount = rsget("commentcount")
				FItemList(i).Fscoresum     = rsget("scoresum")
				FItemList(i).Fregdate      = rsget("regdate")
'				FItemList(i).Fitemid    = rsget("itemid")
				FItemList(i).Fitemname    = rsget("itemname")
				FItemList(i).Fsellcash    = rsget("sellcash")
				FItemList(i).Fmakerid    = rsget("makerid")
				FItemList(i).FPoint_fun    = rsget("point1")
				FItemList(i).FPoint_dgn    = rsget("point2")
				FItemList(i).FPoint_prc    = rsget("point3")
				FItemList(i).FPoint_stf    = rsget("point4")

				if IsNULL(FItemList(i).Fsellcash) then FItemList(i).Fsellcash=0
				i=i+1
				rsget.moveNext
			loop
		end if
		rsget.close
	end Sub


	'// 포토 후기 진행중인 사은품 정보 접수
	public Sub GetAlbumGiftCont()
		dim strSql

		strSql = "select top 1 t1.startDate, t1.endDate " &_
				"	,t2.itemid, t2.brandname, t2.itemname, t2.sellcash, t2.listimage, (Case When isNull(t2.frontMakerid,'')='' then t2.makerid else t2.frontMakerid end) as makerid " &_
				"from [db_cts].[dbo].tbl_photo_event_winner as t1 " &_
				"	Join [db_search].[dbo].tbl_item as t2 " &_
				"		on t1.linkitemid=t2.itemid " &_
				"where t1.isusing='Y' " &_
				"order by t1.campaignname desc"
		db2_rsget.Open strSql, db2_dbget, 1

		redim preserve FItemList(0)

		if Not(db2_rsget.EOF or db2_rsget.BOF) then
			set FItemList(0) = new CEvaluateSearcherItem

			FItemList(0).Fitemid		= db2_rsget("itemid")
			FItemList(0).FstartDate		= db2_rsget("startDate")
			FItemList(0).FendDate		= db2_rsget("endDate")
			FItemList(0).FMakername		= db2_rsget("brandname")
			FItemList(0).Fitemname		= db2_rsget("itemname")
			FItemList(0).Fsellcash		= db2_rsget("sellcash")
			FItemList(0).FimageList100	= "http://webimage.10x10.co.kr/image/List/" & GetImageSubFolderByItemid(db2_rsget("itemid")) & "/" & db2_rsget("listimage")
			FItemList(0).Fmakerid		= db2_rsget("makerid")
		end if

		db2_rsget.Close
	end Sub


	'// 지난 포토 후기 목록 접수
	public Sub GetLastAlbumList()
		dim strSql, i

		strSql = "select campaignname, startDate, endDate, userid, masteridx " &_
				"from [db_cts].[dbo].tbl_photo_event_winner as t1 " &_
				"where isusing='Y' " &_
				"	and masteridx<>'' " &_
				"	and userid<>'' " &_
				"	and datediff(m,endDate,getdate())<=4 " &_
				"order by campaignname desc"
		db2_rsget.Open strSql, db2_dbget, 1

		FResultCount = db2_rsget.RecordCount
		redim preserve FItemList(FResultCount)

		if Not(db2_rsget.EOF or db2_rsget.BOF) then
			for i=0 to FResultCount-1
				set FItemList(i) = new CEvaluateSearcherItem

				FItemList(i).Fidx			= db2_rsget("masteridx")
				FItemList(i).FstartDate		= db2_rsget("startDate")
				FItemList(i).FendDate		= db2_rsget("endDate")
				FItemList(i).FTitle			= db2_rsget("campaignname")
				FItemList(i).Fuserid		= db2_rsget("userid")
				db2_rsget.MoveNext
			next
		end if

		db2_rsget.Close
	end Sub


	'// 포토 후기 이미지 중간 폴더명 지정 //
	public function GetImageFolerName(byval i)
		GetImageFolerName = GetImageSubFolderByItemid(FItemList(i).FItemID)
	end function



	'// 테스터상품후기 리스트
	Public Sub getTesterEvaluList()
		Dim sqlStr,i
		sqlStr = "EXEC [db_event].[dbo].[sp_Ten_TesterEvaluList_Cnt] '" & FRectItemID & "' "
		rsget.open sqlStr,dbget,1
		FTotalCount = rsget(0)
		rsget.close

		If FTotalCount > 0 Then
			sqlStr = "EXEC [db_event].[dbo].[sp_Ten_TesterEvaluList] '" & FRectItemID & "' "

			rsget.pagesize = FPageSize
			rsget.open sqlStr ,dbget,1

			FResultCount = rsget.RecordCount-(FPageSize*(FCurrPage-1))

			redim preserve FItemList(FResultCount)
			i=0

			IF not rsget.eof THEN
				rsget.absolutepage = FCurrPage
				do until rsget.eof

					set FItemList(i) = new CEvaluateSearcherItem

					FItemList(i).Fidx				= rsget("idx")
					FItemList(i).FUserID			= rsget("userid")
					FItemList(i).FTotalPoint		= rsget("TotalPoint")
					FItemList(i).FUesdContents 		= db2html(rsget("contents"))
					FItemList(i).FRegDate			= rsget("regdate")
					FItemList(i).FIsPhoto			= rsget("isPhoto")

					i=i+1
					rsget.movenext
				loop
			END IF
			rsget.close
		End If
	End Sub



	'// 테스터상품후기 리스트 상세보기
	Public Sub getTesterEvaluView()
		Dim sqlStr,i
		sqlStr = "EXEC [db_event].[dbo].[sp_Ten_TesterEvaluList_View] '" & FRectItemID & "', '" & FIdx & "' "
		rsget.open sqlStr,dbget,1

		If not rsget.eof Then
			FResultCount = 1
			set FEvalItem = new CEvaluateSearcherItem
				FEvalItem.FPoint_fun	= rsget("Point_Function")
				FEvalItem.FPoint_dgn	= rsget("Point_Design")
				FEvalItem.FPoint_prc	= rsget("Point_Price")
				FEvalItem.FPoint_stf	= rsget("Point_Satisfy")
				FEvalItem.FUesdContents = db2html(rsget("contents"))
				FEvalItem.FUseGood   	= db2html(rsget("UseGood"))
				FEvalItem.FUseBad    	= db2html(rsget("UseBad"))
				FEvalItem.FUseETC    	= db2html(rsget("UseETC"))
				FEvalItem.FMyBlog    	= rsget("MyBlog")
				If rsget("file1") <> "" Then
					FEvalItem.Flinkimg1	= "http://imgstatic.10x10.co.kr/testgoodsimage/" + GetImageSubFolderByItemid(FRectItemID) + "/" + rsget("file1")
				End IF
				If rsget("file2") <> "" Then
					FEvalItem.Flinkimg2	= "http://imgstatic.10x10.co.kr/testgoodsimage/" + GetImageSubFolderByItemid(FRectItemID) + "/" + rsget("file2")
				End IF
				If rsget("file3") <> "" Then
					FEvalItem.Flinkimg3	= "http://imgstatic.10x10.co.kr/testgoodsimage/" + GetImageSubFolderByItemid(FRectItemID) + "/" + rsget("file3")
				End IF
				If rsget("file4") <> "" Then
					FEvalItem.Flinkimg4	= "http://imgstatic.10x10.co.kr/testgoodsimage/" + GetImageSubFolderByItemid(FRectItemID) + "/" + rsget("file4")
				End IF
				If rsget("file5") <> "" Then
					FEvalItem.Flinkimg5	= "http://imgstatic.10x10.co.kr/testgoodsimage/" + GetImageSubFolderByItemid(FRectItemID) + "/" + rsget("file5")
				End IF
		Else
			FResultCount = 0
		End If
		rsget.close
	End Sub



	'// 테스터상품후기 팝업
	public sub getItemEvalPopup()
		dim sqlStr,i

		sqlStr = "exec [db_event].[dbo].sp_Ten_TestEvaluate_Tcnt '" & CStr(FPageSize) & "','" + Cstr(FRectItemID) + "','" + Cstr(FRectStartPoint) + "','" + Cstr(Fidx) + "','" + Cstr(FsortMethod)+ "'" + vbcrlf

		rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
		rsget.Open sqlStr,dbget

		FTotalCount = rsget("TotalCnt")
		FTotalPage =  rsget("TotalPage")
		rsget.close

		sqlStr = "exec [db_event].[dbo].sp_Ten_TestEvaluate '" +  CStr(FPageSize) + "','" + CStr(FCurrPage) + "','" + Cstr(FRectItemID) + "','" + Cstr(FRectStartPoint) + "','" + Cstr(Fidx) + "','" + Cstr(FsortMethod) + "'" + vbcrlf


		rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
		rsget.Open sqlStr,dbget

		FResultCount = rsget.RecordCount

		redim preserve FItemList(FResultCount)
		i=0
		if  not rsget.EOF  then
			do until rsget.eof
				set FItemList(i) = new CEvaluateSearcherItem


				FItemList(i).Fidx				= rsget("idx")
				FItemList(i).FUserID			= rsget("UserID")
				FItemList(i).FItemID			= rsget("ItemID")
				FItemList(i).FTotalPoint		= rsget("TotalPoint")
				FItemList(i).FUesdContents 		= db2html(rsget("contents"))
				FItemList(i).FPoint_fun			= rsget("Point_Function")
				FItemList(i).FPoint_dgn			= rsget("Point_Design")
				FItemList(i).FPoint_prc			= rsget("Point_Price")
				FItemList(i).FPoint_stf			= rsget("Point_Satisfy")
				FItemList(i).FRegdate 			= rsget("RegDate")

				If rsget("file1") <> "" Then
					FItemList(i).Flinkimg1	= "http://imgstatic.10x10.co.kr/testgoodsimage/" + GetImageSubFolderByItemid(FRectItemID) + "/" + rsget("file1")
				End IF
				If rsget("file2") <> "" Then
					FItemList(i).Flinkimg2	= "http://imgstatic.10x10.co.kr/testgoodsimage/" + GetImageSubFolderByItemid(FRectItemID) + "/" + rsget("file2")
				End IF
				If rsget("file3") <> "" Then
					FItemList(i).Flinkimg3	= "http://imgstatic.10x10.co.kr/testgoodsimage/" + GetImageSubFolderByItemid(FRectItemID) + "/" + rsget("file3")
				End IF

				FItemList(i).FUseGood   	= db2html(rsget("UseGood"))
				FItemList(i).FUseBad    	= db2html(rsget("UseBad"))
				FItemList(i).FUseETC    	= db2html(rsget("UseETC"))
				FItemList(i).FMyBlog    	= rsget("MyBlog")

				'// 과거자료 중 0점이 존재 1점으로 표시
				if FItemList(i).FTotalPoint="0" then FItemList(i).FTotalPoint="1"
				if FItemList(i).FPoint_fun="0" then FItemList(i).FPoint_fun="1"
				if FItemList(i).FPoint_dgn="0" then FItemList(i).FPoint_dgn="1"
				if FItemList(i).FPoint_prc="0" then FItemList(i).FPoint_prc="1"
				if FItemList(i).FPoint_stf="0" then FItemList(i).FPoint_stf="1"

				i=i+1
				rsget.moveNext
			loop
		end if

		rsget.Close
	end Sub

	'// 카테고리 상품후기 항목별 카운트 2013버전 -- 허진원
	Public Sub getEvaluatedItem_cnt()
		dim sqlStr

		if FRectOption="" then
			'//선택옵션이 없으면 상품정보에서 접수
			sqlStr = " SELECT top 1 "
			sqlStr = sqlStr & " itemname , evalcnt , evalcnt_photo, isNull(evaloffcnt,0) as evaloffcnt "
			sqlStr = sqlStr & " , IsNULL((select count(idx) from [db_event].dbo.tbl_tester_Item_Evaluate where itemid = '"&FRectItemID&"' ),0) as evalcnt_tester  "
			sqlStr = sqlStr & " from "
			sqlStr = sqlStr & " [db_item].[dbo].tbl_item "
			sqlStr = sqlStr & " WHERE itemid='" & FRectItemID & "'  "
		else
			'//옵션필터링이 있으면 카운트
			sqlStr = " SELECT top 1 "
			sqlStr = sqlStr & " I.itemname , isNull(E.ecnt,0) evalcnt, isNull(E.pcnt,0) evalcnt_photo, isNull(T.tcnt,0) evalcnt_tester, isNull(I.evaloffcnt,0) as evaloffcnt "
			sqlStr = sqlStr & " from [db_item].[dbo].tbl_item as I "
			sqlStr = sqlStr & " 	left join ( "
			sqlStr = sqlStr & " 		Select itemid "
			sqlStr = sqlStr & " 			,count(itemid) as ecnt "
			sqlStr = sqlStr & " 			,sum(Case When file1<>'' or file2<>'' Then 1 Else 0 end) as pcnt "
			sqlStr = sqlStr & " 		from db_board.dbo.tbl_Item_Evaluate "
			sqlStr = sqlStr & " 		where isUsing='Y' "
			sqlStr = sqlStr & " 			and itemid=" & FRectItemID & " "
			sqlStr = sqlStr & " 			and isnull(itemoptionname,'')<>'' "
			sqlStr = sqlStr & " 			and itemoption='" & FRectOption & "' "
			sqlStr = sqlStr & " 		group by itemid "
			sqlStr = sqlStr & " 	) as E "
			sqlStr = sqlStr & " 		on I.itemid=E.itemid "
			sqlStr = sqlStr & " 	left join ( "
			sqlStr = sqlStr & " 		select itemid, count(idx) as tcnt "
			sqlStr = sqlStr & " 		from [db_event].dbo.tbl_tester_Item_Evaluate "
			sqlStr = sqlStr & " 		where itemid = " & FRectItemID & " "
			sqlStr = sqlStr & " 		group by itemid "
			sqlStr = sqlStr & " 	) as T "
			sqlStr = sqlStr & " 		on I.itemid=T.itemid "
			sqlStr = sqlStr & " WHERE I.itemid=" & FRectItemID & " "
		end if

			'response.write sqlStr
			rsget.open sqlStr ,dbget,1

			FResultCount = rsget.RecordCount

			set FEvalItem = new CEvaluateSearcherItem
			IF not rsget.eof THEN

					FEvalItem.FItemname 			= db2html(rsget("itemname"))
					FEvalItem.FEvalCnt				= rsget("evalcnt")
					FEvalItem.FEvalcnt_photo		= rsget("evalcnt_photo")
					FEvalItem.FEvalcnt_tester		= rsget("evalcnt_tester")
					FEvalItem.FEvalOffCnt		= rsget("evaloffcnt")

			END IF

			rsget.close

	End Sub

	'후기 특정 상품 코드만 보여주기 in
	public sub getItemEvalList_itemid()
		dim sqlStr,i

		'sqlStr = "exec [db_board].[dbo].sp_Ten_Evaluate_InItemId_Tcnt '" & CStr(FPageSize) & "','" + Cstr(FRectItemID) + "','" + Cstr(FRectStartPoint) + "','" + Cstr(Fidx) + "','" + Cstr(FsortMethod)+ "'" + vbcrlf

		sqlStr = " "&_
					 " SELECT  count(IDX) as TotalCnt  , CEILING(CAST(Count(IDX) AS FLOAT)/convert(FLOAT,'" & CStr(FPageSize) & "'))  as TotalPage " &_
					 " FROM [db_board].[dbo].[tbl_Item_Evaluate] " &_
					 " WHERE IsUsing='Y' " &_
					 " and convert(int,itemid) in (" + Cstr(FRectItemID) + ") " &_
					 " and (('" + Cstr(FRectStartPoint) + "' = '' and 1=1) or ('" + Cstr(FRectStartPoint) + "' <>'' and TotalPoint>='" + Cstr(FRectStartPoint) + "')) " &_
					 " and (('" + Cstr(Fidx) + "'='' and 1=1) or ('" + Cstr(Fidx) + "' <>'' and IDX=convert(int,'" + Cstr(Fidx) + "'))) "
		If Cstr(FsortMethod) = "ph" then
		sqlStr = sqlStr + "AND (file1<>'' or file2<>'')"
		End If

		rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
		rsget.Open sqlStr,dbget

		FTotalCount = rsget("TotalCnt")
		FTotalPage =  rsget("TotalPage")
		rsget.close

		sqlStr = "exec [db_board].[dbo].sp_Ten_Evaluate_InItemId '" +  CStr(FPageSize) + "','" + CStr(FCurrPage) + "','" + Cstr(FRectItemID) + "','" + Cstr(FRectStartPoint) + "','" + Cstr(Fidx) + "','" + Cstr(FsortMethod) + "'" + vbcrlf


		rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
		rsget.Open sqlStr,dbget

		FResultCount = rsget.RecordCount

		redim preserve FItemList(FResultCount)
		i=0
		if  not rsget.EOF  then
			do until rsget.eof
				set FItemList(i) = new CEvaluateSearcherItem


				FItemList(i).Fidx				= rsget("idx")
				FItemList(i).Fgubun			= rsget("Gubun")
				FItemList(i).FUserID			= rsget("UserID")
				FItemList(i).FItemID			= rsget("ItemID")
				FItemList(i).FTotalPoint			= rsget("TotalPoint")
				FItemList(i).FUesdContents 	= db2html(rsget("contents"))
				FItemList(i).FPoint_fun			= rsget("Point_Function")
				FItemList(i).FPoint_dgn			= rsget("Point_Design")
				FItemList(i).FPoint_prc			= rsget("Point_Price")
				FItemList(i).FPoint_stf			= rsget("Point_Satisfy")
				FItemList(i).FRegdate 		= rsget("RegDate")
				FItemList(i).Flinkimg1		= rsget("file1")
				FItemList(i).Flinkimg2		= rsget("file2")
				FItemList(i).FOptionName		= rsget("itemoptionname")

				'// 과거자료 중 0점이 존재 1점으로 표시
				if FItemList(i).FTotalPoint="0" then FItemList(i).FTotalPoint="1"
				if FItemList(i).FPoint_fun="0" then FItemList(i).FPoint_fun="1"
				if FItemList(i).FPoint_dgn="0" then FItemList(i).FPoint_dgn="1"
				if FItemList(i).FPoint_prc="0" then FItemList(i).FPoint_prc="1"
				if FItemList(i).FPoint_stf="0" then FItemList(i).FPoint_stf="1"

				i=i+1
				rsget.moveNext
			loop
		end if

		rsget.Close
	end sub


	'// 상품후기 총점수 취합
	public sub getItemEvalTotalPoint()
		dim sqlStr

		sqlStr = "exec [db_board].[dbo].[usp_WWW_Board_ItemEvaluate_TotalPoint_Get] '" + Cstr(FRectItemID) + "'"

		rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
		rsget.Open sqlStr,dbget

		FResultCount = rsget.RecordCount

		set FEvalItem = new CEvaluateSearcherItem
		if  not rsget.EOF  then
			FEvalItem.FTotalPoint	= rsget("TotalPoint")
			FEvalItem.FPoint_fun 	= rsget("Point_Function")
			FEvalItem.FPoint_dgn 	= rsget("Point_Design")
			FEvalItem.FPoint_prc 	= rsget("Point_Price")
			FEvalItem.FPoint_stf 	= rsget("Point_Satisfy")
		end if

		rsget.Close
	end sub



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

'// 상품후기 옵션 선택상자
function getItemEvalOptSelectbox(frmNm,selVal,selIId,addStr)
	dim sqlStr, i, strRst, chkCnt: chkCnt=0

	strRst = "<select name='" & frmNm & "' " & addStr & " class='select'>"
	strRst = strRst & "<option value="""">옵션선택</option>"

	sqlStr = "select itemOption, itemOptionName "
	sqlStr = sqlStr & "FROM db_board.dbo.tbl_Item_Evaluate "
	sqlStr = sqlStr & "WHERE IsUsing='Y' "
	sqlStr = sqlStr & "and ItemID=" & selIId
	sqlStr = sqlStr & "and isNull(itemOptionName,'')<>'' "
	sqlStr = sqlStr & "group by itemOption, itemOptionName "
	sqlStr = sqlStr & "order by itemOption, itemOptionName "
	rsget.Open sqlStr, dbget, 1

	if Not(rsget.EOF or rsget.BOF) then
		chkCnt = rsget.recordCount
		Do Until rsget.EOF
			strRst = strRst & "<option value=""" & rsget("itemOption") & """" & chkIIF(cStr(rsget("itemOption"))=cStr(selVal),"selected","") & ">" & rsget("itemOptionName") & "</option>"
			rsget.MoveNext
		Loop
	end if

	rsget.Close

	strRst = strRst & "</select>"

	if chkCnt>0 then
		getItemEvalOptSelectbox = strRst
	else
		getItemEvalOptSelectbox = "<input type=""hidden"" name=""" & frmNm & """ value="""" />"
	end if
end function
%>