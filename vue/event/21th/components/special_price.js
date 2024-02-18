Vue.component('SPECIAL-PRICE', {
    template : `
        <section id="tab02" class="tab02">
            <section class="section05" v-if="oneDaySale">
                <a href="javascript:void(0);" @click="moveItem(oneDaySale.products[0])">
                    <img src="//webimage.10x10.co.kr/fixevent/event/2022/anniversary/section05.png" alt="">
                    <div class="thumbnail">
                        <img :src="oneDaySale.products[0].image" alt="">
                    </div>
                    <div class="desc">
                        <p class="name" v-html="oneDaySale.products[0].title"></p>
                        <div class="price">
                            <span class="discount" v-html="getDiscountText(oneDaySale.products[0].discountText)"></span>
                            <span class="sum">{{getPrice(oneDaySale.products[0])}}</span>
                        </div>
                    </div>
                </a>
            </section>
            <section class="section06" id="cheer02" v-if="timeSale">
                <a href="javascript:void(0)" @click="moveEvent(timeSale.eventid)">
                    <img :src="timeSale.imageurl" alt="">
                </a>
            </section>
            <section class="section07" v-if="tentenOfTwentyOne">
                <button @click="moveEvent(120314)"></button>
                <div class="swiper02">
                    <div class="swiper prdSwiper">
                        <div class="swiper-wrapper">
                            <div class="swiper-slide" v-for="(item, index) in tentenOfTwentyOne">
                                <img :src="item.imageurl" alt="">
                            </div>
                        </div>
                    </div>
                </div> 
            </section>
        </section>
    `
    , created() {
        const _this = this;
        _this.$store.dispatch('GET_ONE_DAY_ITEM');
        _this.$store.dispatch('GET_BANNER_IMAGE', 201); // 타임세일
        _this.$store.dispatch('GET_BANNER_IMAGE', 202); // 21가지의 텐텐
    }
    , data() {
        return {
            itemList: [],
            isUserLoginOK: false
        }
    }
    , updated() {
        const _this = this;
        _this.$nextTick(function() {
            var mySwiper = new Swiper(".prdSwiper", {		
                slidesPerView: 4,
                spaceBetween:10,
                autoplay:true,		
                loop: true,
            });
        })
    }
    , mounted() {
        const _this = this;        
    }
    , computed : {
        oneDaySale() {
            return this.$store.getters.oneDaySale;
        },
        timeSale() {
            return this.$store.getters.timeSale;
        },
        tentenOfTwentyOne() {
            return this.$store.getters.tentenOfTwentyOne;
        }
    },
    methods : {
        getPrice(product) {
			let price = product.priceText.split('원');
            if (product.dealProduct) {
                price[0] = price[0] + "~";
            }
			return price[0];
		},
        getUrl(itemId) {
			// let gaParam = this.createGaParam('today_just1day_1');
			return this.oneDaySale.type == 'E'
					? this.oneDaySale.link
					: '/shopping/category_prd.asp?itemid='+itemId;
		},
		moveItem(item) {
			let url = this.getUrl(item.productId);
            location.href = url;
		},
        moveEvent(code) {
            location.href  = "/event/eventmain.asp?eventid=" + code;
        },
        getDiscountText(text) {
			if(text.indexOf('%') > 0) {
				return text.replaceAll('%','<span class="percent">%</span>');
			}
			return text;
		}
    }
});
