<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description :  2015오픈이벤트 vipGift - 이벤트 연장
' History : 2015-04-10 이종화
'###########################################################
%>
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
Dim vTotalCount , vTotalCount2 , vQuery , allcnt
dim eCode, userid, sqlstr, refer , mode , preCode
Dim reqname , reqhp1 , reqhp2 , reqhp3 , txZip1 ,  txZip2 , txAddr1 , txAddr2
Dim zipcode , usercell

	IF application("Svr_Info") = "Dev" THEN
		preCode		=  60744 '//지난 이벤트
		eCode		=  61776
	Else
		preCode		=  60833 '//지난 이벤트
		eCode		=  62224
	End If
	userid	= getloginuserid()
	mode	= requestcheckvar(request("mode"),4)

	reqname	= requestcheckvar(request("reqname"),32)
	reqhp1	= requestcheckvar(request("reqhp1"),3)
	reqhp2	= requestcheckvar(request("reqhp2"),4)
	reqhp3	= requestcheckvar(request("reqhp3"),4)
	txZip1	= requestcheckvar(request("txZip1"),3)
	txZip2	= requestcheckvar(request("txZip2"),3)
	txAddr1	= requestcheckvar(request("txAddr1"),100)
	txAddr2	= requestcheckvar(request("txAddr2"),100)

	zipcode = txZip1 &"-"& txZip2
	usercell = reqhp1 &"-"& reqhp2 &"-"& reqhp3 


	refer = request.ServerVariables("HTTP_REFERER")
	if InStr(refer,"10x10.co.kr")<1 then
		Response.Write "잘못된 접속입니다."
		dbget.close() : Response.End
	end If
	
	if not(Date()>="2015-05-06" and Date()<"2015-05-21" ) then
		Response.Write "<script type='text/javascript'>alert('이벤트가 종료 되었습니다.'); parent.top.location.href='/event/eventmain.asp?eventid="& eCode &"'</script>"
		dbget.close() : Response.End
	End If

	If userid = "" Then
		Response.Write "<script type='text/javascript'>alert('로그인을 하셔야 참여가 가능 합니다.'); parent.top.location.href='/event/eventmain.asp?eventid="& eCode &"'</script>"
		dbget.close() : Response.End
	End If

	If Not(GetLoginUserLevel = 3 Or GetLoginUserLevel = 4) Then
		Response.write "<script>alert('VIP 등급만 참여 하실 수 있습니다.'); parent.top.location.href='/event/eventmain.asp?eventid="& eCode &"'</script>"
		dbget.close() : Response.End
	End If

	'// 응모 확인 - 지난 회차
	vQuery = "SELECT count(*) FROM [db_event].[dbo].[tbl_event_subscript] WHERE userid = '" & userid & "' And evt_code='"&preCode&"' "
	rsget.Open vQuery,dbget,1
	IF Not rsget.Eof Then
		vTotalCount = rsget(0)
	End If
	rsget.close()

	If vTotalCount > 0 Then
		response.write "<script>alert('이벤트는 ID당 1회만 참여할 수 있습니다.'); parent.top.location.href='/event/eventmain.asp?eventid="& eCode &"'</script>"
		dbget.close()
		response.end
	End If 

	'// 응모 확인 - 이번 회차
	vQuery = "SELECT count(*) FROM [db_temp].[dbo].[tbl_temp_event_addr] WHERE userid = '" & userid & "' And evt_code='"&eCode&"' "
	rsget.Open vQuery,dbget,1
	IF Not rsget.Eof Then
		vTotalCount2 = rsget(0)
	End If
	rsget.close()

	If vTotalCount2 > 0 Then
		response.write "<script>alert('이벤트는 ID당 1회만 참여할 수 있습니다.'); parent.top.location.href='/event/eventmain.asp?eventid="& eCode &"'</script>"
		dbget.close()
		response.end
	End If 
	
	'// 전체 인원수 확인
	vQuery = "SELECT count(*) FROM [db_temp].[dbo].[tbl_temp_event_addr] WHERE evt_code='"&eCode&"' "
	rsget.Open vQuery,dbget,1
	IF Not rsget.Eof Then
		allcnt = rsget(0)
	End If
	rsget.close()

	if mode="inst" Then
		If allcnt < 3900 Then '// 3900명 제한
			sqlstr = "INSERT INTO [db_temp].[dbo].[tbl_temp_event_addr](evt_code, userid, username , usercell, zipcode, addr1, addr2 , device)" + vbcrlf
			sqlstr = sqlstr & " VALUES("& eCode &", '" & userid & "', '" & reqname & "' , '" & usercell & "' , '"& zipcode &"', '"& txAddr1 &"' , '"& txAddr2 &"' , 'W')" + vbcrlf
			'response.write sqlstr & "<Br>"
			dbget.execute sqlstr
			Response.Write "<script>" &_
					"alert('신청이 완료 되었습니다.\n1차 : 5월 14일(목) 2차 : 5월 21(목) 발송 됩니다.');" &_
					"parent.top.location.href='/event/eventmain.asp?eventid="& eCode &"'" &_
					"</script>"
			dbget.close() : Response.End
		Else
			response.write "<script>alert('죄송합니다\n본 이벤트는 한정수량으로 조기에 선착순 마감되었습니다.'); parent.top.location.href='/event/eventmain.asp?eventid="& eCode &"'</script>"
			dbget.close()
			response.end
		End If 
	else
		Response.Write "<script type='text/javascript'>alert('정상적인 경로가 아닙니다.'); parent.top.location.href='/event/eventmain.asp?eventid="& eCode &"'</script>"
		dbget.close() : Response.End
	end if
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->