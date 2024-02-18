<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/event/sale2020/sale2020Cls.asp" -->
<%
'####################################################
' Description : 정기세일 방금판매된
' History : 2020-03-25 이종화
'####################################################
dim oJustSold , i
dim itemsJustSold
dim vDisp : vDisp = requestCheckVar(request("vdisp"),3)
dim page : page = requestCheckVar(request("cpg"),10)
dim pageSize : pageSize = 20
dim totalPrice , salePercentString , couponPercentString , totalSalePercent

IF page = "" THEN page = 1

set oJustSold = new sale2020Cls
    itemsJustSold = oJustSold.getItemsJustSoldLists(vDisp , page , pageSize)
set oJustSold = nothing 

IF isArray(itemsJustSold) THEN
    FOR i = 0 TO Ubound(itemsJustSold) - 1 
    CALL itemsJustSold(i).fnItemPriceInfos(totalPrice , salePercentString , couponPercentString , totalSalePercent)
%> 
<li> 
    <a href="/shopping/category_prd.asp?itemid=<%=itemsJustSold(i).FItemID%>">
        <div class="thumbnail">
            <img src="<%=itemsJustSold(i).FPrdImage%>" alt="" />
            <div class="badge badge-time"><%=Gettimeset(DateDiff("s",itemsJustSold(i).FSellDate, now()))%></div>
            <% IF itemsJustSold(i).IsFreeBeasong THEN %>
            <div class="badge-group">
                <div class="badge-item badge-delivery">무료배송</div>
            </div>
            <% END IF %>
            <% IF itemsJustSold(i).FsellYn = "N" THEN %>
            <span class="soldout"><span class="ico-soldout">일시품절</span></span>
            <% END IF %>
        </div>
        <div class="desc">
            <div class="price-area"><span class="price"><%=totalPrice%></span>
                <% IF salePercentString > "0"  THEN %><b class="discount sale"><%=salePercentString%></b><% END IF %>
                <% IF couponPercentString > "0" THEN %><b class="discount coupon"><%=couponPercentString%></b><% END IF %>
            </div>
            <p class="name"><%=itemsJustSold(i).Fitemname%></p>
        </div>
    </a>
</li>
<% 
    NEXT 
END IF
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->