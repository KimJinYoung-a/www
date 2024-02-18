<%
dim rebankname, rebankownername, encaccount
fnSoldOutMyRefundInfo userid, rebankname, rebankownername, encaccount
%>

								<!-- 품절 시 처리 방법 -->
								<% if rebankname <> "" and (myorder.FOneItem.FAccountdiv="7" or myorder.FOneItem.FAccountdiv="20") then %>
								<div class="title">
									<h4>품절 시 처리 방법</h4>
									<% if myorder.FOneItem.FIpkumDiv="2" or myorder.FOneItem.FIpkumDiv="3" or myorder.FOneItem.FIpkumDiv="4" or myorder.FOneItem.FIpkumDiv="5" then %>
									<a href="/my10x10/order/myorder_refund_info_edit.asp" title="새창에서 열림" onclick="window.open(this.href, 'popName', 'width=925, height=400, scrollbars=yes'); return false;" class="btn btnS2 btnRed"><span class="fn">환불 계좌 정보 변경</span></a>
                                    <% end if %>
								</div>
								<table class="baseTable rowTable">
								<caption>품절 시 처리 방법</caption>
								<colgroup>
									<col width="130" /> <col width="295" /> <col width="130" /> <col width="*" />
								</colgroup>
								<tbody>
								<tr>
									<th scope="row">처리 방법</th>
									<td>입력된 계좌로 환불</td>
									<th scope="row">은행</th>
									<td><%=rebankname%></td>
								</tr>
								<tr>
									<th scope="row">계좌번호</th>
									<td><%=encaccount%></td>
									<th scope="row">예금주</th>
									<td><%=rebankownername%></td>
								</tr>
								</tbody>
								</table>
                                <% else %>
								<div class="title">
									<h4>품절 시 처리 방법</h4>
								</div>
								<table class="baseTable rowTable">
								<caption>품절 시 처리 방법</caption>
								<colgroup>
									<col width="130" /> <col width="*" />
								</colgroup>
								<tbody>
								<tr>
									<th scope="row">처리 방법</th>
									<td>결제 취소</td>
								</tr>
								</tbody>
								</table>
								<% end if %>
								<!-- 품절 시 처리 방법 -->