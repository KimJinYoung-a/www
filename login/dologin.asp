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
<script type="text/javascript">
<!--
    function jsReloadSSL(isOpen, strPath,blnclose, parentprotocol){
		if ( parentprotocol != "https:"){
			var replacePath =  "<%=chkIIF(instr(request.ServerVariables("HTTP_REFERER"),"www")>0,wwwUrl,replace(wwwUrl,"www.",""))%>/login/popSSLreload.asp?isOpen=" + isOpen + "&strPath=" + strPath+"&blnclose="+blnclose;
		}else{
			var replacePath =  "<%=chkIIF(instr(request.ServerVariables("HTTP_REFERER"),"www")>0,SSLUrl,replace(SSLUrl,"www.",""))%>/login/popSSLreload.asp?isOpen=" + isOpen + "&strPath=" + strPath+"&blnclose="+blnclose;
		}
       	location.replace(replacePath);
    }
//-->
</script>

<%
dim ouser
dim userid, userpass, backpath
dim strGetData, strPostData
dim isupche
dim isopenerreload,blnclose, chkLoginFailCnt, chkCaptcha
dim snsisusing, snsid, snsgubun, snsusermail, snslogin, snsjoingubun, sns_sexflag
dim parentprotocol

'sns 회원가입 추가 정보-유태욱2017-05-29
snsisusing 	= requestCheckVar(request("snsisusing"),1)
snsid			= requestCheckVar(Request("snsid"),64)
snsgubun		= requestCheckVar(Request("snsgubun"),2)
snsusermail	= requestCheckVar(Request("snsusermail"),128)
tokenval		= html2db(request("tokenval"))
snslogin		= URLDecodeUTF8( html2db(request("snslogin")))
blnclose		= requestCheckVar(Request("blnclose"),2)
snsjoingubun		= requestCheckVar(Request("snsjoingubun"),2)
sns_sexflag	= requestCheckVar(Request("sns_sexflag"),7)

userid 		= requestCheckVar(request("userid"),32)
userpass 	= requestCheckVar(request("userpass"),32)

isopenerreload= request("isopenerreload")
backpath 		= ReplaceRequestSpecialChar(request("backpath"))
strGetData  	= ReplaceRequestSpecialChar(request("strGD"))
strPostData 	= ReplaceRequestSpecialChar(request("strPD"))
parentprotocol  = ReplaceRequestSpecialChar(request("parentprotocol"))

if strGetData <> "" then backpath = backpath&"?"&strGetData
if backpath =""  then blnclose ="Y"

dim referer
referer = request.ServerVariables("HTTP_REFERER")
Dim ssnlogindt  ''2016/12/28

'##### 로그인 실패 제한 검사 (2015.10.28; 허진원)
chkLoginFailCnt = ChkLoginFailInfo(userid, "Chk")
if chkLoginFailCnt>=10 then
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
end if

set ouser = new CTenUser
ouser.FRectUserID = userid
ouser.FRectPassWord = userpass

ouser.FRectsns = snsid
ouser.FRectsnsgb = snsgubun

ouser.LoginProc

if (ouser.IsPassOk) then

	'이건 나중에 위쪽으로
