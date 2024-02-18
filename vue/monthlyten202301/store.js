let store = new Vuex.Store({
    state : {
        Items1: [],
        Items2: [],
        Items3: [],
        Items4: [],
        Items5: [],
        Items6: [],
        Items7: [],
        Items8: [],
        Items9: [],
        Items10: [],
        mdchoiceItems: [],
        firstItems: [],
    }
    , actions : {
        GET_CATEGORIES_ITEMS(context) { // 카테고리별 상품 조회
            let apiData = {
                masterCode: 24,
                detailCodes: "601,602,604,606,607,608,611,612,613,614",
                "deviceType" : "MOBILE",
            }
            const success = function(data) {
                context.commit('SET_CATEGORY_ITEMS', data);
            }
            call_api('GET', '/event/sub-category-of-items', apiData, success)
        },
        GET_PRESENT_CATEGORIES_ITEMS(context) { // 카테고리별 상품 조회
            let apiData = {
                masterCode: 24,
                detailCodes: "510"
            }
            const success = function(data) {
                context.commit('SET_PRESENT_CATEGORY_ITEMS', data);
            }
            call_api('GET', '/event/sub-category-of-items', apiData, success)
        },
        GET_MDCHOICE_ITEMS(context) { // 오늘의 큐레이션
            let apiData = {
                mastercode: 24,
                detailCode: 500,
                "deviceType" : "MOBILE"
            }
            const success = function(data) {
                context.commit('SET_MDCHOICE_ITEMS', data);
            }
            call_api('GET', '/event/events-slidebanner', apiData, success)
            
        },
    }
    , mutations : {
        SET_CATEGORY_ITEMS(state, data) {
            data.forEach(function(item) {
                switch(item.detailcode) {
                    // 리스트의 데이터는 통합이벤트에서 불러오고, 상세보기 페이지는 상품속성에서 불어오는 구조이기 때문에 서로 카테고리 코드를 매칭해야한다.
                    // 리스트의 실제 보이는 구조는 상세보기 상품속성에서 불러오는 구조에 맞추어서 뿌려준다.
                    // 기획에서 그렇게 따로 2개로 운영한다고 해서 서로 카테고리 코드를 매칭하는 수뿐이 없음.
                    case 601 : // 디자인문구(통합기획전쪽)
                        if(state.Items1.length < 3) state.Items1.push(item); break; // 디자인문구(리스트의 상품속성)
                    case 602 : // 디지털/핸드폰(통합기획전쪽)
                        if(state.Items2.length < 3) state.Items2.push(item); break; // 디지털/핸드폰(리스트의 상품속성)
                    case 604 : // 토이/취미(통합기획전쪽)
                        if(state.Items3.length < 3) state.Items3.push(item); break; // 토이/취미(리스트의 상품속성)
                    case 606 : // 키친(통합기획전쪽)
                        if(state.Items4.length < 3) state.Items4.push(item); break; // 키친(리스트의 상품속성)
                    case 607 : // 패션잡화(통합기획전쪽)
                        if(state.Items5.length < 3) state.Items5.push(item); break; // 패션잡화(리스트의 상품속성)
                    case 608 : // 패션의류(통합기획전쪽)
                        if(state.Items6.length < 3) state.Items6.push(item); break; // 패션의류(리스트의 상품속성)
                    case 611 : // 패브릭/생활(통합기획전쪽)
                        if(state.Items7.length < 3) state.Items7.push(item); break; // 패브릭/생활(리스트의 상품속성)
                    case 612 : // 가구/수납(통합기획전쪽)
                        if(state.Items8.length < 3) state.Items8.push(item); break; // 가구/수납(리스트의 상품속성)
                    case 613 : // 데코/조명(통합기획전쪽)
                        if(state.Items9.length < 3) state.Items9.push(item); break; // 데코/조명(리스트의 상품속성)
                    case 614 : // 디자인가전(통합기획전쪽)
                        if(state.Items10.length < 3) state.Items10.push(item); break; // 디자인가전(리스트의 상품속성)
                }
            });
        },
        SET_PRESENT_CATEGORY_ITEMS(state, data) {
            data.forEach(function(item) {
                switch(item.detailcode) {
                    case 510 : if(state.firstItems.length < 7) state.firstItems.push(item); break;
                }
            });
        },
        SET_MDCHOICE_ITEMS(state, data) {
            data.forEach(function(item) {
                if(state.mdchoiceItems.length < 5) state.mdchoiceItems.push(item);
            });
        },
    }
    , getters : {
        Items1(state) {
            return state.Items1;
        },
        Items2(state) {
            return state.Items2;
        },
        Items3(state) {
            return state.Items3;
        },
        Items4(state) {
            return state.Items4;
        },
        Items5(state) {
            return state.Items5;
        },
        Items6(state) {
            return state.Items6;
        },
        Items7(state) {
            return state.Items7;
        },
        Items8(state) {
            return state.Items8;
        },
        Items9(state) {
            return state.Items9;
        },
        Items10(state) {
            return state.Items10;
        },
        firstItems(state) {
            return state.firstItems;
        },
        mdchoiceItems(state) {
            return state.mdchoiceItems;
        }
    }
});
