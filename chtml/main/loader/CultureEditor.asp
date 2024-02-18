<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<%
'// 변수 선언
	Dim sMainXmlUrl, oFile, fileCont, xmlDOM
	Dim sFolder, mainFile, i
	Dim editor_no, editor_name, image_list2, image_list2015
	sFolder = "/chtml/xml/"
	mainFile = "main_curtureEditor.xml"

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
			editor_no		= tplNodes.getElementsByTagName("editor_no").item(0).text
			editor_name		= tplNodes.getElementsByTagName("editor_name").item(0).text
			image_list2		= tplNodes.getElementsByTagName("image_list2").item(0).text
			image_list2015		= tplNodes.getElementsByTagName("image_list2015").item(0).text

%>
			<p class="tMar12"><a href="/culturestation/culturestation_editor.asp?editor_no=<%=editor_no%>&gaparam=main_culture_banner"><span class="imgOverV15"><img src="<%= webImgUrl & "/culturestation/editor/2009/list2015/" & image_list2015 %>" alt="<%= editor_name %>" /></span></a></p><%' for dev msg : 어드민 등록배너(8_컬쳐에디터배너) / 배너명 alt값 속성에 넣어주세요 %>

<%		
		Next
		Set cTmpl = Nothing
	End If
%>