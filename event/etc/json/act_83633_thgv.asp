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
' Discription : 2018 설 원데이
' History : 2017.09.05 허진원 : 신규 생성
'			2018-01-19 이종화 : 페이지별 선물 목록 제거
'###############################################

dim itemid, oJson
Dim pageDiv

'//헤더 출력
Response.ContentType = "application/json"

'// json객체 선언
Set oJson = jsObject()

'=========== 오늘의 특가 선물 ======================

Dim baseDt: baseDt = date & " " & Num2Str(Hour(now),2,"0","R") & ":" & Num2Str(Minute(now),2,"0","R") & ":" & Num2Str(Second(now),2,"0","R")
'baseDt = Date()+3
'// 날짜별 원데이 상품 지정
Select Case left(baseDt,10)
	'// 1주차
	Case "2018-01-22": itemid=949487		'영국 무설탕 슈퍼잼 선물세트
	Case "2018-01-23": itemid=1556834		'MADVANILLA 바닐라라떼 선물세트 싱글
	Case "2018-01-24": itemid=1212217		'인테이크 에센셜 조미료 3종(허브/향신료/천연조미료)
	Case "2018-01-25": itemid=52732			'신꽃피는차 - 선물 셋트
	Case "2018-01-26","2018-01-27","2018-01-28": itemid=1780969		'정성견과 선물세트

	'// 2주차
	Case "2018-01-29": itemid=1860800		'제주 더치커피_ 마이빈스 새해기원 선물세트 (210mlx4ea)
	Case "2018-01-30": itemid=1285004		'아몬드/캐슈넛/호두/피스타치오/피칸 닥터넛츠 오리지널뉴(30팩)
	Case "2018-01-31": itemid=1596901		'현미 연강정 선물세트 M 생강/초코/사과 (쇼핑백 포함) 			
	Case "2018-02-01": itemid=1879838		'[꽃을담다]미니꽃차&티스틱세트+쑥꽃티스틱세트(5ea)
	Case "2018-02-02","2018-02-03","2018-02-04": itemid=1549045		'[꿀.건.달] ★보자기묶음 벌꿀 3종 미니 선물세트

	'// 3주차
	Case "2018-02-05": itemid=1887287		'해일 곶감 설 선물세트
	Case "2018-02-06": itemid=1630836		'현미 연강정&정과&편강&부각 선물세트L 생강/초코/사과칩 
	Case "2018-02-07": itemid=1253348		'마이빈스 더치한첩 40
	Case "2018-02-08": itemid=1792350		'인시즌 생강 5종 선물세트
	Case "2018-02-09","2018-02-10","2018-02-11": itemid=1212217		'인테이크 에센셜 조미료 3종

	'// 4주차
	Case "2018-02-12": itemid=1780968		'인테이크 모닝죽
	Case "2018-02-13": itemid=1630095		'[SuperNuts]100%땅콩 슈퍼너츠-선물세트
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

'Json 출력(JSON)
oJson.flush
Set oJson = Nothing
%>
