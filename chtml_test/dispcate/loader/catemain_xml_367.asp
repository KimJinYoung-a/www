<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/commlib.asp" -->
<%
On Error Resume Next
'// 변수 선언
	Dim sMainXmlUrl, oFile, fileCont, xmlDOM, startNo
	Dim sFolder, mainFile, i, CtrlDate, existsidx, existscnt, needcnt
	Dim image, link, posname, startdate, enddate, idx, vDisp, evtname, evtcode, evtsubcopyK, etcitemimg, ab, tmpEvtName, evtSaleVal, etcitemid, etcimg, basicimg, basicimg600, vChkTestDate
	vDisp = request("disp")
	ab = request("ab")
	vChkTestDate = request("chkTestDate")
	sFolder = "/chtml_test/dispcate/xml/"
	mainFile = "catemain_xml_367_"&vDisp&".xml"


	existscnt = 0
	needcnt = 0
	
	startNo=int(Rnd*(3))+1

	If vChkTestDate <> "" Then 
		CtrlDate = CDate(vChkTestDate)
	Else
		CtrlDate = Date()
	End If
	'CtrlDate = Cdate("2013-10-01")
	
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


		i = 0
		For each tplNodes in cTmpl
			
			if i>4 then exit for	'//이미지 갯수가 5장일경우 그만뿌림
		
			'변수 저장
			image		= tplNodes.getElementsByTagName("image").item(0).text
			link		= tplNodes.getElementsByTagName("link").item(0).text
			posname		= tplNodes.getElementsByTagName("posname").item(0).text
			startdate	= CDate(replace(tplNodes.getElementsByTagName("startdate").item(0).text,",","-"))
			enddate		= CDate(replace(tplNodes.getElementsByTagName("enddate").item(0).text,",","-"))
			idx		= tplNodes.getElementsByTagName("idx").item(0).text
			evtname		= tplNodes.getElementsByTagName("evtname").item(0).text
			evtcode		= tplNodes.getElementsByTagName("evtcode").item(0).text
			evtsubcopyK		= tplNodes.getElementsByTagName("evtsubcopyK").item(0).text
			etcitemimg		= tplNodes.getElementsByTagName("etcitemimg").item(0).Text			
			etcitemid		= tplNodes.getElementsByTagName("etcitemid").item(0).Text
			basicimg		= tplNodes.getElementsByTagName("basicimage").item(0).Text
			basicimg600		= tplNodes.getElementsByTagName("basicimage600").item(0).Text
			
			If CtrlDate >= startdate AND CtrlDate <= enddate Then
'				If ab="002_b_5" Then
					evtSaleVal = ""
					If Trim(evtname)<>"" Then
						tmpEvtName = Split(evtname, "|")
						If ubound(tmpEvtName)>0 Then
							evtname = tmpEvtName(0)
							evtSaleVal = tmpEvtName(1)
						End If
					End If

					If Trim(etcitemimg)="" Then
						If Trim(basicimg600)<>"" Then
							etcimg = "http://webimage.10x10.co.kr/image/basic600/" + GetImageSubFolderByItemid(etcitemid) + "/" + basicimg600
						Else
							etcimg = "http://webimage.10x10.co.kr/image/basic/" + GetImageSubFolderByItemid(etcitemid) + "/" + basicimg
						End If
					Else
						etcimg = etcitemimg
					End If

					Response.Write " <div class='bnr0"&i&"'> " & vbCrLf
					If Trim(image) <> "" Then
						Response.Write "	<a href='/event/eventmain.asp?eventid="&evtcode&"'><img src='"&image&"' alt='"&evtname&"' /></a> " & vbCrLf
					Else
						Response.Write "	<a href='/event/eventmain.asp?eventid="&evtcode&"'><img src='"&etcimg&"' alt='"&evtname&"' /></a> " & vbCrLf
					End If
					Response.Write "	<div class='bnrTit'> " & vbCrLf
					Response.Write "		<span class='num'>0"&i+1&"</span><p>"&chrbyte(evtname,23,"Y")
					If Trim(evtSaleVal)<>"" Then
						Response.Write " <em class='saleRed'>"&evtSaleVal&"</em></p> " & vbCrLf
					Else
						Response.Write "</p>" & vbCrLf
					End If
					Response.Write "	</div> " & vbCrLf
					Response.Write " </div> " & vbCrLf
