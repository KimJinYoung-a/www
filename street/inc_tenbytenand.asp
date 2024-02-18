<%
'###########################################################
' Description :  브랜드스트리트
' History : 2013.08.29 한용민 생성
'###########################################################
%>
<%
if tenbytenand_yn="Y" then

dim otenbytenand, it
set otenbytenand = new cTENBYTENand
	otenbytenand.frectmakerid = makerid
	otenbytenand.frectisusing = "Y"
	otenbytenand.FPageSize = 9
	otenbytenand.FCurrPage = 1
	
	if makerid<>"" then
		otenbytenand.sbTENBYTENlist
	end if
%>
<% if otenbytenand.Ftotalcount > 0 then %>
	<div class="wFix">
		<h4 class="line"><img src="http://fiximage.10x10.co.kr/web2013/brand/tit_tenbyten.gif" alt="TENBYTEN &amp;" /></h4>
		<div class="brBnrArea">
			<div class="linkList">
				<ul>
					<% for it = 0 to otenbytenand.Ftotalcount -1 %>
						<% if it="0" then %>
							<li class="current" id="brImg0<%= it+1 %>"><%= it+1 %></li>
						<% else %>
							<li id="brImg0<%= it+1 %>"><%= it+1 %></li>
						<% end if %>
					<% next %>
				</ul>
			</div>
	
			<% for it = 0 to otenbytenand.Ftotalcount -1 %>
				<% if otenbytenand.FItemList(it).FFlag="2" then %>
					<div class="bnrArea" id="vbrImg0<%= it+1 %>"><iframe src="<%= otenbytenand.FItemList(it).fplayurl %>" width="1140" height="100%" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe></div>
				<% else %>
					<div class="bnrArea" id="vbrImg0<%= it+1 %>"><img onclick="window.open('<%= otenbytenand.FItemList(it).FLinkurl %>','tenlink', 'width=1024, height=768,scrollbars=auto,resizable=yes'); return false;" src="<%= staticImgUrl %>/brandstreet/TENBYTEN/<%= otenbytenand.FItemList(it).fimgurl %>" alt="<%= otenbytenand.FItemList(it).fmakerid %>" style="cursor:pointer;" /></div>
				<% end if %>
			<% next %>
		</div>
	</div>
<% end if %>
<%
set otenbytenand = nothing

end if
%>