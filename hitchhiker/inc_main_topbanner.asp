<%
'#############################################################
'	Description : HITCHHIKER
'	History		: 2014.08.06 유태욱 생성
'#############################################################
%>
<%
Dim omainbanner
set omainbanner = new CHitchhikerlist
	omainbanner.Frectisusing = "Y"
	omainbanner.FrectCurrentpreview = "Y"
	omainbanner.FPageSize = 10
	omainbanner.FCurrPage = 1
	omainbanner.fnGetmainbanner
%>
<% if omainbanner.FResultCount > 0 then %>
	<% for i = 0 to omainbanner.FResultCount - 1 %>
		<% if omainbanner.FItemList(i).FReqgubun = "1" then %>
			<% ' 링크 %>
			<div class=<% if omainbanner.FItemList(i).FReqlinkurl = "" then response.write "hitlist" %>>
				<a href=<% if omainbanner.FItemList(i).FReqlinkurl = "" then response.write "#hichlist" else response.write omainbanner.FItemList(i).FReqlinkurl end if %>><img src="<%= omainbanner.FItemList(i).FReqcon_viewthumbimg %>" alt="<%= i %>" /></a>
			</div>
		<% elseif omainbanner.FItemList(i).FReqgubun = "2" then %>
			<% ' 레이어팝업 %>
			<div class="vip">
				<p><a href="#lyVip" onclick="topLayer(); return false;"><img src="<%= omainbanner.FItemList(i).FReqcon_viewthumbimg %>" alt="<%= i %>" /></a></p>
			</div>
		<% elseif omainbanner.FItemList(i).FReqgubun = "4" then %>
			<% ' 모집&발간 %>
			<div class="essayediter">
				<p><a href="#handwork"><img src="<%= omainbanner.FItemList(i).FReqcon_viewthumbimg %>" alt="<%= i %>" /></a></p>
			</div>
		<% else %>
			<% ' OnlyView %>
			<div><img src="<%= omainbanner.FItemList(i).FReqcon_viewthumbimg %>" alt="<%= i %>" /></div>
		<% end if %>
	<% next %>
<% end if %>
<% set omainbanner = nothing %>