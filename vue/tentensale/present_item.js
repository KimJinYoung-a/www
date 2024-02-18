Vue.component('present-item', {
    template : `
    <section id="tab03" class="section03">
        <div class="in_wrap">
            <div class="inner">
                <h2><span>상황에 딱 맞는 아이템을 추천할게요​</span>어떤 선물이 좋을지​<br>고민 중이라면!</h2>
                <div class="prd_wrap">
                    <div class="prd_tit" @click="moreDetailPage(1,409102)">
                        <p class="icon">
                            <img src="//webimage.10x10.co.kr/fixevent/event/2022/ten_sale12/icon01.png" alt="">
                        </p>
                        <div class="copy">
                            <p class="main_copy">별다꾸러</p>
                            <p class="sub_copy">다꾸러에게 주고 싶은 선물</p>
                        </div>
                    </div>
                    <div class="prd-list">
                        <ul class="item_list">
                            <li v-for="(item, index) in firstItems">
                                <a href="javascript:void(0);" @click="prdDetailPage(1,item.itemid)" :class="'firstItems' + item.itemid">
                                    <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/nov/tenbyten_thumbnail.jpg" alt=""></div>
                                    <div class="desc">
                                        <p class="price"><s></s> <span class="sale"></span></p>
                                        <p class="name"></p>
                                        <p class="brand"></p>
                                    </div>
                                </a>
                            </li>
                        </ul>
                    </div>
                    <a href="javascript:void(0);" @click="moreDetailPage2(409102)" class="more">추천상품 더보기</a>
                </div>
                <div class="prd_wrap">
                    <div class="prd_tit" @click="moreDetailPage(2,409103)">
                        <p class="icon">
                            <img src="//webimage.10x10.co.kr/fixevent/event/2022/ten_sale12/icon02.png" alt="">
                        </p>
                        <div class="copy">
                            <p class="main_copy">감성브이로거</p>
                            <p class="sub_copy">첫 자취를 응원하는 선물</p>
                        </div>
                    </div>
                    <div class="prd-list">
                        <ul class="item_list">
                            <li v-for="(item, index) in secondItems">
                                <a href="javascript:void(0);" @click="prdDetailPage(2,item.itemid)" :class="'secondItems' + item.itemid">
                                    <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/nov/tenbyten_thumbnail.jpg" alt=""></div>
                                    <div class="desc">
                                        <p class="price"><s></s> <span class="sale"></span></p>
                                        <p class="name"></p>
                                        <p class="brand"></p>
                                    </div>
                                </a>
                            </li>
                        </ul>
                    </div>
                    <a href="javascript:void(0);" @click="moreDetailPage2(409103)" class="more">추천상품 더보기</a>
                </div>
                <div class="prd_wrap">
                    <div class="prd_tit" @click="moreDetailPage(3,409106)">
                        <p class="icon">
                            <img src="//webimage.10x10.co.kr/fixevent/event/2022/ten_sale12/icon03.png" alt="">
                        </p>
                        <div class="copy">
                            <p class="main_copy">귀여움수집가</p>
                            <p class="sub_copy">귀여움이 모두 담긴 선물</p>
                        </div>
                    </div>
                    <div class="prd-list">
                        <ul class="item_list">
                            <li v-for="(item, index) in fourthItems">
                                <a href="javascript:void(0);" @click="prdDetailPage(3,item.itemid)" :class="'fourthItems' + item.itemid">
                                    <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/nov/tenbyten_thumbnail.jpg" alt=""></div>
                                    <div class="desc">
                                        <p class="price"><s></s> <span class="sale"></span></p>
                                        <p class="name"></p>
                                        <p class="brand"></p>
                                    </div>
                                </a>
                            </li>
                        </ul>
                    </div>
                    <a href="javascript:void(0);" @click="moreDetailPage2(409106)" class="more">추천상품 더보기</a>
                </div>
                <div class="prd_wrap">
                    <div class="prd_tit" @click="moreDetailPage(4,409107)">
                        <p class="icon">
                            <img src="//webimage.10x10.co.kr/fixevent/event/2022/ten_sale12/icon04.png" alt="">
                        </p>
                        <div class="copy">
                            <p class="main_copy">엄빠연습생</p>
                            <p class="sub_copy">예비 엄빠를 위한 선물</p>
                        </div>
                    </div>
                    <div class="prd-list">
                        <ul class="item_list">
                            <li v-for="(item, index) in fifthItems">
                                <a href="javascript:void(0);" @click="prdDetailPage(4,item.itemid)" :class="'fifthItems' + item.itemid">
                                    <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/nov/tenbyten_thumbnail.jpg" alt=""></div>
                                    <div class="desc">
                                        <p class="price"><s></s> <span class="sale"></span></p>
                                        <p class="name"></p>
                                        <p class="brand"></p>
                                    </div>
                                </a>
                            </li>
                        </ul>
                    </div>
                    <a href="javascript:void(0);" @click="moreDetailPage2(409107)" class="more">추천상품 더보기</a>
                </div>
                <div class="prd_wrap">
                    <div class="prd_tit" @click="moreDetailPage(5,409104)">
                        <p class="icon">
                            <img src="//webimage.10x10.co.kr/fixevent/event/2022/ten_sale12/icon05.png" alt="">
                        </p>
                        <div class="copy">
                            <p class="main_copy">출근러</p>
                            <p class="sub_copy">지친 동료를 위한 선물</p>
                        </div>
                    </div>
                    <div class="prd-list">
                        <ul class="item_list">
                            <li v-for="(item, index) in thirdItems">
                                <a href="javascript:void(0);" @click="prdDetailPage(5,item.itemid)" :class="'thirdItems' + item.itemid">
                                    <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/nov/tenbyten_thumbnail.jpg" alt=""></div>
                                    <div class="desc">
                                        <p class="price"><s></s> <span class="sale"></span></p>
                                        <p class="name"></p>
                                        <p class="brand"></p>
                                    </div>
                                </a>
                            </li>
                        </ul>
                    </div>
                    <a href="javascript:void(0);" @click="moreDetailPage2(409104)" class="more">추천상품 더보기</a>
                </div>
                <div class="prd_wrap">
                    <div class="prd_tit" @click="moreDetailPage(6,409108)" >
                        <p class="icon">
                            <img src="//webimage.10x10.co.kr/fixevent/event/2022/ten_sale12/icon06.png" alt="">
                        </p>
                        <div class="copy">
                            <p class="main_copy">방구석바리스타</p>
                            <p class="sub_copy">홈카페 감성러를 위한 선물</p>
                        </div>
                    </div>
                    <div class="prd-list">
                        <ul class="item_list">
                            <li v-for="(item, index) in sixthItems">
                                <a href="javascript:void(0);" @click="prdDetailPage(6,item.itemid)" :class="'sixthItems' + item.itemid">
                                    <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/nov/tenbyten_thumbnail.jpg" alt=""></div>
                                    <div class="desc">
                                        <p class="price"><s></s> <span class="sale"></span></p>
                                        <p class="name"></p>
                                        <p class="brand"></p>
                                    </div>
                                </a>
                            </li>
                        </ul>
                    </div>
                    <a href="javascript:void(0);" @click="moreDetailPage2(409108)" class="more">추천상품 더보기</a>
                </div>
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
        secondItems() { 
            const items = this.$store.getters.secondItems;
            this.setItemInit('secondItems', items);
            return this.$store.getters.secondItems 
        },
        thirdItems() { 
            const items = this.$store.getters.thirdItems;
            this.setItemInit('thirdItems', items);
            return this.$store.getters.thirdItems 
        },
        fourthItems() { 
            const items = this.$store.getters.fourthItems;
            this.setItemInit('fourthItems', items);
            return this.$store.getters.fourthItems 
        },
        fifthItems() { 
            const items = this.$store.getters.fifthItems;
            this.setItemInit('fifthItems', items);
            return this.$store.getters.fifthItems 
        },
        sixthItems() { 
            const items = this.$store.getters.sixthItems;
            this.setItemInit('sixthItems', items);
            return this.$store.getters.sixthItems 
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
        prdDetailPage(index,itemid){
            fnAmplitudeEventMultiPropertiesAction('click_tentensale_present_prodcut','thema|item_id',index+'|'+itemid);
            location.href = "/shopping/category_prd.asp?itemid=" + itemid;
        },
        moreDetailPage(index,attribCd){
            fnAmplitudeEventAction('click_tentensale_present_prodcut', 'num', index);
            location.href = "/event/heart_gift/detail.asp?attribCd=" + attribCd + "&catecode=&sort=best";
        },
        moreDetailPage2(attribCd){
            fnAmplitudeEventAction('click_tentensale_present_button', '', '');
            location.href = "/event/heart_gift/detail.asp?attribCd=" + attribCd + "&catecode=&sort=best";
        },
        moreItem(e, index) {
            const _target = e.target;
            $(_target).parent().siblings('.prd_wrap').find('ul').addClass('more');
            $(_target).parent('.ten_mask').addClass('more');
            $(_target).parent().siblings('.prd_wrap').find('li:hidden').slice(0, 8).show(); 
            if ($(_target).parent().siblings('.prd_wrap').find('li:hidden').length == 0) { 
                $(_target).parent('.ten_mask').hide();
            } 
            fnAmplitudeEventAction('click_monthlyten_item_seemore', 'groupnumber', index);
        },
    }
});