<%@  codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description :  2015오픈이벤트 새로고침
' History : 2015.04.09 유태욱 생성
'###########################################################
%>
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->

<%
Dim vTotalCount, vQuery
dim eCode, userid, mode, sqlstr, refer, txtcomm, sub_idx
	eCode=getevt_code
	userid = getloginuserid()
	mode = requestcheckvar(request("mode"),32)
	sub_idx = requestcheckvar(request("sub_idx"),10)
	txtcomm = requestcheckvar(request("txtcomm"),300)

function getnowdate()
	dim nowdate
	
	nowdate = date()
'	nowdate = "2015-04-13"
	
	getnowdate = nowdate
end function

function getevt_code()
	dim evt_code
	
	IF application("Svr_Info") = "Dev" THEN
		evt_code   =  60742
	Else
		evt_code   =  60835
	End If
	
	getevt_code = evt_code
end function

refer = request.ServerVariables("HTTP_REFERER")

if InStr(refer,"10x10.co.kr")<1 then
	Response.Write "잘못된 접속입니다."
	dbget.close() : Response.End
end if

'// 마일리지 받았는지 확인(아이디당 1회만 받을 수 있음)
vQuery = "SELECT count(*) FROM [db_event].[dbo].[tbl_event_subscript] WHERE userid = '" & userid & "' And evt_code='"&eCode&"' "
rsget.Open vQuery,dbget,1
IF Not rsget.Eof Then
	vTotalCount = rsget(0)
End IF

If userid = "" Then
	Response.Write "<script type='text/javascript'>alert('로그인을 하셔야 참여가 가능 합니다.');</script>"
	dbget.close() : Response.End
End IF
If not(getnowdate>="2015-04-13" and getnowdate<"2015-04-25") Then
	Response.Write "<script type='text/javascript'>alert('이벤트 응모 기간이 아닙니다.'); parent.location.reload();</script>"
	dbget.close() : Response.End
End IF

if mode="addcomment" then
	if txtcomm="" then
		Response.Write "<script type='text/javascript'>alert('내용을 입력해 주세요.'); parent.location.reload();</script>"
		dbget.close() : Response.End		
	end if	
	if checkNotValidTxt(txtcomm) then
		Response.Write "<script type='text/javascript'>alert('내용에 유효하지 않은 글자가 포함되어 있습니다. 다시 작성 해주세요.'); parent.location.reload();</script>"
		dbget.close() : Response.End		
	end if

	sqlstr = "INSERT INTO [db_event].[dbo].[tbl_event_subscript](evt_code, userid, sub_opt1, sub_opt3, device)" + vbcrlf
	sqlstr = sqlstr & " VALUES("& eCode &", '" & userid & "', '" & eCode & "' , '"& html2db(txtcomm) &"' , 'W')" + vbcrlf
	'response.write sqlstr & "<Br>"
	dbget.execute sqlstr
	if vTotalCount < 1 then
		Response.Write "<script>" &_
				"alert('소중한 댓글 감사합니다!\n100 마일리지가 지급되었습니다.');" &_
				"parent.location.reload();" &_
				"</script>"
	else
		Response.Write "<script>" &_
				"alert('소중한 댓글 감사합니다!');" &_
				"parent.location.reload();" &_
				"</script>"
	end if

	if vTotalCount < 1 then
		'// 마일리지 테이블에 넣는다.
		vQuery = " update [db_user].[dbo].[tbl_user_current_mileage] set bonusmileage = bonusmileage + 100, lastupdate=getdate() Where userid='"&userid&"' "
		dbget.Execute vQuery
	
		'// 마일리지 로그 테이블에 넣는다.
		vQuery = " insert into db_user.dbo.tbl_mileagelog(userid , mileage , jukyocd , jukyo , deleteyn) values ('"&userid&"', '+100','"&eCode&"', '축하 코멘트 새로고침 100마일리지','N') "
		dbget.Execute vQuery
	
		'// 이벤트 테이블에 내역을 남긴다.
		vQuery = "INSERT INTO [db_event].[dbo].[tbl_event_subscript](evt_code, userid, sub_opt1, sub_opt3, device) VALUES('" & eCode & "', '" & userid & "','60835마일리지지급' ,'100마일리지 지급', 'W')"
		dbget.Execute vQuery
	end if
elseif mode="delcomment" then
	If sub_idx = "" Then
		Response.Write "<script type='text/javascript'>alert('구분자가 없습니다.'); parent.location.reload();</script>"
		dbget.close() : Response.End
	End IF

	sqlstr="delete from db_event.dbo.tbl_event_subscript where sub_idx='"& sub_idx &"' and userid='"& userid &"' and evt_code='"& eCode &"'"
	'response.write sqlstr & "<Br>"
	dbget.execute sqlstr

	Response.Write "<script type='text/javascript'>alert('삭제되었습니다.'); parent.location.reload();</script>"

else
	Response.Write "<script type='text/javascript'>alert('정상적인 경로가 아닙니다.'); parent.location.reload();</script>"
	dbget.close() : Response.End
end if
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->