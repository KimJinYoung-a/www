<%
'###########################################################
' Description :  브랜드스트리트
' History : 2013.08.29 한용민 생성
'###########################################################

Class cbrand_item
	Public Fmakerid
	Public fdgncomment
	Public fsocname
	Public fsocname_kor
	Public fStoryTitle
	Public fStoryContent
	Public flistimage
	public fitemid
	public fitemname
	public fsmallimage
End Class

Class cbrand_list
	Public FItemList()
	Public FOneItem
	Public FTotalCount
	Public FPageSize
	Public FCurrPage
	Public FResultCount
	Public FTotalPage
	Public FPageCount
	Public FScrollCount
	
	public frectmakerid
	public fnotinitem
	
	'/shopping/inc_street_bestitem.asp
	Public Sub getbestitem_list
		Dim sqlStr, i, sqladd

		sqlStr = "exec db_brand.dbo.[sp_Ten_street_bestitem_list] '"&FRectMakerid&"', '"& fnotinitem &"', '"& CStr(FPageSize*FCurrPage) &"'"

'        rsget.CursorLocation = adUseClient
'		rsget.CursorType = adOpenStatic
'		rsget.LockType = adLockOptimistic
'        rsget.pagesize = FPageSize
'		rsget.Open sqlStr,dbget,1
        
        dim rsMem : set rsMem = getDBCacheSQL(dbget,rsget,"BRBS",sqlStr,60*60)
        if (rsMem is Nothing) then Exit Sub ''추가
            
		Ftotalcount = rsMem.RecordCount
		FResultCount = rsMem.RecordCount
		Redim preserve FItemList(FResultCount)
		i = 0
		If  not rsMem.EOF  then
			rsMem.absolutepage = FCurrPage
			Do until rsMem.eof
				Set FItemList(i) = new cbrand_item

					FItemList(i).fitemid = rsMem("itemid")
					FItemList(i).Fmakerid = rsMem("makerid")
					FItemList(i).fitemname = db2html(rsMem("itemname"))
					FItemList(i).fsmallimage = "http://webimage.10x10.co.kr/image/small/" + GetImageSubFolderByItemid(FItemList(i).fitemid) + "/" + rsMem("smallimage")
					
				i = i + 1
				rsMem.moveNext
			Loop
		End If
		rsMem.Close
	End Sub
	
	'/shopping/inc_street_bestitem.asp
	Public Sub getbestitem()
		Dim sqlStr, i
		
		sqlStr = "exec db_brand.dbo.[sp_Ten_street_bestitem] '"&FRectMakerid&"' "
		
		'response.write sqlStr & "<br>"
        rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
		rsget.Open sqlStr,dbget,1

		FTotalCount = rsget.RecordCount
		FResultCount = rsget.RecordCount
		Redim preserve FItemList(FResultCount)
		i = 0
		If not rsget.EOF then
			Do until rsget.EOF
				Set FOneItem = new cbrand_item
					
					FOneItem.fitemid				= rsget("itemid")
					FOneItem.FMakerid				= rsget("makerid")
					FOneItem.fdgncomment			= db2html(rsget("dgncomment"))
					FOneItem.fsocname			= db2html(rsget("socname"))
					FOneItem.fsocname_kor			= db2html(rsget("socname_kor"))
					FOneItem.fStoryTitle			= db2html(rsget("StoryTitle"))
					FOneItem.fStoryContent			= db2html(rsget("StoryContent"))
					FOneItem.flistimage				= "http://webimage.10x10.co.kr/image/list/" + GetImageSubFolderByItemid(FOneItem.Fitemid) + "/" + rsget("listimage")
					
				i = i + 1
				rsget.moveNext
			Loop
		End If
		rsget.Close
	End Sub

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
End Class

Class cmanager_item
	Public FIdx
	Public Fmakerid
	Public Fregdate
	Public Flastupdate
	Public Fbrandgubun
	public fregadminid
	public flastadminid
	public Fsubtopimage
	public Fbrandgubunname
	public forderno
	public Fhello_yn
	public Finterview_yn
	public Ftenbytenand_yn
	public Fartistwork_yn
	public Fshop_collection_yn
	public Fshop_event_yn
	public Flookbook_yn
	public fisusing
	public fsocname
	public fsocname_kor
	public FCatecode
	public FRecommendcount
End Class

Class cmanager
	Public FItemList()
	Public FOneItem
	Public FTotalCount
	Public FPageSize
	Public FCurrPage
	Public FResultCount
	Public FTotalPage
	Public FPageCount
	Public FScrollCount

	Public FrectMakerid
	Public Frectbrandgubun
	public FrectIdx
	public frectisusing

	'//street/street_brand.asp		'/shopping/category_prd.asp
	public sub sbbrandgubunlist()
		dim SqlStr ,i

		sqlStr = "exec db_brand.[dbo].[sp_Ten_street_brandgubun] '"&frectmakerid&"'"
		'Response.write sqlStr &"<br>"

        rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
        rsget.pagesize = FPageSize
		rsget.Open sqlStr,dbget,1

		Ftotalcount = rsget.RecordCount
		FResultCount = rsget.RecordCount
		Redim preserve FItemList(FResultCount)
		i = 0
		If  not rsget.EOF  then
			rsget.absolutepage = FCurrPage
			Do until rsget.eof
				Set FOneItem = new cmanager_item

				FOneItem.fmakerid			= rsget("makerid")
				FOneItem.fsocname			= rsget("socname")
				FOneItem.fsocname_kor			= rsget("socname_kor")
				FOneItem.fbrandgubun			= rsget("brandgubun")
				FOneItem.fsubtopimage			= rsget("subtopimage")
				FOneItem.fbrandgubunname			= rsget("brandgubunname")
				FOneItem.fhello_yn			= rsget("hello_yn")
				FOneItem.finterview_yn			= rsget("interview_yn")
				FOneItem.ftenbytenand_yn			= rsget("tenbytenand_yn")
				FOneItem.fartistwork_yn			= rsget("artistwork_yn")
				FOneItem.fshop_collection_yn			= rsget("shop_collection_yn")
				FOneItem.fshop_event_yn			= rsget("shop_event_yn")
				FOneItem.flookbook_yn			= rsget("lookbook_yn")
				FOneItem.FCatecode			= rsget("standardCatecode")
				FOneItem.FRecommendcount			= rsget("recommendcount")

				i = i + 1
				rsget.moveNext
			Loop
		End If
		rsget.Close
	End Sub

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
End Class

Class cinterview_item
	public fmainidx
	public fmakerid
	public fstartdate
	public ftitle
	public fcomment
	public fmainimg
	public fdetailimg
	public fdetailimglink
	public fisusing
	public fregdate
	public flastupdate
	public fregadminid
	public flastadminid
	public fcommentidx
	public fuserid
	public fimgCnt
	public fpremainidx
	public fnextmainidx
End Class

