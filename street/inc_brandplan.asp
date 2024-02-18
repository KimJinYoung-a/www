<%
'###########################################################
' Description :  브랜드스트리트
' History : 2013.08.29 한용민 생성
'###########################################################
%>
<%
dim iv, oEvent, oEventitem, eventpage
dim eCode, iconcountp
	eCode = getNumeric(requestcheckvar(request("evt_code"),10))
	eventpage = getNumeric(requestcheckvar(request("eventpage"),10))

if eventpage="" then eventpage=1

'//현재 브랜드가 이벤트매뉴 노출 권한이 있고 기획전이 존재 할때만 뿌림
if shop_event_yn="Y" then
	
	set oEvent = new cEvent
		oEvent.frectevt_code = eCode
		oEvent.frectmakerid = makerid
		oEvent.frectevt_kind = "16"
		
		if makerid<>"" then
			oEvent.fnGetEvent
		end if
	
%>

	<% if oEvent.ftotalcount>0 then %>
		<%
		'//이벤트 종료시
		IF (datediff("d",oEvent.FOneItem.FEEDate,date()) >0) OR (oEvent.FOneItem.FEState =9) THEN
		%>
		<% end if %>
		
		<h4>브랜드 기획전</h4>
		<div class="bnr">
			<img src="<%= oEvent.FOneItem.FEMimg %>" alt="<%= oEvent.FOneItem.FECode %>" />
			<a href="" onclick="shopchg('1'); return false;" class="btn btnS2 btnGrylight"><em class="gryArr01">브랜드 전상품 보기</em></a>
		</div>
		
		<!-- list -->
		<% '<!-- for dev msg : 이미지 사이즈별 클래스 적용(pdt240V15/pdt200V15/pdt150V15)--> %>
		<%
		set oEventitem = new cEvent
			oEventitem.frectevt_code = shop_event_one_code
			oEventitem.FPageSize = PageSize
			oEventitem.FCurrPage = CurrPage
			
			if shop_event_one_code<>"" then
				oEventitem.fnGetEventitem
			end if
		%>
		<% IF oEventitem.FResultCount >0 then %>
			<div class="ctgyWrapV15">
				<div class="pdtWrap pdt200V15">
					<ul class="pdtList">
						<% For i=0 To oEventitem.FResultCount -1 %>
						<li <%=chkIIF(oEventitem.FItemList(i).isSoldOut," class=""soldOut""","")%>>
							<div class="pdtBox">
								<div class="pdtPhoto">
									<a href="/shopping/category_prd.asp?itemid=<%= oEventitem.FItemList(i).FItemID %>&disp=<%= oEventitem.FItemList(i).FcateCode %><%=logparam%>">
										<span class="soldOutMask"></span>
										<img src="<%=getThumbImgFromURL(oEventitem.FItemList(i).FImageBasic,200,200,"true","false")%>" alt="<%=Replace(oEventitem.FItemList(i).FItemName,"""","")%>" />
										<% if oEventitem.FItemList(i).FAddimage<>"" then %><dfn><img src="<%=getThumbImgFromURL(oEventitem.FItemList(i).FAddimage,200,200,"true","false")%>" alt="<%=Replace(oEventitem.FItemList(i).FItemName,"""","")%>" /></dfn><% end if %>
									</a>
								</div>
								<div class="pdtInfo">
									<p class="pdtBrand tPad20"><a href="/street/street_brand.asp?makerid=<%= oEventitem.FItemList(i).FMakerid %>"><% = oEventitem.FItemList(i).FBrandName %></a></p>
									<p class="pdtName tPad07">
										<a href="/shopping/category_prd.asp?itemid=<%= oEventitem.FItemList(i).FItemID %>&disp=<%= oEventitem.FItemList(i).FcateCode %><%=logparam%>">
										<% = oEventitem.FItemList(i).FItemName %></a>
									</p>
									<% if oEventitem.FItemList(i).IsSaleItem or oEventitem.FItemList(i).isCouponItem Then %>
										<% IF oEventitem.FItemList(i).IsSaleItem then %>
											<p class="pdtPrice"><span class="txtML"><%=FormatNumber(oEventitem.FItemList(i).getOrgPrice,0)%>원</span></p>
											<p class="pdtPrice"><span class="finalP"><%=FormatNumber(oEventitem.FItemList(i).getRealPrice,0)%>원</span> <strong class="cRd0V15">[<%=oEventitem.FItemList(i).getSalePro%>]</strong></p>
										<% end if %>
										<% IF oEventitem.FItemList(i).IsCouponItem Then %>
											<% if Not(oEventitem.FItemList(i).IsFreeBeasongCoupon() or oEventitem.FItemList(i).IsSaleItem) Then %>
												<p class="pdtPrice"><span class="txtML"><%=FormatNumber(oEventitem.FItemList(i).getOrgPrice,0)%>원</span></p>
											<% end If %>

											<p class="pdtPrice"><span class="finalP"><%=FormatNumber(oEventitem.FItemList(i).GetCouponAssignPrice,0)%>원</span> <strong class="cGr0V15">[<%=oEventitem.FItemList(i).GetCouponDiscountStr%>]</strong></p>
										<% End If %>
									<% Else %>
										<p class="pdtPrice"><span class="finalP"><%=FormatNumber(oEventitem.FItemList(i).getRealPrice,0) & chkIIF(oEventitem.FItemList(i).IsMileShopitem,"Point","원")%></span></p>
									<% End If %>
									<p class="pdtStTag tPad10">
										<% IF oEventitem.FItemList(i).isSoldOut Then %>
											<img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" />
										<% else %>
											<% iconcountp=0 %>
											<% IF oEventitem.FItemList(i).isTempSoldOut and iconcountp < 4 Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" /> <% iconcountp=iconcountp+1 %><% end if %>
											<% IF oEventitem.FItemList(i).isSaleItem and iconcountp < 4 Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_sale.gif" alt="SALE" /> <% iconcountp=iconcountp+1 %><% end if %>
											<% IF oEventitem.FItemList(i).isCouponItem and iconcountp < 4 Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_coupon.gif" alt="쿠폰" /> <% iconcountp=iconcountp+1 %><% end if %>
											<% IF oEventitem.FItemList(i).isLimitItem and iconcountp < 4 Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_limited.gif" alt="한정" /> <% iconcountp=iconcountp+1 %><% end if %>
											<% IF oEventitem.FItemList(i).IsTenOnlyitem and iconcountp < 4 Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_only.gif" alt="ONLY" /> <% iconcountp=iconcountp+1 %><% end if %>
											<% IF oEventitem.FItemList(i).isNewItem and iconcountp < 4 Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_new.gif" alt="NEW" /> <% iconcountp=iconcountp+1 %><% end if %>
										<% end if %>
									</p>
								</div>
								<ul class="pdtActionV15">
									<li class="largeView"><a href="" onclick="ZoomItemInfo('<%=oEventitem.FItemList(i).FItemid %>'); return false;"><img src="http://fiximage.10x10.co.kr/web2015/common/btn_quick.png" alt="QUICK" /></a></li>
									<li class="postView"><a href="" onclick="<%=chkIIF(oEventitem.FItemList(i).FEvalCnt>0,"popEvaluate('" & oEventitem.FItemList(i).FItemid & "');","")%>return false;"><span><%=oEventitem.FItemList(i).FEvalCnt%></span></a></li>
									<li class="wishView"><a href="" onclick="TnAddFavorite('<%=oEventitem.FItemList(i).FItemid %>'); return false;"><span><%=oEventitem.FItemList(i).FfavCount%></span></a></li>
								</ul>
							</div>
						</li>
						<% Next %>
					</ul>
				</div>
				
				<!-- paging -->
				<div class="pageWrapV15 tMar20">
					<%= fnDisplayPaging_New(CurrPage,oEventitem.FTotalCount,PageSize,10,"jsGoPagebrand") %>
				</div>
			</div>
		<% else %>
			<div class="ct" style="padding:150px 0;">
				<p style="font-family:'malgun gothic', '맑은고딕', dotum, '돋움', sans-serif; font-size:21px; color:#000;"><strong>흠... <span class="cRd0V15">상품</span>이 없습니다.</strong></p>
			</div>
		<% end if %>
	<% end if %>
<%
	set oEventitem = nothing
	set oEvent = nothing

end if
%>