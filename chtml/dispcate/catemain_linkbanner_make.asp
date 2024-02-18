<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/classes/shopping/category_contents_managecls.asp" -->
<%
Dim oKeyArr, i, j, cnt
Dim poscode, allrefresh, idx
Dim HeaderDataExsists, IdxDataExsists, vBody, vArr
Dim appData, sqlStr, vTotalCount, vReqCount, vFixType, vTerm, prevDate, vTerm2, sqlDate, vCateCode, vIsAll
Dim ocontents, ocontentsCode
Dim tFile, fso

	vCateCode 	= requestCheckVar(Request("catecode"),3)
	poscode		= requestCheckVar(Request("poscode"),32)
	idx			= requestCheckVar(Request("idx"),9)
	vIsAll		= "x"
	
	If idx = "" Then
		vIsAll = "o"
	End IF
	

	If vIsAll = "o" Then
		sqlStr = sqlStr & "SELECT c.catecode FROM [db_item].[dbo].[tbl_display_cate] AS c " & vbCrLf
		sqlStr = sqlStr & " WHERE c.depth = '1' AND c.useyn = 'Y'"
		rsget.Open SqlStr, dbget, 1
		vArr = rsget.getRows()
		rsget.close
	End IF
	'----------------------------------------------------------------------------------------------------------------------------------------
	
	If vIsAll = "x" Then
		    sqlStr = "select top 1 c.*, p.posname"
		    sqlStr = sqlStr & " from [db_sitemaster].[dbo].tbl_category_contents c"
		    sqlStr = sqlStr & " left join [db_sitemaster].dbo.tbl_category_contents_poscode p"
		    sqlStr = sqlStr & " 	on c.poscode=p.poscode"
		    sqlStr = sqlStr & " where c.poscode = " & poscode & " and c.isusing = 'Y' and c.disp1 = '" & vCateCode & "' "
		    sqlStr = sqlStr & "	and c.idx = '" & idx & "' "
		    sqlStr = sqlStr & " order by c.startdate desc "
		    rsget.Open SqlStr, dbget, 1
			
			
			IF Not rsget.Eof Then
				vBody = ""
				vBody = vBody & "<a href=""" & db2Html(rsget("linkUrl")) & """><img src=""" & staticImgUrl & "/category/" & db2Html(rsget("imageurl")) & """ alt=""" & rsget("posname") & """ /></a>" & vbCrLf
				
			    if (vBody<>"") then
					Set fso = Server.CreateObject("ADODB.Stream")
					fso.Type = 2
					fso.Charset = "utf-8"
					fso.Open
					fso.WriteText (vBody)
					fso.SaveToFile server.mappath("/chtml/dispcate/main/ban/")+ "\"&"catemain_linkbanner_"&poscode&"_"&vCateCode&".html", 2
					Set fso = nothing
			    end if
			End If
			rsget.close
	ElseIf vIsAll = "o" Then
			For i = 0 To UBound(vArr,2)
			    sqlStr = "select top 1 c.*, p.posname"
			    sqlStr = sqlStr & " from [db_sitemaster].[dbo].tbl_category_contents c"
			    sqlStr = sqlStr & " left join [db_sitemaster].dbo.tbl_category_contents_poscode p"
			    sqlStr = sqlStr & " 	on c.poscode=p.poscode"
			    sqlStr = sqlStr & " where c.poscode = " & poscode & " and c.isusing = 'Y' and c.disp1 = '" & vArr(0,i) & "' "
			    sqlStr = sqlStr & "	and Convert(varchar(10),c.startdate,120) <= '" & date() & "' "
			    sqlStr = sqlStr & "	and Convert(varchar(10),c.enddate,120) >= '" & date() & "' "
			    sqlStr = sqlStr & " order by c.startdate desc "
			    rsget.Open SqlStr, dbget, 1
				
				
				IF Not rsget.Eof Then
					vBody = ""
					vBody = vBody & "<a href=""" & db2Html(rsget("linkUrl")) & """><img src=""" & staticImgUrl & "/category/" & db2Html(rsget("imageurl")) & """ alt=""" & rsget("posname") & """ /></a>" & vbCrLf
					
				    if (vBody<>"") then
				        Set fso = CreateObject("Scripting.FileSystemObject")
				        Set tFile = fso.CreateTextFile(server.mappath("/chtml/dispcate/main/ban/")+ "\"&"catemain_linkbanner_"&poscode&"_"&vArr(0,i)&".html")
					    tFile.Write vBody
					    tFile.Close
					    Set tFile = Nothing
				        Set fso = Nothing
				    end if
				End If
				rsget.close
			Next
	End If
%>
<% If vIsAll = "x" Then %><script>window.close();</script><% End If %>
<!-- #include virtual="/lib/db/dbclose.asp" -->