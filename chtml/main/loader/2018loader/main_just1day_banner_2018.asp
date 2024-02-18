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
' Discription : pc_main_just1day 2018 신규
' History : 2018-06-21 원승현 생성
'#######################################################
Dim poscode , intI ,intJ
Dim sqlStr , rsMem , arrList, arrItem, arrItemCount
Dim gaParam
Dim CtrlDate : CtrlDate = now()
Dim playingGubun, targetNum, intT
Dim amplitudeJust1Day

Dim listidx, listtitle, liststartdate, listenddate, listregdate, listlastupdate, listadminid, listlastadminid, listisusing, listmaxsaleper, listtype, listbannerimage, listlinkurl, listworkertext, listplatform
Dim itemsubidx, itemlistidx, itemtitle, itemitemid, itemfrontimage, itemprice, itemsaleper, itemisusing, itemsortnum, itemmakerid, itemitemdiv, itemgubun
Dim itemsellcash, itemorgprice, itemsailprice, itemsellyn, itemlimityn, itemsailyn, itembasicimage, itemitemcoupontype, itemitemcouponvalue, itemitemcouponyn, itemtenonlyyn, itemdispcate1, itembrandname
Dim itemlimitno, itemlimitsold


'//DB 시간 타이머 00시부터 00시 5분 사이에는 DB 캐쉬 1분에 한번 읽기
Dim cTime , dummyName
If timer > 10 And Cint(timer/60) < 6 Then
	cTime = 60*1
	dummyName = "PBJUST1DAYNEWMAIN_"&Cint(timer/60)
Else
	cTime = 60*5
'	cTime = 1*1
	dummyName = "PBJUST1DAYNEWMAIN"
End If

sqlStr = "exec db_sitemaster.dbo.usp_Ten_pcmain_Just1DayList2018 'pc'"

set rsMem = getDBCacheSQL(dbget, rsget, dummyName, sqlStr, cTime)
IF Not (rsMem.EOF OR rsMem.BOF) THEN
	arrList = rsMem.GetRows
END IF
rsMem.close

If IsArray(arrList) Then
	listidx = arrList(0,0)
	listtitle = arrList(1,0)
	liststartdate = arrList(2,0)
	listenddate = arrList(3,0)
	listregdate = arrList(4,0)
	listlastupdate = arrList(5,0)
	listadminid = arrList(6,0)
	listlastadminid = arrList(7,0)
	listisusing = arrList(8,0)
	listmaxsaleper = arrList(9,0)
	listtype = arrList(10,0)
	listbannerimage = arrList(11,0)
	listlinkurl = arrList(12,0)
	listworkertext = arrList(13,0)
	listplatform = arrList(14,0)
End If

If IsArray(arrList) Then
	sqlStr = "exec db_sitemaster.dbo.usp_Ten_pcmain_Just1DayItem2018 '"&listidx&"' "
	'Response.write sqlStr
	'response.End
	set rsMem = getDBCacheSQL(dbget, rsget, dummyName, sqlStr, cTime)
	IF Not (rsMem.EOF OR rsMem.BOF) THEN
		arrItem = rsMem.GetRows
		arrItemCount = rsMem.RecordCount
	END IF
	rsMem.close
End If

on Error Resume Next
if arrItemCount >= 3 then 

intJ = 0

Dim vTimerDate
If Trim(listtype) = "event" Then
	vTimerDate = listenddate
Else
	vTimerDate = DateAdd("d",1,Date())
End If
%>
<% targetNum = 100-CInt((DateDiff("s", Now(),listenddate) / DateDiff("s", liststartdate, listenddate)*100)) %>
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


	var nowdt = new Date();
	var thendt = new Date('<%=Year(vTimerDate)&"-"&Month(vTimerDate)&"-"&Day(vTimerDate)&" "&Hour(vTimerDate)&":"&Minute(vTimerDate)&":"&Second(vTimerDate)%>');
	var gapdt = thendt.getTime() - nowdt.getTime();

	gapdt = Math.floor(gapdt / (1000*60*60*24));

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

	$("#countdown").html(dhour.substr(0,1)+dhour.substr(1,1)+":"+dmin.substr(0,1)+dmin.substr(1,1)+":"+dsec.substr(0,1)+dsec.substr(1,1));

	var usrDt=new Date();	// 현재 브라우저 시간
	var vTerm = parseInt(usrDt.getTime()/1000)-parseInt(j1nowDt.getTime()/1000);	// 시작시 시간과의 차이(초)
	j1minus_second = vTerm;	// 증가시간에 차이 반영

	setTimeout("countdown()",500)
}

