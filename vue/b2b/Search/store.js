const store = new Vuex.Store({
    state : {
        // 파라미터
        parameter : {
            keyword : '',
            disp_categories : [],
            brand_ids : [],
            group_type : 'n',
            page : 1,
            sort_method : 'ne',
            except_sold_out_yn : false,
            deli_type : [],
            color : [],
            style : [],
            max_price : '',
            min_price : ''
        },

        // 그룹별 상품 수 정보
        count_info : {
            all : 0,
            sale : 0,
            wish : 0,
            wrapping : 0
        },

        products : [], // 상품 리스트
        search_complete_yn : false, // 상품 API 호출 완료 여부

        category_filters : [], // 카테고리 필터 리스트
        best_brand_filters : [], // 카테고리 필터 리스트
        brand_filters : [], // 카테고리 필터 리스트

        // 필터
        colors : [], // 컬러 리스트
        styles : [], // 스타일 리스트
        deliveries : [], // 배송 리스트
        filter_price : { min:0, max:0 }, // 필터 최저, 최고 가격
        item_price_info : { min:0, max:0 }, // 현재 상품 최저, 최고 가격
    },
    mutations : {
        SET_PARAMETER(state, parameter) {
            // 키워드
            if( parameter.keyword.trim() === '' ) {
                history.back();
            }
            state.parameter.keyword = parameter.keyword;

            // 카테고리
            if( parameter.disp_categories !== '' )
                state.parameter.disp_categories = parameter.disp_categories.split(',');

            // 브랜드
            if( parameter.brand_ids !== '' )
                state.parameter.brand_ids = parameter.brand_ids.split(',');

            // 그룹타입
            state.parameter.group_type = parameter.group_type;

            // 페이지
            state.parameter.page = Number(parameter.page);

            // 정렬 기준
            state.parameter.sort_method = parameter.sort_method;

            // 품절상품제외 여부!!!
            state.parameter.except_sold_out_yn = parameter.except_sold_out_yn === 'Y';

            //배송
            if( parameter.deli_type === 'FT' ) {
                state.parameter.deli_type = ['FD', 'TN'];
            } else if( parameter.deli_type !== '' ) {
                state.parameter.deli_type = [parameter.deli_type];
            }

            // 컬러
            if( parameter.color !== '' ) {
                state.parameter.color = parameter.color.split(',');
            }

            // 스타일
            if( parameter.style !== '' ) {
                state.parameter.style = parameter.style.split(',');
            }

            // 최저, 최고가
            state.parameter.max_price = parameter.max_price;
            state.parameter.min_price = parameter.min_price;
        },
        SET_COUNT_INFO(state, data) {
            state.count_info.all = data.all_count;
            state.count_info.sale = data.sale_count;
            state.count_info.wish = data.wish_count;
            state.count_info.wrapping = data.gift_wrap_count;
        },
        SET_PRODUCTS(state, products) {
            if( products != null && products.length > 0 ) {
                products.forEach(product => {
                    product.basic_image = decode_base64(product.basic_image);
                    product.add_image = decode_base64(product.add_image);
                    product.move_url = decode_base64(product.move_url);
                    state.products.push(product);
                });
            } else {
                state.products = null;
            }
        },
        SET_CATEGORY_FILTER(state, categories) {
            if( categories != null && categories.length > 0 ) {
                state.category_filters = categories;
            }
        },
        SET_BRAND_FILTER(state, payload) {
            if( payload.best_brands != null )
                state.best_brand_filters = payload.best_brands;
            if( payload.brands != null )
                state.brand_filters = payload.brands;
        },

        // 필터
        SET_FILTERS(state, data) {
            // 컬러
            if( data.colors != null ) {
                data.colors.forEach(color => {
                    state.colors.push({
                        'code' : color.code,
                        'name' : color.name_en.replace(/_/g, ''),
                        'select_yn' : state.parameter.color.indexOf(color.code) > -1
                    });
                });
                if( state.colors.find(color => color.select_yn) === undefined ) {
                    state.colors[0].select_yn = true;
                }
            }

            // 스타일
            if( data.styles != null ) {
                data.styles.forEach(style => {
                    state.styles.push({
                        'code'     : style.code,
                        'name'     : style.name,
                        'select_yn': state.parameter.style.indexOf(style.code) > -1
                    });
                });
                if (state.styles.find(style => style.select_yn) === undefined) {
                    state.styles[0].select_yn = true;
                }
            }

            // 배송
            const deliveries = [
                {code: '',      name: 'ALL',           description: 'ALL'},
                {code: 'FD',    name: '무료 배송',      description: '무료배송 상품입니다.'},
                {code: 'TN',    name: '텐바이텐 배송',   description: '텐바이텐 물류센터에서 직접 발송이 되는 상품입니다.'},
                {code: 'FT',    name: '무료+텐바이텐 배송', description: '텐바이텐 물류센터에서 직접 발송이 되는 무료배송 상품입니다.'},
                {code: 'DT',    name: '해외 직구',      description: '해외에서 배송되는 상품입니다.'},
                {code: 'WD',    name: '해외 배송',      description: '해외 배송이 가능한 상품입니다.'}
            ];
            deliveries.forEach(delivery => {
                if( delivery.code === 'FT' ) {
                    delivery.select_yn = state.parameter.deli_type.indexOf('FD') > -1 && state.parameter.deli_type.indexOf('TN') > -1;
                } else if( delivery.code === '' ) {
                    delivery.select_yn = state.parameter.deli_type.length === 0;
                } else {
                    delivery.select_yn = state.parameter.deli_type[0] === delivery.code;
                }
                state.deliveries.push(delivery);
            });

            // 현재 상품리스트 최저, 최고가
            state.item_price_info.min = data.min_price;
            state.item_price_info.max = data.max_price;

            // 가격
            if( state.parameter.min_price === '' || isNaN(state.parameter.min_price) ) {
                state.filter_price.min = data.min_price;
            } else {
                state.filter_price.min = Number(state.parameter.min_price);
            }
            if( state.parameter.max_price === '' || isNaN(state.parameter.max_price) ) {
                state.filter_price.max = data.max_price;
            } else {
                state.filter_price.max = Number(state.parameter.max_price);
            }
        },
        /**
         * 컬러 추가
         * 전체면 다른 선택 한 컬러 선택해제
         * 전체가 아니면 전체 선택해제
         */
        ADD_FILTER_COLOR(state, color_code) {
            if( color_code === '000' ) {
                state.colors.forEach(e => e.select_yn = false);
            } else {
                state.colors[0].select_yn = false;
            }
            state.colors.find(e => e.code === color_code).select_yn = true;
        },
        /**
         * 컬러 삭제
         * 전체면 실행 안함
         * 해제 후 선택된 컬러가 없다면 전체 선택
         */
        DEL_FILTER_COLOR(state, color_code) {
            if( color_code === '000' )
                return false;

            state.colors.find(e => e.code === color_code).select_yn = false;

            if( state.colors.find(e => e.select_yn) === undefined ) {
                state.colors[0].select_yn = true;
            }
        },
        /**
         * 스타일 추가
         * 전체면 다른 선택 한 스타일 선택해제
         * 전체가 아니면 스타일 선택해제
         */
        ADD_FILTER_STYLE(state, style_code) {
            if( style_code === '000' ) {
                state.styles.forEach(e => e.select_yn = false);
            } else {
                state.styles[0].select_yn = false;
            }
            state.styles.find(e => e.code === style_code).select_yn = true;
        },
        /**
         * 스타일 삭제
         * 전체면 실행 안함
         * 해제 후 선택된 스타일이 없다면 전체 선택
         */
        DEL_FILTER_STYLE(state, style_code) {
            if( style_code === '000' )
                return false;

            state.styles.find(e => e.code === style_code).select_yn = false;

            if( state.styles.find(e => e.select_yn) === undefined ) {
                state.styles[0].select_yn = true;
            }
        },
        /**
         * 가격 변경
         */
        SET_FILTER_PRICE(state, payload) {
            state.filter_price.min = Number(payload.min);
            state.filter_price.max = Number(payload.max);
        },
        /**
         * 배송 선택
         */
        SET_FILTER_DELIVERY(state, code) {
            state.deliveries.forEach(e => e.select_yn = false);
            state.deliveries.find(e => e.code === code).select_yn = true;
        },

        SET_SEARCH_COMPLETE_YN(state, flag) {
            state.search_complete_yn = flag;
        }
    },
    actions : {
        // GET 카테고리 필터 목록
        GET_CATEGORY_FILTERS(context) {
            const keyword = context.getters.parameter.keyword;
            call_api('get', '/b2b/pc/category/filter', {'keyword' : keyword}
            , data => {
                //console.log('GET_CATEGORY_FILTERS\n', data);
                context.commit('SET_CATEGORY_FILTER', data.categories);
            });
        },
        // GET 브랜드 필터 목록
        GET_BRAND_FILTERS(context) {
            const keyword = context.getters.parameter.keyword;
            call_api('get', '/b2b/pc/brand/filter', {'keyword' : keyword}
            , data => {
                //console.log('GET_BRAND_FILTERS\n', data);
                context.commit('SET_BRAND_FILTER', data);
            });
        },
        // GET 카테고리 상품관련 정보
        GET_PRODUCTS_INFO(context) {
            const parameter = context.getters.parameter;

            let api_sort_method;
            switch(parameter.sort_method) {
                case 'be' : api_sort_method = 'best'; break;
                case 'ne' : api_sort_method = 'new'; break;
                default : api_sort_method = parameter.sort_method; break;
            }

            const send_data = {
                'keyword' : parameter.keyword,
                'disp_categories' : parameter.disp_categories.join(','),
                'brand_ids' : parameter.brand_ids.join(','),
                'page' : parameter.page,
                'page_size' : 40,
                'sort_method' : api_sort_method,
                'sale_yn' : parameter.group_type === 'sc',
                'have_wish_yn' : parameter.group_type === 'fv',
                'gift_wrap_yn' : parameter.group_type === 'pk',
                'except_sold_out_yn' : parameter.except_sold_out_yn,
                'deli_type' : parameter.deli_type.join(','),
                'max_price' : parameter.max_price,
                'min_price' : parameter.min_price,
                'colors' : parameter.color.join(','),
                'styles' : parameter.style.join(',')
            }

            call_api('get', '/b2b/pc/search/product', send_data
            ,data => {
                //console.log('GET_PRODUCTS_INFO\n', data);
                context.commit('SET_PRODUCTS', data.items);
                context.commit('SET_FILTERS', data);
                context.commit('SET_COUNT_INFO', data);
                context.commit('SET_SEARCH_COMPLETE_YN', true);
            });
        }
    },
    getters : {
        parameter(state) { return state.parameter; },
        count_info(state) { return state.count_info; },
        products(state) { return state.products; },
        search_complete_yn(state) { return state.search_complete_yn; },
        category_filters(state) { return state.category_filters; },
        best_brand_filters(state) { return state.best_brand_filters; },
        brand_filters(state) { return state.brand_filters; },
        colors(state) { return state.colors; },
        styles(state) { return state.styles; },
        deliveries(state) { return state.deliveries; },
        filter_price(state) { return state.filter_price; },
        item_price_info(state) { return state.item_price_info; },
    }
});