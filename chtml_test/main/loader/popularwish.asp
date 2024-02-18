<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
	dim vRstCont, vXmlUrl, xmlDOM
	dim oFile, cSub, subNodes
	dim vItem(3), lp, i
	dim mx, my, si, j

	on Error Resume Next
	vRstCont = ""
	vXmlUrl = server.MapPath("/chtml/xml/mainPopularWish.xml")
	Set oFile = CreateObject("ADODB.Stream")
	With oFile
		.Charset = "UTF-8"
		.Type=2
		.mode=3
		.Open
		.loadfromfile vXmlUrl
		vRstCont=.readtext
		.Close
	End With
	Set oFile = Nothing

	If vRstCont<>"" Then
		Set xmlDOM = Server.CreateObject("MSXML2.DomDocument.3.0")
		xmlDOM.async = False
		xmlDOM.LoadXML vRstCont

		'// 하위 항목이 여러개일 때
		Set cSub = xmlDOM.getElementsByTagName("item")
		Set xmlDOM = Nothing

		lp = 0: i=0 : j=0
		For each subNodes in cSub
			If j < 9 Then
				si = "0"&j+1
			Else
				si = j+1
			End If

			if subNodes.getElementsByTagName("addValue").item(0).text>0 Then
				'// 할인율 표시 : 각 할인율이 증가할때마다 left값이 -50px 추가되게 해주세요, 11%부터는 10단위로 top값이 -50px 추가됨
				mx = (subNodes.getElementsByTagName("addValue").item(0).text-1) mod 10
				my = fix((subNodes.getElementsByTagName("addValue").item(0).text-1)/10)
				vItem(lp) = vItem(lp) & "<li class=""best"&si&" saleTag"">" & vbCrLf
				If InStr(link,"?") Then 
					vItem(lp) = vItem(lp) & "<a href="""&subNodes.getElementsByTagName("link").item(0).text&"&gaparam=main_wish_"&si&""">" & vbCrLf
				Else
					vItem(lp) = vItem(lp) & "<a href="""&subNodes.getElementsByTagName("link").item(0).text&"&gaparam=main_wish_"&si&""">" & vbCrLf
				End If
				vItem(lp) = vItem(lp) & "										<em style=""background-position:" & mx*-50 & "px " & my*-50 & "px;""></em>" & vbCrLf
			else
				vItem(lp) = vItem(lp) & "<li class=""best"&si&""">" & vbCrLf
				If InStr(link,"?") Then 
					vItem(lp) = vItem(lp) & "<a href="""&subNodes.getElementsByTagName("link").item(0).text&"&gaparam=main_wish_"&si&""">" & vbCrLf
				Else
					vItem(lp) = vItem(lp) & "<a href="""&subNodes.getElementsByTagName("link").item(0).text&"&gaparam=main_wish_"&si&""">" & vbCrLf
				End If
				vItem(lp) = vItem(lp) & "										<em></em>" & vbCrLf
			end if
			vItem(lp) = vItem(lp) & "										<p class='mdWishNumV15'><dfn>"&subNodes.getElementsByTagName("addValue1").item(0).text&"</dfn></p>" & vbCrLf
			vItem(lp) = vItem(lp) & "										<p class=""mdTxt"">" & subNodes.getElementsByTagName("showtext").item(0).text & "</p>" & vbCrLf
			vItem(lp) = vItem(lp) & "										<span class=""mdPhoto""><img src=""" & subNodes.getElementsByTagName("image").item(0).text & """ alt=""" & replace(subNodes.getElementsByTagName("image").item(0).text,"""","") & """ /></span>" & vbCrLf
			vItem(lp) = vItem(lp) & "									</a></li>" & vbCrLf & "									"

			i = i + 1
			j = j + 1
			if (i mod 10)=0 then
				lp = lp+1
			end If
		Next

		Set cSub = Nothing
%>
				<div>
					<h2><img src="http://fiximage.10x10.co.kr/web2015/main/tit_popularwish.png" alt="POPULAR WISH" /></h2>
					<ul class="mdListV15 wishMdV15">
						<%=vItem(0)%>
					</ul>
				</div>

<%
	End If

	on Error Goto 0
%>
