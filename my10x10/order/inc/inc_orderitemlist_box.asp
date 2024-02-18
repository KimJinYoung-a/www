<%
Dim vIsPacked, packpaysum, packcnt
packpaysum = 0
packcnt = 0
vIsPacked = CHKIIF(myorder.FOneItem.FOrderSheetYN="P","Y","N")

'// IsTravelOrder 는 취소디테일에서 쓰이고 있다.
dim IsTravelOrderAA, vIsInterparkTravelExist, vIsDeliveItemExist
IsTravelOrderAA = False
vIsInterparkTravelExist = False
vIsDeliveItemExist = False
if (myorder.FOneItem.Fjumundiv <> "9") then
	IsTravelOrderAA = (myorder.FOneItem.Fjumundiv = "3")
else
	for i=0 to myorderdetail.FResultCount-1
		if (myorderdetail.FItemList(i).FItemdiv = "18") then
			IsTravelOrderAA = True
			exit for
		end if
	next
end if
%>
								<div class="title">
									<h4>주문상품정보</h4>
								</div>
								<table class="baseTable btmLine">
								<caption>주문상품정보 목록</caption>
								<colgroup>
									<col width="98" /><col width="70" /><col width="*" /><col width="90" /><col width="50" /><col width="90" /><col width="80" /><% If vIsPacked = "Y" Then %><col width="70" /><% End If %><col width="110" />
								</colgroup>
								<thead>
								<tr>
									<th scope="col">상품코드/배송</th>
									<% If (myorder.FOneItem.FAccountDiv="150") Then %>
										<th scope="col" colspan="3">상품정보</th>
									<% Else %>
										<th scope="col" colspan="2">상품정보</th>
										<th scope="col">판매가</th>
									<% End If %>
									<th scope="col">수량</th>
									<th scope="col">소계금액</th>
									<th scope="col">주문상태</th>
									<% If vIsPacked = "Y" Then %>
									<th scope="col" class="pkgInfoLyrV15a">
										<div class="infoMoreViewV15">
											<span>선물포장</span>
											<div class="infoViewLyrV15" style="display:none;">
												<div class="infoViewBoxV15">
													<dfn></dfn>
													<div class="infoViewV15">
														<div class="pad15">
															<p class="pkgOnV15a">선물포장이 <strong>가능</strong>한 상품</p>
															<p class="pkgActV15a">선물포장을 <strong>설정</strong>한 상품</p>
															<p class="pkgNoV15a">아이콘이 미표기된 상품은 선물포장을 <br />지원하지 않는 상품입니다.</p>
														</div>
													</div>
												</div>
											</div>
										</div>
									</th>
									<% End If %>
									<th scope="col">택배정보</th>
								</tr>
								</thead>
								<tbody>
								<%
								for i=0 to myorderdetail.FResultCount-1
									if (myorderdetail.FItemList(i).FItemdiv = "18" AND myorderdetail.FItemList(i).Fmakerid = "interparktour") then
										vIsInterparkTravelExist = True
									end if

									'### 인터파크여행상품이 있으면서 일반 상품도 있는지 체크. 일반상품있는경우 따로 체크되는 변수있어야함.
									If Not(myorderdetail.FItemList(i).Fitemdiv = "18" AND myorderdetail.FItemList(i).Fmakerid = "interparktour") Then
										vIsDeliveItemExist = True
									End If

									If myorderdetail.FItemList(i).FItemid <> 100 Then	'### 선물포장은 제외. 선물포장비합계는 내야함.
								%>
									<tr>
										<td>
											<div><%=myorderdetail.FItemList(i).FItemid%></div>
											<div><%=myorderdetail.FItemList(i).getDeliveryTypeName %></div>
										</td>
										<td><a href="javascript:ZoomItemInfo('<%= myorderdetail.FItemList(i).FItemid %>');" title="상품 자세히 보기"><img src="<%= myorderdetail.FItemList(i).FImageSmall %>" width="50" height="50" alt="<%= myorderdetail.FItemList(i).FItemName %>" /></a></td>
										<td class="lt">
											<div><a href="javascript:ZoomItemInfo('<%= myorderdetail.FItemList(i).FItemid %>');" title="상품 자세히 보기"><%= myorderdetail.FItemList(i).FItemName %></a></div>
											<% if myorderdetail.FItemList(i).FItemoptionName <> "" then %>
											<div><strong>옵션 : <%= myorderdetail.FItemList(i).FItemoptionName %></strong></div>
											<% end if %>
										</td>
										<% If (myorder.FOneItem.FAccountDiv="150") Then %>
											<td></td>
										<% Else %>
											<td>
												<% if (myorderdetail.FItemList(i).IsSaleItem) then %>
													<strike><%= FormatNumber(myorderdetail.FItemList(i).Forgitemcost,0) %></strike><%= CHKIIF(myorderdetail.FItemList(i).IsMileShopSangpum,"Pt","원") %><br>
													<strong class="crRed"><%= FormatNumber(myorderdetail.FItemList(i).getItemcostCouponNotApplied,0) %></strong><%= CHKIIF(myorderdetail.FItemList(i).IsMileShopSangpum,"Pt","원") %>
												<% else %>
													<% if (myorderdetail.FItemList(i).IsItemCouponAssignedItem) then %>
													<strike><%= FormatNumber(myorderdetail.FItemList(i).getItemcostCouponNotApplied,0) %></strike><%= CHKIIF(myorderdetail.FItemList(i).IsMileShopSangpum,"Pt","원") %>
													<% else %>
													<%= FormatNumber(myorderdetail.FItemList(i).getItemcostCouponNotApplied,0) %><%= CHKIIF(myorderdetail.FItemList(i).IsMileShopSangpum,"Pt","원") %>
													<% end if %>
												<% end if %>


												<% if (myorderdetail.FItemList(i).IsItemCouponAssignedItem) then %>
													<br><strong class="crGrn"><%= FormatNumber(myorderdetail.FItemList(i).FItemCost,0) %> 원</strong>
												<% else %>

												<% end if %>

												<% if (myorderdetail.FItemList(i).IsSaleBonusCouponAssignedItem) then %>
												<p class="crRed"><img src='http://fiximage.10x10.co.kr/web2008/shoppingbag/coupon_icon.gif' width='10' height='10' > <%= FormatNumber(myorderdetail.FItemList(i).getReducedPrice,0) %><%= CHKIIF(myorderdetail.FItemList(i).IsMileShopSangpum,"Pt","원") %></p>
												<% end if %>
											</td>
										<% End If %>
										<td><%= myorderdetail.FItemList(i).FItemNo %>
											<%
												If myorderdetail.FItemList(i).FIsPacked = "Y" Then
													Response.Write "<br /><span class=""cRd0V15"">(포장상품 " & fnGetPojangItemCount(myorderdetail.FItemList(i).FOrderSerial, myorderdetail.FItemList(i).FItemid, myorderdetail.FItemList(i).FItemoption) & ")</span>"
												End If
											%>
										</td>
										<td>
											<% If (myorder.FOneItem.FAccountDiv="150") Then %>
												<%=iniRentalMonthLength%>개월 간 월 <%=formatnumber(iniRentalMonthPrice,0)%>원
											<% Else %>
												<%= FormatNumber(myorderdetail.FItemList(i).FItemCost*myorderdetail.FItemList(i).FItemNo,0) %> <%= CHKIIF(myorderdetail.FItemList(i).IsMileShopSangpum,"Pt","원") %>
												<% if (myorderdetail.FItemList(i).IsSaleBonusCouponAssignedItem) then %>
												<p class="crRed"><img src='http://fiximage.10x10.co.kr/web2008/shoppingbag/coupon_icon.gif' width='10' height='10' > <%= FormatNumber(myorderdetail.FItemList(i).getReducedPrice*myorderdetail.FItemList(i).FItemNo,0) %><%= CHKIIF(myorderdetail.FItemList(i).IsMileShopSangpum,"Pt","원") %></p>
												<% end if %>
											<% End If %>
										</td>
										<td >
											<%
											'/품절출고불가 상품		'/2016.03.31 한용민 추가
											if myorderdetail.FItemList(i).Fmibeasoldoutyn="Y" then
											%>
												품절 <a href="/my10x10/orderpopup/popcancelorder.asp?mode=so&orderserial=<%= myorderdetail.FItemList(i).FOrderSerial %>" onclick="window.open(this.href, 'popDepositor', 'width=925, height=800, scrollbars=yes'); return false;" class="btn btnS2 btnRed"><span class="fn">주문취소</span>
											<% else %>
												<%= myorderdetail.FItemList(i).GetItemDeliverStateNameNew(myorder.FOneItem.FIpkumDiv, myorder.FOneItem.FCancelyn, myorder.FOneItem.Fbaljudate, myorder.FOneItem.FTenbeasongCnt) %>
											<% end if %>
										</td>

										<% If vIsPacked = "Y" Then %>
											<td>
												<%
												If myorderdetail.FItemList(i).FIsPacked = "Y" Then	'### 내가포장했는지
													Response.Write "<img src=""http://fiximage.10x10.co.kr/web2015/shopping/ico_pakage_act.png"" alt=""상품요청상품"" />"
												End If
												%>
											</td>
										<% End If %>

										<td>
											<%= myorderdetail.FItemList(i).GetDeliveryName %><br>
											<%= myorderdetail.FItemList(i).GetSongjangURL %>
                                            <%
                                            if IsAddSongjangExist then
                                                for j = 0 to oAddSongjang.FResultCount - 1
                                                    if ((myorderdetail.FItemList(i).Fisupchebeasong = "N") and (oAddSongjang.FItemList(j).Fmakerid = "")) or _
                                                        ((myorderdetail.FItemList(i).Fisupchebeasong = "Y") and (oAddSongjang.FItemList(j).Fmakerid = myorderdetail.FItemList(i).Fmakerid)) then
                                            %>
                                            <br /><%= oAddSongjang.FItemList(j).GetDeliveryName %><br />
                                            <%= oAddSongjang.FItemList(j).GetSongjangURL %>
                                            <%
                                                    end if
                                                next
                                            end if
                                            %>
										</td>
									</tr>
								<%
									Else
										packcnt = packcnt + myorderdetail.FItemList(i).Fitemno	'### 총결제금액에 사용. 상품종수, 갯수 -1 해줌.
										packpaysum = packpaysum + myorderdetail.FItemList(i).FItemCost * myorderdetail.FItemList(i).Fitemno
									End If
								next
								%>
								</tbody>
								<tfoot>
								<tr>
									<td colspan="9">
										<div class="orderSummary">
											<span>주문상품수 <strong><%=CHKIIF(packcnt>0,myorderdetail.FResultCount-1,myorderdetail.FResultCount)%>종
											(<%= FormatNumber(myorder.FOneItem.GetTotalOrderItemCount(myorderdetail),0)-packcnt %>개)</strong></span>
											<% If (myorder.FOneItem.FAccountDiv<>"150") Then %>
												<span>적립 마일리지 <strong><%= FormatNumber(myorder.FOneItem.Ftotalmileage,0) %>P</strong></span>
												<span>상품구매 총액 <strong><%= FormatNumber(myorder.FOneItem.FTotalSum-myorder.FOneItem.FDeliverPrice-packpaysum,0) %>원</strong></span>
											<% End If %>
										</div>
										<% If myorder.FOneItem.FAccountDiv="150" then %>
											<div class="orderTotal">
												총 결제금액 : <strong class="crRed"><%=iniRentalMonthLength%></strong>개월 간 월 <strong class="crRed"><%=formatnumber(iniRentalMonthPrice,0)%></strong>원
											</div>
										<% Else %>
											<div class="orderTotal">
												총 결제금액 :
												상품구매총액 <strong><%= FormatNumber(myorder.FOneItem.FTotalSum-myorder.FOneItem.FDeliverPrice-packpaysum,0) %></strong>원
												(상품수 <%= CHKIIF(packcnt>0,myorderdetail.FResultCount-1,myorderdetail.FResultCount) %>종
												<%= FormatNumber(myorder.FOneItem.GetTotalOrderItemCount(myorderdetail),0)-packcnt %>개)
												<%=CHKIIF(vIsPacked="Y"," + 선물포장비 " & FormatNumber(packpaysum,0) & "원","")%>
												+ <%= CHKIIF(IsTravelOrderAA and myorder.FOneItem.Fjumundiv="9","취소수수료", "배송비") %> <%= FormatNumber(myorder.FOneItem.FDeliverpriceCouponNotApplied,0) %>원 <!-- 배송비 쿠폰 적용전 -->
													<% if (myorder.FOneItem.FDeliverpriceCouponNotApplied>myorder.FOneItem.FDeliverprice) then %>
												- 배송비쿠폰할인 <%= FormatNumber(myorder.FOneItem.FDeliverpriceCouponNotApplied-myorder.FOneItem.FDeliverprice,0) %>원
													<% end if %>
													<% if myorder.FOneItem.FArriveDeliverCnt > 0 then %>
												+ 착불배송비 별도
													<% end if %>
													<% IF (myorder.FOneItem.Fmiletotalprice<>0) then %>
												- 마일리지 <%= FormatNumber(myorder.FOneItem.Fmiletotalprice,0) %>원
													<% end if %>
													<% IF (myorder.FOneItem.Ftencardspend<>0) then %>
												- 보너스쿠폰할인 <%= FormatNumber(myorder.FOneItem.Ftencardspend,0) %>원
													<% end if %>
													<% if (myorder.FOneItem.Fallatdiscountprice + myorder.FOneItem.Fspendmembership<>0) then %>
												- 기타할인 <%= FormatNumber((myorder.FOneItem.Fallatdiscountprice + myorder.FOneItem.Fspendmembership),0) %>원
													<% end if %>
												= <strong class="crRed"><%= FormatNumber(myorder.FOneItem.FsubtotalPrice,0) %></strong> 원
											</div>
										<% End If %>
									</td>
								</tr>
								</tfoot>
								</table>
			                    <%
									''구매금액별 선택 사은품
									Dim oOpenGift
									Set oOpenGift = new CopenGift
									oOpenGift.FRectOrderserial = orderserial

									if userid<>"" then
										if (isEvtGiftDisplay) then
											oOpenGift.getGiftListInOrder
										else
										    oOpenGift.getOpenGiftInOrder
										end if
									end if

			                    	if (oOpenGift.FResultCount>0) then
			                    %>
								<ul class="box5 tPad10 bPad10 lPad20 list01 cr777 fs11 lh19">
								    <% for j=0 to oOpenGift.FREsultCount-1 %>
								    <% if (oOpenGift.FItemList(j).Fchg_giftStr<>"") then %>
								    <li><%= oOpenGift.FItemList(j).Fevt_name %> - 사은품 선택 : <%= oOpenGift.FItemList(j).Fchg_giftStr %></li>
								    <% else %>
								    <li><%= oOpenGift.FItemList(j).Fevt_name %> : <%= oOpenGift.FItemList(j).Fgiftkind_name %></li>
								    <% end if %>

									<% if (oOpenGift.FItemList(j).Fgiftkind_cnt>1)  then %>
			                    	&nbsp;(<%=oOpenGift.FItemList(j).Fgiftkind_cnt%>)개
			                    	<% end if %>
									<% next %>
								</ul>
			                    <%
			                    	end if
			                    	Set oOpenGift = Nothing
			                    %>
								<% if (myorder.FOneItem.FAccountDiv="150") and (myorder.FOneItem.FIpkumDiv >= 4) then %>
									<%'<!-- for dev msg : 이니시스 렌탈 주문상세 렌탈정보 추가 -->%>
									<div class="title">
										<h4>렌탈 정보</h4>
									</div>
									<table class="baseTable rowTable">
									<caption>렌탈정보</caption>
									<colgroup>
										<col width="130" />
										<col width="*" />
									</colgroup>
									<tbody>
									<tr>
										<th scope="row">렌탈 현황</th>
										<td>
											<div class="rental-service-info">
												<button type="button" class="btn btnS2 btnRed" onclick="receiptinirental('<%=iniRentalAesEncodeTid%>','<%=iniRentalMid%>')"><span class="fn">조회하기</span></button>
												<p>서비스 문의 : KG 이니시스 렌탈 고객센탈 고객센터</p>
												<p class="number">1800-1739</p>
											</div>
										</td>
									</tr>
									</tbody>
									</table>
									<%'<!-- //이니시스 렌탈 주문상세 렌탈정보 추가 -->%>
								<% End If %>
