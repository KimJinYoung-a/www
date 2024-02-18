const store = new Vuex.Store({
    state : {
        child_character_tab : []
        , parents_character_tab : []
        , events_eventbanner : []
        , events_slidebanner : []
        , mdpick : []
        , bestitem_list : []

        , total_attribCd : ""
        , random_item : []
        , character_item : []
    }
    , actions : {
        GET_ATTRIBUTE_GROUP(context){
            return new Promise(function(resolve, reject){
                let api_data = {
                    "attribDiv" : [401,402,403,404,405]
                    , "target" : "child"
                    , "orderType" : "random"
                    , "deviceType" : "PC"
                };

                call_api("GET", "/event/attribute-group", api_data, function(data){
                    console.log("GET_ATTRIBUTE_GROUP", data);

                    //미니언즈 고정 임시본
                    let target;
                    data.forEach(function(item, index){
                        if(item.attribCd == "401001"){
                            target = item;
                            data.splice(index, 1);
                        }
                    });
                    data.unshift(target);

                    context.commit("SET_CHILD_ATTRIBUTE_GROUP", data);
                });

                api_data.attribDiv = [401,402,403,404,405, 407];
                api_data.target = "parents";
                call_api("GET", "/event/attribute-group", api_data, function(data){
                    console.log("GET_ATTRIBUTE_GROUP", data);
                    context.commit("SET_PARENTS_ATTRIBUTE_GROUP", data);

                    let totalAttribCd = "";
                    let i = 1;
                    context.getters.parents_character_tab.forEach(function(data){
                        totalAttribCd += data.attribCd + ",";
                        i++;
                    });
                    context.commit("SET_TOTAL_ATTRIBCD", totalAttribCd.slice(0, -1));

                    return resolve();
                });
            });
        }
        , GET_EVENTS_EVENTBANNER(context){
            let api_data = {
                "deviceType" : "PC"
                , "mastercode" : 23
                , "attribCdMin" : 400000
                , "attribCdMax" : 405999
            };

            call_api("GET", "/event/events-eventbanner", api_data, function(data){
                console.log("GET_EVENTS_EVENTBANNER", data);
                context.commit("SET_EVENTS_EVENTBANNER", data);
            });
        }
        , GET_EVENTS_SLIDEBANNER(context){
            let api_data = {
                "deviceType" : "PC"
                , "mastercode" : 23
            };

            call_api("GET", "/event/events-slidebanner", api_data, function(data){
                console.log("GET_EVENTS_SLIDEBANNER", data);
                context.commit("SET_EVENTS_SLIDEBANNER", data);
            });
        }
        , GET_MDPICK(context){
            let api_data = {
                "mastercode" : 23
                , "page" : 1
                , "page_size" : 6
            };

            call_api("GET", "/event/mdpick", api_data, function(data){
                console.log("GET_MDPICK", data);
                context.commit("SET_MDPICK", data);
            });
        }
        , GET_BESTITEM(context){
            return new Promise(function(resolve, reject){
                /*if(!attribCd){
                    attribCd = context.getters.total_attribCd;
                }

                let api_data = {
                    "page" : 1
                    , "pageSize" : 6
                    , "attribCd" : attribCd
                    , "deviceType" : "PC"
                    , "sortMethod" : "bs"
                };

                call_api_v3("GET", "/search/itemSearch", api_data, function(data){
                    console.log("itemSearch", data);
                    context.commit("SET_BESTITEM", data);

                    return resolve();
                });*/

                let totalAttribCd = "";
                let attribCdList = new Array();
                let i = 1;
                let complete_count = 0;
                context.getters.parents_character_tab.forEach(function(data){
                    totalAttribCd += data.attribCd + ",";
                    attribCdList[i] = data.attribCd;

                    i++;
                });
                attribCdList[0] = totalAttribCd.slice(0, -1);

                attribCdList.forEach(function(data, index){
                    let api_data = {
                        "page" : 1
                        , "pageSize" : 6
                        , "attribCd" : data
                        , "deviceType" : "PC"
                        , "sortMethod" : "bs"
                    };

                    call_api_v3("GET", "/search/itemSearch", api_data, function(data){
                        let best_search_data = {
                            "index" : index
                            , "items" : data
                        };
                        console.log("itemSearch", best_search_data);
                        context.commit("SET_BESTITEM_LIST", best_search_data);
                        complete_count++;
                        if(complete_count == attribCdList.length){
                            return resolve();
                        }
                    });
                });
            });
        }
        , GET_RANDOM_ITEM(context){
            let api_data = {
                "page" : 2
                , "pageSize" : 50
                , "attribCd" : context.getters.total_attribCd
                , "deviceType" : "PC"
                , "sortMethod" : "bs"
            };

            call_api_v3("GET", "/search/itemSearch", api_data, function(data){
                console.log("GET_RANDOM_ITEM", data);

                let random_item = data.items.filter(item => item.sell_flag == "Y");
                if(random_item){
                    for(let i = 0; i < random_item.length; i++){
                        //random_item.sort(() => Math.random() - 0.5);
                        let j = Math.floor(Math.random() * (i+1));

                        [random_item[i], random_item[j]] = [random_item[j], random_item[i]];
                    }

                    context.commit("SET_RANDOM_ITEM", random_item.slice(0, 48));
                }
            });
        }
        , GET_CHARACTER_ITEM(context){
            return new Promise(function(resolve, reject){
                let complete_count = 0;

                context.getters.parents_character_tab.forEach(function(data, index){
                    let api_data = {
                        "page" : 1
                        , "pageSize" : 3
                        , "attribCd" : data.attribCd
                        , "deviceType" : "PC"
                        , "sortMethod" : "ws"
                    };

                    call_api_v3("GET", "/search/itemSearch", api_data, function(data2){
                        let search_data = {
                            "index" : index
                            , "attribDiv" : data.attribDiv
                            , "items" : data2
                        };
                        console.log("charcater itemSearch", search_data);
                        context.commit("SET_CHARACTOR_ITEM", search_data);
                        complete_count++;
                        if(complete_count == context.getters.parents_character_tab.length){
                            return resolve();
                        }
                    });
                });
            });
        }
    }
    , mutations : {
        SET_CHILD_ATTRIBUTE_GROUP(state, data){
            state.child_character_tab = data;
        }
        , SET_PARENTS_ATTRIBUTE_GROUP(state, data){
            state.parents_character_tab = data;
        }
        , SET_EVENTS_EVENTBANNER(state, data){
            state.events_eventbanner = data;
        }
        , SET_EVENTS_SLIDEBANNER(state, data){
            state.events_slidebanner = data;
        }
        , SET_MDPICK(state, data){
            state.mdpick = data;
        }
        , SET_BESTITEM_LIST(state, data){
            state.bestitem_list[data.index] = data.items;
        }
        , SET_TOTAL_ATTRIBCD(state, data){
            state.total_attribCd = data;
        }
        , SET_RANDOM_ITEM(state, data){
            state.random_item = data;
        }
        , SET_CHARACTOR_ITEM(state, data){
            state.character_item[data.index] = data;
        }
    }
    , getters : {
        child_character_tab(state){
            return state.child_character_tab;
        }
        , parents_character_tab(state){
            return state.parents_character_tab;
        }
        , events_eventbanner(state){
            return state.events_eventbanner;
        }
        , events_slidebanner(state){
            return state.events_slidebanner;
        }
        , mdpick(state){
            return state.mdpick;
        }
        , bestitem_list(state){
            return state.bestitem_list;
        }
        , total_attribCd(state){
            return state.total_attribCd;
        }
        , random_item(state){
            return state.random_item;
        }
        , character_item(state){
            return state.character_item;
        }
    }
});