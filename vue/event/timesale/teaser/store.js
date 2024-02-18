const store = new Vuex.Store({
    state : {
        mikki_list : []
        , teaser_info : {}
    },
    mutations : {
        SET_MIKKI_LIST(state, data){
            state.mikki_list = data;
        }
        , SET_TEASER_INFO(state, data){
            state.teaser_info = data;
        }
    }
    , actions : {
        GET_MIKKI_LIST(context, eventid){
            //let query_param = new URLSearchParams(window.location.search);
            let now_url = location.search.substr(location.search.indexOf("?") + 1);
            now_url = now_url.split("&");
            //console.log(now_url);
            let result = "";
            for(let i = 0; i < now_url.length; i++){
                let temp_param = now_url[i].split("=");
                if(temp_param[0] == "setting_time"){
                    result = temp_param[1].replace("%20", " ");
                }
            }
            //let setting_time = query_param.get("setting_time");
            let setting_time = result;

            let api_data = {"tz_evt_code" : eventid};
            if(setting_time){
                api_data = {"tz_evt_code" : eventid, "setting_time" : setting_time};
            }

            call_api("GET", "/timedeal/check-valid-event", api_data
                , data=>{
                    //console.log("CHECK_VALID_EVENT", data);
                    if(data.count > 0){
                        let setting_time_param = "";
                        if(is_develop || is_staging){
                            setting_time_param = "&setting_time=" + setting_time;
                        }
                        location.href = "/event/eventmain.asp?eventid=" + data.evt_code + setting_time_param;
                    }else{
                        call_api("GET", "/timedeal/timedeal-teaser", api_data
                            , data=>{
                                console.log("GET_MIKKI_LIST", data);
                                context.commit("SET_MIKKI_LIST", data);
                            }
                        );
                    }
                }
            );
        }
        , GET_TEASER_INFO(context, eventid){
            call_api("GET", "/timedeal/timedeal-next-schedule-teaser", {"tz_evt_code" : eventid}, function (data){
                console.log("check", data);
                context.commit("SET_TEASER_INFO", data);
            });
        }
    }
    , getters : {
        mikki_list(state){
            return state.mikki_list;
        }
        , teaser_info(state){
            return state.teaser_info;
        }
    }
});