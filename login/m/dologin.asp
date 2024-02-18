<%@  codepage="65001" language="VBScript" %>
<% option Explicit %>
<%Response.Addheader "P3P","policyref='/w3c/p3p.xml', CP='NOI DSP LAW NID PSA ADM OUR IND NAV COM'"%>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbHelper.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/memberlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/tenEncUtil.asp" -->
<!-- #include virtual="/lib/classes/membercls/userloginclass.asp" -->
<!-- #include virtual="/lib/classes/membercls/clsMyAnniversary.asp" -->
<!-- #include virtual="/lib/classes/cscenter/eventprizeCls.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->

<%
''Raise Err
1=a

	Dim vURL
	IF application("Svr_Info") = "Dev" THEN
		vURL = "http://testm.10x10.co.kr"
	Else
		vURL = "http://m.10x10.co.kr"
	End If
%>

<script language="javascript">
<!--
    function jsReloadSSL(isOpen, strPath,blnclose){        
        var replacePath =  "<%=vURL%>/login/popSSLreload.asp?isOpen=" + isOpen + "&strPath=" + strPath+"&blnclose="+blnclose;
        location.replace(replacePath);
    }
//-->
</script>

<%
dim ouser
dim userid, userpass, backpath
dim strGetData, strPostData
dim isupche
dim isopenerreload,blnclose

userid 		= requestCheckVar(request("userid"),32)
userpass 	= requestCheckVar(request("userpass"),32)

isopenerreload= request("isopenerreload")
backpath 		= ReplaceRequestSpecialChar(request("backpath"))
strGetData  	= ReplaceRequestSpecialChar(request("strGD"))
strPostData 	= ReplaceRequestSpecialChar(request("strPD"))

if strGetData <> "" then backpath = backpath&"?"&strGetData
if backpath =""  then blnclose ="Y"	
	
set ouser = new CTenUser
ouser.FRectUserID = userid
ouser.FRectPassWord = userpass
ouser.LoginProc

dim referer
referer = request.ServerVariables("HTTP_REFERER")


if (ouser.IsPassOk) then

	response.Cookies("uinfo").domain = "10x10.co.kr"
	response.Cookies("uinfo")("muserid") = ouser.FOneUser.FUserID
	response.Cookies("uinfo")("musername") = ouser.FOneUser.FUserName
	''response.Cookies("uinfo")("museremail") = ouser.FOneUser.FUserEmail
	response.Cookies("uinfo")("muserdiv") = ouser.FOneUser.FUserDiv
	response.cookies("uinfo")("muserlevel") = ouser.FOneUser.FUserLevel
    response.cookies("uinfo")("mrealnamecheck") = ouser.FOneUser.FRealNameCheck

    response.Cookies("etc").domain = "10x10.co.kr"
    response.cookies("etc")("mcouponCnt") = ouser.FOneUser.FCouponCnt
    response.cookies("etc")("mcurrentmile") = ouser.FOneUser.FCurrentMileage
    response.cookies("etc")("cartCnt") = ouser.FOneUser.FBaguniCount
    response.Cookies("etc")("musericon") = ouser.FOneUser.FUserIcon

    ''200907추가 '로거 관련.
    'response.cookies("uinfo")("muS") = ouser.FOneUser.FSexFlag 
    'response.cookies("uinfo")("muA") = ouser.FOneUser.FAge     
    
    ''200908추가 '로거 관련.
    'response.cookies("TRKISLOGIN").domain = "10x10.co.kr"
    'response.cookies("TRKISLOGIN") = "Y"
    

    ''아이디조정, 비밀번호저장
    response.Cookies("mSave").domain = "10x10.co.kr"
    response.cookies("mSave").Expires = Date + 30	'1개월간 쿠키 저장
    If request("saved_auto") = "o" Then
    	response.cookies("mSave")("SAVED_AUTO") = "O"
    Else
    	response.cookies("mSave")("SAVED_AUTO") = ""
    End If
    If request("saved_id") = "o" Then
    	response.cookies("mSave")("SAVED_ID") = tenEnc(userid)
    Else
    	response.cookies("mSave")("SAVED_ID") = ""
    End If
    If request("saved_pw") = "o" Then
    	response.cookies("mSave")("SAVED_PW") = tenEnc(userpass)
    Else
    	response.cookies("mSave")("SAVED_PW") = ""
    End If
        
	if (ouser.FOneUser.FUserDiv="02") or (ouser.FOneUser.FUserDiv="03") or (ouser.FOneUser.FUserDiv="04") or (ouser.FOneUser.FUserDiv="05") or (ouser.FOneUser.FUserDiv="06") or (ouser.FOneUser.FUserDiv="07") or (ouser.FOneUser.FUserDiv="08") or (ouser.FOneUser.FUserDiv="19") or (ouser.FOneUser.FUserDiv="20")   then
		isupche = "Y"
	else
		isupche = "N"
	end if

	response.Cookies("uinfo")("misupche") = isupche

    '####### 로그인 로그 저장
    Call WWWLoginLogSave(userid,"Y","ten_m",flgDevice)
end if

if (ouser.IsPassOk) then	

	set ouser = Nothing
	if (isopenerreload="on") then 
		response.write "<script>jsReloadSSL('"&isopenerreload&"','"& server.URLEncode(backpath) &"','"&blnclose&"');</script>"		
		  dbget.Close: response.end
	else	

		if (backpath = "") then		
			If (referer = "") Then 
				referer = vURL &"/"
			End If 
			
	    	response.write "<script>location.replace('" + referer + "');</script>"
			'''response.redirect(referer)
			dbget.Close: response.end
		else
		%>	
		<form method="post" name="frmLogin" action="<%=vURL & backpath%>" >
			<%	Call sbPostDataToHtml(strPostData) %>
		</form>
		<script language="javascript">
			document.frmLogin.submit();
		</script>
		<%	
		end if
		  dbget.Close: response.end
	end if
elseif (ouser.IsRequireUsingSite) then    
	set ouser = Nothing
    Response.Write "<script language='javascript'>alert('사용 중지하신 서비스 입니다.');location.href='/';</script>"
    Response.End

else
    '####### 로그인 로그 저장
    Call WWWLoginLogSave(userid,"N","ten_m",flgDevice)
    
	set ouser = Nothing
	
	Response.Redirect "" & vURL & "/login/login.asp?loginfail=o"
	
end if
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->