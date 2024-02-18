const store = new Vuex.Store({
    state : {
        evt_code : ""
        , check_coupon_valid : false
        , check_mileage_valid : false
        , check_buyable : true
        , itemid : null
        , check_soldout : false
        , item_buy_count : 0
    }
    , actions : {
        GET_COUPON_VALID(context){
            let api_data = {
                "event_code" : context.getters.evt_code
                , "check_option3" : true
                , "event_option3" : "try"
            };

            call_api("GET", "/event/common/event-subscript-count", api_data, data => {
                console.log("GET_COUPON_VALID", data);
                context.commit("SET_COUPON_VALID", data);
            });
        }
        , GET_MILEAGE_VALID(context){
            let api_data = {
                "event_code" : 118454
            };

            call_api("GET", "/event/common/event-subscript-count", api_data, data => {
                console.log("GET_MILEAGE_VALID", data);
                context.commit("SET_MILEAGE_VALID", data);
            });
        }
        , GET_BUY_COUNT(context){
            let api_data = {
                "itemid_str" : "4606013,4606014,4606015,4606016"
                , "evt_code" : context.getters.evt_code
            };

            call_api("GET", "/event/common/order-info", api_data, data => {
                console.log("GET_BUY_COUNT_1", data);
                context.commit("SET_BUY_COUNT", data);
            });

            if(context.getters.itemid){
                api_data = {
                    "itemid_str" : context.getters.itemid
                    , "evt_code" : context.getters.evt_code
                };
                call_api("GET", "/event/common/order-count", api_data, data => {
                    console.log("GET_BUY_COUNT_2", data);
                    context.commit("SET_ITEM_BUY_COUNT", data);
                });
            }else{
                context.commit("SET_ITEM_BUY_COUNT", 9999);
            }
        }
    }
    , mutations : {
        SET_EVT_CODE(state, data){
            state.evt_code = data;
        }
        , SET_COUPON_VALID(state, data){
            if(data < 175000){
                state.check_coupon_valid = true;
            }else{
                state.check_coupon_valid = false;
            }
        }
        , SET_MILEAGE_VALID(state, data){
            if(data < 60000){
                state.check_mileage_valid = true;
            }else{
                state.check_mileage_valid = false;
            }
        }
        , SET_BUY_COUNT(state, data){
            if(data.itemid){
                state.check_buyable = false;
            }
        }
        , SET_ITEMID(state, data){
            state.itemid = data;
        }
        , SET_ITEM_BUY_COUNT(state, data){
            state.item_buy_count = data;

            if(data >= 500){
                state.check_soldout = true;
            }
        }
    }
    , getters : {
        evt_code(state){
            return state.evt_code;
        }
        , check_coupon_valid(state){
            return state.check_coupon_valid;
        }
        , check_mileage_valid(state){
            return state.check_mileage_valid;
        }
        , check_buyable(state){
            return state.check_buyable;
        }
        , itemid(state){
            return state.itemid;
        }
        , check_soldout(state){
            return state.check_soldout;
        }
        , item_buy_count(state){
            return state.item_buy_count;
        }
    }
});