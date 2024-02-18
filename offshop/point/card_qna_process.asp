<%@ codepage="65001" language="VBScript" %>
<% option explicit %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbHelper.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/classes/cscenter/myqnacls.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/offshop/lib/leftmenu/point_loginchk.asp" -->

<%
	If GetLoginUserID() = "" Then
		Response.Write "<script>alert('로그인을 하세요.');location.href='point_login.asp?reurl=/offshop/point/card_qna.asp';</script>"
		Response.End
	End If
	
dim boardqna
dim boarditem
dim id, page, title, qadiv, emailok, usermail, contents
dim userid, userlevel, username, orderserial, itemid, isusing, vOrder


userid = getLoginUserID
If userid = "" Then
	vOrder = vCardNo
Else
	vOrder = req("orderSerial","")
End If

userlevel = getLoginUserLevel
if userlevel="" then userlevel="5"

Dim mode		: mode		= req("mode","INS")

Dim obj	: Set obj = new CMyQNA

Set obj.FOneItem = new CMyQNAItem

obj.FOneItem.Fuserid				= getLoginUserID
obj.FOneItem.Fuserlevel				= userlevel
obj.FOneItem.FuserName				= str2html(req("userName",""))

obj.FOneItem.Fid					= req("id",0)
obj.FOneItem.FqaDiv					= req("qaDiv","")
obj.FOneItem.Ftitle					= str2html(req("title",""))
obj.FOneItem.Fcontents				= str2html(req("contents",""))
obj.FOneItem.FuserMail				= ReplaceBracket(req("userMail",""))
obj.FOneItem.FemailOK				= req("emailOK","Y")
obj.FOneItem.FitemID				= req("itemID",0)
obj.FOneItem.ForderSerial			= vOrder
obj.FOneItem.Fmd5Key				= req("MD5Key","")

obj.FOneItem.FevalPoint				= req("evalPoint",0)

'//스크립트 방지
if (checkNotValidHTML(obj.FOneItem.Ftitle) = True) then
	Alert_return("제목에는 HTML을 사용하실 수 없습니다.")
End If

if (checkNotValidHTML(obj.FOneItem.Fcontents) = True) then
	Alert_return("내용에는 HTML을 사용하실 수 없습니다.")
End If

if (checkNotValidHTML(obj.FOneItem.FuserMail) = True) then
	Alert_return("e-mail에는 HTML을 사용하실 수 없습니다.")
End if

Dim ErrCode
ErrCode = obj.FrontProcData (mode)

Dim MD5Key	: MD5Key	= obj.FOneItem.FMD5Key
Set obj = Nothing

If mode = "INS" Then 
    response.write "<script>alert('상담신청이 완료되었습니다.');</script>"
    response.write "<script>location.href='" & wwwUrl & "/offshop/point/card_qna.asp';</script>"
    response.write "<script>window.close()</script>"
ElseIf mode = "PNT" Then
	If ErrCode = 0 Then		' 0이면 에러 없음
		If MD5Key = "" Then
			response.write "<script>alert('평가하였습니다.\n\n소중한 의견 감사합니다.');</script>"
			response.write "<script>location.href='/my10x10/qna/myqnalist.asp';</script>"
		Else
			response.write "<script>alert('평가하였습니다.\n\n소중한 의견 감사합니다.');</script>"
			response.write "<script>top.location.href='http://www.10x10.co.kr/';</script>"
		End If 
	Else
		response.write "<script>alert('평가에 실패하였습니다.\n\n관리자에게 문의해 주십시오.');</script>"
		response.write "<script>history.back();</script>"
	End If 
ElseIf mode = "DEL" Then
    response.write "<script>alert('삭제되었습니다.');</script>"
    response.write "<script>location.href='/my10x10/qna/myqnalist.asp';</script>"
End If
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
