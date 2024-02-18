<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
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
<!-- #include virtual="/lib/classes/membercls/userloginclass.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<%
	'// 변수 선언 및 전송값 접수
	dim userid, orgpass, userpass, userpass2, sql, backpath
	userid		= requestCheckVar(trim(request.Form("uid")),32)
	orgpass		= requestCheckVar(trim(request.Form("orgpwd")),32)
	userpass	= requestCheckVar(trim(request.Form("upwd")),32)
	userpass2	= requestCheckVar(trim(request.Form("upwd2")),32)
	backpath 	= ReplaceRequestSpecialChar(request("backpath"))

	if backpath="" then backpath=wwwUrl &"/"

	dim ouser
	set ouser = new CTenUser
	ouser.FRectUserID = userid
	ouser.FRectPassWord = orgpass
	ouser.LoginProc

	if Not(ouser.IsPassOk) then
		response.write "<script type='text/javascript'>" &vbCrLf &_
						"	alert('현재 비밀번호가 틀립니다.\n정확한 비밀번호를 입력해주세요.');" &vbCrLf &_
						"	parent.document.chgpass.orgpwd.value='';" &vbCrLf &_
						"</script>"
		dbget.close()	:	response.End
	end if

	set ouser = Nothing

	'패스워드 확인
	if userpass<>userpass2 then
		response.write "<script type='text/javascript'>" &vbCrLf &_
						"	alert('비밀번호 확인이 틀립니다.\n정확한 비밀번호를 입력해주세요.');" &vbCrLf &_
						"</script>"
		dbget.close()	:	response.End
	end if


	dim chk
	chk = chkSimplePwdComplex(userid,userpass)
	if (chk<>"") then
		response.write "<script type='text/javascript'>" &vbCrLf &_
						"	alert('" & chk & "\n다른 비밀번호를 입력해주세요.');" &vbCrLf &_
						"	parent.document.chgpass.upwd.value='';" &vbCrLf &_
						"	parent.document.chgpass.upwd2.value='';" &vbCrLf &_
						"	parent.document.chgpass.upwd.focus();" &vbCrLf &_
						"</script>"
		dbget.close()	:	response.End
	end if

	'// 패스워드 변경
	dbget.beginTrans

	on Error Resume Next
	
	sql = "Update [db_user].[dbo].tbl_logindata " + vbCrlf
	sql = sql + " set Enc_userpass='' " + vbCrlf
	sql = sql + " , Enc_userpass64='" & SHA256(MD5(CStr(userpass))) & "' " + vbCrlf
	sql = sql + " where userid = '" + userid + "'" + vbCrlf
	dbget.Execute(sql)

	'// 수정 로그 기록
	sql = "insert into db_log.dbo.tbl_user_updateLog (userid,updateDiv,siteDiv,refIP) values " &_
			" ('" & userid & "'" &_
			", 'P', 'T'" &_
			", '" & Left(request.ServerVariables("REMOTE_ADDR"),32) & "')"
	dbget.Execute(sql)

	'오류검사 및 반영
	If Err.Number = 0 Then   
		dbget.CommitTrans				'커밋(정상)

        response.write "<script type='text/javascript'>alert('비밀번호가 변경되었습니다.');top.location.replace('" & backpath & "')</script>"
        dbget.close()	:	response.End

	Else
		dbget.RollBackTrans				'롤백(에러발생시)

		response.write	"<script type='text/javascript'>" &_
					"	alert('처리중 에러가 발생했습니다.');" &_
					"</script>"

	End If
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->