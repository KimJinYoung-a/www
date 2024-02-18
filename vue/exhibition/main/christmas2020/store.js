var dataurl = "/christmas/2020/";
var data_itemlists = dataurl+"getitemlist.asp";

var store = new Vuex.Store({
    state : {
        params : {
            masterCode : '1',
            category : '-1',
            page : 1,
            pageSize : 24,
            listType : 'B',
            isPick : '',
            totalPage : 0,
            totalCount : 0,
            pageBlock : 10,
            sorted : 8,
        },
        eventLists : [],
        itemLists : [],
        mdPickItemLists : [],
        partitionItemLists : [],
        slideLists : [],
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
        SET_ISPICK : function(state , payload) {
            state.params.isPick = payload.isPick;
        },
        SET_PAGESIZE : function(state , payload) {
            state.params.pageSize = payload.pageSize;
        },
        SET_LIMITCOUNT : function(state, payload) {
            state.params.itemShowLimitCount = payload.itemShowLimitCount;
        },
        SET_PARTITIONLIMITCOUNT : function(state , payload) {
            state.partitionItemLists[payload.index].itemShowLimitCount = payload.itemShowLimitCount;
        },
        GET_ITEMLISTS : function(state , payload) {
            state.itemLists = payload.itemlist;
            state.params.totalPage = payload.listtotalpage;
            state.params.totalCount = payload.listtotalcount;
        },
        CLEAR_ITEMLISTS : function(state) {
            state.itemLists = [];
        },
        GET_MDPICKITEMLISTS : function(state , payload) {
            state.mdPickItemLists = payload.itemlist;
            state.params.totalPage = payload.listtotalpage;
            state.params.totalCount = payload.listtotalcount;
        },
        GET_SLIDELISTS : function(state , payload) {
            state.slideLists = payload;
        },
        CLEAR_MDPICKITEMLISTS : function(state) {
            state.mdPickItemLists = [];
        },
        GET_EVENTLISTS : function(state , payload) {
            state.eventLists = payload;
        },
        CLEAR_SLIDELISTS : function(state) {
            state.slideLists = [];
        },
        SET_PAGENUMBER : function(state , payload) {
            state.params.page = payload;
        },
        CLEAR_EVENTLISTS : function(state) {
            state.eventLists = [];
        },
        CLEAR_ISPICK : function(state) {
            state.params.isPick = '';
        },
        GET_PARTITIONITEMLISTS : function(state , payload) {
            state.partitionItemLists.push(payload);
        },
        SET_SORT(state , payload) {
            state.params.sorted = payload;
            state.params.page = 1; // 카테고리 변경시 페이징 넘버 1 초기화
        },
    },
    actions : {
        // API 는 여기서 호출
        GET_ITEMLISTS : function(context) {
            let _self = this.state.params;
            let _url = data_itemlists + "?mastercode="+ _self.masterCode +"&detailcode="+ _self.category +"&page="+ _self.page +"&pagesize="+ _self.pageSize +"&listtype="+ _self.listType +"&ispick="+ _self.isPick + "&sorted="+ _self.sorted;
            let isPick = _self.isPick;

            let getData = new Promise(function(resolve , reject) {
                $.getJSON(_url, function(response) {
                    if (response) {
                        resolve(response);
                    }
                    reject(new Error("Json Data Not Loaded"));
                });
            });

            getData.then(function(data) {
                isPick != '' ? function() {
                    context.commit('CLEAR_MDPICKITEMLISTS');
                    context.commit('GET_MDPICKITEMLISTS',data);
                }() : function() {
                    context.commit('CLEAR_ITEMLISTS');
                    context.commit('GET_ITEMLISTS',data);
                }()
            }, function(reason) {
                console.log(reason);
            });
        },
        GET_PARTITIONITEMLISTS : function(context) {
            let _self = this.state.params;
            let _url = data_itemlists + "?mastercode="+ _self.masterCode +"&detailcode="+ _self.category +"&page="+ _self.page +"&pagesize="+ _self.pageSize +"&listtype="+ _self.listType +"&ispick="+ _self.isPick;

            let _payload = {
                category : _self.category,
                itemShowLimitCount : _self.itemShowLimitCount,
                items : []
            };

            let getData = new Promise(function(resolve , reject) {
                $.getJSON(_url, function(response) {
                    if (response) {
                        resolve(response);
                    }
                    reject(new Error("Json Data Not Loaded"));
                });
            });

            getData.then(function(data) {
                _payload.items = data.itemlist;
                context.commit('GET_PARTITIONITEMLISTS',_payload);
            }, function(reason) {
                console.log(reason);
            });
        },
    },
})