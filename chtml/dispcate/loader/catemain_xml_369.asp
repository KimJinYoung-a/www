<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<%
On Error Resume Next
Dim sMainXmlUrl, oFile, fileCont, xmlDOM
Dim sFolder, mainFile, i, CtrlDate, existscnt, needcnt, idx, posname, existsidx
Dim image, link, startdate, enddate, vDisp
	vDisp = request("disp")
	sFolder = "/chtml/dispcate/xml/"
	mainFile = "catemain_xml_369_"&vDisp&".xml"

	CtrlDate = Date()
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
	
		if i>2 then exit for	'//이미지 갯수가 3장일경우 그만뿌림
		
		'변수 저장
		image		= tplNodes.getElementsByTagName("image").item(0).text
		link		= tplNodes.getElementsByTagName("link").item(0).text
		startdate	= CDate(replace(tplNodes.getElementsByTagName("startdate").item(0).text, ",", "-"))
		enddate		= CDate(replace(tplNodes.getElementsByTagName("enddate").item(0).text, ",", "-"))
		idx		= tplNodes.getElementsByTagName("idx").item(0).text
		posname		= tplNodes.getElementsByTagName("posname").item(0).text
			
		If CtrlDate >= startdate AND CtrlDate <= enddate Then
%>
					<p><a href="<%=link%>"><img src="<%=image%>" alt="<%= posname %>" /></a></p>

<%
			existsidx = existsidx + idx + ","		'/등록된 이미지의 IDX를 저장
			
			i = i + 1
		End If
	Next

	existscnt = ubound(split(existsidx,","))	'//위에서 등록된 이미지수
	If existscnt = "-1" Then
		existscnt = 0
	End IF
	needcnt = 3-existscnt		'//모자란 이미지수
		
	i = 0
	'//만약 등록을 안했을경우 종료 이전꺼를 가져옴
	For each tplNodes in cTmpl
	
		if i>=needcnt then exit for	'//모자란 이미지수 만큼만 뿌린다
			
		'변수 저장
		image		= tplNodes.getElementsByTagName("image").item(0).text
		link		= tplNodes.getElementsByTagName("link").item(0).text
		startdate	= CDate(replace(tplNodes.getElementsByTagName("startdate").item(0).text, ",", "-"))
		enddate		= CDate(replace(tplNodes.getElementsByTagName("enddate").item(0).text, ",", "-"))
		idx		= tplNodes.getElementsByTagName("idx").item(0).text
		posname		= tplNodes.getElementsByTagName("posname").item(0).text
			
		'//종료 인것중에, 위에서 노출시킨거 빼고 뿌린다
		If CtrlDate >= startdate AND instr(existsidx,idx)=0 Then
%>
					<p><a href="<%=link%>"><img src="<%=image%>" alt="<%= posname %>" /></a></p>
<%
			i = i + 1
		End If
	Next
	
	Set cTmpl = Nothing
End If
On Error Goto 0
%>