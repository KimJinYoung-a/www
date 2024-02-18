/**기획전/이벤트 */
Vue.component("coupon-modal", {
    template: `
        <div class="coupon-modal" :class="{'is-has-coupon' : hasCoupon}">
            <div class="coupon-modal__close">
                <button type="button" @click="closeCouponModal" />
            </div>
            <div class="coupon-modal__container">
                <div class="coupon-modal__desc">{{desc}}</div>
                <img :src="img" />
                <div v-if="!(userAgreeCheck || hasCoupon) && februaryLoginCheck === 'True'" class="coupon-modal__check-wrap">
                    <div class="coupon-modal__check-box">
                        <input type="checkBox" id="check"  @change="checkHandler" :checked="agreeCheck" />
                        <label class=" is-coupon-active" for="check" >스마트알림 수신 동의 및 쿠폰팩 발급받기 </label>
                    </div>
                    <span class="coupon-modal__check--more" @click="openNoticeModal">{{noticeText}}</span>
                </div>
                <div v-if="(userAgreeCheck || hasCoupon)" class="coupon-modal__check--notice--more"  @click="openNoticeModal">
                    쿠폰/할인 유의사항 보기
                </div>
                <div v-if="couponPrecautions" class="precaution ">
                    <!-- TODO : 스크롤 하단 도달 시 precaution--dim 클래스 삭제 -->
                    <div class="precaution__inner precaution--dim">
                        <h2 class="precaution__title">쿠폰 유의사항</h2>
                        <ul class="precaution__list--base">
                            <li>해당 쿠폰은 스마트 수신동의를 진행한 고객에게 ID당 1회 발급됩니다.</li>
                            <li>발급 받으신 쿠폰은 23.02.15 까지 사용 가능하며, 미 사용 시 소멸됩니다.</li>
                        </ul>
                        <h2 class="precaution__title">즉시할인 유의사항</h2>
                        <ul class="precaution__list--nember">
                            <li>
                                1) 기간 내 1인당 (카카오페이 서비스 가입 기준) 1회 할인 적용
                                <ul class="precaution__list--base">
                                    <li>1회 결제기준 총 결제금액(쿠폰 사용 등 추가 금액 적용 가)에 할인 적용</li>
                                    <li>결제 전체 취소 후 재 결제 시 할인 적용 가능</li>
                                    <li>결제 부분 취소 후 재 결제 시 할인 적용 불가능</li>
                                </ul>
                            </li>
                            <li>
                                2) 해당 이벤트는 선착순으로 진행되며, 예산 소진 시 조기 종료될 수 있습니다.
                            </li>
                            <li>
                                3) 본 할인은 모바일에서만 적용 받을 수 있습니다. 
                                (PC는 카카오페이 결제 불가)
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="coupon-download" :class="{'is-agree' : (agreeCheck || userAgreeCheck || februaryLoginCheck !== 'True') ,'is-has' : hasCoupon}">
                    <button type="button" @click="couponDownload" >{{buttonText}}</button>
                </div>
            </div>
        </div>
    `,
    data() {
        return {
            isViewNoticeModal: false,
            agreeCheck: false,
            userAgreeCheck: false,
            couponPrecautions: false,
            noticeText: "자세히",
            desc: "",
            img: "",
            buttonText: "",
      };
    },
    created() {
        this.userAgreeCheck = this.$store[0].getters.signInUser.agreeCheck;
        this.userHasCouponCheck(this.$store[0].getters.hasCoupon);
    },
    watch: {
        async hasCoupon(value) {
            this.userHasCouponCheck(value);
        },
    },
    computed: {
        userName() {
            return this.$store[0].getters.signInUser.userName;
        },
        hasCoupon() {
            return this.$store[0].getters.hasCoupon;
        },
    },
    methods: {
        checkHandler() {
            this.agreeCheck = !this.agreeCheck;
        },
        openNoticeModal() {
            this.couponPrecautions = !this.couponPrecautions;
            if (this.couponPrecautions) {
                this.noticeText = "닫기 ";
            }
        },
        async couponDownload() {
            let amplitudeData = {};
			if(februaryLoginCheck !== "True"){
				return location.href = `/login/loginpage.asp?backpath=/monthlyten/2023/february/index.asp`;
			}
            if ((this.agreeCheck || this.userAgreeCheck) && !this.hasCoupon) {
                if (februaryLoginCheck === "True") {
                    this.$store[0].dispatch('DOWNLOAD_COUPON');
                } else {
                    alert("로그인이 필요한 서비스 입니다. 로그인 페이지로 이동합니다.");
                    this.moveLoginPage();
                }
            } else if (this.hasCoupon) {
                alert(
                  "쿠폰은 마이텐바이텐에서 확인 가능하며 주문/결제 시 사용하실 수 있습니다."
                );
            }
        },
        moveLoginPage() {
            location.href = `/login/loginpage.asp?backpath=/monthlyten/2023/february/index.asp`;
        },
        closeCouponModal() {
            this.$emit("closeCouponModal");
        },
        userHasCouponCheck(value) {
            if (value) {
                this.desc = `지금 ${this.userName}님이 받을 수 있는 한정할인 `;
                this.img =
                    "//webimage.10x10.co.kr/fixevent/event/2023/monthly/feburary/m/benefit_discount.png?v=1.2";
                this.buttonText = "쿠폰발급 완료";
            } else {
                this.desc = "한정할인 쿠폰 발급받기";
                this.img =
                    "//webimage.10x10.co.kr/fixevent/event/2023/monthly/feburary/m/get_coupon_modal.png?v=1.2";
				if(februaryLoginCheck === "True"){
					this.buttonText = "쿠폰팩 발급 받기";
				} else{
					this.buttonText = "로그인하고 쿠폰 받기";
				}

            }
        },
    },
});
