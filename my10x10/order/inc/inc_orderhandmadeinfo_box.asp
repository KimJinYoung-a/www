	<div class="title">
		<h4>주문제작상품</h4>
	</div>
	<table class="baseTable">
	<caption>주문제작상품 목록</caption>
	<colgroup>
		<col width="140" /> <col width="70" /> <col width="*" /> <col width="150" /> <col width="170" />
	</colgroup>
	<thead>
	<tr>
		<th scope="col">상품코드/배송</th>
		<th scope="col" colspan="2">상품정보</th>
		<th scope="col">수량</th>
		<th scope="col">상태</th>
	</tr>
	</thead>
	<tbody>
<% for i=0 to myorderdetail.FResultCount-1 %>
	<% if (myorderdetail.FItemList(i).IsRequireDetailExistsItem) or (myorderdetail.FItemList(i).ISFujiPhotobookItem) then %>
	<tr>
		<td rowspan="2">
			<div><%=myorderdetail.FItemList(i).FItemid%></div>
			<div><%=myorderdetail.FItemList(i).getDeliveryTypeName %></div>
		</td>
		<td><a href="javascript:ZoomItemInfo(<%= myorderdetail.FItemList(i).FItemid %>,'new');"><img src="<%= myorderdetail.FItemList(i).FImageSmall %>" width="50" height="50" alt="<%= myorderdetail.FItemList(i).FItemName %>" /></a></td>
		<td class="lt">
			<div><a href="javascript:ZoomItemInfo(<%= myorderdetail.FItemList(i).FItemid %>,'new');"><%= myorderdetail.FItemList(i).FItemName %><br> <strong><%= myorderdetail.FItemList(i).FItemoptionName %></strong></a></div>
		</td>
		<td><%= myorderdetail.FItemList(i).FItemNo %></td>
		<td>
		<% if (myorderdetail.FItemList(i).ISFujiPhotobookItem) then %>
			<% if ((myorderdetail.FItemList(i).IsEditAvailState) or (myorderdetail.FItemList(i).Frequiredetail="")) then %>
				<div><span><%= myorderdetail.FItemList(i).GetItemDeliverStateName(myorder.FOneItem.FIpkumDiv, myorder.FOneItem.FCancelyn) %></span></div>
				<div class="tPad03"><a href="javascript:editPhotolooks('<%= orderserial %>','<%= myorderdetail.FItemList(i).Fidx %>','<%= myorderdetail.FItemList(i).FItemid %>','<%= myorderdetail.FItemList(i).FItemoption %>','<%= myorderdetail.FItemList(i).getPhotobookFileName %>');" title="새창에서 열림" class="btn btnS2 btnGry"><span class="fn">포토북 수정</span></a></div>
			<% else %>
				<div><em class="crRed"><%= myorderdetail.FItemList(i).GetItemDeliverStateName(myorder.FOneItem.FIpkumDiv, myorder.FOneItem.FCancelyn) %></em></div>
				<div class="tPad01"><strong class="crRed">[문구수정 불가]</strong></div>
			<% End If %>
		<% else %>
			<% if (myorderdetail.FItemList(i).IsRequireDetailExistsItem) and (myorderdetail.FItemList(i).IsEditAvailState) then %>
				<div><span><%= myorderdetail.FItemList(i).GetItemDeliverStateName(myorder.FOneItem.FIpkumDiv, myorder.FOneItem.FCancelyn) %></span></div>
				<div class="tPad03"><a href="javascript:popEditHandMadeReq('<%= orderserial %>','<%= myorderdetail.FItemList(i).Fidx %>');" title="주문제작상품 문구수정 팝업열기"  class="btn btnS2 btnGry"><span class="fn">문구수정</span></a></div>
			<% else %>
				<div><em class="crRed"><%= myorderdetail.FItemList(i).GetItemDeliverStateName(myorder.FOneItem.FIpkumDiv, myorder.FOneItem.FCancelyn) %></em></div>
				<div class="tPad01"><strong class="crRed">[문구수정 불가]</strong></div>
			<% end if %>
		<% end if %>
		</td>
	</tr>
	<tr class="orderWord">
		<td colspan="4">
            <% if myorderdetail.FItemList(i).ISFujiPhotobookItem then %>
                <p class="message">포토룩스 상품</p>
            <% else %>
				<% if IsNULL(myorderdetail.FItemList(i).Frequiredetail) or (myorderdetail.FItemList(i).Frequiredetail="") then %>
				<p class="message">주문제작문구를 넣어주세요.</p>
				<% else %>
				<p class="message"><strong>주문제작문구</strong> : <%= nl2Br(myorderdetail.FItemList(i).getRequireDetailHtml) %></p>
				<% end if %>
			<% end if %>
		</td>
	</tr>

	<% end if %>
<% next %>

	</tbody>
	</table>
