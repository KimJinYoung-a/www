<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","-1"
Response.AddHeader "Pragma","no-cache"
%>

<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<%
Dim sMode
Dim shopid, userid, username, stitle, scontents, sitemid, semail, semailok, scell, scellok
Dim idx, password, db_password
Dim strSql
	sMode  =  requestCheckVar(Request.Form("sMode"),2)
	password	= requestCheckVar(Request.Form("password"),16)
SELECT CASE sMode
CASE "I"	
	shopid 		= requestCheckVar(Request.Form("shopid"),32)
	userid 		= requestCheckVar(Request.Form("userid"),32)
	username	= requestCheckVar(Request.Form("username"),32)
	stitle 		= html2db(requestCheckVar(Request.Form("sT"),64))
	scontents	= html2db(Request.Form("tC"))
	sitemid 	= requestCheckVar(Request.Form("sC"),10)
	semail 		= requestCheckVar(Request.Form("sM"),128)
	semailok 	= requestCheckVar(Request.Form("chkM"),1)
	If semailok = "" Then semailok="N"
	scell		= "'" & requestCheckVar(Request.Form("sP1"),16) & "'"
	scellok		= "'" & requestCheckVar(Request.Form("chkC"),1) & "'"
	If scellok = "''" Then
		scell	= "null"
		scellok = "null"
	End If	
	
	if checkNotValidHTML(stitle) then
	response.write "<script>alert('유효하지 않은 단어가 포함되어있습니다. 다시 작성해 주세요.');</script>"
	response.write "<script>history.back();</script>"
	response.end
	end if
	
	if checkNotValidHTML(scontents) then
	response.write "<script>alert('유효하지 않은 단어가 포함되어있습니다. 다시 작성해 주세요.');</script>"
	response.write "<script>history.back();</script>"
	response.end
	end if

	strSql = "INSERT INTO  [db_shop].[dbo].tbl_offshop_qna "&_
			" (shopid, userid, usermail, emailok, title, itemid, contents, usercell, cellok, username, password) Values "&_
			" ('"&shopid&"', '"&userid&"','"&html2db(semail)&"','"&semailok&"', '"&html2db(stitle)&"','"&sitemid&"', '"&html2db(scontents)&"', "&scell&", "&scellok&",'"&username&"','"&password&"')	"	
			'Response.write strSql
			'Response.end
	dbget.execute strSql
	
	IF Err.Number <> 0 THEN
	response.write "<script>alert('등록에 문제가 발생하였습니다. 고객센터로 문의해 주세요');</script>"
	response.write "<script>history.back();</script>"
	response.end		 
	Else	
	response.redirect("shopqna.asp?shopid="&shopid&"&tabidx=3")
    response.end   	
	End IF	
CASE "D"
	shopid 	= requestCheckVar(Request.Form("shopid"),32)
	idx 	= requestCheckVar(Request.Form("idx"),10)
	userid	= requestCheckVar(Request.Form("userid"),32)
	
	If idx = "" THEN 
		response.write "<script>alert('데이터처리에 문제가 발생하였습니다. 고객센터로 문의해 주세요');</script>"
		response.write "<script>history.back();</script>"
		response.end	
	End IF
	
		
	strSql = " UPDATE [db_shop].[dbo].tbl_offshop_qna SET isusing='N' WHERE idx = "&idx& " and shopid = '"&shopid&"' and userid='"&userid&"'"
	dbget.execute strSql	
	
	IF Err.Number <> 0 THEN
	response.write "<script>alert('삭제에 문제가 발생하였습니다. 고객센터로 문의해 주세요');</script>"
	response.write "<script>history.back();</script>"
	response.end		 
	Else	
	response.redirect("shopqna.asp?shopid="&shopid&"&tabidx=3")
    response.end   	
	End IF	
CASE "D2"
	shopid 	= requestCheckVar(Request.Form("shopid"),32)
	idx 	= requestCheckVar(Request.Form("idx"),10)

	If idx = "" THEN 
		response.write "<script>alert('데이터처리에 문제가 발생하였습니다. 고객센터로 문의해 주세요');</script>"
		response.write "<script>history.back();</script>"
		response.end	
	End IF

	strSql = " SELECT password " & vbCrLf
	strSql = strSql & " FROM [db_shop].[dbo].tbl_offshop_qna " & vbCrLf
	strSql = strSql & " WHERE isusing='Y'  and shopid='"&shopid&"'"
	strSql = strSql & "	and idx='" & idx &"'" & vbCrLf
	rsget.Open strSql,dbget 
	IF not rsget.Eof THEN
		db_password = rsget(0)
	END IF	
	rsget.Close

	If password <> db_password THEN 
		response.write "<script>alert('비밀번호를 확인하고 다시 시도해 주세요.');</script>"
		response.write "<script>history.back();</script>"
		response.end	
	End IF
		
	strSql = " UPDATE [db_shop].[dbo].tbl_offshop_qna SET isusing='N' WHERE idx = "&idx& " and shopid = '"&shopid&"' and password='"&password&"'"
	dbget.execute strSql	
	
	IF Err.Number <> 0 THEN
	response.write "<script>alert('삭제에 문제가 발생하였습니다. 고객센터로 문의해 주세요');</script>"
	response.write "<script>history.back();</script>"
	response.end		 
	Else	
	response.redirect("shopqna.asp?shopid="&shopid&"&tabidx=3")
    response.end   	
	End IF

CASE ELSE
	response.write "<script>alert('데이터처리에 문제가 발생하였습니다. 고객센터로 문의해 주세요');</script>"
	response.write "<script>history.back();</script>"
	response.end	
END SELECT	
%>