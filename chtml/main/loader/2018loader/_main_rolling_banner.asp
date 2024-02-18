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
' Discription : pc_main_rolling // cache DB경유
' History : 2018-03-05 이종화 생성
'#######################################################
Dim poscode , intI ,intJ
Dim sqlStr , rsMem , arrList
Dim gaParam : gaParam = "&gaparam=main_mainroll_" '//GA 체크 변수
Dim CtrlDate : CtrlDate = now()

poscode = 710

'//DB 시간 타이머 00시부터 00시 5분 사이에는 DB 캐쉬 1분에 한번 읽기
Dim cTime , dummyName
If timer > 10 And Cint(timer/60) < 6 Then
	cTime = 60*1
	dummyName = "PBIMG_"&Cint(timer/60)
Else
	cTime = 60*5
	dummyName = "PBIMG"
End If

IF poscode = "" THEN
	Call Alert_Return("잘못된 접근입니다.")
	response.End
END IF

sqlStr = "db_sitemaster.dbo.[usp_Ten_pcmain_bannermanage_new] @poscode="&poscode
'Response.write sqlStr

set rsMem = getDBCacheSQL(dbget, rsget, dummyName, sqlStr, cTime)
IF Not (rsMem.EOF OR rsMem.BOF) THEN
	arrList = rsMem.GetRows
END IF
rsMem.close

on Error Resume Next
%>
<script>
	function AmpEventRolling(jsonval)
	{
		AmplitudeEventSend('MainRolling', jsonval, 'eventProperties');
	}
</script>
<%
Function addtag(val1,val2)
	Select Case val1
		Case 2
			addtag = " <span class='labelV18 label-red'><b>"&val2&"</b></span>"
		Case 3
			addtag = " <span class='labelV18 label-green'><b>쿠폰 "&val2&"</b></span>"
		Case 4
			addtag = " <span class='labelV18 label-blue'><b>GIFT</b></span>"
		Case 5
			addtag = " <span class='labelV18 label-blue'><b>1+1</b></span>"
		Case 6
			addtag = " <span class='labelV18 label-black'><b>런칭</b></span>"
		Case 7
			addtag = " <span class='labelV18 label-black'><b>참여</b></span>"
		Case Else
			addtag = ""
	End select
End Function

intJ = 0
If IsArray(arrList) Then
%>
<div class="section main-banner">
	<div class="rolling">
	<%'!-- for dev msg : 어드민에서 받을것 - 1.배경이미지(wide,fix)/2.연결링크값/3.텍스트(없을수도 있음)/4.배경컬러(좌,우) --%>
