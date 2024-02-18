<%
'####### 적립예상마일리지.
'### 마케팅 두배이벤트시 그때그때 달라지므로 따로 뺏음.
'0 ~ 1 : count(*) AS totalcnt, isNull(SUM(CASE WHEN i.evalcnt > 0 THEN 100 ELSE 200 END),0) AS totalgetmile, 
'2 ~ 3 : sum(Case When i.evalcnt>0 then 1 else 0 end) AS cnt, sum(Case When i.evalcnt=0 then 1 else 0 end) AS firstcnt
Dim cMil, vMileArr, vMileValue, vIsMileEvent

If Now() > #08/29/2018 00:00:00# AND Now() < #09/04/2018 23:59:59# Then
	vIsMileEvent = "o"
	vMileValue = 200
Else
	vIsMileEvent = "x"
	vMileValue = 100
End If

Set cMil = New CEvaluateSearcher
cMil.FRectUserID = Userid
cMil.FRectMileage = vMileValue
vMileArr = cMil.getEvaluatedTotalMileCnt
Set cMil = Nothing
%>
<div class="mileageBox">
	<dl>
		<dt><strong>적립 예상 마일리지</strong> (<%=vMileArr(0,0)%>건)</dt>
		<dd><%=FormatNumber(vMileArr(1,0),0)%><span>p</span></dd>
	</dl>
	<% If vIsMileEvent = "o" Then %>
	<p>
		<span><a href="/event/eventmain.asp?eventid=88837">[상품후기] 더블 마.일.리.지(~09.04)</a></span>
	</p>
	<% End If %>
</div>