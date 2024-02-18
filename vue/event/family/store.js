const store = new Vuex.Store({
    state : {
        evt_code : ""
        , evtgroup_code: 400945
        , evtgroup_index : 1
        , page : 1
        , last_page : 1
        , event_item : []
    }
    , actions : {
        GET_EVENT_ITEM(context){
            let api_data = {
                "evt_code" : context.getters.evt_code
                , "evtgroup_code" : context.getters.evtgroup_code
                , "page" : context.getters.page
                , "page_size" : 8
            };

            call_api("GET", "/event/common/display-none-event-item", api_data, data => {
                console.log("GET_EVENT_ITEM", data);
                context.commit("SET_EVENT_ITEM", data.items);
                context.commit("SET_EVENT_ITEM_LAST_PAGE", data.last_page);

                const $rootEl = $("#itemList");
                let tmpEl = "";
                let itemEle = "";

                if(context.getters.page == 1){
                    $rootEl.empty();
                }

                data.items.forEach(function(item){
                    tmpEl = `
                        <li>
                            <a onclick="goProduct('` + item + `');" href="javascript:void(0)">
                                <div class="thumbnail"><img src="" alt=""></div>
                                <div class="desc">
                                    <p class="brand">브랜드</p>
                                    <p class="name">상품명</p>
                                    <div class="price"><s>정가</s> <span>할인가</span><span class="sale">할인율%</span></div>
                                </div>
                            </a>
                        </li>
                    `;
                    itemEle += tmpEl;
                });
                $rootEl.append(itemEle);

                fnDisplayNoneEventItems({
                    items: data.items
                    , target:"itemList"
                    , fields:["image","name","price","sale", "brand"]
                    , unit:"none"
                    , saleBracket:false
                    , page : context.getters.page
                    , page_size : api_data.page_size
                });
            });
        }
    }
    , mutations : {
        SET_EVT_CODE(state, data){
            state.evt_code = data;
        }
        , SET_PAGE(state, data){
            state.page = data;
        }
        , SET_EVTGROUP_CODE(state, data){
            state.evtgroup_code = data;

            switch (state.evtgroup_code) {
                case '400945' : state.evtgroup_index = 1; break;
                case '400946' : state.evtgroup_index = 2; break;
                case '400947' : state.evtgroup_index = 3; break;
                case '400948' : state.evtgroup_index = 4; break;
                case '400949' : state.evtgroup_index = 5; break;
            }
        }
        , SET_EVENT_ITEM(state, data){
            if(state.page == 1){
                state.event_item = data;
            }else{
                state.event_item = state.event_item.concat(data);
            }
        }
        , SET_EVENT_ITEM_LAST_PAGE(state, data){
            state.last_page = data;
        }
    }
    , getters : {
        evt_code(state){
            return state.evt_code;
        }
        , event_item(state){
            return state.event_item;
        }
        , evtgroup_code(state){
            return state.evtgroup_code;
        }
        , evtgroup_index(state){
            return state.evtgroup_index;
        }
        , page(state){
            return state.page;
        }
        , last_page(state){
            return state.last_page;
        }
    }
});