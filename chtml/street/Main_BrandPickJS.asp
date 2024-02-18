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
Dim i , imagecount , idx ,savePath ,FileName ,refurl
idx = requestCheckvar(Request("idx"),44)
idx = left(idx,len(idx)-1)
imagecount = Ubound(Split(idx,",")) + 1
savePath = server.mappath("/chtml/street/js/main/") + "\"
FileName = "brand_MainBranPick.js"
refurl = request.ServerVariables("HTTP_REFERER")

if InStr(refurl,"scm.10x10.co.kr")<1 and InStr(refurl,"webadmin.10x10.co.kr")<1 then
    response.write "<script language=javascript>"
    response.write     "alert('권한이 없습니다.)');"    
    response.write     "self.close();"    
    response.write "</script>"
	dbget.close()	:	response.End
end if

Dim sqlStr, vImageCount, vTotalCount
vImageCount = 4
	
If cint(vImageCount) <> cint(imagecount) Then
    response.write "<script language=javascript>"
    response.write     "alert('적용에 필요한 이미지 수가 일치 하지 않습니다.\n\n(※ " & vImageCount & "건 필요.)');"    
    response.write     "self.close();"    
    response.write "</script>"
	dbget.close()	:	response.End
End If

Dim fnGetList

	sqlStr = ""
	sqlStr = sqlStr & " SELECT TOP 4 B.imagepath, B.linkpath, C.socname "
	sqlStr = sqlStr & " ,H.designis,c.newflg, c.hitflg, c.onlyflg "
	sqlStr = sqlStr & " from db_brand.dbo.tbl_2013brand_image as B "
	sqlStr = sqlStr & " JOIN db_user.dbo.tbl_user_c as C on B.makerid = C.userid "
	sqlStr = sqlStr & " JOIN db_brand.dbo.tbl_street_Hello as H on C.userid = H.makerid "
	sqlStr = sqlStr & " where B.idx in (" & idx & ") "
	sqlStr = sqlStr & " and B.gubun = '2' "
	sqlStr = sqlStr & " ORDER BY B.image_order ASC "
    rsget.Open SqlStr, dbget, 1
    vTotalCount = rsget.RecordCount
	fnGetList =	rsget.getRows()

    If CInt(vImageCount) >= CInt(vTotalCount) Then
		dim fso, tFile, BufStr, VarName, DoubleQuat, omd,ix
		VarName = "brand_MainBrandPick"
		DoubleQuat = Chr(34)
			BufStr = ""
			BufStr = "var " + VarName + ";" + VbCrlf
    		BufStr = BufStr + VarName + " = " + DoubleQuat + DoubleQuat + ";" + VbCrlf
		For i = 1 to vTotalCount
    		BufStr = BufStr + VarName + "+=" + DoubleQuat + "<li>" + DoubleQuat + VbCrlf
    		BufStr = BufStr + VarName + "+=" + DoubleQuat + "	<div class='pic'>" + DoubleQuat + VbCrlf
			if instr(fnGetList(0,i-1),"http://")>0 then
    			BufStr = BufStr + VarName + "+=" + DoubleQuat + "	<a href='"& wwwUrl & db2Html(fnGetList(1,i-1)) &"&gaparam=street_brandpick_"&i&"'><img src='" & db2Html(fnGetList(0,i-1)) &"' alt='브랜드Pick"&i&"' /></a>" + DoubleQuat + VbCrlf
			else
				BufStr = BufStr + VarName + "+=" + DoubleQuat + "	<a href='"& wwwUrl & db2Html(fnGetList(1,i-1)) &"&gaparam=street_brandpick_"&i&"'><img src='" & staticImgUrl & "/brandstreet/main/" & db2Html(fnGetList(0,i-1)) &"' alt='브랜드Pick"&i&"' /></a>" + DoubleQuat + VbCrlf
			end if
''		If fnGetList(5, i-1) = "Y" Then
''			BufStr = BufStr + VarName + "+=" + DoubleQuat + "	<p class='evtIco tagRed'>BEST</p>" + DoubleQuat + VbCrlf
''		ElseIf fnGetList(6, i-1) = "Y" Then
''			BufStr = BufStr + VarName + "+=" + DoubleQuat + "	<p class='evtIco tagOnly'>ONLY</p>" + DoubleQuat + VbCrlf
''		ElseIf fnGetList(4, i-1) = "Y" Then
''			BufStr = BufStr + VarName + "+=" + DoubleQuat + "	<p class='evtIco tagNew'>NEW</p>" + DoubleQuat + VbCrlf
''		End If
			BufStr = BufStr + VarName + "+=" + DoubleQuat + "	</div>" + DoubleQuat + VbCrlf
			BufStr = BufStr + VarName + "+=" + DoubleQuat + "	<div class='txt'>" + DoubleQuat + VbCrlf
			BufStr = BufStr + VarName + "+=" + DoubleQuat + "		<p class='brandPdt'><a href='"& wwwUrl & db2Html(fnGetList(1,i-1)) &"&gaparam=street_brandpick_"&i&"'>"&db2Html(fnGetList(2,i-1))&"</a></p>" + DoubleQuat + VbCrlf
		If fnGetList(3, i-1) <> "" Then
			BufStr = BufStr + VarName + "+=" + DoubleQuat + "		<p class='cmt'><em></em><span>디자인은 "&chrbyte(db2Html(fnGetList(3,i-1)),48,"Y")&"</span></p>" + DoubleQuat + VbCrlf
		End If
    		BufStr = BufStr + VarName + "+=" + DoubleQuat + "	</div>" + DoubleQuat + VbCrlf
    		BufStr = BufStr + VarName + "+=" + DoubleQuat + "</li>" + DoubleQuat + VbCrlf
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
		Response.Write "<script>alert('Hello에 입력하신 브랜드가 있는 지 확인하세요');window.close();</script>"
		rsget.Close
		dbget.close()
		Response.End
	End If
%>
<script type="text/javascript">
alert('PC OK');
<% if application("Svr_Info")="Dev" then %>
location.href="http://testm.10x10.co.kr/chtml/street/Main_BrandPickJS_mobile.asp?idx=<%=idx%>&imagecount=<%=imagecount%>";
<% else %>
location.href="http://m1.10x10.co.kr/chtml/street/Main_BrandPickJS_mobile.asp?idx=<%=idx%>&imagecount=<%=imagecount%>";
<% end if %>
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->