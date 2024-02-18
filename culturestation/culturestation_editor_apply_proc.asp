<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'#######################################################
'	History	:  2011.04.04 강준구 생성
'	Description : culturestation
'#######################################################
%>
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->

<%
	Dim vAction, vQuery, vUserID, vUserName, vUserCell, vUserMail, vLinkUrl, vWhyApply
	vAction		= requestCheckVar(Request("action"),1)
	vUserID		= GetLoginUserID()
	vUserName	= GetLoginUserName()
	vUserCell	= requestCheckVar(Request("usercell1"),4) & "-" & requestCheckVar(Request("usercell2"),4) & "-" & requestCheckVar(Request("usercell3"),4)
	vUserMail	= requestCheckVar(Request("usermail"),100)
	vLinkUrl	= requestCheckVar(Request("linkurl"),120)
	vWhyApply	= html2db(Replace(Request("whyapply"),"'","&#34"))
	
	If vUserID = "" OR vUserName = "" Then
		Response.Write "<script type='text/javascript'>alert('잘못된 경로입니다.');top.location.href='/'</script>"
		dbget.close()
		Response.End
	End If
	
	If vAction = "i" Then
		vQuery = "EXEC [db_culture_station].[dbo].[sp_Ten_CultureStation_Apply] '" & vAction & "', '', '" & vUserID & "', '" & vUserName & "', '" & vUserCell & "', '" & vUserMail & "', '" & vLinkUrl & "', '" & vWhyApply & "', '' "
    	dbget.execute vQuery
	End If
	
	Response.Write "<script type='text/javascript'>alert('저장 되었습니다.');top.location.href='/culturestation/';location.href='about:blank'</script>"
	dbget.close()
	Response.End
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->