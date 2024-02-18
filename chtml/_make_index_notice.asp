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
FixntcLength = 31
NorntcLength = 44

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


Dim strList
strList	= ""
'strList	= strList & "<html>" & vbCrLf
'strList	= strList & "<head>" & vbCrLf
'strList	= strList & "<meta http-equiv=""content-type"" content=""text/html; charset=UTF-8"" />" & vbCrLf
'strList	= strList & "<title>텐바이텐 공지사항</title>" & vbCrLf
'strList	= strList & "</head>" & vbCrLf
'strList	= strList & "<body>" & vbCrLf

strList	= strList & "<div class=""mainNoticeV15"">" & vbCrLf

'// ## 일반공지
lp = 0
strList	= strList & "	<h2><img src=""http://fiximage.10x10.co.kr/web2015/main/tit_notice.gif"" alt=""NOTICE"" /></h2>" & vbCrLf
strList	= strList & "		<ul class=""mainBbsList"">" & vbCrLf

'// 고정목록
For ibb=0 To oNoticeFix.FResultCount -1
		strList	= strList & "			<li><a href=""""  onclick=""PopupNewsSel('" & oNoticeFix.FItemList(ibb).Fid & "');return false;"">" & chrbyte(db2html("*" & getNoticeTypeTag(oNoticeFix.FItemList(ibb).Fnoticetype) & "* " & oNoticeFix.FItemList(ibb).Ftitle),FixntcLength,"Y") & "</a>"
		If oNoticeFix.FItemList(ibb).IsNewNotics Then strList = strList & " <img src=""http://fiximage.10x10.co.kr/web2015/main/ico_n.png"" alt=""NEW"" />"
		strList	= strList & "</li>" & vbCrLf
		lp = lp + 1
Next

'// 일반목록
For ibb=0 To oNotice.FResultCount -1
		strList	= strList & "			<li><a href=""""  onclick=""PopupNewsSel('" & oNotice.FItemList(ibb).Fid & "');return false;"">" & chrbyte(db2html(oNotice.FItemList(ibb).Ftitle),FixntcLength,"Y") & "</a>"
		If oNotice.FItemList(ibb).IsNewNotics Then strList = strList & " <img src=""http://fiximage.10x10.co.kr/web2013/cscenter/ico_new.gif"" alt=""NEW"" />"
		strList	= strList & "</li>" & vbCrLf
		lp = lp + 1

	'목록은 5개만
	if lp>=5 then Exit For	
Next

strList	= strList & "		</ul>" & vbCrLf
strList	= strList & "		<a href="""" onclick=""PopupNewsSel('');return false;"" class=""more btn btnS4 btnGry2""><em class=""fn whiteArr01"">MORE</em></a>" & vbCrLf
strList	= strList & "	</div>" & vbCrLf

'strList	= strList & "</body>" & vbCrLf
'strList	= strList & "</html>" & vbCrLf

dim fso,tFile
Dim html



' 메인공지 파일 저장
savePath = server.mappath("/chtml/")&"\main\"
FileName = "idx_notice.html"

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
