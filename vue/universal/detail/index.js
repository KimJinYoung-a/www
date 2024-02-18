const app = new Vue({
    el: '#app'
    , store : store
    , template : `
        <div class="univarsal">
            <article class="sub-bnr w1140">
                <!-- menu swiper -->
                <div class="fix-start"></div>
                <div class="menu-swiper item-swiper">
                    <div class="logo"><a href="/universal/index.asp"><img src="//webimage.10x10.co.kr/fixevent/event/2022/universal/img_logo02.png" alt="logo"></a></div>
                    <div class="swiper-container">
                        <ul class="swiper-wrapper">
                            <li v-for="(item, index) in parents_character_tab" :class="['swiper-slide', active_attribute.attribDiv == item.attribDiv ? 'active' : '']">
                                <a @click="click_character_tab(item.attribDiv)" href="javascript:void(0)">{{item.attribDivName}}</a>
                            </li>
                        </ul>
                    </div>
                </div>
                <!-- 전체:visual-bnr 없음 -->
                <div v-show="active_attribute.image4" class="visual-area">    
                    <div v-if="active_attribute.image4 && !(active_attribute.attribDiv == '404' || active_attribute.attribDiv == '405')" class="visual-bnr bnr01 on">
                        <img v-for="item in active_attribute.image4" :src="item" alt="">
                    </div>                    
                    <div v-else class="visual-bnr bnr04 on">
                        <div class="fade-swiper">
                            <div class="slider">
                                <div v-for="item in active_attribute.image4" class="slide"><img :src="item" alt=""></div>
                            </div>
                        </div>
                    </div>
                </div>
            </article>
            <article class="sub-contents w1140">
                <div class="sub-menu-area">
                    <div v-show="categories.length > 1" class="prd-menu-swiper item-swiper">
                        <div class="swiper-container">
                            <ul class="swiper-wrapper">
                                <li :class="['swiper-slide', search_catecode == '' ? 'active' : '']">
                                    <button @click="click_categories('')" type="button">전체</button>
                                </li>
                                <li  v-for="item in categories" :class="['swiper-slide', search_catecode == item.cate_code ? 'active' : '']">
                                    <button @click="click_categories(item.cate_code)" type="button">{{item.cate_name}}</button>
                                </li>
                            </ul>
                        </div>
                    </div>
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
        const _this = this;

        this.search_catecode = this.get_url_param("catecode");
        this.search_sort = this.get_url_param("sort") ? this.get_url_param("sort") : "best";

        this.$store.dispatch("GET_ATTRIBUTE_GROUP").then(function() {
            _this.click_character_tab(_this.get_url_param("attribDiv"));

            var menuSwiper = new Swiper(".item-swiper .swiper-container", {
                slidesPerView:'auto',
                speed:500,
            });
        });
        this.$nextTick(function() {
            $(window).scroll(function() {
                if ($(window).scrollTop() * 1.3 >= $(document).height() - $(window).height()) {
                    if(_this.character_item_last_page >  _this.search_page && !_this.now_loading_flag){
                        _this.now_loading_flag = true;
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

            /* menu 선택 */
            $('.menu-swiper .swiper-slide').on('click',function(){
                if($(this).hasClass('active')) {
                    (this).siblings().removeClass('active');
                } else {
                    $(this).addClass('active');
                    $(this).siblings().removeClass('active');
                }
            });
            /* contents menu 선택 */
            $('.prd-menu-swiper .swiper-slide').on('click',function(){
                if($(this).hasClass('active')) {
                    $(this).siblings().removeClass('active');
                } else {
                    $(this).addClass('active');
                    $(this).siblings().removeClass('active');
                }
            });
            /* 상품 정렬 */
            $('.btn-view').on('click',function(){
                $(this).toggleClass('on');
                $(this).next().slideToggle();
            });
            /* 정렬 선택 */
            var btnView = $('.btn-view .text');
            $('.select-list li').on('click',function(){
                var innerText = $(this).text();
                $(btnView).text(innerText);
                $(this).parents('.select-list').slideToggle();
                $(this).parents('.select-list').prev('.btn-view').toggleClass('on');
            });
            /* menu swiper fixed */
            var lastScroll = 0;
            $(window).scroll(function(){
                var header = $('.header-wrap').outerHeight();
                var evthead = $('.evtHead').outerHeight();
                var tabHeight = $('.menu-swiper').outerHeight();
                var fixHeight = header + evthead;
                var st = $(this).scrollTop();
                var startFix = $('.fix-start').offset().top;
                /* 개발파일에서 삭제 */
                if((st >= fixHeight)) {
                    $('.menu-swiper').addClass('fixed').css('top','0')
                } else if((st <= startFix)){
                    $('.menu-swiper').removeClass('fixed').css('top','unset')
                }
            });
            /* scroll top이동 */
            $('.menu-swiper .swiper-slide a').on('click', function (event) {
                event.preventDefault();
                $('html, body').animate({
                    scrollTop: $('.headerTopNew').offset().top
                }, 0);
            });
        });
    }
    , mounted(){
        const _this = this;
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
    }
    , data(){
        return {
            active_attribute : {}
            , search_sort : "best"
            , search_catecode : ""
            , search_page : 1
            , slick_exist_check : false
            , now_loading_flag : false
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
        , click_character_tab(attribDiv){
            const _this = this;

            if(_this.slick_exist_check){
                //$('.fade-swiper .slider').slick("unslick");
                parent.location.href = "/universal/detail.asp?attribDiv=" + attribDiv + "&referrer=" + this.get_url_param("referrer");
                return false;
            }

            if(attribDiv != "" && attribDiv !== "undefined"){
                this.parents_character_tab.forEach(function(item, index){
                    if(item.attribDiv == attribDiv){
                        _this.active_attribute = item;
                    }
                });
            }else{
                _this.active_attribute = _this.parents_character_tab[0];
            }

            this.method_go_search();

            call_api("GET", "/event/categories-of-attribute"
                , {"attribCd" : _this.active_attribute.attribCd.split(",")}
                , function(data){
                    console.log("GET CATEGORIES OF ATTRIBUTE", data);
                    _this.$store.commit("SET_CATEGORIES", data);
                }
            );
        }
        , click_sort(sort){
            parent.location.href = "/universal/detail.asp?attribDiv=" + this.active_attribute.attribDiv + "&referrer=" + this.get_url_param("referrer") + "&catecode=" + this.search_catecode + "&sort=" + sort;
        }
        , click_categories(catecode){
            parent.location.href = "/universal/detail.asp?attribDiv=" + this.active_attribute.attribDiv + "&referrer=" + this.get_url_param("referrer") + "&catecode=" + catecode  + "&sort=" + this.search_sort;
        }
        , go_zoom(itemid){
            ZoomItemInfo(itemid);
        }

        , method_go_search(){
            const _this = this;

            let api_data = {
                "attribCd" : _this.active_attribute.attribCd
                , "sortMethod" : _this.search_sort
                , "catecode" : _this.search_catecode
                , "page" : _this.search_page
            };

            _this.$store.dispatch("GET_CHARACTER_ITEM", api_data).then(function(){
                _this.$forceUpdate();

                let amplitude_category = $(".prd-menu-swiper .swiper-slide.active").find("button").html();
                let view_universal_detail = {
                    "tab" : $(".menu-swiper .swiper-slide.active").find("a").html()
                    , "category" : amplitude_category ? amplitude_category : "전체"
                    , "place" : _this.get_url_param("referrer") ? decodeURI(_this.get_url_param("referrer")) : ""
                };
                fnAmplitudeEventActionJsonData('view_universal_detail', JSON.stringify(view_universal_detail));

                if(_this.active_attribute.attribDiv == 404 || _this.active_attribute.attribDiv == 405){
                    $('.fade-swiper .slider').not('.slick-initialized').slick({
                        slidesToShow: 1,
                        slidesToScroll: 1,
                        autoplay: true,
                        autoplaySpeed: 0,
                        speed: 35000,
                        pauseOnHover: false,
                        pauseOnFocus: false,
                        cssEase: 'linear',
                        arrows:false,
                        dots:false,
                        variableWidth: true
                    });
                }

                _this.slick_exist_check = true;
                _this.now_loading_flag = false;
            });
        }
        , method_reset_search_param(){
            this.search_catecode = "";
            this.search_sort = "best";
            $("#search_sort_name").text("인기순으로 보기");
            this.search_page = 1;
        }
    }
    , watch : {

    }
});