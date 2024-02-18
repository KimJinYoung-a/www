<%
Class CDayAndItem
	public Fevt_code			'이벤트코드
	public Fevt_Name			'이벤트명

	private sub Class_initialize()
	End Sub

	private Sub Class_terminate()
	End Sub
End Class

Class ClsDayAnd
	public FECode
	public FIdx
	
	public FEName
	public Fevt_template
	public Fevt_mainimg
	public Fevt_html
	public Fbrand
	public Fevt_startdate
	public Fevt_enddate
	public Fevt_prizedate
	public Fiscomment
	public Fisbbs
	public Fevt_linkcode
	public Fevt_firstCd
	public Fevt_lastCd
	public Fevt_preCd
	public Fevt_NextCd
	public FfavCnt
	
	public FItemList()
	public FTotalCount
	public FResultCount
	public FCurrPage
	public FTotalPage
	public FPageSize
	public FScrollCount
	public FPageCount

	Private Sub Class_Initialize()
		FCurrPage =1
		FPageSize = 10
		FResultCount = 0
		FScrollCount = 5
		FTotalCount =0
	End Sub

	Private Sub Class_Terminate()
	End Sub

	'//데이엔드 내용 가져오기
	public Function fnGetEventCont
		Dim strSql
		IF FECode = "" THEN FECode = 0
		strSql =" [db_event].[dbo].[sp_Ten_event_DayAnd_GetContents] ("&FECode&")"
		rsget.Open strSql, dbget,  adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
		IF not rsget.EOF THEN
			FECode 			= rsget("evt_code")
			FEName		 	= rsget("evt_name")
			Fevt_template 	= rsget("evt_template")
			Fevt_mainimg 	= rsget("evt_mainimg")
			Fevt_html 		= db2html(rsget("evt_html"))
			Fbrand			= rsget("brand")
			Fevt_startdate	= rsget("evt_startdate")
			Fevt_enddate 	= rsget("evt_enddate")
			Fevt_prizedate	= rsget("evt_prizedate")
			Fiscomment		= rsget("iscomment")
			Fisbbs			= rsget("isbbs")
			Fevt_linkcode	= rsget("link_evtcode")

			Fevt_firstCd	= rsget("firstCd")
			Fevt_lastCd		= rsget("lastCd")
			Fevt_preCd		= rsget("preCd")
			Fevt_NextCd		= rsget("NextCd")
			FfavCnt			= rsget("favCnt")

		END IF	
		rsget.close
	End Function

	'//데이엔드 목록 접수
	public FSPageNo
	public FEPageNo
	public FTotCnt 
	
	public Function fnGetDayAndList()
			FSPageNo = (FPageSize*(FCurrPage-1)) + 1
			FEPageNo = FPageSize*FCurrPage	
		dim sqlStr, i

		'#목록 총개수 접수
		sqlStr = "db_event.dbo.[sp_Ten_event_DayAnd_GetListCnt] " 
		rsget.Open sqlStr, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
		IF Not (rsget.EOF OR rsget.BOF) THEN
			FTotCnt = rsget(0)
		END IF
		rsget.close

		FTotalPage = (FTotCnt\FPageSize)
		If (FTotalPage<>FTotCnt/FPageSize) Then FTotalPage = FTotalPage +1

		'#목록 접수
 		sqlStr = "db_event.dbo.[sp_Ten_event_DayAnd_GetList] (" & FSPageNo & "," & FEPageNo&")"
		rsget.Open sqlStr, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
		IF Not (rsget.EOF OR rsget.BOF) THEN
			fnGetDayAndList = rsget.getRows()
		END IF
		rsget.close 
	End Function

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
%>
