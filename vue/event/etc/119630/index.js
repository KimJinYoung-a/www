const app = new Vue({
    el: '#app'
    , store : store
    , template : `
        <div class="evt119630">
            <div class="sec-wrap">
            <section class="section01"><button type="button" @click="go_alarm" class="btn-alram txt-hidden">알람 받기</button></section>
            <section class="section02">
                <ul class="link-area">
                    <li><a href="#no1" class="txt-hidden">new brand</a></li>
                    <li><a href="#no2" class="txt-hidden">time sale</a></li>
                    <li><a href="#no3" class="txt-hidden">special sale</a></li>
                    <li><a href="#no4" class="txt-hidden">re commend zone</a></li>
                </ul>
            </section>
            <section class="section03">
                <div id="no1"></div>
                <ul class="link-brand">
                    <li><a href="/street/street_brand_sub06.asp?makerid=lifefourcuts1"></a></li>
                    <li><a href="/street/street_brand_sub06.asp?makerid=fastfive10"></a></li>
                    <li><a href="/event/eventmain.asp?eventid=119704"></a></li>
                    <li><a href="/event/eventmain.asp?eventid=119731"></a></li>
                    <li><a href="/event/eventmain.asp?eventid=119752"></a></li>
                    <li><a href="/event/eventmain.asp?eventid=119527"></a></li>
                </ul>
            </section>
            <section class="section04">
                <div id="no2"></div>
                <div class="tit"></div>
                <!-- counting -->
                <div id="countdown" class="time-counting">00:00:00</div>
                
                <div v-if="active_time == 1" class="time-prd"><a href="/shopping/category_prd.asp?itemid=4774732&pEtr=119630" class="txt-hidden">엘리팩토리 30종 랜덤팩</a></div>
                <!-- 8.24 ~ 8.26 노출 -->
                <div v-if="active_time == 2" class="time-prd time02"><a href="/deal/deal.asp?itemid=4830727" class="txt-hidden">푸르릉 1+1 특가</a></div>
                <!-- 8.27 ~ 8.28 노출 -->
                <div v-if="active_time == 3" class="time-prd time04"><a href="/deal/deal.asp?itemid=4833625" class="txt-hidden">젤리크루 스티커버</a></div>
                <!-- 8.29 ~ 8.31 노출 -->
                <div v-if="active_time == 4" class="time-prd time03"><a href="/deal/deal.asp?itemid=4833625" class="txt-hidden">젤리크루 스티커버</a></div>
            </section>
            <section class="section05">
                <div id="no3"></div>
                <div class="w1140">
                    <ul>
                        <li><a href="/shopping/category_prd.asp?itemid=4820641&pEtr=119630" class="txt-hidden">아이코닉</a></li>
                        <li><a href="/shopping/category_prd.asp?itemid=4829913&pEtr=119630" class="txt-hidden">엘레팩토리</a></li>
                        <li><a href="/shopping/category_prd.asp?itemid=4830280&pEtr=119630" class="txt-hidden">워너디스</a></li>
                        <li><a href="/deal/deal.asp?itemid=4829937" class="txt-hidden">밴도</a></li>
                        <li><a href="/deal/deal.asp?itemid=4829935" class="txt-hidden">플레픽</a></li>
                        <li><a href="/shopping/category_prd.asp?itemid=4025846&pEtr=119630" class="txt-hidden">피키디아</a></li>
                        <li><a href="/deal/deal.asp?itemid=4829936" class="txt-hidden">아이코닉</a></li>
                        <li><a href="/shopping/category_prd.asp?itemid=4830279&pEtr=119630" class="txt-hidden">워너디스</a></li>
                        <li><a href="/shopping/category_prd.asp?itemid=4830278&pEtr=119630" class="txt-hidden">워너디스</a></li>
                        <li><a href="/shopping/category_prd.asp?itemid=4829951&pEtr=119630" class="txt-hidden">오나이</a></li>
                        <li><a href="/shopping/category_prd.asp?itemid=4829938&pEtr=119630" class="txt-hidden">바이플디자인</a></li>
                        <li><a href="/shopping/category_prd.asp?itemid=4829939&pEtr=119630" class="txt-hidden">바이플디자인</a></li>
                    </ul>
                </div>
            </section>
            <section class="section06">
                <div id="no4"></div>
                <div class="tit"></div>
                <div class="start-fix"></div>
                <!-- 키워드 -->
                <div class="recommend-swiper swiper-container">
                    <div class="swiper-wrapper">
                        <div v-for="item in parents_evtgroup" class="swiper-slide">
                            <button @click="show_tab_item('parents', item)" type="button" :class="active_parents_evtgroup == item.evtgroup_code ? 'active' : ''"><span>{{item.evtgroup_desc}}</span></button>
                        </div>
                    </div>

                    <div class="tab-category">
                        <div id="tab-1" class="category-list active">
                            <div class="prdlistswiper">
                                <div class="swiper-wrapper">
                                    <div v-for="item in child_evtgroup" @click="show_tab_item('child', item)" :class="['swiper-slide', active_child_evtgroup == item.evtgroup_code ? 'active' : '']">
                                        <span>{{item.evtgroup_desc}}</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- 상품 노출 -->
                <div class="item-recommend">
                    <div class="w1140">
                        <ul id="itemList" class="item_list"></ul>
                    </div>
                </div>
            </section>
            </div>
        </div>
    `
    , created() {
        const _this = this;
        //this.$store.commit("SET_EVT_CODE", get_url_parameter("eventid"));
        this.$store.commit("SET_EVT_CODE", 119630);
        this.set_active_time();

        this.$store.dispatch("GET_PARENTS_EVTGROUP");

        this.$nextTick(function() {
            $(window).scroll(function () {
                if ($(window).scrollTop() * 1.5 >= $(document).height() - $(window).height()) {
                    if (_this.last_page > _this.page && !_this.loading_flag) {
                        _this.loading_flag = true;
                        _this.$store.commit("SET_PAGE", _this.page+1);
                        _this.$store.dispatch("GET_EVENT_ITEM");
                    }
                }
            });

            var recommendSwiper = new Swiper(".recommend-swiper", {
                slidesPerView:'auto',
                loop:false,
                /* 08-20 추가 */
                touchRatio: 0,
            });

            var bottomSwiper = new Swiper(".prdlistswiper", {
                slidesPerView:'auto',
                observer: true,
                observeParents: true,
                spaceBetween:10,
                slideToClickedSlide:true
            });
            /* sale zone 노출 */
            var date = new Date();
            var year = date.getFullYear();
            var month = date.getMonth()+1;
            var day = date.getDate();

            var getDate = year +"-"+ month +"-"+ day;
            console.log(getDate);
            if(eval(getDate) === 2022-8-29) {
                $('.section05').addClass('update');
            } else {
                $('.section05').removeClass('update');
            }
        });
    }
    , mounted(){
        const _this = this;
        this.$nextTick(function() {
            _this.set_active_time();
        })
    }
    , computed : {
        evt_code(){
            return this.$store.getters.evt_code;
        }
        , parents_evtgroup(){
            return this.$store.getters.parents_evtgroup;
        }
        , child_evtgroup(){
            return this.$store.getters.child_evtgroup;
        }
        , event_item(){
            return this.$store.getters.event_item;
        }
        , page(){
            return this.$store.getters.page;
        }
        , last_page(){
            return this.$store.getters.last_page;
        }
    }
    , data(){
        return {
            userid : ""
            , isLoginOk : false
            , active_time : 1
            , active_parents_evtgroup : null
            , active_child_evtgroup : null
            , loading_flag : false
        }
    }
    , methods : {
        go_alarm(){
            alert("앱에서만 신청하실 수 있습니다.");
        }
        , set_active_time(){
            let now = new Date();
            if(now >= new Date(2022,8-1, 22, 12,0, 0) && now < new Date(2022, 8-1, 24, 11, 59, 59)){
                this.active_time = 1;
                countDownTimer(2022, 8, 24, 11, 59, 59, now);
            }else if(now >= new Date(2022,8-1, 24, 12,0, 0) && now < new Date(2022, 8-1, 26, 12, 59, 59)){
                this.active_time = 2;
                countDownTimer(2022, 8, 26, 11, 59, 59, now);
            }else if(now >= new Date(2022,7, 26, 12,0, 0) && now < new Date(2022, 7, 29, 12, 59, 59)){
                this.active_time = 3;
            }else if(now >= new Date(2022,7, 29, 12,0, 0) && now < new Date(2022, 7, 31, 12, 59, 59)){
                this.active_time = 4;
                countDownTimer(2022, 8, 31, 11, 59, 59, now);
            }
        }
        , show_tab_item(type, item){
            var tabWrapHeight = $('.tab-wrap').outerHeight();

            if(type == "parents"){
                this.active_parents_evtgroup = item.evtgroup_code;
                this.$store.commit("SET_PAGE", 1);
                this.$store.dispatch("GET_CHILD_EVTGROUP", item.evtgroup_code);
                this.active_child_evtgroup = 0;
            }else{
                this.active_child_evtgroup = item.evtgroup_code;
                this.$store.commit("SET_EVTGROUP_CODE", item.evtgroup_code);
                this.$store.commit("SET_PAGE", 1);
                this.$store.dispatch("GET_EVENT_ITEM");
            }

            this.active_evtgroup_name = item.evtgroup_desc;
        }
    }
    , watch : {

    }
});