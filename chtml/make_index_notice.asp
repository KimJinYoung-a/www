<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/classes/cscenter/boardnoticecls.asp" -->
<%
'###########################################################################################
'
'############# <!-- for dev msg : 팝업 창 사이즈 width=580, height=750 --> ###############
'
'###########################################################################################
dim oNotice,ibb,oNoticeFix, lp
dim retURL, savePath, FileName


'// 종료후 이동페이지 접수
retURL = Request("retURL")
if retURL="" then
	Response.Write "<script language=javascript>alert('전송 오류\n[복귀 페이지 없음]');</script>"
	REsponse.End
end if

'// 공지사항의 문자길이 지정
dim FixntcLength, NorntcLength
FixntcLength = 60
NorntcLength = 60

'// 고정 공지사항 접수

set oNoticeFix = New CBoardNotice
oNoticeFix.FRectFixonly = "Y"
oNoticeFix.FPageSize = 2
oNoticeFix.FCurrPage = 1
oNoticeFix.getNoticsList

'// 일반 공지사항 접수(픽스 공지 포함 5줄)
set oNotice = New CBoardNotice
oNotice.FRectFixonly = "N"
oNotice.FPageSize = 200
oNotice.FCurrPage = 1
oNotice.FScrollCount = 5
oNotice.getNoticsList


dbget.close()


Dim strList, checknew
strList	= ""
'strList	= strList & "<html>" & vbCrLf
'strList	= strList & "<head>" & vbCrLf
'strList	= strList & "<meta http-equiv=""content-type"" content=""text/html; charset=UTF-8"" />" & vbCrLf
'strList	= strList & "<title>텐바이텐 공지사항</title>" & vbCrLf
'strList	= strList & "</head>" & vbCrLf
'strList	= strList & "<body>" & vbCrLf
For ibb=0 To oNoticeFix.FResultCount -1
	If oNoticeFix.FItemList(ibb).IsNewNotics Then checknew = "Y"
Next
For ibb=0 To oNotice.FResultCount -1
	If oNotice.FItemList(ibb).IsNewNotics Then checknew = "Y"
Next

strList	= strList & "<div class=""article notice"">" & vbCrLf

'// ## 일반공지
lp = 0
If checknew="Y" Then
strList	= strList & "	<h2>공지사항 <span class=""icoV18 ico-new""></span></h2>" & vbCrLf
Else
strList	= strList & "	<h2>공지사항 <span class=""icoV18""></span></h2>" & vbCrLf
End If
strList	= strList & "	<a href=""""  onclick=""PopupNewsSel('');return false;"" class=""btn-linkV18 link2"">more <span></span></a>" & vbCrLf
strList	= strList & "		<ul>" & vbCrLf

'// 고정목록
For ibb=0 To oNoticeFix.FResultCount -1
		'strList	= strList & "			<li><a href=""""  onclick=""PopupNewsSel('" & oNoticeFix.FItemList(ibb).Fid & "');return false;"">" & chrbyte(db2html("*" & getNoticeTypeTag(oNoticeFix.FItemList(ibb).Fnoticetype) & "* " & oNoticeFix.FItemList(ibb).Ftitle),FixntcLength,"Y") & "</a></li>" & vbCrLf
		strList	= strList & "			<li><a href=""""  onclick=""PopupNewsSel('" & oNoticeFix.FItemList(ibb).Fid & "');return false;"">" & chrbyte(db2html(oNoticeFix.FItemList(ibb).Ftitle),FixntcLength,"Y") & "</a></li>" & vbCrLf
		lp = lp + 1
Next

'// 일반목록
For ibb=0 To oNotice.FResultCount -1
		strList	= strList & "			<li><a href=""""  onclick=""PopupNewsSel('" & oNotice.FItemList(ibb).Fid & "');return false;"">" & chrbyte(db2html(oNotice.FItemList(ibb).Ftitle),FixntcLength,"Y") & "</a></li>" & vbCrLf
		lp = lp + 1

	'목록은 5개만
	if lp>=3 then Exit For	
Next

strList	= strList & "		</ul>" & vbCrLf
strList	= strList & "	</div>" & vbCrLf

'strList	= strList & "</body>" & vbCrLf
'strList	= strList & "</html>" & vbCrLf

dim fso,tFile
Dim html



' 메인공지 파일 저장
savePath = server.mappath("/chtml/")&"\main\"
FileName = "new_idx_notice.html"

Set fso = Server.CreateObject("ADODB.Stream")
	fso.Open
	fso.Type = 2
	fso.Charset = "UTF-8"
	fso.WriteText (strList)
	fso.SaveToFile savePath & FileName, 2
Set fso = nothing




set oNotice = nothing
set oNoticeFix = nothing


'// 복귀 페이지 이동
response.Redirect retURL

'// 공지 종류에 따른 머릿말 반환
function getNoticeTypeTag(nType)
	Select Case nType
		Case "01"	'전체공지
			getNoticeTypeTag = "notice"
		Case "02"	'상품공지
			getNoticeTypeTag = "notice"
		Case "03"	'이벤트공지
			getNoticeTypeTag = "event"
		Case "04"	'배송공지
			getNoticeTypeTag = "notice"
		Case "05"	'당첨자공지
			getNoticeTypeTag = "event"
		Case "06"	'CultureStation
			getNoticeTypeTag = "CultureStation"
		Case Else
			getNoticeTypeTag = "notice"
	End Select
end Function
%>
