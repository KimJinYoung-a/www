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
<!-- #include virtual="/lib/inc/incNaverOpenDate.asp" -->
<!-- #include virtual="/lib/inc/incDaumOpenDate.asp" -->
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<%

Dim ouser
Dim userid, userpass, backpath, strGetData, ssnlogindt
Dim chkLoginFailCnt, chkCaptcha

userid 		= requestCheckVar(request("userid"),32)
userpass 	= requestCheckVar(request("userpass"),32)
backpath 	= ReplaceRequestSpecialChar(request("backpath"))
strGetData  = ReplaceRequestSpecialChar(request("strGD"))

if strGetData <> "" then backpath = backpath&"?"&strGetData

dim referer
referer = request.ServerVariables("HTTP_REFERER")

'// 로그인 실패 제한 검사
chkLoginFailCnt = ChkLoginFailInfo(userid, "Chk")
If chkLoginFailCnt>=10 Then
    chkCaptcha = false
    '// Captcha 입력 결과 확인
	if Request.form("g-recaptcha-response")<>"" then
	    Dim recaptcha_secret, sendstring, objXML
	    ' Secret key
	    recaptcha_secret = "6LdSrA8TAAAAADL9MqgEGSBRy51FXxVT0Pifr1l7"
	    sendstring = "https://www.google.com/recaptcha/api/siteverify?secret=" & recaptcha_secret & "&response=" & Request.form("g-recaptcha-response")

	    Set objXML = Server.CreateObject("MSXML2.ServerXMLHTTP")
	    objXML.Open "GET", sendstring, False
	    objXML.Send

	    if inStr(objXML.responseText,"""success"": true")>0 then chkCaptcha = true

	    Set objXML = Nothing
	end if
	'Captcha 입력 결과 확인 끝 //

    session("chkLoginLock")=true
    if Not(chkCaptcha) then
	    response.write "<script type='text/javascript'>" &_
	    				"alert('10회 이상 입력 오류로 인해 잠시 동안 로그인이 제한되었습니다.\n잠시 후 다시 로그인해주세요.');" &_
	    				"location.replace('" & referer & chkIIF(instr(referer,"backpath")>0,"","&backpath=" & server.URLEncode(backpath)) & "');" &_
	    				"</script>"
	    dbget.Close(): response.End
	end if
End If

set ouser = new CTenUser
ouser.FRectUserID = userid
ouser.FRectPassWord = userpass

ouser.BizLoginProc '// Biz 로그인 Proccess

'// 로그인 성공
If (ouser.IsPassOk) then

    Dim iCookieDomainName : iCookieDomainName = GetCookieDomainName

    response.Cookies("tinfo").domain = iCookieDomainName
    response.Cookies("tinfo")("shix") = HashTenID(ouser.FOneUser.FUserID)
    response.Cookies("tinfo")("isEvtWinner") = false
    response.Cookies("tinfo")("isTester") = false
    response.Cookies("tinfo")("isAnnivers") = false

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
    response.Cookies("appboy")("userlevel") = "biz"

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

    '####### 로그인 로그 저장
    Call WWWLoginLogSave(ouser.FOneUser.FUserID,"Y","ten_www",flgDevice)

    '###### 실패로그 정리
    if chkLoginFailCnt>0 then Call ClearLoginFailInfo(ouser.FOneUser.FUserID)
    Session.Contents.Remove("chkLoginLock")		'계정중지 리셋

    set ouser = Nothing

    If (backpath = "") Then
        If (referer = "") Then
            referer = wwwUrl &"/biz/"
        ElseIf referer = wwwUrl & "/member/join.asp" Then
            referer = wwwUrl
        End If

        response.write "<script>location.replace('" & referer & "');</script>"

        dbget.Close: response.end
    Else
        '일반 이동
        If (InStr(LCASE(backpath),"inipay/userinfo")>0) Then
            response.redirect(sslUrl & backpath)
        Else
            response.redirect(wwwUrl & backpath)
        End If

        dbget.Close: response.end
    End If

'// 로그인 실패    
Else

    '####### 로그인 로그 저장
    Call WWWLoginLogSave(userid,"N","ten_www",flgDevice)

    '## 로그인 실패정보 저장 (2015.10.28; 허진원)
    chkLoginFailCnt = ChkLoginFailInfo(userid, "Add")

	set ouser = Nothing

	if chkLoginFailCnt<10 then
		response.write "<script>alert('텐바이텐 Biz회원이 아니시거나, 아이디 또는 비밀번호를 잘못 입력하셨습니다.\n\n※ 10회 이상 입력 오류시 개인정보 보호를 위해 잠시 동안 로그인이 제한됩니다. (" & chkLoginFailCnt & "번 실패)');</script>"
	else
		response.write "<script>alert('텐바이텐 Biz회원이 아니시거나, 아이디 또는 비밀번호를 잘못 입력하셨습니다.\n\n※ 10회 이상 입력 오류로 인해 잠시 동안 로그인이 제한됩니다.\n잠시 후 다시 로그인해주세요.');</script>"
	end if
	response.write "<script>history.back();</script>"

End If

%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
<!-- #include virtual="/lib/db/dbEVTclose.asp" -->