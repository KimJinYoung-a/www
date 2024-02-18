<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
Response.CharSet="UTF-8"
%>
<% Response.Addheader "P3P","policyref='/w3c/p3p.xml', CP='NOI DSP LAW NID PSA ADM OUR IND NAV COM'"%>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/login/checkBaguniLogin.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbhelper.asp" -->
<!-- #include virtual="/lib/classes/ordercls/shoppingbagDBcls.asp" -->
<!-- #include virtual="/lib/email/maillib.asp" -->
<!-- #INCLUDE Virtual="/lib/email/maillib2.asp" -->
<!-- #include virtual="/lib/classes/ordercls/smscls.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_pointcls.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_tenCashCls.asp" -->
<!-- #include virtual="/lib/classes/ordercls/sp_myordercls.asp" -->
<!-- #include virtual="/lib/classes/giftcard/giftcard_MyCardInfoCls.asp" -->
<!-- #include virtual="/inipay/naverpay/incNaverpayCommon.asp"-->
<!-- #include virtual="/lib/classes/ordercls/pack_cls.asp" -->
<!-- #include virtual="/lib/util/rndSerial.asp" -->
<!-- #include virtual="/inipay/common/orderTempFunction.asp" -->
<%

Dim vIDx, iErrMsg, ipgGubun
Dim irefPgParam   '' 결제 예약시 필요한 값들.

ipgGubun = "NP"

vIDx = fnSaveOrderTemp("NP_" & NPay_PartnerID, iErrMsg, ipgGubun, irefPgParam)  '' order_temp 임시저장

if (vIDx<1) then
    ''response.write "<script>alert('처리중 오류가 발생하였습니다.\r\n- "&replace(iErrMsg,"'","")&"');</script>window.close();"
    response.write "ERR2:처리중 오류가 발생하였습니다.- "&iErrMsg&""  ''ERR2로 하면 장바구니로 돌아감.
    dbget.close()
    response.end
end if

if (irefPgParam is Nothing) then
    response.write "ERR2:처리중 오류가 발생하였습니다"
    dbget.close()
    response.end
end if

''======================================================================================================================
Dim iNPay_ReserveId
Dim sqlStr
    ''### 1. 네이버페이 결제예약 (임시주문번호, 상품명, 상품수, 결제금액, 과세금액, 배송비, 주문자) '' 이함수안에 결제결과URL이 들어 있음.
    ''/inipay/naverpay|incNaverpayCommon.asp
    iNPay_ReserveId = fnCallNaverPayReserve(vIdx,irefPgParam.Fgoodname,irefPgParam.Fgoodcnt,irefPgParam.FPrice,irefPgParam.FPrice,irefPgParam.FDlvPrice,irefPgParam.FBuyname)
    
    '예약 번호 저장
    sqlStr = "UPDATE [db_order].[dbo].[tbl_order_temp] "
    sqlStr = sqlStr & " SET P_RMESG2 = '" & iNPay_ReserveId & "'" & VbCRLF
    sqlStr = sqlStr & " WHERE temp_idx = '" & vIdx & "'"
    dbget.execute sqlStr

    SET irefPgParam = Nothing
    
if left(iNPay_ReserveId,4)="ERR:" then
	response.write "ERR1:처리중 오류가 발생했습니다.\n(" & right(iNPay_ReserveId,len(iNPay_ReserveId)-4) & ")"
	dbget.Close() : response.end
end if


''### 2. 결제값 반환
Response.Write "OK:" & rdmSerialEnc(vIdx)
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->