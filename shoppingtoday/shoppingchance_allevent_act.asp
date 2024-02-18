<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/classes/enjoy/shoppingchanceCls_B.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<%
	Dim scType, sCategory, sCateMid
	Dim cShopchance
	Dim iTotCnt, arrList,intLoop
	Dim iPageSize, iCurrpage ,iDelCnt
	Dim iStartPage, iEndPage, iTotalPage, ix,iPerCnt, k
	Dim atype,cdl,cdm , selOp
	Dim tempHTML
	atype = RequestCheckVar(request("atype"),1)
	if atype="" then atype="b"

	selOp		=  requestCheckVar(Request("selOP"),1) '정렬

	'파라미터값 받기 & 기본 변수 값 세팅
	scType 		= requestCheckVar(Request("scT"),4) '쇼핑찬스 분류
	sCategory 	= getNumeric(requestCheckVar(Request("disp"),3)) '카테고리 대분류
	iCurrpage 	= getNumeric(requestCheckVar(Request("iC"),10))	'현재 페이지 번호

	If scType ="end" then
		selOp = "1"
	ElseIf selOp = "" Then
		selOp = "0"
	End if

	IF iCurrpage = "" THEN	iCurrpage = 1

	iPageSize = 20		'한 페이지의 보여지는 열의 수
	iPerCnt = 10		'보여지는 페이지 간격

	'데이터 가져오기
	set cShopchance = new ClsShoppingChance
	cShopchance.FCPage 		= iCurrpage		'현재페이지
	cShopchance.FPSize 		= iPageSize		'페이지 사이즈
	cShopchance.FSCType 	= scType    	'이벤트구분(전체,세일,사은품,상품후기, 신규,마감임박)
	cShopchance.FSCategory 	= sCategory 	'제품 카테고리 대분류
	cShopchance.FSCateMid 	= sCateMid		'제품 카테고리 중분류
	cShopchance.FEScope 	= 2				'view범위: 10x10
	cShopchance.FselOp	 	= selOp			'이벤트정렬
	arrList = cShopchance.fnGetBannerList	'배너리스트 가져오기
	iTotCnt = cShopchance.FTotCnt 			'배너리스트 총 갯수
	set cShopchance = nothing

	iTotalPage =   int((iTotCnt-1)/iPageSize) +1  '전체 페이지 수

	'################# 박스 5,6,13,14 값 셋팅 ##################
	Dim c, vClass(21), vSize(21), vLink, vImg, vIcon, vName, tName, tSale , vTag , ip , addTag

	'// 배열 순서 랜덤
	Dim vImageSize(6) , jj , kk , mm , ii
	Randomize

	For jj = 1 To 6
		kk = Int((20)*Rnd+1 ) '1부터 20까지의 난수 발생
		vImageSize(jj) = kk
		For mm = 1 To jj '같은수가 있는지 비교
			If vImageSize(jj)=vImageSize(mm-1) Then '"같은 숫자가 있다면
			kk = Int((20)*Rnd+1 )
			vImageSize(jj)=kk
			End If
		Next
	Next

	For c = 1 To 20
		If c = vImageSize(1) OR c = vImageSize(2) OR c = vImageSize(3) OR c = vImageSize(4) or c = vImageSize(5) or c = vImageSize(6) Then	''가로 이미지
			vClass(c) = "type02"
			vSize(c) = "width=""360"" height=""195"""
		Else							''그외 세로 작은 이미지
			vClass(c) = "type01"
			vSize(c) = "width=""420"" height=""420"""
		End If
	Next
	'###########################################################

	'### 배열번호
	' 0 ~ 7  : A.evt_code, B.evt_bannerimg, A.evt_startdate, A.evt_enddate, A.evt_kind, B.brand,B.evt_LinkType ,B.evt_bannerlink '
	' 8		 : ,(Case When A.evt_kind=13 Then (Select top 1 itemid from [db_event].[dbo].[tbl_eventitem] where evt_code=A.evt_code order by itemid desc) else 0 end) as itemid '
	' 9 ~ 10 : , B.etc_itemid, isNull(B.etc_itemimg,'''') as etc_itemimg '
	'11		 : , case when isNull(B.etc_itemimg,'''') = '''' then (select isNull(basicimage600,'''') from db_item.dbo.tbl_item where itemid = B.etc_itemid) end as basicimage600 '
	'12		 : , case when isNull(B.etc_itemimg,'''') = '''' then (select basicimage from db_item.dbo.tbl_item where itemid = B.etc_itemid) end as basicimage '
	'13 ~ 22 : , A.evt_name, A.evt_subcopyK, B.issale, B.isgift, B.iscoupon, B.isOnlyTen, B.isoneplusone, B.isfreedelivery, B.isbookingsell, B.iscomment '
	'23	~ 24 : , B.evt_tag , isNull(B.evt_mo_listbanner,'''') as etc_wideimg '

	IF isArray(arrList) THEN
		For intLoop =0 To UBound(arrList,2)

			IF arrList(4,intLoop) = "16" Then
				IF arrList(6,intLoop) = "I" and arrList(7,intLoop) <> "" THEN '링크타입 체크
					vLink = arrList(7,intLoop)
				ELSE
					vLink = "javascript:GoToBrandShopevent_direct('" & arrList(5,intLoop) & "','" & arrList(0,intLoop) & "');"
				END IF
				vName = split(arrList(13,intLoop),"|")(0)
			Elseif arrList(4,intLoop) = "13" Then
				vLink = "javascript:TnGotoProduct('" & arrList(8,intLoop) & "');"
				vName = arrList(13,intLoop)
			Else
				IF arrList(6,intLoop) = "I" and arrList(7,intLoop) <> "" THEN '링크타입 체크
					vLink = arrList(7,intLoop)
				ELSE
					''vLink = "TnGotoEventMain('" & arrList(0,intLoop) & "');"
					vLink = "/event/eventmain.asp?eventid=" & arrList(0,intLoop) & "&gaparam=enjoyevent_"&CHKIIF(scType<>"",scType,"all")&"_"&intLoop+1&""  ''2017/05/25
				END IF
				vName = arrList(13,intLoop)
			End IF

			IF vClass(intLoop+1) = "type01" Then 
				If arrList(10,intLoop) = "" Then
					If arrList(11,intLoop) = "" Then
						vImg = "http://webimage.10x10.co.kr/image/basic/" & GetImageSubFolderByItemid(arrList(9,intLoop)) & "/" & arrList(12,intLoop)
					Else
						vImg = "http://webimage.10x10.co.kr/image/basic600/" & GetImageSubFolderByItemid(arrList(9,intLoop)) & "/" & arrList(11,intLoop)
					End IF
				Else
					vImg = arrList(10,intLoop)
				End If

				vImg = getThumbImgFromURL(vImg,420,420,"true","false")
			ELSE
				vImg = getThumbImgFromURL(arrList(24,intLoop),360,195,"true","false")
			END IF

			vIcon = ""
			If arrList(18,intLoop) Then
				vIcon = vIcon & "<span class=""labelV18 label-s label-black""><b>ONLY</b></span>"
			End IF
			If arrList(15,intLoop) Then
				vIcon = vIcon & "<span class=""labelV18 label-s label-black""><b>SALE</b></span>"
			End IF
			If arrList(17,intLoop) Then
				vIcon = vIcon & "<span class=""labelV18 label-s label-black""><b>쿠폰</b></span>"
			End IF
			If arrList(19,intLoop) Then
				vIcon = vIcon & "<span class=""labelV18 label-s label-black""><b>1+1</b></span>"
			End IF
			If arrList(16,intLoop) Then
				vIcon = vIcon & "<span class=""labelV18 label-s label-black""><b>GIFT</b></span>"
			End IF
			If datediff("d",arrList(2,intLoop),date)<=3 Then
				vIcon = vIcon & "<span class=""labelV18 label-s label-black""><b>NEW</b></span>"
			End IF
			If arrList(22,intLoop) Then
				vIcon = vIcon & "<span class=""labelV18 label-s label-black""><b>참여</b></span>"
			End IF
			If datediff("d",arrList(3,intLoop),date) = 0 Then
				vIcon = vIcon & "<span class=""labelV18 label-s label-black""><b>오늘이 마지막!</b></span>"
			End IF

			'//이벤트 명 할인이나 쿠폰시
			tName = ""
			tSale = ""
			If arrList(15,intLoop) Or arrList(17,intLoop) Then
				if ubound(Split(vName,"|")) > 0 Then
					If arrList(15,intLoop) Or (arrList(15,intLoop) And arrList(17,intLoop)) then
						tName	= cStr(Split(vName,"|")(0))
						tSale	= " <b class=""discount color-redV19"">"& cStr(Split(vName,"|")(1)) &"</b>"
					ElseIf arrList(17,intLoop) Then
						tName	= cStr(Split(vName,"|")(0)) 
						tSale	= " <b class=""discount color-greenV19"">"& cStr(Split(vName,"|")(1)) &"</b>"
					End If
				Else
					tName = vName
					tSale = ""
				end If
			else
				tName = vName
				tSale = ""
			End If 

			addTag = ""
			if arrList(23,intLoop) <> "" or not(isnull(arrList(23,intLoop))) then
				if ubound(Split(arrList(23,intLoop),",")) > 0 Then
					addTag = addTag & "<ul class='list-tag'>"
					for ip = 0 to ubound(Split(arrList(23,intLoop),","))
						if ip > 5 then exit for
						addTag = addTag & "<li><a href='/search/search_result.asp?rect="& Split(arrList(23,intLoop),",")(ip) &"'>#"& Split(arrList(23,intLoop),",")(ip) &"</a></li>"
					next 
					addTag = addTag & "</ul>"
				end if 
			end if 

			tempHTML = tempHTML & "<li class='unit unit-exhibition'>"
			tempHTML = tempHTML & "<div class='inner'>"
			tempHTML = tempHTML & "<div class='banner'><a href="""& vLink &"""><img src='"& vImg &"' "& vSize(intLoop+1) &" alt='"& replace(vName,"""","") &"'></a></div>"
			tempHTML = tempHTML & "<div class='desc'>"
			tempHTML = tempHTML & "<a href="""& vLink &""">"
			tempHTML = tempHTML & "<div class='label-area'>"
			tempHTML = tempHTML & vIcon
			tempHTML = tempHTML & "</div>"
			tempHTML = tempHTML & "<p class='headline'>"& db2html(tName) &"</p>"
			tempHTML = tempHTML & "<p class='subcopy'>"& db2html(arrList(14,intLoop)) &" "& tSale &"</p>"
			tempHTML = tempHTML & "</a>"
			tempHTML = tempHTML & addTag
			tempHTML = tempHTML & "</div>"
			tempHTML = tempHTML & "</div>"
			tempHTML = tempHTML & "</li>"

		Next

		response.write tempHTML
	End If
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->