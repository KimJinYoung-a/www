<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/classes/shopping/main_contents_mdChoiceCls.asp" -->
<%
'###########################################################
' History : 2009.04.17 한용민 2008프론트에서 이동
'           2013.09.27 허진원 2013리뉴얼; xml방식으로 저장
'###########################################################
%>
<%
'' 관리자 확정시 Data 작성. 

dim i, itemCnt
dim savePath, FileName, refip
dim objXML, objXMLv, rstMsg

'표시할 상품수 지정
itemCnt = 30


'// 유입경로 확인
refip = request.ServerVariables("HTTP_REFERER")

if (InStr(refip,"10x10.co.kr")<1) then
	response.write "not valid Referer"
    response.end
end if

dim ocontents, vIdx, vQuery

'// 메인 데이터 접수
set ocontents = New CMDChoice
ocontents.FPageSize = itemCnt
ocontents.GetMDChoiceList

if (ocontents.FResultCount<1) then
    response.write "<script language=javascript>alert('적용할 데이터가 없습니다.');self.close();</script>"
	response.end
elseif (ocontents.FResultCount<itemCnt) then
    response.write "<script language=javascript>alert('적용에 필요한 데이터가 부족합니다.\n\n(※ 최소 " & itemCnt & "건 필요. 현재 " & ocontents.FResultCount & "건 등록됨)');</script>"
	response.end
end if

dim fso, tFile, BufStr
dim VarName, DoubleQuat, omd,ix

'// 파일 생성
if ocontents.FResultCount>0 then

		savePath = server.mappath("/chtml/xml/") + "\"
		FileName = "mainMDPickXML.xml"


		'// XML 데이터 생성
		 Set objXML = server.CreateObject("Microsoft.XMLDOM")
		 objXML.async = False

		'----- XML 해더 생성
		objXML.appendChild(objXML.createProcessingInstruction("xml","version=""1.0"""))
		objXML.appendChild(objXML.createElement("list"))
	
		for i=0 to ocontents.FResultCount-1
			Set objXMLv = objXML.createElement("item")
				objXMLv.appendChild(objXML.createElement("image"))
				objXMLv.childNodes(0).appendChild(objXML.createCDATASection("image_Cdata"))
				If Not(ocontents.FItemList(i).Fphotoimg="" Or isnull(ocontents.FItemList(i).Fphotoimg)) Then
					objXMLv.childNodes(0).childNodes(0).Text = ocontents.FItemList(i).Fphotoimg
				ElseIf Not(ocontents.FItemList(i).FTentenImage200="" Or isnull(ocontents.FItemList(i).FTentenImage200)) Then
					objXMLv.childNodes(0).childNodes(0).Text = ocontents.FItemList(i).FTentenImage200
				Else
					objXMLv.childNodes(0).childNodes(0).Text = ocontents.FItemList(i).FImageList
				End If
				objXMLv.appendChild(objXML.createElement("link"))
				objXMLv.childNodes(1).appendChild(objXML.createCDATASection("link_Cdata"))
				objXMLv.childNodes(1).childNodes(0).text = wwwUrl & ocontents.FItemList(i).Flinkinfo
				objXMLv.appendChild(objXML.createElement("text"))
				objXMLv.childNodes(2).appendChild(objXML.createCDATASection("text_Cdata"))
				objXMLv.childNodes(2).childNodes(0).text = nl2br(ocontents.FItemList(i).Ftextinfo)
				objXMLv.appendChild(objXML.createElement("sale"))
				objXMLv.childNodes(3).text = ocontents.FItemList(i).getSalePercent()
				objXMLv.appendChild(objXML.createElement("itemname"))
				objXMLv.childNodes(4).appendChild(objXML.createCDATASection("item_Cdata"))
				objXMLv.childNodes(4).childNodes(0).text = ocontents.FItemList(i).FitemName
			vIdx = vIdx & ocontents.FItemList(i).Fidx & ","

			'Parent 저장
			objXML.documentElement.appendChild(objXMLv.cloneNode(True))
			Set objXMLv = Nothing
	    next
	
	
		'// XML파일 저장
		objXML.save(savePath & FileName)
		rstMsg = "파일 [" & FileName & "] 생성 완료"

		vIdx = Left(vIdx, (Len(vIdx)-1))
		vQuery = "update [db_sitemaster].[dbo].tbl_main_mdchoice_flash set isNow = null where isNow = 'y' " & vbCrLf
		vQuery = vQuery & "update [db_sitemaster].[dbo].tbl_main_mdchoice_flash set isNow = 'y' where idx in(" & vIdx & ")"
		dbget.execute vQuery


end if
%>
<%
	Set objXML = Nothing
	set ocontents = Nothing
%>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<title>텐바이텐 MDPICK 생성기</title>
</head>
<body>
<script language='javascript'>
alert("<%=rstMsg%>");
self.close();
</script>
<body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->