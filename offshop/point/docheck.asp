<%@ codepage="65001" language="VBScript" %>
<% option explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/member/realname/nice.nuguya.oivs.asp"-->
<%
'##########################################
'# 2013.02.18; 실명확인 사용 안함
Call Alert_Move("사용이 정지된 페이지입니다.","/")
dbget.Close(): Response.End
'##########################################


'==============================================================================
'외부 URL 체크
dim backurl
backurl = request.ServerVariables("HTTP_REFERER")
if InStr(LCase(backurl),"10x10.co.kr") < 1 then response.end

'==============================================================================
dim uip, chkYn, strMsg
dim username, socno1, socno2, birthDt
Const CCurrentSite = "10x10"
Const COtherSite   = "academy"

uip = Left(request.ServerVariables("REMOTE_ADDR"),32)

'==============================================================================
'배치확인 검사
if Not(getCheckBatchUser(uip)) then
	Response.Write "<script langauge=javascript>" &_
					"alert('같은 아이피로 단시간 내에 연속으로 여러번 접속하였습니다.\n잠시 후 다시 시도해주세요.');" &_
					"location.href="""&wwwUrl&"/member/gatepage.asp?sMsg=같은 아이피로 단시간 내에 연속으로 여러번 접속하였습니다.<br>잠시 후 다시 시도해주세요.&nbsp;"" "&_							
					"</script>"
	Response.End
end if

	'	//#######################################################################################
	'	//#####
	'	//#####	개인/외국인 실명확인 서비스 소스 (실명확인요청)				한국신용정보(주)
	'	//#####	( JScript 처리 )
	'	//#####
	'	//#######################################################################################
	
	'	//=======================================================================================
	'	//=====	MAIN PROCESS
	'	//=======================================================================================
	
		dim strNiceId, strSuccUrl, strFailUrl, strReturnUrl

	
	'	/****************************************************************************************
	'	 *****	▣  NiceCheck.htm 에서 넘겨 받은 SendInfo 값을 복호화 하여 
	'	 *****		주민번호,성명 등 각각의 값을 세팅한다 ▣
	'	 ****************************************************************************************/
		oivsObject.clientData = Request.Form( "SendInfo" )
		oivsObject.desClientData()
	
		'// 복호화 된 값은 아래 주석을 풀어 확인 가능합니다. 기존 회원 체크는 이 부분에서 하시면 됩니다.
	'	response.write("<BR>성명 : "  & oivsObject.userNm)
	'	response.write("<BR>주민번호/외국인번호 : "  & oivsObject.resIdNo)
	'	response.write("<BR>조회사유코드 : "  & oivsObject.inqRsn)
	'	response.write("<BR>내/외국인 구분코드 : "  & oivsObject.foreigner)
	'	response.end


	'	/****************************************************************************************
	'	 *****	▣ 회원사 ID 설정 : 계약시에 발급된 회원사 ID를 설정하십시오. ▣
	'	 ****************************************************************************************/
		Select Case oivsObject.foreigner
			Case 1
				strNiceId = "Ntenxten2"		'내국인 확인
			Case 2
				strNiceId = "Ntenxten3"		'외국인 확인
			Case Else
				Response.Write "<script langauge=javascript>" &_
								"alert('내/외국인 구분값이 없습니다.');" &_
								"location.href="""&wwwUrl&"/member/gatepage.asp?sMsg=내/외국인 구분값이 없습니다. "" "&_								
								"</script>"
				Response.End
		end Select


	'	/****************************************************************************************
	'	 *****	▣ 실명확인 서비스를 호출한다. ▣
	'	 ****************************************************************************************/
		oivsObject.niceId = strNiceId
		oivsObject.callService()
	
		 
	'	//==================================================================================================================
	'	//				응답에 대한 결과 및 변수들에 대한 설명
	'	//------------------------------------------------------------------------------------------------------------------
	'	//
	'	//	< 한국신용정보 온라인 식별 서비스에서 제공하는 정보 >
	'	//
	'	//	oivsObject.message			: 오류 또는 정보성 메시지
	'	//	oivsObject.retCd			: 결과 코드(메뉴얼 참고)// cf. 한국신용정보 성명 등록 및 정정 페이지 : https://www.nuguya.com
	'	//	oivsObject.retDtlCd			: 결과 상세 코드(메뉴얼 참고)
	'	//	oivsObject.minor 			: 성인인증 결과 코드
	'	//									"1"	: 성인
	'	//									"2"	: 미성년
	'	//									"9"	: 확인 불가
	'	//	oivsObject.dupeInfo         : 중복가입확인정보 (iPin서비스를 신청해야 넘어옴.. : 차후 사용.)
	'	//
	'	//=================================================================================================================
	
	'*******************************************
	'* 텐바이텐 처리 부분
	'*******************************************
	
	'결과값에 대한 처리
	Select Case oivsObject.retCd
		Case "1"		'정상 확인
			chkYn = "Y"
			strMsg = "실명 확인"
		Case "2"		'확인 실패
			chkYn = "N"
			strMsg = getRealNameErrMsg(oivsObject.retDtlCd)
		Case Else		'정보 없음
			chkYn = "N"
			strMsg = getRealNameErrMsg(oivsObject.retDtlCd)
	End Select

	'전송 정보 변수 할당
	username = oivsObject.userNm
	socno1   = left(trim(oivsObject.resIdNo),6)
	socno2   = right(trim(oivsObject.resIdNo),7)
	
	'로그저장
	Call saveCheckLog("RN",oivsObject.userNm,socno1,MD5(CStr(socno2)),uip,chkYn,oivsObject.retCd,oivsObject.retDtlCd,strMsg,"")
	
	'실패면 안내후 빽!
	if chkYn="N" then
		Response.Write "<script langauge=javascript>" &_
						"alert('" & strMsg & "');" &_
						"location.href="""&wwwUrl&"/member/gatepage.asp?sMsg="&strMsg&" "" "&_
						"</script>"
		Response.End
	end if

