let store = new Vuex.Store({
  state : {
    category_items: [],
    linker_posting: [],
    myClapCounts : {},
  },
  actions : {
    GET_CATEGORIES_ITEMS(context, detailCode) { // 오늘의 Pick 상품 조회
      return new Promise(function(resolve, reject) {
        let api_data = {
          "page" : 1
          , "pageSize" : 8
          , "attribCd" : detailCode
          , "deviceType" : "PC"
          , "sortMethod" : "best"
          , "catecode" : ""
        };

        const success = function(data) {
          context.commit("SET_CATEGORY_ITEMS", data);
          return resolve();
        }

        call_api_v3("GET", "/search/itemSearch", api_data, success);
      });
    },
    SET_LINKER_POSTING(context) {
      let forumIndex = 8;
      const success = function(data) {
        console.log(data)
        context.commit('SET_LINKER_POSTING', data);
      }

      call_apiV2('GET', '/linker/postings/forum/' + forumIndex, null, success);
    },
    GET_MY_CLAP_COUNTS(context) {
      call_apiV2('GET', '/linker/clap/my/count', null,
          data => context.commit('SET_MY_CLAP_COUNTS', data));
    },
  },
  mutations : {
    SET_CATEGORY_ITEMS(state, data) {
      state.category_items = data;
    },
    SET_LINKER_POSTING(state, data) {
      console.log(data)
      state.linker_posting = data;
    },
    SET_MY_CLAP_COUNTS(state, counts) {
      state.myClapCounts = counts;
    },
    PUT_MY_CLAP_COUNTS(state, idx) {
      state.myClapCounts[idx] = 1;
    },
    ADD_MY_CLAP_COUNTS(state, idx) {
      state.myClapCounts[idx]++;
    },
  },
  getters : {
    category_items(state) { return state.category_items; },
    linker_posting(state) { return state.linker_posting; },
    myClapCounts(state) { return state.myClapCounts; },
  }
});

const decodeBase64 = function(str) {
  if( str == null ) return null;
  return atob(str.replace(/_/g, '/').replace(/-/g, '+'));
}


