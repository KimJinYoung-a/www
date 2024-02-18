<%
	'// gift 키워드 항목 출력 (클릭함수,선택값)
	Function getGiftKeyword(vClk,arrChk)
		Dim strRst, sqlStr
		sqlStr = "Select keywordIdx, keywordname "
		sqlStr = sqlStr & "From db_board.dbo.tbl_gift_keyword "
		sqlStr = sqlStr & "Where isUsing='Y' and keywordType=1 "
		sqlStr = sqlStr & "Order by sortNo asc, keywordIdx asc "
		rsget.Open sqlStr, dbget, 1
		if Not(rsget.EOF or rsget.BOF) then
			strRst = "<ul>" & vbCrLf
			Do Until rsget.EOF
				strRst = strRst & "<li><span onclick=""" & vClk & """ keyIdx=""" & rsget("keywordIdx") & """ " & chkIIF(chkArrValue(arrChk,rsget("keywordIdx")),"class=""on""","") & ">" & rsget("keywordname") & "</span></li>"
				rsget.MoveNext
			Loop
			strRst = strRst & "<ul>" & vbCrLf
		end if
		rsget.Close

		getGiftKeyword = strRst
	End Function

	'// gift Tag 항목 출력 (어레이값,구분자1,구분자2,클릭함수)
	Function getGiftTag(vTag,vDiv1,vDiv2,vClk)
		Dim strRst, arrGp, vItm, arrItm
		if vTag="" or isNull(vTag) then Exit Function

		arrGp = split(vTag,vDiv1)
		if ubound(arrGp)<0 then Exit Function

		for each vItm in arrGp
			arrItm = split(vItm,vDiv2)
			if ubound(arrItm)>0 then
				strRst = strRst & chkIIF(strRst<>"",", ","")
				strRst = strRst & "<a href=""#"" onclick=""" & vClk & ";return false;"" keyIdx=""" & arrItm(0) & """>" & db2html(arrItm(1)) & "</a>"
			end if
		next

		getGiftTag = strRst
	End Function

	'//남은 날짜 출력		'2014.04.03 한용민 생성
	Function getdayTerm(vDt,vLimit)
		Dim strRst
		if Not(isDate(vDt)) then Exit Function
	
		strRst=datediff("d", now(), vDt)
		if strRst < vLimit then strRst=0
	
		getdayTerm = strRst
	End Function

	'// 기프트 상품 연결정보(카운트) 업데이트
	Sub updateGiftItemInfo(vDiv,vIdx)
		dim sqlStr
		if vDiv="" or vIdx="" then Exit Sub

		Select Case vDiv
			Case "talk"
				'// 기프트 톡
				sqlStr = "Update f "
				sqlStr = sqlStr & "set f.talkCount=c.cnt "
				sqlStr = sqlStr & "From db_board.dbo.tbl_gift_itemInfo as f "
				sqlStr = sqlStr & "	join ( "
				sqlStr = sqlStr & "		Select d.itemid, sum(Case When m.useyn='y' Then 1 Else 0 end) as cnt "
				sqlStr = sqlStr & "		from db_board.dbo.tbl_shopping_talk as m "
				sqlStr = sqlStr & "			Join db_board.dbo.tbl_shopping_talk_item as d "
				sqlStr = sqlStr & "				on m.talk_idx=d.talk_idx "
				sqlStr = sqlStr & "		where d.itemid in ( "
				sqlStr = sqlStr & "				Select itemid "
				sqlStr = sqlStr & "				from db_board.dbo.tbl_shopping_talk_item "
				sqlStr = sqlStr & "				where talk_idx in (" & vIdx & ")"
				sqlStr = sqlStr & "			) "
				sqlStr = sqlStr & "		group by d.itemid "
				sqlStr = sqlStr & "	) as c "
				sqlStr = sqlStr & "		on f.itemid=c.itemid "
				dbget.Execute(sqlStr)

				sqlStr = "insert into db_board.dbo.tbl_gift_itemInfo (itemid,talkCount) "
				sqlStr = sqlStr & "Select i.itemid, c.cnt "
				sqlStr = sqlStr & "from db_item.dbo.tbl_item as i "
				sqlStr = sqlStr & "	join ( "
				sqlStr = sqlStr & "		Select d.itemid, count(d.idx) as cnt "
				sqlStr = sqlStr & "		from db_board.dbo.tbl_shopping_talk as m "
				sqlStr = sqlStr & "			Join db_board.dbo.tbl_shopping_talk_item as d "
				sqlStr = sqlStr & "				on m.talk_idx=d.talk_idx "
				sqlStr = sqlStr & "		where m.useyn='y' and m.talk_idx in (" & vIdx & ")"
				sqlStr = sqlStr & "		group by d.itemid "
				sqlStr = sqlStr & "	) as c "
				sqlStr = sqlStr & "		on i.itemid=c.itemid "
				sqlStr = sqlStr & "where i.itemid not in ( "
				sqlStr = sqlStr & "		Select itemid "
				sqlStr = sqlStr & "		from db_board.dbo.tbl_gift_itemInfo "
				sqlStr = sqlStr & "	) "
				dbget.Execute(sqlStr)

			Case "day"
				'// 기프트 데이
				sqlStr = "Update f "
				sqlStr = sqlStr & "set f.dayCount=c.cnt "
				sqlStr = sqlStr & "From db_board.dbo.tbl_gift_itemInfo as f "
				sqlStr = sqlStr & "	join ( "
				sqlStr = sqlStr & "		Select d.itemid, sum(Case When m.isUsing='Y' and d.isUsing='Y' Then 1 Else 0 end) as cnt "
				sqlStr = sqlStr & "		from db_board.dbo.tbl_giftDay_detail as m "
				sqlStr = sqlStr & "			Join db_board.dbo.tbl_giftDay_detail_item as d "
				sqlStr = sqlStr & "				on m.detailIdx=d.detailIdx "
				sqlStr = sqlStr & "		where d.itemid in ( "
				sqlStr = sqlStr & "				Select itemid "
				sqlStr = sqlStr & "				from db_board.dbo.tbl_giftDay_detail_item "
				sqlStr = sqlStr & "				where detailIdx in (" & vIdx & ")"
				sqlStr = sqlStr & "			) "
				sqlStr = sqlStr & "		group by d.itemid "
				sqlStr = sqlStr & "	) as c "
				sqlStr = sqlStr & "		on f.itemid=c.itemid "
				dbget.Execute(sqlStr)

				sqlStr = "insert into db_board.dbo.tbl_gift_itemInfo (itemid,dayCount) "
				sqlStr = sqlStr & "Select i.itemid, c.cnt "
				sqlStr = sqlStr & "from db_item.dbo.tbl_item as i "
				sqlStr = sqlStr & "	join ( "
				sqlStr = sqlStr & "		Select d.itemid, count(d.detailitemidx) as cnt "
				sqlStr = sqlStr & "		from db_board.dbo.tbl_giftDay_detail as m "
				sqlStr = sqlStr & "			Join db_board.dbo.tbl_giftDay_detail_item as d "
				sqlStr = sqlStr & "				on m.detailIdx=d.detailIdx and d.isUsing='Y' "
				sqlStr = sqlStr & "		where m.isUsing='Y' and m.detailIdx in (" & vIdx & ")"
				sqlStr = sqlStr & "		group by d.itemid "
				sqlStr = sqlStr & "	) as c "
				sqlStr = sqlStr & "		on i.itemid=c.itemid "
				sqlStr = sqlStr & "where i.itemid not in ( "
				sqlStr = sqlStr & "		Select itemid "
				sqlStr = sqlStr & "		from db_board.dbo.tbl_gift_itemInfo "
				sqlStr = sqlStr & "	) "
				dbget.Execute(sqlStr)

			Case "shop"
				'// 기프트 샾
				sqlStr = "Update f "
				sqlStr = sqlStr & "set f.themeCount=c.cnt "
				sqlStr = sqlStr & "From db_board.dbo.tbl_gift_itemInfo as f "
				sqlStr = sqlStr & "	join ( "
				sqlStr = sqlStr & "		Select d.itemid, sum(Case When m.isOpen='Y' and m.isUsing='Y' Then 1 Else 0 end) as cnt "
				sqlStr = sqlStr & "		from db_board.dbo.tbl_giftShop_theme as m "
				sqlStr = sqlStr & "			join db_board.dbo.tbl_giftShop_theme_item as d "
				sqlStr = sqlStr & "				on m.themeIdx=d.themeIdx "
				sqlStr = sqlStr & "		where d.itemid in ( "
				sqlStr = sqlStr & "				Select itemid "
				sqlStr = sqlStr & "				from db_board.dbo.tbl_giftShop_theme_item "
				sqlStr = sqlStr & "				where themeIdx in (" & vIdx & ")"
				sqlStr = sqlStr & "			) "
				sqlStr = sqlStr & "		group by d.itemid "
				sqlStr = sqlStr & "	) as c "
				sqlStr = sqlStr & "		on f.itemid=c.itemid "
				dbget.Execute(sqlStr)

				sqlStr = "insert into db_board.dbo.tbl_gift_itemInfo (itemid,themeCount) "
				sqlStr = sqlStr & "Select i.itemid, c.cnt "
				sqlStr = sqlStr & "from db_item.dbo.tbl_item as i "
				sqlStr = sqlStr & "	join ( "
				sqlStr = sqlStr & "		Select d.itemid, count(d.themeIdx) as cnt "
				sqlStr = sqlStr & "		from db_board.dbo.tbl_giftShop_theme as m "
				sqlStr = sqlStr & "			join db_board.dbo.tbl_giftShop_theme_item as d "
				sqlStr = sqlStr & "				on m.themeIdx=d.themeIdx "
				sqlStr = sqlStr & "		where m.isOpen='Y' and m.isUsing='Y' "
				sqlStr = sqlStr & "			and m.themeIdx in (" & vIdx & ")"
				sqlStr = sqlStr & "		group by d.itemid "
				sqlStr = sqlStr & "	) as c "
				sqlStr = sqlStr & "		on i.itemid=c.itemid "
				sqlStr = sqlStr & "where i.itemid not in ( "
				sqlStr = sqlStr & "		Select itemid "
				sqlStr = sqlStr & "		from db_board.dbo.tbl_gift_itemInfo "
				sqlStr = sqlStr & "	) "
				dbget.Execute(sqlStr)
		End Select
	End Sub
	
	
	Function fnGetViewRightGiftShop(idx,div)
		Dim vArr, strSql
		strSql = "EXECUTE [db_board].[dbo].[sp_Ten_GiftViewRight_GiftShop] '" & idx & "','" & div & "'"
		'response.write strSql
		rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
		rsget.Open strSql,dbget,1

		if not rsget.EOF then
			vArr = rsget.getRows()
		end if
		rsget.close
		fnGetViewRightGiftShop = vArr
	End Function
%>