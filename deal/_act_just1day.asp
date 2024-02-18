<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "utf-8" %>
<%
'#######################################################
'	History	:  2015.04.01 허진원
'	Description : Just 1 Day 상품 배너 출력
'#######################################################
%>
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/Just1DayCls.asp" -->
<!-- #include virtual="/lib/classes/item/dealCls.asp" -->
<%
	dim oJustItem, itemid
	itemid = getNumeric(requestCheckVar(request("itemid"),9))
	if itemid="" then dbget.close(): Response.End

	'// 오늘의 상품 접수
	set oJustItem = New CJustOneDay
	oJustItem.FRectDate = date
	oJustItem.GetJustOneDayItemInfo

	'// 진행 상품이 맞는지 확인
	if cStr(itemid)<>cStr(oJustItem.FItemList(0).Fitemid) then
		set oJustItem = Nothing
		dbget.close(): Response.End
	end if

	If DateDiff("n",oJustItem.FItemList(0).FJustDate & " 23:59:59",now()) > 0 Then
		set oJustItem = Nothing
		dbget.close(): Response.End
	ElseIf (oJustItem.FItemList(0).FlimitYn="Y" and (oJustItem.FItemList(0).FlimitNo-oJustItem.FItemList(0).FlimitSold)<=0) or ((oJustItem.FItemList(0).FSellYn<>"Y")) Then
		set oJustItem = Nothing
		dbget.close(): Response.End
	End If
	
	'// 상품 할인이 없으면 종료
'	if oJustItem.FItemList(0).FsalePrice>=oJustItem.FItemList(0).ForgPrice then
'		set oJustItem = Nothing
'		dbget.close(): Response.End
'	end If
	
	'//딜 상품 할인율 관리
	Dim oDeal
	Set oDeal = New DealCls
	oDeal.GetIDealInfo itemid

	Dim vSalePercent
	vSalePercent = oDeal.Prd.FMasterDiscountRate

	Dim vTimerDate
	vTimerDate = DateAdd("d",1,oJustItem.FItemList(0).FJustDate)


	'// just1day 조회수를 위한 log테이블에 값 넣기
	Dim vQuery
	vQuery = "INSERT INTO [db_log].[dbo].[tbl_justOneDayViewCntLog] (userid , itemid, refip, platform)" & vbCrlf
	vQuery = vQuery & " VALUES ('"& getLoginUserId &"', '"& itemid &"', '"&request.ServerVariables("REMOTE_ADDR")&"','pcweb')"
	dbget.execute vQuery
	
%>
<script type="text/javascript">
var yr = "<%=Year(vTimerDate)%>";
var mo = "<%=TwoNumber(Month(vTimerDate))%>";
var daa = "<%=TwoNumber(Day(vTimerDate))%>";
var minus_second = 0;
var montharray=new Array("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec")
var today=new Date(<%=Year(now)%>, <%=Month(now)-1%>, <%=Day(now)%>, <%=Hour(now)%>, <%=Minute(now)%>, <%=Second(now)%>);

function countdown(){
	today = new Date(Date.parse(today) + (1000+minus_second));	//서버시간에 1초씩 증가
	var todayy=today.getYear()

	if(todayy < 1000) todayy+=1900;
		
	var todaym=today.getMonth();
	var todayd=today.getDate();
	var todayh=today.getHours();
	var todaymin=today.getMinutes();
	var todaysec=today.getSeconds();
	var todaystring=montharray[todaym]+" "+todayd+", "+todayy+" "+todayh+":"+todaymin+":"+todaysec;
	var futurestring=montharray[mo-1]+" "+daa+", "+yr+" 00:00:00";

	dd=Date.parse(futurestring)-Date.parse(todaystring);
	dday=Math.floor(dd/(60*60*1000*24)*1);
	dhour=Math.floor((dd%(60*60*1000*24))/(60*60*1000)*1);
	dmin=Math.floor(((dd%(60*60*1000*24))%(60*60*1000))/(60*1000)*1);
	dsec=Math.floor((((dd%(60*60*1000*24))%(60*60*1000))%(60*1000))/1000*1);

	if(dday < 0) {
		$(".timeBoxV15 p span").html("0");
		return;
	}

	if(dhour < 10) dhour = "0" + dhour;
	if(dmin < 10) dmin = "0" + dmin;
	if(dsec < 10) dsec = "0" + dsec;
	dhour = dhour+'';
	dmin = dmin+'';
	dsec = dsec+'';

	// Print Time
	$("#j1dRmH1").html(dhour.substr(0,1));
	$("#j1dRmH2").html(dhour.substr(1,1));
	$("#j1dRmM1").html(dmin.substr(0,1));
	$("#j1dRmM2").html(dmin.substr(1,1));
	$("#j1dRmS1").html(dsec.substr(0,1));
	$("#j1dRmS2").html(dsec.substr(1,1));
	
	minus_second = minus_second + 1;
	$("#remaintime").html(dhour+":"+dmin);
	setTimeout("countdown()",1000)
}

$(function(){
	countdown();
});
</script>
<div class="justDayV15">
	<dl>
		<dt><img src="http://fiximage.10x10.co.kr/web2015/shopping/tit_justday.png" alt="JUST1DAY - 단 하루, 오늘만 이 가격!" /></dt>
		<dd>
			<strong><img src="http://fiximage.10x10.co.kr/web2015/shopping/txt_remain_time.png" alt="남은시간" /></strong>
			<div class="timeBoxV15">
				<div>
					<p>
						<span id="j1dRmH1">9</span>
						<span id="j1dRmH2">9</span>
						<em></em>
						<span id="j1dRmM1">9</span>
						<span id="j1dRmM2">9</span>
						<em></em>
						<span id="j1dRmS1">9</span>
						<span id="j1dRmS2">9</span>
					</p>
				</div>
			</div>
		</dd>
	</dl>
	<div class="saleRatev15">
		<img src="http://fiximage.10x10.co.kr/web2015/shopping/rate_txt_0<%=left(vSalePercent,1)%>.png" alt="<%=left(vSalePercent,1)%>" />
		<img src="http://fiximage.10x10.co.kr/web2015/shopping/rate_txt_0<%=right(vSalePercent,1)%>.png" alt="<%=right(vSalePercent,1)%>" />
		<img src="http://fiximage.10x10.co.kr/web2015/shopping/rate_percent.png" alt="%" />
	</div>
</div>
<%
	set oJustItem = Nothing
	set oDeal = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->