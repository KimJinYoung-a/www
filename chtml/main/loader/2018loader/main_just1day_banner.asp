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
' Discription : pc_main_just1day // cache DB경유
' History : 2018-03-16 원승현 생성
'#######################################################
Dim poscode , intI ,intJ
Dim sqlStr , rsMem , arrList, arrItem
Dim gaParam : gaParam = "&gaparam=main_" '//GA 체크 변수
Dim CtrlDate : CtrlDate = now()
Dim playingGubun, targetNum, intT
Dim amplitudeJust1Day

'//DB 시간 타이머 00시부터 00시 5분 사이에는 DB 캐쉬 1분에 한번 읽기
Dim cTime , dummyName
If timer > 10 And Cint(timer/60) < 6 Then
	cTime = 60*1
	dummyName = "PBPLAYINGMAIN_"&Cint(timer/60)
Else
	cTime = 60*5
	dummyName = "PBPLAYINGMAIN"
End If

sqlStr = "db_sitemaster.dbo.[usp_Ten_pcmain_Just1DayList]"

set rsMem = getDBCacheSQL(dbget, rsget, dummyName, sqlStr, cTime)
IF Not (rsMem.EOF OR rsMem.BOF) THEN
	arrList = rsMem.GetRows
END IF
rsMem.close


If IsArray(arrList) Then
sqlStr = "db_sitemaster.dbo.[usp_Ten_pcmain_Just1DayItem] ('"&arrlist(0,0)&"') "
'Response.write sqlStr
'response.End

set rsMem = getDBCacheSQL(dbget, rsget, dummyName, sqlStr, cTime)
IF Not (rsMem.EOF OR rsMem.BOF) THEN
	arrItem = rsMem.GetRows
END IF
rsMem.close

Select Case Trim(arrlist(9,0))
	Case "W"
		playingGubun = "weekend"
	Case "Y"
		playingGubun = ""
	Case "E"
		playingGubun = "event"
	Case "H"
		playingGubun = "holiday"
End Select

on Error Resume Next

intJ = 0
Dim vTimerDate
If trim(playingGubun)="weekend" Or trim(playingGubun)="holiday" Then
	vTimerDate = arrlist(3,0)
Else
	vTimerDate = DateAdd("d",1,Date())
End If