'==============================================================================



dim juminno, jumin1, sexflag, Enc_jumin2, result

juminno = CStr(socno1) + "-" + CStr(socno2)
jumin1  = CStr(socno1)
sexflag = Left(socno2, 1)
Enc_jumin2 = MD5(CStr(socno2))

if trim(juminno)="-" then
	result = "socnofail"
end if
'==============================================================================

'기존에 같은 주민번호가 있는지 체크(기존 주민번호 및 새 주민번호 모두 체크)
dim sqlStr, cnt
dim finedUserid

sqlStr = " select top 1 userid "
sqlStr = sqlStr + " from [db_user].[dbo].tbl_user_n "

''비 암호화
''sqlStr = sqlStr + " where juminno = ('" + juminno + "')"

''암호화 사용
sqlStr = sqlStr + " where ((jumin1 = '" + jumin1 + "') and (Enc_jumin2 = '" + Enc_jumin2 + "')) "

rsget.Open sqlStr,dbget,1
cnt = 0
if Not rsget.Eof then
        cnt = 1
        finedUserid = rsget("userid")
end if
rsget.close

if (cnt > 0) then
        result = "exist"
end if


''#### 사용 사이트 Check (핑거스 가입후 텐바이텐 이용안함 원하는 고객.) ######
if (result = "exist") then
    sqlStr = " select count(*) as cnt "
    sqlStr = sqlStr & " from db_user.dbo.tbl_user_allow_site"
    sqlStr = sqlStr & " where userid='" & finedUserid & "'"
    sqlStr = sqlStr & " and userid<>''"
    sqlStr = sqlStr & " and sitegubun='" & CCurrentSite & "'"
    sqlStr = sqlStr & " and siteusing='N'"

    rsget.Open sqlStr,dbget,1
        ''특정사이트 이용안함.
        if (rsget("cnt")>0) then
            result = "existNotUsing"
        end if
    rsget.Close
    
    if (result = "existNotUsing") then
        ''핑거스도 사용안하는경우..
        sqlStr = " select count(*) as cnt "
        sqlStr = sqlStr & " from db_user.dbo.tbl_user_allow_site"
        sqlStr = sqlStr & " where userid='" & finedUserid & "'"
        sqlStr = sqlStr & " and userid<>''"
        sqlStr = sqlStr & " and sitegubun='" & COtherSite & "'"
        sqlStr = sqlStr & " and siteusing='N'"
        rsget.Open sqlStr,dbget,1
            if (rsget("cnt")>0) then
                result = "existsAllNotUsing"
            end if
        rsget.Close
    end if
end if
''#############################


'개발자테스트용
if ("7205151229427" = (CStr(socno1) + CStr(socno2))) or ("7310131041421" = (CStr(socno1) + CStr(socno2))) then
    result = ""
end if


'==============================================================================
'주민번호가 유효한지 체크(실명확인 인증으로 대체)
if (result = "") then
        'if (IsValidSocNo(socno1, socno2) = false) then
        '        result = "notvalidsocno"
        'end if
end if

'==============================================================================
'14세(한국나이)가 넘었는지 검사
if (result = "") then
	'생년월일산출
	Select Case left(socno2,1)
		Case "0","8"				'1800년대출생
			birthDt = DateSerial("18" & left(socno1,2),mid(socno1,3,2),right(socno1,2))
		Case "1","2","5","6"		'1900년대출생
			birthDt = DateSerial("19" & left(socno1,2),mid(socno1,3,2),right(socno1,2))
		Case "3","4","7","8"		'2000년대출생
			birthDt = DateSerial("20" & left(socno1,2),mid(socno1,3,2),right(socno1,2))
	End Select

    if DateDiff("yyyy",birthDt,date())<13 then
            result = "limitage"
    end if
end if
'==============================================================================
if (result = "") then
        result = "ok"
end if


