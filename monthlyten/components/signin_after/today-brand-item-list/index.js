/**오늘의 브랜드 픽 */
Vue.component('today-brand-item-list', {
    template: `
        <article v-if="todayBrandItemList.length > 0" class="today-brand">
            <h2 class="today-brand__title">오늘의 브랜드 픽</h2>
            <div class="product">
                <div v-for="(item, j) in todayBrandItemList.slice(0, 4)" 
                :key="getLoopKey('monthly-brand-pick-item', j)" 
                class="product__list" 
                @click="moveToProductPage(item.itemid)">
                    <div class="thumbnail">
                        <span v-if="false" class="product__list--badge">무료배송</span>
                        <img v-if="item.imgurl" :src="item.imgurl" :alt="item.itemname">
                    </div>
                    <div class="product-info">
                        <div v-if="getPercent(item.saleper) > 0" class="org-price-wrap">
                            <span class="product-info__org-price">{{formatPrice(item.orgprice)}}</span>
                            <span class="product-info__percent---text">한정할인 적용 시</span>
                        </div>
                        <div class="price-wrap">
                            <span class="product-info__price">{{formatPrice(item.sellprice)}}</span>
                            <span v-if="getPercent(item.saleper) > 0" class="product-info__percent">{{getPercent(item.saleper)}}%</span>
                        </div>
                        <div class="product-info__name">{{item.itemname}}</div>
                        <div class="product-info__brand">{{item.brandname}}</div>
                    </div>
                </div>
            </div>
        </article>
    `,
    data() {
        return {
        }
    },
    computed: {
        todayBrandItemList() {
            return this.$store[0].getters.todayBrandItemList;
        },
    },
    methods: {
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
            location.href = '/shopping/category_prd.asp?itemid=' + targetId;
        },
        getPercent(salePer) {
            return parseInt(salePer);
        }
    }
}); 