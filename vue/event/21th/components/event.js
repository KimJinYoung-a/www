Vue.component('EVENT', {
    template : `
        <section id="tab04" class="tab04">
            <section class="section10" id="cheer03">
                <a v-if="goods" href="javascript:void(0)" @click="movePage(goods.linkurl)">
                    <img :src="goods.imageurl" alt="">
                </a>
            </section>
            <section class="section11" id="cheer04">
                <div class="banner_wrap">
                    <a v-if="diaryStory" href="javascript:void(0)" @click="movePage(diaryStory.linkurl)" id="cheer04">
                        <img :src="diaryStory.imageurl" alt="">
                    </a>
                    <a v-if="bestItem" href="javascript:void(0)" @click="movePage(bestItem.linkurl)">
                        <img :src="bestItem.imageurl" alt="">
                    </a>
                    <a href="#app_qr" class="app_qr">
                        <img :src="firstBuyShop.imageurl" alt="">
                    </a>
                </div>
            </section>
            <section class="section12" id="cheer06">
                <button @click="moveForumPage"></button>
                <div class="hbd">
                    <p class="icon01"><img src="//webimage.10x10.co.kr/fixevent/event/2022/anniversary/heart.png" alt=""></p>
                    <p class="icon02"><img src="//webimage.10x10.co.kr/fixevent/event/2022/anniversary/message01.png" alt=""></p>
                    <p class="icon03"><img src="//webimage.10x10.co.kr/fixevent/event/2022/anniversary/message02.png" alt=""></p>
                    <p class="icon04"><img src="//webimage.10x10.co.kr/fixevent/event/2022/anniversary/message03.png" alt=""></p>
                </div>
            </section>
            <section class="section13" id="app_qr">
                <img src="//webimage.10x10.co.kr/fixevent/event/2022/anniversary/app_qr.png" alt="">
            </section>
            <section class="section14"  v-if="items">
                <h2><img src="//webimage.10x10.co.kr/fixevent/event/2022/anniversary/sale_title.png" alt=""></h2>
                <div class="cont_wrap">
                    <div>
                        <div class="prd_wrap">
                            <ul id="lyrItemlist" class="item_list">
                                <li v-for="(item, index) in items">
                                    <a href="javascript:void(0);" @click="prdDetailPage(item.itemid)" :class="'items' + item.itemid">
                                        <div class="thumbnail"><img src="https://webimage.10x10.co.kr/fixevent/event/2022/anniversary/tenbyten_2022-thum.jpg/10x10/optimize" alt=""></div>
                                        <div class="desc">
                                            <p class="name">상품명</p>
                                            <div class="price"><s>15,000</s> 11,000<span class="sale">30%</span></div>
                                        </div>
                                    </a>
                                </li>
                            </ul>
                        </div>
                        <div class="ten_mask">
                            <a href="javascript:void(0);" @click="moreItem()" class="btn_more">더보기<span class="arrow"></span></a>
                        </div>
                    </div>
                </div>
            </section>
        </section>
    `
    , created() {
        const _this = this;
        _this.$store.dispatch('GET_BANNER_IMAGE', 400); // 굿즈
        _this.$store.dispatch('GET_BANNER_IMAGE', 402); // 텐텐다꾸
        _this.$store.dispatch('GET_BANNER_IMAGE', 403); // 베스트아이템
        _this.$store.dispatch('GET_BANNER_IMAGE', 404); // 첫구매샵
        _this.$store.dispatch('GET_ITEMS'); // 모아보기
    }
    , data() {
        return {
        }
    }
    ,updated() {
        const _this = this;
    }
    , mounted() {
        const _this = this;
        _this.$nextTick(function() {
            $('.app_qr').click(function (event) {
                var tabHeight = $('.tab-area').outerHeight();
                event.preventDefault();
                $('html, body').animate({
                    scrollTop: $($.attr(this, 'href')).offset().top - tabHeight
                }, 500);
            });

            // 더보기 버튼
            $('.btn_more').click(function (e) { 
                e.preventDefault();
                $(this).parent().siblings('.prd_wrap').find('ul').addClass('more');
                $(this).parent('.ten_mask').addClass('more');
                $(this).parent().siblings('.prd_wrap').find('li:hidden').slice(0, 8).show(); 
                if (_this.page * 20 >= _this.itemCount) { 
                    $(this).parent('.ten_mask').hide();
                    $(this).parent().siblings('.prd_wrap').find('ul').css('paddingBottom','80px')
                } 
            })
        })
        
    }
    , computed : {
        goods() {
            return this.$store.getters.goods;
        },
        appEntryItem() {
            return this.$store.getters.appEntryItem;
        },
        diaryStory() {
            return this.$store.getters.diaryStory;
        },
        bestItem() {
            return this.$store.getters.bestItem;
        },
        firstBuyShop() {
            return this.$store.getters.firstBuyShop;
        },
        items() {
            let items = this.$store.getters.items;
            this.setItemInit('items', items);
            return items;
        },
        itemCount() {
            if (this.$store.getters.itemCount < 20) {
                $(".ten_mask").hide();
            }
            return this.$store.getters.itemCount;
        },
        page() {
            return this.$store.getters.page;
        }
    },
    methods : {
        movePage(link) {
            location.href = link;
        },
        moveForumPage() {
            location.href = "/linker/forum.asp?idx=7";
        },
        setItemInit(target, e) {
            const _this = this;
            let items = e.map(i => i.itemid);
            _this.setItemInfo(target, items, ["image", "name", "price", "sale"]);
        },
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
        moreItem() {
            this.$store.dispatch('GET_MORE_ITEMS');
        },
        prdDetailPage(itemid){
            location.href = "/shopping/category_prd.asp?itemid=" + itemid;
        },
    }
});