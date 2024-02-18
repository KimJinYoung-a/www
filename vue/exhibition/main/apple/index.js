var app = new Vue({
    el: '#app',
    store : store ,
    template: '\
                <div id="contentWrap" class="apple-store">\
                    <div class="main-slider">\
                        <event-list\
                            v-for="(item,index) in slideEventLists"\
                                    :key="index"\
                                    :index="index"\
                                    :titlename="item.titlename"\
                                    :subtitlename="item.subtitlename"\
                                    :imageurl="item.imageurl"\
                                    :eventid="item.eventid"\
                                    :leftBgColor="item.lcolor"\
                                    :rightBgColor="item.rcolor"\
                                    :amplitudeActionName="amplitudeActionName"\
                                    :fontColorText="item.titlecolor"\
                                    :linkUrl="item.linkurl"\
                        >\
                        </event-list>\
                    </div>\
                    <div id="appleNav" class="navigation">\
                        <ul>\
                            <li class="tab-iPad"><a href="#ipad">iPad</a></li>\
                            <li class="tab-macbook"><a href="#macbook">Macbook</a></li>\
                            <li class="tab-airpods"><a href="#airpods">AirPods</a></li>\
                            <li class="tab-imac"><a href="#imac">iMac</a></li>\
                            <li class="tab-iphone"><a href="#iphone">iPhone</a></li>\
                            <li class="tab-watch"><a href="#watch">Watch</a></li>\
                        </ul>\
                        <div class="bar"></div>\
                    </div>\
                    <div class="apple-cont">\
                        <div class="today-rec">\
                            <h3>오늘의 추천</h3>\
                            <ul>\
                                <appletype-itemlist\
                                    v-for="(item,index) in mdPickItemLists"\
                                        :key="index"\
                                        :index="index"\
                                        :itemid="item.itemid"\
                                        :brandname="item.brandname"\
                                        :itemname="item.itemname"\
                                        :addText1="item.addText1"\
                                        :addText2="item.addText2"\
                                        :itemimage="item.itemimage"\
                                        :sellCash="item.sellCash"\
                                        :optionCount="item.optionCount"\
                                        :amplitudeActionName="amplitudeActionName"\
                                >\
                                </appletype-itemlist>\
                            </ul>\
                        </div>\
                        <div class="item-list-wrap">\
                            <template\
                                v-for="idx in numbers"\
                            >\
                                <template\
                                    v-for="(itemlist,i) in partitionItemListsTo(idx)"\
                                >\
                                <div v-bind:id="addClassName(idx)" class="item-list" v-bind:class="addClassName(idx)">\
                                    <div class="title">{{listName(idx)}}</div>\
                                    <ul>\
                                        <item-list\
                                            v-for="(item,index) in itemlist.items"\
                                            :key="index"\
                                            :index="index"\
                                            :itemid="item.itemid"\
                                            :brandname="item.brandname"\
                                            :itemname="item.itemname"\
                                            :addText1="item.addText1"\
                                            :addText2="item.addText2"\
                                            :itemimage="item.itemimage"\
                                            :sellCash="item.sellCash"\
                                            :totalprice="item.totalprice"\
                                            :saleperstring="item.saleperstring"\
                                            :couponperstring="item.couponperstring"\
                                            :optionCount="item.optionCount"\
                                            :amplitudeActionName="amplitudeActionName"\
                                            :evalCount="item.evalCount"\
                                            :favCount="item.favCount"\
                                            :totalPoint="item.totalPoint"\
                                            v-show="index < itemlist.itemShowLimitCount"\
                                        >\
                                        </item-list>\
                                        <template\
                                            v-for="(itemlist,i) in partitionItemListsTo(idx+1)"\
                                        >\
                                            <item-list\
                                                v-for="(item,index) in itemlist.items"\
                                                v-if="index < 4"\
                                                :index="index"\
                                                :itemid="item.itemid"\
                                                :brandname="item.brandname"\
                                                :itemname="item.itemname"\
                                                :addText1="item.addText1"\
                                                :addText2="item.addText2"\
                                                :itemimage="item.itemimage"\
                                                :sellCash="item.sellCash"\
                                                :totalprice="item.totalprice"\
                                                :saleperstring="item.saleperstring"\
                                                :couponperstring="item.couponperstring"\
                                                :optionCount="item.optionCount"\
                                                :amplitudeActionName="amplitudeActionName"\
                                                :evalCount="item.evalCount"\
                                                :favCount="item.favCount"\
                                                :totalPoint="item.totalPoint"\
                                                v-show="index < itemlist.itemShowLimitCount"\
                                            >\
                                            </item-list>\
                                        </template>\
                                    </ul>\
                                    <a @click="moreItem(itemlist.category,idx)" class="btn-more">모든 {{listName(idx)}}{{suffix(idx)}} 추천 액세서리 보기</a>\
                                    <template\
                                        v-for="(itemlist,i) in partitionItemListsTo(idx+1)"\
                                    >\
                                        <div class="acc-view" v-bind:id="\'acc\'+itemlist.category" style="display:none;">\
                                            <div class="title">{{listName(idx+1)}}</div>\
                                            <ul>\
                                                <item-list\
                                                    v-for="(item,index) in itemlist.items"\
                                                    :key="index"\
                                                    :index="index"\
                                                    :itemid="item.itemid"\
                                                    :brandname="item.brandname"\
                                                    :itemname="item.itemname"\
                                                    :addText1="item.addText1"\
                                                    :addText2="item.addText2"\
                                                    :itemimage="item.itemimage"\
                                                    :sellCash="item.sellCash"\
                                                    :totalprice="item.totalprice"\
                                                    :saleperstring="item.saleperstring"\
                                                    :couponperstring="item.couponperstring"\
                                                    :optionCount="item.optionCount"\
                                                    :amplitudeActionName="amplitudeActionName"\
                                                    :evalCount="item.evalCount"\
                                                    :favCount="item.favCount"\
                                                    :totalPoint="item.totalPoint"\
                                                >\
                                                </item-list>\
                                            </ul>\
                                        </div>\
                                    </template>\
                                </div>\
                                </template>\
                            </template>\
                            <div class="cartLyr">\
                                <div class="layer-cont">\
                                    <p id="alertMsg">선택하신 상품을<br />장바구니에 담았습니다.</p>\
                                    <div class="btn-area">\
                                        <a @click="cartLayerClose">쇼핑 계속하기</a>\
                                        <a href="/inipay/shoppingbag.asp">장바구니 가기</a>\
                                    </div>\
                                    <button class="btn-close">&#10005;</button>\
                                </div>\
                            </div>\
                        </div>\
                    </div>\
                </div>\
    ',
    data : function() {
        return {
            itemType : 'SET_PARTITIONLIMITCOUNT',
            amplitudeActionName : "click_apple_",
            moveButtonText : "제품 더보기",
            numbers : [ 1 , 3 , 5 , 7 , 9 , 11 ],
        }
    },
    computed: {
        pageSize : function() {
            return this.$store.state.params.pageSize;
        },
        slideEventLists : function() {
            return this.$store.state.slideLists;
        },
        mdPickItemLists : function() {
            return this.$store.state.mdPickItemLists;
        },
        partitionItemLists : function() {
            return this.$store.getters.getPartitionItemListSorting;
        },
    },
    created : function() {
        // Init
        this.$store.commit('SET_MASTERCODE', '11');
        this.$store.commit('SET_LIMITCOUNT', { itemShowLimitCount : 8 });

        // MD`s Pick
        this.$store.commit('SET_ISPICK', { isPick : '1' });
        this.$store.commit('SET_PAGESIZE', { pageSize : 4 });
        this.$store.commit('SET_CATEGORY', '');
        this.$store.dispatch('GET_ITEMLISTS');
        this.$store.commit('CLEAR_ISPICK');

        this.$store.commit('SET_PAGESIZE', { pageSize : 30 });

        // ipad
        this.$store.commit('SET_CATEGORY', '10');
        this.$store.dispatch('GET_PARTITIONITEMLISTS');

        // ipad 액세서리
        this.$store.commit('SET_CATEGORY', '11');
        this.$store.dispatch('GET_PARTITIONITEMLISTS');

        // macbook
        this.$store.commit('SET_CATEGORY', '20');
        this.$store.dispatch('GET_PARTITIONITEMLISTS');

        // macbook 액세서리
        this.$store.commit('SET_CATEGORY', '21');
        this.$store.dispatch('GET_PARTITIONITEMLISTS');

        // airpods
        this.$store.commit('SET_CATEGORY', '30');
        this.$store.dispatch('GET_PARTITIONITEMLISTS');

        // airpods 액세서리
        this.$store.commit('SET_CATEGORY', '31');
        this.$store.dispatch('GET_PARTITIONITEMLISTS');

        // mac
        this.$store.commit('SET_CATEGORY', '40');
        this.$store.dispatch('GET_PARTITIONITEMLISTS');

        // mac 액세서리
        this.$store.commit('SET_CATEGORY', '41');
        this.$store.dispatch('GET_PARTITIONITEMLISTS');

        // iphone
        this.$store.commit('SET_CATEGORY', '50');
        this.$store.dispatch('GET_PARTITIONITEMLISTS');

        // iphone 액세서리
        this.$store.commit('SET_CATEGORY', '51');
        this.$store.dispatch('GET_PARTITIONITEMLISTS');

        // watch
        this.$store.commit('SET_CATEGORY', '60');
        this.$store.dispatch('GET_PARTITIONITEMLISTS');

        // watch 액세서리
        this.$store.commit('SET_CATEGORY', '61');
        this.$store.dispatch('GET_PARTITIONITEMLISTS');

        // SLIDEEVENT
        this.$store.dispatch('GET_SLIDELISTS');
    },
    methods : {
        cartLayerClose : function() {
            $(".cartLyr").hide();
        },
        moreItem : function(category,idx) {
            let categorys = parseInt(category) + 1;
            $(event.target).hide();
            $("#acc"+categorys).show();

            // 스크롤 이동
            $('html,body').animate({scrollTop: $("#"+this.addClassName(idx)).offset().top},'slow');
            
            // acc 아이템 숨김
            this.$store.commit('SET_PARTITIONLIMITCOUNT', { index : idx , itemShowLimitCount : 0 });

            // 상위 아이템 보여짐
            this.$store.commit('SET_PARTITIONLIMITCOUNT', { index : idx-1 , itemShowLimitCount : 100 });
        },
        partitionItemListsTo : function(index) {
            return this.$store.getters.getPartitionItemListSorting.slice(parseInt(index-1),index);
        },
        listName : function(i) {
            switch (i) {
                case 1 :
                    return 'iPad';
                case 2 : 
                    return 'iPad 추천 액세서리';
                case 3 : 
                    return 'Macbook';
                case 4 : 
                    return 'Macbook 추천 액세서리';
                case 5 : 
                    return 'AirPods';
                case 6 : 
                    return 'AirPods 추천 액세서리';
                case 7 : 
                    return 'iMac';
                case 8 : 
                    return 'iMac 추천 액세서리';
                case 9 : 
                    return 'iPhone';
                case 10 : 
                    return 'iPhone 추천 액세서리';
                case 11 : 
                    return 'Watch';
                case 12 : 
                    return 'Watch 추천 액세서리';
                default : 
                    return ''
            }
        },
        suffix : function(i) {
            if (i == 1 || i == 11) {
                return "와";
            } else {
                return "과";
            }
        },
        addClassName : function(i) {
            switch (i) {
                case 1 :
                    return 'ipad';
                case 3 :
                    return 'macbook';
                case 5 : 
                    return 'airpods';
                case 7 :
                    return 'imac';
                case 9 : 
                    return 'iphone';
                case 11 :
                    return 'watch';
                default : 
                    return ''
            }
        }
    },
})
