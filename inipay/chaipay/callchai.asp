<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%Response.Addheader "P3P","policyref='/w3c/p3p.xml', CP='NOI DSP LAW NID PSA ADM OUR IND NAV COM'"%>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
Response.CharSet="UTF-8"
%>
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/inipay/chaipay/incchaipayCommon.asp"-->
<%'결제 페이지 호출용 차이 스크립트%>
<script type="text/javascript" src="https://chai.finance/js/v1/payment.min.js"></script>
<%
dim rdparam, tmpparam, return_paymentId, return_idempotencyKey
rdparam = Request("rdparam")

if rdparam="" then
	Response.write "<script type='text/javascript'>alert('오류가 발생했습니다.\n- 파라메터 없음');opener.location.replace('"&SSLUrl&"/inipay/UserInfo.asp');self.close();</script>"
	dbget.close(): Response.End
end if
'Response.Redirect redirectUrl

if instr(lcase(rdparam),"||") < 0 Then
	Response.write "<script type='text/javascript'>alert('오류가 발생했습니다.\n- 파라메터 없음');opener.location.replace('"&SSLUrl&"/inipay/UserInfo.asp');self.close();</script>"
	dbget.close(): Response.End
End If

tmpparam = split(rdparam,"||")
return_paymentId = tmpparam(0)
return_idempotencyKey = tmpparam(1)
%>
<script type="text/javascript">
  ChaiPayment.checkout({
    <%'// mode: 'production' // default: staging%>
    publicAPIKey: '<%=ChaiPay_Public_Api_Key%>',
    paymentId: '<%=return_paymentId%>',
    returnUrl: '<%=ChaiPay_OrderSuccess_Url%>',
    idempotencyKey: '<%=return_idempotencyKey%>',
    mode: '<%=ChaiPay_ModeType%>',    
  });
</script>