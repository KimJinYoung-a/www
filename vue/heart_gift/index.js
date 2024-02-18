const app = new Vue({
  el: "#app",
  store: store,
  mixins: [linker_mixin],
  template: `
    <div class="heart-gift">
      <!-- 메인 상단 영역 -->
      <section class="main">
        <img src="//webimage.10x10.co.kr/fixevent/event/2023/heart_gift/bg_top.jpg" alt="선물의 진심" />
        <div class="video-box">
          <p class="video-dscrp">소중한 사람들과 작은 것부터<br>나누어 주고 싶은 진심 어린 마음</p>
          <video id="vid" preload="auto" controls loop="loop" width="650" height="374"  poster="//webimage.10x10.co.kr/fixevent/event/2022/heart_gift/poster2.jpg/10x10/optimize" playsinline controls>
            <source src="//webimage.10x10.co.kr/fixevent/event/2022/heart_gift/top_gift_video_var3.mp4" type="video/mp4">
          </video>
        </div>
      </section>

      <!-- 선물하기 기능 소개 -->
      <section class="function">
        <img src="//webimage.10x10.co.kr/fixevent/event/2023/heart_gift/bg_fun.jpg" alt="선물하기 기능 소개" />
      </section>

      <!-- 하단 컨텐츠 영역 -->
      <section ref="content01" class="content-wrap">
        <!-- 1depth 탭 -->
        <ul class="gift-tab">
          <li v-for="(tab, index) in sectionTab" :key="tab.id" @click="moveCurrentTab(index)">{{tab.label}}</li>
        </ul>

        <!-- 상품 영억 -->
        <div class="prod gift-prod">
          <h3 class="prod-title">지금 어떤 선물을 줄지 고민이죠?</h3>

          <div ref="categoryGnb" class="prod-tab-wrap" :class="{fixed: cateIsFixed}">
            <ul class="prod-tab-area"  >
              <li v-for="(cate, index) in categoryTab" :key="cate.id" :class="{'active': cateIsActive === cate.id}" @click="prodCategoryPage(index)">
                {{cate.name}}
              </li>
            </ul>
          </div>

          <div v-for="(cate, index) in giftThemeTab" :key="cate.cateId">
            <template v-if="cate.cateId === cateIsActive">
              <div class="banner-box">
                <img :src="cate.topBanner" alt=""/>
              </div>

              <div class="w1060">
                <div class="prd_list type_basic">
                  <article v-for="item in categoryProductList" class="prd_item">
                    <div class="prd_img" :class="{soldout: item.soldOut}">
                        <img :src="decodeBase64(item.list_image)" alt="" />
                        <span class="prd_mask"></span>
                    </div>
                    <div class="prd_info">
                      <div class="prd_price">
                        <span class="set_price">{{formatPrice(item.item_price)}}</span>
                        <span v-if="item.sale_yn" class="discount">{{item.sale_percent}}%</span>
                      </div>
                      <div class="prd_name">{{item.item_name}}</div>
                    </div>
                    <div v-if="item.reviewCount > 0 && item.evalPoint" class="user_side">
                      <span class="user_eval"><dfn>평점</dfn><i :style="'width:' + item.evalPoint + '%'"></i></span> 
                      <span v-if="item.reviewCount > 4" class="user_comment"><dfn>상품평</dfn>{{formatPrice(item.review_cnt)}}</span>
                    </div>
                    <a @click="moveToProductPage(item.item_id)" class="prd_link"><span class="blind">상품 바로가기</span></a>
                  </article>                        
                </div>
              </div>
              <div class="btn-block">
                <button type="button" @click="moveToDetailPage">상품 더보러가기 ></button>
              </div>
            </template>
          </div>
        </div>
      </section>

      <article ref="scrollYCentent" class="banner">
        <!-- 배너 기프트카드 -->
        <section class="gift-card">
          <h2 class="bnr-title">텐바이텐 기프트카드</h2>
          <p class="bnr-dscrp">감성적인 기프트 카드로 마음을 전해보세요.</p>
          <img src="//webimage.10x10.co.kr/fixevent/event/2023/heart_gift/banner01_v2.jpg" alt="텐바이텐 기프트카드" />
          <a href="https://www.10x10.co.kr/giftcard/" class="btn-block"><span>선물하러 가기 ></span></a>
        </section>
        <!-- 배너 선물의참견 -->
        <section ref="content02" class="gift-interfere">
          <h2 class="bnr-title">선물의 참견</h2>
          <p class="bnr-dscrp">친구에게 공유하고 텐텐이들의 참견 받아보세요!</p>
          <a href="https://www.10x10.co.kr/gift/talk/?gaparam=main_menu_gift">
            <img src="//webimage.10x10.co.kr/fixevent/event/2022/heart_gift/pc/banner02.jpg" alt="선물의 참견" />
          </a>
        </section>
      </article>


      <article ref="content03">
        <LINKER></LINKER>
      </article>
    </div>
  `,
  data() {
    return {
      cateIsFixed: false, // 스크롤시 카테고리 상단 고정
      currentTabIndex: 0,
      isWishActive: false, // 좋아요
      cateIsActive: -999, // 카테고리 클릭 이벤트
      sectionTab: [
        {id: 1, label: "이럴때 이런선물"},
        {id: 2, label: "선물 고민 해결"},
        {id: 3, label: "선물 자랑하기"},
      ],
      categoryTab: [
        {
          id: 409102,
          name: "별다꾸러",
        },
        {
          id: 409103,
          name: "감성브이로거",
        },
        {
          id: 409106,
          name: "귀여움수집가",
        },
        {
          id: 409107,
          name: "엄빠연습생",
        },
        {
          id: 409104,
          name: "출근러",
        },
        {
          id: 409108,
          name: "방구석바리스타",
        },
        {
          id: 409101,
          name: "초보갓생러",
        },
        {
          id: 409105,
          name: "홈파티",
        },
        {
          id: 409109,
          name: "어쩌다어른",
        },
        {
          id: 409110,
          name: "댕냥집사",
        },
        {
          id: 409111,
          name: "취미수집가",
        },
        {
          id: 409112,
          name: "남다른나",
        },
      ],
      giftThemeTab: [
        {
          cateId: 409102,
          topBanner: "//webimage.10x10.co.kr/fixevent/event/2022/heart_gift/pc/cate_banner01.png",
          prodList: [],
        },
        {
          cateId: 409103,
          topBanner: "//webimage.10x10.co.kr/fixevent/event/2022/heart_gift/pc/cate_banner02.png",
          prodList: [],
        },
        {
          cateId: 409106,
          topBanner: "//webimage.10x10.co.kr/fixevent/event/2022/heart_gift/pc/cate_banner03.png",
          prodList: [],
        },
        {
          cateId: 409107,
          topBanner: "//webimage.10x10.co.kr/fixevent/event/2022/heart_gift/pc/cate_banner04.png",
          prodList: [],
        },
        {
          cateId: 409104,
          topBanner: "//webimage.10x10.co.kr/fixevent/event/2022/heart_gift/pc/cate_banner05.png",
          prodList: [],
        },
        {
          cateId: 409108,
          topBanner: "//webimage.10x10.co.kr/fixevent/event/2022/heart_gift/pc/cate_banner06.png",
          prodList: [],
        },
        {
          cateId: 409101,
          topBanner: "//webimage.10x10.co.kr/fixevent/event/2022/heart_gift/pc/cate_banner07.png",
          prodList: [],
        },
        {
          cateId: 409105,
          topBanner: "//webimage.10x10.co.kr/fixevent/event/2022/heart_gift/pc/cate_banner08.png",
          prodList: [],
        },
        {
          cateId: 409109,
          topBanner: "//webimage.10x10.co.kr/fixevent/event/2022/heart_gift/pc/cate_banner09.png",
          prodList: [],
        },
        {
          cateId: 409110,
          topBanner: "//webimage.10x10.co.kr/fixevent/event/2022/heart_gift/pc/cate_banner10.png",
          prodList: [],
        },
        {
          cateId: 409111,
          topBanner: "//webimage.10x10.co.kr/fixevent/event/2022/heart_gift/pc/cate_banner11.png",
          prodList: [],
        },
        {
          cateId: 409112,
          topBanner: "//webimage.10x10.co.kr/fixevent/event/2022/heart_gift/pc/cate_banner12.png",
          prodList: [],
        },
      ],
      categoryProductList:[],
    };
  },
  watch: {
    cateIsActive(targetId) {
      this.categoryProductList= []
      if (targetId > 0) {
        this.$store.dispatch("GET_CATEGORIES_ITEMS", targetId).then(() => {
          this.categoryProductList = this.$store.getters.category_items.items;
          console.log("2")
          console.log(this.categoryProductList)
        });
      }
    },
  },
  computed: {
    categoryItems() {
      return this.$store.getters.category_items;
    },
  },
  created() {
    this.currentTabIndex = Math.floor(Math.random() * this.categoryTab.length);
    this.cateIsActive = this.categoryTab[this.currentTabIndex].id;
    this.$store.dispatch("GET_CATEGORIES_ITEMS", this.cateIsActive).then(() => {
      this.categoryProductList = this.$store.getters.category_items.items;
      console.log("1")
      console.log(this.categoryProductList)
    });
  },
  mounted() {
    window.addEventListener("scroll", this.scrollTab);
  },
  destroyed() {
    window.removeEventListener("scroll", this.scrollTab);
  },
  methods: {
    decodeBase64(str) {
      if (str == null) return null;
      return atob(str.replace(/_/g, "/").replace(/-/g, "+"));
    },
    formatPrice(price) {
      if (price) {
        return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
      }
    },
    moveCurrentTab(index) {
      window.scrollTo({
        top: this.$refs["content0" + this.sectionTab[index].id].offsetTop + 200, // 상단에서 위치
        left: 0,
        behavior: "smooth", // 애니메이션
      });
    },

    prodCategoryPage(index) {
      this.cateIsActive = this.giftThemeTab[index].cateId;
      window.scrollTo({
        top: this.$refs['content01'].offsetTop, //카테고리 최상단
        left: 0,
        behavior: 'smooth',
      });
    },
    reviewAVG(obj) {
      return "width:" + obj + "%";
    },
    showCount(obj) {
      return obj == "999" ? "999+" : obj;
    },
    moveToDetailPage() {
      window.location.href = `/event/heart_gift/detail.asp?attribCd=${this.cateIsActive}`;
    },
    moveToProductPage(itemId) {
      goProduct(itemId);
    },
    click_wish() {
      this.isWishActive = !this.isWishActive;
    },
     // content01 영역에서만 카테고리 노출
     scrollTab() {
      if (window.scrollY > this.$refs.content01.offsetTop + 500 && window.scrollY < this.$refs.scrollYCentent.offsetTop) {
        this.cateIsFixed = true;
      } else {
        this.cateIsFixed = false;
      }
    },
  },
});