'	if InStr(referer,"10x10.co.kr")<1 then
'		Response.Write "Err|잘못된 접속입니다."
'		dbget.close() : Response.End
'	end If

	'2017 sns 로그인 유태욱
	dim sqlstr, snscnt, sqlStrtoken, tokenval, tokencnt, snsgubunname, snsmycnt

	if snsgubun = "nv" then
		snsgubunname = "네이버"
	elseif snsgubun = "fb" then
		snsgubunname = "페이스북"
	elseif snsgubun = "ka" then
		snsgubunname = "카카오"
	elseif snsgubun = "gl" then
		snsgubunname = "구글"
	end if

	if snsisusing="Y" and snsid<>"" and snsgubun<>"" then
		'sns로그인시 전달받은 userid가 없는 경우가 있음> sns로그인에서 매칭된 값으로 할당
		if userid="" then userid=ouser.FOneUser.FUserID

		'// 토큰값 맞는지 확인
		sqlStrtoken = "Select count(*) From [db_user].[dbo].tbl_user_sns_token Where snsid='" & snsid & "' and snsgubun = '" & snsgubun & "' and snstoken = '" & tokenval & "' "
		rsget.Open sqlStrtoken,dbget,1
		IF Not rsget.Eof Then
			tokencnt = rsget(0)
		End IF
		rsget.close

		if tokencnt < 1 Then
	        response.write "<script>alert('SNS인증을 다시 시도해 주세요.')</script>"
	        response.write "<script>history.back()</script>"
	        response.end
		end if

		if snslogin = "" then
			sqlstr = ""
'			sqlstr = "select count(*) From [db_user].[dbo].[tbl_user_sns] Where tenbytenid='"& userid &"' And snsgubun='"& snsgubun &"' And isusing='Y' "	'and snsid="& snsid &"
			sqlstr = "select count(*) From [db_user].[dbo].[tbl_user_sns] Where snsid='"& snsid &"' And snsgubun='"& snsgubun &"' And isusing='Y' "	'and 	tenbytenid='"& userid &"'
			rsget.Open sqlstr, dbget, 1
				snscnt = rsget(0)
			rsget.close

			if snscnt > 0 then
			    response.write "<script type='text/javascript'>" &_
			    				"alert('이미 다른 텐바이텐 아이디와 연동된 "&snsgubunname&" 계정입니다.'); history.back();" &_
			    				"</script>"
			    dbget.Close(): response.End
			else
				sqlstr = "select count(*) From [db_user].[dbo].[tbl_user_sns] Where tenbytenid='"& userid &"' And snsgubun='"& snsgubun &"' And isusing='Y' "	'and snsid="& snsid &"
				rsget.Open sqlstr, dbget, 1
					snsmycnt = rsget(0)
				rsget.close

				if snsmycnt > 0 then
				    response.write "<script type='text/javascript'>" &_
				    				"alert('이미 다른 "&snsgubunname&" 계정과 연동된 아이디입니다.'); history.back();" &_
				    				"</script>"
				    dbget.Close(): response.End
				else
					sqlstr = ""
					sqlstr = "insert into [db_user].[dbo].[tbl_user_sns]  (snsgubun, tenbytenid, snsid, usermail, sexflag, isusing ) values " & vbCrlf
					sqlstr = sqlstr & " ( '"& snsgubun &"' " & vbCrlf
					sqlstr = sqlstr & " , '"& userid &"' " & vbCrlf
					sqlstr = sqlstr & " , '"& snsid & "' " & vbCrlf
					sqlstr = sqlstr & " , '"& snsusermail &"' " & vbCrlf
					sqlstr = sqlstr & " , '"& sns_sexflag &"' " & vbCrlf
					sqlstr = sqlstr & " , 'Y') " & vbCrlf
					dbget.Execute(sqlStr)

					if snsjoingubun = "ji" then
						backpath = ""
					end if
					response.write "<script type='text/javascript'>" &_
									"alert('계정 연결이 완료되었습니다');" &_
									"</script>"
				end if
			end if
		end if
	end if

	
	Dim iCookieDomainName : iCookieDomainName = GetCookieDomainName
	'// 로그인 정보 저장/처리
	response.Cookies("tinfo").domain = iCookieDomainName ''"10x10.co.kr"
	'response.Cookies("tinfo")("userid") = ouser.FOneUser.FUserID
	'response.Cookies("tinfo")("username") = ouser.FOneUser.FUserName
	'if (InStr(ouser.FOneUser.FUserEmail,"--")<1) then
	'    ''2015.03.13 허진원: 개인정보보호를 위해 이메일 제거
	'    ''response.Cookies("tinfo")("useremail") = ouser.FOneUser.FUserEmail
    'end if
	'response.Cookies("tinfo")("userdiv") = ouser.FOneUser.FUserDiv
	'response.Cookies("tinfo")("userlevel") = ouser.FOneUser.FUserLevel
    'response.Cookies("tinfo")("realnamecheck") = ouser.FOneUser.FRealNameCheck
    
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

	' if (ouser.FOneUser.FUserDiv="02") or (ouser.FOneUser.FUserDiv="03") or (ouser.FOneUser.FUserDiv="04") or (ouser.FOneUser.FUserDiv="06") or (ouser.FOneUser.FUserDiv="07") or (ouser.FOneUser.FUserDiv="08") or (ouser.FOneUser.FUserDiv="19") or (ouser.FOneUser.FUserDiv="20")   then
	' 	isupche = "Y"
	' else
	' 	isupche = "N"
	' end if
	''response.Cookies("tinfo")("isupche") = isupche  ''안쓰임 삭제 2018/08/10

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
		Case "9"
			response.Cookies("appboy")("userlevel") = "biz"
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
		session("appboyUseq") = rsget("external_id")
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


	'// 첫구매자 you이벤트 관련(79281)
	Dim FirstUserYouEvtChk
	sqlstr = "select count(userid) From [db_EVT].[dbo].[tbl_FirstOrderEvt] Where userid='"&LCase(ouser.FOneUser.FUserID)&"' "
	rsEVTget.Open sqlstr, dbEVTget, 1
		FirstUserYouEvtChk = rsEVTget(0)
	rsEVTget.close

	If FirstUserYouEvtChk > 0 Then
		response.Cookies("Evt79281FirstOrder") = FirstUserYouEvtChk
	End If

