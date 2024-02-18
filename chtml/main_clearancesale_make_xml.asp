<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description :  메인 페이지 클리어런스 배너 생성
' History : 2017.08.08 유태욱 생성
'###########################################################
%>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<%
'서버ip확인
'if request.ServerVariables("REMOTE_ADDR") <> "" then
'     response.End()
'end if

Dim refip, sqlStr, vTotalCount, objXML, i, objXMLv
refip = request.ServerVariables("HTTP_REFERER")

'If (InStr(refip, "10x10.co.kr") < 1) Then
'	response.write "not valid Referer"
'	response.end
'End if

	sqlStr = "EXEC [db_sitemaster].[dbo].[sp_Ten_Clearance_Main_ItemList] 15"
	rsget.CursorLocation = adUseClient
	rsget.CursorType = adOpenStatic
	rsget.LockType = adLockOptimistic
	rsget.Open sqlStr,dbget
	vTotalCount = rsget.RecordCount

	Dim savePath, FileName
	savePath = server.mappath("/chtml/xml/") + "\"
	FileName = "mainXMLBanner_clearancesale.xml"

	'// XML 데이터 생성
	 Set objXML = server.CreateObject("Microsoft.XMLDOM")
	 objXML.async = False

	'----- XML 해더 생성
	objXML.appendChild(objXML.createProcessingInstruction("xml","version=""1.0"""))
	objXML.appendChild(objXML.createElement("list"))

	'-----프로세스 시작
	if vTotalCount > 0 then 
		For i = 0 To CInt(vTotalCount) - 1
			Set objXMLv = objXML.createElement("item")
				objXMLv.appendChild(objXML.createElement("idx"))
				objXMLv.childNodes(0).text = rsget("idx")
	
				objXMLv.appendChild(objXML.createElement("itemid"))
				objXMLv.childNodes(1).text = rsget("itemid")
	
				objXMLv.appendChild(objXML.createElement("itemname"))
				objXMLv.childNodes(2).appendChild(objXML.createCDATASection("itemname_Cdata"))
				objXMLv.childNodes(2).childNodes(0).text = db2Html(rsget("itemname"))
	
				objXMLv.appendChild(objXML.createElement("limitno"))
				objXMLv.childNodes(3).text = rsget("limitno")
	
				objXMLv.appendChild(objXML.createElement("limitsold"))
				objXMLv.childNodes(4).text = rsget("limitsold")

				objXMLv.appendChild(objXML.createElement("makerid"))
				objXMLv.childNodes(5).appendChild(objXML.createCDATASection("makerid_Cdata"))
				objXMLv.childNodes(5).childNodes(0).text = db2Html(rsget("makerid"))

				objXMLv.appendChild(objXML.createElement("brandname"))
				objXMLv.childNodes(6).appendChild(objXML.createCDATASection("brandname_Cdata"))
				objXMLv.childNodes(6).childNodes(0).text = db2Html(rsget("brandname"))
	
				objXMLv.appendChild(objXML.createElement("listimage"))
				if Not(rsget("listimage")="" or isNull(rsget("listimage"))) then
					objXMLv.childNodes(7).appendChild(objXML.createCDATASection("listimage_Cdata"))
					objXMLv.childNodes(7).childNodes(0).text = "http://webimage.10x10.co.kr/image/list/"&GetImageSubFolderByItemid(rsget("itemid"))&"/"& db2Html(rsget("listimage"))
				end if
	
				objXMLv.appendChild(objXML.createElement("listimage120"))
				if Not(rsget("listimage120")="" or isNull(rsget("listimage120"))) then
					objXMLv.childNodes(8).appendChild(objXML.createCDATASection("listimage120_Cdata"))
					objXMLv.childNodes(8).childNodes(0).text = "http://webimage.10x10.co.kr/image/list120/"&GetImageSubFolderByItemid(rsget("itemid"))&"/"& db2Html(rsget("listimage120"))
				end if

				objXMLv.appendChild(objXML.createElement("basicimage"))
				if Not(rsget("basicimage")="" or isNull(rsget("basicimage"))) then
					objXMLv.childNodes(9).appendChild(objXML.createCDATASection("basicimage_Cdata"))
					objXMLv.childNodes(9).childNodes(0).text = "http://webimage.10x10.co.kr/image/basic/"&GetImageSubFolderByItemid(rsget("itemid"))&"/"& db2Html(rsget("basicimage"))
				end if

				objXMLv.appendChild(objXML.createElement("LimitedLowStock"))
				objXMLv.childNodes(10).text = rsget("LimitedLowStock")

				objXMLv.appendChild(objXML.createElement("orgprice"))
				objXMLv.childNodes(11).text = rsget("orgprice")

				objXMLv.appendChild(objXML.createElement("sellcash"))
				objXMLv.childNodes(12).text = rsget("sellcash")

				objXMLv.appendChild(objXML.createElement("sailper"))
				objXMLv.childNodes(13).text = cint(rsget("sailper"))

				'Parent 저장
				objXML.documentElement.appendChild(objXMLv.cloneNode(True))
				Set objXMLv = Nothing
	
			rsget.MoveNext
		Next

	'// XML파일 저장
	objXML.save(savePath & FileName)
	end if
	rsget.Close

Set objXML = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
