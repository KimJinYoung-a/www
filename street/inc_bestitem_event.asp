<%
'###########################################################
' Description :  브랜드스트리트
' History : 2013.08.29 한용민 생성
'###########################################################
%>
<%
'//연관 브랜드 기획전
dim oStrEvt
Set oStrEvt = New cevent
	oStrEvt.FRectMakerid = makerid
	oStrEvt.FpageSize = 10
	oStrEvt.FRectKind = "1"
	oStrEvt.frectnotinevt_code = shop_event_one_code	'/브랜드기획전에 뿌리는 내용은 제끼고 배너 노출
	oStrEvt.GetBrandEventList

'//베스트 아이템
dim oStrBestItem
Set oStrBestItem = New SearchItemCls
	oStrBestItem.FListDiv="brand"
	oStrBestItem.FRectSortMethod = "be"
	oStrBestItem.FRectMakerid = makerid
	oStrBestItem.FCurrPage = 1
	
	'//연관 브랜드 기획전이 있을경우 3개만 뿌리고 없으면 4개 뿌린다.
	if oStrEvt.FResultCount > 0 then
		oStrBestItem.FpageSize = 3
	else
		oStrBestItem.FpageSize = 4
	end if

	oStrBestItem.FScrollCount = 1
	oStrBestItem.FSellScope="Y"
	oStrBestItem.getSearchList

%>
<style>
	.shopBestPrdV15 .bestItemV15 {height:430px;}
	.shopBestPrdV15 .awardList li .pdtBox {height:370px;}
	.shopBestPrdV15 .awardList li .pdtBox .pdtActionV15 li {padding-top:0;}
	.shopBestPrdV15 .pdt200V15 ul.bestAwd > li {height:436px;}
	.shopBestPrdV15 .shopEventV15 {height:462px;}
