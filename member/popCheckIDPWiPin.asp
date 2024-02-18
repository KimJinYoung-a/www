<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/email/maillib.asp" -->
<!-- #INCLUDE Virtual="/lib/email/maillib2.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/tenEncUtil.asp" -->
<!-- #include virtual="/member/iPin/nice.nuguya.oivs.asp" -->
<%

	'========================================================================================
	'=====	▣ 회원사 키스트링 설정 : 계약시에 발급된 키스트링(80자리)를 설정하십시오. ▣
	'========================================================================================	
	'//텐바이텐
	oivsObject.AthKeyStr = "ITTl2qgWEX6GL6nEsBTVrpbCooS4eN2Zpr1OPItNopj0xdnuJVSPaSIY06TV6IQExcsamhRVh9Jr1uz2" '//전달받은 키스트링(80자리) 입력

'	/****************************************************************************************
'	 *****	▣  한국신용정보로 부터 넘겨 받은 SendInfo 값을 복호화 한다 ▣
'	 ****************************************************************************************/
	oivsObject.resolveClientData(  Request.Form( "SendInfo" ) )

	'// 해킹방지를 위해 세션에 저장된 값과 비교 .. 
	Dim ssOrderNo
	ssOrderNo = session("niceOrderNo")
	''ssOrderNo = tenDec(request.cookies("niceChk")("niceOrderNo"))
	If  ssOrderNo <> oivsObject.ordNo then
		response.write "<script>alert('세션정보가 존재하지 않습니다.\n페이지를 새로고침 하신 후 다시 시도해주세요.');self.close();</script>"
		Response.End
	End If
	''response.cookies("niceChk")("niceOrderNo") = ""
	session("niceOrderNo") = ""

'//임시번호 생성
function RandomStr()
    dim str, strlen
    dim rannum, ix
    
    str = "abcdefghijklmnopqrstuvwxyz0123456789"
    strlen = 6
    
    Randomize
    
    For ix = 1 to strlen
    	 rannum = Int((36 - 1 + 1) * Rnd + 1)
    	 RandomStr = RandomStr + Mid(str,rannum,1)
    Next
end Function

'//회원비번 수정
sub setTempPassword(userid,strRdm)
    dim sqlStr
    dim Enc_userpass, Enc_userpass64
    
    Enc_userpass = MD5(CStr(strRdm))
    Enc_userpass64 = SHA256(MD5(CStr(strRdm)))
    
    
    '##########################################################
    '임시비밀번호로 변경
    sqlStr = " update [db_user].[dbo].[tbl_logindata]" + vbCrlf
    sqlStr = sqlStr + " set userpass=''" + vbCrlf
    sqlStr = sqlStr + " ,Enc_userpass='" + Enc_userpass + "'" + vbCrlf
    sqlStr = sqlStr + " ,Enc_userpass64='" + Enc_userpass64 + "'" + vbCrlf
    sqlStr = sqlStr + " where userid='" + userid + "'"
    rsget.Open sqlStr,dbget,1
    
    '##########################################################
end sub

	'==============================================================================
	'// 넘어온 값들로 중복체크 및 전송

	Dim mode, userid, username, strMsg, dupeInfo, connInfo
	Dim sql,usermail, joinDt
	dim strRdm
	dim refip

	'결과값에 대한 처리
	if oivsObject.retCd="1" then
		'정상 확인
	Else
		'정보 없음
		strMsg = getRealNameErrMsg(oivsObject.retDtlCd)
		response.write "<script>alert('" & strMsg & "');self.close();</script>"
		Response.End
	End if

	'정보 변수 할당
	username = oivsObject.niceNm
	dupeInfo = oivsObject.dupeInfo
	connInfo = left(trim(oivsObject.coInfo),88)

	refip = request.ServerVariables("REMOTE_ADDR")
	mode	= requestCheckVar(request("mode"),4)
	userid	= requestCheckVar(request("txUserID"),32)

'----------

