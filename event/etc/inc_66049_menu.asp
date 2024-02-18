<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : hey, something project 시리즈 매뉴
' History : 2015.09.08 한용민 생성
'####################################################
%>
<%
dim eCode1, eCode2, eCode3, eCode4, eCode5, eCode6, eCode7
IF application("Svr_Info") = "Dev" THEN
	eCode1   =  64880
	eCode2   =  64885
	eCode3   =  64893
	eCode4   =  64898
	eCode5   =  64910
	eCode6   =  64918
	eCode7   =  64918
Else
	eCode1   =  66049
	eCode2   =  66233
	eCode3   =  66242
	eCode4   =  66382
	eCode5   =  66637
	eCode6   =  66453
	eCode7   =  66855
End If

%>

<% '<!-- for dev msg : 오픈 전 <span>...</span> / 오픈 후 <a href="">...</a> / 선택된 탭은 클래스 on 붙여주세요 --> %>
<% If left(currenttime,10)>="2015-10-21" Then %>
	<% if cstr(eCode7)=cstr(eCode) then %>
		<li class="nav1021"><a href="/event/eventmain.asp?eventid=<%= eCode7 %>" class="on">Date.10.21</a></li>
	<% else %>
		<li class="nav1021"><a href="/event/eventmain.asp?eventid=<%= eCode7 %>">Date.10.21</a></li>
	<% end if %>
<% else %>
	<li class="nav1021"><span>Date.10.21</span></li>
<% end if %>

<% If left(currenttime,10)>="2015-10-14" Then %>
	<% if cstr(eCode6)=cstr(eCode) then %>
		<li class="nav1014"><a href="/event/eventmain.asp?eventid=<%= eCode6 %>" class="on">Date.10.14</a></li>
	<% else %>
		<li class="nav1014"><a href="/event/eventmain.asp?eventid=<%= eCode6 %>">Date.10.14</a></li>
	<% end if %>
<% else %>
	<li class="nav1014"><span>Date.10.14</span></li>
<% end if %>

<% If left(currenttime,10)>="2015-10-07" Then %>
	<% if cstr(eCode5)=cstr(eCode) then %>
		<li class="nav1007"><a href="/event/eventmain.asp?eventid=<%= eCode5 %>" class="on">Date.10.07</a></li>
	<% else %>
		<li class="nav1007"><a href="/event/eventmain.asp?eventid=<%= eCode5 %>">Date.10.07</a></li>
	<% end if %>
<% else %>
	<li class="nav1007"><span>Date.10.07</span></li>
<% end if %>

<% If left(currenttime,10)>="2015-09-30" Then %>
	<% if cstr(eCode4)=cstr(eCode) then %>
		<li class="nav0930"><a href="/event/eventmain.asp?eventid=<%= eCode4 %>" class="on">Date.09.30</a></li>
	<% else %>
		<li class="nav0930"><a href="/event/eventmain.asp?eventid=<%= eCode4 %>">Date.09.30</a></li>
	<% end if %>
<% else %>
	<li class="nav0930"><span>Date.09.30</span></li>
<% end if %>

<% If left(currenttime,10)>="2015-09-23" Then %>
	<% if cstr(eCode3)=cstr(eCode) then %>
		<li class="nav0923"><a href="/event/eventmain.asp?eventid=<%= eCode3 %>" class="on">Date.09.23</a></li>
	<% else %>
		<li class="nav0923"><a href="/event/eventmain.asp?eventid=<%= eCode3 %>">Date.09.23</a></li>
	<% end if %>
<% else %>
	<li class="nav0923"><span>Date.09.23</span></li>
<% end if %>

<% If left(currenttime,10)>="2015-09-16" Then %>
	<% if cstr(eCode2)=cstr(eCode) then %>
		<li class="nav0916"><a href="/event/eventmain.asp?eventid=<%= eCode2 %>" class="on">Date.09.16</a></li>
	<% else %>
		<li class="nav0916"><a href="/event/eventmain.asp?eventid=<%= eCode2 %>">Date.09.16</a></li>
	<% end if %>
<% else %>
	<li class="nav0916"><span>Date.09.16</span></li>
<% end if %>

<% If left(currenttime,10)>="2015-09-09" Then %>
	<% if cstr(eCode1)=cstr(eCode) then %>
		<li class="nav0909"><a href="/event/eventmain.asp?eventid=<%= eCode1 %>" class="on">Date.09.09</a></li>
	<% else %>
		<li class="nav0909"><a href="/event/eventmain.asp?eventid=<%= eCode1 %>">Date.09.09</a></li>
	<% end if %>
<% else %>
	<li class="nav0909"><span>Date.09.09</span></li>
<% end if %>