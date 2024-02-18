<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/login/checkUserGuestlogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbHelper.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/cscenter/myqnacls.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->

<%

dim boardqna
dim boarditem
dim id, page, title, qadiv, emailok, usermail, contents
dim userid, userlevel, username, orderserial, itemid, isusing, orderdetailidx
dim userphone, device, OS, OSetc, sqlStr

If IsUserLoginOK() Then
	userid = getEncLoginUserID ''GetLoginUserID
Else
	userid = GetLoginUserID
End If

userlevel = getLoginUserLevel
if userlevel="" then userlevel="5"

Dim mode		: mode		= req("mode","INS")


Dim obj	: Set obj = new CMyQNA

dim evalPoint
evalPoint = requestCheckVar(req("evalPoint",0),8)
if (evalPoint <> "") then
	if (evalPoint < 1) then
		evalPoint = 1
	elseif (evalPoint > 5) then
		evalPoint = 5
	end if
end if

qaDiv			= html2db(requestCheckVar(request("qaDiv"),2))
title			= html2db(CheckCurse(requestCheckVar(request("title"),128)))
contents		= html2db(CheckCurse(requestCheckVar(request("contents"),16000)))
userMail		= html2db(requestCheckVar(request("userMail"),128))
userphone		= html2db(requestCheckVar(request("userphone"),16))
emailOK			= html2db(requestCheckVar(request("emailOK"),1))
itemID			= html2db(requestCheckVar(getNumeric(request("itemID")),10))
orderDetailIDX	= html2db(requestCheckVar(request("orderDetailIDX"),20))
md5Key			= html2db(requestCheckVar(request("md5Key"),32))
orderSerial		= requestCheckVar(req("orderSerial",""),32)
device			= requestCheckVar(req("device",""),1)
OS				= requestCheckVar(req("OS",""),16)
OSetc			= requestCheckVar(req("OSetc",""),15)

if IsGuestLoginOK() then
	orderserial = GetGuestLoginOrderserial()
end if

if (emailOK = "") then
	emailOK = "Y"
end if

if (checkNotValidHTML(title) = True) then
	Alert_return("상담제목에는 HTML을 사용하실 수 없습니다.")
	dbget.Close
	response.end
end if

if (checkNotValidHTML(contents) = True) then
	Alert_return("상담내용에는 HTML을 사용하실 수 없습니다.")
	dbget.Close
	response.end
end if
username = GetLoginUserName()
'//이름 정보 없을때  개인정보 업데이트 2021-09-23 정태훈
If GetLoginUserName()="" and mode="INS" Then
	username = html2db(requestCheckVar(request("username"),32))
	''변경된 이미지 저장(기존에사용했음.주석만남김)
	sqlStr = "EXEC [db_user].[dbo].[usp_WWW_CSBoard_Username_Set] '" & userid & "', '" & Cstr(username) & "'"
	dbget.execute sqlStr
End If

Set obj.FOneItem = new CMyQNAItem

obj.FOneItem.Fuserid				= userid
obj.FOneItem.Fuserlevel				= userlevel
obj.FOneItem.FuserName				= username ''requestCheckVar(req("userName",""),32)

obj.FOneItem.Fid					= requestCheckVar(req("id",0),8)
obj.FOneItem.FqaDiv					= qaDiv
obj.FOneItem.Ftitle					= title
obj.FOneItem.Fcontents				= contents
obj.FOneItem.FuserMail				= userMail
obj.FOneItem.Fuserphone				= userphone
obj.FOneItem.FemailOK				= emailOK
obj.FOneItem.FitemID				= itemID
obj.FOneItem.ForderDetailIDX		= orderDetailIDX
obj.FOneItem.ForderSerial			= orderSerial
obj.FOneItem.Fmd5Key				= md5Key

obj.FOneItem.FevalPoint				= evalPoint
obj.FOneItem.Fdevice				= device
obj.FOneItem.FOS				= OS
obj.FOneItem.FOSetc				= OSetc
Dim ErrCode
ErrCode = obj.FrontProcData (mode)

Dim MD5Key	: MD5Key	= obj.FOneItem.FMD5Key
Set obj = Nothing

If mode = "INS" Then
	If ErrCode = 0 Then		' 0이면 에러 없음
	    response.write "<script>alert('상담신청이 완료되었습니다.');</script>"
		response.write "<script>parent.closePopup();</script>"
	else
		response.write "<script>alert('상담신청 처리중 오류가 발생했습니다.');</script>"
		response.write "<script>history.back();</script>"
	end If
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
