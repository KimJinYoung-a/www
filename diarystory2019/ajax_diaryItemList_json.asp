<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'#############################################################
'	Description : 다이어리 메인 상품 리스트
'	History		: 2017.09.19 유태욱 생성
'#############################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/diarystory2019/lib/classes/diary_class_B.asp" -->
<!-- #include virtual="/lib/classes/search/searchcls.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/JSON_2.0.4.asp"-->
<%
'//헤더 출력
Response.ContentType = "application/json"

dim oJson
Dim i , PrdBrandList , imglink, vParaMeter , GiftSu, weekDate
Dim PageSize : PageSize	= requestcheckvar(request("page"),2)
dim SortMet : SortMet 	= requestCheckVar(request("srm"),9)
dim CurrPage : CurrPage 	= requestCheckVar(request("cpg"),9)
Dim ListDiv : ListDiv	= requestcheckvar(request("ListDiv"),4)
Dim design : design	= requestcheckvar(request("dsn"),12)
Dim keyword : keyword	= requestcheckvar(request("kwd"),12)
Dim contents : contents	= requestcheckvar(request("ctt"),32)
dim userid : userid		= getEncLoginUserID
If ListDiv = "" Then ListDiv = "item"
IF CurrPage = "" then CurrPage = 1
IF SortMet = "" Then SortMet = "best"

'// json객체 선언
Set oJson = jsObject()

If ListDiv = "list" Then
	PageSize = 16
Else
	PageSize = 16
End If

Dim ArrDesign , tmp , iTmp , ctmp, ktmp, arrcontents ,arrkeyword
ArrDesign = design		'request("arrds")
ArrDesign = split(ArrDesign,",")

For iTmp =0 to Ubound(ArrDesign)-1
	IF ArrDesign(iTmp)<>"" Then
		tmp  = tmp & requestcheckvar(ArrDesign(iTmp),2) &","
	End IF
Next
ArrDesign = tmp

Dim sArrDesign,sarrcontents,sarrkeyword
sArrDesign =""
IF ArrDesign <> "" THEN sArrDesign =  left(ArrDesign,(len(ArrDesign)-1))

vParaMeter = "&arrds="&ArrDesign&""

design = xTrim(design , ",")
keyword = xTrim(keyword , ",")
contents = xTrim(contents , ",")

