<%
    dim soldList
    soldList = oExhibition.getItemsNewListProc( "C", 12, mastercode, "", "", "" )
%>
            <% if isArray(soldList) then %>
			<section class="sect-sold">
				<h2>방금<br/>판매되었어요!</h2>
				<div class="prd-list">
                    <% 
                    for i = 0 to Ubound(soldList) - 1 
                        couponPer = oExhibition.GetCouponDiscountStr(soldList(i).Fitemcoupontype, soldList(i).Fitemcouponvalue)
                        couponPrice = oExhibition.GetCouponDiscountPrice(soldList(i).Fitemcoupontype, soldList(i).Fitemcouponvalue, soldList(i).Fsellcash)                    
                        itemSalePer     = CLng((soldList(i).Forgprice-soldList(i).Fsellcash)/soldList(i).FOrgPrice*100)
                        if soldList(i).Fsailyn = "Y" and soldList(i).Fitemcouponyn = "Y" then '세일
                            tempPrice = soldList(i).Fsellcash - couponPrice
                            saleStr = "<span class=""discount""><dfn>할인율</dfn>"&itemSalePer&"</span>"
                            couponStr = "<span class=""discount""><dfn>할인율</dfn>"&couponPer&"</span>"   
                        elseif soldList(i).Fitemcouponyn = "Y" then
                            tempPrice = soldList(i).Fsellcash - couponPrice
                            saleStr = ""
                            couponStr = "<span class=""discount""><dfn>할인율</dfn>"&couponPer&"</span>" 
                        elseif soldList(i).Fsailyn = "Y" then
                            tempPrice = soldList(i).Fsellcash
                            saleStr = "<span class=""discount""><dfn>할인율</dfn>"&itemSalePer&"%</span>"
                            couponStr = ""                                              
                        else
                            tempPrice = soldList(i).Fsellcash
                            saleStr = ""
                            couponStr = ""                                              
                        end if
                    %>
                    <article class="prd-item">
                        <figure class="prd-img">
                            <img src="<%=soldList(i).FImageList%>" alt="">
                        </figure>
                        <div class="prd-info">
                            <div class="prd-price">
                                <span class="set-price"><dfn>판매가</dfn><%=formatNumber(tempPrice, 0)%></span>
                                <% if saleStr<>"" then %><%=saleStr%><% end if %>
						        <% if saleStr="" and couponStr<>"" then %><%=couponStr%><% end if %>
                            </div>
                            <div class="prd-name"><%=soldList(i).Fitemname%></div> <div class="user-side">
                                <% if fnEvalTotalPointAVG(soldList(i).FtotalPoint,"search") >= 80 then %>
                                <span class="user-eval"><dfn>평점</dfn><i style="width:<%=fnEvalTotalPointAVG(soldList(i).FtotalPoint,"search")%>%"><%=fnEvalTotalPointAVG(soldList(i).FtotalPoint,"search")%>점</i></span>
                                <% if soldList(i).FevalCnt >= 5 then %><span class="user-comment"><dfn>상품평</dfn><%=soldList(i).FevalCnt%></span><% end if %>
                                <% end if %>
                            </div>
                            <div class="prd-badge<% if fnGetGiftiCon(soldList(i).Fdeliverytype,soldList(i).Forgprice,soldList(i).Fitemid) and giftCheck and (fnGetDeliveryFreeiCon(soldList(i).Fdeliverytype,soldList(i).Fsellcash,soldList(i).FdefaultFreeBeasongLimit)) then %> badge_two<% end if %>">
                                <% if fnGetDeliveryFreeiCon(soldList(i).Fdeliverytype,soldList(i).Fsellcash,soldList(i).FdefaultFreeBeasongLimit) then %><i class="badge-delivery">무료배송</i><% end if %>
                                <% if fnGetGiftiCon(soldList(i).Fdeliverytype,soldList(i).Forgprice,soldList(i).Fitemid) and giftCheck then %><i class="badge-gift">선물</i><% end if %>
                            </div>
                            <i class="badge-time"><%=soldList(i).FSellDate%></i>
                        </div>
                        <a href="/shopping/category_prd.asp?itemid=<%=soldList(i).Fitemid%>" class="prd-link" onclick="fnAmplitudeEventAction('click_diarystory_justsold','item_id','<%=soldList(i).Fitemid%>');"><span class="blind">상품 바로가기</span></a>
                    </article>
                    <% next %>
				</div>
			</section>
            <% end if %>