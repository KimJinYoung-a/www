Vue.component('saleItem', {
    mixins : [item_mixin, modal_mixin, common_mixin]
    , template : `
    <section id="tab06" class="section06">
    <div class="in_wrap">
        <div class="inner">
            <h2><span>취향에 맞는 추천 선물 고르기​</span>선물하기 좋은​<br>아이템 모아보기<i>~79%</i></h2>
            <div class="prd_wrap">
                <div class="prd_tit" @click="exhibitionDetailPage('408','101','디자인문구')">
                    <div class="copy">
                        <p class="main_copy">{{setCategoryName(101)}}</p>
                    </div>
                </div>
                <div class="prd-list">
                    <ul id="lyrItemlist" class="item_list">
                        <li v-for="(item, index) in Items1">
                            <a href="javascript:void(0);" @click="prdDetailPage(item.itemid)" :class="'Items1' + item.itemid">
                                <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/nov/tenbyten_thumbnail.jpg" alt=""></div>
                                <div class="desc">
                                    <div class="price"><s></s><span class="sale"></span></div>
                                    <p class="name"></p>
                                    <p class="brand"></p>
                                </div>
                            </a>
                        </li>

                    </ul>
                </div>
                <a href="javascript:void(0);" @click="exhibitionDetailPage2('408','101')" class="more">추천상품 더보기</a><!-- 디자인문구 -->
            </div>

            <div class="prd_wrap">
                <div class="prd_tit" @click="exhibitionDetailPage('408','102','디지털/핸드폰')">
                    <div class="copy">
                        <p class="main_copy">{{setCategoryName(102)}}</p>
                    </div>
                </div>
                <div class="prd-list">
                    <ul id="lyrItemlist" class="item_list">
                        <li v-for="(item, index) in Items2">
                            <a href="javascript:void(0);" @click="prdDetailPage(item.itemid)" :class="'Items2' + item.itemid">
                                <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/nov/tenbyten_thumbnail.jpg" alt=""></div>
                                <div class="desc">
                                    <div class="price"><s></s><span class="sale"></span></div>
                                    <p class="name"></p>
                                    <p class="brand"></p>
                                </div>
                            </a>
                        </li>

                    </ul>
                </div>
                <a href="javascript:void(0);" @click="exhibitionDetailPage2('408','102')" class="more">추천상품 더보기</a><!-- 디지털/핸드폰 -->
            </div>

            <div class="prd_wrap">
                <div class="prd_tit" @click="exhibitionDetailPage('408','124','디자인가전')">
                    <div class="copy">
                        <p class="main_copy">{{setCategoryName(124)}}</p>
                    </div>
                </div>
                <div class="prd-list">
                    <ul id="lyrItemlist" class="item_list">
                        <li v-for="(item, index) in Items3">
                            <a href="javascript:void(0);" @click="prdDetailPage(item.itemid)" :class="'Items3' + item.itemid">
                                <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/nov/tenbyten_thumbnail.jpg" alt=""></div>
                                <div class="desc">
                                    <div class="price"><s></s><span class="sale"></span></div>
                                    <p class="name"></p>
                                    <p class="brand"></p>
                                </div>
                            </a>
                        </li>

                    </ul>
                </div>
                <a href="javascript:void(0);" @click="exhibitionDetailPage2('408','124')" class="more">추천상품 더보기</a><!-- 디자인가전 -->
            </div>

            <div class="prd_wrap">
                <div class="prd_tit" @click="exhibitionDetailPage('408','121','가구/수납')">
                    <div class="copy">
                        <p class="main_copy">{{setCategoryName(121)}}</p>
                    </div>
                </div>
                <div class="prd-list">
                    <ul id="lyrItemlist" class="item_list">
                        <li v-for="(item, index) in Items4">
                            <a href="javascript:void(0);" @click="prdDetailPage(item.itemid)" :class="'Items4' + item.itemid">
                                <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/nov/tenbyten_thumbnail.jpg" alt=""></div>
                                <div class="desc">
                                    <div class="price"><s></s><span class="sale"></span></div>
                                    <p class="name"></p>
                                    <p class="brand"></p>
                                </div>
                            </a>
                        </li>

                    </ul>
                </div>
                <a href="javascript:void(0);" @click="exhibitionDetailPage2('408','121')" class="more">추천상품 더보기</a><!-- 가구/수납 -->
            </div>

            <div class="prd_wrap">
                <div class="prd_tit" @click="exhibitionDetailPage('408','120','패브릭/생활')">
                    <div class="copy">
                        <p class="main_copy">{{setCategoryName(120)}}</p>
                    </div>
                </div>
                <div class="prd-list">
                    <ul id="lyrItemlist" class="item_list">
                        <li v-for="(item, index) in Items5">
                            <a href="javascript:void(0);" @click="prdDetailPage(item.itemid)" :class="'Items5' + item.itemid">
                                <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/nov/tenbyten_thumbnail.jpg" alt=""></div>
                                <div class="desc">
                                    <div class="price"><s></s><span class="sale"></span></div>
                                    <p class="name"></p>
                                    <p class="brand"></p>
                                </div>
                            </a>
                        </li>

                    </ul>
                </div>
                <a href="javascript:void(0);" @click="exhibitionDetailPage2('408','120')" class="more">추천상품 더보기</a><!-- 패브릭/생활 -->
            </div>

            <div class="prd_wrap">
                <div class="prd_tit" @click="exhibitionDetailPage('408','122','데코/조명')">
                    <div class="copy">
                        <p class="main_copy">{{setCategoryName(122)}}</p>
                    </div>
                </div>
                <div class="prd-list">
                    <ul id="lyrItemlist" class="item_list">
                        <li v-for="(item, index) in Items6">
                            <a href="javascript:void(0);" @click="prdDetailPage(item.itemid)" :class="'Items6' + item.itemid">
                                <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/nov/tenbyten_thumbnail.jpg" alt=""></div>
                                <div class="desc">
                                    <div class="price"><s></s><span class="sale"></span></div>
                                    <p class="name"></p>
                                    <p class="brand"></p>
                                </div>
                            </a>
                        </li>

                    </ul>
                </div>
                <a href="javascript:void(0);" @click="exhibitionDetailPage2('408','122')" class="more">추천상품 더보기</a><!-- 데코/조명 -->
            </div>

            <div class="prd_wrap">
                <div class="prd_tit" @click="exhibitionDetailPage('408','112','키친')">
                    <div class="copy">
                        <p class="main_copy">{{setCategoryName(112)}}</p>
                    </div>
                </div>
                <div class="prd-list">
                    <ul id="lyrItemlist" class="item_list">
                        <li v-for="(item, index) in Items7">
                            <a href="javascript:void(0);" @click="prdDetailPage(item.itemid)" :class="'Items7' + item.itemid">
                                <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/nov/tenbyten_thumbnail.jpg" alt=""></div>
                                <div class="desc">
                                    <div class="price"><s></s><span class="sale"></span></div>
                                    <p class="name"></p>
                                    <p class="brand"></p>
                                </div>
                            </a>
                        </li>

                    </ul>
                </div>
                <a href="javascript:void(0);" @click="exhibitionDetailPage2('408','112')" class="more">추천상품 더보기</a><!-- 키친 -->
            </div>

            <div class="prd_wrap">
                <div class="prd_tit" @click="exhibitionDetailPage('408','119','푸드')">
                    <div class="copy">
                        <p class="main_copy">{{setCategoryName(119)}}</p>
                    </div>
                </div>
                <div class="prd-list">
                    <ul id="lyrItemlist" class="item_list">
                        <li v-for="(item, index) in Items8">
                            <a href="javascript:void(0);" @click="prdDetailPage(item.itemid)" :class="'Items8' + item.itemid">
                                <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/nov/tenbyten_thumbnail.jpg" alt=""></div>
                                <div class="desc">
                                    <div class="price"><s></s><span class="sale"></span></div>
                                    <p class="name"></p>
                                    <p class="brand"></p>
                                </div>
                            </a>
                        </li>

                    </ul>
                </div>
                <a href="javascript:void(0);" @click="exhibitionDetailPage2('408','119')" class="more">추천상품 더보기</a><!-- 푸드 -->
            </div>

            <div class="prd_wrap">
                <div class="prd_tit" @click="exhibitionDetailPage('408','117','패션의류')">
                    <div class="copy">
                        <p class="main_copy">{{setCategoryName(117)}}</p>
                    </div>
                </div>
                <div class="prd-list">
                    <ul id="lyrItemlist" class="item_list">
                        <li v-for="(item, index) in Items9">
                            <a href="javascript:void(0);" @click="prdDetailPage(item.itemid)" :class="'Items9' + item.itemid">
                                <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/nov/tenbyten_thumbnail.jpg" alt=""></div>
                                <div class="desc">
                                    <div class="price"><s></s><span class="sale"></span></div>
                                    <p class="name"></p>
                                    <p class="brand"></p>
                                </div>
                            </a>
                        </li>

                    </ul>
                </div>
                <a href="javascript:void(0);" @click="exhibitionDetailPage2('408','117')" class="more">추천상품 더보기</a><!-- 패션의류 -->
            </div>

            <div class="prd_wrap">
                <div class="prd_tit" @click="exhibitionDetailPage('408','116','패션잡화')">
                    <div class="copy">
                        <p class="main_copy">{{setCategoryName(116)}}</p>
                    </div>
                </div>
                <div class="prd-list">
                    <ul id="lyrItemlist" class="item_list">
                        <li v-for="(item, index) in Items10">
                            <a href="javascript:void(0);" @click="prdDetailPage(item.itemid)" :class="'Items10' + item.itemid">
                                <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/nov/tenbyten_thumbnail.jpg" alt=""></div>
                                <div class="desc">
                                    <div class="price"><s></s><span class="sale"></span></div>
                                    <p class="name"></p>
                                    <p class="brand"></p>
                                </div>
                            </a>
                        </li>

                    </ul>
                </div>
                <a href="javascript:void(0);" @click="exhibitionDetailPage2('408','116')" class="more">추천상품 더보기</a><!-- 패션잡화 -->
            </div>

            <div class="prd_wrap">
                <div class="prd_tit" @click="exhibitionDetailPage('408','118','뷰티')">
                    <div class="copy">
                        <p class="main_copy">{{setCategoryName(118)}}</p>
                    </div>
                </div>
                <div class="prd-list">
                    <ul id="lyrItemlist" class="item_list">
                        <li v-for="(item, index) in Items11">
                            <a href="javascript:void(0);" @click="prdDetailPage(item.itemid)" :class="'Items11' + item.itemid">
                                <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/nov/tenbyten_thumbnail.jpg" alt=""></div>
                                <div class="desc">
                                    <div class="price"><s></s><span class="sale"></span></div>
                                    <p class="name"></p>
                                    <p class="brand"></p>
                                </div>
                            </a>
                        </li>

                    </ul>
                </div>
                <a href="javascript:void(0);" @click="exhibitionDetailPage2('408','118')" class="more">추천상품 더보기</a><!-- 뷰티 -->
            </div>

            <div class="prd_wrap">
                <div class="prd_tit" @click="exhibitionDetailPage('408','125','주얼리/시계')">
                    <div class="copy">
                        <p class="main_copy">{{setCategoryName(125)}}</p>
                    </div>
                </div>
                <div class="prd-list">
                    <ul id="lyrItemlist" class="item_list">
                        <li v-for="(item, index) in Items12">
                            <a href="javascript:void(0);" @click="prdDetailPage(item.itemid)" :class="'Items12' + item.itemid">
                                <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/nov/tenbyten_thumbnail.jpg" alt=""></div>
                                <div class="desc">
                                    <div class="price"><s></s><span class="sale"></span></div>
                                    <p class="name"></p>
                                    <p class="brand"></p>
                                </div>
                            </a>
                        </li>

                    </ul>
                </div>
                <a href="javascript:void(0);" @click="exhibitionDetailPage2('408','125')" class="more">추천상품 더보기</a><!-- 주얼리/시계 -->
            </div>

            <div class="prd_wrap">
                <div class="prd_tit" @click="exhibitionDetailPage('408','110','cat&dog')">
                    <div class="copy">
                        <p class="main_copy">{{setCategoryName(110)}}</p>
                    </div>
                </div>
                <div class="prd-list">
                    <ul id="lyrItemlist" class="item_list">
                        <li v-for="(item, index) in Items13">
                            <a href="javascript:void(0);" @click="prdDetailPage(item.itemid)" :class="'Items13' + item.itemid">
                                <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/nov/tenbyten_thumbnail.jpg" alt=""></div>
                                <div class="desc">
                                    <div class="price"><s></s><span class="sale"></span></div>
                                    <p class="name"></p>
                                    <p class="brand"></p>
                                </div>
                            </a>
                        </li>

                    </ul>
                </div>
                <a href="javascript:void(0);" @click="exhibitionDetailPage2('408','110')" class="more">추천상품 더보기</a><!-- cat&dog -->
            </div>

            <div class="prd_wrap">
                <div class="prd_tit" @click="exhibitionDetailPage('408','104','토이/취미')">
                    <div class="copy">
                        <p class="main_copy">{{setCategoryName(104)}}</p>
                    </div>
                </div>
                <div class="prd-list">
                    <ul id="lyrItemlist" class="item_list">
                        <li v-for="(item, index) in Items14">
                            <a href="javascript:void(0);" @click="prdDetailPage(item.itemid)" :class="'Items14' + item.itemid">
                                <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/nov/tenbyten_thumbnail.jpg" alt=""></div>
                                <div class="desc">
                                    <div class="price"><s></s><span class="sale"></span></div>
                                    <p class="name"></p>
                                    <p class="brand"></p>
                                </div>
                            </a>
                        </li>

                    </ul>
                </div>
                <a href="javascript:void(0);" @click="exhibitionDetailPage2('408','104')" class="more">추천상품 더보기</a><!-- 토이/취미 -->
            </div>
        </div>
    </div>
    
</section>
    `
    , created() {
        const _this = this;
        this.$store.dispatch('GET_CATEGORIES_ITEMS');
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
        Items1() { 
            const items = this.$store.getters.Items1;
            this.setItemInit('Items1', items);
            return this.$store.getters.Items1;
        },
        Items2() { 
            const items = this.$store.getters.Items2;
            this.setItemInit('Items2', items);
            return this.$store.getters.Items2;
        },
        Items3() { 
            const items = this.$store.getters.Items3;
            this.setItemInit('Items3', items);
            return this.$store.getters.Items3;
        },
        Items4() { 
            const items = this.$store.getters.Items4;
            this.setItemInit('Items4', items);
            return this.$store.getters.Items4;
        },
        Items5() { 
            const items = this.$store.getters.Items5;
            this.setItemInit('Items5', items);
            return this.$store.getters.Items5;
        },
        Items6() { 
            const items = this.$store.getters.Items6;
            this.setItemInit('Items6', items);
            return this.$store.getters.Items6;
        },
        Items7() { 
            const items = this.$store.getters.Items7;
            this.setItemInit('Items7', items);
            return this.$store.getters.Items7;
        },
        Items8() { 
            const items = this.$store.getters.Items8;
            this.setItemInit('Items8', items);
            return this.$store.getters.Items8;
        },
        Items9() { 
            const items = this.$store.getters.Items9;
            this.setItemInit('Items9', items);
            return this.$store.getters.Items9;
        },
        Items10() { 
            const items = this.$store.getters.Items10;
            this.setItemInit('Items10', items);
            return this.$store.getters.Items10;
        },
        Items11() { 
            const items = this.$store.getters.Items11;
            this.setItemInit('Items11', items);
            return this.$store.getters.Items11;
        },
        Items12() { 
            const items = this.$store.getters.Items12;
            this.setItemInit('Items12', items);
            return this.$store.getters.Items12;
        },
        Items13() { 
            const items = this.$store.getters.Items13;
            this.setItemInit('Items13', items);
            return this.$store.getters.Items13;
        },
        Items14() { 
            const items = this.$store.getters.Items14;
            this.setItemInit('Items14', items);
            return this.$store.getters.Items14;
        },
        Items15() { 
            const items = this.$store.getters.Items15;
            this.setItemInit('Items15', items);
            return this.$store.getters.Items15;
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
        setCategoryName(code) {
            let name = '';
            switch(code) {
                case 101: name = '디자인문구'; break;
                case 102: name = '디지털/핸드폰'; break;
                case 124: name = '디자인가전'; break;
                case 121: name = '가구/수납'; break;
                case 120: name = '패브릭/생활'; break;
                case 122: name = '데코/조명'; break;
                case 112: name = '키친'; break;
                case 119: name = '푸드'; break;
                case 117: name = '패션의류'; break;
                case 116: name = '패션잡화'; break;
                case 118: name = '뷰티'; break;
                case 125: name = '주얼리/시계'; break;
                case 110: name = 'cat&dog'; break;
                case 104: name = '토이/취미'; break;
                case 103: name = '캠핑'; break;
            }
            return name;
        },
        setItemInit(target, e) {
            const _this = this;
            let items = e.map(i => i.itemid);
            _this.setItemInfo(target, items, ["image", "name", "price", "sale", "brand"]);
        },
        /**
         * 상품상세 페이지 이동
         * @param itemid
         */
         prdDetailPage(itemid){
            fnAmplitudeEventAction('click_tentensale_sale_product', 'item_id', itemid);
            location.href = "/shopping/category_prd.asp?itemid=" + itemid;
        },
        exhibitionDetailPage(masterCode,catecode,categoryname){
            fnAmplitudeEventAction('click_tentensale_sale_category', 'category_name', categoryname);
            location.href = '/tentensale/exhibitionDetailView.asp?masterCode=' + masterCode + '&catecode=' + catecode;
        },
        exhibitionDetailPage2(masterCode,catecode){
            fnAmplitudeEventAction('click_tentensale_sale_button', '', '');
            location.href = '/tentensale/exhibitionDetailView.asp?masterCode=' + masterCode + '&catecode=' + catecode;
        },        
    }
});