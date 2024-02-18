Vue.component('PRODUCT-BASIC', {
    template : `
        <li :class="product_li_class">
            <div class="pdtBox">
                <i v-if="product.free_delivery_yn && view_type === 'M'" class="free-shipping-badge">무료<br>배송</i>
                <i v-if="product.direct_trade_yn" class="abroad-badge">해외직구</i>
                <!-- 상품 이미지 영역 -->
                <PRODUCT-IMAGE
                    @go_product_detail="go_product_detail"
                    :item_id="product.item_id"
                    :item_name="product.item_name"
                    :basic_image="product.basic_image"
                    :add_image="product.add_image"
                    :adult_yn="product.adult_type != 0"
                ></PRODUCT-IMAGE>
                <!-- 상품 정보 영역 -->
                <PRODUCT-INFO
                    @go_product_detail="go_product_detail"
                    :item_id="product.item_id"
                    :item_name="product.item_name"
                    :org_price="product.origin_price"
                    :sell_price="product.item_price"
                    :brand_id="product.brand_id"
                    :sell_flag="product.sell_flag"
                    :sale_yn="product.sale_yn"
                    :coupon_yn="product.item_coupon_yn"
                    :limit_yn="product.limit_yn"
                    :ten_only_yn="product.tenten_made_yn"
                    :new_yn="product.new_yn"
                    :gift_wrap_yn="product.gift_wrap_yn"
                    :brand_name="product.brand_name"
                ></PRODUCT-INFO>
            </div>
        </li>
    `,
    props : {
        index : {type : Number, default: 0},
        product : {
            item_id : {type : Number, default: 0},
            item_name : {type : String, default: ''},
            origin_price : {type : Number, default: 0},
            item_price : {type : Number, default: 0},
            basic_image : {type : String, default: ''},
            add_image : {type : String, default: ''},
            brand_id : {type : String, default: ''},
            brand_name : {type : String, default: ''},
            adult_type : {type : Number, default: 0},
            sell_flag : {type : String, default: 'Y'},
            sale_yn : {type : Boolean, default: false},
            item_coupon_yn : {type : Boolean, default: false},
            limit_yn : {type : Boolean, default: false},
            tenten_made_yn : {type : Boolean, default: false},
            new_yn : {type : Boolean, default: false},
            gift_wrap_yn : {type : Boolean, default: false},
            free_delivery_yn : {type : Boolean, default: false},
            direct_trade_yn : {type : Boolean, default: false},
            adult_yn : {type : Boolean, default: false},
            review_cnt : {type : Number, default: 0},
            wish_cnt : {type : Number, default: 0},
            move_url : {type : String, default: ''}
        },
        view_type : {type : String, default: 'M'}, // 뷰 타입
    },
    computed : {
        adult_yn() {
            return this.product.adult_type !== 0;
        },
        // 상품 li Class
        product_li_class() {
            return {
                'soldOut' : this.product.sell_flag !== 'Y',
                'adult-item' : this.adult_yn
            };
        }
    },
    methods : {
        // 상품 상세 이동
        go_product_detail() {
            if( this.adult_yn ) {
                confirmAdultAuth(this.move_url); // 성인인증
            }

            this.$emit('go_product_detail', this.index, this.product);
        }
    }
});