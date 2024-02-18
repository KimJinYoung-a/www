const app = new Vue({
    el: "#page",
    store: [dataStore],
    created() {
        this.$store[0].dispatch('GET_TRAILER');
    },
    template: `
        <main>
            <content-guide />
        </main>
    `,
});