<%
	Dim img , link , startdate ,  enddate , altname , maincopy , maincopy2 , subcopy , etctag , etctext , leftbgcode , rightbgcode , bantype, ftcolor, evt_code, img2, salePer, saleCPer, img2Link 'wide fixed
	Dim alink
	Dim amplituderollingval

	For intI = 0 To ubound(arrlist,2)

		img				= "/imgstatic/main/" + db2Html(arrlist(0,intI))
		link			= db2Html(arrlist(1,intI))
		startdate		= arrlist(2,intI)
		enddate			= arrlist(3,intI)
		altname			= db2Html(arrlist(4,intI))
		maincopy		= db2Html(arrlist(5,intI))
		maincopy2		= db2Html(arrlist(6,intI))
		subcopy			= db2Html(arrlist(7,intI))
		etctag			= db2Html(arrlist(8,intI))
		etctext			= db2Html(arrlist(9,intI))
		bantype			= db2Html(arrlist(10,intI))
		ftcolor			= arrlist(13,intI)
		evt_code		= arrlist(14,intI)
		img2				= db2Html(arrlist(15,intI))
		img2Link		= staticImgUrl & "/main2/" + db2Html(arrlist(15,intI))
		salePer			= arrlist(16,intI)
		saleCPer		= arrlist(17,intI)

		alink = link & gaparamchk(link,gaParam) & (intJ+1)

		amplituderollingval = "{'RollingNumber':'"&intI&"'}" 
		amplituderollingval = Replace(amplituderollingval, "'", "\""")
%>
		<% If img2 <> "" And evt_code<>"0" Then %>
			<div class="rolling-item <%=chkiif(bantype="wide","bg-wide","")%> spc-weekend" style="background-image:url(<%=img%>);">
				<a href="<%=alink%>"  onclick=AmpEventRolling(JSON.parse('<%=amplituderollingval%>'));>
					<div class="desc <%=chkiif(ftcolor=0,"color-black","color-white")%>"">
						<div class="copy">
							<p><%=maincopy%>
								<% If maincopy2<> "" Then %>
								<br/><%=maincopy2%>
								<% End If %>
							</p>
						</div>
						<p class="subcopy"><%=subcopy%></p>
					</div>
					<% If img2 <> "" Then %>
					<div class="text-img">
						<img src="<%=img2Link%>" alt="" />
						<p class="discount"><% If salePer<>"" Then %><b class="color-red">~<%=salePer%>%</b><% End If %><% If saleCPer<>"" Then %><b class="color-green"><% If saleCPer > 100 Then %>쿠폰<% Else %><%=saleCPer%>%<% End If %></b><% End If %></p>
					</div>
					<% End If %>
				</a>
				<div class="bg-color left" style="background-color:#<%=arrlist(11,intI)%>;"></div>
				<div class="bg-color right" style="background-color:#<%=arrlist(12,intI)%>;"></div>
			</div>
		<% ElseIf evt_code<>"0" And (img2="" Or isnull(img2)) Then %>
			<% If etctag="8" Then %>
			<div class="rolling-item <%=chkiif(bantype="wide","bg-wide","")%> spc-weekend" style="background-image:url(<%=img%>);">
				<a href="<%=alink%>"  onclick=AmpEventRolling(JSON.parse('<%=amplituderollingval%>'));>
					<div class="desc <%=chkiif(ftcolor=0,"color-black","color-white")%>"">
						<div class="copy">
							<p><%=maincopy%>
								<% If maincopy2<> "" Then %>
								<br/><%=maincopy2%>
								<% End If %>
							</p>
						</div>
						<p class="subcopy"><%=subcopy%></p>
					</div>
					<div class="text-img">
						<p class="discount"><% If salePer<>"" Then %><b class="color-red">~<%=salePer%>%</b><% End If %><% If saleCPer<>"" Then %><b class="color-green">쿠폰 <%=saleCPer%>%</b><% End If %></p>
					</div>
				</a>
				<div class="bg-color left" style="background-color:#<%=arrlist(11,intI)%>;"></div>
				<div class="bg-color right" style="background-color:#<%=arrlist(12,intI)%>;"></div>
			</div>
			<% Else %>
			<div class="rolling-item <%=chkiif(bantype="wide","bg-wide","")%>" style="background-image:url(<%=img%>);">
				<a href="<%=alink%>"  onclick=AmpEventRolling(JSON.parse('<%=amplituderollingval%>'));>
					<div class="desc <%=chkiif(ftcolor=0,"color-black","color-white")%>"">
						<div class="copy">
							<p><%=maincopy%>
								<% If maincopy2<> "" Then %>
								<br/><%=maincopy2%>
								<% End If %>

								<% If salePer<>"" Then %>
								<%=addtag(2,"~"&salePer&"%")%>
								<% End If %>
								<% If saleCPer<>"" Then %>
								<% If saleCPer > 100 Then %>
								<%=addtag(3,"")%>
								<% Else %>
								<%=addtag(3,saleCPer&"%")%>
								<% End If %>
								<% End If %>
							</p>
						</div>
						<p class="subcopy"><%=subcopy%></p>
					</div>
				</a>
				<div class="bg-color left" style="background-color:#<%=arrlist(11,intI)%>;"></div>
				<div class="bg-color right" style="background-color:#<%=arrlist(12,intI)%>;"></div>
			</div>
			<% End If %>
		<% Else %>
			<div class="rolling-item <%=chkiif(bantype="wide","bg-wide","")%>" style="background-image:url(<%=img%>);">
				<a href="<%=alink%>"  onclick=AmpEventRolling(JSON.parse('<%=amplituderollingval%>'));>
					<div class="desc <%=chkiif(ftcolor=0,"color-black","color-white")%>"">
						<div class="copy">
							<p><%=maincopy%>
								<% If maincopy2<> "" Then %>
								<br/><%=maincopy2%>
								<% End If %>
								<%=addtag(etctag,etctext)%>
							</p>
						</div>
						<p class="subcopy"><%=subcopy%></p>
					</div>
				</a>
				<div class="bg-color left" style="background-color:#<%=arrlist(11,intI)%>;"></div>
				<div class="bg-color right" style="background-color:#<%=arrlist(12,intI)%>;"></div>
			</div>
		<% End If %>


<%
		intJ = intJ + 1
	Next
%>
	</div>
</div>
<%
End If
on Error Goto 0
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->