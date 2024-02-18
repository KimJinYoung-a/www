/**브랜드 상품 그룹 */
Vue.component('brand-item-list-group', {
    template: `
        <article class="brand-group">
            <div
            :id="brand.brand_name_kr"
            v-for="(brand, index) in brandItemListGroup" 
            :key="getLoopKey('monthly-brand-group-list', index)" 
            :class="{'is-main-brand' : index < 4}" 
            class="brand-list monthly-items">
                <div class="product">
                    <div class="brand-title" @click="moveToBrandList(brand.brand_id)">
                        <ul class="brand-title__left">
                            <li class="brand-title__left--brand">brand</li>
                            <li class="brand-title__left--index">{{getIndex(index + 1)}}</li>
                        </ul>
                        <ul class="brand-title__right">
                            <li class="brand-title__right--en">{{brand.brand_name_en}}</li>
                            <li class="brand-title__right--kr">{{brand.brand_name_kr}}</li>
                        </ul>
                    </div>
                    <div 
                        v-for="(item, j) in brand.products.slice(0, 4)" 
                        :key="getLoopKey('monthly-brand-group-item', j)" 
                        class="product__list"
                        @click="moveToProductPage(item.itemid)">
                        <div class="thumbnail">
                            <span v-if="false" class="product__list--badge">무료배송</span>
                            <img v-if="item.itemimage" :src="decodeBase64(item.itemimage)" :alt="item.itemname">
                        </div>
                        <div class="product-info">
                            <div v-if="item.salePer > 0" class="org-price-wrap">
                                <span class="product-info__org-price">{{formatPrice(item.orgprice)}}</span>
                                <span class="product-info__percent---text">한정할인 적용 시</span>
                            </div>
                            <div class="price-wrap">
                                <span class="product-info__price">{{formatPrice(item.sellcash)}}</span>
                                <span v-if="item.salePer > 0" class="product-info__percent">{{getPercent(item.salePer)}}%</span>
                            </div>
                            <div class="product-info__name">{{item.itemname}}</div>
                        </div>
                    </div>
                </div>
                <div class="product__more" @click="moveToBrandList(brand.brand_id)">
                    more({{ brand.itemCount }})>
                </div>
            </div>
        </article>
    `,
    computed: {
        brandItemListGroup() {
            return this.$store[0].getters.brandItemListGroup;
        },
    },
    methods: {
        decodeBase64(str) {
            if (str === null) return null;
            return atob(str.replace(/_/g, '/').replace(/-/g, '+'));
        },
        formatPrice(price) {
            if (price) {
                return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
            }
            return '';
        },
        getLoopKey(prefix, index) {
            return `${prefix}-${index}`;
        },
        moveToProductPage(targetId) {
            location.href = `/shopping/category_prd.asp?itemid=${targetId}`;
        },
        getIndex(number) {
            if (number < 10) {
                return '0' + number;
            } else {
                return number;
            }
        },
        moveToBrandList(brandId) {
            location.href = '/monthlyten/2023/february/product/list/index.asp?maker_id=' + brandId;
        },
        getPercent(salePer) {
            return Math.round(salePer);
        }
    }
});