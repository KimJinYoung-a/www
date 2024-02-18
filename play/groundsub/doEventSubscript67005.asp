<%@codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
Response.CharSet = "UTF-8"
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<%
'########################################################
' PLAY #23 summer 5주차 
' 2015-08-28 이종화 작성
'########################################################

dim eCode, userid, referer, vQuery, totalVoteCnt
Dim spoint : spoint = requestcheckvar(request("spoint"),1)

	IF application("Svr_Info") = "Dev" THEN
		eCode   =  "64935"
	Else
		eCode   =  "67005"
	End If

	userid = GetEncLoginUserID
	referer = request.ServerVariables("HTTP_REFERER")

	If IsUserLoginOK() Then
	else
		response.write "<script>alert('로그인 후에 응모 하실 수 있습니다.');location.replace('" + Cstr(referer) + "');</script>"
		dbget.close() : Response.End
	End If

	If referer="" Or Len(referer)=0 Then
		response.write "<script>alert('정상적인 경로로 접근해주시기 바랍니다.');</script>"
	 	response.write "<script>location.replace('" + Cstr(referer) + "');</script>"
		response.End
	End If

	referer = request.ServerVariables("HTTP_REFERER")

	If IsUserLoginOK() Then 
		'// 하루 1회 1회 이상 참여여부 체크한다.
		vQuery = " Select count(userid) From [db_event].dbo.tbl_event_subscript Where evt_code='"&eCode&"' And userid='"&userid&"' and datediff(day,regdate,getdate()) = 0 "
		rsget.Open vQuery,dbget,1
		IF Not rsget.Eof Then
			totalVoteCnt = rsget(0)
		End IF
		rsget.close	

		If totalVoteCnt > 0 Then
			response.write "<script>alert('하루에 한 번씩만 미팅 참여가 가능합니다!');</script>"
			response.write "<script>location.replace('" + Cstr(referer) + "');</script>"
			response.End
		End If

		'// 해당 투표내역 집어넣는다.
		vQuery = "INSERT INTO [db_event].[dbo].[tbl_event_subscript](evt_code , sub_opt1 , userid, device) VALUES('" & eCode & "', '"& spoint &"' , '" & userid & "', 'W')"
		dbget.Execute vQuery
		response.write "<script>alert('데이트 신청이 완료되었습니다.');location.replace('" + Cstr(referer) + "&pagereload=ON');</script>"
		dbget.close()
		response.end
	End If
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->