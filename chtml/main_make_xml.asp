<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/classes/shopping/main_contents_managecls.asp" -->
<%
Dim refip
refip = request.ServerVariables("HTTP_REFERER")

If (InStr(refip, "10x10.co.kr") < 1) Then
	response.write "not valid Referer"
	response.end
End if

Dim vRegUserID
vRegUserID = requestCheckVar(Request("rid"),32)
If vRegUserID = "" Then
	response.write "<script>alert('어드민 로그인을 한 뒤 실행하세요.');self.close();</script>"
	dbget.close()
	response.end
End If

Dim oKeyArr, i, j, cnt
Dim poscode, allrefresh, idx
Dim HeaderDataExsists, IdxDataExsists
Dim appData, sqlStr, vTotalCount, vReqCount, vFixType, vTerm, prevDate, vTerm2, sqlDate, vLinkType
Dim ocontents, ocontentsCode
dim objXML, objXMLv, rstMsg

poscode		= requestCheckVar(Request("poscode"),32)
allrefresh	= requestCheckVar(Request("allrefresh"),32)
idx			= requestCheckVar(Request("idx"),9)
vTerm		= requestCheckVar(Request("term"),3)
vTerm2		= vTerm
If vTerm2 = "" Then vTerm2 = 1
If vTerm <> "" Then
	vTerm = DateAdd("d",date(),vTerm-1)
End IF
sqlDate = ""

'// 적용코드 확인
Set ocontentsCode = new CMainContentsCode
	ocontentsCode.FRectPoscode = poscode
	ocontentsCode.GetOneContentsCode

	If (ocontentsCode.FResultCount < 1) Then
	    response.write "<script language=javascript>alert('유효한 적용코드가 아닙니다.');self.close();</script>"
		response.end
	End If

	If poscode <> 657 Then
		'// 최소 제한수 검사
		for j=1 to cInt(vTerm2)
			'해당 날짜 접수
			prevDate = dateadd("d",(j-1),date)
