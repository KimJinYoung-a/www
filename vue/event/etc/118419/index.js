const app = new Vue({
    el: '#app'
    , store : store
    , template : `
        <div class="evt118419" v-cloak>
            <section class="section section01">
                <div class="txt"></div>
            </section>
            <section class="section section02">
                <div class="section02_01"></div>
                <div class="coupon_slide">
                    <div class="slide_wrap">
                        <div class="slide">
                            <img src="//webimage.10x10.co.kr/fixevent/event/2022/118419/m/coupon01.png" alt="">
                        </div>
                        <div class="slide">
                            <img src="//webimage.10x10.co.kr/fixevent/event/2022/118419/m/coupon02.png" alt="">
                        </div>
                        <div class="slide">
                            <img src="//webimage.10x10.co.kr/fixevent/event/2022/118419/m/coupon03.png" alt="">
                        </div>
                        <div class="slide">
                            <img src="//webimage.10x10.co.kr/fixevent/event/2022/118419/m/coupon04.png" alt="">
                        </div>
                    </div>
                </div>
                <div class="section02_02">
                    <!-- 쿠폰 한 번에 받기 -->
                    <a v-if="check_coupon_valid" @click="get_coupon()" href="javascript:void(0)" class="sect02_btn"><img src="//webimage.10x10.co.kr/fixevent/event/2022/118419/sect02_btn01.png" alt=""></a>
                    <!-- 수량소진 -->
                    <a v-else href="javascript:void(0)"><img src="//webimage.10x10.co.kr/fixevent/event/2022/118419/sect02_btn02.png" alt=""></a>
                    <!-- 다음 혜택 알림 받기 -->
                    <a @click="go_alarm('1')" href="javascript:void(0)" class="btn_alert"><img src="//webimage.10x10.co.kr/fixevent/event/2022/118419/float.png" alt=""></a>
                </div>
            </section>
            <section class="section section03">
                <!-- coming soon -->
                <div v-show="!second_start_flag" class="section03_01"></div>
                <!-- open -->
                <div v-show="second_start_flag" class="section03_02">
                    <!-- 지원금 받기 -->
                    <a v-if="check_mileage_valid" @click="go_mileage('second')" href="javascript:void(0)" class="sect03_btn"><img src="//webimage.10x10.co.kr/fixevent/event/2022/118419/sect03_btn01.png" alt=""></a>
                    <!-- 수량소진 -->
                    <a v-else href="javascript:void(0)" class="sect03_btn"><img src="//webimage.10x10.co.kr/fixevent/event/2022/118419/sect03_btn02.png" alt=""></a>
                </div>
            </section>
            <section class="section section04">
                <!-- coming soon -->
                <div v-show="!third_start_flag" class="section04_01"></div>
                <!-- open -->
                <div v-show="third_start_flag" class="section04_02" style="display:none;">
                    <a v-if="check_soldout" @click="go_soldout" href="javascript:void(0)" class="sect04_btn"><img src="//webimage.10x10.co.kr/fixevent/event/2022/118419/sect04_btn03.png?v=1.1" alt=""></a>
                    <a v-else-if="check_buyable" @click="go_purchase" href="javascript:void(0)" class="sect04_btn"><img src="//webimage.10x10.co.kr/fixevent/event/2022/118419/sect04_btn01.png?v=1.1" alt=""></a>
                    <a v-else href="javascript:void(0)" class="sect04_btn"><img src="//webimage.10x10.co.kr/fixevent/event/2022/118419/sect04_btn02.png?v=1.1" alt=""></a>
                    
                    <!-- 히치하이커 자세히 보기 -->
                    <a href="https://www.10x10.co.kr/hitchhiker/?gaparam=main_hitchhiker" class="sect04_btn02"></a>
                </div>
            </section>
            <section class="section section05">
                <a @click="go_mileage('vip')" href="javascript:void(0)" class="sect05_btn"></a>
            </section>
            <!-- 팝업 - 문자수신 N -->
            <div class="popup pop01">
                <div class="bg_dim"></div>
                <div class="pop">
                    <img src="//webimage.10x10.co.kr/fixevent/event/2022/118419/popup01.png" alt="">
                    <a @click="go_smart_alarm" href="javascript:void(0)" class="btn_alert"></a>
                    <a href="" class="btn_close"></a>
                </div>
            </div>
            <!-- 팝업 - 문자수신 Y -->
            <div class="popup pop02">
                <div class="bg_dim"></div>
                <div class="pop">
                    <img src="//webimage.10x10.co.kr/fixevent/event/2022/118419/popup02.png" alt="">
                    <a href="" class="btn_close"></a>
                </div>
            </div>
            
            <form method="post" name="directOrd" action="/inipay/shoppingbag_process.asp">
                <input type="hidden" name="itemid" id="itemid" value="">
                <input type="hidden" name="itemoption" value="0000">
                <input type="hidden" name="itemea" value="1">
                <input type="hidden" name="mode" value="DO1">
            </form>
        </div>
    `
    , created() {
        this.$store.commit("SET_EVT_CODE", this.get_url_param("eventid"));
        this.$store.dispatch("GET_COUPON_VALID");
        this.$store.dispatch("GET_MILEAGE_VALID");

        let now = new Date();
        let second_start_date = new Date(2022, 5-1, 9, 0, 0, 0);
        if(now >= second_start_date){
            this.second_start_flag = true;
        }
        let third_start_date = new Date(2022, 5-1, 23, 0, 0, 0);
        if(now >= third_start_date){
            this.third_start_flag = true;
        }

        let itemid;
        if(now >= new Date(2022, 5-1, 23, 10, 0, 0) && now < new Date(2022, 5-1, 24, 0, 0, 0)){
            itemid = 4606013;
        }else if(now >= new Date(2022, 5-1, 24, 10, 0, 0) && now < new Date(2022, 5-1, 25, 0, 0, 0)){
            itemid = 4606014;
        }else if(now >= new Date(2022, 5-1, 25, 10, 0, 0) && now < new Date(2022, 5-1, 26, 0, 0, 0)){
            itemid = 4606015;
        }else if(now >= new Date(2022, 5-1, 26, 10, 0, 0) && now < new Date(2022, 5-1, 27, 0, 0, 0)){
            itemid = 4606016;
        }
        this.$store.commit("SET_ITEMID", itemid);
        this.$store.dispatch("GET_BUY_COUNT");

        this.$nextTick(function() {
            var i=1;
            setInterval(function(){
                i++;
                if(i>2){i=1;}
                $('.section01 .txt').css('backgroundImage','url(//webimage.10x10.co.kr/fixevent/event/2022/118419/txt0'+ i +'.png?v=1.1)');
            },1000);

            // section02 슬라이드
            $('.slide_wrap').slick({
                arrows:true,
                dots:true
            });

            // 다음혜택 알림받기 버튼
            var didScroll;
            $(window).scroll(function (event) {
                didScroll = true;
            }); // hasScrolled()를 실행하고 didScroll 상태를 재설정
            setInterval(function () {
                if (didScroll) { hasScrolled(); didScroll = false; }
            }, 0);

            function hasScrolled() { // 동작을 구현
                var st = _jquery_this.scrollTop();
                var start = $('.section').eq(1).offset().top;
                var end = $('.section').last().offset().top + $('.section').last().height() - 300;
                // 접근하기 쉽게 현재 스크롤의 위치를 저장한다.
                if (st > start) {
                    $('.btn_alert').css('display','block');
                    $('.btn_alert').addClass('fixed');
                    if(st > end){
                        $('.btn_alert').css('display','none');
                    }
                }else {
                    $('.btn_alert').css('display','none');
                }
            }

            // 팝업 닫기
            $('.evt118419 .popup .btn_close').click(function(){
                $('.evt118419 .popup').hide()
                return false;
            })
        });
    }
    , mounted(){
        const _this = this;
    }
    , computed : {
        evt_code(){
            return this.$store.getters.evt_code;
        }
        , check_coupon_valid(){
            return this.$store.getters.check_coupon_valid;
        }
        , check_mileage_valid(){
            return this.$store.getters.check_mileage_valid;
        }
        , check_buyable(){
            return this.$store.getters.check_buyable;
        }
        , itemid(){
            return this.$store.getters.itemid;
        }
        , check_soldout(){
            return this.$store.getters.check_soldout;
        }
        , item_buy_count(){
            return this.$store.getters.item_buy_count;
        }
    }
    , data(){
        return {
            is_saving : false
            , tmp_opt2 : 1
            , second_start_flag : false
            , third_start_flag : false
        }
    }
    , methods : {
        format_price(price){
            if(price){
                return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
            }
        }
        , get_url_param(param_name){
            let now_url = location.search.substr(location.search.indexOf("?") + 1);
            now_url = now_url.split("&");
            let result = "";
            for(let i = 0; i < now_url.length; i++){
                let temp_param = now_url[i].split("=");
                if(temp_param[0] == param_name){
                    result = temp_param[1].replace("%20", " ");
                }
            }

            return result;
        }
        , get_coupon(){
            let api_data = {
                "event_code" : this.evt_code
                , "check_option3" : true
                , "event_option3" : "try"
                , "device" : "W"
            };

            give_coupon("evtsel,evtsel,evtsel,evtsel", "2097, 2098, 2099, 2100", this.evt_code).then(function(){
                call_subscription_api(api_data).then(function (data){
                    if(!data.result && data.reason == "alreay"){
                        alert("앗! 이미 쿠폰을 받으셨습니다.");
                    }
                });
            });
        }
        , go_alarm(opt2){
            const _this = this;

            if(!isUserLoginOK){
                alert("로그인이 필요한 서비스입니다.");
                return false;
            }

            call_api("GET", "/user/my-sns-receive-state", {}, function (data){
                if(data){
                    let api_data = {
                        "event_code" : _this.evt_code
                        , "check_option1" : false
                        , "event_option1" : "Y"
                        , "check_option2" : true
                        , "event_option2" : opt2
                        , "check_option3" : true
                        , "event_option3" : "alarm"
                        , "device" : "W"
                    };

                    if(this.is_saving){
                        return false;
                    }
                    this.is_saving = true;

                    call_subscription_api(api_data).then(function(data){
                        console.log(data);
                        if(data.result){
                            $('.evt118419 .pop02').show();
                        }else{
                            if(data.reason == "already"){
                                alert("이미 알림을 신청하셨습니다.");
                            }
                        }
                        _this.is_saving = false;
                    }).catch(function(err){
                        _this.is_saving = false;
                    });
                }else{
                    let api_data = {
                        "event_code" : _this.evt_code
                        , "check_option3" : true
                        , "event_option3" : "open"
                        , "device" : "W"
                    };

                    call_subscription_api(api_data).then(function(data){
                        _this.tmp_opt2 = opt2;

                        $('.evt118419 .pop01').show();
                    });
                }
            });
        }
        , go_smart_alarm(){
            const _this = this;

            if(this.is_saving){
                return false;
            }
            this.is_saving = true;

            call_api("PUT", "/user/smart-alarm", {}, function (data){
                let api_data = {
                    "event_code" : _this.evt_code
                    , "check_option1" : false
                    , "event_option1" : "N"
                    , "check_option2" : true
                    , "event_option2" : _this.tmp_opt2
                    , "check_option3" : true
                    , "event_option3" : "alarm"
                    , "device" : "W"
                };

                call_subscription_api(api_data).then(function(data){
                    if(data.result){
                        alert("스마트 알림 수신 동의 및 알림 신청이 완료되었습니다. \n추후에 개인정보수정 영역에서 수신 여부 변경이 가능합니다.");
                    }else{
                        if(data.reason == "alreay"){
                            alert("이미 알림을 신청하셨습니다.");
                        }
                    }
                    _this.is_saving = false;
                }).catch(function(err){
                    _this.is_saving = false;
                });
            });
        }
        , go_mileage(type){
            if(type == "vip"){
                if(loginUserLevel == 2 || loginUserLevel == 3 || loginUserLevel == 4 || (loginUserLevel == 7 && loginUserID == "pinokio5600")){
                    give_mileage(this.evt_code, 1).then(function(data){
                        if(data.result){
                            alert("마일리지가 지급되었습니다. \n5월 30일까지 사용해주세요.");
                        }else{
                            alert(data.message);
                        }
                    });
                }else{
                    alert("죄송합니다. \nVIP등급에게만 지급되는 혜택입니다.");
                }
            }else if(type == "second"){
                give_mileage(118454, 1).then(function(data){
                    if(data.result){
                        alert("‘2,500p가 지급되었어요! \n5월 12일까지 사용하세요!");
                    }else{
                        alert(data.message);
                    }
                });
            }
        }
        , go_purchase(){
            $("#itemid").val(this.itemid);
            setTimeout(function() {
                document.directOrd.submit();
            },300);
        }
        , go_soldout(){
            if(this.item_buy_count == 9999){
                alert("오전 10시에 오픈됩니다.");
            }
        }
    }
    , watch : {

    }
});