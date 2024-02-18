Vue.component('BRAND-FILTER', {
    template : `
        <li>
            <input type="checkbox" class="check" @change="check_brand" :checked="brand_ids.indexOf(brand.brand_id) > -1"/>
            <a @click="click_brand">{{brand.brand_name}} ({{number_format(brand.item_count)}})</a>
            <img v-if="brand.best_yn" src="http://fiximage.10x10.co.kr/web2013/common/tag_best.gif" alt="BEST" />
        </li>
    `,
    props : {
        brand : {
            brand_id : { type : String, default : '' }, // 브랜드 ID
            brand_name : { type : String, default : '' }, // 브랜드 명
            best_yn : { type : Boolean, default : false }, // 베스트 브랜드 여부
            item_count : { type : Number, default : 0 }, // 상품 갯수
        },
        brand_ids : { type : Array, default : function() {return [];}} // 활성화된 브랜드 필터 리스트
    },
    methods : {
        // 브랜드명 클릭
        click_brand() {
            this.$emit('click_brand', this.brand.brand_id);
        },
        // 체크 브랜드
        check_brand(e) {
            this.$emit('check_brand', this.brand.brand_id, e.target.checked);
        }
    }
});