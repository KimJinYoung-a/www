var app = new Vue({
    el: '#eventlist',
    store : store ,
    template: '\
                <section id="tab-event" class="tab-cont tab-event">\
                    <h3><img src="//webimage.10x10.co.kr/fixevent/event/2020/family2020/tit_related_event.png" alt="관련 이벤트"></h3>\
                    <div class="list-card item-360">\
                        <ul>\
                            <event-list\
                                v-for="(item,index) in eventLists"\
                                :key="index"\
                                :index="index"\
                                :eventid="item.eventid"\
                                :eventname="item.eventname"\
                                :subcopy="item.subcopy"\
                                :squareimage="item.squareimage"\
                                :rectangleimage="item.rectangleimage"\
                                :saleper="item.saleper"\
                                :salecper="item.salecpeer"\
                                :isgift="item.isgift"\
                                :issale="item.issale"\
                                :isoneplusone="item.isoneplusone"\
                                :amplitudeActionName="amplitudeActionName"\
                            >\
                            </event-list>\
                        </ul>\
                    </div>\
                </section>\
            ',
    data : function() {
        return {
            amplitudeActionName : "click_family2020_event",
        }
    },
    computed: {
        eventLists : function() {
            return this.$store.state.eventLists;
        },
    },
    created : function() {
        this.$store.commit('SET_MASTERCODE', '14'); // test 11 , live 14
        // Event List
        this.$store.dispatch('GET_EVENTLISTS');
    },
})
