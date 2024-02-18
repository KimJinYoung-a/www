<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
'#######################################################
'	History	:  2014.10.22 허진원 생성
'			   2022.11.14 한용민 수정(회원 체크해서 상황에 맞게 분기 시키는 로직 추가)
'	Description : 메일링 서비스 수신거부 간소화 페이지 처리 (Ajax)
'#######################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/tenEncUtil.asp" -->
<%
'// 이전페이지 내용 접수
Dim vRef, vMail, vEncMail, dbUserId, dbEmailOk, strSql, mode, chkCnt
dim rdsite, utm_source, utm_medium, utm_campaign
	vRef = request.ServerVariables("HTTP_REFERER")
	vEncMail = requestcheckvar(request("vEncMail"),256)
	rdsite = requestcheckvar(request("rdsite"),32)
	utm_source = requestcheckvar(request("utm_source"),32)
	utm_medium = requestcheckvar(request("utm_medium"),32)
	utm_campaign = requestcheckvar(request("utm_campaign"),13)
	mode = requestcheckvar(request("mode"),32)

if vEncMail<>"" and not(isnull(vEncMail)) then
	vMail = tenDec(vEncMail)
end if

if InStr(vRef,"10x10.co.kr")<1 then
	Response.Write "E01"
	dbget.Close: response.end
end if
if vMail="" then
	Response.Write "E02"
	dbget.Close: response.end
end if
if len(vMail)<6 then
	Response.Write "E03"
	dbget.Close: response.end
end if
if instr(vMail,"@")<=0 or instr(vMail,".")<=0 then
	Response.Write vMail
	dbget.Close: response.end
end if

if mode="RequestEmailNo" then
	dbUserId=""
	dbEmailOk=""
	'// 회원이 있는지 확인
	strSql = "Select userid, emailok"
	strSql = strSql & " From db_user.dbo.tbl_user_n"
	strSql = strSql & " Where usermail='" & vMail & "' "

	'response.write strSql & "<br>"
	rsget.CursorLocation = adUseClient
	rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly
		dbUserId = rsget("userid")
		dbEmailOk = rsget("emailok")
	rsget.Close

	' 회원이 아니면 팅겨냄
	if dbUserId="" or isnull(dbUserId) then
		Response.Write "E05"
		dbget.Close: response.end
	end if

	' 현재 수신여부가N인경우
	if dbEmailOk="N" then
		Response.Write "E05"
		dbget.Close: response.end
	end if

	'Log 기록
	strSql = "insert into db_log.dbo.tbl_user_updateLog (userid,updateDiv,siteDiv,refIP)"
	strSql = strSql & " 	select"
	strSql = strSql & "		userid, 'M', 'R', '" & Left(request.ServerVariables("REMOTE_ADDR"),32) & "'"
	strSql = strSql & " 	from db_user.dbo.tbl_user_n "
	strSql = strSql & " 	where emailok='Y'"
	strSql = strSql & " 	and usermail='" & vMail & "'"

	'response.write strSql & "<br>"
	dbget.Execute strSql

	'// 회원 메일 수신 거부 처리
	strSql = "Update db_user.dbo.tbl_user_n "
	strSql = strSql & " Set emailok='N', email_10x10='N', email_way2way='N' "
	strSql = strSql & " Where emailok='Y' and usermail='" & vMail & "'"

	'response.write strSql & "<br>"
	dbget.Execute(strSql)

	Response.Write "OK"

elseif mode="RequestEmailOk" then
	dbUserId=""
	dbEmailOk=""
	'// 회원이 있는지 확인
	strSql = "Select userid, emailok"
	strSql = strSql & " From db_user.dbo.tbl_user_n"
	strSql = strSql & " Where usermail='" & vMail & "' "

	'response.write strSql & "<br>"
	rsget.CursorLocation = adUseClient
	rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly
		dbUserId = rsget("userid")
		dbEmailOk = rsget("emailok")
	rsget.Close

	' 회원이 아니면 팅겨냄
	if dbUserId="" or isnull(dbUserId) then
		Response.Write "E06"
		dbget.Close: response.end
	end if

	' 현재 수신여부가Y인경우
	if dbEmailOk="Y" then
		Response.Write "E06"
		dbget.Close: response.end
	end if

	'Log 기록
	strSql = "insert into db_log.dbo.tbl_user_updateLog (userid,updateDiv,siteDiv,refIP)"
	strSql = strSql & " 	select"
	strSql = strSql & "		userid, 'M', 'R', '" & Left(request.ServerVariables("REMOTE_ADDR"),32) & "'"
	strSql = strSql & " 	from db_user.dbo.tbl_user_n "
	strSql = strSql & " 	where emailok='N'"
	strSql = strSql & " 	and usermail='" & vMail & "'"

	'response.write strSql & "<br>"
	dbget.Execute strSql

	'// 회원 메일 수신 거부 처리
	strSql = "Update db_user.dbo.tbl_user_n "
	strSql = strSql & " Set emailok='Y', email_10x10='Y'"
	strSql = strSql & " Where emailok='N' and usermail='" & vMail & "'"

	'response.write strSql & "<br>"
	dbget.Execute(strSql)

	Response.Write "OK"
else
	Response.Write "E99"
	dbget.Close: response.end
end if
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->