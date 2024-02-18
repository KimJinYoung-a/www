const store = new Vuex.Store({
    state : {
        eventCode : '',
        eventGroup : [],
        eventGroupPcode : 0
    }
    , actions : {
        GET_EVENT_GROUP(context, eventCode){
            return new Promise(function(resolve, reject){
                context.commit('SET_EVENT_CODE', eventCode);
                let param = {
                    evt_code : eventCode,
                    evtgroup_pcode : 0
                }
                getFrontApiData('GET', '/event/common/display-none-event-item-group', param,
                data => {
                    context.commit('SET_EVENT_GROUP', data);
                    return resolve();
                });
            });
        },
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
    }
    , mutations : {
        SET_EVENT_CODE(state, data) {
            state.eventCode = data;
        },
        SET_EVENT_GROUP(state, data){
            state.eventGroup = data;
            state.eventGroup.forEach((v,i) => {
                let param = {
                    evt_code : state.eventCode,
                    evtgroup_pcode : v.evtgroup_code
                };
                $.ajax({
                    type: 'GET',
                    url: apiurl + '/event/common/display-none-event-item-group',
                    data: param,
                    ContentType: "json",
                    crossDomain: true,
                    async: false,
                    xhrFields: {
                        withCredentials: true
                    },
                    success: function(data) {
                        v.child_group = data;
                    }
                });
            });
        }
    }
    , getters : {
        eventGroup(state) {
            return state.eventGroup;
        },
        eventCode(state) {
            return state.eventCode;
        }
    }
});