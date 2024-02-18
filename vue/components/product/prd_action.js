/**
 * 상품 하단 액션 영역
 * 퀵뷰, 후기 팝업, 위시
 *
 * 사용 시 common_mixin 추가 필요
 */
Vue.component('PRODUCT-ACTION', {
    template : `
        <ul class="pdtActionV15">
            <li class="largeView"><a @click="pop_quick_view"><img src="http://fiximage.10x10.co.kr/web2015/common/btn_quick.png" alt="QUICK"/></a></li>
            <li class="postView"><a @click="pop_review_view"><span>{{number_format(review_count)}}</span></a></li>
            <li class="wishView"><a @click="add_wish"><span>{{number_format(wish_count)}}</span></a></li>
        </ul>
    `,
    props : {
        item_id : {type: Number, default: 0}, // 상품ID
        review_count : {type: Number, default: 0}, // 후기 수
        wish_count : {type: Number, default: 0}, // 위시 수
    },
    methods : {
        // 상품 퀵뷰 팝업
        pop_quick_view() {
            ZoomItemInfo(this.item_id);
            this.send_amplitude('quick');
        },
        // 후기보기 팝업
        pop_review_view() {
            if( this.review_count === 0 )
                return false;

            popEvaluate(this.item_id);
            this.send_amplitude('review');
        },
        // 위시
        add_wish() {
            TnAddFavorite(this.item_id);
            this.send_amplitude('wish');
        },
        // Amplitude 전송
        send_amplitude(value) {
            fnAmplitudeEventMultiPropertiesAction('click_category_list_product_info','type', value);
        }
    }
});