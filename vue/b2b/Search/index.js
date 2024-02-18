const app = new Vue({
    el: '#app',
    store : store,
    mixin : [common_mixin],
    template : `
        <div id="contentWrap">
            <template v-if="count_info.all > 0">
                <!-- 검색 총 결과 수 -->
                <div class="search-result-noti">
                    <p>
                        <span class="icon-sech">
                            <img src="http://fiximage.10x10.co.kr/web2021/biz/icon_search.png" alt="검색">
                        </span>
                        <span>{{number_format(count_info.all)}}</span>건의 상품을 찾아냈어요!
                    </p>
                </div>
                
                <!-- 카테고리, 브랜드 검색 -->
                <ul id="lyrSchExpTab" class="schTabV15">
                    <li @click="active_tab = 'category'" :class="['tabCtgy', {current: active_tab === 'category'}]">
                        <p>
                            <strong>ITEM</strong>
                            <span>({{number_format(total_item_count)}})</span>
                        </p>
                    </li>
                    <li @click="active_tab = 'brand'" :class="['tabBrand', {current: active_tab === 'brand'}]">
                        <p>
                            <strong>브랜드</strong>
                            <span>({{brand_filters.length}})</span>
                        </p>
                    </li>
                </ul>
                <div class="schDetailBoxV15">
                    <!-- 카테고리 -->
                    <div v-show="active_tab === 'category'" class="lyrTabV15">
                        <div class="schCateV15">
                            <table>
                                <colgroup><col width="225"/><col width=""/></colgroup>
                                <tbody>
                                    <CATEGORY-FILTER v-for="(category,index) in category_filters"
                                        v-if="category.low_categories.length > 0"
                                        v-show="index === 0 || show_category_filter"
                                        :ref="'category_filter_' + category.category_code" @click_category="click_category"
                                        @changed_categories="set_active_category_filter"
                                        :parameter_categories="parameter.disp_categories"
                                        :category_code="category.category_code" :category_name="category.category_name"
                                        :item_count="category.item_count" :low_categories="category.low_categories" />
                                </tbody>
                            </table>
                        </div>
                        <p v-if="category_filters.length > 1" @click="toggle_filter('category')" :class="['schMoreViewV15', {folderOffV15 : show_category_filter}]">더보기</p>
                    </div>
                    
                    <!-- 브랜드 -->
                    <div v-show="active_tab === 'brand'" class="lyrTabV15" id="lyrBrandV15">
                        <dl v-if="best_brand_filters.length > 0" class="schBestBrV15">
                            <dt><img src="http://fiximage.10x10.co.kr/web2015/common/tit_best_brand.gif" alt="BEST BRAND" /></dt>
                            <dd>
                                <span v-for="brand in best_brand_filters">
                                    <a :href="'/street/street_brand.asp?makerid=' + brand.brand_id" target="_blank">
                                        <strong>{{brand.brand_name}}</strong> ({{number_format(brand.item_count)}})
                                    </a>
                                </span>
                            </dd>
                        </dl>
                        <div class="schBrListV15">
                            <ul>
                                <BRAND-FILTER v-for="(brand,index) in brand_filters" 
                                    v-show="index < 10 || show_brand_filter"
                                    @click_brand="click_brand" @check_brand="set_active_brand_filter"
                                    :brand="brand" :brand_ids="active_brand_filter"/>
                            </ul>
                        </div>
                        <p @click="toggle_filter('brand')" :class="['schMoreViewV15', {folderOffV15 : show_brand_filter}]">더보기</p>
                    </div>
                </div>
                
                <div class="tPad05 rt">
                    <a :href="clear_uri" v-show="active_category_filter.length > 0 || active_brand_filter.length > 0" class="btn btnS2 btnGry">선택 초기화</a>
                    <a @click="go_category_brand_filter" class="btn btnS2 btnRed">선택 조건 검색</a>
                </div>
                
                <!-- 상품 영역 -->
                <div v-if="count_info.all > 0" class="ctgyWrapV15">
                    <div class="pdtFilterWrap tMar50">
                        <div class="tabWrapV15">
                            <ul class="sortingTabV15">
                                <li :class="{selected: parameter.group_type === 'n'}" @click="change_group('n')">
                                    <strong>ALL</strong><span>({{number_format(count_info.all)}})</span>
                                </li>
                                <li :class="{selected: parameter.group_type === 'sc'}" @click="change_group('sc')">
                                    <strong>SALE</strong><span>({{number_format(count_info.sale)}})</span>
                                </li>
                                <li :class="{selected: parameter.group_type === 'fv'}" @click="change_group('fv')">
                                    <strong>WISH</strong><span>({{number_format(count_info.wish)}})</span>
                                </li>
                                <li :class="['wrappingV15a', {selected: parameter.group_type === 'pk'}]" @click="change_group('pk')">
                                    <i></i><strong>WRAPPING</strong><span>({{number_format(count_info.wrapping)}})</span>
                                </li>
                            </ul>
    
                            <ul class="dFilterTabV15">
                                <li @click="select_filter('color')" :class="['tabColor', {selected: active_filter==='color'}]"><p>컬러</p></li>
                                <li @click="select_filter('style')" :class="['tabStyle', {selected: active_filter==='style'}]"><p>스타일</p></li>
                                <li v-if="filter_price.max > 0" @click="select_filter('price')" :class="['tabPrice', {selected: active_filter==='price'}]"><p>가격</p></li>
                                <li @click="select_filter('delivery')" :class="['tabDelivery', {selected: active_filter==='delivery'}]"><p>배송</p></li>
                            </ul>
                        </div>
                        
                        <!-- 선택한 필터 펼침 영역 -->
                        <div v-show="active_filter !== ''" class="dFilterWrap">
                            <div class="filterSelect">
                                <!-- 색상 -->
                                <div v-show="active_filter === 'color'" class="ftColor">
                                    <ul class="colorchipV15">
                                        <COLOR v-for="color in colors" @select_color="select_color"
                                            :color_code="color.code" :color_name="color.name" :select_yn="color.select_yn"/>
                                    </ul>
                                </div>
        
                                <!-- 스타일 -->
                                <div v-show="active_filter === 'style'" class="ftStyle" id="fttabStyle">
                                    <ul>
                                        <STYLE v-for="style in styles" @select_style="select_style"
                                            :style_code="style.code" :style_name="style.name" :select_yn="style.select_yn"/>
                                    </ul>
                                </div>
        
                                <!-- 가격 -->
                                <PRICE ref="price" v-if="filter_price.max > 0" v-show="active_filter === 'price'" @change_filter_price="change_filter_price"
                                    :bar_min_price="item_price_info.min" :bar_max_price="item_price_info.max"
                                    :search_min_price="filter_price.min" :search_max_price="filter_price.max"/>
        
                                <!-- 배송 -->
                                <div v-show="active_filter === 'delivery'" class="ftDelivery" id="fttabDelivery">
                                    <ul>
                                        <DELIVERY v-for="(delivery, index) in deliveries" @select_delivery="select_delivery" 
                                            :index="index" :delivery="delivery" :select_yn="delivery.select_yn"/>
                                    </ul>
                                </div>
                            </div>
                            
                            <!-- 필터 닫기 버튼 -->
                            <span v-show="active_filter !== ''" @click="select_filter('')" class="filterLyrClose">
                                <img src="http://fiximage.10x10.co.kr/web2013/common/btn_close.gif" alt="Layer Close" />
                            </span>
                            
                        </div>
                        
                        <!-- 현재 활성화 필터 -->
                        <div v-show="exist_active_filter_yn" class="dFilterResult">
                            <dl>
                                <dt class="resultTit">필터</dt>
                                <dd class="resultCont" id="lyrSearchFilter">
                                    <dl v-for="filter in active_filters" v-if="filter.items.length > 0">
                                        <dt>{{filter.name}}</dt>
                                        <dd v-for="item in filter.items">
                                            {{item.name}}
                                            <img @click="delete_filter(filter.type, item.code)" alt="Delete" class="deleteBtn"
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
                        
                    </div>
                    
                    <!-- 정렬, 품절상품제외여부, 뷰타입 -->
                    <div class="overHidden tPad15">
                        <div class="ftRt" style="width:220px;">
                            <select @change="change_sort_method" class="ftLt optSelect" title="배송구분 옵션을 선택하세요" style="height:18px;">
                                <option value="ne" :selected="parameter.sort_method === 'ne'">신상품순</option>
                                <option value="bs" :selected="parameter.sort_method === 'bs'">판매량순</option>
                                <option value="be" :selected="parameter.sort_method === 'be'">인기상품순</option> <!-- 위시그룹 선택상태면 인기위시순 -->
                                <option value="lp" :selected="parameter.sort_method === 'lp'">낮은가격순</option>
                                <option value="hp" :selected="parameter.sort_method === 'hp'">높은가격순</option>
                                <option value="hs" :selected="parameter.sort_method === 'hs'">높은할인율순</option>
                            </select>
                            <a @click="change_except_sold_out_yn" class="lMar20 ftLt btn btnS3 btnGry fn">{{parameter.except_sold_out_yn ? '- 품절상품 제외' : '+ 품절상품 포함'}}</a>
                        </div>
                    </div>
                    
                    <!-- 상품 리스트 -->
                    <div class="section">
                        <!-- 중간이미지: pdt240V15, 작은이미지: pdt150V15 -->
                        <div v-if="products != null && products.length > 0" class="pdtWrap pdt240V15">
                            <ul class="pdtList">
        
                                <PRODUCT-BASIC v-for="(product, index) in products"
                                    @go_product_detail="go_product_detail"
                                    :index="index" :product="product"/>
        
                            </ul>
                        </div>
                        
                        <!-- 페이지 -->
                        <PAGE v-if="products != null && products.length > 0" @move_page="change_page" 
                            :show_item_count="40" :current_page="parameter.page" :total_item_count="current_group_item_count"/>
        
                    </div>
                </div>
            </template>
            
            
            <div v-else-if="search_complete_yn" class="nodata-search">
                <p><b>{{parameter.keyword}}</b> 검색결과가 없습니다.</p>
                <p>해당상품이 품절 되었을 경우 검색이 되지 않습니다.</p>
            </div>
        </div>
    `,
    data() {return {
        active_filter : '', // 활성화 중인 필터
        active_tab : 'category', // 활성화 중인 카테고리,브랜드 탭
        active_category_filter : [], // 활성화 중인 카테고리 코드 필터
        active_brand_filter : [], // 활성화 중인 브랜드ID 필터
        show_category_filter : false, // 카테고리 필터 펼침 여부
        show_brand_filter : false, // 브랜드 필터 펼침 여부
    }},
    created() {
        // SET 초기 파라미터
        this.$store.commit('SET_PARAMETER', parameter);
        // GET 필터 카테고리 목록
        this.$store.dispatch('GET_CATEGORY_FILTERS');
        // GET 필터 브랜드 목록
        this.$store.dispatch('GET_BRAND_FILTERS');
        // GET 카테고리 상품관련 정보
        this.$store.dispatch('GET_PRODUCTS_INFO');
    },
    mounted() {
        this.parameter.brand_ids.forEach(b => this.active_brand_filter.push(b));
        // 브랜드 필터로 검색했을 때 브랜드 탭 활성화
        if( this.parameter.brand_ids.length > 0 ) {
            this.active_tab = 'brand';
        }
    },
    computed : {
        // 현재 파라미터
        parameter() { return this.$store.getters.parameter; },
        // 그룹별 상품 수 정보
        count_info() { return this.$store.getters.count_info; },
        // 상품 리스트
        products() { return this.$store.getters.products; },
        // 카테고리 필터 리스트
        category_filters() { return this.$store.getters.category_filters; },
        // 베스트 브랜드 필터 리스트
        best_brand_filters() { return this.$store.getters.best_brand_filters; },
        // 브랜드 필터 리스트
        brand_filters() { return this.$store.getters.brand_filters; },
        // 필터 - 컬러
        colors() { return this.$store.getters.colors; },
        // 필터 - 스타일
        styles() { return this.$store.getters.styles; },
        // 필터 - 최저, 최고가
        filter_price() { return this.$store.getters.filter_price; },
        // 필터 - 배송
        deliveries() { return this.$store.getters.deliveries; },
        // 현재 상품 최저, 최고 가격
        item_price_info() { return this.$store.getters.item_price_info; },
        // 상품 API 호출 완료 여부
        search_complete_yn() { return this.$store.getters.search_complete_yn; },
        // 총 상품 수
        total_item_count() {
            let count = 0;
            if( this.category_filters != null ) {
                this.category_filters.forEach(f => count += f.item_count);
            }
            return count;
        },
        // 현재그룹 총 상품 수
        current_group_item_count() {
            let total_page = 0;
            switch (this.parameter.group_type) {
                case 'sc' : total_page = this.count_info.sale; break;
                case 'fv' : total_page = this.count_info.wish; break;
                case 'pk' : total_page = this.count_info.wrapping; break;
                default : total_page = this.count_info.all;
            }
            return total_page;
        },
        // 활성화된 필터 리스트
        active_filters() {
            const active_filters = [
                {'type' : 'color', 'name' : '컬러', 'items' : []}
                , {'type' : 'style', 'name' : '스타일', 'items' : []}
                , {'type' : 'price', 'name' : '가격', 'items' : []}
                , {'type' : 'delivery', 'name' : '배송', 'items' : []}
            ];

            // 컬러
            this.colors.forEach(e => {
                if( e.select_yn && e.code !== '000' ) {
                    active_filters[0].items.push({
                        'code' : e.code,
                        'name' : e.name
                    });
                }
            });
            // 스타일
            this.styles.forEach(e => {
                if( e.select_yn && e.code !== '000' ) {
                    active_filters[1].items.push({
                        'code' : e.code,
                        'name' : e.name
                    });
                }
            });
            // 가격
            if( this.filter_price.min !== this.item_price_info.min
                || this.filter_price.max !== this.item_price_info.max ) {
                active_filters[2].items[0] = {
                    'code' : `${this.filter_price.min},${this.filter_price.max}`,
                    'name' : `${this.number_format(this.filter_price.min)}원 ~ ${this.number_format(this.filter_price.max)}원`
                };
            }
            // 배송
            const active_delivery = this.deliveries.find(e => e.select_yn);
            if( active_delivery !== undefined && active_delivery.code !== '' ) { // 전체가 아니면
                active_filters[3].items[0] = {
                    'code' : active_delivery.code,
                    'name' : active_delivery.name
                };
            }

            return active_filters;
        },
        // 현재 검색결과 활성화된 필터 존재 여부
        exist_active_filter_yn() {
            const p = this.parameter;
            return this.active_filters.find(e => e.items.length > 0)
                || p.color.length > 0 || p.style.length > 0 || p.deli_type.length > 0
                || (p.max_price !== '' && !isNaN(p.max_price))
                || (p.min_price !== '' && !isNaN(p.min_price));
        },
        // 초기화 uri
        clear_uri() {
            return `?rect=${this.parameter.keyword}&sflag=${this.parameter.group_type}`
                + `&srm=${this.parameter.sort_method}`;
        }
    },
    methods : {
        // 상품 상세 이동
        go_product_detail(index, product) {
            location.href = product.move_url + '&pRtr=' + encodeURIComponent(this.parameter.keyword);
        },
        // 필터 더보기/접기
        toggle_filter(type) {
            if( this[`show_${type}_filter`] ) {
                $('html, body').animate({scrollTop: $("#lyrSchExpTab").offset().top-20}, 100)
            }
            this[`show_${type}_filter`] = !this[`show_${type}_filter`];
        },

        // 활성화된 브랜드 필터 코드 set
        set_active_brand_filter(brand_id, flag) {
            if( flag ) {
                this.active_brand_filter.push(brand_id);
            } else {
                this.active_brand_filter.splice(this.active_brand_filter.findIndex(b => b === brand_id), 1);
            }
        },

        // 활성화된 카테고리 필터 코드 set
        set_active_category_filter() {
            const categories = [];
            for( let key in this.$refs ) {
                if( key.startsWith('category_filter_') ) {
                    this.$refs[key][0].return_categories.forEach(c => categories.push(c));
                }
            }
            this.active_category_filter = categories;
        },

        /********* 필터 ***********/
        // 필터 선택
        select_filter(type) {
            if( this.active_filter === type ) {
                this.active_filter = '';
            } else {
                // 가격필터의 경우 펼칠 때 가격 슬라이더 생성
                if( type === 'price' ) {
                    this.$refs.price.create_slider();
                }
                this.active_filter = type;
            }
        },
        // 필터 삭제
        delete_filter(type, code) {
            switch (type) {
                case 'color': this.select_color(false, code); break;
                case 'style': this.select_style(false, code); break;
                case 'price':
                    this.change_filter_price(this.item_price_info.min, this.item_price_info.max);
                    this.$refs.price.clear();
                    break;
                case 'delivery': this.select_delivery(''); break;
            }
        },
        // 컬러 선택/해제
        select_color(select_yn, code) {
            if( select_yn )
                this.$store.commit('ADD_FILTER_COLOR', code);
            else
                this.$store.commit('DEL_FILTER_COLOR', code);
        },
        // 스타일 선택/해제
        select_style(select_yn, code) {
            if( select_yn )
                this.$store.commit('ADD_FILTER_STYLE', code);
            else
                this.$store.commit('DEL_FILTER_STYLE', code);
        },
        // 필터 가격 변경
        change_filter_price(min, max) {
            this.$store.commit('SET_FILTER_PRICE', {min:min, max:max});
        },
        // 배송 선택
        select_delivery(code) {
            this.$store.commit('SET_FILTER_DELIVERY', code);
        },

        /*************
         * 페이지 이동
         * 이동 시 고려해야 할 사항들
         * 그룹유형, 정렬기준, 품절상품제외여부, 뷰타입, 페이지
         * , 필터(컬러, 스타일, 가격, 배송, 키워드)
         *
         * 키워드는 고정(키워드 변경 시 모든 파라미터 초기화)
         */
        go_page(changed_parameters) {
            // 기본 파라미터(그룹유형, 정렬기준, 품절상품제외여부, 뷰타입, 페이지)
            const basic_parameter = {
                'group_type' : this.parameter.group_type,
                'sort_method' : this.parameter.sort_method,
                'except_sold_out_yn' : this.parameter.except_sold_out_yn,
                'page' : this.parameter.page
            };
            if( changed_parameters !== undefined ) {
                changed_parameters.forEach(p => basic_parameter[p.name] = p.value);
            }

            let url = `?rect=${this.parameter.keyword}`
                + `&sflag=${basic_parameter.group_type}&srm=${basic_parameter.sort_method}`
                + `&sscp=${basic_parameter.except_sold_out_yn ? 'Y' : 'N'}`
                + `&cpg=${basic_parameter.page}`;

            // 필터
            // 컬러
            const colors = this.active_filters[0];
            if( colors.items.length > 0 ) {
                const color_codes = [];
                colors.items.forEach(c => color_codes.push(c.code));
                url += '&iccd=' + color_codes.join(',');
            }
            // 스타일
            const styles = this.active_filters[1];
            if( styles.items.length > 0 ) {
                const style_codes = [];
                styles.items.forEach(s => style_codes.push(s.code));
                url += '&styleCd=' + style_codes.join(',');
            }
            // 가격
            const prices = this.active_filters[2];
            if( prices.items.length > 0 ) {
                const price_arr = prices.items[0].code.split(',');
                url += `&minPrc=${price_arr[0]}&maxPrc=${price_arr[1]}`;
            }
            // 배송
            const delivery = this.active_filters[3];
            if( delivery.items.length > 0 ) {
                url += `&deliType=${delivery.items[0].code}`;
            }

            // 카테고리
            if( this.active_category_filter.length > 0 ) {
                url += `&arrCate=${encodeURIComponent(this.active_category_filter.join(','))}`;
            }

            // 브랜드
            if( this.active_brand_filter.length > 0 ) {
                url += `&mkr=${encodeURIComponent(this.active_brand_filter.join(','))}`;
            }

            location.href = url;
        },
        // 그룹 변경
        change_group(type) {
            this.go_page([
                  {'name' : 'group_type', 'value' : type}
                , {'name' : 'page', 'value' : 1}
            ]);
        },
        // 정렬 기준 벼경
        change_sort_method(e) {
            this.go_page([
                {'name' : 'sort_method', 'value' : e.target.value}
                , {'name' : 'page', 'value' : 1}
            ]);
        },
        // 품절 상품 제외 변경
        change_except_sold_out_yn() {
            this.go_page([
                {'name' : 'except_sold_out_yn', 'value' : !this.parameter.except_sold_out_yn}
                , {'name' : 'page', 'value' : 1}
            ]);
        },
        // 페이지 변경
        change_page(page) {
            this.go_page([{'name' : 'page', 'value' : page}]);
        },
        // 카테고리필터 클릭
        click_category(code) {
            location.href = this.clear_uri + '&arrCate=' + code;
        },
        // 브랜드필터 클릭
        click_brand(brand_id) {
            location.href = this.clear_uri + '&mkr=' + brand_id;
        },
        go_category_brand_filter() {
            if( this.active_tab === 'category' ) {
                location.href = this.clear_uri + '&arrCate=' + encodeURIComponent(this.active_category_filter.join(','));
            } else {
                location.href = this.clear_uri + '&mkr=' + encodeURIComponent(this.active_brand_filter.join(','));
            }
        }
    },
    watch : {
        // 필터 탭 변경시 비활성화 된 필터 초기화
        active_tab(type) {
            if( type === 'brand' ) {
                for( let key in this.$refs ) {
                    if( key.startsWith('category_filter_') ) {
                        this.$refs[key][0].clear_categories();
                    }
                }
            } else {
                this.active_brand_filter = [];
            }
        }
    }
});