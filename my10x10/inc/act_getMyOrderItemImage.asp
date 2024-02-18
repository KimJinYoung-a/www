<%@ codepage="65001" language="VBScript" %>
<%
option Explicit
Response.CharSet = "utf-8"
%>
<%
'#######################################################
'	History	:  2015.03.20 허진원 생성
'	Description : 내 주문의 상품 이미지 반환
'#######################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<%
	if ((Not IsUserLoginOK) and (Not IsGuestLoginOK)) then
		dbget.Close:  response.end
	end if

	Dim sqlStr, orderserial
	orderserial = requestCheckVar(Request("ordsn"),11)
	
	if orderserial="" then
		dbget.Close:  response.end
	end if

	sqlStr =	" SELECT top 1 d.itemid, d.itemname, i.smallimage, i.listimage " &_
				" FROM db_order.dbo.tbl_order_detail d " &_
				" JOIN [db_item].[dbo].tbl_item i" &_
				"		ON d.itemid=i.itemid " &_
				" WHERE d.orderserial='" + orderserial + "'" &_
				" and d.itemid<>0" &_
				" and d.cancelyn<>'Y'" &_
				" order by d.itemname desc "
	rsget.Open sqlStr,dbget,1

	if Not rsget.Eof then
		'Response.Write "http://webimage.10x10.co.kr/image/small/" + GetImageSubFolderByItemID(rsget("itemid")) + "/" + rsget("smallimage")
		if Not(rsget("listimage")="" or isNull(rsget("listimage"))) then
			Response.Write "http://webimage.10x10.co.kr/image/list/" + GetImageSubFolderByItemID(rsget("itemid")) + "/" + rsget("listimage")
		end if
	end if

	rsget.Close
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->