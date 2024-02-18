
const store = new Vuex.Store({
  state: {
    heart_tab: [],
    category_item: [],
    category_item_last_page: 1,
    categories: [],
  },
  actions: {
    GET_ATTRIBUTE_GROUP(context) {
      return new Promise(function(resolve, reject) {
        let api_data = {
          "attribDiv" : 409
          , "target" : "child"
          , "deviceType" : "PC"
        };

        call_api("GET", "/event/attribute-group", api_data, function(data) {
          context.commit("SET_HEART_GROUP", data);
          return resolve();
        })
      });
    },
    GET_CATEGORIES(context, attribCd) {
      let api_data = {
        "attribCd" : attribCd
      };

      const success = function(data) {
        let result_categories = new Array();
        result_categories.push({
          "cate_code" : ""
          , "cate_name" : "전체"
        });

        context.commit('SET_CATEGORIES', result_categories.concat(data));
      }

      call_api("GET", "/event/categories-of-attribute", api_data, success);
    },
    GET_CATEGORY_ITEM(context, data) {
      return new Promise(function(resolve, reject) {
        let api_data = {
          "page" : data.page
          , "pageSize" : 20
          , "attribCd" : data.attribCd
          , "deviceType" : "PC"
          , "sortMethod" : data.sortMethod
          , "catecode" : data.catecode
        };

        call_api_v3("GET", "/search/itemSearch", api_data, function(data){
          context.commit("SET_CATEGORY_ITEM", data);

          return resolve();
        });
      });
    }
  },
  mutations: {
    SET_HEART_GROUP(state, data) {
      state.heart_tab = data;
    },
    SET_CATEGORY_ITEM(state, data) {
      if (data.current_page == 1) {
        state.category_item = data.items;
      } else {
        state.category_item = state.category_item.concat(data.items);
      }

      state.category_item_last_page = data.last_page;
    },
    SET_CATEGORIES(state, data) {
      state.categories = data
    }
  },
  getters: {
    heart_tab(state) {
      return state.heart_tab;
    },
    category_item(state) {
      return state.category_item;
    },
    category_item_last_page(state) {
      return state.category_item_last_page;
    },
    categories(state) {
      return state.categories;
    }
  }
});