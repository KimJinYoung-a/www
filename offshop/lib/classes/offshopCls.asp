<%
'########################################################
' PageName : /offshop/lib/classes/offshopCls.asp
' Description : 오프라인숍 공통 클래스
' History : 2009.07.14 강준구 생성
'########################################################

function getMayRegShopID(icardNo,byRef isForeignCurrency)
    Dim strSql, ishopid
    
    isForeignCurrency = False
    
    ''계산시 카드 긁으면 등록샵이 지정됨.
    strSql = " select IsNULL(regshopid,'') as regshopid from [db_shop].dbo.tbl_total_shop_card where cardNo='"&icardNo&"'"
    
    rsget.Open strSql,dbget 
	IF Not rsget.EOF THEN
		ishopid = rsget("regshopid")
	END IF	
	rsget.Close
    	
	if (ishopid="") then
	    ''카드가 지정된 경우
        strSql = " select IsNULL(evalshopid,'') as evalshopid from [db_shop].dbo.tbl_total_card_list where cardNo='"&icardNo&"'"
        
        rsget.Open strSql,dbget 
    	IF Not rsget.EOF THEN
    		ishopid = rsget("evalshopid")
    	END IF	
    	rsget.Close
	end if
	
	if (ishopid="") then
	    '' 로그에만 있을경우
	    strSql = " select top 1 IsNULL(regshopid,'') as regshopid " & vbCRLF
        strSql = strSql & " from [db_shop].[dbo].tbl_total_shop_log" & vbCRLF
        strSql = strSql & " where cardNo='"&icardNo&"'" & vbCRLF
        strSql = strSql & " and regshopid<>''" & vbCRLF
        strSql = strSql & " order by Log_idx desc" & vbCRLF
        
        rsget.Open strSql,dbget 
    	IF Not rsget.EOF THEN
    		ishopid = rsget("regshopid")
    	END IF	
    	rsget.Close

	end if
	
	''해외샵인지 체크 
	if (ishopid<>"") then
	    strSql = " select IsNULL(currencyUnit,'WON') as currencyUnit from db_shop.dbo.tbl_shop_user"
        strSql = strSql & " where userid='"&ishopid&"'"
        rsget.Open strSql,dbget 
    	IF Not rsget.EOF THEN
    		isForeignCurrency = (rsget("currencyUnit")<>"WON")
    	END IF	
    	rsget.Close

	end if
		
end function

