<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'###########################################################
' Description :  브랜드스트리트
' History : 2013.08.29 한용민 생성
'###########################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->

<% 
dim i, imagecount ,idx , savePath, FileName, sqlStr, vTotalCount, vImageCount
dim fso, tFile, BufStr, VarName, DoubleQuat, omd,ix, arridx, makerid
	makerid = Request("makerid")
	idx = Request("idx")
	idx = left(idx,len(idx)-1)
	imagecount = request("imagecount")
	savePath = server.mappath("/chtml/street/js/tenbytenand/") + "\"

vImageCount=0

if imagecount = "" or idx = "" then
	response.write "<script type='text/javascript'>"
	response.write "	alert('이미지수["&imagecount&"]나 선택한 인덱스번호["&idx&"]가 없습니다.');"
	response.write "	self.close();"
	response.write "</script>"
	dbget.close()	:	response.End
end if

dim refip
	refip = request.ServerVariables("HTTP_REFERER")

arridx = split(idx,",")

for i = 0 to ubound(arridx)
	vImageCount = vImageCount + 1
next

if trim(vImageCount) <> trim(imagecount) then
    response.write "<script type='text/javascript'>"
    response.write     "alert('적용에 필요한 이미지 수가 일치 하지 않습니다.\n\n(※ " & imagecount & "건 필요.)');"    
    response.write     "self.close();"    
    response.write "</script>"
	dbget.close()	:	response.End
end if

FileName = "tenbytenand_" & makerid & ".js"
VarName = "vtenbytenand"
DoubleQuat = Chr(39)

sqlStr = "select"
sqlStr = sqlStr & " idx, makerid, flag, imgurl, linkurl, playurl, regdate, sortNO"
sqlStr = sqlStr & " , registerID, isusing"
sqlStr = sqlStr & " from db_brand.dbo.tbl_2013street_TENBYTEN"
sqlStr = sqlStr & " where isusing='Y' and idx in (" & idx & ")"
sqlStr = sqlStr & " order by sortNO asc"

'response.write sqlStr & "<Br>"
rsget.Open SqlStr, dbget, 1

vTotalCount = rsget.RecordCount


If not rsget.EOF  then
	if clng(imagecount) = clng(vTotalCount) then
	
	    BufStr = ""    
	    BufStr = "var " + VarName + ";" + VbCrlf
	    BufStr = BufStr + VarName + " = " + DoubleQuat + DoubleQuat + ";" + VbCrlf
		BufStr = BufStr + VarName + "+=" + DoubleQuat + "<!--본 파일은 자동생성 되는 파일입니다. 절대 수작업을 통해 수정하지 마세요!-->" + DoubleQuat + VbCrlf   
	
		BufStr = BufStr + VarName + "+=" + DoubleQuat + "<div class=""linkList"">" + DoubleQuat + VbCrlf   
		BufStr = BufStr + VarName + "+=" + DoubleQuat + "	<ul>" + DoubleQuat + VbCrlf   
		
		i=0
		rsget.Movefirst
		Do until rsget.EOF
			if i="0" then
				BufStr = BufStr + VarName + "+=" + DoubleQuat + "		<li class=""current"" id=""brImg0"&i+1&""">"&i+1&"</li>" + DoubleQuat + VbCrlf
			else
				BufStr = BufStr + VarName + "+=" + DoubleQuat + "		<li id=""brImg0"&i+1&""">"&i+1&"</li>" + DoubleQuat + VbCrlf
			end if
			
			i=i+1
			rsget.MoveNext
		Loop
	
		BufStr = BufStr + VarName + "+=" + DoubleQuat + "	</ul>" + DoubleQuat + VbCrlf   
		BufStr = BufStr + VarName + "+=" + DoubleQuat + "</div>" + DoubleQuat + VbCrlf
		
		i=0
		rsget.Movefirst
		Do until rsget.EOF
			if rsget("flag")="2" then
				BufStr = BufStr + VarName + "+=" + DoubleQuat + "<div class=""bnrArea"" id=""vbrImg0"&i+1&"""><iframe src="""& db2html(rsget("playurl")) &""" width=""1140"" height=""100%"" frameborder=""0"" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe></div>" + DoubleQuat + VbCrlf   
			else
				BufStr = BufStr + VarName + "+=" + DoubleQuat + "<div class=""bnrArea"" id=""vbrImg0"&i+1&"""><img src="""& uploadUrl &"/brandstreet/TENBYTEN/"& db2html(rsget("imgurl")) &""" alt="""& rsget("makerid") &""" /></div>" + DoubleQuat + VbCrlf   		
			end if
			
			i=i+1
			rsget.MoveNext
		Loop

	    BufStr = BufStr + "document.write(" + VarName + ");" + VbCrlf
		
		'response.write BufStr & "<BR>"

		Set fso = Server.CreateObject("ADODB.Stream")
			fso.Open
			fso.Type = 2
			fso.Charset = "UTF-8"
			fso.WriteText (BufStr)
			fso.SaveToFile savePath & FileName, 2
		Set fso = nothing	
	    rsget.Close
	else
	    response.write "<script type='text/javascript'>"
	    response.write     "alert('Need. IMAGE COUNT "&imagecount&"');"
	    response.write     "self.close();"    
	    response.write "</script>"
		rsget.Close		:	dbget.close()	:	response.End	
	end if
end if

Response.Write "<script type='text/javascript'>"
Response.Write "	alert('OK');"
Response.Write "	window.close();"
Response.Write "</script>"
%>

<!-- #include virtual="/lib/db/dbclose.asp" -->