const store = new Vuex.Store({
    state : {
        evt_code : ""
        , schedule_idx: ""
        , now_mikki : {}
        , left_mikki_list : []
        , normal_list : []
        , kakao_info : {}
        , my_win : null
        , winners_list : []
    }
    , actions : {
        GET_DATA(context){
            const _this = this;

            return new Promise(function (resolve, reject){
                let api_data = {"evt_code" : context.getters.evt_code};

                call_api("GET", "/timedeal/timedeal-scheduleidx", api_data
                    , data=>{
                        //console.log("GET_SCHEDULE_IDX", data);
                        if(data.toString() != null && data.toString() != ""){
                            context.commit("SET_SCHEDULE_IDX", data);
                            resolve();
                        }else{
                            alert("진행중인 타임세일이 없습니다.");
                            reject("진행중인 타임세일이 없습니다.");
                        }
                    }
                );
            }).then(function (){
                let api_data = {"evt_code" : context.getters.evt_code, "schedule_idx" : context.getters.schedule_idx};


                call_api("GET", "/timedeal/timedeal-raffle-mikki", api_data
                    , data=>{
                        console.log("GET_MIKKI", data);
                        context.commit("SET_NOW_MIKKI", data[0]);

                        let temp_left_mikki_list_list = [];

                        data.forEach(function (item, index){
                            if(index == 0){
                                return 1;
                            }

                            temp_left_mikki_list_list.push(item);
                        });
                        context.commit("SET_LEFT_MIKKI_list", temp_left_mikki_list_list);
                    }
                );

                call_api("GET", "/timedeal/timedeal-normal", {"evt_code" : context.getters.evt_code, "schedule_idx" : context.getters.schedule_idx}
                    , data=>{
                        console.log("GET_NORMAL_LIST", data);
                        context.commit("SET_NORMAL_LIST", data);

                        const $rootEl = $("#itemList");
                        let tmpEl = "";
                        let itemEle = "";
                        $rootEl.empty();

                        data.forEach(function(item){
                            tmpEl = `
                                <li>
                                    <a href="" onclick="goProduct('` + item + `');return false;">
                                        <div class="thumbnail"><img src="" alt=""></div>
                                        <div class="desc">
                                            <p class="brand">브랜드</p>
                                            <p class="name">상품명상품명상품명상품명상품명상품명</p>
                                            <div class="price"><s>정가</s> <span>할인가</span><span class="sale">할인율%</span></div>
                                        </div>
                                    </a>
                                </li>
                            `
                            itemEle += tmpEl
                        });
                        $rootEl.append(itemEle)

                        fnApplyItemInfoList({
                            items: data,
                            target:"itemList",
                            fields:["image","name","price","sale", "brand"],
                            unit:"none",
                            saleBracket:false
                        });
                    }
                );
            });
        }
        , GET_TIMESALE_RAFFLE_KAKAO_INFO(context){
            call_api("GET", "/timedeal/kakao", {"evt_code" : context.getters.evt_code}
                , data=> {
                    context.commit("SET_KAKAO_INFO", data);
                }
            );
        }
        , GET_TIMESALE_RAFFLE_WINNER(context){
            call_api("GET", "/timedeal/winner", {"evt_code" : context.getters.evt_code}
                , data=> {
                    context.commit("SET_WINNER", data);
                }
            );
        }
    }
    , mutations : {
        SET_EVT_CODE(state, data){
            state.evt_code = data;
        }
        , SET_SCHEDULE_IDX(state, data){
            state.schedule_idx = data;
        }
        , SET_NOW_MIKKI(state, data){
            state.now_mikki = data;
        }
        , SET_LEFT_MIKKI_list(state, data){
            state.left_mikki_list = data;
        }
        , SET_NORMAL_LIST(state, data){
            state.normal_list = data;
        }
        , SET_KAKAO_INFO(state, data){
            state.kakao_info = data;
        }
        , SET_WINNER(state, data){
            state.my_win = data.myWinHistory;
            state.winners_list = data.winnersList;
        }
    }
    , getters : {
        evt_code(state){
            return state.evt_code;
        }
        , schedule_idx(state){
            return state.schedule_idx;
        }
        , now_mikki(state){
            return state.now_mikki;
        }
        , left_mikki_list(state){
            return state.left_mikki_list;
        }
        , normal_list(state){
            return state.normal_list;
        }
        , kakao_info(state){
            return state.kakao_info;
        }
        , my_win(state){
            return state.my_win;
        }
        , winners_list(state){
            return state.winners_list;
        }
    }
});