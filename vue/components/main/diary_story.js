// diary-story
Vue.use(VueAwesomeSwiper);
Vue.component('diary-story',{
	template : `
		<div class="diary2023_today">
			<!-- 텐텐다꾸 ver2 -->
			<div class="section01">
				<div class="blur02"></div>
				<div class="line01"><img src="//webimage.10x10.co.kr/fixevent/event/2022/daccu2023/line05.png?v=2" alt=""></div>
				<div class="line02"><img src="//webimage.10x10.co.kr/fixevent/event/2022/daccu2023/line06.png" alt=""></div>
				<div class="sect01_wrap">
					<Menu-Component></Menu-Component>
					<div class="swiper-container sect01_rolling" v-show="events_slidebanner.length > 0">
						<swiper class="main_slider swiper-wrapper"
								ref="event_swiper" 
								:options="event_swiper" 
								@click.native="goEventLink"
						>
							<swiper-slide  v-for="(item, index) in events_slidebanner" class="slide swiper-slide">
								<a @click="go_link(item.linkurl, index, item.eventid)" href="javascript:void(0)">
									<div class="slide_img">
										<img :src="item.imageurl + '/10x10/optimize'" alt="">
									</div>
									<div class="slide_info">
										<p v-html="item.titlename"></p>
										<p v-if="item.couponText" class="blue"><span>~{{item.couponText}}%</span> 할인</p>
										<p v-else-if="parseInt(item.salePer)" class="blue"><span>~{{item.salePer}}%</span> 할인</p>
										<ul v-if="item.tag" class="badge"><p>{{item.tag}}</p></ul>
									</div>
								</a>
							</swiper-slide>
						</swiper>
						<!-- pagination -->
						<div class="swiper-pagination"></div>
						<div class="end_img">
							<a href="/diarystory2023/index.asp"><img src="//webimage.10x10.co.kr/fixevent/event/2022/daccu2023/daccu_more.png" alt=""></a>
						</div>
					</div>
					<div class="daccu_arrow swiper-button-prev" @click="prev()">
						<img src="//webimage.10x10.co.kr/fixevent/event/2022/daccu2023/arrow_right_new.png" alt="">
					</div>
					<div class="daccu_arrow swiper-button-next" @click="next()">
						<img src="//webimage.10x10.co.kr/fixevent/event/2022/daccu2023/arrow_right_new.png" alt="">
					</div>
				</div>
			</div>
			<!-- //텐텐다꾸 ver2 -->
		</div>
	`,
	created() {
        this.$store.dispatch("GET_EVENTS_LINK");
        this.$store.dispatch("GET_EVENTS_SLIDEBANNER");
        this.send_amplitude("view_diary2023_today", "");
    }
    , mounted(){
        const _this = this;
    }
	, updated() {
		const _this = this
		_this.$nextTick(function() {
			var amt = $('.diary2023_today .main_slider').find('.slide').length;
			$('.diary2023_today .daccu_arrow').click(function(){
				currentSlide = _this.swiper.activeIndex
				if(amt - 4 <= currentSlide){
					$('.diary2023_today .end_img').addClass('on');
				}
			})
		})
	}
    , computed : {
        events_link(){
            return this.$store.getters.events_link;
        }
        , events_slidebanner(){
            return this.$store.getters.events_slidebanner.slice(0,8);
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
				initialSlide: 2
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
            this.send_amplitude("click_diary2023_todaybanner", amplitude_date);
            location.href = link;
        }

        , send_amplitude(name, data){
            fnAmplitudeEventActionJsonData(name, JSON.stringify(data));
        }
		, prev() {
			this.swiper.slidePrev();
		}
		, next() {
			this.swiper.slideNext();
		}
    }
})


// diaryStory
new Vue({
	el: "#diaryStory",
	store : store,
	template : `
		<div id="diary_story">
			<diary-story></diary-story>
		</div>
	`
})