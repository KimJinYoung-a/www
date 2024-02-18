<%@ codepage="65001" language="VBScript" %><?xml version="1.0" encoding="UTF-8" ?>
<%
'#######################################################
'	History	:  2011.03.15 허진원 생성
'	Description : 상품Q&A 내용 수정용 XML반환 페이지
'#######################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<%
'// 페이지에 한글XML코드임을 알림
Response.contentType = "text/xml; charset=UTF-8"

	if getLoginUserid="" then Response.End
	
	dim sqlStr, idx
	idx = getNumeric(requestCheckVar(request("idx"),8))
	sqlStr = "select * " &_
		" from [db_cs].[dbo].tbl_my_item_qna " &_
		" where userid='" & getLoginUserid & "' " &_
		" and isusing ='Y' " &_
		" and id ='" & idx & "' "
	rsget.Open sqlStr, dbget, 1

	if Not(rsget.EOF or rsget.BOF) then
%>
<list>
<item>
	<email><%=db2html(rsget("usermail"))%></email>
	<emailchk><%=rsget("emailok")%></emailchk>
	<userhp><%=rsget("userhp")%></userhp>
	<smschk><%=rsget("smsok")%></smschk>
	<contents><![CDATA[<%=db2html(rsget("contents"))%>]]></contents>
	<secretchk><%=rsget("secretyn")%></secretchk>
</item>
</list>
<%		
	end if

	rsget.Close
%>

<!-- #include virtual="/lib/db/dbclose.asp" -->