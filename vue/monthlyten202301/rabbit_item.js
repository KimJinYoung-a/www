Vue.component('rabbit-item', {
    template : `
        <section id="tab01" class="tab01">
            <div class="sec_brand">
                <h2 class="sec_title"><p>월간 브랜드</p></h2>
                <div class="slide_brand">
                    <div class="swiper-container">
                        <div class="swiper-wrapper">
                            <div class="swiper-slide">
                                <a href="/street/street_brand_sub06.asp?makerid=hightide" @click="brandDetailPage('hightide')"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthten/2301/m/brand1.png" alt=""></a>
                            </div>
                            <div class="swiper-slide">
                                <a href="/street/street_brand_sub06.asp?makerid=luxiai" @click="brandDetailPage('luxiai')"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthten/2301/m/brand2.png" alt=""></a>
                            </div>
                            <div class="swiper-slide">
                                <a href="/street/street_brand_sub06.asp?makerid=kakaofriends1010" @click="brandDetailPage('kakaofriends1010')"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthten/2301/m/brand3.png" alt=""></a>
                            </div>
                            <div class="swiper-slide">
                                <a href="/street/street_brand_sub06.asp?makerid=disney10x10" @click="brandDetailPage('disney10x10')"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthten/2301/m/brand4.png" alt=""></a>
                            </div>
                            <div class="swiper-slide">
                                <a href="/street/street_brand_sub06.asp?makerid=iconic" @click="brandDetailPage('iconic')"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthten/2301/m/brand5.png" alt=""></a>
                            </div>
                            <div class="swiper-slide">
                                <a href="/street/street_brand_sub06.asp?makerid=livework" @click="brandDetailPage('livework')"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthten/2301/m/brand6.png" alt=""></a>
                            </div>
                            <div class="swiper-slide">
                                <a href="/street/street_brand_sub06.asp?makerid=10PILOT" @click="brandDetailPage('10PILOT')"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthten/2301/m/brand7.png" alt=""></a>
                            </div>
                            <div class="swiper-slide">
                                <a href="/street/street_brand_sub06.asp?makerid=sanrio10x10" @click="brandDetailPage('sanrio10x10')"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthten/2301/m/brand8.png" alt=""></a>
                            </div>
                            <div class="swiper-slide">
                                <a href="/street/street_brand_sub06.asp?makerid=misstop88" @click="brandDetailPage('misstop88')"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthten/2301/m/brand9.png" alt=""></a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="slide_brand02">
                    <div class="swiper-container" dir="rtl">
                        <div class="swiper-wrapper">
                            <div class="swiper-slide">
                                <a href="/street/street_brand_sub06.asp?makerid=playmobil1010" @click="brandDetailPage('playmobil1010')"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthten/2301/m/brand10.png" alt=""></a>
                            </div>
                            <div class="swiper-slide">
                                <a href="/street/street_brand_sub06.asp?makerid=nintendo10" @click="brandDetailPage('nintendo10')"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthten/2301/m/brand11.png" alt=""></a>
                            </div>
                            <div class="swiper-slide">
                                <a href="/street/street_brand_sub06.asp?makerid=judigital" @click="brandDetailPage('judigital')"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthten/2301/m/brand12.png" alt=""></a>
                            </div>
                            <div class="swiper-slide">
                                <a href="/street/street_brand_sub06.asp?makerid=peanuts10x10" @click="brandDetailPage('peanuts10x10')"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthten/2301/m/brand13.png" alt=""></a>
                            </div>
                            <div class="swiper-slide">
                                <a href="/street/street_brand_sub06.asp?makerid=jsglowglow" @click="brandDetailPage('jsglowglow')"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthten/2301/m/brand14.png" alt=""></a>
                            </div>
                            <div class="swiper-slide">
                                <a href="/street/street_brand_sub06.asp?makerid=MPNAVI" @click="brandDetailPage('MPNAVI')"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthten/2301/m/brand15.png" alt=""></a>
                            </div>
                            <div class="swiper-slide">
                                <a href="/street/street_brand_sub06.asp?makerid=modernhouse" @click="brandDetailPage('modernhouse')"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthten/2301/m/brand16.png" alt=""></a>
                            </div>
                            <div class="swiper-slide">
                                <a href="/street/street_brand_sub06.asp?makerid=mashimaro1" @click="brandDetailPage('mashimaro1')"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthten/2301/m/brand17.png" alt=""></a>
                            </div>
                            <div class="swiper-slide">
                                <a href="/street/street_brand_sub06.asp?makerid=jellyland" @click="brandDetailPage('jellyland')"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthten/2301/m/brand18.png" alt=""></a>
                            </div>
                            <div class="swiper-slide">
                                <a href="/street/street_brand_sub06.asp?makerid=bunni10x10" @click="brandDetailPage('bunni10x10')"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthten/2301/m/brand19.png" alt=""></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="sec_curation">
                <h2 class="sec_title"><p><span>당신에게 행운을 가져다 줄​</span>귀여운 토끼들​</p></h2>
                <div class="bnr_rabbit">
                    <a href="/event/eventmain.asp?eventid=121632" @click="moreDetailPage('top');"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthten/2301/bnr_rabbit.png" alt=""></a>
                </div>
                <div class="prd_list t01">
                    <li class="prd_item" v-for="(item, index) in firstItems">
                        <div :class="'firstItems' + item.itemid">
                            <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthten/2301/m/tenbyten_thumbnail.jpg" alt=""></div>
                            <div class="desc">
                                <div class="price"><s></s> <span class="sale"></span></div>
                                <div class="name"></div>
                                <div class="brand"></div>
                            </div>
                        </div>
                        <a href="javascript:void(0);" @click="prdDetailPage(item.itemid)" class="prd_link"><span class="blind">상품 바로가기</span></a> 
                    </li>
                    <a href="/event/eventmain.asp?eventid=121632" @click="moreDetailPage('bottom');" class="btn_more">추천상품 더보기</a>
                </div>
            </div>
        </section>
    `
    , created() {
        const _this = this;
        this.$store.dispatch('GET_PRESENT_CATEGORIES_ITEMS');
    }
    , updated() {
        const _this = this;
    }
    , data() {
        return {
            categoryItems: []
        }
    }
    , computed : {
        firstItems() { 
            const items = this.$store.getters.firstItems;
            this.setItemInit('firstItems', items);
            return this.$store.getters.firstItems;
        },
    },
    methods : {
        /**
         * 상품 정보 연동
         * @param target 클래스명
         * @param items 상품아이디
         * @param fields 상품 정보 필드명
         */
        setItemInfo(target, items, fields){
            fnApplyItemInfoEach({
                items: items,
                target: target,
                fields:fields,
                unit:"none",
                saleBracket:false
            });
        },
        setItemInit(target, e) {
            const _this = this;
            let items = e.map(i => i.itemid);
            _this.setItemInfo(target, items, ["image", "name", "price", "sale","brand"]);
        },
        /**
         * 상품상세 페이지 이동
         * @param itemid
         */
        prdDetailPage(itemid){
            fnAmplitudeEventAction('click_monthlyten_maincuration','item_id',itemid);
            location.href = "/shopping/category_prd.asp?itemid=" + itemid;
        },
        moreDetailPage(location){
            fnAmplitudeEventAction('click_monthlyten_maincuration', 'button', location);
        },
        brandDetailPage(brandid){
            fnAmplitudeEventAction('click_monthlyten_brand', 'brandname', brandid);
        },
    }
});