</style>
<!-- BEST ITEM, EVENT -->
<div class="shopBestPrdV15">
	<% IF oStrBestItem.FResultCount >0 then %>
		<!-- best item -->
		<div class="bestItemV15">
			<div class="pdtWrap pdt200V15">
				<ul class="pdtList awardList bestAwd">
					<% 
						For i=0 To oStrBestItem.FResultCount -1 
						
						classStr = ""
						linkUrl = "/shopping/category_prd.asp?itemid="& oStrBestItem.FItemList(i).FItemID &"&disp="&oStrBestItem.FItemList(i).FcateCode & logparam
						adultChkFlag = false
						adultChkFlag = session("isAdult") <> true and oStrBestItem.FItemList(i).FadultType = 1						

						If oStrBestItem.FItemList(i).FItemDiv="21" then
							classStr = addClassStr(classStr,"deal-item")							
						end if
						If oStrBestItem.FItemList(i).isSoldOut=true then
							classStr = addClassStr(classStr,"soldOut")							
						end if				
						if adultChkFlag then
							classStr = addClassStr(classStr,"adult-item")								
						end if																	
					%>
					<li class="<%=classStr%>" <%=chkIIF(adultChkFlag, "onclick=""confirmAdultAuth('"&linkUrl&"');""","")%> > 						
						<div class="pdtNumV15"><img src="http://fiximage.10x10.co.kr/web2015/brand/txt_best_num0<%=i+1 %>.png" alt="1" /></div>
						<div class="pdtBox">
							<% if oStrBestItem.FItemList(i).Fiskimtentenrecom="Y" or oStrBestItem.FItemList(i).IsSaleItem or oStrBestItem.FItemList(i).isCouponItem then %>
								<% if application("Svr_Info")="Dev" or application("Svr_Info")="staging" then %>
									<% If now() >= #2022-10-06 10:00:00# and now() < #2022-10-25 00:00:00# Then %>
										<span class="badge_anniv21">
											<img src="//fiximage.10x10.co.kr/web2022/anniv21/badge_anniv21.png?v=2" alt="21주년">
										</span>
									<% end if %>
								<% else %>
									<% If now() >= #2022-10-10 10:00:00# and now() < #2022-10-25 00:00:00# Then %>
										<span class="badge_anniv21">
											<img src="//fiximage.10x10.co.kr/web2022/anniv21/badge_anniv21.png?v=2" alt="21주년">
										</span>
									<% end if %>
								<% end if %>
							<% end if %>
							<% if oStrBestItem.FItemList(i).FGiftDiv>0 then %>
								<% If now() >= #2022-09-01 00:00:00# and now() < #2022-11-09 00:00:00# Then %>
									<% if application("Svr_Info")="Dev" or application("Svr_Info")="staging" then %>
										<% If now() >= #2022-10-06 10:00:00# and now() < #2022-10-25 00:00:00# Then %>
										<% else %>
											<i class="diary2023Badge"></i>
										<% end if%>
									<% else %>
										<% If now() >= #2022-10-10 10:00:00# and now() < #2022-10-25 00:00:00# Then %>
										<% else %>
											<i class="diary2023Badge"></i>
										<% end if%>
									<% end if%>
								<% end if %>
							<% end if %>
							<% '// 해외직구배송작업추가(원승현) %>
							<% If oStrBestItem.FItemList(i).IsDirectPurchase Then %>
								<i class="abroad-badge">해외직구</i>
							<% End If %>
							<div class="pdtPhoto">
								<% if adultChkFlag then %>									
								<div class="adult-hide">
									<p><span>19세 이상만</span> <span>구매 가능한 상품입니다</span></p>
								</div>
								<% end if %>							
								<a href="/shopping/category_prd.asp?itemid=<%= oStrBestItem.FItemList(i).FItemID %>&disp=<%= oStrBestItem.FItemList(i).FcateCode %><%=logparam%>">
								<span class="soldOutMask"></span>
								<img src="<%=getThumbImgFromURL(oStrBestItem.FItemList(i).FImageBasic,200,200,"true","false")%>" alt="<%=Replace(oStrBestItem.FItemList(i).FItemName,"""","")%>" /></a>
							</div>
							<div class="pdtInfo">
								<p class="pdtName tPad07">
									<a href="/shopping/category_prd.asp?itemid=<%= oStrBestItem.FItemList(i).FItemID %>&disp=<%= oStrBestItem.FItemList(i).FcateCode %><%=logparam%>">
									<% = oStrBestItem.FItemList(i).FItemName %></a>
								</p>

								<% If oStrBestItem.FItemList(i).FItemDiv="30" Then %>
									<%'' 이니렌탈 가격 표시 %>
									<p class="pdtPrice"><span class="finalP">월 <%=FormatNumber(fnRentalPriceCalculationDataInEventList(oStrBestItem.FItemList(i).getRealPrice),0)%>원~</span></p>
								<% Else %>
									<% if oStrBestItem.FItemList(i).IsSaleItem or oStrBestItem.FItemList(i).isCouponItem Then %>
										<% IF oStrBestItem.FItemList(i).IsSaleItem then %>
											<p class="pdtPrice"><span class="txtML"><%=FormatNumber(oStrBestItem.FItemList(i).getOrgPrice,0)%>원</span></p>
											<p class="pdtPrice"><span class="finalP"><%=FormatNumber(oStrBestItem.FItemList(i).getRealPrice,0)%>원</span> <strong class="cRd0V15">[<%=oStrBestItem.FItemList(i).getSalePro%>]</strong></p>
										<% End If %>
										<% IF oStrBestItem.FItemList(i).IsCouponItem Then %>
											<% if Not(oStrBestItem.FItemList(i).IsFreeBeasongCoupon() or oStrBestItem.FItemList(i).IsSaleItem) Then %>
												<p class="pdtPrice"><span class="txtML"><% =FormatNumber(oStrBestItem.FItemList(i).getOrgPrice,0)%>원</span></p>
											<% end If %>

											<p class="pdtPrice"><span class="finalP"><%=FormatNumber(oStrBestItem.FItemList(i).GetCouponAssignPrice,0)%>원</span> <strong class="cGr0V15">[<%=oStrBestItem.FItemList(i).GetCouponDiscountStr%>]</strong></p>
										<% End If %>
									<% Else %>
										<p class="pdtPrice"><span class="finalP"><%=FormatNumber(oStrBestItem.FItemList(i).getRealPrice,0) & chkIIF(oStrBestItem.FItemList(i).IsMileShopitem,"Point","원")%></span></p>
									<% End If %>
								<% End If %>

								<p class="pdtStTag tPad10">
									<% IF oStrBestItem.FItemList(i).isSoldOut Then %>
										<img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" />
									<% else %>
										<% IF oStrBestItem.FItemList(i).isTempSoldOut Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" /> <% end if %>
										<% IF oStrBestItem.FItemList(i).isSaleItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_sale.gif" alt="SALE" /> <% end if %>
										<% IF oStrBestItem.FItemList(i).isCouponItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_coupon.gif" alt="쿠폰" /> <% end if %>
										<% IF oStrBestItem.FItemList(i).isLimitItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_limited.gif" alt="한정" /> <% end if %>
										<% IF oStrBestItem.FItemList(i).IsTenOnlyitem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_only.gif" alt="ONLY" /> <% end if %>
										<% IF oStrBestItem.FItemList(i).isNewItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_new.gif" alt="NEW" /> <% end if %>
									<% end if %>
								</p>
							</div>
							<ul class="pdtActionV15">
								<li class="largeView"><a href="" onclick="ZoomItemInfo('<%=oStrBestItem.FItemList(i).FItemid %>'); return false;"><img src="http://fiximage.10x10.co.kr/web2015/common/btn_quick.png" alt="QUICK" /></a></li>
								<li class="postView"><a href="" onclick="<%=chkIIF(oStrBestItem.FItemList(i).FEvalCnt>0,"popEvaluate('" & oStrBestItem.FItemList(i).FItemid & "');","")%>return false;"><span><%=oStrBestItem.FItemList(i).FEvalCnt%></span></a></li>
								<li class="wishView"><a href="" onclick="TnAddFavorite('<%=oStrBestItem.FItemList(i).FItemid %>'); return false;"><span><%=oStrBestItem.FItemList(i).FfavCount%></span></a></li>
							</ul>
						</div>
					</li>
					<% Next %>
				</ul>
			</div>
		</div>
		<!--// best item -->
	<% end if %>
	
	<% If oStrEvt.FResultCount > 0 Then %>
		<!-- event -->
		<div class="shopEventV15">
			<div class="relatedEventV15">
				<h5><img src="http://fiximage.10x10.co.kr/web2015/brand/tit_related_event.png" alt="RELATED EVENT" /></h5>
				<div class="enjoyEvent">
					<% For i=0 to oStrEvt.FResultCount-1 %>
					<div class="evtItem">
						<a href="/event/eventmain.asp?eventid=<%= oStrEvt.FItemList(i).FECode %>">
						<p class="pic">
							<span class="frame"></span>

							<% If oStrEvt.FItemList(i).fetc_itemimg = "" Then %>
								<% If oStrEvt.FItemList(i).fbasicimage600 = "" Then %>
									<img src="<%= getThumbImgFromURL("http://webimage.10x10.co.kr/image/basic/" & GetImageSubFolderByItemid(oStrEvt.FItemList(i).fetc_itemid) & "/" & oStrEvt.FItemList(i).fbasicimage,200,200,"true","false") %>" alt="<%=oStrEvt.FItemList(i).FECode%>" width=200 height=200 />
								<% else %>
									<img src="<%= getThumbImgFromURL("http://webimage.10x10.co.kr/image/basic600/" & GetImageSubFolderByItemid(oStrEvt.FItemList(i).fetc_itemid) & "/" & oStrEvt.FItemList(i).fbasicimage600,200,200,"true","false") %>" alt="<%=oStrEvt.FItemList(i).FECode%>" width=200 height=200 />
								<% end if %>
							<% else %>
								<img src="<%=getThumbImgFromURL(oStrEvt.FItemList(i).fetc_itemimg,200,200,"true","false")%>" alt="<%=oStrEvt.FItemList(i).FECode%>" width=200 height=200 />
							<% end if %>
						</p>
						<div class="evtProd">
							<p class="pdtStTag">	
								<% if oStrEvt.FItemList(i).fissale then %>
									<img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_sale.gif" alt="SALE" />
								<% end if %>
								<% if oStrEvt.FItemList(i).fisgift then %>
									<img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_gift.gif" alt="GIFT" />
								<% end if %>
								<% if oStrEvt.FItemList(i).fiscoupon then %>
									<img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_coupon.gif" alt="쿠폰" />
								<% end if %>
								<% if oStrEvt.FItemList(i).fisOnlyTen then %>
									<img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_only.gif" alt="ONLY" />
								<% end if %>
								<% if oStrEvt.FItemList(i).fisoneplusone then %>
									<img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_oneplus.gif" alt="1+1" />
								<% end if %>
								<% if datediff("d",oStrEvt.FItemList(i).FESDate,date)<=3 then %>
									<img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_new.gif" alt="NEW" />
								<% end if %>
								<% if oStrEvt.FItemList(i).fiscomment then %>
									<img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_involve.gif" alt="참여" />
								<% end if %>
							</p>
							<p class="evtTit">
								<%=chrbyte(db2html(oStrEvt.FItemList(i).FEName),35,"Y")%>
							</p>
							<p class="evtExp">
								<%=chrbyte(db2html(oStrEvt.FItemList(i).fevt_subcopyK),35,"Y")%>
							</p>
						</div>
						</a>
					</div>
					<% Next %>
				</div>
				<div class="count"><strong>1</strong>/<span></span></div>
			</div>
		
			<!-- for dev msg : 이벤트 없을 경우 -->
			<!--<div class="noEvt" style="display:none;">
				<p><img src="http://fiximage.10x10.co.kr/web2013/brand/txt_event_no.png" alt="해당되는 이벤트가 없습니다." /></p>
				<p class="tPad10">기분 좋은 쇼핑이 될 수 있도록<br />정성을 다하겠습니다.</p>
			</div>-->
		</div>
		<!--// event -->
	<% end if %>
</div>
<!--// BEST ITEM, EVENT -->

<%
Set oStrEvt = Nothing
set oStrBestItem=nothing
%>