'			sqlDate = sqlDate & "('" & prevDate & "' between startdate and enddate)"
			sqlDate = sqlDate & "('" & prevDate & "' between convert(varchar(10),startdate,120) and convert(varchar(10),enddate,120))"

			if j<cInt(vTerm2) then sqlDate = sqlDate & " or "
			'// 메인 데이터 접수
			set ocontents = New CMainContents
				ocontents.FRectPoscode = poscode
				ocontents.FPageSize = ocontentsCode.FOneItem.FuseSet
				ocontents.frectorderidx = "main"
				ocontents.FRectSelDate = prevDate
				ocontents.GetMainContentsValidList

				if (ocontents.FResultCount<1) then
				    response.write "<script language=javascript>alert('[" & prevDate & "]일의 적용할 데이터가 없습니다.');self.close();</script>"
					response.end
				elseif (ocontents.FResultCount<(ocontentsCode.FOneItem.FuseSet)) then
				    response.write "<script language=javascript>alert('[" & prevDate & "]일 적용에 필요한 데이터가 부족합니다.\n\n(※ 최소 " & (ocontentsCode.FOneItem.FuseSet) & "건 필요. 현재 " & ocontents.FResultCount & "건 등록됨)');self.close();</script>"
					response.end
				end if

			set ocontents = Nothing
		Next
	End IF

	sqlStr = "select useSet, fixtype, linktype from [db_sitemaster].dbo.tbl_main_contents_poscode"
	sqlStr = sqlStr & " where poscode = " & poscode & " "
	rsget.Open SqlStr, dbget, 1
		vReqCount = rsget("useSet")
		vFixType = rsget("fixtype")
		vLinkType = rsget("linktype")
	rsget.Close

	dim needAddLinkHostName : needAddLinkHostName = True
	if (poscode = 657) or (vLinkType = "M") then
		needAddLinkHostName = False
	end if

	If vFixType = "D" Then	'### 일별등록
	    sqlStr = "select c.*, p.posname"
	    sqlStr = sqlStr & " from [db_sitemaster].[dbo].tbl_main_contents c"
	    sqlStr = sqlStr & " left join [db_sitemaster].dbo.tbl_main_contents_poscode p"
	    sqlStr = sqlStr & " 	on c.poscode=p.poscode"
	    sqlStr = sqlStr & " where c.poscode = " & poscode & " and c.isusing = 'Y' "
	    sqlStr = sqlStr & "	and (" & sqlDate & ") "
	    sqlStr = sqlStr & " order by c.orderidx asc, c.idx desc "
	Else
		Select Case poscode
			Case 657
			    sqlStr = "select top " & vReqCount & " c.*, p.posname"
			    sqlStr = sqlStr & " from [db_sitemaster].[dbo].tbl_main_contents c"
			    sqlStr = sqlStr & " left join [db_sitemaster].dbo.tbl_main_contents_poscode p"
			    sqlStr = sqlStr & " 	on c.poscode=p.poscode"
			    sqlStr = sqlStr & " where c.poscode = " & poscode & " and c.isusing = 'Y'"
			    sqlStr = sqlStr & " order by c.orderidx asc, c.idx desc"
			Case Else
			    sqlStr = "select top " & vReqCount & " c.*, p.posname"
			    sqlStr = sqlStr & " from [db_sitemaster].[dbo].tbl_main_contents c"
			    sqlStr = sqlStr & " left join [db_sitemaster].dbo.tbl_main_contents_poscode p"
			    sqlStr = sqlStr & " 	on c.poscode=p.poscode"
			    sqlStr = sqlStr & " where c.poscode = " & poscode & " and c.isusing = 'Y' "
			    sqlStr = sqlStr & "	and getdate() between startdate and enddate "
			    sqlStr = sqlStr & " order by c.orderidx asc, c.idx desc "			
		End Select
	End If
	rsget.Open SqlStr, dbget, 1
	vTotalCount = rsget.RecordCount

	If vTotalCount < vReqCount Then
		Response.Write "<script>alert('최소 "& vReqCount & "개 이상을 등록하셔야 합니다.');window.close();</script>"
		rsget.Close
		dbget.close()
		response.end
	End If

	Dim savePath, FileName
	savePath = server.mappath("/chtml/xml/") + "\"
	FileName = "mainXMLBanner_" & poscode & ".xml"

	'// XML 데이터 생성
	 Set objXML = server.CreateObject("Microsoft.XMLDOM")
	 objXML.async = False

	'----- XML 해더 생성
	objXML.appendChild(objXML.createProcessingInstruction("xml","version=""1.0"""))
	objXML.appendChild(objXML.createElement("list"))

	'-----프로세스 시작
	For i = 0 To CInt(vTotalCount) - 1
		Set objXMLv = objXML.createElement("item")

			objXMLv.appendChild(objXML.createElement("idx"))
			objXMLv.childNodes(0).text = rsget("idx")
			objXMLv.appendChild(objXML.createElement("posname"))
			objXMLv.childNodes(1).appendChild(objXML.createCDATASection("posname_Cdata"))		'CData 타입정의
			objXMLv.childNodes(1).childNodes(0).text = db2Html(replace(rsget("posname"),"-",""))				'데이터 넣기

			objXMLv.appendChild(objXML.createElement("vname"))
			objXMLv.childNodes(2).text = db2Html(rsget("posvarname"))

			objXMLv.appendChild(objXML.createElement("image"))
			if Not(rsget("imageurl")="" or isNull(rsget("imageurl"))) then
				objXMLv.childNodes(3).appendChild(objXML.createCDATASection("image_Cdata"))
				objXMLv.childNodes(3).childNodes(0).text = staticImgUrl & "/main/" & db2Html(rsget("imageurl"))
			end if
			objXMLv.appendChild(objXML.createElement("image2"))
			if Not(rsget("imageurl2")="" or isNull(rsget("imageurl2"))) then 
				objXMLv.childNodes(4).appendChild(objXML.createCDATASection("image2_Cdata"))
				objXMLv.childNodes(4).childNodes(0).text = staticImgUrl & "/main2/" & db2Html(rsget("imageurl2"))
			end if

			objXMLv.appendChild(objXML.createElement("link"))
			objXMLv.childNodes(5).appendChild(objXML.createCDATASection("link_Cdata"))
			objXMLv.childNodes(5).childNodes(0).text = chkIIF(needAddLinkHostName,"",wwwUrl) &  db2Html(rsget("linkUrl"))

			objXMLv.appendChild(objXML.createElement("linktext"))
			objXMLv.childNodes(6).appendChild(objXML.createCDATASection("linktext_Cdata"))
			objXMLv.childNodes(6).childNodes(0).text = db2Html(rsget("linktext"))
			objXMLv.appendChild(objXML.createElement("linktext2"))
			objXMLv.childNodes(7).appendChild(objXML.createCDATASection("linktext2_Cdata"))
			objXMLv.childNodes(7).childNodes(0).text = db2Html(rsget("linktext2"))
			objXMLv.appendChild(objXML.createElement("linktext3"))
			objXMLv.childNodes(8).appendChild(objXML.createCDATASection("linktext3_Cdata"))
			objXMLv.childNodes(8).childNodes(0).text = db2Html(rsget("linktext3"))

			objXMLv.appendChild(objXML.createElement("startdate"))
			objXMLv.childNodes(9).appendChild(objXML.createCDATASection("startdate_Cdata"))
'			objXMLv.childNodes(9).text = Replace(Left(rsget("startdate"),10),"-",",")
			objXMLv.childNodes(9).childNodes(0).text = db2Html(rsget("startdate"))

			objXMLv.appendChild(objXML.createElement("enddate"))
			objXMLv.childNodes(10).appendChild(objXML.createCDATASection("enddate_Cdata"))
'			objXMLv.childNodes(10).text = Replace(Left(rsget("enddate"),10),"-",",")
			objXMLv.childNodes(10).childNodes(0).text = db2Html(rsget("enddate"))

			objXMLv.appendChild(objXML.createElement("linktext4"))
			objXMLv.childNodes(11).appendChild(objXML.createCDATASection("linktext4_Cdata"))
			objXMLv.childNodes(11).childNodes(0).text = db2Html(rsget("linktext4"))

			'Parent 저장
			objXML.documentElement.appendChild(objXMLv.cloneNode(True))
			Set objXMLv = Nothing

		rsget.MoveNext
	Next

	'// XML파일 저장
	objXML.save(savePath & FileName)
	rstMsg = "데이터 파일 [" & FileName & "] 생성 완료"

	rsget.Close
	
	sqlStr = "INSERT INTO [db_sitemaster].[dbo].[tbl_main_contents_openlog](poscode, reguserid, duedate) "
	sqlStr = sqlStr & "VALUES('" & poscode & "', '" & vRegUserID & "', '" & DateAdd("d",date(),vTerm2-1) & "')"
	dbget.Execute sqlStr
	
Set objXML = Nothing
set ocontentsCode = Nothing
%>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<title>텐바이텐 메인페이지 생성기</title>
</head>
<body>
<script type='text/javascript'>
alert("<%=rstMsg%>");
self.close();
</script>
<body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->
