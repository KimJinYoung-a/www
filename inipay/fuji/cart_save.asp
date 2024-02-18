<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<% Response.Addheader "P3P","policyref=""/w3c/p3p.xml"", CP=""CONi NOI DSP LAW NID PHY ONL OUR IND COM"""%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbHelper.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/classes/ordercls/shoppingbagDBcls.asp" -->


<%
'' Fuji PhotoBook 관련 장바구니 : photobook ActiveX에서 장바구니로 담을경우.
'' 사이트 구분
Const sitename = "10x10"

dim i
dim userid, guestSessionID
userid = GetLoginUserID
guestSessionID = GetGuestSessionKey()

dim itemid      : itemid = RequestCheckvar(request.Form("itemid"),10)
dim itemoption  : itemoption = RequestCheckvar(request.Form("itemoption"),4)

dim pcode   : pcode   = RequestCheckvar(request.Form("pcode"),16)       'Fuji 제품코드
dim tplcode : tplcode = RequestCheckvar(request.Form("tplcode"),16)     'Fuji 템플릿코드
dim ordfile : ordfile = RequestCheckvar(request.Form("ordfile"),100)    '저장된 파일
dim itemea  : itemea  = RequestCheckvar(request.Form("itemea"),10)

'response.write "pcode="&pcode&"<br>"
'response.write "tplcode="&tplcode&"<br>"
'response.write "ordfile="&ordfile&"<br>"
'response.write "itemea="&itemea&"<br>"
'response.write "itemid="&itemid&"<br>"
'response.write "itemoption="&itemoption&"<br>"

dim requiredetail   : requiredetail = ordfile

if (itemea="") then itemea=1


dim oShoppingBag
set oShoppingBag = new CShoppingBag
oShoppingBag.FRectUserID    = userid
oshoppingbag.FRectSessionID = guestSessionID
oShoppingBag.FRectSiteName  = sitename

oShoppingBag.GetShoppingBagDataDB

dim NotValidItemExists, ValidRet
dim Pitemea

ValidRet = oshoppingbag.checkValidItem(itemid,itemoption)
if (ValidRet=0) then
    response.write "<script>alert('죄송합니다. 유효하지 않은 상품이거나 품절된 상품입니다.');</script>"
    response.write "<script>window.close();</script>"

    dbget.close() : response.end
else
    ''다시 저장하는경우는 갯수를 1개로.
    Pitemea      = oShoppingBag.getItemNoByItemID(itemid,itemoption)
'    rw "itemid="&itemid
'    rw "itemoption="&itemoption
'    rw "Pitemea="&Pitemea
    if (Pitemea<1) then
        oshoppingbag.AddshoppingBagDB itemid,itemoption,itemea,""
    else
        oshoppingbag.EditshoppingBagDB itemid,itemoption,Pitemea
    end if

    oShoppingBag.EditShoppingRequireDetail itemid, itemoption, "[[포토룩스]:"&(requiredetail)&"]"
end if

set oShoppingBag = Nothing


%>
<script language='javascript'>
opener.location.href="/inipay/shoppingbag.asp"
opener.focus();
window.close();
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->