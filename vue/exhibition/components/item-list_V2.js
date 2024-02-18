Vue.component('item-list',{
    template :`
        <li>
            <a @click="itemUrl(itemid)">
                <div class="thumbnail"><img :src="itemimage" :alt="itemname"></div>
                <div class="desc">
                    <p class="name">{{itemname}}</p>
                    <p class="price">
                        <span class="sum">{{numberWithCommas(totalprice)}}원</span>
                        <span v-if="saleperstring > \'0\'" class="discount color-red">{{saleperstring}}</span>
                        <span v-if="couponperstring > \'0\'" class="discount color-green">{{couponperstring}}</span>
                    </p>
                </div>
            </a>
            <slot>
                <wish-evaluate
                    :evalCount="evalCount"
                    :favCount="favCount"
                    :totalPoint="totalPoint"
                >
                </wish-evaluate>
            </slot>
        </li>
    `
    , props: {
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
        favCount : {
            type : Number,
            default : 0
        },
        totalPoint : {
            type : Number,
            default : 0
        },
    },
    methods : {        
        itemUrl : function(itemid) {
            fnAmplitudeEventAction(this.amplitudeActionName+'item','itemid',itemid);
            window.location.href = '/shopping/category_prd.asp?itemid='+itemid;
        }
        , numberWithCommas : function(price) {
            return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        }
    },
})

Vue.use(VueLazyload, {
	preLoad: 1.3,
	error : false,
	loading : false,
	supportWebp : false,
	listenEvents: ['scroll', 'wheel', 'mousewheel', 'resize', 'animationend', 'transitionend', 'touchmove']
})