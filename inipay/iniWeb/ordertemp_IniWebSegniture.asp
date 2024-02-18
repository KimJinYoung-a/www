<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
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
<!-- #include virtual="/inipay/iniWeb/INIWeb_Util.asp" -->
<%
Dim vIDx, iErrMsg, ipgGubun
Dim irefPgParam   '' 결제 예약시 필요한 값들.
Dim Tn_paymethod : Tn_paymethod = request("Tn_paymethod")

ipgGubun = chkIIF(Tn_paymethod="130","SP","")

vIDx = fnSaveOrderTemp(request("mid"), iErrMsg, ipgGubun, irefPgParam)  '' order_temp 임시저장

if (vIDx<1) then
    response.write "ERR2:처리중 오류가 발생하였습니다.- "&iErrMsg&""  ''ERR2로 하면 장바구니로 돌아감.
    dbget.close()
    response.end
end if

if (irefPgParam is Nothing) then
    response.write "ERR2:처리중 오류가 발생하였습니다"
    dbget.close()
    response.end
end if

INIWEB_oid = vIDx

dim imkey  : imkey = INIWEB_mKey
Select Case Tn_paymethod
    Case "110"  '신용카드 + OK캐시백
        imkey = INIWEB_mKey6
    Case "190"  '텐바이텐 하나체크카드
        imkey = INIWEB_mKeyH
    Case "400"  '모바일 소액결제
        imkey = INIWEB_mKey10
    Case "130"  '삼성페이
        imkey = INIWEB_mKeySP
    Case "150"  '이니렌탈
        imkey = INIWEB_mKeyR
End Select
%>
<input type=hidden name=oid value="<%=INIWEB_oid%>">
<input type=hidden name=timestamp value="<%=INIWEB_timestamp%>">
<input type=hidden name=signature value="<%=getIniWebSignature(INIWEB_oid,irefPgParam.FPrice,INIWEB_timestamp)%>">
<input type=hidden name=merchantData value="vidx=<%=INIWEB_oid%>">
<input type=hidden name=mKey value="<%=imkey%>">
<input type=hidden name=hnprice value="<%=irefPgParam.FPrice%>">
<!-- #include virtual="/lib/db/dbclose.asp" -->