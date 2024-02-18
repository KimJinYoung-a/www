<%
	on Error Resume Next
	Dim vBLM_fileCont, vBLM_sMainXmlUrl, vBLM_oFile, vBLM_xmlDOM, vBLM_cSub, vBLM_subNodes, vBLM_Cate, vBLM_i, vBLM_Hot, vBLM_Book, vB3DepFirstChk, vB3DepCnt
	vBLM_fileCont = ""
	vBLM_sMainXmlUrl = server.MapPath("/chtml/dispcate/menu/xml/cate_left_book_menu.xml")
	Set vBLM_oFile = CreateObject("ADODB.Stream")
	With vBLM_oFile
		.Charset = "UTF-8"
		.Type=2
		.mode=3
		.Open
		.loadfromfile vBLM_sMainXmlUrl
		vBLM_fileCont=.readtext
		.Close
	End With
	Set vBLM_oFile = Nothing

	If vBLM_fileCont<>"" Then
		Set vBLM_xmlDOM = Server.CreateObject("MSXML2.DomDocument.3.0")
		vBLM_xmlDOM.async = False
		vBLM_xmlDOM.LoadXML vBLM_fileCont

		'// 하위 항목이 여러개일 때
		Set vBLM_cSub = vBLM_xmlDOM.getElementsByTagName("item")
		Set vBLM_xmlDOM = Nothing
		
		Response.Write "<ul class=""lnbV15"">" & vbCrLf
		
		vBLM_i = 0
		vBLM_Hot = ""
		vB3DepCnt = 0
		vB3DepFirstChk = "x"
		For each vBLM_subNodes in vBLM_cSub

			If vBLM_subNodes.getElementsByTagName("depth").item(0).text = "1" AND vBLM_i <> 0 Then
				If vB3DepCnt > 0 Then
				vBLM_Cate = vBLM_Cate & "									</ul>" & vbCrLf
				vBLM_Cate = vBLM_Cate & "									<span></span>" & vbCrLf
				vBLM_Cate = vBLM_Cate & "								</div>" & vbCrLf
				vBLM_Cate = vBLM_Cate & "							</div>" & vbCrLf
				End If
				
				If vBLM_subNodes.getElementsByTagName("catename").item(0).text <> "클리어런스" Then
					vBLM_Cate = vBLM_Cate & "						</li>" & vbCrLf
				End If
			End If

			If vBLM_subNodes.getElementsByTagName("catename").item(0).text <> "클리어런스" Then
				If vBLM_subNodes.getElementsByTagName("depth").item(0).text = "1" Then
					vBLM_Cate = vBLM_Cate & "						<li " & CHKIIF(Left(CStr(vDisp),6)=Left(CStr(vBLM_subNodes.getElementsByTagName("catecode").item(0).text),6),"class='selected'","") & ">" & vbCrLf
					
					If LCase(vBLM_subNodes.getElementsByTagName("catename").item(0).text) = "book" Then
						vBLM_Cate = vBLM_Cate & "							<a href=""" & vBLM_subNodes.getElementsByTagName("link").item(0).text & """><strong>" & vBLM_subNodes.getElementsByTagName("catename").item(0).text & "</strong>"
					Else
						vBLM_Cate = vBLM_Cate & "							<a href=""" & vBLM_subNodes.getElementsByTagName("link").item(0).text & """>" & vBLM_subNodes.getElementsByTagName("catename").item(0).text & ""
					End If
					vBLM_Cate = vBLM_Cate & "<em class=""icoHot"" style=""display:none;"" id=""hotdisp"&vBLM_subNodes.getElementsByTagName("catecode").item(0).text&"""><img src=""http://fiximage.10x10.co.kr/web2013/common/ico_hot.gif"" alt=""HOT"" /></em>"
					vBLM_Cate = vBLM_Cate & "</a>" & vbCrLf
					
					vB3DepCnt = vBLM_subNodes.getElementsByTagName("dep3exist").item(0).text
					vB3DepFirstChk = "o"
				End If
			End If

			If vBLM_subNodes.getElementsByTagName("depth").item(0).text = "3" Then
				If vB3DepFirstChk = "o" Then
					vBLM_Cate = vBLM_Cate & "							<div class=""lnbLyrWrapV15"">" & vbCrLf
					vBLM_Cate = vBLM_Cate & "								<div>" & vbCrLf
					vBLM_Cate = vBLM_Cate & "									<ul class=""lnbSubV15"">" & vbCrLf
					
					vB3DepFirstChk = "x"
				End If
				
				vBLM_Cate = vBLM_Cate & "									<li " & CHKIIF(Left(CStr(vDisp),9)=Left(CStr(vBLM_subNodes.getElementsByTagName("catecode").item(0).text),9),"class='selected'","") & ">"
				vBLM_Cate = vBLM_Cate & "<a href=""" & vBLM_subNodes.getElementsByTagName("link").item(0).text & """>" & vBLM_subNodes.getElementsByTagName("catename").item(0).text & ""
				vBLM_Cate = vBLM_Cate & "<em class=""icoHot"" style=""display:none;"" id=""hotdisp"&vBLM_subNodes.getElementsByTagName("catecode").item(0).text&"""><img src=""http://fiximage.10x10.co.kr/web2013/common/ico_hot.gif"" alt=""HOT"" /></em>"
				vBLM_Cate = vBLM_Cate & "</a>"
				vBLM_Cate = vBLM_Cate & "</li>" & vbCrLf
			End If
			
			'### HOT 카테고리
			If InStr((","&Application("comp_cate_hot")&","),(","&vBLM_subNodes.getElementsByTagName("catecode").item(0).text&",")) > 0 Then
				vBLM_Hot = vBLM_Hot & "$('#hotdisp"&vBLM_subNodes.getElementsByTagName("catecode").item(0).text&"').show();" & vbCrLf
			End IF

			vBLM_i = vBLM_i + 1
		Next

		If vB3DepCnt > 0 Then
		vBLM_Cate = vBLM_Cate & "									</ul>" & vbCrLf
		vBLM_Cate = vBLM_Cate & "									<span></span>" & vbCrLf
		vBLM_Cate = vBLM_Cate & "								</div>" & vbCrLf
		vBLM_Cate = vBLM_Cate & "							</div>" & vbCrLf
		End IF
		vBLM_Cate = vBLM_Cate & "						</li>" & vbCrLf

		Set vBLM_cSub = Nothing
		
		Response.Write vBLM_Cate
%>
					</ul>
					<script>
					<%=vBLM_Hot%>
					</script>
<%
		Set vBLM_cSub = Nothing
	End If
	vBLM_Cate = ""
	on Error Goto 0
%>