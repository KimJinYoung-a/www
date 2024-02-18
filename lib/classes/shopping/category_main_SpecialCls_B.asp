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
		dim sqlStr, addSQL, i
        dim iMaxPage
        
		If GetLoginUserID = "violetiris" AND GetLoginUserLevel() = "7" Then
			iMaxPage = 1000
		Else
        	iMaxPage = 30
        End If
        
        sqlStr = "exec [db_board].[dbo].[sp_Ten_getRecentBestReviewCNT]'"&FRectCateCode&"','"&FRectMode&"','"&FRegdateS&"','"&FRegdateE&"'"

		'rsget.Open sqlStr, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
        ''캐시로 변경 2015/04/09
        dim rsMem : set rsMem = getDBCacheSQL(dbget,rsget,"BRVCC",sqlStr,60*20)
		if (rsMem is Nothing) then Exit Sub ''추가
		    
		IF Not (rsMem.EOF OR rsMem.BOF) THEN
		    FTotalCount = rsMem(0)
		END IF
		rsMem.close
		
		FtotalPage =  CInt(FTotalCount\FPageSize)
		if  (FTotalCount\FPageSize)<>(FTotalCount/FPageSize) then
			FtotalPage = FtotalPage +1
		end if

		''끝페이지 갈경우 (Top N) Too Long Long Time  - Page 수 제한
		if (FtotalPage>iMaxPage) then 
			FtotalPage=iMaxPage
			FTotalCount =FtotalPage*FPageSize
		end if
        if (CLNG(FCurrPage)>FtotalPage) and FtotalPage>0 then FCurrPage=FtotalPage

        IF (FTotalCount>0) then
            sqlStr = "exec [db_board].[dbo].[sp_Ten_getRecentBestReviewLIST] "&FPageSize&","&FCurrPage&",'"&FRectCateCode&"','"&FRectMode&"','"&FRegdateS&"','"&FRegdateE&"','"&FRectSort&"'"

            set rsMem = getDBCacheSQL(dbget,rsget,"BRVL",sqlStr,60*20)
			if (rsMem is Nothing) then Exit Sub ''추가
			    
			FResultCount = rsMem.RecordCount
			if FResultCount<1 then FResultCount=0
		    redim preserve FItemList(FResultCount)
		        
			IF Not (rsMem.EOF OR rsMem.BOF) THEN
			    i = 0
    			Do Until rsMem.EOF or rsMem.BOF
    				set FItemList(i) = new CCategoryPrdItem
    
    				FItemList(i).fEval_excludeyn 	= rsMem("Eval_excludeyn")
    				FItemList(i).Fidx				= rsMem("idx")
    				FItemList(i).Fitemid			= rsMem("itemid")
    				FItemList(i).Fuserid			= rsMem("userid")
    				FItemList(i).Fregdate			= rsMem("regdate")
    				FItemList(i).Fitemname			= db2html(rsMem("itemname"))
    				FItemList(i).Fmakerid			= db2html(rsMem("makerid"))
    				FItemList(i).Fbrandname			= db2html(rsMem("brandname"))
    				FItemList(i).Fevalcnt			= rsMem("evalcnt")
    				FItemList(i).Fcontents			= db2html(rsMem("contents"))
    				FItemList(i).FOrgprice			= rsMem("orgprice")
    				FItemList(i).FSellYn			= rsMem("sellyn")
    				FItemList(i).FSaleYn			= rsMem("sailyn")
    				FItemList(i).FSellCash			= rsMem("sellcash")
    				FItemList(i).FPoints			= rsMem("TPoint")
    				FItemList(i).FPoint_fun			= rsMem("Point_Function")
    				FItemList(i).FPoint_dgn			= rsMem("Point_Design")
    				FItemList(i).FPoint_prc			= rsMem("Point_Price")
    				FItemList(i).FPoint_stf			= rsMem("Point_Satisfy")				
    				FItemList(i).Fitemcouponyn		= rsMem("itemcouponyn")
    				FItemList(i).Fitemcoupontype	= rsMem("itemcoupontype")
    				FItemList(i).FItemCouponValue	= rsMem("itemcouponvalue")
    
    				if Not(rsMem("File1")="" or isNull(rsMem("File1"))) then
    					FItemList(i).FImageIcon1		= "http://imgstatic.10x10.co.kr/goodsimage/" + GetImageFolerName(i) + "/" + rsMem("File1")
    				end if
    				if Not(rsMem("File2")="" or isNull(rsMem("File2"))) then
    					FItemList(i).FImageIcon2		= "http://imgstatic.10x10.co.kr/goodsimage/" + GetImageFolerName(i) + "/" + rsMem("File2")
    				end if
    				FItemList(i).FImageBasic 		= "http://webimage.10x10.co.kr/image/basic/" + GetImageFolerName(i) + "/" + rsMem("basicimage")
    				FItemList(i).FImageList120    = "http://webimage.10x10.co.kr/image/list120/" + GetImageFolerName(i) + "/" + rsMem("listimage120")
    				FItemList(i).FIcon1Image	  = "http://webimage.10x10.co.kr/image/icon1/" + GetImageFolerName(i) + "/" + rsMem("icon1image")
    				FItemList(i).FIcon2Image	  = "http://webimage.10x10.co.kr/image/icon2/" + GetImageFolerName(i) + "/" + rsMem("icon2image")
    				FItemList(i).FEvalcnt		  = rsMem("evalcnt")
    				FItemList(i).FBRWriteRegdate  = rsMem("write_regdate")
    				FItemList(i).FfavCount		= rsMem("favcount")
    
    				rsMem.moveNext
    				i = i + 1
    			Loop
			END IF
			rsMem.close
			
        end if
		
	end sub
	
	
	'// 테스터 리뷰 목록(페이지用) 접수 //
	public Sub GetTesterReviewAllList()
		dim sqlStr, i
        dim iMaxPage
        
		If GetLoginUserID = "violetiris" AND GetLoginUserLevel() = "7" Then
			iMaxPage = 1000
		Else
        	iMaxPage = 30
        End If
        
        sqlStr = "[db_board].[dbo].[sp_Ten_getRecentTesterReviewCNT]('"&FRectCateCode&"','"&FRegdateS&"','"&FRegdateE&"')"

		'rsget.Open sqlStr, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
        ''캐시로 변경 2015/04/09
        dim rsMem : set rsMem = getDBCacheSQL(dbget,rsget,"BRVTC",sqlStr,60*20)
		if (rsMem is Nothing) then Exit Sub ''추가
		    
		IF Not (rsMem.EOF OR rsMem.BOF) THEN
		    FTotalCount = rsMem(0)
		END IF
		rsMem.close
		
		FtotalPage =  CInt(FTotalCount\FPageSize)
		if  (FTotalCount\FPageSize)<>(FTotalCount/FPageSize) then
			FtotalPage = FtotalPage +1
		end if
        
        if (CLNG(FCurrPage)>FtotalPage) and FtotalPage>0 then FCurrPage=FtotalPage

        IF (FTotalCount>0) then
            sqlStr = "[db_board].[dbo].[sp_Ten_getRecentTesterReviewLIST]("&FPageSize&","&FCurrPage&",'"&FRectCateCode&"','"&FRegdateS&"','"&FRegdateE&"','"&FRectSort&"')"

            set rsMem = getDBCacheSQL(dbget,rsget,"BRVTL",sqlStr,60*20)
			if (rsMem is Nothing) then Exit Sub ''추가
			    
			FResultCount = rsMem.RecordCount
			if FResultCount<1 then FResultCount=0
		    redim preserve FItemList(FResultCount)
		        
			IF Not (rsMem.EOF OR rsMem.BOF) THEN
    			i = 0
    			Do Until rsMem.EOF or rsMem.BOF
    				set FItemList(i) = new CCategoryPrdItem
    
    				FItemList(i).Fidx				= rsMem("idx")
    				FItemList(i).Fitemid			= rsMem("itemid")
    				FItemList(i).Fuserid			= rsMem("userid")
    				FItemList(i).Fregdate			= rsMem("regdate")
    				FItemList(i).Fitemname			= db2html(rsMem("itemname"))
    				FItemList(i).Fmakerid			= db2html(rsMem("makerid"))
    				FItemList(i).Fbrandname			= db2html(rsMem("brandname"))
    				FItemList(i).Fevalcnt			= rsMem("evalcnt")
    				FItemList(i).Fcontents			= db2html(rsMem("contents"))
    				FItemList(i).FOrgprice			= rsMem("orgprice")
    				FItemList(i).FSellYn			= rsMem("sellyn")
    				FItemList(i).FSaleYn			= rsMem("sailyn")
    				FItemList(i).FSellCash			= rsMem("sellcash")
    				FItemList(i).FPoints			= rsMem("TPoint")
    				FItemList(i).Fitemcouponyn		= rsMem("itemcouponyn")
    				FItemList(i).Fitemcoupontype	= rsMem("itemcoupontype")
    				FItemList(i).FItemCouponValue	= rsMem("itemcouponvalue")
    
    				if Not(rsMem("File1")="" or isNull(rsMem("File1"))) then
    					FItemList(i).FImageIcon1		= "http://imgstatic.10x10.co.kr/testgoodsimage/" + GetImageFolerName(i) + "/" + rsMem("File1")
    				end if
    				if Not(rsMem("File2")="" or isNull(rsMem("File2"))) then
    					FItemList(i).FImageIcon2		= "http://imgstatic.10x10.co.kr/testgoodsimage/" + GetImageFolerName(i) + "/" + rsMem("File2")
    				end if
    				if Not(rsMem("File3")="" or isNull(rsMem("File3"))) then
    					FItemList(i).FImageIcon3		= "http://imgstatic.10x10.co.kr/testgoodsimage/" + GetImageFolerName(i) + "/" + rsMem("File3")
    				end if
    				if Not(rsMem("File4")="" or isNull(rsMem("File4"))) then
    					FItemList(i).FImageIcon4		= "http://imgstatic.10x10.co.kr/testgoodsimage/" + GetImageFolerName(i) + "/" + rsMem("File4")
    				end if
    				if Not(rsMem("File5")="" or isNull(rsMem("File5"))) then
    					FItemList(i).FImageIcon5		= "http://imgstatic.10x10.co.kr/testgoodsimage/" + GetImageFolerName(i) + "/" + rsMem("File5")
    				end if
    
    				FItemList(i).FImageList120    = "http://webimage.10x10.co.kr/image/list120/" + GetImageFolerName(i) + "/" + rsMem("listimage120")
    				FItemList(i).FIcon1Image	  = "http://webimage.10x10.co.kr/image/icon1/" + GetImageFolerName(i) + "/" + rsMem("icon1image")
    				FItemList(i).FIcon2Image	  = "http://webimage.10x10.co.kr/image/icon2/" + GetImageFolerName(i) + "/" + rsMem("icon2image")
    				FItemList(i).FEvalcnt		  = rsMem("evalcnt")
    				FItemList(i).FBRWriteRegdate  = rsMem("write_regdate")
    				
    				FItemList(i).FUseGood			= db2html(rsMem("UseGood"))
    				FItemList(i).FUseETC			= db2html(rsMem("UseETC"))
    
    				rsMem.moveNext
    				i = i + 1
    			Loop
    		END IF
			rsMem.close
        end if
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