<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
'###########################################################
' Description :  메인 페이지 멀티배너
' History : 2015.04.07 원승현 생성
'###########################################################
%>
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<%
Dim sMainXmlUrl, oFile, fileCont, xmlDOM
Dim sFolder, mainFile, i, CtrlDate, existscnt, needcnt, idx, posname, existsidx
Dim image, image2, link, linktext, linktext2, startdate, enddate, linktext3
	sFolder = "/chtml_test/xml/"
	mainFile = "mainXMLBanner_694.xml"

	CtrlDate = Date()
	'CtrlDate = Cdate("2015-03-30")

''--------2016-03-23 유태욱 추가---------------------------------
	dim CtrltestDate
	CtrltestDate = requestCheckVar(Request("CtrltestDate"),32)
	if trim(CtrltestDate) <> "" then
		CtrlDate = cdate(trim(CtrltestDate))
	end if
''--------------------------------------------------------------

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
	Response.Write "<div class='mainMultiSlideV15'>"
	
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

		if i>4 then exit for	'//최대 5개까지 제한

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
%>
			<p>
			<% If InStr(link,"?") Then %>
				<a href="<%=link%>&gaparam=main_multi_0<%=i+1%>">
			<% Else %>
				<a href="<%=link%>?gaparam=main_multi_0<%=i+1%>">
			<% End If %>
					<img src="<%=image%>" alt="메인멀티" />
				</a>
			</p>
<%
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
%>
			<p>
			<% If InStr(link,"?") Then %>
				<a href="<%=link%>&gaparam=main_multi_0<%=i+1%>">
			<% Else %>
				<a href="<%=link%>?gaparam=main_multi_0<%=i+1%>">
			<% End If %>
					<img src="<%=image%>" alt="메인멀티" />
				</a>
			</p>
<%
			i = i + 1
			existscnt = existscnt + 1
		End If
	Next

	Set cTmpl = Nothing

	Response.Write "</div>"
End If
%>