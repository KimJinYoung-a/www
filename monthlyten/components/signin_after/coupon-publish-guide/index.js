/**쿠폰 발급 안내 */
Vue.component("coupon-publish-guide", {
  template: `
        <article class="coupon-publish-guide">
            <span :class="[{'coupon-Y' : hasCoupon ? 'coupon-Y' : 'coupon-N'}] ">{{getCouponInfo}}</span>
            <span class="coupon__limited-number">이 기간에만 한정 할인을 받을 수 있습니다.</span>
        </article>
    `,
  data() {
    return {
      hasCoupon: false,
    };
  },
  computed: {
    getCouponInfo: function () {
      if (this.hasCoupon) {
        return "이미 쿠폰을 발급 받으셨군요! 그럼 할인 상품을 둘러볼까요?";
      } else {
        return "아래의 기획전을 통해 쿠폰을 발급 받아주세요!";
      }
    },
  },
});
