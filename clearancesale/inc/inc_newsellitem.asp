<%
'#############################################################
'	Description : 클리어런스 세일 롤링3 방금 판매된상품
'	History		: 2016.01.18 유태욱 생성
'#############################################################
%>
	<%'' 판매완료 %>
	<% if oNewsellitem.Fnowsellitemcnt > 4 then %>
		<div class="itemCont sellNow">
			<h3>방금 판매된 상품 입니다!</h3>
			<div class="pdtWrap pdt180V15">
				<ul class="pdtList">
				<% FOR i = 0 to 4 %>
					<li <% if oNewsellitem.FItemList(i).IsSoldOut then %>class="soldOut"<% end if %>><%'' for dev msg : 품절일경우 클래스 soldOut 붙여주세요 %>
						<div class="pdtBox">
							<strong class="pdtLabel"><em><%= oNewsellitem.FItemList(i).Gettimeset %></em></strong>
							<div class="pdtPhoto">
								<span class="soldOutMask"></span>
								<a href="/shopping/category_prd.asp?itemid=<%=oNewsellitem.FItemList(i).FItemid%>">
									<img src="<%= oNewsellitem.FItemList(i).FImageIcon1 %>" alt="<%= oNewsellitem.FItemList(i).FItemName %>" />
								</a>
							</div>
							<div class="pdtInfo">
								<p class="pdtBrand"><a href="" onclick="GoToBrandShop('<%= oNewsellitem.FItemList(i).FMakerId %>'); return false;"><%= oNewsellitem.FItemList(i).FBrandName %></a></p>
								<p class="pdtName tPad07"><a href="/shopping/category_prd.asp?itemid=<%=oNewsellitem.FItemList(i).FItemid%>"><%= oNewsellitem.FItemList(i).FItemName %></a></p>
								<%
									If oNewsellitem.FItemList(i).IsSaleItem or oNewsellitem.FItemList(i).isCouponItem Then
										'If oNewsellitem.FItemList(i).Fitemcoupontype <> "3" Then
										'	Response.Write "<p class='pdtPrice'><span class='txtML'>" & FormatNumber(oNewsellitem.FItemList(i).FOrgPrice,0) & "원 </span></p>"
										'End If
										IF oNewsellitem.FItemList(i).IsSaleItem Then
											Response.Write "<p class='pdtPrice'><span class='txtML'>" & FormatNumber(oNewsellitem.FItemList(i).FOrgPrice,0) & "원 </span></p>"
											Response.Write "<p class='pdtPrice'><span class='finalP'>" & FormatNumber(oNewsellitem.FItemList(i).getRealPrice,0) & "원 </span>"
											Response.Write "<strong class='cRd0V15'>[" & oNewsellitem.FItemList(i).getSalePro & "]</strong></p>"
								 		End IF
								 		IF oNewsellitem.FItemList(i).IsCouponItem Then
								 			if Not(oNewsellitem.FItemList(i).IsFreeBeasongCoupon() or oNewsellitem.FItemList(i).IsSaleItem) Then
								 				Response.Write "<p class='pdtPrice'><span class='txtML'>" & FormatNumber(oNewsellitem.FItemList(i).FOrgPrice,0) & "원 </span></p>"
								 			end if
											Response.Write "<p class='pdtPrice'><span class='finalP'>" & FormatNumber(oNewsellitem.FItemList(i).GetCouponAssignPrice,0) & "원 </span>"
											Response.Write "<strong class='cGr0V15'>[" & oNewsellitem.FItemList(i).GetCouponDiscountStr & "]</strong></p>"
								 		End IF
									Else
										Response.Write "<p class='pdtPrice'><span class='finalP'>" & FormatNumber(oNewsellitem.FItemList(i).getRealPrice,0) & "원 </span>"
									End If
								%>
							</div>
						</div>
					</li>
				<% next %>
				</ul>
			</div>
		</div>
	<% end if %>
	<%''// 판매완료 %>