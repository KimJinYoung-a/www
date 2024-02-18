<script>
$(function(){
    getDiaryItems(1, true);

    $("#sortMenu li").click(function(){
        $("#sortmet").val($(this).attr("sort"))
        getDiaryItems()
    })

    $(".cate-menu ul li input").click(function(){
        getDiaryItems()
    })

    $(".slt-area li input").click(function(){
        getDiaryItems()
    })
})
function getDiaryItems(page, init){
    var searchParam = getSearchParam()
    var srm         = $("#sortmet").val();
    var attribCd    = searchParam.att; //$("input[name='dtype']:checked").val() == undefined ?  : $("input[name='dtype']:checked").val()
    var deliType    = $('input:checkbox[id="deliType"]').is(':checked') ? $("#deliType").val() : ""
    var giftdiv     = $('input:checkbox[id="giftdiv"]').is(':checked') ? $("#giftdiv").val() : ""
    var colorCd     = searchParam.color
    var pageSize    = 16
    var SubShopCd   = 100
    var moveElement = document.location.href.indexOf("search.asp") != -1 ? "#prdWrap" : "#cate-menu"

	if (page==''){
		page=1;
    }
    var items = []
    var pagingData = {}

    $.ajax({
		type: "POST",
		url: "/diarystory2020/api/diaryItems.asp",
		data: {
            srm: srm,
            cpg: page,
            pageSize: pageSize,
            SubShopCd: SubShopCd,
            deliType: deliType,
            giftdiv: giftdiv,
            attribCd: attribCd,
            colorCd: colorCd
        },
		dataType: "json",
        success: function(Data){
            $("#listContainer").empty();
            $("#pagingElement").empty();

            items = Data.items
            pagingData = Data.pagingData

            // console.log(items)

            renderItems(items)
            renderPaging(pagingData)

            if(!init) window.$('html,body').animate({scrollTop:$(moveElement).offset().top}, 400);
        },
        error: function(e){
            console.log('데이터를 받아오는데 실패하였습니다.')
            $("#listContainer").empty();
            $("#pagingElement").empty();
        }
	})
}
function renderPaging(pagingObj){
    if(Object.keys(pagingObj).length === 0 && pagingObj.constructor === Object) return false;
    var pagingHtml='';
    var totalpage = parseInt(pagingObj.totalpage);
    var currpage = parseInt(pagingObj.currpage);
    var scrollpage = parseInt(pagingObj.scrollpage);
    var scrollcount = parseInt(pagingObj.scrollcount);
    var totalcount = parseInt(pagingObj.totalcount);
    var falert = "alert('이전페이지가 없습니다.'); return false;"
    var nalert = "alert('다음페이지가 없습니다.'); return false;"

    if(totalpage > 1){
        pagingHtml +='<div class="paging">';	//'+totalcount+'
        pagingHtml +='	<a href="" onclick="getDiaryItems(1); return false;" class="first arrow"><span>맨 처음 페이지로 이동</span></a> ';
        if(currpage>1){
            pagingHtml +=' <a href="" onclick="getDiaryItems('+(currpage-1)+'); return false;" class="prev arrow"><span>이전페이지로 이동</span></a> ';
        }else{
            pagingHtml +=' <a href="" onclick="'+falert+'" class="prev arrow"><span>이전페이지로 이동</span></a> ';
        }
        for (var ii=(0+scrollpage); ii< (scrollpage+scrollcount); ii++) {
            if(ii > totalpage){
                break;
            }
            if(ii==currpage){
                pagingHtml +=' <a href="javascript:void(0)" class="current"><span>'+ii+'</span></a> '
            }else{
                pagingHtml +=' <a href="" onclick="getDiaryItems('+ii+'); return false;" ><span>'+ii+'</span></a> '
            }
        }
        if(currpage < totalpage){
            pagingHtml +=' <a href="" onclick="getDiaryItems('+(currpage+1)+'); return false;" class="next arrow"><span>다음 페이지로 이동</span></a>' ;
        }else{
            pagingHtml +=' <a href="" onclick="'+nalert+'" class="next arrow"><span>다음 페이지로 이동</span></a> ';
        }
        pagingHtml +=' <a href="" onclick="getDiaryItems('+totalpage+'); return false;" class="end arrow"><span>맨 마지막 페이지로 이동</span></a> ';
        pagingHtml +='</div>';
        pagingHtml +='<div class="pageMove">';
        pagingHtml +='<input type="text" style="width:24px;" /> /23페이지 <a href="" class="btn btnS2 btnGry2"><em class="whiteArr01 fn">이동</em></a>';
        pagingHtml +='</div>';
    }
    $("#pagingElement").html(pagingHtml);
}
function renderItems(items){
    if(items.length < 1){
        var noResultHtml = '<div class="nodiary-area">\
                                <p>만족하는 다이어리가 없습니다</p>\
                                <button type="button" class="btn-nodiary" onclick="window.location.reload()">다이어리 전체보기</button>\
                            </div>'
        $("#listContainer").html(noResultHtml);
        return false;
    }
    var listHtmlStr = ''
    var bestBadge = ''
    var newBadge = ''
    var giftBadge = ''
    var freeDelBadge = ''
    var soldOut = ''

    listHtmlStr += '<ul>'
    items.forEach(function(item){
        bestBadge = item.bestYn == 'Y' ? '<div class="badge badge-best">BEST</div>' : ''
        newBadge = item.newYn == 'Y' ? '<div class="badge badge-new">NEW</div>' : ''
        if(item.bestYn == 'Y' && item.newYn == 'Y') newBadge = ''

        giftBadge = item.giftDiv == 'R' ? '<div class="badge badge-giftyou color-diary">사은품증정</div>' : ''
        freeDelBadge = item.isFreeDelivery == 'Y' ? '<div class="badge badge-giftyou">무료배송</div>' : ''
        soldOut = item.sellYN == 'N' ? '<span class="soldout"><span class="ico-soldout">일시품절</span></span>' : ''
  
        listHtmlStr += '\
                <li class="item"> \
                    <a href="/shopping/category_prd.asp?itemid='+ item.itemid +'">\
                        <div class="thumbnail">\
                            <img src="'+ item.itemImg +'" alt="'+ item.itemName +'" />\
                            ' + soldOut + '\
                        </div>\
                        '+ bestBadge + newBadge + '\
                        <div class="badge-group">\
                        '+ freeDelBadge + giftBadge + '\
                        </div>\
                        <div class="desc">\
                            <div class="price-area">\
                                <span class="price">'+ item.price +'</span>\
                                <b class="discount sale">'+ item.saleStr +'</b>\
                                <b class="discount coupon">'+ item.couponStr +'</b></div>\
                            <p class="name">'+ item.itemName +'</p>\
                            <div class="brand">'+ item.brandName +'</div>\
                        </div>\
                    </a>\
                </li>\
        '
    })
    listHtmlStr += '</ul>'
    $("#listContainer").html(listHtmlStr);
}
</script>
<script>
// 검색 스크립트
$(function(){
	$(".colorchips li input").click(function(){
        $(this).parent().toggleClass("selected")
		if($(this).val() == '' && $(this).prop("checked")){
        // 전체
			$(".colorchips input[type=checkbox]").prop("checked",false);
			$(".colorchips li").removeClass("selected")
			$(this).parent().toggleClass("selected")
		}else{
        // 전체 이외
			$("#all").prop("checked",false)
			$("#all").parent().removeClass("selected")
            if($('.colorchips input:checkbox:checked').length == 0){
                $("#all").prop("checked",true)
                $("#all").parent().toggleClass("selected")
            }
		}

	})
})
function generateAttr(targetArr){
    var result = ""
	targetArr.forEach(function(item){
		result += item + ','
	});

    return $.trim(result)
}
function getSearchParam(){
	var attTempArr = []
	var colorTempArr = []
	$('.diary-attr input:checkbox:checked').each(function(){
        var attr = $(this).val();
        if(attr == "") return true
		attTempArr.push(attr)
	})

	$('.colorchips input:checkbox:checked').each(function(){
        var colorChip = $(this).val();
        if(colorChip == "") return true
		colorTempArr.push(colorChip)
    })
    return {
        att: generateAttr(attTempArr),
        color: generateAttr(colorTempArr)
    }
}
function resetOptions(){
	$("input[type=checkbox]").prop("checked",false);
    $(".colorchips li").removeClass("selected")
    $("#all").prop("checked",true)
    $("#all").parent().toggleClass("selected")
}
</script>
<form name="sFrm" method="post">
    <input type="hidden" name="sortmet" id="sortmet" value="be" >
    <div class="prd-wrap" id="prdWrap">
        <div class="item-area">
            <div class="sort-area">
                <ul class="slt-area">
                    <li><input type="checkbox" name="deliType" value="FD"  id="deliType" /><label for="deliType">무료배송 상품</label></li>
                    <li><input type="checkbox" name="giftdiv"  value="R" id="giftdiv" /><label for="giftdiv">사은품 증정 상품</label></li>
                </ul>
                <ul class="tab-menu" id="sortMenu">
                    <li sort="be" class="on"><a href="/">인기상품순</a></li>
                    <li sort="ne"><a href="">신상품순</a></li>
                    <li sort="lp"><a href="">낮은가격순</a></li>
                    <li sort="hs"><a href="">높은할인율순</a></li>
                </ul>
            </div>
            <div class="item-list" id="listContainer">
            </div>
        </div>
        <div class="pageWrapV15" id="pagingElement"></div>
    </div>
</form>