Vue.component('eventList', {
    template : `
        <section id="tab04" class="tab04">
            <div class="sec_event">
                <h2 class="sec_title"><p>이달의 이벤트<span>지금 바로 참여해보세요!</span></p></h2>
                <div class="event_list">
                    <p v-if="showSurprizeMileage">
                        <a href="javascript:void(0);" @click="goEventPage(1,121868);"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthten/2301/event01.png?v=1.1" alt=""></a>
                    </p>
                    <p v-if="showFreeDelivery">
                        <a href="javascript:void(0);" @click="goEventPage(2,121876);"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthten/2301/event02.png" alt=""></a>
                    </p>
                    <p v-if="showRabbitKit">
                        <a href="javascript:void(0);" @click="goEventPage(3,121861);"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthten/2301/event03.png" alt=""></a>
                    </p>
                    <p v-if="showAttendanceMileage">
                        <a href="javascript:void(0);" @click="goEventPage(4,121976);"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthten/2301/event04.png" alt=""></a>
                    </p>
                    <p>
                        <a href="javascript:void(0);" @click="goEventPage(6,'');"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthten/2301/event05.png" alt=""></a>
                    </p>
                </div>
                <div class="qr_app">
                    <img src="//webimage.10x10.co.kr/fixevent/event/2022/monthten/2301/qr.png" alt="">
                </div>
            </div>
        </section>
    `
    , created() {

    }
    , mounted() {

    }
    , updated() {

    }
    , computed : {
        showSurprizeMileage() { //** 깜찍마일 */
            let now = sysdt;
            let startDay = new Date(2023, 0, 11, 0, 0, 0).getTime();
            let endDay = new Date(2023, 0, 12, 23, 59, 59).getTime();
            
            if (now >= startDay && now <= endDay) {
                return true;
            } else {
                return false;
            }
        },
        showFreeDelivery() { //** 무배데이 */
            let now = sysdt;
            let startDay = new Date(2023, 0, 9, 0, 0, 0).getTime();
            let endDay = new Date(2023, 0, 10, 23, 59, 59).getTime();
            
            if (now >= startDay && now <= endDay) {
                return true;
            } else {
                return false;
            }
        },
        showRabbitKit() { //** 토끼키트 */
            let now = sysdt;
            let startDay = new Date(2023, 0, 6, 0, 0, 0).getTime();
            let endDay = new Date(2023, 0, 16, 23, 59, 59).getTime();
            
            if (now >= startDay && now <= endDay) {
                return true;
            } else {
                return false;
            }
        },
        showAttendanceMileage() { //** 매일리지 */
            let now = sysdt;
            let startDay = new Date(2023, 0, 6, 0, 0, 0).getTime();
            let endDay = new Date(2023, 0, 16, 23, 59, 59).getTime();
            
            if (now >= startDay && now <= endDay) {
                return true;
            } else {
                return false;
            }
        },
        showPickUpEvent() { //** 줍줍이벤트 */
            let now = sysdt;
            let startDay = new Date(2023, 0, 6, 0, 0, 0).getTime();
            let endDay = new Date(2023, 0, 18, 23, 59, 59).getTime();
            
            if (now >= startDay && now <= endDay) {
                return true;
            } else {
                return false;
            }
        },
        showAPPMessage() { //** 줍줍이벤트 */
            if(this.is_app) {
                return true;
            } else {
                return false;
            }
        },
    },
    methods : {
        goEventPage(idx,eventid){
            fnAmplitudeEventAction('click_monthlyten_event', 'num', idx);
            if(eventid==""){
                location.href = "/diarystory2023/index.asp";
            }else{
                location.href = "/event/eventmain.asp?eventid=" + eventid;
            }
        },
    }
});