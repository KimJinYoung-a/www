<%
	on Error Resume Next
	Dim vLM_fileCont, vLM_sMainXmlUrl, vLM_oFile, vLM_xmlDOM, vLM_cSub, vLM_subNodes, vLM_Cate, vLM_i, vLM_Hot, vLM_Book, v3DepFirstChk, v3DepCnt
	vLM_fileCont = ""
	vLM_sMainXmlUrl = server.MapPath("/chtml/dispcate/menu/xml/cate_left_menu_new"&Left(vDisp,3)&".xml")
	Set vLM_oFile = CreateObject("ADODB.Stream")
	With vLM_oFile
		.Charset = "UTF-8"
		.Type=2
		.mode=3
		.Open
		.loadfromfile vLM_sMainXmlUrl
		vLM_fileCont=.readtext
		.Close
	End With
	Set vLM_oFile = Nothing

	If vLM_fileCont<>"" Then
		Set vLM_xmlDOM = Server.CreateObject("MSXML2.DomDocument.3.0")
		vLM_xmlDOM.async = False
		vLM_xmlDOM.LoadXML vLM_fileCont

		'// 하위 항목이 여러개일 때
		Set vLM_cSub = vLM_xmlDOM.getElementsByTagName("item")
		Set vLM_xmlDOM = Nothing
		
		Response.Write "<ul class=""lnbV15"">" & vbCrLf
		
		vLM_i = 0
		vLM_Hot = ""
		v3DepCnt = 0
		v3DepFirstChk = "x"
		For each vLM_subNodes in vLM_cSub

			If vLM_subNodes.getElementsByTagName("depth").item(0).text = "2" AND vLM_i <> 0 Then
				If v3DepCnt > 0 Then
				vLM_Cate = vLM_Cate & "									</ul>" & vbCrLf
				vLM_Cate = vLM_Cate & "									<span></span>" & vbCrLf
				vLM_Cate = vLM_Cate & "								</div>" & vbCrLf
				vLM_Cate = vLM_Cate & "							</div>" & vbCrLf
				End If
				vLM_Cate = vLM_Cate & "						</li>" & vbCrLf
			End If

			If vLM_subNodes.getElementsByTagName("depth").item(0).text = "2" Then
				vLM_Cate = vLM_Cate & "						<li " & CHKIIF(Left(CStr(vDisp),6)=Left(CStr(vLM_subNodes.getElementsByTagName("catecode").item(0).text),6),"class='selected'","") & ">" & vbCrLf
				
				If LCase(vLM_subNodes.getElementsByTagName("catename").item(0).text) = "book" Then
					vLM_Cate = vLM_Cate & "							<a href=""" & vLM_subNodes.getElementsByTagName("link").item(0).text & """><strong>" & vLM_subNodes.getElementsByTagName("catename").item(0).text & "</strong>"
				Else
					vLM_Cate = vLM_Cate & "							<a href=""" & vLM_subNodes.getElementsByTagName("link").item(0).text & """>" & vLM_subNodes.getElementsByTagName("catename").item(0).text & ""
				End If
				vLM_Cate = vLM_Cate & "<em class=""icoHot"" style=""display:none;"" id=""hotdisp"&vLM_subNodes.getElementsByTagName("catecode").item(0).text&"""><img src=""http://fiximage.10x10.co.kr/web2013/common/ico_hot.gif"" alt=""HOT"" /></em>"
				vLM_Cate = vLM_Cate & "</a>" & vbCrLf
				
				v3DepCnt = vLM_subNodes.getElementsByTagName("dep3exist").item(0).text
				v3DepFirstChk = "o"
			End If

			If vLM_subNodes.getElementsByTagName("depth").item(0).text = "3" Then
				If v3DepFirstChk = "o" Then
					vLM_Cate = vLM_Cate & "							<div class=""lnbLyrWrapV15"">" & vbCrLf
					vLM_Cate = vLM_Cate & "								<div>" & vbCrLf
					vLM_Cate = vLM_Cate & "									<ul class=""lnbSubV15"">" & vbCrLf
					
					v3DepFirstChk = "x"
				End If
				
				vLM_Cate = vLM_Cate & "									<li " & CHKIIF(Left(CStr(vDisp),9)=Left(CStr(vLM_subNodes.getElementsByTagName("catecode").item(0).text),9),"class='selected'","") & ">"
				vLM_Cate = vLM_Cate & "<a href=""" & vLM_subNodes.getElementsByTagName("link").item(0).text & """>" & vLM_subNodes.getElementsByTagName("catename").item(0).text & ""
				vLM_Cate = vLM_Cate & "<em class=""icoHot"" style=""display:none;"" id=""hotdisp"&vLM_subNodes.getElementsByTagName("catecode").item(0).text&"""><img src=""http://fiximage.10x10.co.kr/web2013/common/ico_hot.gif"" alt=""HOT"" /></em>"
				vLM_Cate = vLM_Cate & "</a>"
				vLM_Cate = vLM_Cate & "</li>" & vbCrLf
			End If
			
			'### HOT 카테고리
			If InStr((","&Application("comp_cate_hot")&","),(","&vLM_subNodes.getElementsByTagName("catecode").item(0).text&",")) > 0 Then
				vLM_Hot = vLM_Hot & "$('#hotdisp"&vLM_subNodes.getElementsByTagName("catecode").item(0).text&"').show();" & vbCrLf
			End IF

			vLM_i = vLM_i + 1
		Next

		If v3DepCnt > 0 Then
		vLM_Cate = vLM_Cate & "									</ul>" & vbCrLf
		vLM_Cate = vLM_Cate & "									<span></span>" & vbCrLf
		vLM_Cate = vLM_Cate & "								</div>" & vbCrLf
		vLM_Cate = vLM_Cate & "							</div>" & vbCrLf
		End IF
		vLM_Cate = vLM_Cate & "						</li>" & vbCrLf

		Set vLM_cSub = Nothing
		
		Response.Write vLM_Cate
%>
					</ul>
					<script>
					<%=vLM_Hot%>
					</script>
<%
		Set vLM_cSub = Nothing
	End If
	vLM_Cate = ""
	on Error Goto 0
%>