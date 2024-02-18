const app = new Vue({
    el: '#app'
    , store : store
    , template : `
        <div class="container diary2023">
            <div id="contentWrap" class="diary2023_ranking">
                <div class="blur01"></div>
                <div class="blur02"></div>
                <div class="blur03"></div>
                <div class="line01"><img src="//webimage.10x10.co.kr/fixevent/event/2022/daccu2023/line03.png?v=2" alt=""></div>
                <div class="line02"><img src="//webimage.10x10.co.kr/fixevent/event/2022/daccu2023/line04.png" alt=""></div>
                <div class="top"></div>
                <div class="content">
                    <div class="section">
                        <div class="section01">
                            <Menu-Component></Menu-Component>
                           
                            <a href="/diarystory2023/index.asp"><div class="sect01_inform">
                                <p>기록의 즐거움<br><span>2023 텐텐다꾸</span></p>
                                <li>추억을 기억하는<br>가장 즐거운 방법!</li>
                            </div></a>
                        </div>
                        <div class="section02">
                            <div class="section02_top"><img src="//webimage.10x10.co.kr/fixevent/event/2022/daccu2023/note_header.png" alt=""></div>
                            <div class="rangking_slide">
                                <div class="swiper-wrapper">
                                    <div v-for="item in product_category" @click="go_category(item)" :class="['swiper-slide', item.cate_name == active_product_category ? 'on' : '']">
                                        {{item.cate_name}}
                                    </div>
                                </div>
                                <div class="swiper-navigation">
                                    <div class="swiper-button-prev"></div>
                                    <div class="swiper-button-next"></div>
                                </div>
                            </div>
                           
                            <div class="sect02_list">
                                <div v-for="(item, index) in ranking_item.items" class="prd_wrap">
                                    <a :href="'/shopping/category_prd.asp?itemid=' + item.item_id">
                                        <div class="prd_img">
                                            <img :src="decode_base64(item.list_image)" alt="">
                                            <p class="ranking">{{index+1}}</p>
                                        </div>
                                        <div class="prd_info">
                                            <div class="price">
                                                <s v-show="item.sale_percent > 0">{{format_price(item.org_price)}}</s>{{format_price(item.item_price)}}
                                                <span v-show="item.sale_percent > 0">{{item.sale_percent}}%</span>
                                            </div>
                                            <p class="name">{{item.item_name}}</p>
                                            <p class="brand">{{item.brand_name_en}}</p>
                                        </div>
                                    </a>
                                    <a @click="add_shoppingbag($event, item.item_id, item.optioncnt > 0 ? 1 : 0)" href="javascript:void(0)"><div class="btn_cart">담기
                                        <div class="alertLyrV15 cartLyr" style="display: none;">
                                            <div class="alertBox layer-cont">
                                                <em class="closeBtnV15 btn-close">&times;</em>
                                                <div class="alertInner">
                                                    <p id="alertMsg"><strong class="cBk0V15">선택하신 상품을<br />장바구니에 담았습니다.</strong></p>
                                                    <p class="tPad10 btn-area">
                                                        <a @click="cartLayerClose" class="btn btnS1 btnRed">쇼핑 계속하기</a>
                                                        <a href="/inipay/shoppingbag.asp" class="btn btnS1 btnWhite">장바구니 가기</a>
                                                    </p>
                                                </div>
                                            </div>
                                        </div>
                                    </div></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="bottom"></div>
            </div>
        </div>
    `
    , created() {
        const _this = this;

        this.search_parameter = {
            "cate_code" :  this.product_category[0].cate_code
            , "page" : 1
        };
        this.$store.dispatch("GET_RANKING_ITEM", this.search_parameter).then(function(){
            sectionHeihgt = $('.diary2023_ranking .section').innerHeight() - 100;
            $('.diary2023_ranking .content').css('height', sectionHeihgt);
        });

        this.$nextTick(function() {
            // 카테고리
            const swiper = new Swiper('.rangking_slide', {
                slidesPerView:'auto',
                touchRatio: 0,
                navigation: {
                    nextEl: '.swiper-button-next',
                    prevEl: '.swiper-button-prev',
                },
            });

            $('.rangking_slide .swiper-slide').on('click',function(){
                if($(this).hasClass('on')) {
                    $(this).siblings().removeClass('on');
                } else {
                    $(this).addClass('on');
                    $(this).siblings().removeClass('on');
                }
            });

            $(window).scroll(function() {
                if($(window).scrollTop() * 1.2 >= $(document).height() - $(window).height()) {
                    if(10 >  _this.search_parameter.page && !_this.loading_flag){
                        _this.loading_flag = true;
                        _this.show_more();
                    }
                }
            });
        });
    }
    , mounted(){
        const _this = this;
    }
    , computed : {
        ranking_item(){
            return this.$store.getters.ranking_item;
        }
    }
    , data(){
        return {
            active_product_category : "전체상품"
            , search_parameter : {
                "cate_code" : null
                , "page" : 1
            }
            , loading_flag : false
            , popup_nooption : false
            , popup_option : false
            , product_category : [
                {"cate_name" : "전체상품", "cate_code" : [101102101101, 101102101102, 101102101106, 101102101109, 101102101105, 101102101104, 101102101103, 101102101108, 101102103101, 101102103102, 101102103103, 101102103104, 101102103109, 101102103106, 101102103107, 101102104101, 101102104102, 101102104105, 101102104106, 101102104107, 101102104108, 101102104103, 101107102101, 101107102102, 101107102103, 101107102104, 101107102105, 101107102106, 101107102107, 101107102111, 101107101101, 101107101102, 101107101103, 101107101104, 101107101105, 101107103101, 101107103102, 101107103103, 101107103104, 101107103106, 101107103105, 101104101105, 101104101102, 101104101104, 101104101107, 101104101109, 101104101108, 101104101114, 101103108101, 101103108102, 101106101, 101106102, 101110111]}
                , {"cate_name" : "전체 다이어리", "cate_code" : [101102101101, 101102101102, 101102101109, 101102101104, 101102101103, 101102101108]}
                , {"cate_name" : "심플 다이어리", "cate_code" : [101102101101]}
                , {"cate_name" : "일러스트 다이어리", "cate_code" : [101102101102]}
                , {"cate_name" : "3공/6공 다이어리", "cate_code" : [101102101109]}
                , {"cate_name" : "리필속지 베스트", "cate_code" : [101102101105]}
                , {"cate_name" : "모든 다꾸템 베스트", "cate_code" : [101102101106, 101102101105, 101107102101, 101107102102, 101107102103, 101107102104, 101107102105, 101107102106, 101107102107, 101107102111, 101107101101, 101107101102, 101107101103, 101107101104, 101107101105, 101107103101, 101107103102, 101107103103, 101107103104, 101107103106, 101107103105, 101104101105, 101104101102, 101104101104, 101104101107, 101104101109, 101104101108, 101104101114, 101103108101, 101103108102]}
                , {"cate_name" : "스티커 베스트", "cate_code" : [101107102101, 101107102102, 101107102103, 101107102104, 101107102105, 101107102106, 101107102107, 101107102111]}
                , {"cate_name" : "스탬프 베스트", "cate_code" : [101107101101, 101107101102, 101107101103, 101107101104, 101107101105]}
                , {"cate_name" : "펜/색연필 베스트", "cate_code" : [101104101105, 101104101102, 101104101104, 101104101107, 101104101109, 101104101108, 101104101114]}
                , {"cate_name" : "캘린더 베스트", "cate_code" : [101102104101, 101102104102, 101102104105, 101102104106, 101102104107, 101102104108, 101102104103]}
                , {"cate_name" : "플래너 베스트", "cate_code" : [101102103101, 101102103102, 101102103103, 101102103104, 101102103109, 101102103106]}
                , {"cate_name" : "가계부 베스트", "cate_code" : [101102103107]}
                , {"cate_name" : "패드/앱 베스트", "cate_code" : [101116]}
            ]
            , clicked_itemid : null
            , test : null
        }
    }
    , methods : {
        format_price(price){
            if(price){
                return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
            }
        }
        , go_category(category){
            this.active_product_category = category.cate_name;
            this.search_parameter = {
                "cate_code" :  category.cate_code
                , "page" : 1
            };
            this.$store.dispatch("GET_RANKING_ITEM", this.search_parameter).then(function(){
                sectionHeihgt = $('.diary2023_ranking .section').innerHeight() - 100;
                $('.diary2023_ranking .content').css('height', sectionHeihgt);
            });;
        }
        , show_more(){
            this.search_parameter.page += 1;
            this.$store.dispatch("GET_RANKING_ITEM", this.search_parameter).then(function(){
                sectionHeihgt = $('.diary2023_ranking .section').innerHeight() - 100;
                $('.diary2023_ranking .content').css('height', sectionHeihgt);
            });
            fnAmplitudeEventAction('view_diarystory_best', 'category_name|paging_index', this.active_product_category + '|' + this.search_parameter.page);
        }
        , add_shoppingbag(event, itemid, option_flag){
            const _this = this;
            if(!isUserLoginOK){
                if(confirm("로그인이 필요합니다.")){
                    location.href='/login/loginpage.asp?backpath=' + window.location.pathname;
                }

                return false;
            }

            this.test = event.target.children[0];
            this.clicked_itemid = itemid;

            if (option_flag) {
                //this.popup_option = true;
                ZoomItemInfo(itemid);
            } else {
                let vTrData = {
                    "mode" : "add",
                    "itemid" : itemid,
                    "sitename" : "",
                    "itemoption" : "0000",
                    "itemea" : "1"
                }

                $.ajax({
                    type : "POST",
                    url : "/inipay/shoppingbag_process.asp?tp=ajax",
                    data : vTrData,
                    success: function(message) {
                        switch(message.split("||")[0]) {
                            case "0":
                                alert("유효하지 않은 상품이거나 품절된 상품입니다.");
                                break;
                            case "1":
                                fnDelCartAll();
                                $("#alertMsg").html("선택하신 상품을<br />장바구니에 담았습니다.");
                                $(event.target.children[0]).fadeIn('fast').delay(3000).fadeOut();
                                //$(".cartLyr").fadeIn('fast').delay(3000).fadeOut();
                                break;
                            case "2":
                                $("#alertMsg").html("장바구니에 이미<br />같은 상품이 있습니다.");
                                $(event.target.children[0]).fadeIn('fast').delay(3000).fadeOut();
                                //$(".cartLyr").fadeIn('fast').delay(3000).fadeOut();
                                break;
                            default:
                                alert("죄송합니다. 오류가 발생했습니다.");
                                break;
                        }
                    }
                });
                fnAmplitudeEventAction('click_diarystory_shoppingbag', 'category_name|item_id', _this.active_product_category + '|' + itemid);
            }
        }
        , cartLayerClose : function() {
            $(".cartLyr").hide();
        }
    }
});