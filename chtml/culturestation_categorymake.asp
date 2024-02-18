<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
'###########################################################
'	History	:  2010.04.08 한용민 생성
'              2013.08.30 허진원 : 2013리뉴얼
'	Description : culturestation 왼쪽 메뉴 카테고리 생성
'###########################################################
%>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- include virtual="/lib/classes/item/iteminfoCls.asp" -->
<!-- #include virtual="/lib/classes/culturestation/culturestationCls.asp" -->

<%
dim savePath, FileName, refip,evt_type , evt_code , DoubleQuat , i ,fso, tFile, BufStr
dim arrTypeNm, arrTypeCss

	arrTypeNm = split("느껴봐,읽어봐,들어봐",",")
	arrTypeCss = split("feeling,reading,listening",",")

	evt_type = request("evt_type")
	evt_code = request("evt_code")	
	evt_code = left(evt_code,len(evt_code)-1)

'//이벤트 구분 체크	
if evt_type = "" or evt_code = "" then
	response.write "<script>"
	response.write "alert('생성될 이벤트 구분이 없습니다.');"
	response.write "self.close();"
	response.write "</script>"
	dbget.close()	:	response.End
end if		

'savePath = server.mappath("/chtml/culturestation") + "/"		'기본경로 생성
' 메인공지 파일 저장
savePath = server.mappath("/chtml/")&"\culturestation\"
DoubleQuat = Chr(34)

if evt_type = 0 then 	

	FileName = "culturestation_category_"&evt_type+1&".asp"			'느껴봐파일명 
elseif evt_type = 1 then 

	FileName = "culturestation_category_"&evt_type+1&".asp"			'읽어봐파일명		
elseif evt_type = 2 then 

	FileName = "culturestation_category_"&evt_type+1&".asp"			'들어봐파일명
end if

dim oevtleft
	set oevtleft = new cevent_list
	oevtleft.frectevt_type = evt_type
	oevtleft.frectevt_code =  evt_code
	oevtleft.frectevent_limit = 50
	oevtleft.fevent_make()
	
'// 파일 생성

    BufStr = ""

	BufStr = BufStr &"<" & chr(37) & "'본 파일은 자동생성 되는 파일입니다. 절대 수작업을 통해 수정하지 마세요!" & chr(37) & ">" & vbCrLf
	BufStr = BufStr &"<!-- #include virtual=""/lib/util/commlib.asp"" -->" & vbCrLf
	BufStr = BufStr &"<" & chr(37) & vbCrLf
	BufStr = BufStr &"dim evt_code" & vbCrLf
	BufStr = BufStr &"evt_code = getNumeric(requestCheckVar(request(""evt_code""),5))" & vbCrLf
	BufStr = BufStr & chr(37) & ">" & vbCrLf

	BufStr = BufStr &"<li class=""" & arrTypeCss(evt_type) & """><a href="""" class=""ico""><span>" & arrTypeNm(evt_type) & " (" & oevtleft.FTotalCount & ")</span></a>" & vbCrLf
	BufStr = BufStr &"	<ul class=""submenu"">" & vbCrLf

	if 	oevtleft.FTotalCount > 0 then
		for i = 0 to oevtleft.FTotalCount - 1 	
			BufStr = BufStr &"		<li><a href=""culturestation_event.asp?evt_code=" & oevtleft.fitemlist(i).fevt_code & """ <" &chr(37)& "=chkIIF(evt_code=""" & oevtleft.fitemlist(i).fevt_code & """,""class='current'"","""")" &chr(37)&"> onclick=""TnGotocultureEvenMain(" & oevtleft.fitemlist(i).fevt_code & ");"">" & chrbyte(oevtleft.fitemlist(i).fevt_name,25,"Y") & "</a></li>" & vbCrLf
		next
	else
		BufStr = BufStr &"		<li><a href="""" onclick=""return false;"">진행중인 이벤트가 없습니다</a></li>" & vbCrLf
	end if

	BufStr = BufStr &"	</ul>" & vbCrLf
	BufStr = BufStr &"</li>" & vbCrLf


Set fso = Server.CreateObject("ADODB.Stream")
	fso.Open
	fso.Type = 2
	fso.Charset = "UTF-8"
	fso.WriteText (BufStr)
	fso.SaveToFile savePath & FileName, 2
Set fso = nothing

	set oevtleft = nothing
%>


<script language='javascript'>
	alert("OK");
	self.close();
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->

