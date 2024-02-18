const app = new Vue({
    el: '#app'
    , store : store
    , mixin : [common_mixin]
    , template : `
        <div class="container brandV15">
            <div class="brandContWrapV15"><!-- for dev msg : 기존 fullView,slimView 클래스 삭제 -->
                <div class="brandIntro" :style="street_hello ? 'background: url(http://imgstatic.10x10.co.kr/brandstreet/hello/' + street_hello.bgImageURL + ') center top / cover no-repeat;' : ''">
                    <div class="brandNavV15" :class="ctgyBg"><!-- for dev msg : 각 브랜드마다 지정된 대표 카테고리별 클래스 지정(ctgyBg01~ctgyBg10), 업체에서 등록한 배경이미지가 있는 경우 클래스명 제거 -->
                        <div class="bg">
                            <div class="wFix">
                                <h3>
                                    <span class="eng">{{brand_info.brand_name_en}}</span>
                                    <span class="korean">{{brand_info.brand_name_kr}}</span>
                                </h3>
                                <ul class="navListV15"><!-- for dev msg : 브랜드별 메뉴 노출 상이함 -->
                                    <li :class="[{current : brand_tap == 'shop'}]" @click="brand_tap_change('shop')">
                                        <span>SHOP</span>
                                    </li>
                                    <li v-if="interview.length > 0" :class="[{current : brand_tap == 'interview'}]" @click="brand_tap_change('interview')">
                                        <span>INTERVIEW</span>
                                    </li>
                                    <li v-if="artistwork.artistworkCount > 0" :class="[{current : brand_tap == 'artistwork'}]" @click="brand_tap_change('artistwork')">
                                        <span>ARTIST WORK</span>
                                    </li>
                                    <li v-if="lookbook_master.length > 0" :class="[{current : brand_tap == 'lookbook'}]" @click="brand_tap_change('lookbook')">
                                        <span>LOOKBOOK</span>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
    
                <div class="snsAreaV15">
                    <div class="snsBoxV15">
                        <dl>
                            <dt>공유</dt>
                            <dd>
                                <ul>
                                    <li class="twitter"><a href="#" @click="click_sns('tw')" ><span></span>트위터</a></li>
                                    <li class="facebook"><a href="#" @click="click_sns('fb')"><span></span>페이스북</a></li>
                                    <li class="pinterest"><a href="#" @click="click_sns('pt')"><span></span>핀터레스트</a></li>
                                </ul>
                            </dd>
                        </dl>
                        <div :class="{zzimBrOff : check_is_zzim('off'), zzimBrOn : check_is_zzim('on')}" @click="click_zzim"><strong>{{street_zzim_count}}</strong></div><!-- for dev msg : div 태그에 로그인 후 zzimBrOff 클래스 추가 / 찜브랜드 등록 후 zzimBrOn 클래스 변경 되게 해주세요 -->
                    </div>
                </div>
    
                <div class="brandSection">
                    <BRAND-HELLO v-if="street_hello" :street_hello="street_hello"/>
    
                    <!-- SHOP -->
                    <div v-show="brand_tap == 'shop'" class="brandShopV15">
                        <div class="titleWrap line">
                            <ul class="navigator">
                                <li class="nav1"><a href="javascript:void(0)" class="on"><em>SHOP</em> <strong>({{total_count}})</strong></a></li>
                            </ul>
                            <p v-if="brand_info.defaultFreeBeasongLimit > 0" class="delivery fs11"><strong>[배송안내]</strong> {{brand_info.brand_name_kr}} 상품 <span class="cRd0V15">{{number_format(brand_info.defaultFreeBeasongLimit)}} 이상</span> 구매 시 무료배송 (배송비 2,500원)</p>
                        </div>
                        <!-- shop -->
                        <div class="article">
                            <h4>SHOP</h4>
                            <!-- BEST ITEM, EVENT -->
                            <div class="shopBestPrdV15">
                                <!-- best item -->
                                <div class="bestItemV15">
                                    <div class="pdtWrap pdt200V15">
                                        <ul class="pdtList awardList bestAwd">
                                            <BEST-PRODUCT v-for="(item, index) in best_product" :key="index" @go_product_detail="go_product_detail" :index="index" :product="item" />
                                        </ul>
                                    </div>
                                </div>
                                <!--// best item -->
    
                                <!-- event -->
                                <div class="shopEventV15" style="display:none;">
                                    <!-- or dev msg : 이벤트 있을 경우 -->
                                    <div class="relatedEventV15">
                                        <h5>RELATED EVENT</h5>
                                        <div class="enjoyEvent">
                                            <div class="evtItem">
                                                <a href="">
                                                    <p class="pic"><span class="frame"></span><img src="http://fiximage.10x10.co.kr/web2013/@temp/pdt12_200x200.jpg" alt="DESIGN FILTER"></p>
                                                    <div class="evtProd">
                                                        <p class="pdtStTag">
                                                            <img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT">
                                                        </p>
                                                        <p class="evtTit">우리집 공간 활용법 우리집 공간 활용법 우리집 공간 활용법...</p>
                                                        <p class="evtExp">작은 공간 활용으로 특별한 우리집 만들기 우리집 만들기! [20%]...</p>
                                                    </div>
                                                </a>
                                            </div>
                                            <div class="evtItem">
                                                <a href="">
                                                    <p class="pic"><span class="frame"></span><img src="http://fiximage.10x10.co.kr/web2013/@temp/pdt10_200x200.jpg" alt="DESIGN FILTER"></p>
                                                    <div class="evtProd">
                                                        <p class="pdtStTag">
                                                            <img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT">
                                                        </p>
                                                        <p class="evtTit">두번째 이벤트</p>
                                                        <p class="evtExp">특별한 우리집 만들기! [20%]</p>
                                                    </div>
                                                </a>
                                            </div>
                                        </div>
                                        <div class="count"><strong>1</strong>/<span></span></div>
                                    </div>
    
                                    <!-- for dev msg : 이벤트 없을 경우 -->
                                    <div class="noEvt" style="display:none;">
                                        <p><img src="http://fiximage.10x10.co.kr/web2013/brand/txt_event_no.png" alt="해당되는 이벤트가 없습니다."></p>
                                        <p class="tPad10">기분 좋은 쇼핑이 될 수 있도록<br />정성을 다하겠습니다.</p>
                                    </div>
                                </div>
                                <!--// event -->
                            </div>
                            <!--// BEST ITEM, EVENT -->
    
                            <!-- 카테고리 탭 선택시 노출 -->
                            <div class="shopViewCtgy">
                                <CATEGORY-FILTER :cate_filter="cate_filter" :checked_cate_filter="checked_cate_filter" @go_cate_search="go_page" @update_cate_filter="update_cate_filter"/>
    
                                <!-- for dev msg : 카테고리 리스트와 동일합니다. -->
                                <div class="ctgyWrapV15">
                                    <div class="pdtFilterWrap tMar50"><!-- for dev msg : 기존 클래스명 tMar40에서 tMar50 으로 변경되었습니다. -->
                                        <div class="tabWrapV15"><!-- for dev msg : 기존 클래스명 변경되었습니다. -->
                                            <ul class="sortingTabV15"><!-- for dev msg : 기존 클래스명 변경되었습니다. -->
                                                <li :class="{selected: parameter.group_type === 'n'}" @click="change_group('n')">
                                                    <strong>ALL</strong><span>({{search_data.all_count}})</span><!-- for dev msg : 기존 p태그에서 strong 태그로 변경되었습니다. -->
                                                </li>
                                                <li :class="{selected: parameter.group_type === 'sc'}" @click="change_group('sc')">
                                                    <strong>SALE</strong><span>({{search_data.sale_count}})</span>
                                                </li>
                                                <li :class="{selected: parameter.group_type === 'fv'}" @click="change_group('fv')">
                                                    <strong>WISH</strong><span>({{search_data.wish_count}})</span>
                                                </li>
                                            </ul>
    
                                            <ul class="dFilterTabV15"><!-- for dev msg : 기존 감싸고 있던 dl, dt, dd 태그 삭제되고 ul만 유지됩니다. / 기존 클래스명 변경되었습니다. -->
                                                <li @click="select_filter('color')" :class="['tabColor', {selected: active_filter==='color'}]"><p>컬러</p></li>
                                                <li @click="select_filter('style')" :class="['tabStyle', {selected: active_filter==='style'}]"><p>스타일</p></li>
                                                <li @click="select_filter('price')" :class="['tabPrice', {selected: active_filter==='price'}]"><p>가격</p></li>
                                                <li @click="select_filter('delivery')" :class="['tabDelivery', {selected: active_filter==='delivery'}]"><p>배송</p></li>
                                                <li @click="select_filter('keyword')" :class="['tabSearch', {selected: active_filter==='keyword'}]"><p>검색</p></li>
                                            </ul>
                                        </div>
    
                                        <div v-show="active_filter !== ''" class="dFilterWrap">
                                            <div class="filterSelect">
                                                <div v-show="active_filter === 'color'" class="ftColor" id="fttabColor">
                                                    <ul class="colorchipV15"><!-- for dev msg : 기존 클래스명 변경되었습니다./아래 체크박스 감싸는 p 태그 추가되었습니다. -->
                                                        <COLOR v-for="item in filter_data.colors" @select_color="select_color"
                                                            :color_code="item.code" :color_name="item.name" :select_yn="item.select_yn"/>  
                                                    </ul>
                                                </div>
                                                <div v-show="active_filter === 'style'" class="ftStyle" id="fttabStyle">
                                                    <ul>
                                                        <STYLE v-for="item in filter_data.styles" @select_style="select_style"
                                                            :style_code="item.code" :style_name="item.name" :select_yn="item.select_yn"/>
                                                    </ul>
                                                </div>
                                                
                                                <PRICE v-show="active_filter === 'price'" ref="price" @change_filter_price="change_filter_price"
                                                        :bar_min_price="search_data.min_price" :bar_max_price="search_data.max_price"
                                                        :search_min_price="filter_data.min_price" :search_max_price="filter_data.max_price"/>
                                                        
                                                <div v-show="active_filter === 'delivery'" class="ftDelivery" id="fttabDelivery">
                                                    <ul>
                                                        <DELIVERY v-for="(item, index) in filter_data.deli_type" @select_delivery="select_delivery" 
                                                            :index="index" :delivery="item" :select_yn="item.select_yn"/>
                                                    </ul>
                                                </div>
                                                <div v-show="active_filter === 'keyword'" class="ftSearch" id="fttabSearch">
                                                    <input type="text" :value="keyword" style="width:400px" class="ftSearchInput" @input="input_keyword" />
                                                    <input type="image" src="http://fiximage.10x10.co.kr/web2015/common/btn_add.png" alt="키워드 검색">
                                                </div>
                                            </div>                                            
                                        </div>
                                        
                                        <div v-show="exist_active_filter_yn" class="dFilterResult">
                                            <dl>
                                                <dt class="resultTit">필터</dt>
                                                <dd class="resultCont">
                                                    <dl v-for="item in active_filters" v-if="item.items.length > 0">
                                                        <dt>{{item.name}}</dt>
                                                        <dd v-for="item2 in item.items">
                                                            {{item2.name}}
                                                            <img @click="delete_filter(item.type, item2.code)" alt="Delete" class="deleteBtn"
                                                                src="http://fiximage.10x10.co.kr/web2013/common/btn_delete.gif">
                                                        </dd>
                                                    </dl>
                                                </dd>
                                            </dl>
                                            <p class="btnSltSearch">
                                                <a :href="clear_uri" class="btn btnS1 btnWhite btnW80">초기화</a>
                                                <a @click="go_page()" class="btn btnS1 btnRed btnW80">검색</a>
                                            </p>
                                        </div>
                                        <span v-show="active_filter !== ''" @click="select_filter('')" class="filterLyrClose">
                                            <img src="http://fiximage.10x10.co.kr/web2013/common/btn_close.gif" alt="Layer Close">
                                        </span>
                                    </div>
                                    
    
                                    <div class="overHidden tPad15">
                                        <div class="ftRt" style="width:140px;">
                                            <select @change="change_sort_method" name="srm" class="ftLt optSelect" title="옵션을 선택하세요">
                                                <option value="new" :selected="parameter.sort_method === 'new'">신상품순</option>
                                                <option value="best" :selected="parameter.sort_method === 'best'">인기상품순</option>
                                                <option value="lp" :selected="parameter.sort_method === 'lp'">낮은가격순</option>
                                                <option value="hp" :selected="parameter.sort_method === 'hp'">높은가격순</option>
                                                <option value="hs" :selected="parameter.sort_method === 'hs'">높은할인율순</option>
                                            </select>
                                            <ul class="pdtView"><!-- for dev msg : 이미지 사이즈별 보기는 리뷰, 포토리뷰 리스트에서는 노출 안됩니다. -->
                                                <li :class="['view02', {current: parameter.view_type === 'M'}]" data-type="M" data-size="40">
                                                    <a @click="change_view_type" title="중간이미지" style="cursor: pointer;">중간 이미지로 보기</a>
                                                </li>
                                                <li :class="['view03', {current: parameter.view_type === 'S'}]" data-type="S" data-size="72">
                                                    <a @click="change_view_type" title="작은이미지" style="cursor: pointer;">작은 이미지로 보기</a>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
    
                                    <!-- list -->
                                    <div :class="['pdtWrap', {pdt200V15 : parameter.view_type == 'M'}, {pdt150V15 : parameter.view_type == 'S'}]"><!-- for dev msg : 이미지 사이즈별 클래스 적용(pdt240V15/pdt200V15/pdt150V15)-->
                                        <ul class="pdtList">
                                            <PRODUCT-BASIC v-for="(item, index) in search_data.items" :key="index" @go_product_detail="go_product_detail" :index="index" :product="item" />
                                        </ul>
                                    </div>
                                    
                                    <!-- 검색결과 없음 -->
                                    <div v-if="search_data.items == null" class="ct" style="padding:150px 0;">
                                        <p style="font-family:'malgun gothic', '맑은고딕', dotum, '돋움', sans-serif; font-size:21px; color:#000;">
                                            <strong>흠... <span class="cRd0V15">조건에 맞는 상품</span>이 없습니다.</strong>
                                        </p>
                                        <p class="tPad10">Filter 조건 선택해제 후, 다시 원하시는 조건을 선택해 주세요.<p>
                                        <p>일시적으로 상품이 품절일 경우 검색되지 않습니다.</p>
                                    </div>

                                    <!-- paging -->
                                    <PAGE @move_page="change_page" :show_item_count="show_page_count" :current_page="parameter.page" :total_item_count="search_data.all_count"/>
                                </div>
                            </div>
                            <!-- //카테고리 탭 선택시 노출 -->
                        </div>
                        <!-- //shop -->
                    </div>
                    <!-- //SHOP -->                  
                    
                    <!-- INTERVIEW -->
                    <div v-show="brand_tap == 'interview'" class="interview" id="section02" >
                        <div class="wFix">
                            <h4 class="line"><img src="http://fiximage.10x10.co.kr/web2013/brand/tit_interview.gif" alt="INTERVIEW" /></h4>
                            <div class="interviewList">
                                <div v-for="(item, index) in interview" class="interviewCont">
                                    <img :src="item.detailimg" alt="NEWEST DESIGNER!" usemap="#interviewmap1"/>
                                    <div v-html="item.detailimglink"></div>
                                </div>
                                
                                <button type="button" class="prevBtn">Prev</button>
                                <button type="button" class="nextBtn">Next</button>
                            </div>
                        </div>
                    </div>
                    <!-- //INTERVIEW -->
                    
                    <!-- ARTISTWORK -->
                    <div v-if="brand_tap == 'artistwork'" class="artistWork" id="section04">
                        <div class="wFix">
                            <h4><img src="http://fiximage.10x10.co.kr/web2013/brand/tit_artistwork.gif" alt="ARTIST WORK" /></h4>
                            
                               <ARTIST-WORK :artistwork="artistwork" />
                        </div>
                    </div>
                    <!-- //ARTISTWORK -->
                    
                    <!-- LOOKBOOK -->
                    <div v-show="brand_tap == 'lookbook'" class="lookbook" id="section06">
                        <LOOK-BOOK :lookbook_master="lookbook_master" :active_lookbook="lookbook_data.active_lookbook" 
                            :lookbook_detail="lookbook_data.detail"
                            @update_lookbook_detail="update_lookbook_detail" @update_active_lookbook="update_active_lookbook"
                        />
                    </div>
                    <!-- LOOKBOOK -->
                </div>
            </div>
		</div>
    `,
    data(){
        return {
            brand_tap : "shop"
            , active_filter : ''
        }
    }
    , created() {
        const _this = this;
        let uri = window.location.href.split('?');
        let left_param;
        if (uri.length == 2){
            let vars = uri[1].split('&');
            let getVars = {};
            let tmp = '';
            vars.forEach(function(v){
                tmp = v.split('=');
                if(tmp.length == 2){
                    getVars[tmp[0]] = tmp[1];
                    if(tmp[0] == 'makerid'){
                        _this.brand_id = tmp[1]
                    }
                }
            });

            left_param = vars.slice(1);
        }
        this.$store.commit('SET_PARAMETER', parameter);

        this.$store.dispatch("GET_BRAND_INFO", this.brand_id);
        this.$store.dispatch("GET_BRAND_PRODUCT", {"brand_id" : this.brand_id, "query_string": "&" + left_param.join("&")});

        let group_type = '';
        if(this.parameter.group_type == "sc"){
            group_type += `&sale_yn=true`
        }else if(this.parameter.group_type == "fv"){
            group_type += `&have_wish_yn=true`
        }

        this.$store.dispatch("GET_BRAND_FILTER", {"brand_id" : this.brand_id, "query_string": group_type});
    }
    , computed : {
        brand_info(){
            return this.$store.getters.brand_info;
        }
        , my_zzim() {
            return this.$store.getters.my_zzim;
        }
        , street_hello(){
            return this.$store.getters.street_hello;
        }
        , is_zzim(){
            return this.$store.getters.is_zzim;
        }
        , street_zzim_count(){
            return this.$store.getters.street_zzim_count;
        }
        , best_product(){
            return this.$store.getters.best_product;
        }
        , total_count(){
            return this.$store.getters.total_count;
        }
        , cate_filter(){
            return this.$store.getters.cate_filter;
        }
        , checked_cate_filter(){
            return this.$store.getters.checked_cate_filter;
        }
        , ctgyBg(){
            if(this.street_hello && this.street_hello.bgImageURL){
                return null;
            }else{
                return "ctgyBg04";
            }
        }
        , search_data(){
            return this.$store.getters.search_data;
        }
        , interview(){
            return this.$store.getters.interview;
        }
        , artistwork(){
            return this.$store.getters.artistwork;
        }
        , lookbook_master(){
            return this.$store.getters.lookbook_master;
        }
        , lookbook_data() {
            return this.$store.getters.lookbook_data;
        }

        /*default*/
        , parameter() { return this.$store.getters.parameter; }
        , show_page_count() {
            return this.parameter.view_type === 'M' ? 40 : 72;
        }
        , filter_data(){
            return this.$store.getters.filter_data;
        }
        , active_filters() {
            const active_filters = [
                {'type' : 'color', 'name' : '컬러', 'items' : []}
                , {'type' : 'style', 'name' : '스타일', 'items' : []}
                , {'type' : 'price', 'name' : '가격', 'items' : []}
                , {'type' : 'delivery', 'name' : '배송', 'items' : []}
                , {'type' : 'keyword', 'name' : '키워드', 'items' : []}
            ];

            this.filter_data.colors.forEach(e => {
                if( e.select_yn && e.code !== '000' ) {
                    active_filters[0].items.push({
                        'code' : e.code,
                        'name' : e.name
                    });
                }
            });

            this.filter_data.styles.forEach(e => {
                if( e.select_yn && e.code !== '000' ) {
                    active_filters[1].items.push({
                        'code' : e.code,
                        'name' : e.name
                    });
                }
            });

            if( this.filter_data.min_price !== this.search_data.min_price
                || this.filter_data.max_price !== this.search_data.max_price ) {
                active_filters[2].items[0] = {
                    'code' : `${this.filter_data.min_price},${this.filter_data.max_price}`,
                    'name' : `${this.number_format(this.filter_data.min_price)}원 ~ ${this.number_format(this.filter_data.max_price)}원`
                };
            }

            const active_delivery = this.filter_data.deli_type.find(e => e.select_yn);
            if( active_delivery !== undefined && active_delivery.code !== '' ) { // 전체가 아니면
                active_filters[3].items[0] = {
                    'code' : active_delivery.code,
                    'name' : active_delivery.name
                };
            }

            if( this.keyword.length > 0 ) {
                active_filters[4].items[0] = {
                    'code' : this.keyword,
                    'name' : this.keyword
                };
            }

            return active_filters;
        }
        , keyword() { return this.$store.getters.keyword; }
        , clear_uri() {
            return `?makerid=${this.brand_info.brand_id}`
                + `&group_type=${this.parameter.group_type}`
                + `&sort_method=${this.parameter.sort_method}`;
        }
        , exist_active_filter_yn() {
            const p = this.parameter;

            let active_filter_flag = this.active_filters.find(e => e.items.length > 0)
                || p.colors.length > 0 || p.styles.length > 0 || p.deli_type.length > 0
                || (p.max_price !== '' && !isNaN(p.max_price))
                || (p.min_price !== '' && !isNaN(p.min_price));

            return active_filter_flag;
        }
    }
    , methods : {
        go_zzim_brand(event){
            location.href="/biz/brand.asp?brand_id=" + event.target.value;
        }
        , click_sns(sns){
            if(sns == "tw"){
                popSNSPost("tw", this.brand_info.popSNSPost, "10x10.co.kr/biz/brand.asp?brand_id=" + this.brand_info.brand_name_en, '텐바이텐', "#10x10", '');
            }else if(sns == "fb"){
                popSNSPost("fb", this.brand_info.popSNSPost, "10x10.co.kr/biz/brand.asp?brand_id=" + this.brand_info.brand_name_en, '', "", '');
            }else if(sns == "pt"){
                popSNSPost("pt", this.brand_info.popSNSPost, "10x10.co.kr/biz/brand.asp?brand_id=" + this.brand_info.brand_name_en, '', "", '');
            }
        }
        , check_is_zzim(classType){
            if(classType == 'off'){
                if(this.is_zzim > 0){
                    return false;
                }else{
                    return true;
                }
            }else{
                if(this.is_zzim > 0){
                    return true;
                }else{
                    return false;
                }
            }
        }
        , go_product_detail(index, product) {
            /*fnAmplitudeEventMultiPropertiesAction('click_category_list_product'
                , 'item_index|sort|category_code|category_depth|itemid|category_name|brand_name|list_style'
                , `${index}|${this.parameter.sort}|${this.category_info.category_code}|${this.category_info.category_depth}`
                + `|${product.item_id}|${this.category_info.category_name}|${product.brand_name}|${this.parameter.view_type}`);*/

            location.href = product.move_url;
        }
        , update_cate_filter(data){
            this.$store.commit("UPDATE_CHECKED_CATE", data);
        }
        , brand_tap_change(data){
            this.brand_tap = data;
        }
        , update_lookbook_detail(data){
            this.$store.dispatch("GET_BRAND_LOOKBOOK_DETAIL", data);
        }
        , update_active_lookbook(data){
            this.$store.commit("UPDATE_LOOKBOOK_ACTIVE", data);
        }

        /*Default*/
        , change_page(page) {
            this.go_page([{'name' : 'page', 'value' : page}]);
        }
        , go_page(changed_parameters) {
            // 기본 파라미터(그룹유형, 정렬기준, 품절상품제외여부, 뷰타입, 페이지)
            const basic_parameter = {
                "brand_id" : this.brand_info.brand_id
                , 'page' : this.parameter.page
                , "page_size" : this.show_page_count
                , "sort_method" : this.parameter.sort_method
                , "view_type" : this.parameter.view_type
                , "group_type" : this.parameter.group_type
            };

            if( changed_parameters !== undefined ) {
                changed_parameters.forEach(p => basic_parameter[p.name] = p.value);
            }
            //this.$store.commit('UPDATE_PAGE', basic_parameter.page);
            //this.$store.commit('UPDATE_PRAMETER_VIEWTYPE', basic_parameter.view_type);

            let url = `?makerid=${basic_parameter.brand_id}`
                + `&page=${basic_parameter.page}`
                + `&page_size=${basic_parameter.page_size}`
                + `&view_type=${basic_parameter.view_type}`
                + `&sort_method=${basic_parameter.sort_method}`
                + `&group_type=${basic_parameter.group_type}`
            ;

            // 필터
            const colors = this.active_filters[0];
            if( colors.items.length > 0 ) {
                const color_codes = [];
                colors.items.forEach(item => color_codes.push(item.code));
                url += '&colors=' + color_codes.join(',');

                //this.$store.commit('UPDATE_PRAMETER_COLORS');
            }

            const styles = this.active_filters[1];
            if( styles.items.length > 0 ) {
                const style_codes = [];
                styles.items.forEach(s => style_codes.push(s.code));
                url += '&styles=' + style_codes.join(',');

                //this.$store.commit('UPDATE_PRAMETER_STYLES');
            }

            const prices = this.active_filters[2];
            if( prices.items.length > 0 ) {
                const price_arr = prices.items[0].code.split(',');
                url += `&min_price=${price_arr[0]}&max_price=${price_arr[1]}`;

                //this.$store.commit('UPDATE_PRAMETER_PRICE', price_arr);
            }

            const delivery = this.active_filters[3];
            if( delivery.items.length > 0 ) {
                url += `&deli_type=${delivery.items[0].code}`;

                //this.$store.commit('UPDATE_PRAMETER_DELI');
            }

            const keyword = this.active_filters[4];
            if( keyword.items.length > 0) {
                url += `&keyword=${keyword.items[0].code}`;

                //this.$store.commit('UPDATE_PRAMETER_KEYWORD');
            }

            const checked_cate_filter = this.checked_cate_filter;
            if(checked_cate_filter.length > 0){
                const cate = [];
                checked_cate_filter.forEach(item => cate.push(item));

                url += `&disp_categories=${checked_cate_filter}`
            }

            const group_type = basic_parameter.group_type;
            if(group_type == 'n'){

            }else if(group_type == "sc"){
                url += `&sale_yn=true`
            }else if(group_type == "fv"){
                url += `&have_wish_yn=true`
            }

            location.href = url;

            /*this.$store.commit('UPDATE_PRAMETER_GROUPTYPE', group_type);
            this.$store.dispatch("GET_BRAND_PRODUCT", {"brand_id" : this.brand_id, "query_string" : url});*/
        }
        , select_color(select_yn, code) {
            if( select_yn )
                this.$store.commit('ADD_FILTER_COLOR', code);
            else
                this.$store.commit('DEL_FILTER_COLOR', code);
        }
        , select_style(select_yn, code) {
            if( select_yn )
                this.$store.commit('ADD_FILTER_STYLE', code);
            else
                this.$store.commit('DEL_FILTER_STYLE', code);
        }
        , change_filter_price(min, max) {
            this.$store.commit('SET_FILTER_PRICE', {min:min, max:max});
        }
        , select_filter(type) {
            if( this.active_filter === type ) {
                this.active_filter = '';
            } else {
                // 가격필터의 경우 펼칠 때 가격 슬라이더 생성
                if( type === 'price' ) {
                    this.$refs.price.create_slider();
                }
                this.active_filter = type;
            }
        }
        , delete_filter(type, code) {
            switch (type) {
                case 'color': this.select_color(false, code); break;
                case 'style': this.select_style(false, code); break;
                case 'price':
                    this.change_filter_price(this.search_data.min_price, this.search_data.max_price);
                    this.$refs.price.clear();
                    break;
                case 'delivery': this.select_delivery(''); break;
                case 'keyword': this.delete_keyword(); break;
            }
        }
        , select_delivery(code) {
            this.$store.commit('SET_FILTER_DELIVERY', code);
        }
        , delete_keyword() {
            this.$store.commit('SET_KEYWORD', '');
        }
        , input_keyword(e) {
            this.$store.commit('SET_KEYWORD', e.target.value);
        }
        , change_sort_method(e) {
            this.go_page([
                {'name' : 'sort_method', 'value' : e.target.value}
                , {'name' : 'page', 'value' : 1}
            ]);
        }
        , change_view_type(e) {
            this.go_page([
                {'name' : 'view_type', 'value' : e.target.parentElement.dataset.type}
                , {'name' : 'page_size', 'value' : e.target.parentElement.dataset.size}
                , {'name' : 'page', 'value' : 1}
            ]);
        }
        , change_group(type) {
            this.go_page([
                {'name' : 'group_type', 'value' : type}
                , {'name' : 'page', 'value' : 1}
            ]);
        }
        , click_zzim(){
            const _this = this;

            if(this.check_is_zzim("on")){
                call_api("post", "/b2b/pc/home/brand-info", {"makerid": this.brand_info.brand_id, "update_type" : "cancel"}, data => {
                    _this.$store.commit("SET_IS_ZZIM", 0);
                    _this.$store.commit("UPDATE_STREET_ZZIM_COUNT", "cancel");
                });
            }else{
                call_api("post", "/b2b/pc/home/brand-info", {"makerid": this.brand_info.brand_id, "update_type" : "add"}, data => {
                    _this.$store.commit("SET_IS_ZZIM", 1);
                    _this.$store.commit("UPDATE_STREET_ZZIM_COUNT", "add");
                });
            }
        }
    }
});