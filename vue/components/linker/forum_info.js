Vue.component('FORUM-INFO', {
    template : `
        <div class="forum_top" :style="forumTopStyle">
            <div class="bnr_top w1140">
                <!-- 10-05 추가 -->
                <a href="/event/21th/index.asp?tabType=benefit" class="link-year" v-if="showBadge">
                    <img src="//webimage.10x10.co.kr/fixevent/event/2022/plusSale/m/badge_year2023_green.png?v=1.3" alt="주년 엠블럼">
                </a>
                <!-- // -->
                <div class="menu-area">
                    <button type="button" class="btn_add_word" @click="writePosting"><span class="icon"></span>글 작성하기</button>
                    <!-- 리스트 목록 버튼 숨김 처리 2022-10-07
                    <button type="button" class="btn_list_menu" @click="openForumList">
                        <img src="http://fiximage.10x10.co.kr/web2021/anniv2021/icon_menu.png?v=2" alt="menu">
                        <div class="num">{{numberFormat(forumCnt)}}</div>
                    </button>
                    <div class="talk_bubble">다른 텐텐토크 보러가기</div>
                    -->
                </div>
                <div class="bnr_tit">
                    <p>{{forum.subTitle}}</p>
                    <p class="tit" v-html="forum.title"></p>
                    <p class="h_sub" v-html="forum.description"></p>
                    <button v-if="descriptionCnt > 0" @click="openForumDetail" type="button" class="btn_detail">자세히보기</button>
                </div>
            </div>
            <FORUM-LIST v-if="showForumList" :forumList="forumList" @closeModal="hideForumList" />
        </div>
    `,
    mounted() {
        const _self = this;
        setTimeout(function() {
            _self.talkBubbleHide();
        },
         5000);
    },
    data() {
        return {
            showDescription : false, // 설명 노출 여부
            showForumList : false   // 포럼 목록 노출 여부
        }
    },
    props : {
        //region forum 포럼
        'forum' : {
            'title' : { type:String, default:'' }, // 제목
            'subTitle' : { type:String, default:'' }, // 부 제목
            'description' : { type:String, default:'' }, // 부 제목
            'backgroundMediaType' : { type:String, default:'image' }, // 배경 유형
            'backgroundMediaValue' : { type:String, default:'' }, // 배경 값
            'descriptions' : { // 설명 리스트
                'title' : { type:String, default:'' }, // 제목
                'content' : { type:String, default:'' } // 내용
            },
        },
        //endregion
        // 포럼 내용 개수
        descriptionCnt: {
            type:Number,
            default:0
        },
        // 포럼 개수
        forumCnt : {
            type:Number, 
            default: 0
        },
        // 포럼 목록
        forumList : {
            type:Array,
            default:[]
        },
        // 포럼 내용 개수
        descriptionCnt: {
            type:Number,
            default: 0
        },
        // 포럼 일련번호
        forumIndex: {
            type:Number,
            default: 0
        }
    },
    computed : {
        //region forumTopStyle 포럼 정보 스타일
        forumTopStyle() {
            // TODO : 동영상 배경
            if( this.forum.backgroundMediaType === 'image' ) {
                return {'background' : 'no-repeat 50% 99% / cover url(' + this.forum.backgroundMediaValue + ')'}
            } else if( this.forum.backgroundMediaType === 'color' ) {
                return {'background' : this.forum.backgroundMediaValue}
            } else {
                return {};
            }
        },
        //endregion
        showBadge() {
            const _this = this;
            let now = new Date().getTime();
            let startDate = new Date(2022, 9, 10, 10, 0, 0).getTime();
            if (_this.forumIndex === 7 && now > startDate) {
                return true;
            }
            return false;
        }
    },
    methods : {
        //region openForumDetail 포럼 설명 모달 열기
        openForumDetail() {
            fnAmplitudeEventMultiPropertiesAction('click_forum_detail', 'forum_index', this.forumIndex.toString());
            this.$emit('openForumDetail', true);
        },
        //endregion
        // 글 작성하기
        writePosting() {
            fnAmplitudeEventMultiPropertiesAction('click_add_posting', 'forum_index', this.forumIndex.toString());
            this.$emit('writePosting');
        },
        // <br> 태그 제거
        removeTag(content) {
            return content.replaceAll("<br>", " ");
        },
        openForumList() {
            fnAmplitudeEventMultiPropertiesAction('click_forum_list', 'forum_index', this.forumIndex.toString());
            this.showForumList = true;
        },
        hideForumList() {
            this.showForumList = false;
        },
        talkBubbleHide() {
            $(".talk_bubble").hide();
        },
    }

});