Class cinterview
	Public FItemList()
	Public FOneItem
	Public FTotalCount
	Public FPageSize
	Public FCurrPage
	Public FResultCount
	Public FTotalPage
	Public FPageCount
	Public FScrollCount

	public FrectMakerid
	public FRectDesignerId
	public Frectstate
	public Frecttitle
	public frectisusing
	public FrectIdx

	'/street/act_interview.asp
	Public Sub getinterview_comment_list
		Dim sqlStr, i, sqladd

		sqlStr = "exec db_brand.dbo.sp_Ten_street_interview_comment_cnt '"&frectidx&"','"&frectisusing&"'"

		'Response.write sqlStr &"<br>"
		rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
		rsget.Open sqlStr,dbget,1
			FTotalCount = rsget("cnt")
		rsget.Close

		if FTotalCount < 1 then exit Sub

		sqlStr = "exec db_brand.dbo.sp_Ten_street_interview_comment_list '"&frectidx&"','"&frectisusing&"', '" & CStr(FPageSize*FCurrPage) & "'"

		'Response.write sqlStr &"<br>"
        rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
        rsget.pagesize = FPageSize
		rsget.Open sqlStr,dbget,1

		if (FCurrPage * FPageSize < FTotalCount) then
			FResultCount = FPageSize
		else
			FResultCount = FTotalCount - FPageSize*(FCurrPage-1)
		end if

		FTotalPage = (FTotalCount\FPageSize)
		if (FTotalPage<>FTotalCount/FPageSize) then FTotalPage = FTotalPage +1

		redim preserve FItemList(FResultCount)

		FPageCount = FCurrPage - 1

		i=0
		if  not rsget.EOF  then
			rsget.absolutepage = FCurrPage
			do until rsget.EOF
				set FItemList(i) = new cinterview_item

				FItemList(i).fcommentidx		= rsget("commentidx")
				FItemList(i).fmainidx			= rsget("mainidx")
				FItemList(i).fuserid			= rsget("userid")
				FItemList(i).fcomment			= db2html(rsget("comment"))
				FItemList(i).fisusing			= rsget("isusing")
				FItemList(i).fregdate			= rsget("regdate")

				rsget.movenext
				i=i+1
			loop
		end if

		rsget.Close
	End Sub

	'/street/act_interview.asp
	Public Sub finterviewmain_list
		Dim sqlStr, i, sqladd
		if FRectDesignerId="" then exit Sub

		sqlStr = "exec db_brand.[dbo].[sp_Ten_street_interview_main_list] '"&FRectDesignerId&"','"&frectidx&"'"

		'Response.write sqlStr &"<br>"
        rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
        rsget.pagesize = FPageSize
		rsget.Open sqlStr,dbget,1

		Ftotalcount = rsget.RecordCount
		FResultCount = rsget.RecordCount
		Redim preserve FItemList(FResultCount)
		i = 0
		If  not rsget.EOF  then
			rsget.absolutepage = FCurrPage
			Do until rsget.eof
				Set FOneItem = new cinterview_item

					FOneItem.fpremainidx = rsget("premainidx")
					FOneItem.fnextmainidx = rsget("nextmainidx")
					FOneItem.Fmainidx = rsget("mainidx")
					FOneItem.Fmakerid = rsget("makerid")
					FOneItem.Fstartdate = rsget("startdate")
					FOneItem.Ftitle = db2html(rsget("title"))
					FOneItem.Fcomment = db2html(rsget("comment"))
					FOneItem.Fmainimg = rsget("mainimg")
					FOneItem.fdetailimg = rsget("detailimg")
					FOneItem.fdetailimglink = db2html(rsget("detailimglink"))
					FOneItem.Fisusing = rsget("isusing")
					FOneItem.Fregdate = rsget("regdate")
					FOneItem.Flastupdate = rsget("lastupdate")
					FOneItem.Fregadminid = rsget("regadminid")
					FOneItem.Flastadminid = rsget("lastadminid")

				i = i + 1
				rsget.moveNext
			Loop
		End If
		rsget.Close
	End Sub

	'/street/act_interview.asp '//신버전
	Public Sub finterviewsub_list
		Dim sqlStr, i, sqladd

		sqlStr = "exec db_brand.[dbo].[sp_Ten_street_interview_sub_cnt] '"&FRectDesignerId&"','"&frectidx&"'"

		'Response.write sqlStr &"<br>"
		rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
		rsget.Open sqlStr,dbget,1
			FTotalCount = rsget(0)
		rsget.Close

		if FTotalCount < 1 then exit Sub

		sqlStr = "exec db_brand.[dbo].[sp_Ten_street_interview_sub_list] '"&FRectDesignerId&"','"&frectidx&"'"

		'Response.write sqlStr &"<br>"
        rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
        rsget.pagesize = FPageSize
		rsget.Open sqlStr,dbget,1

		redim preserve FItemList(FTotalCount)

		i=0
		if  not rsget.EOF  then
			rsget.absolutepage = 1
			do until rsget.EOF
				set FItemList(i) = new cinterview_item

				FItemList(i).fdetailimg		= rsget("detailimg")
				FItemList(i).fdetailimglink	= rsget("detailimglink")

				rsget.movenext
				i=i+1
			loop
		end if

		rsget.Close
	End Sub

	Private Sub Class_Initialize()
		FCurrPage =1
		FPageSize = 50
		FResultCount = 0
		FScrollCount = 10
		FTotalCount =0
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
End Class

class cevent_item
	public FECode
	public FEGCode
   	public FEGPCode

	public FEKind
	public FEManager
	public FEScope
	public FEName
	public FESDate
	public FEEDate
	public FEState
	public FERegdate
	public FEPDate
	public FECategory
	public FECateMid
	public FSale
	public FGift
	public FCoupon
	public FComment
	public FBlogURL
	public FBBS
	public FItemeps
	public FApply
	public FTemplate
	public FEMimg
	public FEHtml
	public FItemsort
	public FBrand
	public FGimg
	public FFullYN
	public FIteminfoYN
	public frectekind
	public FFBAppid
	public FFBcontent
	public FBimg
	public FEDispCate
	public FEWideYN
	public FItempriceYN
	
	Private Sub Class_Initialize()
	End Sub
	Private Sub Class_Terminate()
	End Sub
end Class