'2018.03.28 PC메인개편 기념 PC로그인 회원 마일리지 지급 (200마일; 구분코드:85581)
	' If Date="2018-03-28" Then
	' 	sqlstr = "IF NOT EXISTS(select id from [db_user].[dbo].[tbl_mileagelog] with (noLock) WHERE jukyocd=85581 AND userid='" & GetLoginUserID & "') " & vbCrLf
	' 	sqlstr = sqlstr & "BEGIN " & vbCrLf
	' 	sqlstr = sqlstr & "	insert into [db_user].[dbo].[tbl_mileagelog] (userid,mileage,jukyocd,jukyo,deleteyn) " & vbCrLf
	' 	sqlstr = sqlstr & "	select '" & GetLoginUserID & "', 200,85581,'PC리뉴얼 기념 로그인 마일리지','N' " & vbCrLf
	' 	sqlstr = sqlstr & "	update M " & vbCrLf
	' 	sqlstr = sqlstr & "	set M.bonusmileage=M.bonusmileage + 200 " & vbCrLf
	' 	sqlstr = sqlstr & "	, M.lastupdate = getdate() " & vbCrLf
	' 	sqlstr = sqlstr & "	from db_user.dbo.tbl_user_current_mileage as M " & vbCrLf
	' 	sqlstr = sqlstr & "	where userid='" & GetLoginUserID & "' " & vbCrLf
	' 	sqlstr = sqlstr & "END " & vbCrLf
	' 	dbget.Execute sqlstr
	' End If

'진영 2012-08-30 VIP 쿠키 생성
	'If ouser.FOneUser.FUserID = "kjy8517" or ouser.FOneUser.FUserID = "dream1103" or ouser.FOneUser.FUserID = "star088" or ouser.FOneUser.FUserID = "motions" or ouser.FOneUser.FUserID = "okkang77" Then
	If ouser.FOneUser.FUserLevel ="3" or ouser.FOneUser.FUserLevel="4" OR ouser.FOneUser.FUserID = "kjy8517" Then
		If ouser.fnusingChk = True Then
			If isempty(request.Cookies("hitchVIP")("mode")) or request.Cookies("hitchVIP")("mode") <> "x" Then
				response.Cookies("hitchVIP").domain = "10x10.co.kr"
				response.Cookies("hitchVIP")("mode") = "o"
				response.Cookies("hitchVIP")("ecode") = ouser.eCode
				response.cookies("hitchVIP").Expires = Date + 30	'1개월간 쿠키 저장
			End If
		ElseIf ouser.fnusingChk = False Then
			response.Cookies("hitchVIP").domain = "10x10.co.kr"
			response.Cookies("hitchVIP")("mode") = ""
			response.cookies("hitchVIP").Expires = Date - 1
		End If
	End If
