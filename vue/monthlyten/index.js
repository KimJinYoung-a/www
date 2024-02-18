
const app = new Vue({
    el : '#app',
    store: store,
    template : `
        <div class="monthly_ten">
            <section class="month_top">
                <img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/pc/nov/monthtop_back.jpg" alt="">
                <img class="monthtop" src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/pc/nov/monthtop1.png" alt="">
            </section>
            <section class="tab-area">
                <ul class="tab_wrap">
                    <p class="tab prd01"><a href="#tab01" @click="tabAmplitude(1)"><span>혜택</span></a></p>
                    <p class="tab prd02"><a href="#tab02" @click="tabAmplitude(2)"><span>특가</span></a></p>
                    <p class="tab prd03"><a href="#tab03" @click="tabAmplitude(3)"><span>이벤트</span></a></p>
                </ul>
            </section>
            <BENEFIT></BENEFIT>
            <SALE></SALE>
            <EVENT></EVENT>
            <!-- 텐텐다꾸 플로팅 배너 -->
            <div class="daccu_banner">
                <a href="javascript:void(0);" @click="closePopup" class="btn_close"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/pc/close_daccu.png" alt=""></a>
                <!-- 텐텐다꾸로 이동 -->
                <a href="/diarystory2023/index.asp" class="btn_daccu" @click="diaryAmplitude"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthTen/pc/daccu.png" alt=""></a>
            </div>
        </div>
    `,
    data() {return {
        tabType : tabType,
        floating : true
    }},
    created() {
        this.showFloating();
        this.initAmplitude();
    },
    mounted() {
        const _this = this;
        this.$nextTick(function() {
            // 상단 이미지 변경
            var i=1;
            setInterval(function(){
                i++;
                if(i>11){i=1;}
        		$('.monthly_ten .month_top .monthtop').attr("src","//webimage.10x10.co.kr/fixevent/event/2022/monthTen/pc/nov/monthtop"+i+".png?v=2");
            },500);

            // link smooth 이동 
		    $('.tab-area').on('click', 'a[href^="#"]', function (event) {
                var tabHeight = $('.tab-area').outerHeight();
                event.preventDefault();
                $('html, body').animate({
                    scrollTop: $($.attr(this, 'href')).offset().top - tabHeight
                }, 500);
            });

            $('.benefit_list').on('click', 'a[href^="#"]', function (event) {
                var tabHeight = $('.tab-area').outerHeight();
                event.preventDefault();
                $('html, body').animate({
                    scrollTop: $($.attr(this, 'href')).offset().top - tabHeight
                }, 500);
            });
            
            // 스크롤 이벤트
            var lastScroll = 0;
            $(window).scroll(function () {
                var tabHeight = $('.tab-area').outerHeight();
                var fixHeight = tabHeight;
                var st = $(this).scrollTop();
                var startFix = $('.tab01').offset().top - fixHeight;

                if (st > startFix) {
                    $('.tab-area').addClass('fixed').css('top', 0)
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
                    if (tab01.position().top <= scrollPos && tab01.position().top + tab01.height() >= scrollPos - 70) {
                        $('.tab-area .tab').removeClass("active");
                        $('.prd01').addClass("active");
                    }
                    else if (tab02.position().top <= scrollPos && tab02.position().top + tab02.height() >= scrollPos - 70) {
                        $('.tab-area .tab').removeClass("active");
                        $('.prd02').addClass("active");
                    }
                    else if (tab03.position().top <= scrollPos && tab03.position().top + tab03.height() >= scrollPos - 70) {
                        $('.tab-area .tab').removeClass("active");
                        $('.prd03').addClass("active");
                    }
                });

                // 다꾸 플로팅 배너 
                if ($('.tab-area').hasClass('fixed') && _this.floating) {
                    $('.daccu_banner').addClass('active');
                }else{
                    $('.daccu_banner').removeClass('active');
                }
            });

        });
    },
    methods : {
        closePopup() {
            $('.daccu_banner').removeClass('active');
            this.floating = false;
        }
        , showFloating() {
            let now = new Date();
            let diaryDay = new Date(2022, 8, 1, 10, 00 ,00);
            if (now.getTime() < diaryDay.getTime() ) {
                this.floating = false;
            }
        }
        , initAmplitude() {
            fnAmplitudeEventAction('view_monthlyten_main', '', '');
        }
        , tabAmplitude(index) {
            fnAmplitudeEventAction('click_monthlyten_tap', 'num', index);
        }
        , diaryAmplitude() {
            fnAmplitudeEventAction('click_monthlyten_floating', '', '');
        }
    }
});