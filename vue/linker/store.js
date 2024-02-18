const store = new Vuex.Store({
    state : {
        forum_idx: 1
        , max_posting_idx: 0
        , posting_idx: 0
        , is_mine: false
        , posting_list: []
        ,
        myProfile : {
            'auth' : 'N',
            'avataNo' : '0',
            'description' : null,
            'image' : null,
            'nickName' : '',
            'levelName' : 'test',
            'nickNameRecommendation' : null,
            'registration' : false
        },
        //region forum 포럼
        'forum' : {
            'title' : '', // 제목
            'subTitle' : '', // 부 제목
            'description' : '', // 포럼 설명
            'backgroundMediaType' : '', // 배경 유형
            'backgroundMediaValue' : '', // 배경 값
            'descriptions' : [
                {
                    infoIdx : '',
                    title : '',
                    content: ''
                }
            ], // 설명 리스트
            'startDate' : '', // 노출 시작 일
            'endDate' : '' // 노출 종료 일
        },
        //endregion
        descriptions : [
            {
                pcTitle : '',
                pcContent : ''
            }
        ],
        forumCount: 0, // 포럼 수
        forumList: [], // 포럼 목록
        myClapCounts: {} // 박수 정보
    }
    , mutations : {
        SET_FORUM_IDX(state, data){
            state.forum_idx = data;
        }
        , SET_MAX_POSTING_IDX(state, data) {
            let result = 1;
            if (data !== Number.NEGATIVE_INFINITY) {
                result = data;
            }
            state.max_posting_idx = result;
        }
        , SET_MINE(state, data) {
            state.is_mine = data;
        }
        , SET_POSTING_LIST(state, data) {
            state.posting_list = data;
        }
        , SET_MY_PROFILE(state, payload) {
            state.myProfile = payload;
        }, 
        //region SET_FORUM Set 포럼
        SET_FORUM(state, payload) {
            state.forum.title = payload.title;
            state.forum.subTitle = payload.subTitle;
            state.forum.description = payload.description;
            state.forum.backgroundMediaType = payload.backgroundMediaType;
            state.forum.backgroundMediaValue = decodeBase64(payload.backgroundMediaValue);
            state.forum.descriptions = payload.descriptions;
        },
        //endregion
        //region SET_FORUMS Set 포럼
        SET_FORUMS(state, payload) {
            state.forumList = payload.forums;
            state.forumCount = payload.forumCount;
        },
        //endregion
        SET_DESCRIPTIONS(state, payload) {
            state.descriptions = payload;
        },
        //region SET_MY_CLAP_COUNTS Set 내 박수 갯수 리스트 조회
        SET_MY_CLAP_COUNTS(state, counts) {
            state.myClapCounts = counts;
        },
        //endregion
        PUT_MY_CLAP_COUNTS(state, idx) {
            state.myClapCounts[idx] = 1;
        },
        ADD_MY_CLAP_COUNTS(state, payload) {
            state.myClapCounts[payload.postingIndex] = payload.prevClapCount + 1;
        },
    }
    , getters : {
        forum_idx(state){
            return state.forum_idx;
        }
        , max_posting_idx(state){
            return state.max_posting_idx;
        }
        , posting_idx(state){
            return state.posting_idx;
        }
        , is_mine(state){
            return state.is_mine;
        },
        myProfile(state) { 
            return state.myProfile; 
        }
        , forum(state) { 
            return state.forum; 
        }
        , forumList(state) {
            return state.forumList;
        }
        , forumCount(state){
            return state.forumCount;
        }
        , descriptions(state) {
            return state.descriptions;
        }
        , descriptions(state) {
            return state.descriptions;
        },
        myClapCounts(state) { 
            return state.myClapCounts; 
        },
    },
    actions : {
        //region GET_MY_PROFILE Get 포럼 정보
        GET_MY_PROFILE(context) {
            const success = function(data) {
                context.commit('SET_MY_PROFILE', data);
            }

            call_api('GET', '/user/profile', null, success, function() {});
        },
        //endregion
        //region GET_FORUM_INFO Get 포럼 정보
        GET_FORUM_INFO(context, forumIndex) {
            const success = function(data) {
                context.commit('SET_FORUM', data);
            }
            call_apiV2('GET', '/linker/forum/' + forumIndex + '/pc', null, success);
        },
        //endregion
        //region GET_FORUMS Get 포럼 정보
        GET_FORUMS(context) {
            const success = function(data) {
                context.commit('SET_FORUMS', data);
            }
            call_apiV2('GET', '/linker/forums', null, success);
        },
        //endregion
        //region GET_DESCRIPTIONS Get 포럼 정보
        GET_DESCRIPTIONS(context) {
            const success = function(data) {
                context.commit('SET_DESCRIPTIONS', data);
            }
            const url = `/linker/forum/descriptions/${forumIndex}/device/PC`;
            call_apiV2('GET', url, null, success);
        },
        //endregion
        //region GET_MY_CLAP_COUNTS Get 내 박수 갯수 리스트 조회
        GET_MY_CLAP_COUNTS(context) {
            call_apiV2('GET', '/linker/clap/my/count', null,
                    data => context.commit('SET_MY_CLAP_COUNTS', data));
        },
        //endregion
    }
});

const decodeBase64 = function(str) {
    if( str == null ) return null;
    return atob(str.replace(/_/g, '/').replace(/-/g, '+'));
}