Vue.component('ShoppingBag',{
    template : '<button class="btn-cart" v-on:click.stop="addShoppingBag">장바구니</button>\
    ',
    props : {
        itemId : {
            type : Number,
            default : 0,
        },
        optionCount : {
            type : Number,
            default : 0,
        },
        sellCash : {
            type : Number,
            default : 0,
        }
    },
    methods : {
        addShoppingBag : function() {
            if (this.itemId == 0) {
                return false;
            }

            if (this.optionCount > 0) {
                ZoomItemInfo(this.itemId);
            } else {
                let vTrData = {
                    "mode" : "add",
                    "itemid" : this.itemId,
                    "sitename" : "",
                    "itemoption" : "0000",
                    "itemPrice" : this.sellCash,
                    "isPhotobook" : "",
                    "isPresentItem" : "",
                    "itemea" : "1"
                }

                let offsetTop = $(event.target).offset().top;
                let offsetLeft = $(event.target).offset().left;

                $.ajax({
                    type : "POST",
                    url : "/inipay/shoppingbag_process.asp?tp=ajax",
                    data : vTrData,
                    success: function(message) {
                        switch(message.split("||")[0]) {
                            case "0":
                                alert("유효하지 않은 상품이거나 품절된 상품입니다.");
                                break;
                            case "1":
                                fnDelCartAll();
                                $(".cartLyr").css({
                                    "position" : "absolute",
                                    "top" : offsetTop-145,
                                    "left" : offsetLeft-120
                                });
                                $("#alertMsg").html("선택하신 상품을<br />장바구니에 담았습니다.");
                                $(".cartLyr").fadeIn('fast').delay(3000).fadeOut();
                                break;
                            case "2":
                                $(".cartLyr").css({
                                    "position" : "absolute",
                                    "top" : offsetTop-145,
                                    "left" : offsetLeft-120
                                });
                                $("#alertMsg").html("장바구니에 이미<br />같은 상품이 있습니다.");
                                $(".cartLyr").fadeIn('fast').delay(3000).fadeOut();
                                break;
                            default:
                                alert("죄송합니다. 오류가 발생했습니다.");
                                break;
                        }
                    }
                });
            }
       }
    }
})