class cevent
    public FOneItem
	public FItemList()
	public FTotalCount
	public FCurrPage
	public FTotalPage
	public FPageSize
	public FResultCount
	public FScrollCount
	public FPageCount
	
	public frectevt_code
	public frectmakerid
	public frectevt_kind

	'//street/act_shop_event.asp
	Public Sub fnGetEventitem
		Dim sqlStr, i, sqladd

		sqlStr = "exec db_brand.[dbo].[sp_Ten_street_shop_event_item_cnt] '"&frectevt_code&"'"

		'Response.write sqlStr &"<br>"
		rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
		rsget.pagesize = FPageSize
		rsget.Open sqlStr,dbget,1
			FTotalCount = rsget("cnt")
		rsget.Close

		if FTotalCount < 1 then exit Sub

		sqlStr = "exec db_brand.[dbo].[sp_Ten_street_shop_event_item_list] '"&frectevt_code&"', '" & CStr(FPageSize*FCurrPage) & "'"

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
				Set FItemList(i) = new CCategoryPrdItem

					FItemList(i).fevt_code			= rsget("evt_code")
					FItemList(i).fitemid			= rsget("itemid")
					FItemList(i).FImageIcon1 = "http://webimage.10x10.co.kr/image/Icon1/" + GetImageSubFolderByItemid(FItemList(i).Fitemid) + "/" + db2html(rsget("icon1image"))
					FItemList(i).fEvalCnt			= rsget("EvalCnt")
					FItemList(i).FEvalcnt_Photo			= rsget("Evalcnt_Photo")
					FItemList(i).ffavCount			= rsget("favCount")
					FItemList(i).fItemName 	= db2html(rsget("ItemName"))
					FItemList(i).FSellCash = rsget("SellCash")
					FItemList(i).FOrgPrice = rsget("OrgPrice")
					FItemList(i).FSellyn = rsget("Sellyn")
					FItemList(i).FSaleyn = rsget("sailyn")
					FItemList(i).FLimityn = rsget("Limityn")
					FItemList(i).FItemcouponyn = rsget("Itemcouponyn")
					FItemList(i).FItemCouponValue = rsget("ItemCouponValue")
					FItemList(i).FItemCouponType = rsget("ItemCouponType")
					FItemList(i).FItemScore = rsget("ItemScore")
					FItemList(i).FtenOnlyYn = rsget("tenOnlyYn")

				i = i + 1
				rsget.moveNext
			Loop
		End If
		rsget.Close
	End Sub
	
	'//street/act_shop_event.asp
	Public Sub fnGetEvent()
		Dim sqlStr, i, sqladd
		
		sqlStr = "exec db_brand.dbo.sp_Ten_street_shop_event '"&frectevt_code&"', '"&frectmakerid&"', '"&frectevt_kind&"'"
        rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
		rsget.Open sqlStr,dbget,1

		FTotalCount = rsget.RecordCount
		FResultCount = rsget.RecordCount
		Redim preserve FItemList(FResultCount)
		i = 0
		If not rsget.EOF then
			Do until rsget.EOF
				Set FOneItem = new cevent_item
				
				FOneItem.FECode		= rsget("evt_code")
				FOneItem.FEKind		= rsget("evt_kind")
				FOneItem.FEManager 	= rsget("evt_manager")
				FOneItem.FEScope 	= rsget("evt_scope")
				FOneItem.FEName 		= db2html(rsget("evt_name"))
				FOneItem.FESDate 	= rsget("evt_startdate")
				FOneItem.FEEDate 	= rsget("evt_enddate")
				FOneItem.FEState 	= rsget("evt_state")
				FOneItem.FERegdate 	= rsget("evt_regdate")
				FOneItem.FEPDate  	= rsget("evt_prizedate")
   				FOneItem.FECategory 	= rsget("evt_category")
   				FOneItem.FECateMid 	= rsget("evt_cateMid")
   				FOneItem.FSale 		= rsget("issale")
   				FOneItem.FGift 		= rsget("isgift")
   				FOneItem.FCoupon   	= rsget("iscoupon")
   				FOneItem.FComment 	= rsget("iscomment")
   				FOneItem.FBlogURL	= rsget("isGetBlogURL")
   				FOneItem.FBBS	 	= rsget("isbbs")
   				FOneItem.FItemeps 	= rsget("isitemps")
   				FOneItem.FApply 		= rsget("isapply")
   				FOneItem.FTemplate 	= rsget("evt_template")
   				FOneItem.FEMimg 		= rsget("evt_mainimg")
   				FOneItem.FEHtml 		= db2html(rsget("evt_html"))
   				FOneItem.FItemsort 	= rsget("evt_itemsort")
   				FOneItem.FBrand 		= db2html(rsget("brand"))
   				
   				IF FOneItem.FGift THEN FOneItem.FGimg		= rsget("evt_giftimg")
   					
   				FOneItem.FFullYN		= rsget("evt_fullYN")
   				FOneItem.FIteminfoYN	= rsget("evt_iteminfoYN")
   				FOneItem.FFBAppid	= rsget("fb_appid")
   				FOneItem.FFBcontent	= rsget("fb_content")
   				FOneItem.FBimg		= rsget("evt_bannerimg")
   				FOneItem.FItempriceYN	= rsget("evt_itempriceyn")
   				FOneItem.FEWideYN	= rsget("evt_wideyn")
   				
   				If rsget("evt_dispCate") = 0 Then
   					FOneItem.FEDispCate	= ""
   				Else
   					FOneItem.FEDispCate	= rsget("evt_dispCate")
   				End If
   				
				i = i + 1
				rsget.moveNext
			Loop
		End If
		rsget.Close
	End Sub

	Private Sub Class_Initialize()
		redim  FItemList(0)
		FCurrPage =1
		FPageSize = 12
		FResultCount = 0
		FScrollCount = 10
		FTotalCount =0
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

class ccollection_item
	public fidx
	public fmakerid
	public ftitle
	public fsubtitle
	public fstate
	public fmainimg
	public fisusing
	public fsortNo
	public fregdate
	public flastupdate
	public fregadminid
	public flastadminid
	public fcomment
	public fdetailidx
	public fmasteridx
	public fitemCnt
	public fsellyn
	public fitemisusing
	
	Private Sub Class_Initialize()
	End Sub
	Private Sub Class_Terminate()
	End Sub
end Class

