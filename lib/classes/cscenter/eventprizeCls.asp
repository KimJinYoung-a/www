<%
Class CEventPrize
	public FUserid
	public FCPage
	public FPSize
	public FTotCnt
	public FResultCount

	public FGubun
	public FWinnerOX

	public Function fnGetEventPrizeList
		Dim strSql,iDelCnt
		strSql = " [db_event].[dbo].sp_Ten_event_winner_listCnt ('"&FUserid&"') "
		rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
		IF not rsget.EOF THEN
			FTotCnt = rsget(0)
		END IF

		rsget.close
		FResultCount = FTotCnt
		IF FTotCnt > 0 THEN
			iDelCnt =  ((FCPage - 1) * FPSize )+1
			strSql = " [db_event].[dbo].sp_Ten_event_winner_list ('"&iDelCnt&"','"&FPSize&"','"&FUserid&"') "
			rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
		IF not rsget.EOF THEN
			fnGetEventPrizeList =rsget.getRows()
		END IF
		rsget.close
		END IF
	End Function

	public Function fnGetEventPrizeLastOne
		Dim strSql,iDelCnt
		strSql = " [db_event].[dbo].sp_Ten_event_winner_last_one ('"&FUserid&"') "

		rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
		IF not rsget.EOF THEN
			FResultCount = 1
			fnGetEventPrizeLastOne =rsget.getRows()
		END IF
		rsget.close

	End Function

	public Function fnGetEventCheckPrice
		Dim strSql
		strSql = " [db_event].[dbo].sp_Ten_event_winner_CheckCnt ('"&FUserid&"') "
		rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
		IF not rsget.EOF THEN
			FTotCnt = rsget(0)
		END IF

		rsget.close
		FResultCount = FTotCnt
	End Function


	public Function fnGetTesterEventCheck
		Dim strSql
		strSql = " [db_event].[dbo].sp_Ten_TesterWinner_Check ('"&FUserid&"') "
		rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
		IF not rsget.EOF THEN
			FTotCnt = rsget(0)
		END IF

		rsget.close
		FResultCount = FTotCnt
	End Function


	public Function fnGetEventJoinList
		Dim strSql,iDelCnt
		strSql = " [db_event].[dbo].sp_Ten_event_join_listCnt ('"&FGubun&"','"&FUserid&"','"&FWinnerOX&"') "
		rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
		IF not rsget.EOF THEN
			FTotCnt = rsget(0)
		END IF

		rsget.close
		FResultCount = FTotCnt
		IF FTotCnt > 0 THEN
			iDelCnt =  (FCPage - 1) * FPSize
			strSql = " [db_event].[dbo].sp_Ten_event_join_list ('"&FGubun&"','"&iDelCnt&"','"&FPSize&"','"&FUserid&"','"&FWinnerOX&"') "
			'response.write strSql
			rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
		IF not rsget.EOF THEN
			fnGetEventJoinList =rsget.getRows()
		END IF
		rsget.close
		END IF
	End Function

	public FPrizeType
	public FStatus
	public FStatusDesc
	public FSongjangno
	public FreqDeliverDate
	public FConfirm
	public FSongjangid
	public FPCode

	'-----------------------------------------------------------------------
	' fnSetStatus : 이벤트 공통코드 가져오기
	'-----------------------------------------------------------------------
	public Function fnSetStatus
		FStatusDesc ="-"
		FConfirm ="-"
	IF FPrizeType = 2 THEN
        FStatusDesc="쿠폰발급완료"
	ELSEIF FPrizeType = 3 OR FPrizeType = 5 THEN
        IF FStatus = 0 THEN
           FStatusDesc ="배송지입력대기"
           FConfirm="<a href="""" onclick=""PopOpenEventSongjangEdit('"&FSongjangid&"');return false;"">배송지입력하기</a>"
        ELSEIF FStatus = 3 THEN
            IF  FSongjangno <> "" THEN
            	FStatusDesc="출고완료"
            	FConfirm = "<a href="""" onclick=""PopOpenEventSongjangView('"&FSongjangid&"');return false;"">배송지입력완료</a>"
            ELSE
            	FStatusDesc="상품준비중"
            	if DateDiff("d",FreqDeliverDate,date)<0 then  '' 기존 -2 => 0 으로 수정 2015/07/02 by eastone
            		FConfirm = "<a href="""" onclick=""PopOpenEventSongjangEdit('"&FSongjangid&"');return false;"">배송지변경</a>"
            	else
            		FConfirm = "<a href="""" onclick=""PopOpenEventSongjangView('"&FSongjangid&"');return false;"">배송지입력완료</a>"
            	end if
            END IF
        END IF
      END IF
	End Function
