<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<%
'###############################################
' PageName : main_manager.asp
' Discription : 사이트 메인 관리
' History : 2008.04.11 허진원 : 실서버에서 이전
'			2009.04.19 한용민 2009에 맞게 수정
'###############################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/offshop/flash/offshopmain_contents_managecls.asp" -->

<%

'' 관리자 확정시 Data 작성. 
dim i
dim poscode
dim savePath, FileName, refip
	poscode = requestCheckVar(Request("poscode"),32)

	'// 생성파일 경로 및 파일명 선언
	savePath = server.mappath("/offshop/flash/") + "\"
	FileName = "point1010mainflash_" + CStr(poscode) + ".txt"
	
	'// 유입경로 확인
	refip = request.ServerVariables("HTTP_REFERER")
	
	if (InStr(refip,"10x10.co.kr")<1) then
		response.write "not valid Referer"
	    response.end
	end if
	
	if (Len(poscode)<1) then
		response.write "not valid cd"
		response.end
	end if

dim ocontents, ocontentsCode

'// 적용코드 확인
set ocontentsCode = new CMainContentsCode
	ocontentsCode.FRectPoscode = poscode
	ocontentsCode.GetOneContentsCode

if (ocontentsCode.FResultCount<1) then
    response.write "<script language=javascript>alert('유효한 적용코드가 아닙니다.');self.close();</script>"
	response.end
end if

'// 메인 데이터 접수
set ocontents = New CMainContents
	ocontents.FRectPoscode = poscode
	ocontents.FPageSize = ocontentsCode.FOneItem.FuseSet
	ocontents.frectorderidx = "main"
	ocontents.GetMainContentsValidList

if (ocontents.FResultCount<1) then
    response.write "<script language=javascript>alert('적용할 데이터가 없습니다.');self.close();</script>"
	response.end
elseif (ocontents.FResultCount<ocontentsCode.FOneItem.FuseSet) then
    response.write "<script language=javascript>alert('적용에 필요한 데이터가 부족합니다.\n\n(※ 최소 " & ocontentsCode.FOneItem.FuseSet & "건 필요. 현재 " & ocontents.FResultCount & "건 등록됨)');</script>"
	response.end
end if

dim fso, tFile, BufStr

'// 파일 생성
if ocontents.FResultCount>0 then
    Set fso = CreateObject("Scripting.FileSystemObject")
    Set tFile = fso.CreateTextFile(savePath & FileName )
    BufStr = ""
    
		for i=0 to ocontents.FResultCount-1 

			BufStr = BufStr & "&img" & Format00(2,i+1) & "=" & ocontents.FItemList(i).GetImageUrl &"&q="& replace(FormatDateTime(Now(), 2),"-","")&replace(FormatDateTime(Now(), 4),":","") & "&" & VbCrlf
			BufStr = BufStr & "&link" & Format00(2,i+1) & "=" & Replace(ocontents.FItemList(i).Flinkurl,"&","%26") & "&" & VbCrlf
        next
    
    tFile.Write BufStr
    tFile.Close
    
    Set tFile = Nothing
    Set fso = Nothing

end if
%>
	<script language='javascript'>
	alert("[<%=ocontentsCode.FOneItem.Fposname%>]에 사용될 \n\n\'<%=FileName%>\'파일 생성 완료!");
	self.close();
	</script>
	
<%
set ocontentsCode = Nothing
set ocontents = Nothing
%>

<!-- #include virtual="/lib/db/dbclose.asp" -->