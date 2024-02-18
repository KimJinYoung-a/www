<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<!-- #include virtual="/login/checkPopUserGuestLogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbHelper.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/classes/cscenter/taxsheet_cls.asp"-->
<!-- #include virtual="/lib/classes/ordercls/cashreceiptcls.asp" -->

<%
'' 비회원도 발급 가능하게 수정 200905
'' 1. 현금영수증 발행 요청 했는지 체크 -> out
'' 2. 세금계산서 발행 되었는지 체크 -> print로 Redirect

	Dim orderserial, userid, chkConfirm
    Dim chkReg
    Dim chkReq_receipt

    orderserial = Request("orderserial")
	userid = getLoginUserID

    chkReq_receipt = chkReqReceipt(orderserial)  ''00 : 발행 성공, R : 발행요청,

    if (chkReq_receipt<>"none") then
        response.write "<script language='javascript'>alert('현금영수증 발행 요청건이 있습니다. \n\n세금계산서와 현금영수증은 동시에 발행하실 수 없습니다.');</script>"
        response.write "<script language='javascript'>window.close();</script>"
	    dbget.close()	:	response.End
    end if

	'중복 신청 여부 확인
	chkReg = chkRegTax(orderserial)  ''Y : 발행, N : 발행전, none : 신청전
	if chkReg="Y" then
'	    response.redirect "/my10x10/taxSheet/pop_taxPrint.asp?orderserial=" + orderserial
		response.write "<script>" & vbCrLf
		response.write "location.href = '/my10x10/taxSheet/pop_taxPrint.asp?orderserial=" & orderserial & "';" & vbCrLf
		response.write "</script>" & vbCrLf
		dbget.close()	:	response.End
	end if

	if chkReg="N" then
		Response.Write "<script language=javascript>" &_
						"	alert('이미 세금계산서 발급 요청을 하셨습니다. \n발행시까지 기다려 주시기바랍니다.');" &_
						"	self.close();" &_
						"</script>"
		dbget.close()	:	response.End
	end if

	'사업자등록증 등록 여부 확인
	if (userid<>"") then
	    chkConfirm = chkRegBusi(userid)
	else
	    chkConfirm = chkRegBusiByOrderserial(orderserial)
	end if
	'// 사업자등록증 등록 여부에 따른 페이지 분기
	if chkConfirm="0" then

		'# 등록되어있지 않음 → 사업자 정보 입력 화면
		Server.Execute("pop_taxWrite.asp")

	else

		'# 등록되어있는 사업자등록증이 존재 → 사업자 정보 선택 화면
		Server.Execute("pop_taxList.asp")

	end if
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