'진영 2012-08-30 VIP 쿠키 끝

	'2014-01-24 김진영 추가..네이버 유입된 회원에게 쿠폰쏘기
	If Left(request.Cookies("rdsite"), 6) = "nvshop" Then
		If isNaverOpen Then
			Dim sqlnv, nvRow
	'		원할인
			sqlnv = "IF NOT EXISTS(select userid FROM [db_user].[dbo].[tbl_user_coupon] WHERE userid = '" & GetLoginUserID & "' AND masteridx = '1022') " & vbCrlf
			sqlnv = sqlnv & "insert into [db_user].[dbo].tbl_user_coupon " & vbCrlf
			sqlnv = sqlnv & " (masteridx,userid,couponvalue,coupontype,couponname,minbuyprice, " & vbCrlf
			sqlnv = sqlnv & " targetitemlist,startdate,expiredate) " & vbCrlf
			sqlnv = sqlnv & " values(1022,'" & GetLoginUserID & "',3000,'2','[1월 네이버]쿠폰_3000원 할인',30000, " & vbCrlf
			sqlnv = sqlnv & " '','2018-01-01 00:00:00' ,'2018-01-07 23:59:59') " & vbCrlf

	'		%할인
	'		sqlnv = "IF NOT EXISTS(select userid FROM [db_user].[dbo].[tbl_user_coupon] WHERE userid = '" & GetLoginUserID & "' AND masteridx = '313') " & vbCrlf
	'		sqlnv = sqlnv & "insert into [db_user].[dbo].tbl_user_coupon " & vbCrlf
	'		sqlnv = sqlnv & " (masteridx,userid,couponvalue,coupontype,couponname,minbuyprice, " & vbCrlf
	'		sqlnv = sqlnv & " targetitemlist,startdate,expiredate) " & vbCrlf
	'		sqlnv = sqlnv & " values(313,'" & GetLoginUserID & "',5,'1','네이버 유입고객 쿠폰 5%',30000, " & vbCrlf
	'		sqlnv = sqlnv & " '','2014-03-07 00:00:00' ,'2014-03-23 23:59:59') " & vbCrlf
			dbget.Execute sqlnv, nvRow
			If (nvRow = 1) Then
				response.Cookies("nvshop").domain = "10x10.co.kr"
				response.cookies("nvshop")("mode") = "y"
				response.cookies("nvshop").Expires = Date + 7
				response.write 	"<script language='javascript'>alert('네이버X텐바이텐 할인쿠폰\n\n쿠폰지급 완료');</script>"
			End If
		End If
	End If

	'2016-02-17 김진영 추가..다음 유입된 회원에게 쿠폰쏘기
	If Left(request.Cookies("rdsite"), 8) = "daumshop" Then
		If isDaumOpen Then
			Dim sqldaum, daumRow
	'		원할인
			sqldaum = "IF NOT EXISTS(select userid FROM [db_user].[dbo].[tbl_user_coupon] WHERE userid = '" & GetLoginUserID & "' AND masteridx = '862') " & vbCrlf
			sqldaum = sqldaum & "insert into [db_user].[dbo].tbl_user_coupon " & vbCrlf
			sqldaum = sqldaum & " (masteridx,userid,couponvalue,coupontype,couponname,minbuyprice, " & vbCrlf
			sqldaum = sqldaum & " targetitemlist,startdate,expiredate) " & vbCrlf
			sqldaum = sqldaum & " values(862,'" & GetLoginUserID & "',3000,'2','[5월 다음]쿠폰_3000원 할인',30000, " & vbCrlf
			sqldaum = sqldaum & " '','2016-05-23 00:00:00' ,'2016-05-29 23:59:59') " & vbCrlf

	'		%할인
	'		sqldaum = "IF NOT EXISTS(select userid FROM [db_user].[dbo].[tbl_user_coupon] WHERE userid = '" & GetLoginUserID & "' AND masteridx = '313') " & vbCrlf
	'		sqldaum = sqldaum & "insert into [db_user].[dbo].tbl_user_coupon " & vbCrlf
	'		sqldaum = sqldaum & " (masteridx,userid,couponvalue,coupontype,couponname,minbuyprice, " & vbCrlf
	'		sqldaum = sqldaum & " targetitemlist,startdate,expiredate) " & vbCrlf
	'		sqldaum = sqldaum & " values(313,'" & GetLoginUserID & "',5,'1','네이버 유입고객 쿠폰 5%',30000, " & vbCrlf
	'		sqldaum = sqldaum & " '','2014-03-07 00:00:00' ,'2014-03-23 23:59:59') " & vbCrlf
			dbget.Execute sqldaum, daumRow
			If (daumRow = 1) Then
				response.Cookies("daumshop").domain = "10x10.co.kr"
				response.cookies("daumshop")("mode") = "y"
				response.cookies("daumshop").Expires = Date + 7
				response.write "<script type='text/javascript'>" &_
								"alert('다음X텐바이텐 할인쿠폰\n\n쿠폰지급 완료');" &_
								"</script>"
			End If
		End If
	End If

	''2019년10월 18주년 상품쿠폰 지급
	If application("Svr_Info")="Dev" Then
		If date() > "2019-09-25" AND date() < "2019-10-01" Then
			Call fnSetItemCouponDown(getLoginUserid, 22174)
			Call fnSetItemCouponDown(getLoginUserid, 22173)
			Call fnSetItemCouponDown(getLoginUserid, 22171)      
		End IF
	Else
		If date() > "2019-09-30" AND date() < "2019-11-01" Then                
			Call fnSetItemCouponDown(getLoginUserid, 56078)
			Call fnSetItemCouponDown(getLoginUserid, 56079)
			Call fnSetItemCouponDown(getLoginUserid, 56080)
			Call fnSetItemCouponDown(getLoginUserid, 56081)
			Call fnSetItemCouponDown(getLoginUserid, 56082)
			Call fnSetItemCouponDown(getLoginUserid, 56083)
		End IF
	End IF   

