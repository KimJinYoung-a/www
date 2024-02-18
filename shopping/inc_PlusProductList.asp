<% ''//PLUS SALE 메인 상품 상세 화면 / 서브 상품 정보
	dim oPlusSaleMainItem, plusmj
	set oPlusSaleMainItem = new CSetSaleItem
	oPlusSaleMainItem.FRectItemID = itemid

	if (oPlusSaleMainItem.IsSetSaleLinkItem) then
		oPlusSaleMainItem.GetPlusMainProductList
	end if

	if oPlusSaleMainItem.FResultCount>0 then
%>
<div class="plusSaleVItem17">
	<div class="hgroup">
		<h3>PLUS ITEM</h3>
		<p>함께 구매하면 좋아요!</p>
	</div>

	<div class="item typeA">
		<ul>
			<%' for dev msg : 갯수 상관없음 %>
			<% for plusmj=0 to (oPlusSaleMainItem.FResultCount-1) %>
				<li>
					<%' 마우스 오버시 Quick보기 popup으로 링크 %>
					<a href="" onclick="ZoomItemInfo(<%= oPlusSaleMainItem.FItemList(plusmj).FItemID %>); return false;">
						<span class="thumbnail">
							<img src="<%= oPlusSaleMainItem.FItemList(plusmj).FImageBasic %>" width="130" height="130" alt="" />
							<span class="btnView"><i></i>자세히보기</span>
						</span>
						<div class="desc">
							<div class="inner">
								<span class="no">상품 <%=plusmj+1%></span>
								<p class="name"><%= Replace(oPlusSaleMainItem.FItemList(plusmj).FItemName,Chr(34),"") %></p>
								<div class="price">
									<% IF (oPlusSaleMainItem.FItemList(plusmj).FSaleYn="Y") and (oPlusSaleMainItem.FItemList(plusmj).FOrgPrice-oPlusSaleMainItem.FItemList(plusmj).FSellCash>0) THEN %>
										<div>
											<span>할인판매가</span> 
											<s>
												<%
													Response.Write FormatNumber(oPlusSaleMainItem.FItemList(plusmj).FSellCash,0) & chkIIF(oPlusSaleMainItem.FItemList(plusmj).IsMileShopitem,"Point","원") & " ["
													If oPlusSaleMainItem.FItemList(plusmj).FOrgprice = 0 Then
														Response.Write "0%]"
													Else
														Response.Write CLng((oPlusSaleMainItem.FItemList(plusmj).FOrgPrice-oPlusSaleMainItem.FItemList(plusmj).FSellCash)/oPlusSaleMainItem.FItemList(plusmj).FOrgPrice*100) & "%]"
													End If
												%>
											</s>
										</div>
									<% Else %>
										<div><span>판매가</span> <s><%= FormatNumber(oPlusSaleMainItem.FItemList(plusmj).getOrgPrice,0) & chkIIF(oPlusSaleMainItem.FItemList(plusmj).IsMileShopitem,"Point","원")%></s></div>
									<% End If %>
									<div><span>플러스세일가</span> <b><%= FormatNumber(oPlusSaleMainItem.FItemList(plusmj).GetPLusSalePrice, 0) %>원
										<% if oPlusSaleMainItem.FItemList(plusmj).FPLusSalePro>0 then %>
										[<%= oPlusSaleMainItem.FItemList(plusmj).FPLusSalePro %>%]
										<% end if %>
									</b></div>
								</div>
							</div>
						</div>
					</a>
				</li>
			<% next %>
		</ul>
	</div>

	<ul class="list01V15">
		<li>본 상품과 PLUS ITEM 상품 구성은 변동될 수 있습니다.</li>
		<li>PLUS ITEM 상품에 추가 할인이 있었을 경우, 본상품을 구매 취소 하면 추가 할인이 적용 되지 않음을 유의해주세요.</li>
		<li>자세한 문의 사항은 1:1게시판 또는 고객행복센터(1644-6030)를 이용해 주세요.</li>
	</ul>
</div>
<%
	end if
	set oPlusSaleMainItem = nothing
%>

<%
   ''// PLUS SALE 서브 상품 상세 영역 / 메인 상품 정보
	dim oPlusSaleSubItem, plussj
	set oPlusSaleSubItem = new CSetSaleItem
	oPlusSaleSubItem.FRectItemID = itemid

	if (oPlusSaleSubItem.IsSetSaleLinkSubItem) then
		oPlusSaleSubItem.GetPlusSubProductList
	end if

	if oPlusSaleSubItem.FResultCount>0 then
%>
<div class="plusSaleVItem17">
	<div class="hgroup">
		<h3>같이 구매하면 할인되는 꿀케미 상품을 추천드려요!</h3>
		<p>지금 보고 계신 상품과 아래의 상품을 함께 구매해주세요</p>
	</div>

	<div class="item typeB">
		<ul>
			<%' for dev msg : 4개까지 랜덤하게 노출 %>
			<% for plussj=0 to (oPlusSaleSubItem.FResultCount-1) %>
				<li>
					<a href="" onclick="ZoomItemInfo(<%= oPlusSaleSubItem.FItemList(plussj).FItemID %>); return false;">
						<span class="thumbnail">
							<img src="<%= oPlusSaleSubItem.FItemList(plussj).FImageBasic %>" width="130" height="130" alt="" />
							<span class="btnView"><i></i>자세히보기</span>
						</span>
						<div class="desc">
							<div class="inner">
								<p class="name"><%= Replace(oPlusSaleSubItem.FItemList(plussj).FItemName,Chr(34),"") %></p>
								<div class="price">
									<div>
										<b>
											<%
												Response.Write FormatNumber(oPlusSaleSubItem.FItemList(plussj).FSellCash,0) & chkIIF(oPlusSaleSubItem.FItemList(plussj).IsMileShopitem,"Point","원") & " ["
												If oPlusSaleSubItem.FItemList(plussj).FOrgprice = 0 Then
													Response.Write "0%]"
												Else
													Response.Write CLng((oPlusSaleSubItem.FItemList(plussj).FOrgPrice-oPlusSaleSubItem.FItemList(plussj).FSellCash)/oPlusSaleSubItem.FItemList(plussj).FOrgPrice*100) & "%]"
												End If
											%>
										</b>
									</div>
								</div>
							</div>
						</div>
					</a>
				</li>
			<% next %>
		</ul>
	</div>

	<!--ul class="list01V15">
		<li>할인 상품의 구성은 변동될 수 있습니다.</li>
		<li>현재 상품을 구매취소 하시면 상품의 할인 적용이 되지 않음을 유의해주세요.</li>
		<li>자세한 문의사항은 1:1게시판 또는 고객행복센터 (1644-6030)를 이용해주세요.</li>
	</ul-->
</div>

<%
	end if
	set oPlusSaleSubItem = nothing
%>
