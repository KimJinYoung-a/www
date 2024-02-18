<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbHelper.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/classes/cscenter/myqnacls.asp" -->

<%

dim boardqna
dim boarditem
dim id, page, title, qadiv, emailok, usermail, contents
dim userid, userlevel, username, orderserial, itemid, isusing

Dim mode		: mode		= req("mode","PNT")

Dim obj	: Set obj = new CMyQNA

Set obj.FOneItem = new CMyQNAItem

obj.FOneItem.Fuserid				= ""
obj.FOneItem.Fmd5Key				= requestCheckVar(req("MD5Key",""),32)
obj.FOneItem.FevalPoint				= requestCheckVar(req("evalPoint",0),8)

Dim ErrCode
ErrCode = obj.FrontProcData (mode)

Dim MD5Key	: MD5Key	= obj.FOneItem.FMD5Key
Set obj = Nothing

If mode = "PNT" Then
	If ErrCode = 0 Then		' 0이면 에러 없음
		If MD5Key = "" Then
		Else
			response.write "<script>alert('평가하였습니다.\n\n소중한 의견 감사합니다.');</script>"
			response.write "<script>top.location.href='http://www.10x10.co.kr/';</script>"
		End If 
	Else
		response.write "<script>alert('평가에 실패하였습니다.\n\n관리자에게 문의해 주십시오.');</script>"
		response.write "<script>history.back();</script>"
	End If 
End If
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
