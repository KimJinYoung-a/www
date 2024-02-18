<script>
function getDiaryItems(subshopgroupcode){
    var srm         = "be";
    var deliType    = "";
    var giftdiv     = "";
    var pageSize    = 12;
    var SubShopCd   = subshopgroupcode == '100102' ? '' : 100;
    var page = 1;
    var subShopGroupCode = subshopgroupcode == '100102' ? '' : subshopgroupcode;
    var cateCode = subshopgroupcode == '100102' ? "101102101109,101102101106,101102101105" : '';
    var items = []

    $.ajax({
		type: "POST",
		url: "/diarystory2021/api/diaryItems.asp",
		data: {
            srm: srm,
            cpg: page,
            pageSize: pageSize,
            SubShopCd: SubShopCd,
            deliType: deliType,
            giftdiv: giftdiv,
            subShopGroupCode : subShopGroupCode,
            cateCode : cateCode,
        },
		dataType: "json",
        success: function(Data){
            items = Data.items;
            //console.log(items);
            renderItems(items,subshopgroupcode);
        },
        error: function(e){
            console.log('데이터를 받아오는데 실패하였습니다.');
        }
    })
}

function renderItems(items,subShopGroupCode){
    var listHtmlStr = '',
        salecouponString = '',
        bestBadge = '',
        newBadge = '',
        giftBadge = '',
        freeDelBadge = '',
        sellYN = ''

    items.forEach(function(item , index){
        <% if giftCheck then %>
        giftBadge = item.giftDiv == 'R' ? '<i class="badge-gift">선물</i>' : ''
        <% end if %>
        freeDelBadge = item.isFreeDelivery == "Y" ? '<i class="badge-delivery">무료배송</i>' : ''
        if (item.saleStr != "" && item.couponStr != "" ) {
            salecouponString = "더블할인"
        } else if (item.saleStr != "") { 
            salecouponString = item.saleStr;
        } else if (item.couponStr != "") {
            salecouponString = item.couponStr;
        } else {
            salecouponString = "";
        }

        listHtmlStr += '<article class="prd-item">\
                            <figure class="prd-img">\
                                <img src="'+ item.itemImg +'" alt="'+ item.itemName +'">\
                            </figure>\
                            <div class="prd-info">\
                                <div class="prd-price">\
                                    <span class="set-price"><dfn>판매가</dfn>'+ item.price +'</span>\
                                    <span class="discount"><dfn>할인율</dfn>'+ salecouponString +'</span>\
                                </div>\
                                <div class="prd-name">'+ item.itemName +'</div>\
                                <div class="user-side">\
                                    <span class="user-eval"><dfn>평점</dfn><i style="width:'+ item.evaltotalpoint +'%">'+ item.evaltotalpoint +'점</i></span>\
                                    <span class="user-comment"><dfn>상품평</dfn>'+ item.evalcount +'</span>\
                                </div>\
                                <div class="prd-badge">\
                                    ' + giftBadge + freeDelBadge + '\
                                </div>\
                                <i class="badge-rank">'+ parseInt(index+1) +'</i>\
                            </div>\
                            <a href="/shopping/category_Prd.asp?itemid='+ item.itemid +'" class="prd-link"><span class="blind">상품 바로가기</span></a>\
                        </article>'
    })

    return $("#diarybestlist").empty().append(listHtmlStr);
}

$(function() {
    getDiaryItems('100101'); // 다이어리

    $('.cate-list li').click(function() {
        $(this).addClass('on').siblings().removeClass('on');
    })
})
</script>

<section class="sect-best">
    <h2>잘 나가는 <br/>베스트 아이템</h2>
    <ul class="cate-list">
        <li class="on"><a href="javascript:getDiaryItems('100101');">다이어리</a></li>
        <li><a href="javascript:getDiaryItems('100102');">6공</a></li>
        <li><a href="javascript:getDiaryItems('100103');">플래너</a></li>
        <li><a href="javascript:getDiaryItems('100104');">스티커</a></li>
        <li><a href="javascript:getDiaryItems('100105');">떡메모지</a></li>
        <li><a href="javascript:getDiaryItems('100106');">펜/색연필</a></li>
    </ul>
    <div class="prd-list" id="diarybestlist"></div>
</section>