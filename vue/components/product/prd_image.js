/**
 *  상품 이미지 영역
 */
Vue.component('PRODUCT-IMAGE', {
    template : `
        <div class="pdtPhoto">
            <div v-if="adult_yn" class="adult-hide"><p><span>19세 이상만</span> <span>구매 가능한 상품입니다</span></p></div>
            
            <a href="javascript:void(0);" @click="go_product_detail">
                <span class="soldOutMask"></span>
                <img :src="basic_image" :alt="item_name">
                <dfn v-if="add_image"><img :src="add_image" onerror="$(this).parent().empty();" :alt="item_name"></dfn>
            </a>
        </div>
    `,
    mounted() {
        $(".pdtList li .pdtPhoto").mouseenter(function(e){
            $(this).find("dfn").fadeIn(150);
        }).mouseleave(function(e){
            $(this).find("dfn").fadeOut(150);
        });
    },
    props : {
        item_id : { type : Number, default : 0 }, // 상품 ID
        item_name : { type : String, default : '' }, // 상품명
        basic_image : { type : String, default : '' }, // 기본이미지
        add_image : { type : String, default : '' }, // 추가이미지
        adult_yn : { type : Boolean, default : false }, // 성인상품 여부
    },
    methods : {
        // 상품상세 이동
        go_product_detail() {
            this.$emit('go_product_detail');
        }
    }
});