<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<!-- #include virtual="/lib/util/commlib.asp" -->
<%
'// 변수 선언
	Dim sMainXmlUrl, oFile, fileCont, xmlDOM
	Dim sFolder, mainFile, i
	Dim evt_code, evt_name, evt_type, bannerImg, typetext, typealt, evt_comment
	sFolder = "/chtml/xml/"
	mainFile = "main_curture12Banner.xml"

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
			evt_code		= tplNodes.getElementsByTagName("evt_code").item(0).text
			evt_name		= tplNodes.getElementsByTagName("evt_name").item(0).text
			evt_type		= tplNodes.getElementsByTagName("evt_type").item(0).text
			bannerImg		= tplNodes.getElementsByTagName("bannerImg").item(0).text
			evt_comment		= tplNodes.getElementsByTagName("evt_comment").item(0).text

			If i = 1 Then
%>
				<ul class="cultureListV15">
<%
			End If
%>

					<li>
						<a href="/culturestation/culturestation_event.asp?evt_code=<%=evt_code%>&gaparam=main_culture_<%=i%>">
							<p><span class="imgOverV15"><img src="<%=bannerImg%>" alt="<%=evt_name%>" /></span></p><%' for dev msg : 컬쳐명 alt값 속성에 넣어주세요 %>
							<span><%=evt_comment%></span>
						</a>
					</li>

<%
			If i mod 5 = 0 Then
				If i < 15 Then
%>
				</ul>
				<ul class="cultureListV15">
<%
				Else
%>
				</ul>

<%
				End If
			End If
			i = i + 1
		Next
		Set cTmpl = Nothing
	End If
%>
