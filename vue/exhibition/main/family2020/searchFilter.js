Vue.component('SearchFilter',{
    template : '\
                <div class="type">\
                    <ul>\
                        <li>\
                            <input type="radio" value="" name="category" v-model="category" id="typeAll"/>\
                            <label for="typeAll"><span>All</span><strong>전체상품</strong></label>\
                        </li>\
                        <li>\
                            <input type="radio" value=21 name="category" v-model="category" id="type1"/>\
                            <label for="type1"><span>Carnations</span><strong>카네이션</strong></label>\
                        </li>\
                        <li>\
                            <input type="radio" value=22 name="category" v-model="category" id="type2"/>\
                            <label for="type2"><span>Pocket</span><strong>용돈</strong></label>\
                        </li>\
                        <li>\
                            <input type="radio" value=23 name="category" v-model="category" id="type3"/>\
                            <label for="type3"><span>Parents</span><strong>효도선물</strong></label>\
                        </li>\
                        <li>\
                            <input type="radio" value=11 name="category" v-model="category" id="type4"/>\
                            <label for="type4"><span>Toys</span><strong>장난감</strong></label>\
                        </li>\
                        <li>\
                            <input type="radio" value=12 name="category" v-model="category" id="type5"/>\
                            <label for="type5"><span>Devices</span><strong>전자기기</strong></label>\
                        </li>\
                        <li>\
                            <input type="radio" value=32 name="category" v-model="category" id="type6"/>\
                            <label for="type6"><span>Rose day</span><strong>로즈데이</strong></label>\
                        </li>\
                        <li>\
                            <input type="radio" value=33 name="category" v-model="category" id="type7"/>\
                            <label for="type7"><span>20&apos;s</span><strong>스무살</strong></label>\
                        </li>\
                    </ul>\
                </div>\
    ',
    props : {
        navMoveTop : {
            type : String,
            default : "item-box"
        }
    },
    computed: {
        category : {
            get : function() {
                return this.$store.state.params.category;
            },
            set : function(value) {
                var offset = $("."+this.navMoveTop).offset();
                $('html, body').animate({scrollTop : offset.top}, 400);

                this.$store.commit('SET_CATEGORY', value);
                this.$store.dispatch('GET_ITEMLISTS'); // Search Action
            }
        },
    },
})