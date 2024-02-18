const app = new Vue({
    el: '#app'
    , store : store
    , mixins : [linker_mixin, modal_mixin]
    , template : `
        <div class="container">
            <div id="contentWrap">
                <FORUM-INFO 
                    :forum="forum"
                    :forumCnt="forumCount"
                    :forumList="forumList"
                    :descriptionCnt="descriptions.length" 
                    :forumIndex="forumIndex"
                    @openForumDetail="openForumDetail"
                    @writePosting="writePosting"
                />
                <div class="grid_containr">
                    <div v-if="this.myProfile.registration" class="check_mypost">
                        <input type="checkbox" id="mypost" :checked="onlyMyPosting" @click="viewMyPostings">
                        <label for="mypost">내 글만 보기</label>
                    </div>
                    <!-- 작성된 글이 없을 경우 노출 -->
                    <div class="empty_post" v-if="!postingData">
                        <span class="img_empty"></span>   
                        <p class="tit">아직 작성된 글이 없네요.</p>
                        <p class="txt">가벼운 마음으로 첫번째 글을<br/>
                            올려보는건 어떨까요?</p>
                    </div>
                    <div class="grid" id="container"></div>
                    <!-- 2021-11-05 배경 버블 추가 -->
                    <div class="bg-bubble-wrap" v-if="postingData">
                        <template v-for="i in bubbleCount">
                            <div class="bubble-list">
                                <div class="bg-big-bubble"></div>
                                <div class="bg-big-bubble type02"></div>
                            </div>
                            <div class="bubble-list type02">
                                <div class="bg-big-bubble"></div>
                                <div class="bg-big-bubble type02"></div>
                            </div>
                        </template>
                    </div>
                    <!-- 글 작성하기 버튼 -->
                    <button @click="writePosting" type="button" class="btn_plus"><span class="icon"></span>글 작성하기</button>
                </div>
            </div>
            
            <!-- 포럼 상세 모달 -->
            <MODAL-FORUM-DETAIL 
                :descriptions="descriptions" 
                :forumIndex="forumIndex" 
                :onlyMyPosting="onlyMyPosting"
                v-show="showForumDetail"
                @forumDetailClose="closeShowForumDetail"/>

            <!-- 포스팅 작성 모달 -->
            <MODAL-POSTING-WRITE 
                ref="postingWriteModal" 
                v-show="showPostingWriteModal" 
                :onlyMyPosting="onlyMyPosting"
                :forumIndex="forumIndex" 
                :profile="myProfile" 
                @close="closeShowPostingWriteModal"/>
                
            <!-- 포스팅 상세 조회 모달 -->
            <MODAL-POSTING-DETAIL 
                ref="modalPosting" 
                v-show="showPostingDetailModal" 
                :isLogin="isLogin" 
                :isProfileRegister="myProfile.registration"
                :onlyMyPosting="onlyMyPosting"
                :forumIndex="forumIndex" 
                @modifyPosting="modifyPosting"
                @goLoginPage="goLoginPage"
                @openProfileWrite="openProfileWrite" 
                @close="closeShowPostingDetailModal"/>

            <!-- 프로필 작성 모달 -->
            <MODAL-PROFILE-WRITE 
                v-if="showProfileModal" 
                :linker="true" 
                :myProfile="myProfile"  
                :userId="userId"
                @closeModal="closeShowProfileModal" 
                @completePostProfile="completePostProfile"/>
        </div>
    `
    , created() {
        this.forumIndex = forumIndex;
        this.isLogin = isUserLoginOK;
        this.onlyMyPosting = onlyMyPosting;
        this.$store.dispatch('GET_MY_CLAP_COUNTS');
        this.$store.dispatch('GET_FORUM_INFO', forumIndex);
        this.$store.dispatch('GET_DESCRIPTIONS');
        this.$store.dispatch('GET_FORUMS');
        this.$store.dispatch('GET_MY_PROFILE');

        fnAmplitudeEventMultiPropertiesAction('view_forum', 'forum_index|place', `${this.forumIndex}|${place}`);
    }
    , data() {
        return {
            ig : null,  // infiniteGrid
            forumIndex : 0, // 포럼 index
            showPostingWriteModal : false, // 작성 모달 노출 여부
            showPostingDetailModal : false, // 상세 조회 모달 노출 여부
            showProfileModal : false, // 프로필 작성 모달 노출 여부
            isLogin : false, // 로그인 여부
            userId : getUserId, // 유저 ID
            postingList: [], // 포스팅 조회 데이터
            onlyMyPosting: false, // 내 글만보기 여부
            loadingPosting : false, // 포스팅 로딩 여부
            showForumDetail: false, // 포럼 상세
            myPosting: false, // 내글 보기
            clapingElement : null, // 박수치고 있는 중인 엘리먼트
            postingAreaHeight: 0
        }
    }
    ,mounted() {
        /* 프로필 선택시 class on 추가 */
        $('.pro_img').on('click',function(){
            $(this).toggleClass('on').parent().siblings().children().removeClass('on'); 
        });
        var didScroll; 
        // 스크롤시에 사용자가 스크롤했다는 것을 알림 
        $(window).scroll(function(event){ 
            didScroll = true;
        }); // hasScrolled()를 실행하고 didScroll 상태를 재설정 
        setInterval(function() { 
            if (didScroll) 
            { hasScrolled(); didScroll = false; }
        }, 250);
        function hasScrolled() { // 동작을 구현 
            //var bnrEnd = $('.grid_containr').offset().top; // 동작의 구현이 시작하고 끝나는 위치
            // 접근하기 쉽게 현재 스크롤의 위치를 저장한다. 
            //var st = $(window).scrollTop();
            //if (st >= bnrEnd){
                //$('.btn_plus').removeClass('hide');
            //} else {
               // $('.btn_plus').addClass('hide');
            //}
        }

        const _self = this;
        // InfiniteGrid 호출
        _self.createInfiniteGrid();
        if (this.onlyMyPosting) {
            _self.getPostingLoad();
        } else {
            _self.getFirstPosting(); // 처음 페이지 진입시 데이터 호출
        }

        $('html, body').css({'overflow': 'auto', 'height': 'auto'});
    }
    , watch : {
        myPosting : function(val) {
            const _self = this;
            _self.viewMyPostings(val);
        }
    }
    , computed : {
        forum_idx(){ return this.$store.getters.forum_idx; }, 
        max_posting_idx(){ return this.$store.getters.max_posting_idx;}, 
        posting_idx(){ return this.$store.getters.posting_idx; },
        is_mine(){ return this.$store.getters.is_mine; }, 
        postingData() { return this.postingList.length > 0; },
        myProfile() { return this.$store.getters.myProfile; }, 
        forum() { return this.$store.getters.forum; },
        forumList() { return this.$store.getters.forumList; },
        forumCount() { return this.$store.getters.forumCount; }, 
        descriptions() { return this.$store.getters.descriptions; }, 
        myClapCounts() { return this.$store.getters.myClapCounts; },
        bubbleCount() { return Math.round(this.postingAreaHeight/524); },
    }
    , methods : {
        // createInfiniteGrid InfiniteGrid 생성
        createInfiniteGrid() {
            const _self = this;
            _self.ig = new eg.InfiniteGrid("#container", {
                isConstantSize: true,
                transitionDuration: 0.5,
                useRecycle : false,
                useFit : true,
                isEqualSize : false,
                threshold : 10,
                renderExternal: true,
            }).on({
                "append" : _self.getPostingLoad,
                "layoutComplete" : _self.layoutCompleteInfiniteGrid
            });

            _self.ig.setLayout(eg.InfiniteGrid.GridLayout, {align: "center", margin:20});
        },
        // 페이지 처음 진입시 조회
        getFirstPosting() {
            if( this.loadingPosting )
                return false;

            this.loadingPosting = true;
            this.$store.commit("SET_FORUM_IDX", this.forumIndex);
            call_apiV2("GET", "/linker/postings/forum/" + this.forumIndex, null, this.setPostingHtml);
        },
        // 조회한 posting 데이터 infiniteGrid에 적용
        setPostingHtml(data) {
            if (data.length > 0) {
                this.postingList = data;
                this.$store.commit("SET_MAX_POSTING_IDX", data[data.length - 1].postingIdx);
                this.ig.append(this.setPostingList(data));
            }
            this.loadingPosting = false;
        },
        //region layoutCompleteInfiniteGrid 그리드 레이아웃 추가 완료시 포스팅 박수5개 class추가 및 배경 버블 추가를 위한 height 계산
        layoutCompleteInfiniteGrid(e) {
            if( e.isAppend ) {
                this.postingAreaHeight = document.querySelector('.grid_containr').offsetHeight;
            }
        },
        //endregion
        // 데이터 조회
        getPostingLoad() {
            if( this.loadingPosting )
                return false;

            this.loadingPosting = true;
            call_apiV2("GET", `/linker/postings/forum/${this.forumIndex}/max/${this.max_posting_idx}/mine/${this.onlyMyPosting}`,
                        null, this.setPostingHtml);
        },
        // 조회한 데이터 HTML 변경
        setPostingList(postingList) {
            let htmlList = [];
            postingList.forEach(function (item, index) {
                let commentImages = item.commentImages;
                let clapClass = "";
                let clapLottieHtml = "";
                let onlyTextClass = "";
                let clapBtnClass = "";

                let isContentLong = false;
                if( item.postingContent.length > 200 ) {
                    isContentLong = true;
                    item.postingContent = item.postingContent.substr(0, 200) + '...';
                }
                if (item.clapCount >= 30) {
                    clapClass = "over-clap";
                    clapBtnClass = "on";
                    clapLottieHtml = `<lottie-player autoplay loop class="loop-clap" src="/vue/linker/bubbleAll.json" background="transparent" style="position: absolute"></lottie-player>`;
                }

                if (item.commentCount <= 0 && !isContentLong) {
                    onlyTextClass = "only-txt";
                }

                let html = "";
                html += `<div class="grid-item" data-idx="${item.postingIdx}" style="cursor: pointer;">
                                <div class="post-position ${clapClass} ${onlyTextClass}">`;
                html += `           <div class="post-list">`
                html += `               <div class="profile ${item.hostOrGuest ? 'p_infu' : ''}"><div class="bd_pro"><img src="${item.userImage}" alt=""></div></div>`;
                if( item.userDescription && item.userDescription !== 'WHITE' && item.userDescription !== 'RED' ) {
                    html += `           <p class="level">${item.userDescription}</p>`;
                }
                html += `               <p class="nick-name">${item.userNickname}</p>`;
                if (item.linkTitle) {
                    html += `           <div class="plan">`;
                    html += `               <div class="thum ${item.linkType === 2 ? 'produce' : ''}"><img src="${item.linkThumbnail}" alt=""></div>`;
                    html += `           </div>`;
                }
                html += `               <p class="conts">${item.postingContent}</p>`;
                if( isContentLong ) {
                    html += `           <button type="button" class="btn-more" onclick="app.openPosting(this, ${item.postingIdx}, ${item.blocked})">더보기</button>`;
                }
                if ( item.commentCount > 0  ) {
                html += `         <div class="feed-area">`;
                html += `             <div class="feed-count"><span class="icon"></span><span class="count">${item.commentCount}개</span></div>`;
                    if (commentImages.length > 0) {
                        if( commentImages.length === 3 ) {
                            html += `             <div class="profile-conts third">`;
                        } else if( commentImages.length === 2 ) {
                            html += `             <div class="profile-conts two">`;
                        } else {
                            html += `             <div class="profile-conts">`;
                        }
                        commentImages.forEach(function (item, idx){
                            html += `                 <div class="feed-profile pro0${idx + 1}"><img src="${item}" alt=""></div>`;
                        }) 
                html += `                         </div>`;
                    }
                    html += `      </div>`;
                }

                html += `<div class="lottie-view" onclick="app.openPosting(this, ${item.postingIdx}, ${item.blocked})" >`
                // lottie 이미지 영역 추가
                html += `<lottie-player class="max-clap loop-clap" src="/vue/linker/bubbleAll.json" background="transparent" style="position: absolute; display: none;"></lottie-player>`;
                html += clapLottieHtml;
                for( let i=1 ; i<=5 ; i++ ) {
                    html += `<lottie-player class="ico-claps" src="/vue/linker/bubble0${i}.json" background="transparent"></lottie-player>`;
                }
                html += `</div>`
                if (item.blocked) {
                    html += `
                                <div class="bg_blind">
                                    <span class="icon"></span>
                                    <p>여러 명의 신고로<br/>가려진 포스팅입니다</p>    
                                </div>
                            `
                } else {
                    html += `
                        <button onclick="app.postClap(this, ${item.postingIdx})" type="button" class="btn-like-clap ico-clap ${clapBtnClass}">
                            <div class="border">
                                <div class="like-clap">
                                    <span class="icon"></span>
                                    <span class="clap-count">${item.clapCount}</span>
                                </div>
                            </div>
                        </button>
                    `;
                }
                html += `       </div>`;
                html += `   </div>`;
                html += `</div>`;
                htmlList.push(html);
            });
            let resultPostingHtml = [];
            htmlList.forEach(el => {
                resultPostingHtml.push(el.replaceAll("\n", ""));
            });
            return resultPostingHtml;
        },
        // 내 글만 보기시 infiniteGrid 재 설정
        setInfinite(val) {
            const _self = this;
            $('#container').empty();
            $('#container').css("height", "0px");
            _self.postingList = [];
            _self.ig = null; 
            _self.createInfiniteGrid();
            
            if (val) {  
                _self.getPostingLoad();
            } else {
                _self.getFirstPosting();
            }
        },
        //writePosting 새 포스팅 등록
        writePosting() {
            if ( !isUserLoginOK ) {
                if (confirm('로그인이 필요한 서비스입니다.\n로그인 하시겠어요?') ) {
                    this.goLoginPage();
                }
            } else if ( !this.myProfile.registration ) {
                this.lockBodyScroll();
                this.showProfileModal = true;
            } else {
                this.lockBodyScroll();
                this.showPostingWriteModal = true;
            }
        },
        //addLink 링크 추가
        addLink(type, item) {
            this.$refs.modalWrite.addLink(type, item);
        },
        //completePostProfile 포스팅 등록 완료
        completePostProfile() {
            this.$store.dispatch('GET_MY_PROFILE');
            this.showProfileModal = false;
            this.unlockBodyScroll();
        },
        // 포스팅 자세히보기 모달 열기
        openPosting(el, postingIndex, blocked) {
            if( el.classList.contains('btn-like-clap') ) { // 박수버튼일 경우 박수
                this.postClap(el, postingIndex);
                return false;
            }

            if( blocked )
                return false;

            const positionIndex = this.getPostingPositionIndex(el);
            fnAmplitudeEventMultiPropertiesAction('click_posting', 'forum_index|posting_index|position_index', 
                `${this.forumIndex}|${postingIndex}|${positionIndex}`);

            this.$refs.modalPosting.open(postingIndex);
            this.showPostingDetailModal = true;
            this.lockBodyScroll();
        },
        getPostingPositionIndex(el) {
            return $(el).closest('.grid-item').index();
        },
        // 자세히 보기
        openForumDetail() {
            const _self = this;
            _self.showForumDetail = true;
            _self.lockBodyScroll();
        },
        //region modifyPosting 포스팅 수정
        modifyPosting(postingIndex) {
            const _self = this;
            _self.showPostingWriteModal = true;
            _self.$refs.postingWriteModal.setModifyPostingData(postingIndex);
        },
        //endregion
        //region lockBodyScroll, unlockBodyScroll 바디 스크롤 잠금/해제
        lockBodyScroll() {
            $('html, body').css({'overflow': 'hidden'});
            $('.modalV20').addClass('show');
            $('#contentWrap').on('scroll touchmove mousewheel', function(event) // 터치무브 및 마우스휠 스크롤 막기
            {   event.preventDefault();
                event.stopPropagation();
                return false; 
            });
        },
        unlockBodyScroll() {
            $('html, body').css({'overflow': 'auto', 'height': 'auto'});
            $('#contentWrap').off('scroll touchmove mousewheel'); // 터치무브 및 마우스휠 스크롤 가능
            $('.modalV20').removeClass('show');
        },
        //endregion
        // ShowForumDetail 닫기 처리
        closeShowForumDetail() {
            this.showForumDetail = false;
            this.unlockBodyScroll();
        },
        // showPostingWriteModal 닫기 처리
        closeShowPostingWriteModal() {
            this.showPostingWriteModal = false;
            this.unlockBodyScroll();
        },
        // showPostingDetailModal 닫기 처리
        closeShowPostingDetailModal() {
            this.showPostingDetailModal = false;
            this.unlockBodyScroll();
        },
        // showProfileModal 닫기 처리
        closeShowProfileModal() {
            this.showProfileModal = false;
            this.unlockBodyScroll();
        },
        // showProfileModal 열기 처리
        openProfileWrite() {
            this.closeShowPostingDetailModal();
            this.showProfileModal = true;
            this.lockBodyScroll();
        },
        // 내 글만 보기 기능
        viewMyPostings() {
            fnAmplitudeEventMultiPropertiesAction('click_show_mypost', 'forum_index', this.forumIndex.toString());
            location.replace(`?idx=${this.forumIndex}&me=${this.onlyMyPosting ? 0 : 1}`);
        },
        //region postClap 박수 등록
        postClap(el, postingIdx) {
            const _self = this;
            if( !_self.isLogin && confirm('로그인이 필요한 서비스입니다.\n로그인 하시겠어요?') ) {
                _self.goLoginPage();
                return;
            } else if (_self.isLogin) {   
                if (_self.clapingElement) {
                    return false;
                } else {
                    _self.clapingElement = el;
                }
                
                const count = _self.myClapCounts[postingIdx] ? _self.myClapCounts[postingIdx] : 0;
                if( count >= 5 ) {
                    alert('고마워요! 하지만 박수는 다섯번까지만 칠 수 있어요 :)');
                    _self.clapingElement = null;
                    return false;
                }

                fnAmplitudeEventMultiPropertiesAction('click_posting_clap', 'forum_index|posting_index|place', `${this.forumIndex}|${postingIdx}|forum_main`);
                
                _self.getFrontApiDataV2('POST', `/linker/posting/${postingIdx}/clap`, null, _self.successPostClap, () => _self.clapingElement = null);
            }
        },
        //endregion
        successPostClap(data) {
            if( data.result ) {
                const postingIndex = data.postingIdx;
                const prevClapCount = this.myClapCounts[postingIndex] ? this.myClapCounts[postingIndex] : 0;

                this.playLottie(prevClapCount);
                this.updateMyClapCounts(postingIndex, prevClapCount);

                if( data.clapCount >= 30 )
                    this.clapingElement.classList.add('on');

                if ( data.clapCount === 30)
                    this.maxClapLottie();

                this.clapingElement.querySelector('.clap-count').innerText = data.clapCount;
                this.clapingElement = null;
            } else {
                alert('고마워요! 하지만 박수는 다섯번까지만 칠 수 있어요 :)');
                this.clapingElement = null;
            }
        },
        maxClapLottie() {
            const lottie = this.clapingElement.parentElement.querySelector(".max-clap");
            lottie.style.display = '';
            lottie.toggleLooping();
            lottie.play();
        },
        playLottie(prevClapCount) {
            const lottie = this.getActiveLottie(prevClapCount);
            lottie.style.position = 'relative';
            lottie.setDirection(1);
            lottie.play();
        },
        getActiveLottie(prevClapCount) {
            const parentElement = this.clapingElement.parentElement;
            parentElement.querySelectorAll('lottie-player').forEach(e => e.style.position = 'absolute');
            return parentElement.querySelectorAll('lottie-player')[prevClapCount + 1];
        },
        updateMyClapCounts(postingIndex, prevClapCount) {
            if( prevClapCount === 0 ) {
                this.$store.commit('PUT_MY_CLAP_COUNTS', postingIndex);
            }
            else {
                let payload = {
                    'postingIndex': postingIndex,
                    'prevClapCount': prevClapCount
                }
                this.$store.commit('ADD_MY_CLAP_COUNTS', payload);
            }
        },
        //endregion
    }
});