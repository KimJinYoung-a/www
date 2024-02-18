Vue.component('SearchFilter',{
    template : '\
                <div class="type">\
                    <ul>\
                        <li>\
                            <input type="radio" value="-1" name="category" v-model="category" id="typeAll"/>\
                            <label for="typeAll"><span>All</span><strong>전체상품</strong></label>\
                        </li>\
                        <li>\
                            <input type="radio" value=10 name="category" v-model="category" id="type1" />\
                            <label for="type1"><span>Tree</span><strong>트리</strong></label>\
                        </li>\
                        <li>\
                            <input type="radio" value=20 name="category" v-model="category" id="type2" />\
                            <label for="type2"><span>Lighting</span><strong>조명</strong></label>\
                        </li>\
                        <li>\
                            <input type="radio" value=30 name="category" v-model="category" id="type3" />\
                            <label for="type3"><span>Wreath</span><strong>리스&middot;가랜드</strong></label>\
                        </li>\
                        <li>\
                            <input type="radio" value=40 name="category" v-model="category" id="type4" />\
                            <label for="type4"><span>Ornament</span><strong>오너먼트</strong></label>\
                        </li>\
                        <li>\
                            <input type="radio" value=50 name="category" v-model="category" id="type5" />\
                            <label for="type5"><span>Candle</span><strong>캔들&middot;디퓨저</strong></label>\
                        </li>\
                        <li>\
                            <input type="radio" value=60 name="category" v-model="category" id="type6" />\
                            <label for="type6"><span>X-mas gift</span><strong>선물</strong></label>\
                        </li>\
                        <li>\
                            <input type="radio" value=70 name="category" v-model="category" id="type7" />\
                            <label for="type7"><span>X-mas card</span><strong>카드</strong></label>\
                        </li>\
                    </ul>\
                </div>\
    ',
    computed: {
        category : {
            get : function() {
                return this.$store.state.params.category;
            },
            set : function(value) {
                this.$store.commit('SET_CATEGORY', value);
                this.$store.dispatch('GET_ITEMLISTS'); // Search Action
            }
        },
    },
})