<%
'###########################################################
' Description :  브랜드스트리트
' History : 2013.08.29 한용민 생성
'###########################################################
%>
<% 
dim ocollection_m, ic, jc, ocollection_d, colcount, rowcount, iconcountc

if shop_collection_yn="Y" then

	set ocollection_m = new ccollection
		ocollection_m.frectmakerid = makerid
		ocollection_m.frectisusing = "Y"
		ocollection_m.Frectstate="7"
		ocollection_m.FPageSize = 50
		ocollection_m.FCurrPage = 1
		
		if makerid<>"" then
			ocollection_m.getcollection_master
		end if
%>
	<% if ocollection_m.fresultcount>0 then %>
		<% for ic = 0 to ocollection_m.fresultcount-1 %>
		<%
		set ocollection_d = new ccollection
			ocollection_d.frectisusing = "Y"
			ocollection_d.frectidx=ocollection_m.FItemList(ic).Fidx
			ocollection_d.FPageSize = 40
			ocollection_d.FCurrPage = 1
			
			if ocollection_m.FItemList(ic).Fidx<>"" then
				ocollection_d.getshop_collection_detail
			end if
		%>
		<div class="clct">
			<div class="overHidden">
				<h5 class="ftLt"><img src="<%= ocollection_m.FItemList(ic).Fmainimg %>" alt="<%= ocollection_m.FItemList(ic).Ftitle %>" /></h5>
		
				<!-- list -->
				<div class="pdtWrap pdt150V15">
					<ul class="pdtList">
						<% if ocollection_d.fresultcount>0 then %>
							<%
							rowcount=1
							colcount=0
							
							for jc = 0 to ocollection_d.fresultcount -1
							
							colcount = colcount + 1
							
							if colcount>4 then
								rowcount = rowcount + 1
								colcount=1
							end if
							%>
							<li class="<%=chkIIF(ocollection_d.FItemList(jc).isSoldOut,"soldOut","")%><% if rowcount>2 then %><%= "trcollectionMore"&ocollection_m.FItemList(ic).Fidx %><% end if %>" <% if rowcount>2 then %>style="display:none;"<% end if %>>
								<div class="pdtBox">
									<div class="pdtPhoto">
										<a href="/shopping/category_prd.asp?itemid=<%= ocollection_d.FItemList(jc).FItemID %>&disp=<%= ocollection_d.FItemList(jc).FcateCode %><%=logparam%>">
											<span class="soldOutMask"></span>
											<img src="<%=getThumbImgFromURL(ocollection_d.FItemList(jc).FImageBasic,150,150,"true","false")%>" alt="<%=Replace(ocollection_d.FItemList(jc).FItemName,"""","")%>" />
										</a>
									</div>
									<div class="pdtInfo">
										<p class="pdtBrand tPad20"><a href="/street/street_brand.asp?makerid=<%= ocollection_d.FItemList(jc).FMakerid %>"><% = ocollection_d.FItemList(jc).FBrandName %></a></p>
										<p class="pdtName tPad07">
											<a href="/shopping/category_prd.asp?itemid=<%= ocollection_d.FItemList(jc).FItemID %>&disp=<%= ocollection_d.FItemList(jc).FcateCode %><%=logparam%>">
											<% = ocollection_d.FItemList(jc).FItemName %></a>
										</p>
										<% if ocollection_d.FItemList(jc).IsSaleItem or ocollection_d.FItemList(jc).isCouponItem Then %>
											<% IF ocollection_d.FItemList(jc).IsSaleItem then %>
												<p class="pdtPrice"><span class="txtML"><%=FormatNumber(ocollection_d.FItemList(jc).getOrgPrice,0)%>원</span></p>
												<p class="pdtPrice"><span class="finalP"><%=FormatNumber(ocollection_d.FItemList(jc).getRealPrice,0)%>원</span> <strong class="cRd0V15">[<%=ocollection_d.FItemList(jc).getSalePro%>]</strong></p>
											<% end if %>
											<% IF ocollection_d.FItemList(jc).IsCouponItem Then %>
												<% if Not(ocollection_d.FItemList(jc).IsFreeBeasongCoupon() or ocollection_d.FItemList(jc).IsSaleItem) Then %>
													<p class="pdtPrice"><span class="txtML"><%=FormatNumber(ocollection_d.FItemList(jc).getOrgPrice,0)%>원</span></p>
												<% end If %>

												<p class="pdtPrice"><span class="finalP"><%=FormatNumber(ocollection_d.FItemList(jc).GetCouponAssignPrice,0)%>원</span> <strong class="cGr0V15">[<%=ocollection_d.FItemList(jc).GetCouponDiscountStr%>]</strong></p>
											<% End If %>
										<% Else %>
											<p class="pdtPrice"><span class="finalP"><%=FormatNumber(ocollection_d.FItemList(jc).getRealPrice,0) & chkIIF(ocollection_d.FItemList(jc).IsMileShopitem,"Point","원")%></span></p>
										<% End If %>
										<p class="pdtStTag tPad10">
											<% IF ocollection_d.FItemList(jc).isSoldOut Then %>
												<img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" />
											<% else %>
												<% iconcountc=0 %>
												<% IF ocollection_d.FItemList(jc).isTempSoldOut and iconcountc < 4 Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" /> <% iconcountc=iconcountc+1 %><% end if %>
												<% IF ocollection_d.FItemList(jc).isSaleItem and iconcountc < 4 Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_sale.gif" alt="SALE" /> <% iconcountc=iconcountc+1 %><% end if %>
												<% IF ocollection_d.FItemList(jc).isCouponItem and iconcountc < 4 Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_coupon.gif" alt="쿠폰" /> <% iconcountc=iconcountc+1 %><% end if %>
												<% IF ocollection_d.FItemList(jc).isLimitItem and iconcountc < 4 Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_limited.gif" alt="한정" /> <% iconcountc=iconcountc+1 %><% end if %>
												<% IF ocollection_d.FItemList(jc).IsTenOnlyitem and iconcountc < 4 Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_only.gif" alt="ONLY" /> <% iconcountc=iconcountc+1 %><% end if %>
												<% IF ocollection_d.FItemList(jc).isNewItem and iconcountc < 4 Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_new.gif" alt="NEW" /> <% iconcountc=iconcountc+1 %><% end if %>
											<% end if %>
										</p>
									</div>
									<ul class="pdtActionV15">
										<li class="largeView"><a href="" onclick="ZoomItemInfo('<%=ocollection_d.FItemList(jc).FItemid %>'); return false;"><img src="http://fiximage.10x10.co.kr/web2015/common/btn_quick.png" alt="QUICK" /></a></li>
										<li class="postView"><a href="" onclick="<%=chkIIF(ocollection_d.FItemList(jc).FEvalCnt>0,"popEvaluate('" & ocollection_d.FItemList(jc).FItemid & "');","")%>return false;"><span><%=ocollection_d.FItemList(jc).FEvalCnt%></span></a></li>
										<li class="wishView"><a href="" onclick="TnAddFavorite('<%=ocollection_d.FItemList(jc).FItemid %>'); return false;"><span><%=ocollection_d.FItemList(jc).FfavCount%></span></a></li>
									</ul>
								</div>
							</li>
							<% next %>
						<% end if %>
					</ul>
				</div>

				<% if ocollection_d.fresultcount>8 then %>
					<p class="clctMoreBtn" view="" idx="<%=ocollection_m.FItemList(ic).Fidx%>">더보기</p>
				<% end if %>
			</div>
		</div>
		<% next %>
		
	<% end if %>
<%
set ocollection_m = nothing

end if
%>