%>
<% If Trim(playingGubun)<>"event" Then %>
	<% targetNum = 100-CInt((DateDiff("s", Now(),arrlist(3,0)) / DateDiff("s", arrlist(2,0), arrlist(3,0))*100)) %>
	<script>
		var j1yr = "<%=Year(vTimerDate)%>";
		var j1mo = "<%=TwoNumber(Month(vTimerDate))%>";
		var j1da = "<%=TwoNumber(Day(vTimerDate))%>";
	var montharray=new Array("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec")
	var j1today=new Date(<%=Year(now)%>, <%=Month(now)-1%>, <%=Day(now)%>, <%=Hour(now)%>, <%=Minute(now)%>, <%=Second(now)%>);

	var j1minus_second = 0;		// 변경될 증가시간(초)
	var j1nowDt=new Date();		// 시작시 브라우저 시간

	function countdown(){
		var cntDt = new Date(Date.parse(j1today) + (1000*j1minus_second));	//서버시간에 변화값(1초) 증가
		var todayy=cntDt.getYear()

		if(todayy < 1000) todayy+=1900;

		var todaym=cntDt.getMonth();
		var todayd=cntDt.getDate();
		var todayh=cntDt.getHours();
		var todaymin=cntDt.getMinutes();
		var todaysec=cntDt.getSeconds();
		var todaystring=montharray[todaym]+" "+todayd+", "+todayy+" "+todayh+":"+todaymin+":"+todaysec;
		var futurestring=montharray[j1mo-1]+" "+j1da+", "+j1yr+" 00:00:00";

		<% if trim(playingGubun)="weekend" or trim(playingGubun)="holiday" then %>
			var nowdt = new Date();
			var thendt = new Date('<%=Year(arrlist(3,0))&"-"&Month(arrlist(3,0))&"-"&Day(arrlist(3,0))&" "&Hour(arrlist(3,0))&":"&Minute(arrlist(3,0))&":"&Second(arrlist(3,0))%>');
			var gapdt = thendt.getTime() - nowdt.getTime();

			gapdt = Math.floor(gapdt / (1000*60*60*24));
		<% end if %>
		dd=Date.parse(futurestring)-Date.parse(todaystring);
		dday=Math.floor(dd/(60*60*1000*24)*1);
		dhour=Math.floor((dd%(60*60*1000*24))/(60*60*1000)*1);
		dmin=Math.floor(((dd%(60*60*1000*24))%(60*60*1000))/(60*1000)*1);
		dsec=Math.floor((((dd%(60*60*1000*24))%(60*60*1000))%(60*1000))/1000*1);

		if(dday < 0) {
			$("#countdown").html("00:00:00");
			return;
		}

		if(dhour < 10) dhour = "0" + dhour;
		if(dmin < 10) dmin = "0" + dmin;
		if(dsec < 10) dsec = "0" + dsec;
		dhour = dhour+'';
		dmin = dmin+'';
		dsec = dsec+'';

		// Print Time
		<% if trim(playingGubun)="weekend" or trim(playingGubun)="holiday" then %>
			if (gapdt > 0)
			{
				$("#countdown").html("<strong>"+gapdt+"일 "+dhour.substr(0,1)+dhour.substr(1,1)+":"+dmin.substr(0,1)+dmin.substr(1,1)+":"+dsec.substr(0,1)+dsec.substr(1,1)+"</strong>");
			}
			else
			{
				$("#countdown").html("<strong>"+dhour.substr(0,1)+dhour.substr(1,1)+":"+dmin.substr(0,1)+dmin.substr(1,1)+":"+dsec.substr(0,1)+dsec.substr(1,1)+"</strong>");
			}
		<% else %>
			$("#countdown").html("<strong>"+dhour.substr(0,1)+dhour.substr(1,1)+":"+dmin.substr(0,1)+dmin.substr(1,1)+":"+dsec.substr(0,1)+dsec.substr(1,1)+"</strong>");
		<% end if %>

		var usrDt=new Date();	// 현재 브라우저 시간
		var vTerm = parseInt(usrDt.getTime()/1000)-parseInt(j1nowDt.getTime()/1000);	// 시작시 시간과의 차이(초)
		j1minus_second = vTerm;	// 증가시간에 차이 반영

		setTimeout("countdown()",500)
	}

	$(function(){
		countdown();
	});
	</script>
<% End If %>
<script>
	function AmpEventJust1day(jsonval)
	{
		AmplitudeEventSend('MainJust1Day', jsonval, 'eventProperties');
	}
</script>

