const MASTER_CODE = {
  MONTHLY_TEN_TEN: 24,
};

const storeData = new Vuex.Store({
  state : {
    isLoading: false,
    itemList: [],
    itemListLastPage: 0,
    brandList: [],
    categoryList: [],
  },
  getters : {
    isLoading(state) {
      return state.isLoading;
    },
    itemList(state) {
      return state.itemList;
    },
    itemListLastPage(state) {
      return state.itemListLastPage;
    },
    brandList(state) {
      return state.brandList;
    },
    categoryList(state) {
      return state.categoryList;
    },
  },
  mutations : {
    SET_IS_LOADING(state, payload) {
      state.isLoading = payload;
    },
    SET_ITEM_LIST(state, payload) {
      if (payload.current_page === 1) {
        state.itemList = payload.items;
      } else {
        if (payload.current_page <= payload.last_page) {
          state.itemList = state.itemList.concat(payload.items);
        }
      }
      state.itemListLastPage = payload.last_page;
    },
    SET_BRAND_LIST(state, payload) {
      state.brandList = payload;
    },
    SET_CATEGORY_LIST(state, payload) {
      state.categoryList = payload;
    },
  },
  actions : {
    UPDATE_IS_LOADING(context, params) {
      context.commit('SET_IS_LOADING', params);
    },
    async GET_ITEM_LIST(context, params) {
      context.commit('SET_IS_LOADING', true);
      try {
        const baseUrl = 'https://fapi.10x10.co.kr/api/web/v3/search/itemSearch';
        const baseQueryString = 'pageSize=20&attribCd=410101&deviceType=MOBILE';
        let extraQueryString = '';
        if (params.currentPage) {
          extraQueryString += `&page=${params.currentPage}`;
        }

        if (params.sortOption) {
          extraQueryString += `&sortMethod=${params.sortOption}`;
        }

        if (!!params.makerIds) {
          extraQueryString += `&makerIds=${params.makerIds}`;
        }

        if (!!params.categoryCode) {
          extraQueryString += `&catecode=${params.categoryCode}`;
        }

        const targetUrl = `${baseUrl}?${baseQueryString}${extraQueryString}`;
        const response = await fetch(targetUrl);
        if (response.ok) {
          const json = await response.json();
          if (json.items) {
            context.commit('SET_ITEM_LIST', json);
          }

          context.commit('SET_IS_LOADING', false);
        }
      } catch (e) {
        context.commit('SET_IS_LOADING', false);
      }
    },
    async GET_BRAND_LIST(context) {
      try {
        const targetUrl = `https://gateway.10x10.co.kr/v1/event/apis/exhibition-brand-group/${MASTER_CODE.MONTHLY_TEN_TEN}`;
        const response = await fetch(targetUrl);
        if (response.ok) {
          const json = await response.json();
          if (json.status === 200) {
            context.commit('SET_BRAND_LIST', json.result);
          }
        }
      } catch (e) {}
    },
    async GET_CATEGORY_LIST(context) {
      try {
        const targetUrl = `https://fapi.10x10.co.kr/api/web/v1/event/categories-of-attribute?attribCd=410101`;
        const response = await fetch(targetUrl);
        if (response.ok) {
          const json = await response.json();
          const newList = [{
            cate_code : '',
            cate_name : '전체',
          }];

          context.commit('SET_CATEGORY_LIST', newList.concat(json));
        }
      } catch (e) {}
    },
  }
});