Set PrdBrandList = new cdiary_list
	'아이템 리스트
	PrdBrandList.FPageSize = PageSize
	PrdBrandList.FCurrPage = CurrPage
	PrdBrandList.frectdesign = design		'sArrDesign
	PrdBrandList.frectcontents = ""
	PrdBrandList.frectajaxcontents = contents
	PrdBrandList.frectkeyword = keyword
	PrdBrandList.fmdpick = ""
	PrdBrandList.ftectSortMet = SortMet
	PrdBrandList.getDiaryItemLIst

	Dim tempimg, tempimg2 , diaryItemBedge
	dim imgSz : imgSz = 240
	If PrdBrandList.FResultCount > 0 Then
		Set oJson("diarylist") = jsArray()
		For i = 0 To PrdBrandList.FResultCount - 1
			If ListDiv = "item" Then
				tempimg = PrdBrandList.FItemList(i).FDiaryBasicImg
				tempimg2 = PrdBrandList.FItemList(i).FDiaryBasicImg2
			End If
			If ListDiv = "list" Then''2016부터 사용안함(활용컷-마우스오버로)
				tempimg = PrdBrandList.FItemList(i).FDiaryBasicImg2
			End If

			IF application("Svr_Info") = "Dev" THEN
				tempimg = left(tempimg,7)&mid(tempimg,12)
				tempimg2 = left(PrdBrandList.FItemList(i).FDiaryBasicImg2,7)&mid(PrdBrandList.FItemList(i).FDiaryBasicImg2,12)''마우스오버 활용컷
			end if

			diaryItemBedge = ""

			if PrdBrandList.FItemList(i).FNewYN = "1" then 
				diaryItemBedge = "<span class=""label new""></span>"
			end if 

			if PrdBrandList.FItemList(i).FmdpickYN = "o" then 
				diaryItemBedge = "<span class=""label best""></span>"
			end if 

			Set oJson("diarylist")(null) = jsObject()
			oJson("diarylist")(null)("image") = cStr(tempimg)
			oJson("diarylist")(null)("addimage") = cStr(tempimg2)
			oJson("diarylist")(null)("itemid") = cStr(PrdBrandList.FItemList(i).FItemid)
			oJson("diarylist")(null)("soldout") = cStr(PrdBrandList.FItemList(i).IsSoldOut)
			oJson("diarylist")(null)("artitemname") = cStr(PrdBrandList.FItemList(i).FItemName)
			if PrdBrandList.FItemList(i).FpreviewImg <> "" then 
				oJson("diarylist")(null)("previewimg") = cStr(PrdBrandList.FItemList(i).FpreviewImg)
			end if
			oJson("diarylist")(null)("makerid") = cStr(PrdBrandList.FItemList(i).FMakerId)
			oJson("diarylist")(null)("makername") = cStr(PrdBrandList.FItemList(i).Fsocname)

			If PrdBrandList.FItemList(i).isSaleItem Or PrdBrandList.FItemList(i).isLimitItem Then
				oJson("diarylist")(null)("itemname") = cStr(chrbyte(PrdBrandList.FItemList(i).FItemName,30,"Y"))
			Else
				oJson("diarylist")(null)("itemname") = cStr(PrdBrandList.FItemList(i).FItemName)
			End If

			if PrdBrandList.FItemList(i).IsSaleItem or PrdBrandList.FItemList(i).isCouponItem Then
				IF PrdBrandList.FItemList(i).IsSaleItem then
					oJson("diarylist")(null)("price") = "<span class='sum'>"&FormatNumber(PrdBrandList.FItemList(i).getRealPrice,0)&"원</span>"&"<span class='discount color-red'>["&PrdBrandList.FItemList(i).getSalePro&"]</span>"
				elseif PrdBrandList.FItemList(i).IsCouponItem Then
					oJson("diarylist")(null)("price") = "<span class='sum'>"&FormatNumber(PrdBrandList.FItemList(i).GetCouponAssignPrice,0)&"원</span>"&"<span class='discount color-green'>["&PrdBrandList.FItemList(i).GetCouponDiscountStr&"]</span>"
				elseif PrdBrandList.FItemList(i).IsSaleItem and PrdBrandList.FItemList(i).isCouponItem then
					oJson("diarylist")(null)("price") = "<span class='sum'>"&FormatNumber(PrdBrandList.FItemList(i).getRealPrice,0)&"원</span>"&"<span class='color-red'>["&PrdBrandList.FItemList(i).getSalePro&"]</span><span class='sum'>"&FormatNumber(PrdBrandList.FItemList(i).GetCouponAssignPrice,0)&"원</span>"&"<span class='color-green'>["&PrdBrandList.FItemList(i).GetCouponDiscountStr&"]</span>"
				end if
			else
				oJson("diarylist")(null)("price") = "<span class='sum'>"&FormatNumber(PrdBrandList.FItemList(i).getRealPrice,0)&chkIIF(PrdBrandList.FItemList(i).IsMileShopitem,"Point","원")&"</span>"
			end if

			oJson("diarylist")(null)("diaryitembedge") = diaryItemBedge
		next
		
		'페이징관련
		Set oJson("diarylistpaging") = jsObject()
		oJson("diarylistpaging")("totalpage") = PrdBrandList.FtotalPage
		oJson("diarylistpaging")("currpage") = PrdBrandList.FCurrPage
		oJson("diarylistpaging")("scrollpage") = PrdBrandList.StartScrollPage
		oJson("diarylistpaging")("scrollcount") = PrdBrandList.FScrollCount
		oJson("diarylistpaging")("totalcount") = PrdBrandList.Ftotalcount
	else
		oJson("diarylist") = ""
		oJson("diarylistpaging") = ""
	End If
	
oJson.flush
Set oJson = Nothing
set PrdBrandList=nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
