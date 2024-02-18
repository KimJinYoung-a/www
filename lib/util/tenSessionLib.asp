<%
''session library 2016/11
dim C_MaxSessionTimedOUT : C_MaxSessionTimedOUT = 60*60*14    ''2Hour 이상 적당.  세션이 날라갔을경우 쿠키로 세션을 복구할 시간 (웹서버 세션시간보다 커야함..)
dim C_ssnUpdateReCycleTime : C_ssnUpdateReCycleTime = 60*30  ''10~20분사이 적당할듯. 디비 체크 및 세션 업데이트 체크 주기 C_MaxSessionTimedOUT 보다 작아야.
dim C_LongTimeSessionTimedOUT : C_LongTimeSessionTimedOUT = 60*60*24*15 '' 15일  연결유지시
Dim GG_TEN_APP_CON_NAME : GG_TEN_APP_CON_NAME = "db_main"

IF (application("Svr_Info")="Dev") then   ''TEST
    C_MaxSessionTimedOUT = 60*60*1
    C_ssnUpdateReCycleTime = 20 ''60*20
    
end if

'IF (application("Svr_Info")="staging") then
'   '' response.write session("ssnhash")
'   '' C_MaxSessionTimedOUT = 60*60*1
'   '' C_ssnUpdateReCycleTime = 20 ''60*20
'end if

'' 2018/08/17 V2로 변경
CALL fnChkDBSessionUpdateV2()

function fnDateTimeToLongTime(icookieLoginDt)
    dim iorginDt : iorginDt = icookieLoginDt
    iorginDt = CDate(iorginDt)
    
    fnDateTimeToLongTime = Year(iorginDt)&Right("00"&Month(iorginDt),2)&Right("00"&Day(iorginDt),2)&Right("00"&Hour(iorginDt),2)&Right("00"&Minute(iorginDt),2)&Right("00"&Second(iorginDt),2)
end function

function fnLongTimeToDateTime(ilongTime)
    dim iorgDt : iorgDt= ilongTime
    if LEN(ilongTime)<>14 then 
        Exit function
    end if
        
    fnLongTimeToDateTime = CDate(LEFT(ilongTime,4)&"-"&MID(ilongTime,5,2)&"-"&MID(ilongTime,7,2)&" "&MID(ilongTime,9,2)&":"&MID(ilongTime,11,2)&":"&MID(ilongTime,13,2))
end function

''디비 세션 생성 log-on
function fnDBSessionCreate(ilgnchannel)
    dim ssnuserid  : ssnuserid =  session("ssnuserid")
    dim ssnlogindt : ssnlogindt = session("ssnlogindt")
    
    if (ssnuserid="") or (ssnlogindt="") then Exit function
        
    dim iSsnCon : set iSsnCon = CreateObject("ADODB.Connection")
    Dim cmd : set cmd = server.CreateObject("ADODB.Command")
    
    dim sqlStr
    sqlStr = "db_user.[dbo].[sp_TEN_SSN_CREATE]"
    
    iSsnCon.Open Application(GG_TEN_APP_CON_NAME) ''커넥션 스트링.
    cmd.ActiveConnection = iSsnCon
    cmd.CommandText = sqlStr
    cmd.CommandType = adCmdStoredProc
    
    cmd.Parameters.Append cmd.CreateParameter("@ssnuserid", adVarchar, adParamInput, 32, ssnuserid)
    cmd.Parameters.Append cmd.CreateParameter("@ssnlogindt", adVarchar, adParamInput, 14, ssnlogindt)
    cmd.Parameters.Append cmd.CreateParameter("@lgnchannel", adVarchar, adParamInput, 1, ilgnchannel)
   
    cmd.Execute 
    set cmd = Nothing
    iSsnCon.Close
    SET iSsnCon = Nothing
    
end function

