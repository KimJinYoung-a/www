<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/tenEncUtil.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<%
'####################################################
' Description : 마이텐바이텐 - 입고 알림 신청 내역
' History : 2018-01-30 원승현 
'####################################################

	Dim referer, refip, i, sqlStr, vMode
	referer = request.ServerVariables("HTTP_REFERER")
	refip = request.ServerVariables("REMOTE_ADDR")

	if InStr(referer,"10x10.co.kr")<1 Then
		Response.Write "<script>alert('잘못된 접속입니다.');return false;</script>"
		Response.End
	end If

	'// 로그인시에만 사용가능
	If not(IsUserLoginOK()) Then
		Response.Write "<script>alert('로그인이 필요한 서비스 입니다.');return false;</script>"
		Response.End
	End If

	Dim vUserid, vPrevDateType, vPrevDateValue, vStdnum, vPageSize, vIdx

	vUserid = tenDec(requestCheckVar(request("UserId"),50))
	vIdx = requestCheckVar(request("Idx"),20)

	'// 회원확인
	If vUserid <> getEncLoginUserId Then
		Response.Write "<script>alert('잘못된 접속입니다.');return false;</script>"
		Response.End
	End If

	If Trim(vIdx)="" Then
		Response.Write "<script>alert('잘못된 접속입니다.');return false;</script>"
		Response.End
	End If
	sqlStr = ""
	sqlStr = sqlStr & " UPDATE db_my10x10.[dbo].[tbl_SoldOutProductAlarm] SET UserCheckStatus='N' WHERE idx='"&vIdx&"' "
	dbget.Execute sqlStr

	response.write "OK"
	response.End

%>
<!-- #include virtual="/lib/db/dbclose.asp" -->