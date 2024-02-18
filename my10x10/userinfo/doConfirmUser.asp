<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%Response.Addheader "P3P","policyref='/w3c/p3p.xml', CP='NOI DSP LAW NID PSA ADM OUR IND NAV COM'"%>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_userinfocls.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/tenEncUtil.asp" -->
<%
dim userid, userpass
userid = GetLoginUserID
userpass = requestCheckVar(request.Form("userpass"),32)


'####### POINT1010 에서 넘어온건지 체크 #######
Dim pFlag, vParam
pFlag	= requestCheckVar(request("pflag"),1)
If pFlag = "o" Then
vParam	= "?pflag=o"
End If
'####### POINT1010 에서 넘어온건지 체크 #######


''개인정보보호를 위해 패스워드로 한번더 Check
dim sqlStr, checkedPass, userdiv
dim Enc_userpass
checkedPass = false

'''if (Session("InfoConfirmFlag")<>userid) then
    ''패스워드없이 쿠키로만 들어온경우
    if (userpass="") then
    	response.redirect SSLUrl & "/my10x10/userinfo/confirmuser.asp" & vParam
        response.end    
    end if
    
    Enc_userpass = MD5(CStr(userpass))
    
    ''비암호화
    ''sqlStr = "select userid, IsNULL(userdiv,'02') as userdiv from [db_user].[dbo].tbl_logindata where userid='" & userid & "' and userpass='" & userpass & "'"
    
    ''암호화 사용(MD5)
    ''sqlStr = "select userid, IsNULL(userdiv,'02') as userdiv from [db_user].[dbo].tbl_logindata where userid='" & userid & "' and Enc_userpass='" & Enc_userpass & "'"

    ''암호화 사용(SHA256)
    sqlStr = "select userid, IsNULL(userdiv,'02') as userdiv from [db_user].[dbo].tbl_logindata where userid='" & userid & "' and Enc_userpass64='" & SHA256(Enc_userpass) & "'"

    rsget.Open sqlStr, dbget, 1
    if Not rsget.Eof then
        checkedPass = true
        userdiv = rsget("userdiv")
    end if
    rsget.close
    
    ''패스워드올바르지 않음
    if (Not checkedPass) then
        response.write "<script>location.replace('" & SSLUrl & "/my10x10/userinfo/confirmuser.asp?errcode=1" & Replace(vParam,"?","&") & "');</script>"
        'response.redirect wwwUrl & "/my10x10/confirmuser.asp?errcode=1"
        response.end    
    end if

    '// 세션이 유지되어 있고 쿠키가 있어도 해당 페이지에 10x10을 통해서 넘어오지 않은 경우 튕겨낸다.
    If InStr(lcase(request.ServerVariables("HTTP_REFERER")),"10x10.co.kr")<1 Then
        response.redirect SSLUrl&"/my10x10/userinfo/confirmuser.asp" & vParam
        response.end
    End If

	'// 세션처리후 회원정보 수정 페이지로 GoGo!
    Session("InfoConfirmFlag") = userid
    '//세션이 안먹는경우;;
    response.Cookies("tinfo").domain = "10x10.co.kr"
    response.Cookies("tinfo")("EcChk") = TenEnc(userid)
    
    ''업체인경우 Biz 회원정보 수정페이지로 이동
    if (userdiv="02") or (userdiv="03") or (userdiv="09") then
        response.write "<script>location.replace('" & SSLUrl & "/biz/membermodify.asp" & vParam & "');</script>"
    else
        response.write "<script>location.replace('" & SSLUrl & "/my10x10/userinfo/membermodify.asp" & vParam & "');</script>"
    end if
	
'''end if
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->