"use strict";

Vue.component('EVENT', {
  template: "\n        <section id=\"tab04\" class=\"tab04\">\n            <section class=\"section10\" id=\"cheer03\">\n                <a v-if=\"goods\" href=\"javascript:void(0)\" @click=\"movePage(goods.linkurl)\">\n                    <img :src=\"goods.imageurl\" alt=\"\">\n                </a>\n            </section>\n            <section class=\"section11\" id=\"cheer04\">\n                <div class=\"banner_wrap\">\n                    <a v-if=\"diaryStory\" href=\"javascript:void(0)\" @click=\"movePage(diaryStory.linkurl)\" id=\"cheer04\">\n                        <img :src=\"diaryStory.imageurl\" alt=\"\">\n                    </a>\n                    <a v-if=\"bestItem\" href=\"javascript:void(0)\" @click=\"movePage(bestItem.linkurl)\">\n                        <img :src=\"bestItem.imageurl\" alt=\"\">\n                    </a>\n                    <a href=\"#app_qr\" class=\"app_qr\">\n                        <img :src=\"firstBuyShop.imageurl\" alt=\"\">\n                    </a>\n                </div>\n            </section>\n            <section class=\"section12\" id=\"cheer06\">\n                <button @click=\"moveForumPage\"></button>\n                <div class=\"hbd\">\n                    <p class=\"icon01\"><img src=\"//webimage.10x10.co.kr/fixevent/event/2022/anniversary/heart.png\" alt=\"\"></p>\n                    <p class=\"icon02\"><img src=\"//webimage.10x10.co.kr/fixevent/event/2022/anniversary/message01.png\" alt=\"\"></p>\n                    <p class=\"icon03\"><img src=\"//webimage.10x10.co.kr/fixevent/event/2022/anniversary/message02.png\" alt=\"\"></p>\n                    <p class=\"icon04\"><img src=\"//webimage.10x10.co.kr/fixevent/event/2022/anniversary/message03.png\" alt=\"\"></p>\n                </div>\n            </section>\n            <section class=\"section13\" id=\"app_qr\">\n                <img src=\"//webimage.10x10.co.kr/fixevent/event/2022/anniversary/app_qr.png\" alt=\"\">\n            </section>\n            <section class=\"section14\"  v-if=\"items\">\n                <h2><img src=\"//webimage.10x10.co.kr/fixevent/event/2022/anniversary/sale_title.png\" alt=\"\"></h2>\n                <div class=\"cont_wrap\">\n                    <div>\n                        <div class=\"prd_wrap\">\n                            <ul id=\"lyrItemlist\" class=\"item_list\">\n                                <li v-for=\"(item, index) in items\">\n                                    <a href=\"javascript:void(0);\" @click=\"prdDetailPage(item.itemid)\" :class=\"'items' + item.itemid\">\n                                        <div class=\"thumbnail\"><img src=\"https://webimage.10x10.co.kr/fixevent/event/2022/anniversary/tenbyten_2022-thum.jpg/10x10/optimize\" alt=\"\"></div>\n                                        <div class=\"desc\">\n                                            <p class=\"name\">\uC0C1\uD488\uBA85\uC0C1\uD488\uBA85\uC0C1\uD488\uBA85\uC0C1\uD488\uBA85\uC0C1\uD488\uBA85\uC0C1\uD488\uBA85</p>\n                                            <div class=\"price\"><s>15,000</s> 11,000<span class=\"sale\">30%</span></div>\n                                        </div>\n                                    </a>\n                                </li>\n                            </ul>\n                        </div>\n                        <div class=\"ten_mask\">\n                            <a href=\"javascript:void(0);\" @click=\"moreItem()\" class=\"btn_more\">\uB354\uBCF4\uAE30<span class=\"arrow\"></span></a>\n                        </div>\n                    </div>\n                </div>\n            </section>\n        </section>\n    ",
  created: function created() {
    var _this = this;

    _this.$store.dispatch('GET_BANNER_IMAGE', 400); // 굿즈


    _this.$store.dispatch('GET_BANNER_IMAGE', 402); // 텐텐다꾸


    _this.$store.dispatch('GET_BANNER_IMAGE', 403); // 베스트아이템


    _this.$store.dispatch('GET_BANNER_IMAGE', 404); // 첫구매샵


    _this.$store.dispatch('GET_ITEMS'); // 모아보기

  },
  data: function data() {
    return {};
  },
  updated: function updated() {
    var _this = this;

    _this.$nextTick(function () {
      if (_this.itemCount < 20) {
        $(".ten_mask").hide();
      }
    });
  },
  mounted: function mounted() {
    var _this = this;

    _this.$nextTick(function () {
      $('.app_qr').click(function (event) {
        var tabHeight = $('.tab-area').outerHeight();
        event.preventDefault();
        $('html, body').animate({
          scrollTop: $($.attr(this, 'href')).offset().top - tabHeight
        }, 500);
      }); // 더보기 버튼

      $('.btn_more').click(function (e) {
        e.preventDefault();
        $(this).parent().siblings('.prd_wrap').find('ul').addClass('more');
        $(this).parent('.ten_mask').addClass('more');
        $(this).parent().siblings('.prd_wrap').find('li:hidden').slice(0, 8).show();

        if (_this.page * 20 >= _this.itemCount) {
          $(this).parent('.ten_mask').hide();
          $(this).parent().siblings('.prd_wrap').find('ul').css('paddingBottom', '80px');
        }
      });
    });
  },
  computed: {
    goods: function goods() {
      return this.$store.getters.goods;
    },
    appEntryItem: function appEntryItem() {
      return this.$store.getters.appEntryItem;
    },
    diaryStory: function diaryStory() {
      return this.$store.getters.diaryStory;
    },
    bestItem: function bestItem() {
      return this.$store.getters.bestItem;
    },
    firstBuyShop: function firstBuyShop() {
      return this.$store.getters.firstBuyShop;
    },
    items: function items() {
      var items = this.$store.getters.items;
      this.setItemInit('items', items);
      return items;
    },
    itemCount: function itemCount() {
      return this.$store.getters.itemCount;
    },
    page: function page() {
      return this.$store.getters.page;
    }
  },
  methods: {
    movePage: function movePage(link) {
      location.href = link;
    },
    moveForumPage: function moveForumPage() {
      location.href = "/linker/forum.asp?idx=7";
    },
    setItemInit: function setItemInit(target, e) {
      var _this = this;

      var items = e.map(function (i) {
        return i.itemid;
      });

      _this.setItemInfo(target, items, ["image", "name", "price", "sale"]);
    },

    /**
     * 상품 정보 연동
     * @param target 클래스명
     * @param items 상품아이디
     * @param fields 상품 정보 필드명
     */
    setItemInfo: function setItemInfo(target, items, fields) {
      fnApplyItemInfoEach({
        items: items,
        target: target,
        fields: fields,
        unit: "none",
        saleBracket: false
      });
    },
    moreItem: function moreItem() {
      this.$store.dispatch('GET_MORE_ITEMS');
    },
    prdDetailPage: function prdDetailPage(itemid) {
      location.href = "/shopping/category_prd.asp?itemid=" + itemid;
    }
  }
});