Vue.use(VueAwesomeSwiper);

const app = new Vue({
    el: '#app'
    , store : store
    , template : `
        <div class="container diary2023">
            <div id="contentWrap" class="diary2023_main">
                <!-- 롤링 -->
                <div class="section01">
                    <div class="blur02"></div>
                    <div class="line01"><img src="//webimage.10x10.co.kr/fixevent/event/2022/daccu2023/line01.png" alt=""></div>
                    <div class="line02"><img src="//webimage.10x10.co.kr/fixevent/event/2022/daccu2023/line02.png" alt=""></div>
                    <div class="sect01_wrap">
                        <Menu-Component></Menu-Component>
                        
                        <div v-if="events_slidebanner.length > 0"  class="swiper-container sect01_rolling">
                            <swiper class="main_slider swiper-wrapper" 
                                    ref="event_swiper" 
                                    :options="event_swiper" 
                                    @click.native="goEventLink"
                            >
                                <swiper-slide class="slide swiper-slide" v-for="(item, index) in events_slidebanner">
                                    <a @click="go_link(item.linkurl, index, item.eventid)" href="javascript:void(0)">
                                        <div class="slide_img">
                                            <img :src="item.imageurl + '/10x10/optimize'" alt="">
                                        </div>
                                        <div class="slide_info">
                                            <p class="number">{{getNumber(index + 1)}}</p>
                                            <p v-html="item.titlename"></p>
                                            <p v-if="item.couponText" class="blue"><span>~{{item.couponText}}%</span> 할인</p>
                                            <p v-else-if="parseInt(item.salePer)" class="blue"><span>~{{item.salePer}}%</span> 할인</p>
                                            <ul v-if="item.tag" class="badge"><p>{{item.tag}}</p></ul>
                                        </div>
                                    </a>
                                </swiper-slide>
                            </swiper>
                            <div class="swiper-pagination"></div>
                        </div>
                        <div class="prev swiper-button-prev" @click="prev()">
                            <img src="//webimage.10x10.co.kr/fixevent/event/2022/daccu2023/arrow_right_new.png" alt="">
                        </div>
                        <div class="next swiper-button-next" @click="next()">
                            <img src="//webimage.10x10.co.kr/fixevent/event/2022/daccu2023/arrow_right_new.png" alt="">
                        </div>
                        <div class="sect01_inform">
                            today's 텐텐다꾸
                        </div>
                    </div>
                </div>
                <div class="section02">
                    <div class="sect02_event">
                        <div v-for="item in event" class="event_wrap">
                            <a @click="eventAmplitude(item.evt_code)" :href="'/event/eventmain.asp?eventid=' + item.evt_code">
                                <div class="event_img">
                                    <img :src="item.bannerImage + '/10x10/optimize'" alt="">                                    
                                    <ul v-if="item.tag" class="badge"><p>{{item.tag}}</p></ul>
                                </div>
                                <div class="event_info">
                                    <p v-html="item.evt_name"></p>
                                    <p v-if="item.couponText" class="blue"><span>{{item.couponText}}%</span> 할인</p>
                                    <p v-else-if="parseInt(item.salePer)" class="blue"><span>~{{item.salePer}}%</span> 할인</p>
                                </div>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    `
    , created() {
        this.$store.dispatch("GET_EVENTS_LINK");
        this.$store.dispatch("GET_EVENTS_SLIDEBANNER");
        this.$store.dispatch("GET_EVENT");

        this.send_amplitude("view_diary2023_main", "");
    }
    , mounted(){
        const _this = this;
    }
    , computed : {
        events_link(){
            return this.$store.getters.events_link;
        }
        , events_slidebanner(){
            return this.$store.getters.events_slidebanner;
        }
        , event(){
            return this.$store.getters.event;
        }
        , swiper() {
            return this.$refs.event_swiper.$swiper;
        }
    }
    , data(){
        return {
            event_swiper : {
                loop:true,
                slidesPerView:2,
                navigation: {
                    nextEl: '.swiper-button-next',
                    prevEl: '.swiper-button-prev',
                },
                pagination: {
                    el: '.swiper-pagination',
                    clickable: true,
                },
                slidesPerGroup : 2,
            }
        }
    }
    , methods : {
        goEventLink() {
            const _this = this;
            let index = _this.getSlideIndex(_this.swiper.clickedIndex);
            let slideInfo = _this.events_slidebanner[index];
            _this.go_link(slideInfo.linkurl, index+1, slideInfo.eventid);
        },
        getSlideIndex(index) {
            let result_index = index - 2;
            if (result_index === -1) {
                result_index = this.events_slidebanner.length - 1;
            } else if (result_index === -2) {
                result_index = this.events_slidebanner.length - 2;
            }
            return result_index;
        },
        format_price(price){
            if(price){
                return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
            }
        }
        , go_link(link, index, eventid){
            let amplitude_date = {
                "index": index+1
                , "eventcode" : eventid
            };
            this.send_amplitude("click_diary2023_mainbanner", amplitude_date);
            location.href = link;
        }

        , send_amplitude(name, data){
            fnAmplitudeEventActionJsonData(name, JSON.stringify(data));
        }
        , getNumber(num) {
            let result = num < 10 ? "0" + num : num;
            return result + ".";
        },
        prev() {
			this.swiper.slidePrev();
		},
		next() {
			this.swiper.slideNext();
		} ,
        eventAmplitude(eventCode) {
            fnAmplitudeEventAction('click_diarystory_event', 'event_code', eventCode);
        }

    }
});