class ccollection
    public FOneItem
	public FItemList()
	public FTotalCount
	public FCurrPage
	public FTotalPage
	public FPageSize
	public FResultCount
	public FScrollCount
	public FPageCount
	
	public FrectMakerid
	public Frectstate
	public Frecttitle
	public frectisusing
	public FrectIdx
	Public Fitemid

	'//shopping/inc_street_Collection.asp  cateprd전용
	Public Sub getcollection_master_new
		Dim sqlStr, i, sqladd

		sqlStr = "exec db_brand.[dbo].[sp_Ten_street_shop_collection_master_list_new] '"&frectmakerid&"','"&frectidx&"','"&Frectstate&"','"&frectisusing&"', '" & CStr(FPageSize*FCurrPage) & "' ,'"& Fitemid &"' "

		'Response.write sqlStr &"<br>"

        rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
        rsget.pagesize = FPageSize
		rsget.Open sqlStr,dbget,1

		Ftotalcount = rsget.RecordCount
		FResultCount = rsget.RecordCount
		Redim preserve FItemList(FResultCount)
		i = 0
		If  not rsget.EOF  then
			rsget.absolutepage = FCurrPage
			Do until rsget.eof
				Set FItemList(i) = new ccollection_item

					FItemList(i).Fidx = rsget("idx")
					FItemList(i).Fmakerid = rsget("makerid")
					FItemList(i).Ftitle = db2html(rsget("title"))
					FItemList(i).fsubtitle = db2html(rsget("subtitle"))
					FItemList(i).Fstate = rsget("state")
					FItemList(i).Fmainimg = rsget("mainimg")
					FItemList(i).Fisusing = rsget("isusing")
					FItemList(i).FsortNo = rsget("sortNo")
					FItemList(i).Fregdate = rsget("regdate")
					FItemList(i).Flastupdate = rsget("lastupdate")
					FItemList(i).Fregadminid = rsget("regadminid")
					FItemList(i).Flastadminid = rsget("lastadminid")
					FItemList(i).Fcomment = db2html(rsget("comment"))
					FItemList(i).fitemcnt = rsget("itemcnt")
					
				i = i + 1
				rsget.moveNext
			Loop
		End If
		rsget.Close
	End Sub
	
	'/street/act_shop_collection.asp	
	Public Sub getcollection_master
		Dim sqlStr, i, sqladd

		sqlStr = "exec db_brand.[dbo].[sp_Ten_street_shop_collection_master_list] '"&frectmakerid&"','"&frectidx&"','"&Frectstate&"','"&frectisusing&"', '" & CStr(FPageSize*FCurrPage) & "' "

		'Response.write sqlStr &"<br>"

        rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
        rsget.pagesize = FPageSize
		rsget.Open sqlStr,dbget,1

		Ftotalcount = rsget.RecordCount
		FResultCount = rsget.RecordCount
		Redim preserve FItemList(FResultCount)
		i = 0
		If  not rsget.EOF  then
			rsget.absolutepage = FCurrPage
			Do until rsget.eof
				Set FItemList(i) = new ccollection_item

					FItemList(i).Fidx = rsget("idx")
					FItemList(i).Fmakerid = rsget("makerid")
					FItemList(i).Ftitle = db2html(rsget("title"))
					FItemList(i).fsubtitle = db2html(rsget("subtitle"))
					FItemList(i).Fstate = rsget("state")
					FItemList(i).Fmainimg = rsget("mainimg")
					FItemList(i).Fisusing = rsget("isusing")
					FItemList(i).FsortNo = rsget("sortNo")
					FItemList(i).Fregdate = rsget("regdate")
					FItemList(i).Flastupdate = rsget("lastupdate")
					FItemList(i).Fregadminid = rsget("regadminid")
					FItemList(i).Flastadminid = rsget("lastadminid")
					FItemList(i).Fcomment = db2html(rsget("comment"))
					FItemList(i).fitemcnt = rsget("itemcnt")
					
				i = i + 1
				rsget.moveNext
			Loop
		End If
		rsget.Close
	End Sub

	'/street/act_shop_collection.asp
	Public Sub getshop_collection_detail
		Dim sqlStr, i, sqladd

		sqlStr = "exec db_brand.[dbo].[sp_Ten_street_shop_collection_detail_list] '"&frectidx&"','"&frectisusing&"', '" & CStr(FPageSize*FCurrPage) & "'"

		'Response.write sqlStr &"<br>"
        rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
        rsget.pagesize = FPageSize
		rsget.Open sqlStr,dbget,1

		FTotalCount = rsget.recordcount
		FResultCount = rsget.RecordCount-(FPageSize*(FCurrPage-1))

		Redim preserve FItemList(FResultCount)
		i = 0
		If  not rsget.EOF  then
			rsget.absolutepage = FCurrPage
			Do until rsget.eof
				Set FItemList(i) = new CCategoryPrdItem

					FItemList(i).fdetailidx			= rsget("detailidx")
					FItemList(i).fmasteridx			= rsget("masteridx")
					FItemList(i).fitemid			= rsget("itemid")
					FItemList(i).fisusing			= rsget("isusing")
					FItemList(i).fsortNo			= rsget("sortNo")
					FItemList(i).fregdate			= rsget("regdate")
					FItemList(i).flastupdate			= rsget("lastupdate")
					FItemList(i).fregadminid			= rsget("regadminid")
					FItemList(i).flastadminid			= rsget("lastadminid")
					FItemList(i).FImageIcon1 	= db2html(rsget("icon1image"))
					FItemList(i).FImageIcon2 	= db2html(rsget("icon2image"))
					FItemList(i).fEvalCnt			= rsget("EvalCnt")
					FItemList(i).FEvalcnt_Photo			= rsget("Evalcnt_Photo")
					FItemList(i).ffavCount			= rsget("favCount")
					FItemList(i).fItemName 	= db2html(rsget("ItemName"))
					FItemList(i).FSellCash = rsget("SellCash")
					FItemList(i).FOrgPrice = rsget("OrgPrice")
					FItemList(i).FSellyn = rsget("Sellyn")
					FItemList(i).FSaleyn = rsget("sailyn")
					FItemList(i).FLimityn = rsget("Limityn")
					FItemList(i).FItemcouponyn = rsget("Itemcouponyn")
					FItemList(i).FItemCouponValue = rsget("ItemCouponValue")
					FItemList(i).FItemCouponType = rsget("ItemCouponType")
					FItemList(i).FItemScore = rsget("ItemScore")
					FItemList(i).FtenOnlyYn = rsget("tenOnlyYn")
										
				i = i + 1
				rsget.moveNext
			Loop
		End If
		rsget.Close
	End Sub
	
	Private Sub Class_Initialize()
		redim  FItemList(0)
		FCurrPage =1
		FPageSize = 12
		FResultCount = 0
		FScrollCount = 10
		FTotalCount =0
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

Class clookbook_item
	Public Fidx
	Public Fmakerid
	Public Ftitle
	Public Fstate
	Public Fmainimg
	Public Fisusing
	Public FsortNo
	Public Fregdate
	Public Flastupdate
	Public Fregadminid
	Public Flastadminid
	Public Fdetailidx
	Public Fmasteridx
	Public Flookbookimg
	public fimgCnt
	public fcomment
	public fpreidx
	public fnextidx
End Class

