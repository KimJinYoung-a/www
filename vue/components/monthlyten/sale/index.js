Vue.component('SALE', {
    template : `
        <section id="tab02" class="tab02">
            <!-- 세일 아이템 -->
            <section class="section01_4">
                <h2><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/pc/nov/title09.png" alt=""></h2>
                <div class="cont_wrap">
                    <div :style="firstStyle">
                        <h3>
                            <span>{{setCategoryName(200)}}</span>
                            {{setCategoryTag(200)}}
                        </h3>
                        <div class="prd_wrap">
                            <ul id="lyrItemlist" class="item_list"><!-- target의 ID 지정 -->
                                <li v-for="(item, idx) in firstItems">
                                    <a href="javascript:void(0);" @click="prdDetailPage(item.itemid)" :class="'firstItems' + item.itemid">
                                        <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/pc/nov/tenbyten_thumbnail.jpg" alt=""></div>
                                        <div class="desc">
                                            <p class="name"></p>
                                            <div class="price"><s></s><span class="sale"></span></div>
                                        </div>
                                    </a>
                                </li>
                            </ul>
                        </div>
                        <div class="ten_mask" v-if="showMask(firstItems)">
                            <a v-if="showMask(firstItems)" href="javascript:void(0);" class="btn_more" @click="moreItem($event, 1)">
                                <img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/pc/nov/btn_more.png" alt="">
                            </a>
                        </div>
                    </div>
                    <div :style="secondStyle">
                        <h3>
                            <span>{{setCategoryName(201)}}</span>
                            {{setCategoryTag(201)}}
                        </h3>
                        <div class="prd_wrap">
                            <ul id="lyrItemlist" class="item_list"><!-- target의 ID 지정 -->
                                <li v-for="(item, idx) in secondItems">
                                    <a href="javascript:void(0);" @click="prdDetailPage(item.itemid)" :class="'secondItems' + item.itemid">
                                        <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/pc/nov/tenbyten_thumbnail.jpg" alt=""></div>
                                        <div class="desc">
                                            <p class="name"></p>
                                            <div class="price"><s></s><span class="sale"></span></div>
                                        </div>
                                    </a>
                                </li>
                            </ul>
                        </div>
                        <div class="ten_mask" v-if="showMask(secondItems)">
                            <a v-if="showMask(secondItems)" href="javascript:void(0);" class="btn_more" @click="moreItem($event, 2)">
                                <img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/pc/nov/btn_more.png" alt="">
                            </a>
                        </div>
                    </div>
                    <div :style="thirdStyle">
                        <h3>
                            <span>{{setCategoryName(202)}}</span>
                            {{setCategoryTag(202)}}
                        </h3>
                        <div class="prd_wrap">
                            <ul id="lyrItemlist" class="item_list"><!-- target의 ID 지정 -->
                                <li v-for="(item, idx) in thirdItems">
                                    <a href="javascript:void(0);" @click="prdDetailPage(item.itemid)" :class="'thirdItems' + item.itemid">
                                        <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/pc/nov/tenbyten_thumbnail.jpg" alt=""></div>
                                        <div class="desc">
                                            <p class="name"></p>
                                            <div class="price"><s></s><span class="sale"></span></div>
                                        </div>
                                    </a>
                                </li>
                            </ul>
                        </div>
                        <div class="ten_mask" v-if="showMask(thirdItems)">
                            <a v-if="showMask(thirdItems)" href="javascript:void(0);" class="btn_more" @click="moreItem($event, 3)">
                                <img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/pc/nov/btn_more.png" alt="">
                            </a>
                        </div>
                    </div>
                    <div :style="fourthStyle">
                        <h3>
                            <span>{{setCategoryName(203)}}</span>
                            {{setCategoryTag(203)}}
                        </h3>
                        <div class="prd_wrap">
                            <ul id="lyrItemlist" class="item_list"><!-- target의 ID 지정 -->
                                <li v-for="(item, idx) in fourthItems">
                                    <a href="javascript:void(0);" @click="prdDetailPage(item.itemid)" :class="'fourthItems' + item.itemid">
                                        <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/pc/nov/tenbyten_thumbnail.jpg" alt=""></div>
                                        <div class="desc">
                                            <p class="name"></p>
                                            <div class="price"><s></s><span class="sale"></span></div>
                                        </div>
                                    </a>
                                </li>
                            </ul>
                        </div>
                        <div class="ten_mask" v-if="showMask(fourthItems)">
                            <a v-if="showMask(fourthItems)" href="javascript:void(0);" class="btn_more" @click="moreItem($event, 4)">
                                <img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/pc/nov/btn_more.png" alt="">
                            </a>
                        </div>
                    </div>
                    <div :style="fifthStyle">
                        <h3>
                            <span>{{setCategoryName(204)}}</span>
                            {{setCategoryTag(204)}}
                        </h3>
                        <div class="prd_wrap">
                            <ul id="lyrItemlist" class="item_list"><!-- target의 ID 지정 -->
                                <li v-for="(item, idx) in fifthItems">
                                    <a href="javascript:void(0);" @click="prdDetailPage(item.itemid)" :class="'fifthItems' + item.itemid">
                                        <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/pc/nov/tenbyten_thumbnail.jpg" alt=""></div>
                                        <div class="desc">
                                            <p class="name"></p>
                                            <div class="price"><s></s><span class="sale"></span></div>
                                        </div>
                                    </a>
                                </li>
                            </ul>
                        </div>
                        <div class="ten_mask" v-if="showMask(fifthItems)">
                            <a v-if="showMask(fifthItems)" href="javascript:void(0);" class="btn_more" @click="moreItem($event, 5)">
                                <img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/pc/nov/btn_more.png" alt="">
                            </a>
                        </div>
                    </div>
                    <div :style="sixthStyle">
                        <h3>
                            <span>{{setCategoryName(205)}}</span>
                            {{setCategoryTag(205)}}
                        </h3>
                        <div class="prd_wrap">
                            <ul id="lyrItemlist" class="item_list"><!-- target의 ID 지정 -->
                                <li v-for="(item, idx) in sixthItems">
                                    <a href="javascript:void(0);" @click="prdDetailPage(item.itemid)" :class="'sixthItems' + item.itemid">
                                        <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/pc/nov/tenbyten_thumbnail.jpg" alt=""></div>
                                        <div class="desc">
                                            <p class="name"></p>
                                            <div class="price"><s></s><span class="sale"></span></div>
                                        </div>
                                    </a>
                                </li>
                            </ul>
                        </div>
                        <div class="ten_mask" v-if="showMask(sixthItems)">
                            <a v-if="showMask(sixthItems)" href="javascript:void(0);" class="btn_more" @click="moreItem($event, 6)">
                                <img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/pc/nov/btn_more.png" alt="">
                            </a>
                        </div>
                    </div>
                    <div :style="seventhStyle">
                        <h3>
                            <span>{{setCategoryName(206)}}</span>
                            {{setCategoryTag(206)}}
                        </h3>
                        <div class="prd_wrap">
                            <ul id="lyrItemlist" class="item_list"><!-- target의 ID 지정 -->
                                <li v-for="(item, idx) in seventhItems">
                                    <a href="javascript:void(0);" @click="prdDetailPage(item.itemid)" :class="'seventhItems' + item.itemid">
                                        <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/pc/nov/tenbyten_thumbnail.jpg" alt=""></div>
                                        <div class="desc">
                                            <p class="name"></p>
                                            <div class="price"><s></s><span class="sale"></span></div>
                                        </div>
                                    </a>
                                </li>
                            </ul>
                        </div>
                        <div class="ten_mask" v-if="showMask(seventhItems)">
                            <a v-if="showMask(seventhItems)" href="javascript:void(0);" class="btn_more" @click="moreItem($event, 7)">
                                <img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/pc/nov/btn_more.png" alt="">
                            </a>
                        </div>
                    </div>
                    <div :style="eighthStyle">
                        <h3>
                            <span>{{setCategoryName(207)}}</span>
                            {{setCategoryTag(207)}}
                        </h3>
                        <div class="prd_wrap">
                            <ul id="lyrItemlist" class="item_list"><!-- target의 ID 지정 -->
                                <li v-for="(item, idx) in eighthItems">
                                    <a href="javascript:void(0);" @click="prdDetailPage(item.itemid)" :class="'eighthItems' + item.itemid">
                                        <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/pc/nov/tenbyten_thumbnail.jpg" alt=""></div>
                                        <div class="desc">
                                            <p class="name"></p>
                                            <div class="price"><s></s><span class="sale"></span></div>
                                        </div>
                                    </a>
                                </li>
                            </ul>
                        </div>
                        <div class="ten_mask" v-if="showMask(eighthItems)">
                            <a v-if="showMask(eighthItems)" href="javascript:void(0);" class="btn_more" @click="moreItem($event, 8)">
                                <img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/pc/nov/btn_more.png" alt="">
                            </a>
                        </div>
                    </div>
                </div>
            </section>
        </section>
    `
    , created() {
        const _this = this;
        _this.$store.dispatch('GET_CATEGORIES_ITEMS');
    }
    , updated() {
        const _this = this;
        _this.$nextTick(function() {
            var swiper = new Swiper(".slide_brand", {
                autoplay: {
                    delay:0,
                    disableOnInteraction:false,
                },
                speed: 5000,
                slidesPerView:'auto',
                loop:true,
                autoHeight :true,
            });
        
            var swiper = new Swiper(".slide_brand02", {
                autoplay: {
                    delay:0,
                    disableOnInteraction:false,
                },
                speed: 5000,
                slidesPerView:'auto',
                loop:true,
                autoHeight :true,
            });
        })
    }
    , mounted() {
        
    }
    , data() {
        return {
            categoryItems: []
        }
    }
    , computed : {
        firstItems() { 
            const items = this.$store.getters.firstItems;
            this.setItemInit('firstItems', items);
            return this.$store.getters.firstItems;
        },
        secondItems() { 
            const items = this.$store.getters.secondItems;
            this.setItemInit('secondItems', items);
            return this.$store.getters.secondItems 
        },
        thirdItems() { 
            const items = this.$store.getters.thirdItems;
            this.setItemInit('thirdItems', items);
            return this.$store.getters.thirdItems 
        },
        fourthItems() { 
            const items = this.$store.getters.fourthItems;
            this.setItemInit('fourthItems', items);
            return this.$store.getters.fourthItems 
        },
        fifthItems() { 
            const items = this.$store.getters.fifthItems;
            this.setItemInit('fifthItems', items);
            return this.$store.getters.fifthItems 
        },
        sixthItems() { 
            const items = this.$store.getters.sixthItems;
            this.setItemInit('sixthItems', items);
            return this.$store.getters.sixthItems 
        },
        seventhItems() { 
            const items = this.$store.getters.seventhItems;
            this.setItemInit('seventhItems', items);
            return this.$store.getters.seventhItems 
        },
        eighthItems() { 
            const items = this.$store.getters.eighthItems;
            this.setItemInit('eighthItems', items);
            return this.$store.getters.eighthItems 
        },
        firstStyle() {
            if (this.$store.getters.firstItems.length <= 4) {
                return {
                    'margin-bottom': '10vw'  
                };
            } else {
                return '';
            }
        },
        secondStyle() {
            if (this.$store.getters.secondItems.length <= 4) {
                return {
                    'margin-bottom': '10vw'  
                };
            } else {
                return '';
            }
        },
        thirdStyle() {
            if (this.$store.getters.thirdItems.length <= 4) {
                return {
                    'margin-bottom': '10vw'  
                };
            } else {
                return '';
            }
        },
        fourthStyle() {
            if (this.$store.getters.fourthItems.length <= 4) {
                return {
                    'margin-bottom': '10vw'  
                };
            } else {
                return '';
            }
        },
        fifthStyle() {
            if (this.$store.getters.fifthItems.length <= 4) {
                return {
                    'margin-bottom': '10vw'  
                };
            } else {
                return '';
            }
        },
        sixthStyle() {
            if (this.$store.getters.sixthItems.length <= 4) {
                return {
                    'margin-bottom': '10vw'  
                };
            } else {
                return '';
            }
        },
        seventhStyle() {
            if (this.$store.getters.seventhItems.length <= 4) {
                return {
                    'margin-bottom': '10vw'  
                };
            } else {
                return '';
            }
        },
        eighthStyle() {
            if (this.$store.getters.eighthItems.length <= 4) {
                return {
                    'margin-bottom': '10vw'  
                };
            } else {
                return '';
            }
        },
        curationText() {
            let text = "";
            let now = new Date().getTime();
            let startDay1 = new Date(2022, 10, 7, 00, 00, 00).getTime();
            let endDay1 = new Date(2022, 10, 7, 23, 59, 59).getTime();
            let startDay2 = new Date(2022, 10, 8, 00, 00, 00).getTime();
            let endDay2 = new Date(2022, 10, 8, 23, 59, 59).getTime();
            let startDay3 = new Date(2022, 10, 9, 00, 00, 00).getTime();
            let endDay3 = new Date(2022, 10, 9, 23, 59, 59).getTime();
            let startDay4 = new Date(2022, 10, 10, 00, 00, 00).getTime();
            let endDay4 = new Date(2022, 10, 10, 23, 59, 59).getTime();
            let startDay5 = new Date(2022, 10, 11, 00, 00, 00).getTime();
            let endDay5 = new Date(2022, 10, 11, 23, 59, 59).getTime();
            let startDay6 = new Date(2022, 10, 12, 00, 00, 00).getTime();
            let endDay6 = new Date(2022, 10, 12, 23, 59, 59).getTime();
            let startDay7 = new Date(2022, 10, 13, 00, 00, 00).getTime();
            let endDay7 = new Date(2022, 10, 13, 23, 59, 59).getTime();
            let startDay8 = new Date(2022, 10, 14, 00, 00, 00).getTime();
            let endDay8 = new Date(2022, 10, 14, 23, 59, 59).getTime();
            let startDay9 = new Date(2022, 10, 15, 00, 00, 00).getTime();
            let endDay9 = new Date(2022, 10, 15, 23, 59, 59).getTime();
            let startDay10 = new Date(2022, 10, 16, 00, 00, 00).getTime();
            let endDay10 = new Date(2022, 10, 16, 23, 59, 59).getTime();
            if (now >= startDay1 && now <= endDay1) {
                text = "힘이 나는 월요일";
            } else if (now >= startDay2 && now <= endDay2) {
                text = "11월 8일";
            } else if (now >= startDay3 && now <= endDay3) {
                text = "우리가 사랑하는 수요일";
            } else if (now >= startDay4 && now <= endDay4) {
                text = "11월 10일";
            } else if (now >= startDay5 && now <= endDay5) {
                text = "평화로운 금요일";
            } else if (now >= startDay6 && now <= endDay6) {
                text = "쇼핑하기 좋은 토요일";
            } else if (now >= startDay7 && now <= endDay7) {
                text = "나른한 일요일";
            } else if (now >= startDay8 && now <= endDay8) {
                text = "새롭게 찾아온 월요일";
            } else if (now >= startDay9 && now <= endDay9) {
                text = "딱 하루 남았어요";
            } else if (now >= startDay10 && now <= endDay10) {
                text = "세일 마지막 날!";
            } 
            return text;
        }
    },
    methods : {
        setCategoryName(code) {
            let name = '';
            switch(code) {
                case 200: name = 'Only 텐바이텐'; break;
                case 201: name = '텐텐다이어리'; break;
                case 202: name = '텐텐상점'; break;
                case 203: name = '텐텐하우스'; break;
                case 204: name = '텐텐전자'; break;
                case 205: name = '텐텐패션'; break;
                case 206: name = '해외직구'; break;
                case 207: name = '해외문구'; break;
            }
            return name;
        },
        setCategoryTag(code) {
            let name = '';
            switch(code) {
                case 200: name = '#산리오 #스누피 #디즈니'; break;
                case 201: name = '#2023다이어리 #데일리 #플래너'; break;
                case 202: name = '#문구템 #감성다꾸 #감성키링'; break;
                case 203: name = '#집콕템 #살림템 #차량용품'; break;
                case 204: name = '#필카 #닌텐도 #폰꾸'; break;
                case 205: name = '#포인트템 #겨울잠옷 #신상백'; break;
                case 206: name = '#미리크리스마스 #희귀소품샵'; break;
                case 207: name = '#세련된 #미도리 #하이타이드'; break;
            }
            return name;
        },
        /**
         * 상품 정보 연동
         * @param target 클래스명
         * @param items 상품아이디
         * @param fields 상품 정보 필드명
         */
         setItemInfo(target, items, fields){
            fnApplyItemInfoEach({
                items: items,
                target: target,
                fields:fields,
                unit:"none",
                saleBracket:false
            });
        },
        setItemInit(target, e) {
            const _this = this;
            let items = e.map(i => i.itemid);
            _this.setItemInfo(target, items, ["image", "name", "price", "sale"]);
        },
        showMask(items) {
            let isShow = false;
            if (items != null && items.length > 8) {
                isShow = true;
            }
            return isShow;
        },
        moreItem(e, index) {
            const _target = e.target;
            $(_target).parent().parent().siblings('.prd_wrap').find('ul').addClass('more');
            $(_target).parent().parent('.ten_mask').addClass('more');
            $(_target).parent().parent().siblings('.prd_wrap').find('li:hidden').slice(0, 8).show(); 
            if ($(_target).parent().parent().siblings('.prd_wrap').find('li:hidden').length == 0) { 
                $(_target).parent().parent('.ten_mask').hide();
                $(_target).parent().parent().siblings('.prd_wrap').find('ul').css('paddingBottom','80px')
            } 
            fnAmplitudeEventAction('click_monthlyten_item_seemore', 'groupnumber', index);
        },
        /**
         * 상품상세 페이지 이동
         * @param itemid
         */
         prdDetailPage(itemid){
            location.href = "/shopping/category_prd.asp?itemid=" + itemid + "&petr="+this.eventCode;
        },
        swiperCount(number) {
            const _this = this;
            let result = 0;
            let standard = _this.$store.getters.brands.length;
            let value = standard / 2;
            let remainder = standard % 2;
            result = value * number + remainder;
            return result;
        }
    }
});