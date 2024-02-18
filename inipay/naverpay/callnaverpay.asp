<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%Response.Addheader "P3P","policyref='/w3c/p3p.xml', CP='NOI DSP LAW NID PSA ADM OUR IND NAV COM'"%>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
Response.CharSet="UTF-8"
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/inipay/naverpay/incNaverpayCommon.asp"-->
<!-- #include virtual="/lib/util/rndSerial.asp" -->
<%
dim vIdx, vQuery
dim NPay_ReserveId
vIdx = Request("ordsn")
vIdx = rdmSerialDec(vIdx)

if vIdx="" or Not(isNumeric(vIdx)) then
	Response.write "<script type='text/javascript'>alert('오류가 발생했습니다.\n- 파라메터 없음');opener.location.replace('"&SSLUrl&"/inipay/UserInfo.asp');self.close();</script>"
	dbget.close(): Response.End
end if

'// 네이버페이 결제예약번호 접수
vQuery = "SELECT TOP 1 P_RMESG2 FROM [db_order].[dbo].[tbl_order_temp] WHERE temp_idx = '" & vIdx & "' and IsPay='N' and P_STATUS=''"
rsget.Open vQuery,dbget,1
IF Not rsget.EOF THEN
	NPay_ReserveId 		= rsget("P_RMESG2")
END IF
rsget.close

if NPay_ReserveId="0" or NPay_ReserveId="" or isNull(NPay_ReserveId) then
	Response.write "<script type='text/javascript'>alert('오류가 발생했습니다.\n- 없거나 잘못된 주문');opener.location.replace('"&SSLUrl&"/inipay/UserInfo.asp');self.close();</script>"
	dbget.close(): Response.End
end if

Response.Redirect NPay_SvcPC_URL & "/payments/" & NPay_ReserveId
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->