$(function(){
	countdown();
});
</script>
<% If Trim(listtype)="just1day" Then %>
	<% If IsArray(arrItem) Then %>
		<% If arrItemCount >= 3 Then %>
			<div class="section just1day">
				<div class="inner-cont">
					<div class="ftLt">
						<h2><img src="http://fiximage.10x10.co.kr/web2018/main/tit_just_1day_v2.png?v=1.1" alt="JUST 1 DAY" /></h2>
						<!-- 21주년 타이틀 수정
						<h2><img src="//fiximage.10x10.co.kr/web2018/main/tit_special_21st.png" alt="텐텐세일에 만나는 오늘만 특가"></h2> -->
						<p class="sale"><strong><%=listmaxsaleper%></strong>SALE</p>
						<div class="timeline"><span style="width:<%=targetNum%>%;"><em></em></span></div>
						<p class="time">남은시간 <span id="countdown">00:00:00</span></p>
					</div>
					<div class="items">
						<ul>
							<% 
							For intI = 0 To UBound(arrItem, 2)
								itemsubidx = arrItem(0,intI)
								itemlistidx = arrItem(1,intI)
								itemtitle = arrItem(2,intI)
								itemitemid = arrItem(3,intI)
								itemfrontimage = arrItem(4,intI)
								itemprice = arrItem(5,intI)
								itemsaleper = arrItem(6,intI)
								itemisusing = arrItem(7,intI)
								itemsortnum = arrItem(8,intI)
								itemmakerid = arrItem(9,intI)
								itemitemdiv = arrItem(10,intI)
								itemgubun = arrItem(11,intI)
								itemsellcash = arrItem(12,intI)
								itemorgprice = arrItem(13,intI)
								itemsailprice = arrItem(14,intI)
								itemsellyn = arrItem(15,intI)
								itemlimityn = arrItem(16,intI)
								itemsailyn = arrItem(17,intI)
								itembasicimage = arrItem(18,intI)
								itemitemcoupontype = arrItem(19,intI)
								itemitemcouponvalue = arrItem(20,intI)
								itemitemcouponyn = arrItem(21,intI)
								itemtenonlyyn = arrItem(22,intI)
								itemdispcate1 = arrItem(23,intI)
								itembrandname = arrItem(24,intI)
								itemlimitno = arrItem(25,intI)
								itemlimitsold = arrItem(26,intI)
								gaparam = "main_just1day_"&intI+1
							%>
								<li>
									<% If itemitemdiv="21" Then %>
										<a href="/deal/deal.asp?itemid=<%=itemitemid%>&gaparam=<%=gaparam%>" onclick="fnAmplitudeEventMultiPropertiesAction('click_mainjust1day','type|itemid|indexnumber','just1day|<%=itemitemid%>|<%=intI+1%>');">
									<% Else %>
										<a href="/shopping/category_prd.asp?itemid=<%=itemitemid%>&gaparam=<%=gaparam%>" onclick="fnAmplitudeEventMultiPropertiesAction('click_mainjust1day','type|itemid|indexnumber','just1day|<%=itemitemid%>|<%=intI+1%>');">
									<% End If %>
										<div class="thumbnail">
											<% If Trim(itemfrontimage)<>"" Then %>
												<img src="<%=Trim(itemfrontimage)%>" alt="<%=itemtitle%>">
											<% Else %>
												<img src="<%=Trim(itembasicimage)%>" alt="<%=itemtitle%>">
											<% End If %>
										</div>
										<div class="desc">
											<p class="name"><%=itemtitle%></p>
											<div class="price">
												<% If itemitemdiv="21" Then %>
													<span class="discount color-red"><%=itemsaleper%></span>
													<span class="sum"><%=itemprice%></span>
												<% Else %>
													<% If itemsailyn="Y" OR itemsaleper<>"" Then %>
														<span class="discount color-red">
															<%
																if itemitemid = 1849622 then 
																	response.write "1+1"
																elseif itemsaleper<>"" then 
																	response.write itemsaleper
																Else
																	response.write CLng((itemorgprice-itemsellcash)/itemorgprice*100) &"%"
																end if 
															%>
														</span>
													<% End If %>
													<span class="sum"><%=FormatNumber(itemsellcash, 0)%>원</span>
												<% End If %>
											</div>
										</div>
									</a>
								</li>
							<% 
								If intI >= 2 Then
									Exit For
								End If
							%>
							<% Next %>
						</ul>
					</div>
				</div>
			</div>
		<% End If %>
	<% End If %>
<% End If %>

<% If Trim(listtype)="event" Then %>
	<%' 저스트원데이(기획전) %>
	<% If Trim(listtitle) <> "" Then %>
		<div class="section time-sale saleV2 eventV2">
			<div class="inner-cont">
				<a href="<%=listlinkurl%>&gaparam=main_just1day_event" onclick="fnAmplitudeEventMultiPropertiesAction('click_mainjust1day','type|itemid|indexnumber','event|none|none');">
					<h2><span>TIME SALE</span></h2>
					<div class="desc">
						<h3><span><%=listtitle%></span><i><%=listmaxsaleper%></i></h3>
						<p><%=listworkertext%></p>
					</div>
				</a>
				<% If IsArray(arrItem) Then %>
					<div class="image-cont">
						<a href="<%=listlinkurl%>&gaparam=main_just1day_event" onclick="fnAmplitudeEventMultiPropertiesAction('click_mainjust1day','type|itemid|indexnumber','event|none|none');">
							<div class="thumbnail">
								<div class="rolling">
									<%' for dev msg : 이미지는 한장일수도, 여러장일수도 있음 %>
									<% 
									For intI = 0 To UBound(arrItem, 2)
										itemitemid = arrItem(3,intI)
										itemfrontimage = arrItem(4,intI)
										itembasicimage = arrItem(18,intI)
									%>
										<% If Trim(itemfrontimage) <> "" Then %>
											<img src="<%=Trim(itemfrontimage)%>" alt="<%=itemtitle%>" />										
										<% Else %>
											<img src="<%=Trim(itembasicimage)%>" alt="<%=itemtitle%>" />										
										<% End If %>
									<% Next %>									
								</div>
							</div>
						</a>
					</div>
				<% End If %>
			</div>
		</div>
	<% End If %>
<% End If %>
<% End If %>
<%
	on Error Goto 0
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->