const store = new Vuex.Store({
    state : {
        banners : []
        , bestpick : []
        , recommend : []
    },
    mutations : {
        SET_BANNER_LIST(state, data){
            state.banners = data;
        }
        , SET_BESTPICK_LIST(state, data){
            if( data != null && data.length > 0 ) {
                data.forEach(item => {
                    item.basic_image = decode_base64(item.basic_image);
                    item.add_image = decode_base64(item.add_image);
                    item.move_url = decode_base64(item.move_url);
                    state.bestpick.push(item);
                });
            } else {
                state.bestpick = null;
            }
        }
        , SET_RECOMMEND_LIST(state, data){
            if( data != null && data.length > 0 ) {
                state.recommend = [];
                data.forEach(item => {
                    item.basic_image = decode_base64(item.basic_image);
                    item.add_image = decode_base64(item.add_image);
                    item.move_url = decode_base64(item.move_url);
                    state.recommend.push(item);
                });
            } else {
                state.recommend = null;
            }
        }
    },
    actions : {
        GET_BANNER_LIST(context){
            /*운영 21 / 테스트 17*/
            call_api("get", "/b2b/pc/home/banner-list?masterCode=21", null
                , data=>{
                    context.commit("SET_BANNER_LIST", data);
                });
        }
        , GET_BESTPICK_LIST(context){
            call_api("get", "/b2b/pc/home/bestpick-list", null
                , data=>{
                    context.commit("SET_BESTPICK_LIST", data);
                });
        }
        , GET_RECOMMEND_LIST(context, sortType){
            call_api("get", "/b2b/pc/home/recomenmend-list?sortType=" + sortType, null
                , data=>{
                    context.commit("SET_RECOMMEND_LIST", data);
                });
        }
    },
    getters : {
        banners(state){ return state.banners; }
        , bestpick(state){ return state.bestpick; }
        , recommend(state){ return state.recommend; }
    }
});