<%
	'마감임박 이벤트 데이터 가져오기
	if blnFull then
		iPageSize = "3"
	Else
		iPageSize = "2"
	End If

	Dim arrEndList , endiTotCnt , cShopchance , intEndLoop

	set cShopchance = new ClsShoppingChance
	cShopchance.FCPage 		= 1		'현재페이지
	cShopchance.FPSize 		= iPageSize		'페이지 사이즈 형에 따라 다름 기본형 2 풀단or와이드 3
	cShopchance.FSCType 	= "end"    		'이벤트구분(마감임박)
	cShopchance.FSCategory 	= "" 			'제품 카테고리 대분류
	cShopchance.FSCateMid 	= ""			'제품 카테고리 중분류
	cShopchance.FEScope 	= 2				'view범위: 10x10
	cShopchance.FselOp	 	= 1				'이벤트정렬
	arrEndList				= cShopchance.fnGetBannerList	'배너리스트 가져오기
	endiTotCnt				= cShopchance.FTotCnt 			'배너리스트 총 갯수
	set cShopchance = Nothing
	
	'################# 박스 5,6,13,14 값 셋팅 ##################
	Dim c, vLen(21), vLink, vImg, vIcon, vName
	For c = 1 To 20
		If c = 5 OR c = 14 Then
			vLen(c) = 246
		ElseIf c = 6 OR c = 13 Then
			vLen(c) = 102
		Else
			vLen(c) = 86
		End If
	Next
	'###########################################################

	strExpireMsg = "<div class=""evtEndWrapV15"">"
	strExpireMsg = strExpireMsg +"	<p class=""endMsg""" & chkIIF(GetLoginUserLevel()=7," onclick=""$('.evtEndWrapV15').hide();"" style=""cursor:pointer""","") & ">앗! 죄송합니다! 종료된 이벤트 입니다.</p>"
	strExpireMsg = strExpireMsg +"	<div class=""finishSoon"">"
	strExpireMsg = strExpireMsg +"		<div class=""titArea"">"
	strExpireMsg = strExpireMsg +"			<p><strong>이벤트 마감임박!</strong></p>"
	strExpireMsg = strExpireMsg +"			<a href=""/shoppingtoday/shoppingchance_allevent.asp"" class=""more"">more</a>"
	strExpireMsg = strExpireMsg +"		</div>"
	strExpireMsg = strExpireMsg +"		<ul class=""evtListV15"">"

	IF isArray(arrEndList) THEN
		For intEndLoop =0 To UBound(arrEndList,2)

			IF arrEndList(4,intEndLoop) = "16" Then
				IF arrEndList(6,intEndLoop) = "I" and arrEndList(7,intEndLoop) <> "" THEN '링크타입 체크
					vLink = "location.href='" & arrEndList(7,intEndLoop) & "';"
				ELSE
					vLink = "GoToBrandShopevent_direct('" & arrEndList(5,intEndLoop) & "','" & arrEndList(0,intEndLoop) & "');"
				END IF
				vName = split(arrEndList(13,intEndLoop),"|")(0)
			Elseif arrEndList(4,intEndLoop) = "13" Then
				vLink = "TnGotoProduct('" & arrEndList(8,intEndLoop) & "');"
				vName = arrEndList(13,intEndLoop)
			Else
				IF arrEndList(6,intEndLoop) = "I" and arrEndList(7,intEndLoop) <> "" THEN '링크타입 체크
					vLink = "location.href='" & arrEndList(7,intEndLoop) & "';"
				ELSE
					vLink = "TnGotoEventMain('" & arrEndList(0,intEndLoop) & "');"
				END IF
				vName = arrEndList(13,intEndLoop)
			End IF

			If arrEndList(10,intEndLoop) = "" Then
				If arrEndList(11,intEndLoop) = "" Then
					vImg = "http://webimage.10x10.co.kr/image/basic/" & GetImageSubFolderByItemid(arrEndList(9,intEndLoop)) & "/" & arrEndList(12,intEndLoop)
				Else
					vImg = "http://webimage.10x10.co.kr/image/basic600/" & GetImageSubFolderByItemid(arrEndList(9,intEndLoop)) & "/" & arrEndList(11,intEndLoop)
				End IF
			Else
				vImg = arrEndList(10,intEndLoop)
			End If

			vImg = getThumbImgFromURL(vImg,200,200,"true","false")

			vIcon = ""
			If arrEndList(18,intEndLoop) Then
				vIcon = vIcon & "<img src=""http://fiximage.10x10.co.kr/web2013/shopping/tag_only.gif"" alt=""ONLY"" />"
			End IF
			If arrEndList(15,intEndLoop) Then
				vIcon = vIcon & "<img src=""http://fiximage.10x10.co.kr/web2013/shopping/tag_sale.gif"" alt=""SALE"" />"
			End IF
			If arrEndList(17,intEndLoop) Then
				vIcon = vIcon & "<img src=""http://fiximage.10x10.co.kr/web2013/shopping/tag_coupon.gif"" alt=""쿠폰"" />"
			End IF
			If arrEndList(19,intEndLoop) Then
				vIcon = vIcon & "<img src=""http://fiximage.10x10.co.kr/web2013/shopping/tag_oneplus.gif"" alt=""1+1"" />"
			End IF
			If arrEndList(16,intEndLoop) Then
				vIcon = vIcon & "<img src=""http://fiximage.10x10.co.kr/web2013/shopping/tag_gift.gif"" alt=""GIFT"" />"
			End IF
			If datediff("d",arrEndList(2,intEndLoop),date)<=3 Then
				vIcon = vIcon & "<img src=""http://fiximage.10x10.co.kr/web2013/shopping/tag_new.gif"" alt=""NEW"" />"
			End IF
			If arrEndList(22,intEndLoop) Then
				vIcon = vIcon & "<img src=""http://fiximage.10x10.co.kr/web2013/shopping/tag_involve.gif"" alt=""참여"" />"
			End IF
	strExpireMsg = strExpireMsg +"			<li>"
	strExpireMsg = strExpireMsg +"				<div class=""evtItem"">"
	strExpireMsg = strExpireMsg +"					<a href="""" onclick="""& vLink &" return false;"">"
	strExpireMsg = strExpireMsg +"						<div class=""pic""><img src="""& vImg &""" alt="""& replace(vName,"""","") &""" /></div>"
	strExpireMsg = strExpireMsg +"						<div class=""evtInfoWrap"">"
	strExpireMsg = strExpireMsg +"							<div class=""evtInfo"">"
	strExpireMsg = strExpireMsg +"								<p class=""pdtStTag"">"
	strExpireMsg = strExpireMsg +"									"&vIcon&""
	strExpireMsg = strExpireMsg +"								</p>"
	strExpireMsg = strExpireMsg +"								<p class=""evtTit"">"& Replace(chrbyte(db2html(vName),46,"Y"),"[☆2015 다이어리]","") &"</p>"
	strExpireMsg = strExpireMsg +"								<p class=""evtExp"">"& chrbyte(db2html(arrEndList(14,intEndLoop)),vLen(intEndLoop+1),"Y") &"</p>"
	strExpireMsg = strExpireMsg +"								<p class=""evtDate"">~"& FormatDate(arrEndList(3,intEndLoop),"0000.00.00") &"</p>"
	strExpireMsg = strExpireMsg +"							</div>"
	strExpireMsg = strExpireMsg +"						</div>"
	strExpireMsg = strExpireMsg +"					</a>"
	strExpireMsg = strExpireMsg +"				</div>"
	strExpireMsg = strExpireMsg +"			</li>"
		Next
	End If
	strExpireMsg = strExpireMsg +"		</ul>"
	strExpireMsg = strExpireMsg +"	</div>"
	strExpireMsg = strExpireMsg +"</div>"
%>