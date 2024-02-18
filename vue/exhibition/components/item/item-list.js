Vue.component('item-list',{
    template :'\
                <li>\
                    <a @click="itemUrl(itemid)">\
                        <div class="thumbnail">\
                            <img :src="itemimage" :alt="itemname">\
                            <slot>\
                                <ShoppingBag\
                                    :itemId="itemid"\
                                    :optionCount="optionCount"\
                                    :sellCash="sellCash"\
                                >\
                                </ShoppingBag>\
                            </slot>\
                        </div>\
                        <div class="desc">\
                            <p class="price">{{totalprice}}\
                                <span v-if="saleperstring > \'0\'" class="sale">{{saleperstring}}</span>\
                                <span v-if="couponperstring > \'0\'" class="coupon">{{couponperstring}}</span>\
                            </p>\
                            <p class="name">{{itemname}}</p>\
                            <div class="tag review" v-if="evalCount > \'0\'"><span><i v-bind:style="{width : totalPoint +\'%\'}"></i></span>{{evalCount}}</div>\
                        </div>\
                    </a>\
                </li>\
                '
    ,
    props: {
        index : {
            type: Number,
            default: 0
        },
        itemid: {
            type: Number,
            default: 0
        },
        itemname : {
            type : String,
            default : ''
        },
        itemimage : {
            type : String,
            default : ''
        },
        brandname : {
            type : String,
            default : ''
        },
        totalprice : {
            type : String,
            default : "0"
        },
        totalsaleper : {
            type : String,
            default : "0"
        },
        saleperstring : {
            type : String,
            default : "0"
        },
        couponperstring : {
            type : String,
            default : "0"
        },
        amplitudeActionName : {
            type : String,
            default : ""
        },
        evalCount: {
            type: Number,
            default: 0
        },
        totalPoint : {
            type : Number,
            default : 0
        },
        optionCount : {
            type : Number,
            default : 0
        },
        sellCash : {
            type : Number,
            default : 0
        }
    },
    methods : {        
        itemUrl : function(itemid) {
            fnAmplitudeEventAction(this.amplitudeActionName+'item','itemid',itemid);
            window.location.href = '/shopping/category_prd.asp?itemid='+itemid;
        },
    },
})