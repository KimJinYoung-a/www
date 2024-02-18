<%
    dim bestList : bestList = oExhibition.getItemsNewListProc( "B", 15, mastercode, "", "1", "1" )
%>
<% if isArray(bestList) then %>
<section class="sect-md">
    <h2>MD가 추천해요</h2>
    <div class="slider-prd">
    <%
        dim arrItemIds , returnItemsList
        for i = 0 to Ubound(bestList) - 1
            if bestList(i).Fitemid = "" then exit for
            if i = 0 then 
                arrItemIds = bestList(i).Fitemid
            else
                arrItemIds = arrItemIds &","& bestList(i).Fitemid
            end if 
        next 

        'returnItemsList = getExistsGiftItems(arrItemIds)

        dim couponPer, couponPrice, itemSalePer, totalPrice, totalSaleCouponString
        for i = 0 to Ubound(bestList) - 1
            couponPer = oExhibition.GetCouponDiscountStr(bestList(i).Fitemcoupontype, bestList(i).Fitemcouponvalue)
            couponPrice = oExhibition.GetCouponDiscountPrice(bestList(i).Fitemcoupontype, bestList(i).Fitemcouponvalue, bestList(i).Fsellcash)
            itemSalePer     = CLng((bestList(i).Forgprice-bestList(i).Fsellcash)/bestList(i).FOrgPrice*100)
            if bestList(i).Fsailyn = "Y" and bestList(i).Fitemcouponyn = "Y" then '세일
                totalPrice = bestList(i).Fsellcash - couponPrice
                totalSaleCouponString = "더블할인"
            elseif bestList(i).Fitemcouponyn = "Y" then
                totalPrice = bestList(i).Fsellcash - couponPrice
                totalSaleCouponString = ""&couponPer&""
            elseif bestList(i).Fsailyn = "Y" then
                totalPrice = bestList(i).Fsellcash
                totalSaleCouponString = chkiif(itemSalePer > 0,""&itemSalePer&"%","")
            else
                totalPrice = bestList(i).Fsellcash
                totalSaleCouponString = ""
            end if
    %>
        <article class="prd-item">
            <figure class="prd-img">
                <img src="<%=bestList(i).FImageList%>" alt="">
            </figure>
            <div class="prd-info">
                <div class="prd-price">
                    <span class="set-price"><dfn>판매가</dfn><%=formatNumber(totalPrice, 0)%></span>
                    <span class="discount"><dfn>할인율</dfn><%=totalSaleCouponString%></span>
                </div>
                <div class="prd-name"><%=bestList(i).Fitemname%></div>
                <div class="user-side">
                    <% if fnEvalTotalPointAVG(bestList(i).FtotalPoint,"search") >= 80 then %>
                    <span class="user-eval"><dfn>평점</dfn><i style="width:<%=fnEvalTotalPointAVG(bestList(i).FtotalPoint,"search")%>%"><%=fnEvalTotalPointAVG(bestList(i).FtotalPoint,"search")%>점</i></span>
                    <% if bestList(i).FevalCnt >= 5 then  %><span class="user-comment"><dfn>상품평</dfn><%=formatNumber(bestList(i).FevalCnt,0)%></span><% end if %>
                    <% end if %>
                </div>
                <div class="prd-badge<% if fnGetGiftiCon(bestList(i).Fdeliverytype,bestList(i).Forgprice,bestList(i).Fitemid) and giftCheck and (fnGetDeliveryFreeiCon(bestList(i).Fdeliverytype,bestList(i).Fsellcash,bestList(i).FdefaultFreeBeasongLimit)) then %> badge_two<% end if %>">
                    <% if fnGetDeliveryFreeiCon(bestList(i).Fdeliverytype,bestList(i).Fsellcash,bestList(i).FdefaultFreeBeasongLimit) then %><i class="badge-delivery">무료배송</i><% end if %>
                    <% if fnGetGiftiCon(bestList(i).Fdeliverytype,bestList(i).Forgprice,bestList(i).Fitemid) and giftCheck then %><i class="badge-gift">선물</i><% end if %>
                </div>
            </div>
            <a href="/shopping/category_Prd.asp?itemid=<%=bestList(i).Fitemid%>" class="prd-link" onclick="fnAmplitudeEventAction('click_diarystory_mdpick','item_id','<%=bestList(i).Fitemid%>');"><span class="blind">상품 바로가기</span></a>
        </article>
    <% next %>
    </div>
</section>
<% end if %>