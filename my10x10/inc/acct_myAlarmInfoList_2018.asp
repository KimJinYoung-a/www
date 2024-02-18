<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<%
response.Charset="UTF-8"
%>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/myalarmlib.asp" -->
<%
''한글
dim i
dim returnStr : returnStr = ""
dim returnResult : returnResult = False
dim resultRows, resultRow
dim display003or004
dim exist003, exist004
dim weekdayOfNow
dim yyyymmdd

yyyymmdd = requestCheckVar(request("yyyymmdd"),10)
if (yyyymmdd = "") then
	yyyymmdd = Left(Now(), 10)
end if

if (DateDiff("d", yyyymmdd, Now()) >= 7) or (DateDiff("d", yyyymmdd, Now()) < 0) then
	dbget.close() : Response.end
end if

weekdayOfNow = Weekday(CDate(yyyymmdd), 1)		'// 1 = vbSunday


if IsUserLoginOK() and GetLoginUserID() <> "" Then
	if (Not MyAlarm_IsExist_CheckDateCookie()) then
		returnResult = MyAlarm_CheckNewMyAlarm(GetLoginUserID(), GetLoginUserLevel())
	else
		returnResult = MyAlarm_IsExist_NewMyAlarmCookie()
	end if

	if (returnResult = True) then
		Call MyAlarm_SetNewMyAlarmAsRead(GetLoginUserID())
	end if

	resultRows = MyAlarm_MyAlarmList(GetLoginUserID(), yyyymmdd, GetLoginUserLevel())

	'// 장바구니 상품이벤트, 위시 상품이벤트 중 어떤걸 표시할지
	display003or004 = "000"
	exist003 = False
	exist004 = False
	if isArray(resultRows) then
		for i = 0 To UBound(resultRows,2)
			Select Case resultRows(1,i)
				Case "003"
					exist003 = True
					if (weekdayOfNow = 2) or (weekdayOfNow = 4) then
						display003or004 = "003"
					end if
				Case "004"
					exist004 = True
					if (weekdayOfNow <> 2) and (weekdayOfNow <> 4) then
						display003or004 = "004"
					end if
				Case Else
					''
			End Select
		next
	end if

	if (display003or004 = "000") then
		if (exist003 = True) then
			display003or004 = "003"
		end if

		if (exist004 = True) then
			display003or004 = "004"
		end if
	end if

