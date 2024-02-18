<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<% 
Dim i , imagecount , idx ,savePath ,FileName ,refip, sort
idx = Request("idx")
sort = Request("sort")
idx = left(idx,len(idx)-1)
sort= left(sort,len(sort)-1)
imagecount = Ubound(Split(idx,",")) + 1
savePath = server.mappath("/chtml/street/js/main/") + "\"
FileName = "brand_MainLookBook.js"
refip = request.ServerVariables("HTTP_REFERER")

Dim sqlStr, vImageCount, vTotalCount
vImageCount = 3
	
If cint(vImageCount) <> cint(imagecount) Then
    response.write "<script language=javascript>"
    response.write     "alert('적용에 필요한 이미지 수가 일치 하지 않습니다.\n\n(※ " & vImageCount & "건 필요.)');"    
    response.write     "self.close();"    
    response.write "</script>"
	dbget.close()	:	response.End
End If

Dim fnGetList, r
	sqlStr = ""
    sqlStr = sqlStr & " SELECT TOP 3 mainimg, '/street/street_brand_sub05.asp?makerid='+makerid+'&sid=l&sidx='+convert(varchar, idx), C.socname, M.title, "
    sqlStr = sqlStr & " CASE   "
    For r = 0 To Ubound(Split(idx,","))
    sqlStr = sqlStr & " When idx="&split(idx,",")(r)&" Then "&split(sort,",")(r)&" "
	Next
    sqlStr = sqlStr & " end as sorting "
    sqlStr = sqlStr & " FROM db_brand.dbo.tbl_street_LookBook_Master AS M "
    sqlStr = sqlStr & " JOIN db_user.dbo.tbl_user_c as C on m.makerid = c.userid "
    sqlStr = sqlStr & " WHERE M.idx in (" & idx & ") "
    sqlStr = sqlStr & " and M.state = '7' "
    sqlStr = sqlStr & " ORDER BY sorting ASC "
    rsget.Open SqlStr, dbget, 1
    vTotalCount = rsget.RecordCount
	fnGetList =	rsget.getRows()

    If CInt(vImageCount) >= CInt(vTotalCount) Then
		dim fso, tFile, BufStr, VarName, DoubleQuat, omd,ix
		VarName = "brand_MainLookBook"
		DoubleQuat = Chr(34)
			BufStr = ""
			BufStr = "var " + VarName + ";" + VbCrlf
    		BufStr = BufStr + VarName + " = " + DoubleQuat + DoubleQuat + ";" + VbCrlf
		For i = 1 to vTotalCount
			BufStr = BufStr + VarName + "+=" + DoubleQuat + "<div class='swiper-slide' style='cursor:pointer;' onclick=location.href='"& wwwUrl & db2Html(fnGetList(1,i-1)) &"'>" + DoubleQuat + VbCrlf
			BufStr = BufStr + VarName + "+=" + DoubleQuat + "	<div class='bInfo'>" + DoubleQuat + VbCrlf
			BufStr = BufStr + VarName + "+=" + DoubleQuat + "		<dl>" + DoubleQuat + VbCrlf
			BufStr = BufStr + VarName + "+=" + DoubleQuat + "			<dt>"& db2Html(fnGetList(2,i-1)) &"</dt>" + DoubleQuat + VbCrlf
			BufStr = BufStr + VarName + "+=" + DoubleQuat + "			<dd><p>"& db2Html(fnGetList(3,i-1)) &"</p></dd>" + DoubleQuat + VbCrlf
			BufStr = BufStr + VarName + "+=" + DoubleQuat + "		</dl>" + DoubleQuat + VbCrlf
			BufStr = BufStr + VarName + "+=" + DoubleQuat + "	</div>" + DoubleQuat + VbCrlf
			BufStr = BufStr + VarName + "+=" + DoubleQuat + "	<div class='pic'><img src='"&db2Html(fnGetList(0,i-1))&"' width='259' height='360' alt='"&db2Html(fnGetList(2,i-1))&"' /></div>" + DoubleQuat + VbCrlf
			BufStr = BufStr + VarName + "+=" + DoubleQuat + "</div>" + DoubleQuat + VbCrlf
		Next
			BufStr = BufStr + "document.write(" + VarName + ");" + VbCrlf
		Set fso = Server.CreateObject("ADODB.Stream")
			fso.Open
			fso.Type = 2
			fso.Charset = "UTF-8"
			fso.WriteText (BufStr)
			fso.SaveToFile savePath & FileName, 2
		Set fso = nothing
	Else
		Response.Write "<script>alert('최소 3개 이상을 등록하셔야 합니다.');window.close();</script>"
		rsget.Close
		dbget.close()
		Response.End
	End If
%>
<script language='javascript'>
alert('OK');
window.close();
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->