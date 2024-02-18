<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'#######################################################
'	History	:  2010.04.08 한용민 생성
'	Description : culturestation
'#######################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/classes/culturestation/culturestationCls.asp" -->

<%
dim userid , comment , editor_no , idx , mode
	userid = GetLoginUserID
	comment = request("comment")
	editor_no = requestCheckVar(request("editor_no"),10)
	idx = requestCheckVar(request("idx"),10)
	mode = requestCheckVar(request("mode"),20)

dim sql

dim referer
referer = request.ServerVariables("HTTP_REFERER")

'// 로그인 체크
if GetLoginUserID = "" then
	response.write "<script>"
	response.write "var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');"
	response.write "winLogin.focus();"
	response.write "history.go(-1);"	
	response.write "</script>"			
	dbget.close()	:	response.End
end if	

'//코맨트 삭제
if  mode = "delete_comment" then
	
	if idx = "" then
		response.write "<script>"
		response.write "alert('인덱스번호가 없습니다.');"		
		response.write "location.href='"& referer &"';"
		response.write "</script>"	
		dbget.close()	:	response.End
	end if	
	
	sql = "update db_culture_station.dbo.tbl_culturestation_editor_comment " &_
			" set isusing='N' " &_
			" where idx = " & idx
	'response.write sql
	dbget.execute sql
	
	response.write "<script>"
	response.write "location.href='"& referer &"';"
	response.write "</script>"	

'//코맨트 등록
else	

	if editor_no = "" then
		response.write "<script>"
		response.write "alert('이벤트코드가 없습니다.');"		
		response.write "location.href='"& referer &"';"
		response.write "</script>"	
		dbget.close()	:	response.End
	end if	

	if checkNotValidHTML(comment) or comment = "" then
%>

	<script>
	alert('내용이 없거나 유효하지 않은 글자가 포함되어 있습니다. 다시 작성 해주세요');
	history.go(-1);
	</script>		

<%		dbget.close()	:	response.End
	end if
		

	sql = "insert into db_culture_station.dbo.tbl_culturestation_editor_comment (editor_no,userid,comment,isusing) values"
	sql = sql & "("
	sql = sql & " "& editor_no &""	
	sql = sql & " ,'"& GetLoginUserID &"'"		
	sql = sql & " ,'"& html2db(comment) &"'"	
	sql = sql & " ,'Y'"		
	sql = sql & ")"	
	
	'response.write sql
	dbget.execute sql
	
	response.write "<script>"
	response.write "location.href='"& referer &"';"
	response.write "</script>"	

end if
%>
	
<!-- #include virtual="/lib/db/dbclose.asp" -->