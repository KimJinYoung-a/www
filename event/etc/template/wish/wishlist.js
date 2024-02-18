(function(_$) {
    // get wishlist.asp
	var json_data = '/apps/webapi/wish/getPopularWishList.asp';
    var _data = [];
    var _trigger = 650;
    var _displayCatecode = '116';
    var _sortNumber = 3;
    var _page = 1;
    var fnWishList = {
        el : function(){
            return _$("#getWishList");
        },
        getWishListData : function() {
            var _parameters = "?disp="+ _displayCatecode +"&sort="+ _sortNumber +"&cpg="+ _page;
            // 비동기로 Data를 전역 변수에 저장함
            _$.ajaxSetup({
                async : false
            });
            _$.getJSON(json_data + _parameters , function (data, status, xhr) {
                if (status == 'success') {
                    var _list = data.wish;
                    if (Object.keys(_data).length == 0) {
                        _data = _list;
                    } else {
                        var tempData = new Array();
                        _$.each(_list, function(key,value) {
                            tempData.push(value);
                        });
                        _data = _data.concat(tempData);
                    }
                } else {
                    console.log('JSON data not Loaded.' + status);
                }
            });
        },
        getMainHtml : function(v) {
            var tophtml = '<div class="wish-list">\
                        <p><img src="//webimage.10x10.co.kr/fixevent/event/2020/103450/tit_wish.png" alt="지금 실시간으로 위시를 받은 상품들!"></p>\
                        <ul>'+ v +'</ul>\
                    </div>'
            
            return tophtml;
        },
        getSubHtml : function(v) {
            var subhtml;
            var s = v.brandname;
            var im = v.itemname;
            var st = im.length > 20 ? im.substring(0,20)+'..' : im.substring(0,20);

            subhtml = '<li>';
            subhtml = subhtml + '<a href="/shopping/category_prd.asp?itemid='+ v.itemid +'">';
            subhtml = subhtml + '<div class="thumbnail"><img src="'+ v.basicimage +'" alt="'+ im +'"></div>';
            subhtml = subhtml + '<div class="desc">';
            subhtml = subhtml + '<div class="name">['+ s +'] '+ st +'</div>';
            subhtml = subhtml + '<div class="price">'+ v.totalprice +'원';
            if(v.saleyn ==='Y'){
                subhtml = subhtml + ' <span class="sale">'+ v.totalsaleper +'</span>';
            }
            subhtml = subhtml + '</div>';
            subhtml = subhtml + '</div>';
            subhtml = subhtml + '<button class="btn-bag" optcnt="'+ v.itemoptioncount +'" itemid="'+ v.itemid +'" orgprice="'+ v.sellcash +'">장바구니 담기</button>';
            subhtml = subhtml + '</a>';
            subhtml = subhtml + '</li>';

            return subhtml;
        },
        setDataToHtml : function() {
            // 저장된 전역 변수 Data를 HTML 바인딩 시킴
            var addEl = new Array();
            _$.each(_data,function(index){
                addEl += fnWishList.getSubHtml(_data[index]);
            });

            return fnWishList.el().html(fnWishList.getMainHtml(addEl));
        },
        getNextPageHtml : function() {
            setTimeout(function() {
                fnWishList.getWishListData()
            },100);

            return fnWishList.setDataToHtml();
        },
    }

    // init 
    fnWishList.getWishListData();

    // first bind
    _$(function() {
        fnWishList.setDataToHtml();

        // scroll action
        _$(window).scroll(function() {
            if (_$(window).scrollTop() >= _$(document).height() - _$(window).height() - _trigger - _$('.related-event').height()){
                _page += 1
                fnWishList.getNextPageHtml();
            }
        });
    });

    // 장바구니
    _$(document).on('click', function(event){
        if(_$(event.target).attr('class') == 'btn-bag'){
            event.preventDefault();
            var itemid = _$(event.target).attr("itemid");
            var itemoptioncount = _$(event.target).attr("optcnt");
            var orgprice = _$(event.target).attr("orgprice");

            var addCart = function(arg1, arg2) {
                var frm = document.sbagfrm;
                frm.itemid.value = arg1;
                frm.itemid.itemPrice = arg2;
                
                var vTrData;

                vTrData = "mode=add";
                vTrData += "&itemid=" + frm.itemid.value;
                vTrData += "&sitename=" + frm.sitename.value;
                vTrData += "&itemoption=" + frm.itemoption.value;
                vTrData += "&itemPrice=" + frm.itemPrice.value;
                vTrData += "&isPhotobook=" + frm.isPhotobook.value;
                vTrData += "&isPresentItem=" + frm.isPresentItem.value;
                vTrData += "&itemea=" + frm.itemea.value;

                _$.ajax({
                    type: "POST",
                    url: "/inipay/shoppingbag_process.asp?tp=ajax",
                    data: vTrData,
                    success: function(message) {
                        switch(message.split("||")[0]) {
                            case "0":
                                alert("유효하지 않은 상품이거나 품절된 상품입니다.");
                                break;
                            case "1":
                                fnDelCartAll();
                                alert("선택하신 상품을\n장바구니에 담았습니다.");
                                break;
                            case "2":
                                alert("장바구니에 이미\n같은 상품이 있습니다.");
                                break;
                            default:
                                alert("죄송합니다. 오류가 발생했습니다.");
                                break;
                        }
                    }
                });
            }

            return (itemoptioncount > 0) ? ZoomItemInfo(itemid) : addCart(itemid, orgprice);
        }
    });
}(jQuery));