'				Else
'					Response.Write "<p><a href=""" & link & """><img src=""" & image & """ alt=""" & posname & """ style=""width:635px; height:380px;"" /></a></p>" & vbCrLf
'				End If
				existsidx = existsidx + idx + ","		'/등록된 이미지의 IDX를 저장
				i = i + 1
			
			end if
		Next

		existscnt = ubound(split(existsidx,","))	'//위에서 등록된 이미지수
		If existscnt = "-1" Then
			existscnt = 0
		End IF
		needcnt = 5-existscnt		'//모자란 이미지수

		i = 0
		'//만약 등록을 안했을경우 종료 이전꺼를 가져옴
		For each tplNodes in cTmpl
			
			if i>=needcnt then exit for	'//모자란 이미지수 만큼만 뿌린다
		
			'변수 저장
			image		= tplNodes.getElementsByTagName("image").item(0).text
			link		= tplNodes.getElementsByTagName("link").item(0).text
			posname		= tplNodes.getElementsByTagName("posname").item(0).text
			startdate	= CDate(replace(tplNodes.getElementsByTagName("startdate").item(0).text,",","-"))
			enddate		= CDate(replace(tplNodes.getElementsByTagName("enddate").item(0).text,",","-"))
			idx		= tplNodes.getElementsByTagName("idx").item(0).Text
			evtname		= tplNodes.getElementsByTagName("evtname").item(0).text
			evtcode		= tplNodes.getElementsByTagName("evtcode").item(0).text
			evtsubcopyK		= tplNodes.getElementsByTagName("evtsubcopyK").item(0).text
			etcitemimg		= tplNodes.getElementsByTagName("etcitemimg").item(0).Text						
			etcitemid		= tplNodes.getElementsByTagName("etcitemid").item(0).Text			
			basicimg		= tplNodes.getElementsByTagName("basicimage").item(0).Text
			basicimg600		= tplNodes.getElementsByTagName("basicimage600").item(0).Text
			
			'//종료 인것중에, 위에서 노출시킨거 빼고 뿌린다
			If CtrlDate >= startdate AND instr(existsidx,idx)=0 Then
				If ab="002_b_5" Then
					If Trim(evtname)<>"" Then
						tmpEvtName = Split(evtname, "|")
						If ubound(tmpEvtName)>0 Then
							evtname = tmpEvtName(0)
							evtSaleVal = tmpEvtName(1)
						End If
					End If

					If Trim(etcitemimg)="" Then
						If Trim(basicimg600)<>"" Then
							etcimg = "http://webimage.10x10.co.kr/image/basic600/" + GetImageSubFolderByItemid(etcitemid) + "/" + basicimg600
						Else
							etcimg = "http://webimage.10x10.co.kr/image/basic/" + GetImageSubFolderByItemid(etcitemid) + "/" + basicimg
						End If
					Else
						etcimg = etcitemimg
					End If

					Response.Write " <div class='bnr0"&existscnt+i&"'> " & vbCrLf
					If Trim(image) <> "" Then
						Response.Write "	<a href='/event/eventmain.asp?eventid="&evtcode&"'><img src='"&image&"' alt='"&evtname&"' /></a> " & vbCrLf
					Else
						Response.Write "	<a href='/event/eventmain.asp?eventid="&evtcode&"'><img src='"&etcimg&"' alt='"&evtname&"' /></a> " & vbCrLf
					End If
					Response.Write "	<div class='bnrTit'> " & vbCrLf
					Response.Write "		<span class='num'>0"&existscnt+i+1&"</span><p>"&chrbyte(evtname,15,"Y")
					If Trim(evtSaleVal)<>"" Then
						Response.Write "<em class='saleRed'>"&evtSaleVal&"</em></p> " & vbCrLf
					Else
						Response.Write "</p>" & vbCrLf
					End If
					Response.Write "	</div> " & vbCrLf
					Response.Write " </div> " & vbCrLf
				Else
					Response.Write "<p><a href=""" & link & """><img src=""" & image & """ alt=""" & posname & """ style=""width:635px; height:380px;"" /></a></p>"
				End If
				i = i + 1
			
			end if
		Next

		Set cTmpl = Nothing
	End If
On Error Goto 0
%>