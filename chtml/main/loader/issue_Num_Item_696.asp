<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
'###########################################################
' Description :  메인 페이지 이슈별 넘버링 아이템
' History : 2015.04.08 원승현 생성
'###########################################################
%>
<!-- #include virtual="/lib/util/commlib.asp" -->
<%
'// 변수 선언
	Dim sMainXmlUrl, oFile, fileCont, xmlDOM, startNo
	Dim sFolder, mainFile, i, CtrlDate, existsidx, existscnt, needcnt
	Dim image, link, linktext, linktext2, linktext3, posname, startdate, enddate, idx, si

	sFolder = "/chtml/xml/"
	mainFile = "mainXMLBanner_696.xml"

	existscnt = 0
	needcnt = 0


	CtrlDate = Date()
	'CtrlDate = Cdate("2013-10-01")

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
%>

<%
i = 0
For each tplNodes in cTmpl

'	if i >= (1 + 5) then exit for	'//이미지 제한인데 이건 사실상 이미지 제한 없음 다만 반드시 입력시 맨 상단에 타이틀 이미지 넣어야됨

	'변수 저장
	image		= tplNodes.getElementsByTagName("image").item(0).text
	link		= tplNodes.getElementsByTagName("link").item(0).text
	linktext	= tplNodes.getElementsByTagName("linktext").item(0).text
	''linktext2	= tplNodes.getElementsByTagName("linktext2").item(0).text
	''linktext3	= tplNodes.getElementsByTagName("linktext3").item(0).text
	posname		= tplNodes.getElementsByTagName("posname").item(0).text
	startdate	= CDate(replace(tplNodes.getElementsByTagName("startdate").item(0).text,",","-"))
	enddate		= CDate(replace(tplNodes.getElementsByTagName("enddate").item(0).text,",","-"))
	idx			= tplNodes.getElementsByTagName("idx").item(0).text

	If CtrlDate >= startdate AND CtrlDate <= enddate Then
		'// 종료않된 것만.
		if (i = 0) then
			'타이틀 이미지
	%>
					<h2><img src="<%= image %>" alt="<%= linktext %>" /></h2>
					<div id="issueSlider" class="slider-horizontal">
					<%
		else
			'라운드 이미지

			If Len(Trim(i))=1 Then
				si = "0"&i
			Else
				si = i
			End If
	%>
					<div class="issuItem">
					<% If InStr(link,"?") Then %>
						<a href="<%=link%>&gaparam=main_issue_<%=si%>">
					<% Else %>
						<a href="<%=link%>?gaparam=main_issue_<%=si%>">
					<% End If %>
							<p class="imgOverV15"><img src="<%= image %>" alt="<%= linktext %>" /></p><%' for dev msg : 해당상품명 alt값에 넣어주세요/마우스 오버하면 포토서버 적용해서 이미지의 opacity:50%(0.5) 적용해주세요 %>
							<strong><%=si%></strong><%' for dev msg : 등록하는 컨텐츠 순서대로 넘버링 해주세요 %>
						</a>
					</div>
	<%
		end if

		existsidx = existsidx + idx + ","		'/등록된 이미지의 IDX를 저장
		i = i + 1
	end if
Next
	%>

	</div>
						
<%
		Set cTmpl = Nothing
	End If
%>
