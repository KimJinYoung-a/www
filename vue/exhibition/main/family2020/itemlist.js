var app = new Vue({
    el: '#itemlist',
    store : store ,
    template: '\
                <section class="category-wrap">\
                    <h3><img src="//webimage.10x10.co.kr/fixevent/event/2020/family2020/tit_category.jpg" alt="5월의 선물 키워드"></h3>\
                    <SearchFilter\
                        :navMoveTop="navMoveTop"\
                    >\
                    </SearchFilter>\
                    <div class="item-box">\
                        <div class="items type-thumb item-240">\
                            <ul>\
                                <item-list\
                                    v-for="(item,index) in itemLists"\
                                    :key="index"\
                                    :index="index"\
                                    :itemid="item.itemid"\
                                    :itemimage="item.itemimage"\
                                    :itemname="item.itemname"\
                                    :brandname="item.brandname"\
                                    :totalprice="item.totalprice"\
                                    :saleperstring="item.saleperstring"\
                                    :couponperstring="item.couponperstring"\
                                    :amplitudeActionName="amplitudeActionName"\
                                    :evalCount="item.evalCount"\
                                    :favCount="item.favCount"\
                                    :totalPoint="item.totalPoint"\
                                >\
                                </item-list>\
                            </ul>\
                        </div>\
                        <Pagination\
                            :isFirstEndArrow="isFirstEndArrow"\
                            :pageMoveTop="pageMoveTop"\
                        >\
                        </Pagination>\
                    </div>\
                </section>\
    ',
    data : function() {
        return {
            isFirstEndArrow : false,
            amplitudeActionName : "click_family2020_",
            pageMoveTop : "item-box",
            navMoveTop : "category-wrap",
        }
    },
    computed: {
        itemLists : function() {
            return this.$store.state.itemLists;
        },
    },
    created : function(){
        this.$store.commit('SET_MASTERCODE', '14'); // test 11 , live 14
        this.$store.dispatch('GET_ITEMLISTS');
    },
})