/**
 * 카테고리 필터 TR
 */
Vue.component('CATEGORY-FILTER', {
    template : `
        <tr>
            <th>
                <input type="checkbox" class="check" :id="'cate' + category_code" :value="category_code" 
                    v-model="selected_categories" @click="check_category"/> 
                <a @click="click_category(category_code)">{{category_name}}</a> 
                <span class="fn">({{number_format(item_count)}})</span>
            </th>
            <td>
                <div v-for="categories in divided_low_categories" class="categoryV15">
                    <span v-for="category in categories">
                        <input type="checkbox" class="check" :id="'cate' + category.category_code" 
                            :value="category.category_code" v-model="selected_categories" @click="check_category"/>
                        <a @click="click_category(category.category_code)">
                            {{category.category_name}} ({{number_format(category.item_count)}})
                        </a>
                    </span>
                    <!--
                    <div class="depthWrapV15">
                        <div class="depth">
                            <a href="#">꽃다발/꽃바구니 (38)</a>
                            <a href="#">꽃화병/어레인지먼트 (38)</a>
                            <a href="#">공기정화식물 (38)</a>
                            <a href="#">미니녹색식물 (38)</a>
                            <a href="#">새싹키우기 (38)</a>
                            <a href="#">수경재배식물 (38)</a>
                            <a href="#">꽃다발 (38)</a>
                            <a href="#">골드플라워 (38)</a>
                        </div>
                    </div>
                    -->
                </div>
            </td>
        </tr>
    `,
    mounted() {
        const _this = this;
        // 1dpeth 선택되었을 때 하위 카테고리 모두 선택
        if( this.parameter_categories.findIndex(c => Number(c) === this.category_code) > -1 ) {
            this.selected_categories.push(this.category_code);
            this.check_all_low_categories();
        } else {
            this.parameter_categories.forEach(c => {
                if( Number(c.substr(0, 3)) === _this.category_code ) {
                    _this.selected_categories.push(Number(c));
                }
            });
        }
    },
    data() {return {
        selected_categories : [], // 선택된 카테고리코드 리스트
    }},
    props: {
        category_code : { type : Number, default : 0 }, // 카테고리 코드
        category_name : { type : String, default : '' }, // 카테고리 명
        item_count : { type : Number, default : 0 }, // 상품 수
        low_categories : { // 하위 카테고리 리스트
            category_code : { type : Number, default : 0 }, // 카테고리 코드
            category_name : { type : String, default : '' }, // 카테고리 명
            item_count : { type : Number, default : 0 }, // 상품 수
        },
        parameter_categories : { type : Array, default : function() {return [];} }, // 활성화된 카테고리 파라미터
    },
    computed : {
        // 4개씩 그룹
        divided_low_categories() {
            if( this.low_categories == null || this.low_categories.length === 0 )
                return [];

            const divided_low_categories = [];
            for( let i=0 ; i<Math.ceil(this.low_categories.length/4) ; i++ ) {
                divided_low_categories.push(this.low_categories.slice(i*4, i*4 + 4));
            }
            return divided_low_categories;
        },
        // 부모 컴포넌트에 올려줄 선택 카테고리 리스트
        return_categories() {
            if( this.selected_categories.findIndex(c => c === this.category_code) > -1 ) {
                return [this.category_code];
            } else {
                return this.selected_categories;
            }
        }
    },
    methods : {
        // 카테고리 클릭
        click_category(code) {
            this.$emit('click_category', code);
        },
        // check 카테고리
        check_category(e) {
            const category_code = Number(e.target.value);

            // 1Depth 클릭 시
            if( category_code === this.category_code ) {
                if( e.target.checked ) { // 체크
                    // 하위 카테고리 모두 체크
                    this.check_all_low_categories();
                } else { // 체크X
                    // 하위 카테고리 모두 체크X
                    this.selected_categories = [];
                }

            // 2Depth 클릭 시
            } else {
                if( e.target.checked ) { // 체크
                    // click이벤트가 model연동보다 빠르기때문에 크기 비교시 현재 하위카테고리에서 1을 뺀 크기를 비교
                    // 모두 체크 시 1Depth 체크
                    if( this.selected_categories.length === (this.low_categories.length - 1) ) {
                        this.selected_categories.push(this.category_code);
                    }
                } else { // 체크X
                    // 1Depth 체크 되어있으면 체크 풀어줌
                    let depth1_index = this.selected_categories.findIndex(c => c.toString().length === 3);
                    if( depth1_index > -1 ) {
                        this.selected_categories.splice(depth1_index, 1);
                    }
                }
            }
        },
        // 하위 카테고리 모두 체크
        check_all_low_categories() {
            this.low_categories.forEach(c => {
                if( this.selected_categories.indexOf(c.category_code) === -1 ) {
                    this.selected_categories.push(c.category_code);
                }
            });
        },
        clear_categories() {
            this.selected_categories = [];
        }
    },
    watch : {
        selected_categories(categories) {
            this.$emit('changed_categories');
        }
    }
});