%>
	<ul>
		<% if Not isArray(resultRows) Then %>
			<% '## rw "표시할 알림 없음" %>
			<li class="nodata">
				<p>관심 상품을<br />위시 또는 장바구니에 담아보세요.</p>
				<p>상품 관련 이벤트 소식이 있을 때 알려드려요.</p>
				<a href="/my10x10/popularwish.asp?gaparam=top_menu_alarm" class="btn-linkV18 link2">실시간 인기위시 <span></span></a>
			</li>
		<% Else %>
			<% for i = 0 To UBound(resultRows,2) %>
				<% Select Case resultRows(1,i) %>
					<% Case "000" %>
						<% '## 단체알림 %>
						<li class="today-mkt">
							<a href=""<%= resultRows(5,i) %>">
								<span class="icoV18"></span>
								<div class="desc">
									<p class="headline"><em><%= resultRows(2,i) %></em></p>
									<p class="subcopy"><em><%= resultRows(3,i) %></em></p>
									<p class="etc"><em><%= resultRows(4,i) %></em></p>
								</div>
							</a>
						</li>
					<% Case "001" %>
						<% '## 신규가입쿠폰 %>
						<li class="today-coupon">
							<a href="<%= resultRows(5,i) %>">
								<span class="icoV18"></span>
								<div class="desc">
									<% If InStr(resultRows(2,i), "|") > 0 Then %>
										<p class="headline"><em><%= Split(resultRows(2,i), "|")(0)%></em> <span class="discount color-green"><%= Split(resultRows(2,i), "|")(1)%></span></p>
									<% Else %>
										<p class="headline"><em><%= resultRows(2,i)%></em></p>
									<% End If %>
									<p class="subcopy"><em><%= resultRows(3,i) %></em></p>
									<p class="etc"><em><%= resultRows(4,i) %></em></p>
								</div>
							</a>
						</li>
					<% Case "002" %>
						<% '## 쿠폰만료 %>
						<li class="today-coupon">
							<a href="<%= resultRows(5,i) %>">
								<span class="icoV18"></span>
								<div class="desc">

									<% If InStr(resultRows(2,i), "|") > 0 Then %>
										<p class="headline"><em><%= Split(resultRows(2,i), "|")(0) %></em> <span class="discount color-green"><%=Split(resultRows(2,i), "|")(1)%></span></p>
									<% Else %>
										<p class="headline"><em><%= resultRows(2,i) %></em></p>
									<% End If %>
									<p class="subcopy"><em><%= resultRows(3,i) %></em></p>
									<p class="etc"><em><%= resultRows(4,i) %></em></p>
								</div>
							</a>
						</li>
					<% Case "003" %>
						<% '## 장바구니 상품 이벤트 %>
						<% If display003or004 = "003" Then %>
							<li class="today-event">
								<a href="<%= resultRows(5,i) %>">
									<span class="thumbnail"><img src="<%= "http://webimage.10x10.co.kr/image/list/" + GetImageSubFolderByItemid(resultRows(11,i)) + "/" + resultRows(13,i) %>" alt="<%= db2html(resultRows(12,i)) %>" alt="" /></span>
									<div class="desc">
										<% If Not(Trim(resultRows(9,i)) = "0" And Trim(resultRows(8,i)) = "0" And Trim(resultRows(10,i)) = "0") Then %>
											<p class="labelV18">
												<% if (resultRows(9,i) <> "0") then %><span class="color-black">ONLY</span><% End If %>
												<% if (resultRows(8,i) <> "0") then %><span class="color-red">SALE</span><% End If %>
												<% if (resultRows(10,i) <> "0") then %><span class="color-green">쿠폰</span><% End If %>
											</p>
										<% End If %>
										<p class="subcopy">
											<% If InStr(resultRows(2,i), "|") > 0 Then %>
												<em>
													<%= Split(resultRows(2,i), "|")(0) %>
												</em> 
												<% if (resultRows(9,i) <> "0") then %>
													<span class="discount color-red"><%=Split(resultRows(2,i), "|")(1)%></span>
												<% End If %>
												<% if (resultRows(11,i) <> "0") then %>
													<span class="discount color-green"><%=Split(resultRows(2,i), "|")(1)%></span>
												<% End If %>
											<% Else %>
												<em>
													<%= resultRows(2,i) %>
												</em> 
											<% End If %>
										</p>
										<p class="etc"><em><%= resultRows(4,i) %></em></p>
									</div>
								</a>
							</li>
						<% End If %>
					<% Case "004" %>
						<% '## 위시 상품 이벤트 %>
						<% If display003or004 = "004" Then %>
							<li class="today-event">
								<a href="<%= resultRows(5,i) %>">
									<span class="thumbnail"><img src="<%= "http://webimage.10x10.co.kr/image/list/" + GetImageSubFolderByItemid(resultRows(11,i)) + "/" + resultRows(13,i) %>" alt="<%= db2html(resultRows(12,i)) %>" alt="" /></span>
									<div class="desc">
										<% If Not(Trim(resultRows(9,i)) = "0" And Trim(resultRows(8,i)) = "0" And Trim(resultRows(10,i)) = "0") Then %>
											<p class="labelV18">
												<% if (resultRows(9,i) <> "0") then %><span class="color-black">ONLY</span><% End If %>
												<% if (resultRows(8,i) <> "0") then %><span class="color-red">SALE</span><% End If %>
												<% if (resultRows(10,i) <> "0") then %><span class="color-green">쿠폰</span><% End If %>
											</p>
										<% End If %>
										<p class="subcopy">
											<% If InStr(resultRows(2,i), "|") > 0 Then %>
												<em>
													<%= Split(resultRows(2,i), "|")(0) %>
												</em> 
												<% if (resultRows(8,i) <> "0") then %>
												 <span class="discount color-red"><%= Split(resultRows(2,i), "|")(1) %></span>
												<% End If %>
												<% if (resultRows(10,i) <> "0") then %>
												 <span class="discount color-green"><%= Split(resultRows(2,i), "|")(1) %></span>
												<% End If %>
											<% Else %>
												<em>
													<%= resultRows(2,i) %>
												</em> 
											<% End If %>
										</p>
										<p class="etc"><em><%= resultRows(4,i) %></em></p>
									</div>
								</a>
							</li>
						<% End If %>
					<% Case "005" %>
						<% '## 1:1 상담 %>
						<li class="today-cs">
							<a href="<%= resultRows(5,i) %>">
								<span class="icoV18"></span>
								<%' for dev msg : 답변 달렸을 경우 완료 아이콘 추가 %>
								<span class="icoV18 a-finish">완료</span>
								<div class="desc">
									<p class="headline"><em><%= resultRows(2,i) %></em></p>
									<p class="subcopy"><em><%= resultRows(3,i) %></em></p>
									<p class="etc"><em><%= resultRows(4,i) %></em></p>
								</div>
							</a>
						</li>
					<% Case "006" %>
						<% '## 상품 QnA %>
						<li class="today-cs">
							<a href="<%= resultRows(5,i) %>">
								<span class="icoV18"></span>
								<%' for dev msg : 답변 달렸을 경우 완료 아이콘 추가 %>
								<span class="icoV18 a-finish">완료</span>
								<div class="desc">
									<p class="headline"><em><%= resultRows(2,i) %></em></p>
									<p class="subcopy"><em><%= resultRows(3,i) %></em></p>
									<p class="etc"><em><%= resultRows(4,i) %></em></p>
								</div>
							</a>
						</li>
					<% Case "007" %>
						<% '## 이벤트 당첨 %>
						<li class="today-win">
							<a href="<%= resultRows(5,i) %>">
								<span class="icoV18"></span>
								<div class="desc">
									<p class="headline"><em><%= resultRows(2,i) %></em></p>
									<p class="subcopy"><em><%= resultRows(3,i) %></em></p>
									<p class="etc"><em><%= resultRows(4,i) %></em></p>
								</div>
							</a>
						</li>
					<% Case "901" %>
						<li class="nodata">
							<p>관심 상품을<br />위시 또는 장바구니에 담아보세요.</p>
							<p>상품 관련 이벤트 소식이 있을 때 알려드려요.</p>
							<a href="/my10x10/popularwish.asp?gaparam=top_menu_alarm" class="btn-linkV18 link2">실시간 인기위시 <span></span></a>
						</li>
					<% Case "902" %>
						<li class="nodata">
							<p>추천 이벤트가<br />발견되지 않았습니다.</p>
							<p>맘에 드는 관심 상품 수를 늘려보세요.</p>
							<a href="/my10x10/popularwish.asp?gaparam=top_menu_alarm" class="btn-linkV18 link2">실시간 인기위시 <span></span></a>
						</li>
					<% Case Else %>
				<% End Select %>
			<% Next %>
		<% End If %>
	</ul>
<% end if %>
<!-- #include virtual="/lib/db/dbclose.asp" -->
