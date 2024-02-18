<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'==========================================================================
'	Description: 기프트카드 MMS발송
'	History: 2012.01.02 허진원 - 생성
'	http://www.10x10.co.kr/inipay/giftcard/send_GiftCard_Order_System.asp?ordsn=G1000001,G1000002
'	------------------
'	update db_order.dbo.tbl_giftcard_order
'	set sendhp='1644-6030'
'		,reqhp='받는분휴대폰번호'
'		,MMSTitle='메지시 제목'
'		,MMSContent='메지시 내용'
'	where giftOrderSerial='G2020200508'
'==========================================================================

    Response.AddHeader "Cache-Control","no-cache"
    Response.AddHeader "Expires","0"
    Response.AddHeader "Pragma","no-cache"
%>
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/classes/ordercls/smscls.asp" -->
<%
	dim strRst, strSql, lp, OrdSn, arrOrdSn
	OrdSn = Request("ordsn")

	'// 특정사용자만 실행가능
	if Not(GetLoginUserID="kobula" or GetLoginUserID="eastone") then
		Call Alert_Close("잘못된 접속입니다.")
		dbget.Close(): response.End
	end if

	if OrdSn="" then
		Call Alert_Close("기프트카드 주문번호를 입력해주세요.")
		dbget.Close(): response.End
	end if

	arrOrdSn = split(OrdSn,",")

	'// MMS발송 도돌이
	For lp=0 to ubound(arrOrdSn)
		strRst = strRst & "- " & arrOrdSn(lp) & " : " & sendGiftCardLMSMsg(arrOrdSn(lp)) & "<br>"
	Next

	'#### 결과 출력
	response.Write strRst
%>