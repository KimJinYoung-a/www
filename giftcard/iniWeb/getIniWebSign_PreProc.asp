<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/MD5.asp" -->
<!-- #include virtual="/lib/classes/giftcard/GiftCardinfoCls.asp" -->
<!-- #include virtual="/lib/classes/giftcard/GiftCardOptionCls.asp" -->
<!-- #include virtual="/lib/classes/giftcard/giftcard_orderCls2016.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_userinfocls.asp" -->
<!-- #include virtual="/inipay/iniWeb/INIWeb_Util.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<%
if GetLoginUserID="" then
	Response.Write "ERR.로그인이 필요합니다. 페이지를 새로고침 후 로그인해주세요."
	dbget.close: Response.End
end if

'// 임시 주문정보 저장 //
dim temp_idx,cardItemid,cardOption,userid,buyname,buyemail,buyhp,buyPhone,sendHP,sendemail,reqhp,accountdiv,accountname,accountno
dim price,referip,userlevel,designId,MMSTitle,MMSContent,userImage,rdsite,vMid,userDevice
dim i


cardItemid		= requestCheckVar(request.Form("cardid"),3)
cardOption		= requestCheckVar(request.Form("cardopt"),4)
userid			= GetLoginUserID
buyname			= requestCheckVar(request.Form("buyname"),16)
buyemail		= requestCheckVar(request.Form("buyemail"),120)
buyhp			= requestCheckVar(request.Form("buyhp"),16)
buyPhone		= requestCheckVar(request.Form("buyphone"),16)
sendHP			= requestCheckVar(request.Form("sendhp"),16)
sendemail		= requestCheckVar(request.Form("sendemail"),120)
reqhp			= requestCheckVar(request.Form("reqhp"),16)
accountdiv		= requestCheckVar(request.Form("Tn_paymethod"),3)
accountname		= requestCheckVar(request.Form("acctname"),16)
accountno		= requestCheckVar(request.Form("acctno"),32)
price			= getNumeric(requestCheckVar(request.Form("cardPrice"),18))
referip			= Left(request.ServerVariables("REMOTE_ADDR"),32)
userlevel		= GetLoginUserLevel
designId		= requestCheckVar(request.Form("designid"),3)
MMSTitle		= requestCheckVar(request.Form("MMSTitle"),64)
MMSContent		= html2db(request.Form("MMSContent"))
userImage		= requestCheckVar(request.Form("userImg"),128)
rdsite			= requestCheckVar(request.Form("rdsite"),32)
vMid			= chkIIF(application("Svr_Info")="Dev","INIpayTest","teenxteen8")
userDevice		= Replace(chrbyte(Request.ServerVariables("HTTP_USER_AGENT"),300,"Y"),"'","")

if designId="900" then
	if userImage<>"" then
		userImage = "/giftcard/temp/" & userImage
	else
		designId = "605"		'기본 디자인
	end if
elseif designId="" then
	designId = "605"
end if


'// 카드-옵션 정보 접수
dim oCardItem
Set oCardItem = new CItemOption
oCardItem.FRectItemID = cardItemid
oCardItem.FRectItemOption = cardOption
oCardItem.GetItemOneOptionInfo

if oCardItem.FResultCount<=0 then
    response.write "ERR.판매중인 Gift카드가 아니거나 없는 Gift카드번호 입니다."
	dbget.close: response.End
elseif oCardItem.FOneItem.FoptSellYn="N" then
    response.write "ERR.판매중인 Gift카드가 아니거나 품절된 Gift카드 옵션입니다."
	dbget.close: response.End
end if

if CLNG(oCardItem.FOneItem.FcardSellCash)<>CLNG(price) then
    response.write "ERR.금액이 잘못되었습니다."

    ''관리자 오류 통보
	'sqlStr = " exec [db_sms].[dbo].[usp_SendSMS] '010-6324-9110','1644-6030','gift카드 금액오류-"&referip&":" & oCardItem.FOneItem.FcardSellCash &":"&price&"'"
	'dbget.Execute sqlStr
	response.end
end if

set oCardItem=Nothing



''##############################################################################
''디비작업
''##############################################################################
Dim strSql
strSql = "INSERT INTO [db_order].[dbo].[tbl_giftcard_order_temp] (" &_
	"cardItemid,cardOption,userid,buyname,buyemail,buyhp,buyPhone,sendHP,sendemail,reqhp,accountdiv,accountname,accountno" &_
	",price,referip,userlevel,designId,MMSTitle,MMSContent,userImage,rdsite,mid,userDevice" &_
	",P_STATUS,P_TID,P_AUTH_NO,P_RMESG1,P_RMESG2,P_FN_CD1,P_CARD_ISSUER_CODE,P_CARD_PRTC_CODE,PayResultCode,IsSuccess,no_OID" &_
	") VALUES (" &_
	"'" & cardItemid & "','" & cardOption & "','" & userid & "','" & buyname & "','" & buyemail & "','" & buyhp & "','" & buyPhone & "','" & sendHP & "'" &_
	",'" & sendemail & "','" & reqhp & "','" & accountdiv & "','" & accountname & "','" & accountno & "','" & price & "','" & referip & "','" & userlevel &"'" &_
	",'" & designId & "',N'" & MMSTitle & "',N'" & MMSContent & "','" & userImage & "','" & rdsite & "','" & vMid & "','" & userDevice & "'" &_
	",'','','','','','','','','','','" & INIWEB_oid & "')"
	''Response.WRite "ERR." &strSql: dbget.close: Response.End
dbget.execute strSql

strSql = " SELECT SCOPE_IDENTITY() "
rsget.Open strSql,dbget
IF Not rsget.EOF THEN
	temp_idx = rsget(0)
END IF
rsget.close

IF temp_idx = "" Then
	Response.Write "ERR.처리 중 오류가 발생하였습니다. 잠시후 다시 해주세요."
	dbget.close: Response.End
End IF

'// 표준웹결제 정보 및 임시주문번호 출력 ↓
Response.Write "OK."
%>
<input type="hidden" name="oid" value="<%=INIWEB_oid%>">
<input type="hidden" name="timestamp" value="<%=INIWEB_timestamp%>">
<input type="hidden" name="signature" value="<%=getIniWebSignature(INIWEB_oid,request.form("cardPrice"),INIWEB_timestamp)%>">
<input type="hidden" name="merchantData" value="<%=temp_idx%>">
<!-- #include virtual="/lib/db/dbclose.asp" -->