<%
Class DrawEventCls

	public evtCode
	public winPercent	
	public range	
	public randomNumber	
	public drawResult	
	public userid
	public refip	
	public device
	public winnerLimit
	public testMode
	public totalResult
	public testPopulation
	'--리턴 코드
	' 10 - 이벤트 당첨자
	' 20 - 금일 응모자
	' 30 - 당첨
	' 40 - 꽝, 당첨자 도달(꽝)
	' 50 - 매개변수값 없음
	' 60 - 실행메서드 실행안함

	'랜덤번호 추출
	Private sub getRandomNumber()
		dim ranNum

		randomize
		ranNum = int(Rnd*range)+1
		randomNumber = ranNum
	end sub
    '당첨여부
	Private sub compareDice()		
		if randomNumber <= winPercent then
			drawResult = true
		else
			drawResult = false
		end if
	end sub
	
	'실행 메서드 (일일 실시간 당첨로직)
    '1. 유효성체크
	'2. 일 max당첨자 확인
	'3. 금일 응모 확인
	'4. 당첨자인지 확인
	'5. 당첨 로직 실행, 당첨결과 멤버변수에 저장
	'6. 유저 응모 로그 삽입
	'7. 당첨결과 db저장	
	public sub execDraw() 'day base 이벤트		
		if not testMode then		
			if chkValidation() then
				totalResult = 50			
				exit sub
			end if					
			'일 max 당첨여부 확인
			if isLimitDayBase() then '당첨자 도달시
				execResult(0)
				totalResult = 40
				exit sub
			end if

			'금일 응모 확인
			if isParticipationDayBase() then '금일 응모확인				
				totalResult = 20
				exit sub
			end if

			'당첨자인지 확인
			if isWinner() then '이벤트 당첨자인지 확인.
				execResult(0)
				totalResult = 10
				exit sub
			end if

		end if	

		'실행		
		getRandomNumber()
		compareDice()
		insertLog()

		if drawResult then	'당첨시
			if isLimitDayBase() then '당첨자 도달 한번 더 체크
				execResult(0)
				totalResult = 40
				exit sub
			end if		
			execResult(1)
			totalResult = 30
		else '실패시
			execResult(0)
			totalResult = 40
		end if
	end sub

	public function test()
		dim i
		for i = 0 to testPopulation			
			getRandomNumber()
			compareDice()
			response.write drawEvt.drawResult
			response.write drawEvt.randomNumber & "<br>"	
		next					
	end function

	private function chkValidation()
		dim result
		result = false

		if (evtCode = "") or (winPercent = "") or (userid = "") or (winnerLimit = "") then			
			result = true
			chkValidation = result
		end if
	end function

	'유저 응모 로그 삽입
	Private sub insertLog()
		dim sqlStr 

		sqlStr = "INSERT INTO db_log.[dbo].[tbl_caution_event_log] (evt_code , userid , refip ,value1,  value3, device)" & vbcrlf
		sqlStr = sqlStr & " VALUES("& evtCode &", '"& userid &"' ,'"&refip&"','"&randomNumber&"', '"&drawResult&"', '"&device&"')"
		dbget.execute sqlStr
	end sub

	'일 max 당첨자 도달 여부
	Private function isLimitDayBase()
		dim result, sqlstr, icnt
		result = false

		sqlstr = "select count(*) as icnt FROM [db_event].[dbo].[tbl_event_subscript] WHERE evt_code="& evtCode &" and sub_opt1 = 1 and datediff(day,regdate,getdate()) = 0 "
		rsget.Open sqlstr, dbget, 1
			icnt = rsget("icnt")
		rsget.close

		If icnt >= winnerLimit Then 		
			result = true
		Else		
			result = false
		End If 		

		isLimitDayBase = result
	end function

	'당첨 여부 체크
	public function isWinner()
		dim result, sqlstr, icnt
		result = false
		'sub_opt1 : 1 - 당첨
		'		  : 0 - 실패
		sqlstr = "select count(*) as icnt FROM [db_event].[dbo].[tbl_event_subscript] WHERE evt_code="& evtCode &" and userid='"&userid&"' and sub_opt1 = 1 "
		rsget.Open sqlstr, dbget, 1
			icnt = rsget("icnt")
		rsget.close

	If icnt >= 1 Then 		
		result = true
	Else		
		result = false
	End If 		
		isWinner = result
	end function

	'당일 응모 내역 체크	
	public function isParticipationDayBase()
		dim result, sqlstr, icnt
		result = false
		
		sqlstr = "select count(*) as icnt FROM [db_event].[dbo].[tbl_event_subscript] WHERE evt_code="& evtCode &" and userid='"&userid&"' and datediff(day,regdate,getdate()) = 0 "
		rsget.Open sqlstr, dbget, 1
			icnt = rsget("icnt")
		rsget.close

	If icnt >= 1 Then 		
		result = true
	Else		
		result = false
	End If 
		isParticipationDayBase = result
	end function

	'일별 참여자수
	public function getParticipantsPerDay()	
		dim SqlStr

		sqlStr = "SELECT convert(char(10), regdate, 23) as date "
		sqlStr = sqlStr & "     , count(*) as cnt						 "
		sqlStr = sqlStr & "     , isnull(sum(case when sub_opt1 = '1' then 1 else 0 end),0) as winnercnt "		
		sqlStr = sqlStr & "   from db_event.dbo.tbl_event_subscript as a "	
		sqlStr = sqlStr & "  where evt_code = '"& CStr(evtCode) &"'            "	
		sqlStr = sqlStr & "  group by convert(char(10), regdate, 23)	 "
		sqlStr = sqlStr & "  order by date desc							 "	

		'response.write sqlStr &"<br>"
		'response.end
		
		rsget.CursorLocation = adUseClient
        rsget.Open sqlStr, dbget, adOpenForwardOnly, adLockReadOnly
		
 		if not rsget.EOF then
		    getParticipantsPerDay = rsget.getRows()	
		end if
		rsget.close			
	End function

	'결과 처리
	Private sub execResult(isWin)
		dim sqlstr, icnt
		'isWin : 1 - 당첨
		'	   : 0 - 실패
		sqlStr = "INSERT INTO [db_event].[dbo].[tbl_event_subscript] (evt_code , userid , sub_opt1 , device)" & vbcrlf
		sqlStr = sqlStr & " VALUES("& evtCode &", '"& userid &"', '"&isWin&"', '"&device&"')"
		dbget.execute sqlStr
	end sub		

    Private Sub Class_Initialize()	
		range = 1000
		refip = Request.ServerVariables("REMOTE_ADDR")	
		totalResult = 60
		testMode = false
	End Sub	
	Private Sub Class_Terminate()
    End Sub	

end Class
%>
