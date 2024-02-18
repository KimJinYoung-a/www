Vue.component('saleItem', {
    mixins : [item_mixin, modal_mixin, common_mixin]
    , template : `
        <section id="tab03" class="tab03">
            <div class="sec_today">
                <h2 class="sec_title"><p>오늘의 큐레이션<span>MD가 추천하는 오늘의 할인 아이템은?</span></p></h2>
                <div class="prd_list t02">
                    <li class="prd_item" v-for="(item, index) in mdchoiceItems">
                        <div :class="'mdchoiceItems' + item.eventid">
                            <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthten/2301/m/tenbyten_thumbnail.jpg" alt=""></div>
                            <div class="desc">
                                <p class="price"><s></s> <span class="sale"></span></p>
                                <p class="name"></p>
                                <div class="brand"></div>
                            </div>
                        </div> 
                        <a href="javascript:void(0);" @click="prdDetailPage2(index+1,item.eventid)" class="prd_link"><span class="blind">상품 바로가기</span></a> 
                    </li>
                </div>
            </div>
            <div class="sec_sale">
                <h2 class="sec_title"><p>세일 아이템 모아보기</p></h2>
                <div class="prd_list t01">
                    <div class="category"><a href="javascript:void(0);" @click="exhibitionDetailPage('410','101','디자인문구')">{{setCategoryName(101)}}<span class=""><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthten/2301/arrow_right.png" alt=""></span></a></div>
                    <li class="prd_item" v-for="(item, index) in Items1">
                        <div :class="'Items1' + item.itemid">
                            <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthten/2301/m/tenbyten_thumbnail.jpg" alt=""></div>
                            <div class="desc">
                                <div class="price"><s></s> <span class="sale"></span></div>
                                <div class="name"></div>
                                <div class="brand"></div>
                            </div>
                        </div> 
                        <a href="javascript:void(0);" @click="prdDetailPage(item.itemid)" class="prd_link"><span class="blind">상품 바로가기</span></a> 
                    </li>
                    <a href="javascript:void(0);" @click="exhibitionDetailPage2('410','101')" class="btn_more">추천상품 더보기</a>
                </div>
                <div class="prd_list t01">
                    <div class="category"><a href="javascript:void(0);" @click="exhibitionDetailPage('410','102','디지털/핸드폰')">{{setCategoryName(102)}}<span class=""><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthten/2301/arrow_right.png" alt=""></span></a></div>
                    <li class="prd_item" v-for="(item, index) in Items2">
                        <div :class="'Items2' + item.itemid">
                            <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthten/2301/m/tenbyten_thumbnail.jpg" alt=""></div>
                            <div class="desc">
                                <div class="price"><s></s> <span class="sale"></span></div>
                                <div class="name"></div>
                                <div class="brand"></div>
                            </div>
                        </div> 
                        <a href="javascript:void(0);" @click="prdDetailPage(item.itemid)" class="prd_link"><span class="blind">상품 바로가기</span></a> 
                    </li>
                    <a href="javascript:void(0);" @click="exhibitionDetailPage2('410','102')" class="btn_more">추천상품 더보기</a>
                </div>
                <div class="prd_list t01">
                    <div class="category"><a href="javascript:void(0);" @click="exhibitionDetailPage('410','104','토이/취미')">{{setCategoryName(104)}}<span class=""><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthten/2301/arrow_right.png" alt=""></span></a></div>
                    <li class="prd_item" v-for="(item, index) in Items3">
                        <div :class="'Items3' + item.itemid">
                            <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthten/2301/m/tenbyten_thumbnail.jpg" alt=""></div>
                            <div class="desc">
                                <div class="price"><s></s> <span class="sale"></span></div>
                                <div class="name"></div>
                                <div class="brand"></div>
                            </div>
                        </div> 
                        <a href="javascript:void(0);" @click="prdDetailPage(item.itemid)" class="prd_link"><span class="blind">상품 바로가기</span></a> 
                    </li>
                    <a href="javascript:void(0);" @click="exhibitionDetailPage2('410','104')" class="btn_more">추천상품 더보기</a>
                </div>
                <div class="prd_list t01">
                    <div class="category"><a href="javascript:void(0);" @click="exhibitionDetailPage('410','112','키친')">{{setCategoryName(112)}}<span class=""><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthten/2301/arrow_right.png" alt=""></span></a></div>
                    <li class="prd_item" v-for="(item, index) in Items4">
                        <div :class="'Items4' + item.itemid">
                            <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthten/2301/m/tenbyten_thumbnail.jpg" alt=""></div>
                            <div class="desc">
                                <div class="price"><s></s> <span class="sale"></span></div>
                                <div class="name"></div>
                                <div class="brand"></div>
                            </div>
                        </div> 
                        <a href="javascript:void(0);" @click="prdDetailPage(item.itemid)" class="prd_link"><span class="blind">상품 바로가기</span></a> 
                    </li>
                    <a href="javascript:void(0);" @click="exhibitionDetailPage2('410','112')" class="btn_more">추천상품 더보기</a>
                </div>
                <div class="prd_list t01">
                    <div class="category"><a href="javascript:void(0);" @click="exhibitionDetailPage('410','116','패션잡화')">{{setCategoryName(116)}}<span class=""><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthten/2301/arrow_right.png" alt=""></span></a></div>
                    <li class="prd_item" v-for="(item, index) in Items5">
                        <div :class="'Items5' + item.itemid">
                            <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthten/2301/m/tenbyten_thumbnail.jpg" alt=""></div>
                            <div class="desc">
                                <div class="price"><s></s> <span class="sale"></span></div>
                                <div class="name"></div>
                                <div class="brand"></div>
                            </div>
                        </div> 
                        <a href="javascript:void(0);" @click="prdDetailPage(item.itemid)" class="prd_link"><span class="blind">상품 바로가기</span></a> 
                    </li>
                    <a href="javascript:void(0);" @click="exhibitionDetailPage2('410','116')" class="btn_more">추천상품 더보기</a>
                </div>
                <div class="prd_list t01">
                    <div class="category"><a href="javascript:void(0);" @click="exhibitionDetailPage('410','117','패션의류')">{{setCategoryName(117)}}<span class=""><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthten/2301/arrow_right.png" alt=""></span></a></div>
                    <li class="prd_item" v-for="(item, index) in Items6">
                        <div :class="'Items6' + item.itemid">
                            <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthten/2301/m/tenbyten_thumbnail.jpg" alt=""></div>
                            <div class="desc">
                                <div class="price"><s></s> <span class="sale"></span></div>
                                <div class="name"></div>
                                <div class="brand"></div>
                            </div>
                        </div> 
                        <a href="javascript:void(0);" @click="prdDetailPage(item.itemid)" class="prd_link"><span class="blind">상품 바로가기</span></a> 
                    </li>
                    <a href="javascript:void(0);" @click="exhibitionDetailPage2('410','117')" class="btn_more">추천상품 더보기</a>
                </div>
                <div class="prd_list t01">
                    <div class="category"><a href="javascript:void(0);" @click="exhibitionDetailPage('410','120','패브릭/생활')">{{setCategoryName(120)}}<span class=""><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthten/2301/arrow_right.png" alt=""></span></a></div>
                    <li class="prd_item" v-for="(item, index) in Items7">
                        <div :class="'Items7' + item.itemid">
                            <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthten/2301/m/tenbyten_thumbnail.jpg" alt=""></div>
                            <div class="desc">
                                <div class="price"><s></s> <span class="sale"></span></div>
                                <div class="name"></div>
                                <div class="brand"></div>
                            </div>
                        </div> 
                        <a href="javascript:void(0);" @click="prdDetailPage(item.itemid)" class="prd_link"><span class="blind">상품 바로가기</span></a> 
                    </li>
                    <a href="javascript:void(0);" @click="exhibitionDetailPage2('410','120')" class="btn_more">추천상품 더보기</a>
                </div>
                <div class="prd_list t01">
                    <div class="category"><a href="javascript:void(0);" @click="exhibitionDetailPage('410','121','가구/수납')">{{setCategoryName(121)}}<span class=""><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthten/2301/arrow_right.png" alt=""></span></a></div>
                    <li class="prd_item" v-for="(item, index) in Items8">
                        <div :class="'Items8' + item.itemid">
                            <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthten/2301/m/tenbyten_thumbnail.jpg" alt=""></div>
                            <div class="desc">
                                <div class="price"><s></s> <span class="sale"></span></div>
                                <div class="name"></div>
                                <div class="brand"></div>
                            </div>
                        </div> 
                        <a href="javascript:void(0);" @click="prdDetailPage(item.itemid)" class="prd_link"><span class="blind">상품 바로가기</span></a> 
                    </li>
                    <a href="javascript:void(0);" @click="exhibitionDetailPage2('410','121')" class="btn_more">추천상품 더보기</a>
                </div>
                <div class="prd_list t01">
                    <div class="category"><a href="javascript:void(0);" @click="exhibitionDetailPage('410','122','데코/조명')">{{setCategoryName(122)}}<span class=""><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthten/2301/arrow_right.png" alt=""></span></a></div>
                    <li class="prd_item" v-for="(item, index) in Items9">
                        <div :class="'Items9' + item.itemid">
                            <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthten/2301/m/tenbyten_thumbnail.jpg" alt=""></div>
                            <div class="desc">
                                <div class="price"><s></s> <span class="sale"></span></div>
                                <div class="name"></div>
                                <div class="brand"></div>
                            </div>
                        </div> 
                        <a href="javascript:void(0);" @click="prdDetailPage(item.itemid)" class="prd_link"><span class="blind">상품 바로가기</span></a> 
                    </li>
                    <a href="javascript:void(0);" @click="exhibitionDetailPage2('410','122')" class="btn_more">추천상품 더보기</a>
                </div>
                <div class="prd_list t01">
                    <div class="category"><a href="javascript:void(0);" @click="exhibitionDetailPage('410','124','디자인가전')">{{setCategoryName(124)}}<span class=""><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthten/2301/arrow_right.png" alt=""></span></a></div>
                    <li class="prd_item" v-for="(item, index) in Items10">
                        <div :class="'Items10' + item.itemid">
                            <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthten/2301/m/tenbyten_thumbnail.jpg" alt=""></div>
                            <div class="desc">
                                <div class="price"><s></s> <span class="sale"></span></div>
                                <div class="name"></div>
                                <div class="brand"></div>
                            </div>
                        </div> 
                        <a href="javascript:void(0);" @click="prdDetailPage(item.itemid)" class="prd_link"><span class="blind">상품 바로가기</span></a> 
                    </li>
                    <a href="javascript:void(0);" @click="exhibitionDetailPage2('410','124')" class="btn_more">추천상품 더보기</a>
                </div>
            </div>
        </section>
    `
    , created() {
        const _this = this;
        this.$store.dispatch('GET_CATEGORIES_ITEMS');
        this.$store.dispatch('GET_MDCHOICE_ITEMS');
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
        mdchoiceItems() { 
            const items = this.$store.getters.mdchoiceItems;
            this.setItemInit2('mdchoiceItems', items);
            return this.$store.getters.mdchoiceItems;
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
        setItemInit2(target, e) {
            const _this = this;
            let items = e.map(i => i.eventid);
            _this.setItemInfo(target, items, ["image", "name", "price", "sale"]);
        },
        /**
         * 상품상세 페이지 이동
         * @param itemid
         */
        prdDetailPage(itemid){
            fnAmplitudeEventAction('click_tentensale_sale_button', 'item_id', itemid);
            location.href = "/shopping/category_prd.asp?itemid=" + itemid;
        },
        prdDetailPage2(div,itemid){
            fnAmplitudeEventMultiPropertiesAction('click_monthlyten_curation', 'num|item_id', div+"|"+itemid);
            location.href = "/shopping/category_prd.asp?itemid=" + itemid;
        },
        exhibitionDetailPage(masterCode,catecode,categoryname){
            fnAmplitudeEventAction('click_tentensale_sale_button', 'category_name', categoryname);
            location.href = '/monthlyten/Detail.asp?masterCode=' + masterCode + '&catecode=' + catecode;
        },
        exhibitionDetailPage2(masterCode,catecode){
            fnAmplitudeEventAction('click_tentensale_sale_button', 'button', catecode);
            location.href = '/monthlyten/Detail.asp?masterCode=' + masterCode + '&catecode=' + catecode;
        }
    }
});