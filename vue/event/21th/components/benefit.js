Vue.component('BENEFIT', {
    template : `
        <section id="tab01" class="tab01">
            <section class="section01">
                <div class="scroll">
                    <p class="scroll01"><a href="#cheer01"></a></p>
                    <p class="scroll02"><a href="#cheer02"></a></p>
                    <p class="scroll03"><a href="#cheer03"></a></p>
                    <p class="scroll04"><a href="#cheer04"></a></p>
                    <p class="scroll05"><a href="#cheer04"></a></p>
                    <p class="scroll06"><a href="#cheer06"></a></p>
                </div>
            </section>
            <section class="section02" id="cheer01" @click="moveCoupon">
                <div class="coupon_area">
                    <p class="coupon"><img src="//webimage.10x10.co.kr/fixevent/event/2022/anniversary/coupon.png" alt=""></p>
                    <p class="coupon_wrap"><img src="//webimage.10x10.co.kr/fixevent/event/2022/anniversary/coupon_wrap.png" alt=""></p>
                </div>
            </section>
            <section class="section03" v-if="showSpecialBanner('mileage')">
                <div class="mileage_area">
                    <p class="mileage"><img src="//webimage.10x10.co.kr/fixevent/event/2022/anniversary/mileage.png?v=2" alt=""></p>
                    <p class="mileage_wrap"><img src="//webimage.10x10.co.kr/fixevent/event/2022/anniversary/mileage_wrap.png" alt=""></p>
                </div>
                <button @click="movePage('mileage')"></button>
            </section>
            <section class="section04" v-if="showSpecialBanner('freeDelivery') && freeDelivery">
                <div class="swiper01">
                    <div class="swiper freeSwiper">
                        <div class="swiper-wrapper">
                            <div class="swiper-slide" v-for="(item, index) in freeDelivery">
                                <a href="javascript:void(0)" @click="moveDealProduct(item.eventid)">
                                    <img :src="item.imageurl" alt="">
                                </a>    
                            </div>
                        </div>
                    </div>
                    <div class="swiper-button-next"></div>
                    <div class="swiper-button-prev"></div>
                </div>
                <button @click="movePage('freeDelivery')"></button>
            </section>
        </section>
    `
    , created() {
        const _this = this;
        _this.$store.dispatch('GET_BANNER_IMAGE', 101); // 무배데이
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
            var swiper = new Swiper(".freeSwiper", {
                slidesPerView: 5,
                loop:true,
                spaceBetween:15,
                autoplay:true,	
                navigation: {
                    nextEl: ".swiper-button-next",
                    prevEl: ".swiper-button-prev",
                },
            });
        })
    }
    , mounted() {
        const _this = this;
        _this.$nextTick(function() {
            // link smooth 이동 
            $('.tab-area, .scroll').on('click', 'a[href^="#"]', function (event) {
                var tabHeight = $('.tab-area').outerHeight() + 70;
                event.preventDefault();
                $('html, body').animate({
                    scrollTop: $($.attr(this, 'href')).offset().top - tabHeight
                }, 500);
            });
        })
        
    }
    , computed : {
        freeDelivery() {
            return this.$store.getters.freeDelivery;
        }
    },
    methods : {
        showSpecialBanner(type) {
            let result = false;
            let day = new Date().getDay();
            if (type === 'mileage' & (day === 3 || day === 4) ) {
                result = true;
            } else if (type === 'freeDelivery' && (day === 1 || day === 2) ) {
                result = true;
            }
            return result
        },
        movePage(type) {
            let url = "";
            if (type === 'mileage') {
                url = "/my10x10/mymain.asp";
            } else {
                url = "/event/eventmain.asp?eventid=120550";
            }
            location.href = url;
        },
        moveCoupon() {
            let url = "/my10x10/couponbook.asp?tab=1"
            location.href = url;
        },
        moveDealProduct(itemId) {
            if (itemId === '0') {
                return false;
            } else {
                let url = "/deal/deal.asp?itemid=";
                location.href = url + itemId;
            }
        }
    }
});