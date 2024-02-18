Vue.component('MODAL-POSTING-WRITE', {
    template : `
        <div class="modalV20 modal_anniv20">
            <div @click="close" class="modal_overlay"></div>
            <div>
                <div class="anniv_modal_wrap login" style="display:flex;">
                    <button @click="close" type="button" class="btn_close"><i class="i_close"></i></button>
                    <div>
                        <!-- region 프로필 -->
                        <div class="anniv_modal_header">
                            <div class="login_profile">
                                <div class="login_info_area">
                                    <div class="img"><img :src="userThumbnail"></div>
                                    <div class="info">
                                        <p class="txt">{{userDescription}}</p>
                                        <p class="id">{{profile.nickName}}</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- endregion -->

                        <div class="forum_tag">
                            <div class="tag_wrapper">
                                <div class="tag_item" v-for="(tag, index) in forum_tag" :class="{active : getActiveTag(tag)}" @click="toggleNewTag(tag)"><span>{{ tag.name }}</span></div>
                            </div>
                        </div>
                        
                        <div class="anniv_modal_conts login">
                            <div class="txt_enter_container">
                                <div class="txt_area">
                                    <textarea v-model="content" class="" placeholder="내용을 입력해주세요." maxlength="500"></textarea>
                                </div>
                            </div>
                            <div class="count_word"><span>{{content.length}}</span>/500</div>
                            
                            <!-- region 링크 아이템 -->
                            <div v-if="linkItem.id" class="copy_view">
                                <div class="link_info" @click="clickLinkType(linkItemType)">
                                    <div :class="linkThumbnailClass">
                                        <img :src="linkItem.image">
                                    </div>
                                    <div v-if="linkItemType === 'event'" class="link">
                                        <p class="pro_tit">기획전</p>
                                        <p class="pro_sub">{{linkItem.title}}</p>
                                    </div>
                                    <div v-else-if="linkItemType === 'product' || linkItemType === 'brand'" class="link">
                                        <p v-if="linkItemType === 'product'" class="tit">{{linkItem.subTitle}}</p>
                                        <p class="sub">{{linkItem.title}}</p>
                                    </div>
                                    <div class="link" v-else-if="linkItemType === 'url'">
                                        <p class="url">{{linkItem.title}}</p>
                                    </div>
                                </div>
                                <button @click="clearLinkItem(true)" class="btn_link_close">닫기</button>
                            </div>
                            <!-- endregion -->
                            
                            <!-- region 링크 추가 종류 탭 -->
                            <div v-else class="link-list-area">
                                <h3>링크 추가하기</h3>
                                <div class="link_list">
                                    <div @click="clickLinkType('product')" class="list_prd">
                                        <button type="button" :class="['btn_prd', {on:linkItemType==='product'}]"></button>
                                        <p>상품</p>
                                    </div>
                                    <div @click="clickLinkType('brand')" class="list_prd">
                                        <button type="button" :class="['btn_brd', {on:linkItemType==='brand'}]"></button>
                                        <p>브랜드</p>
                                    </div>
                                    <div @click="clickLinkType('event')" class="list_prd">
                                        <button type="button" :class="['btn_produce', {on:linkItemType==='event'}]"></button>
                                        <p>기획전</p>
                                    </div>
                                    <div class="list_prd">
                                        <button @click="clickLinkType('url')" type="button" :class="['btn_url', {on:linkItemType==='url'}]"></button>
                                        <p>URL</p>
                                    </div>
                                </div>
                            </div>
                            <!-- endregion -->
                            
                        </div>
                    </div>
                    <!-- 검색하기 -->
                    <div v-show="showSearchLink" class="right_conts">
                        <div class="forum_conts">
                            
                            <!--region 상단 탭-->
                            <div class="menu_list" v-if="linkItemType !== 'url'">
                                <li :class="[{on:onTab==='search'}]" @click="changeSearchTab('search')"><a>검색하기</a></li>
                                <li :class="[{on:onTab==='wish'}]" @click="changeSearchTab('wish')" v-if="linkItemType==='product' || linkItemType==='brand'"><a>{{linkItemType === 'product' ? '내 위시' : '찜브랜드'}}</a></li>
                                <li :class="[{on:onTab==='basket'}]" @click="changeSearchTab('basket')" v-if="linkItemType==='product'"><a>장바구니</a></li>
                                <li :class="[{on:onTab==='order'}]" @click="changeSearchTab('order')" v-if="linkItemType==='product'"><a>주문내역</a></li>
                            </div>
                            <!-- endregion -->
                            
                            <!-- region 검색바 -->
                            <div id="searchbar" class="srchbar_wrap" v-if="linkItemType !== 'url'">
                                <div class="srchbar input_txt">
                                    <span class="icon_sh"></span>
                                    <input @input="updateKeyword" @keyup.enter="keywordSearch" id="searchBar" 
                                        type="search" title="검색어 입력" placeholder="검색어를 입력해주세요" class="srch_input">
                                    <button class="btn_del" style="display:none;">
                                        <i class="i_close"></i>
                                    </button>
                                </div>
                            </div>
                            <!-- endregion -->
                            
                            <!-- 검색 결과 -->
                            <div :class="['forum_conts_box', {link:linkItemType === 'url'}]" @scroll="scroll">
                            
                                <!-- region 검색어 자동 완성 -->
                                <div v-show="keyword && autoKeywords.length > 0 && !doSearch" class="srch_kwd_list">
                                    <ul>
                                        <li v-for="(k, index) in autoKeywords" :key="index">
                                            <a @click="clickAuthKeyword(k.keyword)" v-html="k.tag"></a>
                                        </li>
                                    </ul>
                                </div>
                                <!-- endregion -->
                                
                                <!-- region 검색 결과 -->
                                <div v-show="doSearch && searchTotalCount > 0" class="forum_search_result">
                                    <div class="search_total">
                                        <div class="total_num"><div>총 <span>{{numberFormat(searchTotalCount)}}</span>건</div></div>
                                        <select @change="changeSearchOrder" v-if="onTab === 'search'">
                                            <option value="best">인기순</option>
                                            <option value="new">신규순</option>
                                        </select>
                                    </div>
                                    <div class="search_list_area">
                                         <MODAL-POSTING-LINK-ITEM v-for="result in searchResult" :key="result.id" :type="linkItemType" :item="result"
                                            :selectedValue="selectedItem.id" @selectItem="selectItem "/>
                                    </div>
                                    <button @click="addLink" type="button" :class="['btn_add', {disabled: getSelectItem}]">
                                     <span class="icon"></span>추가하기
                                    </button>
                                </div>
                                <!-- endregion -->
                                
                                <!-- region 검색 결과 없음 -->
                                <div v-if="doSearch && searchTotalCount===0" class="empty_noti_word">
                                    <span class="icon"></span>
                                    <h3>아쉽게도 알맞은 컨텐츠가 없어요</h3>
                                    <p>마음에 드는 상품이나 컨텐츠를<br/>
                                        찾아보세요 :)</p>
                                </div>
                                <!-- endregion -->
                            
                                <!-- region 최근 본 상품 -->
                                <div v-if="onTab === 'search' && (linkItemType === 'product' || linkItemType === 'brand' || linkItemType === 'event') && !doSearch" class="forum_search_result">
                                    <div class="search_total">
                                        <div class="total_num"><div>최근 본 {{typeKor}}</div></div>
                                    </div>
                                    <div class="search_list_area">
                                         <MODAL-POSTING-LINK-ITEM v-for="item in recentlyViewItems" :key="item.id" :type="linkItemType" :item="item"
                                            :selectedValue="selectedItem.id" @selectItem="selectItem "/>
                                    </div>
                                    <button @click="addLink" type="button" id="recently_add_btn" :class="['btn_add', {disabled: getSelectItem}]">
                                        <span class="icon"></span>추가하기
                                    </button>
                                </div>
                                <!-- endregion -->
                                
                                <!-- region 링크추가 -->
                                <div class="copy_link_area" v-if="linkItemType === 'url'">
                                    <h3>URL을 입력해주세요</h3>
                                    <div class="input">
                                        <textarea  id="inputContent" @input="inputLinkContent" placeholder="연결이 가능한 URL을 입력해주세요"></textarea>
                                    </div>
                                    <div class="copy_view">
                                        <div class="link_info">
                                            <div class="url_img"></div>
                                            <div class="link">{{getLinkContent}}</div>
                                        </div>
                                    </div>
                                    <button @click="addLink" type="button" id="link_add_btn" :class="['btn_add', {disabled: !getLinkContent}]"><span class="icon"></span>추가하기</button>
                                </div>
                                <!-- endregion -->
                                
                            </div>
                        </div>
                    </div>
                    <!-- 등록하기 버튼 -->
                    <button @click="register" type="button" class="btn_enter edit">등록하기</button>

                    <!-- 수정,삭제 버튼 -->
                    <!-- <div class="btn_container">
                        <button type="button" class="btn_enter edit"><span class="icon"></span>수정하기</button>
                        <button type="button" class="btn_enter delete"><span class="icon"></span>삭제하기</button>
                    </div> -->
                </div>
            </div>
        </div>
    `,
    data() {return {
        content : '', // 내용
        postingIndex : null, // 포스팅 일련번호(수정용)

        linkItemType : '', // 링크 아이템 유형(상품:product, 브랜드:brand, 기획전:event, URL:url)
        linkItem : {}, // 링크 아이템

        showSearchLink : false, // 링크 검색 노출 여부
        onTab : 'search', // 활성화된 탭
        doSearch : false, // 검색 실행 여부
        recentlyViewItems : [], // 최근 본 아이템 리스트
        sortMethod : 'best', // 정렬기준

        keyword : '', // 검색 키워드
        searchedKeyword : '', // 검색 한 키워드
        tempAutoKeywords : [], // 자동완성 키워드 리스트
        currentPage : 1, // 현재 페이지
        searchTotalCount : 0, // 검색 총 결과 수
        searchResult : [], // 검색 결과
        searchLoading : false, // 검색 중 여부
        searchAll : false, // 마지막 페이지까지 전부 불러왔는지 여부

        selectedItem : {}, // 선택된 아이템
        linkContent : '', // 외부링크 내용
        linkerTagList : [],
        forum_tag : [
            {
                id: 1,
                name: '별다꾸러'
            },
            {
                id: 2,
                name: '감성브이로거'
            },
            {
                id: 3,
                name: '귀여움수집가'
            },
            {
                id: 4,
                name: '엄빠연습생'
            },
            {
                id: 5,
                name: '출근러'
            },
            {
                id: 6,
                name: '방구석바리스타'
            },
            {
                id: 7,
                name: '초보갓생러'
            },
            {
                id: 8,
                name: '홈파티'
            },
            {
                id: 9,
                name: '어쩌다어른'
            },
            {
                id: 10,
                name: '댕냥집사'
            },
            {
                id: 11,
                name: '취미수집가'
            },
            {
                id: 12,
                name: '남다른나'
            }
        ],
    }},
    props : {
        profile : {
            auth : { type:String, default:'N' },
            avataNo : { type:Number, default:0 },
            description : { type:String, default:'' },
            levelName : { type:String, default:'' },
            image : { type:String, default:'' },
            nickName : { type:String, default:'' }
        },
        forumIndex : { type:Number, default:0 },
        onlyMyPosting: {type:Boolean, default:false}
    },
    computed : {
        //region linkTypeNumber 링크 구분 숫자값(API전달용)
        linkTypeNumber() {
            switch (this.linkItemType) {
                case 'product': return 1;
                case 'event': return 2;
                case 'brand': return 7;
                default: return 99;
            }
        },
        //endregion
        //region userThumbnail 유저 썸네일 이미지
        userThumbnail() {
            if( this.profile.image != null && this.profile.image !== '' )
                return this.profile.image;
            else
                return `//fiximage.10x10.co.kr/web2015/common/img_profile_${this.profile.avataNo < 10 ? '0' : ''}${this.profile.avataNo}.png`;
        },
        //endregion
        //region userDescription 유저 설명
        userDescription() {
            if( this.profile.auth === 'H' || this.profile.auth === 'G' ) {
                return this.profile.description;
            } else if( this.profile.levelName !== 'RED' && this.profile.levelName !== 'WHITE' ) {
                return this.profile.levelName;
            } else {
                return '';
            }
        },
        //endregion
        //region linkThumbnailClass 링크 아이템 이미지 div 클래스
        linkThumbnailClass() {
            if( this.linkItem.id ) {
                if( this.linkItemType === 'event' )
                    return 'pro_img';
                else if( this.linkItemType === 'url' )
                    return 'url_img';
                else
                    return 'img';
            } else {
                return '';
            }
        },
        //endregion
        //region autoKeywords 자동완성 키워드 리스트
        autoKeywords() {
            let autoKeywords = [];
            if( this.tempAutoKeywords != null && this.tempAutoKeywords.length > 0 ) {
                for( let i=0 ; i<this.tempAutoKeywords.length ; i++ ) {
                    // 일치하는 문자 <b>태그 처리
                    autoKeywords.push({
                        keyword : this.tempAutoKeywords[i].keyword,
                        tag : this.tempAutoKeywords[i].keyword.replaceAll(this.keyword, `<b>${this.keyword}</b>`)
                    });
                }
            }
            return autoKeywords;
        },
        //endregion
        //region typeKor 유형 한글
        typeKor() {
            switch (this.linkItemType) {
                case 'product' : return '상품';
                case 'brand' : return '브랜드';
                case 'event' : return '기획전/이벤트';
            }
        },
        //endregion
        // linkContent
        getLinkContent() {
            return this.linkContent;
        },
        // 추가하기 버튼 클래스
        addLinkClass() {
            return this.doSearch;
        },
        // 선택상품 확인
        getSelectItem() {
            return this.isEmpty(this.selectedItem);
        }
    },
    methods : {
        //region clickLinkType 링크 추가 유형 클릭
        clickLinkType(type) {
            this.sendClickLinkTypeAmplitude(type);
            this.linkItemType = type;
            this.onTab = 'search';
            this.recentlyViewItems = [];
            this.clearSearchResult();
            this.clearKeyword();
            this.getRecentlyViewItems();
            this.showSearchLink = true;
        },
        sendClickLinkTypeAmplitude(type) {
            const amplitudeType = type === 'product' ? 'item' : type;
            fnAmplitudeEventMultiPropertiesAction('click_add_link', 'forum_index|type', `${this.forumIndex}|${amplitudeType}`);
        },
        //endregion
        //region close 모달 닫기
        close() {
            this.content = '';
            this.clearLinkItem();
            this.showSearchLink = false;
            this.$emit('close');
        },
        //endregion
        //region scroll 스크롤
        scroll(e) {
            const modal_height = e.target.scrollHeight; // 모달창 총 Height
            const current_bottom = e.target.offsetHeight + e.target.scrollTop; // 현재 Y위치(하단기준) => 화면높이 + 현재 상단 Y위치

            // 페이지 로딩
            if( !this.searchLoading && !this.searchAll && (modal_height - current_bottom) < 1200 ) {
                this.loadMoreSearchItems();
            }
        },
        //endregion
        //region getRecentlyViewItems 최근 본 아이템 가져오기
        getRecentlyViewItems() {
            if( this.linkItemType === 'product' )
                this.getRecentlyViewProducts();
            else if( this.linkItemType === 'brand' )
                this.getRecentlyViewBrands();
            else if( this.linkItemType === 'event' )
                this.getRecentlyViewEvents();
        },
        //endregion
        //region addLink 링크 추가
        addLink() {
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
        clearLinkItem(isConfirm) {
            if( !isConfirm || confirm('링크를 제거하시겠어요?') ) {
                this.linkItemType = '';
                this.linkItem = {};
            }
        },
        //endregion
        //region changeSearchTab 활성화 탭 변경
        changeSearchTab(tab) {
            this.onTab = tab;
            this.clearKeyword();
            this.clearSearchResult();
            this.clearSelect();
            this.linkContent = '';

            if( tab === 'wish' ) {
                this.wishSearch(1);
            } else if( tab === 'basket' ) {
                this.basketSearch(1);
            } else if( tab === 'order' ) {
                this.orderSearch(1);
            }
        },
        //endregion
        //region keywordSearch 키워드 검색
        keywordSearch() {
            if( this.keyword.trim() === '' )
                return false;
            else if( this.keyword.length > 100 )
                this.keyword = this.keyword.substr(0, 100);

            this.clearSearchResult();
            this.searchedKeyword = this.keyword;

            switch(this.onTab) {
                case 'search': this.search(1); break;
                case 'wish': this.wishSearch(1); break;
                case 'basket': this.basketSearch(1); break;
                case 'order': this.orderSearch(1); break;
            }
        },
        //endregion
        //region search 검색탭 검색
        search(currentPage) {
            const url = this.getSearchUrl();
            const data = {
                keyword : this.searchedKeyword,
                sortMethod : this.sortMethod,
                currentPage : currentPage
            }
            this.callSearchApi(url, data);
        },
        //endregion
        //region getSearchUrl Get 검색 Url
        getSearchUrl() {
            let url = '/linker';
            switch(this.linkItemType) {
                case 'product' : return url + '/products/search';
                case 'brand' : return url + '/brands/search';
                case 'event' : return url + '/exhibitions/search';
            }
        },
        //endregion
        //region wishSearch 위시탭 검색
        wishSearch(currentPage) {
            let data = {
                keyword : this.searchedKeyword,
                page : currentPage
            };
            let url;
            if( this.linkItemType === 'product' ) {
                url = '/linker/products';
                data.searchType = 'wish';
            } else {
                url = '/linker/brand/wish'
            }
            this.callSearchApi(url, data);
        },
        //endregion
        //region basketSearch 장바구니탭 검색
        basketSearch(currentPage) {
            const url = '/linker/products';
            const data = {
                keyword : this.searchedKeyword,
                searchType : 'basket',
                page : currentPage
            }
            this.callSearchApi(url, data);
        },
        //endregion
        //region orderSearch 주문내역탭 검색
        orderSearch(currentPage) {
            const url = '/linker/products';
            const data = {
                keyword : this.searchedKeyword,
                searchType : 'order',
                page : currentPage
            }
            this.callSearchApi(url, data);
        },
        //endregion
        //region loadMoreSearchItems 페이지 더 불러오기
        loadMoreSearchItems() {
            this.currentPage++;

            if( this.doSearch ) {
                switch(this.onTab) {
                    case 'search': this.search(this.currentPage); break;
                    case 'wish': this.wishSearch(this.currentPage); break;
                    case 'basket': this.basketSearch(this.currentPage); break;
                    case 'order': this.orderSearch(this.currentPage); break;
                }
            } else {
                this.getRecentlyViewItems();
            }
        },
        //endregion
        //region clickAuthKeyword 자동완성 키워드 클릭
        clickAuthKeyword(keyword) {
            this.keyword = keyword;
            $('#searchBar').val(keyword);
            this.keywordSearch();
        },
        //endregion
        //region callSearchApi 검색 실행
        callSearchApi(url, data) {
            this.searchLoading = true;
            this.doSearch = true;

            const _this = this;
            const success = function(data) {
                _this.searchTotalCount = data.totalCount;

                for( let i=0 ; i<data.items.length ; i++ ) {
                    switch(_this.linkItemType) {
                        case 'product': _this.searchResult.push(_this.convertSearchProductItem(data.items[i])); break;
                        case 'brand': _this.searchResult.push(_this.convertSearchBrandItem(data.items[i])); break;
                        case 'event': _this.searchResult.push(_this.convertSearchEventItem(data.items[i])); break;
                    }
                }

                if( data.currentPage === data.lastPage ) {
                    _this.searchAll = true;
                }
                _this.searchLoading = false;
            }
            this.getFrontApiDataV2('GET', url, data, success);
        },
        //endregion
        //region getDefaultSearchData Get 기본 검색 Data
        getDefaultSearchData() {
            return {
                'keyword' : this.keyword,
                'sortMethod' : 'best',
                'currentPage' : 1
            };
        },
        //endregion
        //region convertSearchProductItem 상품검색결과 -> 결과Item
        convertSearchProductItem(result) {
            return {
                id : result.productId.toString(),
                image: this.decodeBase64(result.productImage),
                subTitle: result.brandName,
                title: result.productName,
                price: result.productPrice
            }
        },
        //endregion
        //region convertSearchBrandItem 브랜드검색결과 -> 결과Item
        convertSearchBrandItem(result) {
            return {
                id : result.brandId,
                image: this.decodeBase64(result.brandImage),
                title: result.brandName
            }
        },
        //endregion
        //region convertSearchEventItem 브랜드검색결과 -> 결과Item
        convertSearchEventItem(result) {
            return {
                id : result.evt_code.toString(),
                image: this.decodeBase64(result.banner_img),
                title: result.evt_name
            }
        },
        //endregion
        //region updateKeyword 키워드 수정
        updateKeyword(e) {
            this.keyword = e.target.value.trim();
            if( this.keyword !== '' ) {
                this.getAuthKeywords();
            }
        },
        //endregion
        //region clearKeyword 키워드 초기화
        clearKeyword() {
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
        clearSearchResult() {
            this.searchTotalCount = 0;
            this.currentPage = 1;
            this.searchResult = [];
            this.doSearch = false;
            this.searchAll = false;
        },
        //endregion
        //region clearSelect 선택아이템 초기화
        clearSelect() {
            this.selectedItem = {}
        },
        //endregion
        //region selectItem 아이템 선택
        selectItem(item) {
            this.selectedItem = item;
        },
        //endregion
        //region getAuthKeywords 자동완성 키워드리스트 불러오기
        getAuthKeywords() {
            const _this = this;
            const success = function(data) {
                _this.tempAutoKeywords = data.keywords;
            }
            this.getFrontApiData('GET', '/search/completeKeywords?keyword=' + this.keyword, null, success);
        },
        //endregion
        //region getRecentlyViewProducts 최근 본 상품 리스트 불러오기
        getRecentlyViewProducts() {
            const _this = this;
            this.searchLoading = true;
            const success = function(data) {
                if( data != null ) {
                    for( let i=0 ; i<data.length ; i++ ) {
                        _this.recentlyViewItems.push({
                            id : data[i].productId.toString(),
                            image : _this.decodeBase64(data[i].productImage),
                            title : data[i].productName,
                            subTitle : data[i].brandName,
                            price : data[i].productPrice
                        });
                    }

                    if( data.length === 0 ) {
                        _this.searchAll = true;
                    }
                    _this.searchLoading = false;
                }
            }
            this.getFrontApiDataV2('GET', `/linker/products/view/recently/page/${this.currentPage}`, null, success);
        },
        //endregion
        //region getRecentlyViewBrands 최근 본 브랜드 리스트 불러오기
        getRecentlyViewBrands() {
            const _this = this;
            this.searchLoading = true;
            const success = function(data) {
                if( data != null ) {
                    for( let i=0 ; i<data.length ; i++ ) {
                        _this.recentlyViewItems.push({
                            id : data[i].brandId,
                            image : _this.decodeBase64(data[i].brandImage),
                            title : data[i].brandName
                        });
                    }

                    if( data.length === 0 ) {
                        _this.searchAll = true;
                    }
                    _this.searchLoading = false;
                }
            }
            this.getFrontApiDataV2('GET', `/linker/brands/view/recently/page/${this.currentPage}`, null, success);
        },
        //endregion
        //region getRecentlyViewEvents 최근 본 이벤트 리스트 불러오기
        getRecentlyViewEvents() {
            const _this = this;
            this.searchLoading = true;
            const success = function(data) {
                if( data != null ) {
                    for( let i=0 ; i<data.length ; i++ ) {
                        _this.recentlyViewItems.push({
                            id : data[i].eventId.toString(),
                            image : _this.decodeBase64(data[i].eventImage),
                            title : data[i].eventName
                        });
                    }

                    if( data.length === 0 ) {
                        _this.searchAll = true;
                    }
                    _this.searchLoading = false;
                }
            }
            this.getFrontApiDataV2('GET', `/linker/events/view/recently/page/${this.currentPage}`, null, success);
        },
        //endregion
        //region register 등록하기
        register() {            
            if (this.isEmpty(this.linkItem) && this.linkItemType !== '') {
                this.validationData('register');
            } else if (this.content === '') {
                alert('내용을 입력해주세요');
            } else if( this.content.trim() !== '' && confirm('작성한 내용을 등록할까요?') ) {
                const data = this.createRegisterData();
                let url;
                if( this.postingIndex ) {
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
        isEmpty(data) {
            return Object.keys(data).length === 0 && data.constructor === Object
        },
        // validation 처리
        validationData(type) {
            if ( type === 'register' && this.isEmpty(this.linkItem) && this.linkItemType !== '') {
                let word = this.validationWord(type);
                alert(word + " 선택 후 '추가하기' 버튼을 눌러주세요");
            } else if ( type === 'addLink' && this.linkItemType !== '') {
                let word = this.validationWord(type);
                alert("추가를 원하는 " + word + " 선택해주세요.");
            }
        },
        validationWord(type) {
            const _self = this;
            let word = "";
            if (type === 'register') {
                switch(_self.linkItemType) {
                    case 'product': word = "상품"; break;
                    case 'event': word = "기획전/이벤트"; break;
                    case 'brand': word = "브랜드"; break;
                    default: word = "URL"; break;
                }
            } else if (type === 'addLink') {
                switch(_self.linkItemType) {
                    case 'product': word = "상품을"; break;
                    case 'event': word = "기획전/이벤트를"; break;
                    case 'brand': word = "브랜드를"; break;
                    default: word = "URL을"; break;
                }
            }
            return word;
        },
        //region createRegisterData 등록 api 데이터 생성
        createRegisterData() {
            if (this.linkerTagList.length > 0) {
                let joinedTagText = [];
                this.linkerTagList.map(tag => {
                    joinedTagText.push(`#${tag.name}`);
                });

                this.content = `${joinedTagText.join(' ')}${'\r\n'}` + this.content;
                
            }
            
            const data = {
                content : this.content
            };
            if( this.linkItem.id ) {
                data.linkType = this.linkTypeNumber;
                data.linkTitle = this.linkItem.title;
                data.linkValue = this.linkItem.id;
                data.thumbnailImage = this.linkItem.image;
            }
            return data;
        },
        //endregion
        //region successRegister 등록 성공 callback
        successRegister() {
            location.replace(`?idx=${this.forumIndex}&me=${this.onlyMyPosting ? 1 : 0}`);
        },
        //endregion
        //region inputLinkContent 외부 링크 입력
        inputLinkContent(e) {
            this.updateLinkContent(e.target.value);
        },
        //endregion
        //region updateLinkContent 외부 링크 내용 update
        updateLinkContent(value) {
            this.linkContent = value;

            this.selectedItem = {
                id : this.linkContent,
                image : 'http://fiximage.10x10.co.kr/web2021/anniv2021/m/icon_url_default.png?v=1.0',
                title : this.linkContent
            };
        },
        //endregion
        //region setModifyPostingData 포스팅 수정 data Set
        setModifyPostingData(postingIndex) {
            const _this = this;
            const success = function(data) {
                _this.postingIndex = Number(postingIndex);
                _this.content = data.content;
                if( data.linkValue ) {
                    switch(data.linkType) {
                        case 1: _this.linkItemType = 'product'; break;
                        case 2: _this.linkItemType = 'event'; break;
                        case 7: _this.linkItemType = 'brand'; break;
                        default: _this.linkItemType = 'url'; break;
                    }
                    _this.linkItem = {
                        id : data.linkValue,
                        image : data.linkThumbnail,
                        title : data.linkTitle,
                        subTitle : data.linkDescription
                    }
                }
            }
            call_apiV2('GET', `/linker/posting/${postingIndex}`, null, success,
                function(){alert('존재하지 않는 포스팅입니다.');})
        },
        //endregion
        //region changeSearchOrder 검색 정렬 순서 변경
        changeSearchOrder(e) {
            this.sortMethod = e.target.value;
            this.clearSearchResult();
            this.search(1);
        },
        //endregion
        toggleNewTag(item) {
            let hasItem = false;
            let targetIndex = -1;
            for (let i = 0 ; i < this.linkerTagList.length; i++) {
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
        getActiveTag(item) {
            for (let i = 0 ; i < this.linkerTagList.length; i++) {
                if (item.id === this.linkerTagList[i].id) {
                    return true;
                }
            }
            return false;
        }
    }

});