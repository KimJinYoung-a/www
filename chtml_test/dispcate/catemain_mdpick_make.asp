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
	'// 유입경로 확인
	Dim refip, objXML, vQuery, vTotalCountI, fso, vBody, i, vRealPrice, vSale, vClass
	Dim vCateCode, vGubun

	vCateCode = Request("dispcate")

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
	End IF
	'----------------------------------------------------------------------------------------------------------------------------------------
	vQuery = "SELECT Top 24 m.itemid, i.itemname, i.listimage120, i.sellcash, i.orgprice, i.sailyn, i.itemcouponyn, i.itemcouponvalue, i.itemcoupontype "
	vQuery = vQuery & " 	FROM [db_sitemaster].dbo.tbl_category_MDChoice as m "
	vQuery = vQuery & " INNER JOIN [db_item].dbo.tbl_item as i on m.itemid = i.itemid "
	vQuery = vQuery & " WHERE m.dispcate1 = '" & vCateCode & "' AND m.isusing = 'Y' "
	vQuery = vQuery & " ORDER BY m.sortno ASC, m.regdate desc "
	rsget.Open vQuery,dbget,1
	vTotalCountI = rsget.RecordCount
	
	If vTotalCountI < 24 Then
		rsget.close()
		Response.Write "<script>alert('MD Pick 상품 갯수는 24개 입니다!');window.close();</script>"
		dbget.close()
		Response.End
	End If

	i = 0
	vBody = ""
	Do Until rsget.Eof
	
		vRealPrice = fnRealPrice(rsget("orgprice"),rsget("sellcash"),rsget("sailyn"),rsget("itemcouponyn"),rsget("itemcouponvalue"),rsget("itemcoupontype"))
		vSale = Round(100-(100*(vRealPrice/rsget("orgprice"))))
		If rsget("sailyn") = "Y" AND rsget("itemcouponyn") = "Y" Then
			vClass = "cGr0V15"
		Else
			IF rsget("sailyn") = "Y" Then
				vClass = "cRd0V15"
			End IF
			IF rsget("itemcouponyn") = "Y" Then
				vClass = "cGr0V15"
			End IF
		End If

		If i = 0 OR i = 8 OR i = 16 Then
			If i = 8 OR i = 16 Then
				vBody = vBody & "</ul>" & vbCrLf
			End If
			vBody = vBody & "<ul class=""pdtList"">" & vbCrLf
		End If

		vBody = vBody & "	<li onclick=""location.href='/shopping/category_prd.asp?itemid="&rsget("itemid")&logparam&"';"">" & vbCrLf
		vBody = vBody & "		<a href=""/shopping/category_prd.asp?itemid="&rsget("itemid")&logparam&""">" & vbCrLf
		vBody = vBody & "		<p class=""pdtPhoto""><img src=""http://webimage.10x10.co.kr/image/List120/" & GetImageSubFolderByItemid(rsget("itemid")) & "/" & rsget("listimage120") & """ alt=""" & Replace(db2html(rsget("itemname")),chr(34),"") & """ style=""width:120px; height:120px;"" /></p>" & vbCrLf
		vBody = vBody & "		<p class=""pdtName tPad07"">" & db2html(rsget("itemname")) & "</p>" & vbCrLf
		vBody = vBody & "		<p class=""pdtPrice""><strong>" & FormatNumber(vRealPrice,0) & "원"
		
		If vSale > 0 Then
			vBody = vBody & " <span class=""" & vClass & """>[" & vSale & "%]</span>"
		End IF
		
		vBody = vBody & "</strong></p>" & vbCrLf
		vBody = vBody & "		</a>" & vbCrLf
		vBody = vBody & "	</li>" & vbCrLf
		
		i = i + 1
	rsget.MoveNext
	Loop
	rsget.close

	vBody = vBody & "</ul>" & vbCrLf

    if (vBody<>"") then
		Set fso = Server.CreateObject("ADODB.Stream")
		fso.Type = 2
		fso.Charset = "utf-8"
		fso.Open
		fso.WriteText (vBody)
		fso.SaveToFile server.mappath("/chtml/dispcate/main/") & "\"&"catemain_mdpick_"&vCateCode&".html", 2
		Set fso = nothing
    end if
	
	
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