'#######################################################################
' 사용자 정보 체크
'#######################################################################
''조회로그저장.
sql = "insert into [db_log].[dbo].tbl_user_search_log"
sql = sql + " (searchname,searchuid,searchuno,refip)"
sql = sql + " values("
sql = sql + " '" + LEFT(username,1) + "'"
sql = sql + " ,'" + userid + "'"
sql = sql + " ,'" + dupeInfo + "'"
sql = sql + " ,'" + refip + "'"
sql = sql + " )"
dbget.Execute sql

''배치조회막기.(최근 15분동안 검색수; 2009.05.21.허진원)
dim recentqcount
recentqcount=0
sql = "select count(idx) as cnt "
sql = sql + " from [db_log].[dbo].tbl_user_search_log "
sql = sql + " where refip='" + refip + "' "
sql = sql + " and datediff(n,regdate,getdate())<=15"

rsget.Open sql, dbget, 1
	recentqcount = rsget("cnt")
rsget.Close

if (recentqcount>11) then
    response.write "<script>alert('같은 아이피로 단시간 내에 연속으로 여러번 접속하였습니다.\n잠시 후 다시 시도해주세요.');self.close();</script>"
    response.end
end if


'////////// 분기 처리 ////////////
SELECT CASE mode
CASE "id"		'-- 아이디 찾기 (화면 출력) ------------------------------------
	sql = "EXEC [db_user_Hold].[dbo].[usp_WWW_FindUseridCI_Get] '" & connInfo & "'"
	rsget.CursorLocation = adUseClient
	rsget.Open sql, dbget, adOpenForwardOnly, adLockReadOnly
	
	if  not rsget.EOF  then
		userid = rsget("userid")
		joinDt = rsget("regdate")
	end if
	rsget.Close

	
	if Not(userid="" or isNull(userid)) then
	    strMsg = "<li>- <strong>" & userid & "</strong> (가입일자 : " & left(FormatDateTime(joinDt,1),len(FormatDateTime(joinDt,1))-4) & ")</li>"
	else
		strMsg = "<strong>입력하신 정보와 일치하는 아이디가 없습니다. 다시 입력 부탁드립니다.</strong>"
	end if

	Response.Write	"<script type='text/javascript'>" & vbCrLf &_
					"opener.document.getElementById('lyrIDResult').style.display='';" & vbCrLf &_
					"opener.document.getElementById('lyrResultIdList').innerHTML='" & strMsg & "';" & vbCrLf &_
					"self.close();" & vbCrLf &_
					"</script>"
	Response.End
	
CASE "pass"		'-- 패스워드 찾기 (이메일 발송) ------------------------------------

	sql = "EXEC [db_user_Hold].[dbo].[usp_WWW_FindUsermailCI_Get] '" & userid & "', '" & connInfo & "'"
	rsget.CursorLocation = adUseClient
	rsget.Open sql, dbget, adOpenForwardOnly, adLockReadOnly

	if  not rsget.EOF  then
		usermail = rsget("usermail")
	end if
	rsget.Close

	'' email 일부 *** 처리.
	dim dispUserMail,GolPos
	''Left of @
	GolPos = InStr(usermail,"@")
	
	if (GolPos>0) then
	    dispUserMail = Left(usermail,GolPos-1)
	    
	    if (Len(dispUserMail)>2) then
	        dispUserMail = Left(dispUserMail,Len(dispUserMail)-2) + "**"
	    else
	        dispUserMail = "**"
	    end if
	    
	    dispUserMail = dispUserMail & Mid(usermail,GolPos,255)
	end if
	
	
	if (usermail = "") then
			response.write "<script>alert('검색결과가 존재하지 않습니다.');self.close();</script>"
			response.end
	else
			strRdm = RandomStr()
			call setTempPassword(userid,strRdm)
		    call sendmailsearchpass(usermail,username,strRdm)

			response.write "<script>alert('가입 당시 이메일로 임시 비밀번호를 보내드렸습니다.\n확인하시기 바랍니다. " + dispUserMail + "');self.close();</script>"
			response.end
	end if

Case Else
	response.write "<script>alert('데이터 처리에 문제가 발생하였습니다.\n죄송합니다. 다시 시도해 주시기 바랍니다.');self.close();</script>"
	Response.End
End Select
%>

<!-- #include virtual="/lib/db/dbclose.asp" -->
