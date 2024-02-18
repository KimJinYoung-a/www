Vue.component('MODAL-FORUM-DETAIL',{
    template: `
        <!-- 팝업 - 자세히보기 -->
        <div class="modalV20 modal_anniv20">
            <div @click="close" class="modal_overlay"></div>
            <div class="anniv_modal_wrap detail">
                <button type="button" class="btn_close" @click="close"><i class="i_close"></i></button>
                <div class="anniv_modal_conts">
                    <!-- 자세히보기 2개이상일 경우 노출 선택시 class on 추가 -->
                    <div class="forum_ex_multi">
                        <div class="list_wrap">
                            <div class="list" v-for="(description, index) in descriptions">
                                <button :id="index" type="button" @click="setDescriptionContent(description, index)">
                                    <p v-html="description.title"></p>
                                </button>
                            </div>
                        </div>
                    </div>
                    <!-- 컨텐츠 영역 -->
                    <FORUM-DESCRIPTION :content="content" />
                </div>
            </div>
        </div>
    `
    ,
    props: {
        forumIndex : { type:Number, default:0 }, // 포럼 일련번호
        //region forum 포럼
        'descriptions' : {
            infoIdx : { type:Number, default:0 },
            title : { type:String, default:'' },
            content : { type:String, default:'' }
        }
    },
    data() {
        return {
            content: ''
        }
    },
    mounted() {
        const _self = this;
        setTimeout(function() {
            _self.setDescriptionContent(_self.descriptions[0], 0);
        },
         500);        
    },
    methods : {
        // 모달 닫기
        close() {
            this.$emit('forumDetailClose');
        },
        // forum 상세 정보
        setDescriptionContent(description, index) {
            fnAmplitudeEventMultiPropertiesAction('click_forum_info', 'forum_index|info_index', `${this.forumIndex}|${description.infoIdx}`);
            this.content = description.content;
            
            $('.list').removeClass("on");
            $('#' + index +'').closest("div").addClass("on");
        }
    },
    computed: {
        // forum 상세 정보
        getDescriptionContent() {
            return this.content
        }
    }
})