'===============================================서프라이즈 쿠폰===============================================
	' 2019-02-26 프로모션쿠폰 
	Dim couponSqlStr

	couponSqlStr = "EXEC db_user.dbo.USP_TEN_LOGINCOUPON_INSERT '"& ouser.FOneUser.FUserID &"'"
	dbget.Execute couponSqlStr, 1		
	'dim couponStartDate, couponEndDate	
	'dim couponIdx

	'couponStartDate = cdate("2019-02-11")
	'couponEndDate = cdate("2019-02-12")
	'couponIdx = "1126,1127,1128"

	'If date() >= couponStartDate and date() <= couponEndDate Then			
	'	couponSqlStr = "IF NOT EXISTS(select userid FROM [db_user].[dbo].[tbl_user_coupon] WHERE userid = '" & ouser.FOneUser.FUserID & "' AND masteridx in ("& couponIdx &")) " & vbCrlf
	'	couponSqlStr = couponSqlStr & " insert into [db_user].[dbo].tbl_user_coupon " & vbCrlf
	'	couponSqlStr = couponSqlStr & " (masteridx,userid,couponvalue,coupontype,couponname,minbuyprice,startdate,expiredate,regdate,validsitename,reguserid) " & vbCrlf
	'	couponSqlStr = couponSqlStr & " Select idx, '"&ouser.FOneUser.FUserID&"', couponvalue, coupontype, couponname, minbuyprice, startdate, expiredate, getdate(), validsitename,'system' " & vbCrlf
	'	couponSqlStr = couponSqlStr & " From db_user.dbo.tbl_user_coupon_master Where idx in ("& couponIdx &") And isusing='Y' "
	'	dbget.Execute couponSqlStr, 1
	'End If


	
    '####### 로그인 로그 저장
    Call WWWLoginLogSave(ouser.FOneUser.FUserID,"Y","ten_www",flgDevice)

    '###### 실패로그 정리
    if chkLoginFailCnt>0 then Call ClearLoginFailInfo(ouser.FOneUser.FUserID)
    Session.Contents.Remove("chkLoginLock")		'계정중지 리셋

