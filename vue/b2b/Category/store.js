const store = new Vuex.Store({
    state : {
        // 파라미터
        parameter : {
            keyword : '',
            category_code : 102,
            group_type : 'n',
            page : 1,
            view_type : 'M',
            sort_method : 'ne',
            except_sold_out_yn : false,
            deli_type : [],
            color : [],
            style : [],
            max_price : '',
            min_price : ''
        },

        // 카테고리 정보
        category_info : {
            current_category_code : 0,
            current_category_name : '',
            current_category_depth : 1,
            head_category_code : 0,
            head_category_name : '',
            header_categories : [],
            low_categories : []
        },
        // 그룹별 상품 수 정보
        count_info : {
            all : 0,
            sale : 0,
            wish : 0,
            wrapping : 0
        },

        products : [], // 상품 리스트

        // 필터
        colors : [], // 컬러 리스트
        styles : [], // 스타일 리스트
        deliveries : [], // 배송 리스트
        keyword : '', // 검색 키워드
        filter_price : { min:0, max:0 }, // 필터 최저, 최고 가격
        item_price_info : { min:0, max:0 }, // 현재 상품 최저, 최고 가격
    },
    mutations : {
        SET_PARAMETER(state, parameter) {
            // 카테고리
            if( isNaN(parameter.category_code) || parameter.category_code.length%3 !== 0 ) {
                history.back();
            }
            state.parameter.category_code = Number(parameter.category_code);

            // 그룹타입
            state.parameter.group_type = parameter.group_type;

            // 페이지
            state.parameter.page = Number(parameter.page);
            // 뷰타입
            state.parameter.view_type = parameter.view_type;

            // 정렬 기준
            state.parameter.sort_method = parameter.sort_method;

            // 품절상품제외 여부
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

            // 키워드
            state.parameter.keyword = parameter.keyword;
        },
        SET_COUNT_INFO(state, data) {
            state.count_info.all = data.all_count;
            state.count_info.sale = data.sale_count;
            state.count_info.wish = data.wish_count;
            state.count_info.wrapping = data.gift_wrap_count;
        },
        SET_CATEGORY_INFO(state, data) {
            state.category_info.current_category_code = data.current_category_code;
            state.category_info.current_category_name = data.current_category_name;
            state.category_info.current_category_depth = data.current_category_code.toString().length/3;
            state.category_info.head_category_code = data.head_category_code;
            state.category_info.head_category_name = data.head_category_name;
            state.category_info.header_categories = data.header_categories;
            state.category_info.low_categories = data.categories;
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

            // 키워드
            state.keyword = state.parameter.keyword;
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
        /**
         * 키워드
         */
        SET_KEYWORD(state, keyword) {
            state.keyword = keyword.trim();
        }
    },
    actions : {
        // GET 카테고리 관련 정보
        GET_CATEGORY_INFO(context) {
            call_api('get', '/b2b/pc/category/' + context.getters.parameter.category_code, null
            ,data => {
                console.log('GET_CATEGORY_INFO\n', data);
                context.commit('SET_CATEGORY_INFO', data);
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
                'disp_categories' : parameter.category_code,
                'page' : parameter.page,
                'page_size' : parameter.view_type === 'M' ? 40 : 72,
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

            call_api('get', '/b2b/pc/category/list', send_data
            ,data => {
                console.log('GET_PRODUCTS_INFO\n', data);
                context.commit('SET_PRODUCTS', data.items);
                context.commit('SET_FILTERS', data);
                context.commit('SET_COUNT_INFO', data);
            });
        }
    },
    getters : {
        parameter(state) { return state.parameter; },
        count_info(state) { return state.count_info; },
        category_info(state) { return state.category_info; },
        products(state) { return state.products; },
        colors(state) { return state.colors; },
        styles(state) { return state.styles; },
        filter_price(state) { return state.filter_price; },
        item_price_info(state) { return state.item_price_info; },
        deliveries(state) { return state.deliveries; },
        keyword(state) { return state.keyword; },
    }
});