<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>

<%Response.Addheader "P3P","policyref='/w3c/p3p.xml', CP='NOI DSP LAW NID PSA ADM OUR IND NAV COM'"%>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbhelper.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/classes/ordercls/shoppingbagDBcls.asp" -->
<!-- #include virtual="/lib/email/maillib.asp" -->
<!-- #INCLUDE Virtual="/lib/email/maillib2.asp" -->
<!-- #include virtual="/lib/classes/ordercls/smscls.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_pointcls.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_tenCashCls.asp" -->
<!-- #include virtual="/lib/classes/ordercls/sp_myordercls.asp" -->
<%
	'// 특정사용자만 실행가능
	if Not(GetLoginUserID="kobula" or GetLoginUserID="eastone") then
		Call Alert_Close("잘못된 접속입니다.")
		dbget.Close(): response.End
	end if

	Dim OrdSn
	OrdSn = Request("ordsn")

	if OrdSn="" then
		Call Alert_Close("주문서를 발송할 주문번호를 입력해주세요.")
		dbget.Close(): response.End
	end if

	'주문서 발송
	call sendmailorder(OrdSn,"텐바이텐<customer@10x10.co.kr>")

	Call Alert_Close("주문서 재발송 완료!")
%>

<!-- #include virtual="/lib/db/dbclose.asp" -->