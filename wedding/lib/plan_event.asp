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
' Discription : wedding_plan_event // cache DB경유
' History : 2018-04-11 정태훈 생성
'#######################################################
Dim poscode , icnt ,jcnt, totalsaleper, totalprice
Dim sqlStr , rsMem, arrList, intI

'//DB 시간 타이머 00시부터 00시 5분 사이에는 DB 캐쉬 1분에 한번 읽기
Dim cTime , dummyName
If timer > 10 And Cint(timer/60) < 6 Then
	cTime = 60*1
	dummyName = "WeddingPlanEvent_"&Cint(timer/60)
Else
	cTime = 60*5
	dummyName = "WeddingPlanEvent"
End If

'// foryou
sqlStr = "EXEC [db_sitemaster].[dbo].[usp_WWW_Wedding_PlanEvent_Get]"
set rsMem = getDBCacheSQL(dbget, rsget, dummyName, sqlStr, cTime)
IF Not (rsMem.EOF OR rsMem.BOF) THEN
	arrList = rsMem.GetRows
END IF
rsMem.close


on Error Resume Next

If IsArray(arrList) Then
%>
			<div class="event-list">
				<div class="wed-evt-list">
					<div class="repesent-evt">
						<a href="/event/eventmain.asp?eventid=<%=arrList(0,0)%>">
							<div><img src="<%=arrList(5,0)%>" alt="<%=arrList(1,0)%>" /></div>
							<p class="evt-tit"><span><%=arrList(1,0)%><% If arrList(3,0)<>"0" Then %></span>&nbsp;<span class="color-red"><%=arrList(3,0)%></span><% End If %></p>
							<p><% If arrList(4,0)<>"0" Then %><span class="color-green">쿠폰<%=arrList(4,0)%></span><% End If %>&nbsp;<%=arrList(2,0)%></p>
						</a>
					</div>
					<div class="swiper-container">
						<div class="swiper-wrapper">
							<% For intI = 1 To ubound(arrlist,2) %>
							<div class="swiper-slide">
								<a href="/event/eventmain.asp?eventid=<%=arrList(0,intI)%>">
									<div><img src="<%=arrList(5,intI)%>" alt="<%=arrList(1,intI)%>" /></div>
									<p class="evt-tit"><span><%=arrList(1,intI)%><% If arrList(3,intI)<>"0" Then %></span>&nbsp;<span class="color-red"><%=arrList(3,intI)%></span><% End If %></p>
									<p><% If arrList(4,intI)<>"0" Then %><span class="color-green">쿠폰<%=arrList(4,intI)%></span><% End If %> &nbsp;<%=arrList(2,intI)%></p>
								</a>
							</div>
							<% Next %>
						</div>
					</div>
				<button type="button" class="btnNav btn-prev">이전</button>
				<button type="button" class="btnNav btn-next">다음</button>
				</div>
			</div>
<%
End If
on Error Goto 0
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->