Class clookbook
	Public FItemList()
	Public FOneItem
	Public FTotalCount
	Public FPageSize
	Public FCurrPage
	Public FResultCount
	Public FTotalPage
	Public FPageCount
	Public FScrollCount

	public FrectMakerid
	public Frectstate
	public Frecttitle
	public frectisusing
	public FrectIdx
	public FrectdetailIdx

	'/street/act_lookbook.asp
	Public Sub getlookbook_detail_one
		Dim sqlStr, i, sqladd
		
		sqlStr = "exec db_brand.dbo.[sp_Ten_street_lookbook_detail_one] '"&frectidx&"', '"&FrectdetailIdx&"', '"&frectisusing&"'"
		
		'Response.write sqlStr &"<br>"
        rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
		rsget.Open sqlStr,dbget,1

		FTotalCount = rsget.RecordCount
		FResultCount = rsget.RecordCount
		Redim preserve FItemList(FResultCount)
		i = 0
		If not rsget.EOF then
			Do until rsget.EOF
				Set FOneItem = new clookbook_item
				
				FOneItem.fdetailidx			= rsget("detailidx")
				FOneItem.fmasteridx			= rsget("masteridx")
				FOneItem.flookbookimg		= rsget("lookbookimg")
				FOneItem.FIsusing		= rsget("isusing")
				FOneItem.FRegdate		= rsget("regdate")
				FOneItem.flastupdate	= rsget("lastupdate")
				FOneItem.fregadminid		= rsget("regadminid")
				FOneItem.flastadminid	= rsget("lastadminid")
				FOneItem.fpreidx = rsget("preidx")
				FOneItem.fnextidx = rsget("nextidx")
					
				i = i + 1
				rsget.moveNext
			Loop
		End If
		rsget.Close
	End Sub
	
	'/street/act_lookbook.asp
	Public Sub getlookbook_master
		Dim sqlStr, i, sqladd

		sqlStr = "exec db_brand.[dbo].[sp_Ten_street_lookbook_master_list] '"&frectmakerid&"','"&frectidx&"','"&Frectstate&"','"&frectisusing&"', '" & CStr(FPageSize*FCurrPage) & "' "

		'Response.write sqlStr &"<br>"

        rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
        rsget.pagesize = FPageSize
		rsget.Open sqlStr,dbget,1

		Ftotalcount = rsget.RecordCount
		FResultCount = rsget.RecordCount
		Redim preserve FItemList(FResultCount)
		i = 0
		If  not rsget.EOF  then
			rsget.absolutepage = FCurrPage
			Do until rsget.eof
				Set FItemList(i) = new clookbook_item

					FItemList(i).Fidx = rsget("idx")
					FItemList(i).Fmakerid = rsget("makerid")
					FItemList(i).Ftitle = db2html(rsget("title"))
					FItemList(i).Fstate = rsget("state")
					FItemList(i).Fmainimg = rsget("mainimg")
					FItemList(i).Fisusing = rsget("isusing")
					FItemList(i).FsortNo = rsget("sortNo")
					FItemList(i).Fregdate = rsget("regdate")
					FItemList(i).Flastupdate = rsget("lastupdate")
					FItemList(i).Fregadminid = rsget("regadminid")
					FItemList(i).Flastadminid = rsget("lastadminid")

				i = i + 1
				rsget.moveNext
			Loop
		End If
		rsget.Close
	End Sub

	'/street/act_lookbook.asp		'/사용안함
	Public Sub getlookbook_detail
		Dim sqlStr, i, sqladd

		sqlStr = "exec db_brand.[dbo].[sp_Ten_street_lookbook_detail_cnt] '"&frectidx&"','"&frectisusing&"'"

		'Response.write sqlStr &"<br>"
       	rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
       	rsget.pagesize = FPageSize
		rsget.Open sqlStr,dbget,1
			FTotalCount = rsget("cnt")
		rsget.Close

		if FTotalCount < 1 then exit Sub

		sqlStr = "exec db_brand.[dbo].[sp_Ten_street_lookbook_detail_list] '"&frectidx&"','"&frectisusing&"', '" & CStr(FPageSize*FCurrPage) & "'"

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

		Redim preserve FItemList(FResultCount)
		i = 0
		If  not rsget.EOF  then
			rsget.absolutepage = FCurrPage
			Do until rsget.eof
				Set FItemList(i) = new clookbook_item

					FItemList(i).fdetailidx			= rsget("detailidx")
					FItemList(i).fmasteridx			= rsget("masteridx")
					FItemList(i).flookbookimg		= rsget("lookbookimg")
					FItemList(i).FIsusing		= rsget("isusing")
					FItemList(i).FRegdate		= rsget("regdate")
					FItemList(i).flastupdate	= rsget("lastupdate")
					FItemList(i).fregadminid		= rsget("regadminid")
					FItemList(i).flastadminid	= rsget("lastadminid")

				i = i + 1
				rsget.moveNext
			Loop
		End If
		rsget.Close
	End Sub

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
End Class

Class CGalleryItem
	public Fgal_sn
	public Fdesignerid
	public Fgal_div
	public Fgal_imgorg
	public Fgal_img400
	public Fgal_regdate
	public Fgal_isusing
	public Fgal_desc
	public Fgal_sortNo

	Private Sub Class_Initialize()
	End Sub
	Private Sub Class_Terminate()
	End Sub
end Class

Class CGallery
	public FItemList()
	public FTotalCount
	public FResultCount
	public FCurrPage
	public FTotalPage
	public FPageSize
	public FScrollCount
	public FPageCount
	public FOneItem
	public FGubun
	public FTab
	public FSellyn
	public FIdx

	public Fcmt_sn
	public Fcmt
	public FRectGal_div
	public FRectDesignerId
	public FRectIsusing


	Public Sub GetGalleryDetail
		Dim sqlStr, i, sqladd

'/부하 줄일려고 쿼리 안함. 탑몇개 갯수 제한주고 다뿌림
'		sqlStr = "exec [db_contents].[dbo].[ten_artist_Detail_cnt] '" & FRectDesignerId & "', '" & FRectGal_div & "'"
'
'		'Response.write sqlStr &"<br>"
'		rsget.CursorLocation = adUseClient
'		rsget.CursorType = adOpenStatic
'		rsget.LockType = adLockOptimistic
'		rsget.pagesize = FPageSize
'		rsget.Open sqlStr,dbget,1
'			FTotalCount = rsget("cnt")
'		rsget.Close
'
'		if FTotalCount < 1 then exit Sub

		sqlStr = "exec [db_contents].[dbo].[ten_artist_Detail] " & FPageSize & ", " & FCurrPage & ", '" & FRectDesignerId & "', '" & FRectGal_div & "'"

		'Response.write sqlStr &"<br>"
        rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
        rsget.pagesize = FPageSize
		rsget.Open sqlStr,dbget,1

		FTotalCount = rsget.recordcount
		FResultCount = rsget.RecordCount-(FPageSize*(FCurrPage-1))

		Redim preserve FItemList(FResultCount)
		i = 0
		If  not rsget.EOF  then
			rsget.absolutepage = FCurrPage
			Do until rsget.eof
				Set FItemList(i) = new CGalleryItem

					FItemList(i).Fgal_sn				= rsget("gal_sn")
					FItemList(i).Fdesignerid			= rsget("designerid")
					FItemList(i).Fgal_div				= rsget("gal_div")
					FItemList(i).Fgal_imgorg			= rsget("gal_imgorg")
					FItemList(i).Fgal_img400			= rsget("gal_img400")
					FItemList(i).Fgal_regdate			= rsget("gal_regdate")
					FItemList(i).Fgal_isusing			= rsget("gal_isusing")
					FItemList(i).Fgal_desc				= rsget("gal_desc")
					FItemList(i).Fgal_sortNo			= rsget("gal_sortNo")

				i = i + 1
				rsget.moveNext
			Loop
		End If
		rsget.Close
	End Sub

	Private Sub Class_Initialize()
		FCurrPage =1
		FPageSize = 50
		FResultCount = 0
		FScrollCount = 10
		FTotalCount =0
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

Class cTENBYTEN_item
	Public FIdx
	Public FMakerid
	Public FFlag
	Public FImgurl
	Public FLinkurl
	Public FPlayurl
	Public FRegdate
	Public FSortNO
	Public FRegisterID
	Public FIsusing
End Class

Class cTENBYTENand
	Public FItemList()
	Public FOneItem
	Public FTotalCount
	Public FPageSize
	Public FCurrPage
	Public FResultCount
	Public FTotalPage
	Public FPageCount
	Public FScrollCount

	Public frectmakerid
	Public frectisusing

	'//street/inc_tenbytenand.asp		'//shopping/inc_brand.asp
	public sub sbTENBYTENlist()
		dim SqlStr ,i

		sqlStr = "exec db_brand.[dbo].[sp_Ten_street_tenbytenand] '"&frectmakerid&"','"&frectisusing&"', '" & CStr(FPageSize*FCurrPage) & "' "

		'Response.write sqlStr &"<br>"

        rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
        rsget.pagesize = FPageSize
		rsget.Open sqlStr,dbget,1

		Ftotalcount = rsget.RecordCount
		FResultCount = rsget.RecordCount
		Redim preserve FItemList(FResultCount)
		i = 0
		If  not rsget.EOF  then
			rsget.absolutepage = FCurrPage
			Do until rsget.eof
				Set FItemList(i) = new cTENBYTEN_item
					FItemList(i).FIdx			= rsget("idx")
					FItemList(i).FMakerid		= rsget("makerid")
					FItemList(i).FFlag			= rsget("flag")
					FItemList(i).FImgurl		= rsget("imgurl")
					FItemList(i).FLinkurl		= db2html(rsget("linkurl"))
					FItemList(i).FPlayurl		= db2html(rsget("playurl"))
					FItemList(i).FRegdate		= rsget("regdate")
					FItemList(i).FSortNO		= rsget("sortNO")
					FItemList(i).FRegisterID	= rsget("registerID")
					FItemList(i).FIsusing		= rsget("isusing")
				i = i + 1
				rsget.moveNext
			Loop
		End If
		rsget.Close
	End Sub

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
End Class

