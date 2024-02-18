const app = new Vue({
    el: "#page",
    store: [dataStore],
    data() {
        return {
            isLoading: false, // visible only not is app
            isLogin: true,
        };
    },
    created() {
        this.$store[0].dispatch('GET_TRAILER');
        this.$store[0].dispatch('GET_TODAY_BRAND_ITEM_LIST');
        this.$store[0].dispatch('GET_BRAND_ITEM_LIST_GROUP');
        this.$store[0].dispatch('GET_DISCOUNT_ITEM_LIST_GROUP');
        this.$store[0].dispatch('GET_EVENT_LIST');
		if(februaryLoginCheck === "True"){
			this.$store[0].dispatch('GET_CHECK_HAS_COUPON_STATE');
			if ((monthlyTenSmsUserCheck > 0 && monthlyTenEmailUserCheck > 0)) {
				this.$store[0].commit('SET_USER_INFO', true)
			} else {
				this.$store[0].commit('SET_USER_INFO', false)
			}
		}
    },
    template: `
        <main>
            <div v-if="isLoading">loading...</div>
            <div v-else>
                <section v-if="isLogin">
                    <profile />
                    <coupon-publish-guide />
                    <intro />
                    <take-part-brand-list />
                    <today-brand-item-list />
                    <floating />
                    <brand-item-list-group />
                    <discount-item-list-group />
                    <exhibit-and-event />
                    <to-gift />
                    <alarm-or-download />
                </section>
                <content-guide v-else />
            </div>
        </main>
    `,
});