Class COffshopBoard
	public Fidx
	public FTotCnt
	public FCPage
	public FPSize
	public FShopId
	
	public FPreNoticeIdx
	public FBackNoticeIdx
	
	
	public Function fnGetTopNotice()
		Dim strSql
		if FPSize="" then FPSize=5
		
		strSql = " SELECT TOP " & FPSize & "  a.idx, a.shopid, a.gubun, a.title, a.regdate, b.shopname " & vbCrLf
		strSql = strSql & " FROM [db_shop].[dbo].tbl_offshop_news_event as a INNER JOIN [db_shop].[dbo].tbl_shop_user as b on a.shopid = b.userid " & vbCrLf
		strSql = strSql & " WHERE a.isusing ='Y' and b.vieworder <> 0 order by a.idx DESC "
				'" WHERE a.isusing ='Y' and b.vieworder <> 0 and a.enddate > getdate() order by a.idx DESC "
		'response.write strSql
		rsget.Open strSql,dbget 
		IF Not rsget.EOF THEN
			fnGetTopNotice = rsget.getRows()
		END IF	
		rsget.Close
	End Function
	
	
	public Function fnGetNoticeCont()
		Dim strSql
		IF Fidx = "" THEN EXIT Function
		strSql = " SELECT idx, shopid, gubun, title, contents, file1, enddate, regdate " & vbCrLf
		strSql = strSql & " FROM [db_shop].[dbo].tbl_offshop_news_event" & vbCrLf
		strSql = strSql & " WHERE isusing ='Y' and idx= '" & Fidx & "' "
		rsget.Open strSql,dbget 
		IF Not rsget.EOF THEN
			fnGetNoticeCont = rsget.getRows()
		END IF	
		rsget.Close				
	End Function
	
	
	public Function fnGetNotice()
		Dim strSql, strSqlCnt, intDelCnt, strAdd
		IF FShopId <> "" THEN
			strAdd = " and a.shopid = '"&FShopId&"'"
		END IF
	
		strSqlCnt = " SELECT COUNT(a.idx) " & vbCrLf
		strSqlCnt = strSqlCnt & " FROM [db_shop].[dbo].tbl_offshop_news_event  as a INNER JOIN [db_shop].[dbo].tbl_shop_user as b on a.shopid = b.userid " & vbCrLf
		strSqlCnt = strSqlCnt & " WHERE a.isusing ='Y' and b.vieworder <> 0 " & strAdd
		rsget.Open strSqlCnt,dbget 
		IF Not rsget.EOF THEN
			FTotCnt = rsget(0)
		END IF	
		rsget.Close
				
		IF FTotCnt > 0 THEN
			intDelCnt =  (FCPage - 1) * FPSize 			
		strSql = " SELECT TOP "&FPSize&" a.idx, a.shopid, a.gubun, a.title, b.shopname, a.enddate, a.regdate, a.contents, a.file1 " & vbCrLf
		strSql = strSql & " FROM [db_shop].[dbo].tbl_offshop_news_event  as a INNER JOIN [db_shop].[dbo].tbl_shop_user as b on a.shopid = b.userid " & vbCrLf
		strSql = strSql & " WHERE  a.isusing ='Y' and b.vieworder <> 0 " & strAdd & "" & vbCrLf
		strSql = strSql & "	and a.idx not in (SELECT TOP "&intDelCnt&" a.idx FROM [db_shop].[dbo].tbl_offshop_news_event as a INNER JOIN [db_shop].[dbo].tbl_shop_user as b on a.shopid = b.userid WHERE a.isusing ='Y' and b.vieworder <> 0 "&strAdd&" ORDER BY a.idx DESC) " & vbCrLf
		strSql = strSql & "	ORDER BY a.idx DESC "
		rsget.Open strSql,dbget 
		IF Not rsget.EOF THEN
			fnGetNotice = rsget.getRows()
		END IF	
		rsget.Close			
		END IF		
	End Function
	
	
	Public Function fnGetPreBackNoticeCon()
		Dim strSql
		IF Fidx = "" THEN EXIT Function
		'strSql = " SELECT Top 1 idx FROM [db_shop].[dbo].tbl_offshop_news_event WHERE isusing ='Y' and idx > " & Fidx & " and shopid = '" & FShopId & "' and enddate > getdate() order by idx ASC "
		strSql = " SELECT Top 1 idx FROM [db_shop].[dbo].tbl_offshop_news_event WHERE isusing ='Y' and idx > " & Fidx & " and shopid = '" & FShopId & "' order by idx ASC "
		rsget.Open strSql,dbget 
		IF Not rsget.EOF THEN
			FPreNoticeIdx = rsget(0)
		Else
			FPreNoticeIdx = "0"
		END IF
		rsget.Close
		'strSql = " SELECT Top 1 idx FROM [db_shop].[dbo].tbl_offshop_news_event WHERE isusing ='Y' and idx < " & Fidx & " and shopid = '" & FShopId & "' and enddate > getdate() order by idx DESC "
		strSql = " SELECT Top 1 idx FROM [db_shop].[dbo].tbl_offshop_news_event WHERE isusing ='Y' and idx < " & Fidx & " and shopid = '" & FShopId & "' order by idx DESC "
		rsget.Open strSql,dbget
		IF Not rsget.EOF THEN
			FBackNoticeIdx = rsget(0)
		Else
			FBackNoticeIdx = "0"
		END IF
		rsget.Close	
	End Function
	
End Class


