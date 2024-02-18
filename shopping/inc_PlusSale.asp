<% ''//세트 구매 상품 관련
dim oPlusSaleItem, j
set oPlusSaleItem = new CSetSaleItem
oPlusSaleItem.FRectItemID = itemid

if (oPlusSaleItem.IsSetSaleLinkItem) then
    oPlusSaleItem.GetLinkSetSaleItemList
end if

if oPlusSaleItem.FResultCount>0 then
%>
<div class="plusSaleBoxV15">
	<div class="plusSHeadV15">
		<h3 class="ftLt"><img src="http://fiximage.10x10.co.kr/web2017/shopping/tit_plus_item_2.png" alt="PLUS SALE" /></h3>
		<span class="ftLt lPad05 cGy2V15">(<strong><%=oPlusSaleItem.FResultCount%></strong>)</span>
		<span class="ftRt">
			함께 구매하면 좋아요! 
			<div class="infoMoreViewV15">
				<span class="more1V15">서비스안내</span>
				<div class="infoViewLyrV15">
					<div class="infoViewBoxV15">
						<dfn></dfn>
						<div class="infoViewV15">
							<div class="pad20">
								<p>함께 구매하면 좋은 상품을 추천드립니다.</p>
								<ul class="list01V15 tMar15">
									<li>본 상품과 PLUS ITEM 상품 구성은 변동될 수 있습니다.</li>
									<li>PLUS ITEM 상품에 추가 할인이 있었을 경우, 본상품을 구매 취소 하면 추가 할인이 적용 되지 않음을<br />유의해주세요.</li>
									<li>자세한 문의 사항은 1:1게시판 또는 고객행복센터(1644-6030)를 이용해 주세요.</li>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</span>
	</div>
	<div class="plusSListV15">
		<div class="">
			<ul class="pdtList">
			<% for j=0 to (oPlusSaleItem.FResultCount-1) %>
				<li<%=chkIIF(oPlusSaleItem.FItemList(j).IsSoldOut,"class=""soldOut""","")%>>
					<input type="hidden" name="pitemid" value="<%= oPlusSaleItem.FItemList(j).FItemID %>" />
					<input type="hidden" name="pitemname" value="<%= Replace(oPlusSaleItem.FItemList(j).FItemName,Chr(34),"") %>">
					<input type="hidden" name="pitemorgprice" value="<%= oPlusSaleItem.FItemList(j).getRealPrice %>">
					<input type="hidden" name="pitemplussaleprice" value="<%= oPlusSaleItem.FItemList(j).GetPLusSalePrice %>">
					<div class="pdtBox">
						<div class="pdtPhoto">
							<a href="" onclick="ZoomItemInfo(<%= oPlusSaleItem.FItemList(j).FItemID %>); return false;"><span class="soldOutMask"></span><img src="<%= oPlusSaleItem.FItemList(j).FImageList %>" alt="<%=Replace(oPlusSaleItem.FItemList(j).FItemName,"""","")%>" /></a>
						</div>
						<div class="pdtInfo">
							<p class="pdtName tPad10"><a href="" onclick="ZoomItemInfo(<%= oPlusSaleItem.FItemList(j).FItemID %>); return false;"><%=oPlusSaleItem.FItemList(j).FItemName%></a></p>
							<p class="pdtPrice"><span class="finalP"><%= FormatNumber(oPlusSaleItem.FItemList(j).GetPLusSalePrice,0) %>원</span>
								<% if oPlusSaleItem.FItemList(j).FPLusSalePro>0 then %><strong class="cGr0V15">[<%= oPlusSaleItem.FItemList(j).FPLusSalePro %>%]</strong><% end if %>
							</p>
							<p class="tPad07">
								<% if oPlusSaleItem.FItemList(j).IsItemOptionExists then %>
									<!-- 상품옵션 -->
									<%=getOneTypeOptionBoxDpLimitHtml(oPlusSaleItem.FItemList(j).FItemID, oPlusSaleItem.FItemList(j).IsSoldOut,"class='optSelect2 select'",oPlusSaleItem.FItemList(j).FLimitDispYn="Y")%>
							    <% else %>
							        <input type="hidden" name="item_option" value="0000">
							    <% end if %>
							</p>
							<% if (oPlusSaleItem.FItemList(j).FItemDiv = "06") then %>
							<p class="tPad07" style="display:none;"><textarea style="width:213px; height:30px;" name="requiredetailplus" placeholder="제작 문구" title="제작 문구를 입력해주세요"></textarea></p>
							<p class="tPad07">담으신 후 원하는 문구를 입력하실 수 있습니다.</p>
							<% end if %>
						</div>
						<a href="" name="btnPlus" class="btn btnS2 btnGry2"><span class="fn">담기</span></a>
					</div>
				</li>
			<% next %>
			</ul>
		</div>
	</div>
</div>
<%
end if
set oPlusSaleItem = nothing
%>