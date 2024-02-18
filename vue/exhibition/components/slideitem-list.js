Vue.component('slideitem-list',{
    template :'\
                <div class="item">\
                    <a @click="itemUrl(itemid)">\
                        <div class="thumbnail">\
                            <p v-if="optionCode > \'0\'" class="tagV18 t-low"><span>{{tagName}}</span></p>\
                            <img :src="itemimage" :alt="itemname" v-if="index < 4">\
                            <img v-lazy="itemimage" :alt="itemname" v-else>\
                        </div>\
                        <div class="desc">\
                            <p class="name">{{itemname}}</p>\
                            <p class="price">\
                                <span class="sum">{{totalprice}}원</span>\
                                <span v-if="saleperstring > \'0\'" class="discount color-red">{{saleperstring}}</span>\
                                <span v-if="couponperstring > \'0\'" class="discount color-green">{{couponperstring}}</span>\
                            </p>\
                        </div>\
                    </a>\
                </div>\
                '
    ,
    props: {
        index : {
            type : Number,
            default : 0
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
            type : [Number,String],
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
        optionCode : {
            type : [String,Number],
            default : "0"
        }
    },
    computed : {
        tagName : function() {
            switch (this.optionCode) {
                case "1" :
                    return '최저가';
                case "2" : 
                    return '특가';
                case "3" : 
                    return '단독';
                default : 
                    return ''
            }
        }
    },
    methods : {        
        itemUrl : function(itemid) {
            fnAmplitudeEventAction(this.amplitudeActionName,'itemid',itemid);

            window.location.href = '/shopping/category_prd.asp?itemid='+itemid;
        },
    },
})