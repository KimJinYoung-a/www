
const app = new Vue({
    el : '#app',
    store: store,
    template : `
        <div class="ten_sale12">
            <section class="main">
                <div class="main01 main_div" v-if="randomMainNumber === 0">
                    <div class="talk">
                        <p class="talk01"><a href="javascript:void(0);" @click="prdDetailPage(3347216)"><img src="//webimage.10x10.co.kr/fixevent/event/2022/ten_sale12/talk01.png?v=1.02" alt=""></a></p>
                        <p class="talk02"><a href="javascript:void(0);" @click="prdDetailPage(4958612)"><img src="//webimage.10x10.co.kr/fixevent/event/2022/ten_sale12/talk02.png?v=1.02" alt=""></a></p>
                        <p class="talk03"><a href="javascript:void(0);" @click="prdDetailPage(4992530)"><img src="//webimage.10x10.co.kr/fixevent/event/2022/ten_sale12/talk03.png?v=1.02" alt=""></a></p>
                    </div>
                </div>	
                <div class="main02 main_div" v-if="randomMainNumber === 1">
                    <div class="talk">
                        <p class="talk01"><a href="javascript:void(0);" @click="prdDetailPage(4977125)"><img src="//webimage.10x10.co.kr/fixevent/event/2022/ten_sale12/talk04.png?v=1.02" alt=""></a></p>
                        <p class="talk02"><a href="javascript:void(0);" @click="prdDetailPage(4922428)"><img src="//webimage.10x10.co.kr/fixevent/event/2022/ten_sale12/talk05.png?v=1.02" alt=""></a></p>
                        <p class="talk03"><a href="javascript:void(0);" @click="prdDetailPage(4975399)"><img src="//webimage.10x10.co.kr/fixevent/event/2022/ten_sale12/talk06.png?v=1.02" alt=""></a></p>
                    </div>
                </div>	
                <div class="main03 main_div" v-if="randomMainNumber === 2">
                    <div class="talk">
                        <p class="talk01"><a href="javascript:void(0);" @click="prdDetailPage(4803913)"><img src="//webimage.10x10.co.kr/fixevent/event/2022/ten_sale12/talk07.png?v=1.02" alt=""></a></p>
                        <p class="talk02"><a href="javascript:void(0);" @click="prdDetailPage(4958612)"><img src="//webimage.10x10.co.kr/fixevent/event/2022/ten_sale12/talk08.png?v=1.02" alt=""></a></p>
                        <p class="talk03"><a href="javascript:void(0);" @click="prdDetailPage(5013330)"><img src="//webimage.10x10.co.kr/fixevent/event/2022/ten_sale12/talk09.png?v=1.02" alt=""></a></p>
                    </div>
                </div>								
                <a href="javascript:void(0);" @click="goForumPage()" class="go_gift"><img src="//webimage.10x10.co.kr/fixevent/event/2022/ten_sale12/go_gift.png" alt=""></a>
            </section>
            <just-one-day></just-one-day>
            <everyday-mileage></everyday-mileage>
            <present-item></present-item>
            <surprise></surprise>
            <app-benefit></app-benefit>
            <saleItem></saleItem>
            <section class="banner"><a href="javascript:void(0);" @click="goHeartGiftPage()"><img src="//webimage.10x10.co.kr/fixevent/event/2022/ten_sale12/banner.png" alt=""></a></section>
            <div class="tab-area">
                <div class="tab01"><a href="#tab01">오늘만<br>특가</a></div>
                <div class="tab02"><a href="#tab02">출석체크<br>이벤트<span id="daycheck">~4,500p</span></a></div>
                <div class="tab03"><a href="#tab03">선물<br>추천상품</a></div>
                <div class="tab04"><a href="#tab04">오늘의<br>깜짝선물<span id="surprisetxt">쿠폰 증정</span></a></div>
                <div class="tab05"><a href="#tab05">APP<br>전용혜택<span id="appbenefitcount">3</span></a></div>
                <div class="tab06"><a href="#tab06">세일상품<br>구경하기<span>~79%할인</span></a></div>
                <div class="tab07"><a href="javascript:void(0);" @click="goHeartGiftPage()"><img src="//webimage.10x10.co.kr/fixevent/event/2022/ten_sale12/gift.png" alt=""></a></div>
            </div>
            <div class="pop_noti" style="display:none;">
                <div class="noti_info">
                    <button class="btn_close"><i class="i_close"></i>모달닫기</button>
                    <h3>이벤트 유의사항</h3>
                    <ul>
                        <li>본 이벤트는 하루에 한 번씩 참여 가능합니다.</li>
                        <li>이벤트가 종료되면 더 이상 참여가 불가합니다.</li>
                        <li>지급된 마일리지는 스페셜 마일리지로 2022년 12월 31일 23:59:59까지 사용 가능합니다. 미사용 시 자동으로 소멸됩니다.</li>
                        <li>해당 이벤트는 내부 사정으로 인해 별도 공지 없이 이벤트가 조기 종료될 수 있습니다.</li>
                        <li>텐바이텐 마일리지는 3만원 이상 구매 시 결제 화면에서 현금처럼 사용이 가능합니다.</li>
                    </ul>
                </div>
            </div>
        </div>
    `,
    data() {return {
        tabType : tabType,
        mainNumber: -1
    }},
    created() {
        $(function(){

            var lastScroll = 0;
            $(window).scroll(function () {
                var header = $('.header-wrap').outerHeight();
                var tabHeight = $('.main').outerHeight();
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
                    var tab05 = $('#tab05');
                    var tab06 = $('#tab06');
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
                    else if (tab05.position().top <= scrollPos + 100 && tab05.position().top + tab05.height() >= scrollPos + 100) {
                        $('.tab-area div').removeClass("on");
                        $('.tab05').addClass("on");
                    }
                    else if (tab06.position().top <= scrollPos + 100 && tab06.position().top + tab06.height() >= scrollPos + 100) {
                        $('.tab-area div').removeClass("on");
                        $('.tab06').addClass("on");
                    }
                });
        
               
            });
        
            $('.tab-area').on('click', 'a[href^="#"]', function (event) {
                var header = $('#header').outerHeight();
                event.preventDefault();
                $('html, body').animate({
                    scrollTop: $($.attr(this, 'href')).offset().top - header + 1
                }, 500);
                if($.attr(this, 'href')=="#tab01"){
                    fnAmplitudeEventAction('click_tentensale_sidemenu', 'num', 1);
                }else if($.attr(this, 'href')=="#tab02"){
                    fnAmplitudeEventAction('click_tentensale_sidemenu', 'num', 2);
                }else if($.attr(this, 'href')=="#tab03"){
                    fnAmplitudeEventAction('click_tentensale_sidemenu', 'num', 3);
                }else if($.attr(this, 'href')=="#tab04"){
                    fnAmplitudeEventAction('click_tentensale_sidemenu', 'num', 4);
                }else if($.attr(this, 'href')=="#tab05"){
                    fnAmplitudeEventAction('click_tentensale_sidemenu', 'num', 5);
                }else if($.attr(this, 'href')=="#tab06"){
                    fnAmplitudeEventAction('click_tentensale_sidemenu', 'num', 6);
                }else if($.attr(this, 'href')=="#tab07"){
                    fnAmplitudeEventAction('click_tentensale_sidemenu', 'num', 7);
                }
            });
        
            var swiper = new Swiper(".mySwiper", {
                slidesPerView:'auto',
                loop:'true',
            });
            $(".noti_more").click(function (event) {
                $(".pop_noti").show();
                return false;
            });
        
            $(".btn_close").click(function (event) {
                $(".pop_noti").hide();
                return false;
            });
            fnAmplitudeEventAction('view_tentensale_main', '', '');
        });
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
    updated() {
        
    },
    mounted() {
        const _this = this;
    },
    methods : {
        closePopup() {
            $('.daccu_banner').removeClass('active');
            this.floating = false;
        },
        goEventPage(code) {
            url = "event/eventmain.asp?eventid=" + code;
            location.href = "/" + url;
        },
        prdDetailPage(itemid){
            location.href = "/shopping/category_prd.asp?itemid=" + itemid;
        },
        goForumPage(){
            fnAmplitudeEventAction('click_tentensale_main_message', '', '');
            location.href = "/linker/forum.asp?idx=8";
        },
        goHeartGiftPage(){
            fnAmplitudeEventAction('click_tentensale_preasent_banner', '', '');
            location.href = "/event/heart_gift/";
        },
    }
});