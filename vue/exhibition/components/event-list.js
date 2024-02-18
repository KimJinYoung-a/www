Vue.component('event-list',{
    template :'\
                <li>\
                    <a @click="eventUrl(index,eventid)">\
                        <div class="thumbnail"><img :src="rectangleimage" :alt="eventname"></div>\
                        <div class="desc">\
                            <p class="headline"><span class="ellipsis">{{eventname}}</span>\
                                <b class="discount color-red">{{salePerString}}</b>\
                                <b class="discount color-green">{{couponPerString}}</b>\
                            </p>\
                            <p class="subcopy">{{subcopy}}</p>\
                        </div>\
                    </a>\
                </li>\
                '
    ,
    computed : {
        salePerString : function() {
            var saleString = this.saleper;
            return saleString > 0 ? "~"+saleString+"%" : "";
        }
    },
    props: {
        index : {
            type : Number,
            default : 0
        },
        eventid: {
            type: Number,
            default: 0
        },
        eventname : {
            type : String,
            default : ''
        },
        subcopy : {
            type : String,
            default : ''
        },
        squareimage : {
            type : String,
            default : ''
        },
        rectangleimage : {
            type : String,
            default : ''
        },
        saleper : {
            type : [Number, String],
            default : "0"
        },
        salecper : {
            type : [Number, String],
            default : "0"
        },
        isgift : {
            type : Boolean,
            default : false
        },
        issale : {
            type : Boolean,
            default : false
        },
        isoneplusone : {
            type : Boolean,
            default : false
        },
        amplitudeActionName : {
            type : String,
            default : ""
        },
    },
    computed : {
        salePerString : function() {
            return this.saleper > 0 ? "~"+this.saleper+"%" : "";
        },
        couponPerString : function() {
            return this.salecper > 0 ? "+ "+this.salecper+"%" : "";
        }
    },
    methods : {        
        eventUrl : function(index,eventid) {
            fnAmplitudeEventMultiPropertiesAction(this.amplitudeActionName,'idx|eventcode',index +'|'+ eventid);
            window.location.href = "/event/eventmain.asp?eventid="+ eventid;
        },
    },
})