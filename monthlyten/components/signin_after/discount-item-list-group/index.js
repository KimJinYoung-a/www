/**한정할인 상품 그룹 */
Vue.component('discount-item-list-group', {
    template: `
    <article class="category-group">
        <div
            :id="category.category_name_kr" 
            v-for="(category, index) in discountItemListGroup" 
            :key="getLoopKey('monthly-category-group-list', index)" 
            class="category-list monthly-items">
            <h2>한정할인 상품</h2>
            <div class="product">
                <div class="category-title" @click="moveToCategoryItemList(category.code)">
                    <ul class="category-title__left">
                        <li class="category-title__left--index">{{ getIndex(index + 1) }}</li>
                    </ul>
                    <ul class="category-title__right">
                        <li class="category-title__right--kr">{{ category.category_name_kr }}</li>
                    </ul>
                </div>
                <div 
                    v-for="(item, j) in category.products.slice(0, 4)" 
                    :key="getLoopKey('monthly-category-group-item', j)" 
                    class="product__list"
                    @click="moveToProductPage(item.itemid)">
                    <div class="thumbnail">
                        <span v-if="false" class="product__list--badge">무료배송</span>
                        <img 
                            v-if="item.itemimage" 
                            :src="decodeBase64(item.itemimage)" 
                            alt="item.itemname" 
                        />
                        <button 
                            v-if="false"
                            type="button" 
                            :id="getWishButtonIds(item.itemid)" 
                            class="button-wish" 
                            :class="{'is-wish-active': item.wish_yn}" 
                            @click="addWishItem($event, item)" />
                    </div>
                    <div class="product-info">
                        <div class="org-price-wrap">
                            <span class="product-info__org-price">
                                {{ item.orgprice.toLocaleString() }}
                            </span>
                            <span v-if="parseInt(item.salePer) > 0" class="product-info__percent---text">한정할인 적용 시</span>
                        </div>
                        <div class="price-wrap">
                            <span class="product-info__price">{{ getDiscountPrice(item) }}</span>
                            <span class="product-info__percent">{{ parseInt(item.salePer) }}%</span>
                        </div>
                        <div class="product-info__name">{{ item.itemname }}</div>
                    </div>
                </div>
            </div>
            <div
                class="product__more"
                @click="moveToCategoryItemList(category.code)">
                more({{ category.itemCount }})>
            </div>
        </div>
    </article>
    `,
    computed: {
        discountItemListGroup() {
            return this.$store[0].getters.discountItemListGroup;
        },
    },
    methods: {
        decodeBase64(str) {
            if (str === null) return null;
            return atob(str.replace(/_/g, '/').replace(/-/g, '+'));
        },
        getDiscountPrice(item) {
            const percentage = parseInt(item.salePer) * 0.01;
            return (item.orgprice - (item.orgprice * percentage)).toLocaleString();
        },
        getLoopKey(prefix, index) {
          return `${prefix}-${index}`;
        },
        moveToProductPage(targetId) {
            location.href = `/shopping/category_prd.asp?itemid=${targetId}`;
        },
        getWishButtonIds(targetId) {
          return `btn-id-${targetId}`;
        },
        addWishItem(event, item) {
            event.stopPropagation();
            item.wish_yn = !item.wish_yn;
        }, 
        getIndex(number) {
            if (number < 10) {
                return '0' + number;
            } else {
                return number;
            }
        },
        moveToCategoryItemList(code) {
            location.href = `/monthlyten/2023/february/product/list/index.asp?code=${code}`;
        },
    }
});