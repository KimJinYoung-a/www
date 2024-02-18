<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/classes/culturestation/culturestationCls.asp"-->
<%
Dim i, editor_no, savePath, FileName
editor_no = Request("editor_no")
editor_no = Left(editor_no, Len(editor_no) - 1)
savePath = server.mappath("/chtml/XML/") + "\"
FileName = "main_curtureEditor.xml"

If (Len(editor_no) < 1) Then
	response.write "not valid editor_no"
	response.end
End If

Dim strSQL, rsEditor_no, rsEditor_name, rsImage_list2, rsImage_list2015
'// 메인 데이터 접수

strSQL = ""
strSQL = strSQL & " SELECT TOP 1 editor_no, editor_name, ISNULL(image_list2, '') as image_list2, ISNULL(image_list2015, '') as image_list2015 FROM db_culture_station.dbo.tbl_culturestation_editor WHERE editor_no = '"&editor_no&"' "
rsget.Open strSQL, dbget, 1
If Not rsget.EOF Then
	rsEditor_no		= rsget("editor_no")
	rsEditor_name	= rsget("editor_name")
	rsImage_list2	= rsget("image_list2")
	rsImage_list2015	= rsget("image_list2015")
End If
rsget.Close

If rsImage_list2015 = "" Then
	response.write "선택하신 에디터에 기본 #2015 이미지가 등록되지 않았습니다."
	response.end
End If

Dim objXML, objXMLv, blnFileExist
If rsImage_list2 <> "" then
	 Set objXML = server.CreateObject("Microsoft.XMLDOM")
		 objXML.async = False

		'// 기존 파일 삭제
		Dim fso, delFile
		Set fso = CreateObject("Scripting.FileSystemObject")
		If fso.FileExists(savePath & FileName) then
			Set delFile = fso.GetFile(savePath & FileName)
				delFile.Delete 
			Set delFile = Nothing
		End If
		Set fso = Nothing
	
		 '----- XML 해더 생성
		  objXML.appendChild(objXML.createProcessingInstruction("xml","version=""1.0"""))
		  objXML.appendChild(objXML.createElement("CurtureEditor"))
		 '-----프로세스 시작
		Set objXMLv = objXML.createElement("item")
			objXMLv.appendChild(objXML.createElement("editor_no"))
			objXMLv.appendChild(objXML.createElement("editor_name"))
			objXMLv.appendChild(objXML.createElement("image_list2"))
			objXMLv.appendChild(objXML.createElement("image_list2015"))
			
			objXMLv.childNodes(0).text = rsEditor_no
			objXMLv.childNodes(1).text = rsEditor_name
			objXMLv.childNodes(2).text = rsImage_list2
			objXMLv.childNodes(3).text = rsImage_list2015
			objXML.documentElement.appendChild(objXMLv.cloneNode(True))
		Set objXMLv = Nothing
		objXML.save(savePath & FileName)
	Set objXML = Nothing
End If
%>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<title>텐바이텐 컬처스테이션 생성기</title>
</head>
<body>
<script language='javascript'>
	alert("\'<%=FileName%>\'파일 생성 완료!");
	self.close();
</script>
<body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->