Vue.component('benefit-info', {
    template : `
        <section id="tab02" class="tab02">
            <div class="sec_benefit">
                <h2 class="sec_title"><p class="user_name">{{this.username}}</p>님을 위한 혜택</h2>
                <div class="bene_list">
                    <li class="benefit on">월간텐텐&nbsp;<span>쿠폰팩 지급</span></li>
                    <li class="benefit">1,399개의 상품&nbsp;<span>단독 ~70% 할인</span></li>
                    <li class="benefit">카카오페이&nbsp;<span>2,000원 즉시 할인!</span></li>
                    <li class="benefit">새해 맞이&nbsp;<span>혜택 풍성한 이벤트!</span></li>
                </div>
            </div>
            <div class="sec_coupon">
                <h2 class="sec_title"><p>월간텐텐 쿠폰팩</p></h2>
                <div class="coupon_list">
                    <div class="coupon_img">
                        <img src="//webimage.10x10.co.kr/fixevent/event/2022/monthten/2301/coupon01.png" alt="">
                        <img src="//webimage.10x10.co.kr/fixevent/event/2022/monthten/2301/coupon02.png" alt="">
                    </div>
                    <p class="coupon_info">쿠폰 사용 기간 : 1.6 - 1.16</p>
                    <button class="btn_coupon" @click="couponDownloadCheck">쿠폰팩 다운받기</button>
                    <p class="coupon_info02">*스마트 알림 수신 동의 시 발급이 가능합니다.</p>
                </div>
                <div class="coupon_list02">
                    <a href="javascript:void(0);" @click="goKakaoEvent(121883)"><img src="//webimage.10x10.co.kr/fixevent/event/2022/monthten/2301/benefit01.png" alt=""></a>
                </div>
            </div>
        </section>
    `
    , created() {
        const _this = this;
        _this.isUserLoginOK = isUserLoginOK;
        this.username = userName;
        $(function(){
            // 혜택
	        var i=0;
	        setInterval(function(){
	        	i++;
	        	if(i>3){i=0;}
                $('.sec_benefit .benefit').removeClass('on')
	        	$('.sec_benefit .benefit').eq(i).addClass('on')
	        },1000);

            // 팝업 닫기
            $('.popup .btn_close').click(function(){
                $('.monthlyten .dim').hide();
                $('.monthlyten .pop01').hide();
                $('.monthlyten .pop02').hide();
                return false;
            });
        });
    }
    , mounted() {

    }
    , updated() {

    }
    , computed : {

    },
    methods : {
        async couponDownloadCheck() {
            const _this = this;
            fnAmplitudeEventAction('click_monthlyten_coupon', '', '');
            if (_this.isUserLoginOK) {
                let checkSmartAlarm = await _this.check_smart_alarm();
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
        couponDownload() {
            const _this = this;
            let apiData = {
                //bonusCoupons: "4041,4042"
                bonusCoupons: "2389,2390"
            }
            const success = function(data) {
                if (data === 0) {
                    //alert("쿠폰이 발급되었습니다. 11월 16일까지 사용하세요!");
                    $('.monthlyten .dim').show();
                    $('.monthlyten .pop02').show();
                    fnAmplitudeEventAction('click_monthlyten_coupon_popup_view', 'num', 'Y');
                    
                } else if (data === 1) {
                    alert("쿠폰 지급 시 문제가 발생했습니다.");
                } else if (data === 2) {
                    alert("발급받을 쿠폰이 없습니다.");
                } else {
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
        showCouponPopup() {
            fnAmplitudeEventAction('click_monthlyten_coupon_popup_view', 'num', 'N');
            $('.monthlyten .dim').show();
            $('.monthlyten .pop01').show();
        },
        couponPopupClose() {
            $('.monthlyten .dim').hide();
            $('.monthlyten .pop01').hide();
        },
        // 스마트 알람 조회
        go_smart_alarm() {
            call_api("PUT", "/user/smart-alarm", {}, function (data) {
                return data;
            })
        },
        check_smart_alarm() {
            const _this = this;
            return new Promise(function(resolve, reject) {
                call_api("GET", "/user/my-sns-receive-state", {}, function (data) {
                    resolve(data);
                })
            })
        },
        moveLoginPage() {
            location.href="/login/loginpage.asp?vType=G";
        },
        goKakaoEvent(eventid){
            fnAmplitudeEventAction('click_monthlyten_kakao', '', '');
            location.href = "/event/eventmain.asp?eventid=" + eventid;
        },
    }
});