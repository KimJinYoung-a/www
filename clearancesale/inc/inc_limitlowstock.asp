<%
'#############################################################
'	Description : 클리어런스 세일 롤링2 매진임박 재고 30개이하상품
'	History		: 2016.01.18 유태욱 생성
'#############################################################
%>
	<%'' 매진임박 %>
	<% if oLimitedLowStock.FLowStockcnt > 4 then %>
		<div class="itemCont selloutSoon">
			<h3>재고가 얼마 남지 않았어요!</h3>
			<div class="pdtWrap pdt180V15">
				<ul class="pdtList">
				<% FOR i = 0 to 4 %>
					<li <% if oLimitedLowStock.FItemList(i).IsSoldOut then %>class="soldOut"<% end if %>><%'' for dev msg : 품절일경우 클래스 soldOut 붙여주세요 %>
						<div class="pdtBox">
							<strong class="pdtLabel"><em><%= oLimitedLowStock.FItemList(i).FLimitedLowStock %></em>개 한정</strong>
							<div class="pdtPhoto">
								<span class="soldOutMask"></span>
								<a href="/shopping/category_prd.asp?itemid=<%=oLimitedLowStock.FItemList(i).FItemid%>">
									<img src="<%= oLimitedLowStock.FItemList(i).FImageIcon1 %>" alt="<%= oLimitedLowStock.FItemList(i).FItemName %>" />
								</a>
							</div>
							<div class="pdtInfo">
								<p class="pdtBrand"><a href="" onclick="GoToBrandShop('<%= oLimitedLowStock.FItemList(i).FMakerId %>'); return false;"><%= oLimitedLowStock.FItemList(i).FBrandName %></a></p>
								<p class="pdtName tPad07"><a href="/shopping/category_prd.asp?itemid=<%=oLimitedLowStock.FItemList(i).FItemid%>"><%= oLimitedLowStock.FItemList(i).FItemName %></a></p>
								<%
									If oLimitedLowStock.FItemList(i).IsSaleItem or oLimitedLowStock.FItemList(i).isCouponItem Then
										'If oLimitedLowStock.FItemList(i).Fitemcoupontype <> "3" Then
										'	Response.Write "<p class='pdtPrice'><span class='txtML'>" & FormatNumber(oLimitedLowStock.FItemList(i).FOrgPrice,0) & "원 </span></p>"
										'End If
										IF oLimitedLowStock.FItemList(i).IsSaleItem Then
											Response.Write "<p class='pdtPrice'><span class='txtML'>" & FormatNumber(oLimitedLowStock.FItemList(i).FOrgPrice,0) & "원 </span></p>"
											Response.Write "<p class='pdtPrice'><span class='finalP'>" & FormatNumber(oLimitedLowStock.FItemList(i).getRealPrice,0) & "원 </span>"
											Response.Write "<strong class='cRd0V15'>[" & oLimitedLowStock.FItemList(i).getSalePro & "]</strong></p>"
								 		End IF
								 		IF oLimitedLowStock.FItemList(i).IsCouponItem Then
								 			if Not(oLimitedLowStock.FItemList(i).IsFreeBeasongCoupon() or oLimitedLowStock.FItemList(i).IsSaleItem) Then
								 				Response.Write "<p class='pdtPrice'><span class='txtML'>" & FormatNumber(oLimitedLowStock.FItemList(i).FOrgPrice,0) & "원 </span></p>"
								 			end if
											Response.Write "<p class='pdtPrice'><span class='finalP'>" & FormatNumber(oLimitedLowStock.FItemList(i).GetCouponAssignPrice,0) & "원 </span>"
											Response.Write "<strong class='cGr0V15'>[" & oLimitedLowStock.FItemList(i).GetCouponDiscountStr & "]</strong></p>"
								 		End IF
									Else
										Response.Write "<p class='pdtPrice'><span class='finalP'>" & FormatNumber(oLimitedLowStock.FItemList(i).getRealPrice,0) & "원 </span>"
									End If
								%>
							</div>
						</div>
					</li>
				<% next %>
				</ul>
			</div>
		</div>
		<%''// 매진임박 %>
	<% end if %>