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
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/base64.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<%
'#######################################################
' Discription : pc_main_enjoy_event // cache DB경유
' History : 2018-03-12 정태훈 생성
'#######################################################
Dim poscode , icnt ,jcnt, totalsaleper, totalprice
Dim sqlStr , rsMem, arrList

'//DB 시간 타이머 00시부터 00시 5분 사이에는 DB 캐쉬 1분에 한번 읽기
Dim cTime , dummyName
If timer > 10 And Cint(timer/60) < 6 Then
	cTime = 60*1
	dummyName = "GatherEvent_"&Cint(timer/60)
Else
	cTime = 60*5
	dummyName = "GatherEvent"
End If

'// foryou
sqlStr = "EXEC [db_sitemaster].[dbo].[usp_WWW_PCMain_GatherEvent_Get]"
set rsMem = getDBCacheSQL(dbget, rsget, dummyName, sqlStr, cTime)
IF Not (rsMem.EOF OR rsMem.BOF) THEN
	arrList = rsMem.GetRows
END IF
rsMem.close


on Error Resume Next

If IsArray(arrList) Then
%>
<script>
	function AmpGatherEvent(jsonval)
	{
		AmplitudeEventSend('MainGatherEvent', jsonval, 'eventProperties');
	}
</script>
			<div class="section text-exhibition">
				<div class="inner-cont">
					<div class="sentence">
						<p><span><%=arrList(0,0)%></span></p>
						<% If arrList(1,0)<>"" Then %>
						<p><span><%=arrList(1,0)%></span></p>
						<% End If %>
					</div>
					<div class="list-card">
						<ul>
							<li>
								<a href="/event/eventmain.asp?eventid=<%=arrList(2,0)%>&gaparam=main_eventset_1" onclick=AmpGatherEvent(JSON.parse('<%=Replace("{'GatherNumber':'1'}", "'", "\""")%>'));fnAmplitudeEventMultiPropertiesAction('click_maingather_event','indexnumber|eventcode','1|<%=arrList(2,0)%>');>
									<div class="thumbnail"><img src="<%=arrList(6,0)%>" alt="<%=arrList(3,0)%>" /></div>
									<div class="desc">
										<p class="headline"><span class="ellipsis"><%=arrList(3,0)%></span><% If arrList(5,0)<>"" Then %> <b class="discount color-red"><%=arrList(5,0)%></b><% End If %></p>
										<p class="subcopy"><% If arrList(17,0) <> "" Then %><b class="discount color-green">쿠폰 <%=arrList(17,0)%></b><% End If %><%=arrList(4,0)%></p>
									</div>
								</a>
							</li>
							<% If arrList(7,0)>0 Then %>
							<li>
								<a href="/event/eventmain.asp?eventid=<%=arrList(7,0)%>&gaparam=main_eventset_2" onclick=AmpGatherEvent(JSON.parse('<%=Replace("{'GatherNumber':'2'}", "'", "\""")%>'));fnAmplitudeEventMultiPropertiesAction('click_maingather_event','indexnumber|eventcode','2|<%=arrList(7,0)%>');>
									<div class="thumbnail"><img src="<%=arrList(11,0)%>" alt="<%=arrList(8,0)%>" /></div>
									<div class="desc">
										<p class="headline"><span class="ellipsis"><%=arrList(8,0)%></span><% If arrList(10,0)<>"" Then %> <b class="discount color-red"><%=arrList(10,0)%></b><% End If %></p>
										<p class="subcopy"><% If arrList(18,0) <> "" Then %><b class="discount color-green">쿠폰 <%=arrList(18,0)%></b><% End If %><%=arrList(9,0)%></p>
									</div>
								</a>
							</li>
							<% End If %>
							<% If arrList(12,0)>0 Then %>
							<li>
								<a href="/event/eventmain.asp?eventid=<%=arrList(12,0)%>&gaparam=main_eventset_3" onclick=AmpGatherEvent(JSON.parse('<%=Replace("{'GatherNumber':'3'}", "'", "\""")%>'));fnAmplitudeEventMultiPropertiesAction('click_maingather_event','indexnumber|eventcode','3|<%=arrList(12,0)%>');>
									<div class="thumbnail"><img src="<%=arrList(16,0)%>" alt="<%=arrList(13,0)%>" /></div>
									<div class="desc">
										<p class="headline"><span class="ellipsis"><%=arrList(13,0)%></span><% If arrList(15,0)<>"" Then %> <b class="discount color-red"><%=arrList(15,0)%></b><% End If %></p>
										<p class="subcopy"><% If arrList(19,0) <> "" Then %><b class="discount color-green">쿠폰 <%=arrList(19,0)%></b><% End If %><%=arrList(14,0)%></p>
									</div>
								</a>
							</li>
							<% End If %>
						</ul>
					</div>
				</div>
			</div>
<%
End If
on Error Goto 0
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->