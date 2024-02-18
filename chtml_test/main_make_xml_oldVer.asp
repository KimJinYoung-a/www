<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
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

Dim oKeyArr, i, j, cnt
Dim poscode, allrefresh, idx
Dim HeaderDataExsists, IdxDataExsists
Dim appData, sqlStr, vTotalCount, vReqCount, vFixType, vTerm, prevDate, vTerm2, sqlDate, vLinkType
Dim ocontents, ocontentsCode

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
			sqlDate = sqlDate & "('" & prevDate & "' between startdate and enddate)"
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

	'// 특정 코드에 링크텍스트 추가(IMG ALT 값 등)
	dim IsLinkTextNeed
	IsLinkTextNeed = (InStr(",642,659,673,674,675,", ("," & poscode & ",")) > 0)

	Dim savePath, FileName, fso, tFile, BufStr, VarName, DoubleQuat, omd,ix
	savePath = server.mappath("/chtml/xml/") + "\"
	FileName = "mainXMLBanner_" & poscode & ".xml"
	BufStr = ""
	BufStr = "<?xml version=""1.0"" encoding=""UTF-8"" ?>" & VbCrlf
	BufStr = BufStr & "<list>" & VbCrlf
	For i = 0 To CInt(vTotalCount) - 1
		BufStr = BufStr & "<item>" & VbCrlf
			BufStr = BufStr & "<image><![CDATA[" & staticImgUrl & "/main/" & db2Html(rsget("imageurl")) & "]]></image>" & VbCrlf
			If poscode = "652" or poscode = "653" or poscode = "654" Then
				BufStr = BufStr & "<image2><![CDATA[" & staticImgUrl & "/main2/" & db2Html(rsget("imageurl2")) & "]]></image2>" & VbCrlf
			End If

			If (needAddLinkHostName = False) Then
				BufStr = BufStr & "<link><![CDATA[" & db2Html(rsget("linkUrl")) & "]]></link>" & VbCrlf
			Else
				BufStr = BufStr & "<link><![CDATA[" & wwwUrl & db2Html(rsget("linkUrl")) & "]]></link>" & VbCrlf
			End If
			BufStr = BufStr & "<posname><![CDATA[" & db2Html(replace(rsget("posname"),"-","")) & "]]></posname>" & VbCrlf
			BufStr = BufStr & "<idx><![CDATA[" & rsget("idx") & "]]></idx>" & VbCrlf

			If (IsLinkTextNeed = True) Then
				BufStr = BufStr & "<linktext><![CDATA[" & db2Html(rsget("linktext")) & "]]></linktext>" & VbCrlf
				BufStr = BufStr & "<linktext2><![CDATA[" & db2Html(rsget("linktext2")) & "]]></linktext2>" & VbCrlf
				BufStr = BufStr & "<linktext3><![CDATA[" & db2Html(rsget("linktext3")) & "]]></linktext3>" & VbCrlf
			End If

			BufStr = BufStr & "<startdate><![CDATA[" & Replace(Left(rsget("startdate"),10),"-",",") & "]]></startdate>" & VbCrlf
			BufStr = BufStr & "<enddate><![CDATA[" & Replace(Left(rsget("enddate"),10),"-",",") & "]]></enddate>" & VbCrlf

			if (vLinkType = "M") then
				BufStr = BufStr & "<vname><![CDATA[" & db2Html(rsget("posvarname")) & "]]></vname>" & VbCrlf
			end if

		BufStr = BufStr & "</item>" & VbCrlf
		rsget.MoveNext
	Next
	BufStr = BufStr & "</list>" & VbCrlf

	''## EUC-KR 저장 (ASP File System은 서버 문자열을 따라감)
	''Set fso = CreateObject("Scripting.FileSystemObject")
	''    Set tFile = fso.CreateTextFile(savePath & FileName )
	''    tFile.Write BufStr
	''    tFile.Close
	''    Set tFile = Nothing
	''Set fso = Nothing

	'# UTF-8 저장 (ADODB.Stream 사용)
	Set fso = Server.CreateObject("ADODB.Stream")
	fso.Open
	fso.Type = 2	'adTypeText
	fso.Charset = "utf-8"
	fso.WriteText (BufStr)
	fso.SaveToFile (savePath & FileName), 2	'adSaveCreateOverWrite
	Set fso = nothing 

	rsget.Close
set ocontentsCode = Nothing
%>
OK<br>
<!-- #include virtual="/lib/db/dbclose.asp" -->
