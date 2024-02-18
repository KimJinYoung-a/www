var app = new Vue({
    el: '#app',
    store : store ,
    template: `
                <section class="xmas-item">
                    <h3>크리스마스아이템</h3>
                    <div class="inner">
                        <SearchFilter></SearchFilter>
                        <div class="prd-list">
                            <item-list
                                v-for="(item,index) in itemLists"
                                :key="index"
                                :index="index"
                                :itemid="item.itemid"
                                :itemimage="item.itemimage"
                                :itemname="item.itemname"
                                :brandname="item.brandname"
                                :totalprice="item.totalprice"
                                :saleperstring="item.saleperstring"
                                :couponperstring="item.couponperstring"
                                :totalsaleper="item.totalsaleper"
                                :evalPoint="item.evalPoint"
                                :evalCount="item.evalCount"
                            >
                            </item-list>
                        </div>
                        <Pagination
                            :isFirstEndArrow="isFirstEndArrow"
                        >
                        </Pagination>
                    </div>
                </section>
    `,
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
        this.$store.commit('SET_MASTERCODE', '17');
        this.$store.dispatch('GET_ITEMLISTS');
    },
})
