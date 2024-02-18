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
<!-- #include virtual="/lib/classes/item/dealCls.asp" -->
<%
'###############################################
' Discription : 17주년 특가이벤트
' History : 2018.10.12 최종원
'###############################################
Class brandObjCls
	Public brandName
	Public brandCopy
	Public brandItemCode
	
	Public brandImg
	public brandSalePer	
	
	public evtcode
	public linktype '//1 - itemid , 2 - eventid
End Class

dim itemid, oJson, pageDiv, i, itemImgArr(), specialItemImg, todayBrandImg
dim specialItemCode, landingUrl, brandList(), brandObj, specialItemName, specialItemMainImg, specialItemSellPrice
dim specialItemDealSalePer, specialItemDealsellPrice, specialItemDealSalePrice
dim testDateParam

testDateParam = request("testdate")

Redim preserve itemImgArr(13)
Redim preserve brandList(3)

'brand
set brandList(0) = new brandObjCls
set brandList(1) = new brandObjCls
set brandList(2) = new brandObjCls

'deal schedule
itemImgArr(0) = "http://webimage.10x10.co.kr/fixevent/event/2018/17th/89541/img_pop_1015.png"	'15일
itemImgArr(1) = "http://webimage.10x10.co.kr/fixevent/event/2018/17th/89541/img_pop_1016.png?v=0.01"	'16일
itemImgArr(2) = "http://webimage.10x10.co.kr/fixevent/event/2018/17th/89541/img_pop_1017.png"	'17일
itemImgArr(3) = "http://webimage.10x10.co.kr/fixevent/event/2018/17th/89541/img_pop_1018.png"	'18일
itemImgArr(4) = "http://webimage.10x10.co.kr/fixevent/event/2018/17th/89541/img_pop_1019.png"	'19일
itemImgArr(5) = "http://webimage.10x10.co.kr/fixevent/event/2018/17th/89541/img_pop_1022.png"	'22일
itemImgArr(6) = "http://webimage.10x10.co.kr/fixevent/event/2018/17th/89541/img_pop_1023.png"	'23일
itemImgArr(7) = "http://webimage.10x10.co.kr/fixevent/event/2018/17th/89541/img_pop_1024.png"	'24일
itemImgArr(8) = "http://webimage.10x10.co.kr/fixevent/event/2018/17th/89541/img_pop_1025.png"	'25일
itemImgArr(9) = "http://webimage.10x10.co.kr/fixevent/event/2018/17th/89541/img_pop_1026.png"	'26일
itemImgArr(10) = "http://webimage.10x10.co.kr/fixevent/event/2018/17th/89541/img_pop_1029.png"	'29일
itemImgArr(11) = "http://webimage.10x10.co.kr/fixevent/event/2018/17th/89541/img_pop_1030.png"	'30일
itemImgArr(12) = "http://webimage.10x10.co.kr/fixevent/event/2018/17th/89541/img_pop_1031.png"	'31일


'//헤더 출력
Response.ContentType = "application/json"

'// json객체 선언
Set oJson = jsObject()

'=========== 오늘의 특가 선물 ======================

Dim baseDt: baseDt = date & " " & Num2Str(Hour(now),2,"0","R") & ":" & Num2Str(Minute(now),2,"0","R") & ":" & Num2Str(Second(now),2,"0","R")
'// 날짜별 원데이 상품 지정
if testDateParam <> "" then
	baseDt = testDateParam
end if

