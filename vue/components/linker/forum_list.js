Vue.component('FORUM-LIST', {
    template : `
    <div class="forum_view_wrap">
        <div class="forum_list_wrap">
            <div class="swiper forum_slider">
                <div class="swiper-wrapper" @click="closeForumList">
                    <div class="swiper-slide" v-for="forum in forumList">
                        <div @click="forumMove(forum)" class="forum_list_view" :style="getBackgroundImage(forum)">
                            <p class="tit">{{forum.subTitle}}</p>
                            <p class="txt" v-html="forum.title"></p>
                            <span v-if="forumIconClass(forum) !== ''" :class="forumIconClass(forum)"></span>
                            <!-- 종료시 노출 -->
                            <div v-if="isEndContent(forum)" class="dim" @click="checkForum(forum)"></div>
                            <!-- bg가 영상일때 노출 -->
                            <div v-if="forum.backgroundMediaType === 'video'" class="video_wrap">
                                <video loop="" autoplay="" muted="">
                                    <source :src="decodeBase64(forum.backgroundMediaValue)" type="video/mp4"">
                                </video>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="swiper-button-prev"></div>
                <div class="swiper-button-next"></div>
            </div>
        </div>
        <div class="dim" @click="$emit('closeModal')"></div>
        <button type="button" @click="$emit('closeModal')" class="btn_pop_close"></button>
    </div>

    `,
    data() {
        return {
            mySwiper: null,
            forum: null
        }
    },
    props : {
        forumList : {
            type: Array,
            default: null
        }
    },
    mounted() {
        const _self = this;
        this.mySwiper = new Swiper('.forum_slider', {
            slidesPerView:"auto",
            breakpoints: {
                // when window width is <= 1400px
                1400: {
                slidesPerView:3,
                },
            },
            navigation: {
                nextEl: '.swiper-button-next',
                prevEl: '.swiper-button-prev',
            }
        });
    },
    methods : {
        // new, 종료 icon 처리
        forumIconClass(forum) {
            let result = "";
            let now = new Date();
            let startDate = new Date(forum.startDate);
            let endDate = new Date(forum.endDate);
            if (startDate >= now || endDate <= now) {
                result = "icon_close";
                return result;
            }
            let newIcon = new Date(forum.startDate);
            newIcon.setDate(newIcon.getDate() + 14);
            if (newIcon >= now) {
                result = "icon_new"
            }
            return result;
        },
        // 배경 이미지
        getBackgroundImage(forum) {
            const _self = this;
            let result = {};
            if (forum.backgroundMediaType === 'image') {
                result = {
                    'background-image': 'url(' + _self.decodeBase64(forum.backgroundMediaValue) + ')'
                }
            } else if (forum.backgroundMediaType === 'color') {
                result = {
                    'background-color' : _self.decodeBase64(forum.backgroundMediaValue)
                }
            }
            return result;
        },
        // 종료된 컨텐츠 체크
        isEndContent(forum) {
            let result = false;
            let now = new Date();
            let startDate = new Date(forum.startDate);
            let endDate = new Date(forum.endDate);
            if (startDate >= now || endDate <= now) {
                result = true;
            }
            return result;

        },
        decodeBase64(str) {
            if( str == null ) return null;
            return atob(str.replace(/_/g, '/').replace(/-/g, '+'));
        },
        // 포럼 이동
        forumMove(forum) {
            fnAmplitudeEventMultiPropertiesAction('click_forum', 'forum_index', forum.forumIdx.toString());
            location.replace('?idx=' + forum.forumIdx);
        },
        // 종료된 포럼인지 체크
        checkForum(forum) {
            if ( this.isEndContent(forum) ) {
                this.forum = forum;
            }
        },
        // 종료된 포럼을 클릭했을 때는 닫기 처리 안함
        closeForumList() {
            if (!(this.forum && this.isEndContent(this.forum))) {
                this.$emit('closeModal');
            }
            this.forum = null;
        }
    }
})