Vue.component('BENEFIT', {
    template : `
        <section id="tab01" class="tab01">
            <!-- 4가지 혜택 -->
            <section class="section01_1">
                <img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/pc/nov/section02_1.jpg" alt="">
            </section>
            <!-- 세일 브랜드 수정ver7 클래스명 수정 -->
            <section class="section01_1_brand" id="link02">
                <h2><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/pc/nov/title07.png" alt=""></h2>
                <div class="brand_wrap">
                    <div class="slide_brand swiper-container">
                        <div class="swiper-wrapper">
                            <div class="swiper-slide">
                                <a href="/street/street_brand_sub06.asp?makerid=nintendo10" @click="brandAmplitude('nintendo10')">
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/nov/nintendo10.png" alt="">
                                </a>
                            </div>
                            <div class="swiper-slide">
                                <a href="/street/street_brand_sub06.asp?makerid=kodak01" @click="brandAmplitude('kodak01')">
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/nov/kodak01.png" alt="">
                                </a>
                            </div>
                            <div class="swiper-slide">
                                <a href="/street/street_brand_sub06.asp?makerid=kakaofriends1010" @click="brandAmplitude('kakaofriends1010')">
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/nov/kakaofriends1010.png" alt="">
                                </a>
                            </div>
                            <div class="swiper-slide">
                                <a href="/street/street_brand_sub06.asp?makerid=oa" @click="brandAmplitude('oa')">
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/nov/oa.png" alt="">
                                </a>
                            </div>
                            <div class="swiper-slide">
                                <a href="/street/street_brand_sub06.asp?makerid=bbluekorea" @click="brandAmplitude('bbluekorea')">
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/nov/bbluekorea.png" alt="">
                                </a>
                            </div>
                            <div class="swiper-slide">
                                <a href="/street/street_brand_sub06.asp?makerid=bleoh22" @click="brandAmplitude('bleoh22')">
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/nov/bleoh22.png" alt="">
                                </a>
                            </div>
                            <div class="swiper-slide">
                                <a href="/street/street_brand_sub06.asp?makerid=midori2" @click="brandAmplitude('midori2')">
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/nov/midori2.png" alt="">
                                </a>
                            </div>
                            <div class="swiper-slide">
                                <a href="/street/street_brand_sub06.asp?makerid=HIGHTIDE" @click="brandAmplitude('HIGHTIDE')">
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/nov/HIGHTIDE.png" alt="">
                                </a>
                            </div>
                            <div class="swiper-slide">
                                <a href="/street/street_brand_sub06.asp?makerid=sanrio10x10" @click="brandAmplitude('sanrio10x10')">
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/nov/sanrio10x10.png" alt="">
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="slide_brand02 swiper-container" dir="rtl">
                        <div class="swiper-wrapper">
                            <div class="swiper-slide">
                                <a href="/street/street_brand_sub06.asp?makerid=peanuts10x10" @click="brandAmplitude('peanuts10x10')">
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/nov/peanuts10x10.png" alt="">
                                </a>
                            </div>
                            <div class="swiper-slide">
                                <a href="/street/street_brand_sub06.asp?makerid=disney10x10" @click="brandAmplitude('disney10x10')">
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/nov/disney10x10.png" alt="">
                                </a>
                            </div>
                            <div class="swiper-slide">
                                <a href="/street/street_brand_sub06.asp?makerid=livework" @click="brandAmplitude('livework')">
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/nov/livework.png" alt="">
                                </a>
                            </div>
                            <div class="swiper-slide">
                                <a href="/street/street_brand_sub06.asp?makerid=dailylike" @click="brandAmplitude('dailylike')">
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/nov/dailylike.png" alt="">
                                </a>
                            </div>
                            <div class="swiper-slide">
                                <a href="/street/street_brand_sub06.asp?makerid=motemote10" @click="brandAmplitude('motemote10')">
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/nov/motemote10.png" alt="">
                                </a>
                            </div>
                            <div class="swiper-slide">
                                <a href="/street/street_brand_sub06.asp?makerid=judigital" @click="brandAmplitude('judigital')">
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/nov/judigital.png" alt="">
                                </a>
                            </div>
                            <div class="swiper-slide">
                                <a href="/street/street_brand_sub06.asp?makerid=pis935310" @click="brandAmplitude('pis935310')">
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/nov/pis935310.png" alt="">
                                </a>
                            </div>
                            <div class="swiper-slide">
                                <a href="/street/street_brand_sub06.asp?makerid=wigglewiggle" @click="brandAmplitude('wigglewiggle')">
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/nov/wigglewiggle.png" alt="">
                                </a>
                            </div>
                            <div class="swiper-slide">
                                <a href="/street/street_brand_sub06.asp?makerid=ithinkso" @click="brandAmplitude('ithinkso')">
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/nov/ithinkso.png" alt="">
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <!-- 깜짝 특가 11/8, 15 노출 -->
            <section class="section01_4"  v-if="showSurprizeSale">
                <div class="prd_evt">
                    <!-- 11월8일 오픈 -->
                    <p v-if="showSurprizeFirstItem">
                        <a href="javascript:void(0);" @click="surprizeAmplitude(4958612)">
                            <img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/pc/nov/section05_1.png" alt="">
                        </a>
                    </p>
                    <!-- 11월15일 오픈 -->
                    <p v-if="showSurprizeSecondItem">
                        <a href="javascript:void(0);" @click="surprizeAmplitude(4490128)">
                            <img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/pc/nov/section05_2.png" alt="">
                        </a>
                    </p>
                </div>
            </section>
            <!-- 오늘의 큐레이션 -->
            <section class="section01_2_today">
                <p class="top_text">{{curationText}}</p>
                <h2><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/pc/nov/title08.png?v=2" alt=""></h2>
                <div class="prd_wrap">
                    <ul id="lyrItemlist" class="item_list">
                        <li v-for="(item, index) in items">
                            <a :href="'/shopping/category_prd.asp?itemid='+item.eventid" :class="'itemInfo'+item.eventid" @click="curationAmplitude(item.eventid, index+1)">
                                <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/pc/nov/tenbyten_thumbnail.jpg" alt=""></div>
                                <div class="desc">
                                    <p class="name"></p>
                                    <div class="price"><s></s><span class="sale"></span></div>
                                </div>
                            </a>
                        </li>
                    </ul>
                </div>
            </section>
            <!-- 4가지 혜택 수정ver7 클래스명, 이미지 수정 -->
            <section class="section01_1_benefit">
                <img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/pc/nov/section02_2.jpg" alt="">
                <p class="top_text"><span class="name">{{userName}}</span>님을 위한</p>
                <div class="benefit_list">
                    <a href="#link01" @click="benefitAmplitude(1)"></a>
                    <a href="#tab02" @click="benefitAmplitude(2)"></a>
                    <a href="#link03" @click="benefitAmplitude(3)"></a>
                    <a href="#link03" @click="benefitAmplitude(4)"></a>
                </div>
            </section>
            <!-- 쿠폰팩 -->
            <section class="section01_2" id="link01">
                <img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/pc/nov/section03.jpg?v=3" alt="">
                <!-- 쿠폰 다운로드 -->
                <p class="btn_download"><a href="javascript:void(0);" @click="couponDownloadCheck"></a></p>
            </section>
            
            <!-- 깜짝 마일리지 11/9-10, 16 노출 -->
            <section class="section01_5" v-if="showMileage">
                <img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/pc/nov/section06.jpg?v=3" alt="">
                <p class="btn_mileage">
                    <a href="javascript:void(0);" @click="movePage('mileage')" ></a>
                </p>
                <div class="date">
                    <!-- 11월9-10일 -->                    
                    <img v-if="firstShowMileage" src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/pc/nov/mileage01_2.png?v=2" alt="" class="date01_2">
                    <img v-if="firstShowMileage" src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/pc/nov/mileage01.png?v=2" alt="" class="date01">
          
                    <!-- 11월15일 카피 -->
                    <img v-if="firstShowMileageOfCopy" src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/pc/nov/mileage02_2.png?v=3" alt="" class="date02_2">
                    <!-- 11월16일 카피 -->
                    <img v-if="secondShowMileageOfCopy" src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/pc/nov/mileage02_3.png" alt="" class="date02_3">
                    <img v-if="secondShowMileage" src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/pc/nov/mileage02.png?v=3" alt="" class="date02">
                </div>
            </section>
            <!-- 무료배송 데이 11/7-8, 14 노출 -->
            <section class="section01_6" v-if="showFreeDelivery">
                <img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/pc/nov/section07.jpg?v=3" alt="">
                <div class="free_wrap">
                    <div class="swiper freeSwiper">
                        <div class="swiper-wrapper">
                            <div class="swiper-slide" v-for="(item, index) in freeDelivery">
                                <a href="javascript:void(0)" @click="freeDeliveryAmplitude(item.eventid)">
                                    <img :src="item.imageurl" alt="">
                                </a>    
                            </div>
                        </div>
                    </div>
                    <div class="swiper-button-next"></div>
                    <div class="swiper-button-prev"></div>
                </div>
                <button @click="moveFreeDelivery()"></button>  
                <div class="date">
                    <!-- 11월7-8일 -->                    
                    <img v-if="firstShowFreeDelivery" src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/pc/nov/free01_2.png?v=2" alt="" class="date01_2">
                    <img v-if="firstShowFreeDelivery" src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/pc/nov/free01.png?v=2" alt="" class="date01">
                    <!-- 11월14일 -->                    
                    <img v-if="secondShowFreeDelivery" src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/pc/nov/free02_2.png?v=2" alt="" class="date02_2">
                    <img v-if="secondShowFreeDelivery" src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/pc/nov/free02.png?v=2" alt="" class="date02">
                </div>     
            </section>
            <!-- 텐텐다꾸로 이동 -->
            <section class="section01_3">
                <p><a href="/diarystory2023/index.asp" @click="diaryBannerAmplitude"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/pc/nov/go_daccu.jpg?v=2" alt=""></a></p>
            </section>
            <div class="popup">
                <div class="bg_dim">
                    <div class="pop pop01">
                        <img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/pc/nov/popup.png" alt="">
                        <div class="check" @click="agreeAlert">
                            <img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/pc/nov/check01.png" alt="" class="check01">
                            <img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/pc/nov/check02.png" alt="" class="check02">
                        </div>
                        <a href="javascript:void(0)" @click="couponDownload" class="btn_coupon"></a>
                        <a href="javascript:void(0)" @click="couponPopupClose" class="btn_close"></a>
                    </div>
                </div>
            </div>
        </section>
    `
    , created() {
        const _this = this;
        _this.$store.dispatch('GET_SALE_INFOS');
        _this.isUserLoginOK = isUserLoginOK;
        _this.$store.dispatch('GET_FREE_DELIVERY');
        _this.$store.dispatch('GET_ITEMS');
    }
    , data() {
        return {
            itemList: [],
            isUserLoginOK: false,
            smsYn: "N"
        }
    }
    , mounted() {
        const _this = this;
        _this.$nextTick(function() {
            // link smooth 이동 
            $('.tab-area').on('click', 'a[href^="#"]', function (event) {
                var tabHeight = $('.tab-area').outerHeight();
                event.preventDefault();
                $('html, body').animate({
                    scrollTop: $($.attr(this, 'href')).offset().top - tabHeight
                }, 500);
            });
        })
        
    }
    ,updated() {
        const _this = this;
        _this.$nextTick(function() {
            // 무료배송 데이
            var swiper = new Swiper(".freeSwiper", {
                slidesPerView: 3,
                loop:true,
                spaceBetween:16,  
                autoplay:true,	
                navigation: {
                nextEl: ".swiper-button-next",
                prevEl: ".swiper-button-prev",
                },
            });

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
    , computed : {
        saleInfos() {
            return this.$store.getters.saleInfos;
        },
        showSurprizeSale() {
            if (this.showSurprizeFirstItem || this.showSurprizeSecondItem) {
                return true;
            } else {
                return false;
            }
        },
        showSurprizeFirstItem() {
            let now = new Date().getTime();
            let startDay = new Date(2022, 10, 8, 00, 00, 00).getTime();
            let endDay = new Date(2022, 10, 8, 23, 59, 59).getTime();
            
            if (now >= startDay && now <= endDay) {
                return true;
            } else {
                return false;
            }
        },
        showSurprizeSecondItem() {
            let now = new Date().getTime();
            let startDay = new Date(2022, 10, 15, 00, 00, 00).getTime();
            let endDay = new Date(2022, 10, 15, 23, 59, 59).getTime();
            if (now >= startDay && now <= endDay) {
                return true;
            } else {
                return false;
            }
        },
        freeDelivery() {
            return this.$store.getters.freeDelivery;
        },
        showMileage() {
            const _this = this;
            if (_this.firstShowMileage || _this.secondShowMileage) {
                return true;
            } else {
                return false;
            }
        },
        firstShowMileage() {
            let now = new Date().getTime();
            let startDay = new Date(2022, 10, 9, 00, 00, 00).getTime();
            let endDay = new Date(2022, 10, 10, 23, 59, 59).getTime();
            
            if (now >= startDay && now <= endDay) {
                return true;
            } else {
                return false;
            }
        },
        secondShowMileage() {
            let now = new Date().getTime();
            let startDay = new Date(2022, 10, 15, 00, 00, 00).getTime();
            let endDay = new Date(2022, 10, 16, 23, 59, 59).getTime();
            if (now >= startDay && now <= endDay) {
                return true;
            } else {
                return false;
            }
        },
        firstShowMileageOfCopy() {
            let now = new Date().getTime();
            let startDay = new Date(2022, 10, 15, 00, 00, 00).getTime();
            let endDay = new Date(2022, 10, 15, 23, 59, 59).getTime();
            if (now >= startDay && now <= endDay) {
                return true;
            } else {
                return false;
            }
        },
        secondShowMileageOfCopy() {
            let now = new Date().getTime();
            let startDay = new Date(2022, 10, 16, 00, 00, 00).getTime();
            let endDay = new Date(2022, 10, 16, 23, 59, 59).getTime();
            if (now >= startDay && now <= endDay) {
                return true;
            } else {
                return false;
            }
        },
        showFreeDelivery() {
            const _this = this;
            if (_this.firstShowFreeDelivery || _this.secondShowFreeDelivery) {
                return true;
            } else {
                return false;
            }
        },
        firstShowFreeDelivery() {
            let now = new Date().getTime();
            let startDay = new Date(2022, 10, 7, 00, 00, 00).getTime();
            let endDay = new Date(2022, 10, 8, 23, 59, 59).getTime();
            
            if (now >= startDay && now <= endDay) {
                return true;
            } else {
                return false;
            }
        },
        secondShowFreeDelivery() {
            let now = new Date().getTime();
            let startDay = new Date(2022, 10, 14, 00, 00, 00).getTime();
            let endDay = new Date(2022, 10, 14, 23, 59, 59).getTime();
            if (now >= startDay && now <= endDay) {
                return true;
            } else {
                return false;
            }
        },
        getUserName() {
            return userName;
        },
        items() {
            const _this = this;
            let itemInfo = _this.$store.getters.items
            _this.setItemInit('itemInfo', itemInfo);
            return itemInfo;
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
        /**
         * 상품상세 페이지 이동
         * @param itemid
         */
         prdDetailPage(itemid){
            location.href = "/shopping/category_prd.asp?itemid=" + itemid + "&petr=monthlyten";
        },
        couponDownload() {
            const _this = this;
            let apiData = {
                bonusCoupons: "2282,2281"
            }
            const success = function(data) {
                if (data === 0) {
                    alert("쿠폰이 발급되었습니다. 11월 16일까지 사용하세요!");
                } else if (data === 1) {
                    alert("쿠폰 지급 시 문제가 발생했습니다.");
                } else if (data === 2) {
                    alert("발급받을 쿠폰이 없습니다.");
                } else {
                    alert("이미 모든 쿠폰을 발급받으셨습니다.");
                }
            }
            const error = function(data) {
                if (data.code === -10) {
                    alert("로그인이 필요한 서비스 입니다. 로그인 페이지로 이동합니다.");
                    _this.moveLoginPage();
                }
            }
            if (_this.isUserLoginOK) {
                call_api('GET', '/event/bonus-coupon-all-download', apiData, success, error);
                if (_this.smsYn === 'Y' ) {
                    _this.go_smart_alarm();
                }
            } else {
                alert("로그인이 필요한 서비스 입니다. 로그인 페이지로 이동합니다.");
                _this.moveLoginPage();
            }
        },
        async couponDownloadCheck() {
            const _this = this;
            fnAmplitudeEventAction('click_monthlyten_coupon', '', '');
            let checkSmartAlarm = await _this.check_smart_alarm();
            if (_this.isUserLoginOK) {
                if (checkSmartAlarm) {
                    _this.couponDownload();
                } else {
                    _this.showCouponPopup();
                }
            } else {
                alert("로그인이 필요한 서비스 입니다. 로그인 페이지로 이동합니다.");
                _this.moveLoginPage();
            }
        },
        check_smart_alarm() {
            const _this = this;
            return new Promise(function(resolve, reject) {
                call_api("GET", "/user/my-sns-receive-state", {}, function (data) {
                    resolve(data);
                })
            })
        },
        agreeAlert(e) {
            const _this = this;
            $(e.target).parent().toggleClass("on");
            let check = document.getElementsByClassName('on');
            if (check.length) {
                _this.smsYn = 'Y';
            } else {
                _this.smsYn = 'N';
            }
        },
        // 스마트 알람 조회
        go_smart_alarm() {
            call_api("PUT", "/user/smart-alarm", {}, function (data) {
                return data;
            })
        },
        showCouponPopup() {
            fnAmplitudeEventActionJsonData('view_monthlyten_coupon_popup', JSON.stringify(''));
            $('.monthly_ten .popup .bg_dim').show();
            $('.monthly_ten .popup .pop01').show();
        },
        couponPopupClose() {
            $('.monthly_ten .popup .bg_dim').hide();
            $('.monthly_ten .popup .pop01').hide();
        },
        popupCouponDownload() {
            const _this = this;
            let data = {
                "checkbox" : _this.smsYn
            }
            fnAmplitudeEventActionJsonData('view_monthlyten_coupon_popup', JSON.stringify(data));
            _this.couponDownload();
        },
        moveLoginPage() {
            location.href = '/login/loginpage.asp?vType=G';
        },
        movePage(type) {
            let url = "";
            if (type === 'mileage') {
                url = "/my10x10/mymileage.asp?dType=B";
                fnAmplitudeEventAction('click_monthlyten_mileage', '', '');
            } else {
                url = "/event/eventmain.asp?eventid=120550";
            }
            location.href = url;
        },
        moveFreeDelivery() {
            const _this = this;
            fnAmplitudeEventAction('click_monthlyten_freedelivery_button', '', '');
            if (_this.firstShowFreeDelivery) {
                location.href = "/event/eventmain.asp?eventid=120898";
            } else {
                location.href = "/event/eventmain.asp?eventid=121202";
            }
        },
        setItemInit(target, e) {
            const _this = this;
            let items = e.map(i => i.eventid);
            _this.setItemInfo(target, items, ["image", "name", "price", "sale"]);
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
        benefitAmplitude(index) {
            fnAmplitudeEventAction('click_monthlyten_benefit', 'num', index);
        },
        curationAmplitude(itemId, index) {
            fnAmplitudeEventAction('click_monthlyten_curation', 'num|item_id', index + '|' + itemId);
        },
        surprizeAmplitude(itemId) {
            fnAmplitudeEventAction('click_monthlyten_lowprice', '', '');
            this.prdDetailPage(itemId)
        },
        freeDeliveryAmplitude(itemId) {
            fnAmplitudeEventAction('click_monthlyten_freedelivery', 'item_id', itemId);
            this.prdDetailPage(itemId)
        },
        brandAmplitude(brandId) {
            fnAmplitudeEventAction('click_monthlyten_brand', 'brandname', brandId);
        },
        diaryBannerAmplitude() {
            fnAmplitudeEventAction('click_monthlyten_banner', '', '');
        }
    }
});