Class cHello_item
	Public FMakerid
	Public FBrandgubun
	Public FSubtopimage
	Public FCatecode
	Public FBgImageURL
	Public FStoryTitle
	Public FStoryContent
	Public FPhilosophyTitle
	Public FPhilosophyContent
	Public FDesignis
	Public FBookmark1SiteName
	Public FBookmark1SiteURL
	Public FBookmark1SiteDetail
	Public FBookmark2SiteName
	Public FBookmark2SiteURL
	Public FBookmark2SiteDetail
	Public FBookmark3SiteName
	Public FBookmark3SiteURL
	Public FBookmark3SiteDetail
	Public FBrandTag
	Public FSamebrand
	Public FIsusing
	Public FSamebrandID
	Public FSocname
	Public FSocname_kor
End Class

Class cHello
	Public FItemList()
	Public FOneItem
	Public FTotalCount
	Public FPageSize
	Public FCurrPage
	Public FResultCount
	Public FTotalPage
	Public FPageCount
	Public FScrollCount

	Public FRectMakerid
	Public FRectIsusing

	Public Sub sbHellolist()
		Dim sqlStr, i, sqladd
		sqlStr = "exec db_brand.dbo.sp_Ten_street_Hello '"&FRectMakerid&"' "
        rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
		rsget.Open sqlStr,dbget,1

		FTotalCount = rsget.RecordCount
		FResultCount = rsget.RecordCount
		Redim preserve FItemList(FResultCount)
		i = 0
		If not rsget.EOF then
			Do until rsget.EOF
				Set FOneItem = new cHello_item
					FOneItem.FMakerid				= rsget("makerid")
					FOneItem.FBrandgubun			= rsget("brandgubun")
					FOneItem.FSubtopimage			= rsget("subtopimage")
					FOneItem.FCatecode				= rsget("catecode")
					FOneItem.FBgImageURL			= rsget("bgImageURL")
					FOneItem.FStoryTitle			= db2html(rsget("StoryTitle"))
					FOneItem.FStoryContent			= db2html(rsget("StoryContent"))
					FOneItem.FPhilosophyTitle		= db2html(rsget("philosophyTitle"))
					FOneItem.FPhilosophyContent		= db2html(rsget("philosophyContent"))
					FOneItem.FDesignis				= db2html(rsget("designis"))
					FOneItem.FBookmark1SiteName		= db2html(rsget("bookmark1SiteName"))
					FOneItem.FBookmark1SiteURL		= db2html(rsget("bookmark1SiteURL"))
					FOneItem.FBookmark1SiteDetail	= db2html(rsget("bookmark1SiteDetail"))
					FOneItem.FBookmark2SiteName		= db2html(rsget("bookmark2SiteName"))
					FOneItem.FBookmark2SiteURL		= db2html(rsget("bookmark2SiteURL"))
					FOneItem.FBookmark2SiteDetail	= db2html(rsget("bookmark2SiteDetail"))
					FOneItem.FBookmark3SiteName		= db2html(rsget("bookmark3SiteName"))
					FOneItem.FBookmark3SiteURL		= db2html(rsget("bookmark3SiteURL"))
					FOneItem.FBookmark3SiteDetail	= db2html(rsget("bookmark3SiteDetail"))
					FOneItem.FBrandTag				= rsget("brandTag")
					FOneItem.FSamebrand				= rsget("samebrand")
				i = i + 1
				rsget.moveNext
			Loop
		End If
		rsget.Close
	End Sub

	Public Function fnHelloSameBrandlist()
		Dim sqlStr
		sqlStr = "exec db_brand.dbo.sp_Ten_street_HelloSameBrandList '"&FRectMakerid&"' "
        rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
		rsget.Open sqlStr,dbget,1
		IF Not (rsget.EOF OR rsget.BOF) THEN
			fnHelloSameBrandlist = rsget.GetRows()
		END IF
		rsget.close
	End Function

End Class

Class CStreetItem
	public FMakerid
	public Fsocname
	public Fsocname_kor
	public FStandardCateCode
	public Fsoclogo
	public Fdgncomment
	public fidx
	public ftype
	public fregdate
	public fisusing
	public fsellyn
	public flimityn
	public flimitno
	public flimitsold
	public fdanjongyn
	public fsellcash
	public fbuycash
	public Fdiv
	public Fhitflg
	public Fnewflg
	public Fsaleflg
	public Fonlyflg
	public Fartistflg
	public Fkdesignflg
	public Fsamebrand
	public Ftitleimgurl
	public FRecommendcount
	public FTodayRecommendcount
	public FTopbrandcount
	public FRecentTopbrandyn
	public FevtCode
	public FevtName
	public FItemId
	public FItemName
	public FEvalcnt
	public Ficon1Image
	public Ficon2Image
	public FImageMain
	public FImageList
	public FImageSmall
	public FImageBasic
	public flistimage120
	public Fevt_kind
	public Fevt_enddate
	public Fevt_startdate
	public FCDLarge
	public FCDMid
	public FCDSmall
	public FCateName
	public FDFidx
	public FDFName
	public Fevt_bannerimg
	public Fevt_bannerimg2010
	public Fevt_newest
	public Fevt_bannerlink
	public FSaleYn
	public FOrgPrice
	public FSpecialUserItem
	public FItemCouponYN
	public Fitemcoupontype
	public Fitemcouponvalue
	public FmaxSaleValue
	public FminSaleValue

	
	'//베스트브랜드
	public function IsHitBrand()
		IsHitBrand = (Fhitflg="Y")
	end function

	'//뉴브랜드
	public function IsNewBrand()
		IsNewBrand = (Fnewflg="Y")
	end function

	'//찜브랜드
	public function IsZimBrand()
		IsZimBrand = (FRecommendcount>=1000) or (FTodayRecommendcount>=5)
	end function

	'//아티스트브랜드
	public function IsArtistBrand()
		IsArtistBrand = (Fartistflg="Y")
	end function

	'//온리브랜드
	public function IsOnlyBrand()
		IsOnlyBrand = (Fonlyflg="Y")
	end function

	'//케이디자인브랜드
	public function IsKdesignBrand()
		IsKdesignBrand = (Fkdesignflg="Y")
	end function

	Private Sub Class_Initialize()
	End Sub
	Private Sub Class_Terminate()
	End Sub
End Class

