<script type="text/javascript">
// 새알람 표시

function GetMyAlarmInfo() {
	var str = "";
	str = $.ajax({
		type: "GET",
		url: "/my10x10/inc/acct_myAlarmInfo.asp?t=<%= DateDiff("s", "01/01/1970 00:00:00", now()) %>",
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
					url: "/my10x10/inc/acct_myAlarmInfoList.asp?t=<%= DateDiff("s", "01/01/1970 00:00:00", now()) %>&yyyymmdd=" + yyyymmdd,
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
			$(".uAlarmV15").addClass("newArV15");
		}
<%
	elseif MyAlarm_IsExist_NewMyAlarmCookie() then
%>
		$(".uAlarmV15").addClass("newArV15");
<%
	end if
%>

var MA_ListStr = "";
$(function() {
	//UNB - Alarm Control
	$('.uAlarmV15').mouseover(function() {
		$(this).children('.uSubLyrV15').show();
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

			$( ".subLyrBoxV15 > .myAlarmV15 > .alarmListV15" ).append( MA_ListStr );
		}

		setTimeout(function(){
			$(".uAlarmV15").removeClass("newArV15");
		},1000);
	});

	$('.uAlarmV15').mouseleave(function() {
		$('.uAlarmV15 > .uSubLyrV15').hide();
	});
});
<% end if %>
</script>
<div class="uSubLyrV15">
	<div class="subLyrBgV15">
		<div class="subLyrBoxV15">
			<% If (Not IsUserLoginOK) Then %>
			<div class="alarmSvcV15">
				<p class="titV15"><strong>MY 알림 서비스</strong><img src="http://fiximage.10x10.co.kr/web2013/common/ico_new2.gif" alt="NEW" /></p>
				<p class="figure"><img src="http://fiximage.10x10.co.kr/web2015/common/ico_shop.png" alt="" /></p>
				<p class="txtV15">맘에 드는 상품을 장바구니, 위시에 담아두면 <br />취향에 맞는 할인정보, 회원혜택 등 <br />각종소식을 알려드립니다. (회원전용 서비스)</p>
				<p class="tPad20"><a href="/login/loginpage.asp?vType=G" class="btn btnS1 btnRed" style="width:90px;"><em>로그인</em></a></p>
				<p class="tPad10"><a href="/member/join.asp" class="goLinkV15">아직 회원이 아니신가요?</a></p>
			</div>
			<% Else %>
			<div class="myAlarmV15">
				<p class="titV15">
					<strong>MY 알림</strong>
					<a href="/my10x10/" class="goLinkV15">더보기</a>
				</p>
				<div class="alarmListV15">
					<div class="almTodayV15">
						<p class="boxRd0V15"><%=FormatDate(now,"0000.00.00") & " (" & getWeekName(date) & ")" %></p>
					</div>
				</div>
			</div>
			<% end if %>
		</div>
	</div>
</div>
