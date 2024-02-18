<script>
function getBrandLists(sortdiv){
    var items = [];
    $("#btn1").removeClass("active");
    $("#btn2").removeClass("active");
    if(sortdiv=="best"){
        $("#btn1").addClass("active");
    }else{
        $("#btn2").addClass("active");
    }
    $.ajax({
		type: "GET",
		url: apiurl + "/tempEvent/tentenEventBrand",
		data: {
            brandListMasterIdx: "<%=brandListMasterIdx%>",
            sortType : sortdiv
        },
		dataType: "json",
        success: function(res){
            renderBrands(res);
        },
        error: function(e){
            console.log('데이터를 받아오는데 실패하였습니다.');
        }
    })
}
function renderBrands(items){
    var listHtmlStr = ''
    items.forEach(function(item){
        listHtmlStr += '<li><a href="/street/street_brand_sub06.asp?makerid=' + item.brandid + '">' + item.socname_kor + '</a></li>'
    });
    return $("#brandList").empty().append(listHtmlStr);
}
$(function() {
    getBrandLists("best");
});
</script>
    <section class="section-brand" id="brand">
        <h3><img src="//webimage.10x10.co.kr/fixevent/event/2021/109789/tit_brand.png" alt="나의 최애 브랜드"></h3>
        <div class="tab">
            <button class="active" id="btn1" onclick="getBrandLists('best');">인기순</button>
            <button  id="btn2" onclick="getBrandLists('kor');">가나다순</button>
        </div>
        <div class="brand-list">
            <ul id="brandList"></ul>
        </div>
    </section>