<%@codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
Response.CharSet = "UTF-8"
'####################################################
' Description : 쿠폰 다운로드 체크
' History : 2023.02.01 정태훈 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/util/functions.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/base64.asp" -->
<!-- #include virtual="/lib/util/JSON_2.0.4.asp"-->
<%
	Response.ContentType = "application/json"
	response.charset = "utf-8"
	dim currentDate, eventStartDate, eventEndDate, i, refer
	Dim eCode, LoginUserid, mode, sqlStr, device, snsType, returntext, eventobj
	dim result, oJson, mktTest, vItemID, cnt
	dim vQuery , vIsExistItem , iscouponeDown, couponCode

    refer 		= request.ServerVariables("HTTP_REFERER") '// 레퍼러
	Set oJson = jsObject()
	mode = request("mode")
	couponCode = request("couponCode")
    iscouponeDown = false
	IF application("Svr_Info") = "Dev" THEN
	else
		If InStr(refer, "10x10.co.kr") < 1 Then
			'oJson("response") = "fail"
			'oJson("faildesc") = "잘못된 접속입니다."
			'oJson.flush
			'Set oJson = Nothing
			'dbget.close() : Response.End
		End If
	End If

    if couponCode="" or isnull(couponCode) then
        oJson("response") = "fail"
        oJson("faildesc") = "쿠폰코드 정보가 없습니다."
        oJson.flush
        Set oJson = Nothing
        dbget.close() : Response.End
    end if

    if mode="" or isnull(mode) then
        oJson("response") = "fail"
        oJson("faildesc") = "조회 구분 정보가 없습니다."
        oJson.flush
        Set oJson = Nothing
        dbget.close() : Response.End
    end if

	LoginUserid		= getencLoginUserid()

    if LoginUserid="" then
        oJson("response") = "fail"
        oJson("faildesc") = "비 로그인 상태입니다."
        oJson.flush
        Set oJson = Nothing
        dbget.close() : Response.End
    end if

    if mode="itemcoupon" then
        vQuery = "select count(couponidx) from [db_item].[dbo].[tbl_user_item_coupon] with (nolock) where userid = '" & LoginUserid & "'"
        vQuery = vQuery + " and itemcouponidx in ("&couponCode&") "
        vQuery = vQuery + " and usedyn = 'N' "
        rsget.CursorLocation = adUseClient
        rsget.Open vQuery,dbget,adOpenForwardOnly,adLockReadOnly
        If rsget(0) > 0 Then
            iscouponeDown = true
        End IF
        rsget.close
    elseif mode="bonuscoupon" then
        vQuery = "select count(idx) from [db_user].[dbo].[tbl_user_coupon] with (nolock) where userid = '" & LoginUserid & "'"
        vQuery = vQuery + " and masteridx in ("&couponCode&") "
        vQuery = vQuery + " and deleteyn = 'N' "
        rsget.CursorLocation = adUseClient
        rsget.Open vQuery,dbget,adOpenForwardOnly,adLockReadOnly
        If rsget(0) > 0 Then
            iscouponeDown = true
        End IF
        rsget.close
       
	End If

	oJson("response") = "ok"
    oJson("coupondown") = iscouponeDown
	oJson.flush
	Set oJson = Nothing
	dbget.close() : Response.End

%>
<!-- #include virtual="/lib/db/dbclose.asp" -->