<%
'#############################################################
'	Description : 클리어런스 세일 롤링1 실시간 인기급상승
'	History		: 2016.01.18 유태욱 생성
'#############################################################
%>
	<%'' 인기 급상승 %>
	<% if obestitem.Fbestitem > 4 then %>
		<div class="itemCont popular">
			<h3>실시간 인기 급상승!</h3>
			<div class="pdtWrap pdt180V15">
				<ul class="pdtList">
				<% FOR i = 0 to 4 %>
					<li <% if obestitem.FItemList(i).IsSoldOut then %>class="soldOut"<% end if %>><%'' for dev msg : 품절일경우 클래스 soldOut 붙여주세요 %>
						<div class="pdtBox">
							<div class="pdtPhoto">
								<span class="soldOutMask"></span>
								<a href="/shopping/category_prd.asp?itemid=<%=obestitem.FItemList(i).FItemid%>">
									<img src="<%= obestitem.FItemList(i).FImageIcon1 %>" alt="<%= obestitem.FItemList(i).FItemName %>" />
								</a>
							</div>
							<div class="pdtInfo">
								<p class="pdtBrand"><a href="" onclick="GoToBrandShop('<%= obestitem.FItemList(i).FMakerId %>'); return false;"><%= obestitem.FItemList(i).FBrandName %></a></p>
								<p class="pdtName tPad07"><a href="/shopping/category_prd.asp?itemid=<%=obestitem.FItemList(i).FItemid%>"><%= obestitem.FItemList(i).FItemName %></a></p>
								<%
									If obestitem.FItemList(i).IsSaleItem or obestitem.FItemList(i).isCouponItem Then
										'If obestitem.FItemList(i).Fitemcoupontype <> "3" Then
										'	Response.Write "<p class='pdtPrice'><span class='txtML'>" & FormatNumber(obestitem.FItemList(i).FOrgPrice,0) & "원 </span></p>"
										'End If
										IF obestitem.FItemList(i).IsSaleItem Then
											Response.Write "<p class='pdtPrice'><span class='txtML'>" & FormatNumber(obestitem.FItemList(i).FOrgPrice,0) & "원 </span></p>"
											Response.Write "<p class='pdtPrice'><span class='finalP'>" & FormatNumber(obestitem.FItemList(i).getRealPrice,0) & "원 </span>"
											Response.Write "<strong class='cRd0V15'>[" & obestitem.FItemList(i).getSalePro & "]</strong></p>"
								 		End IF
								 		IF obestitem.FItemList(i).IsCouponItem Then
								 			if Not(obestitem.FItemList(i).IsFreeBeasongCoupon() or obestitem.FItemList(i).IsSaleItem) Then
								 				Response.Write "<p class='pdtPrice'><span class='txtML'>" & FormatNumber(obestitem.FItemList(i).FOrgPrice,0) & "원 </span></p>"
								 			end if
											Response.Write "<p class='pdtPrice'><span class='finalP'>" & FormatNumber(obestitem.FItemList(i).GetCouponAssignPrice,0) & "원 </span>"
											Response.Write "<strong class='cGr0V15'>[" & obestitem.FItemList(i).GetCouponDiscountStr & "]</strong></p>"
								 		End IF
									Else
										Response.Write "<p class='pdtPrice'><span class='finalP'>" & FormatNumber(obestitem.FItemList(i).getRealPrice,0) & "원 </span>"
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
	<%''// 인기 급상승 %>