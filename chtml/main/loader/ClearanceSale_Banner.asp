<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<!-- #include virtual="/lib/util/commlib.asp" -->
<%
'// 변수 선언
	Dim sMainXmlUrl, oFile, fileCont, xmlDOM
	Dim sFolder, mainFile, i
	Dim evt_code, evt_name, evt_type, bannerImg, typetext, typealt, evt_comment
	dim itemid, itemname, limitno, limitsold, makerid, brandname, listimage, listimage120, basicimage
	dim orgprice, sellcash, getSalePro, LimitedLowStock, sailper

	sFolder = "/chtml/xml/"
	mainFile = "mainXMLBanner_clearancesale.xml"

	'// 메인페이지를 구성하는 XML로딩 (파일직접로딩)
	on Error Resume Next
	sMainXmlUrl = server.MapPath(sFolder & mainFile)	'// 접수 파일
	Set oFile = CreateObject("ADODB.Stream")
	With oFile
		.Charset = "UTF-8"
		.Type=2
		.mode=3
		.Open
		.loadfromfile sMainXmlUrl
		fileCont=.readtext
		.Close
	End With
	Set oFile = Nothing
	on Error Goto 0

	If fileCont<>"" Then
		'// XML 파싱
		Set xmlDOM = Server.CreateObject("MSXML2.DomDocument.3.0")
			xmlDOM.async = False
			xmlDOM.LoadXML fileCont
			'// 하위 항목이 여러개일 때
			Dim cTmpl, tplNodes, cSub, subNodes, tmpOrder
			Set cTmpl = xmlDOM.getElementsByTagName("item")
		Set xmlDOM = Nothing
		tmpOrder = 1
	
		i = 1
		For each tplNodes in cTmpl
			'변수 저장
			itemid		= tplNodes.getElementsByTagName("itemid").item(0).text
			itemname		= tplNodes.getElementsByTagName("itemname").item(0).text
			limitno		= tplNodes.getElementsByTagName("limitno").item(0).text
			limitsold		= tplNodes.getElementsByTagName("limitsold").item(0).text
			makerid			= tplNodes.getElementsByTagName("makerid").item(0).text
			brandname		= tplNodes.getElementsByTagName("brandname").item(0).text
			listimage		= tplNodes.getElementsByTagName("listimage").item(0).text
			listimage120		= tplNodes.getElementsByTagName("listimage120").item(0).text
			basicimage		= tplNodes.getElementsByTagName("basicimage").item(0).text
			orgprice		= tplNodes.getElementsByTagName("orgprice").item(0).text
			sellcash		= tplNodes.getElementsByTagName("sellcash").item(0).text
			LimitedLowStock = tplNodes.getElementsByTagName("LimitedLowStock").item(0).text
			sailper 		= tplNodes.getElementsByTagName("sailper").item(0).text

			if sailper < 1 then
				sailper = ""
			else
				sailper = ""&sailper &"%"
			end if

			If i = 1 Then
%>
				<div class="pdt180V15">
					<ul class="pdtList">
<%
			End If
%>
						<li>
							<div class="pdtBox">
								<strong class="pdtLabel"><em><%= LimitedLowStock %></em>개 한정</strong>
								<div class="pdtPhoto">
									<span class="soldOutMask"></span>
									<a href="/shopping/category_prd.asp?itemid=<%=itemid%>&gaparam=main_clearance"><img src="<%=basicimage%>" alt="<%= itemname %>" /></a>
								</div>
								<div class="pdtInfo">
									<p class="pdtBrand"><a href="/street/street_brand_sub06.asp?makerid=<%=makerid%>&gaparam=main_clearance"><%=brandname%></a></p>
									<p class="pdtName tPad05"><a href="/shopping/category_prd.asp?itemid=<%=itemid%>"><%= itemname %></a>
										<span class="tagSale"><%= sailper %></span>
									</p>
								</div>
							</div>
						</li>
<%
			If i mod 5 = 0 Then
				If i < 15 Then
%>
					</ul>
				</div>
				<div class="pdt180V15">
					<ul class="pdtList">
<%
				Else
%>
					</ul>
				</div>
<%
				End If
			End If
			i = i + 1
		Next
		Set cTmpl = Nothing
	End If
%>
