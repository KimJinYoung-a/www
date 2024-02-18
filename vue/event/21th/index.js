
const app = new Vue({
    el : '#app',
    store: store,
    template : `
        <div class="anniversary">
            <section class="main" v-if="randomMainNumber === 0"></section>
            <section class="main02" v-if="randomMainNumber === 1">
                <img class="anni_top" src="//webimage.10x10.co.kr/fixevent/event/2022/anniversary/main01.jpg" alt="">
            </section>
            <section class="main03" v-if="randomMainNumber === 2"></section>
            <section class="tab-area">
                <ul class="tab_wrap">
                    <p class="tab prd01 active"><a href="#tab01"><span>텐텐혜택</span></a></p>
                    <p class="tab prd02"><a href="#tab02"><span>텐텐특가</span></a></p>
                    <p class="tab prd03"><a href="#tab03"><span>텐텐x유튜버</span></a></p>
                    <p class="tab prd04"><a href="#tab04"><span>이벤트</span></a></p>
                </ul>
            </section>
            <!-- 혜택 -->
            <BENEFIT></BENEFIT>
            <!-- 특가 -->
            <SPECIAL-PRICE></SPECIAL-PRICE>
            <!-- 텐텐x유튜버 -->
            <YOUTUBE></YOUTUBE>
            <!-- 이벤트 -->
            <EVENT></EVENT>
        </div>
    `,
    data() {return {
        tabType : tabType,
        mainNumber: -1
    }},
    created() {

    },
    computed: {
        randomMainNumber() {
            const _this = this;
            let nowDay = new Date().getTime();
            let showDay = new Date(2022, 09, 17, 00, 00, 00).getTime();
            let number = 2;
            if (nowDay > showDay) {
                number = 3;
            }
            _this.mainNumber = Math.floor(Math.random() * number);
            return _this.mainNumber;
        }
    },
    mounted() {
        const _this = this;
        _this.$nextTick(function() {
            $(window).scroll(function(){
                $('.youtube').each(function(){
                    var y = $(window).scrollTop() + $(window).height() + 5;
                    var imgTop = $(this).offset().top;
                    if(y > imgTop) {
                        $(this).addClass('on');
                    }
                });
            });

            var i=0;
            setInterval(function(){
                i++;
                if(i>7){i=1;}
                $('.anniversary .main02 .anni_top').attr("src","//webimage.10x10.co.kr/fixevent/event/2022/anniversary/main0"+i+".jpg");
            },800);

            // link smooth 이동 
		    $('.tab-area').on('click', 'a[href^="#"]', function (event) {
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
                    var tab04 = $('#tab04');
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
                    else if (tab04.position().top <= scrollPos && tab04.position().top + tab04.height() >= scrollPos - 70) {
                        $('.tab-area .tab').removeClass("active");
                        $('.prd04').addClass("active");
                    }
                    
                });
            });


        });
    },
    methods : {

    }
});