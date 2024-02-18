var app = new Vue({
    el: '#itemlist',
    store : store ,
    template: `
        <section class="tab-wrap">
            <h3><img src="//webimage.10x10.co.kr/fixevent/event/2021/family/tit_tab.png" alt="5월의 선물 키워드"></h3>
            <SearchFilter></SearchFilter>        
            
            <div class="tab-cont">
                <p class="keyword" style="display:none;"><img src="//webimage.10x10.co.kr/fixevent/event/2021/family/txt_kwd_01.png" alt="" class="vTop"></p>
                <div class="items type-thumb item-240">
                    <ul>
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
                            :amplitudeActionName="amplitudeActionName"
                            :evalCount="item.evalCount"
                            :favCount="item.favCount"
                            :totalPoint="item.totalPoint"
                        ></item-list>
                    </ul>
                </div>
                
                <Pagination :isFirstEndArrow="isFirstEndArrow" :pageMoveTop="pageMoveTop" />
            </div>
        </section>
    `,
    data : function() {
        return {
            isFirstEndArrow : false,
            amplitudeActionName : "click_family2020_",
            pageMoveTop : "tab-wrap",
            navMoveTop : "category-wrap",
        }
    },
    computed: {
        itemLists : function() {
            return this.$store.state.itemLists;
        },
    },
    created : function(){
        this.$store.commit('SET_MASTERCODE', '20'); // test 12 , live 20
        this.$store.commit('SET_CATEGORY', '');
        this.$store.dispatch('GET_ITEMLISTS');
    },
})