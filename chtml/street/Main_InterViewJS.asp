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
Dim i , imagecount , idx ,savePath ,FileName ,refurl, sort
idx = requestCheckvar(Request("idx"),33)
sort = Request("sort")
idx = left(idx,len(idx)-1)
sort= left(sort,len(sort)-1)
imagecount = Ubound(Split(idx,",")) + 1
savePath = server.mappath("/chtml/street/js/main/") + "\"
FileName = "brand_MainInterView.js"
refurl = request.ServerVariables("HTTP_REFERER")


if InStr(refurl,"scm.10x10.co.kr")<1 and InStr(refurl,"webadmin.10x10.co.kr")<1 then
    response.write "<script language=javascript>"
    response.write     "alert('권한이 없습니다.)');"    
    response.write     "self.close();"    
    response.write "</script>"
	dbget.close()	:	response.End
end if

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
    sqlStr = sqlStr & " SELECT mainimg, '/street/street_brand_sub02.asp?makerid='+makerid+'&sid=i&sidx='+convert(varchar, mainidx) "
    sqlStr = sqlStr & " ,title, startdate, comment, "
    sqlStr = sqlStr & " CASE   "
    For r = 0 To Ubound(Split(idx,","))
    sqlStr = sqlStr & " When mainidx="&split(idx,",")(r)&" Then "&split(sort,",")(r)&" "
	Next
	sqlStr = sqlStr & " end as sorting "
    sqlStr = sqlStr & " FROM db_brand.dbo.tbl_street_interview_main "
    sqlStr = sqlStr & " WHERE mainidx in (" & idx & ") "
    sqlStr = sqlStr & " ORDER BY sorting ASC "
    rsget.Open SqlStr, dbget, 1
    vTotalCount = rsget.RecordCount
	fnGetList =	rsget.getRows()

    If CInt(vImageCount) >= CInt(vTotalCount) Then
		dim fso, tFile, BufStr, VarName, DoubleQuat, omd,ix
		VarName = "brand_MainInterView"
		DoubleQuat = Chr(34)
			BufStr = ""
			BufStr = "var " + VarName + ";" + VbCrlf
    		BufStr = BufStr + VarName + " = " + DoubleQuat + DoubleQuat + ";" + VbCrlf
		For i = 1 to vTotalCount
			BufStr = BufStr + VarName + "+=" + DoubleQuat + "<div class='swiper-slide' id='a0"&i&"' onclick=location.href='"& wwwUrl & db2Html(fnGetList(1,i-1)) &"&gaparam=street_interview_"&i&"'>" + DoubleQuat + VbCrlf
			BufStr = BufStr + VarName + "+=" + DoubleQuat + "	<p><img src='"&db2Html(fnGetList(0,i-1))&"' width='442' height='360' alt='I am a Designer #8' /></p>" + DoubleQuat + VbCrlf
			BufStr = BufStr + VarName + "+=" + DoubleQuat + "	<dl class='account'>" + DoubleQuat + VbCrlf
			BufStr = BufStr + VarName + "+=" + DoubleQuat + "		<dt>"& db2Html(fnGetList(2,i-1)) &"</dt>" + DoubleQuat + VbCrlf
			BufStr = BufStr + VarName + "+=" + DoubleQuat + "		<dd>" + DoubleQuat + VbCrlf
			'BufStr = BufStr + VarName + "+=" + DoubleQuat + "			<p class='date'><strong>"&FormatDate(fnGetList(3,i-1),"0000.00.00")&"</strong></p>" + DoubleQuat + VbCrlf
			BufStr = BufStr + VarName + "+=" + DoubleQuat + "			<p>"&nl2br(db2Html(fnGetList(4,i-1)))&"</p>" + DoubleQuat + VbCrlf
			BufStr = BufStr + VarName + "+=" + DoubleQuat + "		</dd>" + DoubleQuat + VbCrlf
			BufStr = BufStr + VarName + "+=" + DoubleQuat + "	</dl>" + DoubleQuat + VbCrlf
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
	    rsget.Close
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