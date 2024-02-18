<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<%
 Dim idx, arridx, stype, arrstype, i, userid, mode
 idx = ReplaceRequest(Request("idx"))
 stype = ReplaceRequest(Request("stype"))
 mode = requestcheckvar(request("mode"),32)
 arridx = split(idx,",")
 arrstype = split(stype,",")
 userid  = GetLoginUserID

IF idx = "" or stype = "" THEN
	''Alert_move "유입경로에 문제가 발생하였습니다. 관리자에게 문의해주십시오","/event/4ten/"
	''dbget.close()	:	response.End
	Response.Write "01||"
	dbget.close() : Response.End
END IF

'## 상품쿠폰 다운 함수
	Function fnSetItemCouponDown(ByVal userid, ByVal idx)
		dim sqlStr
		Dim objCmd
		Set objCmd = Server.CreateObject("ADODB.COMMAND")
		With objCmd
			.ActiveConnection = dbget
			.CommandType = adCmdText
			.CommandText = "{?= call [db_item].[dbo].sp_Ten_itemcoupon_down("&idx&",'"&userid&"')}"
			.Parameters.Append .CreateParameter("RETURN_VALUE", adInteger, adParamReturnValue)
			.Execute, , adExecuteNoRecords
			End With
		    fnSetItemCouponDown = objCmd(0).Value
		Set objCmd = Nothing
	END Function

'## 이벤트쿠폰 다운	함수
	Function fnSetEventCouponDown(ByVal userid, ByVal idx)
		dim sqlStr
		Dim objCmd
		Set objCmd = Server.CreateObject("ADODB.COMMAND")
		With objCmd
			.ActiveConnection = dbget
			.CommandType = adCmdText
			.CommandText = "{?= call [db_user].[dbo].sp_Ten_eventcoupon_down("&idx&",'"&userid&"')}"
			.Parameters.Append .CreateParameter("RETURN_VALUE", adInteger, adParamReturnValue)
			.Execute, , adExecuteNoRecords
			End With
		    fnSetEventCouponDown = objCmd(0).Value
		Set objCmd = Nothing
	END Function

'## 이벤트쿠폰 다운	함수(선택고객,중복발급 불가)
	Function fnSetSelectCouponDown(ByVal userid, ByVal idx)
		dim sqlStr
		Dim objCmd
		Set objCmd = Server.CreateObject("ADODB.COMMAND")
		With objCmd
			.ActiveConnection = dbget
			.CommandType = adCmdText
			.CommandText = "{?= call [db_user].[dbo].sp_Ten_eventcoupon_down_selected("&idx&",'"&userid&"')}"
			.Parameters.Append .CreateParameter("RETURN_VALUE", adInteger, adParamReturnValue)
			.Execute, , adExecuteNoRecords
			End With
		    fnSetSelectCouponDown = objCmd(0).Value
		Set objCmd = Nothing
	END Function


if mode = "cpok" then
	'## 데이터 처리
		dim rvalue, oldrvalue
		dbget.beginTrans
	
		For i = 0 To UBound(arridx)
	
			IF Cstr(arrstype(i)) = "event" THEN '이벤트함수일때 다운처리
				rvalue = fnSetEventCouponDown(userid,arridx(i))
			ELSEIF Cstr(arrstype(i)) = "evtsel" THEN '선택이벤트함수일때 다운처리
				rvalue = fnSetSelectCouponDown(userid,arridx(i))
			ELSEIF 	Cstr(arrstype(i)) = "prd" THEN '상품함수일때 다운처리
				rvalue = fnSetItemCouponDown(userid,arridx(i))
			END IF
	
			if rvalue = 0 then 	'문제 발생시 롤백처리
				exit for
			elseif rvalue = 1 then	'정상처리
				oldrvalue = 1
			elseif (rvalue = 2 or  rvalue = 3) then	'유효하지 않은 쿠폰또는 이미받은 쿠폰 제외하고 다른 쿠폰 다운처리
				if oldrvalue = 1 then 	rvalue = 1
			end if
		Next
	
		SELECT CASE  rvalue
			CASE 0
				dbget.RollBackTrans
				''Alert_move "데이터 처리에 문제가 발생하였습니다. 관리자에게 문의해주십시오","/shoppingtoday/couponshop.asp"
				''Alert_return ("데이터 처리에 문제가 발생하였습니다. 관리자에게 문의해주십시오")
				''dbget.close()	:	response.End
				Response.Write "00||"
				dbget.close() : Response.End	
			CASE 1
				dbget.CommitTrans
				''Alert_move "쿠폰이 발급되었습니다. 주문시 사용가능합니다.","/shoppingtoday/couponshop.asp"
				''Alert_return ("쿠폰이 발급되었습니다. 주문시 사용가능합니다.")
				Response.Write "11||"
				dbget.close() : Response.End				
			CASE 2
				dbget.RollBackTrans
				''Alert_move "기간이 종료되었거나 유효하지 않은 쿠폰입니다.","/shoppingtoday/couponshop.asp"
				''Alert_return ("기간이 종료되었거나 유효하지 않은 쿠폰입니다.")
				''dbget.close()	:	response.End
				Response.Write "12||"
				dbget.close() : Response.End
			CASE 3
				dbget.RollBackTrans
				''Alert_move "이미 쿠폰을 받으셨습니다.","/shoppingtoday/couponshop.asp"
				''Alert_return ("이미 다운로드 받으셨습니다.")
				''dbget.close()	:	response.End
				Response.Write "13||"
				dbget.close() : Response.End
		END SELECT
	dbget.close()	:	response.End
else
	Response.Write "00||"
	dbget.close() : Response.End	
end if

%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
