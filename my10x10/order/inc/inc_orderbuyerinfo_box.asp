
								<div class="title">
									<h4 class="">구매자정보</h4>
									<% if (MyOrdActType = "E") then %>
										<% if (myorder.FOneItem.IsWebOrderInfoEditEnable) then %>
											<a href="javascript:popEditOrderInfo('<%= orderserial %>','ordr');" title="구매자정보 변경" class="btn btnS2 btnGrylight"><span class="fn">구매자 정보변경</span></a>
										<% end if %>
									<% end if %>
								</div>
<!-- 640, 460 -->
								<table class="baseTable rowTable">
								<caption>구매자정보</caption>
								<colgroup>
									<col width="130" /> <col width="210" /> <col width="130" /> <col width="*" />
								</colgroup>
								<tbody>
								<tr>
									<th scope="row">주문하시는 분</th>
									<td><%= myorder.FOneItem.FBuyName %></td>
									<th scope="row">이메일 주소</th>
									<td><%= myorder.FOneItem.FBuyEmail %></td>
								</tr>
								<tr>
									<th scope="row"> 전화번호</th>
									<td><%= myorder.FOneItem.FBuyPhone %></td>
									<th scope="row">휴대전화 번호</th>
									<td><%= myorder.FOneItem.FBuyhp %></td>
								</tr>
								</tbody>
								</table>
