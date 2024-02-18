var app = new Vue({
    el: '#app',
    store : store ,
    template: '\
                <section class="xmas-item">\
                    <h3 id="item-box"><img src="//webimage.10x10.co.kr/fixevent/event/2019/xmas2019/tit_item.png" alt="CHRISTMAS ITEM" /></h3>\
                    <SearchFilter></SearchFilter>\
                    <div class="item-box">\
                        <div class="items type-thumb item-240">\
                            <ul>\
                                <item-list\
                                    v-for="(item,index) in itemLists"\
                                    :key="index"\
                                    :itemid="item.itemid"\
                                    :itemimage="item.itemimage"\
                                    :itemname="item.itemname"\
                                    :brandname="item.brandname"\
                                    :totalprice="item.totalprice"\
                                    :saleperstring="item.saleperstring"\
                                    :couponperstring="item.couponperstring"\
                                >\
                                </item-list>\
                            </ul>\
                        </div>\
                        <Pagination\
                            :isFirstEndArrow="isFirstEndArrow"\
                        >\
                        </Pagination>\
                    </div>\
                </section>\
    ',
    data : function() {
        return {
            isFirstEndArrow : false,
        }
    },
    computed: {
        itemLists : function() {
            return this.$store.state.itemLists;
        },
    },
    created : function(){
        this.$store.commit('SET_MASTERCODE', '13');
        this.$store.dispatch('GET_ITEMLISTS');
    },
})
