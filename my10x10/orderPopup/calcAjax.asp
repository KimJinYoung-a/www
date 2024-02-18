<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
Response.ContentType = "application/json"
%>
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/login/checkPopUserGuestLogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbHelper.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/tenEncUtil.asp" -->
<!-- #include virtual="/lib/util/base64.asp" -->
<!-- #include virtual="/lib/classes/ordercls/sp_myordercls.asp" -->
<!-- #include virtual="/lib/classes/shopping/sp_couponcls.asp" -->
<!-- #include virtual="/lib/classes/cscenter/cs_aslistcls.asp" -->
<!-- #include virtual="/cscenter/lib/csAsfunction.asp"-->
<!-- #include virtual="/lib/classes/ordercls/pack_cls.asp" -->
<!-- #include virtual="/lib/util/JSON_2.0.4.asp" -->
<%

dim mode
dim orderserial, userid, IsBiSearch
dim checkidx, regitemno, checkidxArr, regitemnoArr

dim disableidxarr, cancelPrdPrc, cancelDlvPrc, addDlvPrc, totCancelPrc

mode        	= requestCheckvar(request.Form("mode"), 32)
checkidxArr		= request.Form("checkidx")
regitemnoArr	= request.Form("regitemno")

userid          = getEncLoginUserID()
orderserial     = requestCheckvar(request.form("orderserial"), 32)

''mode = "recalcPrice"
''orderserial = "18041989498"
''checkidxArr = "43051446,43051449"
''regitemnoArr = "0,1"


if ((userid="") and session("userorderserial")<>"") then
	IsBiSearch = true
	orderserial = session("userorderserial")
elseif ((userid="") and session("userorderserial")="") then
	response.write "unauthrized access[0]"
    dbget.close()	:	response.End
end if


if orderserial="" then
	Call Alert_Close("선택된 주문번호가 없습니다.")
	dbget.close()	:	response.End
end if


'==============================================================================
dim myorder
set myorder = new CMyOrder
if IsUserLoginOK() then
    '// myorder.FRectUserID = GetLoginUserID()
    myorder.FRectUserID = getEncLoginUserID()
    myorder.FRectOrderserial = orderserial
    myorder.GetOneOrder

elseif IsGuestLoginOK() then
    orderserial = GetGuestLoginOrderserial()
    myorder.FRectOrderserial = orderserial
    myorder.GetOneOrder

end if

if orderserial="" then
	Call Alert_Close("선택된 주문번호가 없습니다.")
	dbget.close()	:	response.End
end if


dim myorderdetail
set myorderdetail = new CMyOrder
myorderdetail.FRectOrderserial = orderserial

if myorder.FResultCount>0 then
	myorderdetail.FRectUserID = userid
    myorderdetail.GetOrderDetail
end if

if (myorder.FResultCount<1) or (myorderdetail.FResultCount<1) Then
    dbget.close()	:	response.End
end if

dim oupchebeasongpay
set oupchebeasongpay = new CMyOrder

dim i, j, k
dim BeforeBrandConfirmOnly : BeforeBrandConfirmOnly = False
dim requireupche, requiremakerid
dim sqlStr
dim result
Dim objObject
dim totItemReducedPrice, totBeasongReducedPrice
dim totItemPay, totDeliveryPay, cancelItemPay, freeDeliveryItemCnt, defaultfreebeasonglimit, defaultdeliverpay

select case mode
	case "recalcPrice":
		Set objObject = jsObject()
		Set objObject("disableidxarr") = jsArray()

		if (Trim(checkidxArr) = "") then
			totItemPay = 0
			totDeliveryPay = 0
			cancelPrdPrc = 0
			cancelDlvPrc = 0
			addDlvPrc = 0
			totCancelPrc = 0

			objObject("resultCode") = "OK"
		else
			if Not IsNumberOnly(checkidxArr) or Not IsNumberOnly(regitemnoArr) then
				'// 해킹대비
				dbget.close()	:	response.End
			end if

			'// 접수는 텐바이텐배송 상품 또는 업체별로만 선택가능
			'// 두개 업체가 선택된 경우 에러
			result = CheckPartialCancelValid(orderserial, checkidxArr)

			totItemPay = 0
			totDeliveryPay = 0
			cancelPrdPrc = 0
			cancelDlvPrc = 0
			addDlvPrc = 0
			totCancelPrc = 0

			if Left(result, 4) = "ERR[" then
				'// 에러
				objObject("resultCode") = "ERR"
			else
				objObject("resultCode") = "OK"

				if result = "" then
					requireupche = "N"
					requiremakerid = ""
				else
					requireupche = "Y"
					requiremakerid = result
				end if

				result = GetPartialCancelDisableArr(orderserial, requiremakerid)

				if (result <> "") then
					result = Split(result, ",")
					for i = 0 to UBound(result)
						objObject("disableidxarr")(null) = result(i)
					next
				end if

				'// 취소수량 임시디비 저장
				Call InsertUpdateCancelItemNo(checkidxArr, regitemnoArr)

				Call GetDataForPartialCancel(orderserial, checkidxArr, requiremakerid, totItemPay, totDeliveryPay, cancelPrdPrc, freeDeliveryItemCnt, defaultfreebeasonglimit, defaultdeliverpay)

				'// 추가배송비 발생조건
				'// 1. 전체선택 : X
				'// 2. 이미 배송비가 있는 경우 X
				'// 3. 업체무료배송상품 텐배무료배송상품 또는 착불 상품이 있는지
				'// 4. 선택안된상품이 30000만원 미만인 경우

				if (totItemPay = cancelPrdPrc) then
					cancelDlvPrc = totDeliveryPay
				elseif totDeliveryPay = 0 and freeDeliveryItemCnt = 0 and (totItemPay - cancelPrdPrc) < defaultfreebeasonglimit then
					addDlvPrc = defaultdeliverpay
				end if

				totCancelPrc = cancelPrdPrc + cancelDlvPrc - addDlvPrc

				if (totCancelPrc < 0) then
					totCancelPrc = 0
				end if
			end if
		end if

		objObject("totItemPay") = totItemPay
		objObject("totDeliveryPay") = totDeliveryPay
		objObject("cancelPrdPrc") = cancelPrdPrc
		objObject("cancelDlvPrc") = cancelDlvPrc
		objObject("addDlvPrc") = addDlvPrc
		objObject("totCancelPrc") = totCancelPrc

		objObject.flush
	case else:
		response.write "unauthrized access[1]"
		dbget.close()	:	response.End
end select

%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
