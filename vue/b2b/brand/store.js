const store = new Vuex.Store({
    state : {
        brand_info : {}
        , my_zzim : []
        , street_hello : {}
        , is_zzim : 0
        , street_zzim_count : 0
        , best_product: []
        , total_count : 0
        , cate_filter : []
        , search_data:{
            all_count:0
            , sale_count:0
            , wish_count:0
            , gift_count:0
            , items: []
            , colors : []
            , styles: []
            , min_price : 0
            , max_price : 0
        }
        , interview : []
        , artistwork : {}
        , lookbook_master : []
        , lookbook_data : {
            active_lookbook : 0
            , detail : {}
        }

        /*Default*/
        , parameter : { //가지고 있어야하는 데이터. 비교용
            page : 1
            , view_type : 'M'
            , sort_method : 'best'
            , colors : []
            , styles : []
            , min_price : ''
            , max_price : ''
            , deli_type : []
            , keyword : ""
            , disp_categories : []
            , group_type : "n"
        }
        , filter_data: { //필터에 들어갈 실제값
            colors : []
            , styles : []
            , min_price : 0
            , max_price : 0
            , deli_type : []
        }
        , keyword : ''
    },
    mutations : {
        SET_PARAMETER(state, parameter) {
            // 키워드
            if( parameter.keyword.trim() !== '' ) {
                state.parameter.keyword = parameter.keyword;
            }

            // 카테고리
            if( parameter.disp_categories !== '' )
                state.parameter.disp_categories = parameter.disp_categories.split(',');

            // 그룹타입
            state.parameter.group_type = parameter.group_type;

            // 페이지
            state.parameter.page = Number(parameter.page);

            // 정렬 기준
            state.parameter.sort_method = parameter.sort_method;

            //배송
            if( parameter.deli_type === 'FT' ) {
                state.parameter.deli_type = ['FD', 'TN'];
            } else if( parameter.deli_type !== '' ) {
                state.parameter.deli_type = [parameter.deli_type];
            }

            // 컬러
            if( parameter.colors !== '' ) {
                state.parameter.colors = parameter.colors.split(',');
            }

            // 스타일
            if( parameter.styles !== '' ) {
                state.parameter.styles = parameter.styles.split(',');
            }

            // 최저, 최고가
            state.parameter.max_price = parameter.max_price;
            state.parameter.min_price = parameter.min_price;

            state.parameter.view_type = parameter.view_type;
        }
        , SET_BRAND_INFO(state, data){
            state.brand_info = data;
        }
        , SET_MY_ZZIM(state, data){
            state.my_zzim = data;
        }
        , SET_STREET_HELLO(state, data){
            state.street_hello = data;
        }
        , SET_IS_ZZIM(state, data){
            state.is_zzim = data;
        }
        , SET_STREET_ZZIM_COUNT(state, data){
            state.street_zzim_count = data;
        }
        , UPDATE_STREET_ZZIM_COUNT(state, data){
            if (data == "cancel"){
                state.street_zzim_count -= 1;
            }else{
                state.street_zzim_count += 1;
            }

        }
        , SET_BEST_PRODUCT(state, data){
            if( data != null && data.length > 0 ) {
                data.forEach(item => {
                    item.basic_image = decode_base64(item.basic_image);
                    item.add_image = decode_base64(item.add_image);
                    item.move_url = decode_base64(item.move_url);
                    state.best_product.push(item);
                });
            } else {
                state.best_product = null;
            }
        }
        , SET_TOTAL_COUNT(state, data){
            state.total_count = data;
        }
        , SET_CATE_FILTER(state, data){
            state.cate_filter = data;

            //console.log("SET_CATE_FILTER", data);
            data.forEach(function(item, index){
                let sub_cate_gouping = [];
                const subCateLen = item.subCate.length;
                let subCateLoopCount = parseInt(subCateLen / 4);
                if(subCateLen % 4 != 0){
                    subCateLoopCount += 1;
                }
                for(let i=0; i<subCateLoopCount; i++){
                    sub_cate_gouping.push(item.subCate.slice(4*i, 4*(i+1) -1));
                }

                state.cate_filter[index].subCate = sub_cate_gouping;
            });
        }
        , SET_SEARCH(state, data){
            state.search_data.items = [];

            state.search_data.all_count = data.all_count;
            state.search_data.wish_count = data.wish_count;
            state.search_data.sale_count = data.sale_count;
            if( data.items != null && data.items.length > 0 ) {
                data.items.forEach(item => {
                    item.basic_image = decode_base64(item.basic_image);
                    item.add_image = decode_base64(item.add_image);
                    item.move_url = decode_base64(item.move_url);
                    state.search_data.items.push(item);
                });
            } else {
                state.search_data.items = null;
            }
            state.search_data.colors = data.colors;
            state.search_data.styles = data.styles;
            state.search_data.min_price = data.min_price;
            state.search_data.max_price = data.max_price;
        }
        , SET_FILTERS(state, data){
            //console.log("parameter", state.parameter);

            state.filter_data.colors = [];
            state.filter_data.styles = [];


            if(data.colors != null){
                data.colors.forEach(item => {
                    state.filter_data.colors.push({
                        'code' : item.code,
                        'name' : item.name_en.replace(/_/g, ''),
                        'select_yn' : state.parameter.colors.indexOf(item.code) > -1
                    });
                });

                if( state.filter_data.colors.find(color => color.select_yn) === undefined ) {
                    state.filter_data.colors[0].select_yn = true;
                }
            }

            if(data.styles != null){
                data.styles.forEach(item => {
                    state.filter_data.styles.push({
                        'code' : item.code,
                        'name' : item.name,
                        'select_yn' : state.parameter.styles.indexOf(item.code) > -1
                    });
                });
                if( state.filter_data.styles.find(style => style.select_yn) === undefined ) {
                    state.filter_data.styles[0].select_yn = true;
                }
            }

            if(state.parameter.min_price !== "" && !isNaN(state.parameter.min_price)){
                state.filter_data.min_price = Number(state.parameter.min_price);
            }else{
                state.filter_data.min_price = data.min_price;
            }
            if(state.parameter.max_price !== "" && !isNaN(state.parameter.max_price)){
                state.filter_data.max_price = Number(state.parameter.max_price);
            }else{
                state.filter_data.max_price = data.max_price;
            }

            const deliveries = [
                {code: '',      name: 'ALL',           description: 'ALL'},
                {code: 'FD',    name: '무료 배송',      description: '무료배송 상품입니다.'},
                {code: 'TN',    name: '텐바이텐 배송',   description: '텐바이텐 물류센터에서 직접 발송이 되는 상품입니다.'},
                {code: 'FT',    name: '무료+텐바이텐 배송', description: '텐바이텐 물류센터에서 직접 발송이 되는 무료배송 상품입니다.'},
                {code: 'DT',    name: '해외 직구',      description: '해외에서 배송되는 상품입니다.'},
                {code: 'WD',    name: '해외 배송',      description: '해외 배송이 가능한 상품입니다.'}
            ];

            state.filter_data.deli_type = [];

            deliveries.forEach(item => {
                if( item.code === 'FT' ) {
                    item.select_yn = state.parameter.deli_type.indexOf('FD') > -1 && state.parameter.deli_type.indexOf('TN') > -1;
                } else if( item.code === '' ) {
                    item.select_yn = state.parameter.deli_type.length === 0;
                } else {
                    item.select_yn = state.parameter.deli_type[0] === item.code;
                }
                state.filter_data.deli_type.push(item);
            });

            state.keyword = state.parameter.keyword;
        }
        , ADD_FILTER_COLOR(state, color_code) {
            if( color_code === '000' ) {
                state.filter_data.colors.forEach(e => e.select_yn = false);
            } else {
                state.filter_data.colors[0].select_yn = false;
            }
            state.filter_data.colors.find(e => e.code === color_code).select_yn = true;
        }
        , DEL_FILTER_COLOR(state, color_code) {
            if( color_code === '000' )
                return false;

            state.filter_data.colors.find(e => e.code === color_code).select_yn = false;

            if( state.filter_data.colors.find(e => e.select_yn) === undefined ) {
                state.filter_data.colors[0].select_yn = true;
            }
        }
        , UPDATE_PRAMETER_COLORS(state, data){
            state.parameter.colors = state.filter_data.colors;
        }
        , ADD_FILTER_STYLE(state, style_code) {
            if( style_code === '000' ) {
                state.filter_data.styles.forEach(e => e.select_yn = false);
            } else {
                state.filter_data.styles[0].select_yn = false;
            }
            state.filter_data.styles.find(e => e.code === style_code).select_yn = true;
        }
        , DEL_FILTER_STYLE(state, style_code) {
            if( style_code === '000' )
                return false;

            state.filter_data.styles.find(e => e.code === style_code).select_yn = false;

            if( state.filter_data.styles.find(e => e.select_yn) === undefined ) {
                state.filter_data.styles[0].select_yn = true;
            }
        }
        , UPDATE_PRAMETER_STYLES(state, data){
            state.parameter.styles = state.filter_data.styles;
        }
        , SET_FILTER_PRICE(state, data) {
            state.filter_data.min_price = data.min;
            state.filter_data.max_price = data.max;
        }
        , UPDATE_PRAMETER_PRICE(state, data){
            state.parameter.max_price = data[1];
            state.parameter.min_price = data[2];
        }
        , SET_FILTER_DELIVERY(state, code) {
            state.filter_data.deli_type.forEach(e => e.select_yn = false);
            state.filter_data.deli_type.find(e => e.code === code).select_yn = true;
        }
        , UPDATE_PRAMETER_DELI(state, code){
            state.parameter.deli_type = state.filter_data.deli_type;
        }
        , SET_KEYWORD(state, keyword) {
            state.keyword = keyword.trim();
        }
        , UPDATE_PRAMETER_KEYWORD(state, data){
            state.parameter.keyword = state.keyword;
        }
        , UPDATE_PRAMETER_VIEWTYPE(state, data){
            state.parameter.view_type = data;
        }
        , UPDATE_CHECKED_CATE(state, data){
            state.parameter.disp_categories = data;
        }
        , UPDATE_PRAMETER_GROUPTYPE(state, data){
            state.parameter.group_type = data;
        }
        , SET_BRAND_INTERVIEW(state, data){
            state.interview = data;
        }
        , SET_BRAND_ARTISTWORK(state, data){
            state.artistwork = data;
        }
        , SET_BRAND_LOOKBOOK_MASTER(state, data){
            state.lookbook_data.active_lookbook = data[0].idx;
            state.lookbook_master = data;
        }
        , SET_BRAND_LOOKBOOK_DETAIL(state, data){
            state.lookbook_data.detail = data;
        }
        , UPDATE_LOOKBOOK_ACTIVE(state, data){
            state.lookbook_data.active_lookbook = data;
        }
        , UPDATE_PAGE(state, data){
            state.parameter.page = data;
        }
    }
    , actions : {
        GET_BRAND_INFO(context, brand_id){
            call_api("get", "/b2b/pc/home/brand-info?brand_ids=" + brand_id, null
                , data=>{
                    //console.log("GET_BRAND_INFO", data);
                    context.commit("SET_BRAND_INFO", data.brandInfo);
                    context.commit("SET_MY_ZZIM", data.myZzim);
                    context.commit("SET_STREET_HELLO", data.streetHello);
                    context.commit("SET_IS_ZZIM", data.isZzim);
                    context.commit("SET_STREET_ZZIM_COUNT", data.streetZzimCount);
                    context.commit("SET_BEST_PRODUCT", data.bestProduct);
                    context.commit("SET_TOTAL_COUNT", data.totalCount);
                    context.commit("SET_CATE_FILTER", data.categoryFilter);
                    context.commit("SET_BRAND_INTERVIEW", data.interview);
                    context.commit("SET_BRAND_ARTISTWORK", data.artistwork);

                    if (data.lookbookMaster.length > 0){
                        context.commit("SET_BRAND_LOOKBOOK_MASTER", data.lookbookMaster);

                        let url = "/b2b/pc/home/brand-lookbook?master_idx=" + data.lookbookMaster[0].idx;
                        call_api("GET", url, null, data => {
                            context.commit("SET_BRAND_LOOKBOOK_DETAIL", data);
                        });
                    }
                });
        }
        , GET_BRAND_PRODUCT(context, request){
            call_api("get", "/b2b/pc/home/brand-list?brand_ids=" + request.brand_id.replace("#","") + request.query_string, null
                , data=>{
                    //console.log("GET_BRAND_PRODUCT", data);
                    context.commit("SET_SEARCH", data);
                });
        }
        , GET_BRAND_FILTER(context, request){
            call_api("get", "/b2b/pc/home/brand-list?brand_ids=" + request.brand_id.replace("#","") + request.query_string, null
                , data=>{
                    //console.log("GET_BRAND_PRODUCT", data);
                    context.commit('SET_FILTERS', data);
                });
        }
        , GET_BRAND_LOOKBOOK_DETAIL(context, request){
            let url = "/b2b/pc/home/brand-lookbook?master_idx=" + request.master_idx;
            if(request.detail_idx != null){
                url += "&detail_idx=" + request.detail_idx;
            }
            call_api("GET", url, null, data => {
                //console.log("GET_BRAND_LOOKBOOK_DETAIL", data);
                context.commit("SET_BRAND_LOOKBOOK_DETAIL", data);
            });
        }
    },
    getters : {
        brand_info(state){return state.brand_info;}
        , my_zzim(state){return state.my_zzim;}
        , street_hello(state){return state.street_hello;}
        , is_zzim(state){return state.is_zzim;}
        , street_zzim_count(state){return state.street_zzim_count;}
        , best_product(state){return state.best_product;}
        , total_count(state){return state.total_count;}
        , cate_filter(state){return state.cate_filter;}
        , checked_cate_filter(state){return state.parameter.disp_categories;}
        , search_data(state){return state.search_data;}
        , interview(state){return state.interview;}
        , artistwork(state){return state.artistwork;}
        , lookbook_master(state){return state.lookbook_master;}
        , lookbook_data(state){return state.lookbook_data;}

        /*Default*/
        , parameter(state) { return state.parameter; }
        , filter_data(state){return state.filter_data;}
        , keyword(state) { return state.keyword; }
        , group_type(state){return state.group_type;}
    }
});