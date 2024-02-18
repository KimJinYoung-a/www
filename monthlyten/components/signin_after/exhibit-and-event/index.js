/**기획전/이벤트 */
Vue.component('exhibit-and-event', {
    template: `
        <article id="exhibit-and-event" class="limit-event">
            <h2>한정 이벤트</h2>
            <div class="limit-event__wrap">
                <div class="limit-event__banner" v-for="(event, index) in eventList" @click="goEvent(event.eventCode)">
                    <img :src="event.bannerImage" :alt="event.eventCode" />
                </div>
            </div>
        </article>
    `,
    computed : {
        eventList() {
            return this.$store[0].getters.eventList;
        }
    },methods : {
        goEvent(eventCode) {
            let targetEvent = eventCode;
            switch (targetEvent) {
                case 122398:
                    targetEvent = 122399;
                    break;
                case 122367:
                    targetEvent = 122366;
                    break;
            }
                
            location.href = `/event/eventmain.asp?eventid=${targetEvent}`;
        }
    }
});