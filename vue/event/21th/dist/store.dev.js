"use strict";

var store = new Vuex.Store({
  state: {
    couponInfo: [],
    freeDelivery: [],
    nowDiscount: [],
    oneDaySale: [],
    timeSale: [],
    tentenOfTwentyOne: [],
    tenYoutube: [],
    goods: [],
    appEntryItem: [],
    diaryStory: [],
    bestItem: [],
    firstBuyShop: [],
    hbd: [],
    items: [],
    itemCount: 0,
    page: 1
  },
  actions: {
    GET_BANNER_IMAGE: function GET_BANNER_IMAGE(context, detailCode) {
      var apiData = {
        mastercode: 25,
        detailCode: detailCode,
        "deviceType": "PC"
      };

      var success = function success(data) {
        switch (detailCode) {
          case 100:
            context.commit('SET_COUPON_INFO', data);
            break;

          case 101:
            context.commit('SET_FREE_DELIVERY', data);
            break;

          case 102:
            context.commit('SET_NOW_DISCOUNT', data);
            break;

          case 200:
            context.commit('SET_ONE_DAY_SALE', data);
            break;

          case 201:
            context.commit('SET_TIME_SALE', data);
            break;

          case 202:
            context.commit('SET_TENTEN_OF_TWENTY_ONE', data);
            break;

          case 300:
            context.commit('SET_TEN_YOUTUBE', data);
            break;

          case 400:
            context.commit('SET_GOODS', data);
            break;

          case 401:
            context.commit('SET_APP_ENTRY_ITEM', data);
            break;

          case 402:
            context.commit('SET_DIARY_STORY', data);
            break;

          case 403:
            context.commit('SET_BEST_ITEM', data);
            break;

          case 404:
            context.commit('SET_FIRST_BUY_SHOP', data);
            break;

          case 405:
            context.commit('SET_HBD', data);
            break;
        }
      };

      call_api('GET', '/event/events-slidebanner', apiData, success);
    },
    GET_ITEMS: function GET_ITEMS(context) {
      var apiData = {
        masterCode: 25,
        detailCodes: "406,",
        page: 1,
        pageSize: 20
      };

      var success = function success(data) {
        context.commit('SET_ITEMS', data);
      };

      var success_count = function success_count(data) {
        context.commit('SET_ITEMS_COUNT', data);
      };

      call_api('GET', '/event/sub-category-of-items', apiData, success);
      call_api('GET', '/event/sub-category-of-item-count', apiData, success_count);
    },
    GET_MORE_ITEMS: function GET_MORE_ITEMS(context) {
      var apiData = {
        masterCode: 25,
        detailCodes: "406",
        page: context.getters.page + 1,
        pageSize: 20
      };

      var success = function success(data) {
        context.commit('SET_MORE_ITEMS', data);
        context.commit('SET_PAGE', apiData.page);
      };

      call_api('GET', '/event/sub-category-of-items', apiData, success);
    },
    GET_ONE_DAY_ITEM: function GET_ONE_DAY_ITEM(context) {
      var success = function success(data) {
        context.commit('SET_ONE_DAY_SALE', data);
      };

      call_apiV2('GET', '/today/one-day-item', {}, success);
    }
  },
  mutations: {
    SET_ITEMS: function SET_ITEMS(state, data) {
      state.items = data;
    },
    SET_ITEMS_COUNT: function SET_ITEMS_COUNT(state, data) {
      state.itemCount = data;
    },
    SET_MORE_ITEMS: function SET_MORE_ITEMS(state, data) {
      state.items = state.items.concat(data);
    },
    SET_PAGE: function SET_PAGE(state, data) {
      state.page = data;
    },
    SET_COUPON_INFO: function SET_COUPON_INFO(state, data) {
      state.couponInfo = data;
    },
    SET_FREE_DELIVERY: function SET_FREE_DELIVERY(state, data) {
      state.freeDelivery = data;
    },
    SET_NOW_DISCOUNT: function SET_NOW_DISCOUNT(state, data) {
      state.nowDiscount = data;
    },
    SET_ONE_DAY_SALE: function SET_ONE_DAY_SALE(state, data) {
      state.oneDaySale = data;
    },
    SET_TIME_SALE: function SET_TIME_SALE(state, data) {
      state.timeSale = data[0];
    },
    SET_TENTEN_OF_TWENTY_ONE: function SET_TENTEN_OF_TWENTY_ONE(state, data) {
      state.tentenOfTwentyOne = data;
    },
    SET_TEN_YOUTUBE: function SET_TEN_YOUTUBE(state, data) {
      state.tenYoutube = data;
    },
    SET_GOODS: function SET_GOODS(state, data) {
      state.goods = data[0];
    },
    SET_APP_ENTRY_ITEM: function SET_APP_ENTRY_ITEM(state, data) {
      state.appEntryItem = data[0];
    },
    SET_BEST_ITEM: function SET_BEST_ITEM(state, data) {
      state.bestItem = data[0];
    },
    SET_FIRST_BUY_SHOP: function SET_FIRST_BUY_SHOP(state, data) {
      state.firstBuyShop = data[0];
    },
    SET_DIARY_STORY: function SET_DIARY_STORY(state, data) {
      state.diaryStory = data[0];
    },
    SET_HBD: function SET_HBD(state, data) {
      state.hbd = data;
    }
  },
  getters: {
    items: function items(state) {
      return state.items;
    },
    couponInfo: function couponInfo(state) {
      return state.couponInfo;
    },
    freeDelivery: function freeDelivery(state) {
      return state.freeDelivery;
    },
    nowDiscount: function nowDiscount(state) {
      return state.nowDiscount;
    },
    oneDaySale: function oneDaySale(state) {
      return state.oneDaySale;
    },
    timeSale: function timeSale(state) {
      return state.timeSale;
    },
    tentenOfTwentyOne: function tentenOfTwentyOne(state) {
      return state.tentenOfTwentyOne;
    },
    tenYoutube: function tenYoutube(state) {
      return state.tenYoutube;
    },
    goods: function goods(state) {
      return state.goods;
    },
    appEntryItem: function appEntryItem(state) {
      return state.appEntryItem;
    },
    bestItem: function bestItem(state) {
      return state.bestItem;
    },
    firstBuyShop: function firstBuyShop(state) {
      return state.firstBuyShop;
    },
    diaryStory: function diaryStory(state) {
      return state.diaryStory;
    },
    hbd: function hbd(state) {
      return state.hbd;
    },
    page: function page(state) {
      return state.page;
    },
    itemCount: function itemCount(state) {
      return state.itemCount;
    }
  }
});

var decodeBase64 = function decodeBase64(str) {
  if (str == null) return null;
  return atob(str.replace(/_/g, '/').replace(/-/g, '+'));
};