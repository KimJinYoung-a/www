Vue.component('just-one-day',{
	template : `
        <section id="tab01" class="section01">
            <div class="in_wrap" v-if="oneDaySale">
                <div class="inner">
                    <h2><span>단 하루의 기회</span>놓치면 아까운<br>오늘만! 특가</h2>
                    <div class="items">
                        <ul>
                            <li v-for="(data,index) in oneDaySale.products">
                                <a href="javascript:void(0);" @click="moveItem(index,data.productId)">
                                    <div class="desc">
                                        <p class="name" v-html="data.title"></p>
                                        <div class="price">
                                            <span class="discount color-red" v-html="getDiscountText(data.discountText)">{{data.discountText}}%</span>
                                            <span class="sum">{{getPrice(data.priceText)}}원</span>
                                        </div>
                                    </div>
                                    <div class="thumbnail"><img :src="data.image" alt=""></div>
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>	
            </div>                    
        </section>
	`
    , created() {
        const _this = this;
        _this.$store.dispatch('GET_ONE_DAY_ITEM');
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
                autoplay: true,
                slidesPerView: 2.9,
                centeredSlides: true,
                spaceBetween:10, 
                grabCursor: true,
                loop: true,
            });
        })
    }
    , mounted() {
        const _this = this;
        _this.$nextTick(function() {

        })
        
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
        getPrice(priceText) {
			let price = priceText.split('원');
			return price[0];
		},
        getUrl(itemId) {
			// let gaParam = this.createGaParam('today_just1day_1');
			return this.oneDaySale.type == 'E'
					? this.oneDaySale.link
					: '/shopping/category_prd.asp?itemid='+itemId;
		},
		moveItem(index,itemid) {
			let url = this.getUrl(itemid);
            fnAmplitudeEventAction('click_tentensale_todaysale', 'num', index+1);
			location.href = url;
		},
        moveEvent(code) {
            let url = "/event/eventmain.asp?eventid=" + code;
			location.href = url;
        },
        getDiscountText(text) {
			if(text.indexOf('%') > 0) {
				return text.replaceAll('%','<span class="percent">%</span>');
			}
			return text;
		}
    }
})