'==============================================================================
function IsValidSocNo(socno1, socno2)
        dim chk, sumvalue, i, socno

        socno = CStr(socno1) + CStr(socno2)
        chk = "234567892345"
        sumvalue = 0
        for i = 0 to 11
                sumvalue = sumvalue + (CInt(Mid(socno, (i + 1), 1)) * CInt(Mid(chk, (i + 1), 1)))
        next
        sumvalue = 11 - (sumvalue mod 11)
        sumvalue = sumvalue mod 10

        if (sumvalue <> CInt(Right(socno, 1))) then
                IsValidSocNo = false
        else
                IsValidSocNo = true
        end if
end function

'//최근 IP에서 접근한적이 있는가? - 최근 1분내 3번까지 실명확인허용(배치 검사 제외)
function getCheckBatchUser(uip)
	dim strSql
	strSql = "Select count(chkIdx) " &_
			" From db_log.dbo.tbl_user_checkLog " &_
			" where chkIP='" & uip & "'" &_
			"	and datediff(n,chkDate,getdate())<=1 "
	rsget.Open strSql, dbget, 1
	if rsget(0)>3 then
		getCheckBatchUser = false
	else
		getCheckBatchUser = true
	end if
	rsget.Close
end function

'//확인 로그를 남긴다
Sub saveCheckLog(cDv,unm,jm1,jm2e,uip,uYn,rcd,dcd,rmsg,uid)
	'구분(chkDiv) : RN : 실명확인, CP : 본인확인
	dim strSql
	strSql = "Insert into db_log.dbo.tbl_user_checkLog "
	strSql = strSql & " (chkDiv,chkName,jumin1,jumin2_Enc,chkIP,chkYN,rstCD,rstDtCd,rstMsg,userid) values "
	strSql = strSql & "('" & cDv & "'"
	strSql = strSql & ",'" & unm & "'"
	strSql = strSql & ",'" & jm1 & "'"
	strSql = strSql & ",''"
	strSql = strSql & ",'" & uip & "'"
	strSql = strSql & ",'" & uYn & "'"
	strSql = strSql & ",'" & rcd & "'"
	strSql = strSql & ",'" & dcd & "'"
	strSql = strSql & ",'" & rmsg & "'"
	if uid="" then
		strSql = strSql & ",null)"
	else
		strSql = strSql & ",'" & uid & "')"
	end if
	dbget.Execute(strSql)
end Sub
%>
<form name="frm1" method="post" action="<%=wwwUrl%>/offshop/point/card_reg_write.asp" target="_top">
<input type="hidden" name="searching" value="o">
<input type="hidden" name="username" value="<%=username%>">
<input type="hidden" name="userssn1" value="<%=socno1%>">
<input type="hidden" name="userssn2" value="<%=socno2%>">
</form>
<script language="javascript">

<% If result = "exist" Then %>
                //alert("이미 가입하셨습니다.");
		 		frm1.submit();
<% ElseIf result = "socnofail" Then %>
                alert("실명이 아닙니다.");
                location.href="<%=wwwUrl%>/offshop/point/card_reg.asp?sMsg=실명이 아닙니다."     
<% ElseIf result = "notvalidsocno" Then %>
                alert("정상적인 주민번호가 아닙니다.");
                location.href="<%=wwwUrl%>/offshop/point/card_reg.asp?sMsg=정상적인 주민번호가 아닙니다."   
<% ElseIf result = "existNotUsing" Then %>
                alert("귀하는 텐바이텐 서비스에 이미 회원 가입하셨습니다. \n텐바이텐 쇼핑몰을 이용하시려면 핑거스 My Fingers에서 \n이용사이트 설정을 수정하시면 텐바이텐 서비스를 바로 이용하실 수 있습니다.");
                location.href="<%=wwwUrl%>/offshop/point/card_reg.asp?sMsg=귀하는 텐바이텐 서비스에 이미 회원 가입하셨습니다. <br>텐바이텐 쇼핑몰을 이용하시려면 핑거스 My Fingers에서 <br>이용사이트 설정을 수정하시면 텐바이텐 서비스를 바로 이용하실 수 있습니다.<br>(<a href='http://thefingers.co.kr/myfingers/membermodify.asp' target='_blank'>-&gt;My Fingers 바로가기</a>)<br>&nbsp;"                
<% ElseIf result = "existsAllNotUsing" Then %>
                alert("가입후 사용 중지 하신 상태입니다. 고객센터로 문의해 주세요");
                location.href="<%=wwwUrl%>/offshop/point/card_reg.asp?sMsg=가입후 사용 중지 하신 상태입니다. 고객센터로 문의해 주세요. "                
<% ElseIf result = "limitage" Then %>
                alert("만 14세 미만인 분은 가입할 수 없습니다.");
                location.href="<%=wwwUrl%>/offshop/point/card_reg.asp?sMsg= 만 14세 미만인 분은 가입할 수 없습니다."
<% Else %>
				frm1.submit();
<% End If  %>
	
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->