'//COffShopQNA :  Q&A Info  (2006.12.11 정윤정)
Class COffShopQNA
	public FTotCnt
	public FCPage
	public FPSize
	public FIdx
	public FShopId
	public	Fuserid
	public	Ftitle 
	public	Fitemid 
	public	Fcontents 
	public	Fregdate 
	public	Freplyuser 	
	public	Freplydate 
	public  Freplycontents
	public Fbrandname   
	public Fitemname 	
	public Fsellcash 	
	public Flistimage
	public Flistimage200
	
	public FPreQNAIdx
	public FBackQNAIdx
	
			
	'-- fnGetShopQNA : 각지점의 각각의 Q&A 보기
	public Function fnGetShopQNA()
		Dim strSql, strSqlCnt, intDelCnt, strAdd		
		IF FShopId = "" THEN Exit Function			
		strSqlCnt = " SELECT COUNT(idx) " & vbCrLf
		strSqlCnt = strSqlCnt & " FROM [db_shop].[dbo].tbl_offshop_qna " & vbCrLf
		strSqlCnt = strSqlCnt & " WHERE isusing='Y'  and shopid='"&FShopId&"'"
		rsget.Open strSqlCnt,dbget 
		IF not rsget.Eof THEN
			FTotCnt = rsget(0)
		END IF	
		rsget.Close			
		
		IF 	FTotCnt > 0 THEN
			intDelCnt =  (FCPage - 1) * FPSize 			
			strSql = " SELECT TOP "&FPSize&" idx, shopid, userid, title, regdate, replyuser, replydate " & vbCrLf
			strSql = strSql & " FROM [db_shop].[dbo].tbl_offshop_qna " & vbCrLf
			strSql = strSql & "  WHERE isusing='Y'  and shopid='"&FShopId&"'" & vbCrLf
			strSql = strSql & "	and idx not in ( SELECT TOP "&intDelCnt&" idx FROM [db_shop].[dbo].tbl_offshop_qna " & vbCrLf
			strSql = strSql & "				WHERE isusing='Y' and shopid='"&FShopId&"' order by idx DESC)" & vbCrLf
			strSql = strSql & "	order by idx DESC "
					
			rsget.Open strSql,dbget 
		IF not rsget.Eof THEN
			fnGetShopQNA = rsget.getRows()
		END IF	
		rsget.Close					
		END IF	
	End Function

	public Function fnGetQNACont(ByVal Fidx)
		Dim strSql
		strSql = " SELECT userid, title, itemid, contents, regdate, replyuser, replydate, replycontents " & vbCrLf
		strSql = strSql & " FROM [db_shop].[dbo].tbl_offshop_qna " & vbCrLf
		strSql = strSql & " WHERE isusing='Y' and shopid='"&FShopId&"' and idx = '"&Fidx&"' " & vbCrLf
		rsget.Open strSql,dbget 
		IF not rsget.Eof THEN
			Fuserid = rsget("userid")
			Ftitle = rsget("title")
			Fitemid = rsget("itemid")
			Fcontents = rsget("contents")
			Fregdate = rsget("regdate")
			Freplyuser = rsget("replyuser")		
			Freplydate = rsget("replydate")
			Freplycontents= rsget("replycontents")
		END IF	
		rsget.Close							
		IF Fitemid <> 0 OR not isnull(Fitemid) THEN
			call fnGetItemInfo(Fitemid)
		END IF	
		
	End Function
	
	
	Public Function fnGetPreBackQNACon()
		Dim strSql
		IF Fidx = "" THEN EXIT Function
		strSql = " SELECT Top 1 idx FROM [db_shop].[dbo].tbl_offshop_qna WHERE isusing ='Y' and idx > " & Fidx & " and shopid = '" & FShopId & "' order by idx ASC "
		rsget.Open strSql,dbget 
		IF Not rsget.EOF THEN
			FPreQNAIdx = rsget(0)
		Else
			FPreQNAIdx = "0"
		END IF
		rsget.Close
		strSql = " SELECT Top 1 idx FROM [db_shop].[dbo].tbl_offshop_qna WHERE isusing ='Y' and idx < " & Fidx & " and shopid = '" & FShopId & "' order by idx DESC "
		rsget.Open strSql,dbget
		IF Not rsget.EOF THEN
			FBackQNAIdx = rsget(0)
		Else
			FBackQNAIdx = "0"
		END IF
		rsget.Close	
	End Function

	
	private Function fnGetItemInfo(ByVal itemID)
		Dim strSql
		IF itemID = "" THEN EXIT FUNCTION
		strSql = " SELECT brandname, itemname, sellcash,listimage,icon1image FROM [db_item].[dbo].tbl_item WHERE itemid ="&itemID
		rsget.Open strSql, dbget 
		IF not rsget.Eof THEN
			Fbrandname 		= rsget("brandname")
			Fitemname 		= rsget("itemname")
			Fsellcash 		= rsget("sellcash")
			Flistimage 		= rsget("listimage")
			Flistimage200	= rsget("icon1image")
		END IF	
		rsget.Close		
	End Function	
End Class


Class COffShopGallery

	public FShopId
	public FTotCnt
	public FCPage
	public FPSize
	
	public Function fnGetShopGallery()
		Dim strSql, strSqlCnt, intDelCnt, strAdd
		IF FShopId = "" THEN Exit Function
			
		strSqlCnt = " SELECT COUNT(idx) " & vbCrLf
		strSqlCnt = strSqlCnt & " FROM [db_shop].[dbo].tbl_offshop_gallery " & vbCrLf
		strSqlCnt = strSqlCnt & "  WHERE UseYN='Y'  and shopid='"&FShopId&"'"
		rsget.Open strSqlCnt,dbget 
		IF not rsget.Eof THEN
			FTotCnt = rsget(0)
		END IF	
		rsget.Close
		
		IF 	FTotCnt > 0 THEN
			intDelCnt =  (FCPage - 1) * FPSize
			strSql = " SELECT TOP "&FPSize&" IDX, ShopID, ImageURL, Regdate " & vbCrLf
			strSql = strSql & " FROM [db_shop].[dbo].tbl_offshop_gallery " & vbCrLf
			strSql = strSql & "  WHERE UseYN='Y'  and shopid='"&FShopId&"'" & vbCrLf
			strSql = strSql & "	and idx not in ( SELECT TOP "&intDelCnt&" idx FROM [db_shop].[dbo].tbl_offshop_gallery " & vbCrLf
			strSql = strSql & "				WHERE UseYN='Y' and ShopID='"&FShopId&"' order by IDX DESC)" & vbCrLf
			strSql = strSql & "	order by IDX DESC "
					
			rsget.Open strSql,dbget 
		IF not rsget.Eof THEN
			fnGetShopGallery = rsget.getRows()
		END IF	
		rsget.Close
		END IF	
	End Function
	
