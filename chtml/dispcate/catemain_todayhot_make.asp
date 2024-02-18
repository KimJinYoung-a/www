<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<%
	Dim vQuery, vCateCode, vBody, mx, my, vTotalCount, vSale, vRealPrice, vClass
	vCateCode = Request("catecode")

	'//logparam
	Dim logparam : logparam = "&pCtr="&vCateCode
	
	If vCateCode = "" Then
		Response.Write "<script>alert('잘못된 접근임!');window.close();</script>"
		dbget.close()
		Response.End
	End IF
	
	If isNumeric(vCateCode) = False Then
		Response.Write "<script>alert('잘못된 접근임!');window.close();</script>"
		dbget.close()
		Response.End
	End If

	'// amplitude용 카테고리 이름
	Dim vCateName : vCateName = fnFindToCateName(vCateCode)

	'----------------------------------------------------------------------------------------------------------------------------------------
	'### sale 체크 : 페이지를 읽는게 아니고 관리자가 만드는거라 등급체크 못하여 그냥 sailyn 값만 체크함.
	vQuery = "SELECT TOP 6 m.itemid, i.itemname, i.icon1image, i.sellcash, i.orgprice, i.sailyn, i.itemcouponyn, i.itemcouponvalue, i.itemcoupontype, c.SocName as BrandName "
	vQuery = vQuery & " 	FROM [db_sitemaster].[dbo].tbl_category_mainItem as m "
	vQuery = vQuery & " INNER JOIN db_item.dbo.tbl_item as i ON m.itemid = i.itemid "
	vQuery = vQuery & " LEFT JOIN [db_user].[dbo].tbl_user_c as c ON (Case When isNull(i.frontMakerid,'')='' then i.makerid else i.frontMakerid end)= c.userid "
	vQuery = vQuery & " WHERE m.disp = '" & vCateCode & "' AND m.isusing = 'Y' "
	vQuery = vQuery & " ORDER BY m.sortno asc, m.idx desc"
	rsget.Open vQuery,dbget,1
	vTotalCount = rsget.RecordCount
	
	If CStr(vTotalCount) <> "4" AND  CStr(vTotalCount) <> "5" AND CStr(vTotalCount) <> "6" Then
		rsget.close
		Response.Write "<script>alert('Today`s Hot 에 올릴 상품은 4~6개가 되어야합니다.');window.close();</script>"
		dbget.close()
		Response.End
	End If

	Dim i : i = 1
	
	IF Not rsget.Eof Then
		vBody = ""
		Do Until rsget.Eof
		
			vRealPrice = fnRealPrice(rsget("orgprice"),rsget("sellcash"),rsget("sailyn"),rsget("itemcouponyn"),rsget("itemcouponvalue"),rsget("itemcoupontype"))
			vSale = Round(100-(100*(vRealPrice/rsget("orgprice"))))
			If rsget("sailyn") = "Y" AND rsget("itemcouponyn") = "Y" Then
				vClass = " couponTag"
			Else
				IF rsget("sailyn") = "Y" Then
					vClass = " saleTag"
				End IF
				IF rsget("itemcouponyn") = "Y" Then
					vClass = " couponTag"
				End IF
			End If
			
				vBody = vBody & "		<div> " & vbCrLf
				vBody = vBody & "			<a href='/shopping/category_prd.asp?itemid="&rsget("itemid")& logparam & CateMain_GaParam(vCateCode,"todayhot",i) &"' onclick=""fnAmplitudeEventMultiPropertiesAction('click_category_main_todayshot','indexnumber|itemid|categoryname|brand_name','"& i &"|"& rsget("itemid") &"|"& vCateName &"|"& rsget("BrandName") &"');""> " & vbCrLf
				vBody = vBody & "				<p class='todayPhoto " & vClass & "'> " & vbCrLf
			If vSale > 0 Then
				mx = (vSale-1) mod 10
				my = fix((vSale-1)/10)
				vBody = vBody & "					<span style='background-position:" & mx*-40 & "px " & my*-40 & "px;'></span> " & vbCrLf
			End If
				vBody = vBody & "					<img src='http://webimage.10x10.co.kr/image/icon1/" & GetImageSubFolderByItemid(rsget("itemid")) & "/" & rsget("icon1image") & "' alt='" & Replace(db2html(rsget("itemname")),chr(34),"") & "' /> " & vbCrLf
				vBody = vBody & "				</p> " & vbCrLf
				vBody = vBody & "				<p class='pdtBrand'>"&db2html(rsget("BrandName"))&"</p> " & vbCrLf
				vBody = vBody & "				<p class='pdtName tPad07'>" & db2html(rsget("itemname")) & "</p> " & vbCrLf
				vBody = vBody & "				<p class='pdtPrice tPad10'><strong>" & FormatNumber(vRealPrice,0) & "원</strong></p> " & vbCrLf
				vBody = vBody & "			</a> " & vbCrLf
				vBody = vBody & "		</div> " & vbCrLf
	
				vClass = ""
		i = i + 1
		rsget.MoveNext
		Loop
		
		vBody = vBody & "" & vbCrLf
		
	    if (vBody<>"") then
	    	Dim tFile, fso
			Set fso = Server.CreateObject("ADODB.Stream")
			fso.Type = 2
			fso.Charset = "utf-8"
			fso.Open
			fso.WriteText (vBody)
			fso.SaveToFile server.mappath("/chtml/dispcate/main/") & "\"&"catemain_todayhot_"&vCateCode&".html", 2
			Set fso = nothing
	    end if
	End If
	rsget.close


