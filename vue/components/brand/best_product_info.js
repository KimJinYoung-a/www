Vue.component('BEST-PRODUCT-INFO', {
    template : `
        <div class="pdtInfo">
            <p class="pdtName tPad07"><a @click="go_product_detail">{{item_name}}</a></p>
            <p v-if="sale_yn || coupon_yn" class="pdtPrice"><span class="txtML">{{number_format(org_price)}}원</span></p>
            <p class="pdtPrice">
                <span class="finalP">{{number_format(sell_price)}}원</span>
                <strong v-if="sale_percent > 0 && (sale_yn || coupon_yn)" :class="sale_percent_class">[{{sale_percent}}%]</strong>
            </p>
            <p class="pdtStTag tPad10">
                <!-- 품절이면  & 다른 뱃지 표시 안함 -->
                <img v-if="sell_flag == 'N'" src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" />
                <template v-else>
                    <img v-if="sell_flag != 'Y'" src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" />
                    <img v-if="sale_yn" src="http://fiximage.10x10.co.kr/web2013/shopping/tag_sale.gif" alt="SALE" />
                    <img v-if="coupon_yn" src="http://fiximage.10x10.co.kr/web2013/shopping/tag_coupon.gif" alt="쿠폰"/>
                    <img v-if="limit_yn" src="http://fiximage.10x10.co.kr/web2013/shopping/tag_limited.gif" alt="한정"/>
                    <img v-if="ten_only_yn" src="http://fiximage.10x10.co.kr/web2013/shopping/tag_only.gif" alt="ONLY"/>
                    <img v-if="new_yn" src="http://fiximage.10x10.co.kr/web2013/shopping/tag_new.gif" alt="NEW"/>
                    <span v-if="gift_wrap_yn" class="icoWrappingV15a">
                        <img src="http://fiximage.10x10.co.kr/web2015/shopping/ico_pakage_act.png" alt="선물포장가능">
                        <em><img src="http://fiximage.10x10.co.kr/web2015/common/pkg_tip.png" alt="선물포장가능"></em>
                    </span>
                </template>
            </p>
        </div>
    `,
    props: {
        // 상품정보
        item_id : { type : Number, default : 0 }, // 상품 ID
        item_name : { type : String, default : '' }, // 상품명
        org_price : { type : Number, default : 0 }, // 기존 가격
        sell_price : { type : Number, default : 0 }, // 판매 가격
        brand_id : { type : String, default : '' }, // 브랜드ID
        brand_name : { type : String, default : '' }, // 브랜드명

        // 태그 관련
        sell_flag : { type : String, default : 'Y' }, // 판매상태(Y:정상, N:품절, S:일시품절)
        sale_yn : { type : Boolean, default : false }, // 세일 중 여부
        coupon_yn : { type : Boolean, default : false }, // 쿠폰 존재 여부
        limit_yn : { type : Boolean, default : false }, // 한정상품 여부
        ten_only_yn : { type : Boolean, default : false }, // 텐텐Only 여부
        new_yn : { type : Boolean, default : false }, // 신상품 여부
        gift_wrap_yn : { type : Boolean, default : false }, // 선물포장 여부
    },
    computed : {
        // 할인율
        sale_percent() {
            return Math.round((this.org_price - this.sell_price) * 100/this.org_price);
        },
        // 할인율 Class
        sale_percent_class() {
            if( this.sale_percent > 0 ) {
                if( this.sale_yn ) {
                    return 'cRd0V15';
                } else if( this.coupon_yn ) {
                    return 'cGr0V15';
                } else {
                    return '';
                }
            } else {
                return '';
            }
        }
    },
    methods : {
        // 브랜드 페이지 이동(Amplitude전송 후 이동)
        go_brand_detail() {
            fnAmplitudeEventMultiPropertiesAction('click_category_list_product_brand'
                , 'item_index|sort|category_code|category_depth|itemid|category_name|brand_name|list_style'
                ,`${this.index}|${this.sort}|${this.category_code}|${this.category_depth}`
                + `|${this.item_id}|${this.category_name}|${this.brand_name}|${this.view_type}`);

            location.href = '/street/street_brand.asp?makerid=' + this.brand_id;
        },
        // 상품 상세 이동
        go_product_detail() {
            this.$emit('go_product_detail');
        }
    }
});