<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"

'#############################################################
'	Description : HITCHHIKER
'	History		: 2014.08.08 유태욱 생성
'#############################################################
%>
<!-- #include virtual="/login/logincheckandback.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/classes/enjoy/hitchhikerCls.asp" -->
<%
Dim chkid, chklevel , st_date , ed_date , dl_date
chkid 	= requestCheckVar(request.Form("chkid"),32)
st_date = requestCheckVar(request.Form("st_date"),10)
ed_date = requestCheckVar(request.Form("ed_date"),10)
dl_date = requestCheckVar(request.Form("dl_date"),10)

Dim hitch
Set hitch = new Hitchhiker
hitch.FUserId = GetLoginUserID
hitch.fnGetHitchCont
chklevel = hitch.FUserlevel

Dim alertDate, aVol, currdate
currdate = date()
If cstr(currdate) >= cstr(st_date) and cstr(currdate) <= cstr(ed_date) Then
	aVol = "1"											'### 차수
	alertDate = FormatDate(cstr(dl_date),"M/D")							'### 발송일
'ElseIf date >= "2016-09-12" and date <= "2016-09-18" Then
'	aVol = "2"
'	alertDate = "09월 29일"
End If
	
'// 아이디 확인  //
IF chkid <> getEncLoginUserID THEN
	response.write "<script>alert('아이디 정보가 일치하지 않습니다.');top.location.href='"&wwwURL&"/hitchhiker/';</script>"
	response.end
END IF

'// vip 회원이상만 신청가능 //
IF (chklevel <> 3 and chklevel <> 4 and chklevel <> 6 and chkid <> "kjy8517" and chkid <> "kobula" and chkid <> "dream1103" and chkid <> "star088" and chkid <> "okkang77" and chkid <> "tozzinet" and chkid <> "baboytw" And chkid <> "motions") THEN 
	response.write "<script>alert('마이텐바이텐의 회원등급을 확인해주세요!');top.location.href='"&wwwURL&"/hitchhiker/';</script>"
	response.end
END IF

Dim zipcode, addr1, addr2, userphone, usercell
Dim strSql,strQuery
Dim iHVol, username

'zipcode = requestCheckVar(request.Form("txZip1"),3) + "-" + requestCheckVar(request.Form("txZip2"),3)
zipcode = requestCheckVar(request.Form("txZip"),8)
addr1 = html2db(request.Form("txAddr1"))
addr2 = html2db(request.Form("txAddr2"))

userphone = requestCheckVar(request.Form("reqphone1"),3) + "-" + requestCheckVar(request.Form("reqphone2"),4) + "-" + requestCheckVar(request.Form("reqphone3"),4)
usercell = requestCheckVar(request.Form("reqhp1"),3)+ "-" + requestCheckVar(request.Form("reqhp2"),4) + "-" +requestCheckVar(request.Form("reqhp3"),4)
iHVol = requestCheckVar(request.Form("iHVol"),10)
username = requestCheckVar(request.Form("reqname"),32)

Dim appCount
rsget.open "select count(1) as appCount from [db_user].[dbo].[tbl_user_hitchhiker] where HVol = '"&iHVol&"'",dbget,1
If not rsget.eof Then
	appCount = rsget("appCount")
Else
	appCount = 0
End If
rsget.close

If appCount > 10000 Then
	response.write "<script>alert('아쉽게도 선착순 신청이 마감되었어요!\n다음 기회에 참여해주세요 :)');top.location.href='"&wwwURL&"/hitchhiker/';</script>"
	response.End
End If

If requestCheckVar(request.Form("txZip"),8) = "" OR addr1 = "" OR addr2 = "" OR requestCheckVar(request.Form("reqhp1"),3) = "" OR requestCheckVar(request.Form("reqhp2"),3) = "" OR requestCheckVar(request.Form("reqhp3"),3) = "" OR iHvol = "" OR username = "" Then
	response.write "<script>alert('주소 입력이 잘 못 되었습니다.');top.location.href='"&wwwURL&"/hitchhiker/';</script>"
	response.end
End If

dbget.beginTrans

'	strSql = " UPDATE [db_user].[dbo].tbl_user_n" & VbCrlf
'	strSql = strSql & " SET " & VbCrlf
'	strSql = strSql & " zipcode='" + zipcode + "'" & VbCrlf
'	strSql = strSql & " ,useraddr='" + addr2 + "'" & VbCrlf
'	strSql = strSql & " ,userphone='" + userphone + "'" & VbCrlf
'	strSql = strSql & " ,usercell='" + usercell + "'"  & VbCrlf
'	strSql = strSql & " where userid='" + chkid + "'"
'	dbget.execute strSql

	strQuery =" SELECT userid FROM [db_user].[dbo].[tbl_user_hitchhiker] WHERE HVol = "&iHVol&" and userid ='"&chkid&"'"
	rsget.Open strQuery, dbget
	IF NOT (rsget.EOF OR rsget.BOF) THEN
		strSql = "UPDATE [db_user].[dbo].[tbl_user_hitchhiker] "	& VbCrlf
		strSql = strSql & " SET ApplyDate =getdate(), recevieName='"& username&"', zipcode='"&zipcode&"', useraddr='"& addr2&"', userphone='"& userphone&"', usercell='"& usercell&"',zipaddr='"& addr1&"' " & VbCrlf
		strSql = strSql & " WHERE HVol = "& iHVol & VbCrlf
		strSql = strSql & " and userid='"&chkid&"'"
	ELSE
		strSql = "INSERT INTO [db_user].[dbo].[tbl_user_hitchhiker] "	& VbCrlf
		strSql = strSql & " (HVol, userid, ApplyVol,recevieName, zipcode, useraddr, userphone, usercell, zipaddr)" & VbCrlf
		strSql = strSql & " VALUES " & VbCrlf
		strSql = strSql & " ("&iHVol&",'"&chkid&"','"&aVol&"','"&username&"','"&zipcode&"','"&addr2&"','"&userphone&"','"&usercell&"','"&addr1&"')"
	END IF
		dbget.execute strSql
	rsget.Close

IF Err.Number = 0 THEN
	dbget.CommitTrans
		response.Cookies("hitchVIP").domain = "10x10.co.kr"
		response.Cookies("hitchVIP")("mode") = "x"
		response.cookies("hitchVIP").Expires = Date + 30

		response.write "<script>alert('고맙습니다. "&alertDate&" 일괄 우편 발송됩니다.');top.location.href='"&wwwURL&"/hitchhiker/';</script>"
		response.end
Else
   	dbget.RollBackTrans
		response.write "<script>alert('데이터 처리에 실패하였습니다. 다시 시도해 주세요.\n\n 지속적으로 문제 발생시 고객센터로 연락주세요.');top.location.href='"&wwwURL&"/hitchhiker/';</script>"
		response.end
End IF
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->