End Class


Class COffshopPoint1010

	public FUserSeq
	public FUserID
	public FUserName
	public FPoint
	public FRegdate
	public FRealNameChk
	public FSSN1
	public FSSN2
	public FCardNo
	public FUseYN
	public FCPage
	public FPSize
	public FTotCnt
	public FFAQIDX
	public FSearch
	public FGubun

	public FIDX
	public FTitle
	public FContent
	public FEmail
	public FEmailYN
	public FTenEmailYN
	public FFinEmailYN
	public FMobile
	public FMobileYN
	public FTenMobileYN
	public FFinMobileYN
	public FTelNo
	public FHpNo
	public FZipCode
	public FAddress
	public FAddressDetail
	
	public FHaveTotalCardYN
	
	public FImageURL
	public FLinkURL


	'-- 실명 확인 및 가입여부 확인
	public Function fnGetUserSilMyung()
		Dim strSql, strSqlCnt, intDelCnt, strAdd, vEnc_Jumin2

		strSql = " SELECT COUNT(*) "&_
				" FROM [db_shop].[dbo].[tbl_total_shop_user] AS A "&_
				" 		INNER JOIN [db_shop].[dbo].[tbl_total_shop_card] AS B ON A.UserSeq = B.UserSeq "&_
				"  WHERE A.OnlineUserID = '" & GetLoginUserID() & "' AND B.UseYN = 'Y' AND Left(B.CardNo,4) = '1010' "& _
				"	 "
					
		rsget.Open strSql,dbget 
		IF rsget(0) > 0 THEN
			FHaveTotalCardYN = "Y"
		Else
			FHaveTotalCardYN = "N"
		END IF	
		rsget.Close

		strSql = " SELECT B.RegShopID, B.CardNo, Convert(varchar(10),B.Regdate,120) AS Regdate, B.Point, A.UserSeq "&_
				" FROM [db_shop].[dbo].[tbl_total_shop_user] AS A "&_
				" 		INNER JOIN [db_shop].[dbo].[tbl_total_shop_card] AS B ON A.UserSeq = B.UserSeq "&_
				"  WHERE A.OnlineUserID = '" & GetLoginUserID() & "' AND B.UseYN = 'Y' "& _
				"	 "
					
		rsget.Open strSql,dbget 
		IF not rsget.Eof THEN
			fnGetUserSilMyung = rsget.getRows()
		END IF	
		rsget.Close

	End Function
	
	
	'-- 개인정보 수정
	public Function fnGetMemberYuMu()
		Dim strSql
		strSql = "SELECT COUNT(*) FROM [db_shop].[dbo].tbl_total_shop_user WHERE OnlineUserID = '" & FUserID & "'"
		rsget.Open strSql,dbget
		IF not rsget.Eof THEN
			If rsget(0) > 0 Then
				FGubun = "o"
			End If
		END IF
		rsget.Close
	End Function
	

	'-- 개인정보 수정
	public Function fnGetMemberInfo()
		Dim strSql, subSql
		If FGubun = "1" Then
			strSql = " SELECT A.UserSeq, A.UserName, A.Jumin1, A.Email, " & _
					 "			B.email_10x10 AS TenEYN, B.email_way2way AS FinEYN, isNull(A.EmailYN,'N') AS P1010EYN, " & _
					 "			isNull(B.smsok,'N') AS TenSYN, isNull(B.smsok_fingers,'N') AS FinSYN, isNull(A.SMSYN,'N') AS P1010SYN, " & _
					 "			A.TelNo, A.HpNo, A.ZipCode, A.Address, A.AddressDetail " & _
					 "		FROM [db_shop].[dbo].tbl_total_shop_user AS A " & _
					 "		INNER JOIN [db_user].[dbo].tbl_user_n AS B ON A.OnlineUserID = B.userid " & _
					 "	WHERE A.OnlineUserID = '" & FUserID & "' "
		ElseIf FGubun = "2" Then
			strSql = " SELECT A.UserSeq, A.UserName, A.Jumin1, A.Email,  " & _
					 "			'' AS TenEYN, '' AS FinEYN, isNull(A.EmailYN,'N') AS P1010EYN, " & _
					 "			'' AS TenSYN, '' AS FinSYN, isNull(A.SMSYN,'N') AS P1010SYN, " & _
					 "			A.TelNo, A.HpNo, A.ZipCode, A.Address, A.AddressDetail " & _
					 "		FROM [db_shop].[dbo].tbl_total_shop_user AS A " & _
					 "		INNER JOIN [db_shop].[dbo].tbl_total_shop_card AS B ON A.UserSeq = B.UserSeq " & _
					 "	WHERE B.CardNo = '" & FCardNo & "' AND B.UseYN = 'Y' "
		End If
		rsget.Open strSql,dbget
		IF not rsget.Eof THEN
			FUserSeq		= rsget("UserSeq")
			FUserName		= rsget("UserName")
			FSSN1			= rsget("Jumin1")
			FEmail			= rsget("Email")
			FTenEmailYN		= rsget("TenEYN")
			FFinEmailYN		= rsget("FinEYN")
			FEmailYN		= rsget("P1010EYN")
			FTenMobileYN	= rsget("TenSYN")
			FFinMobileYN	= rsget("FinSYN")
			FMobileYN		= rsget("P1010SYN")
			FTelNo			= rsget("TelNo")
			FHpNo			= rsget("HpNo")
			FZipCode		= rsget("ZipCode")
			FAddress		= rsget("Address")
			FAddressDetail	= rsget("AddressDetail")
		ELSE
			FUserSeq = ""
		END IF
		rsget.Close

		If FGubun = "1" Then
			subSql = " AND UserSeq = '" & FUserSeq & "' "
		ElseIf FGubun = "2" Then
			subSql = " AND CardNo = '" & FCardNo & "' "
		End If
		
		IF (CStr(FUserSeq)<>"") or (FCardNo<>"") then  '''서동석 수정 AND UserSeq='' 로 비교하면 0 이나옴..??
    		strSql = "SELECT CardNo From [db_shop].[dbo].tbl_total_shop_card Where UseYN = 'Y' " & subSql & " "
    
    		rsget.Open strSql,dbget
    		IF not rsget.Eof THEN
    			fnGetMemberInfo = rsget.getRows()
    		END IF
    		rsget.Close
    	ENd IF
	End Function
	
	
	'-- 카드 정보 확인
	public Function fnGetCardInfo()
		Dim strSql
		If FCardNo <> "" Then
			strSql = " SELECT CardNo, Point, UseYN FROM [db_shop].[dbo].[tbl_total_shop_card] WHERE CardNo = '" & FCardNo & "' "
		Else
''			strSql = " SELECT A.CardNo, A.Point, A.UseYN FROM [db_shop].[dbo].[tbl_total_shop_card] AS A " & _
''					 "		INNER JOIN [db_shop].[dbo].[tbl_total_shop_user] AS B ON A.UserSeq = B.UserSeq " & _
''					 "		INNER JOIN [db_user].[dbo].[tbl_user_n] AS C ON B.Jumin1 = C.jumin1 AND B.Jumin2_Enc = C.Enc_jumin2 " & _
''					 "	Where C.userid = '" & GetLoginUserID() & "' AND A.UseYN = 'Y' "
		    
		    strSql = " SELECT A.CardNo, A.Point, A.UseYN FROM [db_shop].[dbo].[tbl_total_shop_card] AS A " & _
					 "		INNER JOIN [db_shop].[dbo].[tbl_total_shop_user] AS B ON A.UserSeq = B.UserSeq " & _
					 "	Where B.onlineuserid = '" & GetLoginUserID() & "' AND A.UseYN = 'Y' "
		End If
		rsget.Open strSql,dbget
		IF not rsget.Eof THEN
			fnGetCardInfo = rsget.getRows()
		END IF
		rsget.Close
	End Function
	
	
	'-- 카드 번호 확인
	public Function fnGetCardNumberCheck()
		Dim strSql
		If FGubun = "o" Then
			strSql = " SELECT Count(*) FROM [db_shop].[dbo].[tbl_total_shop_log_cardno] WHERE PointCode = '4' AND LogDesc = '카드번호조회:"&Request.ServerVariables("REMOTE_ADDR")&"' AND datediff(n,Regdate,getdate()) < 11 "
			rsget.Open strSql,dbget
			IF not rsget.Eof THEN
				If rsget(0) > 10 Then
					FTotCnt = 1000000000
					Exit Function
				End If
			END IF
			rsget.Close
		End If
		
		strSql = " SELECT Count(*) FROM [db_shop].[dbo].[tbl_total_card_list] WHERE CardNo = '" & FCardNo & "' AND UseYN = 'N' "
		rsget.Open strSql,dbget
		IF not rsget.Eof THEN
			FTotCnt = rsget(0)
		END IF
		rsget.Close
		
		''조건 추가 // 2013/02/18
		if (FTotCnt<1) then
    		strSql = " select count(*) as CNT"
            strSql = strSql&" from db_shop.dbo.tbl_total_shop_card c"
            strSql = strSql&" 	Join db_shop.dbo.tbl_total_shop_user U"
            strSql = strSql&" 	on c.UserSEq=U.UserSeq"
            strSql = strSql&" where c.CARDNo='"&FCardNo&"'"
            strSql = strSql&" and U.onlineUserId Is NULL"
            
            rsget.Open strSql,dbget
    		IF not rsget.Eof THEN
    			FTotCnt = rsget(0)
    		END IF
    		rsget.Close
        end if
		
		If FGubun = "o" Then
			dbget.Execute "INSERT INTO [db_shop].[dbo].[tbl_total_shop_log_cardno](CardNo, PointCode, RegShopID, LogDesc) VALUES('" & FCardNo & "', '4', '', '카드번호조회:"&Request.ServerVariables("REMOTE_ADDR")&"')"
		End If
	End Function
	
	
	'-- 보유 카드 포인트 내역 확인
	public Function fnGetMyCardPointInfo()
		Dim strSql
		If FCardNo <> "" Then
			strSql = " SELECT CardNo, Point, UseYN, regdate FROM [db_shop].[dbo].[tbl_total_shop_card] WHERE CardNo = '" & FCardNo & "' "
		Else
'			strSql = " SELECT A.CardNo, A.Point, A.UseYN, A.RegShopID FROM [db_shop].[dbo].[tbl_total_shop_card] AS A " & _
'					 "		INNER JOIN [db_shop].[dbo].[tbl_total_shop_user] AS B ON A.UserSeq = B.UserSeq " & _
'					 "		INNER JOIN [db_user].[dbo].[tbl_user_n] AS C ON B.Jumin1 = C.jumin1 AND B.Jumin2_Enc = C.Enc_jumin2 " & _
'					 "	Where C.userid = '" & GetLoginUserID() & "' AND A.UseYN = 'Y' "
					 
		    strSql = " SELECT A.CardNo, A.Point, A.UseYN, A.RegShopID, B.regdate FROM [db_shop].[dbo].[tbl_total_shop_card] AS A " & _
					 "		INNER JOIN [db_shop].[dbo].[tbl_total_shop_user] AS B ON A.UserSeq = B.UserSeq " & _
					 "	Where B.onlineuserid = '" & GetLoginUserID() & "' AND A.UseYN = 'Y' "
		End If
		rsget.Open strSql,dbget
		IF not rsget.Eof THEN
			fnGetMyCardPointInfo = rsget.getRows()
		END IF
		rsget.Close
	End Function
	
	
	'-- 적립 포인트 내역
	public Function fnGetMyCardPoint()
		Dim strSql, subSql
		If FGubun = "plus" Then
			subSql = " AND PointCode IN ('0','1','3') "
		ElseIf FGubun = "minus" Then
			subSql = " AND PointCode IN ('2','9') "
		End If
		strSql = " SELECT isNull(SUM(Point),0) FROM [db_shop].[dbo].[tbl_total_shop_log] WHERE CardNo = '" & FCardNo & "' " & subSql & " "
		rsget.Open strSql,dbget
		IF not rsget.Eof THEN
			FPoint = rsget(0)
		END IF
		rsget.Close
	End Function
	
	
	'-- 포인트 적립 및 내역 리스트 
	'-- (eastone 09.07.30) IX_tbl_total_shop_log_CardNo 추가  / tbl_user_n Join 필요한지 확인.
	public Function fnGetMyCardPointList()
		Dim strSql, strSqlCnt, subSql, intDelCnt
		
		subSql = " AND D.PointCode <> '4' AND A.UseYN = 'Y' "
'		If FGubun = "1010" Then
'			subSql = subSql & " AND Left(A.CardNo,4) = '1010' "
'		ElseIf FGubun = "3253" Then
'			subSql = subSql & " AND Left(A.CardNo,4) = '3253' "
'		ElseIf FGubun = "othe" Then
'			subSql = subSql & " AND Left(A.CardNo,4) NOT IN ('1010','3253') "
'		End If
		

		strSqlCnt = " SELECT COUNT(*)  " & _
				 	"		FROM [db_shop].[dbo].[tbl_total_shop_card] AS A " & _
				 	"		INNER JOIN [db_shop].[dbo].[tbl_total_shop_user] AS B ON A.UserSeq = B.UserSeq " & _
				 	"		INNER JOIN [db_shop].[dbo].[tbl_total_shop_log] AS D ON A.CardNo = D.CardNo  " & _
				 	"		INNER JOIN [db_shop].[dbo].[tbl_total_shop_code] AS E ON D.PointCode = E.code_value AND E.code_type = 'point'  " & _
				 	"	Where B.OnlineUserID = '" & GetLoginUserID() & "' " & subSql & " "

		rsget.Open strSqlCnt,dbget 
		IF not rsget.Eof THEN
			FTotCnt = rsget(0)
		END IF
		rsget.Close

		
		IF 	FTotCnt > 0 THEN
			intDelCnt =  (FCPage - 1) * FPSize

			strSql = " SELECT TOP "&FPSize&" A.RegShopID, D.CardNo, Convert(varchar(10),D.Regdate,120) AS Regdate, E.code_desc, '0', D.Point, isNull(D.OrderNo,'') AS OrderNo, D.PointCode, isNull(D.LogDesc,'') AS LogDesc  " & _
					 "		FROM [db_shop].[dbo].[tbl_total_shop_card] AS A " & _
					 "		INNER JOIN [db_shop].[dbo].[tbl_total_shop_user] AS B ON A.UserSeq = B.UserSeq " & _
					 "		INNER JOIN [db_shop].[dbo].[tbl_total_shop_log] AS D ON A.CardNo = D.CardNo  " & _
					 "		INNER JOIN [db_shop].[dbo].[tbl_total_shop_code] AS E ON D.PointCode = E.code_value AND E.code_type = 'point'  " & _
					 "	Where B.OnlineUserID = '" & GetLoginUserID() & "' " & subSql & " " & _
					 "		AND D.Log_Idx not in ( SELECT TOP "&intDelCnt&" D.Log_Idx FROM [db_shop].[dbo].[tbl_total_shop_card] AS A "&_
					 "				INNER JOIN [db_shop].[dbo].[tbl_total_shop_user] AS B ON A.UserSeq = B.UserSeq " & _
					 "				INNER JOIN [db_shop].[dbo].[tbl_total_shop_log] AS D ON A.CardNo = D.CardNo  " & _
					 "				INNER JOIN [db_shop].[dbo].[tbl_total_shop_code] AS E ON D.PointCode = E.code_value AND E.code_type = 'point'  " & _
					 "				WHERE B.OnlineUserID = '" & GetLoginUserID() & "' " & subSql & " ORDER BY D.Log_Idx DESC)"&_
					 "	ORDER BY D.Log_Idx DESC "

			'response.write strSql
			rsget.Open strSql,dbget
			IF not rsget.Eof THEN
				fnGetMyCardPointList = rsget.getRows()
			END IF
			rsget.Close
		END IF
	End Function
	
	
	'-- FAQ 리스트
	public Function fnGetPointFAQ()
		Dim strSql, strSqlCnt, intDelCnt, strAdd, subSql
		
		subSql = ""
		IF FFAQIDX <> "" Then
			subSql = subSql & " AND faqId = '" & FFAQIDX & "' "
		End If
		
		IF FSearch <> "" Then
			subSql = subSql & " AND (title Like '%" & FSearch & "%' OR contents Like '%" & FSearch & "%') "
		End If
				
		strSqlCnt = " SELECT COUNT(faqId) "&_
					" FROM [db_cs].[dbo].tbl_new_faq "&_
					"  WHERE isusing = 'Y' AND commCd = 'F016' " & subSql & " "
		rsget.Open strSqlCnt,dbget 
		IF not rsget.Eof THEN
			FTotCnt = rsget(0)
		END IF	
		rsget.Close
		
		IF 	FTotCnt > 0 THEN
			intDelCnt =  (FCPage - 1) * FPSize 			
			strSql = " SELECT TOP "&FPSize&" faqId, title, contents, hitcount "&_
					" FROM [db_cs].[dbo].tbl_new_faq "&_
					"  WHERE isusing = 'Y' AND commCd = 'F016' " & subSql & " "& _
					"	and faqId not in ( SELECT TOP "&intDelCnt&" faqId FROM [db_cs].[dbo].tbl_new_faq "&_
					"				WHERE isusing = 'Y' AND commCd = 'F016' " & subSql & " order by faqId DESC)"&_
					"	order by faqId DESC "
					
			rsget.Open strSql,dbget
		IF not rsget.Eof THEN
			fnGetPointFAQ = rsget.getRows()
		END IF	
		rsget.Close					
		END IF	
	End Function
	
	
	'-- FAQ 글적기
	public Function fnPoint1010QnaInsert()
		Dim strSql, vUserID
		vUserID = GetLoginUserID()

		IF FEmail = "" Then
			FEmail = "null"
		Else
			FEmail = "'" & FEmail & "'"
		End If
		IF FEmailYN = "" Then
			FEmailYN = "null"
		Else
			FEmailYN = "'" & FEmailYN & "'"
		End If
		IF FMobile = "" Then
			FMobile = "null"
		Else
			FMobile = "'" & FMobile & "'"
		End If
		IF FMobileYN = "" Then
			FMobileYN = "null"
		Else
			FMobileYN = "'" & FMobileYN & "'"
		End If
		strSql = "INSERT INTO [db_cs].[dbo].[tbl_point1010_qna](Title, Contents, Email, EmailYN, Mobile, MobileYN, UserID) " & _
				 " VALUES ('" & FTitle & "', '" & FContent & "', " & FEmail & ", " & FEmailYN & ", " & FMobile & ", " & FMobileYN & ", '" & vUserID & "') "
		dbget.Execute(strSql)
		
	End Function
	
	
	'-- FAQ 적은글 삭제
	public Function fnPoint1010QnaDelete()
		Dim strSql, subSql
		
		If GetLoginUserID() <> "" Then
			subSql = " AND userid = '" & GetLoginUserID() & "' "
		Else
			subSql = " AND orderserial = '" & request.Cookies("tinfo")("cardno") & "' "
		End If
		
		strSql = "IF EXISTS(SELECT id FROM [db_cs].[dbo].[tbl_myqna] WHERE id = '" & FIDX & "' " & subSql & ") " & _
				 "	BEGIN " & _
				 "		UPDATE [db_cs].[dbo].[tbl_myqna] SET isusing = 'N' WHERE id = '" & FIDX & "' " & _
				"	END "
		dbget.Execute(strSql)
	End Function
	
	
	'-- FAQ 적은글 리스트
	public Function fnPoint1010QnaList()
		Dim strSql, strSqlCnt, intDelCnt, strAdd, subSql
		
		If GetLoginUserID() <> "" Then
			subSql = " AND userid = '" & GetLoginUserID() & "' "
		Else
			subSql = " AND orderserial = '" & request.Cookies("tinfo")("cardno") & "' "
		End If
		
		IF FIDX <> "" Then
			subSql = subSql & " AND id = '" & FIDX & "' "
		End If
				
		strSqlCnt = " SELECT COUNT(id) "&_
					" FROM [db_cs].[dbo].tbl_myqna "&_
					"  WHERE qadiv = '24' AND isusing = 'Y' " & subSql & " "
		rsget.Open strSqlCnt,dbget 
		IF not rsget.Eof THEN
			FTotCnt = rsget(0)
		END IF	
		rsget.Close
		
		IF 	FTotCnt > 0 THEN
			intDelCnt =  (FCPage - 1) * FPSize 			
			strSql = " SELECT TOP "&FPSize&" id, title, Contents, Convert(varchar(10),regdate,120) AS regdate, isNull(replyuser,'N') AS RepleYN, replycontents "&_
					" FROM [db_cs].[dbo].tbl_myqna "&_
					"  WHERE qadiv = '24' AND isusing = 'Y' " & subSql & " "& _
					"	and id not in ( SELECT TOP "&intDelCnt&" id FROM [db_cs].[dbo].tbl_myqna "&_
					"				WHERE qadiv = '24' AND isusing = 'Y' " & subSql & " order by id DESC)"&_
					"	order by id DESC "
					
			rsget.Open strSql,dbget
		IF not rsget.Eof THEN
			fnPoint1010QnaList = rsget.getRows()
		END IF	
		rsget.Close					
		END IF	
	End Function
	
	
	
	'-- 메인페이지 좌측베너
	public Function fnGetMainLeftBanner()
		Dim strSql
		strSql = " SELECT Top 1 imageurl, linkurl FROM [db_sitemaster].[dbo].tbl_Offshopmain_contents " & _
				 "		WHERE poscode = 429 AND startdate <= getdate() AND enddate >= getdate() AND isusing = 'Y' "
		rsget.Open strSql,dbget
		IF not rsget.Eof THEN
			FImageURL = rsget("imageurl")
			FLinkURL  = rsget("linkurl")
		END IF
		rsget.Close
	End Function

	
End Class
%>
