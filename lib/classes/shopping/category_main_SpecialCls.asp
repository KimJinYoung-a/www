<%
Class CSpecial
	public FItemList()
	public FCommentList()

	public FResultCount
	public FPageSize
	public FCurrpage
	public FTotalCount
	public FTotalPage
	public FScrollCount
	
	public FTitle
	public FSubcopy
	public FImgurl
	public FLinkurl


	public FTableName
	public FRectCD1
	public FRectCD2
	public FRectSort
	public FRectMode
	public FRectArrItemid
	public FRegdateS
	public FRegdateE
	public FRectCateCode
	public FRectPage
	public FRectStartDate
	public FRectGubun
	public FStartDateReal

	Private Sub Class_Initialize()
		redim preserve FItemList(0)
		redim preserve FCommentList(0)

		FTableName        = "[db_board].[dbo].tbl_user_goodusing"
	End Sub

	Private Sub Class_Terminate()

	End Sub

	public function GetImageFolerName(byval i)
		'GetImageFolerName = "0" + CStr(Clng(FItemList(i).FItemID\10000))
		GetImageFolerName = GetImageSubFolderByItemid(FItemList(i).FItemID)
	end function


	
	'// left 카테고리메뉴 베스트브랜드 리스트 <!-- //--> //
	public Function GetCateMainBrandList()
		dim strSQL, i

		strSQL = "EXEC [db_const].[dbo].[sp_Ten_BestBrandTop3_ByDispcate] '" & FRectCateCode & "'"
		rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenForwardOnly
		rsget.LockType = adLockReadOnly
		rsget.Open strSQL, dbget

		if  not rsget.EOF  then
			GetCateMainBrandList = rsget.getRows()
		end if
		rsget.close
	end Function
	
	
	'// 카테고리메인 오늘날짜와비교해 보여야할 startdate, 해당일의 총 페이지수 <!-- //--> //
    public Sub GetCateMainDetail()
		dim strSQL, i

		strSQL = "EXEC [db_sitemaster].[dbo].[sp_Ten_Display_CateMain] '" & FRectCateCode & "', '" & FRectStartDate & "'"
		rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenForwardOnly
		rsget.LockType = adLockReadOnly
		rsget.Open strSQL, dbget

		i = 0
		if not rsget.EOF then
			Do until rsget.eof
				If CStr(FRectPage) = CStr(rsget("page")) Then
					FStartDateReal	= rsget("startdate")
				End If
				i = i + 1
			rsget.MoveNext
			Loop
		end if
		FTotalPage = i
		rsget.close

    End Sub
    
	
	'// 카테고리메인 보여야할 startdate 상세 내용 가져오기 <!-- //--> //
	public sub GetCateMainDetailList()
		dim strSQL, i, vMultiImg1, vMultiLink1, vMultiImg2, vMultiLink2, vMultiImg3, vMultiLink3, vBookImg, vBookLink, vRecipeImg, vRecipeLink, vRecipeTitle, vRecipeSubcopy

		'### 1 페이지가 아닐때 페이지 고정(multi1,2,3 book+ recipe) 가져오기.
		If FRectPage <> "1" Then
			strSQL = "EXEC [db_sitemaster].[dbo].[sp_Ten_Display_CateMain_Detail] '" & FRectGubun & "', '" & FRectCateCode & "', '1', '" & FRectStartDate & "'"
			rsget.CursorLocation = adUseClient
			rsget.CursorType = adOpenForwardOnly
			rsget.LockType = adLockReadOnly
			rsget.Open strSQL, dbget

			if  not rsget.EOF  then
				Do until rsget.EOF
					If rsget("type") = "multiimg1" Then
						vMultiImg1	= rsget("imgurl")
						vMultiLink1	= rsget("linkurl")
					End If
					If rsget("type") = "multiimg2" Then
						vMultiImg2	= rsget("imgurl")
						vMultiLink2	= rsget("linkurl")
					End If
					If rsget("type") = "multiimg3" Then
						vMultiImg3	= rsget("imgurl")
						vMultiLink3	= rsget("linkurl")
					End If
					If rsget("type") = "book" Then
						vBookImg	= rsget("imgurl")
						vBookLink	= rsget("linkurl")
					End If
					If rsget("type") = "recipe" Then
						vRecipeImg	= rsget("imgurl")
						vRecipeLink	= rsget("linkurl")
						vRecipeTitle = db2html(rsget("title"))
						vRecipeSubcopy = db2html(rsget("subcopy"))
					End If

					rsget.moveNext
				Loop
			end if
			rsget.close
		End If

		strSQL = "EXEC [db_sitemaster].[dbo].[sp_Ten_Display_CateMain_Detail] '" & FRectGubun & "', '" & FRectCateCode & "', '" & FRectPage & "', '" & FRectStartDate & "'"
		rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenForwardOnly
		rsget.LockType = adLockReadOnly
		rsget.Open strSQL, dbget

		FResultCount = rsget.RecordCount
		Redim preserve FItemList(FResultCount)
		i = 0
		if  not rsget.EOF  then
			Do until rsget.EOF
				Set FItemList(i) = new CCategoryPrdItem
				FItemList(i).Ftype = rsget("type")
				FItemList(i).Fcode = rsget("code")
				FItemList(i).Ftitle = db2html(rsget("title"))
				FItemList(i).Fsubcopy = db2html(rsget("subcopy"))

				If FRectPage = "1" Then
					FItemList(i).Fimgurl = rsget("imgurl")
					FItemList(i).Flinkurl = rsget("linkurl")
				Else
					FItemList(i).Fimgurl = rsget("imgurl")
					FItemList(i).Flinkurl = rsget("linkurl")
					
					If rsget("type") = "multiimg1" Then
						FItemList(i).Fimgurl	= vMultiImg1
						FItemList(i).Flinkurl	= vMultiLink1
					End If
					If rsget("type") = "multiimg2" Then
						FItemList(i).Fimgurl	= vMultiImg2
						FItemList(i).Flinkurl	= vMultiLink2
					End If
					If rsget("type") = "multiimg3" Then
						FItemList(i).Fimgurl	= vMultiImg3
						FItemList(i).Flinkurl	= vMultiLink3
					End If
					If rsget("type") = "book" Then
						FItemList(i).Fimgurl	= vBookImg
						FItemList(i).Flinkurl	= vBookLink
					End If
					If rsget("type") = "recipe" Then
						FItemList(i).Fimgurl	= vRecipeImg
						FItemList(i).Flinkurl	= vRecipeLink
						FItemList(i).Ftitle 	= vRecipeTitle
						FItemList(i).Fsubcopy 	= vRecipeSubcopy
					End If
				End If
				
				FItemList(i).Ficon = rsget("icon")
				FItemList(i).FItemid = rsget("code")
				FItemList(i).FItemName = db2html(rsget("itemname"))
				FItemList(i).FSellCash = rsget("sellcash")
				FItemList(i).FOrgPrice = rsget("orgprice")
				FItemList(i).FSellyn = rsget("sellyn")
				FItemList(i).FSaleyn = rsget("sailyn")
				FItemList(i).FLimityn = rsget("limityn")
				FItemList(i).FItemcouponyn = rsget("itemcouponyn")
				FItemList(i).FItemCouponValue = rsget("itemCouponValue")
				FItemList(i).FItemCouponType = rsget("itemCouponType")
					
				i = i + 1
				rsget.moveNext
			Loop
		end if
		rsget.close
	end sub
	
	
	'// 카테고리메인 이슈 <!-- //--> //
    public Sub GetCateMainIssue()
		dim strSQL, i

		strSQL = "EXEC [db_sitemaster].[dbo].[sp_Ten_Display_CateMain_Issue] '" & FRectCateCode & "'"
		rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenForwardOnly
		rsget.LockType = adLockReadOnly
		rsget.Open strSQL, dbget

		if not rsget.EOF then
			FTitle		= db2html(rsget("title"))
			FSubcopy	= db2html(rsget("subcopy"))
			FImgurl		= rsget("imgurl")
			FLinkurl	= rsget("linkurl")
		end if
		rsget.close

    End Sub
    
	'// 베스트 리뷰 목록(페이지用) 접수 //
	public Sub GetBestReviewAllList()
		dim sql, addSQL, i
        dim iMaxPage
        
		If GetLoginUserID = "violetiris" AND GetLoginUserLevel() = "7" Then
			iMaxPage = 10000
		Else
        	iMaxPage = 30
        End If

		'추가 조건
		addSQL = " and e.isUsing = 'Y' "

		if FRegdateS <> "" OR FRegdateE <> "" then
			addSQL = addSQL & " and e.regdate Between '" & FRegdateS & "' AND '" & FRegdateE & "' " + vbcrlf
		end if

		if FRectCateCode <> "" then
			addSQL = addSQL & " and i.dispcate1='" & FRectCateCode & "' " + vbcrlf
		end if

		if FRectMode="item" then
			addSQL = addSQL & " and e.File1 is Null " + vbcrlf
		elseif FRectMode="photo" then
			addSQL = addSQL & " and e.File1 is Not Null " + vbcrlf
			addSQL = addSQL & " and ee.itemid is Null " + vbcrlf
		end if

		'// 개수 파악 //
		sql =	"Select count(e.idx), CEILING(CAST(Count(e.idx) AS FLOAT)/" & FPageSize & ") "
		sql = sql & " From db_board.[dbo].tbl_item_evaluate e "
		sql = sql & " JOIN  [db_item].[dbo].tbl_item i  " + vbcrlf
		sql = sql & " 	on e.itemid = i.itemid " + vbcrlf
		sql = sql & " JOIN  [db_item].[dbo].tbl_item_contents j  " + vbcrlf
		sql = sql & " 	on j.itemid = i.itemid " + vbcrlf
		sql = sql + " left join db_board.dbo.tbl_Item_Evaluate_exclude ee"
		sql = sql + " 	on e.itemid=ee.itemid"
		sql = sql & " WHERE i.sellyn='Y'  " & addSQL + vbcrlf

		rsget.Open SQL,dbget,1
			FTotalCount = rsget(0)
			FtotalPage = rsget(1)
		rsget.Close

		''끝페이지 갈경우 (Top N) Too Long Long Time  - Page 수 제한
		if (FtotalPage>iMaxPage) then 
			FtotalPage=iMaxPage
			FTotalCount =FtotalPage*FPageSize
		end if
        if (CLNG(FCurrPage)>FtotalPage) and FtotalPage>0 then FCurrPage=FtotalPage

		'// 목록 접수 //
		sql = " SELECT TOP " + CStr(FPageSize*FCurrPage) + " e.idx, e.userid, e.regdate as write_regdate, e.itemid " + vbcrlf
		sql = sql & " , e.contents, (Case When isNull(i.frontMakerid,'')='' then i.makerid else i.frontMakerid end) as makerid, i.brandname, e.TotalPoint as Tpoint " + vbcrlf
		sql = sql + " , isnull(e.Point_function,0) as Point_function "
		sql = sql + " , isnull(e.Point_Design,0) as Point_Design "
		sql = sql + " , isnull(e.Point_Price,0) as Point_Price "
		sql = sql + " , isnull(e.Point_satisfy,0) as Point_satisfy "		
		sql = sql & " , i.itemname, i.sellyn, i.sellcash, i.orgprice, i.sailyn, i.itemcouponyn, i.itemcoupontype, i.itemcouponvalue " + vbcrlf
		sql = sql & " , i.listimage120, i.evalcnt, i.itemscore, e.File1, e.File2, i.icon2image, i.regdate, i.icon1image, j.favcount  " + vbcrlf
		sql = sql & " , (case when isnull(ee.itemid,'') <> '' then 'Y' else 'N' end) as Eval_excludeyn"
		sql = sql & " FROM db_board.[dbo].tbl_item_evaluate e " + vbcrlf
		sql = sql & " JOIN  [db_item].[dbo].tbl_item i  " + vbcrlf
		sql = sql & " 	on e.itemid = i.itemid " + vbcrlf
		sql = sql & " JOIN  [db_item].[dbo].tbl_item_contents j  " + vbcrlf
		sql = sql & " 	on j.itemid = i.itemid " + vbcrlf
		sql = sql + " left join db_board.dbo.tbl_Item_Evaluate_exclude ee"
		sql = sql + " 	on e.itemid=ee.itemid"		
		sql = sql & " WHERE i.sellyn = 'Y'  " & addSQL + vbcrlf

		Select Case FRectSort
			Case "new"
				'최근등록순
				sql = sql & " ORDER BY e.IDX DESC  " + vbcrlf
			Case "pnt"
				'상품평점수순
				sql = sql & " ORDER BY e.TotalPoint DESC, e.IDX DESC  " + vbcrlf
			Case "bst"
				'인기상품 순
				sql = sql & " ORDER BY i.itemscore DESC  " + vbcrlf
			Case "cnt"
				'상품평개수
				sql = sql & " ORDER BY i.evalcnt DESC, e.IDX DESC  " + vbcrlf
		End Select

		rsget.pagesize = FPageSize
		rsget.Open SQL,dbget,1
		

		FResultCount = rsget.RecordCount-(FPageSize*(FCurrPage-1))

		if FResultCount<1 then FResultCount=0

		redim preserve FItemList(FResultCount)

		if  not rsget.EOF  then
			rsget.absolutePage=FCurrPage
			i = 0
			Do Until rsget.EOF or rsget.BOF
				set FItemList(i) = new CCategoryPrdItem

				FItemList(i).fEval_excludeyn 			= rsget("Eval_excludeyn")
				FItemList(i).Fidx				= rsget("idx")
				FItemList(i).Fitemid			= rsget("itemid")
				FItemList(i).Fuserid			= rsget("userid")
				FItemList(i).Fregdate			= rsget("regdate")
				FItemList(i).Fitemname			= db2html(rsget("itemname"))
				FItemList(i).Fmakerid			= db2html(rsget("makerid"))
				FItemList(i).Fbrandname			= db2html(rsget("brandname"))
				FItemList(i).Fevalcnt			= rsget("evalcnt")
				FItemList(i).Fcontents			= db2html(rsget("contents"))
				FItemList(i).FOrgprice			= rsget("orgprice")
				FItemList(i).FSellYn			= rsget("sellyn")
				FItemList(i).FSaleYn			= rsget("sailyn")
				FItemList(i).FSellCash			= rsget("sellcash")
				FItemList(i).FPoints			= rsget("TPoint")
				FItemList(i).FPoint_fun			= rsget("Point_Function")
				FItemList(i).FPoint_dgn			= rsget("Point_Design")
				FItemList(i).FPoint_prc			= rsget("Point_Price")
				FItemList(i).FPoint_stf			= rsget("Point_Satisfy")				
				FItemList(i).Fitemcouponyn		= rsget("itemcouponyn")
				FItemList(i).Fitemcoupontype	= rsget("itemcoupontype")
				FItemList(i).FItemCouponValue	= rsget("itemcouponvalue")

				if Not(rsget("File1")="" or isNull(rsget("File1"))) then
					FItemList(i).FImageIcon1		= "http://imgstatic.10x10.co.kr/goodsimage/" + GetImageFolerName(i) + "/" + rsget("File1")
				end if
				if Not(rsget("File2")="" or isNull(rsget("File2"))) then
					FItemList(i).FImageIcon2		= "http://imgstatic.10x10.co.kr/goodsimage/" + GetImageFolerName(i) + "/" + rsget("File2")
				end if
				FItemList(i).FImageList120    = "http://webimage.10x10.co.kr/image/list120/" + GetImageFolerName(i) + "/" + rsget("listimage120")
				FItemList(i).FIcon1Image	  = "http://webimage.10x10.co.kr/image/icon1/" + GetImageFolerName(i) + "/" + rsget("icon1image")
				FItemList(i).FIcon2Image	  = "http://webimage.10x10.co.kr/image/icon2/" + GetImageFolerName(i) + "/" + rsget("icon2image")
				FItemList(i).FEvalcnt		  = rsget("evalcnt")
				FItemList(i).FBRWriteRegdate  = rsget("write_regdate")
				FItemList(i).FfavCount		= rsget("favcount")

				rsget.moveNext
				i = i + 1
			Loop
		end if
		rsget.close
	end sub
	
	
	'// 테스터 리뷰 목록(페이지用) 접수 //
	public Sub GetTesterReviewAllList()
		dim sql, addSQL, i
        dim iMaxPage
        
		If GetLoginUserID = "violetiris" AND GetLoginUserLevel() = "7" Then
			iMaxPage = 10000
		Else
        	iMaxPage = 30
        End If

		'추가 조건
		addSQL = " and e.isUsing = 'Y' "

		if FRegdateS <> "" OR FRegdateE <> "" then
			addSQL = addSQL & " and e.regdate Between '" & FRegdateS & "' AND '" & FRegdateE & "' " + vbcrlf
		end if

		if FRectCateCode <> "" then
			addSQL = addSQL & " and i.dispcate1='" & FRectCateCode & "' " + vbcrlf
		end if

		'// 개수 파악 //
		sql =	"Select count(e.idx), CEILING(CAST(Count(e.idx) AS FLOAT)/" & FPageSize & ") "
		sql = sql & "From [db_event].[dbo].tbl_tester_Item_Evaluate e "
		sql = sql & " JOIN  [db_item].[dbo].tbl_item i  " + vbcrlf
		sql = sql & " 	on e.itemid = i.itemid " + vbcrlf
		sql = sql & " JOIN  [db_item].[dbo].tbl_item_contents j  " + vbcrlf
		sql = sql & " 	on j.itemid = i.itemid " + vbcrlf
		sql = sql & " WHERE i.sellyn='Y'  " & addSQL + vbcrlf

		rsget.Open SQL,dbget,1
			FTotalCount = rsget(0)
			FtotalPage = rsget(1)
		rsget.Close

		''끝페이지 갈경우 (Top N) Too Long Long Time  - Page 수 제한
		if (FtotalPage>iMaxPage) then FtotalPage=iMaxPage
        if (CLNG(FCurrPage)>FtotalPage) and FtotalPage>0 then FCurrPage=FtotalPage


		'// 목록 접수 //
		sql = " SELECT TOP " + CStr(FPageSize*FCurrPage) + " e.idx, e.userid, e.regdate as write_regdate, e.itemid " + vbcrlf
		sql = sql & " , e.contents, (Case When isNull(i.frontMakerid,'')='' then i.makerid else i.frontMakerid end) as makerid, i.brandname, e.TotalPoint as Tpoint " + vbcrlf
		sql = sql & " , i.itemname, i.sellyn, i.sellcash, i.orgprice, i.sailyn, i.itemcouponyn, i.itemcoupontype, i.itemcouponvalue " + vbcrlf
		sql = sql & " , i.listimage120, i.evalcnt, i.itemscore, e.File1, e.File2, e.File3, e.File4, e.File5, e.UseGood, e.UseETC, i.icon1image, i.icon2image, i.evalcnt, i.regdate" + vbcrlf
		sql = sql & " , j.favcount  " + vbcrlf
		sql = sql & " FROM [db_event].[dbo].tbl_tester_Item_Evaluate e " + vbcrlf
		sql = sql & " JOIN  [db_item].[dbo].tbl_item i  " + vbcrlf
		sql = sql & " 	on e.itemid = i.itemid " + vbcrlf
		sql = sql & " JOIN  [db_item].[dbo].tbl_item_contents j  " + vbcrlf
		sql = sql & " 	on j.itemid = i.itemid " + vbcrlf
		sql = sql & " WHERE i.sellyn = 'Y'  " & addSQL + vbcrlf

		Select Case FRectSort
			Case "new"
				'최근등록순
				sql = sql & " ORDER BY e.IDX DESC  " + vbcrlf
		End Select

		rsget.pagesize = FPageSize
		rsget.Open SQL,dbget,1
		'response.write sql&"<br>"

		FResultCount = rsget.RecordCount-(FPageSize*(FCurrPage-1))

		if FResultCount<1 then FResultCount=0

		redim preserve FItemList(FResultCount)

		if  not rsget.EOF  then
			rsget.absolutePage=FCurrPage
			i = 0
			Do Until rsget.EOF or rsget.BOF
				set FItemList(i) = new CCategoryPrdItem

				FItemList(i).Fidx				= rsget("idx")
				FItemList(i).Fitemid			= rsget("itemid")
				FItemList(i).Fuserid			= rsget("userid")
				FItemList(i).Fregdate			= rsget("regdate")
				FItemList(i).Fitemname			= db2html(rsget("itemname"))
				FItemList(i).Fmakerid			= db2html(rsget("makerid"))
				FItemList(i).Fbrandname			= db2html(rsget("brandname"))
				FItemList(i).Fevalcnt			= rsget("evalcnt")
				FItemList(i).Fcontents			= db2html(rsget("contents"))
				FItemList(i).FOrgprice			= rsget("orgprice")
				FItemList(i).FSellYn			= rsget("sellyn")
				FItemList(i).FSaleYn			= rsget("sailyn")
				FItemList(i).FSellCash			= rsget("sellcash")
				FItemList(i).FPoints			= rsget("TPoint")
				FItemList(i).Fitemcouponyn		= rsget("itemcouponyn")
				FItemList(i).Fitemcoupontype	= rsget("itemcoupontype")
				FItemList(i).FItemCouponValue	= rsget("itemcouponvalue")

				if Not(rsget("File1")="" or isNull(rsget("File1"))) then
					FItemList(i).FImageIcon1		= "http://imgstatic.10x10.co.kr/testgoodsimage/" + GetImageFolerName(i) + "/" + rsget("File1")
				end if
				if Not(rsget("File2")="" or isNull(rsget("File2"))) then
					FItemList(i).FImageIcon2		= "http://imgstatic.10x10.co.kr/testgoodsimage/" + GetImageFolerName(i) + "/" + rsget("File2")
				end if
				if Not(rsget("File3")="" or isNull(rsget("File3"))) then
					FItemList(i).FImageIcon3		= "http://imgstatic.10x10.co.kr/testgoodsimage/" + GetImageFolerName(i) + "/" + rsget("File3")
				end if
				if Not(rsget("File4")="" or isNull(rsget("File4"))) then
					FItemList(i).FImageIcon4		= "http://imgstatic.10x10.co.kr/testgoodsimage/" + GetImageFolerName(i) + "/" + rsget("File4")
				end if
				if Not(rsget("File5")="" or isNull(rsget("File5"))) then
					FItemList(i).FImageIcon5		= "http://imgstatic.10x10.co.kr/testgoodsimage/" + GetImageFolerName(i) + "/" + rsget("File5")
				end if

				FItemList(i).FImageList120    = "http://webimage.10x10.co.kr/image/list120/" + GetImageFolerName(i) + "/" + rsget("listimage120")
				FItemList(i).FIcon1Image	  = "http://webimage.10x10.co.kr/image/icon1/" + GetImageFolerName(i) + "/" + rsget("icon1image")
				FItemList(i).FIcon2Image	  = "http://webimage.10x10.co.kr/image/icon2/" + GetImageFolerName(i) + "/" + rsget("icon2image")
				FItemList(i).FEvalcnt		  = rsget("evalcnt")
				FItemList(i).FBRWriteRegdate  = rsget("write_regdate")
				
				FItemList(i).FUseGood			= db2html(rsget("UseGood"))
				FItemList(i).FUseETC			= db2html(rsget("UseETC"))

				rsget.moveNext
				i = i + 1
			Loop
		end if
		rsget.close
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

end Class


Function fnGetEventIconName(icon)
	SELECT Case icon
		Case "tagReserv" : fnGetEventIconName = "예약판매"
		Case "tagRed" : fnGetEventIconName = "SALE"
		Case "tagGreen" : fnGetEventIconName = "쿠폰"
		Case "tagOneplus" : fnGetEventIconName = "1+1"
		Case "tagGift" : fnGetEventIconName = "GIFT"
		Case "tagOnly" : fnGetEventIconName = "ONLY"
		Case "tagFreeship" : fnGetEventIconName = "무료배송"
		Case "tagInvolve" : fnGetEventIconName = "참여"
		Case "tagNew" : fnGetEventIconName = "NEW"
	END SELECT
End Function
%>