Vue.component('floating', {
    template: `
        <div class="floating" :class="{'no-sticky' : !addClass}">
            <div class="floating__inner">
                <div class="swiper brand-swiper">
                    <ul class="swiper-wrapper">
                        <li v-for="(list, index) in swiperList" 
                            class="swiper-slide" 
                            :class="{'is-selected' : selectedSlide === list}" 
                            :value="index"
                            @click="moveBrandRef(list,index)">{{ list }}</li>
                    </ul>
                    <div class="swiper-button-next"></div>
                    <div class="swiper-button-prev"></div>
                </div>
                <div 
                    class="button-coupon" 
                    :class="{'is-change-coupon' : hasCoupon}" 
                    @click="openCouponModal">
                    <button 
                        id="modal_toggle"
                        class="button-coupon__text">
                            {{ hasCoupon ? '한정할인 적용중' : '쿠폰 발급받기' }}
                    </button>
                </div>
            </div>
            <coupon-modal
                v-if="isViewCouponModal"
                @closeCouponModal="openCouponModal"
            />
        </div>
    `,
    data() {
        return {
            isViewCouponModal: false,
            agreeCheck: false,
            addClass: false,
            totalHeight : '',
            selectedSlide: [],
        };
    },
    updated() {
        this.swiper();
        window.addEventListener('scroll', this.hasScrolled);
    },
    computed: {
        hasCoupon() {
            return this.$store[0].getters.hasCoupon;
        },
        gnbFlagCheck() {
            return gnbFlag;
        },
        swiperList() {
            let list = [];
            let brandItemList = this.$store[0].getters.brandItemListGroup;
            let discountItemList = this.$store[0].getters.discountItemListGroup;
            this.selectedSlide = this.$store[0].getters.brandItemListGroup;

            for (let i = 0; i < brandItemList.length; i++) {
                list.push(brandItemList[i].brand_name_kr);
            }
        
            for (let i = 0; i < discountItemList.length; i++) {
                list.push(discountItemList[i].category_name_kr);
            }

            this.selectedSlide = list[0];
            return list;
        },
    },
    methods: {
        openCouponModal() {
            document.getElementById('modal_toggle').classList.toggle('open',  !this.isViewCouponModal);
            this.isViewCouponModal = !this.isViewCouponModal;
        },
        checkHandler() {
            this.agreeCheck = !this.agreeCheck;
        },
        moveBrandRef(itemId, index) {
            this.selectedSlide = itemId;
            mySwiper.slideTo(index, 1000, false);
            window.scrollTo({top : document.getElementById(`${itemId}`).getBoundingClientRect().top + window.pageYOffset - 60,   behavior: 'smooth'});
        },
        hasScrolled() {
            let endFloating = document.querySelector('#exhibit-and-event').getBoundingClientRect().top;
            if (endFloating > 0) {
                this.addClass = true;
            } else {
                this.addClass = false;
            }

            let scrollPos = document.documentElement.scrollTop;
            let tabs = document.querySelectorAll('.floating .swiper-slide');
            for (let j = 0; j < tabs.length; j++) {
                let selectedTab = document.querySelectorAll('.floating .swiper-slide')[j];
                let selectedId = selectedTab.getAttribute('value');
                let selectedContent = document.querySelectorAll('.monthly-items')[selectedId];
                if (selectedContent.getBoundingClientRect().top + window.pageYOffset <= scrollPos + 100 && selectedContent.getBoundingClientRect().top + window.pageYOffset + selectedContent.clientHeight >= scrollPos + 100) {
                    for (let i = 0; i < tabs.length; i++) {
                        document.querySelectorAll('.floating .swiper-slide')[i].classList.remove('is-selected');
                    }
                    
                    selectedTab.classList.add('is-selected');
                    mySwiper.slideTo(selectedId);
                } else if (document.querySelectorAll('.monthly-items')[0].getBoundingClientRect().top + window.pageYOffset > scrollPos + 55) {
                    for (let h = 0; h < tabs.length; h++) {
                        document.querySelectorAll('.floating .swiper-slide')[h].classList.remove('is-selected');
                    }
                }
            }
        },
        swiper() {
            this.$nextTick(function() {
                mySwiper = new Swiper (".brand-swiper", {
                    slidesPerView:'auto',
                    grabCursor: true,
                    navigation: {
                        nextEl: ".swiper-button-next",
                        prevEl: ".swiper-button-prev",
                    },
                    slideToClickedSlide: true,
                });
            });
        },
    }
});