''디비 세션 생성 log-on
function fnDBSessionCreateV2(ilgnchannel, issnExistsType)
    dim ssnuserid  : ssnuserid =  session("ssnuserid")
    dim ssnlogindt : ssnlogindt = session("ssnlogindt")
    
    if (ssnuserid="") or (ssnlogindt="") then Exit function
    
    Dim ssnkeepAddtime : ssnkeepAddtime = 0
    if (issnExistsType=1) then ssnkeepAddtime=C_LongTimeSessionTimedOUT
    Dim isessionData : isessionData = fnMakeSessionToDBData()  ''2018/08/07 세션값을 Serialize 
    
    dim iSsnCon : set iSsnCon = CreateObject("ADODB.Connection")
    Dim cmd : set cmd = server.CreateObject("ADODB.Command")
    
    dim sqlStr
    sqlStr = "db_user.[dbo].[sp_TEN_SSN_CREATE_V2]"
    
    iSsnCon.Open Application(GG_TEN_APP_CON_NAME) ''커넥션 스트링.
    cmd.ActiveConnection = iSsnCon
    cmd.CommandText = sqlStr
    cmd.CommandType = adCmdStoredProc
    
    cmd.Parameters.Append cmd.CreateParameter("@ssnuserid", adVarchar, adParamInput, 32, ssnuserid)
    cmd.Parameters.Append cmd.CreateParameter("@ssnlogindt", adVarchar, adParamInput, 14, ssnlogindt)
    cmd.Parameters.Append cmd.CreateParameter("@lgnchannel", adVarchar, adParamInput, 1, ilgnchannel)
    cmd.Parameters.Append cmd.CreateParameter("@ssnkeepAddtime", adInteger, adParamInput, , ssnkeepAddtime)
    cmd.Parameters.Append cmd.CreateParameter("@ssndata", adVarWChar, adParamInput, 384, isessionData)
    cmd.Parameters.Append cmd.CreateParameter("@retSsnHash", adVarchar, adParamOutput, 64, "")

    cmd.Execute 
    Dim iretSsnHash : iretSsnHash = cmd.Parameters("@retSsnHash").Value
    fnDBSessionCreateV2 = iretSsnHash

    set cmd = Nothing
    iSsnCon.Close
    SET iSsnCon = Nothing
    
end function

''디비세션 날림 log-off시
function fnDBSessionExpire()
    dim ssnuserid  : ssnuserid =  session("ssnuserid")
    dim ssnlogindt : ssnlogindt = session("ssnlogindt")
    
    if (ssnuserid="") or (ssnlogindt="") then Exit function
    
    dim iSsnCon : set iSsnCon = CreateObject("ADODB.Connection")
    Dim cmd : set cmd = server.CreateObject("ADODB.Command")
    dim intResult
    
    dim sqlStr
    sqlStr = "db_user.[dbo].[sp_TEN_SSN_EXPIRE]"
    
    iSsnCon.Open Application(GG_TEN_APP_CON_NAME) ''커넥션 스트링.
    cmd.ActiveConnection = iSsnCon
    cmd.CommandText = sqlStr
    cmd.CommandType = adCmdStoredProc
    
    cmd.Parameters.Append cmd.CreateParameter("returnValue", adInteger, adParamReturnValue)
    cmd.Parameters.Append cmd.CreateParameter("@ssnuserid", adVarchar, adParamInput, 32, ssnuserid)
    cmd.Parameters.Append cmd.CreateParameter("@ssnlogindt", adVarchar, adParamInput, 14, ssnlogindt)
    cmd.Execute 
    
    intResult = cmd.Parameters("returnValue").Value
    set cmd = Nothing
    iSsnCon.Close
    SET iSsnCon = Nothing
    
    fnDBSessionExpire = (intResult>0)
end function

function fnDBSessionExpireV2()
    dim ssnhash : ssnhash = session("ssnhash")
    dim cookiessnHash : cookiessnHash = request.Cookies("tinfo")("ssnhash")

    if (ssnhash="") and (cookiessnHash="") then Exit function
    if (ssnhash="") then ssnhash=cookiessnHash

    dim iSsnCon : set iSsnCon = CreateObject("ADODB.Connection")
    dim intResult
    dim sqlStr
    
    iSsnCon.Open Application(GG_TEN_APP_CON_NAME) ''커넥션 스트링.

    Dim cmd : set cmd = server.CreateObject("ADODB.Command")
    sqlStr = "db_user.[dbo].[sp_TEN_SSN_EXPIRE_V2]"
    cmd.ActiveConnection = iSsnCon
    cmd.CommandText = sqlStr
    cmd.CommandType = adCmdStoredProc
    
    cmd.Parameters.Append cmd.CreateParameter("returnValue", adInteger, adParamReturnValue)
    cmd.Parameters.Append cmd.CreateParameter("@ssnHash", adVarchar, adParamInput, 64, ssnhash)
    cmd.Execute 
    
    intResult = cmd.Parameters("returnValue").Value
    set cmd = Nothing

    iSsnCon.Close
    SET iSsnCon = Nothing
    
    fnDBSessionExpireV2 = (intResult>0)
