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


if IsUserLoginOK() and GetLoginUserID() <> "" then
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
					<ul class="alarmUnitV15">
<%
	if Not isArray(resultRows) then
		''rw "표시할 알림 없음"
	else
		for i = 0 To UBound(resultRows,2)
			Select Case resultRows(1,i)
				Case "000"
					''// 단체알림
					%>
						<li class="mktIsuPartV15">
							<a href="<%= resultRows(5,i) %>">
								<span class="alarmIcoV15"></span>
								<dl>
									<dt><%= resultRows(2,i) %></dt>
									<dd><%= resultRows(3,i) %></dd>
								</dl>
								<p><%= resultRows(4,i) %></p>
							</a>
						</li>
					<%
				Case "001"
					''// 신규가입쿠폰
					%>
						<li class="cuponPartV15">
							<a href="<%= resultRows(5,i) %>">
								<span class="alarmIcoV15"></span>
								<dl>
									<dt><%= resultRows(2,i) %></dt>
									<dd><%= resultRows(3,i) %></dd>
								</dl>
								<p><%= resultRows(4,i) %></p>
							</a>
						</li>
					<%
				Case "002"
					''// 쿠폰만료
					%>
						<li class="cuponPartV15">
							<a href="<%= resultRows(5,i) %>">
								<span class="alarmIcoV15"></span>
								<dl>
									<dt><%= resultRows(2,i) %></dt>
									<dd><%= resultRows(3,i) %></dd>
								</dl>
								<p><%= resultRows(4,i) %></p>
							</a>
						</li>
					<%
				Case "003"
					''// 장바구니 상품 이벤트
					if display003or004 = "003" then
					%>
						<li class="evtPartV15">
							<a href="<%= resultRows(5,i) %>">
								<span class="alarmIcoV15"><img src="<%= "http://webimage.10x10.co.kr/image/list/" + GetImageSubFolderByItemid(resultRows(11,i)) + "/" + resultRows(13,i) %>" alt="<%= db2html(resultRows(12,i)) %>" /></span>
								<p class="pdtStTag">
									<% if (resultRows(10,i) <> "0") then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_only.gif" alt="ONLY" /><% end if %>
									<% if (resultRows(9,i) <> "0") then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_sale.gif" alt="SALE" /><% end if %>
									<% if (resultRows(11,i) <> "0") then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_coupon.gif" alt="쿠폰" /><% end if %>
								</p>
								<dl>
									<dt><%= resultRows(2,i) %></dt>
									<dd><%= resultRows(3,i) %></dd>
								</dl>
								<p><%= resultRows(4,i) %></p>
							</a>
						</li>
					<%
					end if
				Case "004"
					''// 위시 상품 이벤트
					if display003or004 = "004" then
					%>
						<li class="evtPartV15">
							<a href="<%= resultRows(5,i) %>">
								<span class="alarmIcoV15"><img src="<%= "http://webimage.10x10.co.kr/image/list/" + GetImageSubFolderByItemid(resultRows(11,i)) + "/" + resultRows(13,i) %>" alt="<%= db2html(resultRows(12,i)) %>" /></span>
								<p class="pdtStTag">
									<% if (resultRows(9,i) <> "0") then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_only.gif" alt="ONLY" /><% end if %>
									<% if (resultRows(8,i) <> "0") then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_sale.gif" alt="SALE" /><% end if %>
									<% if (resultRows(10,i) <> "0") then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_coupon.gif" alt="쿠폰" /><% end if %>
								</p>
								<dl>
									<dt><%= resultRows(2,i) %></dt>
									<dd><%= resultRows(3,i) %></dd>
								</dl>
								<p><%= resultRows(4,i) %></p>
							</a>
						</li>
					<%
					end if
				Case "005"
					''// 1:1 상담
					%>
						<li class="csPartV15">
							<a href="<%= resultRows(5,i) %>">
								<span class="alarmIcoV15"></span>
								<p><img src="http://fiximage.10x10.co.kr/web2015/common/tag_a_ok.gif" alt="답변완료" /></p>
								<dl>
									<dt><%= resultRows(2,i) %></dt>
									<dd><%= resultRows(3,i) %></dd>
								</dl>
								<p><%= resultRows(4,i) %></p>
							</a>
						</li>
					<%
				Case "006"
					''// 상품 QnA
					%>
						<li class="csPartV15">
							<a href="<%= resultRows(5,i) %>">
								<span class="alarmIcoV15"></span>
								<p><img src="http://fiximage.10x10.co.kr/web2015/common/tag_a_ok.gif" alt="답변완료" /></p>
								<dl>
									<dt><%= resultRows(2,i) %></dt>
									<dd><%= resultRows(3,i) %></dd>
								</dl>
								<p><%= resultRows(4,i) %></p>
							</a>
						</li>
					<%
				Case "007"
					''// 이벤트 당첨
					%>
						<li class="winPartV15">
							<a href="<%= resultRows(5,i) %>">
								<span class="alarmIcoV15"></span>
								<dl>
									<dt><%= resultRows(2,i) %></dt>
									<dd><%= resultRows(3,i) %></dd>
								</dl>
								<p><%= resultRows(4,i) %></p>
							</a>
						</li>
					<%
				Case Else
					''
			End Select
		next
%>
					</ul>
<%
		for i = 0 To UBound(resultRows,2)
			Select Case resultRows(1,i)
				Case "901"
					''// 관심상품 없음
					%>
					<div class="alarmType01">
						<p class="figure"><img src="http://fiximage.10x10.co.kr/web2015/common/ico_wish_cart.png" alt="" /></p>
						<p class="txtV15"><strong>관심 상품을 <br />위시 또는 장바구니에 담아보세요.</strong></p>
						<p class="tPad05">상품 관련 이벤트 소식이 있을 때 알려드려요.</p>
						<p class="tPad15"><a href="/my10x10/popularwish.asp" class="btn btnS2 btnRed"><em class="whiteArr01 fn">실시간 인기위시 보기</em></a></p>
					</div>
					<%
				Case "902"
					''// 관련이벤트 없음
					%>
					<div class="alarmType01">
						<p class="figure"><img src="http://fiximage.10x10.co.kr/web2015/common/ico_event.png" alt="" /></p>
						<p class="txtV15"><strong>추천 이벤트가 발견되지 않았습니다.</strong></p>
						<p class="tPad05">맘에 드는 관심 상품 수를 늘려보세요.</p>
						<p class="tPad15"><a href="/my10x10/popularwish.asp" class="btn btnS2 btnRed"><em class="whiteArr01 fn">실시간 인기위시 보기</em></a></p>
					</div>
					<%
				Case Else
					''
			End Select
		next
%>
	<% end if %>
<% end if %>
<!-- #include virtual="/lib/db/dbclose.asp" -->
