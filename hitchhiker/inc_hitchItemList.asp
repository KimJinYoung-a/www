<%
'#############################################################
'	Description : HITCHHIKER
'	History		: 2014.08.06 유태욱 생성
'#############################################################
%>
<%
dim makerid, soldoutyn, sortno
	page=requestcheckvar(request("page"),10)
	soldoutyn=requestcheckvar(request("soldoutyn"),1)
	sortno=requestcheckvar(request("sortno"),4)

if soldoutyn="" then soldoutyn="N"
if page="" then page=1
makerid="hitchhiker"

dim ohitlist
set ohitlist = new CHitchhikerlist
	ohitlist.frectmakerid=makerid
	ohitlist.frectsoldoutyn=soldoutyn
	ohitlist.frectsortno=sortno
	ohitlist.FPageSize = 15
	ohitlist.FCurrPage = page
	ohitlist.fnGetHitList
%>

<div class="col">
	<div class="goods" id="hitlist">
		<h3><img src="http://fiximage.10x10.co.kr/web2013/hitchhiker/tit_hitchhiker.gif" alt="HITCHHIKER" /></h3>
		<p><img src="http://fiximage.10x10.co.kr/web2013/hitchhiker/txt_hitchhiker.gif" alt="당신의 감성을 채워 줄 히치하이커 상품을 만나보세요" /></p>
		<div class="option">
			<select onchange="hichlist('1','<%= soldoutyn %>',this.value);" class="ftLt optSelect" title="배송구분 옵션을 선택하세요" style="height:18px;">
				<option value="new" <% if sortno="new" then response.write " selected" %>>신상품순</option>
				<option value="best" <% if sortno="best" then response.write " selected" %>>인기상품순</option>
				<option value="min" <% if sortno="min" then response.write " selected" %>>낮은가격순</option>
				<option value="max" <% if sortno="max" then response.write " selected" %>>높은가격순</option>
				<!--<option>높은할인율순</option>-->
			</select>
			<% if soldoutyn="N" then %>
				<a href="" onclick="hichlist('1','Y','<%= sortno %>'); return false;" class="lMar20 ftLt btn btnS3 btnGry fn">- 품절상품 제외</a>
			<% else %>
				<a href="" onclick="hichlist('1','N','<%= sortno %>'); return false;" class="lMar20 ftLt btn btnS3 btnGry fn">+ 품절상품 포함</a>
			<% end if %>
			<%'  for dev msg : 이미지 사이즈별 보기는 리뷰, 포토리뷰 리스트에서는 노출 안됩니다. %>
			<!--<ul class="pdtView">
				<li class="view01 current"><a href="">큰 이미지로 보기</a></li>
				<li class="view02"><a href="">중간 이미지로 보기</a></li>
				<li class="view03"><a href="">작은 이미지로 보기</a></li>
			</ul>-->
		</div>
	</div>

	<% IF ohitlist.FResultCount > 0 THEN %>
		<div class="pdtWrap pdt200V15">
			<ul class="pdtList">
				<% ' for dev msg : 히치하이커 상품 16개 (5개*3줄) 이상일 경우에 페이징 표시해주세요. 15개미만에선 페이징 없음 %>
				<% FOR i = 0 to ohitlist.FResultCount-1 %>
				<li <%=chkiif(ohitlist.FItemList(i).IsSoldOut,"class=""soldout""","")%>>
					<div class="pdtBox">
						<div class="pdtPhoto">
							<a href="/shopping/category_prd.asp?itemid=<%=ohitlist.FItemList(i).FItemID %>">
								<span class="soldOutMask"></span>
								<img src="<%=getThumbImgFromURL(ohitlist.FItemList(i).FImageBasic,"200","200","true","false")%>" alt="<%=ohitlist.FItemList(i).FItemName%>" />
							</a>
						</div>
						<div class="pdtInfo">
							<p class="pdtBrand tPad20"><a href="/street/street_brand.asp?makerid=<%=ohitlist.FItemList(i).FMakerId %>" target="_top"><%=ohitlist.FItemList(i).FBrandName %></a></p>
							<p class="pdtName tPad07"><a href="/shopping/category_prd.asp?itemid=<%=ohitlist.FItemList(i).FItemID %>" target="_top"><%=ohitlist.FItemList(i).FItemName%></a></p>
							<% IF ohitlist.FItemList(i).IsSaleItem or ohitlist.FItemList(i).isCouponItem Then %>
								<% IF ohitlist.FItemList(i).IsSaleItem then %>
									<p class="pdtPrice"><span class="finalP"><% = FormatNumber(ohitlist.FItemList(i).getRealPrice,0) %>원</span> <strong class="cRd0V15">[<%=ohitlist.FItemList(i).getSalePro%>]</strong></p>
								<% End IF %>
								<% IF ohitlist.FItemList(i).IsCouponItem Then %>
									<p class="pdtPrice"><span class="finalP"><% = FormatNumber(ohitlist.FItemList(i).GetCouponAssignPrice,0) %>원</span> <strong class="cGr0V15">[<%=ohitlist.FItemList(i).GetCouponDiscountStr%>]</strong></p>
								<% End IF %>
							<% Else %>
								<p class="pdtPrice"><span class="finalP"><% = FormatNumber(ohitlist.FItemList(i).getRealPrice,0) %><% if ohitlist.FItemList(i).IsMileShopitem then %> Point<% else %> 원<% end  if %></span></p>
							<% End IF %>
							<%	
								if ohitlist.FItemList(i).IsSoldOut then
									sBadges = "<img src='http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif' alt='SOLDOUT' />"
								else
									sBadges = ""
									IF ohitlist.FItemList(i).isSaleItem Then sBadges = sBadges & "<img src='http://fiximage.10x10.co.kr/web2012/category/product_tag_sale.png' />"
									IF ohitlist.FItemList(i).isCouponItem Then sBadges = sBadges & "<img src='http://fiximage.10x10.co.kr/web2012/category/product_tag_coupon.png' />"
									IF ohitlist.FItemList(i).isLimitItem Then sBadges = sBadges & "<img src='http://fiximage.10x10.co.kr/web2012/category/product_tag_limited.png' />"
									IF ohitlist.FItemList(i).isNewItem Then sBadges = sBadges & "<img src='http://fiximage.10x10.co.kr/web2013/shopping/tag_new.gif' alt='NEW' />"
									IF ohitlist.FItemList(i).IsTenOnlyitem Then sBadges = sBadges & "<img src='http://fiximage.10x10.co.kr/web2012/category/product_tag_only.png' />"
								end if
								
								If sBadges <> "" Then
									Response.Write "<p class='pdtStTag tPad10'>" & sBadges & "</p>"
								End If
							%>
						</div>
						<ul class="pdtActionV15">
							<li class="largeView"><a href="" onclick="ZoomItemInfo('<%=ohitlist.FItemList(i).FItemid %>');return false;"><img src="http://fiximage.10x10.co.kr/web2015/common/btn_quick.png" alt="QUICK" /></a></li>
							<li class="postView"><a href="" <%=chkIIF(ohitlist.FItemList(i).Fevalcnt>0,"onclick=""popEvaluate('" & ohitlist.FItemList(i).FItemid & "');""","onclick=""return false;""")%>><span><%=ohitlist.FItemList(i).Fevalcnt%></span></a></li>
							<li class="wishView"><a href="" onclick="TnAddFavorite('<%=ohitlist.FItemList(i).FItemid %>');return false;"><span><%=ohitlist.FItemList(i).FfavCount%></span></a></li>
						</ul>
					</div>
				</li>
				<% NEXT %>
			</ul>
		</div>
	
		<% if ohitlist.FtotalPage > 1 then %>
		<div class="pageWrapV15 tMar20">
			<div class="paging">
				<a href="" onclick="hichlist('1','<%= soldoutyn %>','<%= sortno %>'); return false;" class="first arrow"><span>맨 처음 페이지로 이동</span></a>
				<% if ohitlist.FCurrPage > 1 then %>
					<a href="" onclick="hichlist('<%= ohitlist.FCurrPage-1 %>','<%= soldoutyn %>','<%= sortno %>'); return false;" class="prev arrow"><span>이전페이지로 이동</span></a>
				<% else %>
					<a href="" onclick="alert('이전페이지가 없습니다.'); return false;" class="prev arrow"><span>이전페이지로 이동</span></a>
				<% end if %>
		
				<% for i = 0 + ohitlist.StartScrollPage to ohitlist.StartScrollPage + ohitlist.FScrollCount - 1 %>
					<% if (i > ohitlist.FTotalpage) then Exit for %>
					<% if CStr(i) = CStr(ohitlist.FCurrPage) then %>			
						<a href="" class="current"><span><%= i %></span></a>
					<% else %>
						<a href="" onclick="hichlist('<%= i %>','<%= soldoutyn %>','<%= sortno %>'); return false;" ><span><%= i %></span></a>
					<% end if %>
				<% next %>
				
				<% if cint(ohitlist.FCurrPage) < cint(ohitlist.FtotalPage) then %>
					<a href="" onclick="hichlist('<%= ohitlist.FCurrPage+1 %>','<%= soldoutyn %>','<%= sortno %>'); return false;" class="next arrow"><span>다음 페이지로 이동</span></a>
				<% else %>
					<a href="" onclick="alert('다음 페이지가 없습니다.'); return false;" class="next arrow"><span>다음 페이지로 이동</span></a>
				<% end if %>
				<a href="" onclick="hichlist('<%= ohitlist.FTotalPage %>','<%= soldoutyn %>','<%= sortno %>'); return false;" class="end arrow"><span>맨 마지막 페이지로 이동</span></a>
			</div>
		</div>
		<% end if %>
	<% end if %>
</div>

<%
set ohitlist=nothing
%>