end function

function fnCheckDBsessionUpdate(icookieUserID,icookieSsnDt,inowSsnDt,iMaxSessionTimedOUT,byRef idbssnlogindt)
    fnCheckDBsessionUpdate = false
    if (icookieUserID="") or (icookieSsnDt="") or (inowSsnDt="") then Exit function
    
    dim iSsnCon : set iSsnCon = CreateObject("ADODB.Connection")
    Dim cmd : set cmd = server.CreateObject("ADODB.Command")
    dim intResult
    
    dim sqlStr
    sqlStr = "db_user.[dbo].[sp_TEN_SSN_CHECKNUPDATE]"
    
    iSsnCon.Open Application(GG_TEN_APP_CON_NAME) ''커넥션 스트링.
    cmd.ActiveConnection = iSsnCon
    cmd.CommandText = sqlStr
    cmd.CommandType = adCmdStoredProc
    
    cmd.Parameters.Append cmd.CreateParameter("returnValue", adInteger, adParamReturnValue)
    cmd.Parameters.Append cmd.CreateParameter("@ssnuserid", adVarchar, adParamInput, 32, icookieUserID)
    cmd.Parameters.Append cmd.CreateParameter("@ssnlogindt", adVarchar, adParamInput, 14, icookieSsnDt)
    cmd.Parameters.Append cmd.CreateParameter("@updatelogindt", adVarchar, adParamInput, 14, inowSsnDt)
    cmd.Parameters.Append cmd.CreateParameter("@ssntimeoutScond", adInteger, adParamInput, , iMaxSessionTimedOUT)
    cmd.Parameters.Append cmd.CreateParameter("@retdbssnlogindt", adVarchar, adParamOutput, 14, "")
    cmd.Execute
    
    intResult = cmd.Parameters("returnValue").Value
    idbssnlogindt = cmd.Parameters("@retdbssnlogindt").Value
    
    set cmd = Nothing
    iSsnCon.Close
    SET iSsnCon = Nothing
    
    fnCheckDBsessionUpdate = (intResult>0)
end function

function fnChkDBSessionUpdate()
    dim cookieUserID    : cookieUserID = request.cookies("tinfo")("userid")         ''로그인시 값과 동일해야함.
    dim cookieSsnDt     : cookieSsnDt = request.Cookies("tinfo")("ssndt")           ''로그인시 값과 동일해야함.  tinfo 로변경.
    dim isReqSSnUp      : isReqSSnUp = false
    dim isDbssnExists   : isDbssnExists = false
    
    ''if (cookieUserID="") or (cookieSsnDt="") then Exit function
    '' cookieSsnDt 없으면 expired  2016/12/16
    if (cookieUserID="") then Exit function 
    
    dim nowDateTime     : nowDateTime=now()
    dim cookieDateTime  : cookieDateTime=fnLongTimeToDateTime(cookieSsnDt)
    
    dim ssnuserid  : ssnuserid  = session("ssnuserid")
    dim ssnlogindt : ssnlogindt = session("ssnlogindt")
    dim ssnlastcheckdt : ssnlastcheckdt = session("ssnlastcheckdt")
    dim ssnlastcheckDateTime : ssnlastcheckDateTime=fnLongTimeToDateTime(ssnlastcheckdt)
    dim nowSsnDt, dbssnlogindt
    dim isSessionExists : isSessionExists=FALSE
    
    ''세션이존재하고 최종업데이트 시간이 C_ssnUpdateReCycleTime 보다 크면 업데이트. (너무 자주업데이트 하지 않도록)
    if (LCASE(cookieUserID)=LCase(ssnuserid)) then
        if (ssnlogindt=cookieSsnDt) then
            isSessionExists = true
            isReqSSnUp = datediff("s",ssnlastcheckDateTime,nowDateTime)>C_ssnUpdateReCycleTime
        else    ''cookieSsnDt 없는경우 등. 2016/12/15 수정.
            isReqSSnUp = TRUE                   
        end if
    end if
    
    ''비정상적으로 세션이 날라갔을경우.  C_MaxSessionTimedOUT 보다 작은경우에 한해 DB에서 체크 후 세션 업데이트함.
    ''수정 세션이 없으면 무조건 체크.
    if (ssnuserid="") then
        isReqSSnUp = true
    elseif (LCASE(cookieUserID)<>LCase(ssnuserid)) then   ''2017/05/18 수정 세션이 달라도 체크  Expire ** 2017/05/26
        Call CookieSessionExpire("9")
        Exit function
    end if

    if (isReqSSnUp) then
        ''DB에 값이 있는지 체크.
        nowSsnDt = fnDateTimeToLongTime(nowDateTime)
        isDbssnExists = fnCheckDBsessionUpdate(cookieUserID,cookieSsnDt,nowSsnDt,C_MaxSessionTimedOUT,dbssnlogindt)
        
        if (isDbssnExists) then ''세션 업데이트.
            if (NOT isSessionExists) then
                session("ssnuserid") = cookieUserID
                session("ssnlogindt") = dbssnlogindt    ''기존 세션에 있는 
            END IF
            session("ssnlastcheckdt") = nowSsnDt    ''다시체크를 위해업데이트
        else
            ''쿠키 /세션 날림.
            Call CookieSessionExpire("")
        end if
    end if
