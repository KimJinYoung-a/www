/**
 * 페이지
 */
Vue.component('PAGE', {
    template : `
        <div class="pageWrapV15 tMar20">
            <div class="paging">
                <a @click="move_page(1)" title="첫 페이지" class="first arrow">
                    <span style="cursor:pointer;">맨 처음 페이지로 이동</span>
                </a>
                <a @click="move_page(current_page - 1)" title="이전 페이지" class="prev arrow">
                    <span style="cursor:pointer;">이전페이지로 이동</span>
                </a>
                <a v-for="page in pages" @click="move_page(page)" 
                    :class="{current : page === current_page}" :title="page + ' 페이지'" style="margin: 0 2px;" :id="'page' + page" name="pageGroup">
                    <span style="cursor:pointer;">{{page}}</span>
                </a>
                <a @click="move_page(current_page + 1)" title="다음 페이지" class="next arrow">
                    <span style="cursor:pointer;">다음 페이지로 이동</span>
                </a>
                <a @click="move_page(last_page)" title="마지막 페이지" class="end arrow">
                    <span style="cursor:pointer;">맨 마지막 페이지로 이동</span>
                </a>
            </div>
            
            <div class="pageMove">
                <input type="number" v-model="input_page" min="1" :max="last_page" style="width:24px;">/{{number_format(last_page)}}페이지 
                <a href="javascript:void(0);" @click="move_page_input" class="btn btnS2 btnGry2">
                    <em class="whiteArr01 fn">이동</em>
                </a>
            </div>
        </div>
    `,
    data() {return {
        input_page : 1
    }},
    mounted() {
        this.input_page = this.current_page;
    },
    props : {
        show_item_count : { type : Number, default : 40 }, // 한번에 노출 할 상품 수
        show_page_count : { type : Number, default : 10 }, // 한번에 노출 할 페이지 수
        current_page : { type : Number, default : 1 }, // 현재 페이지
        total_item_count : { type : Number, default : 1 }, // 총 상품 수
    },
    computed : {
        // 첫 페이지
        first_page() {
            return Math.floor((this.current_page-1)/this.show_page_count)*this.show_page_count + 1;
        },
        // 마지막 페이지
        last_page() {
            return Math.floor((this.total_item_count-1)/this.show_item_count) + 1;
        },
        // 페이지 리스트
        pages() {
            let current_page;
            const page_list = [];
            for( let i = 0 ; i < this.show_page_count ; i++ ) {
                current_page = this.first_page + i;
                if( current_page > this.last_page ) {
                    break;
                }

                page_list.push(current_page);
            }
            return page_list;
        }
    },
    methods : {
        // 페이지 이동
        move_page(page) {
            if( page < 1 || page > this.last_page )
                return false;

            this.$emit('move_page', page);
        },
        // 직접 입력 이동
        move_page_input() {
            this.move_page(parseInt(this.input_page));
        }
    }
});