Select Case left(baseDt,10)					
	Case "2018-10-23": 
	'특가
		specialItemCode = 2116053' 
		specialItemName = "추울때 필요한건 마틸라"
		specialItemSellPrice = 176000
	'특가 딜
		specialItemDealSalePer	= "~48%"
		specialItemDealsellPrice= "59900"
		specialItemDealSalePrice= "7900"
	'브랜드			
	'1
		brandList(0).brandName = "DODOT"
		brandList(0).brandCopy = "자취생 필수 가구, 두닷"
		brandList(0).brandSalePer = "~68"		
		brandList(0).evtcode = "89904"						
	'2
		brandList(1).brandName = "SNEAKERS BEST 7 "
		brandList(1).brandCopy = "편하고 이쁜 신발 다 있다"
		brandList(1).brandSalePer = "~80"		
		brandList(1).evtcode = "89839"				
	'3	
		brandList(2).brandName = "HOME GALLERY 5"
		brandList(2).brandCopy = "공간을 공유하고 싶은 그림"
		brandList(2).brandSalePer = "~40"		
		brandList(2).evtcode = "89968"						
	Case "2018-10-24": 
	'특가
		specialItemCode = 2116700' 
		specialItemName = "드레텍 스탑워치 3종"
		'specialItemSellPrice = 176000 일반 상품용
	'특가 딜
		specialItemDealSalePer	= "~40%"
		specialItemDealsellPrice= "12900"
		specialItemDealSalePrice= "7700"
	'브랜드			
	'1
		brandList(0).brandName = "DESIGNERSROOM"
		brandList(0).brandCopy = "이쁜데 실용적이기까지"
		brandList(0).brandSalePer = "~89"		
		brandList(0).evtcode = "89902"						
	'2
		brandList(1).brandName = "BAG BEST BRAND 7"
		brandList(1).brandCopy = "매일 들고 다니고 싶어지는"
		brandList(1).brandSalePer = "~57"		
		brandList(1).evtcode = "89869"				
	'3	
		brandList(2).brandName = "Recolte"
		brandList(2).brandCopy = "작지만 알찬 주방을 위해"
		brandList(2).brandSalePer = "~35"		
		brandList(2).evtcode = "89981"				
	Case "2018-10-25": 
	'특가
		specialItemCode = 2117048' 
		specialItemName = "뷰티 기초 보습대전"
		'specialItemSellPrice = 176000 일반 상품용
	'특가 딜
		specialItemDealSalePer	= "~72%"
		specialItemDealsellPrice= "112100"
		specialItemDealSalePrice= "1600"
	'브랜드			
	'1
		brandList(0).brandName = "CUP&TUMBLER HOT 10"
		brandList(0).brandCopy = "추울 때 따뜻한 한 모금 "
		brandList(0).brandSalePer = "~74"		
		brandList(0).evtcode = "89949"						
	'2
		brandList(1).brandName = "Dyson"
		brandList(1).brandCopy = "강력한 흡입 강력한 할인"
		brandList(1).brandSalePer = "~43"		
		brandList(1).evtcode = "89977"				
	'3	
		brandList(2).brandName = "travelus"
		brandList(2).brandCopy = "일상과 여행, 모두를 위한"
		brandList(2).brandSalePer = "~25"		
		brandList(2).evtcode = "89982"		
	Case "2018-10-26": 
	'특가
		specialItemCode = 2117264' 
		specialItemName = "가습기 모음딜"
		'specialItemSellPrice = 176000 일반 상품용
	'특가 딜
		specialItemDealSalePer	= "~80%"
		specialItemDealsellPrice= "759000"
		specialItemDealSalePrice= "15900"
	'브랜드			
	'1
		brandList(0).brandName = "TANGLE TEEZER"
		brandList(0).brandCopy = "손상모도 손맛 나는 빗질"
		brandList(0).brandSalePer = "~30"		
		brandList(0).evtcode = "89975"						
	'2
		brandList(1).brandName = "FASHION BEST 100"
		brandList(1).brandCopy = "쌀쌀한 가을에 꼭 필요한 상의"
		brandList(1).brandSalePer = "~80"		
		brandList(1).evtcode = "89965"				
	'3	
		brandList(2).brandName = "MD'S CANDLE"
		brandList(2).brandCopy = "내 공간을 향기롭게 채우다"
		brandList(2).brandSalePer = "~62"		
		brandList(2).evtcode = "89969"		
	Case "2018-10-27", "2018-10-28", "2018-10-29": 	
	'특가
		specialItemCode = 2124425' 
		specialItemName = "드롱기 외 커피용품"
		'specialItemSellPrice = 176000 일반 상품용
	'특가 딜
		specialItemDealSalePer	= "~50%"
		specialItemDealsellPrice= "599000"
		specialItemDealSalePrice= "3000"
	'브랜드			
	'1
		brandList(0).brandName = "APPLE"
		brandList(0).brandCopy = "혁신적인 무선 이어폰, 최저가"
		brandList(0).brandSalePer = "32"		
		brandList(0).evtcode = "1885168"
		brandList(0).linktype = "1"
	'2
		brandList(1).brandName = "BO WELL"
		brandList(1).brandCopy = "일상적 공간을 디자인하다"
		brandList(1).brandSalePer = "~35"		
		brandList(1).evtcode = "89957"
		brandList(1).linktype = "2"
	'3	
		brandList(2).brandName = "cocodo'r"
		brandList(2).brandCopy = "국민 디퓨저의 유니크한 향"
		brandList(2).brandSalePer = "~70"		
		brandList(2).evtcode = "90065"
		brandList(2).linktype = "2"
	Case "2018-10-30": 
	'특가
		specialItemCode = 2126580' 
		specialItemName = "슬로우 매트리스"
		'specialItemSellPrice = 176000 일반 상품용
	'특가 딜
		specialItemDealSalePer	= "~29%"
		specialItemDealsellPrice= "690000"
		specialItemDealSalePrice= "355000"
	'브랜드			
	'1
		brandList(0).brandName = "CAT&DOG BEST 100"
		brandList(0).brandCopy = "강아지도 인정한 그 상품!"
		brandList(0).brandSalePer = "~63"		
		brandList(0).evtcode = "90036"
		brandList(0).linktype = "2"
	'2
		brandList(1).brandName = "MARKETB"
		brandList(1).brandCopy = "자취방 필수 가구"
		brandList(1).brandSalePer = "~42"		
		brandList(1).evtcode = "90057"
		brandList(1).linktype = "2"
	'3	
		brandList(2).brandName = "FOOD BEST 10"
		brandList(2).brandCopy = "SNS에서 핫한 푸드"
		brandList(2).brandSalePer = "~73"		
		brandList(2).evtcode = "90078"
		brandList(2).linktype = "2"	
	Case "2018-10-31": 
	'특가
		specialItemCode = 1948944' 
		specialItemName = "진리상점X닥터리브"
		specialItemSellPrice = 9900 ' 일반 상품용
	'특가 딜
		'specialItemDealSalePer	= "~29%"
		'specialItemDealsellPrice= "690000"
		'specialItemDealSalePrice= "355000"
	'브랜드			
	'1
		brandList(0).brandName = "MONDAYHOUSE"
		brandList(0).brandCopy = "원목의 아늑함 그대로"
		brandList(0).brandSalePer = "~76"		
		brandList(0).evtcode = "89991"
		brandList(0).linktype = "2"
	'2
		brandList(1).brandName = "HOT WINTER"
		brandList(1).brandCopy = "월동준비 특가"
		brandList(1).brandSalePer = "~83"		
		brandList(1).evtcode = "90071"
		brandList(1).linktype = "2"
	'3	
		brandList(2).brandName = "KODAK"
		brandList(2).brandCopy = "찍고 뽑고 맛보고 즐기고~"
		brandList(2).brandSalePer = "~36"		
		brandList(2).evtcode = "90154"
		brandList(2).linktype = "2"		
	Case Else
		specialItemCode=0
		baseDt=""
