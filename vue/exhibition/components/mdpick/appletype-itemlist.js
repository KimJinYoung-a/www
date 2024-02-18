Vue.component('appletype-itemlist',{
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
                            <p class="txt1">{{mainText}}</p>\
                            <p class="txt2">{{subText}}</p>\
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
        brandname : {
            type : String,
            default : ''
        },
        itemname : {
            type : String,
            default : ''
        },
        addText1 : {
            type : String,
            default : ''
        },
        addText2 : {
            type : String,
            default : ''
        },
        itemimage : {
            type : String,
            default : ''
        },
        amplitudeActionName : {
            type : String,
            default : ""
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
    computed : {
        mainText : function() {
            return this.addText1 == "" ? this.brandname : this.addText1;
        },
        subText : function() {
            return this.addText2 == "" ? this.itemname : this.addText2;
        }
    },
    methods : {        
        itemUrl : function(itemid) {
            fnAmplitudeEventAction(this.amplitudeActionName+'item','itemid',itemid);
            window.location.href = '/shopping/category_prd.asp?itemid='+itemid;
        },
    },
})