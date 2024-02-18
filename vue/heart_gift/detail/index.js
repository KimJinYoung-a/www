const app = new Vue({
  el: "#app",
  store: store,
  template: `
    <div ref="giftDetail" class="heart-gift w1140">
      <!-- 상단 메뉴 + 배너 -->
      <article class="sub-bnr" >
        <div ref="categoryGnb" class="prod-tab-wrap" :class="{fixed: cateIsFixed}">
          <ul class="prod-tab-area" >
            <li v-for="(item, index) in heartTab" :key="item.id" :class="{'active': cateIsActive === item.attribCd}" @click="prodCategoryPage(item.attribCd)">
              {{item.attribName}}
            </li>
          </ul>
        </div
      </article>
      
      <!-- 컨텐츠 영역 -->
      <template v-for="(cate, index) in heartTab" :key="cate.attribCd" >
        <template v-if="cate.attribCd === cateIsActive">
          <article class="sub-contents ">
            <div class="banner-box">
              <img :src="cate.image1" alt="">
            </div>
            <!-- 카테고리 리스트 -->
            <ul v-if="categories.length > 1" class="sub-menu-area">
              <li v-for="(item, index) in categories" :key="item.id" :class="{'active': searchCateCode == item.cate_code}" @click="clickCategories(item.cate_code)">
                {{item.cate_name}}
              </li>
            </ul>
            <!-- 필터링 -->
            <div class="view-select">
              <button type="button" class="btn-view" :class="{active: sortList}" @click="click_sort">{{searchSort.name}} 보기</button>
              <ul v-if="!sortList" class="select-list">
                <li @click="sorting('best')">인기순으로 보기</li>
                <li @click="sorting('new')">신규순으로 보기</li>
                <li @click="sorting('br')">평가좋은순 보기</li>
                <li @click="sorting('hp')">높은가격순 보기</li>
                <li @click="sorting('bs')">판매량순 보기</li>
                <li @click="sorting('ws')">위시순 보기</li>
                <li @click="sorting('lp')">낮은가격순 보기</li>
                <li @click="sorting('hs')">할인율순 보기</li>
              </ul>
            </div>
          </article>

          <!-- 상품리스트 영역 -->
          <article class="pdtWrap pdt240V15 w1140">
            <ul class="pdtList">
              <li v-for="(item, index) in categoryItem" :key="item.itemId" >
                <div class="pdtBox" >
                  <i v-if="item.free_baesong" class="free-shipping-badge">무료<br>배송</i>
                  <div class="pdtPhoto" :class="{pdtPhoto: item.soldOut}"> 
                    <a @click="moveToProductPage(item.item_id)">
                      <img :src="decodeBase64(item.list_image)" alt="상품">
                      <dfn><img :src="item.imageURL" alt="상품"></dfn>
                    </a>
                  </div>
                  <div class="pdtInfo">
                    <p class="pdtBrand tPad20" @click="moveToBrandPage(item.brand_id)"><a>{{item.brand_name}}</a></p>
                    <p class="pdtName tPad07" @click="moveToProductPage(item.item_id)"><a>{{item.item_name}}</a></p>
                    <p v-if="item.sale_yn" class="pdtPrice"><span class="txtML">{{formatPrice(item.org_price)}}원</span></p>
                    <p class="pdtPrice"><span class="finalP">{{formatPrice(item.item_price)}}원</span> <strong v-if="item.sale_yn" class="cRd0V15">[{{item.sale_percent}}%]</strong></p>
                    <!-- 아이템 뱃지 데이터 확인  --> 
                    <p class="pdtStTag tPad10">
                      <img v-if="item.sale_yn" src="http://fiximage.10x10.co.kr/web2013/shopping/tag_sale.gif" alt="SALE">
                      <img v-if="item.item_coupon_yn" src="http://fiximage.10x10.co.kr/web2013/shopping/tag_coupon.gif" alt="쿠폰">
                      <img v-if="item.free_baesong" src="http://fiximage.10x10.co.kr/web2013/shopping/tag_free_ship.gif" alt="무료배송">
                      <img v-if="item.limityn" src="http://fiximage.10x10.co.kr/web2013/shopping/tag_limited.gif" alt="한정">
                      <img v-if="item.ten_only" src="http://fiximage.10x10.co.kr/web2013/shopping/tag_only.gif" alt="ONLY">
                      <img v-if="item.newyn" src="http://fiximage.10x10.co.kr/web2013/shopping/tag_new.gif" alt="NEW">
                      <span v-if="item.pojangok" class="icoWrappingV15a">
                          <img src="http://fiximage.10x10.co.kr/web2015/shopping/ico_pakage_act.png" alt="선물포장가능">
                          <em><img src="http://fiximage.10x10.co.kr/web2015/common/pkg_tip.png" alt="선물포장가능"></em>
                      </span>
                    </p>
                  </div>
                  <ul class="pdtActionV15">
                    <li class="largeView"><a @click="go_zoom(item.item_id)" href="javascript:void(0)"><img src="http://fiximage.10x10.co.kr/web2015/common/btn_quick.png" alt="QUICK"></a></li>
                    <li class="postView"><a @click="itemReView(item.item_id)" href="javascript:void(0)"><span>{{formatPrice(item.review_cnt)}}</span></a></li>
                    <li class="wishView"><a @click="addWishItem(item.item_id)"  href="javascript:void(0)"><span>{{formatPrice(item.favcount)}}</span></a></li>
                  </ul>
                </div>
              </li>
            </ul>
          </article>
        </template>
      </template>
    </div>
    `,
  data() {
    return {
      cateIsFixed: false, // 스크롤시 카테고리 상단 고정
      cateIsActive: 409102, // 카테고리 클릭 이벤트
      categoryTab: [
        {
          id: 409102,
          name: '별다꾸러',
        },
        {
          id: 409103,
          name: '감성브이로거',
        },
        {
          id: 409106,
          name: '귀여움수집가',
        },
        {
          id: 409107,
          name: '엄빠연습생',
        },
        {
          id: 409104,
          name: '출근러',
        },
        {
          id: 409108,
          name: '방구석바리스타',
        },
        {
          id: 409101,
          name: '초보갓생러',
        },
        {
          id: 409105,
          name: '홈파티',
        },
        {
          id: 409109,
          name: '어쩌다어른',
        },
        {
          id: 409110,
          name: '댕냥집사',
        },
        {
          id: 409111,
          name: '취미수집가',
        },
        {
          id: 409112,
          name: '남다른나',
        },
      ],
      searchCateCode: "", // 카테고리 전체
      searchPage: 1,
      sortList: true, // sort 노출 여부
      searchSort: {
        sort: "best",
        name: "인기순",
      },
    };
  },
  created() {
    const params = this.getUrlParams();
    this.cateIsActive = params.attribCd;
    {
      params.sort ? this.searchSort.sort = params.sort : this.searchSort.sort = "best"
    }
    {
      params.catecode ? this.searchCateCode = params.catecode : this.searchCateCode = ""
    }
    this.$store.dispatch("GET_ATTRIBUTE_GROUP");
    this.$store.dispatch("GET_CATEGORIES", params.attribCd);
    this.method_go_search()
    switch (this.searchSort.sort) {
      case "best": this.searchSort.name = ("인기순으로");break;
      case "new" : this.searchSort.name = ("신규순으로");break;
      case "br" : this.searchSort.name = ("평가좋은순");break;
      case "hp" : this.searchSort.name = ("높은가격순");break;
      case "bs" : this.searchSort.name = ("판매량순");break;
      case "ws" : this.searchSort.name = ("위시순");break;
      case "lp" : this.searchSort.name = ("낮은가격순");break;
      case "hs" : this.searchSort.name = ("할인율순");break;
    }
  },
  computed: {
    heartTab() {
      return this.$store.getters.heart_tab;
    },
    categories() {
      return this.$store.getters.categories;
    },
    categoryItem() {
      return this.$store.getters.category_item;
    },
    category_item_last_page() {
      return this.$store.getters.category_item_last_page;
    }
  },
  mounted() {
    window.addEventListener("scroll", this.scrollTab);
  },
  destroyed() {
    window.removeEventListener("scroll", this.scrollTab);
  },
  methods: {
    getUrlParams() {
      let params = {};
      window.location.search.replace(/[?&]+([^=&]+)=([^&]*)/gi, (str, key, value) => {
        params[key] = value;
      });

      return params;
    },
    prodCategoryPage(attribCd) {
      window.scrollTo({
        top: this.$refs.categoryGnb.offsetTop,
        left: 100,
        behavior: 'smooth'
      })
      // window.scrollTo(0, 100);
      this.cateIsActive = attribCd;
      this.$store.dispatch("GET_CATEGORIES", this.cateIsActive);
      this.method_reset_search_param();
      this.method_go_search();
    },
    method_go_search() {
      const _this = this;
      let api_data = {
        attribCd: _this.cateIsActive,
        sortMethod: _this.searchSort.sort,
        catecode: _this.searchCateCode,
        page: _this.searchPage,
      };
      this.$store.dispatch("GET_CATEGORY_ITEM", api_data);
    },
    // 상단 메뉴 선택
    scrollTab() {
      if (window.scrollY > this.$refs.categoryGnb.offsetTop) {
        this.cateIsFixed = true;
      } else {
        this.cateIsFixed = false;
      }
      if ($(window).scrollTop() * 1.3 >= $(document).height() - $(window).height()) {
        if (this.category_item_last_page > this.searchPage) {
          this.searchPage += 1;
          this.method_go_search();
        }
      }
    },
    method_reset_search_param() {
      this.searchCateCode = "";
      this.showType = "detail";
      this.searchSort = {
        sort: "best",
        name: "인기순",
      };
      this.searchPage = 1;
    },
    get_url_param(param_name){
      let now_url = location.search.substr(location.search.indexOf("?") + 1);
      now_url = now_url.split("&");
      let result = "";
      for(let i = 0; i < now_url.length; i++){
        let temp_param = now_url[i].split("=");
        if(temp_param[0] == param_name){
          result = temp_param[1].replace("%20", " ");
        }
      }
      return result;
    },
    sorting(sort){
      parent.location.href = "/event/heart_gift/detail.asp?attribCd=" + this.cateIsActive + "&referrer=" + this.get_url_param("referrer") + "&catecode=" + this.searchCateCode + "&sort=" + sort;
    },
    formatPrice(price) {
      if (price) {
        return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
      }
    },
    // 중분류 카테고리 스와이퍼
    clickCategories(cateCode) {
      parent.location.href = "/event/heart_gift/detail.asp?attribCd=" + this.cateIsActive + "&referrer=" + this.get_url_param("referrer") + "&catecode=" + cateCode  + "&sort=" + this.searchSort.sort;
    },
    click_sort(event) {
      this.sortList = !this.sortList;
    },
    reviewAVG(obj) {
      return "width:" + obj + "%";
    },
    showCount(obj) {
      return obj == "999" ? "999+" : obj;
    },
    
    decodeBase64(str) {
      if( str == null ) return null;
      return atob(str.replace(/_/g, '/').replace(/-/g, '+'));
    },
    moveToBrandPage(brandId) {
      parent.location.href='/street/street_brand_sub06.asp?makerid='+brandId;
    },
    moveToProductPage(itemId) {
      goProduct(itemId);
    },
    go_zoom(itemid){
      ZoomItemInfo(itemid);
    },
    itemReView(itemid){
      popEvaluate(itemid)
    },
    addWishItem(targetId) {
      fnWishAdd(targetId);
    },
  },
});
