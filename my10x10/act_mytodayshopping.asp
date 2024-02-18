<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbEVTopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/tenEncUtil.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<%

	Dim referer, refip, i, myTodayShopping, sqlStr, t
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

	Dim vUserId, vItemId, tmpvItemId, dChkCnt

	vUserid = tenDec(requestCheckVar(request("DUserId"),50))
	vItemId =  requestCheckVar(request("Ditemid"),1000)

	'// 회원확인
	If vUserid <> getEncLoginUserId Then
		Response.Write "<script>alert('잘못된 접속입니다.');return false;</script>"
		Response.End
	End If

	If vItemId <> "" Then
		tmpvItemId = Left(vItemId, Len(vItemId)-1)
		tmpvItemId = Split(vItemId, ",")
		For i = 0 To UBound(tmpvItemId)
			sqlStr = "select count(idx) "
			sqlStr = sqlStr + " from [db_EVT].dbo.[tbl_itemevent_userLogData_FrontRecent] with (nolock) "
			sqlStr = sqlStr + " where userid = '"&vUserid&"' And type='item' And itemid='"&tmpvItemId(i)&"' "
			rsEVTget.Open sqlStr,dbEVTget,1
				dChkCnt = rsEVTget(0)
			rsEVTget.close

			If dChkCnt > 0 Then
				sqlStr = " Delete From [db_EVT].dbo.[tbl_itemevent_userLogData_FrontRecent] "
				sqlStr = sqlStr & " Where userid='"&vUserid&"' And type='item' And itemid='"&tmpvItemId(i)&"' "
				dbEVTget.execute sqlStr
			End If
		Next
		response.write "ok"
		response.End
	End If





%>
<!-- #include virtual="/lib/db/dbEVTclose.asp" -->