const app = new Vue({
    el: '#app',
    store : store,
    mixin : [common_mixin],
    template : `
        <div class="ctgyWrapV15">

            <!-- 카테고리 정보 -->
            <div class="section">
                <!-- TODO : 기존 좌측 lnb때문에 오른쪽 float되어있었음. css 다시 잡아야 함 -->
                <div class="content">

                    <!-- 헤더 카테고리 로테이션 정보 -->
                    <div class="locationV15">
                        <p>
                            <a href="/">HOME</a>
                            <template v-for="category in category_info.header_categories">
                                &nbsp;&gt;&nbsp;<a @click="change_category(category.category_code)">{{category.category_name}}</a>
                            </template>
                        </p>
                    </div>

                    <!-- 하위 카테고리 리스트 -->
                    <dl class="subCtgyViewV15">
                        <dt>{{category_info.head_category_name}}</dt>
                        <dd>
                            <ul>
                                <li v-for="category in category_info.low_categories" :class="{current : category.select_yn}">
                                    <a @click="change_category(category.catecode)" style="cursor:pointer;">{{category.catename}}</a>
                                </li>
                            </ul>
                        </dd>
                    </dl>

                </div>
            </div>

            <!-- 필터 영역 -->
            <div class="pdtFilterWrap tMar50">
                <div class="tabWrapV15">

                    <!-- 그룹 탭 -->
                    <div class="sortingTabV15">
                        <ul>
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
                    </div>

                    <ul class="dFilterTabV15">
                        <li @click="select_filter('color')" :class="['tabColor', {selected: active_filter==='color'}]"><p>컬러</p></li>
                        <li @click="select_filter('style')" :class="['tabStyle', {selected: active_filter==='style'}]"><p>스타일</p></li>
                        <li v-if="filter_price.max > 0" @click="select_filter('price')" :class="['tabPrice', {selected: active_filter==='price'}]"><p>가격</p></li>
                        <li @click="select_filter('delivery')" :class="['tabDelivery', {selected: active_filter==='delivery'}]"><p>배송</p></li>
                        <li @click="select_filter('keyword')" :class="['tabSearch', {selected: active_filter==='keyword'}]"><p>검색</p></li>
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

                        <!-- 키워드 -->
                        <div v-show="active_filter === 'keyword'" class="ftSearch" id="fttabSearch">
                            <input type="text" :value="keyword" style="width:400px" class="ftSearchInput" 
                                @input="input_keyword" @keydown.enter="go_page()" />
                            <input type="image" src="http://fiximage.10x10.co.kr/web2015/common/btn_add.png" alt="Search" />
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
                <div class="ftRt" style="width:280px;">
                    <select @change="change_sort_method" class="ftLt optSelect" title="배송구분 옵션을 선택하세요" style="height:18px;">
                        <option value="ne" :selected="parameter.sort_method === 'ne'">신상품순</option>
                        <option value="bs" :selected="parameter.sort_method === 'bs'">판매량순</option>
                        <option value="be" :selected="parameter.sort_method === 'be'">인기상품순</option> <!-- 위시그룹 선택상태면 인기위시순 -->
                        <option value="lp" :selected="parameter.sort_method === 'lp'">낮은가격순</option>
                        <option value="hp" :selected="parameter.sort_method === 'hp'">높은가격순</option>
                        <option value="hs" :selected="parameter.sort_method === 'hs'">높은할인율순</option>
                    </select>
                    <a @click="change_except_sold_out_yn" class="lMar20 ftLt btn btnS3 btnGry fn">{{parameter.except_sold_out_yn ? '- 품절상품 제외' : '+ 품절상품 포함'}}</a>
                    <ul class="pdtView" id="lySchIconSize">
                        <li :class="['view02', {current: parameter.view_type === 'M'}]" data-type="M"><a @click="change_view_type" title="중간이미지" style="cursor: pointer;">중간 이미지로 보기</a></li>
                        <li :class="['view03', {current: parameter.view_type === 'S'}]" data-type="S"><a @click="change_view_type" title="작은이미지" style="cursor: pointer;">작은 이미지로 보기</a></li>
                    </ul>
                </div>
            </div>

            <!-- 상품 리스트 -->
            <div class="section">
                <!-- 중간이미지: pdt240V15, 작은이미지: pdt150V15 -->
                <div v-if="products != null && products.length > 0" :class="['pdtWrap', 'pdtBiz', parameter.view_type === 'M' ? 'pdt240V15' : 'pdt150V15']">
                    <ul class="pdtList">

                        <PRODUCT-BASIC v-for="(product, index) in products"
                            @go_product_detail="go_product_detail"
                            :index="index" :product="product" :view_type="parameter.view_type"/>

                    </ul>
                </div>
                
                <!-- 검색결과 없음 -->
                <div v-else-if="products == null" class="ct" style="padding:150px 0;">
                    <p style="font-family:'malgun gothic', '맑은고딕', dotum, '돋움', sans-serif; font-size:21px; color:#000;">
                        <strong>흠... <span class="cRd0V15">조건에 맞는 상품</span>이 없습니다.</strong>
                    </p>
                    <p class="tPad10">Filter 조건 선택해제 후, 다시 원하시는 조건을 선택해 주세요.<p>
                    <p>일시적으로 상품이 품절일 경우 검색되지 않습니다.</p>
                </div>
                
                <!-- 페이지 -->
                <PAGE v-if="products != null && products.length > 0" @move_page="change_page" 
                    :show_item_count="show_page_count" :current_page="parameter.page" :total_item_count="total_item_count"/>

            </div>

        </div>
    `,
    data() {return {
        active_filter : '', // 활성화 중인 필터
    }},
    created() {
        // SET 초기 파라미터
        this.$store.commit('SET_PARAMETER', parameter);
        // GET 카테고리 정보
        this.$store.dispatch('GET_CATEGORY_INFO');
        // GET 카테고리 상품관련 정보
        this.$store.dispatch('GET_PRODUCTS_INFO');
    },
    computed : {
        // 현재 파라미터
        parameter() { return this.$store.getters.parameter; },
        // 그룹별 상품 수 정보
        count_info() { return this.$store.getters.count_info; },
        // 카테고리 정보
        category_info() { return this.$store.getters.category_info; },
        // 상품 리스트
        products() { return this.$store.getters.products; },
        // 필터 - 컬러
        colors() { return this.$store.getters.colors; },
        // 필터 - 스타일
        styles() { return this.$store.getters.styles; },
        // 필터 - 최저, 최고가
        filter_price() { return this.$store.getters.filter_price; },
        // 필터 - 배송
        deliveries() { return this.$store.getters.deliveries; },
        // 필터 - 키워드
        keyword() { return this.$store.getters.keyword; },
        // 현재 상품 최저, 최고 가격
        item_price_info() { return this.$store.getters.item_price_info; },
        // 현재그룹 총 상품 수
        total_item_count() {
            let total_page = 0;
            switch (this.parameter.group_type) {
                case 'sc' : total_page = this.count_info.sale; break;
                case 'fv' : total_page = this.count_info.wish; break;
                case 'pk' : total_page = this.count_info.wrapping; break;
                default : total_page = this.count_info.all;
            }
            return total_page;
        },
        // 한 페이지에 보여 줄 상품 수
        show_page_count() {
            return this.parameter.view_type === 'M' ? 40 : 72;
        },
        // 활성화된 필터 리스트
        active_filters() {
            const active_filters = [
                {'type' : 'color', 'name' : '컬러', 'items' : []}
                , {'type' : 'style', 'name' : '스타일', 'items' : []}
                , {'type' : 'price', 'name' : '가격', 'items' : []}
                , {'type' : 'delivery', 'name' : '배송', 'items' : []}
                , {'type' : 'keyword', 'name' : '키워드', 'items' : []}
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
            // 키워드
            if( this.keyword.length > 0 ) {
                active_filters[4].items[0] = {
                    'code' : this.keyword,
                    'name' : this.keyword
                };
            }

            return active_filters;
        },
        // 현재 검색결과 활성화된 필터 존재 여부
        exist_active_filter_yn() {
            const p = this.parameter;
            return this.active_filters.find(e => e.items.length > 0)
                || p.color.length > 0 || p.style.length > 0 || p.deli_type.length > 0 || p.keyword !== ''
                || (p.max_price !== '' && !isNaN(p.max_price))
                || (p.min_price !== '' && !isNaN(p.min_price));
        },
        // 초기화 uri
        clear_uri() {
            return '?disp=' + this.category_info.current_category_code + '&sflag=' + this.parameter.group_type;
        }
    },
    methods : {
        // 상품 상세 이동 전 Amplitude전송 후 이동
        go_product_detail(index, product) {
            fnAmplitudeEventMultiPropertiesAction('click_category_list_product'
                , 'item_index|sort|category_code|category_depth|itemid|category_name|brand_name|list_style'
                , `${index}|${this.parameter.sort}|${this.category_info.current_category_code}|${this.category_info.category_depth}`
                + `|${product.item_id}|${this.category_info.category_name}|${product.brand_name}|${this.parameter.view_type}`);

            location.href = product.move_url;
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
        // 키워드 입력
        input_keyword(e) {
            this.$store.commit('SET_KEYWORD', e.target.value);
        },

        /*************
         * 페이지 이동
         * 이동 시 고려해야 할 사항들
         * 그룹유형, 정렬기준, 품절상품제외여부, 뷰타입, 페이지
         * , 필터(컬러, 스타일, 가격, 배송, 키워드)
         *
         * 카테고리는 고정(카테고리 변경 시 모든 파라미터 초기화)
         */
        go_page(changed_parameters) {
            // 기본 파라미터(그룹유형, 정렬기준, 품절상품제외여부, 뷰타입, 페이지)
            const basic_parameter = {
                'group_type' : this.parameter.group_type,
                'sort_method' : this.parameter.sort_method,
                'except_sold_out_yn' : this.parameter.except_sold_out_yn,
                'view_type' : this.parameter.view_type,
                'page' : this.parameter.page
            };
            if( changed_parameters !== undefined ) {
                changed_parameters.forEach(p => basic_parameter[p.name] = p.value);
            }

            let url = `?disp=${this.category_info.current_category_code}`
                + `&sflag=${basic_parameter.group_type}&srm=${basic_parameter.sort_method}`
                + `&sscp=${basic_parameter.except_sold_out_yn ? 'Y' : 'N'}`
                + `&icoSize=${basic_parameter.view_type}&cpg=${basic_parameter.page}`;

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
            // 키워드
            const keyword = this.active_filters[4];
            if( keyword.items.length > 0 ) {
                url += `&rect=${keyword.items[0].code}`;
            }

            //console.log(url);
            location.href = url;
        },
        // 그룹 변경
        change_group(type) {
            fnAmplitudeEventMultiPropertiesAction('click_category_list_item_type', 'categoryname|type'
                , `${this.category_info.current_category_name}|${type}`);

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
        // 뷰타입 변경
        change_view_type(e) {
            this.go_page([
                  {'name' : 'view_type', 'value' : e.target.parentElement.dataset.type}
                , {'name' : 'page', 'value' : 1}
            ]);
        },
        // 페이지 변경
        change_page(page) {
            this.go_page([{'name' : 'page', 'value' : page}]);
        },
        // 카테고리 변경
        change_category(code) {
            const this_category_code = this.category_info.current_category_code.toString();
            // 클릭 시 이동 전에 앰플리튜드전송(event명: view_category_list_subcategory, 속성:category_code(현재카테고리코드)|category_depth(현재카테고리뎁스)|move_category_code(이동할카테고리코드)|move_category_depth(이동할카테고리뎁스))
            fnAmplitudeEventMultiPropertiesAction('view_category_list_subcategory'
                , 'category_code|category_depth|move_category_code|move_category_depth'
                , `${this_category_code}|${this_category_code.length/3}|${code}|${code.length/3}`);
            location.href = '?disp=' + code;
        }
    }
});