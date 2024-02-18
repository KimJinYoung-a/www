var dataurl = "/apps/webapi/exhibition/";
var data_itemlists = dataurl+"getitemlist.asp";
var data_eventlists = dataurl+"geteventlist.asp";
var data_slidelists = dataurl+"getslidelist.asp";

let store = new Vuex.Store({
    state : {
        params : {
            masterCode : '1',
            category : '-1',
            page : 1,
            pageSize : 20,
            listType : 'A',
            isPick : '',
            totalPage : 0,
            totalCount : 0,
            pageBlock : 10,
        },
        itemLists : []
    },
    getters : {
        getPartitionItemListSorting : function(state) {
            function compare(a, b) {
                if (parseInt(a.category) < parseInt(b.category)) {
                    return -1;
                }
                if (parseInt(a.category) > parseInt(b.category)) {
                    return 1;
                }
                return 0;
            }
            return state.partitionItemLists.sort(compare);
        },
    },
    mutations : {
        SET_MASTERCODE : function(state , payload) {
            state.params.masterCode = payload;
        },
        SET_CATEGORY : function(state , payload) {
            state.params.category = payload;
            state.params.page = 1; // 카테고리 변경시 페이징 넘버 1 초기화
        },
        SET_PAGESIZE : function(state , payload) {
            state.params.pageSize = payload.pageSize;
        },
        SET_LIMITCOUNT : function(state, payload) {
            state.params.itemShowLimitCount = payload.itemShowLimitCount;
        },
        GET_ITEMLISTS : function(state , payload) {
            state.itemLists = payload.itemList;
            state.params.totalPage = payload.paging.totPg;
            state.params.totalCount = payload.paging.totalcnt;
        },
        CLEAR_ITEMLISTS : function(state) {
            state.itemLists = [];
        },
        SET_PAGENUMBER : function(state , payload) {
            state.params.page = payload;
        }
    },
    actions : {
        // API 는 여기서 호출
        GET_ITEMLISTS : function(context) {
            //console.log("masterCode", this.state.params.masterCode, "/",this.state.params.category);

            let _self = this.state.params;
            let _url = apiurl + "/tempEvent/love-is-now?masterCode="+ _self.masterCode +"&detailCode="+ _self.category +"&page="+ _self.page +"&pagesize="+ _self.pageSize +"&listtype="+ _self.listType +"&ispick="+ _self.isPick + "&deviceType=p";

            let getData = new Promise(function(resolve , reject) {
                $.ajax({
                    type: "GET",
                    url: _url,
                    ContentType: "json",
                    crossDomain: true,
                    xhrFields: {
                        withCredentials: true
                    },
                    success: function (data) {
                        //console.log('GET_ITEMLISTS', data);

                        return resolve(data);
                    },
                    error: function (xhr) {
                        console.log(xhr.responseText);
                        return reject();
                    }
                });
            });

            getData.then(function(data) {
                context.commit('CLEAR_ITEMLISTS');
                context.commit('GET_ITEMLISTS', data);
            }, function(reason) {
                console.log(reason);
            });
        }
    }
})