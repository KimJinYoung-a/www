Vue.component('app-benefit',{
	template : `
        <section id="tab05" class="section05">
            <div class="in_wrap">
                <div class="inner">
                    <h2><span>혹시 내가 당첨자?​</span>APP에서만 만나는​<br>특별한 이벤트</h2>
                    <div class="app_wrap">
                        <div v-if="showAppBanner1"><a href="javascript:void(0);" @click="goEventPage(1)"><img src="//webimage.10x10.co.kr/fixevent/event/2022/ten_sale12/app_time.png" alt=""></a></div>
                        <div v-if="showAppBanner2"><a href="javascript:void(0);" @click="goEventPage(2)"><img src="//webimage.10x10.co.kr/fixevent/event/2022/ten_sale12/app_coupon.png" alt=""></a></div>
                        <div v-if="showAppBanner3"><a href="javascript:void(0);" @click="goEventPage(3)"><img src="//webimage.10x10.co.kr/fixevent/event/2022/ten_sale12/app_kit.png" alt=""></a></div>
                    </div>
                    <div class="qr_wrap">
                        <img src="//webimage.10x10.co.kr/fixevent/event/2022/ten_sale12/qr.png" alt="">
                    </div>
                </div>
            </div>
        </section>
	`
    , created() {
        this.moveEventID1 = "";
        this.moveEventID2 = "";
        this.moveEventID3 = "";
        this.openBannerCount = 0;
        this.$nextTick(function() {
            this.is_login_ok = isUserLoginOK;
            if(!this.is_login_ok){
                this.userid = '고객';
            }else{
                this.userid = userid;
            }
        });
    }
    , data() {
        return {
            itemList: [],
            is_login_ok : false,
        }
    }
    , updated() {

    }
    , mounted() {
        const _this = this;
        _this.$nextTick(function() {
            $("#appbenefitcount").html(this.openBannerCount);
        })
        
    }
    , computed : {
        showAppBanner1() {
            this.moveEventID1 = "121460";
            this.openBannerCount++;
            return true;
        },
        showAppBanner2() {
            if (this.showAppBanner2Day1 || this.showAppBanner2Day2 || this.showAppBanner2Day3) {
                this.moveEventID2 = "121336";
                this.openBannerCount++;
                return true;
            } else {
                return false;
            }
        },
        showAppBanner2Day1() {
            let now = sysdt;
            let startDay = new Date(2022, 11, 4, 0, 0, 0).getTime();
            let endDay = new Date(2022, 11, 9, 23, 59, 59).getTime();
            
            if (now >= startDay && now <= endDay) {
                return true;
            } else {
                return false;
            }
        },
        showAppBanner2Day2() {
            let now = sysdt;
            let startDay = new Date(2022, 11, 12, 0, 0, 0).getTime();
            let endDay = new Date(2022, 11, 16, 23, 59, 59).getTime();

            if (now >= startDay && now <= endDay) {
                return true;
            } else {
                return false;
            }
        },
        showAppBanner2Day3() {
            let now = sysdt;
            let startDay = new Date(2022, 11, 19, 0, 0, 0).getTime();
            let endDay = new Date(2022, 11, 19, 23, 59, 59).getTime();

            if (now >= startDay && now <= endDay) {
                return true;
            } else {
                return false;
            }
        },
        showAppBanner3() {
            if (this.showAppBanner3Day1) {
                this.moveEventID3 = "121340";
                this.openBannerCount++;
                return true;
            } else {
                return false;
            }
        },
        showAppBanner3Day1() {
            let now = sysdt;
            let startDay = new Date(2022, 11, 4, 0, 0, 0).getTime();
            let endDay = new Date(2022, 11, 14, 23, 59, 59).getTime();
            
            if (now >= startDay && now <= endDay) {
                return true;
            } else {
                return false;
            }
        },
    },
    methods : {
        goEventPage(eventOrder) {
            if(eventOrder==1){
                code = this.moveEventID1
                fnAmplitudeEventAction('click_tentensale_timesale', '', '');
            }else if(eventOrder==2){
                code = this.moveEventID2
                fnAmplitudeEventAction('click_tentensale_timecoupon', '', '');
            }else if(eventOrder==3){
                code = this.moveEventID3
                fnAmplitudeEventAction('click_tentensale_themakit', '', '');
            }
            if(code=="121458" || code=="121461" || code=="121464" || code=="121467"){
                code = "121460";
            }else if(code=="121336"){
                code = "121337";
            }else if(code=="121340"){
                code = "121339";
            }
            location.href = "/event/eventmain.asp?eventid=" + code;
        },
    }
})