End Class

'-----------------------------------------------------------------------
' fnGetCommCodeArrDesc : 특정종류의 공통코드값의 배열에서 특정값의 코드명 가져오기
'-----------------------------------------------------------------------
	Function fnGetCommCodeArrDesc(ByVal arrCode, ByVal iCodeValue)
		Dim intLoop
		IF iCodeValue = "" or isNull(iCodeValue) THEN iCodeValue = -1
		For intLoop =0 To UBound(arrCode,2)
			IF Cint(iCodeValue) = arrCode(0,intLoop) THEN
				fnGetCommCodeArrDesc = arrCode(1,intLoop)
				Exit For
			END IF
		Next
	End Function


	Function fnGetCommCodeArrDescCulture(ByVal iCodeValue)
		select Case iCodeValue
			Case 0	'느껴봐
			 	fnGetCommCodeArrDescCulture = "느껴봐"
			Case 1	'읽어봐
				fnGetCommCodeArrDescCulture = "읽어봐"
			Case 2	'들어봐
				fnGetCommCodeArrDescCulture = "들어봐"
			Case Else
				fnGetCommCodeArrDescCulture = ""
		End Select
	End Function

'-----------------------------------------------------------------------
' fnSetCommonCodeArr : 이벤트 공통코드 가져오기
'-----------------------------------------------------------------------
 Function fnSetCommonCodeArr(ByVal code_type, ByVal blnUse)
	Dim strSql, arrList, intLoop, strAdd
	Dim intI, intJ, arrCode(), strtype
	strAdd = ""
	IF blnUse THEN
		strAdd= " and code_using ='Y' "
	END IF
	strSql = " SELECT code_value, code_desc FROM [db_event].[dbo].[tbl_event_commoncode] WHERE code_type='"&code_type&"'"&strAdd&_
			" Order by code_type, code_sort "
	rsget.Open strSql,dbget
	IF not rsget.EOF THEN
		fnSetCommonCodeArr = rsget.getRows()
	END IF
	rsget.close
End Function

'-----------------------------
' GetEventURLLink : 이벤트 링크
' ex)GetEventURLLink(vGubun,arrList(1,intLoop),arrList(9,intLoop),arrList(8,intLoop),arrList(11,intLoop),arrList(12,intLoop),arrList(7,intLoop))
'---------------------------
function GetEventURLLink(eType,gCd,eCd,lnkTp,lnkUrl,przNm)
	Dim strGoUrl

	select Case eType
		Case 5	'컬쳐스테이션
			strGoUrl = " /culturestation/culturestation_event.asp?evt_code="&gCd
		Case 6	'디자인파이터
			strGoUrl = " /culturestation/culturestation_event.asp?idx="&gCd
		Case 7	'위클리코디네이터
			strGoUrl = "/guidebook/weekly_coordinator.asp?eventid="&eCd
		Case 11	'디자인핑거스
			strGoUrl = "/designfingers/designfingers.asp?fingerid="&gCd
		Case 19	'모바일이벤트
			strGoUrl = ""
		Case Else
			If lnkTp = "I" then
				strGoUrl = lnkUrl
			Else
				strGoUrl = "/event/eventmain.asp?eventid="&eCd
			End If
	End Select

	If eType = "12" Then	'### 구분이 전체일경우
		strGoUrl = przNm
	Else
		strGoUrl = "<a href='" & strGoUrl & "'>" & przNm & "</a>"
	End If

	'결과반환
	GetEventURLLink = strGoUrl
end function

'-----------------------------
' GetEventSongjangURL : 송장 링크
'---------------------------
function GetEventSongjangURL(songjangurl, songjangno)
	if IsNull(songjangurl) then
		songjangurl = ""
	end if
	if IsNull(songjangno) then
		songjangno = ""
	end if

	songjangno = Replace(songjangno, "-", "")

	if (songjangno = "") then
		GetEventSongjangURL = ""
		exit function
	end if

	if (songjangurl = "") then
		GetEventSongjangURL = "송장오류"
		exit function
	end if

	GetEventSongjangURL = "<a href=" & db2html(songjangurl) & songjangno & " title=""새창에서 열림"" target=""_blank"">" & songjangno & "</a>"
end function
%>
