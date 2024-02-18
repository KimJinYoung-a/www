const app = new Vue({
    el : '#app',
    store: store,
    template : `
                <div class="monthlyten">
                    <section class="top">
                        <div class="top01" v-if="showTopImageViewDayCheck1">
                            <p class="rabbit"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthten/2301/rabbit.png" alt=""></p>
                        </div>
                        <div class="top02" v-if="showTopImageViewDayCheck2">
                            <p class="rabbit"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthten/2301/rabbit02.png" alt=""></p>
                        </div>
                        <div class="top03" v-if="showTopImageViewDayCheck3">
                            <p class="rabbit"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthten/2301/rabbit03.png" alt=""></p>
                        </div>
                    </section>
                    <rabbit-item></rabbit-item>
                    <benefit-info></benefit-info>
                    <saleItem></saleItem>
                    <eventList></eventList>
                    <div class="tab-area">
                        <div class="tab01"><a href="#tab01" @click="clickTabMenu(1)">오늘만<br>특가</a></div>
                        <div class="tab02"><a href="#tab02" @click="clickTabMenu(2)">1월의<br>혜택</a></div>
                        <div class="tab03"><a href="#tab03" @click="clickTabMenu(3)">1월의<br>세일 상품</a></div>
                        <div class="tab04"><a href="#tab04" @click="clickTabMenu(4)">1월의<br>이벤트</a></div>
                        <div class="tab05"><a href="javascript:void(0);" @click="clickTabMenu(5)"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthten/2301/sidebar_present.png" alt=""></a></div>
                        <div class="tab06"><a href="javascript:void(0);" @click="clickTabMenu(6)"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthten/2301/sidebar_best.png" alt=""></a></div>
                    </div>
                    <!-- 팝업 -->
                    <div class="dim" style="display:none;"></div>
                    <div class="popup pop01" style="display:none;">
                        <h2><li>앗!</li><li>스마트 수신동의가 되어 있지 않아요.</li></h2>
                        <p class="txt01">다음 쿠폰이 오픈되면​ 문자/메일로 알려드릴까요?</p>
                        <a href="javascript:void(0);" @click="agreeAlert" class="btn_agree">동의하고 쿠폰 받기</a>
                        <a href="" class="btn_close"></a>
                    </div>
                    <div class="popup pop02" style="display:none;">
                        <h2>쿠폰팩이 지급되었습니다!</h2>
                        <p class="txt01">1월 16일까지 꼭 사용해보세요.</p>
                        <a href="" class="btn_close"></a>
                    </div>
                </div>
    `,
    data() {return {
        tabType : tabType,
        isUserLoginOK: false,
        smsYn: "N"
    }},
    created() {
        const _this = this;
        this.username = userName;
        _this.isUserLoginOK = isUserLoginOK;
        $(function(){
            var lastScroll = 0;
            $(window).scroll(function () {
                var header = $('.header-wrap').outerHeight();
                var tabHeight = $('.top').outerHeight() + $(".sec_brand").outerHeight();
                var fixHeight = tabHeight + header;
                var st = $(this).scrollTop();
        
                if (st > fixHeight) {
                    $('.tab-area').addClass('fixed')
                } else {
                    $('.tab-area').removeClass('fixed')
                }
        
                lastScroll = st;
        
                // 스크롤시 특정위치서 탭 활성화
                var scrollPos = $(document).scrollTop();
                $('.tab-area a').each(function () {
                    var tab01 = $('#tab01');
                    var tab02 = $('#tab02');
                    var tab03 = $('#tab03');
                    var tab04 = $('#tab04');
                    if (tab01.position().top <= scrollPos + 100 && tab01.position().top + tab01.height() >= scrollPos + 100) {
                        $('.tab-area div').removeClass("on");
                        $('.tab01').addClass("on");
                    }
                    else if (tab02.position().top <= scrollPos + 100 && tab02.position().top + tab02.height() >= scrollPos + 100) {
                        $('.tab-area div').removeClass("on");
                        $('.tab02').addClass("on");
                    }
                    else if (tab03.position().top <= scrollPos + 100 && tab03.position().top + tab03.height() >= scrollPos + 100) {
                        $('.tab-area div').removeClass("on");
                        $('.tab03').addClass("on");
                    }
                    else if (tab04.position().top <= scrollPos + 100 && tab04.position().top + tab04.height() >= scrollPos + 100) {
                        $('.tab-area div').removeClass("on");
                        $('.tab04').addClass("on");
                    }
                });
            });
        
            $('.tab-area').on('click', 'a[href^="#"]', function (event) {
                var header = $('#header').outerHeight();
                event.preventDefault();
                $('html, body').animate({
                    scrollTop: $($.attr(this, 'href')).offset().top - header + 1
                }, 500);
            });
        
            // 브랜드 
            var brandSwiper = new Swiper(".slide_brand .swiper-container", {
                autoplay: {
                    delay:0,
                    disableOnInteraction:false,
                },
                speed: 4000,
                slidesPerView:'auto',
                loop:true,
                autoHeight : true,
                centeredSlides :true
            });
            var brandSwiper02 = new Swiper(".slide_brand02 .swiper-container", {
                autoplay: {
                    delay:0,
                    disableOnInteraction:false,
                },
                speed: 4000,
                slidesPerView:'auto',
                loop:true,
                autoHeight :true,
                centeredSlides :true
            });

            // 혜택
            var i=0;
            setInterval(function(){
                i++;
                if(i>3){i=0;}
                $('.sec_benefit .benefit').removeClass('on')
                $('.sec_benefit .benefit').eq(i).addClass('on')
            },1000);

            fnAmplitudeEventAction('view_monthlyten_main', '', '');

            
        });
    },
    computed: {
        showTopImageViewDayCheck1() { //** 상단 이미지 */
            let now = sysdt;
            let startDay = new Date(2023, 0, 4, 0, 0, 0).getTime();
            let endDay = new Date(2023, 0, 8, 23, 59, 59).getTime();
            
            if (now >= startDay && now <= endDay) {
                return true;
            } else {
                return false;
            }
        },
        showTopImageViewDayCheck2() { //** 상단 이미지 */
            let now = sysdt;
            let startDay = new Date(2023, 0, 9, 0, 0, 0).getTime();
            let endDay = new Date(2023, 0, 11, 23, 59, 59).getTime();
            
            if (now >= startDay && now <= endDay) {
                return true;
            } else {
                return false;
            }
        },
        showTopImageViewDayCheck3() { //** 상단 이미지 */
            let now = sysdt;
            let startDay = new Date(2023, 0, 12, 0, 0, 0).getTime();
            let endDay = new Date(2024, 0, 12, 23, 59, 59).getTime();
            
            if (now >= startDay && now <= endDay) {
                return true;
            } else {
                return false;
            }
        },
    },
    updated() {
        
    },
    mounted() {
    },
    methods : {
        agreeAlert(e) {
            const _this = this;
            _this.smsYn = 'Y';
            fnAmplitudeEventAction('click_monthlyten_coupon_popup_click', '', '');
            _this.couponPopupClose();
            _this.couponDownload();
        },
        couponDownload() {
            const _this = this;
            let apiData = {
                //bonusCoupons: "4041,4042"
                bonusCoupons: "2389,2390"
            }
            const success = function(data) {
                if (data === 0) {
                    //alert("쿠폰이 발급되었습니다. 1월 16일까지 사용하세요!");
                    fnAmplitudeEventAction('click_monthlyten_coupon_popup_view', 'num', 'Y');
                    $('.monthlyten .pop02').show();
                } else if (data === 1) {
                    $('.monthlyten .dim').hide();
                    alert("쿠폰 지급 시 문제가 발생했습니다.");
                } else if (data === 2) {
                    $('.monthlyten .dim').hide();
                    alert("발급받을 쿠폰이 없습니다.");
                } else {
                    $('.monthlyten .dim').hide();
                    alert("이미 발급 받은 쿠폰입니다.");
                }
            }
            const error = function(data) {
                if (data.code === -10) {
                    alert("로그인이 필요한 서비스 입니다. 로그인 페이지로 이동합니다.");
                    _this.moveLoginPage();
                }
            }
            if (_this.isUserLoginOK) {  
                if (_this.smsYn === 'Y' ) {
                    _this.go_smart_alarm();
                }
                call_api('GET', '/event/bonus-coupon-all-download', apiData, success, error);
            } else {
                alert("로그인이 필요한 서비스 입니다. 로그인 페이지로 이동합니다.");
                _this.moveLoginPage();
            }
        },
        couponPopupClose() {
            $('.monthlyten .pop01').hide();
            $('.monthlyten .pop02').hide();
        },
        moveLoginPage() {
            location.href="/login/loginpage.asp?vType=G";
        },
        // 스마트 알람 조회
        go_smart_alarm() {
            call_api("PUT", "/user/smart-alarm", {}, function (data) {
                return data;
            })
        },
        clickTabMenu(num) {
            fnAmplitudeEventAction('click_monthlyten_sidemenu', 'num', num);
            if(num==5){
                location.href = '/event/heart_gift/index.asp';
            }
            if(num==6){
                location.href = '/award/awardlist.asp?atype=b&gaparam=main_menu_best';
            }
        },
    }
});