Vue.component('comment-list-98339', {
    template: '\
    <div class="cmt-list" id="top">\
        <ul class="inner">\
            <li\
                v-for="comment in comments"\
                :class="[filterParam != \'\' ? \'shared-cmt\' : \'\' ]"\
            >\
                <div class="cmt-grp"><b class="name">{{comment.userName}}</b>님은 <span>{{comment.content}},</span><br/><span>{{comment.content2}}명</span>과 2020을<br/>함께하고 싶어요!</div>\
                <div class="cmt-reason">{{comment.content3}}</div>\
                <div class="share"> <button class="btn-share clip-board" \
                        @click="handleClickShare(comment.content)"\
                    >공유하기</button>\
                </div>\
                <like-icon\
                    :like-cnt.sync="comment.likeCnt"\
                    :my-like-cnt.sync="comment.myLikeCnt"\
                    :like-id="likeId"\
                    :is-login="isLogin"\
                    :contents-sub-id="comment.contentId"\
                    :after-like-callback="updateLikeCnt"\
                    :lyr-class-name="lyrClassName"\
                    :max-like-limit="maxLikeLimit"\
                    :key="comment.contentId"\
                >\
                    <template slot="likeIcon" slot-scope="sp">\
                        <div class="smile-wrap"\
                            :class="[sp.isLikeClick ? \'is-touched\' : \'\']"\
                        >\
                            <div class="count"\
                                :accessKey="comment.contentId"\
                                ref="cnt"\
                            >{{"+"+sp.myLikeCnt}}</div>\
                            <em class="click"\
                                v-if="sp.initialState"\
                            >클릭</em>\
                            <button class="btn-smile"\
                                type="button"\
                                @click="sp.handleClickLikeBtn"\
                            >\
                                <i>스마일</i>\
                                <span>{{ sp.likeCnt }}</span>\
                            </button>\
                        </div>\
                    </template>\
                </like-icon>\
                <button class="btn-delete"\
                    v-if="comment.isMyContent"\
                    @click="deleteContent(comment.contentId)"\
                >삭제하기</button>\
            </li>\
        </ul>\
        <button class="btn-more"\
            v-if="filterParam != \'\'"\
            onclick="window.location.reload()"\
        >\
            <img src="//webimage.10x10.co.kr/fixevent/event/2019/98339/btn_more.png" alt="더 많은 사연 구경하기">\
        </button>\
    </div>\
    ',
    data: function(){
        return {
           lyrClassName: "lyr-smile",
           maxLikeLimit: 30
        }
    },
    props: {
        comments: {
            type: Array,
            default: []
        },
        likeId: {
            type: Number,
            default: 0
        },
        isLogin: {
            type: Boolean,
            default: false
        },
        updateLikeCnt: {
            type: Function,
            default: function(){
                console.log('default update function')
            }
        },
        deleteContent: {
            type: Function,
            default: function(){
                console.log('default delete function')
            }
        },
        filterParam: {
            type: String,
            default: ''
        }
    },
    methods: {
        handleClickShare: function(key){
            var shareLink = 'http://www.10x10.co.kr/event/eventmain.asp?eventid=98339&filterparam=' + key
            var cbd = new ClipboardJS('.clip-board', {
                text: function(trigger) {
                    return shareLink
                }
            })
            cbd.on('success', function(e){
                alert('링크가 복사되었습니다. 원하시는 곳에 붙여넣기 하세요.')
            })
            cbd.on('error', function(e) {
                alert('클립보드 복사에 실패하였습니다.')
                console.error('Action:', e.action);
                console.error('Trigger:', e.trigger);
            });
        }
    }
})
