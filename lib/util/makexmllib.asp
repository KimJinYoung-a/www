<%

Function MakeXmlFile(gubuncode)
	'// TODO : dbopen.asp, commlib.asp 이 include 되어 있다고 가정함.
	Dim oKeyArr, i, j, cnt
	Dim sqlStr, vTotalCount, BufStr, outputFileName

	sqlStr = ""
	Select Case gubuncode
		Case "mainPopularWish"
			'// ----------------------------------------------------------------
			sqlStr = "exec db_const.dbo.sp_Ten_awardItemList_2013 10, 'f', '', '', 0 "
			outputFileName = "mainPopularWish.xml"
		Case "mainBestAward"
			'// ----------------------------------------------------------------
			sqlStr = "exec db_const.dbo.sp_Ten_awardItemList_2013 10, 'b', '', '', 0 "
			outputFileName = "mainBestAward.xml"
		Case Else
			'// ----------------------------------------------------------------
			'// 없음
	End Select

	if (sqlStr = "") then
		exit Function
	end if

	'response.write sqlStr
	rsget.CursorLocation = adUseClient
	rsget.CursorType = adOpenStatic
	rsget.LockType = adLockOptimistic
	rsget.Open sqlStr,dbget,1

	vTotalCount = rsget.RecordCount

	if (vTotalCount < 1) then
		rsget.Close
		exit Function
	end if

	BufStr = ""
	if  not rsget.EOF  then

		BufStr = "<?xml version=""1.0"" ?>" & VbCrlf
		BufStr = BufStr & "<list>" & VbCrlf
		For i = 0 To CInt(vTotalCount) - 1
			BufStr = BufStr & "<item>" & VbCrlf

			'// TODO : 날짜에서 마이너스문자(-) 는 제거해주어야 한다. 2014-01-01 => 2014,01,01
			Select Case gubuncode
				Case "mainPopularWish"
					'// --------------------------------------------------------
					BufStr = BufStr & "<link><![CDATA[" & "/shopping/category_prd.asp?itemid=" & rsget("itemid") & "]]></link>" & VbCrlf
					BufStr = BufStr & "<image><![CDATA[" & "http://webimage.10x10.co.kr/image/Icon1/" + GetImageSubFolderByItemid(rsget("itemid")) + "/" + rsget("icon1image") & "]]></image>" & VbCrlf
					BufStr = BufStr & "<showtext><![CDATA[" & db2Html(rsget("itemname")) & "]]></showtext>" & VbCrlf
					BufStr = BufStr & "<linktext><![CDATA[" & db2Html(rsget("itemname")) & "]]></linktext>" & VbCrlf

					'// 할인%
					BufStr = BufStr & "<addValue><![CDATA[" & Round(100-(100*(fnRealPrice_XML(rsget("orgprice"), rsget("sellcash"), rsget("sailyn"), rsget("itemcouponyn"), rsget("itemcouponvalue"), rsget("itemcoupontype")) / rsget("orgprice")))) & "]]></addValue>" & VbCrlf

					'// 위시카운트
					BufStr = BufStr & "<addValue1><![CDATA[" & rsget("favcount") & "]]></addValue1>" & VbCrlf
				Case "mainBestAward"
					'// --------------------------------------------------------
					BufStr = BufStr & "<link><![CDATA[" & "/shopping/category_prd.asp?itemid=" & rsget("itemid") & "]]></link>" & VbCrlf
					if (i < 2) then
						'// 200X200 이미지, XML 불러들일때 160X160 섬네일을 생성한다.
						''getThumbImgFromURL(이미지파일경로,넓이,높이,"true","false")
						BufStr = BufStr & "<image><![CDATA[" & "http://webimage.10x10.co.kr/image/Icon1/" + GetImageSubFolderByItemid(rsget("itemid")) + "/" + rsget("icon1image") & "]]></image>" & VbCrlf
					else
						BufStr = BufStr & "<image><![CDATA[" & "http://webimage.10x10.co.kr/image/Icon1/" + GetImageSubFolderByItemid(rsget("itemid")) + "/" + rsget("icon1image") & "]]></image>" & VbCrlf
					end if

					BufStr = BufStr & "<showtext><![CDATA[" & db2Html(rsget("itemname")) & "]]></showtext>" & VbCrlf
					BufStr = BufStr & "<linktext><![CDATA[" & db2Html(rsget("itemname")) & "]]></linktext>" & VbCrlf

					'// 할인%
					BufStr = BufStr & "<addValue><![CDATA[" & Round(100-(100*(fnRealPrice_XML(rsget("orgprice"), rsget("sellcash"), rsget("sailyn"), rsget("itemcouponyn"), rsget("itemcouponvalue"), rsget("itemcoupontype")) / rsget("orgprice")))) & "]]></addValue>" & VbCrlf
				Case Else
					'// 없음
			End Select

			BufStr = BufStr & "</item>" & VbCrlf
			rsget.MoveNext
		Next
		BufStr = BufStr & "</list>" & VbCrlf

	end if

	rsget.Close

	Dim savePath, fso, tFile
	savePath = server.mappath("/chtml/xml/") + "/"

	Set fso = Server.CreateObject("ADODB.Stream")
		fso.Type = 2
		fso.Charset = "utf-8"
		fso.Open
		fso.WriteText (BufStr)
		fso.SaveToFile savePath & "\"&outputFileName, 2
	Set fso = nothing

end Function

Function fnRealPrice_XML(orgprice, sellcash, sailyn, itemcouponyn, itemcouponvalue, itemcoupontype)
	Dim vPrice
	vPrice = orgprice
	IF sailyn = "Y" AND itemcouponyn = "Y" Then
		vPrice = sellcash
		vPrice = GetCouponAssignPrice_XML(vPrice,itemcouponyn,itemcouponvalue,itemcoupontype)
	Else
		If sailyn = "Y" Then
			vPrice = sellcash
		End If
		If itemcouponyn = "Y" Then
			vPrice = GetCouponAssignPrice_XML(vPrice,itemcouponyn,itemcouponvalue,itemcoupontype)
		End If
	End If
	fnRealPrice_XML = vPrice
End Function

Function getSalePercent_XML(org,sell,sailyn,couponyn,cvalue,ctype)
	dim sSprc, sPer
	sSprc=0 : sPer=0

	if org>0 then
		if sailyn="Y" then sSprc = sSprc + org-sell
		if couponyn="Y" then sSprc = sSprc + org-GetCouponAssignPrice_XML(sell,couponyn,cvalue,ctype)
		sPer = CLng(sSprc/org*100)
	end if

	getSalePercent_XML = sPer
End Function

'// 쿠폰 적용가
Function GetCouponAssignPrice_XML(sell,couponyn,cvalue,ctype)
	if (couponyn="Y") then
		GetCouponAssignPrice_XML = sell - GetCouponDiscountPrice_XML(sell,cvalue,ctype)
	else
		GetCouponAssignPrice_XML = sell
	end if
End Function

'// 쿠폰 할인가 '?
Function GetCouponDiscountPrice_XML(sell,cvalue,ctype)
	Select case ctype
		case "1" ''% 쿠폰
			GetCouponDiscountPrice_XML = CLng(cvalue*sell/100)
		case "2" ''원 쿠폰
			GetCouponDiscountPrice_XML = cvalue
		case "3" ''무료배송 쿠폰
		    GetCouponDiscountPrice_XML = 0
		case else
			GetCouponDiscountPrice_XML = 0
	end Select

End Function

%>
