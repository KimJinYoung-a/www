<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/event/exhibitionCls.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<%
    dim oExhibition
    dim page , mastercode , detailcode , listType , sortMet
    dim iCTotCnt , i

    listType = "B"
    mastercode = 8
    detailcode = requestCheckVar(request("detailcode"),10)
    page = requestCheckVar(request("cpg"),10)
    sortMet = requestCheckVar(request("sortMet"),10)

    if page = "" then page = 1
    if sortMet = "" then sortMet = "5"

    SET oExhibition = new ExhibitionCls

        oExhibition.FPageSize = 12
        oExhibition.FCurrPage = page
        oExhibition.FrectMasterCode = mastercode
        oExhibition.FrectDetailCode = detailcode
        oExhibition.FrectListType = listType
        oExhibition.FrectSortMet = sortMet
        oExhibition.getItemsPageListProc

        iCTotCnt = oExhibition.FTotalCount
%>
<script>
$(function() {
    // category
    $('.cateList li').click(function(){
        var checkval = $(this).find("input[name='type']").val();
        $(this).addClass('on').siblings().removeClass('on')
        document.listfrm.detailcode.value = checkval;
        document.listfrm.cpg.value = 1;
        fnScrollMove();
        getList();
    })

    // sorting
    $('.cate-area .sort a').click(function(e){
        var checkval = $(this).attr("rel");
        $(this).parent().addClass('on').siblings().removeClass('on')
        document.listfrm.sortMet.value = checkval;
        document.listfrm.cpg.value = 1;
        e.preventDefault();
        fnScrollMove();
        getList();
    })
})

function jsGoComPage(iP) {
    document.listfrm.cpg.value = iP;
    fnScrollMove();
    getList();
}


// 스크롤 이동
function fnScrollMove() {
    $('html,body').animate({scrollTop: $("#catearea").offset().top},'slow');
}
</script>
<% if oExhibition.FTotalCount > 0 then %>
    <div class="cateList">
        <ul>
            <li class="all <%=chkiif(detailcode="","on","") %>"><input type="radio" name="type" id="all" value="" <%=chkiif(detailcode="","checked","") %>/><label for="all"><span></span>전체보기</label></li>
            <li class="sticker <%=chkiif(detailcode="10","on","") %>"><input type="radio" name="type" id="sticker" value="10" <%=chkiif(detailcode="10","checked","") %>/><label for="sticker"><span></span>스티커</label></li>
            <li class="tape <%=chkiif(detailcode="20","on","") %>"><input type="radio" name="type" id="tape" value="20" <%=chkiif(detailcode="20","checked","") %>/><label for="tape"><span></span>마스킹테이프</label></li>
            <li class="keyring <%=chkiif(detailcode="30","on","") %>"><input type="radio" name="type" id="keyring" value="30" <%=chkiif(detailcode="30","checked","") %>/><label for="keyring"><span></span>키링</label></li>
            <li class="pen <%=chkiif(detailcode="40","on","") %>"><input type="radio" name="type" id="pen" value="40" <%=chkiif(detailcode="40","checked","") %>/><label for="pen"><span></span>펜</label></li>
            <li class="case <%=chkiif(detailcode="50","on","") %>"><input type="radio" name="type" id="case" value="50" <%=chkiif(detailcode="50","checked","") %>/><label for="case"><span></span>필통</label></li>
            <li class="memo <%=chkiif(detailcode="60","on","") %>"><input type="radio" name="type" id="memo" value="60" <%=chkiif(detailcode="60","checked","") %>/><label for="memo"><span></span>메모지/노트</label></li>
            <li class="binder <%=chkiif(detailcode="70","on","") %>"><input type="radio" name="type" id="binder" value="70" <%=chkiif(detailcode="70","checked","") %>/><label for="binder"><span></span>바인더/다이어리</label></li>
            <li class="desc <%=chkiif(detailcode="80","on","") %>"><input type="radio" name="type" id="desc" value="80" <%=chkiif(detailcode="80","checked","") %>/><label for="desc"><span></span>데스크아이템</label></li>
        </ul>
    </div>
    <div class="inner">
        <div class="items-wrap">
            <div class="sort">
                <ul>
                    <li class="nav1 <%=chkiif(sortMet=5,"on","") %>"><a href="" rel="5">신상품순</a></li>
                    <li class="nav2 <%=chkiif(sortMet=6,"on","") %>"><a href="" rel="6">낮은가격순</a></li>
                    <li class="nav3 <%=chkiif(sortMet=7,"on","") %>"><a href="" rel="7">높은할인율순</a></li>
                </ul>
            </div>
            <div class="order">
                <ul class="items">
                    <% 				
                        dim totalPrice , salePercentString , couponPercentString , totalSalePercent
                        for i = 0 to oExhibition.FResultCount - 1
                        call oExhibition.FItemList(i).fnItemPriceInfos(totalPrice , salePercentString , couponPercentString , totalSalePercent)
                    %>
                    <li> 
                        <a href="/shopping/category_prd.asp?itemid=<%=oExhibition.FItemList(i).Fitemid%>">
                            <div class="thumbnail">
                                <img src="<%=oExhibition.FItemList(i).FImageList%>" alt="" />
                            </div>
                            <div class="desc">
                                <p class="name"><%=oExhibition.FItemList(i).Fitemname%></p>
                                <div class="price">
                                    <div class="unit">
                                        <b class="sum"><%=formatNumber(totalPrice, 0)%>원</b>
                                        <% if salePercentString <> "0" then %><b class="discount color-red">[<%=salePercentString%>]</b><% end if%>
                                        <% if couponPercentString <> "0" then %><b class="discount color-green">[<%=couponPercentString%>]</b><% end if%>
                                    </div>
                                </div>
                            </div>
                        </a>
                    </li>
                    <% 
                        next 
                    %>
                </ul>
            </div>
        </div>
        <div class="pageWrapV15">
            <%= fnDisplayPaging_New_nottextboxdirect(page,iCTotCnt,12,10,"jsGoComPage") %>
        </div>
    </div>
<% end if %>
<%
    SET oExhibition = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->