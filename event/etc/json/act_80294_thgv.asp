<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp"-->
<!-- #include virtual="/lib/inc_const.asp"-->
<!-- #include virtual="/lib/classes/item/itemInfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryPrdCls.asp" -->
<!-- #include virtual="/lib/util/JSON_2.0.4.asp"-->
<%
'###############################################
' Discription : 2017 추석 세끼
' History : 2017.09.05 허진원 : 신규 생성
'###############################################

dim itemid, oJson, pageDiv


pageDiv = requestCheckVar(Request("pdv"),6)		'// 현재 페이지 구분(only:단독, tradit:전통, new:신상)

'//헤더 출력
Response.ContentType = "application/json"

'// json객체 선언
Set oJson = jsObject()

'=========== 오늘의 특가 선물 ======================

Dim baseDt: baseDt = date & " " & Num2Str(Hour(now),2,"0","R") & ":" & Num2Str(Minute(now),2,"0","R") & ":" & Num2Str(Second(now),2,"0","R")

'// 날짜별 원데이 상품 지정
Select Case left(baseDt,10)
	Case "2017-09-11": itemid=949487		'영국 무설탕 슈퍼잼 선물세트
	Case "2017-09-12": itemid=1556834		'MADVANILLA 바닐라라떼 선물세트 싱글
	Case "2017-09-13": itemid=1285004		'인테이크 닥터넛츠 오리지널뉴
	Case "2017-09-14": itemid=1783983		'제주감귤파이/제주차 이야기 선물세트
	Case "2017-09-15","2017-09-16","2017-09-17": itemid=1549045		'꿀,건,달 벌꿀 3종 미니 선물세트
	Case "2017-09-18": itemid=1639500		'인테이크 힘내 2종 선물세트+쇼핑백
	Case "2017-09-19": itemid=1253348		'마이빈스 더치커피- 더치한첩 40
	Case "2017-09-20": itemid=52732			'신 꽃피는 차 선물세트
	Case "2017-09-21": itemid=1547074		'힘내! 홍삼 젤리스틱
	Case "2017-09-22","2017-09-23","2017-09-24": itemid=1781907		'마이빈스 더치커피 - 추석 선물세트
	Case "2017-09-25": itemid=1791664		'해일 곶감 선물세트 1DAY 특가 모음전
	Case "2017-09-26": itemid=1536908		'힘내! 멀티비타민 오렌지 구미
	Case "2017-09-27": itemid=1783924		'MADVANILLA 바닐라라떼 선물세트 더블
	Case "2017-09-28","2017-09-29","2017-09-30": itemid=1780969		'정성견과 선물세트
	Case Else
		itemid=0
		baseDt=""
end Select

If itemid=0 then
	'// 기간 종료
	oJson("today") = ""
else
	'// 상품 정보 접수
	dim oItem
	set oItem = new CatePrdCls
		oItem.GetItemData itemid

		If oItem.FResultCount > 0 Then
			Set oJson("today") = jsObject()
			oJson("today")("date") = replace(baseDt,"-","/")
			oJson("today")("itemid") = cStr(itemid)
			oJson("today")("itemname") = cStr(oItem.Prd.Fitemname)
			oJson("today")("imgurl") = cStr(oItem.Prd.FImageicon2)		'150px icon image
			oJson("today")("orgprice") = FormatNumber(oItem.Prd.FOrgPrice,0) & chkIIF(oItem.Prd.IsMileShopitem,"Pt","원")
			oJson("today")("sellprice") = FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Pt","원")
			If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN
				oJson("today")("saleper") = cStr(int((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100)) & "%"
			else
				oJson("today")("saleper") = ""
			end if
		else
			oJson("today") = ""
		end if
end if


'=========== 페이지별 선물 목록 ======================
dim arrItem, strSort

Select Case pageDiv
	Case "only"		'단독
		arrItem = "1780969,1780601,1515948,1780970,1780971,1780603"
		'arrItem = "123125,123123,456789,123127,266397,123124"
	Case "tradit"	'전통
		arrItem = "1253348,915264,1549045,1630836,1059384,1780974"
	Case "new"		'신상
		arrItem = "1781962,1780978,1780968,1780976,1780975,1702197"
	
end Select

if arrItem<>"" then
	'정렬순서 쿼리
	dim srt, lp
	for each srt in split(arrItem,",")
		lp = lp +1
		strSort = strSort & "When itemid=" & srt & " then " & lp & " "
	next

	dim sqlStr
	sqlStr = "Select itemid, itemname, orgprice, sellcash, sailyn, itemdiv "
	sqlStr = sqlStr & "from db_item.dbo.tbl_item "
	sqlStr = sqlStr & "where itemid in (" & arrItem & ")"
	sqlStr = sqlStr & "order by case " & strSort & " end"
	rsget.Open sqlStr,dbget,adOpenForwardOnly,adLockReadOnly
	
	if Not(rsget.EOF or rsget.BOF) then
		Set oJson("giftlist") = jsArray()
		
		Do Until rsget.EOF
			Set oJson("giftlist")(null) = jsObject()
			oJson("giftlist")(null)("itemid") = cStr(rsget("itemid"))
			oJson("giftlist")(null)("itemname") = cStr(rsget("itemname"))
			oJson("giftlist")(null)("orgprice") = FormatNumber(rsget("orgprice"),0) & chkIIF(rsget("itemdiv")="82","Pt","원")
			oJson("giftlist")(null)("sellprice") = FormatNumber(rsget("sellcash"),0) & chkIIF(rsget("itemdiv")="82","Pt","원")

			If (rsget("sailyn")="Y") and (rsget("orgprice") - rsget("sellcash") > 0) THEN
				oJson("giftlist")(null)("saleper") = cStr(int((rsget("orgprice")-rsget("sellcash"))/rsget("orgprice")*100)) & "%"
			else
				oJson("giftlist")(null)("saleper") = ""
			end if

			rsget.MoveNext
		loop
	else
		oJson("giftlist") = ""
	end if
	rsget.Close
else
	oJson("giftlist") = ""
end if

'Json 출력(JSON)
oJson.flush
Set oJson = Nothing
%>
