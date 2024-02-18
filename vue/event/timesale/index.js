const app = new Vue({
    el: '#app'
    , store : store
    , mixin : [common_mixin]
    , template : `
        <div class="evt111787">
            <div class="topic">
                <!-- main -->
                <div class="main-top">
                    <a href="/event/21th/index.asp" class="img-beg"><img src="//webimage.10x10.co.kr/fixevent/event/2022/plusSale/badge_year2023_blue.png?v=1.3" alt="주년세일 엠블럼 위치"></a><!-- 10-04 수정 -->
                    <!-- 몇시타임 진행중인지 타임 노출 리스트 -->
                    <div class="show-time-current">
                        <div class="time-current-wrap">
                            <template v-for="(item, index) in mikki_time">
                                <div :class="[item.end_flag === 'Y' ? 'end' : '']">
                                    <img :src="'//webimage.10x10.co.kr/fixevent/event/2022/120264/m/' + item.active_name + (index + 1) + '.png'" :alt="item.mikki_time + '시 노출'" />
                                </div>
                            </template>
                        </div>    
                    </div>
                    <div class="tit-ready"><h2>{{time_text}}</h2></div>
                    <div class="sale-timer">
                        <div><span>-</span><span id="countdown">00:00:00</span></div>
                    </div>
                </div>
            </div>
            
            <div class="special-list-wrap">
                <div class="special-item">
                    <ul id="list1" class="list list1">
                        <li :class="[{'sold-out' : now_mikki.is_soldout, 'not-open' : now_mikki.is_open == 'N'}]">
                            <div class="product-inner">
                                <div class="thum">
                                    <img :src="now_mikki.itemImage" :alt="now_mikki.itemName">
                                    <span class="num-limite"><em>{{now_mikki.itemCnt}}</em>개 한정</span>
                                </div>
                                <div class="desc">
                                    <p class="name">{{now_mikki.itemName}}</p>
                                    <div class="price"><s>{{format_price(now_mikki.orgPrice)}}</s> {{format_price(now_mikki.sellCash)}} <span class="p-won">원</span><span class="sale">{{now_mikki.saleValue}}%</span></div>
                                </div>
                                <div class="go-link">
                                    <a @click="goDirOrdItem(now_mikki.itemid)">
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/111787/btn_buy.png" alt="바로구매하기">
                                    </a>
                                </div>
                            </div>
                        </li>
                    </ul>
                    <p class="txt-noti">선착순 특가 상품 구매 시 하단의 '유의사항'을 참고 바랍니다.</p>
                </div>
            </div>
    
            <!-- MD상품 30개 -->
            <div v-if="time_text != '세일 오픈까지'" class="md-list">
                <div class="md-list-wrap">
                    <ul id="itemList"></ul>
                </div>
            </div>            
    
            <!-- 티저 상품 -->
            <div v-show="pre_mikki.length > 0" class="product-list-wrap">
                <img src="//webimage.10x10.co.kr/fixevent/event/2021/111787/tit_ready.png?v=2" alt="잠시 후 오픈합니다.">
                <div class="product-list">
                    <ul id="list2" class="list list2">
                        <li v-for="(item, index) in pre_mikki">
                            <p class="open-time">{{item.mikki_time >= 12 ? '오후' : '오전'}} <span><em>{{item.mikki_time - 12 > 0 ? item.mikki_time - 12 : item.mikki_time}}</em>시</span></p>
                            <!--<img :src="'//upload.10x10.co.kr/linkweb/timesale/teaser/pc/time_header_' + item.mikki_time + '.png'" alt="시간">-->
                            <div class="product-inner">
                                <img :src="item.tzImage" :alt="item.itemName">
                                <span class="num-limite"><em>{{item.itemCnt}}</em>개 한정</span>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
    
            <div class="sold-out-wrap">
                <h2><img src="//webimage.10x10.co.kr/fixevent/event/2021/111787/tit_sold.png" alt="오늘, 지난 시간 판매 완료된 대표 상품"></h2>
                <div class="sold-out-list">
                    <div class="slide-area">
                        <div class="swiper-container">
                            <ul id="list3" class="list list3 swiper-wrapper">
                                <!-- 판매완료 상품 class sold-out 추가 -->
                                <li v-for="item in post_mikki" :class="['swiper-slide', 'sold-prd', {'sold-out' : (item.limitno - item.limitsold < 1 || item.maxcnt <= item.buycnt)}]">
                                    <div class="tit-prd">
                                        <div class="thum"><img :src="item.soldoutImage" alt="상품"></div>
                                        <div class="desc">
                                            <p class="name">{{item.itemName}}</p>
                                            <div class="price">
                                                <s>{{item.orgPrice}}</s> 
                                                {{item.sellCash}} <span class="p-won">원</span><span class="sale">{{item.saleValue}}%</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="sold-time">
                                        <p class="am">{{item.mikki_time >= 12 ? '오후' : '오전'}} <em>{{item.mikki_time - 12 > 0 ? item.mikki_time - 12 : item.mikki_time}}</em>시</p>
                                    </div>
                                </li>
                            </ul>                      
                        </div>
                    </div>
                </div>
            </div>
    
            <div class="noti-area">
                <div class="noti-header">
                    <button type="button" class="btn-noti"><img src="//webimage.10x10.co.kr/fixevent/event/2021/111786/tit_noti.jpg?v=2" alt="유의사항 확인하기"><span><img src="//webimage.10x10.co.kr/fixevent/event/2021/111786/icon_noti_arrow.png" alt=""></span></button>
                </div>
                <div class="noti-info">
                    <img src="//webimage.10x10.co.kr/fixevent/event/2021/111786/img_noti_info.jpg?v=2" alt="유의사항 내용">
                </div>
            </div>
    
            <!-- 티저 시작전 알림받기 -->
            <div v-show="next_schedule != null" class="teaser-timer">
                <div class="timer-inner">
                    <!-- 알림팝업 노출 버튼 -->
                    <button type="button" class="btn-push"></button>
                </div>
            </div>
            
            <!-- 쿠폰영역 생성 -->
            <!--<div class="coupon-area">
                <a class="go-coupon" href="/my10x10/couponbook.asp"></a>
            </div>-->
    
            <!-- 팝업 - 알림받기 -->
            <div class="pop-container push">
                <div class="pop-inner">
                    <div class="pop-contents">
                        <div class="contents-inner">
                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/111786/pop_push.png?v=3" alt="기회를 놓치지 않는 가장 확실한 방법">
                            <!-- 휴대폰 번호 입력 input -->
                            <div class="input-box">
                                <input type="number" id="phone" placeholder="휴대폰 번호를 입력해주세요" />
                                <button @click="fnSendToKakaoMessage" type="button" class="btn-submit">확인</button>
                            </div>
                            <button type="button" class="btn-close">닫기</button>
                        </div>
                    </div>
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
        //let query_param = new URLSearchParams(window.location.search);
        //this.$store.commit("SET_EVT_CODE", query_param.get("eventid"));
        this.$store.commit("SET_EVT_CODE", this.get_url_param("eventid"));

        this.$store.dispatch("GET_DATA");
        this.$store.dispatch("GET_NEXT_SCHEDULE");

        //this.setting_time = query_param.get("setting_time");
        this.setting_time = this.get_url_param("setting_time");

        this.isUserLoginOK = isUserLoginOK;
    }
    , mounted(){
        const _this = this;

        this.$nextTick(function() {
            $('.btn-noti').on("click",function(){
                $('.noti-info').toggleClass("on");
                $(this).toggleClass("on");
            });

            $('.evt111787 .btn-push').click(function(){
                $('.pop-container.push').fadeIn();
            });
            $('.evt111787 .btn-close').click(function(){
                $(".pop-container").fadeOut();
            });
        });
    }
    , computed : {
        normal_list(){
            return this.$store.getters.normal_list;
        }
        , schedule_idx() {
            return this.$store.getters.schedule_idx;
        }
        , mikki_time(){
            return this.$store.getters.mikki_time;
        }
        , time_text(){
            return this.$store.getters.time_text;
        }
        , now_mikki(){
            return this.$store.getters.now_mikki;
        }
        , pre_mikki(){
            return this.$store.getters.pre_mikki;
        }
        , post_mikki() {
            return this.$store.getters.post_mikki;
        }
        , next_mikki(){
            return this.$store.getters.next_mikki;
        }
        , evt_code(){
            return this.$store.getters.evt_code;
        }
        , next_schedule() {
            return this.$store.getters.next_schedule;
        }
    }
    , data(){
        return {
            setting_time : ""
            , isUserLoginOK : ""
        }
    }
    , methods : {
        format_price(price){
            if(price){
                return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
            }
        }
        , goDirOrdItem(itemid){
            if(itemid){
                if(this.isUserLoginOK == "False"){
                    if(confirm("로그인을 하셔야 이벤트에 참여하실 수 있습니다.")){
                        location.href='/login/loginpage.asp?backpath=/event/eventmain.asp?eventid=' + this.evt_code;
                    }
                }else if(loginUserLevel == 7 && (!is_production && loginUserID != "corpse2"&& loginUserID != "seojb1983"&& loginUserID != "pinokio5600")){
                    alert("텐바이텐 스탭은 참여할 수 없습니다.");
                }else{
                    const _this = this;

                    //let query_param = new URLSearchParams(window.location.search);
                    //let setting_time = query_param.get("setting_time");
                    let setting_time = this.get_url_param("setting_time");
                    let data = {"evt_code" : this.evt_code , "schedule_idx" : this.schedule_idx, "itemid" : itemid};
                    if(setting_time){
                        data = {"evt_code" : this.evt_code , "schedule_idx" : this.schedule_idx, "itemid" : itemid, "setting_time" : setting_time}
                    }

                    call_api("GET", "/timedeal/timedeal-now-mikki-realtime", data, function (data){
                        console.log("buy", data);
                        if(data.buyable == 0){
                            alert("응모 가능한 상태가 아닙니다.");
                            return false;
                        }else if(data.limitno - data.limitsold < 1) {
                            alert("준비된 수량이 소진되었습니다.");
                            return false;
                        }else if(data.bought_count > 0){
                            alert("이미 1개 결제하셨습니다.\nID당 1회만 구매 가능합니다.");
                            return false;
                        }else{
                            call_api("POST", "/timedeal/timedeal-eventlog", {"evt_code" : _this.evt_code, "mode" : "order", "itemid" : itemid, "device" : "M"});

                            call_api("GET", "/timedeal/timedeal-order-count-check", {"itemid" : itemid}, function(data){
                                if(data){
                                    $("#itemid").val(itemid);
                                    setTimeout(function() {
                                        document.directOrd.submit();
                                    },300);
                                }else{
                                    alert("준비된 수량이 소진되었습니다.");
                                    return false;
                                }
                            });
                        }
                    });
                }
            }
        }
        , fnSendToKakaoMessage(){
            const _this = this;

            if ($("#phone").val() == '' || $("#phone").val().length > 13) {
                alert('알림 받으실 전화번호를 정확히 입력해 주세요.');
                $("#phone").focus();
                return;
            }else{
                let phoneNumber;
                if ($("#phone").val().length > 10) {
                    phoneNumber = $("#phone").val().substring(0,3)+ "-" +$("#phone").val().substring(3,7)+ "-" +$("#phone").val().substring(7,11);
                } else {
                    phoneNumber = $("#phone").val().substring(0,3)+ "-" +$("#phone").val().substring(3,6)+ "-" +$("#phone").val().substring(6,10);
                }

                let request_date
                if(this.setting_time){
                    request_date = new Date();
                    request_date.setMinutes(request_date.getMinutes() - 2);
                }else{
                    request_date = new Date(
                        this.next_schedule.substr(0, 4)
                        , this.next_schedule.substr(5, 2) - 1
                        , this.next_schedule.substr(8, 2)
                        , /*this.next_schedule.substr(11, 2)*/ "09"
                        , this.next_schedule.substr(14, 2)
                        , this.next_schedule.substr(17, 2)
                    );

                    request_date.setMinutes(request_date.getMinutes() - 20);
                }
                request_date = request_date.getFullYear() + "-" + (request_date.getMonth() + 1) + "-" + request_date.getDate() + " " + request_date.getHours() + ":" + request_date.getMinutes() + ":" + request_date.getSeconds();
                //console.log("request_date", request_date);

                call_api("POST", "/timedeal/timedeal-kakao-joined", {"evt_code" : this.evt_code, "schedule_idx" : this.schedule_idx + 1, "usercell" : phoneNumber}, function (data){
                    if(!data){
                        alert("이미 알림톡 서비스를 신청 하셨습니다.");
                    }else{
                        let fullText = "신청하신 [타임세일] 이벤트 알림입니다.\n\n";
                        fullText += "잠시 후 9시부터 이벤트 참여가 가능합니다.\n\n";
                        fullText += "맞아요, 이 가격.\n";
                        fullText += "고민하는 순간 품절됩니다.\n";
                        fullText += "서두르세요!";

                        let failText = "[텐바이텐] 신청하신 타임세일 이벤트 알림입니다."

                        let btnJson = '{"button":[{"name":"참여하러 가기","type":"WL","url_mobile":"https://tenten.app.link/n0YytasjKeb"}]}';

                        let join_request = {"evt_code" : _this.evt_code, "schedule_idx" : _this.schedule_idx, "usercell" : phoneNumber
                            , "request_date" : request_date.toString(), "fullText" : fullText, "failText" : failText, "btnJson" : btnJson};
                        //console.log("join_request", join_request);

                        call_api("POST", "/timedeal/timedeal-kakao-join", join_request, function (data){
                            if(data > 0){
                                alert("신청이 완료되었습니다.");
                                $("#phone").val('');
                                $(".pop-container").fadeOut();
                            }else{
                                alert("신청 실패. 오류발생");
                            }
                        });
                    }
                });
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
    }
    , watch : {
        next_mikki(data){
            let now = new Date();

            if(this.setting_time){
                now = new Date(
                    this.setting_time.substr(0, 4)
                    , this.setting_time.substr(5, 2) - 1
                    , this.setting_time.substr(8, 2)
                    , this.setting_time.substr(11, 2)
                    , this.setting_time.substr(14, 2)
                    , this.setting_time.substr(17, 2)
                );
            }

            countDownTimer(data.substr(0, 4)
                , data.substr(5, 2)
                , data.substr(8, 2)
                , data.substr(11, 2)
                , data.substr(14, 2)
                , data.substr(17, 2)
                , now
            );
        }
    }
});