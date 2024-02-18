var app = new Vue({
    el: '#app',
    template: '\
    <div>\
        <comment-container\
            :list-query="listQuery"\
            :input-validation="inputValidation"\
            :chk-col-name="chkColName"\
            :chk-alert-msg="chkAlertMsg"\
        >\
            <template slot="commentForm" slot-scope="sp">\
                <div class="cmt-write">\
                    <div class="inner">\
                        <h3><img src="//webimage.10x10.co.kr/fixevent/event/2019/98339/tit_cmt_v2.png" alt="친구들과 함께 받는 다이어리 신청하기"></h3>\
                        <div class="input-section">\
                            <div class="input-box input-grp"><span><img src="//webimage.10x10.co.kr/fixevent/event/2019/98339/txt_grp_name_v2.png" alt="그룹명"></span>\
                                <input type="text" @click="sp.loginChk" ref="txtcomm" placeholder="텐텐클럽"  v-model.trim="sp.formData.txtcomm">\
                                <button class="btn-chck" @click="sp.chkDataDuplication(\'그룹명을 넣어주세요.\')"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98339/btn_chck_v2.png" alt="중복확인"></button>\
                            </div>\
                            <div class="input-box input-num"><span><img src="//webimage.10x10.co.kr/fixevent/event/2019/98339/txt_num_v2.png" alt="인원수"></span>\
                                <input type="number" @click="sp.loginChk" ref="txtcomm2" placeholder="0"  v-model.trim="sp.formData.txtcomm2">명\
                            </div>\
                            <div class="input-box input-reason"><span><img src="//webimage.10x10.co.kr/fixevent/event/2019/98339/txt_reason_v2.png" alt="이유"></span>\
                                <textarea name="reason" @click="sp.loginChk" ref="txtcomm3" cols="30" rows="4" placeholder="100자 이내로 입력해주세요."  v-model.trim="sp.formData.txtcomm3"></textarea>\
                                <em class="txt-num"><i>{{ sp.txt3Length }}</i>/100</em>\
                            </div>\
                            <button class="btn-submit" @click="handleClickSubmit(sp.submitComment, sp.downCoupon)"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98339/btn_submit_v2.png" alt="응모하기"></button>\
                        </div>\
                    </div>\
                </div>\
                <div class="search-section">\
                    <div class="inner">\
                        <p><img src="//webimage.10x10.co.kr/fixevent/event/2019/98339/txt_search_v2.png" alt="응모하기"></p>\
                        <div class="input-box"><input type="text" text="" placeholder="그룹명을 입력해주세요."  v-model.trim="listQuery.filterTxt">\
                        <button class="btn-search" @click="handleClickSearch(sp.getCommentList)"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98339/btn_search_v2.png" alt="검색"></button></div>\
                    </div>\
                </div>\
            </template>\
            <template slot="commentList" slot-scope="sp">\
                <comment-list-98339\
                    :comments="sp.comments"\
                    :like-id="listQuery.likeId"\
                    :is-login="sp.isLogin"\
                    :update-like-cnt="sp.updateLikeCnt"\
                    :delete-content="sp.deleteContent"\
                    :filter-param="sp.filterParam"\
                />\
            </template>\
            <template slot="paging" slot-scope="sp">\
                <div class="pageWrapV15"\
                    v-if="sp.pagingData.totalcount != 0"\
                >\
                    <div class="paging">\
                        <!--<a  class="first arrow"><span>맨 처음 페이지로 이동</span></a>\-->\
                        <a  class="prev arrow"\
                            v-if="sp.isPreArrowButton"\
                            @click="sp.handleClickPreArrow"\
                        ><span>이전페이지로 이동</span></a>\
                        <a \
                            v-for="i in sp.pageIdx"\
                            :class="[sp.dispPageNumber(i) == sp.pagingData.currpage ? \'current\' : \'\']"\
                        ><span\
                            @click="sp.handleClickPageNumber( sp.dispPageNumber(i) )"\
                        >{{ sp.dispPageNumber(i) }}</span></a>\
                        <a  class="next arrow"\
                            v-if="sp.isNextArrowButton"\
                            @click="sp.handleClickNextArrow"\
                        ><span>다음 페이지로 이동</span></a>\
                        <!--<a  class="end arrow"><span>맨 마지막 페이지로 이동</span></a>\-->\
                    </div>\
                </div>\
            </template>\
        </comment-container>\
        <div class="lyr-share" v-if="popState"\>\
            <div class="inner">\
                <p><img src="//webimage.10x10.co.kr/fixevent/event/2019/98339/img_share.png" alt=""></p>\
                <ul>\
                    <li><a href="javascript:snschk(\'fb\');">페이스북 공유</a></li>\
                    <li><a href="javascript:snschk(\'tw\');">트위터 공유</a></li>\
                </ul>\
                <button class="btn-close" @click="setPopState(false)">레이어닫기</button>\
                <a href="/my10x10/couponbook.asp" class="btn-cp" v-if="isGetCoupon"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98339/btn_cp.png" alt="3,000원 할인쿠폰 지급 완료"></a>\
            </div>\
        </div>\
        <div class="lyr-smile" style="display:none;">\
            <span class="smile">\
                <img src="//webimage.10x10.co.kr/fixevent/event/2019/98339/img_smile.png" alt="스마일">\
                <i><img src="//webimage.10x10.co.kr/fixevent/event/2019/98339/img_wink.png" alt="스마일 윙크"></i>\
                <span class="dc dc1"></span>\
                <span class="dc dc2"></span>\
                <span class="dc dc3"></span>\
            </span>\
        </div>\
    </div>\
    ',
    data: function(){
        return {
            // 리스트 api 파라미터
            listQuery: {
                currentPage: 1,
                eventCode: eventCode,
                pageSize: 6,
                scrollCount: 10,
                likeId: 1,
                filterTxt: ''
            },
            // 폼 유효성 체크
            inputValidation: [
                { dataKey: 'txtcomm', nullCheck: { message: '그룹명을 작성해 주세요!' }, lengthCheck: { maxlength: 8, message: '그룹명은 8자까지 입력해주세요.' } },
                { dataKey: 'txtcomm2', nullCheck: { message: '빈칸을 모두 작성해주세요!' }, lengthCheck: { maxlength: 3, message: '3자리 숫자까지 입력해주세요.' } },
                { dataKey: 'txtcomm3', nullCheck: { message: '빈칸을 모두 작성해주세요!' }, lengthCheck: { maxlength: 100, message: '100자 이내로 입력해주세요', lengthWatch: true } }
            ],
            // 중복체크 관련 데이터
            chkColName: "txtcomm",
            chkAlertMsg: "이미 등록된 그룹명입니다. 다른 그룹명을 입력해주세요.",
            popState: false,
            isGetCoupon: false
        }
    },
    methods: {
        handleClickSubmit: function(submit, cb){
            submit('addpday', 10, function(res){
                if(res == "ok"){
                    cb('evtsel', couponIdx, function(res){
                        if(res == "11"){
                            this.isGetCoupon = true
                        }else{
                            this.isGetCoupon = false
                        }
                        fnAmplitudeEventMultiPropertiesAction('click_event_apply', 'evtcode', eventCode)
                        this.setPopState()
                    }.bind(this))
                }
            }.bind(this))
        },
        setPopState: function(){
            this.popState = !this.popState
        },
        handleClickSearch: function(getComm){
            this.listQuery.currentPage = 1
            getComm();
        }
    }
})
