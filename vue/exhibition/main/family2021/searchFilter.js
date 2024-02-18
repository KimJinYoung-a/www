Vue.component('SearchFilter',{
    template : `
        <div class="tab-nav">
            <ul class="tab-list">
                <li>
                    <input type="radio" value="" name="category" v-model="category" id="typeAll" checked />
                    <label for="typeAll">전체상품</label>
                </li>
                <li>
                    <input type="radio" value=20 name="category" v-model="category" id="type1" />
                    <label for="type1">어버이날</label>
                </li>
                <li>
                    <input type="radio" value=70 name="category" v-model="category" id="type2" />
                    <label for="type2">어린이날</label>
                </li>
                <li>
                    <input type="radio" value=50 name="category" v-model="category" id="type3" />
                    <label for="type3">스승의날</label>
                </li>
                <li>
                    <input type="radio" value=90 name="category" v-model="category" id="type4" />
                    <label for="type4">로즈데이</label>
                </li>
                <li>
                    <input type="radio" value=110 name="category" v-model="category" id="type5" />
                    <label for="type5">성년의날</label>
                </li>
            </ul>
        </div>
    `,
    props : {
        navMoveTop : {
            type : String,
            default : "tab-wrap"
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
        }
    }
});