end if

'## 상품쿠폰 다운 함수
Function fnSetItemCouponDown(ByVal userid, ByVal idx)
	dim sqlStr
	Dim objCmd
	Set objCmd = Server.CreateObject("ADODB.COMMAND")
	With objCmd
		.ActiveConnection = dbget
		.CommandType = adCmdText
		.CommandText = "{?= call [db_item].[dbo].sp_Ten_itemcoupon_down("&idx&",'"&userid&"')}"
		.Parameters.Append .CreateParameter("RETURN_VALUE", adInteger, adParamReturnValue)
		.Execute, , adExecuteNoRecords
		End With	
		fnSetItemCouponDown = objCmd(0).Value	
	Set objCmd = Nothing		
END Function	

if (ouser.IsPassOk) then

	'이벤트 당첨여부 확인
	Dim clsEvtPrize	: set clsEvtPrize  = new CEventPrize
	clsEvtPrize.FUserid = getLoginuserid
		clsEvtPrize.fnGetEventCheckPrice
		if clsEvtPrize.FTotCnt>0 then
			response.Cookies("tinfo")("isEvtWinner") = true
		else
			response.Cookies("tinfo")("isEvtWinner") = false
		end if

		'Tester 당첨 여부.
		clsEvtPrize.fnGetTesterEventCheck
		if clsEvtPrize.FTotCnt>0 then
			response.Cookies("tinfo")("isTester") = true
		else
			response.Cookies("tinfo")("isTester") = false
		end if
	set clsEvtPrize = Nothing

	'// 비밀번호 변경 안내 여부 확인 (2011.08.19; 허진원 추가)
	Dim chkChangePass : chkChangePass=true
	if ouser.FOneUser.FUserLevel="7" then
		''chkChangePass = ouser.checkOldPasswordChange(userid)
	end if

	set ouser = Nothing
	if (isopenerreload="on") then
		response.write "<script>jsReloadSSL('"&isopenerreload&"','"& server.URLEncode(backpath) &"','"&blnclose&"','"& parentprotocol &"');</script>"
		  dbget.Close: response.end
	else

		' 기념일 알림 여부 가져오기
		Dim objAnniversary	: Set objAnniversary = new clsMyAnniversary

		objAnniversary.CurrPage	= 0
		objAnniversary.FrontGetList
		If (UBound(objAnniversary.Items) > 0) Then
			response.Cookies("tinfo")("isAnnivers") = true

			response.Cookies("pop").domain = "10x10.co.kr"
		   	response.cookies("pop")("popOpenAnniversary") = "Y"
		Else
			response.Cookies("tinfo")("isAnnivers") = false
		End If
		Set objAnniversary = Nothing

		if (backpath = "") then
			If (referer = "") Then
				referer = wwwUrl &"/"
			End If
			'회원가입 페이지에서 로그인시 버그 김진영 수정
			If referer = wwwUrl & "/member/join.asp" Then
				referer = wwwUrl
			End If

	    	if chkChangePass or request.cookies("chkChgPass")="done" then
	    		response.write "<script>location.replace('" & referer & "');</script>"
	    	else
	    		'#비번 변경 안내로 이동 -> 2011.09.29:보기 않좋다고 삭제(최이사님))
	    		response.write "<script>location.replace('" & SSLUrl & "/login/oldPassInfo.asp?backpath=" & server.URLEncode(referer) & "');</script>"
	    	end if

			dbget.Close: response.end
		else
			if strPostData<>"" then
				'POST전송시
		%>
		<form method="post" name="frmLogin" action="<%=wwwUrl & backpath%>" >
			<%	Call sbPostDataToHtml(strPostData) %>
		</form>
		<script language="javascript">
			document.frmLogin.submit();
		</script>
		<%
			else
				'일반 이동
				if (InStr(LCASE(backpath),"inipay/userinfo")>0) then  ''2016/09/27 추가 eastone
				    response.redirect(sslUrl & backpath)
				else
				    response.redirect(wwwUrl & backpath)
			    end if
			end if
		end if
		  dbget.Close: response.end
	end if
