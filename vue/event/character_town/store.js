const store = new Vuex.Store({
    state : {
        evt_code : ""
        , evtgroup_code: ['400982', '400983']
        , evtgroup_index : 1
        , page : 1
        , last_page : 1
        , event_item : []
        , parents_evtgroup : []
        , child_evtgroup : []
    }
    , actions : {
        GET_EVENT_ITEM(context){
            let api_data = {
                "evt_code" : context.getters.evt_code
                , "evtgroup_code" : context.getters.evtgroup_code
                , "page" : context.getters.page
                , "page_size" : 16
            };

            $.ajax({
                type: "GET"
                , url: apiurl + "/event/common/display-none-event-item"
                , data: api_data
                , ContentType: "json"
                , crossDomain: true
                , xhrFields: {
                    withCredentials: true
                }
                , traditional : true
                , success: function(data){
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
                                <div class="etc">
                                    <div class="tag review"><span class="icon icon-rating"><i style="width:100%;"></i></span><span class="counting" title="리뷰 개수">999+</span></div>
                                </div>
                                <div class="wish" id="wish` + item + `" onclick="fnWishAdd('` + item + `');"></div>
                            </li>
                        `;
                        itemEle += tmpEl;
                    });
                    $rootEl.append(itemEle);

                    fnDisplayNoneEventItems({
                        items: data.items
                        , target:"itemList"
                        , fields:["image","name","price","sale", "brand","wish","evaluate"]
                        , unit:"none"
                        , saleBracket:false
                        , page : context.getters.page
                        , page_size : 16
                    });
                }
            });
        }
        , GET_PARENTS_EVTGROUP(context){
            const _this = this;
            let api_data = {
                "evt_code" : context.getters.evt_code
                , "evtgroup_pcode" : 0
            };

            call_api("GET", "/event/common/display-none-event-item-group", api_data, data => {
                console.log("GET_PARENTS_EVTGROUP", data);
                context.commit("SET_PARENTS_EVTGROUP", data);
                app.active_parents_evtgroup = data[0].evtgroup_code;
                app.active_evtgroup_name = data[0].evtgroup_desc;
                context.dispatch("GET_CHILD_EVTGROUP", data[0].evtgroup_code);
            });
        }
        , GET_CHILD_EVTGROUP(context, evtgroup_pcode){
            const _this = this;
            let api_data = {
                "evt_code" : context.getters.evt_code
                , "evtgroup_pcode" : evtgroup_pcode
            };

            call_api("GET", "/event/common/display-none-event-item-group", api_data, data => {
                console.log("GET_CHILD_EVTGROUP", data);
                context.commit("SET_CHILD_EVTGROUP", data);

                let tmpArray = [];
                data.forEach(function(item){
                    tmpArray.push(item.evtgroup_code);
                });

                if(tmpArray.length == 0){
                    tmpArray.push(evtgroup_pcode);
                }
                context.commit("SET_EVTGROUP_CODE", tmpArray);
                context.dispatch("GET_EVENT_ITEM");
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
        , SET_PARENTS_EVTGROUP(state, data){
            state.parents_evtgroup = data;
        }
        , SET_CHILD_EVTGROUP(state, data){
            state.child_evtgroup = data;
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
        , parents_evtgroup(state){
            return state.parents_evtgroup;
        }
        , child_evtgroup(state){
            return state.child_evtgroup;
        }
    }
});