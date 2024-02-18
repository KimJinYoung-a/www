<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'==========================================================================
'	Description: 나의 기념일 처리, 이영진
'	History: 2009.04.16
'==========================================================================
	Response.Expires = -1440
%>
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbHelper.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/membercls/clsMyAnniversary.asp" -->
<%
Dim mode		: mode		= req("mode","INS")
Dim i, PKID
Dim obj	: Set obj = new clsMyAnniversary

Dim vIdx , vSetDay , vDayType , vTitle , vMemo , vAlarmcycle

vIdx			= req("idx","")
vSetDay 		= req("setDay1","") & "-" & req("setDay2","") & "-" & req("setDay3","")
vDayType 		= req("dayType","S")
vTitle 			= req("title","")
vMemo 			= req("memo","")
vAlarmcycle		= req("alarmcycle","")

'// 크로스 사이트 스크립팅 방지
If checkNotValidHTML(vTitle) Then
	response.write "<script>alert('HTML태그 및 스크립트는 입력하실 수 없습니다.');history.back();</script>"
	response.End
End If

If checkNotValidHTML(vMemo) Then
	response.write "<script>alert('HTML태그 및 스크립트는 입력하실 수 없습니다.');history.back();</script>"
	response.End
End If

obj.GetData ""

obj.Item.idx				= vIdx
obj.Item.setDay				= vSetDay
obj.Item.dayType			= vDayType
obj.Item.title				= stripHTML(vTitle)
obj.Item.memo				= stripHTML(vMemo)
obj.Item.alarmcycle			= vAlarmcycle

Dim errCode
If mode = "DEL" Or mode = "ALERT" Then	' 삭제, 사용
	PKID = Split(req("idx",""),",")
	For i = 0 To UBound(PKID)
		obj.Item.idx		= PKID(i)
		obj.FrontProcData mode
	Next
Else					' 등록,수정
	errCode = obj.FrontProcData (mode)
End If

Set obj = Nothing

If errCode = -1 Then
	mode = "NULL"
ElseIf errCode <> 0 Then
	mode = "BACK"
End If

%>
<script>
	<%if mode = "ALERT" then %>
		window.close();
	<%elseif mode = "DEL" then%>
		alert("삭제되었습니다.");
		location.href = "/my10x10/MyAnniversary/MyAnniversaryList.asp";
	<%elseif mode = "UPD" then%>
		alert("수정되었습니다.");
		opener.location.href = "/my10x10/MyAnniversary/MyAnniversaryList.asp";
		window.close();
	<%elseif mode = "INS" then%>
		alert("등록되었습니다.");
		opener.location.href = "/my10x10/MyAnniversary/MyAnniversaryList.asp";
		window.close();
	<%elseif mode = "NULL" then	' 양력일자 없음%>
		alert("선택하신 음력일자의 양력일자가 없습니다.");
		history.back();
	<%elseif mode = "NULL" then	' 오류발생%>
		alert("처리 중 오류가 발생하였습니다.");
		history.back();
	<%end if%>
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->