elseif (ouser.IsRequireUsingSite) then
	set ouser = Nothing
    response.write "<script>var ret = confirm('사용 중지하신 서비스 입니다. \n텐바이텐 쇼핑몰을 이용하시려면 핑거스 My Fingers에서 \n이용사이트 설정을 수정하시면 텐바이텐 서비스를 바로 이용하실 수 있습니다.'); if (ret) { var popwin=window.open('http://thefingers.co.kr/myfingers/membermodify.asp','_blank',''); popwin.focus(); } </script>"
    response.write "<script>history.back();</script>"

elseif ouser.FConfirmUser="X" then
	set ouser = Nothing
    response.write "<script type='text/javascript'>" &_
    				"alert('사용이 일시정지된 아이디입니다.\n텐바이텐 고객센터(1644-6030)으로 연락주세요.');" &_
    				"history.back();" &_
    				"</script>"

elseif ouser.FConfirmUser="N" then
	set ouser = Nothing
	session("sUserid")=userid
    response.write "<script type='text/javascript'>" &_
    			" var ret = confirm('가입 승인 대기중입니다.\n회원가입 본인인증 페이지로 이동하시겠습니까?.'); " &_
    			" if (ret) { self.location='" & wwwUrl &"/member/join_step3.asp';} " &_
    			" else {history.back();}" &_
    			"</script>"
else

    '####### 로그인 로그 저장
    Call WWWLoginLogSave(userid,"N","ten_www",flgDevice)

    '## 로그인 실패정보 저장 (2015.10.28; 허진원)
    chkLoginFailCnt = ChkLoginFailInfo(userid, "Add")

	set ouser = Nothing

	if chkLoginFailCnt<10 then
		''Session.Contents.Remove("chkLoginLock")
		response.write "<script>alert('텐바이텐 회원이 아니시거나, 아이디 또는 비밀번호를 잘못 입력하셨습니다.\n\n※ 10회 이상 입력 오류시 개인정보 보호를 위해 잠시 동안 로그인이 제한됩니다. (" & chkLoginFailCnt & "번 실패)');</script>"
	else
		response.write "<script>alert('텐바이텐 회원이 아니시거나, 아이디 또는 비밀번호를 잘못 입력하셨습니다.\n\n※ 10회 이상 입력 오류로 인해 잠시 동안 로그인이 제한됩니다.\n잠시 후 다시 로그인해주세요.');</script>"
	end if
	If requestCheckVar(request("point1010login"),1) = "o" Then
		response.write "<script>location.href='" & wwwUrl &"/offshop/point/point_login.asp?reurl=" & backpath & "'</script>"
	Else
		response.write "<script>history.back();</script>"
	End If

end if
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
<!-- #include virtual="/lib/db/dbEVTclose.asp" -->