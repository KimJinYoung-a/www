<%@codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
Response.CharSet = "UTF-8"
'####################################################
' Description : 브랜드 리스크 카운트
' History : 2023.02.03 정태훈 생성
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
<!-- #include virtual="/lib/classes/item/iteminfoCls.asp" -->
<!-- #include virtual="/lib/classes/search/searchcls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryPrdCls.asp" -->
<%
	Response.ContentType = "application/json"
	response.charset = "utf-8"
	dim vQuery, i, refer, mastercode, obranditem, ocategory
	dim result, oJson, mktTest, cnt, makeridArr, ix, iy
    dim cateCNT1, cateCNT2, cateCNT3, cateCNT4, cateCNT5, cateCNT6, cateCNT7, cateCNT8
    
    refer = request.ServerVariables("HTTP_REFERER") '// 레퍼러
	Set oJson = jsObject()
    
	mastercode = request("mastercode")

	IF application("Svr_Info") = "Dev" THEN
    elseif application("Svr_Info") = "staging" THEN
	else
		If InStr(refer, "10x10.co.kr") < 1 Then
			oJson("response") = "fail"
			oJson("faildesc") = "잘못된 접속입니다."
			oJson.flush
			Set oJson = Nothing
			dbget.close() : Response.End
		End If
	End If

    if mastercode="" or isnull(mastercode) then
        oJson("response") = "fail"
        oJson("faildesc") = "마스터 코드 정보가 없습니다."
        oJson.flush
        Set oJson = Nothing
        dbget.close() : Response.End
    end if

    i=0
	vQuery = "select makerid from [db_event].[dbo].[tbl_exhibition_brandgroup]"
	vQuery = vQuery & " where mastercode=" & Cstr(mastercode)
    vQuery = vQuery & " order by sortNo ASC"
	rsget.CursorLocation = adUseClient
	rsget.Open vQuery,dbget,adOpenForwardOnly,adLockReadOnly
	IF Not (rsget.EOF OR rsget.BOF) THEN
        do until rsget.eof
		    if i < 1 then
                makeridArr = rsget("makerid")
            else
                makeridArr = makeridArr + "," + rsget("makerid")
            end if 
            i=i+1
            rsget.moveNext
        loop
	end if
	rsget.close

	set obranditem = Nothing
	set obranditem = new SearchItemCls
        obranditem.FRectSearchItemDiv = "y"
        obranditem.FCurrPage = 1
        obranditem.FPageSize = 100
        obranditem.FScrollCount =10
        obranditem.FListDiv = "brand"
        obranditem.FLogsAccept = False
        obranditem.FattribCd="410101"
		obranditem.FRectMakerid	= makeridArr
		obranditem.getGroupbyBrandList
    if obranditem.FResultCount > 0 then

        SET oJson("brandlist") = jsArray()
        oJson("response") = "ok"
        For ix=0 To obranditem.FResultCount-1
            SET oJson("brandlist")(NULL) = jsObject()
            oJson("brandlist")(NULL)("makerid") = obranditem.FItemList(ix).FMakerID
            oJson("brandlist")(NULL)("itemCount") = obranditem.FItemList(ix).FItemScore
        Next
    end if
    cateCNT1=0
    cateCNT2=0
    cateCNT3=0
    cateCNT4=0
    cateCNT5=0
    cateCNT6=0
    cateCNT7=0
    cateCNT8=0
	set ocategory = Nothing
	set ocategory = new SearchItemCls
        ocategory.FRectSearchItemDiv = "y"
        ocategory.FCurrPage = 1
        ocategory.FPageSize = 100
        ocategory.FScrollCount =10
        ocategory.FListDiv = "fulllist"
        ocategory.FLogsAccept = False
		ocategory.FattribCd="410101"
        ocategory.FGroupScope = "1"
		ocategory.getGroupbyCategoryList
    if ocategory.FResultCount > 0 then

        For iy=0 To ocategory.FResultCount-1
            if ocategory.FItemList(iy).FCateCd1="101" then
                cateCNT1 = cateCNT1 + ocategory.FItemList(iy).FSubTotal
            elseif ocategory.FItemList(iy).FCateCd1="104" then
                cateCNT2 = cateCNT2 + ocategory.FItemList(iy).FSubTotal
            elseif ocategory.FItemList(iy).FCateCd1="112" then
                cateCNT3 = cateCNT3 + ocategory.FItemList(iy).FSubTotal
            elseif ocategory.FItemList(iy).FCateCd1="116" then
                cateCNT4 = cateCNT4 + ocategory.FItemList(iy).FSubTotal
            elseif ocategory.FItemList(iy).FCateCd1="120" then
                cateCNT5 = cateCNT5 + ocategory.FItemList(iy).FSubTotal
            elseif ocategory.FItemList(iy).FCateCd1="122" then
                cateCNT6 = cateCNT6 + ocategory.FItemList(iy).FSubTotal
            elseif ocategory.FItemList(iy).FCateCd1="124" then
                cateCNT7 = cateCNT7 + ocategory.FItemList(iy).FSubTotal
            elseif ocategory.FItemList(iy).FCateCd1="102" then
                cateCNT8 = cateCNT8 + ocategory.FItemList(iy).FSubTotal
            end if
        Next

        SET oJson("categorylist") = jsArray()
        SET oJson("categorylist")(NULL) = jsObject()
        oJson("categorylist")(NULL)("detailCode") = "601"
        oJson("categorylist")(NULL)("itemCount") = cateCNT1
        SET oJson("categorylist")(NULL) = jsObject()
        oJson("categorylist")(NULL)("detailCode") = "604"
        oJson("categorylist")(NULL)("itemCount") = cateCNT2
        SET oJson("categorylist")(NULL) = jsObject()
        oJson("categorylist")(NULL)("detailCode") = "606"
        oJson("categorylist")(NULL)("itemCount") = cateCNT3
        SET oJson("categorylist")(NULL) = jsObject()
        oJson("categorylist")(NULL)("detailCode") = "607"
        oJson("categorylist")(NULL)("itemCount") = cateCNT4
        SET oJson("categorylist")(NULL) = jsObject()
        oJson("categorylist")(NULL)("detailCode") = "611"
        oJson("categorylist")(NULL)("itemCount") = cateCNT5
        SET oJson("categorylist")(NULL) = jsObject()
        oJson("categorylist")(NULL)("detailCode") = "613"
        oJson("categorylist")(NULL)("itemCount") = cateCNT6
        SET oJson("categorylist")(NULL) = jsObject()
        oJson("categorylist")(NULL)("detailCode") = "614"
        oJson("categorylist")(NULL)("itemCount") = cateCNT7
        SET oJson("categorylist")(NULL) = jsObject()
        oJson("categorylist")(NULL)("detailCode") = "615"
        oJson("categorylist")(NULL)("itemCount") = cateCNT8
    end if

	oJson.flush
	Set oJson = Nothing
    set obranditem = Nothing
    set ocategory = Nothing
	dbget.close() : Response.End

%>
<!-- #include virtual="/lib/db/dbclose.asp" -->