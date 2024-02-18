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
<%
	Dim vQuery, vCateCode, vBody, mx, my, vTotalCount, vSale, vRealPrice, vClass
	vCateCode = Request("catecode")

	'//logparam
	Dim logparam : logparam = "&pCtr="&vCateCode
	
	If vCateCode = "" Then
		Response.Write "<script>alert('잘못된 접근임!');window.close();</script>"
		dbget.close()
		Response.End
	End IF
	
	If isNumeric(vCateCode) = False Then
		Response.Write "<script>alert('잘못된 접근임!');window.close();</script>"
		dbget.close()
		Response.End
	End IF
	'----------------------------------------------------------------------------------------------------------------------------------------
	'### sale 체크 : 페이지를 읽는게 아니고 관리자가 만드는거라 등급체크 못하여 그냥 sailyn 값만 체크함.
	vQuery = "SELECT TOP 4 m.itemid, i.itemname, i.icon1image, i.sailyn,m.keyword, m.link "
	vQuery = vQuery & " 	FROM [db_sitemaster].[dbo].tbl_category_hotkeyword as m "
	vQuery = vQuery & " INNER JOIN db_item.dbo.tbl_item as i ON m.itemid = i.itemid "
	vQuery = vQuery & " WHERE m.disp = '" & vCateCode & "' AND m.isusing = 'Y' "
	vQuery = vQuery & " ORDER BY m.sortno asc, m.idx desc"
	rsget.Open vQuery,dbget,1
	vTotalCount = rsget.RecordCount
	
	If CStr(vTotalCount) <> "4" Then
		rsget.close
		Response.Write "<script>alert('HotKeyWord 에 올릴 상품은 4개가 되어야합니다.');window.close();</script>"
		dbget.close()
		Response.End
	End If

	Dim i : i = 1
	
	IF Not rsget.Eof Then
		vBody = ""
		Do Until rsget.Eof
				vBody = vBody & "		<li>  " & vbCrLf
				vBody = vBody & "			<a href='"& rsget("link") & CateMain_GaParam(vCateCode,"hotkeyword",i) &"'>  " & vbCrLf
				vBody = vBody & "				<div class='pdtPhoto'>  " & vbCrLf
				vBody = vBody & "					<p><span>#"&rsget("keyword")&"</span></p>  " & vbCrLf
				vBody = vBody & "					<img src='http://webimage.10x10.co.kr/image/icon1/" & GetImageSubFolderByItemid(rsget("itemid")) & "/" & rsget("icon1image") & "' alt='"&rsget("keyword")&"' /> " & vbCrLf
				vBody = vBody & "				</div>  " & vbCrLf
				vBody = vBody & "			</a>  " & vbCrLf
				vBody = vBody & "		</li>  " & vbCrLf
		
		i = i + 1
		rsget.MoveNext
		Loop
		
		vBody = vBody & "" & vbCrLf
		
	    if (vBody<>"") then
	    	Dim tFile, fso
			Set fso = Server.CreateObject("ADODB.Stream")
			fso.Type = 2
			fso.Charset = "utf-8"
			fso.Open
			fso.WriteText (vBody)
			fso.SaveToFile server.mappath("/chtml/dispcate/main/") & "\"&"catemain_hotkeyword_"&vCateCode&".html", 2
			Set fso = nothing
	    end if
	End If
	rsget.close
   

%>
<script>alert("적용완료!");window.close();</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->