end function

function fnCheckDBsessionUpdateV2(icookieSsnhash,icookieSsnDt,inowSsnDt,iMaxSessionTimedOUT,byRef iloginuserid, byRef iretssndata)
    fnCheckDBsessionUpdateV2 = false
    if (icookieSsnhash="") or (icookieSsnDt="") then Exit function
    
    dim iSsnCon : set iSsnCon = CreateObject("ADODB.Connection")
    Dim cmd : set cmd = server.CreateObject("ADODB.Command")
    dim intResult
    
    dim sqlStr
    sqlStr = "db_user.[dbo].[sp_TEN_SSN_CHECKNUPDATE_V2]"
    
    iSsnCon.Open Application(GG_TEN_APP_CON_NAME) ''커넥션 스트링.
    cmd.ActiveConnection = iSsnCon
    cmd.CommandText = sqlStr
    cmd.CommandType = adCmdStoredProc
    
    cmd.Parameters.Append cmd.CreateParameter("returnValue", adInteger, adParamReturnValue)
    cmd.Parameters.Append cmd.CreateParameter("@ssnhash", adVarchar, adParamInput, 64, icookieSsnhash)
    cmd.Parameters.Append cmd.CreateParameter("@ssnlogindt", adVarchar, adParamInput, 14, icookieSsnDt)
    cmd.Parameters.Append cmd.CreateParameter("@ssntimeoutScond", adInteger, adParamInput, , iMaxSessionTimedOUT)
    cmd.Parameters.Append cmd.CreateParameter("@retloginuserid", adVarchar, adParamOutput, 32, "")
    cmd.Parameters.Append cmd.CreateParameter("@retssndata", adVarWchar, adParamOutput, 384, "")
    cmd.Execute
    
    intResult = cmd.Parameters("returnValue").Value
    iloginuserid = cmd.Parameters("@retloginuserid").Value
    iretssndata = cmd.Parameters("@retssndata").Value
    
    set cmd = Nothing
    iSsnCon.Close
    SET iSsnCon = Nothing
    
    fnCheckDBsessionUpdateV2 = (intResult>0)
end function