Class CStreet
	public FItemList()
	public FOneItem
	public FpageSize
	public FResultCount
	public FTotalCount
	public FCurrPage
	public FTotalPage
	public FScrollCount
	public FPageCount

	public FRectMakerid
	public FRectCDL
	public FRectLang
	public FRectKind
	public Frectchar1
	public Frectchar2
	public FrectchrCd
	public FBrandName

	Private Sub Class_Initialize()
		FCurrPage =1
		FPageSize = 50
		FResultCount = 0
		FScrollCount = 10
		FTotalCount =0
	End Sub
	Private Sub Class_Terminate()
	End Sub

	'// 브랜드 검색 결과 목록 // 한글 '//street/index.asp
	Public sub GetBrandStreetList_k()
		Dim sqlStr , i
		sqlStr = "exec [db_user].[dbo].[ten2013_BrandStreetList_K] '" & FBrandName & "', '" & Frectchar1 & "', '" & Frectchar2 & "', '" & FrectchrCd & "', '" & frectlang & "', '" & FRectCDL & "'"
        rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic       
		rsget.pagesize = FPageSize
		rsget.Open sqlStr,dbget,1
		FResultCount = rsget.RecordCount

		ftotalcount = rsget.recordcount
		redim preserve FItemList(ftotalcount)

		i=0
		if  not rsget.EOF  then
			do until rsget.EOF
				set FItemList(i) = new CStreetItem

				FItemList(i).Fdiv			= rsget("div")
				FItemList(i).Fmakerid		= rsget("userid")
				FItemList(i).Fsocname		= db2html(rsget("socname"))
				FItemList(i).Fsocname_kor	= db2html(rsget("socname_kor"))
				rsget.movenext
				i=i+1
			loop
		end if
		rsget.Close
	end sub

	public sub GetBrandStreetList_E()
		dim sqlStr , i

		sqlStr = "exec [db_user].[dbo].[ten2013_BrandStreetList_E] '" & FBrandName & "', '" & Frectchar1 & "', '" & Frectchar2 & "', '" & FrectchrCd & "', '" & frectlang & "', '" & FRectCDL & "'"
        rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic       
		rsget.pagesize = FPageSize
		rsget.Open sqlStr,dbget,1
		FResultCount = rsget.RecordCount

		ftotalcount = rsget.recordcount
		redim preserve FItemList(ftotalcount)

		i=0
		if  not rsget.EOF  then
			do until rsget.EOF
				set FItemList(i) = new CStreetItem

				FItemList(i).Fdiv			= rsget("div")
				FItemList(i).Fmakerid		= rsget("userid")
				FItemList(i).Fsocname		= db2html(rsget("socname"))
				FItemList(i).Fsocname_kor	= db2html(rsget("socname_kor"))
				rsget.movenext
				i=i+1
			loop
		end if
		rsget.Close
	end sub

	Public sub BrandSearchBestBrandTop5()
		Dim sqlStr, i
		sqlStr = "exec db_brand.[dbo].[sp_Ten_BrandSearchBestBrandTop5] '"&FRectCDL&"' " 
        rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic       
		rsget.pagesize = FPageSize
		rsget.Open sqlStr,dbget,1
		FResultCount = rsget.RecordCount
		ftotalcount = rsget.recordcount
		redim preserve FItemList(ftotalcount)

		i=0
		if  not rsget.EOF  then
			do until rsget.EOF
				set FItemList(i) = new CStreetItem
					FItemList(i).Fmakerid			= rsget("userid")
					FItemList(i).Fsocname			= db2html(rsget("socname"))
					FItemList(i).Fsocname_kor		= db2html(rsget("socname_kor"))
					FItemList(i).FStandardCateCode	= rsget("standardCateCode")
				rsget.movenext
				i=i+1
			loop
		end if
		rsget.Close
	End sub
End Class

'/아티스트 갤러리 총 갯수
function GetGallery_totalcnt(imakerid, iGal_div, igal_isusing)
	dim SqlStr
	if imakerid="" then
		GetGallery_totalcnt = 0
		exit function
	end if

	sqlStr = "exec db_contents.[dbo].[ten_artist_totalcnt] '"&imakerid&"','"&iGal_div&"','"&igal_isusing&"'"

	'Response.write sqlStr &"<br>"
    rsget.CursorLocation = adUseClient
	rsget.CursorType = adOpenStatic
	rsget.LockType = adLockOptimistic
	rsget.Open sqlStr,dbget,1

	if not rsget.EOF then
        GetGallery_totalcnt = rsget("artist_totalcnt")
	else
		GetGallery_totalcnt = 0
	end if

	rsget.close
End function

'/인터뷰 총 갯수
function Getinterview_totalcnt(imakerid)
	dim SqlStr
	if imakerid="" then
		Getinterview_totalcnt = 0
		exit function
	end if
	sqlStr = "exec db_brand.[dbo].sp_Ten_street_interview_totalcnt '"&imakerid&"'"

	'Response.write sqlStr &"<br>"
    rsget.CursorLocation = adUseClient
	rsget.CursorType = adOpenStatic
	rsget.LockType = adLockOptimistic
	rsget.Open sqlStr,dbget,1

	if not rsget.EOF then
        Getinterview_totalcnt = rsget("interview_totalcnt")
	else
		Getinterview_totalcnt = 0
	end if

	rsget.close
End function

'/tenbytenand 총 갯수
function Gettenbytenand_totalcnt(imakerid)
	dim SqlStr
	if imakerid="" then
		Gettenbytenand_totalcnt = 0
		exit function
	end if
	sqlStr = "exec db_brand.[dbo].sp_Ten_street_tenbytenand_totalcnt '"&imakerid&"'"

	'Response.write sqlStr &"<br>"
    rsget.CursorLocation = adUseClient
	rsget.CursorType = adOpenStatic
	rsget.LockType = adLockOptimistic
	rsget.Open sqlStr,dbget,1

	if not rsget.EOF then
        Gettenbytenand_totalcnt = rsget("tenbytenand_totalcnt")
	else
		Gettenbytenand_totalcnt = 0
	end if

	rsget.close
End function

'/shop_collection 총 갯수
function Getshop_collection_totalcnt(imakerid)
	dim SqlStr
	if imakerid="" then
		Getshop_collection_totalcnt = 0
		exit function
	end if
	sqlStr = "exec db_brand.dbo.[sp_Ten_street_shop_collection_totalcnt] '"&imakerid&"'"

	'Response.write sqlStr &"<br>"
    rsget.CursorLocation = adUseClient
	rsget.CursorType = adOpenStatic
	rsget.LockType = adLockOptimistic
	rsget.Open sqlStr,dbget,1

	if not rsget.EOF then
        Getshop_collection_totalcnt = rsget("shop_collection_totalcnt")
	else
		Getshop_collection_totalcnt = 0
	end if

	rsget.close
End function

'/shop_event 총 갯수
function Getshop_event_totalcnt(imakerid, ievt_kind)
	dim SqlStr
	if imakerid="" then
		Getshop_event_totalcnt = 0
		exit function
	end if
	sqlStr = "exec db_brand.dbo.[sp_Ten_street_shop_event_totalcnt] '"&imakerid&"', '"&ievt_kind&"'"

	'Response.write sqlStr &"<br>"
    rsget.CursorLocation = adUseClient
	rsget.CursorType = adOpenStatic
	rsget.LockType = adLockOptimistic
	rsget.Open sqlStr,dbget,1

	if not rsget.EOF then
        Getshop_event_totalcnt = rsget("shop_event_totalcnt")
	else
		Getshop_event_totalcnt = 0
	end if

	rsget.close
End function

