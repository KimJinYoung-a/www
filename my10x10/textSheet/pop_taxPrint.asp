<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/login/checkUserGuestlogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbHelper.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/classes/cscenter/taxsheet_cls.asp"-->
<%

'// 쓰이는 페이지인가 ㅡㅡ?

	Dim orderserial, userid
	Dim oBusi

	orderserial = Request("orderserial")
	userid = getLoginUserID

	'// 내용 접수
	set oBusi = new CBusi
	oBusi.FRectorderserial = orderserial

	oBusi.GetBusiPrint

	'내용 확인
	if oBusi.FTotalCount=0 then
		Response.Write "<script language='javascript'>" &_
						"	alert('아직 발급승인이 안되었거나 요청한 정보가 없습니다.');" &_
						"	window.close();" &_
						"</script>"
	Else
		Dim retUrl
		retUrl = "http://web1.neoport.net/jsp/dti/tx/dti_get_pin.jsp" &_
				"?tax_no=" & oBusi.FBusiList(0).FneoTaxNo &_
				"&b_biz_no=" & Replace(oBusi.FBusiList(0).FbusiNo,"-","") &_
				"&s_biz_no=2118700620"

        if LEft(oBusi.FBusiList(0).FneoTaxNo,2)="TX" then
            retUrl = "http://www.bill36524.com/popupBillTax.jsp?NO_TAX=" & oBusi.FBusiList(0).FneoTaxNo & "&NO_BIZ_NO=" & Replace(oBusi.FBusiList(0).FbusiNo,"-","")
        end if
		dbget.close()
'		response.redirect retUrl

'		Response.Write "<script language='javascript'>" & vbCrLf &_
'						"window.location.href='http://web1.neoport.net/jsp/dti/tx/dti_get_pin.jsp" &_
'						"?tax_no=" & oBusi.FBusiList(0).FneoTaxNo &_
'						"&b_biz_no=" & Replace(oBusi.FBusiList(0).FbusiNo,"-","") &_
'						"&s_biz_no=2118700620';" & vbCrLf &_
'						"</script>"
		response.write "<script>" & vbCrLf
		response.write "window.resizeTo(800,700);" & vbCrLf
		response.write "location.href = '" & retUrl & "';" & vbCrLf
		response.write "</script>" & vbCrLf

		response.End
	end if

	Set oBusi=Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