function fnChkDBSessionUpdateV2()
    dim cookieSsnhash    : cookieSsnhash = request.cookies("tinfo")("ssnhash")         ''로그인시 값과 동일해야함.
    dim cookieSsnDt     : cookieSsnDt = request.Cookies("tinfo")("ssndt")             ''로그인시 값과 동일해야함.  tinfo 로변경.
    dim isReqSSnUp      : isReqSSnUp = false
    dim isDbssnExists   : isDbssnExists = false
    
    dim ssnuserid  : ssnuserid  = session("ssnuserid")
    dim ssnhash : ssnhash = session("ssnhash")
    
    '' cookieSsnhash 는 로그인된경우 무조건 있다고 본다.
    if (cookieSsnhash="") and (ssnuserid<>"") then
        session("ssnuserid") = ""
        session.abandon
    end if 

    if (cookieSsnhash="") then Exit function 
 
    ''제외할 경로는 여기에 넣자. =====================================================================
    'Dim iCurrPage : iCurrPage = LCASE(request.ServerVariables("SCRIPT_NAME")) 
    'if (LEFT(iCurrPage,LEN("/login/dologin.asp")) = "/login/dologin.asp") then Exit function 
    '''===========================================================================================

    dim nowDateTime     : nowDateTime=now()
    dim cookieDateTime  : cookieDateTime=fnLongTimeToDateTime(cookieSsnDt)
    
    dim ssnlogindt : ssnlogindt = session("ssnlogindt")
    dim ssnlastcheckdt : ssnlastcheckdt = session("ssnlastcheckdt")
    dim ssnlastcheckDateTime : ssnlastcheckDateTime=fnLongTimeToDateTime(ssnlastcheckdt)
    dim nowSsnDt, iretssndata, iloginuserid
    dim isSessionExists : isSessionExists=FALSE
    
    
    ''세션이존재하고 최종업데이트 시간이 C_ssnUpdateReCycleTime 보다 크면 업데이트. (너무 자주업데이트 하지 않도록)
    if (LCASE(cookieSsnhash)=LCase(ssnhash)) then
        isSessionExists = true
        isReqSSnUp = datediff("s",ssnlastcheckDateTime,nowDateTime)>C_ssnUpdateReCycleTime
    else    ''cookieSsnDt 없는경우 등. 2016/12/15 수정.
        isReqSSnUp = TRUE                   
    end if

    if (ssnhash="") then
        isReqSSnUp = true
    elseif (LCASE(cookieSsnhash)<>LCase(ssnhash)) then   '' 다르면 안됨.
        Call CookieSessionExpire("9")
        Exit function
    end if
    
    ''세션이 날라간 경우는 다시 불러와야 한다.
    if (ssnuserid="") or (ssnlogindt="") then 
        isReqSSnUp = TRUE
    end if

    ''DB에 값이 있는지 체크 후 DB 값으로 재세팅.
    if (isReqSSnUp) then
        nowSsnDt = fnDateTimeToLongTime(nowDateTime)
        isDbssnExists = fnCheckDBsessionUpdateV2(cookieSsnhash,cookieSsnDt,nowSsnDt,C_MaxSessionTimedOUT,iloginuserid,iretssndata)
        
        if (isDbssnExists) then ''세션 업데이트.
            session("ssnlastcheckdt") = nowSsnDt    ''다시체크를 위해업데이트
            session("ssnhash") = cookieSsnhash
            if (ssnuserid<>"") and (LCASE(ssnuserid)<>LCASE(iloginuserid)) then ''이런경우는 좀..
                Call CookieSessionExpire("2")
                exit function
            end if

            Call fnRestoreSessionFromDBData(iretssndata)

            if (LCASE(session("ssnuserid"))<>LCASE(iloginuserid)) then  ''이런경우도 좀.
                Call CookieSessionExpire("3")
                exit function
            end if
            
        else
            ''쿠키 /세션 날림.
            Call CookieSessionExpire("1")
        end if
    end if
end function

function fnIsSessionCookieValid()
    ''쿠키가 있는경우만. 비로그인은 제외
    if (request.cookies("tinfo")("userid")<>"") then
        fnIsSessionCookieValid = (LCASE(request.cookies("tinfo")("userid"))=LCASE(session("ssnuserid")))
    else
        fnIsSessionCookieValid = true    
    end if
end function

function CookieSessionExpire(nk)
    Dim iCookieDomain : iCookieDomain = "10x10.co.kr"
    IF application("Svr_Info")="Dev" THEN
        if (request.ServerVariables("LOCAL_ADDR")="::1") or (request.ServerVariables("LOCAL_ADDR")="127.0.0.1") then
            iCookieDomain = "localhost"
        end if
    End if

    ''log-out
    response.Cookies("tinfo").domain = iCookieDomain
    response.Cookies("tinfo") = ""
    response.Cookies("tinfo").Expires = Date - 1
    
    response.Cookies("etc").domain = iCookieDomain
    response.Cookies("etc") = ""
    response.Cookies("etc").Expires = Date - 1
 
    session.abandon
    
    ''addLog 추가 로그 //2016/12/16
    dim iAddLogs
    iAddLogs = "r=snexpire"&nk
    if (request.ServerVariables("QUERY_STRING")<>"") then iAddLogs="&"&iAddLogs
    response.AppendToLog iAddLogs

end function


'' 세션값이 변경될경우 DB 세션값을 변경한다. 이름,이메일,레벨
function fnEtcSessionChangedToDBSessionUpdate()
    dim ssnuserid  : ssnuserid =  session("ssnuserid")
    dim ssnlogindt : ssnlogindt = session("ssnlogindt")
    dim ssnhash : ssnhash = session("ssnhash")
    Dim isessionData : isessionData = fnMakeSessionToDBData() 

    dim iSsnCon : set iSsnCon = CreateObject("ADODB.Connection")
    Dim cmd : set cmd = server.CreateObject("ADODB.Command")
    dim intResult
    
    if (ssnhash="") then Exit function

    dim sqlStr
    sqlStr = "db_user.[dbo].[sp_TEN_SSN_SET_V2]"
    
    iSsnCon.Open Application(GG_TEN_APP_CON_NAME) ''커넥션 스트링.
    cmd.ActiveConnection = iSsnCon
    cmd.CommandText = sqlStr
    cmd.CommandType = adCmdStoredProc
    
    cmd.Parameters.Append cmd.CreateParameter("returnValue", adInteger, adParamReturnValue)
    cmd.Parameters.Append cmd.CreateParameter("@ssnhash", adVarchar, adParamInput, 64, ssnhash)
    cmd.Parameters.Append cmd.CreateParameter("@ssnuserid", adVarchar, adParamInput, 32, ssnuserid)
    cmd.Parameters.Append cmd.CreateParameter("@ssnlogindt", adVarchar, adParamInput, 14, ssnlogindt)
    cmd.Parameters.Append cmd.CreateParameter("@ssndata", adVarWChar, adParamInput, 384, isessionData)
    cmd.Execute 
    
    set cmd = Nothing
    iSsnCon.Close
    SET iSsnCon = Nothing

end function
''2018/08/07 DB저장할 세션값 Serialize
function fnMakeSessionToDBData()
    Dim retData
    Dim ispliter : ispliter = "||"
    retData = ""
    retData = retData & "ssnuserid=="&session("ssnuserid")&ispliter
    retData = retData & "ssnlogindt=="&session("ssnlogindt")&ispliter
    retData = retData & "ssnusername=="&replace(session("ssnusername"),ispliter,"")&ispliter
    retData = retData & "ssnuserdiv=="&session("ssnuserdiv")&ispliter
    retData = retData & "ssnuserlevel=="&session("ssnuserlevel")&ispliter
	retData = retData & "ssnrealnamecheck=="&session("ssnrealnamecheck")&ispliter
    retData = retData & "ssnuseremail=="&replace(session("ssnuseremail"),ispliter,"")&ispliter
    retData = retData & "ssnisAdult=="&chkIIF(session("isAdult"),"Y","N")&ispliter
    retData = retData & "ssnuserbizconfirm=="&session("ssnuserbizconfirm")&ispliter
    fnMakeSessionToDBData = retData
end function

''2018/08/07 DB저장 세션값 DeSerialize
function fnRestoreSessionFromDBData(idata)
    Dim ispliter : ispliter = "||"
    Dim iArrData, i, iOneRows

    if isNULL(idata) then Exit function
    if Len(idata)<1 then Exit function

    iArrData = split(idata,ispliter)

    if NOT isArray(iArrData) then Exit function

    for i=LBound(iArrData) to UBound(iArrData)
        iOneRows = iArrData(i)
        Call AssignSessionByOneSsnData(iOneRows)
    Next
end function

Sub AssignSessionByOneSsnData(ioneRow)
    if isNULL(ioneRow) then Exit Sub
    if Len(ioneRow)<1 then Exit Sub

    dim issnName, issnValue
    dim isplitedVar

    isplitedVar = split(ioneRow,"==")
    if NOT isArray(isplitedVar) then Exit Sub

    if UBound(isplitedVar)<1 then Exit Sub
    
    issnName  = isplitedVar(0)
    issnValue = isplitedVar(1)
    if (issnName="") then Exit Sub

    if issnName = "ssnisAdult" then
        session("isAdult") = (issnValue="Y")
    else
        session(issnName) = issnValue
    end if
end Sub

''자동로그인 및 장기로그인 접속자로그인 날짜를 업뎃
public function fnReSetSsnLoginDt(inowSsnDt)
    Dim idtauto : idtauto = request.cookies("tinfo")("dtauto")
    if (idtauto="") then Exit function ''자동로그인인경우 만 로그를 쌓자.
	if (NOT IsNumeric(idtauto)) then Exit function

    if NOT (LEFT(inowSsnDt,8)>LEFT(idtauto,8)) then Exit function '' 날짜가 지난경우만 상관있음.

    dim ssnuserid  : ssnuserid =  session("ssnuserid")
    dim ssnlogindt : ssnlogindt = session("ssnlogindt")
    dim ssnhash : ssnhash = session("ssnhash")

    fnReSetSsnLoginDt = FALSE
    if (ssnhash="") or (ssnlogindt="") or (ssnuserid="") then Exit function

    dim iSsnCon : set iSsnCon = CreateObject("ADODB.Connection")
    Dim cmd : set cmd = server.CreateObject("ADODB.Command")
    dim intResult, ssnkeepAddtime : ssnkeepAddtime = 0

    Dim irefip : irefip = Request.ServerVariables("REMOTE_ADDR")
    Dim isiteDiv : isiteDiv = "ten_www_auto"
    Dim ilgnGuid : ilgnGuid = LEFT(fn_getGgsnCookie(),40)

    dim sqlStr
    sqlStr = "db_user.[dbo].[sp_TEN_SSN_Auto_LoginSET]"
    
    iSsnCon.Open Application(GG_TEN_APP_CON_NAME) ''커넥션 스트링.
    cmd.ActiveConnection = iSsnCon
    cmd.CommandText = sqlStr
    cmd.CommandType = adCmdStoredProc
    
    cmd.Parameters.Append cmd.CreateParameter("returnValue", adInteger, adParamReturnValue)
    cmd.Parameters.Append cmd.CreateParameter("@ssnhash", adVarchar, adParamInput, 64, ssnhash)
    cmd.Parameters.Append cmd.CreateParameter("@ssnuserid", adVarchar, adParamInput, 32, ssnuserid)
    cmd.Parameters.Append cmd.CreateParameter("@ssnlogindt", adVarchar, adParamInput, 14, ssnlogindt)
    cmd.Parameters.Append cmd.CreateParameter("@ssntimeoutScond", adInteger, adParamInput, , C_MaxSessionTimedOUT)

    cmd.Parameters.Append cmd.CreateParameter("@refip", adVarchar, adParamInput, 16, irefip)
    cmd.Parameters.Append cmd.CreateParameter("@siteDiv", adVarchar, adParamInput, 16, isiteDiv)
    cmd.Parameters.Append cmd.CreateParameter("@chkDevice", adVarchar, adParamInput, 1, "W")
    cmd.Parameters.Append cmd.CreateParameter("@lgnGuid", adVarchar, adParamInput, 40, ilgnGuid)
    
    cmd.Parameters.Append cmd.CreateParameter("@ssnkeepAddtime", adInteger, adParamOutput, 0)

    cmd.Execute 
    
    intResult = cmd.Parameters("returnValue").Value
    ssnkeepAddtime = cmd.Parameters("@ssnkeepAddtime").Value

    set cmd = Nothing
    iSsnCon.Close
    SET iSsnCon = Nothing

    Dim iCookieDomain : iCookieDomain = "10x10.co.kr"
    IF application("Svr_Info")="Dev" THEN
        if (request.ServerVariables("LOCAL_ADDR")="::1") or (request.ServerVariables("LOCAL_ADDR")="127.0.0.1") then
            iCookieDomain = "localhost"
        end if
    End if
    
    if (intResult>0) then
        '' reSET dtauto DT
        response.Cookies("tinfo").domain = iCookieDomain
        response.cookies("tinfo")("dtauto") = inowSsnDt

        if (ssnkeepAddtime>0) and (CLNG(ssnkeepAddtime/(60*60*24))>0) then   ''원래 세팅한 값 만큼 추가로 지정해 준다.
            response.cookies("tinfo").Expires = Date + CLNG(ssnkeepAddtime/(60*60*24))
        end if

        fnReSetSsnLoginDt = True
    end if
end function
public function addClassStr(originalClass, classToAdd)
    dim whiteSpace, classStr    
    whiteSpace = " "

    if classToAdd = "" then
        exit function        
    end if

    if originalClass <> "" then
        classStr = originalClass & whiteSpace & classToAdd    
    else
        classStr = classToAdd    
    end if

    addClassStr = classStr
end function
%>