Function fnRealPrice(orgprice, sellcash, sailyn, itemcouponyn, itemcouponvalue, itemcoupontype)
	Dim vPrice
	vPrice = orgprice
	IF sailyn = "Y" AND itemcouponyn = "Y" Then
		vPrice = sellcash
		vPrice = GetCouponAssignPrice(vPrice,itemcouponyn,itemcouponvalue,itemcoupontype)
	Else
		If sailyn = "Y" Then
			vPrice = sellcash
		End If
		If itemcouponyn = "Y" Then
			vPrice = GetCouponAssignPrice(vPrice,itemcouponyn,itemcouponvalue,itemcoupontype)
		End If
	End If
	fnRealPrice = vPrice
End Function

    
'vSale = getSalePercent(rsget("orgprice"),rsget("sellcash"),rsget("sailyn"),rsget("itemcouponyn"),rsget("itemcouponvalue"),rsget("itemcoupontype"))
'// 상품/쿠폰 할인율
Function getSalePercent(org,sell,sailyn,couponyn,cvalue,ctype)
	dim sSprc, sPer
	sSprc=0 : sPer=0

	if org>0 then
		if sailyn="Y" then sSprc = sSprc + org-sell
		if couponyn="Y" then sSprc = sSprc + org-GetCouponAssignPrice(sell,couponyn,cvalue,ctype)
		sPer = CLng(sSprc/org*100)
	end if
	
	getSalePercent = sPer
End Function

'// 쿠폰 적용가
Function GetCouponAssignPrice(sell,couponyn,cvalue,ctype)
	if (couponyn="Y") then
		GetCouponAssignPrice = sell - GetCouponDiscountPrice(sell,cvalue,ctype)
	else
		GetCouponAssignPrice = sell
	end if
End Function

'// 쿠폰 할인가 '?
Function GetCouponDiscountPrice(sell,cvalue,ctype) 
	Select case ctype
		case "1" ''% 쿠폰
			GetCouponDiscountPrice = CLng(cvalue*sell/100)
		case "2" ''원 쿠폰
			GetCouponDiscountPrice = cvalue
		case "3" ''무료배송 쿠폰
		    GetCouponDiscountPrice = 0
		case else
			GetCouponDiscountPrice = 0
	end Select

End Function
%>
<script>alert("적용완료!");window.close();</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->