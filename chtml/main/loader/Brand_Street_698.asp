<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
'###########################################################
' Description :  메인페이지 브랜드 스트리트
' History : 2015.04.08 원승현 생성
'###########################################################
%>
<!-- #include virtual="/lib/util/commlib.asp" -->
<%
Dim sMainXmlUrl, oFile, fileCont, xmlDOM
Dim sFolder, mainFile, i, CtrlDate, existscnt, needcnt, idx, posname, existsidx
Dim image, image2, link, linktext, linktext2, startdate, enddate, linktext3
	sFolder = "/chtml/xml/"
	mainFile = "mainXMLBanner_698.xml"

	CtrlDate = Date()
	'CtrlDate = Cdate("2015-03-30")

	existscnt = 0
	needcnt = 0

'// 메인페이지를 구성하는 XML로딩 (파일직접로딩)
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

If fileCont<>"" Then
	Response.Write "<ul class='brandListV15'>"
	
	'// XML 파싱
	Set xmlDOM = Server.CreateObject("MSXML2.DomDocument.3.0")
		xmlDOM.async = False
		xmlDOM.LoadXML fileCont
		'// 하위 항목이 여러개일 때
		Dim cTmpl, tplNodes, cSub, subNodes
		Set cTmpl = xmlDOM.getElementsByTagName("item")
	Set xmlDOM = Nothing

	i = 0
	For each tplNodes in cTmpl

		if i>8 then exit for	'//최대 9개까지 제한

		'변수 저장
		image		= tplNodes.getElementsByTagName("image").item(0).text				'BG Image
		image2		= tplNodes.getElementsByTagName("image2").item(0).text				'Text Image
		link		= tplNodes.getElementsByTagName("link").item(0).text				'Link URL
		linktext	= tplNodes.getElementsByTagName("linktext").item(0).text			'BG Color
		linktext2	= tplNodes.getElementsByTagName("linktext2").item(0).text			'Logo Type
		linktext3	= tplNodes.getElementsByTagName("linktext3").item(0).text			'Logo Type
		startdate	= CDate(replace(tplNodes.getElementsByTagName("startdate").item(0).text, ",", "-"))
		enddate		= CDate(replace(tplNodes.getElementsByTagName("enddate").item(0).text, ",", "-"))
		idx		= tplNodes.getElementsByTagName("idx").item(0).text
		posname		= tplNodes.getElementsByTagName("posname").item(0).text

		If CtrlDate >= startdate AND CtrlDate <= enddate Then

			If InStr(link,"?") Then 
				response.write "<li><a href=""" & CStr(link) & "&gaparam=main_street_"&i+1&"""><p class='imgOverV15'><img src=""" & CStr(image) & """ alt=""" & posname & """  /></p></a></li>"
			Else
				response.write "<li><a href=""" & CStr(link) & "?gaparam=main_street_"&i+1&"""><p class='imgOverV15'><img src=""" & CStr(image) & """ alt=""" & posname & """  /></p></a></li>"
			End If

			If (i+1) Mod 3 = 0 Then
				If (i+1)<9 Then
					response.write "</ul><ul class='brandListV15'>"
				End If
			End If
			existsidx = existsidx + idx + ","		'/등록된 이미지의 IDX를 저장

			i = i + 1
		End If
	Next

	existscnt = ubound(split(existsidx,","))	'//위에서 등록된 이미지수
	needcnt = 1-existscnt		'//모자란 이미지수(최소 1개)

	i = 0
	'//만약 등록을 안했을경우 종료 이전꺼를 가져옴
	For each tplNodes in cTmpl

		if i>=needcnt then exit for	'//모자란 이미지수 만큼만 뿌린다

		'변수 저장
		image		= tplNodes.getElementsByTagName("image").item(0).text				'BG Image
		image2		= tplNodes.getElementsByTagName("image2").item(0).text				'Text Image
		link		= tplNodes.getElementsByTagName("link").item(0).text				'Link URL
		linktext	= tplNodes.getElementsByTagName("linktext").item(0).text			'BG Color
		linktext2	= tplNodes.getElementsByTagName("linktext2").item(0).text			'Logo Type
		linktext3	= tplNodes.getElementsByTagName("linktext3").item(0).text			'Logo Type
		startdate	= CDate(replace(tplNodes.getElementsByTagName("startdate").item(0).text, ",", "-"))
		enddate		= CDate(replace(tplNodes.getElementsByTagName("enddate").item(0).text, ",", "-"))
		idx		= tplNodes.getElementsByTagName("idx").item(0).text
		posname		= tplNodes.getElementsByTagName("posname").item(0).text

		'//종료 인것중에, 위에서 노출시킨거 빼고 뿌린다
		If CtrlDate >= startdate AND instr(existsidx,idx)=0 Then

			If InStr(link,"?") Then 
				response.write "<li><a href=""" & CStr(link) & "&gaparam=main_street_"&i+1&"""><p class='imgOverV15'><img src=""" & CStr(image) & """ alt=""" & posname & """  /></p></a></li>"
			Else
				response.write "<li><a href=""" & CStr(link) & "?gaparam=main_street_"&i+1&"""><p class='imgOverV15'><img src=""" & CStr(image) & """ alt=""" & posname & """  /></p></a></li>"
			End If
			If (i+1) Mod 3 = 0 Then
				If (i+1)<9 Then
					response.write "</ul><ul class='brandListV15'>"
				End If
			End If

			i = i + 1
			existscnt = existscnt + 1
		End If
	Next

	Set cTmpl = Nothing

	Response.Write "</ul>"
End If
%>
