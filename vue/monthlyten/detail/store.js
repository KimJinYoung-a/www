const store = new Vuex.Store({
  state : {
      child_character_tab : []
      , parents_character_tab : []
      , character_item : []
      , character_item_last_page : 1
      , categories : []
      , swiper_index : 0
  }
  , actions : {
      GET_ATTRIBUTE_GROUP(context){
          return new Promise(function(resolve, reject){
              let api_data = {
                  "attribDiv" : 408
                  , "target" : "child"
                  , "orderType" : "random"
                  , "deviceType" : "MOBILE"
              };


              call_api("GET", "/event/attribute-group", api_data, function(data){
                  console.log("GET_ATTRIBUTE_GROUP", data);
                  context.commit("SET_CHILD_ATTRIBUTE_GROUP", data);
                  return resolve();
              }); 
          });
      }
      , GET_CHARACTER_ITEM(context, data){
          return new Promise(function(resolve, reject){
              let api_data = {
                  "page" : data.page
                  , "pageSize" : 20
                  , "attribCd" : data.attribCd
                  , "deviceType" : "PC"
                  , "sortMethod" : data.sortMethod
                  , "catecode" : data.catecode
              };

              call_api_v3("GET", "/search/itemSearch", api_data, function(data){
                  context.commit("SET_CHARACTOR_ITEM", data);

                  return resolve();
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
      , SET_CHARACTOR_ITEM(state, data){
          if(data.current_page == 1){
              state.character_item = data.items;
          }else{
              state.character_item = state.character_item.concat(data.items);
          }

          state.character_item_last_page = data.last_page;
      }
      , SET_CATEGORIES(state, data){
          state.categories = data;
      }
  }
  , getters : {
      child_character_tab(state){
          return state.child_character_tab;
      }
      , parents_character_tab(state){
          return state.parents_character_tab;
      }
      , character_item(state){
          return state.character_item;
      }
      , character_item_last_page(state){
          return state.character_item_last_page;
      }
      , categories(state){
          return state.categories;
      }
      , swiper_index(state) {
          return state.swiper_index;
      }
  }
});