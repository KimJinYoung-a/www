const app = new Vue({
    el: '#app',
    template: `
       <div class="evt116957">
            <div class="topic">
                <div class="conts">
                    <h2><img src="//webimage.10x10.co.kr/fixevent/event/2021/116957/tit01.png?v=2" alt="봄을 맞이하는 당신을 위해 텐바이텐이 준비한 big sale"></h2>
                    <div class="tit"><img src="//webimage.10x10.co.kr/fixevent/event/2021/116957/tit02.png?v=2.1" alt="2월의 가장 큰 세일 ~50%"></div>
                        <!-- <div class="tag"><img src="//webimage.10x10.co.kr/fixevent/event/2021/116957/tag.png?v=2" alt="봄맞이 SALE"></div> -->
                        <!-- 2022-02-24 추가 -->
                        <div class="ch-day">
                            <!-- 마지막날 노출 이미지 -->
                            <template v-if="currentDate == 20220227">
                                <img src="//webimage.10x10.co.kr/fixevent/event/2021/116957/img_lastday.png?v=2" alt="오늘이 마지막"> 
                            </template>
                            <template v-if="currentDate < 20220227">
                                <img src="//webimage.10x10.co.kr/fixevent/event/2021/116957/img_day.png" alt="세일 종료">
                                <span class="count">D{{currentDate - 20220227}}</span>
                            </template>                        <!-- // -->
                        </div>
                        
                    </div>
            </div>
            <div class="tab-start"></div>
            <!-- tab menu -->
            <div class="tab-list">
                <div class="tab1">
                    <a href="#tab01" class="first_on">혜택</a>
                </div>
                <div class="tab2">
                    <a href="#tab02"><span>브랜드</span></a>
                </div>
                <div class="tab3">
                    <a href="#mapGroup395355"><span>SALE</span></a>
                </div>
            </div>
            <!-- 혜택 -->
            <div id="tab01" class="benefit-area">
                <div class="bg-01">
                    <div class="conts">
                        <div class="section">
                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/116957/img_benefit01.jpg?v=2.1" alt="세일 쿠폰팩">
                            <button type="button" class="btn-cupon" v-if="!isCouponDownload" @click="couponPackDownload">쿠폰 한번에 다운받기</button>
                            <!-- 다운 완료 버튼 -->
                            <button type="button" class="btn-cupon disabled" v-if="isCouponDownload">쿠폰 받기 완료</button> 
                        </div>
                        <div class="section">
                            <a href="/event/eventmain.asp?eventid=116870" class="link" v-if="currentDate <= 20220217">
                                <img src="//webimage.10x10.co.kr/fixevent/event/2021/116957/img_benefit02.jpg?v=2.1" alt="토스 결제하면 4,000원 할인">
                            </a>
                            <a href="/event/eventmain.asp?eventid=117210" class="link" v-if="currentDate >= 20220218">
                                <img src="//webimage.10x10.co.kr/fixevent/event/2021/116957/img_benefit02-04.jpg" alt="토스 결제하면 2,000원 할인">
                            </a>
                            <!-- 노출기간 2/16 ~ 2/17 -->
                            <a href="/event/eventmain.asp?eventid=116996" class="link" v-if="currentDate >= 20220216 && currentDate <= 20220217">
                                <img src="//webimage.10x10.co.kr/fixevent/event/2021/116957/img_benefit02-02.jpg?v=2.1" alt="선착순으로 2,000p 증정">
                            </a>
                        </div>
                    </div>
                </div>
                <div class="bg-02">
                    <div class="conts">
                        <div class="section pick">
                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/116957/img_benefit03.jpg?v=3.1" alt="오늘의 랜덤 혜택">
                            <button type="button" class="btn-pick txt-hidden" @click="randomCouponDownload">뽑기</button>
                            <div class="item01"><img src="//webimage.10x10.co.kr/fixevent/event/2021/116957/img_item01.png?v=2" alt="10,000원"></div>
                            <div class="item02"><img src="//webimage.10x10.co.kr/fixevent/event/2021/116957/img_item02.png?v=2" alt="1,000p"></div>
                            <div class="item03"><img src="//webimage.10x10.co.kr/fixevent/event/2021/116957/img_item03.png?v=2" alt="100p"></div>
                            <div class="item04"><img src="//webimage.10x10.co.kr/fixevent/event/2021/116957/img_item04.png?v=2" alt="coupon"></div>
                        </div>                    
                        <div class="section" v-if="currentDate <= 20220224">
                            <!-- 오픈 전 -->
                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/116957/img_benefit04.jpg?v=2" alt="미션 혜택" v-if="currentDate < 20220221"> 
                            <!-- 오픈 후 -->
                            <div class="mission-benefit" v-if="currentDate >= 20220221 && currentDate <= 20220224">
                                <img src="//webimage.10x10.co.kr/fixevent/event/2021/116957/img_benefit04-02.jpg?v=2" alt="미션 혜택">
                                <button type="button" class="btn-point" @click="missionMileage(loginMileageEventCode)" v-if="!loginMileageDisabled">받 기</button>
                                <button type="button" class="btn-point disabled" v-if="loginMileageDisabled">{{loginMileageDisabledMsg}}</button>
                                <button type="button" class="btn-point wish" @click="missionMileage(wishMileageEventCode)" v-if="!wishMileageDisabled">받 기</button>
                                <button type="button" class="btn-point wish disabled" v-if="wishMileageDisabled">{{wishMileageDisabledMsg}}</button>
                                <button type="button" class="btn-pop txt-hidden" @click="showPopup()">팝업 보기</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- brand -->
            <div id="tab02" class="brand-area">
                <div class="b-list">
                    <ul>
                        <li><a href="/street/street_brand_sub06.asp?makerid=apbasic"></a></li>
                        <li><a href="/street/street_brand_sub06.asp?makerid=decoview"></a></li>
                        <li><a href="/street/street_brand_sub06.asp?makerid=mido0547"></a></li>
                        <li><a href="/street/street_brand_sub06.asp?makerid=borasee21"></a></li>
                        <li><a href="/street/street_brand_sub06.asp?makerid=moshi1010"></a></li>
                        <li><a href="/street/street_brand_sub06.asp?makerid=geuldam"></a></li>
                        <li><a href="/street/street_brand_sub06.asp?makerid=7321"></a></li>
                        <li><a href="/street/street_brand_sub06.asp?makerid=oa"></a></li>
                        <li><a href="/street/street_brand_sub06.asp?makerid=Playmobil"></a></li>
                        <li><a href="/street/street_brand_sub06.asp?makerid=MPNAVI"></a></li>
                        <li><a href="/street/street_brand_sub06.asp?makerid=trendmecca"></a></li>
                        <li><a href="/street/street_brand_sub06.asp?makerid=pis935310"></a></li>
                        <li><a href="/street/street_brand_sub06.asp?makerid=ithinkso"></a></li>
                        <li><a href="/street/street_brand_sub06.asp?makerid=fennec01"></a></li>
                        <li><a href="/street/street_brand_sub06.asp?makerid=ETUDEHOUSE"></a></li>
                    </ul>
                </div>
            </div>
                            <!-- SALE -->
                            <!-- <div id="tab03" class="sale-area">
                                
                            </div> -->
            <div class="tab-end"></div>
            <!-- 팝업 -->
            <div class="dim" v-show="isPopup"></div>
            <div class="pop" v-show="isPopup">
                <img src="//webimage.10x10.co.kr/fixevent/event/2021/116957/pop.jpg" alt="상품 하나만 눌러도 1,000p 드려요">
                <button type="button" class="btn-close txt-hidden" @click="showPopup()">닫기</button>
                <!-- 베스트 아이템 리스트 페이지로 이동 -->
                <a href="/award/awardlist.asp" class="link-best txt-hidden">베스트 상품 보기</a>
            </div>
       </div>
    `,
    data: function () {
        return {
            currentDate: isDevelop ? 20220227 : this.getToday(),
            isLoginOk : isUserLoginOK,
            isDevelop : isDevelop,
            isCalling : true,
            isLoginMileagePayment : false,
            isWishMileagePayment : false,
            isRandomCouponDown : false,
            isCouponDownload : false,
            isPopup : false,
            mileageLimit : true
        }
    },
    created() {
        if(this.isLoginOk) {
            // this.mileageLimitCheck();
            this.couponDownloadCheck();
            this.mileageGiveCheck(this.loginMileageEventCode);
            this.mileageGiveCheck(this.wishMileageEventCode);
        }
        this.isCalling = false;
    },
    computed : {
        eventCode() { // 이벤트 코드
            return this.isDevelop ? 109479 : 116957;
        },
        device() {
            return 'W';
        },
        downloadCoupons() {
            return this.isDevelop
                ? '25279,25280,25281'
                : '167995,167996,167997,167998,167999,168000,168001,168002';
        },
        loginMileageEventCode() {
            return this.isDevelop ? 109483 : 116962;
        },
        wishMileageEventCode() {
            return this.isDevelop ? 109484 : 116963;
        },
        loginMileageDisabled() {
            return this.isLoginMileagePayment || this.mileageLimit;
        },
        wishMileageDisabled() {
            return this.isWishMileagePayment || this.mileageLimit;
        },
        loginMileageDisabledMsg() {
            return this.isLoginMileagePayment ? '발급 완료' : '선착순 종료'
        },
        wishMileageDisabledMsg() {
            return this.isWishMileagePayment ? '발급 완료' : '선착순 종료'
        }
    },
    methods : {
        showPopup() {
            this.isPopup = !this.isPopup;
        },
        /**
         * 쿠폰 다운로드
         */
        couponPackDownload() {
            if(this.isLoginOk) {
                this.couponDownloadAjax();
            } else {
                this.callLoginPage();
            }
        },
        /**
         * 쿠폰 다운로드 Ajax
         */
        couponDownloadAjax() {
            if(this.isCalling) return false;
            this.isCalling = true;

            const _this = this;

            $.ajax({
                type: 'POST',
                url: '/shoppingtoday/act_couponshop_process.asp',
                data: `idx=${this.downloadCoupons}&stype=prd,prd,prd,prd,prd,prd,prd,prd`,
                cache: false,
                success: function(message) {
                    if(typeof(message)=='object') {
                        if(message.response=='Ok') {
                            _this.isCouponDownload = true;
                            alert('쿠폰 다운이 완료되었습니다. 즐거운 쇼핑 되세요!');
                        } else {
                            alert(message.message);
                        }
                    } else {
                        alert('처리중 오류가 발생했습니다.');
                    }
                },
                error: function(err) {
                    console.log(err.responseText);
                },
                complete: function() {
                    _this.isCalling = false;
                }
            });
        },
        /**
         * 미션 마일리지 발급
         *
         * @param mileageKey
         * @returns {boolean}
         */
        missionMileage(eventCode) {
            if(this.isCalling) return false;
            this.isCalling = true;

            const _this = this;
            let url = `/event/temp/${eventCode}/mileage/1/device/${this.device}`;
            $.ajaxSettings.traditional = true;
            let data = { eventCodes : [this.loginMileageEventCode,this.wishMileageEventCode]}
            call_apiV2('POST', url, data,
                    data => {
                        this.isCalling = false;
                        _this.validateMileageGive(data,'1');
                        _this.setMileageGiveStatus(eventCode, true);
                        alert('마일리지 1000P가 지급되었습니다. 2월24일까지 사용하세요!');
                    },
                    e => {
                        _this.isCalling = false;
                        try {
                            const error = JSON.parse(e.responseText);
                            switch(error.code) {
                                case -10: case -11: _this.callLoginPage(); return;
                                case -600: alert('처리과정 중 오류가 발생했습니다.\n코드:001'); return;
                                case -602: alert('이벤트가 종료되었습니다'); return;
                                case -609: alert('이미 지급되었습니다.\nID당 1회만 받을 수 있습니다'); return;
                                case -611: _this.showPopup(); return;
                                case -617: alert('선착순 지급이 마감되었습니다.'); return;
                                default: alert('처리과정 중 오류가 발생했습니다.\n코드:003'); return;
                            }
                        } catch(e) {
                            console.log(e);
                            alert('처리과정 중 오류가 발생했습니다.\n코드:002');
                        }
                    }
            );
        },
        /**
         * 마일리지 유효성 검사
         *
         * @param data
         * @param mileageKey
         */
        validateMileageGive(data, mileageKey) {
            const send_data = {

                'mileage_log_id' : data.mileage_log_id,
                'mileage_key' : mileageKey,
                'round' : data.round,
                'device' : 'A'
            };
            call_api('POST', '/event/mileage/validate', send_data);
        },
        /**
         * 랜덤 쿠폰 다운로드
         */
        randomCouponDownload() {
            if(this.isLoginOk) {
                this.randomCouponDownloadAjax();
            } else {
                this.callLoginPage();
            }
        },
        /**
         * 랜덤 쿠폰 다운로드 Ajax
         * @returns {boolean}
         */
        randomCouponDownloadAjax() {
            if(this.isCalling) return false;
            this.isCalling = true;

            const _this = this;
            let url = `/event/temp/bigsale/random/${this.eventCode}/${this.device}`;
            call_apiV2('POST', url, '',
                data => {
                    alert(data.couponName+' 당첨! (2/27까지 사용 가능)\n내일도 참여해보세요!');
                    _this.isCalling = false;
                },
                e => {
                    _this.isCalling = false;
                    try {
                        const error = JSON.parse(e.responseText);
                        switch(error.code) {
                            case -10: case -11: _this.callLoginPage(); return;
                            case -600: alert('처리과정 중 오류가 발생했습니다.\n코드:001'); return;
                            case -602: alert('기간이 종료되었거나 유효하지 않은 쿠폰입니다.'); return;
                            case -603: alert('오늘은 이미 참여 완료!\n내일 또 참여해보세요.'); return;
                            case -609: alert('이미 지급되었습니다.\nID당 1회만 받을 수 있습니다'); return;
                            case -617: alert('선착순 지급이 마감되었습니다.'); return;
                            default: alert('처리과정 중 오류가 발생했습니다.\n코드:003' + error.code); return;
                        }
                    } catch(e) {
                        console.log(e);
                        alert('처리과정 중 오류가 발생했습니다.\n코드:002');
                    }
                }
            );
        },
        /**
         * 로그인 페이지 이동
         */
        callLoginPage() {
            let url = '/login/loginpage.asp';
            let param = '?backpath=' + location.pathname + location.search.replace('&','^^') +'^^coupon_down=Y';
            location.href = url + param;
        },
        /**
         * 쿠폰 다운로드 여부 체크 AJAX
         */
        couponDownloadCheck() {
            const _this = this;
            let url = `/event/temp/bigsale/coupon?coupons=${this.downloadCoupons}`;
            call_apiV2('GET', url, '',
                data => {
                    _this.isCouponDownload = data.download;
                    if(!data.download) {
                        let query_param = new URLSearchParams(window.location.search);
                        let couponDown = query_param.get("coupon_down");
                        if(couponDown == 'Y') {
                            _this.couponPackDownload();
                        }
                    }
                }
            );
        },
        /**
         * 마일리지 선착순 마감 여부
         */
        mileageLimitCheck() {
            const _this = this;
            let url = `/event/temp/bigsale/mileage/limit?eventCodes=${this.loginMileageEventCode},${this.wishMileageEventCode}`;
            call_apiV2('GET', url, '',
                data => {
                    _this.mileageLimit = data.limit;
                }
            );
        },
        /**
         * 마일리지 지급 여부 체크 AJAX
         *
         * @param data
         * @param type
         */
        mileageGiveCheck(eventCode) {
            const _this = this;
            let url = `/event/temp/bigsale/${eventCode}/mileage`;
            call_apiV2('GET', url, '',
                data => {
                    _this.setMileageGiveStatus(eventCode, data.giveMileage);
                }
            );
        },
        /**
         * 마일리지 지급 여부 상태 세팅
         *
         * @param eventCode
         * @param status
         */
        setMileageGiveStatus(eventCode, status) {
            switch(eventCode) {
                case this.loginMileageEventCode: this.isLoginMileagePayment = status; return;
                case this.wishMileageEventCode: this.isWishMileagePayment = status; return;
                default: return;
            }
        },
        /**
         * 오늘 날짜 조회
         * @returns {string}
         */
        getToday() {
            let date = new Date();
            let year = date.getFullYear();
            let month = ("0" + (1 + date.getMonth())).slice(-2);
            let day = ("0" + date.getDate()).slice(-2);
            return year + month + day;
        }

    }
});