<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
response.charset = "utf-8"
Session.Codepage = 65001
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<%
'#######################################################
' Discription : pc_main_gif // cache DB경유
' History : 2018-03-06 이종화 생성
'#######################################################
Dim poscode , intI
Dim sqlStr , rsMem , arrList
Dim gaParam : gaParam = "&gaparam=main_gif" '//GA 체크 변수

poscode = 713

'//DB 시간 타이머 00시부터 00시 5분 사이에는 DB 캐쉬 1분에 한번 읽기
Dim cTime , dummyName
If timer > 10 And Cint(timer/60) < 6 Then
	cTime = 60*1
	dummyName = "GIFIMG_"&Cint(timer/60)
Else
	cTime = 60*5
	dummyName = "GIFIMG"
End If

IF poscode = "" THEN
	Call Alert_Return("잘못된 접근입니다.")
	response.End
END IF

sqlStr = "db_sitemaster.dbo.[usp_Ten_pcmain_bannermanage] @poscode ="&poscode
'Response.write sqlStr

set rsMem = getDBCacheSQL(dbget, rsget, dummyName, sqlStr, cTime)
IF Not (rsMem.EOF OR rsMem.BOF) THEN
	arrList = rsMem.GetRows
END IF
rsMem.close

on Error Resume Next
%>

<%
If IsArray(arrList) Then
	Dim img , link , altname , alink

	For intI = 0 To ubound(arrlist,2)

		img				= staticImgUrl & "/main/" + db2Html(arrlist(0,intI))
		link			= db2Html(arrlist(1,intI))
		altname			= db2Html(arrlist(4,intI))

		alink = link & gaparamchk(link,gaParam)
%>
	<div class="gif-bnr">
		<a href="<%=alink%>" onclick="fnAmplitudeEventMultiPropertiesAction('click_maingifbanner','','');"><img src="<%=img%>" alt="<%=altname%>" /></a>
		<script>function AmpEventGif(jsonval){AmplitudeEventSend('MainGifBanner', jsonval, 'eventProperties');}</script>
	</div>
<%
	Next
End If
on Error Goto 0
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->