<% If IsArray(arrItem) Then %>
	<div class="section time-sale <%=playingGubun%>"> 
		<div class="inner-cont">
			<% If Trim(playingGubun)="" Then %>
			<% 
				amplitudeJust1Day = "{'Kind':'just1day'}" 
				amplitudeJust1Day = Replace(amplitudeJust1Day, "'", "\""")
			%>
			<a href="/shopping/category_prd.asp?itemid=<%=arrItem(2,0)%><%=gaParam%>just1day_00" onclick=AmpEventJust1day(JSON.parse('<%=amplitudeJust1Day%>'));> 
			<% End If %>
			<% If Trim(playingGubun)="weekend" Or Trim(playingGubun)="holiday" Then %>
			<% 
				amplitudeJust1Day = "{'Kind':'"&playingGubun&"'}" 
				amplitudeJust1Day = Replace(amplitudeJust1Day, "'", "\""")
			%>
			<a href="<%=arrlist(11,0)%><%=gaParam%><%=Trim(playingGubun)%>_00" onclick=AmpEventJust1day(JSON.parse('<%=amplitudeJust1Day%>'));> 
			<% End If %>
			<% If Trim(playingGubun)="event" Then %>
			<% 
				amplitudeJust1Day = "{'Kind':'exhibition'}" 
				amplitudeJust1Day = Replace(amplitudeJust1Day, "'", "\""")
			%>
			<a href="<%=arrlist(11,0)%><%=gaParam%>exhibition_00" onclick=AmpEventJust1day(JSON.parse('<%=amplitudeJust1Day%>'));> 
			<% End If %>
				<h2><span>TIME SALE</span><i><%=arrlist(13,0)%></i></h2> 
				<div class="desc"> 
					<% Select Case Trim(playingGubun) %>
						<% Case "" %>
							<% If Trim(arrItem(8,0))="21" Then %>
								<p><%=arrItem(5,0)%><span class="price color-black"><%=FormatNumber(arrItem(10,0), 0)%>원~</span></p> 
							<% Else %>
								<p><%=arrItem(5,0)%><span class="price"><s><%=FormatNumber(arrItem(11,0), 0)%>원</s><%=FormatNumber(arrItem(10,0), 0)%>원</span></p> 
							<% End If %>
						<% Case "event" %>
							<% ' 기획전일 경우 텍스트대신 이미지만 들어갑니다. alt 값에 이벤트명 넣어주세요 %>
							<p><img src="<%=arrlist(10,0)%>" alt="<%=arrlist(1,0)%>" /></p> 
						<% Case "weekend" %>
							<p><%=arrlist(12,0)%></p> 
						<% Case "holiday" %>
							<p><%=arrlist(12,0)%></p> 
					<% End Select %>
				</div> 
			</a>
			<div class="image-cont"> 
				<% If Trim(playingGubun)="" Then %>
				<% 
					amplitudeJust1Day = "{'Kind':'just1day'}" 
					amplitudeJust1Day = Replace(amplitudeJust1Day, "'", "\""")
				%>
				<a href="/shopping/category_prd.asp?itemid=<%=arrItem(2,0)%><%=gaParam%>just1day_00" onclick=AmpEventJust1day(JSON.parse('<%=amplitudeJust1Day%>'));> 
				<% End If %>
				<% If Trim(playingGubun)="weekend" Or Trim(playingGubun)="holiday" Then %>
				<% 
					amplitudeJust1Day = "{'Kind':'"&playingGubun&"'}" 
					amplitudeJust1Day = Replace(amplitudeJust1Day, "'", "\""")
				%>
				<a href="<%=arrlist(11,0)%><%=gaParam%><%=Trim(playingGubun)%>_00" onclick=AmpEventJust1day(JSON.parse('<%=amplitudeJust1Day%>'));> 
				<% End If %>
				<% If Trim(playingGubun)="event" Then %>
				<% 
					amplitudeJust1Day = "{'Kind':'"&playingGubun&"'}" 
					amplitudeJust1Day = Replace(amplitudeJust1Day, "'", "\""")
				%>
				<a href="<%=arrlist(11,0)%><%=gaParam%>exhibition_00" onclick=AmpEventJust1day(JSON.parse('<%=amplitudeJust1Day%>'));> 
				<% End If %>
					<div class="thumbnail"> 
						<div class="rolling">
							<% ' for dev msg : 이미지는 한장일수도, 여러장일수도 있음 %>
							<% For intI = 0 To UBound(arrItem, 2) %>
								<img src="<%=arrItem(16, intI)%>" alt="<%=arrItem(5, intI)%>" /> 
							<% intJ = intJ + 1 %>
							<% Next %>
						</div>
						<% If Trim(playingGubun)<>"event" Then %>
							<div class="time">남은 시간 <span id="countdown"><strong>00:00:00</strong></span></div> 
							<% If Trim(playingGubun)="" Then %>
								<% If arrItem(14, 0) = "Y" Then %>
									<% If CInt(arrItem(23, 0)) - CInt(arrItem(24, 0)) < 1 Then %>
										<div class="soldout"><b>SOLD OUT</b><p>준비된 수량이<br />모두 소진되었습니다.</p></div> 
									<% End If %>
								<% End If %>
							<% End If %>
						<% End If %>
					</div> 
					<% If Trim(playingGubun)<>"event" Then %>
						<div class="timeline" data-percent="<%=targetNum%>"><span></span></div> 
					<% End If %>
				</a> 
			</div>
		</div> 
	</div> 
<% End If %>
<%
End If
on Error Goto 0
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->