/**타이틀(인트로) */
Vue.component('intro', {
    template: `
    <article class="intro">
      <div class="intro__inner">
        <p class="intro__title--decoration">
          <span>monthlytenten</span>
          <span>February</span>
        </p>
        <h2 class="intro__title">
          <img src="//webimage.10x10.co.kr/fixevent/event/2023/monthly/feburary/pc/intro/intro__event-title.svg" alt="월간텐텐" />
        </h2>
        <h3 class="intro__sub-title">
          <img src="//webimage.10x10.co.kr/fixevent/event/2023/monthly/feburary/pc/intro/intro__monthly-title.svg" alt="2월 준비의달" />
        </h3>
        <p class="intro__sub---decoration">
          <span>2월의 당신이 <strong>새로운 시작</strong>을 준비할 수 있도록.</span>
        </p>

        <!-- 상품 영역 -->
        <div v-if="randomIntroNumber === 0" class="part1">
          <div v-for="(item, index) in itemListPart1"
            :key="getLoopKey('intro-position-item-part1', index)" 
            :class="[{'is-soldout': item.soldout === 'true'},getLoopClassName(index)]"
            @click="moveToProductPage(item)">
            <span v-if="item.soldout === 'false'" class="tag-percent">{{ item.discountRate }}</span>
            <span v-if="item.soldout === 'true'" class="tag-percent--soldout">완판!</span>
            <img :src="item.itemImage" :alt="item.itemName" />
          </div>
        </div>
        <div v-if="randomIntroNumber === 1" class="part2">
          <div v-for="(item, index) in itemListPart2"
            :key="getLoopKey('intro-position-item-part2', index)" 
            :class="[{'is-soldout': item.soldout === 'true'},getLoopClassName(index)]"
            @click="moveToProductPage(item)">
            <span v-if="item.soldout === 'false'" class="tag-percent">{{ item.discountRate }}</span>
            <span v-if="item.soldout === 'true'" class="tag-percent--soldout">완판!</span>
            <img :src="item.itemImage" :alt="item.itemName" />
          </div>
        </div>
      </div>
    </article>
  `,
  data() {
    return {
      introNumber: -1,
    }
  },
  computed: {
    randomIntroNumber() {
      this.introNumber = Math.floor(Math.random() * 2);
      return this.introNumber
    },
    itemListPart1() {
      return this.$store[0].getters.itemListPart1;
    },
    itemListPart2() {
      return this.$store[0].getters.itemListPart2;
    },
  },
  methods: {
    getLoopKey(prefix, index) {
      return `${prefix}-${index}`;
    },
    getLoopClassName(index) {
      return `intro__product-0${index + 1}`;
    },
    moveToProductPage(item) {
      location.href = `/shopping/category_prd.asp?itemid=${item.itemId}`;
    },
  }
});