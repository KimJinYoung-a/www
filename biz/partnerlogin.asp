<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%Response.Addheader "P3P","policyref='/w3c/p3p.xml', CP='NOI DSP LAW NID PSA ADM OUR IND NAV COM'"%>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbEVTopen.asp" -->
<!-- #include virtual="/lib/db/dbHelper.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/memberlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/membercls/userloginclass.asp" -->
<!-- #include virtual="/lib/classes/membercls/clsMyAnniversary.asp" -->
<!-- #include virtual="/lib/classes/cscenter/eventprizeCls.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/tenEncUtil.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/util/base64.asp" -->
<%
    Dim partnerReferer : partnerReferer = Request.ServerVariables("HTTP_REFERER")
    Dim v, ouser, ssnlogindt, sqlStr, chkLoginFailCnt, userid
    v = Request("v")

    'scm에서 온게 아니라면 리턴
    If InStr(partnerReferer, "scm.10x10.co.kr") <= 0 Then
        Response.Redirect wwwUrl
        Response.End
    End If
    
    ' 이미 로그인 되어 있으면 biz로
    If GetLoginUserID <> "" Then
        If GetLoginUserLevel() = "7" OR GetLoginUserLevel() = "9" Then
            ' Biz모드 on
            Response.Cookies("bizMode").domain = "10x10.co.kr"
            Response.Cookies("bizMode") = "Y"
            Response.Redirect wwwUrl & "/biz/"
            Response.End
        Else
            Response.Redirect wwwUrl
            Response.End
        End If
    End If

    On Error Resume Next
    
    Dim data, httpRequest, postResponse, key, iv
    key = "tenbytentenbytentenbyten"
    iv = "tenbytentenbyten"

    data = "text=" & Server.URLEncode(v)
    data = data & "&key=" & key
    data = data & "&iv=" & iv

    Set httpRequest = Server.CreateObject("MSXML2.ServerXMLHTTP")
    httpRequest.Open "POST", "https://fapi.10x10.co.kr/api/web/v1/encode/decodeAes128", False
    httpRequest.SetRequestHeader "Content-Type", "application/x-www-form-urlencoded"
    httpRequest.Send data
    
    set ouser = new CTenUser
    ouser.FRectEnc = TRUE
    ouser.FPartnerLoginValue = httpRequest.ResponseText

    if Err.Number > 0 then
        Response.Redirect wwwUrl & "/login/loginpage.asp?backpath=" & server.URLEncode("/biz/")
        Response.End
    end if
    
    ouser.LoginProc

    ' 로그인 성공
    If (ouser.IsPassOk) Then
        Dim iCookieDomainName : iCookieDomainName = GetCookieDomainName
        '// 로그인 정보 저장/처리
        response.Cookies("tinfo").domain = iCookieDomainName
        
        ''201007 추가 로그인아이디 해시값
        response.Cookies("tinfo")("shix") = HashTenID(ouser.FOneUser.FUserID)

        response.Cookies("etc").domain = iCookieDomainName ''"10x10.co.kr"
        response.cookies("etc")("couponCnt") = ouser.FOneUser.FCouponCnt
        response.cookies("etc")("currentmile") = ouser.FOneUser.FCurrentMileage
        response.cookies("etc")("currtencash") = ouser.FOneUser.FCurrentTenCash
        response.cookies("etc")("currtengiftcard") = ouser.FOneUser.FCurrentTenGiftCard
        response.cookies("etc")("currtcardpoint") = ouser.FOneUser.FCurrentcardpoint		''10x10멤버쉽 카드포인트 2017-06-27 유태욱
        response.cookies("etc")("currtcardyn") = ouser.FOneUser.FCurrentcardyn			''10x10멤버쉽 카드보유여부 2017-06-27 유태욱
        response.cookies("etc")("cartCnt") = ouser.FOneUser.FBaguniCount		'201004 추가 장바구니갯수.
        response.Cookies("etc")("ordCnt") = ouser.FOneUser.ForderCount		'201409 추가 최근주문/배송수
        response.Cookies("etc")("usericon") = ouser.FOneUser.FUserIcon
        response.cookies("etc")("usericonNo") = ouser.FOneUser.FUserIconNo
        response.Cookies("etc")("logindate") = now()
        response.Cookies("etc")("ConfirmUser") = ouser.FConfirmUser

        response.Cookies("mSave").domain = iCookieDomainName ''"10x10.co.kr"
        response.cookies("mSave").Expires = Date + 30	'1개월간 쿠키 저장
        If request("saved_id") = "o" Then
            response.cookies("mSave")("SAVED_ID") = tenEnc(userid)
        Else
            response.cookies("mSave")("SAVED_ID") = ""
        End If

        ssnlogindt = fnDateTimeToLongTime(now())                            ''2016/12/28 추가
        response.Cookies("tinfo")("ssndt") = ssnlogindt                     ''2016/12/28

        ''## 보안강화 세션 처리 2016/11/09=================================
        session("ssnuserid")  = LCase(ouser.FOneUser.FUserID)
        session("ssnlogindt") = ssnlogindt
        session("ssnlastcheckdt") = ssnlogindt

        ''2018/08/07 Cookie=>Session 변경=================================
        session("ssnusername") 	= ouser.FOneUser.FUserName
        session("ssnuserdiv") 	= ouser.FOneUser.FUserDiv
        session("ssnuserlevel")	= ouser.FOneUser.FUserLevel
        session("ssnrealnamecheck")	= ouser.FOneUser.FRealNameCheck
        session("ssnuseremail")	= ouser.FOneUser.FUserEmail
	    session("ssnuserbizconfirm") = ouser.FOneUser.FBizConfirm

        ' ==============================================================

        '// appBoy관련데이터 추가-원승현(2017-11-07)
        '// 2018 회원등급 개편
        session("appboySession") = ouser.FOneUser.FUserSeq
        Select Case Trim(ouser.FOneUser.FUserLevel)
            Case "0"
                response.Cookies("appboy")("userlevel") = "white"
            Case "1"
                response.Cookies("appboy")("userlevel") = "red"
            Case "2"
                response.Cookies("appboy")("userlevel") = "vip"
            Case "3"
                response.Cookies("appboy")("userlevel") = "vipgold"
            Case "4"
                response.Cookies("appboy")("userlevel") = "vvip"
            Case "5"
                response.Cookies("appboy")("userlevel") = "white"
            Case "6"
                response.Cookies("appboy")("userlevel") = "vvip"
            Case "7"
                response.Cookies("appboy")("userlevel") = "staff"
            Case "8"
                response.Cookies("appboy")("userlevel") = "family"
        End Select
        sqlstr = " Select top 1 "
        sqlstr = sqlstr & "	n.userid,  "
        sqlstr = sqlstr & "	case when convert(varchar(10), birthday, 120)='1900-01-01' then '' else convert(varchar(10), birthday, 120) end as dob, "
        sqlstr = sqlstr & "	case when n.sexflag in (1,3,5,7) then 'M' when n.sexflag in (2,4,6,8) then 'F' else '' end as gender,  "
        sqlstr = sqlstr & "	convert(varchar(33), regdate, 126)+'+09:00' as firstLogin, convert(varchar(33), l.lastlogin, 126)+'+09:00' as lastLogin,  "
        sqlstr = sqlstr & "	useq*3 as external_id,  "
        sqlstr = sqlstr & "	case when lastpushyn='Y' then 'opted_in' when lastpushyn='N' then 'unsubscribed' else 'subscribed' end as push_subscribe,  "
        sqlstr = sqlstr & "	case when lastpushyn='Y' then convert(varchar(33), lastpushynDate, 126)+'+09:00' else '' end as push_opted_in_at, l.counter, "
        sqlstr = sqlstr & " n.connInfo ci,"
        sqlstr = sqlstr & " n.jumin1 jumin1, case when n.realnamecheck='Y' then 1 else 0 end realnamecheck,"
        sqlstr = sqlstr & " case when email_10x10='Y' then 1 else 0 end emailcheck,"
        sqlstr = sqlstr & " case when smsok='Y' then 1 else 0 end smscheck"	
        sqlstr = sqlstr & "	From db_user.dbo.tbl_user_n n "
        sqlstr = sqlstr & "	inner join db_user.dbo.tbl_logindata l on n.userid = l.userid "
        sqlstr = sqlstr & "	left join db_contents.dbo.tbl_app_wish_userinfo u on n.userid = u.userid "
        sqlstr = sqlstr & "	Where n.userid='"&LCase(ouser.FOneUser.FUserID)&"' "
        rsget.CursorLocation = adUseClient
        rsget.Open sqlstr, dbget, adOpenForwardOnly, adLockReadOnly
        If Not(rsget.bof Or rsget.eof) Then
        ''성인인증
            session("isAdult") = False
            Dim jumin1 :jumin1 = rsget("jumin1")
            If  rsget("realnamecheck") = 1 And jumin1<>"" Then
                dim dtBirthDay : dtBirthDay = chkIIF(Left( jumin1,1)<>"0", "19"+left(jumin1,2), "20"+left(jumin1,2)) & "-" & mid(jumin1,3,2) & "-" & right(jumin1,2) & " 00:00:00"
                dtBirthDay = CDate(dtBirthDay)
                
                if datediff("m", dtBirthDay, now())/12 >= 18 then
                    session("isAdult") = True
                end if
            end if	

            session("appboyDob") = rsget("dob")
            session("appboyGender") = rsget("gender")
            response.Cookies("appboy")("firstLoginDate") = rsget("firstLogin")
            response.Cookies("appboy")("lastLoginDate") = rsget("lastLogin")
            response.Cookies("appboy")("pushSubscribe") = rsget("push_subscribe")
            response.Cookies("appboy")("pushOptedInAt") = rsget("push_opted_in_at")
            response.Cookies("appboy")("loginCounter") = rsget("counter")
            response.Cookies("appboy")("emailCheck") = rsget("emailcheck")
            response.Cookies("appboy")("smsCheck") = rsget("smscheck")		
        End If
        rsget.close


        '' DB세션 저장
        '' Call fnDBSessionCreate("W")  ''2018/08/17 중지
        Dim isSSnLongKeep : isSSnLongKeep = 0  '' 값이 1이면 길게 유지
        Dim retSsnHash
        retSsnHash = fnDBSessionCreateV2("W",isSSnLongKeep)  ''2018/08/07
        if (isSSnLongKeep>0) then
            response.cookies("tinfo").Expires = Date + 15
        end if
        response.Cookies("tinfo")("ssnhash") = retSsnHash
        session("ssnhash") = retSsnHash

        response.Cookies("tinfo")("isEvtWinner") = false
        response.Cookies("tinfo")("isTester") = false
        response.Cookies("tinfo")("isAnnivers") = false


        ' 2019-02-26 프로모션쿠폰 
        Dim couponSqlStr

        couponSqlStr = "EXEC db_user.dbo.USP_TEN_LOGINCOUPON_INSERT '"& ouser.FOneUser.FUserID &"'"
        dbget.Execute couponSqlStr, 1

        '####### 로그인 로그 저장
        Call WWWLoginLogSave(ouser.FOneUser.FUserID,"Y","ten_www",flgDevice)

        '###### 실패로그 정리
        Session.Contents.Remove("chkLoginLock")		'계정중지 리셋

        set ouser = Nothing

        ' Biz모드 on
        Response.Cookies("bizMode").domain = "10x10.co.kr"
        Response.Cookies("bizMode") = "Y"


        Response.Redirect wwwUrl & "/biz/"

    ' 로그인 실패
    else
        
        '####### 로그인 로그 저장
        Call WWWLoginLogSave(userid,"N","ten_www",flgDevice)

        set ouser = Nothing

        Response.Redirect wwwUrl & "/login/loginpage.asp?backpath=" & server.URLEncode("/biz/")
    end if
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
<!-- #include virtual="/lib/db/dbEVTclose.asp" -->