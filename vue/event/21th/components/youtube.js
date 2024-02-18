Vue.component('YOUTUBE', {
    template : `
        <section id="tab03" class="tab03">
            <section class="section08">
                <div class="youtube">
                    <p class="you01"><img src="//webimage.10x10.co.kr/fixevent/event/2022/anniversary/you01.png" alt=""></p>
                    <p class="you02"><img src="//webimage.10x10.co.kr/fixevent/event/2022/anniversary/you02.png" alt=""></p>
                    <p class="you04"><img src="//webimage.10x10.co.kr/fixevent/event/2022/anniversary/you04.png" alt=""></p>
                    <p class="you05"><img src="//webimage.10x10.co.kr/fixevent/event/2022/anniversary/you05.png" alt=""></p>
                </div>
                <button @click="movePage()"></button>
            </section>
        </section>
    `
    , created() {
        const _this = this;
    }
    , data() {
        return {
        }
    }
    , mounted() {
        const _this = this;
        
    }
    , computed : {

    },
    methods : {
        movePage() {
            location.href = "/event/eventmain.asp?eventid=120293";
        }
    }
});