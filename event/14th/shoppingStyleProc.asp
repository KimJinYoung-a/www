<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
'### 14주년 이벤트 그것이 알고싶다. 
'### 2015-10-06 원승현
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_myfavoritecls.asp" -->
<!-- #include virtual="/lib/util/badgelib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<%
dim eCode, userid, mode, sqlstr, refer, myscent, mycomcnt, vQuery, enterCnt, vQanswer, vYCnt, vResultScore, splitQanswer, vSubOpt1Val
Dim refip, myfolderCnt, vFidx, foldername, vqWishItems
Dim myfavorite, vWishEventOX, vqWishItemsLen, intResult, intloop


	userid = GetEncLoginUserID
	refer = request.ServerVariables("HTTP_REFERER")
	refip = Request.ServerVariables("REMOTE_ADDR")
	vQanswer = requestcheckvar(request("qAnswer"),128)
	mode = requestcheckvar(request("mode"),128)
	vqWishItems = requestcheckvar(request("qWishItems"),128)

	'// 폴더네임 정의
	foldername = "그것이 알고싶다"

	IF application("Svr_Info") = "Dev" THEN
		eCode   =  64909
	Else
		eCode   =  66518
	End If

	if InStr(refer,"10x10.co.kr")<1 then
		Response.Write "Err|잘못된 접속입니다."
		dbget.close() : Response.End
	end if

	If not( left(now(),10)>="2015-10-07" and left(now(),10)<"2015-10-27" ) Then
		Response.Write "Err|이벤트 응모 기간이 아닙니다."
		dbget.close() : Response.End
	End If

	If mode = "add" Then '//응모하기 버튼 클릭
		'' 해당일자에 응모 이력 있는지 체크
		sqlstr = "select count(userid) as cnt "
		sqlstr = sqlstr & " from [db_event].[dbo].[tbl_event_subscript]"
		sqlstr = sqlstr & " where evt_code="& eCode &""
		sqlstr = sqlstr & " and userid='"& userid &"' And convert(varchar(10), regdate, 120) = '"&Left(now(), 10)&"' "
		rsget.Open sqlstr, dbget, adOpenForwardOnly, adLockReadOnly
	
		If Not rsget.Eof Then
			mycomcnt = rsget(0)
		End IF
		rsget.close

		If mycomcnt < 1 Then '//응모 내역이 없음
			'// 무조건 총합 5자이여야 하므로 해당 값 체크하여 5자가 넘거나 초과하면 튕김
			If Len(Trim(vQanswer))=5 Then
				'// 들어온값중 2,3,4번째 자리만 추출
				 splitQanswer = Mid(vQanswer, 2, 3)
			Else
				Response.Write "Err|정상적인 경로가 아닙니다."
				dbget.close() : Response.End
			End If

			vSubOpt1Val = "Type0"&getResultSbsValue(Trim(splitQanswer))

			'// 결과값(사용자응모값, 타입값)을 집어넣는다.
			sqlstr = "INSERT INTO [db_event].[dbo].[tbl_event_subscript] (evt_code , userid , sub_opt1 , sub_opt2, sub_opt3, device, regdate)" + vbcrlf
			sqlstr = sqlstr & " VALUES("& eCode &", '"& userid &"', '"&vSubOpt1Val&"', '"&getResultSbsValue(Trim(splitQanswer))&"','"&Trim(vQanswer)&"', 'W',getdate() )" + vbcrlf
			dbget.execute sqlstr

			Response.Write "OK|"&getResultSbsValue(Trim(splitQanswer))
			dbget.close() : Response.End

		Else '//이미 이벤트에 참여했음
			Response.Write "Err|이미 응모하셨습니다."
			dbget.close() : Response.End
		End If
		
	ElseIf mode="wish" Then

		'// 혹 모르니 위시폴더 갯수 다시한번 확인
		sqlstr = " SELECT count(userid) FROM [db_my10x10].[dbo].[tbl_myfavorite_folder] WHERE UserID = '"&userid&"' "
		rsget.Open sqlstr, dbget, adOpenForwardOnly, adLockReadOnly
			myfolderCnt = rsget(0)
		rsget.close

		If myfolderCnt>=19 Then
			Response.Write "Err|위시폴더의 개수가 초과되었습니다.>?n위시폴더를 삭제 후 응모해주세요."
			dbget.close() : Response.End
		End If

		'// 그것이 알고싶다 폴더가 생성되었는지 확인.
		sqlstr = "Select top 1 fidx From [db_my10x10].[dbo].[tbl_myfavorite_folder]  WHERE foldername = '" & trim(foldername) & "' and userid='" & userid & "'  "
		rsget.Open sqlstr,dbget, adOpenForwardOnly, adLockReadOnly
		IF Not rsget.Eof Then
			vFidx = rsget(0)
		else
			vFidx = ""
		END IF
		rsget.Close

		'// 사용자 선택값이 제대로 넘어 왔는지 확인.
		If Trim(vqWishItems)="" Then
			Response.Write "Err|상품을 선택해주세요."
			dbget.close() : Response.End
		End If

		
		'// 사용자가 선택한 상품리스트 정리(,지워줌)
		vqWishItemsLen = Len(Trim(vqWishItems))
		vqWishItems = Right(vqWishItems, vqWishItemsLen-1)

		If Trim(vFidx) <> "" Then
			'// 폴더가 생성되어있다면 해당폴더에 상품만 넣는다.
			set myfavorite = new CMyFavorite			
			myfavorite.FRectUserID	= userid
			myfavorite.FFolderIdx	= vFidx
			myfavorite.selectedinsert(vqWishItems)
			'// 뱃지 카운트(위시 등록)
			Call MyBadge_CheckInsertBadgeLog(userid, "0004", "", vqWishItems, "")
			myfavorite.Fevtcode	= eCode
			myfavorite.fnWishListEventSave
			myfavorite.fnUpdateFolderInfo
			set myfavorite = Nothing

			'// itemcontents에 위시 담긴 상품갯수를 업데이트 해준다.
			vQuery = "UPDATE R SET " & vbCrLf
			vQuery = vQuery & " 	favcount = D.cnt " & vbCrLf
			vQuery = vQuery & " FROM [db_item].[dbo].[tbl_item_Contents] AS R " & vbCrLf
			vQuery = vQuery & " INNER JOIN " & vbCrLf
			vQuery = vQuery & " ( " & vbCrLf
			vQuery = vQuery & " 	SELECT itemid, count(itemid) AS cnt FROM [db_my10x10].[dbo].[tbl_myfavorite] where itemid in(" & vqWishItems & ") " & vbCrLf
			vQuery = vQuery & " 	GROUP BY itemid " & vbCrLf
			vQuery = vQuery & " ) AS D ON R.itemid = D.itemid " & vbCrLf
			vQuery = vQuery & " where R.itemid in(" & vqWishItems & ") " & vbCrLf
			'rw vQuery
			dbget.Execute vQuery

			Response.Write "OK|응모가 완료되었습니다.>?n[그것이 알고싶다] 위시플더를 확인해 주세요."
			dbget.close() : Response.End				
			
		Else
			'// 폴더가 없다면 폴더를 생성해준다.
			set myfavorite = new CMyFavorite	
				myfavorite.FRectUserID = userid
				myfavorite.FFolderName = foldername
				myfavorite.fviewisusing = "Y"
				intResult = myfavorite.fnSetFolder
			set myfavorite = nothing	
			'// 폴더가 정상적으로 생성이 되었다면..

			IF intResult > 0  Then
				set myfavorite = new CMyFavorite			
				myfavorite.FRectUserID	= userid
				myfavorite.FFolderIdx	= intResult

				myfavorite.selectedinsert(vqWishItems)
				'// 뱃지 카운트(위시 등록)
				Call MyBadge_CheckInsertBadgeLog(userid, "0004", "", vqWishItems, "")

				myfavorite.Fevtcode	= eCode
				myfavorite.fnWishListEventSave
				myfavorite.fnUpdateFolderInfo
				set myfavorite = Nothing

				'// itemcontents에 위시 담긴 상품갯수를 업데이트 해준다.
				vQuery = "UPDATE R SET " & vbCrLf
				vQuery = vQuery & " 	favcount = D.cnt " & vbCrLf
				vQuery = vQuery & " FROM [db_item].[dbo].[tbl_item_Contents] AS R " & vbCrLf
				vQuery = vQuery & " INNER JOIN " & vbCrLf
				vQuery = vQuery & " ( " & vbCrLf
				vQuery = vQuery & " 	SELECT itemid, count(itemid) AS cnt FROM [db_my10x10].[dbo].[tbl_myfavorite] where itemid in(" & vqWishItems & ") " & vbCrLf
				vQuery = vQuery & " 	GROUP BY itemid " & vbCrLf
				vQuery = vQuery & " ) AS D ON R.itemid = D.itemid " & vbCrLf
				vQuery = vQuery & " where R.itemid in(" & vqWishItems & ") " & vbCrLf
				'rw vQuery
				dbget.Execute vQuery

				Response.Write "OK|응모가 완료되었습니다.>?n[그것이 알고싶다] 위시플더를 확인해 주세요."
				dbget.close() : Response.End				
			Else
				Response.Write "Err|데이터처리에 문제가 발생했습니다."
				dbget.close() : Response.End				
			End If
		End If

	Else
		Response.Write "Err|정상적인 경로가 아닙니다."
		dbget.close() : Response.End
	end If
	
	'// 결과값별 type값 산정
	Function getResultSbsValue(rs)
		Dim SelTypeVal

		Select Case Trim(rs)
			Case "AAA"
				SelTypeVal = "1"
			Case "AAB"
				SelTypeVal = "2"
			Case "ABA"
				SelTypeVal = "3"
			Case "ABB"
				SelTypeVal = "4"
			Case "BAA"
				SelTypeVal = "5"
			Case "BAB"
				SelTypeVal = "6"
			Case "BBA"
				SelTypeVal = "7"
			Case "BBB"
				SelTypeVal = "8"
			Case Else
				SelTypeVal = "1"
		End Select
		getResultSbsValue = SelTypeVal
	End Function
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->