end Select

'품절여부 확인

  
 

dim isSoldOut, strSql

isSoldOut = 0

	strSql = " SELECT SELLYN "
	strSql = strSql & "	FROM DB_ITEM.DBO.TBL_ITEM "
	strSql = strSql & "	WHERE ITEMID =  '"&specialItemCode&"'"
	
	rsget.CursorLocation = adUseClient
	rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly
	
	if Not rsget.Eof Then
	isSoldOut = rsget("SELLYN")
	End If
	rsget.close

If specialItemCode=0 then
	'// 기간 종료
	oJson("today") = ""
else
	'// 상품 정보 접수
	dim oItem
	dim orgprice, sellprice, saleyn
	set oItem = new CatePrdCls
		oItem.GetItemData specialItemCode

		If oItem.FResultCount > 0 Then
			Set oJson("today") = jsObject()
			oJson("today")("date") = replace(baseDt,"-","/")
			oJson("today")("specialItemCode") = cStr(specialItemCode)
			oJson("today")("itemname") = specialItemName			
			oJson("today")("itemdiv") = cStr(oItem.Prd.FItemDiv)		'itemdiv			
			if cStr(oItem.Prd.FItemDiv) = 21 then ' 딜 상품일 경우 
				Dim oDeal, ArrDealItem
				Set oDeal = New DealCls
				oDeal.GetIDealInfo specialItemCode

				ArrDealItem = oDeal.GetDealItemList(oDeal.Prd.FDealCode)

				orgprice = ArrDealItem(11,0) 				
				saleyn = cStr(ArrDealItem(10,0)) 'saleyn

				oJson("today")("orgprice") = FormatNumber(FiX(orgprice),0) & "원"
				oJson("today")("sellprice") = FormatNumber(FiX(sellprice),0) & "원"
				oJson("today")("saleyn") = saleyn
				oJson("today")("specialItemDealSalePer") = specialItemDealSalePer
				oJson("today")("specialItemDealsellPrice") = FormatNumber(FiX(specialItemDealsellPrice),0) & "원"
				oJson("today")("specialItemDealSalePrice") = FormatNumber(FiX(specialItemDealSalePrice),0) & "원"				
			else
				orgprice = oItem.Prd.FOrgPrice
				sellprice =  oItem.Prd.FSellCash
				sellprice =  specialItemSellPrice
				saleyn = cStr(oItem.Prd.FSaleYn)					

				oJson("today")("orgprice") = FormatNumber(FiX(orgprice),0) & "원"
				oJson("today")("sellprice") = FormatNumber(FiX(sellprice),0) & "원"
				oJson("today")("saleyn") = saleyn
				oJson("today")("isSoldOut") = isSoldOut				
			end if

'			If (saleyn="Y") and (int(orgprice) - int(sellprice) > 0) THEN
				oJson("today")("saleper") = cStr(int( round((orgprice-sellprice)/orgprice*100) )) & "%"
'			else
'				oJson("today")("saleper") = ""
'			end if			
		else
			oJson("today") = ""
		end if
end if

	Set oJson("brandList") = jsArray()
	For i = 0 To UBound(brandList) - 1
		Set oJson("brandList")(null) = jsObject()
		oJson("brandList")(null)("brandName") = brandList(i).brandName
		oJson("brandList")(null)("brandCopy") = brandList(i).brandCopy		
		oJson("brandList")(null)("brandSalePer") = brandList(i).brandSalePer		
		oJson("brandList")(null)("evtcode") = brandList(i).evtcode
		oJson("brandList")(null)("linktype") = brandList(i).linktype		
	next

	Set oJson("itemImgList") = jsArray()
	For i = 0 To UBound(itemImgArr) - 1
		Set oJson("itemImgList")(null) = jsObject()
		oJson("itemImgList")(null)("itemImg") = itemImgArr(i)
	next

'Json 출력(JSON)
oJson.flush
Set oJson = Nothing
%>
