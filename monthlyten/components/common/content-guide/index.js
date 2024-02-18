Vue.component('content-guide', {
    template: `
        <section class="content-guide-wrap">
            <div class="guide-limit" >
                <li class="guide-limit__members" >회원전용 이벤트 진행중</li>
                <li class="guide-limit__time" >{{calculateDate}}일 후 종료</li>
            </div>
            <div class="guide-main" >
                <div class="guide-benefit" >
                    <li class="benefit__receive-emph" >
                        지금 받을 수 있는 <p><span class="benefit__receive-orange">한정할인</span> 혜택<p>
                    </li>
                    <ul class="benefit__info" >
                        <li class="benefit__info--coupon" >할인 쿠폰 <span class="coupon-num">2</span> 개</li>
                        <li class="benefit__info--plus" > + </li>
                        <li class="benefit__info--discount" >즉시할인 <span class="coupon-num">1</span> 개</li>
                    </ul>
                </div>
                <div class="guide-desc" >
                    <li class="guide-desc__title" >2월</li>
                    <li class="guide-desc__sub" >준비의 달</li>
                    <li class="guide-desc__login" >로그인 후 이용 가능합니다</li>
                    <button type="button" class="guide-desc__button " @click="moveLoginPageHandler" >로그인</button>
                </div>
                <div class="main__intro">
                    <intro />
                </div>
            </div>
        </section>
    `,
    computed: {
        calculateDate: () => {
            const endDay = 2023 - 02 - 16
            let limitTime = currentDate - endDay
            return limitTime
        },
    },
    methods: {
        moveLoginPageHandler() {
            location.href = `/login/loginpage.asp?backpath=/monthlyten/2023/february/index.asp`
        },
    },
})
