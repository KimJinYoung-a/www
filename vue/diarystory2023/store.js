const store = new Vuex.Store({
    state : {
        events_link : []
        , events_slidebanner : []
        , event : []
        , ranking_item : []
    }
    , actions : {
        GET_EVENTS_LINK(context, round){
            return new Promise(function(resolve, reject){
                let api_data = {
                    "mastercode" : 10
                };

                call_api("GET", "/event/events-link", api_data, function(data){
                    console.log("GET_EVENTS_LINK", data);
                    context.commit("SET_EVENTS_LINK", data.slice(0,6));

                    return resolve();
                });
            });
        }
        , GET_EVENTS_SLIDEBANNER(context){
            let api_data = {
                "deviceType" : "PC"
                , "mastercode" : 10
            };

            call_api("GET", "/event/events-slidebanner", api_data, function(data){
                console.log("GET_EVENTS_SLIDEBANNER", data);
                context.commit("SET_EVENTS_SLIDEBANNER", data.slice(0,16));
            });
        }
        , GET_EVENT(context){
            call_api("GET", "/diary/events", null, function(data){
                console.log("GET_EVENT", data);
                context.commit("SET_EVENT", data);
            });
        }
        , GET_RANKING_ITEM(context, parameter){
            return new Promise(function(resolve, reject){
                let api_data = {
                    "page" : parameter.page
                    , "pageSize" : 20
                    , "dispCategories" : parameter.cate_code
                    , "deviceType" : "MOBILE"
                    , "sortMethod" : "bs"
                    , "diary" : true
                };

                call_api_v3("GET", "/search/itemSearch", api_data, function(data){
                    console.log("GET_RANKING_ITEM", data);
                    context.commit("SET_RANKING_ITEM", data);
                    app.loading_flag = false;

                    return resolve();
                });
            });
        }
    }
    , mutations : {
        SET_EVENTS_LINK(state, data){
            state.events_link = data;
        }
        , SET_EVENTS_SLIDEBANNER(state, data){
            state.events_slidebanner = data;
        }
        , SET_EVENT(state, data){
            state.event = data;
        }
        , SET_RANKING_ITEM(state, data){
            if(data.current_page > 1){
                console.log(state.ranking_item.items);
                data.items = state.ranking_item.items.concat(data.items);
            }

            state.ranking_item = data;
        }
    }
    , getters : {
        events_link(state){
            return state.events_link;
        }
        , events_slidebanner(state){
            return state.events_slidebanner;
        }
        , event(state){
            return state.event;
        }
        , ranking_item(state){
            return state.ranking_item;
        }
    }
});