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
' Discription : pc_main_multievent_banner // cache DB경유
' History : 2018-03-15 이종화 생성
'#######################################################
Dim intI
Dim sqlStr , rsMem , arrList
Dim gaParam : gaParam = "&gaparam=main_event_" '//GA 체크 변수

'//DB 시간 타이머 00시부터 00시 5분 사이에는 DB 캐쉬 1분에 한번 읽기
Dim cTime , dummyName
If timer > 10 And Cint(timer/60) < 6 Then
	cTime = 60*1
	dummyName = "MTBAN_"&Cint(timer/60)
Else
	cTime = 60*5
	dummyName = "MTBAN"
End If

sqlStr = "EXEC db_sitemaster.dbo.usp_Ten_pcmain_multievent "
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
	Dim linkurl , evt_mo_listbanner , maincopy , subcopy , coupon_per , sale_per , alink , amplitudemultieventval , tag_only
	Dim viewHtml(3)
	Dim ii : ii = 0
	

	For intI = 0 To ubound(arrlist,2)

		linkurl				= arrlist(0,intI)
		evt_mo_listbanner	= arrlist(1,intI)
		maincopy			= arrlist(2,intI)
		subcopy				= arrlist(3,intI)
		coupon_per			= arrlist(4,intI)
		sale_per			= arrlist(5,intI)
		tag_only			= arrlist(6,intI)
	
		alink = linkurl & gaParam & intI+1

		amplitudemultieventval = "{'MultiEventNumber':'"&intI&"'}" 
		amplitudemultieventval = Replace(amplitudemultieventval, "'", "\""")

		If intI = 4 Or intI = 8 Or intI = 12 Then ii = ii + 1

		If intI = 0 Or intI = 4 Or intI = 8 Or intI = 12 Then
			viewHtml(ii) = viewHtml(ii) & "<div class='section exhibition'><div class='inner-cont'><div class='list-card'><ul>"
		End if

			viewHtml(ii) = viewHtml(ii) & "<li><a href='"& alink &"' onclick=AmpEventMultiEvent(JSON.parse('"& amplitudemultieventval &"'));fnAmplitudeEventMultiPropertiesAction('click_mainmultievent','indexnumber|banner','"&intI+1&"|"&linkurl&"');>"
			viewHtml(ii) = viewHtml(ii) & "<div class='thumbnail'>"& chkiif(tag_only="Y","<p class='tagV18 t-only'><span>ONLY<br />10X10</span></p>","") &"<img src='"& evt_mo_listbanner &"' alt='' /></div>"
			viewHtml(ii) = viewHtml(ii) & "<div class='desc'><p class='headline'><span class='ellipsis'>"& maincopy &"</span>"

			If sale_per <> "" Then
				viewHtml(ii) = viewHtml(ii) & "<b class='discount color-"& chkiif(sale_per<>"","red","green")&"'>"& sale_per &"</b>"
			End If
			If coupon_per<> "" Then
			viewHtml(ii) = viewHtml(ii) & "</p><p class='subcopy'><b class='discount color-green'>쿠폰 "&coupon_per&"</b>"& subcopy &"</p></div></a></li>"
			Else
			viewHtml(ii) = viewHtml(ii) & "</p><p class='subcopy'>"& subcopy &"</p></div></a></li>"
			End If
		If intI = 3 Or intI = 7 Or intI = 11 Or intI = ubound(arrlist,2) Then
			viewHtml(ii) = viewHtml(ii) & "</ul></div></div>"
			viewHtml(ii) = viewHtml(ii) & "<script>function AmpEventMultiEvent(jsonval)	{ AmplitudeEventSend('MainMultiEvent', jsonval, 'eventProperties'); }</script>"
			viewHtml(ii) = viewHtml(ii) & "</div>"
		End If
	Next
End If

If request.Cookies("pcmain")("mevt") = "1" Then
	Response.write viewHtml(0)
ElseIf request.Cookies("pcmain")("mevt") = "2" Then
	Response.write viewHtml(1)
ElseIf request.Cookies("pcmain")("mevt") = "3" Then
	Response.write viewHtml(2)
ElseIf request.Cookies("pcmain")("mevt") = "4" Then
	Response.write viewHtml(3)
End If

on Error Goto 0
%>

<!-- #include virtual="/lib/db/dbclose.asp" -->