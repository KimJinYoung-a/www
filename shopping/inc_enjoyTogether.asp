<%
	dim oHTBCItem
	set oHTBCItem = New CAutoCategory
	oHTBCItem.FRectItemId = itemid
	oHTBCItem.FRectDisp = catecode

	oHTBCItem.GetCateRightHappyTogetherNCateBestItemList

	if oHTBCItem.FResultCount>0 then
%>
	<ul class="pdtList">
	<%	For iLp = 0 To oHTBCItem.FResultCount - 1 %>
	<%		if iLp>3 then Exit For %>
		<li>
			<p class="pdtPhoto"><a href="/shopping/category_prd.asp?itemid=<%= oHTBCItem.FItemList(iLp).Fitemid %>"><img src="<%=getThumbImgFromURL(oHTBCItem.FItemList(iLp).FIcon1Image,150,150,"true","false")%>" alt="<%=Replace(oHTBCItem.FItemList(iLp).FitemName,"""","")%>" /></a></p>
			<p class="pdtBrand tPad15"><a href="/street/street_brand.asp?makerid=<%= oHTBCItem.FItemList(iLp).FMakerid %>"><%= UCase(oHTBCItem.FItemList(iLp).FBrandName) %></a></p>
			<p class="pdtName tPad05"><a href="/shopping/category_prd.asp?itemid=<%= oHTBCItem.FItemList(iLp).Fitemid %>"><%=chrbyte(oHTBCItem.FItemList(iLp).FitemName,12,"Y")%></a></p>
			<p class="pdtPrice tPad05">
				<strong><% = FormatNumber(oHTBCItem.FItemList(iLp).getRealPrice,0) %>원</strong>
				<% If oHTBCItem.FItemList(iLp).IsSaleItem Then %>
				<strong class="cRd0V15">[<% = oHTBCItem.FItemList(iLp).getSalePro %>]</strong>
				<% end if %>
			</p>
		</li>
	<%	Next %>
	</ul>
<%
	else
		'버튼없앰
		Response.Write "<script>$('.recommendItemV15 .itemNaviV15 .item02').hide();</script>"
	end if
	set oHTBCItem = nothing
%>