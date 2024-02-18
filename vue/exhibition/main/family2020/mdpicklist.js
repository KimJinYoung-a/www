var app = new Vue({
    el: '#mdpicklist',
    store : store ,
    template: '\
                <section class="md-pick">\
                    <h3><img src="//webimage.10x10.co.kr/fixevent/event/2020/family2020/tit_md_pick.png" alt="MD가 추천하는 선물"></h3>\
                    <div class="items type-thumb">\
                        <div class="item-slider">\
                            <slideitem-list\
                                v-for="(item,index) in mdPickItemLists"\
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
                                :optionCode="item.optionCode"\
                            >\
                            </slideitem-list>\
                        </div>\
                    </div>\
                </section>\
            ',
    data : function() {
        return {
            amplitudeActionName : "click_family2020_mdpick_item",
        }
    },
    computed: {
        pageSize : function() {
            return this.$store.state.params.pageSize;
        },
        mdPickItemLists : function() {
            return this.$store.state.mdPickItemLists;
        },
    },
    created : function() {
        // mastercode init
        this.$store.commit('SET_MASTERCODE', '14'); // test 11 , live 14
        this.$store.commit('SET_PAGESIZE', { pageSize : 20 });

        // MD`s Pick
        this.$store.commit('SET_ISPICK', { isPick : '1' });
        this.$store.commit('SET_CATEGORY', '');
        this.$store.dispatch('GET_ITEMLISTS');
        this.$store.commit('CLEAR_ISPICK');
    },
    mounted : function() {
        this.$nextTick(function() {
			setTimeout(function() {
                $(".family2020 .md-pick .item-slider").slick({
                    slidesToShow: 4,
                    slidesToScroll: 4,
                    variableWidth: true,
                    infinite: false
                });
			},500);
		});
    }
})
