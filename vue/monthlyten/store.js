let store = new Vuex.Store({
    state : {
        items : [],
        saleInfos: [],
        brands: [],
        events : [],
        firstItems: [],
        secondItems: [],
        thirdItems: [],
        fourthItems: [],
        fifthItems: [],
        sixthItems: [],
        seventhItems: [],
        eighthItems: [],
        freeDelivery: [],
    }
    , actions : {
        GET_ITEMS(context) { // 오늘의 Pick 상품 조회
            let apiData = {
                mastercode: 24,
                detailCode: 100,
                "deviceType" : "MOBILE"
            }
            const success = function(data) {
                context.commit('SET_ITEMS', data);
            }
            call_api('GET', '/event/events-slidebanner', apiData, success)
            
        },
        GET_SALE_INFOS(context) {
            let apiData = {
                mastercode: 24,
                detailCode: 101,
                "deviceType" : "PC"
            }
            const success = function(data) {
                context.commit('SET_SALE_INFOS', data);
            }
            call_api('GET', '/event/events-slidebanner', apiData, success)
        },
        GET_BRAND(context) { // 브랜드 별 모아보기
            let apiData = {
                mastercode: 24,
                detailCode: 300,
                "deviceType" : "PC"
            }
            const success = function(data) {
                context.commit('SET_BRAND', data);
            }
            call_api('GET', '/event/events-slidebanner', apiData, success)
            
        },
        GET_EVENTS(context) { // 이벤트 정보 조회
            let apiData = {
                mastercode: 24,
                detailCode: 400,
                "deviceType" : "PC"
            }
            const success = function(data) {
                context.commit('SET_EVENTS', data);
            }
            call_api('GET', '/event/events-slidebanner', apiData, success)
        },
        GET_CATEGORIES_ITEMS(context) { // 카테고리별 상품 조회
            let apiData = {
                masterCode: 24,
                detailCodes: "200,201,202,203,204,205,206,207"
            }
            const success = function(data) {
                context.commit('SET_CATEGORY_ITEMS', data);
            }
            call_api('GET', '/event/sub-category-of-items', apiData, success)
        },
        GET_FREE_DELIVERY(context) { // 이벤트 정보 조회
            let apiData = {
                mastercode: 24,
                detailCode: 103,
                "deviceType" : "PC"
            }
            const success = function(data) {
                context.commit('SET_FREE_DELIVERY', data);
            }
            call_api('GET', '/event/events-slidebanner', apiData, success)
        },
    }
    , mutations : {
        SET_ITEMS(state, data) {
            state.items = data;
        },
        SET_SALE_INFOS(state, data) {
            state.saleInfos  = data;
        },
        SET_BRAND(state, data) {
            state.brands = data;
        },
        SET_EVENTS(state, data) {
            state.events = data;
        },
        SET_CATEGORY_ITEMS(state, data) {
            data.forEach(function(item) {
                switch(item.detailcode) {
                    case 200 : state.firstItems.push(item); break;
                    case 201 : state.secondItems.push(item); break;
                    case 202 : state.thirdItems.push(item); break;
                    case 203 : state.fourthItems.push(item); break;
                    case 204 : state.fifthItems.push(item); break;
                    case 205 : state.sixthItems.push(item); break;
                    case 206 : state.seventhItems.push(item); break;
                    case 207 : state.eighthItems.push(item); break;
                }
            });
        },
        SET_FREE_DELIVERY(state, data) {
            state.freeDelivery = data;
        }
    }
    , getters : {
        items(state) {
            return state.items;
        },
        saleInfos(state) {
            return state.saleInfos;
        },
        brands(state) {
            return state.brands;
        },
        events(state) { 
            return state.events; 
        },
        saleItems(state) {
            return state.saleItems;
        },
        firstItems(state) {
            return state.firstItems;
        },
        secondItems(state) {
            return state.secondItems;
        },
        thirdItems(state) {
            return state.thirdItems;
        },
        fourthItems(state) {
            return state.fourthItems;
        },
        fifthItems(state) {
            return state.fifthItems;
        },
        sixthItems(state) {
            return state.sixthItems;
        },
        seventhItems(state) {
            return state.seventhItems;
        },
        eighthItems(state) {
            return state.eighthItems;
        },
        freeDelivery(state) {
            return state.freeDelivery;
        }
    }
});

const decodeBase64 = function(str) {
    if( str == null ) return null;
    return atob(str.replace(/_/g, '/').replace(/-/g, '+'));
}