<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'#######################################################
'	History	:  2010.04.08 한용민 생성
'	Description : culturestation 이벤트 처리
'#######################################################
%>
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->

<!-- #include virtual="/lib/classes/culturestation/culturestationCls.asp" -->

<%
dim isusing , mode, contents , idx , gubun , ck_userid
	gubun = requestCheckVar(request("gubun"),2)
	ck_userid = getloginuserid()                             ''수정 2012/01/15
	isusing = "N"
	contents = request("contents")
	idx = getNumeric(requestCheckVar(request("idx"),10))

dim referer
	referer = request.ServerVariables("HTTP_REFERER")

dim sqlStr

'//기존 삭제여부 Y
if idx <> "" then
	sqlStr = "update db_culture_station.dbo.tbl_thanks_10x10 set" &VbCRLF
	sqlStr = sqlStr & " isusing_del = 'Y'"&VbCRLF
	sqlStr = sqlStr & " where idx = '"& idx &"'"&VbCRLF
    sqlStr = sqlStr & " and userid='"&ck_userid&"'"&VbCRLF   '' 추가 2012/01/15
    
	'response.write sqlStr
    dbget.Execute sqlStr

	sqlStr = "delete from db_culture_station.dbo.tbl_thanks_10x10_comment where idx = "& idx &""	
	
	'response.write sqlStr
	dbget.execute sqlStr
	
	response.write "<script>"
	response.write "alert(' 삭제되었습니다.');"
	response.write "parent.location.href='"& referer &"';"
	response.write "</script>"	
	dbget.close()	:	response.End
end if

if ck_userid="" then
	response.write "<script>alert('고객ID가 없습니다. 로그인하세요');</script>"
	dbget.close()	:	response.End
    ''dbget.close()	:	response.End 
end if 

	if checkNotValidHTML(contents) then
%>

	<script>
	alert('내용에 유효하지 않은 글자가 포함되어 있습니다. 다시 작성 해주세요');
	history.go(-1);
	</script>		

<%		dbget.close()	:	response.End
	end if
			

'' 디비에 저장
	    sqlStr = " insert into db_culture_station.dbo.tbl_thanks_10x10" + VbCrlf
	    sqlStr = sqlStr + " (userid,contents,isusing_display,gubun)" + VbCrlf
	    sqlStr = sqlStr + " values(" + VbCrlf
	    sqlStr = sqlStr + " '" & ck_userid & "'" + VbCrlf
	    sqlStr = sqlStr + " ,'" & html2db(contents) & "'" + VbCrlf
	    sqlStr = sqlStr + " ,'" & isusing & "'" + VbCrlf
	    sqlStr = sqlStr + " ,'" & gubun & "'" + VbCrlf
		sqlStr = sqlStr + " )"
    
    'response.write sqlStr &"<br>"
    dbget.Execute sqlStr
    

%>    
<script language="javascript">
	alert('고객님의 글이 저장되었습니다.\n써주신 칭찬글은 텐바이텐에서 확인 후, 답변과 함께 게시됩니다.\n감사합니다.');
	parent.location.href="<%= referer %>";
</script>	

<!-- #include virtual="/lib/db/dbclose.asp" -->