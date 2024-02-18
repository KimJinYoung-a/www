"use strict";

Vue.component('MODAL-POSTING-WRITE', {
  template: "\n        <div class=\"modalV20 modal_anniv20\">\n            <div @click=\"close\" class=\"modal_overlay\"></div>\n            <div>\n                <div class=\"anniv_modal_wrap login\" style=\"display:flex;\">\n                    <button @click=\"close\" type=\"button\" class=\"btn_close\"><i class=\"i_close\"></i></button>\n                    <div>\n                        <!-- region \uD504\uB85C\uD544 -->\n                        <div class=\"anniv_modal_header\">\n                            <div class=\"login_profile\">\n                                <div class=\"login_info_area\">\n                                    <div class=\"img\"><img :src=\"userThumbnail\"></div>\n                                    <div class=\"info\">\n                                        <p class=\"txt\">{{userDescription}}</p>\n                                        <p class=\"id\">{{profile.nickName}}</p>\n                                    </div>\n                                </div>\n                            </div>\n                        </div>\n                        <!-- endregion -->\n\n                        <div class=\"forum_tag\">\n                            <div class=\"tag_wrapper\">\n                                <div class=\"tag_item\" v-for=\"(tag, index) in forum_tag\" :class=\"{active : getActiveTag(tag)}\" @click=\"toggleNewTag(tag)\"><span>{{ tag.name }}</span></div>\n                            </div>\n                        </div>\n                        \n                        <div class=\"anniv_modal_conts login\">\n                            <div class=\"txt_enter_container\">\n                                <div class=\"txt_area\">\n                                    <textarea v-model=\"content\" class=\"\" placeholder=\"\uB0B4\uC6A9\uC744 \uC785\uB825\uD574\uC8FC\uC138\uC694.\" maxlength=\"500\"></textarea>\n                                </div>\n                            </div>\n                            <div class=\"count_word\"><span>{{content.length}}</span>/500</div>\n                            \n                            <!-- region \uB9C1\uD06C \uC544\uC774\uD15C -->\n                            <div v-if=\"linkItem.id\" class=\"copy_view\">\n                                <div class=\"link_info\" @click=\"clickLinkType(linkItemType)\">\n                                    <div :class=\"linkThumbnailClass\">\n                                        <img :src=\"linkItem.image\">\n                                    </div>\n                                    <div v-if=\"linkItemType === 'event'\" class=\"link\">\n                                        <p class=\"pro_tit\">\uAE30\uD68D\uC804</p>\n                                        <p class=\"pro_sub\">{{linkItem.title}}</p>\n                                    </div>\n                                    <div v-else-if=\"linkItemType === 'product' || linkItemType === 'brand'\" class=\"link\">\n                                        <p v-if=\"linkItemType === 'product'\" class=\"tit\">{{linkItem.subTitle}}</p>\n                                        <p class=\"sub\">{{linkItem.title}}</p>\n                                    </div>\n                                    <div class=\"link\" v-else-if=\"linkItemType === 'url'\">\n                                        <p class=\"url\">{{linkItem.title}}</p>\n                                    </div>\n                                </div>\n                                <button @click=\"clearLinkItem(true)\" class=\"btn_link_close\">\uB2EB\uAE30</button>\n                            </div>\n                            <!-- endregion -->\n                            \n                            <!-- region \uB9C1\uD06C \uCD94\uAC00 \uC885\uB958 \uD0ED -->\n                            <div v-else class=\"link-list-area\">\n                                <h3>\uB9C1\uD06C \uCD94\uAC00\uD558\uAE30</h3>\n                                <div class=\"link_list\">\n                                    <div @click=\"clickLinkType('product')\" class=\"list_prd\">\n                                        <button type=\"button\" :class=\"['btn_prd', {on:linkItemType==='product'}]\"></button>\n                                        <p>\uC0C1\uD488</p>\n                                    </div>\n                                    <div @click=\"clickLinkType('brand')\" class=\"list_prd\">\n                                        <button type=\"button\" :class=\"['btn_brd', {on:linkItemType==='brand'}]\"></button>\n                                        <p>\uBE0C\uB79C\uB4DC</p>\n                                    </div>\n                                    <div @click=\"clickLinkType('event')\" class=\"list_prd\">\n                                        <button type=\"button\" :class=\"['btn_produce', {on:linkItemType==='event'}]\"></button>\n                                        <p>\uAE30\uD68D\uC804</p>\n                                    </div>\n                                    <div class=\"list_prd\">\n                                        <button @click=\"clickLinkType('url')\" type=\"button\" :class=\"['btn_url', {on:linkItemType==='url'}]\"></button>\n                                        <p>URL</p>\n                                    </div>\n                                </div>\n                            </div>\n                            <!-- endregion -->\n                            \n                        </div>\n                    </div>\n                    <!-- \uAC80\uC0C9\uD558\uAE30 -->\n                    <div v-show=\"showSearchLink\" class=\"right_conts\">\n                        <div class=\"forum_conts\">\n                            \n                            <!--region \uC0C1\uB2E8 \uD0ED-->\n                            <div class=\"menu_list\" v-if=\"linkItemType !== 'url'\">\n                                <li :class=\"[{on:onTab==='search'}]\" @click=\"changeSearchTab('search')\"><a>\uAC80\uC0C9\uD558\uAE30</a></li>\n                                <li :class=\"[{on:onTab==='wish'}]\" @click=\"changeSearchTab('wish')\" v-if=\"linkItemType==='product' || linkItemType==='brand'\"><a>{{linkItemType === 'product' ? '\uB0B4 \uC704\uC2DC' : '\uCC1C\uBE0C\uB79C\uB4DC'}}</a></li>\n                                <li :class=\"[{on:onTab==='basket'}]\" @click=\"changeSearchTab('basket')\" v-if=\"linkItemType==='product'\"><a>\uC7A5\uBC14\uAD6C\uB2C8</a></li>\n                                <li :class=\"[{on:onTab==='order'}]\" @click=\"changeSearchTab('order')\" v-if=\"linkItemType==='product'\"><a>\uC8FC\uBB38\uB0B4\uC5ED</a></li>\n                            </div>\n                            <!-- endregion -->\n                            \n                            <!-- region \uAC80\uC0C9\uBC14 -->\n                            <div id=\"searchbar\" class=\"srchbar_wrap\" v-if=\"linkItemType !== 'url'\">\n                                <div class=\"srchbar input_txt\">\n                                    <span class=\"icon_sh\"></span>\n                                    <input @input=\"updateKeyword\" @keyup.enter=\"keywordSearch\" id=\"searchBar\" \n                                        type=\"search\" title=\"\uAC80\uC0C9\uC5B4 \uC785\uB825\" placeholder=\"\uAC80\uC0C9\uC5B4\uB97C \uC785\uB825\uD574\uC8FC\uC138\uC694\" class=\"srch_input\">\n                                    <button class=\"btn_del\" style=\"display:none;\">\n                                        <i class=\"i_close\"></i>\n                                    </button>\n                                </div>\n                            </div>\n                            <!-- endregion -->\n                            \n                            <!-- \uAC80\uC0C9 \uACB0\uACFC -->\n                            <div :class=\"['forum_conts_box', {link:linkItemType === 'url'}]\" @scroll=\"scroll\">\n                            \n                                <!-- region \uAC80\uC0C9\uC5B4 \uC790\uB3D9 \uC644\uC131 -->\n                                <div v-show=\"keyword && autoKeywords.length > 0 && !doSearch\" class=\"srch_kwd_list\">\n                                    <ul>\n                                        <li v-for=\"(k, index) in autoKeywords\" :key=\"index\">\n                                            <a @click=\"clickAuthKeyword(k.keyword)\" v-html=\"k.tag\"></a>\n                                        </li>\n                                    </ul>\n                                </div>\n                                <!-- endregion -->\n                                \n                                <!-- region \uAC80\uC0C9 \uACB0\uACFC -->\n                                <div v-show=\"doSearch && searchTotalCount > 0\" class=\"forum_search_result\">\n                                    <div class=\"search_total\">\n                                        <div class=\"total_num\"><div>\uCD1D <span>{{numberFormat(searchTotalCount)}}</span>\uAC74</div></div>\n                                        <select @change=\"changeSearchOrder\" v-if=\"onTab === 'search'\">\n                                            <option value=\"best\">\uC778\uAE30\uC21C</option>\n                                            <option value=\"new\">\uC2E0\uADDC\uC21C</option>\n                                        </select>\n                                    </div>\n                                    <div class=\"search_list_area\">\n                                         <MODAL-POSTING-LINK-ITEM v-for=\"result in searchResult\" :key=\"result.id\" :type=\"linkItemType\" :item=\"result\"\n                                            :selectedValue=\"selectedItem.id\" @selectItem=\"selectItem \"/>\n                                    </div>\n                                    <button @click=\"addLink\" type=\"button\" :class=\"['btn_add', {disabled: getSelectItem}]\">\n                                     <span class=\"icon\"></span>\uCD94\uAC00\uD558\uAE30\n                                    </button>\n                                </div>\n                                <!-- endregion -->\n                                \n                                <!-- region \uAC80\uC0C9 \uACB0\uACFC \uC5C6\uC74C -->\n                                <div v-if=\"doSearch && searchTotalCount===0\" class=\"empty_noti_word\">\n                                    <span class=\"icon\"></span>\n                                    <h3>\uC544\uC27D\uAC8C\uB3C4 \uC54C\uB9DE\uC740 \uCEE8\uD150\uCE20\uAC00 \uC5C6\uC5B4\uC694</h3>\n                                    <p>\uB9C8\uC74C\uC5D0 \uB4DC\uB294 \uC0C1\uD488\uC774\uB098 \uCEE8\uD150\uCE20\uB97C<br/>\n                                        \uCC3E\uC544\uBCF4\uC138\uC694 :)</p>\n                                </div>\n                                <!-- endregion -->\n                            \n                                <!-- region \uCD5C\uADFC \uBCF8 \uC0C1\uD488 -->\n                                <div v-if=\"onTab === 'search' && (linkItemType === 'product' || linkItemType === 'brand' || linkItemType === 'event') && !doSearch\" class=\"forum_search_result\">\n                                    <div class=\"search_total\">\n                                        <div class=\"total_num\"><div>\uCD5C\uADFC \uBCF8 {{typeKor}}</div></div>\n                                    </div>\n                                    <div class=\"search_list_area\">\n                                         <MODAL-POSTING-LINK-ITEM v-for=\"item in recentlyViewItems\" :key=\"item.id\" :type=\"linkItemType\" :item=\"item\"\n                                            :selectedValue=\"selectedItem.id\" @selectItem=\"selectItem \"/>\n                                    </div>\n                                    <button @click=\"addLink\" type=\"button\" id=\"recently_add_btn\" :class=\"['btn_add', {disabled: getSelectItem}]\">\n                                        <span class=\"icon\"></span>\uCD94\uAC00\uD558\uAE30\n                                    </button>\n                                </div>\n                                <!-- endregion -->\n                                \n                                <!-- region \uB9C1\uD06C\uCD94\uAC00 -->\n                                <div class=\"copy_link_area\" v-if=\"linkItemType === 'url'\">\n                                    <h3>URL\uC744 \uC785\uB825\uD574\uC8FC\uC138\uC694</h3>\n                                    <div class=\"input\">\n                                        <textarea  id=\"inputContent\" @input=\"inputLinkContent\" placeholder=\"\uC5F0\uACB0\uC774 \uAC00\uB2A5\uD55C URL\uC744 \uC785\uB825\uD574\uC8FC\uC138\uC694\"></textarea>\n                                    </div>\n                                    <div class=\"copy_view\">\n                                        <div class=\"link_info\">\n                                            <div class=\"url_img\"></div>\n                                            <div class=\"link\">{{getLinkContent}}</div>\n                                        </div>\n                                    </div>\n                                    <button @click=\"addLink\" type=\"button\" id=\"link_add_btn\" :class=\"['btn_add', {disabled: !getLinkContent}]\"><span class=\"icon\"></span>\uCD94\uAC00\uD558\uAE30</button>\n                                </div>\n                                <!-- endregion -->\n                                \n                            </div>\n                        </div>\n                    </div>\n                    <!-- \uB4F1\uB85D\uD558\uAE30 \uBC84\uD2BC -->\n                    <button @click=\"register\" type=\"button\" class=\"btn_enter edit\">\uB4F1\uB85D\uD558\uAE30</button>\n\n                    <!-- \uC218\uC815,\uC0AD\uC81C \uBC84\uD2BC -->\n                    <!-- <div class=\"btn_container\">\n                        <button type=\"button\" class=\"btn_enter edit\"><span class=\"icon\"></span>\uC218\uC815\uD558\uAE30</button>\n                        <button type=\"button\" class=\"btn_enter delete\"><span class=\"icon\"></span>\uC0AD\uC81C\uD558\uAE30</button>\n                    </div> -->\n                </div>\n            </div>\n        </div>\n    ",
  data: function data() {
    return {
      content: '',
      // 내용
      postingIndex: null,
      // 포스팅 일련번호(수정용)
      linkItemType: '',
      // 링크 아이템 유형(상품:product, 브랜드:brand, 기획전:event, URL:url)
      linkItem: {},
      // 링크 아이템
      showSearchLink: false,
      // 링크 검색 노출 여부
      onTab: 'search',
      // 활성화된 탭
      doSearch: false,
      // 검색 실행 여부
      recentlyViewItems: [],
      // 최근 본 아이템 리스트
      sortMethod: 'best',
      // 정렬기준
      keyword: '',
      // 검색 키워드
      searchedKeyword: '',
      // 검색 한 키워드
      tempAutoKeywords: [],
      // 자동완성 키워드 리스트
      currentPage: 1,
      // 현재 페이지
      searchTotalCount: 0,
      // 검색 총 결과 수
      searchResult: [],
      // 검색 결과
      searchLoading: false,
      // 검색 중 여부
      searchAll: false,
      // 마지막 페이지까지 전부 불러왔는지 여부
      selectedItem: {},
      // 선택된 아이템
      linkContent: '',
      // 외부링크 내용
      linkerTagList: [],
      forum_tag: [{
        id: 1,
        name: '별다꾸러'
      }, {
        id: 2,
        name: '감성브이로거'
      }, {
        id: 3,
        name: '귀여움수집가'
      }, {
        id: 4,
        name: '엄빠연습생'
      }, {
        id: 5,
        name: '출근러'
      }, {
        id: 6,
        name: '방구석바리스타'
      }, {
        id: 7,
        name: '초보갓생러'
      }, {
        id: 8,
        name: '홈파티'
      }, {
        id: 9,
        name: '어쩌다어른'
      }, {
        id: 10,
        name: '댕냥집사'
      }, {
        id: 11,
        name: '취미수집가'
      }, {
        id: 12,
        name: '남다른나'
      }]
    };
  },
  props: {
    profile: {
      auth: {
        type: String,
        "default": 'N'
      },
      avataNo: {
        type: Number,
        "default": 0
      },
      description: {
        type: String,
        "default": ''
      },
      levelName: {
        type: String,
        "default": ''
      },
      image: {
        type: String,
        "default": ''
      },
      nickName: {
        type: String,
        "default": ''
      }
    },
    forumIndex: {
      type: Number,
      "default": 0
    },
    onlyMyPosting: {
      type: Boolean,
      "default": false
    }
  },
  computed: {
    //region linkTypeNumber 링크 구분 숫자값(API전달용)
    linkTypeNumber: function linkTypeNumber() {
      switch (this.linkItemType) {
        case 'product':
          return 1;

        case 'event':
          return 2;

        case 'brand':
          return 7;

        default:
          return 99;
      }
    },
    //endregion
    //region userThumbnail 유저 썸네일 이미지
    userThumbnail: function userThumbnail() {
      if (this.profile.image != null && this.profile.image !== '') return this.profile.image;else return "//fiximage.10x10.co.kr/web2015/common/img_profile_".concat(this.profile.avataNo < 10 ? '0' : '').concat(this.profile.avataNo, ".png");
    },
    //endregion
    //region userDescription 유저 설명
    userDescription: function userDescription() {
      if (this.profile.auth === 'H' || this.profile.auth === 'G') {
        return this.profile.description;
      } else if (this.profile.levelName !== 'RED' && this.profile.levelName !== 'WHITE') {
        return this.profile.levelName;
      } else {
        return '';
      }
    },
    //endregion
    //region linkThumbnailClass 링크 아이템 이미지 div 클래스
    linkThumbnailClass: function linkThumbnailClass() {
      if (this.linkItem.id) {
        if (this.linkItemType === 'event') return 'pro_img';else if (this.linkItemType === 'url') return 'url_img';else return 'img';
      } else {
        return '';
      }
    },
    //endregion
    //region autoKeywords 자동완성 키워드 리스트
    autoKeywords: function autoKeywords() {
      var autoKeywords = [];

      if (this.tempAutoKeywords != null && this.tempAutoKeywords.length > 0) {
        for (var i = 0; i < this.tempAutoKeywords.length; i++) {
          // 일치하는 문자 <b>태그 처리
          autoKeywords.push({
            keyword: this.tempAutoKeywords[i].keyword,
            tag: this.tempAutoKeywords[i].keyword.replaceAll(this.keyword, "<b>".concat(this.keyword, "</b>"))
          });
        }
      }

      return autoKeywords;
    },
    //endregion
    //region typeKor 유형 한글
    typeKor: function typeKor() {
      switch (this.linkItemType) {
        case 'product':
          return '상품';

        case 'brand':
          return '브랜드';

        case 'event':
          return '기획전/이벤트';
      }
    },
    //endregion
    // linkContent
    getLinkContent: function getLinkContent() {
      return this.linkContent;
    },
    // 추가하기 버튼 클래스
    addLinkClass: function addLinkClass() {
      return this.doSearch;
    },
    // 선택상품 확인
    getSelectItem: function getSelectItem() {
      return this.isEmpty(this.selectedItem);
    }
  },
  methods: {
    //region clickLinkType 링크 추가 유형 클릭
    clickLinkType: function clickLinkType(type) {
      this.sendClickLinkTypeAmplitude(type);
      this.linkItemType = type;
      this.onTab = 'search';
      this.recentlyViewItems = [];
      this.clearSearchResult();
      this.clearKeyword();
      this.getRecentlyViewItems();
      this.showSearchLink = true;
    },
    sendClickLinkTypeAmplitude: function sendClickLinkTypeAmplitude(type) {
      var amplitudeType = type === 'product' ? 'item' : type;
      fnAmplitudeEventMultiPropertiesAction('click_add_link', 'forum_index|type', "".concat(this.forumIndex, "|").concat(amplitudeType));
    },
    //endregion
    //region close 모달 닫기
    close: function close() {
      this.content = '';
      this.clearLinkItem();
      this.showSearchLink = false;
      this.$emit('close');
    },
    //endregion
    //region scroll 스크롤
    scroll: function scroll(e) {
      var modal_height = e.target.scrollHeight; // 모달창 총 Height

      var current_bottom = e.target.offsetHeight + e.target.scrollTop; // 현재 Y위치(하단기준) => 화면높이 + 현재 상단 Y위치
      // 페이지 로딩

      if (!this.searchLoading && !this.searchAll && modal_height - current_bottom < 1200) {
        this.loadMoreSearchItems();
      }
    },
    //endregion
    //region getRecentlyViewItems 최근 본 아이템 가져오기
    getRecentlyViewItems: function getRecentlyViewItems() {
      if (this.linkItemType === 'product') this.getRecentlyViewProducts();else if (this.linkItemType === 'brand') this.getRecentlyViewBrands();else if (this.linkItemType === 'event') this.getRecentlyViewEvents();
    },
    //endregion
    //region addLink 링크 추가
    addLink: function addLink() {
      if (this.isEmpty(this.selectedItem)) {
        this.validationData('addLink');
      } else {
        this.showSearchLink = false;
        this.linkItem = this.selectedItem;
        this.selectedItem = {};
      }
    },
    //endregion
    //region clearLinkItem 링크 아이템 초기화
    clearLinkItem: function clearLinkItem(isConfirm) {
      if (!isConfirm || confirm('링크를 제거하시겠어요?')) {
        this.linkItemType = '';
        this.linkItem = {};
      }
    },
    //endregion
    //region changeSearchTab 활성화 탭 변경
    changeSearchTab: function changeSearchTab(tab) {
      this.onTab = tab;
      this.clearKeyword();
      this.clearSearchResult();
      this.clearSelect();
      this.linkContent = '';

      if (tab === 'wish') {
        this.wishSearch(1);
      } else if (tab === 'basket') {
        this.basketSearch(1);
      } else if (tab === 'order') {
        this.orderSearch(1);
      }
    },
    //endregion
    //region keywordSearch 키워드 검색
    keywordSearch: function keywordSearch() {
      if (this.keyword.trim() === '') return false;else if (this.keyword.length > 100) this.keyword = this.keyword.substr(0, 100);
      this.clearSearchResult();
      this.searchedKeyword = this.keyword;

      switch (this.onTab) {
        case 'search':
          this.search(1);
          break;

        case 'wish':
          this.wishSearch(1);
          break;

        case 'basket':
          this.basketSearch(1);
          break;

        case 'order':
          this.orderSearch(1);
          break;
      }
    },
    //endregion
    //region search 검색탭 검색
    search: function search(currentPage) {
      var url = this.getSearchUrl();
      var data = {
        keyword: this.searchedKeyword,
        sortMethod: this.sortMethod,
        currentPage: currentPage
      };
      this.callSearchApi(url, data);
    },
    //endregion
    //region getSearchUrl Get 검색 Url
    getSearchUrl: function getSearchUrl() {
      var url = '/linker';

      switch (this.linkItemType) {
        case 'product':
          return url + '/products/search';

        case 'brand':
          return url + '/brands/search';

        case 'event':
          return url + '/exhibitions/search';
      }
    },
    //endregion
    //region wishSearch 위시탭 검색
    wishSearch: function wishSearch(currentPage) {
      var data = {
        keyword: this.searchedKeyword,
        page: currentPage
      };
      var url;

      if (this.linkItemType === 'product') {
        url = '/linker/products';
        data.searchType = 'wish';
      } else {
        url = '/linker/brand/wish';
      }

      this.callSearchApi(url, data);
    },
    //endregion
    //region basketSearch 장바구니탭 검색
    basketSearch: function basketSearch(currentPage) {
      var url = '/linker/products';
      var data = {
        keyword: this.searchedKeyword,
        searchType: 'basket',
        page: currentPage
      };
      this.callSearchApi(url, data);
    },
    //endregion
    //region orderSearch 주문내역탭 검색
    orderSearch: function orderSearch(currentPage) {
      var url = '/linker/products';
      var data = {
        keyword: this.searchedKeyword,
        searchType: 'order',
        page: currentPage
      };
      this.callSearchApi(url, data);
    },
    //endregion
    //region loadMoreSearchItems 페이지 더 불러오기
    loadMoreSearchItems: function loadMoreSearchItems() {
      this.currentPage++;

      if (this.doSearch) {
        switch (this.onTab) {
          case 'search':
            this.search(this.currentPage);
            break;

          case 'wish':
            this.wishSearch(this.currentPage);
            break;

          case 'basket':
            this.basketSearch(this.currentPage);
            break;

          case 'order':
            this.orderSearch(this.currentPage);
            break;
        }
      } else {
        this.getRecentlyViewItems();
      }
    },
    //endregion
    //region clickAuthKeyword 자동완성 키워드 클릭
    clickAuthKeyword: function clickAuthKeyword(keyword) {
      this.keyword = keyword;
      $('#searchBar').val(keyword);
      this.keywordSearch();
    },
    //endregion
    //region callSearchApi 검색 실행
    callSearchApi: function callSearchApi(url, data) {
      this.searchLoading = true;
      this.doSearch = true;

      var _this = this;

      var success = function success(data) {
        _this.searchTotalCount = data.totalCount;

        for (var i = 0; i < data.items.length; i++) {
          switch (_this.linkItemType) {
            case 'product':
              _this.searchResult.push(_this.convertSearchProductItem(data.items[i]));

              break;

            case 'brand':
              _this.searchResult.push(_this.convertSearchBrandItem(data.items[i]));

              break;

            case 'event':
              _this.searchResult.push(_this.convertSearchEventItem(data.items[i]));

              break;
          }
        }

        if (data.currentPage === data.lastPage) {
          _this.searchAll = true;
        }

        _this.searchLoading = false;
      };

      this.getFrontApiDataV2('GET', url, data, success);
    },
    //endregion
    //region getDefaultSearchData Get 기본 검색 Data
    getDefaultSearchData: function getDefaultSearchData() {
      return {
        'keyword': this.keyword,
        'sortMethod': 'best',
        'currentPage': 1
      };
    },
    //endregion
    //region convertSearchProductItem 상품검색결과 -> 결과Item
    convertSearchProductItem: function convertSearchProductItem(result) {
      return {
        id: result.productId.toString(),
        image: this.decodeBase64(result.productImage),
        subTitle: result.brandName,
        title: result.productName,
        price: result.productPrice
      };
    },
    //endregion
    //region convertSearchBrandItem 브랜드검색결과 -> 결과Item
    convertSearchBrandItem: function convertSearchBrandItem(result) {
      return {
        id: result.brandId,
        image: this.decodeBase64(result.brandImage),
        title: result.brandName
      };
    },
    //endregion
    //region convertSearchEventItem 브랜드검색결과 -> 결과Item
    convertSearchEventItem: function convertSearchEventItem(result) {
      return {
        id: result.evt_code.toString(),
        image: this.decodeBase64(result.banner_img),
        title: result.evt_name
      };
    },
    //endregion
    //region updateKeyword 키워드 수정
    updateKeyword: function updateKeyword(e) {
      this.keyword = e.target.value.trim();

      if (this.keyword !== '') {
        this.getAuthKeywords();
      }
    },
    //endregion
    //region clearKeyword 키워드 초기화
    clearKeyword: function clearKeyword() {
      this.keyword = '';
      this.searchedKeyword = '';

      if (this.linkItemType === 'url') {
        $('#inputContent').val('');
        this.linkContent = '';
      } else {
        document.getElementById('searchBar').value = '';
      }
    },
    //endregion
    //region clearSearchResult 검색결과 초기화
    clearSearchResult: function clearSearchResult() {
      this.searchTotalCount = 0;
      this.currentPage = 1;
      this.searchResult = [];
      this.doSearch = false;
      this.searchAll = false;
    },
    //endregion
    //region clearSelect 선택아이템 초기화
    clearSelect: function clearSelect() {
      this.selectedItem = {};
    },
    //endregion
    //region selectItem 아이템 선택
    selectItem: function selectItem(item) {
      this.selectedItem = item;
    },
    //endregion
    //region getAuthKeywords 자동완성 키워드리스트 불러오기
    getAuthKeywords: function getAuthKeywords() {
      var _this = this;

      var success = function success(data) {
        _this.tempAutoKeywords = data.keywords;
      };

      this.getFrontApiData('GET', '/search/completeKeywords?keyword=' + this.keyword, null, success);
    },
    //endregion
    //region getRecentlyViewProducts 최근 본 상품 리스트 불러오기
    getRecentlyViewProducts: function getRecentlyViewProducts() {
      var _this = this;

      this.searchLoading = true;

      var success = function success(data) {
        if (data != null) {
          for (var i = 0; i < data.length; i++) {
            _this.recentlyViewItems.push({
              id: data[i].productId.toString(),
              image: _this.decodeBase64(data[i].productImage),
              title: data[i].productName,
              subTitle: data[i].brandName,
              price: data[i].productPrice
            });
          }

          if (data.length === 0) {
            _this.searchAll = true;
          }

          _this.searchLoading = false;
        }
      };

      this.getFrontApiDataV2('GET', "/linker/products/view/recently/page/".concat(this.currentPage), null, success);
    },
    //endregion
    //region getRecentlyViewBrands 최근 본 브랜드 리스트 불러오기
    getRecentlyViewBrands: function getRecentlyViewBrands() {
      var _this = this;

      this.searchLoading = true;

      var success = function success(data) {
        if (data != null) {
          for (var i = 0; i < data.length; i++) {
            _this.recentlyViewItems.push({
              id: data[i].brandId,
              image: _this.decodeBase64(data[i].brandImage),
              title: data[i].brandName
            });
          }

          if (data.length === 0) {
            _this.searchAll = true;
          }

          _this.searchLoading = false;
        }
      };

      this.getFrontApiDataV2('GET', "/linker/brands/view/recently/page/".concat(this.currentPage), null, success);
    },
    //endregion
    //region getRecentlyViewEvents 최근 본 이벤트 리스트 불러오기
    getRecentlyViewEvents: function getRecentlyViewEvents() {
      var _this = this;

      this.searchLoading = true;

      var success = function success(data) {
        if (data != null) {
          for (var i = 0; i < data.length; i++) {
            _this.recentlyViewItems.push({
              id: data[i].eventId.toString(),
              image: _this.decodeBase64(data[i].eventImage),
              title: data[i].eventName
            });
          }

          if (data.length === 0) {
            _this.searchAll = true;
          }

          _this.searchLoading = false;
        }
      };

      this.getFrontApiDataV2('GET', "/linker/events/view/recently/page/".concat(this.currentPage), null, success);
    },
    //endregion
    //region register 등록하기
    register: function register() {
      if (this.isEmpty(this.linkItem) && this.linkItemType !== '') {
        this.validationData('register');
      } else if (this.content === '') {
        alert('내용을 입력해주세요');
      } else if (this.content.trim() !== '' && confirm('작성한 내용을 등록할까요?')) {
        var data = this.createRegisterData();
        var url;

        if (this.postingIndex) {
          url = '/linker/posting/update';
          data.postingIndex = this.postingIndex;
        } else {
          url = '/linker/posting';
          data.forumIndex = this.forumIndex;
        }

        fnAmplitudeEventMultiPropertiesAction('click_upload_posting', 'forum_index', this.forumIndex.toString());
        this.getFrontApiDataV2('POST', url, data, this.successRegister);
      }
    },
    //endregion
    isEmpty: function isEmpty(data) {
      return Object.keys(data).length === 0 && data.constructor === Object;
    },
    // validation 처리
    validationData: function validationData(type) {
      if (type === 'register' && this.isEmpty(this.linkItem) && this.linkItemType !== '') {
        var word = this.validationWord(type);
        alert(word + " 선택 후 '추가하기' 버튼을 눌러주세요");
      } else if (type === 'addLink' && this.linkItemType !== '') {
        var _word = this.validationWord(type);

        alert("추가를 원하는 " + _word + " 선택해주세요.");
      }
    },
    validationWord: function validationWord(type) {
      var _self = this;

      var word = "";

      if (type === 'register') {
        switch (_self.linkItemType) {
          case 'product':
            word = "상품";
            break;

          case 'event':
            word = "기획전/이벤트";
            break;

          case 'brand':
            word = "브랜드";
            break;

          default:
            word = "URL";
            break;
        }
      } else if (type === 'addLink') {
        switch (_self.linkItemType) {
          case 'product':
            word = "상품을";
            break;

          case 'event':
            word = "기획전/이벤트를";
            break;

          case 'brand':
            word = "브랜드를";
            break;

          default:
            word = "URL을";
            break;
        }
      }

      return word;
    },
    //region createRegisterData 등록 api 데이터 생성
    createRegisterData: function createRegisterData() {
      if (this.linkerTagList.length > 0) {
        var joinedTagText = [];
        this.linkerTagList.map(function (tag) {
          joinedTagText.push("#".concat(tag.name));
        });
        this.content = "".concat(joinedTagText.join(' '), '\r\n') + this.content;
      }

      var data = {
        content: this.content
      };

      if (this.linkItem.id) {
        data.linkType = this.linkTypeNumber;
        data.linkTitle = this.linkItem.title;
        data.linkValue = this.linkItem.id;
        data.thumbnailImage = this.linkItem.image;
      }

      return data;
    },
    //endregion
    //region successRegister 등록 성공 callback
    successRegister: function successRegister() {
      location.replace("?idx=".concat(this.forumIndex, "&me=").concat(this.onlyMyPosting ? 1 : 0));
    },
    //endregion
    //region inputLinkContent 외부 링크 입력
    inputLinkContent: function inputLinkContent(e) {
      this.updateLinkContent(e.target.value);
    },
    //endregion
    //region updateLinkContent 외부 링크 내용 update
    updateLinkContent: function updateLinkContent(value) {
      this.linkContent = value;
      this.selectedItem = {
        id: this.linkContent,
        image: 'http://fiximage.10x10.co.kr/web2021/anniv2021/m/icon_url_default.png?v=1.0',
        title: this.linkContent
      };
    },
    //endregion
    //region setModifyPostingData 포스팅 수정 data Set
    setModifyPostingData: function setModifyPostingData(postingIndex) {
      var _this = this;

      var success = function success(data) {
        _this.postingIndex = Number(postingIndex);
        _this.content = data.content;

        if (data.linkValue) {
          switch (data.linkType) {
            case 1:
              _this.linkItemType = 'product';
              break;

            case 2:
              _this.linkItemType = 'event';
              break;

            case 7:
              _this.linkItemType = 'brand';
              break;

            default:
              _this.linkItemType = 'url';
              break;
          }

          _this.linkItem = {
            id: data.linkValue,
            image: data.linkThumbnail,
            title: data.linkTitle,
            subTitle: data.linkDescription
          };
        }
      };

      call_apiV2('GET', "/linker/posting/".concat(postingIndex), null, success, function () {
        alert('존재하지 않는 포스팅입니다.');
      });
    },
    //endregion
    //region changeSearchOrder 검색 정렬 순서 변경
    changeSearchOrder: function changeSearchOrder(e) {
      this.sortMethod = e.target.value;
      this.clearSearchResult();
      this.search(1);
    },
    //endregion
    toggleNewTag: function toggleNewTag(item) {
      var hasItem = false;
      var targetIndex = -1;

      for (var i = 0; i < this.linkerTagList.length; i++) {
        if (item.id === this.linkerTagList[i].id) {
          hasItem = true;
          targetIndex = i;
          break;
        }
      }

      if (hasItem && targetIndex >= 0) {
        this.linkerTagList.splice(targetIndex, 1);
      } else {
        this.linkerTagList.push(item);
      }
    },
    getActiveTag: function getActiveTag(item) {
      for (var i = 0; i < this.linkerTagList.length; i++) {
        if (item.id === this.linkerTagList[i].id) {
          return true;
        }
      }

      return false;
    }
  }
});