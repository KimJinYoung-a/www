Vue.component('EVENT', {
    template : `
        <section id="tab03" class="tab03">
            <!-- 배너 -->
            <section class="section01_1" id="link03">
                <h2><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/pc/nov/title10.png" alt=""></h2>
                <div class="bnr_wrap">
                    <li v-for="(event, index) in events">
                        <a :href="event.linkurl" @click="eventAmplitude(index+1)">
                            <img :src="event.imageurl" alt="">
                        </a>
                    </li>
                </div>
            </section>
            <!-- 베스트 -->
            <section class="section01_2">
                <p>
                    <a href="/award/awardlist.asp?atype=b&gaparam=main_menu_best" @click="bestAmplitude">
                        <img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/pc/nov/go_brand.jpg?v=2" alt="">
                    </a>
                </p>
            </section>
        </section>
    `
    , created() {
        const _this = this;
        _this.$store.dispatch('GET_EVENTS');
    }
    , data() {
        return {
            itemList: []
        }
    }
    , computed : {
        events() { return this.$store.getters.events; }
    },
    methods : {
        goEventPage(code) {
            let url = "";
            let appTitle = "기획전";
            switch(code) {
                case 'firstBuy' : 
                    url = '/event/benefit/index.asp';
                    appTitle = "첫구매SHOP";
                    break;
                case 'plusSale' : 
                    url = '/plussale/index.asp'; 
                    appTitle = "플러스세일";
                    break;
            }
            if (url === "") {
                url = "/event/eventmain.asp?eventid=" + code;
            }

            location.href = url;
        },
        eventAmplitude(index) {
            fnAmplitudeEventAction('click_monthlyten_event', 'num', index);
        },
        bestAmplitude() {
            fnAmplitudeEventAction('click_monthlyten_event', '', '');
        }
    }
});