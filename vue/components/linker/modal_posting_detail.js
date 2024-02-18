Vue.component('MODAL-POSTING-DETAIL', {
    template : `
        <div class="modalV20 modal_anniv20">
            <div @click="close" class="modal_overlay"></div>
            <div>
                <div class="anniv_modal_wrap login">
                    <div class="anni_container">
                        <button type="button" class="btn_close" @click="close"><i class="i_close"></i></button>
                        <div class="left_conts">
                            
                            <!-- region 프로필, 박수 -->
                            <div class="anniv_modal_header">
                                <div class="login_profile">
                                    <div class="login_info_area">
                                        <div class="img"><img :src="posting.creatorThumbnail"></div>
                                        <div class="info">
                                            <p v-if="posting.creatorDescription" class="txt">{{posting.creatorDescription}}</p>
                                            <p class="id">{{posting.creatorNickname}}</p>
                                        </div>
                                        <button @click="postClap" type="button" :class="['btn_clap', {empty:posting.clapCount === 0}]">
                                            <span class="icon"></span><span class="num">{{posting.clapCount===0 ? '멋져요! 짝짝짝' : numberFormat(posting.clapCount)}}</span>
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <!-- endregion -->
                            
                            <!-- region 내용, 링크 -->
                            <div class="anniv_modal_conts login">
                                <div class="my_words" v-html="setCreatorDescription(posting.content)"></div>
                                <div v-if="posting.linkValue" class="copy_view my_view">
                                    <div class="link_info">
                                        <div @click="goLink" :class="linkThumbnailClass">
                                            <img :src="posting.linkThumbnail">
                                        </div>
                                        <div @click="goLink" v-if="posting.linkType === 2" class="link">
                                            <p class="pro_tit">기획전</p>
                                            <p class="pro_sub">{{posting.linkTitle}}</p>
                                        </div>
                                        <div @click="goLink" v-else-if="posting.linkType === 1 || posting.linkType === 7" class="link">
                                            <p v-if="posting.linkType === 1" class="tit">{{posting.linkDescription}}</p>
                                            <p class="sub">{{posting.linkTitle}}</p>
                                        </div>
                                        <div @click="goLink" v-else-if="posting.linkType === 99" class="link">
                                            <p class="url">{{posting.linkTitle}}</p>
                                        </div>
                                        <div v-if="posting.linkType === 1 || posting.linkType === 7" id="wish" class="select_prd">
                                            <button id="wish" type="button" class="btn_wish" @click="wish">
                                                <figure class="ico_wish"></figure>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- endregion -->
                            
                        </div>
                        
                        <!-- region 댓글 영역 -->
                        <div class="right_conts comment">
                            <div class="forum_conts">
                                <div class="my_comment_area">
                                    <div v-if="comments.length > 0" class="forum_my_comment">
                                        <MODAL-POSTING-COMMENT v-for="comment in comments" :key="comment.commentIndex" :comment="comment"
                                            :isLogin="isLogin" @postReComment="postReComment" @deleteComment="getPostingComments"/>
                                    </div>
                                    <div v-else class="no_comment">
                                        <span class="icon"></span>
                                        <p class="sub">설레는 첫 답글을 남겨보세요 :)</p>
                                    </div>
                                </div>
                                <div class="bottom_comment">
                                    <textarea v-model="commentContent" @blur="blurComment" @focus="checkCommentUserAuth" 
                                        id="comment" class="autosize" :placeholder="commentPlaceHolder"></textarea>
                                    <button @click="postComment" type="button" class="btn_enter_comment">답글달기</button>
                                </div>
                            </div>
                        </div>
                        <!-- endregion -->
                        
                        <div v-if="posting.creator" class="btn_container">
                            <button @click="modifyPosting" type="button" class="btn_enter edit"><span class="icon"></span>수정하기</button>
                            <button @click="deletePosting()" type="button" class="btn_enter delete"><span class="icon"></span>삭제하기</button>
                        </div>
                        <div v-else class="btn_container">
                            <button @click="clickReportPosting" type="button" class="btn_enter cancel">
                                <span class="icon"></span> {{ posting.reported ? '신고 취소하기' : '신고하기' }}
                                <div v-if="showPostingReportBubble" class="sp_bubble">신고 5회 누적 시 블라인드 처리됩니다.</div>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    `,
    data() {return {
        postingIndex : 0,
        //region posting 포스팅
        posting : {
            clapCount: 0, // 박수 수
            content: '', // 내용
            creatorDescription: '', // 작성자 설명
            creatorNickname: '', // 작성자 별명
            creatorThumbnail: '', // 작성자 썸네일
            linkDescription: '', // 링크 설명
            linkThumbnail: '', // 링크 썸네일
            linkTitle: '', // 링크 타이틀
            linkType: 0, // 링크 구분
            linkValue: '', // 링크 값
            linkWish: false, // 링크 위시 여부
            creator: false, // 작성자 여부
            reported : false // 포스팅 본인 신고 여부
        },
        //endregion
        comments: [], // 댓글 리스트
        upperCommentIndex : null, // 상위 댓글 일련번호
        commentContent : '', // 댓글 내용
        aniWish : null, // 위시 로티
        showPostingReportBubble : false, // 포스팅 신고 말풍선 노출 여부
        defaultPosting : {}, // 기본 포스팅 정보(초기화용)
        dataError : false, // 서버 통신 여부
    }},
    props : {
        isLogin : { type:Boolean, default:false }, // 로그인 유저인지 여부
        isProfileRegister : { type:Boolean, default:false }, // 프로필 등록 여부
        forumIndex : { type:Number, default:0 },
        onlyMyPosting: {type:Boolean, default:false}
    },
    mounted() {
        this.defaultPosting = this.posting;
    },
    computed : {
        //region linkThumbnailClass 링크 썸네일 클래스
        linkThumbnailClass() {
            if( this.posting.linkValue !== '' ) {
                if( this.posting.linkType === 2 )
                    return 'pro_img';
                else if( this.posting.linkType === 99 )
                    return 'url_img';
                else
                    return 'img';
            } else {
                return '';
            }
        },
        //endregion
        //region commentPlaceHolder 댓글 입력영역 placeholder
        commentPlaceHolder() {
            if( !this.isLogin )
                return '로그인이 필요한 서비스입니다';
            else if( !this.isProfileRegister )
                return '프로필 등록이 필요한 서비스입니다';
            else
                return '답글을 입력해주세요';
        },
        //endregion
    },
    methods : {
        //region open 모달 열기
        open(postingIndex) {
            this.postingIndex = postingIndex;
            this.getPostingDetail();
            this.getPostingComments();
        },
        //endregion
        //region close 모달 닫기
        close() {
            this.clearPostingAndComments();
            this.dataError = false;
            this.$emit('close');
        },
        //endregion
        // region 데이터 조회 실패시 alert 
        errorAlert() {
            if (!this.dataError) {
                alert("서버와 통신이 원활하지 않습니다. 잠시후 다시 시도해주세요.");
                this.dataError = true;
            }
        },
        // endregion
        //region getPostingDetail 포스팅 상세 Get
        getPostingDetail() {
            this.getFrontApiDataV2('GET', `/linker/posting/${this.postingIndex}`
                , null, this.setPosting, this.errorAlert);
        },
        //endregion
        //region setPosting 포스팅 Set
        setPosting(data) {
            this.posting = data;
        },
        //endregion
        //region getPostingComments 포스팅 댓글 리스트 Get
        getPostingComments() {
            this.getFrontApiDataV2('GET', `/linker/posting/${this.postingIndex}/comments`
                , null, this.setPostingComments, this.errorAlert);
        },
        //endregion
        //region setPostingComments 포스팅 댓글 리스트 Set
        setPostingComments(data) {
            this.comments = data;
            this.calculateCommentAreaMargin();
        },
        //endregion
        //region goLink 링크 이동
        goLink() {
            switch(this.posting.linkType) {
                case 1: this.goLinkProduct(); break;
                case 2: this.goLinkEvent(); break;
                case 7: this.goLinkBrand(); break;
                case 99: this.goLinkUrl(); break;
            }
        },
        //endregion
        //region goLinkProduct 링크 상품 이동
        goLinkProduct() {
            const itemId = this.posting.linkValue;
            location.href = '/shopping/category_prd.asp?itemid=' + itemId;
        },
        //endregion
        //region goLinkEvent 링크 이벤트 이동
        goLinkEvent() {
            const eventCode = this.posting.linkValue;
            location.href = '/event/eventmain.asp?eventid=' + eventCode;
        },
        //endregion
        //region goLinkBrand 링크 브랜드 이동
        goLinkBrand() {
            const brandId = this.posting.linkValue;
            location.href = '/street/street_brand_sub06.asp?makerid=' + brandId;
        },
        //endregion
        //region goLinkUrl 링크 외부링크 이동
        goLinkUrl() {
            window.open(this.posting.linkValue, '_blank');
        },
        //endregion
        //region goLoginPage 로그인 페이지 이동
        goLoginPage() {
            if( confirm('로그인이 필요한 서비스입니다.\n로그인 하시겠어요?') )
                this.$emit('goLoginPage');
        },
        //endregion
        //region calculateCommentAreaMargin 댓글 영역 하단 마진 계산
        calculateCommentAreaMargin() {
            /* comment 영역 height 계산 */
            setTimeout(function() {
                var h_botom_co = $('.bottom_comment').height()+30;
                $('.my_comment_area').css( { margin: `0 0 ${h_botom_co}px 0` } );
            }, 500);

            /* textarea 자동 높이 조절 */
            $("textarea.autosize").on('keydown keyup', function (e) {
                if( e.target.value === '' ) {
                    $(this).height(1).height( $(this).prop('scrollHeight')-25 );	
                } else {
                    const scrollHeight = $(this).prop('scrollHeight');
                    $(this).height(1).height( scrollHeight > 55 ? 45 : 25);	
                }
            });
        },
        //endregion
        //region wish 위시
        wish() {
            let url = '/wish';
            let data = {
                method : !this.posting.linkWish ? 'POST' : 'DELETE'
            };
            switch (this.posting.linkType) {
                case 1 : // 상품
                    url += '/item';
                    data.item_id = this.posting.linkValue;
                    break;
                case 7 : // 브랜드
                    url += '/brand';
                    data.brand_id = this.posting.linkValue;
                    break;
            }
            getFrontApiData('POST', url, data, this.successWish);
        },
        successWish() {
            this.posting.linkWish = !this.posting.linkWish;

            if( this.posting.linkWish ) {
                fnAmplitudeEventMultiPropertiesAction('click_wish_in_product', 'action', 'on');
                this.aniWish.playSegments([0,18], true);
            } else {
                this.aniWish.playSegments([18,30], true);
            }
        },
        createWishAnimation() {
            this.aniWish = bodymovin.loadAnimation({
                container: document.querySelector('#wish figure'),
                loop: false,
                autoplay: false,
                path: 'https://assets2.lottiefiles.com/private_files/lf30_jgta4mcw.json'
            });
            if( this.posting.linkWish ) {
                this.aniWish.goToAndStop(18, true);
            } else {
                this.aniWish.goToAndStop(0, true);
            }
        },
        //endregion
        //region clearPostingAndComments 포스팅, 댓글리스트 초기화
        clearPostingAndComments() {
            this.posting = this.defaultPosting;
            this.comments = [];
            this.commentContent = '';
            $("textarea.autosize").height(1).height(25);
        },
        //endregion
        //region checkCommentUserAuth 댓글 작성 유저 권한 체크
        checkCommentUserAuth(e) {
            if( !this.isLogin ) {
                e.target.blur();
                this.goLoginPage();
            } else if( !this.isProfileRegister ) {
                e.target.blur();
                this.$emit('openProfileWrite');
            }
        },
        //endregion
        //region postComment 댓글 등록
        postComment() {
            if( !this.isLogin ) {
                this.goLoginPage();
                return false;
            } else if( !this.isProfileRegister ) {
                this.$emit('openProfileWrite');
                return false;
            }

            const data = {
                postingIndex : this.postingIndex,
                content : this.commentContent
            }
            if( this.upperCommentIndex != null )
                data.upperCommentIndex = this.upperCommentIndex;

            fnAmplitudeEventMultiPropertiesAction('click_upload_comment', '', '');

            this.getFrontApiDataV2('POST', '/linker/posting/comment', data, this.successRegisterComment)
        },
        //endregion
        //region successRegisterComment 댓글 등록 성공
        successRegisterComment() {
            this.getPostingComments();
            this.commentContent = '';
            this.upperCommentIndex = null;
            $("textarea.autosize").height(1).height( $(this).prop('scrollHeight'));
        },
        //endregion
        //region postReComment 대댓글 등록
        postReComment(comment) {
            this.upperCommentIndex = comment.commentIndex;
            const textarea = document.getElementById('comment');
            textarea.placeholder = this.createReCommentPlaceHolder(comment.creatorNickname);
            textarea.focus();
        },
        createReCommentPlaceHolder(nickName) {
            let name = nickName.length > 5 ? (nickName.substr(0, 5)+'...') : nickName;
            return `${name}님에게 답글을 입력해주세요`;
        },
        blurComment(e) {
            if( !this.isLogin )
                e.target.placeholder =  '로그인이 필요한 서비스입니다';
            else if( !this.isProfileRegister )
                e.target.placeholder =  '프로필 등록이 필요한 서비스입니다';
            else
                e.target.placeholder = '답글을 입력해주세요';
        },
        //endregion
        //region postClap 박수 등록
        postClap() {
            if( !this.isLogin && confirm('로그인이 필요한 서비스입니다.\n로그인 하시겠어요?') ) {
                this.goLoginPage();
                return;
            } else if (this.isLogin) {
                const _this = this;
                
                const success = function(data) {
                    if( data.result ) {
                        _this.posting.clapCount++;
                    }
                    else {
                        alert('고마워요! 하지만 박수는 다섯번까지만 칠 수 있어요 :)');
                    }
                }
                const fail = function(e) {
                    console.log(e);
                }

                fnAmplitudeEventMultiPropertiesAction('click_posting_clap', 'forum_index|posting_index|place', 
                    `${this.forumIndex}|${this.postingIndex}|posting_popup`);
                
                this.getFrontApiDataV2('POST', `/linker/posting/${this.postingIndex}/clap`, null, success, fail);
            }
        },
        //endregion
        //region modifyPosting 포스팅 수정
        modifyPosting() {
            if( this.posting.creator ) {
                this.$emit('modifyPosting', this.postingIndex);
                this.close();
            }
        },
        //endregion
        //region deletePosting 포스팅 삭제
        deletePosting() {
            if ( confirm('포스트를 제거하시겠어요?') ) {
                const _self = this;
                const success = function (data) {
                    location.replace(`?idx=${_self.forumIndex}&me=${_self.onlyMyPosting ? 1 : 0}`);
                }
                call_apiV2('POST', `/linker/posting/delete/${this.postingIndex}`, null, success);
            }
        },
        //endregion
        //region clickReportPosting 포스팅 신고하기 클릭
        clickReportPosting() {
            const _self = this;
            if( !this.isLogin ) {
                this.goLoginPage();
            } else if( _self.posting.reported ) {
                _self.cancelReportPosting();
            } else {
                _self.reportPosting();
            }
        },
        //endregion
        //region reportPosting 포스팅 신고
        reportPosting() {
            if( !this.posting.creator && confirm('포스트를 신고하시겠어요?') ) {
                const _this = this;
                const success = function(result) {
                    if( !result ) {
                        alert('이미 신고하셨습니다.');
                    } else {
                        _this.showPostingReportBubble = true;
                        setTimeout(() => _this.showPostingReportBubble = false, 5000);
                    }
                    _this.posting.reported = true;
                }
                this.getFrontApiDataV2('POST', `/linker/posting/${this.postingIndex}/report`, null, success);
            }
        },
        //endregion
        //region cancelReportPosting 포스팅 신고 취소하기
        cancelReportPosting() {
            if( !this.posting.creator && confirm('신고를 취소하시겠어요?') ) {
                const _this = this;
                const success = function() { _this.posting.reported = false; }
                this.getFrontApiDataV2('POST', `/linker/posting/${this.postingIndex}/report/delete`, null, success);
            }
        },
        //endregion
        checkCommentAuth() {
            const _self = this;
            if( !_self.isLogin ) {
                return false;
            } else if( _self.posting.reported ) {
                return false;
            } else {
                return true;
            }
        },
        setCreatorDescription(creatorDescription) {
            return creatorDescription.replaceAll("\n" , "<br>")
        }
    }
});