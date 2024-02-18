const app = new Vue({
    el: "#page",
    store: [storeData],
    template: `
        <main class="monthly">
            <div class="monthly__top-banner">
                <img src="//webimage.10x10.co.kr/fixevent/event/2023/monthly/feburary/pc/intro-banner.jpg?v=1.1" alt="월간 텐텐">
            </div>
            <section class="monthly__container">
                <!-- 메뉴 스와이퍼 -->
                <div class="swiper menu-swiper">
                    <ul v-if="!!brandList.length" class="swiper-wrapper">
                        <li 
                            v-for="(brand, index) in brandList" 
                            :key="getLoopKey('brand-list', brand.makerId)" 
                            class="swiper-slide" 
                            :class="{'is-tab-active' : activeId === brand.makerId}" 
                            @click="selectTabItem(brand.makerId)"
                        >
                            {{ brand.socName }}
                        </li>
                    </ul>
                    <ul v-if="!!categoryList.length" class="swiper-wrapper">
                        <li
                            v-for="(category, index) in categoryList"
                            class="swiper-slide" 
                            :key="getLoopKey('tab-list', category.cate_code)" 
                            :class="{'is-tab-active' : activeId === category.cate_code}"
                            @click="selectTabItem(category.cate_code)">
                                {{ category.cate_name }}
                        </li>
                    </ul>
                    <div class="swiper-button-next"></div>
                    <div class="swiper-button-prev"></div>
                </div>
                <button 
                    type="button" 
                    class="monthly__sort" 
                    :class="{'is-sort-active': isVisibleSortingList}"
                    @click="changeSortingValue">
                        {{searchSort.name}}으로 보기
                </button>
                <ul v-if="isVisibleSortingList" class="monthly__sorting-list">
                    <li 
                        v-for="(sort, index) in sortList" 
                        :key="getLoopKey('sorting-list', sort.htmlFor)"
                        @click="changeSorting(sort)">
                            {{ sort.text }}으로 보기
                    </li>
                </ul>
                <ul class="product">
                    <li 
                        v-for="(item, k) in itemList"  
                        :key="getLoopKey('montyly-product-list-item', k)" 
                        class="product__list" 
                        @click="moveToProductPage(item.item_id)">
                        <!-- TODO : 추후 품절일 경우 soldout 키값 확인해서 변경 -->
                        <div class="thumbnail" :class="{'is-soldout': item.soldout === true}">
                            <img v-if="item.list_image" :src="decodeBase64(item.list_image)" :alt="item.item_name" />
                        </div>
                        <div class="product-info">
                            <div class="product-info__brand" @click="moveToBrandPage($event, item.brand_id)">
                                {{item.brand_name}}
                            </div>
                            <div class="product-info__name">{{item.item_name}}</div>
                            <div class="product-info__org-price">
                                {{formatPrice(item.org_price)}}
                            </div>
                            <div class="price-wrap">
                                <span class="product-info__price">{{formatPrice(item.item_price)}}</span>
                                <strong v-if="item.sale_percent > 0" class="product-info__percent">
                                    [{{item.sale_percent}}%]
                                </strong>
                            </div>
                            <!-- 아이템 뱃지 데이터 확인  --> 
                            <p class="product-info__bage">
                                <img v-if="item.sale_yn" src="http://fiximage.10x10.co.kr/web2013/shopping/tag_sale.gif" alt="SALE">
                                <img v-if="item.item_coupon_yn" src="http://fiximage.10x10.co.kr/web2013/shopping/tag_coupon.gif" alt="쿠폰">
                                <img v-if="item.free_baesong" src="http://fiximage.10x10.co.kr/web2013/shopping/tag_free_ship.gif" alt="무료배송">
                                <img v-if="item.limityn" src="http://fiximage.10x10.co.kr/web2013/shopping/tag_limited.gif" alt="한정">
                                <img v-if="item.ten_only" src="http://fiximage.10x10.co.kr/web2013/shopping/tag_only.gif" alt="ONLY">
                                <img v-if="item.newyn" src="http://fiximage.10x10.co.kr/web2013/shopping/tag_new.gif" alt="NEW">
                                <span v-if="item.pojangok" class="product-info__bage--gift">
                                    <img src="http://fiximage.10x10.co.kr/web2015/shopping/ico_pakage_act.png" alt="선물포장가능">
                                </span>
                            </p>
                            <ul v-if="false" class="product-info__action">
                                <li class="product-info__action--quick" @click="goZoom($event, item.item_id)">
                                    <img src="http://fiximage.10x10.co.kr/web2015/common/btn_quick.png" alt="QUICK" />
                                </li>
                                <li class="product-info__action--review" @click="itemReView($event, item.item_id)">
                                    <span>{{formatPrice(item.review_cnt)}}</span>
                                </li>
                                <li class="product-info__action--wish" @click="addWishItem($event, item.item_id)" >
                                    <span>{{formatPrice(item.favcount)}}</span>
                                </li>
                            </ul>
                        </div>
                    </li>
                </ul>
            </section>
        </main>
    `,
    data() {
        return {
            activeId: '',
            searchSort: {
                sort : 'best',
                name: '인기순'
            },
            sortList: [
                {
                    text: '신규순',
                    htmlFor: 'optA_1',
                    value: 'new',
                },
                {
                    text: '판매량순',
                    htmlFor: 'optA_2',
                    value: 'bs',
                },
                {
                    text: '인기순',
                    htmlFor: 'optA_3',
                    value: 'best',
                },
                {
                    text: '위시순',
                    htmlFor: 'optA_4',
                    value: 'ws',
                },
                {
                    text: '평가 좋은순',
                    htmlFor: 'optA_5',
                    value: 'br',
                },
                {
                    text: '낮은 가격순',
                    htmlFor: 'optA_6',
                    value: 'lp',
                },
                {
                    text: '높은 가격순',
                    htmlFor: 'optA_7',
                    value: 'hp',
                },
                {
                    text: '할인율순',
                    htmlFor: 'optA_8',
                    value: 'hs',
                },
            ],
            isVisibleSortingList: false,
            makerIds: '',
            categoryCode: '',
            currentPage: 1,
            currentSlideIndex: 0,
            brandListSwiper: null,
            categoryListSwiper: null,
            onFlag: false,
        }
    },
    created() {
        let params = {};
        window.location.search.replace(/[?&]+([^=&]+)=([^&]*)/gi, (str, key, value) => {
            params[key] = value;
        });
        const queryObject = {
            currentPage: this.currentPage,
            sortOption: this.searchSort.sort,
        };
      
        if (params.hasOwnProperty('maker_id')) {
            this.activeId = params.maker_id;
            this.$store[0].dispatch('GET_BRAND_LIST');
            queryObject.makerIds = params.maker_id;
            this.makerIds = params.maker_id;
        } else if (params.hasOwnProperty('code')) {
            this.activeId = params.code;
            this.$store[0].dispatch('GET_CATEGORY_LIST');
            queryObject.categoryCode = params.code;
            this.categoryCode = params.code;
        } else {
            if(!alert("잘못된 경로입니다")) document.location = '/monthlyten/2023/february/index.asp';
        }

        this.$store[0].dispatch('GET_ITEM_LIST', queryObject);
    },
    mounted() {
        document.addEventListener('scroll', () => {
            if (window.scrollY + window.innerHeight >= document.body.scrollHeight) {
                if (!this.isLoading) {
                    this.currentPage += 1;
                }
            }
        });
    },
    watch: {
        brandList(list) {
            if (list.length > 0) {
                this.initalizeSwiper();
            }
        },
        categoryList(list) {
            if (list.length > 0) {
                this.initalizeSwiper();
            }
        },
        isVisibleSortingList(value) {
            if (!value) {
                this.$store[0].dispatch('GET_ITEM_LIST', {
                    currentPage: 1,
                    sortOption: this.searchSort.sort,
                    makerIds: this.makerIds,
                    categoryCode: this.categoryCode,
                });
            }
        },
        activeId(target) {
            const queryObject = {
                currentPage: 1,
                sortOption: this.searchSort.sort,
            };

            if (!!this.makerIds.length) {
                queryObject.makerIds = target;
                this.$store[0].dispatch('GET_ITEM_LIST', queryObject);
            }

            if (!!this.categoryCode.length) {
                queryObject.categoryCode = target;
                this.$store[0].dispatch('GET_ITEM_LIST', queryObject);
            }
        },
        currentPage(target) {
            this.$store[0].dispatch('GET_ITEM_LIST', {
                currentPage: target,
                sortOption: this.searchSort.sort,
                makerIds: this.makerIds,
                categoryCode: this.categoryCode,
            });
        },
        currentSlideIndex(targetIndex) {
            if (targetIndex >= 0) {
                if (this.brandListSwiper) {
                    this.brandListSwiper.slideTo(targetIndex);
                }

                if (this.categoryListSwiper) {
                    this.categoryListSwiper.slideTo(targetIndex);
                }
            }
        },
    },
    computed: {
        isLoading() {
            return this.$store[0].getters.isLoading;
        },
        itemList() {
            return this.$store[0].getters.itemList;
        },
        brandList() {
            return this.$store[0].getters.brandList;
        },
        categoryList() {
            return this.$store[0].getters.categoryList;
        },
    },
    methods: {
        initalizeSwiper() {
            const _T = this;
            this.$nextTick(() => {
                const swiperOptions = {
                    slidesPerView: 'auto',
                    grabCursor: true,
                    navigation: {
                        nextEl: ".swiper-button-next",
                        prevEl: ".swiper-button-prev",
                    },
                    on: {
                        click: (data) => {
                            _T.currentSlideIndex = data.clickedIndex;
                        },
                    }
                };

                if (_T.brandList.length > 0) {
                    _T.brandListSwiper = new Swiper('.menu-swiper', swiperOptions);
                    for (let i = 0; i < _T.brandList.length; i++) {
                        if (_T.makerIds === _T.brandList[i].makerId) {
                            _T.currentSlideIndex = i;
                            break;
                        }
                    }
            
                    _T.brandListSwiper.slideTo(_T.currentSlideIndex, 0);
                }
          
                if (_T.categoryList.length > 0) {
                    _T.categoryListSwiper = new Swiper('.menu-swiper', swiperOptions);
                    for (let i = 0; i < _T.categoryList.length; i++) {
                        if (_T.categoryCode === _T.categoryList[i].cate_code) {
                            _T.currentSlideIndex = i;
                            break;
                        }
                    }
            
                    _T.categoryListSwiper.slideTo(_T.currentSlideIndex, 0);
                }
            });
        },
        selectTabItem(targetId) {
            this.activeId = targetId;
            document.body.scrollTop = 0; // For Safari
            document.documentElement.scrollTop = 0; // For Chrome, Firefox, IE and Opera
        },
        decodeBase64(str) {
            if (str === null) return null;
            return atob(str.replace(/_/g, '/').replace(/-/g, '+'));
        },
        formatPrice(price) {
            if (price) {
                return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
            }

            return '';
        },
        getLoopKey(prefix, index) {
            return `${prefix}-${index}`;
        },
        changeSortingValue() {
            this.isVisibleSortingList = !this.isVisibleSortingList;
        },
        changeSorting(sort) {
            this.searchSort.name = sort.text;
            this.searchSort.sort = sort.value;
            this.isVisibleSortingList = false;
        },
        moveToProductPage(itemid) {
            location.href = `/shopping/category_prd.asp?itemid=${itemid}`;
        },
        moveToBrandPage(event, brandId) {
            // 브랜드 이동
            parent.location.href='/street/street_brand_sub06.asp?makerid='+brandId;
            event.stopPropagation();
        },
        goZoom(event, itemid) {
            event.stopPropagation();
            ZoomItemInfo(itemid);
        },
        itemReView(event, itemid) {
            event.stopPropagation();
            // popEvaluate(itemid)
        },
        addWishItem(event, item) {
            event.stopPropagation();
            // fnWishAdd(targetId);
        },
    },
});