let store = new Vuex.Store({
    state : {
        couponInfo: []
        , freeDelivery: []
        , nowDiscount: []
        , oneDaySale: []
        , timeSale: []
        , tentenOfTwentyOne: []
        , tenYoutube: []
        , goods: []
        , appEntryItem: []
        , diaryStory: []
        , bestItem: []
        , firstBuyShop: []
        , hbd: []
        , items: []
        , itemCount: 0
        , page: 1
    }
    , actions : {
        GET_BANNER_IMAGE(context, detailCode) {
            let apiData = {
                mastercode: 25,
                detailCode: detailCode,
                "deviceType" : "PC"
            }
            const success = function(data) {
                switch(detailCode) {
                    case 100: context.commit('SET_COUPON_INFO', data); break;
                    case 101: context.commit('SET_FREE_DELIVERY', data); break;
                    case 102: context.commit('SET_NOW_DISCOUNT', data); break;
                    case 200: context.commit('SET_ONE_DAY_SALE', data); break;
                    case 201: context.commit('SET_TIME_SALE', data); break;
                    case 202: context.commit('SET_TENTEN_OF_TWENTY_ONE', data); break;
                    case 300: context.commit('SET_TEN_YOUTUBE', data); break;
                    case 400: context.commit('SET_GOODS', data); break;
                    case 401: context.commit('SET_APP_ENTRY_ITEM', data); break;
                    case 402: context.commit('SET_DIARY_STORY', data); break;
                    case 403: context.commit('SET_BEST_ITEM', data); break;
                    case 404: context.commit('SET_FIRST_BUY_SHOP', data); break;
                    case 405: context.commit('SET_HBD', data); break;
                }
            }
            call_api('GET', '/event/events-slidebanner', apiData, success)

        },
        GET_ITEMS(context) {
            let apiData = {
                masterCode: 25,
                detailCodes: "406,",
                page: 1,
                pageSize: 20
            }
            const success = function(data) {
                context.commit('SET_ITEMS', data);
            }
            const success_count = function(data) {
                context.commit('SET_ITEMS_COUNT', data);
            }
            call_api('GET', '/event/sub-category-of-items', apiData, success)
            call_api('GET', '/event/sub-category-of-item-count', apiData, success_count)
        },
        GET_MORE_ITEMS(context) {
            let apiData = {
                masterCode: 25,
                detailCodes: "406",
                page: context.getters.page + 1,
                pageSize: 20
            }
            const success = function(data) {
                context.commit('SET_MORE_ITEMS', data);
                context.commit('SET_PAGE', apiData.page);
            }
            call_api('GET', '/event/sub-category-of-items', apiData, success)
        },
        GET_ONE_DAY_ITEM(context) {
            const success = function(data) {
                context.commit('SET_ONE_DAY_SALE', data);
            }
            call_apiV2('GET', '/today/one-day-item', {}, success)
        }
    }
    , mutations : {
        SET_ITEMS(state, data) {
            state.items = data;
        },
        SET_ITEMS_COUNT(state, data) {
            state.itemCount = data;
        },
        SET_MORE_ITEMS(state, data) {
            state.items = state.items.concat(data);
        },
        SET_PAGE(state, data) {
            state.page = data;
        },
        SET_COUPON_INFO(state, data) {
            state.couponInfo = data;
        },
        SET_FREE_DELIVERY(state, data) {
            state.freeDelivery = data;
        },
        SET_NOW_DISCOUNT(state, data) {
            state.nowDiscount = data;
        },
        SET_ONE_DAY_SALE(state, data) {
            state.oneDaySale = data;
        },
        SET_TIME_SALE(state, data) {
            state.timeSale = data[0];
        },
        SET_TENTEN_OF_TWENTY_ONE(state, data) {
            state.tentenOfTwentyOne = data;
        },
        SET_TEN_YOUTUBE(state, data) {
            state.tenYoutube = data;
        },
        SET_GOODS(state, data) {
            state.goods = data[0];
        },
        SET_APP_ENTRY_ITEM(state, data) {
            state.appEntryItem = data[0];
        },
        SET_BEST_ITEM(state, data) {
            state.bestItem = data[0];
        },
        SET_FIRST_BUY_SHOP(state, data) {
            state.firstBuyShop = data[0];
        },
        SET_DIARY_STORY(state, data) {
            state.diaryStory = data[0];
        },
        SET_HBD(state, data) {
            state.hbd = data;
        }
    }
    , getters : {
        items(state) {
            return state.items;
        },
        couponInfo(state) {
            return state.couponInfo;
        },
        freeDelivery(state) {
            return state.freeDelivery;
        },
        nowDiscount(state) {
            return state.nowDiscount;
        },
        oneDaySale(state) {
            return state.oneDaySale;
        },
        timeSale(state) {
            return state.timeSale;
        },
        tentenOfTwentyOne(state) {
            return state.tentenOfTwentyOne;
        },
        tenYoutube(state) {
            return state.tenYoutube;
        },
        goods(state) {
            return state.goods;
        },
        appEntryItem(state) {
            return state.appEntryItem;
        },
        bestItem(state) {
            return state.bestItem;
        },
        firstBuyShop(state) {
            return state.firstBuyShop;
        },
        diaryStory(state) {
            return state.diaryStory;
        },
        hbd(state) {
            return state.hbd;
        },
        page(state) {
            return state.page;
        },
        itemCount(state) {
            return state.itemCount;
        }
    }
});

const decodeBase64 = function(str) {
    if( str == null ) return null;
    return atob(str.replace(/_/g, '/').replace(/-/g, '+'));
}