Vue.use(VueAwesomeSwiper);

const app = new Vue({
    el: '#app'
    , store : store
    , template : `
<div class="univarsal" id="content">
    <div class="visual-area">
        <div class="visual-bnr bnr01"><img src="//webimage.10x10.co.kr/fixevent/event/2022/ten_sale12/bg.png" alt="선물하기 좋은"></div>
    </div>
    <article class="sub-bnr w1140">
        <!-- menu swiper -->
        <div class="fix-start"></div>
        <div v-show="categories.length > 2" class="menu-swiper item-swiper swiper-container">
            <swiper :options="category_swiper" ref="category_swiper" class="swiper-wrapper">
                <swiper-slide v-for="item in categories" :key="active_attribute.attribCd" :dispcd="item.cate_code" :class="['swiper-slide', search_catecode == item.cate_code ? 'active' : '']">
                    <a @click="click_categories(item.cate_code)" href="javascript:void(0)">{{item.cate_name}}</a>
                </swiper-slide>
            </swiper>
        </div>
    </article>
    <article class="sub-contents w1140">
        <div class="sub-menu-area">
            <div class="view-select">
                <button type="button" class="btn-view"><span id="search_sort_name" class="text">인기순으로 보기</span> <span class="icon"></span></button>
                <div class="select-list">
                    <ul>
                        <li @click="click_sort('best')">인기순으로 보기</li>
                        <li @click="click_sort('new')">신규순으로 보기</li>
                        <li @click="click_sort('br')">평가좋은순 보기</li>
                        <li @click="click_sort('hp')">높은가격순 보기</li>
                        <li @click="click_sort('bs')">판매량순 보기</li>
                        <li @click="click_sort('ws')">위시순 보기</li>
                        <li @click="click_sort('lp')">낮은가격순 보기</li>
                        <li @click="click_sort('hs')">할인율순 보기</li>
                    </ul>
                </div>
            </div>
        </div>
        <!-- 상품 리스트 -->
        <section class="uni-prd-list">
            <div class="pdtWrap pdt240V15">
                <ul class="pdtList">
                    <li v-for="(item, index) in character_item" :class="[item.sell_flag != 'Y' ? 'soldOut' : '']">
                        <div class="pdtBox">
                            <i v-if="item.free_baesong" class="free-shipping-badge">무료<br>배송</i>
                            <div class="pdtPhoto">
                                <span class="soldOutMask"></span>
                                <a :onclick="'goProduct(' + item.item_id + ')'" href="javascript:void(0)">
                                    <img :src="decodeBase64(item.list_image)" alt="상품">
                                    <dfn><img :src="decodeBase64(item.list_image)" alt="상품"></dfn>
                                </a>
                            </div>
                            <div class="pdtInfo">
                                <p class="pdtBrand tPad20"><a :href="'/street/street_brand.asp?makerid=' + item.brand_id">{{item.brand_name_en}}</a></p>
                                <p class="pdtName tPad07"><a :onclick="'goProduct(' + item.item_id + ')'" href="javascript:void(0)">{{item.item_name}}</a></p>
                                <p v-if="item.sale_yn" class="pdtPrice"><span class="txtML">{{format_price(item.org_price)}}원</span></p>
                                <!--<p class="pdtPrice"><span class="txtML">12,039,600원</span> <strong class="cGr0V15">[10%]</strong></p>-->
                                <p class="pdtPrice"><span class="finalP">{{format_price(item.item_price)}}원</span> <strong v-show="item.sale_yn" class="cRd0V15">[{{item.sale_percent}}%]</strong></p>
                                <p class="pdtStTag tPad10">
                                    <img v-show="item.sale_yn" src="http://fiximage.10x10.co.kr/web2013/shopping/tag_sale.gif" alt="SALE">
                                    <img v-show="item.item_coupon_yn" src="http://fiximage.10x10.co.kr/web2013/shopping/tag_coupon.gif" alt="쿠폰">
                                    <img v-show="item.free_baesong" src="http://fiximage.10x10.co.kr/web2013/shopping/tag_free_ship.gif" alt="무료배송">
                                    <img v-show="item.limityn" src="http://fiximage.10x10.co.kr/web2013/shopping/tag_limited.gif" alt="한정">
                                    <img v-show="item.ten_only" src="http://fiximage.10x10.co.kr/web2013/shopping/tag_only.gif" alt="ONLY">
                                    <img v-show="item.newyn" src="http://fiximage.10x10.co.kr/web2013/shopping/tag_new.gif" alt="NEW">
                                    <span v-show="item.pojangok" class="icoWrappingV15a">
                                        <img src="http://fiximage.10x10.co.kr/web2015/shopping/ico_pakage_act.png" alt="선물포장가능">
                                        <em><img src="http://fiximage.10x10.co.kr/web2015/common/pkg_tip.png" alt="선물포장가능"></em>
                                    </span>
                                </p>
                            </div>
                            <ul class="pdtActionV15">
                                <li class="largeView"><a @click="go_zoom(item.item_id)" href="javascript:void(0)"><img src="http://fiximage.10x10.co.kr/web2015/common/btn_quick.png" alt="QUICK"></a></li>
                                <li class="postView"><a href="javascript:void(0)"><span>{{format_price(item.review_cnt)}}</span></a></li>
                                <li class="wishView"><a href="javascript:void(0)"><span>{{format_price(item.favcount)}}</span></a></li>
                            </ul>
                        </div>
                    </li>
                </ul>
            </div>
        </section>
    </article>	
</div>
    `
    , created() {
        const _this= this;

        this.search_sort = this.get_url_param("sort") ? this.get_url_param("sort") : "best";
        //console.log("paramater method_go_search1", this.search_sort);
        //this.$store.dispatch("GET_ATTRIBUTE_GROUP").then(() => {
        //    _this.click_character_tab();
        //});
        this.$store.dispatch("GET_ATTRIBUTE_GROUP").then(function() {
            _this.click_character_tab(_this.get_url_param("catecode"));

            var menuSwiper = new Swiper(".item-swiper .swiper-container", {
                slidesPerView:'auto',
                speed:500,
            });
        });
        this.$nextTick(function() {
            $(window).scroll(function() {
                if ($(window).scrollTop() * 1.3 >= $(document).height() - $(window).height()) {
                    if(_this.character_item_last_page >  _this.search_page){
                        _this.search_page += 1;
                        _this.method_go_search();
                    }
                }
            });

            switch (this.search_sort) {
                case "best": $("#search_sort_name").text("인기순으로 보기");break;
                case "new" : $("#search_sort_name").text("신규순으로 보기");break;
                case "br" : $("#search_sort_name").text("평가좋은순 보기");break;
                case "hp" : $("#search_sort_name").text("높은가격순 보기");break;
                case "bs" : $("#search_sort_name").text("판매량순 보기");break;
                case "ws" : $("#search_sort_name").text("위시순 보기");break;
                case "lp" : $("#search_sort_name").text("낮은가격순 보기");break;
                case "hs" : $("#search_sort_name").text("할인율순 보기");break;
            }

            /* 모달 호출 */
            $('.btn-search').on('click',function(){
                $('.modal_uni_sorting').addClass('show');
                $('html,body').addClass('scroll-disable');

            });
            /* 모달 닫기 */
            $('.btn_close,.modal_overlay').on('click',function(){
                $('.modal_uni_sorting').removeClass('show');
                $('html,body').removeClass('scroll-disable');

            });
            $('.modal_uni_sorting .btn_ten').on('click',function(){

            });
        });
    }
    , updated() {
        const _this = this;

    }
    , mounted(){
        const _this = this;

        const catecode = this.get_url_param("catecode");

    }
    , computed : {
        child_character_tab(){
            return this.$store.getters.child_character_tab;
        }
        ,parents_character_tab(){
            return this.$store.getters.parents_character_tab;
        }
        , character_item(){
            return this.$store.getters.character_item;
        }
        , character_item_last_page(){
            return this.$store.getters.character_item_last_page;
        }
        , categories(){
            return this.$store.getters.categories;
        }
        , swiper(){
            return this.$refs.category_swiper.$swiper;
        }

    }
    , data(){
        return {
            active_attribute : {}
            , search_sort : {
                "sort" : "best"
                , "name" : "인기순"
            }
            , search_catecode : this.get_url_param("catecode")
            , search_page : 1
            , show_type : "detail"
            , category_swiper: {
                slidesPerView: 'auto'
                , speed : 500
                , on : {
                    click : function(data){
                        const activeIndex = data.clickedIndex;
                        if(activeIndex){
                            console.log("click swiper index", activeIndex);
                            app.$refs.category_swiper.$swiper.slideTo(activeIndex);
                        }
                    }
                }
            }
            , character_swiper: {
                slidesPerView: 'auto'
                , speed : 500
                , on : {
                    click : function(data){
                        const activeIndex = data.clickedIndex;
                        if(activeIndex){
                            app.$refs.character_swiper.$swiper.slideTo(activeIndex);
                        }
                    }
                }
            }
            , random_character_banner : {}

            , slick_exist_check : false
            , swiper_check : true
            , swiper_index : 0
        }
    }
    , methods : {
        format_price(price){
            if(price){
                return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
            }
        }
        , get_url_param(param_name){
            let now_url = location.search.substr(location.search.indexOf("?") + 1);
            now_url = now_url.split("&");
            let result = "";
            for(let i = 0; i < now_url.length; i++){
                let temp_param = now_url[i].split("=");
                if(temp_param[0] == param_name){
                    result = temp_param[1].replace("%20", " ");
                }
            }

            return result;
        }
        , decodeBase64(str) {
            if( str == null ) return null;
            return atob(str.replace(/_/g, '/').replace(/-/g, '+'));
        }
        , click_character_tab(){
            const _this = this;

            if(_this.slick_exist_check){
                $('.fade-swiper .slider').slick("unslick");
            }

            this.method_reset_search_param();
            this.method_go_search();
            //this.method_get_random_character_banner();

            call_api("GET", "/event/categories-of-attribute"
                , {"attribCd" : "408101"}
                , function(data){
                    let result_categories = new Array();
                    result_categories.push({
                        "cate_code" : "all"
                        , "cate_name" : "전체"
                    });

                    _this.$store.commit("SET_CATEGORIES", result_categories.concat(data));
                    for(let i = 0; i < data.length; i++){
                        if(data[i].cate_code === _this.search_catecode){
                            _this.swiper_index = i + 1;
                            break;
                        }
                    }
                    let swiperInfo = app.$refs.category_swiper.$swiper;
                    if (_this.swiper_check) {
                        setTimeout(function() {
                            //alert(_this.swiper_index)
                            swiperInfo.slideTo(_this.swiper_index);
                        }, 1000);
                        _this.swiper_check = false;
                    }
                }
            );
        }
        , click_sort(sort){
            parent.location.href = "/tentensale/exhibitionDetailView.asp?catecode=" + this.search_catecode + "&referrer=" + this.get_url_param("referrer") + "&sort=" + sort;
        }
        , go_sorting(){
            this.search_sort = $("input[name=optA]:checked").val();
            this.method_go_search();

            $('.modal_uni_sorting').removeClass('show');
            $('html,body').removeClass('scroll-disable');
        }
        , click_categories(catecode){
            this.search_catecode = catecode;
            this.method_reset_search_param()
            this.method_go_search();
        }
        , go_zoom(itemid){
            ZoomItemInfo(itemid);
        }
        , method_go_search(){
            const _this = this;
            let search_catecode_param = ""
            if(this.search_catecode != "all"){
                search_catecode_param = this.search_catecode;
            }

            let api_data = {
                "attribCd" : _this.active_attribute.attribCd
                , "sortMethod" : _this.search_sort
                , "catecode" : search_catecode_param
                , "page" : _this.search_page
            };

            _this.$store.dispatch("GET_CHARACTER_ITEM", api_data)
        }
        , method_reset_search_param(){
            this.show_type = "detail";
            //this.search_sort = {
            //    "sort" : "best"
            //    , "name" : "인기순"
            //};
            this.search_page = 1;
        }
        , method_get_random_character_banner(){
            const _this = this;

            let exclude_child_attribute_group = this.child_character_tab.filter(function(data){
                return data.attribDiv != _this.active_attribute.attribDiv;
            });
            this.random_character_banner = exclude_child_attribute_group[Math.floor(Math.random() * exclude_child_attribute_group.length)];
        }
        /**
         * 상품상세 페이지 이동
         * @param itemid
         */
        , goProduct(itemid){
            location.href = "/shopping/category_prd.asp?itemid=" + itemid;
        }
    }
    , watch : {
    }
});