'/shop_event 진행중인것 탑1
function Getshop_event_one(imakerid, ievt_kind)
	dim SqlStr, tmpGetshop_event_one
	if imakerid="" then
		Getshop_event_one = ""
		exit function
	end if
	sqlStr = "exec db_brand.[dbo].sp_Ten_street_shop_event_one '"&imakerid&"', '"&ievt_kind&"'"

	'Response.write sqlStr &"<br>"
    rsget.CursorLocation = adUseClient
	rsget.CursorType = adOpenStatic
	rsget.LockType = adLockOptimistic
	rsget.Open sqlStr,dbget,1

	if not rsget.EOF then
        tmpGetshop_event_one = db2html(rsget("evt_name"))
	else
		tmpGetshop_event_one = ""
	end if

	rsget.close
	
	if tmpGetshop_event_one <> "" then
		tmpGetshop_event_one = split(tmpGetshop_event_one,"|")(0)
	end if

	Getshop_event_one = tmpGetshop_event_one
End function

'/lookbook 총 갯수
function Getlookbook_totalcnt(imakerid)
	dim SqlStr
	if imakerid="" then
		Getlookbook_totalcnt = 0
		exit function
	end if
	sqlStr = "exec db_brand.[dbo].sp_Ten_street_lookbook_totalcnt '"&imakerid&"'"

	'Response.write sqlStr &"<br>"
    rsget.CursorLocation = adUseClient
	rsget.CursorType = adOpenStatic
	rsget.LockType = adLockOptimistic
	rsget.Open sqlStr,dbget,1

	if not rsget.EOF then
        Getlookbook_totalcnt = rsget("LookBook_totalcnt")
	else
		Getlookbook_totalcnt = 0
	end if

	rsget.close
End function

'/hello 총 갯수
function Gethello_totalcnt(imakerid)
	dim SqlStr
	if imakerid="" then
		Gethello_totalcnt = 0
		exit function
	end if
	sqlStr = "exec db_brand.[dbo].sp_Ten_street_hello_totalcnt '"&imakerid&"'"

	'Response.write sqlStr &"<br>"
    rsget.CursorLocation = adUseClient
	rsget.CursorType = adOpenStatic
	rsget.LockType = adLockOptimistic
	rsget.Open sqlStr,dbget,1

	if not rsget.EOF then
        Gethello_totalcnt = rsget("hello_totalcnt")
	else
		Gethello_totalcnt = 0
	end if

	rsget.close
End function

'//나의 찜 브랜드 보기
Function SelectMyzzimBrand(boxname, selectOpt)
	Dim sqlStr, tem_str
	If getloginuserid() <> "" Then
		response.write "<select id='ss' name='" & boxname & "' onchange='GoMyBrand(this.value);' "&selectOpt&" >"
		response.write "<option value='' selected>--나의 찜브랜드 리스트--</option>"

		sqlStr = "exec db_brand.dbo.sp_Ten_SelectMyzzimBrand '" & getloginuserid() & "' "
		rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
		rsget.Open sqlStr,dbget,1
		If not rsget.EOF then
			Do until rsget.EOF
				response.write "<option value='" & rsget("makerid") & "' " & tem_str & ">" & db2html(rsget("socname_kor")) & "</option>"
				tem_str = ""
				rsget.movenext
			Loop
		End If
		rsget.close
		response.write "</select>"
	Else
		response.write "<select name='" & boxname & "' "&selectOpt&" >"
		response.write "<option>--나의 찜브랜드 리스트--</option>"
		response.write "<option>로그인이 필요합니다.</option>"
		response.write "<select/>"
		Exit Function
	End If
End Function

'/브랜드 총 찜한것 카운트
function GetZzim_totalcnt(imakerid)
	dim SqlStr
	if imakerid="" then
		GetZzim_totalcnt = 0
		exit function
	end if

	sqlStr = "exec db_brand.[dbo].[sp_Ten_street_ZZimCnt] '"&imakerid&"'"
	'Response.write sqlStr &"<br>"
    rsget.CursorLocation = adUseClient
	rsget.CursorType = adOpenStatic
	rsget.LockType = adLockOptimistic
	rsget.Open sqlStr,dbget,1

	If not rsget.EOF Then
        GetZzim_totalcnt = rsget("cnt")
	Else
		GetZzim_totalcnt = 0
	End If
	rsget.close
End function

'// 스트리트 브랜드명 검색어 반환
function convertChar(lang, chrCd, byref chr1 , byref chr2)
	select case lang

		'//한글
		case "K"
			select case chrCd
				Case "가": chr1="ㄱ": chr2="ㄴ"
				Case "나": chr1="ㄴ": chr2="ㄷ"
				Case "다": chr1="ㄷ": chr2="ㄹ"
				Case "라": chr1="ㄹ": chr2="ㅁ"
				Case "마": chr1="ㅁ": chr2="ㅂ"
				Case "바": chr1="ㅂ": chr2="ㅅ"
				Case "사": chr1="ㅅ": chr2="ㅇ"
				Case "아": chr1="ㅇ": chr2="ㅈ"
				Case "자": chr1="ㅈ": chr2="ㅊ"
				Case "차": chr1="ㅊ": chr2="ㅋ"
				Case "카": chr1="ㅋ": chr2="ㅌ"
				Case "타": chr1="ㅌ": chr2="ㅍ"
				Case "파": chr1="ㅍ": chr2="ㅎ"
				Case "하": chr1="ㅎ": chr2="힣"
				Case "Ω": chr1="": chr2=""
			end select

		'//영어
		case "E"
			select case chrCd
				Case "A": chr1="A": chr2="A"
				Case "B": chr1="B": chr2="B"
				Case "C": chr1="C": chr2="C"
				Case "D": chr1="D": chr2="D"
				Case "E": chr1="E": chr2="E"
				Case "F": chr1="F": chr2="F"
				Case "G": chr1="G": chr2="G"
				Case "H": chr1="H": chr2="H"
				Case "I": chr1="I": chr2="I"
				Case "J": chr1="J": chr2="J"
				Case "K": chr1="K": chr2="K"
				Case "L": chr1="L": chr2="L"
				Case "M": chr1="M": chr2="M"
				Case "N": chr1="N": chr2="N"
				Case "O": chr1="O": chr2="O"
				Case "P": chr1="P": chr2="P"
				Case "Q": chr1="Q": chr2="Q"
				Case "R": chr1="R": chr2="R"
				Case "S": chr1="S": chr2="S"
				Case "T": chr1="T": chr2="T"
				Case "U": chr1="U": chr2="U"
				Case "V": chr1="V": chr2="V"
				Case "W": chr1="W": chr2="W"
				Case "X": chr1="X": chr2="X"
				Case "Y": chr1="Y": chr2="Y"
				Case "Z": chr1="Z": chr2="Z"
				Case "Σ": chr1="": chr2=""
			end select
	end select
end function

'// 이니셜을 일련번호로 변환
function getInitial2Num(chIni)
	dim strCharacter, retNo

	'한글에서 검사
	strCharacter = "가나다라마바사아자차카타파하Ω"
	retNo = instr(strCharacter,chIni)

	if retNo=0 then
		'한글에서 없으면 영문에서 검사
		strCharacter = "ABCDEFGHIJKLMNOPQRSTUVWXYZΣ"
		retNo = instr(strCharacter,chIni)
	end if

	getInitial2Num = retNo
end function
%>