const app = new Vue({
    el: '#app',
    store : store,
    mixin : [common_mixin],
    template : /*html*/`
        <div>
            <!-- 메인 배너 -->
			<SLIDE-BANNER v-if="banners.length > 0" :banners="banners" :banners_count="banners.length" />
			
			<!-- best pick 오늘의 추천 -->
            <div v-if="bestpick != null && bestpick.length > 0">
                <div class="h-tit"><h2>오늘의 추천</h2></div>
                <div class="section best-pick">
                    <div class="pdtWrap pdt240V15 pdtBizWrap recommend_prd">
                        <ul class="pdtList">
                            <PRODUCT-BASIC v-for="(item, index) in bestpick" :key="index" @go_product_detail="go_product_detail" :index="index" :product="item" />
                        </ul>
                    </div>
                </div>
            </div>
            
            <!-- biz 상품 큐레이터 -->
            <div class="section biz-pd-curator">
                <div class="tab-nav">
                    <button type="button" :class="{on : recommend_type == 'best'}" @click="change_recommend_type('best')"><span>많이 찾고있어요</span></button>
                    <button type="button" :class="{on : recommend_type == 'new'}" @click="change_recommend_type('new')"><span>새로 들어왔어요</span></button>
                </div>
                <div class="pdtWrap pdt240V15 pdtBizWrap">
                    <ul class="pdtList">
                        <PRODUCT-BASIC v-for="(item, index) in recommend" :key="index" @go_product_detail="go_product_detail" :index="index" :product="item" />                     
                    </ul>
                </div>
            </div>
        </div>
    `,
    data() {return {
        parameter : {
            keyword : '',
            category_code : 102,
            group_type : 'sc',
            page : 1,
            view_type : 'M',
            sort_method : 'ne',
            except_sold_out_yn : false,
            deli_type : [],
            color : [],
            style : []
        }
        , category_info : {
            category_code : 0,
            category_name : '',
            category_depth : 1,
            header_categories : [],
            low_categories : []
        }
        , recommend_type : "best"
    }},
    created() {
        this.$store.dispatch("GET_BANNER_LIST");
        this.$store.dispatch("GET_BESTPICK_LIST");
        this.$store.dispatch("GET_RECOMMEND_LIST", this.recommend_type);
    },
    computed : {
        banners() {
            return this.$store.getters.banners;
        }
        , bestpick() {
            return this.$store.getters.bestpick;
        }
        , recommend() {
            return this.$store.getters.recommend;
        }
    }
    , methods : {
        go_product_detail(index, product) {
            fnAmplitudeEventMultiPropertiesAction('click_category_list_product'
                , 'item_index|sort|category_code|category_depth|itemid|category_name|brand_name|list_style'
                , `${index}|${this.parameter.sort}|${this.category_info.category_code}|${this.category_info.category_depth}`
                + `|${product.item_id}|${this.category_info.category_name}|${product.brand_name}|${this.parameter.view_type}`);

            location.href = product.move_url;
        }
        , change_recommend_type(type){
            this.recommend_type = type;
            this.$store.dispatch("GET_RECOMMEND_LIST", this.recommend_type);
        }
    }
});