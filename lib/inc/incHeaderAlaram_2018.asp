<script type="text/javascript">
// 새알람 표시

function GetMyAlarmInfo() {
	var str = "";
	str = $.ajax({
		type: "GET",
		url: "/my10x10/inc/acct_myAlarmInfo_2018.asp?t=<%= DateDiff("s", "01/01/1970 00:00:00", now()) %>",
		dataType: "text",
		async: false
	}).responseText;

	str = str.replace(/(^\s*)|(\s*$)/gi, "").replace(/\\n/gi,"");

	return str;
}

function GetMyAlarmList(yyyymmdd) {
	var str = "";
	str = $.ajax({
					type: "GET",
					url: "/my10x10/inc/acct_myAlarmInfoList_2018.asp?t=<%= DateDiff("s", "01/01/1970 00:00:00", now()) %>&yyyymmdd=" + yyyymmdd,
					dataType: "text",
					async: false
				}).responseText;

	return str;
}
<%
if IsUserLoginOK() and GetLoginUserID() <> "" then

	if Not MyAlarm_IsExist_CheckDateCookie() then
%>
		if(typeof(Storage) !== "undefined") {
			sessionStorage.removeItem("myalarm");
		}

		var MA_rStr = GetMyAlarmInfo("<%= Left(Now(), 10) %>");
		if (MA_rStr == "Y") {
			$(".util-alarm").addClass("newArV15");
		}
<%
	elseif MyAlarm_IsExist_NewMyAlarmCookie() then
%>
		$(".util-alarm").addClass("newArV15");
<%
	end if
%>

var MA_ListStr = "";
$(function() {
	//UNB - Alarm Control
	$('.util-alarm').mouseover(function() {
		$(this).children('.util-layer').show();
		if (MA_ListStr == "") {
			if(typeof(Storage) !== "undefined") {
				MA_ListStr = sessionStorage.getItem("myalarm");

				if (MA_ListStr == null) {
					MA_ListStr = "";
				}
			}

			if (MA_ListStr == "") {
				MA_ListStr = GetMyAlarmList("<%= Left(Now(), 10) %>");
			}

			sessionStorage.setItem("myalarm", MA_ListStr);

			$( "#alarmContents" ).append( MA_ListStr );
		}

		setTimeout(function(){
			$(".util-alarm").removeClass("newArV15");
		},1000);
	});

	$('.util-alarm').mouseleave(function() {
		$('.util-layer').hide();
	});
});
<% end if %>
</script>
<div class="util-layer">
	<p class="title"><a href="<%=SSLUrl%>/my10x10/" class="btn-linkV18 link1">MY 알림 <span></span></a></p>
	<div class="todayis">
		<p class="date"><%=FormatDate(now,"0000.00.00") & " (" & getWeekName(date) & ")" %></p>
		<div id="alarmContents"></div>
	</div>
</div>