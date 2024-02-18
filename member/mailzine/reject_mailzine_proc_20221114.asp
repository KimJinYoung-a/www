<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
'#######################################################
'	History	:  2014.10.22 허진원 생성
'	Description : 메일링 서비스 수신거부 간소화 페이지 처리 (Ajax)
'#######################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/tenEncUtil.asp" -->
<%
	dim strSql

	'// 이전페이지 내용 접수
	Dim vRef
	vRef = request.ServerVariables("HTTP_REFERER")

	if InStr(vRef,"10x10.co.kr")<1 then
		Response.Write "E01"
		dbget.Close: response.end
	end if

	'// 메일 접수
	dim vMail, vEncMail
	vEncMail = requestCheckVar(request("um"),256)
	vMail = tenDec(vEncMail)

	if vMail="" then
		Response.Write "E02"
		dbget.Close: response.end
	end if

	if len(vMail)<6 then
		Response.Write "E03"
		dbget.Close: response.end
	end if

	if instr(vMail,"@")<=0 or instr(vMail,".")<=0 then
		Response.Write "E04"
		dbget.Close: response.end
	end if

	'//거부안된 회원이 있는지 확인
	dim chkCnt : chkCnt=0
	strSql = "Select count(*) cnt "
	strSql = strSql & " From db_user.dbo.tbl_user_n "
	strSql = strSql & " Where usermail='" & vMail & "' "
	strSql = strSql & " 	and emailok='Y' "
	rsget.Open strSql, dbget, 1
		chkCnt = rsget("cnt")
	rsget.Close
	
	if chkCnt<=0 then
		Response.Write "E05"
		dbget.Close: response.end
	end if

	'Log 기록
	strSql = "insert into db_log.dbo.tbl_user_updateLog (userid,updateDiv,siteDiv,refIP) " &_
			" select userid, 'M', 'R' " &_
			"	, '" & Left(request.ServerVariables("REMOTE_ADDR"),32) & "'" &_
			" from db_user.dbo.tbl_user_n " &_
			" where usermail='" & vMail & "' " &_
			" 	and emailok='Y'"
	dbget.Execute strSql

	'// 회원 메일 수신 거부 처리
	strSql = "Update db_user.dbo.tbl_user_n "
	strSql = strSql & " Set emailok='N', email_10x10='N', email_way2way='N' "
	strSql = strSql & " Where usermail='" & vMail & "'"
	dbget.Execute(strSql)

	Response.Write "OK"
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->