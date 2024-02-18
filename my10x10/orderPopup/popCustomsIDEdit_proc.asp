<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
'// 개인통관 고유부호 수정
%>
<!-- #include virtual="/login/checkUserGuestlogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/tenEncUtil.asp" -->
<!-- #include virtual="/lib/util/base64.asp" -->
<!-- #include virtual="/cscenter/lib/csAsfunction.asp" -->
<%
	Dim customNumber, sqlStr , orderserial, contents_jupsu, contents_finish, finishuser, iAsID, divcd, reguserid, title, gubun01, gubun02, CNEXT
	customNumber 	= requestCheckVar(request("customNumber"),13)
	orderserial		= requestCheckVar(request("orderserial"),13)

	CNEXT = " => "

	If customNumber = "" Or orderserial = "" Then
		dbget.close()
		Response.Write "<script language='javascript'>alert('잘못된 접근입니다.');window.close();</script>"
		Response.End
	End If
	
	''CS 처리 내역 입력.========================================================================
	reguserid   = getloginuserid
    divcd       = "A900"
    title       = "해외직구 정보 수정"
    gubun01     = "C004"
    gubun02     = "CD99"

    contents_jupsu  = ""
    contents_finish = ""
    finishuser      = "system"

	sqlStr = " select top 1 IsNULL(customnumber,'') as customnumber"
	sqlStr = sqlStr + " from db_order.dbo.tbl_order_custom_number"
	sqlStr = sqlStr + " where orderserial='" + CStr(orderserial) + "' " + VbCrlf
	rsget.Open sqlStr,dbget,1
	if Not rsget.Eof then
		contents_jupsu = contents_jupsu & "변경전 내역" & VbCrlf
		if (rsget("customnumber")<>customnumber) then
			contents_jupsu = contents_jupsu & "개인통관 고유부호: " & rsget("customnumber") & CNEXT & customnumber & VbCrlf
		end if
	end if
	rsget.Close

    contents_finish = contents_jupsu

	iAsID = RegCSMaster(divcd , orderserial, reguserid, title, contents_jupsu, gubun01, gubun02)
    Call FinishCSMaster(iAsid, finishuser, html2db(contents_finish))

    sqlStr = "update [db_cs].[dbo].tbl_new_as_list"
    sqlStr = sqlStr & " set opentitle='"&html2db(contents_finish)&"'"
    sqlStr = sqlStr & " where id=" + CStr(iAsid)
    dbget.Execute sqlStr


	'// 개인통관 고유부호 수정
	sqlStr = "exec db_order.[dbo].[usp_Ten_ShoppingBag_UnipassNum_EDIT] '"&orderserial&"','"&customNumber&"','"&reguserid&"'"
	dbget.Execute sqlStr
%>

<script style="text/javascript">
	opener.document.location.reload();
	window.close();
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->