<%
'// 내 위시 상품 목록(검색 결과에서 상품목록 전송)
Sub getMyFavItemList(uid,iid,byRef sIid, byRef sCnt)
 
 a=CINT(111111111111111111111111) ''오류냄. 더이상 안쓰임.
 Exit Sub
	dim strSQL, aiid, acnt
	aiid="": acnt=""

	if (uid="") then Exit Sub
	strSQL = "execute [db_my10x10].[dbo].[sp_Ten_MyWishSearchItem] '" & CStr(uid) & "', '" & cStr(iid) & "'"

	rsget.CursorLocation = adUseClient
	rsget.CursorType=adOpenStatic
	rsget.Locktype=adLockReadOnly
	rsget.Open strSQL, dbget
	if Not(rsget.EOF or rsget.BOF) then
		Do Until rsget.EOF
			aiid = aiid & chkIIF(aiid<>"",",","") & rsget("itemid")
			acnt = acnt & chkIIF(acnt<>"",",","") & rsget("favcount")
			rsget.MoveNext
		Loop
	end if
	rsget.Close

	'결과 반환
	sIid = aiid
	sCnt = acnt
end Sub

'// 뱃지 아이콘 목록 접수(코멘트, 후기 등)
Sub getUserBadgeList(uid,byRef sUid,byRef sBno, isRnd)
	dim strSQL, auid, abno
	auid="": abno=""

	if (uid="") then Exit Sub
	strSQL = "execute [db_my10x10].[dbo].[sp_Ten_UserBadgeGetArrList] '" & CStr(uid) & "','" & isRnd & "'"

	rsget.CursorLocation = adUseClient
	rsget.CursorType=adOpenStatic
	rsget.Locktype=adLockReadOnly
	rsget.Open strSQL, dbget
	if Not(rsget.EOF or rsget.BOF) then
		Do Until rsget.EOF
			if Not(rsget("dispno")="" or isNull(rsget("dispno"))) then
				auid = auid & chkIIF(auid<>"",",","") & rsget("userid")
				abno = abno & chkIIF(abno<>"",",","") & rsget("dispno")
			end if
			rsget.MoveNext
		Loop
	end if
	rsget.Close

	'결과 반환
	sUid = auid
	sBno = abno
end Sub

'// 뱃지 아이콘 출력 (아이콘 목록 사용;getUserBadgeList())
Function getUserBadgeIcon(uid,arrUid,arrBno,pno)
	Dim strRst, tmpBdg, i, arrBdgNm
	arrBdgNm = split("슈퍼 코멘터||기프트 초이스||위시 메이커||포토 코멘터||브랜드 쿨!||얼리버드||세일헌터||스타일리스트||컬러홀릭||텐텐 트윅스||카테고리 마스터||톡! 엔젤||10월 스페셜||11월 스페셜||12월 스페셜","||")

	if chkArrValue(arrUid,uid) then
		tmpBdg = chkArrSelVal(arrUid,arrBno,uid)
		tmpBdg = split(tmpBdg,"||")

		'strRst = "<p class=""badgeView"">"
		strRst = ""

		for i=0 to ubound(tmpBdg)
			strRst = strRst & " <span><img src=""http://fiximage.10x10.co.kr/web2015/common/badge/badge15_" & Num2Str(tmpBdg(i),2,"0","R") & ".png"" title=""" & arrBdgNm(tmpBdg(i)-1) & """ /></span>"
			if i>=(pno-1) then Exit For
		next

		'strRst = strRst & "</p>"
	end if

	getUserBadgeIcon = strRst
End Function

'//텐바이텐 상품고시관련 상품후기 제외 상품		'//2013.12.26 한용민 생성
function getEvaluate_exclude_Itemyn(itemid)
	dim sqlstr, tmpexists
	tmpexists="N"
	
	if itemid="" or itemid="0" then
		getEvaluate_exclude_Itemyn=tmpexists
		exit function
	end if

	sqlstr = "exec db_board.dbo.sp_Ten_Evaluate_exclude_oneItem '"& itemid &"'"
	
	'response.write sqlstr & "<Br>"
	rsget.CursorLocation = adUseClient
	rsget.CursorType=adOpenStatic
	rsget.Locktype=adLockReadOnly
	rsget.Open sqlstr, dbget
	if Not(rsget.EOF or rsget.BOF) then
		if rsget("cnt")>0 then
			tmpexists="Y"
		end if
	else
		tmpexists="N"
	end if
	rsget.Close
	
	getEvaluate_exclude_Itemyn=tmpexists
end function

'// 이벤트 로그 저장(이벤트코드, 유저ID, IP-자동저장, 값1, 값2, 값3, 디바이스 ) '//2015.05.13 유태욱 생성
Function fnCautionEventLog(evt_code,userid,value1,value2,value3,device)
	Dim strSql
	strSql = "insert into db_log.[dbo].[tbl_caution_event_log] (evt_code, userid, refip, value1 , value2, value3, device ) values " &_
			" ('"& evt_code &"'" &_
			", '"& userid &"'" &_
			", '"& Left(request.ServerVariables("REMOTE_ADDR"),32) & "'" &_
			", '"& value1 &"'" &_
			", '"& value2 &"'" &_
			", '"& value3 &"'" &_
			", '"& device & "')"
	dbget.Execute strSql
End Function

Function getSuperCoolFestivalItemExists(itemid)
	dim strSql

	strSql = "SELECT TOP 1  itemid FROM  [db_event].[dbo].[tbl_eventitem] WHERE  evt_code in (78707) and itemid=" & CStr(itemid)
	rsget.open strSql, dbget
	If Not rsget.EOF Then
		getSuperCoolFestivalItemExists 	= true
	ELSE
		getSuperCoolFestivalItemExists 	= false
	End if
	rsget.close
End Function

'// 안전인증
function fnSafetyDivCodeName(c)
	dim r
	select case c
		case "10" : r = "전기용품 > 안전인증"
		case "20" : r = "전기용품 > 안전확인 신고"
		case "30" : r = "전기용품 > 공급자 적합성 확인"
		case "40" : r = "생활제품 > 안전인증"
		case "50" : r = "생활제품 > 안전확인"
		case "60" : r = "생활제품 > 공급자 적합성 확인"
		case "70" : r = "어린이제품 > 안전인증"
		case "80" : r = "어린이제품 > 안전확인"
		case "90" : r = "어린이제품 > 공급자 적합성 확인"
	end select
	fnSafetyDivCodeName = r
end function
%>


