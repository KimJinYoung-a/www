<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbHelper.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<%
	'// 변수 선언
	dim orderserial, mode
	dim busiIdx, busiNo, busiName, busiCEOName
	dim busiAddr, busiType, busiItem, userid, orderIdx
	dim itemname, totalPrice, totalTax, repName, repTel, repEmail, isueDate
	dim SQL, msg, retURL

	'// 전송값 저장
	mode =			Request("mode")
	busiIdx =		RequestCheckVar(Request("busiIdx"),10)
	orderserial =	RequestCheckVar(Request("orderserial"),11)
	busiNo =		RequestCheckVar(Request("busiNo1") & "-" & Request("busiNo2") & "-" & Request("busiNo3"),16)
	busiName =		RequestCheckVar(html2db(Request("busiName")),32)
	busiCEOName =	RequestCheckVar(html2db(Request("busiCEOName")),32)
	busiAddr =		RequestCheckVar(html2db(Request("busiAddr")),200)
	busiType =		RequestCheckVar(html2db(Request("busiType")),50)
	busiItem =		RequestCheckVar(html2db(Request("busiItem")),50)

	orderIdx =		RequestCheckVar(Request("orderIdx"),10)
	itemname =		RequestCheckVar(html2db(Request("itemname")),200)
	totalPrice =	RequestCheckVar(Request("totalPrice"),10)
	totalTax =		RequestCheckVar(Request("totalTax"),10)
	repName =		RequestCheckVar(html2db(Request("repName")),32)
	repEmail =		RequestCheckVar(html2db(Request("repEmail")),200)
    repTel =		RequestCheckVar(Trim(html2db(Request("repTel1"))) + "-" + Trim(html2db(Request("repTel2"))) + "-" + Trim(html2db(Request("repTel3"))),16)

    isueDate =		RequestCheckVar(Request("isueDate"),10)

	userid = GetLoginUserID()

	If mode = "select" Then

		'@@ 사업자등록 확인 페이지로 이동
		retURL = "pop_taxRequest.asp?orderserial=" & orderserial & "&busiIdx=" & busiIdx
		response.write	"<script language='javascript'>" &_
						"	location='" & retURL & "';" &_
						"</script>"
		response.End

	End If


	'트랜젝션 시작
	dbget.beginTrans


	'// 모드별 처리 분기
	Select Case mode
		Case "add"
			'@@ 신규 등록
			if (userid<>"") then
    			SQL =	"Insert into db_order.[dbo].tbl_busiInfo " & VbCRLF
    			SQL = SQL & "	(userid, busiNo, busiName, busiCEOName, busiAddr, busiType, busiItem, confirmYn) " & VbCRLF
    			SQL = SQL & " values " & VbCRLF
    			SQL = SQL & "	('" & userid & "'" & VbCRLF
    			SQL = SQL & "	,'" & busiNo & "'" & VbCRLF
    			SQL = SQL & "	,'" & busiName & "'" & VbCRLF
    			SQL = SQL & "	,'" & busiCEOName & "'" & VbCRLF
    			SQL = SQL & "	,'" & busiAddr & "'" & VbCRLF
    			SQL = SQL & "	,'" & busiType & "'" & VbCRLF
    			SQL = SQL & "	,'" & busiItem & "','Y')"
    		    dbget.Execute(SQL)
			else

    			SQL =	"Insert into db_order.[dbo].tbl_busiInfo " & VbCRLF
    			SQL = SQL & "	(userid, busiNo, busiName, busiCEOName, busiAddr, busiType, busiItem, confirmYn,guestOrderSerial) " & VbCRLF
    			SQL = SQL & " values " & VbCRLF
    			SQL = SQL & "	('" & userid & "'" & VbCRLF
    			SQL = SQL & "	,'" & busiNo & "'" & VbCRLF
    			SQL = SQL & "	,'" & busiName & "'" & VbCRLF
    			SQL = SQL & "	,'" & busiCEOName & "'" & VbCRLF
    			SQL = SQL & "	,'" & busiAddr & "'" & VbCRLF
    			SQL = SQL & "	,'" & busiType & "'" & VbCRLF
    			SQL = SQL & "	,'" & busiItem & "','Y'" & VbCRLF
    			SQL = SQL & "	,'" & orderserial & "')"
    			dbget.Execute(SQL)
            end if

			'msg = "사업자등록증 정보를 저장하였습니다.\n팩스(02-763-4077)로 사업자등록증을\n반드시 보내주십시오."
			msg = "사업자등록증 정보를 저장하였습니다."

			'돌아갈 페이지
			retURL = "location='pop_taxList.asp?orderserial=" & orderserial & "'"




		Case "request"
			'@@ 요청서 등록 처리
			SQL =	"Insert into db_order.[dbo].tbl_taxSheet " & VbCRLF
			SQL = SQL & "	(orderIdx, userid, repName, repEmail, repTel, busiIdx, orderserial, itemname, totalPrice, totalTax, isueDate, taxIssueType, sellBizCd, selltype) " & VbCRLF
			SQL = SQL & " values " & VbCRLF
			SQL = SQL & "	(" & orderIdx & VbCRLF
			SQL = SQL & "	,'" & userid & "'" & VbCRLF
			SQL = SQL & "	,'" & repName & "'" & VbCRLF
			SQL = SQL & "	,'" & repEmail & "'" & VbCRLF
			SQL = SQL & "	,'" & repTel & "'" & VbCRLF
			SQL = SQL & "	, " & busiIdx & VbCRLF
			SQL = SQL & "	,'" & orderserial & "'" & VbCRLF
			SQL = SQL & "	,'" & itemname & "'" & VbCRLF
			SQL = SQL & "	, " & totalPrice & VbCRLF
			SQL = SQL & "	, " & totalTax & VbCRLF
			SQL = SQL & "	, '" & isueDate & "', 'C', '0000000101', 20166)"			'// 0000000101 : 온라인(공통), 매출계정 : 20166
			dbget.Execute(SQL)

            SQL =	"update db_order.dbo.tbl_order_master set cashreceiptreq='T' where orderserial='"&orderserial&"'"
            dbget.Execute(SQL)

			msg = "세금계산서 발급 요청하였습니다.\n내용 확인 후 2~3일 후 세금계산서를 보내드리겠습니다."

			'돌아갈 페이지
			retURL = "opener.location.reload();" &_
			         "window.close();"

	End Select


	'오류검사 및 반영
	If Err.Number = 0 Then
		dbget.CommitTrans				'커밋(정상)

		response.write	"<script language='javascript'>" &_
						"	alert('" & msg & "');" & retURL &_
						"</script>"
	Else
	    dbget.RollBackTrans				'롤백(에러발생시)

		response.write	"<script language='javascript'>" &_
						"	alert('처리중 에러가 발생했습니다.');" &_
						"</script>"

	End If
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
