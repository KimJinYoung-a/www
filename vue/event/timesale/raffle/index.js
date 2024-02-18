const app = new Vue({
    el: '#app'
    , store : store
    , mixin : [common_mixin]
    , template : `
        <div class="timesales">
            <a href="/event/eventmain.asp?eventid=117614"><img src="//webimage.10x10.co.kr/fixevent/event/2022/117461/img_banner01.png" alt="맛있는 세일"></a>
            <div class="topic">
                <div class="conts relative">
                    <button type="button" class="btn-check">
                        <img src="//webimage.10x10.co.kr/fixevent/event/2022/117461/img_prev.png?v=2" alt="지난 래플 확인하기">
                    </button>
                </div>
            </div>
            <div class="top-sec">
                <div class="conts">
                    <div class="relative">
                        <h3><img src="//webimage.10x10.co.kr/fixevent/event/2022/117461/title.png" alt="텐텐래플"></h3>
                        <button type="button" class="btn-tenten txt-hidden">텐텐래플?</button>
                        <!-- 텐텐래플 안내 팝업 -->
                        <div class="popup ten-raffle" style="display:none;">
                            <img src="//webimage.10x10.co.kr/fixevent/event/2022/117461/pop.png" alt="탠탠래플? 하루 3번 진행되는 래플 이벤트!">
                            <button type="button" class="btn-close txt-hidden">팝업 닫기</button>
                        </div>
                        <div class="time-border">
                            <template v-if="is_today_start">
                                <img src="//webimage.10x10.co.kr/fixevent/event/2022/117461/border_time.png" alt="time border">
                                <div id="countdown" class="time">
                                    <span class="hour">0</span>
                                    <span class="bar">:</span>
                                    <span class="min">00</span>
                                    <span class="bar02">:</span>
                                    <span class="second">00</span>
                                </div>
                            </template>
                            
                            <div v-if="now_mikki.end_flag == 'I'" class="open-noti">지금 <span>{{now_mikki.subscript_count}}</span>명이 참여하고 있어요</div>
                            <div v-else class="open-noti">매주 월, 수 오전 9시 정각에 시작합니다</div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="item-sec">
                <div class="product-inner">
                    <div class="thum">
                        <img src="//webimage.10x10.co.kr/fixevent/event/2022/117461/bg_item.png" alt="bg">
                        <div class="item-img">
                            <img :src="now_mikki.itemImage" alt="">
                        </div>
                        <div class="round"><img v-if="now_mikki.mikki_idx" :src="'//webimage.10x10.co.kr/fixevent/event/2022/117461/img0' + now_mikki.mikki_idx + '.png'" :alt="now_mikki.mikki_idx + '차'"></div>
                    </div>
                    <div class="info">
                        <div class="desc">
                            <p class="brand">{{now_mikki.makerName}}</p>
                            <p class="name">{{now_mikki.itemName}}</p>
                            <span class="num-limite"><em>{{now_mikki.itemCnt}}</em>개 한정</span>
                            <div class="price relative">
                                <s>{{format_price(now_mikki.orgPrice)}}</s>
                                <span class="p-won">{{format_price(now_mikki.sellCash)}}원</span>
                                <span class="sale">{{now_mikki.saleValue}}%</span>
                            </div>
                            <button v-if="now_mikki.end_flag == 'N'" @click="click_alarm(now_mikki.startDate, now_mikki.mikki_idx)" type="button" class="btn-alram"><img src="//webimage.10x10.co.kr/fixevent/event/2022/117461/icon_alram.png" alt="알람받기"></button>
                            <button @click="copy_clipboard" id="urlcopy" data-clipboard-text="https://10x10.co.kr/event/eventmain.asp?eventid=117461" type="button" class="btn-share"><img src="//webimage.10x10.co.kr/fixevent/event/2022/117461/icon_share.png" alt="공유하기"></button>
                        </div>
                        <div class="line"></div>
                        <ul class="event-day">
                            <li>{{now_mikki.mikki_idx}}회차 래플 응모기간 {{raffle_time_info.subscript_period}}</li>
                            <li>당첨자 발표일 {{raffle_time_info.notice_date}} 15:00</li>
                            <li>당첨자 구매기한 {{raffle_time_info.buyable_date}} 15:00까지</li>
                        </ul>
                    </div>
                </div>
                <!-- 진행예정 일떄 class disabled 추가 -->
                <button @click="show_popup('subscript')" type="button" :class="['btn-apply', now_mikki.end_flag == 'N' ? 'disabled' : '']">{{now_mikki.end_flag == 'N' ? '진행예정' : '응모하기'}}</button>
                <p class="tit-noti">*아래 유의사항을 꼭 확인하고 응모해주세요</p>
                <div class="noti-area">
                    <button type="button" class="btn-noti">
                        <img src="//webimage.10x10.co.kr/fixevent/event/2022/117461/btn_notice.png" alt="유의사항"><span class="icon"></span>
                    </button>
                    <div class="noti-txt">
                        <h3>이벤트 유의사항</h3>
                        <ul>
                            <li>- 응모 고객 대상 추첨 판매하는 상품입니다.</li>
                            <li>- 텐바이텐 회원만 참여가 가능하며, 로그인 후 응모가 가능합니다. (1인 1아이디, 1회 응모 가능 / 핸드폰 번호 중복 응모 불가능)</li>
                            <li>- 응모 시 정보가 잘못 입력되어 있을 시 응모가 취소될 수 있습니다.</li>
                            <li>- 당첨 시 구매할 수 있는 상품을 장바구니에 넣어, 개별 안내 메세지가 발송됩니다. 메세지 확인 후 장바구니의 상품을 구매 하시면 됩니다.</li>
                            <li>- 당첨 안내 후 구매기한 내에 구매하지 않을 경우 자동 취소 됩니다. (상품별 '당첨자 구매기한' 일정 확인).</li>
                            <li> : 당첨 시 SMS 메시지 발송 (알림 톡 또는 LMS)</li>
                            <li> : 핸드폰 번호 오류로 인해 안내받지 못한 고객은 자동 취소</li>
                            <li>- 상품 발송은 발표일 이후 7일 이내 발송 예정입니다. (영업일 기준 / 상황에 따라 배송이 지연될 수 있습니다.)</li>
                            <li>- 당첨자는 100% 프로그램을 통한 랜덤 추첨됩니다.</li>
                            <li>- 배송비는 각 상품의 배송비 정책에 따라 부과 됩니다.</li>
                            <li>- 매크로 프로그램, 가상 아이디 사용 등 부정한 방법의 구매 시도를 했을 경우 추첨 대상에서 제외됩니다.</li>
                        </ul>
                    </div>
                </div>
            </div>
            
            <div class="item-sec02">
                <div v-for="(item, index) in left_mikki_list">
                    <template v-if="item.end_flag == 'Y'">
                        <h3><img :src="'//webimage.10x10.co.kr/fixevent/event/2022/117461/tit_end0' + item.mikki_idx + '.png'" :alt="item.mikki_idx + '차 완료'"></h3>
                        <div class="product-inner next-item end-time">
                            <div class="bg">
                                <div class="thum">
                                    <div class="item-img">
                                        <img :src="item.itemImage" alt="">
                                    </div>
                                    <div class="badge">
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2022/117461/img_end.png" :alt="item.mikki_idx + '차 완료래플'">
                                    </div>
                                </div>
                                <div class="info">
                                    <div class="desc">
                                        <p class="brand">{{item.makerName}}</p>
                                        <p class="name">{{item.itemName}}</p>
                                        <div class="price relative">
                                            <s>{{format_price(item.orgPrice)}}</s>
                                            <span class="p-won">{{format_price(item.sellCash)}}</span>
                                            <span class="sale">{{item.saleValue}}%</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </template>
                    <template v-else>
                        <h3><img :src="'//webimage.10x10.co.kr/fixevent/event/2022/117461/tit_apply0' + item.mikki_idx + '.png?v=2'" :alt="'오늘의 ' + item.mikki_idx + '차 래플'"></h3>
                        <div class="product-inner next-item">
                            <div class="bg">
                                <div class="thum">
                                    <div class="item-img">
                                        <img :src="item.itemImage" alt="">
                                    </div>
                                </div>
                                <div class="info">
                                    <div class="desc">
                                        <p class="brand">{{item.makerName}}</p>
                                        <p class="name">{{item.itemName}}</p>
                                        <span class="num-limite"><em>{{item.itemCnt}}</em>개 한정</span>
                                        <div class="price relative">
                                            <s>{{format_price(item.orgPrice)}}</s>
                                            <span class="p-won">{{format_price(item.sellCash)}}</span>
                                            <span class="sale">{{item.saleValue}}%</span>
                                        </div>
                                        <button @click="click_alarm(item.startDate, item.mikki_idx)" type="button" class="btn-alram"><img src="//webimage.10x10.co.kr/fixevent/event/2022/117461/icon_alram.png" alt="알람받기"></button>
                                        <button @click="copy_clipboard" id="urlcopy" data-clipboard-text="https://10x10.co.kr/event/eventmain.asp?eventid=117461" type="button" class="btn-share"><img src="//webimage.10x10.co.kr/fixevent/event/2022/117461/icon_share.png" alt="공유하기"></button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </template>
                </div>
            </div>
            <div :class="['more-product', is_today_start ? '' : 'before']">
                <div class="grd-bar"></div>
                <div class="conts relative">
                    <div class="top-tit">
                        <div class="tit"><img src="//webimage.10x10.co.kr/fixevent/event/2022/117461/tit_apply04.png" alt="오늘 단하루 타임특가"></div>
                        
                        <template v-if="!is_today_start">
                            <div class="open-noti">매주 월, 수 자정에 시작합니다</div>
                            <img src="//webimage.10x10.co.kr/fixevent/event/2022/117461/img_banner03.png" alt="배너">
                        </template>
                        
                        <button type="button" class="btn-sale txt-hidden">타임특가란?</button>
                        <!-- 타인특가 안내 팝업 -->
                        <div class="popup ten-sale" style="display:none;">
                            <img src="//webimage.10x10.co.kr/fixevent/event/2022/117461/pop02.png" alt="타임특가란?">
                            <button type="button" class="btn-close txt-hidden">팝업 닫기</button>
                        </div>
                        
                        <div v-if="is_today_start" id="countdown_of_end_today" class="time">
                            <span class="hour">00</span>
                            <span class="bar">:</span>
                            <span class="min">00</span>
                            <span class="bar02">:</span>
                            <span class="second">00</span>
                        </div>                        
                        <div v-else>
                            <a href="/event/eventmain.asp?eventid=117475" class="link01"></a>
                            <a href="/event/eventmain.asp?eventid=117460" class="link02"></a>
                        </div>                        
                    </div>
                    <!-- 24시간 타임특가 상품 -->
                    <div v-show="is_today_start">
                        <div id="itemList"></div>
                        <div class="bnr-zone">
                            <div class="link-wrap">
                                <img src="//webimage.10x10.co.kr/fixevent/event/2022/117461/img_banner02.png" alt="세일 이벤트">
                                <a href="/event/eventmain.asp?eventid=117475" class="link01"></a>
                                <a href="/event/eventmain.asp?eventid=117460" class="link02"></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!--  팝업 START  -->
            <!-- 알림신청 팝업 -->
            <div class="dim" style="display:none;"></div>
            <div class="popup pop-alram" style="display:none;">
                <img src="//webimage.10x10.co.kr/fixevent/event/2022/117461/pop_alram.png" alt="래플 알림 신청">
                <input @input="check_only_number" name="phone" id="alarm_phone_number" type="text" placeholder="휴대폰 번호를 입력해주세요">
                <button @click="clear_phone_number" type="button" class="btn-delete txt-hidden">번호 지우기</button>
                <button @click="fnSendToKakaoMessage" type="button" class="btn-applys txt-hidden">알림신청</button>
                <button type="button" class="btn-close txt-hidden">팝업 닫기</button>
            </div>
            <!-- 응모하기 팝업 -->
            <div class="popup pop-apply" style="display:none;">
                <img src="//webimage.10x10.co.kr/fixevent/event/2022/117461/pop_apply.png" alt="응모하기">
                <input @input="check_only_number" name="phone" id="subscript_phone_number" type="text" placeholder="휴대폰 번호를 입력해주세요">
                <button @click="clear_phone_number" type="button" class="btn-delete txt-hidden">번호 지우기</button>
                <button @click="go_subscript_raffle" type="button" class="btn-applys txt-hidden">응모하기</button>
                <button type="button" class="btn-close txt-hidden">팝업 닫기</button>
            </div>
            <!-- 지난래플 당첨자 클릭시 노출 팝업 -->
            <div class="popup pop-win01" style="display:none;">
                <img src="//webimage.10x10.co.kr/fixevent/event/2022/117461/pop_win01.png" alt="탠탠 래플 당첨자 안내">
                <button @click="check_my_win" type="button" class="btn-ch-win txt-hidden">내당첨 확인하기</button>
                <button type="button" class="btn-all-win txt-hidden">당첨자 전체 보기</button>
                <button type="button" class="btn-close txt-hidden">팝업 닫기</button>
            </div>
            <!-- 내 당첨 확인하기 팝업 -->
            <div class="popup pop-win02" style="display:none;">
                <img src="//webimage.10x10.co.kr/fixevent/event/2022/117461/pop_win02.png" alt="축하드립니다.">
                <div v-if="my_win" class="txt">{{my_win.startdate}}일 {{my_win.mikki_idx}}회차 응모에<br/>당첨되셨습니다:)</div>
                <button type="button" class="btn-close txt-hidden">팝업 닫기</button>
            </div>
            <!-- 당첨자 전체 보기 팝업 -->
            <div class="popup pop-win03" style="display:none;">
                <div class="pop-inner">
                    <div class="tit">
                        <img src="//webimage.10x10.co.kr/fixevent/event/2022/117461/tit_prev_winner.png" alt="텐텐래플 당첨자 안내">
                    </div>
                    <template v-for="item in winners_list">
                        <div class="prev-day">{{item.schedule_date}}</div>
                        <div class="winner-info">
                            <div v-for="winner in item.winners" class="winner-list">
                                <div class="winner-detail">
                                    <div class="thumbnail">
                                        <img :src="winner.itemImage" alt="">
                                        <div class="bg-noti">추첨완료</div>
                                    </div>
                                    <div class="desc">
                                        <div class="round">{{winner.mikki_idx}}차</div>
                                        <p class="name">{{winner.itemName}}</p>
                                        <div class="winner-id">
                                            <p class="id"><span class="ten-id">{{winner.userid}}</span> <span>님</span></p>
                                            <p>축하드립니다!</p>
                                        </div>
                                    </div>
                                </div>
                            </div>                            
                        </div>
                    </template>
                    <button type="button" class="btn-close txt-hidden">팝업 닫기</button>
                </div>
            </div>
        </div>
    `
    , created() {
        this.$store.commit("SET_EVT_CODE", this.get_url_param("eventid"));
        this.$store.dispatch("GET_DATA");
        this.$store.dispatch("GET_NEXT_SCHEDULE");
        this.$store.dispatch("GET_TIMESALE_RAFFLE_KAKAO_INFO");
        this.$store.dispatch("GET_TIMESALE_RAFFLE_WINNER");

        this.showWinner = this.get_url_param("showWinner");

        this.isUserLoginOK = isUserLoginOK;

        this.$nextTick(function() {
            if(this.showWinner > 0){
                $('.popup.pop-win01').show();
                $('.dim').show();
            }

            /* 유의사항 보기 */
            $('.btn-noti').on('click',function(){
                $(this).children('.icon').toggleClass('on');
                $(this).next().toggleClass('on');
            });
            /* 팝업 */
            $('.btn-tenten').on('click',function(){
                $('.popup.ten-raffle').show();
            });
            $('.btn-sale').on('click',function(){
                $('.popup.ten-sale').show();
            });
            $('.btn-check').on('click',function(){
                $('.popup.pop-win01').show();
                $('.dim').show();
            });
            $('.btn-all-win').on('click',function(){
                $('.popup.pop-win01').hide();
                $('.popup.pop-win03').show();
                $('.dim').show();
            });
            $('.btn-close').on('click',function(){
                $('.popup').hide();
                $('.dim').hide();
            });
        });
    }
    , computed : {
        schedule_idx() {
            return this.$store.getters.schedule_idx;
        }
        , now_mikki(){
            return this.$store.getters.now_mikki;
        }
        , left_mikki_list(){
            return this.$store.getters.left_mikki_list;
        }
        , normal_list(){
            return this.$store.getters.normal_list;
        }
        , evt_code(){
            return this.$store.getters.evt_code;
        }
        , kakao_info(){
            return this.$store.getters.kakao_info;
        }
        , my_win(){
            return this.$store.getters.my_win;
        }
        , winners_list(){
            return this.$store.getters.winners_list;
        }
    }
    , data(){
        return {
            isUserLoginOK : ""
            , is_saving : false
            , kakao_request_date : ""
            , kakao_mikki_idx : null
            , raffle_time_info : {
                subscript_period : null
                , notice_date : null
                , buyable_date : null
            }
            , showWinner : 0
            , is_today_start : false
        }
    }
    , methods : {
        format_price(price){
            if(price){
                return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
            }
        }
        , click_alarm(request_date, mikki_idx){
            let new_request_date = new Date(
                request_date.substr(0, 4)
                , request_date.substr(5, 2) - 1
                , request_date.substr(8, 2)
                , request_date.substr(11, 2)
                , request_date.substr(14, 2)
                , request_date.substr(17, 2)
            );
            new_request_date.setMinutes(new_request_date.getMinutes() - 20);

            const now = new Date();
            if(now >= new_request_date){
                alert("시작 20분 전에는 알림을 신청하실 수 없습니다.");
                return false;
            }

            this.kakao_request_date = new_request_date;
            this.kakao_mikki_idx = mikki_idx;

            this.show_popup("alarm");
        }
        , show_popup(popup_name){
            switch(popup_name){
                case "alarm" :
                    $('.popup.pop-alram').show();
                    $('.dim').show();
                    break;
                case "subscript" :
                    $('.popup.pop-apply').show();
                    $('.dim').show();
                    break;
                case "my_win" :
                    $('.popup.pop-win01').hide();
                    $('.popup.pop-win02').show();
                    $('.dim').show();
                    break;
            }
        }
        , copy_clipboard(){
            const clipboard = new Clipboard('#urlcopy');

            clipboard.on('success', function() {
                alert('URL이 복사 되었습니다.');
            });
            clipboard.on('error', function() {
                alert('URL을 복사하는 도중 에러가 발생했습니다.');
            });
        }
        , go_subscript_raffle(){
            if(this.now_mikki.itemid){
                if(this.isUserLoginOK == "False"){
                    if(confirm("로그인을 하셔야 이벤트에 참여하실 수 있습니다.")){
                        location.href='/login/loginpage.asp?backpath=/event/eventmain.asp?eventid=' + this.evt_code;
                    }

                    return false;
                }else if(loginUserLevel == 7 && (loginUserID != "seojb1983"&& loginUserID != "pinokio5600")){
                    alert("텐바이텐 스탭은 참여할 수 없습니다.");
                }else if ($("#subscript_phone_number").val() == '' || $("#subscript_phone_number").val().length > 11 || $("#subscript_phone_number").val().length < 10) {
                    alert('알림 받으실 전화번호를 정확히 입력해 주세요.');
                    $("#subscript_phone_number").focus();

                    return false;
                }else{
                    let api_data = {
                        "event_code" : this.evt_code
                        , "check_option1" : true
                        , "event_option1" : this.now_mikki.itemid
                        , "check_option2" : true
                        , "event_option2" : this.schedule_idx
                        , "event_option3" : $("#subscript_phone_number").val()
                        , "device" : "P"
                    };

                    this.go_subscription_api(api_data);
                }
            }
        }
        , go_subscription_api(api_data){
            const _this = this;

            if(this.is_saving){
                return false;
            }
            this.is_saving = true;

            let usercell_api_data = {
                "evt_code" : api_data.event_code
                , "itemid" : api_data.event_option1
                , "schedule_idx" : api_data.event_option2
                , "usercell" : api_data.event_option3
            }
            call_api("GET", "/timedeal/usercell-duplication-check", usercell_api_data, function (data){
                if(data){
                    alert("이미 응모처리된 연락처입니다.");
                    _this.is_saving = false;
                }else{
                    call_api("POST", "/event/common/subscription", api_data, function (data){
                        alert("응모가 완료되었습니다.");
                        _this.is_saving = false;
                    }, function(xhr){
                        _this.is_saving = false;

                        try {
                            const err_obj = JSON.parse(xhr.responseText);
                            console.log(err_obj);
                            switch (err_obj.code) {
                                case -10: alert('이벤트에 응모를 하려면 로그인이 필요합니다.'); break;
                                default: alert(err_obj.message); break;
                            }
                        }catch(error) {
                            console.log(error);
                            alert('데이타를 저장하는 도중에 에러가 발생하였습니다. 관리자 문의 요망. (에러코드 : 002)');
                        }
                    });
                }
            });
        }
        , fnSendToKakaoMessage(){
            const _this = this;

            if ($("#alarm_phone_number").val() == '' || $("#alarm_phone_number").val().length > 11 || $("#alarm_phone_number").val().length < 10) {
                alert('알림 받으실 전화번호를 정확히 입력해 주세요.');
                $("#alarm_phone_number").focus();
                return;
            }else{
                let phoneNumber;
                if ($("#alarm_phone_number").val().length > 10) {
                    phoneNumber = $("#alarm_phone_number").val().substring(0,3)+ "-" +$("#alarm_phone_number").val().substring(3,7)+ "-" +$("#alarm_phone_number").val().substring(7,11);
                } else {
                    phoneNumber = $("#alarm_phone_number").val().substring(0,3)+ "-" +$("#alarm_phone_number").val().substring(3,6)+ "-" +$("#alarm_phone_number").val().substring(6,10);
                }

                let request_date = this.kakao_request_date;
                request_date = request_date.getFullYear() + "-" + (request_date.getMonth() + 1) + "-" + request_date.getDate() + " " + request_date.getHours() + ":" + request_date.getMinutes() + ":" + request_date.getSeconds();
                //console.log("request_date", request_date);

                let kakao_api_data = {
                    "evt_code" : this.evt_code
                    , "schedule_idx" : this.schedule_idx + "" + this.kakao_mikki_idx
                    , "usercell" : phoneNumber
                };
                call_api("POST", "/timedeal/timedeal-kakao-joined", kakao_api_data, function (data){
                    if(!data){
                        alert("이미 알림톡 서비스를 신청 하셨습니다.");
                    }else{
                        const kakao_button = {
                            "name" : _this.kakao_info.katalkLinkButtonName
                            , "type" : "WL"
                            , "url_mobile" : _this.kakao_info.katalkLinkUrl
                        };
                        const btnJson = {"button":[kakao_button]};

                        let join_request = {
                            "evt_code" : _this.evt_code
                            , "usercell" : phoneNumber
                            , "request_date" : request_date.toString()
                            , "fullText" : _this.kakao_info.katalkContent.replaceAll("\r\n", "\n")
                            , "failText" : "[텐바이텐] 신청하신 텐텐 래플 이벤트 알림입니다."
                            , "btnJson" : JSON.stringify(btnJson)
                        };
                        console.log("join_request", join_request);

                        call_api("POST", "/timedeal/timedeal-kakao-join", join_request, function (data){
                            if(data > 0){
                                alert("신청이 완료되었습니다.");
                                _this.clear_phone_number();

                                $('.popup').hide();
                                $('.dim').hide();
                            }else{
                                alert("신청 실패. 오류발생");
                            }
                        });
                    }
                });
            }
        }
        , check_only_number(event){
            event.target.value = event.target.value.replace(/[^0-9.]/g, '');
        }
        ,  clear_phone_number(){
            $("input[name=phone]").each(function(index, item){
                $(item).val("");
            });
        }
        , get_raffle_time_info(){
            const start_date = new Date(
                this.now_mikki.startDate.substr(0, 4)
                , this.now_mikki.startDate.substr(5, 2) - 1
                , this.now_mikki.startDate.substr(8, 2)
                , this.now_mikki.startDate.substr(11, 2)
                , this.now_mikki.startDate.substr(14, 2)
                , this.now_mikki.startDate.substr(17, 2)
            );
            const end_date = new Date(
                this.now_mikki.endDate.substr(0, 4)
                , this.now_mikki.endDate.substr(5, 2) - 1
                , this.now_mikki.endDate.substr(8, 2)
                , this.now_mikki.endDate.substr(11, 2)
                , this.now_mikki.endDate.substr(14, 2)
                , this.now_mikki.endDate.substr(17, 2)
            );

            let month = this.make_two_digits(start_date.getMonth() + 1);
            let day = this.make_two_digits(start_date.getDate());
            const time = this.make_two_digits(start_date.getHours()) + ":" + this.make_two_digits(start_date.getMinutes()) + "~" + this.make_two_digits(end_date.getHours()) + ":" + this.make_two_digits(end_date.getMinutes());

            this.raffle_time_info.subscript_period = month + "." + day + " " + time;

            let i;
            for(i = 0; i < 2; i++){
                let before = start_date.getDate();
                start_date.setDate(start_date.getDate() + 1);
                if(before > start_date.getDate()){
                    start_date.setMonth(start_date.getMonth() + 1);
                    month = this.make_two_digits(start_date.getMonth());
                }
                day = this.make_two_digits(start_date.getDate());

                switch (i){
                    case 0 : this.raffle_time_info.notice_date = month + "." + day; break;
                    case 1 : this.raffle_time_info.buyable_date = month + "." + day; break;
                }
            }
        }
        , make_two_digits(item){
            return item < 10 ? "0" + item : item;
        }
        , check_my_win(){
            if(this.isUserLoginOK == "False"){
                if(confirm("당첨 확인은 로그인이 필요합니다.")){
                    location.href='/login/loginpage.asp?backpath=/event/eventmain.asp?eventid=' + this.evt_code;
                }
            }

            if(this.my_win){
                this.show_popup('my_win');
            }else{
                alert("당첨내역이 없습니다.");
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
        now_mikki(data){
            let end_time_point = data.endDate;
            let now = new Date();

            if(data.end_flag == 'N'){
                end_time_point = data.startDate;
            }

            countDownTimer(end_time_point.substr(0, 4)
                , end_time_point.substr(5, 2)
                , end_time_point.substr(8, 2)
                , end_time_point.substr(11, 2)
                , end_time_point.substr(14, 2)
                , end_time_point.substr(17, 2)
                , now
            );

            this.get_raffle_time_info();

            let start_date = new Date(data.startDate.substr(0, 4)
                , data.startDate.substr(5, 2) - 1
                , data.startDate.substr(8, 2)
                , data.startDate.substr(11, 2)
                , data.startDate.substr(14, 2)
                , data.startDate.substr(17, 2)
            );

            if(now.getDate() == start_date.getDate()){
                this.is_today_start = true;
            }
        }
    }
});