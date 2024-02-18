<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<!-- #include virtual="/login/checkpoplogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/shopping/sp_itemcouponcls.asp" -->

<%
'' 상품쿠폰 받기 Process

dim userid
dim itemcouponidx, prload
dim AlreadyCouponReceived

userid  = getEncLoginUserID
itemcouponidx = requestCheckVar(request.form("itemcouponidx"),10)
prload  = request.form("prload")

if itemcouponidx="" then
	response.write "<script>alert('잘못된 접근입니다.');</script>"
	response.write "<script>window.close();</script>"
	response.end
end if

dim oitemcoupon
set oitemcoupon = new CItemCouponMaster
oitemcoupon.FRectItemCouponIdx = itemcouponidx

oitemcoupon.GetOneItemCouponMaster

if (Not oitemcoupon.FOneItem.IsOpenAvailCoupon) then
	response.write "<script>alert('기간이 종료되었거나 유효하지 않은 쿠폰입니다.');</script>"
	response.write "<script>history.back();</script>"
	response.end
end if

set oitemcoupon = Nothing


dim ouseritemcoupon
set ouseritemcoupon = new CUserItemCoupon
ouseritemcoupon.FRectUserID = userid
ouseritemcoupon.FRectItemCouponIdx = itemcouponidx

AlreadyCouponReceived = ouseritemcoupon.IsCouponAlreadyReceived

if (AlreadyCouponReceived=true) then
	response.write "<script>alert('이미 쿠폰을 받으셨습니다. \n이미 받으신 쿠폰으로 사용 가능 상품에 동시에 적용하실 수 있습니다.');</script>"
	'response.write "<script>history.back();</script>"
	response.write "<script>window.close();</script>"
	response.end
end if



dim sqlStr

if (Not AlreadyCouponReceived) then
	sqlStr = "insert into [db_item].[dbo].tbl_user_item_coupon"
	sqlStr = sqlStr + " (userid,itemcouponidx,issuedno,"
	sqlStr = sqlStr + " itemcoupontype, itemcouponvalue, itemcouponstartdate, "
	sqlStr = sqlStr + " itemcouponexpiredate, itemcouponname, itemcouponimage, couponGubun "
	sqlStr = sqlStr + " )"
	sqlStr = sqlStr + " select top 1 "
	sqlStr = sqlStr + " '" + userid + "'," + CStr(itemcouponidx) + ","
	sqlStr = sqlStr + " (select count(*) as cnt from [db_item].[dbo].tbl_user_item_coupon where itemcouponidx="+ CStr(itemcouponidx)+" and userid='" + userid + "')+1 as issuedno"
	sqlStr = sqlStr + " ,itemcoupontype, itemcouponvalue, itemcouponstartdate"
	sqlStr = sqlStr + " ,[db_item].[dbo].[uf_GetNvItemCouponExpiredate](couponGubun,itemcouponexpiredate) as itemcouponexpiredate"  ''2018/08/27 수정
	sqlStr = sqlStr + " ,itemcouponname, itemcouponimage, couponGubun"
	sqlStr = sqlStr + " from [db_item].[dbo].tbl_item_coupon_master"
	sqlStr = sqlStr + " where itemcouponidx=" + CStr(itemcouponidx)

''response.write sqlStr
	rsget.Open sqlStr, dbget, 1
end if
%>


<%
set ouseritemcoupon = Nothing
%>

<%
dim refer
refer = request.ServerVariables("HTTP_REFERER")
%>

<script language="javascript">
alert('상품 쿠폰이 발급되었습니다. 주문시 사용가능합니다.');
<% if (prload<>"") then %>
	opener.location.reload();
<% end if %>
window.close();
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->

