// Vue.use(MasonryInfiniteGrid);

Vue.component("LINKER", {
  template: `
  <div class="forum_posting">
    <h2 class="bnr-title">우리가 몰랐던 당신의 선물​</h2>
    <p class="bnr-dscrp">다른 사람들의 선물상자를 참고해보면 어때요?​</p>

    <div class="heart-gift-grid" ref="forumElements">
    <!-- 포스팅 리스트 -->
      <div v-for="(posting, index) in postingList" :key="posting.postingIdx" class="post-list">
        <div class="post-position" :class="{'over-clap':posting.clapCount >= 30, 'only-txt': !longContent && posting.commentCount === 0}">
          <div class="profile" :class="{'p_infu':posting.hostOrGuest}">
            <div class="bd_pro"><img :src="posting.userImage" alt="프로필"></div>
          </div>
          <p v-if="posting.userDescription" class="level">{{ posting.userDescription }}</p>
          <p class="nick-name">{{posting.userNickname}}</p>
          <div class="plan">
            <div class="thum" :class="{'produce' : posting.linkType === 2}">
              <img :src="posting.linkThumbnail" alt="" />
            </div>
          </div>
          <p class="conts">{{posting.postingContent}}</p>
          <div class="lottie-view" v-html="createPostingLottieHtml(posting.clapCount)" />
          <button type="button"
                  class="btn-like-clap ico-clap"
                  :class="{on : posting.clapCount >= 30}"
                  @click="clap(posting, index)">
            <div class="border">
              <div class="like-clap">
                <span class="icon"></span>
                <span>{{posting.clapCount}}</span>
              </div>
            </div>
          </button>
        </div>
      </div>
    </div>
    <div class="btn-block">
      <button type="button" onclick="location.href='https://www.10x10.co.kr/linker/forum.asp?idx=8';">더 많은 자랑 보러가기></button>
    </div>
  </div>
  `,
  data() {
    return {
      longContent: false, // 현재 포스팅 영역 높이
      isRenderedList: false,
    };
  },
  created() {
    this.$store.dispatch("SET_LINKER_POSTING");
    this.$store.dispatch("GET_MY_CLAP_COUNTS");
  },
  mounted() {},
  updated() {
    this.$nextTick(() => {
      if (typeof this.$refs.forumElements !== "undefined") {
        console.log(this.$refs.forumElements);
        this.masonryLayout(this.$refs.forumElements.children);
      }
    });
  },
  computed: {
    postingList() {
      console.log(this.$store.getters.linker_posting.slice(0, 14))
      return this.$store.getters.linker_posting.slice(0, 14);
    },
    myClapCounts() {
      return this.$store.getters.myClapCounts;
    },
  },
  methods: {
    clap(posting, lottieAnimationTargetIndex) {
      if (isUserLoginOK) {
        const count = this.myClapCounts[posting.postingIdx]
          ? this.myClapCounts[posting.postingIdx]
          : 0;
        if (count >= 5) {
          alert("고마워요! 하지만 박수는 다섯번까지만 칠 수 있어요 :)");
          return;
        }

        const uri = `/linker/posting/${posting.postingIdx}/clap`;
        call_apiV2(
          "POST",
          uri,
          null,
          response => {
            posting.clapCount += 1;
            this.successClapCallback(response, lottieAnimationTargetIndex);
          },
          () => {},
        );
      } else {
        if (confirm("로그인이 필요한 서비스입니다.\n로그인 하시겠어요?")) {
          this.goLoginPage();
        }
      }
    },
    successClapCallback(data, lottieAnimationTargetIndex) {
      if (data.result) {
        const postingIndex = data.postingIdx;
        const prevClapCount = this.myClapCounts[postingIndex] ? this.myClapCounts[postingIndex] : 0;
        this.playLottie(prevClapCount, lottieAnimationTargetIndex);
        this.updateMyClapCounts(postingIndex, prevClapCount);
      } else {
        alert("고마워요! 하지만 박수는 다섯번까지만 칠 수 있어요 :)");
      }
    },
    createPostingLottieHtml(clapCount) {
      let html = "";
      for (let i = 1; i <= 5; i++) {
        html += `<lottie-player class="ico-claps" src="/vue/linker/bubble0${i}.json?v=1.0" background="transparent" ${
          i === 5 && clapCount >= 30 ? "autoplay loop" : ""
        }></lottie-player>`;
      }

      return html;
    },
    playLottie(prevClapCount, lottieAnimationTargetIndex) {
      const lottie = this.getActiveLottie(prevClapCount, lottieAnimationTargetIndex);
      if (lottie) {
        lottie.setDirection(1);
        lottie.play();
      }
    },
    getActiveLottie(prevClapCount, lottieAnimationTargetIndex) {
      const parent = document.getElementsByClassName("lottie-view");
      if (parent.length >= lottieAnimationTargetIndex) {
        return parent[lottieAnimationTargetIndex].querySelectorAll("lottie-player")[prevClapCount];
      }

      return null;
    },
    updateMyClapCounts(postingIndex, prevClapCount) {
      if (prevClapCount === 0) this.$store.commit("PUT_MY_CLAP_COUNTS", postingIndex);
      else this.$store.commit("ADD_MY_CLAP_COUNTS", postingIndex);
    },
    masonryLayout(elements) {
      const masonryContainerStyle = getComputedStyle(document.querySelector(".heart-gift-grid"));
      const columnGap = parseInt(masonryContainerStyle.getPropertyValue("column-gap"));
      const autoRows = parseInt(masonryContainerStyle.getPropertyValue("grid-auto-rows"));

      console.log(elements);
      for (let i = 0; i < elements.length; i++) {
        const item = elements[i];
        item.style.gridRowEnd = `span ${
          Math.ceil(
            item.querySelector(".post-position").scrollHeight / autoRows + columnGap / autoRows,
          ) + 7
        }`;
      }
    },
  },
});
